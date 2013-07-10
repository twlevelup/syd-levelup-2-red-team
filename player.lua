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

    return self
end
