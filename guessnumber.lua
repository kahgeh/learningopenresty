print "Guess a number"
math.randomseed(os.time())
math.random()
number = math.random(100)
answer= io.read("*n")
print(number)
print(answer)