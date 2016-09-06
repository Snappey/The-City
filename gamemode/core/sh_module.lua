
CityRP.Module = {}
CityRP.Module.Stored = {}
CityRP.Module.Folder = "city/gamemode/core/module"
local module = CityRP.Module

function module.LoadModule(folder)
	if SERVER then
		MsgC(XLBLUE, "| - Included ", GREEN, "module '" .. folder .. "'\n")
		AddCSLuaFile(CityRP.Module.Folder .. "/" .. folder .. "/module.lua")
		CityRP.Module.Stored[folder] = include(CityRP.Module.Folder .. "/" .. folder .. "/module.lua")
	else
		CityRP.Module.Stored[folder] = include(CityRP.Module.Folder .. "/" .. folder .. "/module.lua")
	end
end

function module.Get(name)
	if CityRP.Module.Stored[name] then
		return CityRP.Module.Stored[name]
	end
	return false
end

function CityRP.LoadModules()
	MsgN("|---------------------------------------------------------------------------|")
	MsgN("| Loading Modules")
	MsgN("|---------------------------------------------------------------------------|")
	local _,d = file.Find(CityRP.Module.Folder .. "/*", "LUA") 
	for k,v in pairs(d) do
		module.LoadModule(v)
	end
	MsgC(GREEN, "| --> ", WHITE, "Finished Including 'Modules'\n")
	MsgN("|---------------------------------------------------------------------------|")
end
