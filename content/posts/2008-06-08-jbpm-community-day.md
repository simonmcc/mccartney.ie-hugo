---
title: jBPM Community Day
author: simonm
type: post
date: 2008-06-08T09:48:46+00:00
url: /jbpm-community-day/
categories:
  - '*nix'
  - Open Source
tags:
  - bpm
  - community
  - dublin
  - jboss
  - jbpm
  - pvm

---
Friday 6th June 2008 was the first [jBPM Community Day][1], held in the [Guinness Store House][2] in [Dublin][3], this is practically on my doorstep, and as we’ve been looking at jBPM for some pilots recently, I couldn’t not go.

The speakers on the day were [Tom Baeyens][4], [Joram Barrez][5], [Paul Browne][6] and [Koen Aers][7]. <span class="Apple-converted-space"></span>It was great to hear that jBPM is being used in all sort of environments, in some very large projects and most of all the direction of the project from the project leaders. <span class="Apple-converted-space"></span>It was also good to hear about local take up in & around Ireland (there were guests from all over Europe, including some Americans based in Budapest) <span class="Apple-converted-space"></span>

Tom & the rest of the team are taking their collective experience in the BPM and building the [Process Virtual Machine][8], and state engine that can be used to execute processes described in many different languages, starting with jPDL, but already on the horizon are BPEL and Seam PageFlow. <span class="Apple-converted-space"></span>The PVM looks set to be the definitive state machine for process management, with plugin interfaces for persistence, task management etc.

It was a great day, many thanks to all of those who contributed to the smooth running & interesting content, and selection of a great venue!

[It’s only just struck me what a great venue, making a product that’s as consistently good as Guinness requires clearly documented processes, which soon becomes clear when you take the tour of the Store House that describes the process involved in taking the raw ingredients and producing something as fine as a smooth pint of Guinness]

Questions for the jBPM Community/Things I’m going to try and answer over the coming weeks

<ul style="list-style-type: disc">
  <li style="font: 12.0px Helvetica">
    Where’s the absolute beginners guide?<span class="Apple-converted-space"> </span>[or, as<span class="Apple-converted-space"> </span>this is in a community, where can I start one and what needs to be in it? :-)]
  </li>
  <li style="font: 12.0px Helvetica">
    What are the requirements/guidelines on replacing the jbpm-console or integrating functionality into your own app?
  </li>
  <li style="font: 12.0px Helvetica">
    What are the interface points/techniques in PVM for other languages?
  </li>
  <li style="font: 12.0px Helvetica">
    Drools/jBPM &#8211; what are the integration scenarios? <ul style="list-style-type: hyphen">
      <li style="font: 12.0px Helvetica">
        populate Drools with data/beans in a node of a process?
      </li>
      <li style="font: 12.0px Helvetica">
        do both things operate independently?
      </li>
    </ul>
  </li>
  
  <li style="font: 12.0px Helvetica">
    Integration with authentication systems?<span class="Apple-converted-space"> </span>(AD/LDAP instead of SQL based accounts)
  </li>
</ul>

 [1]: http://wiki.jboss.org/wiki/JbpmCommunityDay
 [2]: http://www.guinness-storehouse.com/
 [3]: http://en.wikipedia.org/wiki/Dublin
 [4]: http://processdevelopments.blogspot.com/
 [5]: http://www.jorambarrez.be/blog/2008/04/03/some-real-life-jbpm-action/
 [6]: http://www.firstpartners.net/blog/technology/java/2008/06/05/jboss-business-rules-and-jbpm-workflow-presentation-dublin/
 [7]: http://koentsje.blogspot.com/
 [8]: http://www.jboss.org/jbossjbpm/pvm/