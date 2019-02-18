---
title: 'Getting Cisco IOS & Racoon IPSec to play ball..'
author: simonm
type: post
date: 2005-09-15T12:07:18+00:00
url: /getting-cisco-ios-racoon-ipsec-to-play-ball/
categories:
  - Open Source

---
..ok, none of this is hard, but I get stuck in the odd place, mainly the Cisco router throwing this:

ISAKMP (0:1): Checking IPSec proposal 1
  
ISAKMP: transform 1, ESP_3DES
  
ISAKMP: attributes in transform:
  
ISAKMP: SA life type in seconds
  
ISAKMP: SA life duration (basic) of 28800
  
ISAKMP: encaps is 1
  
ISAKMP: authenticator is HMAC-SHA
  
ISAKMP: group is 2
  
validate proposal 0
  
**IPSEC(vaidate\_proposal): transform proposal (prot 3, trans 3, hmac\_alg 2) not supported**
  
ISAKMP (0:1): atts not acceptable. Next payload is 0
  
ISAKMP (0:1): phase 2 SA not acceptable!

This is a Cisco 3640 running IOS:
  
IOS &#8482; 3600 Software (C3640-IK9S-M), Version 12.2(23a)

I added the following to our exitsing IOS config:

<p align="left">
  crypto isakmp key somerandomtext address remote-host-ip no-xauth<br /> crypto ipsec transform-set vault esp-3des esp-sha-hmac
</p>

<div align="left">
</div>

<p align="left">
  crypto map to-vault 10 ipsec-isakmp<br /> set peer remote-host-ip<br /> set transform-set vault<br /> set pfs group2<br /> match address 101
</p>

<div align="left">
</div>

<p align="left">
  interface Ethernet0/0<br /> &#8230;<br /> crypto map to-dublin-vault
</p>

<div align="left">
</div>

<p align="left">
  access-list 101 permit ip host this-host-ip host remote-host-ip log
</p>

The racoon-tool.conf config looks like this:

\# How to control the syslog level
  
global:
  
\# log: notify
  
log: debug

#
  
\# some defaults
  
#
  
peer(%default):
  
verify_identifier: on
  
nat_traversal: off
  
hash_algorithm[0]: sha1
  
authentication\_method[0]: pre\_shared_key
  
encryption_algorithm[0]: 3des

connection(%default):
  
src_ip: 192.168.0.6

#
  
\# IPSec between belfast-core-external &#038; vault
  
peer(213.185.212.122):
  
peers_identifier: address

connection(to-belfast-core):
  
mode: tunnel
  
admin_status: enabled
  
compression: no
  
src_ip: 213.185.212.114
  
dst_ip: 213.185.212.122
  
encryption_algorithm: 3des
  
authentication\_algorithm: hmac\_sha1