require 'player'

describe("Player", function()
    describe("#update", function()
        
        mock_sound = function()
            return {
                playLooping = spy.new(function() end),
                stop = spy.new(function() end)
            }
        end
        
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
            player = Player(mock_sound())
            player.speed = 1
            local orig_y = player.y
            player.update(mock_input('up'))

            assert.is.equal(orig_y - 1, player.y)
        end)

        it("should increment the player's y if the down-arrow is pressed", function()
            player = Player(mock_sound())
            player.speed = 1
            local orig_y = player.y
            player.update(mock_input('down'))

            assert.is.equal(orig_y + 1, player.y)
        end)

        it("should decrement the player's x if the left-arrow is pressed", function()
            player = Player(mock_sound())
            player.speed = 1
            local orig_x = player.x
            player.update(mock_input('left'))

            assert.is.equal(orig_x - 1, player.x)
        end)

        it("should increment the player's x if the right-arrow is pressed", function()
            player = Player(mock_sound())
            player.speed = 1
            local orig_x = player.x
            player.update(mock_input('right'))

            assert.is.equal(orig_x + 1, player.x)
        end)
        
        it("should start playing the sound effects when the player start moving", function()
            s = mock_sound()
            player = Player(s)
            player.update(mock_input('right'))
            player.update(mock_input('right'))
            player.update(mock_input('right'))
            assert.spy(s.playLooping).was.called(1)
        end)

        it("should stop playing the sound effects when the player stops moving", function()
            s = mock_sound()
            player = Player(s)
            player.update(mock_input('right'))
            player.update(mock_input('right'))
            assert.spy(s.stop).was.called(0)
            player.update(mock_input(''))
            assert.spy(s.stop).was.called(1)
        end)
        
    end)
end)
