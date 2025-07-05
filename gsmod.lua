print('Loading gsmod.lua')

--[[
-- OnBankItem
-- @author: kong@pkodev.net
-- @param role - player who is banking
-- @param item - userdata item type of targeted item
-- @return return 1 to allow banking, return 0 to prevent banking
-- Fixed Bag of Holding Dupe by Rinor
--]]
function OnBankItem(role, item)
	local itemID = GetItemID(item)
	local itemtype = GetItemType(item)
	if itemtype == 43 or itemtype == 45 or itemtype == 46 or itemID == 15044 or itemID == 15045 then
		return 0
	end
	return 1
end

function RightClickHandle(role,item)
	local itemType = GetItemType(item)
	if itemType == 59 and FairyObj then
		local fairy = FairyObj:Create(role)
		if fairy and fairy.Fairy == item then
			fairy:Open()
		end
		return 0
	end
	return 1
end


function BeforeLeaveMap(role)

end

function AfterEnterMap(role)
		local PID										=  GetPlayerID(GetChaPlayer(role))
		if (GetChaMapName(role) ~= "ctf") then
			if (GetChaStateLv(role, CTF.Conf.Flag.State) ~= 0) then
				RemoveState(role, CTF.Conf.Flag.State)
			end
		end
end

function AfterCastSkill(ATKER,DEFER,skill,lv)

end

function OnDeath(role)

end