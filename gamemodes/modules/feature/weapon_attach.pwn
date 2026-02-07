//Weapon Attach
enum weaponSettings
{
    Float:Position[6],
    Bone,
    Hidden
}
new WeaponSettings[MAX_PLAYERS][MAX_WEAPONS][weaponSettings], WeaponTick[MAX_PLAYERS], EditingWeapon[MAX_PLAYERS];
 
GetWeaponObjectSlot(WEAPON:weaponid)
{
    new objectslot;
 
    switch (_:weaponid)
    {
        case 22..24: objectslot = 4;	// Handguns
        case 25..27: objectslot = 5;	// Shotguns
        case 28, 29, 32: objectslot = 6;	//Sub-Machineguns
        case 30, 31: objectslot = 7;	//Machineguns
        case 33, 34: objectslot = 8;	//Rifles
        //case 35..38: objectslot = 9; //Heavy Weapons
    }
    return objectslot;
}
 
GetWeaponModel(WEAPON:weaponid) //Will only return the model of wearable weapons (22-38)
{
    new model;
   
    switch(_:weaponid)
    {
		case 1: model = 331;
		case 2..8: model = 331 + _:weaponid;
		case 9: model = 341;
		case 10..15: model = 311 + _:weaponid;
		case 16..18: model = 326 + _:weaponid;
        case 22..29: model = 324 + _:weaponid;
        case 30: model = 355;
        case 31: model = 356;
        case 32: model = 372;
        case 33..45: model = 324 + _:weaponid;
		case 46: model = 371;
    }
    return model;
}
 
PlayerHasWeapon(playerid, WEAPON:weaponid)
{
    new WEAPON:weapon, ammo;
 
    for (new i; i < 13; i++)
    {
        GetPlayerWeaponData(playerid, WEAPON_SLOT:i, weapon, ammo);
        if (weapon == weaponid && ammo) return 1;
    }
    return 0;
}
 
IsWeaponWearable(weaponid)
    return (weaponid >= 22 && weaponid <= 38);
 
IsWeaponHideable(weaponid)
    return (weaponid >= 22 && weaponid <= 24 || weaponid == 28 || weaponid == 32);
	
//Drop Weapon
enum droppedweapons {
    WeapID,
    WeapPlayer[24],
	WeapModel,
	WEAPON:WeaponID,
	WeapAmmo,
    Float:WeapPos[3],
	WeapInt,
	WeapWorld,
    WeapObject,
	Text3D:WeapLabel
};
new DropWeap[MAX_DROP_WEAPON][droppedweapons];

