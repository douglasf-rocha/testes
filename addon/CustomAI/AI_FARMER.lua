-- --------------------------
-- AI DEDICATED TO "AI_FARMER"
-- --------------------------
-- AI_FARMER Mod is a sample of what can be done.
-- The base idea will be that the summoned pet is
-- not aggressive toward owner. Whenever it has nothing to
-- do, it will attempt to follow its master.
-- Othervise, it will try to attack the master s target.
----------------------------------------------


print( "        * Loading AI_FARMER functions" )

------------------------------
-- Load Variables 
------------------------------
dofile(GetResPath("script/addon/CustomAI/FARMER_VAR.lua"))
------------------------------
function CheckTargetType(role,target)
	local TargetID = GetChaID(target)
	if(Farmer.Type[(GetChaID(target))] == "Tree")then
	return "Tree"
	elseif(Farmer.Type[(GetChaID(target))] == "Rock Monster")then
	return "Ore"
	end
end

-- This is what happen when a pet has a target
function AI_FARMER_has_target(monster, target)
	local master = GetChaHost(monster)
	-- Won't harm player's , its here to farm only.
		if(IsPlayer(target) == 1)then
		clear_target(monster)
		else
		ChaUseSkill(monster, target, 201)
		ChaUseSkill(monster, target, 200)
		end
	local distance_to_master = get_distance(monster, master)
	if distance_to_master > 800 then
	local hx, hy = GetChaPos(master)
	local rx = 200 - Rand(400)
	local ry = 200 - Rand(400)
	flee(monster,target)
	clear_target(monster)
	ChaMove(monster, hx + rx, hy + ry)
	end
end
IsTree = {}
IsTree[1] = 107
-- This is what happen when a pet has no target
function AI_FARMER_no_target(monster)
	local target = GetChaSetByRange ( monster , 0 ,0 ,600 , 0)
	local ID = GetChaID(monster)
		if(CheckMonsterDead(target) == 0)then
			local Check = CheckTargetType(monster,target)
			if ID == 1291 and Check == "Tree" then
			ChaUseSkill(monster, target, 200)
			elseif ID == 1291 and Check == "Ore" then
			clear_target(monster)
			elseif ID == 1292 and Check == "Tree" then
			clear_target(monster)
			elseif ID == 1292 and Check == "Ore" then
			ChaUseSkill(monster, target, 201)
			end
		end
	local master = GetChaHost(monster)
	-- No target and no master, switch to aggressive mode
	if (master == nil) then
		SetChaAIType(monster, AI_ATK)
		return
	end
	-- Nothing todo Go to our Master
	local distance_to_master = get_distance(monster, master)
	local Type = {}
	Type[1292] = "mine"
	Type[1291] = "chop"
	local Type2 = {}
	Type2[1292] = "ore"
	Type2[1291] = "tree"
	if distance_to_master > 400 then
		local hx, hy = GetChaPos(master)
		local rx = 200 - Rand(400)
		local ry = 200 - Rand(400)
		ChaMove(monster, hx + rx, hy + ry)
		-- Lets make our Pet talk a bit
				local Rad = math.random(1,80)
				if Rad == 1 then
				Say(monster,"Lets get a "..Type2[GetChaID(monster)].." to "..Type[GetChaID(monster)].."!!")
				elseif Rad == 2 then
				Say(monster,"Master, i will "..Type[GetChaID(monster)].." every "..Type2[GetChaID(monster)].." in our way.")
				elseif Rad == 3 then
				Say(monster,"Master you fight monsters and i will "..Type[GetChaID(monster)].." "..Type2[GetChaID(monster)].."s!!!")
			end
		end
	end

-- This is what happen everytime
function AI_FARMER_tick(monster)
	local master = GetChaHost(monster)
	if Farmer.Power[master] == nil then
	Farmer.Power[master] = 1000
	end
	if Farmer.Saving[master] == nil then
	Farmer.Saving[master] = { ID = {} }
	end
	if Farmer.Stack[master] == nil then
	Farmer.Stack[master] = 10
	end
	if Farmer.Power[master] < 300 then
		if(math.random(1,50) == 20)then
			AddState(monster,monster,STATE_XY,5,3)
			Say(monster,"Ah, I feel dizzy. Im hungry!")
		end
	end
end

