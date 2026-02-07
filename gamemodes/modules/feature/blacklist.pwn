// Blacklist player by Fann
/*Blacklist_Check(playerid)
{
	mysql_query(g_SQL, sprintf("SELECT * FROM `blacklist` WHERE `username` = '%s' OR `player` = '%s' LIMIT 1;", SQL_EscapeString(UcpData[playerid][uUsername]), SQL_EscapeString(NormalName(playerid))), true);

	if(cache_num_rows())
	{
		return 1;
	}
	return 0;
}*/

Blacklist_CheckByName(const unconst_name[])
{
	new name[MAX_PLAYER_NAME];
	format(name, sizeof(name), "%s", unconst_name);
 	mysql_query(g_SQL, sprintf("SELECT * FROM `blacklist` WHERE `username` = '%s' OR `player` = '%s' LIMIT 1;", SQL_EscapeString(name), SQL_EscapeString(name)), true);

	if(cache_num_rows())
	{
		return 1;
	}
	return 0;
}

/*Blacklist_CheckByIP(playerid, bool:ucp = false)
{
	new query[248], PlayerIP[16];
	if(!ucp)
    	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `blacklist` WHERE `player` = '%s' OR `ip` = '%s' OR (`longip` != 0 AND (`longip` & %i) = %i) LIMIT 1", NormalName(playerid), PlayerData[playerid][pIP], BAN_MASK, (Ban_GetLongIP(PlayerIP) & BAN_MASK));
    else
    	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `blacklist` WHERE `username` = '%s' OR `ip` = '%s' OR (`longip` != 0 AND (`longip` & %i) = %i) LIMIT 1", UcpData[playerid][uUsername], PlayerData[playerid][pIP], BAN_MASK, (Ban_GetLongIP(PlayerIP) & BAN_MASK));

    mysql_query(g_SQL, query, true);

    if(cache_num_rows() > 0)
    {
    	return 1;
    }
    return 0;
}*/

Blacklist_List(playerid)
{
	new count = 0, playername[MAX_PLAYER_NAME], ucpname[MAX_PLAYER_NAME], bannedby[MAX_PLAYER_NAME], reason[40], bandate[42], banexpired;
	mysql_query(g_SQL, "SELECT * FROM blacklist");

	new fanstr[5000];
	if(cache_num_rows() > 0)
	{
		strcat(fanstr, "UCP\tCharacter Name\tBanned by - Reason\tBanned Date - Expired\n");
		forex(banid, cache_num_rows())
		{
			cache_get_value_name(banid, "username", ucpname);
			cache_get_value_name(banid, "player", playername);
			cache_get_value_name(banid, "bannedby", bannedby);
			cache_get_value_name(banid, "reason", reason);
			cache_get_value_name_int(banid, "banned_expired", banexpired);
			cache_get_value_name(banid, "banned_date", bandate);

			strcat(fanstr, sprintf("%s\t%s\t%s - %s\t%s - %s\n", ucpname, playername, bannedby, reason, bandate, banexpired == 0 ? "Permanent" : ReturnDate(banexpired)), sizeof(fanstr));
			count++;
		}
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Count: %d | Banned List", count), fanstr, "Exit", "");
	}
	else
		SendCustomMessage(playerid, "SYSTEM", "There is hasn't banned!");

	return 1;
}

