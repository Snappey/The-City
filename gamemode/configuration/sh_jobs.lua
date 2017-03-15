
TEAM_CITIZEN = CityRP.Team.Add("Citizen", {
	colour = Color(25, 150, 25),
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
}) -- TODO: Move to seperate file

TEAM_REBEL = CityRP.Team.Add("Rebel", {
	colour = Color(100,100,100),
	salary = 50,
	models = {
		"models/player/Group03/male_01.mdl"
	}
})

TEAM_REBELLEADER = CityRP.Team.Add("Rebel Leader", {
	colour = Color(140,140,140),
	salary = 50,
	limit = 1,
	models = {
		"models/player/Group03/male_03.mdl"
	}
})

TEAM_GUNDEALER = CityRP.Team.Add("Gun Dealer", {
	colour = Color(255,140,0),
	salary = 250,
	limit = 3,
	models = {
		"models/player/monk.mdl"
	}
})

TEAM_TAXI = CityRP.Team.Add("Taxi", {
	colour = Color(255,204,0),
	salary = 100,
	limit = 4,
	models = {
		"models/player/Hostage/Hostage_01.mdl"
	}
})

TEAM_POLICE = CityRP.Team.Add("Police", {
	colour = Color(50,50,255),
	salary = 300,
	limit = 6,
	models = {
		"models/player/police.mdl"
	}
})

TEAM_POLICECHIEF = CityRP.Team.Add("Police Chief", {
	colour = Color(75,150,255),
	salary = 350,
	limit = 1,
	models = {
		"models/player/combine_soldier_prisonguard.mdl"
	}
})

TEAM_PRESIDENT = CityRP.Team.Add("President", {
	colour = Color(255,50,25),
	salary = 500,
	limit = 1,
	models = {
		"models/player/breen.mdl"
	}
})