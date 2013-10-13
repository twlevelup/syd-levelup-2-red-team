require 'presets'

BackgroundImage = {}
BackgroundImage.__index = BackgroundImage

function BackgroundImage:new(game)

    newBackgroundImage = {
        fenceTopImage = game.graphics.newImage("assets/images/fence-top.png"),
        fenceBotImage = game.graphics.newImage("assets/images/fence-bottom.png"),
        grassImage = game.graphics.newImage("assets/images/grass.png"),
        soilImage = game.graphics.newImage("assets/images/soil.png"),
        love = game
    }

	return setmetatable(newBackgroundImage, self)
end


function BackgroundImage:calculateRepeat()

    local repeats = {
        x = 0,
        y = 0
    }

    local sizeX = self.fenceTopImage:getWidth()
    local sizeY = self.fenceTopImage:getHeight()
    local screenHeight = self.love.graphics.getHeight()
    local screenWidth = self.love.graphics.getWidth()

    repeats.x = math.ceil(screenWidth/sizeX)
    repeats.y = math.ceil(screenHeight/sizeY)

    return repeats
end

function BackgroundImage:repeatImages(repeats)

    local x = repeats.x
    local y = repeats.y

    local i, j

    for i = 0,y do
        for j = 0,x do

            if i == 0 then
                self:draw(self.grassImage, j, i)
            elseif i == 1 then
                self:draw(self.fenceTopImage, j, i)
            else
                self:draw(self.soilImage, j, i)
            end    
        end
    end

end

function BackgroundImage:draw(tile, offsetX, offsetY)
    love.graphics.draw(tile, 0 + (40*offsetX), 0 + (40*offsetY), 0, 1, 1, 0, 0)
end

function BackgroundImage:fillBackground()

    local repeats = self:calculateRepeat()
    self:repeatImages(repeats)

end

