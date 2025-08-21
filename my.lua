
-- Load Orion Library
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua'))()
local Window = OrionLib:MakeWindow({
    Name = 'VortXB Hub - My Market',
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = 'VortXBHub-MyMarket'
})

-- Create Features tab
local FeaturesTab = Window:MakeTab({ Name = 'Features' })

-- Function for ESP toggle
local function ESP_Toggle(value)
    if value then
        print('ESP Enabled')
    else
        print('ESP Disabled')
    end
end

-- Function for Fly toggle
local function Fly_Toggle(value)
    if value then
        print('Fly Enabled')
    else
        print('Fly Disabled')
    end
end

-- Function for NoClip toggle
local function NoClip_Toggle(value)
    if value then
        print('NoClip Enabled')
    else
        print('NoClip Disabled')
    end
end

-- Function for Auto Open toggle
local function AutoOpen_Toggle(value)
    if value then
        print('Auto Open Enabled')
    else
        print('Auto Open Disabled')
    end
end

-- Function for Auto Buy toggle
local function AutoBuy_Toggle(value)
    if value then
        print('Auto Buy Enabled')
    else
        print('Auto Buy Disabled')
    end
end

-- Function for Auto Collect toggle
local function AutoCollect_Toggle(value)
    if value then
        print('Auto Collect Enabled')
    else
        print('Auto Collect Disabled')
    end
end

-- Function for 500x Luck toggle
local function Luck_Toggle(value)
    if value then
        print('500x Luck Enabled')
    else
        print('500x Luck Disabled')
    end
end

-- Function for 500x Money toggle
local function Money_Toggle(value)
    if value then
        print('500x Money Enabled')
    else
        print('500x Money Disabled')
    end
end

-- Function for Infinite Money toggle
local function InfiniteMoney_Toggle(value)
    if value then
        print('Infinite Money Enabled')
    else
        print('Infinite Money Disabled')
    end
end

-- Add toggles to the Features tab
FeaturesTab:AddToggle({ Name = 'ESP', Default = false, Callback = ESP_Toggle })
FeaturesTab:AddToggle({ Name = 'Fly', Default = false, Callback = Fly_Toggle })
FeaturesTab:AddToggle({ Name = 'NoClip', Default = false, Callback = NoClip_Toggle })
FeaturesTab:AddToggle({ Name = 'Auto Open', Default = false, Callback = AutoOpen_Toggle })
FeaturesTab:AddToggle({ Name = 'Auto Buy', Default = false, Callback = AutoBuy_Toggle })
FeaturesTab:AddToggle({ Name = 'Auto Collect', Default = false, Callback = AutoCollect_Toggle })
FeaturesTab:AddToggle({ Name = '500x Luck', Default = false, Callback = Luck_Toggle })
FeaturesTab:AddToggle({ Name = '500x Money', Default = false, Callback = Money_Toggle })
FeaturesTab:AddToggle({ Name = 'Infinite Money', Default = false, Callback = InfiniteMoney_Toggle })

-- Initialize OrionLib
OrionLib:Init()
