--[[Mod = {}

function Mod.sum(x, y)
    return x + y
end
]]

--Same as above
Mod = {
    sum = function(x, y)
        return x + y
    end
}

function Mod.sayHello(name)
    print("Hello, " .. name)
end

return Mod