
StarterQuest = function()
	------------------------------ Quest #1 ------------------------------
	DefineMission(2000, "Adventure Start!", 1, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
	
	MisResultTalk("You've just arrived, correct? What's your name? Alright, please show me your letter. Let's see... from what I can tell, everything seems in order. ")
	MisHelpTalk("")
	MisResultCondition(NoRecord, 31)
	MisResultCondition(HasMission, 31)
	MisResultCondition(HasMission, 1)
	MisResultAction(ClearMission, 31)
	MisResultAction(ClearMission, 1)
	MisResultAction(SetRecord, 31)
	MisResultAction(SetRecord, 1)
--	MisResultAction(LearnSkill, 1)
	MisResultAction(AddExp, 100, 100)
	MisResultAction(AddExpAndType, 2, 300, 300)
	
	MisPrize(MIS_PRIZE_MONEY, 100, 1)
	MisPrize(MIS_PRIZE_ITEM, 15731, 1, 4)
	MisPrizeSelAll()
	------------------------------ Quest #2 ------------------------------
	DefineMission(2001, 'Adventure Start 2', 2001)
	
	MisBeginTalk('Shirley: go speak with a certain wise man named Ronnie which is supposed to help you getting started in the lands of Ascaron.')
	MisBeginCondition(HasRecord, 31)
	MisBeginCondition(NoRecord, 2001)
	MisBeginCondition(NoMission, 2001)
	MisBeginCondition(LvCheck, ">", 1)
	MisBeginAction(AddMission, 2001)
	MisCancelAction(ClearMission, 2001)
		
	MisNeed(MIS_NEED_DESP, 'You must speak with a wise man named Ronnie at <b(2240,2746)>.')
	
	MisHelpTalk('<TextHere>')
	MisResultCondition(AlwaysFailure)
	------------------------------ Quest #2 ------------------------------
	DefineMission(2002, 'Adventure Start 2', 2001, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)

	MisResultTalk('Hello, newcomer you should spend some time getting familiar with your new environment. For starters, you need some basic equipment. Now, open your Inventory by pressing the keys ALT + E and you will find some basic equipment pieces. If you double click an equipment piece such as armor, accessories, and weapons, these will be equipped for use in battle. When you\'re fully equipped and ready, let me know.')
	MisResultCondition(NoRecord, 2001)
	MisResultCondition(HasMission, 2001)
	MisResultAction(ClearMission, 2001)
	MisResultAction(SetRecord, 2001)
	MisResultAction(AddExp, 200, 200)
	MisResultAction(AddExpAndType, 2, 300, 300)
	
	MisPrize(MIS_PRIZE_MONEY, 355, 1)
	MisPrize(MIS_PRIZE_ITEM, 15737, 1, 4)	-- Skill Reset ID?
--	MisPrize(MIS_PRIZE_ITEM, 436, 1, 4)--Newbiew Chest
	MisPrizeSelAll()
	------------------------------ Quest #3 ------------------------------
	DefineMission(2003, 'Adventure Start 3', 2002)

	MisBeginTalk('Hello, newcomer you should spend some time getting familiar with your new environment. For starters, you need some basic equipment. Now, open your Inventory by pressing the keys ALT + E and double click the Welcome Chest to find some basic equipment pieces. If you double click an equipment piece such as armor, accessories, and weapons, these will be equipped for use in battle. When you\'re fully equipped and ready, let me know.')
	MisBeginCondition(LvCheck, ">", 1)
	MisBeginCondition(NoRecord, 2002)
	MisBeginCondition(HasRecord, 2001)
	MisBeginCondition(NoMission, 2002)
	MisBeginAction(AddMission, 2002)
	MisCancelAction(ClearMission, 2002)

	MisResultTalk('I see that you start to get more familiar with the situation but there is much more that you shall learn, so let\'s continue with the basics, you can display your Character Stats with ALT + A. Please Allocate your Status Points as you see fit. If you don\'t know what each attribute does please read the Mouse Hover tooltip. Talk to me when you\'re ready to continue with your journeys.')
	MisHelpTalk('You must speak again with Ronnie at <b(2249,2746)> ')
	MisResultCondition(HasMission, 2002)
	MisResultAction(ClearMission, 2002)
	MisResultAction(SetRecord, 2002)
	MisResultAction(AddExp, 1025, 1025)
	MisResultAction(AddExpAndType, 2, 300, 300)
	
	MisPrize(MIS_PRIZE_MONEY, 437, 1)
	MisPrizeSelAll()
	------------------------------ Quest #4 ------------------------------
	DefineMission(2004, 'Adventure Start 4', 2003)

	MisBeginTalk('I request you to open your Character\'s Skill Window by using the controls ALT + S then you should Drag and Drop all Combo Attacks onto my F1~F12 Hotkeys. When you are done with it, you are supposed to continue your conversation with me and get leads on what you must do next.')
	MisBeginCondition(LvCheck, ">", 2)
	MisBeginCondition(NoRecord, 2003)
	MisBeginCondition(HasRecord, 2002)
	MisBeginCondition(NoMission, 2003)
	MisBeginAction(AddMission, 2003)
	MisCancelAction(ClearMission, 2003)

	MisResultTalk('Great. Now let\'s speak about Skills. Use the controls ALT + S to display your Character Skills. Talk to me again when you\'ve performed this task and you\'re confident about it.')
	MisHelpTalk('You must speak again with Ronnie at <b(2249,2746)> ')
	MisResultCondition(HasMission, 2003)
	MisResultAction(ClearMission, 2003)
	MisResultAction(SetRecord, 2003)
	MisResultAction(AddExp, 1578, 1578)
	MisResultAction(AddExpAndType, 2, 300, 300)
	
	MisPrize(MIS_PRIZE_MONEY, 490, 1)
	MisPrizeSelAll()
	------------------------------ Quest #5 ------------------------------
	DefineMission(2005, 'Adventure Start 5', 2004)

	MisBeginTalk('Whenever you are ready to go on with my tasks you must speak with me.')
	MisBeginCondition(LvCheck, ">", 2)
	MisBeginCondition(NoRecord, 2004)
	MisBeginCondition(HasRecord, 2003)
	MisBeginCondition(NoMission, 2004)
	MisBeginAction(AddMission, 2004)
	MisCancelAction(ClearMission, 2004)

	MisResultTalk('Let\'s start with some minor request, leave Argent City and start your exploration of the Argent Outskirts and come back!')
	MisHelpTalk('Speak with Ronnie at <b(2249,2746)> ')
	MisResultCondition(HasMission, 2004)
	MisResultAction(ClearMission, 2004)
	MisResultAction(SetRecord, 2004)
	MisResultAction(AddExp, 3990, 3990)
	MisResultAction(AddExpAndType, 2, 800, 800)
	
	MisPrize(MIS_PRIZE_MONEY, 50000, 1)
	MisPrizeSelAll()

	------------------------------ Quest #6 ------------------------------
	DefineMission(2006, 'Adventure Start 6', 2005)

	MisBeginTalk('Defeat some of the Mini Bees at <b(2109,2730)> populating the area. They\'ve become quite aggressive lately and must be supressed. When you\'re done, please collect Cuddly Lamb\'s Premium Wools <b(2013,2667)>. I\'ll be waiting for your return.')
	MisBeginCondition(LvCheck, ">", 2)
	MisBeginCondition(NoRecord, 2005)
	MisBeginCondition(HasRecord, 2004)
	MisBeginCondition(NoMission, 2005)
	MisBeginAction(AddMission, 2005)
	MisBeginAction(AddTrigger, 20051, TE_KILL, 206, 40)
	MisBeginAction(AddTrigger, 20052, TE_GETITEM, 15743, 40)
	MisCancelAction(ClearMission, 2005)

	MisNeed(MIS_NEED_KILL, 206, 40, 10, 40)
	MisNeed(MIS_NEED_ITEM, 15743, 40, 20, 40)


	MisResultTalk('I\'m glad that you could handle your own there. Please speak to me when you\'re ready for your next assignment.')
	MisHelpTalk('I must defeat Cuddly Lamb at <b(2013,2667)> and collect 0/40 Precious Wools')
	MisResultCondition(HasMission, 2005)
	MisResultCondition(HasFlag, 2005, 49)
	MisResultCondition(HasItem, 15743, 40)
	MisResultAction(ClearMission, 2005)
	MisResultAction(SetRecord, 2005)
	MisResultAction(TakeItem, 15743, 40)
	MisResultAction(AddExp, 34781, 34781)
	MisResultAction(AddExpAndType, 2, 2231, 2231)
	
	MisPrize(MIS_PRIZE_MONEY, 500000, 1)
	MisPrize(MIS_PRIZE_ITEM, 15085, 1)
	MisPrize(MIS_PRIZE_ITEM, 3088, 1)

	MisPrizeSelAll()

	InitTrigger()
	TriggerCondition(1, IsMonster, 206)	
	TriggerAction(1, AddNextFlag, 2005, 10, 40)
	RegCurTrigger(20051)
	InitTrigger()
	TriggerCondition(1, IsItem, 15743)	
	TriggerAction(1, AddNextFlag, 2005, 20, 40)
	RegCurTrigger(20052)
	------------------------------ Quest #7 ------------------------------
	DefineMission(2007, 'Adventure Start 7', 2006)

	MisBeginTalk('Whenever you are ready to go on with my tasks you must speak with Ronnie. In order to continue you got to level up above level 20.')
	MisBeginCondition(LvCheck, ">", 7)
	MisBeginCondition(NoRecord, 2006)
	MisBeginCondition(HasRecord, 2005)
	MisBeginCondition(NoMission, 2006)
	MisBeginAction(AddMission, 2006)
	MisCancelAction(ClearMission, 2006)

	MisResultTalk('There\'s someone that wants to know you. Please go talk with Ronnie <b(2195,2706)> in Argent City.')
	MisHelpTalk('Speak with Ronnie at <b(2240,2749)> ')
	MisResultCondition(LvCheck, ">", 19)
	MisResultCondition(HasMission, 2006)
	MisResultAction(ClearMission, 2006)
	MisResultAction(SetRecord, 2006)
	MisResultAction(AddExp, 4870, 4870)
	MisResultAction(AddExpAndType, 2, 300, 300)
	
	MisPrize(MIS_PRIZE_MONEY, 1000000, 1)
	MisPrize(MIS_PRIZE_ITEM, 3089, 1)
	MisPrizeSelAll()
	------------------------------ Quest #8 ------------------------------
	DefineMission(2008, 'Adventure Start 8', 2007)
	
	MisBeginTalk('You must return Argent City. It\'s time to relax a bit, When you are ready to continue my journeys you should speak with Salvier.')
	MisBeginCondition(HasRecord, 2006)
	MisBeginCondition(NoRecord, 2007)
	MisBeginCondition(NoMission, 2007)
	MisBeginCondition(LvCheck, ">", 20)
	MisBeginAction(AddMission, 2007)
	MisCancelAction(ClearMission, 2007)
		
	MisNeed(MIS_NEED_DESP, 'You must speak with Saliver at <b(2223,2749)> ')
	
	MisResultCondition(AlwaysFailure)
	------------------------------ Quest #8 ------------------------------
	DefineMission(2009, 'Adventure Start 8', 2007, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MisResultTalk('Oh a new face, welcome! I see I see, you\'re new but I see you\'re doing just fine so far. Ronnie told me about you and I\'ve readied a set of tasks that will help you get the renown you\'re looking for.')
	MisResultCondition(NoRecord, 2007)
	MisResultCondition(HasMission, 2007)
	MisResultAction(ClearMission, 2007)
	MisResultAction(SetRecord, 2007)
	MisResultAction(AddExp, 21140, 21140)
	MisResultAction(AddExpAndType, 2, 300, 300)
	
	MisPrize(MIS_PRIZE_MONEY, 500000, 1)
	MisPrizeSelAll()
	------------------------------ Quest #9 ------------------------------
	DefineMission(2010, 'Adventure Start 9', 2008)

	MisBeginTalk(' I require someone to quell the increase of Angelic Panda at <b(1641,2567)>. They\'ve started to exponentially in a number concerning of townspeople. When you\'re done with this, report your endeavor to me.')
	MisBeginCondition(NoRecord, 2008)
	MisBeginCondition(HasRecord, 2007)
	MisBeginCondition(NoMission, 2008)
	MisBeginAction(AddMission, 2008)
	MisBeginAction(AddTrigger, 20081, TE_KILL, 189, 99)
	MisCancelAction(ClearMission, 2008)

	MisNeed(MIS_NEED_KILL, 189, 99, 10, 99)

	MisResultTalk('You\'ve earned a glorious reward. Here, take this. Whenever you reach LV 36 come back for your next task.')
	MisHelpTalk('You must speak with Saliver at <b(2223,2749)>')
	MisResultCondition(HasMission, 2008)
	MisResultCondition(HasFlag, 2008, 108)
	MisResultAction(ClearMission, 2008)
	MisResultAction(SetRecord, 2008)
	MisResultAction(AddExp, 435470, 435470)
	MisResultAction(AddExpAndType, 2, 3000, 3000)
	
	MisPrize(MIS_PRIZE_MONEY, 1000000, 1)
	MisPrize(MIS_PRIZE_ITEM, 15731, 1, 4)	--	Skill Reset ID?
	MisPrize(MIS_PRIZE_ITEM, 15737, 1, 4)	--	Stat Reset ID? 
	MisPrizeSelAll()

	InitTrigger()
	TriggerCondition(1, IsMonster, 189)	
	TriggerAction(1, AddNextFlag, 2008, 10, 99)
	RegCurTrigger(20081)
	------------------------------ Quest #10 ------------------------------
	DefineMission(2011, 'Adventure Start 10', 2009)

	MisBeginTalk('I\'m having a Situation, please go discuss the matter with Geliya [1910,2810].')
	MisBeginCondition(HasRecord, 2008)
	MisBeginCondition(NoRecord, 2009)
	MisBeginCondition(NoMission, 2009)
	MisBeginCondition(LvCheck, ">", 35)
	MisBeginAction(AddMission, 2009)
	MisCancelAction(ClearMission, 2009)

	MisNeed(MIS_NEED_DESP, 'You must speak with Geliya at <b(1910,2810)>')

	MisResultCondition(AlwaysFailure)
	------------------------------ Quest #10 ------------------------------
	DefineMission(2012, 'Adventure Start 10', 2009, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MisResultTalk('Congratulations on finding me! here is your rewards!')
	MisResultCondition(NoRecord, 2009)
	MisResultCondition(HasMission, 2009)
	MisResultAction(ClearMission, 2009)
	MisResultAction(SetRecord, 2009)
	MisResultAction(AddExp, 36000, 36000)
	MisResultAction(AddExpAndType, 2, 1220, 1220)

	MisPrize(MIS_PRIZE_MONEY, 9999, 1)
	MisPrize(MIS_PRIZE_ITEM, 0333, 1, 4)
	MisPrizeSelAll()
	------------------------------ Quest #11 ------------------------------
	DefineMission(2013, 'Adventure Start 11', 2010)

	MisBeginTalk('Thank you for your concern in our situation. I\'m pleased to see that you\'re having quite some journeys in the lands of Ascaron. Today you can be of an use here.The mines have fallen under control of letal Mud Monsters at <r(1896,2770)> I would like you to help us performing some serious cleaning; worry not, you\'ll be rewarded for your time.')
	MisBeginCondition(NoRecord, 2010)
	MisBeginCondition(HasRecord, 2009)
	MisBeginCondition(NoMission, 2010)
	MisBeginAction(AddMission, 2010)
	MisBeginAction(AddTrigger, 20101, TE_KILL, 253, 99)
	MisCancelAction(ClearMission, 2010)

	MisNeed(MIS_NEED_KILL, 253, 99, 10, 99)

	MisResultTalk('Thank you for your concern in our situation. I\'m pleased to see that you\'re having quite some journeys in the lands of Ascaron. Today you can be of an use here. The mines have fallen under control of letal Mud Monsters [1896,2770] I would like you to help us performing some serious cleaning; worry not, you\'ll be rewarded for your time.')
	MisHelpTalk('You must speak with Geliya at <b(1910,2810)>')
	MisResultCondition(HasMission, 2010)
	MisResultCondition(HasFlag, 2010, 108)
	MisResultAction(ClearMission, 2010)
	MisResultAction(SetRecord, 2010)
	MisResultAction(AddExp, 123000, 123000)
	MisResultAction(AddExpAndType, 2, 2000, 2000)
	
	MisPrize(MIS_PRIZE_MONEY, 1000000, 1)
	MisPrize(MIS_PRIZE_ITEM, 0333, 2, 4)	--	Unique Gem Voucher ID?
	MisPrize(MIS_PRIZE_ITEM, 3090, 1)
	MisPrizeSelAll()
	MisPrizeSelAll()

	InitTrigger()
	TriggerCondition(1, IsMonster, 253)	
	TriggerAction(1, AddNextFlag, 2010, 10, 99)
	RegCurTrigger(20101)
	------------------------------ Quest #12 ------------------------------
	DefineMission(2014, 'Adventure Start 12', 2011)

	MisBeginTalk('You must speak with Geliya at <b(1910,2810)>')
	MisBeginCondition(LvCheck, ">", 35)
	MisBeginCondition(NoRecord, 2011)
	MisBeginCondition(HasRecord, 2010)
	MisBeginCondition(NoMission, 2011)
	MisBeginAction(AddMission, 2011)
	MisCancelAction(ClearMission, 2011)

	MisResultTalk('Thank you for your services')
	MisHelpTalk('You must speak with Geliya at <b(1910,2810)>')
	MisResultCondition(HasMission, 2011)
	MisResultAction(ClearMission, 2011)
	MisResultAction(SetRecord, 2011)
	MisResultAction(AddExp, 14425000, 14425000)
	MisResultAction(AddExpAndType, 2, 12520, 12520)
	
	MisPrize(MIS_PRIZE_MONEY, 2000000, 1)
	MisPrize(MIS_PRIZE_ITEM, 0333, 5, 4)	
	MisPrize(MIS_PRIZE_ITEM, 15085, 2, 4)
	MisPrizeSelAll()
	
	
--- New Random app quest 

	DefineMission(3721, 'Abyss Beast Return', 3721)
	MisBeginTalk('We\'re in danger. A powerful beast has awakened, it must be defeated as soon as possible.You can look for the Abyss Dragon in the chaldea territory. Hurry, there\'s no time to waste!')
	MisBeginCondition(LvCheck, ">", 44)
	MisBeginCondition(NoMission, 3721)
	MisBeginAction(AddMission, 3721)
	MisBeginAction(AddTrigger, 37211, TE_KILL, 765, 99)
	MisCancelAction(ClearMission, 3721)
	
	MisNeed(MIS_NEED_KILL, 765, 99, 10, 99)
	MisResultTalk('Being such a fighter is rare, I shall reward you good!')
	MisHelpTalk('You must defeat Abyss Dragon near X,Y(City)')
	MisResultCondition(HasMission, 3721)
	MisResultCondition(HasFlag, 3721, 108)
	MisResultAction(AddExp, 120000, 120000)
	MisResultAction(AddMoney, 8000, 8000)
	MisResultAction(ClearMission, 3721)
	MisResultBagNeed(1)
	MisPrize(MIS_PRIZE_ITEM, 15085, 1, 4)
	MisPrizeSelAll()

	InitTrigger()
	TriggerCondition(1, IsMonster, 765)	
	TriggerAction(1, AddNextFlag, 3721, 10, 99)
	RegCurTrigger(37211)
	
--Side Quest 2

	DefineMission(3722, 'Wood Log Commerce', 3722)
	
	MisBeginTalk('We\'re in need of Wood Log for ship building, could you please help us gather some?')
	MisBeginCondition(NoMission, 3722)
	MisBeginCondition(LvCheck, ">", 44)
	MisBeginAction(AddMission, 3722)
	MisCancelAction(ClearMission, 3722)

	MisNeed(MIS_NEED_DESP, 'You must gather and deliver Wood Logs to David in Thundoria City Port')

	MisResultCondition(AlwaysFailure)
	
	------------------------------##------------------------------
	
	DefineMission(3723, 'Wood Log Commerce', 3722, COMPLETE_SHOW)
	
--	MisBeginCondition(AlwaysFailure)

	MisBeginAction(AddTrigger, 37221, TE_GETITEM, 3999, 10)


	MisResultTalk('I need one Exotic Wood Log, You can obtain it from me for x495 Ash Wood Logs.')
	MisResultCondition(HasMission, 3722)
	MisResultCondition(HasItem, 3999, 10)
    MisResultAction(TakeItem, 3999, 10)
	MisResultAction(ClearMission, 3722)
	MisResultAction(SetRecord, 3722)
	MisResultAction(AddExp, 140455, 140455)
	
	MisPrize(MIS_PRIZE_MONEY, 18000, 18000)
	MisPrize(MIS_PRIZE_ITEM, 15085, 1, 4)
	MisPrizeSelAll()

	InitTrigger()
	TriggerCondition(1, IsItem, 3999)	
	TriggerAction(1, AddNextFlag, 3722, 10, 10)
	RegCurTrigger(37221)
	
end
StarterQuest()