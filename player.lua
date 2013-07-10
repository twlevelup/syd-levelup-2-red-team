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

    function self.move(dx, dy)
        self.x = self.x + dx
        self.y = self.y + dy
    end

    return self
end
