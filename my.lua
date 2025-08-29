local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 0
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 24}):Play()

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "StellarLoader"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundTransparency = 1

local bg = Instance.new("Frame", frame)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
bg.BackgroundTransparency = 1
bg.ZIndex = 0
TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 0.3}):Play()

local word = "STELLAR"
local letters = {}

local function tweenOutAndDestroy()
	for _, label in ipairs(letters) do
		TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 1, TextSize = 20}):Play()
	end
	TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
	TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0}):Play()
	wait(0.6)
	screenGui:Destroy()
	blur:Destroy()
end

for i = 1, #word do
	local char = word:sub(i, i)

	local label = Instance.new("TextLabel")
	label.Text = char
	label.Font = Enum.Font.GothamBlack
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextStrokeTransparency = 1 
	label.TextTransparency = 1
	label.TextScaled = false
	label.TextSize = 30 
	label.Size = UDim2.new(0, 60, 0, 60)
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.Position = UDim2.new(0.5, (i - (#word / 2 + 0.5)) * 65, 0.5, 0)
	label.BackgroundTransparency = 1
	label.Parent = frame

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 170, 255)), 
		ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 100, 160))   
	})
	gradient.Rotation = 90
	gradient.Parent = label

	local tweenIn = TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 0, TextSize = 60})
	tweenIn:Play()

	table.insert(letters, label)
	wait(0.25)
end

wait(2)

tweenOutAndDestroy()
 local ScreenGui = Instance.new("ScreenGui")
    local AdFrame = Instance.new("Frame")
    local DiscordLabel = Instance.new("TextLabel")
    local CopyButton = Instance.new("TextButton")
    local ExitButton = Instance.new("TextButton")
    local WaitButton = Instance.new("TextButton")
    local UIGradientFrame = Instance.new("UIGradient")
    local UIGradientText = Instance.new("UIGradient")
    
    ScreenGui.Name = "AdsGui"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    
    AdFrame.Name = "AdFrame"
    AdFrame.Parent = ScreenGui
    AdFrame.Size = UDim2.new(0.4, 0, 0.3, 0)
    AdFrame.Position = UDim2.new(0.5, 0, 0.35, 0)
    AdFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    AdFrame.BorderSizePixel = 2
    AdFrame.Draggable = true
    AdFrame.Active = true
    AdFrame.BorderColor3 = Color3.fromRGB(128, 0, 128)

    UIGradientFrame.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 128)) 
    }
    UIGradientFrame.Parent = AdFrame
    
    DiscordLabel.Name = "DiscordLabel"
    DiscordLabel.Parent = AdFrame
    DiscordLabel.Size = UDim2.new(1, 0, 0.6, 0)
    DiscordLabel.BackgroundTransparency = 1
    DiscordLabel.Text = "Stellar Hub"
    DiscordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordLabel.TextSize = 22
    DiscordLabel.TextWrapped = true

    UIGradientText.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 100, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 128))
    }
    UIGradientText.Parent = DiscordLabel
    
    CopyButton.Name = "CopyButton"
    CopyButton.Parent = AdFrame
    CopyButton.Size = UDim2.new(0.4, 0, 0.2, 0)
    CopyButton.Position = UDim2.new(0.1, 0, 0.7, 0)
    CopyButton.Text = "Copy Link Discord"
    CopyButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
    CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    ExitButton.Name = "ExitButton"
    ExitButton.Parent = AdFrame
    ExitButton.Size = UDim2.new(0.4, 0, 0.2, 0)
    ExitButton.Position = UDim2.new(0.5, 0, 0.7, 0)
    ExitButton.Text = "Exit"
    ExitButton.Visible = false
    ExitButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255) 
    
    WaitButton.Name = "WaittoExit"
    WaitButton.Parent = AdFrame
    WaitButton.Size = UDim2.new(0.4, 0, 0.2, 0)
    WaitButton.Position = UDim2.new(0.5, 0, 0.7, 0)
    WaitButton.Text = "Waitting Delay Exit"
    WaitButton.Visible = true
    WaitButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    WaitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    task.delay(5, function()
        WaitButton.Visible = false
        ExitButton.Visible = true
    end)
    
    CopyButton.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("https://discord.gg/FmMuvkaWvG")
            task.wait()
            CopyButton.Text = "Copied To Discord Link"
            task.wait(0.6)
            CopyButton.Text = "Copy Link Discord"
        end
    end)
    
    ExitButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
