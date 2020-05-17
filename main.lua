function love.load() 
    scale = 2
    love.graphics.setDefaultFilter('nearest', 'nearest')
    dwFont = love.graphics.newFont('assets/PrStart.ttf', 8)
    love.graphics.setFont(dwFont)
    require('dependencies')
    bgImage = love.graphics.newImage('assets/graphics/backgrounds/space-background.png')
    bgImageWidth, bgImageHeight = bgImage:getDimensions()
    bgOffset = 0
    scrollSpeed = 40

    collisionWorld = bump.newWorld()

    ship = Ship:Create()
    collisionWorld:add(ship, ship.x, ship.y, ship.w, ship.h)
    c = Collectible:Create(collectibleDefs.fireBlaster, 0, 0)
    c2 = Collectible:Create(collectibleDefs.extraLife, 30, -40)
    gameWorld = GameWorld:Create(collisionWorld)
    gameWorld:addCollectible(c)
    gameWorld:addCollectible(c2)

    e = Enemy:Create(gEnemies.small, 94, 0)
    gameWorld:addEnemy(e)

    hud = HUD:Create(gameWorld, ship)

end

function love.update(dt)
    bgOffset = bgOffset + (scrollSpeed * dt)
    if (bgOffset >= bgImageHeight) then
        bgOffset = 0
    end
    ship:update(dt)
    gameWorld:update(dt)
    
    -- web based debugging system
    require('libs/lovebird').update()
end

function love.draw()
    love.graphics.scale(scale, scale)
    love.graphics.draw(bgImage, 0, bgOffset - bgImageHeight)
    love.graphics.draw(bgImage, 0, bgOffset)
    ship:draw()
    gameWorld:draw()
    hud:draw()
end