--// JobID-Joiner-Roblox Auto Only Join - by overlordalex69, basado en awaitlol
--// Sin UI ni menus, solo teleport directo al JobId definido

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local LP = Players.LocalPlayer

-- Utilidad para notificación simple en pantalla
local function notify(title, content, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = tostring(content),
            Duration = duration or 5
        })
    end)
end

-- 1. Validar JobID proporcionado por usuario
if not getgenv().JobID or type(getgenv().JobID) ~= "string" or #getgenv().JobID < 5 then
    warn("[JobId Joiner] No se proporcionó JobID válido en getgenv().JobID")
    notify("JobID Joiner", "No se proporcionó JobID válido en getgenv().JobID", 8)
    return
end

-- 2. Tomar GameID automaticamente (experiencia actual)
local GameID = game.PlaceId

-- 3. Si ya estás en ese JobID, no hacer nada
if tostring(game.JobId) == tostring(getgenv().JobID) then
    warn("[JobId Joiner] Ya estás en el JobID especificado.")
    notify("JobID Joiner", "Ya estás en el JobID especificado.", 6)
    return
end

-- 4. Hacer solicitud HTTPS para verificar si el Job existe (opcional, pero recomendado)
local function jobExists(gameId, jobId)
    local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(gameId)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if not success then return false end
    local data
    pcall(function() data = HttpService:JSONDecode(response) end)
    if not data or not data.data then return false end
    for _, server in ipairs(data.data) do
        if server.id == jobId then
            return true
        end
    end
    return false
end

-- 5. Intentar teleport
if jobExists(GameID, getgenv().JobID) then
    notify("JobID Joiner", "Uniéndote al JobID...", 5)
    local ok, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(GameID, getgenv().JobID, LP)
    end)
    if not ok then
        warn("[JobId Joiner] Falló el teleport: " .. tostring(err))
        notify("JobID Joiner", "Falló el teleport: " .. tostring(err), 8)
    end
else
    warn("[JobId Joiner] El JobID no existe o no es público.")
    notify("JobID Joiner", "El JobID no existe o no es público.", 8)
end
