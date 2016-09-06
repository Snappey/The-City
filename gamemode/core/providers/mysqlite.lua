
local SQL = {}

function SQL.Connect() 
	return true
end

function SQL.CheckTable(tablename, onSuccess, onError)
	if sql.TableExists(tablename) then 
		onSuccess()
	else
		onError()
	end
end

function SQL.Query(query, callback)
	--local query = sql.SQLStr(query)
	local res = sql.Query(query)

	if callback == nil then return end
	if res == false then callback(sql.LastError()) return elseif res == nil then callback({}) return end
	callback(res)
end

return SQL