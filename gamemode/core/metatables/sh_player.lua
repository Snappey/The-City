
local PLAYER = FindMetaTable("Player")

function PLAYER:IsStatus(status)
	if bit.band(self:GetStatus(), status) == status then
		return true
	end
	return false
end

function PLAYER:AddStatus(status)
	if bit.band(self:GetStatus(), status) == status then
		return false --- They already have that status
	end
	self:SetStatus(self:GetStatus() + status)
	return true
end

function PLAYER:RemoveStatus(status)
	if bit.band(self:GetStatus(), status) == status then
		self:SetStatus( self:GetStatus() - status)
		return true
	end
	return false -- That status isnt on that player
end
