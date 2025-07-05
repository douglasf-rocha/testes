print('Loading betanpc.lua')

function btalk_tickt10 ()
	Talk( 1, "Sue: Hi! I am Ticket Producer, Sue. I Just opened this store, I hope you enjoy!" )
	Text( 1, "Buy Tickets", BuyPage)
	Text( 1, "Nothing...",  CloseTalk)

	InitTrade()
	Other(	3048	)--Pass to Thundoria Castle
	Other(	3049	)--Pass to Thundoria Harbor
	Other(	3050	)--Pass to Demonic World
	Other(	3051	)--Pass to Andes Forest Haven
	Other(	3052	)--Pass to Oasis Haven
	Other(	3053	)--Pass to Icespire Haven
	Other(	3073	)--Pass to Abandon Mine 1
	Other(	3056	)--Pass to Abandoned Mine 2
	Other(	3057	)--Pass to Silver Mine 2
	Other(	3058	)--Pass to Silver Mine 3
	Other(	3055	)--Pass to Barren Cavern
	Other(	3054	)--Pass to Lone Tower 1
	Other(	3059	)--Pass to Lone Tower 2
	Other(	3060	)--Pass to Lone Tower 3
	Other(	3070	)--Pass to Lone Tower 4
	Other(	3071	)--Pass to Lone Tower 5
	Other(	3072	)--Pass to Lone Tower 6
	Other(	2445	)--Caribbean Tour Ticket
	Other(	3076	)--Pass to Spring Town
	Other(	0563	)--Pass to Summer
	Other(	0583	)--Pass to Autumn
	Other(	2491	)--Pass to Naval Base
--	Other(	2844	)--Pass to Abaddon 4
	Other(	2447	)--Pass to Skeletar Isle?
	Other(	11105	)--Winter Tix
	
end 

-- Captain
function btalk_beta01()
	Talk(1, 'Captain Hook: Along side me are my fellow colleagues ready to assist you in your adventure in the beta phase of Corsairs Online.')
	Text(1, 'Leave...', CloseTalk)
end

-- Fairy merchant - Sparrow
function btalk_beta02()
	Talk(1, 'Sparrow: Fairies, fairies everywhere!')
	Text(1, 'Buy', BuyPage)
	Text(1, 'Leave...', CloseTalk)
	-- misc
	Other(	0262	) -- fairy box
	Other(	0227	) -- ration
	Other(	2312	) -- auto ration
	Other(	0578	) -- fruit growth
	-- fairy fruits
	Other(	0222	)
	Other(	0276	)
	Other(	0223	)
	Other(	0277	)
	Other(	0224	)
	Other(	0278	)
	Other(	0225	)
	Other(	0279	)
	Other(	0226	)
	Other(	0280	)
	-- fairy skills
	Other(	243	) -- protect
	Other(	244	)
	Other(	246	) -- berserk
	Other(	247	)
	Other(	249	) -- magic
	Other(	250	)
	Other(	252	) -- recover
	Other(	253	)
	Other(	259	) -- medi
	Other(	260	)
	-- marriage
	Other(3920)
	Other(3924)
	Other(3922)
	Other(3919)
	Other(3921)
	Other(3925)
	Other(3918)

	Other(3086)
	Other(3087)
end

-- Blacksmith - Turner
function btalk_beta03()
	Talk(1, 'Turner: Awakening is a process of sharpening your equipments even further... exclusive to Beta phase.')
	Text(1, 'Buy', BuyPage)
	Text(1, 'Leave...', CloseTalk)

	InitTrade()
	Weapon(	0767	)
	Weapon(	0774	)
	Weapon(	0764	)
	Weapon(	0771	)
	Weapon(	0804	)
	Weapon(	0800	)
	Weapon(	0790	)
	Weapon(	0793	)
	Weapon(	0796	)
	Weapon(	0786	)
	Weapon(	0778	)
	Weapon(	0782	)
	Weapon(	0768	)-- 55:crus
	Weapon(	0807	)
	Weapon(	0808	)
	Weapon(	0775	)
	Weapon(	0805	)-- voyager
	Weapon(	0815	)
	Weapon(	0877	)
	Weapon(	0801	)
	Weapon(	0797	)-- Sealmaster
	Weapon(	0811	)
	Weapon(	0813	)
	Weapon(	0794	)
	Weapon(	0791	)-- Cleric
	Weapon(	0812	)
	Weapon(	0814	)
	Weapon(	0787	)
	Weapon(	0779	)-- Sharpshooter
	Weapon(	0809	)
	Weapon(	0810	)
	Weapon(	0783	)
	Weapon(	0765	)  -- champ
	--Weapon(	3575	)
	--Weapon(	3576	)
	Weapon(	0772	)
	Weapon(	9160	)

	for i = 10150, 10221 do
		Defence(i)
	end
end

