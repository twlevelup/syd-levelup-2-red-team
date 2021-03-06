require 'outer_wall'
require 'player'

describe("OuterWall", function()
    local dt = 1

    local screenX = 1024
    local screenY = 768

    describe("new", function()
        local left_outer_wall
        local right_outer_wall
        local top_outer_wall
        local bottom_outer_wall

        before_each(function()
            left_outer_wall = OuterWall:new({})
            right_outer_wall = OuterWall:new({}, {
                    position = "right"
                })
            top_outer_wall = OuterWall:new({}, {
                    position = "top"
                })
            bottom_outer_wall = OuterWall:new({}, {
                    position = "bottom"
                })
        end)

        describe("left outer wall", function()
            it("should have default x,y coordinates", function()
                assert.is.equal(0, left_outer_wall.x)
                assert.is.equal(0, left_outer_wall.y)
            end)

            it("should have default size", function()
                local expected = { x = 1, y = screenY }
                assert.are.same(expected, left_outer_wall.size)
            end)
        end)
        
        describe("right outer wall", function()
            it("should have default x,y coordinates", function()
                assert.is.equal(screenX, right_outer_wall.x)
                assert.is.equal(0, right_outer_wall.y)
            end)

            it("should have default size", function()
                local expected = { x = 1, y = screenY }
                assert.are.same(expected, right_outer_wall.size)
            end)
        end)

        describe("top outer wall", function()
            it("should have default x,y coordinates", function()
                assert.is.equal(0, top_outer_wall.x)
                assert.is.equal(0, top_outer_wall.y)
            end)

            it("should have default size", function()
                local expected = { x = screenX, y = 1 }
                assert.are.same(expected, top_outer_wall.size)
            end)
        end)

        describe("bottom outer wall", function()
            it("should have default x,y coordinates", function()
                assert.is.equal(0, bottom_outer_wall.x)
                assert.is.equal(screenY, bottom_outer_wall.y)
            end)

            it("should have default size", function()
                local expected = { x = screenX, y = 1 }
                assert.are.same(expected, bottom_outer_wall.size)
            end)
        end)
    end)

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

        it("should not move past left wall", function()
            local left_outer_wall = OuterWall:new({})
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

        it("should not move past right wall", function()
            local right_outer_wall = OuterWall:new({}, {
                    position = "right"
                })
            local player = Player:new(
                mock_input('right'),
                {
                    x = screenX,
                    y = 400,
                    speed = 1
                }
            )

            player.lastPosition = {}
            player.lastPosition.x = screenX - 1
            player.lastPosition.y = 400

            player.graphics.animation = mock_animation()

            local expectedSize = {x = 1, y = screenY}

            assert.is.equal(screenX, right_outer_wall.x)
            assert.is.equal(0, right_outer_wall.y)
            assert.are.same(expectedSize, right_outer_wall.size)
            assert.is.equal("right", right_outer_wall.position)

            player:collide(right_outer_wall)

            assert.is.equal(screenX - 1, player.x)
            assert.is.equal(400, player.y)
        end)

        it("should not move past top wall", function()
            local top_outer_wall = OuterWall:new({}, {
                    position = "top"
                })
            local player = Player:new(
                mock_input('up'),
                {
                    x = 350,
                    y = 0,
                    speed = 1
                }
            )

            player.lastPosition = {}
            player.lastPosition.x = 350
            player.lastPosition.y = 1

            player.graphics.animation = mock_animation()

            local expectedSize = {x = screenX, y = 1}

            assert.is.equal(0, top_outer_wall.x)
            assert.is.equal(0, top_outer_wall.y)
            assert.are.same(expectedSize, top_outer_wall.size)
            assert.is.equal("top", top_outer_wall.position)

            player:collide(top_outer_wall)

            assert.is.equal(350, player.x)
            assert.is.equal(1, player.y)
        end)

        it("should not move past bottom wall", function()
            local bottom_outer_wall = OuterWall:new({}, {
                    position = "bottom"
                })
            local player = Player:new(
                mock_input('down'),
                {
                    x = 350,
                    y = screenY,
                    speed = 1
                }
            )

            player.lastPosition = {}
            player.lastPosition.x = 350
            player.lastPosition.y = screenY - 1

            player.graphics.animation = mock_animation()

            local expectedSize = {x = screenX, y = 1}

            assert.is.equal(0, bottom_outer_wall.x)
            assert.is.equal(screenY, bottom_outer_wall.y)
            assert.are.same(expectedSize, bottom_outer_wall.size)
            assert.is.equal("bottom", bottom_outer_wall.position)

            player:collide(bottom_outer_wall)

            assert.is.equal(350, player.x)
            assert.is.equal(screenY - 1, player.y)
        end)
    end)
end)
