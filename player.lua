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

    newPlayer.blocked = {
        left = false,
        right = false,
        top = false,
        bottom = false
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

function Player:currentDirection()
    if self.lastPosition.x == nil or self.lastPosition.y == nil then
        return nil
    end

    if self.y > self.lastPosition.y then
        return "bottom"
    elseif self.y < self.lastPosition.y then
        return "top"
    elseif self.x > self.lastPosition.x then
        return "right"
    elseif self.x < self.lastPosition.x then
        return "left"
    end
end

function Player:collide(other)
    local collidingSide = self:currentDirection()
    if collidingSide ~= nil then
        self.blocked[collidingSide] = true
    end
end

function Player:update(dt)
    local dx = 0
    local dy = 0

    if self.game.input.pressed(self.keys.left) then
        if not self.blocked.left then
            dx = dx - self.speed
        end

        if self.graphics.facing ~= "left" then
            self.graphics.animation:flipH()
            self.graphics.facing = "left"
        end
    end

    if self.game.input.pressed(self.keys.right) then
        if not self.blocked.right then
            dx = dx + self.speed
        end

        if self.graphics.facing ~= "right" then
            self.graphics.animation:flipH()
            self.graphics.facing = "right"
        end
    end

    if self.game.input.pressed(self.keys.up) then
        if not self.blocked.up then
            dy = dy - self.speed
        end
    end

    if self.game.input.pressed(self.keys.down) then
        if not self.blocked.down then
            dy = dy + self.speed
        end
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

    print("before reset up: " .. tostring(self.blocked.up))
    print("before reset down: " .. tostring(self.blocked.down))
    print("before reset left: " .. tostring(self.blocked.left))
    print("before reset right: " .. tostring(self.blocked.right))

    for _, edge in pairs(self.blocked) do
        edge = false
    end

    print("after reset up: " .. tostring(self.blocked.up))
    print("after reset down: " .. tostring(self.blocked.down))
    print("after reset left: " .. tostring(self.blocked.left))
    print("after reset right: " .. tostring(self.blocked.right))
end
