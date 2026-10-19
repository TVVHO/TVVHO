-- Очистка старого меню
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
if pgui:FindFirstChild("TVVHO_ULTRA") then pgui.TVVHO_ULTRA:Destroy() end

-- Создание интерфейса (в PlayerGui для 100% запуска)
local sg = Instance.new("ScreenGui", pgui)
sg.Name = "TVVHO_ULTRA"
sg.ResetOnSpawn = false

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 220, 0, 350) -- Увеличил высоту для новых кнопок
frame.Position = UDim2.new(0.5, -110, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "TVVHO ULTIMATE V3"
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.TextColor3 = Color3.new(1, 1, 1)
local tcorner = Instance.new("UICorner", title)

-- Функция для кнопок
local function makeBtn(name, pos, callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0.9, 0, 0, 32)
    b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 14
    local bc = Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() callback(b) end)
end

-- 1. INSTANT STEAL (СНАЙПЕР)
local stealing = false
makeBtn("Instant Steal: OFF", 45, function(self)
    stealing = not stealing
    self.Text = stealing and "Instant Steal: ON" or "Instant Steal: OFF"
    self.BackgroundColor3 = stealing and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
    task.spawn(function()
        while stealing do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") then fireclickdetector(v)
                elseif v:IsA("ProximityPrompt") then v.HoldDuration = 0 fireproximityprompt(v) end
            end
            task.wait(0.1)
        end
    end)
end)

-- 2. SET BASE (ТОЧКА ВОЗВРАТА)
local basePos = nil
makeBtn("Set Base (Home)", 85, function(self)
    basePos = player.Character.HumanoidRootPart.CFrame
    self.Text = "Base Saved!"
    task.wait(1)
    self.Text = "Set Base (Home)"
end)

-- 3. AUTO-RETURN (ТП ДОМОЙ С ЛУТОМ)
local autoReturn = false
makeBtn("Auto-Return: OFF", 125, function(self)
    autoReturn = not autoReturn
    self.Text = autoReturn and "Auto-Return: ON" or "Auto-Return: OFF"
    self.BackgroundColor3 = autoReturn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
    task.spawn(function()
        while autoReturn do
            -- Проверка: держит ли игрок что-то в руках (добычу)
            if player.Character:FindFirstChildOfClass("Tool") and basePos then
                player.Character.HumanoidRootPart.CFrame = basePos
                task.wait(2) -- Пауза, чтобы не кикнуло за спам ТП
            end
            task.wait(0.5)
        end
    end)
end)

-- 4. NOCLIP DOORS (ПРОХОД СКВОЗЬ ДВЕРИ)
local noclipDoors = false
makeBtn("NoClip Doors: OFF", 165, function(self)
    noclipDoors = not noclipDoors
    self.Text = noclipDoors and "NoClip Doors: ON" or "NoClip Doors: OFF"
    self.BackgroundColor3 = noclipDoors and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
    task.spawn(function()
        while noclipDoors do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:lower():find("door") or v.Name:lower():find("gate")) then
                    v.CanCollide = false
                    v.Transparency = 0.6
                end
            end
            task.wait(1)
        end
    end)
end)

-- 5. ANTI-KNOCKBACK (УСТОЙЧИВОСТЬ)
makeBtn("Anti-Knockback", 205, function(self)
    self.Text = "Anti-Knockback: ON"
    self.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    game:GetService("RunService").Heartbeat:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        end
    end)
end)

-- 6. FULL ESP
makeBtn("Full ESP", 245, function(self)
    self.Text = "ESP Active"
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(255, 0, 0)
            local b = Instance.new("BillboardGui", p.Character.Head)
            b.Size = UDim2.new(0, 100, 0, 50)
            b.AlwaysOnTop = true
            local tl = Instance.new("TextLabel", b)
            tl.Size = UDim2.new(1, 0, 1, 0)
            tl.Text = p.Name
            tl.TextColor3 = Color3.new(1, 1, 1)
            tl.BackgroundTransparency = 1
        end
    end
end)

-- 7. REJOIN
makeBtn("Rejoin Server", 285, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end)

-- Закрытие
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0, 5)
close.Text = "X"
close.BackgroundColor3 = Color3.new(0.6, 0, 0)
close.MouseButton1Click:Connect(function() sg:Destroy() end)
