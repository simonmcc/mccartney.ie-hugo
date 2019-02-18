---
title: Hows my tablespaces?
author: simonm
type: post
date: 2006-03-27T06:54:33+00:00
url: /hows-my-tablespaces/
categories:
  - Oracle

---
select a.TABLESPACE_NAME,
	  
a.BYTES bytes_used,
	  
b.BYTES bytes_free,
	  
b.largest,
	  
round(((a.BYTES-b.BYTES)/a.BYTES)*100,2) percent_used
  
from
	  
(
		  
select TABLESPACE_NAME,
			  
sum(BYTES) BYTES
		  
from dba\_data\_files
		  
group by TABLESPACE_NAME
	  
)
	  
a,
	  
(
		  
select TABLESPACE_NAME,
			  
sum(BYTES) BYTES ,
			  
max(BYTES) largest
		  
from dba\_free\_space
		  
group by TABLESPACE_NAME
	  
)
	  
b
  
where a.TABLESPACE\_NAME=b.TABLESPACE\_NAME
  
order by ((a.BYTES-b.BYTES)/a.BYTES) desc;

Produces something like this:

<table>
  <tr>
    <td>
      TABLESPACE_NAME
    </td>
    
    <td>
      BYTES_USED
    </td>
    
    <td>
      BYTES_FREE
    </td>
    
    <td>
      LARGEST
    </td>
    
    <td>
      PERCENT_USED
    </td>
  </tr>
  
  <tr>
    <td>
      &#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;
    </td>
    
    <td>
      &#8212;&#8212;&#8212;-
    </td>
    
    <td>
      &#8212;&#8212;&#8212;-
    </td>
    
    <td>
      &#8212;&#8212;&#8212;-
    </td>
    
    <td>
      &#8212;&#8212;&#8212;&#8212;
    </td>
  </tr>
  
  <tr>
    <td>
      SYSTEM
    </td>
    
    <td>
      241172480
    </td>
    
    <td>
      10289152
    </td>
    
    <td>
      9371648
    </td>
    
    <td>
      95.73
    </td>
  </tr>
  
  <tr>
    <td>
      SYSAUX
    </td>
    
    <td>
      157286400
    </td>
    
    <td>
      11206656
    </td>
    
    <td>
      7274496
    </td>
    
    <td>
      92.88
    </td>
  </tr>
  
  <tr>
    <td>
      USERS
    </td>
    
    <td>
      220200960
    </td>
    
    <td>
      22609920
    </td>
    
    <td>
      17367040
    </td>
    
    <td>
      89.73
    </td>
  </tr>
  
  <tr>
    <td>
      MTD_DATA
    </td>
    
    <td>
      104857600
    </td>
    
    <td>
      25624576
    </td>
    
    <td>
      19398656
    </td>
    
    <td>
      75.56
    </td>
  </tr>
  
  <tr>
    <td>
      UNDO
    </td>
    
    <td>
      10485760
    </td>
    
    <td>
      6750208
    </td>
    
    <td>
      3145728
    </td>
    
    <td>
      35.63
    </td>
  </tr>
  
  <tr>
    <td>
      SQL>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
  </tr>
</table>

from <http://vsbabu.org/oracle/sect03.html>