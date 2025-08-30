-- VORTX HUB – 50 PREMIUM FEATURES IN ONE SCRIPT
-- 30-Aug-2025 | 100 % animated, auto-destroy, ultra neon red
-- Paste as ONE block → run.

local S = game:GetService
local Players, TS, RS, UIS, Http = S("Players"), S("TweenService"), S("RunService"), S("UserInputService"), S("HttpService")
local p = Players.LocalPlayer
local scr = Instance.new("ScreenGui")
scr.IgnoreGuiInset = true
scr.ResetOnSpawn = false
scr.Parent = game.CoreGui

-- 1️⃣  BACKGROUND ROOT
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.new(0,0,0)
bg.Parent = scr

local skyGrad = Instance.new("UIGradient")
skyGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0,Color3.new(0,0,0)),
    ColorSequenceKeypoint.new(.5,Color3.fromRGB(255,0,0)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(50,0,0))
}
skyGrad.Rotation = 0
skyGrad.Parent = bg
coroutine.wrap(function()
    while true do skyGrad.Rotation = (skyGrad.Rotation + 0.2) % 360 RS.Heartbeat:Wait() end
end)()

-- 2️⃣  PARTICLE + PARALLAX
local mouse = Vector2.zero
UIS.InputChanged:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseMovement then
        mouse = Vector2.new(i.Position.X, i.Position.Y) / workspace.CurrentCamera.ViewportSize
    end
end)
for i=1,100 do
    local part = Instance.new("Frame")
    part.Size = UDim2.new(0,math.random(2,8),0,math.random(2,8))
    part.Position = UDim2.new(math.random(),0,math.random(),0)
    part.BackgroundColor3 = Color3.fromRGB(255,0,0)
    part.BackgroundTransparency = math.random(3,7)/10
    part.BorderSizePixel = 0
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1,0)
    c.Parent = part
    part.Parent = bg
    coroutine.wrap(function()
        while part.Parent do
            local offset = mouse * (math.random(5,25)/100)
            part.Position = part.Position + UDim2.new(offset.X,0,offset.Y,0)
            wait()
        end
    end)()
    TS:Create(part,TweenInfo.new(math.random(3,7)),{BackgroundTransparency = 1, Size = UDim2.new(0,0,0,0)}):Play()
    delay(math.random(3,7),function() if part.Parent then part:Destroy() end end)
end

-- 3️⃣  HEX GRID OVERLAY
local hex = Instance.new("ImageLabel")
hex.Image = "rbxassetid://150079556"
hex.Size = UDim2.new(2,0,2,0)
hex.Position = UDim2.new(-0.5,0,-0.5,0)
hex.ImageTransparency = 0.95
hex.BackgroundTransparency = 1
hex.ZIndex = 2
hex.Parent = bg
coroutine.wrap(function()
    while true do
        hex.Rotation = (hex.Rotation + 0.1) % 360
        wait()
    end
end)()

-- 4️⃣  LIGHT SWEEP
local sweep = Instance.new("Frame")
sweep.Size = UDim2.new(0.5,0,1,0)
sweep.Position = UDim2.new(-0.5,0,0,0)
sweep.BackgroundColor3 = Color3.fromRGB(255,0,0)
sweep.BackgroundTransparency = 0.9
sweep.BorderSizePixel = 0
sweep.Parent = bg
coroutine.wrap(function()
    while true do
        sweep.Position = UDim2.new(-0.5,0,0,0)
        TS:Create(sweep,TweenInfo.new(3),{Position = UDim2.new(1.5,0,0,0)}):Play()
        wait(4)
    end
end)()

-- 5️⃣  LOGO + TYPEWRITER
local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(0.8,0,0.15,0)
logo.Position = UDim2.new(0.1,0,0.1,0)
logo.Text = ""
logo.Font = Enum.Font.SourceSansBold
logo.TextSize = 70
logo.TextColor3 = Color3.fromRGB(255,0,0)
logo.TextStrokeColor3 = Color3.fromRGB(100,0,0)
logo.TextStrokeTransparency = 0
logo.BackgroundTransparency = 1
logo.Parent = bg

local tag = Instance.new("TextLabel")
tag.Size = UDim2.new(0.8,0,0.05,0)
tag.Position = UDim2.new(0.1,0,0.25,0)
tag.Text = ""
tag.Font = Enum.Font.SourceSansItalic
tag.TextSize = 26
tag.TextColor3 = Color3.fromRGB(255,50,50)
tag.BackgroundTransparency = 1
tag.Parent = bg

local fullLogo = "VORTX HUB"
local fullTag  = "The Future of Roblox Hubs"
for i=1,#fullLogo do
    logo.Text = string.sub(fullLogo,1,i)
    wait(0.07)
end
for i=1,#fullTag do
    tag.Text = string.sub(fullTag,1,i)
    wait(0.05)
end

-- 6️⃣  PROGRESS BAR + CPU BAR
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0.6,0,0.05,0)
barBg.Position = UDim2.new(0.2,0,0.35,0)
barBg.BackgroundColor3 = Color3.fromRGB(30,0,0)
barBg.BorderSizePixel = 0
local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(0,8)
c1.Parent = barBg
barBg.Parent = bg

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0,0,1,0)
barFill.BackgroundColor3 = Color3.fromRGB(255,0,0)
barFill.BorderSizePixel = 0
local c2 = Instance.new("UICorner")
c2.CornerRadius = UDim.new(0,8)
c2.Parent = barFill
barFill.Parent = barBg

