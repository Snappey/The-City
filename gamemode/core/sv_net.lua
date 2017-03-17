
CityRP.Net = CityRP.Net || {}

-- TODO: Refactor / optimise, remove the need for string keys convert them to int keys (string -> int -> val)

util.AddNetworkString("CityRPSyncNetVal")

function CityRP.Net.SyncVal(ply, key)
	if IsValid(ply) then
		if CityRP.Net[ply:SteamID64()] && CityRP.Net[ply:SteamID64()][key] then
			local tbl = CityRP.Net[ply:SteamID64()][key] 
			net.Start("CityRPSyncNetVal")
				net.WriteString(key)
				net.WriteInt(tbl.bits, 6) -- Send the amount of bits that need to be read capped at 32 bits so max we need is 6 (5 + 1) TODO: Change to UInt think it removes the need for 6 
				net.WriteInt(tbl.val, tbl.bits) -- default to sending 4 bytes
			net.Send(ply)
			return true
		end
	end
	return false
end

function CityRP.RegisterNetVar(ply, key, val, maxval)
	if IsValid(ply) then
		if CityRP.Net[ply:SteamID64()] == nil then
			CityRP.Net[ply:SteamID64()] = {} -- Create the players networked values table
		end
		CityRP.Net[ply:SteamID64()][key] = {val = val, bits = util.IntToBits(maxval) + 1} -- bits field determines the amount bits we need to send the clint
		return true
	end
	return false
end

function CityRP.SetNetVar(ply, key, val)
	if IsValid(ply) then
		if CityRP.Net[ply:SteamID64()] == nil then
			CityRP.Net[ply:SteamID64()] = {}
		end
		CityRP.Net[ply:SteamID64()][key].val = val
		CityRP.Net.SyncVal(ply, key)
		return true
	end
end

function CityRP.GetNetVar(ply, key)
	if IsValid(ply) then
		if CityRP.Net[ply:SteamID64()] && CityRP.Net[ply:SteamID64()][key] then
			return CityRP.Net[ply:SteamID64()][key].val
		end
	end
	return false
end


util.AddNetworkString("CityRPSyncInv")

function CityRP.SyncInventory(ply, tbl)
	if IsValid(ply) then
		if ply:GetInventory() then
			net.Start("CityRPSyncInv")
			net.WriteInt(table.Count(ply:GetInventory()), 16)
				for k,v in pairs(ply:GetInventory()) do
					net.WriteString(v.id)
					net.WriteInt(v.amt, 16)
				end
			net.Send(ply)
			print("Sent Inventory")
		else
			print("Player has not loaded")
		end
	end
end