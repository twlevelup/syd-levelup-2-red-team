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

		it("should be able to create 5 fruits in 5 different positions", function()

			local fruit5 = Fruit:randomlyPlace({}, fruits, {}, 5)
			for _, fruitA in pairs(fruits) do
				for _, fruitB in pairs(fruits) do
					if fruitA ~= fruitB then
						assert.is_not.equal({fruitA.x, fruitA.y}, {fruitB.x, fruitB.y})
					end
				end
			end

		end)

		it("should be able to create fruit which don't collide with walls", function() 

			entities = {}

			wallConfig1 = {
				x = 60,
				y = 60,
				size = {
					x = 500,
					y = 50
				}
			}

			wall1 = InnerWall:new(wallConfig1)

			wallConfig2 = {
				x = 60,
				y = 170,
				size = {
					x = 600,
					y = 50
				}
			}

			wall2 = InnerWall:new(wallConfig2)


			wallConfig3 = {
				x = 60,
				y = 350,
				size = {
					x = 400,
					y = 70
				}
			}

			wall3 = InnerWall:new(wallConfig3)

			table.insert(entities, wall1)
			table.insert(entities, wall2)
			table.insert(entities, wall3)

			local fruits = Fruit:randomlyPlace({}, entities, {}, 5)

			for _, fruit in pairs(fruits) do
				for _, entity in pairs(entities) do
					if fruit ~= entity then
						assert.is_false(fruit:collidingWith(entity))
					end
				end
			end

		end)

	end)

end)