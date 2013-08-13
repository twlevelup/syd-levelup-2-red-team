require 'player'

describe("Player", function()
    dt = 1

    describe("#update", function()
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

        describe("playing the movement sound", function()
            it("should play the movement sound when the player is moving", function()
                player = Player:new(mock_input('up'))
                player.sound.moving.sample = mock_sound()
                player:update(1)

                assert.spy(player.sound.moving.sample.play).was.called()
            end)

            it("should stop playing the movement sound when the player is stationary", function()
                player = Player:new(mock_input('none'))
                player.sound.moving.sample = mock_sound()
                player:update(1)

                assert.spy(player.sound.moving.sample.stop).was.called()
            end)
        end)

        describe("animating the player", function()
            describe("the sprite direction", function()
                it("should point to the right by default", function()
                    player = Player:new(mock_input('none'))
                    assert.is.equal(player.graphics.facing, "right")
                end)

                it("should point to the right when the right arrow is pressed", function()
                    player = Player:new(mock_input('right'))
                    player.graphics.facing = "left"
                    player.graphics.animation = mock_animation()
                    player:update(1)

                    assert.is.equal(player.graphics.facing, "right")
                    assert.spy(player.graphics.animation.flipH).was.called()
                end)

                it("should point to the left when the left arrow is pressed", function()
                    player = Player:new(mock_input('left'))
                    player.graphics.animation = mock_animation()
                    player:update(1)

                    assert.is.equal(player.graphics.facing, "left")
                    assert.spy(player.graphics.animation.flipH).was.called()
                end)
            end)

            describe("the animation frame", function()
                it("should stop updating when the player isn't moving", function()
                    player = Player:new(mock_input('none'))
                    player.graphics.animation = mock_animation()
                    player:update(1)

                    assert.spy(player.graphics.animation.gotoFrame).was.called()
                    assert.spy(player.graphics.animation.update).was_not.called()
                end)

                it("should update the animation state when the player is moving", function()
                    player = Player:new(mock_input('up'))
                    player.graphics.animation = mock_animation()

                    player:update(1)

                    assert.spy(player.graphics.animation.update).was.called()
                end)
            end)
        end)

        it("should decrement the player's y if the up-arrow is pressed", function()
            player = Player:new(mock_input('up'))
            local orig_y = player.y
            player:update(1)

            assert.is.equal(orig_y - player.speed, player.y)
        end)

        it("should increment the player's y if the down-arrow is pressed", function()
            player = Player:new(mock_input('down'))
            local orig_y = player.y
            player:update(1)

            assert.is.equal(orig_y + player.speed, player.y)
        end)

        it("should decrement the player's x if the left-arrow is pressed", function()
            player = Player:new(mock_input('left'))
            player.graphics.animation = mock_animation()
            local orig_x = player.x
            player:update(1)

            assert.is.equal(orig_x - player.speed, player.x)
        end)

        it("should increment the player's x if the right-arrow is pressed", function()
            player = Player:new(mock_input('right'))
            local orig_x = player.x
            player:update(1)

            assert.is.equal(orig_x + player.speed, player.x)
        end)
    end)
end)
