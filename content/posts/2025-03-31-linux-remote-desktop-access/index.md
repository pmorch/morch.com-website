---
title: "Linux Remote Desktop Access"
date: 2025-03-31T21:22:37+02:00
tags: []
featured_image: "GNOME-Desktop-version-44.webp"
description: "The different ways to access a Linux desktop remotely"
---

## TL;DR

Here I compare Gnome Remote Desktop, RustDesk and `x11vnc`.

I ended up using Gnome Remote Desktop for "Desktop Saring", but not for "Remote
Login" because it doesn't work without Network Manager, and I don't use Network
Manager. Also, it doesn't allow logging into the physical desktop (see below).

Instead, I use `x11vnc` for the initial logging in to the physical desktop,
which requires GDM to run with wayland disabled and it is a little cumbersome.

While RustDesk seems to work fine, it requires a custom client and a self-hosted
server (or using somebody else's server) and I'm not sure I trust it; a gut
feeling, that could be wrong.

## Background

I have a desktop machine at home, and I want to be able to access it remotely.

I already have [wireguard](https://www.wireguard.com/) set up to access my home
network, so I don't need to traverse firewalls or have my desktop accessible
from the internet. In fact I'd prefer not to.

And what i want to access is the "real" desktop that I see on my monitor at
home. See that window I know I left open, close that app "nicely" that I know I
left running. Not a virtual desktop.

This is about the options I have for accessing a Gnome desktop remotely and
which I've picked.

In the following, I'll distinguish between "pysical" login screens and desktops
(those you can also see on a monitor connected to the physical machine) and
"virtual"  login screens and desktops that are not shown directly anywhere.

## Security considerations

The problem with accessing the "real" desktop is that this desktop will be
unlocked and available to anyone in the vicinity of the machine whose desktop
I'm accessing. And if I'm not there, the mere fact of "unlocking" the desktop
might give unauthorized parties access to an otherwise locked desktop.

This is something I can live with, though, since only my wife and daughter have
physical access to that desktop machine, and I trust them. It is something to
consider, though.

### Stored passwords

Most of the solutions store passwords for remote access in clear text, which
kinda sucks. See below.

## My environment

I'm using Gnome under NixOS. I've tried everything here with Gnome under Ubuntu
24.04 too.

## The two steps of "desktop access"

It is not enough to be able to access a physical desktop that has already been
started, I also need to be able to start the desktop. And unless the system has
been setup to auto-login, when sitting in front of the monitor, when using
Gnome, first the user sees the GDM login screen:

![GDM login screen](GDM.png)

and after logging in, they see the desktop:

![Gnome Desktop](GNOME-Desktop-version-44.webp)

So we need to be able to login from a remote location and view the desktop
afterwards.

## The contenders

These are the solutions I've considered:

* Gnome Remote Desktop: offering RDP access to a gnome desktop
* RustDesk: The new kid on the block
* x11vnc: The old trusted solution

I've kicked the tires on all of them, and spoiler alert: I'll be using a
combination of Gnome Remote Desktop and x11vnc. But I'll describe why.

### Gnome Remote Desktop: offering RDP access to a gnome desktop

Gnome remote desktop is really two solutions:

1. "Desktop Sharing": Access the desktop of somebody who has already logged in
   to the desktop on the physical machine.
1. "Remote Login": Logging in as a user who is not logged in to the desktop on
   the physical machine.

"Desktop Sharing" gives RDP access to a running physical desktop. Access is
prevented by default if the desktop is locked because of inactivity. This is a
security measure to avoid unlocking the physical desktop for all to see and
access. I understand this limitation, but it would have made Gnome Remote
Desktop's "Desktop Sharing" useless to me, if it wasn't for the [Allow Locked
Remote
Desktop](https://extensions.gnome.org/extension/4338/allow-locked-remote-desktop/)
GNOME Shell Extension that exactly lifts this limitation. And then it works
brilliantly.

"Remote Login" works a little differently than I first thought. It runs on
another TCP port than "Desktop Sharing". When you connect with RDP, you see a
virtual GDM login screen, and if you try to login as a user that is already
logged in on the real desktop, you'll get an error. Otherwise, it will start a
virtual desktop in that user's name. So it doesn't allow you to start the
"physical" desktop.

Together, one can use "Desktop Sharing" if the physical desktop has already been
started, and "Remote Login" if it hasn't. The only problem is that if you forget
to logout from the virtual desktop, you will not be able to login to the
physical desktop while the virtual desktop is running. I could live with that.

However, there seems to be a
[problem](https://discourse.gnome.org/t/can-i-run-gnome-remote-desktop-without-networkmanager/28116)
getting "Remote Login" to work without Network Manager. And I don't use Network
Manager, but have configured the network statically in NixOS, so for now, I need
to either use Network Manager or not use "Remote Login".

Gnome Remote Desktop is configured in Gnome Settings -> System -> Remote
Desktop in two tabs:

![Gnome Settings for Gnome Remote Desktop](gnome-remote-desktop-config.png)

#### How are Gnome Remote Desktop passwords stored?

For "Desktop Sharing", they're stored in Gnome's "Passwords and Keys" (Seahorse)

!["Desktop Sharing" password](https://i.imgur.com/fSEJ6Yh.png)

Where "Copy" then copies `{'username': <'test'>, 'password': <'bar'>}`.

For "Remote Login":

```
sudo cat /var/lib/gnome-remote-desktop/.local/share/gnome-remote-desktop/credentials.ini
[RDP]
credentials={'username': <'foo'>, 'password': <'bar'>}
```

So in both cases stored as clear text. ☹️

### RustDesk: The new kid on the block

Rustdesk seems to handle both the physical GDM login and accessing the physical desktop just fine.

I had difficulties getting RustDesk to work as a service in NixOS, but I finally
[managed](https://www.reddit.com/r/rustdesk/comments/1jhn2pa/comment/mjbjrcv/).

I'm self-hosting the [server
part](https://rustdesk.com/docs/en/self-host/rustdesk-server-oss/docker/) so I'm
fully self-hosted also for rustdesk.

I could not find any clear info about where/how rustdesk stores passwords, so
I'm assuming it is in clear text somewhere (please let me know if I'm wrong).

A very prolific NixOS poster
[remarked](https://discourse.nixos.org/t/how-to-best-enable-sudo-en-a-systemd-services-rustdesk/62065/2)
about the way rustdesk uses `sudo`:

> Whoa, that’s quite some horrible application code. This should be done with
> polkit. I’d seen this project around, really expected slightly better quality
> from it…

RustDesk used to only support X11, but now has experimental Wayland support
since version 1.2.0.

### `x11vnc`: The old trusted solution

This only works for X11, and not for wayland. (Which is perhaps why Gnome Remote
Desktop was created?)

I log into the desktop machine with ssh and start `x11vnc` when I need it. This
is a little cumbersome, but I never bothered creating services for this.

#### GDM login

Use this if the user has not yet logged in to the physical desktop. As it turns
out, this is the only thing I ended up using `x11vnc` for in the end:

##### One-time setup

First make sure that wayland is disabled for GDM. This will make GDM itself use
X11, and only allow you to start your desktop with X11.  Edit
`/etc/gdm/custom.conf` and make sure it contains:

```
[daemon]
WaylandEnable=false
```
(Without the comment character `#` in front of `WaylandEnable=false`).

Reboot (or restart GDM) if you had to change `/etc/gdm/custom.conf`.

Then create a `x11vnc` password for GDM. Usually `x11vnc` wants to store the
password file in the user's home directory, but at least on NixOS, for the `gdm`
user, that is `/run/gdm`, which is deleted completely on every reboot. Instead
create the password file like this:

```
sudo mkdir /home/gdm
sudo chown gdm: /home/gdm
sudo chmod 0700 /home/gdm
sudo -u gdm x11vnc -storepasswd /home/gdm/passwd
Enter VNC password: <enter password>
Verify password:    <enter password>
Write password to /home/gdm/passwd?  [y]/n y
Password written to: /home/gdm/passwd
```

##### Login with GDM

Then, to view the the physical GDM login screen remotely, start `x11vnc` like this:

```
sudo -u gdm x11vnc -once -rfbauth /home/gdm/passwd \
    -auth /run/user/$(id -u gdm)/gdm/Xauthority \
    -display :0 -rfbport 5901
```

Now you can connect with `vnc` to port 5901, see GDM and login. Once you've
logged in, the `vnc` screen will disappear and `x11vnc` will exit because of
the `-once` option. It was just for the GDM login.

#### See user's physical desktop

Run this to see the logged in desktop (assuming you're logged in with ssh as the
same user showing the desktop). Again, this only works if the desktop session is
using X11 (and not Wayland):

```
x11vnc -usepw \
    -auth /run/user/$(id -u)/gdm/Xauthority \
    -display :1 -forever -rfbport 5901
```

(You may need to check whether the physical desktop uses `DISPLAY` `:0` or `:1`. Mine uses `:1`.)


## Summary

See TL;DR at the top 🙂