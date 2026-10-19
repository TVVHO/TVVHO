-- TVVHO DYNASTY | TOKYO ELITE EDITION
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()
local camera = workspace.CurrentCamera
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- ПАРАМЕТРЫ
_G.Aim = false
_G.Esp = false

-- ГРОМКИЙ ЗВУК ПРИВЕТСТВИЯ
local function playLoudSound(id)
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://"..id
    s.Volume = 3
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

-- ==========================================
-- ELITE TOKYO INTRO
-- ==========================================
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
IntroFrame.ZIndex = 999

local Welcome = Instance.new("TextLabel", IntroFrame)
Welcome.Size = UDim2.new(1, 0, 1, 0)
Welcome.BackgroundTransparency = 1
Welcome.Text = "ТОКИО ПРИВЕТСТВУЕТ ВАС"
Welcome.TextColor3 = Color3.fromRGB(255, 255, 255)
Welcome.Font = Enum.Font.GothamBold
Welcome.TextSize = 30
Welcome.TextTransparency = 1
Welcome.ZIndex = 1000

task.spawn(function()
    task.wait(0.5)
    playLoudSound(255399231) 
    TweenService:Create(Welcome, TweenInfo.new(1.5), {TextTransparency = 0}):Play()
    task.wait(2.5)
    TweenService:Create(Welcome, TweenInfo.new(1), {TextTransparency = 1}):Play()
    TweenService:Create(IntroFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    task.wait(1)
    IntroFrame:Destroy()
end)

-- ==========================================
-- MAIN UI
-- ==========================================
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "Main"
Main.Size = UDim2.new(0, 420, 0, 280)
Main.Position = UDim2.new(0.5, -210, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
Main.Visible = false
Main.Active = true
Main.Draggable = true
Main.ZIndex = 10
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- NEON GLOW
local Glow = Instance.new("ImageLabel", ScreenGui)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://1316045217"
Glow.ImageColor3 = Color3.fromRGB(255, 0, 50)
Glow.ZIndex = 5
Glow.Visible = false
game:GetService("RunService").RenderStepped:Connect(function()
    Glow.Position = UDim2.new(Main.Position.X.Scale, Main.Position.X.Offset - 30, Main.Position.Y.Scale, Main.Position.Y.Offset - 30)
    Glow.Size = UDim2.new(0, Main.Size.X.Offset + 60, 0, Main.Size.Y.Offset + 60)
end)

-- SIDEBAR
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
Sidebar.ZIndex = 11
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Sidebar)
Title.Text = "TVVHO"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.TextColor3 = Color3.fromRGB(255, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1
Title.ZIndex = 12

-- PAGE CONTAINER
local PageContainer = Instance.new("Frame", Main)
PageContainer.Size = UDim2.new(1, -125, 1, -10)
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
    p.ScrollBarThickness = 2
    p.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 50)
    p.CanvasSize = UDim2.new(0, 0, 0, 800)
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
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 14
    b.ZIndex = 15
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() playLoudSound(5545464063); callback() end)
end

-- СОЗДАЕМ ВКЛАДКИ
local Combat = CreatePage("Combat")
local World = CreatePage("World")
local Visuals = CreatePage("Visuals")
local Misc = CreatePage("Misc")

-- ⚔️ COMBAT
AddButton(Combat, "Aimbot [ON]", function() _G.Aim = true end)
AddButton(Combat, "Aimbot [OFF]", function() _G.Aim = false end)
AddButton(Combat, "Silent Aim (Beta)", function() end)
AddButton(Combat, "Auto Clicker", function() end)
AddButton(Combat, "No Recoil", function() end)
AddButton(Combat, "Hitbox Expander", function() end)

-- 🌍 WORLD
AddButton(World, "Speed Boost (100)", function() lp.Character.Humanoid.WalkSpeed = 100 end)
AddButton(World, "High Jump (150)", function() lp.Character.Humanoid.JumpPower = 150 end)
AddButton(World, "Fly Mode", function() end)
AddButton(World, "Noclip", function() end)
AddButton(World, "Infinite Jump", function() end)

-- 👁️ VISUALS
AddButton(Visuals, "ESP Boxes", function() _G.Esp = true end)
AddButton(Visuals, "ESP OFF", function() _G.Esp = false end)
AddButton(Visuals, "Fullbright", function() game.Lighting.Brightness = 2; game.Lighting.ClockTime = 14 end)

-- 🛠️ MISC
AddButton(Misc, "TG: @TVVHOTER", function() setclipboard("@TVVHOTER") end)
AddButton(Misc, "Rejoin", function() game:GetService("TeleportService"):Teleport(game.PlaceId, lp) end)
AddButton(Misc, "Anti-AFK", function() end)

-- ТАБЫ (ИСПРАВЛЕННЫЕ КНОПКИ)
local function Tab(n, y)
    local t = Instance.new("TextButton", Sidebar)
    t.Size = UDim2.new(0.85, 0, 0, 35)
    t.Position = UDim2.new(0.07, 0, 0, y)
    t.Text = n
    t.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    t.BackgroundTransparency = 0.5 -- Сделал ярче
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.Font = Enum.Font.GothamBold
    t.ZIndex = 20 -- ПОВЕРХ ВСЕГО
    Instance.new("UICorner", t)
    t.MouseButton1Click:Connect(function()
        playLoudSound(5545464063)
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[n].Visible = true
    end)
end

Tab("Combat", 60); Tab("World", 100); Tab("Visuals", 140); Tab("Misc", 180)
Pages["Combat"].Visible = true

-- ЛОГИКА
game:GetService("RunService").RenderStepped:Connect(function()
    if _G.Aim then
        local target = nil
        local dist = 200
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("Head") then
                local pos, onScreen = camera:WorldToViewportPoint(v.Character.Head.Position)
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                if mag < dist and onScreen then target = v; dist = mag end
            end
        end
        if target then camera.CFrame = CFrame.new(camera.CFrame.Position, target.Character.Head.Position) end
    end
    if _G.Esp then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local b = v.Character:FindFirstChild("TVV") or Instance.new("BoxHandleAdornment", v.Character)
                b.Name = "TVV"; b.Adornee = v.Character; b.AlwaysOnTop = true; b.Size = Vector3.new(4,5,0.1); b.Color3 = Color3.fromRGB(255,0,0); b.Transparency = 0.6
            end
        end
    else
       for _, v in pairs(Players:GetPlayers()) do if v.Character and v.Character:FindFirstChild("TVV") then v.Character.TVV:Destroy() end end
    end
end)

local Toggle = Instance.new("ImageButton", ScreenGui)
Toggle.Size = UDim2.new(0, 50, 0, 50)
Toggle.Position = UDim2.new(0, 10, 0.4, 0)
Toggle.Image = "rbxassetid://6031225818"
Toggle.Visible = false
Toggle.ZIndex = 50
Instance.new("UICorner", Toggle)
Toggle.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible; Glow.Visible = Main.Visible end)

task.wait(4.5)
Main.Visible = true; Glow.Visible = true; Toggle.Visible = true
