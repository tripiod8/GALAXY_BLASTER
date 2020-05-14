GameWorld = {}
GameWorld.__index = GameWorld

function GameWorld:Create()
    local this = {
        bullets = {},
        collectibles = {},
        obstacles = {},
        enemies = {},
        score = 0,
        lives = 3,
        extraLifeCounter = 0,
        extraLifePoints = 50000
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
end

function GameWorld:addBullet(b)
    table.insert(self.bullets, b)
end

function GameWorld:addCollectible(c)
    table.insert(self.collectibles, c)
end

function GameWorld:addObstacles(o)
    table.insert(self.obstacles, o)
end

function GameWorld:addenemies(e)
    table.insert(self.enemies, e)
end

function GameWorld:updateScore(scoreIncrease)
    self.score = self.score + scoreIncrease
    self.extraLifeCounter = self.extraLifeCounter + scoreIncrease
    if self.extraLifeCounter >= self.extraLifeCounter then
        self.lives = self.lives + 1
        self.extraLifeCounter = self.extraLifeCounter - self.extraLifePoints
    end
end
