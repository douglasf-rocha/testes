print('Loading tickets.lua')


teletix = {}	-- for tickets
teletix_prohibit = {}

teletix[3141] = ""							Jz_Script_hc = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[0332] = "Spring Town"				Jz_Script_cfzs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[0563] = "Summer Island"				Jz_Script_xdfjp = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[0583] = "Autumn Island"				Jz_Script_qdfjp = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[2445] = "Caribbean"					Jz_Script_jialebi = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[2447] = "Skeletar Isle"			TW_Ticket_Script2 = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[2491] = "Naval Base"				TW_Ticket_Script3 = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[2844] = "Abaddon 4"					Jz_Script_4thDy = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3048] = "Thundoria Castle"			Jz_Script_ltcsA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3049] = "Thundoria Harbor"			Jz_Script_ltjgcsA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3050] = "Sacred Snow Mountain"		Jz_Script_sxscsA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3051] = "Andes Forest Haven"		Jz_Script_laslcsA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3052] = "Oasis Haven"				Jz_Script_sqcsA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3053] = "Icespire Haven"			Jz_Script_bjcsA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3054] = "Lone Tower Entrace"		Jz_Script_jmztcsA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3055] = "Barren Cavern Entrance"	Jz_Script_scrkcsA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3056] = "Abandon Mine 2"			Jz_Script_fk2csA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3057] = "Silver Mine 2"				Jz_Script_yk2csA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3058] = "Silver Mine 3"				Jz_Script_yk3csA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3059] = "Lone Tower 2"				Jz_Script_jmzt2csA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3060] = "Lone Tower 3"				Jz_Script_jmzt3csA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3070] = "Lone Tower 4"				Jz_Script_jmzt4csA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3071] = "Lone Tower 5"				Jz_Script_jmzt5csA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3072] = "Lone Tower 6"				Jz_Script_jmzt6csA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3073] = "Abandon Mine 1"			Jz_Script_fk1csA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3076] = "Spring Town"				Jz_Script_cfzsA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3828] = "Thundoria Castle"			Jz_Script_ltcs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3829] = "Thundoria Harbor"			Jz_Script_ltjgcs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3830] = "Sacred Snow Mountain"		Jz_Script_sxscs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3831] = "Andes Forest Haven"		Jz_Script_laslcs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3832] = "Oasis Haven"				Jz_Script_sqcs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3833] = "Icespire Haven"			Jz_Script_bjcs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3834] = "Lone Tower Entrace"		Jz_Script_jmztcs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3835] = "Barren Cavern Entrance"	Jz_Script_scrkcs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3836] = "Abandon Mine 2"			Jz_Script_fk2cs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3837] = "Silver Mine 2"				Jz_Script_yk2cs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3838] = "Silver Mine 3"				Jz_Script_yk3cs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3839] = "Lone Tower 2"				Jz_Script_jmzt2cs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3840] = "Lone Tower 3"				Jz_Script_jmzt3cs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3841] = "Lone Tower 4"				Jz_Script_jmzt4cs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3842] = "Lone Tower 5"				Jz_Script_jmzt5cs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3843] = "Lone Tower 6"				Jz_Script_jmzt6cs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3847] = "Abandon Mine 1"			Jz_Script_fk1cs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[4602] = "Argent City"				Jz_Script_bycs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[4603] = "Shaitan City"				Jz_Script_slcs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[4604] = "Icicle Castle"				Jz_Script_blbcs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3024] = "Church"					Jz_Script_yszs = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[3076] = "Spring Town"				Jz_Script_spring = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[5620] = "Summer Island"				Jz_Script_summer = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[5621] = "Autumn Island"				Jz_Script_autumn = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[5622] = "Caribbean"					Jz_Script_caribbean = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[5623] = "Abaddon 4"					Jz_Script_4clime = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[5624] = "Sacred Snow Mountain"		Jz_Script_jokul = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[5625] = "Thundoria Castle"			Jz_Script_lante = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[11105] = "Winter Island"				Winter_Ticket_Azure1 = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[6398] = "Icespire Haven"			Jz_Script_bjcsA1 = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[6399] = "Andes Forest Haven"		Jz_Script_laslcsA1 = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[6400] = "Thundoria Harbor"			Jz_Script_ltjgcsA1 = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[6401] = "Sacred Snow Mountain"		Jz_Script_sxscsA1 = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[6454] = "Abandon Mine 1"			Jz_Script_fk1csA = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[6455] = "Caribbean"					Jz_Script_jialebi = function(role,Item) ItemUse_Ticket(role,Item) end
teletix[9500] = "Argent Bar"

teletix_prohibit['prisonisland'] = true

function ItemUse_Ticket(role, Item)
	local itemId = GetItemID(Item)
--	if (Hp(role) < Mxhp(role) * 0.5) or (Sp(role) < Mxsp(role) * 0.5) then 
	if (Hp(role) < Mxhp(role)) or (Sp(role) < Mxsp(role)) then 
		SystemNotice(role, "You need to have full HP and SP to teleport.")
		UseItemFailed(role)
		return
	end
	if ChaIsBoat(role) == 1 then
		SystemNotice(role, "Cannot use while sailing!")
		UseItemFailed(role)
		return
	end
	if teletix_prohibit[GetChaMapName(role)] ~= nil and teletix_prohibit[GetChaMapName(role)] then
		BickerNotice(role, "Cannot use a ticket inside this map.")
		UseItemFailed(role)
		return
	end
	if GetItemType(Item) == 44 or GetItemType(Item) == 36 then
		local j = DelBagItem(role, itemId, 1)
		if j ~= 1 then
			SystemNotice(role, 'Error in item function. Please report!');
			UseItemFailed(role)
			return
		end
	end
	if teletix[itemId] then
		MoveCity(role, teletix[itemId])
	end
end

function GoToPlayer(role,target)
	local map_name = GetChaMapName (target) 
	local x, y = GetChaPos(target) 
	x = math.floor (x*0.01) 
	y = math.floor (y*0.01) 
	GoTo(role, x,y, map_name)
end