Blacklist_Menu(playerid, bool:ucp = true)
{
	new Reason[40], PlayerName[24], BannedName[24], BannedCharName[MAX_PLAYER_NAME];
	new banTime_Int, banDate[42], banIP[16];

	if(ucp)
	{
		mysql_query(g_SQL, sprintf("SELECT * FROM blacklist WHERE username = '%s' LIMIT 1", SQL_EscapeString(GetName(playerid))), true);

		if(cache_num_rows())
		{
			cache_get_value_name(0, "username", BannedName);
			cache_get_value_name(0, "bannedby", PlayerName);
			cache_get_value_name(0, "reason", Reason);
			cache_get_value_name(0, "ip", banIP);
			cache_get_value_name_int(0, "banned_expired", banTime_Int);
			cache_get_value_name(0, "banned_date", banDate);

			new currentTime = gettime(), PlayerIP[16];
			GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
			if(isnull(banIP))
			{
				mysql_tquery(g_SQL, sprintf("UPDATE blacklist SET ip = '%s' WHERE username = '%s'", SQL_EscapeString(PlayerIP), SQL_EscapeString(BannedName)));
			}
	        if(banTime_Int != 0 && banTime_Int <= currentTime) // Unban the player.
			{
				new query[500];
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM blacklist WHERE username = '%s'", SQL_EscapeString(BannedName));
				mysql_tquery(g_SQL, query);
					
				SendServerMessage(playerid, "Your UCP was unbanned automatically at {ffff00}%s{ffffff}.", ReturnDate(banTime_Int));

				SQL_CheckAccount(playerid);
			}
			else
			{
				foreach(new pid : Player)
				{
					if(PlayerData[pid][pTogLog] == 0)
					{
						SendClientMessage(pid, COLOR_RED, "[SERVER]: "GREY2_E"%s(%i) has been auto-kicked for ban evading.", BannedName, playerid);
					}
				}
				PlayerData[playerid][IsLoggedIn] = false;
				printf("[BANNED INFO]: Ban Getting Called on %s", BannedName);
				
				InfoTD_MSG(playerid, 5000, "~r~~h~You are banned from this server!");
				//for(new l; l < 20; l++) SendClientMessage(playerid, COLOR_DARK, "\n");
				SendClientMessage(playerid, COLOR_RED, "You are banned from this server!");
				if(banTime_Int == 0)
				{
					new lstr[512];
					format(lstr, sizeof(lstr), "{FF0000}You are banned from this server!\n\n"LB2_E"Ban Info:\n{FF0000}Name UCP: {778899}%s\n{FF0000}IP: {778899}%s\n{FF0000}Admin: {778899}%s\n{FF0000}Ban Date: {778899}%s\n{FF0000}Ban Reason: {778899}%s\n{FF0000}Ban Time: {778899}Permanent\n\n{FFFFFF}Merasa tidak bersalah terkena banned? Appeal di village", BannedName, PlayerIP, PlayerName, banDate, Reason);
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"BANNED", lstr, "Exit", "");
				}
				else
				{
					new lstr[512];
					format(lstr, sizeof(lstr), "{FF0000}You are banned from this server!\n\n"LB2_E"Ban Info:\n{FF0000}Name UCP: {778899}%s\n{FF0000}IP: {778899}%s\n{FF0000}Admin: {778899}%s\n{FF0000}Ban Date: {778899}%s\n{FF0000}Ban Reason: {778899}%s\n\n{FFFFFF}Merasa tidak bersalah terkena banned? Appeal di village", BannedName, PlayerIP, PlayerName, banDate, Reason);
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"BANNED", lstr, "Exit", "");
				}
				KickEx(playerid);
	  		}
	  	}
	}
	else
	{
		mysql_query(g_SQL, sprintf("SELECT * FROM blacklist WHERE player = '%s' LIMIT 1", SQL_EscapeString(NormalName(playerid))), true);

		if(cache_num_rows())
		{
			cache_get_value_name(0, "username", BannedName);
			cache_get_value_name(0, "player", BannedCharName);
			cache_get_value_name(0, "bannedby", PlayerName);
			cache_get_value_name(0, "reason", Reason);
			cache_get_value_name(0, "ip", banIP);
			cache_get_value_name_int(0, "banned_expired", banTime_Int);
			cache_get_value_name(0, "banned_date", banDate);

			new currentTime = gettime(), PlayerIP[16];
			GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
			if(isnull(banIP))
			{
				mysql_tquery(g_SQL, sprintf("UPDATE blacklist SET ip = '%s' WHERE player = '%s'", SQL_EscapeString(PlayerIP), SQL_EscapeString(BannedCharName)));
			}
	        if(banTime_Int != 0 && banTime_Int <= currentTime) // Unban the player.
			{
				new query[500];
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM blacklist WHERE player = '%s'", SQL_EscapeString(BannedCharName));
				mysql_tquery(g_SQL, query);
					
				SendServerMessage(playerid, "Your character was unbanned automatically at {ffff00}%s{ffffff}.", ReturnDate(banTime_Int));

				if(!PlayerData[playerid][pSpawned])
				{
					new cQuery[256];
			        mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT * FROM `players` WHERE `username` = '%s' LIMIT 1;", SQL_EscapeString(BannedCharName));
			        mysql_tquery(g_SQL, cQuery, "AssignPlayerData", "d", playerid);
				}
			}
			else
			{
				foreach(new pid : Player)
				{
					if(PlayerData[pid][pTogLog] == 0)
					{
						SendClientMessage(pid, COLOR_RED, "[SERVER]: "GREY2_E"%s(%i) has been auto-kicked for ban evading.", BannedCharName, playerid);
					}
				}
				
				PlayerData[playerid][IsLoggedIn] = false;
				printf("[BANNED INFO]: Ban Getting Called on %s Character", BannedCharName);
				
				InfoTD_MSG(playerid, 5000, "~r~~h~You are banned from this server!");
				//for(new l; l < 20; l++) SendClientMessage(playerid, COLOR_DARK, "\n");
				SendClientMessage(playerid, COLOR_RED, "You are banned from this server!");
				if(banTime_Int == 0)
				{
					new lstr[512];
					format(lstr, sizeof(lstr), "{FF0000}You are banned from this server!\n\n"LB2_E"Ban Info:\n{FF0000}Name UCP: {778899}%s\n{FF0000}Name Character: {778899}%s\n{FF0000}IP: {778899}%s\n{FF0000}Admin: {778899}%s\n{FF0000}Ban Date: {778899}%s\n{FF0000}Ban Reason: {778899}%s\n{FF0000}Ban Time: {778899}Permanent\n\n{FFFFFF}Merasa tidak bersalah terkena banned? Appeal di Discord HopePride", BannedName, BannedCharName, PlayerIP, PlayerName, banDate, Reason);
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"BANNED", lstr, "Exit", "");
				}
				else
				{
					new lstr[512];
					format(lstr, sizeof(lstr), "{FF0000}You are banned from this server!\n\n"LB2_E"Ban Info:\n{FF0000}Name UCP: {778899}%s\n{FF0000}Name Character: {778899}%s\n{FF0000}IP: {778899}%s\n{FF0000}Admin: {778899}%s\n{FF0000}Ban Date: {778899}%s\n{FF0000}Ban Reason: {778899}%s\n\n{FFFFFF}Merasa tidak bersalah terkena banned? Appeal di Discord HopePride", BannedName, BannedCharName, PlayerIP, PlayerName, banDate, Reason);
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"BANNED", lstr, "Exit", "");
				}
				KickEx(playerid);
	  		}
	  	}
	}
	return 1;
}

