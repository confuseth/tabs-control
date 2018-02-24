AddCSLuaFile("/client/cl_interface.lua")
AddCSLuaFile("/client/tdlib.lua")
AddCSLuaFile("/client/cl_clientmanip.lua")
if SERVER then
	util.AddNetworkString("aocp_")
	util.AddNetworkString("ntfc_")
	util.AddNetworkString("ntft_")
	util.AddNetworkString("ntfs_")
	util.AddNetworkString("clma_")
	util.AddNetworkString("clma_b")
end



local access = {
	["superadmin"] = true,
	["admin"] = false,
}

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

local Sets = {
	["#spawnmenu.content_show"] 		= true,
	["#spawnmenu.context_show"]			= true,
	["#spawnmenu.admin_view"]			= false,
	["#spawnmenu.admin_view_context"]	= false,
}


local real_groups = real_groups or {}

hook.Add("Initialize", "PostUlib" ,function() 
function Set(t)
  		local r = {}
  		for _, k in ipairs(t) do
  			if r[k] == nil then
    			r[k] = true
    		end
 	 	end
  		return r
	end

	real_groups = Set(table.GetKeys(ULib.ucl.groups))
end)

net.Receive("ntfc_", function(len, ply)
	real_groups = net.ReadTable()
end)

net.Receive("ntft_", function(len, ply)
    Tabs = net.ReadTable()
    net.Start("clma_")
	net.WriteTable(Tabs)
	net.Broadcast()
end)

net.Receive("ntfs_", function(len, ply)
    Sets = net.ReadTable()
    net.Start("clma_b")
    net.WriteTable(Sets)
    net.WriteTable(real_groups)
    net.Broadcast()
end)



local function AdminControl(ply, txt)
	if txt:sub(1,1) == "!" then
	if txt:sub(2,9) == "tabsmenu" then
	if !access[ply:GetNWString("usergroup")] then ply:ChatPrint("You don't have the right rank to do that.") return end	
	net.Start("aocp_")
	net.WriteEntity(ply)
	net.WriteTable(real_groups)
	net.WriteTable(Tabs)
	net.WriteTable(Sets)
	net.Send(ply)
		return ""
	end
	end
end


hook.Add("PlayerSay", "OpenAdminControl", AdminControl )



