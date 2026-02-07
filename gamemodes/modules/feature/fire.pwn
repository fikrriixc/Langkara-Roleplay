// Fire System
#include <YSI_Coding\y_hooks>

//Enum
enum E_FIRE
{
    fireID,
    fireObject,
    fireModel,
    fireArea,
    fireInterior,
    fireVirtualWorld,
    Float:fireHealth,

    Float:firePosX,
    Float:firePosY,
    Float:firePosZ
};
new 
    FireData[MAX_DYNAMIC_FIRE][E_FIRE],
    Iterator:Fire<MAX_DYNAMIC_FIRE>;

Fire_IsExists(index)
{
	if(Iter_Contains(Fire, index))
		return 1;
	
	return 0;
}

Fire_Create(model, Float:x, Float:y, Float:z, int, vw, Float:health = 100.0)
{
	static
		index;

	if((index = Iter_Free(Fire)) != -1)
	{
		Iter_Add(Fire, index);

        FireData[index][fireModel] = model;
        FireData[index][fireInterior] = int;
        FireData[index][fireVirtualWorld] = vw;
        FireData[index][fireHealth] = health;
		FireData[index][firePosX] = x;
		FireData[index][firePosY] = y;
		FireData[index][firePosZ] = z-2;

		mysql_tquery(g_SQL, sprintf("INSERT INTO `fire` (`interior`, `world`) VALUES ('%d', '%d');", FireData[index][fireInterior], FireData[index][fireVirtualWorld]), "OnFireCreated", "d", index);
		return index;
	}
	return -1;
}

Fire_Delete(index)
{
	if(Fire_IsExists(index))
	{
		Iter_Remove(Fire, index);

		mysql_tquery(g_SQL, sprintf("DELETE FROM `fire` WHERE `id`='%d';", FireData[index][fireID]));

		if(IsValidDynamicArea(FireData[index][fireArea]))
			DestroyDynamicArea(FireData[index][fireArea]);

		if(IsValidDynamicObject(FireData[index][fireObject]))
			DestroyDynamicObject(FireData[index][fireObject]);

		new tmp_FireData[E_FIRE];
		FireData[index] = tmp_FireData;

		FireData[index][fireArea] = INVALID_STREAMER_ID;
		FireData[index][fireObject] = INVALID_STREAMER_ID;
		return 1;
	}
	return 0;
}

Fire_Save(index)
{
    if(!Fire_IsExists(index))
        return 0;

    new fanQuery[5000];
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "UPDATE fire SET");
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s model = '%d',", fanQuery, FireData[index][fireModel]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s interior = '%d',", fanQuery, FireData[index][fireInterior]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s world = '%d',", fanQuery, FireData[index][fireVirtualWorld]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s health = '%f',", fanQuery, FireData[index][fireHealth]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s posx = '%f',", fanQuery, FireData[index][firePosX]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s posy = '%f',", fanQuery, FireData[index][firePosY]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s posz = '%f'", fanQuery, FireData[index][firePosZ]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s WHERE id = '%d'", fanQuery, FireData[index][fireID]);

    mysql_tquery(g_SQL, fanQuery);
    return 1;
}

