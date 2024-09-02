settings.add("color.suffix", "", "Color for when suffix is matched")
settings.add("suffix.aliases", ".git=git clone;", "Suffix aliases")

local suffixes = {}

for suffix_prepend_pair in string.gmatch(settings.get("suffix.aliases"), "([^;]+)") do
	local suffix = {}
	for suffix_or_prepend in string.gmatch(suffix_prepend_pair, "([^=]+)") do
		table.insert(suffix, suffix_or_prepend)
	end

	suffixes[suffix[1]] = suffix[2]
end

local function escape_pattern(str)
	return str:gsub("(%W)", "%%%1")
end

local function get_suffix(word)
	for suffix in pairs(suffixes) do
		local pattern = escape_pattern(suffix) .. "$"
		if word:match(pattern) then
			return suffix
		end
	end
	return false
end

local suffix_classifier = clink.classifier(1)
function suffix_classifier:classify(commands)
	local line = commands[1].line_state:getline()
	local color = settings.get("color.suffix") or ""
	local classifications = commands[1].classifications
	local last_index = 1

	for word in line:gmatch("%S+") do
		local match = get_suffix(word)
		local start_index, end_index = string.find(line, word, last_index, true)
		last_index = end_index + 1

		if match and suffixes[match] then
			classifications:applycolor(start_index, end_index - start_index + 1, color)
		end
	end
end

local function onfilterinput(line)
	local words = {}
	for word in line:gmatch("%S+") do
		local match = get_suffix(word)
		if match and suffixes[match] then
			word = suffixes[match] .. " " .. word
		end
		table.insert(words, word)
	end
	return table.concat(words, " ")
end

if clink.onfilterinput then
	clink.onfilterinput(onfilterinput)
else
	clink.onendedit(onfilterinput)
end
