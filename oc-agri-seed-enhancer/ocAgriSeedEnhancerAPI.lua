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
  local _id = tonumber(io.read())
  return _analyzers[_id]
end

function writeConfig(fileName)
  local configName = fileName..".cfg"
  --local tempTable = {}
  --tempTable[fileName] = getAnalyzer(fileName)
  local address = getAnalyzer(fileName)
  --local sTempTable = serial.serialize(tempTable)
  local file = io.open("/home/config/"..configName, "w")
  file:write(address)
  file:close()
end

function readConfig(fileName)
  local file = io.open("/home/config/"..fileName, "r")
  local serialTable = file:read()
  --return serial.unserialize(serialTable)
  return serialTable
end

function API.checkConfig(fileName)
  local configName = fileName..".cfg"
  if fs.exists("/home/config") then
    print("config exists")
  else
    fs.makeDirectory("/home/config")
  end
  if fs.exists("/home/config/"..configName) then
    print(configName.. "exists")
    local result = readConfig(configName)
    print(result)
    return result
  else
    writeConfig(fileName)
  end
end

return API
