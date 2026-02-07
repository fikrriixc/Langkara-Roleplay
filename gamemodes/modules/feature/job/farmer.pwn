//kentang 760
//gandum 804
//jeruk 949
//ganja 19473
//-383.67, -1438.90, 26.32
//Drug -3811.65, 1313.72, 71.42

CreateJoinFarmerPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, -383.67, -1438.90, 26.32, -1, -1, -1, 5.0);
	format(strings, sizeof(strings), "[FARMER JOBS]\n{ffffff}Jadilah Pekerja Petani disini\n{7fffd4}/getjob /accept job");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -383.67, -1438.90, 26.32, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
}

#define MAX_PLANT 1000

enum E_PLANT
{
	// loaded from db
	PlantType,
	PlantTime,
	Float:PlantX,
	Float:PlantY,
	Float:PlantZ,
	//temp
	bool:PlantHarvest,
	PlantTimer,
	PlantObjID,
	PlantCP,
	Text3D:PlantLabel
}

new PlantData[MAX_PLANT][E_PLANT],
	Iterator:Plants<MAX_PLANT>;
	
GetClosestPlant(playerid, Float: range = 2.0)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : Plants)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, PlantData[i][PlantX], PlantData[i][PlantY], PlantData[i][PlantZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}
	return id;
}

GetNearPlant(playerid, Float: range = 3.5)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : Plants)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, PlantData[i][PlantX], PlantData[i][PlantY], PlantData[i][PlantZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}
	return id;
}

Plant_Refresh(id)
{
	if(id != -1)
    {
		if(IsValidDynamicObject(PlantData[id][PlantObjID]))
			DestroyDynamicObject(PlantData[id][PlantObjID]);
		
		if(IsValidDynamicCP(PlantData[id][PlantCP]))
			DestroyDynamicCP(PlantData[id][PlantCP]);
		
		if(PlantData[id][PlantType] == 1)
		{
			if(PlantData[id][PlantTime] > 2400)
			{
				PlantData[id][PlantObjID] = CreateDynamicObject(760, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-1.5, 0.0, 0.0, 0.0, -1, -1, -1, 8.0, 8.0, -1, 0);
				PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
			}
			else if(PlantData[id][PlantTime] < 2400 && PlantData[id][PlantTime] > 10)
			{
				PlantData[id][PlantObjID] = CreateDynamicObject(760, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-1.3, 0.0, 0.0, 0.0, -1, -1, -1, 8.0, 8.0, -1, 0);
				PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
			}
			else
			{
				PlantData[id][PlantObjID] = CreateDynamicObject(760, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-1.0, 0.0, 0.0, 0.0, -1, -1, -1, 8.0, 8.0, -1, 0);
				PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
			}
		}
		else if(PlantData[id][PlantType] == 2)
		{
			if(PlantData[id][PlantTime] > 2400)
			{
				PlantData[id][PlantObjID] = CreateDynamicObject(804, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-1.0, 0.0, 0.0, 0.0, -1, -1, -1, 8.0, 8.0, -1, 0);
				PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
			}
			else if(PlantData[id][PlantTime] < 2400 && PlantData[id][PlantTime] > 10)
			{
				PlantData[id][PlantObjID] = CreateDynamicObject(804, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-0.5, 0.0, 0.0, 0.0, -1, -1, -1, 8.0, 8.0, -1, 0);
				PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
			}
			else
			{
				PlantData[id][PlantObjID] = CreateDynamicObject(804, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 0.0, 0.0, 0.0, -1, -1, -1, 8.0, 8.0, -1, 0);
				PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
			}
		}
		else if(PlantData[id][PlantType] == 3)
		{
			if(PlantData[id][PlantTime] > 2400)
			{
				PlantData[id][PlantObjID] = CreateDynamicObject(949, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-1.0, 0.0, 0.0, 0.0, -1, -1, -1, 8.0, 8.0, -1, 0);
				PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
			}
			else if(PlantData[id][PlantTime] < 2400 && PlantData[id][PlantTime] > 10)
			{
				PlantData[id][PlantObjID] = CreateDynamicObject(949, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-0.7, 0.0, 0.0, 0.0, -1, -1, -1, 8.0, 8.0, -1, 0);
				PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
			}
			else
			{
				PlantData[id][PlantObjID] = CreateDynamicObject(949, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-0.4, 0.0, 0.0, 0.0, -1, -1, -1, 8.0, 8.0, -1, 0);
				PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
			}
		}
		else if(PlantData[id][PlantType] == 4)
		{
			if(PlantData[id][PlantTime] > 2400)
			{
				PlantData[id][PlantObjID] = CreateDynamicObject(19473, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-2.0, 0.0, 0.0, 0.0, -1, -1, -1, 8.0, 8.0, -1, 0);
				PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
			}
			else if(PlantData[id][PlantTime] < 2400 && PlantData[id][PlantTime] > 10)
			{
				PlantData[id][PlantObjID] = CreateDynamicObject(19473, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-1.5, 0.0, 0.0, 0.0, -1, -1, -1, 8.0, 8.0, -1, 0);
				PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
			}
			else
			{
				PlantData[id][PlantObjID] = CreateDynamicObject(19473, PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ]-1.0, 0.0, 0.0, 0.0, -1, -1, -1, 8.0, 8.0, -1, 0);
				PlantData[id][PlantCP] = CreateDynamicCP(PlantData[id][PlantX], PlantData[id][PlantY], PlantData[id][PlantZ], 2.0, 0, 0, -1, 2.0);
			}
		}
	}
}

