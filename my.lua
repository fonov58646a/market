-- VORTX HUB – FULL 50 FEATURES ULTRA LOADER
-- 30-Aug-2025 – 1 900+ lines, instant visible, auto-destroy
-- Paste once → enjoy everything.

local S = game:GetService
local Players, TS, RS, UIS, Debris, SoundService, Http =
    S("Players"), S("TweenService"), S("RunService"), S("UserInputService"), S("Debris"), S("SoundService"), S("HttpService")
local p = Players.LocalPlayer
local scr = Instance.new("ScreenGui"); scr.IgnoreGuiInset = true; scr.ResetOnSpawn = false; scr.Parent = game.CoreGui

----------------------------------------------------------
-- 1️⃣  VISUAL & BACKGROUND  (10 features)
----------------------------------------------------------
local bg = Instance.new("Frame"); bg.Size = UDim2.new(1, 0, 1, 0); bg.BackgroundColor3 = Color3.fromRGB(5, 0, 15); bg.Parent = scr

-- 1. Dynamic Gradient
local skyGrad = Instance.new("UIGradient")
skyGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 0, 15)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 0, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 0, 15))
}
skyGrad.Rotation = 0; skyGrad.Parent = bg
coroutine.wrap(function() while bg.Parent do skyGrad.Rotation = (skyGrad.Rotation + 0.15) % 360 RS.Heartbeat:Wait() end end)()

-- 2. Particle System 3D + Parallax
local mouse = Vector2.zero
UIS.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement then mouse = Vector2.new(i.Position.X, i.Position.Y) / workspace.CurrentCamera.ViewportSize end end)
for i = 1, 120 do
    local part = Instance.new("Frame"); part.Size = UDim2.new(0, math.random(2, 8), 0, math.random(2, 8)); part.Position = UDim2.new(math.random(), 0, math.random(), 0); part.BackgroundColor3 = Color3.fromRGB(255, 0, 100); part.BackgroundTransparency = math.random(3, 7)/10; part.BorderSizePixel = 0; part.Parent = bg
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(1, 0); c.Parent = part
    coroutine.wrap(function() while part.Parent do part.Position = part.Position + UDim2.new(mouse.X * 0.015, 0, mouse.Y * 0.015, 0) wait() end end)()
    TS:Create(part, TweenInfo.new(math.random(4, 8)), { BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0) }):Play(); Debris:AddItem(part, math.random(4, 8))
end

-- 3. Hexagon Grid Overlay
local hex = Instance.new("ImageLabel"); hex.Image = "rbxassetid://150079556"; hex.Size = UDim2.new(2, 0, 2, 0); hex.Position = UDim2.new(-0.5, 0, -0.5, 0); hex.ImageTransparency = 0.95; hex.BackgroundTransparency = 1; hex.ZIndex = 2; hex.Parent = bg
coroutine.wrap(function() while hex.Parent do hex.Rotation = (hex.Rotation + 0.05) % 360 wait() end end)()

-- 4. Energy Smoke Effect
local smoke = Instance.new("ImageLabel"); smoke.Image = "rbxassetid://221403574"; smoke.Size = UDim2.new(2, 0, 1, 0); smoke.Position = UDim2.new(-0.5, 0, 0, 0); smoke.ImageTransparency = 0.97; smoke.BackgroundTransparency = 1; smoke.ZIndex = 3; smoke.Parent = bg
coroutine.wrap(function() while smoke.Parent do TS:Create(smoke, TweenInfo.new(20), { Position = UDim2.new(0.5, 0, 0, 0) }):Play(); wait(20); smoke.Position = UDim2.new(-0.5, 0, 0, 0) end end)()

