require 'obstacle'

Inner_Wall = {}
Inner_Wall.__index = Inner_Wall
setmetatable(Inner_Wall, {__index = Obstacle})

function Inner_Wall:new(game, config)
    local config = config or {}

    local newInner_Wall = Obstacle:new(game)
    newInner_Wall.type = "inner-wall"
    newInner_Wall.x = config.x or 0
    newInner_Wall.y = config.y or 0
    newInner_Wall.size = config.size or {
        x = 600,
        y = 50
    }

    return setmetatable(newInner_Wall, self)
end

function Inner_Wall:draw()
    self.game.graphics.rectangle("line", self.x, self.y, self.size.x, self.size.y)
end
