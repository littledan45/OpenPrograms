local component = require("component")
local fs = component.filesystem

function checkCfg()
  if fs.exists("/usr/dev-app/config.lua") then
    print("Yes")
  else
    print("No")
end

for k,d = in pairs(fs.list("/")) do
  print(k, d)
end
