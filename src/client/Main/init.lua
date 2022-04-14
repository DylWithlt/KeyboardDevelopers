local MainServer = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Util = require(ReplicatedStorage.Common.Util)

local UpdateClientData = Util.AwaitRemote("UpdateClientData")

MainServer.Client = nil

local UpdateBinds = {}
function MainServer.BindUpdate(func)
    table.insert(UpdateBinds, func)
end

function MainServer.UpdateData()
    for _, func in ipairs(UpdateBinds) do
        func(MainServer.Client)
    end
end

function MainServer.Init()
    UpdateClientData.OnClientEvent:Connect(function(_user)
        MainServer.Client = _user

        MainServer.UpdateData()
    end)

    Util.InitializeChildren(script)
end

return MainServer