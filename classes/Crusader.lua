------------[RB]Ethereal Slash - Skill_WuYin_End
 function SkillArea_Circle_WuYin( sklv )							
	local side = 800 
	SetSkillRange ( 4 , side  )  
end 
function SkillCooldown_WuYin( sklv )
	local Cooldown = 30000
	return Cooldown
end
function SkillSp_WuYin ( sklv )										
	local sp_reduce = 125  
	return sp_reduce 
end 
function Skill_WuYin_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_WuYin ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_WuYin_End ( ATKER , DEFER , sklv ) 

        local dmg = math.random ( 350 , 650 )
	Hp_Endure_Dmg ( DEFER , dmg ) 
end
------------------------------------------------------------
------------Dual Sword Mastery - Skill_Fsz_Use
function Skill_Fsz_Use( role , sklv ) 
	local statelv  = sklv
	local aspd_dif = 3 * statelv 
	local aspdsb = ( AspdSb(role) + aspd_dif ) 
	SetCharaAttr( aspdsb , role , ATTR_STATEV_ASPD ) 
	ALLExAttrSet(role)
end
function Skill_Fsz_Unuse( role , sklv ) 
	local statelv  = sklv
	local aspd_dif = 3 * statelv 
	local aspdsb = ( AspdSb(role) - aspd_dif ) 
	SetCharaAttr( aspdsb , role , ATTR_STATEV_ASPD ) 
	ALLExAttrSet(role)
end
------------------------------------------------------------
------------Deftness - Skill_Lqhb_Use
function Skill_Lqhb_Use( role , sklv )
	local statelv = sklv  
	local fleesb_dif = 3 * statelv 
	local fleesb = FleeSb(role) + fleesb_dif
	local def_dif = statelv * 3
	local def = DefSb(role) - def_dif
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE )
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 
function Skill_Lqhb_Unuse( role , sklv ) 
	local statelv = sklv  
	local fleesb_dif = 3 * statelv 
	local fleesb = FleeSb(role) - fleesb_dif  
	local def_dif = statelv * 3
	local def = DefSb(role)+ def_dif
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE )
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 
------------------------------------------------------------
------------Blood Frenzy - Skill_Pxkg_Use
function Skill_Pxkg_Use( role , sklv ) 
	local statelv = sklv
	local mxhpsb_dif = 130 * statelv 
	local mxhpsb = MxhpSb(role) + mxhpsb_dif
	local hrecsb_dif =  3 * statelv  
	local hrecsb = math.floor ( ( HrecSb ( role ) + hrecsb_dif )  )
	local mxatksb_dif = 15 * statelv
	local mnatksb_dif = 15 * statelv
	local mxatksb = ( MxatkSb(role) - mxatksb_dif ) 
	local mnatksb = ( MnatkSb(role) - mxatksb_dif ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK )
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 
	SetCharaAttr( mxhpsb , role , ATTR_STATEV_MXHP )
	ALLExAttrSet(role)
end
function Skill_Pxkg_Unuse( role , sklv ) 
	local statelv = sklv
	local mxhpsb_dif = 130 * statelv 
	local mxhpsb = MxhpSb(role) - mxhpsb_dif
	local hrecsb_dif =  3 * statelv  
	local hrecsb = math.floor ( ( HrecSb ( role ) - hrecsb_dif )  )
	local mxatksb_dif = 15 * statelv
	local mnatksb_dif = 15 * statelv
	local mxatksb = ( MxatkSb(role) + mxatksb_dif ) 
	local mnatksb = ( MnatkSb(role) + mxatksb_dif ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK )
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 
	SetCharaAttr( mxhpsb , role , ATTR_STATEV_MXHP )
	ALLExAttrSet(role)
end
------------------------------------------------------------
------------Poison Dart - Skill_Db_End
function SkillSp_Db ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end
function SkillCooldown_Db( sklv )
	local Cooldown = 20000
	return Cooldown
end
function Skill_Db_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Db ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Db_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =  15 + sklv * 2    
	AddState ( ATKER , DEFER , STATE_ZD , statelv , statetime ) 
	Check_Ys_Rem ( ATKER , DEFER )
end 
function State_Zd_Add ( role , statelv ) 
	local hpdmg = 20 + statelv * 3  
	local map_name_ATKER = GetChaMapName ( role )
	local agi_atker = Agi(role)

	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role)  
end 

function State_Zd_Rem ( role , statelv ) 
end 
------------------------------------------------------------
------------Shadow Slash - Skill_Guz_End
function SkillSp_Guz ( sklv )
	local sp_reduce = 50 + sklv * 5  
	return sp_reduce 
end 
function SkillCooldown_Guz( sklv )
	local Cooldown = 40000
	return Cooldown
end
function Skill_Guz_Begin ( role , sklv )
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Guz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 

end 
function Skill_Guz_End ( ATKER , DEFER , sklv )
	if ValidCha(ATKER) == 0 then 
		LG ( "luascript_err" , "function Skill_Guz_End : ATKER as null" ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		LG ( "luascript_err" , "function Skill_Guz_End : DEFER as null" ) 
		return 
	end
	local hpdmg = ( 1 +  sklv * 0.05 ) * SKILL_ATK_DMG  ( ATKER , DEFER )  
	local statelv = sklv 
	local statetime = 1 + math.floor ( sklv * 0.7 ) 
	if GetChaTypeID( ATKER ) == 979 then
			statetime = 8
	end
	if GetChaAIType( DEFER ) >= 21 then
		if BOSSXYSJ[GetChaTypeID( DEFER )] == 0 then
			SystemNotice ("As a Boss, how can I be defeated by ths same skill. Beware warriors!")
			return
		else
			BOSSXYSJ[GetChaTypeID( DEFER )] = BOSSXYSJ[GetChaTypeID( DEFER )] -1
		end
	end
		Hp_Endure_Dmg ( DEFER , hpdmg )
		AddState( ATKER , DEFER , STATE_XY, statelv , statetime )

	Check_Ys_Rem ( ATKER ,DEFER )
end
------------------------------------------------------------
------------Stealth - Skill_Ys_End
function SkillSp_Ys ( sklv )
	local sp_reduce = 10
	return sp_reduce
end
function SkillCooldown_Ys( sklv )
	local Cooldown = 30000
	return Cooldown
end
function Skill_Ys_Begin ( role , sklv )
	local sp = Sp(role)
	local sp_reduce = SkillSp_Ys ( sklv )
	if sp - sp_reduce < 0 then
		SkillUnable(role)
		return
	end
	Sp_Red (role , sp_reduce )
end
function Skill_Ys_End ( ATKER , DEFER , sklv )
	local statelv = sklv
	local statetime = 30 + sklv * 5
	local agi_atker = Agi(ATKER)
	AddState ( ATKER , DEFER , STATE_YS , statelv , statetime )
end
function State_Ys_Add ( role , statelv ) 
	local sp = Sp(role)
	local sp_reduce = 10 - math.floor ( statelv * 0.5  )
	local map_name_DEFER = GetChaMapName ( role )
	local agi_atker = Agi(role)
	sp = sp - sp_reduce
	if sp <= 0 then
		RemoveState ( role , STATE_YS )
		return
	end
	SetCharaAttr ( sp , role , ATTR_SP )
end 
function State_Ys_Rem ( role , statelv )

end
------------------------------------------------------------
