---
title: Faking Production – database access
author: simonm
type: post
date: 2011-12-20T12:52:44+00:00
url: /faking-production-database-access/
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
  - 1
categories:
  - '*nix'
  - Bright Ideas
  - 'Linux &amp; Laptops'
  - Open Source
  - Random Toad
  - Work

---
One of our services has been around for a while, a realy long time.  It used to get developed in production, there is an awful lot of work involved in making the app self-contained, to where it could be brought up in a VM and run without access to production or some kinds of fake supporting environment.  There&#8217;s lots of stuff hard coded in the app (like database server names/ip etc), and indeed, and there&#8217;s a lot of code designed to handle inaccessible database servers in some kind of graceful manor.

We&#8217;ve been taking bite sized chunks of all of this over the last few years, we&#8217;re on the home straight.

One of the handy tricks we used to get this application to be better self-contained was avoid changing all of the database access layer (hint, there isn&#8217;t one) and just use iptables to redirect requests to production database servers to either local empty database schema on the VM, or shared database servers with realistic amounts of data.

We manage our database pools (master-dbs.example.com, slave-dbs.example.com, other-dataset.example.com etc) using DNS (PowerDNS with MySQL back end), in production, if you make a DNS request for master-dbs.example.com, you will get 3+ IPs back, one of which will be in your datacentre, the others will be other datacentres, the app has logic for selecting the local DB first, and using an offsite DB if there is some kind of connection issue.  We also mark databases as offline by prepending the relevant record in MySQL with OUTOF, so that a request for master-dbs.example.com will return only 2 IPs, and a DNS request for OUTOFmaster-dbs.example.com will return any DB servers marked out of service.

Why am I telling you all of this?  Well, it&#8217;s just not very straight forward for us to update a single config file and have the entire app start using a different database server. _Fear not, our production databases aren&#8217;t actually accessible from the dev environments._

But what we can do is easily identify the IP:PORT combinations that an application server will try and connect to.  And once we know that it&#8217;s pretty trivial to generate a set of iptables statements that will quietly divert that traffic elsewhere.

Here&#8217;s a little ruby that generates some iptables statements to divert access to remote, production, databases to local ports, where you can either use ssh port-forwarding to forward on to a shared set of development databases, or to several local empty-schema MySQL instances:

> require &#8220;rubygems&#8221;
  
> require &#8216;socket&#8217;
> 
> \# map FQDNs to local ports
  
> fqdn_port = Hash.new
  
> fqdn_port[&#8220;master-dbs.example.com&#8221;] = 3311
  
> fqdn_port[&#8220;slave-dbs.example.com&#8221;] = 3312
  
> fqdn_port[&#8220;other-dataset.example.com&#8221;] = 3314
> 
> fqdn_port.each do |fqdn, port|
    
> puts &#8220;#&#8221;
    
> puts &#8220;# #{fqdn}&#8221;
    
> \# addressess for this FQDN
    
> fqdn_addr = Array.new
> 
> \# get the addresses for the FQDN
    
> addr = TCPSocket.gethostbyname(fqdn)
    
> addr[3, addr.length].each { |ip| fqdn_addr << ip }
> 
> addr = TCPSocket.gethostbyname(&#8216;OUTOF&#8217; + fqdn)
    
> addr[3, addr.length].each { |ip| fqdn_addr << ip }
> 
> fqdn_addr.each do |ip|
      
> puts &#8220;iptables -t nat -A OUTPUT -p tcp -d #{ip} &#8211;dport 3306 -j DNAT &#8211;to 127.0.0.1:#{fqdn_port[fqdn]}&#8221;
    
> end
  
> end

And yes, this only generates the statements, just pipe the output into bash if you want the commands actually run.  Want to see what it&#8217;s going to do?  Just run it.  Simples.