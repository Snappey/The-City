----------------
-- The City
-- By Spai
----------------

-- Include Startup Files
include("sh_init.lua")

AddCSLuaFile("sh_init.lua")
AddCSLuaFile("cl_init.lua") 
--
function GM:OnLoad()
	CityRP.StartTime = os.time()
	MsgN("|---------------------------------------------------------------------------|")
	MsgC(Color(255,255,255),"|		", Color(41,178,230), "The City is Loading! ( " .. os.date( "%H:%M:%S - %d/%m/%Y" , CityRP.StartTime ) .. " )\n")
	MsgC(Color(255,255,255),"|			", Color(41,178,230), "by Spai (STEAM_0:1:39690621)\n")
	GM:IncludeFolder("core")
	GM:IncludeFolder("core/metatables")

	CityRP.Configuration = CityRP.Configuration || {}
	GM:IncludeFolder("configuration")
	MsgN("|---------------------------------------------------------------------------|")
end

function GM:IncludeFolder(path)
	MsgN("|---------------------------------------------------------------------------|")
	MsgN("| Including Folder " .. path)
	MsgN("|---------------------------------------------------------------------------|")
	local fl = file.Find("city/gamemode/" .. path .. "/*", "LUA")
	if fl then
		for _,f in ipairs(fl) do
			local pfx = f:sub(1,3)
			if pfx == "sv_" then
				include(path .. "/" .. f)
				MsgC("| - Included ", Color(39,174,96),  path .. "/" .. f , Color(255,255,255), " on SV\n")
			elseif pfx == "cl_" then
				AddCSLuaFile(path .. "/" ..  f) 
				MsgC("| - Included ", Color(39,174,96),  path .. "/" .. f , Color(255,255,255), " on CL\n")
			elseif pfx == "sh_" then
				include(path .. "/" ..  f)
				AddCSLuaFile(path .. "/" ..  f)
				MsgC("| - Included ", Color(39,174,96),  path .. "/" .. f , Color(255,255,255), " on SH\n")
			end
		end
	end
	--MsgN("|---------------------------------------------------------------------------|")
	MsgC(Color(39,174,96), "| --> ", Color(255,255,255), "Finished Including '" ..  path .. "'\n")

end


function GM:Initialize()
	-- Connect to DB
	-- Load Modules
	CityRP.SelectProvider()
	CityRP.ConnectToDB() 

	CityRP.LoadModules()


	util.SplashScreen()
	MsgN("\n|---------------------------------------------------------------------------|")
	MsgC(Color(255,255,255),"|	",XLBLUE, "The City has finished Loading!! ( " .. os.date( "%H:%M:%S - %d/%m/%Y" , CityRP.StartTime ) .. " )\n")
	MsgC(Color(255,255,255),"|			",XLBLUE, "Time Taken: " .. CityRP.StartTime - os.time() .. "s!\n")
	MsgN("|---------------------------------------------------------------------------|\n\n")
	self.BaseClass.Initialize()
end

function GM:OnReloaded()

end

function GM:PlayerInitialSpawn(ply)
	ply:OnSpawn(true) -- Call the default spawn function (true means it was initial spawn)
end

function GM:PlayerSpawn(ply)
	ply:OnSpawn(false)
	ply:GetJob().Spawn(ply)  -- Call the Teams Spawn function
end

function GM:PlayerLoadout()
	return true -- We handle our own loadouts
end

GM:OnLoad()