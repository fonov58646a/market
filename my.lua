-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Variables
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Remote for attacking
local HitRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Hit")

-- ESP Variables
local espEnabled = false
local highlightFolder = Instance.new("Folder")
highlightFolder.Name = "VortXHighlights"
highlightFolder.Parent = game.CoreGui

-- Function to add ESP to a player
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

-- Function to remove all ESP highlights
local function removeAllESP()
    for _, highlight in ipairs(highlightFolder:GetChildren()) do
        highlight:Destroy()
    end
end

-- Function to update ESP
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

-- Function to attack the nearest player
local function attackNearest()
    local closest = nil
    local minDist = 30
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local dist = (targetRoot.Position - root.Position).Magnitude
                if dist <= minDist then
                    closest = player
                end
            end
        end
    end

    if closest then
        HitRemote:FireServer({})
    end
end

-- Main loop for attacking
RunService.Heartbeat:Connect(function()
    if killAuraEnabled or autoAttackEnabled then
        attackNearest()
    end
end)

-- Create Rayfield Window
local Window = Rayfield:CreateWindow({
    Name = "VortX Hub | Kill Streak",
    LoadingTitle = "VortX Hub",
    Theme = 'Default',
    Icon = 4483362458,
    LoadingSubtitle = "by VortX",
    ConfigurationSaving = {
        Enabled = false,
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false,
})

-- Create Tab
local MainTab = Window:CreateTab("Main", 4483362458)

-- Create Kill Aura Toggle
local killAuraEnabled = false
MainTab:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = killAuraEnabled,
    Callback = function(value)
        killAuraEnabled = value
    end,
})

-- Create Auto Attack Toggle
local autoAttackEnabled = false
MainTab:CreateToggle({
    Name = "Auto Attack",
    CurrentValue = autoAttackEnabled,
    Callback = function(value)
        autoAttackEnabled = value
    end,
})

-- Create ESP Toggle
MainTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = espEnabled,
    Callback = function(value)
        espEnabled = value
        updateESP()
    end,
})

-- Update ESP when players join or leave
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if espEnabled then
            addPlayerESP(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    updateESP()
end)

-- Initial ESP setup
updateESP()
