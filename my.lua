-- VortX Hub | Neon Cosmic Loader v2
-- Dynamic background, neon borders, mini-games & achievements
local player = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local playerGui = player:WaitForChild("PlayerGui")
local HttpService = game:GetService("HttpService")

local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

------------------------------------------------------------------
-- 1. Dynamic Gradient Background (Black → Red Neon)
------------------------------------------------------------------
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.Parent = screenGui

local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 80))
}
grad.Rotation = 0
grad.Parent = bg

spawn(function()
    while true do
        grad.Rotation = (grad.Rotation + 0.3) % 360
        RunService.RenderStepped:Wait()
    end
end)

------------------------------------------------------------------
-- 2. Neon Border Frame (Main container)
------------------------------------------------------------------
local container = Instance.new("Frame")
container.Size = UDim2.new(0.7, 0, 0.8, 0)
container.Position = UDim2.new(0.15, 0, 0.1, 0)
container.BackgroundTransparency = 1
container.Parent = bg

-- Neon stroke
local neonStroke = Instance.new("UIStroke")
neonStroke.Color = Color3.fromRGB(255, 0, 80)
neonStroke.Thickness = 2
neonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
neonStroke.Parent = container

-- Glow effect
local glow = Instance.new("ImageLabel")
glow.Image = "rbxassetid://243098098"
glow.Size = UDim2.new(1.06, 0, 1.06, 0)
glow.Position = UDim2.new(-0.03, 0, -0.03, 0)
glow.BackgroundTransparency = 1
glow.ImageTransparency = 0.8
glow.ImageColor3 = Color3.fromRGB(255, 0, 80)
glow.Parent = container

------------------------------------------------------------------
-- 3. Neon Red Progress Bar (Glow + Shine)
------------------------------------------------------------------
local progressHolder = Instance.new("Frame")
progressHolder.Size = UDim2.new(0.6, 0, 0.05, 0)
progressHolder.Position = UDim2.new(0.2, 0, 0.9, 0)
progressHolder.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
progressHolder.BorderSizePixel = 0
progressHolder.Parent = container

local round1 = Instance.new("UICorner")
round1.CornerRadius = UDim.new(0, 12)
round1.Parent = progressHolder

local stroke1 = Instance.new("UIStroke")
stroke1.Color = Color3.fromRGB(255, 0, 80)
stroke1.Thickness = 2
stroke1.Parent = progressHolder

local fill = Instance.new("Frame")
fill.Size = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
fill.BorderSizePixel = 0
fill.Parent = progressHolder

local round2 = Instance.new("UICorner")
round2.CornerRadius = UDim.new(0, 12)
round2.Parent = fill

-- Shine overlay
local shine = Instance.new("Frame")
shine.Size = UDim2.new(0.3, 0, 1, 0)
shine.Position = UDim2.new(-0.3, 0, 0, 0)
shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
shine.BackgroundTransparency = 0.8
shine.BorderSizePixel = 0
shine.Parent = fill

local shineTween = TweenService:Create(shine, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Position = UDim2.new(1, 0, 0, 0)})
shineTween:Play()

------------------------------------------------------------------
-- 4. Game Selector + Mini-Games
------------------------------------------------------------------
local gameFrame = Instance.new("Frame")
gameFrame.Size = UDim2.new(0.6, 0, 0.6, 0)
gameFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
gameFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
gameFrame.BorderSizePixel = 0
gameFrame.Visible = false
gameFrame.Parent = container

local round3 = Instance.new("UICorner")
round3.CornerRadius = UDim.new(0, 20)
round3.Parent = gameFrame

local stroke3 = Instance.new("UIStroke")
stroke3.Color = Color3.fromRGB(255, 0, 80)
stroke3.Thickness = 2
stroke3.Parent = gameFrame

