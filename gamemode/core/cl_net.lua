
CityRP.Net = CityRP.Net || {}

function CityRP.Net.SyncVal()
	if CityRP.Net[LocalPlayer():SteamID64()] == nil then CityRP.Net[LocalPlayer():SteamID64()] = {} end
	local key, bits = net.ReadString(), net.ReadInt(6)
	local val = net.ReadInt(bits)
	print(key, val, bits)
	if IsValid(LocalPlayer()) then
		CityRP.Net[LocalPlayer():SteamID64()][key] = val
	end
end
net.Receive("CityRPSyncNetVal", CityRP.Net.SyncVal)

function CityRP.GetNetVar(key, def)
	if CityRP.Net[LocalPlayer():SteamID64()] && CityRP.Net[LocalPlayer():SteamID64()][key] then
		return CityRP.Net[LocalPlayer():SteamID64()][key]
	end
	return def
end