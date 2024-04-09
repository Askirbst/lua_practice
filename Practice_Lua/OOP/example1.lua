local function Pet(name)
    local age = 10 --private property
    return {
        name = name or "Charlie",
        status = "hungry",
        daysAlive = age * 365, -- public property
        
        speak = function(self)
            print("Meow")
        end,
        
        feed = function(self)
            print(self.name .. " is " .. "eating")
        end
    }
end

local cat = Pet()
local dog = Pet("Jack")

print(cat.name)
print(dog.name)
print(dog.daysAlive)

cat:speak()
dog:feed()

local function Dog(name, breed)
    local dog = Pet(name)
    
    dog.breed = breed or "doberman"
    dog.loyal = true

    dog.speak = function(self)
        print("woof")
    end

    return dog
end

local doberman = Dog("Jessie")
print(doberman.name .. " is a " .. doberman.breed)

local poodle = Dog("Becky", "poodle")
print(poodle.name, poodle.breed)
poodle:speak()