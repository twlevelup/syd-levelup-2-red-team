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

--Wall collide tests

	    describe("Player", function()
        local player

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
        end)

        it("should not move past right side of wall", function()
            local left_side_inner_wall = InnerWall:new(love, {x = 200, y = 200}, 1)
            local player = Player:new(
                mock_input('left'),
                {
                    x = 801,
                    y = 220,
                    speed = 1
                }
            )

            player.lastPosition = {}
            player.lastPosition.x = 801
            player.lastPosition.y = 220

            player.graphics.animation = mock_animation()

            player:collide(left_side_inner_wall)

            assert.is.equal(801, player.x)
            assert.is.equal(220, player.y)
        end)


        it("should not move past left side of wall", function()
            local left_side_inner_wall = InnerWall:new(love, {x = 200, y = 200}, 1)
            local player = Player:new(
                mock_input('right'),
                {
                    x = 199,
                    y = 220,
                    speed = 1
                }
            )

            player.lastPosition = {}
            player.lastPosition.x = 199
            player.lastPosition.y = 220

            player.graphics.animation = mock_animation()

            player:collide(left_side_inner_wall)

            assert.is.equal(199, player.x)
            assert.is.equal(220, player.y)
        end)


        it("should not move past top side of wall", function()
            local left_side_inner_wall = InnerWall:new(love, {x = 200, y = 200}, 1)
            local player = Player:new(
                mock_input('down'),
                {
                    x = 400,
                    y = 199,
                    speed = 1
                }
            )

            player.lastPosition = {}
            player.lastPosition.x = 400
            player.lastPosition.y = 199

            player.graphics.animation = mock_animation()

            player:collide(left_side_inner_wall)

            assert.is.equal(400, player.x)
            assert.is.equal(199, player.y)
        end)

        it("should not move past bottom side of wall", function()
            local left_side_inner_wall = InnerWall:new(love, {x = 200, y = 200}, 1)
            local player = Player:new(
                mock_input('up'),
                {
                    x = 400,
                    y = 251,
                    speed = 1
                }
            )

            player.lastPosition = {}
            player.lastPosition.x = 400
            player.lastPosition.y = 251

            player.graphics.animation = mock_animation()

            player:collide(left_side_inner_wall)

            assert.is.equal(400, player.x)
            assert.is.equal(251, player.y)
        end)

     end)
end)
