function Input()
    local bindings = {}
    local pressed = {}
    local released = {}

    local self = {}


    self.bind = function(key, action)
        bindings[key] = action
    end

    self.pressed = function(action)
        return pressed[action]
    end

    love.keypressed = function(key)
        local action = bindings[key]

        if action ~= nil then
            pressed[action] = true
        end
    end

    love.keyreleased = function(key)
        local action = bindings[key]

        if action ~= nil then
            pressed[action] = false
        end
    end

    return self
end

if not love then
    love = {}
end

love.input = Input()