function btalk_beta04()
	Talk ( 1, "Sue: Tickets to all over the places are sold here. How may i help you?" )
	Text ( 1, "Ticket Shop", BuyPage)

	InitTrade()
	Other(	4602	)--Argent City
	Other(	4603	)--
	Other(	4604	)--
	Other(	3141	)--Old Ticket
	Other(	3048	)--Pass to Thundoria Castle
	Other(	3049	)--Pass to Thundoria Harbor
	Other(	3076	)--Pass to Spring Town
	--Other(	6205	)--Pass to Winter Isle?
	Other(	0563	)--Pass to Summer
	Other(	0583	)--Pass to Autumn
	Other(	3050	)--Pass to Sacred Snow Mountain
	--Other(	10029	)--Pass to Abandon Mine Haven
	Other(	3051	)--Pass to Andes Forest Haven
	Other(	3052	)--Pass to Oasis Haven
	Other(	3053	)--Pass to Icespire Haven
	Other(	3073	)--Pass to Abandon Mine 1
	Other(	3056	)--Pass to Abandoned Mine 2
	Other(	3057	)--Pass to Silver Mine 2
	Other(	3058	)--Pass to Silver Mine 3
	Other(	3055	)--Pass to Barren Cavern
	--Other(	3054	)--Pass to Lone Tower 1
	--Other(	3059	)--Pass to Lone Tower 2
	--Other(	3060	)--Pass to Lone Tower 3
	--Other(	3070	)--Pass to Lone Tower 4
	--Other(	3071	)--Pass to Lone Tower 5
	--Other(	3072	)--Pass to Lone Tower 6
	--Other(	2445	)--Caribbean Tour Ticket
	--Other(	2491	)--Pass to Naval Base
	--Other(	2447	)--Pass to Skeletar Isle?
	--Other(	10027	)--PK Map
	-- Other(	7072	)-- Heaven
	--Other(	10028	)
	--Other(	7078	) -- LA
	--Other(	7079	) -- DA
end

-- Accessories - Elizabeth
function btalk_beta05()
	Talk(1, 'Elizabeth: Ladies do love a man who can give them shiny things...')
	Text(1, 'Buy', BuyPage)
	Text(1, 'Leave...', CloseTalk)

	InitTrade()
	-- necks
	Weapon(	739	)
	Weapon(	461	)
	Weapon(	462	)
	Weapon(	463	)
	-- rings
	Weapon(	324	) -- str
	Weapon(	334	)
	Weapon(	327	) -- agi
	Weapon(	346	)
	Weapon(	328	) -- acc
	Weapon(	347	)
	Weapon(	329	) -- con
	Weapon(	348	)
	Weapon(	330	) -- spr
	Weapon(	349	)
	Weapon()
	Weapon()
	local c = 0
	for i = 7294, 7311 do
		Weapon(i)
		c = c + 1
		if c == 3 then
			Weapon()
			c = 0
		end
	end
end

function btalk_beta06()
	Talk( 1, "Gem Seller: Arrrrrrrr the glowing gems..." )
	Text( 1, "Let me see", BuyPage )

	InitTrade()
--	Weapon(	453	)
--	Weapon(	454	)
	Weapon(	0455	)
	Weapon(	0890	)
	Weapon(	0891	)
	Weapon(	1020	)
--	Weapon(	456	)
--	Weapon(	3074	)
--	Weapon(	3075	)
--	Weapon(	891	)
--	Weapon(	890	)
--	Weapon(	1020	)
	--normal gems
	Weapon(	0885	)
	Weapon(	0878	)
	Weapon(	0879	)
	Weapon(	0880	)
	Weapon(	0881	)
	Weapon(	0882	)
	Weapon(	0883	)
	Weapon(	0884	)
	Weapon(	0887	)
	Weapon(	6817	)
	Weapon(	6818	)
	Weapon(	6819	)
	Weapon(	6820	)
	Weapon(	6821	)
	Weapon(	6822	)
	Weapon(	6823	)
	Weapon(	6824	)
	Weapon(	6825	)
	Weapon(	6826	)
	Weapon(	6827	)
	Weapon(	6828	)
	Weapon(	6829	)
	Weapon(	6830	)
	Weapon(	6831	)

--	Defence(	3109	)
--	Defence(	3110	)
--	Defence(	3111	) 
--	Defence(	3112	)
--	Defence(	3113	)
--	Defence(	3047	)
--	Defence(	3098	)
--	Defence(	3099	)
--	Defence(	3342	)
	--Defence(	850	)
--	Defence(	3105	)
	-- amps
--	for i = 3094,3097 do
--		Defence(i)
--	end
	-- nana
--	Defence(0849)
--	Defence(	2816	)
--	Defence(	5939	)
--	Defence(	15006	)
	
--	Defence(	15044	)
--	Defence(	15045	)
--	Defence(	15046	)
--	Defence(	14999	)	
--	Defence(	1780	)		
--[[
	Other(	3088	)
	Other(	3089	)
	Other(	3090	)
	Other(	3091	)
	Other(	3092	)
	Other(	3093	)]]--
--	Other(	3908	)
--	Other(	207	)
--	Other(	208	)
--[[	Other(	3462	)
	Other(	3463	)
	Other(	3300	)
	Other(	3301	)
	Other(	2625	)
	Other(	2630	)
	Other(	2634	)
	Other(	2635	)
	Other(	2636	)
	Other(	2637	)
	Other(	2638	)]]--
end

