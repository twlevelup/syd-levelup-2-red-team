require 'input'

function Player(game)
    local self = {
        size = 20,
        x = 400,
        y = 300,
        speed = 5,
        graphics = {
            source = "assets/images/nyancat-sprites.png",
            facing = "right"
        },
        sound = {
            moving = {
                source = "assets/sounds/move.wav"
            }
        }
    }

    if game.audio ~= nil then
        self.sound.moving.sample = game.audio.newSource(self.sound.moving.source)
        self.sound.moving.sample:setLooping(true)
    end

    if game.graphics ~= nil and game.animation ~= nil then
        self.graphics.sprites = game.graphics.newImage(self.graphics.source)
        self.graphics.grid = game.animation.newGrid(
            100, 70,
            self.graphics.sprites:getWidth(),
            self.graphics.sprites:getHeight()
        )
        self.graphics.animation = game.animation.newAnimation(
            self.graphics.grid("1-6", 1),
            0.05
        )
    end

    function self.draw()
        self.graphics.animation:draw(self.graphics.sprites, self.x, self.y)
    end

    function self.update(dt)
        local dx = 0
        local dy = 0

        if game.input.pressed("left") then
            dx = dx - self.speed

            if self.graphics.facing ~= "left" then
                self.graphics.animation:flipH()
                self.graphics.facing = "left"
            end
        end

        if game.input.pressed("right") then
            dx = dx + self.speed

            if self.graphics.facing ~= "right" then
                self.graphics.animation:flipH()
                self.graphics.facing = "right"
            end
        end

        if game.input.pressed("up") then
            dy = dy - self.speed
        end

        if game.input.pressed("down") then
            dy = dy + self.speed
        end

        self.x = self.x + dx
        self.y = self.y + dy

        if self.graphics.animation ~= nil then
            if dx ~= 0 or dy ~= 0 then
                self.graphics.animation:update(dt)
            else
                self.graphics.animation:gotoFrame(1)
            end
        end

        if self.sound.moving.sample ~= nil then
            if dx ~= 0 or dy ~= 0 then
                self.sound.moving.sample:play()
            else
                self.sound.moving.sample:stop()
            end
        end
    end

    return self
end
