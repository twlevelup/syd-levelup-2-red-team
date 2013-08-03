require 'input'

function Player(sound, animation)

    local self = {
        size = 20,
        x = 400,
        y = 300,
        speed = 5,
        _sprites = "assets/images/nyancat-sprites.png",
        sprites = nil,
        spriteFlippedH = false,
        grid = nil,
        animation = nil
    }

    local moving = false

    function self.draw(g)
        if self.sprites == nil then
            self.sprites = g.newImage(self._sprites)
        end

        if self.grid == nil then
            self.grid = animation.newGrid(100, 70, self.sprites:getWidth(), self.sprites:getHeight())
        end

        if self.animation == nil then
            self.animation = animation.newAnimation(self.grid("1-6", 1), 0.05)
        end

        self.animation:draw(self.sprites, self.x, self.y)
    end

    function self.update(dt, i)
        local dx = 0
        local dy = 0

        if i.pressed("left") then
            dx = dx - self.speed
            if not self.spriteFlippedH then
              self.spriteFlippedH = true
              self.animation:flipH()
            end
        end

        if i.pressed("right") then
            dx = dx + self.speed
            if self.spriteFlippedH then
              self.spriteFlippedH = false
              self.animation:flipH()
            end
        end

        if i.pressed("up") then
            dy = dy - self.speed
        end

        if i.pressed("down") then
            dy = dy + self.speed
        end

        local gonnaMove = dx ~= 0 or dy ~= 0
        if not moving and gonnaMove then
            sound.playLooping('assets/sounds/move.ogg', 'moving')
        end
        if moving and not gonnaMove then
            sound.stop('moving')
        end
        moving = gonnaMove

        self.x = self.x + dx
        self.y = self.y + dy

        if self.animation ~= nil then
            self.animation:update(dt)
        end
    end

    return self
end
