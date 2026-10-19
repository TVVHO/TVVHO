lua
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "💎 TVVHO HUB | Steal Loot Edition",
   LoadingTitle = "Запуск Снайпера Покупок...",
   LoadingSubtitle = "by TVVHO",
})

-- ВКЛАДКА: СНАЙПЕР (Самое важное для этого плейса)
local SniperTab = Window:CreateTab("Снайпер Покупок", 4483362458)

local AutoBuy = false
SniperTab:CreateToggle({
   Name = "AUTO-BUY: Забирать всё первым",
   CurrentValue = false,
   Callback = function(Value)
      AutoBuy = Value
      task.spawn(function()
         while AutoBuy do
            -- Ищем ClickDetector (та самая рука на экране)
            for _, v in pairs(workspace:GetDescendants()) do
               if v:IsA("ClickDetector") then
                  -- Проверяем, что это не дверь и не мусор (можно настроить)
                  -- Дистанция клика в этом плейсе важна
                  fireclickdetector(v)
               end
            end
            task.wait(0.01) -- Скорость сканирования (бешеная)
         end
      end)
   end,
})

SniperTab:CreateButton({
   Name = "Мгновенное использование (E)",
   Callback = function()
      for _, v in pairs(workspace:GetDescendants()) do
         if v:IsA("ProximityPrompt") then
            v.HoldDuration = 0
         end
      end
   end,
})

-- ВКЛАДКА: ЗАЩИТА БАЗЫ
local DefenseTab = Window:CreateTab("Защита", 4483362458)

DefenseTab:CreateToggle({
   Name = "Подсветка воров (ESP)",
   CurrentValue = false,
   Callback = function(Value)
      _G.PlayerESP = Value
      while _G.PlayerESP do
         for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character and not p.Character:FindFirstChild("Highlight") then
               local h = Instance.new("Highlight", p.Character)
               h.FillColor = Color3.fromRGB(255, 0, 0)
            end
         end
         task.wait(2)
      end
   end,
})

-- ВКЛАДКА: ПЕРСОНАЖ
local PlayerTab = Window:CreateTab("Игрок", 4483345998)

PlayerTab:CreateSlider({
   Name = "Скорость (WalkSpeed)",
   Range = {16, 150},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

PlayerTab:CreateButton({
   Name = "Fly (Полет для набегов)",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
   end,
})

-- УВЕДОМЛЕНИЕ О ЗАПУСКЕ
Rayfield:Notify({
   Title = "TVVHO АКТИВИРОВАН",
   Content = "Включи 'AUTO-BUY', чтобы забирать вещи за 0.01 сек!",
   Duration = 5,
})
