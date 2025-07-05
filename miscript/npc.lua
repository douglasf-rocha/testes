print('Loading npc.lua')

dofile(GetResPath("script\\addon\\CustomAI\\AI_FARMER.lua"))
dofile(GetResPath("script\\addon\\CustomAI\\food_item.lua"))

function BuffPota( role , Item )
	local Cha_Boat = GetCtrlBoat(role)
	if Cha_Boat ~= nil then
	SystemNotice(role , "Not usable on the sea." )
	UseItemFailed (role)
	return
	end
	local buff1 = GetChaStateLv(role,STATE_SHPF)
	local buff2 = GetChaStateLv(role,STATE_XLZH)
	local buff3 = GetChaStateLv(role,STATE_TSHD)
	local buff4 = GetChaStateLv(role,STATE_FZLZ)
	local buff5 = GetChaStateLv(role,STATE_MLCH)
	if buff1 >= 1 or buff2 >= 1 or buff3 >= 1 or buff4 >= 1 or buff5 >= 1 then
	SystemNotice(role,"Same or better buffs are on effect, please wait for effect termination!")
	UseItemFailed(role)
	return
	end
	local del_item = DelBagItem( role , 15977 , 1 )
	if del_item == 1 then
		AddState ( role , role , STATE_SHPF  , 10 , 600 )
		AddState ( role , role , STATE_XLZH  , 10 , 600 )
		AddState ( role , role , STATE_TSHD  , 10 , 600 )
		AddState ( role , role , STATE_FZLZ  , 10 , 600 )
		AddState ( role , role , STATE_MLCH  , 10 , 600 )
		BickerNotice( role , "You recived Harden, Spiritual Fire, Tempest Bolt, Angelic Shield, Intense Magic for 5 minutes!" )
	end

end

Buffdelay = Buffdelay or {}
function PureBuff1 (role)
	if Buffdelay[role] == nil then
		Buffdelay[role] = os.time();
	end
	local StateType = GetChaStateLv (role, STATE_XLZH)
	local StateType = GetChaStateLv (role, STATE_SHPF)
	local StateType = GetChaStateLv (role, STATE_TSHD)
	local StateType = GetChaStateLv (role, STATE_MLCH)
	local StateType = GetChaStateLv (role, STATE_FZLZ)
	local cd = Buffdelay[role] - os.time()
	if cd > 0 then
		SystemNotice(role, 'Buffs cooldown on effect wait '..cd..' sec(s) to use again!')
	elseif StateType ~= 0 then
		SystemNotice (role, "You still have the buffs on effect.")
	else
		AddState (role, role, STATE_XLZH, 10, 600)
		AddState (role, role, STATE_SHPF, 10, 600)
		AddState (role, role, STATE_TSHD, 10, 600)
		AddState (role, role, STATE_MLCH, 10, 600)
		AddState (role, role, STATE_FZLZ, 10, 600) 
		RefreshCha(role)
		local delay = 250
		Buffdelay[role] = os.time()+delay
		SystemNotice (role, "You were buffed up!")
	end
end

function r_spawnTele ()
	Talk(1, "Main Quest Teleporter: I will teleport you to Main Quest 1.")
	InitTrigger()
--	TriggerCondition( 1, LvCheck, "<", 11 )
	TriggerAction( 1, GoTo, 2242, 2826, "garner" )
	Text( 1, "Teleport",MultiTrigger, GetMultiTrigger(), 1)

end

function lanchaapp ()

	Talk(1, "Hello, I have lance/champ apparels, check them out below!")
	Text(1, "Trade", BuyPage)

	InitTrade()
	Weapon(5286)
	Weapon(5282)
	Weapon(5281)
	Weapon(5279)
	Weapon(5276)
	Weapon(5277)
	Weapon(5278)
	Weapon(5094)
	Weapon(5095)
	Weapon(5096)
	Weapon(5097)
	Weapon(5098)
	Weapon(5093)
	Weapon(5085)
	Weapon(5084)
	Weapon(5083)
	Weapon(5007)
	Weapon(5008)
	Weapon(5009)
	Weapon(5010)
	Weapon(5280)
	Weapon(5080)
	Weapon(5006)
	Weapon(5012)
	Weapon(5015)
	Weapon(5032)
	Weapon(5027)
	Weapon(5006)
	Defence(5565)
	Defence(5566)
	Defence(5567)
	Defence(5568)
	Defence(5570)
	Defence(5571)
	Defence(5572)
	Defence(5569)
	Defence(5573)
	Defence(5574)
	Defence(5575)
	Defence(5576)
	Defence(5577)
	Defence(5578)
	Defence(5579)
	Defence(5580)
	Defence(5585)
	Defence(5586)
	Defence(5587)
	Defence(5588)
	Defence(6624)
	Defence(6625)
	Defence(6626)
	Defence(6627)
	Defence(6672)
	Defence(6673)
	Defence(6674)
	Defence(6675)
	Defence(5547)
	Defence(5548)
	Defence(5549)
	Defence(5550)
	Defence(5537)
	Defence(5538)
	Defence(5539)
	Defence(5540)
	Other(5411)
	Other(5412)
	Other(5413)
	--Other(5406)
	Other(5407)
	Other(5408)
	Other(5409)
	Other(5403)
	Other(5404)
	Other(5405)
	Other(5390)
	Other(5391)
	Other(5392)
	Other(5403)
	Other(5404)
	Other(5405)
	Other(5503)
	Other(5504)
	Other(5505)
	Other(5506)
	Other(5577)
	Other(5578)
	Other(5579)
	Other(5580)
	Other(5597)
	Other(5598)
	Other(5599)
	Other(5600)

end

function phyamiapp ()

	Talk(1, "Hello, I have Phy/Ami apparels, check them out below!")
	Text(1, "Trade", BuyPage)
	Weapon(9594)
	Weapon(9595)
	Weapon(9596)
	Weapon(9597)
	Weapon(9598)
	Weapon(9599)
	Weapon(9600)
	Weapon(9601)
	Weapon(5492)
	Weapon(5493)
	Weapon(5494)
	Weapon(5495)
	Weapon(5496)
	Weapon(5497)
	Weapon(5498)
	Weapon(5499)
	Weapon(5521)
	Weapon(5522)
	Weapon(5523)
	Weapon(5524)
	Weapon(5541)
	Weapon(5542)
	Weapon(5543)
	Weapon(5544)
	Weapon(5545)
	Weapon(5546)
	Weapon(5727)
	Weapon(5728)
	Weapon(5729)
	Weapon(5730)
	Weapon(5719)
	Weapon(5720)
	Weapon(5721)
	Weapon(5722)
	Weapon(5741)
	Weapon(5742)
	Weapon(5743)
	Weapon(5744)
	Weapon(5755)
	Weapon(5756)
	Weapon(5757)
	Weapon(5758)
	Weapon(5762)
	Weapon(5763)
	Weapon(5764)
	Weapon(5765)
	Weapon(5784)
	Weapon(5785)
	Weapon(5786)
	Weapon(6523)
	Weapon(6524)
	Weapon(6525)
	Weapon(6530)
	Weapon(6531)
	Weapon(6532)
	Weapon(6533)
	Defence(5006)
	Defence(5280)
	Defence(5080)
	Defence(5006)
	Defence(5012)
	Defence(5015)
	Defence(5032)
	Defence(5027)
	Defence(5286)
	Defence(5282)
	Defence(5281)
	Defence(5279)
	Defence(5276)
	Defence(5277)
	Defence(5278)
	Defence(5094)
	Defence(5095)
	Defence(5096)
	Defence(5097)
	Defence(5098)
	Defence(5093)
	Defence(5085)
	Defence(5084)
	Defence(5083)
	Defence(5007)
	Defence(5008)
	Defence(5009)
	Defence(5010)
end
function Silver_coins()
		Talk( 1, "I'm the only one who can sell you exclusive items!" )
		Text( 1, "I'd like to buy some!", SendExchangeXData)
	
		InitExchangeX()
		ExchangeDataX(	3903	,	40	,	3089	,	1	,	1)
		ExchangeDataX(	854	,	40	,	3090	,	1	,	1)
		ExchangeDataX(	854	,	40	,	3091	,	1	,	1)
		ExchangeDataX(	854	,	40	,	3092	,	1	,	1)
		ExchangeDataX(	854	,	20	,	3094	,	1	,	1)
		ExchangeDataX(	854	,	20	,	3096	,	1	,	1)
		ExchangeDataX(	854	,	70	,	0259	,	1	,	1)
		ExchangeDataX(	854	,	20	,	1780	,	1	,	1)
		ExchangeDataX(	854	,	1	,	1138	,	1	,	1)
		ExchangeDataX(	854	,	5	,	1145	,	1	,	1)
		ExchangeDataX(	854	,	10	,	2729	,	1	,	1)
		ExchangeDataX(	854	,	15	,	2753	,	1	,	1)
		ExchangeDataX(	15971	,	70	,	15946	,	1	,	1)

end

function Silver_coins()
		Talk( 1, "I'm the only one who can sell you exclusive items!" )
		Text( 1, "I'd like to buy some!", SendExchangeXData)
	
		InitExchangeX()
		ExchangeDataX(	3903	,	40	,	3089	,	1	,	1)
		ExchangeDataX(	854	,	40	,	3090	,	1	,	1)
		ExchangeDataX(	854	,	40	,	3091	,	1	,	1)
		ExchangeDataX(	854	,	40	,	3092	,	1	,	1)
		ExchangeDataX(	854	,	20	,	3094	,	1	,	1)
		ExchangeDataX(	854	,	20	,	3096	,	1	,	1)
		ExchangeDataX(	854	,	70	,	0259	,	1	,	1)
		ExchangeDataX(	854	,	20	,	1780	,	1	,	1)
		ExchangeDataX(	854	,	1	,	1138	,	1	,	1)
		ExchangeDataX(	854	,	5	,	1145	,	1	,	1)
		ExchangeDataX(	854	,	10	,	2729	,	1	,	1)
		ExchangeDataX(	854	,	15	,	2753	,	1	,	1)
		ExchangeDataX(	15971	,	70	,	15946	,	1	,	1)

end

function ticket_npc22 ()

	Talk(1, "Aviara: Hello, I sell all kind of tickets")
	
	Text( 1, "Show me", BuyPage )
	InitTrade()
	Weapon(0332)
	Weapon(3833)
	Weapon(3831)
	Weapon(3837)
	Weapon(3838)
	Weapon(3839)
	Weapon(3840)	
	Weapon(3841)	
	Weapon(3842)
	Weapon(3843)
	Weapon(3836)
	Weapon(3847)
	Weapon(4602)
	Weapon(4603)
	Weapon(4604)
	Weapon(2445)
	Weapon(2447)
	Weapon(3073)
	Weapon(0563)
	Weapon(11105)
	Weapon(3053)
	Weapon(3830)
	
end
function mall_npcx()
	Talk(1, "Hello, I will help you with your journey in the game")
	Text(1, "Show me what you have!", BuyPage)
	
	InitTrade()
	Weapon(3094)
	Weapon(3095)
	Weapon(3096)
	Weapon(3097)
	Weapon(0849)
	Weapon(15006)
	Weapon(5939)
	Weapon(854)
	
end

function pot_sellerx()
	Talk(1, "Hello, I am the Potions Seller, check what i have!")
	Text(1, "Show me", BuyPage)

	InitTrade()
	Weapon(3105)
	Weapon(3107)
	Weapon(0852)
	Weapon(0850)
	Weapon(1138)
	Weapon(1136)
	Weapon(1135)	
	Weapon(1137)	
	Weapon(3343)
	Weapon(3047)
	Weapon(1146)
	Weapon(1148)
	Weapon(3462)
	Weapon(3300)
	Weapon(3301)
	Weapon(0259)

end

function pet_sellerx()
	Talk(1, "Hello, I am the Pet Seller, check what i have!")
---Text(1, "Show me", BuyPage)
---Text(1, "Pet Production Exchange", JumpPage, 8)
---Talk(3, "Hello, it seems you don`t have enough fairy coins , check what your inventory again!")
---
---
---InitTrigger()
---TriggerCondition( 1, HasItem, 855, 99 )
---TriggerCondition( 1, HasLeaveBagGrid, 1 )
---TriggerCondition( 1, KitbagLock, 0 )
---TriggerAction( 1, TakeItem, 855, 99 )
---TriggerAction( 1, GiveItem, 15718, 1, 4 )
---TriggerFailure( 1, JumpPage, 3 )
---Talk( 8, "Pet Seller : 99 Fairy Coins To Get 700000" )
---Text( 8, "Confirm to exchange", MultiTrigger, GetMultiTrigger(), 1)
---
---InitTrigger()
---TriggerCondition( 1, HasItem, 855, 1000 )
---TriggerCondition( 1, HasLeaveBagGrid, 1 )
---TriggerCondition( 1, KitbagLock, 0 )
---TriggerAction( 1, TakeItem, 855, 1000 )
---TriggerAction( 1, GiveItem, 0854, 7, 4 )
---TriggerFailure( 1, JumpPage, 3 )
---Talk( 8, "Pet Seller : 1000 Fairy Coins To Get 7000000" )
---Text( 8, "Confirm to exchange", MultiTrigger, GetMultiTrigger(), 1)
---
---
---
---
---
---
---
---
---
---
---InitTrade()
---
---Weapon(0231)
---Weapon(0232)
---Weapon(0233)
---Weapon(0234)
---Weapon(0235)
---Weapon(0236)
---Weapon(0237)
---Defence(0222)
---Defence(0223)
---Defence(0224)
---Defence(0225)
---Defence(0226)
---Defence(0276)
---Defence(0277)
---Defence(0278)
---Defence(0279)
---Defence(0280)
---Other(0227)
---Other(2312)
---Other(0578)
---Other(0239)
---
---
---
---
end

function ge_seller()
	Talk(1, "Hello, I am the gem seller, check what i have!")
	Text(1, "Show me", BuyPage)
	
	InitTrade()
	Weapon(0878)
	Weapon(0879)
	Weapon(0880)
	Weapon(0881)
	Weapon(0882)
	Weapon(0883)
	Weapon(0884)
	Weapon(0885)
	Weapon(0887)
	Weapon(0860)
	Weapon(0861)
	Weapon(0862)
	Weapon(0863)
--	 Weapon(0864)
--	 Weapon(0865)
--	 Weapon(0866)
	Weapon(1012)
--	Weapon(5845)
--	Weapon(5846)
--	Weapon(5847)
--	Weapon(5848)
--	Weapon(5849)
--	Defence(0854)
	Defence(15745)
	Defence(15746)
	Defence(15747)
	Defence(0455)
	Defence(15744)
	Defence(0886)
	Defence(1020)



end


function b_entrace()
	Talk(1, "Hello, I sell all items required to enter Black Dragon Lair 2")
	Text(1, "Show me", BuyPage)
	
	InitTrade()
	Weapon(179)
	Weapon(3084)
	Weapon(3085)
end
function launch_event()
	Talk(1, "Hello, I'm the Event Manager, I will reward you 100 Crystal once per day at 20:00 server time.")
--	local Now_Hour = os.date("%H")
--	if Now_Hour == 7 then
		Text(1,"Daily Prize",CheckWeek)
--	end
end

