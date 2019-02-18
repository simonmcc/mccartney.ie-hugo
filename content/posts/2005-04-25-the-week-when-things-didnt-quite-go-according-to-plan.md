---
title: The week when things didn’t quite go according to plan..
author: simonm
type: post
date: 2005-04-25T02:47:11+00:00
draft: true
url: /?p=15
categories:
  - Uncategorized

---
The company I work for recently decided to move offices, where we were wasn&#8217;t really suitable (it was all ex-lab space, with noisey air-con, carpet stuck on anti-static tiles) and very cramped.

I was asked to lead the &#8220;technical move&#8221;, i.e. in my role as IT manager, ensure that all the IT Infrastructure got moved with minimal downtime. Unfortunaly I&#8217;ve also been working offsite on a very demanding project, leaving the office in the capable hand of my cohort in the IT team.

Due to the tight timescales &#038; my distraction on projects elsewhere, I misunderstood the lead time involved in getting our internet connection (a 2Mb leased line from Energis, with 2x /29 networks) moved, it turned out to be 30 working days, not 30 days. After I had confirmed that there was no shifting of their committed date (in our old building, they were on a tail of their own, in the new building, they didn&#8217;t have any fibre near by &#038; and it didn&#8217;t make sense for them to dig, so they are going to provide us with our connection over a BT tail, meaning that they were at the mercy of BT for the install), we set about concocting an interim solution, they are as follows, in order of preference:

  1. Install a DSL circuit with static IP&#8217;s and get Energis to perform DNAT on traffic destined for our old energis range to our temporary DSL range.
  
    _Energis couldn&#8217;t do this as there core network doesn&#8217;t have NAT facilities in it, and they weren&#8217;t prepared to alter there entire network just for us 🙂_
  2. Install a DSL circuit and modify our DNS to use the new IP range during the interim period.

Once we had the DSL in, we still needed to get the traffic into our existing infrastructure, given that this was a temporary change, I didn&#8217;t fancy change all our routers, DMZ machines &#038; external network machines for a period of weeks.

I reckoned that a linux firewall (Debian/Woody with Shorewall) with one interface in the BT DSL network, the other in what was our energis-outside network, with this interface temporarily replacing the energis Cisco 2600 router. This meant that none of internal servers needed changing, the shorewall box would do NAT (SNAT &#038; DNAT) to translate stuff in and out. We&#8217;d have to publish DNS changes (or seen as we host our own DNS on an now unreachable IP addresses, use a friendly DNS hoster, like [www.rimuhosting.com][1], which whom I have a VPS account for personal use. All we&#8217;d have to do then is update the NS servers, which is easy done through our DR, [www.ukreg.com][2]

We had planned to move on Friday 22nd April 2005, so I had placed the order with BT for the ISDN30 &#038; 2xAnalogue lines well in advance, and requested that the install happen on Monday 18th April 2005. A week after I placed the order I phoned up to see if we could arrange for a temporary number to be placed on the ISDN30 to allow our PBX guys ([www.telappliant.com][3]) to do some testing, at this point I discovered that our order had been lost &#038; that our account manager was on leave.

We were supposed to have analogues lines with DSL installed on the Friday, this is known as a simulttanues provide, but this didn&#8217;t happen, the analogue lines got installed, but the DSL provision failed. The BT engineer left site without informing me of this. So we only found out at around 6pm when tried to hook a DSL router up to the line, no sync.

 [1]: http://www.rimuhosting.com
 [2]: http://www.ukreg.com
 [3]: http://www.telappliant.com