function btalk_beta07()

	Talk( 1, "Appareal NPC - Lance: Welcome to the Appareal Shop of Argent City. I am the owner Lance." )
	Text( 1, "Trade Appareals", BuyPage )

	InitTrade()
	Weapon(	5001	)
	Weapon(	5002	)
	Weapon(	5003	)
	Weapon(	5004	)
	Weapon(	5005	)
	Weapon(	5011	)
	Weapon(	5006	)
	Weapon(	5007	)
	Weapon(	5008	)
	Weapon(	5009	)
	Weapon(	5010	)
	Weapon(	5283	)
	Weapon(	5284	)
	Weapon(	5070	)
	Weapon(	5071	)
	Weapon(	5072	)
	Weapon(	5073	)
	Weapon(	5074	)
	Weapon(	5277	)
	Weapon(	5278	)
	Weapon(	5280	)
	Weapon(	5281	)
	Weapon(	5282	)
	Weapon(	5285	)
	Weapon(	5286	)
	Weapon(	5044	)
	Defence(	5341	)--Robe of the Chilling Heart
	Defence(	5349	)--Gloves of the Chilling Heart
	Defence(	5357	)--Boots of the Chilling Heart
	Defence(	5345	)--Robe of the Frozen Heart
	Defence(	5353	)--Gloves of the Frozen Heart
	Defence(	5361	)--Boots of the Frozen Heart
	Defence(	5369	)--Armor of Catacomb
	Defence(	5370	)--Gauntlets of Catacomb
	Defence(	5371	)--Greaves of Catacomb
	Defence(	5373	)--Armor of Buccaneer
	Defence(	5374	)--Gauntlets of Buccaneer
	Defence(	5375	)--Greaves of Buccaneer
	Defence(	5378	)--Leather Vest
	Defence(	5379	)--Leather Gloves
	Defence(	5380	)--Leather Boots
	Defence(	5381	)--Warrior Frock
	Defence(	5382	)--Warrior Gloves
	Defence(	5383	)--Warrior Boots
	Defence(	5415	)--Straw Shirt
	Defence(	5416	)--Straw Gloves
	Defence(	5417	)--Straw Shoes
	Defence(	5423	)--Brutal Chef Coat
	Defence(	5424	)--Brutal Chef Gloves
	Defence(	5425	)--Brutal Chef Boots
	Defence(	5450	)
	Defence(	5451	)
	Defence(	5452	)
	Defence(	5453	)--Capricious Robe of Dragon
	Defence(	5454	)--Capricious Gloves of Dragon
	Defence(	5455	)--Capricious Boots of Dragon
	Defence(	5456	)--Ember Armor of Caesar
	Defence(	5457	)--Ember Gauntlets of Caesar
	Defence(	5458	)--Ember Greaves of Caesar
	Defence(	5518	)--Lance Dark Royal Robe
	Defence(	5519	)--Lance Dark Royal Gloves
	Defence(	5520	)--Lance Dark Royal Boots
	Defence(	5496	)--Lance Priest Robe
	Defence(	5497	)--Lance Priest Gloves
	Defence(	5498	)--Lance Priest Boots
	Defence(	5525	)--Lance Aries Armor
	Defence(	5526	)--Lance Aries Gauntlets
	Defence(	5527	)--Lance Aries Greaves
	Defence(	5500	)--Violaceous Dragon Boots
	Defence(	5501	)--Amber Kylin Armor
	Defence(	5502	)--Amber Kylin Gloves
	Defence(	5547	)--Lance Romantic Pas Robe
	Defence(	5548	)--Lance Romantic Pas Shoes
	Defence(	5549	)--Lance Romantic Pas White Gloves
	Defence(	5551	)--Lance Romantic Pas Black Gloves
	Defence(	5552	)--
	Other(	5419	)--
	Other(	5420	)--
	Other(	5421	)--
	Other(	3900	)--
	Other(	5485	)--Royal Major Vest
	Other(	5486	)--Royal Major Gloves
	Other(	5487	)--Royal Major Boots
	Other(	5491	)--Crimson Gold Plume
	Other(	5514	)--Lance Fortune Cap
	Other(	5515	)--Lance Fortune Robe
	Other(	5516	)--Lance Fortune Gloves
	Other(	5517	)--Lance Fortune Shoes
	Other(	5521	)--Lance Piggy Beret
	Other(	5522	)--Lance Piggy Shirt
	Other(	5523	)--Lance Piggy Gloves
	Other(	5524	)--Lance Piggy Boots
	Other(	5529	)--Lance Betrayal of Taurus
	Other(	5530	)--Lance Loneliness of Taurus
	Other(	5531	)--Lance Touch of Taurus
	Other(	5532	)--Lance Flowing Sand of Taurus
	Other(	5533	)--Lance Betrayal of Gemini
	Other(	5534	)--Lance Loneliness of Gemini
	Other(	5535	)--Lance Touch of Gemini
	Other(	5536	)--Lance Flowing Sand of Gemini
	Other(	5537	)--Lance Street Love Hat
	Other(	5538	)--Lance Street Love Robe
	Other(	5539	)--Lance Street Love Gloves
	Other(	5540	)--Lance Street Love Shoes
	Other(	5456	)--Lance Cancer Cap
	Other(	5457	)--Lance Cancer Armor
	Other(	5458	)--Lance Cancer Gauntlets
	Other(	5577	)--Lance Vampire Hat
	Other(	5578	)--Lance Vampire Suit
	Other(	5579	)--Lance Vampire Gloves
	Other(	5580	)--Lance Vampire Shoes
	Other(	5581	)--Lance Superman Hat
	Other(	5582	)--Lance Superman Suit
	Other(	5583	)--Lance Superman Gloves
	Other(	5584	)--Lance Superman Shoes
	Other(	5585	)--Lance Ninja Hat
	Other(	5586	)--Lance Ninja Suit
	Other(	5587	)--Lance Ninja Gloves
	Other(	5588	)--Lance Ninja Shoes
	Other(	5589	)--Lance Caribbean Hat
	Other(	5590	)--Lance Caribbean Shirt
	Other(	5591	)--Lance Caribbean Gloves
	Other(	5592	)--Lance Caribbean Shoes
	Other(	5593	)--Lance Chinese New Year Hat
	Other(	5594	)--Lance Chinese New Year Suit
	Other(	5595	)--Lance Chinese New Year Gloves
	Other(	5596	)--Lance Chinese New Year Shoes
	Other(	5597	)--Lance Bloodmoon Helmet
	Other(	5598	)--Lance Bloodmoon Armor
	Other(	5599	)--Lance Bloodmoon Gloves
	Other(	5600	)--Lance Bloodmoon Boots
	Other(	5678	)--Lance Wild West Robe
	Other(	5679	)--Lance Wild West Gloves
	Other(	5680	)--Lance Wild West Boots
	Other(	5681	)--Lance Wild West Boots
	Other(	5609	)
	Other(	5610	)
	Other(	5611	)
	Other(	5612	)
	Other(	141	)
	Other(	905	)
	Other(	904	)
	Other(	906	)
	Other(	935	)
	Other(	937	)
	Other(	142	)
