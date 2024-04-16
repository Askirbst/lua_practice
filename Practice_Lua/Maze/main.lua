---@diagnostic disable: undefined-global
local love = require("love")

function love.load()
    local seed = os.time()
    math.randomseed(seed)

end
local size = 10

local boxes = {}

local function makeBox(pos_A0, pos_A1, pos_B0, pos_B1, pos_C0, pos_C1, type) 
    return {

    type = type,

    pos_A0 = pos_A0,
    pos_A1 = pos_A1,

    pos_B0 = pos_B0,
    pos_B1 = pos_B1,

    pos_C0 = pos_C0,
    pos_C1 = pos_C1
    }
end


function makeGrid()

    boxType = math.random(0, 2) -- determines how many lines are drawn for a given box
    startPos = math.random(0, 3) -- determines at what corner do the lines begin
    
    local x, y = 0, 0

    local pos_A0 = {x, y}
    local pos_A1 = {x, y}
    local pos_B0 = {x, y}
    local pos_B1 = {x, y}
    local pos_C0 = {x, y}
    local pos_C1 = {x, y}

    local type = 0

    for i = 0, 9, 1 do
        for j = 0, 9, 1 do

            if i == 0 and j == 0 then
                local pos_A0 = {x + (i * size), y + size + (j * size)}
                local pos_A1 = {x, y}

                local pos_B0 = {x, y}
                local pos_B1 = {x + size + (j * size), y}

                type = 2
            end
            if i ~= 0 and j == 0 then
                pos_A0 = {x, y + (i * size)}
                pos_A1 = {x, y + size + (i * size)}

                type = 1
            end

            local newBox = makeBox(pos_A0, pos_A1, pos_B0, pos_B1, pos_C0, pos_C1, type)
            table.insert(boxes, newBox)

        end
    end
end

makeGrid()

function love.update(dt)

end

function love.draw()
    for _, box in ipairs(boxes) do
        if box.type == 1 then
            love.graphics.line(box.pos_A0[1], box.pos_A0[2], box.pos_A1[1], box.pos_A1[2])

        elseif box.type == 2 then
            love.graphics.line(box.pos_A0[1], box.pos_A0[2], box.pos_A1[1], box.pos_A1[2], box.pos_B0[1], box.pos_B0[2], box.pos_B1[1], box.pos_B1[2])

        elseif box.type == 3 then
            love.graphics.line(box.pos_A0[1], box.pos_A0[2], box.pos_A1[1], box.pos_A1[2], box.pos_B0[1], box.pos_B0[2], box.pos_B1[1], box.pos_B1[2], box.pos_C0[1], box.pos_C0[2], box.pos_C1[1], box.pos_C1[2])

        end
    end
end
