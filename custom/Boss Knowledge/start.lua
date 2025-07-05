BossFolder = '../lua/plugin/custom/Boss Knowledge/BossLogs/'
print( "*	Loading Boss Knowledge" )

Characterinfo_path = "resource\\characterinfo.txt" -- scanned characterinfo path

-- ----------------
-- Table Index's
-- ----------------

MonsterKnowledge = {}
RespawnBoss = {}
BossToRecord = {}
MonstersToRecord = {}

-- ----------------
-- Bosses IDS
-- ----------------
MonstersToRecord[1] = 805   ---- barbossa 
MonstersToRecord[2] = 789   ---- black dragon 
MonstersToRecord[3] = 1672 --- dream city boss 
MonstersToRecord[4] = 988 --- Rebirth boss 
MonstersToRecord[5] = 978 --- boss sea 
MonstersToRecord[6] = 675 --- pkmap boss  
MonstersToRecord[7] = 974 --- Abb Bosses
MonstersToRecord[8] = 975 --- Abb Bosses
MonstersToRecord[9] = 976 --- Abb Bosses
MonstersToRecord[10] = 977 --- Abb Bosses


 
-- --------------------
-- Bosses Respawn Time
-- --------------------

-- MonsterID / Time in seconds

RespawnBoss[805] = 43200
RespawnBoss[789] = 86400
RespawnBoss[1672] = 86400
RespawnBoss[988] = 43200
RespawnBoss[978] = 86400
RespawnBoss[675] = 10800
RespawnBoss[974] = 86400
RespawnBoss[975] = 86400
RespawnBoss[976] = 86400
RespawnBoss[977] = 86400

-- ----------------------------
-- Record tables for monsters
-- ----------------------------
for i,v in pairs (MonstersToRecord) do
	BossToRecord[v] = true
end
function file_exists(name)
	   local f=io.open(name,"r")
	   if f~=nil then io.close(f ) return true else return false end
end

-- ---------------------------
-- CUSTOM SPLIT FUNCTION
-- ---------------------------
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

-- ---------------------------
-- SCAN CHARACTERINFO
-- ---------------------------
function ScanMonsterKnowledge(file)
	  local fp = assert(io.open (file))
	  for line in fp:lines() do
		local position = string.find(line, "[ \t]*//")
		if (position ~= 1) then
			local data = split(line,"\t")
			local c1 = tonumber(data[1])
			if c1 ~= nil then
				MonsterKnowledge[c1] = {Name = {tostring(data[2])},Skills = {data[45]},Drops = {data[47]},Lv = data[61],MaxHP=data[62],MaxSP=data[64],MinAtk=data[66],MaxAtk=data[67],Pr=data[68],Def=data[69],Hr=data[70],Dodge=data[71],Exp=data[91] }
			end
		end
	end
end

-- ----------------------------
-- Run characterinfo.txt scan
-- ----------------------------
ScanMonsterKnowledge(Characterinfo_path)

-- ---------------------------
-- CHECK STATUS
-- ---------------------------
function CheckBossRespawn(id)
	if file_exists(GetResPath(BossFolder..""..id..".txt")) == false then
		table.save({LastKilled = 0 , RecordRespawn = 0 },GetResPath(BossFolder..""..id..".txt"),"a")
	end
	local Boss = table.load(GetResPath(BossFolder..""..id..".txt"),"r")
	if Boss.RecordRespawn ~= 0 then
		local RemainingTime = Boss.RecordRespawn - os.time()
		if RemainingTime <= 1 then
			Boss.LastKilled = 0
			Boss.RecordRespawn = 0
			table.save(Boss,GetResPath(BossFolder..""..id..".txt"),"w")
		end
		local notice = "Dead"
		local notice1 = "Remaining Respawn time: "..GetTime(RemainingTime).."!"
			return notice,notice1
	end
	if Boss.RecordRespawn == 0 then
		local noticey = "Alive"
		local noticex = "Boss: "..MonsterKnowledge[id].Name[1].." is still alive!"
			return noticey,noticex
	end
