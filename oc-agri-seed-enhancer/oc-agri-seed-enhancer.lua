local component = require("component")
local term = require("term")
local io = require("io")
local serial = require("serialization")
local fs = component.filesystem
local API = require("ocAgriSeedEnhancerAPI")

print(API.checkConfig("analyzerLeft"))
--local analyzerLeft component.proxy(--TODO)
--local analyzerCenter component.proxy(--TODO)
--local analyzerRight component.proxy(--TODO)
