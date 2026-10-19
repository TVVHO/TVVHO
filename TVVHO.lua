local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local RunService = game:GetService("RunService")

-- Создание GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 220, 0, 350)
main.Position = UDim2.new(0.5, -110, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.Active = true
main.Draggable = true -- Позволяет двигать окно пальцем
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local list = Instance.new("UIListLayout", main)
list.Padding = UDim.new(0, 5)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function addButton(text, callback)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 255, 0)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
end

-- Переменные функций
local flying = false
local bodyVel

-- Логика функций
addButton("Fly (Toggle)", function()
    flying = not flying
    if flying then
        bodyVel = Instance.new("BodyVelocity", player.Character.HumanoidRootPart)
        bodyVel.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVel.Velocity = Vector3.new(0, 0, 0)
    elseif bodyVel then
        bodyVel:Destroy()
    end
end)

addButton("Aimbot (Head)", function()
    local closest, min = nil, math.huge
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
            local dist = (p.Character.Head.Position - player.Character.Head.Position).Magnitude
            if dist < min then closest = p; min = dist end
        end
    end
    if closest then
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closest.Character.Head.Position)
    end
end)

addButton("Speed x2", function() player.Character.Humanoid.WalkSpeed = 32 end)
addButton("Reset", function() player.Character.Humanoid.WalkSpeed = 16; if bodyVel then bodyVel:Destroy() end end)
addButton("Close Menu", function() screenGui:Destroy() end)
