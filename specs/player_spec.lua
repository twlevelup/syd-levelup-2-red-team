require 'player'

describe("Player", function()
    describe("#update", function()
        mock_input = function(action)
            return {
                pressed = function(a)
                    if a == action then
                        return true
                    else
                        return false
                    end
                end
            }
        end

        it("should decrement the player's y if the up-arrow is pressed", function()
            player = Player()
            local orig_y = player.y
            player.update(mock_input('up'))

            assert.is.equal(orig_y - 1, player.y)
        end)

        it("should increment the player's y if the down-arrow is pressed", function()
            player = Player()
            local orig_y = player.y
            player.update(mock_input('down'))

            assert.is.equal(orig_y + 1, player.y)
        end)

        it("should decrement the player's x if the left-arrow is pressed", function()
            player = Player()
            local orig_x = player.x
            player.update(mock_input('left'))

            assert.is.equal(orig_x - 1, player.x)
        end)

        it("should increment the player's x if the right-arrow is pressed", function()
            player = Player()
            local orig_x = player.x
            player.update(mock_input('right'))

            assert.is.equal(orig_x + 1, player.x)
        end)
    end)
end)