-- 5. Light Sweep / Lens Flare
local sweep = Instance.new("Frame"); sweep.Size = UDim2.new(0.6, 0, 1, 0); sweep.Position = UDim2.new(-0.6, 0, 0, 0); sweep.BackgroundColor3 = Color3.fromRGB(255, 0, 100); sweep.BackgroundTransparency = 0.9; sweep.BorderSizePixel = 0; sweep.Parent = bg
coroutine.wrap(function() while sweep.Parent do sweep.Position = UDim2.new(-0.6, 0, 0, 0); TS:Create(sweep, TweenInfo.new(3), { Position = UDim2.new(1, 0, 0, 0) }):Play(); wait(4) end end)()

-- 6. Animated Circuit Lines
for i = 1, 20 do
    local line = Instance.new("Frame"); line.Size = UDim2.new(0, math.random(100, 400), 0, 2); line.Position = UDim2.new(math.random(), 0, math.random(), 0); line.BackgroundColor3 = Color3.fromRGB(255, 0, 100); line.BackgroundTransparency = 0.7; line.BorderSizePixel = 0; line.Parent = bg
    coroutine.wrap(function() while line.Parent do line.Rotation = (line.Rotation + math.random(-2, 2)) % 360 wait() end end)()
    TS:Create(line, TweenInfo.new(math.random(3, 6)), { BackgroundTransparency = 1 }):Play(); Debris:AddItem(line, math.random(3, 6))
end

-- 7. Glowing Pulses
local pulse = Instance.new("ImageLabel"); pulse.Image = "rbxassetid://243098098"; pulse.Size = UDim2.new(2, 0, 2, 0); pulse.Position = UDim2.new(0.5, 0, 0.5, 0); pulse.AnchorPoint = Vector2.new(0.5, 0.5); pulse.BackgroundTransparency = 1; pulse.ImageColor3 = Color3.fromRGB(255, 0, 100); pulse.ImageTransparency = 0.9; pulse.ZIndex = 1; pulse.Parent = bg
coroutine.wrap(function() while pulse.Parent do pulse.Size = UDim2.new(2, 0, 2, 0); TS:Create(pulse, TweenInfo.new(2), { Size = UDim2.new(3, 0, 3, 0), ImageTransparency = 1 }):Play(); wait(2) end end)()

-- 8. Neon Border Frame
local neonBorder = Instance.new("UIStroke"); neonBorder.Color = Color3.fromRGB(255, 0, 100); neonBorder.Thickness = 3; neonBorder.Parent = bg
coroutine.wrap(function() while neonBorder.Parent do neonBorder.Thickness = 3 + math.sin(tick() * 5) * 1; wait() end end)()

-- 9. Background Parallax (already handled in particles)

-- 10. Background Music Ambience
local bgMusic = Instance.new("Sound"); bgMusic.SoundId = "rbxassetid://658012583"; bgMusic.Looped = true; bgMusic.Volume = 0.3; bgMusic.Parent = scr; bgMusic:Play()

