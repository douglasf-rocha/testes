------------[RB]Holy Judgement - Skill_SSSP_End
function SkillArea_Circle_SSSP( sklv )								
	local side = 1000 
	SetSkillRange ( 4 , side  )  
end 
function SkillCooldown_SSSP( sklv )
	local Cooldown = 30000
	return Cooldown
end
function SkillSp_SSSP ( sklv )										
	local sp_reduce = 120 + sklv * 20     
	return sp_reduce 
end 
function Skill_SSSP_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_SSSP ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_SSSP_End ( ATKER , DEFER , sklv )
	local dmg_1 = 500 + sklv*150
	local dmg_2 = -200 - sklv*150
	local reg1 = 0
	reg1 =IsChaInRegion( ATKER, 2 )
	if reg1 == 1 then
		dmg_1 = 0
	end
	local reg2 = 0
	reg2 =IsChaInRegion( DEFER, 2 )
	if reg2 == 1 then
		dmg_1 = 0
	end
	if is_friend(ATKER, DEFER) == 0 then
	   Hp_Endure_Dmg ( DEFER , dmg_1 ) 
	else
	   Hp_Endure_Dmg ( DEFER , dmg_2 )
	end 
end 
------------------------------------------------------------
------------Divine Grace - Skill_Sy_Use
--[[
		local bd=GetChaAttr(role, ATTR_BPDEF)
	local defsa_dif = (-1) * ( 0.03 * statelv ) 
	local defsa = math.floor (  (DefSa(role) + defsa_dif ) * ATTR_RADIX ) 
	local bd_dif = (-1) * ( 0.02 * statelv )
	local bd_fin = math.floor (  (ResistSa(role) + bd_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	SetCharaAttr( bd_fin , role , ATTR_STATEC_PDEF ) 
	ALLExAttrSet(role)
]]
function Skill_Sy_Use( role , sklv )
	local statelv = sklv
	local pdef_dif = 10 * statelv
	local pdef = ResistSb(role) + pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )
	ALLExAttrSet(role)
	RefreshCha(role)
end 
function Skill_Sy_Unuse( role , sklv ) 
	local statelv = sklv
	local pdef_dif = 10 * statelv
	local pdef = ResistSb(role) - pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )
	ALLExAttrSet(role)
	RefreshCha(role)
end 
------------------------------------------------------------
------------True Sight - Skill_Syzy_End
function Skill_Syzy_End ( ATKER , DEFER , sklv ) 
end 
function State_Syzy_Add ( role , statelv ) 
end 
function State_Syzy_Rem ( role , statelv ) 
end 
function State_Syzy_Tran ( statelv ) 
	return 1     
end 
------------------------------------------------------------
------------Tornado Swirl - Skill_Jsfb_End
function SkillSp_Jsfb ( sklv )										
	local sp_reduce = 20
	return sp_reduce 
end
function SkillCooldown_Jsfb( sklv )
	local Cooldown = 5000
	return Cooldown
end
function Skill_Jsfb_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Jxwb (sklv) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Jsfb_End ( ATKER , DEFER , sklv )  
	local Cha_Boat = 0
    Cha_Boat = GetCtrlBoat ( DEFER )
    if Cha_Boat ~=  nil then
		return 
	end 
	local statelv = sklv 
	local statetime = 150 + sklv * 3 
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
        AddState( ATKER , DEFER , STATE_JSFB, statelv , statetime ) 
end 
function State_Jsfb_Add ( role , statelv ) 
--	local crtsb_dif =5 + 1 * statelv
	local aspdsa_dif = 0.01 * statelv
--	local crtsb = math.floor ( (CrtSb(role) + crtsb_dif ) )
	local aspdsa = math.floor ( (AspdSa(role) + aspdsa_dif ) * ATTR_RADIX)
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
--	SetCharaAttr( crtsb , role , ATTR_STATEV_CRT ) 
	ALLExAttrSet(role)
end 
function State_Jsfb_Rem ( role , statelv ) 
--	local crtsb_dif =5 + 1 * statelv 
	local aspdsa_dif = 0.01 * statelv
--	local crtsb = math.floor ( (CrtSb(role) - crtsb_dif ) )
	local aspdsa = math.floor ( (AspdSa(role) - aspdsa_dif ) * ATTR_RADIX)
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
--	SetCharaAttr( crtsb , role , ATTR_STATEV_CRT ) 
	ALLExAttrSet(role)  
end 
------------------------------------------------------------
------------Energy Shield - Skill_Xlpz_End
function SkillSp_Xlpz ( sklv )										
	local sp_reduce = 0  
	return sp_reduce 
end
function SkillCooldown_Xlpz( sklv )
	local Cooldown = 1000
	return Cooldown
end
function Skill_Xlpz_Begin ( role , sklv ) 
	local sp = Sp( role ) 
	local sp_reduce = SkillSp_Xlpz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Xlpz_End ( ATKER , DEFER , sklv )  
	local statelv = sklv 
	local statetime = -1  
	if GetChaTypeID( ATKER ) == 984 then
		statelv = 10
	end
        AddState( ATKER , DEFER , STATE_MFD, statelv , statetime )
end 
------------------------------------------------------------
------------Spiritual Shield

