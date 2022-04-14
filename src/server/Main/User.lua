local User = {}
User.__index = User
-- User is a class that will contain all the information for each player and give the ability to save it/load it.
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

User.Cache = {}

local Server = ServerScriptService.Server.Main

local DataModule = require(Server.DataModule)

-- This will create the connection to make new User objects when a player joins.
function User.Init()
    Players.PlayerAdded:Connect(function(Player)
        local newUser = User.new(Player)
        User.Cache[tostring(Player.UserId)] = newUser
    end)

    Players.PlayerRemoving:Connect(function(Player)
        local _user = User.Cache[tostring(Player.UserId)]
        if not _user then return end

        _user:SaveData()
    end)
end

function User.Get(Player)
    return User.Cache[tostring(Player.UserId)]
end

-- User object constructor
function User.new(_Player)
    local self = setmetatable({}, User)

    self.Player = _Player
    self.UserId = _Player.UserId
    self.Data = {}

    self:LoadData()

    return self
end

function User:LoadData()
    self.Data = DataModule.Load(self.UserId)
end

function User:SaveData()
    self.Data = DataModule.Save(self.UserId, self.Data)
end

return User