public:LoadDropWeapons()
{
	new rows = cache_num_rows(), fanstr[256];
	if(rows > 0) for(new i = 0; i < rows; i++)
	{
		cache_get_value_name_int(i, "ID", DropWeap[i][WeapID]);
		cache_get_value_name(i, "PlayerName", DropWeap[i][WeapPlayer]);
		cache_get_value_name_int(i, "WeaponModel", DropWeap[i][WeapModel]);
		cache_get_value_name_int(i, "WeaponID", DropWeap[i][WeaponID]);
		cache_get_value_name_int(i, "Ammo", DropWeap[i][WeapAmmo]);
		cache_get_value_name_float(i, "PosX", DropWeap[i][WeapPos][0]);
		cache_get_value_name_float(i, "PosY", DropWeap[i][WeapPos][1]);
		cache_get_value_name_float(i, "PosZ", DropWeap[i][WeapPos][2]);
		cache_get_value_name_int(i, "Interior", DropWeap[i][WeapInt]);
		cache_get_value_name_int(i, "World", DropWeap[i][WeapWorld]);

		if(IsWeaponModel(DropWeap[i][WeapModel])) 
		{
			DropWeap[i][WeapObject] = CreateDynamicObject(DropWeap[i][WeapModel], DropWeap[i][WeapPos][0], DropWeap[i][WeapPos][1], DropWeap[i][WeapPos][2], 93.7, 120.0, 120.0, DropWeap[i][WeapWorld], DropWeap[i][WeapInt]);
		} 
		else 
		{
			DropWeap[i][WeapObject] = CreateDynamicObject(DropWeap[i][WeapModel], DropWeap[i][WeapPos][0], DropWeap[i][WeapPos][1], DropWeap[i][WeapPos][2], 0.0, 0.0, 0.0, DropWeap[i][WeapWorld], DropWeap[i][WeapInt]);
		}
		
		format(fanstr, sizeof(fanstr), "%s", ReturnWeaponName(DropWeap[i][WeaponID]));
		if(IsAmmoWeapon(DropWeap[i][WeaponID]) && !IsCountableWeapon(DropWeap[i][WeaponID]))
			strcat(fanstr, sprintf("\nAmmo: %d", DropWeap[i][WeapAmmo]), sizeof(fanstr));
		else if(!IsAmmoWeapon(DropWeap[i][WeaponID]) && IsCountableWeapon(DropWeap[i][WeaponID]))
			strcat(fanstr, sprintf("\nCount: %d", DropWeap[i][WeapAmmo]), sizeof(fanstr));

		DropWeap[i][WeapLabel] = CreateDynamic3DTextLabel(fanstr, 0xFFFFFFFF, DropWeap[i][WeapPos][0], DropWeap[i][WeapPos][1], DropWeap[i][WeapPos][2] + 0.5, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, DropWeap[i][WeapWorld], DropWeap[i][WeapInt], 0);
	}
	printf("[DropWeapon] Loaded %d from database", rows);
	return 1;
}

DropWeapon(const player[], model, WEAPON:weaponid = WEAPON_FIST, ammo = 0, Float:x, Float:y, Float:z, interior, world)
{
	new fanstr[256];
    for (new i = 0; i != MAX_DROP_WEAPON; i ++) if(!DropWeap[i][WeapModel])
    {
        format(DropWeap[i][WeapPlayer], 24, player);

        DropWeap[i][WeapModel] = model;
        DropWeap[i][WeaponID] = weaponid;
        DropWeap[i][WeapAmmo] = ammo;
        DropWeap[i][WeapPos][0] = x;
        DropWeap[i][WeapPos][1] = y;
        DropWeap[i][WeapPos][2] = z;

        DropWeap[i][WeapInt] = interior;
        DropWeap[i][WeapWorld] = world;

        if(IsWeaponModel(model)) 
		{
            DropWeap[i][WeapObject] = CreateDynamicObject(model, x, y, z, 93.7, 120.0, 120.0, world, interior);
        } 
		else 
		{
            DropWeap[i][WeapObject] = CreateDynamicObject(model, x, y, z, 0.0, 0.0, 0.0, world, interior);
        }

		format(fanstr, sizeof(fanstr), "%s", ReturnWeaponName(DropWeap[i][WeaponID]));
		if(IsAmmoWeapon(DropWeap[i][WeaponID]) && !IsCountableWeapon(DropWeap[i][WeaponID]))
			strcat(fanstr, sprintf("\nAmmo: %d", DropWeap[i][WeapAmmo]), sizeof(fanstr));
		else if(!IsAmmoWeapon(DropWeap[i][WeaponID]) && IsCountableWeapon(DropWeap[i][WeaponID]))
			strcat(fanstr, sprintf("\nCount: %d", DropWeap[i][WeapAmmo]), sizeof(fanstr));

		DropWeap[i][WeapLabel] = CreateDynamic3DTextLabel(fanstr, 0xFFFFFFFF, DropWeap[i][WeapPos][0], DropWeap[i][WeapPos][1], DropWeap[i][WeapPos][2] + 0.5, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, DropWeap[i][WeapWorld], DropWeap[i][WeapInt], 0);
        mysql_tquery(g_SQL, sprintf("INSERT INTO dropped_weapons (PlayerName, WeaponModel, WeaponID, Ammo, PosX, PosY, PosZ, Interior, World) VALUES ('%s', %d, %d, %d, %.2f, %.2f, %.2f, %d, %d)", DropWeap[i][WeapPlayer], model, weaponid, ammo, x, y, z, interior, world), "OnWeaponDropped", "d", i);
		return i;
    }
    return -1;
}

