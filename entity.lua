Entity = {}
Entity.__index = Entity

function Entity:new(game)
  newObj = {
    game = game,
    x = 0,
    y = 0
  }
  return setmetatable(newObj, self)
end

function Entity:draw()
    self.graphics.animation:draw(self.graphics.sprites, self.x, self.y)
end