Fire_Sync(index)
{
	if(Fire_IsExists(index))
	{
		if(IsValidDynamicObject(FireData[index][fireObject]))
		{
            Streamer_SetIntData(STREAMER_TYPE_OBJECT, FireData[index][fireObject], E_STREAMER_MODEL_ID, FireData[index][fireModel]);

			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FireData[index][fireObject], E_STREAMER_X, FireData[index][firePosX]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FireData[index][fireObject], E_STREAMER_Y, FireData[index][firePosY]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FireData[index][fireObject], E_STREAMER_Z, FireData[index][firePosZ] - 0.4);

			Streamer_SetIntData(STREAMER_TYPE_OBJECT, FireData[index][fireObject], E_STREAMER_INTERIOR_ID, FireData[index][fireInterior]);
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, FireData[index][fireObject], E_STREAMER_WORLD_ID, FireData[index][fireVirtualWorld]);

        }
		else 
        {
            FireData[index][fireObject] = CreateDynamicObject(FireData[index][fireModel], FireData[index][firePosX], FireData[index][firePosY], FireData[index][firePosZ] - 0.4, 0.0, 0.0, 0.0, FireData[index][fireVirtualWorld], FireData[index][fireInterior], -1, 50, 50);
        }

		if(IsValidDynamicArea(FireData[index][fireArea]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_X, FireData[index][firePosX]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_Y, FireData[index][firePosY]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_MIN_Z, FireData[index][firePosZ] - 1.0);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_MAX_Z, FireData[index][firePosZ] + 3.0);

			Streamer_SetIntData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_INTERIOR_ID, FireData[index][fireInterior]);
			Streamer_SetIntData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_WORLD_ID, FireData[index][fireVirtualWorld]);
		}
		else
		{			
			FireData[index][fireArea] = CreateDynamicCylinder(FireData[index][firePosX], FireData[index][firePosY], FireData[index][firePosZ] - 1.0, FireData[index][firePosZ] + 3.0, 20.0, FireData[index][fireVirtualWorld], FireData[index][fireInterior]);
			new Fire_Streamer_Info[2]; 

			Fire_Streamer_Info[0] = FIRE_AREA_INDEX;
			Fire_Streamer_Info[1] = index;
			Streamer_SetArrayData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_EXTRA_ID, Fire_Streamer_Info);
		}
	}
	return 1;
}

CreateExplosionEx(Float:x, Float:y, Float:z)
{
    CreateExplosion(x, y, z, 13, 100.0);
    CreateExplosion(x, y, z, 13, 100.0);
    CreateExplosion(x, y, z+10.0, 13, 100.0);
    CreateExplosion(x+random(10)-5, y+random(10)-5, z+random(10)-5, 13, 100.0);
    return 1;
}

Fire_Nearest(playerid)
{
	foreach(new i : Fire) if(IsPlayerInRangeOfPoint(playerid, 10.0, FireData[i][firePosX], FireData[i][firePosY], FireData[i][firePosZ]))
	{
		if(GetPlayerInterior(playerid) == FireData[i][fireInterior] && GetPlayerVirtualWorld(playerid) == FireData[i][fireVirtualWorld])
			return i;
	}
	return -1;
}

Fire_Skin(skinid)
{
    if(skinid == 277 || skinid == 278 || skinid == 279)
        return 1;

    return 0;
}

IsPlayerInFirePoint(playerid, fireid, Float:range = 5.0)
{
    if(Fire_IsExists(fireid))
    {
        if(IsPlayerInRangeOfPoint(playerid, range, FireData[fireid][firePosX], FireData[fireid][firePosY], FireData[fireid][firePosZ]))
        {
            return 1;
        }
        return 0;
    }
    return 0;
}

IsPlayerInFireTruck(playerid)
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(IsSAFDCar(vehicleid))
        {
            return 1;
        }
    }
    return 0;
}

public:Player_FireExhausting(playerid)
{
    if(!PlayerData[playerid][IsLoggedIn])
        return 0;

    new KEY:keys, updown, leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
    if((keys & KEY_FIRE))
    {
        new fireid = Fire_GetInside(playerid);
        if(fireid != INVALID_FIRE_ID)
        {
            if(GetPlayerWeapon(playerid) == WEAPON_FIREEXTINGUISHER && IsPlayerInFirePoint(playerid, fireid, 5.0))
            {
                if(FireData[fireid][fireHealth] > 0) 
                {
                    FireData[fireid][fireHealth] -= 10.0;
                }
                else if(FireData[fireid][fireHealth] <= 0)
                {
                    FireData[fireid][fireHealth] = 0;
                    Fire_Delete(fireid);
                }
            }
            else if(IsPlayerInFireTruck(playerid) && IsPlayerInFirePoint(playerid, fireid, 20.0))
            {
                if(FireData[fireid][fireHealth] > 0) 
                {
                    FireData[fireid][fireHealth] -= 25.0;
                }
                else if(FireData[fireid][fireHealth] <= 0)
                {
                    FireData[fireid][fireHealth] = 0;
                    Fire_Delete(fireid);
                }
            }
        }
    }
    return 1;
}

