-- VORTX HUB | NEON LOADER v6
-- Struktur 100% V1: semua langsung di CoreGui, semua muncul bersamaan, tanpa trivia
local player = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

------------------------------------------------------------------
-- 1. Background luar angkasa animasi
------------------------------------------------------------------
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.Parent = screenGui

-- bintang bergerak
for i = 1, 200 do
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(1, 4), 0, math.random(1, 4))
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
    star.BackgroundTransparency = math.random(2, 7) / 10
    star.BorderSizePixel = 0
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(1, 0); corner.Parent = star
    star.Parent = background
    spawn(function()
        while true do
            TweenService:Create(star, TweenInfo.new(math.random(5, 10)), {
                Position = UDim2.new(star.Position.X.Scale, 0, (star.Position.Y.Scale + 0.05) % 1, 0)
            }):Play()
            wait(math.random(5, 10))
        end
    end)
end

-- gradient merah neon berputar
local skyGradient = Instance.new("UIGradient")
skyGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 80))
}
skyGradient.Rotation = 0
skyGradient.Parent = background
spawn(function()
    while true do
        skyGradient.Rotation = (skyGradient.Rotation + 0.5) % 360
        RunService.RenderStepped:Wait()
    end
end)

------------------------------------------------------------------
-- 2. Brand utama (teks lebih bagus + glow merah)
------------------------------------------------------------------
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.9, 0, 0.1, 0)
title.Position = UDim2.new(0.05, 0, 0.05, 0)
title.Text = "VORTX HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 80
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.BackgroundTransparency = 1
title.TextStrokeColor3 = Color3.fromRGB(255, 50, 50)
title.TextStrokeTransparency = 0
title.Parent = background

-- animasi glow merah
spawn(function()
    while true do
        TweenService:Create(title, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
            TextColor3 = Color3.fromRGB(255, 50, 50),
            TextStrokeColor3 = Color3.fromRGB(255, 100, 100)
        }):Play()
        wait(0.8)
        TweenService:Create(title, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
            TextColor3 = Color3.fromRGB(255, 0, 0),
            TextStrokeColor3 = Color3.fromRGB(255, 50, 50)
        }):Play()
        wait(0.8)
    end
end)

------------------------------------------------------------------
-- 3. Frame Discord dengan tombol copy
------------------------------------------------------------------
local discordFrame = Instance.new("Frame")
discordFrame.Size = UDim2.new(0.35, 0, 0.08, 0)
discordFrame.Position = UDim2.new(0.325, 0, 0.18, 0)
discordFrame.BackgroundColor3 = Color3.fromRGB(40, 0, 60)
discordFrame.BackgroundTransparency = 0.3
discordFrame.BorderSizePixel = 0
local dCorner = Instance.new("UICorner")
dCorner.CornerRadius = UDim.new(0, 12)
dCorner.Parent = discordFrame
local dStroke = Instance.new("UIStroke")
dStroke.Color = Color3.fromRGB(255, 0, 80)
dStroke.Thickness = 2
dStroke.Parent = discordFrame
discordFrame.Parent = background

local discordText = Instance.new("TextButton")
discordText.Size = UDim2.new(1, 0, 1, 0)
discordText.Text = "discord.gg/jxJ8HNQKjH  [COPY]"
discordText.Font = Enum.Font.GothamBold
discordText.TextSize = 20
discordText.TextColor3 = Color3.fromRGB(255, 150, 150)
discordText.BackgroundTransparency = 1
discordText.Parent = discordFrame
discordText.MouseButton1Click:Connect(function()
    setclipboard("discord.gg/jxJ8HNQKjH")
    discordText.Text = "COPIED!"
    wait(1)
    discordText.Text = "discord.gg/jxJ8HNQKjH  [COPY]"
end)

------------------------------------------------------------------
-- 4. Progress Bar center + fake tasks
------------------------------------------------------------------
local progressBarBg = Instance.new("Frame")
progressBarBg.Size = UDim2.new(0.5, 0, 0.04, 0)
progressBarBg.Position = UDim2.new(0.25, 0, 0.45, 0)
progressBarBg.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
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
progressBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
local cornerFill = Instance.new("UICorner")
cornerFill.CornerRadius = UDim.new(0, 12)
cornerFill.Parent = progressBarFill
progressBarFill.Parent = progressBarBg

-- Shine effect
local shine = Instance.new("Frame")
shine.Size = UDim2.new(0.3, 0, 1, 0)
shine.Position = UDim2.new(-0.3, 0, 0, 0)
shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
shine.BackgroundTransparency = 0.8
shine.BorderSizePixel = 0
shine.Parent = progressBarFill
TweenService:Create(shine, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Position = UDim2.new(1, 0, 0, 0)}):Play()

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(0.2, 0, 0.05, 0)
loadingText.Position = UDim2.new(0.4, 0, 0.5, 0)
loadingText.Text = "0 %"
loadingText.Font = Enum.Font.GothamBlack
loadingText.TextSize = 34
loadingText.TextColor3 = Color3.fromRGB(255, 0, 0)
loadingText.BackgroundTransparency = 1
loadingText.Parent = background

