-----------Range Mastery - Skill_Gjsl_Use
function Skill_Gjsl_Use( role , sklv )
	local statelv = sklv
	local mxatksb_dif = 50 * statelv
	local mnatksb_dif = 50 * statelv
	local mxatksb = ( MxatkSb(role) + mxatksb_dif ) 
	local mnatksb = ( MnatkSb(role) + mxatksb_dif ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK )
	ALLExAttrSet(role)
end
function Skill_Gjsl_Unuse( role , sklv )
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
-----------Windwalk - Skill_Jfb_Use
function Skill_Jfb_Use( role , sklv )
	local statelv = sklv
	local mspdsb_dif = 5 * statelv
	local mspdsb = MspdSb(role) + mspdsb_dif
	SetCharaAttr( mspdsb , role , ATTR_STATEV_MSPD )
	ALLExAttrSet(role)
end 
function Skill_Jfb_Unuse( role , sklv ) 
	local statelv = sklv
	local mspdsb_dif = 5 * statelv
	local mspdsb = MspdSb(role) - mspdsb_dif
	SetCharaAttr( mspdsb , role , ATTR_STATEV_MSPD )
	ALLExAttrSet(role)
end 
------------------------------------------------------------
-----------Dual Shot - Skill_Lzj_End
function SkillSp_Lzj ( sklv )
	local sp_reduce = 30  
	return sp_reduce 
end 
function SkillCooldown_Lzj( sklv )
	local Cooldown = 5000
	return Cooldown
end
function Skill_Lzj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Lzj ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Lzj_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		LG ( "luascript_err" , "function Skill_Lzj_End : ATKER as null" ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		LG ( "luascript_err" , "function Skill_Lzj_End : DEFER as null" ) 
		return 
	end 
		hpdmg = ( sklv * 0.15 ) * SKILL_ATK_DMG ( ATKER , DEFER ) 
		Hp_Endure_Dmg ( DEFER , hpdmg )  
end
------------------------------------------------------------
-----------Rousing - Skill_Fnq_End
function SkillSp_Fnq ( sklv )
	local sp_reduce = 25 
	return sp_reduce 
end 
function SkillCooldown_Fnq( sklv )
	local Cooldown = 25000
	return Cooldown
end
function Skill_Fnq_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Fnq ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Fnq_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 20
	if GetChaTypeID( ATKER ) == 983 then
		statetime = 120
		statelv = 10
	end
	AddState( ATKER , DEFER , STATE_FNQ, statelv , statetime ) 
end 
function State_Fnq_Add ( role , statelv )  
	local aspd_dif = 8 * statelv 
	local aspdsb = ( AspdSb(role) + aspd_dif ) 
	SetCharaAttr( aspdsb , role , ATTR_STATEV_ASPD ) 
	ALLExAttrSet(role)  
end 
function State_Fnq_Rem ( role , statelv ) 
	local aspd_dif = 8 * statelv 
	local aspdsb = ( AspdSb(role) - aspd_dif ) 
	SetCharaAttr( aspdsb , role , ATTR_STATEV_ASPD ) 
	ALLExAttrSet(role)  
end
------------------------------------------------------------
-----------Frozen Arrow - Skill_Bdj_End
function SkillSp_Bdj ( sklv )
   local sp_reduce = 15   
	return sp_reduce 
end 
function SkillCooldown_Bdj( sklv )
	local Cooldown = 15000
	return Cooldown
end
function Skill_Bdj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Bdj ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Bdj_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		LG ( "luascript_err" , "function Skill_Bdj_End : ATKER as null" ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		LG ( "luascript_err" , "function Skill_Bdj_End : DEFER as null" ) 
		return 
	end 
	local hpdmg = (0.1 * sklv) * SKILL_ATK_DMG ( ATKER , DEFER ) 
	Hp_Endure_Dmg ( DEFER , hpdmg )  
	local statelv = sklv 
	local statetime = 5 
	if GetChaTypeID( ATKER ) == 983 then
		statelv = 10
	end
	AddState ( ATKER , DEFER , STATE_BDJ , statelv , statetime ) 
end 
function State_Bdj_Add ( role , statelv ) 
	local mspdsa_dif = 0.2 + statelv * 0.03
	local mspdsa = ( MspdSa(role) - mspdsa_dif ) * ATTR_RADIX  
	SetCharaAttr ( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 
function State_Bdj_Rem ( role , statelv ) 
	local mspdsa_dif = 0.2 + statelv * 0.03
	local mspdsa =( MspdSa(role) + mspdsa_dif ) * ATTR_RADIX  
	SetCharaAttr ( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 
------------------------------------------------------------
-----------Meteor Shower - Skill_Lxjy_End
function SkillArea_Square_Lxjy ( sklv )
	local side = 520 
	SetSkillRange ( 4 , side )  	
end 
function SkillPre_Lxjy ( sklv )
end 
function SkillCooldown_Lxjy( sklv )
	local Cooldown = 21000 - (sklv * 1100)
	return Cooldown
end
function SkillSp_Lxjy ( sklv )
	local sp_reduce = 37 + sklv * 3
	return sp_reduce 
end 
function Skill_Lxjy_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Lxjy ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Lxjy_End ( ATKER , DEFER , sklv ) 
	local hp = Hp( DEFER ) 
	if ValidCha(ATKER) == 0 then 
		LG ( "luascript_err" , "function Skill_Lxjy_End : ATKER as null" ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		LG ( "luascript_err" , "function Skill_Lxjy_End : DEFER as null" ) 
		return 
	end 
	local dmg = ( sklv * 0.07 ) * SKILL_ATK_DMG ( ATKER , DEFER )  
	Hp_Endure_Dmg ( DEFER , dmg )  
end 
------------------------------------------------------------
-----------Venom Arrow - Skill_Dj_End
function SkillSp_Dj ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end
function SkillCooldown_Dj( sklv )
	local Cooldown = 25000
	return Cooldown
end
function Skill_Dj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Dj ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Dj_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =  11 + sklv * 3
	AddState ( ATKER , DEFER , STATE_DJ , statelv , statetime ) 
	Check_Ys_Rem ( ATKER , DEFER )
end 
function State_Dj_Add ( role , statelv ) 
	local hpdmg = 10 + statelv * 6   
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role)  
end 
function State_Dj_Rem ( role , statelv ) 
end 
------------------------------------------------------------