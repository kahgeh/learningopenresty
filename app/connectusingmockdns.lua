local mocks = require 'mocks'
local dns=mocks.Dns:new()
dns:retrieve()
ngx.say(dns:lookup('echo-fiji'))
