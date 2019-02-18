---
title: Solaris still rocks!
author: simonm
type: post
date: 2005-06-08T09:53:39+00:00
url: /solaris-still-rocks/
categories:
  - '*nix'

---
One of my favourite features of Solaris 8 and above is DiskSuite, when igb first showed me the beautiful simplicity of metainit, metattach et al, I was simply blown away (having previously only worked with Windows NT4&#8217;s crude mirroring).

Last night was a perfect example, we have a Sun E220 with an A1000 &#038; a couple of D1000&#8217;s hanging off it, I had been playing with some spare disks and managed to get the metadb (metadb keeps track of what metadevice is built from what physical devices) in a bit of a state, if we ignore the fact that I managed to get the metadbs in a mess, the recovery is remarkable smooth, considering that our local Sun support team could only suggest that we wiped everything &#038; restored from tape.

**The problem:**
  
We had a metadevice, d90, that didn&#8217;t display in metastat, but if we did a &#8220;metastat d90&#8221;, it was shown, it was a stripset of 11 disks in one of the D1000&#8217;s. metaclear wouldn&#8217;t remove the md, complaining that it was in use, we had rebooted several times, started up in single user mode etc to ensure that nothing was actually using it. (it wasn&#8217;t being mounted, lsof &#038; fuser showed nothing). We applied that latest Solaris8 patch cluster ( a prerequisite for opening a call with your Sun support provider :-), tried everything again, still no luck.

**The Solution**
  
Keith proved this on a spare Ultra 60, however, we missed one key step, see if you can spot it.
  
\# metadb
  
metadb: headline-22: there are no existing databases
  
\# metastat
  
metastat: headline-22: there are no existing databases

\# metadb -a -f c0t1d0s0

\# metainit d100 2 1 c0t1d0s3 1 c0t1d0s6
  
d100: Concat/Stripe is setup

\# metastat
  
d100: Concat/Stripe
  
Size: 4099440 blocks
  
Stripe 0:
  
Device Start Block Dbase
  
c0t1d0s3 0 No
  
Stripe 1:
  
Device Start Block Dbase
  
c0t1d0s6 0 No

\# newfs /dev/md/rdsk/d100
  
newfs: construct a new file system /dev/md/rdsk/d100: (y/n)? y
  
/dev/md/rdsk/d100: 4099440 sectors in 870 cylinders of 19 tracks, 248 sectors
  
2001.7MB in 44 cyl groups (20 c/g, 46.02MB/g, 11200 i/g)
  
super-block backups (for fsck -F ufs -o b=#) at:
  
32, 94528, 189024, 283520, 378016, 472512, 567008, 661504, 756000, 850496,
  
944992, 1039488, 1133984, 1228480, 1322976, 1417472, 1511968, 1606464,
  
1700960, 1795456, 1889952, 1984448, 2078944, 2173440, 2267936, 2362432,
  
2456928, 2551424, 2645920, 2740416, 2834912, 2929408, 3015712, 3110208,
  
3204704, 3299200, 3393696, 3488192, 3582688, 3677184, 3771680, 3866176,
  
3960672, 4055168,

\# metastat
  
d100: Concat/Stripe
  
Size: 4099440 blocks
  
Stripe 0:
  
Device Start Block Dbase
  
c0t1d0s3 0 No
  
Stripe 1:
  
Device Start Block Dbase
  
c0t1d0s6 0 No

\# fsck /dev/md/rdsk/d100
  
** /dev/md/rdsk/d100
  
** Last Mounted on
  
** Phase 1 &#8211; Check Blocks and Sizes
  
** Phase 2 &#8211; Check Pathnames
  
** Phase 3 &#8211; Check Connectivity
  
** Phase 4 &#8211; Check Reference Counts
  
** Phase 5 &#8211; Check Cyl groups
  
2 files, 9 used, 1987390 free (14 frags, 248422 blocks, 0.0% fragmentation)

\# mkdir /keith
  
\# mount /dev/md/dsk/d100 /keith
  
\# cd /keith
  
\# ls
  
lost+found
  
\# echo &#8220;test new mount&#8221; > test
  
\# cd /etc
  
\# cp * /keith

\# cd /keith
  
\# ls
  
TIMEZONE cfgadm dacf.conf devlink.tab ff fstyp halt lost+found
  
aliases chroot datemsk dgroup.tab fmthard ftpusers hostname.hme0 test
  
asppp.cf clri dcopy driver_aliases format fuser hosts
  
auto\_home coreadm.conf defaultdomain driver\_classes format.dat getty inetd.conf
  
auto_master crash defaultrouter dumpadm.conf fsck group init
  
autopush cron device.tab dumpdates fsdb grpck initpipe
  
\# cd /
  
\# umount /keith
  
\# metadb -d -f c0t1d0s0
  
\# metadb
  
\# metastat
  
d100: Concat/Stripe
  
Size: 4099440 blocks
  
Stripe 0:
  
Device Start Block Dbase
  
c0t1d0s3 0 No
  
Stripe 1:
  
Device Start Block Dbase
  
c0t1d0s6 0 No

\# metadb
  
metadb: headline-22: there are no existing databases

\# metastat
  
metastat: headline-22: there are no existing databases

\# metadb -a -f c0t1d0s0
  
\# metainit d100 2 1 c0t1d0s3 1 c0t1d0s6
  
d100: Concat/Stripe is setup
  
\# mount /dev/md/dsk/d100 /keith
  
\# cd /keith
  
\# ls
  
TIMEZONE cfgadm dacf.conf devlink.tab ff fstyp halt lost+found
  
aliases chroot datemsk dgroup.tab fmthard ftpusers hostname.hme0 test
  
asppp.cf clri dcopy driver_aliases format fuser hosts
  
auto\_home coreadm.conf defaultdomain driver\_classes format.dat getty inetd.conf
  
auto_master crash defaultrouter dumpadm.conf fsck group init
  
autopush cron device.tab dumpdates fsdb grpck initpipe

\# cat test
  
test new mount

Did you spot it? Probably not, I didn&#8217;t give you enough detail about the E220 setup, it&#8217;s fully mirrored, /, /usr,
  
swap, /var, the works. See the problem now? If we delete the metadbs, the kernel loads (OpenBoot PROM knows to use one of the disks that make the root metadevice), but then fails to mount the root filesystem, as
  
described in /etc/system using the rootdev command:
  
*Begin MDD root info (do not edit)
  
rootdev:/pseudo/md@0:0,10,blk_
  
*End MDD root info (do not edit)_

We found this out the hard way, i.e. we rebooted the box, left to boot of disk, the kernel loaded &#038;
  
then failed. So how did we get round this? Simple, un mirror everything,
  
boot up cleanly and then re-mirror everything 🙂

Here&#8217;s how we did it:

  1. Determine which of the physical disks the OBP uses to boot from.
  
    You should really have this logged in your machine log, but we again
  
    did this the hard way:</p> 
      1. Boot from CD (&#8220;boot cdrom -s&#8221; from the OBP)
      2. mkdir /tmp/a
      3. mount /dev/c0t0d0s0 /tmp/a
      4. cd /tmp/a/etc
      5. commentout the rootdev line in system
      6. edit vfstab so that all important partitions are now physical instead of
  
        meta devices.(by important, I mean /, /usr, /var, /opt, swap)

There is a very useful guide here <http://www.unixway.com/vm/disksuite/mirroros.html>