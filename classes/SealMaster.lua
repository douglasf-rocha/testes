-----------[RB]Devil Curse - Skill_EmoYuYan_End
function SkillSp_EmoYuYan ( sklv )										
	local sp_reduce = 155
	return sp_reduce
end 
function SkillArea_Circle_EmoYuYan ( sklv )
	local side = 550 + math.floor ( sklv * 50 ) 
	SetSkillRange ( 4 , side )  
end
function SkillCooldown_EmoYuYan( sklv )
	local Cooldown = 30000
	return Cooldown
end
function Skill_EmoYuYan_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_EmoYuYan ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_EmoYuYan_End ( ATKER , DEFER , sklv )
	local statetime = 25
	local statelv =  1
	local dmg = 150 
	Hp_Endure_Dmg ( DEFER , dmg )
	AddState ( ATKER , DEFER , STATE_EMYY , statelv , statetime )
end 
function State_EmoYuYan_Add ( role , statelv )
	local hpdmg = 20 + statelv * 15
	Hp_Endure_Dmg ( role , hpdmg )
	local statelv = 1
	local mspdsa_dif = (-1) * ( 0.28 + 0.02 * statelv ) -- reduce mspd by 30%
	local mspdsa = math.floor (  (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	local defsa_dif = (-1) * ( 0.048 + 0.02 * statelv ) -- Drops Defense %5
	local defsa = math.floor (  (DefSa(role) + defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF )  
	local mnatksa_dif = (-1) * ( 0.48 + 0.02 * statelv ) -- Drops Min Attack by 50%
	local mnatksa = math.floor ( (MnatkSa(role) + mnatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK )
	local mxatksa_dif = (-1) * ( 0.48 + 0.02 * statelv ) -- Drops Max Attack by 50%
	local mxatksa = math.floor ( (MxatkSa(role) + mxatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK )
	local aspdsa_dif = (-1) * ( 0.28 + 0.02 * statelv ) -- Drops Attack Speed by 30%
	local aspdsa = math.floor ( (AspdSa(role) + aspdsa_dif ) * ATTR_RADIX) 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
	ALLExAttrSet(role)  
end 
function State_EmoYuYan_Rem ( role , statelv )
	local statelv = 1
	local mspdsa_dif = (-1) * ( 0.28 + 0.02 * statelv ) -- Increases Movement Speed by 30%
	local mspdsa = math.floor (  (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	local defsa_dif = (-1) * ( 0.048 + 0.02 * statelv ) -- Increases Def by 5%
	local defsa = math.floor (  (DefSa(role) - defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	local mnatksa_dif = (-1) * ( 0.48 + 0.02 * statelv ) -- Increases Min Attack by 50%
	local mnatksa = math.floor ( (MnatkSa(role) - mnatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK )
	local mxatksa_dif = (-1) * ( 0.48 + 0.02 * statelv ) -- Increases Max Attack by 50%
	local mxatksa = math.floor ( (MxatkSa(role) - mxatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK )
	local aspdsa_dif = (-1) * ( 0.28 + 0.02 * statelv ) -- Increases Attack Speed by 30%
	local aspdsa = math.floor ( (AspdSa(role) - aspdsa_dif ) * ATTR_RADIX) 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
	ALLExAttrSet(role)  
end
function State_dev2_Add( role , statelv ) 
	local statelv = 1
	local mspdsa_dif = (-1) * ( 0.28 + 0.02 * statelv ) -- reduce mspd by 30%
	local mspdsa = math.floor (  (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	local defsa_dif = (-1) * ( 0.048 + 0.02 * statelv ) -- Drops Defense %5
	local defsa = math.floor (  (DefSa(role) + defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF )  
	local mnatksa_dif = (-1) * ( 0.48 + 0.02 * statelv ) -- Drops Min Attack by 50%
	local mnatksa = math.floor ( (MnatkSa(role) + mnatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK )
	local mxatksa_dif = (-1) * ( 0.48 + 0.02 * statelv ) -- Drops Max Attack by 50%
	local mxatksa = math.floor ( (MxatkSa(role) + mxatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK )
	local aspdsa_dif = (-1) * ( 0.28 + 0.02 * statelv ) -- Drops Attack Speed by 30%
	local aspdsa = math.floor ( (AspdSa(role) + aspdsa_dif ) * ATTR_RADIX) 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
	ALLExAttrSet(role)  
end
function State_dev2_Rem( role , statelv ) 
	local statelv = 1
	local mspdsa_dif = (-1) * ( 0.28 + 0.02 * statelv ) -- Increases Movement Speed by 30%
	local mspdsa = math.floor (  (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	local defsa_dif = (-1) * ( 0.048 + 0.02 * statelv ) -- Increases Def by 5%
	local defsa = math.floor (  (DefSa(role) - defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	local mnatksa_dif = (-1) * ( 0.48 + 0.02 * statelv ) -- Increases Min Attack by 50%
	local mnatksa = math.floor ( (MnatkSa(role) - mnatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK )
	local mxatksa_dif = (-1) * ( 0.48 + 0.02 * statelv ) -- Increases Max Attack by 50%
	local mxatksa = math.floor ( (MxatkSa(role) - mxatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK )
	local aspdsa_dif = (-1) * ( 0.28 + 0.02 * statelv ) -- Increases Attack Speed by 30%
	local aspdsa = math.floor ( (AspdSa(role) - aspdsa_dif ) * ATTR_RADIX) 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
	ALLExAttrSet(role)  
end
------------------------------------------------------------
-----------Cursed Fire - Skill_Zzzh_End
function SkillSp_Zzzh ( sklv )										
	local sp_reduce = 20   
	return sp_reduce 
end
function SkillCooldown_Zzzh( sklv )
	local Cooldown = 30000
	return Cooldown
end
function SkillArea_Square_Zzzh ( sklv )
	local side = 300 
	SetSkillRange ( 3 , side ) 	
end 
function SkillArea_State_Zzzh ( sklv )										
	local statetime = 5 + sklv  * 1  
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local sta_atker = Sta(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" then
			if Can_Pk_Garner2 == 0 then
			 statetime =math.max(5,math.floor(sta_atker/30))+sklv
			end
		end
	local statelv = sklv 
	SetRangeState ( STATE_ZZZH , statelv  , statetime )
end 
function Skill_Zzzh_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce 
	sp_reduce = SkillSp_Zzzh ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Zzzh_End ( ATKER , DEFER , sklv ) 
end 
function State_Zzzh_Add ( role , statelv ) 
	local defsa_dif = (-1) * ( 0.1 + 0.02 * statelv ) 
	local defsa = math.floor (  (DefSa(role) + defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	ALLExAttrSet(role)  
end 
function State_Zzzh_Rem ( role , statelv ) 
	local defsa_dif = (-1) * ( 0.1 + 0.02 * statelv ) 
	local defsa = math.floor (  (DefSa(role) - defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	ALLExAttrSet(role)  
end 
function  State_Zzzh_Tran ( statelv ) 
	local statetime = 20 + sklv * 2    
	return statetime 
end 
------------------------------------------------------------
-----------Abyss Mire - Skill_Synz_End
function SkillSp_Synz ( sklv )										
	local sp_reduce = sklv * 5 + 50  
	return sp_reduce 
end
function SkillCooldown_Synz( sklv )
	local Cooldown = 30000
	return Cooldown
end
function SkillArea_Square_Synz ( sklv )
	local side = 500 
	SetSkillRange ( 3 , side ) 	
end 
function SkillArea_State_Synz ( sklv )										
	local statetime = 18 + sklv * 2     
	local statelv = sklv 
	if GetChaTypeID( ATKER ) == 985 then
		statetime = 40
		statelv = 10
	end
	SetRangeState ( STATE_SYNZ , statelv  , statetime )
end 
function Skill_Synz_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce 
	sp_reduce = SkillSp_Synz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Synz_End ( ATKER , DEFER , sklv ) 
end 
function State_Synz_Add ( role , statelv ) 
	local mspdsa_dif = (-1) * ( 0.20 + 0.015 * statelv ) 
	local mspdsa = math.floor (  (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 
function State_Synz_Rem ( role , statelv ) 
	local mspdsa_dif = (-1) * ( 0.20 + 0.015 * statelv ) 
	local mspdsa = math.floor (  (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 
function  State_Synz_Tran ( statelv ) 
	local statetime = 3   
	return statetime 
end 
------------------------------------------------------------
-----------Shadow Insignia - Skill_Ayzz_End
function SkillSp_Ayzz ( sklv )
	local sp_reduce = 30 + sklv * 3  
	return sp_reduce 
end 
function SkillCooldown_Ayzz( sklv )
	local Cooldown = 30000
	return Cooldown
end
function Skill_Ayzz_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Ayzz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Ayzz_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 5 + sklv * 1
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local con_atker = Con(ATKER)

	local hp_defer = Mxhp ( DEFER )
	if hp_defer >= 100000 and hp_defer < 1000000 then 
		local a = Percentage_Random (0.7)
		if a == 1 then
			statetime = 9
		else
			--SetSus( DEFER , 0 )
			return
		end
	elseif hp_defer >= 1000000 then 
		local a = Percentage_Random (0.7)
		if a == 1 then
			statetime = 4
		else
			--SetSus( DEFER , 0 )
			return
		end
	end 
	if GetChaTypeID( ATKER ) == 985 then
		statetime = 15
		statelv = 10
	end
	if GetChaAIType( DEFER ) >= 21 then
		if BOSSAYSJ[GetChaTypeID( DEFER )] == 0 then
			SystemNotice ("As a Boss, how can I be defeated by ths same skill. Beware warriors!")
			return
		else
			BOSSAYSJ[GetChaTypeID( DEFER )] = BOSSAYSJ[GetChaTypeID( DEFER )] -1
		end
	end
	AddState( ATKER , DEFER , STATE_GJJZ, statelv , statetime ) 
end 
------------------------------------------------------------
-----------Seal of Elder - Skill_Xzfy_End
function SkillSp_Xzfy ( sklv )
	local sp_reduce = 30 + sklv * 2 
	return sp_reduce 
end 
function SkillCooldown_Xzfy( sklv )
	local Cooldown = 20000
	return Cooldown
end
function Skill_Xzfy_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Xzfy ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Xzfy_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 1 + math.floor ( sklv * 0.5  ) 
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local con_atker = Con(ATKER)
	local Check_Heilong  = CheckItem_Heilong ( ATKER )
	if Check_Heilong == 1 then
		local Percentage = Percentage_Random ( 0.7)
			if Percentage == 1 then
				  statetime =  statetime*1.5
				SystemNotice ( ATKER , "Obtain power from Black Dragon set. Skill effect enhanced")
			end
	end
	local hp_defer = Hp ( DEFER ) 
	if hp_defer >= 100000 then 
		local a = Percentage_Random (0.8)
		if a == 1 then
			statetime = 5 + math.floor ( sklv * 0.3 ) 
		else
			--SetSus( DEFER , 0 ) 
			SystemNotice ( ATKER , "Seal of Elder usage failed!!") 
			return
		end
	end 
	if GetChaTypeID( ATKER ) == 985 then
		statetime = 15
		statelv = 10
	end
	if GetChaAIType( DEFER ) >= 21 then
		if BOSSXZSJ[GetChaTypeID( DEFER )] == 0 then
			SystemNotice ("As a Boss, how can I be defeated by ths same skill. Beware warriors!")
			return
		else
			BOSSXZSJ[GetChaTypeID( DEFER )] = BOSSXZSJ[GetChaTypeID( DEFER )] -1
		end
	end
	AddState ( ATKER , DEFER ,STATE_JNJZ , statelv , statetime ) 
end 
------------------------------------------------------------