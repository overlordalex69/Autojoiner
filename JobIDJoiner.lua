--// JobID Auto-Joiner (no UI) - by overlordalex69, basado en awaitlol

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local LP = Players.LocalPlayer

local function simpleNotify(msg)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "JobID Joiner",
            Text = tostring(msg),
            Duration = 5
        })
    end)
end

-- Validar JobID
if not getgenv().JobID or type(getgenv().JobID) ~= "string" or #getgenv().JobID == 0 then
    warn("[JobId Joiner] No se proporcionó un JobID válido en getgenv().JobID. Deteniendo script.")
    simpleNotify("No se proporcionó un JobID válido en getgenv().JobID.")
    return
end

local GameID = game.PlaceId

-- Si ya estás en ese JobId, avisar y no hacer nada
if tostring(game.JobId) == tostring(getgenv().JobID) then
    warn("[JobId Joiner] Ya estás en el JobID especificado ("..getgenv().JobID..").")
    simpleNotify("Ya estás en el JobID especificado.")
    return
end

-- Teleportar al JobId
simpleNotify("Intentando unirse al JobID...")
local success, err = pcall(function()
    TeleportService:TeleportToPlaceInstance(GameID, getgenv().JobID, LP)
end)

if not success then
    warn("[JobId Joiner] Falló el teleport: " .. tostring(err))
    simpleNotify("Falló el teleport: " .. tostring(err))
else
    simpleNotify("Teleport realizado, espera unos segundos...")
end
