--// Auto Teleport to JobId by overlordalex69 (basado en awaitlol)
--// Sin UI, solo teleport automático al JobId si está definido

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local LP = Players.LocalPlayer

-- Validar existencia de JobID
if not getgenv().JobID or type(getgenv().JobID) ~= "string" or #getgenv().JobID == 0 then
    warn("[JobId Joiner] No se proporcionó un JobID válido en getgenv().JobID. Deteniendo script.")
    return
end

-- Usar el PlaceId actual
local GameID = game.PlaceId

-- Si ya estas en ese JobId, no hacer nada
if tostring(game.JobId) == tostring(getgenv().JobID) then
    warn("[JobId Joiner] Ya estás en el JobID especificado ("..getgenv().JobID..").")
    return
end

-- Teleport directo al JobId
local success, err = pcall(function()
    TeleportService:TeleportToPlaceInstance(GameID, getgenv().JobID, LP)
end)

if not success then
    warn("[JobId Joiner] Falló el teleport: " .. tostring(err))
end
