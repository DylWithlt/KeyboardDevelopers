-- This script is to do some pre-setup for the codebase and then initialize the main module.
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = Instance.new("Folder")
Remotes.Name = "Remotes"
Remotes.Parent = ReplicatedStorage

require(script.Main).Init()