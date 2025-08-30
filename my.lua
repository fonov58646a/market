-- VortX Hub | Kill Streak
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()

-- Game services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Player
local LocalPlayer = Players.LocalPlayer

-- Remote detection
local HitRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Hit")
if not HitRemote then
    OrionLib:MakeNotification({Name = "Error", Content = "RemoteEvent 'Hit' not found!", Time = 5})
    return
end

-- ESP variables
local espEnabled = false
local highlightFolder = Instance.new("Folder")
highlightFolder.Name = "VortXHighlights"
highlightFolder.Parent = game.CoreGui

-- Utility: Add ESP to a player
local function addPlayerESP(player)
    if not espEnabled then return end
    local character = player.Character or player.CharacterAdded:Wait()
    if character and not character:FindFirstChild("VortXESP") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "VortXESP"
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = highlightFolder
    end
end

-- Utility: Remove all ESP
local function removeAllESP()
    for _, highlight in ipairs(highlightFolder:GetChildren()) do
        highlight:Destroy()
    end
end

-- Utility: Update ESP
local function updateESP()
    removeAllESP()
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                addPlayerESP(player)
            end
        end
    end
end

-- Kill aura & auto attack
local killAuraEnabled = false
local autoAttackEnabled = false

local function attackNearest()
    local closest = nil
    local maxDist = 30
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local dist = (targetRoot.Position - root.Position).Magnitude
                if dist <= maxDist then
                    closest = player
                end
            end
        end
    end

    if closest then
        HitRemote:FireServer({})
    end
end

-- Main loop
RunService.Heartbeat:Connect(function()
    if killAuraEnabled or autoAttackEnabled then
        attackNearest()
    end
end)

-- UI
local Window = OrionLib:MakeWindow({
    Name = "VortX Hub | Kill Streak",
    HidePremium = false,
    SaveConfig = false,
    IntroEnabled = false
})

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345875"
})

MainTab:AddToggle({
    Name = "Kill Aura",
    Default = false,
    Callback = function(val)
        killAuraEnabled = val
    end
})

MainTab:AddToggle({
    Name = "Auto Attack",
    Default = false,
    Callback = function(val)
        autoAttackEnabled = val
    end
})

MainTab:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(val)
        espEnabled = val
        updateESP()
    end
})

-- Handle new players joining
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if espEnabled then
            addPlayerESP(player)
        end
    end)
end)

-- Handle players leaving
Players.PlayerRemoving:Connect(function(player)
    updateESP()
end)

-- Initial ESP setup
updateESP()

OrionLib:Init()
