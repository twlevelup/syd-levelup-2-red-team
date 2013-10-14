require 'fruit'
require 'presets'


FruitFactory = {}
FruitFactory.__index = FruitFactory

function FruitFactory:new()
	local newFruitFactory = {
		
	}
	return setmetatable(newFruitFactory, self)
end	

function FruitFactory:createRandomFruit(game)

    local config = config or {}
    local game = game or {}

    config.x = math.random(GAME_WIDTH - GAME_FRUIT_SIDE_LENGTH - (2*GAME_FENCE_BUFFER)) + GAME_FENCE_BUFFER
    config.y = math.random(GAME_HEIGHT - GAME_INFO_OFFSET_Y - GAME_FRUIT_SIDE_LENGTH - (2*GAME_FENCE_BUFFER)) + GAME_FENCE_BUFFER
    local fruit = Fruit:new(game, config)

	return fruit
end