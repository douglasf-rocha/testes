print("Loading Fortune Tree Disabler!")	
	FortuneTree = FortuneTree or {Text = {}, Hook = {}, ID = {}, Role = {}, Spawn = {}}
	FortuneTree.Text.Sealed = 'Fortune Tree is currently sealed.'
	FortuneTree.Hook.Friendly = function()
		local FuncName = 'is_friend'
		local OriginalFunction = _G[FuncName]
		_G[FuncName] = function(ATKER, DEFER)
			local n_t = GetNowTime()
			local Tree_ID = GetChaTypeID( DEFER )
				if Tree_ID == 778 and n_t == 1 then
--					if n_t == 3 or n_t == 4 or n_t == 5 or n_t == 9 or n_t == 10 or n_t == 11 or n_t == 15 or n_t == 16 or n_t == 17 or n_t == 21 or n_t == 22 or n_t == 23 then
--					if n_t == 1 then
						SystemNotice(ATKER, FortuneTree.Text.Sealed)
						return LUA_TRUE
--					end
				end
			return OriginalFunction(ATKER, DEFER)
		end
	end
	FortuneTree.Hook.Friendly()