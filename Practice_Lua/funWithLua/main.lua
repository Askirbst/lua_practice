function love.load()
    local seed = os.time()
    math.randomseed(seed)
end 

local rain = love.audio.newSource("audio/rain.mp3", "stream")
love.audio.play(rain)

local width = 800
local height = 800
local scaleFactor = 800 / 1024

local raindrops = {}
local drops = 1


function loadImage(path)
    local info = love.filesystem.getInfo(path)
    if info then
        return love.graphics.newImage(path)
    end
end

image = loadImage("images/bgImage.jpeg")

function makeRain(drops)

    local raindrop = {
        x = math.random(0, width),
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

    local stopped = rain:isStopped()
    if stopped then
        love.audio.play(rain)
    end

    for i, raindrop in ipairs(raindrops) do
        raindrop.y1 = raindrop.y1 + raindrop.speed
        raindrop.y2 = raindrop.y2 + raindrop.speed
        raindrop.y3 = raindrop.y3 + raindrop.speed

        raindrop.vertices = {raindrop.x1,raindrop.y1 , raindrop.x2,raindrop.y2 , raindrop.x3,raindrop.y3}

        if raindrop.y1 >= height + 50 then
            raindrop.y1 = raindrop.y
            raindrop.y2 = raindrop.y
            raindrop.y3 = raindrop.y - raindrop.size * 2 

            raindrop.x = math.random(0, width)
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
    love.graphics.draw(image, 0, 0, 0, scaleFactor, scaleFactor)
    for _, raindrop in ipairs(raindrops) do
        love.graphics.setColor(0, raindrop.shade, 1)
        love.graphics.arc("fill", raindrop.x3, raindrop.y1, raindrop.size, 0, math.pi)
        love.graphics.polygon("fill", raindrop.vertices)
        love.graphics.setColor(1, 1, 1)
    end

end
