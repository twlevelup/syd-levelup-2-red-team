require 'fruit'

LayoutManager = {}
LayoutManager.__index = LayoutManager

function LayoutManager:new(game, entities)
	local newLayoutManager = {
		entities = entities or {},
		game = game or {}
	}
	return setmetatable(newLayoutManager, self)
end	

function LayoutManager:place(entity)

 --    fruits = {}
    local config = config or {}
 --    local collides = false
 --    local randomX = 0
 --    local randomY = 0
 --    local i = 1

    config.x = math.random(1024)
    config.y = math.random(768)



	-- local fruit = Fruit:new({})
	return fruit
end