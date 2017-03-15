
CityRP.HUD = {}
local hud = CityRP.HUD
local w,h,ply = ScrW(), ScrH(), LocalPlayer()

local infominimal = CreateClientConVar("cityrp_hud_info_minimal","0")
local barminimal = CreateClientConVar("cityrp_hud_bar_minimal","0")

surface.CreateFont("HUDInfo", {font="Tahoma", size=20, weight=400})

hud.HiddenElements = { 
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["NetGraph"] = false
}
function GM:HUDShouldDraw(name)
	if hud.HiddenElements[name] then
		return false
	end
	return true
end

function GM:HUDPaint()
	if !IsValid(LocalPlayer()) then ply = LocalPlayer() return end
	if !LocalPlayer()._DataInit then return end
	self:DrawInfo()
	self:DrawBar()
end

hud.Info = {}
function GM:DrawInfo()
	local i,y = 1 -- Use our own counter, allows us to only increment if it is actually drawn
	for _,v in ipairs(hud.Info) do
		if hook.Call("HUDShouldDrawInfo", GAMEMODE, v.title) then continue end -- Return true to disable, this should be changed to return to false to disable
		y = (h - 8) - (i * 36)

		if infominimal:GetInt() <= 0 then

			surface.SetDrawColor(DBLACK, 200)
				surface.DrawRect(8, y, 34, 34)
				surface.DrawRect(8 + 36, y, 240, 34)

			surface.SetDrawColor(WHITE)
				surface.SetMaterial(v.icon)
				surface.DrawTexturedRect(9, y + 2, 32, 32) 

			surface.SetTextColor(WHITE)
			surface.SetTextPos(8 + 36 + 4, y + 6)
			surface.SetFont("HUDInfo")
				surface.DrawText(v.prefix .. v.var())
		end
		i = i + 1
	end
end

hud.Bar = {}
function GM:DrawBar()
	local i,x,perc = 1
	for _,v in ipairs(hud.Bar) do
		if hook.Call("HUDShouldDrawBar", GAMEMODE, v.title) then continue end
		if v.lastval == nil then v.lastval = v.var() end
		if v.lastval >= 99 && math.ceil(v.lastval) == math.ceil(v.var()) then continue end -- hides the bar if its near max and hasnt changed
		x = (w - 8) - (i * 38)
		y = h - 180

		if barminimal:GetInt() <= 0 then

			surface.SetDrawColor(DBLACK, 200)
				surface.DrawRect(x, y, 36, 136)
				surface.DrawRect(x, y + 137, 36, 32)

			v.lastval = Lerp(.05, v.lastval, v.var()) -- smoothen the values
			perc = (135 / (v.maxvar / v.lastval))

			surface.SetDrawColor(v.col, 255)
				render.SetScissorRect(x, y + (133 - perc), x + 36, y + 135, true)
					surface.DrawRect(x + 1, y + 1, 34, 135)
				render.SetScissorRect(0, 0, 0, 0, false)

			surface.SetDrawColor(WHITE)
				surface.SetMaterial(v.icon)
				surface.DrawTexturedRect(x + 2, y + 137, 32, 32)

		end
		i = i + 1
	end 
end

function hud.AddInfo(title, prefix, var, icon)
	table.insert(hud.Info, {
		title = title, 
		prefix = prefix,
		var = var,
		icon = Material(icon)
	})
end

function hud.AddBar(title, var, maxvar, suffix, col, icon)
	table.insert(hud.Bar, {
		title = title,
		var = var,
		maxvar = maxvar,
		sfx = suffix,
		col = col,
		icon = Material(icon)
	})
end

local oSetDrawColor = surface.SetDrawColor -- Little helper function for my colour constants
function surface.SetDrawColor(col,alpha,b,a) -- needs cleaning up
	if type(col) == "table" then
		if alpha then
			col.a = alpha 
		end
		oSetDrawColor(col)
	else 
		oSetDrawColor(col,alpha,b,a) 
	end
end

hud.AddInfo("Name", "Name: ",function() return LocalPlayer():GetRPName() || "#ERROR" end, "thecity/person.png") --- maybe build a caching system, so instead of a function just store the value that is updated when it changes
hud.AddInfo("Money", "Money: ", function() return util.FormatMoney(LocalPlayer():GetMoney()) || "#ERROR" end, "thecity/money.png")
hud.AddInfo("Job", "Job: ", function() return team.GetName(LocalPlayer():Team()) || "#ERROR" end, "thecity/tag.png")

hud.AddBar("Health", function() return LocalPlayer():Health() end, 100, "", RED, "thecity/heart.png")
hud.AddBar("Stamina", function() return CityRP.GetNetVar("Stamina", 100) end, 100, "%", XLBLUE, "thecity/running.png")
