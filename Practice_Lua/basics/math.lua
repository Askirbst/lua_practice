print(5 + 5)
print(5 - 15)
print(5 * 5)
print(17 / 5)
print(5 ^ 2)

print(17 % 5)

--17 / 5
--5 10 15
--2

print(5 + 2 * 10) --order of operations matter in lua
print((5 + 2) * 10)
print(5 + (2 * 10))

print(math.pi)

print(math.min(10, 5, -5, 100, -99))
print(math.max(10, 5, -5, 100, -99))

print(math.ceil(20.9))
print(math.ceil(20.1))

print(math.floor(20.9))
print(math.floor(20.1))

math.randomseed(os.time())

print(math.random(10, 50))

