
CityRP.Net = {}

util.AddNetworkString("CityRPSyncNetVal")

function CityRP.Net.SyncVal(ply, key)
	if IsValid(ply) then
		if CityRP.Net[ply:SteamID64()] && CityRP.Net[ply:SteamID64()][key] then
			local tbl = CityRP.Net[ply:SteamID64()][key] 
			net.Start("CityRPSyncNetVal")
				net.WriteString(key)
				net.WriteInt(tbl.bits, 6) -- Send the amount of bits that need to be read capped at 32 bits so max we need is 6
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

		if type(val) == "number" then
			CityRP.Net[ply:SteamID64()][key] = {val = val, bits = util.IntToBits(maxval) + 1} -- bits determines the amount bits we need to send the clint
			return true
		else
			ErrorNoHalt("Type (" .. type(val) .. ") is not supported by NetVar")
		end
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