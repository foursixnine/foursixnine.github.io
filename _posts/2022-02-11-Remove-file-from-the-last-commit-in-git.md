---
layout: post
title: Remove file from the last commit in git
categories:
- blog
- tech
- linux
- git
generated on: 2022-02-11
---
* So, you want to remove that pesky file from your last commit?
* By accident (naturally, as you and me are perfect beings) a file was commited and it should have not?
* The cat went over the keyboard and now there's an extra file in your commit?

If the answer to any of the above is yes, here's how to do it without pain (Tanking into account, that you want to do
that on the last commit; If you need to do it in the middle of a rebase, see the previous post or combine this trick
with a rebase (edit a commit with a rebase...).

`git restore --source=HEAD^ pesky.file`

You can always checkout the file again, or use some witchcraft extracted from `man git-restore` to do it all at once

This is blatantly stolen from: https://devconnected.com/how-to-remove-files-from-git-commit/ but also `man git`
could get you there too, given enough reading.
