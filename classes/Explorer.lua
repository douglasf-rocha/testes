------------Diligence - Skill_Jr_Use
function Skill_Jr_Use( role , sklv ) 
	local statelv = sklv  
	local fleesb_dif = 5 * statelv 
	local fleesb = FleeSb(role) + fleesb_dif  
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE ) 
	ALLExAttrSet(role)  
end
function Skill_Jr_Unuse( role , sklv ) 
	local statelv = sklv 
	local fleesb_dif = 5 * statelv 
	local fleesb = FleeSb(role) - fleesb_dif  
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE ) 
	ALLExAttrSet(role)  
end
------------------------------------------------------------
------------Lightning Bolt - Skill_Lj_End
function SkillSp_Lj ( sklv )										
	local sp_reduce = 20 + sklv * 3
	return sp_reduce 
end
function SkillCooldown_Lj( sklv )
	local Cooldown = 3000
	return Cooldown
end
function SkillEnergy_Lj ( sklv )										
	local energy_reduce = math.floor ( 3 + sklv * 0.5 )    
	return energy_reduce 
end
function Skill_Lj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Lj ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end
function Skill_Lj_End ( ATKER , DEFER , sklv ) 
	local statelv = 2  
	local statetime = 3 
	local atk_role = TurnToCha ( ATKER ) 
	local def_role = TurnToCha ( DEFER ) 
	local sta_atk= Sta ( ATKER ) 
	local power_atk= Str ( ATKER ) 
	local sta_def = Sta ( DEFER )
	local Lv = Lv( ATKER )
	local AddStateLv = 0
	AddStateLv = GetChaStateLv ( ATKER , STATE_MLCH )


	local atker_MXSP = GetChaAttr(ATKER,ATTR_MXSP)
	if IsPlayer(DEFER) == 1 then
		--if atker_MXSP > 1000 then 
		--	local dmg = math.floor ( 1 +  sklv * 0.11 + (1 * (1000 /540)) * SKILL_ATK_DMG(ATKER , DEFER)  ) + math.random(1,100)
		--	local dmg_fin = Cuihua_Mofa ( dmg , AddStateLv )
		--	local dmg_ElfSkill = ElfSkill_MagicAtk ( dmg , ATKER )
		--	AddState ( ATKER , DEFER , STATE_MB , statelv , statetime )
		--	Hp_Endure_Dmg ( DEFER, dmg )
		--else
			local dmg = math.floor (  ( (power_atk - (sklv*10) ) / 250)  * SKILL_ATK_DMG(ATKER , DEFER)  ) + math.random(1,100)
			local dmg_fin = Cuihua_Mofa ( dmg , AddStateLv )
			local dmg_ElfSkill = ElfSkill_MagicAtk ( dmg , ATKER )
			AddState ( ATKER , DEFER , STATE_MB , statelv , statetime )
			Hp_Endure_Dmg ( DEFER, dmg )
		--end
	else
		local dmg = math.floor ( 3 +  sklv * 0.15 + (1 + (power_atk / 150)) * SKILL_ATK_DMG(ATKER , DEFER)  ) + math.random(100,200)
		local dmg_fin = Cuihua_Mofa ( dmg , AddStateLv )
		local dmg_ElfSkill = ElfSkill_MagicAtk ( dmg , ATKER )
		AddState ( ATKER , DEFER , STATE_MB , statelv , statetime )
		Hp_Endure_Dmg ( DEFER, dmg )
	end
end 
------------------------------------------------------------
------------Current - Skill_Sl_Use
function Skill_Sl_Use( role , sklv ) 
	local statelv = sklv
	local aspd_dif = 20 * statelv 
	local aspdsb = ( AspdSb(role) + aspd_dif ) 
	local mspdsb_dif = 20 * statelv
	local mspdsb = MspdSb(role) + mspdsb_dif
	local mxhpsb_dif = 100 * statelv 
	local mxhpsb = MxhpSb(role) + mxhpsb_dif
	local mxspsb_dif = 100 * statelv 
	local mxspsb = MxspSb(role) + mxspsb_dif
	SetCharaAttr( mxhpsb , role , ATTR_STATEV_MXHP )
	SetCharaAttr( mxspsb , role , ATTR_STATEV_MXSP )
	SetCharaAttr( aspdsb , role , ATTR_STATEV_ASPD ) 
	SetCharaAttr( mspdsb , role , ATTR_STATEV_MSPD )
	ALLExAttrSet(role)