local scoreLabel = Instance.new("TextLabel")
scoreLabel.Size = UDim2.new(1, 0, 0.1, 0)
scoreLabel.Position = UDim2.new(0, 0, 0, 0)
scoreLabel.BackgroundTransparency = 1
scoreLabel.Text = "SCORE: 0"
scoreLabel.Font = Enum.Font.GothamBold
scoreLabel.TextSize = 28
scoreLabel.TextColor3 = Color3.fromRGB(255, 50, 100)
scoreLabel.Parent = gameFrame

local achievementLabel = Instance.new("TextLabel")
achievementLabel.Size = UDim2.new(1, 0, 0.08, 0)
achievementLabel.Position = UDim2.new(0, 0, 0.92, 0)
achievementLabel.BackgroundTransparency = 1
achievementLabel.Text = ""
achievementLabel.Font = Enum.Font.GothamBold
achievementLabel.TextSize = 18
achievementLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
achievementLabel.Parent = gameFrame

local score = 0
local function addScore(amount)
    score = score + amount
    scoreLabel.Text = "SCORE: " .. score
    if score >= 100 and not achievementLabel.Text:find("EASTER") then
        achievementLabel.Text = "⭐ EASTER EGG UNLOCKED! ⭐"
        -- Easter egg: disco background
        spawn(function()
            local hue = 0
            while true do
                hue = (hue + 2) % 360
                bg.BackgroundColor3 = Color3.fromHSV(hue / 360, 1, 1)
                wait(0.1)
            end
        end)
    end
end

------------------------------------------------------------------
-- 4a. Memory Puzzle (Remember color pattern)
------------------------------------------------------------------
local memoryFrame = Instance.new("Frame")
memoryFrame.Size = UDim2.new(1, 0, 0.8, 0)
memoryFrame.Position = UDim2.new(0, 0, 0.1, 0)
memoryFrame.BackgroundTransparency = 1
memoryFrame.Visible = false
memoryFrame.Parent = gameFrame

local colors = {Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0), Color3.fromRGB(0,0,255)}
local pattern = {}
local userInput = {}
local memoryButtons = {}

