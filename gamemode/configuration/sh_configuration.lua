
CityRP.Configuration["Starting Money"] = 10000
CityRP.Configuration["Salary Timer"] = 300 -- Time for each salary
CityRP.Configuration["Default Loadout"] = {"weapon_physcannon", "weapon_physgun", "gmod_camera", "gmod_tool", "weapon_fists"}
CityRP.Configuration["Default RPName"] = {"Sean Steel", "Callum Wood", "Luke King", "Connor Zecon"}
CityRP.Configuration["Currency Symbol"] = "$"

TEAM_CITIZEN = CityRP.Team.Add("Citizen", {
	colour = Color(0,255,0),
	salary = 150,
	models = {
		"models/player/Group03/male_01.mdl",
		"models/player/Group03/male_02.mdl",
		"models/player/Group03/male_03.mdl",
		"models/player/Group03/male_04.mdl",
		"models/player/Group03/male_05.mdl",
		"models/player/Group03/male_06.mdl",
		"models/player/Group03/male_07.mdl",
		"models/player/Group03/male_08.mdl",
		"models/player/Group03/male_09.mdl"
	}
}) -- Move to seperate file