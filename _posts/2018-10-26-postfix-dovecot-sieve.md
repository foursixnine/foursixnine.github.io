---
layout: post
title: Setting up postfix, dovecot and sieve
categories:
- blog
---

# The horror
While trying to set up my mail system, I ran into multiple tutorials to figure
out what was the best way to avoid multiple error messages, mainly because you,
like me (you silly human!), simply copy and pasted random stuff from stack 
overflow, and tutorials in howtoforge and places like that... 

## The mistakes
You tried something like this

```
spamassassin unix - n n - - pipe flags=DROhu user=vmail argv=/usr/bin/spamc -e /usr/lib/dovecot/deliver -f ${sender} -d ${user}@${nexthop} 
```

or this:

```
mailbox_transport = lmtp:unix:private/lmtp
virtual_transport = lmtp:unix:private/lmtp
```

## The pain
so you ended up with something that looks similar to this:

```
Oct 24 01:13:24 nergal postfix/pipe[10207]: fatal: get_service_attr: unknown username: vmail
Oct 24 01:13:25 nergal postfix/master[10104]: warning: process /usr/lib/postfix/bin//pipe pid 10207 exit status 1
Oct 24 01:13:25 nergal postfix/qmgr[10106]: warning: private/spamassassin socket: malformed response
Oct 24 01:13:25 nergal postfix/master[10104]: warning: /usr/lib/postfix/bin//pipe: bad command startup -- throttling
Oct 24 01:13:25 nergal postfix/qmgr[10106]: warning: transport spamassassin failure -- see a previous warning/fatal/panic logfile record for the problem description
```

## Resignation

So what worked for me was to leave the service in the master.cf as I had it working... 

and simply add to master.cf

```
spamassassin unix - n   n - - pipe flags=R     user=app argv=/usr/bin/spamc -e /usr/sbin/sendmail -oi -f ${sender} ${recipient}
```

and in the main.cf

```
mailbox_command = /usr/lib/dovecot/deliver
```

## The light

Sieve filtering started to work after these changes :)

* Check [This article](https://www.vultr.com/docs/simple-mailserver-postfix-dovecot-sieve-centos-7)
that gave me that life saving line
