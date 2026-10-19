local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "💎 TVVHO Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "TVVHO_Config"})

-- ВКЛАДКА КРАЖА
local StealTab = Window:MakeTab({
 Name = "Кража",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

StealTab:AddToggle({
 Name = "AUTO-BUY (Снайпер)",
 Default = false,
 Callback = function(Value)
  _G.AutoBuy = Value
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
 end    
})

-- ВКЛАДКА ОБХОД (АНТИ-АНОМАЛИЯ)
local AntiTab = Window:MakeTab({
 Name = "Обход",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

AntiTab:AddButton({
 Name = "TP-Noclip (Сквозь стены)",
 Callback = function()
        -- Метод обхода: толкаем персонажа вперед через стену
  local char = game.Players.LocalPlayer.Character
  if char then
   char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + char.HumanoidRootPart.CFrame.LookVector * 5
  end
 end
})

AntiTab:AddToggle({
 Name = "Удалить коллизию стен",
 Default = false,
 Callback = function(Value)
  _G.NoCol = Value
  task.spawn(function()
   while _G.NoCol do
    for _, v in pairs(workspace:GetDescendants()) do
     if v:IsA("BasePart") and v.Name == "Wall" or v.Name == "Fence" then
      v.CanCollide = false
     end
    end
    task.wait(1)
   end
  end)
 end
})

-- ВКЛАДКА ВИЗУАЛЫ
local VisualTab = Window:MakeTab({
 Name = "Визуалы",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

VisualTab:AddButton({
 Name = "Включить ESP",
 Callback = function()
  for _, p in pairs(game.Players:GetPlayers()) do
   if p ~= game.Players.LocalPlayer and p.Character then
    local h = Instance.new("Highlight", p.Character)
    h.FillColor = Color3.fromRGB(255, 0, 0)
   end
  end
 end
})

OrionLib:Init()
-- Чтобы закрыть меню, в Orion обычно есть кнопка в углу или можно нажать на иконку
