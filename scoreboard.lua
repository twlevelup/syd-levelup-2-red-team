Scoreboard = {}
Scoreboard.__index = Scoreboard

function Scoreboard:new(playerNumber)
	

	local newScoreboard = {
		playerNumber = playerNumber or 1,
		score = 0,
		x_pos = 10,
		y_pos = 10,
		orientation = 0,
		x_scale = 2,
		y_scale = 2

	}
	return setmetatable(newScoreboard, self)
end

--Need to possibly implement a gaurd against score going into negative, check with BA
function Scoreboard:update(value)
	self.score = value + self.score
end

function Scoreboard:draw()

	offset = 200

	if self.playerNumber == 1 then
		love.graphics.print("Player 1 = "..self.score.."", self.x_pos, self.y_pos, self.orientation, 
    	self.x_scale, self.y_scale)
	else
		love.graphics.print("Player O = "..self.score.."", self.x_pos + offset, self.y_pos, self.orientation, 
    	self.x_scale, self.y_scale)
	end
    
end