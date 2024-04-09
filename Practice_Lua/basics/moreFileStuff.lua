local file = io.open("myFile.txt", "w")

if file ~= nil then
    file:write("Hello there!")
    file:close()
else
    print("Could not open the file")
end

local file = io.open("myFile.txt", "a")

if file ~= nil then
    file:write("\nHow are you?")
    file:write("\nI am well.")
    file:write("\nAnd you?")
    file:close()
else
    print("Could not open the file")
end

local file = io.open("myFile.txt", "r")

if file ~= nil then
    for line in file:lines() do
        print(line) 
    end
    file:close()
else
    print("Could not open the file")
end
