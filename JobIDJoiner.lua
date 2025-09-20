--// JobID-Joiner-Roblox by awaitlol. on Discord!
--// Versión sin UI/Menu, solo teleporta automáticamente al JobId indicado por el usuario.
--// El usuario debe definir getgenv().GameID y getgenv().JobID antes de ejecutar este script.
--// Ejemplo en el executor:
--// getgenv().GameID = 123456789
--// getgenv().JobID = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
--// loadstring(game:HttpGet("https://raw.githubusercontent.com/awaitlol/JobID-Joiner-Roblox/refs/heads/main/JobIDJoiner.lua",true))()

--// Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local LP = Players.LocalPlayer

--// Validar que GameID y JobID están definidos
if not getgenv().GameID or not tonumber(getgenv().GameID) then
    warn("[JobId Joiner] No GameID válido proporcionado en getgenv().GameID. Deteniendo script.")
    return
end

if not getgenv().JobID or type(getgenv().JobID) ~= "string" or #getgenv().JobID == 0 then
    warn("[JobId Joiner] No JobID válido proporcionado en getgenv().JobID. Deteniendo script.")
    return
end

--// Si ya está en el juego correcto pero en diferente JobId, teleporta
if game.PlaceId ~= tonumber(getgenv().GameID) then
    warn("[JobId Joiner] Estás en otro juego. El script intentará teletransportar al GameID y JobID especificados.")
end

--// Intentar teletransportar al JobId dado
local success, err = pcall(function()
    TeleportService:TeleportToPlaceInstance(tonumber(getgenv().GameID), getgenv().JobID, LP)
end)

if not success then
    warn("[JobId Joiner] Fallo al teletransportar: " .. tostring(err))
end