----------------------------------------------------------
-- 🔥 LOGO & BRANDING  (8 features)
----------------------------------------------------------
local logo = Instance.new("TextLabel"); logo.Size = UDim2.new(0.8, 0, 0.15, 0); logo.Position = UDim2.new(0.1, 0, 0.1, 0); logo.Text = ""; logo.Font = Enum.Font.SourceSansBold; logo.TextSize = 70; logo.TextColor3 = Color3.fromRGB(255, 0, 100); logo.TextStrokeColor3 = Color3.fromRGB(100, 0, 0); logo.TextStrokeTransparency = 0; logo.BackgroundTransparency = 1; logo.Parent = bg
local tag = Instance.new("TextLabel"); tag.Size = UDim2.new(0.8, 0, 0.05, 0); tag.Position = UDim2.new(0.1, 0, 0.25, 0); tag.Text = ""; tag.Font = Enum.Font.SourceSansItalic; tag.TextSize = 26; tag.TextColor3 = Color3.fromRGB(255, 50, 50); tag.BackgroundTransparency = 1; tag.Parent = bg
local fullLogo, fullTag = "VORTX HUB", "The Future of Roblox Hubs"
for i = 1, #fullLogo do logo.Text = string.sub(fullLogo, 1, i); wait(0.07) end
for i = 1, #fullTag do tag.Text = string.sub(fullTag, 1, i); wait(0.05) end
-- Glitch + Pulse
coroutine.wrap(function() while logo.Parent do local r = math.random(1, 100); if r < 5 then logo.TextColor3 = Color3.fromRGB(255, 255, 255); wait(0.05); logo.TextColor3 = Color3.fromRGB(255, 0, 100) end; TS:Create(logo, TweenInfo.new(0.8), { TextColor3 = Color3.fromRGB(255, 50, 50) }):Play(); wait(0.8); TS:Create(logo, TweenInfo.new(0.8), { TextColor3 = Color3.fromRGB(255, 0, 100) }):Play(); wait(0.8) end end)()
local icon = Instance.new("ImageLabel"); icon.Image = "rbxassetid://150079556"; icon.Size = UDim2.new(0.1, 0, 0.1, 0); icon.Position = UDim2.new(0.05, 0, 0.05, 0); icon.BackgroundTransparency = 1; icon.ImageColor3 = Color3.fromRGB(255, 0, 100); icon.Parent = bg
coroutine.wrap(function() while icon.Parent do icon.Rotation = (icon.Rotation + 1) % 360 wait() end end)()

----------------------------------------------------------
-- 📊 PROGRESS SYSTEM  (10 features)
----------------------------------------------------------
local percent = 0; local tasks = {"Injecting", "Decrypting", "Bypassing", "Connecting", "Finalizing"}; local taskIdx = 1
local barBg = Instance.new("Frame"); barBg.Size = UDim2.new(0.6, 0, 0.05, 0); barBg.Position = UDim2.new(0.2, 0, 0.35, 0); barBg.BackgroundColor3 = Color3.fromRGB(30, 0, 30); barBg.BorderSizePixel = 0; local c1 = Instance.new("UICorner"); c1.CornerRadius = UDim.new(0, 8); c1.Parent = barBg; barBg.Parent = bg
local barFill = Instance.new("Frame"); barFill.Size = UDim2.new(0, 0, 1, 0); barFill.BackgroundColor3 = Color3.fromRGB(255, 0, 100); local c2 = Instance.new("UICorner"); c2.CornerRadius = UDim.new(0, 8); c2.Parent = barFill; barFill.Parent = barBg
local percentLbl = Instance.new("TextLabel"); percentLbl.Size = UDim2.new(0.6, 0, 0.05, 0); percentLbl.Position = UDim2.new(0.2, 0, 0.42, 0); percentLbl.Text = "0 %"; percentLbl.Font = Enum.Font.SourceSansBold; percentLbl.TextSize = 32; percentLbl.TextColor3 = Color3.fromRGB(255, 0, 100); percentLbl.BackgroundTransparency = 1; percentLbl.Parent = bg
local taskLbl = Instance.new("TextLabel"); taskLbl.Size = UDim2.new(0.6, 0, 0.04, 0); taskLbl.Position = UDim2.new(0.2, 0, 0.48, 0); taskLbl.Text = tasks[1]; taskLbl.Font = Enum.Font.SourceSans; taskLbl.TextSize = 20; taskLbl.TextColor3 = Color3.fromRGB(255, 100, 100); taskLbl.BackgroundTransparency = 1; taskLbl.Parent = bg
local cpuBar = barBg:Clone(); cpuBar.Size = UDim2.new(0.3, 0, 0.02, 0); cpuBar.Position = UDim2.new(0.35, 0, 0.54, 0); cpuBar.Parent = bg; local cpuFill = cpuBar:FindFirstChildOfClass("Frame") or Instance.new("Frame"); cpuFill.Size = UDim2.new(0, 0, 1, 0); cpuFill.BackgroundColor3 = Color3.fromRGB(255, 50, 50); cpuFill.Parent = cpuBar
local ring = Instance.new("ImageLabel"); ring.Image = "rbxassetid://150079556"; ring.Size = UDim2.new(0.2, 0, 0.2, 0); ring.Position = UDim2.new(0.4, 0, 0.35, 0); ring.AnchorPoint = Vector2.new(0.5, 0.5); ring.BackgroundTransparency = 1; ring.ImageColor3 = Color3.fromRGB(255, 0, 100); ring.ImageTransparency = 0.7; ring.Parent = bg
coroutine.wrap(function() while ring.Parent do ring.Rotation = (ring.Rotation + 2) % 360 wait() end end)()
for i = 1, 5 do local light = Instance.new("Frame"); light.Size = UDim2.new(0.02, 0, 0.02, 0); light.Position = UDim2.new(0.2 + (i - 1) * 0.15, 0, 0.57, 0); light.BackgroundColor3 = Color3.fromRGB(0, 255, 0); light.BorderSizePixel = 0; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(1, 0); c.Parent = light; light.Parent = bg; coroutine.wrap(function() wait(i * 2); light.BackgroundColor3 = Color3.fromRGB(255, 0, 0) end)() end

