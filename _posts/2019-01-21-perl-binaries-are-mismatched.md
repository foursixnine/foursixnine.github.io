---
layout: post
title: About Perl and mismatched binaries
categories:
- blog
---

# The horror

You happen to update your system (In my case, I use Tumbleweed or Gentoo) and there's new version of Perl,
at some point there's the realization that you're using [local::lib](https://metacpan.org/pod/local::lib), and
the pain unfolds: A shell is started, and you find a dreaded:

```perl
Cwd.c: loadable library and perl binaries are mismatched (got handshake key 0xdb00080, needed 0xdb80080)
```

Which means: that the module (Cwd in this case) is not compatible (Because it's an [XS module](http://modernperlbooks.com/mt/2009/05/perl-5-and-binary-compatibility.html))
with your current version of perl, installed on your system: Likely it was compiled for a previous version, leadin to those [binaries mismatching](https://rt.perl.org/Public/Bug/Display.html?id=133440)

## Don't panic!

In the past, I used to reinstall my full local::lib directory, however after hanging out and asking few questions on #toolchain on irc.perl.org, I got to write (or rather hack, an ugly hack) a
quick perl script to walk the [local::lib](https://github.com/foursixnine/stunning-octo-chainsaw/blob/master/ll-walker.pl) packages that were installed already, only looking at the specified
directory... it worked well, gave me the list of what I needed so I could reinstall later, however Grinnz pointed me to his [perl-migrate-modules](https://bit.ly/2CwLXvb) script, to which after chatting a bit,
he added the `from` switch, which allows people to reinstall all the modules that were present in an old local::lib directory:

## The light

```
# Migrate modules from an old (inactive) local::lib directory
$ perl-migrate-modules --from ~/perl5-old/lib/perl5 /usr/bin/perl
```

Hope you find it useful :)
