local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- Функция для звука
local function playSfx(id)
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://"..id
    s.Volume = 0.5
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

-- ==========================================
-- ИНТРО С НЕОНОМ
-- ==========================================
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
IntroFrame.ZIndex = 100

local IntroText = Instance.new("TextLabel", IntroFrame)
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.BackgroundTransparency = 1
IntroText.Text = "TVVHO DYNASTY"
IntroText.TextColor3 = Color3.fromRGB(255, 0, 50)
IntroText.Font = Enum.Font.GothamBold
IntroText.TextSize = 2
IntroText.TextTransparency = 1
IntroText.ZIndex = 101

-- Неоновая тень под текстом интро
local TextGlow = Instance.new("TextLabel", IntroFrame)
TextGlow.Size = IntroText.Size
TextGlow.BackgroundTransparency = 1
TextGlow.Text = IntroText.Text
TextGlow.TextColor3 = Color3.fromRGB(255, 0, 50)
TextGlow.Font = IntroText.Font
TextGlow.TextSize = IntroText.TextSize
TextGlow.TextTransparency = 1
TextGlow.ZIndex = 100

local function StartIntro()
    task.wait(0.5)
    playSfx(1548170034)
    TweenService:Create(IntroText, TweenInfo.new(1), {TextSize = 45, TextTransparency = 0}):Play()
    -- Эффект неоновой вспышки
    task.wait(0.2)
    TweenService:Create(TextGlow, TweenInfo.new(1), {TextSize = 60, TextTransparency = 0.5}):Play()
    task.wait(1.5)
    TweenService:Create(IntroFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    TweenService:Create(IntroText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(TextGlow, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    task.wait(1)
    IntroFrame:Destroy()
end

-- ==========================================
-- ГЛАВНОЕ МЕНЮ С НЕОНОВЫМ СВЕЧЕНИЕМ
-- ==========================================
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 280)
Main.Position = UDim2.new(0.5, -210, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Draggable = true
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- НЕОНОВАЯ ОБВОДКА (Glow)
local MainGlow = Instance.new("ImageLabel", ScreenGui)
MainGlow.Name = "MainGlow"
MainGlow.BackgroundTransparency = 1
MainGlow.Image = "rbxassetid://1316045217" -- Текстура мягкого свечения
MainGlow.ImageColor3 = Color3.fromRGB(255, 0, 50)
MainGlow.ImageTransparency = 0.4
MainGlow.ZIndex = Main.ZIndex - 1
MainGlow.Visible = false

-- Синхронизация свечения с окном
RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function()
    MainGlow.Position = UDim2.new(Main.Position.X.Scale, Main.Position.X.Offset - 25, Main.Position.Y.Scale, Main.Position.Y.Offset - 25)
    MainGlow.Size = UDim2.new(0, Main.Size.X.Offset + 50, 0, Main.Size.Y.Offset + 50)
end)

-- Пульсация неона
task.spawn(function()
    while true do
        TweenService:Create(MainGlow, TweenInfo.new(1.5), {ImageTransparency = 0.7}):Play()
        task.wait(1.5)
        TweenService:Create(MainGlow, TweenInfo.new(1.5), {ImageTransparency = 0.3}):Play()
        task.wait(1.5)
    end
end)

-- Сайдбар
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15,17)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local NeonLine = Instance.new("Frame", Sidebar)
NeonLine.Size = UDim2.new(0, 2, 0.8, 0)
NeonLine.Position = UDim2.new(1, 0, 0.1, 0)
NeonLine.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
NeonLine.BorderSizePixel = 0
-- Добавляем неон на линию
local LineGlow = Instance.new("Frame", NeonLine)
LineGlow.Size = UDim2.new(4, 0, 1, 0)
LineGlow.Position = UDim2.new(-1.5, 0, 0, 0)
LineGlow.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
LineGlow.BackgroundTransparency = 0.5
Instance.new("UICorner", LineGlow).CornerRadius = UDim.new(1, 0)

-- [Функции AddButton и AddToggle теперь будут иметь неоновый эффект при наведении/включении]

local function AddButton(page, text, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    Instance.new("UICorner", b)
    
    -- Неоновый контур кнопки
    local stroke = Instance.new("UIStroke", b)
    stroke.Color = Color3.fromRGB(255, 0, 50)
    stroke.Transparency = 1
    stroke.Thickness = 1.5

    b.MouseButton1Click:Connect(function()
        playSfx(5545464063)
        stroke.Transparency = 0
        TweenService:Create(stroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
        callback()
    end)
end

-- Переключение вкладок
local PageContainer = Instance.new("Frame", Main)
PageContainer.Size = UDim2.new(1, -120, 1, -10)
PageContainer.Position = UDim2.new(0, 120, 0, 5)
PageContainer.BackgroundTransparency = 1

local Pages = {}
local function CreatePage(name)
    local p = Instance.new("ScrollingFrame", PageContainer)
    p.Size = UDim2.new(1, 0, 1, 0)
    p.Visible = false
    p.BackgroundTransparency = 1
    p.CanvasSize = UDim2.new(0, 0, 0, 800)
    p.ScrollBarThickness = 0
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 8)
    Pages[name] = p
    return p
end

local Combat = CreatePage("Combat")
local World = CreatePage("World")

-- Пример функций
AddButton(Combat, "Silent Aim [NEON]", function() print("Neon Aim Active") end)
AddButton(World, "GodSpeed", function() lp.Character.Humanoid.WalkSpeed = 200 end)

local function Tab(n, y)
    local t = Instance.new("TextButton", Sidebar)
    t.Size = UDim2.new(0.85, 0, 0, 35)
    t.Position = UDim2.new(0.07, 0, 0, y)
    t.Text = n
    t.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    t.BackgroundTransparency = 0.9
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", t)
    t.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[n].Visible = true
        playSfx(5545464063)
    end)
end

Tab("Combat", 60); Tab("World", 105)
Pages["Combat"].Visible = true

-- КНОПКА ОТКРЫТИЯ С НЕОНОМ
local Toggle = Instance.new("ImageButton", ScreenGui)
Toggle.Size = UDim2.new(0, 50, 0, 50)
Toggle.Position = UDim2.new(0, 10, 0.4, 0)
Toggle.Image = "rbxassetid://6031225818"
Toggle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Toggle.Visible = false
local TCorner = Instance.new("UICorner", Toggle)
TCorner.CornerRadius = UDim.new(1, 0)
local TStroke = Instance.new("UIStroke", Toggle)
TStroke.Color = Color3.fromRGB(255, 0, 50)
TStroke.Thickness = 2

-- Запуск Интро и Показ меню
task.spawn(StartIntro)
task.wait(3.5)
Main.Visible = true
MainGlow.Visible = true
Toggle.Visible = true
playSfx(1548170034)
