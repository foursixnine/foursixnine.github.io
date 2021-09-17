---
layout: post
title: So you want to recover and old git branch because it has been overwritten?
categories:
- blog
- linux
- tech
- git

generated on: 2021-09-17
---
## So you just broke that PR you've been working on for months?

One day, you find yourself force pushing over your already existing Pull request/branch, because like me, you like to
reuse funny names:

```
git fetch origin
git checkout tellmewhy #already exists and has a pull request still open, but you didn't know
git reset --hard origin/master
# hack hack hack
git commit $files
git push -f nameofmyremote
```

![panic](https://giphy.com/media/panic-P4133zeloooHm/giphy.gif)

## Panic!

Here's when you realize that You've done something wrong, very very wrong, because github will throw the message:

```
Error creating pull request: Unprocessable Entity (HTTP 422)
A pull request already exists for foursixnine:tellmewhy.
```

So, you already broke your old PR with a completely unrelated change, 

![what do you do?](https://giphy.com/media/cjWY3shtuKyfX5VeB1/giphy.gif)

## Don't panic
![don't panic](https://media.giphy.com/media/MEM0K35P4iC70rCNSo/giphy.gif)

If you happen to know what's the previous commit id, you can always pick it up again (go to github.com/pulls for instance and look for the PR with the branch),
AND, AND, AAANDDDD, ABSOLUTELY ANDDDD, you haven't ran `git gc`.

In my case:

__@foursixnine foursixnine force-pushed the tellmewhy branch from 9e86f3a to **9714c93** 2 months ago__

All there's to do is:

```
git checkout $commit
# even better:
git checkout tellmewhy # old branch with new commits that are unrelated/overwritten over the old ones
git checkout -b tellmewhyagain # your new copy, open your pr from here
git push tellmewhyagain # now all is "safe" in the cloud
git checkout tellmewhy # Let's bring the dead back to life
git reset --hard 9714c93
git push -f tellmewhy
```

And this is it, you've brought the dead back to life

![](https://media.giphy.com/media/l2YWAOJso1n136fM4/giphy.gif)
