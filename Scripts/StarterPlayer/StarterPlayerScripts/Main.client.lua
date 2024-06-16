local mouse = game.Players.LocalPlayer:GetMouse()
local event = game.ReplicatedStorage.Remotes.ClickEvent

mouse.Button1Down:Connect(function()
	event:FireServer()
end)