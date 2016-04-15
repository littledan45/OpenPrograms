local component = require("component")
local term = require("term")
local io = require("io")
local serial = require("serialization")
local fs = component.filesystem
local gpu = component.gpu
-- place first stick orange=left, magenta=center, lightblue=right
-- place seeds yellow=left, lime=right
-- place second stick pink=center
-- break grey=left, silver=center, cyan=right
local rs = component.redstone
local API = require("ocAgriSeedEnhancerAPI")
-- Get Analyzer Addresses

local tabAnalyzerLeft = {} --TODO add config table
local tabAnalyzerCenter = {} --TODO add config table
local tabAnalyzerRight = {} --TODO add config table

local analyzerLeft = component.proxy(API.checkConfig("analyzerLeft"))
local analyzerCenter = component.proxy(API.checkConfig("analyzerCenter"))
local analyzerRight = component.proxy(API.checkConfig("analyzerRight"))
-- Get what they are facing eg("NORTH")
local analyzerFace = API.checkConfig("analyzerFace")
-- Variables
local analyzerDetails = {}
--local analyzerSpecimenStats = {}

function checkInitPlantDetails(analyzer, tabHasPlant)
  if tabHasPlant == true then
    return analyzer.getSpecimenStats(analyzerFace)
  elseif tabHasPlant == false then
    if analyzer ~= analyzerCenter then
      gpu.setForeground(0xff0000)
      print("Only weeds here. Please place seeds and restart the program")
      gpu.setForeground(0xffffff)
      os.exit()
    else
      --TODO break sticks
    end
  else
    if analyzer ~= analyzerCenter then
      gpu.setForeground(0xff0000)
      print("There are no crop sticks")
      print("Please place seeds and restart the program")
      gpu.setForeground(0xffffff)
      os.exit()
    end
  end
end

function checkWeedOrPlant(analyzer)
  if analyzer.hasPlant(analyzerFace) == true then
    return true
  elseif analyzer.hasWeeds(analyzerFace) == true then
    return false
  else
    return nil
  end
end

function initCheck()
  analyzerDetails.analyzerLeftHasPlant = checkWeedOrPlant(analyzerLeft)
  analyzerDetails.analyzerCenterHasPlant = checkWeedOrPlant(analyzerCenter)
  analyzerDetails.analyzerRightHasPlant = checkWeedOrPlant(analyzerRight)

  analyzerDetails.analyzerLeftGrowth, analyzerDetails.analyzerLeftGain, analyzerDetails.analyzerLeftStrength = checkInitPlantDetails(analyzerLeft, analyzerDetails.analyzerLeftHasPlant)
  analyzerDetails.analyzerCenterGrowth, analyzerDetails.analyzerCenterGain, analyzerDetails.analyzerCenterStrength = checkInitPlantDetails(analyzerCenter, analyzerDetails.analyzerCenterHasPlant)
  analyzerDetails.analyzerRightGrowth, analyzerDetails.analyzerRightGain, analyzerDetails.analyzerRightStrength = checkInitPlantDetails(analyzerRight, analyzerDetails.analyzerRightHasPlant)
end
