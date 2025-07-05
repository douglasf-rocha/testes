print("* Loading <BoEUpgrade> init.lua" )
	upgBoE							= {}
		upgBoE.conf				= {
			BoEId					= 0776,
			dustyId					= 7873,
			BoESlot				= 5,
			maxLv					= 13,
		}
		upgBoE.upRate				= {}
		upgBoE.upRate[0]			= .5
		upgBoE.upRate[1]			= .5
		upgBoE.upRate[2]			= .5
		upgBoE.upRate[3]			= .5
		upgBoE.upRate[4]			= .5
		upgBoE.upRate[5]			= .5
		upgBoE.upRate[6]			= .5
		upgBoE.upRate[7]			= .5
		upgBoE.upRate[8]			= .5
		upgBoE.upRate[9]			= .5
		upgBoE.upRate[10]			= .5
		upgBoE.upRate[11]			= .5
		upgBoE.upRate[12]			= .5
		upgBoE.upRate[13]			= .5

	function upgBoE.getLv(BoE)
		local BoELv				= GetItemAttr(BoE, 55)
		if BoELv == nil then
			return 0
		else
			return BoELv
		end
	end
	
	function BoE_Unseal(Player, Item)
		local Cha_Boat				= 0
		Cha_Boat 					= GetCtrlBoat(Player)
		if Cha_Boat ~= nil then 
			SystemNotice(Player, 'Cannot use while sailing!')
			UseItemFailed(Player) 
			return 
		end	
		local hasDusty				= CheckBagItem(Player, upgBoE.conf['dustyId'])
		if hasDusty < 1 then
			BickerNotice(Player, 'You need ['..GetItemName(upgBoE.conf['dustyId'])..'] in your inventory!')
			UseItemFailed(Player)
			return
		else
			--TakeItem(Player, 0, upgBoE.conf['dustyId'], 1)
			GiveItem(Player, 0, upgBoE.conf['BoEId'], 1, 90)
			Notice(GetChaDefaultName(Player)..' has unleashed '..GetItemName(upgBoE.conf['dustyId'])..' and received Blade of Enigma!')
			PlayEffect(Player, 345)
		end
	end
	
	function BoE_Injection(Player, Item)
		local Cha_Boat				= 0
		Cha_Boat 					= GetCtrlBoat(Player)
		if Cha_Boat ~= nil then 
			SystemNotice(Player, 'Cannot use while sailing!') 
			UseItemFailed(Player) 
			return 
		end	
		local Injection				= {}
		Injection[7874]				= {AttrType = ITEMATTR_VAL_STR, AttrAdd = 1, AttrMax = 13, AttrName = 'Strength'}		--Maximum of Str
		Injection[7875]				= {AttrType = ITEMATTR_VAL_CON, AttrAdd = 1, AttrMax = 13, AttrName = 'Constitution'}	--Maximum of Con
		Injection[7876]				= {AttrType = ITEMATTR_VAL_DEX, AttrAdd = 1, AttrMax = 13, AttrName = 'Accuracy'}		--Maximum of Acc
		Injection[7877]				= {AttrType = ITEMATTR_VAL_AGI, AttrAdd = 1, AttrMax = 13, AttrName = 'Agility'}	    --Maximum of Agi
		Injection[7878]				= {AttrType = ITEMATTR_VAL_STA, AttrAdd = 1, AttrMax = 13, AttrName = 'Spirit'}			--Maximum of Spr
		local ItemId				= GetItemID(Item)
		if Injection[ItemId] == nil then
			SystemNotice(Player, 'Internal error!')
			UseItemFailed(Player)
			return
		end
		local slot					= GetChaItem(Player, 2, (upgBoE.conf['BoESlot'] -1))
		local slotId				= GetItemID(slot)
		local BoELv				= upgBoE.getLv(slot)
		if slot == nil then
			BickerNotice(Player, 'Please place Blade of Enigma on 5th inventory slot!')
			UseItemFailed(Player)
			return
		end
		if slotId == upgBoE.conf['BoEId'] then
			BickerNotice(Player, GetItemName(upgBoE.conf['BoEId'])..' must be placed on 5th inventory slot!')
			UseItemFailed(Player)
			return
		end
		if BoELv >= upgBoE.conf['maxLv'] then
			BickerNotice(Player, GetItemName(upgBoE.conf['BoEId'])..' can no longer be enchanted.')
			UseItemFailed(Player)
			return
		end
		local upChance				= Percentage_Random(upgBoE.upRate[BoELv])		
		local statAdd				= Injection[ItemId].AttrAdd
		local attrNum 				= GetItemAttr(slot, Injection[ItemId].AttrType)
		if attrNum >= Injection[ItemId].AttrMax then
        BickerNotice(Player, Injection[ItemId].AttrName..' reached it\'s maximum = '..Injection[ItemId].AttrMax..'!')
        UseItemFailed(Player)
        return
    end   		
		
	
		
		local newLv					= BoELv + 1		
		if upChance == 1 then
			attrNum					= attrNum + statAdd
			SetItemAttr(slot, Injection[ItemId].AttrType, attrNum)
			SetItemPrefix(slot, 61)
			SetItemAttr(slot, 55, newLv)
			SystemNotice(Player, 'Awesome! successfully enchanted Blade of Enigma to +'..newLv..'.')
			PlayEffect(Player, 345)
			RefreshCha(Player)
		else
			SystemNotice(Player, 'Enchanting failed..')
			PlayEffect(Player, 346)
		end
	end