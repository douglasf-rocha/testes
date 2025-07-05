------------Heal - Skill_Xzy_End
function SkillSp_Xzy ( sklv )							
	local sp_reduce = 30 + sklv * 4    
	return sp_reduce 
end
function SkillCooldown_Xzy( sklv ) 
	local Cooldown = 7000 - sklv * 300 
	return Cooldown 
end
function Skill_Xzy_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Xzy ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Xzy_End ( ATKER , DEFER , sklv ) 
	local sta = Sta( ATKER ) 
	local exp = Exp( ATKER )
	local SK_ATK_DMG = (-1) * SKILL_ATK_DMG ( ATKER , DEFER )
	local hpdmg = ( -1 ) * math.floor ( 50 + 15 * sklv + (sta * 8)) + (SK_ATK_DMG * (1 + (0.2 * sklv) ))
	local mxhp_def = Mxhp( DEFER ) 
	local hp_def = Hp( DEFER ) 
	local hp_recover = math.max( math.min ( ( mxhp_def - hp_def ) , (-1) * hpdmg ) , 0 )
	local exp_add = hp_recover / 8 
	local Lv = Lv( ATKER )
		if Lv >= 80 then
			exp_add = exp_add / 50
		end
	local rolemode_defer = IsPlayer ( DEFER ) 
	local ChaList = {}
	local i = 0
	local Hate = 0
	local role = ATKER
	local HateNum = 3
	local HateAddNum = 0
	if rolemode_defer == 1 and DEFER ~= ATKER then 
		exp = exp + exp_add 
		SetCharaAttr ( exp , ATKER , ATTR_CEXP )  
	end 
	Hp_Endure_Dmg ( DEFER , hpdmg ) 
	ChaList[1] , ChaList[2] , ChaList[3] , ChaList[4] , ChaList[5] , ChaList[6] , ChaList[7] , ChaList[8] , ChaList[9] , ChaList[10] , ChaList[11] , ChaList[12] = GetChaSetByRange ( DEFER , 0 ,0 ,800 , 0)
	Hate = math.floor ( hpdmg / -2 )
	for i = 1 , 12 , 1 do
		if ChaList[i] ~= nil then
			role = GetChaTarget ( ChaList[i] )
			if role == DEFER then
				if HateAddNum < HateNum then
					AddHate ( ChaList[i] , ATKER , Hate )
					HateAddNum = HateAddNum + 1
				end

			end
		end
	end

end 
------------------------------------------------------------
------------Spiritual Bash - Skill_Xlcz_End
function SkillSp_Xlcz ( sklv )
	local sp_reduce = 30 + sklv * 3
	return sp_reduce 
end 
function SkillCooldown_Xlcz( sklv ) 
	local Cooldown = 3000
	return Cooldown
end
function Skill_Xlcz_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Xlcz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Xlcz_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		LG ( "luascript_err" , "function Skill_Xlcz_End : ATKER as null" ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		LG ( "luascript_err" , "function Skill_Xlcz_End : DEFER as null" ) 
		return 
	end 
	local atker_power = GetChaAttr(ATKER,ATTR_STR)
	if IsPlayer(DEFER) == 1 then
--[[		if atker_MXSP > 1000 then 
			local dmg = math.floor ( 1 +  sklv * 0.1 + (1 + (1000 /540)) * SKILL_ATK_DMG(ATKER , DEFER)  )  + math.random(1,100)
			Hp_Endure_Dmg ( DEFER, dmg )
		else]]--
			local dmg = math.floor ( 1 +  sklv * 0.1 + (1 + (atker_power /250)) * SKILL_ATK_DMG(ATKER , DEFER)  )  + math.random(1,100)
			Hp_Endure_Dmg ( DEFER, dmg )
		--end
	else
		local dmg = math.floor ( 3 +  sklv * 0.15+ (1 + (atker_power /100)) * SKILL_ATK_DMG(ATKER , DEFER)  ) + math.random(200,300)
		Hp_Endure_Dmg ( DEFER, dmg )
	end
end
------------------------------------------------------------
------------Vigor - Skill_Jsjc_Use
function Skill_Jsjc_Use( role , sklv )
	local statelv = sklv
	local srecsb_dif = 2 * statelv
	local srecsa_dif = 0.5 * statelv
	local srecsa = math.floor ( (SrecSa(role) + srecsa_dif ) * ATTR_RADIX )
	local srecsb = math.floor ( (SrecSb(role) + srecsb_dif )  )
--	local hrecsa_dif = 2 * statelv
--	local hrecsb_dif = 2 * statelv
--	local hrecsa = math.floor ( (HrecSa(role) + hrecsa_dif )  * ATTR_RADIX)
--	local hrecsb = math.floor ( ( HrecSb ( role ) + hrecsb_dif )  )
--	SetCharaAttr( hrecsa , role , ATTR_STATEC_HREC )
--	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC )
	SetCharaAttr( srecsa , role , ATTR_STATEC_SREC )
	SetCharaAttr ( srecsb , role , ATTR_STATEV_SREC )
	ALLExAttrSet(role)

