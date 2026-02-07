CMD:acmds(playerid)
{
	if(PlayerData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new line3[2480];
	strcat(line3, ""WHITE_E"Moderator/Admin Commands:"LB2_E"\n\
 	/aduty /a /h /asay /togooc /o /goto /sendto /gethere /freeze /unfreeze /arevive /spec /slap\n\
 	/caps /peject /astats /ostats /acuff /auncuff /jetpack /getip /aka /akaip /jail /unjail\n\
	/kick /banchar /banucp /unban /dveh /respawnjobs /aitems /aject /setvw\n\
	/reports /asks /ans /ar /dr /vmodels /vehname /apv /aveh /gotoveh /getveh /respawnveh /respawnrad");

	if(PlayerData[playerid][pAdmin] > 1)
	{
		strcat(line3, "\n\n"WHITE_E"Admin Junior Commands:"LB2_E"\n\
	 	/sethp /setbone /afuel /agl /clearreports /afix /setskin /akill /ann /cd /settime /setweather /gotows\n\
	    /ojail /oban /owarn /setam /gotoco /gotohouse /gotobisnis /gotodoor /gotolocker /gotogs /banip /unbanip");
	}
	if(PlayerData[playerid][pAdmin] > 2)
	{
		strcat(line3, "\n\n"WHITE_E"Admin Commands:"LB2_E"\n\
		/reloadweap /resetweap /sethbe /setlevel\n\
	 	/createdoor /editdoor /asetcouple");
	}
	if(PlayerData[playerid][pAdmin] > 3)
	{
		strcat(line3, ""WHITE_E"\n\nHead Admin Commands:"LB2_E"\n\
		/setname /setvip /setfaction /setleader /takemoney /takegold /giveweap\n\
		/veh /destroyveh /givemoneyall /setbooster /checkbanned /flip");
	}
	if(PlayerData[playerid][pAdmin] > 4)
	{
		strcat(line3, "\n\n"WHITE_E"Executive Admin Commands:"LB2_E"\n\
		/sethelperlevel /setadminname /setmoney /givemoney /setbankmoney /givebankmoney\n\
		/setmaterial /setcomponent /createpv /destroypv /explode /makequiz /agive /opmmode\n\
		/setcs");
	}
	if(PlayerData[playerid][pAdmin] > 5)
	{
		strcat(line3, "\n\n"WHITE_E"Developer/CEO:"LB2_E"\n\
		/setadminlevel /setgold /givegold /setstock /setprice /createws /editws\n\
		/setpassword /createhouse /edithouse /createbisnis /editbisnis /creatempoint\n\
		/editmpoint /removmpoint /speedlimit /nametag\n\
		/setitem");
	}
 	
	strcat(line3, "\n"LB_E"HP:RP "WHITE_E"- Anti-Cheat is actived.\n\
	"PINK_E"NOTE: All admin commands log is saved in database! | Abuse Commands? Kick And Demote Premanent!.");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Staff Commands", line3, "OK","");
	return true;
}

CMD:arelease(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
        return SendErrorMessage(playerid, "Kamu harus menjadi Admin level 5.");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    SendSyntaxMessage(playerid, "/arelease <ID/Name>");
	    return true;
	}

    if(otherid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player tersebut belum masuk!");

	if(PlayerData[otherid][pArrest] == 0)
	    return SendErrorMessage(playerid, "The player isn't in arrest!");

	PlayerData[otherid][pArrest] = 0;
	PlayerData[otherid][pArrestTime] = 0;
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SetPlayerPositionEx(otherid, 1526.69, -1678.05, 5.89, 267.76, 2000);
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);
	return true;
}

CMD:makequiz(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] > 4)
	{
		new tmp[128], string[256], str[256], pr;
		if(sscanf(params, "s", tmp)) {
			SendSyntaxMessage(playerid, "/makequiz [option]");
			SendSyntaxMessage(playerid, "question, answer, price, end");
			SendInfoMessage(playerid, "Tolong buat jawabannya dulu.");
			return 1;
		}
		if(!strcmp(tmp, "question", true, 8))
		{
			if(sscanf(params, "s[128]s[256]", tmp, str)) return SendSyntaxMessage(playerid, "/makequiz question [question]");
			if (quiz == 1) return SendErrorMessage(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan /makequiz end.");
			if (answermade == 0) return SendErrorMessage(playerid, "tolong buat jawaban dulu...");
			if (qprs == 0) return SendErrorMessage(playerid, "Tolong tambahkan hadiah terlebih dahulu.");
			format(string, sizeof(string), "{7fffd4}[QUIZ]: {ffff00}%s?, Hadiah {00FF00}$%d.", str, qprs);
			SendClientMessageToAll(0xFFFF00FF, string);
			SendClientMessageToAll(-1,"{ffff00}Anda bisa memberi jawaban dengan menggunakan /answer.");
			quiz = 1;
		}
		else if(!strcmp(tmp, "answer", true, 6))
		{
			if(sscanf(params, "s[128]s[256]", tmp, str)) return SendSyntaxMessage(playerid, "/makequiz answer [answer]");
			if (quiz == 1) return SendInfoMessage(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan /makequiz end.");
			answers = str;
			answermade = 1;
			format(string, sizeof(string), "Anda telah membuat jawaban, {00FF00}%s.", str);
			SendClientMessage(playerid, 0xFFFFFFFF, string);
		}
		else if(!strcmp(tmp, "price", true, 5))
		{
			if(sscanf(params, "s[128]d", tmp, pr)) return SendSyntaxMessage(playerid, "/makequiz price [amount]");
			if (quiz == 1) return SendErrorMessage(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan / makequiz end.");
			if (answermade == 0) return SendErrorMessage(playerid, " Membuat jawabannya lebih dulu...");
			if (pr <= 0) return SendErrorMessage(playerid, "buat harga lebih besar dari 0!");
			qprs = pr;
			format(string, sizeof(string), "Anda telah menempatkan {00FF00}%d sebagai jumlah hadiah untuk kuis.", pr);
			SendClientMessage(playerid, 0xFFFFFFFF, string);
		}
		else if(!strcmp(tmp, "end", true, 3))
		{
			if (quiz == 0) return SendErrorMessage(playerid, "Sayangnya tidak ada kuis dari admin server.");
			SendClientMessageToAll(0xFF0000FF, "Sayangnya Admin server telah mengakhiri kuis tersebut.");
			answermade = 0;
			quiz = 0;
			qprs = 0;
			answers = "";
		}
	}
	else return PermissionError(playerid);
	return 1;
}

CMD:answer(playerid, params[])
{
	new tmp[256], string[256];
	if (quiz == 0) return SendErrorMessage(playerid, "Sayangnya tidak ada kuis dari admin server.");
	if (sscanf(params, "s[256]", tmp)) return SendSyntaxMessage(playerid, "/answer [jawaban]");
	if(strcmp(tmp, answers, true)==0)
	{
		GivePlayerMoneyEx(playerid, qprs);
		format(string, sizeof(string), "[QUIZ]: %s telah memberikan jawaban yang benar '%s' dari kuis dan mendapatkan hadiah {00FF00}%d.", ReturnName(playerid), answers, qprs);
		SendClientMessageToAll(0xFFFF00FF, string);
		answermade = 0;
		quiz = 0;
		qprs = 0;
		answers = "";
	}
	else
	{
		SendErrorMessage(playerid,"Jawaban yang salah coba keberuntungan Anda lain kali.");
	}
	return 1;
}

CMD:hcmds(playerid)
{
	if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] == 0)
		return PermissionError(playerid);

	new line3[2480];
	strcat(line3, ""WHITE_E"Junior Helper Commands:"LB2_E"\n\
 	/aduty /h /asay /o /goto /sendto /gethere /freeze /unfreeze\n\
	/kick /slap /caps /acuff /auncuff /reports /ar /dr");

	strcat(line3, "\n\n"WHITE_E"Senior Helper Commands:"LB2_E"\n\
 	/spec /peject /astats /ostats /jetpack\n\
    /jail /unjail");

	strcat(line3, "\n\n"WHITE_E"Head Helper Commands:"LB2_E"\n\
	/respawnsapd /respawnsags /respawnsamd /respawnsana /respawnjobs\n");
 	
	strcat(line3, "\nAnti-Cheat is actived.\n\
	"PINK_E"NOTE: All admin commands log is saved in database! | Abuse Commands? Kick And Demote Premanent!.");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Staff Commands", line3, "OK","");
	return true;
}

CMD:admins(playerid, params[])
{
	new count = 0;

	SendClientMessage(playerid, ARWIN, "[-----------------STAFF ONLINE-----------------]");
	foreach(new i : Player)
	{
		if(strcmp(UcpData[i][uUsername], "Fann"))
		{
			if(PlayerData[i][pAdmin] > 0 || PlayerData[i][pHelper] > 0)
			{
				SendClientMessage(playerid, ARWIN, " (ID: %i) {ffffff}[%s{ffffff}] {ffff00}%s(%s){ffffff}: %s{ffffff}.", i, GetStaffRank(i), PlayerData[i][pName], PlayerData[i][pAdminname], PlayerData[i][pAdminDuty] ? ("{ff0000}AdminDuty") : ("{00ff00}Roleplaying"));
				count++;
			}
		}
	}
	if(!count)
		SendClientMessage(playerid, COLOR_RED, "Tidak ada Administrator yang online saat ini.");
	
	SendClientMessage(playerid, ARWIN, "[---------------------------------------------]");
	return 1;
}

CMD:adminjail(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new count = 0, line3[512];
	foreach(new i:Player)
	{
		if(PlayerData[i][pJail] > 0)
		{
			format(line3, sizeof(line3), "%s\n"WHITE_E"%s(ID: %d) [Jail Time: %d seconds]", line3, PlayerData[i][pName], i, PlayerData[i][pJailTime]);
			count++;
		}
	}
	if(count > 0)
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Jail Player", line3, "Close", "");
	}
	else
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Jail Player", "There are no player in jail!", "Close", "");
	}
	return 1;
}

//---------------------------[ Admin Level 1 ]--------------------
CMD:aduty(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	if(!strcmp(PlayerData[playerid][pAdminname], "None"))
		return SendErrorMessage(playerid, "Kamu harus setting Nama Admin mu!");
	
	if(!PlayerData[playerid][pAdminDuty])
    {
		if(PlayerData[playerid][pAdmin] > 0)
		{
			SetPlayerColor(playerid, COLOR_RED);
			PlayerData[playerid][pAdminDuty] = 1;
			SetPlayerName(playerid, PlayerData[playerid][pAdminname]);
			SendStaffMessage(COLOR_RED, "* %s telah on duty admin.", PlayerData[playerid][pName]);
		}
		else
		{
			SetPlayerColor(playerid, COLOR_GREEN);
			PlayerData[playerid][pAdminDuty] = 1;
			SetPlayerName(playerid, PlayerData[playerid][pAdminname]);
			SendStaffMessage(COLOR_RED, "* %s telah on helper duty.", PlayerData[playerid][pName]);
		}
    }
    else
    {
        if(PlayerData[playerid][pFaction] != -1 && PlayerData[playerid][pOnDuty]) 
            SetFactionColor(playerid);
        else 
            SetPlayerColor(playerid, COLOR_WHITE);
                
        SetPlayerName(playerid, PlayerData[playerid][pName]);
        PlayerData[playerid][pAdminDuty] = 0;
        SendStaffMessage(COLOR_RED, "* %s telah off admin duty.", PlayerData[playerid][pName]);
    }
	return 1;
}

CMD:asay(playerid, params[]) 
{
    new text[225];

    if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] == 0)
			return PermissionError(playerid);

    if(sscanf(params,"s[225]",text))
        return SendSyntaxMessage(playerid, "/asay [text]");
        
    SendClientMessageToAll(COLOR_RED,"{ff0000}**[STAFF]** (%s{ff0000}) "YELLOW_E"%s: "LG_E"%s", GetStaffRank(playerid), PlayerData[playerid][pAdminname], ColouredText(text));
    return 1;
}

CMD:h(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	if(isnull(params))
	{
	    SendSyntaxMessage(playerid, "/h <text>");
	    return true;
	}

    // Decide about multi-line msgs
	new i = -1;
	new line[512];
	if(strlen(params) > 70)
	{
		i = strfind(params, " ", false, 60);
		if(i > 80 || i == -1) i = 70;

		// store the second line text
		line = " ";
		strcat(line, params[i]);

		// delete the rest from msg
		params[i] = EOS;
	}
	new mstr[512];
	format(mstr, sizeof(mstr), "{1e90ff}[Helper Chat] (%s{1e90ff}) "WHITEP_E"%s(%i): {ffffff}%s", GetStaffRank(playerid), PlayerData[playerid][pAdminname], playerid, params);
	foreach(new ii : Player) 
	{
		if(PlayerData[ii][pAdmin] > 0 || PlayerData[ii][pHelper] == 1)
		{
			SendClientMessage(ii, COLOR_LB, mstr);	
		}
	}
	if(i != -1)
	{
		foreach(new ii : Player)
		{
			if(PlayerData[ii][pAdmin] > 0 || PlayerData[ii][pHelper] == 1)
			{
				SendClientMessage(ii, COLOR_LB, line);
			}
		}
	}
	return 1;
}

CMD:a(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	if(isnull(params))
	{
	    SendSyntaxMessage(playerid, "/a <text>");
	    return true;
	}

    // Decide about multi-line msgs
	new i = -1;
	new line[512];
	if(strlen(params) > 70)
	{
		i = strfind(params, " ", false, 60);
		if(i > 80 || i == -1) i = 70;

		// store the second line text
		line = " ";
		strcat(line, params[i]);

		// delete the rest from msg
		params[i] = EOS;
	}
	new mstr[512];
	format(mstr, sizeof(mstr), ""RED_E"[Admin Chat] %s {ffff00}%s(%i): {ffffff}%s", GetStaffRank(playerid), PlayerData[playerid][pAdminname], playerid, params);
	foreach(new ii : Player) 
	{
		if(PlayerData[ii][pAdmin] > 0)
		{
			SendClientMessage(ii, COLOR_LB, mstr);	
		}
	}
	if(i != -1)
	{
		foreach(new ii : Player)
		{
			if(PlayerData[ii][pAdmin] > 0)
			{
				SendClientMessage(ii, COLOR_LB, line);
			}
		}
	}
	return true;
}

