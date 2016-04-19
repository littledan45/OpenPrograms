local component = require("component")
local term = require("term")
local io = require("io")
local serial = require("serialization")
local fs = component.filesystem
local gpu = component.gpu
local rs = component.redstone
-- place first stick orange=left, magenta=center, lightblue=right
-- place seeds yellow=left, lime=right
-- place second stick pink=center
-- break grey=left, silver=center, cyan=right
-- extract green=left, brown=right purple=trashseeds
local rs = component.redstone
local FileAPI = require("ocAgriSeedEnhancerFileAPI")
-- Get Analyzer Addresses

local tabAnalyzerLeft = FileAPI.checkConfig("analyzerLeft")
local tabAnalyzerCenter = FileAPI.checkConfig("analyzerCenter")
local tabAnalyzerRight = FileAPI.checkConfig("analyzerRight")

local analyzerLeft = component.proxy(tabAnalyzerLeft.address)
local analyzerCenter = component.proxy(tabAnalyzerCenter.address)
local analyzerRight = component.proxy(tabAnalyzerRight.address)
-- Get what they are facing eg("NORTH")
local analyzerFace = FileAPI.checkConfig("analyzerFace")
-- Variables
local analyzerDetails = {}
--local analyzerSpecimenStats = {}

function getPlantDetails(analyzer, tabHasPlant)
  if tabHasPlant == "Plant" then
    return analyzer.getSpecimenStats(analyzerFace)
  elseif tabHasPlant == "Weeds" then
    if analyzer ~= analyzerCenter then
      repeat
        gpu.setForeground(0xff0000)
        print("Place a Seed by analyzer", analyzer.address)
        gpu.setForeground(0xffffff)
        os.sleep(5)
      until checkWeedOrPlant(analyzer) == "Plant"
      return analyzer.getSpecimenStats(analyzerFace)
    else
      --TODO break sticks
    end
  else
    if analyzer ~= analyzerCenter then
      repeat
        gpu.setForeground(0xff0000)
        print("Place a crop sticks by analyzer", analyzer.address)
        gpu.setForeground(0xffffff)
        os.sleep(5)
      until checkWeedOrPlant(analyzer) == "Plant"
      return analyzer.getSpecimenStats(analyzerFace)
    end
  end
end

function checkWeedOrPlant(analyzer)
  if analyzer.hasPlant(analyzerFace) == true then
    return "Plant"
  elseif analyzer.hasWeeds(analyzerFace) == true then
    return "Weeds"
  else
    return nil
  end
end

function runCheckWeedOrPlant()
  analyzerDetails.analyzerLeftHasPlant = checkWeedOrPlant(analyzerLeft)
  analyzerDetails.analyzerCenterHasPlant = checkWeedOrPlant(analyzerCenter)
  analyzerDetails.analyzerRightHasPlant = checkWeedOrPlant(analyzerRight)
end

function runGetPlantDetails()
  analyzerDetails.analyzerLeftGrowth, analyzerDetails.analyzerLeftGain, analyzerDetails.analyzerLeftStrength = getPlantDetails(analyzerLeft, analyzerDetails.analyzerLeftHasPlant)
  analyzerDetails.analyzerRightGrowth, analyzerDetails.analyzerRightGain, analyzerDetails.analyzerRightStrength = getPlantDetails(analyzerRight, analyzerDetails.analyzerRightHasPlant)
end

function runGetGrowthStage()
  analyzerDetails.analyzerLeftGrowthStage = analyzerLeft.getGrowthStage(analyzerFace)
  analyzerDetails.analyzerRightGrowthStage = analyzerRight.getGrowthStage(analyzerFace)
end

function initCheck()
  runCheckWeedOrPlant()

  runGetPlantDetails()

  runGetGrowthStage()
end

function compareSeeds()

end

function run()
  --scan

  --rotate
end
