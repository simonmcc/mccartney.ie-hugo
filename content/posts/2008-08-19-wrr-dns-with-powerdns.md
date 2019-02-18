---
title: WRR DNS with PowerDNS
author: simonm
type: post
date: 2008-08-19T09:03:59+00:00
url: /wrr-dns-with-powerdns/
categories:
  - '*nix'
  - Bright Ideas
  - Open Source
  - Random Toad
tags:
  - dns
  - load balancing
  - powerdns
  - weighted round robin
  - wrr

---
I had an interesting challenge in work recently, we have 3 data centres running our applications, currently the RR DNS system does what it&#8217;s supposed to, spreads the data round each of the 3 DCs evenly.  This works fine when all of your data centres have a similar capacity.  But ours don&#8217;t.  This causes problem when your load/traffic gets to the point where one of the DCs can&#8217;t cope.  Now, there are many expensive and complicated solutions to this, this how ever isn&#8217;t one of them, it&#8217;s quite simple, has it&#8217;s weaknesses, but as you&#8217;ll see it&#8217;s also quite elegant.

## Background

Our infrastructure already relies heavily on MySQL replication & PowerDNS, both of those are installed on all our public machines, indeed, we have a large MySQL replication loop with many spokes off the loop, ensuring that all of the MySQL data is available everywhere.  PowerDNS is used for both internal & external DNS services, all backed off the MySQL backend on the aforementioned MySQL replication loop.  This is important to us, as this solution required no new software, just some configuration file tweaks & same database table alterations.

## Overview

Each record is assigned a weight. This weight will influence the likelihood of that record being returned in a DNS request with multiple A records. A weight of 0 will mean that the record will always be in the set of A records returned. A weight of 100 will mean that the record will never be returned (well, almost never).

## Method

  1. Add an extra column to the PowerDNS records table, called weight, this is an integer.
  2. Create a view on the records table that adds random values to each record every time it is retrieved.
  3. Alter the query used to retrieve data from the records table to use the view and filter on the weight and random data to decide if the record should be returned.

This is achieved by using the view to create a random number between 0 and 100 (via rand()*100).

> create view recordsr AS select content,ttl,prio,type,domain_id,name, rand()*100 as rv, weight from records; 

We use this SQL to add the column:

> alter table records add column \`weight\` int(11) default 0 after change_date; 

The random data is then compared against the record weight to decide if the record should be returned in the request. This is done using the following line in the pdns.conf file:

> gmysql-any-query=select content,ttl,prio,type,domain_id,name from recordsr where name=&#8217;%s&#8217; and weight < rv order by rv 

For small sample sets (100), the results are quite poor & the method proves to be inaccurate, but for larger sets, 10,000 and above, the accuracy improved greatly.  I&#8217;ve written some scripts to perform some analysis against the database server & against the DNS server itself.  To test the DNS server, I set cache-ttl=1 and no-shuffle=on in pdns.conf.  With the cache-ttl=1, I waited 1.1 seconds between DNS queries.

Here&#8217;s some results, [sample-pdns.pl][1] was used to gather this data:

> Sample Size = 1,000
> 
> \#### WRR DNS Results
  
> dc1: 462, 46.2% (sample size), 23.38% (total RR)
  
> dc2: 514, 51.4% (sample size), 26.01% (total RR)
  
> dc3: 1000, 100% (sample size), 50.60% (total RR)
  
> total_hits: 1976, 197.6% (sample size), 100% (total RR)
> 
> Desired priorities were:
  
> dc1 2/100, 80%
  
> dc2 5/100, 50%
  
> dc3 0/100, 100% 

Sample Size = 10,000

> \#### WRR DNS Results
  
> dc1: 10000, 100% (sample size), 50.57% (total RR)
  
> dc2: 5821, 58.21% (sample size), 29.43% (total RR)
  
> dc3: 3952, 39.52% (sample size), 19.98% (total RR)
> 
> pos-1-dc1: 5869, 58.69% (sample size), 29.68% (total RR)
  
> pos-1-dc2: 2509, 25.09% (sample size), 12.68% (total RR)
  
> pos-1-dc3: 1622, 16.22% (sample size), 8.20% (total RR)
  
> pos-2-dc1: 3332, 33.32% (sample size), 16.85% (total RR)
  
> pos-2-dc2: 2548, 25.48% (sample size), 12.88% (total RR)
  
> pos-2-dc3: 1540, 15.4% (sample size), 7.78% (total RR)
  
> pos-3-dc1: 799, 7.99% (sample size), 4.04% (total RR)
  
> pos-3-dc3: 790, 7.9% (sample size), 3.99% (total RR)
  
> pos-3-dc2: 764, 7.64% (sample size), 3.86% (total RR)
> 
> total_hits: 19773, 197.73% (sample size), 100% (total RR)
> 
> \#### Desired priorities were:
  
> dc3 60/100, 40%
  
> dc2 40/100, 60%
  
> dc1 0/100, 100% 

As you can see, with the larger sample size, the weighting becomes much more transparent.

dc1 appeared in the returned records 100% of the time, as expected, dc2 appeared 58.21% (desired percentage was 60%) and dc3 appeared 39.52% (desired percentage was 40%).

What is possibly more interesting & relevant is the number of times a particular dc appears in the top slot (pos-1) of the returned results, this is the A record most likely to be used by the client.  dc1 appears in the top slot 58.69% of the time, with dc2 appearing 25.09% and dc3 16.22%.  These results diverge from the desired prioroties quite a bit, but are still in order with the desired distribution.

## Advantages

  1. No new code/binaries to distribute
  2. Reuse existing infrastructure
  3. Easy to roll-back from.

## Disadvantages

  1. Fairly coarse grained controls of load balancing (no feedback loop)
  2. At least 1 site should have a weight of 0
  3. No gurantee on number of records that will be returned in a query (other then records with a weight of 0)
  4. Increased load on the database generating 1 or more random numbers on each query against the view

 [1]: https://gist.github.com/simonmcc/2ef0ccf92d7844a8931e41ab9c6940ae