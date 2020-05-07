---
layout: post
title: How to import a gpg key on zypper (openSUSE)
categories:
- blog
- linux
- tech
generated on: 2020-05-07
---
For some odd reason, I couldn't find quickly (2 mins in the manpage and some others on DuckDuckGo) a way to import a
GPG key.

![](https://media.giphy.com/media/L3pfVwbsJbrk4/giphy.gif)

Just because one of the repos gives this ugly message:

```
Repository vscode does not define additional 'gpgkey=' URLs.
Warning: File 'repomd.xml' from repository 'vscode' is signed with an unknown key 'EB3E94ADBE1229CF'.

    Note: Signing data enables the recipient to verify that no modifications occurred after the data
    were signed. Accepting data with no, wrong or unknown signature can lead to a corrupted system
    and in extreme cases even to a system compromise.

    Note: File 'repomd.xml' is the repositories master index file. It ensures the integrity of the
    whole repo.

    Warning: We can't verify that no one meddled with this file, so it might not be trustworthy
    anymore! You should not continue unless you know it's safe.
```

I know you can use `zypper ar --gpg-auto-import-keys`, but I didn't do it when I added it (and I'm too lazy to remove 
the repo and add it again, just to see if it works)

```
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper ref
```

