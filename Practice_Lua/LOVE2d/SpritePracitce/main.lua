_G.love = require("love")
---@diagnostic disable: lowercase-global
function love.load()
    yoshi = {
        x = 0,
        y = 0,
        sprite = love.graphics.newImage("sprites/spritesheet.png"),
        SPRITE_WIDTH = 4376,
        SPRITE_HEIGHT = 481,
        QUAD_WIDTH = 547, 
        QUAD_HEIGHT = 481,
        animation = {
            direction = "right",
            idle = true,
            frame = 1,
            max_frames = 8,
            speed = 20,
            timer = 0.1
        }
    }

   

    quad = {}
    
    for i = 1, yoshi.animation.max_frames do
        quad[i] = love.graphics.newQuad(yoshi.QUAD_WIDTH * (i - 1), 0, yoshi.QUAD_WIDTH, yoshi.QUAD_HEIGHT, yoshi.SPRITE_WIDTH, yoshi.SPRITE_HEIGHT)
    end
end 

function love.update(dt)

    if love.keyboard.isDown("d") then
        yoshi.animation.idle = false
        yoshi.animation.direction = "right"
    
    elseif love.keyboard.isDown("a") then
        yoshi.animation.idle = false
        yoshi.animation.direction = "left"
    
    else
        yoshi.animation.idle = true
        yoshi.animation.frame = 1
    end
    
    if not yoshi.animation.idle then
        yoshi.animation.timer = yoshi.animation.timer + dt

        if yoshi.animation.timer > 0.2 then
            yoshi.animation.timer = 0.1

            yoshi.animation.frame = yoshi.animation.frame + 1
        
        if yoshi.animation.direction == "right" then
            yoshi.x = yoshi.x + yoshi.animation.speed
        elseif yoshi.animation.direction == "left" then
            yoshi.x = yoshi.x - yoshi.animation.speed
        end
            if yoshi.animation.frame > yoshi.animation.max_frames then
                yoshi.animation.frame = 1
            end
        end
   end
end

function love.draw()
    love.graphics.scale(0.3)

    if yoshi.animation.direction == "right" then
        love.graphics.draw(yoshi.sprite, quad[yoshi.animation.frame], yoshi.x, yoshi.y)
    elseif yoshi.animation.direction == "left" then
        love.graphics.draw(yoshi.sprite, quad[yoshi.animation.frame], 
        yoshi.x, yoshi.y, 0, -1, 1, yoshi.QUAD_WIDTH, 0)
    end

    
end