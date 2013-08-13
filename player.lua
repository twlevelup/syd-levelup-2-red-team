require 'input'

Player = {}

function Player:new(game)
    newObj = {
        game = game,
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
        newObj.sound.moving.sample = game.audio.newSource(newObj.sound.moving.source)
        newObj.sound.moving.sample:setLooping(true)
    end

    if game.graphics ~= nil and game.animation ~= nil then
        newObj.graphics.sprites = game.graphics.newImage(newObj.graphics.source)
        newObj.graphics.grid = game.animation.newGrid(
            100, 70,
            newObj.graphics.sprites:getWidth(),
            newObj.graphics.sprites:getHeight()
        )
        newObj.graphics.animation = game.animation.newAnimation(
            newObj.graphics.grid("1-6", 1),
            0.05
        )
    end

    self.__index = self
    return setmetatable(newObj, self)
end

function Player:draw()
    self.graphics.animation:draw(self.graphics.sprites, self.x, self.y)
end

function Player:update(dt)
    local dx = 0
    local dy = 0

    if self.game.input.pressed("left") then
        dx = dx - self.speed

        if self.graphics.facing ~= "left" then
            self.graphics.animation:flipH()
            self.graphics.facing = "left"
        end
    end

    if self.game.input.pressed("right") then
        dx = dx + self.speed

        if self.graphics.facing ~= "right" then
            self.graphics.animation:flipH()
            self.graphics.facing = "right"
        end
    end

    if self.game.input.pressed("up") then
        dy = dy - self.speed
    end

    if self.game.input.pressed("down") then
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