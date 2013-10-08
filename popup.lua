Popup = {}
Popup.__index = Popup

function Popup:new(message)
	return setmetatable({message=message}, self)
end

function Popup:draw()
	love.graphics.print(self.message, (GAME_WIDTH/2)-80, (GAME_HEIGHT/2)-100, 0, 2, 2)
end

--love.graphics.print("game over", 10, 10, 0, 2, 2)