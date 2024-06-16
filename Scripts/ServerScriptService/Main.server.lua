workspace.Baseplate:Destroy()
workspace.Gravity = 100

local event = game.ReplicatedStorage.Remotes.ClickEvent

local floor = workspace.Floor
local start = workspace.Start
local maxValue = (floor.Position - start.Position).Magnitude

function givePoints(player: Player, value: number)
	local stats = player:FindFirstChild("leaderstats")
	if stats then
		local points: IntValue = stats:FindFirstChild('Points')
		points.Value += value
	end
end

function onClick(player: Player)
	local character = player.Character
	if character then
		local humanoid: Humanoid = character:FindFirstChildOfClass("Humanoid")

		
		if humanoid:GetState() == Enum.HumanoidStateType.Freefall then
			local mag = (floor.Position - character:GetPivot().Position).Magnitude
			givePoints(player, maxValue - mag)
			character:MoveTo(start.Position + Vector3.new(0, 100, 0))
		end
	end
end

function onPlayerAdded(player: Player)
	script.leaderstats:Clone().Parent = player
end

function floorTouched(hit: Part)
	local humanoid = hit.Parent:FindFirstChildOfClass('Humanoid')
	if humanoid then
		humanoid.Health = 0
	end
end


floor.Touched:Connect(floorTouched)
event.OnServerEvent:Connect(onClick)
game.Players.PlayerAdded:Connect(onPlayerAdded)