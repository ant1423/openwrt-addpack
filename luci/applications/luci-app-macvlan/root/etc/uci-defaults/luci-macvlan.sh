#!/bin/sh

uci -q batch <<-EOF >/dev/null
          delete ucitrack.@macvlan[-1]
          add ucitrack macvlan
          set ucitrack.@macvlan[-1].init=macvlan
          commit ucitrack
EOF

/etc/init.d/macvlan enable

rm -f /tmp/luci-indexcache
exit 0
