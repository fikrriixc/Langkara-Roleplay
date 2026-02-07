//-----------[ Faction Commands ]------------
#include <YSI_Coding\y_hooks>
static tmpobjid;

CMD:factionhelp(playerid)
{
	if(PlayerData[playerid][pFaction] == 1)
	{
		new str[3500];
		strcat(str, ""BLUE_E"SAPD: /locker /or (/r)adio /od /d(epartement) (/gov)ernment (/m)egaphone /invite /uninvite /setrank\n");
		strcat(str, ""WHITE_E"SAPD: /sapdonline /(un)cuff /tazer /detain /arrest /release /flare /destroyflare /checkveh /takedl\n");
		strcat(str, ""BLUE_E"SAPD: /takemarijuana /spike /destroyspike /destroyallspike /getloc /checkmask /checkvstorage\n");
		strcat(str, ""WHITE_E"NOTE: Lama waktu duty anda akan menjadi gaji anda pada saat paycheck!\n");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"SAPD", str, "Close", "");
	}
	else if(PlayerData[playerid][pFaction] == 2)
	{
		new str[3500];
		strcat(str, ""LB_E"SAGS: /locker /or (/r)adio /od /d(epartement) (/gov)ernment (/m)egaphone /invite /uninvite /setrank\n");
		strcat(str, ""WHITE_E"SAGS: /sagsonline /(un)cuff /setcouple\n");
		strcat(str, ""WHITE_E"NOTE: Lama waktu duty anda akan menjadi gaji anda pada saat paycheck!\n");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"SAGS", str, "Close", "");
	}
	else if(PlayerData[playerid][pFaction] == 3)
	{
		new str[3500];
		strcat(str, ""PINK_E"SAMD: /locker /or (/r)adio /od /d(epartement) (/gov)ernment (/m)egaphone /invite /uninvite /setrank\n");
		strcat(str, ""WHITE_E"SAMD: /samdonline /loadinjured /dropinjured /ems /findems /healbone /rescue /salve\n");
		strcat(str, ""WHITE_E"NOTE: Lama waktu duty anda akan menjadi gaji anda pada saat paycheck!\n");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"SAMD", str, "Close", "");
	}
	else if(PlayerData[playerid][pFaction] == 4)
	{
		new str[3500];
		strcat(str, ""ORANGE_E"SANA: /locker /or (/r)adio /od /d(epartement) (/gov)ernment (/m)egaphone /invite /uninvite /setrank\n");
		strcat(str, ""WHITE_E"SANA: /sanaonline /broadcast /bc /live /inviteguest /removeguest\n");
		strcat(str, ""WHITE_E"NOTE: Lama waktu duty anda akan menjadi gaji anda pada saat paycheck!\n");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"SANEWS", str, "Close", "");
	}
	else if(PlayerData[playerid][pFaction] == 5)
	{
		new str[3500];
		strcat(str, ""ORANGE_E"SANA: /locker /or (/r)adio /od /d(epartement) (/gov)ernment (/m)egaphone /invite /uninvite /setrank\n");
		strcat(str, ""WHITE_E"SANA: /safdonline /taketool /storetool\n");
		strcat(str, ""WHITE_E"NOTE: Lama waktu duty anda akan menjadi gaji anda pada saat paycheck!\n");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"SAFD", str, "Close", "");
	}
	else if(PlayerData[playerid][pFamily] != -1)
	{
		new str[3500];
		strcat(str, ""WHITE_E"Family: /fsafe /f(amily) /finvite /funinvite /fsetrank\n");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Family", str, "Close", "");
	}
	else
	{
		SendErrorMessage(playerid, "Anda tidak bergabung dalam faction/family manapun!");
	}
	return 1;
}

CMD:or(playerid, params[])
{
    new text[128];
    
    if(PlayerData[playerid][pFaction] == 0)
        return SendErrorMessage(playerid, "You must in faction member to use this command");
            
    if(sscanf(params,"s[128]",text))
        return SendSyntaxMessage(playerid, "/or(OOC radio) [text]");

    if(strval(text) > 128)
        return SendErrorMessage(playerid,"Text too long.");

    if(PlayerData[playerid][pFaction] == 1) {
        SendFactionMessage(1, COLOR_RADIO, "* (( %s: %s ))", PlayerData[playerid][pName], text);
		//format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		//SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else if(PlayerData[playerid][pFaction] == 2) {
        SendFactionMessage(2, COLOR_RADIO, "* (( %s: %s ))", PlayerData[playerid][pName], text);
		//format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		//SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else if(PlayerData[playerid][pFaction] == 3) {
        SendFactionMessage(3, COLOR_RADIO, "* (( %s: %s ))", PlayerData[playerid][pName], text);
		//format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		//SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else if(PlayerData[playerid][pFaction] == 4) {
        SendFactionMessage(4, COLOR_RADIO, "* (( %s: %s ))", PlayerData[playerid][pName], text);
		//format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		//SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else if(PlayerData[playerid][pFaction] == 5) {
        SendFactionMessage(5, COLOR_RADIO, "* (( %s: %s ))", PlayerData[playerid][pName], text);
		//format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		//SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else
        SendErrorMessage(playerid, "You are'nt in any faction");

    return 1;
}

CMD:r(playerid, params[])
{
    new text[128], mstr[512];
    
    if(PlayerData[playerid][pFaction] == 0)
        return SendErrorMessage(playerid, "You must in faction member to use this command");
            
    if(sscanf(params,"s[128]",text))
        return SendSyntaxMessage(playerid, "/r(adio) [text]");

    if(strval(text) > 128)
        return SendErrorMessage(playerid,"Text too long.");

    if(PlayerData[playerid][pFaction] == 1) {
        SendFactionMessage(1, COLOR_RADIO, "** [SAPD Radio] %s(%d) %s: %s", GetFactionRank(playerid), PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], text);
		format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else if(PlayerData[playerid][pFaction] == 2) {
        SendFactionMessage(2, COLOR_RADIO, "** [SAGS Radio] %s(%d) %s: %s", GetFactionRank(playerid),  PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], text);
		format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else if(PlayerData[playerid][pFaction] == 3) {
        SendFactionMessage(3, COLOR_RADIO, "** [SAMD Radio] %s(%d) %s: %s", GetFactionRank(playerid),  PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], text);
		format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else if(PlayerData[playerid][pFaction] == 4) {
        SendFactionMessage(4, COLOR_RADIO, "** [SANA Radio] %s(%d) %s: %s", GetFactionRank(playerid),  PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], text);
		format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else if(PlayerData[playerid][pFaction] == 5) {
        SendFactionMessage(5, COLOR_RADIO, "** [SAFD Radio] %s(%d) %s: %s", GetFactionRank(playerid),  PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], text);
		format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else
        SendErrorMessage(playerid, "You are'nt in any faction");

    return 1;
}

CMD:od(playerid, params[])
{
    new text[128];
    
    if(PlayerData[playerid][pFaction] == 0)
        return SendErrorMessage(playerid, "You must in faction member to use this command");
            
    if(sscanf(params,"s[128]",text))
        return SendSyntaxMessage(playerid, "/od(OOC departement) [text]");

    if(strval(text) > 128)
        return SendErrorMessage(playerid,"Text too long.");
	
	for(new fid = 1; fid < 5; fid++)
	{
		if(PlayerData[playerid][pFaction] == 1) {
			SendFactionMessage(fid, 0xFFD7004A, "** (( %s: %s ))", PlayerData[playerid][pName], text);
			//format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			//SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else if(PlayerData[playerid][pFaction] == 2) {
			SendFactionMessage(fid, 0xFFD7004A, "** (( %s: %s ))", PlayerData[playerid][pName], text);
			//format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			//SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else if(PlayerData[playerid][pFaction] == 3) {
			SendFactionMessage(fid, 0xFFD7004A, "** (( %s: %s ))", PlayerData[playerid][pName], text);
			//format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			//SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else if(PlayerData[playerid][pFaction] == 4) {
			SendFactionMessage(fid, 0xFFD7004A, "** (( %s: %s ))", PlayerData[playerid][pName], text);
			//format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			//SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else if(PlayerData[playerid][pFaction] == 5) {
			SendFactionMessage(fid, 0xFFD7004A, "** (( %s: %s ))", PlayerData[playerid][pName], text);
			//format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			//SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else
				return SendErrorMessage(playerid, "You are'nt in any faction");
	}
    return 1;
}

CMD:d(playerid, params[])
{
    new text[128], mstr[512];
    
    if(PlayerData[playerid][pFaction] == 0)
        return SendErrorMessage(playerid, "You must in faction member to use this command");
            
    if(sscanf(params,"s[128]",text))
        return SendSyntaxMessage(playerid, "/d(epartement) [text]");

    if(strval(text) > 128)
        return SendErrorMessage(playerid,"Text too long.");
	
	for(new fid = 1; fid < 6; fid++)
	{
		if(PlayerData[playerid][pFaction] == 1) 
		{
			SendFactionMessage(fid, 0xFFD7004A, "** [SAPD Departement] %s(%d) %s: %s", GetFactionRank(playerid), PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], text);
			format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else if(PlayerData[playerid][pFaction] == 2) 
		{
			SendFactionMessage(fid, 0xFFD7004A, "** [SAGS Departement] %s(%d) %s: %s", GetFactionRank(playerid),  PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], text);
			format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else if(PlayerData[playerid][pFaction] == 3) 
		{
			SendFactionMessage(fid, 0xFFD7004A, "** [SAMD Departement] %s(%d) %s: %s", GetFactionRank(playerid),  PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], text);
			format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else if(PlayerData[playerid][pFaction] == 4) 
		{
			SendFactionMessage(fid, 0xFFD7004A, "** [SANA Departement] %s(%d) %s: %s", GetFactionRank(playerid),  PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], text);
			format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else if(PlayerData[playerid][pFaction] == 5) 
		{
			SendFactionMessage(fid, 0xFFD7004A, "** [SANA Departement] %s(%d) %s: %s", GetFactionRank(playerid),  PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], text);
			format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else
				return SendErrorMessage(playerid, "You are'nt in any faction");
	}
    return 1;
}

CMD:m(playerid, params[])
{
	new facname[16];
	if(PlayerData[playerid][pFaction] <= 0)
		return SendErrorMessage(playerid, "You are not faction!");
		
	if(isnull(params)) return SendSyntaxMessage(playerid, "/m(egaphone) [text]");
	
	if(PlayerData[playerid][pFaction] == 1)
	{
		facname = "SAPD";
	}
	else if(PlayerData[playerid][pFaction] == 2)
	{
		facname = "SAGS";
	}
	else if(PlayerData[playerid][pFaction] == 3)
	{
		facname = "SAMD";
	}
	else if(PlayerData[playerid][pFaction] == 4)
	{
		facname = "SANA";
	}
	else if(PlayerData[playerid][pFaction] == 4)
	{
		facname = "SAFD";
	}
	else
	{
		facname ="Unknown";
	}
	
	if(strlen(params) > 64) {
        SendNearbyMessage(playerid, 60.0, COLOR_YELLOW, "[%s Megaphone] %s says: %.64s", facname, ReturnName(playerid), params);
        SendNearbyMessage(playerid, 60.0, COLOR_YELLOW, "...%s", params[64]);
    }
    else {
        SendNearbyMessage(playerid, 60.0, COLOR_YELLOW, "[%s Megaphone] %s says: %s", facname, ReturnName(playerid), params);
    }
	return 1;
}

CMD:gov(playerid, params[])
{
	if(PlayerData[playerid][pFaction] <= 0)
		return SendErrorMessage(playerid, "You are not faction!");
	
	if(PlayerData[playerid][pFactionRank] < 5)
		return SendErrorMessage(playerid, "Only faction level 5-6");
		
	if(PlayerData[playerid][pFaction] == 1)
	{
		new lstr[1024];
		format(lstr, sizeof(lstr), "** SAPD: %s(%d) %s: %s **", GetFactionRank(playerid), PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], params);
		SendClientMessageToAll(COLOR_WHITE, "|___________ Government News Announcement ___________|");
		SendClientMessageToAll(COLOR_BLUE, lstr);
	}
	else if(PlayerData[playerid][pFaction] == 2)
	{
		new lstr[1024];
		format(lstr, sizeof(lstr), "** SAGS: %s(%d) %s: %s **", GetFactionRank(playerid), PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], params);
		SendClientMessageToAll(COLOR_WHITE, "|___________ Government News Announcement ___________|");
		SendClientMessageToAll(COLOR_LBLUE, lstr);
	}
	else if(PlayerData[playerid][pFaction] == 3)
	{
		new lstr[1024];
		format(lstr, sizeof(lstr), "** SAMD: %s(%d) %s: %s **", GetFactionRank(playerid), PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], params);
		SendClientMessageToAll(COLOR_WHITE, "|___________ Government News Announcement ___________|");
		SendClientMessageToAll(COLOR_PINK2, lstr);
	}
	else if(PlayerData[playerid][pFaction] == 4)
	{
		new lstr[1024];
		format(lstr, sizeof(lstr), "** SANA: %s(%d) %s: %s **", GetFactionRank(playerid), PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], params);
		SendClientMessageToAll(COLOR_WHITE, "|___________ Government News Announcement ___________|");
		SendClientMessageToAll(COLOR_ORANGE2, lstr);
	}
	else if(PlayerData[playerid][pFaction] == 5)
	{
		new lstr[1024];
		format(lstr, sizeof(lstr), "** SAFD: %s(%d) %s: %s **", GetFactionRank(playerid), PlayerData[playerid][pFactionRank], PlayerData[playerid][pName], params);
		SendClientMessageToAll(COLOR_WHITE, "|___________ Government News Announcement ___________|");
		SendClientMessageToAll(COLOR_ORANGE2, lstr);
	}
	return 1;
}

