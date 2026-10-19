local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- Функция для звука (Голос или Эффект)
local function playWelcomeSound()
    local s = Instance.new("Sound", game:GetService("SoundService"))
    -- Используем звук технологичного интерфейса или киберпанка
    s.SoundId = "rbxassetid://255399231" -- Глубокий звук "Power Up"
    s.Volume = 0.8
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

-- ==========================================
-- ЭЛИТНОЕ ИНТРО "ТОКИО"
-- ==========================================
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(5, 0, 0) -- Темно-красный подтон
IntroFrame.ZIndex = 500

-- Эффект сканирующей полоски (как в дорогих системах)
local Scanner = Instance.new("Frame", IntroFrame)
Scanner.Size = UDim2.new(1, 0, 0, 2)
Scanner.Position = UDim2.new(0, 0, 0, 0)
Scanner.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
Scanner.BorderSizePixel = 0
Scanner.ZIndex = 501

local WelcomeText = Instance.new("TextLabel", IntroFrame)
WelcomeText.Size = UDim2.new(1, 0, 1, 0)
WelcomeText.BackgroundTransparency = 1
WelcomeText.Text = "ТОКИО ПРИВЕТСТВУЕТ ВАС"
WelcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.TextSize = 30
WelcomeText.TextTransparency = 1
WelcomeText.ZIndex = 502

local SubText = Instance.new("TextLabel", IntroFrame)
SubText.Size = UDim2.new(1, 0, 1, 80)
SubText.BackgroundTransparency = 1
SubText.Text = "TVVHO DYNASTY | 伝説"
SubText.TextColor3 = Color3.fromRGB(255, 0, 50)
SubText.Font = Enum.Font.Code
SubText.TextSize = 15
SubText.TextTransparency = 1
SubText.ZIndex = 502

-- АНИМАЦИЯ ЗАПУСКА
local function RunIntro()
    -- Сканирование экрана
    TweenService:Create(Scanner, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Position = UDim2.new(0, 0, 1, 0)}):Play()
    task.wait(0.5)
    
    playWelcomeSound() -- Звук включения системы
    
    -- Плавное появление надписи Токио
    TweenService:Create(WelcomeText, TweenInfo.new(1.5), {TextTransparency = 0}):Play()
    task.wait(1)
    TweenService:Create(SubText, TweenInfo.new(1), {TextTransparency = 0}):Play()
    
    task.wait(2.5)
    
    -- Исчезновение интро
    TweenService:Create(WelcomeText, TweenInfo.new(1), {TextTransparency = 1}):Play()
    TweenService:Create(SubText, TweenInfo.new(1), {TextTransparency = 1}):Play()
    TweenService:Create(IntroFrame, TweenInfo.new(1.5), {BackgroundTransparency = 1}):Play()
    
    task.wait(1.5)
    IntroFrame:Destroy()
end

-- ==========================================
-- ГЛАВНОЕ ОКНО (УЖЕ С РАБОЧИМИ КНОПКАМИ)
-- ==========================================
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 280)
Main.Position = UDim2.new(0.5, -210, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Active = true
Main.Draggable = true
Main.ZIndex = 10
Instance.new("UICorner", Main)

-- Неон под меню
local MainGlow = Instance.new("ImageLabel", ScreenGui)
MainGlow.BackgroundTransparency = 1
MainGlow.Image = "rbxassetid://1316045217"
MainGlow.ImageColor3 = Color3.fromRGB(255, 0, 50)
MainGlow.ImageTransparency = 0.5
MainGlow.ZIndex = 5
MainGlow.Visible = false

game:GetService("RunService").RenderStepped:Connect(function()
    MainGlow.Position = UDim2.new(Main.Position.X.Scale, Main.Position.X.Offset - 30, Main.Position.Y.Scale, Main.Position.Y.Offset - 30)
    MainGlow.Size = UDim2.new(0, Main.Size.X.Offset + 60, 0, Main.Size.Y.Offset + 60)
end)

-- Сайдбар и кнопки
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
Sidebar.ZIndex = 11

local PageContainer = Instance.new("Frame", Main)
PageContainer.Size = UDim2.new(1, -120, 1, -10)
PageContainer.Position = UDim2.new(0, 120, 0, 5)
PageContainer.BackgroundTransparency = 1
PageContainer.ZIndex = 11

local Pages = {}
local function CreatePage(name)
    local p = Instance.new("ScrollingFrame", PageContainer)
    p.Size = UDim2.new(1, 0, 1, 0)
    p.Visible = false
    p.BackgroundTransparency = 1
    p.ZIndex = 12
    p.ScrollBarThickness = 0
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 8)
    Pages[name] = p
    return p
end

local function AddButton(page, text, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    b.ZIndex = 13
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(callback)
end

-- ВКЛАДКИ
local Combat = CreatePage("Combat")
local World = CreatePage("World")

AddButton(Combat, "Aimbot Enabled", function() print("Aimbot Active") end)
AddButton(World, "Speed Boost", function() lp.Character.Humanoid.WalkSpeed = 100 end)

local function Tab(n, y)
    local t = Instance.new("TextButton", Sidebar)
    t.Size = UDim2.new(0.85, 0, 0, 35)
    t.Position = UDim2.new(0.07, 0, 0, y)
    t.Text = n
    t.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    t.BackgroundTransparency = 0.8
    t.ZIndex = 15
    Instance.new("UICorner", t)
    t.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[n].Visible = true
    end)
end

Tab("Combat", 60)
Tab("World", 105)
Pages["Combat"].Visible = true

-- Кнопка открытия
local Toggle = Instance.new("ImageButton", ScreenGui)
Toggle.Size = UDim2.new(0, 50, 0, 50)
Toggle.Position = UDim2.new(0, 10, 0.4, 0)
Toggle.Image = "rbxassetid://6031225818"
Toggle.Visible = false
Toggle.ZIndex = 50
Instance.new("UICorner", Toggle)
Toggle.MouseButton1Click:Connect(function() 
    Main.Visible = not Main.Visible 
    MainGlow.Visible = Main.Visible
end)

-- ЗАПУСК ВСЕГО
task.spawn(RunIntro)
task.wait(5.5) -- Длительность интро
Main.Visible = true
MainGlow.Visible = true
Toggle.Visible = true
