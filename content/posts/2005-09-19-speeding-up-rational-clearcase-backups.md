---
title: Speeding up Rational ClearCase backups..
author: simonm
type: post
date: 2005-09-19T07:57:10+00:00
draft: true
url: /?p=44
categories:
  - '*nix'

---
This is some stuff I worked on several years back, which came up recently on a discussion on the sage-ie mailing list, so I thought I&#8217;d post it here, just for the record.

Rational (now owned by IBM) ClearCase is a source configuration management tool, which while very large &#038; complex, is very flexible, with many advanced &#038; complex features. Everything in ClearCase is stored in it&#8217;s own database, the vob&#8217;s. These need to be backed up in a consistent state, this is done by locking the vobs or shutting down ClearCase, as I&#8217;m sure you can imagine, these databases can get very large, and locking or stopping ClearCase to perform backups can have a huge knock on effect on your users, especially if you are part of a large multi site install which continually syncs the databases between the sites. So, if you have some way of taking filesystem snapshots, you can reduce the downtime hugely.