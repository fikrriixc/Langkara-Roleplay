//House System

enum houseinfo
{
	hOwner[MAX_PLAYER_NAME],
	hAddress[128],
	hPrice,
	hType,
	hLocked,
	hMoney,
	WEAPON:hWeapon[10],
	hAmmo[10],
	hInt,
	Float:hExtposX,
	Float:hExtposY,
	Float:hExtposZ,
	Float:hExtposA,
	Float:hIntposX,
	Float:hIntposY,
	Float:hIntposZ,
	Float:hIntposA,
	Float:hKitchenposX,
	Float:hKitchenposY,
	Float:hKitchenposZ,
	hVisit,
	//Not Saved
	hPickup,
	hCP,
	Text3D:hLabel,
	Text3D:hKitchenLabel
};

new hData[MAX_HOUSES][houseinfo],
	Iterator: Houses<MAX_HOUSES>;
	
Player_OwnsHouse(playerid, houseid)
{
	if(houseid == -1) return 0;
	if(!IsPlayerConnected(playerid)) return 0;
	if(!strcmp(hData[houseid][hOwner], PlayerData[playerid][pName], true)) return 1;
	return 0;
}

Player_HouseCount(playerid)
{
	#if LIMIT_PER_PLAYER != 0
    new count;
	foreach(new i : Houses)
	{
		if(Player_OwnsHouse(playerid, i)) count++;
	}

	return count;
	#else
	return 0;
	#endif
}

HouseReset(houseid)
{
	format(hData[houseid][hOwner], MAX_PLAYER_NAME, "-");
	hData[houseid][hLocked] = 1;
    hData[houseid][hMoney] = 0;
	hData[houseid][hWeapon] = WEAPON_FIST;
	hData[houseid][hAmmo] = 0;
	hData[houseid][hVisit] = 0;
	House_Type(houseid);
	
	for (new i = 0; i < 10; i ++)
    {
        hData[houseid][hWeapon][i] = WEAPON_FIST;

		hData[houseid][hAmmo][i] = 0;
    }
}
	
/*GetHouseOwnerID(houseid)
{
	foreach(new i : Player)
	{
		if(!strcmp(hData[houseid][hOwner], PlayerData[i][pName], true)) return i;
	}
	return INVALID_PLAYER_ID;
}*/

House_WeaponStorage(playerid, houseid)
{
    if(houseid == -1)
        return 0;

    static
        string[320];

    string[0] = 0;

    for (new i = 0; i < 5; i ++)
    {
        if(hData[houseid][hWeapon][i] == WEAPON_FIST)
            format(string, sizeof(string), "%sEmpty Slot\n", string);

        else
            format(string, sizeof(string), "%s%s (Ammo: %d)\n", string, ReturnWeaponName(hData[houseid][hWeapon][i]), hData[houseid][hAmmo][i]);
    }
    ShowPlayerDialog(playerid, HOUSE_WEAPONS, DIALOG_STYLE_LIST, "Weapon Storage", string, "Select", "Cancel");
    return 1;
}

House_OpenStorage(playerid, houseid)
{
    if(houseid == -1)
        return 0;

    new
        items[1],
        string[10 * 32];

    for (new i = 0; i < 5; i ++) if(hData[houseid][hWeapon][i] != WEAPON_FIST) 
	{
        items[0]++;
    }
    if(!Player_OwnsHouse(playerid, houseid))
        format(string, sizeof(string), "Weapon Storage (%d/5)", items[0]);

    else
        format(string, sizeof(string), "Weapon Storage (%d/5)\nMoney Safe (%s)", items[0], FormatMoney(hData[houseid][hMoney]));

    ShowPlayerDialog(playerid, HOUSE_STORAGE, DIALOG_STYLE_LIST, "House Storage", string, "Select", "Cancel");
    return 1;
}

