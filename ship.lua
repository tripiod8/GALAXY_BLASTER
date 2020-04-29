Ship = {}

Ship.__index = Ship

function Ship:Create(def)
local this = {
    x = 0,
    y = 0,
    h = 24,
    w = 16,
    image = love.graphics.newImage('assets/graphics/spritesheets/ship.png'),
    animation = nil,
    shield = nil,
    health = 5,
    weapon = nil
}

local grid = anim8.newGrid(16, 24, this.image:getDimensions())
this.animation = anim8.newAnimation(grid(3, '1-2'), 0.15)

this.x = (love.graphics.getWidth() / 2) / scale - (this.w/2)
this.y = (love.graphics.getHeight() - this.h*2) / scale

this.weapon = BasicBlaster:Create(this)

setmetatable(this, self)
return(this)
end

function Ship:update(dt)
    self:handleInput(dt)
    self.animation:update(dt)
    self.weapon:update(dt)
end

function Ship:draw()
    self.animation:draw(self.image, self.x, self.y)
end

function Ship:handleInput()
    if input:down('left') then
        self.x = clamp(self.x, 0, 239) - 2
    elseif input:down('right') then
        self.x = clamp(self.x, 0, 239) + 2
    end

    if input:down('up') then
        self.y = clamp(self.y, 1, 250) - 2
    elseif input:down('down') then
        self.y = clamp(self.y, 1, 250) + 2
    end

    ship.weapon:handleInput(dt)
end