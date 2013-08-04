require 'input'
require 'player'

love.animation = require 'vendor/anim8'

local entities = {}
local player = Player()

function love.load()
    table.insert(entities, player)

    love.input.bind('up', 'up')
    love.input.bind('left', 'left')
    love.input.bind('right', 'right')
    love.input.bind('down', 'down')
end

function love.update(dt)
    for _, e in pairs(entities) do
        e.update(dt, love)
    end
end

function love.draw()
    for _, e in pairs(entities) do
        e.draw(love)
    end
end
