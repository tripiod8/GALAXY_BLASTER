

function love.load() 
    require('dependencies')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    bgImage = love.graphics.newImage('assets/graphics/backgrounds/space-background.png')
    bgImageWidth, bgImageHeight = bgImage:getDimensions()
    bgOffset = 0
    scrollSpeed = 40
end

function love.update(dt)
    bgOffset = bgOffset + (scrollSpeed * dt)
    if (bgOffset >= bgImageHeight) then
        bgOffset = 0
    end
    require('libs/lovebird').update()
end

function love.draw()
    love.graphics.scale(2, 2)
    love.graphics.draw(bgImage, 0, bgOffset - bgImageHeight)
    love.graphics.draw(bgImage, 0, bgOffset)
end