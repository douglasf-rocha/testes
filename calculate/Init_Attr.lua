print( "Loading Init_Attr.lua" )

function Init_attr() 
--LG("init_attr", "enter function initattr : " , "\n" ) 
for i = 0, ATTR_MAX_NUM, 1 do							--³õÊ¼»¯ËùÓÐÊôÐÔ
	SetChaAttrMax( i, 100000000) 
end 
end 

Init_attr() 

SetChaAttrMax( ATTR_LV		,	150			)	-- ½ÇÉ«µÈ¼¶
SetChaAttrMax( ATTR_HP		,	2000000000	)	-- µ±Ç°HP
SetChaAttrMax( ATTR_SP		,	2000000000	)	-- µ±Ç°SP
SetChaAttrMax( ATTR_JOB		,	100			)	-- ½ÇÉ«Ö°Òµ
SetChaAttrMax( ATTR_CEXP		,	4199999999	)	-- µ±Ç°¾­Ñé
SetChaAttrMax( ATTR_NLEXP	,	4200000000	)	-- ÏÂÒ»¼¶ËùÐè¾­Ñé
SetChaAttrMax( ATTR_AP		,	180			)	-- ÊôÐÔµã
SetChaAttrMax( ATTR_TP		,	200			)	-- ¼¼ÄÜµã
SetChaAttrMax( ATTR_GD		,	2000000000	)	-- ½ðÇ®
SetChaAttrMax( ATTR_CLEXP	,	4200000000	)	--µ±Ç°µÈ¼¶µÄ¾­Ñé
SetChaAttrMax( ATTR_MXHP	,	2000000000	)	--×î´óhp
SetChaAttrMax( ATTR_MXSP		,	2000000000	)	--×î´ósp
SetChaAttrMax( ATTR_BSTR		,	100			)	-- »ù±¾Á¦Á¿             
SetChaAttrMax( ATTR_BDEX		,	100			)	-- »ù±¾ÁéÇÉ             
SetChaAttrMax( ATTR_BAGI		,	100			)	-- »ù±¾Ãô½Ý             
SetChaAttrMax( ATTR_BCON	,	100			)	-- »ù±¾ÌåÖÊ             
SetChaAttrMax( ATTR_BSTA		,	100			)	-- »ù±¾¾«Á¦             
SetChaAttrMax( ATTR_BLUK		,	100			)	-- »ù±¾ÐÒÔË             
SetChaAttrMax( ATTR_BMXHP	,	2000000000	)	-- »ù±¾×î´óHP         
SetChaAttrMax( ATTR_BMXSP	,	2000000000	)	-- »ù±¾×î´óSP         
SetChaAttrMax( ATTR_BMNATK	,	9999			)	-- »ù±¾×îÐ¡¹¥»÷Á¦    
SetChaAttrMax( ATTR_BMXATK	,	9999			)	-- »ù±¾×î´ó¹¥»÷Á¦    
SetChaAttrMax( ATTR_BDEF		,	9999			)	-- »ù±¾·ÀÓùÁ¦          
SetChaAttrMax( ATTR_BHIT		,	9999			)	-- »ù±¾ÃüÖÐÂÊ          
SetChaAttrMax( ATTR_BFLEE	,	9999			)	-- »ù±¾ÉÁ±ÜÂÊ          
SetChaAttrMax( ATTR_BMF		,	9999			)	-- »ù±¾Ñ°±¦ÂÊ          
SetChaAttrMax( ATTR_BCRT		,	9999			)	-- »ù±¾±¬»÷ÂÊ          
SetChaAttrMax( ATTR_BHREC	,	9999			)	-- »ù±¾hp»Ö¸´ËÙ¶È   
SetChaAttrMax( ATTR_BSREC	,	9999			)	-- »ù±¾sp»Ö¸´ËÙ¶È    
SetChaAttrMax( ATTR_BASPD	,	9999			)	-- »ù±¾¹¥»÷¼ä¸ô       
SetChaAttrMax( ATTR_BADIS	,	9999			)	-- »ù±¾¹¥»÷¾àÀë       
SetChaAttrMax( ATTR_BMSPD	,	9999			)	-- »ù±¾ÒÆ¶¯ËÙ¶È       
SetChaAttrMax( ATTR_BCOL		,	9999			)	-- »ù±¾×ÊÔ´²É¼¯ËÙ¶È 
SetChaAttrMax( ATTR_MSPD	,	9999			)	--ÒÆ¶¯ËÙ¶È
SetChaAttrMax( ATTR_LHAND_ITEMV	,	9999			)	--×óÊÖµÀ¾ß¼Ó³É
SetChaAttrMax( ATTR_BOAT_SHIP	,	100000			)	--´¬Ö»ID
SetChaAttrMax( ATTR_BOAT_HEADER	,	100000			)	--´¬Í·ÀàÐÍ
SetChaAttrMax( ATTR_BOAT_BODY	,	100000			)	--´¬ÉíÀàÐÍ
SetChaAttrMax( ATTR_BOAT_ENGINE	,	100000			)	--´¬ÒýÇæÀàÐÍ
SetChaAttrMax( ATTR_BOAT_CANNON	,	100000			)	--´¬»ðÅÚÀàÐÍ
SetChaAttrMax( ATTR_BOAT_PART	,	100000			)	-- ´¬Åä¼þÀàÐÍ
SetChaAttrMax( ATTR_BOAT_BERTH	,	100000			)	--´¬Ö»Í£²´¸Û¿Ú
SetChaAttrMax( ATTR_BOAT_DBID	,	2000000000			)	--´¬Ö÷µÄID