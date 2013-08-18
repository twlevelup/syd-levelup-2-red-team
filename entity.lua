Entity = {}
Entity.__index = Entity

function Entity:new(game)
    local newObj = {
        game = game,
        x = 0,
        y = 0
    }
    return setmetatable(newObj, self)
end

function Entity:draw()
    self.graphics.animation:draw(self.graphics.sprites, self.x, self.y)
end

function Entity:bounds()
    return {
        top = self.y,
        left = self.x,
        bottom = self.y + self.size,
        right = self.x + self.size
    }
end

function Entity:handleCollision(other)
    if self:collidingWith(other) then
        self:collide(other)
    end
end

function Entity:collidingWith(other)
    local bounds = self:bounds()
    local otherBounds = other:bounds()

    return not (otherBounds.left > bounds.right or
        otherBounds.right < bounds.left or
        otherBounds.top > bounds.bottom or
        otherBounds.bottom < bounds.top)
end

function Entity:collide(other)
end
