-- Load Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()

-- Game Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

-- Local Player
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

-- Zombie Tracking
local Zombies = {}
local ESPBoxes = {}

-- Orion Library Window
local Window = OrionLib:MakeWindow({
    Name = "Hunty Zombie",
    IntroEnabled = true,
    IntroText = "Hunty Zombie Script",
    ConfigFolder = "HuntyZombieConfigs"
})

-- Main Tab
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345875"
})

-- ESP Feature
local ESPEnabled = false
MainTab:AddToggle({
    Name = "ESP Zombies",
    Default = false,
    Callback = function(Value)
        ESPEnabled = Value
        if Value then
            for _, Zombie in ipairs(workspace:GetDescendants()) do
                if Zombie:IsA("Model") and Zombie:FindFirstChild("HumanoidRootPart") then
                    table.insert(Zombies, Zombie)
                    local espBox = Instance.new("BoxHandleAdornment")
                    espBox.Adornee = Zombie.HumanoidRootPart
                    espBox.Size = Zombie.HumanoidRootPart.Size + Vector3.new(0.5, 0.5, 0.5)
                    espBox.Color3 = Color3.new(1, 0, 0)
                    espBox.Transparency = 0.7
                    espBox.ZIndex = 2
                    espBox.Parent = Zombie
                    table.insert(ESPBoxes, espBox)
                end
            end
        else
            for _, Box in ipairs(ESPBoxes) do
                Box:Destroy()
            end
            ESPBoxes = {}
            Zombies = {}
        end
    end
})

-- Auto Farm Headshots
local IsAutoFarming = false
MainTab:AddToggle({
    Name = "Auto Farm Headshots",
    Default = false,
    Callback = function(Value)
        IsAutoFarming = Value
        if Value then
            Camera.CameraType = Enum.CameraType.Scriptable
            while IsAutoFarming and wait(0.1) do
                local ClosestZombie = nil
                local MinDistance = math.huge

                for _, Zombie in ipairs(workspace:GetDescendants()) do
                    if Zombie:IsA("Model") and Zombie:FindFirstChild("Head") then
                        local Distance = (Zombie.Head.Position - Camera.CFrame.Position).Magnitude
                        if Distance < MinDistance then
                            MinDistance = Distance
                            ClosestZombie = Zombie
                        end
                    end
                end

                if ClosestZombie then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, ClosestZombie.Head.Position)
                end
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
            while IsAutoSkill and wait(0.15) do
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
                VirtualUser:SetKeyDown(Enum.KeyCode.Z, true)
                VirtualUser:SetKeyDown(Enum.KeyCode.X, true)
                VirtualUser:SetKeyDown(Enum.KeyCode.C, true)
                wait(0.1)
                VirtualUser:SetKeyDown(Enum.KeyCode.Z, false)
                VirtualUser:SetKeyDown(Enum.KeyCode.X, false)
                VirtualUser:SetKeyDown(Enum.KeyCode.C, false)
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
            while IsKillAura and wait(0.2) do
                VirtualUser:ClickButton2(Vector2.new())
                VirtualUser:SetKeyDown(Enum.KeyCode.G, true)
                wait(0.1)
                VirtualUser:SetKeyDown(Enum.KeyCode.G, false)
            end
        end
    end
})

-- No-Clip
local IsNoClipping = false
MainTab:AddToggle({
    Name = "NoClip",
    Default = false,
    Callback = function(Value)
        IsNoClipping = Value
        if Value then
            Humanoid:ChangeState(Enum.HumanoidStateType.Physicless)
        else
            Humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end
})

-- Auto Win on Clouds
local function FindSafeCloudPosition()
    -- Define known cloud positions based on map
    local CloudPositions = {
        Vector3.new(-80, 100, 150),
        Vector3.new(100, 105, -200),
        Vector3.new(-250, 105, 50)
    }
    
    for _, Position in ipairs(CloudPositions) do
        local RaycastParams = RaycastParams.new()
        RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        RaycastParams.FilterDescendantsInstances = {workspace.Terrain}
        
        local RaycastResult = workspace:Raycast(Position + Vector3.new(0, 10, 0), Vector3.new(0, -10, 0), RaycastParams)
        if not RaycastResult then
            return Position
        end
    end
    return Vector3.new(0, 1000, 0)  -- Fallback position
end

MainTab:AddButton({
    Name = "Auto Win (Cloud Safety)",
    Callback = function()
        if Character then
            local SafePosition = FindSafeCloudPosition()
            RootPart.CFrame = CFrame.new(SafePosition)
            OrionLib:MakeNotification({
                Name = "Auto Win",
                Content = "Teleported to a safe cloud location!",
                Time = 5
            })
        end
    end
})

-- GodMode
local OriginalTakeDamage
local IsGodMode = false
MainTab:AddToggle({
    Name = "GodMode",
    Default = false,
    Callback = function(Value)
        IsGodMode = Value
        if Value then
            OriginalTakeDamage = Humanoid.TakeDamage
            Humanoid.TakeDamage = function() end
        else
            if OriginalTakeDamage then
                Humanoid.TakeDamage = OriginalTakeDamage
            end
        end
    end
})

-- Credits
local CreditsTab = Window:MakeTab({
    Name = "Credits",
    Icon = "rbxassetid://4483345875"
})

CreditsTab:AddLabel("Script made with Orion Library")
CreditsTab:AddLabel("Advanced features for Hunty Zombie")
CreditsTab:AddButton("Copy License", function()
    setclipboard("Hunty-Zombie-Script-2023")
    OrionLib:MakeNotification({
        Name = "License Copied",
        Content = "License copied to clipboard!",
        Time = 5
    })
end)

-- Cleanup
OrionLib:OnDestroy(function()
    for _, Box in ipairs(ESPBoxes) do
        Box:Destroy()
    end
    ESPBoxes = {}
    Zombies = {}
end)

OrionLib:MakeNotification({
    Name = "Script Loaded",
    Content = "All features are active!",
    Time = 5
})
