require 'presets'

BackgroundImage = {}
BackgroundImage.__index = BackgroundImage

function BackgroundImage:new(game)

    newBackgroundImage = {
        fenceTopImage = game.graphics.newImage("assets/images/fence-top.png"),
        fenceBotImage = game.graphics.newImage("assets/images/fence-bottom.png"),
        grassImage = game.graphics.newImage("assets/images/grass.png"),
        soilImage = game.graphics.newImage("assets/images/soil.png"),
        love = game,
        repeatX = 0,
        repeatY = 0
    }

	return setmetatable(newBackgroundImage, self)
end


function BackgroundImage:calculateRepeat()

    local sizeX = self.fenceTopImage:getWidth()
    local sizeY = self.fenceTopImage:getHeight()
    local screenHeight = self.love.graphics.getHeight()
    local screenWidth = self.love.graphics.getWidth()

    self.repeatX = math.ceil(screenWidth/sizeX)
    self.repeatY = math.ceil(screenHeight/sizeY)

end

function BackgroundImage:repeatImages()

    local x = self.repeatX
    local y = self.repeatY

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

function BackgroundImage:drawBottom(tile, offsetX, y)
    love.graphics.draw(tile, 0 + (40*offsetX), y, 0, 1, 1, 0, 0)
end

function BackgroundImage:fillBackground()

    local repeats = self:calculateRepeat()
    self:repeatImages(repeats)

end

function BackgroundImage:drawBottomFence()
    local x = self.repeatX
    local y = self.love.graphics.getHeight() - self.fenceBotImage:getHeight()

    for i = 0, x do
        self:drawBottom(self.fenceBotImage, i, y)
    end
end

