local component = require("component")
-- add Geolyzer address
-- TODO fix Geolyzer proxies
local geoLeft = component.proxy("")
local geoCenter = component.proxy("")
local geoRight = component.proxy("")
-- add Redstone address
local rs = component.proxy("")

-- What side are the Crop stick on
local constGeolyzerFace = 4

local tableGeoLeft = {}
local tableGeoCenter = {}
local tableGeoRight = {}

function geoAnalyze(geo, direction)
  return geo.analyze(direction)
end

function init()
  tableGeoLeft = geoAnalyze(geoLeft, constGeolyzerFace)
  tableGeoRight = geoAnalyze(geoRight, constGeolyzerFace)

  -- if air

  -- if crops
end
