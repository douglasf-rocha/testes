print('Loading itemuse.lua')

do
	if not IsItemEquipment then
		weap_t = {}
		weap_t[09] = true -- Staff
		weap_t[02] = true -- Hammer
		weap_t[07] = true -- Dagger
		weap_t[04] = true -- Gun
		weap_t[03] = true -- Bow
		weap_t[01] = true -- Sword
		weap_t[11] = true -- Shield
		eqpt_t = {}
		eqpt_t[22] = true
		eqpt_t[23] = true
		eqpt_t[24] = true
		eqpt_t[27] = true
		eqpt_t[20] = true

		function IsItemWeapon(item) return weap_t[GetItemType(item)] or false end
		function IsItemArmor(item) return eqpt_t[GetItemType(item)] or false end
		function IsItemEquipment(item) return IsItemWeapon(item) or IsItemArmor(item) end
	end
end

ITEM_MAX_DELEVEL = 5

-- item deleveling hamemr
function ItemUse_DelevlEq(role, Item, Item_Traget)
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		SystemNotice( role , "Inventory has been binded")
		return
	end
	local isboat = 0
	isboat = GetCtrlBoat(role)
	if isboat ~= nil then
		SystemNotice(role, "Cannot use while sailing")
		UseItemFailed(role)
		return
	end
	-- check itemtype
	local isequip = IsItemEquipment(Item_Traget)
	if not isequip then
		SystemNotice(role, "Can only be used on equipments!")
		UseItemFailed(role)
		return
	end
	local originalLv = GetItemOriginalLv(Item_Traget)
	local currentLv = GetItemLv(Item_Traget)
	if currentLv <= (originalLv - ITEM_MAX_DELEVEL) then
		SystemNotice(role, "Target equipment has already been deleveled "..ITEM_MAX_DELEVEL.." times!")
		UseItemFailed(role)
		return
	end
	if currentLv <= 1 then
		SystemNotice(role, "Target equipment cannot be deleveled any further!")
		UseItemFailed(role)
		return
	end
	local newLv = currentLv-1
	SetItemLv(Item_Traget, newLv)
	BickerNotice(role, "Level of "..GetItemName(GetItemID(Item_Traget)).." was decreased to "..newLv.."!")
	PlayEffect(role, 345)
	
	SynChaKitbag(role, 13)
	SetChaKitbagChange( role , 1 )
	--SynChaKitbag(role, 4)
end


apparelConverterTable = {
	[1] = 5291,--1h sword
	[2] = 5292,--2h sword
	[3] = 5296,--bow
	[4] = 5293,--gun
	[7] = 5295, --dagger
	[9] = 5294, --staff
	[11] = 5297, --shield
	[20] = 5287, --helm
	[22] = 5288, --armour
	[23] = 5289, --glove
	[24] = 5290, --boot
	[27] = 5288, --tatoo
}
function ApparelConverter(role,item,target)
	if not target or GetItemAttr(target,ITEMATTR_MAXURE) == 25000 then
		return UseItemFailed(role)
	end
	local itemType = GetItemType(target)
	if apparelConverterTable[itemType] then
		local ID = GetItemID(target)
		for i = 0,47 do
			local item2 = GetChaItem(role,2,i)
			if item2 == target then
				RemoveChaItem ( role , GetItemID(target) , 1 , 2 , i , 2 , 1 , 0)
				break
			end
		end
		local appTab = {
			ID = apparelConverterTable[itemType],
			Quantity = 1,
			MaxDurability = 25000,
			Durability = 25000,
			FuseID = ID,
		}
		AddItem(role,appTab)
	else
		SystemNotice(role,"Invalid equipment.")
		return UseItemFailed(role)
	end
end
function Pot_Pack(role, Item )
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 3 then
		SystemNotice(role ,"You need at least 2 empty inventory slots to open the Potion Pack")
		UseItemFailed ( role )
		return
	end

	local rand = math.random(1,5)
	if rand == 1 then
		GiveItem ( role , 0 , 1148 , 2 , 4 )
	elseif rand == 2 then
		GiveItem ( role , 0 , 2732 , 2 , 4 )
	elseif rand == 3 then
		GiveItem ( role , 0 , 1136 , 2 , 4 )
	elseif rand == 4 then
		GiveItem ( role , 0 , 2720 , 2 , 4 )
	elseif rand == 5 then
		GiveItem ( role , 0 , 1860 , 2 , 4 )
	end	
end
function HeavenTreasure(role, Item )
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 6 then
		SystemNotice(role ,"You need at least 6 empty inventory slots to open the Heaven Treasure")
		UseItemFailed ( role )
		return
	end
	GiveItem ( role , 0 , 2235 , 1 , 4 )
	GiveItem ( role , 0 , 864 , 1 , 101 )
	GiveItem ( role , 0 , 865 , 1 , 101 )
	GiveItem ( role , 0 , 866 , 1 , 101 )
	local rand = math.random(1,4)
	if rand == 1 then
		GiveItem ( role , 0 , 15973 , 1 , 4 )
	elseif rand == 2 then
		GiveItem ( role , 0 , 15974 , 1 , 4 )
	elseif rand == 3 then
		GiveItem ( role , 0 , 15975 , 1 , 4 )
	elseif rand == 4 then
		GiveItem ( role , 0 , 15976 , 1 , 4 )
	end
end
-- Fairy Box
function ItemUse_fairybox( role , Item )
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	 if Item_CanGet < 3 then
		SystemNotice(role ,"You need at least 3 empty inventory slots to open the Fairy Coin Chest")
		UseItemFailed ( role )
		return
	end
	
--	local master1 =TakeItem( role, 0,0855, 99 )				--Iteminfo ID of Fairy Coins
--	if master1==0 then
--		SystemNotice ( role ,"You  don't have 99x Fairy Coins, unable to Open this Chest")
--		return 0
--	end
	
--	GiveItem ( role , 0 , 2610 , 1 , 4 )
	local rad = math.random ( 1, 25 )
	if rad ==1 then
		GiveItem ( role , 0 , 0227 , 2 , 4 )
	end
	if rad ==2 then
		GiveItem ( role , 0 , 0227 , 3 , 4 )
	end
	if rad ==3 then
		GiveItem ( role , 0 , 885 , 1 , 4 )
	end
	if rad ==4 then
		GiveItem ( role , 0 , 1128 , 1 , 4 )
	end
	if rad ==5 then
		GiveItem ( role , 0 , 1128 , 2 , 4 )
	end
	if rad ==6 then
		GiveItem ( role , 0 , 3844 , 1 , 4 )
	end
	if rad ==7 then
		GiveItem ( role , 0 , 3845 , 1 , 4 )
	end
	if rad ==8 then
		GiveItem ( role , 0 , 3846 , 1 , 4 )
	end
	if rad ==9 then
		GiveItem ( role , 0 , 3837 , 1 , 4 )
	end
	if rad ==10 then
		GiveItem ( role , 0 , 3836 , 1 , 4 )
	end
	if rad ==11 then
		GiveItem ( role , 0 , 3835 , 1 , 4 )
	end
	if rad ==12 then
		GiveItem ( role , 0 , 3832 , 1 , 4 )
	end
	if rad ==13 then
		GiveItem ( role , 0 , 3833 , 1 , 4 )
	end
	if rad ==14 then
		GiveItem ( role , 0 , 3831 , 1 , 4 )
	end
	if rad ==15 then
		GiveItem ( role , 0 , 3832 , 1 , 4 )
	end
	if rad ==16 then
		GiveItem ( role , 0 , 3830 , 1 , 4 )
	end
	if rad ==17 then
		GiveItem ( role , 0 , 3829 , 1 , 4 )
	end
	if rad ==18 then
		GiveItem ( role , 0 , 3828 , 1 , 4 )
	end
	if rad ==19 then
		GiveItem ( role , 0 , 3847 , 1 , 4 )
	end
	if rad ==20 then
		GiveItem ( role , 0 , 0332 , 1 , 4 )
	end
	if rad ==21 then
		GiveItem ( role , 0 , 0563 , 1 , 4 )
	end
	if rad ==22 then
		GiveItem ( role , 0 , 2445 , 1 , 4 )
	end
	if rad ==23 then
		GiveItem ( role , 0 , 2447 , 1 , 4 )
	end
	if rad ==24 then
		GiveItem ( role , 0 , 2491 , 1 , 4 )
	end
	if rad ==25 then
		GiveItem ( role , 0 , 3141 , 3 , 4 )
	end
	
end

-- Chaos Chest
-- edits: added Chaos Crownstone
function ItemUse_FightingBox( role , Item )
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	 if Item_CanGet < 2 then
		SystemNotice(role ,"You need at least 2 empty inventory slots to open the Chaos Chest")
		UseItemFailed ( role )
		return
	end
	GiveItem ( role , 0 , 2610 , 1 , 4 )
	local rad = math.random ( 1, 3 )
	if rad ==1 then
		GiveItem ( role , 0 , 1124 , 1 , 15 )
	end
	if rad ==2 then
		GiveItem ( role , 0 , 1125 , 1 , 15 )
	end
	if rad ==3 then
		GiveItem ( role , 0 , 1126 , 1 , 15 )
	end
--	if rad ==4 then
--		GiveItem ( role , 0 , 1127 , 1 , 15 )
--	end
end

-- skill reset book
function ItemUse_XiDianBook ( role , item )
	local zsskill_lv = {}
	 zsskill_lv [0] = GetSkillLv ( role, 453 )
	 zsskill_lv [1] = GetSkillLv ( role, 454 )
	 zsskill_lv [2] = GetSkillLv ( role, 455 )
	 zsskill_lv [3] = GetSkillLv ( role, 456 )
	 zsskill_lv [4] = GetSkillLv ( role, 457 )
	 zsskill_lv [5] = GetSkillLv ( role, 458 )
	local n = 0
	local item_canget = GetChaFreeBagGridNum ( role )
	if item_canget < 2 then
		SystemNotice(role ,"You need to have at least 2 empty inventory slot")
		UseItemFailed ( role )
	else
		for i = 0, 5, 1 do
			if zsskill_lv [i] >= 1 then
				n = n+1
			end
		end
		local cha_skill_num=GetChaAttr(role, ATTR_TP )
		local clear_skill_num=ClearFightSkill(role)
		cha_skill_num=cha_skill_num+clear_skill_num
		if n > 0 then
			local job = GetChaAttr( role, ATTR_JOB)
			local item_id = {}
			item_id [8] = 2957
			item_id [9] = 2956
			item_id [12] = 2961
			item_id [13] = 2959
			item_id [14] = 2958
			item_id [16] = 2960
			GiveItem ( role, 0, item_id [job] , 1, 4)
			--GiveItem ( role, 0, 15860, 1, 4)
			cha_skill_num = cha_skill_num - 2
		end
		SetChaAttr(role, ATTR_TP ,cha_skill_num ) 
	end
end

function ItemUse_TLHFJA( role , Item )
	local map = GetChaMapName(role)
	if map == 'garner2' then
		SystemNotice(role ,"Cannot be used in Chaos Argent")
		UseItemFailed ( role )
	end
	local hp = GetChaAttr(role, ATTR_HP) 
	hp_resume = 1000 
	
	hp = hp + hp_resume 
	mxhp = GetChaAttr(role,ATTR_MXHP) 
	if hp > mxhp then
		hp = mxhp 
	end 
	SetCharaAttr(hp, role, ATTR_HP)
end

function ItemUse_TMLGZA( role , Item ) 
	local map = GetChaMapName(role)
	if map == 'garner2' then
		SystemNotice(role ,"Cannot be used in Chaos Argent")
		UseItemFailed ( role )
	end
	local sp = GetChaAttr(role, ATTR_SP) 
	sp_resume = 150 
	
	sp = sp + sp_resume 
	mxsp = GetChaAttr(role,ATTR_MXSP) 
	if sp > mxsp then
		sp = mxsp 
	end 
	SetCharaAttr(sp, role, ATTR_SP) 
end

function ItemUse_NoExp(role, item)
	local on = GetItemAttr(item, 55);
	local itemname = GetItemName(GetItemID(item))
	if on == 1 then
		SystemNotice(role, itemname..' grants you full EXP!')
		SetItemAttr(item, 55, 0)
	else
		SystemNotice(role, itemname..' grats you zero EXP!')
		SetItemAttr(item, 55, 1)
	end
	SynChaKitbag(role, 13)
end

function ItemUse_CZBox ( role , Item )
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 4 then
		SystemNotice(role ,"To open a Aries Apparel Chest requires at least 4 empty inventory slots")
		UseItemFailed ( role )
		return
	end
	GiveItem ( role , 0 , 5525  , 1 , 4 )
	GiveItem ( role , 0 , 5526  , 1 , 4 )
	GiveItem ( role , 0 , 5527  , 1 , 4 )
	--GiveItem ( role , 0 , 5528  , 1 , 4 )
	local cha_type = GetChaTypeID ( role ) 
	if cha_type == 4 then
		GiveItem(role, 0, 5528, 1, 4)
	end
end

function ItemUse_JNCZBox ( role , Item )
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	 if Item_CanGet < 4 then
		SystemNotice(role ,"You need at least 4 space to use the Taurus Apparel Chest")
		UseItemFailed ( role )
		return
	end
	--GiveItem ( role , 0 , 5529  , 1 , 4 )
	GiveItem ( role , 0 , 5530  , 1 , 4 )
	GiveItem ( role , 0 , 5531  , 1 , 4 )
	GiveItem ( role , 0 , 5532  , 1 , 4 )
	
	local cha_type = GetChaTypeID ( role ) 
	if cha_type == 4 then
		GiveItem(role, 0, 5529, 1, 4)
	end
end
function ItemUse_randomappch(role, Item)
	local cha_name = GetChaDefaultName(role)
	local ChaBoat = 0
	ChaBoat = GetCtrlBoat(role)
	if(ChaBoat ~= nil)then
		SystemNotice(role, "Cannot use while sailing")
		UseItemFailed(role)
		return
	end
	local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 5)then
		SystemNotice(role, "Requires 5 empty slots to open!")
		UseItemFailed(role)
		return
	end
	local item = {}
	item[1] = {5755,5756,5757,5758};
	item[2] = {5772,5773,5774,5775};
	item[3] = {5792,5793,5794,5795};
	item[4] = {5803,5804,5805,5806};
	item[5] = {6500,6501,6502};
	item[6] = {6526,6527,6528,6529};
	item[7] = {6536};
	item[8] = {6632,6633};
	item[9] = {5589,5590,5591,5592};
	item[10] = {5577,5578,5579,5580};
	item[11] = {5581,5582,5583,5584};
	item[12] = {5605,5606,5607,5608};
	item[13] = {5731,5732,5733};
	item[14] = {5723,5724,5725,5726};
	item[15] = {5745,5746,5747,5748};
	item[16] = {5751,5752,5753,5754};
	item[17] = {5777,5778,5779};
	item[18] = {5384,5385,5386};
	item[19] = {6661,6662,6663};
	item[20] = {5557};
	item[21] = {5465,5466,5467};
	item[22] = {9532};
	item[23] = {9533};
	item[24] = {9533};
	item[25] = {9535};
	item[26] = {9536};
	item[27] = {9537};
	item[28] = {9538};
	item[29] = {9539};
	item[30] = {9540};
	item[31] = {5283};
	item[32] = {5315};
	item[33] = {5316};
	item[34] = {5317};
	item[35] = {5318};
	item[36] = {5319};
	item[37] = {5320};
	item[38] = {5322};
	item[39] = {5285};
	item[40] = {5081};
	item[41] = {5071};
	item[42] = {5072};
	item[43] = {5005};
	item[44] = {5014};
	item[45] = {5006};
	item[46] = {5024};
	item[47] = {5025};
	item[48] = {5026};
	item[49] = {5027};
	item[50] = {5028};
	item[51] = {5029};
	item[52] = {5284};
	local randomapp = math.random(1,52);
	if table.getn(item[randomapp]) > 1 then
		for i=1, table.getn(item[randomapp]) do
			GiveItem(role, 0, item[randomapp][i], 1, 4);
			LG('RandomAppChest',''..cha_name..' opened RandomAppChest and obtained 1x '..GetItemName(item[randomapp][i])..'!')
		end
	else
		GiveItem(role, 0, item[randomapp][1], 1, 4);
		LG('RandomAppChest',''..cha_name..' opened RandomAppChest and obtained 1x '..GetItemName(item[randomapp][1])..'!')
	end	
