#!/bin/sh
#
#    /etc/hotplug.d/block/20-samba-hotplug
#
# Set access the mounted device with read-write or read-only permission
FS_READONLY=0  # <0|1  0-Read Write, 1-Read Only>

MOUNT_POINTS=/tmp/mount_points

blkid="/usr/sbin/blkid"
grep="/bin/grep"
mount="/bin/mount"
umount="/bin/umount"
samba="/etc/init.d/samba"
uci="/sbin/uci"

. /lib/functions.sh

mount_extdisk() {
	local mount_opts=""
	local fs_type=`expr "$blk_info" : '.*TYPE="\([^"]*\)'`
	local acs
	[ -n "$fs_type" ] || return 1
	[ -d "$mountpoint" ] || mkdir -p "$mountpoint"
	[ $FS_READONLY -eq 1 ] && acs="ro" || acs="rw"

	case "$fs_type" in
		 ext[234]|xfs|reiserfs) # tested
                    if `grep -vs '^nodev' /proc/filesystems | grep -qs "$fs_type"` ; then
                        mount_opts="-t $fs_type -o ${acs},async,noatime"
                    fi
                    ;;
                iso9660|udf) # tested
                    if `grep -vs '^nodev' /proc/filesystems | grep -qs "$fs_type"` ; then
                        mount_opts="-t $fs_type -o ro"
                    fi					;;
                exfat|vfat|msdos) # tested
                    if `grep -vs '^nodev' /proc/filesystems | grep -qs "$fs_type"` ; then
                        mount_opts="-t $fs_type -o ${acs},umask=000,codepage=65001,iocharset=utf8,async,noatime"
                    fi
                    ;;
                ntfs)
                    if `grep -vs '^nodev' /proc/filesystems | grep -qs "ufsd"` ; then
                        mount_opts="-t ufsd -o ${acs},async,noatime"
		    elif `which mount.ntfs-3g >/dev/null`; then
			mount_opts="-t ntfs-3g -o ${acs},big_writes,umask=000,async,noatime"
                    fi
                    ;;
                *)
                    return 1
                    ;;
	esac

	if $mount $device $mountpoint $mount_opts; then
		chown nobody:nogroup "$mountpoint"
		chmod 0777 "$mountpoint"
		return 0
	fi

	rmdir "$mountpoint"
	return 1
}

umount_extdisk() {
	[ -e "$device" ] && $umount "$device"
	[ -d "$mountpoint" ] && rmdir "$mountpoint"
	sed -i "/$name:/d" $MOUNT_POINTS
}

uci_set_samba(){
	local field="$1"
	local section="$2"
	$uci -q batch << EOF
set ${field}.${section}="sambashare"
set ${field}.${section}.ident="${section}"
set ${field}.${section}.name="Disk_${name}"
set ${field}.${section}.path="${mountpoint}"
set ${field}.${section}.read_only="no"
set ${field}.${section}.guest_ok="yes"
set ${field}.${section}.create_mask="0777"
set ${field}.${section}.dir_mask="0777"
commit ${field}
EOF
}

uci_delete_samba() {
	local field="$1"
	local section="$2"
	$uci -q batch << EOF
delete ${field}.${section}
commit ${field}
EOF
}

configure_samba() {
	[ -d "$mountpoint" ] || return 1

	local samba="samba"
	local uuid=`expr "$blk_info" : '.*UUID="\([^"]*\)'`
	local section="`echo $uuid | sed 's/-//g'`"
	case $1 in
		add)
			uci_set_samba "$samba" "$section"
		;;
		remove)
			uci_delete_samba "$samba" "$section"
		;;
		*)
			return 1
		;;
	esac
	sleep 1
	$samba restart
	return 0
}

name=`basename "$DEVPATH"`

touch $MOUNT_POINTS
case "$ACTION" in
	add)
		case "$name" in
			[shm]d[a-z]*|mmcblk*) ;;  
			*) exit ;;
		esac
		device="/dev/$name"
		mountpoint="/mnt/$name"
		blk_info=`$blkid "$device"`
	
		if mount_extdisk; then
			echo "$blk_info" >> $MOUNT_POINTS
			configure_samba "$ACTION"
			hdparm -S 120 $device
		fi
	;;
	remove)
		case "$name" in
			[shm]d[a-z]*|mmcblk*) ;;  
			*) exit ;;
		esac
		device="/dev/$name"
		mountpoint="/mnt/$name"
		blk_info=`$grep "$device:" $MOUNT_POINTS`

		if configure_samba "$ACTION"; then
			umount_extdisk
		fi
	;;
esac
