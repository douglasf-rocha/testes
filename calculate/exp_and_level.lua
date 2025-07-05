print( "Loading Exp_And_Level.lua" )
--�˴����þ���ֵ�ͼ����йصļ���

InTeamGetExp_RAID = 1

--�����������Ʒ���
function AskGuildItem(role,Guild_type)
	local gold = GetChaAttr(role,ATTR_GD)
	local fame = GetChaAttr(role,ATTR_FAME) 
	local attr_guild = HasGuild ( role ) 
	if attr_guild ~= 0 then 
		HelpInfo(role,0,"Already in a guild")
		--SystemNotice(role,0,"������������")
		return 0 
	end 
	local Lv = Lv ( role )
	if Lv < 40 then
		SystemNotice ( role , "Have not reached Lv 40. Unable to create" )
		return 0
	end

	if Guild_type == 1 then						--�ж���������
		if Guild2_ItemMax > 0 then
			for i = 1 , Guild2_ItemMax , 1 do
				local K = Check_BagItem(role,Guild2_item[i],Guild2_count[i])
				if K == 0 then
					HelpInfo(role,0,"Items insufficient. Unable to create")
					--SystemNotice(role,0,"���߲����޷�����")
					return 0
				end
			end
		end

		if gold < Guild2_Gold then
			HelpInfo(role,0,"Insufficient gold. Unable to create")
			--SystemNotice(role,0,"��Ǯ�����޷�����")
			return 0
		end
		if fame < Guild2_fame then
			HelpInfo(role,0,"Insufficient reputation to create")
			--SystemNotice(role,0,"���������޷�����")
			return 0
		end
	elseif Guild_type == 0 then					--�ж���������
		if Guild1_ItemMax > 0 then
			for i = 1 , Guild1_ItemMax , 1 do
				local K = Check_BagItem(role,Guild1_item[i],Guild1_count[i])
				if K == 0 then
					HelpInfo(role,0,"Items insufficient. Unable to create")
					--SystemNotice(role,0,"���߲����޷�����")
					return 0
				end
			end
		end
		if gold < Guild1_Gold then
			HelpInfo(role,0,"Insufficient gold. Unable to create")
			--SystemNotice(role,0,"��Ǯ�����޷�����")
			return 0
		end
		if fame < Guild1_fame then
			HelpInfo(role,0,"Insufficient reputation to create")
			--SystemNotice(role,0,"���������޷�����")
			return 0
		end
	else
		--LG("checkguild","�������ʹ���  Guild_type = ",Guild_type)
	end
	return 1
end 

function Check_BagItem(role,a,b)		--��鱳�������Ƿ��㹻
	local a = CheckBagItem ( role , a ) 
	if a>= b then 
		return 1 
	else 
		return 0 
	end 
end 
		


--ɾ����������������Ʒ
function DeductGuildItem(role,Guild_type)
	local gold = GetChaAttr(role,ATTR_GD)
	local fame = GetChaAttr(role,ATTR_FAME) 
	local attr_guild = HasGuild ( role )  
--	if attr_guild ~= 0 then 
--		HelpInfo(role,0,"������������") 
		--SystemNotice(role,0,"������������") 
--		return 0 
--	end 

	if Guild_type == 1 then						--�ж���������
--		if Guild2_ItemMax > 0 then
--			for i = 1 ,Guild2_ItemMax,1 do
--				local K = DelBagItem(role,Guild2_item[i],Guild2_count[i])
--			end
--		end
		DelBagItem(role,1780,1)	
		gold = gold - Guild2_Gold
		fame = fame - Guild2_fame
		SetAttrChangeFlag ( role )

		SetChaAttr(role,ATTR_GD,gold)
		SetChaAttr(role,ATTR_FAME,fame)

		SyncChar( role, 4 )
	
	elseif Guild_type == 0	then					--�ж���������
--		if Guild1_ItemMax > 0 then
--			for i = 1 ,Guild1_ItemMax,1 do
--				local K = DelBagItem(role,Guild1_item[i],Guild1_count[i])
--			end
--		end
		DelBagItem(role,1780,1)	
		gold = gold - Guild1_Gold
		fame = fame - Guild1_fame
		SetAttrChangeFlag ( role )

		SetChaAttr(role,ATTR_GD,gold)
		SetChaAttr(role,ATTR_FAME,fame)

		SyncChar( role, 4 )
	else
		--LG("checkguild","�������ʹ���  Guild_type = ",Guild_type)
	end

end
	

function AskJoinGuild ( role , guild_type ) 					-- ������빤���ж�   �������� 0��������1������
	local attr_guild = HasGuild ( role )  
	if attr_guild ~= 0 then 
		HelpInfo(role,0,"Already in a guild") 
		--SystemNotice(role,0,"������������") 
		return 0 
	end 
--	local fame = GetChaAttr ( role , ATTR_FAME ) 
--	if guild_type == 0 then 
--		if fame < JOINGUILD_NAVY_FAME then 
--			HelpInfo(role,0,"������������") 
--			--SystemNotice(role,0,"������������") 
--			return 0 
--		end 
--	elseif guild_type == 1 then 
--		if fame > JOINGUILD_PIRATE_FAME then 
--			HelpInfo(role,0,"������������") 
--			--SystemNotice(role,0,"������������") 
--			return 0 
--		end 
--	end 
	return 1 
end 

			



--�������(������Ӿ������)
--���н�ɫ����ʱ������
function GetExp_New(dead , atk  ) 
	if ValidCha(atk) == 0  then 
		LG ( "exp_atker=NIL" , "function GetExp_New : atker = nil " ) 
		return 
	end 
	--SystemNotice ( atk , "����GetExp_New")

	--LuaPrint("Enter function GetExp() --[[����ֵ��ù�ʽ1������ɱ�� 2�����ﱻ����ɱ�� 3����������pk���� 4���޾��齱��]]--") 
	local a = Check_Combat_Mod(dead , atk ) 
	if a==1 then 
	--LG("exp" , " enter  pkm mod" ) 
	GetExp_PKM( dead , atk ) --[[player kill monster]]--
	elseif a==2 then 
	--LG("exp" , " enter  mkp mod" ) 
	GetExp_MKP(dead , atk) --[[monster kill player]]--
	elseif a==3 then 
	--LG("exp" , " enter  pkp mod" ) 
	GetExp_PKP(dead , atk) --[[player kill player]]--
	elseif a==4 then 
	--LG("exp" , " enter  mkm mod" ) 
	GetExp_Noexp(dead , atk) --[[monster kill monster]]--
	else 
	--LuaPrint("�޷��ж�������ģʽ".."\n") return 
	end 