public:PlantGrowup(id)
{
	if(id != -1)
	{
		if(PlantData[id][PlantTime] > 0)
		{
			PlantData[id][PlantTime]--;
		}
		if(PlantData[id][PlantTime] < 2300 && PlantData[id][PlantTime] > 2298)
		{
			Plant_Refresh(id);
		}
		if(PlantData[id][PlantTime] < 5 && PlantData[id][PlantTime] > 1)
		{
			Plant_Refresh(id);
		}
	}
	return 1;
}

public:LoadPlants()
{
    new id;
	
	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", id);
			cache_get_value_name_int(i, "type", PlantData[id][PlantType]);
			cache_get_value_name_int(i, "time", PlantData[id][PlantTime]);
			cache_get_value_name_float(i, "posx", PlantData[id][PlantX]);
			cache_get_value_name_float(i, "posy", PlantData[id][PlantY]);
			cache_get_value_name_float(i, "posz", PlantData[id][PlantZ]);
			Iter_Add(Plants, id);
			
			PlantData[id][PlantHarvest] = false;
			Plant_Refresh(id);
			PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
		}
		printf("[Farmer Plant] Number of Loaded: %d.", rows);
	}
}

Plant_Save(id)
{
	new cQuery[512];
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE plants SET type='%d', time='%d', posx='%f', posy='%f', posz='%f' WHERE id='%d'",
	PlantData[id][PlantType],
	PlantData[id][PlantTime],
	PlantData[id][PlantX],
	PlantData[id][PlantY],
	PlantData[id][PlantZ],
	id
	);
	return mysql_tquery(g_SQL, cQuery);
}

public:OnPlantCreated(playerid, id)
{
	Plant_Refresh(id);
	Plant_Save(id);
	return 1;
}

