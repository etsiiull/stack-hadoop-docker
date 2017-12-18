#!/bin/bash

/sbin/ldconfig &
#/usr/sbin/sssd &
#service nscd start &
#/etc/init.d/ssh start
/usr/sbin/sshd -D

