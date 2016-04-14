local component = require("component")
local io = require("io")
local fs = require("filesystem")
local serial = require("serialization")

local API = {}

function getAnalyzer(configFileName)
  print("Starting getAnalyzer with Filename", configFileName)
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
  local address = getAnalyzer(fileName)
  local file = io.open("/home/config/"..configName, "w")
  file:write(address)
  file:close()
end

function writeConfig(fileName)
  local configName = fileName..".cfg"
  local res = getAnalyzerFace()
  local file = io.open("/home/config/"..configName, "w")
  file:write(res)
  file:close()
end

function readConfig(fileName)
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
    return readConfig(configName)
  else
    if fileName == analyzerFace then
      writeConfig(fileName)
      return readConfig(configName)

    else
      writeAnalyzerConfig(fileName)
      return readConfig(configName)
    end
  end
end

return API
