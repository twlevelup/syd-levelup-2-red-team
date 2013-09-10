require 'obstacle'

InnerWall = {}
InnerWall.__index = InnerWall
setmetatable(InnerWall, {__index = Obstacle})

function InnerWall:new(game, config)
    local config = config or {}

    local newInnerWall = Obstacle:new(game)
    newInnerWall.type = "inner-wall"
    newInnerWall.x = config.x or 0
    newInnerWall.y = config.y or 0
    newInnerWall.size = config.size or {
        x = 600,
        y = 50
    }

    return setmetatable(newInnerWall, self)
end

function InnerWall:draw()
    self.game.graphics.rectangle("line", self.x, self.y, self.size.x, self.size.y)
end
