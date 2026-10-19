-- УДАЛЯЕМ СТАРЫЕ ГУИ ЕСЛИ ЕСТЬ
if game.CoreGui:FindFirstChild("TVVHO_FIX") then game.CoreGui.TVVHO_FIX:Destroy() end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "TVVHO_FIX"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 180, 0, 220)
MainFrame.Position = UDim2.new(0.5, -90, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true -- Можно двигать!

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "TVVHO ULTIMATE"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- ФУНКЦИЯ СОЗДАНИЯ КНОПОК
local function CreateBtn(name, pos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 1. АВТО-ПОКУПКА (НОВЫЙ МЕТОД)
local buying = false
local buyBtn = CreateBtn("AutoBuy: OFF", 40, function()
    buying = not buying
    _G.btnText = buying and "AutoBuy: ON" or "AutoBuy: OFF"
    script.Parent.Text = _G.btnText -- Обновление текста
end)

task.spawn(function()
    while task.wait(0.01) do
        if buying then
            for _, v in pairs(workspace:GetDescendants()) do
                -- Пытаемся нажать всеми способами сразу
                if v:IsA("ClickDetector") then 
                    fireclickdetector(v) 
                elseif v:IsA("ProximityPrompt") then 
                    v.HoldDuration = 0
                    fireproximityprompt(v)
                end
            end
        end
    end
end)

-- 2. GOD MODE (НОВЫЙ МЕТОД)
CreateBtn("GOD MODE (Active)", 85, function()
    local lp = game.Players.LocalPlayer
    if lp.Character then
        lp.Character.Humanoid.MaxHealth = 999999
        lp.Character.Humanoid.Health = 999999
    end
    -- Защита от турелей (удаляем пули, которые летят в нас, если они объекты)
    game:GetService("RunService").Stepped:Connect(function()
        for _, part in pairs(workspace:GetChildren()) do
            if part:IsA("BasePart") and (part.Name:find("Bullet") or part.Name:find("Projectile")) then
                if (part.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 10 then
                    part.CanCollide = false
                    part.CFrame = CFrame.new(0, -500, 0) -- Прячем пули под карту
                end
            end
        end
    end)
end)

-- 3. ESP
CreateBtn("ESP", 130, function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)

-- КНОПКА ЗАКРЫТИЯ
local close = Instance.new("TextButton", MainFrame)
close.Size = UDim2.new(0, 20, 0, 20)
close.Position = UDim2.new(1, -20, 0, 0)
close.Text = "-"
close.BackgroundColor3 = Color3.new(0.5, 0, 0)
close.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    -- Тут можно добавить маленькую кнопку открытия
end)

print("TVVHO LOADED")
