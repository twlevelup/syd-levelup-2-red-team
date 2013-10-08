require 'presets'

BackgroundImage = {}
BackgroundImage.__index = BackgroundImage

function BackgroundImage:new()
	

	local config = config or {}

    local newBackgroundImage = Entity:new(game)
    newBackgroundImage.type = "BackgroundImage"
    newBackgroundImage.x = config.x or 0
    newBackgroundImage.y = config.y or 0
    newBackgroundImage.size = config.size or {
        x = GAME_WIDTH,
        y = GAME_HEIGHT
    }

    newBackgroundImage.graphics = config.graphics or {
        source = "assets/images/bg.png"
    }

    if game.graphics ~= nil and game.animation ~= nil then
        newBackgroundImage.graphics.sprites = game.graphics.newImage(newBackgroundImage.graphics.source)
        newBackgroundImage.graphics.grid = game.animation.newGrid(
            newBackgroundImage.size.x, newBackgroundImage.size.y,
            newBackgroundImage.graphics.sprites:getWidth(),
            newBackgroundImage.graphics.sprites:getHeight()
        )
        newBackgroundImage.graphics.animation = game.animation.newAnimation(
            newBackgroundImage.graphics.grid("1-1", 1),
            0.5
        )
    end

	return setmetatable(newBackgroundImage, self)
end

--Need to possibly implement a gaurd against score going into negative, check with BA
function BackgroundImage:update(value)
	self.score = value + self.score
end

function BackgroundImage:draw()
    love.graphics.print(self.score, self.x_pos, self.y_pos, self.orientation, 
    	self.x_scale, self.y_scale)
end