------------Taunt - Skill_CHF_End
function SkillSp_CHF ( sklv )										
	local sp_reduce = 10  
	return sp_reduce 
end 
function SkillCooldown_CHF( sklv )
	local Cooldown = 5000
	return Cooldown
end
function Skill_CHF_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_CHF ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_CHF_End ( ATKER , DEFER , sklv )
	local statelv = sklv 
	local statetime = 10 + sklv  
	local mxhp = Mxhp ( DEFER )
	local hate = mxhp
	if ValidCha ( ATKER ) == 0 then
		LG("Skill_CHF" , "Attacker as null")
		SkillUnable( ATKER )   
		return
	end
	if ValidCha ( DEFER ) == 0 then
		LG("Skill_CHF" , "Attacked target as nil")
		SkillUnable( ATKER )   
		return
	end
	if IsPlayer( DEFER ) == 1 then
		LG("Skill_CHF" , "Victim as")
		SkillUnable( ATKER )   
		return
	end
	AddState( ATKER , DEFER , STATE_CHF, statelv , statetime )
	AddHate ( DEFER , ATKER , hate )
	Check_Ys_Rem ( ATKER , DEFER)
end 
function State_Chf_Add ( role , statelv )
		local map_name_DEFER = GetChaMapName ( role )
		local Can_Pk_Garner2 = Is_NormalMonster (role)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" then
		local sklv =math.floor(statelv)-1
		local CfLv = (statelv - sklv)*10
		--	if Can_Pk_Garner2 == 0 then
				if CfLv ~= 0 then
				--	local statelv = sklv
					local defsa_dif = 0.02 * CfLv 
					local defsa = math.floor ( (DefSa(role) - defsa_dif ) * ATTR_RADIX )
					SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
					ALLExAttrSet(role)
				end	
	--		end
		end
end
function State_Chf_Rem ( role , statelv )
	local HateList = {}
	local Hate = {}
	local i = 0
	local HateMax = 0
	local ATKER = role
	local mxhp = Mxhp ( role )
	local hate = mxhp * -1
		local map_name_DEFER = GetChaMapName ( role )
		local Can_Pk_Garner2 = Is_NormalMonster (role)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" then
		local sklv =math.floor(statelv)-1
		local CfLv = (statelv - sklv)*10
		-- Notice("CfLv ="..CfLv)
		--	if Can_Pk_Garner2 == 0 then
				if CfLv ~= 0 then
				--	local statelv = sklv  
					local defsa_dif = 0.02 * CfLv 
					local defsa = math.floor ( (DefSa(role) + defsa_dif ) * ATTR_RADIX )
					SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
					ALLExAttrSet(role)
				end	
	--		end
		end
	for i = 1 , 5 , 1 do
		HateList[i] , Hate[i] = GetChaHateByNo ( role , i-1 )
			
	end
	for i = 1 , 5 , 1 do
		if Hate[i] > HateMax then
			HateMax = Hate[i]
		end
	end
	for i = 1 , 5 , 1 do
		if Hate[i] == HateMax then
			ATKER = HateList[i]
		end
	end
	if ValidCha ( role ) == 0 then
		LG("Skill_CHF" , "Target as null")
		SkillUnable( role )   
		return
	end
	if ValidCha ( ATKER ) == 0 then
		LG("Skill_CHF" , "Target vengeance list as null")
--		SkillUnable( role )
		return
	end
	AddHate ( role  , ATKER , hate )
end
------------------------------------------------------------
------------Concentration - Skill_Jdzz_Use
function Skill_Jdzz_Use( role , sklv ) 
	local statelv = sklv  
	local hit_dif = 2
	local hitsb  = HitSb( role ) + hit_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT )
	ALLExAttrSet(role)
end 
function Skill_Jdzz_Unuse( role , sklv ) 
	local statelv = sklv  
	local hit_dif = 2
	local hitsb  = HitSb( role ) - hit_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT )
	ALLExAttrSet(role)
end
------------------------------------------------------------
------------Sword Mastery - Skill_Jssl_Use
function Skill_Jssl_Use( role , sklv ) 
	local statelv = sklv  
	local hitsb_dif = 2 * statelv 
	local hitsb = HitSb(role) + hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 
	ALLExAttrSet(role)  
end
function Skill_Jssl_Unuse( role , sklv ) 
	local statelv = sklv  
	local hitsb_dif = 2 * statelv 
	local hitsb = HitSb(role) - hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 
	ALLExAttrSet(role)  
end
------------------------------------------------------------
------------Will of Steel - Skill_Gtyz_End
function SkillSp_Gtyz ( sklv )
   local sp_reduce = 50 + (6*sklv)
	return sp_reduce 
end 
function SkillCooldown_Gtyz( sklv )
	local Cooldown = 61000
	return Cooldown
end
function Skill_Gtyz_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Gtyz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Gtyz_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =  60    
	AddState ( ATKER , DEFER , STATE_GTYZ , statelv , statetime )
	Check_Ys_Rem ( ATKER , DEFER )
