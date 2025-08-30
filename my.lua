-- VORTX HUB – Ultra-Neon Red Cosmic Loader
-- Last update: 30-Aug-2025
-- FULL 100 % animated, auto-destroy, tembak-tembakan mini-game

local player = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local playerGui = player:WaitForChild("PlayerGui")

-- ===== UI ROOT =====
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
background.Parent = screenGui

local skyGradient = Instance.new("UIGradient")
skyGradient.Rotation = 0
skyGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 0, 0)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(80, 0, 0)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 20, 20))
}
skyGradient.Parent = background

spawn(function()
    while true do
        skyGradient.Rotation = (skyGradient.Rotation + 0.2) % 360
        RunService.RenderStepped:Wait()
    end
end)

-- ===== STARFIELD =====
local function createStar()
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
    star.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundTransparency = 0.6
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
    glow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    glow.Parent = star
    star.Parent = background

    spawn(function()
        TweenService:Create(star, TweenInfo.new(math.random(4, 7)), {
            Position = UDim2.new(star.Position.X.Scale + math.random(-0.2, 0.2), 0,
                star.Position.Y.Scale + math.random(-0.2, 0.2), 0),
            BackgroundTransparency = 1
        }):Play()
        wait(math.random(4, 7))
        star:Destroy()
    end)
end

spawn(function()
    while true do
        createStar()
        wait(0.05)
    end
end)

-- ===== TITLE =====
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.9, 0, 0.12, 0)
title.Position = UDim2.new(0.05, 0, 0.05, 0)
title.Text = "VORTX HUB"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 60
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.BackgroundTransparency = 1
title.TextStrokeColor3 = Color3.fromRGB(50, 0, 0)
title.TextStrokeTransparency = 0
local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.fromRGB(255, 0, 0)
titleStroke.Thickness = 2
titleStroke.Transparency = 0.5
titleStroke.Parent = title
title.Parent = background

spawn(function()
    while true do
        TweenService:Create(title, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {
            TextColor3 = Color3.fromRGB(255, 50, 50),
            TextStrokeColor3 = Color3.fromRGB(100, 0, 0)
        }):Play()
        wait(0.6)
        TweenService:Create(title, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {
            TextColor3 = Color3.fromRGB(255, 0, 0),
            TextStrokeColor3 = Color3.fromRGB(50, 0, 0)
        }):Play()
        wait(0.6)
    end
end)

-- ===== LOADING TEXT =====
local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(0.6, 0, 0.08, 0)
loadingText.Position = UDim2.new(0.2, 0, 0.18, 0)
loadingText.Text = "0 %"
loadingText.Font = Enum.Font.SourceSansBold
loadingText.TextSize = 40
loadingText.TextColor3 = Color3.fromRGB(255, 0, 0)
loadingText.BackgroundTransparency = 1
loadingText.TextStrokeColor3 = Color3.fromRGB(50, 0, 0)
loadingText.TextStrokeTransparency = 0
loadingText.Parent = background

-- ===== PROGRESS BAR =====
local progressBarBg = Instance.new("Frame")
progressBarBg.Size = UDim2.new(0.7, 0, 0.05, 0)
progressBarBg.Position = UDim2.new(0.15, 0, 0.28, 0)
progressBarBg.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
progressBarBg.BorderSizePixel = 0
local cornerBg = Instance.new("UICorner")
cornerBg.CornerRadius = UDim.new(0, 8)
cornerBg.Parent = progressBarBg
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 0, 0)
stroke.Thickness = 2
stroke.Parent = progressBarBg
progressBarBg.Parent = background

local progressBarFill = Instance.new("Frame")
progressBarFill.Size = UDim2.new(0, 0, 1, 0)
progressBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
local cornerFill = Instance.new("UICorner")
cornerFill.CornerRadius = UDim.new(0, 8)
cornerFill.Parent = progressBarFill
progressBarFill.Parent = progressBarBg

