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

---------------------------------------------------------------------

FireBlaster = {}
FireBlaster.__index = FireBlaster

function FireBlaster:Create(ship) 
local this = {
    ship = ship
}

setmetatable(this, self)
return(this)
end

function FireBlaster:fire()
    local f = FireBolt:Create(self.ship.x, self.ship.y)
    table.insert(gBullets, f)

end

function FireBlaster:update(dt)
end

function FireBlaster:handleInput(dt)
    if input:pressed('fire') then
        self:fire()
    end
end