CMD:setrank(playerid, params[])
{
	new rank, otherid;
	if(PlayerData[playerid][pFactionLead] == 0 && PlayerData[playerid][pFactionRank] > 5)
		return SendErrorMessage(playerid, "You must faction leader!");
		
	if(sscanf(params, "ud", otherid, rank))
        return SendSyntaxMessage(playerid, "/setrank [playerid/PartOfName] [rank 1-6]");
		
	if(otherid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Invalid ID.");
	
	if(otherid == playerid)
		return SendErrorMessage(playerid, "Invalid ID.");
	
	if(PlayerData[otherid][pFaction] != PlayerData[playerid][pFaction])
		return SendErrorMessage(playerid, "This player is not in your devision!");
	
	if(rank < 1 || rank > 6)
		return SendErrorMessage(playerid, "rank must 1 - 6 only");
	
	PlayerData[otherid][pFactionRank] = rank;
	SendServerMessage(playerid, "You has set %s faction rank to level %d", PlayerData[otherid][pName], rank);
	SendServerMessage(otherid, "%s has set your faction rank to level %d", PlayerData[playerid][pName], rank);
	return 1;
}

CMD:uninvite(playerid, params[])
{
	if(PlayerData[playerid][pFaction] <= 0)
		return SendErrorMessage(playerid, "You are not faction!");
		
	if(PlayerData[playerid][pFactionRank] < 5)
		return SendErrorMessage(playerid, "You must faction level 5 - 6!");
	
	if(!PlayerData[playerid][pOnDuty])
        return SendErrorMessage(playerid, "You must on duty!.");
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/uninvite [playerid/PartOfName]");
		
	if(!IsPlayerConnected(otherid))
		return SendErrorMessage(playerid, "Invalid ID.");
	
	if(otherid == playerid)
		return SendErrorMessage(playerid, "Invalid ID.");
	
	if(PlayerData[otherid][pFactionRank] > PlayerData[playerid][pFactionRank])
		return SendErrorMessage(playerid, "You cant kick him.");
		
	PlayerData[otherid][pFactionRank] = 0;
	PlayerData[otherid][pFaction] = 0;
	PlayerData[otherid][pFacSkin] = -1;
	SendServerMessage(playerid, "Anda telah mengeluarkan %s dari faction.", PlayerData[otherid][pName]);
	SendServerMessage(otherid, "%s telah mengkick anda dari faction.", PlayerData[playerid][pName]);
	return 1;
}

CMD:invite(playerid, params[])
{
	if(PlayerData[playerid][pFaction] <= 0)
		return SendErrorMessage(playerid, "You are not faction!");
		
	if(PlayerData[playerid][pFactionRank] < 5)
		return SendErrorMessage(playerid, "You must faction level 5 - 6!");
	
	if(!PlayerData[playerid][pOnDuty])
        return SendErrorMessage(playerid, "You must on duty!.");
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/invite [playerid/PartOfName]");
		
	if(!IsPlayerConnected(otherid))
		return SendErrorMessage(playerid, "Invalid ID.");
	
	if(otherid == playerid)
		return SendErrorMessage(playerid, "Invalid ID.");
	
	if(!NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "You must be near this player.");

    if(PlayerData[otherid][pCharStory] == 0)
    	return SendErrorMessage(playerid, "Player tersebut tidak memiliki Character Story!");
	
	if(PlayerData[otherid][pFamily] != -1)
		return SendErrorMessage(playerid, "Player tersebut sudah bergabung family!");
		
	if(PlayerData[otherid][pFaction] != 0)
		return SendErrorMessage(playerid, "Player tersebut sudah bergabung faction!");
		
	PlayerData[otherid][pFacInvite] = PlayerData[playerid][pFaction];
	PlayerData[otherid][pFacOffer] = playerid;
	SendServerMessage(playerid, "Anda telah menginvite %s untuk menjadi faction.", PlayerData[otherid][pName]);
	SendServerMessage(otherid, "%s telah menginvite anda untuk menjadi faction. Type: /accept faction or /deny faction!", PlayerData[playerid][pName]);
	return 1;
}

CMD:locker(playerid, params[])
{
	if(PlayerData[playerid][pFaction] < 1)
		if(PlayerData[playerid][pVip] < 1)
			return SendErrorMessage(playerid, "You cant use this commands!");
		
	foreach(new lid : Lockers)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, lData[lid][lPosX], lData[lid][lPosY], lData[lid][lPosZ]))
		{
			if(PlayerData[playerid][pVip] > 0 && lData[lid][lType] == 5)
			{
				ShowPlayerDialog(playerid, DIALOG_LOCKERVIP, DIALOG_STYLE_LIST, "VIP Locker", "Health\nWeapons\nClothing\nVip Toys", "Okay", "Cancel");
			}
			else if(PlayerData[playerid][pFaction] == 1 && PlayerData[playerid][pFaction] == lData[lid][lType])
			{
				ShowPlayerDialog(playerid, DIALOG_LOCKERSAPD, DIALOG_STYLE_LIST, "SAPD Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing\nClothing War", "Proceed", "Cancel");
			}
			else if(PlayerData[playerid][pFaction] == 2 && PlayerData[playerid][pFaction] == lData[lid][lType])
			{
				ShowPlayerDialog(playerid, DIALOG_LOCKERSAGS, DIALOG_STYLE_LIST, "SAGS Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing", "Proceed", "Cancel");
			}
			else if(PlayerData[playerid][pFaction] == 3 && PlayerData[playerid][pFaction] == lData[lid][lType])
			{
				ShowPlayerDialog(playerid, DIALOG_LOCKERSAMD, DIALOG_STYLE_LIST, "SAMD Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing", "Proceed", "Cancel");
			}
			else if(PlayerData[playerid][pFaction] == 4 && PlayerData[playerid][pFaction] == lData[lid][lType])
			{
				ShowPlayerDialog(playerid, DIALOG_LOCKERSANEW, DIALOG_STYLE_LIST, "SANA Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing", "Proceed", "Cancel");
			}
			else if(PlayerData[playerid][pFaction] == 5 && lData[lid][lType] == 6)
			{
				ShowPlayerDialog(playerid, DIALOG_LOCKERSAFD, DIALOG_STYLE_LIST, "SAFD Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing", "Proceed", "Cancel");
			}
			else return SendErrorMessage(playerid, "You are not in this faction type!");
		}
	}
	/*if(PlayerData[playerid][pFaction] == 1)
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.0, 1573.26, -1652.93, -40.59))
    	{
     		ShowPlayerDialog(playerid, LockerSAPD, DIALOG_STYLE_LIST, "SAPD Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing\nClothing War", "Proceed", "Cancel");
     	}
 		else
   		{
     		SendErrorMessage(playerid, "You aren't in range in area lockers.");
			return 1;
     	}
	}
	else if(PlayerData[playerid][pFaction] == 2)
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.0, 1464.10, -1790.31, 2349.68))
    	{
     		ShowPlayerDialog(playerid, LockerSAGS, DIALOG_STYLE_LIST, "SAGS Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing", "Proceed", "Cancel");
     	}
 		else
   		{
     		SendErrorMessage(playerid, "You aren't in range in area lockers.");
			return 1;
     	}
	}
	else if(PlayerData[playerid][pFaction] == 3)
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.0, -1100.25, 1980.02, -58.91) || IsPlayerInRangeOfPoint(playerid, 4.0, -196.35, -1748.86, 675.76))
    	{
     		ShowPlayerDialog(playerid, LockerSAMD, DIALOG_STYLE_LIST, "SAMD Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing", "Proceed", "Cancel");
     	}
 		else
   		{
     		SendErrorMessage(playerid, "You aren't in range in area lockers.");
			return 1;
     	}
	}
	else if(PlayerData[playerid][pFaction] == 4)
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.0, 256.14, 1776.99, 701.08))
    	{
     		ShowPlayerDialog(playerid, LockerSANEW, DIALOG_STYLE_LIST, "SANEW Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing", "Proceed", "Cancel");
     	}
 		else
   		{
     		SendErrorMessage(playerid, "You aren't in range in area lockers.");
			return 1;
     	}
	}
	else return SendErrorMessage(playerid, "You are not faction!");*/
	return 1;
}

