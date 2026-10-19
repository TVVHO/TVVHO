--[[
    TVVHO V7: PRO EDITION
    Уровень: Платный (Open Source)
    Метод: Remote Interception & Optimized Loops
]]

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
if pgui:FindFirstChild("TVVHO_PRO") then pgui.TVVHO_PRO:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "TVVHO_PRO"
sg.ResetOnSpawn = false

-- ГЛАВНАЯ ПАНЕЛЬ С ДИЗАЙНОМ
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 250, 0, 480)
frame.Position = UDim2.new(0.5, -125, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local UICorner = Instance.new("UICorner", frame)
UICorner.CornerRadius = UDim.new(0, 15)

-- ЗАГОЛОВОК (PRO STYLE)
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "TVVHO V7 [PRO]"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, 0, 1, -45)
scroll.Position = UDim2.new(0, 0, 0, 45)
scroll.CanvasSize = UDim2.new(0, 0, 0, 800)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 2

local function addModule(name, pos, callback)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(0.9, 0, 0, 38)
    b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSans
    b.TextSize = 16
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() callback(b) end)
end

-- 1. REMOTE SNIPER (Самый мощный метод)
local remoteSniper = false
addModule("REMOTE SNIPER: OFF", 10, function(self)
    remoteSniper = not remoteSniper
    self.Text = remoteSniper and "SNIPER: ACTIVE" or "REMOTE SNIPER: OFF"
    self.BackgroundColor3 = remoteSniper and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(30, 30, 35)
    
    task.spawn(function()
        while remoteSniper do
            -- Ищем все события взаимодействия в игре
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
                    -- Прямой вызов события без анимации и задержки
                    if v:IsA("ClickDetector") then fireclickdetector(v)
                    else v.HoldDuration = 0 fireproximityprompt(v) end
                end
            end
            task.wait(0.001) -- Максимальная скорость
        end
    end)
end)

-- 2. SILENT STEAL (ТП к луту и обратно)
addModule("SILENT RAID (Auto-TP)", 55, function()
    local oldPos = player.Character.HumanoidRootPart.CFrame
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Loot" or v.Name == "Treasure" then -- Названия зависят от игры
            player.Character.HumanoidRootPart.CFrame = v.CFrame
            wait(0.1)
            -- Сюда можно добавить нажатиеplayer.Character.HumanoidRootPart.CFrame = oldPos
            break
        end
    end
end)

-- 3. GOD PROTECTION + ANTI-STUN
addModule("ULTRA DEFENSE", 100, function(self)
    self.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    task.spawn(function()
        game:GetService("RunService").Heartbeat:Connect(function()
            -- Убираем станы, замедления и откидывания на уровне физики
            if player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.PlatformStand = false
                player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            end
        end)
    end)
end)

-- 4. SMART ESP (NAME, DIST, VALUE)
addModule("SMART ESP", 145, function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            local highlight = Instance.new("Highlight", p.Character)
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            -- Надпись с дистанцией
            local bg = Instance.new("BillboardGui", p.Character.Head)
            bg.Size = UDim2.new(0, 100, 0, 50)
            bg.AlwaysOnTop = true
            local tl = Instance.new("TextLabel", bg)
            tl.Size = UDim2.new(1,0,1,0)
            tl.BackgroundTransparency = 1
            tl.TextColor3 = Color3.new(1,1,1)
            task.spawn(function()
                while bg.Parent do
                    local d = (p.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    tl.Text = p.Name .. " [" .. math.floor(d) .. "m]"
                    wait(1)
                end
            end)
        end
    end
end)

-- 5. FPS BOOSTER (Для слабых тел)
addModule("FPS BOOST (No Textures)", 190, function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end
    end
end)

-- 6. КНОПКА СКРЫТЬ (ToggleButton)
local Tog = Instance.new("TextButton", sg)
Tog.Size = UDim2.new(0, 40, 0, 40)
Tog.Position = UDim2.new(0, 5, 0.5, 0)
Tog.Text = "TV"
Tog.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
Tog.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Tog).CornerRadius = UDim.new(1, 0)
Tog.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)
