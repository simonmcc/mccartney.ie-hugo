---
title: Making Thunderbird more Mutt like
author: simonm
type: post
date: 2007-10-18T08:18:18+00:00
url: /making-thunderbird-more-mutt-like/
categories:
  - '*nix'
  - Open Source

---
I used to be a big [mutt][1] fan, but with the growing amount of HTML mail I recieve, it became too much of a chore, combined with the fact that IMAP offline support is a _bit_ kludgy (I&#8217;ve used both isync &#038; offlineimap) I abandoned mutt some time ago and move to Thunderbird.

Thunderbird has better offline IMAP support, but it&#8217;s very mouse driven, but there are some handy extensions that can make it easier to use from the keyboard. I&#8217;m using <a target="_blank" href="https://addons.mozilla.org/en-US/thunderbird/addon/1339">GMailUI</a> and [keyconfig][2]. GMailUI gives you j/k support, and single key archive (these are UI features lifted from GMail, but we all know that they came from vi/mutt originally)

I don&#8217;t use Thunderbird&#8217;s spam filters, I have a sendmail/cyrus/spamassassin mail setup, and I keep it trained using folders on the IMAP server, this also means that the rest of my family should get the benefit of my spam training.

A shorter version of this is that I want to press a single key to move a mail to a certain folder, without invoking Thunderbird Junk Mail stuff.

keyconfig to the rescue!

  * Install keyconfig
  * Open the keyconfig menu (Tools, Keyconfig)
  * Click &#8220;Add a new key&#8221;
  * Call it what you like (mine is MoveToJunk)
  * Enter the following code: 
    <pre>MsgMoveMessage('imap://simon@mccartney.ie/INBOX/Junk');</pre>
    
    Where simon@mccartney.ie is the name of the IMAP account I&#8217;m using and Junk is a subfolder of the Inbox (as far as Cyrus is concerned, everything is a subfolder of the Inbox, unlike other IMAP systems).</li> 
    
      * Click OK
      * Assign a key against it (I use Shift-J, which meant I also had to un-map the existing Junk Control keys using keyconfig, look **As Junk** &#038; **As Not Junk** and click reset.
      * Ahhh, keyboard heaven!</ul>

 [1]: http://www.mutt.org/
 [2]: http://kb.mozillazine.org/Keyconfig_extension