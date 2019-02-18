---
title: Using GPRS Easy Connect 3.0.1 with Ubuntu 7.04 (Edgy Eft)
author: simonm
type: post
date: 2007-08-04T21:32:42+00:00
url: /using-gprs-easy-connect-301-with-ubuntu-704-edgy-eft/
categories:
  - '*nix'
  - 'Linux &amp; Laptops'

---
I&#8217;ve been playing around with some cobbled together pppd &#038; chat scripts to get my Novatel Wireless U630 working under Ubuntu, with a Vodafone UK Data SIM (I think most of the problmes come from VF UK&#8217;s DNS Servers being broken in some odd way)

<div>
  One of the many resources for APN settings etc is from the GPRS Easy Connect web site, <a href="http://gprsec.hu">http://gprsec.hu</a>, (other great resource are <a href="http://www.filesaveas.com/gprs.html">filesaveas</a> and <a href="http://home2.btconnect.com/Taniwha/gprs.html">Taniwha</a>). After I got my stuff working by hand, I thought I would have a play with their tool that wraps all there settings together. I hit some problems installing from the source package (the supply rpms, but no .deb files), here&#8217;s how they were resolved:</p> 
  
  <div>
    <blockquote>
      <p>
        wget http://www.gprsec.hu/downloads/GPRS_Easy_Connect_301.tar.bz2<br /> tar xvjf GPRS_Easy_Connect_301.tar.bz2<br /> cd GPRS_Easy_Connect_301<br /> sudo ./INSTALL.sh<br /> ./INSTALL: error while loading shared libraries: libgtk-1.2.so.0: cannot open shared object file: No such file or directory
      </p>
    </blockquote>
  </div>
  
  <p>
    This easy resolved via the libgtk1.2 package:
  </p>
  
  <div>
    <blockquote>
      <p>
        sudo apt-get install libgtk1.2
      </p>
    </blockquote>
  </div>
  
  <p>
    Take #2:
  </p>
  
  <div>
    <blockquote>
      <p>
        sudo ./INSTALL.sh<br /> Gtk2:TrayIcon perl module [Error]
      </p>
    </blockquote>
  </div>
  
  <p>
    Better, but still some problems, this one is easy resolved, using the libgtk2-trayicon-perl package:
  </p>
  
  <div>
    <blockquote>
      <p>
        sudo apt-get install libgtk2-trayicon-perl
      </p>
    </blockquote>
  </div>
  
  <p>
    BTW, it&#8217;s fairly easy to identify these packages required by playing about with apt-cache search, in this case:
  </p>
  
  <div>
    <blockquote>
      <p>
        apt-cache search trayicon | grep perl<br /> libgtk2-trayicon-perl &#8211; Perl interface to fill the system tray
      </p>
    </blockquote>
  </div>
  
  <p>
    After that, the source package was able to complete it&#8217;s installation.
  </p>
  
  <div>
    PS, here are the cobbled together scripts are working for me, YMMV.<br /> <a href="http://www.mccartney.ie/~simonm/vodafone-U630"> /etc/ppp/peers/vodafone-U630</a><br /> <a href="http://www.mccartney.ie/~simonm/vodafone-U630-chat"> /etc/chatscripts/vodafone-U630</a><br /> <a href="http://www.mccartney.ie/~simonm/2override-dns"> /etc/ppp/ip-up.d/2override-dns</a> (prepends the PPP IPCP supplied DNS servers with your own DNS Server of choice)</p> 
    
    <p>
      I just kick this off with a &#8220;pppd debug vodafone-U630&#8221; in a root terminal window.
    </p>
    
    <div>
      PPS The Windows based Novatel tool is able to tell me all sorts of into about signal strength etc, as is the 3rd party tool MWConn, I wonder are there any specs around that would let us get similar info in a non-Windows environment?
    </div>
  </div>
</div>