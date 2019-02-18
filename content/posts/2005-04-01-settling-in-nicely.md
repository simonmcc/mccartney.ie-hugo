---
title: Settling in nicely…
author: simonm
type: post
date: 2005-04-01T07:45:32+00:00
url: /settling-in-nicely/
categories:
  - Random Toad

---
So I&#8217;ve had Debian Unstable on the laptop for a week or two now and I think I&#8217;ve finished all the config/migrate work. I&#8217;ve got the wireless card working (using ipw2100 & waproamd, I tried wpasupplicant, but I only need WEP and WEP is broken for wpasuplicant & ipw2100&#8217;s), gprs over bluetooth and the the built-in modem (using sl-modem-daemon & sl-modem-source). I haven&#8217;t got suspend working at all, for disk or memory. Applying the suspend2.net patches to straight kernel sources or debian-patched kernel sources seems way to hard, it looks like I&#8217;ll have to have a look at bitkeeper and pull a patched kernel dtraight from the suspend2 guys. Here&#8217;s a quick rundown of my original requirements and how I&#8217;ve met them:

  * Multiple network access methods (wired, wireless, gprs) all to work smoothly
  
      
    _(RealTek RTL8139 support in kernel, ipw2100 support from ipw2100.sourceforge.net, bluez, rfcomm & pppd are all that&#8217;s needed for gprs)_</p> 
      * Offline Email
  
          
        _(Thunderbird&#8217;s clunky offline support will do for now)_</p> 
          * Offline Network Shares
  
              
            _(hmm, not quite there yet on this, probably going ti endup using rsync/drsync/unison to sync directories)_</p> 
              * VPN Access (currently we use SSH for crude but effective VPN access, IPSec is on it&#8217;s way, as is Citrix SG if I ever get a chance!)
  
                  
                _(OpenSSH, need I say more? Need to look at using OpenSWAN with 2.6 IPSec&#8230;)_</p> 
                  * Proper wordprocessing & spreadsheet tools, this pretty much means Word & Excel, as we&#8217;re stuck in the &#8220;that&#8217;s what everybody else is using&#8221; rut.
  
                      
                    _(One of my collegues was using CrossOver Office, I was mightly impressed and looked at using Wine and then CrossOver, which is a whole $40, which is nothing, so I&#8217;m running the CrossOver eval and will get the full product in due course!)_</p> 
                      * Encryptable disk space & Cross platform encryptable USB stick support.
  
                          
                        _(I&#8217;ve been looking at Jetico&#8217;s BestCrypt, I have been using it under XP and was quite impressed, however when I took my encrypted volume from XP & tried to open it under Linux, it complained bitterly)_ </ul> 
                        So, getting there, I need to get suspend of some form working&#8230;