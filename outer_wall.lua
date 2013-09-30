require 'obstacle'

OuterWall = {}
OuterWall.__index = OuterWall
setmetatable(OuterWall, {__index = Obstacle})

local GAME_FIELD_BOTTOM_OFFSET = 50

function OuterWall:createWalls(game)
    local walls = {}

    local leftWall = OuterWall:new(game, {position = "left"})
    local rightWall = OuterWall:new(game, {position = "right"})
    local topWall = OuterWall:new(game, {position = "top"})
    local bottomWall = OuterWall:new(game, {position = "bottom"})

    table.insert(walls, leftWall)
    table.insert(walls, rightWall)
    table.insert(walls, topWall)
    table.insert(walls, bottomWall)

    return walls
end


function OuterWall:new(game, config)
    local config = config or {}

    local screenHeight = 768 -- - GAME_FIELD_BOTTOM_OFFSET
    local screenWidth = 1024

    local newOuterWall = Obstacle:new(game)
    newOuterWall.type = "outer-wall"
    newOuterWall.position = config.position or "left"
    newOuterWall.x = config.x or 0
    newOuterWall.y = config.y or 0
    newOuterWall.size = config.size or {
        x = 1,
        y = screenHeight
    }

    if newOuterWall.position == "bottom" then
        newOuterWall.x = 0
        newOuterWall.y = screenHeight
        newOuterWall.size = {
            x = screenWidth,
            y = 1
        }
    elseif newOuterWall.position == "left" then
        newOuterWall.x = 0
        newOuterWall.y = 0
        newOuterWall.size = {
            x = 1,
            y = screenHeight
        }
    elseif newOuterWall.position == "right" then
        newOuterWall.x = screenWidth
        newOuterWall.y = 0
        newOuterWall.size = {
            x = 1,
            y = screenHeight
        }
    elseif newOuterWall.position == "top" then
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