end

function btalk_beta08()
	Talk( 1, "Appareal NPC - Carsise: Welcome to the Appareal Shop of Argent City. I am the owner Carsise." )
	Text( 1, "Trade Appareals", BuyPage )

	InitTrade()
	Weapon(	5001	)
	Weapon(	5002	)
	Weapon(	5003	)
	Weapon(	5004	)
	Weapon(	5005	)
	Weapon(	5011	)
	Weapon(	5006	)
	Weapon(	5007	)
	Weapon(	5008	)
	Weapon(	5009	)
	Weapon(	5010	)
	Weapon(	5283	)
	Weapon(	5284	)
	Weapon(	5070	)
	Weapon(	5071	)
	Weapon(	5072	)
	Weapon(	5073	)
	Weapon(	5074	)
	Weapon(	5277	)
	Weapon(	5278	)
	Weapon(	5280	)
	Weapon(	5281	)
	Weapon(	5282	)
	Weapon(	5285	)
	Weapon(	5286	)
	Weapon(	5044	)
	Defence(	5342	)--Modern Caveman Robe
	Defence(	5350	)--Modern Caveman Gloves
	Defence(	5358	)--Modern Caveman Boots
	Defence(	5346	)--Wild Caveman Robe
	Defence(	5354	)--Wild Caveman Gloves
	Defence(	5362	)--Wild Caveman Boots
	Defence(	5369	)--Torso of Catacomb
	Defence(	5370	)--Gage of Catacomb
	Defence(	5371	)--Sandals of Catacomb
	Defence(	5373	)--Torso of Buccaneer
	Defence(	5374	)--Gage of Buccaneer
	Defence(	5375	)--Sandals of Buccaneer
	Defence(	5387	)--Seaman Vest
	Defence(	5388	)--Seaman Gloves
	Defence(	5389	)--Seaman Boots
	Defence(	5390	)--Shark Hide Armor
	Defence(	5391	)--Shark Hide Gloves
	Defence(	5392	)--Shark Hide Boots
	Defence(	5393	)--Sailor Vest
	Defence(	5394	)--Sailor Gloves
	Defence(	5395	)--Sailor Boots
	Defence(	5396	)--Navy Vest
	Defence(	5397	)--Navy Gloves
	Defence(	5398	)--Navy Boots
	Defence(	5399	)--Captain's Jacket
	Defence(	5400	)--Captain's Gloves
	Defence(	5401	)--Captain's Boots
	Defence(	5403	)--Bloody Captain Shirt
	Defence(	5404	)--Bloody Captain Gloves
	Defence(	5405	)--Bloody Captain Shoes
	Defence(	5411	)--Smoker Navy Vest
	Defence(	5412	)--Smoker Navy Gloves
	Defence(	5413	)--Smoker Navy Boots
	Defence(	5525	)--Carsise Aries Armor
	Defence(	5526	)--Carsise Aries Gauntlets
	Defence(	5527	)--Carsise Aries Greaves
	Defence(	5367	)--Tattoo of the Burning Dragon
	Defence(	5368	)--Tattoo of the Frozen Dragon
	Defence(	5518	)--Carsise Romantic Shirt
	Defence(	5519	)--Carsise Romantic Gloves
	Defence(	5520	)--Carsise Romantic Boots
	Defence(	5500	)--Carsise Bruce Tights
	Defence(	5501	)--Carsise Bruce Gloves
	Defence(	5502	)--Carsise Bruce Shoes
	Defence(	5547	)--Carsise Romantic Pas Robe
	Defence(	5548	)--Carsise Romantic Pas Shoes
	Defence(	5549	)--Carsise Romantic Pas White Gloves