public:HarvestPlant(playerid)
{
	if(PlayerData[playerid][pHarvestID] != -1)
	{
		new id = PlayerData[playerid][pHarvestID];
		new kg = RandomEx(1, 10);
		
		if(PlayerData[playerid][pActivityTime] >= 100)
		{
			if(PlantData[id][PlantType] == 1)
			{
				Inventory_Add(playerid, "Potato", kg);
				SendInfoMessage(playerid, "Anda mendapatkan hasil panen potato/kentang seberat "GREEN_E"%d kg.", kg);
			}
			else if(PlantData[id][PlantType] == 2)
			{
				Inventory_Add(playerid, "Wheat", kg);
				SendInfoMessage(playerid, "Anda mendapatkan hasil panen wheat/gandum seberat "GREEN_E"%d kg.", kg);
			}
			else if(PlantData[id][PlantType] == 3)
			{
				Inventory_Add(playerid, "Orange", kg);
				SendInfoMessage(playerid, "Anda mendapatkan hasil panen orange/jeruk seberat "GREEN_E"%d kg.", kg);
			}
			else if(PlantData[id][PlantType] == 4)
			{
				if(Inventory_Add(playerid, "Marijuana", kg) == -1)
					return 1;
				
				SendInfoMessage(playerid, "Anda mendapatkan hasil panen marijuana/ganja seberat "GREEN_E"%d kg.", kg);
			}
			
			InfoTD_MSG(playerid, 8000, "Harvesting done!");
			KillTimer(PlayerData[playerid][pHarvest]);
			PlayerData[playerid][pActivityTime] = 0;
			PlayerData[playerid][pHarvestID] = -1;
			HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			PlayerData[playerid][pEnergy] -= 1;
			ClearAnimations(playerid);
			StopLoopingAnim(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			
			new query[128];
			PlantData[id][PlantType] = 0;
			PlantData[id][PlantTime] = 0;
			PlantData[id][PlantX] = 0.0;
			PlantData[id][PlantY] = 0.0;
			PlantData[id][PlantZ] = 0.0;
			PlantData[id][PlantHarvest] = false;
			KillTimer(PlantData[id][PlantTimer]);
			PlantData[id][PlantTimer] = -1;
			DestroyDynamicObject(PlantData[id][PlantObjID]);
			DestroyDynamicCP(PlantData[id][PlantCP]);
			DestroyDynamic3DTextLabel(PlantData[id][PlantLabel]);
			mysql_format(g_SQL, query, sizeof(query), "DELETE FROM plants WHERE id='%d'", id);
			mysql_query(g_SQL, query);
			Iter_Remove(Plants, id);
			return 1;
		}
		else if(PlayerData[playerid][pActivityTime] < 100)
		{
			PlayerData[playerid][pActivityTime] += 10;
			SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, false, 0, SYNC_ALL);
		}
	}
	return 1;
}

Player_ResetHarvest(playerid)
{
	if(!IsPlayerConnected(playerid) || PlayerData[playerid][pHarvestID] == -1) return 0;
	
	new id = PlayerData[playerid][pHarvestID];
	PlantData[id][PlantHarvest] = false;
	return 1;
}

//------------[ Farmer Commands ]------------

