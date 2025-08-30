local player = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
local gradient = Instance.new("UIGradient")
gradient.Rotation = 45
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 10, 10)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 70, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 10, 20))
}
gradient.Parent = background
background.Parent = screenGui

spawn(function()
    while true do
        gradient.Rotation = (gradient.Rotation + 0.5) % 360
        RunService.RenderStepped:Wait()
    end
end)

local function createStar()
    local color = Color3.fromRGB(math.random(200, 255), math.random(100, 200), math.random(100, 150))
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
    star.BackgroundColor3 = color
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundTransparency = 0.7
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = star
    local glow = Instance.new("ImageLabel")
    glow.Image = "rbxassetid://243098098"
    glow.Size = UDim2.new(2.5, 0, 2.5, 0)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundTransparency = 1
    glow.ImageColor3 = color
    glow.ImageTransparency = 0.6
    glow.Parent = star
    star.Parent = background

    spawn(function()
        local tweenInfo = TweenInfo.new(math.random(3, 5), Enum.EasingStyle.Sine)
        local directionX = math.random(-1, 1) * 0.2
        local directionY = math.random(-1, 1) * 0.2
        TweenService:Create(star, tweenInfo, {
            Position = UDim2.new(star.Position.X.Scale + directionX, 0, star.Position.Y.Scale + directionY, 0),
            BackgroundTransparency = 1
        }):Play()
        wait(tweenInfo.Time)
        star:Destroy()
    end)
end

spawn(function()
    while true do
        createStar()
        wait(0.1)
    end
end)

local function createSunBurst()
    local sun = Instance.new("Frame")
    sun.Size = UDim2.new(0, 80, 0, 80)
    sun.Position = UDim2.new(math.random(), math.random(120, 200), math.random(), math.random(120, 200))
    sun.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
    sun.BackgroundTransparency = 0.3
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = sun
    local rays = Instance.new("UIGradient")
    rays.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 80, 80))
    }
    rays.Parent = sun
    sun.Parent = background

    spawn(function()
        local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Quadratic)
        TweenService:Create(sun, tweenInfo, {
            Size = UDim2.new(0, 30, 0, 30),
            BackgroundTransparency = 1
        }):Play()
        wait(tweenInfo.Time)
        sun:Destroy()
    end)
end

spawn(function()
    while true do
        createSunBurst()
        wait(5)
    end
end)

local topText = Instance.new("TextLabel")
topText.Size = UDim2.new(0.9, 0, 0.07, 0)
topText.Position = UDim2.new(0.05, 0, 0.02, 0)
topText.Text = "⚡ [VortX Hub] Please wait while our systems initialize... ⚡"
topText.Font = Enum.Font.GothamBlack
topText.TextSize = 18
topText.TextColor3 = Color3.fromRGB(255, 70, 70)
topText.BackgroundTransparency = 1
topText.TextTransparency = 1
local topStroke = Instance.new("UIStroke")
topStroke.Color = Color3.fromRGB(255, 255, 100)
topStroke.Thickness = 1
topStroke.Parent = topText
topText.Parent = background

spawn(function()
    wait(1)
    TweenService:Create(topText, TweenInfo.new(2, Enum.EasingStyle.Quad), {TextTransparency = 0.1}):Play()
    while true do
        TweenService:Create(topText, TweenInfo.new(2, Enum.EasingStyle.Sine), {TextColor3 = Color3.fromRGB(255, 50, 50)}):Play()
        wait(2)
        TweenService:Create(topText, TweenInfo.new(2, Enum.EasingStyle.Sine), {TextColor3 = Color3.fromRGB(255, 150, 100)}):Play()
        wait(2)
    end
end)

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(0.6, 0, 0.1, 0)
loadingText.Position = UDim2.new(0.2, 0, 0.15, 0)
loadingText.Text = "Initializing... 0%"
loadingText.Font = Enum.Font.GothamBlack
loadingText.TextSize = 30
loadingText.TextColor3 = Color3.fromRGB(255, 100, 100)
loadingText.BackgroundTransparency = 1
loadingText.Parent = background