public:OnWeaponDropped(itemid)
{
	DropWeap[itemid][WeapID] = cache_insert_id();
	return 1;
}

NearWeapon(playerid)
{
    for (new i = 0; i != MAX_DROP_WEAPON; i ++) if(DropWeap[i][WeapModel] && IsPlayerInRangeOfPoint(playerid, 1.5, DropWeap[i][WeapPos][0], DropWeap[i][WeapPos][1], DropWeap[i][WeapPos][2]))
    {
        if(GetPlayerInterior(playerid) == DropWeap[i][WeapInt] && GetPlayerVirtualWorld(playerid) == DropWeap[i][WeapWorld])
        return i;
    }
    return -1;
}

DeleteWeapon(itemid)
{
    if(itemid != -1 && DropWeap[itemid][WeapModel])
    {
		if(IsValidDynamicObject(DropWeap[itemid][WeapObject]))
        	DestroyDynamicObject(DropWeap[itemid][WeapObject]);

		if(IsValidDynamic3DTextLabel(DropWeap[itemid][WeapLabel]))
			DestroyDynamic3DTextLabel(DropWeap[itemid][WeapLabel]);

        DropWeap[itemid][WeapModel] = 0;
        DropWeap[itemid][WeapPos][0] = 0.0;
        DropWeap[itemid][WeapPos][1] = 0.0;
        DropWeap[itemid][WeapPos][2] = 0.0;
        DropWeap[itemid][WeapInt] = 0;
        DropWeap[itemid][WeapWorld] = 0;
		DropWeap[itemid][WeaponID] = WEAPON_FIST;
		DropWeap[itemid][WeapAmmo] = 0;

		mysql_tquery(g_SQL, sprintf("DELETE FROM dropped_weapons WHERE ID='%d'", DropWeap[itemid][WeapID]));
    }
    return 1;
}

PickupWeapon(playerid, itemid)
{
    if(itemid != -1 && DropWeap[itemid][WeapModel])
    {
        GivePlayerWeaponEx(playerid, DropWeap[itemid][WeaponID], DropWeap[itemid][WeapAmmo]);
		//SendServerMessage(playerid, "Anda telah mengambil senjata %s", ReturnWeaponName(DropWeap[itemid][WeaponID]));
        DeleteWeapon(itemid);
    }
    return 1;
}
	
//Weapon Attach System
public:OnWeaponsLoaded(playerid)
{
    new rows, WEAPON:weaponid, WEAPON:index;
   
    cache_get_row_count(rows);
   
    for (new i; i < rows; i++)
    {
        cache_get_value_name_int(i, "WeaponID", weaponid);
        index = weaponid - WEAPON:22;
       
        cache_get_value_name_float(i, "PosX", WeaponSettings[playerid][index][Position][0]);
        cache_get_value_name_float(i, "PosY", WeaponSettings[playerid][index][Position][1]);
        cache_get_value_name_float(i, "PosZ", WeaponSettings[playerid][index][Position][2]);
       
        cache_get_value_name_float(i, "RotX", WeaponSettings[playerid][index][Position][3]);
        cache_get_value_name_float(i, "RotY", WeaponSettings[playerid][index][Position][4]);
        cache_get_value_name_float(i, "RotZ", WeaponSettings[playerid][index][Position][5]);
       
        cache_get_value_name_int(i, "Bone", WeaponSettings[playerid][index][Bone]);
        cache_get_value_name_int(i, "Hidden", WeaponSettings[playerid][index][Hidden]);
    }
}

