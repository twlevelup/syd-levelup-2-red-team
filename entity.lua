Entity = {}
Entity.__index = Entity

function Entity:new(game)
    local newEntity = {
        game = game,
        x = 0,
        y = 0
    }

    return setmetatable(newEntity, self)
end

function Entity:draw()
    self.graphics.animation:draw(self.graphics.sprites, self.x, self.y)
    self.game.graphics.rectangle("line", self.x, self.y, self.size.x, self.size.y)
end

function Entity:bounds()
    return {
        top = self.y,
        left = self.x,
        bottom = self.y + self.size.x,
        right = self.x + self.size.y
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

    local left = bounds.left <= otherBounds.left and bounds.right >= otherBounds.left
    local right = bounds.left >= otherBounds.left and bounds.left <= otherBounds.right
    local top = bounds.top <= otherBounds.top and bounds.bottom >= otherBounds.top
    local bottom = bounds.top >= otherBounds.top and bounds.top <= otherBounds.bottom

    return (left or right) and (top or bottom)
end

end

function Entity:collide(other, collidingSide)
end
