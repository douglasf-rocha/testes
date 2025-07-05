------------[RB]Super consciousness - Skill_XYSYF_End
function SkillSp_XYSYF ( sklv )										
	local sp_reduce = 160  
	return sp_reduce 
end
function SkillCooldown_XYSYF( sklv )
	local Cooldown = 30000
	return Cooldown
end
function SkillArea_Circle_XYSYF ( sklv )					
	local side = 800 
	SetSkillRange ( 4 , side  ) 	
end
function SkillArea_State_XYSYF ( sklv )										
	local statetime = 15 
	local statelv = sklv
	SetRangeState ( STATE_YNZL , statelv  , statetime ) 									
end 
function Skill_XYSYF_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce 
	sp_reduce = SkillSp_XYSYF ( sklv )	
	if sp - sp_reduce < 0 then 
		SkillUnable(role)
		return 
	end 
	Sp_Red (role , sp_reduce )
end
function Skill_XYSYF_End ( ATKER , DEFER , sklv )
end 
function State_XYSYF_Add ( role , statelv )
	local dmg =  150 + statelv * 30 
	Hp_Endure_Dmg ( role , dmg ) 
end 
function State_XYSYF_Rem ( role , statelv ) 

end 
function State_XYSYF_Tran ( statelv )
	return 3
end
------------------------------------------------------------
------------Conch Ray - Skill_Bkcj_End
function SkillArea_Line_Bkcj ( sklv )
	local lenth = 500 + sklv * 50  
	local width = 100 + sklv * 10 
	SetSkillRange ( 1 , lenth , width  )  
end
function SkillCooldown_Bkcj( sklv )
	local Cooldown = 3000
	return Cooldown
end
function SkillSp_Bkcj ( sklv )										
	local sp_reduce = 26+ sklv * 5
	return sp_reduce 
end
function SkillEnergy_Bkcj ( sklv )										
	local energy_reduce = math.floor ( 3 + sklv * 0.5 )    
	return energy_reduce 
end 
function Skill_Bkcj_Begin ( role , sklv ) 
	 if AddonSystem["Anti_bot"]	== 1	then
		 local AntiBotSystem = AntiBotSystemLine(role)
		 if AntiBotSystem == 0 then SkillUnable(role) return end
	 end
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Bkcj ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end
function Skill_Bkcj_End ( ATKER , DEFER , sklv ) 
	local atker_MXSP = GetChaAttr(ATKER,ATTR_MXSP)
	local atker_power = Str(ATKER)
	if IsPlayer(DEFER) == 1 then
		--if atker_MXSP > 1000 then 
		--	local dmg = math.floor ( 1 +  sklv * 0.13 + (1 + (1000 /500)) * SKILL_ATK_DMG(ATKER , DEFER)  ) + math.random(1,300)
		--	Hp_Endure_Dmg ( DEFER, dmg )
		--else
			local dmg = math.floor ( (((atker_power+(sklv*10)) / 300)) * SKILL_ATK_DMG(ATKER , DEFER)  ) + math.random(1,300)
			Hp_Endure_Dmg ( DEFER, dmg )
		--end
	else
		local dmg = math.floor ( 3 + sklv * 0.13 + (1 + (atker_power /150)) * SKILL_ATK_DMG(ATKER , DEFER)  ) + math.random(200,300)
		Hp_Endure_Dmg ( DEFER, dmg )
	end
end
------------------------------------------------------------
------------Tail Wind - Skill_Sf_End
function SkillArea_Circle_Sf ( sklv )
	local side = 1000  
	SetSkillRange ( 3 , side  )  
end
function SkillCooldown_Sf( sklv )
	local Cooldown = 10000
	return Cooldown
end
function SkillSp_Sf ( sklv )										
	local sp_reduce = 20+ sklv * 3   
	return sp_reduce 
end
function SkillEnergy_Sf ( sklv )										
	local energy_reduce = math.floor ( 3 + sklv * 0.5 )    
	return energy_reduce 
end 
function Skill_Sf_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Sf ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Sf_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 150 + sklv * 10 
	AddState ( ATKER , DEFER , STATE_SF , statelv , statetime ) 
