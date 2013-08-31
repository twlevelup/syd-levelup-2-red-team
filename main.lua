require 'input'
require 'player'

love.animation = require 'vendor/anim8'

local entities = {}
local player = Player:new(love, {x = 100, y = 100})

function love.load()
    table.insert(entities, player)

    love.input.bind('up', 'up')
    love.input.bind('left', 'left')
    love.input.bind('right', 'right')
    love.input.bind('down', 'down')
end

function love.update(dt)
    for _, e in pairs(entities) do
        for _, other in pairs(entities) do
            if other ~= e then
                e:handleCollision(other)
            end
        end

        e:update(dt)
    end
end

function love.draw()
    for _, e in pairs(entities) do
        e:draw()
    end
end
