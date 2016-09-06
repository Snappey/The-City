
CityRP.Command = {}
CityRP.Command.Prefixes = {["/"] = true,["!"] = true, ["~"] = false}
CityRP.Command.Stored = {}
local command = CityRP.Command

-- TODO: Add access string to only allow certain people to run it
function command.AddChatCommand(cmd, func, help, alias)
	if !CityRP.Command.Stored[cmd] then
		CityRP.Command.Stored[cmd] = {func = func, help = help || "", alias = alias || {}}
		-- Let em know its been registered
	else
		-- Command is already registered
	end
end

function command.RemoveChatCommand(cmd)
	if CityRP.Command.Stored[cmd] then
		CityRP.Command.Stored[cmd] = nil
	else
		-- COmmand isnt registered
	end
end

-- Return feedback from the command, returns a string to display to the player w/ a  bool to say if it was successful or not
function command.RunCommand(ply, cmd, args)
	if CityRP.Command.Exists(cmd) then
		if IsValid(ply) then
			local res, msg = CityRP.Command.Stored[cmd].func(ply, args)
			if res then
				ply:Notify(msg || "Success!", 0, 4)
			else
				ply:Notify(msg || CityRP.Command.Get(cmd).help, 1, 4)
			end
		end
	end
end

function command.ParseChat(ply, text, tm)
	if IsValid(ply) && CityRP.Command.Prefixes[text:sub(1,1)] then
		local s = string.find(text," ")
		local args = nil -- < Kill me now remember to localise variables kids
		if s then
			args = string.Explode(" ", text:sub(s))
			table.remove(args, 1) -- If there is ever a problem with arg parsing, probably this check it
			text = text:sub(2, (s - 1)) -- Dont want the space with it hence '-1'
		else
			text = text:sub(2)
		end
		command.RunCommand(ply, text, args)
		return ""
	end
end
hook.Add("PlayerSay","CityParseChatCommands", command.ParseChat)

function command.Get(cmd)
	if CityRP.Command.Stored[cmd] then
		return CityRP.Command.Stored[cmd]
	end
	return false
end

function command.Exists(cmd)
	if CityRP.Command.Stored[cmd] then
		return true
	end
	return false
end

function command.GetTable()
	return CityRP.Command.Stored
end
