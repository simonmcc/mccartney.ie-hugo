---
title: Introducing kitchen-salt, a salt provisioner for test-kitchen
author: simonm
type: post
date: 2014-01-24T01:14:58+00:00
url: /introducing-kitchen-salt-a-salt-provisioner-for-test-kitchen/
thumbnail: wp-content/uploads/2014/01/Salt-KitchenBar-600.jpg
categories:
  - Open Source

---
Over the last week I&#8217;ve been working on kitchen-salt, a SaltStack
provisioner for Test Kitchen, this allows you to perform integration
testing on salt-formula. Test Kitchen will create a VM (through
Vagrant, LXC, OpenStack, ec2 etc), install a version of salt of your
choosing, apply a given set of states & then optionally allow you to
perform some automated validation of the states via the supported
testing frameworks (bats, serverspec etc).

The tests can all be run from your workstation, but we&#8217;ve also just
started plugging this into our CI system, so that changes are gated on a
successful test run, hopefully preventing bad states ever making it into
a branch.

I&#8217;ve started a walkthrough of setting up a working Test Kitchen
environment & adding a test-kitchen support to an existing formula, you
can see it here: <https://github.com/saltstack/kitchen-salt/blob/master/docs/gettingstarted.md>

kitchen-salt supports multiple salt install vectors (apt & bootstrap,
apt allows you to specify a version & repo to pull from) & setting of
pillars & state\_top. Test Kitchen allows you to define suites of tests,
and you can change the pillars, state\_top and installed version of salt
per suite too, so you can test many different scenarios.

You can find the full project here: <https://github.com/saltstack/kitchen-salt>

Looking forward to some feedback & hopefully some PR&#8217;s
I&#8217;m not going to SaltConf, but I will be at [@cfgmgmtcamp](https://twitter.com/cfgmgmtcamp) in Gent in a
few weeks, see you soon!

2019-02-17: kitchen-salt was adopted by [SaltStack](https://www.saltstack.com) and is now under their ownership, links here updated, many thanks to SaltStack for taking care of kitchen-salt for me ;-)
