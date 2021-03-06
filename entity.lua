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
    self.graphics.animation:draw(self.graphics.sprites, self.x, self.y + GAME_INFO_OFFSET_Y)
    if DEBUG_MODE then
        self.game.graphics.rectangle("line", self.x, self.y + GAME_INFO_OFFSET_Y, self.size.x, self.size.y)
    end
end

function Entity:bounds()
    return {
        top = self.y,
        left = self.x,
        bottom = self.y + self.size.y,
        right = self.x + self.size.x
    }
end

function Entity:collidingWith(other)
    local bounds = self:bounds()
    local other = other:bounds()

    local my_left_overlaps_their_right = bounds.left <= other.right
    local my_right_overlaps_their_left = bounds.right >= other.left

    local my_top_overlaps_their_bottom = bounds.top <= other.bottom
    local my_bottom_overlaps_their_top = bounds.bottom >= other.top

    return my_left_overlaps_their_right and my_right_overlaps_their_left and
            my_top_overlaps_their_bottom and my_bottom_overlaps_their_top
end

function Entity:collide(other)
end
