local component = require("component")
local colors = require("colors")
local sides = require("sides")
local analyzerLeft = component.proxy("")
local analyzerCenter = component.proxy("")
local analyzerRight = component.proxy("")
local rs = component.redstone
local chat = component.chat_box
 
local running = true
local analyzerCenterFace = "WEST"
local analyzerFace = "EAST"
local sendRight = true
chat.setName("Ellen")
chat.setDistance(100)

local rsExtractLeft = colors.lime
local rsExtractRight = colors.orange
local rsBreakLeft = colors.white
local rsBreakCenter = colors.red
local rsBreakRight = colors.magenta
local rsPlaceStickLeft = colors.pink
local rsPlaceStickCenter = colors.yellow
local rsPlaceStickRight = colors.gray
local rsPlaceSeedLeft = colors.black 
local rsPlaceCrossCenter = colors.green
local rsPlaceSeedRight = colors.blue

 
function main()
  while running == true do
    --print("running main")
    local leftReady = getGrowth(analyzerLeft)
    local rightReady = getGrowth(analyzerRight)
    --print(leftReady, rightReady)
    if rightReady == true and leftReady == true then
      getStateCenter()
    end
    os.sleep(5)
  end
end

function getSeed()
  --print("getSeed")
  getSeedDone = false
  repeat
    growth, gain, strength = analyzerCenter.getSpecimenStats()
    if growth == 10 and gain == 10 and strength == 10 then
      analyzerCenter.analyze()
      os.sleep(2)
      print("Finished with enhancing Seed")
      chat.say("Finished with enhancing Seed")
      getSeedDone = true
      running = false
    else
      if growth ~= nil then
        analyzerCenter.analyze()
        os.sleep(2)
        getSeedDone = true
        print("Seed stats: " .. growth .. " " .. gain .. " " .. strength)
        chat.say("Seed stats: " .. growth .. " " .. gain .. " " .. strength)
        if sendRight == true then
          extract(rsExtractRight)
          os.sleep(5)
          breakSticks(rsBreakRight)
          repeat
            os.sleep(1)
            placeSeed(rsPlaceStickRight)
            os.sleep(1)
            placeSeed(rsPlaceSeedRight)
          until analyzerRight.hasPlant(analyzerFace) == true
          os.sleep(1)
          sendRight = false
        else
          extract(rsExtractLeft)
          os.sleep(5)
          breakSticks(rsBreakLeft)
          repeat
            os.sleep(1)
            placeSeed(rsPlaceStickLeft)
            os.sleep(1)
            placeSeed(rsPlaceSeedLeft)
          until analyzerLeft.hasPlant(analyzerFace) == true
          os.sleep(1)
          sendRight = true
        end
      end
    end
  until getSeedDone == true
end

function getStateCenter()
  --print("getStateCenter")
  if analyzerCenter.hasPlant(analyzerCenterFace) == true then
    --print("isCrossCrop")
    breakSticks(rsBreakCenter)
    os.sleep(5)
    getSeed()
   elseif analyzerCenter.isCrossCrop(analyzerCenterFace) ~= true then
    placeCross()
  end
end

function placeCross()
  rs.setBundledOutput(sides.top, rsPlaceStickCenter, 15)
  os.sleep(1)
  rs.setBundledOutput(sides.top, rsPlaceStickCenter, 0)
  rs.setBundledOutput(sides.top, rsPlaceCrossCenter, 15)
  os.sleep(.5)
  rs.setBundledOutput(sides.top, rsPlaceCrossCenter, 0)
end

function placeSeed(rsPlaceColor)
  rs.setBundledOutput(sides.top, rsPlaceColor, 15)
  os.sleep(1)
  rs.setBundledOutput(sides.top, rsPlaceColor, 0)
end

function getGrowth(analyzer)
  if analyzer.getGrowthStage(analyzerFace) == 100 then
    return true
   else
    return false
  end
end

function breakSticks(rsColor)
  rs.setBundledOutput(sides.top, rsColor, 15)
  os.sleep(1)
  rs.setBundledOutput(sides.top, rsColor, 0)
end

function extract(rsColor)
  rs.setBundledOutput(sides.top, rsColor, 15)
  os.sleep(2)
  rs.setBundledOutput(sides.top, rsColor, 0)
end
 
main()