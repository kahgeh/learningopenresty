caloriecounter = {count=0, goal=2000}

function caloriecounter:add(amount)
    self.count=self.count + amount;
end

function caloriecounter:reachedGoal()
    return self.count >= self.goal
end

function caloriecounter:new(t)
    t=t or {}
    setmetatable(t,self)
    self.__index = self
    return t
end

c = caloriecounter:new{goal=1500}

c:add(500)

print(c.count)

print(c:reachedGoal())

c:add(1000)

print(c:reachedGoal())