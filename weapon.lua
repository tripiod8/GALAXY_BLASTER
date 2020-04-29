BasicBlaster = {}
BasicBlaster.__index = BasicBlaster

function BasicBlaster:Create(ship) 
local this = {
    ship = ship
}

setmetatable(this, self)
return(this)
end

function BasicBlaster:fire()
    local b = Bullet:Create(self.ship.x, self.ship.y)
    table.insert(gBullets, b)

end

function BasicBlaster:update(dt)
end

function BasicBlaster:handleInput(dt)
    if input:pressed('fire') then
        self:fire()
    end
end