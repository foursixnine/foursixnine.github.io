---
layout: post
title: In case your zsh completion is broken on OSX with homebrew
categories:
- blog
- osx
- homebrew
- zsh
generated on: 2022-07-13
---

Happens that I spent today (Finally) a good few hours trying to figure out why my autocompletion was broken on my new shiny MacBook Pro M1 Pro... 

despite Homebrew's `brew doctor` giving me the All OK.

```
foursixnine@pakhet ~ % brew doctor
Your system is ready to brew.
```

turns out that it was just the shell:

```
foursixnine@pakhet ~ % echo $FPATH
/opt/homebrew/share/zsh-completions:/usr/local/share/zsh/site-functions:/usr/share/zsh/site-functions:/usr/share/zsh/5.8.1/functions
```

My user's shell is still being set to osx's 5.8.1 zsh... 

So after hours of searching on the internet to no avail, and scratching my head, I came back to my initial idea of just switching the shell::

```
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshenv
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
```

