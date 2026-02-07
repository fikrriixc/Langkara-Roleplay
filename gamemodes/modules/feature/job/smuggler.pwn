// SMUGGLER PACKET



CreateJoinSmugglerPoint()
{
    //JOBS
    new strings[128];
    CreateDynamicPickup(1239, 23, 977.34, -771.49, 112.20, -1);
    format(strings, sizeof(strings), "[SMUGGLER JOBS]\n{ffffff}Jadilah Smuggler disini\n{7fffd4}/getjob /accept job");
    CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 977.34, -771.49, 112.20, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // SMUGGLER

    CreateDynamicPickup(1239, 23, 973.71, -764.56, 111.94+0.2, -1);
    format(strings, 128, "{ffffff}Weapon/Packet Delivery Point");
    CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 973.71, -764.56, 112.34, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID);
}

CMD:deliverypacket(playerid, params[])
{
	if(PlayerData[playerid][pJob] != 12 && PlayerData[playerid][pJob2] != 12) return SendErrorMessage(playerid, "You're not Smuggler");

	if(!IsPlayerInRangeOfPoint(playerid, 3.5, 973.71, -764.56, 111.94)) return SendErrorMessage(playerid, "Kamu harus dipoint delivery!");

	if(PlayerData[playerid][pTakePacket] == false) return SendErrorMessage(playerid, "Please Carry the Packet before Delivery the Packet");
	
	InfoTD_MSG(playerid, 3000, "Delivering Packet..");
	ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,false,false,false,false,0,SYNC_ALL);
	new bonus = RandomEx(1000, 5000);
	GivePlayerMoneyEx(playerid, bonus);
	RemovePlayerAttachedObject(playerid, 3);
	SendInfoMessage(playerid, "Successfully Delivery Packet and you get %s", FormatMoney(bonus));

	PlayerData[playerid][pTakePacket] = false;
	return 1;
}

new Float: RandomPacketPos[12][3] =
{
    {-788.65, 1565.19, 26.32},
    {-166.42, 1177.99, 22.15},
    {2428.71, 86.60, 27.05},
    {1270.54, 307.02, 18.73},
    {774.23, -484.35, 16.54},
    {206.32, -102.91, 4.10},
    {-1663.82, 1080.81, 7.13},
    {-2147.69, 1229.76, 33.13},
    {-673.34, 2706.38, 69.97},
    {2354.80, -680.41, 132.14},
    {-1635.92, -2246.49, 30.68},
    {858.25, -18.09, 62.40}
};

IsPacketTaken()
{
    new found = 0;
    foreach(new i : Player)
    {
        if(PlayerData[i][pTakePacket] == true)
        {
            found++;
        }
    }
    if(found) return 1;
    else return 0;
}

