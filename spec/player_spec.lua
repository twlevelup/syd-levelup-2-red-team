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
            return {
            }
        end

        before_each(function()
            player = Player(mock_sound(), mock_animation())
        end)

        pending("animation orientation", function()
            it("should point to the right by default", function()
                assert.False(player.spriteFlippedH)
            end)

            it("should point to the right when the right arrow is pressed", function()
                player.update(dt, mock_input('right'))

                assert.False(player.spriteFlippedH)
            end)

            it("should point to the left when the left arrow is pressed", function()
                player.update(dt, mock_input('left'))

                assert.True(player.spriteFlippedH)
            end)
        end)

        it("should decrement the player's y if the up-arrow is pressed", function()
            player = Player(mock_input('up'))
            local orig_y = player.y
            player.update(1)

            assert.is.equal(orig_y - player.speed, player.y)
        end)

        it("should increment the player's y if the down-arrow is pressed", function()
            player = Player(mock_input('down'))
            local orig_y = player.y
            player.update(1)

            assert.is.equal(orig_y + player.speed, player.y)
        end)

        it("should decrement the player's x if the left-arrow is pressed", function()
            player = Player(mock_input('left'))
            local orig_x = player.x
            player.update(1)

            assert.is.equal(orig_x - player.speed, player.x)
        end)

        it("should increment the player's x if the right-arrow is pressed", function()
            player = Player(mock_input('right'))
            local orig_x = player.x
            player.update(1)

            assert.is.equal(orig_x + player.speed, player.x)
        end)

        it("should update the animation state", function()
            player = Player(mock_input('none'))
            local animation_spy = { update = spy.new(function(dt) end) }

            player.graphics.animation = animation_spy

            player.update(1)

            assert.spy(animation_spy.update).was.called()
        end)
    end)
end)
