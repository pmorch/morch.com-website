---
title: HowtoHugo
draft: true
omit_header_text: true
description: How to write posts and use hugo
type: post
menu: main
toc: true
---

# Running Hugo

To run hugo:

    HUGO_ENV=production hugo

(see `themes/ananke/README.md` for `HUGO_ENV`)

To run hugo while developing (`-D` means include drafts):

    hugo server -D

To run hugo while developing in WSL2:

    hugo server -D --bind 0.0.0.0 -b http://ubuntu-wsl2

# Any Non-standard Markdown

Use the comment:

```
<!-- HUGO: some description -->
```

Then, if I ever need to move from Hugo to something else, I know I need to fix
at least these specific things.

# Mathjax

See [How to use Mathjax in Hugo](/posts/2021-07-24-mathjax-in-hugo/), but short
version:

Mathjax block:

<!-- HUGO: mathjax -->
{{< mathjax/block >}}
\[a \ne 0\]
{{< /mathjax/block >}}

<!-- HUGO: mathjax -->
Inline shortcode {{< mathjax/inline >}}\(a \ne 0\){{< /mathjax/inline >}} with
Mathjax.

# Table of Contents

Add `toc: true` to the front matter. I don't know why, but by default, it
starts at `##`/`<H2>` and below. I've modified that to be H1 and below with
this in
`config.toml`:


    [markup]
      [markup.tableOfContents]
        startLevel = 1

Add `type: post` to `index.md` page front matter to get a TOC.
