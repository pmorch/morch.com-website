---
author: peter
date: 2011-02-20 22:09:42+00:00
draft: false
title: 'Subversion: Setting the repository path for svn+ssh://server/repos'
type: post
url: /2011/02/20/subversion-setting-the-repository-path-for-svnsshserve/
featured_image: subversion-logo.png
categories:
- Technology
---

For some reason, it doesn't seem to be possible to set up a path for your repository when using subversion as: `svn+ssh://server/repos` out of the box. So you end up having to specify `svn+ssh://server/some/path/repos`.

But it really isn't that hard to do. Here is how I do it. Beware that you're going to be making system-wide changes to how svnserve operates. The basic idea is to replace svnserve with our own version, that calls the original one with a -r parameter.

<!-- more -->

As in:

```bash
cd /usr/bin
mv svnserve svnserve.distrib
cat > svnserve.my <<EOF
#!/bin/bash
# Change this to reflect where your repository really is
repos=/home/svnrepos
umask 002
/usr/bin/svnserve.distrib -r $repos "$@"
EOF
chmod +x svnserve
```


Now, whenever somebody accesses `svn+ssh://server/repos`, they're really accessing `/home/svnrepos/repos` (which must then exist and be set up etc.)


# Being careful about system upgrades


Now we've replaced svnserve that comes from the subversion package. Next time there is a new subversion package, our little script will be overwritten by svnserve from the new subversion package. So if we don't do something else, keep a copy of your little wrapper script. You'll be needing it periodically as you'll need to do the above every time the subversion package gets updated. Unless:


## Handling subversion package upgrades on dpkg (debian) based systems


Here, dpkg-divert is very handy as it allows us to move some package files "out of the way" like this:


```bash
$ sudo dpkg-divert /usr/bin/svnserve
Adding `local diversion of /usr/bin/svnserve to /usr/bin/svnserve.distrib'
```

Now, next time subversion is upgraded with a new one, /usr/bin/svnserve will stay the same, but /usr/bin/svnserve.distrib will get updated and we won't have to do anything


# Please give us a way to do this simply


I don't understand why this isn't possible by editing a config file somewhere. Oh, well, this works for me and I guess I have to pick my battles. This isn't one of them, but now you also know how to do it. It has worked since forever for me.
