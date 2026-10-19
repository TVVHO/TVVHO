-- Вкладка Автоматизация
local AutoTab = Window:CreateTab("Автоматизация", 4483362458)

local AutoProximity = false
AutoTab:CreateToggle({
   Name = "Auto Proximity Prompt (Быстрое E)",
   CurrentValue = false,
   Callback = function(Value)
      AutoProximity = Value
      task.spawn(function()
         while AutoProximity do
            -- Ищем все объекты взаимодействия в радиусе 20 блоков
            for _, prompt in pairs(workspace:GetDescendants()) do
               if prompt:IsA("ProximityPrompt") then
                  -- Убираем задержку (делаем моментальным)
                  prompt.HoldDuration = 0
                  -- Если игрок рядом — активируем
                  local player = game.Players.LocalPlayer
                  if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                     local dist = (prompt.Parent:IsA("Model") and prompt.Parent:GetModelCFrame().Position or prompt.Parent.Position - player.Character.HumanoidRootPart.Position).Magnitude
                     if dist < 15 then -- Радиус срабатывания
                        fireproximityprompt(prompt)
                     end
                  end
               end
            end
            task.wait(0.1) -- Скорость проверки (можно меньше, но может лагать)
         end
      end)
   end,
})

AutoTab:CreateToggle({
   Name = "Auto Clicker (Кликер)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoClick = Value
      task.spawn(function()
         while _G.AutoClick do
            local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then
               tool:Activate()
            end
            task.wait(0.01)
         end
      end)
   end,
})

AutoTab:CreateButton({
   Name = "Удалить задержку нажатия (Instant Interact)",
   Callback = function()
      for _, v in pairs(workspace:GetDescendants()) do
         if v:IsA("ProximityPrompt") then
            v.HoldDuration = 0
         end
      end
      Rayfield:Notify({Title = "TVVHO", Content = "Теперь все кнопки 'E' нажимаются мгновенно!", Duration = 3})
   end,
})
