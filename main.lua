function love.load() 
    scale = 2
    require('dependencies')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    bgImage = love.graphics.newImage('assets/graphics/backgrounds/space-background.png')
    bgImageWidth, bgImageHeight = bgImage:getDimensions()
    bgOffset = 0
    scrollSpeed = 40

    collisionWorld = bump.newWorld()

    ship = Ship:Create()
    collisionWorld:add(ship, ship.x, ship.y, ship.w, ship.h)
    c = Collectible:Create(collectibleDefs.spreadBlaster)
    gameWorld = GameWorld:Create(collisionWorld)
    gameWorld:addCollectible(c)

    
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
end