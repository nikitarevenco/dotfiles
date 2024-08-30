local suffix_aliases = {
	[".git"] = "git clone",
}

-- For highlighting
local function file_exists_in_directory(directory, filename)
	local separator = "\\"
	local path = directory .. separator .. filename
	local file = io.open(path, "r")
	if file then
		file:close()
		return true
	end
	return false
end

local function is_in_path(program)
	local path_env = os.getenv("PATH")
	local path_ext = os.getenv("PATHEXT")

	if not path_ext then
		error("%PATHEXT% is not available")
	elseif not path_env then
		error("%PATH% is not available")
	end

	local extensions = {}

	for str in string.gmatch(path_ext, "([^;]+)") do
		table.insert(extensions, str)
	end

	local split_path = string.gmatch(path_env, "[^;]+")

	for dir in split_path do
		for _, ext in ipairs(extensions) do
			if file_exists_in_directory(dir, program .. ext) then
				return true
			end
		end
	end

	return false
end

local function string_endswith(string, suffix)
	return string:sub(-#suffix) == suffix
end

local function onfilterinput(text)
	for suffix, command in pairs(suffix_aliases) do
		if string_endswith(text, suffix) then
			clink.argmatcher(text)
			local text_without_suffix = string.sub(text, 0, #text - #suffix)
			if not is_in_path(text_without_suffix) then
				return command .. " " .. text
			end
		end
	end
end

if clink.onfilterinput then
	clink.onfilterinput(onfilterinput)
else
	clink.onendedit(onfilterinput)
end
