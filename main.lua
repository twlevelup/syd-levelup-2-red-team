require 'input'
require 'player'
require 'TEsound'

local entities = {}
local player = Player()

function love.load()
    table.insert(entities, player)
    love.input.bind('up', 'up')
    love.input.bind('left', 'left')
    love.input.bind('right', 'right')
    love.input.bind('down', 'down')

    TEsound.play('sfx/blip.ogg')
end

function love.update()
    for _, e in pairs(entities) do
        e.update(love.input)
    end
end

function love.draw()
    for _, e in pairs(entities) do
        e.draw(love.graphics)
    end
end
