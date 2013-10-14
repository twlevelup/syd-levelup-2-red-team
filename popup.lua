Popup = {}
Popup.__index = Popup

function Popup:new(message)
	return setmetatable({message=message}, self)
end

function Popup:draw()
	love.graphics.print(self.message, (GAME_WIDTH/4)+(GAME_WIDTH/8), (GAME_HEIGHT/4)+(GAME_HEIGHT/8) + GAME_INFO_OFFSET_Y, 0, 2, 2)
end

--love.graphics.print("game over", 10, 10, 0, 2, 2)