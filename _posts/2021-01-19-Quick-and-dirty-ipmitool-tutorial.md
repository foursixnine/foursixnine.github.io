---
layout: post
title: Quick and dirty ipmitool tutorial
categories:
- blog
generated on: 2021-01-19
---
# Because I always forget

## To reboot a SUPERMICRO server:

Just remember that the default user/password might still be ADMIN/ADMIN :)

ipmitool -I lanplus -H $HOST -U USER -P PASSWORD power cycle

## To connect to  the serial console

ipmitool -I lanplus -H $HOST -U USER -P PASSWORD sol activate

