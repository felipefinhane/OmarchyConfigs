#!/bin/sh
#
# ~/.xinitrc - X11 initialization script for Omarchy
#

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Set wallpaper if available
if command -v feh >/dev/null 2>&1; then
    feh --bg-scale ~/.wallpaper 2>/dev/null || true
fi

# Start compositor if available
if command -v picom >/dev/null 2>&1; then
    picom -b &
fi

# Start window manager (customize as needed)
# Example window managers:
# exec i3
# exec bspwm
# exec openbox-session
# exec xfce4-session
exec i3