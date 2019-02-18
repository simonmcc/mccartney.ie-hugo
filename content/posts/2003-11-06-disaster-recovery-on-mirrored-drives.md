---
title: Disaster Recovery on Mirrored drives
author: simonm
type: post
date: 2003-11-06T12:29:33+00:00
url: /disaster-recovery-on-mirrored-drives/
categories:
  - '*nix'

---
Cut&#8217;n&#8217;paste from orginal sunmanagers posting from [here][1], should also be titled &#8220;**Why ufsdump&#8217;s are still a good thing**&#8221;

Date: Thu, 6 Nov 2003 13:29:33 +0000
  
To: sunmanagers@sunmanagers.org

This is just a quick guide covering something that caught me out recently:

Scenario:

Solaris 8

We have a couple of E20R&#8217;s, all with mirrored system partitions (/, /usr,
  
/var, /opt) We run Legato Networker for our main backups, but I still run
  
a ufsdump every couple of nights aswell. The reasoning behind this is that
  
one of the E220&#8217;s is the Networker server, so in the event of a major
  
problem on this machine, we need to get it back before we can use Networker
  
to pull stuff from the backups.

With a tape that has UFS Dumps of your sys partitions, you can be back on
  
the road in a couple of hours (depends on tape speeds 🙂

There are scenarios where mirroring wont protect you, primarily user error,
  
which in this case was a restore be done on the wrong machine, so somebody
  
over wrote everything on the E220 with the contents of a different machine.

The snag with a mirrored setup is that if you boot of a CD or network, you
  
wont beable to see your metadevices, just the raw devices. So when your
  
restore from tape to an underlying device, what does the metaresync do on
  
reboot? I don&#8217;t know, but the solution is to restore to one drive and pull
  
the 2nd drive before rebooting, preventing the metaresync from doing
  
anything! After the recovery, reinsert the 2nd drive and reenable all
  
alices.

Here follows the detailed solution:

Things you should take note of before the disaster occurs!

1) partitions sizes, names &#038; mount points, just incase!
  
2) The order in which partitions are written to tape
  
3) The correct options for ufsrestore! (we use a block size of 512, which
  
always catches me out..)

Here are the steps I followed:

1) Write protect your ufssdump tape.

2) Pull your second drive (i.e. the one that your machine DOESN&#8217;T boot
  
from)

3) Boot from a Solaris CD or network jumpstart kit in single user mode
  
&#8220;boot cdrom -s&#8221; or &#8220;boot net -s&#8221;

5) wipe your corrupted partitions:
  
newfs /dev/dsk/c0t0d0s0
  
newfs etc

5) mount your root partition to /mnt and mount /opt as /mnt/opt etc to
  
fill out the tree

6) This next step assumes that your partitions are written to tape in the
  
following order, /, /usr, /var, /opt

cd /mnt
  
ufsrestore rvfb /dev/rmt/0cn 512
  
cd /mnt/usr
  
ufsrestore rvfb /dev/rmt/0cn 512
  
cd /mnt/var
  
ufsrestore rvfb /dev/rmt/0cn 512
  
cd /mnt/opt
  
ufsrestore rvfb /dev/rmt/0cn 512

7) Rewrite the boot block on your disk:

installboot /usr/platform/&#8217;/usr/sbin/uname -i&#8217;/lib/fs/ufs/bootblk
  
/dev/rdsk/c0t0d0s0

8) Unmount everything.
  
cd /
  
umount /mnt/opt
  
umount /mnt/usr
  
umount /mnt/var
  
umount /mnt

9) Go down to the OBP
  
shutdown -i0 -g0 -y

10) Boot as normal (assuming you pulled the right drive, you may have to
  
boot off the, alternative if you didn&#8217;t, you can do this by setting
  
device aliases etc, detailed elsewhere)

11) Everything look ok? Good, now reinsert the 2nd disk and re-enable the
  
slices:

devfsadm
  
metareplace -e d10 c0t1d0s0
  
etc.

12) Be happy that your system is back 🙂

Please feel free to add comments &#038; embelish this as you see fit. Hopefully
  
it will be of some help to somebody in there hour of need.

Regards,

Simon.

 [1]: http://unix.derkeiler.com/Mailing-Lists/SunManagers/2003-11/0109.html