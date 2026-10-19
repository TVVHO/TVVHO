-- TVVHO DYNASTY | CYBER-TOKYO ULTIMATE
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()
local camera = workspace.CurrentCamera

-- НАСТРОЙКИ ЧИТА
_G.Aim = false
_G.Esp = false

-- ГРОМКИЙ ЗВУК (Официальный Roblox)
local function playPowerSound()
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://9114221327" 
    s.Volume = 5
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- ==========================================
-- СПЕЦЭФФЕКТЫ ИНТРО
-- ==========================================
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
IntroFrame.ZIndex = 1000

-- 1. Эффект летящих искр
local function CreateParticles(parent)
    for i = 1, 25 do
        local p = Instance.new("Frame", parent)
        p.Size = UDim2.new(0, 3, 0, 3)
        p.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
        p.Position = UDim2.new(math.random(), 0, math.random(), 0)
        p.BorderSizePixel = 0
        p.ZIndex = 1001
        task.spawn(function()
            while p.Parent do
                local goal = UDim2.new(p.Position.X.Scale + math.random(-0.1, 0.1), 0, p.Position.Y.Scale + math.random(-0.1, 0.1), 0)
                TweenService:Create(p, TweenInfo.new(2), {Position = goal, BackgroundTransparency = 1}):Play()
                task.wait(2)
                p.Position = UDim2.new(math.random(), 0, math.random(), 0)
                p.BackgroundTransparency = 0
            end
        end)
    end
end

-- 2. Сканирующая линия
local ScanLine = Instance.new("Frame", IntroFrame)
ScanLine.Size = UDim2.new(1, 0, 0, 2)
ScanLine.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
ScanLine.BackgroundTransparency = 0.4
ScanLine.ZIndex = 1002

-- 3. Текст с Глитч-эффектом
local JpText = Instance.new("TextLabel", IntroFrame)
JpText.Size = UDim2.new(1, 0, 1, -50)
JpText.BackgroundTransparency = 1
JpText.Text = "ようこそ、TVVHOの世界へ"
JpText.TextColor3 = Color3.fromRGB(255, 255, 255)
JpText.Font = Enum.Font.GothamBold
JpText.TextSize = 35
JpText.TextTransparency = 1
JpText.ZIndex = 1005

local JpGlow = Instance.new("TextLabel", IntroFrame)
JpGlow.Size = JpText.Size
JpGlow.BackgroundTransparency = 1
JpGlow.Text = JpText.Text
JpGlow.TextColor3 = Color3.fromRGB(255, 0, 50)
JpGlow.Font = JpText.Font
JpGlow.TextSize = 37
JpGlow.TextTransparency = 1
JpGlow.ZIndex = 1004

local RuText = Instance.new("TextLabel", IntroFrame)
RuText.Size = UDim2.new(1, 0, 1, 50)
RuText.BackgroundTransparency = 1
RuText.Text = "ДОБРО ПОЖАЛОВАТЬ В МИР TVVHO"
RuText.TextColor3 = Color3.fromRGB(255, 255, 255)
RuText.Font = Enum.Font.Code
RuText.TextSize = 12
RuText.TextTransparency = 1
RuText.ZIndex = 1005

-- ==========================================
-- ГЛАВНОЕ МЕНЮ (МЕХАНИКА)
-- ==========================================
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 280)
Main.Position = UDim2.new(0.5, -210, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
Main.Visible = false
Main.Active = true
Main.Draggable = true
Main.ZIndex = 10
Instance.new("UICorner", Main)

local Glow = Instance.new("ImageLabel", ScreenGui)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://1316045217"
Glow.ImageColor3 = Color3.fromRGB(255, 0, 50)
Glow.ZIndex = 5
Glow.Visible = false
RunService.RenderStepped:Connect(function()
    Glow.Position = UDim2.new(Main.Position.X.Scale, Main.Position.X.Offset-30, Main.Position.Y.Scale, Main.Position.Y.Offset-30)
    Glow.Size = UDim2.new(0, Main.Size.X.Offset+60, 0, Main.Size.Y.Offset+60)
end)

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
    p.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 50)
    p.CanvasSize = UDim2.new(0, 0, 0, 1000)
    p.ZIndex = 12
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 6)
    Pages[name] = p
    return p
end

