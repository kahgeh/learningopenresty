local mocks = require 'mocks'
local prettyprinter=require 'pl.pretty'
local dns=mocks.Dns:new()
dns:retrieve()
prettyprinter.dump(dns.names)
print(dns:lookup("echo-fiji"))