--	Other(	5406	)--
--	Other(	5407	)--
--	Other(	5408	)--
--	Other(	5409	)--
	Other(	3900	)--Sahara Crocodile Crown
	Other(	5485	)--Royal Major Vest
	Other(	5486	)--Royal Major Gloves
	Other(	5487	)--Royal Major Boots
	Other(	5503	)--Carsise Ranger Beret
	Other(	5504	)--Carsise Ranger Shirt
	Other(	5505	)--Carsise Ranger Gloves
	Other(	5506	)--Carsise Ranger Boots
	Other(	5514	)--Carsise Fortune Cap
	Other(	5515	)--Carsise Fortune Robe
	Other(	5516	)--Carsise Fortune Gloves
	Other(	5517	)--Carsise Fortune Shoes
	Other(	5521	)--Carsise Piggy Beret
	Other(	5522	)--Carsise Piggy Armor
	Other(	5523	)--Carsise Piggy Gloves
	Other(	5524	)--Carsise Piggy Boots
	Other(	5529	)--Carsise Betrayal of Taurus
	Other(	5530	)--Carsise Loneliness of Taurus
	Other(	5531	)--Carsise Touch of Taurus
	Other(	5532	)--Carsise Flowing Sand of Taurus
	Other(	5533	)--Carsise Betrayal of Gemini
	Other(	5534	)--Carsise Loneliness of Gemini
	Other(	5535	)--Carsise Touch of Gemini
	Other(	5536	)--Carsise Flowing Sand of Gemini
	Other(	5581	)--Carsise Superman Hat
	Other(	5582	)--Carsise Superman Suit
	Other(	5583	)--Carsise Superman Gloves
	Other(	5584	)--Carsise Superman Shoes
	Other(	5585	)--Carsise Ninja Hat
	Other(	5586	)--Carsise Ninja Suit
	Other(	5587	)--Carsise Ninja Gloves
	Other(	5588	)--Carsise Ninja Boots
	Other(	5589	)--Carsise Caribbean Hat
	Other(	5590	)--Carsise Caribbean Shirt
	Other(	5591	)--Carsise Caribbean Gloves
	Other(	5592	)--Carsise Caribbean Boots
	Other(	5593	)--Carsise Chinese New Year Hat
	Other(	5594	)--Carsise Chinese New Year Suit
	Other(	5595	)--Carsise Chinese New Year Gloves
	Other(	5596	)--Carsise Chinese New Year Shoes
	Other(	5597	)--Carsise Bloodmoon Helmet
	Other(	5598	)--Carsise Bloodmoon Armor
	Other(	5599	)--Carsise Bloodmoon Gloves
	Other(	5600	)--Carsise Bloodmoon Boots
	Other(	5601	)--Carsise Wild West Cap
	Other(	5602	)--Carsise Wild West Robe
	Other(	5603	)--Carsise Wild West Gloves
	Other(	5604	)--Carsise Wild West Boots
	Other(	5605	)
	Other(	5606	)
	Other(	5607	)
	Other(	5608	)
	Other(	5609	)
	Other(	5610	)
	Other(	5611	)
	Other(	5612	)
	Other(	141	)
	Other(	905	)
	Other(	904	)
	Other(	906	)
	Other(	935	)
	Other(	937	)
	Other(	142	)
	Other(	1120	)
	Other(	1122	)
	Other(	1121	)
end 