//SAPD Commands
CMD:sapdonline(playerid, params[])
{
	new duty[16], lstr[1024];
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\tDuty Time\n");
	foreach(new i: Player)
	{
		if(PlayerData[i][pFaction] == 1)
		{
			switch(PlayerData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = ""BLUE_E"On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s\t%d detik", lstr, PlayerData[i][pName], i, GetFactionRank(i), PlayerData[i][pFactionRank], duty, PlayerData[i][pOnDutyTime]);
			format(lstr, sizeof(lstr), "%s\n", lstr);
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "SAPD Online", lstr, "Close", "");
	return 1;
}

CMD:checkmask(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 1)
        return SendErrorMessage(playerid, "Kamu harus menjadi police officer.");

    new otherid;
    if(sscanf(params, "u", otherid))
    	return SendSyntaxMessage(playerid, "/checkmask [PlayerID/PartOfName]");

    if(!IsPlayerConnected(otherid))
    	return SendErrorMessage(playerid, "That player isn't connected!");

    if(!NearPlayer(playerid, otherid, 3.5))
    	return SendErrorMessage(playerid, "You're not near of that player!");

    new fanstr[256];
    strcat(fanstr, "Name\tMask Alias\n");
    strcat(fanstr, sprintf("%s\tMask_#%d", NormalName(otherid), PlayerData[otherid][pMaskID]), sizeof(fanstr));
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Check Mask", fanstr, "Close", "");

    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s checking identity in the mask of %s.", ReturnName(playerid), ReturnName(otherid));
	return 1;
}

CMD:flare(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 1)
        return SendErrorMessage(playerid, "Kamu harus menjadi police officer.");
		
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	
	if(IsValidDynamicObject(PlayerData[playerid][pFlare]))
		DestroyDynamicObject(PlayerData[playerid][pFlare]);
		
	PlayerData[playerid][pFlare] = CreateDynamicObject(18728, x, y, z-2.8, 0, 0, a-90);
	SendInfoMessage(playerid, "Flare: request backup is actived! /destroyflare to delete flare.");
	SendFactionMessage(1, COLOR_RADIO, "[FLARE] "WHITE_E"Officer %s has request a backup in near (%s).", ReturnName(playerid), GetLocation(x, y, z));
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s deployed a flare on the ground.", ReturnName(playerid));
    return 1;
}

CMD:destroyflare(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 1)
        return SendErrorMessage(playerid, "Kamu harus menjadi police officer.");
		
	if(IsValidDynamicObject(PlayerData[playerid][pFlare]))
		DestroyDynamicObject(PlayerData[playerid][pFlare]);
	SendInfoMessage(playerid, "Your flare is deleted.");
	return 1;
}

CMD:undetain(playerid, params[]) return callcmd::detain(playerid, params);
CMD:detain(playerid, params[])
{
    new vehicleid = GetNearestVehicleToPlayer(playerid, 3.0, false), otherid;

    if(PlayerData[playerid][pFaction] != 1)
        return SendErrorMessage(playerid, "Kamu harus menjadi police officer.");
	
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/detain [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "That player is disconnected.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "You cannot detained yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "You must be near this player.");

    if(!PlayerData[otherid][pCuffed])
        return SendErrorMessage(playerid, "The player is not cuffed at the moment.");

    if(vehicleid == INVALID_VEHICLE_ID)
        return SendErrorMessage(playerid, "You are not near any vehicle.");

    if(GetVehicleMaxSeats(vehicleid) < 2)
        return SendErrorMessage(playerid, "You can't detain that player in this vehicle.");

    if(IsPlayerInVehicle(otherid, vehicleid))
    {
        TogglePlayerControllable(otherid, true);

        RemoveFromVehicle(otherid);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s opens the door and pulls %s out the vehicle.", ReturnName(playerid), ReturnName(otherid));
    }
    else
    {
        new seatid = GetAvailableSeat(vehicleid, 2);

        if(seatid == -1)
            return SendErrorMessage(playerid, "There are no more seats remaining.");

        new
            string[64];

        format(string, sizeof(string), "You've been ~r~detained~w~ by %s.", ReturnName(playerid));
        TogglePlayerControllable(otherid, false);

        //StopDragging(otherid);
        PutPlayerInVehicle(otherid, vehicleid, seatid);

        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s opens the door and places %s into the vehicle.", ReturnName(playerid), ReturnName(otherid));
        InfoTD_MSG(otherid, 3500, string);
    }
    return 1;
}

CMD:cuff(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == 1 || PlayerData[playerid][pFaction] == 2)
	{
		if(!PlayerData[playerid][pOnDuty])
			return SendErrorMessage(playerid, "You must on duty to use cuff.");
		
		new otherid;
		if(sscanf(params, "u", otherid))
			return SendSyntaxMessage(playerid, "/cuff [playerid/PartOfName]");

		if(otherid == INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "That player is disconnected.");

		if(otherid == playerid)
			return SendErrorMessage(playerid, "You cannot handcuff yourself.");

		if(!NearPlayer(playerid, otherid, 5.0))
			return SendErrorMessage(playerid, "You must be near this player.");

		if(GetPlayerState(otherid) != PLAYER_STATE_ONFOOT)
			return SendErrorMessage(playerid, "The player must be onfoot before you can cuff them.");

		if(PlayerData[otherid][pCuffed])
			return SendErrorMessage(playerid, "The player is already cuffed at the moment.");

		PlayerData[otherid][pCuffed] = 1;
		SetPlayerSpecialAction(otherid, SPECIAL_ACTION_CUFFED);
		
		new mstr[128];
		format(mstr, sizeof(mstr), "You've been ~r~cuffed~w~ by %s.", ReturnName(playerid));
		InfoTD_MSG(otherid, 3500, mstr);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s tightens a pair of handcuffs on %s's wrists.", ReturnName(playerid), ReturnName(otherid));
	}
	else
	{
		return SendErrorMessage(playerid, "You not police/gov.");
	}
    return 1;
}

CMD:uncuff(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == 1 || PlayerData[playerid][pFaction] == 2)
	{
	
		if(!PlayerData[playerid][pOnDuty])
			return SendErrorMessage(playerid, "You must on duty to use cuff.");
		
		new otherid;
		if(sscanf(params, "u", otherid))
			return SendSyntaxMessage(playerid, "/uncuff [playerid/PartOfName]");

		if(otherid == INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "That player is disconnected.");

		if(otherid == playerid)
			return SendErrorMessage(playerid, "You cannot uncuff yourself.");

		if(!NearPlayer(playerid, otherid, 5.0))
			return SendErrorMessage(playerid, "You must be near this player.");

		if(!PlayerData[otherid][pCuffed])
			return SendErrorMessage(playerid, "The player is not cuffed at the moment.");

		static
			string[64];

		PlayerData[otherid][pCuffed] = 0;
		SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

		format(string, sizeof(string), "You've been ~g~uncuffed~w~ by %s.", ReturnName(playerid));
		InfoTD_MSG(otherid, 3500, string);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s loosens the pair of handcuffs on %s's wrists.", ReturnName(playerid), ReturnName(otherid));
	}
	else
	{
		return SendErrorMessage(playerid, "You not police/gov.");
	}
    return 1;
}

CMD:release(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 1)
        return SendErrorMessage(playerid, "Kamu harus menjadi police officer.");
	
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 224.11, 118.50, 999.10))
		return SendErrorMessage(playerid, "You must be near an arrest point.");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    SendSyntaxMessage(playerid, "/release <ID/Name>");
	    return true;
	}

    if(otherid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player tersebut belum masuk!");
	
	if(otherid == playerid)
		return SendErrorMessage(playerid, "You cant release yourself!");

	if(PlayerData[otherid][pArrest] == 0)
	    return SendErrorMessage(playerid, "The player isn't in arrest!");

	PlayerData[otherid][pArrest] = 0;
	PlayerData[otherid][pArrestTime] = 0;
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SetPlayerPositionEx(otherid, 1526.69, -1678.05, 5.89, 267.76, 2000);
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

	SendClientMessageToAll(COLOR_BLUE, "[PRISON]"WHITE_E"Officer %s telah membebaskan %s dari penjara.", ReturnName(playerid), ReturnName(otherid));
	return true;
}


CMD:arrest(playerid, params[])
{
    static
        denda,
		cellid,
        times,
		otherid;

    if(PlayerData[playerid][pFaction] != 1)
        return SendErrorMessage(playerid, "Kamu harus menjadi police officer.");
		
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 224.11, 118.50, 999.10))
		return SendErrorMessage(playerid, "You must be near an arrest point.");

    if(sscanf(params, "uddd", otherid, cellid, times, denda))
        return SendSyntaxMessage(playerid, "/arrest [playerid/PartOfName] [cell id] [minutes] [denda]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "The player is disconnected or not near you.");
		
	/*if(otherid == playerid)
		return SendErrorMessage(playerid, "You cant arrest yourself!");*/

    if(times < 1 || times > 120)
        return SendErrorMessage(playerid, "The specified time can't be below 1 or above 120.");
		
	if(cellid < 1 || cellid > 4)
        return SendErrorMessage(playerid, "The specified cell id can't be below 1 or above 4.");
		
	if(denda < 100 || denda > 20000)
        return SendErrorMessage(playerid, "The specified denda can't be below 100 or above 20,000.");

    /*if(!IsPlayerNearArrest(playerid))
        return SendErrorMessage(playerid, "You must be near an arrest point.");*/

	GivePlayerMoneyEx(otherid, -denda);
    PlayerData[otherid][pArrest] = cellid;
    PlayerData[otherid][pArrestTime] = times * 60;
	
	SetPlayerArrest(otherid, cellid);

    
    SendClientMessageToAll(COLOR_BLUE, "[PRISON]"WHITE_E" %s telah ditangkap dan dipenjarakan oleh polisi selama %d hari dengan denda "GREEN_E"%s.", ReturnName(otherid), times, FormatMoney(denda));
    return 1;
}

CMD:getloc(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 1)
		return SendErrorMessage(playerid, "Kamu harus menjadi police officer.");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    SendSyntaxMessage(playerid, "/getloc <ID/Name>");
	    return true;
	}

	if(PlayerData[playerid][pSuspectTimer] > 1)
		return SendErrorMessage(playerid, "Anad harus menunggu %d detik untuk melanjutkan GetLoc",PlayerData[playerid][pSuspectTimer]);

    if(otherid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player tersebut belum masuk!");
	
	if(otherid == playerid)
		return SendErrorMessage(playerid, "You cant getloc yourself!");

	if(PlayerData[otherid][pPhone] == 0) return SendErrorMessage(playerid, "Player tersebut belum memiliki Ponsel");
	if(PlayerData[otherid][pUsePhone] == 0) return SendErrorMessage(playerid, "Tidak dapat mendeteksi lokasi, Ponsel tersebut yang dituju sedang Offline");

	new Float:sX, Float:sY, Float:sZ;
	GetPlayerPos(otherid, sX, sY, sZ);
	SetPlayerCheckpoint(playerid, sX, sY, sZ, 5.0);
	PlayerData[playerid][pSuspectTimer] = 120;
	SendInfoMessage(playerid, "Target Nama : %s", PlayerData[otherid][pName]);
	SendInfoMessage(playerid, "Target Akun Twitter : %s", PlayerData[otherid][pTwittername]);
	SendInfoMessage(playerid, "Lokasi : %s", GetLocation(sX, sY, sZ));
	SendInfoMessage(playerid, "Nomer Telepon : %d", PlayerData[otherid][pPhone]);
	return 1;
}

