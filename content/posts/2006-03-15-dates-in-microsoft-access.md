---
title: Dates in Microsoft Access
author: simonm
type: post
date: 2006-03-15T22:04:48+00:00
url: /dates-in-microsoft-access/
categories:
  - Microsoft

---
Every now &#038; then I&#8217;m forced to deal with databases in Access, the worst case of this is when the database started life in something else, &#8216;cos that when Dates usually get really screwy.

I recently had one with dates stored as 3 seperate fileds, I know I should have transformed the data, but I didn&#8217;t, so I came up witha few queries that tried to munge the data into something usable, my first attempt was this:

PurchaseDate: LTrim(RTrim(day))+&#8217;/&#8217;+LTrim(RTrim(month))+&#8217;/&#8217;+LTrim(RTrim(year))

But then I found a better way:

PDate: DateFromDMY([day],[month],[year])

Where DateFromDMY is a VB function, something akin to:

Public Function DateFromDMY(a\_Day As Integer, a\_Month As Integer, a_Year As Integer) As Date

If (a_Day = 0) Then
  
a_Day = 1
  
End If

If (a_Month = 0) Then
  
a_Month = 1
  
End If

If (a_Month > 12) Then
  
a_Month = 12
  
End If

DateFromDMY = CDate(CStr(a\_Day) + &#8220;/&#8221; + CStr(a\_Month) + &#8220;/&#8221; + CStr(a_Year))

End Function

Now that&#8217;s a crude function, but you get the idea, you can fix up data easily.

Thank you [Martin Green][1] for his pointers [here][2].

 [1]: http://www.fontstuff.com/index.html
 [2]: http://www.fontstuff.com/vba/vbatut04.htm