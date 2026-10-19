local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- Настройки
_G.Aim = false
_G.Esp = false

-- 1. ЛЕГКОЕ ИНТРО
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
IntroFrame.ZIndex = 999

local JpText = Instance.new("TextLabel", IntroFrame)
JpText.Size = UDim2.new(1, 0, 1, 0)
JpText.BackgroundTransparency = 1
JpText.Text = "ようこそ、TVVHOの世界へ"
JpText.TextColor3 = Color3.fromRGB(255, 0, 50)
JpText.Font = Enum.Font.GothamBold
JpText.TextSize = 30
JpText.TextTransparency = 1
JpText.ZIndex = 1000

-- 2. ГЛАВНОЕ МЕНЮ
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 280)
Main.Position = UDim2.new(0.5, -210, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
Main.Visible = false
Main.Active = true
Main.Draggable = true
Main.ZIndex = 10
Instance.new("UICorner", Main)

local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
Sidebar.ZIndex = 11
Instance.new("UICorner", Sidebar)

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
    p.ScrollBarThickness = 2
    p.CanvasSize = UDim2.new(0, 0, 0, 800)
    p.ZIndex = 12
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 5)
    Pages[name] = p
    return p
end

local function AddButton(page, text, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamSemibold
    b.ZIndex = 15
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(callback)
end

-- СТРАНИЦЫ
local Combat = CreatePage("Combat")
local World = CreatePage("World")
local Misc = CreatePage("Misc")

AddButton(Combat, "Aimbot ON", function() _G.Aim = true end)
AddButton(Combat, "Aimbot OFF", function() _G.Aim = false end)
AddButton(World, "Speed 100", function() lp.Character.Humanoid.WalkSpeed = 100 end)
AddButton(Misc, "TG: @TVVHOTER", function() setclipboard("@TVVHOTER") end)

local function Tab(n, y)
    local t = Instance.new("TextButton", Sidebar)
    t.Size = UDim2.new(0.85, 0, 0, 35)
    t.Position = UDim2.new(0.07, 0, 0, y)
    t.Text = n
    t.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    t.BackgroundTransparency = 0.7
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.ZIndex = 20
    Instance.new("UICorner", t)
    t.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[n].Visible = true
    end)
end
Tab("Combat", 60); Tab("World", 100); Tab("Misc", 140)
Pages["Combat"].Visible = true

-- Кнопка открытия
local Toggle = Instance.new("ImageButton", ScreenGui)
Toggle.Size = UDim2.new(0, 50, 0, 50)
Toggle.Position = UDim2.new(0, 10, 0.4, 0)
Toggle.Image = "rbxassetid://6031225818"
Toggle.Visible = false
Toggle.ZIndex = 50
Instance.new("UICorner", Toggle)
Toggle.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- ЗАПУСК
task.spawn(function()
    TweenService:Create(JpText, TweenInfo.new(1.5), {TextTransparency = 0}):Play()
    task.wait(2.5)
    TweenService:Create(IntroFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    TweenService:Create(JpText, TweenInfo.new(1), {TextTransparency = 1}):Play()
    task.wait(1)
    IntroFrame:Destroy()
    Main.Visible = true
    Toggle.Visible = true
end)
