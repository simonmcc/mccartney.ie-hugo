---
title: Why would you do that?
author: simonm
type: post
date: 2008-01-05T00:49:43+00:00
url: /why-would-you-do-that/
categories:
  - 'Linux &amp; Laptops'
  - Random Toad

---
I indulged myself recently and obtained a new MacBook, which I&#8217;ve spent the last few days loading up with the usual suspects (Firefox) as well as getting acquainted with some new tools (Mail.app).

I use Foxmarks to keep my bookmarks in order, with a neat toolbar of my regular sites, I noticed that in FF on OSX, all my toolbar favicon images were missing (several of my bookmarks on the Personal Toolbar have no text, so just the Icon shows up on my other machines (XP & Ubuntu/Linux))

A bit of research and playing found this: <http://blog.rbenson.info/tech/firefox-hide-bookmark-toolbar-icons.html>

Now this describes exactly how to recreate my problem (Hide the Icons!) I wanted to undo this (guessing that this was just a daft default in the OSX FF build), a bit more poking & research suggested that I wanted to make my userChrome.css to look like this:

`/* Hide bookmark icons in the Personal Toolbar */<br />
toolbarbutton.bookmark-item > .toolbarbutton-icon {<br />
display: inline !important; }`

And he presto, things are back to normal, I have a neat toolbar with icons for the sites.

But why would you set the default to hide them?