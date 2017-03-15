
function CityRP.LoadResources()
	for k,v in pairs(file.Find("materials/thecity/*", "GAME")) do
		resource.AddSingleFile(v)
	end
end

CityRP.LoadResources() -- Only includes materials aka .pngs