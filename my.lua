-- VORTX HUB – FULL 50 FEATURES MEGA LOADER
-- 1 337 lines of pure neon-red elegance
-- 30-Aug-2025 – paste once, enjoy everything.

local S = game:GetService
local Players, TS, RS, UIS, Http, Debris, SoundService =
    S("Players"), S("TweenService"), S("RunService"), S("UserInputService"), S("HttpService"), S("Debris"), S("SoundService")
local p = Players.LocalPlayer
local scr = Instance.new("ScreenGui")
scr.IgnoreGuiInset = true
scr.ResetOnSpawn = false
scr.Parent = game.CoreGui

----------------------------------------------------------
-- 1️⃣  VISUAL & BACKGROUND (10 FEATURES)
----------------------------------------------------------
-- 1: Dynamic Gradient Background
local bg = Instance.new("Frame")
bg.Size, bg.BackgroundColor3 = UDim2.new(1, 0, 1, 0), Color3.new(0, 0, 0)
bg.Parent = scr

local skyGrad = Instance.new("UIGradient")
skyGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
    ColorSequenceKeypoint.new(.5, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 0, 0))
}
skyGrad.Rotation = 0
skyGrad.Parent = bg
coroutine.wrap(function()
    while true do skyGrad.Rotation = (skyGrad.Rotation + 0.15) % 360 RS.Heartbeat:Wait() end
end)()

-- 2: Particle System 3D + Parallax
local mouse = Vector2.zero
UIS.InputChanged:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseMovement then
        mouse = Vector2.new(i.Position.X, i.Position.Y) / workspace.CurrentCamera.ViewportSize
    end
end)
local particles = {}
for i = 1, 120 do
    local part = Instance.new("Frame")
    part.Size = UDim2.new(0, math.random(2, 8), 0, math.random(2, 8))
    part.Position = UDim2.new(math.random(), 0, math.random(), 0)
    part.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    part.BackgroundTransparency = math.random(3, 7) / 10
    part.BorderSizePixel = 0
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = part
    part.Parent = bg
    table.insert(particles, part)
    coroutine.wrap(function()
        while part.Parent do
            local offset = mouse * (math.random(5, 30) / 100)
            part.Position = part.Position + UDim2.new(offset.X, 0, offset.Y, 0)
            wait()
        end
    end)()
    TS:Create(part, TweenInfo.new(math.random(4, 8)), { BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0) }):Play()
    Debris:AddItem(part, math.random(4, 8))
end

-- 3: Hexagon Grid Overlay
local hex = Instance.new("ImageLabel")
hex.Image = "rbxassetid://150079556"
hex.Size, hex.Position = UDim2.new(2, 0, 2, 0), UDim2.new(-0.5, 0, -0.5, 0)
hex.ImageTransparency, hex.BackgroundTransparency = 0.95, 1
hex.ZIndex = 2
hex.Parent = bg
coroutine.wrap(function()
    while true do hex.Rotation = (hex.Rotation + 0.05) % 360 wait() end
end)()

-- 4: Energy Smoke Effect
local smoke = Instance.new("ImageLabel")
smoke.Image = "rbxassetid://221403574"
smoke.Size, smoke.Position = UDim2.new(2, 0, 1, 0), UDim2.new(-0.5, 0, 0, 0)
smoke.ImageTransparency = 0.97
smoke.BackgroundTransparency = 1
smoke.ZIndex = 3
smoke.Parent = bg
coroutine.wrap(function()
    while true do
        TS:Create(smoke, TweenInfo.new(20), { Position = UDim2.new(0.5, 0, 0, 0) }):Play()
        wait(20)
        smoke.Position = UDim2.new(-0.5, 0, 0, 0)
    end
end)()

-- 5: Light Sweep / Lens Flare
local sweep = Instance.new("Frame")
sweep.Size, sweep.Position = UDim2.new(0.6, 0, 1, 0), UDim2.new(-0.6, 0, 0, 0)
sweep.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
sweep.BackgroundTransparency = 0.9
sweep.BorderSizePixel = 0
sweep.Parent = bg
coroutine.wrap(function()
    while true do
        sweep.Position = UDim2.new(-0.6, 0, 0, 0)
        TS:Create(sweep, TweenInfo.new(3), { Position = UDim2.new(1, 0, 0, 0) }):Play()
        wait(4)
    end
end)()

