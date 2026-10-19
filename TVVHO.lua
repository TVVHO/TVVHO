local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Функция для звука (Профессиональный штрих)
local function playSfx(id)
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://"..id
    s.Volume = 0.5
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

-- СОЗДАНИЕ UI
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "TVVHO_PREMIUM"

-- Тень/Свечение (Glow)
local GlowFrame = Instance.new("ImageLabel", ScreenGui)
GlowFrame.Name = "Glow"
GlowFrame.BackgroundTransparency = 1
GlowFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
GlowFrame.Size = UDim2.new(0, 420, 0, 320)
GlowFrame.Image = "rbxassetid://1316045217" -- Тень
GlowFrame.ImageColor3 = Color3.fromRGB(255, 0, 50)
GlowFrame.ImageTransparency = 1

-- Главное окно
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "Main"
Main.Size = UDim2.new(0, 400, 0, 300)
Main.Position = UDim2.new(0.5, -200, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.BackgroundTransparency = 1 -- Начнем с прозрачного

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 10)

-- Боковая панель (Сайдбар)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Sidebar.BorderSizePixel = 0

local SideLine = Instance.new("Frame", Sidebar)
SideLine.Size = UDim2.new(0, 2, 1, 0)
SideLine.Position = UDim2.new(1, 0, 0, 0)
SideLine.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
SideLine.BorderSizePixel = 0

-- Заголовок
local Title = Instance.new("TextLabel", Sidebar)
Title.Text = "TVVHO\n侍"
Title.Size = UDim2.new(1, 0, 0, 60)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

-- Контейнер для кнопок (Вкладки)
local TabContainer = Instance.new("ScrollingFrame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, -70)
TabContainer.Position = UDim2.new(0, 0, 0, 70)
TabContainer.BackgroundTransparency = 1
TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
TabContainer.ScrollBarThickness = 0

local Layout = Instance.new("UIListLayout", TabContainer)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Padding = UDim.new(0, 8)

-- ФУНКЦИЯ СОЗДАНИЯ ВКЛАДКИ (Анимированная)
local function CreateTab(name, iconId)
    local TabBtn = Instance.new("TextButton", TabContainer)
    TabBtn.Size = UDim2.new(0.9, 0, 0, 35)
    TabBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    TabBtn.BackgroundTransparency = 1
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.TextSize = 14
    
    local btnCorner = Instance.new("UICorner", TabBtn)
    btnCorner.CornerRadius = UDim.new(0, 6)

    -- Анимация при наведении/нажатии
    TabBtn.MouseButton1Click:Connect(function()
        playSfx(5545464063) -- Звук клика
        for _, v in pairs(TabContainer:GetChildren()) do
            if v:IsA("TextButton") then
                TweenService:Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
            end
        end
        TweenService:Create(TabBtn, TweenInfo.new(0.3), {BackgroundTransparency = 0.8, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    end)
end

-- Добавляем вкладки
CreateTab("COMBAT", "")
CreateTab("WORLD", "")
CreateTab("VISUALS", "")
CreateTab("SETTINGS", "")

-- АНИМАЦИЯ ПОЯВЛЕНИЯ (ПРОФИ-СТИЛЬ)
local function Intro()
    playSfx(1548170034) -- Звук катаны
    Main.Size = UDim2.new(0, 400, 0, 0)
    Main.BackgroundTransparency = 0
    TweenService:Create(Main, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 300)}):Play()
    wait(0.5)
    TweenService:Create(GlowFrame, TweenInfo.new(1), {ImageTransparency = 0.5}):Play()
end

Intro()

-- Drag System (Перетаскивание для мобилок)
local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        GlowFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X - 10, startPos.Y.Scale, startPos.Y.Offset + delta.Y - 10)
    end
end)
UserInputService.InputEnded:Connect(function(input) dragging = false end)
