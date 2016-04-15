local component = require("component")
local term = require("term")
local io = require("io")
local serial = require("serialization")
local fs = component.filesystem
local API = require("ocAgriSeedEnhancerAPI")
-- Get Analyzer Addresses
local analyzerLeft = component.proxy(API.checkConfig("analyzerLeft"))
local analyzerCenter = component.proxy(API.checkConfig("analyzerCenter"))
local analyzerRight = component.proxy(API.checkConfig("analyzerRight"))
-- Get what they are facing eg("NORTH")
local analyzerFace = API.checkConfig("analyzerFace")
-- Variables
local analyzerDetails = {}
--local analyzerSpecimenStats = {}

function checkPlantDetails(analyzer, tabHasPlant)
  if tabHasPlant == true then
    local tempTab = {}
    analyzerDetails[analyzer.."Growth"], analyzerDetails[analyzer.."Gain"], analyzerDetails[analyzer.."Strength"] = growthanalyzer.getSpecimenStats(analyzerFace)
    --tempTab.growth, tempTab.gain, tempTab.strength = growthanalyzer.getSpecimenStats(analyzerFace)
    --return tempTab
  elseif tabHasPlant == false then
    print("Only weeds here")
    -- TODO break sticks and place with seeds
  else
    print("There are no crop sticks")
    -- TODO put down crop sticks and seeds
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

  --local tempTab = checkPlantDetails(analyzerLeft, analyzerDetails.analyzerLeftHasPlant)
  checkPlantDetails(analyzerLeft, analyzerDetails.analyzerLeftHasPlant)
  --analyzerDetails.analyzerLeftGrowth = tempTab.growth
  --analyzerDetails.analyzerLeftGain = tempTab.gain
  --analyzerDetails.analyzerLeftStrength = tempTab.strength
end
