-- VortX Hub | Neon Cosmic Loader
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
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.Parent = screenGui

local skyGradient = Instance.new("UIGradient")
skyGradient.Rotation = 0
skyGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 0, 30)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(80, 0, 50)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 0, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 0, 255))
}
skyGradient.Parent = background

spawn(function()
    while true do
        skyGradient.Rotation = (skyGradient.Rotation + 0.3) % 360
        RunService.RenderStepped:Wait()
    end
end)

local function createStar()
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
    star.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundTransparency = 0.4
    star.BorderSizePixel = 0
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = star
    local glow = Instance.new("ImageLabel")
    glow.Image = "rbxassetid://243098098"
    glow.Size = UDim2.new(3, 0, 3, 0)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundTransparency = 1
    glow.ImageTransparency = 0.7
    glow.Parent = star
    star.Parent = background

    spawn(function()
        local tween = TweenService:Create(star, TweenInfo.new(math.random(3, 6), Enum.EasingStyle.Sine), {
            Position = UDim2.new(star.Position.X.Scale + math.random(-0.2, 0.2), 0,
                star.Position.Y.Scale + math.random(-0.2, 0.2), 0),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, math.random(10, 20), 0, math.random(10, 20))
        })
        tween:Play()
        TweenService:Create(glow, TweenInfo.new(math.random(3, 6)), {
            ImageTransparency = 1,
            Size = UDim2.new(5, 0, 5, 0)
        }):Play()
        tween.Completed:Wait()
        star:Destroy()
    end)
end

spawn(function()
    while true do
        createStar()
        wait(0.05)
    end
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.9, 0, 0.1, 0)
title.Position = UDim2.new(0.05, 0, 0.05, 0)
title.Text = "VORTX HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 48
title.TextColor3 = Color3.fromRGB(255, 0, 100)
title.BackgroundTransparency = 1
title.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
title.TextStrokeTransparency = 0.5
title.Parent = background

spawn(function()
    while true do
        TweenService:Create(title, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
            TextColor3 = Color3.fromRGB(255, 50, 150)
        }):Play()
        wait(0.8)
        TweenService:Create(title, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
            TextColor3 = Color3.fromRGB(255, 0, 100)
        }):Play()
        wait(0.8)
    end
end)

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(0.6, 0, 0.08, 0)
loadingText.Position = UDim2.new(0.2, 0, 0.2, 0)
loadingText.Text = "0 %"
loadingText.Font = Enum.Font.GothamBlack
loadingText.TextSize = 40
loadingText.TextColor3 = Color3.fromRGB(255, 100, 100)
loadingText.BackgroundTransparency = 1
loadingText.Parent = background

local progressBarBg = Instance.new("Frame")
progressBarBg.Size = UDim2.new(0.7, 0, 0.04, 0)
progressBarBg.Position = UDim2.new(0.15, 0, 0.32, 0)
progressBarBg.BackgroundColor3 = Color3.fromRGB(20, 0, 40)
progressBarBg.BorderSizePixel = 0
local cornerBg = Instance.new("UICorner")
cornerBg.CornerRadius = UDim.new(0, 12)
cornerBg.Parent = progressBarBg
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 0, 100)
stroke.Thickness = 2
stroke.Parent = progressBarBg
progressBarBg.Parent = background

local progressBarFill = Instance.new("Frame")
progressBarFill.Size = UDim2.new(0, 0, 1, 0)
progressBarFill.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
local cornerFill = Instance.new("UICorner")
cornerFill.CornerRadius = UDim.new(0, 12)
cornerFill.Parent = progressBarFill
progressBarFill.Parent = progressBarBg

local gameFrame = Instance.new("Frame")
gameFrame.Size = UDim2.new(0.4, 0, 0.45, 0)
gameFrame.AnchorPoint = Vector2.new(0.5, 0)
gameFrame.Position = UDim2.new(0.5, 0, 0.45, 0)
gameFrame.BackgroundColor3 = Color3.fromRGB(30, 0, 40)
gameFrame.BackgroundTransparency = 0.2
local gameCorner = Instance.new("UICorner")
gameCorner.CornerRadius = UDim.new(0, 20)
gameCorner.Parent = gameFrame
local gameStroke = Instance.new("UIStroke")
gameStroke.Color = Color3.fromRGB(255, 0, 100)
gameStroke.Thickness = 2
gameStroke.Parent = gameFrame
gameFrame.Parent = background

local scoreText = Instance.new("TextLabel")
scoreText.Size = UDim2.new(1, 0, 0.2, 0)
scoreText.Position = UDim2.new(0, 0, 0.05, 0)
scoreText.Text = "ENERGY: 0"
scoreText.Font = Enum.Font.GothamBold
scoreText.TextSize = 28
scoreText.TextColor3 = Color3.fromRGB(255, 100, 100)
scoreText.BackgroundTransparency = 1
scoreText.Parent = gameFrame

local discordText = Instance.new("TextLabel")
discordText.Size = UDim2.new(1, 0, 0.15, 0)
discordText.Position = UDim2.new(0, 0, 0.85, 0)
discordText.Text = "discord.gg/jxJ8HNQKjH"
discordText.Font = Enum.Font.GothamBold
discordText.TextSize = 18
discordText.TextColor3 = Color3.fromRGB(255, 200, 200)
discordText.BackgroundTransparency = 1
discordText.Parent = gameFrame

local score = 0
local function createParticle()
    local p = Instance.new("TextButton")
    p.Size = UDim2.new(0, math.random(30, 50), 0, math.random(30, 50))
    p.Position = UDim2.new(math.random(), 0, math.random(), 0)
    p.BackgroundColor3 = Color3.fromRGB(255, 100, 150)
    p.Text = ""
    p.Font = Enum.Font.GothamBold
    p.TextSize = 24
    p.TextColor3 = Color3.fromRGB(255, 255, 255)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = p
    local glow = Instance.new("ImageLabel")
    glow.Image = "rbxassetid://243098098"
    glow.Size = UDim2.new(2.5, 0, 2.5, 0)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundTransparency = 1
    glow.ImageTransparency = 0.7
    glow.ImageColor3 = Color3.fromRGB(255, 100, 150)
    glow.Parent = p
    p.Parent = gameFrame

    spawn(function()
        local tween = TweenService:Create(p, TweenInfo.new(math.random(2, 4), Enum.EasingStyle.Quad), {
            Position = UDim2.new(math.random(), 0, math.random(), 0)
        })
        tween:Play()
    end)

    p.MouseButton1Click:Connect(function()
        score = score + 1
        scoreText.Text = "ENERGY: " .. score
        TweenService:Create(p, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(glow, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
        wait(0.2)
        p:Destroy()
    end)

    delay(math.random(3, 5), function()
        if p.Parent then
            TweenService:Create(p, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
            wait(0.4)
            p:Destroy()
        end
    end)
end

spawn(function()
    while true do
        createParticle()
        wait(0.4)
    end
end)

local percent = 0
local function simulateLoading()
    while percent < 100 do
        local step = math.random(2, 5)
        percent = math.min(percent + step, 100)
        loadingText.Text = percent .. " %"
        progressBarFill:TweenSize(UDim2.new(percent / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.3, true)
        wait(math.random(0.4, 1.2))
    end
    loadingText.Text = "COMPLETE!"
end

setclipboard("discord.gg/jxJ8HNQKjH")
spawn(simulateLoading)
