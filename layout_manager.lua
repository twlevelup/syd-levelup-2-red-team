require 'entity'

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

	local collides = false

    for itemNum = 1, #entities do
        if entities[itemNum]:collidingWith(entity) then
            collides = true
        end
    end

    if collides == false then
        table.insert(entities, entity)
    end

	return collides
end