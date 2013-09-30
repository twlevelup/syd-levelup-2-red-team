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

	it("should do xyz", function()
		assert.is.equal(1, 1)
	end)

	--[[ it should:
		- display time in 00:00 format
		- should decrement time left
		- should count down ever second
		- quit when time is zero
		- be on top right of screen
		- be start at 3 minutes
	]]

end)