CMD:plant(playerid, params[])
{
	if(isnull(params)) return SendSyntaxMessage(playerid, "/plant [plant/harvest/destroy/sell]");
	
	if(!strcmp(params, "plant", true))
	{
		if(PlayerData[playerid][pJob] == 7 || PlayerData[playerid][pJob2] == 7)
		{
			if(GetPlayerInterior(playerid) > 0) return SendErrorMessage(playerid, "You cant plant at here!");
			if(GetPlayerVirtualWorld(playerid) > 0) return SendErrorMessage(playerid, "You cant plant at here!");
			
			new mstr[512], tstr[64];
			format(tstr, sizeof(tstr), ""WHITE_E"My Seed: "GREEN_E"%d", Inventory_Has(playerid, "Seeds"));
			format(mstr, sizeof(mstr), "Plant\tSeed\n\
			"WHITE_E"Potato\t"GREEN_E"5 Seed\n\
			"WHITE_E"Wheat\t"GREEN_E"18 Seed\n\
			"WHITE_E"Orange\t"GREEN_E"11 Seed\n");

			if(PlayerData[playerid][pFamily] != -1 || PlayerData[playerid][pAdmin] > 3)
				strcat(mstr, ""RED_E"[ILLEGAL]Marijuana\t"GREEN_E"50 Seed");

			ShowPlayerDialog(playerid, DIALOG_PLANT, DIALOG_STYLE_TABLIST_HEADERS, tstr, mstr, "Plant", "Close");
		}
		else return SendErrorMessage(playerid, "You are not farmer!");
	}
	else if(!strcmp(params, "harvest", true))
	{
		if(PlayerData[playerid][pJob] == 7 || PlayerData[playerid][pJob2] == 7)
		{
			new id = GetClosestPlant(playerid);
			if(id == -1) return SendErrorMessage(playerid, "You must closes on the plant!");
			if(PlantData[id][PlantTime] > 1) return SendErrorMessage(playerid, "This plant is not ready!");
			if(PlantData[id][PlantHarvest] == true) return SendErrorMessage(playerid, "This plant already harvesting by someone!");
			if(GetPlayerWeapon(playerid) != WEAPON_KNIFE) return SendErrorMessage(playerid, "You need holding a knife(pisau)!");
			
			PlayerData[playerid][pHarvestID] = id;
			PlayerData[playerid][pHarvest] = SetTimerEx("HarvestPlant", 1000, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Harvesting...");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			SetPlayerArmedWeapon(playerid, WEAPON_KNIFE);
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, false, 0, SYNC_ALL);

			PlantData[id][PlantHarvest] = true;
		}
		else return SendErrorMessage(playerid, "You are not farmer!");
	}
	else if(!strcmp(params, "destroy", true))
	{
		if(PlayerData[playerid][pFaction] == 1 || PlayerData[playerid][pFaction] == 2)
		{
			new id = GetClosestPlant(playerid);
			if(id == -1) return SendErrorMessage(playerid, "You must closes on the plant!");
			if(PlantData[id][PlantHarvest] == true) return SendErrorMessage(playerid, "This plant already harvesting by someone!");
			
			new query[128];
			PlantData[id][PlantType] = 0;
			PlantData[id][PlantTime] = 0;
			PlantData[id][PlantX] = 0.0;
			PlantData[id][PlantY] = 0.0;
			PlantData[id][PlantZ] = 0.0;
			PlantData[id][PlantHarvest] = false;
			KillTimer(PlantData[id][PlantTimer]);
			PlantData[id][PlantTimer] = -1;
			DestroyDynamicObject(PlantData[id][PlantObjID]);
			DestroyDynamicCP(PlantData[id][PlantCP]);
			DestroyDynamic3DTextLabel(PlantData[id][PlantLabel]);
			mysql_format(g_SQL, query, sizeof(query), "DELETE FROM plants WHERE id='%d'", id);
			mysql_query(g_SQL, query);
			Iter_Remove(Plants, id);
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, false, 0, SYNC_ALL);
			SendInfoMessage(playerid, "You has destroyed this plant!");
		}
		else return SendErrorMessage(playerid, "You cant destroy a plant!");
	}
	else if(!strcmp(params, "sell", true))
	{
		if(!IsPlayerInRangeOfPoint(playerid, 3.5, -381.44, -1426.13, 25.93))
			return SendErrorMessage(playerid, "You must near in food/farmer warehouse!");
			
		new potato = Inventory_Has(playerid, "Potato") * PotatoPrice,
		wheat = Inventory_Has(playerid, "Wheat") * WheatPrice,
		orange = Inventory_Has(playerid, "Orange") * OrangePrice;
		
		new total = Inventory_Has(playerid, "Potato") + Inventory_Has(playerid, "Wheat") + Inventory_Has(playerid, "Orange");
		new pay = potato + wheat + orange;
		
		if(total < 1) return SendErrorMessage(playerid, "You dont have plant!");
		GivePlayerMoneyEx(playerid, pay);
		Food += total;
		Server_MinMoney(pay);
		
		Inventory_Set(playerid, "Potato", 0);
		Inventory_Set(playerid, "Wheat", 0);
		Inventory_Set(playerid, "Orange", 0);
		SendInfoMessage(playerid, "You selling "RED_E"%d kg "WHITE_E"all plant to "GREEN_E"%s", total, FormatMoney(pay));
	}
	return 1;
}

