----------------------------------
-- Kill/Death Ratio Script
----------------------------------
print("enabling Ranking Libs")

function GetPlayerKey(role)
	local hex,name = '', GetChaDefaultName(role)
	while string.len(name) > 0 do
		local hb = string.format("%X", string.byte(name, 1, 1))
		if string.len(hb) < 2 then 
			hb = '0' .. hb 
		end        
		hex = hex .. hb        
		name = string.sub(name, 2)    
	end    
	return hex
end

function AddKill(c)
local key = "Logs"
local name = GetChaDefaultName(c)
local map = GetChaMapName(c)
local stable1 = table.load(_PkP.logfile..key..".txt","r")
local stable = stable1[map]
	if(stable1[map][name] ~= nil)then	
		local k = stable1[map][name].kill
		local d = stable1[map][name].death
		local r = stable1[map][name].ratio
		stable1[map][name] = {kill = k + 1 , death = d , ratio = r }
		table.save(stable1,_PkP.logfile..key..".txt","w")
	else
		stable1[map][name] = {kill = 1 , death = 0 , ratio = 0 }
		table.save(stable1,_PkP.logfile..key..".txt","w")
	end
	if(stable1["overall"][name] == nil)then
		stable1["overall"][name] = {kill = 0 , death = 0 , ratio = 0 }
	end
	local k0 = stable1["overall"][name].kill
	local d0 = stable1["overall"][name].death
	local r0 = stable1["overall"][name].ratio
	stable1["overall"][name] = {kill = k0 + 1 , death = d0 , ratio = r0 }
	table.save(stable1,_PkP.logfile..key..".txt","w")
end

function AddDeath(c)
local key = "Logs"
local name = GetChaDefaultName(c)
local map = GetChaMapName(c)
local stable1 = table.load(_PkP.logfile..key..".txt","r")
local stable = stable1[map]
	if(stable1[map][name] ~= nil)then	
		local k = stable1[map][name].kill
		local d = stable1[map][name].death
		local r = stable1[map][name].ratio
		stable1[map][name] = {kill = k , death = d + 1, ratio = r }
		table.save(stable1,_PkP.logfile..key..".txt","w")
	else
		stable1[map][name] = {kill = 0 , death = 1 , ratio = 0 }
		table.save(stable1,_PkP.logfile..key..".txt","w")
	end
	if(stable1["overall"][name] == nil)then
		stable1["overall"][name] = {kill = 0 , death = 0 , ratio = 0 }
	end
	local k0 = stable1["overall"][name].kill
	local d0 = stable1["overall"][name].death
	local r0 = stable1["overall"][name].ratio
	stable1["overall"][name] = {kill = k0 , death = d0 + 1 , ratio = r0 }
	table.save(stable1,_PkP.logfile..key..".txt","w")
end


function CalculateRanking( tab )
	local rank1 = { name=nil, score=-1}
	local rank2 = { name=nil, score=-1}
	local rank3 = { name=nil, score=-1}
	local rank4 = { name=nil, score=-1}
	local rank5 = { name=nil, score=-1}
	for charname,attributes in next,tab do
		if (attributes.score > rank1.score) then
			rank5.name = rank4.name
			rank5.score = rank4.score

			rank4.name = rank3.name
			rank4.score = rank3.score
			
			rank3.name = rank2.name
			rank3.score = rank2.score

			rank2.name = rank1.name
			rank2.score = rank1.score

			rank1.name = charname
			rank1.score = attributes.score
		else 
			if (attributes.score > rank2.score) then		  
				rank5.name = rank4.name
				rank5.score = rank4.score		 
				
				rank4.name = rank3.name
				rank4.score = rank3.score	
				
				rank3.name = rank2.name
				rank3.score = rank2.score

				rank2.name = charname
				rank2.score = attributes.score
			else
				if (attributes.score > rank3.score) then		  
					rank5.name = rank4.name
					rank5.score = rank4.score	  
					
					rank4.name = rank3.name
					rank4.score = rank3.score
					
					rank3.name = charname
					rank3.score = attributes.score
					else
					if (attributes.score > rank4.score) then		  
						rank5.name = rank4.name
						rank5.score = rank4.score
						
						rank4.name = charname
						rank4.score = attributes.score
					else
					if (attributes.score > rank5.score) then		  
						rank5.name = charname
						rank5.score = attributes.score
						end
					end
				end
			end
		end
	end
	return rank1.name,rank2.name,rank3.name,rank4.name,rank5.name
end

function CheckIsPvPWinner(cha,cond)
	local name,c = GetChaDefaultName(cha),0
	if(file_exists(_PkP.logfile..name..".txt") == true)then
		c = 1 else c = 0
	end
	if c == cond then return LUA_TRUE elseif c ~= cond then return LUA_FALSE end
end
function CheckIsPvPWinner2(cha,cond)
	local name,c = GetChaDefaultName(cha),0
	if(file_exists(_PkP.logfile2..name..".txt") == true)then
		c = 1 else c = 0
	end
	if c == cond then return LUA_TRUE elseif c ~= cond then return LUA_FALSE end
end


function PvPWinnerReward(cha)
	local name = GetChaDefaultName(cha)
	local Item_CanGet = GetChaFreeBagGridNum ( cha )
	if Item_CanGet <= _PkP.rewardAmount then
		HelpInfo(cha ,0,"You need to have atleast ".._PkP.rewardAmount.." Empty slots in your bag to recieve the reward")
		return
	end
	for i,v in pairs(_PkP.rewards) do
		GiveItem(cha,0,_PkP.rewards[i].id,_PkP.rewards[i].amount,4)
	end
	os.remove(_PkP.logfile..name..".txt")
