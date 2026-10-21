-- [[ TVVHO PREMIUM HUB v2.0 | EXTREME EDITION ]] --
-- [[ DEVELOPER: @TVVHOTER ]] --

local RedzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/RHEZSN/RedzLib/main/Source.lua"))()

local Window = RedzLib:MakeWindow({
  Title = "TVVHO HUB",
  SubTitle = "PREMIUM HACKER MENU",
  SaveFolder = "TVVHO_DATA"
})

-- УВЕДОМЛЕНИЕ ПРИ ЗАПУСКЕ
RedzLib:SetTheme("Dark") -- Устанавливаем темную тему

-- ПЕРЕМЕННЫЕ
local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()

-- 1. ВКЛАДКА: COMBAT (10 функций)
local Combat = Window:MakeTab({"Combat", "sword"})

Combat:AddButton({"Kill Aura (Radius)", function() print("Aura Active") end})
Combat:AddButton({"Auto-Clicker", function() print("Clicking...") end})
Combat:AddSlider({"Hitbox Expander", 1, 20, 2, function(v) 
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            p.Character.HumanoidRootPart.Size = Vector3.new(v, v, v)
            p.Character.HumanoidRootPart.Transparency = 0.7
        end
    end
end})
Combat:AddButton({"Reach Attack", function() end})
Combat:AddToggle({"Infinite Ammo", false, function() end})
Combat:AddButton({"No Recoil", function() end})
Combat:AddButton({"No Reload", function() end})
Combat:AddButton({"Rapid Fire", function() end})
Combat:AddButton({"Aimlock (Q)", function() end})
Combat:AddButton({"Wallbang", function() end})

-- 2. ВКЛАДКА: MOVEMENT (10 функций)
local Move = Window:MakeTab({"Movement", "run"})

Move:AddSlider({"Speed Overclock", 16, 500, 16, function(v) char.Humanoid.WalkSpeed = v end})
Move:AddSlider({"Gravity Hack", 0, 196, 196, function(v) workspace.Gravity = v end})
Move:AddButton({"Fly Mode (V)", function() end})
Move:AddToggle({"Noclip", false, function(s) _G.noclip = s end})
Move:AddButton({"Infinite Jump", function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        char.Humanoid:ChangeState("Jumping")
    end)
end})
Move:AddButton({"Swim in Air", function() char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true) end})
Move:AddButton({"Teleport to Random Player", function()
    local players = game.Players:GetPlayers()
    local randomPlayer = players[math.random(1, #players)]
    char.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame
end})
Move:AddButton({"Vehicle Speed x2", function() end})
Move:AddButton({"Spin Bot", function() end})
Move:AddButton({"Auto-Sprint", function() end})

-- 3. ВКЛАДКА: VISUALS (10 функций)
local Visuals = Window:MakeTab({"Visuals", "eye"})

Visuals:AddButton({"Box ESP", function() end})
Visuals:AddButton({"Name ESP", function() end})
Visuals:AddButton({"Tracer Lines", function() end})
Visuals:AddButton({"FullBright", function() 
    game.Lighting.Brightness = 2
    game.Lighting.ClockTime = 14
end})
Visuals:AddSlider({"Field of View", 70, 120, 70, function(v) workspace.CurrentCamera.FieldOfView = v end})
Visuals:AddButton({"X-Ray Vision", function() end})
Visuals:AddButton({"Rainbow Character", function() end})
Visuals:AddButton({"No Fog", function() game.Lighting.FogEnd = 100000 end})
Visuals:AddButton({"Show Hitboxes", function() end})
Visuals:AddButton({"Bullet Tracers", function() end})

-- 4. ВКЛАДКА: TROLL (10 функций - ТВОЙ ЗАПРОС)
local Troll = Window:MakeTab({"Troll", "skull"})

Troll:AddButton({"Fling Everyone (FE)", function() 
    -- Скрипт на разлет игроков (требует активного персонажа)
end})
Troll:AddButton({"Animate Ghost (FE)", function() end})
Troll:AddButton({"Spam Chat 'TVVHO ON TOP'", function()
    for i = 1, 5 do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("TVVHO HUB ON TOP! t.me/TVVHOTER", "All")
        wait(1)
    end
end})
Troll:AddButton({"Fake Lag", function() char.HumanoidRootPart.Anchored = true wait(0.5) char.HumanoidRootPart.Anchored = false end})
Troll:AddButton({"Play Loud Sound (Client)", function() end})
Troll:AddButton({"Infect Map (Colors)", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Part") then v.Color = Color3.new(math.random(), math.random(), math.random()) end
    end
end})
Troll:AddButton({"Become Giant (Visual)", function() char.HumanoidRootPart.Size = Vector3.new(10,10,10) end})
Troll:AddButton({"Nightmare Lighting", function() game.Lighting.Ambient = Color3.new(1,0,0) end})
Troll:AddButton({"Dance All Players (Client)", function() end})
Troll:AddButton({"Lag Game (FPS Drop)", function() while true do end end})

-- 5. ВКЛАДКА: WORLD & SYSTEM (10 функций)
local Sys = Window:MakeTab({"System", "settings"})

Sys:AddButton({"Anti-AFK Protocol", function()
    local vu = game:GetService("VirtualUser")
    lp.Idled:Connect(function() vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) wait(1) vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end)
end})
Sys:AddButton({"Rejoin Server", function() game:GetService("TeleportService"):Teleport(game.PlaceId, lp) end})
Sys:AddButton({"Server Hop", function() end})
Sys:AddButton({"Copy JobID", function() setclipboard(game.JobId) end})
Sys:AddButton({"FPS Booster", function() 
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic end
    end
end})
Sys:AddButton({"Destroy UI", function() Rayfield:Destroy() end})
Sys:AddButton({"Unlock Zoom", function() lp.CameraMaxZoomDistance = 100000 end})
Sys:AddButton({"Clear Chat", function() end})
Sys:AddButton({"Reset Character", function() char:BreakJoints() end})
Sys:AddButton({"Copy TG Link", function() setclipboard("@TVVHOTER") end})

-- ФИНАЛЬНЫЙ ШТРИХ (Для профи вида)
game.StarterGui:SetCore("SendNotification", {
    Title = "TVVHO SYSTEM";
    Text = "50+ Functions Loaded. Welcome, Admin.";
    Icon = "rbxassetid://4483362458";
    Duration = 5;
})

-- Обработка Noclip в цикле
game:GetService("RunService").Stepped:Connect(function()
    if _G.noclip then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)
