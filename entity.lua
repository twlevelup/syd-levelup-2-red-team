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
    local b = self:bounds()
    local otherb = other:bounds()

    return not (otherb.left > b.right or 
        otherb.right < b.left or 
        otherb.top > b.bottom or
        otherb.bottom < b.top)
end

function Entity:collide(other)
end