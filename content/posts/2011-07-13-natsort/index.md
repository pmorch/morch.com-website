---
author: Peter
date: 2011-07-13 06:52:08+00:00
draft: false
title: Natural Sort
type: post
url: /2011/07/13/natsort/
categories:
- Technology
---

Why doesn't every programming language have "Natural Sorting" built in, out of the box? Natural sorting is the way humans sort, where number substrings are sorted numerically, everything else alphabetically:
<table >

<tr >
Sorted "[Asciibetically](http://weblog.masukomi.org/2007/12/10/alphabetical-asciibetical)" (normal computer sort)
Sorted "Naturally" (what humans prefer)
</tr>

<tbody >
<tr >

<td >foo1bar
foo10bar
foo2bar
</td>

<td >foo1bar
foo2bar
foo10bar
</td>
</tr>
</tbody>
</table>
Notice how 10 comes before 2 in [asciibetical](http://weblog.masukomi.org/2007/12/10/alphabetical-asciibetical) "normal computer sorting" ? Haven't we all seen user interfaces that like that? Its just plain _wrong_. :-(

[Dave Koelle's Alphanum Algorithm](http://www.davekoelle.com/alphanum.html) sorts naturally, but instead of analyzing each array element O(log(N)) times, I [present a modified Perl version](https://github.com/pmorch/natsort) that allows for [Schwartzian transforms](http://en.wikipedia.org/wiki/Schwartzian_transform), yielding huge performance improvements.

<!-- more -->


# Improvements to Alphanum


The problem is that the sorting algorithm in many languages sorts by calling a user-provided comparison function taking two parameters, a and b. Such comparisons are done O(n log(n)) times (for [typical sort](http://en.wikipedia.org/wiki/Sorting_algorithm) algorithms mergesort and timsort)

Alphanum works by splitting input strings into string and number sequences and then sorting them individually as strings and numbers respectively. This splitting and partial sorting is performance heavy, and being done O(n log(n)) times. A [Schwartzian transform](http://en.wikipedia.org/wiki/Schwartzian_transform) allows that to be done exactly n times, which gives a huge performance improvement.

So instead of converting string23string into

    
    array: [ "string", 23, "string"]


it is converted to

    
    string: "string0000000000000023string"


in a pre-processing step and then a normal asciibetical-comparison sort is performed, which is _much_ faster.

On my machine, sorting 100 strings is 4 times faster, sorting 100,000 strings is 10 times faster and sorting 1,000,000 strings is 12 times faster.


# What Natural Sorting _isn't_ - I18n_
_


While I was investigating to write this post, I discovered [UTS #10: Unicode Collation Algorithm](http://unicode.org/reports/tr10/). Man, sorting (or _collation_) is _complicated_, especially if you take internationalization (i18n) into account. I hadn't considered that z < ö in Swedish, but ö < z in German, even though I live 22km from Sweden and my wife is German. (Which reminds me that anybody who thinks time calculation is simple doesn't have a clue, but that is a topic for another post another day ;-))

However, the Unicode Collation Algorithm doesn't consider Natural Sorting to be important enough to make it on their list. It is explicitly mentioned as a [Non-goal: Numeric formatting: numbers composed of a string of digits or other numerics will not necessarily sort in numerical order](http://unicode.org/reports/tr10/#Non-Goals)__

Hopefully I didn't mess up and my modified versions of Alphanum will work hand-in-hand with any i18n/locale-aware sorting the user does.


# To-do


I've written a perl improvement, but I'm going to need a  javascript version and a MySql version too.  A javascript starting point can be found on [Dave Koelle's](http://www.davekoelle.com/alphanum.html) page, and I found a [MySql based natsort](http://drupalcode.org/project/natsort.git/tree/refs/heads/5.x-1.x). They just need to be modified similarly. Patches welcome! :-)
