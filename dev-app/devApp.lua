local fs = require("filesystem")

for k,d = in pairs(fs.list("/")) do
  print(k, d)
end
