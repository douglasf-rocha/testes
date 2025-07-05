-----------[RB]Red Thunder Cannon - Skill_ArfGX_End
function SkillArea_Line_ArfGX ( sklv )										
	local lenth = 900 + sklv * 30  
	local width = 250 + sklv * 10 
	SetSkillRange ( 1 , lenth , width  )  
end
function SkillCooldown_ArfGX( sklv )
	local Cooldown = 30000
	return Cooldown
end
function SkillSp_ArfGX ( sklv )										
	local sp_reduce = 105   
	return sp_reduce 
end
function Skill_ArfGX_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_ArfGX ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_ArfGX_End ( ATKER , DEFER , sklv )
        local dmg = math.random ( 350 , 650 ) 
        Hp_Endure_Dmg ( DEFER , dmg ) 
end 
------------------------------------------------------------
-----------Firegun Mastery - Skill_Hqsl_Use
function Skill_Hqsl_Use( role , sklv ) 
	local statelv = sklv
	local mxatksb_dif = 50 * statelv
	local mnatksb_dif = 50 * statelv
	local mxatksb = ( MxatkSb(role) + mxatksb_dif ) 
	local mnatksb = ( MnatkSb(role) + mxatksb_dif ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK )
	ALLExAttrSet(role)
end
function Skill_Hqsl_Unuse( role , sklv ) 
	local statelv = sklv
	local mxatksb_dif = 50 * statelv
	local mnatksb_dif = 50 * statelv
	local mxatksb = ( MxatkSb(role) - mxatksb_dif ) 
	local mnatksb = ( MnatkSb(role) - mxatksb_dif ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK )
	ALLExAttrSet(role)
end 
------------------------------------------------------------
-----------Magma Bullet - Skill_Rsd_End
function SkillPre_Rsd ( sklv )
end 
function SkillArea_Square_Rsd ( sklv )
	local side = 250 
	SetSkillRange ( 4 , side )   
end 
function SkillCooldown_Rsd( sklv )
	local Cooldown = 15000
	return Cooldown
end
function SkillArea_State_Rsd ( sklv )										
	local statetime = 10 
	local statelv = sklv 
	SetRangeState ( STATE_RS , statelv  , statetime )
end 
function SkillSp_Rsd ( sklv )
	local sp_reduce = sklv * 2 + 15   
	return sp_reduce 
end 
function Skill_Rsd_Begin ( role , sklv )
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Rsd ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red ( role , sp_reduce ) 
end 
function Skill_Rsd_End ( ATKER , DEFER , sklv ) 
end 
function State_Rs_Add ( role , statelv ) 
	local arealv = GetAreaStateLevel ( role , STATE_RS ) 
	local hp = GetChaAttr( role , ATTR_HP ) 
	local hpdmg = 10 
	if arealv >= 1 then 
		hpdmg = arealv * 3 + 30  
	end 
	Hp_Endure_Dmg ( role , hpdmg ) 
end 
function State_Rs_Rem ( role , statelv ) 
end 
------------------------------------------------------------
-----------Cripple - Skill_Tj_End
function SkillSp_Tj ( sklv )										
	local sp_reduce = 45 + sklv * 3
	return sp_reduce
end
function SkillCooldown_Tj( sklv )
	local Cooldown = 8000 - sklv * 200  
	return Cooldown 
end 
function Skill_Tj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Tj ( sklv )
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Tj_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = math.floor( (5 + sklv * 0.5) / 2) 
 	dmg = ( 0.3 + sklv * 0.05 ) * SKILL_ATK_DMG ( ATKER , DEFER )  
	Hp_Endure_Dmg ( DEFER , dmg )  
	if GetChaTypeID( ATKER ) == 980 then
		statetime = 2.5
	end
	if GetChaAIType( DEFER ) >= 21 then
		if BOSSTJSJ[GetChaTypeID( DEFER )] == 0 then
			SystemNotice ("As a Boss, how can I be defeated by ths same skill. Beware warriors!")
			return
		else
			BOSSTJSJ[GetChaTypeID( DEFER )] = BOSSTJSJ[GetChaTypeID( DEFER )] -1
		end
	end
	AddState( ATKER , DEFER , STATE_TJ, statelv , statetime ) 