CMD:togooc(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
        return PermissionError(playerid);

    if(TogOOC == 0)
    {
        SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s has disabled global OOC chat.", PlayerData[playerid][pAdminname]);
        TogOOC = 1;
    }
    else
    {
        SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s has enabled global OOC chat (DON'T SPAM).", PlayerData[playerid][pAdminname]);
        TogOOC = 0;
    }
    return 1;
}

CMD:o(playerid, params[])
{
    if(TogOOC == 1 && PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 1) 
            return SendErrorMessage(playerid, "An administrator has disabled global OOC chat.");

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/o [global OOC]");

    /*if(PlayerData[playerid][pDisableOOC])
        return SendErrorMessage(playerid, "You must enable OOC chat first.");*/

    if(strlen(params) < 90)
    {
		new rank[60];
		format(rank, sizeof(rank), GetStaffRank(playerid));
		forex(fan, strlen(GetStaffRank(playerid))) if(rank[fan] >= 'A' && rank[fan] <= 'Z')
			rank[fan] = toupper(rank[fan]);

        foreach (new i : Player) if(PlayerData[i][IsLoggedIn] == true && PlayerData[i][pSpawned] == 1)
        {
            if(PlayerData[playerid][pAdmin] > 0) SendClientMessage(i, COLOR_WHITE, "(( {FF0000}[%s] %s{FFFFFF}: %s {FFFFFF}))", rank, PlayerData[playerid][pAdminname], ColouredText(params));
			else if(PlayerData[playerid][pHelper] > 0 && PlayerData[playerid][pAdmin] == 0)
			{
				SendClientMessage(i, COLOR_WHITE, "(( {00FF00}[HELPER] %s{FFFFFF}: %s {FFFFFF}))", PlayerData[playerid][pAdminname], ColouredText(params));
			}
            else
            {
                SendClientMessage(i, COLOR_WHITE, "(( {33FFCC}Player %s{FFFFFF} (%d): %s ))", PlayerData[playerid][pName], playerid, params);
            }
        }
    }
    else
        return SendErrorMessage(playerid, "The text to long, maximum character is 90");

    return 1;
}

CMD:id(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
   		if(PlayerData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
	
	new otherid;
	if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/id [playerid/PartOfName]");
	
	if(!IsPlayerConnected(otherid))
		return SendErrorMessage(playerid, "No player online or name is not found!");
	
	new fanstr[128];
	GetPlayerVersion(playerid, fanstr, sizeof(fanstr));
	SendServerMessage(playerid, "(ID: %d) Name: %s | UCP: %s | Level: %d | PLoss: %d | Ping: %dms | Version: %s | Average FPS: %d", otherid, PlayerData[otherid][pName], UcpData[otherid][uUsername], PlayerData[otherid][pLevel], NetStats_PacketLossPercent(otherid), GetPlayerPing(otherid), fanstr, GetPlayerFPS(otherid));
	return 1;
}

CMD:goto(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
   		if(PlayerData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;
	if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/goto [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
		
	SendPlayerToPlayer(playerid, otherid);
	SendServerMessage(otherid, "%s has been teleported to you.", PlayerData[playerid][pName]);
	SendServerMessage(playerid, "You have teleport to %s position.", PlayerData[otherid][pName]);
	return 1;
}

CMD:sendto(playerid, params[])
{
    static
        type[24],
        string[64],
		otherid;

    if(PlayerData[playerid][pAdmin] < 1)
   		if(PlayerData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

    if(sscanf(params, "us[32]s()[64]", otherid, type, string))
    {
        SendSyntaxMessage(playerid, "/sendto [PlayerID/PartOfName] [name]");
        SendInfoMessage(playerid, "[NAMES]:{FFFFFF} player, vehicle, ls, lv, sf, ooczone");
        return 1;
    }
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(!strcmp(UcpData[otherid][uUsername], "Fann"))
	{
		if(playerid != otherid)
		{
			SendInfoMessage(otherid, "Ada yang ingin ngeteleportmu lohh, wkwk! %s(%d).", PlayerData[playerid][pAdminname], playerid);
			return SendErrorMessage(playerid, "Kerja bagus nak wkwkk!");
		}
	}

	if(!strcmp(type,"ls")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),1482.0356,-1724.5726,13.5469);
        }
        else 
		{
            SetPlayerPosition(otherid,1482.0356,-1724.5726,13.5469,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		SendServerMessage(playerid, "Player %s telah berhasil di teleport", PlayerData[otherid][pName]);
		SendServerMessage(otherid, "Admin %s telah mengirim anda ke teleport spawn", PlayerData[playerid][pAdminname]);
		PlayerData[otherid][pInDoor] = -1;
		PlayerData[otherid][pInHouse] = -1;
		PlayerData[otherid][pInBiz] = -1;
    }
    else if(!strcmp(type,"player"))
    {
    	new otherid2;
    	if(sscanf(string, "u", otherid2))
    		return SendSyntaxMessage(playerid, "/sendto [PlayerID/PartOfName] player [TargetID/PartOfName]");

    	if(!PlayerData[otherid2][IsLoggedIn])
    		return SendErrorMessage(playerid, "Target tidak ada!");

    	SendPlayerToPlayer(otherid, otherid2);
		SendServerMessage(playerid, "Player %s telah berhasil di teleport ke %s.", PlayerData[otherid][pName], PlayerData[otherid2][pName]);
		SendServerMessage(otherid, "Admin %s telah mengirim anda ke posisi %s.", PlayerData[playerid][pAdminname], PlayerData[otherid2][pName]);
    }
    else if(!strcmp(type,"vehicle"))
    {
    	new vehicleid;
    	if(sscanf(string, "d", vehicleid))
    		return SendSyntaxMessage(playerid, "/sendto [PlayerID/PartOfName] vehicle [vehicleid]");

    	if(!IsValidVehicle(vehicleid))
    		return SendErrorMessage(playerid, "Target tidak ada!");

    	new Float:pos[3];
    	if(!GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]))
    		return SendErrorMessage(playerid, "Something went wrong!");

    	SetPlayerPosition(otherid, pos[0], pos[1], pos[2]+3.0, 4.0, GetVehicleInterior(vehicleid));
		SetPlayerVirtualWorld(otherid, GetVehicleVirtualWorld(vehicleid));
		PlayerData[otherid][pInDoor] = -1;
		PlayerData[otherid][pInHouse] = -1;
		PlayerData[otherid][pInBiz] = -1;
		SendServerMessage(playerid, "Player %s telah berhasil di teleport ke %s.", PlayerData[otherid][pName], GetVehicleName(vehicleid));
		SendServerMessage(otherid, "Admin %s telah mengirim anda ke posisi %s.", PlayerData[playerid][pAdminname], GetVehicleName(vehicleid));
    }
    else if(!strcmp(type,"sf")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),-1425.8307,-292.4445,14.1484);
        }
        else 
		{
            SetPlayerPosition(otherid,-1425.8307,-292.4445,14.1484,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		SendServerMessage(playerid, "Player %s telah berhasil di teleport", PlayerData[otherid][pName]);
		SendServerMessage(otherid, "Admin %s telah mengirim anda ke teleport spawn", PlayerData[playerid][pAdminname]);
		PlayerData[otherid][pInDoor] = -1;
		PlayerData[otherid][pInHouse] = -1;
		PlayerData[otherid][pInBiz] = -1;
    }
    else if(!strcmp(type,"lv")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),1686.0118,1448.9471,10.7695);
        }
        else 
		{
            SetPlayerPosition(otherid,1686.0118,1448.9471,10.7695,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		SendServerMessage(playerid, "Player %s telah berhasil di teleport", PlayerData[otherid][pName]);
		SendServerMessage(otherid, "Admin %s telah mengirim anda ke teleport spawn", PlayerData[playerid][pAdminname]);
		PlayerData[otherid][pInDoor] = -1;
		PlayerData[otherid][pInHouse] = -1;
		PlayerData[otherid][pInBiz] = -1;
    }
    else if(!strcmp(type,"ooczone")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		        return SendErrorMessage(playerid, "Pemain tersebut sedang menggunakan kendaraan");

		SetPlayerPosition(otherid,2183.71, -1017.67, 1020.63,750);
		SetPlayerFacingAngle(otherid,179.4088);
		SetPlayerInterior(otherid, 1);
		SetPlayerVirtualWorld(otherid, 0);
		SendServerMessage(playerid, "Player %s telah berhasil di teleport", PlayerData[otherid][pName]);
	    SendServerMessage(otherid, "Admin %s telah mengirim anda ke teleport spawn", PlayerData[playerid][pAdminname]);
		PlayerData[otherid][pInDoor] = 1;
	    PlayerData[otherid][pInHouse] = -1;
		PlayerData[otherid][pInBiz] = -1;
    }
    else
    	SendErrorMessage(playerid, "Invalid type!");

    return 1;
}

CMD:gethere(playerid, params[])
{
    new otherid;

	if(PlayerData[playerid][pAdmin] < 1)
   		if(PlayerData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/gethere [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "The specified user(s) are not connected.");
	
	if(PlayerData[playerid][pSpawned] == 0 || PlayerData[otherid][pSpawned] == 0)
		return SendErrorMessage(playerid, "Player/Target sedang tidak spawn!");
		
	if(PlayerData[playerid][pJail] > 0 || PlayerData[otherid][pJail] > 0)
		return SendErrorMessage(playerid, "Player/Target sedang di jail");
		
	if(PlayerData[playerid][pArrest] > 0 || PlayerData[otherid][pArrest] > 0)
		return SendErrorMessage(playerid, "Player/Target sedang di arrest");

	if(PlayerData[playerid][pAdmin] < PlayerData[otherid][pAdmin] > 0)
		return SendErrorMessage(playerid, "Anda tidak dapat menarik Admin dengan level paling tinggi");

    SendPlayerToPlayer(otherid, playerid);

    SendServerMessage(playerid, "Anda menarik %s.", PlayerData[otherid][pName]);
    SendServerMessage(otherid, "%s telah menarik mu.", PlayerData[playerid][pName]);
    return 1;
}

CMD:freeze(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
   		if(PlayerData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/freeze [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(!strcmp(UcpData[otherid][uUsername], "Fann"))
	{
		if(playerid != otherid)
		{
			SendInfoMessage(otherid, "Ada yang ingin melakukan freeze padamu lohh, wkwk! %s(%d).", PlayerData[playerid][pAdminname], playerid);
			return SendErrorMessage(playerid, "Kerja bagus nak wkwkk!");
		}
	}

    PlayerData[playerid][pFreeze] = 1;

    TogglePlayerControllable(otherid, false);
    SendServerMessage(playerid, "You have frozen %s's movements.", ReturnName(otherid));
	SendServerMessage(otherid, "You have been frozen movements by admin %s.", PlayerData[playerid][pAdminname]);
    return 1;
}

CMD:unfreeze(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
   		if(PlayerData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/unfreeze [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    PlayerData[playerid][pFreeze] = 0;

    TogglePlayerControllable(otherid, true);
    SendServerMessage(playerid, "You have unfrozen %s's movements.", ReturnName(otherid));
	SendServerMessage(otherid, "You have been unfrozen movements by admin %s.", PlayerData[playerid][pAdminname]);
    return 1;
}

CMD:arevive(playerid, params[])
{

    if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] < 2)
     		return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/arevive [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(!PlayerData[otherid][pInjured])
        return SendErrorMessage(playerid, "Tidak bisa revive karena tidak injured.");

    SetPlayerHealthEx(otherid, 100.0);
    PlayerData[otherid][pInjured] = 0;
	PlayerData[otherid][pHospital] = 0;
	PlayerData[otherid][pSick] = 0;

    ClearAnimations(otherid);
    SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

    if(strcmp(UcpData[playerid][uUsername], "Fann"))
    {
    	SendInfoMessage(otherid, "Staff %s has revived your character.", PlayerData[playerid][pAdminname]);
    	SendStaffMessage(COLOR_RED, "Staff %s have revived player %s.", PlayerData[playerid][pAdminname], ReturnName(otherid));
    }
    return 1;
}

CMD:spec(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] < 2)
			return PermissionError(playerid);

    if(!isnull(params) && !strcmp(params, "off", true))
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
            return SendErrorMessage(playerid, "You are not spectating any player.");

		PlayerData[PlayerData[playerid][pSpec]][playerSpectated]--;
        PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);
        PlayerSpectateVehicle(playerid, INVALID_VEHICLE_ID);

        SetSpawnInfo(playerid, 0, PlayerData[playerid][pSkin], PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ], PlayerData[playerid][pPosA], WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);
        TogglePlayerSpectating(playerid, false);
		PlayerData[playerid][pSpec] = -1;

        return SendServerMessage(playerid, "You are no longer in spectator mode.");
    }
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/spectate [playerid/PartOfName] - Type '/spec off' to stop spectating.");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
		
	if(otherid == playerid)
		return SendErrorMessage(playerid, "You can't spectate yourself bro..");

    if(PlayerData[playerid][pAdmin] < PlayerData[otherid][pAdmin])
        return SendErrorMessage(playerid, "You can't spectate admin higher than you.");
		
	if(PlayerData[otherid][pSpawned] == 0)
	{
	    SendErrorMessage(playerid, "%s(%i) isn't spawned!", PlayerData[otherid][pName], otherid);
	    return true;
	}

    if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
    {
        GetPlayerPos(playerid, PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ]);
        GetPlayerFacingAngle(playerid, PlayerData[playerid][pPosA]);

        PlayerData[playerid][pInt] = GetPlayerInterior(playerid);
        PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
    }
    SetPlayerInterior(playerid, GetPlayerInterior(otherid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(otherid));

    TogglePlayerSpectating(playerid, true);

    if(IsPlayerInAnyVehicle(otherid))
	{
		new vehicleid = GetPlayerVehicleID(otherid);
        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(otherid));
		if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER)
	    {
	    	SendServerMessage(playerid, "You are now spectating %s(%i) who is driving a %s(%d).", PlayerData[otherid][pName], otherid, GetVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
		}
		else
		{
		    SendServerMessage(playerid, "You are now spectating %s(%i) who is a passenger in %s(%d).", PlayerData[otherid][pName], otherid, GetVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
		}
	}
    else
	{
        PlayerSpectatePlayer(playerid, otherid);
	}
	PlayerData[otherid][playerSpectated]++;
	if(strcmp(UcpData[playerid][uUsername], "Fann"))
    	SendStaffMessage(COLOR_RED, "%s now spectating %s (ID: %d).", PlayerData[playerid][pAdminname], PlayerData[otherid][pName], otherid);
    
    SendServerMessage(playerid, "You are now spectating %s (ID: %d).", PlayerData[otherid][pName], otherid);
    PlayerData[playerid][pSpec] = otherid;
    return 1;
}

