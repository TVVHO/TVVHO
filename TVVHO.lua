-- TVVHO HUB: SAMURAI EDITION (ANDROID OPTIMIZED)
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Глобальные настройки
_G.AimEnabled = false
_G.AimbotFOV = 150
_G.EspEnabled = false

-- Функция для звуков
local function playSfx(id)
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://"..id
    s.Volume = 0.5
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "TVVHO_HUB_FINAL"

-- КНОПКА ОТКРЫТИЯ (Красная иконка слева)
local ToggleIcon = Instance.new("ImageButton", ScreenGui)
ToggleIcon.Size = UDim2.new(0, 50, 0, 50)
ToggleIcon.Position = UDim2.new(0, 10, 0.4, 0)
ToggleIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleIcon.Image = "rbxassetid://6031225818"
ToggleIcon.ImageColor3 = Color3.fromRGB(255, 0, 50)
Instance.new("UICorner", ToggleIcon).CornerRadius = UDim.new(1, 0)
local stroke = Instance.new("UIStroke", ToggleIcon)
stroke.Color = Color3.fromRGB(255, 0, 50)
stroke.Thickness = 2

-- ГЛАВНОЕ ОКНО
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 260)
Main.Position = UDim2.new(0.5, -200, 0.5, -130)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.Draggable = true -- Для удобства на Android
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- КАРТИНКА НА ФОНЕ (САМЫЙ НИЖНИЙ СЛОЙ)
local SamuraiBg = Instance.new("ImageLabel", Main)
SamuraiBg.Size = UDim2.new(0, 250, 0, 250)
SamuraiBg.Position = UDim2.new(1, -220, 1, -220)
SamuraiBg.Image = "rbxassetid://14332371995" 
SamuraiBg.BackgroundTransparency = 1
SamuraiBg.ImageTransparency = 0.8
SamuraiBg.ZIndex = 0 -- За кнопками

-- САЙДБАР (ЛЕВОЕ МЕНЮ)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 2

local Title = Instance.new("TextLabel", Sidebar)
Title.Text = "TVVHO\n侍"
Title.Size = UDim2.new(1, 0, 0, 60)
Title.TextColor3 = Color3.fromRGB(255, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.BackgroundTransparency = 1
Title.ZIndex = 3

-- КОНТЕЙНЕР ДЛЯ ФУНКЦИЙ
local PageContainer = Instance.new("Frame", Main)
PageContainer.Size = UDim2.new(1, -120, 1, -10)
PageContainer.Position = UDim2.new(0, 120, 0, 5)
PageContainer.BackgroundTransparency = 1
PageContainer.ZIndex = 2

local Pages = {}

-- ФУНКЦИЯ СОЗДАНИЯ СТРАНИЦЫ
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 0
    Page.CanvasSize = UDim2.new(0, 0, 0, 500)
    Page.ZIndex = 3
    local layout = Instance.new("UIListLayout", Page)
    layout.Padding = UDim.new(0, 6)
    Pages[name] = Page
    return Page
end

-- КНОПКА (ПЕРЕДНИЙ ПЛАН)
local function AddButton(page, text, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamSemibold
    b.ZIndex = 5 -- ПОВЕРХ КАРТИНКИ
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() playSfx(5545464063); callback() end)
end

-- ПЕРЕКЛЮЧАТЕЛЬ (ПЕРЕДНИЙ ПЛАН)
local function AddToggle(page, text, callback)
    local state = false
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    b.Text = "  " .. text
    b.TextXAlignment = "Left"
    b.TextColor3 = Color3.fromRGB(160, 160, 160)
    b.Font = Enum.Font.Gotham
    b.ZIndex = 5
    Instance.new("UICorner", b)
    
    local ind = Instance.new("Frame", b)
    ind.Position = UDim2.new(1, -25, 0.5, -7)
    ind.Size = UDim2.new(0, 14, 0, 14)
    ind.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ind.ZIndex = 6
    Instance.new("UICorner", ind)

    b.MouseButton1Click:Connect(function()
        state = not state
        playSfx(5545464063)
        ind.BackgroundColor3 = state and Color3.fromRGB(255, 0, 50) or Color3.fromRGB(50, 50, 50)
        b.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)
        callback(state)
    end)
end

-- СОЗДАЕМ ВКЛАДКИ
local Combat = CreatePage("Combat")
local Visuals = CreatePage("Visuals")
local Info = CreatePage("Info")

-- COMBAT FUNCTIONS
AddToggle(Combat, "Aimbot Enabled", function(v) _G.AimEnabled = v end)
AddButton(Combat, "Set FOV: 150", function() _G.AimbotFOV = 150 end)

-- VISUALS FUNCTIONS
AddToggle(Visuals, "ESP Boxes", function(v) _G.EspEnabled = v end)

-- INFO FUNCTIONS
AddButton(Info, "Copy TG: @TVVHOTER", function() setclipboard("@TVVHOTER") end)
local Desc = Instance.new("TextLabel", Info)
Desc.Size = UDim2.new(1,0,0,60)
Desc.BackgroundTransparency = 1
Desc.Text = "TVVHO HUB Dynasty\nPremium Mobile Script"
Desc.TextColor3 = Color3.fromRGB(200,200,200)
Desc.ZIndex = 5

-- ПЕРЕКЛЮЧАТЕЛЬ ВКЛАДОК
local function Tab(n, y)
    local t = Instance.new("TextButton", Sidebar)
    t.Size = UDim2.new(0.9, 0, 0, 32)
    t.Position = UDim2.new(0.05, 0, 0, y)
    t.Text = n
    t.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    t.BackgroundTransparency = 0.9
    t.TextColor3 = Color3.fromRGB(230, 230, 230)
    t.ZIndex = 4
    Instance.new("UICorner", t)
    t.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[n].Visible = true
        playSfx(5545464063)
    end)
end

Tab("Combat", 70); Tab("Visuals", 110); Tab("Info", 150)
Pages["Combat"].Visible = true

-- ЛОГИКА АИМА И ESP
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
                local b = v.Character:FindFirstChild("TVV_ESP") or Instance.new("BoxHandleAdornment", v.Character)
                b.Name = "TVV_ESP"; b.Adornee = v.Character; b.AlwaysOnTop = true; b.Size = Vector3.new(4,5,0.2); b.Color3 = Color3.fromRGB(255,0,50); b.Transparency = 0.7
            end
        end
    else
        for _, v in pairs(Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("TVV_ESP") then v.Character.TVV_ESP:Destroy() end
        end
    end
end)

-- СКРЫТЬ/ПОКАЗАТЬ
ToggleIcon.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    playSfx(1548170034)
end)

playSfx(1548170034) -- Звук при запуске
