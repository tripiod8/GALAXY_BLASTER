Explosion = {}
Explosion.__index = Explosion

function Explosion:Create(x, y)
    local this = {
        x = x,
    y = y,
    image = love.graphics.newImage('assets/graphics/spritesheets/explosion.png'),
    animation = nil
    }

    local grid = anim8.newGrid(16, 16, this.image:getDimensions())
    this.animation = anim8.newAnimation(grid('1-5', 1), 0.1, 'pauseAtEnd')

    setmetatable(this, self)
    return(this)
end

function Explosion:update(dt)
    self.animation:update(dt)
end

function Explosion:draw()
    self.animation:draw(self.image, self.x, self.y)
end

function Explosion:isDead()
    return(self.animation.status == 'paused')
end