CMD:slap(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new Float:POS[3], otherid;
	if(sscanf(params, "u", otherid))
	{
	    SendSyntaxMessage(playerid, "/slap <ID>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(!strcmp(UcpData[otherid][uUsername], "Fann"))
	{
		if(playerid != otherid)
		{
			SendInfoMessage(otherid, "Ada yang ingin melakukan slap padamu lohh, wkwk! %s(%d).", PlayerData[playerid][pAdminname], playerid);
			return SendErrorMessage(playerid, "Kerja bagus nak wkwkk!");
		}
	}

	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	SetPlayerPos(otherid, POS[0], POS[1], POS[2] + 9.0);
	if(IsPlayerInAnyVehicle(otherid)) 
	{
		RemovePlayerFromVehicle(otherid);
		//OnPlayerExitVehicle(otherid, GetPlayerVehicleID(otherid));
	}
	SendStaffMessage(COLOR_RED, "Admin %s telah men-slap player %s", PlayerData[playerid][pAdminname], PlayerData[otherid][pName]);

	PlayerPlaySound(otherid, 1130, 0.0, 0.0, 0.0);
	return 1;
}

CMD:caps(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new otherid;
 	if(sscanf(params, "u", otherid))
	{
	    SendSyntaxMessage(playerid, "/caps <ID>");
	    SendInfoMessage(playerid, "Function: Will disable caps for the player, type again to enable caps.");
	    return 1;
	}
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

	if(!GetPVarType(otherid, "Caps"))
	{
	    // Disable Caps
	    SetPVarInt(otherid, "Caps", 1);
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah menon-aktifkan anti caps kepada player %s", PlayerData[playerid][pAdminname], PlayerData[playerid][pName]);
	}
	else
	{
	    // Enable Caps
		DeletePVar(otherid, "Caps");
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah meng-aktifkan anti caps kepada player %s", PlayerData[playerid][pAdminname], PlayerData[playerid][pName]);
	}
	return 1;
}

CMD:peject(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] < 2)
			return PermissionError(playerid);
	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    SendSyntaxMessage(playerid, "/peject <ID>");
	    return 1;
	}

	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

	if(!IsPlayerInAnyVehicle(otherid))
	{
		SendErrorMessage(playerid, "Player tersebut tidak berada dalam kendaraan!");
		return 1;
	}

	new vv = GetVehicleModel(GetPlayerVehicleID(otherid));
	SendServerMessage(playerid, "You have successfully ejected %s(%i) from their %s.", PlayerData[otherid][pName], otherid, GetVehicleModelName(vv - 400));
	SendServerMessage(otherid, "%s(%i) has ejected you from your %s.", PlayerData[playerid][pName], playerid, GetVehicleModelName(vv));
	RemovePlayerFromVehicle(otherid);
	return 1;
}

CMD:astats(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] < 2)
			return PermissionError(playerid);
	new otherid;
	if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/check [playerid/PartOfName]");
		
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

	if(PlayerData[otherid][IsLoggedIn] == false)
        return SendErrorMessage(playerid, "That player is not logged in yet.");

	DisplayStats(playerid, otherid);
	return 1;
}

CMD:ostats(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] < 2)
			return PermissionError(playerid);
			
	new name[24], PlayerName[24];
	if(sscanf(params, "s[24]", name))
	{
	    SendSyntaxMessage(playerid, "/ostats <player name>");
 		return 1;
 	}

 	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

		if(!strcmp(PlayerName, name, true))
		{
			SendErrorMessage(playerid, "Player is online, you can use /stats on them.");
	  		return 1;
	  	}
	}

	// Load User Data
    new cVar[500];
    new cQuery[600];

	strcat(cVar, "email,admin,helper,level,levelup,vip,vip_time,gold,reg_date,last_login,money,bmoney,brek,hours,minutes,seconds,");
	strcat(cVar, "gender,age,faction,family,warn,job,job2,interior,world");

	mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT %s FROM players WHERE username='%e' LIMIT 1", cVar, name);
	mysql_tquery(g_SQL, cQuery, "LoadStats", "is", playerid, name);
	return true;
}

CMD:acuff(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
   		if(PlayerData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid, mstr[128];		
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/acuff [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    //if(otherid == playerid)
        //return SendErrorMessage(playerid, "You cannot handcuff yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "You must be near this player.");

    if(GetPlayerState(otherid) != PLAYER_STATE_ONFOOT)
        return SendErrorMessage(playerid, "The player must be onfoot before you can cuff them.");

    if(PlayerData[otherid][pCuffed])
        return SendErrorMessage(playerid, "The player is already cuffed at the moment.");

    PlayerData[otherid][pCuffed] = 1;
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_CUFFED);

    format(mstr, sizeof(mstr), "You've been ~r~cuffed~w~ by %s.", PlayerData[playerid][pName]);
    InfoTD_MSG(otherid, 3500, mstr);

    SendServerMessage(playerid, "Player %s telah berhasil di cuffed.", PlayerData[otherid][pName]);
    SendServerMessage(otherid, "Admin %s telah mengcuffed anda.", PlayerData[playerid][pName]);
    return 1;
}

CMD:auncuff(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
   		if(PlayerData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;		
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/auncuff [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    //if(otherid == playerid)
        //return SendErrorMessage(playerid, "You cannot uncuff yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "You must be near this player.");

    if(!PlayerData[otherid][pCuffed])
        return SendErrorMessage(playerid, "The player is not cuffed at the moment.");

    static
        string[64];

    PlayerData[otherid][pCuffed] = 0;
    SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

    format(string, sizeof(string), "You've been ~g~uncuffed~w~ by %s.", PlayerData[playerid][pName]);
    InfoTD_MSG(otherid, 3500, string);
	SendServerMessage(playerid, "Player %s telah berhasil uncuffed.", PlayerData[otherid][pName]);
    SendServerMessage(otherid, "Admin %s telah uncuffed tangan anda.", PlayerData[playerid][pName]);
    return 1;
}

CMD:jetpack(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
   		if(PlayerData[playerid][pHelper] < 2)
     		return PermissionError(playerid);
			
	new otherid;		
    if(sscanf(params, "u", otherid))
    {
        playerJetpack[playerid] = true;
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    }
    else
    {
        playerJetpack[otherid] = true;
        SetPlayerSpecialAction(otherid, SPECIAL_ACTION_USEJETPACK);
        SendServerMessage(playerid, "You have spawned a jetpack for %s.", PlayerData[otherid][pName]);
    }
    return 1;
}

CMD:getip(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);
		
	new otherid, PlayerIP[16], giveplayer[24];
	if(sscanf(params, "u", otherid))
 	{
  		SendSyntaxMessage(playerid, "/getip <ID>");
		return 1;
	}
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
		
	if(PlayerData[otherid][pAdmin] == 5)
 	{
  		SendErrorMessage(playerid, "You can't get the server owners ip!");
  		SendServerMessage(otherid, "%s(%i) tried to get your IP!", PlayerData[playerid][pName], playerid);
  		return 1;
    }
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

	SendServerMessage(playerid, "%s(%i)'s IP: %s", giveplayer, otherid, PlayerIP);
	return 1;
}

CMD:aka(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);
	new otherid, PlayerIP[16], query[128];
	if(sscanf(params, "u", otherid))
	{
	    SendSyntaxMessage(playerid, "/aka <ID/Name>");
	    return true;
	}
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
		
	if(PlayerData[otherid][pAdmin] == 5)
 	{
  		SendErrorMessage(playerid, "You can't AKA the server owner!");
  		SendServerMessage(otherid, "%s(%i) tried to AKA you!", PlayerData[playerid][pName], playerid);
  		return 1;
    }
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE IP='%s'", PlayerIP);
	mysql_tquery(g_SQL, query, "CheckPlayerIP", "is", playerid, PlayerIP);
	return true;
}

CMD:akaip(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);
	new query[128];
	if(isnull(params))
	{
	    SendSyntaxMessage(playerid, "/akaip <IP>");
		return true;
	}

	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE IP='%s'", params);
	mysql_tquery(g_SQL, query, "CheckPlayerIP2", "is", playerid, params);
	return true;
}

CMD:vmodels(playerid, params[])
{
    new string[3500];

    if(PlayerData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);

    for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
    {
        format(string,sizeof(string), "%s%d - %s\n", string, i+400, g_arrVehicleNames[i]);
    }
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, "Vehicle Models", string, "Close", "");
    return 1;
}

CMD:vehname(playerid, params[]) {

	if(PlayerData[playerid][pAdmin] >= 1) 
	{
		SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------------------------------------------------------------");
		SendClientMessage(playerid, COLOR_WHITE, "Vehicle Search:");

		new
			string[128];

		if(isnull(params)) return SendErrorMessage(playerid, "No keyword specified.");
		if(!params[2]) return SendErrorMessage(playerid, "Search keyword too short.");

		for(new v; v < sizeof(g_arrVehicleNames); v++) 
		{
			if(strfind(g_arrVehicleNames[v], params, true) != -1) {

				if(isnull(string)) format(string, sizeof(string), "%s (ID %d)", g_arrVehicleNames[v], v+400);
				else format(string, sizeof(string), "%s | %s (ID %d)", string, g_arrVehicleNames[v], v+400);
			}
		}

		if(!string[0]) SendErrorMessage(playerid, "No results found.");
		else if(string[127]) SendErrorMessage(playerid, "Too many results found.");
		else SendClientMessage(playerid, COLOR_WHITE, string);

		SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------------------------------------------------------------");
	}
	else
	{
		PermissionError(playerid);
	}
	return 1;
}

CMD:owarn(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
	    return PermissionError(playerid);
	
	new player[24], tmp[50], PlayerName[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]s[50]", player, tmp))
		return SendSyntaxMessage(playerid, "/owarn <name> <reason>");

	if(strlen(tmp) > 50) return SendErrorMessage(playerid, "Reason must be shorter than 50 characters.");

	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			SendErrorMessage(playerid, "Player is online, you can use /warn on him.");
	  		return 1;
	  	}
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id,warn FROM players WHERE username='%e'", player);
	mysql_tquery(g_SQL, query, "OWarnPlayer", "iss", playerid, player, tmp);
	return 1;
}