/*CMD:su(playerid, params[])
{
	new crime[64];
	if(sscanf(params, "us[64]", otherid, crime)) return SendSyntaxMessage(playerid, "(/su)spect [playerid] [crime discription]");

	if (PlayerData[playerid][pFaction] == 1 || PlayerData[playerid][pFaction] == 2)
	{
		if(IsPlayerConnected(otherid))
		{
			if(otherid != INVALID_PLAYER_ID)
			{
				if(otherid == playerid)
				{
					SendErrorMessage(playerid, COLOR_GREY, "Kamu tidak dapat mensuspek dirimu!");
					return 1;
				}
				if(PlayerData[playerid][pFaction] > 0)
				{
					SendErrorMessage(playerid, COLOR_GREY, "Tidak dapat mensuspek fraksi!");
					return 1;
				}
				WantedPoints[otherid] += 1;
				PlayerData[playerid][pSuspect] = 1;
				SetPlayerCriminal(otherid,playerid, crime);
				return 1;
			}
		}
		else
		{
			SendErrorMessage(playerid, "Invalid player specified.");
			return 1;
		}
	}
	else
	{
		SendErrorMessage(playerid, "   You are not a Cop/Gov!");
	}
	return 1;
}*/

CMD:ticket(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 1)
			return SendErrorMessage(playerid, "Kamu harus menjadi sapd officer.");
	
	new vehid, ticket;
	if(sscanf(params, "dd", vehid, ticket))
		return SendSyntaxMessage(playerid, "/ticket [vehid] [amount] | /checkveh - for find vehid");
	
	if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
		return SendErrorMessage(playerid, "Invalid id");
	
	if(ticket < 0 || ticket > 500)
		return SendErrorMessage(playerid, "Amount max of ticket is $1 - $500!");
	
	new nearid = GetNearestVehicleToPlayer(playerid, 5.0, false);
	if(nearid != vehid)
		return SendErrorMessage(playerid, "Kendaraan tersebut tidak di dekatmu!");

	if((vehid = Vehicle_GetID(nearid)) != -1)
	{
		if(VehicleData[vehid][cTicket] >= 2000)
			return SendErrorMessage(playerid, "Kendaraan ini sudah mempunyai terlalu banyak ticket!");
			
		VehicleData[vehid][cTicket] += ticket;
		SendInfoMessage(playerid, "Anda telah menilang kendaraan %s(id: %d) dengan denda sejumlah "RED_E"%s", GetVehicleName(nearid), nearid, FormatMoney(ticket));
	}
	else 
		SendErrorMessage(playerid, "Terjadi kesalahan!");	

	return 1;
}

CMD:checkvstorage(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 1)
		if(PlayerData[playerid][pAdmin] < 2)
			return SendErrorMessage(playerid, "Kamu harus menjadi sapd officer.");

	if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Kamu harus keluar dari kendaraan!");

	static vehid, carid;
	if(sscanf(params, "d", vehid))
		return SendSyntaxMessage(playerid, "/checkvstorage [vehicleid] | /checkveh - find near vehicle");

	if(GetNearestVehicleToPlayer(playerid, 3.0, false) != vehid)
		return SendErrorMessage(playerid, "Kendaraan tersebut tidak di dekatmu!");

	if(!GetTrunkStatus(vehid) && !IsABike(vehid)) 
		return SendErrorMessage(playerid, "Please open the vehicle trunk!");

	if((carid = Vehicle_GetID(vehid)) != -1)
	{
		if(Vehicle_IsOwner(playerid, carid))
			return SendErrorMessage(playerid, "Kamu adalah pemilik dari kendaraan ini!");

		if(PlayerData[playerid][pAdmin] >= 2 && PlayerData[playerid][pAdminDuty])
		{
			SetPVarInt(playerid, "vStorageID", carid);
			VehicleStorage_Open(playerid, true);
		}
		else
		{
			if(PlayerData[playerid][pActivityTime] > 0)
				return SendErrorMessage(playerid, "Kamu masih ada activity!");

			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s checking into %s's trunk.", ReturnName(playerid), GetVehicleName(vehid));
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, false, false, false, false, 0, SYNC_ALL);
			PlayerData[playerid][pProducting] = SetTimerEx("CheckStorage", 1000, true, "id", playerid, carid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Check Storage...");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
		}
	}
	else
		SendErrorMessage(playerid, "Terjadi kesalahan!");

	return 1;
}

public:CheckStorage(playerid, carid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(PlayerData[playerid][pProducting])) return 0;
	if(PlayerData[playerid][pActivityTime] >= 100)
	{
		SetPVarInt(playerid, "vStorageID", carid);
		VehicleStorage_Open(playerid, true);

		KillTimer(PlayerData[playerid][pProducting]);
		PlayerData[playerid][pActivityTime] = 0;
		HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		ClearAnimations(playerid);
	}
	else if(PlayerData[playerid][pActivityTime] < 100)
	{
		PlayerData[playerid][pActivityTime] += 10;
		SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, false, false, false, false, 0, SYNC_ALL);
	}
	return 1;
}

CMD:checkveh(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 1)
		if(PlayerData[playerid][pAdmin] < 1)
			return SendErrorMessage(playerid, "Kamu harus menjadi sapd officer.");
		
	static carid;
	new vehicleid = GetNearestVehicleToPlayer(playerid, 3.0, false);

	if(vehicleid == INVALID_VEHICLE_ID || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "You not in near any vehicles.");
	
	if((carid = Vehicle_GetID(vehicleid)) != -1)
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE reg_id='%d'", VehicleData[carid][cOwner]);
		mysql_query(g_SQL, query);
		new rows = cache_num_rows();
		if(rows) 
		{
			new owner[32];
			cache_get_value_index(0, 0, owner);
			
			if(strcmp(VehicleData[carid][cPlate], "NoHave"))
			{
				SendInfoMessage(playerid, "ID: %d | Model: %s | Owner: %s | Plate: %s | Plate Time: %s", vehicleid, GetVehicleName(vehicleid), owner, VehicleData[carid][cPlate], ReturnTimelapse(gettime(), VehicleData[carid][cPlateTime]));
			}
			else
			{
				SendInfoMessage(playerid, "ID: %d | Model: %s | Owner: %s | Plate: None | Plate Time: None", vehicleid, GetVehicleName(vehicleid), owner);
			}
		}
		else
		{
			SendErrorMessage(playerid, "This vehicle no owned found!");
			return 1;
		}
	}
	else
	{
		SendErrorMessage(playerid, "You are not in near owned private vehicle.");
		return 1;
	}	
	return 1;
}


CMD:takemarijuana(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 1)
        return SendErrorMessage(playerid, "Kamu harus menjadi sapd officer.");
	if(PlayerData[playerid][pFactionRank] < 1)
		return SendErrorMessage(playerid, "You must be 1 rank level!");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    SendSyntaxMessage(playerid, "/takemarijuana <ID/Name> | Melenyapkan Marijuana");
	    return true;
	}

	if(!IsPlayerConnected(otherid) || otherid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player tersebut belum masuk!");

 	if(!NearPlayer(playerid, otherid, 4.0))
        return SendErrorMessage(playerid, "The specified player is disconnected or not near you.");
		
	
	Inventory_Set(otherid, "Marijuana", 0);
	SendInfoMessage(playerid, "Anda telah mengambil semua marijuana milik %s.", ReturnName(otherid));
	SendInfoMessage(otherid, "Officer %s telah mengambil semua marijuana milik anda", ReturnName(playerid));
	return 1;
}

CMD:takedl(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 1)
        return SendErrorMessage(playerid, "Kamu harus menjadi sapd officer.");
	if(PlayerData[playerid][pFactionRank] < 2)
		return SendErrorMessage(playerid, "You must be 2 rank level!");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    SendSyntaxMessage(playerid, "/takedl <ID/Name> | Tilang Driving License(SIM)");
	    return true;
	}

	if(!IsPlayerConnected(otherid) || otherid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player tersebut belum masuk!");

 	if(!NearPlayer(playerid, otherid, 4.0))
        return SendErrorMessage(playerid, "The specified player is disconnected or not near you.");
		
	PlayerData[otherid][pDriveLic] = 0;
	PlayerData[otherid][pDriveLicTime] = 0;
	SendInfoMessage(playerid, "Anda telah menilang Driving License milik %s.", ReturnName(otherid));
	SendInfoMessage(otherid, "Officer %s telah menilang Driving License milik anda", ReturnName(playerid));
	return 1;
}

//SAGS Commands
CMD:sagsonline(playerid, params[])
{
	new duty[16], lstr[1024];
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\tDuty Time\n");
	foreach(new i: Player)
	{
		if(PlayerData[i][pFaction] == 2)
		{
			switch(PlayerData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = ""BLUE_E"On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s\t%d detik", lstr, PlayerData[i][pName], i, GetFactionRank(i), PlayerData[i][pFactionRank], duty, PlayerData[i][pOnDutyTime]);
			format(lstr, sizeof(lstr), "%s\n", lstr);
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "SAGS Online", lstr, "Close", "");
	return 1;
}

CMD:setcouple(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 2)
		return SendErrorMessage(playerid, "You aren't SAGS!");

	new otherid, otherid2, status;
	if(sscanf(params, "uud", otherid, otherid2, status))
		return SendSyntaxMessage(playerid, "/setcouple <PlayerID/PartOfName> <WithID/PartOfName> <status>");

	if(!PlayerData[otherid][pSpawned])
		return SendErrorMessage(playerid, "PlayerID 1 tidak ditemukan!");

	if(!PlayerData[otherid2][pSpawned])
		return SendErrorMessage(playerid, "PlayerID 2 tidak ditemukan!");

	if(!NearPlayer(otherid2, otherid, 5.0))
		return SendErrorMessage(playerid, "Target tidak saling berdekatan!");

	if(!NearPlayer(playerid, otherid, 5.0))
		return SendErrorMessage(playerid, "Target1 tidak dekat denganmu!");

	if(!NearPlayer(playerid, otherid2, 5.0))
		return SendErrorMessage(playerid, "Target2 tidak dekat denganmu!");

	if(PlayerData[otherid][pGender] == PlayerData[otherid2][pGender])
		return SendErrorMessage(playerid, "Kamu tidak bisa menjodohkan orang tersebut dengan gender yang sama!");

	if(otherid == otherid2)
		return SendErrorMessage(playerid, "Tidak dapat menjodohkan jika id sama!");

	if(status == 1)
	{
		PlayerData[otherid][pCouple] = PlayerData[otherid2][pID];
		PlayerData[otherid2][pCouple] = PlayerData[otherid][pID];

		SendNearbyMessage(playerid, 50.0, COLOR_BLUE, "GOVERNMENT: {ffffff}%s telah menjodohkan {FFFF00}%s {FFFFFF}dan{FFFF00} %s {FFFFFF}menjadi seorang couple.");
	}
	else
	{
		PlayerData[otherid][pCouple] = -1;
		PlayerData[otherid2][pCouple] = -1;

		SendNearbyMessage(playerid, 50.0, COLOR_BLUE, "GOVERNMENT: {ffffff}%s telah memisahkan {FFFF00}%s {FFFFFF}dan{FFFF00} %s {FFFFFF}menjadi seorang couple.", ReturnName(playerid), ReturnName(otherid), ReturnName(otherid2));
	}
	return 1;
}