--Zizo's Global Drop System Handler
--------------------------------------------------------------------------
--[[	if IsPlayer ( dead ) == 0 then
	local monsterLv = GetChaAttr(dead, ATTR_LV)
		if monsterLv > 0 then
			local Rarity = Percentage_Random( 1 )
			local Rarity2 = Percentage_Random( 0.03 )
			local Rarity3 = Percentage_Random( 0.02 )
			local Rarity4 = Percentage_Random( 0.01 )
			if Rarity == 1 then
				GiveItemX(atk, 0, 15868, 1 , 4 )
			end
			if Rarity2 == 1 then
				GiveItemX(atk, 0, 15869, 1 , 4 )
			end
			if Rarity3 == 1 then
				GiveItemX(atk, 0, 15870, 1 , 4 )
			end
			if Rarity4 == 1 then
				GiveItemX(atk, 0, 15871, 1 , 4 )
			end
		end
--------------------------------------------------------------------------
	local rand = {}
	rand[1] = {15834,15835,15836,15840,15841,15842}--HP Potions
	local monsterLv = GetChaAttr(dead, ATTR_LV)
	local Rarity = Percentage_Random( 0.14 )
	local i = math.random(1,6)
	if Rarity == 1 then
		if monsterLv >= 10 then
			GiveItemX(atk, 0, rand[1][i], 1, 4)
		end
	end
--------------------------------------------------------------------------
	local monsterLv = GetChaAttr(dead, ATTR_LV)
	local Rarity = Percentage_Random( 0.07 )
	if Rarity == 1 then
		if monsterLv > 0 then 
			GiveItemX(atk, 0, 15829, 1 , 4 )--BronzeHunterCoin
		end
	end
--------------------------------------------------------------------------
	local item = {}
	item[1] = {15752, 15755, 15756, 15758, 15759, 15760, 15761, 15762, 15763, 15764} -- Lv10 Chests
	item[2] = {15768, 15771, 15772, 15773, 15774, 15775, 15776, 15777, 15778, 15779, 15780} -- Lv20 Chests
	item[3] = {15784, 15787, 15788, 15789, 15790, 15791, 15792, 15793, 15794, 15795, 15796} -- Lv40 Chests
	item[4] = {15800, 15803, 15804, 15805, 15806, 15807, 15808, 15809, 15810, 15811, 15812} -- Lv60 Chests
	item[5] = {15816, 15819, 15820, 15821, 15822, 15823, 15824, 15825, 15826, 15827, 15828} -- Lv90 Chests


	local monsterLv = GetChaAttr(dead, ATTR_LV)
	if(monsterLv >= 25 and monsterLv < 56 ) then
		local Rarity = math.random(1,100)
		local rad = math.random(1,10)
		local rad2 = math.random(1,11)
		if Rarity > 94 then
			if rad == 1 then
					GiveItemX ( atk, 0, item[2][rad], 1, 4);
				elseif rad == 2 then
					GiveItemX ( atk, 0, item[2][rad], 1, 4);
				elseif rad == 3 then
					GiveItemX ( atk, 0, item[2][rad], 1, 4);
				elseif rad == 4 then
					GiveItemX ( atk, 0, item[2][rad], 1, 4);
				elseif rad == 5 then
					GiveItemX ( atk, 0, item[2][rad], 1, 4);
				elseif rad == 6 then
					GiveItemX ( atk, 0, item[2][rad], 1, 4);
				elseif rad == 7 then
					GiveItemX ( atk, 0, item[2][rad], 1, 4);
				elseif rad == 8 then
					GiveItemX ( atk, 0, item[2][rad], 1, 4);
				elseif rad == 9 then
					GiveItemX ( atk, 0, item[2][rad], 1, 4);
				elseif rad == 10 then
					GiveItemX ( atk, 0, item[2][rad], 1, 4);
				-- elseif rad == 11 then
					-- GiveItemX ( atk, 0, item[2][rad], 1, 4);
			end
		end
		 if Rarity > 98 then
			if rad2 == 1 then
					GiveItemX ( atk, 0, item[3][rad2], 1, 4);
				elseif rad2 == 2 then
					GiveItemX ( atk, 0, item[3][rad2], 1, 4);
				elseif rad2 == 3 then
					GiveItemX ( atk, 0, item[3][rad2], 1, 4);
				elseif rad2 == 4 then
					GiveItemX ( atk, 0, item[3][rad2], 1, 4);
				elseif rad2 == 5 then
					GiveItemX ( atk, 0, item[3][rad2], 1, 4);
				elseif rad2 == 6 then
					GiveItemX ( atk, 0, item[3][rad2], 1, 4);
				elseif rad2 == 7 then
					GiveItemX ( atk, 0, item[3][rad2], 1, 4);
				elseif rad2 == 8 then
					GiveItemX ( atk, 0, item[3][rad2], 1, 4);
				elseif rad2 == 9 then
					GiveItemX ( atk, 0, item[3][rad2], 1, 4);
				elseif rad2 == 10 then
					GiveItemX ( atk, 0, item[3][rad2], 1, 4);
				elseif rad2 == 11 then
					GiveItemX ( atk, 0, item[3][rad2], 1, 4);
			end
		end
	end
--------------------------------------------------------------------------
	local monsterLv = GetChaAttr(dead, ATTR_LV)
	if(monsterLv >= 1 and monsterLv < 36) then
		local Rarity = math.random(1,100)
		local rad = math.random(1,11)
		local rad2 = math.random(1,11)
		if Rarity > 94 then
			if rad == 1 then
					GiveItemX ( atk, 0, item[1][rad], 1, 4);
				elseif rad == 2 then
					GiveItemX ( atk, 0, item[1][rad], 1, 4);
				elseif rad == 3 then
					GiveItemX ( atk, 0, item[1][rad], 1, 4);
				elseif rad == 4 then
					GiveItemX ( atk, 0, item[1][rad], 1, 4);
				elseif rad == 5 then
					GiveItemX ( atk, 0, item[1][rad], 1, 4);
				elseif rad == 6 then
					GiveItemX ( atk, 0, item[1][rad], 1, 4);
				elseif rad == 7 then
					GiveItemX ( atk, 0, item[1][rad], 1, 4);
				elseif rad == 8 then
					GiveItemX ( atk, 0, item[1][rad], 1, 4);
				elseif rad == 9 then
					GiveItemX ( atk, 0, item[1][rad], 1, 4);
				elseif rad == 10 then
					GiveItemX ( atk, 0, item[1][rad], 1, 4);
				elseif rad == 11 then
					GiveItemX ( atk, 0, item[1][rad], 1, 4);
			end
		end
		 if Rarity > 98 then
			if rad2 == 1 then
					GiveItemX ( atk, 0, item[1][rad2], 1, 4);
				elseif rad2 == 2 then
					GiveItemX ( atk, 0, item[1][rad2], 1, 4);
				elseif rad2 == 3 then
					GiveItemX ( atk, 0, item[1][rad2], 1, 4);
				elseif rad2 == 4 then
					GiveItemX ( atk, 0, item[1][rad2], 1, 4);
				elseif rad2 == 5 then
					GiveItemX ( atk, 0, item[1][rad2], 1, 4);
				elseif rad2 == 6 then
					GiveItemX ( atk, 0, item[1][rad2], 1, 4);
				elseif rad2 == 7 then
					GiveItemX ( atk, 0, item[1][rad2], 1, 4);
				elseif rad2 == 8 then
					GiveItemX ( atk, 0, item[1][rad2], 1, 4);
				elseif rad2 == 9 then
					GiveItemX ( atk, 0, item[1][rad2], 1, 4);
				elseif rad2 == 10 then
					GiveItemX ( atk, 0, item[1][rad2], 1, 4);
				elseif rad2 == 11 then
					GiveItemX ( atk, 0, item[1][rad2], 1, 4);
				end
			end
		end
	end]]--
end 









function Check_Combat_Mod(dead , atk) --[[�ж����齱�ͷ�ʽ]]-- 
	--LuaPrint("Enter function Check_Combat_Mod () --[[�ж����齱�ͷ�ʽ]]-- ") 
	local rolemod_atker = IsPlayer(atk) 
	--LG("exp" , " atker role = " ,  rolemod_atker ) 
	local rolemod_defer = IsPlayer(dead)  --����ɫ���ࣺ0����� 1�����
	--LG("exp" , " defer role = " ,  rolemod_defer ) 
	if (rolemod_atker==0) and (rolemod_defer==0) then 
		return 4 
	elseif rolemod_atker==0 and rolemod_defer==1 then 
		return 2 
	elseif rolemod_atker==1 and rolemod_defer==0 then 
		return 1 
	elseif rolemod_atker==1 and rolemod_defer==1 then 
		return 3 
	else 
		--LuaPrint("����Ľ�ɫ����ֵ".."\n") 
		return 
	end 
	--LuaPrint("Out function Check_Combat_Mod () --[[�ж����齱�ͷ�ʽ]]-- ") 
