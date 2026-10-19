-- Сервисы
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Переменные читов
local flying = false
local bodyVel
local aimbotToggle = false
local espToggle = false

-- Защита от повторных запусков
if CoreGui:FindFirstChild("DeltaAdminHub") then return end

-- === ОСНОВНОЙ КОНТЕЙНЕР (CoreGui) ===
local mainGui = Instance.new("ScreenGui", CoreGui)
mainGui.Name = "DeltaAdminHub"
mainGui.ResetOnSpawn = false
mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Размытие фона (как в Delta)
local blur = Instance.new("BlurEffect", Lighting)
blur.Name = "AdminHubBlur"
blur.Enabled = false
blur.Size = 0

-- === ОКНО (WINDOW) ===
local window = Instance.new("Frame", mainGui)
window.Name = "Window"
window.Size = UDim2.new(0, 500, 0, 400)
window.Position = UDim2.new(0.5, -250, 0.5, -200)
window.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
window.BorderSizePixel = 0
window.Active = true
window.Draggable = true

-- Элементы стилизации окна
Instance.new("UICorner", window).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke", window)
stroke.Color = Color3.fromRGB(60, 60, 80)
stroke.Thickness = 2

-- Тень (тень важна для "премиум" вида)
local shadow = Instance.new("ImageLabel", window)
shadow.Image = "rbxassetid://5502127379"
shadow.BackgroundTransparency = 1
shadow.Size = UDim2.new(1, 0, 1, 0)
shadow.Position = UDim2.new(0, 0, 0, 0)
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(25, 25, 225, 225)

-- === ШАПКА ===
local topbar = Instance.new("Frame", window)
topbar.Size = UDim2.new(1, 0, 0, 35)
topbar.Position = UDim2.new(0, 0, 0, 0)
topbar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
topbar.BorderSizePixel = 0

Instance.new("UICorner", topbar).CornerRadius = UDim.new(0, 8, 0, 0)

local title = Instance.new("TextLabel", topbar)
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "Delta Executor // Admin Panel"
title.TextColor3 = Color3.fromRGB(0, 255, 180)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Position = UDim2.new(0, 10, 0, 0)

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton", topbar)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.Text = ""
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local closeIcon = Instance.new("TextLabel", closeBtn)
closeIcon.Size = UDim2.new(1, 0, 1, 0)
closeIcon.BackgroundTransparency = 1
closeIcon.Text = "X"
closeIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
closeIcon.Font = Enum.Font.GothamBold
closeIcon.TextSize = 18

-- === ВКЛАДКИ (TABS) ===
local tabHolder = Instance.new("Frame", window)
tabHolder.Size = UDim2.new(1, 0, 0, 40)
tabHolder.Position = UDim2.new(0, 0, 0, 40)
tabHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
tabHolder.BorderSizePixel = 0

Instance.new("UICorner", tabHolder).CornerRadius = UDim.new(0, 6)

local tabs = {"Combat", "Visual", "World"}
local currentTab = "Combat"
local tabButtons = {}

local function SwitchTab(tabName)
    currentTab = tabName
    -- Обновляем цвет вкладок
    for _, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    end
    tabButtons[tabName].BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    
    -- Очищаем контент
    for _, v in pairs(contentArea:GetChildren()) do
        if v:IsA("TextButton") or v:IsA("Frame") then
            v:Destroy()
        end
    end

    -- Создаем контент в зависимости от вкладки
    local list = Instance.new("UIListLayout", contentArea)
    list.Padding = UDim.new(0, 8)
    list.HorizontalAlignment = Enum.HorizontalAlignment.Center

    if tabName == "Combat" then
        CreateToggle("Aimbot", aimbotToggle, function(state)
            aimbotToggle = state
            if state then
                RunService:BindToRenderStep("Aimbot", Enum.RenderPriority.Camera.Value, function()
                    local target = nil
                    local minDist = math.huge
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
                            local dist = (p.Character.Head.Position - player.Character.Head.Position).Magnitude
                            if dist < minDist then target = p; minDist = dist end
                        end
                    end
                    if target then
                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position)
                    end
                end)
            else
                RunService:UnbindFromRenderStep("Aimbot")
            end
        end)
        CreateToggle("Silent Aim", false, function() warn("Locked Feature") end)
        CreateToggle("Trigger Bot", false, function() warn("Locked Feature") end)

    elseif tabName == "Visual" then
        CreateToggle("ESP Boxes", espToggle, function(state)
            espToggle = state
            -- Здесь была бы логика ESP
            warn("ESP Toggled: " .. tostring(state))
        end)
        CreateToggle("Chams", false, function() warn("Locked Feature") end)
        CreateToggle("Fullbright", false, function()
            Lighting.Ambient = Color3.new(1, 1, 1)
            Lighting.Brightness = 3
            Lighting.GlobalShadows = false
        end)

    elseif tabName == "World" then
        CreateButton("Fly (Toggle)", function()
            flying = not flying
            if flying then
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    bodyVel = Instance.new("BodyVelocity", player.Character.HumanoidRootPart)
                    bodyVel.MaxForce = Vector3.new(100000, 100000, 100000)
                    bodyVel.Velocity = Vector3.new(0, 0, 0)
                    RunService.Heartbeat:Connect(function()
                        if bodyVel then
                            local cam = workspace.CurrentCamera
                            bodyVel.Velocity = (cam.CFrame.LookVector * (UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0) +
                                               cam.CFrame.LookVector * -1 * (UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0) +
                                               cam.CFrame.RightVector * (UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0) +
                                               cam.CFrame.RightVector * -1 * (UserInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0) +
                                               Vector3.new(0, (UserInputService:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0), 0)) * 100
                        end
                    end)
                end
            elseif bodyVel then
                bodyVel:Destroy()
                bodyVel = nil
            end
        end)
        CreateButton("Destroy GUI", function()
            blur.Enabled = false
            blur.Size = 0
            mainGui:Destroy()
        end)
    end
