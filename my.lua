-- Load Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()

-- Initialize variables
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Camera = workspace.CurrentCamera

-- Store zombies
local Zombies = {}
local Connections = {}

-- Create Orion window
local Window = OrionLib:MakeWindow({
    Name = "Hunty Zombie",
    IntroEnabled = true,
    IntroText = "Hunty Zombie Hack",
    ConfigFolder = "HuntyZombieConfig"
})

-- ESP Functions
local function CreateESP(zombie)
    local esp = Instance.new("BoxHandleAdornment")
    esp.Adornee = zombie:WaitForChild("HumanoidRootPart")
    esp.Color3 = Color3.new(1, 0, 0)
    esp.Size = zombie.HumanoidRootPart.Size + Vector3.new(0.5, 0.5, 0.5)
    esp.ZIndex = 2
    esp.Transparency = 0.7
    
    return esp
end

-- Auto Farm Functions
local function FindClosestZombie()
    local Closest = nil
    local MinDistance = math.huge
    
    for _, Zombie in ipairs(Zombies) do
        if Zombie.Humanoid.Health > 0 then
            local Distance = (Zombie.HumanoidRootPart.Position - Camera.CFrame.Position).Magnitude
            if Distance < MinDistance then
                MinDistance = Distance
                Closest = Zombie
            end
        end
    end
    
    return Closest
end

-- Main Features
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "http://www.roblox.com/asset/?id=6028608201"
})

-- ESP Toggle
MainTab:AddToggle({
    Name = "ESP Zombies",
    Default = false,
    Callback = function(Value)
        if Value then
            for _, Zombie in ipairs(workspace:GetDescendants()) do
                if Zombie:IsA("Model") and Zombie:FindFirstChild("Humanoid") then
                    table.insert(Zombies, Zombie)
                    CreateESP(Zombie)
                end
            end
            
            Connections[#Connections+1] = workspace.DescendantAdded:Connect(function(Obj)
                if Obj:IsA("Model") and Obj:FindFirstChild("Humanoid") then
                    table.insert(Zombies, Obj)
                    CreateESP(Obj)
                end
            end)
        else
            for _, Zombie in ipairs(Zombies) do
                if Zombie:FindFirstChild("ESP") then
                    Zombie.ESP:Destroy()
                end
            end
            for _, Conn in ipairs(Connections) do Conn:Disconnect() end
            Zombies = {}
        end
    end
})

-- Auto Farm
local IsAutoFarming = false
MainTab:AddToggle({
    Name = "Auto Farm Headshot",
    Default = false,
    Callback = function(Value)
        IsAutoFarming = Value
        if Value then
            while IsAutoFarming do
                local Closest = FindClosestZombie()
                if Closest and Closest:FindFirstChild("Head") then
                    Camera.CameraType = Enum.CameraType.Scriptable
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, Closest.Head.Position)
                end
                RunService.Heartbeat:Wait()
            end
            Camera.CameraType = Enum.CameraType.Custom
        end
    end
})

-- Auto Skills
local IsAutoSkill = false
MainTab:AddToggle({
    Name = "Auto Skills (Z, X, C)",
    Default = false,
    Callback = function(Value)
        IsAutoSkill = Value
        if Value then
            while IsAutoSkill do
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
                VirtualUser:SetKeyDown(Enum.KeyCode.Z, true)
                VirtualUser:SetKeyDown(Enum.KeyCode.X, true)
                VirtualUser:SetKeyDown(Enum.KeyCode.C, true)
                wait(0.1)
                VirtualUser:SetKeyDown(Enum.KeyCode.Z, false)
                VirtualUser:SetKeyDown(Enum.KeyCode.X, false)
                VirtualUser:SetKeyDown(Enum.KeyCode.C, false)
                wait(0.5) -- Anti cooldown
            end
        end
    end
})

-- Kill Aura
local IsKillAura = false
MainTab:AddToggle({
    Name = "Auto G (Kill Aura)",
    Default = false,
    Callback = function(Value)
        IsKillAura = Value
        if Value then
            while IsKillAura do
                VirtualUser:ClickButton2(Vector2.new())
                VirtualUser:SetKeyDown(Enum.KeyCode.G, true)
                wait(0.1)
                VirtualUser:SetKeyDown(Enum.KeyCode.G, false)
                wait(0.5) -- Anti cooldown
            end
        end
    end
})

-- NoClip
local IsNoClipping = false
MainTab:AddToggle({
    Name = "NoClip",
    Default = false,
    Callback = function(Value)
        IsNoClipping = Value
        if Value then
            while IsNoClipping do
                if Character and Character:FindFirstChild("Humanoid") then
                    Character.Humanoid.WalkSpeed = 50
                    Character.Humanoid.JumpPower = 100
                    Humanoid:ChangeState(11)
                end
                RunService.Heartbeat:Wait()
            end
        else
            if Character and Character:FindFirstChild("Humanoid") then
                Humanoid:ChangeState(5)
            end
        end
    end
})

-- Auto Win
MainTab:AddButton({
    Name = "Auto Win (Teleport)",
    Callback = function()
        if Character then
            Character.HumanoidRootPart.CFrame = CFrame.new(0, 1000, 0)
        end
    end
})

-- GodMode
local IsGodMode = false
MainTab:AddToggle({
    Name = "GodMode",
    Default = false,
    Callback = function(Value)
        IsGodMode = Value
        if Value and Character then
            local OldDamage = Humanoid.TakeDamage
            Humanoid.TakeDamage = function() end
        else
            if Character and Humanoid.TakeDamage then
                Humanoid.TakeDamage = OldDamage
            end
        end
    end
})

-- Credits Tab
local CreditsTab = Window:MakeTab({
    Name = "Credits",
    Icon = "http://www.roblox.com/asset/?id=6028608201"
})

CreditsTab:AddLabel("Script made by Orion Library Team")
CreditsTab:AddLabel("Hunty Zombie script by Developer")
CreditsTab:AddButton("Copy License", function()
    setclipboard("Hunty-Zombie-Script-2023")
    OrionLib:MakeNotification({
        Name = "License Copied",
        Content = "License key copied to clipboard",
        Time = 5
    })
end)

-- Save settings on close
OrionLib:Init()

-- Destroy on exit
OrionLib:OnDestroy(function()
    for _, Zombie in ipairs(Zombies) do
        if Zombie:FindFirstChild("ESP") then
            Zombie.ESP:Destroy()
        end
    end
    for _, Conn in ipairs(Connections) do Conn:Disconnect() end
end)

-- Start Orion
OrionLib:MakeNotification({
    Name = "Script Loaded",
    Content = "All features ready to use!",
    Time = 5
})
