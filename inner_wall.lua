require 'obstacle'

InnerWall = {}
InnerWall.__index = InnerWall
setmetatable(InnerWall, {__index = Obstacle})

function InnerWall:new(game, config, style)
    local config = config or {}

    local newInnerWall = Obstacle:new(game)
    newInnerWall.type = "inner-wall"
    newInnerWall.x = config.x or 0
    newInnerWall.y = config.y or 0
    newInnerWall.size = config.size or {
        x = 600,
        y = 50
    }

    newInnerWall.style = style or '1'

    newInnerWall.graphics = config.graphics or {
        source = "assets/images/bush" .. newInnerWall.style .. ".png"
    }

    if game.graphics ~= nil and game.animation ~= nil then
        newInnerWall.graphics.sprites = game.graphics.newImage(newInnerWall.graphics.source)
        newInnerWall.graphics.grid = game.animation.newGrid(
            newInnerWall.size.x, newInnerWall.size.y,
            newInnerWall.graphics.sprites:getWidth(),
            newInnerWall.graphics.sprites:getHeight()
        )
        newInnerWall.graphics.animation = game.animation.newAnimation(
            newInnerWall.graphics.grid("1-1", 1),
            0.5
        )
    end

    return setmetatable(newInnerWall, self)
end
