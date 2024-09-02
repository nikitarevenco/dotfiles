local green = "\x1b[92m"
local blue = "\x1b[34m"
local magenta = "\x1b[35m"
local cyan = "\x1b[36m"
local white = "\x1b[37m"
local normal = "\x1b[m"

local bracket_prompt = clink.promptfilter(150)
function bracket_prompt:filter()
	return green .. " ➜ " .. normal
end

function bracket_prompt:rightfilter()
	return blue
		.. os.getcwd():gsub("%" .. os.getenv("USERPROFILE"), magenta .. "~" .. blue):gsub("%\\", white .. "/ " .. blue)
		.. " "
		.. normal
end