function WACA_BANKER ()

	Talk( 1, "Banker: Hi, I am your banker. All accounts never go wrong with me around." )
	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, OpenBank )
	TriggerFailure( 1, JumpPage, 10 )
--	Text( 1, "Vault (2000G Fee)", MultiTrigger, GetMultiTrigger(), 1)
	Text( 1, "             Service", JumpPage, 2)

	Talk( 2, "Banker: Hi, I am your banker. All accounts never go wrong with me around." )
	Text( 2, "              Invest", JumpPage, 3)
	Text( 2, "             Withdraw", UnRegisterInvestment)
	Text( 2, "            My Balance", BalanceCheckout)

	Talk( 3, "           Invest Buccaneers Card:_ 1.Minimum to invest is 100 BC._ 2.Banker Currency rate 100BC = 5BC Daily._ 3.Investment interest is 1%._ 4.At first time investment get 1%          Cashback._ 5.Cashback and Interest will be paid in_   Buccaneers Card._ 6.Withdrawing after 30 days, will give_   you double amount of all your_   investments._ 7.You can take the interest every day._ 8.In case you ain't take your interest,_   It won't be stacked." )
	Text( 3, "            Register", JumpPage, 4)
	Text( 3, "         Interest Payout", InterestPayOut)

	Talk( 4, "Banker: So how much would you invest?" )
	Text( 4, "        100 Buccaneers Card", RegisterInvestment, 15060, 100)
	Text( 4, "        200 Buccaneers Card", RegisterInvestment, 15060, 200)
	Text( 4, "        500 Buccaneers Card", RegisterInvestment, 15060, 500)
	Text( 4, "       1000 Buccaneers Card", RegisterInvestment, 15060, 1000)
	Text( 4, "      All-In Buccaneers Card", RegisterInvestment, 15060, -1)


	Talk( 10, "Banker: Sorry, you do not have sufficient gold to pay for vault usage" )
end

function Uns_Upgrades()
		Talk( 1, "Wow, you got strong enough as to get my upgrades?!" )
		Text( 1, "Weapon Upgrades", SendExchangeXData)
	
		InitExchangeX()
		ExchangeDataX(	15061	,	4	,	10150	,	2	,	1)
		ExchangeDataX(	15061	,	4	,	10151	,	2	,	1)
		ExchangeDataX(	15061	,	7	,	10152	,	2	,	1)
		ExchangeDataX(	15061	,	7	,	10153	,	2	,	1)
		ExchangeDataX(	15061	,	10	,	10154	,	2	,	1)
		ExchangeDataX(	15061	,	10	,	10155	,	2	,	1)
		ExchangeDataX(	15061	,	4	,	10156	,	1	,	1)
		ExchangeDataX(	15061	,	4	,	10157	,	1	,	1)
		ExchangeDataX(	15061	,	7	,	10158	,	1	,	1)
		ExchangeDataX(	15061	,	7	,	10159	,	1	,	1)
		ExchangeDataX(	15061	,	10	,	10160	,	1	,	1)
		ExchangeDataX(	15061	,	10	,	10161	,	1	,	1)
		ExchangeDataX(	15061	,	4	,	10162	,	1	,	1)
		ExchangeDataX(	15061	,	4	,	10163	,	1	,	1)
		ExchangeDataX(	15061	,	7	,	10164	,	1	,	1)
		ExchangeDataX(	15061	,	7	,	10165	,	1	,	1)
		ExchangeDataX(	15061	,	10	,	10166	,	1	,	1)
		ExchangeDataX(	15061	,	10	,	10167	,	1	,	1)
		ExchangeDataX(	15061	,	4	,	10168	,	1	,	1)
		ExchangeDataX(	15061	,	4	,	10169	,	1	,	1)
		ExchangeDataX(	15061	,	7	,	10170	,	1	,	1)
		ExchangeDataX(	15061	,	7	,	10171	,	1	,	1)
		ExchangeDataX(	15061	,	10	,	10172	,	1	,	1)
		ExchangeDataX(	15061	,	10	,	10173	,	1	,	1)
		ExchangeDataX(	15061	,	4	,	10174	,	1	,	1)
		ExchangeDataX(	15061	,	4	,	10175	,	1	,	1)
		ExchangeDataX(	15061	,	7	,	10176	,	1	,	1)
		ExchangeDataX(	15061	,	7	,	10177	,	1	,	1)
		ExchangeDataX(	15061	,	10	,	10178	,	1	,	1)
		ExchangeDataX(	15061	,	10	,	10179	,	1	,	1)
		ExchangeDataX(	15061	,	4	,	10180	,	1	,	1)
		ExchangeDataX(	15061	,	4	,	10181	,	1	,	1)
		ExchangeDataX(	15061	,	7	,	10182	,	1	,	1)
		ExchangeDataX(	15061	,	7	,	10183	,	1	,	1)
		ExchangeDataX(	15061	,	10	,	10184	,	1	,	1)
		ExchangeDataX(	15061	,	10	,	10185	,	1	,	1)
		ExchangeDataX(	15061	,	4	,	10144	,	1	,	1)
		ExchangeDataX(	15061	,	4	,	10145	,	1	,	1)
		ExchangeDataX(	15061	,	7	,	10146	,	1	,	1)
		ExchangeDataX(	15061	,	7	,	10147	,	1	,	1)
		ExchangeDataX(	15061	,	10	,	10148	,	1	,	1)
		ExchangeDataX(	15061	,	10	,	10149	,	1	,	1)

end
function ancient_exch()

	local npcName = 'Exchanger'
	Talk( 1, npcName..": Hi, i take your Gold Coins and give you some benefits!" )
	Text(1, "80 Gold Coin = White Braces Chest", JumpPage, 2)
	Text(1, "80 Gold Coin = White Belt Chest", JumpPage, 3)
	Text(1, "99 Gold Coin = White Earring Chest", JumpPage, 4)
	Text(1, "198 Gold Coin = Lv10 Headgear Chest", JumpPage, 5)
	Text(1, "160 Gold Coin = Yellow Braces Chest", JumpPage, 6)
	Text(1, "160 Gold Coin = Yellow Belt Chest", JumpPage, 7)
	Text(1, "198 Gold Coin = Yellow Earring Chest", JumpPage, 8)
	Text(1, "396 Gold Coin = Lv20 Headgear Chest", JumpPage, 9)

	InitTrigger()
	TriggerCondition( 1, HasItem, 855, 80 )
	TriggerAction( 1, TakeItem, 855, 80 )
	TriggerAction( 1, GiveItem, 15750, 1, 4 )
	TriggerFailure( 1, JumpPage, 18 )
	Text( 2, "Costs: x80 Gold Coin",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 2, "Let me consider", CloseTalk)
	
	TriggerCondition( 1, HasItem, 855, 80 )
	TriggerAction( 1, TakeItem, 855, 80 )
	TriggerAction( 1, GiveItem, 15749, 1, 4 )
	TriggerFailure( 1, JumpPage, 18 )
	Text( 3, "Costs: x80 Gold Coin",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 3, "Let me consider", CloseTalk)
	
	TriggerCondition( 1, HasItem, 855, 99 )
	TriggerAction( 1, TakeItem, 855, 99 )
	TriggerAction( 1, GiveItem, 15751, 1, 4 )
	TriggerFailure( 1, JumpPage, 18 )
	Text( 4, "Costs: x99 Gold Coin",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 4, "Let me consider", CloseTalk)

	TriggerCondition( 1, HasItem, 855, 198 )
	TriggerAction( 1, TakeItem, 855, 198 )
	TriggerAction( 1, GiveItem, 15752, 1, 4 )
	TriggerFailure( 1, JumpPage, 18 )
	Text( 5, "Costs: x198 Gold Coin",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 5, "Let me consider", CloseTalk)
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 855, 160 )
	TriggerAction( 1, TakeItem, 855, 160 )
	TriggerAction( 1, GiveItem, 15766, 1, 4 )
	TriggerFailure( 1, JumpPage, 18 )
	Text( 6, "Costs: x160 Gold Coin",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 6, "Let me consider", CloseTalk)
	
	TriggerCondition( 1, HasItem, 855, 160 )
	TriggerAction( 1, TakeItem, 855, 160 )
	TriggerAction( 1, GiveItem, 15765, 1, 4 )
	TriggerFailure( 1, JumpPage, 18 )
	Text( 7, "Costs: x160 Gold Coin",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 7, "Let me consider", CloseTalk)
	
	TriggerCondition( 1, HasItem, 855, 198 )
	TriggerAction( 1, TakeItem, 855, 198 )
	TriggerAction( 1, GiveItem, 15767, 1, 4 )
	TriggerFailure( 1, JumpPage, 18 )
	Text( 8, "Costs: x99 Gold Coin",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 8, "Let me consider", CloseTalk)

	TriggerCondition( 1, HasItem, 855, 396 )
	TriggerAction( 1, TakeItem, 855, 396 )
	TriggerAction( 1, GiveItem, 15768, 1, 4 )
	TriggerFailure( 1, JumpPage, 18 )
	Text( 9, "Costs: x198 Gold Coin",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 9, "Let me consider", CloseTalk)
	
	
	Talk(18,"You do not have the required amount of gold coins!")
	
end
function mineral_exch()

	local npcName = 'Mineral Exchanger'
	Talk( 1, npcName..": Hi, i can take your valueable jewels for some benefits!" )
	Text( 1, "99 Ruby --> 1x Random LVL Belt Chest", JumpPage, 2 )
	Text( 1, "99 Opal --> 1x Random LVL Earring Chest", JumpPage, 3 )
	Text( 1, "99 Topaz --> 1x Random LVL Bracelets Chest", JumpPage, 4 )
	Text( 1, "99 Diamond --> 1x Random LVL h.Acesssories Chest", JumpPage, 5 )
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 15868, 99 )
	TriggerAction( 1, TakeItem, 15868, 99 )
	TriggerAction( 1, GiveItem, 15872, 1, 4 )
	TriggerFailure( 1, JumpPage, 8 )
	Text( 2, "Costs: x99 Ruby",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 2, "Let me consider", CloseTalk)

	InitTrigger()
	TriggerCondition( 1, HasItem, 15869, 99 )
	TriggerAction( 1, TakeItem, 15869, 99 )
	TriggerAction( 1, GiveItem, 15873, 1, 4 )
	TriggerFailure( 1, JumpPage, 8 )
	Text( 3, "Costs: x99 Opal",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 3, "Let me consider", CloseTalk)
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 15870, 99 )
	TriggerAction( 1, TakeItem, 15870, 99 )
	TriggerAction( 1, GiveItem, 15874, 1, 4 )
	TriggerFailure( 1, JumpPage, 8 )
	Text( 4, "Costs: x99 Topaz",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 4, "Let me consider", CloseTalk)
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 15871, 99 )
	TriggerAction( 1, TakeItem, 15871, 99 )
	TriggerAction( 1, GiveItem, 15875, 1, 4 )
	TriggerFailure( 1, JumpPage, 8 )
	Text( 5, "Costs: x99 Diamonds",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 5, "Let me consider", CloseTalk)

	Talk( 8, npcName..": You don't have the required items to make this exchange, please check it again!" )

end

function fairy_coinshe()

	local npcName = 'Fairy Coins Exchanger'
--	Talk( 1, npcName..": Hi, i can give you a Fairy Coin Box for 99 Fairy Coins in exchange!" )
--	Text( 1, "Tak", JumpPage, 2 )
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 0855, 99 )
	TriggerAction( 1, TakeItem, 0855, 99 )
	TriggerAction( 1, GiveItem, 15700, 1, 4 )
--	TriggerAction( 1, JumpPage, 4 )
	TriggerFailure( 1, JumpPage, 3 )
	Talk( 1, npcName..": Hi, i can give you a Fairy Coin Box for 99 Fairy Coins in exchange!" )
	Text( 1, "Costs: 99x Fairy Coins",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 1, "Let me consider", CloseTalk)

	Talk( 3, npcName..": You don't have 99x Fairy Coins to make this exchange, please check it again!" )

end

function fcds_manager()

	local npcName = 'Manager'
	Talk( 1, npcName..": Obtain your Daily Quest for FC or DS!" )
	
	-- AddNpcMission ( 6002 )
	-- AddNpcMission ( 6004 )
	
end

function exch_rep()

	local npcName = 'Lisa'
	Talk( 1, npcName..": Hi, i can exchanger your Reputations to Buccaneers Cards!" )
--	Text( 1, "Reps for Money", JumpPage, 2 )
--	Text( 1, "Buccaneer Cards", JumpPage, 3 )
--	Text( 1, "Unique Accessories", JumpPage, 8 )
	--Text( 1, "Goddess Favor", JumpPage, 12 )

	InitTrigger()
	TriggerCondition( 1, HasCredit,2000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit,2000 )
	TriggerAction( 1, GiveItem, 0938,1,4 )
	TriggerFailure( 1, JumpPage, 30)
	Talk( 12, npcName..": To exchange Goddess's Favor will cost you 2k Reputation" )
	Text( 12, "Costs: 2k Reputation",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 12, "Let me consider", CloseTalk)
	
	Talk( 30, npcName..": You don't have enough Reputation to make this Exchange!" )
	
end

function SPKO_ACHIV()
	Talk( 1, "Jim: Welcome..Can i help you?" )
	Text( 1, "Checking my achievement", JumpPage, 2)
	Text( 1, "Claim Rewards", JumpPage, 3)

	Talk( 2, "Jim: Which one you want to check?" )
--	Text( 2, "Leveled Up", DisplayAchievementLeveledUp)
--	Text( 2, "Time Online", DisplayAchievementTimeOnline)
	Text( 2, "Monster Kills", DisplayAchievementMonsterKills)
--	Text( 2, "Boss Kills", DisplayAchievementBossKills)

	Talk( 3, "Jim: Which one you want to claims?" )
--	Text( 3, "Claim Level Up Achievement", JumpPage, 4)
--	Text( 3, "Claim Time Online Achievement", JumpPage, 5)
	Text( 3, "Claim Monster Kills Achievement", JumpPage, 9)
--	Text( 3, "Claim Boss Kills Achievement", JumpPage, 10)

	Talk( 4, "               Reward Information" )
--	Text( 4, "Reached Sklv 10          Reward Chest", ClaimLeveledUpReward,  10,  1)
--	Text( 4, "Reached Sklv 30          Reward Chest", ClaimLeveledUpReward,  30,  3)
	Text( 4, "Reached Sklv 50        Lv50 Reward Chest", ClaimLeveledUpReward,  50,  1)
	Text( 4, "Reached Sklv 60        Lv60 Reward Chest", ClaimLeveledUpReward,  60,  1)
	Text( 4, "Reached Sklv 70        Lv70 Reward Chest", ClaimLeveledUpReward, 70,  1)
	Text( 4, "Reached Sklv 80        Lv80 Reward Chest", ClaimLeveledUpReward, 80,  1)