end 




function GetExp_PKM( dead , atk  ) --[[player kill monster ����ֵ��ù�ʽ ����exp��exp(d)/math.floor(|lv(a)-lv(b)|*0.1+1)]]--
--	Beach.PlayerKilledMonster(dead, atk)
--	AchievementKillMonster(dead,atk)
CTF.PKM(dead, atk)
	local dead_lv = GetChaAttrI( dead , ATTR_LV ) --������ߵĵȼ�   
	local dead_exp = GetChaAttrI( dead , ATTR_CEXP ) * EXP_RAID
	LG("exp" , "deadlv = " , dead_lv ) 
	LG("exp" , "dead_exp = " , dead_exp ) 
	local k = {} 
	local kdmg = {} 
	local k_exp = {} 

	k[0] , kdmg[0] = GetChaHarmByNo ( dead , 0 ) 
--	if ValidCha ( k[0] ) == 0 then 
--		SystemNotice ( atk , "�˺��б���λΪ��" ) 
--	end 
	--SystemNotice ( atk , "�����˺���λ0��") 
	--SystemNotice ( atk , "�����˺�Ϊ"..kdmg[0]) 

	k[1] , kdmg[1] = GetChaHarmByNo ( dead , 1 ) 
--	if ValidCha ( k[1] ) == 0 then 
--		SystemNotice ( atk , "�˺��б�2λΪ��" ) 
--	end 
	--SystemNotice ( atk , "�����˺���λ1��") 
	--SystemNotice ( atk , "�����˺�Ϊ"..kdmg[1]) 

	k[2] , kdmg[2] = GetChaHarmByNo ( dead , 2 ) 
--	if ValidCha ( k[2] ) == 0 then 
--		SystemNotice ( atk , "�˺��б�3λΪ��" ) 
--	end 
	--SystemNotice ( atk , "�����˺���λ2��") 
	--SystemNotice ( atk , "�����˺�Ϊ"..kdmg[2]) 

	k[3] , kdmg[3] = GetChaHarmByNo ( dead , 3 ) 
--	if ValidCha ( k[3] ) == 0 then 
--		SystemNotice ( atk , "�˺��б�4λΪ��" ) 
--	end 
	--SystemNotice ( atk , "�����˺���λ3��") 
	--SystemNotice ( atk , "�����˺�Ϊ"..kdmg[3]) 

	k[4] , kdmg[4] = GetChaHarmByNo ( dead , 4 ) 
--	if ValidCha ( k[4] ) == 0 then 
--		SystemNotice ( atk , "�˺��б�5λΪ��" ) 
--	end 
	--SystemNotice ( atk , "�����˺���λ4��") 
	--SystemNotice ( atk , "�����˺�Ϊ"..kdmg[4]) 
	local first_atker = GetFirstAtker ( dead ) 
	
	local Gen_dmg = 0 

	for i = 0 , 4 , 1 do 
		if k[i] ~= 0 then 
			Gen_dmg = Gen_dmg + kdmg[i] 
			--SystemNotice ( atk , "�����˺�ָ�벻Ϊ0����λ"..i) 
			--SystemNotice ( atk , "�����˺�Ϊ"..kdmg[i]) 
		end 
	end 
	--SystemNotice ( atk , "�ܹ����˺�Ϊ"..Gen_dmg) 
	for i = 0 , 4 , 1 do 
		k_exp[i] = 0 

		if ValidCha( k[i] )== 1 then 
			if kdmg[i] > 0 then 
				if k[i] == first_atker then 
					k_exp[i] = dead_exp * ( 0.7 * kdmg[i] / Gen_dmg + 0.3 )		--��һλ���������Ȼ��30���Ĺ����ܾ���
				else
					k_exp[i] =  dead_exp * 0.7 * kdmg[i] / Gen_dmg 
				end
				--SystemNotice ( atk , "�����˺���λ"..i) 
				--SystemNotice ( atk , "���䵽exp"..k_exp[i]) 
				ShareTeamExp ( dead , k[i] , k_exp[i] ,atk ) 
			end 
		end 
	end 
	
	local MonsterIDs = {
	[668] = 200000,	---monster id --- gold amount 
	[669] = 100000,	---monster id --- gold amount 
	[670] = 100000,	---monster id --- gold amount 
	[671] = 100000,	---monster id --- gold amount 
	[672] = 100000,	---monster id --- gold amount 
	[725] = 100000,	---monster id --- gold amount 
	[726] = 100000,	---monster id --- gold amount 
	}

	local BossIDs = {
		[789] = 50000000,	---boss id --- gold amount 
		[679] = 5000000,	---boss id --- gold amount 
		[678] = 5000000,	---boss id --- gold amount 
		[675] = 5000000,	---boss id --- gold amount 
		[706] = 5000000,	---boss id --- gold amount 
		[707] = 5000000,	---boss id --- gold amount 
		[708] = 5000000,	---boss id --- gold amount 
		[690] = 5000000,	---boss id --- gold amount 
		[691] = 5000000,	---boss id --- gold amount 
		[692] = 5000000,	---boss id --- gold amount 
		[693] = 5000000,	---boss id --- gold amount 
		[1417] = 5000000,	---boss id --- gold amount 
		[988] = 10000000,	---boss id --- gold amount 
		[1672] = 1000000,
	}
	local monster = GetChaID(dead)
	local bosses = GetChaID(dead)
	local killer_name = GetChaDefaultName(atk)
	local boss_name = GetChaDefaultName(dead)
	if (MonsterIDs[monster] ~= nil) then
	AddMoney(atk, 0, MonsterIDs[monster])
	elseif(BossIDs[bosses] ~= nil) then
		AddMoney(atk, 0, BossIDs[bosses])
		ScrollNotice("[INSANE damage by ] "..killer_name.." beside he has killed "..boss_name.."! ",1)
	end 

--------------------------------------------------------------------------
	local item_host = 0 
	local exp_max = k_exp[0] 
	--SystemNotice ( atk , "���߳�ʼ������λ"..0) 
	for i = 1 , 4 , 1 do 
		--SystemNotice ( atk , "���߹����ж�"..i) 
		--SystemNotice ( atk , "����ݶ�"..k_exp[i])

		if k_exp [i] > exp_max  then 
			exp_max = k_exp[i] 
			item_host = i 
			--SystemNotice ( atk , "���߸��Ĺ�����λ"..i) 
		end 
	end 
	if ChaIsBoat (k[item_host] ) == 1 then 

		local ship_lv = GetChaAttr ( k[item_host] , ATTR_LV ) 
		local shipowner_lv  = GetChaAttr ( TurnToCha ( k[item_host] ) , ATTR_LV )  
		local ship_exp = GetChaAttr ( k[item_host] , ATTR_CEXP ) 
		local ship_expadd = math.floor ( math.min ( 7 , ( dead_lv / 10 + 2 ) ) ) 
		local lv_limit = math.min ( ship_lv , shipowner_lv ) - 10 
		if dead_lv >= lv_limit then 
			ship_exp = ship_exp + ship_expadd 
			SetCharaAttr (  ship_exp , k[item_host] ,ATTR_CEXP ) 
--			SystemNotice ( k[item_host] , "���Ӵ�ֻ����"..ship_expadd ) 

		end 
	end 
	SetItemHost ( dead , k[item_host] ) 

end 


function ValidCha(ter)
  if ter==nil or ter==0 then 
	return 0 
  end
  return 1
end

