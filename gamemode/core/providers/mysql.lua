
local SQL = {}
require("mysqloo")

if !mysqloo then error("MySQLoo not installed!") end

SQL.queue = {}


function SQL.Connect()
	if db && mysqloo.DATABASE_CONNECTED then return db end
	db = mysqloo.connect(util.GetConfig("SQL-IP"),util.GetConfig("SQL-Username"),util.GetConfig("SQL-Password"),util.GetConfig("SQL-Database"),util.GetConfig("SQL-Port"))

	function db:onConnected()
		MsgC(XLBLUE, "[DATA]: ",WHITE ,"Successfuly connected to MySQL Server! ( " .. util.GetConfig("SQL-IP") .. " )\n")

		for k,v in pairs(SQL.queue) do
			SQL.Query(v[1], v[2])
		end
	end

	function db:onConnectionFailed(err)
		MsgC(XLBLUE, "[DATA]: ",WHITE ,"Failed to connect to database! ERROR: " .. err .. "\n")
	end

	db:connect()
	return db
end

function SQL.Query(qur, callback)
	print(qur, "QUERY IS BEING RUN")
	q = db:query(qur)

	if q == nil then table.insert(SQL.queue, {qur, callback}) return end
	function q:onSuccess(data)
		if callback == nil then return end 
		callback(data) -- data:getData() was causing an error
	end

	function q:onError(err)
		if db:status() == mysqloo.DATABASE_NOT_CONNECTED then
			table.insert(SQL.queue, {qur,callback})
			db:connect()
		end
		MsgC(RED, err)
	end

	q:start()
	return q
end


function SQL.CheckTable(tablename, onSuccess, onError)
	SQL.Query("SHOW TABLES LIKE '" .. string.lower(tablename) .. "'", function(data)
		local data = data
		if #data == 0 then
			onError()
		else
			onSuccess()
		end
	end)
end

return SQL