-- VortX Hub | Neon Cosmic Loader v4 - V1 STRUCTURE
-- Menggunakan cara pembuatan & parent seperti v1 (screenGui → CoreGui)
local player = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

------------------------------------------------------------------
-- 1. Background luar angkasa bergerak
------------------------------------------------------------------
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.Parent = screenGui

-- Bintang animasi
for i = 1, 150 do
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(1, 4), 0, math.random(1, 4))
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
    star.BackgroundTransparency = math.random(3, 7) / 10
    star.BorderSizePixel = 0
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = star
    star.Parent = background
    
    spawn(function()
        while true do
            TweenService:Create(star, TweenInfo.new(math.random(4, 8)), {
                Position = UDim2.new(star.Position.X.Scale, 0, (star.Position.Y.Scale + 0.1) % 1, 0)
            }):Play()
            wait(math.random(4, 8))
        end
    end)
end

-- Gradient merah neon
local skyGradient = Instance.new("UIGradient")
skyGradient.Rotation = 0
skyGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 0, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 80))
}
skyGradient.Parent = background

spawn(function()
    while true do
        skyGradient.Rotation = (skyGradient.Rotation + 0.4) % 360
        RunService.RenderStepped:Wait()
    end
end)

------------------------------------------------------------------
-- 2. Brand VORTX + Discord (animasi)
------------------------------------------------------------------
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.9, 0, 0.1, 0)
title.Position = UDim2.new(0.05, 0, 0.1, 0)
title.Text = "VORTX HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 60
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

------------------------------------------------------------------
-- 3. Frame Discord khusus (glow)
------------------------------------------------------------------
local discordFrame = Instance.new("Frame")
discordFrame.Size = UDim2.new(0.3, 0, 0.06, 0)
discordFrame.Position = UDim2.new(0.35, 0, 0.22, 0)
discordFrame.BackgroundColor3 = Color3.fromRGB(40, 0, 60)
discordFrame.BackgroundTransparency = 0.3
discordFrame.BorderSizePixel = 0
local dCorner = Instance.new("UICorner")
dCorner.CornerRadius = UDim.new(0, 12)
dCorner.Parent = discordFrame
local dStroke = Instance.new("UIStroke")
dStroke.Color = Color3.fromRGB(255, 0, 100)
dStroke.Thickness = 2
dStroke.Parent = discordFrame
discordFrame.Parent = background

local discordText = Instance.new("TextLabel")
discordText.Size = UDim2.new(1, 0, 1, 0)
discordText.Position = UDim2.new(0, 0, 0, 0)
discordText.Text = "discord.gg/jxJ8HNQKjH"
discordText.Font = Enum.Font.GothamBold
discordText.TextSize = 18
discordText.TextColor3 = Color3.fromRGB(255, 200, 200)
discordText.BackgroundTransparency = 1
discordText.Parent = discordFrame

------------------------------------------------------------------
-- 4. Progress Bar di tengah (full animasi)
------------------------------------------------------------------
local progressBarBg = Instance.new("Frame")
progressBarBg.Size = UDim2.new(0.5, 0, 0.04, 0)
progressBarBg.Position = UDim2.new(0.25, 0, 0.48, 0)
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
loadingText.Position = UDim2.new(0.4, 0, 0.53, 0)
loadingText.Text = "0 %"
loadingText.Font = Enum.Font.GothamBlack
loadingText.TextSize = 34
loadingText.TextColor3 = Color3.fromRGB(255, 0, 100)
loadingText.BackgroundTransparency = 1
loadingText.Parent = background

local fakeTask = Instance.new("TextLabel")
fakeTask.Size = UDim2.new(0.6, 0, 0.04, 0)
fakeTask.Position = UDim2.new(0.2, 0, 0.43, 0)
fakeTask.Text = "Loading VortX assets..."
fakeTask.Font = Enum.Font.Gotham
fakeTask.TextSize = 20
fakeTask.TextColor3 = Color3.fromRGB(200, 200, 200)
fakeTask.BackgroundTransparency = 1
fakeTask.Parent = background

------------------------------------------------------------------
-- 5. Games container (muncul setelah loading)
------------------------------------------------------------------
local gameFrame = Instance.new("Frame")
gameFrame.Size = UDim2.new(0.4, 0, 0.45, 0)
gameFrame.AnchorPoint = Vector2.new(0.5, 0)
gameFrame.Position = UDim2.new(0.5, 0, 0.45, 0)
gameFrame.BackgroundColor3 = Color3.fromRGB(30, 0, 40)
gameFrame.BackgroundTransparency = 0.2
gameFrame.Visible = false
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

------------------------------------------------------------------
-- 5a. Memory Puzzle
------------------------------------------------------------------
local memoryFrame = Instance.new("Frame")
memoryFrame.Size = UDim2.new(1, 0, 0.7, 0)
memoryFrame.Position = UDim2.new(0, 0, 0.15, 0)
memoryFrame.BackgroundTransparency = 1
memoryFrame.Visible = false
memoryFrame.Parent = gameFrame

local colors = {Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0), Color3.fromRGB(0,0,255)}
local pattern = {}
local userInput = {}
local memoryButtons = {}

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
-- 5b. Trivia Quiz
------------------------------------------------------------------
local triviaFrame = Instance.new("Frame")
triviaFrame.Size = UDim2.new(1, 0, 0.7, 0)
triviaFrame.Position = UDim2.new(0, 0, 0.15, 0)
triviaFrame.BackgroundTransparency = 1
triviaFrame.Visible = false
triviaFrame.Parent = gameFrame