end

-- ---------------------------
-- CHECK LAST KILLER
-- ---------------------------

function LastKillBossName(id)
	if file_exists(GetResPath(BossFolder..""..id..".txt")) == false then
		table.save({LastKilled = 0 , RecordRespawn = 0 },GetResPath(BossFolder..""..id..".txt"),"a")
	end
	local Boss = table.load(GetResPath(BossFolder..""..id..".txt"),"r")
	if Boss.LastKilled == 0 then
		killer = "Nobody"
	else
		killer = Boss.LastKilled
	end
	return killer
end		

-- ----------------------------
-- NPC Function
-- ----------------------------

function bossknowl()
Talk(1,"Graves: Hello, I can show you some information about bosses! Pick a boss already and check the information about it.")
	for i,v in pairs(MonstersToRecord) do
		Text(1,""..MonsterKnowledge[v].Name[1].."",CheckMonsterSat,v)
	end
end

-- ---------------------------
-- LOADING STATS
-- ---------------------------
function CheckMonsterSat(cha,id)
local MonsterName = MonsterKnowledge[id].Name[1]
local Lv = MonsterKnowledge[id].Lv
local Hp = MonsterKnowledge[id].MaxHP
local Sp = MonsterKnowledge[id].MaxSP
local mAtk = MonsterKnowledge[id].MinAtk
local mxAtk = MonsterKnowledge[id].MaxAtk
local Pr = MonsterKnowledge[id].Pr
local Def = MonsterKnowledge[id].Def
local Hr = MonsterKnowledge[id].Hr
local Dodge = MonsterKnowledge[id].Dodge
local Exp = MonsterKnowledge[id].Exp
local Drops = MonsterKnowledge[id].Drops
local Stat,Notice = CheckBossRespawn(id)
local LastKill = LastKillBossName(id)

	HelpInfoX(cha,0,"Boss:  "..MonsterName.." Information_ Lv:"..Lv.."  Hp: "..Hp.."   Sp: "..Sp.."_ Min Attack: "..mAtk.."   Max Attack: "..mxAtk.."_ Physical Resistance: "..Pr.."   Defense: "..Def.."_ Hit Rate: "..Hr.."   Dodge: "..Dodge.."   Exp: "..Exp.."_ Status: "..Stat.."   Last Killer: "..LastKill.." _ "..Notice.."")-- _ Drops : "..Dropsx.."")
	
end

-- ---------------------------
-- GET TIME IN SECOND
-- ---------------------------

function GetTime(Seconds)
if tonumber(Seconds) == 0 then
	return "00:00:00";
else
	Hours = string.format("%02.f", math.floor(tonumber(Seconds)/3600));
	Mins = string.format("%02.f", math.floor(tonumber(Seconds)/60 - (Hours*60)));
	Secs = string.format("%02.f", math.floor(tonumber(Seconds) - Hours*3600 - Mins *60));
		return Hours..":"..Mins..":"..Secs
	end
end
-- ---------------------------
-- PLAYER KILL BOSS HOOK
-- ---------------------------
function RecordKilledBosses(z,dead,atk)
local GetKillerName = GetChaDefaultName(atk)
local GetBossName = GetChaDefaultName(dead)
local GetBossID = GetChaID(dead)
local DisplayCurrentTime = ""..os.date("%H")..":"..os.date("%M")..":"..os.date("%S")..""
	if BossToRecord[GetBossID] == true then
		local Boss = table.load(GetResPath(BossFolder..""..GetBossID..".txt"),"r")
		Boss.RecordRespawn = os.time() + RespawnBoss[GetBossID]
		Boss.LastKilled = GetKillerName
		table.save(Boss,GetResPath(BossFolder..""..GetBossID..".txt"),"w")
		Notice("Boss: "..GetBossName.." has been defeated by "..GetKillerName.." at time: "..DisplayCurrentTime.."!")
	end
end	
Hook:AddPostHook("GetExp_PKM",RecordKilledBosses)
