--// JobID-Joiner-Roblox by awaitlol. on Discord!

--// Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer

--// Auto-fallback for GameID
if not getgenv().GameID then
    warn("[JobId Joiner] No GameID provided, defaulting to current PlaceId.")
    getgenv().GameID = game.PlaceId
end

-- Check if current game matches chosen GameID
if game.PlaceId ~= getgenv().GameID then
    warn("[JobId Joiner] You are not in the target GameID right now.")
end

--// Load Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "JobId Joiner",
    LoadingTitle = "JobId Joiner",
    LoadingSubtitle = "by awaitlol",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

local MainTab = Window:CreateTab("Joiner", 4483362458)

--// Notify Game Info
task.spawn(function()
    local success, result = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games?universeIds=" .. tostring(game.GameId))
    end)

    if success and result then
        local data = HttpService:JSONDecode(result)
        local gameName = data.data and data.data[1] and data.data[1].name or "Unknown"

        Rayfield:Notify({
            Title = "Game Detected!",
            Content = "Game name: " .. tostring(gameName),
            Duration = 6,
            Image = 4483362458,
        })
    else
        Rayfield:Notify({
            Title = "Game Detection Failed",
            Content = "Could not fetch game name.",
            Duration = 6,
            Image = 4483362458,
        })
    end
end)

--// Helpers
local function notify(title, content, duration)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration or 4,
        Image = 4483362458,
    })
end

local function joinJob(jobId)
    if type(jobId) ~= "string" or jobId == "" then
        notify("Invalid JobId", "Please enter a valid JobId.")
        return
    end

    notify("Teleporting…", "Attempting to join JobId", 5)

    local ok, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(getgenv().GameID, jobId, LP)
    end)
    if not ok then
        notify("Teleport failed", tostring(err))
    end
end

--// UI
local currentInput = ""

MainTab:CreateInput({
    Name = "JobId",
    PlaceholderText = "Paste JobId here",
    RemoveTextAfterFocusLost = false,
    Callback = function(value)
        currentInput = tostring(value or "")
    end,
})

MainTab:CreateButton({
    Name = "Join JobId",
    Callback = function()
        joinJob(currentInput)
    end,
})

MainTab:CreateButton({
    Name = "Rejoin This Server",
    Callback = function()
        if game.JobId and #game.JobId > 0 then
            joinJob(game.JobId)
        else
            notify("No JobId", "This server has no JobId (studio/test?)")
        end
    end,
})

MainTab:CreateButton({
    Name = "Copy Current JobId",
    Callback = function()
        local jid = tostring(game.JobId or "")
        if jid == "" then
            notify("No JobId", "Current session has no JobId to copy.")
            return
        end
        if setclipboard then
            setclipboard(jid)
            notify("Copied", "JobId copied to clipboard.")
        else
            notify("Clipboard unavailable", "Your executor doesn't support setclipboard.")
        end
    end,
})

MainTab:CreateButton({
    Name = "Copy Current GameId",
    Callback = function()
        local gid = tostring(game.PlaceId or "")
        if gid == "" then
            notify("No GameId", "Current session has no GameId to copy.")
            return
        end
        if setclipboard then
            setclipboard(gid)
            notify("Copied", "GameId copied to clipboard.")
        else
            notify("Clipboard unavailable", "Your executor doesn't support setclipboard.")
        end
    end,
})
