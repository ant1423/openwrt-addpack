local s, m, o

m = Map("pdnsd")
s = m:section(TypedSection, "server", translate("pdnsd") .. ": " .. translate("server Section"))
s.anonymous = true
s.addremove = false
s.rmempty = false

--[[
config server
	option label 'openwrt'
	#option ip   '114.114.114.114'
	option port  '53'
	option file  '/etc/ppp/resolv.conf'
	#option uptest 'none'
	option timeout 10
	option uptest  none
	option purge_cache 0
	option edns_query 1
]]--

o = s:option(Value, "label", translate("Label"))
o.placeholder = "openwrt"
o.rmempty = true
o.default = "openwrt"

o = s:option(Value, "ip", translate("DNS Server IP"), translate("DNS Server IP desc"))
o.rmempty = true
o.default = ""
o.optional = false
o:value("8.8.8.8,8.8.4.4", translate("Google public DNS"))
o:value("208.67.222.222,208.67.220.220", translate("OpenDNS"))
o:value("114.114.114.114,114.114.115.115", translate("114DNS"))
o:value("223.5.5.5,223.6.6.6", translate("AliDNS"))
o:value("180.76.76.76", translate("BaiduDNS"))

o = s:option(Value, "port", translate("DNS Server Port"), translate("DNS Server Port desc"))
o.datatype = "uinteger"
o.placeholder = "53"
o.rmempty = true
o.default = ""

o = s:option(Value, "file", translate("resolv.conf"), translate("resolv.conf desc"))
o.rmempty = true
o.default = ""
o.optional = false
o:value("/var/resolv.conf.auto")
o:value("/etc/ppp/resolv.conf")

o = s:option(Value, "timeout", translate("Timeout"), translate("Timeout desc"))
o.datatype = "uinteger"
o.placeholder = "120"
o.rmempty = true
o.default = "120"

o = s:option(Flag, "purge_cache", translate("Purge Cache"))
o.rmempty = false
o.default = false

o = s:option(Flag, "edns_query", translate("EDNS Query"), translate("EDNS Query desc"))
o.rmempty = false
o.default = true

return m

