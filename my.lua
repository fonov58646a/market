-- ServiÃ§os
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- RedzMagnus V5
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/wx-sources/Redzmagnusv5/refs/heads/main/RedzV5.Lua.txt"))()

-- Cria a janela
local Window = redzlib:MakeWindow({
Title = "ðŸŒŒ Nytherune Hub + ðŸŒŒ - Spydersammy's game Script 2025",
SubTitle = "by Nytherune Developers",
SaveFolder = "base_manager"
})

-- Tabs
local TabInfo = Window:MakeTab({Title = "Info", Icon = "info"})
local TabBases = Window:MakeTab({Title = "Scripts das bases", Icon = "cherry"})
local TabItens = Window:MakeTab({Title = "Itens do jogo", Icon = "star"}) -- Nova tabela


TabInfo:AddParagraph({"Script de Steal a brainrot se divirta!"})
local executor = identifyexecutor()
TabInfo:AddParagraph({"Seu executor atual Ã© o " .. executor})

-- SeÃ§Ã£o Scripts
TabBases:AddSection("Scripts")

-- Coordenadas das bases
local Bases = {
["Selecionar base 1"] = Vector3.new(-331, -4, -99),
["Selecionar base 2"] = Vector3.new(-485, -4, 221),
["Selecionar base 3"] = Vector3.new(-332, -4, 222),
["Selecionar base 4"] = Vector3.new(-492, -4, 6),
["Selecionar base 5"] = Vector3.new(-493, -4, -99),
["Selecionar base 6"] = Vector3.new(-328, -4, -101),
["Selecionar base 7"] = Vector3.new(-328, -4, 113),
["Selecionar base 8"] = Vector3.new(-489, -4, 113)
}

-- VariÃ¡veis
local selectedBase = nil
local loopTeleport = false
local loopTeleportDetected = false
local userBase = nil
local buttonsCreated = false
local cameraLoop = false
local rotationAngle = 0
local rotationSpeed = math.rad(30) -- 30Â° por segundo

-- FunÃ§Ã£o TweenTeleport
local function TweenTeleport(position)
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
local HRP = LocalPlayer.Character.HumanoidRootPart
local tweenSpeed = (position == userBase) and 0.5 or 2
local tween = TweenService:Create(HRP, TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(position)})
tween:Play()
end
end

-- FunÃ§Ã£o DetectClosestBase
local function DetectClosestBase()
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
local HRP = LocalPlayer.Character.HumanoidRootPart
local closestDistance = math.huge
local closestBase = nil
for name, pos in pairs(Bases) do
local dist = (HRP.Position - pos).Magnitude
if dist < closestDistance then
closestDistance = dist
closestBase = pos
end
end
return closestBase
end
end

-- FunÃ§Ã£o ShowNotification
local function ShowNotification(text)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")  
Frame.Parent = ScreenGui  
Frame.Size = UDim2.new(0.4,0,0.08,0)  
Frame.Position = UDim2.new(0.3,0,0.1,0)  
Frame.BackgroundTransparency = 0.5  
Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)  
Frame.BorderSizePixel = 2  

local UIStroke = Instance.new("UIStroke")  
UIStroke.Parent = Frame  
UIStroke.Color = Color3.new(0,0,0)  
UIStroke.Thickness = 2  

local Label = Instance.new("TextLabel")  
Label.Parent = Frame  
Label.Size = UDim2.new(1,0,1,0)  
Label.BackgroundTransparency = 1  
Label.Text = text  
Label.TextColor3 = Color3.new(1,1,1)  
Label.TextScaled = true  
Label.Font = Enum.Font.BuilderSansBold  

task.wait(2)  
ScreenGui:Destroy()

end

-- AtualizaÃ§Ã£o da cÃ¢mera com giro automÃ¡tico
RunService.RenderStepped:Connect(function(deltaTime)
if cameraLoop and selectedBase then
rotationAngle = rotationAngle + rotationSpeed * deltaTime
local offset = Vector3.new(0, 10, 20)
local rotatedOffset = CFrame.Angles(0, rotationAngle, 0) * CFrame.new(offset)
Camera.CameraType = Enum.CameraType.Scriptable
Camera.CFrame = CFrame.new(selectedBase + rotatedOffset.Position, selectedBase)
end
end)

-- Dropdown para selecionar base
TabBases:AddDropdown({
Name = "Selecionar Base",
Options = {"Selecionar base 1", "Selecionar base 2", "Selecionar base 3", "Selecionar base 4", "Selecionar base 5", "Selecionar base 6", "Selecionar base 7", "Selecionar base 8"},
Callback = function(Value)
selectedBase = Bases[Value]
end
})

