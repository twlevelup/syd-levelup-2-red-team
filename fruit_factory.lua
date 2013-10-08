require 'fruit'

FruitFactory = {}
FruitFactory.__index = FruitFactory

function FruitFactory:new(game)
	local newFruitFactory = {
		
	}
	return setmetatable(newFruitFactory, self)
end	

function FruitFactory:createRandom(game)

    local config = config or {}

    config.x = math.random(1024)
    config.y = math.random(768)
    local fruit = Fruit:new({}, config)


	-- local fruit = Fruit:new({})
	return fruit
end