GetOwnedHouses(playerid)
{
	new tmpcount;
	foreach(new hid : Houses)
	{
	    if(!strcmp(hData[hid][hOwner], PlayerData[playerid][pName], true))
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}
ReturnPlayerHousesID(playerid, hslot)
{
	new tmpcount;
	if(hslot < 1 && hslot > LIMIT_PER_PLAYER) return -1;
	foreach(new hid : Houses)
	{
	    if(!strcmp(PlayerData[playerid][pName], hData[hid][hOwner], true))
	    {
     		tmpcount++;
       		if(tmpcount == hslot)
       		{
        		return hid;
  			}
	    }
	}
	return -1;
}

House_Save(houseid)
{
	new cQuery[1536];
	format(cQuery, sizeof(cQuery), "UPDATE houses SET owner='%s', address='%s', price='%d', type='%d', locked='%d', money='%d'",
	hData[houseid][hOwner],
	hData[houseid][hAddress],
	hData[houseid][hPrice],
	hData[houseid][hType],
	hData[houseid][hLocked],
	hData[houseid][hMoney]
	);
	
	for (new i = 0; i < 10; i ++) 
	{
        format(cQuery, sizeof(cQuery), "%s, houseWeapon%d='%d', houseAmmo%d='%d'", cQuery, i + 1, _:hData[houseid][hWeapon][i], i + 1, hData[houseid][hAmmo][i]);
    }
	
	format(cQuery, sizeof(cQuery), "%s, houseint='%d', extposx='%f', extposy='%f', extposz='%f', extposa='%f', intposx='%f', intposy='%f', intposz='%f', intposa='%f', kitchenposx='%f', kitchenposy='%f', kitchenposz='%f', visit='%d' WHERE ID='%d'",
        cQuery,
        hData[houseid][hInt],
        hData[houseid][hExtposX],
        hData[houseid][hExtposY],
		hData[houseid][hExtposZ],
		hData[houseid][hExtposA],
		hData[houseid][hIntposX],
		hData[houseid][hIntposY],
		hData[houseid][hIntposZ],
		hData[houseid][hIntposA],
		hData[houseid][hKitchenposX],
		hData[houseid][hKitchenposY],
		hData[houseid][hKitchenposZ],
		hData[houseid][hVisit],
        houseid
    );
	return mysql_tquery(g_SQL, cQuery);
}

House_Type(houseid)
{
	if(hData[houseid][hType] == 1)
	{
	    switch(random(3))
		{
			case 0:
			{
				hData[houseid][hIntposX] = 845.89;
				hData[houseid][hIntposY] = -2048.00;
				hData[houseid][hIntposZ] = 1476.91;
				hData[houseid][hIntposA] = 92.60;
				hData[houseid][hInt] = 1;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 337.61;
				hData[houseid][hIntposY] = 1854.10;
				hData[houseid][hIntposZ] = 1002.08;
				hData[houseid][hIntposA] = 265.14;
				hData[houseid][hInt] = 1;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 338.29;
				hData[houseid][hIntposY] = 1794.87;
				hData[houseid][hIntposZ] = 1002.17;
				hData[houseid][hIntposA] = 269.09;
				hData[houseid][hInt] = 1;
			}
			/*case 0:
			{
				hData[houseid][hIntposX] = 223.32;
				hData[houseid][hIntposY] = 1287.26;
				hData[houseid][hIntposZ] = 1082.14;
				hData[houseid][hIntposA] = 352.43;
				hData[houseid][hInt] = 1;
			}
			case 1:
			{
				hData[houseid][hIntposX] = -68.85;
				hData[houseid][hIntposY] = 1351.42;
				hData[houseid][hIntposZ] = 1080.21;
				hData[houseid][hIntposA] = 358.06;
				hData[houseid][hInt] = 6;
			}
			case 2:
			{
				hData[houseid][hIntposX] = -42.59;
				hData[houseid][hIntposY] = 1405.65;
				hData[houseid][hIntposZ] = 1084.42;
				hData[houseid][hIntposA] = 354.17;
				hData[houseid][hInt] = 8;
			}
			case 3:
			{
				hData[houseid][hIntposX] = 260.82;
				hData[houseid][hIntposY] = 1237.48;
				hData[houseid][hIntposZ] = 1084.25;
				hData[houseid][hIntposA] = 9.24;
				hData[houseid][hInt] = 9;
			}
			case 4:
			{
				hData[houseid][hIntposX] = 22.90;
				hData[houseid][hIntposY] = 1403.32;
				hData[houseid][hIntposZ] = 1084.43;
				hData[houseid][hIntposA] = 0.24;
				hData[houseid][hInt] = 5;
			}
			case 5:
			{
				hData[houseid][hIntposX] = 226.17;
				hData[houseid][hIntposY] = 1239.99;
				hData[houseid][hIntposZ] = 1082.14;
				hData[houseid][hIntposA] = 84.87;
				hData[houseid][hInt] = 2;
			}*/
		}
	}
	if(hData[houseid][hType] == 2)
	{
	    switch(random(3))
		{
			case 0:
			{
				hData[houseid][hIntposX] = 736.03;
				hData[houseid][hIntposY] = 1672.08;
				hData[houseid][hIntposZ] = 501.08;
				hData[houseid][hIntposA] = 356.23;
				hData[houseid][hInt] = 1;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 338.78;
				hData[houseid][hIntposY] = 1734.95;
				hData[houseid][hIntposZ] = 1002.08;
				hData[houseid][hIntposA] = 268.46;
				hData[houseid][hInt] = 1;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 351.59;
				hData[houseid][hIntposY] = 1669.31;
				hData[houseid][hIntposZ] = 1002.17;
				hData[houseid][hIntposA] = 176.03;
				hData[houseid][hInt] = 1;
			}
			/*case 0:
			{
				hData[houseid][hIntposX] = 235.25;
				hData[houseid][hIntposY] = 1186.68;
				hData[houseid][hIntposZ] = 1080.25;
				hData[houseid][hIntposA] = 10.63;
				hData[houseid][hInt] = 3;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 295.04;
				hData[houseid][hIntposY] = 1472.60;
				hData[houseid][hIntposZ] = 1080.25;
				hData[houseid][hIntposA] = 3.49;
				hData[houseid][hInt] = 15;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 24.13;
				hData[houseid][hIntposY] = 1340.47;
				hData[houseid][hIntposZ] = 1084.37;
				hData[houseid][hIntposA] = 0.72;
				hData[houseid][hInt] = 10;
			}
			case 3:
			{
				hData[houseid][hIntposX] = -260.73;
				hData[houseid][hIntposY] = 1456.78;
				hData[houseid][hIntposZ] = 1084.36;
				hData[houseid][hIntposA] = 97.64;
				hData[houseid][hInt] = 4;
			}
			case 4:
			{
				hData[houseid][hIntposX] = 83.28;
				hData[houseid][hIntposY] = 1322.48;
				hData[houseid][hIntposZ] = 1083.86;
				hData[houseid][hIntposA] = 354.73;
				hData[houseid][hInt] = 9;
			}*/
		}
	}
	if(hData[houseid][hType] == 3)
	{
	    switch(random(4))
		{
			case 0:
			{
				hData[houseid][hIntposX] = 1855.38;
				hData[houseid][hIntposY] = -1709.12;
				hData[houseid][hIntposZ] = 1720.06;
				hData[houseid][hIntposA] = 273.58;
				hData[houseid][hInt] = 1;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 4577.82;
				hData[houseid][hIntposY] = -2527.82;
				hData[houseid][hIntposZ] = 5.28;
				hData[houseid][hIntposA] = 262.63;
				hData[houseid][hInt] = 1;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 1263.68;
				hData[houseid][hIntposY] = -605.30;
				hData[houseid][hIntposZ] = 1001.08;
				hData[houseid][hIntposA] = 189.50;
				hData[houseid][hInt] = 1;
			}
			case 3:
			{
				hData[houseid][hIntposX] = 1224.34;
				hData[houseid][hIntposY] = -749.22;
				hData[houseid][hIntposZ] = 1085.72;
				hData[houseid][hIntposA] = 265.59;
				hData[houseid][hInt] = 1;
			}
			/*case 0:
			{
				hData[houseid][hIntposX] = 226.70;
				hData[houseid][hIntposY] = 1114.22;
				hData[houseid][hIntposZ] = 1080.99;
				hData[houseid][hIntposA] = 267.25;
				hData[houseid][hInt] = 5;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 2323.84;
				hData[houseid][hIntposY] = -1149.33;
				hData[houseid][hIntposZ] = 1050.71;
				hData[houseid][hIntposA] = 8.92;
				hData[houseid][hInt] = 12;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 139.83;
				hData[houseid][hIntposY] = 1366.16;
				hData[houseid][hIntposZ] = 1083.85;
				hData[houseid][hIntposA] = 354.86;
				hData[houseid][hInt] = 5;
			}
			case 3:
			{
				hData[houseid][hIntposX] = 234.04;
				hData[houseid][hIntposY] = 1063.92;
				hData[houseid][hIntposZ] = 1084.21;
				hData[houseid][hIntposA] = 351.12;
				hData[houseid][hInt] = 6;
			}*/
		}
	}
}

House_Refresh(houseid)
{
    if(houseid != -1)
    {
        if(IsValidDynamic3DTextLabel(hData[houseid][hLabel]))
            DestroyDynamic3DTextLabel(hData[houseid][hLabel]);

        if(IsValidDynamicPickup(hData[houseid][hPickup]))
            DestroyDynamicPickup(hData[houseid][hPickup]);
			
		if(IsValidDynamicCP(hData[houseid][hCP]))
            DestroyDynamicCP(hData[houseid][hCP]);

		if(IsValidDynamic3DTextLabel(hData[houseid][hKitchenLabel]))
            DestroyDynamic3DTextLabel(hData[houseid][hKitchenLabel]);

        static
        string[255];
		
		new type[128];
		if(hData[houseid][hType] == 1)
		{
			type= "Small";
		}
		else if(hData[houseid][hType] == 2)
		{
			type= "Medium";
		}
		else if(hData[houseid][hType] == 3)
		{
			type= "Large";
		}
		else
		{
			type= "Unknow";
		}

        if(strcmp(hData[houseid][hOwner], "-"))
		{
			format(string, sizeof(string), "[ID: %d]\n{FFFFFF}House Location {FFFF00}%s\n{FFFFFF}House Type {FFFF00}%s\n"WHITE_E"Owned by %s\nPress '{FF0000}ENTER{FFFFFF}' to enter", houseid, GetLocation(hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]), type, hData[houseid][hOwner]);
			hData[houseid][hPickup] = CreateDynamicPickup(1273, 23, hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]+0.2, 0, 0, _, 10.0);
        }
        else
        {
            format(string, sizeof(string), "[ID: %d]\n{00FF00}This house for sell\n{FFFFFF}House Location: {FFFF00}%s\n{FFFFFF}House Type: {FFFF00}%s\n{FFFFFF}House Price: {FFFF00}%s\n"WHITE_E"Type /buy to purchase", houseid, GetLocation(hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]), type, FormatMoney(hData[houseid][hPrice]));
            hData[houseid][hPickup] = CreateDynamicPickup(1273, 23, hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]+0.2, 0, 0, _, 10.0);
        }

		if(hData[houseid][hKitchenposX] != 0)
		{
			hData[houseid][hKitchenLabel] = CreateDynamic3DTextLabel("[House Kitchen]", COLOR_YELLOW, hData[houseid][hKitchenposX], hData[houseid][hKitchenposY], hData[houseid][hKitchenposZ], 2.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, houseid, hData[houseid][hInt]);
		}
		//hData[houseid][hCP] = CreateDynamicCP(hData[houseid][hIntposX], hData[houseid][hIntposY], hData[houseid][hIntposZ], 1.0, houseid, hData[houseid][hInt], -1, 3.0);
        hData[houseid][hLabel] = CreateDynamic3DTextLabel(string, COLOR_GREEN, hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]+0.5, 2.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
    }
    return 1;
}

