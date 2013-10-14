require 'input'
require 'player'
require 'obstacle'
require 'fruit'
require 'inner_wall'
require 'outer_wall'
require 'time'
require 'presets'
require 'fruit_placer'
require 'scoreboard'
require 'popup'
require 'background_image'

love.animation = require 'vendor/anim8'

entities = {}
fruits = {}

local player1 = Player:new(love, {x = 10, y = 10})

local player2 = Player:new(love, {
    x = GAME_WIDTH - 200,
    y = GAME_HEIGHT - GAME_INFO_OFFSET_Y - 200,
    playerNumber = 2,
    keys = {
        up = "w",
        down = "s",
        left = "a",
        right = "d"
    },
    graphics = {
        source = "assets/images/nyancat-sprites-playerO.png",
        facing = "right"
    },
    sound = {
        moving = {
            source = "assets/sounds/move2.wav"
        }
    }    
})

local wall_1 = InnerWall:new(love, {x = 200, y = 200}, 1)
local wall_2 = InnerWall:new(love, {x = 200, y = 400}, 2)
local wall_3 = InnerWall:new(love, {x = 200, y = 600}, 3)

local backgroundImage = BackgroundImage:new(love)

-- Outer Walls render all 4 render
local outerWalls = OuterWall:createWalls(love)

function love.load()
    time = Time:new(GAME_TIME_LIMIT_SECONDS)
    time:start(os.time());
    scoreboard = Scoreboard:new()

    table.insert(entities, player1)
    table.insert(entities, player2)
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

    love.input.bind('w', 'w')
    love.input.bind('a', 'a')
    love.input.bind('d', 'd')
    love.input.bind('s', 's')


end

function love.update(dt)
    time:tick(os.time())

    if (time.finished) then
        thread = love.thread.getThread("die_thread")
        if thread then
             if thread:get('ready') then
                love.event.push('quit')
            end
        else
            thread = love.thread.newThread("die_thread", "die.lua")
            thread:start()
        end

    else

        for _, entity in pairs(entities) do
            entity:update(dt)

            for _, other in pairs(entities) do
                if other ~= entity then
                    if entity:collidingWith(other) then
                        if other.type == 'Fruit' then
                            entity:collide(other)
                            other:collide(entity, fruitPlacer)
                        elseif entity.type == 'Fruit' then
                            entity:collide(other, fruitPlacer)
                            other:collide(entity)
                        else
                            entity:collide(other)
                            other:collide(entity)
                        end

                    end
                end;
            end

        end

    end

end

function love.draw()
    
    backgroundImage:fillBackground()

    for _, e in pairs(entities) do
        e:draw()
    end

    time:draw()
    player1.scoreboard:draw()
    player2.scoreboard:draw()

    if time:game_over() then
        
        local popup

        if player1.scoreboard.score > player2.scoreboard.score then
            popup = Popup:new("Game Over! Player 1 Wins!!")
        elseif player2.scoreboard.score > player1.scoreboard.score then
            popup = Popup:new("Game Over! Player O Wins!!")
        else
            popup = Popup:new("Game Over! It's a tie!!")
        end

        popup:draw()
    end

    backgroundImage:drawBottomFence()

end