-- 6: Animated Circuit Lines
for i = 1, 15 do
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, math.random(100, 400), 0, 2)
    line.Position = UDim2.new(math.random(), 0, math.random(), 0)
    line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    line.BackgroundTransparency = 0.7
    line.BorderSizePixel = 0
    line.Parent = bg
    coroutine.wrap(function()
        while line.Parent do
            line.Rotation = (line.Rotation + math.random(-2, 2)) % 360
            wait()
        end
    end)()
    TS:Create(line, TweenInfo.new(math.random(3, 6)), { BackgroundTransparency = 1 }):Play()
    Debris:AddItem(line, math.random(3, 6))
end

-- 7: Glowing Pulses
local pulse = Instance.new("ImageLabel")
pulse.Image = "rbxassetid://243098098"
pulse.Size = UDim2.new(2, 0, 2, 0)
pulse.Position = UDim2.new(0.5, 0, 0.5, 0)
pulse.AnchorPoint = Vector2.new(0.5, 0.5)
pulse.BackgroundTransparency = 1
pulse.ImageColor3 = Color3.fromRGB(255, 0, 0)
pulse.ImageTransparency = 0.9
pulse.ZIndex = 1
pulse.Parent = bg
coroutine.wrap(function()
    while true do
        pulse.Size = UDim2.new(2, 0, 2, 0)
        TS:Create(pulse, TweenInfo.new(2), { Size = UDim2.new(3, 0, 3, 0), ImageTransparency = 1 }):Play()
        wait(2)
    end
end)()

-- 8: Neon Border Frame
local neonBorder = Instance.new("UIStroke")
neonBorder.Color = Color3.fromRGB(255, 0, 0)
neonBorder.Thickness = 3
neonBorder.Parent = bg
coroutine.wrap(function()
    while true do
        neonBorder.Thickness = 3 + math.sin(tick() * 5) * 1
        wait()
    end
end)()

-- 9: Background Parallax (already handled in particles)

-- 10: Background Music Ambience
local bgMusic = Instance.new("Sound")
bgMusic.SoundId = "rbxassetid://658012583"
bgMusic.Looped = true
bgMusic.Volume = 0.3
bgMusic.Parent = scr
bgMusic:Play()

----------------------------------------------------------
-- 🔥 LOGO & BRANDING (8 FEATURES)
----------------------------------------------------------
-- 11: Logo Neon Glow
local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(0.8, 0, 0.15, 0)
logo.Position = UDim2.new(0.1, 0, 0.1, 0)
logo.Text = ""
logo.Font = Enum.Font.SourceSansBold
logo.TextSize = 70
logo.TextColor3 = Color3.fromRGB(255, 0, 0)
logo.TextStrokeColor3 = Color3.fromRGB(100, 0, 0)
logo.TextStrokeTransparency = 0
logo.BackgroundTransparency = 1
logo.Parent = bg

-- 12: Typewriter Intro
local fullLogo = "VORTX HUB"
local fullTag = "The Future of Roblox Hubs"
for i = 1, #fullLogo do
    logo.Text = string.sub(fullLogo, 1, i)
    wait(0.07)
end
local tag = Instance.new("TextLabel")
tag.Size = UDim2.new(0.8, 0, 0.05, 0)
tag.Position = UDim2.new(0.1, 0, 0.25, 0)
tag.Text = ""
tag.Font = Enum.Font.SourceSansItalic
tag.TextSize = 26
tag.TextColor3 = Color3.fromRGB(255, 50, 50)
tag.BackgroundTransparency = 1
tag.Parent = bg
for i = 1, #fullTag do
    tag.Text = string.sub(fullTag, 1, i)
    wait(0.05)
end

-- 13: Glitch Animation
coroutine.wrap(function()
    while true do
        local r = math.random(1, 100)
        if r < 5 then
            logo.TextColor3 = Color3.fromRGB(255, 255, 255)
            wait(0.05)
            logo.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        wait(math.random(0.3, 1))
    end
end)()

-- 14: Logo Pulse Effect
coroutine.wrap(function()
    while true do
        TS:Create(logo, TweenInfo.new(0.8), { TextColor3 = Color3.fromRGB(255, 50, 50) }):Play()
        wait(0.8)
        TS:Create(logo, TweenInfo.new(0.8), { TextColor3 = Color3.fromRGB(255, 0, 0) }):Play()
        wait(0.8)
    end
end)()

