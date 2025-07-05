local map_timing = {}
map_timing['Chaos Argent'] = {hour = 6, portal = 30, map = 45, open_map = 'Icicle Castle', coord={1371,531}} ---- map each 6 hours open 
map_timing['Demonic World'] = {hour = 3, portal = 40, map = 120, open_map = 'Sacred Snow Mountain', coord={910,1069}}
map_timing['Demonic World 2'] = {hour = 3, portal = 60, map = 120, open_map = 'Demonic World', coord={172,165}}
map_timing['Forsaken City'] = {hour = 3, portal = 60, map = 120, open_map = 'Shaitan City', coord={927,3588}}
map_timing['Forsaken City 2'] = {hour = 3, portal = 40, map = 120, open_map = 'Forsaken City', coord={84,246}}
map_timing['Forsaken City 3'] = {hour = 3, portal = 80, map = 120, open_map = 'Forsaken City 2', coord={249,225}}
map_timing['Dark Swamp'] = {hour = 3, portal = 60, map = 120, open_map = 'Shaitan City', coord={927,3596}}
map_timing['Dark Swamp 2'] = {hour = 3, portal = 120, map = 120, open_map = 'Dark Swamp', coord={153,137}}
map_timing['Dark Swamp 3'] = {hour = 3, portal = 120, map = 120, open_map = 'Dark Swamp 2', coord={501,914}}
map_timing['Guild War'] = {hour = 1, portal = 30, map = 35, open_map = 'Shaitan City', coord={936,3578}}
map_timing['Capture The Flag'] = {hour = 12, portal = 5, map = 35, open_map = 'Shaitan City', coord={936,3578}}

function map_timing_checker(map)
	if map_timing[map] == nil then return 0 end
	local now_hour = os.date("%H")
	local now_minute = tonumber(os.date("%M"))
	
	local map_open = 0
	local portal_open = 0
	local portal_remain_time = 0
	local map_remain_time = 0
	
	local map_open_check = now_hour/map_timing[map].hour
	if map_open_check == math.floor(map_open_check) then
		map_open = 1
		map_remain_time = map_timing[map].map - now_minute
		if(map_timing[map].portal - now_minute) > 1 then
			portal_open = 1
			portal_remain_time = map_timing[map].portal - now_minute
		end
	end
	return map_open,portal_open,portal_remain_time,map_remain_time
end

function map_timing_remain(map)
local now_hour = tonumber(os.date("%H"))
local now_minute = tonumber(os.date("%M"))
local time_remain = 0
	for i = 1,24,1 do
		if i+now_hour <= 24 and time_remain == 0 then
		local calculation = (now_hour+i)/map_timing[map].hour
			if calculation == math.floor(calculation) then
			local minutes = i*60
			time_remain = minutes - now_minute
			end
		end
	end
local remain_min = 0
local remain_hour = 0
	if time_remain >= 60 then
		remain_hour = math.floor(time_remain/60)
		remain_min = time_remain-(remain_hour*60)
		else
		remain_min = time_remain
	end
	return remain_hour,remain_min
end

function map_timing_notice(role,map)
local map_name = map
	if map_timing[map] == nil then
		SystemNotice(role,"Please make sure to use a valid map name and the correct syntax .../checkmap Chaos Argent")
		return
	end
local is_open,portal_open,portal_remain_time,map_remain_time = map_timing_checker(map)

local opening_hour_text = 'Opening hours: Every '..map_timing[map].hour..' hour(s)'
local portal_text = 'Portal opens for: '..map_timing[map].portal..' minutes'
local map_open_text = 'Map opens for: '..map_timing[map].map..' minutes'
	if map_timing[map].map > 60 then
		local hours = math.floor(map_timing[map].map/60)
		local minutes = map_timing[map].map-(hours*60)
		map_open_text = 'Map opens for: '..hours..' hour(s), '..minutes..' minutes'
	end


-- if map is closed show remaining time to open
	if is_open == 0 then
	local remain_hour,remain_min = map_timing_remain(map)
	local remaing_hour_text = 'Opening in '..remain_hour..' hour(s), '..remain_min..' minutes'
		HelpInfoX(role,0,'Information for: '..map_name..'_Location: '..map_timing[map].open_map..' ('..map_timing[map].coord[1]..','..map_timing[map].coord[2]..')_'..opening_hour_text..'_'..portal_text..'_'..map_open_text..'_'..remaing_hour_text..'')
-- if map is open, get portal timing and closing timing
	elseif is_open == 1 then
	local portal_status_text = 'Portal status: closing in '..portal_remain_time..' minutes'
	if portal_remain_time <= 0 then 
		portal_status_text = 'Portal status: Closed'
	elseif portal_remain_time >= 60 then
		local hours = math.floor(portal_remain_time/60)
		local minutes = portal_remain_time-(hours*60)
		portal_status_text = 'Portal status: closing in '..hours..' hour(s), '..minutes..' minutes'
	end
	local map_open_status_text = 'Map status: closing in '..map_remain_time..' minutes'
	if map_remain_time <=0 then 
		map_open_status_text = 'Map status: Recently Closed' 
	elseif map_remain_time >= 60 then
		local hours = math.floor(map_remain_time/60)
		local minutes = map_remain_time-(hours*60)
		map_open_status_text = 'Map status: closing in '..hours..' hour(s), '..minutes..' minutes'
	end
		HelpInfoX(role,0,'Information for: '..map_name..'_Location: '..map_timing[map].open_map..' ('..map_timing[map].coord[1]..','..map_timing[map].coord[2]..')_'..opening_hour_text..'_'..portal_text..'_'..map_open_text..'_'..portal_status_text..'_'..map_open_status_text..'')
	end

end