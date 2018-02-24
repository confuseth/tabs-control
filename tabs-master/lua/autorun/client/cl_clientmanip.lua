


local Tabs = {
	["#spawnmenu.content_tab"] 			= true,		//Props tab
	["#spawnmenu.category.weapons"]		= true,		//Weapons tab
	["#spawnmenu.category.npcs"]		= true,		//NPCs tab
	["#spawnmenu.category.entities"]	= true,		//Entities tab
	["#spawnmenu.category.vehicles"]	= true,		//Vehicles tab
	["#spawnmenu.category.postprocess"]	= true,		//Postprocessing tab
	["#spawnmenu.category.dupes"]		= true,		//Dupes tab
	["#spawnmenu.category.saves"]		= true		//Saves tab
}


net.Receive("clma_", function()
	Tabs = net.ReadTable()
end)

local function RemoveTabs()
	for k,v in pairs(g_SpawnMenu.CreateMenu:GetItems()) do
		if !Tabs[v.Name] then
			v.Tab:SetVisible(false) else v.Tab:SetVisible(true)
		end
	end
	
end



hook.Add("SpawnMenuOpen", "RemoveClientTabs", RemoveTabs ) 

local Set = {
	["#spawnmenu.content_show"] 		= true,
	["#spawnmenu.context_show"] 		= true,
	["#spawnmenu.admin_view"]			= false,
	["#spawnmenu.admin_view_context"]	= false,
}

net.Receive("clma_b", function()
	Set = net.ReadTable()
	real_groups = net.ReadTable()
end)

local function SpawnMenuRestriction()
	if !Set["#spawnmenu.content_show"] then

		if Set["#spawnmenu.admin_view"] then
			hook.Add("SpawnMenuOpen", "content_block", function()  
				if !real_groups[LocalPlayer():GetNWString("usergroup")] then
		 			return true
	 			else 
	 				return false
	 			end  
		 	end)
	
		elseif !Set["#spawnmenu.admin_view"] then

        	hook.Add("SpawnMenuOpen", "content_block", function() return false end)
		
		end 

	else 
		hook.Remove("SpawnMenuOpen", "content_block")
	end
end

hook.Add("SpawnMenuOpen", "SpawnRestrict", SpawnMenuRestriction)

local function ContextMenuRestriction()
	if !Set["#spawnmenu.context_show"] then
		if Set["#spawnmenu.admin_view_context"] then
			hook.Add("ContextMenuOpen", "context_block", function()  
				if !real_groups[LocalPlayer():GetNWString("usergroup")] then
		 			return true
	 			else 
	 				return false
	 			end  
		 	end)
	
		elseif !Set["#spawnmenu.admin_view_context"] then

        	hook.Add("ContextMenuOpen", "context_block", function() return false end)
		
		end 

	else 
		hook.Remove("ContextMenuOpen", "context_block")
	end
end

hook.Add("ContextMenuOpen", "ContextRestrict", ContextMenuRestriction)