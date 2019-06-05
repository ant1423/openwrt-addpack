module("luci.controller.automemc", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/automemc") then
		return
	end

	local page

	page = entry({"admin", "services", "automemc"}, cbi("automemc"), _("Auto Memory Cleanup"))
	page.i18n = "automemc"
	page.dependent = true
end
