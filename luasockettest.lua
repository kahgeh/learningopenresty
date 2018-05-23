local socket = require("socket")
local http = require("socket.http")
local url = require("socket.url")
local pl = require 'pl.pretty'
local ltn12 = require("ltn12")

http.TIMEOUT = 10
local t = socket.gettime()
local request={
    url="http://localhost:3010/names.json"
}
if not request.sink then request.sink, t = ltn12.sink.table() end
request.source = request.source or
    (request.body and ltn12.source.string(request.body))
local response = {}

local code,status,headers,message =http.request(request)
if t and #t > 0 then body = table.concat(t) end

pl.dump(request)
print(code)
print(status)
pl.dump(headers)
pl.dump(message)
print(body)

