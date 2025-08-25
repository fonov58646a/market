local correctKey = "VORTXKEY_GHIIRRM6PXFF"
local keyFilePath = "vortx_key.txt" -- Path file untuk menyimpan kunci

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "YoxanXHubKey"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

-- Rainbow stroke
local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
coroutine.wrap(function()
	while frame.Parent do
		local h = tick() % 5 / 5
		stroke.Color = Color3.fromHSV(h, 1, 1)
		task.wait(0.05)
	end
end)()

local title = Instance.new("TextLabel", frame)
title.Text = "VortX Hub| Key System"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local input = Instance.new("TextBox", frame)
input.PlaceholderText = "Enter key here"
input.Size = UDim2.new(1, -40, 0, 35)
input.Position = UDim2.new(0, 20, 0, 50)
input.Text = ""
input.TextSize = 14
input.TextColor3 = Color3.new(1,1,1)
input.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

local status = Instance.new("TextLabel", frame)
status.Text = "Waiting for key..."
status.Size = UDim2.new(1, -40, 0, 20)
status.Position = UDim2.new(0, 20, 1, -25)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.new(0.7,0.7,0.7)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left

local check = Instance.new("TextButton", frame)
check.Text = "CHECK"
check.Size = UDim2.new(1, -40, 0, 30)
check.Position = UDim2.new(0, 20, 0, 100)
check.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
check.TextColor3 = Color3.new(1,1,1)
check.Font = Enum.Font.GothamBold
check.TextSize = 14
Instance.new("UICorner", check).CornerRadius = UDim.new(0, 6)

-- Fungsi untuk menyimpan kunci ke file
local function saveKeyToFile(key)
	local file = io.open(keyFilePath, "w")
	if file then
		file:write(key)
		file:close()
	end
end

-- Fungsi untuk membaca kunci dari file
local function loadKeyFromFile()
	local file = io.open(keyFilePath, "r")
	if file then
		local key = file:read("*a")
		file:close()
		return key
	end
	return nil
end

-- Periksa apakah kunci tersimpan dan valid
local savedKey = loadKeyFromFile()
if savedKey and savedKey == correctKey then
	gui:Destroy()
	loadstring(game:HttpGet(_G.scriptURL))()
else
	-- Tombol check
	check.MouseButton1Click:Connect(function()
		if input.Text == correctKey then
			status.Text = "✅ Key accepted! Loading script..."
			task.wait(1.5)
			gui:Destroy()
			saveKeyToFile(correctKey) -- Simpan kunci jika valid
			loadstring(game:HttpGet(_G.scriptURL))()
		else
			status.Text = "❌ Invalid key!"
		end
	end)
end

-- URL script utama
_G.scriptURL = "https://raw.githubusercontent.com/ZyqRulNafVexMipT/Fisch/main/fishh.lua"