end
------Random Free Apparels----
function ItemUse_RandomFreeApps( role , Item )
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 
	local cha_name = GetChaDefaultName ( role )	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	
	 if Item_CanGet < 5 then
		SystemNotice(role ,"Inventory requires at least 5 empty slots to use Random Apparel Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random ( 1, 5 )
	if rad ==1 then --
	GiveItem ( role , 0 , 5525  , 1 , 4 )		
	GiveItem ( role , 0 , 5526  , 1 , 4 )		
	GiveItem ( role , 0 , 5527  , 1 , 4 )		
	GiveItem ( role , 0 , 5528  , 1 , 4 )		
	LG('Random Apparel',''..cha_name..' has opened Random Apparel Chest and obtained 1x '..GetItemName(5525)..'!')
	end
	if rad ==2 then --
	GiveItem ( role , 0 , 5529  , 1 , 4 )
	GiveItem ( role , 0 , 5530  , 1 , 4 )
	GiveItem ( role , 0 , 5531  , 1 , 4 )
	GiveItem ( role , 0 , 5532  , 1 , 4 )
	LG('Random Apparel',''..cha_name..' has opened Random Apparel Chest and obtained 1x '..GetItemName(5529)..'!')
	end
	if rad ==3 then --
	GiveItem ( role , 0 , 5533  , 1 , 4 )
	GiveItem ( role , 0 , 5534  , 1 , 4 )
	GiveItem ( role , 0 , 5535  , 1 , 4 )
	GiveItem ( role , 0 , 5536  , 1 , 4 )
	LG('Random Apparel',''..cha_name..' has opened Random Apparel Chest and obtained 1x '..GetItemName(5533)..'!')
	end
	if rad ==4 then --
	GiveItem ( role , 0 , 5553  , 1 , 4 )
	GiveItem ( role , 0 , 5554  , 1 , 4 )
	GiveItem ( role , 0 , 5555  , 1 , 4 )
	GiveItem ( role , 0 , 5556  , 1 , 4 )
	LG('Random Apparel',''..cha_name..' has opened Random Apparel Chest and obtained 1x '..GetItemName(5553)..'!')
	end
	if rad ==5 then --
	GiveItem ( role , 0 , 5569  , 1 , 4)	
	GiveItem ( role , 0 , 5570  , 1 , 4)	
	GiveItem ( role , 0 , 5571  , 1 , 4)	
	GiveItem ( role , 0 , 5572  , 1 , 4)	
	LG('Random Apparel',''..cha_name..' has opened Random Apparel Chest and obtained 1x '..GetItemName(5569)..'!')	
	end
end

------Random Broken/Cracked/Chipped/UG Gems----
function ItemUse_BrokenGem( role , Item )
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 
	local cha_name = GetChaDefaultName ( role )	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	
	 if Item_CanGet < 2 then
		SystemNotice(role ,"Inventory requires at least 2 empty slots to use Random Broken Gem Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random ( 1, 5 )
	if rad ==1 then --Striking
	GiveItem ( role , 0 , 6820  , 1 , 4 )		
	LG('Random Broken',''..cha_name..' has opened Random Broken Gem Chest and obtained 1x '..GetItemName(6820)..'!')
	end
	if rad ==2 then --Soul
	GiveItem ( role , 0 , 6829  , 1 , 4 )
	LG('Random Broken',''..cha_name..' has opened Random Broken Gem Chest and obtained 1x '..GetItemName(6829)..'!')
	end
	if rad ==3 then --Colo
	GiveItem ( role , 0 , 6823  , 1 , 4 )
	LG('Random Broken',''..cha_name..' has opened Random Broken Gem Chest and obtained 1x '..GetItemName(6823)..'!')
	end
	if rad ==4 then --Wind
	GiveItem ( role , 0 , 6817  , 1 , 4 )
	LG('Random Broken',''..cha_name..' has opened Random Broken Gem Chest and obtained 1x '..GetItemName(6817)..'!')
	end
	if rad ==5 then --Rage
	GiveItem ( role , 0 , 6826  , 1 , 4)	
	LG('Random Broken',''..cha_name..' has opened Random Broken Gem Chest and obtained 1x '..GetItemName(6826)..'!')	
	end
end

function ItemUse_CrackedGem( role , Item )
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 
	local cha_name = GetChaDefaultName ( role )	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	
	 if Item_CanGet < 2 then
		SystemNotice(role ,"Inventory requires at least 2 empty slots to use Random Cracked Gem Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random ( 1, 8 )
	if rad ==1 then --Striking
	GiveItem ( role , 0 , 6821  , 1 , 4 )		
	LG('Random Cracked',''..cha_name..' has opened Random Cracked Gem Chest and obtained 1x '..GetItemName(6821)..'!')
	end
	if rad ==2 then --Soul
	GiveItem ( role , 0 , 6830  , 1 , 4 )
	LG('Random Cracked',''..cha_name..' has opened Random Cracked Gem Chest and obtained 1x '..GetItemName(6830)..'!')
	end
	if rad ==3 then --Colo
	GiveItem ( role , 0 , 6824  , 1 , 4 )
	LG('Random Cracked',''..cha_name..' has opened Random Cracked Gem Chest and obtained 1x '..GetItemName(6824)..'!')
	end
	if rad ==4 then --Wind
	GiveItem ( role , 0 , 6818  , 1 , 4 )
	LG('Random Cracked',''..cha_name..' has opened Random Cracked Gem Chest and obtained 1x '..GetItemName(6818)..'!')
	end
	if rad ==5 then --Rage
	GiveItem ( role , 0 , 6827  , 1 , 4)	
	LG('Random Cracked',''..cha_name..' has opened Random Cracked Gem Chest and obtained 1x '..GetItemName(6827)..'!')	
	end
	if rad ==6 then --Soul
	GiveItem ( role , 0 , 6830  , 1 , 4 )
	LG('Random Cracked',''..cha_name..' has opened Random Cracked Gem Chest and obtained 1x '..GetItemName(6830)..'!')
	end
	if rad ==7 then --Wind
	GiveItem ( role , 0 , 6818  , 1 , 4 )
	LG('Random Cracked',''..cha_name..' has opened Random Cracked Gem Chest and obtained 1x '..GetItemName(6818)..'!')
	end
	if rad ==8 then --Striking
	GiveItem ( role , 0 , 6821  , 1 , 4 )		
	LG('Random Cracked',''..cha_name..' has opened Random Cracked Gem Chest and obtained 1x '..GetItemName(6821)..'!')
	end
end

function ItemUse_ChippedGem( role , Item )
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 
	local cha_name = GetChaDefaultName ( role )	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	
	 if Item_CanGet < 2 then
		SystemNotice(role ,"Inventory requires at least 2 empty slots to use Random Chipped Gem Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random ( 1, 8 )
	if rad ==1 then --Striking
	GiveItem ( role , 0 , 6822  , 1 , 4 )		
	LG('Random Chipped',''..cha_name..' has opened Random Chipped Gem Chest and obtained 1x '..GetItemName(6822)..'!')
	end
	if rad ==2 then --Rage
	GiveItem ( role , 0 , 6828  , 1 , 4)	
	LG('Random Chipped',''..cha_name..' has opened Random Chipped Gem Chest and obtained 1x '..GetItemName(6828)..'!')	
	end
	if rad ==3 then --Wind
	GiveItem ( role , 0 , 6819  , 1 , 4 )
	LG('Random Chipped',''..cha_name..' has opened Random Chipped Gem Chest and obtained 1x '..GetItemName(6819)..'!')
	end
	if rad ==4 then --Soul
	GiveItem ( role , 0 , 6831  , 1 , 4 )
	LG('Random Chipped',''..cha_name..' has opened Random Chipped Gem Chest and obtained 1x '..GetItemName(6831)..'!')
	end
	if rad ==5 then --Colo
	GiveItem ( role , 0 , 6825  , 1 , 4 )
	LG('Random Chipped',''..cha_name..' has opened Random Chipped Gem Chest and obtained 1x '..GetItemName(6825)..'!')
	end
	if rad ==6 then --Wind
	GiveItem ( role , 0 , 6819  , 1 , 4 )
	LG('Random Chipped',''..cha_name..' has opened Random Chipped Gem Chest and obtained 1x '..GetItemName(6819)..'!')
	end
	if rad ==7 then --Soul
	GiveItem ( role , 0 , 6831  , 1 , 4 )
	LG('Random Chipped',''..cha_name..' has opened Random Chipped Gem Chest and obtained 1x '..GetItemName(6831)..'!')
	end
	if rad ==8 then --Striking
	GiveItem ( role , 0 , 6822  , 1 , 4 )		
	LG('Random Chipped',''..cha_name..' has opened Random Chipped Gem Chest and obtained 1x '..GetItemName(6822)..'!')
	end
end
function ItemUse_UniqueGem( role , Item )
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 
	local cha_name = GetChaDefaultName ( role )	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	
	 if Item_CanGet < 2 then
		SystemNotice(role ,"Inventory requires at least 2 empty slots to use Random Unique Gem Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random ( 1, 8 )
	if rad ==1 then --Striking
	GiveItem ( role , 0 , 0861  , 1 , 4 )		
	LG('Random Unique',''..cha_name..' has opened Random Unique Gem Chest and obtained 1x '..GetItemName(0861)..'!')
	end
	if rad ==2 then --Rage
	GiveItem ( role , 0 , 0863  , 1 , 4)	
	LG('Random Unique',''..cha_name..' has opened Random Unique Gem Chest and obtained 1x '..GetItemName(0863)..'!')	
	end
	if rad ==3 then --Wind
	GiveItem ( role , 0 , 0860  , 1 , 4 )
	LG('Random Unique',''..cha_name..' has opened Random Unique Gem Chest and obtained 1x '..GetItemName(0860)..'!')
	end
	if rad ==4 then --Soul
	GiveItem ( role , 0 , 1012  , 1 , 4 )
	LG('Random Unique',''..cha_name..' has opened Random Unique Gem Chest and obtained 1x '..GetItemName(1012)..'!')
	end
	if rad ==5 then --Wind
	GiveItem ( role , 0 , 0860  , 1 , 4 )
	LG('Random Unique',''..cha_name..' has opened Random Unique Gem Chest and obtained 1x '..GetItemName(0860)..'!')
	end
	if rad ==6 then --Colo
	GiveItem ( role , 0 , 0862  , 1 , 4 )
	LG('Random Unique',''..cha_name..' has opened Random Unique Gem Chest and obtained 1x '..GetItemName(0862)..'!')
	end
	if rad ==7 then --Soul
	GiveItem ( role , 0 , 1012  , 1 , 4 )
	LG('Random Unique',''..cha_name..' has opened Random Unique Gem Chest and obtained 1x '..GetItemName(1012)..'!')
	end
	if rad ==8 then --Striking
	GiveItem ( role , 0 , 0861  , 1 , 4 )		
	LG('Random Unique',''..cha_name..' has opened Random Unique Gem Chest and obtained 1x '..GetItemName(0861)..'!')
	end
end

--Achievements--
function ItemUse_Lv50 ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 3 then
		SystemNotice(role ,"Requires 4 slots in inventory to open Lv50 Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "Lv50 Reward Chest", cha_name,"opened [Lv50 Reward Chest] and got [50x Health Regenerator / 99x Cakes]")
	GiveItem ( cha , 0 , 11001 , 50 , 4 )
	GiveItem ( cha , 0 , 1849 , 99 , 4 )
	local rad = math.random ( 1, 5 )
	if rad ==1 then --Striking
	GiveItem ( role , 0 , 6820  , 1 , 4 )		
	LG('Lv50 Reward Chest',''..cha_name..' opened [Lv50 Reward Chest] and got 1x '..GetItemName(6820)..'!')
	end
	if rad ==2 then --Rage
	GiveItem ( role , 0 , 6826  , 1 , 4)	
	LG('Lv50 Reward Chest',''..cha_name..' opened [Lv50 Reward Chest] and got 1x '..GetItemName(6826)..'!')	
	end
	if rad ==3 then --Wind
	GiveItem ( role , 0 , 6817  , 1 , 4 )
	LG('Lv50 Reward Chest',''..cha_name..' opened [Lv50 Reward Chest] and got 1x '..GetItemName(6817)..'!')
	end
	if rad ==4 then --Soul
	GiveItem ( role , 0 , 6829  , 1 , 4 )
	LG('Lv50 Reward Chest',''..cha_name..' opened [Lv50 Reward Chest] and got 1x '..GetItemName(6829)..'!')
	end
	if rad ==5 then --Colo
	GiveItem ( role , 0 , 6823  , 1 , 4 )
	LG('Lv50 Reward Chest',''..cha_name..' opened [Lv50 Reward Chest] and got 1x '..GetItemName(6823)..'!')
	end
end

function ItemUse_Lv60 ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 3 then
		SystemNotice(role ,"Requires 4 slots in inventory to open Lv60 Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "Lv60 Reward Chest", cha_name,"opened [Lv60 Reward Chest] and got [99x Cakes]")
--	GiveItem ( cha , 0 , 11001 , 50 , 4 )
	GiveItem ( cha , 0 , 1849 , 99 , 4 )
	local rad = math.random ( 1, 5 )
	if rad ==1 then --Striking
	GiveItem ( role , 0 , 6820  , 1 , 4 )		
	LG('Lv60 Reward Chest',''..cha_name..' opened [Lv60 Reward Chest] and got 1x '..GetItemName(6820)..'!')
	end
	if rad ==2 then --Rage
	GiveItem ( role , 0 , 6826  , 1 , 4)	
	LG('Lv60 Reward Chest',''..cha_name..' opened [Lv60 Reward Chest] and got 1x '..GetItemName(6826)..'!')	
	end
	if rad ==3 then --Wind
	GiveItem ( role , 0 , 6817  , 1 , 4 )
	LG('Lv60 Reward Chest',''..cha_name..' opened [Lv60 Reward Chest] and got 1x '..GetItemName(6817)..'!')
	end
	if rad ==4 then --Soul
	GiveItem ( role , 0 , 6829  , 1 , 4 )
	LG('Lv60 Reward Chest',''..cha_name..' opened [Lv60 Reward Chest] and got 1x '..GetItemName(6829)..'!')
	end
	if rad ==5 then --Colo
	GiveItem ( role , 0 , 6823  , 1 , 4 )
	LG('Lv60 Reward Chest',''..cha_name..' opened [Lv60 Reward Chest] and got 1x '..GetItemName(6823)..'!')
	end
end

function ItemUse_Lv70 ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 3 then
		SystemNotice(role ,"Requires 4 slots in inventory to open Lv70 Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "Lv70 Reward Chest", cha_name,"opened [Lv70 Reward Chest] and got [99x Health Regenerator / 99x Cakes]")
	GiveItem ( cha , 0 , 11001 , 99 , 4 )
	GiveItem ( cha , 0 , 1849 , 99 , 4 )
	local rad = math.random ( 1, 5 )
	if rad ==1 then --Striking
	GiveItem ( role , 0 , 6820  , 1 , 4 )		
	LG('Lv70 Reward Chest',''..cha_name..' opened [Lv70 Reward Chest] and got 1x '..GetItemName(6820)..'!')
	end
	if rad ==2 then --Rage
	GiveItem ( role , 0 , 6826  , 1 , 4)	
	LG('Lv70 Reward Chest',''..cha_name..' opened [Lv70 Reward Chest] and got 1x '..GetItemName(6826)..'!')	
	end
	if rad ==3 then --Wind
	GiveItem ( role , 0 , 6817  , 1 , 4 )
	LG('Lv70 Reward Chest',''..cha_name..' opened [Lv70 Reward Chest] and got 1x '..GetItemName(6817)..'!')
	end
	if rad ==4 then --Soul
	GiveItem ( role , 0 , 6829  , 1 , 4 )
	LG('Lv70 Reward Chest',''..cha_name..' opened [Lv70 Reward Chest] and got 1x '..GetItemName(6829)..'!')
	end
	if rad ==5 then --Colo
	GiveItem ( role , 0 , 6823  , 1 , 4 )
	LG('Lv70 Reward Chest',''..cha_name..' opened [Lv70 Reward Chest] and got 1x '..GetItemName(6823)..'!')
	end
end

function ItemUse_Lv80 ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 4 then
		SystemNotice(role ,"Requires 5 slots in inventory to open Lv80 Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "Lv80 Reward Chest", cha_name,"opened [Lv80 Reward Chest] and got [99x Health Regenerator / 99x Cakes]")
	GiveItem ( cha , 0 , 11001 , 99 , 4 )
	GiveItem ( cha , 0 , 1849 , 99 , 4 )
	local rad = math.random ( 1, 5 )
	if rad ==1 then --Striking
	GiveItem ( role , 0 , 6820  , 1 , 4 )		
	LG('Lv80 Reward Chest',''..cha_name..' opened [Lv80 Reward Chest] and got 1x '..GetItemName(6820)..'!')
	end
	if rad ==2 then --Rage
	GiveItem ( role , 0 , 6826  , 1 , 4)	
	LG('Lv80 Reward Chest',''..cha_name..' opened [Lv80 Reward Chest] and got 1x '..GetItemName(6826)..'!')	
	end
	if rad ==3 then --Wind
	GiveItem ( role , 0 , 6817  , 1 , 4 )
	LG('Lv80 Reward Chest',''..cha_name..' opened [Lv80 Reward Chest] and got 1x '..GetItemName(6817)..'!')
	end
	if rad ==4 then --Soul
	GiveItem ( role , 0 , 6829  , 1 , 4 )
	LG('Lv80 Reward Chest',''..cha_name..' opened [Lv80 Reward Chest] and got 1x '..GetItemName(6829)..'!')
	end
	if rad ==5 then --Colo
	GiveItem ( role , 0 , 6823  , 1 , 4 )
	LG('Lv80 Reward Chest',''..cha_name..' opened [Lv80 Reward Chest] and got 1x '..GetItemName(6823)..'!')
	end
end

function ItemUse_1h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 1h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "1h Reward Chest", cha_name,"opened [1h Reward Chest] and got [5x Cakes]")
	GiveItem ( cha , 0 , 1849 , 5 , 4 )
end

function ItemUse_2h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 2h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "2h Reward Chest", cha_name,"opened [2h Reward Chest] and got [10x Cakes]")
	GiveItem ( cha , 0 , 1849 , 10 , 4 )
--[[	local rad = math.random ( 1, 15 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('2h Reward Chest',''..cha_name..' opened [2h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end]]--
end

function ItemUse_4h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 4h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "4h Reward Chest", cha_name,"opened [4h Reward Chest] and got [15x Health Regenerator / 25x Cakes]")
	GiveItem ( cha , 0 , 1849 , 25 , 4 )
	GiveItem ( cha , 0 , 11001 , 15 , 4 )
--[[	local rad = math.random ( 1, 25 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Fusion Scroll
	GiveItem ( role , 0 , 0453  , 1 , 4 )
	LG('4h Reward Chest',''..cha_name..' opened [4h Reward Chest] and got 1x '..GetItemName(0453)..'!')
	end]]--
end

function ItemUse_8h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 8h Reward Chest")
		UseItemFailed ( role )
		return
	end

	local cha_name = GetChaDefaultName ( role )
	LG( "8h Reward Chest", cha_name,"opened [8h Reward Chest] and got [20x Health Regenerator / 30x Cakes]")
	GiveItem ( cha , 0 , 1849 , 30 , 4 )
	GiveItem ( cha , 0 , 11001 , 20 , 4 )
--[[	local rad = math.random ( 1, 25 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Fusion Scroll
	GiveItem ( role , 0 , 0453  , 1 , 4 )
	LG('8h Reward Chest',''..cha_name..' opened [8h Reward Chest] and got 1x '..GetItemName(0453)..'!')
	end]]--
end

function ItemUse_12h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 12h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "12h Reward Chest", cha_name,"opened [12h Reward Chest] and got [35x Cakes]")
	GiveItem ( cha , 0 , 1849 , 35 , 4 )
	local rad = math.random ( 1, 24 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
--	if rad ==25 then --Fusion Scroll
--	GiveItem ( role , 0 , 0453  , 1 , 4 )
--	LG('12h Reward Chest',''..cha_name..' opened [12h Reward Chest] and got 1x '..GetItemName(0453)..'!')
--	end
end

function ItemUse_24h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 24h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "24h Reward Chest", cha_name,"opened [24h Reward Chest] and got [40x Cakes]")
	GiveItem ( cha , 0 , 1849 , 40 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('24h Reward Chest',''..cha_name..' opened [24h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_48h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 48h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "48h Reward Chest", cha_name,"opened [48h Reward Chest] and got [40x Cakes]")
	GiveItem ( cha , 0 , 1849 , 40 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('48h Reward Chest',''..cha_name..' opened [48h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_72h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 72h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "72h Reward Chest", cha_name,"opened [72h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('72h Reward Chest',''..cha_name..' opened [72h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_96h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 96h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "96h Reward Chest", cha_name,"opened [96h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('96h Reward Chest',''..cha_name..' opened [96h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_120h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 120h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "120h Reward Chest", cha_name,"opened [120h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('120h Reward Chest',''..cha_name..' opened [120h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_144h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 144h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "144h Reward Chest", cha_name,"opened [144h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('144h Reward Chest',''..cha_name..' opened [144h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_168h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 168h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "168h Reward Chest", cha_name,"opened [168h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('168h Reward Chest',''..cha_name..' opened [168h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_192h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 192h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "192h Reward Chest", cha_name,"opened [192h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('192h Reward Chest',''..cha_name..' opened [192h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_216h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 216h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "216h Reward Chest", cha_name,"opened [216h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('216h Reward Chest',''..cha_name..' opened [216h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_240h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 240h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "240h Reward Chest", cha_name,"opened [240h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('240h Reward Chest',''..cha_name..' opened [240h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_480h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 480h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "480h Reward Chest", cha_name,"opened [480h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('480h Reward Chest',''..cha_name..' opened [480h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_1000h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 1000h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "1000h Reward Chest", cha_name,"opened [1000h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('1000h Reward Chest',''..cha_name..' opened [1000h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_1500h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 1500h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "1500h Reward Chest", cha_name,"opened [1500h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('1500h Reward Chest',''..cha_name..' opened [1500h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_2000h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 2000h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "2000h Reward Chest", cha_name,"opened [2000h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 2x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('2000h Reward Chest',''..cha_name..' opened [2000h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_5000h ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 5000h Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	LG( "5000h Reward Chest", cha_name,"opened [5000h Reward Chest] and got [45x Cakes]")
	GiveItem ( cha , 0 , 1849 , 45 , 4 )
	local rad = math.random ( 1, 31 )
	if rad ==1 then --Sacred Snow Mountain
	GiveItem ( role , 0 , 3050  , 1 , 4 )		
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(3050)..'!')
	end
	if rad ==2 then --Icespire Haven
	GiveItem ( role , 0 , 3053  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(3053)..'!')
	end
	if rad ==3 then --Barren Cavern
	GiveItem ( role , 0 , 3055  , 1 , 4)	
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(3055)..'!')	
	end
	if rad ==4 then --Abandoned Mine 2
	GiveItem ( role , 0 , 3056  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(3056)..'!')
	end
	if rad ==5 then --Silver Mine 2
	GiveItem ( role , 0 , 3057  , 2 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 2x '..GetItemName(3057)..'!')
	end
	if rad ==6 then --Oasis Haven
	GiveItem ( role , 0 , 3052  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(3052)..'!')
	end
	if rad ==7 then --Andes Forest Haven
	GiveItem ( role , 0 , 3051  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(3051)..'!')
	end
	if rad ==8 then --Thundoria Castle
	GiveItem ( role , 0 , 3048  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(3048)..'!')
	end
	if rad ==9 then --Thundoria Harbor
	GiveItem ( role , 0 , 3049  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(3049)..'!')
	end
	if rad ==10 then --Abandon Mine 1
	GiveItem ( role , 0 , 3073  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(3073)..'!')
	end
	if rad ==11 then --Mini Amplifier of Strive
	GiveItem ( role , 0 , 1128  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(1128)..'!')
	end
	if rad ==12 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(1092)..'!')
	end
	if rad ==13 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0684)..'!')
	end
	if rad ==14 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(3047)..'!')
	end
	if rad ==15 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0850)..'!')
	end
	if rad ==16 then --Fiery Gem
	GiveItem ( role , 0 , 0878  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0878)..'!')
	end
	if rad ==17 then --Furious Gem
	GiveItem ( role , 0 , 0879  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0879)..'!')
	end
	if rad ==18 then --Explosive Gem
	GiveItem ( role , 0 , 0880  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0880)..'!')
	end
	if rad ==19 then --Glowing Gem
	GiveItem ( role , 0 , 0882  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0882)..'!')
	end
	if rad ==20 then --Shining Gem
	GiveItem ( role , 0 , 0883  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0883)..'!')
	end
	if rad ==21 then --Shadow Gem
	GiveItem ( role , 0 , 0884  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0884)..'!')
	end
	if rad ==22 then --Spirit Gem
	GiveItem ( role , 0 , 0887  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0887)..'!')
	end
	if rad ==23 then --Gem Composition Scroll
	GiveItem ( role , 0 , 0886  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0886)..'!')
	end
	if rad ==24 then --Strengthening Scroll
	GiveItem ( role , 0 , 0455  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0455)..'!')
	end
	if rad ==25 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==26 then --50k
	--AddMoney ( role , 0 , 50000 ) 
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 50k Gold!')
	end
	if rad ==27 then --100k
	--AddMoney ( role , 0 , 100000 ) 
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 100k Gold!')
	end
	if rad ==28 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 200k Gold!')
	end
	if rad ==29 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 500k Gold!')
	end
	if rad ==30 then --750k
	--AddMoney ( role , 0 , 750000 ) 
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 750k Gold!')
	end
	if rad ==31 then --Strengthening Crystal
	GiveItem ( role , 0 , 0456  , 1 , 4 )
	LG('5000h Reward Chest',''..cha_name..' opened [5000h Reward Chest] and got 1x '..GetItemName(0456)..'!')
	end
end

function ItemUse_1K ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 1K Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	local rad = math.random ( 1, 12 )
	if rad ==1 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 20 , 4 )
	LG('1K Reward Chest',''..cha_name..' opened [1K Reward Chest] and got 20x '..GetItemName(1092)..'!')
	end
	if rad ==2 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 20 , 4 )
	LG('1K Reward Chest',''..cha_name..' opened [1K Reward Chest] and got 20x '..GetItemName(0684)..'!')
	end
	if rad ==3 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 15 , 4 )
	LG('1K Reward Chest',''..cha_name..' opened [1K Reward Chest] and got 15x '..GetItemName(3047)..'!')
	end
	if rad ==4 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 25 , 4 )
	LG('1K Reward Chest',''..cha_name..' opened [1K Reward Chest] and got 25x '..GetItemName(0850)..'!')
	end
	if rad ==5 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('1K Reward Chest',''..cha_name..' opened [1K Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==6 then --500K
	--AddMoney ( role , 0 , 100000 ) 
	LG('1K Reward Chest',''..cha_name..' opened [1K Reward Chest] and got 100K Gold!')
	end
	if rad ==7 then --1m
	--AddMoney ( role , 0 , 500000 ) 
	LG('1K Reward Chest',''..cha_name..' opened [1K Reward Chest] and got 500k Gold!')
	end
	if rad ==8 then --200k
	--AddMoney ( role , 0 , 200000 ) 
	LG('1K Reward Chest',''..cha_name..' opened [1K Reward Chest] and got 200k Gold!')
	end
	if rad ==9 then --800k
	--AddMoney ( role , 0 , 300000 ) 
	LG('1K Reward Chest',''..cha_name..' opened [1K Reward Chest] and got 300k Gold!')
	end
	if rad ==10 then --Random Cracked
	GiveItem ( role , 0 , 15090  , 3 , 4 )
	LG('1K Reward Chest',''..cha_name..' opened [1K Reward Chest] and got 3x '..GetItemName(15090)..'!')
	end
	if rad ==11 then --Random Chipped
	GiveItem ( role , 0 , 15091  , 3 , 4 )
	LG('1K Reward Chest',''..cha_name..' opened [1K Reward Chest] and got 3x '..GetItemName(15091)..'!')
	end
	if rad ==12 then --Random Unique
	GiveItem ( role , 0 , 15092  , 3 , 4 )
	LG('1K Reward Chest',''..cha_name..' opened [1K Reward Chest] and got 3x '..GetItemName(15092)..'!')
	end
end

function ItemUse_5K ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 5K Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	local rad = math.random ( 1, 12 )
	if rad ==1 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 30 , 4 )
	LG('5K Reward Chest',''..cha_name..' opened [5K Reward Chest] and got 30x '..GetItemName(1092)..'!')
	end
	if rad ==2 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 30 , 4 )
	LG('5K Reward Chest',''..cha_name..' opened [5K Reward Chest] and got 30x '..GetItemName(0684)..'!')
	end
	if rad ==3 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 25 , 4 )
	LG('5K Reward Chest',''..cha_name..' opened [5K Reward Chest] and got 25x '..GetItemName(3047)..'!')
	end
	if rad ==4 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 35 , 4 )
	LG('5K Reward Chest',''..cha_name..' opened [5K Reward Chest] and got 35x '..GetItemName(0850)..'!')
	end
	if rad ==5 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('5K Reward Chest',''..cha_name..' opened [5K Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==6 then --5K
	--AddMoney ( role , 0 , 500000 ) 
	LG('5K Reward Chest',''..cha_name..' opened [5K Reward Chest] and got 5K Gold!')
	end
	if rad ==7 then --1m
	--AddMoney ( role , 0 , 1000000 ) 
	LG('5K Reward Chest',''..cha_name..' opened [5K Reward Chest] and got 1m Gold!')
	end
	if rad ==8 then --2m
	--AddMoney ( role , 0 , 2000000 ) 
	LG('5K Reward Chest',''..cha_name..' opened [5K Reward Chest] and got 2m Gold!')
	end
	if rad ==9 then --800k
	--AddMoney ( role , 0 , 800000 ) 
	LG('5K Reward Chest',''..cha_name..' opened [5K Reward Chest] and got 800k Gold!')
	end
	if rad ==10 then --Random Cracked
	GiveItem ( role , 0 , 15090  , 3 , 4 )
	LG('5K Reward Chest',''..cha_name..' opened [5K Reward Chest] and got 3x '..GetItemName(15090)..'!')
	end
	if rad ==11 then --Random Chipped
	GiveItem ( role , 0 , 15091  , 3 , 4 )
	LG('5K Reward Chest',''..cha_name..' opened [5K Reward Chest] and got 3x '..GetItemName(15091)..'!')
	end
	if rad ==12 then --Random Unique
	GiveItem ( role , 0 , 15092  , 3 , 4 )
	LG('5K Reward Chest',''..cha_name..' opened [5K Reward Chest] and got 3x '..GetItemName(15092)..'!')
	end
end

function ItemUse_10K ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 10K Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	local rad = math.random ( 1, 12 )
	if rad ==1 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 30 , 4 )
	LG('10K Reward Chest',''..cha_name..' opened [10K Reward Chest] and got 30x '..GetItemName(1092)..'!')
	end
	if rad ==2 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 30 , 4 )
	LG('10K Reward Chest',''..cha_name..' opened [10K Reward Chest] and got 30x '..GetItemName(0684)..'!')
	end
	if rad ==3 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 25 , 4 )
	LG('10K Reward Chest',''..cha_name..' opened [10K Reward Chest] and got 25x '..GetItemName(3047)..'!')
	end
	if rad ==4 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 35 , 4 )
	LG('10K Reward Chest',''..cha_name..' opened [10K Reward Chest] and got 35x '..GetItemName(0850)..'!')
	end
	if rad ==5 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('10K Reward Chest',''..cha_name..' opened [10K Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==6 then --10K
	--AddMoney ( role , 0 , 500000 ) 
	LG('10K Reward Chest',''..cha_name..' opened [10K Reward Chest] and got 10K Gold!')
	end
	if rad ==7 then --1m
	--AddMoney ( role , 0 , 1000000 ) 
	LG('10K Reward Chest',''..cha_name..' opened [10K Reward Chest] and got 1m Gold!')
	end
	if rad ==8 then --2m
	--AddMoney ( role , 0 , 2000000 ) 
	LG('10K Reward Chest',''..cha_name..' opened [10K Reward Chest] and got 2m Gold!')
	end
	if rad ==9 then --800k
	--AddMoney ( role , 0 , 800000 ) 
	LG('10K Reward Chest',''..cha_name..' opened [10K Reward Chest] and got 800k Gold!')
	end
	if rad ==10 then --Random Cracked
	GiveItem ( role , 0 , 15090  , 3 , 4 )
	LG('10K Reward Chest',''..cha_name..' opened [10K Reward Chest] and got 3x '..GetItemName(15090)..'!')
	end
	if rad ==11 then --Random Chipped
	GiveItem ( role , 0 , 15091  , 3 , 4 )
	LG('10K Reward Chest',''..cha_name..' opened [10K Reward Chest] and got 3x '..GetItemName(15091)..'!')
	end
	if rad ==12 then --Random Unique
	GiveItem ( role , 0 , 15092  , 3 , 4 )
	LG('10K Reward Chest',''..cha_name..' opened [10K Reward Chest] and got 3x '..GetItemName(15092)..'!')
	end
end

function ItemUse_25K ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 25K Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	local rad = math.random ( 1, 12 )
	if rad ==1 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 30 , 4 )
	LG('25K Reward Chest',''..cha_name..' opened [25K Reward Chest] and got 30x '..GetItemName(1092)..'!')
	end
	if rad ==2 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 30 , 4 )
	LG('25K Reward Chest',''..cha_name..' opened [25K Reward Chest] and got 30x '..GetItemName(0684)..'!')
	end
	if rad ==3 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 25 , 4 )
	LG('25K Reward Chest',''..cha_name..' opened [25K Reward Chest] and got 25x '..GetItemName(3047)..'!')
	end
	if rad ==4 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 35 , 4 )
	LG('25K Reward Chest',''..cha_name..' opened [25K Reward Chest] and got 35x '..GetItemName(0850)..'!')
	end
	if rad ==5 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('25K Reward Chest',''..cha_name..' opened [25K Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==6 then --25K
	--AddMoney ( role , 0 , 500000 ) 
	LG('25K Reward Chest',''..cha_name..' opened [25K Reward Chest] and got 25K Gold!')
	end
	if rad ==7 then --1m
	--AddMoney ( role , 0 , 1000000 ) 
	LG('25K Reward Chest',''..cha_name..' opened [25K Reward Chest] and got 1m Gold!')
	end
	if rad ==8 then --2m
	--AddMoney ( role , 0 , 2000000 ) 
	LG('25K Reward Chest',''..cha_name..' opened [25K Reward Chest] and got 2m Gold!')
	end
	if rad ==9 then --800k
	--AddMoney ( role , 0 , 800000 ) 
	LG('25K Reward Chest',''..cha_name..' opened [25K Reward Chest] and got 800k Gold!')
	end
	if rad ==10 then --Random Cracked
	GiveItem ( role , 0 , 15090  , 3 , 4 )
	LG('25K Reward Chest',''..cha_name..' opened [25K Reward Chest] and got 3x '..GetItemName(15090)..'!')
	end
	if rad ==11 then --Random Chipped
	GiveItem ( role , 0 , 15091  , 3 , 4 )
	LG('25K Reward Chest',''..cha_name..' opened [25K Reward Chest] and got 3x '..GetItemName(15091)..'!')
	end
	if rad ==12 then --Random Unique
	GiveItem ( role , 0 , 15092  , 3 , 4 )
	LG('25K Reward Chest',''..cha_name..' opened [25K Reward Chest] and got 3x '..GetItemName(15092)..'!')
	end
end

function ItemUse_50K ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 50K Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	local rad = math.random ( 1, 12 )
	if rad ==1 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 30 , 4 )
	LG('50K Reward Chest',''..cha_name..' opened [50K Reward Chest] and got 30x '..GetItemName(1092)..'!')
	end
	if rad ==2 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 30 , 4 )
	LG('50K Reward Chest',''..cha_name..' opened [50K Reward Chest] and got 30x '..GetItemName(0684)..'!')
	end
	if rad ==3 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 25 , 4 )
	LG('50K Reward Chest',''..cha_name..' opened [50K Reward Chest] and got 25x '..GetItemName(3047)..'!')
	end
	if rad ==4 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 35 , 4 )
	LG('50K Reward Chest',''..cha_name..' opened [50K Reward Chest] and got 35x '..GetItemName(0850)..'!')
	end
	if rad ==5 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('50K Reward Chest',''..cha_name..' opened [50K Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==6 then --50K
	--AddMoney ( role , 0 , 500000 ) 
	LG('50K Reward Chest',''..cha_name..' opened [50K Reward Chest] and got 50K Gold!')
	end
	if rad ==7 then --1m
	--AddMoney ( role , 0 , 1000000 ) 
	LG('50K Reward Chest',''..cha_name..' opened [50K Reward Chest] and got 1m Gold!')
	end
	if rad ==8 then --2m
	--AddMoney ( role , 0 , 2000000 ) 
	LG('50K Reward Chest',''..cha_name..' opened [50K Reward Chest] and got 2m Gold!')
	end
	if rad ==9 then --800k
	--AddMoney ( role , 0 , 800000 ) 
	LG('50K Reward Chest',''..cha_name..' opened [50K Reward Chest] and got 800k Gold!')
	end
	if rad ==10 then --Random Cracked
	GiveItem ( role , 0 , 15090  , 3 , 4 )
	LG('50K Reward Chest',''..cha_name..' opened [50K Reward Chest] and got 3x '..GetItemName(15090)..'!')
	end
	if rad ==11 then --Random Chipped
	GiveItem ( role , 0 , 15091  , 3 , 4 )
	LG('50K Reward Chest',''..cha_name..' opened [50K Reward Chest] and got 3x '..GetItemName(15091)..'!')
	end
	if rad ==12 then --Random Unique
	GiveItem ( role , 0 , 15092  , 3 , 4 )
	LG('50K Reward Chest',''..cha_name..' opened [50K Reward Chest] and got 3x '..GetItemName(15092)..'!')
	end
end

function ItemUse_100K ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 100K Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	local rad = math.random ( 1, 12 )
	if rad ==1 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 30 , 4 )
	LG('100K Reward Chest',''..cha_name..' opened [100K Reward Chest] and got 30x '..GetItemName(1092)..'!')
	end
	if rad ==2 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 30 , 4 )
	LG('100K Reward Chest',''..cha_name..' opened [100K Reward Chest] and got 30x '..GetItemName(0684)..'!')
	end
	if rad ==3 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 25 , 4 )
	LG('100K Reward Chest',''..cha_name..' opened [100K Reward Chest] and got 25x '..GetItemName(3047)..'!')
	end
	if rad ==4 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 35 , 4 )
	LG('100K Reward Chest',''..cha_name..' opened [100K Reward Chest] and got 35x '..GetItemName(0850)..'!')
	end
	if rad ==5 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('100K Reward Chest',''..cha_name..' opened [100K Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==6 then --100K
	--AddMoney ( role , 0 , 500000 ) 
	LG('100K Reward Chest',''..cha_name..' opened [100K Reward Chest] and got 100K Gold!')
	end
	if rad ==7 then --1m
	--AddMoney ( role , 0 , 1000000 ) 
	LG('100K Reward Chest',''..cha_name..' opened [100K Reward Chest] and got 1m Gold!')
	end
	if rad ==8 then --2m
	--AddMoney ( role , 0 , 2000000 ) 
	LG('100K Reward Chest',''..cha_name..' opened [100K Reward Chest] and got 2m Gold!')
	end
	if rad ==9 then --800k
	--AddMoney ( role , 0 , 800000 ) 
	LG('100K Reward Chest',''..cha_name..' opened [100K Reward Chest] and got 800k Gold!')
	end
	if rad ==10 then --Random Cracked
	GiveItem ( role , 0 , 15090  , 3 , 4 )
	LG('100K Reward Chest',''..cha_name..' opened [100K Reward Chest] and got 3x '..GetItemName(15090)..'!')
	end
	if rad ==11 then --Random Chipped
	GiveItem ( role , 0 , 15091  , 3 , 4 )
	LG('100K Reward Chest',''..cha_name..' opened [100K Reward Chest] and got 3x '..GetItemName(15091)..'!')
	end
	if rad ==12 then --Random Unique
	GiveItem ( role , 0 , 15092  , 3 , 4 )
	LG('100K Reward Chest',''..cha_name..' opened [100K Reward Chest] and got 3x '..GetItemName(15092)..'!')
	end
end

function ItemUse_200K ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 200K Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	local rad = math.random ( 1, 12 )
	if rad ==1 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 30 , 4 )
	LG('200K Reward Chest',''..cha_name..' opened [200K Reward Chest] and got 30x '..GetItemName(1092)..'!')
	end
	if rad ==2 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 30 , 4 )
	LG('200K Reward Chest',''..cha_name..' opened [200K Reward Chest] and got 30x '..GetItemName(0684)..'!')
	end
	if rad ==3 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 25 , 4 )
	LG('200K Reward Chest',''..cha_name..' opened [200K Reward Chest] and got 25x '..GetItemName(3047)..'!')
	end
	if rad ==4 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 35 , 4 )
	LG('200K Reward Chest',''..cha_name..' opened [200K Reward Chest] and got 35x '..GetItemName(0850)..'!')
	end
	if rad ==5 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('200K Reward Chest',''..cha_name..' opened [200K Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==6 then --200K
	--AddMoney ( role , 0 , 500000 ) 
	LG('200K Reward Chest',''..cha_name..' opened [200K Reward Chest] and got 200K Gold!')
	end
	if rad ==7 then --1m
	--AddMoney ( role , 0 , 1000000 ) 
	LG('200K Reward Chest',''..cha_name..' opened [200K Reward Chest] and got 1m Gold!')
	end
	if rad ==8 then --2m
	--AddMoney ( role , 0 , 2000000 ) 
	LG('200K Reward Chest',''..cha_name..' opened [200K Reward Chest] and got 2m Gold!')
	end
	if rad ==9 then --800k
	--AddMoney ( role , 0 , 800000 ) 
	LG('200K Reward Chest',''..cha_name..' opened [200K Reward Chest] and got 800k Gold!')
	end
	if rad ==10 then --Random Cracked
	GiveItem ( role , 0 , 15090  , 3 , 4 )
	LG('200K Reward Chest',''..cha_name..' opened [200K Reward Chest] and got 3x '..GetItemName(15090)..'!')
	end
	if rad ==11 then --Random Chipped
	GiveItem ( role , 0 , 15091  , 3 , 4 )
	LG('200K Reward Chest',''..cha_name..' opened [200K Reward Chest] and got 3x '..GetItemName(15091)..'!')
	end
	if rad ==12 then --Random Unique
	GiveItem ( role , 0 , 15092  , 3 , 4 )
	LG('200K Reward Chest',''..cha_name..' opened [200K Reward Chest] and got 3x '..GetItemName(15092)..'!')
	end
end

function ItemUse_500K ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Requires 3 slots in inventory to open 500K Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
--	LG( "500K Reward Chest", cha_name,"opened [500K Reward Chest] and got [99x Cakes]")
--	GiveItem ( cha , 0 , 1849 , 99 , 4 )
	local rad = math.random ( 1, 12 )
	if rad ==1 then --Old Sheepskin Scroll
	GiveItem ( role , 0 , 1092  , 30 , 4 )
	LG('500K Reward Chest',''..cha_name..' opened [500K Reward Chest] and got 30x '..GetItemName(1092)..'!')
	end
	if rad ==2 then --New Sheepskin Scroll
	GiveItem ( role , 0 , 0684  , 30 , 4 )
	LG('500K Reward Chest',''..cha_name..' opened [500K Reward Chest] and got 30x '..GetItemName(0684)..'!')
	end
	if rad ==3 then --Voodoo Puppet
	GiveItem ( role , 0 , 3047  , 25 , 4 )
	LG('500K Reward Chest',''..cha_name..' opened [500K Reward Chest] and got 25x '..GetItemName(3047)..'!')
	end
	if rad ==4 then --Weightless Potion
	GiveItem ( role , 0 , 0850  , 35 , 4 )
	LG('500K Reward Chest',''..cha_name..' opened [500K Reward Chest] and got 35x '..GetItemName(0850)..'!')
	end
	if rad ==5 then --Million Dollar Note
	GiveItem ( role , 0 , 0854  , 1 , 4 )
	LG('500K Reward Chest',''..cha_name..' opened [500K Reward Chest] and got 1x '..GetItemName(0854)..'!')
	end
	if rad ==6 then --500k
	--AddMoney ( role , 0 , 500000 ) 
	LG('500K Reward Chest',''..cha_name..' opened [500K Reward Chest] and got 500k Gold!')
	end
	if rad ==7 then --1m
	--AddMoney ( role , 0 , 1000000 ) 
	LG('500K Reward Chest',''..cha_name..' opened [500K Reward Chest] and got 1m Gold!')
	end
	if rad ==8 then --2m
	--AddMoney ( role , 0 , 2000000 ) 
	LG('500K Reward Chest',''..cha_name..' opened [500K Reward Chest] and got 2m Gold!')
	end
	if rad ==9 then --800k
	--AddMoney ( role , 0 , 800000 ) 
	LG('500K Reward Chest',''..cha_name..' opened [500K Reward Chest] and got 800k Gold!')
	end
	if rad ==10 then --Random Cracked
	GiveItem ( role , 0 , 15090  , 3 , 4 )
	LG('500K Reward Chest',''..cha_name..' opened [500K Reward Chest] and got 3x '..GetItemName(15090)..'!')
	end
	if rad ==11 then --Random Chipped
	GiveItem ( role , 0 , 15091  , 3 , 4 )
	LG('500K Reward Chest',''..cha_name..' opened [500K Reward Chest] and got 3x '..GetItemName(15091)..'!')
	end
	if rad ==12 then --Random Unique
	GiveItem ( role , 0 , 15092  , 3 , 4 )
	LG('500K Reward Chest',''..cha_name..' opened [500K Reward Chest] and got 3x '..GetItemName(15092)..'!')
	end
end

function ItemUse_BetaTest ( role , Item ) 
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 5 then
		SystemNotice(role ,"Requires 5 slots in inventory to open Beta Reward Chest")
		UseItemFailed ( role )
		return
	end
	local cha_name = GetChaDefaultName ( role )
	local rad = math.random ( 1, 15 )
	if rad ==1 then --Pack 1
	GiveItem ( role , 0 , 0849  , 1 , 4 )	
	GiveItem ( role , 0 , 3844  , 2 , 4)	
	GiveItem ( role , 0 , 3845  , 1 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 1!')
	end
	if rad ==2 then --Pack 2
	GiveItem ( role , 0 , 0849  , 2 , 4 )
	GiveItem ( role , 0 , 3844  , 1 , 4)	
	GiveItem ( role , 0 , 3845  , 1 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 2!')
	end
	if rad ==3 then --Pack 3
	GiveItem ( role , 0 , 0849  , 1 , 4 )
	GiveItem ( role , 0 , 3844  , 1 , 4)	
	GiveItem ( role , 0 , 3845  , 2 , 4 )
	--AddMoney ( role , 0 , 50000 ) 	
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 3!')	
	end
	if rad ==4 then --Pack 4
	GiveItem ( role , 0 , 0849  , 1 , 4 )
	GiveItem ( role , 0 , 3844  , 1 , 4)	
	GiveItem ( role , 0 , 3845  , 2 , 4 )	
	GiveItem ( role , 0 , 3847  , 3 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 4!')	
	end
	if rad ==5 then --Pack 5
	GiveItem ( role , 0 , 15080  , 1 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 5!')	
	end
	if rad ==6 then --Pack 6
	GiveItem ( role , 0 , 15081  , 1 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 6!')	
	end
	if rad ==7 then --Pack 7
	GiveItem ( role , 0 , 5791  , 1 , 4 )
	GiveItem ( role , 0 , 5792  , 1 , 4)	
	GiveItem ( role , 0 , 5793  , 1 , 4 )	
	GiveItem ( role , 0 , 5794  , 1 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 7!')	
	end
	if rad ==8 then --Pack 8
	GiveItem ( role , 0 , 5795  , 1 , 4 )
	GiveItem ( role , 0 , 5796  , 1 , 4)	
	GiveItem ( role , 0 , 5797  , 1 , 4 )	
	GiveItem ( role , 0 , 5798  , 1 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 9!')	
	end
	if rad ==9 then --Pack 9
	GiveItem ( role , 0 , 5799  , 1 , 4 )
	GiveItem ( role , 0 , 5800  , 1 , 4)	
	GiveItem ( role , 0 , 5801  , 1 , 4 )	
	GiveItem ( role , 0 , 5802  , 1 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 9!')	
	end
	if rad ==10 then --Pack 10
	GiveItem ( role , 0 , 5803  , 1 , 4 )
	GiveItem ( role , 0 , 5804  , 1 , 4)	
	GiveItem ( role , 0 , 5805  , 1 , 4 )	
	GiveItem ( role , 0 , 5806  , 1 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 10!')	
	end
	if rad ==11 then --Pack 11
	GiveItem ( role , 0 , 5807  , 1 , 4 )
	GiveItem ( role , 0 , 5808  , 1 , 4)	
	GiveItem ( role , 0 , 5809  , 1 , 4 )	
	GiveItem ( role , 0 , 5810  , 1 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 11!')	
	end
	if rad ==12 then --Pack 12
	GiveItem ( role , 0 , 0849  , 2 , 4 )
	GiveItem ( role , 0 , 3844  , 1 , 4)	
	GiveItem ( role , 0 , 3845  , 2 , 4 )	
	GiveItem ( role , 0 , 3847  , 2 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 12!')	
	end
	if rad ==13 then --Pack 13
	GiveItem ( role , 0 , 0849  , 2 , 4 )
	GiveItem ( role , 0 , 3844  , 2 , 4)	
	GiveItem ( role , 0 , 3845  , 2 , 4 )	
	GiveItem ( role , 0 , 3847  , 1 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 13!')	
	end
	if rad ==14 then --Pack 14
	GiveItem ( role , 0 , 0849  , 2 , 4 )
	GiveItem ( role , 0 , 3844  , 2 , 4)	
	GiveItem ( role , 0 , 3845  , 2 , 4 )	
	GiveItem ( role , 0 , 3847  , 2 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 14!')	
	end
	if rad ==15 then --Pack 15
	GiveItem ( role , 0 , 0849  , 3 , 4 )
	GiveItem ( role , 0 , 3844  , 3 , 4)	
	GiveItem ( role , 0 , 3845  , 3 , 4 )	
	GiveItem ( role , 0 , 3847  , 3 , 4 )
	--AddMoney ( role , 0 , 50000 ) 
	LG('Beta Reward Chest',''..cha_name..' opened [Beta Reward Chest] and got Pack 15!')	
	end
end

-------------------------------------------
----------------Lv10 EQP Chests------------
local lv10beltx = 16001
local lv10belty = 16160
function Lv10Belts(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10beltx, lv10belty)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10bracex = 16161
local lv10bracey = 16320
function Lv10Braces(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10bracex, lv10bracey)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10earringsx = 16321
local lv10earringsy = 16480
function Lv10Earrings(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10earringsx, lv10earringsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10headgearsx = 16481
local lv10headgearsy = 16640
function Lv10Headgears(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10headgearsx, lv10headgearsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10ringsx = 16641
local lv10ringsy = 16800
function Lv10Rings(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10ringsx, lv10ringsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10necksx = 16801
local lv10necksy = 16960
function Lv10Necks(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10necksx, lv10necksy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10shieldsx = 16961
local lv10shieldsy = 17120
function Lv10Shields(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10shieldsx, lv10shieldsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10torsosx = 17121
local lv10torsosy = 17280
function Lv10Torsos(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10torsosx, lv10torsosy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10gauntletsx = 17281
local lv10gauntletsy = 17440
function Lv10Gauntlets(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10gauntletsx, lv10gauntletsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10bootsx = 17441
local lv10bootsy = 17600
function Lv10Boots(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10bootsx, lv10bootsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10gunsx = 17601
local lv10gunsy = 17760
function Lv10Guns(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10gunsx, lv10gunsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10daggersx = 17761
local lv10daggersy = 17920
function Lv10Daggers(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10daggersx, lv10daggersy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10onehandx = 17921
local lv10onehandy = 18080
function Lv10onehand(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10onehandx, lv10onehandy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10twohandx = 18081
local lv10twohandy = 18240
function Lv10twohand(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10twohandx, lv10twohandy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10staffsx = 18241
local lv10staffsy = 18400
function Lv10Staffs(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10staffsx, lv10staffsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv10bowsx = 18401
local lv10bowsy = 18560
function Lv10Bows(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv10bowsx, lv10bowsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
-------------------------------------------
----------------Lv20 EQP Chests------------
local lv20beltx = 18561
local lv20belty = 18720
function Lv20Belts(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20beltx, lv20belty)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20bracex = 18721
local lv20bracey = 18880
function Lv20Braces(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20bracex, lv20bracey)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20earringsx = 18881
local lv20earringsy = 19040
function Lv20Earrings(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20earringsx, lv20earringsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20headgearsx = 19041
local lv20headgearsy = 19200
function Lv20Headgears(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20headgearsx, lv20headgearsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20ringsx = 19201
local lv20ringsy = 19360
function Lv20Rings(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20ringsx, lv20ringsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20necksx = 19361
local lv20necksy = 19520
function Lv20Necks(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20necksx, lv20necksy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20shieldsx = 19521
local lv20shieldsy = 19680
function Lv20Shields(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20shieldsx, lv20shieldsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20torsosx = 19681
local lv20torsosy = 19840
function Lv20Torsos(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20torsosx, lv20torsosy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20gauntletsx = 19841
local lv20gauntletsy = 20000
function Lv20Gauntlets(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20gauntletsx, lv20gauntletsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20bootsx = 20001
local lv20bootsy = 20160
function Lv20Boots(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20bootsx, lv20bootsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20gunsx = 20161
local lv20gunsy = 20320
function Lv20Guns(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20gunsx, lv20gunsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20daggersx = 20321
local lv20daggersy = 20480
function Lv20Daggers(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20daggersx, lv20daggersy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20onehandx = 20481
local lv20onehandy = 20640
function Lv20onehand(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20onehandx, lv20onehandy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20twohandx = 20641
local lv20twohandy = 20800
function Lv20twohand(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20twohandx, lv20twohandy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20staffsx = 20801
local lv20staffsy = 20960
function Lv20Staffs(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20staffsx, lv20staffsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv20bowsx = 20961
local lv20bowsy = 21120
function Lv20Bows(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv20bowsx, lv20bowsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
-------------------------------------------
----------------Lv40 EQP Chests------------
local lv40beltx = 21121
local lv40belty = 21280
function Lv40Belts(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40beltx, lv40belty)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40bracex = 21281
local lv40bracey = 21440
function Lv40Braces(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40bracex, lv40bracey)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40earringsx = 21441
local lv40earringsy = 21600
function Lv40Earrings(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40earringsx, lv40earringsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40headgearsx = 21601
local lv40headgearsy = 21760
function Lv40Headgears(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40headgearsx, lv40headgearsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40ringsx = 21761
local lv40ringsy = 21920
function Lv40Rings(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40ringsx, lv40ringsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40necksx = 21921
local lv40necksy = 22080
function Lv40Necks(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40necksx, lv40necksy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40shieldsx = 22081
local lv40shieldsy = 22240
function Lv40Shields(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40shieldsx, lv40shieldsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40torsosx = 22241
local lv40torsosy = 22400
function Lv40Torsos(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40torsosx, lv40torsosy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40gauntletsx = 22401
local lv40gauntletsy = 22560
function Lv40Gauntlets(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40gauntletsx, lv40gauntletsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40bootsx = 22561
local lv40bootsy = 22720
function Lv40Boots(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40bootsx, lv40bootsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40gunsx = 22721
local lv40gunsy = 22880
function Lv40Guns(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40gunsx, lv40gunsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40daggersx = 22881
local lv40daggersy = 23040
function Lv40Daggers(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40daggersx, lv40daggersy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40onehandx = 23041
local lv40onehandy = 23200
function Lv40onehand(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40onehandx, lv40onehandy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40twohandx = 23201
local lv40twohandy = 23360
function Lv40twohand(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40twohandx, lv40twohandy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40staffsx = 23361
local lv40staffsy = 23520
function Lv40Staffs(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40staffsx, lv40staffsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv40bowsx = 23521
local lv40bowsy = 23680
function Lv40Bows(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv40bowsx, lv40bowsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
-------------------------------------------
----------------Lv60 EQP Chests------------
local lv60beltx = 23681
local lv60belty = 23840
function Lv60Belts(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60beltx, lv60belty)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60bracex = 23841
local lv60bracey = 24000
function Lv60Braces(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60bracex, lv60bracey)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60earringsx = 24001
local lv60earringsy = 24160
function Lv60Earrings(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60earringsx, lv60earringsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60headgearsx = 24161
local lv60headgearsy = 24320
function Lv60Headgears(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60headgearsx, lv60headgearsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60ringsx = 24321
local lv60ringsy = 24480
function Lv60Rings(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60ringsx, lv60ringsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60necksx = 24481
local lv60necksy = 24640
function Lv60Necks(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60necksx, lv60necksy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60shieldsx = 24641
local lv60shieldsy = 24800
function Lv60Shields(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60shieldsx, lv60shieldsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60torsosx = 24801
local lv60torsosy = 24960
function Lv60Torsos(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60torsosx, lv60torsosy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60gauntletsx = 24961
local lv60gauntletsy = 25120
function Lv60Gauntlets(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60gauntletsx, lv60gauntletsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60bootsx = 25121
local lv60bootsy = 25280
function Lv60Boots(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60bootsx, lv60bootsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60gunsx = 25281
local lv60gunsy = 25440
function Lv60Guns(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60gunsx, lv60gunsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60daggersx = 25441
local lv60daggersy = 25600
function Lv60Daggers(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60daggersx, lv60daggersy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60onehandx = 25601
local lv60onehandy = 25760
function Lv60onehand(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60onehandx, lv60onehandy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60twohandx = 25761
local lv60twohandy = 25920
function Lv60twohand(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60twohandx, lv60twohandy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60staffsx = 25921
local lv60staffsy = 26080
function Lv60Staffs(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60staffsx, lv60staffsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv60bowsx = 26081
local lv60bowsy = 26240
function Lv60Bows(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv60bowsx, lv60bowsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
-------------------------------------------
----------------Lv90 EQP Chests------------
local lv90beltx = 26241
local lv90belty = 26400
function Lv90Belts(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90beltx, lv90belty)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90bracex = 26401
local lv90bracey = 26560
function Lv90Braces(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90bracex, lv90bracey)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90earringsx = 26561
local lv90earringsy = 26720
function Lv90Earrings(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90earringsx, lv90earringsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90headgearsx = 26721
local lv90headgearsy = 26880
function Lv90Headgears(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90headgearsx, lv90headgearsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90ringsx = 26881
local lv90ringsy = 27040
function Lv90Rings(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90ringsx, lv90ringsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90necksx = 27041
local lv90necksy = 27200
function Lv90Necks(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90necksx, lv90necksy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90shieldsx = 27201
local lv90shieldsy = 27360
function Lv90Shields(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90shieldsx, lv90shieldsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90torsosx = 27361
local lv90torsosy = 27520
function Lv90Torsos(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90torsosx, lv90torsosy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90gauntletsx = 27521
local lv90gauntletsy = 27680
function Lv90Gauntlets(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90gauntletsx, lv90gauntletsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90bootsx = 27681
local lv90bootsy = 27840
function Lv90Boots(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90bootsx, lv90bootsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90gunsx = 27841
local lv90gunsy = 28000
function Lv90Guns(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90gunsx, lv90gunsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90daggersx = 28001
local lv90daggersy = 28160
function Lv90Daggers(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90daggersx, lv90daggersy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90onehandx = 28161
local lv90onehandy = 28320
function Lv90onehand(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90onehandx, lv90onehandy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90twohandx = 28321
local lv90twohandy = 28480
function Lv90twohand(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90twohandx, lv90twohandy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90staffsx = 28481
local lv90staffsy = 28640
function Lv90Staffs(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90staffsx, lv90staffsy)
	GiveItem(role, 0, ItemID , 1, 4)
end
local lv90bowsx = 28641
local lv90bowsy = 28800
function Lv90Bows(role, Item)
	if GetCtrlBoat(role) ~= nil then
		SystemNotice(role, 'Cannot use when sailing.')
		UseItemFailed(role)
		return
	end
	if GetChaFreeBagGridNum(role) < 1 then
		SystemNotice(role, 'You need at least 1 free slot.')
		UseItemFailed(role)
		return
	end
	local ItemID = math.random(lv90bowsx, lv90bowsy)
	GiveItem(role, 0, ItemID , 1, 4)
end




------------------------------------
--HP Pots---------------------------
------------------------------------
Hpot = Hpot or {}
function ItemUse_HPAC( role , Item )
	if Hpot[role] == nil then
		Hpot[role] = os.time();
	end
	local cd = Hpot[role] - os.time()
	if cd > 0 then
		SystemNotice(role, 'HpPotion cooldown on effect wait '..cd..' sec(s) to use again!')
		UseItemFailed(role)
		return
	end
	local hp = GetChaAttr(role, ATTR_HP) 
	hp_resume = 100
	hp = hp + hp_resume 
	mxhp = GetChaAttr(role,ATTR_MXHP) 
	if hp > mxhp then
		hp = mxhp 
	end 
	local delay = 10
	Hpot[role] = os.time()+delay
	SetCharaAttr(hp, role, ATTR_HP)
end
function ItemUse_HPBC( role , Item )
	if Hpot[role] == nil then
		Hpot[role] = os.time();
	end
	local cd = Hpot[role] - os.time()
	if cd > 0 then
		SystemNotice(role, 'HpPotion cooldown on effect wait '..cd..' sec(s) to use again!')
		UseItemFailed(role)
		return
	end
	local hp = GetChaAttr(role, ATTR_HP) 
	hp_resume = 300
	hp = hp + hp_resume 
	mxhp = GetChaAttr(role,ATTR_MXHP) 
	if hp > mxhp then
		hp = mxhp 
	end 
	local delay = 10
	Hpot[role] = os.time()+delay
	SetCharaAttr(hp, role, ATTR_HP)
end
function ItemUse_HPCC( role , Item )
	if Hpot[role] == nil then
		Hpot[role] = os.time();
	end
	local cd = Hpot[role] - os.time()
	if cd > 0 then
		SystemNotice(role, 'HpPotion cooldown on effect wait '..cd..' sec(s) to use again!')
		UseItemFailed(role)
		return
	end
	local hp = GetChaAttr(role, ATTR_HP) 
	hp_resume = 600
	hp = hp + hp_resume 
	mxhp = GetChaAttr(role,ATTR_MXHP) 
	if hp > mxhp then
		hp = mxhp 
	end 
	local delay = 10
	Hpot[role] = os.time()+delay
	SetCharaAttr(hp, role, ATTR_HP)
end

------------------------------------
--SP Pots---------------------------
------------------------------------
Spot = Spot or {}
function ItemUse_SPAC(role, Item)
	local Cha_Boat = 0
	Cha_Boat = GetCtrlBoat ( role )
	if Cha_Boat ~= nil then 
		SystemNotice( role , "Cannot use while sailing" ) 
		UseItemFailed ( role ) 
		return 
	end
	if Spot[role] == nil then
		Spot[role] = os.time();
	end
	local cd = Spot[role] - os.time()
	if cd > 0 then
		SystemNotice(role, 'SpPotion cooldown on effect wait '..cd..' sec(s) to use again!')
		UseItemFailed(role)
		return
	end
	local sp = GetChaAttr(role, ATTR_SP) 
	sp_resume = 36   
	sp = sp + sp_resume 
	mxsp = GetChaAttr(role,ATTR_MXSP) 
	if sp > mxsp then
		sp = mxsp 
	end 
	local delay = 12
	Spot[role] = os.time()+delay
	SetCharaAttr(sp, role, ATTR_SP) 
end
function ItemUse_SPBC(role, Item)
	local Cha_Boat = 0
	Cha_Boat = GetCtrlBoat ( role )
	if Cha_Boat ~= nil then 
		SystemNotice( role , "Cannot use while sailing" ) 
		UseItemFailed ( role ) 
		return 
	end
	if Spot[role] == nil then
		Spot[role] = os.time();
	end
	local cd = Spot[role] - os.time()
	if cd > 0 then
		SystemNotice(role, 'SpPotion cooldown on effect wait '..cd..' sec(s) to use again!')
		UseItemFailed(role)
		return
	end
	local sp = GetChaAttr(role, ATTR_SP) 
	sp_resume = 66   
	sp = sp + sp_resume 
	mxsp = GetChaAttr(role,ATTR_MXSP) 
	if sp > mxsp then
		sp = mxsp 
	end 
	local delay = 12
	Spot[role] = os.time()+delay
	SetCharaAttr(sp, role, ATTR_SP) 
end
function ItemUse_SPCC(role, Item)
	local Cha_Boat = 0
	Cha_Boat = GetCtrlBoat ( role )
	if Cha_Boat ~= nil then 
		SystemNotice( role , "Cannot use while sailing" ) 
		UseItemFailed ( role ) 
		return 
	end
	if Spot[role] == nil then
		Spot[role] = os.time();
	end
	local cd = Spot[role] - os.time()
	if cd > 0 then
		SystemNotice(role, 'SpPotion cooldown on effect wait '..cd..' sec(s) to use again!')
		UseItemFailed(role)
		return
	end
	local sp = GetChaAttr(role, ATTR_SP) 
	sp_resume = 90   
	sp = sp + sp_resume 
	mxsp = GetChaAttr(role,ATTR_MXSP) 
	if sp > mxsp then
		sp = mxsp 
	end 
	local delay = 12
	Spot[role] = os.time()+delay
	SetCharaAttr(sp, role, ATTR_SP) 
end

--Heavens Berry(BOUND)
function ItemUse_DoubleEXPR( role , Item )
	local statelv = 1
	local ChaStateLv = GetChaStateLv ( role , STATE_SBJYGZ )
	if ChaStateLv > statelv then
		SystemNotice ( role , "Better fruit in effect. Please use it later" )
		UseItemFailed ( role )
		return
	end
	local statetime = 900
	local Cha_Boat = 0
	Cha_Boat = GetCtrlBoat ( role )
	if Cha_Boat ==  nil then
		AddState( role , role , STATE_SBJYGZ , statelv , statetime )
	else
		AddState( Cha_Boat , Cha_Boat , STATE_SBJYGZ , statelv , statetime )
	end
end

--Charmed Berry(BOUND)
function ItemUse_DoubleDROPR( role , Item )
	local statelv = 1
	local ChaStateLv = GetChaStateLv ( role , STATE_SBBLGZ )
	
	if ChaStateLv > statelv then
		SystemNotice ( role , "Better fruit in effect. Please use it later" )
		UseItemFailed ( role )
		return
	end
	local statetime = 900
	local Cha_Boat = 0
	Cha_Boat = GetCtrlBoat ( role )
	if Cha_Boat ==  nil then
		AddState( role , role , STATE_SBBLGZ , statelv , statetime )
	else
		AddState( Cha_Boat , Cha_Boat , STATE_SBBLGZ , statelv , statetime )
	end
end
function ItemUse_RandGr8Fruit ( role, Item )
	local rad = math.random(276,280)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Fairy Box")
		UseItemFailed ( role )
		return
	end
	GiveItem ( role , 0 , rad , 1 , 4 ) 
end
function ItemUse_RandNormalGem ( role, Item )
	local item = {}
	item[1] = {878,879,880,881,882,883,884,887}
	local rad = math.random(1,8)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Fairy Box")
		UseItemFailed ( role )
		return
	end
	GiveItem ( role , 0 , item[1][rad] , 1 , 101 ) 
end
function ItemUse_BFairyBox ( role, Item )
	local item = math.random(15851,15859)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Fairy Box")
		UseItemFailed ( role )
		return
	end
	GiveItem ( role , 0 , item , 1 , 4 ) 
end
Rsks = Rsks or {}
function ItemUse_ResetSkills ( role , item )
	local zsskill_lv = {}
	 zsskill_lv [0] = GetSkillLv ( role, 453 )
	 zsskill_lv [1] = GetSkillLv ( role, 454 )
	 zsskill_lv [2] = GetSkillLv ( role, 455 )
	 zsskill_lv [3] = GetSkillLv ( role, 456 )
	 zsskill_lv [4] = GetSkillLv ( role, 457 )
	 zsskill_lv [5] = GetSkillLv ( role, 458 )
	local n = 0
	local item_canget = GetChaFreeBagGridNum ( role )
	if item_canget < 4 then
		SystemNotice(role ,"You need to have at least 4 empty inventory slot")
		UseItemFailed ( role )
	else
		for i = 0, 5, 1 do
			if zsskill_lv [i] >= 1 then
				n = n+1
			end
		end
		local cha_skill_num=GetChaAttr(role, ATTR_TP )
		local clear_skill_num=ClearFightSkill(role)
		cha_skill_num=cha_skill_num+clear_skill_num
		if n > 0 then
			local job = GetChaAttr( role, ATTR_JOB)
			local item_id = {}
			item_id [8] = 2957
			item_id [9] = 2956
			item_id [12] = 2961
			item_id [13] = 2959
			item_id [14] = 2958
			item_id [16] = 2960
			GiveItem ( role, 0, item_id [job] , 1, 4)
			cha_skill_num = cha_skill_num - 2
		end
		if Rsks[role] == nil then
			Rsks[role] = os.time();
		end
		local cd = Rsks[role] - os.time()
		if cd > 0 then
			SystemNotice(role, 'Skills Reset Potion cooldown on effect wait '..cd..' sec(s) to use again!')
			UseItemFailed(role)
			return
		end
		SystemNotice ( role , "Resetted all abilities successfully, you have obtained "..cha_skill_num.." Skill Points" )
		--GiveItem ( role, 0, 15860, 1, 4)
		SetChaAttr(role, ATTR_TP ,cha_skill_num )
		AddChaSkill ( role , 25, 1 , 1 , 1 )
		local x, y = GetChaPos(role)
		GoTo(role,x,y,"garner")
		local delay = 10
		Rsks[role] = os.time()+delay
		local form_sklv = GetSkillLv( role , sk_add ) 
		if form_sklv ~= 0  then 
			UseItemFailed ( role )  
			return 
		end		
	end
end
function Sk_Script_SprShield ( role , Item ) 											
	local sk_add = 0467 
	local form_sklv = GetSkillLv( role , sk_add ) 
	if form_sklv ~= 0  then
		UseItemFailed ( role )  
		return 
	end 
	a = AddChaSkill ( role , sk_add, 1 , 1 , 1 ) 
	if a== 0 then 
		UseItemFailed ( role )  
		return 
	end 
end 
--[[
function ItemUse_ResetSkills ( role , Item )
	local cha_skill_num=GetChaAttr(role, ATTR_TP  )
	local clear_skill_num=ClearFightSkill(role)
	cha_skill_num=cha_skill_num+clear_skill_num
	if cha_skill_num < 1 then
		SystemNotice ( role , "You do not have enough points to reset. Reset failed!" )
		UseItemFailed ( role )
		return
	end
	SystemNotice ( role , "Resetted all abilities successfully, you have obtained "..cha_skill_num.." Skill Points" )
	SetChaAttr(role, ATTR_TP ,cha_skill_num )
end
]]--
function ItemUse_ResetStats ( role , Item )
	local str = GetChaAttr( role , ATTR_BSTR )
	local agi = GetChaAttr( role , ATTR_BAGI )
	local con = GetChaAttr( role , ATTR_BCON )
	local spr = GetChaAttr( role , ATTR_BSTA )
	local acc = GetChaAttr( role , ATTR_BDEX )
	local ap = GetChaAttr( role , ATTR_AP )
	if str <= 5 and acc <= 5 and agi <= 5 and con <= 5 and spr <= 5 then
		SystemNotice ( role , "You do not have enough points to reset. Reset failed!" )
		UseItemFailed ( role )
		return
	end
	local str_dif = str - 5
	local agi_dif = agi - 5
	local spr_dif = spr - 5
	local acc_dif = acc - 5
	local con_dif = con - 5
	local total_dif = str_dif+agi_dif+spr_dif+acc_dif+con_dif
	ap = ap + total_dif
	SystemNotice ( role , "Resetted all main character attributes successfully, you have obtained "..total_dif.." Stat Points" )
	SetCharaAttr ( 5 , role , ATTR_BSTR )
	SetCharaAttr ( 5 , role , ATTR_BDEX )
	SetCharaAttr ( 5 , role , ATTR_BSTA )
	SetCharaAttr ( 5 , role , ATTR_BCON )
	SetCharaAttr ( 5 , role , ATTR_BAGI )
	SetCharaAttr ( ap , role , ATTR_AP )
end

function ItemUse_SocketSetOne ( role , Item )
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Two inventory slots are required in order to open Socket[1] Chest!")
		UseItemFailed ( role )
		return
	end
	GiveItem ( cha , 0 , 890 , 1 , 4 )
	GiveItem ( cha , 0 , 891 , 1 , 4 )
	local cha_name = GetChaDefaultName ( role )
	LG('Socket[1]Chest', ''..cha_name.. ' obtained Socket Set One!')
end 

function ItemUse_SocketSetTwo ( role , Item )
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Two inventory slots are required in order to open Socket[1] Chest!")
		UseItemFailed ( role )
		return
	end
	GiveItem ( cha , 0 , 15733 , 1 , 4 )
	GiveItem ( cha , 0 , 15734 , 1 , 4 )
	local cha_name = GetChaDefaultName ( role )
	LG('Socket[2]Chest', ''..cha_name.. ' obtained Socket Set Two!')
end 

function ItemUse_SocketSetThree ( role , Item )
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet <= 2 then
		SystemNotice(role ,"Two inventory slots are required in order to open Socket[1] Chest!")
		UseItemFailed ( role )
		return
	end
	GiveItem ( cha , 0 , 15735 , 1 , 4 )
	GiveItem ( cha , 0 , 15736 , 1 , 4 )
	local cha_name = GetChaDefaultName ( role )
	LG('Socket[3]Chest', ''..cha_name.. ' obtained Socket Set Three!')
end 
function ItemUse_WelcomeChest ( role , Item )
	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 

	local Item_CanGet = GetChaFreeBagGridNum ( cha )

	if Item_CanGet == 4 then
		SystemNotice(role ,"Insufficient space in inventory. Unable to open chest")
		UseItemFailed ( role )
		return
	end
	GiveItem ( cha , 0 , 15863 , 50 , 4 )
	--GiveItem ( cha , 0 , 15969 , 1 , 4 )
	GiveItem ( cha , 0 , 15908 , 1 , 4 )
	GiveItem ( cha , 0 , 1128 , 5 , 4 )
	AddMoney( cha , 0 , 50000)
	local cha_name = GetChaDefaultName ( role )
	LG('WelcomeChest', ''..cha_name.. ' Opened Welcome Chest!')
end

function ItemUse_RubyBE ( role , Item )
	local cha = TurnToCha ( role ) 
	local Item_CanGet = GetChaFreeBagGridNum ( cha )
	if Item_CanGet <= 2 then
		SystemNotice(role ,"Two inventory slots are required in order to open Chest!")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,4)
	if rad == 1 then 
	local lv10rad = (math.random(16001,16160))
		GiveItem ( role, 0 , lv10rad , 1 , 4 )
	elseif rad == 2 then
	local lv20rad = (math.random(18561,18720))
		GiveItem ( role, 0 , lv20rad , 1 , 4 )
	elseif rad == 3 then
	local lv40rad = (math.random(21121,21280))
		GiveItem ( role, 0 , lv40rad , 1 , 4 )
	elseif rad == 4 then
	local lv60rad = (math.random(23681,23840))
		GiveItem ( role, 0 , lv60rad , 1 , 4 )
	end
end 

function ItemUse_TopazBR ( role , Item )
	local cha = TurnToCha ( role ) 
	local Item_CanGet = GetChaFreeBagGridNum ( cha )
	if Item_CanGet <= 2 then
		SystemNotice(role ,"Two inventory slots are required in order to open Chest!")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,4)
	if rad == 1 then 
	local lv10rad = (math.random(16161,16320))
		GiveItem ( role, 0 , lv10rad , 1 , 4 )
	elseif rad == 2 then
	local lv20rad = (math.random(18561,18720))
		GiveItem ( role, 0 , lv20rad , 1 , 4 )
	elseif rad == 3 then
	local lv40rad = (math.random(21281,21440))
		GiveItem ( role, 0 , lv40rad , 1 , 4 )
	elseif rad == 4 then
	local lv60rad = (math.random(23841,24000))
		GiveItem ( role, 0 , lv60rad , 1 , 4 )
	end
end 


function ItemUse_OpalEA ( role , Item )
	local cha = TurnToCha ( role ) 
	local Item_CanGet = GetChaFreeBagGridNum ( cha )
	if Item_CanGet <= 2 then
		SystemNotice(role ,"Two inventory slots are required in order to open Chest!")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,4)
	if rad == 1 then 
	local lv10rad = (math.random(16321,16480))
		GiveItem ( role, 0 , lv10rad , 1 , 4 )
	elseif rad == 2 then
	local lv20rad = (math.random(18883,19040))
		GiveItem ( role, 0 , lv20rad , 1 , 4 )
	elseif rad == 3 then
	local lv40rad = (math.random(21441,21600))
		GiveItem ( role, 0 , lv40rad , 1 , 4 )
	elseif rad == 4 then
	local lv60rad = (math.random(24001,24160))
		GiveItem ( role, 0 , lv60rad , 1 , 4 )
	end
end 


function ItemUse_DiamondBEB ( role , Item )
	local cha = TurnToCha ( role ) 
	local Item_CanGet = GetChaFreeBagGridNum ( cha )
	if Item_CanGet <= 2 then
		SystemNotice(role ,"Two inventory slots are required in order to open Chest!")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,3)
	if rad == 1 then 
	local lv40rad = (math.random(21121,21600))
		GiveItem ( role, 0 , lv40rad , 1 , 4 )
	elseif rad == 2 then
	local lv60rad = (math.random(23681,24160))
		GiveItem ( role, 0 , lv60rad , 1 , 4 )
	elseif rad == 3 then
	local lv90rad = (math.random(26241,26720))
		GiveItem ( role, 0 , lv90rad , 1 , 4 )
	end
end 

function random_weaponrace( role, Item)
	local race = GetChaTypeID(role)
	local rad1 = math.random(1,10)
	local rad2 = math.random(1,6)
	local rad3 = math.random(1,12)
	local rad4 = math.random(1,4)
	local item = {}
	item[1] = {15759,15764,15775,15780,15760,15776,15761,15762,15777,15778}
	item[2] = {15761,15762,15777,15778,15763,15779}
	item[3] = {15759,15764,15775,15780,15760,15776,15761,15762,15777,15778,15763,15779}
	item[4] = {15760,15776,15763,15779}
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Weapon Chest")
		UseItemFailed ( role )
		return
	end
	if race == 1 then--lance
		GiveItem ( role , 0 , item[1][rad1] , 1 , 4 )
	elseif race == 2 then--carsise
		GiveItem ( role , 0 , item[2][rad2] , 1 , 4 ) 
	elseif race == 3 then--phyliss
		GiveItem ( role , 0 , item[3][rad3] , 1 , 4 ) 
	elseif race == 4 then--ami
		GiveItem ( role , 0 , item[4][rad4] , 1 , 4 )
	end
end

function random_boots1020( role, Item)
	local item = {}
	item[1] = {15774,15758}
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Boots Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,2)
	GiveItem ( role , 0 , item[1][rad] , 1 , 4 )
end

function random_gloves1020( role, Item)
	local item = {}
	item[1] = {15773,15757}
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Gloves Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,2)
	GiveItem ( role , 0 , item[1][rad] , 1 , 4 )
end

function random_torsos1020( role, Item)
	local item = {}
	item[1] = {15756,15772}
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Torso Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,2)
	GiveItem ( role , 0 , item[1][rad] , 1 , 4 )
end

function random_access10204060( role, Item)
	local item = {}
	item[1] = {15749,15750,15751,15753,15754}
	item[2] = {15765,15766,15767,15769,15770}
	item[3] = {15781,15782,15783,15785,15786}
	item[4] = {15797,15798,15799,15801,15802}
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Accessory Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,5)
	local i = math.random(1,4)
	GiveItem ( role , 0 , item[i][rad] , 1 , 4 )
end

function random_normalgems( role, Item)
	local item = {}
	item[1] = {878,879,880,881,882,883,884,887,864,865,866}
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Gem 2 Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,11)
	GiveItem ( role , 0 , item[1][rad] , 1 , 101 )
end

function random_access90( role, Item)
	local item = {}
	item[1] = {15813,15814,15815,15817,15818}
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Accessory Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,5)
	GiveItem ( role , 0 , item[1][rad] , 1 , 4 )
end

function random_allgems( role, Item)
	local item = {}
	item[1] = {878,879,880,881,882,883,884,887,860,861,862,863,1012,864,865,866}
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Gem 2 Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,16)
	GiveItem ( role , 0 , item[1][rad] , 1 , 101 )
end

function Random_admiralcl( role, Item)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Gem 2 Chest")
		UseItemFailed ( role )
		return
	end
	local item = {}
	local getitem,getrare;
	item[1] = {15902}; -- COMMON 
	item[2] = {15903}; -- REFINED
	item[3] = {15904}; -- LEGENDARY
	local Rariety = math.random(1,100);
	if Rariety > 0 and Rariety <= 69 then
		getrare = 1;
		getitem = math.random(1, table.getn(item[getrare]));
	elseif Rariety > 70 and Rariety <= 90 then
		getrare = 2;
		getitem = math.random(1, table.getn(item[getrare]));
	elseif Rariety > 90 then
		getrare = 3;
		getitem = math.random(1, table.getn(item[getrare]));
	end
	GiveItem(role, 0, item[getrare][getitem], 1, 4);
	LG('RandomAdmiralCloak',''..cha_name..' opened Random Admiral Chest and obtained 1x '..GetItemName(item[getrare][getitem])..'!')
end

function random_lv10weapon( role, Item)
	local item = {}
	item[1] = {15759,15760,15761,15762,15763,15764,15755}
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Lv10 Random Weapon Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,7)
	GiveItem ( role , 0 , item[1][rad] , 1 , 4 )
end

function ItemUse_pluseq27( role, Item )
	local GemSlotAID3 = 12		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 1 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 2		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 9		-- Gem Level - 1 ~ 9
--r13,r23 = MakeItem(role,17761,2,18)-- Your Equip
--	r13,r23 = MakeItem(role,17601,1,18)-- Your Equip
--	r13,r23 = MakeItem(role,17921,1,18)-- Your Equip
--	r13,r23 = MakeItem(role,17120,1,18)-- Your Equip
--	r13,r23 = MakeItem(role,18081,1,18)-- Your Equip
--	r13,r23 = MakeItem(role,18241,1,18)-- Your Equip
	r13,r23 = MakeItem(role,15951,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	

	
end

function Lv10GearChest( role, Item)
	local job = GetChaAttr(role, ATTR_JOB)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 14 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use V1 Gear Chest")
		UseItemFailed ( role )
		return
	end
	if job == 1 then--Swordsman
		GiveItem ( role , 0 , 15935 , 2 , 4 )
		GiveItem ( role , 0 , 15936 , 1 , 4 )
		GiveItem ( role , 0 , 15938 , 1 , 4 )
		GiveItem ( role , 0 , 15939 , 1 , 4 )
		GiveItem ( role , 0 , 15940 , 1 , 4 )
		GiveItem ( role , 0 , 15941 , 1 , 4 )
		GiveItem ( role , 0 , 15942 , 1 , 4 )
--		GiveItem ( role , 0 , 15943 , 1 , 4 )
--		GiveItem ( role , 0 , 15944 , 2 , 4 )
--		GiveItem ( role , 0 , 15945 , 1 , 4 )
		GiveItem ( role , 0 , 15947 , 1 , 4 )
	elseif job == 5 then--Herbalist
		GiveItem ( role , 0 , 15933 , 2 , 4 ) 
		GiveItem ( role , 0 , 15939 , 1 , 4 )
		GiveItem ( role , 0 , 15940 , 1 , 4 )
		GiveItem ( role , 0 , 15941 , 1 , 4 )
		GiveItem ( role , 0 , 15942 , 1 , 4 )
--		GiveItem ( role , 0 , 15943 , 1 , 4 )
--		GiveItem ( role , 0 , 15944 , 2 , 4 )
--		GiveItem ( role , 0 , 15945 , 1 , 4 )
		GiveItem ( role , 0 , 15947 , 1 , 4 )
	elseif job == 4 then--Explorer
		GiveItem ( role , 0 , 15934 , 2 , 4 )
		GiveItem ( role , 0 , 15939 , 1 , 4 )
		GiveItem ( role , 0 , 15940 , 1 , 4 )
		GiveItem ( role , 0 , 15941 , 1 , 4 )
		GiveItem ( role , 0 , 15942 , 1 , 4 )
--		GiveItem ( role , 0 , 15943 , 1 , 4 )
--		GiveItem ( role , 0 , 15944 , 2 , 4 )
--		GiveItem ( role , 0 , 15945 , 1 , 4 )
		GiveItem ( role , 0 , 15947 , 1 , 4 )
	elseif job == 2 then--Hunter
		GiveItem ( role , 0 , 15932 , 1 , 4 )
		GiveItem ( role , 0 , 15937 , 1 , 4 )
		GiveItem ( role , 0 , 15939 , 1 , 4 )
		GiveItem ( role , 0 , 15940 , 1 , 4 )
		GiveItem ( role , 0 , 15941 , 1 , 4 )
		GiveItem ( role , 0 , 15942 , 1 , 4 )
--		GiveItem ( role , 0 , 15943 , 1 , 4 )
--		GiveItem ( role , 0 , 15944 , 2 , 4 )
--		GiveItem ( role , 0 , 15945 , 1 , 4 )
		GiveItem ( role , 0 , 15947 , 1 , 4 )
	else
		SystemNotice(role ,"Available for 1st Classes only!. Unable to use V1 Gear Chest")
		UseItemFailed ( role )
		return
	end
end

function ItemUse_Lv1RefGemz(role, Item)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 1 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Ref Gem Voucher")
		UseItemFailed ( role )
		return
	end
	GiveItem ( role , 0 , 885 , 1 , 101 )
end

function Lv40GearChest( role, Item)
	local job = GetChaAttr(role, ATTR_JOB)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Lv10 Gear Chest")
		UseItemFailed ( role )
		return
	end
	if job == 9 or job == 8 then--Crusader/Champ
		GiveItem ( role , 0 , 15951 , 2 , 4 )
		GiveItem ( role , 0 , 15952 , 1 , 4 )
		GiveItem ( role , 0 , 15954 , 1 , 4 )
		GiveItem ( role , 0 , 15955 , 1 , 4 )
		GiveItem ( role , 0 , 15956 , 1 , 4 )
		GiveItem ( role , 0 , 15957 , 1 , 4 )
		GiveItem ( role , 0 , 15958 , 1 , 4 )
		GiveItem ( role , 0 , 15959 , 1 , 4 )
		GiveItem ( role , 0 , 15960 , 2 , 4 )
		GiveItem ( role , 0 , 15961 , 1 , 4 )
		GiveItem ( role , 0 , 15962 , 2 , 4 )
		GiveItem ( role , 0 , 15963 , 1 , 4 )
	elseif job == 13 or job == 14 then--SM/Cleric
		GiveItem ( role , 0 , 15949 , 2 , 4 )
		GiveItem ( role , 0 , 15955 , 1 , 4 )
		GiveItem ( role , 0 , 15956 , 1 , 4 )
		GiveItem ( role , 0 , 15957 , 1 , 4 )
		GiveItem ( role , 0 , 15958 , 1 , 4 )
		GiveItem ( role , 0 , 15959 , 1 , 4 )
		GiveItem ( role , 0 , 15960 , 2 , 4 )
		GiveItem ( role , 0 , 15961 , 1 , 4 )
		GiveItem ( role , 0 , 15962 , 2 , 4 )
		GiveItem ( role , 0 , 15963 , 1 , 4 )
	elseif job == 16 then--Voy
		GiveItem ( role , 0 , 15950 , 2 , 4 ) 
		GiveItem ( role , 0 , 15955 , 1 , 4 )
		GiveItem ( role , 0 , 15956 , 1 , 4 )
		GiveItem ( role , 0 , 15957 , 1 , 4 )
		GiveItem ( role , 0 , 15958 , 1 , 4 )
		GiveItem ( role , 0 , 15959 , 1 , 4 )
		GiveItem ( role , 0 , 15960 , 2 , 4 )
		GiveItem ( role , 0 , 15961 , 1 , 4 )
		GiveItem ( role , 0 , 15962 , 2 , 4 )
		GiveItem ( role , 0 , 15963 , 1 , 4 )
	elseif job == 12 then--SS
		GiveItem ( role , 0 , 15948 , 1 , 4 )
		GiveItem ( role , 0 , 15953 , 1 , 4 )
		GiveItem ( role , 0 , 15955 , 1 , 4 )
		GiveItem ( role , 0 , 15956 , 1 , 4 )
		GiveItem ( role , 0 , 15957 , 1 , 4 )
		GiveItem ( role , 0 , 15958 , 1 , 4 )
		GiveItem ( role , 0 , 15959 , 1 , 4 )
		GiveItem ( role , 0 , 15960 , 2 , 4 )
		GiveItem ( role , 0 , 15961 , 1 , 4 )
		GiveItem ( role , 0 , 15962 , 2 , 4 )
		GiveItem ( role , 0 , 15963 , 1 , 4 )
	end
end



function Random_Uns75xSet( role, Item)


   local i= CheckBagItem( role,  18807  )	
	if i <=0 then
		SystemNotice(  role , "It appears you do not have enough keys or you have the wrong keys ")
		UseItemFailed ( role )
		return LUA_FALSE
	end
	local s = DelBagItem ( role , 18807 , 1 ) 
	
	
	
	---local Kals_Num = 0
	---if Kals_Num == 3 then
		---local j = TakeItem ( role , 0 , 3457 , Kals_Num )
	



	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Gem 2 Chest")
		UseItemFailed ( role )
		return
	end
	local item = {}
	local getitem,getrare;
	item[1] = {18793}; -- COMMON 
	item[2] = {18794}; -- REFINED
	item[3] = {18795}; -- LEGENDARY
    local Rariety = math.random(1,100);
	if Rariety > 0 and Rariety <= 69 then
		getrare = 1;
		getitem = math.random(1, table.getn(item[getrare]));
	elseif Rariety > 70 and Rariety <= 90 then
		getrare = 2;
		getitem = math.random(1, table.getn(item[getrare]));
	elseif Rariety > 90 then
		getrare = 3;
		getitem = math.random(1, table.getn(item[getrare]));
	end
	GiveItem(role, 0, item[getrare][getitem], 1, 4);
	LG('RandomAdmiralCloak',''..cha_name..' opened Random Admiral Chest and obtained 1x '..GetItemName(item[getrare][getitem])..'!')
	
 
	
	
end

function Random_Uns75xSet( role, Item) --- black dragon chest 


    ---local first = CheckBagItem( role, 18807 )       
    ---local second = CheckBagItem( role, 18808 )      
    ---local third = CheckBagItem( role, 18809 ) 

  local first = CheckBagItem( role, 18807 )                                                

	if first  <=0 then
		SystemNotice(  role , "It appears you don`t have the enough keys,or you have the wrong keys")
		UseItemFailed ( role )
		return LUA_FALSE
	end
	
  local second = CheckBagItem( role, 18808 )                                                

	if second  <=0 then
		SystemNotice(  role , "It appears you don`t have the enough keys,or you have the wrong keys ")
		UseItemFailed ( role )
		return LUA_FALSE
	end




	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Gem 2 Chest")
		UseItemFailed ( role )
		return
	end
	
	local s = DelBagItem ( role , 18807 , 1 )
	local s = DelBagItem ( role , 18808 , 1 )
	
	local item = {}
	local getitem,getrare;
	item[1] = {18818}; -- COMMON 
	item[2] = {18819}; -- REFINED
	item[3] = {18820}; -- LEGENDARY
    local Rariety = math.random(1,100);
	if Rariety > 0 and Rariety <= 69 then
		getrare = 1;
		getitem = math.random(1, table.getn(item[getrare]));
	elseif Rariety > 70 and Rariety <= 90 then
		getrare = 2;
		getitem = math.random(1, table.getn(item[getrare]));
	elseif Rariety > 90 then
		getrare = 3;
		getitem = math.random(1, table.getn(item[getrare]));
	end
	GiveItem(role, 0, item[getrare][getitem], 1, 4);
	LG('RandomAdmiralCloak',''..cha_name..' opened Random Black dragon chest Chest and obtained 1x '..GetItemName(item[getrare][getitem])..'!')
	
     
	
	
	
end

function ItemUse_pluseq29( role, Item)  ---bacldragon v2


		local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 
	local cha_name = GetChaDefaultName ( role )	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	
	 if Item_CanGet < 5 then
		SystemNotice(role ,"Inventory requires at least 5 empty slots to use Random Apparel Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random ( 1, 2 )
	if rad ==1 then --
	GiveItem ( role , 0 , 18812  , 1 , 3 )		
	GiveItem ( role , 0 , 18813  , 1 , 3 )		
	GiveItem ( role , 0 , 18814  , 1 , 3 )		
		
	LG('Random Apparel',''..cha_name..' has opened Random Apparel Chest and obtained 1x '..GetItemName(5525)..'!')
	end
	if rad ==2 then --
	GiveItem ( role , 0 , 18812 , 1 , 3 )
	GiveItem ( role , 0 , 18813 , 1 , 3 )
	GiveItem ( role , 0 , 18814 , 1 , 3 )
	
	LG('Random Apparel',''..cha_name..' has opened Random Apparel Chest and obtained 1x '..GetItemName(5529)..'!')
	end

	
	---item[1] = {18812,18813,18814};


end

function ItemUse_pluseq288( role, Item)  ---black dragon v1


		local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 
	local cha_name = GetChaDefaultName ( role )	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	
	 if Item_CanGet < 5 then
		SystemNotice(role ,"Inventory requires at least 5 empty slots to use Random Apparel Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random ( 1, 2 )
	if rad ==1 then --
	GiveItem ( role , 0 , 2367  , 1 , 3 )		
	GiveItem ( role , 0 , 2368  , 1 , 3 )		
	GiveItem ( role , 0 , 2369  , 1 , 3 )		
		
	LG('Random Apparel',''..cha_name..' has opened Random Apparel Chest and obtained 1x '..GetItemName(5525)..'!')
	end
	if rad ==2 then --
	GiveItem ( role , 0 , 2367 , 1 , 3 )
	GiveItem ( role , 0 , 2368 , 1 , 3 )
	GiveItem ( role , 0 , 2369 , 1 , 3 )
	
	LG('Random Apparel',''..cha_name..' has opened Random Apparel Chest and obtained 1x '..GetItemName(5529)..'!')
	end

	
	---item[1] = {18812,18813,18814};


end

function ItemUse_pluseq268( role, Item)  ---black dragon v3


		local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 
	local cha_name = GetChaDefaultName ( role )	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	
	 if Item_CanGet < 5 then
		SystemNotice(role ,"Inventory requires at least 5 empty slots to use Random Apparel Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random ( 1, 2 )
	if rad ==1 then --
	GiveItem ( role , 0 , 18815  , 1 , 3 )		
	GiveItem ( role , 0 , 18816  , 1 , 3 )		
	GiveItem ( role , 0 , 18817  , 1 , 3 )		
		
	LG('Random Apparel',''..cha_name..' has opened Random Apparel Chest and obtained 1x '..GetItemName(5525)..'!')
	end
	if rad ==2 then --
	GiveItem ( role , 0 , 18815 , 1 , 3 )
	GiveItem ( role , 0 , 18816 , 1 , 3 )
	GiveItem ( role , 0 , 18817 , 1 , 3 )
	
	LG('Random Apparel',''..cha_name..' has opened Random Apparel Chest and obtained 1x '..GetItemName(5529)..'!')
	end

	
	---item[1] = {18812,18813,18814};


end


function Lv101GearChest( role, Item)

    local i= CheckBagItem( role,  18807  )	
	if i <=0 then
		SystemNotice(  role , "It appears you do not have enough keys or you have the wrong keys ")
		UseItemFailed ( role )
		return LUA_FALSE
	end
	
	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 2 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use V1 Gear Chest")
		UseItemFailed ( role )
		return
	end
	
	
  local job = GetChaAttr(role, ATTR_JOB)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 2 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use V1 Gear Chest")
		UseItemFailed ( role )
		return
	end
	if job == 9 then--cruseder
		GiveItem ( role , 0 , 2331 , 2 , 6 )

	elseif job == 14 then--sealmaster     
		GiveItem ( role , 0 , 2343 , 1 , 6 ) 

	elseif job == 16 then--voyger         
		GiveItem ( role , 0 , 2336 , 1 , 6 )

	elseif job == 12 then--Hunter         
		GiveItem ( role , 0 , 2338 , 1 , 6 )

	elseif job == 8 then--champ          
		GiveItem ( role , 0 , 2333 , 1 , 6 )
		
	elseif job == 13 then--cleric         
		GiveItem ( role , 0 , 2341 , 1 , 6 )
		
	
	else
        SystemNotice(role ,"Available for 2st Classes only!. Unable to open Chest")
        UseItemFailed ( role )
        return
    end

    local i = DelBagItem ( role , 18807 , 1 )
	
	

end


---- mount app chest 15978,15979,15981,15982,16021,16022,16023,16024



----belts-chest 15978,15979,15981,15982,16021,16022,16023,16024

function MountGearChest_1(role, Item)
	local cha_name = GetChaDefaultName(role)
	local ChaBoat = 0
	ChaBoat = GetCtrlBoat(role)
	if(ChaBoat ~= nil)then
		SystemNotice(role, "Cannot use while sailing")
		UseItemFailed(role)
		return
	end
	local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	local item = {}
	item[1] = {15978};
	item[2] = {15979};
	item[3] = {15981};
	item[4] = {15982};
	item[5] = {16021};
	item[6] = {16022};
	item[7] = {16023};
	item[8] = {16024};

	local randomapp = math.random(1,8);
	if table.getn(item[randomapp]) > 1 then
		for i=1, table.getn(item[randomapp]) do
			GiveItem(role, 0, item[randomapp][i], 1, 4);
			LG('RandomAppChest',''..cha_name..' opened RandomAppChest and obtained 1x '..GetItemName(item[randomapp][i])..'!')
		end
	else
		GiveItem(role, 0, item[randomapp][1], 1, 4);
		LG('RandomAppChest',''..cha_name..' opened RandomAppChest and obtained 1x '..GetItemName(item[randomapp][1])..'!')
	end	
end
------belt chest ----

function ItemUse_belt2(role, Item)

	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 
	local cha_name = GetChaDefaultName ( role )	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	GiveItem ( role , 0 , 15961  , 1 , 1 )		
	
	LG('Belts',''..cha_name..' has opened Belts chest and obtained 1x '..GetItemName(5525)..'!')
	
	
	

end




function ItemUse_pluseq60( role, Item ) ---crus wepo


  
    


	local GemSlotAID3 = 2		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 12 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 43		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 3		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 4		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 3		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,0776,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq61( role, Item )  --- cleri cwepo


  
    


	local GemSlotAID3 = 5		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 16 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 46		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 3		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 4		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 3		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,0788,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq62( role, Item )  --- sharpshoter wepo 


  
    


	local GemSlotAID3 = 2		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 10 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 37		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 3		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 4		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 3		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,0784,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq63( role, Item )  --- champ wepo 


  
    


	local GemSlotAID3 = 2		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 12 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 43		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 3		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 4		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 3		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,0773,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq64( role, Item )  --- seal master wepo  


  
    


	local GemSlotAID3 = 6		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 16 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 46		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 3		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 4		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 3		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,0795,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq65( role, Item )  --- voyger wepo  


  

	local GemSlotAID3 = 6		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 16 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 46		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 3		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 4		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 3		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,0802,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end


function ItemUse_pluseq67( role, Item )  --- starter armor 


  

	local GemSlotAID3 = 6		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 11 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 40		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 3		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 4		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 3		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,18830,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq68( role, Item )  --- starter glove


  

	local GemSlotAID3 = 4		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 10 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 16		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 3		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 4		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 3		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,18831,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq69( role, Item )  --- starter shoes


  

	local GemSlotAID3 = 7		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 9 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 16		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 3		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 4		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 3		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,18832,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end


function ItemUse_belt1(role, Item)

	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 
	local cha_name = GetChaDefaultName ( role )	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	GiveItem ( role , 0 , 18823  , 1 , 1 )		
	
	LG('Belts',''..cha_name..' has opened Belts chest and obtained 1x '..GetItemName(5525)..'!')
	
	
	

end

function ItemUse_belt3(role, Item)

	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 
	local cha_name = GetChaDefaultName ( role )	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	GiveItem ( role , 0 , 18824  , 2 , 1 )		
	
	LG('Belts',''..cha_name..' has opened Belts chest and obtained 1x '..GetItemName(5525)..'!')
	
	
	

end

---rings

function ItemUse_ring68( role, Item)

	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 2 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use V1 Gear Chest")
		UseItemFailed ( role )
		return
	end
	
	
  local job = GetChaAttr(role, ATTR_JOB)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 2 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use V1 Gear Chest")
		UseItemFailed ( role )
		return
	end
	if job == 9 then--cruseder
		GiveItem ( role , 0 , 0334 , 2 , 6 )

	elseif job == 14 then--sealmaster     
		GiveItem ( role , 0 , 0349 , 2 , 6 ) 

	elseif job == 16 then--voyger         
		GiveItem ( role , 0 , 0349 , 2 , 6 )

	elseif job == 12 then--Hunter         
		GiveItem ( role , 0 , 0347 , 2 , 6 )

	elseif job == 8 then--champ          
		GiveItem ( role , 0 , 0334 , 2 , 6 )
		
	elseif job == 13 then--cleric         
		GiveItem ( role , 0 , 0349 , 2 , 6 )
		
	
	else
        SystemNotice(role ,"Available for 2st Classes only!. Unable to open Chest")
        UseItemFailed ( role )
        return
    end

   
	
	

end

---necklace 

function ItemUse_neck69(role, Item)

	local cha = TurnToCha ( role ) 
	local cha_type = GetChaTypeID ( cha ) 
	local cha_name = GetChaDefaultName ( role )	
	
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	GiveItem ( role , 0 , 0739  , 2 , 1 )		
	
	LG('Belts',''..cha_name..' has opened Belts chest and obtained 1x '..GetItemName(5525)..'!')
	
	
	

end

function ItemUse_pluseq85( role, Item )  --- starter armor 


  

	local GemSlotAID3 = 14		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 11 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 55		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 9		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,18815,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq86( role, Item )  --- starter armor 


  

	local GemSlotAID3 = 14		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 11 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 55		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 9		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,18816,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq87( role, Item )  --- starter armor 


  

	local GemSlotAID3 = 10		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 11 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 57		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 9		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,15948,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq88( role, Item )  --- starter armor 


  

	local GemSlotAID3 = 12		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 13 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 54		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 9		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,0776,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_beltneck2( role, Item) --- black dragon chest 



	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Gem 2 Chest")
		UseItemFailed ( role )
		return
	end
	

	
	local item = {}
	local getitem,getrare;
	item[1] = {18826}; -- COMMON 
	item[2] = {18827}; -- REFINED
	item[3] = {18828}; -- LEGENDARY
    local Rariety = math.random(1,100);
	if Rariety > 0 and Rariety <= 69 then
		getrare = 1;
		getitem = math.random(1, table.getn(item[getrare]));
	elseif Rariety > 70 and Rariety <= 90 then
		getrare = 2;
		getitem = math.random(1, table.getn(item[getrare]));
	elseif Rariety > 90 then
		getrare = 3;
		getitem = math.random(1, table.getn(item[getrare]));
	end
	GiveItem(role, 0, item[getrare][getitem], 1, 4);
	LG('RandomAdmiralCloak',''..cha_name..' opened Random Black dragon chest Chest and obtained 1x '..GetItemName(item[getrare][getitem])..'!')
	
     
	
	
	
end

function ItemUse_pluseq11( role, Item )  --- beta bow  


  

	local GemSlotAID3 = 10		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 57 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 13		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 6		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 5		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,2339,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end
function ItemUse_pluseq12( role, Item )  --- beta staf sm  


  

	local GemSlotAID3 = 16		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 58 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 48		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 6		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 5		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,2343,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq13( role, Item )  --- beta hammer sm  


  

	local GemSlotAID3 = 12		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 54 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 13		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 6		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 5		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,2334,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq14( role, Item )  --- beta sowrds sm  


  

	local GemSlotAID3 = 12		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 54 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 13		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 6		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 5		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,2331,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq15( role, Item )  --- beta dagger   


  

	local GemSlotAID3 = 16		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 58 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 48		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 6		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 5		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,2335,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end
function ItemUse_pluseq16( role, Item )  --- beta armor   


  

	local GemSlotAID3 = 11		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 55 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 14		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 6		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 5		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,18812,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end
function ItemUse_pluseq17( role, Item )  --- beta claw   


  

	local GemSlotAID3 = 4		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 15 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 50		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 6		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 5		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,18813,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq18( role, Item )  --- beta shoes   


  

	local GemSlotAID3 = 9		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 56 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 50		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 6		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 5		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,18814,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_petstr ( role , Item )
    local Item_CanGet = GetChaFreeBagGridNum ( role ) 
    if Item_CanGet <= 1 then
        SystemNotice(role ,"Insufficient slot in inventory. Failed to use!")
        UseItemFailed ( role )
        return
    end
local new_str= 52

local new_lv = 5000
local r1,r2 = MakeItem ( role , 681 , 1 , 4 )
local Item_newJL = GetChaItem ( role , 2 , r2 )
SetItemAttr ( Item_newJL , ITEMATTR_VAL_STR , new_str )

SetItemAttr ( Item_newJL , ITEMATTR_VAL_LV , new_lv )
SetItemAttr ( Item_newJL , ITEMATTR_MAXURE , 32000 )
SetItemAttr ( Item_newJL , ITEMATTR_URE , 32000 )
SetItemAttr ( Item_newJL , ITEMATTR_MAXENERGY , 6480 )
SetItemAttr ( Item_newJL , ITEMATTR_ENERGY , 6480 )
RefreshCha(role)
end

function ItemUse_petacc ( role , Item )
    local Item_CanGet = GetChaFreeBagGridNum ( role ) 
    if Item_CanGet <= 1 then
        SystemNotice(role ,"Insufficient slot in inventory. Failed to use!")
        UseItemFailed ( role )
        return
    end


local new_acc= 52

local new_lv = 5000
local r1,r2 = MakeItem ( role , 681 , 1 , 4 )
local Item_newJL = GetChaItem ( role , 2 , r2 )
--SetItemAttr ( Item_newJL , ITEMATTR_VAL_STR , new_str )
--SetItemAttr ( Item_newJL , ITEMATTR_VAL_CON , new_con )
SetItemAttr ( Item_newJL , ITEMATTR_VAL_DEX , new_acc )
--SetItemAttr ( Item_newJL , ITEMATTR_VAL_AGI , new_agi )
--SetItemAttr ( Item_newJL , ITEMATTR_VAL_STA , new_spr )
SetItemAttr ( Item_newJL , ITEMATTR_VAL_LV , new_lv )
SetItemAttr ( Item_newJL , ITEMATTR_MAXURE , 32000 )
SetItemAttr ( Item_newJL , ITEMATTR_URE , 32000 )
SetItemAttr ( Item_newJL , ITEMATTR_MAXENERGY , 6480 )
SetItemAttr ( Item_newJL , ITEMATTR_ENERGY , 6480 )
RefreshCha(role)
end

----unction ItemUse_petaspr ( role , Item )

function ItemUse_petaspr ( role , Item )
    local Item_CanGet = GetChaFreeBagGridNum ( role ) 
    if Item_CanGet <= 1 then
        SystemNotice(role ,"Insufficient slot in inventory. Failed to use!")
        UseItemFailed ( role )
        return
    end


local new_spr= 52

local new_lv = 5000
local r1,r2 = MakeItem ( role , 681 , 1 , 4 )
local Item_newJL = GetChaItem ( role , 2 , r2 )
--SetItemAttr ( Item_newJL , ITEMATTR_VAL_STR , new_str )
--SetItemAttr ( Item_newJL , ITEMATTR_VAL_CON , new_con )
--SetItemAttr ( Item_newJL , ITEMATTR_VAL_DEX , new_acc )
--SetItemAttr ( Item_newJL , ITEMATTR_VAL_AGI , new_agi )
SetItemAttr ( Item_newJL , ITEMATTR_VAL_STA , new_spr )
SetItemAttr ( Item_newJL , ITEMATTR_VAL_LV , new_lv )
SetItemAttr ( Item_newJL , ITEMATTR_MAXURE , 32000 )
SetItemAttr ( Item_newJL , ITEMATTR_URE , 32000 )
SetItemAttr ( Item_newJL , ITEMATTR_MAXENERGY , 6480 )
SetItemAttr ( Item_newJL , ITEMATTR_ENERGY , 6480 )
RefreshCha(role)
end

function ItemUse_pluseq18( role, Item )  --- beta shoes   


  

	local GemSlotAID3 = 9		-- Gem Stone ID A ( Can be founded in stoneinfo.txt )
	local GemSlotBID3 = 56 		-- Gem Stone ID B ( Can be founded in stoneinfo.txt )	
	local GemSlotCID3 = 51		-- Gem Stone ID C ( Can be founded in stoneinfo.txt )
	local GemSlotALevel3 = 9		-- Gem Level - 1 ~ 9
	local GemSlotBLevel3 = 6		-- Gem Level - 1 ~ 9
	local GemSlotCLevel3 = 5		-- Gem Level - 1 ~ 9

	r13,r23 = MakeItem(role,18814,1,18)-- Your Equip

	local Equipp3 = GetChaItem(role,2,r23)
    local param3 = GetItemForgeParam(Equipp3,1)
    local Item_Stone3 = {}
    local Item_StoneLv3 = {}


     

    param3 = TansferNum(param3)
    Item_Stone3[0] = GetNum_Part2(param3)
    Item_StoneLv3[0] = GetNum_Part3(param3)
    Item_Stone3[0] = GemSlotAID3				
    Item_StoneLv3[0] = GemSlotALevel3					
    param3 = SetNum_Part2(param3, Item_Stone3[0]) 			
    param3 = SetNum_Part3(param3, Item_StoneLv3[0]) 		
    SetItemForgeParam(Equipp3, 1, param3)
	
    param3= TansferNum(param3)
    Item_Stone3[1] = GetNum_Part2(param3)
    Item_StoneLv3[1] = GetNum_Part3(param3)
    Item_Stone3[1] =  GemSlotBID3						
    Item_StoneLv3[1] = GemSlotBLevel3					
    param3 = SetNum_Part4(param3, Item_Stone3[1]) 			
    param3 = SetNum_Part5(param3, Item_StoneLv3[1]) 	
    SetItemForgeParam(Equipp3, 1, param3)

    param3 = TansferNum(param3)
    Item_Stone3[2] = GetNum_Part2(param3)
    Item_StoneLv3[2] = GetNum_Part3(param3)
    Item_Stone3[2] = GemSlotCID3				
    Item_StoneLv3[2] = GemSlotCLevel3		
    param3 = SetNum_Part6(param3, Item_Stone3[2]) 			
    param3 = SetNum_Part7(param3, Item_StoneLv3[2]) 		
    SetItemForgeParam(Equipp3, 1, param3)

	local Socket3 = GetItemForgeParam(Equipp3, 1)
	Socket3 = TansferNum(Socket3)
	Socket3 = SetNum_Part1(Socket3, 3)
	SetItemForgeParam(Equipp3, 1, Socket3)
	RefreshCha(role)
	
		local CheckBag = GetChaFreeBagGridNum(role)
	if(CheckBag < 2)then
		SystemNotice(role, "Requires 2 empty slots to open!")
		UseItemFailed(role)
		return
	end
	
	
end

function ItemUse_pluseq93 ( role , Item )
	local Cha_Boat = 0
	local charLv=Lv ( role )
	local dif_exp_five = DEXP[75]

	Cha_Boat = GetCtrlBoat ( role )
	if Cha_Boat ~=  nil then
		SystemNotice( role , "Cannot use while sailing" )
		UseItemFailed ( role )
		return
	end
	if charLv < 75 then
		SetChaAttrI( role , ATTR_CEXP , dif_exp_five )
	else
		SystemNotice( role , "Level too high to use" )
		UseItemFailed ( role )
		return
	end
end




function ItemUse_petcon ( role , Item )
    local Item_CanGet = GetChaFreeBagGridNum ( role ) 
    if Item_CanGet <= 1 then
        SystemNotice(role ,"Insufficient slot in inventory. Failed to use!")
        UseItemFailed ( role )
        return
    end
local new_con= 52

local new_lv = 5000
local r1,r2 = MakeItem ( role , 681 , 1 , 4 )
local Item_newJL = GetChaItem ( role , 2 , r2 )
SetItemAttr ( Item_newJL , ITEMATTR_VAL_CON , new_con )

SetItemAttr ( Item_newJL , ITEMATTR_VAL_LV , new_lv )
SetItemAttr ( Item_newJL , ITEMATTR_MAXURE , 32000 )
SetItemAttr ( Item_newJL , ITEMATTR_URE , 32000 )
SetItemAttr ( Item_newJL , ITEMATTR_MAXENERGY , 6480 )
SetItemAttr ( Item_newJL , ITEMATTR_ENERGY , 6480 )
RefreshCha(role)

end

function random_biongogems( role, Item)
	local item = {}
	item[1] = {6900,6901,6902,6903,6904}
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Gem 2 Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,4)
	GiveItem ( role , 0 , item[1][rad] , 1 , 101 )
end

function random_unqiuegems( role, Item)
	local item = {}
	item[1] = {0860,0861,0862,0863,1012}
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet <= 0 then
		SystemNotice(role ,"Insufficient inventory space. Unable to use Random Gem 2 Chest")
		UseItemFailed ( role )
		return
	end
	local rad = math.random(1,11)
	GiveItem ( role , 0 , item[1][rad] , 1 , 101 )
end






function random_azraelgems( role, Item)

	local Item_CanGet = GetChaFreeBagGridNum ( role )	 
	if Item_CanGet <= 2 then	 
		SystemNotice(role ,"Insufficient inventory space. Unable to use this Chest")	 
		UseItemFailed ( role )	 
		return	 
    end
      
 
    local Money_Need = 33000000
    local Money_Have = GetChaAttr ( role , ATTR_GD )
    if Money_Have < Money_Need then
        SystemNotice( role ," Insufficient gold you must have    ( 33,000,000 ) G! to Open this Chest.")
        UseItemFailed ( role )		
        return 0
    end
    TakeMoney(role,nil,Money_Need)

	
	
	
	local rad = math.random ( 1, 5 )
	if rad ==1 then --
	GiveItem ( role , 0 , 5845  , 1 , 2 )		
	GiveItem ( role , 0 , 18856  , 1 , 2 )		
	
	---LG('Grand Coin',''..cha_name..' has opened Grand Coin Chest and obtained 1x '..GetItemName(5525)..'!')
	end
	if rad ==2 then --
	GiveItem ( role , 0 , 18856  , 1 , 2 )
	GiveItem ( role , 0 , 5846  , 1 , 2 )

	---LG('Grand Coin',''..cha_name..' has opened Grand Coin Chest and obtained 1x '..GetItemName(5529)..'!')
	end
	if rad ==3 then --
	GiveItem ( role , 0 , 5847  , 1 , 2 )
	GiveItem ( role , 0 , 18856  , 1 , 2 )

	---LG('Grand Coin',''..cha_name..' has opened Grand Coin Chest and obtained 1x '..GetItemName(5533)..'!')
	end
	if rad ==4 then --
	GiveItem ( role , 0 , 18856  , 1 , 4 )
	GiveItem ( role , 0 , 5848  , 1 , 2 )

	---LG('Grand Coin',''..cha_name..' has opened Grand Coin Chest and obtained 1x '..GetItemName(5553)..'!')
	end
	if rad ==5 then --
	GiveItem ( role , 0 , 5849  , 1 , 2)	
	GiveItem ( role , 0 , 18856  , 1 , 2)	

	---LG('Grand Coin',''..cha_name..' has opened Grand Coin Chest and obtained 1x '..GetItemName(5569)..'!')	
	end
	
	
	

	
	
end





function unqifairy_1chest (role, Item)





  local Item_CanGet = GetChaFreeBagGridNum ( role )	 
	if Item_CanGet <= 2 then	 
		SystemNotice(role ,"Insufficient inventory space. Unable to use this Chest")	 
		UseItemFailed ( role )	 
		return	 
    end



 local Money_Need = 2500000
    local Money_Have = GetChaAttr ( role , ATTR_GD )
    if Money_Have < Money_Need then
        SystemNotice( role ," Insufficient gold you must have    ( 2,500,000 ) G! to Open this Chest.")
        UseItemFailed ( role )		
        return 0
    end
    TakeMoney(role,nil,Money_Need)

	
	
	
	local rad = math.random ( 1, 5 )
	if rad ==1 then --
	GiveItem ( role , 0 , 0860  , 1 , 2 )		
	GiveItem ( role , 0 , 18855  , 1 , 2 )		
	
	---LG('Unique Coin',''..cha_name..' has opened Unique Coin Chest and obtained 1x '..GetItemName(5525)..'!')
	end
	if rad ==2 then --
	GiveItem ( role , 0 , 18855  , 1 , 2 )
	GiveItem ( role , 0 , 0861  , 1 , 2 )

	---LG('Unique Coin',''..cha_name..' has opened Unique Coin Chest and obtained 1x '..GetItemName(5529)..'!')
	end
	if rad ==3 then --
	GiveItem ( role , 0 , 0862  , 1 , 2 )
	GiveItem ( role , 0 , 18855  , 1 , 2 )

	---LG('Unique Coin',''..cha_name..' has opened Unique Coin Chest and obtained 1x '..GetItemName(5533)..'!')
	end
	if rad ==4 then --
	GiveItem ( role , 0 , 18855  , 1 , 4 )
	GiveItem ( role , 0 , 0863  , 1 , 2 )

	---LG('Unique Coin',''..cha_name..' has opened Unique Coin Chest and obtained 1x '..GetItemName(5553)..'!')
	end
	if rad ==5 then --
	GiveItem ( role , 0 , 1012  , 1 , 2)	
	GiveItem ( role , 0 , 18855  , 1 , 2)	

	---LG('Unique Coin',''..cha_name..' has opened Unique Coin Chest and obtained 1x '..GetItemName(5569)..'!')	
	end



end


function unqifairy_2chest (role, Item)





  local Item_CanGet = GetChaFreeBagGridNum ( role )	 
	if Item_CanGet <= 2 then	 
		SystemNotice(role ,"Insufficient inventory space. Unable to use this Chest")	 
		UseItemFailed ( role )	 
		return	 
    end



 local Money_Need = 5000000
    local Money_Have = GetChaAttr ( role , ATTR_GD )
    if Money_Have < Money_Need then
        SystemNotice( role ," Insufficient gold you must have    ( 2,500,000 ) G! to Open this Chest.")
        UseItemFailed ( role )		
        return 0
    end
    TakeMoney(role,nil,Money_Need)

	
	
	
	local rad = math.random ( 1, 5 )
	if rad ==1 then --
	GiveItem ( role , 0 , 6900  , 1 , 2 )		
	GiveItem ( role , 0 , 18870  , 1 , 2 )		
	
	LG('Mini Coin',''..cha_name..' has opened Mini Coin Chest and obtained 1x '..GetItemName(5525)..'!')
	end
	if rad ==2 then --
	GiveItem ( role , 0 , 18870  , 1 , 2 )
	GiveItem ( role , 0 , 6901  , 1 , 2 )

	LG('Mini Coin',''..cha_name..' has opened Mini Coin Chest and obtained 1x '..GetItemName(5529)..'!')
	end
	if rad ==3 then --
	GiveItem ( role , 0 , 6902  , 1 , 2 )
	GiveItem ( role , 0 , 18870  , 1 , 2 )

	LG('Mini Coin',''..cha_name..' has opened Mini Coin Chest and obtained 1x '..GetItemName(5533)..'!')
	end
	if rad ==4 then --
	GiveItem ( role , 0 , 18870  , 1 , 4 )
	GiveItem ( role , 0 , 6903  , 1 , 2 )

	LG('Mini Coin',''..cha_name..' has opened Mini Coin Chest and obtained 1x '..GetItemName(5553)..'!')
	end
	if rad ==5 then --
	GiveItem ( role , 0 , 6904  , 1 , 2)	
	GiveItem ( role , 0 , 18870  , 1 , 2)	

	LG('Random Apparel',''..cha_name..' has opened Mini Coin Chest and obtained 1x '..GetItemName(5569)..'!')	
	end



end








---if table.getn(item[randomapp]) > 1 then
---	for i=1, table.getn(item[randomapp]) do
---		GiveItem(role, 0, item[randomapp][i], 1, 4);
---		LG('RandomAppChest',''..cha_name..' opened RandomAppChest and obtained 1x '..GetItemName(item[randomapp][i])..'!')---local CheckBag = GetChaFreeBagGridNum(role)
---	end---if(CheckBag < 5)then
---else---	SystemNotice(role, "Requires 5 empty slots to open!")
---	GiveItem(role, 0, item[randomapp][1], 1, 4);---	UseItemFailed(role)
---	LG('RandomAppChest',''..cha_name..' opened RandomAppChest and obtained 1x '..GetItemName(item[randomapp][1])..'!')---	return
---end	
---
---end
---local item = {}
---item[1] = {5755,5756,5757,5758};
---item[2] = {5772,5773,5774,5775};
---item[3] = {5792,5793,5794,5795};
---item[4] = {5803,5804,5805,5806};
---item[5] = {6500,6501,6502};
---
---item[1] = {5845,5846,5847,5848,5849}




---    local i= CheckBagItem( role,  18807  )	
---	if i <=0 then
---		SystemNotice(  role , "It appears you do not have enough keys or you have the wrong keys ")
---		UseItemFailed ( role )
---		return LUA_FALSE
---	end
---	
---	
---	
---	local Item_CanGet = GetChaFreeBagGridNum ( role )
---	if Item_CanGet <= 2 then
---		SystemNotice(role ,"Insufficient inventory space. Unable to use V1 Gear Chest")
---		UseItemFailed ( role )
---		return
---	end
---	
---	
---  local job = GetChaAttr(role, ATTR_JOB)
---	local Item_CanGet = GetChaFreeBagGridNum ( role )
---	if Item_CanGet <= 2 then
---		SystemNotice(role ,"Insufficient inventory space. Unable to use V1 Gear Chest")
---		UseItemFailed ( role )
---		return
---	end
---	if job == 9 then--cruseder
---		GiveItem ( role , 0 , 2331 , 2 , 6 )
---
---	elseif job == 14 then--sealmaster     
---		GiveItem ( role , 0 , 2343 , 1 , 6 ) 
---
---	elseif job == 16 then--voyger         
---		GiveItem ( role , 0 , 2336 , 1 , 6 )
---
---	elseif job == 12 then--Hunter         
---		GiveItem ( role , 0 , 2338 , 1 , 6 )
---
---	elseif job == 8 then--champ          
---		GiveItem ( role , 0 , 2333 , 1 , 6 )
---		
---	elseif job == 13 then--cleric         
---		GiveItem ( role , 0 , 2341 , 1 , 6 )
---		
---	
---	else
---        SystemNotice(role ,"Available for 2st Classes only!. Unable to open Chest")
---        UseItemFailed ( role )
---        return
---    end
---
---    local i = DelBagItem ( role , 18807 , 1 )