Blacklist_AddChar(playerid, const unconst_BannedBy[], const unconst_Reason[], time, const unconst_IP[])
{
	new BannedBy[MAX_PLAYER_NAME], Reason[42], IP[16];
	format(BannedBy, sizeof(BannedBy), "%s", unconst_BannedBy);
	format(Reason, sizeof(Reason), "%s", unconst_Reason);
	format(IP, sizeof(IP), "%s", unconst_IP);
	mysql_tquery(g_SQL, sprintf("INSERT INTO blacklist (`player`, `bannedby`, `reason`, `banned_expired`, `banned_date`, `ip`) VALUES('%s', '%s', '%s', '%d', '%s', '%s')", SQL_EscapeString(NormalName(playerid)), SQL_EscapeString(BannedBy), SQL_EscapeString(Reason), time, ReturnDate(gettime()), SQL_EscapeString(IP)));
	SetTimerEx("Blacklist_OpenMenu", 2000, false, "dd", playerid, 0);
	return 1;
}

Blacklist_AddUCP(playerid, const unconst_BannedBy[], const unconst_Reason[], time, const unconst_IP[])
{
	new BannedBy[MAX_PLAYER_NAME], Reason[42], IP[16];
	format(BannedBy, sizeof(BannedBy), "%s", unconst_BannedBy);
	format(Reason, sizeof(Reason), "%s", unconst_Reason);
	format(IP, sizeof(IP), "%s", unconst_IP);
	mysql_tquery(g_SQL, sprintf("INSERT INTO blacklist (`username`, `bannedby`, `reason`, `banned_expired`, `banned_date`, `ip`) VALUES('%s', '%s', '%s', '%d', '%s', '%s')", SQL_EscapeString(UcpData[playerid][uUsername]), SQL_EscapeString(BannedBy), SQL_EscapeString(Reason), time, ReturnDate(gettime()), SQL_EscapeString(IP)));
	SetTimerEx("Blacklist_OpenMenu", 2000, false, "dd", playerid, 1);
	return 1;
}

Blacklist_Offline(const unconst_name[], const unconst_BannedBy[], const unconst_Reason[], time, const unconst_IP[])
{
	new name[MAX_PLAYER_NAME], BannedBy[MAX_PLAYER_NAME], Reason[42], IP[16];
	format(name, sizeof(name), "%s", unconst_name);
	format(BannedBy, sizeof(BannedBy), "%s", unconst_BannedBy);
	format(Reason, sizeof(Reason), "%s", unconst_Reason);
	format(IP, sizeof(IP), "%s", unconst_IP);
	if(IsValidRoleplayName(name))
	{
		mysql_tquery(g_SQL, sprintf("INSERT INTO blacklist (`player`, `bannedby`, `reason`, `banned_expired`, `banned_date`, `ip`) VALUES('%s', '%s', '%s', '%d', '%s', '%s')", SQL_EscapeString(name), SQL_EscapeString(BannedBy), SQL_EscapeString(Reason), time, ReturnDate(gettime()), SQL_EscapeString(IP)));
	}
	else
	{
		mysql_tquery(g_SQL, sprintf("INSERT INTO blacklist (`username`, `bannedby`, `reason`, `banned_expired`, `banned_date`, `ip`) VALUES('%s', '%s', '%s', '%d', '%s', '%s')", SQL_EscapeString(name), SQL_EscapeString(BannedBy), SQL_EscapeString(Reason), time, ReturnDate(gettime()), SQL_EscapeString(IP)));
	}
	return 1;
}

public:Blacklist_OpenMenu(playerid, bool:type)
{
	Blacklist_Menu(playerid, type);
	return 1;
}