_G.love = require("love")

function love.load()
    math.randomseed(os.time())
    _G.pacman = {}
    pacman.x = 200
    pacman.y = 250
    pacman.eat = false

    pacman.angle1Start = (math.pi) / 4
    pacman.angle2Start = (math.pi * 7) / 4

    pacman.angle1W = -((math.pi * 3) / 4)
    pacman.angle2W = -((math.pi * 9) / 4)

    pacman.angle1A = (math.pi * 3) / 4
    pacman.angle2A = -((math.pi * 3) / 4)

    pacman.angle1S = (math.pi * 3) / 4
    pacman.angle2S = (math.pi * 9) / 4

    pacman.angle1D = pacman.angle1Start
    pacman.angle2D = pacman.angle2Start

    _G.angle1, _G.angle2 = pacman.angle1Start, pacman.angle2Start

    _G.food = {}
    food.x = math.random(0, 730)
    food.y = math.random(0, 530)
    food.eaten = false

end

function love.update(dt)
    math.randomseed(os.time())
    --Move Pacman around screen while changing which direction he faces
    if love.keyboard.isDown("w") then
        pacman.y = pacman.y - 2
        angle1, angle2 = pacman.angle1W, pacman.angle2W
    end
    if love.keyboard.isDown("a") then
        pacman.x = pacman.x - 2
        angle1, angle2 = pacman.angle1A, pacman.angle2A
    end
    if love.keyboard.isDown("s") then
        pacman.y = pacman.y + 2
        angle1, angle2 = pacman.angle1S, pacman.angle2S
    end
    if love.keyboard.isDown("d") then
        pacman.x = pacman.x + 2
        angle1, angle2 = pacman.angle1D, pacman.angle2D
    end
    -- Check whether Pacman has hit the food
    function isCollision(obj1, obj2, margin)
        return obj1.x >= obj2.x and obj1.x <= obj2.x + margin and
               obj1.y >= obj2.y and obj1.y <= obj2.y + margin
    end
    
    if isCollision(pacman, food, 60) then
        pacman.eat, food.eaten = true, true
        food.x, food.y = math.random(0, 730), math.random(0, 530)
        food.eaten = false
    end
    
end

function love.draw()
    
    if not food.eaten then
        love.graphics.setColor(125 / 255, 75 / 255, 230 / 255)
        love.graphics.rectangle("fill", food.x, food.y, 70, 70)
    end

    love.graphics.setColor(1, 0.7, 0.1)

    love.graphics.arc("fill", pacman.x, pacman.y, 60, angle1, angle2)

end