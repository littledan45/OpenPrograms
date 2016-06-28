local event = require("event")
local term = require("term")
local component = require("component")
local gpu = component.gpu
local rs = component.redstone
local colors = require("colors")
local sides = require("sides")

local w, h = gpu.getResolution()
local e, p, m
local rsPower = colors.red
local sidePower = sides.east
local current = false

function main()
	term.clear()
	update_mon()
	while true do
		e,_,p,m = event.pull()
		handle_event()
		update_mon()
	end
end

function update_mon()
	if rs.getBundledOutput(sidePower, rsPower) == 0 then
		if current == true then
			generate_mon(colors.red)
			current = false
		end
	else
		if current == false then
			generate_mon(colors.green)
			current = true
		end
	end
end

function generate_mon(color)
	gpu.setBackground(color, true)
	gpu.fill(w/2-7, 2, 15, 3, " ")
	gpu.set(w/2-2, 3, "Power")
	gpu.setBackground(colors.black, true)
end

function handle_event()
	--e,_,p,m = event.pull()
	if e == "chat_message" then
		if auth(p) == true then
			result = get_command(m)
			if result["key"] == true then
				if result["message"] == "shutdown_power" then
					shutdown_power()
				elseif result["message"] == "startup_power" then
					startup_power()
				end
			end
		end
	elseif e == "touch" then
		if p > w/2-8 and p < w/2+16 then
			if m > 1 and m < 5 then
				if rs.getBundledOutput(sidePower, rsPower) == 0 then
					startup_power()
				else
					shutdown_power()
				end
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

function startup_power()
	rs.setBundledOutput(sidePower, rsPower, 15)
end

main()