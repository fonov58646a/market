--[[
    ----------------------------------------------------------
    VortX Hub V1.5.0  –  HyperShot Gunfight Edition
    ----------------------------------------------------------
]]

--[[  1.  Libs & Helpers  ]]
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Remotes = ReplicatedStorage:WaitForChild("Network"):WaitForChild("Remotes")
local IgnoreThese = Workspace:WaitForChild("IgnoreThese")
local Pickups = IgnoreThese:WaitForChild("Pickups")

local ConfigFolder = "VortXConfigs"
if not isfolder(ConfigFolder) then makefolder(ConfigFolder) end
local ConfigFile = ConfigFolder .. "/Hypershot_" .. game.PlaceId .. ".json"

--  2.  Save / Load
local Settings = {
    Aimbot = {
        Enabled = false,
        FOV = 120,
        Smooth = 0.15,
        VisibleCheck = true,
        HitPart = "Head"
    },
    Visuals = {
        SkeletonESP = false
    },
    Farming = {
        AutoSpawn = false,
        AutoChest = false,
        ChestType = "Diamond",
        AutoSpin = false,
        AutoPlaytime = false,
        AutoHeal = false,
        AutoCoin = false,
        AutoWeapon = false
    },
    Combat = {
        RapidFire = false,
        NoRecoil = false,
        InfAmmo = false,
        NoAbilityCD = false,
        InfProjectileSpeed = false
    },
    Misc = {
        HeadLock = false,
        AntiCheatBypass = false
    }
}

local function Save()
    writefile(ConfigFile, game:GetService("HttpService"):JSONEncode(Settings))
end
local function Load()
    if isfile(ConfigFile) then
        local ok, data = pcall(function() return game:GetService("HttpService"):JSONDecode(readfile(ConfigFile)) end)
        if ok then
            for k, v in pairs(data) do
                Settings[k] = v
            end
        end
    end
end
Load()

--  3.  Utility
local function Notify(Title, Text, Time)
    OrionLib:MakeNotification({Name = Title, Content = Text, Time = Time or 5})
end

local ESPDrawings = {}

local function CreateSkeletonESP(character)
    local drawings = {}
    local parts = {
        character:FindFirstChild("Head"),
        character:FindFirstChild("HumanoidRootPart"),
        character:FindFirstChild("UpperTorso"),
        character:FindFirstChild("LowerTorso"),
        character:FindFirstChild("LeftArm"),
        character:FindFirstChild("RightArm"),
        character:FindFirstChild("LeftLeg"),
        character:FindFirstChild("RightLeg")
    }
    
    for i = 1, #parts do
        if parts[i] then
            for j = i + 1, #parts do
                if parts[j] then
                    local line = Drawing.new("Line")
                    line.Color = Color3.fromRGB(255, 0, 0)
                    line.Thickness = 2
                    line.Transparency = 1
                    line.Visible = Settings.Visuals.SkeletonESP
                    table.insert(drawings, line)
                end
            end
        end
    end
    
    return drawings
end

local function UpdateSkeletonESP()
    for _, drawing in ipairs(ESPDrawings) do
        drawing.Visible = false
    end
    
    ESPDrawings = {}
    
    if not Settings.Visuals.SkeletonESP then return end
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local drawings = CreateSkeletonESP(plr.Character)
            for _, line in ipairs(drawings) do
                table.insert(ESPDrawings, line)
            end
        end
    end
    
    -- Update for mobs
    local mobs = Workspace:FindFirstChild("Mobs")
    if mobs then
        for _, mob in ipairs(mobs:GetChildren()) do
            if mob:FindFirstChild("Head") then
                local drawings = CreateSkeletonESP(mob)
                for _, line in ipairs(drawings) do
                    table.insert(ESPDrawings, line)
                end
            end
        end
    end
end

RunService.Heartbeat:Connect(function()
    if Settings.Visuals.SkeletonESP then
        UpdateSkeletonESP()
    end
end)

--  4.  UI
local Window = OrionLib:MakeWindow({
    Name = "VortX Hub V1.5.0 – HyperShot",
    ConfigFolder = ConfigFolder,
    SaveConfig = true,
    HidePremium = true
})

