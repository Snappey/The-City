if !SERVER then return end

local commands = {}
commands.Author = "Spai"
commands.Description = "Declares all gamemode commands!"

include("sv_commands.lua")

return commands