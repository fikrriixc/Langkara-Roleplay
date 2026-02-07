
enum    e_taser
{
	bool: TaserEnabled,
	TaserCountdown,
	GetupTimer,
	TaserUpdate,
	bool: TaserCharged,
	ChargeTimer
};

new
	TaserData[MAX_PLAYERS][e_taser];

LoadTazerSAPD()
{
	for(new i, maxp = MAX_PLAYERS; i <= maxp; ++i)
	{
		if(!IsPlayerConnected(i)) continue;
		TaserData[i][TaserEnabled] = false;
		TaserData[i][TaserCharged] = true;
		TaserData[i][TaserCountdown] = 0;
		TaserData[i][GetupTimer] = -1;
		TaserData[i][ChargeTimer] = -1;

		ApplyAnimation(i, "KNIFE", "null", 0.0, false, false, false, false, 0, SYNC_NONE);
		ApplyAnimation(i, "CRACK", "null", 0.0, false, false, false, false, 0, SYNC_NONE);
	}
}

UnloadTazerSAPD()
{
	for(new i, maxp = MAX_PLAYERS; i <= maxp; ++i)
	{
		if(!IsPlayerConnected(i)) continue;
		if(!TaserData[i][TaserEnabled]) continue;
		RemovePlayerAttachedObject(i, TASER_INDEX);
		DestroyPlayerProgressBar(i, PlayerData[i][activitybar]);
	}
}

ResetVariableTazer(playerid)
{
	TaserData[playerid][TaserEnabled] = false;
	TaserData[playerid][TaserCharged] = true;
	TaserData[playerid][TaserCountdown] = 0;
	TaserData[playerid][GetupTimer] = -1;
	TaserData[playerid][ChargeTimer] = -1;

	ApplyAnimation(playerid, "KNIFE", "null", 0.0, false, false, false, false, 0, SYNC_NONE);
	ApplyAnimation(playerid, "CRACK", "null", 0.0, false, false, false, false, 0, SYNC_NONE);
}

KillTazerTimer(playerid)
{
	if(TaserData[playerid][GetupTimer] != -1)
	{
		KillTimer(TaserData[playerid][GetupTimer]);
		TaserData[playerid][GetupTimer] = -1;
	}

	if(TaserData[playerid][ChargeTimer] != -1)
	{
		KillTimer(TaserData[playerid][ChargeTimer]);
		TaserData[playerid][ChargeTimer] = -1;
	}
}

UpdateTazer(playerid)
{
	if(TaserData[playerid][TaserEnabled] && TaserData[playerid][TaserUpdate] < tickcount())
	{
	    if(GetPlayerWeapon(playerid) == WEAPON_FIST) {
	        SetPlayerAttachedObject(playerid, TASER_INDEX, 18642, 6, 0.0795, 0.015, 0.0295, 180.0, 0.0, 0.0);
	    }else{
	        RemovePlayerAttachedObject(playerid, TASER_INDEX);
	    }

	    TaserData[playerid][TaserUpdate] = tickcount()+100;
	}
}


public:TaserGetUp(playerid)
{
	if(TaserData[playerid][TaserCountdown] > 1) {
	    new string[48];
	    TaserData[playerid][TaserCountdown]--;
		format(string, sizeof(string), "~b~Taser: ~w~%d", TaserData[playerid][TaserCountdown]);
	    InfoTD_MSG(playerid, 1000, string);
	}else if(TaserData[playerid][TaserCountdown] == 1) {
		TogglePlayerControllable(playerid, true);
		ClearAnimations(playerid, SYNC_ALL);
		KillTimer(TaserData[playerid][GetupTimer]);
		TaserData[playerid][GetupTimer] = -1;
		TaserData[playerid][TaserCountdown] = 0;
	    InfoTD_MSG(playerid, 1000,"~w~Taser Effect Clear");
	}

	return 1;
}

public:ChargeUp(playerid)
{
	if(PlayerData[playerid][pActivityTime] >= 100)
	{
		KillTimer(TaserData[playerid][ChargeTimer]);
		TaserData[playerid][TaserCharged] = true;
		PlayerData[playerid][pActivityTime] = 0;
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		SendInfoMessage(playerid, "Taser charged and ready to use.");
		HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	}

	if(PlayerData[playerid][pActivityTime] < 100)
	{
		PlayerData[playerid][pActivityTime] += 20;
		SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
	}
	return 1;
}

CMD:taser(playerid, params[]) return callcmd::tazer(playerid, params);
CMD:tazer(playerid, params[])
{
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT || !PlayerData[playerid][pSpawned])
        return SendErrorMessage(playerid, "You can't use this command right now.");

    if(PlayerData[playerid][pFaction] != 1)
        return SendErrorMessage(playerid, "You must be a police officer.");

    if(!PlayerData[playerid][pOnDuty])
        return SendErrorMessage(playerid, "You must on duty to use tazer.");

    if(!TaserData[playerid][TaserCharged])
		return SendErrorMessage(playerid, "You can't use this command while your taser is charging.");
		
	TaserData[playerid][TaserEnabled] = !TaserData[playerid][TaserEnabled];
	SendInfoMessage(playerid, "SAPD Taser: %s"W".", (TaserData[playerid][TaserEnabled]) ? (""GREEN_E"ON") : (""RED_E"OFF"));

	if(TaserData[playerid][TaserEnabled]) {
		SetPlayerArmedWeapon(playerid, WEAPON_FIST);
		SetPlayerAttachedObject(playerid, TASER_INDEX, 18642, 6, 0.0795, 0.015, 0.0295, 180.0, 0.0, 0.0);
		TaserData[playerid][TaserUpdate] = tickcount()+100;

		SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], 100.0);
	}else{
		RemovePlayerAttachedObject(playerid, TASER_INDEX);
		HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	}
    return 1;
}
