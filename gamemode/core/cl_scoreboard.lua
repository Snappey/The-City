
CityRP.Scoreboard = {}
local scoreboard = CityRP.Scoreboard
local w,h = ScrW(), ScrH()

surface.CreateFont("ScoreboardTitle", {font = "Tahoma", size = 36, weight = 400})
surface.CreateFont("ScoreboardInfo", {font = "Tahoma", size = 24, weight = 400})
surface.CreateFont("ScoreboardSubTitle", {font = "Tahoma", size = 14, weight = 300})

function GM:ScoreboardShow()
	scoreboard:Open()
end

function GM:ScoreboardHide()
	scoreboard:Hide()
end

function scoreboard:Hide()
	self.Frame:Remove()
end

function scoreboard:Open()
	if IsValid(self.Frame) then self.Frame:SetVisible(true) end

	self.Frame = vgui.Create("DScrollPanel")
	self.Frame:SetSize(w * .5, h * .75)
	self.Frame:SetPos(w * .25, h * .1)
	self.Frame:SetPadding(40,40,40,40)

	self.Header = vgui.Create("DPanel", self.Frame)
	self.Header:SetSize(self.Frame:GetWide(), 45)
	self.Header.Paint = function(pnl,w,h) surface.SetDrawColor(BLUE) surface.DrawRect(0,0,w,h) end

		local title = vgui.Create("DLabel", self.Header)
		title:SetPos(5,5)
		title:SetTextColor(LWHITE)
		title:SetText(GetConVarString("hostname"))
		title:SetFont("ScoreboardTitle")
		title:SizeToContents()

		local playercount = vgui.Create("DLabel", self.Header)
		playercount:SetTextColor(LWHITE)
		playercount:SetText("Players: " .. #player.GetAll() .. " / " .. game.MaxPlayers())
		playercount:SetFont("ScoreboardSubTitle")
		playercount:SetPos(self.Frame:GetWide() - surface.GetTextSize("Players: " .. #player.GetAll() .. " / " .. game.MaxPlayers()) + 20, 28)
		playercount:SizeToContents()

	local s = (48) -- start of the player panels
	for k,v in pairs(player.GetAll()) do

		local pnl = vgui.Create("DPanel", self.Frame)
		pnl:SetSize(self.Frame:GetWide(), 36)
		pnl:SetPos(0, s + ((k - 1) * 38))
		pnl.Paint = function(pnl,w,h) surface.SetDrawColor(team.GetColor(v:Team())) surface.DrawRect(0,0,w,h) end

		local avatar = vgui.Create("AvatarImage",pnl)
		avatar:SetSize(32,32)
		avatar:SetPos(2,2)
		avatar:SetPlayer(v)

		local name = vgui.Create("DLabel", pnl)
		name:SetTextColor(LWHITE)
		name:SetText(v:Nick() .. " (" .. v:GetRPName() .. ")")
		name:SetFont("ScoreboardInfo")
		name:SetPos((42), 5)
		name:SizeToContents()


		local ping = vgui.Create("DLabel", pnl)
		ping:SetTextColor(LWHITE)
		ping:SetText(v:Ping())
		ping:SetFont("ScoreboardInfo")
		ping:SetPos(pnl:GetWide() - 60, 7)

		local mute = vgui.Create("DImageButton", pnl)
		mute:SetPos(pnl:GetWide() - 35, 2)
		mute:SetSize(32,32)
		mute.DoClick = function()
			if v:IsMuted() then
				v:SetMuted(false)
				mute:SetImage("icon32/unmuted.png")
			else
				v:SetMuted(true)
				mute:SetImage("icon32/muted.png")
			end
		end

		if v:IsMuted() then
			mute:SetImage("icon32/muted.png")
		else
			mute:SetImage("icon32/unmuted.png")
		end
	end

	self.Frame:MakePopup()
end