public:LoadHouses()
{
    static
        str[128],
		hid;
		
	new rows = cache_num_rows(), owner[128], address[128];
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "ID", hid);
			cache_get_value_name(i, "owner", owner);
			format(hData[hid][hOwner], 128, owner);
			cache_get_value_name(i, "address", address);
			format(hData[hid][hAddress], 128, address);
			cache_get_value_name_int(i, "price", hData[hid][hPrice]);
			cache_get_value_name_int(i, "type", hData[hid][hType]);
			cache_get_value_name_float(i, "extposx", hData[hid][hExtposX]);
			cache_get_value_name_float(i, "extposy", hData[hid][hExtposY]);
			cache_get_value_name_float(i, "extposz", hData[hid][hExtposZ]);
			cache_get_value_name_float(i, "extposa", hData[hid][hExtposA]);
			cache_get_value_name_float(i, "intposx", hData[hid][hIntposX]);
			cache_get_value_name_float(i, "intposy", hData[hid][hIntposY]);
			cache_get_value_name_float(i, "intposz", hData[hid][hIntposZ]);
			cache_get_value_name_float(i, "intposa", hData[hid][hIntposA]);
			cache_get_value_name_float(i, "kitchenposx", hData[hid][hKitchenposX]);
			cache_get_value_name_float(i, "kithcenposy", hData[hid][hKitchenposY]);
			cache_get_value_name_float(i, "kitchenposz", hData[hid][hKitchenposZ]);
			cache_get_value_name_int(i, "houseint", hData[hid][hInt]);
			cache_get_value_name_int(i, "money", hData[hid][hMoney]);
			cache_get_value_name_int(i, "locked", hData[hid][hLocked]);
			cache_get_value_name_int(i, "visit", hData[hid][hVisit]);

			for (new j = 0; j < 10; j ++)
			{
				format(str, 24, "houseWeapon%d", j + 1);
				cache_get_value_name_int(i, str, _:hData[hid][hWeapon][j]);

				format(str, 24, "houseAmmo%d", j + 1);
				cache_get_value_name_int(i, str, hData[hid][hAmmo][j]);
			}
			House_Refresh(hid);
			Iter_Add(Houses, hid);
		}
		printf("[Houses] Number of Loaded: %d.", rows);
	}
}

