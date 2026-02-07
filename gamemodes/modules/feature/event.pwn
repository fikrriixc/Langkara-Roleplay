// TDM

enum e_teamtdm_data
{
    eTempCount,
    eCount,
    eMax,
    eKill
};
new TeamData[2][e_teamtdm_data];

new const Float:TeamPos[2][10][] =
{
    {
        {2797.4746, 2678.2988, 911.8222, 355.4658},
        {2794.9797, 2678.2517, 911.8222, 356.6875},
        {2792.5874, 2678.0920, 911.8222, 357.9032},
        {2790.3376, 2678.4526, 911.8222, 356.3022},
        {2780.7531, 2678.6203, 911.8222, 359.5688},
        {2778.4816, 2678.5075, 911.8222, 356.8942},
        {2776.0187, 2678.4758, 911.8222, 357.8868},
        {2773.5227, 2678.4682, 911.8222, 357.8868},
        {2776.3647, 2674.7031, 911.8222, 356.6304},
        {2786.3842, 2674.4313, 911.8222, 357.8099}
    },
    {
        {2776.0686, 2749.9624, 911.8222, 175.1127},
        {2778.4509, 2749.8735, 911.8222, 176.7931},
        {2780.7128, 2749.7285, 911.8222, 175.0943},
        {2782.9616, 2749.7631, 911.8222, 177.2950},
        {2792.5654, 2749.6250, 911.8222, 177.7401},
        {2794.9177, 2749.4384, 911.8222, 179.3544},
        {2797.4147, 2749.3330, 911.8222, 179.3544},
        {2799.7631, 2749.3420, 911.8222, 179.5831},
        {2805.2617, 2753.0451, 911.8222, 177.2248},
        {2769.9853, 2753.6008, 911.8222, 177.7333}
    }
};

Team_Reset(team)
{
    TeamData[team][eMax] = 10;
    TeamData[team][eCount] = 0;
    TeamData[team][eTempCount] = 0;
    TeamData[team][eKill] = 0;
}

Team_Sync(team = 0)
{
    if(TeamData[team][eTempCount] >= 10)
        TeamData[team][eTempCount] = 0;

    TeamData[team][eTempCount]++;
    return TeamData[team][eTempCount];
}

Team_Get(playerid)
{
    return PlayerTemp[playerid][temp_team];
}

Team_Color(playerid)
{
    new color;
    switch(Team_Get(playerid))
    {
        case 0: color = COLOR_BLUE;
        case 1: color = COLOR_RED;
        default: color = COLOR_WHITE;
    }
    return color;
}

Team_Name(team)
{
    new fanstr[34];
    switch(team)
    {
        case 0: fanstr = "{0000ff}Blue Team{ffffff}";
        case 1: fanstr = "{ff0000}Red Team{ffffff}";
    }
    return fanstr;
}

CMD:tdmhelp(playerid)
{
    if(PlayerData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    new fanstr[5000];
    strcat(fanstr, "Command\tFunction\n");
    strcat(fanstr, "/createtdm\tMembuat event TDM\n");
    strcat(fanstr, "/starttdm\tMemulai event TDM\n");
    strcat(fanstr, "/endtdm\tMengakhiri event TDM\n");
    strcat(fanstr, "/edittdm\tMengubah peraturan event TDM\n");
    strcat(fanstr, "/announceevent\tMemberi pemberitahuan event TDM\n");
    strcat(fanstr, "/locktdm\tMengunci event TDM\n");
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Event TDM Help", fanstr, "Got it", "");
    return 1;
}

CMD:createtdm(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(EventCreated > 1)
    	return SendErrorMessage(playerid, "Event sudah pernah dibuat");

    new time;
    if(sscanf(params, "d", time))
        return SendSyntaxMessage(playerid, "/createtdm [time (minute)]");

    if(time < 0 || time > 60)
        return SendErrorMessage(playerid, "Minimal 1 menit, maksimal 60 menit!");

    SendInfoMessage(playerid, "Event berhasil dibuat, gunakan /tdmhelp");
    EventCreated = 1;
    EventLocked = 1;
    EventTime = 60 * time;
    forex(team, 2) Team_Reset(team);
    return 1;
}

CMD:leavetdm(playerid, params[])
{
	if(IsAtEvent[playerid] == 0)
    	return SendErrorMessage(playerid, "Anda tidak berada di TDM");

    if(IsAtEvent[playerid] == 1 && EventStarted == 1)
    	return SendErrorMessage(playerid, "Anda tidak dapat keluar saat Match Dimulai");

    new tempteam = Team_Get(playerid);
    IsAtEvent[playerid] = 0;
    PlayerTemp[playerid][temp_team] = -1;
    PlayerTemp[playerid][temp_teampos] = -1;
    TeamData[tempteam][eCount]--;
    IsAtEvent[playerid] = 0;
    playerWarnEvent[playerid] = 0;
    SendServerMessage(playerid, "Anda berhasil keluar dari Event TDM");
    ResetPlayerWeaponsEx(playerid);
    SetFactionColor(playerid);
   
    SetPlayerInterior(playerid, PlayerData[playerid][pInt]);
    SetPlayerVirtualWorld(playerid, PlayerData[playerid][pWorld]);
    SetPlayerPositionEx(playerid, PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ], PlayerData[playerid][pPosA], 5000);
    return 1;
}

