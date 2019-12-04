---
author: peter
date: 2011-07-20 20:03:44+00:00
title: Showing icons on <input type="submit"> HTML buttons
type: post
url: /2011/07/20/showing-icons-on-html-buttons/
categories:
- Technology
---

[![](http://www.morch.com/wp-content/uploads/2011/07/buttonWithIcon1.png)
](http://www.morch.com/wp-content/uploads/2011/07/buttonWithIcon1.png)If you got here, you've probably figured out that it isn't trivial to style <input type="submit"> HTML buttons and give them e.g. icons. Here is [a solution](http://www.morch.com/download/proxyButtons.html).

<!-- more -->

Getting an <input type="submit"> shown with icons [isn't normally possible](http://bugs.jqueryui.com/ticket/5683):


<blockquote>"When using an input of type button, submit or reset, support is limited to plain text labels with no icons."..."This is a browser limitation".</blockquote>


It works by using a "proxy button" approach: Hide the <input type="submit"> button, append a <button> and have the click event of the new <button> invoke the click event on the original hidden <input type="submit">.

It has been tested in IE6, IE8, Chrome12 and FF 3.6.

Inspiration came from Robert Mullaney and Andy Chapman on [Robert Mullaney's blog](http://www.robertmullany.com/2010/11/29/style-submit-and-reset-buttons-with-icons-using-jquery-ui/).