function btalk_beta09()
	Talk( 1, "Appareal NPC - Phyllis: Welcome to the Appareal Shop of Argent City. I am the owner Phyllis." )
	Text( 1, "Trade Appareals", BuyPage )

	InitTrade()
	Weapon(	5001	)
	Weapon(	5002	)
	Weapon(	5003	)
	Weapon(	5004	)
	Weapon(	5005	)
	Weapon(	5006	)
	Weapon(	5007	)
	Weapon(	5008	)
	Weapon(	5009	)
	Weapon(	5010	)
	Weapon(	5283	)
	Weapon(	5284	)
	Weapon(	5070	)
	Weapon(	5071	)
	Weapon(	5072	)
	Weapon(	5073	)
	Weapon(	5074	)
	Weapon(	5277	)
	Weapon(	5278	)
	Weapon(	5280	)
	Weapon(	5281	)
	Weapon(	5282	)
	Weapon(	5285	)
	Weapon(	5286	)
	Defence(	5343	)--Alluring Grand Robe
	Defence(	5351	)--Alluring Grand Gloves
	Defence(	5359	)--Alluring Grand Boots
	Defence(	5347	)--Winter Grand Robe
	Defence(	5355	)--Winter Grand Gloves
	Defence(	5363	)--Winter Grand Boots
	Defence(	5369	)--Coat of Catacomb
	Defence(	5370	)--Gloves of Catacomb
	Defence(	5371	)--Boots of Catacomb
	Defence(	5373	)--Coat of Buccaneer
	Defence(	5374	)--Gloves of Buccaneer
	Defence(	5375	)--Boots of Buccaneer
	Defence(	5378	)--Leather Vest
	Defence(	5379	)--Leather Gloves
	Defence(	5380	)--Leather Boots
	Defence(	5381	)--Warrior Frock
	Defence(	5382	)--Warrior Gloves
	Defence(	5383	)--Warrior Boots
	Defence(	5384	)--Nightmare Vest
	Defence(	5385	)--Nightmare Gloves
	Defence(	5386	)--Nightmare Boots
	Defence(	5387	)--Seaman Vest
	Defence(	5388	)--Seaman Gloves
	Defence(	5389	)--Seaman Boots
	Defence(	5390	)--Shark Hide Armor
	Defence(	5391	)--Shark Hide Gloves
	Defence(	5392	)--Shark Hide Boots
	Defence(	5393	)--Sailor Vest
	Defence(	5394	)--Sailor Gloves
	Defence(	5395	)--Sailor Boots
	Defence(	5396	)--Navy Vest
	Defence(	5397	)--Navy Gloves
	Defence(	5398	)--Navy Boots
	Defence(	5399	)--Captain's Jacket
	Defence(	5400	)--Captain's Gloves
	Defence(	5401	)--Captain's Boots
	Defence(	5447	)--Sexy Coat
	Defence(	5448	)--Sexy Gloves
	Defence(	5449	)--Sexy Boots
	Defence(	5450	)--Tiger Armor of Cavalry
	Defence(	5451	)--Tiger Gauntlets of Cavalry
	Defence(	5452	)--Tiger Greaves of Cavalry
	Defence(	5453	)--Capricious Robe of Dragon
	Defence(	5453	)--Capricious Gloves of Dragon
	Defence(	5455	)--Capricious Boots of Dragon
	Defence(	5462	)--Dark Blue Vest of Fate
	Defence(	5463	)--Dark Blue Gloves of Fate
	Defence(	5464	)--Dark Blue Boots of Fate
	Defence(	5525	)--Phyllis Aries Forlorn
	Defence(	5526	)--Phyllis Aries Gauntlets
	Defence(	5527	)--Phyllis Aries Greaves
	Defence(	5518	)--Phyllis Romantic Blouse
	Defence(	5519	)--Phyllis Romantic Muffs
	Defence(	5520	)--Phyllis Romantic Shoes
	Defence(	5500	)--Phyllis Bruce Tights
	Defence(	5501	)--Phyllis Bruce Gloves
	Defence(	5502	)--Phyllis Bruce Shoes
	Defence(	5547	)--Phyllis Mirable Paradise Robe
	Defence(	5548	)--Phyllis Mirable Paradise Shoes
	Defence(	5549	)--Phyllis Mirable Paradise White Gloves
	Defence(	5734	)--
	Defence(	5735	)--
	Defence(	5736	)--
	Other(	5438	)--Dainty Doll
	Other(	5439	)--Dainty Bodice
	Other(	5440	)--Dainty Gloves
	Other(	5441	)--Dainty Shoes
	Other(	5442	)--Sassy Princess
	Other(	5443	)--Shaitan Princess Bodice
	Other(	5444	)--Shaitan Princess Gloves
	Other(	5445	)--Shaitan Princess Shoes
	Other(	3900	)--Christmas Cap
	Other(	5488	)--Dynamic Royal
	Other(	5485	)--Royal Major Vest
	Other(	5486	)--Royal Major Gloves
	Other(	5487	)--Royal Major Boots
	Other(	5492	)--Phyllis Wedding Veil
	Other(	5493	)--Phyllis Wedding Gown
	Other(	5494	)--Phyllis Wedding Gloves
	Other(	5495	)--Phyllis Wedding Shoes
	Other(	5496	)--Phyllis Vestal Wrap
	Other(	5497	)--Phyllis Vestal Costume
	Other(	5498	)--Phyllis Vestal Gloves
	Other(	5499	)--Phyllis Vestal Shoes
	Other(	5514	)--Phyllis Fortune Cap
	Other(	5515	)--Phyllis Fortune Robe
	Other(	5516	)--Phyllis Fortune Gloves
	Other(	5517	)--Phyllis Fortune Shoes
	Other(	5521	)--Phyllis Piggy Bonnet
	Other(	5522	)--Phyllis Piggy Blouse
	Other(	5523	)--Phyllis Piggy Gloves
	Other(	5524	)--Phyllis Piggy Boots
	Other(	5529	)--Phyllis Betrayal of Taurus
	Other(	5530	)--Phyllis Loneliness of Taurus
	Other(	5531	)--Phyllis Touch of Taurus
	Other(	5532	)--Phyllis Flowing Sand of Taurus
	Other(	5533	)--Phyllis Betrayal of Gemini
	Other(	5534	)--Phyllis Loneliness of Gemini
	Other(	5535	)--Phyllis Touch of Gemini
	Other(	5536	)--Phyllis Flowing Sand of Gemini
	Other(	5569	)--Phyllis Vampire Hat
	Other(	5570	)--Phyllis Vampire Armor
	Other(	5571	)--Phyllis Vampire Gloves
	Other(	5572	)--Phyllis Vampire Boots
	Other(	5585	)--Phyllis Ninja Hat
	Other(	5586	)--Phyllis Ninja Suit
	Other(	5587	)--Phyllis Ninja Gloves
	Other(	5588	)--Phyllis Ninja Shoes
	Other(	5589	)--Phyllis Caribbean Hat
	Other(	5590	)--Phyllis Caribbean Shirt
	Other(	5591	)--Phyllis Caribbean Gloves
	Other(	5592	)--Phyllis Caribbean Shoes
	Other(	5593	)--Phyllis Chinese New Year Hat
	Other(	5594	)--Phyllis Chinese New Year Suit
	Other(	5595	)--Phyllis Chinese New Year Gloves
	Other(	5596	)--Phyllis Chinese New Year Shoes
	Other(	5597	)--Phyllis Bloodmoon Helmet
	Other(	5598	)--Phyllis Bloodmoon Armor
	Other(	5599	)--Phyllis Bloodmoon Gloves
	Other(	5600	)--Phyllis Bloodmoon Boots
	Other(	5601	)--Phyllis Wild West Hat
	Other(	5602	)--Phyllis Wild West Robe
	Other(	5603	)--Phyllis Wild West Gloves
	Other(	5604	)--Phyllis Wild West Boots
	Other(	5609	)
	Other(	5610	)
	Other(	5611	)
	Other(	5612	)
	Other(	5613	)
	Other(	5614	)
	Other(	5615	)
	Other(	5616	)
	Other(	5637	)
	Other(	5638	)
	Other(	5639	)
	Other(	5640	)
	Other(	141	)
	Other(	905	)
	Other(	904	)
	Other(	906	)
	Other(	935	)
	Other(	937	)
	Other(	142	)
	Other(	1120	)
	Other(	1122	)
	Other(	1121	)
	Other(	2583	)
	Other(	2584	)
	Other(	2585	)
