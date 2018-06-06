function Test(params)
    params = params or {}
    options = {
      param1 = false
    }
    
    for k,v in pairs(params) do options[k] = v end
    param1 = options.param1
    print(param1)
end

Test()
Test{param1=true}