CMD:starttdm(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(EventCreated < 1)
    	return SendErrorMessage(playerid, "Belum ada event TDM yang sedang dibuat");

    if(EventLocked == 0)
    	return SendErrorMessage(playerid, "Event sudah dibuka");

    if(EventStarted == 1)
    	return SendErrorMessage(playerid, "Event Sedang dimulai");

    if(TeamData[0][eCount] == 0)
    	return SendErrorMessage(playerid, "Suatu Pemain dalam tim biru belum mencukupi");

    if(TeamData[1][eCount] == 0)
    	return SendErrorMessage(playerid, "Suatu Pemain dalam tim merah belum mencukupi");

    Count = 6;
    countTimer = SetTimer("pCountDown", 1000, true);
    EventStarted = 1;

    foreach(new ii : Player)
    {
    	if(IsAtEvent[ii] == 1)
    	{
    		showCD[ii] = 1;
    	}
    }
    return 1;
}

CMD:endtdm(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(EventCreated < 1)
    	return SendErrorMessage(playerid, "Belum ada event TDM yang sedang dibuat");

    EventStarted = 0;
    EventLocked = 1;
    foreach(new ii : Player)
    {
    	if(IsAtEvent[ii] == 1)
    	{
            IsAtEvent[ii] = 0;
            PlayerTemp[ii][temp_team] = -1;
            PlayerTemp[ii][temp_teampos] = -1;
            IsAtEvent[ii] = 0;
            SendServerMessage(ii, "Anda berhasil keluar dari Event TDM");
            ResetPlayerWeaponsEx(ii);
            SetFactionColor(ii);
           
            playerWarnEvent[ii] = 0;
            SetPlayerInterior(ii, PlayerData[ii][pInt]);
            SetPlayerVirtualWorld(ii, PlayerData[ii][pWorld]);
            SetPlayerPositionEx(ii, PlayerData[ii][pPosX], PlayerData[ii][pPosY], PlayerData[ii][pPosZ], PlayerData[ii][pPosA], 5000);
    	}
    }
    forex(team, 2) Team_Reset(team);
    SendServerMessage(playerid, "Berhasil End TDM");
    return 1;
}