function ShareTeamExp ( dead , team_atker , dead_exp , The_Killer) 
	local cha_name1100 = GetChaDefaultName (team_atker )	
	local star111=GetChaAttr (  team_atker , ATTR_CEXP )----------��ǰ�ȼ�����
	LG("star_exp" , "Player"..cha_name1100.."Current Experience is"..star111.."Starts ShareTeamExp" ) 
	local atker_role = ChaIsBoat ( team_atker ) 
	local monster_location = IsChaInLand ( dead ) 
	if atker_role == 1 and monster_location == 1 then 
		dead_exp = math.floor ( dead_exp / 5 + 1 ) 
	end 

	--SystemNotice ( team_atker , "����ShareTeamExp")

	local dead_lv = GetChaAttrI( dead , ATTR_LV )			--������ߵĵȼ�   
	--local team_atker = TurnToCha ( team_atker )				--ת����ָ��
	local t = {} 
	t[0] = team_atker  
	if ValidCha (team_atker) == 0 then 
		LG ( "luascript_err" , "function ShareTeamExp : party experience source as null" ) 
		return 
	end 
	t[1] = GetTeamCha(team_atker, 0 )  
	t[2] = GetTeamCha(team_atker, 1 )   
	t[3] = GetTeamCha(team_atker, 2 )    
	t[4] = GetTeamCha(team_atker, 3 )
    
    --SystemNotice ( team_atker , "aaaa")
--	LG("harm", "t[0] = ", t[0]," t[1] = ", t[1], "t[2] = ", t[2])
--	LG("harm", "\n")
    --local notice = "t[1]="..t[1].." t[2]="..t[2].." t[3]="..t[3].." t[4]="..t[4]
    ----SystemNotice ( team_atker , notice)
    --SystemNotice ( team_atker , "bbbb")
	
    
	local count = 0 
	local NewPlayer_CanGet = 0
	local NewPlayer_Lv = 0
	local NewPlayer_Lv_dif = -100
	local Check_Killer = 0
	if t[0] == The_Killer then
		Check_Killer = 1
	end
	for i = 0 , 4 , 1 do	
		if ValidCha( t[i] )== 1  then					--��������Ӿ������Ľ�ɫ������ڣ��ҶԶ��龭��ļӳɺͷ���Ҳ������Ч��Ա��������
			--SystemNotice(team_atker, "��ʼ����CheckExpShare")
			a = CheckExpShare ( t[i] , team_atker ) 
			--SystemNotice(team_atker, "��������CheckExpShare, ����ֵ="..a)
			if a == 1 then 
				count = count + 1 
				NewPlayer_Lv = Lv( TurnToCha(t[i]) )
				NewPlayer_Lv_dif = dead_lv - NewPlayer_Lv
				if NewPlayer_Lv <=30 and NewPlayer_Lv >= 10 and NewPlayer_Lv_dif >= -5 then
					NewPlayer_CanGet = NewPlayer_CanGet + 1
				end
			end 
		end 
        end 
	if count == 0 then 
		LG ("luascript_err" , "function ShareTeamExp : Member total count as 0 " )
		return 
	end 
	local TeamExp_Increas = 0.25 * TeamExp_RAID

	--SystemNotice ( team_atker , "�����뾭�鹲����Ա��count="..count)
	LG("exp" , "deadlv = " , dead_lv ) 
	LG("exp" , "dead_exp = " , dead_exp ) 
	LG("exp" , "teamer_count = " , count ) 
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
	local exp_add = math.floor( dead_exp * ( 1 + (count -1 )* TeamExp_Increas ) ) --�ܾ���
	local exp_increase = math.floor ( dead_exp * (count -1 )* TeamExp_Increas ) --���Ӿ���

---BB����

	LG("exp" , "exp_add = " , exp_add ) 

	if count >=2 then
		exp_add = exp_add * InTeamGetExp_RAID
	end

	local exp_up

    --SystemNotice ( team_atker , "��ʼΪ��Ա���侭��")
	for i = 0 , 4 , 1 do	
		if ValidCha(t[i])==1 then			--��ɫ��Ϊ��
			local a = 1							--��ʼ����ɫ�ڿ�ʼʱ�Ƿ���侭��ļ��ϵ��
			local b = 1							--��ʼ����ɫ�ڿ�ʼʱ���侭��ı���ϵ��
			LG("exp" , "loop = " , i ) 

			if i >= 1 then 
--				t[i] = TurnToCha ( t[i] )			            --ת����ָ��
				a = CheckExpShare ( t[i] , team_atker ) 		--��������� 
				LG("exp" , "experience distribution test a =  " , a ) 
				exp_up = math.max (1,  math.floor ( exp_add/count ) )  * a 
				LG("exp" , "exp_up1  =  " , exp_up ) 
			else 
				exp_up = math.max ( 1, math.floor ( exp_add/count ) )  
				LG("exp" , "exp_up1  =  " , exp_up ) 
				--��ֱ��ɱ���������⴦�� 
			end 

			t_lv = GetChaAttrI ( TurnToCha(t[i]) , ATTR_LV ) 

			lv_dis =  t_lv - dead_lv 	--�����ȼ���Ծ����ȡ�������ж�
			LG ( "exp" , " t_lv = " , t_lv , "  dead_lv = " , dead_lv , "  lv_dis = " , lv_dis ) 
			if lv_dis >= 4 then 
				b = math.min ( 10 , 1 + ( math.abs ( lv_dis - 4 ) * 0.4 ) )  --�����ȼ��������޷����ȫ���
			elseif lv_dis <= -1 * 10 then 
				b = math.min ( 4 , 1 + math.abs ( lv_dis - 10)  * 0.1 )      --�����ȼ��������޷����ȫ��� 
			end 
			LG ( "exp" , "exp_up2 =  " , exp_up , " b = " , b , " a = ", a ) 

			exp_up = math.floor ( math.max ( 1 , exp_up / b ) ) * a 

			LG ( "exp" , "exp_up3 =  " , exp_up) 
			
			if count >=3 and NewPlayer_CanGet <= 0 and Check_Killer == 1 then				---�жϻ����ӹ��׵���
				if lv_dis <=3 then
					Add_RYZ_TeamPoint ( TurnToCha(t[i]) , count , 1)
				end
			end
			if t_lv >= 50 and NewPlayer_CanGet > 0 and Check_Killer == 1 then
				Add_RYZ_TeamPoint ( TurnToCha(t[i]) , 6 , NewPlayer_CanGet)
			end

			exp = GetChaAttrI ( TurnToCha(t[i]) , ATTR_CEXP ) 
			LG("exp" , "exp_original = " , exp ) 
			local EXP_RAID_STATE = 1
			local StateLv = GetChaStateLv ( t[i] , STATE_SBJYGZ )
	
	---------------------------------------------------------------------08��Ʒ��������Ӧstatelv���е���kokora-------------------------------------------------------------
			if StateLv > 0 and StateLv <= 10 then
				if StateLv == 1 then
					EXP_RAID_STATE = StateLv + 1
				end
				if StateLv == 2 then
					EXP_RAID_STATE = 2
				end
				if StateLv == 3	then
					EXP_RAID_STATE = 2.5
				end
				if StateLv == 4	then
					EXP_RAID_STATE = 3
				end
				if StateLv == 5	then----------------------------�����ƽ���------Amon
					EXP_RAID_STATE = 5---------------------��Сʱ5������
				end
				if StateLv == 6	then----------------------------�����ƽ���------Amon
					EXP_RAID_STATE = 10---------------------15����10������
				end

				if StateLv == 7	then----------------------------��բз--------kokora
					EXP_RAID_STATE = 20------------------2����20������
				end
			end
			
			if StateLv > 1 then
				local CheckLucky = 0
				CheckLucky = CheckLuckyFinish ( StateLv )
				if CheckLucky == 1 then
					EXP_RAID_STATE = EXP_RAID_STATE * 2
					SystemNotice ( TurnToCha(t[i]) , "Lucky Strike, obtains increased experience gained" )
				end
				if CheckLucky == 2 then
					EXP_RAID_STATE = 10
					SystemNotice ( TurnToCha(t[i]) , "Super Lucky Strike! Obtained 10 times EXP" )
				end
			end

			if exp_up == 0 then 
				LG ( "exp" , "No experience growth" ) 
				return 
			end
			
			exp_up = exp_up * EXP_RAID_STATE
			