//----------[ House Commands ]--------
//House System
CMD:createhouse(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
	
	new hid = Iter_Free(Houses), address[128];
	if(hid == -1) return SendErrorMessage(playerid, "You cant create more door!");
	new price, type, query[512];
	if(sscanf(params, "dd", price, type)) return SendSyntaxMessage(playerid, "/createhouse [price] [type, 1.small 2.medium 3.Big]");
	format(hData[hid][hOwner], 128, "-");
	GetPlayerPos(playerid, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]);
	GetPlayerFacingAngle(playerid, hData[hid][hExtposA]);
	hData[hid][hPrice] = price;
	hData[hid][hType] = type;
	address = GetLocation(hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]);
	format(hData[hid][hAddress], 128, address);
	hData[hid][hLocked] = 1;
	hData[hid][hMoney] = 0;
	hData[hid][hInt] = 0;
	hData[hid][hIntposX] = 0;
	hData[hid][hIntposY] = 0;
	hData[hid][hIntposZ] = 0;
	hData[hid][hIntposA] = 0;
	hData[hid][hVisit] = 0;
	House_Type(hid);
	
	for (new i = 0; i < 10; i ++) 
	{
        hData[hid][hWeapon][i] = WEAPON_FIST;
        hData[hid][hAmmo][i] = 0;
    }
    House_Refresh(hid);
	Iter_Add(Houses, hid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO houses SET ID='%d', owner='%s', price='%d', type='%d', extposx='%f', extposy='%f', extposz='%f', extposa='%f', address='%s'", hid, hData[hid][hOwner], hData[hid][hPrice], hData[hid][hType], hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ], hData[hid][hExtposA], hData[hid][hAddress]);
	mysql_tquery(g_SQL, query, "OnHousesCreated", "i", hid);
	return 1;
}