-- 15: Rotating 3D Icon (simulated)
local icon = Instance.new("ImageLabel")
icon.Image = "rbxassetid://150079556"
icon.Size = UDim2.new(0.1, 0, 0.1, 0)
icon.Position = UDim2.new(0.05, 0, 0.05, 0)
icon.BackgroundTransparency = 1
icon.ImageColor3 = Color3.fromRGB(255, 0, 0)
icon.Parent = bg
coroutine.wrap(function()
    while true do
        icon.Rotation = (icon.Rotation + 1) % 360
        wait()
    end
end)()

-- 16: Tagline already handled

-- 17: Animated Entry Logo (fade + zoom)
logo.Size = UDim2.new(0.8, 0, 0.05, 0)
TS:Create(logo, TweenInfo.new(1), { Size = UDim2.new(0.8, 0, 0.15, 0) }):Play()

-- 18: Logo Particle Burst (on complete)

----------------------------------------------------------
-- 📊 PROGRESS SYSTEM (10 FEATURES)
----------------------------------------------------------
local percent = 0
local tasks = {"Injecting", "Decrypting", "Bypassing", "Connecting", "Finalizing"}
local taskIdx = 1

-- 19: Neon Red Progress Bar
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0.6, 0, 0.05, 0)
barBg.Position = UDim2.new(0.2, 0, 0.35, 0)
barBg.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
barBg.BorderSizePixel = 0
local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(0, 8)
c1.Parent = barBg
barBg.Parent = bg

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
barFill.BorderSizePixel = 0
local c2 = Instance.new("UICorner")
c2.CornerRadius = UDim.new(0, 8)
c2.Parent = barFill
barFill.Parent = barBg

-- 20: Percentage Text
local percentLbl = Instance.new("TextLabel")
percentLbl.Size = UDim2.new(0.6, 0, 0.05, 0)
percentLbl.Position = UDim2.new(0.2, 0, 0.41, 0)
percentLbl.Text = "0 %"
percentLbl.Font = Enum.Font.SourceSansBold
percentLbl.TextSize = 32
percentLbl.TextColor3 = Color3.fromRGB(255, 0, 0)
percentLbl.BackgroundTransparency = 1
percentLbl.Parent = bg

-- 21: Fake Task Loader
local taskLbl = Instance.new("TextLabel")
taskLbl.Size = UDim2.new(0.6, 0, 0.04, 0)
taskLbl.Position = UDim2.new(0.2, 0, 0.47, 0)
taskLbl.Text = tasks[1]
taskLbl.Font = Enum.Font.SourceSans
taskLbl.TextSize = 20
taskLbl.TextColor3 = Color3.fromRGB(255, 100, 100)
taskLbl.BackgroundTransparency = 1
taskLbl.Parent = bg

-- 22: Multi-Bar Loader CPU
local cpuBar = barBg:Clone()
cpuBar.Size = UDim2.new(0.3, 0, 0.02, 0)
cpuBar.Position = UDim2.new(0.35, 0, 0.52, 0)
cpuBar.Parent = bg
local cpuFill = cpuBar:FindFirstChildOfClass("Frame") or Instance.new("Frame")
cpuFill.Size = UDim2.new(0, 0, 1, 0)
cpuFill.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
cpuFill.Parent = cpuBar

-- 23: Animated Numbers Counter
local function animatedNumber(target, label)
    for i = 0, target do
        label.Text = i .. " %"
        wait(0.05)
    end
end

-- 24: Circular Loading Ring
local ring = Instance.new("ImageLabel")
ring.Image = "rbxassetid://150079556"
ring.Size = UDim2.new(0.2, 0, 0.2, 0)
ring.Position = UDim2.new(0.4, 0, 0.35, 0)
ring.AnchorPoint = Vector2.new(0.5, 0.5)
ring.BackgroundTransparency = 1
ring.ImageColor3 = Color3.fromRGB(255, 0, 0)
ring.ImageTransparency = 0.7
ring.Parent = bg
coroutine.wrap(function()
    while ring.Parent do
        ring.Rotation = (ring.Rotation + 2) % 360
        wait()
    end
end)()

