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


end)