#!/bin/bash

# Simple Bash script for chroot from a live distribution (I used ubuntu)
# in case you need to recovery your installation.
# Copyright (c) 2013 Gabriele Baldoni gabriele.baldoni(_at_)gmail.com


if [ `id -u` -eq 0 ]; then
	if [ $# -ne 2 ]; then
		printf "Usage: sudo ./chroot_from_live.sh [mount folder] [device]\n"
		printf "The script will create itself the mount directory into /mnt/\n"
		exit 1
	else
		#need to turn echo off here
		mountpoint=$1
		device=$2
		rmdir /mnt/$mountpoint
		mkdir /mnt/$mountpoint 
		mount /dev/$device /mnt/$mountpoint
		mount -t sysfs none /mnt/$mountpoint/sys
		mount -t proc none /mnt/$mountpoint/proc
		mount --bind /dev/ /mnt/$mountpoint/dev
		mount --bind /etc/resolv.conf /mnt/$mountpoint/etc/resolv.conf
		#and to turn echo on here
		chroot /mnt/$mountpoint
		exit 0

	fi

else
  printf "Run this as root!!!\n" 
  exit 1
fi

