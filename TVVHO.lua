-- TVVHO Ultra Realistic Graphics
local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace").Terrain

-- Очистка старых эффектов
for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("PostProcessEffect") then v:Destroy() end
end

-- 1. АТМОСФЕРА (Убирает плоский вид неба)
local Atmosphere = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere", Lighting)
Atmosphere.Density = 0.3
Atmosphere.Offset = 0.1
Atmosphere.Color = Color3.fromRGB(190, 190, 180) -- Теплый свет
Atmosphere.Decay = Color3.fromRGB(100, 105, 120) -- Голубоватый туман вдали
Atmosphere.Glare = 0.3
Atmosphere.Haze = 0.5

-- 2. ЦВЕТОКОРРЕКЦИЯ (Кинематографичный вид)
local CC = Instance.new("ColorCorrectionEffect", Lighting)
CC.Brightness = 0.02
CC.Contrast = 0.25 -- Глубокие черные тени
CC.Saturation = 0.15 -- Реалистичные, не "ядерные" цвета
CC.TintColor = Color3.fromRGB(255, 255, 250) -- Едва заметный теплый фильтр

-- 3. BLOOM (Мягкое освещение)
local Bloom = Instance.new("BloomEffect", Lighting)
Bloom.Intensity = 0.2 -- Минимум свечения для реализма
Bloom.Size = 12
Bloom.Threshold = 0.9

-- 4. DOF (Размытие как в кино)
local DOF = Instance.new("DepthOfFieldEffect", Lighting)
DOF.FarIntensity = 0.15
DOF.FocusDistance = 60
DOF.InFocusRadius = 40
DOF.NearIntensity = 0

-- 5. НАСТРОЙКИ СВЕТА
Lighting.GlobalShadows = true
Lighting.ShadowSoftness = 0.05 -- Четкие тени
Lighting.Brightness = 1.8
Lighting.EnvironmentDiffuseScale = 1 -- Отражение света от неба
Lighting.EnvironmentSpecularScale = 1 -- Блики на материалах
Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 75) -- Реалистичные тени

-- 6. ТЕКСТУРЫ ВОДЫ
Terrain.WaterReflectionSize = 1024
Terrain.WaterWaveSize = 0.2
Terrain.WaterWaveSpeed = 7
Terrain.WaterTransparency = 0.6
Terrain.WaterColor = Color3.fromRGB(60, 110, 130)

print("TVVHO Reality Engine Loaded!")
