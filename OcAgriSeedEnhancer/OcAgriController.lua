local compontents = require("compontents")
-- add Geolyzer address
local geoLeft = compontents.proxy("")
local geoCenter = compontents.proxy("")
local geoRight = compontents.proxy("")

local tableGeoLeft = {}
local tableGeoRight = {}
-- Make sure you change block dirrection
local constGeoLeftDir = 4
local constGeoCenterDir = 4
local constGeoRightDir = 4

function geoAnalyze(geo, direction)
  return geo.analyze(direction)
end

function init()
  tableGeoLeft = geoAnalyze(geoLeft, constGeoLeftDir)
  tableGeoRight = geoAnalyze(geoRight, constGeoRightDir)
end