--	Text( 4, "Reached Sklv 150         Reward Chest", ClaimLeveledUpReward, 150,  70)
--	Text( 4, "Reached Sklv 200         Reward Chest", ClaimLeveledUpReward, 200,  130)

	Talk( 5, "                Reward Information" )
	Text( 5, "   1 Hours Online      1h Reward Chest", ClaimTimeOnlineReward, 3600, 1)
	Text( 5, "   2 Hours Online      2h Reward Chest", ClaimTimeOnlineReward, 7200, 1)
	Text( 5, "   4 Hours Online      4h Reward Chest", ClaimTimeOnlineReward, 14400, 1)
	Text( 5, "   8 Hours Online      8h Reward Chest", ClaimTimeOnlineReward, 28800, 1)
	Text( 5, "  12 Hours Online     12h Reward Chest", ClaimTimeOnlineReward, 43200, 1)
	Text( 5, "", JumpPage, 5)
	Text( 5, "        Next", JumpPage, 6)

	Talk( 6, "               Reward Information" )
	Text( 6, " 24 Hours Online       24h Reward Chest", ClaimTimeOnlineReward, 86400, 1)
	Text( 6, " 48 Hours Online       48h Reward Chest", ClaimTimeOnlineReward, 172800, 1)
	Text( 6, " 72 Hours Online       72h Reward Chest", ClaimTimeOnlineReward, 259200, 1)
	Text( 6, " 96 Hours Online       96h Reward Chest", ClaimTimeOnlineReward, 345600, 1)
	Text( 6, "120 Hours Online      120h Reward Chest", ClaimTimeOnlineReward, 432000, 1)
	Text( 6, "", JumpPage, 6)
	Text( 6, "        Next -->>", JumpPage, 7)

	Talk( 7, "               Reward Information" )
	Text( 7, "144 Hours Online      144h Reward Chest", ClaimTimeOnlineReward, 518400, 1)
	Text( 7, "168 Hours Online      168h Reward Chest", ClaimTimeOnlineReward, 604800, 1)
	Text( 7, "192 Hours Online      192h Reward Chest", ClaimTimeOnlineReward, 691200, 1)
	Text( 7, "216 Hours Online      216h Reward Chest", ClaimTimeOnlineReward, 777600, 1)
	Text( 7, "240 Hours Online      240h Reward Chest", ClaimTimeOnlineReward, 864000, 1)
	Text( 7, "", JumpPage, 6)
	Text( 7, "        Next -->>", JumpPage, 8)

	Talk( 8, "               Reward Information" )
	Text( 8, " 480 Hours Online     480h Reward Chest", ClaimTimeOnlineReward, 1728000, 1)
	Text( 8, "1000 Hours Online    1000h Reward Chest", ClaimTimeOnlineReward, 3600000, 1)
	Text( 8, "1500 Hours Online    1500h Reward Chest", ClaimTimeOnlineReward, 5400000, 1)
	Text( 8, "2000 Hours Online    2000h Reward Chest", ClaimTimeOnlineReward, 7200000, 1)
	Text( 8, "5000 Hours Online    5000h Reward Chest", ClaimTimeOnlineReward, 18000000, 1)

	Talk( 9, "               Reward Information" )
	Text( 9, "Kills 1K   Monster       1K Reward Chest", ClaimMonsterKillsReward,  1000, 1)
	Text( 9, "Kills 5K   Monster       5K Reward Chest", ClaimMonsterKillsReward,  5000, 1)
	Text( 9, "Kills 10K  Monster      10K Reward Chest", ClaimMonsterKillsReward, 10000, 1)
	Text( 9, "Kills 25K  Monster      25K Reward Chest", ClaimMonsterKillsReward, 25000, 1)
	Text( 9, "Kills 50K  Monster      50K Reward Chest", ClaimMonsterKillsReward, 50000, 1)
	Text( 9, "Kills 100K Monster     100K Reward Chest", ClaimMonsterKillsReward, 100000, 1)
	Text( 9, "Kills 200K Monster     200K Reward Chest", ClaimMonsterKillsReward, 200000, 1)
	Text( 9, "Kills 500K Monster     500K Reward Chest", ClaimMonsterKillsReward, 500000, 1)

	Talk( 10, "                Coming Soon!" )
end

function leo_talk10()
	Talk(1, "Black Market Merchant: Hoho, you must be somebody to locate me. Hoho, what do you need?")
	--Text( 1, "Something special", JumpPage, 2 )
	Text( 1, "Buy.", BuyPage)

	--Talk(2,"Black Market Merchant: Hoho, you are well-informed indeed...How you wish to exchange?")
	--Text(2,"Let me take a look at your things first", SendExchangeData )

	InitExchange()
	DoExchange()

	InitTrade()
	Other(	rand()	)
	Other(	rand()	)
	Other(	rand()	)
	Other(	rand()	)
	Other(	rand()	)
	Other(	rand()	)
	Other(	rand()	)
	Other(	rand()	)

	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 53, TE_GAMETIME, TT_CYCLETIME, 240, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()
end

function r_talk57 ()
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 6 )
	TriggerCondition( 1, HasRecord, 500 )
	TriggerAction( 1, ReAll )
	TriggerCondition( 2, HasMoney, 200 )
	TriggerAction( 2, TakeMoney, 200 )
	TriggerAction( 2, ReAll )
	TriggerFailure( 2, JumpPage, 2 )

	Talk( 1, "Landy: Hello! I am Nurse Landy of Shaitan City. I just finished my training so How may I assist you?" )
	Text( 1, "Greater Heal", MultiTrigger,GetMultiTrigger(),2)
	--Text( 1, "Record Spawn point", JumpPage, 24 )

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 6 )
	TriggerCondition( 1, HasRecord, 500 )
	TriggerAction( 1, ReHp, 50 )
	TriggerCondition( 2, HasMoney, 50 )
	TriggerAction( 2, TakeMoney, 50 )
	TriggerAction( 2, ReHp,50 )
	TriggerFailure( 2, JumpPage, 3 )
	Text( 1, "Heal", MultiTrigger,GetMultiTrigger(),2)
	Talk( 2, "Landy: Sorry, Healing requires 200G. You do not have enough¡­" )
	Talk( 3, "Landy: Sorry! Healing requires 50G¡­You do not have enough¡­" )

	Talk( 24, "Landy: Record spawn right here? Is that correct?" )
	Text( 24, "Yes. Please record.", SetSpawnPos, "Nurse Landy" )
	Text( 24, "No, thank you",CloseTalk )
end

function r_talk76 ()
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 6 )
	TriggerCondition( 1, HasRecord, 500 )
	TriggerAction( 1, ReAll )
	TriggerCondition( 2, HasMoney, 200 )
	TriggerAction( 2, TakeMoney, 200 )
	TriggerAction( 2, ReAll )
	TriggerFailure( 2, JumpPage, 2 )

	Talk( 1, "Anne: Hi! I am Nurse Anne. I am finally off probation. Would you like some treatment?" )
	Text( 1, "Greater Heal", MultiTrigger,GetMultiTrigger(),2)

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 6 )
	TriggerCondition( 1, HasRecord, 500 )
	TriggerAction( 1, ReHp, 50 )
	TriggerCondition( 2, HasMoney, 50 )
	TriggerAction( 2, TakeMoney, 50 )
	TriggerAction( 2, ReHp,50 )
	TriggerFailure( 2, JumpPage, 3 )
	Text( 1, "Heal", MultiTrigger,GetMultiTrigger(),2)
	Talk( 2, "Anne: Sorry, Healing requires 200G. You do not have enough¡­" )
	Talk( 3, "Anne: Sorry! Healing requires 50G¡­You do not have enough¡­" )

	-- AddNpcMission	(1018)
	-- AddNpcMission	(1073)
	-- AddNpcMission	(1128)
	-- AddNpcMission	(1181)
	-- AddNpcMission	(1236)
end 

AddBirthPoint("Chaos Portal", "darkblue", 1363,537)
function x_ChaosHeal ()
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 6 )
	TriggerCondition( 1, HasRecord, 500 )
	TriggerAction( 1, ReAll )
	TriggerCondition( 2, HasMoney, 200 )
	TriggerAction( 2, TakeMoney, 200 )
	TriggerAction( 2, ReAll )
	TriggerFailure( 2, JumpPage, 2 )

	Talk( 1, "Tia: Hello, I am Nurse Tia of Chaos Argent. Healings are free of cost until Lv39 and above. 200g for Lv39+!" )
	Text( 1, "Buff Me!", PureBuff1,1)
	Text( 1, "Greater Heal", MultiTrigger,GetMultiTrigger(),2)
	Text( 1, "Record Spawn Point", JumpPage, 7 )

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 6 )
	TriggerCondition( 1, HasRecord, 500 )
	TriggerAction( 1, ReHp, 50 )
	TriggerCondition( 2, HasMoney, 50 )
	TriggerAction( 2, TakeMoney, 50 )
	TriggerAction( 2, ReHp,50 )
	TriggerFailure( 2, JumpPage, 3 )

	Talk( 2, "Tia: Sorry, healing requires 200G. You do not have enough¡K" )
	Talk( 3, "Tia: Sorry! Healing requires 50G¡KYou do not have enough¡K" )


	Talk( 7, "Tia: Record next to me? Good idea..." )
	Text( 7, "Yes. Please record.", SetSpawnPos, "Chaos Portal")
	Text( 7, "Close",CloseTalk )
end
function r_talkJOB ()
		local npcName = 'Elisabetta'
		local fclass = 4000
		local sclass = 40000
		Talk( 10, npcName..": You do not meet the requirements for Job advancement!" )
		Text( 10, "Close Talk...", CloseTalk )
----------------------
		Talk( 2, npcName..": Welcome Lance, what class do you want to become?" )
		Text( 2, "Swordsman", JumpPage, 6 )
		Text( 2, "Explorer", JumpPage, 9 )
		Text( 2, "Hunter", JumpPage, 7 )
--		Text( 2, "Herbalist", JumpPage, 8 )
		Text( 2, "Nevermind", CloseTalk )
----------------------
		Talk( 3, npcName..": Welcome Carsise, what class do you want to become?" )
		Text( 3, "Swordsman", JumpPage, 6 )
--		Text( 3, "Explorer", JumpPage, 9 )
--		Text( 3, "Herbalist", JumpPage, 8 )
		Text( 3, "Nevermind", CloseTalk )
----------------------
		Talk( 4, npcName..": Welcome Phyllis, what class do you want to become?" )
--		Text( 4, "Swordsman", JumpPage, 6 )
		Text( 4, "Explorer", JumpPage, 9 )
		Text( 4, "Hunter", JumpPage, 7 )
		Text( 4, "Herbalist", JumpPage, 8 )
		Text( 4, "Nevermind", CloseTalk )
----------------------
		Talk( 5, npcName..": Welcome Ami, what class do you want to become?" )
		Text( 5, "Explorer", JumpPage, 9 )
		Text( 5, "Herbalist", JumpPage, 8 )
		Text( 5, "Nevermind", CloseTalk )
----------------------
		Talk( 6, npcName..": Are you sure you want to become a Swordsman?" )
		InitTrigger()
		TriggerCondition( 1, PfEqual, 0 )--Newbie
		TriggerCondition( 1, HasMoney, fclass )
		TriggerAction(1, TakeMoney, fclass )
		TriggerAction( 1, SetProfession, 1 )--swordsman
		Text( 6, "Yes", MultiTrigger, GetMultiTrigger(), 1 )
		Text( 6, "Nevermind", CloseTalk )
----------------------
		Talk( 7, npcName..": Are you sure you want to become a Hunter?" )
		InitTrigger()
		TriggerCondition( 1, PfEqual, 0 )--Newbie
		TriggerCondition( 1, HasMoney, fclass )
		TriggerAction(1, TakeMoney, fclass )
		TriggerAction( 1, SetProfession, 2 )--hunter
		Text( 7, "Yes", MultiTrigger, GetMultiTrigger(), 1 )
		Text( 7, "Nevermind", CloseTalk )
----------------------
		Talk( 8, npcName..": Are you sure you want to become a Herbalist?" )
		InitTrigger()
		TriggerCondition( 1, PfEqual, 0 )--Newbie
		TriggerCondition( 1, HasMoney, fclass )
		TriggerAction(1, TakeMoney, fclass )
		TriggerAction( 1, SetProfession, 5 )--herbalist
		Text( 8, "Yes", MultiTrigger, GetMultiTrigger(), 1 )
		Text( 8, "Nevermind", CloseTalk )
----------------------
		Talk( 9, npcName..": Are you sure you want to become a Explorer?" )
		InitTrigger()
		TriggerCondition( 1, PfEqual, 0 )--Newbie
		TriggerCondition( 1, HasMoney, fclass )
		TriggerAction(1, TakeMoney, fclass )
		TriggerAction( 1, SetProfession, 4 )--explorer
		Text( 9, "Yes", MultiTrigger, GetMultiTrigger(), 1 )
		Text( 9, "Nevermind", CloseTalk )
----------------------
		Talk( 11, npcName..": Welcome Swordsman, Here for your class advancement?" )
		InitTrigger()
		TriggerCondition( 1, IsCategory, 1 )--lance
		TriggerCondition( 1, PfEqual, 1 )--Swordsman
		TriggerCondition( 1, HasMoney, sclass )
		TriggerAction(1, TakeMoney, sclass )
		TriggerAction( 1, SetProfession, 9 )--crusader
		TriggerCondition( 2, PfEqual, 1 )--Swordsman
		TriggerCondition( 2, IsCategory, 2 )--carsise
		TriggerCondition( 2, HasMoney, sclass )
		TriggerAction(2, TakeMoney, sclass )
		TriggerAction( 2, SetProfession, 8 )--champion
		Text( 11, "Yes", MultiTrigger, GetMultiTrigger(), 3 )
		Text( 11, "Nevermind", CloseTalk )
----------------------
		Talk( 12, npcName..": Welcome Hunter, Here for your class advancement?" )
		InitTrigger()
		TriggerCondition( 1, PfEqual, 2 )--Hunter
		TriggerCondition( 1, HasMoney, sclass )
		TriggerAction(1, TakeMoney, sclass )
		TriggerAction( 1, SetProfession, 12 )--sharpshooter
		Text( 12, "SharpShooter", MultiTrigger, GetMultiTrigger(), 1 )
		Text( 12, "Nevermind", CloseTalk )
----------------------
		Talk( 13, npcName..": Welcome Herbalist, which class do you want to become?" )
		Text( 13, "Seal Master", JumpPage, 14 )
		Text( 13, "Cleric", JumpPage, 15 )
		Text( 13, "Nevermind", CloseTalk )
----------------------
		Talk( 14, npcName..": Welcome Herbalist, Here for your Seal Master advancement?" )
		InitTrigger()
		TriggerCondition( 1, PfEqual, 5 )--Herbalist
		TriggerCondition( 1, HasMoney, sclass )
		TriggerAction(1, TakeMoney, sclass )
		TriggerAction( 1, SetProfession, 14 )--seal master
		Text( 14, "Yes", MultiTrigger, GetMultiTrigger(), 1 )
		Text( 14, "Nevermind", CloseTalk )
----------------------
		Talk( 15, npcName..": Welcome Herbalist, Here for your Cleric advancement?" )
		InitTrigger()
		TriggerCondition( 1, PfEqual, 5 )--Herbalist
		TriggerCondition( 1, HasMoney, sclass )
		TriggerAction(1, TakeMoney, sclass )
		TriggerAction( 1, SetProfession, 13 )--cleric
		Text( 15, "Yes", MultiTrigger, GetMultiTrigger(), 1 )
		Text( 15, "Nevermind", CloseTalk )