end 
function State_Sf_Add ( role , statelv ) 
	local mspdsa_dif = 0.05 + statelv * 0.01    
	local mspdsa = ( MspdSa ( role ) + mspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 
function State_Sf_Rem ( role , statelv ) 
	local mspdsa_dif = 0.05 + statelv * 0.01    
	local mspdsa = ( MspdSa ( role ) - mspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role) 
end
------------------------------------------------------------
------------Whirlpool - Skill_Xw_End
function SkillArea_Circle_Xw ( sklv )
	local side = 300  
	SetSkillRange ( 3 , side  )  
end
function SkillCooldown_Xw( sklv )
	local Cooldown = 10000
	return Cooldown
end
function SkillSp_Xw ( sklv )										
	local sp_reduce = 20+ sklv * 1    
	return sp_reduce 
end
function SkillArea_State_Xw ( sklv )										
	local statetime = 20 + sklv * 1    
	local statelv = sklv 
	SetRangeState ( STATE_XW , statelv  , statetime )
end 
function Skill_Xw_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Xw ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Xw_End ( ATKER , DEFER , sklv ) 
end 
function State_Xw_Add ( role , statelv ) 
	local mspdsa_dif = 0.1 + statelv * 0.02 
	local aspdsa_dif = 0.05 + statelv * 0.01 
	local mspdsa = ( MspdSa ( cha_role ) - mspdsa_dif )  * ATTR_RADIX
	local aspdsa = ( AspdSa ( cha_role ) - aspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	ALLExAttrSet( role )  
end 
function State_Xw_Rem ( role , statelv ) 
	local mspdsa_dif = 0.1 + statelv * 0.02 
	local aspdsa_dif = 0.05 + statelv * 0.01 
	local mspdsa = ( MspdSa ( cha_role ) + mspdsa_dif )  * ATTR_RADIX
	local aspdsa = ( AspdSa ( cha_role ) + aspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	ALLExAttrSet( role )  
end 
function State_Xw_Tran ( statelv ) 
	return 1     
end
------------------------------------------------------------
------------Fog - Skill_Mw_End
function SkillArea_Circle_Mw ( sklv )
	local side = 300 + sklv * 50  
	SetSkillRange ( 3 , side  )  
end
function SkillCooldown_Mw( sklv )
	local Cooldown = 10000
	return Cooldown
end
function SkillSp_Mw ( sklv )										
	local sp_reduce = 20+ sklv * 1    
	return sp_reduce 
end
function SkillArea_State_Mw ( sklv )										
	local statetime = 20    
	local statelv = sklv 
	SetRangeState ( STATE_MW , statelv  , statetime )
end 
function SkillEnergy_Mw ( sklv )										
	local energy_reduce = math.floor ( 3 + sklv * 0.5 )    
	return energy_reduce 
end
function Skill_Mw_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Mw ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end
function Skill_Mw_End ( ATKER , DEFER , sklv ) 
end
function State_Mw_Add ( role , statelv ) 
	local mnatksa_dif = 0.05 + statelv * 0.01 
	local mxatksa_dif = 0.05 + statelv * 0.01 
	local mnatksa = ( MnatkSa ( role ) - mnatksa_dif )  * ATTR_RADIX 
	local mxatksa = ( MxatkSa ( role ) - mxatksa_dif )  * ATTR_RADIX 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet( role )  
end
function State_Mw_Rem ( role , statelv ) 
	local mnatksa_dif = 0.05 + statelv * 0.01 
	local mxatksa_dif = 0.05 + statelv * 0.01 
	local mnatksa = ( MnatkSa ( role ) + mnatksa_dif )  * ATTR_RADIX 
	local mxatksa = ( MxatkSa ( role ) + mxatksa_dif )  * ATTR_RADIX 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet( role )  
end
function State_Mw_Tran ( statelv ) 
	return 1     
end
------------------------------------------------------------
------------Lightning Curtain - Skill_Lm_End
function SkillArea_Circle_Lm ( sklv )
	local side = 300  
	SetSkillRange ( 3 , side  )  
end
function SkillCooldown_Lm( sklv )
	local Cooldown = 10000
	return Cooldown
end
function SkillSp_Lm ( sklv )										
	local sp_reduce = 20+ sklv * 1    
	return sp_reduce 
end
function SkillEnergy_Lm ( sklv )										
	local energy_reduce = math.floor ( 3 + sklv * 0.5 )    
	return energy_reduce 
end 
function SkillArea_State_Lm ( sklv )
	local statetime = 15 + sklv * 1
	local statelv = sklv
	SetRangeState ( STATE_LM , statelv  , statetime )
end 
function Skill_Lm_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Lm ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Lm_End ( ATKER , DEFER , sklv ) 
end 
function State_Lm_Add ( role , statelv ) 
	local dmg = 160 + statelv * 20 
	Hp_Endure_Dmg ( role , dmg ) 
end 
function State_Lm_Rem ( role , statelv ) 
end
function State_Lm_Tran ( statelv ) 
	return 1     
end
------------------------------------------------------------