
-- TVVHO ANTICHEAT LAB
-- Local test monitor for Roblox
-- Run as a LocalScript in your own test environment.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "TVVHO_TestMonitor"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(280, 245)
frame.Position = UDim2.new(0.5, -140, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(5, 12, 8)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 255, 100)
stroke.Thickness = 2
stroke.Parent = frame

local function label(text, y, height)
    local l = Instance.new("TextLabel")
    l.Position = UDim2.fromOffset(12, y)
    l.Size = UDim2.new(1, -24, 0, height or 30)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(0, 255, 100)
    l.Font = Enum.Font.Code
    l.TextSize = 14
    l.TextWrapped = true
    l.Parent = frame
    return l
end

local function button(text, y, callback)
    local b = Instance.new("TextButton")
    b.Position = UDim2.fromOffset(12, y)
    b.Size = UDim2.new(1, -24, 0, 36)
    b.BackgroundColor3 = Color3.fromRGB(12, 35, 20)
    b.TextColor3 = Color3.fromRGB(180, 255, 200)
    b.Text = text
    b.Font = Enum.Font.Code
    b.TextSize = 13
    b.Parent = frame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = b

    b.Activated:Connect(callback)
    return b
end

label("TVVHO // ANTICHEAT LAB", 8, 28)
local status = label("STATUS: READY", 39, 25)
local log = label("No test recorded.", 66, 40)

local startedAt
local function recordResult(text)
    local elapsed = startedAt and
        string.format("%.1f sec", os.clock() - startedAt) or "N/A"
    log.Text = text .. "\nElapsed: " .. elapsed
end

button("START FLY TEST", 112, function()
    startedAt = os.clock()
    status.Text = "STATUS: TEST RUNNING"
    recordResult("Observe server anti-cheat")
end)

button("RECORD: KICKED", 154, function()
    status.Text = "STATUS: KICK OBSERVED"
    recordResult("Manual result: kicked")
end)

button("RECORD: NOT KICKED", 196, function()
    status.Text = "STATUS: STILL IN GAME"
    recordResult("Manual result: not kicked")
end)