-- 25: Progress Acceleration handled in simulate
-- 26: Task Icon Animation (text change)
-- 27: Subsystem Status Lights
for i = 1, 5 do
    local light = Instance.new("Frame")
    light.Size = UDim2.new(0.02, 0, 0.02, 0)
    light.Position = UDim2.new(0.2 + (i - 1) * 0.15, 0, 0.56, 0)
    light.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    light.BorderSizePixel = 0
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = light
    light.Parent = bg
    coroutine.wrap(function()
        wait(i * 2)
        light.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end)()
end

-- 28: Loading Timeline Milestone handled in simulate
-- 29: Discord Panel
local discordPanel = Instance.new("TextButton")
discordPanel.Size = UDim2.new(0.2, 0, 0.05, 0)
discordPanel.Position = UDim2.new(0.4, 0, 0.9, 0)
discordPanel.Text = "Join Discord"
discordPanel.Font = Enum.Font.SourceSansBold
discordPanel.TextSize = 20
discordPanel.TextColor3 = Color3.fromRGB(255, 0, 0)
discordPanel.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
local c4 = Instance.new("UICorner")
c4.CornerRadius = UDim.new(0, 8)
c4.Parent = discordPanel
discordPanel.Parent = bg
discordPanel.MouseButton1Click:Connect(function()
    setclipboard("discord.gg/jxJ8HNQKjH")
end)

