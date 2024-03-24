local Teams = game:GetService("Teams")
local Players = game:GetService("Players")

local teams = {}
teams.__index = teams

function teams.new(amount: number)
	local self = {}
	self.index = 1
	self.max = amount
	
	return (setmetatable(self, teams))
end

function teams:Next()
	self.index += 1
	if self.index > self.max then
		self.index = 1
	end
end

function teams:SetTeam(player: Player)
	local team = player:FindFirstChild("RoundTeam") == nil and
		player:WaitForChild("RoundTeam") or
		player.RoundTeam
	team.Value = self.index
	self:Next()
end

function teams:SetAllTeams()
	for _, player: Player in pairs(Players:GetPlayers()) do
		local team = player.RoundTeam == nil and player:WaitForChild("RoundTeam") or player.RoundTeam
		team.Value = self.index
		self:Next()
	end
end

function teams:GetTeamPlayers(team: number)
	local players = {};
	for _, player: Player in pairs(Players:GetPlayers()) do
		if player.RoundTeam.Value == team then
			table.insert(players, player)
		end
	end
	return players
end

function teams:GetPlayerTeam(player: Player)
	return player.RoundTeam.Value
end

function teams:ResetAllTeams()
	for _, player: Player in pairs(Players:GetPlayers()) do
		player.RoundTeam.Value = 0
	end
	self.index = 1
end

return teams
