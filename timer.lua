print('Loading timer.lua')

-- C++ no longer calls ai_loop
-- ai_timer is called instead.
-- ai_timer will call ai_loop
function ai_timer(c, freq, time)
	local resume_freq = 10 -- according to players, monster heals too fast (set to 10 instead 5) 
	local now_tick = GetChaParam(c, 1) 
	local is_role_living = -1

	SetChaParam(c, 1, now_tick + freq * time) 
	if math.mod(now_tick, resume_freq) == 0 and now_tick > 0 then 
		if is_role_living == -1 then
			is_role_living = IsChaLiving(c)
		end
		if is_role_living == 1 then
			local hp = GetChaAttr(c, ATTR_HP)
			local mxhp = GetChaAttr(c, ATTR_MXHP)
			if hp < mxhp then
				Resume(c)
			end
		end 
	end
	ai_loop(c)
end

function npc_timer(role)
end

function cha_timer(role, freq, time)
--	TimeOnlineCounter(role, freq, time)
	local resume_freq = 5 
	local now_tick = GetChaParam(role, 1)
	local is_role_living = -1
	SetChaParam(role, 1, now_tick + freq * time)
		if (IsPlayer(role) == 1) then
			CTF.Timer(role)	
		end
	if math.mod(now_tick, resume_freq) == 0 and now_tick > 0 then
		if is_role_living == -1 then
			is_role_living = IsChaLiving(role)
		end
		if is_role_living == 1 then
			Resume(role)
		end
	end
------------------Zizo's Mount Removal!--------------------------------
if(IsPlayer(role) == 1) then
	local i = GetChaItem(role, 1, 18)
	local c = GetItemID(i)
	if(c == 15969) then
	local Item_URE = GetItemAttr ( i , ITEMATTR_URE )
		if Item_URE > 10 then
		--SystemNotice(role," "..Item_URE.." is the Dura of BD Mount")
			if math.mod(now_tick, 60) == 0 and now_tick > 0 then
				local Take_Num = 17
				Item_URE = Item_URE - Take_Num
				SetItemAttr ( i , ITEMATTR_URE , Item_URE )
			end
			else
			RemoveChaItem ( role , 15969 , 1 , 1 , 18 , -1 , 0, 0)
			SystemNotice(role,"System removed your mount as 1 hour has passed!.")
		end
	end
	--[[for i = 0,47 do
		local item2 = GetChaItem(role,2,i)
		if item2 == target then
			RemoveChaItem ( role , GetItemID(target) , 1 , 2 , i , 2 , 1 , 0)
			break
		end
	end]]

end
-----------------------------------------------------------------------
	if math.mod(now_tick, 3600) == 0 and now_tick > 0 then
	local cha_lv = GetChaAttr( role , ATTR_LV )
		if cha_lv > 5 and cha_lv < 30 then
			GiveItem ( role , 0 , 15862 , 10 , 0 )
			GiveItem ( role , 0 , 15865 , 10 , 0 )
			SystemNotice( role, "[GIFT]: You've obtained a hourly potion gift!")
		end
	end
	if math.mod(now_tick, 1) == 0 and now_tick > 0 then
--		SystemNotice(role,"Extension TICKING WORKING")
		local statelv_sprshield = GetChaStateLv ( role , 202 )
		if statelv_sprshield > 0 then
--			SystemNotice(role,"SPR SHIELD EFFECT IS ON")
			local mnsp = GetChaAttr(role,ATTR_SP)
			local maxsp = GetChaAttr(role, ATTR_MXSP)
			local sp_reduce = 2
			Sp_Red (role , sp_reduce )
--			SystemNotice(role,"Deduct 2 SP for SPR SHIELD EFFECT")
			if mnsp < ((maxsp * 40) / 100) then
				RemoveState( role, 202 )
				SystemNotice( role, "[Battle]:Your SP have been depleted below 40 percent, Spiritual Barrier effect has been removed from you!.")
			end