end

function btalk_beta10()
	Talk( 1, "Appareal NPC - Ami: Welcome to the Appareal Shop of Argent City. I am the owner Ami." )
	Text( 1, "Trade Appareals", BuyPage )

	InitTrade()
	Weapon(	5001	)
	Weapon(	5002	)
	Weapon(	5003	)
	Weapon(	5004	)
	Weapon(	5005	)
	Weapon(	5006	)
	Weapon(	5007	)
	Weapon(	5008	)
	Weapon(	5009	)
	Weapon(	5010	)
	Weapon(	5283	)
	Weapon(	5284	)
	Weapon(	5070	)
	Weapon(	5071	)
	Weapon(	5072	)
	Weapon(	5073	)
	Weapon(	5074	)
	Weapon(	5277	)
	Weapon(	5278	)
	Weapon(	5280	)
	Weapon(	5281	)
	Weapon(	5282	)
	Weapon(	5285	)
	Weapon(	5286	)
	Defence(	5365	)--Country Cap
	Defence(	5344	)--Country Robe
	Defence(	5352	)--Country Gloves
	Defence(	5360	)--Country Boots
	Defence(	5366	)--Carillon Cap
	Defence(	5348	)--Carillon Robe
	Defence(	5352	)--Carillon Gloves
	Defence(	5364	)--Carillon Boots
	Defence(	5372	)--Crown of Catacomb
	Defence(	5369	)--Costume of Catacomb
	Defence(	5370	)--Muffs of Catacomb
	Defence(	5371	)--Waders of Catacomb
	Defence(	5376	)--Crown of Buccaneer
	Defence(	5373	)--Costume of Buccaneer
	Defence(	5374	)--Muffs of Buccaneer
	Defence(	5375	)--Waders of Buccaneer
	Defence(	5426	)--Happy Reindeer Cap
	Defence(	5427	)--Happy Reindeer Costume
	Defence(	5428	)--Happy Reindeer Muffs
	Defence(	5429	)--Happy Reindeer Shoes
	Defence(	5430	)--Shrooms Cap
	Defence(	5431	)--Shrooms Costume
	Defence(	5432	)--Shrooms Muffs
	Defence(	5433	)--Shrooms Shoes
	Defence(	5434	)--Little Bee Cap
	Defence(	5435	)--Little Bee Costume
	Defence(	5436	)--Little Bee Muffs
	Defence(	5437	)--Little Bee Shoes
	Defence(	5465	)--Aliya Mini Shirt
	Defence(	5466	)--Aliya Mini Gloves
	Defence(	5467	)--Aliya Mini Shoes
	Defence(	5472	)--Sweetie Cap
	Defence(	5469	)--Sweetie Robe
	Defence(	5470	)--Sweetie Gloves
	Defence(	5471	)--Sweetie Shoes
	Defence(	5476	)--Azure Crown of Fairy
	Defence(	5473	)--Azure Robe of Fairy
	Defence(	5474	)--Azure Gloves of Fairy
	Defence(	5475	)--Azure Boots of Fairy
	Defence(	5480	)--Noble Lion Crown
	Defence(	5477	)--Noble Lion Costume
	Defence(	5478	)--Noble Lion Muffs
	Defence(	5479	)--Noble Lion Paw
	Defence(	5484	)--Silk Bunny Cap
	Defence(	5481	)--Silk Bunny Costume
	Defence(	5482	)--Silk Bunny Muffs
	Defence(	5483	)--Silk Bunny Shoes
	Defence(	5507	)--Ami Aries Diadem
	Defence(	5508	)--Ami Aries Costume
	Defence(	5509	)--Ami Aries Muffs
	Defence(	5510	)--Ami Aries Shoes
	Defence(	5518	)--Ami Romantic Dress
	Defence(	5519	)--Ami Romantic Gloves
	Defence(	5520	)--Ami Romantic Boots
	Defence(	5500	)--Ami Bruce Tights
	Defence(	5501	)--Ami Bruce Gloves
	Defence(	5502	)--Ami Bruce Shoes
	Defence(	5547	)--Ami Pink Angel White Gloves
	Defence(	5548	)--Ami Pink Angel Blue Gloves
	Defence(	5549	)--Ami Pink Angel Black Gloves
	Defence(	5550	)--
	Other(	5488	)--
	Other(	5485	)--
	Other(	5486	)--
	Other(	5487	)--
	Other(	3900	)--Christmas Cap
	Other(	5492	)--Ami Wedding Veil
	Other(	5493	)--Ami Wedding Gown
	Other(	5494	)--Ami Wedding Gloves
	Other(	5495	)--Ami Wedding Shoes
	Other(	5514	)--Ami Fortune Cap
	Other(	5515	)--Ami Fortune Robe
	Other(	5516	)--Ami Fortune Gloves
	Other(	5517	)--Ami Fortune Shoes
	Other(	5521	)--Ami Piggy Cap
	Other(	5522	)--Ami Piggy Costume
	Other(	5523	)--Ami Piggy Muffs
	Other(	5524	)--Ami Piggy Shoes
	Other(	5529	)--Ami Betrayal of Taurus
	Other(	5530	)--Ami's Loneliness of Taurus
	Other(	5531	)--Ami Touch of Taurus
	Other(	5532	)--Ami Flowing Sand of Taurus
	Other(	5533	)--Ami Betrayal of Gemini
	Other(	5534	)--Ami's Loneliness of Gemini
	Other(	5535	)--Ami Touch of Gemini 
	Other(	5536	)--Ami Flowing Sand of Gemini
	Other(	5569	)--Ami Vampire Hat
	Other(	5570	)--Ami Vampire Costume
	Other(	5571	)--Ami Vampire Muffs
	Other(	5572	)--Ami Vampire Shoes
	Other(	5573	)--Ami Black Leather Hat
	Other(	5574	)--Ami Trenchcoat Costume
	Other(	5575	)--Ami Black Leather Gloves
	Other(	5576	)--Ami Black Leather Shoes
	Other(	5565	)--Ami Shinigami Hat
	Other(	5566	)--Ami Shinigami Robe
	Other(	5567	)--Ami Shinigami Gloves
	Other(	5568	)--Ami Shinigami Shoes
	Other(	5585	)--Ami Ninja Hat
	Other(	5586	)--Ami Ninja Suit
	Other(	5587	)--Ami Ninja Gloves
	Other(	5588	)--Ami Ninja Shoes
	Other(	5589	)--Ami Caribbean Hat
	Other(	5590	)--Ami Caribbean Shirt
	Other(	5591	)--Ami Caribbean Gloves
	Other(	5592	)--Ami Caribbean Shoes
	Other(	5593	)--Ami Chinese New Year Hat
	Other(	5594	)--Ami Chinese New Year Suit
	Other(	5595	)--Ami Chinese New Year Gloves
	Other(	5596	)--Ami Chinese New Year Shoes
	Other(	5597	)--Ami Bloodmoon Helmet
	Other(	5598	)--Ami Bloodmoon Armor
	Other(	5599	)--Ami Bloodmoon Gloves
	Other(	5600	)--Ami Bloodmoon Boots
	Other(	5601	)--Ami Wild West Robe
	Other(	5602	)--Ami Wild West Gloves
	Other(	5603	)--Ami Wild West Boots
	Other(	5604	)
	Other(	5605	)
	Other(	5606	)
	Other(	5607	)
	Other(	5608	)
	Other(	5609	)
	Other(	5610	)
	Other(	5611	)
	Other(	5612	)
	Other(	141	)
	Other(	905	)
	Other(	904	)
	Other(	906	)
	Other(	935	)
	Other(	937	)
	Other(	142	)
	Other(	1120	)
	Other(	1122	)
	Other(	1121	)
	Other(	2583	)
	Other(	2584	)
	Other(	2585	)
