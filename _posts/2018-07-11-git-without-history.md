---
layout: post
title: Merge two git repositories
categories:
- blog
- tech
tags:
- git
- tips
---

I just followed this [medium post](https://medium.com/@spences10/git-allow-unrelated-histories-a39a3814b981), but long story short:

Check out the origin/master branch and make sure my local master, is equal to
origin, then push it to my fork (I seldomly do git pull on master).

```bash
 git fetch origin
 git checkout master
 git reset --hard origin/master
 git push foursixnine
```

I needed to add the remote that belongs to a complete different repository:

```bash
 git remote add acarvajal gitlab@myhost:acarvajal/openqa-monitoring.git
 git fetch acarvajal
 git checkout -b merge-monitoring
 git merge acarvajal/master --allow-unrelated-histories
```

Tadam! my changes are there!

Since I want everything inside a specific directory:

```bash
 mkdir openqa/monitoring
 git mv ${allmyfiles} openqa/monitoring/
```

Since the unrelated repository had a README.md file, I need to make sure that
both of them make it into the cut, the one from my original repo, and the other
from the new unrelated repo:

Following command means: checkout README.md from acarvajal/master.

```bash
 git checkout acarvajal/master --  README.md
 git mv README.md openqa/monitoring/
```

Following command means: checkout README.md from origin/master.

```bash
 git checkout origin/master --  README.md
```

Commit changes, push to my fork and open pull request :)

```bash
 git commit
 git push foursixnine
```
