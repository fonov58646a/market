-- Load Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()

-- Initialize core services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Store zombies and connections
local Zombies = {}
local Connections = {}

-- Orion window
local Window = OrionLib:MakeWindow({
    Name = "Hunty Zombie",
    IntroEnabled = true,
    IntroText = "Hunty Zombie Fully Scripted",
    ConfigFolder = "HuntyZombie"
})

-- ESP Zombie Function
local function CreateESP(zombie)
    local espBox = Instance.new("BoxHandleAdornment", zombie:WaitForChild("HumanoidRootPart"))
    espBox.Adornee = zombie.HumanoidRootPart
    espBox.Color3 = Color3.new(1, 0, 0)
    espBox.Size = zombie.HumanoidRootPart.Size + Vector3.new(0.5, 0.5, 0.5)
    espBox.ZIndex = 2
    espBox.Transparency = 0.7
    return espBox
end

local function UpdateZombies()
    for _, zombie in ipairs(workspace:GetDescendants()) do
        if zombie:IsA("Model") and zombie:FindFirstChild("HumanoidRootPart") then
            if not table.find(Zombies, zombie) then
                table.insert(Zombies, zombie)
                CreateESP(zombie)
            end
        end
    end
end

-- Auto Farm Logic
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

-- Main Features Tab
local MainTab = Window:MakeTab({
    Name = "Features",
    Icon = "rbxassetid://4483345875"
})

-- ESP Toggle
local EspToggle = MainTab:AddToggle({
    Name = "Zombie ESP",
    Default = false,
    Callback = function(Value)
        if Value then
            UpdateZombies()
            Connections[#Connections + 1] = Workspace.DescendantAdded:Connect(function(Obj)
                if Obj:IsA("Model") and Obj:FindFirstChild("HumanoidRootPart") then
                    table.insert(Zombies, Obj)
                    CreateESP(Obj)
                end
            end)
        else
            for _, Zombie in ipairs(Zombies) do
                if Zombie:FindFirstChild("BoxHandleAdornment") then
                    Zombie.BoxHandleAdornment:Destroy()
                end
            end
            for _, Conn in ipairs(Connections) do
                pcall(function()
                    Conn:Disconnect()
                end)
            end
            Zombies = {}
        end
    end
})

-- Auto Farm
local IsAutoFarming = false
local AutoFarmToggle = MainTab:AddToggle({
    Name = "Auto Farm (Headshot)",
    Default = false,
    Callback = function(Value)
        IsAutoFarming = Value
        if Value then
            while IsAutoFarming do
                local ClosestZombie = FindClosestZombie()
                if ClosestZombie and ClosestZombie:FindFirstChild("Head") then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, ClosestZombie.Head.Position)
                end
                RunService.Heartbeat:Wait()
            end
        end
    end
})

-- Auto Skills
local IsAutoSkill = false
local AutoSkillToggle = MainTab:AddToggle({
    Name = "Auto Skills (Z, X, C)",
    Default = false,
    Callback = function(Value)
        IsAutoSkill = Value
        if Value then
            while IsAutoSkill do
                VirtualUser:ClickButton2(Vector2.new())
                VirtualUser:SetKeyDown(Enum.KeyCode.Z, true)
                VirtualUser:SetKeyDown(Enum.KeyCode.X, true)
                VirtualUser:SetKeyDown(Enum.KeyCode.C, true)
                wait(0.15 + math.random() * 0.05) -- Randomized delay
                VirtualUser:SetKeyDown(Enum.KeyCode.Z, false)
                VirtualUser:SetKeyDown(Enum.KeyCode.X, false)
                VirtualUser:SetKeyDown(Enum.KeyCode.C, false)
                wait(0.6 + math.random() * 0.2) -- Anti-cooldown
            end
        end
    end
})

-- Kill Aura
local IsKillAura = false
local KillAuraToggle = MainTab:AddToggle({
    Name = "Auto G (Kill Aura)",
    Default = false,
    Callback = function(Value)
        IsKillAura = Value
        if Value then
            while IsKillAura do
                VirtualUser:ClickButton2(Vector2.new())
                VirtualUser:SetKeyDown(Enum.KeyCode.G, true)
                wait(0.15 + math.random() * 0.05)
                VirtualUser:SetKeyDown(Enum.KeyCode.G, false)
                wait(0.6 + math.random() * 0.2)
            end
        end
    end
})

-- No-Clip
local IsNoClipping = false
local NoClipToggle = MainTab:AddToggle({
    Name = "NoClip",
    Default = false,
    Callback = function(Value)
        IsNoClipping = Value
        if Value then
            while IsNoClipping do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.WalkSpeed = 100
                    LocalPlayer.Character.Humanoid.JumpPower = 150
                    LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                end
                RunService.Heartbeat:Wait()
            end
        else
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Land)
            end
        end
    end
})

-- Enhanced Auto-Win (Cloud Safe)
local AutoWinToggle = MainTab:AddButton({
    Name = "Auto Win (On Cloud)",
    Callback = function()
        for _, cloud in ipairs(Workspace:GetDescendants()) do
            if cloud.Name:lower():find("cloud") and cloud:IsA("Part") then
                local targetPosition = cloud.CFrame + Vector3.new(0, 10, 0)
                LocalPlayer.Character.HumanoidRootPart.CFrame = targetPosition
                break
            end
        end
    end
})

-- GodMode
local OriginalTakeDamage
local IsGodMode = false
local GodModeToggle = MainTab:AddToggle({
    Name = "GodMode",
    Default = false,
    Callback = function(Value)
        IsGodMode = Value
        if Value then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                OriginalTakeDamage = LocalPlayer.Character.Humanoid.TakeDamage
                LocalPlayer.Character.Humanoid.TakeDamage = function()
                    return nil
                end
            end
        else
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.TakeDamage = OriginalTakeDamage
            end
        end
    end
})

-- Credits Tab
local CreditsTab = Window:MakeTab({
    Name = "Credits",
    Icon = "rbxassetid://4483345875"
})
CreditsTab:AddLabel("Script made by Kimi Dev Team")
CreditsTab:AddLabel("Integrated with Orion Library")

-- Notification on load
OrionLib:MakeNotification({
    Name = "Script Loaded",
    Content = "All features are ready to use!",
    Time = 5
})

-- Cleanup on script close
OrionLib:OnDestroy(function()
    for _, Zombie in ipairs(Zombies) do
        if Zombie:FindFirstChild("BoxHandleAdornment") then
            Zombie.BoxHandleAdornment:Destroy()
        end
    end
    for _, Conn in ipairs(Connections) do
        pcall(function()
            Conn:Disconnect()
        end)
    end
    Zombies = {}
end)

-- Start Orion
OrionLib:Init()
