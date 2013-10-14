require 'fruit'
require 'presets'

describe("Fruit", function()

	describe("Fruit flavours", function()
		it("should assign a fruit flavour if not given", function()
			-- create new fruit without flavour
			-- check flavour value after

			local fruit = Fruit:new({}, {})

			assert.is_not(fruit.flavour, nil)
		end)

		it("should display different types of fruit", function()
			-- collect image for every fruit in types table
			local fruits = {}
			local count = 0
			for k,v in pairs(GAME_FRUIT_TYPES_NEW) do
		        local newFruit = Fruit:new({}, {}, k)
		        local image = newFruit.graphics.source

		        -- use image value as key
		        -- thereby creating a Set
		        table.insert(fruits, 1, image)
		        count = count + 1
		    end

		    -- if Set and vector size differ, non unique value exists
		    assert.is_true(count == #fruits)
		end)

		--[[it("should have unique scores per fruit type", function()

		end)

		it("should only show one golden pineapple", function()
			-- check entities table
		end)]]

	end)

end)