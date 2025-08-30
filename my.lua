-- VortX Hub | Neon Cosmic Loader v3 (FIXED like v1 structure)
-- Everything is parented to CoreGui exactly like your first script
local player = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

------------------------------------------------------------------
-- 1. Dynamic black→red 3D starfield background
------------------------------------------------------------------
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.Parent = screenGui

-- 3D star camera
local cam = Instance.new("Camera")
cam.FieldOfView = 70
local viewport = Instance.new("ViewportFrame")
viewport.Size = UDim2.new(1, 0, 1, 0)
viewport.BackgroundTransparency = 1
viewport.CurrentCamera = cam
viewport.Parent = background
cam.Parent = viewport

-- Star generator
local starCount = 300
for i = 1, starCount do
    local star = Instance.new("Part")
    star.Shape = Enum.PartType.Ball
    star.Size = Vector3.new(math.random(1, 3) / 10, math.random(1, 3) / 10, math.random(1, 3) / 10)
    star.BrickColor = BrickColor.new("Neon orange")
    star.Material = Enum.Material.Neon
    star.Anchored = true
    star.CFrame = CFrame.new(
        math.random(-250, 250),
        math.random(-250, 250),
        math.random(-250, 250)
    )
    star.Parent = viewport
    spawn(function()
        while true do
            star.CFrame = star.CFrame * CFrame.new(0, 0, 0.1)
            if star.Position.Z > 250 then
                star.CFrame = CFrame.new(star.Position.X, star.Position.Y, -250)
            end
            RunService.RenderStepped:Wait()
        end
    end)
end

-- Red gradient overlay
local skyGradient = Instance.new("UIGradient")
skyGradient.Rotation = 0
skyGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 80))
}
skyGradient.Parent = background

spawn(function()
    while true do
        skyGradient.Rotation = (skyGradient.Rotation + 0.3) % 360
        RunService.RenderStepped:Wait()
    end
end)

------------------------------------------------------------------
-- 2. Brand & Discord (like v1)
------------------------------------------------------------------
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

local discordText = Instance.new("TextLabel")
discordText.Size = UDim2.new(0.6, 0, 0.08, 0)
discordText.Position = UDim2.new(0.2, 0, 0.2, 0)
discordText.Text = "discord.gg/jxJ8HNQKjH"
discordText.Font = Enum.Font.GothamBold
discordText.TextSize = 24
discordText.TextColor3 = Color3.fromRGB(255, 200, 200)
discordText.BackgroundTransparency = 1
discordText.Parent = background

------------------------------------------------------------------
-- 3. Progress bar + fake tasks
------------------------------------------------------------------
local progressBarBg = Instance.new("Frame")
progressBarBg.Size = UDim2.new(0.7, 0, 0.04, 0)
progressBarBg.Position = UDim2.new(0.15, 0, 0.8, 0)
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

-- Shine
local shine = Instance.new("Frame")
shine.Size = UDim2.new(0.3, 0, 1, 0)
shine.Position = UDim2.new(-0.3, 0, 0, 0)
shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
shine.BackgroundTransparency = 0.8
shine.BorderSizePixel = 0
shine.Parent = progressBarFill
TweenService:Create(shine, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Position = UDim2.new(1, 0, 0, 0)}):Play()

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(0.6, 0, 0.08, 0)
loadingText.Position = UDim2.new(0.2, 0, 0.72, 0)
loadingText.Text = "0 %"
loadingText.Font = Enum.Font.GothamBlack
loadingText.TextSize = 40
loadingText.TextColor3 = Color3.fromRGB(255, 100, 100)
loadingText.BackgroundTransparency = 1
loadingText.Parent = background

local fakeTask = Instance.new("TextLabel")
fakeTask.Size = UDim2.new(0.6, 0, 0.05, 0)
fakeTask.Position = UDim2.new(0.2, 0, 0.86, 0)
fakeTask.Text = "Initializing VortX engine..."
fakeTask.Font = Enum.Font.Gotham
fakeTask.TextSize = 18
fakeTask.TextColor3 = Color3.fromRGB(200, 200, 200)
fakeTask.BackgroundTransparency = 1
fakeTask.Parent = background

local tasks = {
    "Initializing VortX engine...",
    "Decrypting scripts...",
    "Preloading assets...",
    "Establishing secure connection...",
    "Finishing up..."
}
local taskIndex = 1

------------------------------------------------------------------
-- 4. Games container (hidden until load complete)
------------------------------------------------------------------
local gameFrame = Instance.new("Frame")
gameFrame.Size = UDim2.new(0.4, 0, 0.45, 0)
gameFrame.AnchorPoint = Vector2.new(0.5, 0)
gameFrame.Position = UDim2.new(0.5, 0, 0.45, 0)
gameFrame.BackgroundColor3 = Color3.fromRGB(30, 0, 40)
gameFrame.BackgroundTransparency = 0.2
gameFrame.Visible = false  -- Will show after loading
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
-- 5. Mini-games & achievements
------------------------------------------------------------------
local score = 0
local function addScore(amount)
    score = score + amount
    scoreText.Text = "ENERGY: " .. score
    if score >= 100 and not achievementLabel.Text:find("EASTER") then
        achievementLabel.Text = "⭐ EASTER EGG UNLOCKED! ⭐"
        -- Easter egg: disco background
        spawn(function()
            local hue = 0
            while true do
                hue = (hue + 2) % 360
                background.BackgroundColor3 = Color3.fromHSV(hue / 360, 1, 1)
                wait(0.1)
            end
        end)
    end
end

-- Memory Game
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
    local len = 3 + math.floor(score / 20)
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
    
    wait(2)
    
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
                    addScore(15)
                else
                    addScore(-5)
                end
                
                wait(1)
                createMemoryRound()
            end
        end)
    end
end

-- Trivia Game
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
        addScore(10)
    else
        addScore(-5)
    end
    nextTrivia()
end)

falseBtn.MouseButton1Click:Connect(function()
    if not trivia[triviaIndex].a then
        addScore(10)
    else
        addScore(-5)
    end
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
    showGame("Memory")
    createMemoryRound()
end)

triviaBtn.MouseButton1Click:Connect(function()
    showGame("Trivia")
end)

local function showGame(name)
    memoryFrame.Visible = (name == "Memory")
    triviaFrame.Visible = (name == "Trivia")
end

------------------------------------------------------------------
-- 6. Loading simulation → hide UI after complete
------------------------------------------------------------------
local percent = 0
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
    wait(1)
    
    -- Hide loading UI, show games
    background.Visible = false
    gameFrame.Visible = true
    showGame("Trivia") -- Default game
end

setclipboard("discord.gg/jxJ8HNQKjH")
spawn(simulateLoading)