local Tabs = {
    Main = Window:MakeTab({Name = "Combat", Icon = "rbxassetid://4483345998"}),
    Visuals = Window:MakeTab({Name = "Visuals", Icon = "rbxassetid://4483345998"}),
    Farming = Window:MakeTab({Name = "Farming", Icon = "rbxassetid://4483345998"}),
    Settings = Window:MakeTab({Name = "Settings", Icon = "rbxassetid://4483345998"})
}

-- Combat
local AimSec = Tabs.Main:AddSection({Name = "Aimbot"})
AimSec:AddToggle({Name = "Enable Aimbot", Default = Settings.Aimbot.Enabled, Callback = function(v)
    Settings.Aimbot.Enabled = v
    g.enabled = v
    Save()
end})
AimSec:AddSlider({Name = "FOV", Min = 20, Max = 500, Default = Settings.Aimbot.FOV, Callback = function(v) Settings.Aimbot.FOV = v; Save() end})

local CombatSec = Tabs.Main:AddSection({Name = "Combat Mods"})
CombatSec:AddToggle({Name = "Rapid Fire + No Recoil", Default = Settings.Combat.RapidFire, Callback = function(v)
    Settings.Combat.RapidFire = v
    if v then PatchTables() end
    Save()
end})
CombatSec:AddToggle({Name = "Infinite Ammo", Default = Settings.Combat.InfAmmo, Callback = function(v) Settings.Combat.InfAmmo = v; Save(); PatchTables() end})
CombatSec:AddToggle({Name = "No Ability Cooldown", Default = Settings.Combat.NoAbilityCD, Callback = function(v) Settings.Combat.NoAbilityCD = v; Save(); PatchTables() end})
CombatSec:AddToggle({Name = "Inf Projectile Speed", Default = Settings.Combat.InfProjectileSpeed, Callback = function(v) Settings.Combat.InfProjectileSpeed = v; Save(); PatchTables() end})
CombatSec:AddToggle({Name = "Bring All / Head-Lock", Default = Settings.Misc.HeadLock, Callback = function(v)
    Settings.Misc.HeadLock = v
    if v then StartHeadLock() else StopHeadLock() end
    Save()
end})

-- Visuals
local VisSec = Tabs.Visuals:AddSection({Name = "ESP"})
VisSec:AddToggle({Name = "Skeleton ESP", Default = Settings.Visuals.SkeletonESP, Callback = function(v)
    Settings.Visuals.SkeletonESP = v
    Save()
end})

-- Farming
local FarmSec = Tabs.Farming:AddSection({Name = "Auto Farm"})
FarmSec:AddToggle({Name = "Auto Spawn", Default = Settings.Farming.AutoSpawn, Callback = function(v)
    Settings.Farming.AutoSpawn = v
    if v then StartFarm("AutoSpawn", SpawnLoop) else StopFarm("AutoSpawn") end
    Save()
end})
FarmSec:AddToggle({Name = "Auto Open Chest", Default = Settings.Farming.AutoChest, Callback = function(v)
    Settings.Farming.AutoChest = v
    if v then StartFarm("AutoChest", ChestLoop) else StopFarm("AutoChest") end
    Save()
end})
FarmSec:AddDropdown({Name = "Chest Type", Options = {"Wooden","Bronze","Silver","Gold","Diamond"}, Default = Settings.Farming.ChestType, Callback = function(v) Settings.Farming.ChestType = v; Save() end})
FarmSec:AddToggle({Name = "Auto Spin Wheel", Default = Settings.Farming.AutoSpin, Callback = function(v) Settings.Farming.AutoSpin = v; if v then StartFarm("AutoSpin", SpinLoop) else StopFarm("AutoSpin") end; Save() end})
FarmSec:AddToggle({Name = "Auto Playtime Award", Default = Settings.Farming.AutoPlaytime, Callback = function(v) Settings.Farming.AutoPlaytime = v; if v then StartFarm("AutoPlaytime", PlaytimeLoop) else StopFarm("AutoPlaytime") end; Save() end})
FarmSec:AddToggle({Name = "Auto Pickup Heal", Default = Settings.Farming.AutoHeal, Callback = function(v)
    Settings.Farming.AutoHeal = v
    if v then StartFarm("AutoHeal", PickupLoop("Heals", "PickUpHeal")) else StopFarm("AutoHeal") end
    Save()
end})
FarmSec:AddToggle({Name = "Auto Pickup Coin", Default = Settings.Farming.AutoCoin, Callback = function(v)
    Settings.Farming.AutoCoin = v
    if v then StartFarm("AutoCoin", PickupLoop("Coins", "PickUpCoins")) else StopFarm("AutoCoin") end
    Save()
end})
FarmSec:AddToggle({Name = "Auto Pickup Weapon", Default = Settings.Farming.AutoWeapon, Callback = function(v)
    Settings.Farming.AutoWeapon = v
    if v then StartFarm("AutoWeapon", PickupLoop("Weapons", "PickUpWeapons")) else StopFarm("AutoWeapon") end
    Save()
end})

