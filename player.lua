require 'input'
require 'entity'

Player = {}
Player.__index = Player
setmetatable(Player, {__index = Entity})

function Player:new(game, config)
    local config = config or {}

    local newPlayer = Entity:new(game)
    newPlayer.type = "player"
    newPlayer.x = config.x or 400
    newPlayer.y = config.y or 300
    newPlayer.size = config.size or {
        x = 98,
        y = 60
    }

    newPlayer.speed = config.speed or 5

    newPlayer.keys = config.keys or {
        up = "up",
        down = "down",
        left = "left",
        right = "right"
    }

    newPlayer.graphics = config.graphics or {
        source = "assets/images/nyancat-sprites.png",
        facing = "right"
    }

    newPlayer.sound = config.sound or {
        moving = {
            source = "assets/sounds/move.wav"
        }
    }

    newPlayer.lastPosition = {
        x = nil,
        y = nil
    }

    if game.audio ~= nil then
        newPlayer.sound.moving.sample = game.audio.newSource(newPlayer.sound.moving.source)
        newPlayer.sound.moving.sample:setLooping(true)
    end

    if game.graphics ~= nil and game.animation ~= nil then
        newPlayer.graphics.sprites = game.graphics.newImage(newPlayer.graphics.source)
        newPlayer.graphics.grid = game.animation.newGrid(
            newPlayer.size.x, newPlayer.size.y,
            newPlayer.graphics.sprites:getWidth(),
            newPlayer.graphics.sprites:getHeight()
        )
        newPlayer.graphics.animation = game.animation.newAnimation(
            newPlayer.graphics.grid("1-6", 1),
            0.05
        )
    end

    return setmetatable(newPlayer, self)
end

function Player:collide(other)
    self.x = self.lastPosition.x
    self.y = self.lastPosition.y
end

function Player:collect(points)
    -- TODO: add to score
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

    self.lastPosition = {
        x = self.x,
        y = self.y
    }

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
