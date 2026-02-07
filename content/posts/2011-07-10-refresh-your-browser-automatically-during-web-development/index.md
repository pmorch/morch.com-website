---
author: Peter
date: 2011-07-10 12:08:43+00:00
draft: false
title: Refresh your browser automatically during web development
type: post
url: /2011/07/10/refresh-your-browser-automatically-during-web-development/
categories:
- Technology
featured_image: refresh.png
---

<!-- HUGO: Using figure shortcode -->
{{< figure src="refresh.png" class="auto-width" alt="Refresh image" >}}

Did you ever find that while editing files for the web (e.g. HTML, Javascript, Java/Flash/Ruby, whatever) that it would be cool to have your browser reflect any changes as soon as you hit Save in your IDE without having to Alt-Tab to the browser and hit refresh (Ctrl-R)? That way, you could stay entirely in your browser and just move your eyes to the browser as it refreshes automatically showing you the results of your newest changes.

Well, now you can! I've developed a pair of tools for that allow this when used in concert. Both are Open Source, of course.

<!--more-->

1. A "monitorfiles" tool ([github](https://github.com/pmorch/monitorfiles)) that can execute any command when a monitored file changes
2. A "Remote Control" Firefox extension ([addons.mozilla.org](https://addons.mozilla.org/en-US/firefox/addon/remote-control/)) ([github](https://github.com/pmorch/FF-Remote-Control)) that listens to events from "monitorfiles" to refresh the browser when any such files change.

Do you like it? I do! :-)

Here are some of the things that I'd like to improve, but for now it works fine for me:

* A Chrome extension would be nice too, but that requires [some](http://stackoverflow.com/questions/2091258/chrome-command-line-remote-control-on-linux) more [work](http://groups.google.com/a/chromium.org/group/chromium-extensions/browse_thread/thread/e4c8174f6271482e/f125f5c2f7b1ae37).
* Some investigation as to how to integrate this into e.g. Eclipse instead of requiring "monitorfiles". (But I don't use Eclipse myself, so that isn't low-hanging fruit for me)
* Look at the github links for more information including known outstanding issues.

Enjoy!
