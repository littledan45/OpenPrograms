local component = require("component")
local term = require("term")
local io = require("io")
local serial = require("serialization")
local fs = component.filesystem
local API = require("ocAgriSeedEnhancerAPI")

print(API.checkConfig("analyzerLeft"))
local analyzerLeft = component.proxy(API.checkConfig("analyzerLeft"))
--local analyzerCenter = component.proxy(--TODO)
--local analyzerRight = component.proxy(--TODO)

local res = analyzerLeft.hasPlant("NORTH")

print(res)
