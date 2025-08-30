-- VortX Hub | Kill Streak
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Player
local LocalPlayer = Players.LocalPlayer

-- Remote
local HitRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Hit")
if not HitRemote then
    OrionLib:MakeNotification({Name = "Error", Content = "Remote 'Hit' not found!", Time = 5})
    return
end

-- ESP
local espEnabled = false
local highlightFolder = Instance.new("Folder")
highlightFolder.Name = "VortXHighlights"
highlightFolder.Parent = game.CoreGui

local function addPlayerESP(player)
    if not espEnabled then return end
    local char = player.Character or player.CharacterAdded:Wait()
    if char and not char:FindFirstChild("VortXESP") then
        local hl = Instance.new("Highlight")
        hl.Name = "VortXESP"
        hl.Adornee = char
        hl.FillColor = Color3.fromRGB(255, 0, 0)
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0
        hl.Parent = highlightFolder
    end
end

local function removeAllESP()
    for _, v in ipairs(highlightFolder:GetChildren()) do
        v:Destroy()
    end
end

local function updateESP()
    removeAllESP()
    if espEnabled then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                addPlayerESP(p)
            end
        end
    end
end

-- Features
local killAuraEnabled = false
local autoAttackEnabled = false

local function attackNearest()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local closest = nil
    local maxDist = 30

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local targetRoot = p.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local dist = (targetRoot.Position - root.Position).Magnitude
                if dist <= maxDist then
                    closest = p
                end
            end
        end
    end

    if closest then
        HitRemote:FireServer({})
    end
end

-- Loop
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

-- Auto refresh ESP on player join/leave
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        if espEnabled then
            addPlayerESP(p)
        end
    end)
end)

Players.PlayerRemoving:Connect(function()
    updateESP()
end)

-- Initial
updateESP()
OrionLib:Init()
