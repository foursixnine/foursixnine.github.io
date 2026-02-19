---
layout: post
title: Save your Tumbleweed installation
categories:
- blog
- linux
- tumbleweed
- opensuse
generated on: 2024-07-02
---

## How to save your very old openSUSE Tumbleweed installation?

Say you're in need of recovering a very old system?, I got you:

Make sure you have a container engine, if you like to live your life dangerously:

```
nerdctl run -it -v /:/mnt -v /dev:/dev -v /sys:/sys -v /boot:/boot \
    --name hacky_tw --rm registry.opensuse.org/opensuse/tumbleweed:latest bash
```
- `zypper  --root /mnt  dup -D --allow-vendor-change`

You should be able to reboot your machine and go on with your life.

## Down the rabbit hole

Now, if you want to do weirder things, or for instance, want to check what have
you changed i.e vs an default installation, you can do the following:

```
rpm --root /mnt -V -ac  --nodeps --nomtime | \
 # this will match i.e: files that have been modified, and have different changes
 # from what originally was when the package was installed 
 # S.5......  c /etc/mail/spamassassin/local.cf backup
 awk '/^..5/ { 
    if (system("test -f /mnt"$3".rpmnew") == 0)
        must="diff"; 
    else 
        must="backup"; 

# the format will be:
# backup   /etc/fonts/conf.d/58-family-prefer-local.conf
# add $1, before "must" if you want to "debug"
print must, "\t", $3 

}'
```
