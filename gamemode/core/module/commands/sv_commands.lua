
local command = CityRP.Command

command.AddChatCommand("test", function(ply, args)
	if args && #args > 0 then PrintTable(args) return false, "Args were found!" end
	return true, ply:SteamID64()
end, "This is a test command!")