---@diagnostic disable: lowercase-global
function love.load()
    love.window.setFullscreen(true, "desktop")

    local seed = os.time()
    math.randomseed(seed)

    local rain = love.audio.newSource("audio/rain.mp3", "stream")
    rain:setLooping(true)
    rain:play()

end 

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local raindrops = {}
local drops = 1
local isfullscreen = true

function loadImage(path)
    local info = love.filesystem.getInfo(path)
    if info then
        return love.graphics.newImage(path)
    end
end

local image = loadImage("images/bgImage.jpeg")

local image_width = image:getWidth()
local image_height = image:getHeight()

function getScaleFactorX(wd)
    if isfullscreen then
        return width / image_width
    else
        return 800 / image_width
    end
end

function getScaleFactorY(ht)
    if isfullscreen then
        return height / image_height    
    else
        return 800 / image_height
    end
end

local scaleFactor_x = getScaleFactorX()
local scaleFactor_y = getScaleFactorY()


function love.keypressed(key, scancode, isrepeat)
    if key == "escape" and isfullscreen == false then -- Enter fullscreen
        isfullscreen = true
        love.window.setMode(0, 0, {fullscreen=true, fullscreentype="desktop"})
        
        scaleFactor_x = getScaleFactorX()
        scaleFactor_y = getScaleFactorY()

    elseif key == "escape" and isfullscreen == true then -- Exit fullscreen
        isfullscreen = false
        love.window.setMode(800, 800, {fullscreen=false, fullscreentype="desktop"})

        scaleFactor_x = getScaleFactorX()
        scaleFactor_y = getScaleFactorY()
    end
end


function makeRain(drops)
    
    if isfullscreen then
        newWidth = width
    else
        newWidth = 800
    end
    
    local raindrop = {
        x = math.random(0, newWidth),
        y = 0,
        size = 6,
        speed = math.random(4, 15),
        shade = 1.0000 --changes the shade of blue based on "distance" from viewer
    }
    -- changes size of rain drop depending on speed: faster drops are larger "closer" to viewer.
    raindrop.size = raindrop.speed - 3

    raindrop.x1 = raindrop.x - raindrop.size
    raindrop.y1 = raindrop.y
    raindrop.x2 = raindrop.x + raindrop.size 
    raindrop.y2 = raindrop.y
    raindrop.x3 = raindrop.x 
    raindrop.y3 = raindrop.y - raindrop.size * 2
    raindrop.vertices = {raindrop.x1,raindrop.y1 , raindrop.x2,raindrop.y2 , raindrop.x3,raindrop.y3}
    raindrop.shade = (raindrop.speed / 15)
    table.insert(raindrops, raindrop)

    return drops + 1

end

drops = makeRain(drops)

function love.update(dt)

    if isfullscreen then
        newWidth, newHeight = width, height
    else
        newWidth, newHeight = 800, 800
    end

    for i, raindrop in ipairs(raindrops) do
        raindrop.y1 = raindrop.y1 + raindrop.speed
        raindrop.y2 = raindrop.y2 + raindrop.speed
        raindrop.y3 = raindrop.y3 + raindrop.speed

        raindrop.vertices = {raindrop.x1,raindrop.y1 , raindrop.x2,raindrop.y2 , raindrop.x3,raindrop.y3}

        if raindrop.y1 >= newHeight + 50 then
            raindrop.y1 = raindrop.y
            raindrop.y2 = raindrop.y
            raindrop.y3 = raindrop.y - raindrop.size * 2 

            raindrop.x = math.random(0, newWidth)
            raindrop.x1 = raindrop.x - raindrop.size
            raindrop.x2 = raindrop.x + raindrop.size
            raindrop.x3 = raindrop.x
            
            if drops <= 300 then
                drops = makeRain(drops)
            end
        end
    end
end

function love.draw()
    love.graphics.draw(image, 0, 0, 0, scaleFactor_x, scaleFactor_y)
    for _, raindrop in ipairs(raindrops) do
        love.graphics.setColor(0, raindrop.shade, 1)
        love.graphics.arc("fill", raindrop.x3, raindrop.y1, raindrop.size, 0, math.pi)
        love.graphics.polygon("fill", raindrop.vertices)
        love.graphics.setColor(1, 1, 1)
    end

end