public:OnHousesCreated(hid)
{
	House_Save(hid);
	return 1;
}

CMD:gotohouse(playerid, params[])
{
	new hid;
	if(PlayerData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
		
	if(sscanf(params, "d", hid))
		return SendSyntaxMessage(playerid, "/gotohouse [id]");
	if(!Iter_Contains(Houses, hid)) return SendErrorMessage(playerid, "The doors you specified ID of doesn't exist.");
	SetPlayerPosition(playerid, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ], hData[hid][hExtposA]);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
	SendClientMessage(playerid, COLOR_WHITE, "You have teleport to house id %d", hid);
	PlayerData[playerid][pInDoor] = -1;
	PlayerData[playerid][pInHouse] = -1;
	PlayerData[playerid][pInBiz] = -1;
	return 1;
}

CMD:typehouses(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
        return PermissionError(playerid);
	
	new count = 0;
	foreach(new hid : Houses)
	{
		if(hData[hid][hType] == 1)
		{
			House_Type(hid);
			House_Refresh(hid);
			House_Save(hid);
		}
		if(hData[hid][hType] == 2)
		{
			House_Type(hid);
			House_Refresh(hid);
			House_Save(hid);
		}
		if(hData[hid][hType] == 3)
		{
			House_Type(hid);
			House_Refresh(hid);
			House_Save(hid);
		}
		count++;
	}
	SendServerMessage(playerid, "Anda telah me reset house interior type sebanyak %d rumah.", count);
	return 1;
}

