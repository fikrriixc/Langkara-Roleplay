Sidejob_Name(sidejob)
{
	new fanstr[256];
	switch(sidejob)
	{
		case 1: fanstr = "Sweeper";
		case 2: fanstr = "Bus Driver";
		case 3: fanstr = "Forklift";
		default: fanstr = "None";
	}
	return fanstr;
}

Sidejob_Failed(playerid, vehicleid = INVALID_VEHICLE_ID)
{
	if(!IsValidVehicle(vehicleid))
		vehicleid = GetPlayerVehicleID(playerid);
	
	if(PlayerData[playerid][pSideJob] != 0)
	{
		SendInfoMessage(playerid, "Kamu telah gagal sebagai {ffff00}%s{ffffff}!", Sidejob_Name(PlayerData[playerid][pSideJob]));
		PlayerData[playerid][pSideJob] = 0;
		busRouteTaken[GetPVarInt(playerid, "busRoute")] = false;
		SetPVarInt(playerid, "busRoute", -1);
		SetPVarInt(playerid, "busCount", -1);

		sweeperRouteTaken[GetPVarInt(playerid, "sweeperRoute")] = false;
		SetPVarInt(playerid, "sweeperRoute", -1);
		SetPVarInt(playerid, "sweeperCount", -1);

		SetPVarInt(playerid, "forkliftCount", -1);
		SetPVarInt(playerid, "forkliftCountD", 0);

		KillTimer(PlayerTemp[playerid][temp_jobtimer]);
		
		DisablePlayerRaceCheckpoint(playerid);

		forex(fan, sizeof(JobVeh)) if(vehicleid == JobVeh[fan])
		{
			SetVehicleToRespawn(JobVeh[fan]);
			SetVehicleFuel(JobVeh[fan], 100);
		}
	}
	return 1;
}

Sidejob_SuccessMSG(playerid, sidejob)
{
	SendCustomMessage(playerid, "SIDEJOB", "Kamu telah selesai melakukan pekerjaan {ffff00}%s{ffffff}!", Sidejob_Name(sidejob));
	SendCustomMessage(playerid, "SIDEJOB", "Untuk melihat upah yang didapat, gunakan {00ff00}'/salary'{ffffff}.");
	return 1;
}