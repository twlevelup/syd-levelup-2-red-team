Time = {}
Time.__index = Time

function Time:new(limit)
	local newTime = {
		limit = limit,
		osTime = 0
	}

	return setmetatable(newTime, self)
end

function Time:start(osTime)
	self.osTime = osTime
end
