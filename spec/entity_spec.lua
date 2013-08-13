require 'entity'

describe("Entity", function()
  describe("#handleCollision", function()
    it("should call collide when colliding with another entity", function()
      entity1 = Entity:new({})
      entity1.x = 10
      entity1.y = 10
      entity1.size = 10

      entity2 = Entity:new({})
      entity2.x = 15
      entity2.y = 15
      entity2.size = 10

      spy.on(entity1, "collide")

      entity1:handleCollision(entity2)

      assert.spy(entity1.collide).was_called()
    end)

    it("should not call collide when not colliding with anything", function()
      entity1 = Entity:new({})
      entity1.x = 10
      entity1.y = 10
      entity1.size = 10

      entity2 = Entity:new({})
      entity2.x = 30
      entity2.y = 30
      entity2.size = 10

      spy.on(entity1, "collide")

      entity1:handleCollision(entity2)

      assert.spy(entity1.collide).was_not_called()
    end)
  end)

  describe("#collidingWith", function()
    it("should collide when two entities bounding boxes are intersecting", function()
        entity1 = Entity:new({})
        entity1.x = 10
        entity1.y = 10
        entity1.size = 10

        entity2 = Entity:new({})
        entity2.x = 15
        entity2.y = 15
        entity2.size = 10

        assert.is.equal(entity1:collidingWith(entity2), true)
    end)

    it("should collide when two entities bounding boxes are touching horizontally", function()
        entity1 = Entity:new({})
        entity1.x = 10
        entity1.y = 10
        entity1.size = 10

        entity2 = Entity:new({})
        entity2.x = 20
        entity2.y = 10
        entity2.size = 10

        assert.is.equal(entity1:collidingWith(entity2), true)
    end)

    it("should collide when two entities bounding boxes are touching vertically", function()
        entity1 = Entity:new({})
        entity1.x = 10
        entity1.y = 10
        entity1.size = 10

        entity2 = Entity:new({})
        entity2.x = 10
        entity2.y = 20
        entity2.size = 10

        assert.is.equal(entity1:collidingWith(entity2), true)
    end)

    it("should not collide when two entities bounding boxes are not intersecting", function()
        entity1 = Entity:new({})
        entity1.x = 10
        entity1.y = 10
        entity1.size = 10

        entity2 = Entity:new({})
        entity2.x = 30
        entity2.y = 30
        entity2.size = 10

        assert.is.equal(entity1:collidingWith(entity2), false)
    end)
  end)
end)