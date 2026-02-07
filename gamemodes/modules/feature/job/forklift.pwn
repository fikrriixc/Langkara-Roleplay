// Forklift Side Job (Remake)
// by Fann

static tmpobjid[MAX_VEHICLES]; // the box that will attached to forklift

enum e_forklift_data
{
	Float:fPosX,
	Float:fPosY,
	Float:fPosZ,
	bool:fWait
};

new const stock ForkliftRoute[][e_forklift_data] =
{
	{2745.33,-2431.58,13.64,true},
	{2400.02,-2565.49,13.21,true},
	{2752.89,-2392.60,13.64,true},
	{0.0,0.0,0.0,false}
};

Forklift_LoadVehicle()
{
	JobVeh[6] = CreateVehicle(530, 2758.74,-2385.79, 13.64, 177.14, -1, -1, VEHICLE_RESPAWN);
	JobVeh[7] = CreateVehicle(530, 2749.74,-2385.79, 13.64, 177.14, -1, -1, VEHICLE_RESPAWN);
	JobVeh[8] = CreateVehicle(530, 2752.74,-2385.79, 13.64, 177.14, -1, -1, VEHICLE_RESPAWN);
	JobVeh[9] = CreateVehicle(530, 2755.74,-2385.79, 13.64, 177.14, -1, -1, VEHICLE_RESPAWN);
}

Player_InForklift(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	Loop(i, 10, 6) if(vehicleid == JobVeh[i])
		return 1;

	return 0;
}

Player_ForkliftCP(playerid)
{
	new bCount = GetPVarInt(playerid, "forkliftCount");

	if(ForkliftRoute[bCount+1][fPosX] != 0.0 && ForkliftRoute[bCount+1][fPosY] != 0.0 && ForkliftRoute[bCount+1][fPosZ] != 0.0)
	{
		if(ForkliftRoute[bCount][fWait])
		{
			SetPVarInt(playerid, "forkliftCountD", 10);
			GameTextForPlayer(playerid, "%s~n~Wait: 10", 1000, 3, bCount == 0 ? "Memuat Box" : "Meletakkan Box");
			TogglePlayerControllable(playerid, false);

			PlayerTemp[playerid][temp_jobtimer] = SetTimerEx("Forklift_Update", 1000, true, "d", playerid);
			return 1;
		}
		SetPlayerCheckpoint(playerid, ForkliftRoute[bCount+1][fPosX], ForkliftRoute[bCount+1][fPosY], ForkliftRoute[bCount+1][fPosZ], 5.0);
	
		PlayerPlaySound(playerid, SOUND_CHECKPOINT);
		SetPVarInt(playerid, "forkliftCount", bCount+1);
	}
	else
	{
		new TotalSalary;
		TotalSalary = RandomEx(300, 600);
		AddPlayerSalary(playerid, "Forklift (SideJob)", TotalSalary);

		Sidejob_SuccessMSG(playerid, PlayerData[playerid][pSideJob]);
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));

		DisablePlayerRaceCheckpoint(playerid);

		PlayerTemp[playerid][temp_jobtimer] = -1;
		PlayerData[playerid][pSideJob] = 0;
		SetPVarInt(playerid, "forkliftCount", -1);
		SetPVarInt(playerid, "forkliftCountD", 0);
	}
	return 1;
}

public:Forklift_Wait(playerid)
{
	new bCount = GetPVarInt(playerid, "forkliftCount");
	if(IsPlayerInCheckpoint(playerid))
	{
		SetPVarInt(playerid, "forkliftCountD", GetPVarInt(playerid, "forkliftCountD")-1);
		if(GetPVarInt(playerid, "forkliftCountD") != 0)
		{
			GameTextForPlayer(playerid, "%s~n~Wait: %d", 1000, 3, bCount == 0 ? "Memuat Box" : "Meletakkan Box", GetPVarInt(playerid, "forkliftCountD"));
		}
		else
		{
			KillTimer(PlayerTemp[playerid][temp_jobtimer]);
			TogglePlayerControllable(playerid, true);

			if(bCount == 0)
			{
				SendCustomMessage(playerid, "SIDEJOB", "Sekarang letakkan {ffff00}Box{ffffff} pada checkpoint di map!");

				tmpobjid[GetPlayerVehicleID(playerid)] = CreateDynamicObject(1221,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    			AttachDynamicObjectToVehicle(tmpobjid[GetPlayerVehicleID(playerid)], GetPlayerVehicleID(playerid), 0.000, 0.600, 0.399, 0.000, 0.000, 0.000);

				SetPVarInt(playerid, "forkliftCount", bCount+1);
				bCount = GetPVarInt(playerid, "forkliftCount");

				SetPlayerCheckpoint(playerid, ForkliftRoute[bCount][fPosX], ForkliftRoute[bCount][fPosY], ForkliftRoute[bCount][fPosZ], 5.0);
			}
			else
			{
				SetPVarInt(playerid, "forkliftCPCount", GetPVarInt(playerid, "forkliftCPCount")+1);
				DestroyDynamicObject(tmpobjid[GetPlayerVehicleID(playerid)]);

				if(GetPVarInt(playerid, "forkliftCPCount") >= 10)
				{
					SendCustomMessage(playerid, "SIDEJOB", "Simpan {ffff00}Forklift{ffffff} ke tempat parkirnya!");

					SetPVarInt(playerid, "forkliftCount", bCount+1);
					bCount = GetPVarInt(playerid, "forkliftCount");

					SetPlayerCheckpoint(playerid, ForkliftRoute[bCount][fPosX], ForkliftRoute[bCount][fPosY], ForkliftRoute[bCount][fPosZ], 5.0);
				}
				else
				{
					SendCustomMessage(playerid, "SIDEJOB", "Lanjutkan mengambil {ffff00}Box{ffffff}! %d/10", GetPVarInt(playerid, "forkliftCPCount"));

					SetPVarInt(playerid, "forkliftCount", 0);
					bCount = GetPVarInt(playerid, "forkliftCount");

					SetPlayerCheckpoint(playerid, ForkliftRoute[bCount][fPosX], ForkliftRoute[bCount][fPosY], ForkliftRoute[bCount][fPosZ], 5.0);
				}
				PlayerPlaySound(playerid, SOUND_CHECKPOINT);
			}
		}
	}
	else
	{
		KillTimer(PlayerTemp[playerid][temp_jobtimer]);

		SetPVarInt(playerid, "forkliftCountD", 10);
		SetPlayerCheckpoint(playerid, ForkliftRoute[bCount][fPosX], ForkliftRoute[bCount][fPosY], ForkliftRoute[bCount][fPosZ], 5.0);
	}
	return 1;
}