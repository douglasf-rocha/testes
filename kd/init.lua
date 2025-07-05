----------------------------------
-- Kill/Death Ratio Script
----------------------------------
print("enabling Ranking")
_PkP = {}
_PkP.Server_Name = ""
_PkP.path = GetResPath("../lua/plugin/KD/")
_PkP.logfile = _PkP.path.."records/"
_PkP.logfile2 = _PkP.path.."records2/"
_PkP.Recording = {}

_PkP.Reward1st = true -- Enable/Disable rewards for the first rank
_PkP.RewardOthers = true -- Enable/Disable rewards for 2nd to 5th


_PkP.rewards = {}
_PkP.rewards2 = {}
-- 1st rewards
_PkP.rewardAmount = 3 -- slots required
_PkP.rewards[1] = { id = 0854 , amount = 3 } -- non stackable - 2 slots
_PkP.rewards[2] = { id = 7832 , amount = 2 } -- stackable takes 1 slot

-- 2nd to 5th rewards
_PkP.rewardAmount2 = 3 -- slots required
_PkP.rewards2[1] = { id = 7831 , amount = 5 } -- non stackable - 2 slots
_PkP.rewards2[2] = { id = 7025 , amount = 1 } -- stackable takes 1 slot


-- Add your maps
--_PkP.Recording["deathcircle"] = "Death Circle"
--_PkP.Recording["Rome"] = "Rome"
_PkP.Recording["garner2"] = "Chaos Argent"
--_PkP.Recording["puzzleworld"] = "Demonic World"
_PkP.Recording["jialebi"] = "Gods of Heaven"
_PkP.Recording["eastgoaf"] = "BD Lair"
--_PkP.Recording["abandonedcity"] = "Forsaken City"
--_PkP.Recording["darkswamp"] = "Dark Swamp"

-- Do not edit this one!
_PkP.Recording["overall"] = "Global"

--[[ NpcSdk.lua Lines
		elseif item.func == GetRankingListing then
			GetRankingListing( character,item.p1)
		elseif item.func == PlayerPkPMazeCheck then
			PlayerPkPMazeCheck( character,item.p1)
		elseif item.func == PlayerPkPCheck then
			PlayerPkPCheck( character)
		elseif item.func == PvPWinnerReward then
			PvPWinnerReward( character)
		elseif item.func == PvPWinnerReward2 then
			PvPWinnerReward2( character)
			
	MissionSdk.lua Lines add this somewhere around line 2500
				elseif conditions[i].func == CheckIsPvPWinner then
				PRINT( "ConditionsTest:CheckIsPvPWinner, p1 = ", conditions[i].p1 )
				local ret = CheckIsPvPWinner( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest: CheckIsPvPWinner = false" )
					return LUA_FALSE
				end
				elseif conditions[i].func == CheckIsPvPWinner2 then
				PRINT( "ConditionsTest:CheckIsPvPWinner, p1 = ", conditions[i].p1 )
				local ret = CheckIsPvPWinner2( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest: CheckIsPvPWinner2 = false" )
					return LUA_FALSE
				end
]]--

-----------------------------
-- Save Now Month
-----------------------------
function KD_StoreMonth()
local month = os.date("%m")
table.save({startingmonth = month},_PkP.logfile.."Reset Month.txt","w")
end

-----------------------------
-- Re-Register Maps/ Reset function
------------------------------

function RegisterMaps()
local key = "Logs"
	if(file_exists(_PkP.logfile..key..".txt") ~= false)then
		local stable = table.load(_PkP.logfile..key..".txt","r")
		for i,v in pairs(_PkP.Recording)do
			if stable[i] == nil then
			stable[i] = {}
			table.save(stable,_PkP.logfile..key..".txt","w")
			end
		end
		else
	local stable = {}
	for i,v in pairs(_PkP.Recording)do
		stable[i] = {}
		table.save(stable,_PkP.logfile..key..".txt","w")
		end
	end
	KD_StoreMonth()
end
RegisterMaps()

---------------------------------
-- Load Neccesary files
---------------------------------
dofile(_PkP.path.."/lib.lua")
dofile(_PkP.path.."/mainfuncs.lua")
