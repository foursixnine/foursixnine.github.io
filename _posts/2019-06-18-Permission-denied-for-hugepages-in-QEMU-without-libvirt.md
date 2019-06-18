---
layout: post
title: Permission denied for hugepages in QEMU without libvirt
categories:
- blog
generated on: 2019-06-18
---

So, say you're running qemu, and decided to use hugepages, nice isn't it? helps with performace and stuff, however
a wild wall appears!

```
 QEMU: qemu-system-aarch64: can't open backing store /dev/hugepages/ for guest RAM: Permission denied
```

This basically means that you're using the amazing *-mem-path /dev/hugepages*, and that QEMU running as an unprivileged user can't
write there... This is how it looked for me:

```
sudo -u _openqa-worker qemu-system-aarch64 -device virtio-gpu-pci -m 4094 -machine virt,gic-version=host -cpu host \ 
  -mem-prealloc -mem-path /dev/hugepages -serial mon:stdio  -enable-kvm -no-shutdown -vnc :102,share=force-shared \ 
  -cdrom openSUSE-Tumbleweed-DVD-aarch64-Snapshot20190607-Media.iso \ 
  -pflash flash0.img -pflash flash1.img -drive if=none,file=opensuse-Tumbleweed-aarch64-20190607-gnome-x11@aarch64.qcow2,id=hd0 \ 
  -device virtio-blk-device,drive=hd0
```

The machine tries to start, but utimately I get that dreadful message. 
You can simply do a chmod to the directory, use an udev rule, and get away with it, it's quick and does the job but also
there are few options to solve this using libvirt, however if you're not using [hugeadm](https://linux.die.net/man/8/hugeadm) 
to manage those pools and let the operating system take care of it, likely the operating system will take care of this for you,
so you can look to `/usr/lib/systemd/system/dev-hugepages.mount`, since trying to add an udev rule failed for a colleague of mine,
I decided to use the systemd approach, ending up with the following:

```

[Unit]
Description=Systemd service to fix hugepages + qemu ram problems.
After=dev-hugepages.mount

[Service]
Type=simple
ExecStart=/usr/bin/chmod o+w /dev/hugepages/

[Install]
WantedBy=multi-user.target
```
