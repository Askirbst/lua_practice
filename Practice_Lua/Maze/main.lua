---@diagnostic disable: undefined-global
local love = require("love")

function love.load()
    local seed = os.time()
    math.randomseed(seed)

end
local size = 10

local boxes = {}

local box = {
    x = 0,
    y = 0,

    pos0 = {x, y},
    pos1 = {x, y}

}

function makeBox()

    boxType = math.random(0, 2) -- determines how many lines are drawn for a given box
    startPos = math.random(0, 3) -- determines at what corner do the lines begin

    for i = 0, 9, 1 do
        for j = 0, 9, 1 do
            box.x, box.y = 0, 0

            if i == 0 then
                box.pos0 = {box.x + (j * size), box.y}
                box.pos1 = {box.x + size + (j * size), box.y}
                table.insert(boxes, box)
            elseif j == 0 then
                box.pos0 = {box.x + (i * size), box.y}
                box.pos1 = {box.x, box.y}
                table.insert(boxes, box)
            end
        end
    end
end

makeBox()

function love.update(dt)

end

function love.draw()
    for _, box in ipairs(boxes) do
        love.graphics.line(box.pos0[1], box.pos0[2] + size, box.pos1[1], box.pos1[2] + size)
    end
end
