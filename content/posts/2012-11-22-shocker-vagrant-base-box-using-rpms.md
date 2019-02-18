---
title: 'SHOCKER: Vagrant base box using RPMs'
author: simonm
type: post
date: 2012-11-22T19:27:12+00:00
url: /shocker-vagrant-base-box-using-rpms/
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
  - 1
categories:
  - '*nix'
  - Open Source
  - Random Toad

---
I&#8217;ve been using some of the base boxes available from <http://www.vagrantbox.es/> as a starting point for lots of Vagrant VMs recently, but came unstuck when the version of puppet in use on the base box was substantially different from our production environment (2.7 v 2.6.8 in our production environment). (I was working on [alt_gem][1], an alternate package provider for maintaining gems outside the RVM in use by puppet)

At first I thought it would be simple enough to downgrade puppet on one of my Vagrant VMs, but then I discovered that nearly all of the CentOS/Red Hat vagrant boxes install ruby & puppet from tarballs, which is balls frankly, shouldn&#8217;t we be using packages for everything?!  ([Kris Buytaert says so, so it must be true][2])

So instead of ranting, I tweaked an existing [veewee][3] [CentOS template][4] to install puppet & chef from RPMs, for puppet, it uses the official puppetlabs yum repo, for chef it uses the frameos packages. (I&#8217;m a puppet user, so I&#8217;ve only tested the puppet stuff, chef is at least passing the &#8220;veewee validate&#8221; tests).

You can grab the box here: <https://dl.dropbox.com/u/7196/vagrant/CentOS-56-x64-packages-puppet-2.6.10-chef-0.10.6.box>

&nbsp;

To use it in your Vagrant config, make sure this is in your Vagrantfile:

<pre># Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "CentOS-56-64-packages"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://dl.dropbox.com/u/7196/vagrant/CentOS-56-x64-packages-puppet-2.6.10-chef-0.10.6.box"</pre>

&nbsp;

I&#8217;ve sent a [pull request][5] to Patrick to get the new template included in veewee, and a [pull request][6] to Gareth to get the box listed on [www.vagrantbox.es][7].

Now, time to go back to what I was doing originally before I got side tracked 🙂

&nbsp;

&nbsp;

 [1]: https://github.com/simonmcc/puppet-alt_gem
 [2]: http://www.krisbuytaert.be/blog/package-and-what-package
 [3]: https://github.com/jedi4ever/veewee/
 [4]: https://github.com/jedi4ever/veewee/tree/master/templates/CentOS-5.6-x86_64-netboot
 [5]: https://github.com/jedi4ever/veewee/pull/431
 [6]: https://github.com/garethr/vagrantboxes-heroku/pull/67
 [7]: http://www.vagrantbox.es/