require 'input'
require 'player'
require 'obstacle'
require 'fruit'
require 'inner_wall'
require 'outer_wall'

love.animation = require 'vendor/anim8'

local GAME_TIME_LIMIT_SECONDS = 30
local timeLeft = GAME_TIME_LIMIT_SECONDS

local entities = {}
local player = Player:new(love, {x = 10, y = 10})
local wall_1 = InnerWall:new(love, {x = 200, y = 200})
local wall_2 = InnerWall:new(love, {x = 200, y = 400})
local wall_3 = InnerWall:new(love, {x = 200, y = 600})


local MAPSCALE_X = 128;
local MAPSCALE_Y = 96;

local fruit_at_grid_10 = Fruit:new(love, {x = 1*MAPSCALE_X, y = 0*MAPSCALE_Y}) 
local fruit_at_grid_70 = Fruit:new(love, {x = 7*MAPSCALE_X, y = 0*MAPSCALE_Y})
local fruit_at_grid_51 = Fruit:new(love, {x = 5*MAPSCALE_X, y = 1*MAPSCALE_Y}) 
local fruit_at_grid_33 = Fruit:new(love, {x = 3*MAPSCALE_X, y = 3*MAPSCALE_Y}) 
local fruit_at_grid_23 = Fruit:new(love, {x = 2*MAPSCALE_X, y = 3*MAPSCALE_Y}) 
local fruit_at_grid_64 = Fruit:new(love, {x = 6*MAPSCALE_X, y = 4*MAPSCALE_Y}) 
local fruit_at_grid_05 = Fruit:new(love, {x = 0*MAPSCALE_X, y = 5*MAPSCALE_Y}) 
local fruit_at_grid_45 = Fruit:new(love, {x = 4*MAPSCALE_X, y = 5*MAPSCALE_Y}) 
local fruit_at_grid_37 = Fruit:new(love, {x = 3*MAPSCALE_X, y = 7*MAPSCALE_Y}) 
local fruit_at_grid_77 = Fruit:new(love, {x = 7*MAPSCALE_X, y = 7*MAPSCALE_Y}) 


-- Outer Walls render all 4 render
local outerWalls = OuterWall:createWalls(love)

function love.load()
    timeStart = os.time()
    
    table.insert(entities, player)
    table.insert(entities, obstacle)
    table.insert(entities, wall_1)
    table.insert(entities, wall_2)
    table.insert(entities, wall_3)

    table.insert(entities, fruit_at_grid_10)
    table.insert(entities, fruit_at_grid_70)
    table.insert(entities, fruit_at_grid_51)
    table.insert(entities, fruit_at_grid_33) 
    table.insert(entities, fruit_at_grid_23)
    table.insert(entities, fruit_at_grid_64) 
    table.insert(entities, fruit_at_grid_05)
    table.insert(entities, fruit_at_grid_45)
    table.insert(entities, fruit_at_grid_37)
    table.insert(entities, fruit_at_grid_77)


    -- Loop insert OuterWalls, "#<tablename>" returns number of elements in table
    for i = 0, #outerWalls do
        table.insert(entities, outerWalls[i])
    end

    -- Bind keystroke commands
    love.input.bind('up', 'up')
    love.input.bind('left', 'left')
    love.input.bind('right', 'right')
    love.input.bind('down', 'down')
end

function love.update(dt)
    local currentElapsedTime = os.time() - timeStart
    timeLeft = os.date("%M:%S", GAME_TIME_LIMIT_SECONDS - currentElapsedTime)
    
    if (timeLeft == "00:00") then
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
    love.graphics.printf(timeLeft, 10, 10, 10, "left")

    for _, e in pairs(entities) do
        e:draw()
    end
end