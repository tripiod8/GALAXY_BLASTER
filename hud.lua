HUD = {}
HUD.__index = HUD

function HUD:Create(gameWorld, ship)
    local this = {
        gameWorld = gameWorld,
        ship = ship
    }

    setmetatable(this, self)
    return(this)
end

function HUD:draw()
    love.graphics.print('Lives: ' .. self.gameWorld.lives, 80, 80)
    love . graphics.print('Score: ' .. self.gameWorld.score, 80, 120)
    love.graphics.print('Weapon: ' .. self.ship.currentWeapon.name, 10, 554/2-12)
end