end 
function State_Tj_Add ( role , statelv ) 
	local fleesa_dif = (-1) * 0.2 
	local mspdsa_dif = (-1) * ( 0.5 + 0.025 * statelv )
	local fleesa = (FleeSa(role) + fleesa_dif ) * ATTR_RADIX
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( fleesa , role , ATTR_STATEC_FLEE ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 
function State_Tj_Rem ( role , statelv ) 
	local fleesa_dif = (-1) * 0.2 
	local mspdsa_dif = (-1) * ( 0.5 + 0.025 * statelv ) 
	local fleesa = (FleeSa(role) - fleesa_dif ) * ATTR_RADIX
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( fleesa , role , ATTR_STATEC_FLEE ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end
------------------------------------------------------------
-----------Enfeeble - Skill_Sj_End
function SkillSp_Sj ( sklv )										
	local sp_reduce = (25 + sklv * 1) * 3
	return sp_reduce 
end
function SkillCooldown_Sj( sklv )
	local Cooldown = 15000
	return Cooldown
end
function Skill_Sj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Sj ( sklv )
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Sj_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = ( 5 + math.floor ( sklv * 0.5  ) ) / 2
	local a = 1 
	local dmg = math.floor( (  sklv * 0.07 ) * SKILL_ATK_DMG ( ATKER , DEFER ) ) + 100
	Hp_Endure_Dmg ( DEFER , dmg )  
	if GetChaTypeID( ATKER ) == 980 then
		statetime = 5
	end
	if GetChaAIType( DEFER ) >= 21 then
		if BOSSSJSJ[GetChaTypeID( DEFER )] == 0 then
			SystemNotice ("As a Boss, how can I be defeated by ths same skill. Beware warriors!")
			return
		else
			BOSSSJSJ[GetChaTypeID( DEFER )] = BOSSSJSJ[GetChaTypeID( DEFER )] -1
		end
	end
	AddState( ATKER , DEFER , STATE_SJ, statelv , statetime ) 
	AddState( ATKER , DEFER , STATE_JNJZ, statelv , statetime ) 
end 

function State_Sj_Add ( role , statelv ) 
	local mnatksa_dif = (-1) * 0.2 
	local mxatksa_dif = (-1) * 0.2  
	local mnatksa = (MnatkSa(role) + mnatksa_dif ) * ATTR_RADIX
	local mxatksa = (MxatkSa(role) + mxatksa_dif ) * ATTR_RADIX 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet(role)  
end 
function State_Sj_Rem ( role , statelv ) 
	local mnatksa_dif = (-1) * 0.2 
	local mxatksa_dif = (-1) * 0.2  
	local mnatksa = (MnatkSa(role) - mnatksa_dif ) * ATTR_RADIX 
	local mxatksa = (MxatkSa(role) - mxatksa_dif ) * ATTR_RADIX 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet(role)  
end
------------------------------------------------------------
-----------Headshot - Skill_Bt_End
function SkillSp_Bt ( sklv )
	local sp_reduce = 100 + 10 * sklv
	return sp_reduce 
end 
function SkillCooldown_Bt( sklv )
	local Cooldown = 50000
	return Cooldown
end
function Skill_Bt_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Bt ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Bt_End ( ATKER , DEFER , sklv )
	local statelv = sklv
	local statetime = 1
	local hp = GetChaAttr ( DEFER , ATTR_HP )
	local dmg = math.floor( sklv / 10 * SKILL_ATK_DMG(ATKER,DEFER)  )
	Hp_Endure_Dmg ( DEFER , dmg )
	AddState( ATKER , DEFER , STATE_XY, statelv , statetime )
	-- if dmg > 2500 then
		-- dmg = 2500
	-- end
	-- hp = hp - dmg
	-- SetCharaAttr ( hp , DEFER , ATTR_HP ) 
end
------------------------------------------------------------