-- this is a comment
-- this is also a comment
-- these are single line comments

--[[this is a multiline comment
it can continue to the next line
I can go to a new line without add more dashes]]

print("Hello World") -- will print Hello World
print("Hello Jeff") -- will print Hello Jeff
print("Hello World", "I am cool") -- will print hello world "tab" I am cool
print("Hello World, " .. "I am cool") --[[will print hello world I am cool without a tab
                      .. is used to concatenate]]

--[[ Data Types
nil
number 1 2 -99 9.87
string "asdas" 'sadsad'
boolean true false
table like lists in python
]]

-- Variables
local x = 8 -- local variables can't be used outside of this file or functions depending on it's scope
--print(x + 8)
_G.GlobalVar = 10 -- global variables can be used outside of file
local f = 3.14159 -- floats don't need to be specified
local str = "string"
local longstr = [[asasd
asdfe
adsfe
adfeg
adfge]]

local one, two, three = "one", 2, false -- assign multiple variables of different types on the same line
print(one,"\n",two,"\n",three)

local name = "Steve"

print("Hello my name is " .. name)
print("I have a cool name, " .. name)

local x = #"Hello World"
print(x)
local y = "hello world"
print(#y)
-- # in lua gives the length of the string