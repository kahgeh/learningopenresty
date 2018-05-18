-- learn how to manipulate object, filter
local cjson = require "cjson"

local my_json = [[{"my_array":[]}]]
require 'pl.pretty'.dump( cjson.decode(my_json) )

