local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("TVVHO - Steal Master", "DarkTheme")

-- СОЗДАНИЕ КНОПКИ ЗАКРЫТИЯ/ОТКРЫТИЯ (ДЛЯ МОБИЛОК)
local OpenCloseGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

OpenCloseGui.Name = "TVVHO_Toggler"
OpenCloseGui.Parent = game.CoreGui

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = OpenCloseGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 150) -- Слева сбоку
ToggleButton.Size = UDim2.new(0, 60, 0, 30)
ToggleButton.Text = "TVVHO"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Draggable = true -- Можно двигать пальцем по экрану!

local isOpen = true
ToggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    -- Ищем основное окно чита и скрываем его
    for _, v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "TVVHO - Steal Master" then
            v.Enabled = isOpen
        end
    end
end)

-- ДАЛЕЕ ТВОИ ВКЛАДКИ
local Main = Window:NewTab("Снайпер")
local Section = Main:NewSection("Авто-кража")

Section:NewToggle("AUTO-BUY (Ultra)", "Забирает лут быстрее всех", function(state)
    _G.AutoBuy = state
    task.spawn(function()
        while _G.AutoBuy do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") then fireclickdetector(v) end
                if v:IsA("ProximityPrompt") then 
                    v.HoldDuration = 0 
                    fireproximityprompt(v) 
                end
            end
            task.wait(0.01)
        end
    end)
end)

local Visuals = Window:NewTab("Визуалы")
local VSection = Visuals:NewSection("ESP")

VSection:NewToggle("ESP (Игроки)", "Видеть воров", function(state)
    _G.ESP = state
    while _G.ESP do
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character and not p.Character:FindFirstChild("Highlight") then
                Instance.new("Highlight", p.Character).FillColor = Color3.fromRGB(255, 0, 0)
            end
        end
        task.wait(2)
    end
end)