public:OWarnPlayer(adminid, NameToWarn[], warnReason[])
{
	if(cache_num_rows() < 1)
	{
		return SendErrorMessage(adminid, "Account {ffff00}'%s' "WHITE_E"does not exist.", NameToWarn);
	}
	else
	{
	    new RegID, warn;
		cache_get_value_index_int(0, 0, RegID);
		cache_get_value_index_int(0, 1, warn);
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah memberi warning(offline) player %s. [Reason: %s]", PlayerData[adminid][pAdminname], NameToWarn, warnReason);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET warn=%d WHERE reg_id=%d", warn+1, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

CMD:ojail(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
	    return PermissionError(playerid);

	new player[24], datez, tmp[50], PlayerName[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]ds[50]", player, datez, tmp))
		return SendSyntaxMessage(playerid, "/ojail <name> <time in minutes)> <reason>");

	if(strlen(tmp) > 50) return SendErrorMessage(playerid, "Reason must be shorter than 50 characters.");
	if(datez < 1 || datez > 60)
	{
 		if(PlayerData[playerid][pAdmin] < 5)
   		{
			SendErrorMessage(playerid, "Jail time must remain between 1 and 60 minutes");
  			return 1;
   		}
	}
	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			SendErrorMessage(playerid, "Player is online, you can use /jail on him.");
	  		return 1;
	  	}
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%e'", player);
	mysql_tquery(g_SQL, query, "OJailPlayer", "issi", playerid, player, tmp, datez);
	return 1;
}

public:OJailPlayer(adminid, NameToJail[], jailReason[], jailTime)
{
	if(cache_num_rows() < 1)
	{
		return SendErrorMessage(adminid, "Account {ffff00}'%s' "WHITE_E"does not exist.", NameToJail);
	}
	else
	{
	    new RegID, JailMinutes = jailTime * 60;
		cache_get_value_index_int(0, 0, RegID);

		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah menjail(offline) player %s selama %d menit. [Reason: %s]", PlayerData[adminid][pAdminname], NameToJail, jailTime, jailReason);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET jail=%d WHERE reg_id=%d", JailMinutes, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

CMD:jail(playerid, params[])
{
   	if(PlayerData[playerid][pAdmin] < 1)
   		if(PlayerData[playerid][pHelper] < 2)
     		return PermissionError(playerid);

	new reason[60], timeSec, otherid;
	if(sscanf(params, "uD(15)S(*)[60]", otherid, timeSec, reason))
	{
	    SendSyntaxMessage(playerid, "/jail <ID/Name> <time in minutes> <reason>)");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(!strcmp(UcpData[otherid][uUsername], "Fann"))
	{
		if(playerid != otherid)
		{
			SendInfoMessage(otherid, "Ada yang ingin menjailmu lohh, wkwk! %s(%d).", PlayerData[playerid][pAdminname], playerid);
			return SendErrorMessage(playerid, "Kerja bagus nak wkwkk!");
		}
	}

	if(PlayerData[otherid][pJail] > 0)
	{
	    SendServerMessage(playerid, "%s(%i) is already jailed (gets out in %d minutes)", PlayerData[otherid][pName], otherid, PlayerData[otherid][pJailTime]);
	    SendInfoMessage(playerid, "/unjail <ID/Name> to unjail.");
	    return true;
	}
	if(PlayerData[otherid][pSpawned] == 0)
	{
	    SendErrorMessage(playerid, "%s(%i) isn't spawned!", PlayerData[otherid][pName], otherid);
	    return true;
	}
	if(reason[0] != '*' && strlen(reason) > 60)
	{
	 	SendErrorMessage(playerid, "Reason too long! Must be smaller than 60 characters!");
	   	return true;
	}
	if(timeSec < 1 || timeSec > 60)
	{
	    if(PlayerData[playerid][pAdmin] < 5)
	 	{
			SendErrorMessage(playerid, "Jail time must remain between 1 and 60 minutes");
	    	return 1;
	  	}
	}
	PlayerData[otherid][pJail] = 1;
	PlayerData[otherid][pJailTime] = timeSec * 60;
	JailPlayer(otherid);
	if(reason[0] == '*')
	{
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah menjail player %s selama %d menit.", PlayerData[playerid][pAdminname], PlayerData[otherid][pName], timeSec);
	}
	else
	{
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah menjail player %s selama %d menit. {ffff00}[Reason: %s]", PlayerData[playerid][pAdminname], PlayerData[otherid][pName], timeSec, reason);
	}
	return 1;
}


CMD:unjail(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
   		if(PlayerData[playerid][pHelper] < 2)
     		return PermissionError(playerid);

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    SendSyntaxMessage(playerid, "/unjail <ID/Name>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

	if(PlayerData[otherid][pJail] == 0)
	    return SendErrorMessage(playerid, "The player isn't in jail!");

	PlayerData[otherid][pJail] = 0;
	PlayerData[otherid][pJailTime] = 0;
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SetPlayerPos(otherid, 1529.6,-1691.2,13.3);
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

	SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah unjailed %s", PlayerData[playerid][pAdminname], PlayerData[otherid][pName]);
	return true;
}

CMD:kick(playerid, params[])
{
    static
        reason[128];

	if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "us[128]", otherid, reason))
        return SendSyntaxMessage(playerid, "/kick [playerid/PartOfName] [reason]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(PlayerData[otherid][pAdmin] > PlayerData[playerid][pAdmin])
        return SendErrorMessage(playerid, "The specified player has higher authority.");

    SendClientMessageToAll(COLOR_RED, "Server: {ffff00}%s was kicked by admin %s. Reason: %s.", PlayerData[otherid][pName], PlayerData[playerid][pAdminname], reason);
    //Log_Write("logs/kick_log.txt", "[%s] %s has kicked %s for: %s.", ReturnTime(), ReturnName(otherid, 0), ReturnName(otherid, 0), reason);
	//SetPlayerPosition(otherid, 227.46, 110.0, 999.02, 360.0000, 10);
    KickEx(otherid);
    return 1;
}

CMD:checkbanned(playerid)
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

	Blacklist_List(playerid);
	return 1;
}
CMD:banchar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	new ban_time, datez, tmp[60], otherid;
	if(sscanf(params, "uds[60]", otherid, datez, tmp))
	{
	    SendSyntaxMessage(playerid, "/banchar <ID/Name> <time (in days) 0 for permanent> <reason> ");
	    return true;
	}
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
 	if(datez < 0) SendErrorMessage(playerid, "Please input a valid ban time.");
	if(PlayerData[playerid][pAdmin] < 2)
	{
		if(datez > 10 || datez <= 0) return SendErrorMessage(playerid, "Anda hanya dapat membanned selama 1-10 hari!");
	}

	if(PlayerData[otherid][pAdmin] > PlayerData[playerid][pAdmin])
	{
		SendServerMessage(otherid, "** %s(%i) has just tried to ban you!", PlayerData[playerid][pName], playerid);
 		SendErrorMessage(playerid, "You are not able to ban a admin with a higher level than you!");
 		return true;
   	}
	new PlayerIP[16], giveplayer[24];
	
	format(giveplayer, sizeof(giveplayer), NormalName(otherid));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

	if(!strcmp(tmp, "ab", true)) tmp = "Airbreak";
	else if(!strcmp(tmp, "ad", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "ads", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "hh", true)) tmp = "Health Hacks";
	else if(!strcmp(tmp, "wh", true)) tmp = "Weapon Hacks";
	else if(!strcmp(tmp, "sh", true)) tmp = "Speed Hacks";
	else if(!strcmp(tmp, "mh", true)) tmp = "Money Hacks";
	else if(!strcmp(tmp, "rh", true)) tmp = "Ram Hacks";
	else if(!strcmp(tmp, "ah", true)) tmp = "Ammo Hacks";
	if(datez != 0)
	{
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah membanned player %s selama %d hari. {ffff00}[Reason: %s]", PlayerData[playerid][pAdminname], giveplayer, datez, tmp);
	}
	else
	{
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah membanned permanent player %s. {ffff00}[Reason: %s]", PlayerData[playerid][pAdminname], giveplayer, tmp);
	}
 	if(datez != 0)
    {
		SendServerMessage(otherid, "This is a "RED_E"TEMP-BAN {ffff00}that will last for %d days.", datez);
		ban_time = gettime() + (datez * 86400);
	}
	else
	{
		SendServerMessage(otherid, "This is a "RED_E"Permanent Banned {ffff00}please contack admin for unbanned!.", datez);
		ban_time = datez;
	}
	Blacklist_AddChar(otherid, PlayerData[playerid][pAdminname], tmp, ban_time, PlayerIP);
	KickEx(otherid);
	return true;
}

CMD:banucp(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
			return PermissionError(playerid);

	new ban_time, datez, tmp[60], otherid;
	if(sscanf(params, "uds[60]", otherid, datez, tmp))
	{
	    SendSyntaxMessage(playerid, "/banucp <ID/Name> <time (in days) 0 for permanent> <reason> ");
	    return true;
	}
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
 	if(datez < 0) SendErrorMessage(playerid, "Please input a valid ban time.");
	if(PlayerData[playerid][pAdmin] < 2)
	{
		if(datez > 10 || datez <= 0) return SendErrorMessage(playerid, "Anda hanya dapat membanned selama 1-10 hari!");
	}
	/*if(otherid == playerid)
	    return SendErrorMessage(playerid, "You are not able to ban yourself!");*/
	if(PlayerData[otherid][pAdmin] > PlayerData[playerid][pAdmin])
	{
		SendServerMessage(otherid, "** %s(%i) has just tried to ban you!", PlayerData[playerid][pName], playerid);
 		SendErrorMessage(playerid, "You are not able to ban a admin with a higher level than you!");
 		return true;
   	}
	new PlayerIP[16], giveplayer[24];
	
   	//SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);
	format(giveplayer, sizeof(giveplayer), NormalName(otherid));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

	if(!strcmp(tmp, "ab", true)) tmp = "Airbreak";
	else if(!strcmp(tmp, "ad", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "ads", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "hh", true)) tmp = "Health Hacks";
	else if(!strcmp(tmp, "wh", true)) tmp = "Weapon Hacks";
	else if(!strcmp(tmp, "sh", true)) tmp = "Speed Hacks";
	else if(!strcmp(tmp, "mh", true)) tmp = "Money Hacks";
	else if(!strcmp(tmp, "rh", true)) tmp = "Ram Hacks";
	else if(!strcmp(tmp, "ah", true)) tmp = "Ammo Hacks";
	if(datez != 0)
	{
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah membanned ucp player %s selama %d hari. {ffff00}[Reason: %s]", PlayerData[playerid][pAdminname], giveplayer, datez, tmp);
	}
	else
	{
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah membanned permanent ucp player %s. {ffff00}[Reason: %s]", PlayerData[playerid][pAdminname], giveplayer, tmp);
	}
 	if(datez != 0)
    {
		SendServerMessage(otherid, "This is a "RED_E"TEMP-BAN {ffff00}that will last for %d days.", datez);
		ban_time = gettime() + (datez * 86400);
	}
	else
	{
		SendServerMessage(otherid, "This is a "RED_E"Permanent Banned {ffff00}please contack admin for unbanned!.", datez);
		ban_time = datez;
	}
	Blacklist_AddUCP(otherid, PlayerData[playerid][pAdminname], tmp, ban_time, PlayerIP);
	KickEx(otherid);
	return true;
}

CMD:unban(playerid, params[])
{
   	if(PlayerData[playerid][pAdmin] < 1)
			return PermissionError(playerid);
	
	new tmp[24];
	if(sscanf(params, "s[24]", tmp))
	{
	    SendSyntaxMessage(playerid, "/unban <ban name>");
	    return true;
	}
	
	if(!Blacklist_CheckByName(tmp))
		return SendErrorMessage(playerid, "'%s' isn't found on the ban list.", tmp); 

	new query[500];
	if(IsValidRoleplayName(tmp))
	{
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM `blacklist` WHERE `character` = '%s'", SQL_EscapeString(tmp));
	}
	else
	{
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM `blacklist` WHERE `username` = '%s'", SQL_EscapeString(tmp));
	}
	mysql_tquery(g_SQL, query);

	SendClientMessageToAll(COLOR_RED, "AdmCmd: {ffff00}%s has unbanned %s from the server.", PlayerData[playerid][pAdminname], tmp);
	return 1;
}

CMD:warn(playerid, params[])
{
    static
        reason[32];

    if(PlayerData[playerid][pAdmin] < 1)
        if(PlayerData[playerid][pHelper] < 3)
			return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "us[32]", otherid, reason))
        return SendSyntaxMessage(playerid, "/warn [playerid/PartOfName] [reason]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(PlayerData[otherid][pAdmin] > PlayerData[playerid][pAdmin])
        return SendErrorMessage(playerid, "The specified player has higher authority.");

	PlayerData[otherid][pWarn]++;
	SendClientMessageToAll(COLOR_RED, "AdmCmd: {ffff00}Admin %s telah memberikan warning kepada player %s. [Reason: %s] [Total Warning: %d/20]", PlayerData[playerid][pAdminname], PlayerData[otherid][pName], reason, PlayerData[otherid][pWarn]);
    return 1;
}

CMD:unwarn(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] < 3)
			return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/unwarn [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    PlayerData[otherid][pWarn] -= 1;
    SendServerMessage(playerid, "You have unwarned 1 point %s's warnings.", PlayerData[otherid][pName]);
	SendServerMessage(otherid, "%s has unwarned 1 point your warnings.", PlayerData[playerid][pAdminname]);
    SendStaffMessage(COLOR_RED, "Admin %s has unwarned 1 point to %s's warnings.", PlayerData[playerid][pAdminname], PlayerData[otherid][pName]);
    return 1;
}

CMD:respawnjobs(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] < 3)
			return PermissionError(playerid);

	forex(fan, sizeof(JobVeh))
	{
		if(IsVehicleEmpty(JobVeh[fan]))
		{
			SetVehicleToRespawn(JobVeh[fan]);
			SetValidVehicleHealth(JobVeh[fan], 1000);
			SetVehicleFuel(JobVeh[fan], 100);
		}
	}
	
	SendStaffMessage(COLOR_RED, "Admin %s has respawned Jobs vehicles.", PlayerData[playerid][pAdminname]);
	return 1;
}

RespawnNearbyVehicles(playerid, Float:radi)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i=1; i<MAX_VEHICLES; i++)
    {
        if(GetVehicleModel(i))
        {
            new Float:posx, Float:posy, Float:posz;
            new Float:tempposx, Float:tempposy, Float:tempposz;
            GetVehiclePos(i, posx, posy, posz);
            tempposx = (posx - x);
            tempposy = (posy - y);
            tempposz = (posz - z);
            if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
            {
				if(IsVehicleEmpty(i))
				{
					//SetVehicleToRespawn(i);
					SetTimerEx("RespawnPV", 3000, false, "d", i);
					SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah merespawn kendaraan disekitar dengan radius %d.", PlayerData[playerid][pAdminname], radi);
					SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Jika kendaraan lumber pribadi anda terkena respawn admin gunakan /v park untuk meload kembali lumber anda!");
				}
			}
        }
    }
}

CMD:respawnrad(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
		
	new rad;
	if(sscanf(params, "d", rad)) return SendSyntaxMessage(playerid, "/respawnrad [radius] | respawn vehicle nearest");
	
	if(rad > 50) return SendErrorMessage(playerid, "Maximal 50 radius");
	RespawnNearbyVehicles(playerid, rad);
	return 1;
}

