-- learn how to manipulate object, filter
local cjson = require "./lualib/cjson/util"

local my_json = [[{"my_array":[]}]]
local t = cjson.decode(my_json)