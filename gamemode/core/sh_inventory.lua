CityRP.Inventory = {}

if SERVER then
	
	function CityRP.Inventory.Add(ply, item, amt)
		if ply:GetLoaded() then ErrorNoHalt("Inventory of Player (" .. ply:SteamID64() .. ") has not been loaded!") end
		if CityRP.Inventory.HasItem(ply, item, amt) then -- TODO: Check that the player has enough inv space
			ply.Inventory[item].amt = ply.Inventory[item].amt + amt
			-- TODO: Update this table on the client
		else
			ply.Inventory[item] = {amt = amt, id = item}
		end
	end

	function CityRP.Inventory.Take(ply, item, amt)
		if ply:GetLoaded() then ErrorNoHalt("Inventory of Player (" .. ply:SteamID64() .. ") has not been loaded!") end
		if !CityRP.Inventory.HasItem(ply, item, amt) then
			local val = ply.Inventory[item].amt - amt
			if val >= 0 then -- TODO: Update this table on the client
				ply.Inventory[item].amt = val
			else
				ply.Inventory[item].amt = 0
			end
		end
	end

	function CityRP.Inventory.GetMaxSize()
		return util.GetConfig("Inventory Size")
	end
	
else

	function CityRP.Inventory.Use(item)
		if ply:GetLoaded() then ErrorNoHalt("Your Inventory has not been loaded!") end
		-- Ties directly to the item system afaik
	end

end


function CityRP.Inventory.HasItem(ply, item, amt)
	if ply:GetLoaded() then ErrorNoHalt("Inventory of Player (" .. ply:SteamID64() .. ") has not been loaded!") end
	if ply.Inventory[item] then
		if amt && ply.Inventory[item].amt >= amt then
			return true
		else
			return false
		end
	end
	return false
end
