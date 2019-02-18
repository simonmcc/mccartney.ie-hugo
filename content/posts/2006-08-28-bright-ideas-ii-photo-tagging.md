---
title: 'Bright Ideas II: Photo Tagging'
author: simonm
type: post
date: 2006-08-28T17:02:08+00:00
url: /bright-ideas-ii-photo-tagging/
dsq_thread_id:
  - 445604954
  - 445604954
categories:
  - '*nix'
  - Bright Ideas
  - Life
  - Open Source
  - Random Toad

---
I use a mix of photo gallery software, I use <a target="_blank" href="http://www.flickr.com/photos/simonmcc/tags/">Flickr</a> for some things, notable stuff that&#8217;s public for other people to use, I also use <a target="_blank" href="http://www.fuzzymonkey.net/software/">Fuzzy Monkey</a>&#8216;s [My Photo Gallery][1], which is simple, but has some neat features (like auto thumbnail generation, keeps photos and thumbnails seperate, allowing me to use Unison/rsync to keep my online photos in sync with an offline copy, simple passwording etc).

But I&#8217;m beginning to dig tagging, so I hoked about for some web gallery software that does this, and there seems to be a real shortage, I found <a target="_blank" href="http://jimmac.musichall.cz/original.php">Original</a> and a <a target="_blank" href="http://wingolog.org/pub/original/">modification</a> of [it][2] that supports tagging, but it mix of php &#038; python, and I couldn&#8217;t get my head round all of the Python.

So this got me thinking about what is the best way to generically tag my photos so that the will work in my online gallery and with my offline tools. Microsoft have added a couple of tags in the EXIF standard, eg [XPKeywords][3]. There is some stuff on [XMP][4], Extensible Metadata Platform from Adobe. [IPTC][5] gets mentioned quite a bit, and is also supported by Google&#8217;s latest incarnation of Picasa, but is supposedly being phased out in favour of XMP.

Notably all of this is support by Phil Harvey&#8217;s [ExifTool][6], which is a Perl library and CLI tool.
  
All of this comes under metadata, i.e. it&#8217;s data about the images. So, where to start? Well, I think I need to do the following:

  * Decide which format to support! (EXIF XPKeywords, XMP, IPTC etc)
  
    (actually, the gallery should probably support multiple methods, but let&#8217;s try and focus on one to start with)
  * Extend My Photo Gallery so that it can scan it&#8217;s directory of photo data &#038; build a tag database
  * Extend My Photo Gallery so that is can generate a tag cloud.
  * Extend My Photo Gallery so that it can manage tags in the management UI.

Easy eh?

Where to start? Minimal overhead to start with, probably use SQLite for the tag/photo database, make it scan photos for tags, then work on building a tag cloud. jbrout looks like the thing to start tagging with. Then add tag management to the web UI.
  
Here&#8217;s some of my background reading:

  * [http://assente.altervista.org/?q=how\_to\_manage\_exif\_xmp\_metadata\_on\_linux\_gnome_kde][7]
  * [http://www.tasi.ac.uk/advice/delivering/faqtagging.html][8]
  * <http://www.tasi.ac.uk/advice/delivering/metadata.html>
  * <http://search.cpan.org/src/EXIFTOOL/Image-ExifTool-6.29/html/TagNames/EXIF.html>
  * <http://jbrout.python-hosting.com/>
  * <http://idea.zanestate.edu/archives/2005/11/photo-organizing-in-linux/>

 [1]: http://www.fuzzymonkey.net/software/photogallery/
 [2]: http://wingolog.org/photos/
 [3]: http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/EXIF.html
 [4]: http://en.wikipedia.org/wiki/EXtensible_Metadata_Platform
 [5]: http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/IPTC.html
 [6]: http://www.sno.phy.queensu.ca/~phil/exiftool/
 [7]: http://assente.altervista.org/?q=how_to_manage_exif_xmp_metadata_on_linux_gnome_kde
 [8]: #%20http://www.tasi.ac.uk/advice/delivering/faqtagging.html