spawn(function()
    while true do
        TweenService:Create(loadingText, TweenInfo.new(1, Enum.EasingStyle.Sine), {TextTransparency = 0.4}):Play()
        wait(1)
        TweenService:Create(loadingText, TweenInfo.new(1, Enum.EasingStyle.Sine), {TextTransparency = 0}):Play()
        wait(1)
    end
end)

local progressBarBg = Instance.new("Frame")
progressBarBg.Size = UDim2.new(0.7, 0, 0.06, 0)
progressBarBg.Position = UDim2.new(0.15, 0, 0.3, 0)
progressBarBg.BackgroundColor3 = Color3.fromRGB(50, 10, 10)
progressBarBg.BorderSizePixel = 0
local cornerBg = Instance.new("UICorner")
cornerBg.CornerRadius = UDim.new(0, 15)
cornerBg.Parent = progressBarBg
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 100, 70)
stroke.Thickness = 3
stroke.Parent = progressBarBg
progressBarBg.Parent = background

local progressBarFill = Instance.new("Frame")
progressBarFill.Size = UDim2.new(0, 0, 1, 0)
progressBarFill.BackgroundColor3 = Color3.fromRGB(255, 200, 150)
local fillGradient = Instance.new("UIGradient")
fillGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 150))
}
fillGradient.Parent = progressBarFill
local cornerFill = Instance.new("UICorner")
cornerFill.CornerRadius = UDim.new(0, 15)
cornerFill.Parent = progressBarFill
progressBarFill.Parent = progressBarBg

local gameFrame = Instance.new("Frame")
gameFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
gameFrame.AnchorPoint = Vector2.new(0.5, 0)
gameFrame.Position = UDim2.new(0.5, 0, 0.45, 0)
gameFrame.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
local gameCorner = Instance.new("UICorner")
gameCorner.CornerRadius = UDim.new(0, 20)
gameCorner.Parent = gameFrame
local gameStroke = Instance.new("UIStroke")
gameStroke.Color = Color3.fromRGB(255, 70, 70)
gameStroke.Thickness = 3
gameStroke.Parent = gameFrame
gameFrame.Parent = background

local gameTopText = Instance.new("TextLabel")
gameTopText.Size = UDim2.new(1, 0, 0.15, 0)
gameTopText.Position = UDim2.new(0, 0, -0.15, 0)
gameTopText.Text = "https://discord.gg/jxJ8HNQKjH"
gameTopText.Font = Enum.Font.GothamBold
gameTopText.TextSize = 18
gameTopText.TextColor3 = Color3.fromRGB(255, 150, 150)
gameTopText.BackgroundTransparency = 1
gameTopText.Parent = gameFrame

local score = 0
local scoreText = Instance.new("TextLabel")
scoreText.Size = UDim2.new(1, 0, 0.2, 0)
scoreText.Position = UDim2.new(0, 0, 0.8, 0)
scoreText.Text = "Energy: " .. score
scoreText.Font = Enum.Font.GothamBold
scoreText.TextSize = 20
scoreText.TextColor3 = Color3.fromRGB(255, 200, 150)
scoreText.BackgroundTransparency = 1
scoreText.Parent = gameFrame

local boostButton = Instance.new("TextButton")
boostButton.Size = UDim2.new(0.9, 0, 0.2, 0)
boostButton.Position = UDim2.new(0.05, 0, 0.55, 0)
boostButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
boostButton.Text = "Solar Boost"
boostButton.Font = Enum.Font.GothamBlack
boostButton.TextSize = 18
boostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
boostButton.Visible = false
local boostCorner = Instance.new("UICorner")
boostCorner.CornerRadius = UDim.new(0, 10)
boostCorner.Parent = boostButton
local boostStroke = Instance.new("UIStroke")
boostStroke.Color = Color3.fromRGB(255, 150, 80)
boostStroke.Thickness = 2
boostStroke.Parent = boostButton
boostButton.Parent = gameFrame

