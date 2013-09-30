Time = {}
Time.__index = Time

function Time:new(limit)
	local newTime = {
		limit = limit,
		remaining = 0,
		startTime = 0,
		finished = false
	}

	return setmetatable(newTime, self)
end

function Time:start(currentTime)
	self.finished = false
	self.startTime = currentTime
	self:tick(currentTime) -- update remaining time
end

function Time:tick(currentTime)
	local elapsedTime = currentTime - self.startTime
	self.remaining = os.date("%M:%S", self.limit - elapsedTime)

	if (self.remaining == "00:00") then
        self.finished = true
    end
end

function Time:draw()
    love.graphics.print(self.remaining, 920, 10, 0, 2, 2)
end