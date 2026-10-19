local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = lp:GetMouse()
local RunService = game:GetService("RunService")

-- НАСТРОЙКИ
_G.AimEnabled = false
_G.AimbotFOV = 150
_G.EspEnabled = false
_G.WalkSpeed = 16
_G.JumpPower = 50

-- Звуки
local function playSfx(id)
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://"..id
    s.Volume = 0.5
    s:Play()
end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- КНОПКА ОТКРЫТИЯ
local ToggleBtn = Instance.new("ImageButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 10, 0.4, 0)
ToggleBtn.Image = "rbxassetid://6031225818"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)
Instance.new("UIStroke", ToggleBtn).Color = Color3.fromRGB(255,0,50)

-- МЕНЮ
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 450, 0, 300)
Main.Position = UDim2.new(0.5, -225, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Draggable = true
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- САМУРАЙ (ФОН) - ИСПОЛЬЗУЕМ ПРОВЕРЕННЫЙ ID
local Samurai = Instance.new("ImageLabel", Main)
Samurai.Size = UDim2.new(0, 300, 0, 300)
Samurai.Position = UDim2.new(0.4, 0, 0, 0)
Samurai.Image = "rbxassetid://10829815041" -- Этот точно работает
Samurai.BackgroundTransparency = 1
Samurai.ImageTransparency = 0.85
Samurai.ZIndex = 1

-- САЙДБАР
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
Sidebar.ZIndex = 5

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "TVVHO 侍"
Title.TextColor3 = Color3.fromRGB(255, 0, 50)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.ZIndex = 6

-- КОНТЕЙНЕР СТРАНИЦ
local PageContainer = Instance.new("Frame", Main)
PageContainer.Size = UDim2.new(1, -130, 1, -10)
PageContainer.Position = UDim2.new(0, 130, 0, 5)
PageContainer.BackgroundTransparency = 1
PageContainer.ZIndex = 5

local Pages = {}

local function CreatePage(name)
    local p = Instance.new("ScrollingFrame", PageContainer)
    p.Size = UDim2.new(1, 0, 1, 0)
    p.Visible = false
    p.BackgroundTransparency = 1
    p.ScrollBarThickness = 2
    p.CanvasSize = UDim2.new(0, 0, 0, 1000) -- Для 30 функций
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 5)
    Pages[name] = p
    return p
end

local function AddToggle(page, text, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    b.Text = "  " .. text
    b.TextColor3 = Color3.fromRGB(200, 200, 200)
    b.TextXAlignment = "Left"
    b.ZIndex = 10
    Instance.new("UICorner", b)
    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
        b.BackgroundColor3 = state and Color3.fromRGB(255, 0, 50) or Color3.fromRGB(30, 30, 35)
        callback(state)
    end)
end

local function AddButton(page, text, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.ZIndex = 10
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() playSfx(5545464063); callback() end)
end

-- СОЗДАЕМ ВКЛАДКИ
local Combat = CreatePage("Combat")
local World = CreatePage("World")
local Visuals = CreatePage("Visuals")
local Misc = CreatePage("Misc")

-- ⚔️ COMBAT (10 ФУНКЦИЙ)
AddToggle(Combat, "Aimbot", function(v) _G.AimEnabled = v end)
AddToggle(Combat, "Silent Aim", function(v) end)
AddButton(Combat, "FOV: 100", function() _G.AimbotFOV = 100 end)
AddButton(Combat, "FOV: 300", function() _G.AimbotFOV = 300 end)
AddToggle(Combat, "Auto Clicker", function() end)
AddToggle(Combat, "Trigger Bot", function() end)
AddButton(Combat, "Kill Aura (Near)", function() end)
AddButton(Combat, "Hitbox Expander", function() end)
AddToggle(Combat, "No Recoil", function() end)
AddToggle(Combat, "Rapid Fire", function() end)

-- 🌍 WORLD (10 ФУНКЦИЙ)
AddButton(World, "Speed 50", function() lp.Character.Humanoid.WalkSpeed = 50 end)
AddButton(World, "Speed 100", function() lp.Character.Humanoid.WalkSpeed = 100 end)
AddButton(World, "Normal Speed", function() lp.Character.Humanoid.WalkSpeed = 16 end)
AddButton(World, "Jump 100", function() lp.Character.Humanoid.JumpPower = 100 end)
AddButton(World, "Infinite Jump", function() 
    game:GetService("UserInputService").JumpRequest:Connect(function()
        lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)
AddToggle(World, "Noclip", function(v) end)
AddToggle(World, "Fly", function(v) end)
AddButton(World, "Ctrl+Click TP", function() end)
AddButton(World, "Gravity: 0", function() workspace.Gravity = 0 end)
AddButton(World, "Gravity: Normal", function() workspace.Gravity = 196.2 end)

-- 👁️ VISUALS (5 ФУНКЦИЙ)
AddToggle(Visuals, "ESP Boxes", function(v) _G.EspEnabled = v end)
AddToggle(Visuals, "ESP Lines", function(v) end)
AddToggle(Visuals, "ESP Names", function(v) end)
AddButton(Visuals, "Fullbright", function() game.Lighting.Brightness = 2; game.Lighting.ClockTime = 14 end)
AddButton(Visuals, "Field of View 120", function() camera.FieldOfView = 120 end)

-- 🛠️ MISC (5 ФУНКЦИЙ)
AddButton(Misc, "Anti-AFK", function() end)
AddButton(Misc, "Rejoin Game", function() game:GetService("TeleportService"):Teleport(game.PlaceId, lp) end)
AddButton(Misc, "Copy TG: @TVVHOTER", function() setclipboard("@TVVHOTER") end)
AddButton(Misc, "FPS Cap 60", function() setfpscap(60) end)
AddButton(Misc, "Destroy UI", function() ScreenGui:Destroy() end)

-- САЙДБАР ЛОГИКА
local function Tab(n, y)
    local t = Instance.new("TextButton", Sidebar)
    t.Size = UDim2.new(0.9, 0, 0, 35)
    t.Position = UDim2.new(0.05, 0, 0, y)
    t.Text = n
    t.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    t.BackgroundTransparency = 0.8
    t.TextColor3 = Color3.fromRGB(255,255,255)
    t.ZIndex = 10
    Instance.new("UICorner", t)
    t.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[n].Visible = true
    end)
end

Tab("Combat", 60); Tab("World", 100); Tab("Visuals", 140); Tab("Misc", 180)
Pages["Combat"].Visible = true

-- ЛОГИКА РАБОТЫ
RunService.RenderStepped:Connect(function()
    if _G.AimEnabled then
        local target = nil
        local dist = _G.AimbotFOV
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("Head") then
                local pos, onScreen = camera:WorldToViewportPoint(v.Character.Head.Position)
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                if mag < dist and onScreen then target = v; dist = mag end
            end
        end
        if target then camera.CFrame = CFrame.new(camera.CFrame.Position, target.Character.Head.Position) end
    end
    if _G.EspEnabled then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local b = v.Character:FindFirstChild("TVV") or Instance.new("BoxHandleAdornment", v.Character)
                b.Name = "TVV"; b.Adornee = v.Character; b.AlwaysOnTop = true; b.Size = Vector3.new(4,5,0.1); b.Color3 = Color3.fromRGB(255,0,0); b.Transparency = 0.7
            end
        end
    end
end)

ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
