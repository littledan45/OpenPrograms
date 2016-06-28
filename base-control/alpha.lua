local event = require("event")
local component = require("component")
local rs = component.redstone
local colors = require("colors")
local sides = require("sides")

local rsPower = colors.red
local sidePower = sides.east

_,_,p,m = event.pull("chat_message")

print(p,m)

function main()
	rsControl()
end

function rsControl()
	if auth(p) == true then
		result = get_command(m)
		if result["key"] == true then
			if result["message"] == "shutdown_power" then
				shutdown_power()
				print("Shuting down Power")
			elseif result["message"] == "startup_power" then
				startup_power()
				print("Starting Up Power")
			end
		end
	end
end

function auth(user)
  if user == "littledan45" then
  	return true
	else
		return false
  end
end

function get_command(message)
	message_tab = {}
	for s in string.gmatch(message, "%S+") do
		if s == "alpha" then
			message_tab["key"] = true
		else
			if message_tab["key"] == true then
				message_tab["message"] = s
			else
				break
			end
		end
	end
	return message_tab
end

function shutdown_power()
	rs.setBundledOutput(sidePower, rsPower, 0)
end

function startup_power(rsColor)
	rs.setBundledOutput(sidePower, rsPower, 15)
end

main()