---
layout: post
title: Introducing pass-exporter - Export your passwords from pass to bitwarden csv format
categories:
- blog
- security
- software
generated on: 2026-02-19
---

This is a rudimentary attempt (that surprisingly works) to export passwords from [pass](https://www.passwordstore.org) to Bitwarden  [csv format](https://bitwarden.com/help/condition-bitwarden-import/)

As a requisite you need to have the private key that protects the passwords, exported as an ASCII armored key (Or whatever the nomenclature is), the important bit is that you export it:

`gpg --export-secret-keys --armor $YOURFINGERPRINT > private-key.asc`

To run simply run, you need to clone the sources from the [git repo](https://github.com/foursixnine/pass-exporter) and inside the directory run:

```
go run . --private-key private-key.asc --identity alice@example.com
```

Alternatively you can build it and then run it (Sky is the limit)

You can check usage too by passing `--help`, It runs fairly fast, and in the end up with a `pass_exported_passwords.csv` (again see program help for defaults).

A feature that I'd like to add is a support for user plugins, to i.e check if an otp token is duplicated, or if a password is being reused, but that's for the future

As usual PRs are welcome, specially for adding tests.

PS: "Maybe" I fix the program to be able to be installed via `go install $foo` (or somebody submits a PR :D)

[https://github.com/foursixnine/pass-exporter](https://github.com/foursixnine/pass-exporter) 
