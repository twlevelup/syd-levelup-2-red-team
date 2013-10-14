require 'fruit'
require 'entity'
require 'layout_manager'
require 'fruit_factory'


FruitPlacer = {}
FruitPlacer.__index = FruitPlacer

function FruitPlacer:new(game, entities)
	local newFruitPlacer = {
        layoutManager = LayoutManager:new(game, entities),
        fruitFactory = FruitFactory:new(),
        entities = entities or {},
        game = game or {}
	}
	return setmetatable(newFruitPlacer, self)
end	

function FruitPlacer:place(count)

    local i = 1
    local collides = false

    while i <= count do

        local fruit = self.fruitFactory:createRandomFruit(self.game)
        collides = self.layoutManager:place(fruit)

        if not collides then
            i = i + 1
        end
    end

end