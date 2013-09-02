require 'input'
require 'player'
require 'obstacle'

love.animation = require 'vendor/anim8'

local entities = {}
local player = Player:new(love, {x = 100, y = 100})
local obstacle = Obstacle:new(love, {x = 200, y = 200})

function love.load()
    table.insert(entities, player)
    table.insert(entities, obstacle)

    love.input.bind('up', 'up')
    love.input.bind('left', 'left')
    love.input.bind('right', 'right')
    love.input.bind('down', 'down')
end

function love.update(dt)
    for _, e in pairs(entities) do
        e:update(dt)

        for _, other in pairs(entities) do
            if other ~= e then
                e:handleCollision(other)
            end
        end
    end
end

function love.draw()
    for _, e in pairs(entities) do
        e:draw()
    end
end
