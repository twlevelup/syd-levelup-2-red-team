Scoreboard = {}
Scoreboard.__index = Scoreboard

function Scoreboard:new()
	

	local newScoreboard = {
		score = 0
	}

	return setmetatable(newScoreboard, self)
end