-- Settings
Tabs.Settings:AddButton({Name = "Unload Script", Callback = function()
    OrionLib:Destroy()
    for k in pairs(FarmingLoops) do StopFarm(k) end
    ClearESP()
    StopAimbot()
    StopHeadLock()
    Notify("VortX Hub", "Unloaded safely.", 3)
end})

--  5.  Aimbot + Prediction
local AimbotConn, Target = nil, nil
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
local bx = getgenv().hypershotlum.bighead.enabled
local by = getgenv().hypershotlum.bighead.size
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
        local function dh(di, dj)
            local dk = di:FindFirstChild("Head")
            if dk and dk:IsA("BasePart") then
                dk.Size = Vector3.new(dj, dj, dj)
                dk.Transparency = 0
            end
        end
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

--  7.  Combat Mods
local function PatchTables()
    for _, v in next, getgc(true) do
        if type(v) == "table" then
            -- RapidFire / Anti-Recoil
            if rawget(v, "Spread") then
                v.Spread = 0
                v.BaseSpread = 0
                v.MinCamRecoil = Vector3.new()
                v.MaxCamRecoil = Vector3.new()
                v.MinRotRecoil = Vector3.new()
                v.MaxRotRecoil = Vector3.new()
                v.ScopeSpeed = 100
            end
            -- Infinite Ammo
            if rawget(v, "Ammo") and Settings.Combat.InfAmmo then
                v.Ammo = math.huge
            end
            -- Ability No Cooldown
            if rawget(v, "CD") and Settings.Combat.NoAbilityCD then
                v.CD = 0
            end
            -- Projectile Speed
            if (rawget(v, "Speed") or rawget(v, "ProjectileSpeed")) and Settings.Combat.InfProjectileSpeed then
                v.Speed = 9e99
            end
        end
    end
end

--  8.  Farming Loops
local FarmingLoops = {}
local function StartFarm(name, func) FarmingLoops[name] = true; while FarmingLoops[name] do func() wait() end end
local function StopFarm(name) FarmingLoops[name] = false end

SpawnLoop = function()
    while FarmingLoops.AutoSpawn do
        Remotes.Spawn:FireServer(false)
        wait(1.5)
    end
end
ChestLoop = function()
    while FarmingLoops.AutoChest do
        Remotes.OpenCase:InvokeServer(Settings.Farming.ChestType, "Random")
        wait(6)
    end
end
SpinLoop = function()
    while FarmingLoops.AutoSpin do
        Remotes.SpinWheel:InvokeServer()
        wait(5)
    end
end
PlaytimeLoop = function()
    while FarmingLoops.AutoPlaytime do
        for i = 1, 12 do
            Remotes.ClaimPlaytimeReward:FireServer(i)
            wait(1)
        end
        wait(15)
    end
end
PickupLoop = function(folderName, remoteName)
    return function()
        while FarmingLoops[remoteName] do
            local folder = Pickups:FindFirstChild(folderName)
            if folder then
                for _, obj in ipairs(folder:GetChildren()) do
                    Remotes[remoteName]:FireServer(obj)
                end
            end
            wait(0.3)
        end
    end
end

--  9.  Head-Lock / Bring All
local HeadLockConn
local function StartHeadLock()
    HeadLockConn = RunService.RenderStepped:Connect(function()
        if not Settings.Misc.HeadLock then return end
        local cam = Workspace.CurrentCamera
        for _, enemy in ipairs(GetEnemies()) do
            enemy.Head.CFrame = cam.CFrame + cam.CFrame.LookVector * 5
        end
    end)
end
local function StopHeadLock()
    if HeadLockConn then HeadLockConn:Disconnect(); HeadLockConn = nil end
end

-- Init
OrionLib:Init()
Notify("VortX Hub V1.5.0", "Loaded successfully! Enjoy the game.", 5)

-- Auto-run patches on load
PatchTables()
