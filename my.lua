local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()
local Window = OrionLib:MakeWindow({Name = "Hypershooters", IntroEnabled = true, ConfigFolder = "Hypershooters"})

-- Main configuration for Hypershooters
getgenv().hypershotlum = {
    silentaim = {
        enabled = true,
        teamcheck = true,
        wallcheck = false,
        fov = 200,
        showfov = true,
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
    }
}

-- Fetch necessary services
local a = game:GetService("UserInputService")
local b = game:GetService("RunService")
local c = game:GetService("Players")
local d = c.LocalPlayer
local e = workspace.CurrentCamera
local f = workspace
local g = getgenv().hypershotlum.silentaim

-- Drawing variables for FOV and snapline
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

-- Visibility check function
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

-- Team check function
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

-- World to viewport function
local function y(z)
    local aa, ab = e:WorldToViewportPoint(z)
    return Vector2.new(aa.X, aa.Y), ab
end

-- Health check function
local function ac(ad)
    local ae = ad and ad:FindFirstChildOfClass("Humanoid")
    return ae and ae.Health > 0
end

-- Random hitpart function
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

-- Hitpart selection function
local function al(am)
    if not am then return nil end
    if g.hitpart == "Random" then
        return af(am)
    else
        return am:FindFirstChild(g.hitpart)
    end
end

-- Target selection function
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

-- Touch tap event for toggling functionality
local bc = false
a.TouchTap:Connect(function()
    bc = not bc
end)

