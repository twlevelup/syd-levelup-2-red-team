require 'obstacle'

OuterWall = {}
OuterWall.__index = OuterWall
setmetatable(OuterWall, {__index = Obstacle})


function OuterWall:createWalls(game)

    local walls = {}

    -- Create the 4 walls
    local leftWall = OuterWall:new(game, {position = "left"})
    local rightWall = OuterWall:new(game, {position = "right"})
    local topWall = OuterWall:new(game, {position = "top"})
    local bottomWall = OuterWall:new(game, {position = "bottom"})

    -- Add them to return table
    table.insert(walls, leftWall)
    table.insert(walls, rightWall)
    table.insert(walls, topWall)
    table.insert(walls, bottomWall)

    return walls

end


function OuterWall:new(game, config)
    local config = config or {}

    local screenHeight = 768
    local screenWidth = 1024

    local newOuterWall = Obstacle:new(game)
    newOuterWall.type = "outer-wall"
    newOuterWall.position = "left" or config.position
    newOuterWall.x = config.x or 0
    newOuterWall.y = config.y or 0
    newOuterWall.size = config.size or {
        x = 1,
        y = screenHeight
    }

    -- Based on the position, it sets the size.
    if config.position == "bottom" then
        newOuterWall.x = 0
        newOuterWall.y = screenHeight
        newOuterWall.size = {
            x = screenWidth,
            y = 1
        }
    elseif config.position == "left" then
        newOuterWall.x = 0
        newOuterWall.y = 0
        newOuterWall.size = {
            x = 1,
            y = screenHeight
        }
    elseif config.position == "right" then
        newOuterWall.x = screenWidth
        newOuterWall.y = 0
        newOuterWall.size = {
            x = 1,
            y = screenHeight
        }
    elseif config.position == "top" then
        newOuterWall.x = 0
        newOuterWall.y = 0
        newOuterWall.size = {
            x = screenWidth,
            y = 1
        }
    end

    return setmetatable(newOuterWall, self)
end

function OuterWall:draw()
    self.game.graphics.rectangle("line", self.x, self.y, self.size.x, self.size.y)
end
