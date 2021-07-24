---
author: peter
date: 2021-07-24 04:30:00+00:00
draft: false
title: "How to use Mathjax in Hugo"
type: post
categories:
- Technology
featured_image: hugo-logo-wide.svg
---

[Hugo](https://gohugo.io/) is the static site generator that this site is built
with. This is how to enable Mathjax in Hugo so you can write LaTeX in your
pages, as I've used e.g. in [On the Economics of Streaming: Show me the
money](/posts/2021-07-23-spotify-econonmics/)

Put this in the page source somewhere. I put it in `layouts/partials/head-additions.html`, but perhaps that is specific to the ananke theme:

```html
<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
```

Now you can put this on your page and have it rendered like you'd expect:

```
Raw Mathjax block:

$$a_4 \ne b_4$$
```

You can stop here.

But I went a step further, because I didn't like how Mathjax gives you a flash
of unstyled content (FOUC) as described in [issue
131](https://github.com/mathjax/MathJax/issues/131). I modified the approach
suggested in that issue. Put this in the page source instead of the two simple
`<script>` tags above:

```html
{{- if or (.HasShortcode "mathjax/block") (.HasShortcode "mathjax/inline") -}}
<style>
.has-mathjax {
    visibility: hidden;
}
</style>

<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

<script>
window.MathJax = {
  startup: {
    pageReady: () => {
      return MathJax.startup.defaultPageReady().then(() => {
        for (let element of document.getElementsByClassName("has-mathjax")) {
            element.style.visibility = "visible"
        }
      });
    }
  }
};
</script>
{{- end -}}
```

Put this in `layouts/shortcodes/mathjax/block.html`:
```html
<div class="has-mathjax">
{{ .Inner }}
</div>
```

And this in `layouts/shortcodes/mathjax/inline.html`:
```html
<span class="has-mathjax">{{ .Inner }}</span>
```

Now you can put this in your page source:
```
Mathjax block:

{{</* mathjax/block */>}}
\[a \ne 0\]
{{</* /mathjax/block */>}}

Inline shortcode {{</* mathjax/inline */>}}\(a \ne 0\){{</* /mathjax/inline
*/>}} with Mathjax.
```

You now have Mathjax in Hugo without FOUC.