end 
function Skill_Jsjc_Unuse( role , sklv ) 
	local statelv = sklv
	local srecsb_dif = 2 * statelv
	local srecsa_dif = 0.5 * statelv
	local srecsa = math.floor ( (SrecSa(role) - srecsa_dif ) * ATTR_RADIX )
	local srecsb = math.floor ( (SrecSb(role) - srecsb_dif )  )
	-- local hrecsa_dif = 2 * statelv
	-- local hrecsb_dif = 2 * statelv
	-- local hrecsa = math.floor ( (HrecSa(role) - hrecsa_dif )  * ATTR_RADIX)
	-- local hrecsb = math.floor ( ( HrecSb ( role ) - hrecsb_dif )  )
	-- SetCharaAttr( hrecsa , role , ATTR_STATEC_HREC )
	-- SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC )
	SetCharaAttr( srecsa , role , ATTR_STATEC_SREC )
	SetCharaAttr ( srecsb , role , ATTR_STATEV_SREC )
	ALLExAttrSet(role)
end 
------------------------------------------------------------
------------Harden - Skill_Shpf_End
function SkillSp_Shpf ( sklv )
   local sp_reduce = 40 + sklv * 4 
	return sp_reduce 
end 
function SkillCooldown_Shpf( sklv )
	local Cooldown = 3000
	return Cooldown
end
function Skill_Shpf_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Shpf ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Shpf_End ( ATKER , DEFER , sklv ) 
	local Cha_Boat = 0
    Cha_Boat = GetCtrlBoat ( DEFER )
    if Cha_Boat ~=  nil then
		return 
	end
	local statelv = sklv 
	local statetime =  180    
	AddState ( ATKER , DEFER , STATE_SHPF , statelv , statetime ) 
end 
function State_Shpf_Add ( role , statelv ) 
	local def_dif = 10 + statelv * 4  
	local def = DefSb(role) + def_dif 
	SetCharaAttr( def , role , ATTR_STATEV_DEF )	
	ALLExAttrSet(role)

end 
function State_Shpf_Rem ( role , statelv ) 
	local def_dif = 10 + statelv * 4 
	local def = DefSb(role) - def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 
------------------------------------------------------------
------------Spiritual Fire - Skill_Xlzh_End
function SkillSp_Xlzh ( sklv )										
	local sp_reduce = 30  + math.floor ( sklv * 2 )  
	return sp_reduce 
end
function SkillCooldown_Xlzh( sklv )
	local Cooldown = 3000
	return Cooldown
end
function Skill_Xlzh_Begin ( role , sklv ) 
	local sp = Sp( role ) 
	local sp_reduce = SkillSp_Xlzh ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Xlzh_End ( ATKER , DEFER , sklv )  
	local Cha_Boat = 0
    Cha_Boat = GetCtrlBoat ( DEFER )
    if Cha_Boat ~=  nil then
		return 
	end
	local statelv = sklv 
	local statetime = 180 + sklv * 20 
	AddState( ATKER , DEFER , STATE_XLZH, statelv , statetime ) 