---------------------------------------����Ӿ���״̬�ж�
			--local Check_star = {}
			--	Check_star[0] = t[i]  
			--	Check_star[1] = GetTeamCha( t[i] , 0 )  
			--	Check_star[2] = GetTeamCha( t[i] , 1 )   
			--	Check_star[3] = GetTeamCha( t[i] , 2 )    
			--	Check_star[4] = GetTeamCha( t[i] , 3 )
			--for m = 0 , 4 , 1 do	
			--	if ValidCha( Check_star[m] )== 1  then					--��������Ӿ������Ľ�ɫ�������
					local Item_bg = GetChaItem ( t[i] , 2 , 1  ) --ȡ��ɫ�����ڶ�����ָ��
					local Get_Item_Type = GetItemType ( Item_bg ) --���ó���ӿڻ��Item��������
					if Get_Item_Type==59 then --------�ж��Ƿ�Ϊ����
						local  Item_ID = GetItemID ( Item_bg )	--ȡID
						local str = GetItemAttr( Item_bg ,ITEMATTR_VAL_STR )			--���� 
						local con = GetItemAttr( Item_bg ,ITEMATTR_VAL_CON )		 ---���� 
						local agi = GetItemAttr( Item_bg ,ITEMATTR_VAL_AGI )			--���� 
						local dex = GetItemAttr( Item_bg ,ITEMATTR_VAL_DEX )		 --רע 
						local sta = GetItemAttr( Item_bg ,ITEMATTR_VAL_STA )			 --���� 
						local URE = GetItemAttr( Item_bg ,ITEMATTR_URE )			--���� 
						local MAXURE = GetItemAttr( Item_bg ,ITEMATTR_MAXURE )		 --�������
						local lv_JL = str + con + agi + dex + sta	----һ������ĵȼ�
						local Num_JL = GetItemForgeParam ( Item_bg , 1 )
						local Part1 = GetNum_Part1 ( Num_JL )	--Get Num Part 1 �� Part 7
						local Part2 = GetNum_Part2 ( Num_JL )	
						local Part3 = GetNum_Part3 ( Num_JL )
						local StateLv1 = GetChaStateLv (t[i] , STATE_JLFT7 )
						local StateLv2 = GetChaStateLv (t[i] , STATE_JLFT8 )
						local flag=0
						if Item_ID==237 and StateLv1~=0 then
							flag=1
						end
						if Item_ID==681 and StateLv2~=0 then
							flag=1
						end
						if flag==1  then ----��idΪ237����681�ŵľ��鲢�Ҿ��鸽�弼�ܴ���
							--if StateLv1 == 1 or StateLv2 == 1 then ---����
							--	exp_up = exp_up*(0.005*lv_JL*0.1+1)
							--end
							--if StateLv1 == 2 or StateLv2 == 2 then ---�м�
							--	exp_up = exp_up*(0.0125*lv_JL*0.1+1)
							--end
							--if StateLv1 == 3 or StateLv2 == 3 then ---�߼�
							--	exp_up = exp_up*(0.025*lv_JL*0.1+1)
							--end
							if StateLv1 ~= 0 or StateLv2 ~= 0 then 
								exp_up = exp_up*(lv_JL*0.02+1)
							end
						--	URE=URE-4500
						end
						SetItemAttr ( Item_bg , ITEMATTR_URE , URE ) 	
					end
			--	end
			--end
-------------------------------------------
-------------------------------------------
			local Check = {}
				Check[0] = t[i]  
				Check[1] = GetTeamCha( t[i] , 0 )  
				Check[2] = GetTeamCha( t[i] , 1 )   
				Check[3] = GetTeamCha( t[i] , 2 )    
				Check[4] = GetTeamCha( t[i] , 3 )
	
			for j = 0 , 4 , 1 do	
				if ValidCha( Check[j] )== 1  then					--��������Ӿ������Ľ�ɫ�������
					local star = IsTeamLeader( Check[j] )
					if	star==1 then -------------�ж϶ӳ�			
						local StateLv = GetChaStateLv ( Check[j] , STATE_ZDSBJYGZ )
						local	Isshare = CheckExpShare ( t[i] , Check[j])
						--SystemNotice ( TurnToCha(t[i]) , "Isshare" )
						if StateLv == 1 and Isshare == 1 then
							exp_up = 1.5*exp_up
						end
					end
				end
			end
			
----------------------------------------------
----------------------------------------------ʥս������������
     --Notice("come here")
     local map_name_atk = GetChaMapName ( The_Killer )
     local map_name_def = GetChaMapName ( dead )
     if map_name_atk == "guildwar" or map_name_def == "guildwar" then
       local normal_monster =  GetChaID(dead)
	  --Notice("normal_monster=="..normal_monster)
       if normal_monster == 220 then  ---��ɫ
	   --AddState ( The_Killer , The_Killer , STATE_JRQKL , 10 , 180 )
	   AddState ( The_Killer , The_Killer , STATE_HFZQ , 10 , 10 )
       end
       if normal_monster == 219 then  -----��ɫ
           AddState ( The_Killer , The_Killer , STATE_QINGZ , 10 , 300 )
       end
       if normal_monster == 217 then  -----��ɫ
           AddState ( The_Killer , The_Killer , STATE_JRQKL , 10 , 180 )
       end
       if normal_monster == 218 then -----��ɫ
           AddState ( The_Killer , The_Killer , STATE_YS , 10 , 300 )
       end
      elseif map_name_atk == "guildwar2" or map_name_def == "guildwar2" then
       local normal_monster =  GetChaID(dead)
	  --Notice("normal_monster=="..normal_monster)
       if normal_monster == 220 then  ---��ɫ
	   --AddState ( The_Killer , The_Killer , STATE_JRQKL , 10 , 180 )
	   AddState ( The_Killer , The_Killer , STATE_HFZQ , 10 , 10 )
       end
       if normal_monster == 219 then  -----��ɫ
           AddState ( The_Killer , The_Killer , STATE_QINGZ , 10 , 300 )
       end
       if normal_monster == 217 then  -----��ɫ
           AddState ( The_Killer , The_Killer , STATE_JRQKL , 10 , 180 )
       end
       if normal_monster == 218 then -----��ɫ
           AddState ( The_Killer , The_Killer , STATE_YS , 10 , 300 )
       end
     end


----------------------------------------
-----------------------------------------�Ŷ�֮�Ǵ���
		local expGetNow = exp_up		--��ǰ��ɫ������ֿɿɻ�õľ���
		local expCanGive = 0
		t[i] = TurnToCha ( t[i]  )-- ������
		local ptnItem = GetEquipItemP( t[i] , 8)--ȡ������ָ��	pointer		
		local IdItem = GetItemID ( ptnItem )	
		local lvPerson = GetChaAttr(t[i] , ATTR_LV)
		--Notice ( "���е�����" )
		if IdItem==1034 and lvPerson < 41 then
			local expItemNow = GetItemAttr( ptnItem , ITEMATTR_URE)*10   --100��ʼֵ
			local expItemMax = GetItemAttr ( ptnItem , ITEMATTR_MAXURE)*10
			local retIsInTeam = IsInTeam(t[i] )
			if retIsInTeam ~= LUA_TRUE then			--����ʯͷ���鴢�����
				expItemNow = expItemNow + expGetNow
				if expItemNow >= expItemMax then
					expItemNow = expItemMax
				end
			else						--�����
				if HasTeammate(t[i] ,0, 5) == LUA_TRUE then---û�б��Լ�С5���Ķ���
					local ptnLowLvPlayer = returnLowLVPlayer( t[i], t[0], t[1], t[2], t[3], t[4]) --���ض����б��Լ��ȼ�С5������ָ
					if ValidCha(ptnLowLvPlayer) == 1 then      --��û���Ĵ���
					
						local expCanUse = expItemNow - 1000				--���鷵������
							if expGetNow * 2>= expCanUse then
								expCanGive = expCanUse
								expItemNow = 1000
							else
								expItemNow = expItemNow - expGetNow*2
								expCanGive = expGetNow * 2
							end
							if expItemNow <= 1000 then
								expItemNow = 1000
							end
						exp_up = exp_up + expCanGive
					else																	--���˵Ĵ���				
						expCanGive = 0
						exp_up = exp_up + expCanGive
					end
					
					local expCanUse = expItemNow - 1000

			
				end
			end
			expItemNow= math.floor(expItemNow/10)
			SetItemAttr ( ptnItem ,ITEMATTR_URE , expItemNow )
		end
