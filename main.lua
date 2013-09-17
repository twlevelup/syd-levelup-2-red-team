require 'input'
require 'player'
require 'obstacle'
require 'inner_wall'

love.animation = require 'vendor/anim8'

local entities = {}
local player = Player:new(love, {x = 0, y = 0})
local wall_1 = InnerWall:new(love, {x = 212, y = 155})
local wall_2 = InnerWall:new(love, {x = 212, y = 360})
local wall_3 = InnerWall:new(love, {x = 212, y = 560})

function love.load()
    table.insert(entities, player)
    table.insert(entities, obstacle)
    table.insert(entities, wall_1)
    table.insert(entities, wall_2)
    table.insert(entities, wall_3)

    love.input.bind('up', 'up')
    love.input.bind('left', 'left')
    love.input.bind('right', 'right')
    love.input.bind('down', 'down')
end

function love.update(dt)
    for _, entity in pairs(entities) do
        entity:update(dt)

        for _, other in pairs(entities) do
            if other ~= entity then
                if entity:collidingWith(other) then
                    entity:collide(other)
                end
            end
        end
    end
end

function love.draw()
    for _, e in pairs(entities) do
        e:draw()
    end
end
