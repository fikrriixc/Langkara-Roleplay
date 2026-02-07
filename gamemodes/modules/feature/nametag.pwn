// Simple NameTag player's name
// This script build by Fann

#include <YSI_Coding\y_hooks>

NameTag_Reset(playerid)
{
	if(IsValidDynamic3DTextLabel(fannTag[playerid]))
		DestroyDynamic3DTextLabel(fannTag[playerid]);

	fannTag[playerid] = Text3D:-1;
	return 1;
}

NameTag_Config(playerid, bool:use_underscore = false, bool:nametag = false)
{
	new fannstr[128];
	if(PlayerData[playerid][pAdminDuty] && nametag)
	{
		format(fannstr, sizeof(fannstr), PlayerData[playerid][pAdminname]);
	}
	else if(PlayerData[playerid][pMaskOn])
	{
		format(fannstr, sizeof(fannstr), "Mask_#%d", PlayerData[playerid][pMaskID]);
	}
	else
	{
		format(fannstr, sizeof(fannstr), PlayerData[playerid][pName]);
		
		if(!use_underscore) {
			strreplace(fannstr, "_", " ");
		}
	}

	return fannstr;
}

static Float:NameTag_GetDistance(playerid)
{
	new Float:distance = 0.0;
	if(PlayerData[playerid][pAdminDuty])
	{
		distance = 30.0;
	}
	else if(PlayerData[playerid][pMaskOn])
	{
		distance = 10.0;
	}
	else
		distance = 20.0;

	return distance;
}

NameTag_Loading(playerid)
{
	if(serverEnableTag)
	{
		new fannstr[256];
		format(fannstr, sizeof(fannstr), "Fann Loading..");
		fannTag[playerid] = CreateDynamic3DTextLabel(fannstr, COLOR_RED, 0.0, 0.0, 0.30, NameTag_GetDistance(playerid), playerid, INVALID_VEHICLE_ID);
	}
	else
	{
		if(IsValidDynamic3DTextLabel(fannTag[playerid]))
			DestroyDynamic3DTextLabel(fannTag[playerid]);
	}
	return 1;
}

NameTag_Create(playerid)
{
	if(IsValidDynamic3DTextLabel(fannTag[playerid]))
		DestroyDynamic3DTextLabel(fannTag[playerid]);

	new fannstr[256], Float:health, Float:armour;
	GetPlayerHealth(playerid, health);
	GetPlayerArmour(playerid, armour);
	format(fannstr, sizeof(fannstr), "%s\n{ff0000}HP: %.1f {ffffff}| AM: %.1f", NameTag_Config(playerid, true), health, armour);
	fannTag[playerid] = CreateDynamic3DTextLabel(fannstr, GetPlayerColor(playerid), 0.0, 0.0, 0.30, NameTag_GetDistance(playerid), playerid, INVALID_VEHICLE_ID);
	
	PlayerTemp[playerid][temp_nametag] = SetTimerEx("NameTag_Update", 1000, true, "d", playerid);
	return 1;
}

static NameTag_UpdateName(playerid)
{
	if(!IsValidDynamic3DTextLabel(fannTag[playerid]))
		return 1;

	new fannstr[256], Float:health, Float:armour;
	GetPlayerHealth(playerid, health);
	GetPlayerArmour(playerid, armour);
	if(PlayerData[playerid][pAdminDuty]) {
		format(fannstr, sizeof(fannstr), ""RED_E"%s\n"LRED_E"(%s"LRED_E")", PlayerData[playerid][pAdminname], GetStaffRank(playerid));
	} else if(PlayerData[playerid][pInjured]) {
		format(fannstr, sizeof(fannstr), "%s\n"LRED_E"(Injured)", NameTag_Config(playerid, true));
	} else if(PlayerData[playerid][pHoldingFish]) { 
		format(fannstr, sizeof(fannstr), "%s\n{ff0000}HP: %.1f {ffffff}| AM: %.1f\n{ffff00}(Flexing %s)\n", NameTag_Config(playerid, true), health, armour, FishData[playerid][PlayerData[playerid][pFish]][fName]);
	} else {
		format(fannstr, sizeof(fannstr), "%s\n{ff0000}HP: %.1f {ffffff}| AM: %.1f\n", NameTag_Config(playerid, true), health, armour);
	}
	UpdateDynamic3DTextLabelText(fannTag[playerid], GetPlayerColor(playerid), fannstr);
	return 1;
}

public:NameTag_Update(playerid)
{
	if(!PlayerData[playerid][IsLoggedIn] && !PlayerData[playerid][pSpawned])
	{
		NameTag_Reset(playerid);
		KillTimer(PlayerTemp[playerid][temp_nametag]);
		return 0;
	}

	if(!serverEnableTag)
	{
		NameTag_Reset(playerid);
		KillTimer(PlayerTemp[playerid][temp_nametag]);
		return 0;
	}

	NameTag_UpdateName(playerid);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	NameTag_Reset(playerid);
	KillTimer(PlayerTemp[playerid][temp_nametag]);
	return 1;
}