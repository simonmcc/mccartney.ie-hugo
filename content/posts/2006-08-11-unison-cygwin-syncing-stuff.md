---
title: 'Unison, Cygwin & syncing stuff'
author: simonm
type: post
date: 2006-08-11T19:02:07+00:00
url: /unison-cygwin-syncing-stuff/
categories:
  - '*nix'
  - 'Linux &amp; Laptops'
  - Open Source

---
I have a Linux VPS account which I use for hosting this and some private photo collections [i.e. personal, not porn!] etc, I used to use <a target="_blank" href="http://www.cis.upenn.edu/~bcpierce/unison/">Unison</a> to sync my photo directories between my Linux VPS and my Linux Laptop. I&#8217;m currently running Windows XP on my laptop, so I was looking for a way of syncing stuff with my off site storage again, after some playing around with different versions of Unison, I settled on running unison from withing Cygwin. I have a bash script that fixes the permissions on the remote filesystem and some other stuff using SSH. Getting ssh-agent to work cleanly in a Cygwin environment is tricky, I found the following <a target="_blank" href="http://mah.everybody.org/docs/ssh">tips</a>, and liked this [one][1]. It needed some tweaking to work, probably just the knock on effect of having spaces in my $HOME.

This fragment can be used to setup the ssh-agent so that the rest of the commands in the script that use SSH don&#8217;t prompt for passphrases (including running unison using ssh)
  
[quickcode:noclick]
  
#
  
\# Setup ssh-agent if it&#8217;s not already there
  
\# This is where the ssh-agent environment settings are stored for scripts
  
\# using this fragment
  
SSH_ENV=&#8221;$HOME/.ssh/environment&#8221;
  
function start_agent {
  
echo &#8220;Initialising new SSH agent&#8230;&#8221;
  
/usr/bin/ssh-agent | sed &#8216;s/^echo/#echo/&#8217; > &#8220;${SSH_ENV}&#8221;
  
echo succeeded
  
chmod 600 &#8220;${SSH_ENV}&#8221;
  
. &#8220;${SSH_ENV}&#8221; > /dev/null
  
/usr/bin/ssh-add;
  
}

\# Source SSH settings, if they are there
  
if [ -f &#8220;${SSH_ENV}&#8221; ]; then
  
. &#8220;${SSH_ENV}&#8221; > /dev/null
  
\# If ssh-agent is dead or gone, start from scratch
  
ps -ef | grep ${SSH\_AGENT\_PID} | grep ssh-agent > /dev/null || {
  
start_agent;
  
}
  
else
  
\# start from scratch
  
start_agent;
  
fi
  
[/quickcode]

After this script, I just call ssh a couple of times to tidy up the remote destination, and then call unison using a profile that also uses ssh, slicker than a greased monkey falling of a pole.

 [1]: http://www.cygwin.com/ml/cygwin/2001-06/msg00537.html