GameWorld = {}
GameWorld.__index = GameWorld

function GameWorld:Create(colWorld)
    local this = {
        bullets = {},
        collectibles = {},
        obstacles = {},
        enemies = {},
        effects = {},
        score = 0,
        lives = 3,
        extraLifeCounter = 0,
        extraLifePoints = 50000,
        collisionWorld = colWorld
    }

    setmetatable(this, self)
    return(this)
end

function GameWorld:update(dt)
    for i, b in ipairs(self.bullets) do 
        b:update(dt)
    end
    for i, c in ipairs(self.collectibles) do 
        c:update(dt)
    end
    for i, o in ipairs(self.obstacles) do 
        o:update(dt)
    end
    for i, e in ipairs(self.enemies) do 
        e:update(dt)
    end
    for i, f in ipairs(self.effects) do 
        f:update(dt)
        if f:isDead() then
            self:removeEffect(f)
        end
    end
end

function GameWorld:draw()
    for i, b in ipairs(self.bullets) do 
        b:draw()
    end
    for i, c in ipairs(self.collectibles) do 
        c:draw()
    end
    for i, o in ipairs(self.obstacles) do 
        o:draw()
    end
    for i, e in ipairs(self.enemies) do 
        e:draw()
    end
    for i, f in ipairs(self.effects) do 
        f:draw()
    end
end
-- API Calls

function GameWorld:addEffect(f)
    table.insert(self.effects, f)
end

function GameWorld:removeEffect(f)
    self.collisionWorld:remove(f)
    for i, effect in ipairs(self.effects) do
        if f == effect then
            table.remove(self.effects, i)
            return
        end
    end
end

function GameWorld:addBullet(b)
    self.collisionWorld:add(b, b.x, b.y, b.w, b.h)
    table.insert(self.bullets, b)
end

function GameWorld:addCollectible(c)
    self.collisionWorld:add(c, c.x, c.y, c.w, c.h)
    table.insert(self.collectibles, c)
end

function GameWorld:removeCollectible(c)
    self.collisionWorld:remove(c)
    for i, collectible in ipairs(self.collectibles) do
        if c == collectible then
            table.remove(self.collectibles, i)
            return
        end
    end
end

function GameWorld:addObstacles(o)
    self.collisionWorld:add(o, o.x, o.y, o.w, o.h)
    table.insert(self.obstacles, o)
end

function GameWorld:addEnemy(e)
    self.collisionWorld:add(e, e.x, e.y, e.w, e.h)
    table.insert(self.enemies, e)
end

function GameWorld:removeEnemy(e)
    self.collisionWorld:remove(e)
    for i, enemy in ipairs(self.enemies) do
        if e == enemy then
            table.remove(self.enemies, i)
            return
        end
    end
end

function GameWorld:updateScore(scoreIncrease)
    self.score = self.score + scoreIncrease
    self.extraLifeCounter = self.extraLifeCounter + scoreIncrease
    if self.extraLifeCounter >= self.extraLifeCounter then
        self.lives = self.lives + 1
        self.extraLifeCounter = self.extraLifeCounter - self.extraLifePoints
    end
end

function GameWorld:addLife()
    self.lives = self.lives + 1
end



