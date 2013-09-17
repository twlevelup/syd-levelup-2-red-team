require 'entity'
require 'obstacle'

OuterWall = {}
OuterWall.__index = OuterWall
setmetatable(OuterWall, {__index = Obstacle})

function OuterWall:new(game, config)
    local leftWall = OuterWall:createWall(game, {
        x = 0,
        y = 0,
        size = {
            x = 1,
            y = 764
        }
    })

    local rightWall = OuterWall:createWall(game, {
        x = 1023,
        y = 1,
        size = {
            x = 1,
            y = 764
        }
    })

    local topWall = OuterWall:createWall(game, {
        x = 2,
        y = 1,
        size = {
            x = 1024,
            y = 1
        }
    })

    local bottomWall = OuterWall:createWall(game, {
        x = 1,
        y = 763,
        size = {
            x = 1024,
            y = 1
        }
    })

    local newOuterWalls = {topWall, rightWall, bottomWall, leftWall}
    return setmetatable(newOuterWalls, self)
end

function OuterWall:createWall(game, config)
    local config = config or {}

    local newOuterWall = Obstacle:new(game)
    newOuterWall.type = "outerWall"
    -- newOtherWall.place = config.place or "top"
    newOuterWall.x = config.x or 0
    newOuterWall.y = config.y or 0
    newOuterWall.size = config.size or {
        x = 1,
        y = 768
    }

    -- newOuterWall.graphics = config.graphics or {
    --     source = "assets/images/cactus-sprites.png"
    -- }

    -- if game.graphics ~= nil and game.animation ~= nil then
    --     newOuterWall.graphics.sprites = game.graphics.newImage(newOuterWall.graphics.source)
    --     newOuterWall.graphics.grid = game.animation.newGrid(
    --         newOuterWall.size.x, newOuterWall.size.y,
    --         newOuterWall.graphics.sprites:getWidth() * (newOuterWall.size.x / newOuterWall.graphics.sprites:getWidth() + 1),
    --         newOuterWall.graphics.sprites:getHeight() * (newOuterWall.size.y / newOuterWall.graphics.sprites:getHeight() + 1)
    --     )
    --     newOuterWall.graphics.animation = game.animation.newAnimation(
    --         newOuterWall.graphics.grid("1-1", 1),
    --         0.5
    --     )
    -- end

    return newOuterWall
end

function OuterWall:draw()
    for _, wall in pairs(self) do
        wall.draw()
    end
end

function OuterWall:update(dt)
    if self.graphics.animation ~= nil then
        self.graphics.animation:update(dt)
    end
end
