local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("TVVHO - Sniper & God", "DarkTheme")

-- ВКЛАДКА ГЛАВНАЯ
local Main = Window:NewTab("Главная")
local Section = Main:NewSection("Автоматизация")

_G.AutoClick = false
Section:NewToggle("АВТО-ПОКУПКА (Ultra)", "Забирает лут быстрее всех", function(state)
    _G.AutoClick = state
    task.spawn(function()
        while _G.AutoClick do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") then fireclickdetector(v) end
                if v:IsA("ProximityPrompt") then 
                    v.HoldDuration = 0 
                    fireproximityprompt(v) 
                end
            end
            task.wait(0.05)
        end
    end)
end)

-- ВКЛАДКА ЗАЩИТА
local Protect = Window:NewTab("Защита")
local PSection = Protect:NewSection("Бессмертие")

PSection:NewButton("GOD MODE (Бессмертие)", "Зомби и турели не наносят урон", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    -- Этот метод удаляет обработчик урона на стороне клиента
    if character:FindFirstChild("Humanoid") then
        character.Humanoid.Name = "TVVHO_Humanoid" -- Обман системы игры
    end
    
    local newHumanoid = character["TVVHO_Humanoid"]:Clone()
    newHumanoid.Name = "Humanoid"
    newHumanoid.Parent = character
    character["TVVHO_Humanoid"]:Destroy()
    
    workspace.CurrentCamera.CameraSubject = character.Humanoid
    
    Rayfield:Notify({Title = "TVVHO", Content = "Бессмертие включено!", Duration = 3})
end)

PSection:NewToggle("Анти-Замедление", "Всегда быстрая скорость", function(state)
    _G.NoSlow = state
    task.spawn(function()
        while _G.NoSlow do
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 30
            end
            task.wait(0.5)
        end
    end)
end)

-- ВКЛАДКА ВИЗУАЛЫ
local Visuals = Window:NewTab("Визуалы")
local VSection = Visuals:NewSection("ESP")

_G.ESP = false
VSection:NewToggle("ESP (Красные силуэты)", "Видеть игроков", function(state)
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

VSection:NewButton("Убрать туман и тени", function()
    game:GetService("Lighting").FogEnd = 100000
    game:GetService("Lighting").GlobalShadows = false
end)
