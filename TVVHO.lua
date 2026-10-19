-- Удаление старой версии
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
if pgui:FindFirstChild("TVVHO_MEGA") then pgui.TVVHO_MEGA:Destroy() end

-- Создание ГУИ
local sg = Instance.new("ScreenGui", pgui)
sg.Name = "TVVHO_MEGA"
sg.ResetOnSpawn = false

-- МАЛЕНЬКАЯ КНОПКА СКРЫТИЯ (ToggleButton)
local Toggle = Instance.new("TextButton", sg)
Toggle.Size = UDim2.new(0, 50, 0, 30)
Toggle.Position = UDim2.new(0, 10, 0.4, 0)
Toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Toggle.Text = "TVVHO"
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.Draggable = true
local ToggleCorner = Instance.new("UICorner", Toggle)

-- ГЛАВНОЕ МЕНЮ
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 230, 0, 450) -- Большая панель
frame.Position = UDim2.new(0.5, -115, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.Active = true
frame.Draggable = true
frame.Visible = true

local corner = Instance.new("UICorner", frame)
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "TVVHO MEGA HUB V5"
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.TextColor3 = Color3.new(0, 0.7, 1)

-- Логика кнопки скрыть/показать
Toggle.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Прокрутка кнопок (ScrollingFrame), чтобы влезло много функций
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, 0, 1, -40)
scroll.Position = UDim2.new(0, 0, 0, 40)
scroll.CanvasSize = UDim2.new(0, 0, 0, 650) -- Размер прокрутки
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 4

local function makeBtn(name, pos, callback)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold
    local bc = Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() callback(b) end)
end

-- 1. ЗАЩИТА ОТ УДАРОВ (GOD PROTECTION)
local godProtect = false
makeBtn("God Protection: OFF", 10, function(self)
    godProtect = not godProtect
    self.Text = godProtect and "God Protection: ON" or "God Protection: OFF"
    self.BackgroundColor3 = godProtect and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
    task.spawn(function()
        while godProtect do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (v.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if d < 12 then
                        v.Character.HumanoidRootPart.Velocity = (v.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Unit * 50
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- 2. KILL AURA (АВТО-УДАР)
local kAura = false
makeBtn("Kill Aura: OFF", 55, function(self)
    kAura = not kAura
    self.Text = kAura and "Kill Aura: ON" or "Kill Aura: OFF"
    task.spawn(function()
        while kAura do
            local tool = player.Character:FindFirstChildOfClass("Tool")
            if tool then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= player and v.Character and (v.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude < 15 then
                        tool:Activate()
                    end
                end
            end
            task.wait(0.2)
        end
    end)
end)

-- 3. INSTANT STEAL
local stealing = false
makeBtn("Instant Steal: OFF", 100, function(self)
    stealing = not stealing
    self.Text = stealing and "Instant Steal: ON" or "Instant Steal: OFF"
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

-- 4. SET BASE & AUTO RETURN
local basePos = nil
makeBtn("Set Base", 145, function(self)
    basePos = player.Character.HumanoidRootPart.CFrame
    self.Text = "Base Saved!"
    wait(1) self.Text = "Set Base"
end)

local aReturn = false
makeBtn("Auto Return: OFF", 190, function(self)
    aReturn = not aReturn
    self.Text = aReturn and "Auto Return: ON" or "Auto Return: OFF"
    task.spawn(function()
        while aReturn do
            if player.Character:FindFirstChildOfClass("Tool") and basePos then
                player.Character.HumanoidRootPart.CFrame = basePos
                wait(2)
            end
            task.wait(0.5)
        end
    end)
end)

-- 5. NOCLIP DOORS
makeBtn("NoClip Doors", 235, function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("door") or v.Name:lower():find("gate")) then
            v.CanCollide = false
            v.Transparency = 0.5
        end
    end
end)

-- 6. SPEED & JUMP
makeBtn("Speed Hack (35)", 280, function() player.Character.Humanoid.WalkSpeed = 35 end)
makeBtn("Infinite Jump", 325, function(self)
    self.Text = "Inf Jump: ON"
    game:GetService("UserInputService").JumpRequest:Connect(function()
        player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

-- 7. AUTO HEAL (Слот 3)
local aHeal = false
makeBtn("Auto Heal (Low HP): OFF", 370, function(self)
    aHeal = not aHeal
    task.spawn(function()
        while aHeal do
            if player.Character.Humanoid.Health < 40 then
                local med = player.Backpack:FindFirstChild("First Aid") or player.Character:FindFirstChild("First Aid")
                if med then player.Character.Humanoid:EquipTool(med) med:Activate() end
            end
            task.wait(1)
        end
    end)
end)

-- 8. ESP
makeBtn("Full ESP", 415, function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)

-- 9. ANTI-KNOCKBACK
makeBtn("Anti-Knockback", 460, function()
    game:GetService("RunService").Heartbeat:Connect(function()
        player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
    end)
end)

-- 10. REJOIN
makeBtn("Rejoin Server", 505, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end)
