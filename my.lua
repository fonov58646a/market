local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()
local Window = OrionLib:MakeWindow({Name = "VortX Hub", HidePremium = false})

-- Script Variables
local BOOSTED_SPEED = 75
local speedConn
local espEnabled = false
local espUpdateConn
local autobuy_selected = {}
local executor = identifyexecutor()

-- ESP Functions
local function addHighlightToCharacter(char)
    local highlight = Instance.new("Highlight")
    highlight.Name = "HighlightESP"
    highlight.FillColor = Color3.new(0, 0, 0)
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.Adornee = char
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char
end

local function removeHighlightFromCharacter(char)
    local highlight = char and char:FindFirstChild("HighlightESP")
    if highlight then
        highlight:Destroy()
    end
end

local function enableESP()
    if espEnabled then return end
    espEnabled = true
    espUpdateConn = game:GetService("RunService").Heartbeat:Connect(function()
        if not espEnabled then return end
        if not _G._lastESPUpdate or (tick() - _G._lastESPUpdate) >= 0.1 then
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    addHighlightToCharacter(player.Character)
                end
            end
            _G._lastESPUpdate = tick()
        end
    end)
end

local function disableESP()
    if not espEnabled then return end
    espEnabled = false
    if espUpdateConn then
        espUpdateConn:Disconnect()
        espUpdateConn = nil
    end
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            removeHighlightFromCharacter(player.Character)
        end
    end
end

-- Tabs
local TabInfo = Window:MakeTab({Title = "Info", Icon = "info"})
local TabBases = Window:MakeTab({Title = "Base Scripts", Icon = "cherry"})
local TabItems = Window:MakeTab({Title = "Game Items", Icon = "star"})
local TabFarm = Window:MakeTab({Title = "Farm", Icon = "People"})

-- Info Tab
TabInfo:AddParagraph({"Script of Steal a brainrot! Have fun!"})
TabInfo:AddParagraph({"Your current executor is " .. executor})

-- Farm Tab
TabFarm:AddButton({
    Title = "Platform",
    Callback = function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local TweenService = game:GetService("TweenService")
        local player = Players.LocalPlayer
        local platform = nil
        local isActive = false
        local currentHeight = 0
        local elevationSpeed = 0.02
        local baseHeight = 0.5
        local platformSize = Vector3.new(8, 0.5, 8)
        local elevationConnection = nil

        local function createPlatform()
            if platform then
                platform:Destroy()
            end
            local character = player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                return
            end
            local rootPart = character.HumanoidRootPart
            local position = rootPart.Position
            platform = Instance.new("Part")
            platform.Name = "ElevatorPlatform"
            platform.Size = platformSize
            platform.Material = Enum.Material.Neon
            platform.BrickColor = BrickColor.new("Bright blue")
            platform.Anchored = true
            platform.CanCollide = true
            platform.Shape = Enum.PartType.Block
            platform.Position = Vector3.new(
                position.X,
                position.Y - (character.Humanoid.HipHeight + baseHeight + platformSize.Y/2),
                position.Z
            )
            platform.Parent = workspace
            currentHeight = 0
        end

        local function removePlatform()
            if platform then
                local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local tween = TweenService:Create(platform, tweenInfo, {
                    Transparency = 1,
                    Size = Vector3.new(0.1, 0.1, 0.1)
                })
                tween:Play()
                tween.Completed:Connect(function()
                    platform:Destroy()
                    platform = nil
                end)
            end
            currentHeight = 0
        end

        local function updatePlatform()
            if platform and platform.Parent then
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local rootPart = character.HumanoidRootPart
                    local playerPos = rootPart.Position
                    currentHeight = currentHeight + elevationSpeed
                    local baseY = playerPos.Y - (character.Humanoid.HipHeight + baseHeight + platformSize.Y/2)
                    local newY = baseY + currentHeight
                    platform.Position = Vector3.new(
                        playerPos.X,
                        newY,
                        playerPos.Z
                    )
                end
            end
        end

        local function togglePlatform()
            isActive = not isActive
            if isActive then
                createPlatform()
                elevationConnection = RunService.Heartbeat:Connect(function()
                    updatePlatform()
                end)
            else
                if elevationConnection then
                    elevationConnection:Disconnect()
                    elevationConnection = nil
                end
                removePlatform()
            end
        end

        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.P then
                togglePlatform()
            end
        end)
    end
})

