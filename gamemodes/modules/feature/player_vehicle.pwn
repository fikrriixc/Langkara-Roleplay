
//Private Vehicle Player System Define
new bool:FanAdmin[MAX_VEHICLES];
new bool:VehicleHealthSecurity[MAX_VEHICLES] = false, Float:VehicleHealthSecurityData[MAX_VEHICLES] = 1000.0;

enum pvdata
{
	cID,
	cOwner,
	cModel,
	cColor1,
	cColor2,
	cPaintJob,
	cNeon,
	cTogNeon,
	bool:cToys,
	cLocked,
	cInsu,
	cClaim,
	cClaimTime,
	cPlate[15],
	cPlateTime,
	cTicket,
	cPrice,
	Float:cHealth,
	cFuel,
	Float:cPosX,
	Float:cPosY,
	Float:cPosZ,
	Float:cPosA,
	cInt,
	cVw,
	VEHICLE_PANEL_STATUS:cDamage0,
	VEHICLE_DOOR_STATUS:cDamage1,
	VEHICLE_LIGHT_STATUS:cDamage2,
	VEHICLE_TYRE_STATUS:cDamage3,
	cMod[17],
	cLumber,
	cMetal,
	cCoal,
	cProduct,
	cGasOil,
	cCargoCompo,
	cCargoMat,
	cCargoMilk,
	cRent,
	cVeh,
	cDeath,
	cPark,
	cLockTyre[4]
};
new VehicleData[MAX_PRIVATE_VEHICLE][pvdata],
Iterator:PlayerVehicles<MAX_PRIVATE_VEHICLE >;

//Private Vehicle Player System Native
new const g_arrVehicleNames[][] = {
	"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
	"Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
	"Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
	"Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
	"Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
	"Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
	"Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
	"Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
	"Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
	"FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
	"Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
	"Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
	"Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
	"Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
	"Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
	"Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
	"Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
	"Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
	"Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
	"Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
	"Boxville", "Tiller", "Utility Trailer"
};

GetEngineStatus(vehicleid)
{
	static
	engine,
	lights,
	alarm,
	doors,
	bonnet,
	boot,
	objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(engine != 1)
		return 0;

	return 1;
}

GetLightStatus(vehicleid)
{
	static
	engine,
	lights,
	alarm,
	doors,
	bonnet,
	boot,
	objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(lights != 1)
		return 0;

	return 1;
}

GetHoodStatus(vehicleid)
{
	static
	engine,
	lights,
	alarm,
	doors,
	bonnet,
	boot,
	objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(bonnet != 1)
		return 0;

	return 1;
}

GetWindowStatus(vehicleid) 
{
	if(!IsValidVehicle(vehicleid))
		return -1;
		
	new driver,passenger,backleft,backright;
	GetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, backright);

	if(driver == 1 || passenger == 1 || backleft == 1 || backright == 1) 
	{
		return 1; // At least one window is up
	}
	return 0;
}

GetTrunkStatus(vehicleid)
{
	static
	engine,
	lights,
	alarm,
	doors,
	bonnet,
	boot,
	objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(boot != 1)
		return 0;

	return 1;
}