//SAMD Commands
CMD:loadinjured(playerid, params[])
{
    static
        seatid,
		otherid;

    if(PlayerData[playerid][pFaction] != 3)
        return SendErrorMessage(playerid, "You must be part of a medical faction.");

    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/loadinjured [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 10.0))
        return SendErrorMessage(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "You can't load yourself into an ambulance.");

    if(!PlayerData[otherid][pInjured])
        return SendErrorMessage(playerid, "That player is not injured.");
	
	if(!IsPlayerInAnyVehicle(playerid))
	{
	    SendErrorMessage(playerid, "You must be in a Ambulance to load patient!");
	    return true;
	}
		
	new i = GetPlayerVehicleID(playerid);
    if(GetVehicleModel(i) == 416)
    {
        seatid = GetAvailableSeat(i, 2);

        if(seatid == -1)
            return SendErrorMessage(playerid, "There is no room for the patient.");

        ClearAnimations(otherid);
        PlayerData[otherid][pInjured] = 2;

        PutPlayerInVehicle(otherid, i, seatid);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s opens up the ambulance and loads %s on the stretcher.", ReturnName(playerid), ReturnName(otherid));

        TogglePlayerControllable(otherid, false);
        SetPlayerHealth(otherid, 100.0);
        SendInfoMessage(otherid, "You're injured ~r~now you're on ambulance.");
        return 1;
    }
    else SendErrorMessage(playerid, "You must be in an ambulance.");
    return 1;
}

CMD:dropinjured(playerid, params[])
{

    if(PlayerData[playerid][pFaction] != 3)
        return SendErrorMessage(playerid, "You must be part of a medical faction.");
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/dropinjured [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid)))
        return SendErrorMessage(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "You can't deliver yourself to the hospital.");

    if(PlayerData[otherid][pInjured] != 2)
        return SendErrorMessage(playerid, "That player is not injured.");

    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1142.38, -1330.74, 13.62))
    {
		RemovePlayerFromVehicle(otherid);
		PlayerData[otherid][pHospital] = 1;
		PlayerData[otherid][pHospitalTime] = 0;
		PlayerData[otherid][pInjured] = 1;
		ResetPlayerWeaponsEx(otherid);
        SendInfoMessage(playerid, "You have delivered %s to the hospital.", ReturnName(otherid));
        SendInfoMessage(otherid, "You have recovered at the nearest hospital by officer %s.", ReturnName(playerid));
    }
    else SendErrorMessage(playerid, "You must be near a hospital deliver location.");
    return 1;
}

CMD:samdonline(playerid, params[])
{
	new duty[16], lstr[1024];
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\tDuty Time\n");
	foreach(new i: Player)
	{
		if(PlayerData[i][pFaction] == 3)
		{
			switch(PlayerData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = ""BLUE_E"On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s\t%d detik", lstr, PlayerData[i][pName], i, GetFactionRank(i), PlayerData[i][pFactionRank], duty, PlayerData[i][pOnDutyTime]);
			format(lstr, sizeof(lstr), "%s\n", lstr);
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "SAMD Online", lstr, "Close", "");
	return 1;
}

CMD:ems(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 3)
        return SendErrorMessage(playerid, "Kamu harus menjadi samd officer.");
	
	foreach(new ii : Player)
	{
		if(PlayerData[ii][pInjured])
		{
			SendClientMessage(playerid, COLOR_PINK2, "EMS Player: "WHITE_E"%s(id: %d)", ReturnName(ii), ii);
		}
	}
	SendInfoMessage(playerid, "/findems [id] to search injured player!");
	return 1;
}

CMD:findems(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 3)
        return SendErrorMessage(playerid, "Kamu harus menjadi samd officer.");
		
	new otherid;
	if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/findems [playerid/PartOfName]");
	
	if(!IsPlayerConnected(otherid)) return SendErrorMessage(playerid, "Player is not connected");
	
	if(otherid == playerid)
        return SendErrorMessage(playerid, "You can't find yourself.");
	
	if(!PlayerData[otherid][pInjured]) return SendErrorMessage(playerid, "You can't find a player that's not injured.");
	
	new Float:x, Float:y, Float:z;
	GetPlayerPos(otherid, x, y, z);
	SetPlayerCheckpoint(playerid, x, y, x, 4.0);
	PlayerData[playerid][pFindEms] = otherid;
	SendInfoMessage(otherid, "SAMD Officer %s sedang menuju ke lokasi anda. harap tunggu!", ReturnName(playerid));
	return 1;
}

CMD:rescue(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 3)
        return SendErrorMessage(playerid, "Kamu harus menjadi samd officer.");
	
	if(Inventory_Has(playerid, "Medkit") < 1) return SendErrorMessage(playerid, "You need medkit.");
	new otherid;
	if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/rescue [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "You can't rescue yourself.");

    if(!PlayerData[otherid][pInjured])
        return SendErrorMessage(playerid, "That player is not injured.");
	
	Inventory_Remove(playerid, "Medkit");
	
	SetPlayerHealthEx(otherid, 50.0);
    PlayerData[otherid][pInjured] = 0;
	PlayerData[otherid][pHospital] = 0;
	PlayerData[otherid][pSick] = 0;
    ClearAnimations(otherid);
	
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has rescuered %s with medkit tools.", ReturnName(playerid), ReturnName(otherid));
    SendInfoMessage(otherid, "Officer %s has rescue your character.", ReturnName(playerid));
	return 1;
}

CMD:salve(playerid, params[])
{
	new Float:health;
	
	GetPlayerHealth(playerid, health);
	if(PlayerData[playerid][pFaction] != 3)
        return SendErrorMessage(playerid, "Kamu harus menjadi samd officer.");
	
	if(Inventory_Has(playerid, "Medicine") < 1) return SendErrorMessage(playerid, "Kamu butuh Medicine.");
	new otherid;
	if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/salve [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "Kamu tidak bisa mensalve dirimu sendiri.");

    if(PlayerData[otherid][pSick] == 0)
        return SendErrorMessage(playerid, "Player itu tidak sakit.");
	
	Inventory_Remove(playerid, "Medicine");
	
	//SetPlayerHealthEx(otherid, 50.0);
    //PlayerData[otherid][pInjured] = 0;
	//PlayerData[otherid][pHospital] = 0;
	SetPlayerHealth(playerid, health+50);
	PlayerData[otherid][pHunger] += 20;
	PlayerData[otherid][pEnergy] += 20;
	PlayerData[otherid][pSick] = 0;
	PlayerData[otherid][pSickTime] = 0;
    ClearAnimations(otherid);
	SetPlayerDrunkLevel(otherid, 0);
	
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has given medicine to %s with the right hand.", ReturnName(playerid), ReturnName(otherid));
    SendInfoMessage(otherid, "Officer %s has resalve your sick character.", ReturnName(playerid));
	return 1;
}

CMD:healbone(playerid, params[])
{
	new Float:health;
	
	GetPlayerHealth(playerid, health);
	if(PlayerData[playerid][pFaction] != 3)
        return SendErrorMessage(playerid, "Kamu harus menjadi samd officer.");
	
	if(Inventory_Has(playerid, "Medicine") < 1) return SendErrorMessage(playerid, "Kamu butuh Medicine.");
	new otherid;
	if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/healbone [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "Kamu tidak bisa memperbaiki kesehatan tulang dirimu sendiri.");
	
	Inventory_Remove(playerid, "Medicine");
	
	//SetPlayerHealthEx(otherid, 50.0);
    //PlayerData[otherid][pInjured] = 0;
	//PlayerData[otherid][pHospital] = 0;
	SetPlayerHealth(playerid, health+50);
	PlayerData[otherid][pHead] += 60;
	PlayerData[otherid][pPerut] += 60;
	PlayerData[otherid][pRHand] += 60;
	PlayerData[otherid][pLHand] += 60;
	PlayerData[otherid][pRFoot] += 60;
	PlayerData[otherid][pLFoot] += 60;
	PlayerData[otherid][pSickTime] = 0;
    ClearAnimations(otherid);
	SetPlayerDrunkLevel(otherid, 0);
	
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has given medicine to %s with the right hand.", ReturnName(playerid), ReturnName(otherid));
    SendInfoMessage(otherid, "Officer %s has resalve your sick character.", ReturnName(playerid));
	return 1;
}