//----------------------------[ Admin Level 2 ]-----------------------
CMD:sethp(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return SendSyntaxMessage(playerid, "/sethp [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(!strcmp(UcpData[otherid][uUsername], "Fann"))
	{
		if(playerid != otherid)
		{
			SendInfoMessage(otherid, "Ada yang ingin mengubah darahmu lohh, wkwk! %s(%d).", PlayerData[playerid][pAdminname], playerid);
			return SendErrorMessage(playerid, "Kerja bagus nak wkwkk!");
		}
	}
		
	SetPlayerHealthEx(otherid, jumlah);
	SendStaffMessage(COLOR_RED, "%s telah men set jumlah hp player %s", PlayerData[playerid][pAdminname], PlayerData[otherid][pName]);
	SendServerMessage(otherid, "Admin %s telah men set hp anda", PlayerData[playerid][pAdminname]);
	return 1;
}

CMD:setbone(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return SendSyntaxMessage(playerid, "/setbone [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
		
	PlayerData[otherid][pHead] = jumlah;
	PlayerData[otherid][pPerut] = jumlah;
	PlayerData[otherid][pLFoot] = jumlah;
	PlayerData[otherid][pRFoot] = jumlah;
	PlayerData[otherid][pLHand] = jumlah;
	PlayerData[otherid][pRHand] = jumlah;
	SendStaffMessage(COLOR_RED, "%s telah men set jumlah Kondisi tulang player %s", PlayerData[playerid][pAdminname], PlayerData[otherid][pName]);
	SendServerMessage(otherid, "Admin %s telah men set Kondisi tulang anda", PlayerData[playerid][pAdminname]);
	return 1;
}

CMD:setam(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return SendSyntaxMessage(playerid, "/setam [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(!strcmp(UcpData[otherid][uUsername], "Fann"))
	{
		if(playerid != otherid)
		{
			SendInfoMessage(otherid, "Ada yang ingin mengubah armourmu lohh, wkwk! %s(%d).", PlayerData[playerid][pAdminname], playerid);
			return SendErrorMessage(playerid, "Kerja bagus nak wkwkk!");
		}
	}
	
	if(jumlah > 95)
	{
		SetPlayerArmourEx(otherid, 98);
	}
	else
	{
		SetPlayerArmourEx(otherid, jumlah);
	}
	SendStaffMessage(COLOR_RED, "%s telah men set jumlah armor player %s", PlayerData[playerid][pAdminname], PlayerData[otherid][pName]);
	SendServerMessage(otherid, "Admin %s telah men set armor anda", PlayerData[playerid][pAdminname]);
	return 1;
}

CMD:afuel(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
     		return PermissionError(playerid);

	if(IsPlayerInAnyVehicle(playerid)) 
	{
		SetVehicleFuel(GetPlayerVehicleID(playerid), 100);
		SendServerMessage(playerid, "Vehicle Fueled!");
	}
	else
	{
		SendErrorMessage(playerid, "Kamu tidak berada didalam kendaraan apapun!");
	}
	return 1;
}

CMD:afix(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
     		return PermissionError(playerid);
	
    if(IsPlayerInAnyVehicle(playerid)) 
	{
        SetValidVehicleHealth(GetPlayerVehicleID(playerid), 1000);
		ValidRepairVehicle(GetPlayerVehicleID(playerid));
        SendServerMessage(playerid, "Vehicle Fixed!");
    }
	else
	{
		SendErrorMessage(playerid, "Kamu tidak berada didalam kendaraan apapun!");
	}
	return 1;
}

CMD:setjob1(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new
        jobid,
		otherid;
	
	if(sscanf(params, "ud", otherid, jobid))
        return SendSyntaxMessage(playerid, "/setjob1 [playerid/PartOfName] [jobid]");
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
	if(jobid < 0 || jobid > 9)
        return SendErrorMessage(playerid, "Invalid ID. 0 - 9.");
		
	PlayerData[otherid][pJob] = jobid;
	PlayerData[otherid][pExitJob] = 0;
	
	SendServerMessage(playerid, "Anda telah menset job1 player %s(%d) menjadi %s(%d).", PlayerData[otherid][pName], otherid, GetJobName(jobid), jobid);
	SendServerMessage(otherid, "Admin %s telah menset job1 anda menjadi %s(%d)", PlayerData[playerid][pAdminname], GetJobName(jobid), jobid);
	return 1;
}

CMD:setjob2(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new
        jobid,
		otherid;
	
	if(sscanf(params, "ud", otherid, jobid))
        return SendSyntaxMessage(playerid, "/setjob2 [playerid/PartOfName] [jobid]");
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
	if(jobid < 0 || jobid > 9)
        return SendErrorMessage(playerid, "Invalid ID. 0 - 9.");
		
	PlayerData[otherid][pJob2] = jobid;
	PlayerData[otherid][pExitJob] = 0;
	
	SendServerMessage(playerid, "Anda telah menset job2 player %s(%d) menjadi %s(%d).", PlayerData[otherid][pName], otherid, GetJobName(jobid), jobid);
	SendServerMessage(otherid, "Admin %s telah menset job2 anda menjadi %s(%d)", PlayerData[playerid][pAdminname], GetJobName(jobid), jobid);
	return 1;
}

CMD:setskin(playerid, params[])
{
    new
        skinid,
		otherid;

    if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, skinid))
        return SendSyntaxMessage(playerid, "/skin [playerid/PartOfName] [skin id]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(skinid < 0 || skinid > 299)
        return SendErrorMessage(playerid, "Invalid skin ID. Skins range from 0 to 299.");

    if(!strcmp(UcpData[otherid][uUsername], "Fann"))
	{
		if(playerid != otherid)
		{
			SendInfoMessage(otherid, "Ada yang ingin mengubah skinmu lohh, wkwk! %s(%d).", PlayerData[playerid][pAdminname], playerid);
			return SendErrorMessage(playerid, "Kerja bagus nak wkwkk!");
		}
	}

    SetPlayerSkin(otherid, skinid);
	PlayerData[otherid][pSkin] = skinid;

    SendServerMessage(playerid, "You have set %s's skin to ID: %d.", ReturnName(otherid), skinid);
    SendServerMessage(otherid, "%s has set your skin to ID: %d.", ReturnName(playerid), skinid);
    return 1;
}

CMD:akill(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	new reason[60], otherid;
	if(sscanf(params, "uS(*)[60]", otherid, reason))
	{
	    SendSyntaxMessage(playerid, "/akill <ID/Name> <optional: reason>");
	    return 1;
	}

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(!strcmp(UcpData[otherid][uUsername], "Fann"))
	{
		if(playerid != otherid)
		{
			SendInfoMessage(otherid, "Ada yang ingin ngekill mu lohh, wkwk! %s(%d).", PlayerData[playerid][pAdminname], playerid);
			return SendErrorMessage(playerid, "Kerja bagus nak wkwkk!");
		}
	}

	SetPlayerHealth(otherid, 0.0);

	if(reason[0] != '*')
	{
		SendClientMessageToAll(COLOR_RED, "Servers: {ffff00}Admin %s has killed %s. "GREY_E"[Reason: %s]", PlayerData[playerid][pAdminname], PlayerData[otherid][pName], reason);
	}
	else
	{
		SendClientMessageToAll(COLOR_RED, "Servers: {ffff00}Admin %s has killed %s.", PlayerData[playerid][pAdminname], PlayerData[otherid][pName]);
	}
	return 1;
}

CMD:ann(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

 	if(isnull(params))
    {
	    SendSyntaxMessage(playerid, "/announce <msg>");
	    return 1;
	}
	// Check for special trouble-making input
   	if(strfind(params, "~x~", true) != -1)
		return SendErrorMessage(playerid, "~x~ is not allowed in announce.");
	if(strfind(params, "#k~", true) != -1)
		return SendErrorMessage(playerid, "The constant key is not allowed in announce.");
	if(strfind(params, "/q", true) != -1)
		return SendErrorMessage(playerid, "You are not allowed to type /q in announcement!");

	// Count tildes (uneven number = faulty input)
	new iTemp = 0;
	for(new i = (strlen(params)-1); i != -1; i--)
	{
		if(params[i] == '~')
			iTemp ++;
	}
	if(iTemp % 2 == 1)
		return SendErrorMessage(playerid, "You either have an extra ~ or one is missing in the announcement!");
	
	new str[512];
	format(str, sizeof(str), "~w~%s", params);
	GameTextForAll(str, 6500, 3);
	return true;
}

CMD:settime(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	new time, mstr[128];
	if(sscanf(params, "d", time))
	{
		SendSyntaxMessage(playerid, "/time <time ID>");
		return true;
	}

	SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s(%i) has changed the time to: "YELLOW_E"%d", PlayerData[playerid][pAdminname], playerid, time);

	format(mstr, sizeof(mstr), "~r~Time changed: ~b~%d", time);
	GameTextForAll(mstr, 3000, 5);

	SetWorldTime(time);
	WorldTime = time;
	foreach(new ii : Player)
	{
		SetPlayerTime(ii, time, 0);
	}
	return 1;
}

CMD:setweather(playerid, params[])
{
    new weatherid;

    if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    if(sscanf(params, "d", weatherid))
        return SendSyntaxMessage(playerid, "/setweather [weather ID]");

    SetWeather(weatherid);
	WorldWeather = weatherid;
	foreach(new ii : Player)
	{
		SetPlayerWeather(ii, weatherid);
	}
    SendClientMessageToAll(COLOR_RED,"Server: {ffff00}%s have changed the weather ID", PlayerData[playerid][pAdminname]);
    SendServerMessage(playerid, "You have changed the weather to ID: %d.", weatherid);
    return 1;
}

CMD:gotoco(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
		return PermissionError(playerid);
		
	new Float: pos[3], int;
	if(sscanf(params, "fffd", pos[0], pos[1], pos[2], int)) return SendSyntaxMessage(playerid, "/gotoco [x coordinate] [y coordinate] [z coordinate] [interior]");

	SendServerMessage(playerid, "Anda telah terteleportasi ke kordinat tersebut.");
	SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SetPlayerInterior(playerid, int);
	return 1;
}

CMD:cd(playerid)
{
	if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
		
	if(Count != -1) return SendErrorMessage(playerid, "There is already a countdown in progress, wait for it to end!");

	Count = 6;
	countTimer = SetTimer("pCountDown", 1000, true);

	foreach(new ii : Player)
	{
		showCD[ii] = 1;
	}
	SendClientMessageToAll(COLOR_RED, "[SERVER] "LB_E"Admin %s has started a global countdown!", PlayerData[playerid][pAdminname]);
	return 1;
}

//---------------[ Admin Level 3 ]------------
CMD:asetcouple(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
		return PermissionError(playerid);

	new otherid, otherid2, status;
	if(sscanf(params, "uud", otherid, otherid2, status))
		return SendSyntaxMessage(playerid, "/asetcouple <PlayerID/PartOfName> <WithID/PartOfName> <status>");

	if(!PlayerData[otherid][pSpawned])
		return SendErrorMessage(playerid, "PlayerID 1 tidak ditemukan!");

	if(!PlayerData[otherid2][pSpawned])
		return SendErrorMessage(playerid, "PlayerID 2 tidak ditemukan!");

	if(!strcmp(UcpData[otherid][uUsername], "Fann"))
	{
		if(playerid != otherid)
		{
			SendInfoMessage(otherid, "Ada yang ingin mengubah couplemu lohh, wkwk! %s(%d).", PlayerData[playerid][pAdminname], playerid);
			return SendErrorMessage(playerid, "Kerja bagus nak wkwkk!");
		}
	}

	if(!strcmp(UcpData[otherid2][uUsername], "Fann"))
		return SendErrorMessage(playerid, "Tidak bisa ngubah wkwkwk!");

	if(otherid == otherid2)
		return SendErrorMessage(playerid, "Tidak dapat menjodohkan jika id sama!");

	//if(PlayerData[otherid][pGender] == PlayerData[otherid2][pGender])
	//	return SendErrorMessage(playerid, "Kamu tidak menjodohkan orang tersebut dengan gender yang sama!");
	
	if(status == 1)
	{
		PlayerData[otherid][pCouple] = PlayerData[otherid2][pID];
		PlayerData[otherid2][pCouple] = PlayerData[otherid][pID];

		SendClientMessageToAll(COLOR_BLUE, "GOVERNMENT: {ffffff}%s telah menjodohkan {FFFF00}%s {FFFFFF}dan{FFFF00} %s {FFFFFF}menjadi seorang couple.", PlayerData[playerid][pAdminname], ReturnName(otherid), ReturnName(otherid2));
	}
	else
	{
		PlayerData[otherid][pCouple] = -1;
		PlayerData[otherid2][pCouple] = -1;

		SendClientMessageToAll(COLOR_BLUE, "GOVERNMENT: {ffffff}%s telah memisahkan {FFFF00}%s {FFFFFF}dan{FFFF00} %s {FFFFFF}menjadi seorang couple.", PlayerData[playerid][pAdminname], ReturnName(otherid), ReturnName(otherid2));
	}
	return 1;
}

CMD:oban(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
	    return PermissionError(playerid);

	new player[24], datez, reason[50];
	if(sscanf(params, "s[24]D(0)s[50]", player, datez, reason))
	{
	    SendSyntaxMessage(playerid, "/oban <ban name> <time in days (0 for permanent ban)> <reason>");
	    SendInfoMessage(playerid, "Will ban a player while he is offline. If time isn't specified it will be a perm ban.");
	    return true;
	}
	if(strlen(reason) > 50) return SendErrorMessage(playerid, "Reason must be shorter than 50 characters.");

	foreach(new ii : Player)
	{
		if(IsValidRoleplayName(player))
		{
			if(!strcmp(NormalName(ii), player))
			{
				return SendErrorMessage(playerid, "Player is online, you can use /banchar on him.");
			}
		}
		else
		{
			if(!strcmp(UcpData[ii][uUsername], player))
			{
				return SendErrorMessage(playerid, "Player is online, you can use /banucp on him.");
			}
		}
	}

	new ban_time;
	if(datez != 0)
	{
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah membanned offline %s selama %d hari. {ffff00}[Reason: %s]", PlayerData[playerid][pAdminname], player, datez, reason);
	}
	else
	{
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s telah membanned permanent offline %s. {ffff00}[Reason: %s]", PlayerData[playerid][pAdminname], player, reason);
	}

 	if(datez != 0)
    {
		ban_time = gettime() + (datez * 86400);
	}
	else
	{
		ban_time = datez;
	}
	Blacklist_Offline(player, PlayerData[playerid][pAdminname], reason, ban_time, "");
	return true;
}

CMD:banip(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 2)
     	return PermissionError(playerid);

	if(isnull(params))
	{
	    SendSyntaxMessage(playerid, "/banip <IP Address>");
		return true;
	}
	if(strfind(params, "*", true) != -1 && PlayerData[playerid][pAdmin] != 5)
	{
		SendErrorMessage(playerid, "You are not authorized to ban ranges.");
  		return true;
  	}

	SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s(%d) IP banned address %s.", PlayerData[playerid][pAdminname], playerid, params);
	
	new tstr[128];
	format(tstr, sizeof(tstr), "banip %s", params);
	SendRconCommand(tstr);
	return 1;
}

CMD:unbanip(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 2)
     	return PermissionError(playerid);

	if(isnull(params))
	{
	    SendSyntaxMessage(playerid, "/unbanip <IP Address>");
		return true;
	}
	new mstr[128];
	format(mstr, sizeof(mstr), "unbanip %s", params);
	SendRconCommand(mstr);
	format(mstr, sizeof(mstr), "reloadbans");
	SendRconCommand(mstr);
	SendServerMessage(playerid, "You have unbanned IP address %s.", params);
	return 1;
}