----------------------
		Talk( 16, npcName..": Welcome Explorer, Here for your class advancement?" )
		InitTrigger()
		TriggerCondition( 1, PfEqual, 4 )--Explorer
		TriggerCondition( 1, HasMoney, sclass )
		TriggerAction(1, TakeMoney, sclass )
		TriggerAction( 1, SetProfession, 16 )--voyager
		Text( 16, "Yes", MultiTrigger, GetMultiTrigger(), 1 )
		Text( 16, "Nevermind", CloseTalk )
----------------------
		InitTrigger()

		TriggerCondition( 1, PfEqual, 0 )--newbie
		TriggerCondition( 1, IsCategory, 1 )--lance
		TriggerCondition( 1, LvCheck, ">", 9 )
		TriggerAction( 1, JumpPage, 2 )

		TriggerCondition( 2, PfEqual, 0 )--newbie
		TriggerCondition( 2, IsCategory, 2 )--carsise
		TriggerCondition( 2, LvCheck, ">", 9 )
		TriggerAction( 2, JumpPage, 3 )

		TriggerCondition( 3, PfEqual, 0 )--newbie
		TriggerCondition( 3, IsCategory, 3 )--phyllis
		TriggerCondition( 3, LvCheck, ">", 9 )
		TriggerAction( 3, JumpPage, 4 )

		TriggerCondition( 4, PfEqual, 0 )--newbie
		TriggerCondition( 4, IsCategory, 4 )--ami
		TriggerCondition( 4, LvCheck, ">", 9 )
		TriggerAction( 4, JumpPage, 5 )

		TriggerCondition( 5, PfEqual, 1 )--swordsman
		TriggerCondition( 5, LvCheck, ">", 39 )
		TriggerAction( 5, JumpPage, 11 )

		TriggerCondition( 6, PfEqual, 2 )--hunter
		TriggerCondition( 6, LvCheck, ">", 39 )
		TriggerAction( 6, JumpPage, 12 )

		TriggerCondition( 7, PfEqual, 4 )--explorer
		TriggerCondition( 7, LvCheck, ">", 39 )
		TriggerAction( 7, JumpPage, 16 )

		TriggerCondition( 8, PfEqual, 5 )--herbalist
		TriggerCondition( 8, LvCheck, ">", 39 )
		TriggerAction( 8, JumpPage, 13 )

		TriggerFailure( 8, JumpPage, 10 )
		Start( GetMultiTrigger(), 8 )
end
function new_jobch()

	local fclass = 4000
	local sclass = 40000
	Talk( 1, "Hello, You can change your class here!")
	Text( 1, "1st Classes", JumpPage, 2)
	Text( 1, "2nd Classes", JumpPage, 3)
	
	Talk( 2, "Choose your 1st class below:")
	Text( 2, "Swordsman", JumpPage, 4)
	Text( 2, "Hunter", JumpPage, 5)
	Text( 2, "Explorer", JumpPage, 6)
	Text( 2, "Herbalist", JumpPage, 7)
	
	Text(4, "[Swordsman]", MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition( 1, PfEqual, 0 )--Job
	TriggerCondition( 1, LvCheck, ">", 9 )--Level
	TriggerCondition( 1, HasMoney, fclass )
	TriggerAction(1, TakeMoney, fclass )
	TriggerAction(1, SetProfession, 1 )
	TriggerFailure(1, JumpPage, 19)
	
	Text(5, "[Hunter]", MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition( 1, PfEqual, 0 )--Job
	TriggerCondition( 1, LvCheck, ">", 9 )--Level
	TriggerCondition( 1, HasMoney, fclass )
	TriggerAction(1, TakeMoney, fclass )
	TriggerAction(1, SetProfession, 2)
	TriggerFailure(1, JumpPage, 19)
	
	
	Talk( 19, "You do not have "..fclass.." Gold to change your class" )
	Talk( 20, "You do not have "..sclass.." Gold to change your class" )

end
--[[
function BT_NewUser001()
	Talk( 1, "Senna: Hi, I am the image consultant for Argent City. I am responsible for all newcomers and visitors. Look for me if there is something you do not understand." )
--	Text( 1, "Star of Unity", JumpPage, 31 )
--	Text( 1, "Class Change", JumpPage, 2 )
--	Talk( 31, "Senna: Star of Unity is a mysterious accessory from another world. When you equip it something unexpected might happen. Once the energy of the Star of Unity has been fulfilled, you may redeem for a lv50 class weapon." )
--	Text( 31, "Redeem class weapon", Transfer_TeamStar, 1)
		
	AddNpcMission(2009)
	AddNpcMission(2010)
	AddNpcMission(2011)

end
]]

function BT_NewUser001()

	Talk( 1, "Senna: Hi, I am the image consultant for Argent City. I am responsible for all newcomers and visitors. Look for me if there is something you do not understand." )
--	Text( 1, "Star of Unity", JumpPage, 31 )
	Text( 1, "Regarding Argent City", JumpPage, 20 )
	Text( 1, "Class Change", JumpPage, 2 )
--	Text( 1, "Get Life Skill Points", JumpPage, 5 )
--	Text( 1, "Regarding Argent City", JumpPage, 4 )
	Text( 1, "Regarding Classes and Attributes", JumpPage, 11 )
	Text( 1, "Regarding Monster Coordinates", JumpPage, 30 )
	Text( 1, "I have understood all",  CloseTalk)

	Talk( 5, "Argent City: Here, click exchange to obtain some life points for only 50k!" )
	InitTrigger()
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeMoney, 50000 )
	TriggerAction( 1, AddExpAndType,2,99000,99000)
	TriggerFailure( 1, JumpPage, 9 )
	Text( 5,"Exchange" ,MultiTrigger,GetMultiTrigger(),1)
	Text( 5,"Leave", CloseTalk)

	Talk( 9, "Argent City: Please make sure you have atleast 50k" )

--[[	Talk( 4, "Argent City is a place for merchant to sell their products. Have a look around." )
	Text( 4, "Regarding Weapon Shop", JumpPage, 5 )
	Text( 4, "Regarding Armor Shop", JumpPage, 7 )
	Text( 4, "Regarding Item Shop", JumpPage, 8 )
	Text( 4, "Regarding Teleporter", JumpPage, 9 )
	Text( 4, "Regarding the Nurse", JumpPage, 10 )

	Talk( 5, "Argent City's Blacksmith Goldie deals in the sale of weapons. His weapons are of excellent quality. Go take a look. Blacksmith's shop is at Argent City's top left corner." )
	Text( 5, "Regarding other shops", JumpPage, 4 )
	Text( 5, "I have understood all",  CloseTalk )

--	Talk( 6, "Look for me again if there is anything you don't understand", CloseTalk )

	Talk( 7, "Armors made in Argent City are very durable. You can have a look at them at the top right corner of the city." )
	Text( 7, "Regarding other shops", JumpPage, 4 )
	Text( 7, "I have understood all",  CloseTalk )

	Talk( 8, "We have a lot of items here that are important to an Explorer. Check it out on the right side of the pond." )
	Text( 8, "Regarding other shops", JumpPage, 4 )
	Text( 8, "I have understood all",  CloseTalk )

	Talk( 9, "Teleporter can send you to any city in this land. They can also record the spawn point for you. She is beside the western gate." )
	Text( 9, "Regarding other shops", JumpPage, 4 )
	Text( 9, "I have understood all",  CloseTalk )
]]--
	Talk( 10, "The nurse is just slightly below the fountain. She is a gentle and caring lady that is well loved by all." )
	Text( 10, "Regarding other shops", JumpPage, 4 )
	Text( 10, "I have understood all", CloseTalk)

	
	InitTrigger()
	TriggerCondition( 1, NoRecord, 700 )
	TriggerCondition( 1, HasMission, 700 )
	TriggerCondition( 1, NoFlag, 700, 10 )
	TriggerAction( 1, SetFlag, 700, 10)
	TriggerAction( 1, JumpPage, 12 )
	TriggerFailure( 1, JumpPage, 12 )
	Talk( 11, "Senna: Being a new player, you must understand the basic of each class and attributes. What you wish to know?" )
	Text( 11, "Regarding Classes", JumpPage, 12)
	Text( 11, "Regarding Attributes", JumpPage, 13)
	Text( 11, "I have understood all", JumpPage, 6 )
	--Text( 11, "Regarding Classes", MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, NoRecord, 700 )
	TriggerCondition( 1, HasMission, 700 )
	TriggerCondition( 1, NoFlag, 700, 20 )
	TriggerAction( 1, SetFlag, 700, 20)
	TriggerAction( 1, JumpPage, 13 )
	TriggerFailure( 1, JumpPage, 13 )
	--Text( 11, "Regarding Attributes", MultiTrigger, GetMultiTrigger(), 1)

	Talk( 12, "Senna: There are 7 basic classes in this game. Each has its unique ways and serves a special purpose in the game. Which would you like to become?" )
	Text( 12, "Regarding Swordsman", JumpPage, 14 )
	Text( 12, "Regarding Hunter", JumpPage, 15 )
--	Text( 12, "Regarding Sailor", JumpPage, 16 )
	Text( 12, "Regarding Explorer", JumpPage, 17 )
	Text( 12, "Regarding Herbalist", JumpPage, 18 )
--	Text( 12, "Regarding Artisan", JumpPage, 19 )
--	Text( 12, "Regarding Merchant", JumpPage, 20 )
	Text( 12, "Understood. Let me check out others.", JumpPage, 11 )

	Talk( 13, "Senna: Each character will have 5 base attributes. Players can increase them accordingly to raise certain aspect of their ability. Each level will reward players with 1 stat point and 1 skill point. Beginner will have 5 stat points to distribute." )
	Text( 13, "Regarding Strength", JumpPage, 21 )
	Text( 13, "Regarding Agility", JumpPage, 22 )
	Text( 13, "Regarding Constitution", JumpPage, 23 )
	Text( 13, "Regarding Spirit", JumpPage, 24 )
	--Text( 13, "Regarding Luck", JumpPage, 25 )
	Text( 13, "Regarding Accuracy", JumpPage, 26 )
	Text( 13, "Understood. Let me check out others.", JumpPage, 11 )

	Talk( 14, "Senna: Swordsman has the highest physical resistance in this game. Male character may choose to become one when they reach Lv 10. Look for Peter in Argent City to select the Swordsman class." )
	Text( 14, "Regarding other Classes", JumpPage, 12)
	Text( 14, "Regarding Attributes", JumpPage, 13)
	Text( 14, "I have understood all", JumpPage, 27)

	Talk( 15, "Senna: Hunters is the only long range class in this game. After further advancement, they can learn to use fireguns which have higher damage. Only Lance and Phyllis may become a Hunter. Players Lv 10 and above can look for Ray in Icicle to become a Hunter." )
	Text( 15, "Regarding other Classes", JumpPage, 12)
	Text( 15, "Regarding Attributes", JumpPage, 13)
	Text( 15, "I have understood all", JumpPage, 27)

	Talk( 16, "Senna: Sailor is the strongest class in the sea. It is still unreleased in current version." )
	Text( 16, "Regarding other Classes", JumpPage, 12)
	Text( 16, "Regarding Attributes", JumpPage, 13)
	Text( 16, "I have understood all", JumpPage, 27)
	
	Talk( 17, "Senna: Senna: Explorer are the best support class in the sea. Beside Carsise, all other 3 character can apply for this class. Players Lv 10 and above can talk to Little Daniel in Argent City to become an Explorer." )
	Text( 17, "Regarding other Classes", JumpPage, 12)
	Text( 17, "Regarding Attributes", JumpPage, 13)
	Text( 17, "I have understood all", JumpPage, 27)

	Talk( 18, "Resline: Herbalist are loyal followers of Goddess Kara. They possess mystical healing ability. Only Phyllis and Ami can select to become a Herbalist. Lv 10 players can look for High Priest - Gannon in Shaitan City to become a Herbalist." )
	Text( 18, "Regarding other Classes", JumpPage, 12)
	Text( 18, "Regarding Attributes", JumpPage, 13)
	Text( 18, "I have understood all", JumpPage, 27)

	Talk( 19, "Senna: Artisan is the only class that can make item. They will be in-charge of building structures for the guild. It is still unreleased in current version." )
	Text( 19, "Regarding other Classes", JumpPage, 12)
	Text( 19, "Regarding Attributes", JumpPage, 13)
	Text( 19, "I have understood all", JumpPage, 27)

	Talk( 20, "Senna: Merchant is the richest of all classes as they specialise in commerce. It is still unreleased in current version." )
	Text( 20, "Regarding other Classes", JumpPage, 12)
	Text( 20, "Regarding Attributes", JumpPage, 13)
	Text( 20, "I have understood all", JumpPage, 27)

	Talk( 21, "Senna: Strength increases Melee Attack power" )
	Text( 21, "Enquire about other Attributes", JumpPage, 13)
	Text( 21, "Enquire about other Classes", JumpPage, 12)
	Text( 21, "I have understood all", JumpPage, 27)

	Talk( 22, "Senna: Agility increases Attack Speed and Dodge Rate" )
	Text( 22, "Enquire about other Attributes", JumpPage, 13)
	Text( 22, "Enquire about other Classes", JumpPage, 12)
	Text( 22, "I have understood all", JumpPage, 27)

	Talk( 23, "Senna: Constitution increases Max HP and Physical Resist" )
	Text( 23, "Enquire about other Attributes", JumpPage, 13)
	Text( 23, "Enquire about other Classes", JumpPage, 12)
	Text( 23, "I have understood all", JumpPage, 27)

	Talk( 24, "Senna: Spirit increases Max SP and certain skill effect" )
	Text( 24, "Enquire about other Attributes", JumpPage, 13)
	Text( 24, "Enquire about other Classes", JumpPage, 12)
	Text( 24, "I have understood all", JumpPage, 27)

	Talk( 25, "Senna: Luck increases Critical Rate and Combining Rate" )
	Text( 25, "Enquire about other Attributes", JumpPage, 13)
	Text( 25, "Enquire about other Classes", JumpPage, 12)
	Text( 25, "I have understood all", JumpPage, 27)

	Talk( 26, "Senna: Accuracy increases Hit Rate and Range Attack power" )
	Text( 26, "Enquire about other Attributes", JumpPage, 13)
	Text( 26, "Enquire about other Classes", JumpPage, 12)
	Text( 26, "I have understood all", JumpPage, 27)

	Talk( 27, "Senna: Ok, look for me again if you have something that you do not understand.")
	
	Talk( 28, "Well done, it looks like you now have a good grasp at basic combat and also a good idea on how item drops work. Since there is nothing much left to learn from me, why don't you go and look for my friends? If fighting is your cup of tea, seek out Marcusa. He's a patroller and is often seen patrolling about the outskirts of this city. He was last seen at (2085, 2742). Another person you may like to meet would be Ditto <b(2250, 2770)>, Argent City's famous physician. Lately, he has been looking for helpers to help him collect more ingredients for his medicine. If you are interested, you can look for him on the right side of the city fountain (2250, 2770)." )
	Text( 28, "Regarding Argent City", JumpPage, 4 )
	Text( 28, "Regarding Classes and Attributes", JumpPage, 11 )
	Text( 28, "I have understood all",  CloseTalk)

	Talk( 29, "Senna: Very well! You have progressed to Lv 9. You can choose your class at Lv 10. Go now to the related NPC to start your trial for the class you wish to become. Swordsman look for Peter in Argent City at <b(2192, 2767)>. Herbalist look for High Priest - Gannon in Shaitan City at <b(862,3500)>. Hunter look for Swordsman - Ray in Icicle Castle at <b(1365, 570)>. Explorer look for Little Daniel at <b(2193, 2730)>. You can reach Argent or Shaitan by using the teleporter." )
	Text( 29, "I would like to ask about something", JumpPage, 4 )
	Text( 29, "Regarding Classes and Attributes", JumpPage, 11 )
	Text( 29, "I have understood all",  CloseTalk )

	Talk( 30, "Senna: To check the coordinates of monsters in game, all you have to do is look for a Drunkyard in Argent City Bar at (2222, 288). He can tell you the coordinates for a fee." )
	
	InitTrigger()
	TriggerCondition( 1, NoItem, 1034, 1 )
	TriggerCondition( 1, NoItem, 1033, 1 )
	TriggerCondition( 1, BankNoItem, 1034, 1 )
	TriggerCondition( 1, BankNoItem, 1033, 1 )
	TriggerCondition( 1, EquipNoItem, 1034, 1 )
	TriggerCondition( 1, EquipNoItem, 1033, 1 )

	TriggerCondition( 1, LvCheck, "<", 41 )
	TriggerAction( 1, GiveItem, 1033, 1, 4 )
	TriggerFailure( 1, JumpPage, 6 )
	Talk( 31, "Senna: Star of Unity is a mysterious accessory from another world. When you equip it, you might be able to activate the power of unity and something unexpected might happen. We are running a trial event 'Hoard Exchange'. All players below Lv 41 can redeem a Star of Unity to exchange for a suitable piece of equipment. Are you interested?" )
	Text( 31, "Redeem Star of Unity",MultiTrigger, GetMultiTrigger(), 1)
	Text( 31, "Hoard Exchange",JumpPage, 32 )

	Talk( 32,"Thank you for using our products. If you have a 'Star of Unity', you can redeem a Lv 50 weapon for your class. Interesting isn't it?")
	Text( 32, "Redeem class weapon", Transfer_TeamStar, 1)

	Talk( 6, "Senna: I'm sorry, you are not qualified to receive the prize" )

	--InitTrigger()
	---------------------玩家超过6级完成过瑟安的战斗训练任务
	--TriggerCondition( 1, LvCheck, ">", 4 )
	--TriggerCondition( 1, LvCheck, "<", 8 )
	--TriggerCondition( 1, HasRecord, 704)
	--TriggerAction( 1, JumpPage, 28 )
	--TriggerCondition( 2, LvCheck, ">", 8 )
	--TriggerCondition( 2, PfEqual, 0 )
	--TriggerAction( 2, JumpPage, 29 )
	--TriggerFailure( 2, JumpPage, 1 )

	--Start( GetMultiTrigger(), 2 )

	AddNpcMission ( 701 )
	AddNpcMission ( 702 )
	AddNpcMission ( 704 )
	AddNpcMission ( 706 )
	AddNpcMission ( 708 )
--	AddNpcMission ( 200 )
--	AddNpcMission 	(402)
	AddNpcMission 	(50)
	AddNpcMission 	(51)
	AddNpcMission 	(61)
	AddNpcMission 	(62)
	AddNpcMission 	(63)
	AddNpcMission 	(64)
	AddNpcMission 	(65)
	AddNpcMission 	(82)

	MisListPage(28)
	MisListPage(29)
-----------------二月-------------压岁包
	--AddNpcMission 	(5507)

end
r_talk13 = nil
function r_talk13 ()
	Talk( 1, "Monica: Hi, I am Banker Monica. Accounts can never go wrong with me around." )
	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, OpenBank )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Vault (200G Fee)", MultiTrigger, GetMultiTrigger(), 1)

	--[[InitTrigger()
	TriggerCondition( 1, HasMoney, 5000 )
	TriggerAction( 1, TakeMoney, 5000 )
	TriggerAction( 1, OpenGuildBank )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Guild Bank (50,000G Fee)", MultiTrigger, GetMultiTrigger(), 1)]]

	Talk( 2, "Sorry, you do not have sufficient gold to pay for vault usage" )

	-- AddNpcMission(1050)
	-- AddNpcMission(1212)
	-- AddNpcMission(6091)
	-- AddNpcMission(6092)
end

r_talk81 = nil
function r_talk81 ()
	
	
	Talk( 1, "Belinda: Welcome to Icicle Bank. How may I help you?" )
	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, OpenBank )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Vault (200G Fee)", MultiTrigger, GetMultiTrigger(), 1)
	Talk( 2, "Sorry, you do not have sufficient gold to pay for vault usage" )

	-- AddNpcMission	(1102)
	-- AddNpcMission	(187)
	-- AddNpcMission	(188)
	-- AddNpcMission	(189)
----------eleven
	-- AddNpcMission	(597)
	-- AddNpcMission	(598)
	-- AddNpcMission ( 6093 )

end 

r_talk51 = nil
function r_talk51 ()
	
	
	Talk( 1, "Judis: Hi! Welcome to the bank of Shaitan! How can I help you?" )
	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, OpenBank )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Vault (200G Fee)", MultiTrigger, GetMultiTrigger(), 1)
	Talk( 2, "Sorry, you do not have sufficient gold to pay for vault usage" )

	-- AddNpcMission	(1051)
	-- AddNpcMission	(1104)
	-- AddNpcMission	(1160)
	-- AddNpcMission	(1213)
	-- AddNpcMission(	1231	)
