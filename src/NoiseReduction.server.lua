-- Noise Reduction for Roblox Supermarket

local Players = game:GetService("Players")

local function applyNoiseReduction(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    -- Reduce noise
    humanoid.WalkSpeed = 20
    humanoid.JumpPower = 60

    -- Optional: Add a visual effect to indicate noise reduction
    local effect = Instance.new("ParticleEmitter")
    effect.Name = "NoiseReductionEffect"
    effect.Parent = humanoid.RootPart
    effect.Texture = "rbxassetid://456789123" -- Replace with actual particle texture ID
    effect.LightEmission = 0.3
    effect.LightInfluence = 0.3
    effect.Size = NumberSequence.new(0.7)
    effect.Transparency = NumberSequence.new(0.3)
    effect.Lifetime = NumberRange.new(0.7)
    effect.Rate = 15
    effect.Enabled = true
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            -- Remove the noise reduction effect when the player dies
            local effect = humanoid.RootPart:FindFirstChild("NoiseReductionEffect")
            if effect then
                effect:Destroy()
            end
        end)
    end)
end

Players.PlayerAdded:Connect(onPlayerAdded)

return applyNoiseReduction