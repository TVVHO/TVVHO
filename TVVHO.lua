local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Функция для звука
local function playSfx(id)
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://"..id
    s.Volume = 0.5
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "TVVHO_PREMIUM"

-- Главное окно
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 280)
Main.Position = UDim2.new(0.5, -210, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- Сайдбар
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
Sidebar.BorderSizePixel = 0

local SideLine = Instance.new("Frame", Sidebar)
SideLine.Size = UDim2.new(0, 2, 1, 0)
SideLine.Position = UDim2.new(1, 0, 0, 0)
SideLine.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
SideLine.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Sidebar)
Title.Text = "TVVHO\n侍"
Title.Size = UDim2.new(1, 0, 0, 60)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

-- Контейнер для страниц (Правая часть)
local PageContainer = Instance.new("Frame", Main)
PageContainer.Size = UDim2.new(1, -120, 1, -10)
PageContainer.Position = UDim2.new(0, 120, 0, 5)
PageContainer.BackgroundTransparency = 1

local Pages = {}

-- Функция создания страницы
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.CanvasSize = UDim2.new(0, 0, 0, 500)
    
    local Layout = Instance.new("UIListLayout", Page)
    Layout.Padding = UDim.new(0, 8)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    Pages[name] = Page
    return Page
end

-- Функция создания кнопки внутри страницы
local function AddButton(page, text, callback)
    local Btn = Instance.new("TextButton", page)
    Btn.Size = UDim2.new(0.9, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    Btn.MouseButton1Click:Connect(function()
        playSfx(5545464063)
        callback()
    end)
end

-- Создаем страницы
local CombatPage = CreatePage("COMBAT")
local WorldPage = CreatePage("WORLD")
local SettingsPage = CreatePage("SETTINGS")

-- ЗАПОЛНЯЕМ ФУНКЦИЯМИ
AddButton(CombatPage, "Kill All (Flick)", function()
    print("Запуск твоего старого скрипта...")
    -- Вставь сюда свой код на киллы
end)

AddButton(WorldPage, "Speed x2", function()
    lp.Character.Humanoid.WalkSpeed = 32
end)

AddButton(WorldPage, "Infinite Jump", function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

AddButton(SettingsPage, "Destroy UI", function()
    ScreenGui:Destroy()
end)

-- ЛОГИКА ПЕРЕКЛЮЧЕНИЯ ВКЛАДОК
local function CreateTabBtn(name)
    local TBtn = Instance.new("TextButton", Sidebar)
    TBtn.Size = UDim2.new(0.9, 0, 0, 35)
    TBtn.Position = UDim2.new(0.05, 0, 0, 70 + (#Sidebar:GetChildren()-3) * 40)
    TBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    TBtn.BackgroundTransparency = 1
    TBtn.Text = name
    TBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    TBtn.Font = Enum.Font.Gotham
    TBtn.TextSize = 14
    Instance.new("UICorner", TBtn).CornerRadius = UDim.new(0, 6)

    TBtn.MouseButton1Click:Connect(function()
        playSfx(5545464063)
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(Sidebar:GetChildren()) do 
            if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(150, 150, 150); b.BackgroundTransparency = 1 end 
        end
        Pages[name].Visible = true
        TBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TBtn.BackgroundTransparency = 0.8
    end)
end

CreateTabBtn("COMBAT")
CreateTabBtn("WORLD")
CreateTabBtn("SETTINGS")

-- По умолчанию открыта первая страница
Pages["COMBAT"].Visible = true

-- Drag (Перетаскивание)
local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input) dragging = false end)

playSfx(1548170034)