local function createNebula()
    local nebula = Instance.new("TextButton")
    nebula.Size = UDim2.new(0, math.random(40, 60), 0, math.random(40, 60))
    nebula.Position = UDim2.new(math.random() * 0.7 + 0.15, 0, math.random() * 0.5 + 0.15, 0)
    nebula.BackgroundColor3 = Color3.fromRGB(255, 100, 50)
    nebula.Text = "\240\159\141\132"
    nebula.Font = Enum.Font.SourceSansBold
    nebula.TextSize = 40
    nebula.TextColor3 = Color3.fromRGB(255, 255, 200)
    local nebulaCorner = Instance.new("UICorner")
    nebulaCorner.CornerRadius = UDim.new(1, 0)
    nebulaCorner.Parent = nebula
    local glow = Instance.new("ImageLabel")
    glow.Image = "rbxassetid://243098098"
    glow.Size = UDim2.new(2, 0, 2, 0)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundTransparency = 1
    glow.ImageTransparency = 0.6
    glow.ImageColor3 = Color3.fromRGB(255, 150, 80)
    glow.Parent = nebula
    nebula.Parent = gameFrame

    spawn(function()
        local moveTime = math.random(1, 2)
        local directionX = math.random(-1, 1) * 0.2
        local directionY = math.random(-1, 1) * 0.2
        TweenService:Create(nebula, TweenInfo.new(moveTime, Enum.EasingStyle.Sine), {
            Position = UDim2.new(nebula.Position.X.Scale + directionX, 0, nebula.Position.Y.Scale + directionY, 0)
        }):Play()
    end)

    nebula.MouseButton1Click:Connect(function()
        score = score + 1
        scoreText.Text = "Energy: " .. score
        if score >= 5 then
            boostButton.Visible = true
            TweenService:Create(boostButton, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
        end
        TweenService:Create(nebula, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
        TweenService:Create(glow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {ImageTransparency = 1}):Play()
        wait(0.3)
        nebula:Destroy()
    end)

    delay(math.random(0.8, 1.2), function()
        if nebula.Parent then
            TweenService:Create(nebula, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
            TweenService:Create(glow, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {ImageTransparency = 1}):Play()
            wait(0.4)
            nebula:Destroy()
        end
    end)
end

local gameRunning = true
spawn(function()
    while gameRunning do
        createNebula()
        wait(0.5)
    end
end)

local function updateProgress(percent)
    loadingText.Text = "Initializing... " .. percent .. "%"
    progressBarFill:TweenSize(UDim2.new(percent / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.8, true)
end

local percent = 0
local function simulateLoading()
    local totalTime = 0
    local targetTime = math.random(300, 420)

    while percent <= 100 and totalTime < targetTime do
        local delayTime
        if percent == 30 or percent == 60 or percent == 90 then
            delayTime = math.random(8, 15)
            topText.Text = "⚡ [VortX Hub] System scan in progress... ⚡"
            TweenService:Create(topText, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {TextTransparency = 0.1}):Play()
            updateProgress(percent)
            wait(delayTime)
            topText.Text = "⚡ [VortX Hub] Please wait while our systems initialize... ⚡"
            TweenService:Create(topText, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {TextTransparency = 0.1}):Play()
        else
            delayTime = math.random(1, 2)
            updateProgress(percent)
            wait(delayTime)
        end

        totalTime = totalTime + delayTime
        percent = percent + math.random(1, 2)
    end

    while percent <= 100 do
        updateProgress(percent)
        wait(2)
        percent = percent + 1
    end

    loadingText.Text = "Initialization Complete!"
    TweenService:Create(loadingText, TweenInfo.new(1, Enum.EasingStyle.Sine), {TextColor3 = Color3.fromRGB(100, 255, 100)}):Play()
end

boostButton.MouseButton1Click:Connect(function()
    if score >= 5 then
        score = score - 5
        percent = percent + 5
        if percent > 100 then percent = 100 end
        scoreText.Text = "Energy: " .. score
        updateProgress(percent)
        spawn(function()
            TweenService:Create(boostButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 180, 100)}):Play()
            wait(0.2)
            TweenService:Create(boostButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
        end)
    end
end)

local function checkGameEnd()
    player.CharacterAdded:Connect(function()
        screenGui.Parent = playerGui
    end)

    game:GetService("Players").PlayerRemoving:Connect(function(leavingPlayer)
        if leavingPlayer == player then
            gameRunning = false
        end
    end)
end

setclipboard("https://discord.gg/jxJ8HNQKjH")
spawn(simulateLoading)
checkGameEnd()