-------eleven
	-- AddNpcMission(	5012	)	
end 

r_talk234 = nil
function r_talk234()
	Talk( 1, "Cartel: Hi! Want a change of hairstyle? Be hip and keep up with the trend!" )
	Text( 1, "Trade Hair Items", BuyPage )
	Text( 1, "I want to change my hairstyle", OpenHair )
	Text( 1, "Forget it", CloseTalk )
	
	InitTrade()
	Weapon(	1807	)
	Weapon(	1805	)
	Weapon(	1804	)
	Weapon(	1806	)
	Defence(	1798	)
	Defence(	1800	)
	Defence(	1801	)
	Defence(	1803	)
	Defence(	1797	)
	Defence(	1799	)
	Defence(	1802	)
	Defence(	4610	)
	Defence(	4609	)
	Defence(	4607	)	
	Other(	931	)
	Other(	932	)
	Other(	933	)
	Other(	934	)
	Other(	1808	)
	Other(	1809	)
	Other(	1810	)
	Other(	1811	)
	
end

r_talk07 = nil
function r_talk07 ()
	Talk( 1, "Jimberry: Hi, welcome! How can I help you?" )
	Text( 1, "Trade", BuyPage )
	Text (1, "All Skills Please!", AddSkillNPC, 1)	
	Text( 1, "Combine", OpenUnite )

	InitTrigger()
	TriggerAction(1, AddLifeExp, 100000,100000)
	Text( 1, "Life Skill Points", MultiTrigger,GetMultiTrigger(), 1 )


--	Text( 1, "Redeem Alloy Pickaxe",JumpPage, 3 )
--	Text( 1, "Redeem Reality Mask",JumpPage, 2 )
	Text( 1, "Nothing...",CloseTalk )

	InitTrade()
--	Weapon(	15860	)
	Weapon(	3297	)
	Weapon(	3298	)
	Weapon(	3164	)
	Weapon(	3160	)
	Weapon(	3161	)
	Weapon(	3165	)
	Weapon(	3238	)
	Weapon(	3170	)
	Weapon(	3293	)
	Weapon(	3174	)
	Weapon(	3163	)
	Weapon(	3176	)
	Weapon(	3180	)
	Weapon(	3179	)
	Weapon(	3177	)
	Weapon(	3168	)
	Weapon(	3162	)
	Weapon(	3166	)
	Weapon(	3167	)
	Weapon(	3172	)
	Weapon(	3173	)
	Weapon(	3227	)
	Weapon(	3231	)
	Weapon(	3228	)
	Weapon(	3229	)
	Weapon(	3230	)
	Weapon(	3232	)
	Weapon(	3233	)
	Weapon(	3234	)
	Weapon(	3235	)
	Weapon(	3236	)
	Weapon(	3237	)
	Weapon(	3299	)
	Weapon(	9500	)
--	Defence(	15860	)
	Defence(	3206	)
	Defence(	3208	)
	Defence(	3205	)
	Defence(	3242	)
	Defence(	3210	)
	Defence(	3207	)
	Defence(	3211	)
	Defence(	3215	)
	Defence(	3212	)
	Defence(	3209	)
	Defence(	3220	)
	Defence(	3222	)
	Defence(	3219	)
	Defence(	3218	)
	Defence(	3216	)
	Defence(	15880	)
	Defence(	3217	)
	Defence(	3224	)
	Defence( 886 )
