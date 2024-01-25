---
layout: post
title: Testing kernels with sporadic issues until heisenbug shows in openQA
categories:
- blog
- linux
- tech
- qualityassurance
- openqa
generated on: 2024-01-25
---

This is a follow up to my previous post about [How to test things with openQA without running your own instance](/blog/linux/tech/qualityassurance/2021/06/18/How-to-test-things-with-openQA-without-running-your-own-instance), so you might want to read that first.

Now, while hunting for [bsc#1219073](https://bugzilla.suse.com/show_bug.cgi?id=1219073) which is quite sporadic, and took quite some time to show up often enough so that
became noticeable and traceable, once stars aligned and managed to find a way to get a higher failure rate,
I wanted to have a way for me and for the developer to test the kernel with the different patches to help with the bisecting
and ease the process of finding the culprit and finding a solution for it.

I came with a fairly simple solution, using the `--repeat` parameter of the openqa-cli tool, and a simple shell script to run it:
```bash
```bash
$ cat ~/Downloads/trigger-kernel-openqa-mdadm.sh
# the kernel repo must be the one without https; tests don't have the kernel CA installed
KERNEL="KOTD_REPO=http://download.opensuse.org/repositories/Kernel:/linux-next/standard/"

REPEAT="--repeat 100" # using 100 by default
JOBS="https://openqa.your.instan.ce/tests/13311283 https://openqa.your.instan.ce/tests/13311263 https://openqa.your.instan.ce/tests/13311276 https://openqa.your.instan.ce/tests/13311278"
BUILD="bsc1219073"
for JOB in $JOBS; do 
	openqa-clone-job --within-instance $JOB CASEDIR=https://github.com/foursixnine/os-autoinst-distri-opensuse.git#tellmewhy ${REPEAT} \
		_GROUP=DEVELOPERS ${KERNEL} BUILD=${BUILD} FORCE_SERIAL_TERMINAL=1\
		TEST="${BUILD}_checkmdadm" YAML_SCHEDULE=schedule/qam/QR/15-SP5/textmode/textmode-skip-registration-extra.yaml INSTALLONLY=0 DESKTOP=textmode\
		|& tee jobs-launched.list;
done;
```

There are few things to note here:
- the kernel repo must be the one without https; tests don't have the CA installed by default.
- the `--repeat` parameter is set to 100 by default, but can be changed to whatever number is desired.
- the `JOBS` variable contains the list of jobs to clone and run, having all supported architecures is recommended (at least for this case)
- the `BUILD` variable can be anything, but it's recommended to use the bug number or something that makes sense.
- the `TEST` variable is used to set the name of the test as it will show in the test overview page, you can use `TEST+=foo` if you want to append text instead of overriding it, the `--repeat` parameter, will append a number incrementally to your test, see [os-autoinst/openQA#5331](https://github.com/os-autoinst/openQA/pull/5331) for more details.
- the `YAML_SCHEDULE` variable is used to set the yaml schedule to use, there are other ways to modify the schedule, but in this case I want to perform a full installation

### Running the script

- Ensure you can run at least the openQA client; if you need API keys, see post linked at the beginning of this post
- replace the kernel repo with your branch in line 5
- run the script `$ bash trigger-kernel-openqa-mdadm.sh` and you should get the following, times the `--repeat` if you modified it

```
1 job has been created:
 - sle-15-SP5-Full-QR-x86_64-Build134.5-skip_registration+workaround_modules@64bit -> https://openqa.your.instan.ce/tests/13345270
```
Each URL, will be a job triggered in openQA, depending on the load and amount of jobs, you might need to wait quite a bit (some users can help moving the priority of these jobs so it executes faster)

## The review stuff:

### Looking at the results

- Go to https://openqa.your.instan.ce/tests/overview?distri=sle&build=bsc1219073&version=15-SP5 or from any job from the list above click on `Job groups` menu at the top, and select `Build bsc1219073`
- Click on "Filter"
- type the name of the test module to filter in the field *Module name*, e.g `mdadm`, and select the desired result of such test module e.g `failed` (you can also type, and select multiple result types)
- Click Apply
- The overall summary of the build overview page, will provide you with enough information to calculate the pass/fail rate. 

A rule of thumb: anything above 5% is bad, but you need to also understand your sample size + the setup you're using; YMMV.

### Ain't nobody got time to wait

The script will generate a file called: `jobs-launched.list`, in case you absolutely need to change the priority of the jobs, set it to 45, so it runs higher than default priority, which is 50
`cat jobs-launched.list | grep https | sed -E 's/^.*->\s.*tests\///' | xargs -r -I {} bash -c "openqa-cli api --osd -X POST jobs/{}/prio prio=45; sleep 1"`

## The magic

The actual magic is in the schedule, so right after booting the system and setting it up, before running the mdadm test, I inserted the `update_kernel` module, which will add the kernel repo specified by KOTD_REPO, and install the kernel from there, reboot the system, and leave the system ready for the actual test,
however I had to add very small changes:

```diff
---
 tests/kernel/update_kernel.pm | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/kernel/update_kernel.pm b/tests/kernel/update_kernel.pm
index 1d6312bee0dc..048da593f68f 100644
--- a/tests/kernel/update_kernel.pm
+++ b/tests/kernel/update_kernel.pm
@@ -398,7 +398,7 @@ sub boot_to_console {
 sub run {
     my $self = shift;
 
-    if ((is_ipmi && get_var('LTP_BAREMETAL')) || is_transactional) {
+    if ((is_ipmi && get_var('LTP_BAREMETAL')) || is_transactional || get_var('FORCE_SERIAL_TERMINAL')) {
         # System is already booted after installation, just switch terminal
         select_serial_terminal;
     } else {
@@ -476,7 +476,7 @@ sub run {
         reboot_on_changes;
     } elsif (!get_var('KGRAFT')) {
         power_action('reboot', textmode => 1);
-        $self->wait_boot if get_var('LTP_BAREMETAL');
+        $self->wait_boot if (get_var('FORCE_SERIAL_TERMINAL') || get_var('LTP_BAREMETAL'));
     }
 }
 
```

Likely I'll make a new pull request to have this in the test distribution, but for now this is good enough to help kernel developers
to do some self-service and trigger their own openQA tests, that have many more tests (hopefully in parallel) and faster than if there
was a person doing all of this manually.

Special thanks to the QE Kernel team, who do the amazing job of thinking of some scenarios like this, because they save a lot
of time.
