---
layout: post
title: Cron do not send me empty emails
categories:
- blog
- linux
generated on: 2021-01-26
---
Just in case, if you've ever wondered how to stop `cron` from sending empty emails, a quick look at `man mail` will give
you the answer you're looking for (if you know what you're searching for):

```
    -E

    If an outgoing message does not contain any text in its first or only message part, do not send it but discard it silently,
    effectively setting the skipemptybody variable at program startup. This is useful for sending messages from scripts started 
    by cron(8).
```

I got this after visiting couple of forums, and some threads at stack exchange, however [this one](https://stackoverflow.com/a/14656511) nailed it

So all you need to do is, fire up that `crontab -e` and make your script run every five minutes, without fear of the noise

```
*/5 * * * * /usr/local/bin/only-talk-if-there-are-errors-script |& mail -E -r $(hostname)@opensuse.org -s "[CRON][monitoring] foo bar $(date  --iso-8601='minutes')"  do-not-spam-me@example.com
```

*Et voilà, ma chérie!*
![It's alive!](https://media.giphy.com/media/xT5LMDi8H2A1FtLlpC/giphy.gif)

