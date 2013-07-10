require 'player'

local entities = {}
local player = Player()

function love.load()
    table.insert(entities, player)
end

function get_move_input()
    local dx = 0
    local dy = 0

    if love.keyboard.isDown("left") then
        dx = dx - 1
    end

    if love.keyboard.isDown("right") then
        dx = dx + 1
    end

    if love.keyboard.isDown("up") then
        dy = dy - 1
    end

    if love.keyboard.isDown("down") then
        dy = dy + 1
    end

    return {dx, dy}
end

function love.update()
    move = get_move_input()
    player.move(move[1], move[2])
end

function love.draw()
    for _, e in pairs(entities) do
        e.draw(love.graphics)
    end
end
