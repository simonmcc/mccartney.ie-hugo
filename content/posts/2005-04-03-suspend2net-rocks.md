---
title: suspend2.net rocks!
author: simonm
type: post
date: 2005-04-03T10:57:58+00:00
url: /suspend2net-rocks/
categories:
  - 'Linux &amp; Laptops'

---
My last major requirement was decent hibernate & resume, the standard suspend to disk in 2.6.8/10 didn&#8217;t cut it, so I started on patching the kernel with stuff from [suspend2.net][1], but it wouldn&#8217;t patch a debian&#8217;ised kernel source, or even any kernel source I tried to pull from kernel.org, then I remembered a post on debian-laptop about a some debian&#8217;ised suspend2 patches, some hunting through my inbox and I found it:

> Hello, world.
> 
> I have just finished the first public (yet EXPERIMENTAL!) version of
  
> the Debian software suspend 2 patch (www.suspend2.net). The patch
  
> integrates with Debian&#8217;s kernel-package and modifies the
  
> kernel-image in such a way as to automatically modify any initial
  
> ramdisk and reinitialise swap partitions to preven data loss.
> 
> The patch currently supports Debian kernels 2.6.8 and 2.6.10. For
  
> best results, use the latest kernel. I did most of my testing with
  
> 2.6.10 on i386. Patches for 2.4.2[789] and 2.6.11 are also included
  
> but not tested. 2.4.27 does not currently apply to the Debian
  
> kernels, but should be usable with vanilla ones.
> 
> Help in porting the patch to other Debian kernels would be greatly
  
> appreciated. I am especially looking for an elegant way to support
  
> Debian and vanilla kernels from the same source.
> 
> I am not going to upload the patch to unstable yet, but it has been
  
> submitted to the Debian experimental archive. It will go into
  
> unstable when I have received enough positive feedback and no
  
> serious bugs exist.
> 
> At this point, I want to thank Nigel and everyone else who
  
> contributed for the slick patch, which works very nicely. Also
  
> thanks to Nigel for backporting the 2.1 version to the 2.6.8.1
  
> kernel, which is going to be the standard 2.6 kernel for Debian
  
> sarge.
> 
> If you want to give the patch a whirl, you can obtain it from the
  
> following APT repository:
> 
> deb http://debian.madduck.net ~madduck/packages/stage/kernel-patch-suspend2/
    
> deb-src http://debian.madduck.net ~madduck/packages/stage/kernel-patch-suspend2/
> 
> then install it:
> 
> apt-get update
    
> apt-get install kernel-patch-suspend2
> 
> and then compile the kernel:
> 
> tar xjf /usr/src/kernel-source-2.6.10.tar.bz2
    
> cd kernel-source-2.6.10
    
> make-kpkg &#8211;added-patches suspend2 &#8230; binary
> 
> Then, install the kernel-image and reboot.
> 
> Note that I did my testing using an initial ramdisk (basically the
  
> plain Debian kernel with SUSPEND2 enabled). If you can use an
  
> initial ramdisk, pass the &#8211;initrd option to make-kpkg and be done.
  
> Without an initial ramdisk, you have to make sure to pass the right
  
> &#8216;resume2&#8217; value to the kernel via Grub/Lilo, or whichever is your
  
> bootloader. I plan to add a warning about this when I have more
  
> time.
> 
> I suggest also pulling in the hibernate image (kernel images with
  
> this patch will Recommend it). With UseSwsusp2 set to yes in
  
> /etc/hibernate/hibernate.conf, just running &#8216;hibernate&#8217; should
  
> suspend the machine, and it should come back up without any more of
  
> your doing when you start it again.
> 
> Even though I did all testing on my productive machine(s) and lost
  
> no data (knock on wood), it&#8217;s probably best if you try it on
  
> a less-important machine. Nevertheless, you can turn off
  
> $CHECK\_SWAP\_PARTITIONS\_ON\_BOOT in /etc/default/suspend2 to prevent
  
> the swap partition check. Make sure to read
  
> http://suspend2.net/HOWTO-4.html#ss4.4 about this issue.
> 
> Have fun, feedback welcome.
> 
> &#8212; Please do not send copies of list mail to me; I read the list! .&#8221;\`. martin f. krafft : :&#8217; : proud Debian developer, admin, user, and author \`. \`&#8217;\` \`- Debian &#8211; when you have better things to do than fixing a system Invalid/expired PGP subkeys? Use subkeys.pgp.net as keyserver! 

It works a treat!
  
After you&#8217;ve built your patched kerel, grab the hibernate package from suspend2.net:

> wget http://cp.yi.org/apt/hibernate/hibernate\_1.05-1\_all.deb
> 
> dpkg -i hibernate\_1.05-1\_all.deb 

BTW, I rebuild my kernel&#8217;s slightly differently, I don&#8217;t do initrd or anything, so all I did was:

> cd /usr/src/linux
  
> make-kpkg &#8211;added-patches suspend2 &#8211;append-to-version -sm7-suspend2 kernel_image 

I do this because I sm7 indicates that this is the 7th interation of tweaking settings for this laptop, and that the suspend2 patch has been applied, it makes the kernel namesa bit long, but easier to spot what I&#8217;ve done 🙂

Reboot using your new kernel, et voila! You&#8217;re ready to hibernate, get all your usual apps up and running (Thunderbird, Firefox, Word using CrossOver), fire up a shell, su to root and type hibernate, it rocks&#8230;

 [1]: http://www.suspend2.net