local trivia = {
    {q = "Roblox was released in 2006?", a = true},
    {q = "Lua is case-sensitive?", a = true},
    {q = "The Earth is flat?", a = false},
    {q = "Neon parts glow in Roblox?", a = true},
    {q = "1+1=3?", a = false}
}
local triviaIndex = 1

local triviaLabel = Instance.new("TextLabel")
triviaLabel.Size = UDim2.new(1, 0, 0.3, 0)
triviaLabel.Position = UDim2.new(0, 0, 0.2, 0)
triviaLabel.Text = trivia[triviaIndex].q
triviaLabel.Font = Enum.Font.GothamBold
triviaLabel.TextSize = 22
triviaLabel.TextWrapped = true
triviaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
triviaLabel.BackgroundTransparency = 1
triviaLabel.Parent = triviaFrame

local trueBtn = Instance.new("TextButton")
trueBtn.Size = UDim2.new(0.3, 0, 0.2, 0)
trueBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
trueBtn.Text = "TRUE"
trueBtn.Font = Enum.Font.GothamBold
trueBtn.TextSize = 20
trueBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
trueBtn.BorderSizePixel = 0
trueBtn.Parent = triviaFrame

local falseBtn = Instance.new("TextButton")
falseBtn.Size = UDim2.new(0.3, 0, 0.2, 0)
falseBtn.Position = UDim2.new(0.6, 0, 0.6, 0)
falseBtn.Text = "FALSE"
falseBtn.Font = Enum.Font.GothamBold
falseBtn.TextSize = 20
falseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
falseBtn.BorderSizePixel = 0
falseBtn.Parent = triviaFrame

local function nextTrivia()
    triviaIndex = triviaIndex + 1
    if triviaIndex > #trivia then triviaIndex = 1 end
    triviaLabel.Text = trivia[triviaIndex].q
end

trueBtn.MouseButton1Click:Connect(function()
    if trivia[triviaIndex].a then
        score = score + 10
    else
        score = score - 5
    end
    scoreText.Text = "ENERGY: " .. score
    nextTrivia()
end)

falseBtn.MouseButton1Click:Connect(function()
    if not trivia[triviaIndex].a then
        score = score + 10
    else
        score = score - 5
    end
    scoreText.Text = "ENERGY: " .. score
    nextTrivia()
end)

-- Achievement label
local achievementLabel = Instance.new("TextLabel")
achievementLabel.Size = UDim2.new(1, 0, 0.15, 0)
achievementLabel.Position = UDim2.new(0, 0, 0.85, 0)
achievementLabel.Text = ""
achievementLabel.Font = Enum.Font.GothamBold
achievementLabel.TextSize = 18
achievementLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
achievementLabel.BackgroundTransparency = 1
achievementLabel.Parent = gameFrame

-- Game selector buttons
local memoryBtn = Instance.new("TextButton")
memoryBtn.Size = UDim2.new(0.35, 0, 0.1, 0)
memoryBtn.Position = UDim2.new(0.1, 0, 0.85, 0)
memoryBtn.Text = "Memory"
memoryBtn.Font = Enum.Font.GothamBold
memoryBtn.TextSize = 20
memoryBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 90)
memoryBtn.BorderSizePixel = 0
memoryBtn.Parent = gameFrame

local triviaBtn = Instance.new("TextButton")
triviaBtn.Size = UDim2.new(0.35, 0, 0.1, 0)
triviaBtn.Position = UDim2.new(0.55, 0, 0.85, 0)
triviaBtn.Text = "Trivia"
triviaBtn.Font = Enum.Font.GothamBold
triviaBtn.TextSize = 20
triviaBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 90)
triviaBtn.BorderSizePixel = 0
triviaBtn.Parent = gameFrame

memoryBtn.MouseButton1Click:Connect(function()
    triviaFrame.Visible = false
    memoryFrame.Visible = true
    createMemoryRound()
end)

triviaBtn.MouseButton1Click:Connect(function()
    memoryFrame.Visible = false
    triviaFrame.Visible = true
end)

------------------------------------------------------------------
-- 6. Loading simulation → hide UI setelah complete
------------------------------------------------------------------
local percent = 0
local tasks = {
    "Loading VortX assets...",
    "Decrypting scripts...",
    "Preloading games...",
    "Connecting to server...",
    "Finalizing..."
}
local taskIndex = 1

local function simulateLoading()
    while percent < 100 do
        local step = math.random(2, 5)
        percent = math.min(percent + step, 100)
        loadingText.Text = percent .. " %"
        progressBarFill:TweenSize(UDim2.new(percent / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.3, true)
        
        -- Update fake tasks
        if percent % 20 == 0 and taskIndex < #tasks then
            taskIndex = taskIndex + 1
            fakeTask.Text = tasks[taskIndex]
        end
        
        wait(math.random(0.4, 1.2))
    end
    
    loadingText.Text = "COMPLETE!"
    fakeTask.Text = "Launching games..."
    wait(1.5)
    
    -- Fade out loading UI
    TweenService:Create(background, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    for _, v in ipairs({title, discordFrame, progressBarBg, loadingText, fakeTask}) do
        TweenService:Create(v, TweenInfo.new(0.6), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
    end
    
    wait(0.6)
    
    -- Hide loading UI and show games
    background.Visible = false
    gameFrame.Visible = true
    triviaFrame.Visible = true -- Default game
end

setclipboard("discord.gg/jxJ8HNQKjH")
spawn(simulateLoading)