CMD:edithouse(playerid, params[])
{
    static
        hid,
        type[24],
        string[128];

    if(PlayerData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", hid, type, string))
    {
        SendSyntaxMessage(playerid, "/edithouse [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, interior, kitchen, locked, owner, price, type, reset, delete");
        return 1;
    }
    if((hid < 0 || hid >= MAX_HOUSES))
        return SendErrorMessage(playerid, "You have specified an invalid ID.");
	if(!Iter_Contains(Houses, hid)) return SendErrorMessage(playerid, "The doors you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]);
		GetPlayerFacingAngle(playerid, hData[hid][hExtposA]);
        House_Save(hid);
		House_Refresh(hid);

        SendAdminMessage(COLOR_LRED, "%s has adjusted the location of house ID: %d.", PlayerData[playerid][pAdminname], hid);
    }
    else if(!strcmp(type, "interior", true))
    {
        GetPlayerPos(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ]);
		GetPlayerFacingAngle(playerid, hData[hid][hIntposA]);
		hData[hid][hInt] = GetPlayerInterior(playerid);

        House_Save(hid);
		House_Refresh(hid);

        SendAdminMessage(COLOR_RED, "%s has adjusted the interior spawn of house ID: %d.", PlayerData[playerid][pAdminname], hid);
    }
	else if(!strcmp(type, "kitchen", true))
    {
		GetPlayerPos(playerid, hData[hid][hKitchenposX], hData[hid][hKitchenposY], hData[hid][hKitchenposZ]);
        House_Save(hid);
		House_Refresh(hid);

        SendAdminMessage(COLOR_LRED, "%s has adjusted the kitchen of house ID: %d.", PlayerData[playerid][pAdminname], hid);
    }
    else if(!strcmp(type, "locked", true))
    {
        new locked;

        if(sscanf(string, "d", locked))
            return SendSyntaxMessage(playerid, "/edithouse [id] [locked] [0/1]");

        if(locked < 0 || locked > 1)
            return SendErrorMessage(playerid, "You must specify at least 0 or 1.");

        hData[hid][hLocked] = locked;
        House_Save(hid);
		House_Refresh(hid);

        if(locked) {
            SendAdminMessage(COLOR_RED, "%s has locked house ID: %d.", PlayerData[playerid][pAdminname], hid);
        }
        else {
            SendAdminMessage(COLOR_RED, "%s has unlocked house ID: %d.", PlayerData[playerid][pAdminname], hid);
        }
    }
    else if(!strcmp(type, "price", true))
    {
        new price;

        if(sscanf(string, "d", price))
            return SendSyntaxMessage(playerid, "/edithouse [id] [Price] [Amount]");

        hData[hid][hPrice] = price;

        House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the price of house ID: %d to %d.", PlayerData[playerid][pAdminname], hid, price);
    }
	else if(!strcmp(type, "type", true))
    {
        new htype;

        if(sscanf(string, "d", htype))
            return SendSyntaxMessage(playerid, "/edithouse [id] [Type] [1.small 2.medium 3.Big]");

        hData[hid][hType] = htype;
		House_Type(hid);
        House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the type of house ID: %d to %d.", PlayerData[playerid][pAdminname], hid, htype);
    }
    else if(!strcmp(type, "owner", true))
    {
        new owners[MAX_PLAYER_NAME];

        if(sscanf(string, "s[32]", owners))
            return SendSyntaxMessage(playerid, "/edithouse [id] [owner] [player name] (use '-' to no owner)");

        format(hData[hid][hOwner], MAX_PLAYER_NAME, owners);
  
        House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the owner of house ID: %d to %s", PlayerData[playerid][pAdminname], hid, owners);
    }
    else if(!strcmp(type, "reset", true))
    {
        HouseReset(hid);
		House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(COLOR_RED, "%s has reset house ID: %d.", PlayerData[playerid][pAdminname], hid);
    }
	else if(!strcmp(type, "delete", true))
	{
		HouseReset(hid);
		
		DestroyDynamic3DTextLabel(hData[hid][hLabel]);
        DestroyDynamicPickup(hData[hid][hPickup]);
        DestroyDynamicCP(hData[hid][hCP]);
		
		hData[hid][hExtposX] = 0;
		hData[hid][hExtposY] = 0;
		hData[hid][hExtposZ] = 0;
		hData[hid][hExtposA] = 0;
		hData[hid][hPrice] = 0;
		hData[hid][hInt] = 0;
		hData[hid][hIntposX] = 0;
		hData[hid][hIntposY] = 0;
		hData[hid][hIntposZ] = 0;
		hData[hid][hIntposA] = 0;
		hData[hid][hLabel] = Text3D: INVALID_3DTEXT_ID;
		hData[hid][hPickup] = -1;
		
		Iter_Remove(Houses, hid);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM houses WHERE ID=%d", hid);
		mysql_tquery(g_SQL, query);
        SendAdminMessage(COLOR_RED, "%s has delete house ID: %d.", PlayerData[playerid][pAdminname], hid);
	}
    return 1;
}

