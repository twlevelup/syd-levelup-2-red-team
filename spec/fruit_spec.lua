require 'fruit'

describe("Fruit", function()

	describe("randomlyPlace", function()

		local fruits = {}

		before_each(function()
			fruit1 = Fruit:randomlyPlace({},fruits, {}, 1)
		end)

		it("should randomly generate the fruit positions", function()

			local fruit2 = Fruit:randomlyPlace({}, fruits, {}, 1)

			assert.is_not.equal(fruits[1].x, fruit2[1].x)

		end)

		it("should be able to create 5 fruits without repeating", function()


		end)

	end)

end)