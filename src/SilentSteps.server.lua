-- Silent Steps for Roblox Supermarket

local Players = game:GetService("Players")

local function applySilentSteps(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    -- Reduce footstep sound
    humanoid.WalkSpeed = 16
    humanoid.JumpPower = 50

    -- Optional: Add a visual effect to indicate silent steps
    local effect = Instance.new("ParticleEmitter")
    effect.Name = "SilentStepsEffect"
    effect.Parent = humanoid.RootPart
    effect.Texture = "rbxassetid://123456789" -- Replace with actual particle texture ID
    effect.LightEmission = 0.5
    effect.LightInfluence = 0.5
    effect.Size = NumberSequence.new(0.5)
    effect.Transparency = NumberSequence.new(0.5)
    effect.Lifetime = NumberRange.new(0.5)
    effect.Rate = 10
    effect.Enabled = true
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            -- Remove the silent steps effect when the player dies
            local effect = humanoid.RootPart:FindFirstChild("SilentStepsEffect")
            if effect then
                effect:Destroy()
            end
        end)
    end)
end

Players.PlayerAdded:Connect(onPlayerAdded)

return applySilentSteps