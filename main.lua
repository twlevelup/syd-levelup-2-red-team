require 'input'
require 'player'
require 'obstacle'
require 'fruit'
require 'inner_wall'
require 'outer_wall'
require 'time'

love.animation = require 'vendor/anim8'

local GAME_TIME_LIMIT_SECONDS = 180

local entities = {}
local player = Player:new(love, {x = 10, y = 10})
local wall_1 = InnerWall:new(love, {x = 200, y = 200})
local wall_2 = InnerWall:new(love, {x = 200, y = 400})
local wall_3 = InnerWall:new(love, {x = 200, y = 600})

-- Fruits
local MAPSCALE_X = 128;
local MAPSCALE_Y = 96;

fruits = {}

-- First Row Fruits
local fruit_at_grid_11 = Fruit:new(love, {x = 1*MAPSCALE_X, y = 1*MAPSCALE_Y}) 
local fruit_at_grid_41 = Fruit:new(love, {x = 4*MAPSCALE_X, y = 1*MAPSCALE_Y})
local fruit_at_grid_71 = Fruit:new(love, {x = 7*MAPSCALE_X, y = 1*MAPSCALE_Y}) 

-- Second Row Fruits
local fruit_at_grid_33 = Fruit:new(love, {x = 3*MAPSCALE_X, y = 3*MAPSCALE_Y}) 
local fruit_at_grid_53 = Fruit:new(love, {x = 5*MAPSCALE_X, y = 3*MAPSCALE_Y}) 

-- Third Row Fruits
local fruit_at_grid_15 = Fruit:new(love, {x = 1*MAPSCALE_X, y = 5*MAPSCALE_Y}) 
local fruit_at_grid_45 = Fruit:new(love, {x = 4*MAPSCALE_X, y = 5*MAPSCALE_Y}) 
local fruit_at_grid_75 = Fruit:new(love, {x = 7*MAPSCALE_X, y = 5*MAPSCALE_Y}) 

-- Fourth Row Fruits
local fruit_at_grid_37 = Fruit:new(love, {x = 3*MAPSCALE_X, y = 7*MAPSCALE_Y}) 
local fruit_at_grid_57 = Fruit:new(love, {x = 5*MAPSCALE_X, y = 7*MAPSCALE_Y}) 

table.insert(fruits, fruit_at_grid_11)
table.insert(fruits, fruit_at_grid_41)
table.insert(fruits, fruit_at_grid_71)
table.insert(fruits, fruit_at_grid_33)
table.insert(fruits, fruit_at_grid_53)
table.insert(fruits, fruit_at_grid_15)
table.insert(fruits, fruit_at_grid_45)
table.insert(fruits, fruit_at_grid_75)
table.insert(fruits, fruit_at_grid_37)
table.insert(fruits, fruit_at_grid_57)


-- Outer Walls render all 4 render
local outerWalls = OuterWall:createWalls(love)

function love.load()
    time = Time:new(GAME_TIME_LIMIT_SECONDS)
    time:start(os.time());

    table.insert(entities, player)
    table.insert(entities, obstacle)
    table.insert(entities, wall_1)
    table.insert(entities, wall_2)
    table.insert(entities, wall_3)

    -- Loop insert OuterWalls, "#<tablename>" returns number of elements in table
    for i = 0, #outerWalls do
        table.insert(entities, outerWalls[i])
    end

    -- Load fruits
    for i = 0, #fruits do
        table.insert(entities, fruits[i])
    end

    -- Bind keystroke commands
    love.input.bind('up', 'up')
    love.input.bind('left', 'left')
    love.input.bind('right', 'right')
    love.input.bind('down', 'down')
end

function love.update(dt)
    time:tick(os.time())

    if (time.finished) then
        love.event.push('quit')
    end

    for _, entity in pairs(entities) do
        entity:update(dt)

        for _, other in pairs(entities) do
            if other ~= entity then
                if entity:collidingWith(other) then
                    entity:collide(other)
                end
            end;
        end
    end
end

function love.draw()
    for _, e in pairs(entities) do
        e:draw()
    end

    time:draw()
end
