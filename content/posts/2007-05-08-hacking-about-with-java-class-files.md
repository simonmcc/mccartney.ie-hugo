---
title: Hacking about with Java class files
author: simonm
type: post
date: 2007-05-08T10:34:07+00:00
url: /hacking-about-with-java-class-files/
categories:
  - Uncategorized

---
I&#8217;ve recently been involved in migrating some old JBoss web portal applications from one physical location to another, along the way there were some new security hurdles to jump, including moving all URLs from http to https.

One of the components in this service had a hard coded URL to the http address.  We could have fixed this with an Apache rewrite rule, but the security folks would still have been on our backs.  The source code is long lost (AFAIK) and it probably would have taken ages to create a suitable build environment anyways.

What I needed was a class file editor.  [CafeBabe][1] to the rescue! More details [here][2].  This great little tool allowed be to edit the String in the class file, all I needed to do then was rebuild the jar file, stop JBoss, slip it into the filesystem over the old JAR with the bad url in it, restart JBoss &#038; hey presto!

 [1]: http://www.geocities.com/CapeCanaveral/Hall/2334/programs.html
 [2]: http://www.geocities.com/CapeCanaveral/Hall/2334/Programs/cafebabe.html