-- FOV and snapline updates
local bd = g.fov
local be = 8
b.RenderStepped:Connect(function(bf)
    local bg = f:FindFirstChild("BotRig")
    if bg then
        bg:Destroy()
    end
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
    bd = bd + (bk - bd) * math.clamp(be * bf, 0, 1)
    i.Position = bh
    i.Radius = bd
    j.Position = bh
    j.Radius = bd
    i.Visible = g.showfov and g.enabled
    j.Visible = g.showfov and g.enabled
    local bl = nil
    if h.aimboneenabled then
        bl = an()
    end
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

-- Raycast hook for silent aim
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

-- ESP feature for bighead
local bx = getgenv().hypershotlum.bighead.enabled
local by = getgenv().hypershotlum.bighead.size
local function dh(dl, by)
    local dk = dl:FindFirstChild("Head")
    if dk and dk:IsA("BasePart") then
        dk.Size = Vector3.new(by, by, by)
        dk.Transparency = 0
    end
end

-- Teleport feature
local bz = getgenv().hypershotlum.tpall.players
local ca = getgenv().hypershotlum.tpall.bots
local cb = getgenv().hypershotlum.tpall.teamcheck
local cc = getgenv().hypershotlum.tpall.tpweapons
local cd = getgenv().hypershotlum.tpall.offset
local ce = 10
local cf = 1

b.RenderStepped:Connect(function()
    local cg = d.Character or d.CharacterAdded:Wait()
    local ch = cg:FindFirstChild("HumanoidRootPart") or cg:WaitForChild("HumanoidRootPart")
    if not ch then return end
    local ci = cg:GetAttribute("Team")
    local cj = Vector2.new(e.ViewportSize.X / 2, e.ViewportSize.Y / 2)
    local ck = e:ViewportPointToRay(cj.X, cj.Y)
    local cl = ck.Origin + ck.Direction * 1000
    local cm = -2
    if bz then
        for _, cn in ipairs(f:GetChildren()) do
            if cn:IsA("Model") and cn ~= cg then
                local co = cn:FindFirstChild("HumanoidRootPart")
                local cp = cn:FindFirstChild("Head")
                if co and cp then
                    if cb then
                        local cq = cn:GetAttribute("Team")
                        if cq and ci and cq ~= ci then
                            local cr = e.CFrame.Position + e.CFrame.LookVector * cd
                            local cs = Vector3.new(cr.X, cr.Y + cm, cr.Z)
                            co.CFrame = CFrame.new(cs, e.CFrame.Position)
                            cp.CFrame = CFrame.new(cp.Position, cl)
                        end
                    else
                        local cr = e.CFrame.Position + e.CFrame.LookVector * cd
                        local cs = Vector3.new(cr.X, cr.Y + cm, cr.Z)
                        co.CFrame = CFrame.new(cs, e.CFrame.Position)
                        cp.CFrame = CFrame.new(cp.Position, cl)
                    end
                end
            end
        end
    end

    if ca then
        local ct = f:FindFirstChild("Mobs")
        if ct then
            for _, cu in ipairs(ct:GetChildren()) do
                if cu:IsA("Model") then
                    local cv = cu:FindFirstChild("HumanoidRootPart")
                    local cw = cu:FindFirstChild("Head")
                    if cv and cw then
                        if cb then
                            local cx = cu:GetAttribute("Team")
                            if cx and ci and cx ~= ci then
                                local cy = e.CFrame.Position + e.CFrame.LookVector * cd
                                local cz = Vector3.new(cy.X, cy.Y + cm, cy.Z)
                                cv.CFrame = CFrame.new(cz, e.CFrame.Position)
                                cw.CFrame = CFrame.new(cw.Position, cl)
                            end
                        else
                            local cy = e.CFrame.Position + e.CFrame.LookVector * cd
                            local cz = Vector3.new(cy.X, cy.Y + cm, cy.Z)
                            cv.CFrame = CFrame.new(cz, e.CFrame.Position)
                            cw.CFrame = CFrame.new(cw.Position, cl)
                        end
                    end
                end
            end
        end
    end

    local da = -3
    if cc then
        local db = f:FindFirstChild("IgnoreThese") and f.IgnoreThese:FindFirstChild("Pickups") and f.IgnoreThese.Pickups:FindFirstChild("Weapons")
        if db then
            local dc = db:GetChildren()
            if #dc > 0 then
                if cf > #dc then cf = 1 end
                local dd = dc[cf]
                if dd and dd:IsA("Model") then
                    local de = dd:FindFirstChild("Center")
                    if de and de:IsA("BasePart") then
                        local df = ch.Position + ch.CFrame.LookVector * ce + Vector3.new(0, da, 0)
                        local dg = CFrame.new(df, ch.Position)
                        dd:SetPrimaryPartCFrame(dg)
                    elseif dd and dd:IsA("BasePart") then
                        local df = ch.Position + ch.CFrame.LookVector * ce + Vector3.new(0, da, 0)
                        local dg = CFrame.new(df, ch.Position)
                        dd.CFrame = dg
                    end
                    cf = cf + 1
                end
            else
                cf = 1
            end
        end
    end

    if bx then
        for _, dl in ipairs(f:GetChildren()) do
            if dl:IsA("Model") then
                dh(dl, by)
            end
        end
        local dm = f:FindFirstChild("Mobs")
        if dm then
            for _, dn in ipairs(dm:GetChildren()) do
                if dn:IsA("Model") then
                    dh(dn, by)
                end
            end
        end
    end
end)

-- No cooldown and recoil functions
local og = {}
local recoil = {}

local function nocooldown()
    for _, v in next, getgc(true) do
        if typeof(v) == 'table' and rawget(v, 'CD') then
            if not og[v] then
                og[v] = v.CD
            end
            rawset(v, 'CD', 0)
        end
    end
end

local function luffy()
    for _, v in next, getgc(true) do
        if typeof(v) == 'table' and rawget(v, 'Spread') then
            if not recoil[v] then
                recoil[v] = {
                    Spread = v.Spread,
                    BaseSpread = v.BaseSpread,
                    MinCamRecoil = v.MinCamRecoil or Vector3.new(),
                    MaxCamRecoil = v.MaxCamRecoil or Vector3.new(),
                    MinRotRecoil = v.MinRotRecoil or Vector3.new(),
                    MaxRotRecoil = v.MaxRotRecoil or Vector3.new(),
                    MinTransRecoil = v.MinTransRecoil or Vector3.new(),
                    MaxTransRecoil = v.MaxTransRecoil or Vector3.new(),
                    ScopeSpeed = v.ScopeSpeed
                }
            end

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

nocooldown()
luffy()

-- UI Implementation with OrionLib
local AimbotTab = Window:MakeTab({
    Name = "Aimbot",
    Icon = "rbxassetid://4483345875"
})

AimbotTab:AddToggle({
    Name = "Enable Silent Aim",
    Default = getgenv().hypershotlum.silentaim.enabled,
    Callback = function(Value)
        getgenv().hypershotlum.silentaim.enabled = Value
    end
})

AimbotTab:AddToggle({
    Name = "Dynamic FOV",
    Default = getgenv().hypershotlum.silentaim.dynamicfov,
    Callback = function(Value)
        getgenv().hypershotlum.silentaim.dynamicfov = Value
    end
})

AimbotTab:AddSlider({
    Name = "FOV Size",
    Min = 0,
    Max = 500,
    Default = getgenv().hypershotlum.silentaim.fov,
    Callback = function(Value)
        getgenv().hypershotlum.silentaim.fov = Value
    end
})

AimbotTab:AddSlider({
    Name = "Hit Chance",
    Min = 1,
    Max = 100,
    Default = getgenv().hypershotlum.silentaim.hitchance,
    Callback = function(Value)
        getgenv().hypershotlum.silentaim.hitchance = Value
    end
})

AimbotTab:AddDropdown({
    Name = "Hit Part",
    Options = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso", "LeftArm", "RightArm", "LeftLeg", "RightLeg", "Random"},
    Default = getgenv().hypershotlum.silentaim.hitpart,
    Callback = function(Value)
        getgenv().hypershotlum.silentaim.hitpart = Value
    end
})

AimbotTab:AddToggle({
    Name = "Magic Bullet",
    Default = getgenv().hypershotlum.silentaim.magicbullet,
    Callback = function(Value)
        getgenv().hypershotlum.silentaim.magicbullet = Value
    end
})

local ESPTab = Window:MakeTab({
    Name = "ESP",
    Icon = "rbxassetid://4483345875"
})

ESPTab:AddToggle({
    Name = "Big Head",
    Default = getgenv().hypershotlum.bighead.enabled,
    Callback = function(Value)
        getgenv().hypershotlum.bighead.enabled = Value
    end
})

ESPTab:AddSlider({
    Name = "Head Size",
    Min = 1,
    Max = 10,
    Default = getgenv().hypershotlum.bighead.size,
    Callback = function(Value)
        getgenv().hypershotlum.bighead.size = Value
    end
})

local TeleportTab = Window:MakeTab({
    Name = "Teleport",
    Icon = "rbxassetid://4483345875"
})

TeleportTab:AddToggle({
    Name = "TP Players",
    Default = getgenv().hypershotlum.tpall.players,
    Callback = function(Value)
        getgenv().hypershotlum.tpall.players = Value
    end
})

TeleportTab:AddToggle({
    Name = "TP Bots",
    Default = getgenv().hypershotlum.tpall.bots,
    Callback = function(Value)
        getgenv().hypershotlum.tpall.bots = Value
    end
})

TeleportTab:AddSlider({
    Name = "Offset",
    Min = 0,
    Max = 20,
    Default = getgenv().hypershotlum.tpall.offset,
    Callback = function(Value)
        getgenv().hypershotlum.tpall.offset = Value
    end
})

local RecoilTab = Window:MakeTab({
    Name = "Recoil",
    Icon = "rbxassetid://4483345875"
})

RecoilTab:AddButton({
    Name = "No Cooldown",
    Callback = function()
        nocooldown()
    end
})

RecoilTab:AddButton({
    Name = "No Recoil",
    Callback = function()
        luffy()
    end
})

-- Keep the UI running
OrionLib:Init()
