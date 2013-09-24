require 'outer_wall'
require 'player'

describe("OuterWall", function()
    local dt = 1

    local screenX = 1024
    local screenY = 768

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
            local expected = { x = 1, y = screenY }
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

        it("should prevent the player from moving left when it is at position x=1 y=400", function()
            local player = Player:new(
                mock_input('left'),
                {
                    x = 0,
                    y = 400,
                    speed = 1
                }
            )

            player.lastPosition = {}
            player.lastPosition.x = 1
            player.lastPosition.y = 400

            player.graphics.animation = mock_animation()

            local expectedSize = {x = 1, y = screenY}

            assert.is.equal(0, left_outer_wall.x)
            assert.is.equal(0, left_outer_wall.y)
            assert.are.same(expectedSize, left_outer_wall.size)
            assert.is.equal("left", left_outer_wall.position)

            player:collide(left_outer_wall)

            assert.is.equal(1, player.x)
            assert.is.equal(400, player.y)
        end)
    end)
end)
