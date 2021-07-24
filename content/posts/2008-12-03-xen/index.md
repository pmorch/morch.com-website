---
author: Peter
date: 2008-12-03 00:00:54+00:00
draft: false
title: Xen?
type: post
url: /2008/12/03/xen/
categories:
- Technology
---



Now, do I want to run Xen? Hmm... I'm using it to host morch.com itself, and I think its great.

Compared to VMware workstation, which is my other favorite, I love  that it is open source, and I love that it is detachable. That is, I can  start it and don't have any GUI artifacts hanging around. What I do  with VMware workstation is start it under a VNC server, so I don't have  to worry about the GUI, but this isn't about VMware but about Xen. _[I've since learned that this isn't true about VMware workstation - it has become detachable]_

I also love Ubuntu, and it seems [Xen dom0 is not supported on Ubuntu](http://ubuntuforums.org/showthread.php?p=6230287). As that thread shows, I finally did git Xen running on Ubuntu by following this [howto](http://www.howtoforge.com/ubuntu-8.04-server-install-xen-from-ubuntu-repositories).

But to really get it working, I ran into these problems too:



	  * [no xm console prompt after debootstrap debian or ubuntu](https://bugs.launchpad.net/ubuntu/+source/xen-tools/+bug/139046) (Only for Debian domU-s though)
	  * And the problem in the howto that `file:` should have been `tap:aio:`.
	  * [Xen linux error message: PCI-DMA: Out of SW-IOMMU space.](http://lists.xensource.com/archives/html/xen-devel/2007-09/msg00150.html) Here I added `swiotlb=128` to the xenkopt line in my /boot/grub.menu.list.
	  * [Nvidia graphics drivers don't work in Xen kernels](http://www.nvnews.net/vbulletin/showthread.php?t=72490). (No workaround - live with it)

Other than that, I think my Xen on Ubuntu is running fine.

Now, the way I work is that I'd like to have some virtual machines  running all the time, and some for debugging and short term trials. For  the former, I'd like to use Xen, but for the latter, I'd like to use  VMware workstation (especially because it has multilevel snapshots, and  LVM which Xen uses for snapshots, [doesn't support a snapshot of a snapshot](http://osdir.com/ml/emulators.xen.user/2005-07/msg00717.html).)

But alas, [You cannot run VMware products on a xen kernel](http://communities.vmware.com/message/617263)

So, now, I guess, I have to ask: How much do I really want to run  VMware Workstation? Am I prepared to give that up to run Xen instead?

I wish I could have run VMware under a Xen dom0 and use Nvidia graphics drivers! :-( VMware workstation for now...


