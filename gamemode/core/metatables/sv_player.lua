
local PLAYER = FindMetaTable("Player")

function PLAYER:SetJob(idx)
	return CityRP.Team.Set(self, idx)
end

function PLAYER:GetJob()
	return CityRP.Team.Jobs[CityRP.Team.Get(self:Team())]
end

function PLAYER:AddMoney(amt)
	self:SetMoney(self:GetMoney() + amt)
	return true
end

function PLAYER:TakeMoney(amt)
	if self:GetMoney() - amt < 0 then 
		return false
	end
	self:SetMoney(self:GetMoney() - amt)
	return true 
end

function PLAYER:Notify(str, type, len)
	util.AddNotify(str,type,len,self)
end

function PLAYER:SetNetVar(key, val)
	CityRP.SetNetVar(self, key, val)
end

function PLAYER:GetNetVar(key)
	return CityRP.GetNetVar(self, key)
end