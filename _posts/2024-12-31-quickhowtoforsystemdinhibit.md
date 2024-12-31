---
layout: post
title: Quick howto for systemd-inhibit
categories:
- blog
- systemd
- linux
- hacks
generated on: 2024-12-31
---
# Bit of the why
So often I come across the need to avoid my system to block forever, or until a process finishes, I can't recall how did I came across systemd inhibit, but
here's my approach and a bit of motivation

## Motivation

I noticed that the [Gnome Settings](https://ubuntuhandbook.org/index.php/2024/07/setup-media-server-ubuntu/), come with [Rygel](https://gnome.pages.gitlab.gnome.org/rygel/#developer-features)

After some fiddling (not much really), it starts directly once I login and I will be using it instead of a fully fledged plex or the like, I just want to stream some videos from time to time from my home pc over my ipad :D using VLC.

# The Hack

```
systemd-inhibit --who=foursixnine --why="maybe there be dragons" --mode block \
    bash -c 'while $(systemctl --user is-active -q rygel.service); do sleep 1h; done'
```

One can also use waitpid and more.

Thank you for comming to my ted talk.
