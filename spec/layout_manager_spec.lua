require 'layout_manager'
require 'inner_wall'
require 'fruit'

describe('Layout Manager', function()

	it("should be able to create fruit which don't collide with walls", function() 

			entities = {}

			layoutManager = LayoutManager:new({}, entities)

			wallConfig1 = {
				x = 60,
				y = 60,
				size = {
					x = 500,
					y = 50
				}
			}

			wall1 = InnerWall:new({}, wallConfig1, 1)

			wallConfig2 = {
				x = 60,
				y = 170,
				size = {
					x = 600,
					y = 50
				}
			}

			wall2 = InnerWall:new({}, wallConfig2, 1)


			wallConfig3 = {
				x = 60,
				y = 350,
				size = {
					x = 400,
					y = 70
				}
			}

			wall3 = InnerWall:new({}, wallConfig3, 1)

			table.insert(entities, wall1)
			table.insert(entities, wall2)
			table.insert(entities, wall3)


			local config = {
				x = 5,
				y = 5
			}
			local fruit1 = Fruit:new({}, config, "orange")
			local expected = layoutManager:place(fruit1)

			assert.is_false(expected)

			config = {
				x = 60,
				y = 350
			}

			local fruit2 = Fruit:new({}, config, "orange")
			local expected = layoutManager:place(fruit1)

			assert.is_true(expected)
		end)


end)