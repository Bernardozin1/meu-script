--[[
 WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local image = "91425326664161" --put your id
local sound = "18925320031" --put your sound
local seconds = 4 --time to destroy the gui
local speed = 1 --audio playbackspeed, for bypass
local start = 0 --audio time position, for bypas to
local volume = 10 --audio volume

local jumpscare = Instance.new("ScreenGui")
jumpscare.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
jumpscare.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") --🧐🤨...localplayer?
local label = Instance.new("ImageLabel", jumpscare)
label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
label.BorderColor3 = Color3.fromRGB(0, 0, 0)
label.BorderSizePixel = 0
label.Size = UDim2.new(1, 0, 1, 0)
label.Image = "rbxassetid://"..image
local audio = Instance.new("Sound", game.SoundService)
audio.SoundId = "rbxassetid://"..sound
audio.PlaybackSpeed = speed
audio.TimePosition = start
audio.Volume = volume
audio:Play()
wait(seconds)

jumpscare:Destroy()
