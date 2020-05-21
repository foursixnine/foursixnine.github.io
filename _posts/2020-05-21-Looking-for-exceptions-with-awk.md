---
layout: post
title: Looking for exceptions with awk
categories:
- blog
- linux
- tech

generated on: 2020-05-21
---
Sometimes you just need to search using awk or want to use plain bash to search for an exception in a log file, it's
hard to go into google, stack overflow, duck duck go, or any other place to do a search, and find nothing, or at least
a solution that fits your needs. 

In my case, I wanted to know where a package was generating a conflict [for a friend](https://github.com/os-autoinst/os-autoinst-distri-opensuse/pull/10259/files#diff-141f4b5a48eaecb0c631a0de23e41a51R503), and ended up scratching my head,
because I didn't want to write yet another domain specific function to use on the test framework of openQA, and I'm
very stubborn, I ended up with the following solution


```
journalctl -k | awk 'BEGIN {print "Error - ",NR; group=0}
/ACPI BIOS Error \(bug\)/,/ACPI Error: AE_NOT_FOUND/{ print group"|", 
	$0; if ($0 ~ /ACPI Error: AE_NOT_FOUND,/ ){ print "EOL"; group++ }; 
}'
```

This is short for:

  * Define `$START_PATTERN as /ACPI BIOS Error \(bug\)/,` and `$END_PATTERN as /ACPI Error: AE_NOT_FOUND/`
  * Look for `$START_PATTERN`
  * Look for `$END_PATTERN`
  * If you find `$END_PATTERN` add an `EOL` marker (that is not needed, since the group variable will be incremented)

And there you go: How to search for exceptions in logs, of course it could be more complicated, because you can have nested
cases and whatnot, but for now, this does exactly what I need:

```
EOL
10| May 20 12:38:36 deimos kernel: ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.LPCB.HEC.CHRG], AE_NOT_FOUND (20200110/psargs-330)
10| May 20 12:38:36 deimos kernel: ACPI Error: Aborting method \PNOT due to previous error (AE_NOT_FOUND) (20200110/psparse-529)
10| May 20 12:38:36 deimos kernel: ACPI Error: Aborting method \_SB.AC._PSR due to previous error (AE_NOT_FOUND) (20200110/psparse-529)
10| May 20 12:38:36 deimos kernel: ACPI Error: AE_NOT_FOUND, Error reading AC Adapter state (20200110/ac-115)
EOL
11| May 20 12:39:12 deimos kernel: ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.LPCB.HEC.CHRG], AE_NOT_FOUND (20200110/psargs-330)
11| May 20 12:39:12 deimos kernel: ACPI Error: Aborting method \PNOT due to previous error (AE_NOT_FOUND) (20200110/psparse-529)
11| May 20 12:39:12 deimos kernel: ACPI Error: Aborting method \_SB.AC._PSR due to previous error (AE_NOT_FOUND) (20200110/psparse-529)
11| May 20 12:39:12 deimos kernel: ACPI Error: AE_NOT_FOUND, Error reading AC Adapter state (20200110/ac-115)
EOL
12| May 20 13:37:41 deimos kernel: ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.LPCB.HEC.CHRG], AE_NOT_FOUND (20200110/psargs-330)
12| May 20 13:37:41 deimos kernel: ACPI Error: Aborting method \PNOT due to previous error (AE_NOT_FOUND) (20200110/psparse-529)
12| May 20 13:37:41 deimos kernel: ACPI Error: Aborting method \_SB.AC._PSR due to previous error (AE_NOT_FOUND) (20200110/psparse-529)
12| May 20 13:37:41 deimos kernel: ACPI Error: AE_NOT_FOUND, Error reading AC Adapter state (20200110/ac-115)
EOL
```

So I could later write some code that looks per string, separates the string using the pipe `|` discards the group id, and adds that record to an array
of arrays or hashes: `[ {group: id, errors: [error string .. error string] ]`
