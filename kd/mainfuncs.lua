----------------------------------
-- Kill/Death Ratio Script
----------------------------------
print("enabling Ranking functions")

----------------------------
-- NPC Function
----------------------------
function nash_LV1()
	InitTrigger()
	TriggerCondition( 1, CheckIsPvPWinner, 1 )
	TriggerAction( 1, JumpPage, 4 )
	TriggerCondition( 2, CheckIsPvPWinner2, 1 )
	TriggerAction( 2, JumpPage, 5 )
	TriggerFailure( 2, JumpPage,1)
	Start( GetMultiTrigger(), 2 )
Talk(1,"          ***Player PvP Rankings***")
Text(1,_PkP.Server_Name.."        Maze Player Rankings",JumpPage,2)
Text(1,"       My Kills & Death Ratio",PlayerPkPCheck)
Text(1,"     Check My Record For A Maze",JumpPage,3)
Talk(2,"Select a Map to check the Rankings.")
Talk(3,"                  Select a Map _    <<<<Check Your Kills & Death Ratio>>>>")
Text(2,"Global Ranking",GetRankingListing,"overall")
Text(3,"Global Ranking",PlayerPkPMazeCheck,"overall")
	for i,v in pairs(_PkP.Recording) do
		if(i ~= "overall")then
		Text(2,v.." Ranking",GetRankingListing,i)
		Text(3,v,PlayerPkPMazeCheck,i)
		end
	end
Talk(4,"Congratulations, you were the winner for the last month!")
Text(4,"Please click here to recieve your reward",PvPWinnerReward)
Talk(5,"Congratulations, you were in the top5 ranking for the last month!")
Text(5,"Please click here to recieve your reward",PvPWinnerReward2)
end
-----------------------------
-- Player Kill Player function
-----------------------------
function KD_PKP(ignore,p1,p2)
local map = GetChaMapName(p1)
local p1name = GetChaDefaultName(p1)
local p2name = GetChaDefaultName(p2)
	if(_PkP.Recording[map] ~= nil)then
		AddKill(p1)
		AddDeath(p2)
	end
end
-----------------------------
-- Reset Ranking Function
-----------------------------

function ResetPkPRanks()
local Table,scoring = table.load(_PkP.logfile.."Logs.txt","r"),{}
for i,v in pairs(Table["overall"])do local kills = v.kill scoring[i] = { score = kills} end
local r1,r2,r3,r4,r5 = CalculateRanking( scoring )
Notice("[Ranking NPC] Maze Ranking has been reset! Rise to the top now! This month winner is "..r1.."! He may visit the NPC and collect his reward!")

	if(_PkP.Reward1st == true)then
		table.save({},_PkP.logfile..r1..".txt","w")
	end
	if(_PkP.RewardOthers == true)then
		table.save({},_PkP.logfile2..r2..".txt","w")
		table.save({},_PkP.logfile2..r3..".txt","w")
		table.save({},_PkP.logfile2..r4..".txt","w")
		table.save({},_PkP.logfile2..r5..".txt","w")
	end
os.remove(_PkP.logfile.."Logs.txt")
RegisterMaps()
end
-----------------------------
-- Reset Timer
-----------------------------
b_cha_timer = cha_timer

function KD_PKP_TIMER(ignore,cha)
local month = os.date("%m")
	if(file_exists(_PkP.logfile.."Reset Month.txt") ~= false)then
	local tmonth = table.load(_PkP.logfile.."Reset Month.txt","r")
		if month ~= tmonth.startingmonth then
		ResetPkPRanks()
		end
	end
end

function cha_timer(role, freq, time)
	b_cha_timer(role, freq, time)
	KD_PKP_TIMER(nil, role)
end


-----------------------------
-- Hooks
------------------------------
--Hook:AddPostHook("cha_timer",KD_PKP_TIMER)
Hook:AddPostHook("after_player_kill_player",KD_PKP)

print("activated Rank System")