/*
CMD:buyhouse(playerid, params[])
{
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtpos][0], hData[hid][hExtpos][1], hData[hid][hExtpos][2]))
		{
			if(hData[hid][hPrice] > GetPlayerMoney(playerid)) return SendErrorMessage(playerid, "Not enough money, you can't afford this houses.");
			if(strcmp(hData[hid][hOwner], "-")) return SendErrorMessage(playerid, "Someone already owns this house.");
			if(PlayerData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 2) return SendErrorMessage(playerid, "You can't buy any more houses.");
				#endif
			}
			else if(PlayerData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 3) return SendErrorMessage(playerid, "You can't buy any more houses.");
				#endif
			}
			else if(PlayerData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 4) return SendErrorMessage(playerid, "You can't buy any more houses.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 1) return SendErrorMessage(playerid, "You can't buy any more houses.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -hData[hid][hPrice]);
			GetPlayerName(playerid, hData[hid][hOwner], MAX_PLAYER_NAME);
			hData[hid][hVisit] = gettime();
			
			House_Refresh(hid);
			House_Save(hid);
		}
	
	}
	return 1;
}*/
CMD:lockhouse(playerid, params[])
{
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
		{
			if(!Player_OwnsHouse(playerid, hid)) return SendErrorMessage(playerid, "You don't own this house.");
			if(!hData[hid][hLocked])
			{
				hData[hid][hLocked] = 1;
				House_Save(hid);

				InfoTD_MSG(playerid, 4000, "You have ~r~locked~w~ your house!");
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
			else
			{
				hData[hid][hLocked] = 0;
				House_Save(hid);

				InfoTD_MSG(playerid, 4000,"You have ~g~unlocked~w~ your house!");
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
		}
	}
	return 1;
}

CMD:givehouse(playerid, params[])
{
	new hid, otherid;
	if(sscanf(params, "ud", otherid, hid)) return SendSyntaxMessage(playerid, "/givehouse [playerid/name] [id] | /myhouse - for show info");
	if(hid == -1) return SendErrorMessage(playerid, "Invalid id");
	
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return SendErrorMessage(playerid, "The specified player is disconnected or not near you.");
	
	if(!Player_OwnsHouse(playerid, hid)) return SendErrorMessage(playerid, "You dont own this id house.");
	
	if(PlayerData[otherid][pVip] == 1)
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_HouseCount(otherid) + 1 > 2) return SendErrorMessage(playerid, "Target player cant own any more houses.");
		#endif
	}
	else if(PlayerData[otherid][pVip] == 2)
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_HouseCount(otherid) + 1 > 3) return SendErrorMessage(playerid, "Target player cant own any more houses.");
		#endif
	}
	else if(PlayerData[otherid][pVip] == 3)
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_HouseCount(otherid) + 1 > 4) return SendErrorMessage(playerid, "Target player cant own any more houses.");
		#endif
	}
	else
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_HouseCount(otherid) + 1 > 1) return SendErrorMessage(playerid, "Target player cant own any more houses.");
		#endif
	}
	GetPlayerName(otherid, hData[hid][hOwner], MAX_PLAYER_NAME);
	hData[hid][hVisit] = gettime();
	
	House_Refresh(hid);
	House_Save(hid);
	SendInfoMessage(playerid, "Anda memberikan rumah id: %d kepada %s", hid, ReturnName(otherid));
	SendInfoMessage(otherid, "%s memberikan rumah id: %d kepada anda", hid, ReturnName(playerid));
	return 1;
}

