print('Loading globaldrop.lua')

GlobalDrops = {Enabled = false}
GlobalDrops.GlobalItems = {
	{ID = 1, Amount = 1, Chance = 1},--These items drop from all non-players
	{ID = 2, Amount = 1, Chance = 1},--These items drop from all non-players
	{ID = 3, Amount = 1, Chance = 1},--These items drop from all non-players
}
GlobalDrops.MobItems = {
	[71] = {                --These items only drop from mystic flowers(ID 185).
		{ID = 1, Amount = 1, Chance = 1},--These items only drop from mystic flowers(ID 185).
		{ID = 1, Amount = 1, Chance = 1},--These items only drop from mystic flowers(ID 185).
		{ID = 1, Amount = 1, Chance = 1},--These items only drop from mystic flowers(ID 185).
	},    					 --These items only drop from mystic flowers(ID 185).
	
	[72] = {                 --These items only drop from BD phyliss(ID 885).
		{ID = 2, Amount = 2, Chance = 1},--These items only drop from BD phyliss(ID 885).
		{ID = 3, Amount = 7, Chance = 1},--These items only drop from BD phyliss(ID 885).
		{ID = 4, Amount = 5, Chance = 1},--These items only drop from BD phyliss(ID 885).
	},  
}

function GlobalDrops.Drop(role,array)
	for i,v in pairs(array) do
		if Percentage_Random(v.Chance) == 1 then
			GiveItem(role,0,v.ID,v.Amount,4)
			RemoveChaItem( role , v.ID , v.Amount , 2 , -1, 0 , 1  )
		end
	end	
end

function GlobalDrops.Check(DEFER,ATKER)
	if GlobalDrops.Enabled ~= true then
		return true
	end
	if GetChaTypeID( DEFER ) > 4 then
		GlobalDrops.Drop(DEFER,GlobalDrops.GlobalItems)	
	end
	local array = GlobalDrops.MobItems[GetChaTypeID( DEFER )]
	if array ~= nil then
		GlobalDrops.Drop(DEFER,array)
	end
end
Hook:AddPreHook("GetExp_PKM",GlobalDrops.Check)