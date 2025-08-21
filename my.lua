-- Load Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()

-- Game Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

-- Local Variables
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- ESP and Zombie Tracking
local Zombies = {}
local ESPConnections = {}

-- Drawing System for ESP Skeleton
local Drawing = {}
local function CreateSkeletonESP(zombie)
    local humanoid = zombie:FindFirstChild("Humanoid")
    if not humanoid then return end

    local rig = {
        Head = zombie:FindFirstChild("Head"),
        LeftArm = zombie:FindFirstChild("Left Arm"),
        RightArm = zombie:FindFirstChild("Right Arm"),
        Torso = zombie:FindFirstChild("Torso"),
        LeftLeg = zombie:FindFirstChild("Left Leg"),
        RightLeg = zombie:FindFirstChild("Right Leg"),
    }

    for _, part in pairs(rig) do
        if part then
            local espPart = Drawing.new("Line")
            espPart.Color = Color3.new(1, 0, 0)
            espPart.Thickness = 2
            espPart.Transparency = 1
            Drawing[part] = espPart
        end
    end

    -- Update ESP positions
    task.spawn(function()
        while task.wait(0.1) do
            if not zombie or not zombie.Parent then break end
            for part, espPart in pairs(Drawing) do
                if part and espPart then
                    espPart.From = part.Position
                    espPart.To = (part.Name == "Head" and rig.Torso.Position) or
                                 (part.Name == "Torso" and (rig.LeftArm.Position or rig.RightArm.Position)) or
                                 (part.Name == "LeftArm" and rig.Head.Position) or
                                 (part.Name == "RightArm" and rig.Torso.Position) or
                                 (part.Name == "Left Leg" and rig.Torso.Position) or
                                 (part.Name == "Right Leg" and rig.Torso.Position)
                    espPart.Visible = true
                end
            end
        end
    end)
end

-- Initialize Orion Window
local Window = OrionLib:MakeWindow({
    Name = "Hunty Zombie ESP",
    IntroEnabled = true,
    IntroText = "Advanced Features",
    ConfigFolder = "HuntyZombieConfig"
})

-- Main Tab
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345875"
})

-- Toggle for ESP
MainTab:AddToggle({
    Name = "Skeleton ESP",
    Default = false,
    Callback = function(toggled)
        if toggled then
            for _, model in pairs(Workspace:GetDescendants()) do
                if model:IsA("Model") and model:FindFirstChild("Humanoid") then
                    CreateSkeletonESP(model)
                end
            end
            ESPConnections[#ESPConnections + 1] = Workspace.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("Model") and descendant:FindFirstChild("Humanoid") then
                    CreateSkeletonESP(descendant)
                end
            end)
        else
            for _, connection in pairs(ESPConnections) do
                connection:Disconnect()
            end
            ESPConnections = {}
            for _, drawing in pairs(Drawing) do
                drawing.Visible = false
                drawing:Remove()
            end
            Drawing = {}
        end
    end
})

-- Auto Farm Logic (Headshot)
local IsAutoFarming = false
MainTab:AddToggle({
    Name = "Auto Headshot Farm",
    Default = false,
    Callback = function(toggled)
        IsAutoFarming = toggled
        while IsAutoFarming do
            task.wait()
            local zombies = Workspace:GetDescendants()
            for _, model in pairs(zombies) do
                if model:IsA("Model") and model:FindFirstChild("Humanoid") and model:FindFirstChild("Head") then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, model.Head.Position)
                end
            end
        end
    end
})

-- Hooking Skills (Z, X, C) and Kill Aura (G)
local OldRemoteEvent = nil
MainTab:AddToggle({
    Name = "Auto Skills (Z, X, C)",
    Default = false,
    Callback = function(toggled)
        if toggled then
            OldRemoteEvent = hookmetamethod(game, "__namecall", function(Self, ...)
                local args = {...}
                if getnamecallmethod() == "FireServer" and tostring(Self) == "SkillRemoteEvent" then
                    args[1] = "UseSkill" -- Force the skill activation
                    return OldRemoteEvent(Self, unpack(args))
                end
                return OldRemoteEvent(Self, ...)
            end)
            task.spawn(function()
                while toggled do
                    task.wait(0.5) -- Anti-cooldown delay
                    ReplicatedStorage:FindFirstChild("SkillRemoteEvent"):FireServer("Z")
                    ReplicatedStorage:FindFirstChild("SkillRemoteEvent"):FireServer("X")
                    ReplicatedStorage:FindFirstChild("SkillRemoteEvent"):FireServer("C")
                end
            end)
        else
            if OldRemoteEvent then
                unhookmetamethod(game, "__namecall")
            end
        end
    end
})

local IsKillAuraActive = false
MainTab:AddToggle({
    Name = "Kill Aura (G)",
    Default = false,
    Callback = function(toggled)
        IsKillAuraActive = toggled
        while IsKillAuraActive do
            task.wait(0.5)
            ReplicatedStorage:FindFirstChild("CombatRemoteEvent"):FireServer("G")
        end
    end
})

-- No-Clip and Auto-Win
local IsNoClipping = false
MainTab:AddToggle({
    Name = "No-Clip",
    Default = false,
    Callback = function(toggled)
        IsNoClipping = toggled
        if toggled then
            task.spawn(function()
                while IsNoClipping do
                    if Character and Character:FindFirstChild("HumanoidRootPart") then
                        Character.HumanoidRootPart.CanCollide = false
                        task.wait()
                    end
                end
                if Character and Character:FindFirstChild("HumanoidRootPart") then
                    Character.HumanoidRootPart.CanCollide = true
                end
            end)
        end
    end
})

-- Auto-Win Logic (Teleport to Cloud)
local CloudPositions = {
    CFrame.new(0, 500, 0), -- Default cloud position
    CFrame.new(100, 500, 100),
    CFrame.new(-100, 500, -100)
}

MainTab:AddButton({
    Name = "Win (Cloud Teleport)",
    Callback = function()
        local rootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = CloudPositions[math.random(1, #CloudPositions)]
        end
    end
})

-- GodMode
local IsGodMode = false
MainTab:AddToggle({
    Name = "GodMode (Invincible)",
    Default = false,
    Callback = function(toggled)
        IsGodMode = toggled
        if toggled then
            local oldTakeDamage = nil
            oldTakeDamage = hookfunction(Humanoid.TakeDamage, function(self, ...)
                return oldTakeDamage
            end)
        else
            if gethook(Humanoid.TakeDamage) then
                unhookfunction(Humanoid.TakeDamage)
            end
        end
    end
})

-- Credits
local CreditsTab = Window:MakeTab({
    Name = "Credits",
    Icon = "rbxassetid://4483345875"
})

CreditsTab:AddLabel("Script by Developers")
CreditsTab:AddLabel("Using Orion Library Framework")
CreditsTab:AddButton("Copy License", function()
    setclipboard("Hunty-Zombie-Script-2024")
    OrionLib:MakeNotification({
        Name = "License Copied",
        Content = "License copied!",
        Time = 5
    })
end)

-- Cleanup
OrionLib:OnDestroy(function()
    for _, drawing in pairs(Drawing) do
        drawing.Visible = false
        drawing:Remove()
    end
    Drawing = {}
    for _, connection in pairs(ESPConnections) do
        connection:Disconnect()
    end
    ESPConnections = {}
end)

-- Start the Orion Library
OrionLib:MakeNotification({
    Name = "Script Loaded!",
    Content = "All features are ready to use!",
    Time = 5
})