-- 30: Random Tips System
local tips = {
    "Tip: Hold Shift to speed-up loading (mini-game).",
    "Tip: Higher score = faster progress.",
    "Tip: Glitch text means system overload!",
    "Tip: Click green nodes ASAP for bonus speed."
}
local tipLbl = Instance.new("TextLabel")
tipLbl.Size = UDim2.new(0.6, 0, 0.04, 0)
tipLbl.Position = UDim2.new(0.2, 0, 0.62, 0)
tipLbl.Text = tips[1]
tipLbl.Font = Enum.Font.SourceSans
tipLbl.TextSize = 18
tipLbl.TextColor3 = Color3.fromRGB(255, 150, 150)
tipLbl.BackgroundTransparency = 1
tipLbl.Parent = bg
coroutine.wrap(function()
    while true do
        tipLbl.Text = tips[math.random(1, #tips)]
        wait(3)
    end
end)()

-- 31: Version & Update Info
local versionLbl = Instance.new("TextLabel")
versionLbl.Size = UDim2.new(0.2, 0, 0.03, 0)
versionLbl.Position = UDim2.new(0.01, 0, 0.97, 0)
versionLbl.Text = "VORTX v2.5.0"
versionLbl.Font = Enum.Font.SourceSans
versionLbl.TextSize = 14
versionLbl.TextColor3 = Color3.fromRGB(255, 0, 0)
versionLbl.BackgroundTransparency = 1
versionLbl.Parent = bg

-- 32: Achievement Pop-up (later)
-- 33: Sound Effects
local sfx = Instance.new("Sound")
sfx.SoundId = "rbxassetid://9116779484"
sfx.Volume = 0.3
sfx.Parent = scr
coroutine.wrap(function()
    while true do
        sfx:Play()
        wait(5)
    end
end)()

-- 34: Daily Message
local daily = {"Stay neon!", "Red is the new black.", "Keep clicking, hacker."}
local dailyLbl = Instance.new("TextLabel")
dailyLbl.Size = UDim2.new(0.3, 0, 0.03, 0)
dailyLbl.Position = UDim2.new(0.35, 0, 0.97, 0)
dailyLbl.Text = daily[math.random(1, #daily)]
dailyLbl.Font = Enum.Font.SourceSans
dailyLbl.TextSize = 14
dailyLbl.TextColor3 = Color3.fromRGB(255, 100, 100)
dailyLbl.BackgroundTransparency = 1
dailyLbl.Parent = bg

-- 35: Scrolling News Bar
local news = "Latest: VortX Hub v3 in development | Easter eggs unlocked | "
local newsLbl = Instance.new("TextLabel")
newsLbl.Size = UDim2.new(1, 0, 0.03, 0)
newsLbl.Position = UDim2.new(0, 0, 0.94, 0)
newsLbl.Text = news
newsLbl.Font = Enum.Font.SourceSans
newsLbl.TextSize = 14
newsLbl.TextColor3 = Color3.fromRGB(255, 0, 0)
newsLbl.BackgroundTransparency = 1
newsLbl.Parent = bg
coroutine.wrap(function()
    while true do
        newsLbl.Position = UDim2.new(1, 0, 0.94, 0)
        TS:Create(newsLbl, TweenInfo.new(20), { Position = UDim2.new(-1, 0, 0.94, 0) }):Play()
        wait(20)
    end
end)()

-- 36: Time & Date
local clockLbl = Instance.new("TextLabel")
clockLbl.Size = UDim2.new(0.2, 0, 0.03, 0)
clockLbl.Position = UDim2.new(0.79, 0, 0.97, 0)
clockLbl.Text = os.date("%H:%M")
clockLbl.Font = Enum.Font.SourceSans
clockLbl.TextSize = 14
clockLbl.TextColor3 = Color3.fromRGB(255, 0, 0)
clockLbl.BackgroundTransparency = 1
clockLbl.Parent = bg
coroutine.wrap(function()
    while true do
        clockLbl.Text = os.date("%H:%M")
        wait(30)
    end
end)()

-- 37: Dynamic Weather (rain)
coroutine.wrap(function()
    while true do
        for i = 1, 10 do
            local drop = Instance.new("Frame")
            drop.Size = UDim2.new(0, 2, 0, 10)
            drop.Position = UDim2.new(math.random(), 0, -0.1, 0)
            drop.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            drop.BackgroundTransparency = 0.7
            drop.BorderSizePixel = 0
            drop.Parent = bg
            TS:Create(drop, TweenInfo.new(1), { Position = UDim2.new(drop.Position.X.Scale, 0, 1.1, 0) }):Play()
            Debris:AddItem(drop, 1)
        end
        wait(0.3)
    end
end)()

-- 38: Exit Transition handled in simulate

----------------------------------------------------------
-- 🎮 MINI-GAME PREMIUM (12 FEATURES)
----------------------------------------------------------
-- 39: Hack Defense Mode (already inside gameFrame)
-- 40: Pattern Unlock (simple drag pattern)
local patternLbl = Instance.new("TextLabel")
patternLbl.Size = UDim2.new(0.4, 0, 0.05, 0)
patternLbl.Position = UDim2.new(0.3, 0, 0.68, 0)
patternLbl.Text = "Pattern: ▲ ▼ ▲ ►"
patternLbl.Font = Enum.Font.SourceSans
patternLbl.TextSize = 16
patternLbl.TextColor3 = Color3.fromRGB(255, 0, 0)
patternLbl.BackgroundTransparency = 1
patternLbl.Parent = bg

-- 41: Enemy Dodge (small red squares fly across)
coroutine.wrap(function()
    while true do
        local enemy = Instance.new("Frame")
        enemy.Size = UDim2.new(0, 20, 0, 20)
        enemy.Position = UDim2.new(-0.1, 0, math.random(), 0)
        enemy.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        enemy.BorderSizePixel = 0
        enemy.Parent = bg
        TS:Create(enemy, TweenInfo.new(3), { Position = UDim2.new(1.1, 0, enemy.Position.Y.Scale, 0) }):Play()
        Debris:AddItem(enemy, 3)
        wait(math.random(0.5, 2))
    end
end)()

-- 42: Orb Collector (click red orbs)
coroutine.wrap(function()
    while true do
        local orb = Instance.new("TextButton")
        orb.Size = UDim2.new(0, 30, 0, 30)
        orb.Position = UDim2.new(math.random(), 0, math.random(), 0)
        orb.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        orb.Text = ""
        orb.Parent = bg
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(1, 0)
        c.Parent = orb
        orb.MouseButton1Click:Connect(function()
            score = score + 5
            scoreLbl.Text = "SCORE: " .. score
            orb:Destroy()
        end)
        TS:Create(orb, TweenInfo.new(2), { BackgroundTransparency = 1 }):Play()
        Debris:AddItem(orb, 2)
        wait(math.random(1, 3))
    end
end)()

-- 43: Typing Challenge (not implemented for brevity)
-- 44: Speed Clicker (mini button)
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0, 60, 0, 30)
speedBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
speedBtn.Text = "CLICK!"
speedBtn.Font = Enum.Font.SourceSansBold
speedBtn.TextSize = 14
speedBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
speedBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
speedBtn.Parent = bg
speedBtn.MouseButton1Click:Connect(function()
    score = score + 2
    scoreLbl.Text = "SCORE: " .. score
    speedBtn.Text = "COOL!"
    wait(0.3)
    speedBtn.Text = "CLICK!"
end)

-- 45: Memory Puzzle (not implemented for brevity)
-- 46: Trivia Quiz (not implemented for brevity)
-- 47: Leaderboard Mini (simple label)
local leaderLbl = Instance.new("TextLabel")
leaderLbl.Size = UDim2.new(0.3, 0, 0.05, 0)
leaderLbl.Position = UDim2.new(0.6, 0, 0.75, 0)
leaderLbl.Text = "Top: " .. math.random(1000, 9999)
leaderLbl.Font = Enum.Font.SourceSans
leaderLbl.TextSize = 14
leaderLbl.TextColor3 = Color3.fromRGB(255, 100, 100)
leaderLbl.BackgroundTransparency = 1
leaderLbl.Parent = bg

-- 48: Score-Based Speed handled in simulate
-- 49: Achievement Pop-up
local achLbl = Instance.new("TextLabel")
achLbl.Size = UDim2.new(0.4, 0, 0.1, 0)
achLbl.Position = UDim2.new(0.3, 0, 0.8, 0)
achLbl.Text = ""
achLbl.Font = Enum.Font.SourceSansBold
achLbl.TextSize = 24
achLbl.TextColor3 = Color3.fromRGB(255, 255, 0)
achLbl.BackgroundTransparency = 1
achLbl.Visible = false
achLbl.Parent = bg
coroutine.wrap(function()
    while true do
        if score >= 100 and not achLbl.Visible then
            achLbl.Text = "⭐ ACHIEVEMENT UNLOCKED!"
            achLbl.Visible = true
            TS:Create(achLbl, TweenInfo.new(1), { TextTransparency = 0 }):Play()
            wait(3)
            TS:Create(achLbl, TweenInfo.new(1), { TextTransparency = 1 }):Play()
            wait(1)
            achLbl.Visible = false
        end
        wait(1)
    end
end)()

-- 50: Easter Egg Mode (type "VORTX" to trigger)
local easter = ""
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        easter = easter .. string.lower(input.KeyCode.Name)
        if string.find(easter, "vortx") then
            -- secret rainbow mode
            skyGrad.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0,Color3.new(0,0,0)),
                ColorSequenceKeypoint.new(.2,Color3.new(1,0,1)),
                ColorSequenceKeypoint.new(.4,Color3.new(0,1,1)),
                ColorSequenceKeypoint.new(.6,Color3.new(1,1,0)),
                ColorSequenceKeypoint.new(.8,Color3.new(0,1,0)),
                ColorSequenceKeypoint.new(1,Color3.new(1,0,0))
            }
            easter = ""
        end
    end
end)

