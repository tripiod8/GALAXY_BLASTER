gEnemies = {
    small = {
        width = 16,
        height = 16,
        sprite = 'assets/graphics/spritesheets/enemy-small.png',
        hp = 1,
        score = 30
    },
    medium = {
        width = 32,
        height = 16,
        sprite = 'assets/graphics/spritesheets/enemy-medium.png',
        hp = 2,
        score = 60

    },
    large = {
        width = 32,
        height = 32,
        sprite = 'assets/graphics/spritesheets/enemy-big.png',
        hp = 4,
        score = 120
    }
}

Enemy = {type='enemy'}
Enemy.__index = Enemy

function Enemy:Create(def, x, y)
    local this = {
        x = x or 0,
        y = y or 0,
        w = def.width,
        h = def.height,
        hp = def.hp,
        score = def.score,
        image = love.graphics.newImage(def.sprite),
        animation = nil,
        fireRate = 0.1,
        fireTimer = 0.5
    }

    local grid = anim8.newGrid(def.width, def.height, this.image:getDimensions())
    this.animation = anim8.newAnimation(grid('1-2', 1), 0.15)

    setmetatable(this, self)
    return(this)
end

function Enemy:takeHit()
    self.hp = self.hp - 1
end

function Enemy:update(dt)
    self.fireTimer = self.fireTimer - dt
    if self.fireTimer <= 0 then
        self:fire()
        self.fireTimer = self.fireRate + math.random() * 2
    end

    local targetX = self.x
    local targetY = self.y

    targetY = self.y + 20 * dt
    targetX = self.x + 10 * dt

    local actualX, actualY, cols, len = collisionWorld:move(self, targetX, targetY, shipColFilter)
    self.x = actualX
    self.y = actualY
    if len > 0 then
        for i, c in ipairs(cols) do
            if c.other.type == 'bullet' then
                self:takeHit()
                if self.hp == 0 then
                    gameWorld:removeEnemy(self)
                    local f = Explosion:Create(self.x, self.y)
                    gameWorld:addEffect(f)
                    gameWorld:updateScore(self.score)
                    Sounds.explosion:play()
                end
            end
        end
    end
    self.animation:update(dt)
end

function Enemy:draw()
    self.animation:draw(self.image, self.x, self.y)
end

function Enemy:fire()
    local bulletX = math.floor((self.x + self.w) / 2 - 8)
    local bulletY = self.y + self.h + 2
    local b = Bullet:Create(self.x + (self.w/4), bulletY, 0, 140)
end