local function newMemoryRound()
    -- clear
    for _, btn in ipairs(memoryButtons) do btn:Destroy() end
    memoryButtons = {}
    pattern = {}
    userInput = {}
    -- generate pattern
    for i = 1, 3 + #pattern do
        table.insert(pattern, colors[math.random(1, #colors)])
    end
    -- show pattern
    for i, col in ipairs(pattern) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.15, 0, 0.3, 0)
        btn.Position = UDim2.new(0.2 + (i - 1) * 0.2, 0, 0.3, 0)
        btn.BackgroundColor3 = col
        btn.Text = ""
        btn.BorderSizePixel = 0
        btn.Parent = memoryFrame
        table.insert(memoryButtons, btn)
    end
    wait(2)
    -- hide colors
    for _, btn in ipairs(memoryButtons) do
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
    -- user input
    for i, btn in ipairs(memoryButtons) do
        btn.MouseButton1Click:Connect(function()
            btn.BackgroundColor3 = colors[math.random(1, #colors)]
            table.insert(userInput, btn.BackgroundColor3)
            if #userInput == #pattern then
                local correct = true
                for j = 1, #pattern do
                    if userInput[j] ~= pattern[j] then correct = false break end
                end
                if correct then addScore(10) end
                wait(1)
                newMemoryRound()
            end
        end)
    end
end

------------------------------------------------------------------
-- 4b. Trivia Quiz (True / False)
------------------------------------------------------------------
local triviaFrame = Instance.new("Frame")
triviaFrame.Size = UDim2.new(1, 0, 0.8, 0)
triviaFrame.Position = UDim2.new(0, 0, 0.1, 0)
triviaFrame.BackgroundTransparency = 1
triviaFrame.Visible = false
triviaFrame.Parent = gameFrame

local triviaDB = {
    {q = "The sun is a star.", a = true},
    {q = "Roblox was released in 2004.", a = true},
    {q = "Lua is written in Python.", a = false}
}
local triviaIndex = 1

local triviaLabel = Instance.new("TextLabel")
triviaLabel.Size = UDim2.new(1, 0, 0.4, 0)
triviaLabel.Position = UDim2.new(0, 0, 0.2, 0)
triviaLabel.BackgroundTransparency = 1
triviaLabel.Text = triviaDB[triviaIndex].q
triviaLabel.Font = Enum.Font.GothamBold
triviaLabel.TextSize = 24
triviaLabel.TextWrapped = true
triviaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
triviaLabel.Parent = triviaFrame

local trueBtn = Instance.new("TextButton")
trueBtn.Size = UDim2.new(0.3, 0, 0.2, 0)
trueBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
trueBtn.Text = "TRUE"
trueBtn.Font = Enum.Font.GothamBold
trueBtn.TextSize = 20
trueBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
trueBtn.BorderSizePixel = 0
trueBtn.Parent = triviaFrame

local falseBtn = Instance.new("TextButton")
falseBtn.Size = UDim2.new(0.3, 0, 0.2, 0)
falseBtn.Position = UDim2.new(0.6, 0, 0.7, 0)
falseBtn.Text = "FALSE"
falseBtn.Font = Enum.Font.GothamBold
falseBtn.TextSize = 20
falseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
falseBtn.BorderSizePixel = 0
falseBtn.Parent = triviaFrame

local function nextTrivia()
    triviaIndex = triviaIndex + 1
    if triviaIndex > #triviaDB then triviaIndex = 1 end
    triviaLabel.Text = triviaDB[triviaIndex].q
end

trueBtn.MouseButton1Click:Connect(function()
    if triviaDB[triviaIndex].a then addScore(5) end
    nextTrivia()
end)

falseBtn.MouseButton1Click:Connect(function()
    if not triviaDB[triviaIndex].a then addScore(5) end
    nextTrivia()
end)

------------------------------------------------------------------
-- Game selector buttons
------------------------------------------------------------------
local function showGame(name)
    memoryFrame.Visible = (name == "Memory")
    triviaFrame.Visible = (name == "Trivia")
end

local memoryBtn = Instance.new("TextButton")
memoryBtn.Size = UDim2.new(0.4, 0, 0.1, 0)
memoryBtn.Position = UDim2.new(0.05, 0, 0.85, 0)
memoryBtn.Text = "Memory"
memoryBtn.Font = Enum.Font.GothamBold
memoryBtn.TextSize = 20
memoryBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
memoryBtn.BorderSizePixel = 0
memoryBtn.Parent = gameFrame

local triviaBtn = Instance.new("TextButton")
triviaBtn.Size = UDim2.new(0.4, 0, 0.1, 0)
triviaBtn.Position = UDim2.new(0.55, 0, 0.85, 0)
triviaBtn.Text = "Trivia"
triviaBtn.Font = Enum.Font.GothamBold
triviaBtn.TextSize = 20
triviaBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
triviaBtn.BorderSizePixel = 0
triviaBtn.Parent = gameFrame

memoryBtn.MouseButton1Click:Connect(function() showGame("Memory") newMemoryRound() end)
triviaBtn.MouseButton1Click:Connect(function() showGame("Trivia") end)

------------------------------------------------------------------
-- 5. Loading simulation → reveal games
------------------------------------------------------------------
local percent = 0
local function simulateLoading()
    while percent < 100 do
        local step = math.random(2, 5)
        percent = math.min(percent + step, 100)
        fill:TweenSize(UDim2.new(percent / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.3, true)
        wait(math.random(0.4, 1.2))
    end
    container:TweenPosition(UDim2.new(0.15, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    gameFrame.Visible = true
    showGame("Trivia")
end

spawn(simulateLoading)
setclipboard("discord.gg/jxJ8HNQKjH")