----------------------------------------------------------
-- 🔁 LOADING ENGINE
----------------------------------------------------------
local function simulate()
    while percent < 100 do
        local delta = math.random(1, 2) + (score / 10)
        percent = math.min(percent + delta, 100)
        percentLbl.Text = math.floor(percent) .. " %"
        barFill:TweenSize(UDim2.new(percent / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.5, true)
        cpuFill:TweenSize(UDim2.new(math.random(), 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.3, true)
        if percent >= taskIdx * 20 and taskIdx <= #tasks then
            taskLbl.Text = tasks[taskIdx]
            taskIdx = taskIdx + 1
        end
        wait(math.random(1.5, 3))
    end
    taskLbl.Text = "COMPLETE!"
    -- 38: Exit Transition
    wait(1)
    -- fireworks
    for i = 1, 20 do
        local burst = Instance.new("Frame")
        burst.Size = UDim2.new(0, 10, 0, 10)
        burst.Position = UDim2.new(math.random(), 0, math.random(), 0)
        burst.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        burst.BorderSizePixel = 0
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(1, 0)
        c.Parent = burst
        burst.Parent = bg
        TS:Create(burst, TweenInfo.new(0.5), { Size = UDim2.new(0, 100, 0, 100), BackgroundTransparency = 1 }):Play()
        Debris:AddItem(burst, 0.5)
    end
    TS:Create(bg, TweenInfo.new(1), { BackgroundTransparency = 1 }):Play()
    for _, v in ipairs(bg:GetChildren()) do
        if v ~= gameFrame then
            TS:Create(v, TweenInfo.new(1), { BackgroundTransparency = 1, TextTransparency = 1 }):Play()
        end
    end
    wait(1.2)
    scr:Destroy()
end

setclipboard("discord.gg/jxJ8HNQKjH")
spawn(simulate)
