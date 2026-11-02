-- || !!!WARNING DONT MODIFY  ON/OFF TEXT VALUES!!! || --
local off = "false"
local on = "true"

-- || Settings || --
local cooldown = 3
local addsound = off
local disconnectiflevel = off

-- || Level Settings || --
local levelvalue = 7

-- || Sound settings || --
local soundid = ""
local soundvolume = 5

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://" .. soundid
sound.Volume = math.clamp(soundvolume, 0, 10)
sound.Looped = false
sound.Parent = SoundService

local running = true

local function disconnect()
    running = false
    sound:Stop()
    sound:Destroy()
end

while running do
    local found = false

    for _, player in ipairs(Players:GetPlayers()) do
        local stats = player:FindFirstChild("CustomLeaderstats")
        local level = stats and stats:FindFirstChild("Level")

        if level and level.Value >= levelvalue then
            found = true
            break
        end
    end

    if found then
        if disconnectiflevel == on then
            disconnect()
            break
        elseif addsound == on and not sound.IsPlaying then
            sound:Play()
        end
    end

    task.wait(cooldown)
end

if sound.Parent then
    sound:Destroy()
end
