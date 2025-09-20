--// Autojoiner by overlordalex69 - Version solo GameID, sin UI, teleporta directo

-- Servicios
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local LP = Players.LocalPlayer

-- Validar GameID
if not getgenv().GameID or not tonumber(getgenv().GameID) then
    warn("[Autojoiner] No se proporcionó un GameID válido en getgenv().GameID. Deteniendo script.")
    return
end

-- Si ya estás en ese juego, no hace nada especial
if game.PlaceId == tonumber(getgenv().GameID) then
    warn("[Autojoiner] Ya estás en el GameID especificado ("..tostring(getgenv().GameID).."). No se realizará teleport.")
    return
end

-- Teleportar a una instancia pública aleatoria de ese GameID
local success, err = pcall(function()
    TeleportService:Teleport(tonumber(getgenv().GameID), LP)
end)

if not success then
    warn("[Autojoiner] Falló el teleport: " .. tostring(err))
end
