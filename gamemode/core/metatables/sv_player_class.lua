
local PLAYER = FindMetaTable("Player")

function PLAYER:OnSpawn(init)
	if IsValid(self) then
		if init then -- Is it their first time
			self:SetJob(TEAM_CITIZEN)
			self.data = {}
			self:LoadData() --  Load players data from database
		end
		self:DefaultLoadout() -- Give the default loadout
	end
end

function PLAYER:DefaultLoadout()
	for k,v in pairs(util.GetConfig("Default Loadout")) do
		self:Give(v)
	end
end

function PLAYER:SaveData()
	CityRP.DataProvider.Query("INSERT INTO `city_data` VALUES('" .. self:SteamID64() .. "','" .. self:GetRPName() .. "','" .. self:GetDescription() .. "','" .. self:GetMoney() .. "','" .. util.TableToJSON(self:GetInventory()) .. "','" .. self:GetOrg() .. "','" .. "abcd" .. "','" .. "" .. "','" .. util.BoolToInt(false) .. "','" .. util.BoolToInt(self:GetGender()) .. "')", function()
		MsgC(XLBLUE, "[DATA] ", WHITE, "Player data saved! ( " .. self:Nick() .. " : " .. self:SteamID64() .. " )")
	end)
end

function PLAYER:LoadData()
	self:SetLoaded(false)
	-- Query Database, for their data
	CityRP.DataProvider.Query("SELECT * FROM `city_data` WHERE sid=" .. self:SteamID64() .. ";", function(data)
		if #data > 0 then
			data = data[1]

			self:SetMoney(data.money) -- Possibly move this over to a seperate section of networking, along with everything else that isnt activly displayed to everyone
			self:SetStatus(0)
			self:SetOrg(data.organisation)

			self:SetGender(data.gender)
			self:SetRPName(data.char_name)
			self:SetDescription(data.description)
			MsgC(XLBLUE, "[DATA] ", WHITE, "Loaded player data! (" .. self:Nick() .. " : " .. self:SteamID64() .. " )\n")
		else -- new player
			MsgC(XLBLUE, "[NEW PLAYER] ", WHITE, "Creating new player profile! ( " .. self:Nick() .. " : " .. self:SteamID64() .. " )\n" )
			self:SetMoney(util.GetConfig("Starting Money"))
			self:SetStatus(0) -- no status effects active
			self:SetOrg(0) -- orgs are started from 1
			self:SetGender(true) -- True is male

			self:SetRPName( util.GetConfig("Default RPName")[math.random(1, #util.GetConfig("Default RPName"))] )
			self:SetDescription("")
			self:SaveData() -- Store the data after creating it
		end
		self:SetLoaded(true) -- Player data has finished loading
	end)
end