function SkillSp_Sprshield ( sklv )										
	local sp_reduce = 10 + ( 10 * sklv )
	return sp_reduce 
end
function SkillCooldown_Sprshield( sklv )
	local Cooldown = 180000
	return Cooldown
end
function Skill_Sprshield_Begin ( role , sklv ) 
	local sp = Sp( role ) 
	local sp_reduce = SkillSp_Sprshield ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Sprshield_End ( ATKER , DEFER , sklv )  

	local maxsp = GetChaAttr(ATKER,MXSP)--MxspSb(ATKER)
	if maxsp < ((maxsp * 40) / 100) then
		SystemNotice(ATKER, "[Battle]:You successfully activated Spiritual Barrier, however your SP < 40%. Your barrier has vanished!")
	else
		local statelv = sklv 
		local statetime = 12 + ( 12 * sklv )
		SystemNotice(ATKER, "[Battle]:Spiritual Barrier Activated Successfully!")
		AddState( ATKER , DEFER , 202, statelv , statetime )
	end
end
function State_Sprshield_Add ( role , statelv )
--	SystemNotice(role,"debug spr shield")
	local maxsp0 = GetChaAttr(role,ATTR_MXSP)
--	print("maxsp0 "..maxsp0.."")
	local maxsp = maxsp0 - Sp( role )
--	print("maxsp "..defsb.."")
	local inc_dif = math.floor(maxsp / ( 13 - ( 0.6 * statelv ) ))
--	print("inc_dif "..inc_dif.."")
	local defsb = math.floor ( ( DefSb(role) + inc_dif ) ) 
--	print("defsb "..defsb.."")
	local resistsb = ResistSb(role) + inc_dif
--	print("resistsb "..resistsb.."")
	SetCharaAttr( resistsb , role , ATTR_STATEV_PDEF )
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
	RefreshCha(role)
end 
function State_Sprshield_Rem ( role , statelv ) 
	local maxsp0 = GetChaAttr(role,ATTR_MXSP)
	local maxsp = maxsp0 - Sp( role )
	local inc_dif = math.floor(maxsp / ( 13 - ( 0.6 * statelv ) ))
	local defsb = math.floor ( ( DefSb(role) - inc_dif ) ) 
	local resistsb = ResistSb(role) - inc_dif
	SetCharaAttr( resistsb , role , ATTR_STATEV_PDEF )
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role) 
	RefreshCha(role)
end 
------------------------------------------------------------
------------Angelic Shield - Skill_Tshd_End
function SkillSp_Tshd ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end
function SkillCooldown_Tshd( sklv )
	local Cooldown = 5000
	return Cooldown
end
function Skill_Tshd_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Tshd ( sklv )	
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Tshd_End ( ATKER , DEFER , sklv )  
	local Cha_Boat = 0
    Cha_Boat = GetCtrlBoat ( DEFER )
    if Cha_Boat ~=  nil then
		return 
	end
	local statelv = sklv 
	local statetime = 30 + sklv * 3  
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local sta_atker = Sta(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (ATKER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" then
			if Can_Pk_Garner2 == 0 then
			 statetime =math.max(30,math.floor(sta_atker/5))+sklv*3
			end
		end
	if GetChaTypeID( ATKER ) == 984 then
		statetime = 360
		statelv = 10
	end
        AddState( ATKER , DEFER , STATE_TSHD, statelv , statetime )
end 
function State_Tshd_Add ( role , statelv ) 
	local defsa_dif = 0.03 * statelv 
	local defsa = math.floor ( ( DefSa(role) + defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	ALLExAttrSet(role)  
end 
function State_Tshd_Rem ( role , statelv ) 
	local defsa_dif = 0.03 * statelv 
	local defsa = math.floor ( ( DefSa(role) - defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	ALLExAttrSet(role)  
end 
------------------------------------------------------------
------------Healing Spring - Skill_Hfwq_End
function SkillSp_Hfwq ( sklv )										
	local sp_reduce = sklv * 2 + 30  
	return sp_reduce 
end
function SkillCooldown_Hfwq( sklv )
	local Cooldown = 30000
	return Cooldown
end
function SkillArea_Square_Hfwq ( sklv )
	local side = 400 + sklv * 40 
	SetSkillRange ( 3 , side ) 	
end 
function SkillArea_State_Hfwq ( sklv )										
	local statetime = 15 + sklv * 2 
	local statelv = sklv 
	SetRangeState ( STATE_HFWQ , statelv  , statetime )
end 
function Skill_Hfwq_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce 
	sp_reduce = SkillSp_Hfwq ( sklv )	
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Hfwq_End ( ATKER , DEFER , sklv ) 
end 
function State_Hfwq_Add ( role , statelv ) 
	local Cha_Boat = 0
    Cha_Boat = GetCtrlBoat ( role )
    if Cha_Boat ~=  nil then
		return 
	end
	local dmg = -1 * ( 50 + statelv * 15 )
	Hp_Endure_Dmg ( role , dmg ) 
end 
function State_Hfwq_Rem ( role , statelv ) 
end 
function State_Hfwq_Tran ( statelv ) 
	return 3    
end 
------------------------------------------------------------