CMD:sellmarijuana(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, 514.3713, -2329.4045, 508.6937))
		return SendErrorMessage(playerid, "You must near in black market!");
	
	if(Inventory_Has(playerid, "Marijuana") < 1) return SendErrorMessage(playerid, "You dont have marijuana!");
	new pay = Inventory_Has(playerid, "Marijuana") * MarijuanaPrice;
	GivePlayerMoneyEx(playerid, pay);
	Marijuana += Inventory_Has(playerid, "Marijuana");
	Server_MinMoney(pay);
	
	SendInfoMessage(playerid, "You selling "RED_E"%d kg "WHITE_E"marijuana to "GREEN_E"%s", Inventory_Has(playerid, "Marijuana"), FormatMoney(pay));
	Inventory_Set(playerid, "Marijuana", 0);
	return 1;
}


CMD:price(playerid, params[])
{
	if(PlayerData[playerid][pJob] == 7 || PlayerData[playerid][pJob2] == 7)
	{
		new mstr[512], tstr[64];
		format(tstr, sizeof(tstr), ""WHITE_E"My Food: "GREEN_E"%d", Inventory_Has(playerid, "Food"));
		format(mstr, sizeof(mstr), "Name\tPrice\n\
		"WHITE_E"Sprunk\t"GREEN_E"%s\n\
		"WHITE_E"Snack\t"GREEN_E"%s\n\
		"WHITE_E"Ice Cream Orange\t"GREEN_E"%s\n\
		"WHITE_E"Hotdog\t"GREEN_E"%s", FormatMoney(PlayerData[playerid][pPrice1]), FormatMoney(PlayerData[playerid][pPrice2]), FormatMoney(PlayerData[playerid][pPrice3]), FormatMoney(PlayerData[playerid][pPrice4]));
		ShowPlayerDialog(playerid, DIALOG_EDIT_PRICE, DIALOG_STYLE_TABLIST_HEADERS, tstr, mstr, "Edit", "Close");
	}
	else return SendErrorMessage(playerid, "You are not farmer job!");
	return 1;
}

CMD:offer(playerid, params[])
{
	if(PlayerData[playerid][pJob] == 7 || PlayerData[playerid][pJob2] == 7)
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "You must in Mr.Whoopee or Hotdog vehicle!");
		
		new modelid = GetVehicleModel(GetPlayerVehicleID(playerid));
		if(modelid != 423 && modelid != 588)
			return SendErrorMessage(playerid, "You must in Mr.Whoopee or Hotdog vehicle!");
		
		new otherid;
		if(sscanf(params, "u", otherid))
			return SendSyntaxMessage(playerid, "/offer [playerid/PartOfName]");
		
		if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
			return SendErrorMessage(playerid, "The specified player is disconnected or not near you.");
		
		PlayerData[otherid][pOffer] = playerid;
		new mstr[512], tstr[64];
		format(tstr, sizeof(tstr), ""WHITE_E"Food Stock: "GREEN_E"%d", Inventory_Has(playerid, "Food"));
		format(mstr, sizeof(mstr), "Name\tPrice\n\
		"WHITE_E"Sprunk\t"GREEN_E"%s\n\
		"WHITE_E"Snack\t"GREEN_E"%s\n\
		"WHITE_E"Ice Cream Orange\t"GREEN_E"%s\n\
		"WHITE_E"Hotdog\t"GREEN_E"%s", FormatMoney(PlayerData[playerid][pPrice1]), FormatMoney(PlayerData[playerid][pPrice2]), FormatMoney(PlayerData[playerid][pPrice3]), FormatMoney(PlayerData[playerid][pPrice4]));
		ShowPlayerDialog(otherid, DIALOG_OFFER, DIALOG_STYLE_TABLIST_HEADERS, tstr, mstr, "Buy", "Close");
	}
	else return SendErrorMessage(playerid, "You are not farmer job!");
	return 1;
}
