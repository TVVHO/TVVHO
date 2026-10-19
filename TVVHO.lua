-- УДАЛЯЕМ СТАРЫЕ ВЕРСИИ ПЕРЕД ЗАПУСКОМ
if game.CoreGui:FindFirstChild("TVVHO_FINAL") then game.CoreGui.TVVHO_FINAL:Destroy() end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "TVVHO_FINAL"

-- ГЛАВНОЕ ОКНО
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 200, 0, 250)
Main.Position = UDim2.new(0.5, -100, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- Можно двигать пальцем

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 12)

-- ЗАГОЛОВОК
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Text = "TVVHO HUB V2"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18
local TCorner = Instance.new("UICorner", Title)

-- КНОПКА СКРЫТЬ (-)
local HideBtn = Instance.new("TextButton", Main)
HideBtn.Size = UDim2.new(0, 30, 0, 30)
HideBtn.Position = UDim2.new(1, -35, 0, 2)
HideBtn.Text = "-"
HideBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
HideBtn.TextColor3 = Color3.new(1,1,1)
HideBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

-- ФУНКЦИЯ ДЛЯ КНОПОК
local function AddBtn(name, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    local BCorner = Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
end

-- 1. АВТО-ПОКУПКА (СНАЙПЕР)
local activeBuy = false
AddBtn("AUTO-BUY: OFF", 50, function(self)
    activeBuy = not activeBuy
    self.Text = activeBuy and "AUTO-BUY: ON" or "AUTO-BUY: OFF"
    self.BackgroundColor3 = activeBuy and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(60, 60, 60)
    
    task.spawn(function()
        while activeBuy do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") then 
                    fireclickdetector(v) 
                elseif v:IsA("ProximityPrompt") then 
                    v.HoldDuration = 0 
                    fireproximityprompt(v) 
                end
            end
            task.wait(0.1) -- Безопасная скорость для Delta
        end
    end)
end)

-- 2. ТЕЛЕПОРТ СКВОЗЬ СТЕНУ (ОБХОД АНОМАЛИИ)
AddBtn("ПРОЙТИ СКВОЗЬ СТЕНУ", 100, function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        -- Телепортируем игрока на 7 шагов вперед (проход сквозь стену)
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -7)
    end
end)

-- 3. ESP (ВИДЕТЬ ВРАГОВ)
AddBtn("ESP", 150, function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(255, 0, 0)
            h.OutlineColor = Color3.new(1,1,1)
        end
    end
end)

-- 4. ПЕРЕЗАЙТИ (REJOIN)
AddBtn("REJOIN", 200, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)

-- МАЛЕНЬКАЯ КНОПКА ОТКРЫТИЯ (ВСЕГДА ВИДНА)
local Open = Instance.new("TextButton", ScreenGui)
Open.Size = UDim2.new(0, 60, 0, 30)
Open.Position = UDim2.new(0, 10, 0, 150)
Open.BackgroundColor3 = Color3.new(0,0,0)
Open.Text = "TVVHO"
Open.TextColor3 = Color3.new(1,1,1)
Open.Draggable = true
local OCorner = Instance.new("UICorner", Open)

Open.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