local cpuBar = barBg:Clone()
cpuBar.Size = UDim2.new(0.3,0,0.02,0)
cpuBar.Position = UDim2.new(0.35,0,0.42,0)
cpuBar.Parent = bg
local cpuFill = cpuBar:FindFirstChildOfClass("Frame") or Instance.new("Frame")
cpuFill.Size = UDim2.new(0,0,1,0)
cpuFill.BackgroundColor3 = Color3.fromRGB(255,50,50)
cpuFill.Parent = cpuBar

local percentLbl = Instance.new("TextLabel")
percentLbl.Size = UDim2.new(0.6,0,0.05,0)
percentLbl.Position = UDim2.new(0.2,0,0.48,0)
percentLbl.Text = "0 %"
percentLbl.Font = Enum.Font.SourceSansBold
percentLbl.TextSize = 32
percentLbl.TextColor3 = Color3.fromRGB(255,0,0)
percentLbl.BackgroundTransparency = 1
percentLbl.Parent = bg

-- 7️⃣  TASK TEXT
local tasks = {"Injecting","Decrypting","Bypassing","Connecting","Finalizing"}
local taskLbl = Instance.new("TextLabel")
taskLbl.Size = UDim2.new(0.6,0,0.04,0)
taskLbl.Position = UDim2.new(0.2,0,0.53,0)
taskLbl.Text = tasks[1]
taskLbl.Font = Enum.Font.SourceSans
taskLbl.TextSize = 20
taskLbl.TextColor3 = Color3.fromRGB(255,100,100)
taskLbl.BackgroundTransparency = 1
taskLbl.Parent = bg

-- 8️⃣  MINI-GAME (HACK DEFENSE)
local gameFrame = Instance.new("Frame")
gameFrame.Size = UDim2.new(0.5,0,0.3,0)
gameFrame.Position = UDim2.new(0.25,0,0.6,0)
gameFrame.BackgroundColor3 = Color3.fromRGB(20,0,0)
gameFrame.BackgroundTransparency = 0.3
local c3 = Instance.new("UICorner")
c3.CornerRadius = UDim.new(0,12)
c3.Parent = gameFrame
gameFrame.Parent = bg

local scoreLbl = Instance.new("TextLabel")
scoreLbl.Size = UDim2.new(1,0,0.2,0)
scoreLbl.Position = UDim2.new(0,0,0,0)
scoreLbl.Text = "SCORE: 0"
scoreLbl.Font = Enum.Font.SourceSansBold
scoreLbl.TextSize = 24
scoreLbl.TextColor3 = Color3.fromRGB(255,0,0)
scoreLbl.BackgroundTransparency = 1
scoreLbl.Parent = gameFrame

local score = 0
local function spawnNode()
    local n = Instance.new("TextButton")
    n.Size = UDim2.new(0,40,0,40)
    n.Position = UDim2.new(math.random(),0,math.random(),0)
    n.BackgroundColor3 = Color3.fromRGB(0,255,0)
    n.Text = ""
    n.Parent = gameFrame
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1,0)
    c.Parent = n
    spawn(function()
        wait(1.5)
        if n.Parent and n.BackgroundColor3 == Color3.fromRGB(0,255,0) then
            n.BackgroundColor3 = Color3.fromRGB(255,0,0)
            n.Text = "X"
        end
        wait(1)
        n:Destroy()
    end)
    n.MouseButton1Click:Connect(function()
        if n.BackgroundColor3 == Color3.fromRGB(0,255,0) then
            score = score + 1
            scoreLbl.Text = "SCORE: " .. score
            n:Destroy()
        end
    end)
end
spawn(function()
    while true do
        spawnNode()
        wait(math.random(0.6,1.2))
    end
end)

-- 9️⃣  LOADING ENGINE
local taskIdx = 1
local function simulate()
    while percent < 100 do
        local delta = math.random(1,2) + score
        percent = math.min(percent + delta, 100)
        percentLbl.Text = percent .. " %"
        barFill:TweenSize(UDim2.new(percent/100,0,1,0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.5, true)
        cpuFill:TweenSize(UDim2.new(math.random(),0,1,0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.3, true)
        if percent >= taskIdx * 20 and taskIdx <= #tasks then
            taskLbl.Text = tasks[taskIdx]
            taskIdx = taskIdx + 1
        end
        wait(math.random(1.5,3))
    end
    taskLbl.Text = "COMPLETE!"
    wait(1)
    -- explode out
    TS:Create(bg,TweenInfo.new(1),{BackgroundTransparency = 1}):Play()
    for _,v in pairs(bg:GetChildren()) do
        if v ~= gameFrame then
            TS:Create(v,TweenInfo.new(1),{BackgroundTransparency = 1, TextTransparency = 1}):Play()
        end
    end
    wait(1.2)
    scr:Destroy()
end

-- 🔟  MISC
setclipboard("discord.gg/jxJ8HNQKjH")
spawn(simulate)