//SANEW Commands
CMD:sanaonline(playerid, params[])
{
	new duty[16], lstr[1024];
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\tDuty Time\n");
	foreach(new i: Player)
	{
		if(PlayerData[i][pFaction] == 4)
		{
			switch(PlayerData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = ""BLUE_E"On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s\t%d detik", lstr, PlayerData[i][pName], i, GetFactionRank(i), PlayerData[i][pFactionRank], duty, PlayerData[i][pOnDutyTime]);
			format(lstr, sizeof(lstr), "%s\n", lstr);
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "SANA Online", lstr, "Close", "");
	return 1;
}

CMD:broadcast(playerid, params[])
{
    if(PlayerData[playerid][pFaction] != 4)
        return SendErrorMessage(playerid, "You must be part of a news faction.");

    //if(!IsSANEWCar(GetPlayerVehicleID(playerid)) || !IsPlayerInRangeOfPoint(playerid, 5, 255.63, 1757.39, 701.09))
    //    return SendErrorMessage(playerid, "You must be inside a news van or chopper or in sanew studio.");

    if(!PlayerData[playerid][pBroadcast])
    {
        PlayerData[playerid][pBroadcast] = true;

        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has started a news broadcast.", ReturnName(playerid));
        SendServerMessage(playerid, "You have started a news broadcast (use \"/bc [broadcast text]\" to broadcast).");
    }
    else
    {
        PlayerData[playerid][pBroadcast] = false;

        foreach (new i : Player) if(PlayerData[i][pNewsGuest] == playerid) 
		{
            PlayerData[i][pNewsGuest] = INVALID_PLAYER_ID;
        }
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has stopped a news broadcast.", ReturnName(playerid));
        SendServerMessage(playerid, "You have stopped the news broadcast.");
    }
    return 1;
}


CMD:bc(playerid, params[])
{
    if(PlayerData[playerid][pFaction] != 4)
        return SendErrorMessage(playerid, "You must be part of a news faction.");

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/bc [broadcast text]");

    //if(!IsSANEWCar(GetPlayerVehicleID(playerid)) || !IsPlayerInRangeOfPoint(playerid, 5, 255.63, 1757.39, 701.09))
    //    return SendErrorMessage(playerid, "You must be inside a news van or chopper or in sanew studio.");

    if(!PlayerData[playerid][pBroadcast])
        return SendErrorMessage(playerid, "You must be broadcasting to use this command.");

    if(strlen(params) > 64) {
        foreach (new i : Player) /*if(!PlayerData[i][pDisableBC])*/ {
            SendClientMessage(i, COLOR_ORANGE, "[SANA] Reporter %s: %.64s", ReturnName(playerid), params);
            SendClientMessage(i, COLOR_ORANGE, "...%s", params[64]);
        }
    }
    else {
        foreach (new i : Player) /*if(!PlayerData[i][pDisableBC])*/ {
            SendClientMessage(i, COLOR_ORANGE, "[SANA] Reporter %s: %s", ReturnName(playerid), params);
        }
    }
    return 1;
}

CMD:live(playerid, params[])
{
    static
        livechat[128];
        
    if(sscanf(params, "s[128]", livechat))
        return SendSyntaxMessage(playerid, "/live [live chat]");

    if(PlayerData[playerid][pNewsGuest] == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You're now invite by sanew member to live!");

    /*if(!IsNewsVehicle(GetPlayerVehicleID(playerid)) || !IsPlayerInRangeOfPoint(playerid, 5, 255.63, 1757.39, 701.09))
        return SendErrorMessage(playerid, "You must in news chopper or in studio to live.");*/

    if(PlayerData[PlayerData[playerid][pNewsGuest]][pFaction] == 4)
    {
        foreach (new i : Player) /*if(!PlayerData[i][pDisableBC])*/ {
            SendClientMessage(i, COLOR_LIGHTGREEN, "[SANA] Guest %s: %s", ReturnName(playerid), livechat);
        }
    }
    return 1;
}

CMD:inviteguest(playerid, params[])
{
    if(PlayerData[playerid][pFaction] != 4)
        return SendErrorMessage(playerid, "You must be part of a news faction.");
		
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/inviteguest [playerid/PartOfName]");

    if(!PlayerData[playerid][pBroadcast])
        return SendErrorMessage(playerid, "You must be broadcasting to use this command.");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "You can't add yourself as a guest.");

    if(PlayerData[otherid][pNewsGuest] == playerid)
        return SendErrorMessage(playerid, "That player is already a guest of your broadcast.");

    if(PlayerData[otherid][pNewsGuest] != INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "That player is already a guest of another broadcast.");

    PlayerData[otherid][pNewsGuest] = playerid;

    SendInfoMessage(playerid, "You have added %s as a broadcast guest.", ReturnName(otherid));
    SendInfoMessage(otherid, "%s has added you as a broadcast guest ((/live to start broadcast)).", ReturnName(otherid));
    return 1;
}

CMD:removeguest(playerid, params[])
{

    if(PlayerData[playerid][pFaction] != 4)
        return SendErrorMessage(playerid, "You must be part of a news faction.");
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/removeguest [playerid/PartOfName]");

    if(!PlayerData[playerid][pBroadcast])
        return SendErrorMessage(playerid, "You must be broadcasting to use this command.");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "You can't remove yourself as a guest.");

    if(PlayerData[otherid][pNewsGuest] != playerid)
        return SendErrorMessage(playerid, "That player is not a guest of your broadcast.");

    PlayerData[otherid][pNewsGuest] = INVALID_PLAYER_ID;

    SendInfoMessage(playerid, "You have removed %s from your broadcast.", ReturnName(otherid));
    SendInfoMessage(otherid, "%s has removed you from their broadcast.", ReturnName(otherid));
    return 1;
}

// SAFD Commands
CMD:safdonline(playerid, params[])
{
	new duty[16], lstr[1024];
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\tDuty Time\n");
	foreach(new i: Player)
	{
		if(PlayerData[i][pFaction] == 5)
		{
			switch(PlayerData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = ""RED_E"On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s\t%d detik", lstr, PlayerData[i][pName], i, GetFactionRank(i), PlayerData[i][pFactionRank], duty, PlayerData[i][pOnDutyTime]);
			format(lstr, sizeof(lstr), "%s\n", lstr);
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "SAFD Online", lstr, "Close", "");
	return 1;
}

CMD:taketool(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 5)
		return SendErrorMessage(playerid, "You aren't a SAFD!");

	new Float:x, Float:y, Float:z;
	forex(vehicleid, MAX_VEHICLES) if(IsValidVehicle(vehicleid))
	{
		if(IsSAFDCar(vehicleid))
		{
			GetVehiclePos(vehicleid, x, y, z);
			if(IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
			{
				if(GetVehicleModel(vehicleid) == 544 || GetVehicleModel(vehicleid) == 407)
				{
					ResetWeapon(playerid, WEAPON_FIREEXTINGUISHER);
					GivePlayerWeaponEx(playerid, WEAPON_FIREEXTINGUISHER, 1000);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the fire truck and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON_FIREEXTINGUISHER));
				}
				else
					SendErrorMessage(playerid, "This vehicle is not fire truck!");
			}
		}
	}
	return 1;
}

CMD:storetool(playerid, params[])
{
	if(PlayerData[playerid][pFaction] != 5)
		return SendErrorMessage(playerid, "You aren't a SAFD!");

	new Float:x, Float:y, Float:z;
	forex(vehicleid, MAX_VEHICLES) if(IsValidVehicle(vehicleid))
	{
		if(IsSAFDCar(vehicleid))
		{
			GetVehiclePos(vehicleid, x, y, z);
			if(IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
			{
				if(GetVehicleModel(vehicleid) == 544 || GetVehicleModel(vehicleid) == 407)
				{
					if(GetPlayerWeaponEx(playerid) == WEAPON_FIREEXTINGUISHER)
					{
						ResetWeapon(playerid, WEAPON_FIREEXTINGUISHER);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s put in %s to the fire truck storage.", ReturnName(playerid), ReturnWeaponName(WEAPON_FIREEXTINGUISHER));
					}
					else
						SendErrorMessage(playerid, "You're not holding a Fire Exhauster!");
				}
				else
					SendErrorMessage(playerid, "This vehicle is not fire truck!");
			}
		}
	}
	return 1;
}

forward DutyHour(playerid);
public DutyHour(playerid)
{
	if(PlayerData[playerid][pOnDuty] < 1)
		return KillTimer(DutyTimer[playerid]);

	PlayerData[playerid][pDutyHour] += 1;
	if(PlayerData[playerid][pDutyHour] == 3600)
	{
		if(PlayerData[playerid][pFaction] == 1)
		{
			AddPlayerSalary(playerid, "Duty(SAPD)", 750);
			PlayerData[playerid][pDutyHour] = 0;
			SendServerMessage(playerid, "Anda telah Duty selama 1 Jam dan Anda mendapatkan Pending Salary anda");
		}
		else if(PlayerData[playerid][pFaction] == 2)
		{
			AddPlayerSalary(playerid, "Duty(SAGS)", 750);
			PlayerData[playerid][pDutyHour] = 0;
			SendServerMessage(playerid, "Anda telah Duty selama 1 Jam dan Anda mendapatkan Pending Salary anda");
		}
		else if(PlayerData[playerid][pFaction] == 3)
		{
			AddPlayerSalary(playerid, "Duty(SAMD)", 750);
			PlayerData[playerid][pDutyHour] = 0;
			SendServerMessage(playerid, "Anda telah Duty selama 1 Jam dan Anda mendapatkan Pending Salary anda");
		}
		else if(PlayerData[playerid][pFaction] == 4)
		{
			AddPlayerSalary(playerid, "Duty(SANEWS)", 750);
			PlayerData[playerid][pDutyHour] = 0;
			SendServerMessage(playerid, "Anda telah Duty selama 1 Jam dan Anda mendapatkan Pending Salary anda");
		}
		else if(PlayerData[playerid][pFaction] == 5)
		{
			AddPlayerSalary(playerid, "Duty(SAFD)", 750);
			PlayerData[playerid][pDutyHour] = 0;
			SendServerMessage(playerid, "Anda telah Duty selama 1 Jam dan Anda mendapatkan Pending Salary anda");
		}
	}
	return 1;
}

CMD:despawnsags(playerid, params[])
{
	// Sags Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1455.3724, -1806.4493, 13.5468) || IsPlayerInRangeOfPoint(playerid, 8.0, 1538.7069, -1765.2023, 13.3017) ||
		IsPlayerInRangeOfPoint(playerid, 8.0, 1422.8310, -1765.1185, 13.2999))
	{
		if(PlayerData[playerid][pFaction] != 2)
	        return SendErrorMessage(playerid, "You aren't a Sags Faction!");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehicleid))
			return SendErrorMessage(playerid, "Kamu tidak berada didalam kendaraan.");

    	DestroyVehicle(SAGSVeh[playerid]);
    	SAGSVeh[playerid] = INVALID_VEHICLE_ID;
    	GameTextForPlayer(playerid, "~w~SAGS Vehicle ~r~Despawned", 3500, 3);
    }
    return 1;
}

CMD:spawnsags(playerid, params[])
{
    // Sags Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1455.3724, -1806.4493, 13.5468))
	{
		if(PlayerData[playerid][pFaction] != 2)
	        return SendErrorMessage(playerid, "You aren't a Sags Faction!");

		if(IsValidVehicle(SAGSVeh[playerid])) return SendErrorMessage(playerid,"Anda sudah mengeluarkan 1 kendaraan!");

	    new Zanv[10000], String[10000];
	    strcat(Zanv, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Sags\tCars\n");// 596
		strcat(Zanv, String);
		format(String, sizeof(String), "Sags\tMotorcycle\n");// 597
		strcat(Zanv, String);
		format(String, sizeof(String), "Helicopter\tHelicopter\n");// 598
		strcat(Zanv, String);
		ShowPlayerDialog(playerid,DIALOG_SAGS_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles SA:GS", Zanv, "Spawn","Cancel");
	}
	return 1;
}

CMD:despawnsana(playerid, params[])
{
	// Sana Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 743.5262, -1332.2343, 13.8414) || IsPlayerInRangeOfPoint(playerid, 8.0, 741.9764,-1371.2441,25.8835))
	{
		if(PlayerData[playerid][pFaction] != 4)
	        return SendErrorMessage(playerid, "You aren't a Sana Faction!");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehicleid))
			return SendErrorMessage(playerid, "Kamu tidak berada didalam kendaraan.");

    	DestroyVehicle(SANAVeh[playerid]);
    	SANAVeh[playerid] = INVALID_VEHICLE_ID;
    	GameTextForPlayer(playerid, "~w~SANA Vehicle ~r~Despawned", 3500, 3);
    }
    return 1;
}

