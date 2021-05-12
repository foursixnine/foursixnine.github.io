---
layout: post
title: How to edit stuff that you've already commited to git? (And squash as a bonus)
categories:
- blog
- tech
- linux
- git
generated on: 2021-05-04
---
So, you're in the middle of a review, and have couple of commits but one of the comments is asking you to modify a line
that belongs to second to last, or even the first commit in your list, and you're not willing to do:

`git commit -m "Add fixes from the review" $file`

Or you simply don't know, and have no idea what `squash` or `rebase` means?, well I won't explain `squash` today, but I
will explain `rebase`

![DON'T PANIC](https://media.giphy.com/media/O8FdP4NKLFKcU/giphy.gif)

See how I do it, and also how do I screw up!

[![asciicast](https://asciinema.org/a/bUdcrFZRRAzCHQk2EyG7ru9mA.svg)](https://asciinema.org/a/bUdcrFZRRAzCHQk2EyG7ru9mA)

It all boils down to making sure that you **trust** git, and hope that things are small enough so that if you lose the
stash, you can always rewrite it.

So in the end, for me it was:

```
git fetch origin
git rebase -i origin/master # if your branch is not clean, git will complain and stop
git stash # because my branch was not clean, and my desired change was already done
git rebase -i origin/master # now, let's do a rebase
# edit desired commits, for this add the edit (or an e) before the commit
# save and quit vim ([esc]+[:][x] or [esc]+[:][w][q], or your editor, if you're using something else
git stash pop # because I already had my change
$HACK # if you get conflicts or if you want to modify more
      # be careful here, if you rewrite history too much
      # you will end up in Back to the Future II
      # Luckly you can do git rebase --abort
git commit --amend $files #(alternatively, git add $files first then git commit --amend
git rebase --continue
git push -f # I think you will need to add remote+branch, git will remind you
# go on with your life
```


Note: A squash is gonna put all of the commits together, just make sure that there's an order:

## I lied, here's a very quick and dirty squash guide

* pick COMMIT1
* pick COMMIT2
* squash COMMIT3 # (Git will combine this commit, with the one above iir, so COMMIT2+COMMIT3 and git will ask you for a new commit message) 

![I lied](https://media.giphy.com/media/11CCn8sSFSm2kg/giphy.gif)
