
include("tdlib.lua")



local tabsversion = "TabsMenu ver 0.1b"

local function AdminPanel()
	local ply = net.ReadEntity()
	local real_groups = net.ReadTable()
	local Tabs = net.ReadTable()
	local Set = net.ReadTable()

	local panel = TDLib("DFrame")
	panel:SetPos(ScrW()/2 - 400, ScrH()/2 - 300)
	panel:SetSize(800,500)
	panel:SetTitle("")
	panel:SetDraggable( true )
	panel:MakePopup()
	panel:SetDraggable(false)
	panel:ShowCloseButton(false)
	--panel:FadeIn()
	panel:ClearPaint()
		:Background(Color(255,255,255))
		:Outline(Color(0,0,0), 1)


	local button = TDLib("DButton", panel)
	button:SetPos(panel:GetWide() - 105, 5)
	button:SetSize(100, 22)
	button:SetText("")
	button:SetRemove(panel)
	button:ClearPaint()
	button:NetMessage("ntft_", function() net.WriteTable(Tabs) end)
	button:NetMessage("ntfs_", function() net.WriteTable(Set) end)
		:Background(Color(95, 95, 95, 255))
		:Outline(Color(0,0,0))
    	:FadeHover(Color(200, 100, 100))
    	:Text("close", "Trebuchet18")


    local info = TDLib("DPanel", panel)
    info:SetPos(0,3)
    info:SetSize(400, 25)
    info:ClearPaint()
    	 :Text(tabsversion, "Trebuchet18", Color(45, 45, 45), TEXT_ALIGN_LEFT, 5)

	local scrollpanel = TDLib("DScrollPanel", panel)
	scrollpanel:Dock(FILL)
	scrollpanel:ClearPaint()
		:HideVBar()

    --////SHOW SPAWNMENU////--
	local panel_content = scrollpanel:Add("DPanel")
	panel_content:TDLib()
	panel_content:SetSize(panel:GetWide() - 30, 50)
	panel_content:Dock(TOP)
	panel_content:DockMargin(0,10,0,2)
	panel_content:ClearPaint()
		:Material(Material("gui/noicon.png"), Color(255,255,255))
		:Background(Color(5,5,5,10))
		:Outline(Color(0,0,0), 1)
		:FadeHover(Color(200, 100, 100,90))
		:DualText(
			"DISABLE SPAWNMENU",
			"Trebuchet24",
			Color(220,220,220),

			"disables the spawnmenu for all players",
			"Trebuchet18",
			Color(200,200,200),
			TEXT_ALIGN_CENTER
			)
	
	local checkbox_content = TDLib( "DCheckBox", panel_content)
	checkbox_content:SetPos(15, 15 )
	checkbox_content:SetSize(20,20)
	checkbox_content:SetChecked(Set["#spawnmenu.content_show"])
	checkbox_content:ClearPaint()
		:SquareCheckbox(Color(145, 145, 145), Color(255, 255, 255))

    function checkbox_content:OnChange(val)
    	
        if (val) then
            Set["#spawnmenu.content_show"]  = val
            SimpleNoti("enabled spawnmenu")
        else
            Set["#spawnmenu.content_show"]  = val
            SimpleNoti("disabled spawnmenu")
        end
    end

    local panel_context = scrollpanel:Add("DPanel")
	panel_context:TDLib()
	panel_context:SetSize(panel:GetWide() - 30, 50)
	panel_context:Dock(TOP)
	panel_context:DockMargin(0,0,0,10)
	panel_context:ClearPaint()
		:Material(Material("gui/noicon.png"), Color(255,255,255))
		:Background(Color(5,5,5,10))
		:Outline(Color(0,0,0), 1)
		:FadeHover(Color(200, 200, 100,90))
		:DualText(
			"DISABLE CONTEXTMENU",
			"Trebuchet24",
			Color(220,220,220),

			"disables the contextmenu for all players",
			"Trebuchet18",
			Color(200,200,200),
			TEXT_ALIGN_CENTER
			)
	
	local checkbox_context = TDLib( "DCheckBox", panel_context)
	checkbox_context:SetPos(15, 15 )
	checkbox_context:SetSize(20,20)
	checkbox_context:SetChecked(Set["#spawnmenu.context_show"])
	checkbox_context:ClearPaint()
		:SquareCheckbox(Color(145, 145, 145), Color(255, 255, 255))


    function checkbox_context:OnChange(val)
    	
        if (val) then
            Set["#spawnmenu.context_show"]  = val
            SimpleNoti("enabled contextmenu")
        else
            Set["#spawnmenu.context_show"]  = val
            SimpleNoti("disabled contextmenu")
        end
    end

    --/////SPAWNMENU TABS/////--
	local panel_tabs = scrollpanel:Add("DPanel")
	panel_tabs:SetSize(panel:GetWide() , 366)
	panel_tabs:Dock(TOP)
	panel_tabs:DockMargin(0,10,0,10)
	panel_tabs:TDLib()
	panel_tabs:ClearPaint()
		:Background(Color(255,255,255))
		:Outline(Color(0,0,0), 1)
	
	local panel_wep = TDLib("DPanel", panel_tabs)
	panel_wep:SetSize(panel_tabs:GetWide(),50)
	panel_wep:Dock(TOP)
	panel_wep:DockMargin(2,2,2,0)
	panel_wep:ClearPaint()
		:Background(Color(110,110,110))
		:FadeHover(Color(80, 80, 80,200))
		:DualText(
			"HIDE WEAPONS TAB",
			"Trebuchet24",
			Color(220,220,220),

			"hide weapons tab from the spawnmenu",
			"Trebuchet18",
			Color(200,200,200),
			TEXT_ALIGN_CENTER
			)
	local checkbox_wep = TDLib( "DCheckBox", panel_wep)
	checkbox_wep:SetPos(15, 15 )
	checkbox_wep:SetSize(20,20)
	checkbox_wep:SetChecked(Tabs["#spawnmenu.category.weapons"])
	checkbox_wep:ClearPaint()
		:SquareCheckbox(Color(145, 145, 145), Color(255, 255, 255))



	function checkbox_wep:OnChange(val)
		
		if (val) then
			Tabs["#spawnmenu.category.weapons"] = val
			SimpleNoti("weapons-tab is now visible")
		else
			Tabs["#spawnmenu.category.weapons"] = val
			SimpleNoti("weapons-tab is now hidden")
		end
	end

	local panel_npc = TDLib("DPanel", panel_tabs)
	panel_npc:SetSize(panel_tabs:GetWide(),50)
	panel_npc:Dock(TOP)
	panel_npc:DockMargin(2,2,2,0)
	panel_npc:ClearPaint()
		:Background(Color(110,110,110))
		:FadeHover(Color(80, 80, 80,200))
		:DualText(
			"HIDE NPCS TAB",
			"Trebuchet24",
			Color(220,220,220),

			"hide npcs tab from the spawnmenu",
			"Trebuchet18",
			Color(200,200,200),
			TEXT_ALIGN_CENTER
			)
	local checkbox_npc = TDLib( "DCheckBox", panel_npc)
	checkbox_npc:SetPos(15, 15 )
	checkbox_npc:SetSize(20,20)
	checkbox_npc:SetChecked(Tabs["#spawnmenu.category.npcs"])
	checkbox_npc:ClearPaint()
		:SquareCheckbox(Color(145, 145, 145), Color(255, 255, 255))



	function checkbox_npc:OnChange(val)
		if (val) then
			Tabs["#spawnmenu.category.npcs"] = val
			SimpleNoti("npc-tab is now visible")
		else
			Tabs["#spawnmenu.category.npcs"] = val
			SimpleNoti("npc-tab is now hidden")
		end
	end

	local panel_ent = TDLib("DPanel", panel_tabs)
	panel_ent:SetSize(panel_tabs:GetWide(),50)
	panel_ent:Dock(TOP)
	panel_ent:DockMargin(2,2,2,0)
	panel_ent:ClearPaint()
		:Background(Color(110,110,110))
		:FadeHover(Color(80, 80, 80,200))
		:DualText(
			"HIDE ENTITIES TAB",
			"Trebuchet24",
			Color(220,220,220),

			"hide entities tab from the spawnmenu",
			"Trebuchet18",
			Color(200,200,200),
			TEXT_ALIGN_CENTER
			)
	local checkbox_ent = TDLib( "DCheckBox", panel_ent)
	checkbox_ent:SetPos(15, 15 )
	checkbox_ent:SetSize(20,20)
	checkbox_ent:SetChecked(Tabs["#spawnmenu.category.entities"])
	checkbox_ent:ClearPaint()
		:SquareCheckbox(Color(145, 145, 145), Color(255, 255, 255))



	function checkbox_ent:OnChange(val)
		if (val) then
			Tabs["#spawnmenu.category.entities"] = val
			SimpleNoti("entities-tab is now visible")
		else
			Tabs["#spawnmenu.category.entities"] = val
			SimpleNoti("entities-tab is now hidden")
		end
	end


	local panel_veh = TDLib("DPanel", panel_tabs)
	panel_veh:SetSize(panel_tabs:GetWide(),50)
	panel_veh:Dock(TOP)
	panel_veh:DockMargin(2,2,2,0)
	panel_veh:ClearPaint()
		:Background(Color(110,110,110))
		:FadeHover(Color(80, 80, 80,200))
		:DualText(
			"HIDE VEHICLES TAB",
			"Trebuchet24",
			Color(220,220,220),

			"hide vehicles tab from the spawnmenu",
			"Trebuchet18",
			Color(200,200,200),
			TEXT_ALIGN_CENTER
			)
	local checkbox_veh = TDLib( "DCheckBox", panel_veh)
	checkbox_veh:SetPos(15, 15 )
	checkbox_veh:SetSize(20,20)
	checkbox_veh:SetChecked(Tabs["#spawnmenu.category.vehicles"])
	checkbox_veh:ClearPaint()
		:SquareCheckbox(Color(145, 145, 145), Color(255, 255, 255))



	function checkbox_veh:OnChange(val)
		if (val) then
			Tabs["#spawnmenu.category.vehicles"] = val
			SimpleNoti("vehicles-tab is now visible")
		else
			Tabs["#spawnmenu.category.vehicles"] = val
			SimpleNoti("vehicles-tab is no hidden")
		end
	end

	local panel_pp = TDLib("DPanel", panel_tabs)
	panel_pp:SetSize(panel_tabs:GetWide(),50)
	panel_pp:Dock(TOP)
	panel_pp:DockMargin(2,2,2,0)
	panel_pp:ClearPaint()
		:Background(Color(110,110,110))
		:FadeHover(Color(80, 80, 80,200))
		:DualText(
			"HIDE POSTPROCCESSING TAB",
			"Trebuchet24",
			Color(220,220,220),

			"hide post-proccessing tab from the spawnmenu",
			"Trebuchet18",
			Color(200,200,200),
			TEXT_ALIGN_CENTER
			)
	local checkbox_pp = TDLib( "DCheckBox", panel_pp)
	checkbox_pp:SetPos(15, 15 )
	checkbox_pp:SetSize(20,20)
	checkbox_pp:SetChecked(Tabs["#spawnmenu.category.postprocess"])
	checkbox_pp:ClearPaint()
		:SquareCheckbox(Color(145, 145, 145), Color(255, 255, 255))



	function checkbox_pp:OnChange(val)
		if (val) then
			Tabs["#spawnmenu.category.postprocess"] = val
			SimpleNoti("postprocessing-tab is now visible")
		else
			Tabs["#spawnmenu.category.postprocess"] = val
			SimpleNoti("postprocessing-tab is now hidden")
		end
	end

	local panel_dupe = TDLib("DPanel", panel_tabs)
	panel_dupe:SetSize(panel_tabs:GetWide(),50)
	panel_dupe:Dock(TOP)
	panel_dupe:DockMargin(2,2,2,0)
	panel_dupe:ClearPaint()
		:Background(Color(110,110,110))
		:FadeHover(Color(80, 80, 80,200))
		:DualText(
			"HIDE DUPES TAB",
			"Trebuchet24",
			Color(220,220,220),

			"hide dupe tab from the spawnmenu",
			"Trebuchet18",
			Color(200,200,200),
			TEXT_ALIGN_CENTER
			)
	local checkbox_dupe = TDLib( "DCheckBox", panel_dupe)
	checkbox_dupe:SetPos(15, 15 )
	checkbox_dupe:SetSize(20,20)
	checkbox_dupe:SetChecked(Tabs["#spawnmenu.category.dupes"])
	checkbox_dupe:ClearPaint()
		:SquareCheckbox(Color(145, 145, 145), Color(255, 255, 255))



	function checkbox_dupe:OnChange(val)
		if (val) then
			Tabs["#spawnmenu.category.dupes"] = val
			SimpleNoti("dupes-tab is now visible")
		else
			Tabs["#spawnmenu.category.dupes"] = val
			SimpleNoti("dupes-tab is now hidden")
		end
	end

	local panel_saves = TDLib("DPanel", panel_tabs)
	panel_saves:SetSize(panel_tabs:GetWide(),50)
	panel_saves:Dock(TOP)
	panel_saves:DockMargin(2,2,2,0)
	panel_saves:ClearPaint()
		:Background(Color(110,110,110))
		:FadeHover(Color(80, 80, 80,200))
		:DualText(
			"HIDE SAVES TAB",
			"Trebuchet24",
			Color(220,220,220),

			"hide saves tab from the spawnmenu",
			"Trebuchet18",
			Color(200,200,200),
			TEXT_ALIGN_CENTER
			)
	local checkbox_saves = TDLib( "DCheckBox", panel_saves)
	checkbox_saves:SetPos(15, 15 )
	checkbox_saves:SetSize(20,20)
	checkbox_saves:SetChecked(Tabs["#spawnmenu.category.saves"])
	checkbox_saves:ClearPaint()
		:SquareCheckbox(Color(145, 145, 145), Color(255, 255, 255))



	function checkbox_saves:OnChange(val)
		if (val) then
			Tabs["#spawnmenu.category.saves"] = val
			SimpleNoti("saves-tab is now visible")
		else
			Tabs["#spawnmenu.category.saves"] = val
			SimpleNoti("saves-tab is now hidden")
		end
	end



	--////ADMIN SETTINGS////--
	


	local panel_settings = scrollpanel:Add("DPanel")
	panel_settings:SetSize(panel:GetWide() - 30, 300)
	panel_settings:Dock(TOP)
	panel_settings:DockMargin(0,10,0,10)
	panel_settings:TDLib()
	panel_settings:ClearPaint()
		:Background(Color(255,255,255))
		:Outline(Color(0,0,0), 1)

	local panel_left_settings = TDLib("DPanel", panel_settings)
	panel_left_settings:SetSize(panel_settings:GetWide() / 2 + 17  , 300)
	panel_left_settings:Dock(LEFT)
	panel_left_settings:DockMargin(2, 2, 0, 2)
	panel_left_settings:ClearPaint()
		:Background(Color(255,255,255))

	local admin_content = TDLib("DPanel", panel_left_settings)
	admin_content:SetSize(panel_left_settings:GetWide(),50)
	admin_content:Dock(TOP)
	admin_content:DockMargin(0,0,2,0)
	admin_content:ClearPaint()
		:Background(Color(110,110,110))
		:FadeHover(Color(200, 100, 100,200))
		:DualText(
			"RESTRICTED SPAWNMENU",
			"Trebuchet24",
			Color(220,220,220),

			"selected usergroups can view the spawnmenu",
			"Trebuchet18",
			Color(200,200,200),
			TEXT_ALIGN_CENTER
			)
	local checkbox_acontent = TDLib( "DCheckBox", admin_content)
	checkbox_acontent:SetPos(15, 15 )
	checkbox_acontent:SetSize(20,20)
	checkbox_acontent:SetChecked(Set["#spawnmenu.admin_view"])
	checkbox_acontent:ClearPaint()
		:SquareCheckbox(Color(145, 145, 145), Color(255, 255, 255))

	function checkbox_acontent:OnChange(val)
		if (val) then
			Set["#spawnmenu.admin_view"]= val
			SimpleNoti("spawnmenu: group restriction enabled")
		else
			Set["#spawnmenu.admin_view"] = val
			SimpleNoti("spawnmenu: group restriction disabled")
		end
	end
	
	local admin_context = TDLib("DPanel", panel_left_settings)
	admin_context:SetSize(panel_left_settings:GetWide(),50)
	admin_context:Dock(TOP)
	admin_context:DockMargin(0,1,2,0)
	admin_context:ClearPaint()
		:Background(Color(110,110,110))
		:FadeHover(Color(200, 100, 100,200))
		:DualText(
			"RESTRICTED CONTEXT",
			"Trebuchet24",
			Color(220,220,220),

			"selected usergroups can view the contextmenu",
			"Trebuchet18",
			Color(200,200,200),
			TEXT_ALIGN_CENTER
			)
	local checkbox_acontext = TDLib( "DCheckBox", admin_context)
	checkbox_acontext:SetPos(15, 15 )
	checkbox_acontext:SetSize(20,20)
	checkbox_acontext:SetChecked(Set["#spawnmenu.admin_view_context"])
	checkbox_acontext:ClearPaint()
		:SquareCheckbox(Color(145, 145, 145), Color(255, 255, 255))

	function checkbox_acontext:OnChange(val)
		if (val) then
			Set["#spawnmenu.admin_view_context"]= val
			SimpleNoti("contextmenu: group restriction enabled")
		else
			Set["#spawnmenu.admin_view_context"] = val
			SimpleNoti("contextmenu: group restriction disabled")
		end
	end
	

	local panel_right_settings = TDLib("DPanel", panel_settings)
	panel_right_settings:SetSize(panel_settings:GetWide() / 2 , 300)
	panel_right_settings:Dock(RIGHT)
	panel_right_settings:DockMargin(0, 2, 2, 2)
	panel_right_settings:ClearPaint()
		:Background(Color(110,110,110))

	local list = TDLib("DListView", panel_right_settings)
	list:Dock(FILL)
	list:SetMultiSelect(false)
	list:AddColumn("usergroups")
	list:AddColumn("restrictied")
	for k, v in pairs(real_groups) do
		list:AddLine(k, v)
	end

	local varstring = " is no longer being restricted"
	list.OnRowSelected = function(lst, index, pnl)
		real_groups[pnl:GetColumnText(1)] = not real_groups[pnl:GetColumnText(1)]
		list:Clear()

		if (tostring(real_groups[pnl:GetColumnText(1)]) == "true") then 
			varstring = " has been restricted" 
		else 
			varstring = " is no longer being restricted"
		end
		SimpleNoti( pnl:GetColumnText( 1 ) .. varstring)
		

		net.Start("ntfc_")
		net.WriteTable(real_groups)
		net.SendToServer()
		
		for k, v in pairs(real_groups) do
			list:AddLine(k, v)
		end
		
	end
	
end
	

function SimpleNoti(txt)

	local width, height = surface.GetTextSize(txt)
	local noti = TDLib("DPanel")
	noti:SetSize(ScrW(),height )
	noti:Dock(BOTTOM)
	noti:DockMargin(0,0,0,10)
	noti:ClearPaint()
		:Text(txt, "Trebuchet24", Color(255,255,255,255), TEXT_ALIGN_CENTER, 0, 0, Color(255,255,255))
	timer.Simple(5, function() noti:Remove() end)
	
end

net.Receive("aocp_", AdminPanel)