GetVehicleModelByName(name[])
{
	if(IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
		return strval(name);

	for (new i = 0; i < MAX_VEHICLE_MODELS; i ++)
	{
		if(strfind(EVF::VehicleName[i], name, true) != -1)
		{
			return i + 400;
		}
	}
	return 0;
}

Vehicle_Nearest(playerid, Float:range = 5.5)
{
	new Float:fX,
		Float:fY,
		Float:fZ;

	foreach(new i : PlayerVehicles)
	{
		if(VehicleData[i][cVeh] != INVALID_VEHICLE_ID)
		{
			GetVehiclePos(VehicleData[i][cVeh], fX, fY, fZ);

			if(IsPlayerInRangeOfPoint(playerid, range, fX, fY, fZ)) 
			{
				return i;
			}
		}
	}
	return -1;
}

Vehicle_Nearest2(playerid)
{
	foreach(new i : PlayerVehicles)
	{
		if(VehicleData[i][cVeh] != INVALID_VEHICLE_ID && IsPlayerInAnyVehicle(playerid) && VehicleData[i][cVeh] == GetPlayerVehicleID(playerid))
		{
			return i;
		}
	}
	return -1;
}

Vehicle_HasDriver(vehicleid)
{
	foreach(new playerid : Player) if(IsPlayerInVehicle(playerid, vehicleid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		return 1;

	return 0;
}

Vehicle_IsLocked(vehicleid)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	return doors;
}

Vehicle_GetID(vehicleid)
{
	foreach(new vehid : PlayerVehicles) if(VehicleData[vehid][cVeh] == vehicleid)
		return vehid;

	return -1;
}

GetVehicleOwner(carid)
{
	foreach(new i : Player)
	{
		if(VehicleData[carid][cOwner] == PlayerData[i][pID])
		{
			return i;
		}
	}
	return INVALID_PLAYER_ID;
}

/*GetVehicleOwnerName(carid)
{
	static Oname[MAX_PLAYER_NAME];
	foreach(new i : Player)
	{
		if(VehicleData[carid][cOwner] == PlayerData[i][pID])
		{
			format(Oname, MAX_PLAYER_NAME, PlayerData[i][pName]);
		}
	}
	return Oname;
}*/

Vehicle_IsOwner(playerid, carid)
{
	if(!PlayerData[playerid][IsLoggedIn] || PlayerData[playerid][pID] == -1)
		return 0;

	if((Iter_Contains(PlayerVehicles, carid) && VehicleData[carid][cOwner] != 0) && VehicleData[carid][cOwner] == PlayerData[playerid][pID])
		return 1;

	return 0;
}

Vehicle_GetStatus(carid)
{
	if(IsValidVehicle(VehicleData[carid][cVeh]) && VehicleData[carid][cVeh] != INVALID_VEHICLE_ID)
	{
		GetVehicleDamageStatus(VehicleData[carid][cVeh], VehicleData[carid][cDamage0], VehicleData[carid][cDamage1], VehicleData[carid][cDamage2], VehicleData[carid][cDamage3]);
		GetVehicleHealth(VehicleData[carid][cVeh], VehicleData[carid][cHealth]);
		VehicleData[carid][cFuel] = GetVehicleFuel(VehicleData[carid][cVeh]);
		GetVehiclePos(VehicleData[carid][cVeh], VehicleData[carid][cPosX], VehicleData[carid][cPosY], VehicleData[carid][cPosZ]);
		GetVehicleZAngle(VehicleData[carid][cVeh],VehicleData[carid][cPosA]);
	}
	return 1;
}

CountParkedVeh(id)
{
	if(id > -1)
	{
		new count = 0;
		foreach(new i : PlayerVehicles)
		{
			if(VehicleData[i][cPark] == id)
				count++;
		}
		return count;
	}
	return 0;
}

SetValidVehicleHealth(vehicleid, Float:health) {
	VehicleHealthSecurity[vehicleid] = true;
	VehicleHealthSecurityData[vehicleid] = health;
	SetVehicleHealth(vehicleid, health);
	return 1;
}

ValidRepairVehicle(vehicleid) {
	VehicleHealthSecurity[vehicleid] = true;
	VehicleHealthSecurityData[vehicleid] = 1000.0;
	RepairVehicle(vehicleid);
	return 1;
}


//Private Vehicle Player System Function

public:OnPlayerVehicleRespawn(i)
{
	if(VehicleData[i][cClaim] == 0 && VehicleData[i][cDeath] == 0 && VehicleData[i][cPark] < 0)
	{
		VehicleData[i][cVeh] = CreateVehicle(VehicleData[i][cModel], VehicleData[i][cPosX], VehicleData[i][cPosY], VehicleData[i][cPosZ], VehicleData[i][cPosA], VehicleData[i][cColor1], VehicleData[i][cColor2], -1);
		SetVehicleNumberPlate(VehicleData[i][cVeh], VehicleData[i][cPlate]);
		SetVehicleVirtualWorld(VehicleData[i][cVeh], VehicleData[i][cVw]);
		LinkVehicleToInterior(VehicleData[i][cVeh], VehicleData[i][cInt]);
		SetVehicleFuel(VehicleData[i][cVeh], VehicleData[i][cFuel]);
	}
	if(IsValidVehicle(VehicleData[i][cVeh]))
	{
		if(VehicleData[i][cHealth] < 350.0)
		{
			SetValidVehicleHealth(VehicleData[i][cVeh], 350.0);
		}
		else
		{
			SetValidVehicleHealth(VehicleData[i][cVeh], VehicleData[i][cHealth]);
		}
		UpdateVehicleDamageStatus(VehicleData[i][cVeh], VehicleData[i][cDamage0], VehicleData[i][cDamage1], VehicleData[i][cDamage2], VehicleData[i][cDamage3]);
		if(VehicleData[i][cPaintJob] != -1)
		{
			ChangeVehiclePaintjob(VehicleData[i][cVeh], VehicleData[i][cPaintJob]);
		}
		for(new z = 0; z < 17; z++)
		{
			if(z <= 3 && VehicleData[i][cLockTyre][z]) LockTyre_Attach(VehicleData[i][cVeh], z);
			if(VehicleData[i][cMod][z]) AddVehicleComponent(VehicleData[i][cVeh], VehicleData[i][cMod][z]);
		}
		SwitchVehicleDoors(VehicleData[i][cVeh], bool:VehicleData[i][cLocked]);
		Vehicle_ObjectUpdateAll(i);
	}

	SetTimerEx("OnLoadVehicleStorage", 2000, false, "d", i);
	/*if(VehicleData[i][cClaim] != 0)
	{
		SetTimerEx("RespawnPV", 3000, false, "d", VehicleData[i][cVeh]);
	}*/
	//SwitchVehicleEngine(VehicleData[i][cVeh], false);
    return 1;
}

public:OnLoadVehicleStorage(i)
{
	if(IsValidVehicle(VehicleData[i][cVeh]))
	{
		if(IsAPickup(VehicleData[i][cVeh]))
		{
			if(VehicleData[i][cLumber] > -1)
			{
				for(new lid; lid < VehicleData[i][cLumber]; lid++)
				{
					if(!IsValidDynamicObject(LumberObjects[VehicleData[i][cVeh]][lid]))
					{
						LumberObjects[VehicleData[i][cVeh]][lid] = CreateDynamicObject(19793, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
						AttachDynamicObjectToVehicle(LumberObjects[VehicleData[i][cVeh]][lid], VehicleData[i][cVeh], LumberAttachOffsets[lid][0], LumberAttachOffsets[lid][1], LumberAttachOffsets[lid][2], 0.0, 0.0, LumberAttachOffsets[lid][3]);
					}
				}
			}
			else if(VehicleData[i][cLumber] == -1)
			{
				for(new a; a < LUMBER_LIMIT; a++)
				{
					if(IsValidDynamicObject(LumberObjects[VehicleData[i][cVeh]][a]))
					{
						DestroyDynamicObject(LumberObjects[VehicleData[i][cVeh]][a]);
						LumberObjects[VehicleData[i][cVeh]][a] = -1;
					}
				}
			}
		}
		if(VehicleData[i][cTogNeon] == 1)
		{
			if(VehicleData[i][cNeon] != 0)
			{
				SetVehicleNeonLights(VehicleData[i][cVeh], true, VehicleData[i][cNeon], 0);
			}
		}

		if(VehicleData[i][cMetal] > 0)
		{

			LogStorage[VehicleData[i][cVeh]][ 0 ] = VehicleData[i][cMetal];
		}
		else
		{
			LogStorage[VehicleData[i][cVeh]][ 0 ] = 0;
		}

		if(VehicleData[i][cCoal] > 0)
		{
			LogStorage[VehicleData[i][cVeh]][ 1 ] = VehicleData[i][cCoal];
		}
		else
		{
			LogStorage[VehicleData[i][cVeh]][ 1 ] = 0;
		}

		if(VehicleData[i][cProduct] > 0)
		{
			VehProduct[VehicleData[i][cVeh]] = VehicleData[i][cProduct];
		}
		else
		{
			VehProduct[VehicleData[i][cVeh]] = 0;
		}

		if(VehicleData[i][cGasOil] > 0)
		{
			VehGasOil[VehicleData[i][cVeh]] = VehicleData[i][cGasOil];
		}
		else
		{
			VehGasOil[VehicleData[i][cVeh]] = 0;
		}
	}
}

Vehicle_Load(playerid)
{
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `vehicle` WHERE `owner` = '%d'", PlayerData[playerid][pID]);
	mysql_tquery(g_SQL, query, "LoadPlayerVehicle", "d", playerid);
	return 1;
}

public:LoadPlayerVehicle(playerid)
{
	new count = cache_num_rows(), tempString[56];
	if(count > 0)
	{
		for(new z = 0; z < count; z++)
		{
			new i = Iter_Free(PlayerVehicles);
			VehicleStorage_Reset(i);
			cache_get_value_name_int(z, "id", VehicleData[i][cID]);
			//VehicleData[i][VehicleOwned] = true;
			cache_get_value_name_int(z, "owner", VehicleData[i][cOwner]);
			cache_get_value_name_int(z, "locked", VehicleData[i][cLocked]);
			cache_get_value_name_int(z, "insu", VehicleData[i][cInsu]);
			cache_get_value_name_int(z, "claim", VehicleData[i][cClaim]);
			cache_get_value_name_int(z, "claim_time", VehicleData[i][cClaimTime]);
			cache_get_value_name_float(z, "x", VehicleData[i][cPosX]);
			cache_get_value_name_float(z, "y", VehicleData[i][cPosY]);
			cache_get_value_name_float(z, "z", VehicleData[i][cPosZ]);
			cache_get_value_name_float(z, "a", VehicleData[i][cPosA]);
			cache_get_value_name_float(z, "health", VehicleData[i][cHealth]);
			cache_get_value_name_int(z, "fuel", VehicleData[i][cFuel]);
			cache_get_value_name_int(z, "int", VehicleData[i][cInt]);
			cache_get_value_name_int(z, "vw", VehicleData[i][cVw]);
			cache_get_value_name_int(z, "damage0", _:VehicleData[i][cDamage0]);
			cache_get_value_name_int(z, "damage1", _:VehicleData[i][cDamage1]);
			cache_get_value_name_int(z, "damage2", _:VehicleData[i][cDamage2]);
			cache_get_value_name_int(z, "damage3", _:VehicleData[i][cDamage3]);
			cache_get_value_name_int(z, "color1", VehicleData[i][cColor1]);
			cache_get_value_name_int(z, "color2", VehicleData[i][cColor2]);
			cache_get_value_name_int(z, "paintjob", VehicleData[i][cPaintJob]);
			cache_get_value_name_int(z, "neon", VehicleData[i][cNeon]);
			VehicleData[i][cTogNeon] = 0;
			cache_get_value_name_int(z, "price", VehicleData[i][cPrice]);
			cache_get_value_name_int(z, "model", VehicleData[i][cModel]);
			cache_get_value_name(z, "plate", tempString);
			format(VehicleData[i][cPlate], 16, tempString);
			cache_get_value_name_int(z, "plate_time", VehicleData[i][cPlateTime]);
			cache_get_value_name_int(z, "ticket", VehicleData[i][cTicket]);

			cache_get_value_name_int(z, "locktyre0", VehicleData[i][cLockTyre][0]);
			cache_get_value_name_int(z, "locktyre1", VehicleData[i][cLockTyre][1]);
			cache_get_value_name_int(z, "locktyre2", VehicleData[i][cLockTyre][2]);
			cache_get_value_name_int(z, "locktyre3", VehicleData[i][cLockTyre][3]);
			cache_get_value_name_int(z, "mod0", VehicleData[i][cMod][0]);
			cache_get_value_name_int(z, "mod1", VehicleData[i][cMod][1]);
			cache_get_value_name_int(z, "mod2", VehicleData[i][cMod][2]);
			cache_get_value_name_int(z, "mod3", VehicleData[i][cMod][3]);
			cache_get_value_name_int(z, "mod4", VehicleData[i][cMod][4]);
			cache_get_value_name_int(z, "mod5", VehicleData[i][cMod][5]);
			cache_get_value_name_int(z, "mod6", VehicleData[i][cMod][6]);
			cache_get_value_name_int(z, "mod7", VehicleData[i][cMod][7]);
			cache_get_value_name_int(z, "mod8", VehicleData[i][cMod][8]);
			cache_get_value_name_int(z, "mod9", VehicleData[i][cMod][9]);
			cache_get_value_name_int(z, "mod10", VehicleData[i][cMod][10]);
			cache_get_value_name_int(z, "mod11", VehicleData[i][cMod][11]);
			cache_get_value_name_int(z, "mod12", VehicleData[i][cMod][12]);
			cache_get_value_name_int(z, "mod13", VehicleData[i][cMod][13]);
			cache_get_value_name_int(z, "mod14", VehicleData[i][cMod][14]);
			cache_get_value_name_int(z, "mod15", VehicleData[i][cMod][15]);
			cache_get_value_name_int(z, "mod16", VehicleData[i][cMod][16]);
			cache_get_value_name_int(z, "lumber", VehicleData[i][cLumber]);
			cache_get_value_name_int(z, "metal", VehicleData[i][cMetal]);
			cache_get_value_name_int(z, "coal", VehicleData[i][cCoal]);
			cache_get_value_name_int(z, "product", VehicleData[i][cProduct]);
			cache_get_value_name_int(z, "gasoil", VehicleData[i][cGasOil]);
			cache_get_value_name_int(z, "cargocompo", VehicleData[i][cCargoCompo]);
			cache_get_value_name_int(z, "cargomat", VehicleData[i][cCargoMat]);
			cache_get_value_name_int(z, "cargomat", VehicleData[i][cCargoMat]);
			cache_get_value_name_int(z, "rental", VehicleData[i][cRent]);
			cache_get_value_name_int(z, "park", VehicleData[i][cPark]);
			Iter_Add(PlayerVehicles, i);

			if(VehicleData[i][cClaim] == 0)
			{
				OnPlayerVehicleRespawn(i);
			}
			else
			{
				VehicleData[i][cVeh] = 0;
			}
		}
		foreach(new vehid : PlayerVehicles) if(Vehicle_IsOwner(playerid, vehid))
		{
			Vehicle_LoadByFann(vehid);
		}

		printf("[P_VEHICLE] Loaded player vehicle from: %s(%d)", PlayerData[playerid][pName], playerid);
	}
	return 1;
}

Vehicle_LoadByFann(carid)
{
	VehicleStorage_Load(carid);
	Vehicle_ObjectLoad(carid);
	return 1;
}

public:EngineStatus(playerid, vehicleid)
{
	if(!GetEngineStatus(vehicleid))
	{
		foreach(new ii : PlayerVehicles)
		{
			if(vehicleid == VehicleData[ii][cVeh])
			{
				if(VehicleData[ii][cTicket] >= 2000)
					return SendErrorMessage(playerid, "Kendaraan ini sudah ditilang oleh Polisi! /v insu - untuk memeriksa");
			}
		}
		new Float: f_vHealth;
		GetVehicleHealth(vehicleid, f_vHealth);
		if(f_vHealth < 350.0) return SendErrorMessage(playerid, "Kendaraan tidak dapat Menyala, Sudah rusak!");
		if(GetVehicleFuel(vehicleid) <= 0.0) return SendErrorMessage(playerid, "Kendaraan tidak dapat Menyala, Bensin habis!");

		SwitchVehicleEngine(vehicleid, true);
		InfoTD_MSG(playerid, 4000, "Engine ~g~started");
	}
	else
	{
		//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mematikan mesin kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)));
		SwitchVehicleEngine(vehicleid, false);
		//Info(playerid, "Engine turn off..");
		InfoTD_MSG(playerid, 4000, "Engine ~r~OFF");
	}
	return 1;
}

Vehicle_Save(i)
{
	Vehicle_GetStatus(i);

	new cQuery[5000];
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `vehicle` SET ");
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`owner`='%d', ", cQuery, VehicleData[i][cOwner]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`x`='%f', ", cQuery, VehicleData[i][cPosX]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`y`='%f', ", cQuery, VehicleData[i][cPosY]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`z`='%f', ", cQuery, VehicleData[i][cPosZ]+0.1);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`a`='%f', ", cQuery, VehicleData[i][cPosA]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`health`='%f', ", cQuery, VehicleData[i][cHealth]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fuel`=%d, ", cQuery, VehicleData[i][cFuel]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`int`=%d, ", cQuery, VehicleData[i][cInt]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`price`=%d, ", cQuery, VehicleData[i][cPrice]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`vw`=%d, ", cQuery, VehicleData[i][cVw]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`model`=%d, ", cQuery, VehicleData[i][cModel]);
	if(VehicleData[i][cLocked] == 1)
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`locked`=1, ", cQuery);
	else
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`locked`=0, ", cQuery);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`insu`='%d', ", cQuery, VehicleData[i][cInsu]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`claim`='%d', ", cQuery, VehicleData[i][cClaim]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`claim_time`='%d', ", cQuery, VehicleData[i][cClaimTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`plate`='%e', ", cQuery, VehicleData[i][cPlate]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`plate_time`='%d', ", cQuery, VehicleData[i][cPlateTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ticket`='%d', ", cQuery, VehicleData[i][cTicket]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`color1`=%d, ", cQuery, VehicleData[i][cColor1]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`color2`=%d, ", cQuery, VehicleData[i][cColor2]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`paintjob`=%d, ", cQuery, VehicleData[i][cPaintJob]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`neon`=%d, ", cQuery, VehicleData[i][cNeon]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`damage0`=%d, ", cQuery, _:VehicleData[i][cDamage0]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`damage1`=%d, ", cQuery, _:VehicleData[i][cDamage1]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`damage2`=%d, ", cQuery, _:VehicleData[i][cDamage2]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`damage3`=%d, ", cQuery, _:VehicleData[i][cDamage3]);
	new tempString[56];
	for(new z = 0; z < 17; z++)
	{
		format(tempString, sizeof(tempString), "mod%d", z);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`%s`=%d, ", cQuery, tempString, VehicleData[i][cMod][z]);
	}
	for(new z = 0; z < 4; z++)
	{
		format(tempString, sizeof(tempString), "locktyre%d", z);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`%s`=%d, ", cQuery, tempString, VehicleData[i][cLockTyre][z]);
	}
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`lumber`=%d, ", cQuery, VehicleData[i][cLumber]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`metal`=%d, ", cQuery, VehicleData[i][cMetal]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`coal`=%d, ", cQuery, VehicleData[i][cCoal]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`product`=%d, ", cQuery, VehicleData[i][cProduct]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gasoil`=%d, ", cQuery, VehicleData[i][cGasOil]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`cargocompo`=%d, ", cQuery, VehicleData[i][cCargoCompo]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`cargomat`=%d, ", cQuery, VehicleData[i][cCargoMat]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`cargomilk`=%d, ", cQuery, VehicleData[i][cCargoMilk]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`park`=%d, ", cQuery, VehicleData[i][cPark]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`rental`=%d ", cQuery, VehicleData[i][cRent]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `id` = %d", cQuery, VehicleData[i][cID]);
	mysql_tquery(g_SQL, cQuery);

	forex(id, MAX_VEHICLE_OBJECT)
	{
		Vehicle_ObjectSave(i, id);
	}
	return 1;
}

public:RemovePlayerVehicle(playerid)
{
	foreach(new i : PlayerVehicles)
	{
		if(VehicleData[i][cOwner] == PlayerData[playerid][pID])
		{
			Vehicle_Save(i);

			if(VehicleData[i][cNeon] != 0)
			{
				SetVehicleNeonLights(VehicleData[i][cVeh], false, VehicleData[i][cNeon], 0);
			}
			VehicleStorage_Reset(i);
			forex(id, MAX_VEHICLE_OBJECT)
			{
				Vehicle_ObjectReset(i, id);
			}
			if(VehicleData[i][cVeh] != 0)
			{
				DisableVehicleSpeedCap(GetPlayerVehicleID(playerid));
				if(IsValidVehicle(VehicleData[i][cVeh])) DestroyVehicle(VehicleData[i][cVeh]);
				VehicleData[i][cVeh] = INVALID_VEHICLE_ID;
			}
			Iter_Remove(PlayerVehicles, i);
		}
	}
}

public:OnVehCreated(playerid, oid, pid, model, color1, color2, Float:x, Float:y, Float:z, Float:a)
{
	new i = Iter_Free(PlayerVehicles);
	new price = GetVehicleCost(model);
	VehicleData[i][cID] = cache_insert_id();
	VehicleData[i][cOwner] = pid;
	VehicleData[i][cModel] = model;
	VehicleData[i][cColor1] = color1;
	VehicleData[i][cColor2] = color2;
	VehicleData[i][cPaintJob] = -1;
	VehicleData[i][cNeon] = 0;
	VehicleData[i][cTogNeon] = 0;
	VehicleData[i][cLocked] = 0;
	VehicleData[i][cInsu] = 3;
	VehicleData[i][cClaim] = 0;
	VehicleData[i][cClaimTime] = 0;
	VehicleData[i][cTicket] = 0;
	VehicleData[i][cPrice] = price;
	VehicleData[i][cHealth] = 2000;
	VehicleData[i][cFuel] = 100;
	format(VehicleData[i][cPlate], 16, "NoHave");
	VehicleData[i][cPlateTime] = 0;
	VehicleData[i][cPosX] = x;
	VehicleData[i][cPosY] = y;
	VehicleData[i][cPosZ] = z;
	VehicleData[i][cPosA] = a;
	VehicleData[i][cInt] = 0;
	VehicleData[i][cVw] = 0;
	VehicleData[i][cLumber] = -1;
	VehicleData[i][cMetal] = 0;
	VehicleData[i][cCoal] = 0;
	VehicleData[i][cProduct] = 0;
	VehicleData[i][cGasOil] = 0;
	VehicleData[i][cRent] = 0;
	VehicleData[i][cPark] = -1;
	for(new j = 0; j < 17; j++)
		VehicleData[i][cMod][j] = 0;
	Iter_Add(PlayerVehicles, i);
	OnPlayerVehicleRespawn(i);
	SendServerMessage(playerid, "Anda telah membuat kendaraan kepada %s dengan (model=%d, color1=%d, color2=%d)", PlayerData[oid][pName], model, color1, color2);
	return 1;
}

public:OnVehBuyPV(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a)
{
	new i = Iter_Free(PlayerVehicles);
	VehicleData[i][cID] = cache_insert_id();
	VehicleData[i][cOwner] = pid;
	VehicleData[i][cModel] = model;
	VehicleData[i][cColor1] = color1;
	VehicleData[i][cColor2] = color2;
	VehicleData[i][cPaintJob] = -1;
	VehicleData[i][cNeon] = 0;
	VehicleData[i][cTogNeon] = 0;
	VehicleData[i][cLocked] = 0;
	VehicleData[i][cInsu] = 3;
	VehicleData[i][cClaim] = 0;
	VehicleData[i][cClaimTime] = 0;
	VehicleData[i][cTicket] = 0;
	VehicleData[i][cPrice] = cost;
	VehicleData[i][cHealth] = 2000;
	VehicleData[i][cFuel] = 100;
	format(VehicleData[i][cPlate], 16, "NoHave");
	VehicleData[i][cPlateTime] = 0;
	VehicleData[i][cPosX] = x;
	VehicleData[i][cPosY] = y;
	VehicleData[i][cPosZ] = z;
	VehicleData[i][cPosA] = a;
	VehicleData[i][cInt] = 0;
	VehicleData[i][cVw] = 0;
	VehicleData[i][cLumber] = -1;
	VehicleData[i][cMetal] = 0;
	VehicleData[i][cCoal] = 0;
	VehicleData[i][cProduct] = 0;
	VehicleData[i][cGasOil] = 0;
	VehicleData[i][cRent] = 0;
	VehicleData[i][cPark] = -1;
	for(new j = 0; j < 17; j++)
		VehicleData[i][cMod][j] = 0;
	Iter_Add(PlayerVehicles, i);
	OnPlayerVehicleRespawn(i);
	SendServerMessage(playerid, "Anda telah membeli kendaraan seharga %s dengan model %s(%d)", FormatMoney(GetVehicleCost(model)), GetVehicleModelName(model), model);
	SetPlayerPosition(playerid, 1800.99, -1800.90, 13.54, 6.14, 0);
	PlayerData[playerid][pBuyPvModel] = 0;
	return 1;
}

public:OnVehBuyVIPPV(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a)
{
	new i = Iter_Free(PlayerVehicles);
	VehicleData[i][cID] = cache_insert_id();
	VehicleData[i][cOwner] = pid;
	VehicleData[i][cModel] = model;
	VehicleData[i][cColor1] = color1;
	VehicleData[i][cColor2] = color2;
	VehicleData[i][cPaintJob] = -1;
	VehicleData[i][cNeon] = 0;
	VehicleData[i][cTogNeon] = 0;
	VehicleData[i][cLocked] = 0;
	VehicleData[i][cInsu] = 3;
	VehicleData[i][cClaim] = 0;
	VehicleData[i][cClaimTime] = 0;
	VehicleData[i][cTicket] = 0;
	VehicleData[i][cPrice] = cost;
	VehicleData[i][cHealth] = 2000;
	VehicleData[i][cFuel] = 100;
	format(VehicleData[i][cPlate], 16, "NoHave");
	VehicleData[i][cPlateTime] = 0;
	VehicleData[i][cPosX] = x;
	VehicleData[i][cPosY] = y;
	VehicleData[i][cPosZ] = z;
	VehicleData[i][cPosA] = a;
	VehicleData[i][cInt] = 0;
	VehicleData[i][cVw] = 0;
	VehicleData[i][cLumber] = -1;
	VehicleData[i][cMetal] = 0;
	VehicleData[i][cCoal] = 0;
	VehicleData[i][cProduct] = 0;
	VehicleData[i][cGasOil] = 0;
	VehicleData[i][cRent] = 0;
	VehicleData[i][cPark] = -1;
	for(new j = 0; j < 17; j++)
		VehicleData[i][cMod][j] = 0;
	Iter_Add(PlayerVehicles, i);
	OnPlayerVehicleRespawn(i);
	SendServerMessage(playerid, "Anda telah membeli kendaraan VIP seharga %d gold dengan model %s(%d)", GetVipVehicleCost(model), GetVehicleModelName(model), model);
	SetPlayerPosition(playerid, 1800.99, -1800.90, 13.54, 6.14, 0);
	return 1;
}

public:OnVehRentPV(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a, rental)
{
	new i = Iter_Free(PlayerVehicles);
	VehicleData[i][cID] = cache_insert_id();
	VehicleData[i][cOwner] = pid;
	VehicleData[i][cModel] = model;
	VehicleData[i][cColor1] = color1;
	VehicleData[i][cColor2] = color2;
	VehicleData[i][cPaintJob] = -1;
	VehicleData[i][cNeon] = 0;
	VehicleData[i][cTogNeon] = 0;
	VehicleData[i][cLocked] = 0;
	VehicleData[i][cInsu] = 3;
	VehicleData[i][cClaim] = 0;
	VehicleData[i][cClaimTime] = 0;
	VehicleData[i][cTicket] = 0;
	VehicleData[i][cPrice] = cost;
	VehicleData[i][cHealth] = 2000;
	VehicleData[i][cFuel] = 100;
	format(VehicleData[i][cPlate], 16, "NoHave");
	VehicleData[i][cPlateTime] = 0;
	VehicleData[i][cPosX] = x;
	VehicleData[i][cPosY] = y;
	VehicleData[i][cPosZ] = z;
	VehicleData[i][cPosA] = a;
	VehicleData[i][cInt] = 0;
	VehicleData[i][cVw] = 0;
	VehicleData[i][cLumber] = -1;
	VehicleData[i][cMetal] = 0;
	VehicleData[i][cCoal] = 0;
	VehicleData[i][cProduct] = 0;
	VehicleData[i][cGasOil] = 0;
	VehicleData[i][cRent] = rental;
	VehicleData[i][cPark] = -1;
	for(new j = 0; j < 17; j++)
		VehicleData[i][cMod][j] = 0;
	Iter_Add(PlayerVehicles, i);
	OnPlayerVehicleRespawn(i);
	SendServerMessage(playerid, "Anda telah menyewa kendaraan seharga $500 / one days dengan model %s(%d)", GetVehicleModelName(model), model);
	SetPlayerPosition(playerid, 1800.99, -1800.90, 13.54, 6.14, 0);
	PlayerData[playerid][pBuyPvModel] = 0;
	return 1;
}

public:RespawnPV(vehicleid)
{
	SetVehicleToRespawn(vehicleid);
	SetValidVehicleHealth(vehicleid, 1000);
	SetVehicleFuel(vehicleid, 100);
	return 1;
}

Vehicle_GetCount(playerid)
{
	new count = 0;
	foreach(new pvid : PlayerVehicles) if(VehicleData[pvid][cOwner] == PlayerData[playerid][pID])
		count ++;

	return count;
}

Vehicle_Create(playerid, modelid, color1 = -1, color2 = -1, price, bool:playerpos = true)
{
	new i = Iter_Free(PlayerVehicles);
	if(i != -1)
	{
		if(Vehicle_GetCount(playerid) >= MAX_PLAYER_VEHICLE + PlayerData[playerid][pVip])
		{
			SendErrorMessage(playerid, "You don't have any slot for vehicle!");
			return -1;
		}

		VehicleData[i][cOwner] = PlayerData[playerid][pID];
		VehicleData[i][cModel] = modelid;
		VehicleData[i][cColor1] = color1;
		VehicleData[i][cColor2] = color2;
		VehicleData[i][cPrice] = price;

		VehicleData[i][cPaintJob] = -1;
		VehicleData[i][cNeon] = 0;
		VehicleData[i][cTogNeon] = 0;
		VehicleData[i][cLocked] = 0;
		VehicleData[i][cInsu] = 3;
		VehicleData[i][cClaim] = 0;
		VehicleData[i][cClaimTime] = 0;
		VehicleData[i][cTicket] = 0;
		VehicleData[i][cHealth] = 1000;
		VehicleData[i][cFuel] = 100;
		format(VehicleData[i][cPlate], 16, "NoHave");
		VehicleData[i][cPlateTime] = 0;
		if(!playerpos)
		{
			VehicleData[i][cPosX] = GetPVarFloat(playerid, "VehPosX");
			VehicleData[i][cPosY] = GetPVarFloat(playerid, "VehPosY");
			VehicleData[i][cPosZ] = GetPVarFloat(playerid, "VehPosZ");
			VehicleData[i][cPosA] = GetPVarFloat(playerid, "VehPosA");
		}
		else
		{
			GetPlayerPos(playerid, VehicleData[i][cPosX], VehicleData[i][cPosY], VehicleData[i][cPosZ]);
			GetPlayerFacingAngle(playerid, VehicleData[i][cPosA]);
		}
		VehicleData[i][cInt] = 0;
		VehicleData[i][cVw] = 0;
		VehicleData[i][cLumber] = -1;
		VehicleData[i][cMetal] = 0;
		VehicleData[i][cCoal] = 0;
		VehicleData[i][cProduct] = 0;
		VehicleData[i][cGasOil] = 0;
		VehicleData[i][cCargoCompo] = 0;
		VehicleData[i][cCargoMat] = 0;
		VehicleData[i][cCargoMilk] = 0; 
		VehicleData[i][cRent] = 0;
		VehicleData[i][cPark] = -1;
		for(new j = 0; j < 17; j++)
			VehicleData[i][cMod][j] = 0;
		/*for(new f = 0; f < MAX_VEHICLE_STORAGE; f++)
			VehicleData[i][cTrunkType][f] = false;*/
		VehicleStorage_Reset(i);
		Iter_Add(PlayerVehicles, i);

		mysql_tquery(g_SQL, sprintf("INSERT INTO vehicle (owner) VALUES('%d')", VehicleData[i][cOwner]), "OnPVehCreated", "d", i);
		return i;
	}
	return -1;
}

public:OnPVehCreated(vehid)
{
	VehicleData[vehid][cID] = cache_insert_id();
	OnPlayerVehicleRespawn(vehid);
	Vehicle_Save(vehid);
	return 1;
}

public:OnPVehSave(vehid)
{
	Vehicle_Save(vehid);
	return 1;
}

// Private Vehicle Player System Commands

CMD:pickupveh(playerid, params[])
{
	if(PlayerData[playerid][IsLoggedIn] == false) return SendErrorMessage(playerid, "Kamu harus login!");
	if(PlayerData[playerid][pInjured] >= 1) return SendErrorMessage(playerid, "Kamu tidak bisa melakukan ini!");
	if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You must be not in Vehicle");
	
	new id;
	id = GetClosestParks(playerid);

	if(id != -1)
	{
		PlayerData[playerid][pPark] = id;
		new location[4080], num, bool:found;

		strcat(location, "No\tVehicle\tPlate\n");
		foreach(new vid : PlayerVehicles) if(VehicleData[vid][cPark] == id)
		{
			if(Vehicle_IsOwner(playerid, vid))
			{
				found = true;
				strcat(location, sprintf("%d.\t%s\t%s\n", num+1, GetVehicleModelName(VehicleData[vid][cModel]), VehicleData[vid][cPlate]), sizeof(location));
				PlayerData[playerid][pValueListitem][num] = vid;
				num++;
			}
		}

		if(found)
			ShowPlayerDialog(playerid, DIALOG_PICKUPVEH, DIALOG_STYLE_TABLIST_HEADERS,"Parked Vehicle",location,"Pickup","Cancel");
		else
			SendErrorMessage(playerid, "Tidak ada kendaraan milikmu terparkir di sini!");
	}
	else
		SendErrorMessage(playerid, "You aren't near at parking area!");
	return 1;
}

CMD:parkveh(playerid, params[])
{
	if(PlayerData[playerid][IsLoggedIn] == false) return SendErrorMessage(playerid, "Kamu harus login!");
	if(PlayerData[playerid][pInjured] >= 1) return SendErrorMessage(playerid, "Kamu tidak bisa melakukan ini!");
	if(!IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "You must be in Vehicle");
	new id;
	id = GetClosestParks(playerid);
	
	if(id != -1)
	{
		if(CountParkedVeh(id) >= 40)
			return SendErrorMessage(playerid, "Garasi Kota sudah memenuhi Kapasitas!");

		new carid;

    	if((carid = Vehicle_GetID(GetPlayerVehicleID(playerid))) != -1)
    	{
			if(Vehicle_IsOwner(playerid, carid))
			{
				RemovePlayerFromVehicle(playerid);

				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
				VehicleData[carid][cPark] = id;
				InfoTD_MSG(playerid, 4000, "Vehicle ~r~Despawned");
				SetPlayerArmedWeapon(playerid, WEAPON_FIST);
				
				Vehicle_Save(carid);
				Vehicle_ObjectDespawnAll(carid);
				if(IsValidVehicle(VehicleData[carid][cVeh]))
				{
					DestroyVehicle(VehicleData[carid][cVeh]);
					VehicleData[carid][cVeh] = INVALID_VEHICLE_ID;
				}
			}
			else
				SendErrorMessage(playerid, "Kendaraan ini bukan milikmu!");
		}
		else 
			SendErrorMessage(playerid, "Kendaraan ini tidak dapat di Park!");
	}
	else
		SendErrorMessage(playerid, "Kamu tidak di dekat parking area!");

	return 1;
}

CMD:aeject(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "Anda bukan Admin!");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new otherid;
		if(sscanf(params, "u", otherid))
			return SendSyntaxMessage(playerid, "/aeject [playerid id/name]");

		if(IsPlayerInVehicle(otherid, vehicleid))
		{
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah menendang %s dari kendaraannya.", ReturnName(playerid));
			SendServerMessage(otherid, "{ff0000}%s {ffffff}telah menendang anda dari kendaraan", PlayerData[playerid][pAdminname]);
			RemovePlayerFromVehicle(otherid);
		}
		else
		{
			SendErrorMessage(otherid, "Player/Target tidak berada didalam Kendaraan");
		}
	}
	else
	{
		SendErrorMessage(playerid, "Anda tidak berada didalam kendaraan");
	}
	return 1;
}

CMD:limitspeed(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new Float:speed;
		if(sscanf(params, "f", speed))
			return SendSyntaxMessage(playerid, "/limitspeed [speed - 0 to disable]");

		if(speed > 0.0)
		{
			SendInfoMessage(playerid, "Set Vehicle Limit Speed to %f", speed);
			SetVehicleSpeedCap(GetPlayerVehicleID(playerid), speed);
		}
		else if(speed < 1.0)
		{
			SendInfoMessage(playerid, "You disable this Vehicle Speed");
			DisableVehicleSpeedCap(GetPlayerVehicleID(playerid));
		}
	}
	return 1;
}

CMD:eject(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new otherid;
		if(sscanf(params, "u", otherid))
			return SendSyntaxMessage(playerid, "/eject [playerid id/name]");

		if(IsPlayerInVehicle(otherid, vehicleid))
		{
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah menendang %s dari kendaraannya.", ReturnName(playerid), ReturnName(otherid));
			SendServerMessage(otherid, "%s telah menendang anda dari kendaraan", PlayerData[playerid][pName]);
			RemovePlayerFromVehicle(otherid);
		}
		else
		{
			SendErrorMessage(otherid, "Player/Target tidak berada didalam Kendaraan");
		}
	}
	else
	{
		SendErrorMessage(playerid, "Anda tidak berada didalam kendaraan");
	}
	return 1;
}

CMD:createpv(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new model[64], color1, color2, otherid, modelid;
	if(sscanf(params, "us[64]dd", otherid, model, color1, color2)) return SendSyntaxMessage(playerid, "/createpv [name/playerid] [model/name] [color1] [color2]");

	if(color1 < 0 || color1 > 255) { SendErrorMessage(playerid, "Color Number can't be below 0 or above 255 !"); return 1; }
	if(color2 < 0 || color2 > 255) { SendErrorMessage(playerid, "Color Number can't be below 0 or above 255 !"); return 1; }

	if((modelid = GetVehicleModelByName(model)) == 0)
        return SendErrorMessage(playerid, "Invalid model ID.");

	if(otherid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Invalid player ID!");
	
	new pvid;
	if((pvid = Vehicle_Create(otherid, modelid, color1, color2, GetVehicleCost(modelid))) == -1)
		return 1;

	SendClientMessage(otherid, COLOR_LRED, "AdmCmd: %s has give you vehicle %s", PlayerData[playerid][pAdminname], GetVehicleName(VehicleData[pvid][cVeh]));
	SendCustomMessage(playerid, "AdmCmd", "You have give {ffff00}%s{ffffff} to %s.", GetVehicleName(VehicleData[pvid][cVeh]), ReturnName(otherid));
	StaffCommandLog("CREATEPV", playerid, otherid, sprintf("%s(%d,%d)", GetVehicleName(VehicleData[pvid][cVeh]), color1, color2));
	return 1;
}

CMD:deletepv(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new vehid;
	if(sscanf(params, "d", vehid)) return SendSyntaxMessage(playerid, "/deletepv [vehid] | /apv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "Invalid id");

	foreach(new i : PlayerVehicles)			
	{
		if(vehid == VehicleData[i][cVeh])
		{
			SendServerMessage(playerid, "You are deleted private vehicle id %d (database id: %d).", vehid, VehicleData[i][cID]);
			new query[256];
			mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", VehicleData[i][cID]);
			mysql_tquery(g_SQL, query);
			if(IsValidVehicle(VehicleData[i][cVeh])) DestroyVehicle(VehicleData[i][cVeh]);
			VehicleData[i][cVeh] = INVALID_VEHICLE_ID;
			Iter_Remove(PlayerVehicles, i);
		}
	}
	return 1;
}

/*CMD:deletepv(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new otherid;
	if(sscanf(params, "u", otherid)) return SendSyntaxMessage(playerid, "/gotopv [name/playerid]");
	if(otherid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Invalid playerid");
	
	new bool:found = false, msg2[512], Float:fx, Float:fy, Float:fz;
	format(msg2, sizeof(msg2), "ID\tModel\tLocation\n");
	foreach(new i : PlayerVehicles)
	{
		if(VehicleData[i][cOwner] == PlayerData[otherid][pID])
		{
			GetVehiclePos(VehicleData[i][cVeh], fx, fy, fz);
			format(msg2, sizeof(msg2), "%s%d\t%s\t%s\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), GetLocation(fx, fy, fz));
			found = true;
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_DELETEVEH, DIALOG_STYLE_TABLIST_HEADERS, "Delete Vehicles", msg2, "Delete", "Close");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Player ini tidak memeliki kendaraan", "Close", "");
			
	return 1;
}

CMD:gotopv(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new otherid;
	if(sscanf(params, "u", otherid)) return SendSyntaxMessage(playerid, "/gotopv [name/playerid]");
	if(otherid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Invalid playerid");
	
	new bool:found = false, msg2[512], Float:fx, Float:fy, Float:fz;
	format(msg2, sizeof(msg2), "ID\tModel\tLocation\n");
	foreach(new i : PlayerVehicles)
	{
		if(VehicleData[i][cOwner] == PlayerData[otherid][pID])
		{
			GetVehiclePos(VehicleData[i][cVeh], fx, fy, fz);
			format(msg2, sizeof(msg2), "%s%d\t%s\t%s\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), GetLocation(fx, fy, fz));
			found = true;
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_GOTOVEH, DIALOG_STYLE_TABLIST_HEADERS, "Goto Vehicles", msg2, "Goto", "Close");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Player ini tidak memeliki kendaraan", "Close", "");
			
	return 1;
}

CMD:getpv(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new otherid;
	if(sscanf(params, "u", otherid)) return SendSyntaxMessage(playerid, "/getpv [name/playerid]");
	if(otherid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Invalid playerid");
	
	new bool:found = false, msg2[512], Float:fx, Float:fy, Float:fz;
	format(msg2, sizeof(msg2), "ID\tModel\tLocation\n");
	foreach(new i : PlayerVehicles)
	{
		if(VehicleData[i][cOwner] == PlayerData[otherid][pID])
		{
			GetVehiclePos(VehicleData[i][cVeh], fx, fy, fz);
			format(msg2, sizeof(msg2), "%s%d\t%s\t%s\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), GetLocation(fx, fy, fz));
			found = true;
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_GETVEH, DIALOG_STYLE_TABLIST_HEADERS, "Get Vehicles", msg2, "Get", "Close");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Player ini tidak memeliki kendaraan", "Close", "");
			
	return 1;
}*/

	CMD:pvlist(playerid, params[])
	{
		if(PlayerData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

		new count = 0, created = 0;
		foreach(new i : PlayerVehicles)
		{
			count++;
			if(IsValidVehicle(VehicleData[i][cVeh]))
			{
				created++;
			}
		}
		SendInfoMessage(playerid, "Foreach total: %d, Created: %d", count, created);
		return 1;
	}

	CMD:ainsu(playerid, params[])
	{
		if(PlayerData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

		new otherid;
		if(sscanf(params, "u", otherid)) return SendSyntaxMessage(playerid, "/ainsu [name/playerid]");
		if(otherid == INVALID_PLAYER_ID || !IsPlayerConnected(otherid)) return SendErrorMessage(playerid, "Invalid playerid");

		new bool:found = false, msg2[512];
		format(msg2, sizeof(msg2), "ID\tInsurance\tClaim Time\tTicket\n");
		foreach(new i : PlayerVehicles)
		{
			if(VehicleData[i][cOwner] == PlayerData[otherid][pID])
			{
				if(VehicleData[i][cClaimTime] != 0)
				{
					format(msg2, sizeof(msg2), "%s\t%d\t%s - %d\t%s\t%s\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cVeh], VehicleData[i][cInsu], ReturnTimelapse(gettime(), VehicleData[i][cClaimTime]), FormatMoney(VehicleData[i][cTicket]));
					found = true;
				}
				else
				{
					format(msg2, sizeof(msg2), "%s\t%d\t%s - %d\tClaimed\t%s\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cVeh], VehicleData[i][cInsu], FormatMoney(VehicleData[i][cTicket]));
					found = true;
				}
			}
		}
		if(found)
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Insurance Vehicles", msg2, "Close", "");
		else
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Player tidak memeliki kendaraan", "Close", "");
		return 1;
	}

	CMD:apv(playerid, params[])
	{
		if(PlayerData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

		new otherid;
		if(sscanf(params, "u", otherid)) return SendSyntaxMessage(playerid, "/apv [name/playerid]");
		if(otherid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Invalid playerid");

		new bool:found = false, msg2[512];
		format(msg2, sizeof(msg2), "ID\tModel\tPlate Time\tRental\n");
		foreach(new i : PlayerVehicles)
		{
			if(IsValidVehicle(VehicleData[i][cVeh]))
			{
				if(VehicleData[i][cOwner] == PlayerData[otherid][pID])
				{
					if(strcmp(VehicleData[i][cPlate], "NoHave"))
					{
						if(VehicleData[i][cRent] != 0)
						{
							format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(%s)\t%s\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cVeh], VehicleData[i][cPlate], ReturnTimelapse(gettime(), VehicleData[i][cPlateTime]), ReturnTimelapse(gettime(), VehicleData[i][cRent]));
							found = true;
						}
						else
						{
							format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(%s)\tOwned\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cVeh], VehicleData[i][cPlate], ReturnTimelapse(gettime(), VehicleData[i][cPlateTime]));
							found = true;
						}
					}
					else
					{
						if(VehicleData[i][cRent] != 0)
						{
							format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(None)\t%s\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cVeh], VehicleData[i][cPlate], ReturnTimelapse(gettime(), VehicleData[i][cRent]));
							found = true;
						}
						else
						{
							format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(None)\tOwned\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cVeh], VehicleData[i][cPlate]);
							found = true;
						}
					}
				}
			}
		}
		if(found)
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Player Vehicles", msg2, "Close", "");
		else
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Player ini tidak memeliki kendaraan", "Close", "");
		
	/*new bool:found = false, msg2[512], Float:fx, Float:fy, Float:fz;
	format(msg2, sizeof(msg2), "ID\tModel\tPlate\tPlate Time\n");
	foreach(new i : PlayerVehicles)
	{
		if(VehicleData[i][cOwner] == PlayerData[otherid][pID])
		{
			if(strcmp(VehicleData[i][cPlate], "NoHave"))
			{
				GetVehiclePos(VehicleData[i][cVeh], fx, fy, fz);
				format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s\t%s\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cVeh], VehicleData[i][cPlate], ReturnTimelapse(gettime(), VehicleData[i][cPlateTime]));
				found = true;
			}
			else
			{
				GetVehiclePos(VehicleData[i][cVeh], fx, fy, fz);
				format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s\tNone\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cVeh], VehicleData[i][cPlate]);
				found = true;
			}
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Vehicles Plate", msg2, "Close", "");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles Plate", "Anda tidak memeliki kendaraan", "Close", "");*/
		return 1;
}

CMD:aveh(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new vehicleid = GetNearestVehicleToPlayer(playerid, 5.0, false);

	if(vehicleid == INVALID_VEHICLE_ID)
		return SendErrorMessage(playerid, "Kamu tidak berada didekat Kendaraan apapun.");
	
	SendServerMessage(playerid, "Vehicle ID near on you id: %d (Model: %s(%d))", vehicleid, GetVehicleName(vehicleid), GetVehicleModel(vehicleid));
	return 1;
}

CMD:sendveh(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
	
	new otherid, vehid, Float:x, Float:y, Float:z;
	if(sscanf(params, "ud", otherid, vehid)) return SendSyntaxMessage(playerid, "/sendveh [playerid/name] [vehid] | /apv - for find vehid");
	
	if(!IsPlayerConnected(otherid)) return SendErrorMessage(playerid, "Player id not online!");
	if(!IsValidVehicle(vehid)) return SendErrorMessage(playerid, "Invalid veh id");
	
	GetPlayerPos(otherid, x, y, z);
	SetVehiclePos(vehid, x, y, z+0.5);
	SetVehicleVirtualWorld(vehid, GetPlayerVirtualWorld(otherid));
	LinkVehicleToInterior(vehid, GetPlayerInterior(otherid));
	SendServerMessage(playerid, "Your has send vehicle id %d to player %s(%d) | Location: %s.", vehid, PlayerData[otherid][pName], otherid, GetLocation(x, y, z));
	return 1;
}

CMD:getveh(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new vehid, Float:posisiX, Float:posisiY, Float:posisiZ;
	if(sscanf(params, "d", vehid)) return SendSyntaxMessage(playerid, "/getveh [vehid] | /apv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "Invalid id");
	if(!IsValidVehicle(vehid)) return SendErrorMessage(playerid, "Invalid veh id");
	GetPlayerPos(playerid, posisiX, posisiY, posisiZ);
	SendServerMessage(playerid, "You're get spawn vehicle to %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), vehid);
	SetVehiclePos(vehid, posisiX, posisiY, posisiZ+0.5);
	SetVehicleVirtualWorld(vehid, GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(vehid, GetPlayerInterior(playerid));
	SetPlayerPos(playerid, posisiX, posisiY, posisiZ+1.5);
	return 1;
}

CMD:gotoveh(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new vehid, Float:posisiX, Float:posisiY, Float:posisiZ;
	if(sscanf(params, "d", vehid)) return SendSyntaxMessage(playerid, "/gotoveh [vehid] | /apv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "Invalid id");
	if(!IsValidVehicle(vehid)) return SendErrorMessage(playerid, "Invalid id");
	
	GetVehiclePos(vehid, posisiX, posisiY, posisiZ);
	SendServerMessage(playerid, "You're teleport to %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), vehid);
	SetPlayerPosition(playerid, posisiX, posisiY, posisiZ+3.0, 4.0, GetVehicleInterior(vehid));
	SetPlayerVirtualWorld(playerid, GetVehicleVirtualWorld(vehid));
	return 1;
}

CMD:respawnveh(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new vehid, Float:posisiX, Float:posisiY, Float:posisiZ;
	if(sscanf(params, "d", vehid)) return SendSyntaxMessage(playerid, "/respawnveh [vehid] | /apv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "Invalid id");
	if(!IsValidVehicle(vehid)) return SendErrorMessage(playerid, "Invalid id");
	GetVehiclePos(vehid, posisiX, posisiY, posisiZ);
	if(IsVehicleEmpty(vehid))
	{
		SetTimerEx("RespawnPV", 3000, false, "d", vehid);
		SendServerMessage(playerid, "Your respawned vehicle location %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), vehid);
	}
	else SendErrorMessage(playerid, "This Vehicle in used by someone.");
	return 1;
}

CMD:mypv(playerid, params[])
{
	return callcmd::v(playerid, "my");
}

CMD:myinsu(playerid, params[])
{
	return callcmd::v(playerid, "insu");
}

CMD:engine(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{	
		if(!IsEngineVehicle(vehicleid))
			return SendErrorMessage(playerid, "Kamu tidak berada didalam kendaraan.");
		
		if(GetEngineStatus(vehicleid))
		{
			EngineStatus(playerid, vehicleid);
		}
		else
		{
			//Info(playerid, "Anda mencoba menyalakan mesin kendaraan..");
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mencoba menghidupkan mesin kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)));
			InfoTD_MSG(playerid, 4000, "Starting Engine...");
			SetTimerEx("EngineStatus", 3000, false, "id", playerid, vehicleid);
		}
	}
	else 
		SendErrorMessage(playerid, "Anda harus mengendarai kendaraan!");
	return 1;
}

CMD:lights(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{	
		if(!IsEngineVehicle(vehicleid))
			return SendErrorMessage(playerid, "Kamu tidak berada didalam kendaraan.");
		
		switch(GetLightStatus(vehicleid))
		{
			case false:
			{
				SwitchVehicleLight(vehicleid, true);
			}
			case true:
			{
				SwitchVehicleLight(vehicleid, false);
			}
		}
	}
	else 
		SendErrorMessage(playerid, "Anda harus mengendarai kendaraan!");

	return 1;
}

CMD:window(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{	
		if(GetVehicleDoorAmount(vehicleid) < 1)
			return SendErrorMessage(playerid, "Kamu tidak berada didalam kendaraan berkaca.");
		
		new fanstr[500];
		format(fanstr, sizeof(fanstr), "Part\tStatus\n");
		forex(fan, GetVehicleDoorAmount(vehicleid))
		{
			format(fanstr, sizeof(fanstr), "%s%s\t%s\n", fanstr, WindowName[fan], (GetVehicleWindowState(vehicleid, fan+1)) ? ("{ff0000}Closed{ffffff}") : ("{00ff00}Opened{ffffff}"));
		}

		ShowPlayerDialog(playerid, DIALOG_VEHICLE_WINDOW, DIALOG_STYLE_TABLIST_HEADERS, sprintf("%s's Window(s)", GetVehicleName(vehicleid)), fanstr, "Toggle", "Close");
	}
	else 
		SendErrorMessage(playerid, "Anda harus mengendarai kendaraan!");

	return 1;
}

CMD:hood(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Kamu harus keluar dari kendaraan.");

    new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
    if(vehicleid == INVALID_VEHICLE_ID)
    	return SendErrorMessage(playerid, "Kamu tidak berada didekat Kendaraan apapun.");

	if(IsAMotor(vehicleid)) 
		return SendErrorMessage(playerid, "Kendaraan ini tidak memiliki kap mesin.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    switch (GetHoodStatus(vehicleid))
    {
    	case false:
    	{
    		SwitchVehicleBonnet(vehicleid, true);
    		InfoTD_MSG(playerid, 4000, "Vehicle Hood ~g~Dibuka");
    	}
    	case true:
    	{
    		SwitchVehicleBonnet(vehicleid, false);
    		InfoTD_MSG(playerid, 4000, "Vehicle Hood ~r~Ditutup");
    	}
    }
    return 1;
}

CMD:trunk(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Kamu harus keluar dari kendaraan.");

    new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
	if(vehicleid == INVALID_VEHICLE_ID)
		return SendErrorMessage(playerid, "Kamu tidak berada didekat Kendaraan apapun.");

	switch (GetTrunkStatus(vehicleid))
	{
		case false:
		{
			SwitchVehicleBoot(vehicleid, true);
			SendInfoMessage(playerid, "Vehicle trunk "GREEN_E"dibuka.");
		}
		case true:
		{
			SwitchVehicleBoot(vehicleid, false);
			SendInfoMessage(playerid, "Vehicle trunk "RED_E"ditutup.");
		}
	}
	return 1;
}

CMD:lock(playerid, params[])
{
	new bool:found = false, carid;
	if(IsPlayerInAnyVehicle(playerid))
	{
		if((carid = Vehicle_GetID(GetPlayerVehicleID(playerid))) != -1)
		{
			if(Vehicle_IsOwner(playerid, carid))
			{
				PlayerPlaySound(playerid, 1145);
				VehicleData[carid][cLocked] = !(VehicleData[carid][cLocked]);
				PlayerPlaySound(playerid, SOUND_LOCK_CAR_DOOR);
				SwitchVehicleDoors(VehicleData[carid][cVeh], bool:VehicleData[carid][cLocked]);

				if(VehicleData[carid][cLocked])
				{
					SwitchVehicleDoors(VehicleData[carid][cVeh], true);
					GameTextForPlayer(playerid, sprintf("~w~%s ~r~Locked", GetVehicleName(VehicleData[carid][cVeh])), 3000, 3);
				}
				else if(!VehicleData[carid][cLocked])
				{
					SwitchVehicleDoors(VehicleData[carid][cVeh], false);
					GameTextForPlayer(playerid, sprintf("~w~%s ~g~Unlocked", GetVehicleName(VehicleData[carid][cVeh])), 3000, 3);
				}
			}
			else
				return SendErrorMessage(playerid, "Kamu bukan pemilik kendaraan ini!");
		}
	}
	else
	{
		new str[512];
		format(str, sizeof(str), "#\tModel\tStatus\n");
		foreach(new i : PlayerVehicles) if(IsValidVehicle(VehicleData[i][cVeh]) && Vehicle_IsOwner(playerid, i))
			found = true, strcat(str, sprintf("%d\t%s\t%s\n", VehicleData[i][cVeh], GetVehicleName(VehicleData[i][cVeh]), (VehicleData[i][cLocked]) ? ("{ff0000}Locked{ffffff}") : ("{00ff00}Unlocked{ffffff}")));
		
		if(found)
			ShowPlayerDialog(playerid, DIALOG_VEHICLE_LOCK, DIALOG_STYLE_TABLIST_HEADERS, sprintf("%s's Vehicle(s)", PlayerData[playerid][pName]), str, "Pilih", "Keluar");
		else
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, sprintf("%s's Vehicle(s)", PlayerData[playerid][pName]), "Tidak ada kendaraan!", "Keluar", "");
	}
	return 1;
}

CMD:v(playerid, params[])
{
	static
	type[20],
	string[225],
	vehicleid;

	if(sscanf(params, "s[20]S()[128]", type, string))
	{
		SendClientMessage(playerid,COLOR_BLUE,"|__________________ Vehicle Command __________________|");
		SendClientMessage(playerid,COLOR_WHITE,"VEHICLE: /v [my] [insu] [neon] [park] [storage]");
		SendClientMessage(playerid,COLOR_WHITE,"VEHICLE: /v [acc(esories)/toys]");
		return 1;
	}
	
    if(!strcmp(type,"park",true))
    {
    	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Kamu harus memprivasikan kendaraan ini");

    	new carid,
    	vehid = GetPlayerVehicleID(playerid);

    	if((carid = Vehicle_Nearest(playerid)) != -1)
    	{
    		if(Vehicle_IsOwner(playerid, carid))
    		{
    			Vehicle_GetStatus(carid);
    			if(IsValidVehicle(vehid))
    				DestroyVehicle(vehid);
				/*GetVehiclePos(vehid, VehicleData[carid][cPosX], VehicleData[carid][cPosY], VehicleData[carid][cPosZ]);
				GetVehicleZAngle(vehid, VehicleData[carid][cPosA]);
				VehicleData[carid][cVw] = GetPlayerVirtualWorld(playerid);
				VehicleData[carid][cInt] = GetPlayerInterior(playerid);*/
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
				OnPlayerVehicleRespawn(carid);
				InfoTD_MSG(playerid, 4000, "Kamu telah ~g~Memparkirkan~w~ Kendaraan ini!");
				SetPlayerArmedWeapon(playerid, WEAPON_FIST);
				PutPlayerInVehicle(playerid, vehid, 0);
			}
		}
		else SendErrorMessage(playerid, "Kamu tidak berada dikendaraan anda sendiri.");
	}
	else if(!strcmp(type,"my",true))
	{
		new bool:found = false, msg2[512], count;
		format(msg2, sizeof(msg2), "ID\tModel\tPlate Time\tStatus\n");
		foreach(new i : PlayerVehicles)
		{
			if(VehicleData[i][cOwner] == PlayerData[playerid][pID])
			{
				found = true;
				PlayerData[playerid][pValueListitem][count] = i;
				count++;
				if(strcmp(VehicleData[i][cPlate], "NoHave"))
				{
					if(VehicleData[i][cRent] != 0)
					{
						format(msg2, sizeof(msg2), "%s%d\t%s\t%s(%s)\tRental(%s)\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cPlate], ReturnTimelapse(gettime(), VehicleData[i][cPlateTime]), ReturnTimelapse(gettime(), VehicleData[i][cRent]));
					}
					else
					{
						if(VehicleData[i][cPark] != -1)
						{
							format(msg2, sizeof(msg2), "%sN/A\t%s\t%s(%s)\tOwned{00ff00}(Parked in: %d){ffffff}\n", msg2, GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cPlate], ReturnTimelapse(gettime(), VehicleData[i][cPlateTime]), VehicleData[i][cPark]);
						}
						else if(VehicleData[i][cClaim] == 1)
						{
							format(msg2, sizeof(msg2), "%sN/A\t%s\t%s(%s)\tOwned{ff0000}(In Insurance){ffffff}\n", msg2, GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cPlate], ReturnTimelapse(gettime(), VehicleData[i][cPlateTime]));
						}
						else
							format(msg2, sizeof(msg2), "%s%d\t%s\t%s(%s)\tOwned{15D4ED}(Spawned){ffffff}\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cPlate], ReturnTimelapse(gettime(), VehicleData[i][cPlateTime]));
					}
				}
				else
				{
					if(VehicleData[i][cRent] != 0)
					{
						format(msg2, sizeof(msg2), "%s%d\t%s\t%s(None)\tRental(%s)\\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cPlate], ReturnTimelapse(gettime(), VehicleData[i][cRent]));
					}
					else
					{
						if(VehicleData[i][cPark] != -1)
						{
							format(msg2, sizeof(msg2), "%sN/A\t%s\t%s(None)\tOwned{00ff00}(Parked in: %d){ffffff}\n", msg2, GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cPlate], VehicleData[i][cPark]);
						}
						else if(VehicleData[i][cClaim] == 1)
						{
							format(msg2, sizeof(msg2), "%sN/A\t%s\t%s(None)\tOwned{ff0000}(In Insurance){ffffff}\n", msg2, GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cPlate]);
						}
						else
							format(msg2, sizeof(msg2), "%s%d\t%s\t%s(None)\tOwned{15D4ED}(Spawned){ffffff}\n", msg2, VehicleData[i][cVeh], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cPlate]);
					}
				}
			}
		}
		if(found)
			ShowPlayerDialog(playerid, DIALOG_FINDVEH, DIALOG_STYLE_TABLIST_HEADERS, "My Vehicles", msg2, "Track", "Close");
		else
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Anda tidak memeliki kendaraan", "Close", "");
	}
	else if(!strcmp(type,"insu",true))
	{
		new bool:found = false, msg2[512];
		format(msg2, sizeof(msg2), "ID\tInsurance\tClaim Time\tTicket\n");
		foreach(new i : PlayerVehicles)
		{
			if(VehicleData[i][cOwner] == PlayerData[playerid][pID])
			{
				if(VehicleData[i][cClaim])
				{
					if(VehicleData[i][cClaimTime] != 0)
					{
						format(msg2, sizeof(msg2), "%s%d\t%s - %d\t{00ff00}%d/3{ffffff} | {ff0000}%s{ffffff}\t%s\n", msg2, VehicleData[i][cID], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cVeh], VehicleData[i][cInsu], ReturnTimelapse(gettime(), VehicleData[i][cClaimTime]), FormatMoney(VehicleData[i][cTicket]));
					}
					else
					{
						format(msg2, sizeof(msg2), "%s%d\t%s - %d\t{00ff00}%d/3 {ffffff}|{00ff00} Ready to Claim{ffffff}\t%s\n", msg2, VehicleData[i][cID], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cVeh], VehicleData[i][cInsu], FormatMoney(VehicleData[i][cTicket]));
					}
					found = true;
				}
				else if(VehicleData[i][cTicket] > 0)
				{
					found = true;
					format(msg2, sizeof(msg2), "%s%d\t%s - %d\t{ffff00}Claimed{ffffff}\t%s\n", msg2, VehicleData[i][cID], GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cVeh], VehicleData[i][cInsu], FormatMoney(VehicleData[i][cTicket]));
				}
			}
		}
		if(found)
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "My Vehicles", msg2, "Close", "");
		else
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Tidak ada kendaraanmu yang masuk ke sini!", "Close", "");
	}
	else if(!strcmp(type,"neon",true))
	{
		vehicleid = GetPlayerVehicleID(playerid);
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(!IsEngineVehicle(vehicleid))
				return SendErrorMessage(playerid, "Kamu tidak berada didalam kendaraan.");
			
			new carid;
			if((carid = Vehicle_Nearest(playerid)) != -1)
			{
				if(Vehicle_IsOwner(playerid, carid))
				{
					if(VehicleData[carid][cTogNeon] == 0)
					{
						if(VehicleData[carid][cNeon] != 0)
						{
							SetVehicleNeonLights(VehicleData[carid][cVeh], true, VehicleData[carid][cNeon], 0);
							InfoTD_MSG(playerid, 4000, "Neon ~g~ON");
							VehicleData[carid][cTogNeon] = 1;
						}
						else
						{
							SetVehicleNeonLights(VehicleData[carid][cVeh], false, VehicleData[carid][cNeon], 0);
							VehicleData[carid][cTogNeon] = 0;
						}
					}
					else
					{
						SetVehicleNeonLights(VehicleData[carid][cVeh], false, VehicleData[carid][cNeon], 0);
						InfoTD_MSG(playerid, 4000, "Neon ~r~OFF");
						VehicleData[carid][cTogNeon] = 0;
					}
				}
			}
		}
		else return SendErrorMessage(playerid, "Anda harus mengendarai kendaraan!");
	}
	else if(!strcmp(type,"storage",true))
	{
		callcmd::vstorage(playerid);
	}
	else if(!strcmp(type,"acc",true))
	{
		callcmd::vacc(playerid, "");
	}
	else if(!strcmp(type,"accesories",true))
	{
		callcmd::vacc(playerid, "");
	}
	else if(!strcmp(type,"toys",true))
	{
		callcmd::vacc(playerid, "");
	}
	else
		SendErrorMessage(playerid, "Menu tersebut tidak ditemukan!");
	return 1;
}

CMD:unrentpv(playerid, params[])
{		
	new vehid;
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1750.16, -1761.53, 13.54)) return SendErrorMessage(playerid, "You must in showroom/dealer!");
	if(sscanf(params, "d", vehid)) return SendSyntaxMessage(playerid, "/unrentpv [vehid] | /mypv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "Invalid id");

	foreach(new i : PlayerVehicles)			
	{
		if(vehid == VehicleData[i][cVeh])
		{
			if(VehicleData[i][cOwner] == PlayerData[playerid][pID])
			{
				if(VehicleData[i][cRent] != 0)
				{
					SendInfoMessage(playerid, "You has unrental the vehicle id %d (database id: %d).", vehid, VehicleData[i][cID]);
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", VehicleData[i][cID]);
					mysql_tquery(g_SQL, query);
					if(IsValidVehicle(VehicleData[i][cVeh])) DestroyVehicle(VehicleData[i][cVeh]);
					VehicleData[i][cVeh] = INVALID_VEHICLE_ID;
					Iter_Remove(PlayerVehicles, i);
				}
				else return SendErrorMessage(playerid, "This is not rental vehicle! use /sellpv for sell owned vehicle.");
			}
			else return SendErrorMessage(playerid, "ID kendaraan ini bukan punya mu! gunakan /v my(/mypv) untuk mencari ID.");
		}
	}
	return 1;
}

CMD:givepv(playerid, params[])
{
	new vehid, otherid;
	if(sscanf(params, "ud", otherid, vehid)) return SendSyntaxMessage(playerid, "/givepv [playerid/name] [vehid] | /v my(mypv) - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "Invalid id");

	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
		return SendErrorMessage(playerid, "The specified player is disconnected or not near you.");
	
/*if((vehid = Vehicle_Nearest(playerid)) != -1)
{
	if(Vehicle_IsOwner(playerid, vehid))
	{
		if(!VehicleData[vehid][cLocked])
		{
			VehicleData[vehid][cLocked] = 1;

			InfoTD_MSG(playerid, 4000, "You have ~r~locked~w~ the vehicle!");
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

			SwitchVehicleDoors(VehicleData[vehid][cVeh], true);
		}
	}*/
	foreach(new i : PlayerVehicles)
	{
		if(vehid == VehicleData[i][cVeh])
		{
			if(VehicleData[i][cOwner] == PlayerData[playerid][pID])
			{
				new nearid = GetNearestVehicleToPlayer(playerid, 5.0, false);
				if(vehid == nearid)
				{
					if(VehicleData[i][cRent] != 0) return SendErrorMessage(playerid, "You can't give rental vehicle!");
					SendInfoMessage(playerid, "Anda memberikan kendaraan %s(%d) anda kepada %s.", GetVehicleName(vehid), GetVehicleModel(vehid), ReturnName(otherid));
					SendInfoMessage(otherid, "%s Telah memberikan kendaraan %s(%d) kepada anda.(/mypv)", ReturnName(playerid), GetVehicleName(vehid), GetVehicleModel(vehid));
					VehicleData[i][cOwner] = PlayerData[otherid][pID];
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicle SET owner='%d' WHERE id='%d'", PlayerData[otherid][pID], VehicleData[i][cID]);
					mysql_tquery(g_SQL, query);
					return 1;
				}
				else return SendErrorMessage(playerid, "Anda harus berada di dekat kendaraan yang anda jual!");
			}
			else return SendErrorMessage(playerid, "ID kendaraan ini bukan punya mu! gunakan /v my(/mypv) untuk mencari ID.");
		}
	}
	return 1;
}

GetDistanceToCar(playerid, veh, Float: posX = 0.0, Float: posY = 0.0, Float: posZ = 0.0) 
{
	new
	Float: Floats[2][3];

	if(posX == 0.0 && posY == 0.0 && posZ == 0.0) 
	{
		if(!IsPlayerInAnyVehicle(playerid)) GetPlayerPos(playerid, Floats[0][0], Floats[0][1], Floats[0][2]);
		else GetVehiclePos(GetPlayerVehicleID(playerid), Floats[0][0], Floats[0][1], Floats[0][2]);
	}
	else 
	{
		Floats[0][0] = posX;
		Floats[0][1] = posY;
		Floats[0][2] = posZ;
	}
	GetVehiclePos(veh, Floats[1][0], Floats[1][1], Floats[1][2]);
	return floatround(floatsqroot((Floats[1][0] - Floats[0][0]) * (Floats[1][0] - Floats[0][0]) + (Floats[1][1] - Floats[0][1]) * (Floats[1][1] - Floats[0][1]) + (Floats[1][2] - Floats[0][2]) * (Floats[1][2] - Floats[0][2])));
}

GetClosestCar(playerid, exception = INVALID_VEHICLE_ID) 
{
	new
	Float: Distance,
	target = -1,
	Float: vPos[3];

	if(!IsPlayerInAnyVehicle(playerid)) GetPlayerPos(playerid, vPos[0], vPos[1], vPos[2]);
	else GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);

	for(new v; v < MAX_VEHICLES; v++) if(GetVehicleModel(v) >= 400) 
	{
		if(v != exception && (target < 0 || Distance > GetDistanceToCar(playerid, v, vPos[0], vPos[1], vPos[2]))) 
		{
			target = v;
            Distance = GetDistanceToCar(playerid, v, vPos[0], vPos[1], vPos[2]); // Before the rewrite, we'd be running GetPlayerPos 2000 times...
        }
    }
    return target;
}

CMD:tow(playerid, params[]) 
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new carid = GetPlayerVehicleID(playerid);
		if(IsATowTruck(carid))
		{
			new closestcar = GetClosestCar(playerid, carid);

			if(GetDistanceToCar(playerid, closestcar) <= 8 && !IsTrailerAttachedToVehicle(carid)) 
			{
				/*for(new x;x<sizeof(SAGSVehicles);x++)
				{
					if(SAGSVehicles[x] == closestcar) return SendErrorMessage(playerid, "You cant tow faction vehicle.");
					SendInfoMessage(playerid, "You has towed the vehicle in trailer.");
					AttachTrailerToVehicle(closestcar, carid);
					return 1;
				}
				for(new xx;xx<sizeof(SAPDVehicles);xx++)
				{
					if(SAPDVehicles[xx] == closestcar) return SendErrorMessage(playerid, "You cant tow faction vehicle.");
					SendInfoMessage(playerid, "You has towed the vehicle in trailer.");
					AttachTrailerToVehicle(closestcar, carid);
					return 1;
				}
				for(new y;y<sizeof(SAMDVehicles);y++)
				{
					if(SAMDVehicles[y] == closestcar) return SendErrorMessage(playerid, "You cant tow faction vehicle.");
					SendInfoMessage(playerid, "You has towed the vehicle in trailer.");
					AttachTrailerToVehicle(closestcar, carid);
					return 1;
				}
				for(new yy;yy<sizeof(SANAVehicles);yy++)
				{
					if(SANAVehicles[yy] == closestcar) return SendErrorMessage(playerid, "You cant tow faction vehicle.");
					SendInfoMessage(playerid, "You has towed the vehicle in trailer.");
					AttachTrailerToVehicle(closestcar, carid);
					return 1;
				}*/
				SendInfoMessage(playerid, "You has towed the vehicle in trailer.");
				AttachTrailerToVehicle(closestcar, carid);
				return 1;
			}
		}
		else
		{
			SendErrorMessage(playerid, "Anda harus mengendarai Tow truck.");
			return 1;
		}
	}
	else
	{
		SendErrorMessage(playerid, "Anda harus mengendarai Tow truck.");
		return 1;
	}
	return 1;
}

CMD:untow(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
		{
			SendInfoMessage(playerid, "You has untowed the vehicle trailer.");
			DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
		}
		else
		{
			SendErrorMessage(playerid, "Tow penderek kosong!");
		}
	}
	else
	{
		SendErrorMessage(playerid, "Anda harus mengendarai Tow truck.");
		return 1;
	}
	return 1;
}