public:Readd_Packet(Float:x, Float:y, Float:z)
{

    if(IsValidDynamic3DTextLabel(packetLabel))
        DestroyDynamic3DTextLabel(packetLabel);

    if(IsValidDynamicObject(packetObj))
        DestroyDynamicObject(packetObj), packetObj = INVALID_OBJECT_ID;

    paX = x;
    paY = y;
    paZ = z;
    packetObj = CreateDynamicObject(11745, x, y, z, 0, 0, 0, -1, -1, -1);
    packetLabel = CreateDynamic3DTextLabel("{7fffd4}SMUGGLER PACKET\n{ffffff}Press '{ffff00}N{ffffff}' or Use '{ffff00}/pickuppacket{ffffff}' to pickup", -1, x, y, z+0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
    return 1;
}

public:SmugglerRand()
{
    if(!IsPacketTaken())
    {
        new rand = random(sizeof(RandomPacketPos));
        Readd_Packet(RandomPacketPos[rand][0], RandomPacketPos[rand][1], RandomPacketPos[rand][2]);
        foreach(new p : Player) if(PlayerData[p][pJob] == 12 || PlayerData[p][pJob2] == 12)
        {
            SendClientMessage(p, -1, "{ffff00}[SMUGGLER INFO]{ffffff} Packet has been founded! {ffff00}/trackpacket {ffffff}to track");
        }
    }
}

CMD:trackpacket(playerid)
{
    if(PlayerData[playerid][pJob] != 12 && PlayerData[playerid][pJob2] != 12) return SendErrorMessage(playerid, "You're not Smuggler");
    if(Inventory_Has(playerid, "Handphone") < 1) return SendErrorMessage(playerid, "Anda tidak memiliki Handphone.");

    if(IsAtJob(playerid)) return SendErrorMessage(playerid, "Harap selesaikan Tugas mu untuk ke Checkpoint terlebih dahulu");

    if(PlayerData[playerid][pTrackPacket] >= gettime()) return SendErrorMessage(playerid, "You've must wait %d seconds to track this", PlayerData[playerid][pTrackPacket] - gettime());

    new Float:x, Float:y, Float:z, found;
    foreach(new i : Player)
    {
        if(PlayerData[i][pTakePacket] == true)
        {
            GetPlayerPos(i, x, y, z);
            found++;
        }
    }
    PlayerData[playerid][pCP] = 9;
    if(found)
    {
        SetPlayerCheckpoint(playerid, x, y, z, 3.0);
        SendInfoMessage(playerid, "Packet tracked! Location: {7fff00}%s {ffffff}(STATUS: {ff0000}MOVED{ffffff})", GetLocation(x, y, z));
    }
    else if(paX != 0.0 && paY != 0.0)
    {
        SetPlayerCheckpoint(playerid, paX, paY, paZ, 3.0);
        SendInfoMessage(playerid, "Packet tracked! Location: {7fff00}%s {ffffff}(STATUS: {00ff00}IDLE{ffffff})", GetLocation(paX, paY, paZ));
    }
    else if(paX == 0.0 && paY == 0.0) return SendErrorMessage(playerid, "There's no Packet on City");
    PlayerData[playerid][pTrackPacket] = gettime() + 20;
    return 1;
}

CMD:atrackpacket(playerid)
{
    if(PlayerData[playerid][pAdmin] < 6) return PermissionError(playerid);

    if(IsAtJob(playerid)) return SendErrorMessage(playerid, "Harap selesaikan Tugas mu untuk ke Checkpoint terlebih dahulu");

    new Float:x, Float:y, Float:z, found;
    foreach(new i : Player)
    {
        if(PlayerData[i][pTakePacket] == true)
        {
            GetPlayerPos(i, x, y, z);
            found++;
        }
    }
    PlayerData[playerid][pCP] = 9;
    if(found)
    {
        SetPlayerCheckpoint(playerid, x, y, z, 3.0);
        SendInfoMessage(playerid, "Packet tracked! Location: {7fff00}%s {ffffff}(STATUS: {ff0000}MOVED{ffffff})", GetLocation(x, y, z));
    }
    else if(paX != 0.0 && paY != 0.0)
    {
        SetPlayerCheckpoint(playerid, paX, paY, paZ, 3.0);
        SendInfoMessage(playerid, "Packet tracked! Location: {7fff00}%s {ffffff}(STATUS: {00ff00}IDLE{ffffff})", GetLocation(paX, paY, paZ));
    }
    else if(paX == 0.0 && paY == 0.0) SendErrorMessage(playerid, "There's no Packet on City");
    return 1;
}

CMD:pickuppacket(playerid)
{
    if(PlayerData[playerid][pJob] != 12 && PlayerData[playerid][pJob2] != 12) return SendErrorMessage(playerid, "You're not Smuggler");
    {
        if(!IsPlayerInRangeOfPoint(playerid, 2.0, paX, paY, paZ))
            return SendErrorMessage(playerid, "You're not near Smuggler Packet Position");
            
        if(IsValidDynamic3DTextLabel(packetLabel))
            DestroyDynamic3DTextLabel(packetLabel), packetLabel = Text3D: -1;

        if(IsValidDynamicObject(packetObj))
            DestroyDynamicObject(packetObj), packetObj = INVALID_OBJECT_ID;
        PlayerData[playerid][pTakePacket] = true;
        SetPlayerAttachedObject(playerid, 3, 11745, 6, 0.129999, 0.051000, 0.000000, 103.700004, -64.600059, 0.000000, 0.501999, 1.0, 1.0);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has picked up a Packet.", ReturnName(playerid));
        SendServerMessage(playerid, "You've picked up packet, {ffff00}/deliverypacket {ffffff}on Delivery Point");
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, false, 0, SYNC_ALL);
        InfoTD_MSG(playerid, 4000, "Packet ~g~Picked Up");
        paX = 0.0;
        paY = 0.0;
        paZ = -10.0;
    }
    return 1;
}

CMD:respawnpacket(playerid)
{
    if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

    new rand = random(sizeof(RandomPacketPos));
    Readd_Packet(RandomPacketPos[rand][0], RandomPacketPos[rand][1], RandomPacketPos[rand][2]);
    foreach(new p : Player) if(PlayerData[p][pJob] == 12 || PlayerData[p][pJob2] == 12)
    {   
        SendClientMessage(p, -1, "{ffff00}[SMUGGLER INFO]{ffffff} Packet has been re added! {ffff00}/trackpacket {ffffff}to track");
    }
    SendServerMessage(playerid, "Packet Re ADDED!");
    return 1;
}