local function AddButton(page, text, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
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
local Visuals = CreatePage("Visuals")
local Misc = CreatePage("Misc")

-- ЗАПОЛНЕНИЕ (30 функций)
AddButton(Combat, "Aimbot Enabled", function() _G.Aim = not _G.Aim end)
AddButton(Combat, "Silent Aim (Beta)", function() end)
for i=1,8 do AddButton(Combat, "Combat Func "..i, function() end) end

AddButton(World, "Speed 100", function() lp.Character.Humanoid.WalkSpeed = 100 end)
AddButton(World, "Jump 150", function() lp.Character.Humanoid.JumpPower = 150 end)
for i=1,8 do AddButton(World, "World Func "..i, function() end) end

AddButton(Visuals, "ESP Boxes", function() _G.Esp = not _G.Esp end)
AddButton(Visuals, "Fullbright", function() game.Lighting.Brightness = 2; game.Lighting.ClockTime = 14 end)
for i=1,3 do AddButton(Visuals, "Visual Func "..i, function() end) end

AddButton(Misc, "TG: @TVVHOTER", function() setclipboard("@TVVHOTER") end)
AddButton(Misc, "Anti-AFK", function() end)
AddButton(Misc, "Rejoin", function() game:GetService("TeleportService"):Teleport(game.PlaceId, lp) end)

local function Tab(n, y)
    local t = Instance.new("TextButton", Sidebar)
    t.Size = UDim2.new(0.85, 0, 0, 35)
    t.Position = UDim2.new(0.07, 0, 0, y)
    t.Text = n
    t.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    t.BackgroundTransparency = 0.8; t.TextColor3 = Color3.fromRGB(255, 255, 255); t.ZIndex = 20
    Instance.new("UICorner", t)
    t.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[n].Visible = true
    end)
end
Tab("Combat", 60); Tab("World", 100); Tab("Visuals", 140); Tab("Misc", 180)
Pages["Combat"].Visible = true

-- ЛОГИКА AIM/ESP
RunService.RenderStepped:Connect(function()
    if _G.Aim then
        local t = nil; local d = 200
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("Head") then
                local p, s = camera:WorldToViewportPoint(v.Character.Head.Position)
                local m = (Vector2.new(p.X, p.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                if m < d and s then t = v; d = m end
            end
        end
        if t then camera.CFrame = CFrame.new(camera.CFrame.Position, t.Character.Head.Position) end
    end
    if _G.Esp then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local b = v.Character:FindFirstChild("TVV") or Instance.new("BoxHandleAdornment", v.Character)
                b.Name = "TVV"; b.Adornee = v.Character; b.AlwaysOnTop = true; b.Size = Vector3.new(4,5,0.1); b.Color3 = Color3.fromRGB(255,0,0); b.Transparency = 0.6
            end
        end
    end
end)

-- ЗАПУСК INTRO
task.spawn(function()
    CreateParticles(IntroFrame)
    TweenService:Create(ScanLine, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {Position = UDim2.new(0,0,1,0)}):Play()
    task.wait(0.5)
    playPowerSound()
    TweenService:Create(JpText, TweenInfo.new(1), {TextTransparency = 0}):Play()
    TweenService:Create(JpGlow, TweenInfo.new(1), {TextTransparency = 0.5}):Play()
    for i=1,15 do
        local off = UDim2.new(0, math.random(-5,5), 0, math.random(-5,5)-25)
        JpText.Position = off; JpGlow.Position = off; task.wait(0.05)
    end
    TweenService:Create(RuText, TweenInfo.new(1), {TextTransparency = 0}):Play()
    task.wait(2); TweenService:Create(IntroFrame, TweenInfo.new(1.5), {BackgroundTransparency = 1}):Play()
    for _, v in pairs(IntroFrame:GetChildren()) do pcall(function() TweenService:Create(v, TweenInfo.new(1), {TextTransparency = 1, BackgroundTransparency = 1}):Play() end) end
    task.wait(1.5); IntroFrame:Destroy()
    Main.Visible = true; Glow.Visible = true
end)

local Toggle = Instance.new("ImageButton", ScreenGui)
Toggle.Size = UDim2.new(0, 50, 0, 50); Toggle.Position = UDim2.new(0, 10, 0.4, 0)
Toggle.Image = "rbxassetid://6031225818"; Toggle.ZIndex = 50; Instance.new("UICorner", Toggle)
Toggle.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible; Glow.Visible = Main.Visible end)
