---
layout: post
title: Table to json with jq and awk
categories:
- blog
generated on: 2019-05-08
---

## The problem

Say you have a table that looks like this:

```
AGGREGATE_NEEDED    1
ARCH    x86_64
BASE_TEST_ISSUES    NUMBER
BUILD   :NUMBER:PACKAGE
DISTRI  DISTRIBUTION
FLAVOR  Server-DVD-Incidents-Install
INCIDENT_ID 99999
```
It's just that it contains about 78 or more entries. Of course for a very skilled engineer or a person with
a lot of tricks under the hood, this might be a very trivial task in vim or something like this, I guess that
with a couple of replaces here and there, you'd get somewhere; but I'm not skilled, other than at eating.

## The Solution

So I took my Key Value table saved it to a file and after googling a bit, now I'm more versed into awk :D:

```
    cat FILE.txt | \ 
    awk 'BEGIN { print "{" } \ 
        { printf "\"%s\":\"%s\",", $1,$2} \ 
        END { print "\"MANUALLY_GENERATED_ISO_POST\":1 }" }'
        | jq > x86_64-ready.json'"}'
```

I guess this could have been done easier and prettier, but fits my need and might save you too at some point.
Just make sure you have `jq` installed ok?