repeat task.wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/Lib"))()
local FlagsManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/ConfigManager"))()

local GetService, cloneref = game.GetService, cloneref or function(r)return r end
local services = setmetatable({}, {
    __index = function(self, service)
        local r = cloneref(GetService(game, service))
        self[service] = r
        return r
    end
})

local genv = getgenv and getgenv() or shared or _G or {}
local LRM_UserNote = "Owner"
-- local LRM_ScriptVersion = "110"

local function RoleChecker()
    if string.find(LRM_UserNote, "Ad Reward") then
        return "Free Version"
    elseif string.find(LRM_UserNote, "Premium") then
        return "Premium Version"
    elseif string.find(LRM_UserNote, "Owner") then
        return "Developer x2zu"
    else
        return "No Role Assigned"
    end
end

local function formatVersion(version)
    local formattedVersion = "v" .. version:sub(2):gsub(".", "%0.")
    return formattedVersion:sub(1, #formattedVersion - 1)
end

local function interpolate_color(color1, color2, t)
    local r = math.floor((1 - t) * color1[1] + t * color2[1])
    local g = math.floor((1 - t) * color1[2] + t * color2[2])
    local b = math.floor((1 - t) * color1[3] + t * color2[3])
    return string.format("#%02x%02x%02x", r, g, b)
end

local function hex_to_rgb(hex)
    return {
        tonumber(hex:sub(1, 2), 16),
        tonumber(hex:sub(3, 4), 16),
        tonumber(hex:sub(5, 6), 16)
    }
end

local function gradient(word)
    if not word or #word == 0 then return "Error" end

local start_color = hex_to_rgb("ea00ff")
local end_color = hex_to_rgb("5700ff")


    if genv.GradientColor then
        start_color = hex_to_rgb(genv.GradientColor.startingColor)
        end_color = hex_to_rgb(genv.GradientColor.endingColor)
    end

    local gradient_word = ""
    local word_len = #word
    local step = 1.0 / math.max(word_len - 1, 1)

    for i = 1, word_len do
        local t = step * (i - 1)
        local color = interpolate_color(start_color, end_color, t)
        gradient_word = gradient_word .. string.format('<font color="%s">%s</font>', color, word:sub(i, i))
    end

    return gradient_word
end

local main = lib:Load({
    Title = "Hunty Zombie 〢 " .. gradient("discord.gg/x2zu") .. " 〢 " .. RoleChecker(),
    ToggleButton = "rbxassetid://105059922903197",
    BindGui = Enum.KeyCode.RightControl,
})

local tabs = {
    Information = main:AddTab("Information"),
    AutoFarm = main:AddTab("General"),
    Config = main:AddTab("Settings"),
}

main:SelectTab()

local Sections = {
    Welcome = tabs.Information:AddSection({Defualt = true , Locked = true}),
    Discord = tabs.Information:AddSection({Defualt = true , Locked = true}),
    MainFeatures = tabs.AutoFarm:AddSection({Title = gradient("Auto Farm"), Description = "", Defualt = false , Locked = false}),
    EspFeatures = tabs.AutoFarm:AddSection({Title = gradient("ESP"), Description = "", Defualt = false , Locked = false}),
    PlayerMods = tabs.AutoFarm:AddSection({Title = gradient("Character"), Description = "", Defualt = false , Locked = false}),
}

Sections.Discord:AddParagraph({
    Title = '<font color="rgb(255,0,0)">Found a bug?</font>',
    Description = "Please report by joining our Discord."
})

Sections.Discord:AddButton({
    Title = "Copy Discord Invite",
    Callback = function()
        setclipboard("https://discord.gg/FmMuvkaWvG")
        lib:Notification("Discord","Copied invite to clipboard, just paste it.", 5)
    end,
})

genv.WelcomeParagraph = Sections.Welcome:AddParagraph({
    Title = gradient("Loading..."),
    Description = "Please wait..\nIf you've been stuck on this for a long time please join our discord and report it."
})

genv.WelcomeParagraph:SetTitle(gradient("Information"))
genv.WelcomeParagraph:SetDesc([[<font color="rgb(255,255,255)">Welcome to <b>StellarHub</b>!</font>
<font color="rgb(200,200,200)">
Thank you for choosing StellarHub. We're always working on improvements and features.
If you experience issues or have feedback, don't hesitate to join our Discord server.
</font>

<font color="rgb(255,215,0)"><b>Recent Updates:</b></font>
<font color="rgb(210,210,210)">[+] Added Auto Heli</font>
<font color="rgb(210,210,210)">[+] Added Auto Generator</font>
<font color="rgb(210,210,210)">[+] Added Auto Radio</font>
<font color="rgb(210,210,210)">[+] Added Fast Farming Better than other!</font>
<font color="rgb(0,255,200)">
Join the Discord for help, suggestions, and the latest updates.
</font>]])
local player = game.Players.LocalPlayer
local remote = game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable")


_G.AutoSkills_Enabled = false
_G.SelectedSkills = { "Z", "X", "C", "G", "E" } 
local Skills = {
    Z = function()
        local args = { buffer.fromstring("\a\003\001"), {1755858750.110956} }
        remote:FireServer(unpack(args))
    end,
    X = function()
        local args = { buffer.fromstring("\a\005\001"), {1755858758.302091} }
        remote:FireServer(unpack(args))
    end,
    C = function()
        local args = { buffer.fromstring("\a\006\001"), {1755858762.557009} }
        remote:FireServer(unpack(args))
    end,
    G = function()
        local args = { buffer.fromstring("\a\a\001"), {1755858775.553812} }
        remote:FireServer(unpack(args))
    end,
    E = function()
        local args = { buffer.fromstring("\v") }
        remote:FireServer(unpack(args))
    end,
}


task.spawn(function()
    while task.wait(1) do
        if _G.AutoSkills_Enabled then
            for _, key in ipairs(_G.SelectedSkills) do
                if Skills[key] then
                    Skills[key]()
                    task.wait(0.3)
                end
            end
        end
    end
end)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local RepStorage = game:GetService("ReplicatedStorage")
local ByteNetReliable = RepStorage:WaitForChild("ByteNetReliable")
_G.AutoTeleportEntities_Enabled = false
_G.AutoAttack_Enabled = false
_G.AutoCollect_Enabled = false

local function startAutoTeleportEntities()
    task.spawn(function()
        while _G.AutoTeleportEntities_Enabled do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                hrp = player.Character.HumanoidRootPart
                for _, entity in ipairs(workspace.Entities:GetChildren()) do
                    if entity:IsA("Model") and entity:FindFirstChild("HumanoidRootPart") then
                        hrp.CFrame = entity.HumanoidRootPart.CFrame * CFrame.new(0, 2, 3)
                        task.wait(0.1)
                    elseif entity:IsA("BasePart") then
                        hrp.CFrame = entity.CFrame * CFrame.new(0, 2, 3)
                        task.wait(0.1)
                    end
                end
            end
            task.wait()
        end
    end)
end

Sections.MainFeatures:AddToggle("AutoTeleportEntities_Toggle", {
    Title = "Auto Teleport Entities",
    Default = true,
    Callback = function(isEnabled)
        _G.AutoTeleportEntities_Enabled = isEnabled
        if isEnabled then
            startAutoTeleportEntities()
        end
    end,
})
local function startAutoAttack()
    task.spawn(function()
        while _G.AutoAttack_Enabled do
            local args = {
                buffer.fromstring("\a\001\001"),
                { os.clock() }
            }
            ByteNetReliable:FireServer(unpack(args))
            task.wait()
        end
    end)
end

Sections.MainFeatures:AddToggle("AutoAttack_Toggle", {
    Title = "Auto Attack",
    Default = true,
    Callback = function(isEnabled)
        _G.AutoAttack_Enabled = isEnabled
        if isEnabled then
            startAutoAttack()
        end
    end,
})
local function startAutoCollect()
    task.spawn(function()
        while _G.AutoCollect_Enabled do
            if hrp then
                for _, drop in ipairs(workspace.DropItems:GetChildren()) do
                    if drop:IsA("Model") and drop.PrimaryPart then
                        hrp.CFrame = drop.PrimaryPart.CFrame
                    elseif drop:IsA("BasePart") then
                        hrp.CFrame = drop.CFrame
                    end
                end
            end
            task.wait(0.2)
        end
    end)
end

Sections.MainFeatures:AddToggle("AutoCollect_Toggle", {
    Title = "Auto Collect Drops",
    Default = true,
    Callback = function(isEnabled)
        _G.AutoCollect_Enabled = isEnabled
        if isEnabled then
            startAutoCollect()
        end
    end,
})


local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

Sections.MainFeatures:AddToggle("AutoRadio_Toggle", {
    Title = "Auto Radio (World 1)",
    Description = "Active this feature after clear all monster.",
    Default = false,
    Callback = function(isEnabled)
        _G.AutoRadio_Enabled = isEnabled

        if isEnabled then
            task.spawn(function()
                while _G.AutoRadio_Enabled do
                    local hasEntities = false
                    for _, e in ipairs(workspace.Entities:GetChildren()) do
                        if e:IsA("Model") then
                            hasEntities = true
                            break
                        end
                    end
                    local hasDrops = #workspace.DropItems:GetChildren() > 0

                    if not hasEntities and not hasDrops then
                        local radioPart = workspace.School.Rooms.RooftopBoss:FindFirstChild("RadioObjective")
                        if radioPart and radioPart:IsA("BasePart") then
                            local prompt = radioPart:FindFirstChildWhichIsA("ProximityPrompt", true)
                            if prompt then
                                while _G.AutoRadio_Enabled and prompt.Enabled do
                                    hrp.CFrame = radioPart.CFrame
                                    fireproximityprompt(prompt)
                                    task.wait(0.2)
                                end
                            end
                        end
                    end

                    task.wait(0.3)
                end
            end)
        end
    end,
})

Sections.MainFeatures:AddToggle("AutoHeli_Toggle", {
    Title = "Auto Helicopter (World 1)",
    Description = "Active this feature after clear all monster.",
    Default = false,
    Callback = function(isEnabled)
        _G.AutoHeli_Enabled = isEnabled
        if isEnabled then
            task.spawn(function()
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local hrp = character:WaitForChild("HumanoidRootPart")

                while _G.AutoHeli_Enabled do
                    local hasEntities = false
                    for _, e in ipairs(workspace.Entities:GetChildren()) do
                        if e:IsA("Model") then
                            hasEntities = true
                            break
                        end
                    end
                    local hasDrops = #workspace.DropItems:GetChildren() > 0

                    if not hasEntities and not hasDrops then
                        local heliObj = workspace.School.Rooms.RooftopBoss:FindFirstChild("HeliObjective")
                        if heliObj then
                            local prompt = heliObj:FindFirstChildWhichIsA("ProximityPrompt", true)
                            if prompt and prompt.Enabled then
                                hrp.CFrame = heliObj.CFrame + Vector3.new(0, 2, 0)
                                task.wait(0.2)
                                fireproximityprompt(prompt)
                                repeat
                                    task.wait(1)
                                until not _G.AutoHeli_Enabled or not prompt:IsDescendantOf(workspace) or not prompt.Enabled
                            end
                        end
                    end
                end
            end)
        end
    end,
})


Sections.MainFeatures:AddToggle("AutoGen_Toggle", {
    Title = "Auto Generator (World 2)",
    Default = false,
    Callback = function(isEnabled)
        _G.AutoGen_Enabled = isEnabled

        if isEnabled then
            task.spawn(function()
                while _G.AutoGen_Enabled do
                    local hasEntities = false
                    for _, e in ipairs(workspace.Entities:GetChildren()) do
                        if e:IsA("Model") then
                            hasEntities = true
                            break
                        end
                    end
                    local hasDrops = #workspace.DropItems:GetChildren() > 0

                    if not hasEntities and not hasDrops then
                        local generator = workspace.Sewers.Rooms.BossRoom:FindFirstChild("generator")
                        if generator then
                            local gen = generator:FindFirstChild("gen")
                            local pom = gen and gen:FindFirstChild("pom")

                            if gen and pom and pom.Enabled then
                                while _G.AutoGen_Enabled and pom.Enabled do
                                    hrp.CFrame = gen.CFrame
                                    fireproximityprompt(pom)
                                    task.wait(0.2)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end,
})


Sections.MainFeatures:AddToggle("AutoSkills_Toggle", {
    Title = "Auto Use Skills",
    Default = true,
    Callback = function(isEnabled)
        _G.AutoSkills_Enabled = isEnabled
        if isEnabled then
            task.spawn(function()
                while _G.AutoSkills_Enabled do
                    for _, skill in ipairs(_G.SelectedSkills) do
                        if Skills[skill] then
                            pcall(function()
                                Skills[skill]()
                            end)
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    end,
})

Sections.MainFeatures:AddDropdown("SelectSkills_Dropdown", {
    Title = "Select Skills",
    Options = { "Z", "X", "C", "G", "E" },
    Default = { "Z", "X", "C", "G", "E" }, 
    PlaceHolder = "Select Skills",
    Multiple = true,
    Callback = function(selected)
        _G.SelectedSkills = selected
    end,
})

local entitiesFolder = workspace:WaitForChild("Entities")

local espEnabled = false

local function addHighlight(mob)
    if not espEnabled then return end
    if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") then
        if not mob:FindFirstChild("ESPHighlight") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESPHighlight"
            highlight.Adornee = mob
            highlight.FillColor = Color3.fromRGB(255, 0, 0) 
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Parent = mob
        end
    end
end

local function removeAllHighlights()
    for _, mob in ipairs(entitiesFolder:GetChildren()) do
        local esp = mob:FindFirstChild("ESPHighlight")
        if esp then
            esp:Destroy()
        end
    end
end

local function updateESP()
    if espEnabled then
        for _, mob in ipairs(entitiesFolder:GetChildren()) do
            addHighlight(mob)
        end
    else
        removeAllHighlights()
    end
end

Sections.EspFeatures:AddToggle("MobESP", {
    Title = "ESP Zombie",
    Default = false,
    Callback = function(state)
        espEnabled = state
        updateESP()
    end
})

entitiesFolder.ChildAdded:Connect(function(mob)
    task.wait(0.1)
    if espEnabled then
        addHighlight(mob)
    end
end)

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local blockOxygen = false


local LocalPlayer = Players.LocalPlayer
local currentDropdown = nil

local function getPlayerList()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(list, p.DisplayName)
        end
    end
    return list
end

local function teleportToPlayerExact(target)
    local characters = workspace:FindFirstChild("Characters")
    if not characters then return end

    local targetChar = characters:FindFirstChild(target)
    local myChar = characters:FindFirstChild(LocalPlayer.Name)

    if targetChar and myChar then
        local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        if targetHRP and myHRP then
            myHRP.CFrame = targetHRP.CFrame + Vector3.new(2, 0, 0)
        end
    end
end

local function updateDropdown()
    if currentDropdown and currentDropdown.Destroy then
        currentDropdown:Destroy()
    end

    currentDropdown = Sections.PlayerMods:AddDropdown("TeleportPlayerDropdown", {
        Title = "Teleport to Player",
        Description = "Select player to teleport",
        Options = getPlayerList(),
        Default = "",
        PlaceHolder = "Search Player",
        Multiple = false,
        Callback = function(selectedDisplayName)
            for _, p in pairs(Players:GetPlayers()) do
                if p.DisplayName == selectedDisplayName then
                    teleportToPlayerExact(p.Name)
                    lib:Notification("STELLARHUB", "Teleported to " .. p.DisplayName, 3)
                    break
                end
            end
        end
    })
end

Players.PlayerAdded:Connect(function()
    task.delay(0.1, updateDropdown)
end)

Players.PlayerRemoving:Connect(function()
    task.delay(0.1, updateDropdown)
end)

updateDropdown()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ByteNetReliable    = ReplicatedStorage:WaitForChild("ByteNetReliable")

local originalFireServer
local hooked = false
local enabled = false

local function applyHook()
    if hooked then return end
    hooked = true
    originalFireServer = hookfunction(getrawmetatable(ByteNetReliable).__index.FireServer, newcclosure(function(self, ...)
        local args = {...}
        -- damage packets in Hunty Zombies use "\a\001\001" as first arg
        if enabled and typeof(args[1]) == "buffer" then
            local str = buffer.tostring(args[1])
            if str == "\a\001\001" and typeof(args[2]) == "table" and typeof(args[2][1]) == "number" then
                args[2][1] = args[2][1] * 2        -- double the damage value
            end
        end
        return originalFireServer(self, unpack(args))
    end))
end

local function removeHook()
    if hooked and originalFireServer then
        hookfunction(getrawmetatable(ByteNetReliable).__index.FireServer, originalFireServer)
        hooked = false
    end
end

Sections.MainFeatures:AddToggle("DoubleDamage_Toggle", {
    Title = "Double Damage",
    Default = false,
    Callback = function(state)
        enabled = state
        if enabled then
            applyHook()
        else
            removeHook()
        end
    end
})


-- Unlimited Zoom
local defaultMinZoom = LocalPlayer.CameraMinZoomDistance
local defaultMaxZoom = LocalPlayer.CameraMaxZoomDistance

Sections.PlayerMods:AddToggle("UnlimitedZoomToggle", {
    Title = "Unlimited Zoom",
    Default = false,
    Callback = function(state)
        if state then
            LocalPlayer.CameraMinZoomDistance = 0.5
            LocalPlayer.CameraMaxZoomDistance = 9999
        else
            LocalPlayer.CameraMinZoomDistance = defaultMinZoom
            LocalPlayer.CameraMaxZoomDistance = defaultMaxZoom
        end
    end
})

-- Infinity Jump
local ijump = false
Sections.PlayerMods:AddToggle("InfinityJumpToggle", {
    Title = "Infinity Jump",
    Default = false,
    Callback = function(val)
        ijump = val
    end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if ijump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- ==============================
-- FLOATING PLATFORM SCRIPT
-- ==============================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local floatPart
local floatConnection

local function floatingPlat(enabled)
    if enabled then
        if not floatPart then
            floatPart = Instance.new("Part")
            floatPart.Size = Vector3.new(6, 1, 6)
            floatPart.Anchored = true
            floatPart.Transparency = 0.5
            floatPart.BrickColor = BrickColor.new("Really black")
            floatPart.Parent = workspace
        end

        if not floatConnection then
            floatConnection = RunService.RenderStepped:Connect(function()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    floatPart.CFrame = CFrame.new(hrp.Position - Vector3.new(0, 3, 0))
                end
            end)
        end
    else
        if floatConnection then
            floatConnection:Disconnect()
            floatConnection = nil
        end
        if floatPart then
            floatPart:Destroy()
            floatPart = nil
        end
    end
end

-- ==============================
-- UI TOGGLE
-- ==============================
Sections.PlayerMods:AddToggle("EnableFloatToggle", {
    Title = "Enable Float",
    Default = false,
    Description = "Enable floating platform under player",
    Callback = function(enabled)
        floatingPlat(enabled)
    end
})

-- Universal No Clip
local universalNoclip = false
local originalCollisionState = {}

Sections.PlayerMods:AddToggle("UniversalNoClipToggle", {
    Title = "Universal No Clip",
    Default = true,
    Callback = function(val)
        universalNoclip = val
        if val then
            lib:Notification("STELLARHUB", "Universal Noclip Active", 3)
        else
            for part, state in pairs(originalCollisionState) do
                if part and part:IsA("BasePart") then
                    part.CanCollide = state
                end
            end
            originalCollisionState = {}
            lib:Notification("STELLARHUB", "Universal Noclip Disabled", 3)
        end
    end
})

game:GetService("RunService").Stepped:Connect(function()
    if not universalNoclip then return end

    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                originalCollisionState[part] = true
                part.CanCollide = false
            end
        end
    end

    for _, model in ipairs(workspace:GetChildren()) do
        if model:IsA("Model") and model:FindFirstChildWhichIsA("VehicleSeat", true) then
            for _, part in ipairs(model:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    originalCollisionState[part] = true
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Walk Speed Slider
Sections.PlayerMods:AddSlider("WalkSpeedSlider", {
    Title = "Walk Speed",
    Default = 20,
    Min = 16,
    Max = 200,
    Callback = function(val)
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = val end
    end
})

-- Jump Power Slider
Sections.PlayerMods:AddSlider("JumpPowerSlider", {
    Title = "Jump Power",
    Default = 35,
    Min = 50,
    Max = 500,
    Step = 10,
    Callback = function(val)
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.UseJumpPower = true
                hum.JumpPower = val
            end
        end
    end
})

FlagsManager:SetLibrary(lib)
FlagsManager:SetIgnoreIndexes({})
FlagsManager:SetFolder("Stellar/HuntyZombie")
FlagsManager:InitSaveSystem(tabs.Config)
lib:Notification('STELLARHUB', 'We appreciate you using our hub!', 3)
