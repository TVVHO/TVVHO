-- TVVHO HUB PREMIUM | SAMURAI EDITION
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()
local camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Глобальные настройки
_G.AimEnabled = false
_G.AimbotFOV = 120
_G.EspEnabled = false

-- Звук взмаха меча
local function playSfx(id)
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://"..id
    s.Volume = 0.5
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

-- Создаем UI
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "TVVHO_FINAL"

-- КНОПКА ОТКРЫТИЯ (КРАСНЫЙ САМУРАЙ)
local ToggleIcon = Instance.new("ImageButton", ScreenGui)
ToggleIcon.Size = UDim2.new(0, 45, 0, 45)
ToggleIcon.Position = UDim2.new(0, 10, 0.5, -22)
ToggleIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleIcon.Image = "rbxassetid://6031225818"
ToggleIcon.ImageColor3 = Color3.fromRGB(255, 0, 50)
local ic = Instance.new("UICorner", ToggleIcon)
ic.CornerRadius = UDim.new(1, 0)
local is = Instance.new("UIStroke", ToggleIcon)
is.Color = Color3.fromRGB(255, 0, 50)
is.Thickness = 2

-- ГЛАВНОЕ ОКНО
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 280)
Main.Position = UDim2.new(0.5, -210, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
local mc = Instance.new("UICorner", Main)
mc.CornerRadius = UDim.new(0, 12)

-- ФОНОВЫЙ САМУРАЙ (АРТ)
local SamuraiBg = Instance.new("ImageLabel", Main)
SamuraiBg.Size = UDim2.new(0, 250, 0, 250)
SamuraiBg.Position = UDim2.new(1, -220, 1, -220)
SamuraiBg.Image = "rbxassetid://14332371995" -- Новый ID арта самурая
SamuraiBg.BackgroundTransparency = 1
SamuraiBg.ImageTransparency = 0.85
SamuraiBg.ZIndex = 1

-- Сайдбар (Левая часть)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 3

local Title = Instance.new("TextLabel", Sidebar)
Title.Text = "TVVHO\n侍"
Title.Size = UDim2.new(1, 0, 0, 60)
Title.TextColor3 = Color3.fromRGB(255, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.BackgroundTransparency = 1

-- Контейнер страниц (Правая часть)
local PageContainer = Instance.new("Frame", Main)
PageContainer.Size = UDim2.new(1, -120, 1, -10)
PageContainer.Position = UDim2.new(0, 120, 0, 5)
PageContainer.BackgroundTransparency = 1
PageContainer.ZIndex = 3

local Pages = {}

-- Создание страниц
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 0
    Page.CanvasSize = UDim2.new(0, 0, 0, 500)
    local l = Instance.new("UIListLayout", Page)
    l.Padding = UDim.new(0, 8)
    Pages[name] = Page
    return Page
end

-- Кнопка в меню
local function AddButton(page, text, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() playSfx(5545464063); callback() end)
end

-- Переключатель
local function AddToggle(page, text, callback)local state = false
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    b.Text = "  " .. text
    b.TextXAlignment = "Left"
    b.TextColor3 = Color3.fromRGB(150, 150, 150)
    Instance.new("UICorner", b)
    local ind = Instance.new("Frame", b)
    ind.Position = UDim2.new(1, -25, 0.5, -7)
    ind.Size = UDim2.new(0, 14, 0, 14)
    ind.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Instance.new("UICorner", ind)
    b.MouseButton1Click:Connect(function()
        state = not state
        playSfx(5545464063)
        ind.BackgroundColor3 = state and Color3.fromRGB(255, 0, 50) or Color3.fromRGB(50, 50, 50)
        b.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
        callback(state)
    end)
end

-- СОЗДАЕМ ВКЛАДКИ
local Combat = CreatePage("COMBAT")
local Visuals = CreatePage("VISUALS")
local Info = CreatePage("INFO")

-- COMBAT
AddToggle(Combat, "Enable Aimbot", function(v) _G.AimEnabled = v end)
AddButton(Combat, "FOV: 150", function() _G.AimbotFOV = 150 end)

-- VISUALS
AddToggle(Visuals, "ESP Boxes", function(v) _G.EspEnabled = v end)

-- INFO
AddButton(Info, "TG: @TVVHOTER", function() setclipboard("@TVVHOTER") end)

-- Сайдбар кнопки
local function TabBtn(name)
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    b.BackgroundTransparency = 1
    b.TextColor3 = Color3.fromRGB(200, 200, 200)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[name].Visible = true
        playSfx(5545464063)
    end)
end
TabBtn("COMBAT"); TabBtn("VISUALS"); TabBtn("INFO")
Pages["COMBAT"].Visible = true

-- ЛОГИКА АИМА
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
end)

-- ЛОГИКА ESP
RunService.RenderStepped:Connect(function()
    if _G.EspEnabled then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local b = v.Character:FindFirstChild("TVV_ESP") or Instance.new("BoxHandleAdornment", v.Character)
                b.Name = "TVV_ESP"; b.Adornee = v.Character; b.AlwaysOnTop = true; b.Size = Vector3.new(4,5,1); b.Color3 = Color3.fromRGB(255,0,50); b.Transparency = 0.6
            end
        end
    end
end)

-- Свернуть
ToggleIcon.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    playSfx(1548170034)
end)

playSfx(1548170034)
