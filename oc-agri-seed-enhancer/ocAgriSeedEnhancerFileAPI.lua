local component = require("component")
local io = require("io")
local fs = require("filesystem")
local serial = require("serialization")
local term = require("term")
local colors = require("colors")

local API = {}

function getAnalyzerAddress(configFileName)
  print("Starting getAnalyzerAddress with Filename", configFileName)
  local _analyzers = {}
  local _repeater = 1
  for add,_ in pairs(component.list("agricraft_peripheral")) do
    _analyzers[_repeater] = add
    _repeater = _repeater + 1
  end

  for k,d in pairs(_analyzers) do
    print(k, d)
  end

  print("Please select", configFileName)
  local _id = tonumber(term.read())
  return _analyzers[_id]
end

function getAnalyzerFace()
  local directions = {"NORTH", "SOUTH", "EAST", "WEST"}
  for k,d in pairs(directions) do
    print(k, d)
  end
  print("Select the correct dirrection")
  return directions[tonumber(term.read())]
end

function writeAnalyzerConfig(fileName)
  local configName = fileName..".cfg"
  local temp = {}
  temp.address = getAnalyzerAddress(fileName)
  if fileName == "analyzerLeft" then
    temp.rsStickColor = colors.orange
    temp.rsBreakerColor = colors.grey
    temp.rsSeedColor = colors.yellow
  elseif fileName == "analyzerCenter" then
    temp.rsStickColor = colors.magenta
    temp.rsBreakerColor = colors.silver
    temp.rsCrossColor = colors.pink
  elseif fileName == "analyzerRight" then
    temp.rsStickColor = colors.lightblue
    temp.rsBreakerColor = colors.cyan
    temp.rsSeedColor = colors.lime
  else
    print("cannot find Analyzer Name in writeAnalyzerConfig")
  end

  local sTemp = serial.serialize(temp)

  local file = io.open("/home/config/"..configName, "w")
  file:write(sTemp)
  file:close()
end

function writeFaceConfig(fileName)
  local configName = fileName..".cfg"
  local res = getAnalyzerFace()
  local file = io.open("/home/config/"..configName, "w")
  file:write(res)
  file:close()
end

function readAnalyzerConfig(fileName)
  local file = io.open("/home/config/"..fileName, "r")
  local serialTable = file:read()
  file:close()
  return serial.unserialize(serialTable)
end

function readFaceConfig(fileName)
  local file = io.open("/home/config/"..fileName, "r")
  local serialTable = file:read()
  file:close()
  return serialTable
end

function API.checkConfig(fileName)
  local configName = fileName..".cfg"
-- Check if the config folder exist
  if fs.exists("/home/config") then
    print("config exists")
  else
    fs.makeDirectory("/home/config")
  end

  if fs.exists("/home/config/"..configName) then
    if fileName == "analyzerFace" then
      return readFaceConfig(configName)
    else
      return readAnalyzerConfig(configName)
    end
    return readAnalyzerConfig(configName)
  else
    if fileName == "analyzerFace" then
      writeFaceConfig(fileName)
      return readFaceConfig(configName)
    else
      writeAnalyzerConfig(fileName)
      return readAnalyzerConfig(configName)
    end
  end
end

return API
