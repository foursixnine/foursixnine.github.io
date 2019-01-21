---
layout: post
title: Open Build Service- Contributing on a project
categories:
- blog
generated on: 2019-01-21
---

Here at SUSE we heavily use [Open Build Service](http://openbuildservice.org),
and often while collaborating on a project (In my case, [openQA](https://openqa.opensuse.org)) one has to add a new package
as a dependency from time to time, or has to do a backport for an older SLE or openSUSE Leap release

It boils down to the following steps, in this case I wanted to change the project to build against
SUSE:SLE-12-SPX:Update instead of SUSE:SLE-12-SPX:GM which is a [build target](https://en.opensuse.org/openSUSE:Build_Service_supported_build_targets) that will get the updates while the GM doesn't,
all this, because I wanted to add openvswitch to the project, so that we could use new features in our openQA deployments.

To do this, after setting up the obs account, it boils down to:

1- Branch your project
2- [Link](https://en.opensuse.org/openSUSE:Build_Service_Concept_project_linking) your packages
2- Modify the project metadata if needed
3- Modify the project config if errors related to multiple choices appear (PostgreSQL will be there for sure!)
4- Grab a cup of coffee/tea/water and do [some reading](https://en.opensuse.org/openSUSE:Build_Service_Tips_and_Tricks) while waiting for the build 

```bash
# Branch the project
osc branch devel:openQA:SLE-12

# Link the new package
osc linkpac openSUSE:Factory  openvswitch
# More and more packages will say that their dependencies cannot be resolved, this is
# you might spend some time here adding bunch of dependencies :)
osc linkpac openSUSE:Factory  dpdk devel:openQA:SLE-12
osc linkpac openSUSE:Factory  python-six devel:openQA:SLE-12
```

By this point you might get error messages on the webUI stating that:

```
$a_package: have choice for $conflicting_package needed by $a_package: $options
```

As an example, it might happen that you see postgres-server there, having
postgres96-server and postgres94-server as `$options`, you've got to choose
your destiny!.

When you find this, it's time to edit the project configuration:
```
# Since
osc meta prjconf devel:openQA:SLE-12 -e
# An editor will open and you will be able to change stuff
# Remember that you need write permissions on the project!
...
Prefer: postgresql96-devel
Prefer: postgresql96-server
Prefer: python-dateutil
...

```

Modify the project metadata to use :Updates instead of :GM, and change architectures
if you need to do so.

```xml
# same as before: An editor will open, and you will be able to edit stuff
 osc meta prjconf devel:openQA:SLE-12 -e
  <repository name="SLE_12_SP4">
    <path project="SUSE:SLE-12-SP4:Update" repository="standard"/>
     <arch>x86_64</arch>
    <arch>aarch64</arch>
    <arch>ppc64le</arch>
  </repository>
```
After this, a project rebuild will take place, sit down and give some more reading :)