CMD:jointdm(playerid, params[])
{
	if(EventCreated < 1)
    	return SendErrorMessage(playerid, "Belum ada event TDM yang sedang dibuat");

    if(EventLocked == 1)
    	return SendErrorMessage(playerid, "Event Belum dibuka");

    if(IsAtEvent[playerid] == 1)
    	return SendErrorMessage(playerid, "Anda sudah berada di TDM");

    if(IsPlayerInAnyVehicle(playerid))
    	return SendErrorMessage(playerid, "Harap turun dari kendaraan sebelum bergabung kedalam Event");

    if(EventStarted == 1)
    	return SendErrorMessage(playerid, "Event Sedang dimulai");

    if(PlayerData[playerid][pSideJob] > 1)
    	return SendErrorMessage(playerid, "Selesaikan terlebih dahulu Pekerjaan mu");

    if(PlayerData[playerid][pOnDuty] > 1)
    	return SendErrorMessage(playerid, "Harap off duty terlebih dahulu");

    if(PlayerData[playerid][pCargoCrate])
        return SendErrorMessage(playerid, "Kamu sedang mengangkat Cargo!");

    forex(i, 13) if(PlayerData[playerid][pGuns][i] != WEAPON_FIST)
        return SendErrorMessage(playerid, "Kamu tidak boleh membawa senjata ke dalam Event!");

    UpdatePlayerData(playerid);
    GetPlayerPos(playerid, PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ]);
    PlayerData[playerid][pPosZ] += 1.0;

    new tempteam = random(2), temppos;
    if(TeamData[tempteam][eCount] >= TeamData[tempteam][eMax])
    {
        switch(tempteam)
        {
            case 0: tempteam = 1;
            case 1: tempteam = 0;
        }

        if(TeamData[tempteam][eCount] >= TeamData[tempteam][eMax])
            return SendErrorMessage(playerid, "Semua team sudah terisi penuh!");
    }

    temppos = Team_Sync(tempteam)-1;
    PlayerTemp[playerid][temp_team] = tempteam;
    PlayerTemp[playerid][temp_teampos] = temppos;
    SetPlayerPosition(playerid, TeamPos[tempteam][temppos][0], TeamPos[tempteam][temppos][1], TeamPos[tempteam][temppos][2], TeamPos[tempteam][temppos][3], 2);
    IsAtEvent[playerid] = 1;
    TeamData[tempteam][eCount]++;
    SetPlayerColor(playerid, Team_Color(playerid));

    SendCustomMessage(playerid, "TDM", "You're in %s Team{ffffff}.", tempteam == 0 ? "{0000ff}Blue" : "{ff0000}Red");

    SetPlayerHealth(playerid, 100);
    TogglePlayerControllable(playerid, false);

    ResetPlayerWeaponsEx(playerid);
    GivePlayerWeaponEx(playerid, WEAPON_DEAGLE, 999999);
    GivePlayerWeaponEx(playerid, WEAPON_SHOTGUN, 999999);
    GivePlayerWeaponEx(playerid, WEAPON_M4, 999999);
    return 1;
}

CMD:edittdm(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(EventCreated < 1)
    	return SendErrorMessage(playerid, "Belum ada event TDM yang sedang dibuat");
		
	new name[64], string[128];
	if(sscanf(params, "s[64]S()[128]", name, string))
    {
        SendSyntaxMessage(playerid, "/edittdm [name] [id/amount]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [maxplayer] [prize] [time]");
        return 1;
    }

    if(!strcmp(name, "prize", true))
    {
    	new health;
        if(sscanf(string, "d", health))
            return SendSyntaxMessage(playerid, "/edittdm [prize] [amount]");

        EventPrize = health;
        SendAdminMessage(COLOR_RED, "%s set Prize tdm to %d.", PlayerData[playerid][pAdminname], health);
    }
    else if(!strcmp(name, "maxplayer", true))
    {
    	new armor;
        if(sscanf(string, "d", armor))
            return SendSyntaxMessage(playerid, "/edittdm [maxplayer] [amount]");

        TeamData[0][eMax] = armor;
        TeamData[1][eMax] = armor;
        SendAdminMessage(COLOR_RED, "%s set maxplayer tdm to %d.", PlayerData[playerid][pAdminname], armor);
    }
    else if(!strcmp(name, "time", true))
    {
        new health;
        if(sscanf(string, "d", health))
            return SendSyntaxMessage(playerid, "/edittdm [time] [minute (1-60)]");

        if(health < 0 || health > 60)
            return SendErrorMessage(playerid, "Minimal 1 menit, maksimal 60 menit!");

        if(EventStarted)
            return SendErrorMessage(playerid, "Event sedang berlangsung!");

        EventTime = 60 * health;
        SendAdminMessage(COLOR_RED, "%s set Time tdm to %d minute.", PlayerData[playerid][pAdminname], health);
    }
    return 1;
}

