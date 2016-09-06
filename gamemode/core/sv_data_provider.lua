
CityRP.DataProviders = {}
CityRP.DB = nil

function CityRP.LoadProviders()
	for _,f in ipairs(file.Find("city/gamemode/core/providers/*", "LUA")) do
		local _, e = f:find(".", 1, true)
		CityRP.DataProviders[f:sub(1, e - 1)] = include("providers/" .. f)
	end
end

function CityRP.SelectProvider()
	CityRP.DataProvider = CityRP.DataProviders[util.GetConfig("Data-Provider"):lower()]
end

function CityRP.ConnectToDB()
	MsgC(XLBLUE, "[DATA] ", WHITE, "Creating database connection!\n")
	CityRP.DB = CityRP.DataProvider.Connect()
end

CityRP.LoadProviders() 