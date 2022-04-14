local DataModule = {}
-- This is for saving and loading data for players, also for getting leaderboard information.

local DataStoreService = game:GetService("DataStoreService")

-- !! WARNING !! RESET VARIABLE
local RESET_VAR = "v1" -- Change to reset all data in the game.
-- !! WARNING !! RESET VARIABLE

local LeaderBoards = {"Runes", "Gems", "Level", "RobuxSpent", "MobsKilled", "TimeSpent"}

DataModule.OrderedDataStores = {}

function DataModule.Init()
    for _, board in ipairs(LeaderBoards) do
        DataModule.OrderedDataStores[board] = DataStoreService:GetOrderedDataStore(board..RESET_VAR, "leaderboard")
    end
end

local UserDataStore = DataStoreService:GetDataStore("UserDataStore_"..RESET_VAR)

-- Default User Data
local Default_User_Data = {
    Runes = 0,
    Gems = 0,
    Level = 0,
    RobuxSpent = 0,
    MobsKilled = 0,
    TimeSpent = 0,
    UnlockedSwords = {},
    UnlockedItems = {},
}

function DataModule.Load(userId)
    local succ, data

    repeat 
        succ, data = pcall(function()
            return UserDataStore:GetAsync(userId)
        end)
    until succ

    if not data then
        data = Default_User_Data
        DataModule.Save(userId, data)
    end

    return data
end

function DataModule.Save(userId, data)
    local succ

    repeat
        succ = pcall(function()
            UserDataStore:SetAsync(userId, data)
        end)
    until succ

    for board, leaderStore in pairs(DataModule.OrderedDataStores) do
        if not data[board] then continue end

        repeat
            succ = pcall(function()
                leaderStore:SetAsync(userId, data[board])
            end)
        until succ
    end
end

return DataModule