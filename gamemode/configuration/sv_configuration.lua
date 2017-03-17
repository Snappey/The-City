
CityRP.Configuration["Data-Provider"] = "MySQL"

CityRP.Configuration["SQL-IP"] = "127.0.0.1"
CityRP.Configuration["SQL-Username"] = "root"
CityRP.Configuration["SQL-Password"] = ""
CityRP.Configuration["SQL-Database"] = "city"
CityRP.Configuration["SQL-Port"] = 3306

CityRP.Configuration["Default Items"] = {
	["ent_class"] = 5
}


--[[

CREATE TABLE `city`.`city_data` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `desc` VARCHAR(45) NULL,
  `money` INT UNSIGNED NULL,
  `gender` BIT(1) NULL,
  `playtime` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


CREATE TABLE `city`.`city_items` (
  `id` INT NOT NULL,
  `item` VARCHAR(45) NULL,
  `amt` INT NULL,
  PRIMARY KEY (`id`));



]]