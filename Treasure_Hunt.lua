	-- **************************************************************************************************	****************** --
	-- *************************************************** Treasure Hunt *************************************************** --
	-- ************************************************ Scripted by Angelix ************************************************ --
	-- ********************************************************************************************************************* --
	--[[
		Just place "TreasureHunt.Summon('<MapName>')" inside "<MapName>monster_conf.lua".
	]]--
	print("treasre hunter dBug")
	
	TreasureHunt = TreasureHunt or {Text = {}, Hook = {}, ID = {}, Role = {}, Spawn = {}}
	
	TreasureHunt.Count = 30
	
	TreasureHunt.CheckNear = true
	TreasureHunt.MaxCheck = 3
	TreasureHunt.Distance = 25
	
	TreasureHunt.ID.Chest = {1054, 1055, 1056, 1057, 1058}
	TreasureHunt.ID.Boss = {1064, 1065, 1066, 1067, 1068}
	
	TreasureHunt.Spawn['garner'] = {
		{MinPosX = 1364, MaxPosX = 1464, MinPosY = 2846, MaxPosY = 2946},
		{MinPosX = 1574, MaxPosX = 1674, MinPosY = 2967, MaxPosY = 3067},
		{MinPosX = 2237, MaxPosX = 2337, MinPosY = 2505, MaxPosY = 2605},
		{MinPosX = 300, MaxPosX = 380, MinPosY = 1562, MaxPosY = 1600},
		{MinPosX = 410, MaxPosX = 461, MinPosY = 1620, MaxPosY = 1760},
		{MinPosX = 410, MaxPosX = 481, MinPosY = 1532, MaxPosY = 1610},
		{MinPosX = 300, MaxPosX = 491, MinPosY = 1522, MaxPosY = 1780},
		{MinPosX = 822, MaxPosX = 950, MinPosY = 1210, MaxPosY = 1357},
		{MinPosX = 890, MaxPosX = 1000, MinPosY = 1051, MaxPosY = 1200},
		{MinPosX = 782, MaxPosX = 880, MinPosY = 1051, MaxPosY = 1200},
		{MinPosX = 772, MaxPosX = 1000, MinPosY = 1041, MaxPosY = 1377},
		{MinPosX = 690, MaxPosX = 781, MinPosY = 1200, MaxPosY = 1378},
		{MinPosX = 580, MaxPosX = 671, MinPosY = 1200, MaxPosY = 1378},
		{MinPosX = 670, MaxPosX = 771, MinPosY = 1061, MaxPosY = 1150},
		{MinPosX = 570, MaxPosX = 781, MinPosY = 1041, MaxPosY = 1378},
		{MinPosX = 400, MaxPosX = 480, MinPosY = 1380, MaxPosY = 1500},
		{MinPosX = 320, MaxPosX = 400, MinPosY = 1380, MaxPosY = 1500},
		{MinPosX = 400, MaxPosX = 480, MinPosY = 1260, MaxPosY = 1380},
		{MinPosX = 320, MaxPosX = 400, MinPosY = 1300, MaxPosY = 1380},
		{MinPosX = 300, MaxPosX = 490, MinPosY = 1285, MaxPosY = 1522},
		{MinPosX = 785, MaxPosX = 854, MinPosY = 2278, MaxPosY = 2354},
		{MinPosX = 785, MaxPosX = 854, MinPosY = 2374, MaxPosY = 2504},
		{MinPosX = 775, MaxPosX = 874, MinPosY = 2278, MaxPosY = 2514},
		{MinPosX = 798, MaxPosX = 854, MinPosY = 2076, MaxPosY = 2254},
		{MinPosX = 778, MaxPosX = 874, MinPosY = 2026, MaxPosY = 2274},
		{MinPosX = 650, MaxPosX = 760, MinPosY = 2053, MaxPosY = 2190},
		{MinPosX = 530, MaxPosX = 630, MinPosY = 2053, MaxPosY = 2190},
		{MinPosX = 400, MaxPosX = 500, MinPosY = 2053, MaxPosY = 2190},
		{MinPosX = 285, MaxPosX = 385, MinPosY = 2053, MaxPosY = 2190},
		{MinPosX = 283, MaxPosX = 762, MinPosY = 2063, MaxPosY = 2201},
		{MinPosX = 792, MaxPosX = 864, MinPosY = 1857, MaxPosY = 1989},
		{MinPosX = 762, MaxPosX = 914, MinPosY = 1817, MaxPosY = 2029},
		{MinPosX = 540, MaxPosX = 723, MinPosY = 1831, MaxPosY = 2170},
		{MinPosX = 530, MaxPosX = 733, MinPosY = 1821, MaxPosY = 2530},
		{MinPosX = 881, MaxPosX = 958, MinPosY = 1484, MaxPosY = 1679},
		{MinPosX = 851, MaxPosX = 988, MinPosY = 1384, MaxPosY = 1779},
		{MinPosX = 493, MaxPosX = 530, MinPosY = 1640, MaxPosY = 1803},
		{MinPosX = 580, MaxPosX = 845, MinPosY = 1660, MaxPosY = 1770},
		{MinPosX = 493, MaxPosX = 845, MinPosY = 1640, MaxPosY = 1803},
		{MinPosX = 499, MaxPosX = 613, MinPosY = 1490, MaxPosY = 1625},
		{MinPosX = 499, MaxPosX = 613, MinPosY = 1398, MaxPosY = 1480},
		{MinPosX = 489, MaxPosX = 623, MinPosY = 1388, MaxPosY = 1635},
		{MinPosX = 564, MaxPosX = 680, MinPosY = 2948, MaxPosY = 3088},
		{MinPosX = 564, MaxPosX = 680, MinPosY = 2800, MaxPosY = 2928},
		{MinPosX = 700, MaxPosX = 810, MinPosY = 2795, MaxPosY = 3088},
		{MinPosX = 564, MaxPosX = 810, MinPosY = 2795, MaxPosY = 3088},
		{MinPosX = 682, MaxPosX = 783, MinPosY = 2633, MaxPosY = 2761},
		{MinPosX = 632, MaxPosX = 733, MinPosY = 2533, MaxPosY = 2651},
		{MinPosX = 632, MaxPosX = 783, MinPosY = 2533, MaxPosY = 2781},
		{MinPosX = 461, MaxPosX = 631, MinPosY = 2670, MaxPosY = 2782},
		{MinPosX = 305, MaxPosX = 459, MinPosY = 2670, MaxPosY = 2782},
		{MinPosX = 461, MaxPosX = 631, MinPosY = 2530, MaxPosY = 2650},
		{MinPosX = 296, MaxPosX = 450, MinPosY = 2530, MaxPosY = 2650},
		{MinPosX = 295, MaxPosX = 632, MinPosY = 2520, MaxPosY = 2793},
		{MinPosX = 293, MaxPosX = 531, MinPosY = 2235, MaxPosY = 2433},
		{MinPosX = 531, MaxPosX = 591, MinPosY = 2235, MaxPosY = 2433},
		{MinPosX = 353, MaxPosX = 591, MinPosY = 2435, MaxPosY = 2533},
		{MinPosX = 293, MaxPosX = 591, MinPosY = 2235, MaxPosY = 2533},
		{MinPosX = 865, MaxPosX = 956, MinPosY = 2915, MaxPosY = 3028},
		{MinPosX = 835, MaxPosX = 986, MinPosY = 2835, MaxPosY = 3148},
		{MinPosX = 875, MaxPosX = 994, MinPosY = 2660, MaxPosY = 2835},
		{MinPosX = 905, MaxPosX = 1034, MinPosY = 2540, MaxPosY = 2635},
		{MinPosX = 835, MaxPosX = 1034, MinPosY = 2540, MaxPosY = 2835},
		{MinPosX = 1038, MaxPosX = 1066, MinPosY = 3039, MaxPosY = 3036},
		{MinPosX = 1150, MaxPosX = 1247, MinPosY = 3072, MaxPosY = 3161},
		{MinPosX = 986, MaxPosX = 1100, MinPosY = 3012, MaxPosY = 3121},
		{MinPosX = 986, MaxPosX = 1257, MinPosY = 3012, MaxPosY = 3181},
		{MinPosX = 1026, MaxPosX = 1209, MinPosY = 2875, MaxPosY = 2972},
		{MinPosX = 986, MaxPosX = 1249, MinPosY = 2835, MaxPosY = 3012},
		{MinPosX = 1200, MaxPosX = 1253, MinPosY = 2680, MaxPosY = 2805},
		{MinPosX = 1034, MaxPosX = 1253, MinPosY = 2680, MaxPosY = 2730},
		{MinPosX = 1034, MaxPosX = 1253, MinPosY = 2680, MaxPosY = 2835},
		{MinPosX = 1071, MaxPosX = 1252, MinPosY = 2600, MaxPosY = 2678},
		{MinPosX = 1031, MaxPosX = 1262, MinPosY = 2600, MaxPosY = 2678},
		{MinPosX = 600, MaxPosX = 725, MinPosY = 2385, MaxPosY = 2535},
		{MinPosX = 591, MaxPosX = 700, MinPosY = 2235, MaxPosY = 2385},
		{MinPosX = 591, MaxPosX = 775, MinPosY = 2235, MaxPosY = 2535},
		{MinPosX = 1251, MaxPosX = 1518, MinPosY = 2962, MaxPosY = 3168},
		{MinPosX = 1251, MaxPosX = 1568, MinPosY = 2942, MaxPosY = 3198},
		{MinPosX = 1575, MaxPosX = 1678, MinPosY = 3110, MaxPosY = 3168},
		{MinPosX = 1545, MaxPosX = 1708, MinPosY = 3080, MaxPosY = 3198},
		{MinPosX = 1570, MaxPosX = 1678, MinPosY = 2984, MaxPosY = 3050},
		{MinPosX = 1545, MaxPosX = 1708, MinPosY = 2954, MaxPosY = 3080},
		{MinPosX = 1297, MaxPosX = 1532, MinPosY = 2846, MaxPosY = 2947},
		{MinPosX = 1247, MaxPosX = 1532, MinPosY = 2776, MaxPosY = 2947},
		{MinPosX = 1557, MaxPosX = 1631, MinPosY = 2828, MaxPosY = 2908},
		{MinPosX = 1497, MaxPosX = 1681, MinPosY = 2788, MaxPosY = 2948},
		{MinPosX = 1724, MaxPosX = 1800, MinPosY = 2804, MaxPosY = 2913},
		{MinPosX = 1704, MaxPosX = 1830, MinPosY = 2784, MaxPosY = 2963},
		{MinPosX = 1850, MaxPosX = 1961, MinPosY = 2804, MaxPosY = 2903},
		{MinPosX = 1830, MaxPosX = 1971, MinPosY = 2784, MaxPosY = 2963},
		{MinPosX = 1320, MaxPosX = 1400, MinPosY = 2640, MaxPosY = 2727},
		{MinPosX = 1261, MaxPosX = 1410, MinPosY = 2600, MaxPosY = 2777},
		{MinPosX = 1440, MaxPosX = 1567, MinPosY = 2640, MaxPosY = 2757},
		{MinPosX = 1410, MaxPosX = 1587, MinPosY = 2600, MaxPosY = 2777},
		{MinPosX = 1564, MaxPosX = 1625, MinPosY = 2626, MaxPosY = 2752},
		{MinPosX = 1544, MaxPosX = 1645, MinPosY = 2606, MaxPosY = 2772},
		{MinPosX = 1707, MaxPosX = 1840, MinPosY = 2477, MaxPosY = 2558},
		{MinPosX = 1767, MaxPosX = 1800, MinPosY = 2497, MaxPosY = 2518},
		{MinPosX = 1900, MaxPosX = 2017, MinPosY = 2427, MaxPosY = 2518},
		{MinPosX = 1787, MaxPosX = 1847, MinPosY = 2467, MaxPosY = 2477},
		{MinPosX = 1787, MaxPosX = 2017, MinPosY = 2467, MaxPosY = 2518},
		{MinPosX = 1630, MaxPosX = 1755, MinPosY = 2547, MaxPosY = 2610},
		{MinPosX = 1900, MaxPosX = 2000, MinPosY = 2516, MaxPosY = 2610},
		{MinPosX = 1575, MaxPosX = 2022, MinPosY = 2516, MaxPosY = 2610},
		{MinPosX = 1952, MaxPosX = 1984, MinPosY = 2657, MaxPosY = 2737},
		{MinPosX = 1932, MaxPosX = 2014, MinPosY = 2617, MaxPosY = 2777},
		{MinPosX = 2100, MaxPosX = 2162, MinPosY = 2675, MaxPosY = 2786},
		{MinPosX = 2019, MaxPosX = 2100, MinPosY = 2720, MaxPosY = 2786},
		{MinPosX = 2019, MaxPosX = 2162, MinPosY = 2675, MaxPosY = 2786},
		{MinPosX = 2027, MaxPosX = 2087, MinPosY = 2600, MaxPosY = 2676},
		{MinPosX = 2087, MaxPosX = 2150, MinPosY = 2528, MaxPosY = 2600},
		{MinPosX = 2087, MaxPosX = 2150, MinPosY = 2600, MaxPosY = 2676},
		{MinPosX = 2027, MaxPosX = 2087, MinPosY = 2528, MaxPosY = 2600},
		{MinPosX = 2027, MaxPosX = 2150, MinPosY = 2528, MaxPosY = 2676},
		{MinPosX = 2150, MaxPosX = 2290, MinPosY = 2600, MaxPosY = 2676},
		{MinPosX = 2150, MaxPosX = 2290, MinPosY = 2528, MaxPosY = 2600}
								}
	TreasureHunt.Spawn['magicsea'] = {
		{MinPosX = 2000, MaxPosX = 2000, MinPosY = 2000, MaxPosY = 2000},
		{MinPosX = 1850, MaxPosX = 2150, MinPosY = 1750, MaxPosY = 2150},
		{MinPosX = 2140, MaxPosX = 2280, MinPosY = 3600, MaxPosY = 3938},
		{MinPosX = 3596, MaxPosX = 4060, MinPosY = 3456, MaxPosY = 3972},
		{MinPosX = 3596, MaxPosX = 4060, MinPosY = 2856, MaxPosY = 3372},
		{MinPosX = 3096, MaxPosX = 4060, MinPosY = 2856, MaxPosY = 3972},
		{MinPosX = 1832, MaxPosX = 2100, MinPosY = 3600, MaxPosY = 3938},
		{MinPosX = 1600, MaxPosX = 2300, MinPosY = 3430, MaxPosY = 3600},
		{MinPosX = 2330, MaxPosX = 3032, MinPosY = 3430, MaxPosY = 3938},
		{MinPosX = 2330, MaxPosX = 3030, MinPosY = 2852, MaxPosY = 3400},
		{MinPosX = 1600, MaxPosX = 2300, MinPosY = 2852, MaxPosY = 3400},
		{MinPosX = 1564, MaxPosX = 3072, MinPosY = 2852, MaxPosY = 3988},
		{MinPosX = 2892, MaxPosX = 3392, MinPosY = 2328, MaxPosY = 2824},
		{MinPosX = 2712, MaxPosX = 3392, MinPosY = 2428, MaxPosY = 2924},
		{MinPosX = 1848, MaxPosX = 2336, MinPosY = 2300, MaxPosY = 2756},
		{MinPosX = 1248, MaxPosX = 1748, MinPosY = 2400, MaxPosY = 2856},
		{MinPosX = 1148, MaxPosX = 2336, MinPosY = 2350, MaxPosY = 2706},
		{MinPosX = 3600, MaxPosX = 4100, MinPosY = 2300, MaxPosY = 2650},
		{MinPosX = 3700, MaxPosX = 4200, MinPosY = 1900, MaxPosY = 2250},
		{MinPosX = 3800, MaxPosX = 4300, MinPosY = 1500, MaxPosY = 1850},
		{MinPosX = 3500, MaxPosX = 4400, MinPosY = 1100, MaxPosY = 1450},
		{MinPosX = 3420, MaxPosX = 4060, MinPosY = 1056, MaxPosY = 2828},
		{MinPosX = 2252, MaxPosX = 3392, MinPosY = 1648, MaxPosY = 2292},
		{MinPosX = 1252, MaxPosX = 1752, MinPosY = 1648, MaxPosY = 2292},
		{MinPosX = 2852, MaxPosX = 3392, MinPosY = 1048, MaxPosY = 1548},
		{MinPosX = 1752, MaxPosX = 2252, MinPosY = 1048, MaxPosY = 1548},
		{MinPosX = 1252, MaxPosX = 3392, MinPosY = 1048, MaxPosY = 2292},
		{MinPosX = 1298, MaxPosX = 1464, MinPosY = 3056, MaxPosY = 3212},
		{MinPosX = 1014, MaxPosX = 1160, MinPosY = 3090, MaxPosY = 3167},
		{MinPosX = 1380, MaxPosX = 1461, MinPosY = 2940, MaxPosY = 3007},
		{MinPosX = 1370, MaxPosX = 1471, MinPosY = 2900, MaxPosY = 3037},
		{MinPosX = 1496, MaxPosX = 1516, MinPosY = 3426, MaxPosY = 3446},
		{MinPosX = 1400, MaxPosX = 1476, MinPosY = 3390, MaxPosY = 3436},
		{MinPosX = 1400, MaxPosX = 1526, MinPosY = 3390, MaxPosY = 3476},
		{MinPosX = 1288, MaxPosX = 1380, MinPosY = 3410, MaxPosY = 3466},
		{MinPosX = 1268, MaxPosX = 1400, MinPosY = 3400, MaxPosY = 3476},
		{MinPosX = 1130, MaxPosX = 1239, MinPosY = 3505, MaxPosY = 3609},
		{MinPosX = 1120, MaxPosX = 1249, MinPosY = 3455, MaxPosY = 3629},
		{MinPosX = 1193, MaxPosX = 1269, MinPosY = 3055, MaxPosY = 3160},
		{MinPosX = 1183, MaxPosX = 1279, MinPosY = 3045, MaxPosY = 3220},
		{MinPosX = 1495, MaxPosX = 1519, MinPosY = 3072, MaxPosY = 3212},
		{MinPosX = 1495, MaxPosX = 1519, MinPosY = 2879, MaxPosY = 3062},
		{MinPosX = 1485, MaxPosX = 1549, MinPosY = 2889, MaxPosY = 3222},
		{MinPosX = 1200, MaxPosX = 1311, MinPosY = 2930, MaxPosY = 3017},
		{MinPosX = 1190, MaxPosX = 1371, MinPosY = 2900, MaxPosY = 3037},
		{MinPosX = 1048, MaxPosX = 1138, MinPosY = 2921, MaxPosY = 2975},
		{MinPosX = 1153, MaxPosX = 1190, MinPosY = 3007, MaxPosY = 3046},
		{MinPosX = 984, MaxPosX = 1070, MinPosY = 2962, MaxPosY = 3060},
		{MinPosX = 964, MaxPosX = 1170, MinPosY = 2962, MaxPosY = 3090},
		{MinPosX = 845, MaxPosX = 924, MinPosY = 2987, MaxPosY = 3070},
		{MinPosX = 815, MaxPosX = 954, MinPosY = 2967, MaxPosY = 3090},
		{MinPosX = 1420, MaxPosX = 1526, MinPosY = 3251, MaxPosY = 3340},
		{MinPosX = 1400, MaxPosX = 1546, MinPosY = 3231, MaxPosY = 3390},
		{MinPosX = 1288, MaxPosX = 1390, MinPosY = 3251, MaxPosY = 3350},
		{MinPosX = 1268, MaxPosX = 1400, MinPosY = 3231, MaxPosY = 3400},
		{MinPosX = 1130, MaxPosX = 1264, MinPosY = 3235, MaxPosY = 3305},
		{MinPosX = 1120, MaxPosX = 1284, MinPosY = 3335, MaxPosY = 3455},
		{MinPosX = 957, MaxPosX = 1110, MinPosY = 3355, MaxPosY = 3469},
		{MinPosX = 957, MaxPosX = 1110, MinPosY = 3225, MaxPosY = 3335},
		{MinPosX = 967, MaxPosX = 1120, MinPosY = 3235, MaxPosY = 3479},
		{MinPosX = 825, MaxPosX = 959, MinPosY = 3323, MaxPosY = 3423},
		{MinPosX = 825, MaxPosX = 959, MinPosY = 3223, MaxPosY = 3323},
		{MinPosX = 815, MaxPosX = 969, MinPosY = 3233, MaxPosY = 3433},
		{MinPosX = 993, MaxPosX = 1070, MinPosY = 3506, MaxPosY = 3606},
		{MinPosX = 953, MaxPosX = 1100, MinPosY = 3476, MaxPosY = 3626}
								}
	TreasureHunt.Spawn['darkblue'] = {
		{MinPosX = 2290, MaxPosX = 2362, MinPosY = 3241, MaxPosY = 3348},
		{MinPosX = 2839, MaxPosX = 2907, MinPosY = 3376, MaxPosY = 3420},
		{MinPosX = 2641, MaxPosX = 2914, MinPosY = 3125, MaxPosY = 3326},
		{MinPosX = 2829, MaxPosX = 2968, MinPosY = 2824, MaxPosY = 2998},
		{MinPosX = 2991, MaxPosX = 3053, MinPosY = 2896, MaxPosY = 2944},
		{MinPosX = 2970, MaxPosX = 3036, MinPosY = 2747, MaxPosY = 2795},
		{MinPosX = 3407, MaxPosX = 3474, MinPosY = 3542, MaxPosY = 3602},
		{MinPosX = 3415, MaxPosX = 3474, MinPosY = 3347, MaxPosY = 3490},
		{MinPosX = 3342, MaxPosX = 3395, MinPosY = 3447, MaxPosY = 3565},
		{MinPosX = 3484, MaxPosX = 3524, MinPosY = 3464, MaxPosY = 3558},
		{MinPosX = 3541, MaxPosX = 3577, MinPosY = 3403, MaxPosY = 3501},
		{MinPosX = 3547, MaxPosX = 3674, MinPosY = 3230, MaxPosY = 3368},
		{MinPosX = 3387, MaxPosX = 3519, MinPosY = 3259, MaxPosY = 3437},
		{MinPosX = 3580, MaxPosX = 3808, MinPosY = 2748, MaxPosY = 2914},
		{MinPosX = 3589, MaxPosX = 3665, MinPosY = 3324, MaxPosY = 3400},
		{MinPosX = 3669, MaxPosX = 3717, MinPosY = 3320, MaxPosY = 3363},
		{MinPosX = 3481, MaxPosX = 3557, MinPosY = 3347, MaxPosY = 3526},
		{MinPosX = 3516, MaxPosX = 3546, MinPosY = 3087, MaxPosY = 3195},
		{MinPosX = 3353, MaxPosX = 3393, MinPosY = 2969, MaxPosY = 3021},
		{MinPosX = 3450, MaxPosX = 3455, MinPosY = 2936, MaxPosY = 2992},
		{MinPosX = 3520, MaxPosX = 3557, MinPosY = 2921, MaxPosY = 2995},
		{MinPosX = 3389, MaxPosX = 3476, MinPosY = 3580, MaxPosY = 3615},
		{MinPosX = 3253, MaxPosX = 3346, MinPosY = 3393, MaxPosY = 3453},
		{MinPosX = 3196, MaxPosX = 3242, MinPosY = 3322, MaxPosY = 3427},
		{MinPosX = 3311, MaxPosX = 3359, MinPosY = 3227, MaxPosY = 3370},
		{MinPosX = 3392, MaxPosX = 3497, MinPosY = 2962, MaxPosY = 3041},
		{MinPosX = 3561, MaxPosX = 3682, MinPosY = 3034, MaxPosY = 3094},
		{MinPosX = 3539, MaxPosX = 3761, MinPosY = 2923, MaxPosY = 3011},
		{MinPosX = 3648, MaxPosX = 3739, MinPosY = 2733, MaxPosY = 2888},
		{MinPosX = 3137, MaxPosX = 3164, MinPosY = 2472, MaxPosY = 2554},
		{MinPosX = 3132, MaxPosX = 3247, MinPosY = 2564, MaxPosY = 2578},
		{MinPosX = 3256, MaxPosX = 3315, MinPosY = 2540, MaxPosY = 2575},
		{MinPosX = 3349, MaxPosX = 3396, MinPosY = 2451, MaxPosY = 2536},
		{MinPosX = 3264, MaxPosX = 3324, MinPosY = 2424, MaxPosY = 2466},
		{MinPosX = 3148, MaxPosX = 3239, MinPosY = 2423, MaxPosY = 2442},
		{MinPosX = 3358, MaxPosX = 3910, MinPosY = 3644, MaxPosY = 3972},
		{MinPosX = 3208, MaxPosX = 4060, MinPosY = 3644, MaxPosY = 3972},
		{MinPosX = 2688, MaxPosX = 3143, MinPosY = 3508, MaxPosY = 3938},
		{MinPosX = 2370, MaxPosX = 3055, MinPosY = 2030, MaxPosY = 2658},
		{MinPosX = 1883, MaxPosX = 2398, MinPosY = 3595, MaxPosY = 3980},
		{MinPosX = 1683, MaxPosX = 2598, MinPosY = 3595, MaxPosY = 3980},
		{MinPosX = 986, MaxPosX = 1565, MinPosY = 3384, MaxPosY = 3884},
		{MinPosX = 965, MaxPosX = 1565, MinPosY = 3384, MaxPosY = 3884},
		{MinPosX = 3510, MaxPosX = 4060, MinPosY = 1700, MaxPosY = 2250},
		{MinPosX = 2932, MaxPosX = 3060, MinPosY = 2030, MaxPosY = 2660},
		{MinPosX = 2932, MaxPosX = 3490, MinPosY = 1483, MaxPosY = 1980},
		{MinPosX = 2912, MaxPosX = 4040, MinPosY = 1463, MaxPosY = 2385},
		{MinPosX = 2376, MaxPosX = 2886, MinPosY = 1787, MaxPosY = 2309},
		{MinPosX = 1827, MaxPosX = 2336, MinPosY = 2087, MaxPosY = 2609},
		{MinPosX = 1827, MaxPosX = 2336, MinPosY = 1487, MaxPosY = 2047},
		{MinPosX = 3442, MaxPosX = 4050, MinPosY = 858, MaxPosY = 1138},
		{MinPosX = 2842, MaxPosX = 3422, MinPosY = 858, MaxPosY = 1138},
		{MinPosX = 1250, MaxPosX = 1740, MinPosY = 860, MaxPosY = 1140},
		{MinPosX = 1180, MaxPosX = 2444, MinPosY = 780, MaxPosY = 1436},
		{MinPosX = 3568, MaxPosX = 4060, MinPosY = 150, MaxPosY = 788},
		{MinPosX = 3268, MaxPosX = 4060, MinPosY = 150, MaxPosY = 788},
		{MinPosX = 1886, MaxPosX = 2079, MinPosY = 520, MaxPosY = 540},
		{MinPosX = 2532, MaxPosX = 2643, MinPosY = 866, MaxPosY = 934},
		{MinPosX = 2552, MaxPosX = 2643, MinPosY = 806, MaxPosY = 856},
		{MinPosX = 2532, MaxPosX = 2643, MinPosY = 796, MaxPosY = 944},
		{MinPosX = 2632, MaxPosX = 2729, MinPosY = 764, MaxPosY = 826},
		{MinPosX = 2552, MaxPosX = 2629, MinPosY = 764, MaxPosY = 826},
		{MinPosX = 2522, MaxPosX = 2739, MinPosY = 764, MaxPosY = 836},
		{MinPosX = 3057, MaxPosX = 3145, MinPosY = 647, MaxPosY = 686},
		{MinPosX = 3037, MaxPosX = 3165, MinPosY = 637, MaxPosY = 706},
		{MinPosX = 2800, MaxPosX = 2904, MinPosY = 621, MaxPosY = 680},
		{MinPosX = 2683, MaxPosX = 2790, MinPosY = 621, MaxPosY = 680},
		{MinPosX = 2673, MaxPosX = 2914, MinPosY = 611, MaxPosY = 700},
		{MinPosX = 3091, MaxPosX = 3161, MinPosY = 550, MaxPosY = 626},
		{MinPosX = 2924, MaxPosX = 3071, MinPosY = 540, MaxPosY = 580},
		{MinPosX = 2605, MaxPosX = 2822, MinPosY = 336, MaxPosY = 408},
		{MinPosX = 2585, MaxPosX = 2892, MinPosY = 356, MaxPosY = 448},
		{MinPosX = 2436, MaxPosX = 2506, MinPosY = 445, MaxPosY = 560},
		{MinPosX = 2426, MaxPosX = 2516, MinPosY = 415, MaxPosY = 600},
		{MinPosX = 2337, MaxPosX = 2410, MinPosY = 506, MaxPosY = 597},
		{MinPosX = 2327, MaxPosX = 2430, MinPosY = 506, MaxPosY = 587},
		{MinPosX = 2204, MaxPosX = 2329, MinPosY = 540, MaxPosY = 640},
		{MinPosX = 2204, MaxPosX = 2329, MinPosY = 430, MaxPosY = 510},
		{MinPosX = 2204, MaxPosX = 2329, MinPosY = 420, MaxPosY = 659},
		{MinPosX = 2130, MaxPosX = 2200, MinPosY = 428, MaxPosY = 496},
		{MinPosX = 2125, MaxPosX = 2170, MinPosY = 418, MaxPosY = 566},
		{MinPosX = 1020, MaxPosX = 1100, MinPosY = 778, MaxPosY = 832},
		{MinPosX = 1010, MaxPosX = 1100, MinPosY = 708, MaxPosY = 768},
		{MinPosX = 1078, MaxPosX = 1138, MinPosY = 592, MaxPosY = 652},
		{MinPosX = 1403, MaxPosX = 1508, MinPosY = 529, MaxPosY = 592},
		{MinPosX = 1548, MaxPosX = 1628, MinPosY = 532, MaxPosY = 600},
		{MinPosX = 1403, MaxPosX = 1588, MinPosY = 632, MaxPosY = 702},
		{MinPosX = 1383, MaxPosX = 1588, MinPosY = 509, MaxPosY = 732},
		{MinPosX = 1100, MaxPosX = 1210, MinPosY = 560, MaxPosY = 597},
		{MinPosX = 1118, MaxPosX = 1241, MinPosY = 343, MaxPosY = 400},
		{MinPosX = 1098, MaxPosX = 1261, MinPosY = 323, MaxPosY = 550},
		{MinPosX = 1250, MaxPosX = 1400, MinPosY = 288, MaxPosY = 322},
		{MinPosX = 1098, MaxPosX = 1230, MinPosY = 288, MaxPosY = 322},
		{MinPosX = 1098, MaxPosX = 1495, MinPosY = 278, MaxPosY = 322},
		{MinPosX = 889, MaxPosX = 1100, MinPosY = 275, MaxPosY = 455},
		{MinPosX = 889, MaxPosX = 1000, MinPosY = 375, MaxPosY = 455},
		{MinPosX = 889, MaxPosX = 1100, MinPosY = 288, MaxPosY = 455},
		{MinPosX = 835, MaxPosX = 935, MinPosY = 308, MaxPosY = 358},
		{MinPosX = 775, MaxPosX = 882, MinPosY = 288, MaxPosY = 448},
		{MinPosX = 711, MaxPosX = 833, MinPosY = 278, MaxPosY = 308},
		{MinPosX = 621, MaxPosX = 693, MinPosY = 397, MaxPosY = 426},
		{MinPosX = 621, MaxPosX = 773, MinPosY = 288, MaxPosY = 426},
		{MinPosX = 611, MaxPosX = 693, MinPosY = 288, MaxPosY = 376}
								}
	
	TreasureHunt.Text.Sealed = 'Chest is sealed.'
	
	TreasureHunt.Role.Chest = TreasureHunt.Role.Chest or {}
	TreasureHunt.Role.Boss = TreasureHunt.Role.Boss or {}
	
	TreasureHunt.CheckAlive = function(Monster)
		if Monster == nil then
			return false
		end
		if Hp(Monster) <= 0 then
			return false
		end
		return true
	end
	TreasureHunt.ChooseSpawn = function(MapName)
		local Area = math.random(1, #TreasureHunt.Spawn[MapName])
		local PosX = math.random(TreasureHunt.Spawn[MapName][Area].MinPosX, TreasureHunt.Spawn[MapName][Area].MaxPosX)
		local PosY = math.random(TreasureHunt.Spawn[MapName][Area].MinPosY, TreasureHunt.Spawn[MapName][Area].MaxPosY)
		return PosX, PosY
	end

	TreasureHunt.CheckArea = function(MapName, PosX, PosY)
		if not TreasureHunt.CheckNear or #TreasureHunt.Role.Chest[MapName] == 0 then
			return PosX, PosY
		end
		local Count, Near = 0, true
		while (Count < TreasureHunt.MaxCheck) and Near do
			Near = false
			for A = 1, #TreasureHunt.Role.Chest[MapName], 1 do
				local ChestPosX, ChestPosY = GetChaPos(TreasureHunt.Role.Chest[MapName][A])
				local DifPosX, DifPosY = (ChestPosX - PosX), (ChestPosY - PosY)
				if (math.pow((DifPosX), 2) + math.pow((DifPosY), 2)) <= math.pow(TreasureHunt.Distance, 2) then
					Near = true
				end
			end
			if Near then
				Count = Count + 1
				PosX, PosY = TreasureHunt.ChooseSpawn(MapName)
			end
		end
		return PosX, PosY
	end
	TreasureHunt.Summon = function(MapName)
		TreasureHunt.Role.Chest[MapName] = TreasureHunt.Role.Chest[MapName] or {}
		TreasureHunt.Role.Boss[MapName] = TreasureHunt.Role.Boss[MapName] or {}
		for A = 1, TreasureHunt.Count, 1 do
			local PosX, PosY = TreasureHunt.ChooseSpawn(MapName)
			PosX, PosY = TreasureHunt.CheckArea(MapName, PosX, PosY)
			
			local ChestID = TreasureHunt.ID.Chest[math.random(1, #TreasureHunt.ID.Chest)]
			TreasureHunt.Role.Chest[MapName][A] = CreateCha(ChestID, (PosX * 100), (PosY * 100), 145, 86400)
			print(" ("..PosX.."), ("..PosY..")")
			local BossID = TreasureHunt.ID.Boss[math.random(1, #TreasureHunt.ID.Boss)]
			TreasureHunt.Role.Boss[MapName][A] = CreateCha(BossID, (PosX * 100), (PosY * 100), 145, 86400)
		end
	end
	TreasureHunt.Hook.Friendly = function()
		local FuncName = 'is_friend'
		local OriginalFunction = _G[FuncName]
		_G[FuncName] = function(ATKER, DEFER)
			local MapName = GetChaMapName(ATKER)
			if TreasureHunt.Role.Chest[MapName] ~= nil then
				for A = 1, #TreasureHunt.Role.Chest[MapName], 1 do
					if TreasureHunt.Role.Chest[MapName][A] == DEFER and TreasureHunt.CheckAlive(TreasureHunt.Role.Boss[MapName][A]) then
						SystemNotice(ATKER, TreasureHunt.Text.Sealed)
						return LUA_TRUE
					end
				end
			end
			return OriginalFunction(ATKER, DEFER)
		end
	end
	TreasureHunt.Hook.Friendly()