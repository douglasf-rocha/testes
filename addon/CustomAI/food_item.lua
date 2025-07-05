------------------
---- PET CAKE ----
------------------
function ItemUse_CAKE ( role , Item )  --[[���⹫ʽ]]--
	if Farmer.Power[role] == 1000 then
		SystemNotice(role,"Your farmer stamina is Full")
		UseItemFailed(role)
		return
	end
	Farmer.Power[role] = Farmer.Power[role] + 10
	SystemNotice(role,"Your farmer stamina is "..Farmer.Power[role].."")
	PlayEffect(player_pet[role],165)
end 


-------------------
---- SPAWN ITEM ---
-------------------

function ItemUse_Farmer ( role , Item  )
	local x, y = GetChaPos(role)
	local Farmer = {}
	Farmer[15080] = 1291
	Farmer[15081] = 1292
	local MonsterID = Farmer[GetItemID(Item)]
	local Refresh = 9000				
	local life = 9000000					
	local new = CreateChaX( MonsterID , x , y , 145 , Refresh, role )
	SetChaLifeTime( new, life )
	SetChaSideID(new, GetChaSideID(role))
	SetChaHost(new,role)
	SetChaAIType(new, AI_FARMER)
	local Type = {}
	Type[15080] = "wood"
	Type[15081] = "ores"
	HelpInfoX(role,0,"Farmer AI: This monster will farm "..Type[GetItemID(Item)].." and will stack it up to 10x pieces in his bag. Once it reaches 10 it will automaticly be sent to your bag. The farmer need to be feeden, so you must purchase some farmer cakes,juice,milk or any other type of food. If you dont feed him he will die! Please take care of it.")
end