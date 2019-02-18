---
title: The New Toolbox
author: simonm
type: post
date: 2010-06-15T15:05:42+00:00
url: /the-new-toolbox/
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

---
In days gone by, any computer guy worth his salt had a collection of boot floppies, 5.25&#8243; & 3.5&#8243;, containing a mix of MS-DOS, DR-DOS, Toms Root Boot & Norton tools. These days passed and the next set of essentials was boot cd-r, containing BartPE, RIPLinux, Knoppix etc. People quickly switched to carrying these tools USB sticks, smaller, easier to change, great when the dodgy PC you were trying to breathe life into supported USB booting.

I think there&#8217;s a better way, based on the last 3 days of hell spent setting up what should have been identical touchscreen machines (no cd, slow USB interfaces)

Your new toolkit is a cheap laptop, with a big hard disk, running the following:

  1. Your favourite Linux distro (I&#8217;ve used [Ubuntu][1] for this laptop)
  2. tftpd, [dhcpd][2] & [dnsmasq][3] setup for PXE booting other machines from this laptop (FOG uses dhcpd for all it&#8217;s automatic DHCP magic, use dnsmasq for simple local DNS, required for Unattended)
  3. [FOG Cloning System][4]
  4. [Unattended][5] Windows 2000/XP/2003 Network Install System
  5. [CloneZilla][6] PXE Image (for good measure)
  6. [RIPLinux][7] PXE Image

Why?  USB booting stills seems troublesome, installing Windows from flash seems very slow.  Nearly everything supports PXE these days, if it has a built in ethernet port, it&#8217;s pretty much guaranteed to support PXE booting.  There is nothing like the feeling of being able to image a machine into FOG over a 1Gb crossover cable in a matter of minutes.  Got everything working? image it and walk away, safe in the knowledge that if somebody comes along and breaks things, you can image it back in minutes, instead of having to do another clean install and build all your updates & software back on top.

There&#8217;s a little bit of plain in getting all of separate packages to run from the one /tftpboot/pxelinux.cfg/default, but it&#8217;s just a matter of careful copy & paste from the canned configs.

 [1]: http://www.ubuntu.com/
 [2]: http://www.isc.org/software/dhcp
 [3]: http://www.thekelleys.org.uk/dnsmasq/doc.html
 [4]: http://www.fogproject.org/
 [5]: http://unattended.sourceforge.net/
 [6]: http://clonezilla.org/
 [7]: http://en.wikipedia.org/wiki/Recovery_Is_Possible