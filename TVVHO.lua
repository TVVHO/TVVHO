local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- МАКСИМАЛЬНО ГРОМКАЯ МУЗЫКА (Японский стиль)
local function playJapanMusic()
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://160223332" -- Мощный японский трек / Фонк-стиль
    s.Volume = 10 -- Усиление, чтобы перебить всё
    s.PlayOnRemove = true
    s:Play()
    task.delay(6, function() s:Stop(); s:Destroy() end)
end

-- ==========================================
-- КИБЕР-ЯПОНСКОЕ ИНТРО
-- ==========================================
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IntroFrame.ZIndex = 999

-- Японский текст
local JpText = Instance.new("TextLabel", IntroFrame)
JpText.Size = UDim2.new(1, 0, 1, -50)
JpText.BackgroundTransparency = 1
JpText.Text = "ようこそ、TVVHOの世界へ"
JpText.TextColor3 = Color3.fromRGB(255, 0, 50)
JpText.Font = Enum.Font.GothamBold
JpText.TextSize = 35
JpText.TextTransparency = 1
JpText.ZIndex = 1000

-- Текст перевода (ниже)
local RuText = Instance.new("TextLabel", IntroFrame)
RuText.Size = UDim2.new(1, 0, 1, 50)
RuText.BackgroundTransparency = 1
RuText.Text = "ДОБРО ПОЖАЛОВАТЬ В МИР TVVHO"
RuText.TextColor3 = Color3.fromRGB(255, 255, 255)
RuText.Font = Enum.Font.Code
RuText.TextSize = 12
RuText.TextTransparency = 1
RuText.ZIndex = 1000

-- Глитч-эффект (красная полоса)
local Glitch = Instance.new("Frame", IntroFrame)
Glitch.Size = UDim2.new(1, 0, 0, 100)
Glitch.Position = UDim2.new(0, 0, 0.45, 0)
Glitch.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
Glitch.BackgroundTransparency = 1
Glitch.BorderSizePixel = 0
Glitch.ZIndex = 998

local function StartCyberIntro()
    task.wait(0.5)
    playJapanMusic()
    
    -- Вспышка глитча
    TweenService:Create(Glitch, TweenInfo.new(0.1), {BackgroundTransparency = 0.7}):Play()
    task.wait(0.1)
    TweenService:Create(Glitch, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
    
    -- Появление японского текста
    TweenService:Create(JpText, TweenInfo.new(1.5), {TextTransparency = 0}):Play()
    task.wait(0.8)
    TweenService:Create(RuText, TweenInfo.new(1), {TextTransparency = 0}):Play()
    
    -- Тряска экрана (эффект мощи)
    for i = 1, 10 do
        JpText.Position = UDim2.new(0, math.random(-5, 5), 0, math.random(-5, 5))
        task.wait(0.05)
    end
    JpText.Position = UDim2.new(0, 0, 0, 0)
    
    task.wait(2.5)
    
    -- Растворение
    TweenService:Create(IntroFrame, TweenInfo.new(1.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(JpText, TweenInfo.new(1), {TextTransparency = 1}):Play()
    TweenService:Create(RuText, TweenInfo.new(1), {TextTransparency = 1}):Play()
    
    task.wait(1.5)
    IntroFrame:Destroy()
end

-- ==========================================
-- MAIN UI (С ТВОИМ НЕОНОМ)
-- ==========================================
-- [Весь остальной код твоего меню с 30 функциями и неоном остается здесь]
-- Не забудь добавить Main.Visible = false и Toggle.Visible = false изначально.

-- ЗАПУСК
task.spawn(StartCyberIntro)
task.wait(5.5)
-- Здесь появляется само меню (Main.Visible = true и т.д.)
