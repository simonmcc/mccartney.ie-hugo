---
title: History Meme
author: simonm
type: post
date: 2008-04-28T15:01:32+00:00
url: /history-meme/
categories:
  - Random Toad

---
Following on from [Mark][1] and others, this is my VPS, not my Ubuntu desktop, laptop or MacBook&#8230;

`simonm@mccartney:~$ uname -a<br />
Linux mccartney.ie 2.6.16.33-xenU #8 SMP Wed Sep 12 22:06:48 UTC 2007 i686 GNU/Linux<br />
simonm@mccartney:~$ history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head<br />
90 ls<br />
73 cd<br />
48 sudo<br />
34 vi<br />
17 svn<br />
16 grep<br />
13 cat<br />
11 rm<br />
8 cp<br />
7 top<br />
simonm@mccartney:~$`

 [1]: http://diveintomark.org/archives/2008/04/15/history-meme