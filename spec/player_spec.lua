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
            player = Player()
            local orig_y = player.y
            player.update(0, mock_input('up'))

            assert.is.equal(orig_y - player.speed, player.y)
        end)

        it("should increment the player's y if the down-arrow is pressed", function()
            player = Player()
            local orig_y = player.y
            player.update(0, mock_input('down'))

            assert.is.equal(orig_y + player.speed, player.y)
        end)

        it("should decrement the player's x if the left-arrow is pressed", function()
            player = Player()
            local orig_x = player.x
            player.update(0, mock_input('left'))

            assert.is.equal(orig_x - player.speed, player.x)
        end)

        it("should increment the player's x if the right-arrow is pressed", function()
            player = Player()
            local orig_x = player.x
            player.update(0, mock_input('right'))

            assert.is.equal(orig_x + player.speed, player.x)
        end)
    end)
end)
