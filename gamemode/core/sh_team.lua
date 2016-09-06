
CityRP.Team = {}
CityRP.Team.Jobs = {}

function CityRP.Team.Add(name, tbl)
	tbl.name = name
	tbl.models = tbl.models

	tbl.limit = tbl.limit || 50
	tbl.col = tbl.colour || Color(100,230,100)
	tbl.salary = tbl.salary || 150
	tbl.desc = tbl.description || "N/A"
	tbl.Loadout = tbl.Loadout || function() return true end
	tbl.Spawn = tbl.Spawn || function() return true end
	tbl.OnJoin = tbl.OnJoin || function() return true end

	local idx = table.insert(CityRP.Team.Jobs, tbl)
	tbl.index = idx

	team.SetUp(idx, name, tbl.col) -- Register the team within the base gamemode
	return idx
end

function CityRP.Team.SetVar(idx, var, val)
	if type(idx) == "number" then
		if CityRP.Team.Jobs[idx] then
			CityRP.Team.Jobs[idx][var] = val
			return true
		end
	else
		idx = CityRP.Team.Get(idx)
		if idx then
			CityRP.Team.Jobs[idx][var] = val
			return true
		end
	end
	return false
end

function CityRP.Team.GetVar(idx, var)
	if type(idx) == "number" then
		if CityRP.Team.Jobs[idx] then
			return CityRP.Team.Jobs[idx][var]
		end
	else
		idx = CityRP.Team.Get(idx)
		if idx then
			return CityRP.Team.Jobs[idx][var]
		end
	end
	return false
end

function CityRP.Team.Get(name)
	if type(name) == "number" then
		if CityRP.Team.Jobs[name] then
			return name
		end
	else
		local name = name:lower()
		for k,v in ipairs(CityRP.Team.Jobs) do
			if name == v.name:lower() then
				return k
			end
		end
	end
	return false
end

if SERVER then

	function CityRP:PlayerJoinedTeam(ply, idx)
		if CityRP.Team.Get(idx) && IsValid(ply) then
			ply:SetTeam(idx)
			ply:KillSilent()

			local models = CityRP.Team.GetVar(idx, "models")
			ply:SetModel(models[math.random(1, #models)])
		end
	end

	function CityRP:PlayerFailedJoinTeam(ply, idx, err)
		return false -- Default Functionality, add a hook to change it to true
	end

	function CityRP.Team.Set(ply, idx)
		local tm, res = CityRP.Team.Get(idx), 0
		if CityRP.Team.Jobs[tm] && IsValid(ply) then
			local job = CityRP.Team.Jobs[tm]
			if #team.GetPlayers(tm) + 1 <= job.limit then
				if job.OnJoin then
					hook.Call("PlayerJoinedTeam", CityRP, ply, tm)
					return true
				else
					res = 1 -- Failed the join check
				end
			else
				res = 2 -- Team limit has been reached
			end
			if hook.Call("PlayerFailedJoinTeam", CityRP, ply, idx, res) && res != 0 then
				hook.Call("PlayerJoinedTeam", CityRP, ply, idx)
				return true
			end
		end
		return false
	end

end