local tbl ={"This", 2, 9.9, true, {"ok", "cool"}}

for i = 1, #tbl do
    print(tbl[i])
end

local alphaNums = {1, 2, 3, 4, 5}

table.insert(alphaNums, 2, 19)

table.remove(alphaNums, 4)

for i = 1, #alphaNums do
    print(alphaNums[i])
end 

local obj = {
    name = "Mike",
    age = 12
}

print(obj["name"])
print(obj["age"])
