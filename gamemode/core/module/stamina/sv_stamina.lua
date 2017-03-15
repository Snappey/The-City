
local stamina = {}

local change
function stamina.Process(ply, mv, cmd)
	if ply._LastRun == nil || ply._LastRun + .1 < CurTime() then
		if !ply._Stamina then ply._Stamina = 100 CityRP.RegisterNetVar(ply, "Stamina", ply._Stamina, 100) end
		change = 0

		if mv:KeyDown(IN_SPEED) && ply:OnGround() then
			change = change - 2
		elseif ply._Stamina < 100 then
			change = change + 1
		end

		if mv:KeyPressed(IN_JUMP) then
			change = change - 8
		end

		ply._Stamina = math.Clamp(ply._Stamina + change, 0, 100)

		if change != 0 && ply:GetNetVar("Stamina") && ply:GetNetVar("Stamina") != ply._Stamina then
			ply:SetNetVar("Stamina", ply._Stamina, ply:GetNetVar("Stamina"))
		end

		if ply._Stamina == 0 then
			ply:SetRunSpeed(100)
		elseif ply._Stamina >= 50 then
			ply:SetRunSpeed(300)
		end
		ply._LastRun = CurTime()
	end
end
hook.Add("SetupMove", "CityRPStamina", stamina.Process)

return stamina