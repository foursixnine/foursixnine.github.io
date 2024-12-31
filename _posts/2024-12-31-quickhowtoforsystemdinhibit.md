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
So often I come across the need to avoid my system to block forever, or until a process finishes, I can't recall how did I came across systemd inhibit, but
here's my approach:

```
systemd-inhibit --who=foursixnine --why="maybe there be dragons" --mode block \
    bash -c 'while $(systemctl --user is-active -q rygel.service); do sleep 1h; done'
```


One can also use waitpid and more.

Thank you for comming to my ted talk.
