-- Faster Speed for Roblox Supermarket

local Players = game:GetService("Players")

local function applyFasterSpeed(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    -- Increase walk speed
    humanoid.WalkSpeed = 32
    humanoid.JumpPower = 75

    -- Optional: Add a visual effect to indicate faster speed
    local effect = Instance.new("ParticleEmitter")
    effect.Name = "FasterSpeedEffect"
    effect.Parent = humanoid.RootPart
    effect.Texture = "rbxassetid://987654321" -- Replace with actual particle texture ID
    effect.LightEmission = 1
    effect.LightInfluence = 1
    effect.Size = NumberSequence.new(1)
    effect.Transparency = NumberSequence.new(0.2)
    effect.Lifetime = NumberRange.new(1)
    effect.Rate = 20
    effect.Enabled = true
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            -- Remove the faster speed effect when the player dies
            local effect = humanoid.RootPart:FindFirstChild("FasterSpeedEffect")
            if effect then
                effect:Destroy()
            end
        end)
    end)
end

Players.PlayerAdded:Connect(onPlayerAdded)

return applyFasterSpeed