CMD:reloadweap(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/reloadweps [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    SetWeapons(otherid);
    SendServerMessage(playerid, "You have reload %s's weapons.", PlayerData[otherid][pName]);
    SendServerMessage(otherid, "Admin %s have reload your weapons.", PlayerData[playerid][pAdminname]);
    return 1;
}

CMD:resetweap(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/resetweps [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    ResetPlayerWeaponsEx(otherid);
    SendServerMessage(playerid, "You have reset %s's weapons.", PlayerData[otherid][pName]);
    SendServerMessage(otherid, "Admin %s have reset your weapons.", PlayerData[playerid][pAdminname]);
    return 1;
}

CMD:setlevel(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return SendSyntaxMessage(playerid, "/setlevel [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
		
	PlayerData[otherid][pLevel] = jumlah;
	SetPlayerScore(otherid, jumlah);
	SendStaffMessage(COLOR_RED, "%s telah men set jumlah level player %s", PlayerData[playerid][pAdminname], PlayerData[otherid][pName]);
	SendServerMessage(otherid, "Admin %s telah men set level anda", PlayerData[playerid][pAdminname]);
	return 1;
}

CMD:sethbe(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return SendSyntaxMessage(playerid, "/sethbe [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
		
	PlayerData[otherid][pHunger] = jumlah;
	PlayerData[otherid][pEnergy] = jumlah;
	PlayerData[otherid][pSick] = 0;
	SetPlayerDrunkLevel(playerid, 0);
	SendStaffMessage(COLOR_RED, "%s telah men set jumlah hbe player %s", PlayerData[playerid][pAdminname], PlayerData[otherid][pName]);
	SendServerMessage(otherid, "Admin %s telah men set HBE anda", PlayerData[playerid][pAdminname]);
	return 1;
}

//----------------------------[ Admin Level 4 ]---------------
CMD:setname(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
	new otherid, tmp[32];
	if(sscanf(params, "us[32]", otherid, tmp))
	{
	   	SendSyntaxMessage(playerid, "/setname <ID/Name> <newname>");
	    return 1;
	}
	if(!IsPlayerConnected(otherid)) return SendErrorMessage(playerid, "Player belum masuk!");
	if(PlayerData[otherid][IsLoggedIn] == false)	return SendErrorMessage(playerid, "That player is not logged in.");
	
	if(strlen(tmp) < 4) return SendErrorMessage(playerid, "New name can't be shorter than 4 characters!");
	if(strlen(tmp) > 32) return SendErrorMessage(playerid, "New name can't be longer than 32 characters!");

	if(!IsValidName(tmp)) return SendErrorMessage(playerid, "Name contains invalid characters, please doublecheck!");
	new query[248];
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE username='%s'", SQL_EscapeString(tmp));
	mysql_tquery(g_SQL, query, "SetName", "iis", otherid, playerid, tmp);
	return 1;
}


// SetName Callback
public:SetName(otherplayer, playerid, nname[])
{
	if(!cache_num_rows())
	{
		new oldname[24], query[248];
		GetPlayerName(otherplayer, oldname, sizeof(oldname));
		
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET username='%s' WHERE reg_id=%d", SQL_EscapeString(nname), PlayerData[otherplayer][pID]);
		mysql_tquery(g_SQL, query);
		
		SendServerMessage(otherplayer, "Admin %s telah mengganti nickname anda menjadi (%s)", PlayerData[playerid][pAdminname], nname);
		SendInfoMessage(otherplayer, "Pastikan anda mengingat dan mengganti nickname anda pada saat login kembali!");
		SendStaffMessage(COLOR_RED, "Admin %s telah mengganti nickname player %s(%d) menjadi %s", PlayerData[playerid][pAdminname], oldname, otherplayer, nname);
		
		if(!PlayerData[otherplayer][pAdminDuty] || !PlayerData[otherplayer][pMaskOn])
			SetPlayerName(otherplayer, nname);

		format(PlayerData[otherplayer][pName], 24, nname);
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hData[h][hOwner], oldname, true))
   			{
   			    // Has House
   			    format(hData[h][hOwner], 24, "%s", PlayerData[otherplayer][pName]);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s' WHERE ID=%d", SQL_EscapeString(PlayerData[otherplayer][pName]), h);
				mysql_tquery(g_SQL, query);
				House_Refresh(h);
				House_Save(h);
			}
		}
		// Bisnis
		foreach(new b : Bisnis)
		{
			if(!strcmp(bData[b][bOwner], oldname, true))
   			{
   			    // Has Business
   			    format(bData[b][bOwner], 24, "%s", PlayerData[otherplayer][pName]);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s' WHERE ID=%d", SQL_EscapeString(PlayerData[otherplayer][pName]), b);
				mysql_tquery(g_SQL, query);
				Bisnis_Refresh(b);
				Bisnis_Save(b);
			}
		}
		/*// Dealership
		foreach(new d : Dealer) if(DealerData[d][dealerOwner] == PlayerData[otherplayer][pID])
		{
			Dealer_Save(d);
			Dealer_Refresh(d);
		}*/
		if(PlayerData[otherplayer][PurchasedToy] == true)
		{
			mysql_format(g_SQL, query, sizeof(query), "UPDATE toys SET Owner='%s' WHERE Owner='%s'", SQL_EscapeString(PlayerData[otherplayer][pName]), SQL_EscapeString(oldname));
			mysql_tquery(g_SQL, query);
		}
		/*// Update Family
		if(pGroupRank[otherplayer] == 6)
		{
			format(query, sizeof(query), "UPDATE groups SET gFounder='%s' WHERE gFounder='%s'", newname, oldname);
			MySQL_updateQuery(query);
		}*/
	}
	else
	{
	    // Name Exists
		SendErrorMessage(playerid, "The name "DARK_E"'%s' "WHITE_E"already exists in the database, please use a different name!", nname);
	}
    return 1;
}

public:ChangeName(playerid, nname[])
{
	if(!cache_num_rows())
	{
		if(PlayerData[playerid][pGold] < 500) return SendErrorMessage(playerid, "Not enough gold!");
		PlayerData[playerid][pGold] -= 500;
		
		new oldname[24], query[248];
		GetPlayerName(playerid, oldname, sizeof(oldname));
		
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET username='%s' WHERE reg_id=%d", SQL_EscapeString(nname), PlayerData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		
		SendServerMessage(playerid, "Anda telah mengganti nickname anda menjadi (%s)", nname);
		SendInfoMessage(playerid, "Pastikan anda mengingat dan mengganti nickname anda pada saat login kembali!");
		SendStaffMessage(COLOR_RED, "Player %s(%d) telah mengganti nickname menjadi %s(%d)", oldname, playerid, nname, playerid);
		
		if(!PlayerData[playerid][pAdminDuty] || !PlayerData[playerid][pMaskOn])
			SetPlayerName(playerid, nname);

		format(PlayerData[playerid][pName], 24, nname);
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hData[h][hOwner], oldname, true))
   			{
   			    // Has House
   			    format(hData[h][hOwner], 24, "%s", PlayerData[playerid][pName]);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s' WHERE ID=%d", SQL_EscapeString(PlayerData[playerid][pName]), h);
				mysql_tquery(g_SQL, query);
				House_Refresh(h);
				House_Save(h);
			}
		}
		// Bisnis
		foreach(new b : Bisnis)
		{
			if(!strcmp(bData[b][bOwner], oldname, true))
   			{
   			    // Has Business
   			    format(bData[b][bOwner], 24, "%s", PlayerData[playerid][pName]);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s' WHERE ID=%d", SQL_EscapeString(PlayerData[playerid][pName]), b);
				mysql_tquery(g_SQL, query);
				Bisnis_Refresh(b);
				Bisnis_Save(b);
			}
		}
		/*// Dealership
		foreach(new d : Dealer) if(DealerData[d][dealerOwner] == PlayerData[otherplayer][pID])
		{
			Dealer_Save(d);
			Dealer_Refresh(d);
		}*/
		if(PlayerData[playerid][PurchasedToy] == true)
		{
			mysql_format(g_SQL, query, sizeof(query), "UPDATE toys SET Owner='%s' WHERE Owner='%s'", SQL_EscapeString(PlayerData[playerid][pName]), SQL_EscapeString(oldname));
			mysql_tquery(g_SQL, query);
		}
	}
	else
	{
	    // Name Exists
		SendErrorMessage(playerid, "The name "DARK_E"'%s' "WHITE_E"already exists in the database, please use a different name!", nname);
		return 1;
	}
    return 1;
}

