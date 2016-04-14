local component = require("component")
local term = require("term")
local io = require("io")
local serial = require("serialization")
local fs = component.filesystem
--local rs = component.redstone
-- add Geolyzer address
-- TODO fix Geolyzer proxies
-- example geolyzer[centerAddress, centerFace]
local geolyzer = {}

-- seed tables for each geolyzer
local tableGeoLeft = {}
local tableGeoCenter = {}
local tableGeoRight = {}

function initMakeGeoFile()
  local geoTab = {}
  for _add,_ in pairs(component.list("geolyzer")) do
    table.insert(geoTab, _add)
  end
  for k,d in pairs(geoTab) do
    print(k, d)
  end
  -- Get geolyzer address from user
  term.write("Insert the number for the Center Geolyzer\n")
  local geoCenterAddress = tonumber(term.read())
  term.write("Insert the number for the Left Geolyzer\n")
  local geoLeftAddress = tonumber(term.read())
  term.write("Insert the number for the Right Geolyzer\n")
  local geoRightAddress = tonumber(term.read())
  term.write("What side are the Crops? (use Minecraft directions 0-3)\n")
  local geoFace = tonumber(term.read())
  -- Add geolyzer address & face to main table
  geolyzer.centerAddress = component.proxy(geoTab[geoCenterAddress])
  geolyzer.leftAddress = component.proxy(geoTab[geoLeftAddress])
  geolyzer.rightAddress = component.proxy(geoTab[geoRightAddress])
  geolyzer.face = geoFace
  -- Write geolyzer table to file
  if fs.exists("/home/config") then
    print("config folder exists")
  else
    fs.makeDirectory("/home/config")
    print("made config directory")
  end
  local serialGeolyzer = serial.serialize(geolyzer)
  local file = io.open("/home/config/oc-agri-seed-enhancer.cfg", "w")
  file:write(serialGeolyzer)
  file:close()
end

function initGetGeoFile()
  if fs.exists("/home/config/oc-agri-seed-enhancer.cfg") then
    local file = io.open("/home/config/oc-agri-seed-enhancer.cfg", "r")
    local serialGeolyzer = file:read()
    geolyzer = serial.unserialize(serialGeolyzer)
  else
    print("Config file dosen't exist but why did I Run?")
  end
end

function init()
  if fs.exists("/home/config/oc-agri-seed-enhancer.cfg") then
    initGetGeoFile()
  else
    initMakeGeoFile()
  end
  -- if air

  -- if crops
end

init()