CMD:spawnsana(playerid, params[])
{
    // Sana Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 743.5262, -1332.2343, 13.8414))
	{
		if(PlayerData[playerid][pFaction] != 4)
	        return SendErrorMessage(playerid, "You aren't a Sana Faction!.");

		if(IsValidVehicle(SANAVeh[playerid])) return SendErrorMessage(playerid,"Anda sudah mengeluarkan 1 kendaraan!");

	    new Zanv[10000], String[10000];
	    strcat(Zanv, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Sanew\tCars\n");// 596
		strcat(Zanv, String);
		format(String, sizeof(String), "Sanew\tMotorcycle\n");// 597
		strcat(Zanv, String);
		format(String, sizeof(String), "Helicopter\tHelicopter\n");// 598
		strcat(Zanv, String);
		ShowPlayerDialog(playerid,DIALOG_SANA_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles SA:NA", Zanv, "Spawn","Cancel");
	}
	return 1;
}

CMD:despawnmd(playerid, params[])
{
	// Samd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1131.5339, -1332.3248, 13.5797) || IsPlayerInRangeOfPoint(playerid, 8.0, 1162.8176, -1313.8239, 32.2215))
	{
		if(PlayerData[playerid][pFaction] != 3)
	        return SendErrorMessage(playerid, "You aren't a Samd Faction!");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehicleid))
			return SendErrorMessage(playerid, "Kamu tidak berada didalam kendaraan.");

    	DestroyVehicle(SAMDVeh[playerid]);
    	SAMDVeh[playerid] = INVALID_VEHICLE_ID;
    	GameTextForPlayer(playerid, "~w~SAMD Vehicles ~r~Despawned", 3500, 3);
    }
    return 1;
}

CMD:spawnmd(playerid, params[])
{
    // Samd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1131.5339, -1332.3248, 13.5797))
	{
		if(PlayerData[playerid][pFaction] != 3)
	        return SendErrorMessage(playerid, "You aren't a Samd Faction!");

		if(IsValidVehicle(SAMDVeh[playerid])) return SendErrorMessage(playerid,"Anda sudah mengeluarkan 1 kendaraan!");

	    new Zann[10000], String[10000];
	    strcat(Zann, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Ambulance\tCars\n");// 596
		strcat(Zann, String);
		format(String, sizeof(String), "Fire Truck\tCars\n");// 597
		strcat(Zann, String);
		format(String, sizeof(String), "Helicopter\tHelicopter\n");// 598
		strcat(Zann, String);
		format(String, sizeof(String), "Helicopter 2\tHelicopter\n"); // 599
		strcat(Zann, String);
		format(String, sizeof(String), "Premier\tSport Cars\n"); // 599
		strcat(Zann, String);
		ShowPlayerDialog(playerid,DIALOG_SAMD_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles SA:MD", Zann, "Spawn","Cancel");
	}
	return 1;
}

CMD:despawnsapd(playerid, params[])
{
	// Sapd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1568.40, -1695.66, 5.89) || IsPlayerInRangeOfPoint(playerid, 8.0, 1569.1587,-1641.0361,28.5788)
	|| IsPlayerInRangeOfPoint(playerid, 8.0, 1568.40, -1695.66, 5.89) || IsPlayerInRangeOfPoint(playerid, 8.0, 1569.1587,-1641.0361,28.5788))
	{
		if(PlayerData[playerid][pFaction] != 1)
	        return SendErrorMessage(playerid, "You aren't a Sapd Faction!");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehicleid))
			return SendErrorMessage(playerid, "Kamu tidak berada didalam kendaraan.");

    	DestroyVehicle(SAPDVeh[playerid]);
    	SAPDVeh[playerid] = INVALID_VEHICLE_ID;
		SendServerMessage(playerid, "Anda Berhasil Memasukkan Kendaraaan ke garasi sapd");
    	//GameTextForPlayer(playerid, "~w~SAPD Vehicles ~r~Despawned", 3500, 3);
    }
    return 1;
}

