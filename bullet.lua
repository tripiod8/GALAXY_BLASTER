Bullet = {type='bullet', bulletType='normal'}
Bullet.__index = Bullet

function Bullet:Create(x, y, xVelocity, yVelocity) 
    local this = {
        x = x,
        y = y,
        w = 16,
        h = 16,
        image = love.graphics.newImage('assets/graphics/spritesheets/laser-bolts.png'),
        animation = nil,
        xVelocity = xVelocity or 0,
        yVelocity = yVelocity or -200,
        damage = 0
    }

    local grid = anim8.newGrid(16, 16, this.image:getDimensions())
this.animation = anim8.newAnimation(grid('1-2', 2), 0.15)

    setmetatable(this, self)
    return(this)
end

function Bullet:isDead()
    return(self.x<0 or self.x>512 or self.y<0 or self.y>554)
end

function Bullet:update(dt)
    self.animation:update(dt)
    local targetX = self.x
    local targetY = self.y
    targetY = self.y + self.yVelocity * dt
    targetX = self.x + self.xVelocity * dt

    local actualX, actualY, cols, len = collisionWorld:move(self, targetX, targetY, shipColFilter)
    self.x = actualX
    self.y = actualY
end

function Bullet:draw()
self.animation:draw(self.image, self.x, self.y)
end

-----------------------------------------------------------

FireBolt = {type='bullet'}
FireBolt.__index = FireBolt

function FireBolt:Create(x, y, xVelocity, yVelocity) 
    local this = {
        x = x,
        y = y,
        w = 16,
        h = 16,
        image = love.graphics.newImage('assets/graphics/spritesheets/laser-bolts.png'),
        animation = nil,
        xVelocity = xVelocity or 0,
        yVelocity = yVelocity or -200,
        damage = 0
    }

    local grid = anim8.newGrid(16, 16, this.image:getDimensions())
this.animation = anim8.newAnimation(grid('1-2', 1), 0.15)

    setmetatable(this, self)
    return(this)
end

function FireBolt:isDead()
    return(self.x<0 or self.x>512 or self.y<0 or self.y>554)
end

function FireBolt:update(dt)
    self.animation:update(dt)
    local targetX = self.x
    local targetY = self.y
    targetY = self.y + self.yVelocity * dt
    targetX = self.x + self.xVelocity * dt

    local actualX, actualY, cols, len = collisionWorld:move(self, targetX, targetY, shipColFilter)
    self.x = actualX
    self.y = actualY
end

function FireBolt:draw()
self.animation:draw(self.image, self.x, self.y)
end