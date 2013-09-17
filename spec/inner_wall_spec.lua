require 'inner_wall'
require 'player'

describe("InnerWall", function()

	describe("new", function()
		local inner_wall

		before_each(function()
			inner_wall = InnerWall:new({})
		end)

		it("should have x value of 0 by default", function()
			assert.is.equal(inner_wall.x, 0)
		end)

		it("should have y value of 0 by default", function()
			assert.is.equal(inner_wall.y, 0)
		end)

		it("should have size x=600, y=50 by default", function()
			local expected = { x = 600, y = 50 }
			assert.are.same(inner_wall.size, expected)
		end)

	end)

end)
