require 'entity'

Fruit = {}
Fruit.__index = Fruit
setmetatable(Fruit, {__index = Entity})

function Fruit:new(game, config)
    local config = config or {}

    local newFruit = Entity:new(game)
    newFruit.type = "Fruit"
    newFruit.x = config.x or 0
    newFruit.y = config.y or 0
    newFruit.size = config.size or {
        x = 40,
        y = 40
    }

    newFruit.graphics = config.graphics or {
        source = "assets/images/apple.png"
    }

    if game.graphics ~= nil and game.animation ~= nil then
        newFruit.graphics.sprites = game.graphics.newImage(newFruit.graphics.source)
        newFruit.graphics.grid = game.animation.newGrid(
            newFruit.size.x, newFruit.size.y,
            newFruit.graphics.sprites:getWidth(),
            newFruit.graphics.sprites:getHeight()
        )
        newFruit.graphics.animation = game.animation.newAnimation(
            newFruit.graphics.grid("1-1", 1),
            0.5
        )
    end

    return setmetatable(newFruit, self)
end

function Fruit:update(dt)

end