--	Other(	15860	)
	Other(	3187	)
	Other(	3188	)
	Other(	3190	)
	Other(	3239	)
	Other(	3197	)
	Other(	3193	)
	Other(	3241	)
	Other(	3192	)
	Other(	3198	)
	Other(	3202	)
	Other(	3203	)
	Other(	3204	)
	Other(	3225	)
	Other(	3226	)
	Other(	3294	)
	Other(	3295	)
	Other(	3141	)
	Other(	4602	)
	Other(	4603	)
	Other(	4604	)
	Other( 3296 )
	Other(	2679	)
	Other(	2689	)
	Other(	2699	)
	Other(	2709	)
	Other(	1611	)
	Other(	1682	)
	Other(	1842	)
	Other(	1612	)
	Other(	1710	)
	Other(	1693	)
	Other(	4716	)
	Other(	1716	)
	Other(	1711	)
	Other(	3384	)
	Other(	3932	)
	Other(	1619	)
	Other(	2396	)
	Other(	1729	)
	Other(	4459	)
	Other(	1697	)
	Other(	1730	)
	Other(	1712	)
	Other(	1734	)
	Other(	1621	)
	Other(	1703	)
	Other(  2440    )



	InitTrigger()
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerCondition( 1, HasMoney, 10000 )
	TriggerAction( 1, TakeMoney, 10000 )
	TriggerAction( 1, GiveItem, 3908, 1 , 4)
	TriggerAction( 1, JumpPage, 3 )
	TriggerFailure( 1, JumpPage, 4 )
	Talk( 3, "To obtain Alloy Pickaxe requires 10000G" )
	Text( 3, "Redeem Alloy Pickaxe", MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerCondition( 1, HasItem, 2588, 1 )
	TriggerCondition( 1, HasItem, 1624, 10 )
	TriggerCondition( 1, HasMoney, 10000 )
	TriggerAction( 1, TakeItem, 2588, 1 )
	TriggerAction( 1, TakeItem, 1624, 10 )
	TriggerAction( 1, TakeMoney, 10000 )
	TriggerAction( 1, GiveItem, 2326, 1 , 4)
	TriggerAction( 1, JumpPage, 3 )
	TriggerFailure( 1, JumpPage, 4 )
	Talk( 2, "To obtain a Reality Mask requires 1 Elven Signet, 10000G and any of 10x Lv3 gathered resource" )
	Text( 2, "Bones to change a Reality Mask", MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerCondition( 1, HasItem, 2588, 1 )
	TriggerCondition( 1, HasItem, 4031, 10 )
	TriggerCondition( 1, HasMoney, 10000 )
	TriggerAction( 1, TakeItem, 2588, 1 )
	TriggerAction( 1, TakeItem, 4031, 10 )
	TriggerAction( 1, TakeMoney, 10000 )
	TriggerAction( 1, GiveItem, 2326, 1 , 4)
	TriggerAction( 1, JumpPage, 3 )
	TriggerFailure( 1, JumpPage, 4 )
	Text( 2, "Crystal Eolith to change a Reality Mask", MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerCondition( 1, HasItem, 2588, 1 )
	TriggerCondition( 1, HasItem, 3991, 10 )
	TriggerCondition( 1, HasMoney, 10000 )
	TriggerAction( 1, TakeItem, 2588, 1 )
	TriggerAction( 1, TakeItem, 3991, 10 )
	TriggerAction( 1, TakeMoney, 10000 )
	TriggerAction( 1, GiveItem, 2326, 1 , 4)
	TriggerAction( 1, JumpPage, 3 )
	TriggerFailure( 1, JumpPage, 4 )
	Text( 2, "Teak Wood Log to change a Reality Mask ", MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerCondition( 1, HasItem, 2588, 1 )
	TriggerCondition( 1, HasItem, 4011, 10 )
	TriggerCondition( 1, HasMoney, 10000 )
	TriggerAction( 1, TakeItem, 2588, 1 )
	TriggerAction( 1, TakeItem, 4011, 10 )
	TriggerAction( 1, TakeMoney, 50000 )
	TriggerAction( 1, GiveItem, 2326, 1 , 4)
	TriggerAction( 1, JumpPage, 3 )
	TriggerFailure( 1, JumpPage, 4 )
	Text( 2, "Bubble Fish to change a Reality Mask", MultiTrigger, GetMultiTrigger(), 1)

	Talk( 3, "Jimberry: Keep it well, this is important!" )
	Talk( 4, "Jimberry: You do not seem to have enough materials. Your inventory may be binded or you do not have enough free slots." )
end

r_talk242 = nil
function r_talk242()

	Talk( 14, "Bingo: Give me a Christmas Gem Voucher, and you will get a high quality gem." )
	InitTrigger() --¸ß¼¶±¦Ê¯¶Ò»»È¯
	TriggerCondition( 1, HasItem,2899, 1 )
	TriggerCondition( 1, HasLeaveBagGrid, 3 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 2899, 1 )
	TriggerAction( 1, GiveItem, 0860, 3, 101 )
	TriggerFailure( 1, JumpPage, 15 )
	Text( 14, "Exchanged 3 Gem of the Wind.",MultiTrigger, GetMultiTrigger(), 1) 
	InitTrigger() --¸ß¼¶±¦Ê¯¶Ò»»È¯
	TriggerCondition( 1, HasItem,2899, 1 )
	TriggerCondition( 1, HasLeaveBagGrid, 3 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 2899, 1 )
	TriggerAction( 1, GiveItem, 0861, 3,101 )
	TriggerFailure( 1, JumpPage, 15 )
	Text( 14, "Redeem 3 Gem of Striking",MultiTrigger, GetMultiTrigger(), 1) 

	InitTrigger() --¸ß¼¶±¦Ê¯¶Ò»»È¯
	TriggerCondition( 1, HasItem,2899, 1 )
	TriggerCondition( 1, HasLeaveBagGrid, 3 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 2899, 1 )
	TriggerAction( 1, GiveItem, 0862, 3,101 )
	TriggerFailure( 1, JumpPage, 15 )
	Text( 14, "Exchanged 3 Gem of Colossus",MultiTrigger, GetMultiTrigger(), 1) 

	InitTrigger() --¸ß¼¶±¦Ê¯¶Ò»»È¯
	TriggerCondition( 1, HasItem,2899, 1 )
	TriggerCondition( 1, HasLeaveBagGrid, 3 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 2899, 1 )
	TriggerAction( 1, GiveItem, 0863, 3,101 )
	TriggerFailure( 1, JumpPage, 15 )
	Text( 14, "Exchanged 3 Gem of Rage",MultiTrigger, GetMultiTrigger(), 1) 
	InitTrigger() --¸ß¼¶±¦Ê¯¶Ò»»È¯
	TriggerCondition( 1, HasItem,2899, 1 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 2899, 1 )
	TriggerAction( 1, GiveItem, 1012, 1,101 )
	TriggerFailure( 1, JumpPage, 15 )
	Text( 14, "Redeem 1 Gem of Soul",MultiTrigger, GetMultiTrigger(), 1) 

	Talk( 15, "Redemption failed. You do not seem to have any Christmas Gem Voucher or your inventory has been binded. " )
	Talk( 16, "Merry Christmas!" )

	Talk( 1, "Bingo: I have the latest news around here and it is reliable.")
	--Text( 1, "Christmas Gem Voucher", JumpPage, 14 )
	Text( 1, "Unique Gem Voucher", JumpPage, 12 )
--	Text( 1, "Sklv 1 Refining Gem Voucher", JumpPage, 2 )
--	Text( 1, "Sklv 2 Refining Gem Voucher", JumpPage, 3 )
--	Text( 1, "Refining Gem Voucher", JumpPage, 4 )
--	Text( 1, "Combine Wishing Stone", JumpPage, 6 )
--	Text( 1, "Gem Voucher", JumpPage, 5 )

	Talk( 2, "Bingo: Pass me one Sklv 1 Refining Gem Voucher to exchange for a Sklv 1 Refining Gem. Also, you might obtain an additional random Lv1 Attribute Gem.")
	Text( 2, "Confirm to redeem", TransferDiamond, 1)

	Talk( 3, "Bingo: Bring me a Sklv 2 Refining Gem Voucher to exchange for a Sklv 2 Refining Gem. You might also obtain an additional random Sklv 2 Attribute Gem.")
	Text( 3, "Confirm to redeem", TransferDiamond, 2)

	Talk( 4, "Bingo: Pass me one Refining Gem Voucher to exchange for a Sklv 1 Refining Gem")
	Text( 4, "Confirm to redeem", TransferDiamond, 3)

	Talk( 5, "Bingo: Bring me a Gem Voucher in exchange for a Sklv 1 Gem.")
	Text( 5, "Confirm to redeem", TransferDiamond, 4)

	Talk( 17, "Bingo: Do you have Pirate Vouchers?")

	InitTrigger()--¶Ò»»"IPOD"¶Ò»»È¯
	TriggerCondition( 1, HasItem, 2238, 1 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 2238, 1 )
 	TriggerAction( 1, GiveItem, 2306, 1 ,4)
	TriggerFailure( 1, JumpPage, 18 )
	Text( 17, "I have Pirate Voucher 8",MultiTrigger, GetMultiTrigger(), 1)

	Text( 17, "I have Pirate Voucher 6",JumpPage, 19)
	Talk(19,"Do you wish to exchange?")
	Text( 19, "Confirm to exchange",GetChaName_5, 1)

	InitTrigger()--¶Ò»»¾«ÁéÓ²±Ò99¸ö
	TriggerCondition( 1, HasItem, 2237, 1 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 2237, 1 )
 	TriggerAction( 1, GiveItem, 855, 99 ,4)
	TriggerFailure( 1, JumpPage, 18 )
	Text( 17, "I have Pirate Voucher 9",MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()-- ¶Ò»»ÖýÔìÍ¼Ö½"Encrypted Blueprint"£±ÕÅ
	TriggerCondition( 1, HasItem, 2239, 1 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 2239, 1 )
 	TriggerAction( 1, GiveItem, 1001, 1 ,4)
	TriggerFailure( 1, JumpPage, 18 )
	Text( 17, "I have Pirate Voucher 7",MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()--¶Ò»»¼ÓËÙ³É³¤¹û1¸ö
	TriggerCondition( 1, HasItem, 2241, 1 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 2241, 1 )
 	TriggerAction( 1, GiveItem, 0578, 1 ,4)
	TriggerFailure( 1, JumpPage, 18 )
	Text( 17, "I have Pirate Voucher 5",MultiTrigger, GetMultiTrigger(), 1)
	Text( 17, "Total amount of other Pirate Voucher", GetChaName_4, 1)

	Talk( 18, "Bingo: You do not seem to have the suitable Pirate Voucher. Please check to see if your inventory is binded and that theres a least 1 empty slot.")

 	InitTrigger() --ºÏ³ÉÐíÔ¸Ê¯
	TriggerCondition( 1, HasItem, 3905, 5 )
	TriggerCondition( 1, HasItem, 3907, 1 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 3905, 5 )
	TriggerAction( 1, TakeItem, 3907, 1 )
 	TriggerAction( 1, GiveItem, 3906, 1 ,4)
	TriggerFailure( 1, JumpPage, 8 )
	Talk( 6, "Bingo: Bring me 5 Dark Wishing Stone and 1 Welding Catalyst, I will make 1 Sparkling Wishing Stone for you.")
	Text( 6, "Confirm to combine",MultiTrigger, GetMultiTrigger(), 1)        

	Talk( 8, "Bingo: You seems to lack Wishing Stones and Welding Catalyst! Please make sure that your inventory is not binded and has at least 1 empty slot.")

	InitTrigger() --¶Ò»»ÈýÔÂ¾«Áé
	TriggerCondition( 1, HasItem, 3342, 2 )
	TriggerCondition( 1, HasItem, 3337, 1 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 3342, 2 )
	TriggerAction( 1, TakeItem, 3337, 1 )
	TriggerAction( 1, GiveItem, 3335, 1 ,4)
	TriggerFailure( 1, JumpPage, 11 ) 
	Talk( 10, "Bingo: Bring me 2 Lantern and 1 Fairy Soul to exchange for a Fairy March. Question regarding Fairy Soul? Go to 'Hafta Haven' and look for 'Harbor Operator - Whitcombe'.")
	Text( 10, "Confirm trade",MultiTrigger, GetMultiTrigger(), 1) 

	Talk( 11, "Bingo: Fairy March requires 2 Lanterns and 1 Fairy Soul. Please make sure that your inventory is not binded and has at least 1 empty inventory slot.")

	Talk( 12, "Bingo: Give me 2 Unique Gem Voucher to exchange for x1 of the following five gems.")

	InitTrigger() --¸ß¼¶±¦Ê¯¶Ò»»È¯
	TriggerCondition( 1, HasItem, 0333, 2 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 0333, 2 )
	TriggerAction( 1, GiveItem, 5845, 1,101 )
	TriggerFailure( 1, JumpPage, 13 ) 
	Text( 12, "Azrael Glare",MultiTrigger, GetMultiTrigger(), 1) 

	InitTrigger() --¸ß¼¶±¦Ê¯¶Ò»»È¯
	TriggerCondition( 1, HasItem, 0333, 2 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 0333, 2 )
	TriggerAction( 1, GiveItem, 5846, 1, 101 )
	TriggerFailure( 1, JumpPage, 13 ) 
	Text( 12, "Azrael Undead",MultiTrigger, GetMultiTrigger(), 1) 

	InitTrigger() --¸ß¼¶±¦Ê¯¶Ò»»È¯
	TriggerCondition( 1, HasItem, 0333, 2 )
	TriggerCondition( 1, HasLeaveBagGrid, 1)
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 0333, 2 )
	TriggerAction( 1, GiveItem, 5847, 1,101 )
	TriggerFailure( 1, JumpPage, 13 ) 
	Text( 12, "Azrael Dance",MultiTrigger, GetMultiTrigger(), 1) 

	InitTrigger() --¸ß¼¶±¦Ê¯¶Ò»»È¯
	TriggerCondition( 1, HasItem, 0333, 2 )
	TriggerCondition( 1, HasLeaveBagGrid,1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 0333, 2 )
	TriggerAction( 1, GiveItem, 5848, 1,101 )
	TriggerFailure( 1, JumpPage, 13 ) 
	Text( 12, "Azrael Aggregation",MultiTrigger, GetMultiTrigger(), 1) 

	InitTrigger() --¸ß¼¶±¦Ê¯¶Ò»»È¯
	TriggerCondition( 1, HasItem, 0333, 2 )
	TriggerCondition( 1, HasLeaveBagGrid,1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 0333, 2 )
	TriggerAction( 1, GiveItem, 5849, 1,101 )
	TriggerFailure( 1, JumpPage, 13 ) 
	Text( 12, "Azrael Light",MultiTrigger, GetMultiTrigger(), 1) 

	Talk( 13, "Bingo: You do not seem to have any Unique Gem Voucher. Please make sure that your inventory is not binded and has at least 1 empty inventory slots.")
	Talk( 20, "Bingo: Do you have many moon cakes? You can exchange much great stuff from me." )
	InitTrigger() --99¸ö£ºÃÔÖ®Ëø10¸ö
	TriggerCondition( 1, HasItem,3915, 99 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 3915, 99 )
	TriggerAction( 1, GiveItem, 2440, 10, 4 )
	TriggerFailure( 1, JumpPage, 21 )
	Text( 20, "Exchange 10 Locks of Mystic",MultiTrigger, GetMultiTrigger(), 1) 
	
	InitTrigger() --100¸ö£º²Æ¸»1¸ö
	TriggerCondition( 1, HasItem,3915, 100 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 3915, 100 )
	TriggerAction( 1, GiveItem, 3096, 1,4 )
	TriggerFailure( 1, JumpPage, 21 )
	Text( 20, "Exchange one Amplifier of Luck",MultiTrigger, GetMultiTrigger(), 1) 

	InitTrigger() --200¸ö£º²Ø±¦Í¼1¸ö
	TriggerCondition( 1, HasItem,3915, 200 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 3915, 200 )
	TriggerAction( 1, GiveItem, 1092, 1,4 )
	TriggerFailure( 1, JumpPage, 21 )
	Text( 20, "Exchange one Treasure Map",MultiTrigger, GetMultiTrigger(), 1) 

	InitTrigger() --300¸ö£º99°ü1¸ö
	TriggerCondition( 1, HasItem,3915, 300 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 3915, 300 )
	TriggerAction( 1, GiveItem, 1095, 1,4 )
	TriggerFailure( 1, JumpPage, 21 )
	Text( 20, "Exchange one 99 Parcel",MultiTrigger, GetMultiTrigger(), 1) 
	
	InitTrigger() --2000¸ö£º¼ÓÄÉÖ®Éñ£¨¾«Éñ¼Ó5£©
	TriggerCondition( 1, HasItem,3915, 2000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 3915, 2000 )
	TriggerAction( 1, GiveItem, 1012, 1,4 )
	TriggerFailure( 1, JumpPage, 21 )
	Text( 20, "Exchange one Gem of Soul",MultiTrigger, GetMultiTrigger(), 1) 
	Text( 20, "Next page", JumpPage, 22 )

	Talk( 22, "Bingo: Do you have many moon cakes? You can exchange much great stuff from me." )

	InitTrigger() --2000¸ö£ºÑ×Óñ£¨Á¦Á¿¼Ó5£©
	TriggerCondition( 1, HasItem,3915, 2000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 3915, 2000 )
	TriggerAction( 1, GiveItem, 863, 1,4 )
	TriggerFailure( 1, JumpPage, 21 )
	Text( 22, "Exchange one Gem of Rage",MultiTrigger, GetMultiTrigger(), 1) 

	InitTrigger() --2000¸ö£ºÑÒÓñ£¨ÌåÖÊ¼Ó5£©
	TriggerCondition( 1, HasItem,3915, 2000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 3915, 2000 )
	TriggerAction( 1, GiveItem, 862, 1,4 )
	TriggerFailure( 1, JumpPage, 21 )
	Text( 22, "Exchange one Gem of Colossus",MultiTrigger, GetMultiTrigger(), 1) 

	InitTrigger() --2000¸ö£ºÓ¥ÑÛÊ¯£¨×¨×¢¼Ó5£©
	TriggerCondition( 1, HasItem,3915, 2000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 3915, 2000 )
	TriggerAction( 1, GiveItem, 861, 1,4 )
	TriggerFailure( 1, JumpPage, 21 )
	Text( 22, "Exchange one Gem of Striking",MultiTrigger, GetMultiTrigger(), 1) 

	InitTrigger() --2000¸ö£º·çÁéÊ¯£¨Ãô½Ý¼Ó5£©
	TriggerCondition( 1, HasItem,3915, 2000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 3915, 2000 )
	TriggerAction( 1, GiveItem, 860, 1,4 )
	TriggerFailure( 1, JumpPage, 21 )
	Text( 22, "Exchange one Gem of Wind",MultiTrigger, GetMultiTrigger(), 1) 

	InitTrigger() --3000¸ö£º65 BOSSÒÂ·þ1¼þ
	TriggerCondition( 1, HasItem,3915,3000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 3915, 3000)
	TriggerAction( 1, GiveItem, 241, 1, 4 )
	TriggerFailure( 1, JumpPage, 21 )
	Text( 22, "Exchange one Lvl65 Boss armor",MultiTrigger, GetMultiTrigger(), 1) 

	Text( 22, "Last page", JumpPage, 20 )

	Talk( 21, "Exchange failed. It seems that you have not either enough moon cakes or any blank inventory slot!" )	
end

r_talk05 = nil
function r_talk05 ()

	Talk( 1, "Donna: Hi, I am Donna. Are you a sailor? Have you been to the legendary Galley Isle? Tell me the stories if you have." )
	Text( 1, "Buy Wine", BuyPage )
--	Text( 1, "Reputation Redemption",JumpPage, 5)
	--Text(1, "Royal Pirate Reputation Redemption",JumpPage,7) --

	InitTrade()
	Other(	3916	)

	Talk( 2, "Donna: Heard you have run out of Eight Treasure Wine. I have one left though. If you would like to purchase it, bring me 100000G." )
	InitTrigger()
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeMoney, 100000 )
	TriggerAction( 1, GiveItem, 4072, 1, 4 )
	TriggerFailure( 1, JumpPage, 3 )
	Text( 2, "Eight Treasures Wine", MultiTrigger,GetMultiTrigger(),1)

	Talk( 3, "Donna: It seems that you do not have enough gold. Wine is not for the poor. Come back when you have earned enough." )

	Talk(4,"Reputation is very important. Those who are extremely helpful will in turn obtain more reputation! You can redeem these reputation points for rewards here")
	Text(4,"I have faith in my reputation. I come to redeem the rewards.", JumpPage,5)

	Talk(5,"The current rewards for redemption are as follows. When you redempt your rewards, I'll minus your fame.")
	Text(5, "Endeavor Emblem", JumpPage, 8)
	Text(5, "Mini Fairy fruits", JumpPage, 9)

	InitTrigger()
	TriggerCondition( 1, HasCredit,500 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 500 )
	TriggerAction( 1, GiveItem, 855,5,4 )
	TriggerFailure( 1, JumpPage, 6)
	Text(5,"x5 fairy coins (500 rep)" ,MultiTrigger,GetMultiTrigger(),1)

	Talk(8,"Donna: The Endeavor Emblem is a neccessities of crafting.")
	InitTrigger()
	TriggerCondition( 1, HasCredit,20 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 20 )
	TriggerAction( 1, GiveItem, 2602,1,4 )
	TriggerFailure( 1, JumpPage, 6)
	Text(8,"Novice Endeavor Emblem (20 rep)" ,MultiTrigger,GetMultiTrigger(),1)

	InitTrigger()
	TriggerCondition( 1, HasCredit,200 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 200 )
	TriggerAction( 1, GiveItem, 2603,1,4 )
	TriggerFailure( 1, JumpPage, 6)
	Text(8,"Standard Endeavor Emblem (200 rep)" ,MultiTrigger,GetMultiTrigger(),1)

	InitTrigger()
	TriggerCondition( 1, HasCredit,2000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 2000 )
	TriggerAction( 1, GiveItem, 2604,1,4 )
	TriggerFailure( 1, JumpPage, 6)
	Text(8,"Expert Endeavor Emblem (2000 rep)" ,MultiTrigger,GetMultiTrigger(),1)

	Talk(6,"Please make sure that there are empty slots in your inventory and your inventory is not binded. Either that you do not have sufficient reputation points. Help more people before you come back looking for me. Let me tell you a secret...If you are willing to accept a disciple...",CloseTalk)

	Talk(9,"Donna: Mini fruits can level your first generation fairies up to lv12. Your fame will be deducted on redemption.")
	InitTrigger()
	TriggerCondition( 1, HasCredit,2000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 2000 )
	TriggerAction( 1, GiveItem, 15001,1,4 )
	TriggerFailure( 1, JumpPage, 6)
	Text(9,"Mini Snow Dragon Fruit (2000 rep)" ,MultiTrigger,GetMultiTrigger(),1)
	InitTrigger()
	TriggerCondition( 1, HasCredit,2000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 2000 )
	TriggerAction( 1, GiveItem, 15002,1,4 )
	TriggerFailure( 1, JumpPage, 6)
	Text(9,"Mini Icespire Plum (2000 rep)" ,MultiTrigger,GetMultiTrigger(),1)
	InitTrigger()
	TriggerCondition( 1, HasCredit,2000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 2000 )
	TriggerAction( 1, GiveItem, 15003,1,4 )
	TriggerFailure( 1, JumpPage, 6)
	Text(9,"Mini Zephyr Fish Floss (2000 rep)" ,MultiTrigger,GetMultiTrigger(),1)
	InitTrigger()
	TriggerCondition( 1, HasCredit,2000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 2000 )
	TriggerAction( 1, GiveItem, 15004,1,4 )
	TriggerFailure( 1, JumpPage, 6)
	Text(9,"Mini Argent Mango (2000 rep)" ,MultiTrigger,GetMultiTrigger(),1)
	InitTrigger()
	TriggerCondition( 1, HasCredit,2000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 2000 )
	TriggerAction( 1, GiveItem, 15005,1,4 )
	TriggerFailure( 1, JumpPage, 6)
	Text(9,"Mini Shaitan Biscuit (2000 rep)" ,MultiTrigger,GetMultiTrigger(),1)


	--[[Talk(7,"Hi! This is the Royal Pirates! We only serve pirates with good reputation! Do you wish to redeem anything? Reputation points will be deducted upon redemption.")
	InitTrigger()
	TriggerCondition( 1, HasCredit,500 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 500 )
	TriggerAction( 1, GiveItem, 855,5,4 )
	TriggerAction( 1, JumpPage,8 )
	TriggerFailure( 1, JumpPage, 6)
	Text(7,"5 fairy coins: Requires 500 reputation points" ,MultiTrigger,GetMultiTrigger(),1)

	InitTrigger()
	TriggerCondition( 1, HasCredit,5000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 5000 )
	TriggerAction( 1, GiveItem, 3094,3,4 )
	TriggerAction( 1, JumpPage,8 )
	TriggerFailure( 1, JumpPage, 6)
	Text(7,"Amplifier of Strive x3: Requires 5000 reputation points" ,MultiTrigger,GetMultiTrigger(),1)


	InitTrigger()
	TriggerCondition( 1, HasCredit,20000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 20000 )
	TriggerAction( 1, GiveItem, 0610,1,4 )
	TriggerAction( 1, JumpPage,8 )
	TriggerFailure( 1, JumpPage, 6)
	Text(7,"1 Novice Self Destruct: Requires 20000 reputation points" ,MultiTrigger,GetMultiTrigger(),1)

	InitTrigger()
	TriggerCondition( 1, HasCredit,50000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 50000 )
	TriggerAction( 1, GiveItem, 0885,1,4 )
	TriggerAction( 1, JumpPage,8 )
	TriggerFailure( 1, JumpPage, 6)
	Text(7,"Lv1 Refining Gem: Requires 50000 reputation points" ,MultiTrigger,GetMultiTrigger(),1)


	InitTrigger()
	TriggerCondition( 1, HasCredit,200000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 200000 )
	TriggerAction( 1, GiveItem, 0862,1,4 )
	TriggerAction( 1, JumpPage,8 )
	TriggerFailure( 1, JumpPage, 6)
	Text(7,"Gem of Colossus x1: Requires 200000 reputation points" ,MultiTrigger,GetMultiTrigger(),1)


	InitTrigger()
	TriggerCondition( 1, HasCredit,600000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, DelRoleCredit, 600000 )
	TriggerAction( 1, GiveItem, 1012,1,4 )
	TriggerAction( 1, JumpPage,8 )
	TriggerFailure( 1, JumpPage, 6)
	Text(7,"1 Gem of Soul: Requires 600000 reputation points" ,MultiTrigger,GetMultiTrigger(),1)

	Talk(8,"Welcome to the Royal Pirates! Work harder to achieve your aim!") ]]

	InitTrigger()
	TriggerCondition( 1, HasRecord, 255 )
	TriggerCondition( 1, NoItem, 4072, 1 )
	TriggerCondition( 1, NoRecord, 242 )
	TriggerAction( 1, JumpPage, 2 )
	TriggerFailure( 1, JumpPage, 1 )

	Start( GetMultiTrigger(), 1 )
	MisListPage(2)
	-- AddNpcMission ( 268 )
	-- AddNpcMission ( 269 )
	-- AddNpcMission ( 288 )
	-- AddNpcMission ( 502 )
	-- AddNpcMission ( 334 )
	-- AddNpcMission ( 6081 )
end 

r_talk06 = nil
function r_talk06 ()
	Talk( 1, "Little Daniel: Young adventurers should not be afraid to explore the world. Have you been to the great shrine in the desert? How about the Lone Tower in the deep Sacred forest?" )
	Text( 1, "Purchase Corals", BuyPage )
	Text (1, "Reveal Robot Cores",JumpPage,2)
	Text( 1, "I do not have time for story now.", CloseTalk)
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 3933, 10 )
	TriggerCondition( 1, HasMoney, 5000 )
	TriggerAction( 1, TakeItem, 3933, 10 )
	TriggerAction( 1, TakeMoney, 5000 )
	TriggerAction( 1, GiveItem, 1812, 1, 4 )
	TriggerAction( 1, JumpPage, 3 )
	TriggerFailure( 1, JumpPage, 4 )
	Talk( 2, "Little Daniel: Oh my...I did not expect you to bring so many mechanical core. Bring me 10 Robot Core and 5000G so that I can make a Ancient Generator for you." )
	Text( 2, "Ok I will pay the (5000G) fee",  MultiTrigger, GetMultiTrigger(), 1 )
	Text( 2, "Let me consider", CloseTalk)

	Talk(3, "Little Daniel: Keep it well. This is the Ancient Generator that you will need to get inside Forsaken City. Come to me if you need more.")
	Talk(4, "Little Daniel: Sorry, you need to give me 10 Robot Cores and 5000G to make 1 Ancient Generator.")

	InitTrigger()
	TriggerCondition( 1, HasItem, 3933, 10 )
	TriggerCondition( 1, HasMoney, 5000 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerFailure( 1, JumpPage, 1 )
	Start( GetMultiTrigger(), 1 )

	InitTrade()
	Weapon(	0817	)
	Weapon(	0818	)
	Weapon(	0819	)
	Weapon(	0867	)
	Weapon(	0868	)
	Weapon(	0869	)
	Weapon(	0872	)
	Weapon(	0873	)
	Weapon(	0874	)
	Weapon(	0635	)
	Weapon(	0636	)
	Weapon(	0637	)

	 AddNpcMission ( 748 )
	AddNpcMission	(1045)
	AddNpcMission	(1099)
	AddNpcMission	(1157)
	AddNpcMission	(758)
	AddNpcMission	(103)
	AddNpcMission	(191)
	AddNpcMission	(192)
	AddNpcMission	(193)
	AddNpcMission	(197)
	AddNpcMission	(1225)
	AddNpcMission	(503)
	AddNpcMission	(330)
	AddNpcMission	(331)
	AddNpcMission	(332)
	AddNpcMission	(335)
	AddNpcMission	(359)
	AddNpcMission	(360)
	AddNpcMission	(361)
	AddNpcMission	(362)
	AddNpcMission	(363)
	AddNpcMission	(364)
	AddNpcMission	(365)
	AddNpcMission	(366)
	AddNpcMission	(367)
	AddNpcMission	(368)
	AddNpcMission	(369)
	AddNpcMission	(370)
	AddNpcMission	(371)
	AddNpcMission	(522)
	AddNpcMission	(5058)
	AddNpcMission	(5062)
	MisListPage(2)
end

function r_talk04 ()
	Talk( 1, "Gina: Hello! I am Nurse Gina. Look for me if you are sick or injured!" )

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 6 )
	TriggerCondition( 1, HasRecord, 500 )
	TriggerAction( 1, ReHp, 50 )
	TriggerCondition( 2, HasMoney, 50 )
	TriggerAction( 2, TakeMoney, 50 )
	TriggerAction( 2, ReHp,50 )
	TriggerFailure( 2, JumpPage, 3 )
	Text( 1, "Heal", MultiTrigger,GetMultiTrigger(),2)
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 6 )
	TriggerCondition( 1, HasRecord, 500 )
	TriggerAction( 1, ReAll )
	TriggerCondition( 2, HasMoney, 200 )
	TriggerAction( 2, TakeMoney, 200 )
	TriggerAction( 2, ReAll )
	TriggerFailure( 2, JumpPage, 2 )
	Text( 1, "Greater Heal", MultiTrigger,GetMultiTrigger(),2)

	Talk( 2, "Gina: Sorry, healing requires 200G. You do not have enough!" )
	Talk( 3, "Gina: Sorry! Healing requires 50G. You do not have enough!" )
	Talk( 4, "I do not have any letter. I guess you got the wrong person" )
	Talk( 5, "Ya? Forget it...Thank you. Take this reward for your hard work." )

	Talk( 6, "Gina: Hello! I am Nurse Gina. Look for me if you are sick or injured!" )
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 6 )
	TriggerCondition( 1, HasRecord, 500 )
	TriggerAction( 1, ReHp, 50 )
	TriggerCondition( 2, HasMoney, 50 )
	TriggerAction( 2, TakeMoney, 50 )
	TriggerAction( 2, ReHp,50 )
	TriggerFailure( 2, JumpPage, 3 )
	Text( 6, "Heal", MultiTrigger,GetMultiTrigger(),2)

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 6 )
	TriggerCondition( 1, HasRecord, 500 )
	TriggerAction( 1, ReAll )
	TriggerCondition( 2, HasMoney, 200 )
	TriggerAction( 2, TakeMoney, 200 )
	TriggerAction( 2, ReAll )
	TriggerFailure( 2, JumpPage, 2 )
	Text( 6, "Greater Heal", MultiTrigger,GetMultiTrigger(),2)

	InitTrigger()
	TriggerCondition( 1, HasMission, 53 )
	TriggerCondition( 1, HasFlag, 53, 1 )
	TriggerCondition( 1, NoRecord, 53 )
	TriggerCondition( 1, NoFlag, 53, 4 )
	TriggerCondition( 1, HasItem, 2304, 1 )
	TriggerAction( 1, JumpPage, 6 )
	TriggerFailure( 1, JumpPage, 1 )

	Start( GetMultiTrigger(), 1 )
	-- AddNpcMission	(1048)
	-- AddNpcMission	(1210)
	-- AddNpcMission	(920)
	-- AddNpcMission	(921)

	MisListPage(6)
	-- AddNpcMission ( 6117 )
	-- AddNpcMission ( 6118 )
	-- AddNpcMission ( 6119 )
	-- AddNpcMission ( 6120 )
