---
layout: post
title: When find can't find
categories:
- blog
- tech
generated on: 2019-08-27
---

If you happen to be using [gnu find](http://man7.org/linux/man-pages/man1/find.1.html) in the deadly combination with
a directory that is a symlink (you just don't know that yet), you will find face the hard truth that running:

`find /path/to/directory -type f`

Will return _zero_, __nada__, *nichts*, ~~meiyou~~, which is annoying.

![where is it!](https://media.giphy.com/media/clupdT5vHL9GifMlnC/giphy.gif)

this will make you question your life decisions, and your knowledge on tools that you use daily, only to find out that
the directory is actually a symlink :).


So next time you find yourself using `find` and it returns nothing, but you are sure that your syntax is correct and get
no errors, try adding the `--fowllow` or use the `-L`

` find -L /path/to/directory/with/symlink -type f`

This will do what you want :)

![Here is it!](https://media.giphy.com/media/1FnPDkhFZDgoU/giphy.gif)