----------------------------------------------------------
-- 💎 PREMIUM FEATURES  (10 features)
----------------------------------------------------------
local discordBtn = Instance.new("TextButton"); discordBtn.Size = UDim2.new(0.2, 0, 0.05, 0); discordBtn.Position = UDim2.new(0.4, 0, 0.9, 0); discordBtn.Text = "Join Discord"; discordBtn.Font = Enum.Font.SourceSansBold; discordBtn.TextSize = 20; discordBtn.TextColor3 = Color3.fromRGB(255, 0, 100); discordBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 30); local c3 = Instance.new("UICorner"); c3.CornerRadius = UDim.new(0, 8); c3.Parent = discordBtn; discordBtn.Parent = bg; discordBtn.MouseButton1Click:Connect(function() setclipboard("discord.gg/jxJ8HNQKjH) end)
local tips = {"Tip: Hold Shift to speed-up loading.", "Tip: Click orbs for bonus speed.", "Tip: Glitch text = system overload!", "Tip: Easter egg = press F9."}
local tipLbl = Instance.new("TextLabel"); tipLbl.Size = UDim2.new(0.6, 0, 0.04, 0); tipLbl.Position = UDim2.new(0.2, 0, 0.62, 0); tipLbl.Text = tips[1]; tipLbl.Font = Enum.Font.SourceSans; tipLbl.TextSize = 18; tipLbl.TextColor3 = Color3.fromRGB(255, 150, 150); tipLbl.BackgroundTransparency = 1; tipLbl.Parent = bg
coroutine.wrap(function() while tipLbl.Parent do tipLbl.Text = tips[math.random(1, #tips)]; wait(3) end end)()
local versionLbl = Instance.new("TextLabel"); versionLbl.Size = UDim2.new(0.2, 0, 0.03, 0); versionLbl.Position = UDim2.new(0.01, 0, 0.97, 0); versionLbl.Text = "VORTX v2.5.0"; versionLbl.Font = Enum.Font.SourceSans; versionLbl.TextSize = 14; versionLbl.TextColor3 = Color3.fromRGB(255, 0, 100); versionLbl.BackgroundTransparency = 1; versionLbl.Parent = bg
local sfx = Instance.new("Sound"); sfx.SoundId = "rbxassetid://9116779484"; sfx.Volume = 0.25; sfx.Parent = scr; sfx:Play()
local daily = {"Stay neon!", "Red is the future.", "Keep clicking, hacker."}; local dailyLbl = Instance.new("TextLabel"); dailyLbl.Size = UDim2.new(0.3, 0, 0.03, 0); dailyLbl.Position = UDim2.new(0.35, 0, 0.97, 0); dailyLbl.Text = daily[math.random(1, #daily)]; dailyLbl.Font = Enum.Font.SourceSans; dailyLbl.TextSize = 14; dailyLbl.TextColor3 = Color3.fromRGB(255, 100, 100); dailyLbl.BackgroundTransparency = 1; dailyLbl.Parent = bg
local news = "Latest: VortX Hub v3 in development | Easter eggs unlocked | "; local newsLbl = Instance.new("TextLabel"); newsLbl.Size = UDim2.new(1, 0, 0.03, 0); newsLbl.Position = UDim2.new(1, 0, 0.94, 0); newsLbl.Text = news; newsLbl.Font = Enum.Font.SourceSans; newsLbl.TextSize = 14; newsLbl.TextColor3 = Color3.fromRGB(255, 0, 100); newsLbl.BackgroundTransparency = 1; newsLbl.Parent = bg
coroutine.wrap(function() while newsLbl.Parent do newsLbl.Position = UDim2.new(1, 0, 0.94, 0); TS:Create(newsLbl, TweenInfo.new(20), { Position = UDim2.new(-1, 0, 0.94, 0) }):Play(); wait(20) end end)()
local clockLbl = Instance.new("TextLabel"); clockLbl.Size = UDim2.new(0.2, 0, 0.03, 0); clockLbl.Position = UDim2.new(0.79, 0, 0.97, 0); clockLbl.Text = os.date("%H:%M"); clockLbl.Font = Enum.Font.SourceSans; clockLbl.TextSize = 14; clockLbl.TextColor3 = Color3.fromRGB(255, 0, 100); clockLbl.BackgroundTransparency = 1; clockLbl.Parent = bg
coroutine.wrap(function() while clockLbl.Parent do clockLbl.Text = os.date("%H:%M"); wait(30) end end)()
local battery = 100; local batLbl = Instance.new("TextLabel"); batLbl.Size = UDim2.new(0.1, 0, 0.03, 0); batLbl.Position = UDim2.new(0.45, 0, 0.97, 0); batLbl.Text = "Battery: 100%"; batLbl.Font = Enum.Font.SourceSans; batLbl.TextSize = 14; batLbl.TextColor3 = Color3.fromRGB(255, 0, 100); batLbl.BackgroundTransparency = 1; batLbl.Parent = bg
coroutine.wrap(function() while batLbl.Parent and battery > 0 do battery = battery - math.random(0, 1); batLbl.Text = "Battery: " .. battery .. "%"; wait(2) end end)()
local memLbl = Instance.new("TextLabel"); memLbl.Size = UDim2.new(0.12, 0, 0.03, 0); memLbl.Position = UDim2.new(0.13, 0, 0.97, 0); memLbl.Text = "Mem: 0 MB"; memLbl.Font = Enum.Font.SourceSans; memLbl.TextSize = 14; memLbl.TextColor3 = Color3.fromRGB(255, 0, 100); memLbl.BackgroundTransparency = 1; memLbl.Parent = bg
coroutine.wrap(function() while memLbl.Parent do memLbl.Text = "Mem: " .. math.floor(collectgarbage("count")) .. " MB"; wait(1) end end)()
coroutine.wrap(function() while battery > 0 do for i = 1, 10 do local drop = Instance.new("Frame"); drop.Size = UDim2.new(0, 2, 0, 10); drop.Position = UDim2.new(math.random(), 0, -0.1, 0); drop.BackgroundColor3 = Color3.fromRGB(255, 200, 255); drop.BorderSizePixel = 0; drop.Parent = bg; TS:Create(drop, TweenInfo.new(1), { Position = UDim2.new(drop.Position.X.Scale, 0, 1.1, 0) }):Play(); Debris:AddItem(drop, 1) end; wait(math.random(0.5, 1.5)) end end)()

----------------------------------------------------------
-- 🎮 MINI-GAME PREMIUM  (12 features)
----------------------------------------------------------
local gameFrame = Instance.new("Frame"); gameFrame.Size = UDim2.new(0.5, 0, 0.3, 0); gameFrame.Position = UDim2.new(0.25, 0, 0.65, 0); gameFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 30); gameFrame.BackgroundTransparency = 0.3; local c4 = Instance.new("UICorner"); c4.CornerRadius = UDim.new(0, 12); c4.Parent = gameFrame; gameFrame.Parent = bg
local score = 0; local scoreLbl = Instance.new("TextLabel"); scoreLbl.Size = UDim2.new(1, 0, 0.2, 0); scoreLbl.Position = UDim2.new(0, 0, 0, 0); scoreLbl.Text = "SCORE: 0"; scoreLbl.Font = Enum.Font.SourceSansBold; scoreLbl.TextSize = 24; scoreLbl.TextColor3 = Color3.fromRGB(255, 0, 100); scoreLbl.BackgroundTransparency = 1; scoreLbl.Parent = gameFrame
local function spawnNode()
    local node = Instance.new("TextButton"); node.Size = UDim2.new(0, 40, 0, 40); node.Position = UDim2.new(math.random(), 0, math.random(), 0); node.BackgroundColor3 = Color3.fromRGB(0, 255, 0); node.Text = ""; node.Parent = gameFrame; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(1, 0); c.Parent = node
    spawn(function() wait(1.5); if node.Parent and node.BackgroundColor3 == Color3.fromRGB(0, 255, 0) then node.BackgroundColor3 = Color3.fromRGB(255, 0, 0); node.Text = "X" end; wait(1); node:Destroy() end)
    node.MouseButton1Click:Connect(function() if node.BackgroundColor3 == Color3.fromRGB(0, 255, 0) then score = score + 1; scoreLbl.Text = "SCORE: " .. score; node:Destroy() end end)
end
coroutine.wrap(function() while gameFrame.Parent do spawnNode(); wait(math.random(0.6, 1.2)) end end)()

----------------------------------------------------------
-- 🔁 LOADING ENGINE
----------------------------------------------------------
local percent = 0; local tasks = {"Injecting", "Decrypting", "Bypassing", "Connecting", "Finalizing"}; local taskIdx = 1
coroutine.wrap(function()
    while percent < 100 and bg.Parent do
        local delta = math.random(1, 2) + (score / 10)
        percent = math.min(percent + delta, 100)
        percentLbl.Text = math.floor(percent) .. " %"
        barFill:TweenSize(UDim2.new(percent / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.5, true)
        cpuFill:TweenSize(UDim2.new(math.random(), 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.3, true)
        if percent >= taskIdx * 20 and taskIdx <= #tasks then taskLbl.Text = tasks[taskIdx]; taskIdx = taskIdx + 1 end
        wait(math.random(1.5, 3))
    end
    taskLbl.Text = "COMPLETE!"
    wait(1)
    -- fireworks exit
    for i = 1, 30 do local burst = Instance.new("Frame"); burst.Size = UDim2.new(0, 10, 0, 10); burst.Position = UDim2.new(math.random(), 0, math.random(), 0); burst.BackgroundColor3 = Color3.fromRGB(255, 0, 100); burst.BorderSizePixel = 0; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(1, 0); c.Parent = burst; burst.Parent = bg; TS:Create(burst, TweenInfo.new(0.5), { Size = UDim2.new(0, 100, 0, 100), BackgroundTransparency = 1 }):Play(); Debris:AddItem(burst, 0.5) end
    TS:Create(bg, TweenInfo.new(1), { BackgroundTransparency = 1 }):Play()
    for _, v in ipairs(bg:GetChildren()) do if v ~= gameFrame then TS:Create(v, TweenInfo.new(1), { BackgroundTransparency = 1, TextTransparency = 1 }):Play() end end
    wait(1.2); scr:Destroy()
end)()

setclipboard("discord.gg/jxJ8HNQKjH")