-- ===== GAME CANVAS =====
local gameFrame = Instance.new("Frame")
gameFrame.Size = UDim2.new(0.5, 0, 0.55, 0)
gameFrame.AnchorPoint = Vector2.new(0.5, 0)
gameFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
gameFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
gameFrame.BackgroundTransparency = 0.2
local gameCorner = Instance.new("UICorner")
gameCorner.CornerRadius = UDim.new(0, 12)
gameCorner.Parent = gameFrame
local gameStroke = Instance.new("UIStroke")
gameStroke.Color = Color3.fromRGB(255, 0, 0)
gameStroke.Thickness = 2
gameStroke.Parent = gameFrame
gameFrame.Parent = background

local scoreText = Instance.new("TextLabel")
scoreText.Size = UDim2.new(1, 0, 0.15, 0)
scoreText.Position = UDim2.new(0, 0, 0.05, 0)
scoreText.Text = "SCORE: 0"
scoreText.Font = Enum.Font.SourceSansBold
scoreText.TextSize = 28
scoreText.TextColor3 = Color3.fromRGB(255, 0, 0)
scoreText.BackgroundTransparency = 1
scoreText.TextStrokeColor3 = Color3.fromRGB(50, 0, 0)
scoreText.TextStrokeTransparency = 0
scoreText.Parent = gameFrame

local discordText = Instance.new("TextLabel")
discordText.Size = UDim2.new(1, 0, 0.1, 0)
discordText.Position = UDim2.new(0, 0, 0.85, 0)
discordText.Text = "discord.gg/jxJ8HNQKjH"
discordText.Font = Enum.Font.SourceSansBold
discordText.TextSize = 18
discordText.TextColor3 = Color3.fromRGB(255, 100, 100)
discordText.BackgroundTransparency = 1
discordText.TextStrokeColor3 = Color3.fromRGB(50, 0, 0)
discordText.TextStrokeTransparency = 0
discordText.Parent = gameFrame

-- ===== TEMBAK-TEMBAKAN =====
local score = 0
local function spawnEnemy()
    local enemy = Instance.new("TextButton")
    enemy.Size = UDim2.new(0, 40, 0, 40)
    enemy.Position = UDim2.new(math.random(), 0, math.random() * 0.7, 0)
    enemy.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    enemy.Text = ""
    enemy.AutoButtonColor = false
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = enemy
    local glow = Instance.new("ImageLabel")
    glow.Image = "rbxassetid://243098098"
    glow.Size = UDim2.new(2, 0, 2, 0)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundTransparency = 1
    glow.ImageTransparency = 0.7
    glow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    glow.Parent = enemy
    enemy.Parent = gameFrame

    spawn(function()
        local dirX = math.random(-1, 1) * 0.3
        local dirY = math.random(0.1, 0.3)
        while enemy.Parent do
            enemy.Position = enemy.Position + UDim2.new(dirX * 0.02, 0, dirY * 0.02, 0)
            if enemy.Position.Y.Scale > 1 then
                enemy:Destroy()
                break
            end
            wait(0.05)
        end
    end)

    enemy.MouseButton1Click:Connect(function()
        score = score + 1
        scoreText.Text = "SCORE: " .. score
        TweenService:Create(enemy, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        }):Play()
        TweenService:Create(glow, TweenInfo.new(0.2), {
            ImageTransparency = 1,
            Size = UDim2.new(4, 0, 4, 0)
        }):Play()
        wait(0.2)
        enemy:Destroy()
    end)

    delay(math.random(5, 7), function()
        if enemy.Parent then
            enemy:Destroy()
        end
    end)
end

spawn(function()
    while true do
        spawnEnemy()
        wait(math.random(0.5, 1.5))
    end
end)

-- ===== LOADING SIMULATION =====
local percent = 0
local function simulateLoading()
    while percent < 100 do
        local step = math.random(1, 3)
        percent = math.min(percent + step, 100)
        loadingText.Text = percent .. " %"
        progressBarFill:TweenSize(UDim2.new(percent / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.4, true)
        wait(math.random(1.8, 3.2))
    end
    loadingText.Text = "COMPLETE!"
    wait(1)
    TweenService:Create(background, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    for _, v in ipairs(background:GetChildren()) do
        if v ~= gameFrame then
            TweenService:Create(v, TweenInfo.new(1), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        end
    end
    wait(1)
    background:Destroy()
end

-- ===== FINAL =====
setclipboard("discord.gg/jxJ8HNQKjH")
spawn(simulateLoading)
