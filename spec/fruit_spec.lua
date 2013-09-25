require 'fruit'

describe("Fruit", function()

	describe("randomlyPlace", function()

		local fruits = {}

		before_each(function()
			fruit1 = Fruit:randomlyPlace({},fruits, {}, 1)
		end)

		it("should randomly generate the fruit positions", function()

			local fruit2 = Fruit:randomlyPlace({}, fruits, {}, 1)

			assert.is_not.equal({fruit1[1].x, fruit1[1].y}, {fruit2[1].x, fruit2[1].y})

		end)

		it("should be able to create 5 fruits without repeating", function()

			local fruit5 = Fruit:randomlyPlace({}, fruits, {}, 5)
			for _, fruitA in pairs(fruits) do
				for _, fruitB in pairs(fruits) do
					if fruitA ~= fruitB then
						assert.is_not.equal({fruitA.x, fruitB.y}, {fruitB.x, fruitB.y})
					end
				end
			end

		end)

	end)

end)