local s, m, o

m = Map("pdnsd")
s = m:section(TypedSection, "source", translate("pdnsd") .. ": " .. translate("source Section"))
s.anonymous = true
s.addremove = false
s.rmempty = false

--[[
config source
	option owner localhost
	option ttl   '86400'
	option file '/etc/hosts'
]]--

o = s:option(Value, "owner", translate("Owner"), translate("Owner desc"))
o.rmempty = true
o.default = "localhost"

o = s:option(Value, "ttl", translate("TTL"), translate("TTL desc"))
o.datatype = "uinteger"
o.placeholder = "86400"
o.rmempty = true
o.default = "86400"

o = s:option(Value, "file", translate("File"), translate("File desc"))
o.rmempty = true
o.default = ""
o.optional = false
o:value("/etc/hosts")

return m
