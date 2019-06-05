local s, m, o

m = Map("pdnsd")
s = m:section(TypedSection, "pdnsd", translate("pdnsd") .. ": " .. translate("global Section"))
s.anonymous = true
s.addremove = false
s.rmempty = false

--[[
config pdnsd
	option server_ip any
	option server_port 5353
	option perm_cache 2048
	option cache_dir '/var/pdnsd'
	option run_as 'nobody'
	option status_ctl 1
	option query_method udp_tcp
	option min_ttl 1w
	option max_ttl 2w
	option timeout 10
	option udpbufsize 1024
]]--

o = s:option(Flag, "status_ctl", translate("Status Control"), translate("Status Control desc"))
o.rmempty = false
o.default = false

o = s:option(Value, "server_ip", translate("Local IP"), translate("Local IP desc"))
o.placeholder = "any"
o.rmempty = true
o.default = "any"
o.optional = false
o:value("any", translate("any"))
o:value("127.0.0.1")

o = s:option(Value, "server_port", translate("Local Port"), translate("Local Port desc"))
o.datatype = "uinteger"
o.placeholder = "1053"
o.rmempty = true
o.default = "1053"

o = s:option(Value, "perm_cache", translate("Perm Cache"), translate("Perm Cache desc"))
o.placeholder = "2048"
o.rmempty = true
o.optional = false
o.default = "2048"
o:value("2048")
o:value("off", translate("off"))

o = s:option(Value, "min_ttl", translate("Min TTL"), translate("Min TTL desc"))
o.placeholder = "120"
o.rmempty = true
o.default = "120"

o = s:option(Value, "max_ttl", translate("Max TTL"), translate("Max TTL desc"))
o.placeholder = "1w"
o.rmempty = true
o.default = "1w"

o = s:option(Value, "query_method", translate("Query Method"))
o.placeholder = translate("udp_tcp")
o.rmempty = true
o.optional = true
o.default = "udp_tcp"
o:value("udp_tcp", translate("udp_tcp"))
o:value("tcp_udp", translate("tcp_udp"))
o:value("udp_only", translate("udp_only"))
o:value("tcp_only", translate("tcp_only"))

o = s:option(Value, "timeout", translate("Timeout"), translate("Timeout desc"))
o.datatype = "uinteger"
o.placeholder = "0"
o.rmempty = true
o.default = "0"

o = s:option(Value, "cache_dir", translate("Cache Directory"), translate("Cache Directory desc"))
o.placeholder = "/var/pdnsd"
o.rmempty = true
o.default = "/var/pdnsd"

o = s:option(Value, "udpbufsize", translate("UDP Buffer Size"), translate("UDP Buffer Size desc"))
o.datatype = "uinteger"
o.placeholder = "1024"
o.rmempty = true
o.default = "1024"

return m
