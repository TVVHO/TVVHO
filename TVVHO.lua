local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = lp:GetMouse()

-- ГЛОБАЛЬНЫЕ НАСТРОЙКИ
_G.AimEnabled = false
_G.AimbotFOV = 100
_G.EspEnabled = false

-- ФУНКЦИЯ ДЛЯ ЗВУКА
local function playSfx(id)
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://"..id
    s.Volume = 0.5
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

-- СОЗДАНИЕ UI
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "TVVHO_SAMURAI"

-- КНОПКА ОТКРЫТИЯ (Иконка)
local ToggleIcon = Instance.new("ImageButton", ScreenGui)
ToggleIcon.Size = UDim2.new(0, 50, 0, 50)
ToggleIcon.Position = UDim2.new(0, 10, 0.5, -25)
ToggleIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleIcon.Image = "rbxassetid://6031225818" -- Иконка самурая
Instance.new("UICorner", ToggleIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", ToggleIcon).Color = Color3.fromRGB(255, 0, 50)

-- ГЛАВНОЕ ОКНО
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 280)
Main.Position = UDim2.new(0.5, -210, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- !!! САМУРАЙ НА ФОНЕ !!!
local SamuraiBg = Instance.new("ImageLabel", Main)
SamuraiBg.Size = UDim2.new(0, 300, 0, 300) -- Большой арт
SamuraiBg.Position = UDim2.new(1, -250, 1, -250)
SamuraiBg.Image = "rbxassetid://12558442953" -- ID арта самурая (можно сменить)
SamuraiBg.BackgroundTransparency = 1
SamuraiBg.ImageTransparency = 0.8 -- Едва заметный, чтобы не мешал тексту
SamuraiBg.ZIndex = 0

-- Сайдбар
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 2

local Title = Instance.new("TextLabel", Sidebar)
Title.Text = "TVVHO\n侍"
Title.Size = UDim2.new(1, 0, 0, 60)
Title.TextColor3 = Color3.fromRGB(255, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

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
    Page.CanvasSize = UDim2.new(0, 0, 0, 600)
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 5)
    Pages[name] = Page
    return Page
end

-- ЭЛЕМЕНТЫ: Кнопка и Переключатель
local function AddButton(page, text, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() playSfx(5545464063); callback() end)
end

local function AddToggle(page, text, callback)
    local state = false
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    b.Text = "  " .. text
    b.TextXAlignment = "Left"
    b.TextColor3 = Color3.fromRGB(150, 150, 150)
    Instance.new("UICorner", b)
    
    local ind= Instance.new("Frame", b)
    ind.Position = UDim2.new(1, -25, 0.5, -7)
    ind.Size = UDim2.new(0, 14, 0, 14)
    ind.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Instance.new("UICorner", ind)

    b.MouseButton1Click:Connect(function()
        state = not state
        playSfx(5545464063)
        b.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
        ind.BackgroundColor3 = state and Color3.fromRGB(255, 0, 50) or Color3.fromRGB(50, 50, 50)
        callback(state)
    end)
end

-- ВКЛАДКИ
local CombatPage = CreatePage("COMBAT")
local VisualPage = CreatePage("VISUALS")
local InfoPage = CreatePage("INFO")

-- COMBAT: AIMBOT
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1; FOVCircle.Color = Color3.fromRGB(255, 0, 50); FOVCircle.Visible = false

AddToggle(CombatPage, "Aimbot Enabled", function(v) _G.AimEnabled = v end)
AddToggle(CombatPage, "Show FOV", function(v) FOVCircle.Visible = v end)
AddButton(CombatPage, "Set FOV: 150", function() _G.AimbotFOV = 150 end)

-- VISUALS: ESP
AddToggle(VisualPage, "ESP Boxes", function(v) _G.EspEnabled = v end)

-- INFO
AddButton(InfoPage, "TG: @TVVHOTER", function() setclipboard("@TVVHOTER") end)

-- КНОПКИ САЙДБАРА
local function Tab(n)
    local t = Instance.new("TextButton", Sidebar)
    t.Size = UDim2.new(0.9, 0, 0, 35)
    t.Text = n
    t.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    t.BackgroundTransparency = 1
    t.TextColor3 = Color3.fromRGB(200, 200, 200)
    Instance.new("UICorner", t)
    t.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[n].Visible = true
        playSfx(5545464063)
    end)
end
Tab("COMBAT"); Tab("VISUALS"); Tab("INFO")
Pages["COMBAT"].Visible = true

-- ЛОГИКА AIMBOT
RunService.RenderStepped:Connect(function()
    FOVCircle.Radius = _G.AimbotFOV
    FOVCircle.Position = Vector2.new(mouse.X, mouse.Y + 36)
    
    if _G.AimEnabled then
        local target = nil
        local dist = _G.AimbotFOV
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                if mag < dist and onScreen then
                    dist = mag
                    target = v
                end
            end
        end
        if target then
            camera.CFrame = CFrame.new(camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

-- ЛОГИКА ESP (BOXES)
RunService.RenderStepped:Connect(function()
    if _G.EspEnabled then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local box = v.Character:FindFirstChild("TVVHO_ESP") or Instance.new("BoxHandleAdornment", v.Character)
                box.Name = "TVVHO_ESP"
                box.Adornee = v.Character
                box.AlwaysOnTop = true
                box.ZIndex = 5
                box.Size = v.Character:GetExtentsSize()
                box.Transparency = 0.5
                box.Color3 = Color3.fromRGB(255, 0, 50)
            end
        end
    else
        for _, v in pairs(Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("TVVHO_ESP") then v.Character.TVVHO_ESP:Destroy() end
        end
    end
end)

-- Свернуть/Развернуть
ToggleIcon.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    playSfx(1548170034)
end)

-- Drag
local d, di, ds, sp
Main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then d = true; ds = i.Position; sp = Main.Position end end)
UserInputService.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.Touch then
    local dt = i.Position - ds
    Main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + dt.X, sp.Y.Scale,sp.Y.Offset + dt.Y)
end end)
UserInputService.InputEnded:Connect(function() d = false end)