CMD:spawnsapd(playerid, params[])
{
    // Sapd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1568.40, -1695.66, 5.89) || IsPlayerInRangeOfPoint(playerid, 8.0, 1569.1587,-1641.0361,28.5788)
	|| IsPlayerInRangeOfPoint(playerid, 8.0, 1568.40, -1695.66, 5.89) || IsPlayerInRangeOfPoint(playerid, 8.0, 1569.1587,-1641.0361,28.5788))
	{
		if(PlayerData[playerid][pFaction] != 1)
	        return SendErrorMessage(playerid, "You aren't a Sapd Faction!");

		if(IsValidVehicle(SAPDVeh[playerid])) return SendErrorMessage(playerid,"Anda sudah mengeluarkan 1 kendaraan!");

	    new ZENN[10000], String[10000];
	    strcat(ZENN, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Police Ls\tCars\n");// 596
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Sf\tCars\n");// 597
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Lv\tCars\n");// 598
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Copcarru\tCars\n"); // 599
		strcat(ZENN, String);
		format(String, sizeof(String), "Police S.W.A.T\tCars\n"); // 601
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Enforcer\tCars\n"); // 427
		strcat(ZENN, String);
		format(String, sizeof(String), "Police F.B.I Truck\tCars\n"); // 528
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Infernus\tSport Cars\n"); // 411
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Sultan\tUnique Cars\n"); // 560
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Sanchez\tMotorcycle\n"); // 468
		strcat(ZENN, String);
		format(String, sizeof(String), "Police FCR-900\tMotorcycle\n");  // 521
		strcat(ZENN, String);
		format(String, sizeof(String), "Police HPV-1000\tMotorcycle\n");  // 523
		strcat(ZENN, String);
		format(String, sizeof(String), "Police NRG-500\tMotorcyle\n");// 596
		strcat(ZENN, String);
		format(String, sizeof(String), "Police TowTruck\tTruck\n");// 596
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Maverick\tHelicopter\n"); // 497
		strcat(ZENN, String);
		ShowPlayerDialog(playerid,DIALOG_SAPD_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles SA:PD", ZENN, "Spawn","Cancel");
	}
	return 1;
}

CMD:spawnsafd(playerid, params[])
{
    // Sags Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 951.7573, -1748.2733, 13.9448))
	{
		if(PlayerData[playerid][pFaction] != 5)
	        return SendErrorMessage(playerid, "You aren't a SAFD Faction!");

		if(IsValidVehicle(SAFDVeh[playerid])) return SendErrorMessage(playerid,"Anda sudah mengeluarkan 1 kendaraan!");

	    new Zanv[10000], String[10000];
	    strcat(Zanv, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Fire Truck 1\tTruck\n");// 596
		strcat(Zanv, String);
		format(String, sizeof(String), "Fire Truck 2\tTruck\n");// 597
		strcat(Zanv, String);
		format(String, sizeof(String), "Fire Maverick\tHelicopter\n");// 598
		strcat(Zanv, String);
		format(String, sizeof(String), "Fire Helicopter\tHelicopter\n");// 598
		strcat(Zanv, String);
		ShowPlayerDialog(playerid,DIALOG_SAFD_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles SA:FD", Zanv, "Spawn","Cancel");
	}
	return 1;
}

CMD:despawnsafd(playerid, params[])
{
	// Sapd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 951.7573, -1748.2733, 13.9448) || IsPlayerInRangeOfPoint(playerid, 8.0, 930.4425, -1703.7930, 13.7796))
	{
		if(PlayerData[playerid][pFaction] != 5)
	        return SendErrorMessage(playerid, "You aren't a SAFD Faction!");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehicleid))
			return SendErrorMessage(playerid, "Kamu tidak berada didalam kendaraan.");

    	DestroyVehicle(SAFDVeh[playerid]);
    	SAFDVeh[playerid] = INVALID_VEHICLE_ID;
		SendServerMessage(playerid, "Anda Berhasil Memasukkan Kendaraaan ke garasi safd");
    	//GameTextForPlayer(playerid, "~w~SAPD Vehicles ~r~Despawned", 3500, 3);
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_SAGS_GARAGE)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1455.3724, -1806.4493, 13.5468))
				{
					switch(random(2))
					{
						case 0: SAGSVeh[playerid] = CreateVehicle(409, 1441.7601, -1818.2517, 13.2158, 360.0000, 1, 1, VEHICLE_RESPAWN, true);
						case 1: SAGSVeh[playerid] = CreateVehicle(409, 1453.9023, -1819.2929, 13.2160, 360.0000, 1, 1, VEHICLE_RESPAWN, true);
					}
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAGS Vehicles '"YELLOW_E"/despawnsags"WHITE_E"' to despawn vehicles");
			}
			case 1:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1455.3724, -1806.4493, 13.5468))
				{
					switch(random(2))
					{
						case 0: SAGSVeh[playerid] = CreateVehicle(522, 1441.7601, -1818.2517, 13.2158, 360.0000, 1, 1, VEHICLE_RESPAWN, true);
						case 1: SAGSVeh[playerid] = CreateVehicle(522, 1453.9023, -1819.2929, 13.2160, 360.0000, 1, 1, VEHICLE_RESPAWN, true);
					}
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
			}
			case 2:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1455.3724, -1806.4493, 13.5468))
				{
					switch(random(2))
					{
						case 0: SAGSVeh[playerid] = CreateVehicle(487, 1538.7069, -1765.2023, 13.3017, 0.0000, 1, 1, VEHICLE_RESPAWN, true);
						case 1: SAGSVeh[playerid] = CreateVehicle(487, 1422.8310, -1765.1185, 13.2999, 0.0000, 1, 1, VEHICLE_RESPAWN, true);
					}
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
			}
		}
		SetVehicleNumberPlate(SAGSVeh[playerid], "HP-SAGS");
		PutPlayerInVehicle(playerid, SAGSVeh[playerid], 0);
	}
	if(dialogid == DIALOG_SANA_GARAGE)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.0, 743.5262, -1332.2343, 13.8414))
				{
					SANAVeh[playerid] = CreateVehicle(582, 751.3419,-1345.3467,13.8993,265.8653, 1, 1, VEHICLE_RESPAWN, true);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SANA Vehicles '"YELLOW_E"/despawnsana"WHITE_E"' to despawn vehicles");
			}
			case 1:
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.0, 743.5262, -1332.2343, 13.8414))
				{
					SANAVeh[playerid] = CreateVehicle(586, 751.3419,-1345.3467,13.8993,265.8653, 1, 1, VEHICLE_RESPAWN, true);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SANA Vehicles '"YELLOW_E"/despawnsana"WHITE_E"' to despawn vehicles");
			}
			case 2:
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.0, 743.5262, -1332.2343, 13.8414))
				{
					SANAVeh[playerid] = CreateVehicle(488, 741.9764, -1371.2441, 25.8835, 359.9998, 1, 1, VEHICLE_RESPAWN, true);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SANA Vehicles '"YELLOW_E"/despawnsana"WHITE_E"' to despawn vehicles");
			}
		}
		SetVehicleNumberPlate(SANAVeh[playerid], "HP-SANA");
		PutPlayerInVehicle(playerid, SANAVeh[playerid], 0);
	}
	if(dialogid == DIALOG_SAMD_GARAGE)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1131.5339, -1332.3248, 13.5797))
				{
					SAMDVeh[playerid] = CreateVehicle(416, 1120.0265, -1317.1208, 13.8679, 271.4225, 1, 3, VEHICLE_RESPAWN, true);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAMD Vehicles '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
			}
			case 1:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1131.5339, -1332.3248, 13.5797))
				{
					SAMDVeh[playerid] = CreateVehicle(407, 1120.0265, -1317.1208, 13.8679, 271.4225, -1, 3, VEHICLE_RESPAWN, true);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAMD Vehicles '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
			}
			case 2:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1131.5339, -1332.3248, 13.5797))
				{
					SAMDVeh[playerid] = CreateVehicle(563, 1162.8176, -1313.8239, 32.2215, 270.7216, 0, 1,VEHICLE_RESPAWN, false);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAMD Vehicles '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
			}
			case 3:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1131.5339, -1332.3248, 13.5797))
				{
					SAMDVeh[playerid] = CreateVehicle(487, 1162.8176, -1313.8239, 32.2215, 270.7216, -1,3,VEHICLE_RESPAWN, true);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAMD Vehicles '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
			}
			case 4:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1131.5339, -1332.3248, 13.5797))
				{
					SAMDVeh[playerid] = CreateVehicle(426, 1120.0265, -1317.1208, 13.8679, 271.4225, 1,1,VEHICLE_RESPAWN, true);
					AddVehicleComponent(SAMDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAMD Vehicles '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
			}
		}
		SetVehicleNumberPlate(SAMDVeh[playerid], "HP-SAMD");
		PutPlayerInVehicle(playerid, SAMDVeh[playerid], 0);
	}
	if(dialogid == DIALOG_SAPD_GARAGE)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(596, 1538.42, -1682.46, 5.59, 92.4917, 0, 1, VEHICLE_RESPAWN, false);

					AddVehicleComponent(SAPDVeh[playerid], 1098);
					SetVehicleHealth(SAPDVeh[playerid], 5000);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 1:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(597, 1538.42, -1682.46, 5.59, 92.4917, 0, 1, VEHICLE_RESPAWN, false);

					SetVehicleHealth(SAPDVeh[playerid], 5000);
					AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 2:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(598, 1538.42, -1682.46, 5.59, 92.4917, 0, 1,VEHICLE_RESPAWN, false);


					AddVehicleComponent(SAPDVeh[playerid], 1098);
					SetVehicleHealth(SAPDVeh[playerid], 5000);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 3:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(599, 1538.42, -1682.46, 5.59, 92.4917,0,1,VEHICLE_RESPAWN, false);

					SetVehicleHealth(SAPDVeh[playerid], 5000);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 4:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(601, 1538.42, -1682.46, 5.59, 92.4917,0,1,VEHICLE_RESPAWN, false);

					SetVehicleHealth(SAPDVeh[playerid], 5000);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 5:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(427, 1538.42, -1682.46, 5.59, 92.4917,0,1,VEHICLE_RESPAWN, false);

					SetVehicleHealth(SAPDVeh[playerid], 5000);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 6:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(528, 1538.42, -1682.46, 5.59, 92.4917,0,1,VEHICLE_RESPAWN, false);
					SetVehicleHealth(SAPDVeh[playerid], 5000);

				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 7:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(411, 1538.42, -1682.46, 5.59, 92.4917,0,1,VEHICLE_RESPAWN, false);

					tmpobjid = CreateDynamicObject(11701,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					AttachDynamicObjectToVehicle(tmpobjid, SAPDVeh[playerid], 0.000, 0.000, 0.720, 0.000, 0.000, 0.000);
					tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(tmpobjid, 0, "SAPD", 120, "Ariel", 36, 0, -1, 0, 1);
					AttachDynamicObjectToVehicle(tmpobjid, SAPDVeh[playerid], 1.109, 0.159, -0.029, 0.000, 0.000, 0.000);
					tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(tmpobjid, 0, "SAPD", 120, "Ariel", 36, 0, -1, 0, 1);
					AttachDynamicObjectToVehicle(tmpobjid, SAPDVeh[playerid], -1.100, 0.159, -0.029, 0.000, 0.000, 180.000);
					
					AddVehicleComponent(SAPDVeh[playerid], 1010);//nos
					SetVehicleHealth(SAPDVeh[playerid], 5000);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 8:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(560, 1538.42, -1682.46, 5.59, 92.4917,0,1,VEHICLE_RESPAWN, false);

					tmpobjid = CreateDynamicObject(11701,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					AttachDynamicObjectToVehicle(tmpobjid, SAPDVeh[playerid], 0.000, 0.000, 0.849, 0.000, 0.000, 0.000);
					tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(tmpobjid, 0, "SAPD", 120, "Ariel", 50, 0, -1, 0, 1);
					AttachDynamicObjectToVehicle(tmpobjid, SAPDVeh[playerid], 1.059, -0.100, 0.000, 0.000, 0.000, 0.000);
					tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(tmpobjid, 0, "SAPD", 120, "Ariel", 50, 0, -1, 0, 1);
					AttachDynamicObjectToVehicle(tmpobjid, SAPDVeh[playerid], -1.080, -0.200, 0.000, 0.000, 0.000, 180.000);

					AddVehicleComponent(SAPDVeh[playerid], 1010);//nos
					SetVehicleHealth(SAPDVeh[playerid], 5000);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 9:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(468, 1538.42, -1682.46, 5.59, 92.4917,3,4,VEHICLE_RESPAWN, false);
					SetVehicleHealth(SAPDVeh[playerid], 5000);

				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 10:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(521, 1538.42, -1682.46, 5.59, 92.4917,3,4,VEHICLE_RESPAWN, false);
					SetVehicleHealth(SAPDVeh[playerid], 5000);

				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 11:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(523, 1538.42, -1682.46, 5.59, 92.4917,3,4,VEHICLE_RESPAWN, false);
					SetVehicleHealth(SAPDVeh[playerid], 5000);

				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 12:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(522, 1538.42, -1682.46, 5.59, 92.4917,3,4,VEHICLE_RESPAWN, false);
					SetVehicleHealth(SAPDVeh[playerid], 5000);

				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 13:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(525, 1538.42, -1682.46, 5.59, 92.4917,3,4,VEHICLE_RESPAWN, false);
					SetVehicleHealth(SAPDVeh[playerid], 5000);

				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
			case 14:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1568.40, -1695.66, 5.89))
				{
					SAPDVeh[playerid] = CreateVehicle(497, 1569.1587,-1641.0361,28.5788,3,4,VEHICLE_RESPAWN, false);
					SetVehicleHealth(SAPDVeh[playerid], 5000);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawn"WHITE_E"' to despawn vehicles");
			}
		}
		PutPlayerInVehicle(playerid, SAPDVeh[playerid], 0);
	}
	if(dialogid == DIALOG_SAFD_GARAGE)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 951.7573, -1748.2733, 13.9448))
				{
					switch(random(4))
					{
						case 0: SAFDVeh[playerid] = CreateVehicle(407, 939.5792, -1756.1751, 13.7951, 89.3267, 1, 3, VEHICLE_RESPAWN, true);
						case 1: SAFDVeh[playerid] = CreateVehicle(407, 940.5397, -1666.9327, 13.7966, 178.7310, 1, 3, VEHICLE_RESPAWN, true);
						case 2: SAFDVeh[playerid] = CreateVehicle(407, 935.8040, -1666.9575, 13.7959, 180.4652, 1, 3, VEHICLE_RESPAWN, true);
						case 3: SAFDVeh[playerid] = CreateVehicle(407, 930.4425, -1703.7930, 13.7796, 90.0184, 1, 3, VEHICLE_RESPAWN, true);
					}
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAFD Vehicles '"YELLOW_E"/despawnsafd"WHITE_E"' to despawn vehicles");
			}
			case 1:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 951.7573, -1748.2733, 13.9448))
				{
					switch(random(4))
					{
						case 0: SAFDVeh[playerid] = CreateVehicle(544, 939.5792, -1756.1751, 13.7951, 89.3267, 1, 3, VEHICLE_RESPAWN, true);
						case 1: SAFDVeh[playerid] = CreateVehicle(544, 940.5397, -1666.9327, 13.7966, 178.7310, 1, 3, VEHICLE_RESPAWN, true);
						case 2: SAFDVeh[playerid] = CreateVehicle(544, 935.8040, -1666.9575, 13.7959, 180.4652, 1, 3, VEHICLE_RESPAWN, true);
						case 3: SAFDVeh[playerid] = CreateVehicle(544, 930.4425, -1703.7930, 13.7796, 90.0184, 1, 3, VEHICLE_RESPAWN, true);
					}
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAFD Vehicles '"YELLOW_E"/despawnsafd"WHITE_E"' to despawn vehicles");
			}
			case 2:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 951.7573, -1748.2733, 13.9448))
				{
					switch(random(2))
					{
						case 0: SAFDVeh[playerid] = CreateVehicle(487, 940.5397, -1666.9327, 13.7966, 178.7310, 1, 3, VEHICLE_RESPAWN, true);
						case 1: SAFDVeh[playerid] = CreateVehicle(487, 935.8040, -1666.9575, 13.7959, 180.4652, 1, 3, VEHICLE_RESPAWN, true);
					}
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAFD Vehicles '"YELLOW_E"/despawnsafd"WHITE_E"' to despawn vehicles");
			}
			case 4:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 951.7573, -1748.2733, 13.9448))
				{
					switch(random(2))
					{
						case 0: SAFDVeh[playerid] = CreateVehicle(487, 940.5397, -1666.9327, 13.7966, 178.7310, 1, 3, VEHICLE_RESPAWN, true);
						case 1: SAFDVeh[playerid] = CreateVehicle(487, 935.8040, -1666.9575, 13.7959, 180.4652, 1, 3, VEHICLE_RESPAWN, true);
					}
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				SendInfoMessage(playerid, "You have succefully spawned SAFD Vehicles '"YELLOW_E"/despawnsafd"WHITE_E"' to despawn vehicles");
			}
		}
		SetVehicleNumberPlate(SAFDVeh[playerid], "HP-SAFD");
		PutPlayerInVehicle(playerid, SAFDVeh[playerid], 0);
	}
    return 1;
}
