------------[RB]Beast Legion Smash - Skill_ShouWangS_End
function SkillSp_ShouWangS ( sklv )
	local sp_reduce = 125
	return sp_reduce
end
function SkillCooldown_ShouWangS( sklv )
	local Cooldown = 30000
	return Cooldown
end
function SkillArea_Circle_ShouWangS ( sklv )
	local side = 800
	SetSkillRange ( 4 , side  )
end
function Skill_ShouWangS_Begin ( role , sklv )
	local sp = Sp(role)
	local sp_reduce
	sp_reduce = SkillSp_ShouWangS ( sklv )
	if sp - sp_reduce < 0 then
		SkillUnable(role)
		return 
	end
	Sp_Red (role , sp_reduce )
end
function Skill_ShouWangS_End ( ATKER , DEFER , sklv )
	local dmg = math.random ( 350 , 650 )
	Hp_Endure_Dmg ( DEFER , dmg ) 
end
------------------------------------------------------------
------------Roar - Skill_Pax_End
function SkillArea_Circle_Pax ( sklv )										
	local side = 200 + 20 * sklv 
	SetSkillRange ( 4 , side )   
end 
function SkillCooldown_Pax( sklv )
	local Cooldown = 4000 - sklv * 200
	return Cooldown
end
function SkillPre_Pax ( sklv )									
end
function SkillSp_Pax ( sklv )										
	local sp_reduce = 20
	return sp_reduce 
end
function Skill_Pax_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Pax ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Pax_End ( ATKER , DEFER , sklv ) 
	local HateList = {}
	local Hate = {}
	local i = 0
	local HateMax = 0
	local Hate_dif = 0
	local Hate_fin = 0
	local statelv = sklv
	local statetime = 3
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
	local CfLv = GetSkillLv (ATKER,242)
	local PxLv = GetSkillLv (ATKER,243)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" then
			statelv = sklv + CfLv/10
		end
	if ValidCha ( ATKER ) == 0 then
			LG("Skill_PAX" , "Attacker as null")
			SkillUnable( ATKER )   
			return
	end
	if ValidCha ( DEFER ) == 0 then
			LG("Skill_PAX" , "Attacked target as nil")
			SkillUnable( ATKER )   
			return
	end
	if  IsPlayer( DEFER ) == 0 then
		for i = 1 , 5 , 1 do
			HateList[i] , Hate[i] = GetChaHateByNo ( DEFER , i-1 )
				
		end
		for i = 1 , 5 , 1 do
			if Hate[i] > HateMax then
				HateMax = Hate[i]
			end
		end
		for i = 1 , 5 , 1 do
			if HateList[i] == ATKER then
				Hate_dif = Hate[i]
			end
		end
		local mxhp = Mxhp ( DEFER )
		local hate = mxhp
		AddState( ATKER , DEFER , STATE_CHF, statelv , statetime )
		
		AddHate( DEFER , ATKER , hate )

		Check_Ys_Rem ( ATKER , DEFER)
	end
end
------------------------------------------------------------
------------Greatsword Mastery - Skill_Jjsl_Use
function Skill_Jjsl_Use( role , sklv ) 
	local statelv = sklv
	local defsb_dif = 5 * statelv 
	local defsb = DefSb(role) + defsb_dif  
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 
function Skill_Jjsl_Unuse( role , sklv ) 
	local statelv = sklv
	local defsb_dif = 5 * statelv 
	local defsb = DefSb(role) - defsb_dif  
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 
------------------------------------------------------------
------------Strengthen - Skill_Qhtz_Use
function Skill_Qhtz_Use( role , sklv )
	local statelv = sklv  
	local defsb_dif = 5 * statelv 
	local defsb = DefSb(role) + defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 
function Skill_Qhtz_Unuse( role , sklv ) 
	local statelv = sklv  
	local defsb_dif = 5 * statelv 
	local defsb = DefSb(role) - defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 
------------------------------------------------------------
------------Mighty Strike - Skill_Zj_End
function SkillSp_Zj ( sklv )
   local sp_reduce = 40 + sklv * 2  
	return sp_reduce 
