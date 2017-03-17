
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
	CityRP.DataProvider.Query("INSERT INTO `city_data` VALUES('" .. self:SteamID64() .. "','" .. self:GetRPName() .. "','" .. self:GetDescription() .. "','" .. self:GetMoney() .. "','" .. util.BoolToInt(self:GetGender()) .. "', '" .. (self:GetPlayTime() + (self:TimeConnected() / 60)) .. "')", function()
		MsgC(XLBLUE, "[DATA] ", WHITE, "Player data saved! ( " .. self:Nick() .. " : " .. self:SteamID64() .. " )")
	end)
end

function PLAYER:LoadData()
	self:SetLoaded(false)
	self.Inventory = {}
	-- Query Database, for their data
	hook.Call("PrePlayerDataLoad", GM, self)
	CityRP.DataProvider.Query("SELECT * FROM `city_data` WHERE id='" .. self:SteamID64() .. "';", function(data)
		if #data > 0 then
			data = data[1]

			self:SetMoney(data.money) -- Possibly move this over to a seperate section of networking, along with everything else that isnt activly displayed to everyone
			self:SetStatus(0)
			--self:SetOrg(data.organisation) disabled 

			self:SetGender(data.gender)
			self:SetRPName(data.name)
			self:SetDescription(data.desc)
			self:SetPlayTime(data.playtime)
			MsgC(XLBLUE, "[DATA] ", WHITE, "Loaded player data! (" .. self:Nick() .. " : " .. self:SteamID64() .. " )\n")
		else -- new player
			MsgC(XLBLUE, "[NEW PLAYER] ", WHITE, "Creating new player profile! ( " .. self:Nick() .. " : " .. self:SteamID64() .. " )\n" )
			self:SetMoney(util.GetConfig("Starting Money"))
			self:SetOrg(0) -- orgs are started from 1
			self:SetGender(true) -- True is male

			self:SetRPName( util.GetConfig("Default RPName")[math.random(1, #util.GetConfig("Default RPName"))] )
			self:SetDescription("")
			self:SaveData() -- Store the data after creating it
			self:SetPlayTime(0)

			self:GiveDefaultItems()
		end

		self:LoadInventory() -- Load Players Inventory

	end)
end

function PLAYER:GiveDefaultItems() -- TODO: Change Table names to account for config changes
	local qry = "VALUES "

	for k,v in pairs(util.GetConfig("Default Items")) do
		qry = qry .. "(" .. self:SteamID64() .. ",'" .. k .. "'," .. v .. ")"
		if next(util.GetConfig("Default Items"), k) == nil then
			qry = qry .. ";"
		else
			qry = qry .. ","
		end
	end

	CityRP.DataProvider.Query("INSERT INTO `city_items` " .. qry)
end

function PLAYER:LoadInventory()
	CityRP.DataProvider.Query("SELECT * FROM `city_items` WHERE id='" .. self:SteamID64() .. "';", function(data)
		for k,v in pairs(data) do
			self:AddItem(v.item, v.amt)
		end

		self:SetLoaded(true) -- Player data has finished loading
		CityRP.SyncInventory(self, self:GetInventory())
		hook.Call("PostPlayerDataLoad", GM, self)
	end)
end

function PLAYER:SaveInventory()
	local qry = "VALUES "

	for k,v in pairs(self:GetInventory()) do
		qry = qry .. "(" .. self:SteamID64() .. "," .. v.id .. "," .. v.amt .. ")"
		if next(self:GetInventory(), k) == nil then
			qry = qry .. ";"
		else
			qry = qry .. ","
		end
	end

	CityRP.DataProvider.Query("INSERT INTO `city_items` " .. qry)
end

function PLAYER:AddItem(item, amt)
	CityRP.Inventory.Add(self, item, amt)
end

function PLAYER:TakeItem(item, amt)
	CityRP.Inventory.Take(self, item, amt)
end