function Farmer_CollectForMaster(ignore,role,target,sklv)
	local Player = IsPlayer(role)
	local Master = GetChaHost(role)
	local targetID = GetChaID(target)
	if Master ~= nil and Player ~= 1 then
		Farmer.Power[Master] = Farmer.Power[Master] - 1
		if(Farmer.Saving[Master].ID[Farmer.Drop[targetID]] == nil)then
			Farmer.Saving[Master].ID[Farmer.Drop[targetID]] = {amount = 0}
		end
		local targetLV = GetChaAttr ( target , ATTR_LV ) 
		if sklv < targetLV then 
			Hp_Endure_Dmg(target,1)
		end 
	local Rnd = math.random(1,3)
	if Rnd == 1 then
		if(Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount >= 0)then
			Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount = Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount + 1
			SystemNotice(Master,"Pet Stack of "..GetItemName(Farmer.Drop[targetID]).." No."..Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount..".")
				if(Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount >= Farmer.Stack[Master])then
				Say(role,"Master Please have this stack of "..GetItemName(Farmer.Drop[targetID]).." !!!")
				GiveItem(Master,0,Farmer.Drop[targetID],Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount,4)
				Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount = 0
			end
		end
	end
	if Farmer.Power[Master] == 900 then
	SystemNotice(Master,"Your farmer stamina is "..Farmer.Power[Master].."")
	elseif Farmer.Power[Master] == 700 then
	SystemNotice(Master,"Your farmer stamina is "..Farmer.Power[Master].."")
	elseif Farmer.Power[Master] == 500 then
	SystemNotice(Master,"Your farmer stamina is "..Farmer.Power[Master].."")
	elseif Farmer.Power[Master] == 300 then
	SystemNotice(Master,"Your farmer stamina is "..Farmer.Power[Master]..", Feed him Please!")
	elseif Farmer.Power[Master] == 100 then
	SystemNotice(Master,"Your farmer stamina is "..Farmer.Power[Master]..", He will die soon if doesnt get feeden")
	elseif Farmer.Power[Master] == 10 then
	SystemNotice(Master,"Your farmer stamina is "..Farmer.Power[Master]..", Your farmer will die!")
	elseif Farmer.Power[Master] <= 0 then
	SetChaLifeTime(role,10)
	SystemNotice(Master,"Your farmer stamina reached Zero! He died!")
	Hp_Endure_Dmg(role,Mxhp(role))
		end
	end
end
Hook:AddPostHook("Skill_Ks_End", Farmer_CollectForMaster)
function Farmer_CollectForMasterORE(ignore,role,target,sklv)
	local Player = IsPlayer(role)
	local Master = GetChaHost(role)
	local targetID = GetChaID(target)
	if Master ~= nil and Player ~= 1 then
		Farmer.Power[Master] = Farmer.Power[Master] - 1
		if(Farmer.Saving[Master].ID[Farmer.Drop[targetID]] == nil)then
		Farmer.Saving[Master].ID[Farmer.Drop[targetID]] = {amount = 0}
		end
		local targetLV = GetChaAttr ( target , ATTR_LV ) 
		if sklv < targetLV then 
			Hp_Endure_Dmg(target,1)
		end 
	local Rnd = math.random(1,3)
	if Rnd == 1 then
		if(Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount >= 0)then
		Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount = Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount + 1
		SystemNotice(Master,"Pet Stack of "..GetItemName(Farmer.Drop[targetID]).." No."..Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount..".")
		if(Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount >= 10)then
		Say(role,"Master Please have this stack of "..GetItemName(Farmer.Drop[targetID]).." !!!")
		GiveItem(Master,0,Farmer.Drop[targetID],Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount,4)
		Farmer.Saving[Master].ID[Farmer.Drop[targetID]].amount = 0
		end
		end
	end
	if Farmer.Power[Master] == 900 then
	SystemNotice(Master,"Your farmer stamina is "..Farmer.Power[Master].."")
	elseif Farmer.Power[Master] == 700 then
	SystemNotice(Master,"Your farmer stamina is "..Farmer.Power[Master].."")
	elseif Farmer.Power[Master] == 500 then
	SystemNotice(Master,"Your farmer stamina is "..Farmer.Power[Master].."")
	elseif Farmer.Power[Master] == 300 then
	SystemNotice(Master,"Your farmer stamina is "..Farmer.Power[Master]..", Feed him Please!")
	elseif Farmer.Power[Master] == 100 then
	SystemNotice(Master,"Your farmer stamina is "..Farmer.Power[Master]..", He will die soon if doesnt get feeden")
	elseif Farmer.Power[Master] == 10 then
	SystemNotice(Master,"Your farmer stamina is "..Farmer.Power[Master]..", Your farmer will die!")
	elseif Farmer.Power[Master] <= 0 then
	SetChaLifeTime(role,10)
	SystemNotice(Master,"Your farmer stamina reached Zero! He died!")
	Hp_Endure_Dmg(role,Mxhp(role))
		end
	end
end
Hook:AddPostHook("Skill_Wk_End", Farmer_CollectForMasterORE)
