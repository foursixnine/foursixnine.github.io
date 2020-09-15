---
layout: post
title: Ext4 filesystem has no space left on device? You liar!
categories:
- blog
- linux
- tech
- filesystems
generated on: 2020-09-15
---

![Disk usage](https://imgs.xkcd.com/comics/disk_usage.png)

So, you wake up one day, and find that one of your programs, starts to complainig about "No space left on device":

Next thing (Obviously, duh?) is to see what happened, so you fire up `du -h /tmp` right?:

```
$ du -h /tmp
Filesystem              Size  Used Avail Use% Mounted on
/dev/mapper/zkvm1-root  6.2G  4.6G  1.3G  79% /
```

![Well, yes, but no, ok? ok, ok!](https://media.giphy.com/media/SVgKToBLI6S6DUye1Y/giphy.gif)

Wait, what? there's space there! How can it be? In all my years of experience (+15!), I've never seen such thing!

Gods must be crazy!? or is it a 2020 thing?

![I disagree with you](https://media.giphy.com/media/VcWnY3R6YWVtC/giphy.gif)

```
$ touch /tmp
touch: cannot touch ‘/tmp/test’: No space left on device
```
![Wait, what? not even a small empty file?](https://media.giphy.com/media/ToMjGpJ1lQiQarAftaU/giphy.gif)
![Ok...](https://media.giphy.com/media/XdIOEZTt6dL7zTYWIo/giphy.gif)

After shamelessly googling/duckducking/searching, I ended up at https://blog.merovius.de/2013/10/20/ext4-mysterious-no-space-left-on.html
but alas, that was not my problem, although... perhaps too many files?, let's check with `du -i` this time:

```
$ du -i /tmp
`Filesystem             Inodes  IUsed IFree IUse% Mounted on
/dev/mapper/zkvm1-root 417792 417792     0  100% /
```

![Of course!](https://media.giphy.com/media/xT1R9Up1IZR6AtWdKE/giphy.gif)

Because I'm super smart ~~I'm not~~, I now __know__ where my problem is, too many files!, time to start fixing this... 

After few minutes of deleting files, moving things around, bind mounting things, I landed with the actual root cause:

Tons of messages waiting in [/var/spool/clientmqueue](https://www.ibm.com/support/pages/varspoolclientmqueue-keeps-filling-and-causes-var-filesystem-usage-exceeded-threshold) to be processed,
I decided to delete some, after all, I don't care about this system's mails... so `find /var/spool/clientmqueue -type f -delete` does the job, and allows me to have tab completion again! YAY!.

However, because deleting files blindly is never a good solution, I ended up in the link from above, the solution was quite simple: 

```
$ systemctl enable --now sendmail
```
![Smart idea!](https://media.giphy.com/media/W35DnRbN4oDHIAApdk/giphy.gif)

After a while, `root` user started to receive system mail, and I could delete them afterwards :)

In the end, very simple solution (In my case!) rather than formatting or transfering all the data to a second drive, formatting & playing with inode size and stuff...

```
Filesystem             Inodes IUsed  IFree IUse% Mounted on
/dev/mapper/zkvm1-root 417792 92955 324837   23% /
```
*Et voilà, ma chérie!*
![It's alive!](https://media.giphy.com/media/xT5LMDi8H2A1FtLlpC/giphy.gif)


This is a very long post, just to say:

ext4 no space left on device can mean: You have no space left, or you don't have more room to store your files.