end
function Skill_Sl_Unuse( role , sklv )
	local statelv = sklv
	local aspd_dif = 20 * statelv 
	local aspdsb = ( AspdSb(role) - aspd_dif ) 
	local mspdsb_dif = 20 * statelv
	local mspdsb = MspdSb(role) - mspdsb_dif
	local mxhpsb_dif = 100 * statelv 
	local mxhpsb = MxhpSb(role) - mxhpsb_dif
	local mxspsb_dif = 100 * statelv 
	local mxspsb = MxspSb(role) - mxspsb_dif
	SetCharaAttr( mxhpsb , role , ATTR_STATEV_MXHP )
	SetCharaAttr( mxspsb , role , ATTR_STATEV_MXSP )
	SetCharaAttr( aspdsb , role , ATTR_STATEV_ASPD ) 
	SetCharaAttr( mspdsb , role , ATTR_STATEV_MSPD )
	ALLExAttrSet(role)
end
------------------------------------------------------------
------------Conch Armor - Skill_Bkzj_Use
function Skill_Bkzj_Use( role , sklv )
	local statelv = sklv  
	local resistsb_dif = 6 * statelv
	local resistsb = ResistSb(role) + resistsb_dif
	SetCharaAttr( resistsb , role , ATTR_STATEV_PDEF ) 
	ALLExAttrSet(role)  
end
function Skill_Bkzj_Unuse( role , sklv ) 
	local statelv = sklv  
	local resistsb_dif = 6 * statelv
	local resistsb = ResistSb(role) - resistsb_dif
	SetCharaAttr( resistsb , role , ATTR_STATEV_PDEF ) 
	ALLExAttrSet(role)  
end
------------------------------------------------------------
------------Tornado - Skill_Jf_End
function SkillSp_Jf ( sklv )										
	local sp_reduce = 25 + sklv * 2   
	return sp_reduce 
end 
function SkillCooldown_Jf( sklv )
	local Cooldown = 12000 + ( sklv * 300)
	return Cooldown
end
function SkillEnergy_Jf ( sklv )										
	local energy_reduce = math.floor ( 1 + sklv * 0.25 )    
	return energy_reduce 
end 
function Skill_Jf_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Jf ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Jf_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = math.floor ( 3 + sklv * 0.5 ) 
	local a = 1 
	local hp_defer = Hp ( DEFER ) 
	local MxHp_defer = Mxhp ( DEFER )
	if MxHp_defer >= 100000 then
		--SetSus( DEFER , 0 )
		return
	end
	if hp_defer >= 50000 then 
		a = Percentage_Random ( 0.2 ) 
		statetime = math.floor ( statetime / 2 ) + 1 
	end 
	if  a == 1 then
	if GetChaTypeID( ATKER ) == 986 then
		statetime = 12
		statelv = 10
	end
		AddState ( ATKER , DEFER , STATE_JF , statelv , statetime ) 
	else 
		--SetSus( DEFER , 0 ) 
	end 
end 
function State_Jf_Add ( role , statelv ) 
end 
function State_jf_Rem ( role , statelv ) 
end
------------------------------------------------------------
------------Algae Entanglement - Skill_Hzcr_End
function SkillSp_Hzcr ( sklv )										
	local sp_reduce = 20 + sklv * 1  
	return sp_reduce 
end
function SkillCooldown_Hzcr( sklv )
	local Cooldown = 12000
	return Cooldown
end
function Skill_Hzcr_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Hzcr ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Hzcr_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =math.floor ( 6 + sklv * 0.5 ) 
	local role1 = TurnToCha ( ATKER )
	local hp_defer = Mxhp ( DEFER ) 
	if hp_defer >= 1000000 then 
		local a = Percentage_Random (0.5)
		if a == 1 then
			statetime = math.floor ( 6 + sklv * 0.5 ) 
		else
			SetSus( DEFER , 0 )
			SystemNotice ( ATKER , "Alga Entanglement failed" ) 
			return
		end
	end 
	AddState ( ATKER , DEFER , STATE_HZCR , statelv , statetime ) 
end 
function State_Hzcr_Add ( role , statelv ) 
	local dmg = 200 + statelv * 25 
	Endure_Dmg ( role , dmg ) 
end 
function State_Hzcr_Rem ( role , statelv ) 
end
------------------------------------------------------------