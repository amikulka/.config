local wezterm = require("wezterm")
local act = wezterm.action
local M = {}

local fd = "/opt/homebrew/bin/fd"

local function insertUnique(projects, entry)
	-- Convert label and id to strings
	local newLabel = tostring(entry.label)
	local newId = tostring(entry.id)
	-- Check if an object with the same id already exists
	for _, project in ipairs(projects) do
		if project.id == newId then
			return false -- Object already exists, don't insert
		end
	end
	-- If we reach here, the object doesn't exist, so insert it
	table.insert(projects, { label = newLabel, id = newId })
	return true -- Indicate that we inserted a new object
end

-- Usage
M.toggle = function(window, pane)
	local projects = {}
	local home = os.getenv("HOME")

	local success, stdout, stderr = wezterm.run_child_process({
		fd,
		"-HI",
		"^.git$",
		"--max-depth=2",
		"--prune",
		home .. "/code",
		home,
	})

	if not success then
		wezterm.log_error("Failed to run fd: " .. stderr)
		return
	end

	for line in stdout:gmatch("([^\n]*)\n?") do
		line = line:gsub("/Users/aaronmikulka", "~")
		local project = line:gsub("/.git.*$", "")
		local label = project
		local id = project:gsub(".*/", "")
		insertUnique(projects, { label = tostring(label), id = tostring(id) })
	end

	local current_dir = tostring(pane:get_current_working_dir()):sub(1, -2)
	insertUnique(
		projects,
		{ label = current_dir:gsub("file://", ""):gsub("/Users/aaronmikulka", "~"), id = current_dir:gsub(".*/", "") }
	)

	local other_paths = {
		home,
		home .. "/code/january",
		home .. "/code/january/src",
		home .. "/code/january/src/devx",
		home .. "/code/january/platform",
		home .. "/code/january/frontend/AgentPortal",
		home .. "/code/january/frontend/BorrowerPortal",
		home .. "/code/january/frontend/ClientPortal",
	}
	for _, path in ipairs(other_paths) do
		table.insert(projects, { label = path:gsub("/Users/aaronmikulka", "~"), id = path:gsub(".*/", "") })
	end

	local subdirs = { "libs/", "apps/", "utils/" }
	local search_paths = {}
	for _, sub in ipairs(subdirs) do
		table.insert(search_paths, home .. "/code/january/src/" .. sub)
	end

	success, stdout, stderr = wezterm.run_child_process({
		fd,
		"--type",
		"d",
		"--max-depth=1",
		".",
		table.unpack(search_paths),
	})

	if not success then
		wezterm.log_error("Failed to run fd: " .. stderr)
		return
	end

	for line in stdout:gmatch("([^\n]*)\n?") do
		line = line:gsub("/Users/aaronmikulka", "~")
		local label = line
		local id = line
		insertUnique(projects, { label = tostring(label), id = tostring(id) })
	end

	table.sort(projects, function(a, b)
		return a.label < b.label
	end)

	window:perform_action(
		act.InputSelector({
			action = wezterm.action_callback(function(win, _, id, label)
				if not id and not label then
					wezterm.log_info("Cancelled")
				else
					wezterm.log_info("Selected " .. label)
					win:perform_action(
						act.SwitchToWorkspace({
							name = id,
							spawn = { cwd = label:gsub("~", "/Users/aaronmikulka") },
						}),
						pane
					)
				end
			end),
			fuzzy = true,
			title = "Select Directory",
			fuzzy_description = "Select a directory: ",
			choices = projects,
		}),
		pane
	)
end

return M
