---
author: Peter
date: 2009-02-09 00:00:51+00:00
draft: false
title: Documentation, Git and MediaWiki
type: post
url: /2009/02/09/documentation-git-and-mediawiki/
categories:
- Technology
---



I have a dream. I want to write structured documentation and  source code together in my text editor and version control both together  with [git](http://git-scm.com/), just like the source code. But have it be searchable, viewable and ideally editable within MediaWiki. Is this possible?<!-- more -->


## Requirements


Several contributors each write or edit documentation and check it in  to git. So git holds the original documentation, along side code for  the project or other project files.

The project also has a central MediaWiki installation, where need to  at least be able to search for and view the documentation that is stored  in git. It is ok, that it is only the newest version that is searched  and viewable from MediaWiki.

Structured: The formats of large parts of the documentation is  already given, such as POD for perl, javadoc, and raw source code too.  Additionally some of the documentation will be in some other markup. But  which? MediaWiki markup? AsciiDoc? DocBook? Regardless of whether one  decides to go with MediaWiki markup for some documentation, we need to  be able to search _all of it_. We need to be able to search many different formats, some in sources external to MediaWiki.

In addition, each individual contributor needs to be able to view the  rendered documentation he or she is writing right now, and thereby  check it e.g. for syntax errors. On the local installation, before it is  shared with others.


## Getting MediaWiki to Search and Show External Content


This is the missing part of the puzzle, that I haven't been able to figure out yet...

We have both MediaWiki and non-MediaWiki documentation such as   perl-pod and javadoc stored in our version control system and a bugzilla  installation. What we'd like is to be able to enter "foo" in the  MediaWiki search field, and find MediaWiki pages with "foo" (like now),  ut *also* find "foo" in e.g the javadoc, perldoc, source code and  present a potentially external link such as: [http://server/javadoc.cgi?src=SomeClass.java](http://server/javadoc.cgi?src=SomeClass.java) .

I've been searching for a solution looking all over for this, and I can't believe we're the first people interested in this.[Another question](http://thread.gmane.org/gmane.org.wikimedia.mediawiki/14457) shows no replies but is basically the same question.

I see three different approaches:



	  1. Pre-parse the perldoc, javadoc etc. and keep some internal MediaWiki  pages up-to-date with the parsed external sources. Then MediaWiki's  existing search will be able to index and find data in them. But the  syncing is messy and we don't need to edit java code from inside  MediaWiki anyway. Also, original formatting may get lost.
	  2. Modify MediaWiki's internal search e.g. like Extension:Lucene-search and somehow squeeze in a link to [http://server/javadoc.cgi?src=SomeClass.java](http://server/javadoc.cgi?src=SomeClass.java)
	  3. Create a meta search thingy, so when searched for "foo", it calls  the unmodified MediaWiki search and presents *these* results, then  presents results for searching of javadoc etc.

I don't like 1, but don't know which of 2 or 3 would be easiest.

I posted [this question](http://article.gmane.org/gmane.org.wikimedia.mediawiki/30017) on the MediaWiki mailing list.

Here are some pages, that seem to be closest I've found:



	  * Gmane

	    * [Storing or Linking Documents](http://thread.gmane.org/gmane.org.wikimedia.mediawiki/19519)
	    * [External/non-web automated updates to mediawiki articles](http://thread.gmane.org/gmane.org.wikimedia.mediawiki/451)
	    * [Rob Church's FileSearch work](http://thread.gmane.org/gmane.org.wikimedia.mediawiki/19519)
	    * [Is dynamic content searchable?](http://thread.gmane.org/gmane.org.wikimedia.mediawiki/22719/focus=22723)


	  * Other

	    * [Using the python wikipediabot](http://meta.wikimedia.org/wiki/Interwiki_bot/Getting_started)
	    * [Category:Search_extensions](http://www.mediawiki.org/wiki/Category:Search_extensions)
	    * [Extension:Lucene-search](http://www.mediawiki.org/wiki/Extension:Lucene-search)
	    * [Embedding MediaWiki content in external pages](http://htyp.org/embedding_MediaWiki_content_in_external_pages)





## So, which markup?


For the parts of the documentation, where the format is not dictated  by it's context ( e.g. POD in perl code ) we want structured text, so we  have to decide on a markup language / syntax to use.


### MediaWiki markup


If MediaWiki markup is chosen, that would require each developer  machine to have a separate MediaWiki installation too (I think), which  would complicate that solution a whole lot.

Are there alternatives to this? There seems to be a number of ways to [show MediaWiki markup rendered as HTML without a complete MediaWiki installation](http://www.mediawiki.org/wiki/Alternative_parsers).

Now since it is MediaWiki markup, it would be possible to make the  documentation first class MediaWiki pages too (but we still need to be  able to synchronize with git). Perhaps [mvs](http://search.cpan.org/%7Emarkj/WWW-Mediawiki-Client/bin/mvs) can help here, as it can "check out" and "check in" MediaWiki pages  from a wiki. That would allow us to edit these pages from within  MediaWiki. We're still left with having to provide some way to do  conflict resolution though as there is no locking in git. For some  reason, [Talk:Alternative_parsers](http://www.mediawiki.org/wiki/Talk:Alternative_parsers) is the best page describing these solutions. But it might be possible.


### HTML / DocBook


Of course we could just choose to write the documentation in HTML,  but that is too cumbersome and too XML-ish to write in a text editor in  my opinion. The actual contents of the document are lost on the writer  as he is immersed in <tags/>.

DocBook has the same disadvantages as HTML, but the advantage that it  can be exported to so many formats, but it is also cumbersome to write  without the aid of an application for at least completion of the valid  tags and attributes. (Disclaimer: I don't have any actual experience  with DocBook.)


### AsciiDoc markup


If [AsciiDoc](http://www.methods.co.nz/asciidoc/) markup  is chosen, each developer's installation is rather easy, since there is a  trivial AsciiDoc -> HTML translation, and we can use the  contributor's browser to check the HTML (I'm assuming it will be valid  HTML automatically). Also, AsciiDoc has [adgen,](http://www.rapazp.ch/opensource/tools/adgen) a neat complete website solution, it looks like.

However, if we use non-MediaWiki markup, such as AsciiDoc, then it  won't be possible to render it natively under MediaWiki. And then we  have to solve....:


## See Also





	  * [Dreaming Of Mediawiki Using GIT](http://www.foo.be/cgi-bin/wiki.pl/2007-11-10_Dreaming_Of_Mediawiki_Using_GIT)
	  * [Wikipedia:Text_editor_support](http://en.wikipedia.org/wiki/Wikipedia:Text_editor_support)
	  * [Help:External_editors#ee.pl](http://en.wikipedia.org/wiki/Help:External_editors#ee.pl)

EDIT: I've since replaced WordPress with Drupal. My heart still lies  in this approach, but lets face it. Ikiwiki is not Drupal. I don't get  all the bells and whistles. So I've decided to go with Drupal (again),  learning curve and all. It does rock. Since I wrote this article, I've  discovered the XML-RCP based BlogAPI and other APIs that Drupal (and  Wordpress and...) support, allowing for editing from external editors.  I'll experiment with that for now.