end 

function r_talk24 ()
	Talk( 1, "Dessaro: Hi, I am the highest in command in Thundoria. Do you wish to join us?" )
	InitTrigger()
	TriggerCondition( 1, HasMoney, 1000000 )
	TriggerCondition( 1, HasItem, 1780, 1 )
	TriggerCondition( 1, NoGuild )
	TriggerAction( 1, CreateGuild, 0 )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Create a Navy Guild (fee: 1m)", MultiTrigger, GetMultiTrigger(), 1)

	Talk( 2, "Dessaro: To become a guild leader of the Navy Division, you will need to pay 1,000,000G and bring a Stone of Oath to prove your loyalty." )

	-- AddNpcMission	(566)
	-- AddNpcMission	(477)
	-- AddNpcMission	(478)
	-- AddNpcMission ( 6087 )
	-- AddNpcMission ( 6088 )
end 

function r_talk80 ()
	Talk( 1, "Mas: My family history runs as deep as Icicle Castle. Everybody here know and respected me." )
	Text( 1, "Regarding the legends of the Pirates",JumpPage, 2 )
	Text( 1, "Nothing...",CloseTalk )

	Talk( 2, "Mas: Hohoho...Pirates Crew? You wish to create one? That would have to depend on your ability." )
	InitTrigger()
	TriggerCondition( 1, HasMoney, 1000000 )
	TriggerCondition( 1, HasItem, 1780, 1 )
	TriggerAction( 1, CreateGuild, 1 )
	TriggerFailure( 1, JumpPage, 3 )
	Text( 2, "Create a Pirate Guild (fee: 1m)", MultiTrigger, GetMultiTrigger(), 1)

	Talk( 3, "Mas: To be the leader of the pirates is not an easy matter. Bring 1,000,000G and the Stone of Oath to prove your worth" )

	-- AddNpcMission 	(253)
	-- AddNpcMission 	(254)
	-- AddNpcMission 	(453)
	-- AddNpcMission 	(698)
	-- AddNpcMission 	(801)
	-- AddNpcMission	(1004)
	-- AddNpcMission	(1059)
	-- AddNpcMission	(1114)
	-- AddNpcMission	(1168)
	-- AddNpcMission	(317)
	-- AddNpcMission	(321)
	-- AddNpcMission	(322)
	-- AddNpcMission	(5045)
	-- AddNpcMission	(5046)
	-- AddNpcMission	(5047)
end




