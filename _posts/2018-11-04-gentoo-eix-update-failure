---
layout: post
title: gentoo eix-update failure
categories:
- blog
generated on: 2018-11-04
---

## Summary

If you are having the following error on your Gentoo system: 

```
 Can't open the database file '/var/cache/eix/portage.eix' for writing (mode = 'wb') 
```

Don't waste your time, simply the /var/cache/eix directory is not present and/or writeable by the eix/portage use

```
mkdir -p /var/cache/eix
chmod +w /var/cache/eix*
```

Basic story is that eix will drop privileges to portage user when ran as root. 
