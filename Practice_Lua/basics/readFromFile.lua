io.input("myFile.txt")

local fileData = io.read("*all")

print(fileData)
io.close()