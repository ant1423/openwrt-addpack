#!/bin/sh

uci -q batch <<-EOF >/dev/null
	delete ucitrack.@macvlan[-1]
	add ucitrack macvlan
	set ucitrack.@macvlan[-1].init=macvlan
	commit ucitrack
EOF

chmod 755 /usr/sbin/mwan3
chmod 755 /usr/sbin/mwan3track
chmod 755 /etc/hotplug.d/iface/16-mwancustom
chmod 755 /etc/hotplug.d/iface/16-mwancustombak

rm -f /tmp/luci-indexcache
exit 0
