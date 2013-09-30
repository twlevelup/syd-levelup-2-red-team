require 'time'

describe("Time", function()
	local gameTimeLimit = 3

	it("should set the game time limit", function()
		local time = Time:new(gameTimeLimit)

		assert.is.equal(gameTimeLimit, time.limit)
	end)

	it("should store the start time", function()
		local time = Time:new(gameTimeLimit)
		local timeNow = os.time()
		time:start(timeNow)

		assert.is.equal(timeNow, time.startTime)
	end)

	it("should display the time in ##:## format", function()
		local testLimit = 789
		local expectedFormat = "13:09"
		local time = Time:new(testLimit)
		time:start(os.time())
		
		assert.is.equal(expectedFormat, time.remaining)
	end)

<<<<<<< HEAD
	it("should count down every second", function()
		local testLimit = 10
		local testTimeStart = os.time{year=2000, month=1, day=1, hour=0, sec=0}
		local testTimeFinal = os.time{year=2000, month=1, day=1, hour=0, sec=9}
		local expectedTimeRemaining = "00:01"

		local time = Time:new(testLimit)
		time:start(testTimeStart)
		time:tick(testTimeFinal)

		assert.is.equal(expectedTimeRemaining, time.remaining)
	end)

	it("should finish counting down after set limit", function()
		local testLimit = 10
		local testTimeStart = os.time{year=2000, month=1, day=1, hour=0, sec=0}
		local testTimeFinal = os.time{year=2000, month=1, day=1, hour=0, sec=10}
		local expectedFinishState = true

		local time = Time:new(testLimit)
		time:start(testTimeStart)
		time:tick(testTimeFinal)

		assert.is.equal(expectedFinishState, time.finished)
	end)

	--[[it("should display time on screen", function()
		local testLimit = 10
		local time = Time:new(testLimit)
		time:start(os.time())

		local s = spy.on(time, "draw")
=======
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
>>>>>>> 7f2f56c292864e84e3f1e9fec5bbdc3da2c53c5e

		time:draw()
    	assert.spy(time:greet).was.called()
	end)]]
end)