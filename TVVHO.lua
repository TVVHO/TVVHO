-- КОНФИГУРАЦИЯ
local MY_KEY = "TVVHOGAMES009"

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Очистка старых меню
if pgui:FindFirstChild("TVVHO_FINAL") then pgui.TVVHO_FINAL:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "TVVHO_FINAL"

-- ОКНО КЛЮЧА
local KeyFrame = Instance.new("Frame", sg)
KeyFrame.Size = UDim2.new(0, 200, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyFrame.Active = true
KeyFrame.Draggable = true

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
KeyInput.Position = UDim2.new(0.1, 0, 0.2, 0)
KeyInput.PlaceholderText = "КЛЮЧ ТУТ..."
KeyInput.Text = ""

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.8, 0, 0, 30)
CheckBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
CheckBtn.Text = "ЗАПУСК"
CheckBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckBtn.TextColor3 = Color3.new(1, 1, 1)

-- ОСНОВНОЕ МЕНЮ (ПОЯВИТСЯ ПОСЛЕ КЛЮЧА)
local function StartScript()
    KeyFrame.Visible = false
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 180, 0, 220)
    frame.Position = UDim2.new(0.5, -90, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.Draggable = true

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = "TVVHO UNLOCKED"
    title.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
    title.TextColor3 = Color3.new(1,1,1)

    local function makeBtn(name, pos, callback)
        local b = Instance.new("TextButton", frame)
        b.Size = UDim2.new(0.9, 0, 0, 35)
        b.Position = UDim2.new(0.05, 0, 0, pos)
        b.Text = name
        b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        b.TextColor3 = Color3.new(1, 1, 1)
        b.MouseButton1Click:Connect(callback)
    end

    -- ТЕ САМЫЕ РАБОЧИЕ ФУНКЦИИ
    makeBtn("AUTO-STEAL", 40, function()
        _G.Steal = true
        while _G.Steal do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") then fireclickdetector(v)
                elseif v:IsA("ProximityPrompt") then v.HoldDuration = 0 fireproximityprompt(v) end
            end
            task.wait(0.1)
        end
    end)

    makeBtn("ESP (Players)", 85, function()
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character then
                local h = Instance.new("Highlight", p.Character)
                h.FillColor = Color3.fromRGB(255, 0, 0)
            end
        end
    end)

    makeBtn("NoClip Doors", 130, function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:lower():find("door") or v.Name:lower():find("gate")) then
                v.CanCollide = false
                v.Transparency = 0.5
            end
        end
    end)

    makeBtn("Anti-Knockback", 175, function()
        game:GetService("RunService").Heartbeat:Connect(function()
            if player.Character then player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0) end
        end)
    end)
end

-- ПРОВЕРКА КЛЮЧА
CheckBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == MY_KEY then
        StartScript()
    else
        CheckBtn.Text = "НЕВЕРНО!"
        wait(1)
        CheckBtn.Text = "ЗАПУСК"
    end
end)
