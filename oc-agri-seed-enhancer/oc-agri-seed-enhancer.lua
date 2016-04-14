local component = require("component")
local term = require("term")
local io = require("io")
local serial = require("serialization")
local fs = component.filesystem
--local rs = component.redstone
-- example analyzer[centerAddress, centerFace]
local analyzer = {}

function initMakeAnaFile()
  local anaTab = {}
  for _add,_ in pairs(component.list("agricraft_peripheral")) do
    table.insert(anaTab, _add)
  end
  for k,d in pairs(anaTab) do
    print(k, d)
  end
  -- Get analyzer address from user
  local directions = {"NORTH", "SOUTH", "WEST", "EAST"}
  term.write("Insert the number for the Center Analyzer\n")
  local anaCenterAddress = tonumber(term.read())
  term.write("Insert the number for the Left Analyzer\n")
  local anaLeftAddress = tonumber(term.read())
  term.write("Insert the number for the Right Analyzer\n")
  local anaRightAddress = tonumber(term.read())
  for k,d in pairs(directions) do
    term.write(k, d)
  end
  term.write("What side are the Crops?\n")
  local anaFace = tonumber(term.read())
  -- Add analyzer address & face to main table
  analyzer.centerAddress = component.proxy(anaTab[anaCenterAddress])
  analyzer.leftAddress = component.proxy(anaTab[anaLeftAddress])
  analyzer.rightAddress = component.proxy(anaTab[anaRightAddress])
  analyzer.face = directions[anaFace]
  -- Write analyzer table to file
  if fs.exists("/home/config") then
    print("config folder exists")
  else
    fs.makeDirectory("/home/config")
    print("made config directory")
  end
  local serialanalyzer = serial.serialize(analyzer)
  local file = io.open("/home/config/oc-agri-seed-enhancer.cfg", "w")
  file:write(serialanalyzer)
  file:close()
end

function initGetAnaFile()
  if fs.exists("/home/config/oc-agri-seed-enhancer.cfg") then
    local file = io.open("/home/config/oc-agri-seed-enhancer.cfg", "r")
    local serialanalyzer = file:read()
    analyzer = serial.unserialize(serialanalyzer)
  else
    print("Config file dosen't exist but why did I Run?")
  end
end

function init()
  term.clear()
  if fs.exists("/home/config/oc-agri-seed-enhancer.cfg") then
    initGetAnaFile()
  else
    initMakeAnaFile()
  end
--check if block is air or seed

end

init()
