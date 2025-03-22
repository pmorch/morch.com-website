---
title: "shpool - much preferred over tmux and screen"
date: 2025-03-22T17:08:55+01:00
tags: []
featured_image: "zsh-terminal.png"
description: "tmux - but where the terminal works as normal"
---

`tmux` (and `screen` before it) are wonderful. They allow me to start a CLI app in a terminal, disconnect from `tmux`, close the terminal, and reconnect to it again later.

I love that part.

But they really mess with my terminal. On a normal terminal I can scroll up with the mouse or with keyboard shortcuts like `CTRL+SHIFT+UP/DOWN/PgUp/PgDown` and I can select text with the mouse. But in `tmux` if I try that it doesn't work. Instead `tmux` tries to do something different to achieve the same thing. But I don't want or like different. Yes, I've tried the various workarounds and I hate them. I like my standard terminal's user interface.

Enter [`shpool`](https://github.com/shell-pool/shpool).

```shell
$ shpool attach name-of-session`
```

gives me a session (much like tmux did) *but the terminal works as normal*. I can `shpool detach name-of-session` from another terminal or hit `CTRL+SPACE` and then `CTRL+Q` (without releasing `SPACE`) to detatch from the current `shpool` session. While in the session everything works like normal for terminals.

`shpool` does not provide the window splitting and tiling features that `tmux` does, but I never used them.

Very happy to have found `shpool` ❤️.