---------------------------------
---------------------------------
-----------------------------------------				
			if exp_up > 20000 then
				local cha_name = GetChaDefaultName ( TurnToCha(t[i]) )
				local Monster_name = GetChaDefaultName ( dead )
				LG ( "Big_exp" ,"Character"..cha_name.."Attack"..Monster_name.."Obtained"..exp_up.."EXP" )
			end
			--SystemNotice ( team_atker , "����Ϊ"..exp)
			--SystemNotice ( team_atker , "��þ���Ϊ"..exp_up)
			--SystemNotice ( TurnToCha(t[i]) , "exp = "..exp )
			if exp<DEXP[80] and (exp+exp_up)>DEXP[80] then
				--SystemNotice ( TurnToCha(t[i]) , "DEXP[80] = "..DEXP[80] )
				--SystemNotice ( TurnToCha(t[i]) , "exp_upǰ = "..exp_up)
				exp_up =math.floor((DEXP[80]-exp) +(exp_up-(DEXP[80]-exp))/50)
				--SystemNotice ( TurnToCha(t[i]) , "exp_up�� = "..exp_up)
			end                                                                                  -------------����79����80��֮���õ�������ȵľ��� Jack


			if Lv ( TurnToCha(t[i]) ) >= 80 then 
				exp_up = math.floor ( exp_up / 50 ) 
			end 
			--������ϵ��  
			local retExpState = GetExpState(t[i])

			if exp_up == 0 and retExpState ~= 0 then 
				SystemNotice ( TurnToCha(t[i]) , "Your level is too high to obtain any experience" )
			end 


			--Notice("��ֻ�ȡ����ķ�����ϵ��Ϊ"..retExpState)
			--Notice("������֮ǰ��exp"..exp_up)
			
			exp_up =exp_up *GetExpState(t[i])/100
			--Notice("������֮���exp"..exp_up)

			--SystemNotice ( TurnToCha(t[i]) , "�������ּ����õ���exp_up = "..exp_up)
			exp = exp + exp_up  
			

--			local lv = GetChaAttr(TurnToCha(t[i]), ATTR_LV)
--			if lv == 100 then
--				local a = CheckBagItem ( TurnToCha(t[i]), 171 )
--				--SystemNotice( TurnToCha(t[i]), "��Ŀ="..a)
--				if a == 1 then
--					local role_jyp = GetChaItem2 ( TurnToCha(t[i]), 2, 171)
--					local exp_store = GetItemAttr ( role_jyp, ITEMATTR_VAL_PARAM1 )
--					--SystemNotice( TurnToCha(t[i]), "ԭNUM="..exp_store)
--					exp_store = exp_store+exp_up
--					--SystemNotice( TurnToCha(t[i]), "��NUM="..exp_store)
--					SetItemAttr ( role_jyp, ITEMATTR_VAL_PARAM1, exp_store)
--					SystemNotice( TurnToCha(t[i]), "��ľ���ƿ�еĻ���������"..exp_up)
--				else
--				SetChaAttrI ( TurnToCha(t[i]) , ATTR_CEXP, exp )
--				end
--			else
--			SetChaAttrI ( TurnToCha(t[i]) , ATTR_CEXP, exp )
--			LG("exp" , "exp_now = " , exp ) 
--			end
			SetChaAttrI ( TurnToCha(t[i]) , ATTR_CEXP, exp ) 
			LG("exp" , "exp_now = " , exp ) 
		else 
	        --SystemNotice ( team_atker , "��Ա��λ["..i.."]��ֵΪ��")
		end 
	end 
	local star112=GetChaAttr (  team_atker , ATTR_CEXP )----------��ǰ�ȼ�����
	LG("star_exp" , "Player"..cha_name1100.."Current Experience is"..star112.."End ShareTeamExp" ) 
	LG("exp" , "end getexp " )
end 

function returnLowLVPlayer(PlayerNow,Player1,Player2,Player3,Player4,Player5)    --���ض����б��Լ��ȼ�С5�������ָ��
	local lvPlayerNow = GetChaAttr(PlayerNow, ATTR_LV)
	PlayerNow = TurnToCha(PlayerNow)
	Player1 = TurnToCha(Player1)
	Player2 = TurnToCha(Player2)
	Player3 = TurnToCha(Player3)
	Player4 = TurnToCha(Player4)
	Player5 = TurnToCha(Player5)
	
	if ValidCha(Player1) == 1 then
		local lvPlayer1 = GetChaAttr(Player1, ATTR_LV)
		if lvPlayerNow > lvPlayer1 + 5 then
			return Player1
		end
	end
	
	if ValidCha(Player2) == 1 then
		local lvPlayer2 = GetChaAttr(Player2, ATTR_LV)
		if lvPlayerNow > lvPlayer2 + 5 then
			return Player2
		end
	end
	
	if ValidCha(Player3) == 1 then
		local lvPlayer3 = GetChaAttr(Player3, ATTR_LV)
		if lvPlayerNow > lvPlayer3 + 5 then
			return Player3
		end
	end
	
	if ValidCha(Player4) == 1 then
		local lvPlayer4 = GetChaAttr(Player4, ATTR_LV)
		if lvPlayerNow > lvPlayer4 + 5 then
			return Player4
		end
	end
	
	if ValidCha(Player5) == 1 then
		local lvPlayer5 = GetChaAttr(Player5, ATTR_LV)
		if lvPlayerNow > lvPlayer5 + 5 then
			return Player5
		end
	end
	
	return 0
end

function CheckExpShare ( ti , atk ) --ti���atk����Ǿ���������
	if ValidCha(ti)==0 then 
		LG ( "luascript_err" , "fucntion CheckExpShare : party member count as null\n" ) 
		return 0
	end 

	if IsInSameMap ( atk , ti ) == 0   then 
		--SystemNotice( atk , "�������ڵ�ͼ��ͬ�����޷���ĳЩ���ѷ���ս������") 
		return 0 
	end 

	local pos_ti_x , pos_ti_y = GetChaPos ( ti ) 
	if ValidCha( atk ) == 0 then 
		LG ( "luascript_err" , "fucntion CheckExpShare :  Monster killer as null\n" ) 
		return 0
	end 

		
	local pos_atk_x , pos_atk_y = GetChaPos ( atk ) 
	local distance = Dis ( pos_ti_x , pos_ti_y , pos_atk_x , pos_atk_y ) 
	if distance >= 4000 then 
--		HelpInfo(ti,0,"�������̫Զ�����޷�������ĳЩ���ѷ���ս������") 
		return 0 
	end 
	if IsChaInRegion ( ti , AREA_SAFE ) == 1 then 
--		HelpInfo(ti,0,"���ڴ��ڰ�ȥ�������޷������Ķ��ѷ���ս������") 
		return 0 
	end 
	return 1 
end 


