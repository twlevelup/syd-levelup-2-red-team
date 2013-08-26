require 'input'
require 'entity'

Player = {}
Player.__index = Player
setmetatable(Player, {__index = Entity})

function Player:new(game, config)
    local config = config or {}

    local newObj = Entity:new(game)
    newObj.x = config.x or 400
    newObj.y = config.y or 300
    newObj.size = config.size or 20
    newObj.speed = config.speed or 5

    newObj.keys = config.keys or {
        up = "up",
        down = "down",
        left = "left",
        right = "right"
    }

    newObj.graphics = config.graphics or {
        source = "assets/images/nyancat-sprites.png",
        facing = "right"
    }
    newObj.sound = config.sound or {
        moving = {
            source = "assets/sounds/move.wav"
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

    return setmetatable(newObj, self)
end

function Player:update(dt)
    local dx = 0
    local dy = 0

    if self.game.input.pressed(self.keys.left) then
        dx = dx - self.speed

        if self.graphics.facing ~= "left" then
            self.graphics.animation:flipH()
            self.graphics.facing = "left"
        end
    end

    if self.game.input.pressed(self.keys.right) then
        dx = dx + self.speed

        if self.graphics.facing ~= "right" then
            self.graphics.animation:flipH()
            self.graphics.facing = "right"
        end
    end

    if self.game.input.pressed(self.keys.up) then
        dy = dy - self.speed
    end

    if self.game.input.pressed(self.keys.down) then
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
