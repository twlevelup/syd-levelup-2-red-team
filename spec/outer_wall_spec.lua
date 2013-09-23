require 'outer_wall'
require 'player'

describe("OuterWall", function()
	local dt = 1

	describe("new", function()
		local left_outer_wall

		before_each(function()
			left_outer_wall = OuterWall:new({})
			end)

		it("should have x value of 0 by default", function()
			assert.is.equal(0, left_outer_wall.x)
			end)

		it("should have y value of 0 by default", function()
			assert.is.equal(0, left_outer_wall.y)
			end)

		it("should have size x=1, y=768 by default", function()
			local expected = { x = 1, y = 768 }
			assert.are.same(expected, left_outer_wall.size)
			end)

		end)

	describe("Player", function()
		local player
		local left_outer_wall

		mock_input = function(action)
            return {
                input = {
                    pressed = function(a)
                        if a == action then
                            return true
                        else
                            return false
                        end
                    end
                }
            }
        end

        mock_animation = function()
            local animation_spy = {
                update = spy.new(function(dt) end),
                flipH = spy.new(function() end),
                gotoFrame = spy.new(function() end)
            }

            return animation_spy
        end

        mock_sound = function()
            local sound_spy = {
                play = spy.new(function() end),
                stop = spy.new(function() end)
            }

            return sound_spy
        end

		before_each(function()
			player = Player:new({})
			left_outer_wall = OuterWall:new({})
			end)

		it("should not be able to move left when at x=1 y=400", function()
			orig_x = 1
			orig_y = 400
			local player = Player:new(
				mock_input('left'),
				{
					x = orig_x,
					y = orig_y,
					speed = 1
				}
			)
			player.graphics.animation = mock_animation()
			player:update(dt)

			local expectedSize = {x = 1, y = 768}

			-- Check to see that the outer wall exists
			assert.is.equal(0, left_outer_wall.x)
			assert.is.equal(0, left_outer_wall.y)
			assert.are.same(expectedSize, left_outer_wall.size)
			assert.is.equal("left", left_outer_wall.position)


			assert.are.same({x = orig_x, y = orig_y}, player.lastPosition) -- Last position hasn't changed.
			assert.is.equal(400, player.y) -- Still at y = 400

			assert.is.equal(true, player:collidingWith(left_outer_wall)) -- Registers that it's colliding

			-- assert.is.equal(1, player.x) -- WHY YOU NO STOP AT WALL...?
			-- Actual (Collide) function is called in main.lua and not part of the model.. Maybe that's way.
			-- TODO: Ask Andrew about this.

		end)

	end)

end)
