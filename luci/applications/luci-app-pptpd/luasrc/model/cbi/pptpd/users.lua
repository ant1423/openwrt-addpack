m = Map("pptpd")

s = m:section(TypedSection, "login", translate("VPN Server") .. ": " .. translate("Users Manager"))
s.addremove = true
s.anonymous = true
s.template = "cbi/tblsection"

o = s:option(Flag, "enabled", translate("Enabled"))
o.rmempty = false

o = s:option(Value, "username", translate("User name"))
o.placeholder = translate("User name")
o.rmempty  = true

o = s:option(Value, "password", translate("Password"))
o.password = true
o.rmempty  = true

-- DummyValue
o = s:option(Value, "ipaddress", translate("IP address"))
o.placeholder = translate("Automatically")
o.datatype = "ipaddr"
-- o.value = translate("Automatically (No support)")
o.rmempty  = true
function o.cfgvalue(self, section)
	value = self.map:get(section, "ipaddress")
	return value=="*" and "" or value
end
function o.remove(self, section)
	Value.write(self, section, "*")
	--luci.sys.call("/etc/init.d/pptpd restart >/dev/null")
end

return m
