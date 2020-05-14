Shield = {}
Shield.__index = Shield

function Shield:Create(ship)
  local this = {
    ship = ship,
    duration = 5,
    radius = 14,
    colors = {
      {1,0,0,1}, -- red
      {0,1,0,1}, -- blue
      {0,0,1,1}  -- green
    },
    colorIndex = 1
  }
  setmetatable(this, self)
  return(this)
end

function Shield:update(dt)
  self.colorIndex = self.colorIndex + 1
  if self.colorIndex > #self.colors then
    self.colorIndex = 1
  end
end

function Shield:draw()
  love.graphics.push("all")
  love.graphics.setColor(self.colors[self.colorIndex])
  love.graphics.circle("line", self.ship.x + self.ship.w / 2, self.ship.y + self.ship.h / 2, self.radius)
  love.graphics.pop()
end
