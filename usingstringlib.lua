text=[[
    my name is kahgeh
    blah blah blah

    <div>inside a div</div>
]]

b,e =text:find("blah")
print(b,e)
print(string.sub(text,b,e))
print(text:match("<.->"))
for m in string.gmatch(text,"<.->") do
  print(m)
end