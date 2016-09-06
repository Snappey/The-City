// This is clientside

include("sh_init.lua")

function GM:IncludeFolder(path)
	local fl = file.Find("city/gamemode/" .. path .. "/*", "LUA")
	if fl then
		for _,f in ipairs(fl) do
			local pfx = f:sub(1,3)
			if pfx == "cl_" then
				include(path .. "/" .. f)
			elseif pfx == "sh_" then
				include(path .. "/" ..  f)
			end
		end
	end
end

GM:IncludeFolder("core")
GM:IncludeFolder("core/metatables")
GM:IncludeFolder("configuration")

function GM:Initialize()
	util.SplashScreen()
	CityRP.LoadModules()
	self.BaseClass:Initialize()
end

function GM:SpawnMenuEnabled()
	return true
end

function GM:SpawnMenuOpen()
	return true
end