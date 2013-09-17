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
			assert.is.equal(left_outer_wall.x, 0)
			end)

		it("should have y value of 0 by default", function()
			assert.is.equal(left_outer_wall.y, 0)
			end)

		it("should have size x=1, y=768 by default", function()
			local expected = { x = 1, y = 768 }
			assert.are.same(left_outer_wall.size, expected)
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

			assert.is.equal(1, player.x)
			assert.is.equal(400, player.y)
			assert.are.same(player.lastPosition, {x = orig_x, y = orig_y})
		end)

	end)

end)