end

-- Область контента
local contentArea = Instance.new("Frame", window)
contentArea.Size = UDim2.new(1, -20, 1, -110)
contentArea.Position = UDim2.new(0, 10, 0, 90)
contentArea.BackgroundTransparency = 1

-- Функция создания переключателя (Toggle)
function CreateToggle(text, default, callback)
    local frame = Instance.new("Frame", contentArea)
    frame.Size = UDim2.new(0.9, 0, 0, 30)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 230)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Position = UDim2.new(0, 10, 0, 0)

    local toggleBtn = Instance.new("TextButton", frame)
    toggleBtn.Size = UDim2.new(0, 40, 0, 20)
    toggleBtn.Position = UDim2.new(1, -50, 0, 5)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    toggleBtn.Text = ""
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 4)

    local toggleCircle = Instance.new("Frame", toggleBtn)
    toggleCircle.Size = UDim2.new(0, 16, 0, 16)
    toggleCircle.Position = UDim2.new(0, 2, 0, 2)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 210)
    toggleCircle.BorderSizePixel = 0
    Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(0, 8)

    local state = default
    if state then
        toggleCircle.Position = UDim2.new(1, -18, 0, 2)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 180)
    end

    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        if state then
            TweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0, 2)}):Play()
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 255, 180)}):Play()
        else
            TweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2)}):Play()
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 75)}):Play()
        end
    end)
end

-- Функция создания обычной кнопки
function CreateButton(text, callback)
    local btn = Instance.new("TextButton", contentArea)
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(220, 220, 230)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        callback()
    end)
end

-- === ЛОГИКА ОТКРЫТИЯ/ЗАКРЫТИЯ ===
-- Открытие по клавишам (например, Insert)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        if mainGui.Enabled then
            blur.Enabled = false
            blur.Size = 0
            mainGui.Enabled = false
        else
            blur.Enabled = true
            blur.Size = 15
            mainGui.Enabled = true
            SwitchTab("Combat") -- При открытии обновляем вкладку
        end
    end
end)

-- Кнопка закрытия
closeBtn.MouseButton1Click:Connect(function()
    blur.Enabled = false
    blur.Size = 0
    mainGui:Destroy()
end)

-- Инициализация
SwitchTab("Combat")-- === ЛОГИКА ОТКРЫТИЯ/ЗАКРЫТИЯ МЕНЮ ===

-- По умолчанию скрываем GUI при запуске
mainGui.Enabled = false

-- Открытие/закрытие по клавише Insert
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        if mainGui.Enabled then
            -- Закрываем
            blur.Enabled = false
            blur.Size = 0
            mainGui.Enabled = false
        else
            -- Открываем
            blur.Enabled = true
            TweenService:Create(blur, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 15}):Play()
            mainGui.Enabled = true
            -- При каждом открытии обновляем контент, чтобы сбросить старые BindToRenderStep
            SwitchTab("Combat")
        end
    end
end)

-- Кнопка закрытия (X) в шапке
closeBtn.MouseButton1Click:Connect(function()
    blur.Enabled = false
    blur.Size = 0
    mainGui:Destroy()
end)