public:Vehicle_NearFire()
{
    forex(vehicleid, MAX_VEHICLES) if(IsValidVehicle(vehicleid))
    {
        foreach(new fireid : Fire) if(IsVehicleInRangeOfPoint(vehicleid, 8.0, FireData[fireid][firePosX], FireData[fireid][firePosY], FireData[fireid][firePosZ]))
        {
            new Float:health;
            GetVehicleHealth(vehicleid, health);
            SetValidVehicleHealth(vehicleid, health-100.0);
        }
    }
    return 1;
}

public:Player_NearFire(playerid)
{
    new fireid;
    if((fireid = Fire_GetInside(playerid)) != INVALID_FIRE_ID)
    {
        if(IsPlayerInFirePoint(playerid, fireid, 3.0) && !IsPlayerInAnyVehicle(playerid))
        {
            new skinid = GetPlayerSkin(playerid);
            if(!Fire_Skin(skinid))
            {
                new Float:health;
                GetPlayerHealth(playerid, health);
                SetPlayerHealthEx(playerid, health-5);
            }
        }
    }
    return 1;
}

// Callback
public:OnFireCreated(index)
{
	FireData[index][fireID] = cache_insert_id();

	Fire_Sync(index);
    Fire_Save(index);
	return 1;
}

public:LoadFire()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(Fire, i);

			cache_get_value_name_int(i, "id", FireData[i][fireID]);
			cache_get_value_name_int(i, "model", FireData[i][fireModel]);

	        cache_get_value_name_int(i, "interior", FireData[i][fireInterior]);
	        cache_get_value_name_int(i, "world", FireData[i][fireVirtualWorld]);
	        cache_get_value_name_float(i, "health", FireData[i][fireHealth]);

	        cache_get_value_name_float(i, "posx", FireData[i][firePosX]);
            cache_get_value_name_float(i, "posy", FireData[i][firePosY]);
            cache_get_value_name_float(i, "posz", FireData[i][firePosZ]);

			Fire_Sync(i);
		}
		printf("[FIRE] Number of Loaded: %d.", cache_num_rows());
	}
	return 1;
}

CMD:bakar(playerid, params[])
{
    new userid;

    if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

    if(sscanf(params, "u", userid))
        return SendServerMessage(playerid, "/bakar [playerid/PartOfName]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    new Float:x, Float:y, Float:z, vw, int;
    GetPlayerPos(userid, x, y, z);
    vw = GetPlayerVirtualWorld(userid);
    int = GetPlayerInterior(userid);
    SetPlayerHealthEx(userid, 0);
    CreateExplosionEx(x, y, z);
    Fire_Create(18690, x, y, z, int, vw);
    return 1;
}
CMD:nearestfire(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

    static
        id;

    if((id = Fire_Nearest(playerid)) != -1) SendServerMessage(playerid, "You are standing near fire ID: %d.", id);
    else SendServerMessage(playerid, "Kamu tidak berada didekat api apapun!");

    return 1;
}

CMD:destroyfire(playerid, params[])
{
    static
        id;

    if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

    if(sscanf(params, "d", id))
       return SendServerMessage(playerid, "/destroyfire [fireid]");

    if(!Fire_IsExists(id))
        return SendErrorMessage(playerid, "ID Fire yang kamu input tidak terdaftar!");

    Fire_Delete(id);
    SendServerMessage(playerid, "You remove fire id %d", id);
    return 1;
}

CMD:bakarhouse(playerid, params[])
{
    static
        bid;

    if(PlayerData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(sscanf(params, "d", bid))
        return SendSyntaxMessage(playerid, "/bakarhouse [houseid]");

    if((bid < 0 || bid >= MAX_HOUSES))
        return SendErrorMessage(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Houses, bid)) return SendErrorMessage(playerid, "The houses you specified ID of doesn't exist.");

    CreateExplosionEx(hData[bid][hExtposX], hData[bid][hExtposY], hData[bid][hExtposZ]);
    Fire_Create(18690, hData[bid][hExtposX], hData[bid][hExtposY], hData[bid][hExtposZ], 0, 0);

    SendFactionMessage(5, COLOR_LRED, "{00FFFF}[ALARM] {FFFFFF}%s Houses alarm is triggered, houses is on fire", bData[bid][bName]);
    return 1;
}