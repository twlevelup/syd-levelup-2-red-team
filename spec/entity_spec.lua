require 'entity'

describe("Entity", function()
    local baseEntity, collidingEntity, nonCollidingEntity

    before_each(function()
        baseEntity = Entity:new({})
        baseEntity.x = 10
        baseEntity.y = 10
        baseEntity.size = {
            x = 10,
            y = 10
        }

        collidingEntity = Entity:new({})
        collidingEntity.x = 15
        collidingEntity.y = 15
        collidingEntity.size = {
            x = 10,
            y = 10
        }

        nonCollidingEntity = Entity:new({})
        nonCollidingEntity.x = 30
        nonCollidingEntity.y = 30
        nonCollidingEntity.size = {
            x = 10,
            y = 10
        }

        spy.on(baseEntity, "collide")
    end)

    describe ("bounds", function()
        local entity

        before_each(function()
            entity= Entity:new({})
            entity.x = 10
            entity.y = 10
            entity.size = {
                x = 10,
                y = 15
            }
        end)

        it("should set the top at its vertical position", function()
            assert.is.equal(entity:bounds().top, 10)
        end)

        it("should set the left at its horizontal position", function()
            assert.is.equal(entity:bounds().left, 10)
        end)

        it("should set the right at its horizontal position plus size", function()
            assert.is.equal(entity:bounds().right, 20)
        end)

        it("should set the bottom at its vertical position plus size", function()
            assert.is.equal(entity:bounds().bottom, 25)
        end)
    end)

    describe("collidingWith", function()
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
