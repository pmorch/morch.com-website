---
author: Peter
date: 2011-02-15 07:59:56+00:00
draft: false
title: 'Classical Mechanics: Why does Power depend on frame of reference?'
type: post
url: /2011/02/15/power-depends-on-frame-of-reference/
categories:
- Technology
featured_image: N1_Moon_Rocket_VEXEL_by_rogelead.jpg
---

Imagine we're in a rocket.

We have an imaginary engine, that provides a constant amount of thrust. How much power does such an engine provide? In essence the power depends linearly on the velocity:

<!-- HUGO: mathjax -->
{{< mathjax/block >}}\[
\begin{align*}
P &= \frac{dW}{dt} \wedge W = \int F \cdot ds \Leftrightarrow \\[10 pt]
P &= F \cdot \frac{ds}{dt} \Leftrightarrow \\[10 pt]
P &= F \cdot v
\end{align*}
\]{{< /mathjax/block >}}

And the velocity depends (by definition) on the frame of reference.

So imagine that we started from a planet a while back. Our thrust is constant (remember?) so our acceleration is constant, and so velocity grows linearly.

Does that make sense?

If this was a classical rocket engine (and we can somehow neglect that our rocket looses mass), then the Power would continue to grow. At some point, the power will exceed the power present in the fuel ({{< mathjax/inline >}}\( power = {energy \over time} \){{< /mathjax/inline >}}). That doesn't make sense to me.

Also, lets say we hook up with another rocket that has the same velocity as us. After having drinks and dinner together, we start up our engine and head off. Depending on our frame of reference, we either have enormous power (if we keep our original frame of reference - the planet we started from) or very little power (if we use the other rocket as a frame of reference). That also makes no sense.

Our assumption was that we have an imaginary engine that provides a constant amount of thrust. When faced with conclusions that make no sense, it is customary to question the assumptions. Our imaginary engine.

So, have I then proved that it is impossible to create such an imaginary engine? Really?

Related to the above, we have the definition of kinetic energy:

<!-- HUGO: mathjax -->
{{< mathjax/block >}}\[
E_{kin} = \frac{1}{2} \cdot m \cdot v^2
\]{{< /mathjax/block >}}

Here again, we have that the energy depends on the frame of reference. Energy seems such a crucial cornerstone of physics, that I don't understand how it can depend on the frame of reference. When e.g. the energy content of fuel or batteries or whatever are absolute values.

I've been toying with this for years, never taking it seriously, but I am perplexed. I was just trying to explore the characteristics that such an imaginary engine would have and I don't know what to make of it. Do you?