end 
function SkillCooldown_Zj( sklv )
	local Cooldown = 3000
	return Cooldown
end
function Skill_Zj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Zj ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end
function Skill_Zj_End ( ATKER , DEFER , sklv ) 
	atk_rad = 1.2 + sklv * 0.2 
	hpdmg = atk_rad * SKILL_ATK_DMG ( ATKER , DEFER )	
	Hp_Endure_Dmg ( DEFER , hpdmg )  
	Check_Ys_Rem ( ATKER ,DEFER )
end
------------------------------------------------------------
------------Howl - Skill_Lh_End
function SkillArea_Circle_Lh ( sklv )
	local side = 200 + math.floor ( sklv * 55 )
	SetSkillRange ( 4 , side )   
end 
function SkillCooldown_Lh( sklv )
	local Cooldown = 5000
	return Cooldown
end
function SkillPre_Lh ( sklv )
end
function SkillSp_Lh ( sklv )
	local sp_reduce = 40 + math.floor ( sklv * 4 ) 
	return sp_reduce 
end 
function Skill_Lh_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Lh ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Lh_End ( ATKER , DEFER , sklv ) 
	local hp = Hp( DEFER )
	local STR = Str(ATKER)
	if ValidCha(ATKER) == 0 then 
		LG ( "luascript_err" , "function Skill_Lh_End : ATKER as null" ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		LG ( "luascript_err" , "function Skill_Lh_End : DEFER as null" ) 
		return 
	end 
	dmg = ((((STR-(10*sklv)) / 400)) * SKILL_ATK_DMG ( ATKER , DEFER ) )
	Hp_Endure_Dmg ( DEFER , dmg )  
	Check_Ys_Rem ( ATKER , DEFER)
end
------------------------------------------------------------
------------Blood Bull - Skill_Mnrx_Use
function Skill_Mnrx_Use( role , sklv ) 
	local statelv = sklv
	local hrecsa_dif = 0.02 * statelv
	local hrecsb_dif = 0.02 * statelv
	local hrecsa = math.floor ( (HrecSa(role) + hrecsa_dif )  * ATTR_RADIX)
	local hrecsb = math.floor ( ( HrecSb ( role ) + hrecsb_dif )  )
	SetCharaAttr( hrecsa , role , ATTR_STATEC_HREC )
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC )
	ALLExAttrSet(role)
end 
function Skill_Mnrx_Unuse( role , sklv ) 
	local statelv = sklv
	local hrecsa_dif = 0.02 * statelv
	local hrecsb_dif = 0.02 * statelv
	local hrecsa = math.floor ( (HrecSa(role) - hrecsa_dif )  * ATTR_RADIX)
	local hrecsb = math.floor ( ( HrecSb ( role ) - hrecsb_dif )  )
	SetCharaAttr( hrecsa , role , ATTR_STATEC_HREC )
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC )
	ALLExAttrSet(role)
end
------------------------------------------------------------
------------Primal Rage - Skill_Swzq_End
function SkillSp_Swzq ( sklv )
   local sp_reduce = 50+sklv*5
	return sp_reduce 
end 
function SkillCooldown_Swzq( sklv )
	local Cooldown = 40000
	return Cooldown
end
function Skill_Swzq_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Swzq ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end
function Skill_Swzq_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		LG ( "luascript_err" , "function Skill_Swzq_End : ATKER as null" ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		LG ( "luascript_err" , "function Skill_Swzq_End : DEFER as null" ) 
		return 
	end 
	local DEFER_MAXSP =MxspSb(DEFER)
	dmg = ((sklv * 0.05 ) * SKILL_ATK_DMG ( ATKER ,DEFER ) ) --+ DEFER_MAXSP
	Hp_Endure_Dmg ( DEFER , dmg )  
	local statelv = sklv 
	local statetime = 1 + math.floor ( sklv * 0.3 )
	local hp_defer = Hp ( DEFER )
	AddState ( ATKER , DEFER , STATE_XY , statelv , statetime )
end 
function State_Xy_Add ( role , statelv )
end
function State_Xy_Rem ( role , statelv )
end
------------------------------------------------------------