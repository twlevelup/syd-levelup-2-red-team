require 'fruit_factory'

describe("FruitFactory", function()
	describe("generateFruit", function()
		local fruitFactory = FruitFactory:new({})
		local fruits = {}

		fruit = fruitFactory.createRandomFruit()

		assert.is.equal("Fruit", fruit.type)
	end)

	after_each(function()
		math.random = old_random
	end)

	describe("generateFruit should return randomly positioned fruit", function() 
		old_random = math.random
		math.random = function(a, b)
			return 42
		end
		local fruitFactory = FruitFactory:new({})
		local fruits = {}
		
		fruit = fruitFactory.createRandomFruit()


		assert.is.equal(42, fruit.x)
		assert.is.equal(42, fruit.y)

		math.random = old_random
	end)

end)