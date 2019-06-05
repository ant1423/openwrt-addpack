module("luci.controller.pptpd", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/pptpd") then
		return
	end

	entry({"admin", "services", "pptpd"},
		alias("admin", "services", "pptpd", "settings"),
		_("VPN Server"), 60)

	entry({"admin", "services", "pptpd", "settings"},
		cbi("pptpd/settings"),
		_("General Settings"), 10).leaf = true

	entry({"admin", "services", "pptpd", "users"},
		cbi("pptpd/users"),
		_("Users Manager"), 20).leaf = true

	entry({"admin", "services", "pptpd", "online"},
		cbi("pptpd/online"),
		_("Online Users"), 30).leaf = true
end
