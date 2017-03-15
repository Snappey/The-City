
local PLAYER = FindMetaTable("Player")


function PLAYER:SetupDataTables()
	MsgC(XLBLUE, "[DATA] ", WHITE, "Declaring Player Datatable! ( " .. self:Nick() .. " : " .. (self:SteamID64() || "#ERROR") .. " )\n")
	self:NetworkVar("Int",0,"Money")
	self:NetworkVar("Int",1,"Status") -- Integer will be used for status effects e.g. Tranq, Arrested, Handcuffed etc.
	self:NetworkVar("Int",2,"Org")
	self:NetworkVar("Int",3,"Access") -- Integer will be used for access flags e.g. job permissions / admin permissions
	self:NetworkVar("Int",4,"PlayTime")

	self:NetworkVar("Bool",0,"Loaded")
	self:NetworkVar("Bool",1,"Gender")

	self:NetworkVar("String",0,"RPName")
	self:NetworkVar("String",1,"Description")

	if SERVER then
		-- Add hooks for these values changing, possibly for logging purposes (self;NetworkVarNotify)
	end
end

hook.Add( "OnEntityCreated", "SetupPlayerDataTables", function( ent ) -- Credit to kklouzal for datatable fix
    if ent:IsPlayer() then
        ent:InstallDataTable()
        ent:SetupDataTables()
        ent._DataInit = true
    end
end )

function PLAYER:CalcView()

end