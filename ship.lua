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
    weaponA = nil,
    weaponB = nil,
    currentWeapon = nil
}

local grid = anim8.newGrid(16, 24, this.image:getDimensions())
this.animation = anim8.newAnimation(grid(3, '1-2'), 0.15)

this.x = (love.graphics.getWidth() / 2) / scale - (this.w/2)
this.y = (love.graphics.getHeight() - this.h*2) / scale

this.weaponA = BasicBlaster:Create(this)
this.weaponB = FireBlaster:Create(this)
this.currentWeapon = this.weaponA

setmetatable(this, self)
return(this)
end

function Ship:update(dt)
    self:handleInput(dt)
    self.animation:update(dt)
    self.currentWeapon:update(dt)
end

function Ship:draw()
    self.animation:draw(self.image, self.x, self.y)
end

function Ship:handleInput()
    local targetX = self.x
    local targetY = self.y
    if input:down('left') then
        targetX = clamp(self.x, 0, 239) - 2
    elseif input:down('right') then
        targetX = clamp(self.x, 0, 239) + 2
    end

    if input:down('up') then
        targetY = clamp(self.y, 1, 250) - 2
    elseif input:down('down') then
        targetY = clamp(self.y, 1, 250) + 2
    end

    if input:pressed('c') then
        if self.currentWeapon ~= self.weaponB then
            self.currentWeapon = self.weaponB
        else
            self.currentWeapon = self.weaponA
        end 
    end

    local actualX, actualY, cols, len = collisionWorld:move(self, targetX, targetY, shipColFilter)
    self.x = actualX
    self.y = actualY
    if len > 0 then
        for i, c in ipairs(cols) do
            if c.other.type == "collectible" then
                local newWeaponType = gWeapon[c.other.weapon]
                self.currentWeapon = newWeaponType:Create(self)
                gameWorld:removeCollectible(c.other)
            end
        end
    end

    ship.currentWeapon:handleInput(dt)
end

function shipColFilter(object, other)
    return('cross')
end
