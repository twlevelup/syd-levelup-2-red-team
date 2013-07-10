require 'player'

local entities = {}
local player = Player()

function love.load()
    table.insert(entities, player)
end

function love.draw()
    for _, e in pairs(entities) do
        e.draw(love.graphics)
    end
end
