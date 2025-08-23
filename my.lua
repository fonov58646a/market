-- Load Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()

-- Initialize Window
local Window = OrionLib:MakeWindow({
    Name = "HyperShotLum",
    IntroEnabled = true,
    IntroText = "HyperShotLum",
    HidePremium = true
})

-- Create Tabs
local silentaimTab = Window:MakeTab({
    Name = "SilentAim",
    Icon = "rbxassetid://4483345875"
})

local bigheadTab = Window:MakeTab({
    Name = "BigHead",
    Icon = "rbxassetid://4483345875"
})

local tpallTab = Window:MakeTab({
    Name = "TPAll",
    Icon = "rbxassetid://4483345875"
})

local otherTab = Window:MakeTab({
    Name = "Other",
    Icon = "rbxassetid://4483345875"
})

-- Global Configuration
getgenv().hypershotlum = {
    silentaim = {
        enabled = false,
        teamcheck = true,
        wallcheck = false,
        fov = 200,
        showfov = false,
        showsnapline = true,
        fovcolor = Color3.fromRGB(1, 1, 1),
        snapcolor = Color3.fromRGB(1, 1, 1),
        hitchance = 100,
        hitpart = "Head",
        dynamicfov = false,
        magicbullet = true,
        visibilitycheck = false
    },
    bighead = {
        enabled = false,
        size = 3
    },
    tpall = {
        players = false,
        bots = false,
        teamcheck = false,
        offset = 5,
        tpweapons = false
    },
    other = {
        nocooldown = false,
        luffy = false
    }
}

-- Services
local a = game:GetService("UserInputService")
local b = game:GetService("RunService")
local c = game:GetService("Players")
local d = c.LocalPlayer
local e = workspace.CurrentCamera
local f = workspace
local g = getgenv().hypershotlum.silentaim
local h = {
    aimbone = g.hitpart,
    aimboneenabled = g.enabled,
    usefov = true,
    showfov = g.showfov,
    showtargetline = g.showsnapline,
    visibilitycheck = g.visibilitycheck,
    fovsize = g.fov
}

-- Drawing Objects
local i = Drawing.new("Circle")
i.Radius = g.fov
i.Color = g.fovcolor
i.Thickness = 1
i.Filled = false
i.Transparency = 0
i.Visible = g.showfov
i.ZIndex = 3

local j = Drawing.new("Circle")
j.Radius = g.fov
j.Color = Color3.new(0, 0, 0)
j.Thickness = 2.5
j.Filled = false
j.Transparency = 1
j.Visible = g.showfov
j.ZIndex = 1

local k = Drawing.new("Line")
k.Color = g.snapcolor
k.Thickness = 1
k.Transparency = 0
k.Visible = g.showsnapline
k.ZIndex = 3

local l = Drawing.new("Line")
l.Color = Color3.new(0, 0, 0)
l.Thickness = 2.5
l.Transparency = 1
l.Visible = g.showsnapline
l.ZIndex = 1

-- Utility Functions
local function m(n)
    if not g.visibilitycheck then return true end
    local o = e.CFrame.Position
    local p = (n.Position - o).Unit * 1000
    local q = RaycastParams.new()
    q.FilterDescendantsInstances = {d.Character}
    q.FilterType = Enum.RaycastFilterType.Blacklist
    local r = f:Raycast(o, p, q)
    if r then
        local s = r.Instance
        return s:IsDescendantOf(n.Parent)
    end
    return true
end

local function t(u)
    if not g.teamcheck then return true end
    local v = d:GetAttribute("Team")
    if not v then return true end
    local w = nil
    if typeof(u) == "Instance" then
        w = u:GetAttribute("Team")
        if not w and u:IsA("Model") then
            local x = c:GetPlayerFromCharacter(u)
            if x then w = x:GetAttribute("Team") end
        end
    end
    if not w then return true end
    return v ~= w
end

local function y(z)
    local aa, ab = e:WorldToViewportPoint(z)
    return Vector2.new(aa.X, aa.Y), ab
end

local function ac(ad)
    local ae = ad and ad:FindFirstChildOfClass("Humanoid")
    return ae and ae.Health > 0
end