function Dead_Punish ( dead , atk ) --�����ͷ�
----------ʥ��
	local Role_ID = GetRoleID(dead)
	 BBBB[ Role_ID ] = 0
------------------
	local map_name = GetChaMapName ( dead )
	if map_name == "leiting2" or map_name == "binglang2" or map_name == "shalan2" or map_name == "guildwar" or map_name == "guildwar2" then
		return
	end

	
	local map_name = GetChaMapName ( dead )
	if map_name == "garner2" then
	SetCharaAttr(0, dead, ATTR_SP)
		return
	end
	dead = TurnToCha ( dead ) 
	local lv = GetChaAttr( dead, ATTR_LV ) 
	local check_pirate=CheckItem_pirate(dead)
	local check_death=CheckItem_Death(dead)
	local Time = os.date("%H")
	local TimeNum = tonumber(Time)

	if lv<=10 then
		return 
	end --[[�ж�����10���۳�����]]--
	if lv >= 70 and check_pirate ==1 then
		if TimeNum<=6 or TimeNum >=18 then
			SystemNotice (dead , "Received blessing from moonlight. Death penalty will be removed" ) 
			return
		end
	end
	if lv >= 75 and check_death ==1 then
		if TimeNum<=6 or TimeNum >=18 then
			SystemNotice (dead , "Blessed by Death. No death penalty upon character death" ) 
			return
		end
	end
	local exp_red 
	local exp = Exp(dead) 
	local nlexp = GetChaAttrI ( dead , ATTR_NLEXP ) 
	local clexp = GetChaAttrI ( dead , ATTR_CLEXP ) 
	if  exp <= clexp then 
		exp_red = 0 
	else 
		exp_red = math.min ( math.floor ( ( nlexp - clexp ) * 0.02 ) , math.max ( exp - clexp , 0 ) ) 
	end 
	SetCharaAttr(0, dead, ATTR_SP) 
	local i1 = CheckBagItem( dead,3846 )
	local i2 = CheckBagItem( dead,3047 )
	local i3 = CheckBagItem( dead,5609 )                                      ---------------------------------��������kokora

	if map_name == "secretgarden" or map_name == "teampk" then
	SetCharaAttr(0, dead, ATTR_SP)
		return
	end
	
	local i= CheckBagItem( dead, 2954 )-------����֤��
	--SystemNotice( dead , "i=="..i)
	if i==1 then
		local Dead_BK = GetChaItem2 ( dead , 2 , 2954 )
		local DeadPoint=GetItemAttr ( Dead_BK , ITEMATTR_VAL_STR)
			--SystemNotice( dead , "DeadPoint֮ǰΪ=="..DeadPoint)

		local DeadPoint=DeadPoint+1
			SetItemAttr( Dead_BK , ITEMATTR_VAL_STR , DeadPoint )
				local DeadPoint1=GetItemAttr ( Dead_BK , ITEMATTR_VAL_STR)
				--SystemNotice( dead , "DeadPoint����Ϊ=="..DeadPoint1)

		if DeadPoint>=100 then
		end
	end

	if i1 <= 0 and i2 <= 0 and  i3 <= 0 then ---û����û����û��������kokora
		exp = Exp(dead) - exp_red 
		if Lv ( dead ) >= 80 then 
			exp_red_80 = exp_red * 50 
			SystemNotice (dead , "Death penalty. EXP lost:"..exp_red_80 ) 
		else 
			SystemNotice (dead , "Death penalty. EXP lost:"..exp_red ) 
		end 
		SetChaAttrI( dead , ATTR_CEXP , exp ) --[[�۳�����������ڼ������2��]]--
		if lv > 20 then
			Dead_Punish_ItemURE ( dead )
		end
	
	elseif i1~=0 and i2==0 and  i3==0 then --������û����û��������kokora
		local j1 = TakeItem( dead,0,3846,1)
		if j1 == 0  then
			LG ( "NewItem" , "Voodoo Doll deletion failed" )
			SystemNotice ( dead , "Voodoo Doll deletion failed" )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				SystemNotice (dead , "Death penalty. EXP lost:"..exp_red_80 ) 
			else 
				SystemNotice (dead , "Death penalty. EXP lost:"..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[�۳�����������ڼ������2��]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			SystemNotice ( dead , "Voodoo Doll replace death penalty" )
		end
	elseif i2~=0 and  i1==0 and i3==0  then --�б���û����û��������kokora
		local j2 = TakeItem( dead,0,3047,1)
		if j2 == 0  then
			LG ( "NewItem" , "Voodoo Doll deletion failed" )
			SystemNotice ( dead , "Voodoo Doll deletion failed" )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				SystemNotice (dead , "Death penalty. EXP lost:"..exp_red_80 ) 
			else 
				SystemNotice (dead , "Death penalty. EXP lost:"..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[�۳�����������ڼ������2��]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			SystemNotice ( dead , "Voodoo Doll replace death penalty" )
		end
	elseif i3~=0 and i1==0 and  i2==0  then --����������û����û����kokora
		local j2 = TakeItem( dead,0,5609,1)
		if j2 == 0  then
			LG ( "NewItem" , "��������ɾ��ʧ��" )
			SystemNotice ( dead , "��������ɾ��ʧ��" )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				SystemNotice (dead , "����������ʧ����"..exp_red_80 ) 
			else 
				SystemNotice (dead , "����������ʧ����"..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[�۳�����������ڼ������2��]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			SystemNotice ( dead , "���������ƴ�������,���辭����;óͷ�" )
		end
	elseif i1~=0 and i2~=0 and  i3==0 then --�������б���û��������kokora ��ɾ������
		local j1 = TakeItem( dead,0,3846,1)
		if j1 == 0  then
			LG ( "NewItem" , "Voodoo Doll deletion failed" )
			SystemNotice ( dead , "Voodoo Doll deletion failed" )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				SystemNotice (dead , "Death penalty. EXP lost:"..exp_red_80 ) 
			else 
				SystemNotice (dead , "Death penalty. EXP lost:"..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[�۳�����������ڼ������2��]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			SystemNotice ( dead , "Voodoo Doll replace death penalty" )
		end
	elseif i2~=0 and  i3~=0 and i1==0  then --�б�������������û����kokora��ɾ������
		local j2 = TakeItem( dead,0,3047,1)
		if j2 == 0  then
			LG ( "NewItem" , "Voodoo Doll deletion failed" )
			SystemNotice ( dead , "Voodoo Doll deletion failed" )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				SystemNotice (dead , "Death penalty. EXP lost:"..exp_red_80 ) 
			else 
				SystemNotice (dead , "Death penalty. EXP lost:"..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[�۳�����������ڼ������2��]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			SystemNotice ( dead , "Voodoo Doll replace death penalty" )
		end
	elseif i1~=0 and i3~=0 and  i2==0 then --����������������û����kokora ��ɾ������
		local j1 = TakeItem( dead,0,3846,1)
		if j1 == 0  then
			LG ( "NewItem" , "Voodoo Doll deletion failed" )
			SystemNotice ( dead , "Voodoo Doll deletion failed" )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				SystemNotice (dead , "Death penalty. EXP lost:"..exp_red_80 ) 
			else 
				SystemNotice (dead , "Death penalty. EXP lost:"..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[�۳�����������ڼ������2��]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			SystemNotice ( dead , "Voodoo Doll replace death penalty" )
		end
	elseif i1~=0 and i2~=0 and  i3~=0 then --�����������������б���kokora ��ɾ������
		local j1 = TakeItem( dead,0,3846,1)
		if j1 == 0  then
			LG ( "NewItem" , "Voodoo Doll deletion failed" )
			SystemNotice ( dead , "Voodoo Doll deletion failed" )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				SystemNotice (dead , "Death penalty. EXP lost:"..exp_red_80 ) 
			else 
				SystemNotice (dead , "Death penalty. EXP lost:"..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[�۳�����������ڼ������2��]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			SystemNotice ( dead , "Voodoo Doll replace death penalty" )
		end
	end
	
	local name = GetChaDefaultName ( dead )
	local exp_new = ( exp - clexp ) / ( nlexp - clexp )
	
	LG ( "die_exp" , "Character Name" , name , "Current Lv= ", lv , "Death EXP penalty= " , exp_red , "Newest EXP proportion= " , exp_new )

	local mars = 0
	for mars = 0 , 4 , 1 do
		if name == CheckDmgChaNameTest [mars] then
			LG ( "whydie" , name.."Hang" )
		end
	end
end 


function GetExp_MKP(dead , atk) --[[player kill monster ����ֵ�ı乫ʽ]]-- 
	--LuaPrint("Enter function GetExp_MKP() --[[player kill monster ����ֵ�ı乫ʽ]]--") 
	Dead_Punish( dead , atk) 
	--LuaPrint("Out function GetExp_MKP() --[[player kill monster ����ֵ�ı乫ʽ]]--") 
end 

function GetExp_PKP(dead , atk) --[[player kill player ����ֵ�ı乫ʽ]]-- 
	--LuaPrint("Enter function GetExp_MKP() --[[player kill monster ����ֵ�ı乫ʽ]]--") 
--	Dead_Punish( dead , atk) 
	--LuaPrint("Out function GetExp_MKP() --[[player kill monster ����ֵ�ı乫ʽ]]--") 
end 

function GetExp_Noexp(dead , atk) --[[�޽��;���ֵ�ı乫ʽ]]-- 
	--LuaPrint("Enter function GetExp_Noexp() --[[�޽��;���ֵ�ı乫ʽ]]-- ".."\n" ) 
	--LuaPrint("Out function GetExp_Noexp() --[[�޽��;���ֵ�ı乫ʽ]]-- ".."\n" ) 
end 





--��ɫ�Ǽ����Ը���ű�����������������������������������������������������������������������������������������

function Relive ( role )							
	local mxhp = GetChaAttr ( role , ATTR_MXHP ) 
	local mxsp = GetChaAttr ( role , ATTR_MXSP ) 
	local hp = math.max ( 1, math.floor(  ( mxhp * 0.01 ) + 0.5 ) ) 
	local sp = math.max ( 1, math.floor(  ( mxsp * 0.01 ) + 0.5 ) ) 
	SetCharaAttr ( hp , role , ATTR_HP ) 
	SetCharaAttr ( sp , role , ATTR_SP ) 
end 

--��ɫ�����Ը���ű�����������������������������������������������������������������������������������������

function Relive_now ( role , sklv ) 
	local cha_role = TurnToCha ( role ) 
	local hp = math.max ( 1 , math.floor ( 0.05 * sklv * Mxhp ( cha_role ) ) ) 
	local sp = math.max ( 1 , math.floor ( 0.05 * sklv * Mxsp ( cha_role ) ) ) 
	SetCharaAttr ( hp , cha_role , ATTR_HP ) 
	SetCharaAttr ( sp , cha_role , ATTR_SP ) 
end 




--��ֻ��������;ü��١���������������������������������������������������������������������������������������������������������������������������

function   Ship_ShipDieAttr ( role ) 
	local bmxhp = GetChaAttr ( role , ATTR_BMXHP ) 
	local dead_count = GetChaAttr ( role , ATTR_BOAT_DIECOUNT ) 
	LG ( "shipmxhp" , "___a new dead ship_____________________________________________________" ) 
	LG ( "shipmxhp" , "role = " , role ,  "dead_count = " , dead_count , "form_mxhp = " , bmxhp ) 
	bmxhp = bmxhp * math.max ( 0 , ( 1 - 0.02 - dead_count * 0.01 )  ) 
	LG ( "shipmxhp" , "role = " , role ,   "now_mxhp = " , bmxhp ) 
	SetCharaAttr ( bmxhp , role , ATTR_BMXHP ) 
end  


function BoatLevelUpProc ( cha, boat, levelup, exp, money ) 
	if ValidCha( cha ) == 0 then 
		LG ( "luascript_err" , "function BoatLevelUpProc : cha as null" ) 
		return 0 
	end 
	if ValidCha( boat ) == 0 then 
		LG ( "luascript_err" , "function BoatLevelUpProc : boat as null" ) 
		return 0 
	end 
	PRINT( "BoatLevelUpProc: levelup = , exp = , money = ", levelup, exp, money )
	local lv_up	= levelup 
	local req_exp	= exp 
	local req_gold	= money 
	local boat_lv = GetChaAttr ( boat , ATTR_LV ) 
	if boat_lv ~= lv_up - 1 then 
		PRINT( "BoatLevelUpProc:function BoatLevelUpProc :ship current level and upgrade level does not match" )
		LG ( "luascript_err" , "function BoatLevelUpProc :ship current level and level to upgrade does not match" )
		return 0 
	end 

	local boat_exp = GetChaAttr ( boat , ATTR_CEXP ) 
	if boat_exp < req_exp then 
		SystemNotice ( cha , "Insufficient EXP to level up ship. Please try harder") 
		return 0 
	end 

	local cha_money = GetChaAttr ( cha , ATTR_GD ) 
	if cha_money < req_gold then 
		SystemNotice ( cha , "Insufficient gold to level up ship. Please try harder") 
		return 0 
	end 
	PRINT( "BoatLevelUpProc: boat_exp, req_exp, cha_money, req_gold", boat_exp, req_exp, cha_money, req_gold )
	SetAttrChangeFlag( boat)	
	SetAttrChangeFlag( cha)	

	boat_exp = boat_exp - req_exp 
	SetCharaAttr ( boat_exp , boat , ATTR_CEXP ) 
	cha_money = cha_money - req_gold 	
	SetCharaAttr ( cha_money , cha , ATTR_GD ) 
	SetCharaAttr ( lv_up , boat , ATTR_LV ) 
	ALLExAttrSet ( boat ) 
	SystemNotice ( cha , "Ship level up successfully") 
	SystemNotice ( cha , "Gold Deducted"..req_gold) 
	SystemNotice ( cha , "Consume experience: "..req_exp) 
	SyncBoat ( boat, 4 )
	SyncChar ( cha, 4 )
	PRINT( "BoarLevelUpProc: return 1" )
	return 1 

end 




function Ship_Tran (  buyer , boat ) 
	local ship_lv = GetChaAttr ( boat , ATTR_LV ) 
	local ship_exp = GetChaAttr ( boat , ATTR_CEXP ) 
--	if ValidCha ( seller ) == 0 then 
--		LG ( "luascript_err"  , "function Ship_Tran : seller Ϊ��"  ) 
--		return 
--	end 
--	if ValidCha ( buyer ) == 0 then 
--		LG ( "luascript_err"  , "function Ship_Tran : buyer Ϊ��"  ) 
--		return 
--	end 
	SetAttrChangeFlag( boat)	

	ship_lv = math.max ( 1 , math.max (math.floor ( ship_lv /2 ), ship_lv - 10 ) )  
	ship_exp = 0 
	SetCharaAttr ( ship_exp , boat , ATTR_CEXP ) 
	SetCharaAttr ( ship_lv , boat , ATTR_LV ) 
	SystemNotice ( buyer , "After trade, ship level becomes "..ship_lv )	
	SystemNotice ( buyer , "After trade, ship experience reduced to "..ship_exp )	 

	SyncBoat ( boat, 4 )
end 


--����һ��
function CheckLuckyFinish ( StateLv )
	if StateLv == 3 then
		local Huge_Lucky = Percentage_Random ( 0.01 )
		if Huge_Lucky == 1 then
			return 2
		end
	end
	
	local a = 0.1
	local b = Percentage_Random ( a )
	return b
end