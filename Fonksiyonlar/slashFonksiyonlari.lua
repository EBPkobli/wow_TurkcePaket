--Reload yazmama gerek kalmıyor güzel oluyor--
SLASH_RELOADUI1="/rl"
SlashCmdList.RELOADUI=ReloadUI
--Reload yazmama gerek kalmıyor güzel oluyor--

--Bazı frame adlarını ve detaylarını görmek için güzel oluyor--
SLASH_FRAMESTK1="/fs"
SlashCmdList.FRAMESTK=function()
	LoadAddOn('Blizzard_DebugTools')
	FrameStackTooltip_Toggle()
end
--Bazı frame adlarını ve detaylarını görmek için güzel oluyor--

--Kimlik bilgilerini alan Slash Komutu--
SLASH_GUID1="/gd"
SLASH_GUID2="/kimlik"
SlashCmdList.GUID=function()
	local guid, name = UnitGUID("target"), UnitName("target")
	local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
	if(type~="Player")then
		print("NPC kimliği : ".."|cFF0FC0FF"..npc_id);
	else
		print("Oyuncunun kimliğini alamazsınız.")
	end
end
--Kimlik bilgilerini alan Slash Komutu--

SLASH_GOSSIP1="/gs"
SLASH_GOSSIP2="/gossip"
SlashCmdList.GOSSIP=function()
	print(GetGossipText())
end
