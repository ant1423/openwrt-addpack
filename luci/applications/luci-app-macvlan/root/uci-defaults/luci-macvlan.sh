#!/bin/sh

uci -q batch <<-EOF >/dev/null
	delete ucitrack.@macvlan[-1]
	add ucitrack macvlan
	set ucitrack.@macvlan[-1].init=macvlan
	commit ucitrack
EOF

chmod 755 /bin/genwancfg
chmod 755 /bin/pppconnectcheck
chmod 755 /etc/init.d/macvlan
chmod 755 /etc/init.d/ppp_syncdiag

/etc/init.d/macvlan enable

rm -f /tmp/luci-indexcache
exit 0
