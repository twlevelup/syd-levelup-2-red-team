require 'input'

function Player()
    local self = {
        size = 20,
        x = 400,
        y = 300,
        speed = 5,
        _cat_image = "assets/images/cat.png",
        sprite = nil
    }

    function self.draw(g)
        if self.sprite == nil then
            self.sprite = g.newImage("assets/images/nyancat.png")
        end

        g.draw(
            self.sprite,
            self.x - (self.size / 2),
            self.y - (self.size / 2)
        )
    end

    function self.update(i)
        local dx = 0
        local dy = 0

        if i.pressed("left") then
            dx = dx - self.speed
        end

        if i.pressed("right") then
            dx = dx + self.speed
        end

        if i.pressed("up") then
            dy = dy - self.speed
        end

        if i.pressed("down") then
            dy = dy + self.speed
        end

        self.x = self.x + dx
        self.y = self.y + dy
    end

    return self
end
