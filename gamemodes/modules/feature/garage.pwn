
enum    E_PARK
{
	// loaded from db
	parkID,
	Float: parkX,
	Float: parkY,
	Float: parkZ,
	parkInt,
	parkWorld,
	// temp
	parkPickup,
	Text3D: parkLabel
}

new ppData[MAX_PARKPOINT][E_PARK],
	Iterator:Parks<MAX_PARKPOINT>;
	
GetClosestParks(playerid, Float: range = 4.3)
{
	foreach(new id : Parks) if(IsPlayerInRangeOfPoint(playerid, range, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ]))
		return id;
	
	return -1;
}

ReturnAnyPark(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_PARKPOINT) return -1;
	foreach(new id : Parks)
	{
		tmpcount++;
		if(tmpcount == slot)
		{
			return id;
		}
	}
	return -1;
}

public:LoadPark()
{
	if(cache_num_rows())
  	{
 		new str[528];
		forex(i, cache_num_rows())
		{
			cache_get_value_name_int(i, "id", ppData[i][parkID]);
			cache_get_value_name_float(i, "posx", ppData[i][parkX]);
			cache_get_value_name_float(i, "posy", ppData[i][parkY]);
			cache_get_value_name_float(i, "posz", ppData[i][parkZ]);
			cache_get_value_name_int(i, "interior", ppData[i][parkInt]);
			cache_get_value_name_int(i, "world", ppData[i][parkWorld]);
			format(str, sizeof(str), "[ID: %d]\n{ffffff}%s"YELLOW_E"\n/parkveh /pickupveh", i, GetLocation(ppData[i][parkX], ppData[i][parkY], ppData[i][parkZ]));
		    ppData[i][parkPickup] = CreateDynamicPickup(19134, 23, ppData[i][parkX], ppData[i][parkY], ppData[i][parkZ], ppData[i][parkWorld],  ppData[i][parkInt]);
			ppData[i][parkLabel] = CreateDynamic3DTextLabel(str, ARWIN, ppData[i][parkX], ppData[i][parkY], ppData[i][parkZ]+0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ppData[i][parkWorld], ppData[i][parkInt], -1, 10.0);
			Iter_Add(Parks, i);
		}
		printf("[Dynamic Park Point] Number of Loaded: %d.", cache_num_rows());
	}
}

Park_Save(id)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE parks SET posx='%f', posy='%f', posz='%f', interior=%d, world=%d WHERE id=%d",
	ppData[id][parkX],
	ppData[id][parkY],
	ppData[id][parkZ],
	ppData[id][parkInt],
	ppData[id][parkWorld],
	ppData[id][parkID]
	);
	return mysql_tquery(g_SQL, cQuery);
}

CMD:createpark(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new id = Iter_Free(Parks);
	if(id == -1) return SendErrorMessage(playerid, "Can't add any more Park Point.");
 	new Float: x, Float: y, Float: z;
 	GetPlayerPos(playerid, x, y, z);
	
	ppData[id][parkX] = x;
	ppData[id][parkY] = y;
	ppData[id][parkZ] = z;
	ppData[id][parkInt] = GetPlayerInterior(playerid);
	ppData[id][parkWorld] = GetPlayerVirtualWorld(playerid);
	
	new str[128];
	format(str, sizeof(str), "[ID: %d]\n{ffffff}%s"YELLOW_E"\n/parkveh /pickupveh", id, GetLocation(ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ]));
	ppData[id][parkPickup] = CreateDynamicPickup(19134, 23, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], ppData[id][parkWorld],  ppData[id][parkInt]);
	ppData[id][parkLabel] = CreateDynamic3DTextLabel(str, ARWIN, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ] + 0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ppData[id][parkWorld], ppData[id][parkInt], -1, 10.0);
	Iter_Add(Parks, id);
	
	mysql_tquery(g_SQL, "INSERT INTO parks (interior) VALUES (0)", "OnParkCreated", "ii", playerid, id);
	return 1;
}

public:OnParkCreated(playerid, id)
{
	ppData[id][parkID] = cache_insert_id();
	Park_Save(id);
	SendServerMessage(playerid, "You has created Park Point id: %d.", id);
	return 1;
}

CMD:setparkpos(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new id;
	if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/setparkpos [id]");
	if(!Iter_Contains(Parks, id)) return SendErrorMessage(playerid, "Invalid ID.");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	ppData[id][parkX] = x;
	ppData[id][parkY] = y;
	ppData[id][parkZ] = z;
	ppData[id][parkInt] = GetPlayerInterior(playerid);
	ppData[id][parkWorld] = GetPlayerVirtualWorld(playerid);

	if(IsValidDynamicPickup(ppData[id][parkPickup]))
		DestroyDynamicPickup(ppData[id][parkPickup]), ppData[id][parkPickup] = -1;

	if(IsValidDynamic3DTextLabel(ppData[id][parkLabel]))
		DestroyDynamic3DTextLabel(ppData[id][parkLabel]), ppData[id][parkLabel] = Text3D: INVALID_3DTEXT_ID;

	new str[128];
	ppData[id][parkPickup] = CreateDynamicPickup(19134, 23, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], ppData[id][parkWorld],  ppData[id][parkInt]);
	format(str, sizeof(str), "[ID: %d]\n{ffffff}%s"YELLOW_E"\n/parkveh /pickupveh", id, GetLocation(ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ]));
	ppData[id][parkLabel] = CreateDynamic3DTextLabel(str, ARWIN, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ] + 0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ppData[id][parkWorld], ppData[id][parkInt], -1, 10.0);
	Park_Save(id);
	return 1;
}

CMD:removepark(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new id, query[512];
	if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/removepark [id]");
	if(!Iter_Contains(Parks, id)) return SendErrorMessage(playerid, "Invalid ID.");
	
	DestroyDynamic3DTextLabel(ppData[id][parkLabel]);
	DestroyDynamicPickup(ppData[id][parkPickup]);
	
	ppData[id][parkX] = ppData[id][parkY] = ppData[id][parkZ] = 0.0;
	ppData[id][parkInt] = ppData[id][parkWorld] = 0;
	ppData[id][parkPickup] = -1;
	ppData[id][parkLabel] = Text3D: -1;
	Iter_Remove(Parks, id);
	
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM parks WHERE id=%d", id);
	mysql_tquery(g_SQL, query);
	SendServerMessage(playerid, "Menghapus ID Park Point %d.", id);
	return 1;
}

CMD:gotopark(playerid, params[])
{
	new id;
	if(PlayerData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
		
	if(sscanf(params, "d", id))
		return SendSyntaxMessage(playerid, "/gotopark [id]");
	if(!Iter_Contains(Parks, id)) return SendErrorMessage(playerid, "Park Point ID tidak ada.");
	
	SetPlayerPosition(playerid, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], 2.0);
    SetPlayerInterior(playerid, ppData[id][parkInt]);
    SetPlayerVirtualWorld(playerid, ppData[id][parkWorld]);
	SendServerMessage(playerid, "Teleport ke ID Park Point %d", id);
	return 1;
}

