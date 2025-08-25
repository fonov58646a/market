-- Complete Key System with Auto-Login and Remember Functionality
-- Place this LocalScript in StarterGui

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Configuration
local CORRECT_KEY = "VORTXKEY_GHIIRRM6PXFF"
local MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/ZyqRulNafVexMipT/Fisch/main/fishh.lua" -- Make sure to set this URL
local DATASTORE_NAME = "VortXKeyStore"

-- Create GUI
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "YoxanXHubKey"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

-- Rainbow Stroke Effect
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = frame

coroutine.wrap(function()
    while frame.Parent do
        local h = tick() % 5 / 5
        stroke.Color = Color3.fromHSV(h, 1, 1)
        task.wait(0.05)
    end
end)()

-- GUI Elements
local title = Instance.new("TextLabel")
title.Text = "VortX Hub| Key System"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame

local input = Instance.new("TextBox")
input.PlaceholderText = "Enter key here"
input.Size = UDim2.new(1, -40, 0, 35)
input.Position = UDim2.new(0, 20, 0, 50)
input.Text = ""
input.TextSize = 14
input.TextColor3 = Color3.new(1, 1, 1)
input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
input.Parent = frame

Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

local status = Instance.new("TextLabel")
status.Text = "Waiting for key..."
status.Size = UDim2.new(1, -40, 0, 20)
status.Position = UDim2.new(0, 20, 1, -25)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.new(0.7, 0.7, 0.7)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = frame

local checkBtn = Instance.new("TextButton")
checkBtn.Text = "CHECK"
checkBtn.Size = UDim2.new(1, -40, 0, 30)
checkBtn.Position = UDim2.new(0, 20, 0, 100)
checkBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
checkBtn.TextColor3 = Color3.new(1, 1, 1)
checkBtn.Font = Enum.Font.GothamBold
checkBtn.TextSize = 14
checkBtn.Parent = frame

Instance.new("UICorner", checkBtn).CornerRadius = UDim.new(0, 6)

-- Create RemoteEvent
local keyManagerEvent = Instance.new("RemoteEvent")
keyManagerEvent.Name = "KeyManagerEvent"
keyManagerEvent.Parent = ReplicatedStorage

-- Server-side script (runs locally but simulates server functionality)
local function simulateServerFunctionality()
    local DataStore = DataStoreService:GetDataStore(DATASTORE_NAME)
    
    return {
        getKey = function(player)
            local userId = tostring(player.UserId)
            return pcall(function()
                return DataStore:GetAsync(userId)
            end)
        end,
        setKey = function(player, key)
            local userId = tostring(player.UserId)
            return pcall(function()
                DataStore:SetAsync(userId, key)
                return true
            end)
        end
    }
end

local serverFunctions = simulateServerFunctionality()

-- Auto-login system
task.spawn(function()
    local savedKey = serverFunctions.getKey(player)
    if savedKey == CORRECT_KEY then
        gui:Destroy()
        loadstring(game:HttpGet(MAIN_SCRIPT_URL))()
    end
end)

-- Key check functionality
checkBtn.MouseButton1Click:Connect(function()
    if input.Text == CORRECT_KEY then
        status.Text = "✅ Key accepted! Loading script..."
        
        -- Save key to datastore
        task.spawn(function()
            if serverFunctions.setKey(player, CORRECT_KEY) then
                print("Key saved successfully")
            else
                print("Failed to save key")
            end
        end)
        
        task.wait(1.5)
        gui:Destroy()
        loadstring(game:HttpGet(MAIN_SCRIPT_URL))()
    else
        status.Text = "❌ Invalid key!"
    end
end)