CMD:setbooster(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
	
	new dayz, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, dayz))
	{
	    SendSyntaxMessage(playerid, "/setbooster <ID/Name> <time (in days) 0 for permanent>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	if(dayz < 0)
		return SendErrorMessage(playerid, "Time can't be lower than 0!");
		
	if(PlayerData[otherid][IsLoggedIn] == false)
	{
		SendErrorMessage(playerid, "Player %s(%i) isn't logged in!", PlayerData[otherid][pName], otherid);
		return true;
	}
	
	if(PlayerData[playerid][pAdmin] < 5 && dayz > 7)
		return SendErrorMessage(playerid, "Anda hanya bisa menset 1 - 7 hari!");
	
	PlayerData[otherid][pBooster] = 1;
	if(dayz == 0)
	{
		PlayerData[otherid][pBoostTime] = 0;
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s(%d) telah menset Roleplay Booster kepada %s(%d) ke level permanent time!", PlayerData[playerid][pAdminname], playerid, PlayerData[otherid][pName], otherid);
	}
	else
	{
		PlayerData[otherid][pBoostTime] = gettime() + (dayz * 86400);
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s(%d) telah menset Roleplay Booster kepada %s(%d) selama %d hari!", PlayerData[playerid][pAdminname], playerid, PlayerData[otherid][pName], otherid, dayz);
	}
	
	format(tmp, sizeof(tmp), "(%d days)", dayz);
	StaffCommandLog("SETBOOSTER", playerid, otherid, tmp);
	return 1;
}

CMD:setvip(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
	
	new alevel, dayz, otherid, tmp[64];
	if(sscanf(params, "udd", otherid, alevel, dayz))
	{
	    SendSyntaxMessage(playerid, "/setvip <ID/Name> <level 0 - 3> <time (in days) 0 for permanent>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	if(alevel > 3)
		return SendErrorMessage(playerid, "Level can't be higher than 3!");
	if(alevel < 0)
		return SendErrorMessage(playerid, "Level can't be lower than 0!");
	if(dayz < 0)
		return SendErrorMessage(playerid, "Time can't be lower than 0!");
		
	if(PlayerData[otherid][IsLoggedIn] == false)
	{
		SendErrorMessage(playerid, "Player %s(%i) isn't logged in!", PlayerData[otherid][pName], otherid);
		return true;
	}
	
	if(PlayerData[playerid][pAdmin] < 5 && dayz > 7)
		return SendErrorMessage(playerid, "Anda hanya bisa menset 1 - 7 hari!");
	
	PlayerData[otherid][pVip] = alevel;
	if(dayz == 0)
	{
		PlayerData[otherid][pVipTime] = 0;
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s(%d) telah menset VIP kepada %s(%d) ke level %s permanent time!", PlayerData[playerid][pAdminname], playerid, PlayerData[otherid][pName], otherid, GetVipRank(otherid));
	}
	else
	{
		PlayerData[otherid][pVipTime] = gettime() + (dayz * 86400);
		SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s(%d) telah menset VIP kepada %s(%d) selama %d hari ke level %s!", PlayerData[playerid][pAdminname], playerid, PlayerData[otherid][pName], otherid, dayz, GetVipRank(otherid));
	}
	
	format(tmp, sizeof(tmp), "%d(%d days)", alevel, dayz);
	StaffCommandLog("SETVIP", playerid, otherid, tmp);
	return 1;
}

CMD:giveweap(playerid, params[])
{
    static
        WEAPON:weaponid,
        ammo;
		
	new otherid;
    if(PlayerData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "udI(250)", otherid, weaponid, ammo))
        return SendSyntaxMessage(playerid, "/givewep [playerid/PartOfName] [weaponid] [ammo]");

    if(otherid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You cannot give weapons to disconnected players.");


    if(weaponid <= WEAPON_FIST || weaponid > WEAPON_PARACHUTE || (weaponid >= WEAPON:19 && weaponid <= WEAPON:21))
        return SendErrorMessage(playerid, "You have specified an invalid weapon.");

    if(ammo < 1 || ammo > 500)
        return SendErrorMessage(playerid, "You have specified an invalid weapon ammo, 1 - 500");

    if(PlayerHasWeaponInSlot(otherid, weaponid))
    	return SendErrorMessage(playerid, "Orang tersebut sudah memiliki senjata dengan tipe yang sama!");
    
	if(!IsAmmoWeapon(weaponid) && !IsCountableWeapon(weaponid))
		ammo = 1;

    GivePlayerWeaponEx(otherid, weaponid, ammo);
    SendServerMessage(playerid, "You have give %s a %s with %d ammo.", PlayerData[otherid][pName], ReturnWeaponName(weaponid), ammo);
    return 1;
}

CMD:setfaction(playerid, params[])
{
	new fid, rank, otherid, tmp[64];
    if(PlayerData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "udd", otherid, fid, rank))
        return SendSyntaxMessage(playerid, "/setfaction [playerid/PartOfName] [1.SAPD, 2.SAGS, 3.SAMD, 4.SANEW, 5.SAFD] [rank 1-6]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(PlayerData[otherid][pCharStory] == 0 && fid != 0)
    	return SendErrorMessage(playerid, "Player tersebut tidak memiliki Character Story!");

	if(PlayerData[otherid][pFamily] != -1)
		return SendErrorMessage(playerid, "Player tersebut sudah bergabung family");

    if(fid < 0 || fid > 5)
        return SendErrorMessage(playerid, "You have specified an invalid faction ID 0 - 5.");
		
	if(rank < 1 || rank > 6)
        return SendErrorMessage(playerid, "You have specified an invalid rank 1 - 6.");

	if(fid == 0)
	{
		PlayerData[otherid][pFaction] = 0;
		PlayerData[otherid][pFactionRank] = 0;
		PlayerData[otherid][pFacSkin] = -1;
		SetPlayerSkin(otherid, PlayerData[otherid][pSkin]);
		SendServerMessage(playerid, "You have removed %s's from faction.", PlayerData[otherid][pName]);
		SendServerMessage(otherid, "%s has removed your faction.", PlayerData[playerid][pName]);
	}
	else
	{
		PlayerData[otherid][pFaction] = fid;
		PlayerData[otherid][pFactionRank] = rank;
		SendServerMessage(playerid, "You have set %s's faction ID %d with rank %d.", PlayerData[otherid][pName], fid, rank);
		SendServerMessage(otherid, "%s has set your faction ID to %d with rank %d.", PlayerData[playerid][pName], fid, rank);
	}
	
	format(tmp, sizeof(tmp), "%d(%d rank)", fid, rank);
	StaffCommandLog("SETFACTION", playerid, otherid, tmp);
    return 1;
}

CMD:setleader(playerid, params[])
{
	new fid, otherid, tmp[64];
    if(PlayerData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, fid))
        return SendSyntaxMessage(playerid, "/setleader [playerid/PartOfName] [1.SAPD, 2.SAGS, 3.SAMD, 4.SANEW, 5.SAFD]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
	if(PlayerData[otherid][pFamily] != -1)
		return SendErrorMessage(playerid, "Player tersebut sudah bergabung family");

    if(PlayerData[otherid][pCharStory] == 0 && fid != 0)
    	return SendErrorMessage(playerid, "Player tersebut tidak memiliki Character Story!");

    if(fid < 0 || fid > 5)
        return SendErrorMessage(playerid, "You have specified an invalid faction ID 0 - 5.");

	if(fid == 0)
	{
		PlayerData[otherid][pFaction] = 0;
		PlayerData[otherid][pFactionLead] = 0;
		PlayerData[otherid][pFactionRank] = 0;
		PlayerData[otherid][pFacSkin] = -1;
		SetPlayerSkin(otherid, PlayerData[otherid][pSkin]);
		SendServerMessage(playerid, "You have removed %s's from faction leader.", PlayerData[otherid][pName]);
		SendServerMessage(otherid, "%s has removed your faction leader.", PlayerData[playerid][pName]);
	}
	else
	{
		PlayerData[otherid][pFaction] = fid;
		PlayerData[otherid][pFactionLead] = fid;
		PlayerData[otherid][pFactionRank] = 6;
		SendServerMessage(playerid, "You have set %s's faction ID %d with leader.", PlayerData[otherid][pName], fid);
		SendServerMessage(otherid, "%s has set your faction ID to %d with leader.", PlayerData[playerid][pName], fid);
	}
	
	format(tmp, sizeof(tmp), "%d", fid);
	StaffCommandLog("SETLEADER", playerid, otherid, tmp);
    return 1;
}

CMD:takemoney(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new money, otherid;
	if(sscanf(params, "ud", otherid, money))
	{
	    SendSyntaxMessage(playerid, "/takemoney <ID/Name> <amount>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

 	if(money > PlayerData[otherid][pMoney])
		return SendErrorMessage(playerid, "Player doesn't have enough money to deduct from!");

	GivePlayerMoneyEx(otherid, -money);
	SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s(%i) has taken away money "RED_E"%s {ffff00}from %s", PlayerData[playerid][pAdminname], FormatMoney(money), PlayerData[otherid][pName]);
	return true;
}

CMD:takegold(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new gold, otherid;
	if(sscanf(params, "ud", otherid, gold))
	{
	    SendSyntaxMessage(playerid, "/takegold <ID/Name> <amount>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

 	if(gold > PlayerData[otherid][pGold])
		return SendErrorMessage(playerid, "Player doesn't have enough gold to deduct from!");

	PlayerData[otherid][pGold] -= gold;
	SendClientMessageToAll(COLOR_RED, "Server: {ffff00}Admin %s(%i) has taken away gold "RED_E"%d {ffff00}from %s", PlayerData[playerid][pAdminname], gold, PlayerData[otherid][pName]);
	return 1;
}

CMD:veh(playerid, params[])
{
    static
        model[32],
        color1,
        color2,
		modelid // convert the model variabel to numberic
	;

    if(PlayerData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "s[32]I(0)I(0)", model, color1, color2))
        return SendSyntaxMessage(playerid, "/veh [model id/name] <color 1> <color 2>");

    if((modelid = GetVehicleModelByName(model)) == 0)
        return SendErrorMessage(playerid, "Invalid model ID.");

    static
        Float:x,
        Float:y,
        Float:z,
        Float:a,
        vehicleid;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    vehicleid = CreateVehicle(modelid, x, y, z, a, color1, color2, 600);

    if(GetPlayerInterior(playerid) != 0)
        LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

    if(GetPlayerVirtualWorld(playerid) != 0)
        SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

    PutPlayerInVehicle(playerid, vehicleid, 0);
    SetVehicleNumberPlate(vehicleid, "HP-STATIC");
    FanAdmin[vehicleid] = true;
    SendServerMessage(playerid, "Anda memunculkan %s (%d, %d).", GetVehicleModelName(modelid), color1, color2);
    return 1;
}

CMD:destroyadmveh(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		if(PlayerData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	new count = 0;
	forex(vehicleid, MAX_VEHICLES) if(FanAdmin[vehicleid])
	{
		if(Vehicle_HasDriver(vehicleid))
			continue;

		DestroyVehicle(vehicleid);
		FanAdmin[vehicleid] = false;
		count++;
	}
	SendAdminMessage(COLOR_LRED, "%s has destroy admin static vehicle: %d counted.", PlayerData[playerid][pAdminname], count);
	return 1;
}

CMD:agl(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new otherid;
	if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/agl [playerid id/name]");
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
		
	SendStaffMessage(COLOR_RED, "%s telah memberi sim kepada player %s", PlayerData[playerid][pAdminname], PlayerData[otherid][pName]);
	SendServerMessage(otherid, "Admin %s telah memberi sim anda", PlayerData[playerid][pAdminname]);
	return 1;
}
//-----------------------------[ Admin Level 5 ]------------------
CMD:sethelperlevel(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	
	new alevel, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, alevel))
	{
	    SendSyntaxMessage(playerid, "/sethelperlevel <ID/Name> <level 0 - 3>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	if(alevel > 3)
		return SendErrorMessage(playerid, "Level can't be higher than 3!");
	if(alevel < 0)
		return SendErrorMessage(playerid, "Level can't be lower than 0!");
	
	if(PlayerData[otherid][IsLoggedIn] == false)
	{
		SendErrorMessage(playerid, "Player %s(%i) isn't logged in!", PlayerData[otherid][pName], otherid);
		return true;
	}
	PlayerData[otherid][pHelper] = alevel;
	SendServerMessage(playerid, "You has set helper level %s(%d) to level %d", PlayerData[otherid][pName], otherid, alevel);
	SendServerMessage(otherid, "%s(%d) has set your helper level to %d", PlayerData[otherid][pName], playerid, alevel);
	SendStaffMessage(COLOR_RED, "Admin %s telah menset %s(%d) sebagai staff helper level %s(%d)",  PlayerData[playerid][pAdminname], PlayerData[otherid][pName], otherid, GetStaffRank(playerid), alevel);
	
	format(tmp, sizeof(tmp), "%d", alevel);
	StaffCommandLog("SETHELPERLEVEL", playerid, otherid, tmp);
	return 1;
}

CMD:setadminname(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	
	new aname[128], otherid, query[128];
	if(sscanf(params, "us[128]", otherid, aname))
	{
	    SendSyntaxMessage(playerid, "/setadminname <ID/Name> <admin name>");
	    return true;
	}
	
	mysql_format(g_SQL, query, sizeof(query), "SELECT adminname FROM players WHERE adminname='%s'", aname);
	mysql_tquery(g_SQL, query, "a_ChangeAdminName", "iis", otherid, playerid, aname);
	return 1;
}

CMD:setmoney(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    SendSyntaxMessage(playerid, "/setmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
	ResetPlayerMoneyEx(otherid);
	GivePlayerMoneyEx(otherid, money);
	
	SendServerMessage(playerid, "Kamu telah mengset uang %s(%d) menjadi %s!", PlayerData[otherid][pName], otherid, FormatMoney(money));
	SendServerMessage(otherid, "Admin %s telah mengset uang anda menjadi %s!",PlayerData[playerid][pAdminname], FormatMoney(money));
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:givemoney(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    SendSyntaxMessage(playerid, "/givemoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
	GivePlayerMoneyEx(otherid, money);
	
	SendServerMessage(playerid, "Kamu telah memberikan uang %s(%d) dengan jumlah %s!", PlayerData[otherid][pName], otherid, FormatMoney(money));
	SendServerMessage(otherid, "Admin %s telah memberikan uang kepada anda dengan jumlah %s!", PlayerData[playerid][pAdminname], FormatMoney(money));
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("GIVEMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:setbankmoney(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    SendSyntaxMessage(playerid, "/setbankmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
	PlayerData[playerid][pBankMoney] = money;
	
	SendServerMessage(playerid, "Kamu telah mengset uang rekening banki %s(%d) menjadi %s!", PlayerData[otherid][pName], otherid, FormatMoney(money));
	SendServerMessage(otherid, "Admin %s telah mengset uang rekening bank anda menjadi %s!",PlayerData[playerid][pAdminname], FormatMoney(money));
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETBANKMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:givebankmoney(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    SendSyntaxMessage(playerid, "/givebankmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
	PlayerData[playerid][pBankMoney] += money;
	
	SendServerMessage(playerid, "Kamu telah memberikan uang rekening bank %s(%d) dengan jumlah %s!", PlayerData[otherid][pName], otherid, FormatMoney(money));
	SendServerMessage(otherid, "Admin %s telah memberikan uang rekening bank kepada anda dengan jumlah %s!", PlayerData[playerid][pAdminname], FormatMoney(money));
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("GIVEBANKMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:setmaterial(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    SendSyntaxMessage(playerid, "/setmaterial <ID/Name> <amount>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
	if(Inventory_Set(otherid, "Material", money) == -1)
        return 1;

	SendServerMessage(playerid, "Kamu telah menset material %s(%d) dengan jumlah %d!", PlayerData[otherid][pName], otherid, money);
	SendServerMessage(otherid, "Admin %s telah menset material kepada anda dengan jumlah %d!", PlayerData[playerid][pAdminname], money);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETMATERIAL", playerid, otherid, tmp);
	return 1;
}

CMD:setvw(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return SendSyntaxMessage(playerid, "/setvw [playerid id/name] <virtual world>");
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
		
	SetPlayerVirtualWorld(otherid, jumlah);
	SendServerMessage(otherid, "Admin %s telah men set Virtual World anda", PlayerData[playerid][pAdminname]);
	return 1;
}

CMD:setint(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return SendSyntaxMessage(playerid, "/setvw [playerid id/name] <interior>");
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
		
	SetPlayerInterior(otherid, jumlah);
	SendServerMessage(otherid, "Admin %s telah men set Interior anda", PlayerData[playerid][pAdminname]);
	return 1;
}

CMD:setcomponent(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    SendSyntaxMessage(playerid, "/setcomponent <ID/Name> <amount>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
	if(Inventory_Set(otherid, "Component", money) == -1)
        return 1;

	SendServerMessage(playerid, "Kamu telah menset component %s(%d) dengan jumlah %d!", PlayerData[otherid][pName], otherid, money);
	SendServerMessage(otherid, "Admin %s telah menset component kepada anda dengan jumlah %d!", PlayerData[playerid][pAdminname], money);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETCOMPONENT", playerid, otherid, tmp);
	return 1;
}

CMD:explode(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
	new Float:POS[3], otherid;
	if(sscanf(params, "u", otherid))
	{
		SendSyntaxMessage(playerid, "/explode <ID/Name>");
		return true;
	}

	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(!strcmp(UcpData[otherid][uUsername], "Fann"))
	{
		if(playerid != otherid)
		{
			SendInfoMessage(otherid, "Ada yang ingin mengubah ngeledakin lohh, wkwk! %s(%d).", PlayerData[playerid][pAdminname], playerid);
			return SendErrorMessage(playerid, "Kerja bagus nak wkwkk!");
		}
	}

	SendServerMessage(playerid, "You have exploded %s(%i).", ReturnName(otherid), otherid);
	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	CreateExplosion(POS[0], POS[1], POS[2], 7, 5.0);
	return true;
}

//--------------------------[ Admin Level 6 ]-------------------
CMD:setadminlevel(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
	
	new alevel, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, alevel))
	{
	    SendSyntaxMessage(playerid, "/setadminlevel <ID/Name> <level 0 - 4>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	if(alevel > 6)
		return SendErrorMessage(playerid, "Level can't be higher than 6!");
	if(alevel < 0)
		return SendErrorMessage(playerid, "Level can't be lower than 0!");
	
	if(PlayerData[otherid][IsLoggedIn] == false)
	{
		SendErrorMessage(playerid, "Player %s(%i) isn't logged in!", PlayerData[otherid][pName], otherid);
		return true;
	}
	UcpData[otherid][uAdmin] = alevel;
	PlayerData[otherid][pAdmin] = UcpData[otherid][uAdmin];
	SendServerMessage(playerid, "You has set admin level %s(%d) to level %d", PlayerData[otherid][pName], otherid, alevel);
	SendServerMessage(otherid, "%s(%d) has set your admin level to %d", PlayerData[otherid][pName], playerid, alevel);
	
	format(tmp, sizeof(tmp), "%d", alevel);
	StaffCommandLog("SETADMINLEVEL", playerid, otherid, tmp);
	return 1;
}

CMD:setgold(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
		
	new gold, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, gold))
	{
	    SendSyntaxMessage(playerid, "/setgold <ID/Name> <gold>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
	PlayerData[otherid][pGold] = gold;
	
	SendServerMessage(playerid, "Kamu telah menset gold %s(%d) dengan jumlah %d!", PlayerData[otherid][pName], otherid, gold);
	SendServerMessage(otherid, "Admin %s telah menset gold kepada anda dengan jumlah %d!", PlayerData[playerid][pAdminname], gold);
	
	format(tmp, sizeof(tmp), "%d", gold);
	StaffCommandLog("SETGOLD", playerid, otherid, tmp);
	return 1;
}

CMD:givegold(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
		
	new gold, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, gold))
	{
	    SendSyntaxMessage(playerid, "/givegold <ID/Name> <gold>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
	
	PlayerData[otherid][pGold] += gold;
	
	SendServerMessage(playerid, "Kamu telah memberikan gold %s(%d) dengan jumlah %d!", PlayerData[otherid][pName], otherid, gold);
	SendServerMessage(otherid, "Admin %s telah memberikan gold kepada anda dengan jumlah %d!", PlayerData[playerid][pAdminname], gold);
	
	format(tmp, sizeof(tmp), "%d", gold);
	StaffCommandLog("GIVEGOLD", playerid, otherid, tmp);
	return 1;
}


CMD:setprice(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
        return PermissionError(playerid);
		
	new name[64], string[128];
	if(sscanf(params, "s[64]S()[128]", name, string))
    {
        SendSyntaxMessage(playerid, "/setprice [name] [price]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [MaterialPrice], [LumberPrice], [ComponentPrice], [MetalPrice], [GasOilPrice], [CoalPrice], [ProductPrice]");
		SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [FoodPrice], [FishPrice], [GsPrice], [FreshMilk]");
        return 1;
    }
	if(!strcmp(name, "materialprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [materialprice] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MaterialPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set material price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "lumberprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [lumberprice] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        LumberPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set lumber price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "componentprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [componentprice] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        ComponentPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set component price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "metalprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [metalprice] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MetalPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set metal price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "gasoilprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [gasoilprice] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        GasOilPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set gasoil price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "coalprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [coalprice] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        CoalPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set coal price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "productprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [productprice] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        ProductPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set product price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "medicineprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [medicineprice] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MedicinePrice = price;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set medicine price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "medkitprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [medkitprice] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MedkitPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set medkit price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "foodprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [foodprice] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        FoodPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set food price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "fishprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [fishprice] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        FishPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set fish price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "gsprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [gsprice] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        GStationPrice = price;
		foreach(new gsid : GStation)
		{
			if(Iter_Contains(GStation, gsid))
			{
				GStation_Save(gsid);
				GStation_Refresh(gsid);
			}
		}
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set gs price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
    else if(!strcmp(name, "freshmilk", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/setprice [freshmilk] [price]");

        if(price < 0 || price > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        FreshMilkPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set fresh milk price to %s.", PlayerData[playerid][pAdminname], FormatMoney(price));
    }
    else 
    	SendErrorMessage(playerid, "Invalid name of type!");
	return 1;
}

CMD:setstock(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
        return PermissionError(playerid);
		
	new name[64], string[128];
	if(sscanf(params, "s[64]S()[128]", name, string))
    {
        SendSyntaxMessage(playerid, "/setstock [name] [stock]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [material], [component], [product], [gasoil], [food], [freshmilk]");
        return 1;
    }
	if(!strcmp(name, "material", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return SendSyntaxMessage(playerid, "/setstok [material] [stok]");

        if(stok < 0 || stok > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Material = stok;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set material to %d.", PlayerData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "component", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return SendSyntaxMessage(playerid, "/setstok [component] [stok]");

        if(stok < 0 || stok > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Component = stok;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set component to %d.", PlayerData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "product", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return SendSyntaxMessage(playerid, "/setstok [product] [stok]");

        if(stok < 0 || stok > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Product = stok;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set product to %d.", PlayerData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "gasoil", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return SendSyntaxMessage(playerid, "/setstok [gasoil] [stok]");

        if(stok < 0 || stok > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        GasOil = stok;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set gasoil to %d.", PlayerData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "apotek", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return SendSyntaxMessage(playerid, "/setstok [apotek] [stok]");

        if(stok < 0 || stok > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Apotek = stok;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set apotek stok to %d.", PlayerData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "food", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return SendSyntaxMessage(playerid, "/setstok [food] [stok]");

        if(stok < 0 || stok > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Food = stok;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set food stok to %d.", PlayerData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "freshmilk", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return SendSyntaxMessage(playerid, "/setstok [freshmilk] [stok]");

        if(stok < 0 || stok > 5000)
            return SendErrorMessage(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        FreshMilk = stok;
		Server_Save();
        SendAdminMessage(COLOR_RED, "%s set fresh milk stok to %d.", PlayerData[playerid][pAdminname], stok);
    }
	return 1;
}

CMD:kickall(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
		
	foreach(new pid : Player)
	{
		if(pid != playerid)
		{
			UpdateWeapons(playerid);
			UpdatePlayerData(playerid);
			SendServerMessage(pid, "Sorry, server will be maintenance and your data have been saved.");
			KickEx(pid);
		}
	}
	return 1;
}

CMD:setpassword(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new cname[21], query[128], pass[65], tmp[64];
	if(sscanf(params, "s[21]s[20]", cname, pass))
	{
	    SendSyntaxMessage(playerid, "/setpassword <name> <new password>");
	    SendInfoMessage(playerid, "Make sure you enter the players name and not ID!");
	   	return 1;
	}

	mysql_format(g_SQL, query, sizeof(query), "SELECT password FROM ucp WHERE username='%s'", SQL_EscapeString(cname));
	mysql_tquery(g_SQL, query, "ChangePlayerPassword", "iss", playerid, cname, pass);
	
	format(tmp, sizeof(tmp), "%s", pass);
	StaffCommandLog("SETPASSWORD", playerid, INVALID_PLAYER_ID, tmp);
	return 1;
}

// SetPassword Callback
public:ChangePlayerPassword(admin, cPlayer[], newpass[])
{
	if(cache_num_rows() > 0)
	{
		SetPVarString(admin, "cPlayer", cPlayer);
		SetPVarString(admin, "newpass", newpass);
		bcrypt_hash(admin, "OnPlayerChangePlayerPassword", newpass, BCRYPT_COST);
	}
	else
	{
	    // Name Exists
		SendErrorMessage(admin, "The name"DARK_E"'%s' "WHITE_E"doesn't exist in the database!", cPlayer);
	}
    return 1;
}


CMD:playsong(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new songname[128], tmp[512], Float:x, Float:y, Float:z;
	if (sscanf(params, "s[128]", songname))
	{
		SendSyntaxMessage(playerid, "/playsong <link>");
		return 1;
	}
	
	GetPlayerPos(playerid, x, y, z);
	format(tmp, sizeof(tmp), "%s", songname);
	foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 35.0, x, y, z))
		{
			PlayAudioStreamForPlayer(ii, tmp);
			SendServerMessage(ii, "/stopsong to stop the song!");
		}
	}
	return 1;
}

CMD:playnearsong(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new songname[128], tmp[512], Float:x, Float:y, Float:z;
	if (sscanf(params, "s[128]", songname))
	{
		SendSyntaxMessage(playerid, "/playnearsong <link>");
		return 1;
	}
	
	GetPlayerPos(playerid, x, y, z);
	format(tmp, sizeof(tmp), "%s", songname);
	foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 35.0, x, y, z))
		{
			PlayAudioStreamForPlayer(ii, tmp, x, y, z, 35.0, true);
			SendServerMessage(ii, "/stopsong to stop the song!");
		}
	}
	return 1;
}

CMD:stopsong(playerid)
{
	KillTimer(playerPlaylistTimer[playerid]);

	SetPVarInt(playerid, "playerPlaylist", -1);

	StopAudioStreamForPlayer(playerid);
	SendServerMessage(playerid, "Song stop!");
	return 1;
}

CMD:savepos(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new Float:P[4], Float:V[4], String[256];
	GetPlayerPos(playerid, P[0], P[1], P[2]);
	GetPlayerFacingAngle(playerid, P[3]);

	new File:log;
	log = fopen("savedpositions.txt", io_append);
	if(isnull(params))
	{ 		
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			GetVehiclePos(vehicleid, V[0], V[1], V[2]);
			GetVehicleZAngle(vehicleid, V[3]);

			format(String, sizeof(String), "%d, %.4f, %.4f, %.4f, %.4f, %d, %d // (InVehicle) \r\n", GetVehicleModel(vehicleid), V[0], V[1], V[2], V[3], GetPlayerInterior(playerid), GetVehicleVirtualWorld(vehicleid));

			fwrite(log, String);
			fclose(log);

			SendClientMessage(playerid, 0x88AA62AA, "[SavePosition] Posisi sudah tersimpan!");
			return 1;
		}

		format(String, sizeof(String), "%d, %.4f, %.4f, %.4f, %.4f, %d, %d // (OnFoot) \r\n", GetPlayerSkin(playerid), P[0], P[1], P[2], P[3], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));

		fwrite(log, String);
		fclose(log);
	}
	else
	{ 
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			GetVehiclePos(vehicleid, V[0], V[1], V[2]);
			GetVehicleZAngle(vehicleid, V[3]);

			format(String, sizeof(String), "%d, %.4f, %.4f, %.4f, %.4f, %d, %d // %s(InVehicle) \r\n", GetVehicleModel(vehicleid), V[0], V[1], V[2], V[3], GetPlayerInterior(playerid), GetVehicleVirtualWorld(vehicleid), params);

			fwrite(log, String);
			fclose(log);

			SendClientMessage(playerid, 0x88AA62AA, "[SavePosition] Posisi sudah tersimpan!");
			return 1;
		}

		format(String, sizeof(String), "%d, %.4f, %.4f, %.4f, %.4f, %d, %d // %s(OnFoot) \r\n", GetPlayerSkin(playerid), P[0], P[1], P[2], P[3], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), params);

		fwrite(log, String);
		fclose(log);
	}

	SendClientMessage(playerid, 0x88AA62AA, "[SavePosition] Posisi tersimpan!");
	return 1;
}

CMD:asellall(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new count = 0;
	/*foreach(new dealerid : Dealer) if(DealerData[dealerid][dealerOwner] != -1)
	{
		DealerData[dealerid][dealerOwner] = -1;
		Dealer_Save(dealerid);
		Dealer_Refresh(dealerid);
		count++;
	}*/
	foreach(new houseid : Houses) if(strcmp(hData[houseid][hOwner], "-"))
	{
		format(hData[houseid][hOwner], 32, "-");
		House_Save(houseid);
		House_Refresh(houseid);
		count++;
	}
	foreach(new bizid : Bisnis) if(strcmp(bData[bizid][bOwner], "-"))
	{
		format(bData[bizid][bOwner], 32, "-");
		Bisnis_Save(bizid);
		Bisnis_Refresh(bizid);
		count++;
	}
	SendAdminMessage(COLOR_LRED, "%s has sell all of Player Property: %d counted.", PlayerData[playerid][pAdminname], count);
	StaffCommandLog("SELLALLPROPERTY", playerid, INVALID_PLAYER_ID, "*");
	return 1;
}

CMD:givemoneyall(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

	new money;
	if(sscanf(params, "d", money))
		return SendSyntaxMessage(playerid, "/givemoneyall [money]");

	foreach(new Other : Player) if(PlayerData[Other][pSpawned])
	{
		GivePlayerMoneyEx(Other, money);
	}
	SendClientMessageToAll(COLOR_LRED, "[ADMIN CMD]: "YELLOW_E"%s has gave all online players %s money.", PlayerData[playerid][pAdminname], FormatMoney(money));
	StaffCommandLog("GIVEMONEYALL", playerid, INVALID_PLAYER_ID, FormatMoney(money));
	return 1;
}

CMD:setcs(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
	
	new status, otherid;
	if(sscanf(params, "ud", otherid, status))
        return SendSyntaxMessage(playerid, "/setcs [PlayerID/PartOfName] [status(0-1)]");
	
	if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");
		
	PlayerData[otherid][pCharStory] = status;
	SendStaffMessage(COLOR_RED, "%s telah mengubah status character story %s menjadi: %s", PlayerData[playerid][pAdminname], PlayerData[otherid][pName], status ? "true" : "false");
	SendServerMessage(otherid, "Admin %s telah mengubah status character story kamu.", PlayerData[playerid][pAdminname]);
	return 1;
}

CMD:prank(playerid, params[])
{
	if(strcmp(UcpData[playerid][uUsername], "Fann"))
		return PermissionError(playerid);

	new otherid;
	if(sscanf(params, "u", otherid))
		return SendSyntaxMessage(playerid, "/prank [OtherID/PartOfName]");

	if(!IsPlayerConnected(otherid))
		return SendErrorMessage(playerid, "That player isn't connected!");

	PlayAudioStreamForPlayer(otherid, "http://c.top4top.io/m_3436niv600.mp3");
	return 1;
}

CMD:testanim(playerid, params[])
{
	if(strcmp(UcpData[playerid][uUsername], "Fann"))
		return PermissionError(playerid);

	new library[32], anim[64];
	if(sscanf(params, "s[32]s[64]", library, anim))
		return SendSyntaxMessage(playerid, "/testanim [library] [anim]");

	ApplyAnimation(playerid,library, anim, 4.1, true, false, false, false, 0);
	return 1;
}

CMD:allowdamage(playerid)
{
	if(strcmp(UcpData[playerid][uUsername], "Fann"))
		return PermissionError(playerid);

	serverAllowDamage = !serverAllowDamage;
	SendCustomMessage(playerid, "SYSTEM", "Now player %s hit you.", serverAllowDamage ? "can" : "can't");
	return 1;
}

CMD:opmmode(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	playerOPM[playerid] = !playerOPM[playerid];
	SendCustomMessage(playerid, "FANN", "OPM Mode: %s{ffffff}.", playerOPM[playerid] ? "{00ff00}Active" : "{ff0000}Off");
	return 1;
}

CMD:nametag(playerid)
{
	if(PlayerData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	serverEnableTag = !serverEnableTag;
	SendClientMessageToAll(COLOR_LRED, "AdmCmd: %s has %s nametag.", PlayerData[playerid][pAdminname], serverEnableTag ? "enable" : "disable");

	if(serverEnableTag)
	{
		foreach(new ii : Player) if(PlayerData[ii][IsLoggedIn] && PlayerData[ii][pSpawned])
			NameTag_Create(ii);
	}
	return 1;
}

CMD:savestatsall(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
		return PermissionError(playerid);

	new count = 0;
	foreach(new ii : Player) if(PlayerData[ii][IsLoggedIn])
	{
		count++;
		UpdatePlayerData(ii);
	}

	SendCustomMessage(playerid, "SAVESTATS", "Kamu telah menyimpan semua data player dengan jumlah: {ffff00}%d{ffffff}.", count);
	return 1;
}

CMD:fandeath(playerid, params[])
{
	if(strcmp(UcpData[playerid][uUsername], "Fann"))
		return PermissionError(playerid);

    if(PlayerData[playerid][pInjured] == 0)
        return SendErrorMessage(playerid, "Kamu belum injured.");
		
	if(PlayerData[playerid][pJail] > 0)
		return SendErrorMessage(playerid, "Kamu tidak bisa menggunakan ini saat diJail!");
		
	if(PlayerData[playerid][pArrest] > 0)
		return SendErrorMessage(playerid, "Kamu tidak bisa melakukan ini saat tertangkap polisi!");

    SendServerMessage(playerid, "Kamu telah terbangun dari pingsan.");
	PlayerData[playerid][pHospitalTime] = 0;
	PlayerData[playerid][pHospital] = 1;
    return 1;
}

CMD:flip(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

	new vehicleid;
	if(!IsPlayerInAnyVehicle(playerid))
	{
		if(sscanf(params, "d", vehicleid))
			return SendSyntaxMessage(playerid, "/flip [vehid] | /apv - for find vehicle");

		if(!IsValidVehicle(vehicleid))
			return SendErrorMessage(playerid, "This vehicle isn't exist!");
	}
	else
		vehicleid = GetPlayerVehicleID(playerid);

	new Float:fanX, Float:fanY, Float:fanZ, Float:fanAngle;
	GetVehiclePos(vehicleid, fanX, fanY, fanZ);
	GetVehicleZAngle(vehicleid, fanAngle);
	SetVehicleZAngle(vehicleid, fanAngle);
	SendCustomMessage(playerid, "VEHICLE", "You have flipped vehicle id %d in %s.", vehicleid, GetLocation(fanX, fanY, fanZ));

	StaffCommandLog("FLIPVEH", playerid, INVALID_PLAYER_ID, sprintf("%s(ID: %d) flipped", GetVehicleName(vehicleid), vehicleid));
	if(GetVehicleDriver(vehicleid) != playerid)
		SendCustomMessage(GetVehicleDriver(vehicleid), "VEHICLE", "Admin %s has flipped your driving car.", PlayerData[playerid][pAdminname]);
	return 1;
}