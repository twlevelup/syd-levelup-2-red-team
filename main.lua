require 'input'
require 'player'
require 'obstacle'
require 'fruit'
require 'inner_wall'
require 'outer_wall'

love.animation = require 'vendor/anim8'

local entities = {}
local player = Player:new(love, {x = 10, y = 10})
local wall_1 = InnerWall:new(love, {x = 200, y = 200})
local wall_2 = InnerWall:new(love, {x = 200, y = 400})
local wall_3 = InnerWall:new(love, {x = 200, y = 600})
local fruits = {}

-- Outer Walls render all 4 render
local outerWalls = OuterWall:createWalls(love)

function love.load()
    table.insert(entities, player)
    table.insert(entities, obstacle)
    table.insert(entities, wall_1)
    table.insert(entities, wall_2)
    table.insert(entities, wall_3)

    -- Loop insert OuterWalls, "#<tablename>" returns number of elements in table
    for i = 1, #outerWalls do
        table.insert(entities, outerWalls[i])
    end

    -- Create fruit
    fruits = Fruit:randomlyPlace(love, entities, {}, 10)

    -- Bind keystroke commands
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