end 
function State_Gtyz_Add ( role , statelv ) 
	local condef = GetChaAttr( role , ATTR_CON )
	local def_dif = statelv * 5 + condef
	local def = DefSb(role) + def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )	
	ALLExAttrSet(role)

end
function State_Gtyz_Rem ( role , statelv )
	local condef = GetChaAttr( role , ATTR_CON )
	local def_dif =  statelv * 5 + condef
	local def = DefSb(role) - def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end
------------------------------------------------------------
------------Illusion Slash - Skill_Hyz_End
function SkillSp_Hyz ( sklv )
   local sp_reduce = 34 
	return sp_reduce 
end 

function SkillCooldown_Hyz( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_Hyz_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Hyz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Hyz_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		LG ( "luascript_err" , "function Skill_Hyz_End : ATKER as null" ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		LG ( "luascript_err" , "function Skill_Hyz_End : DEFER as null" ) 
		return 
	end
	local dmg = 1
	local aspd = Aspd ( ATKER )
	if IsPlayer( DEFER ) == 1 then
		dmg = ( ( 0.1 * sklv ) ) * (math.min(2,( math.max ( 1, math.floor( aspd / 100  ) )  ))) * SKILL_ATK_DMG  ( ATKER , DEFER )
	elseif IsPlayer(DEFER) ~= 1 then
		dmg = ( ( 1.3 + 0.1 * sklv ) ) * (math.min(3,( math.max ( 1, math.floor( aspd / 83  ) )  ))) * SKILL_ATK_DMG  ( ATKER , DEFER )
	end
	Hp_Endure_Dmg ( DEFER , dmg )  

	Check_Ys_Rem ( ATKER , DEFER )
end
------------------------------------------------------------
------------Break Armor - Skill_Pj_End
function SkillSp_Pj ( sklv )
   local sp_reduce = 50+(sklv*6)  
	return sp_reduce 
end 
function SkillCooldown_Pj( sklv )
	local Cooldown = 25000
	return Cooldown
end
function Skill_Pj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Pj ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Pj_End ( ATKER , DEFER , sklv ) 
		local statelv = sklv 
		local statetime =  15    
		AddState ( ATKER , DEFER , STATE_PJ , statelv , statetime )
		Check_Ys_Rem ( ATKER , DEFER )
end
function State_Pj_Add ( role , statelv )
	local accdef = GetChaAttr( role, ATTR_DEX)
	local def_dif = statelv * 10 + ( accdef * 2)
	local def = DefSb(role) - def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )	
	ALLExAttrSet(role)

end
function State_Pj_Rem ( role , statelv )
	local accdef = GetChaAttr( role, ATTR_DEX)
	local def_dif = statelv * 10 + ( accdef * 2)
	local def = DefSb(role) + def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end
------------------------------------------------------------
------------Berserk - Skill_Kb_End
function SkillSp_Kb ( sklv )
	local sp_reduce = 15 
	return sp_reduce 
end 
function SkillCooldown_Kb( sklv )
	local Cooldown = 35000
	return Cooldown
end
function Skill_Kb_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Kb ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Kb_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 20  
	AddState( ATKER , DEFER , STATE_KB, statelv , statetime )
end 
function State_Kb_Add ( role , statelv )
	local aspdsa_dif = 0.2 + statelv * 0.015
	local aspdsa = ( AspdSa(role) + aspdsa_dif) * ATTR_RADIX
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	ALLExAttrSet(role)  
end 
function State_Kb_Rem ( role , statelv )
	local aspdsa_dif = 0.2 + statelv * 0.015
	local aspdsa = ( AspdSa(role) - aspdsa_dif) * ATTR_RADIX
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	ALLExAttrSet(role)  
end 
------------------------------------------------------------
------------Tiger Roar - Skill_Hx_End
function SkillArea_Circle_Hx ( sklv )
	local side = 200 
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_Hx( sklv )
	local Cooldown = 20000
	return Cooldown
end
function SkillSp_Hx ( sklv )
	local sp_reduce = 20 
	return sp_reduce 
end 
function Skill_Hx_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Hx ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
function Skill_Hx_End ( ATKER , DEFER , sklv ) 
	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 15
	AddState( ATKER , DEFER , STATE_HX, statelv , statetime ) 
end 
function State_Hx_Add ( role , statelv )
	local mxatksb_dif = 3 * statelv
	local mnatksb_dif = 3 * statelv
	local mspdsa_dif = 0.015 * statelv 
	local mxatksb = ( MxatkSb(role) - mxatksb_dif ) 
	local mnatksb = ( MnatkSb(role) - mxatksb_dif ) 
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK )
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)
end
function State_Hx_Rem ( role , statelv ) 
	local mxatksb_dif = 3 * statelv
	local mnatksb_dif = 3 * statelv
	local mspdsa_dif = 0.015 * statelv 
	local mxatksb = ( MxatkSb(role) + mxatksb_dif ) 
	local mnatksb = ( MnatkSb(role) + mxatksb_dif ) 
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK )
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)
end
------------------------------------------------------------