local function af(ag)
    if not ag then return nil end
    local ah = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso", "LeftArm", "RightArm", "LeftLeg", "RightLeg"}
    local ai = {}
    for _, aj in pairs(ah) do
        local ak = ag:FindFirstChild(aj)
        if ak then table.insert(ai, ak) end
    end
    if #ai > 0 then
        return ai[math.random(1, #ai)]
    else
        return ag:FindFirstChild("Head") or ag:FindFirstChild("HumanoidRootPart")
    end
end

local function al(am)
    if not am then return nil end
    if g.hitpart == "Random" then
        return af(am)
    else
        return am:FindFirstChild(g.hitpart)
    end
end

local function an()
    local ao = Vector2.new(e.ViewportSize.X / 2, e.ViewportSize.Y / 2)
    local ap = nil
    local aq = g.fov
    for _, ar in pairs(f:GetChildren()) do
        if ar:IsA("Model") and ar:FindFirstChild(h.aimbone) and ac(ar) then
            if not d.Character or ar ~= d.Character then
                if t(ar) then
                    local as = ar[h.aimbone]
                    local at, au = y(as.Position)
                    if au and m(as) then
                        local av = (ao - at).Magnitude
                        if h.usefov and av < aq then
                            aq = av
                            ap = as
                        elseif not h.usefov then
                            ap = as
                            break
                        end
                    end
                end
            end
        end
    end
    local aw = f:FindFirstChild("Mobs")
    if aw then
        for _, ax in pairs(aw:GetChildren()) do
            if ax:FindFirstChild(h.aimbone) and ac(ax) then
                if t(ax) then
                    local ay = ax[h.aimbone]
                    local az, ba = y(ay.Position)
                    if ba and m(ay) then
                        local bb = (ao - az).Magnitude
                        if h.usefov and bb < aq then
                            aq = bb
                            ap = ay
                        elseif not h.usefov then
                            ap = ay
                            break
                        end
                    end
                end
            end
        end
    end
    return ap
end

local bc = false
a.TouchTap:Connect(function()
    bc = not bc
end)

-- RenderStepped Connections
b.RenderStepped:Connect(function()
    if not g.enabled then
        g.target = nil
        g.istargeting = false
        i.Visible = false
        j.Visible = false
        k.Visible = false
        l.Visible = false
        return
    end

    local bh = Vector2.new(e.ViewportSize.X / 2, e.ViewportSize.Y / 2)
    local bi = g.fov
    local bj = bi * 0.35
    local bk = bi
    if g.dynamicfov and bc then
        bk = bi + bj
    end

    i.Position = bh
    i.Radius = bk
    j.Position = bh
    j.Radius = bk
    i.Visible = g.showfov and g.enabled
    j.Visible = g.showfov and g.enabled

    local bl = an()
    g.target = bl
    g.istargeting = bl ~= nil

    if g.istargeting and g.showsnapline then
        local bm, bn = y(bl.Position)
        if bn then
            l.From = bh
            l.To = bm
            l.Visible = true
            k.From = bh
            k.To = bm
            k.Visible = true
        else
            k.Visible = false
            l.Visible = false
        end
    else
        k.Visible = false
        l.Visible = false
    end
end)

local bo
bo = hookmetamethod(game, "__namecall", function(bp, ...)
    local bq = getnamecallmethod()
    local br = {...}
    if not checkcaller() and bp == f and bq == "Raycast" and g.enabled and g.istargeting and g.target then
        if math.random(1, 100) > g.hitchance then
            return bo(bp, ...)
        end
        local bs = br[1]
        local bt = g.target.Position
        if g.magicbullet then
            local bu = {
                Instance = g.target,
                Position = bt,
                Normal = Vector3.new(5, 5, 5),
                Material = Enum.Material.Plastic,
                Distance = (bt - bs).Magnitude
            }
            local bv = {}
            bv.__index = bv
            function bv:Distance() return self.Distance end
            function bv:Position() return self.Position end
            function bv:Instance() return self.Instance end
            setmetatable(bu, bv)
            return bu
        else
            local bw = (bt - bs).Unit * 1000
            br[2] = bw
            return bo(bp, unpack(br))
        end
    end
    return bo(bp, ...)
end)

-- UI Elements
silentaimTab:AddToggle({
    Name = "Enabled",
    Callback = function(value)
        getgenv().hypershotlum.silentaim.enabled = value
        i.Visible = value and getgenv().hypershotlum.silentaim.showfov
        j.Visible = value and getgenv().hypershotlum.silentaim.showfov
    end,
    Save = true,
    Flag = "silentaim_enabled"
})

silentaimTab:AddSlider({
    Name = "FOV",
    Min = 1,
    Max = 500,
    Callback = function(value)
        getgenv().hypershotlum.silentaim.fov = value
        i.Radius = value
        j.Radius = value
    end,
    Save = true,
    Flag = "silentaim_fov"
})

silentaimTab:AddToggle({
    Name = "Show FOV",
    Callback = function(value)
        getgenv().hypershotlum.silentaim.showfov = value
        i.Visible = value and getgenv().hypershotlum.silentaim.enabled
        j.Visible = value and getgenv().hypershotlum.silentaim.enabled
    end,
    Save = true,
    Flag = "silentaim_showfov"
})

silentaimTab:AddToggle({
    Name = "Team Check",
    Callback = function(value)
        getgenv().hypershotlum.silentaim.teamcheck = value
    end,
    Save = true,
    Flag = "silentaim_teamcheck"
})

silentaimTab:AddToggle({
    Name = "Wall Check",
    Callback = function(value)
        getgenv().hypershotlum.silentaim.wallcheck = value
    end,
    Save = true,
    Flag = "silentaim_wallcheck"
})

silentaimTab:AddToggle({
    Name = "Dynamic FOV",
    Callback = function(value)
        getgenv().hypershotlum.silentaim.dynamicfov = value
    end,
    Save = true,
    Flag = "silentaim_dynamicfov"
})

silentaimTab:AddToggle({
    Name = "Magic Bullet",
    Callback = function(value)
        getgenv().hypershotlum.silentaim.magicbullet = value
    end,
    Save = true,
    Flag = "silentaim_magicbullet"
})

silentaimTab:AddToggle({
    Name = "Visibility Check",
    Callback = function(value)
        getgenv().hypershotlum.silentaim.visibilitycheck = value
    end,
    Save = true,
    Flag = "silentaim_visibilitycheck"
})

-- BigHead Tab
bigheadTab:AddToggle({
    Name = "Enabled",
    Callback = function(value)
        getgenv().hypershotlum.bighead.enabled = value
    end,
    Save = true,
    Flag = "bighead_enabled"
})

bigheadTab:AddSlider({
    Name = "Size",
    Min = 1,
    Max = 10,
    Callback = function(value)
        getgenv().hypershotlum.bighead.size = value
    end,
    Save = true,
    Flag = "bighead_size"
})

-- TPAll Tab
tpallTab:AddToggle({
    Name = "Players",
    Callback = function(value)
        getgenv().hypershotlum.tpall.players = value
    end,
    Save = true,
    Flag = "tpall_players"
})

tpallTab:AddToggle({
    Name = "Bots",
    Callback = function(value)
        getgenv().hypershotlum.tpall.bots = value
    end,
    Save = true,
    Flag = "tpall_bots"
})

tpallTab:AddToggle({
    Name = "Team Check",
    Callback = function(value)
        getgenv().hypershotlum.tpall.teamcheck = value
    end,
    Save = true,
    Flag = "tpall_teamcheck"
})

tpallTab:AddSlider({
    Name = "Offset",
    Min = 1,
    Max = 20,
    Callback = function(value)
        getgenv().hypershotlum.tpall.offset = value
    end,
    Save = true,
    Flag = "tpall_offset"
})

tpallTab:AddToggle({
    Name = "TP Weapons",
    Callback = function(value)
        getgenv().hypershotlum.tpall.tpweapons = value
    end,
    Save = true,
    Flag = "tpall_tpweapons"
})

-- Other Tab
otherTab:AddToggle({
    Name = "No Cooldown",
    Callback = function(value)
        getgenv().hypershotlum.other.nocooldown = value
        if value then
            for _, v in next, getgc(true) do
                if typeof(v) == 'table' and rawget(v, 'CD') then
                    rawset(v, 'CD', 0)
                end
            end
        end
    end,
    Save = true,
    Flag = "other_nocooldown"
})

otherTab:AddToggle({
    Name = "Luffy",
    Callback = function(value)
        getgenv().hypershotlum.other.luffy = value
        if value then
            for _, v in next, getgc(true) do
                if typeof(v) == 'table' and rawget(v, 'Spread') then
                    rawset(v, 'Spread', 0)
                    rawset(v, 'BaseSpread', 0)
                    rawset(v, 'MinCamRecoil', Vector3.new())
                    rawset(v, 'MaxCamRecoil', Vector3.new())
                    rawset(v, 'MinRotRecoil', Vector3.new())
                    rawset(v, 'MaxRotRecoil', Vector3.new())
                    rawset(v, 'MinTransRecoil', Vector3.new())
                    rawset(v, 'MaxTransRecoil', Vector3.new())
                    rawset(v, 'ScopeSpeed', 100)
                end
            end
        end
    end,
    Save = true,
    Flag = "other_luffy"
})

-- RenderStepped for TPAll and Other Features
b.RenderStepped:Connect(function()
    -- TPAll Logic
    if getgenv().hypershotlum.tpall.players or getgenv().hypershotlum.tpall.bots then
        local cg = d.Character or d.CharacterAdded:Wait()
        local ch = cg:FindFirstChild("HumanoidRootPart") or cg:WaitForChild("HumanoidRootPart")
        if not ch then return end
        local ci = cg:GetAttribute("Team")
        local cj = Vector2.new(e.ViewportSize.X / 2, e.ViewportSize.Y / 2)
        local ck = e:ViewportPointToRay(cj.X, cj.Y)
        local cl = ck.Origin + ck.Direction * 1000
        local cm = -2

        if getgenv().hypershotlum.tpall.players then
            for _, cn in ipairs(workspace:GetChildren()) do
                if cn:IsA("Model") and cn ~= cg then
                    local co = cn:FindFirstChild("HumanoidRootPart")
                    local cp = cn:FindFirstChild("Head")
                    if co and cp then
                        if getgenv().hypershotlum.tpall.teamcheck then
                            local cq = cn:GetAttribute("Team")
                            if cq and ci and cq ~= ci then
                                local cr = e.CFrame.Position + e.CFrame.LookVector * getgenv().hypershotlum.tpall.offset
                                local cs = Vector3.new(cr.X, cr.Y + cm, cr.Z)
                                co.CFrame = CFrame.new(cs, e.CFrame.Position)
                                cp.CFrame = CFrame.new(cp.Position, cl)
                            end
                        else
                            local cr = e.CFrame.Position + e.CFrame.LookVector * getgenv().hypershotlum.tpall.offset
                            local cs = Vector3.new(cr.X, cr.Y + cm, cr.Z)
                            co.CFrame = CFrame.new(cs, e.CFrame.Position)
                            cp.CFrame = CFrame.new(cp.Position, cl)
                        end
                    end
                end
            end
        end

        if getgenv().hypershotlum.tpall.bots then
            local ct = workspace:FindFirstChild("Mobs")
            if ct then
                for _, cu in ipairs(ct:GetChildren()) do
                    if cu:IsA("Model") then
                        local cv = cu:FindFirstChild("HumanoidRootPart")
                        local cw = cu:FindFirstChild("Head")
                        if cv and cw then
                            if getgenv().hypershotlum.tpall.teamcheck then
                                local cx = cu:GetAttribute("Team")
                                if cx and ci and cx ~= ci then
                                    local cy = e.CFrame.Position + e.CFrame.LookVector * getgenv().hypershotlum.tpall.offset
                                    local cz = Vector3.new(cy.X, cy.Y + cm, cy.Z)
                                    cv.CFrame = CFrame.new(cz, e.CFrame.Position)
                                    cw.CFrame = CFrame.new(cw.Position, cl)
                                end
                            else
                                local cy = e.CFrame.Position + e.CFrame.LookVector * getgenv().hypershotlum.tpall.offset
                                local cz = Vector3.new(cy.X, cy.Y + cm, cy.Z)
                                cv.CFrame = CFrame.new(cz, e.CFrame.Position)
                                cw.CFrame = CFrame.new(cw.Position, cl)
                            end
                        end
                    end
                end
            end
        end

        -- TP Weapons
        if getgenv().hypershotlum.tpall.tpweapons then
            local da = workspace:FindFirstChild("IgnoreThese") and workspace.IgnoreThese:FindFirstChild("Pickups") and workspace.IgnoreThese.Pickups:FindFirstChild("Weapons")
            if da then
                local cf = 1
                for _, dd in ipairs(da:GetChildren()) do
                    if dd:IsA("Model") then
                        local de = dd:FindFirstChild("Center")
                        if de and de:IsA("BasePart") then
                            local df = ch.Position + ch.CFrame.LookVector * 10 + Vector3.new(0, -3, 0)
                            local dg = CFrame.new(df, ch.Position)
                            dd:SetPrimaryPartCFrame(dg)
                        elseif dd and dd:IsA("BasePart") then
                            local df = ch.Position + ch.CFrame.LookVector * 10 + Vector3.new(0, -3, 0)
                            local dg = CFrame.new(df, ch.Position)
                            dd.CFrame = dg
                        end
                        cf = cf + 1
                    end
                end
            end
        end
    end

    -- BigHead Logic
    if getgenv().hypershotlum.bighead.enabled then
        local by = getgenv().hypershotlum.bighead.size
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Head") then
                if v.Head:IsA("BasePart") then
                    v.Head.Size = Vector3.new(by, by, by)
                    v.Head.Transparency = 0
                end
            end
        end
        local dm = workspace:FindFirstChild("Mobs")
        if dm then
            for _, dn in ipairs(dm:GetChildren()) do
                if dn:IsA("Model") then
                    local do = dn:FindFirstChild("Head")
                    if do and do:IsA("BasePart") then
                        do.Size = Vector3.new(by, by, by)
                        do.Transparency = 0
                    end
                end
            end
        end
    end
end)

-- Initialize OrionLib
OrionLib:Init()
