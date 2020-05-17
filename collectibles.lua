collectibleDefs = {
    spreadBlaster = {
        frames = {'3-4', 1},
        action = function(gameWorld, ship)
            ship.currentWeapon = BasicBlaster:Create(ship)
        end
    },
    fireBlaster = {
        frames = {'3-4', 2},
        action = function(gameWorld, ship)
            ship.currentWeapon = FireBlaster:Create(ship)
        end
    },
    extraLife = {
        frames = {'1-2', 1},
        action = function(gameWorld, ship)
            gameWorld:addLife()
        end
    }
}

Collectible = {type="collectible"}
Collectible.__index = Collectible

function Collectible:Create(def)
    local this = {
        x = 0,
        y = 0,
        w = 16,
        h = 16,
        image = love.graphics.newImage('assets/graphics/spritesheets/power-up.png'),
        animation = nil,
        yVelocity = 15,
        action = def.action
    }

    local grid = anim8.newGrid(16, 16, this.image:getDimensions())
    this.animation = anim8.newAnimation(grid(unpack(def.frames)), 0.4)

    setmetatable(this, self)
    return(this)
end

function Collectible:update(dt)
    self.animation:update(dt)
    local targetX = self.x
    local targetY = self.y
    targetY = self.y + self.yVelocity * dt
    local actualX, actualY, cols, len = collisionWorld:move(self, targetX, targetY, shipColFilter)
    self.x = actualX
    self.y = actualY
end

function Collectible:draw()
    self.animation:draw(self.image, self.x, self.y)
end

