require 'scoreboard'


describe("scoreboard", function()
	local start_score = 0
	local scoreboard

	before_each(function()
		scoreboard = Scoreboard:new(start_score)
	end)

	it("should set score to zero", function()
	
		assert.is.equal(start_score, scoreboard.score)
	end)

	it("should update with positive numbers", function()

	local new_point = 5
	local new_score = start_score + new_point
	scoreboard:update(new_point)

	assert.is.equal(new_score, scoreboard.score)
	end)

		it("should update with negative numbers", function()

	local new_point = -5
	local new_score = start_score + new_point
	scoreboard:update(new_point)

	assert.is.equal(new_score, scoreboard.score)
	end)



end)