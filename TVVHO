local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "💠 TVVHO Visuals | NextGen Graphics",
   LoadingTitle = "Загрузка шейдеров TVVHO...",
   LoadingSubtitle = "by TBBXO",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "TVVHO_Settings",
      FileName = "ShaderConfig"
   },
   KeySystem = false -- Система ключей выключена для удобства
})

local MainTab = Window:CreateTab("🎨 Основные Шейдеры", 4483362458) -- Иконка кисти
local VisualsSection = MainTab:CreateSection("Настройка картинки")

-- Сервисы освещения
local Lighting = game:GetService("Lighting")
local ColorCorr = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
local Bloom = Lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", Lighting)

MainTab:CreateSlider({
   Name = "Насыщенность (Saturation)",
   Range = {-1, 1},
   Increment = 0.1,
   Suffix = "S",
   CurrentValue = 0,
   Callback = function(Value)
      ColorCorr.Saturation = Value
   end,
})

MainTab:CreateSlider({
   Name = "Контраст (Contrast)",
   Range = {-1, 1},
   Increment = 0.1,
   Suffix = "C",
   CurrentValue = 0,
   Callback = function(Value)
      ColorCorr.Contrast = Value
   end,
})

MainTab:CreateSlider({
   Name = "Мягкий свет (Bloom)",
   Range = {0, 10},
   Increment = 0.5,
   Suffix = "B",
   CurrentValue = 1,
   Callback = function(Value)
      Bloom.Intensity = Value
   end,
})

local EffectsTab = Window:CreateTab("✨ Эффекты", 4483345998) -- Иконка звезд
local EffectSection = EffectsTab:CreateSection("Дополнительно")

EffectsTab:CreateToggle({
   Name = "Солнечные лучи (SunRays)",
   CurrentValue = false,
   Flag = "SunRaysToggle",
   Callback = function(Value)
      local sun = Lighting:FindFirstChildOfClass("SunRaysEffect") or Instance.new("SunRaysEffect", Lighting)
      sun.Enabled = Value
      sun.Intensity = 0.1
   end,
})

EffectsTab:CreateToggle({
   Name = "Размытие (Depth of Field)",
   CurrentValue = false,
   Flag = "DOF",
   Callback = function(Value)
      local dof = Lighting:FindFirstChildOfClass("DepthOfFieldEffect") or Instance.new("DepthOfFieldEffect", Lighting)
      dof.Enabled = Value
      dof.FarIntensity = 0.5
      dof.FocusDistance = 50
   end,
})

local PresetsTab = Window:CreateTab("💾 Пресеты", 4483362458)

PresetsTab:CreateButton({
   Name = "Ультра Реализм (RTX)",
   Callback = function()
      ColorCorr.Saturation = 0.2
      ColorCorr.Contrast = 0.15
      Bloom.Intensity = 0.5
      Lighting.Brightness = 2
      Rayfield:Notify({Title = "Пресет применен", Content = "Установлены настройки RTX", Duration = 3})
   end,
})

PresetsTab:CreateButton({
   Name = "Сброс настроек",
   Callback = function()
      ColorCorr.Saturation = 0
      ColorCorr.Contrast = 0
      Bloom.Intensity = 1
      Lighting.Brightness = 2
      Rayfield:Notify({Title = "Сброс", Content = "Стандартная графика", Duration = 3})
   end,
})

Rayfield:Notify({
   Title = "Готово!",
   Content = "Скрипт TVVHO успешно загружен",
   Duration = 5,
   Image = 4483345998,
})
