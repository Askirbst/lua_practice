local function sayHello(name)
    print("Hello " .. name .. "!")
end

print("What is your name?")
local input = io.read()

sayHello(input)

local function sum(num1, num2)
    local result = num1 + num2
    return result
end

local x = 20

local ans = sum(10, x)

print("The answer is: " .. ans)