end 
function State_Xlzh_Add ( role , statelv ) 
	local mnatksa_dif =( 0.1 + 0.01 * statelv) / 2
	local mxatksa_dif =( 0.1 + 0.01 * statelv) / 2
	local mnatksa = math.floor ( (MnatkSa(role) + mnatksa_dif ) * ATTR_RADIX) 
	local mxatksa = math.floor ( (MxatkSa(role) + mxatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet(role)  
end 
function State_Xlzh_Rem ( role , statelv ) 
	local mnatksa_dif =( 0.1 + 0.01 * statelv) / 2
	local mxatksa_dif =( 0.1 + 0.01 * statelv) / 2
	local mnatksa = math.floor ( (MnatkSa(role) - mnatksa_dif ) * ATTR_RADIX) 
	local mxatksa = math.floor ( (MxatkSa(role) - mxatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet(role)  
end 
------------------------------------------------------------
------------Recover - Skill_Dhfs_End
function SkillArea_Circle_Dhfs ( sklv )
	local side = 300 + math.floor ( sklv * 30 ) 
	SetSkillRange ( 4 , side )   
end 
function SkillCooldown_Dhfs( sklv )
	local Cooldown = 5000
	return Cooldown
end
function SkillPre_Dhfs ( sklv )
end 
function SkillSp_Dhfs ( sklv )
	local sp_reduce = 15 + math.floor ( sklv*0.5 ) 
	return sp_reduce 
end 
function Skill_Dhfs_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Dhfs (sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Dhfs_End ( ATKER , DEFER , sklv ) 
		dmg = ( -1 ) * ( 5 + sklv * 3  ) 
		Hp_Endure_Dmg ( DEFER , dmg )  
		Rem_State_Unnormal ( DEFER ) 
end 
------------------------------------------------------------
------------Tempest Boost - Skill_Fzlz_End
function SkillSp_Fzlz ( sklv )										
	local sp_reduce = 40  + sklv * 4
	return sp_reduce 
end
function SkillCooldown_Fzlz( sklv )
	local Cooldown = 3000
	return Cooldown
end
function Skill_Fzlz_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Fzlz(sklv)  
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Fzlz_End ( ATKER , DEFER , sklv )  
	local Cha_Boat = 0
    Cha_Boat = GetCtrlBoat ( DEFER )
    if Cha_Boat ~=  nil then
		return 
	end 
	local statelv = sklv 
	local statetime = 180 + sklv * 18 
	if GetChaTypeID( ATKER ) == 984 then
		statetime = 360
		statelv = 10
	end
	AddState( ATKER , DEFER , STATE_FZLZ, statelv , statetime )
end 
function State_Fzlz_Add ( role , statelv ) 
	local mspdsa_dif = 0.05 + 0.01 * statelv 
	local aspdsa_dif = 0.05 + 0.01 * statelv 
	local mspdsa = math.floor ( (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX) 
	local aspdsa = math.floor ( (AspdSa(role) + aspdsa_dif ) * ATTR_RADIX)
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)  
end 
function State_Fzlz_Rem ( role , statelv ) 
	local mspdsa_dif =0.05 + 0.01 * statelv 
	local aspdsa_dif = 0.05 + 0.01 * statelv 
	local mspdsa = math.floor ( (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX) 
	local aspdsa = math.floor ( (AspdSa(role) - aspdsa_dif ) * ATTR_RADIX)
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)  
end 
------------------------------------------------------------
------------Revival - Skill_Fh_End
function SkillSp_Fh ( sklv )
   local sp_reduce = 50   
	return sp_reduce 
end 
function SkillCooldown_Fh( sklv )
	local Cooldown = 60000 - sklv * 1500
	return Cooldown
end
function Skill_Fh_Begin ( role , sklv ) 
	local map_name_ATKER = GetChaMapName ( role )
	if map_name_ATKER == "garner2" or map_name_ATKER == "bountypk" then
			SystemNotice ( role , "Unable to use Revival skills here." )
	SkillUnable(role)   
		end
--[[	local item_count = CheckBagItem ( role , ITEM_RELIFE ) 
	if item_count <= 0 then  
		SkillUnable(role)   
		SystemNotice ( role , "Does not possess required item to use skill" ) 
	end 
	local a = DelBagItem ( role , ITEM_RELIFE , 1 ) ]]
end 
function Skill_Fh_End ( ATKER , DEFER , sklv ) 
	local ChaName = GetChaDefaultName ( ATKER )
	SetRelive ( ATKER , DEFER ,  sklv , "Player"..ChaName.."\n\n wish to revive you. Accept?" ) 
end 
------------------------------------------------------------