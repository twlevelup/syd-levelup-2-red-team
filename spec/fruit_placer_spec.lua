require 'fruit_placer'

describe("Fruit Placer", function()

	it("should place exactly the right amount of fruits on the board", function()

		entities = {}
		fruitPlacer = FruitPlacer:new({}, entities)

		fruitPlacer:place(2)

		assert.is_equal(2, #entities)

		for _,v in pairs(entities) do
			assert.is_equal("Fruit", v.type)
		end

	end)


end)