function mutaz2256107_1()

	Talk( 1, " Shirley: Hi! I am the Harbor Operator for Argent. I am in charge of all ships that is docked in this harbor. Look for me if you want to set sail." )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 1 )
	--TriggerAction( 1, RemoveYS )
	TriggerAction( 1, LuanchBerthList, 1, 2260,2829, 177 )
	TriggerFailure( 1, JumpPage, 3 )
	Text( 1, "Set sail", MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 1 )
	TriggerAction( 2, RepairBerthList, 1 )
	TriggerFailure( 2, JumpPage, 4 )
	Text( 1, "Repair Ship", MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 1 )
	TriggerAction( 2, SupplyBerthList, 1 )
	TriggerFailure( 2, JumpPage, 5 )
	Text( 1, "Refuel", MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 1 )
	TriggerAction( 1, SalvageBerthList, 1 )
	TriggerFailure( 1, JumpPage, 6 )
	Text( 1, "Salvage Ship", MultiTrigger, GetMultiTrigger(), 1 ) 

	Talk( 3, "Sorry, you do not have a ship at the harbor or it was sunken. Please salvage it before setting sail again!" )
	Talk( 4, "Sorry! I only repair ships docked in this harbor. Please pay 1000G." )
	Talk( 5, "Sorry, you need to dock your ship in our harbor in order to refuel. Please pay 200G" )
	Talk( 6, "Sorry! We only salvage ships docked in our harbor. You have to pay a fee of 1000G." )

	AddNpcMission ( 289 )
	AddNpcMission ( 290 )
-----------2.0冬岛日常任务-----------
	--AddNpcMission ( 6702 )
------------主线任务
	--AddNpcMission ( 6787 )
	--AddNpcMission ( 6788 )
	--AddNpcMission ( 6789 )
	--AddNpcMission ( 6790 )
	--AddNpcMission ( 6791 )
	--AddNpcMission ( 6792 )
	--

end












-- CreateBerthEntity( "Docked", 455, 2, 217565, 284424, 0, 1, 2170, 2828, 0 )
--[[function r_talk152()
	Talk( 1, " Shirley: Hi! I am the Harbor Operator for Argent. I am in charge of all ships that is docked in this harbor. Look for me if you want to set sail." )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 1 )
	TriggerAction( 1, LuanchBerthList, 1, 2184, 2849, 177 )
	TriggerFailure( 1, JumpPage, 3 )
	Text( 1, "Set sail", MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 1 )
	TriggerAction( 2, RepairBerthList, 1 )
	TriggerFailure( 2, JumpPage, 4 )
	Text( 1, "Repair Ship", MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 1 )
	TriggerAction( 2, SupplyBerthList, 1 )
	TriggerFailure( 2, JumpPage, 5 )
	Text( 1, "Refuel", MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 1 )
	TriggerAction( 1, SalvageBerthList, 1 )
	TriggerFailure( 1, JumpPage, 6 )
	Text( 1, "Salvage Ship", MultiTrigger, GetMultiTrigger(), 1 ) 

	Talk( 3, "Sorry, you do not have a ship at the harbor or it was sunken. Please salvage it before setting sail again!" )
	Talk( 4, "Sorry! I only repair ships docked in this harbor. Please pay 1000G." )
	Talk( 5, "Sorry, you need to dock your ship in our harbor in order to refuel. Please pay 200G" )
	Talk( 6, "Sorry! We only salvage ships docked in our harbor. You have to pay a fee of 1000G." )
	-- AddNpcMission ( 289 )
	-- AddNpcMission ( 290 )
end]]

function r_talk53 ()
	
	
	Talk( 1, "Smithy: Hi! I have a wide variety of weapons here! Free free to browse!" )
	Text( 1, "Trade", BuyPage )
	Text( 1, "Repair", OpenRepair )
	Text( 1, "Forge", OpenForge)
	Text( 1, "Socket Milling", OpenMilling)
	--Text( 1, "Apparel Fusion", OpenFusion)
	Text( 1, "Equipment Strengthening", OpenUpgrade)
	Text( 1, "Nothing...",CloseTalk )


	InitTrade()
	Weapon(	0196	)
	Weapon(	0197	)
	Weapon(	0198	)


	-- AddNpcMission ( 713 )
	-- AddNpcMission	(1043)
	-- AddNpcMission	(1095)
	-- AddNpcMission	(1154)
	-- AddNpcMission	(1206)
	-- AddNpcMission	(91)
	-- AddNpcMission	(92)
	-- AddNpcMission	(93)

end 

function mmm_talk04 ()
	Talk( 1, "Blacksmith's apprentice: If only I have my teacher's skills." )
	Text( 1, "Regarding Item Forging", JumpPage, 2 )
	Text( 1, "Regarding Composition", JumpPage, 3 )
	Text( 1, "Regarding Socket Milling", JumpPage, 7 )
	Text( 1, "Nothing...",CloseTalk )
	
	
	Talk( 2, "Blacksmith's Disciple: To forge any item, there is a huge fee to pay. You will need to have a Refining Gem that is of equal level to that of your item as a catalyst. Then you select the type of Gems to forge onto your item. Different type of Gems have different attribute added and item type restriction. The Gems also need to be of equal level to that of your item. Do you want to forge?" )
	Text( 2, "Regarding Refining Gem", JumpPage, 4)
	Text( 2, "Regarding Gem", JumpPage, 5)
	Text( 2, "Regarding Forging Success Rate", JumpPage, 6)
	
	Talk( 3, "Blacksmith Disciple: You wish to combine something? From what I understand, you need a combining scroll and it will list the required items. Collect the items needed and talk to Grocer - Amos in Shaitan City. He is the only person who knows how to combine." )
	
	Talk( 4, "Blacksmith Disciple: Refining Gems are a crucial catalyst in the forging of items. It must match the level of the item before it can be used. High level refining gems may be obtained from combining or killing monsters." )

	Talk( 5, "Blacksmith Disciple: There are a lof of gems for forging. Fire based attack gem, water based defense gem and sacred spiritual gem. High level gems can be obtained from combining or killing monsters." )

	Talk( 6, "Blacksmith's Disciple: Success rate gets lower as item level gets higher. Max level of item that can be forged is 27. Items will disappear if forging fails." )
	
	Talk( 7, "Blacksmith Disciple: For socket milling, you need to prepare 1 Equipment Stabilizer and 1 Equipment Catalyst in order to make a socket." )

end

function dina_talk08 () 
 	Talk (1, "Weird Hat Seller: I heard that the hat refining system is now opened. It seems that I have struck gold this time. Hey, you guys, take your tume to select the perfect hat for yourselves. No hurry." ) 
 	Text (1, "Trade", BuyPage) 

	InitTrade () 
	Weapon(	3908	)
	Weapon(	207	)
	Weapon(	208	)
	
	Defence(	3342	)
	Defence(	3047	)
	Defence(	3105	)
	Defence(	15006	)
	Defence(	3343	)
	Defence(	3344	)
	Defence(	1780	)
	
	Other (2553) 
	Other (2583) 
	Other (2584) 

 end 
 
 function x_heal01 ()
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 6 )
	TriggerCondition( 1, HasRecord, 500 )
	TriggerAction( 1, ReAll )
	TriggerCondition( 2, HasMoney, 200 )
	TriggerAction( 2, TakeMoney, 200 )
	TriggerAction( 2, ReAll )
	TriggerFailure( 2, JumpPage, 2 )

	Talk( 1, "Eva: Hello! I am Nurse Eva of Argent Bar. Find me, when all hope is lost!" )
	Text( 1, "Greater Heal", MultiTrigger,GetMultiTrigger(),2)

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 6 )
	TriggerCondition( 1, HasRecord, 500 )
	TriggerAction( 1, ReHp, 50 )
	TriggerCondition( 2, HasMoney, 50 )
	TriggerAction( 2, TakeMoney, 50 )
	TriggerAction( 2, ReHp,50 )
	TriggerFailure( 2, JumpPage, 3 )

	Talk( 2, "Eva: Sorry, Healing requires 200G. You do not have enough¡­" )
	Talk( 3, "Eva: Sorry! Healing requires 50G¡­You do not have enough¡­" )
end
 
function newmutaz332()

	Talk( 1, " Senna: Hi! I am in charge of helping all the new pirates on the city . Look for me if you want any help." )


	AddNpcMission(2000)
	AddNpcMission(2001)


end


function s_q1 ()
	Talk(1, "Pak: I may have some adventure for you soon")
	AddNpcMission(3721)
end

function s_q2 ()
	Talk(1, "David: I may have some adventure for you, check them below")
	Text(1, "Show me, Please",  SendExchangeXData)
	InitExchangeX()
	ExchangeDataX(	3903	,	250	,	18793	,	1	,	1)
	ExchangeDataX(	3903	,	35	,	4551	,	1	,	1)
	ExchangeDataX(	3903	,	35	,	4550	,	1	,	1)
	ExchangeDataX(	3903	,	35	,	4545	,	1	,	1)
	ExchangeDataX(	3903	,	35	,	4558	,	1	,	1)	
	ExchangeDataX(	3903	,	250	,	15965	,	1	,	1)	
	ExchangeDataX(	3903	,	99	,	18794	,	1	,	1)	
	ExchangeDataX(	3903	,	99	,	18795	,	1	,	1)
	ExchangeDataX(	3903	,	40	,	3088	,	1	,	1)	
	ExchangeDataX(	3903	,	50	,	3089	,	1	,	1)	
    ExchangeDataX(	3903	,	60	,	3090	,	1	,	1)	
	ExchangeDataX(	3903	,	70	,	3091	,	1	,	1)	
	ExchangeDataX(	3903	,	90	,	3092	,	1	,	1)	
	ExchangeDataX(	3903	,	100	,	3093	,	1	,	1)	
	ExchangeDataX(	3903	,	50	,	3096	,	1	,	1)	
	ExchangeDataX(	3903	,	150	,	0259	,	1	,	1)	
	ExchangeDataX(	3903	,	200	,	1780	,	1	,	1)	
	ExchangeDataX(	3903	,	10	,	1138	,	1	,	1)	
	ExchangeDataX(	3903	,	40	,	1145	,	1	,	1)	
	ExchangeDataX(	3903	,	60	,	2729	,	1	,	1)
	ExchangeDataX(	3903	,	60	,	2729	,	1	,	1)
	ExchangeDataX(	3903	,	50	,	18855	,	1	,	1)
	ExchangeDataX(	3903	,	50	,	18856	,	1	,	1)
	ExchangeDataX(	3903	,	30	,	18870	,	1	,	1)
	
	
end




function s_q21 ()
	Talk(1, "David: I may have some adventure for you soon")
--	AddNpcMission(3722)
	---AddNpcMission(3723)
	
end

--TODO
function s_q3 ()
end

function ash_woodstrip()
Talk( 1, "Hello, I will exchange your Ash Wood Strips with valueable items!")
Text( 1, "Check items", SendExchangeXData)
	InitExchangeX()

	ExchangeDataX(	3999	,	99	,	0227	,	99	,	1)
	ExchangeDataX(	3999	,	297	,	15882	,	1	,	1)
	ExchangeDataX(	3999	,	198	,	1020	,	1	,	1)
	ExchangeDataX(	3999	,	297	,	15745	,	1	,	1)
	ExchangeDataX(	3999	,	99	,	15744	,	1	,	1)	
end

function global_coins()
	Talk(1, "There's precious Coins scattered all around the world._If you find them I'll make sure_to have you properly rewarded!_You can find coins by killing some_monsters or opening treasure chests, go find them!")
	Text(1, "5 BHC => Random Sklv(10-20) Weapon", JumpPage, 2)
	Text(1, "5 BHC => Random Sklv(10-20) Torso", JumpPage, 3)
	Text(1, "5 BHC => Random Sklv(10-20) Gauntlets", JumpPage, 4)
	Text(1, "5 BHC => Random Sklv(10-20) Boots", JumpPage, 5)
	Text(1, "Hunter Coin Details", JumpPage, 10)
	Text(1, "Next Page -->",JumpPage, 11)
	Talk(11, "There's precious Coins scattered all around the world._If you find them I'll make sure_to have you properly rewarded!_You can find coins by killing some_monsters or opening treasure chests, go find them!")
	Text(11, "99 BHC => Random Sklv(10-60) Accessories", JumpPage, 6)
	Text(11, "99 SHC => Random Gem 2 Chest", JumpPage, 7)
	Text(11, "99 PHC => Random Lv90 Accessories", JumpPage, 8)
	Text(11, "99 PHC => Random Gem 3 Chest", JumpPage, 9)
	Text(11, "Hunter Coin Details", JumpPage, 10)
	Text(11, "<-- Previous Page", JumpPage, 1)

	InitTrigger()
	TriggerCondition( 1, HasItem,15829,5 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 15829,5 )
	TriggerAction( 1, GiveItem, 15890,1,4 )
	TriggerFailure( 1, JumpPage, 16)
	Text(2,"Exchange!" ,MultiTrigger,GetMultiTrigger(),1)
	
	InitTrigger()
	TriggerCondition( 1, HasItem,15829,5 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 15829,5 )
	TriggerAction( 1, GiveItem, 15887,1,4 )
	TriggerFailure( 1, JumpPage, 16)
	Text(3,"Exchange!" ,MultiTrigger,GetMultiTrigger(),1)	

	InitTrigger()
	TriggerCondition( 1, HasItem,15829,5 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 15829,5 )
	TriggerAction( 1, GiveItem, 15888,1,4 )
	TriggerFailure( 1, JumpPage, 16)
	Text(4,"Exchange!" ,MultiTrigger,GetMultiTrigger(),1)	
	
	InitTrigger()
	TriggerCondition( 1, HasItem,15829,5 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 15829,5 )
	TriggerAction( 1, GiveItem, 15889,1,4 )
	TriggerFailure( 1, JumpPage, 16)
	Text(5,"Exchange!" ,MultiTrigger,GetMultiTrigger(),1)
	
	InitTrigger()
	TriggerCondition( 1, HasItem,15829,99 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 15829,99 )
	TriggerAction( 1, GiveItem, 15886,1,4 )
	TriggerFailure( 1, JumpPage, 16)
	Text(6,"Exchange!" ,MultiTrigger,GetMultiTrigger(),1)
	
	InitTrigger()
	TriggerCondition( 1, HasItem,15830,99 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 15830,99 )
	TriggerAction( 1, GiveItem, 15883,1,4 )
	TriggerFailure( 1, JumpPage, 16)
	Text(7,"Exchange!" ,MultiTrigger,GetMultiTrigger(),1)
	
	InitTrigger()
	TriggerCondition( 1, HasItem,15832,99 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 15832,99 )
	TriggerAction( 1, GiveItem, 15885,1,4 )
	TriggerFailure( 1, JumpPage, 16)
	Text(8,"Exchange!" ,MultiTrigger,GetMultiTrigger(),1)
	
	InitTrigger()
	TriggerCondition( 1, HasItem,15832,99 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeItem, 15832,99 )
	TriggerAction( 1, GiveItem, 15884,1,4 )
	TriggerFailure( 1, JumpPage, 16)
	Text(9,"Exchange!" ,MultiTrigger,GetMultiTrigger(),1)
	Talk(10, "Hunter Coin Details:__BHC ==> Bronze Hunter Coin._SHC ==> Silver Hunter Coin._PHC ==> Platinum Hunter Coin.")
	Talk(16, "You do not have the required amount of coins for this exchange!")
end

function c_z1 ()
	Talk(1, "Janna: Hoho, you must be somebody to locate me. Hoho, what do you need?")
	Text( 1, "Buy.", BuyPage)

	InitTrade()
	Other(	0222	)
	Other(	0223	)
	Other(	0224	)
	Other(	0225	)
	Other(	0226	)

end