//Weapon Attach System
CMD:gun(playerid, params[]) return callcmd::weapon(playerid, params);
CMD:weapon(playerid, params[])
{
	new WEAPON:weaponid = GetPlayerWeaponEx(playerid);
	new ammo = GetPlayerAmmoEx(playerid);
	
	new name[20], give[128];
	if(sscanf(params, "s[20]S()[128]", name, give))
		return SendSyntaxMessage(playerid, "/weapon [give/drop/pickup/pos/bone/hide]");

	if(!strcmp(name, "pos", true))
	{
		if (!weaponid)
			return SendErrorMessage(playerid, "You are not holding a weapon.");

		if (!IsWeaponWearable(weaponid))
			return SendErrorMessage(playerid, "This weapon cannot be edited.");
		
		if (EditingWeapon[playerid])
			return SendErrorMessage(playerid, "You are already editing a weapon.");

		if (WeaponSettings[playerid][weaponid - WEAPON:22][Hidden])
			return SendErrorMessage(playerid, "You cannot adjust a hidden weapon.");

		new WEAPON:index = weaponid - WEAPON:22;
		   
		SetPlayerArmedWeapon(playerid, WEAPON_FIST);
	   
		SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);
		EditAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
	   
		EditingWeapon[playerid] = weaponid;
	}
	else if (!strcmp(name, "bone", true))
	{
		if (!weaponid)
			return SendErrorMessage(playerid, "You are not holding a weapon.");

		if (!IsWeaponWearable(weaponid))
			return SendErrorMessage(playerid, "This weapon cannot be edited.");
			
		if (EditingWeapon[playerid])
			return SendErrorMessage(playerid, "You are already editing a weapon.");

		ShowPlayerDialog(playerid, DIALOG_EDITBONE, DIALOG_STYLE_LIST, "Bone", "Spine\nHead\nLeft upper arm\nRight upper arm\nLeft hand\nRight hand\nLeft thigh\nRight thigh\nLeft foot\nRight foot\nRight calf\nLeft calf\nLeft forearm\nRight forearm\nLeft shoulder\nRight shoulder\nNeck\nJaw", "Choose", "Cancel");
		EditingWeapon[playerid] = weaponid;
	}
	else if (!strcmp(name, "hide", true))
	{
		if (!weaponid)
			return SendErrorMessage(playerid, "You are not holding a weapon.");

		if (!IsWeaponWearable(weaponid))
			return SendErrorMessage(playerid, "This weapon cannot be edited.");
			
		if (EditingWeapon[playerid])
			return SendErrorMessage(playerid, "You cannot hide a weapon while you are editing it.");

		if (!IsWeaponHideable(weaponid))
			return SendErrorMessage(playerid, "This weapon cannot be hidden.");

		new WEAPON:index = weaponid - WEAPON:22, weaponname[18], string[150];

		GetWeaponName(weaponid, weaponname, sizeof(weaponname));
	   
		if (WeaponSettings[playerid][index][Hidden])
		{
			format(string, sizeof(string), "You have set your %s to show.", weaponname);
			WeaponSettings[playerid][index][Hidden] = false;
		}
		else
		{
			if (IsPlayerAttachedObjectSlotUsed(playerid, GetWeaponObjectSlot(weaponid)))
				RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));

			format(string, sizeof(string), "You have set your %s not to show.", weaponname);
			WeaponSettings[playerid][index][Hidden] = true;
		}
		SendClientMessage(playerid, -1, string);
	   
		mysql_format(g_SQL, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, Hidden) VALUES ('%d', %d, %d) ON DUPLICATE KEY UPDATE Hidden = VALUES(Hidden)", PlayerData[playerid][pID], weaponid, WeaponSettings[playerid][index][Hidden]);
		mysql_tquery(g_SQL, string);
	}
	else if(!strcmp(name, "give", true))
	{
		if (!weaponid)
			return SendErrorMessage(playerid, "You are not holding a weapon.");
		new opt[32], otherid, addestr[256];	
		if(sscanf(give, "s[32]uS(-)[256]", opt, otherid, addestr))
			return SendSyntaxMessage(playerid, "/weapon [give] [gun/ammo] [playerid]");
			
		if(otherid == INVALID_PLAYER_ID || otherid == playerid || !NearPlayer(playerid, otherid, 5.0))
			return SendErrorMessage(playerid, "You must in near target player.");

		if(!strcmp(opt, "gun", true))
		{
			if(PlayerHasWeaponInSlot(otherid, weaponid))
				return SendErrorMessage(playerid, "Orang tersebut sudah memiliki senjata dengan tipe yang sama!");
			
			ResetWeapon(playerid, weaponid);
			SendInfoMessage(playerid, "Anda telah memberikan weapon %s kepada %s.", ReturnWeaponName(weaponid) , ReturnName(otherid));
			SendInfoMessage(otherid, "%s telah memberikan weapon %s kepada anda.", ReturnName(playerid), ReturnWeaponName(weaponid));
			GivePlayerWeaponEx(otherid, weaponid, ammo);
		}
		else if(!strcmp(opt, "ammo"))
		{
			if(!PlayerHasWeaponInSlot(otherid, weaponid))
				return SendErrorMessage(playerid, "Orang tersebut tidak memiliki senjata dengan tipe yang sama!");
			
			new amount;
			if(sscanf(addestr, "d", amount))
				return SendSyntaxMessage(playerid, "/weapon [give] [gun/ammo] [PlayerID/PartOfName] [amount]");

			if(ammo < amount)
				return SendErrorMessage(playerid, "Kamu tidak bisa memberi lebih dari ammo yang kamu miliki!");

			if(ammo == amount)
				return SendErrorMessage(playerid, "Kamu tidak bisa memberi jumlah ammo dengan yang kamu miliki saat ini! %s", ammo == 1 ? "" : "(kurangi 1)");

			SendInfoMessage(playerid, "Anda telah memberikan %s ammo kepada %s.", ReturnWeaponName(weaponid) , ReturnName(otherid));
			SendInfoMessage(otherid, "%s telah memberikan %s ammo kepada anda.", ReturnName(playerid), ReturnWeaponName(weaponid));
			GivePlayerWeaponEx(otherid, PlayerData[otherid][pGuns][g_aWeaponSlots[weaponid]], amount);
		}
		else
			SendSyntaxMessage(playerid, "/weapon [give] [gun/ammo] [playerid]");
	}
	else if(!strcmp(name, "drop", true))
	{
		if (!weaponid)
			return SendErrorMessage(playerid, "You are not holding a weapon.");
			
		static
			Float:x,
			Float:y,
			Float:z,
			Float:angle;

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);

		x += 1 * floatsin(-angle, degrees);
		y += 1 * floatcos(-angle, degrees);

		DropWeapon(PlayerData[playerid][pName], GetWeaponModel(weaponid), weaponid, GetPlayerAmmoEx(playerid), x, y, z - 1, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
		ResetWeapon(playerid, weaponid);

		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, false, 0, SYNC_ALL);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out a %s and drops it on the floor.", ReturnName(playerid), ReturnWeaponName(weaponid));
	}
	else if(!strcmp(name, "pickup", true))
	{
		new wid = NearWeapon(playerid);
		if(wid != -1)
        {

		    if(PlayerHasWeaponInSlot(playerid, DropWeap[wid][WeaponID]))
		    	return SendErrorMessage(playerid, "Kamu sudah memiliki senjata dengan tipe yang sama!");
			
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has picked up a %s.", ReturnName(playerid), ReturnWeaponName(DropWeap[wid][WeaponID]));
			PickupWeapon(playerid, wid);
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, false, 0, SYNC_ALL);
		}
	}
	else SendErrorMessage(playerid, "You have specified an invalid option.");
	return 1;
}
