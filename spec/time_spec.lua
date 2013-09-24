require 'time'

describe("Time", function()
	local gameTimeLimit = 3

	it("should set the game time limit", function()
		local time = Time:new(gameTimeLimit);
		assert.is.equal(gameTimeLimit, time.limit)
	end)

	it("should store the start time", function()
		local time = Time:new(gameTimeLimit);
		local osTime = os.time();
		time:start(osTime)
		assert.is.equal(osTime, time.osTime)
	end)


end)