-- Load Orion Library
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua'))()
local Window = OrionLib:MakeWindow({Name = 'VortXB Hub - My Market', HidePremium = true, SaveConfig = true, ConfigFolder = 'VortXBHub-MyMarket'})

-- Services
local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService('UserInputService')

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

-- Hooks and Fake Raycast
local origRemoteEventFire = nil
local origRaycast = Workspace.Raycast
local function FakeRaycast(...) return Vector3.new(), nil end

-- ESP Logic
local function ESP_Toggle(value)
    if value then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local character = player.Character
                if character and character:FindFirstChild('Head') then
                    local head = character.Head
                    local esp = Drawing.new('Text')
                    esp.Text = player.Name
                    esp.Color = Color3.new(1, 1, 1)
                    esp.Size = 14
                    esp.Outline = true
                    esp.Visible = true
                    RunService.RenderStepped:Connect(function()
                        local screenPosition, onScreen = Camera:WorldToScreenPoint(head.Position)
                        if onScreen then
                            esp.Position = Vector2.new(screenPosition.X, screenPosition.Y)
                        else
                            esp.Visible = false
                        end
                    end)
                end
            end
        end
    else
        for _, esp in pairs(Drawing:GetObjects()) do esp:Remove() end
    end
end

-- Fly Logic
local function Fly_Toggle(value)
    if value then
        local flySpeed = 50
        local keys = {a = false, d = false, w = false, s = false}
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.A then keys.a = true end
            if input.KeyCode == Enum.KeyCode.D then keys.d = true end
            if input.KeyCode == Enum.KeyCode.W then keys.w = true end
            if input.KeyCode == Enum.KeyCode.S then keys.s = true end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.A then keys.a = false end
            if input.KeyCode == Enum.KeyCode.D then keys.d = false end
            if input.KeyCode == Enum.KeyCode.W then keys.w = false end
            if input.KeyCode == Enum.KeyCode.S then keys.s = false end
        end)
        RunService.RenderStepped:Connect(function()
            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChild('Humanoid')
                if humanoid then
                    humanoid.PlatformStand = true
                    local moveVector = Vector3.new((keys.d and 1 or 0) - (keys.a and 1 or 0), 0, (keys.s and 1 or 0) - (keys.w and 1 or 0))
                    character:TranslateBy(moveVector * flySpeed)
                end
            end
        end)
    else
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild('Humanoid')
            if humanoid then humanoid.PlatformStand = false end
        end
    end
end

-- NoClip Logic
local function NoClip_Toggle(value)
    if value then
        RunService.Stepped:Connect(function()
            for _, character in pairs(Players.LocalPlayer.Character:GetChildren()) do
                if character:IsA('Part') or character:IsA('MeshPart') then character.CanCollide = false end
            end
        end)
    else
        for _, character in pairs(Players.LocalPlayer.Character:GetChildren()) do
            if character:IsA('Part') or character:IsA('MeshPart') then character.CanCollide = true end
        end
    end
end

-- Auto Open Logic
local function AutoOpen_Toggle(value)
    if value then
        while task.wait(1) do
            for _, part in pairs(Workspace:GetDescendants()) do
                if part:IsA('Part') and part.Name == 'LootBox' then
                    local raycastResult = FakeRaycast(part.Position, (part.Position - Camera.CFrame.Position).Unit, RaycastParams.new())
                    if raycastResult.Instance == part then ReplicatedStorage:FindFirstChild('RemoteEvent'):FireServer('OpenLootBox', part) end
                end
            end
        end
    end
end

-- Auto Buy Logic
local function AutoBuy_Toggle(value)
    if value then
        while task.wait(1) do
            for _, part in pairs(Workspace:GetDescendants()) do
                if part:IsA('Part') and part.Name == 'BuyButton' then
                    local raycastResult = FakeRaycast(part.Position, (part.Position - Camera.CFrame.Position).Unit, RaycastParams.new())
                    if raycastResult.Instance == part then ReplicatedStorage:FindFirstChild('RemoteEvent'):FireServer('BuyItem', part) end
                end
            end
        end
    end
end

-- Auto Collect Logic
local function AutoCollect_Toggle(value)
    if value then
        while task.wait(1) do
            for _, part in pairs(Workspace:GetDescendants()) do
                if part:IsA('Part') and part.Name == 'Money' then
                    local raycastResult = FakeRaycast(part.Position, (part.Position - Camera.CFrame.Position).Unit, RaycastParams.new())
                    if raycastResult.Instance == part then ReplicatedStorage:FindFirstChild('RemoteEvent'):FireServer('CollectMoney', part) end
                end
            end
        end
    end
end

-- 500x Luck Logic
local function Luck_Toggle(value)
    if value then origRemoteEventFire = hookmetamethod(game, '__namecall', function(self, ...) 
        if self.Name == 'RemoteEvent' and getnamecallmethod() == 'FireServer' then
            local args = {...}
            if args[1] == 'ClaimLuck' then args[2] = args[2] * 500 end
            return origRemoteEventFire(self, unpack(args))
        end
    end) end
end

-- 500x Money Logic
local function Money_Toggle(value)
    if value then origRemoteEventFire = hookmetamethod(game, '__namecall', function(self, ...) 
        if self.Name == 'RemoteEvent' and getnamecallmethod() == 'FireServer' then
            local args = {...}
            if args[1] == 'EarnMoney' then args[2] = args[2] * 500 end
            return origRemoteEventFire(self, unpack(args))
        end
    end) end
end

-- Infinite Money Logic
local function InfiniteMoney_Toggle(value)
    if value then origRemoteEventFire = hookmetamethod(game, '__namecall', function(self, ...) 
        if self.Name == 'RemoteEvent' and getnamecallmethod() == 'FireServer' then
            local args = {...}
            if args[1] == 'UpdateMoney' then args[2] = math.huge end
            return origRemoteEventFire(self, unpack(args))
        end
    end) end
end

-- GUI Setup
local FeaturesTab = Window:MakeTab({Name = 'Features', Icon = 'rbxassetid://4483345875'})
FeaturesTab:AddToggle({Name = 'ESP', Default = false, Callback = ESP_Toggle})
FeaturesTab:AddToggle({Name = 'Fly', Default = false, Callback = Fly_Toggle})
FeaturesTab:AddToggle({Name = 'NoClip', Default = false, Callback = NoClip_Toggle})
FeaturesTab:AddToggle({Name = 'Auto Open', Default = false, Callback = AutoOpen_Toggle})
FeaturesTab:AddToggle({Name = 'Auto Buy', Default = false, Callback = AutoBuy_Toggle})
FeaturesTab:AddToggle({Name = 'Auto Collect', Default = false, Callback = AutoCollect_Toggle})
FeaturesTab:AddToggle({Name = '500x Luck', Default = false, Callback = Luck_Toggle})
FeaturesTab:AddToggle({Name = '500x Money', Default = false, Callback = Money_Toggle})
FeaturesTab:AddToggle({Name = 'Infinite Money', Default = false, Callback = InfiniteMoney_Toggle})

-- Hooks Setup
origRemoteEventFire = hookfunction(ReplicatedStorage.RemoteEvent.FireServer, function(...) return origRemoteEventFire(...) end)
origRaycast = hookfunction(Workspace.Raycast, function(...) return FakeRaycast(...) end)

OrionLib:Init()
