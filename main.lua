require 'input'
require 'player'

local sound = require 'vendor/TEsound'
local animation = require 'vendor/anim8'

local entities = {}
local player = Player(sound, animation)

function love.load()
    table.insert(entities, player)

    love.input.bind('up', 'up')
    love.input.bind('left', 'left')
    love.input.bind('right', 'right')
    love.input.bind('down', 'down')

    sound.playLooping('assets/sounds/nyan.ogg', 'background')
    sound.volume('background', 0.4)
end

function love.update(dt)
    sound.cleanup()
    for _, e in pairs(entities) do
        e.update(dt, love.input)
    end
end

function love.draw()
    for _, e in pairs(entities) do
        e.draw(love.graphics)
    end
end
