function love.load() 
    scale = 2
    require('dependencies')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    bgImage = love.graphics.newImage('assets/graphics/backgrounds/space-background.png')
    bgImageWidth, bgImageHeight = bgImage:getDimensions()
    bgOffset = 0
    scrollSpeed = 40

    ship = Ship:Create()

    gBullets = {}

end

function love.update(dt)
    bgOffset = bgOffset + (scrollSpeed * dt)
    if (bgOffset >= bgImageHeight) then
        bgOffset = 0
    end
    ship:update(dt)
    for i, b in ipairs(gBullets) do 
        b:update(dt)
    end
    -- web based debugging system
    require('libs/lovebird').update()
end

function love.draw()
    love.graphics.scale(scale, scale)
    love.graphics.draw(bgImage, 0, bgOffset - bgImageHeight)
    love.graphics.draw(bgImage, 0, bgOffset)
    for i, b in ipairs(gBullets) do 
        b:draw()
    end
    ship:draw()
end