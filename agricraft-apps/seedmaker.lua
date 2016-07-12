local component = require("component")
local colors = require("colors")
local sides = require("sides")
local analyzer = component.proxy("")
local rs = component.redstone
local chat = component.chat_box
local term = require("term")
 
local running = true
local seed = nil
local analyzerFace = "NORTH"
chat.setName("Mandy")
chat.setDistance(100)
 
local rsExtractRight = colors.lime
local rsBreakCenter = colors.red
local rsPlaceStickCenter = colors.yellow
local rsPlaceCrossCenter = colors.green
 
 
function main()
  term.clear()
  seed = term.read()
  if seed == nil then
    print("Seed can not be nil")
    seed = term.read()
  end
  while running == true do
    getState()
    os.sleep(5)
    getSeed()
  end
end
 
function breakCross()
  rs.setBundledOutput(sides.top, rsBreakCenter, 15)
  os.sleep(1)
  rs.setBundledOutput(sides.top, rsBreakCenter, 0)
end
 
function placeCross()
  rs.setBundledOutput(sides.top, rsPlaceStickCenter, 15)
  os.sleep(1)
  rs.setBundledOutput(sides.top, rsPlaceStickCenter, 0)
  rs.setBundledOutput(sides.top, rsPlaceCrossCenter, 15)
  os.sleep(.5)
  rs.setBundledOutput(sides.top, rsPlaceCrossCenter, 0)
end
 
function getState()
  if analyzer.isCrossCrop(analyzerFace) == true then
    --print("isCrossCrop")
  else
    breakCross()
    os.sleep(4)
    placeCross()
  end
end
 
function removeSeed()
  rs.setBundledOutput(sides.top, rsExtractRight, 15)
  os.sleep(1)
  rs.setBundledOutput(sides.top, rsExtractRight, 0)
end
 
function getSeed()
  plant = analyzer.getSpecimen()
  if plant == seed then
    analyzer.analyze()
    os.sleep(1)
    print(plant)
    chat.say("Master I finished " .. plant)
    removeSeed()
    running = false
  else
    if plant ~= nil then
      analyzer.analyze()
      os.sleep(1)
      print(plant)
      removeSeed()
    end
  end
end
 
 
main()