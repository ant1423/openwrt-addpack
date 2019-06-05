#!/bin/sh

uci -q batch <<-EOF >/dev/null
	delete ucitrack.@automemc[-1]
	add ucitrack automemc
	set ucitrack.@automemc[-1].init=automemc
	commit ucitrack
EOF

chmod 755 /etc/init.d/automemc
chmod 755 /usr/sbin/automemc

/etc/init.d/automemc enable

rm -f /tmp/luci-indexcache
exit 0
