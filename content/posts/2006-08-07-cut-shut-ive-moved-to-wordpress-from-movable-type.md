---
title: 'Cut & Shut (I’ve moved to WordPress from Movable Type)'
author: simonm
type: post
date: 2006-08-07T02:30:32+00:00
url: /cut-shut-ive-moved-to-wordpress-from-movable-type/
categories:
  - '*nix'
  - Life
  - Open Source
  - Random Toad

---
<p align="left">
  A couple of friends have just started blogging (<a href="http://www.mcgrellis.org/blog/" target="_blank">Keith</a> & <a href="http://www.jfrancey.com/blog2" target="_blank">Jonny</a>), I was stunned how clean and simple their blogs look. At the same time I&#8217;ve been getting frustrated at several things in <a href="http://www.sixapart.com/movabletype/" target="_blank">MovableType</a> (like the lack of any decent online editing tools for creating posts, and the fact that it is painfully slow on my VPS), so I had a quick look at the blogging software they are using, <a href="http://wordpress.org/" target="_blank">WordPress</a>. I was mightly impressed, it seems to be much slicker & easier to use than MT, I was even more impressed that I could import all my current entries & comments, and that there&#8217;s plenty of help in making old links work. So I exported my stuff from MT & imported into WordPress, with the help of notes from <a href="http://wordpress.org/docs/tutorials/import-mt/" target="_blank">here</a>. I&#8217;ve also got over <a href="http://www.mccartney.ie/wordpress/2005/03/10/bandwagon-jumping/">my need for everything to be in perl</a>.
</p>

<div align="left">
  <p align="left">
    The next challenge was to ensure that old links get redirected to the content properly, this was mostly just a technical challenge as this blog is mostly private, I doubt anybody I don&#8217;t know reads it, so ensuring that links in search engine indexes is largely moot. (I had to struggle to find a reference to my blog in Google, resorting to restricting it to my site, like <a href="http://www.google.com/search?q=solaris+site%3Amccartney.ie" target="_blank">this</a>). Anyway, I found a couple of pointers that sent me in the right direction, like <a href="http://wiki.wordpress.org/MT-Redirect" target="_blank">one</a> from the WordPress wiki and <a href="http://codex.wordpress.org/Importing_from_Movable_Type_to_WordPress" target="_blank">one</a> from the newer Codex resource.
  </p>
  
  <div align="left">
    <p align="left">
      I ran into some snags in the method used here, mostly because the permalink/archive method I had used in MT was YYYY/MM/entry, so here&#8217;s the template I needed:
    </p>
    
    <p>
      <code>&lt;?php&lt;br />
require('wp-config.php');&lt;br />
header('Content-type: text/plain');&lt;br />
?&gt;&lt;br />
&lt;MTEntries lastn="999999"&gt;&lt;br />
Redirect Permanent /archives/&lt;$MTArchiveDate format="%Y/%m"$&gt;/&lt;MTArchiveFile&gt;&lt;br />
http://www.mccartney.ie/wordpress/&lt;$MTArchiveDate format="%Y/%m/%d"$&gt;/&lt;?php echo sanitize_title("&lt;$MTEntryTitle$&gt;"); ?&gt;&lt;/MTEntries&gt;</code>
    </p>
    
    <p align="left">
      This generates a file that us suitable for using as a <code>.htaccess</code> file, making Apache redirect requests for the old MT URIs to the new WordPress URIs. For the category links, I&#8217;ve just hand crafted the lines, I only had a couple of categories.
    </p>
    
    <p style="font-style: italic;" align="left">
      (In writing this post, I&#8217;ve discovered some of the problems with quoting PHP in a PHP based system, so I&#8217;ve started to read <a href="http://codex.wordpress.org/Writing_Code_in_Your_Posts" target="_blank">this</a> and promise to make the template above make sense soon, I also found <a href="http://www.coffee2code.com/archives/2005/03/29/plugin-preserve-code-formatting/" target="_blank">this</a>) <em><strong>Done.</strong></em>
    </p>
  </div>
</div></div> </div>