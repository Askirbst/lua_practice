---@diagnostic disable: undefined-global
local love = require("love")


function love.load()
    local seed = os.time()
    math.randomseed(seed)
end

local lines = {} -- Will hold the individual lines to be drawn in love.draw()

local function createLine(x1, y1, x2, y2)
    local line = {
        posStart = {x1, y1}, -- Holds the values (x, y) for the vertices of a given line
        posStop = {x2, y2}
    }
    table.insert(lines, line)
end

function createMaze()

    local mazeSize = 10 -- Represents the size of the maze (What size grid, i.e. 10 x 10, 5 x 5)
    local len = 50 -- Represents the length of the lines used to create the maze
    local offset = 10 -- Position of top left corner of maze to the edge of the screen. Effectively the zero position of the maze

    local x1, y1, x2, y2 = 0, 0, 0, 0

    for i = 0, mazeSize - 1, 1 do
        for j = 0, mazeSize - 1, 1 do

            -- for random number generation 0 is a horizontal line and 1 is a vertical line

            if i == 0 and j <= mazeSize - 1 then -- Represents the top border of maze
                x1, y1 = offset + (j * len), offset
                x2, y2 = offset + len + (j * len), offset   
                createLine(x1, y1, x2, y2)

                if math.random(0, 1) == 1 then -- Adds a random vertical line from the top border
                    x1, y1 = offset + len + (len * j), offset
                    x2, y2 = offset + len + (len * j), offset + len
                    createLine(x1, y1, x2, y2)
                end

            end

            if i <= mazeSize - 1 and j == 0 then -- Represents the left border of the maze
                x1, y1 = offset, offset + (i * len)
                x2, y2 = offset, offset + len + (i * len)
                createLine(x1, y1, x2, y2)

                if math.random(0, 1) == 0 then -- Adds a random horizontal line from the left border
                    x1, y1 = offset, offset + (i * len)
                    x2, y2 = offset + len, offset + (i * len)
                    createLine(x1, y1, x2, y2)
                end
            end

            if i <= mazeSize - 1 and j == mazeSize - 1 then -- Represents the right border of the maze
                x1, y1 = offset + mazeSize * len, offset + (i * len)
                x2, y2 = offset + mazeSize * len, offset + len + (i * len)
                createLine(x1, y1, x2, y2)
            end

            if i == mazeSize - 1 and j <= mazeSize - 1 then -- Represents the bottom border of the maze
                x1, y1 = offset + (j * len), offset + (mazeSize * len)
                x2, y2 = offset + len + (j * len), offset + (mazeSize * len)
                createLine(x1, y1, x2, y2)
            end

            if i + 1 < mazeSize and j + 1 < mazeSize then -- Randomizes lines inside the border to create a maze-like picture

                if math.random(0, 1) == 0 then
                    x1, y1 = offset + (len * j), offset + (i * len)
                    x2, y2 = offset + len + (len * j), offset + (i * len)
                    createLine(x1, y1, x2, y2)
                end

                if math.random(0, 1) == 1 then
                    x1, y1 = offset + len + (len * j), offset + (i * len)
                    x2, y2 = offset + len + (len * j), offset + len + (i * len)
                    createLine(x1, y1, x2, y2)
                end
            end
        end
    end
end

createMaze()

function love.update(dt)

end

function love.draw()
    love.graphics.setLineWidth(5)
    for _, line in ipairs(lines) do
        love.graphics.line(line.posStart[1], line.posStart[2], line.posStop[1], line.posStop[2])
    end
end
