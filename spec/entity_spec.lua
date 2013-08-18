require 'entity'

describe("Entity", function()
    before_each(function()
        baseEntity = Entity:new({})
        baseEntity.x = 10
        baseEntity.y = 10
        baseEntity.size = 10

        collidingEntity = Entity:new({})
        collidingEntity.x = 15
        collidingEntity.y = 15
        collidingEntity.size = 10

        nonCollidingEntity = Entity:new({})
        nonCollidingEntity.x = 30
        nonCollidingEntity.y = 30
        nonCollidingEntity.size = 10

        spy.on(baseEntity, "collide")
    end)

    describe("#handleCollision", function()
        it("should call collide when colliding with another entity", function()
            baseEntity:handleCollision(collidingEntity)

            assert.spy(baseEntity.collide).was_called()
        end)

        it("should not call collide when not colliding with anything", function()
            baseEntity:handleCollision(nonCollidingEntity)

            assert.spy(baseEntity.collide).was_not_called()
        end)
    end)

    describe("#collidingWith", function()
        it("should collide when two entities bounding boxes are intersecting", function()
            assert.is.equal(baseEntity:collidingWith(collidingEntity), true)
        end)

        it("should collide when two entities bounding boxes are touching horizontally", function()
            collidingEntity.x = 20
            collidingEntity.y = 10

            assert.is.equal(baseEntity:collidingWith(collidingEntity), true)
        end)

        it("should collide when two entities bounding boxes are touching vertically", function()
            collidingEntity.x = 10
            collidingEntity.y = 20

            assert.is.equal(baseEntity:collidingWith(collidingEntity), true)
        end)

        it("should not collide when two entities bounding boxes are not intersecting", function()
            assert.is.equal(baseEntity:collidingWith(nonCollidingEntity), false)
        end)
    end)
end)