end
function PvPWinnerReward2(cha)
	local name = GetChaDefaultName(cha)
	local Item_CanGet = GetChaFreeBagGridNum ( cha )
	if Item_CanGet <= _PkP.rewardAmount2 then
		HelpInfo(cha ,0,"You need to have atleast ".._PkP.rewardAmount2.." Empty slots in your bag to recieve the reward")
		return
	end
	for i,v in pairs(_PkP.rewards2) do
		GiveItem(cha,0,_PkP.rewards2[i].id,_PkP.rewards2[i].amount,4)
	end
	os.remove(_PkP.logfile2..name..".txt")
end

function split(str, delim, maxNb)
		-- Eliminate bad cases...
		if string.find(str, delim) == nil then
			return { str }
		end
		if maxNb == nil or maxNb < 1 then
			maxNb = 0    -- No limit
		end
		local result = {}
		local pat = "(.-)" .. delim .. "()"
		local nb = 0
		local lastPos
		for part, pos in string.gfind(str, pat) do
			nb = nb + 1
			result[nb] = part
			lastPos = pos
			if nb == maxNb then break end
		end
		-- Handle the last field
		if nb ~= maxNb then
			result[nb + 1] = string.sub(str, lastPos)
		end
		return result
end
function turn_number(na)
local num = tostring(na)
local line,a = string.gsub(num,"%.",",")
	local position = string.find(line, "[ ,]*//")
	if (position ~= 1) then
		local data = split(line,",")
		local d1 = tonumber(data[1])
		local d2 = tonumber(data[2])
		if d2 == nil then
		return na
		end
		if(d2/100) < 0.5 then
			return d1
		elseif(d2/100) >= 0.5 then
			return (d1 + 1)
		end
	end
end
function PlayerPkPCheck(cha)
local key = "Logs"
local Table = table.load(_PkP.logfile..key..".txt","r")
local name = GetChaDefaultName(cha)
	if(Table["overall"][name] == nil)then
		SystemNotice(cha,"You are not listed in the ranking yet! You need to practicipate in more PvPs")
		return LUA_FALSE
	else
		local kills = Table["overall"][name].kill
		local death = Table["overall"][name].death
		local ratio = (tonumber(kills)/tonumber(death))
		if death == 0 then
		ratio = kills
		end
		HelpInfo(cha,0,"[[ "..name.." ]] Global Ranking_* Kills : "..kills.."_* Death : "..death.."_* Ratio : "..ratio.."")
	end
end

function PlayerPkPMazeCheck(cha,map)
local key = "Logs"
local Table = table.load(_PkP.logfile..key..".txt","r")
local name = GetChaDefaultName(cha)
	if(Table[map][name] == nil)then
		SystemNotice(cha,"You are not listed in this ranking yet! You need to practicipate in more PvPs inside ".._PkP.Recording[map].."!")
		return LUA_FALSE
	else
	local kills = Table[map][name].kill
	local death = Table[map][name].death
	HelpInfo(cha,0,"Your [[ ".._PkP.Recording[map].." ]]  Ranking_* Kills : "..kills.."_* Death : "..death.."")
	end
end

function GetRankingListing(cha,map)
local key = "Logs"
local Table = table.load(_PkP.logfile..key..".txt","r")
local scoring = {}
	for i,v in pairs(Table[map])do
		local kills = v.kill
		scoring[i] = { score = kills}
	end
	local r1,r2,r3,r4,r5 = CalculateRanking( scoring )
	local kills1,kills2,kills3,kills4,kills5 = 0,0,0,0,0
	local death1,death2,death3,death4,death5 = 0,0,0,0,0
	if r1 == nil then
		r1 = "None"
		kills1 = "0"
		death1 = "0"
		else
		r1 = r1
		kills1 = Table[map][r1].kill
		death1 = Table[map][r1].death
	end
	if r2 == nil then
		r2 = "None"
		kills2 = "0"
		death2 = "0"
		else
		r2 = r2
		kills2 = Table[map][r2].kill
		death2 = Table[map][r2].death
	end
	if r3 == nil then
		r3 = "None"
		kills3 = "0"
		death3 = "0"
		else
		r3 = r3
		kills3 = Table[map][r3].kill
		death3 = Table[map][r3].death
	end
	if r4 == nil then
		r4 = "None"
		kills4 = "0"
		death4 = "0"
		else
		r4 = r4
		kills4 = Table[map][r4].kill
		death4 = Table[map][r4].death
	end
	if r5 == nil then
		r5 = "None"
		kills5 = "0"
		death5 = "0"
		else
		r5 = r5
		kills5 = Table[map][r5].kill
		death5 = Table[map][r5].death
	end
	HelpInfo(cha,0,"[[".._PkP.Recording[map].."]] Ranking List_Rank 1 : "..r1.." ("..kills1.."/"..death1..") K/D_Rank 2 : "..r2.." ("..kills2.."/"..death2..") K/D_Rank 3 : "..r3.." ("..kills3.."/"..death3..") K/D_Rank 4 : "..r4.." ("..kills4.."/"..death4..") K/D_Rank 5 : "..r5.." ("..kills5.."/"..death5..") K/D")
end
