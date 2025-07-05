--[[
	Lua tradeserver implementation by Billy
	
	todo - 		
		VIP stuffs.
		Limited Duration
		Limited quantity >>> Done (mothannakh)
		quantity for each item inside the pack ---
]]

CMD_CM_STORE_OPEN_ASK = 41
CMD_CM_STORE_LIST_ASK = 42
CMD_CM_STORE_BUY_ASK = 43
CMD_CM_STORE_CHANGE_ASK	= 44
CMD_CM_STORE_QUERY = 45
CMD_CM_STORE_VIP = 46
CMD_CM_STORE_AFFICHE = 47
CMD_CM_STORE_CLOSE = 48

CMD_MC_STORE_OPEN_ASR = 561
CMD_MC_STORE_LIST_ASR = 562
CMD_MC_STORE_BUY_ASR = 563
CMD_MC_STORE_CHANGE_ASR = 564
CMD_MC_STORE_QUERY = 565
CMD_MC_STORE_VIP = 566

CMD_MC_UPDATEIMP = 611

PACK_PER_PAGE = 6

IGSUsers = IGSUsers or {}
IGSPacks = {}
IGSTabs = {}
IDStock = IDStock or {}	---Stock Tables 
function AddMallPack(title,description,price,hot,items,Quantity,stock)
	local index = #IGSPacks+1
	IGSPacks[index] = {
		Title = title,
		Description = description,
		Price = price,
		Hot = hot,
		Items = items,
		Quantity = Quantity,
		stock = stock,
	}
	return index
end

function AddMallTab(Title,Packs,Parent)
	Packs = Packs or {}
	local index = #IGSTabs+1
	IGSTabs[index] = {
		Title = Title,
		Packs = Packs,
		Parent = Parent or 0,
	}
	for i,v in pairs(Packs) do
		IGSPacks[v].Enabled = true
	end
	return index
end

