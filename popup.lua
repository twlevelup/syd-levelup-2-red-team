Popup = {}
Popup.__index = Popup

function Popup:new(message)
	return setmetatable({message=message}, self)
end

function Popup:draw()
	love.graphics.print(self.message, 10, 10, 0, 2, 2)
end

--love.graphics.print("game over", 10, 10, 0, 2, 2)