TabFarm:AddButton({
    Title = "Float",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")
        local forwardSpeed = 55
        local gravityScale = 0.1
        local floatDuration = 7
        local walkSpeed = 32
        local isFloating = false
        local bodyVelocity = nil

        local function applyFloat()
            if humanoid and rootPart and not isFloating then
                isFloating = true
                game.Workspace.Gravity = 196.2 * gravityScale
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bodyVelocity.Velocity = rootPart.CFrame.LookVector * forwardSpeed + Vector3.new(0, 0, 0)
                bodyVelocity.Parent = rootPart
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.MaxTorque = Vector3.new(4000, 0, 4000)
                bodyGyro.CFrame = rootPart.CFrame
                bodyGyro.Parent = rootPart
                humanoid.WalkSpeed = walkSpeed
                wait(floatDuration)
                if bodyVelocity then
                    bodyVelocity:Destroy()
                    bodyVelocity = nil
                end
                if bodyGyro then
                    bodyGyro:Destroy()
                end
                game.Workspace.Gravity = 196.2
                humanoid.WalkSpeed = 16
                isFloating = false
            end
        end

        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.F then
                applyFloat()
            end
        end)
    end
})

-- Base Scripts Tab
local Bases = {
    ["Select Base 1"] = Vector3.new(-331, -4, -99),
    ["Select Base 2"] = Vector3.new(-485, -4, 221),
    ["Select Base 3"] = Vector3.new(-332, -4, 222),
    ["Select Base 4"] = Vector3.new(-492, -4, 6),
    ["Select Base 5"] = Vector3.new(-493, -4, -99),
    ["Select Base 6"] = Vector3.new(-328, -4, -101),
    ["Select Base 7"] = Vector3.new(-328, -4, 113),
    ["Select Base 8"] = Vector3.new(-489, -4, 113)
}

local selectedBase = nil
local loopTeleport = false
local loopTeleportDetected = false
local userBase = nil
local buttonsCreated = false
local cameraLoop = false
local rotationAngle = 0
local rotationSpeed = math.rad(30)

local function TweenTeleport(position)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        local tweenSpeed = (position == userBase) and 0.5 or 2
        local tween = TweenService:Create(HRP, TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(position)})
        tween:Play()
    end
end

local function DetectClosestBase()
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        local closestDistance = math.huge
        local closestBase = nil
        for name, pos in pairs(Bases) do
            local dist = (HRP.Position - pos).Magnitude
            if dist < closestDistance then
                closestDistance = dist
                closestBase = pos
            end
        end
        return closestBase
    end
end

local function ShowNotification(text)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false

    local Frame = Instance.new("Frame")  
    Frame.Parent = ScreenGui  
    Frame.Size = UDim2.new(0.4,0,0.08,0)  
    Frame.Position = UDim2.new(0.3,0,0.1,0)  
    Frame.BackgroundTransparency = 0.5  
    Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)  
    Frame.BorderSizePixel = 2  

    local UIStroke = Instance.new("UIStroke")  
    UIStroke.Parent = Frame  
    UIStroke.Color = Color3.new(0,0,0)  
    UIStroke.Thickness = 2  

    local Label = Instance.new("TextLabel")  
    Label.Parent = Frame  
    Label.Size = UDim2.new(1,0,1,0)  
    Label.BackgroundTransparency = 1  
    Label.Text = text  
    Label.TextColor3 = Color3.new(1,1,1)  
    Label.TextScaled = true  
    Label.Font = Enum.Font.BuilderSansBold  

    task.wait(2)  
    ScreenGui:Destroy()
end

game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
    if cameraLoop and selectedBase then
        rotationAngle = rotationAngle + rotationSpeed * deltaTime
        local offset = Vector3.new(0, 10, 20)
        local rotatedOffset = CFrame.Angles(0, rotationAngle, 0) * CFrame.new(offset)
        game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
        game.Workspace.CurrentCamera.CFrame = CFrame.new(selectedBase + rotatedOffset.Position, selectedBase)
    end
end)

TabBases:AddDropdown({
    Name = "Select Base",
    Options = {"Select Base 1", "Select Base 2", "Select Base 3", "Select Base 4", "Select Base 5", "Select Base 6", "Select Base 7", "Select Base 8"},
    Callback = function(Value)
        selectedBase = Bases[Value]
    end
})

TabBases:AddToggle({
    Name = "View Selected Base",
    Default = false,
    Callback = function(Value)
        cameraLoop = Value
        if not Value then
            game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end
    end
})

TabBases:AddButton({
    Name = "Teleport to Base",
    Callback = function()
        if selectedBase then
            TweenTeleport(selectedBase)
        end
    end
})

TabBases:AddToggle({
    Name = "Loop Teleport to Base",
    Default = false,
    Callback = function(Value)
        loopTeleport = Value
        task.spawn(function()
            while loopTeleport do
                if selectedBase then
                    TweenTeleport(selectedBase)
                end
                task.wait(3)
            end
        end)
    end
})

