---@diagnostic disable: undefined-global
local love = require("love")

function love.load()
    local seed = os.time()
    math.randomseed(seed)

end

local lines = {} -- Will hold the individual lines to be drawn in love.draw()
local line = {

    posStart = {}, -- Holds the values (x, y) for the vertices of a given line
    posStop = {}

}

function createMaze()

    local mazeSize = 10 -- Represents the size of the maze (What size grid, i.e. 10 x 10, 5 x 5)
    local len = 10 -- Represents the length of the lines used to create the maze
    local offset = 10 -- Position of top left corner of maze to the edge of the screen. Effectively the zero position of the maze

    for i = 0, mazeSize - 1, 1 do
        for j = 0, mazeSize - 1, 1 do

            if i == 0 then -- Represents the first vertice in the top left corner of maze
                line.posStart = {offset + (i * len), offset}
                line.posStop = {offset + len + (i * len), offset}

            end
            if i == 0 and j == mazeSize - 1 then -- Represents the right side of the maze
                line.posStart = {mazeSize, len}
                line.posStop = {mazeSize, len + (i * len)}
            end
            if i >= 0 and j == 0 then -- Represents the left side of the maze
                line.posStart = {offset, offset + (i * len)}
                line.posStop = {offset, offset + len + (i * len)}
            end

            table.insert(lines, line)

        end
    end
end

createMaze()

function love.update(dt)

end

function love.draw()
    for _, line in ipairs(lines) do
        love.graphics.line(line.posStart[1], line.posStart[2], line.posStop[1], line.posStop[2])
    end
end
