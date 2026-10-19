local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- Настройки
_G.Aim = false
_G.AimbotFOV = 150 -- Радиус круга
_G.Esp = false

-- СОЗДАНИЕ КРУГА FOV (Рисуем через Frame, так как на Android Drawing.new часто глючит)
local FOVCircle = Instance.new("Frame", ScreenGui)
FOVCircle.Size = UDim2.new(0, _G.AimbotFOV * 2, 0, _G.AimbotFOV * 2)
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Thickness = 2 -- Толщина линии
FOVCircle.Visible = false -- По умолчанию скрыт

-- Делаем его круглым через UIStroke
local stroke = Instance.new("UIStroke", FOVCircle)
stroke.Color = Color3.fromRGB(255, 0, 50) -- Красный неон
stroke.Thickness = 1.5
Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)

-- ГЛАВНОЕ ОКНО (Тот самый первый вариант)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 260)
Main.Position = UDim2.new(0.5, -200, 0.5, -130)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ZIndex = 10
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- Сайдбар
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 100, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Sidebar.ZIndex = 11
Instance.new("UICorner", Sidebar)

local Title = Instance.new("TextLabel", Sidebar)
Title.Text = "TVVHO"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(255, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.ZIndex = 12

-- Контейнер
local PageContainer = Instance.new("Frame", Main)
PageContainer.Size = UDim2.new(1, -110, 1, -10)
PageContainer.Position = UDim2.new(0, 110, 0, 5)
PageContainer.BackgroundTransparency = 1
PageContainer.ZIndex = 11

local Pages = {}
local function CreatePage(name)
    local p = Instance.new("ScrollingFrame", PageContainer)
    p.Size = UDim2.new(1, 0, 1, 0)
    p.Visible = false
    p.BackgroundTransparency = 1
    p.CanvasSize = UDim2.new(0,0,0,400)
    p.ScrollBarThickness = 0
    p.ZIndex = 12
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 5)
    Pages[name] = p
    return p
end

local function AddToggle(page, text, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    btn.Text = "  " .. text
    btn.TextXAlignment = "Left"
    btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.ZIndex = 13
    Instance.new("UICorner", btn)
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
        btn.BackgroundColor3 = state and Color3.fromRGB(40, 20, 20) or Color3.fromRGB(25, 25, 28)
        callback(state)
    end)
end

-- ВКЛАДКИ
local Combat = CreatePage("Combat")
local Visuals = CreatePage("Visuals")

AddToggle(Combat, "Aimbot", function(v) _G.Aim = v; FOVCircle.Visible = v end)
AddToggle(Visuals, "ESP Boxes", function(v) _G.Esp = v end)

local function Tab(n, pos)
    local t = Instance.new("TextButton", Sidebar)
    t.Size = UDim2.new(0.9, 0, 0, 30)
    t.Position = UDim2.new(0.05, 0, 0, pos)
    t.Text = n
    t.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    t.BackgroundTransparency = 0.9
    t.TextColor3 = Color3.fromRGB(255,255,255)
    t.ZIndex = 15
    Instance.new("UICorner", t)
    t.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[n].Visible = true
    end)
end

Tab("Combat", 50); Tab("Visuals", 85)
Pages["Combat"].Visible = true

-- ЛОГИКА (AIM + ESP + CIRCLE)
RunService.RenderStepped:Connect(function()
    -- Обновляем позицию круга за мышкой/пальцем
    FOVCircle.Position = UDim2.new(0, mouse.X, 0, mouse.Y + 36)

    if _G.Aim then
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
    
    if _G.Esp then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local b = v.Character:FindFirstChild("TVV") or Instance.new("BoxHandleAdornment", v.Character)
                b.Name = "TVV"; b.Adornee = v.Character; b.AlwaysOnTop = true; b.Size = Vector3.new(4,5,0.1); b.Color3 = Color3.fromRGB(255,0,0); b.Transparency = 0.7
            end
        end
    end
end)

-- Иконка открытия (САМУРАЙ)
local ToggleIcon = Instance.new("ImageButton", ScreenGui)
ToggleIcon.Size = UDim2.new(0, 45, 0, 45)
ToggleIcon.Position = UDim2.new(0, 5, 0.4, 0)
ToggleIcon.Image = "rbxassetid://6031225818"
ToggleIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleIcon.ZIndex = 50
Instance.new("UICorner", ToggleIcon).CornerRadius = UDim.new(1, 0)
ToggleIcon.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
