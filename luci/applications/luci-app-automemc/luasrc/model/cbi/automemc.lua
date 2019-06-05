local m, s, o, enable, frequency, minval

local running=(luci.sys.call("pidof automemc > /dev/null") == 0)
if running then	
	m = Map("automemc", translate("Auto Memory Cleanup"), translate("Auto memory cleanup is running"))
else
	m = Map("automemc", translate("Auto Memory Cleanup"), translate("Auto memory cleanup is not running"))
end

s = m:section(TypedSection, "automemc", translate("Settings"))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = false

enable = s:option(Flag, "enable", translate("Enable"))
enable.optional = false
enable.rmempty = false

minval = s:option(Value, "minval", translate("minimum value"), translate("minimum value desc"))
minval.optional = false
minval.rmempty = false
minval.default = "10"
minval:value("100","100%")
minval:value("90","90%")
minval:value("80","80%")
minval:value("70","70%")
minval:value("60","60%")
minval:value("50","50%")
minval:value("40","40%")
minval:value("30","30%")
minval:value("20","20%")
minval:value("10","10%")

frequency = s:option(Value, "frequency", translate("frequency"))
frequency.optional = false
frequency.rmempty = false

return m
