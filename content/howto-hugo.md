---
title: HowtoHugo
draft: true
omit_header_text: true
description: How to write posts and use hugo
type: post
menu: main
toc: true
---

## Running Hugo

To run hugo:

```bash
HUGO_ENV=production hugo
```

(see `themes/ananke/README.md` for `HUGO_ENV`)

To run hugo while developing (`-D` means include drafts):

```bash
hugo server -D
```

To run hugo while developing in WSL2:

```bash
hugo server -D --bind 0.0.0.0 -b http://ubuntu-wsl2
```

## Use `##` for `<h2>` as the "top" headings

The page title uses a `<h1>`, and for SEO purposes, that should be the only `<h1>` on the page. See
[Why does markup.tableOfContents.startLevel default to 2?](https://discourse.gohugo.io/t/why-does-markup-tableofcontents-startlevel-default-to-2/33963).

## Table of Contents

Add this to the article/post front matter to get a TOC:

```toml
toc: true
type: post
```

The `type: post` may not be required, but seems to be required
in `index.md` page front matter to get a TOC.

## Any Non-standard Markdown

Use the comment in the Markdown source:

```
<!-- HUGO: some description -->
```

Then, if I ever need to move from Hugo to something else, I know I need to fix
at least these specific things.

## Mathjax

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
