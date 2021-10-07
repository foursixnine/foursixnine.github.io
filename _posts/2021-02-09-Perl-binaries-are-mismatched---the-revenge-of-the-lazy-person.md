---
layout: post
title: Perl binaries are mismatched - the revenge of the lazy person
categories:
- blog
- linux
- perl
generated on: 2021-02-09
---
# The uninvited eldrich terror

You use [local::lib](https://metacpan.org/pod/local::lib), and the pain unfolds: A shell is started, and you find a dreaded:

```perl
Cwd.c: loadable library and perl binaries are mismatched (got handshake key 0xdb00080, needed 0xdb80080)
```

![Pennywise, because I could not find the right gif, from the Uninvited, of Sabrina's netflix](https://media.giphy.com/media/CiJGnsh7wWXv2/giphy.gif)

Which means: that the module (Cwd in this case) is not compatible (Because it's an [XS module](http://modernperlbooks.com/mt/2009/05/perl-5-and-binary-compatibility.html))
with your current version of perl, installed on your system: Likely it was compiled for a previous version, leadin to those [binaries mismatching](https://rt.perl.org/Public/Bug/Display.html?id=133440)

## Don't panic!

I [wrote about this](/blog/2019/01/21/perl-binaries-are-mismatched.html) however, I left out how to get to the point where you have already an usable Perl again?

## The light

Instead of downloading local::lib from git as I used to do... this time I decided to do it on a much simpler way: use `perl-local-lib` from my distribution, and let it do the magic, I mean
that's why I run [openSUSE Tumbleweed](https://get.opensuse.org)

```
 zypper in perl-local-lib
 rm -rf perl5-old || echo "First time eh?"
 mv perl5 perl5-old
 perl -MCPAN -Mlocal::lib -e 'CPAN::install(App::cpanminus)'
 cpanm App::MigrateModules
 perl-migrate-modules --from ~/perl5-old/lib/perl5 /usr/bin/perl
```

Et voilà, ma chérie!

![It's alive!](https://media.giphy.com/media/xT5LMDi8H2A1FtLlpC/giphy.gif)
