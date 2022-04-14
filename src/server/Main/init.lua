local MainServer = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Util = require(ReplicatedStorage.Common.Util)

function MainServer.Init()
    Util.InitializeChildren(script)
end

return MainServer