end

function btalk_beta11()
	Talk( 1, "Foxy: Hi! I am Apparel Tailor, Foxy. Take a look at my apparels, and remember to check all 3 tabs!" )
	Text( 1, "Trade Apparel", BuyPage )

	InitTrade()
	Other(	5001	)
	Other(	5002	)
	Other(	5007	)
	Other(	5008	)
	Other(	5003	)
	Other(	5009	)
	Other(	5004	)
	Other(	5010	)
	Other(	5005	)
	Other(	5011	)
	Other(	5044	)
	Other(	5279	)
	Other(	5286	)
	Other(	5006	)
	Other(	5012	)
	Other(	5283	)
	Other(	5284	)
	Other(	5280	)
	Other(	5309	)
	Other(	5310	)
	Other(	5311	)
	Other(	5312	)
	Other(	5313	)
	Other(	5314	)
	Other(	0141	)--Ebony Dragon Wings
	Other(	0906	)--Devil Wings
	Other(	0937	)--Angelic Wings
	Other(	0142	)--Rainbow Wings
	Other(	0905	)--Dragon Wings
	Other(	0904	)--Vampiric Wings
	Other(	0935	)--Elven Wings
	Other(	0936	)--Butterfly Wings
	Other(	15000	)
end

function r_talkJOB ()
		local npcName = 'Tang'
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