CMD:announceevent(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(EventCreated < 1)
    	return SendErrorMessage(playerid, "Belum ada event TDM yang sedang dibuat");

    SendClientMessageToAll(-1, "{ffff00}[ANNOUNCEMENT]{7fff00} Event dibuka! /jointdm untuk masuk!");
    return 1;
}

CMD:locktdm(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(EventCreated < 1)
    	return SendErrorMessage(playerid, "Belum ada event TDM yang sedang dibuat");

    if(EventLocked == 1)
    {
    	EventLocked = 0;
    	SendServerMessage(playerid, "Event berhasil dibuka!");
    }
    else if(EventLocked == 0)
    {
    	EventLocked = 1;
    	SendServerMessage(playerid, "Event berhasil dikunci!");
    }
    return 1;
}

public:FannEvent()
{
    new teamwin = -1, teamlose = -1;
    if(EventStarted)
    {
        if(EventTime > 0)
        {
            EventTime--;
            foreach(new playerid : Player) 
            {
                if(IsAtEvent[playerid])
                {
                    GameTextForPlayer(playerid, sprintf("team kill: %d~n~~n~~n~", TeamData[Team_Get(playerid)][eKill]), 3000, 3);
                    InfoTD_MSG(playerid, 2500, sprintf("Time: %s left", (EventTime / 60) > 0 ? sprintf("%d minute(s)", EventTime / 60) : sprintf("%d second(s)", EventTime)));
                }
                
                forex(team, 2) if(TeamData[team][eCount] == 0)
                {
                    teamlose = team;
                    switch(team)
                    {
                        case 0: teamwin = 1;
                        case 1: teamwin = 0;
                    }
                }

                if(teamlose != -1 && teamwin != -1)
                {
                    SendCustomMessage(playerid, "EVENT", "%s is the winner!", Team_Name(teamwin));
                    SendCustomMessage(playerid, "EVENT", "%s is lose, try again later!", Team_Name(teamlose));

                    if(IsAtEvent[playerid])
                    {   
                        if(teamlose != Team_Get(playerid))
                        {
                            SendCustomMessage(playerid, "EVENT", "You guys have win {00ff00}%s{ffffff}!", FormatMoney(EventPrize));
                            GameTextForPlayer(playerid, "You are ~y~winner!", 5000, 3);

                            PlayerData[playerid][pBankMoney] += EventPrize;
                        }
                        else
                            SendCustomMessage(playerid, "EVENT", "Your team is lose, try again later!");
                    }

                    if(PlayerData[playerid][pAdmin] > 0 || PlayerData[playerid][pHelper] > 0)
                    {
                        if(!IsAtEvent[playerid])
                        {
                            if(teamwin == 0 && teamlose == 1)
                            {
                                SendCustomMessage(playerid, "EVENT", "{0000ff}Blue Team{ffffff} is the winner!");
                                SendCustomMessage(playerid, "EVENT", "{ff0000}Red Team{ffffff} is lose!");
                            }
                            else if(teamwin == 1 && teamlose == 0)
                            {
                                SendCustomMessage(playerid, "EVENT", "{ff0000}Red Team{ffffff} is the winner!");
                                SendCustomMessage(playerid, "EVENT", "{0000ff}Blue Team{ffffff} is lose!");
                            }
                            else
                                SendCustomMessage(playerid, "EVENT", "{0000ff}Blue Team{ffffff} and {ff0000}Red Team{ffffff} is draw!");
                        }
                    }
                    if(IsAtEvent[playerid])
                    {
                        SetFactionColor(playerid);
                        playerWarnEvent[playerid] = 0;
                        ResetPlayerWeaponsEx(playerid);
                        SetPlayerInterior(playerid, PlayerData[playerid][pInt]);
                        SetPlayerVirtualWorld(playerid, PlayerData[playerid][pWorld]);
                        SetPlayerPositionEx(playerid, PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ], PlayerData[playerid][pPosA], 5000);

                        PlayerTemp[playerid][temp_team] =
                        PlayerTemp[playerid][temp_teampos] = -1;
                        IsAtEvent[playerid] = 0;
                    }
                    EventStarted = 
                    EventLocked = 
                    EventTime = 0;
                    
                    forex(team, 2) Team_Reset(team);
                    return 1;
                }
            }   

            if(EventTime == 0)
            {
                foreach(new playerid : Player)
                {
                    if(IsAtEvent[playerid])
                    {
                        if(TeamData[0][eKill] > TeamData[1][eKill])
                        {
                            teamwin = 0;
                            teamlose = 1;
                            if(Team_Get(playerid) == 0)
                            {
                                SendCustomMessage(playerid, "EVENT", "{0000ff}Blue Team{ffffff} is the winner!");
                                SendCustomMessage(playerid, "EVENT", "You guys have win {00ff00}%s{ffffff}!", FormatMoney(EventPrize));
                                GameTextForPlayer(playerid, "You are ~y~winner!", 5000, 3);
                                PlayerData[playerid][pBankMoney] += EventPrize;
                            }
                            else
                                SendCustomMessage(playerid, "EVENT", "{ff0000}Red Team{ffffff} is lose, try again later!");
                        }
                        else if(TeamData[0][eKill] < TeamData[1][eKill])
                        {
                            teamwin = 1;
                            teamlose = 0;
                            if(Team_Get(playerid) == 1)
                            {
                                SendCustomMessage(playerid, "EVENT", "{ff0000}Red Team{ffffff} is the winner!");
                                SendCustomMessage(playerid, "EVENT", "You guys have win {00ff00}%s{ffffff}!", FormatMoney(EventPrize));

                                PlayerData[playerid][pBankMoney] += EventPrize;
                            }
                            else
                                SendCustomMessage(playerid, "EVENT", "{0000ff}Blue Team{ffffff} is lose, try again later!");
                        }
                        else if(TeamData[0][eKill] == TeamData[1][eKill])
                        {
                            SendCustomMessage(playerid, "EVENT", "{0000ff}Blue Team{ffffff} and {ff0000}Red Team{ffffff} is draw!");
                            SendCustomMessage(playerid, "EVENT", "You guys have get a half of the prize {00ff00}%s{ffffff}!", FormatMoney(EventPrize/2));
                            PlayerData[playerid][pBankMoney] += EventPrize/2;
                        }
                        SetFactionColor(playerid);
                        playerWarnEvent[playerid] = 0;
                        PlayerTemp[playerid][temp_team] =
                        PlayerTemp[playerid][temp_teampos] = -1;
                        ResetPlayerWeaponsEx(playerid);
                        SetPlayerInterior(playerid, PlayerData[playerid][pInt]);
                        SetPlayerVirtualWorld(playerid, PlayerData[playerid][pWorld]);
                        SetPlayerPositionEx(playerid, PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ], PlayerData[playerid][pPosA], 5000);
                    }
                    
                    if(PlayerData[playerid][pAdmin] > 0 || PlayerData[playerid][pHelper] > 0)
                    {
                        if(!IsAtEvent[playerid])
                        {
                            if(teamwin == 0 && teamlose == 1)
                            {
                                SendCustomMessage(playerid, "EVENT", "{0000ff}Blue Team{ffffff} is the winner!");
                                SendCustomMessage(playerid, "EVENT", "{ff0000}Red Team{ffffff} is lose!");
                            }
                            else if(teamwin == 1 && teamlose == 0)
                            {
                                SendCustomMessage(playerid, "EVENT", "{ff0000}Red Team{ffffff} is the winner!");
                                SendCustomMessage(playerid, "EVENT", "{0000ff}Blue Team{ffffff} is lose!");
                            }
                            else
                                SendCustomMessage(playerid, "EVENT", "{0000ff}Blue Team{ffffff} and {ff0000}Red Team{ffffff} is draw!");
                        }
                    }

                    if(IsAtEvent[playerid])
                        IsAtEvent[playerid] = 0;
                    
                    EventStarted = 
                    EventLocked = 
                    EventTime = 0;
                    forex(team, 2) Team_Reset(team);
                }
            }
        }
    }
    return 1;
}