CMD:sellhouse(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1396.2109, -4.3407, 1000.8535)) return SendErrorMessage(playerid, "Anda harus berada di City Hall!");
	if(GetOwnedHouses(playerid) == -1) return SendErrorMessage(playerid, "You don't have a houses.");
	//if(!Player_OwnsBusiness(playerid, id)) return SendErrorMessage(playerid, "You don't own this business.");
	new hid, _tmpstring[128], count = GetOwnedHouses(playerid), CMDSString[1024];
	CMDSString = "";
	new lock[128];
	Loop(itt, (count + 1), 1)
	{
	    hid = ReturnPlayerHousesID(playerid, itt);
		if(hData[hid][hLocked] == 1)
		{
			lock = "{FF0000}Locked";
		
		}
		else
		{
			lock = "{00FF00}Unlocked";
		}
		if(itt == count)
		{
		    format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t{FFFF2A}%s   (%s{FFFF2A})\n", itt, hData[hid][hAddress], lock);
		}
		else format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t{FFFF2A}%s  (%s{FFFF2A})\n", itt, hData[hid][hAddress], lock);
		strcat(CMDSString, _tmpstring);
	}
	ShowPlayerDialog(playerid, DIALOG_SELL_HOUSES, DIALOG_STYLE_LIST, "Sell Houses", CMDSString, "Sell", "Cancel");
	return 1;
}

CMD:myhouse(playerid)
{
	if(GetOwnedHouses(playerid) == -1) return SendErrorMessage(playerid, "You don't have a houses.");
	//if(!Player_OwnsBusiness(playerid, id)) return SendErrorMessage(playerid, "You don't own this business.");
	new hid, _tmpstring[128], count = GetOwnedHouses(playerid), CMDSString[1024];
	CMDSString = "";
	new lock[128];
	Loop(itt, (count + 1), 1)
	{
	    hid = ReturnPlayerHousesID(playerid, itt);
		if(hData[hid][hLocked] == 1)
		{
			lock = "{FF0000}Dikunci";
		
		}
		else
		{
			lock = "{00FF00}Dibuka";
		}
		if(itt == count)
		{
		    format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t{FFFF2A}%s   (%s)\n", itt, hData[hid][hAddress], lock);
		}
		else format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t{FFFF2A}%s  (%s)\n", itt, hData[hid][hAddress], lock);
		strcat(CMDSString, _tmpstring);
	}
	ShowPlayerDialog(playerid, DIALOG_MY_HOUSES, DIALOG_STYLE_LIST, "Houses Menu", CMDSString, "Select", "Cancel");
	return 1;
}

CMD:hm(playerid, params[])
{
	if(PlayerData[playerid][pInHouse] == -1)
		return SendErrorMessage(playerid, "You aren't in any houses!");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/hm [kitchenpos/storage]");

	if(!strcmp(params, "kitchenpos", true))
	{
		if(!Player_OwnsHouse(playerid, PlayerData[playerid][pInHouse])) 
			return SendErrorMessage(playerid, "Kamu bukan pemilik rumah.");

		new hid = PlayerData[playerid][pInHouse];
		GetPlayerPos(playerid, hData[hid][hKitchenposX], hData[hid][hKitchenposY], hData[hid][hKitchenposZ]);
        House_Save(hid);
		House_Refresh(hid);
	}
	else if(!strcmp(params, "storage", true))
	{
		if(!Player_OwnsHouse(playerid, PlayerData[playerid][pInHouse])) 
			if(PlayerData[playerid][pFaction] != 1)
				return SendErrorMessage(playerid, "Kamu bukan pemilik rumah.");
	
		House_OpenStorage(playerid, PlayerData[playerid][pInHouse]);
	}
    return 1;
}

//--------------[ House Dialog ]----------
