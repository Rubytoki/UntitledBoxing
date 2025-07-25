-- Boxing Client Script (Place in StarterCharacterScripts)
local player = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")

local blocking = false
local debounce = false

-- Punch when clicking
uis.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 and not blocking then
		rs:WaitForChild("PunchEvent"):FireServer()
	end
end)

-- Hold F to block
uis.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.F then
		blocking = true
		rs:WaitForChild("BlockEvent"):FireServer(true)
	end
end)

uis.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.F then
		blocking = false
		rs:WaitForChild("BlockEvent"):FireServer(false)
	end
end)

-- Listen for stamina UI updates
rs:WaitForChild("StaminaUpdate").OnClientEvent:Connect(function(value)
	local bar = player:WaitForChild("PlayerGui"):FindFirstChild("BoxingUI", true)
	if bar and bar:FindFirstChild("StaminaBar") then
		bar.StaminaBar.Size = UDim2.new(value / 100, 0, 1, 0)
	end
end)
