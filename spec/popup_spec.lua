require 'popup'

describe("Popup", function()

	describe("new", function()
		popup = Popup:new("test-message")
		assert.is.equal(popup.message, "test-message")
	end)

	graphics_spy = function()
		return {
			print = spy.new(function() end)
		}
	end

	describe("draw", function()
		love.graphics = graphics_spy()
		popup = Popup:new("another-message")

		popup:draw()

		assert.spy(love.graphics.print).was.called_with(
			"another-message", (GAME_WIDTH/4)+(GAME_WIDTH/8), (GAME_HEIGHT/4)+(GAME_HEIGHT/8) + GAME_INFO_OFFSET_Y, 0, 2, 2)
	end)

end)