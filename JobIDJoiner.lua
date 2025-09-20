--// Simple Auto Joiner by overlordalex69 (sin UI, solo teleport por GameID o JobID)

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local LP = Players.LocalPlayer

local function notify(msg)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Autojoiner",
            Text = tostring(msg),
            Duration = 5
        })
    end)
end

if getgenv().JobID and type(getgenv().JobID) == "string" and #getgenv().JobID > 0 then
    -- Prioridad: Si hay JobID, unirse a ese
    if tostring(game.JobId) == tostring(getgenv().JobID) then
        notify("Ya estás en el JobID especificado.")
        return
    end
    pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, getgenv().JobID, LP)
    end)
elseif getgenv().GameID and tonumber(getgenv().GameID) then
    -- Si solo hay GameID, unirse a una instancia aleatoria de ese juego
    if game.PlaceId == tonumber(getgenv().GameID) then
        notify("Ya estás en el GameID especificado.")
        return
    end
    pcall(function()
        TeleportService:Teleport(tonumber(getgenv().GameID), LP)
    end)
else
    notify("Debes definir getgenv().JobID o getgenv().GameID antes de ejecutar este script.")
end