function AddPackToTab(tab,item)
	IGSTabs[tab].Packs[#IGSTabs[tab].Packs+1] = IGSPacks[item]
	IGSPacks[item].Enabled = true
end

---		title			/description	/price/hot/items	/	qty/	limited stock----		
--Mall Points
 -- MallPoint1 = AddMallPack("Crystal Mall Point","Double click to get 1 Mall Point.",1	,	1,{	14985,	}, 1,		-1		)	 	
 -- MallPoint2 = AddMallPack("Crystal Mall Point","Double click to get 10 Mall Point.",10	,	1,{	14986,	}, 1,		-1		)    	
 -- MallPoint3 = AddMallPack("Crystal Mall Point","Double click to get 25 Mall Point.",25	,	1,{	14987,	}, 1,		-1		)
 -- MallPoint4 = AddMallPack("Crystal Mall Point","Double click to get 50 Mall Point.",50	,	1,{	14988,	}, 1,		-1		)	
 -- MallPoint5 = AddMallPack("Crystal Mall Point","Double click to get 100 Mall Point.",100	,	1,{	14989,	}, 1,		-1 		)
 -- MallPoint6 = AddMallPack("Crystal Mall Point","Double click to get 250 Mall Point.",250	,	1,{	14990,	}, 1 ,		-1		)
 -- MallPoint7 = AddMallPack("Crystal Mall Point","Double click to get 500 Mall Point.",500	,	1,{	14991,	}, 1,	-1		)
 -- MallPoint8 = AddMallPack("Crystal Mall Point","Double click to get 1000 Mall Point.",1000	,	1,{	14992,	}, 1,	-1		)
--Apparels
--Weapons
--[[ Apps1 = AddMallPack("Sword of Azure Flame","Apparel",29	,	1,{	5001,	}, 1,		-1		)	 	
 Apps2 = AddMallPack("Sword of Crimson Thunder","Apparel",29	,	1,{	5002,	}, 1,		-1		)    	
 Apps3 = AddMallPack("Great Hammer of Zest","Apparel",39	,	1,{	5003,	}, 1,		-1		)
 Apps4 = AddMallPack("Blade of the Frozen Crescent","Apparel",39	,	1,{	5004,	}, 1,		-1		)	
 Apps5 = AddMallPack("Vinyon","Apparel",39	,	1,{	5005,	}, 1,		-1 		)
 Apps6 = AddMallPack("Rattle Drum of the Burning Crescent","Apparel",39	,	1,{	5006,	}, 1 ,		-1		)
 Apps7 = AddMallPack("Sword of Crimson Flame","Apparel",29	,	1,{	5007,	}, 1,	-1		)
 Apps8 = AddMallPack("Sword of Azure Thunder","Apparel",29	,	1,{	5008,	}, 1,	-1		)
 Apps9 = AddMallPack("Great Hammer of Hone","Apparel",39	,	1,{	5009,	}, 1,		-1		)	 	
 Apps10 = AddMallPack("Blade of Burning Crescent","Apparel",39	,	1,{	5010,	}, 1,		-1		)    	
 Apps11 = AddMallPack("Victorian","Apparel",39	,	1,{	5011,	}, 1,		-1		)
 Apps12 = AddMallPack("Rattle Drum of the Frozen Crescent","Apparel",39	,	1,{	5012,	}, 1,		-1		)	
 Apps13 = AddMallPack("Foldable Chair","Apparel",35	,	1,{	5276,	}, 1,		-1 		)
 Apps14 = AddMallPack("Langa's Cleaning Brush","Apparel",69	,	1,{	5277,	}, 1 ,		-1		)
 Apps15 = AddMallPack("Branch of Defecate","Apparel",69	,	1,{	5278,	}, 1,	-1		)
 Apps16 = AddMallPack("Soup Spoon","Apparel",49	,	1,{	5280,	}, 1,	-1		)
 Apps17 = AddMallPack("Pseudo Air Cannon","Apparel",39	,	1,{	5281,	}, 1,		-1		)	 	
 Apps18 = AddMallPack("Oriental Mystic Chopsticks","Apparel",39	,	1,{	5282,	}, 1,		-1		)   
 Apps19 = AddMallPack("Barborosa's Knife","Apparel",75	,	1,{	5283,	}, 1,		-1		)
 Apps20 = AddMallPack("Barborosa's Fork","Apparel",75	,	1,{	5284,	}, 1,		-1		)	
 Apps21 = AddMallPack("Matchstick Granny's Pan","Apparel",55	,	1,{	5285,	}, 1,		-1 		)
 Apps22 = AddMallPack("Goddess of Vengence","Apparel",49	,	1,{	5279,	}, 1 ,		-1		)
 Apps23 = AddMallPack("Fine Crossbow","Apparel",39	,	1,{	5286,	}, 1 ,		-1		)]]--
  Apps24 = AddMallPack("Helios Sword","Apparel",99	,	1,{	9560,	}, 1,	-1		)
  Apps25 = AddMallPack("Ocean Wind","Apparel",99	,	1,{	9561,	}, 1,		-1		)	 	
  Apps26 = AddMallPack("Grand Shotgun","Apparel",119	,	1,{	9562,	}, 1,		-1		)    	
  Apps27 = AddMallPack("Devastator","Apparel",119	,	1,{	9563,	}, 1,		-1		)
  Apps28 = AddMallPack("Pyrocitor","Apparel",209	,	1,{	9564,	}, 1,		-1		)	
  Apps29 = AddMallPack("Heilig Bogen","Apparel",209	,	1,{	9565,	}, 1,		-1 		)
  Apps30 = AddMallPack("Wyvern Bow","Apparel",299	,	1,{	9566,	}, 1 ,		-1		)
  Apps31 = AddMallPack("God of Thunder","Apparel",99	,	1,{	9567,	}, 1,	-1		)
  Apps32 = AddMallPack("Dagger of Souls","Apparel",139	,	1,{	9568,	}, 1,	-1		)
  Apps33 = AddMallPack("Twin Fin","Apparel",109	,	1,{	9569,	}, 1,		-1		)
  Apps34 = AddMallPack("Brass Asperity","Apparel",109	,	1,{	9570,	}, 1,		-1		)	
  Apps35 = AddMallPack("Warden of the Sun","Apparel",179	,	1,{	9572,	}, 1,		-1 		)
  Apps36 = AddMallPack("Sumptuous Staff","Apparel",259	,	1,{	9573,	}, 1 ,		-1		)
  Apps37 = AddMallPack("Infinity Staff","Apparel",149	,	1,{	9574,	}, 1,	-1		)
  Apps38 = AddMallPack("Hyperion Shield","Apparel",329	,	1,{	9575,	}, 1,	-1		)
  Apps39 = AddMallPack("Nightbringer Shield","Apparel",329	,	1,{	9576,	}, 1,		-1 		)
  Apps40 = AddMallPack("Donut Staff","Apparel",199	,	1,{	9571,	}, 1,	-1		)
  Apps41 = AddMallPack("Chocolate Cake Staff","Apparel",259	,	1,{	9577,	}, 1,	-1		)
  Apps42 = AddMallPack("Chocolate Cleaver","Apparel",259	,	1,{	9578,	}, 1,	-1		)
 -- Apps43 = AddMallPack("Katana","Apparel",155	,	1,{	5019,	}, 1,	-1		)
 -- Apps44 = AddMallPack("Aurora Blade","Apparel",109	,	1,{	5084,	}, 1,	-1		)
 -- Apps45 = AddMallPack("Divinity Blade","Apparel",99	,	1,{	5085,	}, 1,	-1		) 
 -- Apps46 = AddMallPack("August Sword 1","Apparel",109	,	1,{	5024,	}, 1,	-1		) 
 -- Apps47 = AddMallPack("August Sword 2","Apparel",109	,	1,{	5029,	}, 1,	-1		) 
 -- Apps48 = AddMallPack("Holy Ice Sword Apparel","Apparel",149	,	1,{	5087,	}, 1,	-1		) 
 -- Apps49 = AddMallPack("Battle Smallsword Apparel","Apparel",179	,	1,{	5092,	}, 1,	-1		) 
 -- Apps50 = AddMallPack("August Firegun 1","Apparel",105	,	1,{	5026,	}, 1,	-1		) 
 -- Apps51 = AddMallPack("August Firegun 2","Apparel",105	,	1,{	5031,	}, 1,	-1		) 
 -- Apps52 = AddMallPack("Battle Gun Apparel","Apparel",185	,	1,{	5095,	}, 1,	-1		) 
 -- Apps53 = AddMallPack("Wing Bow Apparel","Apparel",155	,	1,{	5088,	}, 1,	-1		) 
 -- Apps54 = AddMallPack("Dagger of Cadaver","Apparel",99	,	1,{	5016,	}, 1,	-1		) 
 -- Apps55 = AddMallPack("August Dagger 1","Apparel",105	,	1,{	5028,	}, 1,	-1		)  
 -- Apps56 = AddMallPack("August Dagger 2","Apparel",105	,	1,{	5033,	}, 1,	-1		) 
 -- Apps57 = AddMallPack("Green Jade Blade Apparel","Apparel",155	,	1,{	5089,	}, 1,	-1		) 
 -- Apps58 = AddMallPack("Greatsword of Cadaver","Apparel",99	,	1,{	5013,	}, 1,	-1		) 
 -- Apps59 = AddMallPack("August Greataxe 1","Apparel",110	,	1,{	5025,	}, 1,	-1		) 
 -- Apps60 = AddMallPack("August Greataxe 2","Apparel",110	,	1,{	5030,	}, 1,	-1		) 
 -- Apps61 = AddMallPack("Soul Stealing Sword Apparel","Apparel",160	,	1,{	5090,	}, 1,	-1		) 
 -- Apps62 = AddMallPack("Battle Epee Apparel","Apparel",195	,	1,{	5097,	}, 1,	-1		) 
 -- Apps63 = AddMallPack("Louis Vuitton AK-47","Apparel",140	,	1,{	6600,	}, 1,	-1		) 
 -- Apps64 = AddMallPack("Orenji Bow","Apparel",130	,	1,{	6601,	}, 1,	-1		) 
 -- Apps65 = AddMallPack("2x Sword of Red Dawn","Apparel",140	,	1,{	6602,	}, 2,	-1		) 
 -- Apps66 = AddMallPack("AK-47","Apparel",125	,	1,{	6603,	}, 1,	-1		) 
 -- Apps67 = AddMallPack("Spear Dagger","Apparel",135	,	1,{	6604,	}, 1,	-1		) 
 -- Apps68 = AddMallPack("Demon Staff","Apparel",140	,	1,{	6605,	}, 1,	-1		) 
 -- Apps69 = AddMallPack("Rage Sword","Apparel",180	,	1,{	6616,	}, 2,	-1		) 
 -- Apps70 = AddMallPack("Thrust Sword","Apparel",180	,	1,{	6617,	}, 2,	-1		) 
 -- Apps71 = AddMallPack("Edgar Hammer","Apparel",175	,	1,{	6620,	}, 1,	-1		) 
 -- Apps72 = AddMallPack("Javi Dagger","Apparel",175	,	1,{	6622,	}, 1,	-1		) 
 -- Apps73 = AddMallPack("Javi Staff","Apparel",175	,	1,{	6623,	}, 1,	-1		) 
 -- Apps74 = AddMallPack("Javi Witch Staff","Apparel",175	,	1,{	6638,	}, 1,	-1		) 
 -- Apps75 = AddMallPack("Dirty Sword","Apparel",200	,	1,{	6653,	}, 2,	-1		) 
 -- Apps76 = AddMallPack("Ancelmos Sword","Apparel",200	,	1,{	6666,	}, 2,	-1		) 
 -- Apps77 = AddMallPack("Evil Dagger","Apparel",200	,	1,{	6671,	}, 1,	-1		) 
 -- Apps78 = AddMallPack("Snow Staff","Apparel",210	,	1,{	6682,	}, 1,	-1		) 
 -- Apps79 = AddMallPack("Tron Bow","Apparel",200	,	1,{	6684,	}, 1,	-1		) 
 -- Apps80 = AddMallPack("Christ AK47 Gun","Apparel",230	,	1,{	6686,	}, 1,	-1		) 
 -- Apps81 = AddMallPack("War Dagger","Apparel",180	,	1,{	9625,	}, 1,	-1		) 
 -- Apps82 = AddMallPack("Bluebird Bow","Apparel",200	,	1,{	9629,	}, 1,	-1		) 
 -- Apps83 = AddMallPack("Rock and Roll gun","Apparel",200	,	1,{	9630,	}, 1,	-1		) 
 -- Apps84 = AddMallPack("Sharmoota Swords","Apparel",200	,	1,{	9634,	}, 2,	-1		) 
 -- Apps85 = AddMallPack("iTrouble Axes","Apparel",200	,	1,{	9635,	}, 2,	-1		) 
 -- Apps86 = AddMallPack("Jess Stab","Apparel",210	,	1,{	9637,	}, 2,	-1		) 
 -- Apps87 = AddMallPack("B.D.J.E.S.S.G.U.N","Apparel",180	,	1,{	9638,	}, 1,	-1		) 
 -- Apps88 = AddMallPack("What Axes","Apparel",220	,	1,{	9641,	}, 2,	-1		) 
 -- Apps89 = AddMallPack("When Axes","Apparel",220	,	1,{	9642,	}, 2,	-1		) 
 -- Apps90 = AddMallPack("Unruly Reavers","Apparel",200	,	1,{	9646,	}, 2,	-1		) 
 -- Apps91 = AddMallPack("United Bow","Apparel",210	,	1,{	9647,	}, 1,	-1		) 
 -- Apps92 = AddMallPack("United Staff","Apparel",190	,	1,{	9648,	}, 1,	-1		) 
 -- Apps93 = AddMallPack("United Swords","Apparel",200	,	1,{	9649,	}, 2,	-1		) 
 -- Apps94 = AddMallPack("White Unseal Sword","Apparel",230	,	1,{	9651,	}, 2,	-1		) 
 -- Apps95 = AddMallPack("Yuna White Staff","Apparel",200	,	1,{	9652,	}, 1,	-1		) 
 -- Apps96 = AddMallPack("Unruly Ak","Apparel",200	,	1,{	9654,	}, 1,	-1		) 
 -- Apps97 = AddMallPack("CarpetsLove Sword","Apparel",200	,	1,{	9663,	}, 2,	-1		) 
 -- Apps98 = AddMallPack("CarpetsLove Hammer","Apparel",190	,	1,{	9664,	}, 1,	-1		) 
 -- Apps99 = AddMallPack("7Skiez Sword","Apparel",200	,	1,{	9667,	}, 2,	-1		) 
 -- AppsWe100 = AddMallPack("Kims Bloody Blade","Apparel",200	,	1,{	9674,	}, 2,	-1		) 
 -- AppsWe101 = AddMallPack("Kims Bloody Bow","Apparel",200	,	1,{	9675,	}, 1,	-1		) 
 -- AppsWe102 = AddMallPack("Hektors Sword","Apparel",200	,	1,{	9684,	}, 2,	-1		) 
 -- AppsWe103 = AddMallPack("Hektors Hammer","Apparel",200	,	1,{	9685,	}, 1,	-1		) 
 -- AppsWe104 = AddMallPack("Kims Enormous Dagger","Apparel",170	,	1,{	9692,	}, 1,	-1		) 
 -- AppsWe105 = AddMallPack("Zamudio Gun","Apparel",180	,	1,{	9693,	}, 1,	-1		) 
 -- AppsWe106 = AddMallPack("Perz 7Dsin Swords","Apparel",200	,	1,{	9695,	}, 2,	-1		) 
 -- AppsWe107 = AddMallPack("Nitros Golden Ak-47","Apparel",220	,	1,{	9697,	}, 1,	-1		) 
 -- AppsWe108 = AddMallPack("Nitros Golden Bow","Apparel",220	,	1,{	9698,	}, 1,	-1		) 
 -- AppsWe109 = AddMallPack("Hugin Swords","Apparel",200	,	1,{	9708,	}, 2,	-1		) 
 -- AppsWe110 = AddMallPack("SNOW Staff","Apparel",175	,	1,{	9717,	}, 1,	-1		) 
 -- AppsWe111 = AddMallPack("The Joker Sword","Apparel",185	,	1,{	9720,	}, 2,	-1		) 
 -- AppsWe112 = AddMallPack("sSputnik Dagger","Apparel",185	,	1,{	9721,	}, 1,	-1		) 
 -- AppsWe113 = AddMallPack("sSputnik Gun","Apparel",185	,	1,{	9722,	}, 1,	-1		) 
 -- AppsWe114 = AddMallPack("Atrox X BoW","Apparel",190	,	1,{	9723,	}, 1,	-1		) 
 -- AppsWe115 = AddMallPack("Patricks Swords","Apparel",205	,	1,{	9739,	}, 2,	-1		) 
 -- AppsWe116 = AddMallPack("sSputnik Gun 2","Apparel",205	,	1,{	9741,	}, 1,	-1		) 
 -- AppsWe117 = AddMallPack("AK-Valhalla Gun","Apparel",205	,	1,{	9742,	}, 1,	-1		) 
 -- AppsWe118 = AddMallPack("Edgar Dark Gun","Apparel",180	,	1,{	9744,	}, 1,	-1		) 
 -- AppsWe119 = AddMallPack("Edgar Dark Bow","Apparel",180	,	1,{	9745,	}, 1,	-1		) 
 -- AppsWe120 = AddMallPack("H.A.R.D.I.N.S.M.I.G.H.T","Apparel",180	,	1,{	9746,	}, 2,	-1		) 
 -- AppsWe121 = AddMallPack("E.U.T.D.A.G.G.E.R","Apparel",180	,	1,{	9747,	}, 1,	-1		) 
 -- AppsWe122 = AddMallPack("Z.H.E.N.D.A.G.G.E.R","Apparel",180	,	1,{	9748,	}, 1,	-1		) 
 -- AppsWe123 = AddMallPack("Venom666 Sword","Apparel",200	,	1,{	9754,	}, 2,	-1		) 

--Sets
--[[ Apps100 = AddMallPack("Caribbean Set","Apparel",95	,	1,{	5589,5590,5591,5592,	}, 1,		-1 		)
 Apps101 = AddMallPack("Bloodmoon Set","Apparel",85	,	1,{	5597,5598,5599,5600,	}, 1,		-1 		)
 Apps102 = AddMallPack("Wild West Set","Apparel",85	,	1,{	5601,5602,5603,5604,	}, 1,		-1 		)
 Apps103 = AddMallPack("Ninja Set","Apparel",189	,	1,{	5662,5663,5664,5665,	}, 1,		-1 		)
 Apps104 = AddMallPack("Azrael Set","Apparel",120	,	1,{	5577,5578,5579,5580,	}, 1,		-1 		)
 Apps105 = AddMallPack("Catacomb Set","Apparel",85	,	1,{	5369,5370,5371,	}, 1,		-1 		)
 Apps106 = AddMallPack("Piggy Set","Apparel",69	,	1,{	5521,5522,5523,5524,	}, 1,		-1 		)
 Apps107 = AddMallPack("Buccaneer Set","Apparel",89	,	1,{	5373,5374,5375,	}, 1,		-1 		)
 Apps108 = AddMallPack("Royal Major Set","Apparel",105	,	1,{	5485,5486,5487,5488,	}, 1,		-1 		)
 Apps109 = AddMallPack("Wedding Robe Set","Apparel",115	,	1,{	5492,5493,5494,5495,	}, 1,		-1 		)
 Apps110 = AddMallPack("Hacker Set","Apparel",135	,	1,{	5573,5574,5575,5576,	}, 1,		-1 		)
 Apps111 = AddMallPack("Kylinkin Set","Apparel",149	,	1,{	5566,5567,5568,	}, 1,		-1 		)
 Apps112 = AddMallPack("Leech Set","Apparel",120	,	1,{	5569,5570,5571,5572,	}, 1,		-1 		)
 Apps113 = AddMallPack("Fortune Set","Apparel",159	,	1,{	5514,5515,5516,5517,	}, 1,		-1 		)
 Apps114 = AddMallPack("Romantic Set","Apparel",109	,	1,{	5518,5519,5520,	}, 1,		-1 		)
 Apps115 = AddMallPack("Aries Set","Apparel",125	,	1,{	5525,5526,5527,5528,	}, 1,		-1 		)
 Apps116 = AddMallPack("Taurus Set","Apparel",135	,	1,{	5529,5530,5531,5532,	}, 1,		-1 		)
 Apps117 = AddMallPack("Gemini Set","Apparel",135	,	1,{	5533,5534,5535,5536,	}, 1,		-1 		)
 Apps118 = AddMallPack("Street Love Set","Apparel",159	,	1,{	5537,5538,5539,5540,	}, 1,		-1 		)
 Apps119 = AddMallPack("Baccalaureate Set","Apparel",119	,	1,{	5541,5542,5543,	}, 1,		-1 		)
 Apps120 = AddMallPack("Big Crab's Rebellion Set","Apparel",115	,	1,{	5553,5554,5555,5556,	}, 1,		-1 		)]]--
 -- Apps121 = AddMallPack("Wanderer's Set","Apparel",125	,	1,{	5605,5606,5607,5608,	}, 1,		-1 		)
-- Apps122 = AddMallPack("Battle King's Set","Apparel",135	,	1,{	5609,5610,5611,5612,	}, 1,		-1 		)
-- Apps123 = AddMallPack("Teddy-Bear Set","Apparel",159	,	1,{	5613,5614,5615,5616,	}, 1,		-1 		)
 -- Apps124 = AddMallPack("Iron Man Set","Apparel",185	,	1,{	5641,5642,5643,5644,	}, 1,		-1 		)
 -- Apps125 = AddMallPack("Power Ranger Set","Apparel",179	,	1,{	5645,5646,5647,5648,	}, 1,		-1 		)
 -- Apps126 = AddMallPack("Martial Artist Set","Apparel",155	,	1,{	5649,5650,5651,5652,	}, 1,		-1 		)
 -- Apps127 = AddMallPack("Bannana Set","Apparel",105	,	1,{	5653,5654,5655,5656,	}, 1,		-1 		)
 -- Apps128 = AddMallPack("Hawaiian Set","Apparel",199	,	1,{	5666,5667,5668,5669,	}, 1,		-1 		)
 -- Apps129 = AddMallPack("Magic Woods Set","Apparel",219	,	1,{	5670,5671,5672,5673,	}, 1,		-1 		)
 -- Apps130 = AddMallPack("Lucky Bull's Set","Apparel",135	,	1,{	5674,5675,5676,5677,	}, 1,		-1 		)
-- Apps131 = AddMallPack("Demon's Set","Apparel",179	,	1,{	5678,5679,5680,5681,	}, 1,		-1 		)
 -- Apps132 = AddMallPack("Skyline Postman Set","Apparel",279	,	1,{	5751,5752,5753,5754,	}, 1,		-1 		)
 -- Apps133 = AddMallPack("Wise Set","Apparel",299	,	1,{	5759,5760,5761,	}, 1,		-1 		)
 -- Apps134 = AddMallPack("Gladiator Set","Apparel",239	,	1,{	5780,5781,5782,5783,	}, 1,		-1 		)
-- Apps135 = AddMallPack("Funny Bunny Set","Apparel",275	,	1,{	5776,5777,5778,5779,	}, 1,		-1 		)
-- Apps136 = AddMallPack("Bruce Tights Set","Apparel",135	,	1,{	5500,5501,5502,	}, 1,		-1 		)
-- Apps137 = AddMallPack("New Year's Set","Apparel",139	,	1,{	5593,5594,5595,5596,	}, 1,		-1 		)   
-- Apps138 = AddMallPack("Ninja Suit Set","Apparel",159	,	1,{	5585,5586,5587,5588,	}, 1,		-1 		)    
 -- Apps139 = AddMallPack("Baccalaureate Set","Apparel",129	,	1,{	5541,5542,5543,	}, 1,		-1 		)  
-- Apps140 = AddMallPack("Romantic Pas Set","Apparel",159	,	1,{	5547,5548,5549,	}, 1,		-1 		)  
 -- Apps141 = AddMallPack("Night Deity Set","Apparel",139	,	1,{	5551,5552,	}, 1,		-1 		)   
 -- Apps142 = AddMallPack("Christmas Set","Apparel",135	,	1,{	5511,5512,5513,	}, 1,		-1 		)  
-- Apps143 = AddMallPack("Priest Set","Apparel",119	,	1,{	5496,5497,5498,	}, 1,		-1 		)  
 -- Apps144 = AddMallPack("Capricious Dragon Set","Apparel",139	,	1,{	5453,5454,5455,	}, 1,		-1 		)   
-- Apps145 = AddMallPack("Ember Set","Apparel",129	,	1,{	5456,5457,5458,	}, 1,		-1 		)  
-- Apps146 = AddMallPack("Kylinkin Set","Apparel",135	,	1,{	5565,5566,5567,5568,	}, 1,		-1 		) 
 -- Apps147 = AddMallPack("Black Dragonkin Set","Apparel",135	,	1,{	5561,5562,5563,5564,	}, 1,		-1 		) 
-- Apps148 = AddMallPack("Country Set","Apparel",135	,	1,{	5344,5352,5360,5365,	}, 1,		-1 		) 
 -- Apps149 = AddMallPack("Kingdom Set","Apparel",190	,	1,{	6518,6519,6520,6521,	}, 1,		-1 		) 
 -- Apps150 = AddMallPack("Black Panther Set","Apparel",170	,	1,{	6522,6523,6524,6525,	}, 1,		-1 		) 
 -- Apps151 = AddMallPack("Deadpool Set","Apparel",180	,	1,{	6526,6527,6528,6529,	}, 1,		-1 		) 
 
--Different Classes
  Apps300 = AddMallPack("Gamora Set","Phyllis Apparel",149	,	1,{	9579,9580,9581,	}, 1,		-1 		)
 -- Apps301 = AddMallPack("Snow Bunny Set","Ami Apparel",145	,	1,{	9582,9583,9584,9585,	}, 1,		-1 		)
 -- Apps302 = AddMallPack("Little Lady Set","Phyllis Apparel",165	,	1,{	9586,9587,9588,9589,	}, 1,		-1 		)
 -- Apps303 = AddMallPack("Merchant Set","Phyllis Apparel",175	,	1,{	9590,9591,9592,9593,	}, 1,		-1 		)
 -- Apps304 = AddMallPack("Traveling Witch Set","Ami Apparel",170	,	1,{	9594,9595,9596,9597,	}, 1,		-1 		)
-- Apps305 = AddMallPack("Ami Xian Set","Ami Apparel",175	,	1,{	9598,9599,9600,9601,	}, 1,		-1 		)
 -- Apps306 = AddMallPack("Fairy Maid Set","Phyllis Apparel",220	,	1,{	9602,9603,9604,9605,	}, 1,		-1 		)
 -- Apps307 = AddMallPack("Lance Xian Set","Lance Apparel",175	,	1,{	9606,9607,9608,9609,	}, 1,		-1 		)
-- Apps308 = AddMallPack("Phyllis Xian Set","Phyllis Apparel",175	,	1,{	9610,9611,9612,9613,	}, 1,		-1 		)
 -- Apps309 = AddMallPack("Lance Business Set","Lance Apparel",215	,	1,{	9614,9615,9616,9617,	}, 1,		-1 		)
 -- Apps310 = AddMallPack("Phyllis Business Set","Phyllis Apparel",215	,	1,{	9618,9619,9620,9621,	}, 1,		-1 		)
 -- Apps311 = AddMallPack("Superman Set","L/C Apparel",170	,	1,{	5581,5582,5583,5584,	}, 1,		-1 		)
 -- Apps312 = AddMallPack("Chibi Set","Ami Apparel",155	,	1,{	5507,5508,5509,5510,	}, 1,		-1 		)
 -- Apps313 = AddMallPack("Marshal Set","Lance Apparel",199	,	1,{	5617,5618,5619,5620,	}, 1,		-1 		)
 -- Apps314 = AddMallPack("Templar's Set","Lance Apparel",179	,	1,{	5686,5687,5688,	}, 1,		-1 		) 
 -- Apps315 = AddMallPack("Tiger Cavalry Set","L/P Apparel",135	,	1,{	5450,5451,5452,	}, 1,		-1 		)  
 -- Apps316 = AddMallPack("Brutal Chef Set","Lance Apparel",155	,	1,{	5423,5424,5425,	}, 1,		-1 		)  
-- Apps317 = AddMallPack("Tri-Blader Set","L/P Apparel",160	,	1,{	5419,5420,5421,	}, 1,		-1 		)  
-- Apps318 = AddMallPack("Straw Set","Lance Apparel",179	,	1,{	5414,5415,5416,5417,	}, 1,		-1 		) 
-- Apps319 = AddMallPack("Warrior Frock Set","L/P Apparel",145	,	1,{	5381,5382,5383,	}, 1,		-1 		)  
 -- Apps320 = AddMallPack("Leather Set","Lance Apparel",135	,	1,{	5378,5379,5380,	}, 1,		-1 		)  
-- Apps321 = AddMallPack("Frozen Heart Set","Lance Apparel",160	,	1,{	5345,5353,5361,	}, 1,		-1 		)  
-- Apps322 = AddMallPack("Chilling Heart Set","Lance Apparel",160	,	1,{	5341,5349,5357,	}, 1,		-1 		)  
 -- Apps323 = AddMallPack("Shaitan Princess Set","Lance Apparel",160	,	1,{	5442,5443,5444,5445,	}, 1,		-1 		) 
 -- Apps324 = AddMallPack("Sexy Coat Set","Phyllis Apparel",110	,	1,{	5447,5448,5449,	}, 1,		-1 		) 
-- Apps325 = AddMallPack("Dainty Doll Set","Phyllis Apparel",100	,	1,{	5438,5439,5440,5441,	}, 1,		-1 		) 
 -- Apps326 = AddMallPack("Aliya Mini Set","Ami Apparel",110	,	1,{	5465,5466,5467,	}, 1,		-1 		) 
-- Apps327 = AddMallPack("Dainty Doll Set","Ami Apparel",100	,	1,{	5473,5474,5475,5476,	}, 1,		-1 		) 
-- Apps328 = AddMallPack("Carsise Torso Set","Carsise Apparel",110	,	1,{	5459,5460,5461,	}, 1,		-1 		) 
 -- Apps330 = AddMallPack("Student Gown Set","Phyllis Apparel",100	,	1,{	5544,5545,5546,	}, 1,		-1 		) 
 -- Apps331 = AddMallPack("Mario Set","L/C/P Apparel",135	,	1,{	5637,5638,5639,	}, 1,		-1 		) 
 -- Apps332 = AddMallPack("Super Hero Set","L/C/P Apparel",135	,	1,{	5633,5634,5635,5636,	}, 1,		-1 		) 
 -- Apps333 = AddMallPack("Blue Spirit Set","Ami Apparel",125	,	1,{	5693,5694,5695,5696,	}, 1,		-1 		) 
 -- Apps334 = AddMallPack("Jedi Set","Phyllis Ami Apparel",120	,	1,{	5697,5698,5699,5700,	}, 1,		-1 		) 
 -- Apps335 = AddMallPack("Kimono Set","Phyllis Ami Apparel",115	,	1,{	5701,5702,5703,5704,	}, 1,		-1 		) 
 -- Apps336 = AddMallPack("Little Ninja Set","Ami Apparel",130	,	1,{	5689,5690,5691,5692,	}, 1,		-1 		) 
 -- Apps337 = AddMallPack("Aladdin Set","Carsise Apparel",100	,	1,{	5715,5716,5717,5718,	}, 1,		-1 		) 
 -- Apps338 = AddMallPack("Darth Maul Set","Lance Apparel",150	,	1,{	5772,5773,5774,5775,	}, 1,		-1 		) 
 -- Apps339 = AddMallPack("Spider Man Set","L/C Apparel",140	,	1,{	5768,5769,5770,5771,	}, 1,		-1 		) 
 -- Apps340 = AddMallPack("Nancys Set","Phyllis Apparel",130	,	1,{	5762,5763,5764,	}, 1,		-1 		) 
 -- Apps341 = AddMallPack("Track Set","Lance Apparel",135	,	1,{	5755,5756,5757,5758,	}, 1,		-1 		) 
 -- Apps342 = AddMallPack("Orfeu Lira Set","L/P Apparel",155	,	1,{	5741,5742,5743,5744,	}, 1,		-1 		) 
 -- Apps343 = AddMallPack("Fashion Set","Phyllis Apparel",150	,	1,{	5745,5746,5747,	}, 1,		-1 		) 
 -- Apps344 = AddMallPack("Red Playboy Set","Phyllis Apparel",150	,	1,{	5723,5724,5725,5726,	}, 1,		-1 		) 
 -- Apps345 = AddMallPack("Xmas Bunnygirl Set","P/A Apparel",125	,	1,{	5719,5720,5721,5722,	}, 1,		-1 		) 
-- Apps346 = AddMallPack("Dynamic Set","Lance Carsise Phyllis Apparel",120	,	1,{	5489,5490,	}, 1,		-1 		) 
 -- Apps347 = AddMallPack("Brown Set","Lance Apparel",145	,	1,{	6500,6501,6502,	}, 1,		-1 		) 
  Apps348 = AddMallPack("Blue Naruto Set","Lance Apparel",165	,	1,{	6503,6504,6505,6506,	}, 1,		-1 		) 
  Apps349 = AddMallPack("Blue BD Set","Lance Apparel",165	,	1,{	6507,6508,6509,	}, 1,		-1 		) 
  Apps350 = AddMallPack("Bukai Set","Carsise Apparel",155	,	1,{	6510,6511,6512,6513,	}, 1,		-1 		) 
  Apps351 = AddMallPack("O.P ACE Set","Lance Apparel",175	,	1,{	6514,6515,6516,6517,	}, 1,		-1 		) 
  Apps352 = AddMallPack("Black Star Set","Phyllis Apparel",155	,	1,{	6530,6531,6532,6533,	}, 1,		-1 		) 
 -- Apps353 = AddMallPack("Aaravset Set","Lance Apparel",140	,	1,{	6534,6535,	}, 1,		-1 		) 
 -- Apps354 = AddMallPack("$ Set","Lance Apparel",200	,	1,{	6606,6607,6608,6609,	}, 1,		-1 		) 
 -- Apps355 = AddMallPack("Edgar Armor","Lance Apparel",140	,	1,{	6610,	}, 1,		-1 		) 
 -- Apps356 = AddMallPack("PaulDaBest","Phyllis Apparel",145	,	1,{	6611,	}, 1,		-1 		) 
 -- Apps357 = AddMallPack("Carsise New Set","Carsise Apparel",190	,	1,{	6612,6613,6614,6615,	}, 1,		-1 		) 
 -- Apps358 = AddMallPack("Rosadodelacolina","Carsise Apparel",170	,	1,{	6618,6619,	}, 1,		-1 		) 
 -- Apps359 = AddMallPack("JessGSet","Lance Apparel",195	,	1,{	6624,6625,6626,6627,	}, 1,		-1 		) 
 -- Apps360 = AddMallPack("Garlic Breads Set","Ami Apparel",180	,	1,{	6628,6629,	}, 1,		-1 		) 
 -- Apps361 = AddMallPack("MsCutes Set","Ami Apparel",175	,	1,{	6630,6631,	}, 1,		-1 		) 
 -- Apps362 = AddMallPack("Hugin Set","Carsise Apparel",180	,	1,{	6632,6633,	}, 1,		-1 		) 
 -- Apps363 = AddMallPack("Edgar Jason Set","Carsise Apparel",180	,	1,{	6634,6635,	}, 1,		-1 		) 
 -- Apps364 = AddMallPack("Javi Witch Set","Phyllis Apparel",185	,	1,{	6636,6637,	}, 1,		-1 		) 
 -- Apps365 = AddMallPack("Js Ernesto Set","Ami Apparel",185	,	1,{	6639,6640,	}, 1,		-1 		) 
  Apps366 = AddMallPack("Colonel Set","Lance Apparel",190	,	1,{	6641,6642,	}, 1,		-1 		) 
  Apps367 = AddMallPack("M4CHINE WAR Set","Lance Apparel",190	,	1,{	6643,6644,6645,	}, 1,		-1 		) 
  Apps368 = AddMallPack("TDT Js Set","Lance Apparel",200	,	1,{	6646,6647,6648,6649,	}, 1,		-1 		) 
  Apps369 = AddMallPack("Lit-FuckMe Set","Phyllis Apparel",190	,	1,{	6650,6651,6652,	}, 1,		-1 		) 
 -- Apps370 = AddMallPack("Dirty Set","Lance Apparel",190	,	1,{	6654,6655,	}, 1,		-1 		) 
 -- Apps371 = AddMallPack("Kei Set","Phyllis Apparel",180	,	1,{	6656,6657,6658,	}, 1,		-1 		) 
 -- Apps372 = AddMallPack("Cyan Weed Set","Lance Apparel",190	,	1,{	6659,6660,	}, 1,		-1 		) 
 -- Apps373 = AddMallPack("Peeko D Gr8 Set","Ami Apparel",190	,	1,{	6661,6662,6663,	}, 1,		-1 		) 
 -- Apps374 = AddMallPack("Ancelmos Set","Lance Apparel",190	,	1,{	6664,6665,	}, 1,		-1 		) 
 -- Apps375 = AddMallPack("Wrath of Set","Lance Apparel",220	,	1,{	6667,6668,6669,6670,	}, 1,		-1 		) 
 -- Apps376 = AddMallPack("Sky Set","Lance Apparel",200	,	1,{	6672,6673,6674,6675,	}, 1,		-1 		) 
 -- Apps377 = AddMallPack("Ice Set","Lance Apparel",205	,	1,{	6676,6677,6678,6679,	}, 1,		-1 		) 
 -- Apps378 = AddMallPack("Snow Set","Phyllis Apparel",190	,	1,{	6680,6681,	}, 1,		-1 		) 
 -- Apps379 = AddMallPack("Nestos Set","Phyllis Apparel",195	,	1,{	6683,6685,	}, 1,		-1 		) 
 -- Apps380 = AddMallPack("War Set ","Lance Apparel",150	,	1,{	9622,9623,9624,9626	}, 1,		-1 		) 
 -- Apps381 = AddMallPack("Janaconda Armor","Phyllis Apparel",100	,	1,{	9627,	}, 1,		-1 		) 
 -- Apps382 = AddMallPack("Boss Armor","Lance Apparel",110	,	1,{	9628,	}, 1,		-1 		) 
 -- Apps383 = AddMallPack("7Skiez Set","Lance Apparel",220	,	1,{	9631,9632,9633,	}, 1,		-1 		) 
 -- Apps384 = AddMallPack("Unruly Set","Lance Apparel",130	,	1,{	9644,9645,	}, 1,		-1 		) 
 -- Apps385 = AddMallPack("Mesterious Armor 2","Lance Apparel",100	,	1,{	9650,	}, 1,		-1 		) 
 -- Apps386 = AddMallPack("Unruly Robe","Lance Apparel",100	,	1,{	9653,	}, 1,		-1 		) 
 -- Apps387 = AddMallPack("Ocean Vampire","Lance Apparel",155	,	1,{	9655,9656,	}, 1,		-1 		) 
 -- Apps388 = AddMallPack("Ocean Hardin","Lance Apparel",190	,	1,{	9657,9658,	}, 1,		-1 		) 
 -- Apps389 = AddMallPack("CarpetsLove Set","Carsise Apparel",200	,	1,{	9659,9660,9661,9662,	}, 1,		-1 		) 
 -- Apps390 = AddMallPack("Skiez7 Set","Lance Apparel",150	,	1,{	9665,9666,	}, 1,		-1 		) 
 -- Apps391 = AddMallPack("Papi Esco Set","Lance Apparel",185	,	1,{	9668,9669,9670,	}, 1,		-1 		) 
 -- Apps392 = AddMallPack("MDMA666 Set","Carsise Apparel",185	,	1,{	9671,9672,9673,	}, 1,		-1 		) 
 -- Apps393 = AddMallPack("Kims Kraken Armor","Carsise Apparel",115	,	1,{	9676,	}, 1,		-1 		) 
 -- Apps394 = AddMallPack("Steroid Set","Lance Apparel",180	,	1,{	9677,9678,9679,	}, 1,		-1 		) 
 -- Apps395 = AddMallPack("Hektors Set","Carsise Apparel",190	,	1,{	9680,9681,9682,9683,	}, 1,		-1 		) 
 -- Apps396 = AddMallPack("Nitros GG Set","Lance Apparel",185	,	1,{	9686,9687,9688,	}, 1,		-1 		) 
 -- Apps397 = AddMallPack("Kims Ami Armor","Ami Apparel",105	,	1,{	9689,	}, 1,		-1 		) 
 -- Apps398 = AddMallPack("Kims BigAss Armor","Carsise Apparel",105	,	1,{	9690,	}, 1,		-1 		) 
 -- Apps399 = AddMallPack("Yancos Great Set","Lance Apparel",200	,	1,{	9699,9700,9701,	}, 1,		-1 		) 
 -- Apps400 = AddMallPack("Mesterious Demon Set","Lance Apparel",200	,	1,{	9702,9703,9704,9705,	}, 1,		-1 		) 
 -- Apps401 = AddMallPack("Hugin Armor and Hat","Lance Apparel",150	,	1,{	9706,9707,	}, 1,		-1 		) 
 -- Apps402 = AddMallPack("Dexter Punisher Set","Lance Apparel",230	,	1,{	9709,9710,9711,	}, 1,		-1 		) 
 -- Apps403 = AddMallPack("Rymac Armor II Set","Lance Apparel",195	,	1,{	9712,9713,9714,	}, 1,		-1 		) 
 -- Apps404 = AddMallPack("SNOW Armor and Hat","Phyllis Apparel",155	,	1,{	9715,9716,	}, 1,		-1 		) 
 -- Apps405 = AddMallPack("The Joker Armor and Hat","Lance Apparel",155	,	1,{	9718,9719,	}, 1,		-1 		) 
 -- Apps406 = AddMallPack("Unrulys II Set","Lance Apparel",255	,	1,{	9724,9725,9726,9727,9728,	}, 1,		-1 		) 
 -- Apps407 = AddMallPack("Patricks Set","Lance Apparel",255	,	1,{	9729,9730,9731,9732,	}, 1,		-1 		) 
 -- Apps408 = AddMallPack("Mohammed Set","Lance Apparel",255	,	1,{	9733,9734,9735,9736,9737,	}, 1,		-1 		) 
 -- Apps409 = AddMallPack("Patricks Armor","Lance Apparel",135	,	1,{	9738,	}, 1,		-1 		) 
 -- Apps410 = AddMallPack("Einherjar Armor","Lance Apparel",135	,	1,{	9740,	}, 1,		-1 		) 
 -- Apps411 = AddMallPack("Edgar Armor","Lance Apparel",135	,	1,{	9743,	}, 1,		-1 		) 
 -- Apps412 = AddMallPack("CrackMan666 Set","Lance Apparel",210	,	1,{	9749,9750,9751,9753,	}, 1,		-1 		) 
 -- Apps413 = AddMallPack("Venom666 Set","Lance Apparel",210	,	1,{	9752,9755,9756,9757,	}, 1,		-1 		) 
 
--Hat Apparels
 -- Apps500 = AddMallPack("Yahoo Duckbilled Hat","Hat Apparel",125	,	1,{	5557,	}, 1,		-1 		)
 -- Apps501 = AddMallPack("Cacodaemon Cap","Hat Apparel",115	,	1,{	5558,	}, 1,		-1 		)
 -- Apps502 = AddMallPack("Centaur Helmet","Hat Apparel",90	,	1,{	5559,	}, 1,		-1 		)
 -- Apps503 = AddMallPack("Ice Dragon Helmet","Hat Apparel",75	,	1,{	5560,	}, 1,		-1 		)
 -- Apps504 = AddMallPack("Invisible Hat","Hat Apparel",125	,	1,{	6536,	}, 1,		-1 		)
 -- Apps505 = AddMallPack("3la Zby Hair Hat","Hat Apparel",130	,	1,{	9636,	}, 1,		-1 		)
 -- Apps506 = AddMallPack("Shefter Hat","Hat Apparel",130	,	1,{	9643,	}, 1,		-1 		)
 -- Apps507 = AddMallPack("Kims Crown of Cruelty Hat","Hat Apparel",135	,	1,{	9691,	}, 1,		-1 		)
 -- Apps508 = AddMallPack("Perz 7Dsin Hat","Hat Apparel",125	,	1,{	9694,	}, 1,		-1 		)
 -- Apps509 = AddMallPack("Nitros Golden Death Crown","Hat Apparel",145	,	1,{	9696,	}, 1,		-1 		)
 
--Pets
 Pets16 = AddMallPack("Demonic of Strength","Use during pet marriage to conceive a Fairy of Strength",20	,	1,{	3920,	}, 1,	-1		)	
 Pets17 = AddMallPack("Demonic of Intellect","Use during pet marriage to conceive a Fairy of Spirit",20	,	1,{	3921,	}, 1,	-1		)
 Pets18 = AddMallPack("Demonic of Energy","Use during pet marriage to conceive a Fairy of Accuracy",20	,	1,{	3922,	}, 1,	-1		)
 Pets19 = AddMallPack("Demonic of Aberrant","Use during pet marriage to conceive a Fairy of Agility",20	,	1,{	3924,	}, 1,	-1		)
 Pets20 = AddMallPack("Demonic of Mystery","Use during pet marriage to conceive a Fairy of Evil",20	,	1,{	3925,	}, 1,	-1		)
 Pets21 = AddMallPack("Novice Meditation","Pet Skill",10	,	1,{	0259,	}, 1,	-1		)
-- Hot Packs
-- HotP1 = AddMallPack("Random Admiral Cloak Chest","Open to receive a random admiral cloak type",199	,	1,{	15905,	}, 1,		-1 		)
 Eqp1 = AddMallPack("Common Admiral Cloak","A Cloak commisioned by Argent's Admiral.A commendation for all the vigilant defenders of the country (Effective only when placed on the cloak slot, Right click to equip)",450	,	1,{	15902,	}, 1,		-1 		)
 Eqp2 = AddMallPack("Refiend Admiral Cloak","A Cloak commisioned by Argent's Admiral.A commendation for all the vigilant defenders of the country (Effective only when placed on the cloak slot, Right click to equip)",450	,	1,{	15903,	}, 1,		-1 		)

----Tickets
 
Mount1 = AddMallPack("Chocobo Mount ","Upgradeable Mount, Right click to equip)",350	,	1,{	15984,	}, 1,		-1 		)

Mount2  = AddMallPack("Blue Wolf Mount","Upgradeable Mount, Right click to equip)",350	,	1,{	15985,	}, 1,		-1 		)

Mount3 = AddMallPack("Pink Pawn Mount ","Upgradeable Mount, Right click to equip)",350	,	1,{	15986,	}, 1,		-1 		)

Mount4 = AddMallPack("Fedian Mount ","Upgradeable Mount, Right click to equip)",350	,	1,{	15987,	}, 1,		-1 		)

Mount5 = AddMallPack("Helikopter Mount ","Upgradeable Mount, Right click to equip)",350	,	1,{	15989,	}, 1,		-1 		)

Mount6 = AddMallPack("Magic Broom Mount ","Upgradeable Mount, Right click to equip)",350	,	1,{	15990,	}, 1,		-1 		)

Mount7 = AddMallPack("Purple dragon Mount ","Upgradeable Mount, Right click to equip)",350	,	1,{	15991,	}, 1,		-1 		)
Mount8 = AddMallPack("Scorpion King Mount ","Upgradeable Mount, Right click to equip)",350	,	1,{	15992,	}, 1,		-1 		)
Mount9 = AddMallPack("Baowang Mount ","Upgradeable Mount, Right click to equip)",350	,	1,{	15993,	}, 1,		-1 		)
Mount10 = AddMallPack("Jianchihu Tiger Mount ","Upgradeable Mount, Right click to equip)",350	,	1,{	15994,	}, 1,		-1 		)
Mount11 = AddMallPack("White Elephant Mount ","Upgradeable Mount, Right click to equip)",350	,	1,{	15995,	}, 1,		-1 		)

Mount12 = AddMallPack("Frozen Eagle  Mount ","Upgradeable Mount, Right click to equip)",1000	,	1,{	15998,	}, 1,		-1 		)

Mount13 = AddMallPack("Dragon Slayer  Mount ","Upgradeable Mount, Right click to equip)",800	,	1,{	15999,	}, 1,		-1 		)
Mount14 = AddMallPack("Pink Baby Black Dragon Mount ","Upgradeable Mount, Right click to equip)",800	,	1,{	16002,	}, 1,		-1 		)
Mount15 = AddMallPack("White  Baby Black Dragon Mount ","Upgradeable Mount, Right click to equip)",800	,	1,{	16003,	}, 1,		-1 		)

Mount16 = AddMallPack("Fire Eagle Mount ","Upgradeable Mount, Right click to equip)",1000	,	1,{	16004,	}, 1,		-1 		)
 
 --unt1 = AddMallPack("Cho"A Cloak commisioned by Argent's Admiral.A commendation for all the vigilant defenders of the country (Effective only when placed on the cloak slot, Right click to equip)",450	,	1,{	15902,	}, 1,		-1 		)

 --p1 = AddMallPack("Common Admiral Cloak","A Cloak commisioned by Argent's Admiral.A commendation for all the vigilant defenders of the country (Effective only when placed on the cloak slot, Right click to equip)",450	,	1,{	15902,	}, 1,		-1 		)
--Leveling
-- Level1 = AddMallPack("Ticket to Spring","Use to get back to Spring Town",50	,	1,{	0332,	}, 99,	-1		)	
--Forging
 Forge1 = AddMallPack("Azrael's Glare","Can be forged into all weapons.",10	,	1,{	5845,	}, 1,	-1		)
 Forge2 = AddMallPack("Azrael's Undead","Can be forged into armor.",10	,	1,{	5846,	}, 1,	-1		)
 Forge3 = AddMallPack("Azrael's Dance","Can be forged into all equipments.",10	,	1,{	5847,	}, 1,	-1		)
 Forge4 = AddMallPack("Azrael's Aggregation","Can be forged into all equipments.",10	,	1,{	5848,	}, 1,	-1		)
 Forge5 = AddMallPack("Azrael's Light","Can be forged into all equipments.",10	,	1,{	5849,	}, 1,	-1		)
 Forge6 = AddMallPack("Gem of Conqueror","Can be forged into all equipments.",40	,	1,{	864,	}, 1,	-1		)
 Forge7 = AddMallPack("Bight Gem","Can be forged into all equipments.",40	,	1,{	865,	}, 1,	-1		)
 Forge8 = AddMallPack("Gem of Toughness","Can be forged into all equipments.",40	,	1,{	866,	}, 1,	-1		)
 Forge9 = AddMallPack("Gem Slot Card","Take the Slot Card to Blacksmith to change your gem's locations.",25	,	1,{	11101,	}, 1,	-1		)
--Miscellaneous
 Miscs1 = AddMallPack("Gold Axe","Woodcutting tool for all class that produce double yield. Required level 10 to use.",10	,	1,{	0207,	}, 1,	-1		)
 Miscs2 = AddMallPack("Gold Alloy Pickaxe","Enhanced from Alloy Pickaxe with higher durability.",10	,	1,{	3108,	}, 1,	-1		)
 Miscs3 = AddMallPack("Heaven Treasure","Double Click to find out about Heaven's Treasure.",650	,	1,{	15970,	}, 1,	-1		)
 Miscs4 = AddMallPack("Wood Farmer","Double Click to summons Wood Farmer. It will help you Chops tree more faster.",10	,	1,{	15080,	}, 1,	-1		)
 Miscs5 = AddMallPack("Buff Potion","Grants you full Buff for 10 mins.",79	,	1,{	15977,	}, 10,	-1		)
 Miscs6 = AddMallPack("32 Slot Inventory","Increases inventory slots to 32. Can be used only if you have 28 inventory slots",10	,	1,{	15909,	}, 1,	-1		)
 Miscs7 = AddMallPack("36 Slot Inventory","Increases inventory slots to 36. Can be used only if you have 32 inventory slots",10	,	1,{	15910,	}, 1,	-1		)
 Miscs8 = AddMallPack("40 Slot Inventory","Increases inventory slots to 40. Can be used only if you have 36 inventory slots",10	,	1,{	15911,	}, 1,	-1		)
 Miscs9 = AddMallPack("44 Slot Inventory","Increases inventory slots to 44. Can be used only if you have 40 inventory slots",10	,	1,{	15912,	}, 1,	-1		)
 Miscs10 = AddMallPack("48 Slot Inventory","Increases inventory slots to 48. Can be used only if you have 44 inventory slots",10	,	1,{	15913,	}, 1,	-1		)

--Pet Apparels
  Apps707 = AddMallPack("August Pet 1","Pet Apparel",100	,	1,{	5317,	}, 1,		-1 		)
  Apps708 = AddMallPack("August Pet 2","Pet Apparel",100	,	1,{	5318,	}, 1,		-1 		)
  Apps709 = AddMallPack("August Pet 3","Pet Apparel",100	,	1,{	5319,	}, 1,		-1 		)
  Apps710 = AddMallPack("August Pet 4","Pet Apparel",100	,	1,{	5320,	}, 1,		-1 		)
  Apps711 = AddMallPack("Angela","Pet Apparel",100	,	1,{	5321,	}, 1,		-1 		)
  Apps712 = AddMallPack("Angela Junior","Pet Apparel",100	,	1,{	5322,	}, 1,		-1 		)

--Promotions
--Promo1 = AddMallPack("Random Admiral Cloak Chest","Open to receive a random admiral cloak type",500	,	1,{	15905,	}, 1,		-1 		)
--Character
 -- Chars5 = AddMallPack("Name Change Card","Allows you to change your character name",200	,	1,{	9100,	}, 1,		-1 		)
  --Wings

 Wings1 = AddMallPack("Sacred Faerie","Wings",50	,	1,{	9527,	}, 1,		-1 		)
 Wings2 = AddMallPack("Nature Faerie","Wings",50	,	1,{	9528,	}, 1,		-1 		)
 Wings3 = AddMallPack("Mechanical Butterfly","Wings",50	,	1,{	9529,	}, 1,		-1 		)
 Wings4 = AddMallPack("Tinker","Wings",50	,	1,{	9530,	}, 1,		-1 		)
 Wings5 = AddMallPack("Nike Goddess","Wings",50	,	1,{	9531,	}, 1,		-1 		)
 Wings6 = AddMallPack("Undead","Wings",50	,	1,{	9532,	}, 1,		-1 		)
 Wings7 = AddMallPack("Ghoul","Wings",50	,	1,{	9533,	}, 1,		-1 		)
-- Wings8 = AddMallPack("Fallen Angelic","Wings",125	,	1,{	9534,	}, 1,		-1 		)
-- Wings9 = AddMallPack("Bloodshot Angelic","Wings",125	,	1,{	9535,	}, 1,		-1 		)
 Wings10 = AddMallPack("New Dragon","Wings",50	,	1,{	9536,	}, 1,		-1 		)
 Wings11 = AddMallPack("Mystique","Wings",50	,	1,{	9537,	}, 1,		-1 		)
 Wings12 = AddMallPack("Spring Faerie","Wings",50	,	1,{	9538,	}, 1,		-1 		)
 Wings13 = AddMallPack("Crystal","Wings",50	,	1,{	9539,	}, 1,		-1 		)
 Wings14 = AddMallPack("Parrot","Wings",50	,	1,{	9540,	}, 1,		-1 		)
 Wings15 = AddMallPack("Ivory","Wings",50	,	1,{	9541,	}, 1,		-1 		)
 Wings16 = AddMallPack("Rainforest","Wings",50	,	1,{	9542,	}, 1,		-1 		) 
 Wings17 = AddMallPack("Bat","Wings",50	,	1,{	9543,	}, 1,		-1 		)
-- Wings18 = AddMallPack("Oriental","Wings",125	,	1,{	9544,	}, 1,		-1 		)
 Wings19 = AddMallPack("Cherry Blossom","Wings",50	,	1,{	9545,	}, 1,		-1 		)
 Wings20 = AddMallPack("Fairie Blossom","Wings",50	,	1,{	9546,	}, 1,		-1 		)
 Wings21 = AddMallPack("Hippogriff","Wings",50	,	1,{	9547,	}, 1,		-1 		)
 Wings22 = AddMallPack("Macaw","Wings",50	,	1,{	9548,	}, 1,		-1 		)
 Wings23 = AddMallPack("Bloody Overlord","Wings",50	,	1,{	9549,	}, 1,		-1 		)   
 Wings24 = AddMallPack("Dark Overlord","Wings",50	,	1,{	9550,	}, 1,		-1 		)
 Wings25 = AddMallPack("Overlord","Wings",50	,	1,{	9551,	}, 1,		-1 		)
 Wings26 = AddMallPack("Jay","Wings",50	,	1,{	9552,	}, 1,		-1 		)
 Wings27 = AddMallPack("Fawkes","Wings",50	,	1,{	9553,	}, 1,		-1 		)  
 Wings28 = AddMallPack("Aero Upgrade","Upgrade your wings to a flying one",399	,	1,{	15000,	}, 1,		-1 		)
-- Wings29 = AddMallPack("Fallen Dragon","Wings",199	,	1,{	9555,	}, 1,		-1 		)
 Wings30 = AddMallPack("Thunder","Wings",50	,	1,{	9556,	}, 1,		-1 		)
 Wings31 = AddMallPack("Night","Wings",50	,	1,{	9557,	}, 1,		-1 		)   
 Wings32 = AddMallPack("Frost","Wings",50	,	1,{	9558,	}, 1,		-1 		)
 Wings33 = AddMallPack("Break","Wings",50	,	1,{	9559,	}, 1,		-1 		)
 
--// Glows Apps
 Glow1 = AddMallPack("Effect Glow - Lightning","Glow Apparels",75	,	1,{	15070,	}, 1,		-1 		)
 Glow2 = AddMallPack("Effect Glow - Tinker","Glow Apparels",75	,	1,{	15071,	}, 1,		-1 		)   
 Glow3 = AddMallPack("Effect Glow - Hardin","Glow Apparels",75	,	1,{	15072,	}, 1,		-1 		)
 Glow4 = AddMallPack("Effect Glow - Darkness","Glow Apparels",75	,	1,{	15073,	}, 1,		-1 		)  
 Glow5 = AddMallPack("Effect Glow - Tornado","Glow Apparels",75	,	1,{	15074,	}, 1,		-1 		)
 Glow6 = AddMallPack("Effect Glow - Shining","Glow Apparels",75	,	1,{	15075,	}, 1,		-1 		)  
 
--// Title Apps
 Title1 = AddMallPack("Bronze - Title","Title Apparels",150	,	1,{	15710,	}, 1,		-1 		)
 Title2 = AddMallPack("Silver - Title","Title Apparels",150	,	1,{	15711,	}, 1,		-1 		)   
 Title3 = AddMallPack("Gold - Title","Title Apparels",150	,	1,{	15712,	}, 1,		-1 		)
 Title4 = AddMallPack("Platinum - Title","Title Apparels",150	,	1,{	15713,	}, 1,		-1 		)  
 Title5 = AddMallPack("Diamond - Title","Title Apparels",150	,	1,{	15714,	}, 1,		-1 		)
 Title6 = AddMallPack("Master - Title","Title Apparels",150	,	1,{	15715,	}, 1,		-1 		)  
 Title7 = AddMallPack("Challenger - Title","Title Apparels",150	,	1,{	15716,	}, 1,		-1 		)  
 Title8 = AddMallPack("Vip - Title","Title Apparels",150	,	1,{	15717,	}, 1,		-1 		)  
 
--// Coloured Names Apps
 Names1 = AddMallPack("Red Coloured Name","Coloured Names",500	,	1,{	15600,	}, 1,		-1 		)
 Names2 = AddMallPack("Green Coloured Name","Coloured Names",500	,	1,{	15601,	}, 1,		-1 		)
 Names3 = AddMallPack("Blue Coloured Name","Coloured Names",500	,	1,{	15602,	}, 1,		-1 		)
 Names4 = AddMallPack("Black Coloured Name","Coloured Names",500	,	1,{	15603,	}, 1,		-1 		)  
 Names5 = AddMallPack("Gray Coloured Name","Coloured Names",500	,	1,{	15604,	}, 1,		-1 		)  
 
 Mounts1 = AddMallPack("Cochobo Mount","Upgradeable Mount",350,	1,{	15984,	}, 1,		-1 		) 


	-----##			tabs Section Start				## ----																								  
           
--local tabHotP = AddMallTab("HOT PACKS!",{HotP2,HotP3,HotP4,HotP5,HotP6,})		   
--local tabPromo = AddMallTab("PROMO",{Promo7,Promo8,Promo9,Promo10,Promo11,Promo12,})
local tabPet = AddMallTab("PET",{Pets16,Pets17,Pets18,Pets19,Pets20,Pets21,})     
local tabPets = AddMallTab("Pet",{},tabPet)
--local tabPetFood = AddMallTab("Marriage",{Pets9,Pets10,Pets11,Pets12,Pets13,Pets15,Pets16,Pets17,Pets18,Pets19,},tabPet)
local tabPetP = AddMallTab("Pet Apparels",{Apps707,Apps708,Apps709,Apps710,Apps711,Apps712,},tabPet)
	
--local tabLvl = AddMallTab("Leveling",{})
--	local tabLvlTick= AddMallTab("Tickets",{Level1,Level2,Level3,Level4,Level5,Level6,Level7,Level8,Level9,Level10,Level11,Level12,Level13,Level14,Level15,Level16,Level17,Level18,Level19,Level20,Level21,Level22,Level23,Level24,Level25,Level26,},tabLvl)
--	local tabLvlAmp = AddMallTab("Amplifiers",{Level30,Level31,Level32,Level33,Level34,},tabLvl)
--	local tabLvlPot = AddMallTab("Potions",{},tabLvl)
	
local tabForging = AddMallTab("Forge",{})
local tabForgingGems = AddMallTab("Gems",{Forge9,Forge1,Forge2,Forge3,Forge4,Forge5,Forge6,Forge7,Forge8,},tabForging)

local tabDec = AddMallTab("Fashion",{})
	local tabDecW= AddMallTab("Weapons",{Apps24,Apps25,Apps26,Apps27,Apps28,Apps29,Apps30,Apps31,Apps32,Apps33,Apps34,Apps35,Apps36,Apps37,Apps38,Apps39,Apps40,Apps41,Apps42,--[[Apps43,Apps44,Apps45,Apps46,Apps47,Apps48,Apps49,Apps50,Apps51,Apps52,Apps53,Apps54,Apps55,Apps56,Apps57,Apps58,Apps59,Apps60,Apps61,Apps62,Apps63,Apps64,Apps65,Apps66,Apps67,Apps68,Apps69,Apps70,Apps71,Apps72,Apps73,Apps74,Apps75,Apps76,Apps77,Apps78,Apps79,Apps80,Apps81,Apps82,Apps83,Apps84,Apps85,Apps86,Apps87,Apps88,Apps89,Apps90,Apps91,Apps92,Apps93,Apps94,Apps95,Apps96,Apps97,Apps98,Apps99,AppsWe100,AppsWe101,AppsWe102,AppsWe103,AppsWe104,AppsWe105,AppsWe106,AppsWe107,AppsWe108,AppsWe109,AppsWe110,AppsWe111,AppsWe112,AppsWe113,AppsWe114,AppsWe115,AppsWe116,AppsWe117,AppsWe118,AppsWe119,AppsWe120,AppsWe121,AppsWe122,AppsWe123,]] },tabDec)
	--local tabDecA = AddMallTab("All Class",{Apps100,Apps101,Apps102,Apps104,Apps105,Apps106,Apps107,Apps108,Apps109,Apps110,Apps111,Apps112,Apps113,Apps114,Apps115,Apps116,Apps117,Apps118,Apps119,Apps120,Apps121,Apps122,Apps123,Apps124,Apps125,Apps126,Apps127,Apps128,Apps129,Apps130,Apps131,Apps132,Apps133,Apps134,Apps136,Apps137,Apps138,Apps139,Apps140,Apps141,Apps142,Apps143,Apps144,Apps145,Apps146,Apps147,Apps148,Apps149,Apps150,Apps151,},tabDec)
	local tabDecO = AddMallTab("Other",{Apps300,--[[Apps301,Apps302,Apps303,Apps304,Apps306,Apps307,Apps309,Apps310,Apps311,Apps312,Apps313,Apps314,Apps315,Apps316,Apps320,Apps323,Apps324,Apps326,Apps330,Apps331,Apps332,Apps333,Apps334,Apps335,Apps336,Apps337,Apps338,Apps339,Apps340,Apps341,Apps342,Apps343,Apps344,Apps345,Apps347]]Apps348,Apps349,Apps350,Apps351,Apps352,--[[Apps353,Apps354,Apps355,Apps356,Apps357,Apps358,Apps359,Apps360,Apps361,Apps362,Apps363,Apps364,Apps365,]]Apps366,Apps367,Apps368,Apps369,--[[Apps370,Apps371,Apps372,Apps373,Apps374,Apps375,Apps376,Apps377,Apps378,Apps379,Apps380,Apps381,Apps382,Apps383,Apps384,Apps385,Apps386,Apps387,Apps388,Apps389,Apps390,Apps391,Apps392,Apps393,Apps394,Apps395,Apps396,Apps397,Apps398,Apps399,Apps400,Apps401,Apps402,Apps403,Apps404,Apps405,Apps406,Apps407,Apps408,Apps409,Apps410,Apps411,Apps412,Apps413,]]},tabDec)
--	local tabDecH = AddMallTab("Hats",{Apps500,Apps501,Apps502,Apps503,Apps504,Apps505,Apps506,Apps507,Apps508,Apps509,},tabDec)
	local tabDecWi = AddMallTab("Wings",{Wings28,Wings1,Wings2,Wings3,Wings4,Wings5,Wings6,Wings7,Wings10,Wings11,Wings12,Wings13,Wings14,Wings15,Wings16,Wings17,Wings19,Wings20,Wings21,Wings22,Wings23,Wings24,Wings25,Wings26,Wings27,Wings30,Wings31,Wings32,Wings33,},tabDec)	
	local tabDecG = AddMallTab("Glow Apparels",{Glow1,Glow2,Glow3,Glow4,Glow5,Glow6,},tabDec)	
	local tabDecCo = AddMallTab("Coloured Names",{Names1,Names2,Names3,Names4,Names5,Names6,},tabDec)
	local tabDecGt = AddMallTab("Title Apparels",{Title1,Title2,Title3,Title4,Title5,Title6,Title7,Title8,},tabDec)	
local tabMisc = AddMallTab("MISC",{Miscs3,Miscs4,Miscs5,Miscs6,Miscs7,Miscs8,Miscs9,Miscs10,Miscs11,Miscs12,Miscs13,})
--	local tabMisc = AddMallTab("Character",{Chars1,Chars2,Chars3,Chars4,Chars5,},tabMisc)
local tabEquip = AddMallTab("Aspects of Equips",{Eqp1,Eqp2})
local tabMount = AddMallTab("Mounts",{Mount1,Mount2,Mount3,Mount4,Mount4,Mount5,Mount6,Mount7,Mount8,Mount9,Mount10,Mount11,Mount12,Mount13,Mount14,Mount15,Mount16,})


--local tabcrystal = AddMallTab("CRYSTAL POINTS",{MallPoint1,MallPoint2,MallPoint3,MallPoint4,MallPoint5,MallPoint6,MallPoint7,MallPoint8,})

	-----##				tabs Section End 			##----	
function operateIGS(role,pkt)
	local cmd = ReadCmd(pkt)
	if cmd == CMD_CM_STORE_OPEN_ASK then
		openIGS(role)
	elseif cmd == CMD_CM_STORE_BUY_ASK then
		local ID = ReadDword(pkt)
		BuyIGSPack(role,ID)
	elseif cmd == CMD_CM_STORE_LIST_ASK then
		local lClsID = ReadDword(pkt)
		local sPage = ReadWord(pkt)
		local sNum = ReadWord(pkt)	
		openIGSTab(role,lClsID,sPage)
	elseif cmd == CMD_CM_STORE_CLOSE then
		IGSUsers[role] = nil
	end
end
------ create .log file ---mothannakh
_igs					= {}												-- Declares the table _igs
_igs.SavePath			= GetResPath('../Log/Igs.log')		-- create the empty file 
_igs.SavePath2			= GetResPath('../Log/MallPoints.log')		-- create the empty file
_igs.Initial			= function(File)
	Table				= io.open(File, 'r')
	
	if Table ~= nil then
		io.close(Table)
		--print("file closed")
	else
	io.open(File, 'w+')
	---print("Mall System Logs unexpected Error!")
	end
end
_igs.Initial(_igs.SavePath)	
_igs.Initial(_igs.SavePath2)	
-----------mall points logs--
function MallLog(msg)
	local file = "Log/MallPoints.log"
	local LogFile = io.open(file,'a')
	LogFile:write("["..os.date().."]\t"..msg.."\n")
	LogFile:close()	
end
----------------
function IGSLog(msg)
	local file = "Log/Igs.log"
	local LogFile = io.open(file,'a')
	LogFile:write("["..os.date().."]\t"..msg.."\n")
	LogFile:close()	
end

function BuyIGSPack(role,ID)
	if IGSPacks[ID] and IGSPacks[ID].Enabled then
		local pack = IGSPacks[ID]
		local slots = #pack
		local pkt = GetPacket()
		WriteCmd(pkt,CMD_MC_STORE_BUY_ASR)
		if GetChaFreeTempBagGridNum(role) >= slots and HasIMP(role,pack.Price) then
			-----Stock check start ----mothannakh--
			if IDStock[ID].Stockx ~= -1 then 
				if	IDStock[ID].Stockx >= 1  then
					IDStock[ID].Stockx = IDStock[ID].Stockx - 1		--- update new stock 
					local cmd2 = string.format([[IDStock[%d].Stockx = %d]],ID,IDStock[ID].Stockx)	--update new stock in all gs --
					LuaAll(cmd2,role)
					local cmd = string.format("UpdateIGS()",role)	--reload igs packs --- and call it in all gs
					LuaAll(cmd,role)		
						---lets stop fast spam ---
					PopupNotice(role,"You Bought [ "..pack.Title.." ] Successfully! ")	--- This will slow down the click Spam just incase! --
				else
					PopupNotice(role,"Item Stock Sold Out")	--- if stocks sold out --
					return
				end	
			end		
			------stock check end ---
			TakeIMP(role,pack.Price)
			IGSLog(string.format("[%s] Bought [%s] for [%d], [%d] remaining.",GetChaDefaultName(role),pack.Title,pack.Price,GetIMP(role)))
			for i,v in ipairs(pack.Items) do
				if type(v) == "table" then
				--print(i..v)
					AddItem(role,v,1)
				else
				i = pack.Quantity	--todo add qty  for each itemid not pack id--mothannakh
				--print(i..v)
					GiveItemX ( role , 0 , v , i , 0 )
				end
			end
			WriteByte(pkt,1)
			WriteDword(pkt,GetIMP(role))
		else
			WriteByte(pkt,0)
		end	
		SendPacket(role,pkt)
	end
end

function SetIMPAcc(acc,num)
	local chas = {GetPlayerByActName(acc)}
	for i,v in ipairs(chas) do
		SetIMP(v,num,true)
		UpdateIMP(v)
	end
end

function imp(i)
	GiveIMP(GetPlayerByName('[GM]Zuzfdukinpro'),i or 1000)
end
-----function for handle chat mothannakh--
--give imps byname
function giveimps (role,name,num)
	local name = GetPlayerByName(name)
	local gmname = GetChaDefaultName(role)
	if name ~= nil then
		GiveIMP(name,num)
		SystemNotice(name,"GM ["..gmname.." ]Gave you x"..num.." [mall points ]")
		PopupNotice(role,"You Gave you x ("..num..") [ Mall Points ] to ["..GetChaDefaultName(name).." ]")
		MallLog("GM ["..gmname.." ]Gave x("..num.." ) [ Mall Points ] to ["..GetChaDefaultName(name).."] " )
	end
end
----take imps handlechat mothannakh--
function takeimps (role,name,num)
	local name = GetPlayerByName(name)
	local gmname = GetChaDefaultName(role)
	if name ~= nil then
		TakeIMP(name,num)
		SystemNotice(name,"GM ["..gmname.." ]took from you x"..num.." [Mall Points ]")
		PopupNotice(role,"You Took x "..num.." [Mall Points ] from ["..GetChaDefaultName(name).." ]")
		MallLog("GM [ "..gmname.." ] Took x("..num..") [ Mall Points ] from ["..GetChaDefaultName(name).."] " )
	end
end
----give imps or take by accountname	--Note Player should be online 
function impsbyacount(role,name,num,value)
	local account = GetPlayerByActName(name)
	if account ~= nil then
		if value == '+' then
			SetIMP(account,GetIMP(account)+num)
		--	print("here")
		--	UpdateIMP(name)		
			else
			SetIMP(account,GetIMP(account)-num)
			--UpdateIMP(name)	
		end
	end

end

------
function imps(name,num)
	local role = GetPlayerByName(name)
	local cmd = string.format([[SetIMPAcc('%s',%d)]],GetActName(role),num)
	Lua_All(cmd,role)
end

function HasIMP(role,num)
	return GetIMP(role) >= num
end

function TakeIMP(role,num)
	--local cmd = string.format([[SetIMPAcc('%s',%d)]],GetActName(role),GetIMP(role)-num)
	--Lua_All(cmd,role)
	--SetIMPAcc(GetActName(role),GetIMP(role)-num)
	SetIMP(role,GetIMP(role)-num)
end

function GiveIMP(role,num)
	--SetIMP(role,GetIMP(role)+num)
	--local cmd = string.format([[SetIMPAcc('%s',%d)]],GetActName(role),GetIMP(role)+num)
	--Lua_All(cmd,role)
	SetIMP(role,GetIMP(role)+num)
	SystemNotice(role, "System gives you "..num.." IMP, total: "..GetIMP(role).."!");
end

function UpdateIMP(role)
	local pkt = GetPacket()
	WriteCmd(pkt,CMD_MC_UPDATEIMP)
	WriteDword(pkt,GetIMP(role))
	SendPacket(role,pkt)
end
---------this function to set limited stock inside igs 
function limitchange(role,ID,limit)
	if	ID == nil or limit == nil then
		PopupNotice(role,"Packet ID or Limit value is null!")
		return
	end
	local cmd = string.format([[IDStock[%d].Stockx = %d]],ID,limit)	
	Lua_All(cmd,role)
	
end


-----------

function WritePackage(pkt,ID)
	local pack = IGSPacks[ID]
	local qty = pack.Quantity
	local stock = pack.stock--stock
	---Create Stocks tables ---
	if stock == nil then 
		stock = -1
		---Store Stocks IDs and Qty of it ---
			else 
			if IDStock[ID] == nil then	---create table for each pack 
				IDStock[ID] = {Stockx = pack.stock }
			end
		 
	end
	------Stock tables end ---
	WriteDword(pkt,ID) --comid
	WriteString(pkt,pack.Title) --package name
	WriteDword(pkt,pack.Price) --price
	WriteString(pkt,pack.Description) --description
	WriteByte(pkt,pack.Hot) --1=hot, 0=not
	WriteDword(pkt,0x80000000) --nTime (??)
	WriteDword(pkt,IDStock[ID].Stockx) --stock Quantity
	WriteDword(pkt,0x80000000) --hours remaining 0x80000000
	WriteWord(pkt,#pack.Items)--number of items in package
	for j,k in pairs(pack.Items) do
		WriteItem(pkt,k,qty)
	end
end

function WriteItem(pkt,item,qty)
	if type(item) ~= "table" then
		item = {ID=item, Quantity = Quantity}	---todo qty for each item --- mothannakh--
	end	
	
	WriteWord(pkt,item.ID) --itemID
	WriteWord(pkt,qty or 1) --itemnum or Quantity
	WriteWord(pkt,0) --flute(????)
	for i = 1,5 do
		if item.Attributes and item.Attributes[i] then
			WriteWord(pkt,item.Attributes[i].ID)--attr
			WriteWord(pkt,item.Attributes[i].Num)--value
		else
			WriteWord(pkt,0)--attr
			WriteWord(pkt,0)--value
		end
	end
end

function openIGSTab(role,tab,page)
	tab = tab or 1
	page = page or 1
	if not IGSTabs[tab] or not role then
		return
	end
	IGSUsers[role] = {tab,page}
	local pkt = GetPacket()
	WriteCmd(pkt,CMD_MC_STORE_LIST_ASR )
	local totalnum = #IGSTabs[tab].Packs
	local maxPage = math.ceil(totalnum/PACK_PER_PAGE)
	WriteWord(pkt,maxPage)--max page (calc this)
	if page<maxPage or totalnum==PACK_PER_PAGE then			----add <= if want to fill empty slots
		WriteWord(pkt,page)--current page
		WriteWord(pkt,PACK_PER_PAGE)--number of item packages
	else
		WriteWord(pkt,maxPage)--current page
		WriteWord(pkt,math.mod(totalnum,PACK_PER_PAGE))--number of item packages
	end
	for i = 1,PACK_PER_PAGE do
		local index = i + (page-1)*PACK_PER_PAGE
		local packID = IGSTabs[tab].Packs[index]
		if packID then
			WritePackage(pkt,packID)
		end
	end
	SendPacket(role,pkt)
end

function openIGS(role)
	if not role then
		return
	end
	IGSUsers[role] = true
	local pkt = GetPacket()
	WriteCmd(pkt,CMD_MC_STORE_OPEN_ASR)
	WriteByte(pkt,1)--is valid
	WriteDword(pkt,0)--VIP level
	WriteDword(pkt,0)--bean
	WriteDword(pkt,GetIMP(role))--money
	WriteDword(pkt,0)--unused (count for field that isnt used)
	WriteDword(pkt,#IGSTabs)--lClsNum
	for i,v in ipairs(IGSTabs) do
		WriteWord(pkt,i)--lClsID
		WriteString(pkt,v.Title)--szClsName
		WriteWord(pkt,v.Parent or 0)--parentID
	end
	SendPacket(role,pkt)
end

function UpdateIGS()
	for i,v in pairs(IGSUsers) do
		if v then
			if type(v) == "table" then
				openIGSTab(i,v[1],v[2])
			else
				openIGS(i)
			end
			PopupNotice(i,"Mall has been updated!")	--Disable this since we load it every time for limited items
		end
	end
end

UpdateIGS()

--------igs mall point ---

ImpsPointCard = function(Player, Item)
	local Name = GetChaDefaultName(Player)
	local ItemID = GetItemID(Item)
	local GlobalCD = true	-- If true, every player will have the same cooldown and will not be able to use it when another player just used it.
	local Cooldown = 5		-- Cooldown in seconds.
	local crystalifo = GetIMP(Player)
	if GlobalCD then
		IGS_V = IGS_V or 0
		if (IGS_V - os.time()) > 0 then
			HelpInfoX(Player, 0, "In order to use ["..GetItemName(ItemID).."] you must wait "..(IGS_V - os.time()).." second(s) since it's in a global cooldown.")
			UseItemFailed(Player)
			return
		end
		IGS_V = os.time() + Cooldown
	else
		IGS_V = IGS_V or {}
		IGS_V[Name] = IGS_V[Name] or 0
		if (IGS_V[Name] - os.time()) > 0 then
			HelpInfoX(Player, 0, "In order to use ["..GetItemName(ItemID).."] you must wait "..(IGS_V[Name] - os.time()).." second(s) since it's in a global cooldown.")
			UseItemFailed(Player)
			return
		end
		IGS_V[Name] = os.time() + Cooldown
	end
	
	local Points = {

		[14985] = 1,	
		[14986] = 10,    
		[14987] = 25,   
		[14988] = 50,   
		[14989] = 100,   
		[14990] = 250,   
		[14991] = 500,  
		[14992] = 1000,  
--		[15065] = 500,  
--		[15067] = 1000  	
		 			}      	
--GetIMP(role)
	local Amount = Points[ItemID]
	local total = Amount + crystalifo
	GiveIMP(Player,Amount) 
	HelpInfoX(Player, 0, "You just used ["..GetItemName(ItemID).."] and gained "..Amount.." point(s) to spend in [Ingame-Mall], enjoy!")
	LG("Imps System", " Player:["..GetChaDefaultName(Player).."], Used:["..GetItemName(ItemID).."], Total IMPS now is: Amount:["..Amount.."] + Current Amount:["..crystalifo.."]= Total["..total.."]")
	
end
