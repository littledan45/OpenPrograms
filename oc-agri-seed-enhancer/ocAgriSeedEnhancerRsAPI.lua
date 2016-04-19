local component = require("component")
local rs - component.redstone

local API = {}

function API.executeRedstone(side, rsColor)
  rs.setBundledOutput(side, rsColor, 15)
  os.sleep(1)
  rs.setBundledOutput(side, rsColor, 0)
end

return API
