---
title: The Last Straw..
author: simonm
type: post
date: 2005-03-26T00:08:00+00:00
excerpt: 26 March, 2005, 01:08 am
url: /the-last-straw/
dsq_thread_id:
  - 445604829
  - 445604829
categories:
  - 'Linux &amp; Laptops'

---
My main laptop died the other day, I&#8217;ve had enough. It didn&#8217;t die hardware wise, a single file in the Windows XP Pro install got damaged & that was it. The machine was dodo like. After some checks with the Recovery Console and various F8 options (like don&#8217;t reboot on a crash so that I can see the error!) I discovered that the software hive from the registry was damaged, there were a couple of MSDN/TechNet notes on how to recover from this, including using the Recovery console to remove the existing hives & replace them with some backups from the original install, you can see more [here][1].

I&#8217;d been getting increasingly frustrated with the laptop, it&#8217;s no slouch, a Fujitsu-Siemens S6120, 1.6Ghz Centrino, 1024Mb, 40Gb disk, but it took forever to resume from a hibernate. If you hibernated it whilst docked & resumed un-docked, it would crash. Firefox seemd to get more & more sluggish.

I know not all of these problems are Microsofts, but it&#8217;s urged me to try something different on the laptop, I&#8217;m a Network & Systems Specialist by day, I work in mixed environments, I look after alot of Sun/Solaris, Intel/Windows & Intel/Linux kit, my previous laptop (actually, the one I&#8217;m writing this on, another Fujitsu-Siemns, a B2130 this time) ran Debian/Woody for a long time, with alot of neat features working, like the touchscreen, bluetooth, gprs, masqmail, mutt & isync, jpilot, file syncing with unison over ssh, wireless with waproamd.

When work gave me the S6120, I thought I&#8217;d run it out of the box for a while to see how we got along, initially things worked well, I got PuTTY installed for remote access to \*nix boxes, I got VMWare installed for a couple of \*nix & Windows VM&#8217;s for playing & breaking things. I disovered some promsing software for keeping my Palm, Palm Desktop & my phone all in sync (MobileMaster, it works,mostly)and some other neat bluetooth/phone tools like Float&#8217;s FMA. When stuck on site in an office with no external internet access, I even managed to share the dialup line with collegues over bluetooth.

But resuming got slower, it would crash on resume every now & then.

It was time to see of Debian/Linux could give me a decent working environment for my current needs. I work for a medium sized high end software services company, I&#8217;m there IT manager, I also do &#8220;consultancy&#8221; for them, where then send me out on site & expect everything in the office to run as if I&#8217;m still there while I do the same for some other company 🙂

I need the following:

  * Multiple network access methods (wired, wireless, gprs) all to work smoothly 
      * Offline Email 
          * Offline Network Shares 
              * VPN Access (currently we use SSH for crude but effective VPN access, IPSec is on it&#8217;s way, as is Citrix SG if I ever get a chance!) 
                  * Proper wordprocessing & spreadsheet tools, this pretty much means Word & Excel, as we&#8217;re stuck in the &#8220;that&#8217;s what everybody else is using&#8221; rut. 
                      * Encryptable disk space 
                          * Cross platform encryptable USB stick support. </ul> 
                            Easy huh?
                            
                            It&#8217;s bed time, the rest of the story will have to wait until tomorrow&#8230;

 [1]: http://support.microsoft.com/kb/307545