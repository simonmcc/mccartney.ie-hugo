---
title: Solaris getting more Windows like?!
author: simonm
type: post
date: 2005-06-07T10:27:57+00:00
url: /solaris-getting-more-windows-like/
categories:
  - '*nix'

---
I have a tricky problem on a Solaris/Veritas/Dell-EMC cluster I&#8217;m working on. The Solaris machines need to be rebooted **twice** to be able to use a LUN presented from the SAN. Now I&#8217;m not sure where the problem lies, I think the first reboot is for Solaris to see the devices, once you can see the devices you can use EMC&#8217;s PowerPath tools (powermt) to determine the managed device for the LUN (this is managed in that powerpath presents you with a virtual device, usually something like /dev/rdsk/emcpowerXX, access to this device is used to load balance access across the physical paths to the SAN, and handle when a path my become unavailable).

Once the virtual device is there, you then need to put a VTOC on the device so that Veritas Volume Manager can see the device, it can&#8217;t use it until you reboot tho&#8217;, which is a major grumble. VEA shows the disk as &#8220;Not Setup&#8221;, it won&#8217;t allow you to Initialize the disk until the box has been rebooted.
  
After the reboot, VEA will show the disk as &#8220;Not Initialized&#8221;, you can now use the disk (i.e. Add it to a Disk Group etc)

The SAN is all Dell/EMC based, which means it runs on Windows, can you imagine the flack I&#8217;m getting from the Windows boys over having to reboot twice to use a LUN!

<!--more-->


  
A little more detail on the setup:

  * Solaris 9 on SPARC, (V440&#8217;s & V880)
  
    (HBA cards are Sun badged Qlogic cards)</p> 
      * Veritas Cluster Server 4.0 , VxVM 4.0 
          * Dell/EMC SAN, using Navisphere & PowerPath on Solaris for management. </ul>