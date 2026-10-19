-- Store Interface for Roblox Supermarket

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SilentSteps = require(script.Parent.SilentSteps)
local FasterSpeed = require(script.Parent.FasterSpeed)
local NoiseReduction = require(script.Parent.NoiseReduction)

local function createStoreGui(player)
    local storeGui = Instance.new("ScreenGui")
    storeGui.Name = "StoreGui"
    storeGui.Parent = player.PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.5, 0, 0.5, 0)
    frame.Position = UDim2.new(0.25, 0, 0.25, 0)
    frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    frame.BorderSizePixel = 0
    frame.Parent = storeGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "Supermarket Store"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.TextScaled = true
    title.Parent = frame

    local currencyLabel = Instance.new("TextLabel")
    currencyLabel.Size = UDim2.new(1, 0, 0.1, 0)
    currencyLabel.Position = UDim2.new(0, 0, 0.1, 0)
    currencyLabel.Text = "Currency: " .. tostring(player:FindFirstChild("leaderstats"):FindFirstChild("Currency").Value)
    currencyLabel.TextColor3 = Color3.new(1, 1, 1)
    currencyLabel.BackgroundTransparency = 1
    currencyLabel.TextScaled = true
    currencyLabel.Parent = frame

    local function createItemButton(name, cost, applyFunction, position)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.4, 0, 0.2, 0)
        button.Position = position
        button.Text = name .. "\nCost: " .. cost
        button.TextColor3 = Color3.new(1, 1, 1)
        button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        button.BorderSizePixel = 0
        button.Parent = frame

        button.MouseButton1Click:Connect(function()
            local currency = player:FindFirstChild("leaderstats"):FindFirstChild("Currency")
            if currency.Value >= cost then
                currency.Value = currency.Value - cost
                applyFunction(player)
                currencyLabel.Text = "Currency: " .. tostring(currency.Value)
            else
                warn("Not enough currency to purchase " .. name)
            end
        end)
    end

    createItemButton("Silent Steps", 200, SilentSteps, UDim2.new(0.1, 0, 0.3, 0))
    createItemButton("Faster Speed", 300, FasterSpeed, UDim2.new(0.5, 0, 0.3, 0))
    createItemButton("Noise Reduction", 250, NoiseReduction, UDim2.new(0.1, 0, 0.6, 0))

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    closeButton.Position = UDim2.new(0.4, 0, 0.9, 0)
    closeButton.Text = "Close"
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.BackgroundColor3 = Color3.new(0.5, 0, 0)
    closeButton.BorderSizePixel = 0
    closeButton.Parent = frame

    closeButton.MouseButton1Click:Connect(function()
        storeGui:Destroy()
    end)
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function()
        createStoreGui(player)
    end)
end

Players.PlayerAdded:Connect(onPlayerAdded)