//Job Taxi


CreateJoinTaxiPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, -2159.04, 640.36, 1052.38, -1);
	format(strings, sizeof(strings), "[TAXI JOBS]\n{ffffff}Jadilah Pekerja Taxi disini\n{7fff00}/getjob /accept job");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -2159.04, 640.36, 1052.38, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Taxi
}

//Taxi
CMD:taxiduty(playerid, params[])
{
	if(PlayerData[playerid][pJob] == 1 || PlayerData[playerid][pJob2] == 1)
	{
		new modelid = GetVehicleModel(GetPlayerVehicleID(playerid));
		
		if(modelid != 438 && modelid != 420)
			return SendErrorMessage(playerid, "Kamu harus berada didalam Taxi.");
			
		if(PlayerData[playerid][pTaxiDuty] == 0)
		{
			PlayerData[playerid][pTaxiDuty] = 1;
			SetPlayerColor(playerid, COLOR_YELLOW);
			SendClientMessageToAll(COLOR_YELLOW, "[TAXI]"WHITE_E"[ %s sedang On duty ] {ffffff}Gunakan {7fffd4}[ /call 933 ] {ffffff}untuk memanggil taksi", ReturnName(playerid));
		}
		else
		{
			PlayerData[playerid][pTaxiDuty] = 0;
			SetPlayerColor(playerid, COLOR_WHITE);
			SendServerMessage(playerid, "Anda off duty!");
		}
	}
	else return SendErrorMessage(playerid, "Anda bukan pekerja taxi driver.");
	return 1;
}

CheckPassengers(vehicleid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerInAnyVehicle(i))
		{
			if(GetPlayerVehicleID(i) == vehicleid && i != GetVehicleDriver(vehicleid))
			{

				return 1;

			}
		}
	}
	return 0;
}

CMD:fare(playerid, params[])
{
	if(PlayerData[playerid][pTaxiDuty] == 0)
		return SendErrorMessage(playerid, "Anda harus On duty taxi.");
		
	new vehicleid = GetPlayerVehicleID(playerid);
	new modelid = GetVehicleModel(vehicleid);
		
	if(modelid != 438 && modelid != 420)
		return SendErrorMessage(playerid, "Anda harus mengendarai taxi.");
		
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "Anda bukan driver.");
	
	
	if(PlayerData[playerid][pFare] == 0)
	{
		if(CheckPassengers(vehicleid) != 1) return SendErrorMessage(playerid,"Tidak ada penumpang!");
		GetPlayerPos(playerid, Float:PlayerData[playerid][pFareOldX], Float:PlayerData[playerid][pFareOldY], Float:PlayerData[playerid][pFareOldZ]);
		PlayerData[playerid][pFareTimer] = SetTimerEx("FareUpdate", 1000, true, "ii", playerid, GetVehiclePassenger(vehicleid));
		PlayerData[playerid][pFare] = 1;
		PlayerData[playerid][pTotalFare] = 5;
		new formatted[128];
		format(formatted,128,"%s", FormatMoney(PlayerData[playerid][pTotalFare]));
		TextDrawShowForPlayer(playerid, TDEditor_TD[11]);
		TextDrawShowForPlayer(playerid, DPvehfare[playerid]);
		TextDrawSetString(DPvehfare[playerid], formatted);
		SendInfoMessage(playerid, "Anda telah mengaktifkan taxi fare, silahkan menuju ke tempat tujuan!");
		//passanger
		TextDrawShowForPlayer(GetVehiclePassenger(vehicleid), TDEditor_TD[11]);
		TextDrawShowForPlayer(GetVehiclePassenger(vehicleid), DPvehfare[GetVehiclePassenger(vehicleid)]);
		TextDrawSetString(DPvehfare[GetVehiclePassenger(vehicleid)], formatted);
		SendInfoMessage(GetVehiclePassenger(vehicleid), "Taxi fare telah aktif!");
	}
	else
	{
		TextDrawHideForPlayer(playerid, TDEditor_TD[11]);
		TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
		KillTimer(PlayerData[playerid][pFareTimer]);
		SendInfoMessage(playerid, "Anda telah menonaktifkan taxi fare pada total: {00FF00}%s", FormatMoney(PlayerData[playerid][pTotalFare]));
		//passanger
		SendInfoMessage(GetVehiclePassenger(vehicleid), "Taxi fare telah di non aktifkan pada total: {00FF00}%s", FormatMoney(PlayerData[playerid][pTotalFare]));
		TextDrawHideForPlayer(GetVehiclePassenger(vehicleid), TDEditor_TD[11]);
		TextDrawHideForPlayer(GetVehiclePassenger(vehicleid), DPvehfare[GetVehiclePassenger(vehicleid)]);
		PlayerData[playerid][pFare] = 0;
		PlayerData[playerid][pTotalFare] = 0;
	}
	return 1;
}

public:FareUpdate(playerid, passanger)
{	
	new formatted[128];
	GetPlayerPos(playerid,PlayerData[playerid][pFareNewX],PlayerData[playerid][pFareNewY],PlayerData[playerid][pFareNewZ]);
	new Float:totdistance = GetDistance3D(PlayerData[playerid][pFareOldX],PlayerData[playerid][pFareOldY],PlayerData[playerid][pFareOldZ], PlayerData[playerid][pFareNewX],PlayerData[playerid][pFareNewY],PlayerData[playerid][pFareNewZ]);
    if(totdistance > 300.0)
    {
		new argo = RandomEx(20, 100);
	    PlayerData[playerid][pTotalFare] = PlayerData[playerid][pTotalFare]+argo;
		format(formatted,128,"%s", FormatMoney(PlayerData[playerid][pTotalFare]));
		TextDrawShowForPlayer(playerid, DPvehfare[playerid]);
		TextDrawSetString(DPvehfare[playerid], formatted);
		GetPlayerPos(playerid,Float:PlayerData[playerid][pFareOldX],Float:PlayerData[playerid][pFareOldY],Float:PlayerData[playerid][pFareOldZ]);
		//passanger
		TextDrawShowForPlayer(passanger, DPvehfare[passanger]);
		TextDrawSetString(DPvehfare[passanger], formatted);
	}
	return 1;
}
