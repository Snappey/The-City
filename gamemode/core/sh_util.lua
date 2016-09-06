
-- Colours used in the gamemode
WHITE  = Color(255,255,255)
LWHITE = Color(236,240,241)
BLACK  = Color(0,0,0)
DBLACK = Color(32,32,32)
LBLACK = Color(64,64,64)
BLUE   = Color(52,128,219)
LBLUE  = Color(41,128,185)
XLBLUE = Color(41,178,230)
DBLUE  = Color(44,62,80)
RED    = Color(231,76,60)
GREEN  = Color(39,174,96)

function util.FormatMoney(amt) -- Credit to lua-user wiki for this
  local formatted = amt
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return CityRP.Configuration["Currency Symbol"] .. formatted
end

function util.BoolToInt(b)
	if b then
		return 1
	end
	return 0
end

function util.IntToBool(i)
	if i != 0 then
		return true
	end
	return false
end

function util.IntToBits(i)
	local bits = 0
	while (i > 0) do
		i = bit.rshift(i, 1)
		bits = bits + 1
	end
	return bits
end

function util.GetConfig(key)
	if CityRP.Configuration[key] then
		return CityRP.Configuration[key]
	end
	return false
end

local splash = [[ 
				THE CITY 
		Inspiration from Applejack / Cider / CityRP		]]
local splash2 = [[			     Created By Spai]] -- TODO: Redo ASCII Splash logo

function util.SplashScreen()
	local splash = string.Explode("\n", splash)
	for k,v in ipairs(splash) do
		MsgC(XLBLUE, v, "\n")
	end
	MsgN(splash2)
end

if (CLIENT) then

	function util.AddNotify(str, type, len)
		notification.AddLegacy(str,type,len)
		surface.PlaySound("ui/click.wav")
		MsgC(XLBLUE, "[NOTIF] ", WHITE, str)
	end
	net.Receive("City_Notifications", function() util.AddNotify(net.ReadString(), net.ReadInt(4), net.ReadInt(4)) end)
end

if (SERVER) then

	util.AddNetworkString("City_Notifications")
	function util.AddNotify(str, type, len, ply)
		net.Start("City_Notifications")
			net.WriteString(str)
			net.WriteInt(type, 4)
			net.WriteInt(len, 4)
		net.Send(ply)
	end
end