local fakeTask = Instance.new("TextLabel")
fakeTask.Size = UDim2.new(0.6, 0, 0.04, 0)
fakeTask.Position = UDim2.new(0.2, 0, 0.4, 0)
fakeTask.Text = "Initializing VortX engine..."
fakeTask.Font = Enum.Font.Gotham
fakeTask.TextSize = 20
fakeTask.TextColor3 = Color3.fromRGB(200, 200, 200)
fakeTask.BackgroundTransparency = 1
fakeTask.Parent = background

------------------------------------------------------------------
-- 5. Games container (muncul bersamaan)
------------------------------------------------------------------
local gameFrame = Instance.new("Frame")
gameFrame.Size = UDim2.new(0.4, 0, 0.45, 0)
gameFrame.AnchorPoint = Vector2.new(0.5, 0)
gameFrame.Position = UDim2.new(0.5, 0, 0.6, 0)
gameFrame.BackgroundColor3 = Color3.fromRGB(30, 0, 40)
gameFrame.BackgroundTransparency = 0.2
gameFrame.Visible = true
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

-- Memory Game
local memoryFrame = Instance.new("Frame")
memoryFrame.Size = UDim2.new(1, 0, 0.7, 0)
memoryFrame.Position = UDim2.new(0, 0, 0.15, 0)
memoryFrame.BackgroundTransparency = 1
memoryFrame.Visible = true
memoryFrame.Parent = gameFrame

local colors = {Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0), Color3.fromRGB(0,0,255)}
local pattern = {}
local userInput = {}
local memoryButtons = {}
local score = 0

local function createMemoryRound()
    -- Clear old
    for _, btn in ipairs(memoryButtons) do btn:Destroy() end
    memoryButtons = {}
    pattern = {}
    userInput = {}
    
    -- Generate pattern
    local len = 3 + math.floor(score / 15)
    for i = 1, len do
        pattern[i] = colors[math.random(1, #colors)]
    end
    
    -- Show pattern
    for i, col in ipairs(pattern) do
        local btn = Instance.new("Frame")
        btn.Size = UDim2.new(0.15, 0, 0.3, 0)
        btn.Position = UDim2.new(0.2 + (i-1)*0.2, 0, 0.3, 0)
        btn.BackgroundColor3 = col
        btn.BorderSizePixel = 0
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn
        btn.Parent = memoryFrame
        table.insert(memoryButtons, btn)
    end
    
    wait(1.5)
    
    -- Hide colors
    for _, btn in ipairs(memoryButtons) do
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end
    
    -- User input
    for i, btn in ipairs(memoryButtons) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 1, 0)
        button.Text = ""
        button.BackgroundTransparency = 1
        button.Parent = btn
        
        button.MouseButton1Click:Connect(function()
            btn.BackgroundColor3 = pattern[i]
            table.insert(userInput, pattern[i])
            
            if #userInput == #pattern then
                local correct = true
                for j = 1, #pattern do
                    if userInput[j] ~= pattern[j] then
                        correct = false
                        break
                    end
                end
                
                if correct then
                    score = score + 15
                else
                    score = score - 5
                end
                scoreText.Text = "ENERGY: " .. score
                
                wait(1)
                createMemoryRound()
            end
        end)
    end
end

------------------------------------------------------------------
-- 6. Loading lama + improve animasi
------------------------------------------------------------------
local percent = 0
local tasks = {
    "Initializing VortX engine...",
    "Decrypting red-glow scripts...",
    "Loading memory modules...",
    "Connecting to VortX servers...",
    "Almost ready..."
}
local taskIndex = 1

local function simulateLoading()
    while percent < 100 do
        local step = math.random(1, 2)
        percent = math.min(percent + step, 100)
        
        -- Animasi progress bar lebih smooth
        TweenService:Create(progressBarFill, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {
            Size = UDim2.new(percent / 100, 0, 1, 0)
        }):Play()
        
        loadingText.Text = percent .. " %"
        
        -- Update fake tasks dengan animasi
        if percent % 20 == 0 and taskIndex < #tasks then
            taskIndex = taskIndex + 1
            fakeTask.Text = tasks[taskIndex]
            TweenService:Create(fakeTask, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        end
        
        wait(math.random(1.2, 2.5))
    end
    
    loadingText.Text = "COMPLETE!"
    fakeTask.Text = "Welcome to VortX Hub!"
    
    -- Fade out loading elements
    local fadeOut = TweenService:Create
    local fadeList = {progressBarBg, progressBarFill, loadingText, fakeTask, dFrame}
    
    for _, v in ipairs(fadeList) do
        if v:IsA("TextLabel") or v:IsA("TextButton") then
            fadeOut(v, TweenInfo.new(1), {TextTransparency = 1}):Play()
        else
            fadeOut(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
        end
    end
    
    wait(1)
    createMemoryRound()
end

setclipboard("discord.gg/jxJ8HNQKjH")
spawn(simulateLoading)
