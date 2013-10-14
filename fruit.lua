require 'entity'
require 'presets'

Fruit = {}
Fruit.__index = Fruit
setmetatable(Fruit, {__index = Entity})

function Fruit:new(game, config, flavour)
    local config = config or {}

    local newFruit = Entity:new(game)
    newFruit.type = "Fruit"
    newFruit.x = config.x or 0
    newFruit.y = config.y or 0
    newFruit.size = config.size or {
        x = 40,
        y = 40
    }
    -- if flavour isnt defined, choose a random one
    local flavour = flavour or Fruit:getRandomFlavour()
    newFruit.flavour = flavour
    newFruit.value = GAME_FRUIT_TYPES_NEW[flavour]

    newFruit.graphics = config.graphics or {
        source = "assets/images/" .. flavour .. ".png"
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

function Fruit:collide(other, fruitPlacer)
    -- remove fruit when player collides with it
    for i,v in pairs(entities) do
        if v == self then
            other:collect(self.value)
            table.remove(entities, i)
            fruitPlacer:place(1)
        end
    end
end

function Fruit:getRandomFlavour()
    -- collect just names of fruits (the key collection)
    local flavours = {}
    for k,v in pairs(GAME_FRUIT_TYPES_NEW) do
        table.insert(flavours, k)
    end
    -- return random flavour
    return flavours[math.random(#flavours)]
end

function Fruit:update(dt)

end