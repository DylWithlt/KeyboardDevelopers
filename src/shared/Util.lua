local Util = {}
-- Module is used for useful functions in many places around the codebase.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- Finds all the children inside of a function and calls an Init function if it's found.
function Util.InitializeChildren(parent)
    for _, mod in ipairs(parent) do
        if not mod:IsA("ModuleScript") then continue end

        mod = require(mod)

        if not mod.Init then continue end
        mod.Init()
    end
end

-- Creates remotes
function Util.CreateRemote(name, type)
    local remote = Remotes:FindFirstChild(name)
    if remote then return remote end

    remote = Instance.new(type)
    remote.Name = name
    remote.Parent = Remotes
    return remote
end

-- Waits for a remote event to exist.
function Util.AwaitRemote(name)
    return Remotes:WaitForChild(name, 3)
end

return Util