---
title: ssh-vulnkey
author: simonm
type: post
date: 2008-05-23T08:46:38+00:00
url: /ssh-vulnkey/
categories:
  - '*nix'
  - 'Linux &amp; Laptops'
  - Open Source
  - Random Toad

---
There&#8217;s a flaw in ssh-vulnkey, it doesn&#8217;t always show you the name of the file with an offending blacklisted key in it. Here&#8217;s a couple of ways round this:

For a small machine, inspect the files by hand:

> strace ssh-vulnkey -a 2>&1 | grep ^stat64| grep -v NOENT| cut -d&#8221; -f 2| sort | uniq | xargs vi

Or, a little longer, using ssh-vulnkey to find all relevant keys & reprocess them displaying the filename & then the result of the ssh-vulnkey for the individual file:

> strace ssh-vulnkey -a 2>&1 | grep ^stat64| grep -v NOENT| cut -d&#8221; -f 2| sort | uniq | xargs -i bash -c &#8220;echo ; echo {} ; ssh-vulnkey {};&#8221;

This really is a dirty hack, using strace to extract the files ssh-vulnkey and then reprocess them individually, there are a million ways this could be done better, but not on a single bash line 🙂