-- Toggle para ver base
TabBases:AddToggle({
Name = "Ver base selecionada",
Default = false,
Callback = function(Value)
cameraLoop = Value
if not Value then
Camera.CameraType = Enum.CameraType.Custom
end
end
})

-- BotÃ£o Teleportar pra base
TabBases:AddButton({
Name = "Teleportar pra base",
Callback = function()
if selectedBase then
TweenTeleport(selectedBase)
end
end
})

-- Toggle Teleportar em Loop
TabBases:AddToggle({
Name = "Teleportar em Loop pra base",
Default = false,
Callback = function(Value)
loopTeleport = Value
task.spawn(function()
while loopTeleport do
if selectedBase then
TweenTeleport(selectedBase)
end
task.wait(3)
end
end)
end
})

-- SeÃ§Ã£o Brainrots
TabBases:AddSection("Scripts brainrots")

TabBases:AddButton({
Name = "Colocar brainrot na mÃ¡quina de mistura",
Callback = function()
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
local hs = LocalPlayer.Character.Humanoid.WalkSpeed
if hs > 22 then
ShowNotification("VocÃª precisa pegar um brainrot da sua base!")
else
local Humanoid = LocalPlayer.Character.Humanoid
local targetPos = Vector3.new(-390, -6, 77)
Humanoid:MoveTo(targetPos)
Humanoid.MoveToFinished:Wait()
end
end
end
})

-- SeÃ§Ã£o "Sua base"
TabBases:AddSection("Sua base")

TabBases:AddButton({
Name = "Detectar sua base",
Callback = function()
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid.Health = 0
LocalPlayer.CharacterAdded:Wait()
task.wait(1)
userBase = DetectClosestBase()

if userBase and not buttonsCreated then  
            buttonsCreated = true  
            TabBases:AddButton({  
                Name = "Teleportar pra sua base",  
                Callback = function()  
                    TweenTeleport(userBase)  
                end  
            })  

            TabBases:AddToggle({  
                Name = "Teleportar Loops pra sua base",  
                Default = false,  
                Callback = function(Value)  
                    loopTeleportDetected = Value  
                    task.spawn(function()  
                        while loopTeleportDetected do  
                            TweenTeleport(userBase)  
                            task.wait(3)  
                        end  
                    end)  
                end  
            })  
        end  
    end  
end

})

-- ===== Nova Tabela: Itens do jogo =====
TabItens:AddSection("Auto click")

-- VariÃ¡veis Auto Click
local autoClickEnabled = false

-- Toggle Auto hit jogadores
TabItens:AddToggle({
Name = "Auto hit jogadores",
Default = false,
Callback = function(Value)
autoClickEnabled = Value
end
})

-- FunÃ§Ã£o que realiza cliques automÃ¡ticos
task.spawn(function()
while true do
if autoClickEnabled then
local VirtualUser = game:GetService("VirtualUser")
VirtualUser:ClickButton1(Vector2.new(0,0))
wait(0.25)
VirtualUser:ClickButton1(Vector2.new(0,0))
wait(0.25)
else
wait(0.1)
end
end
end)

-- ===== Nova SeÃ§Ã£o: Dupe tools =====
TabItens:AddSection("Dupe tools")

TabItens:AddButton({
Name = "Dupar todas as tools do jogo",
Callback = function()
local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local playerGui = player:WaitForChild("PlayerGui")

-- FunÃ§Ã£o para efeito visual temporÃ¡rio  
    local function showDupingEffect()  
        local blur = Instance.new("BlurEffect")  
        blur.Size = 10  
        blur.Parent = game.Lighting  

        local screenGui = Instance.new("ScreenGui")  
        screenGui.ResetOnSpawn = false  
        screenGui.Parent = playerGui  

        local textLabel = Instance.new("TextLabel")  
        textLabel.Size = UDim2.new(1, 0, 1, 0)  
        textLabel.BackgroundTransparency = 1  
        textLabel.Text = "Dupando tools..."  
        textLabel.Font = Enum.Font.BuilderSansBold  
        textLabel.TextScaled = true  
        textLabel.TextColor3 = Color3.new(1, 1, 1)  
        textLabel.Parent = screenGui  

        task.wait(1)  

        blur:Destroy()  
        screenGui:Destroy()  
    end  

    -- FunÃ§Ã£o para coletar todas as tools  
    local function collectAllTools()  
        showDupingEffect()  
        for _, tool in pairs(game:GetDescendants()) do  
            if tool:IsA("Tool") then  
                local clonedTool = tool:Clone()  
                clonedTool.Parent = backpack  
            end  
        end  
    end  

    -- Executa a duplicaÃ§Ã£o  
    collectAllTools()  
end

})
