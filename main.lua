require 'input'
require 'player'

require 'vendor/TEsound'

local entities = {}
local player = Player(TEsound)

function love.load()
    table.insert(entities, player)
    love.input.bind('up', 'up')
    love.input.bind('left', 'left')
    love.input.bind('right', 'right')
    love.input.bind('down', 'down')

    TEsound.playLooping('assets/sounds/nyan.ogg', 'background')
    TEsound.volume('background', 0.4)
end

function love.update()
    TEsound.cleanup()
    for _, e in pairs(entities) do
        e.update(love.input)
    end
end

function love.draw()
    for _, e in pairs(entities) do
        e.draw(love.graphics)
    end
end
