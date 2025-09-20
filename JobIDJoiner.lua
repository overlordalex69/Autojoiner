--// Autojoiner JobID - Versión automática SIN UI, solo teleport a JobID

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local LP = Players.LocalPlayer

-- Validar JobID
if not getgenv().JobID or type(getgenv().JobID) ~= "string" or #getgenv().JobID == 0 then
    warn("[Autojoiner] No se proporcionó un JobID válido en getgenv().JobID. Deteniendo script.")
    return
end

-- Tomar GameID de la experiencia actual
local GameID = game.PlaceId

-- Si ya estás en ese JobId, no hacer nada
if tostring(game.JobId) == tostring(getgenv().JobID) then
    warn("[Autojoiner] Ya estás en el JobID especificado ("..getgenv().JobID..").")
    return
end

-- Teleportar al JobID
local success, err = pcall(function()
    TeleportService:TeleportToPlaceInstance(GameID, getgenv().JobID, LP)
end)

if not success then
    warn("[Autojoiner] Falló el teleport: " .. tostring(err))
end
