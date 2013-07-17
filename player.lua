require 'input'

function Player()
    local self = {
        size = 20,
        x = 400,
        y = 300
    }

    function self.draw(g)
        g.rectangle(
            'line',
            self.x - (self.size / 2),
            self.y - (self.size / 2),
            self.size, self.size
        )

        g.point(self.x, self.y, 1)
    end

    function self.update(i)
        local dx = 0
        local dy = 0

        if i.pressed("left") then
            dx = dx - 1
        end

        if i.pressed("right") then
            dx = dx + 1
        end

        if i.pressed("up") then
            dy = dy - 1
        end

        if i.pressed("down") then
            dy = dy + 1
        end

        self.x = self.x + dx
        self.y = self.y + dy
    end

    return self
end
