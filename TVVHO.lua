local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Настройки темы
local THEME_COLOR = Color3.fromRGB(255, 0, 50)
local BG_COLOR = Color3.fromRGB(12, 12, 14)

-- Звуки
local function playSfx(id)
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://"..id
    s.Volume = 0.4
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "TVVHO_HUB"

-- КНОПКА ОТКРЫТИЯ (Floating Button)
local ToggleIcon = Instance.new("ImageButton", ScreenGui)
ToggleIcon.Size = UDim2.new(0, 50, 0, 50)
ToggleIcon.Position = UDim2.new(0, 10, 0.5, -25)
ToggleIcon.BackgroundColor3 = BG_COLOR
ToggleIcon.Image = "rbxassetid://6031225818" -- Иконка самурая/ниндзя
ToggleIcon.ImageColor3 = THEME_COLOR
Instance.new("UICorner", ToggleIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", ToggleIcon).Color = THEME_COLOR

-- ГЛАВНОЕ ОКНО
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 280)
Main.Position = UDim2.new(0.5, -210, 0.5, -140)
Main.BackgroundColor3 = BG_COLOR
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Visible = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- Сайдбар
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
Sidebar.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Sidebar)
Title.Text = "TVVHO\n侍"
Title.Size = UDim2.new(1, 0, 0, 60)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

local PageContainer = Instance.new("Frame", Main)
PageContainer.Size = UDim2.new(1, -120, 1, -10)
PageContainer.Position = UDim2.new(0, 120, 0, 5)
PageContainer.BackgroundTransparency = 1

local Pages = {}

-- ФУНКЦИЯ СОЗДАНИЯ СТРАНИЦЫ
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = THEME_COLOR
    Page.CanvasSize = UDim2.new(0, 0, 0, 600) -- Большой размер для 30+ функций
    
    local Layout = Instance.new("UIListLayout", Page)
    Layout.Padding = UDim.new(0, 6)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    Pages[name] = Page
    return Page
end

-- КНОПКА (Button)
local function AddButton(page, text, callback)
    local Btn = Instance.new("TextButton", page)
    Btn.Size = UDim2.new(0.95, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(function()
        playSfx(5545464063)
        callback()
    end)
end

-- ПЕРЕКЛЮЧАТЕЛЬ (Toggle)
local function AddToggle(page, text, callback)
    local TglFrame = Instance.new("TextButton", page)
    TglFrame.Size = UDim2.new(0.95, 0, 0, 35)
    TglFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    TglFrame.Text = "  " .. text
    TglFrame.TextColor3 = Color3.fromRGB(180, 180, 180)
    TglFrame.Font = Enum.Font.Gotham
    TglFrame.TextSize = 13
    TglFrame.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", TglFrame).CornerRadius = UDim.new(0, 6)

    local Indicator = Instance.new("Frame", TglFrame)
    Indicator.Position = UDim2.new(1, -30, 0.5, -8)
    Indicator.Size = UDim2.new(0, 20, 0, 16)
    Indicator.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(0, 4)

    local state = false
    TglFrame.MouseButton1Click:Connect(function()
        state = not state
        playSfx(5545464063)
        TweenService:Create(Indicator, TweenInfo.new(0.3), {BackgroundColor3 = state and THEME_COLOR or Color3.fromRGB(50, 50, 50)}):Play()
        callback(state)
    end)
end

-- ЛОГИКА ВКЛАДОК
local function CreateTabBtn(name)
    local TBtn = Instance.new("TextButton", Sidebar)
    TBtn.Size = UDim2.new(0.9, 0, 0, 35)
    TBtn.Position = UDim2.new(0.05, 0, 0, 70 + (#Sidebar:GetChildren()-1) * 40)
    TBtn.BackgroundColor3 = THEME_COLOR
    TBtn.BackgroundTransparency = 1
    TBtn.Text = name
    TBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    TBtn.Font = Enum.Font.GothamBold
    TBtn.TextSize = 12
    Instance.new("UICorner", TBtn).CornerRadius = UDim.new(0, 6)

    TBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(Sidebar:GetChildren()) do if b:IsA("TextButton") then b.BackgroundTransparency = 1 end end
        Pages[name].Visible = true
        TBtn.BackgroundTransparency = 0.8
        playSfx(5545464063)
    end)
end

-- Создаем страницы и функции
local Combat = CreatePage("COMBAT")
local World = CreatePage("WORLD")
local Misc = CreatePage("MISC")

-- COMBAT FUNCTIONS
AddToggle(Combat, "Silent Aim", function(v) print("Silent Aim:", v) end)
AddToggle(Combat, "Auto Clicker", function(v) _G.autoclick = v while _G.autoclick do wait() --[[click code]] end end)
AddButton(Combat, "Kill All Players", function() print("Убиваем всех...") end)

-- WORLD FUNCTIONS
AddButton(World, "Speed Boost", function() lp.Character.Humanoid.WalkSpeed = 100 end)
AddButton(World, "High Jump", function() lp.Character.Humanoid.JumpPower = 150 end)
AddToggle(World, "Fly Mode", function(v) print("Fly:", v) end)
AddToggle(World, "No Clip", function(v) print("NoClip:", v) end)

-- Создаем кнопки вкладок
CreateTabBtn("COMBAT")
CreateTabBtn("WORLD")
CreateTabBtn("MISC")
Pages["COMBAT"].Visible = true

-- ЛОГИКА ОТКРЫТИЯ/ЗАКРЫТИЯ
ToggleIcon.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    playSfx(1548170034)
    if Main.Visible then
        Main:TweenSize(UDim2.new(0, 420, 0, 280), "Out", "Back", 0.5, true)
    else
        Main:TweenSize(UDim2.new(0, 420, 0, 0), "In", "Quad", 0.3, true)
    end
end)

-- ПЕРЕТАСКИВАНИЕ (Drag)
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
