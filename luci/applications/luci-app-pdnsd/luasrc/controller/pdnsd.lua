--[[
LuCI - Lua Configuration Interface
]]--

module("luci.controller.pdnsd", package.seeall)

function index()
	
	if not nixio.fs.access("/etc/config/pdnsd") then
		return
	end

	entry({"admin", "services", "pdnsd"},
		alias("admin", "services", "pdnsd", "global"),
		_("pdnsd"), 60)

	-- 2.1.1 global Section
	entry({"admin", "services", "pdnsd", "global"},
		cbi("pdnsd/global"),
		_("global Section"), 10).leaf = true

	-- 2.1.2 server Section
	entry({"admin", "services", "pdnsd", "server"},
		cbi("pdnsd/server"),
		_("server Section"), 20).leaf = true

	-- 2.1.5 source Section
	entry({"admin", "services", "pdnsd", "source"},
		cbi("pdnsd/source"),
		_("source Section"), 50).leaf = true
end
