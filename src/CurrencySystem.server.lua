-- Currency System for Roblox Supermarket

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local currencyDataStore = DataStoreService:GetDataStore("CurrencyStore")

local function giveStartingCurrency(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local currency = Instance.new("IntValue")
    currency.Name = "Currency"
    currency.Value = 1000 -- Starting amount
    currency.Parent = leaderstats

    local success, err = pcall(function()
        currencyDataStore:SetAsync(player.UserId, currency.Value)
    end)

    if not success then
        warn("Error saving currency for " .. player.Name .. ": " .. err)
    end
end

local function onPlayerAdded(player)
    giveStartingCurrency(player)

    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            local currency = player:FindFirstChild("leaderstats"):FindFirstChild("Currency")
            if currency then
                local success, err = pcall(function()
                    currencyDataStore:SetAsync(player.UserId, currency.Value)
                end)

                if not success then
                    warn("Error saving currency for " .. player.Name .. ": " .. err)
                end
            end
        end)
    end)
end

Players.PlayerAdded:Connect(onPlayerAdded)

local function onPlayerRemoving(player)
    local currency = player:FindFirstChild("leaderstats"):FindFirstChild("Currency")
    if currency then
        local success, err = pcall(function()
            currencyDataStore:SetAsync(player.UserId, currency.Value)
        end)

        if not success then
            warn("Error saving currency for " .. player.Name .. ": " .. err)
        end
    end
end

Players.PlayerRemoving:Connect(onPlayerRemoving)