--			print("Character (MNSP,MXSP) is: "..mnsp.." and "..maxsp.."")
		end
	end
	if(IsPlayer(role) == 1) then
		local armor = GetEquipItemP(role, 2)
		local gloves = GetEquipItemP(role, 3)
		local boots = GetEquipItemP(role, 4)
		local armorid = GetItemID(armor)
		local glovesid = GetItemID(gloves)
		local bootsid = GetItemID(boots)
		local statelv = 1
		local statetime = 3600
		if(armorid == 15940 and glovesid == 15939 and bootsid == 15941) then
			AddState ( role , role , 206 , statelv , statetime )
		else
			local statelv_lv10set = GetChaStateLv ( role , 206 )
			if statelv_lv10set~=0 then
				RemoveState ( role , 206 ) 
			end
		end
	end
	if(IsPlayer(role) == 1) then
		local i = GetChaItem(role, 1, 15)
		local c = GetItemID(i)
		local cha_type = GetChaTypeID(role)
		local statelv = 1
		local statetime = 3600
		if (c == 15902) then 
			if cha_type == 1 then
			AddState ( role , role , 224 , statelv, statetime )
			elseif cha_type == 2 then
				AddState ( role , role , 227 , statelv, statetime )
			elseif cha_type == 3 then
				AddState ( role , role , 230 , statelv, statetime )
			elseif cha_type == 4 then
				AddState ( role , role , 233 , statelv, statetime )
			end
		else
			if cha_type == 1 then
				local statelv_comcloak = GetChaStateLv ( role , 224 )
				if statelv_comcloak~=0 then
					RemoveState ( role , 224 ) 
				end
			elseif cha_type == 2 then
				local statelv_comcloak = GetChaStateLv ( role , 227 )
				if statelv_comcloak~=0 then
					RemoveState ( role , 227 ) 
				end
			elseif cha_type == 3 then
				local statelv_comcloak = GetChaStateLv ( role , 230 )
				if statelv_comcloak~=0 then
					RemoveState ( role , 230 ) 
				end
			elseif cha_type == 4 then
				local statelv_comcloak = GetChaStateLv ( role , 233 )
				if statelv_comcloak~=0 then
					RemoveState ( role , 233 ) 
				end
			end
		end
		if (c == 15903) then
			if cha_type == 1 then
				AddState ( role , role , 225 , statelv, statetime )
				elseif cha_type == 2 then
					AddState ( role , role , 228 , statelv, statetime )
				elseif cha_type == 3 then
					AddState ( role , role , 231 , statelv, statetime )
				elseif cha_type == 4 then
					AddState ( role , role , 234 , statelv, statetime )
				end
		else
			if cha_type == 1 then
				local statelv_refcloak = GetChaStateLv ( role , 225 )
				if statelv_refcloak~=0 then
					RemoveState ( role , 225 ) 
				end
			elseif cha_type == 2 then
				local statelv_refcloak = GetChaStateLv ( role , 228 )
				if statelv_refcloak~=0 then
					RemoveState ( role , 228 ) 
				end
			elseif cha_type == 3 then
				local statelv_refcloak = GetChaStateLv ( role , 231 )
				if statelv_refcloak~=0 then
					RemoveState ( role , 231 ) 
				end
			elseif cha_type == 4 then
				local statelv_refcloak = GetChaStateLv ( role , 234 )
				if statelv_refcloak~=0 then
					RemoveState ( role , 234 ) 
				end
			end
		end
		if (c == 15904) then
			if cha_type == 1 then
				AddState ( role , role , 226 , statelv, statetime )
				elseif cha_type == 2 then
					AddState ( role , role , 229 , statelv, statetime )
				elseif cha_type == 3 then
					AddState ( role , role , 232 , statelv, statetime )
				elseif cha_type == 4 then
					AddState ( role , role , 235 , statelv, statetime )
				end
		else
			if cha_type == 1 then
				local statelv_legcloak = GetChaStateLv ( role , 226 )
				if statelv_legcloak~=0 then
					RemoveState ( role , 226 ) 
				end
			elseif cha_type == 2 then
					local statelv_legcloak = GetChaStateLv ( role , 229 )
					if statelv_legcloak~=0 then
						RemoveState ( role , 229 ) 
					end
			elseif cha_type == 3 then
					local statelv_legcloak = GetChaStateLv ( role , 232 )
					if statelv_legcloak~=0 then
						RemoveState ( role , 232 ) 
					end
			elseif cha_type == 4 then
					local statelv_legcloak = GetChaStateLv ( role , 235 )
					if statelv_legcloak~=0 then
						RemoveState ( role , 235 ) 
					end
			end
		end
	end
end