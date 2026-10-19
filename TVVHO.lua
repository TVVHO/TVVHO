-- TVVHO Ultra Graphics Engine
local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace").Terrain

-- Удаляем старые эффекты, чтобы не лагало
for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("PostProcessEffect") then v:Destroy() end
end

-- 1. Настройка Bloom (Эффект HDR и свечения)
local Bloom = Instance.new("BloomEffect", Lighting)
Bloom.Intensity = 0.5
Bloom.Size = 18
Bloom.Threshold = 0.8

-- 2. ColorCorrection (Насыщенная и четкая картинка)
local CC = Instance.new("ColorCorrectionEffect", Lighting)
CC.Brightness = 0.05
CC.Contrast = 0.2
CC.Saturation = 0.35

-- 3. SunRays (Реалистичные лучи солнца)
local Sun = Instance.new("SunRaysEffect", Lighting)
Sun.Intensity = 0.15
Sun.Spread = 1

-- 4. DepthOfField (Размытие заднего фона, эффект камеры)
local DOF = Instance.new("DepthOfFieldEffect", Lighting)
DOF.FarIntensity = 0.1
DOF.FocusDistance = 50
DOF.InFocusRadius = 40

-- 5. Общие настройки Lighting (Тени и освещение)
Lighting.GlobalShadows = true
Lighting.ShadowSoftness = 0.1
Lighting.Brightness = 2.5
Lighting.ExposureCompensation = 0.5

-- 6. Улучшение текстур воды
Terrain.WaterReflectionSize = 1024
Terrain.WaterWaveSize = 0.15
Terrain.WaterWaveSpeed = 10
Terrain.WaterTransparency = 0.5

print("TVVHO Graphics Loaded!")
