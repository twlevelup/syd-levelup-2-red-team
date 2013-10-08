require 'input'
require 'player'
require 'obstacle'
require 'fruit'
require 'inner_wall'
require 'outer_wall'
require 'time'
require 'presets'
require 'fruit_placer'

love.animation = require 'vendor/anim8'

entities = {}
fruits = {}

local player = Player:new(love, {x = 10, y = 10})
local wall_1 = InnerWall:new(love, {x = 200, y = 200})
local wall_2 = InnerWall:new(love, {x = 200, y = 400})
local wall_3 = InnerWall:new(love, {x = 200, y = 600})

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

    for i = 1, #outerWalls do
        table.insert(entities, outerWalls[i])
    end

    -- fruits = Fruit:randomlyPlace(love, entities, {}, 10)
    fruitPlacer = FruitPlacer:new(love, entities)
    fruitPlacer:place(10)

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
                    if other.type == 'Fruit' then
                        entity:collide(other)
                        other:collide(entity, fruitPlacer)
                    else
                        entity:collide(other)
                        other:collide(entity)
                    end

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