TabBases:AddButton({
    Name = "Detect Your Base",
    Callback = function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.Health = 0
            game.Players.LocalPlayer.CharacterAdded:Wait()
            task.wait(1)
            userBase = DetectClosestBase()

            if userBase and not buttonsCreated then  
                buttonsCreated = true  
                TabBases:AddButton({  
                    Name = "Teleport to Your Base",  
                    Callback = function()  
                        TweenTeleport(userBase)  
                    end  
                })  

                TabBases:AddToggle({  
                    Name = "Loop Teleport to Your Base",  
                    Default = false,  
                    Callback = function(Value)  
                        loopTeleportDetected = Value  
                        task.spawn(function()  
                            while loopTeleportDetected do  
                                TweenTeleport(userBase)  
                                task.wait(3)  
                            end  
                        end)  
                    end  
                })  
            end  
        end  
    end
})

TabBases:AddButton({
    Name = "Place brainrot in Mixing Machine",
    Callback = function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            local hs = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
            if hs > 22 then
                ShowNotification("You need to get a brainrot from your base!")
            else
                local Humanoid = game.Players.LocalPlayer.Character.Humanoid
                local targetPos = Vector3.new(-390, -6, 77)
                Humanoid:MoveTo(targetPos)
                Humanoid.MoveToFinished:Wait()
            end
        end
    end
})

-- Game Items Tab
TabItems:AddSection("Auto Click")

local autoClickEnabled = false

TabItems:AddToggle({
    Name = "Auto Hit Players",
    Default = false,
    Callback = function(Value)
        autoClickEnabled = Value
    end
})

task.spawn(function()
    while true do
        if autoClickEnabled then
            local VirtualUser = game:GetService("VirtualUser")
            VirtualUser:ClickButton1(Vector2.new(0,0))
            wait(0.25)
            VirtualUser:ClickButton1(Vector2.new(0,0))
            wait(0.25)
        else
            wait(0.1)
        end
    end
end)

TabItems:AddSection("Dupe Tools")

TabItems:AddButton({
    Name = "Dupe All Game Tools",
    Callback = function()
        local player = game.Players.LocalPlayer
        local backpack = player:WaitForChild("Backpack")
        local playerGui = player:WaitForChild("PlayerGui")

        local function showDupingEffect()  
            local blur = Instance.new("BlurEffect")  
            blur.Size = 10  
            blur.Parent = game.Lighting  

            local screenGui = Instance.new("ScreenGui")  
            screenGui.ResetOnSpawn = false  
            screenGui.Parent = playerGui  

            local textLabel = Instance.new("TextLabel")  
            textLabel.Size = UDim2.new(1, 0, 1, 0)  
            textLabel.BackgroundTransparency = 1  
            textLabel.Text = "Duplicating tools..."  
            textLabel.Font = Enum.Font.BuilderSansBold  
            textLabel.TextScaled = true  
            textLabel.TextColor3 = Color3.new(1, 1, 1)  
            textLabel.Parent = screenGui  

            task.wait(1)  

            blur:Destroy()  
            screenGui:Destroy()  
        end  

        local function collectAllTools()  
            showDupingEffect()  
            for _, tool in pairs(game:GetDescendants()) do  
                if tool:IsA("Tool") then  
                    local clonedTool = tool:Clone()  
                    clonedTool.Parent = backpack  
                end  
            end  
        end  

        collectAllTools()  
    end
})

-- Speed Boost Feature
local TabSpeed = Window:MakeTab({Title = "Speed", Icon = "speed"})
TabSpeed:AddToggle({
    Name = "Speed Boost",
    Default = false,
    Callback = function(Value)
        if Value then
            speedConn = game:GetService("RunService").Heartbeat:Connect(function()
                if not _G._lastSpeedBoostUpdate or (tick() - _G._lastSpeedBoostUpdate) >= 0.1 then
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if humanoid and rootPart and humanoid.MoveDirection.Magnitude > 0 then
                            local moveDir = humanoid.MoveDirection
                            rootPart.Velocity = Vector3.new(
                                moveDir.X * BOOSTED_SPEED,
                                rootPart.Velocity.Y,
                                moveDir.Z * BOOSTED_SPEED
                            )
                        end
                    end
                    _G._lastSpeedBoostUpdate = tick()
                end
            end)
        else
            if speedConn then
                speedConn:Disconnect()
                speedConn = nil
            end
        end
    end
})

-- ESP Feature
local TabESP = Window:MakeTab({Title = "ESP", Icon = "search"})
TabESP:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(state)
        if state then
            enableESP()
        else
            disableESP()
        end
    end
})

-- Server Tab
local TabServer = Window:MakeTab({Title = "Server", Icon = "server"})
TabServer:AddSection({Title = "Server Info"})

TabServer:AddParagraph({
    Title = "Copy Server ID",
    Desc = game.JobId,
    Buttons = {
        {
            Title = "Copy",
            Callback = function()
                setclipboard(game.JobId)
            end
        }
    }
})

TabServer:AddInput({
    Title = "Enter Server ID",
    Callback = function(value)
        _G.JobId = value
    end
})

TabServer:AddButton({
    Title = "Join Server ID",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, _G.JobId)
    end
})
