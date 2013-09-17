require 'entity'

Obstacle = {}
Obstacle.__index = Obstacle
setmetatable(Obstacle, {__index = Entity})

function Obstacle:new(game, config)
    local config = config or {}

    local newObstacle = Entity:new(game)
    newObstacle.type = "obstacle"
    newObstacle.x = config.x or 0
    newObstacle.y = config.y or 0
    newObstacle.size = config.size or {
        x = 40,
        y = 52
    }

    newObstacle.graphics = config.graphics or {
        source = "assets/images/cactus-sprites.png"
    }

    if game.graphics ~= nil and game.animation ~= nil then
        newObstacle.graphics.sprites = game.graphics.newImage(newObstacle.graphics.source)
        newObstacle.graphics.grid = game.animation.newGrid(
            newObstacle.size.x, newObstacle.size.y,
            newObstacle.graphics.sprites:getWidth(),
            newObstacle.graphics.sprites:getHeight()
        )
        newObstacle.graphics.animation = game.animation.newAnimation(
            newObstacle.graphics.grid("1-2", 1),
            0.5
        )
    end

    return setmetatable(newObstacle, self)
end

function Obstacle:update(dt)
    if self.graphics.animation ~= nil then
        self.graphics.animation:update(dt)
    end
end

function OuterWall:draw()
    self.game.graphics.rectangle("line", self.x, self.y, self.size.x, self.size.y)
end