// simple gps system by Fann
// inspired by LunarPride GPS

enum e_gps_type
{
	gNone,
	gPublic,
	gPublicProp,
	gOwnProp,
	gJob
};

enum e_gps_data
{
	gName[32],
	e_gps_type:gType,
	Float:gFanX,
	Float:gFanY,
	Float:gFanZ
};

new const fan_gpstype[][32] =
{
	"Disable Checkpoint",
	"Public Location",
	"Nearest Public Property",
	"Own Property",
	"Jobs"
};

new const fan_gps[][e_gps_data] =
{
	// Public
	{"City Hall", gPublic, 1481.9028, -1739.8154, 13.3857},
	{"Police Department", gPublic, 1539.8739, -1675.4764, 13.3870},
	{"Medical Department", gPublic, 1183.9266, -1324.1641, 13.4139},
	{"Fire Department", gPublic, 922.4051, -1731.9703, 13.6949},
	{"News Agency", gPublic, 645.3287, -1360.8510, 13.4298},
	{"Insurance Agency", gPublic, 1081.2470, -1754.9291, 13.1147},
	{"Department of Motor Vehicles", gPublic, 2062.83, -1897.38, 13.5538},
	{"Bank Los Santos", gPublic, 1464.98, -1011.79, 26.84},
	{"Fish Factory", gPublic, 2845.96, -1521.22, 11.2172},
	{"HopePride Showroom", gPublic, 1775.5502, -1769.4544, 13.3806},
	{"Mechanic Center", gPublic, 1620.9643, -1841.2453, 13.5402},
	{"Product Store", gPublic, -279.67, -2148.42, 28.54},
	{"Component Store", gPublic, 315.07, 926.53, 20.46},
	{"Material Store", gPublic, 2484.9497, -2120.2229, 13.5468},
	{"Component Warehouse", gPublic, 845.1538, -602.0665, 18.4218},
	{"Material Warehouse", gPublic, 571.2070, 1217.8161, 11.8042},
	{"Lumber Warehouse", gPublic, -258.54, -2189.92, 28.97},
	{"Peternakan Sapi", gPublic, 218.2315, 1138.0712, 13.4666},

	// Nearest Public Property
	{"Nearest Bisnis", gPublicProp, 0.0, 0.0, 0.0},
	{"Nearest Park", gPublicProp, 0.0, 0.0, 0.0},
	{"Nearest Dealership", gPublicProp, 0.0, 0.0, 0.0},
	{"Nearest Workshop", gPublicProp, 0.0, 0.0, 0.0},
	{"Nearest Modshop", gPublicProp, 0.0, 0.0, 0.0},
	{"Nearest Gas Station", gPublicProp, 0.0, 0.0, 0.0},
	{"Nearest ATM", gPublicProp, 0.0, 0.0, 0.0},

	// Own Property
	{"House Property", gOwnProp, 0.0, 0.0, 0.0},
	{"Bisnis Property", gOwnProp, 0.0, 0.0, 0.0},
	{"Workshop Property", gOwnProp, 0.0, 0.0, 0.0},
	{"Dealership Property", gOwnProp, 0.0, 0.0, 0.0},
	{"Vehicle Property", gOwnProp, 0.0, 0.0, 0.0},

	// Jobs
	{"Taxi", gJob, 1753.46, -1893.96, 13.55},
	{"Mechanic", gJob, 1627.54, -1785.21, 13.52},
	{"Lumberjack", gJob, -265.81, -2213.57, 29.04},
	{"Trucker", gJob, -77.38, -1136.52, 1.07},
	{"Miner", gJob, 319.94, 874.77, 20.39},
	{"Production", gJob, -283.02, -2174.36, 28.66},
	{"Farmer", gJob, -382.68, -1438.80, 26.13},
	{"Sweeper", gJob, 1380.45, -1578.67, 13.1435},
	{"Bus Driver", gJob, 1002.21, -1332.16, 12.9822},
	{"Forklift", gJob, 2749.74,-2385.79, 13.64},
	{"Milker", gJob, 300.1200, 1141.2943, 9.1374}
};

GPS_ShowForPlayer(playerid)
{
	new fanstr[256];
	forex(fan, sizeof(fan_gpstype))
		strcat(fanstr, sprintf("%s\n", fan_gpstype[fan]));

	strcat(fanstr, "Trucker Mission(Trucker Job)\n");
	strcat(fanstr, "Trucker Hauling(Trucker Job)\n");
	strcat(fanstr, "Tree Location(LumberJack Job)");
	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_TABLIST, "GPS Menu", fanstr, "Pilih", "Keluar");
	return 1;
}

GPS_PublicForPlayer(playerid)
{
	new fanstr[625];
	strcat(fanstr, "Name\tDistance\n");
	forex(fan, sizeof(fan_gps)) if(fan_gps[fan][gType] == gPublic)
		strcat(fanstr, sprintf("%s\t%.2fm\n", fan_gps[fan][gName], GetPlayerDistanceFromPoint(playerid, fan_gps[fan][gFanX], fan_gps[fan][gFanY], fan_gps[fan][gFanZ])));

	ShowPlayerDialog(playerid, DIALOG_GPS_PUBLIC, DIALOG_STYLE_TABLIST_HEADERS, fan_gpstype[1], fanstr, "Pilih", "Kembali");
	return 1;	
}

GPS_PublicPropForPlayer(playerid)
{
	new fanstr[625];
	strcat(fanstr, "Name\n");
	forex(fan, sizeof(fan_gps)) if(fan_gps[fan][gType] == gPublicProp)
		strcat(fanstr, sprintf("%s\n", fan_gps[fan][gName]));

	ShowPlayerDialog(playerid, DIALOG_GPS_PUBLIC_PROP, DIALOG_STYLE_TABLIST_HEADERS, fan_gpstype[2], fanstr, "Pilih", "Kembali");
	return 1;	
}

GPS_OwnPropForPlayer(playerid)
{
	new fanstr[625];
	strcat(fanstr, "Name\n");
	forex(fan, sizeof(fan_gps)) if(fan_gps[fan][gType] == gOwnProp)
		strcat(fanstr, sprintf("%s\n", fan_gps[fan][gName]));

	ShowPlayerDialog(playerid, DIALOG_GPS_OWN_PROP, DIALOG_STYLE_TABLIST_HEADERS, fan_gpstype[3], fanstr, "Pilih", "Kembali");
	return 1;	
}

GPS_JobForPlayer(playerid)
{
	new fanstr[625];
	strcat(fanstr, "Name\tDistance\n");
	forex(fan, sizeof(fan_gps)) if(fan_gps[fan][gType] == gJob)
		strcat(fanstr, sprintf("%s\t%s\n", fan_gps[fan][gName], fan_gps[fan][gFanX] == 0.0 ? ("") : (sprintf("%.2fm", GetPlayerDistanceFromPoint(playerid, fan_gps[fan][gFanX], fan_gps[fan][gFanY], fan_gps[fan][gFanZ])))));

	ShowPlayerDialog(playerid, DIALOG_GPS_JOB, DIALOG_STYLE_TABLIST_HEADERS, fan_gpstype[4], fanstr, "Pilih", "Kembali");
	return 1;	
}

CMD:gps(playerid, params[])
{
	if(PlayerData[playerid][pPhone] < 1) 
		return SendErrorMessage(playerid, "Anda tidak memiliki Phone.");

	GPS_ShowForPlayer(playerid);
	return 1;
}

GPS_ShowNearbyLoc(playerid, loc)
{
	new fanstr[5000], bool:found = false;
	switch(loc)
	{
		case 1: // Bisnis
		{
			strcat(fanstr, "#\tName\tType\tDistance\n");
			foreach(new bizid : Bisnis) if(IsPlayerInRangeOfPoint(playerid, 1000.0, bData[bizid][bExtposX], bData[bizid][bExtposY], bData[bizid][bExtposZ]) && bData[bizid][bLocked] == 0)
			{
				found = true;
				strcat(fanstr, sprintf("%d\t%s\t%s\t%.2fm\n", bizid, bData[bizid][bName], Bisnis_GetType(bizid), GetPlayerDistanceFromPoint(playerid, bData[bizid][bExtposX], bData[bizid][bExtposY], bData[bizid][bExtposZ])));
			}
		}
		case 2: // Park
		{
			strcat(fanstr, "#\tLocation\tDistance\n");
			foreach(new park : Parks) if(IsPlayerInRangeOfPoint(playerid, 1000.0, ppData[park][parkX], ppData[park][parkY], ppData[park][parkZ]))
			{
				found = true;
				strcat(fanstr, sprintf("%d\t%s\t%.2fm\n", park, GetLocation(ppData[park][parkX], ppData[park][parkY], ppData[park][parkZ]), GetPlayerDistanceFromPoint(playerid, ppData[park][parkX], ppData[park][parkY], ppData[park][parkZ])));
			}
		}
		case 3: // Dealership
		{
			/*strcat(fanstr, "#\tName\tType\tDistance\n");
			foreach(new dealerid : Dealer) if(IsPlayerInRangeOfPoint(playerid, 1000.0, DealerData[dealerid][dealerPos][0], DealerData[dealerid][dealerPos][1], DealerData[dealerid][dealerPos][2]) && DealerData[dealerid][dealerStatus] == 0)
			{
				found = true;
				strcat(fanstr, sprintf("%d\t%s\t%s\t%.2fm\n", dealerid, DealerData[dealerid][dealerName], Dealer_Type(dealerid), GetPlayerDistanceFromPoint(playerid, DealerData[dealerid][dealerPos][0], DealerData[dealerid][dealerPos][1], DealerData[dealerid][dealerPos][2])));
			}*/
			GPS_ShowForPlayer(playerid);
			SendCustomMessage(playerid, "DEALERSHIP", "Coming Soon!");
		}
		case 4:
		{
			strcat(fanstr, "#\tName\tDistance\n");
			foreach(new wsid : Workshop) if(IsPlayerInRangeOfPoint(playerid, 1000.0, wsData[wsid][wX], wsData[wsid][wY], wsData[wsid][wZ]) && wsData[wsid][wStatus] == 1)
			{
				found = true;
				strcat(fanstr, sprintf("%d\t%s\t%.2fm\n", wsid, wsData[wsid][wName], GetPlayerDistanceFromPoint(playerid, wsData[wsid][wX], wsData[wsid][wY], wsData[wsid][wZ])));
			}
		}
		case 5:
		{
			strcat(fanstr, "#\tLocation\tDistance\n");
			Loop(mdid, MAX_MODSHOP, 1) if(ModsPoint[mdid][ModsExist] && IsPlayerInRangeOfPoint(playerid, 1000.0, ModsPoint[mdid][ModsPos][0], ModsPoint[mdid][ModsPos][1], ModsPoint[mdid][ModsPos][2]))
			{
				found = true;
				strcat(fanstr, sprintf("%d\t%s\t%.2fm\n", mdid, GetLocation(ModsPoint[mdid][ModsPos][0], ModsPoint[mdid][ModsPos][1], ModsPoint[mdid][ModsPos][2]), GetPlayerDistanceFromPoint(playerid, ModsPoint[mdid][ModsPos][0], ModsPoint[mdid][ModsPos][1], ModsPoint[mdid][ModsPos][2])));
			}
		}
		case 6:
		{
			strcat(fanstr, "#\tLocation\tDistance\n");
			foreach(new gsid : GStation) if(IsPlayerInRangeOfPoint(playerid, 1000.0, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]))
			{
				found = true;
				strcat(fanstr, sprintf("%d\t%s\t%.2fm\n", gsid, GetLocation(gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]), GetPlayerDistanceFromPoint(playerid, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ])));
			}
		}
		case 7:
		{
			strcat(fanstr, "#\tLocation\tDistance\n");
			foreach(new atmid : ATMS) if(IsPlayerInRangeOfPoint(playerid, 1000.0, AtmData[atmid][atmX], AtmData[atmid][atmY], AtmData[atmid][atmZ]))
			{
				found = true;
				strcat(fanstr, sprintf("%d\t%s\t%.2fm\n", atmid, GetLocation(AtmData[atmid][atmX], AtmData[atmid][atmY], AtmData[atmid][atmZ]), GetPlayerDistanceFromPoint(playerid, AtmData[atmid][atmX], AtmData[atmid][atmY], AtmData[atmid][atmZ])));
			}
		}
	}
	if(!found)
	{
		if(loc == 1)
		{
			SendInfoMessage(playerid, "Tidak ditemukan bisnis terdekat yang buka di daerah sini!");
		}
		else if(loc == 2)
		{
			SendInfoMessage(playerid, "Tidak ditemukan park point terdekat di sekitar sini!");
		}
		else if(loc == 3)
		{
			SendInfoMessage(playerid, "Tidak ditemukan dealership terdekat yang buka di daerah ini!");
		}
		else if(loc == 4)
		{
			SendInfoMessage(playerid, "Tidak ditemukan workshop terdekat yang buka di daerah ini!");
		}
		else if(loc == 5)
		{
			SendInfoMessage(playerid, "Tidak ditemukan modshop terdekat di daerah ini!");
		}
		else if(loc == 6)
		{
			SendInfoMessage(playerid, "Tidak ditemukan gas station terdekat di daerah ini!");
		}
		else if(loc == 7)
		{
			SendInfoMessage(playerid, "Tidak ditemukan atm terdekat di daerah ini!");
		}
		else
			SendErrorMessage(playerid, "Invalid Type!");

		GPS_PublicPropForPlayer(playerid);
		return 1;
	}
	SetPVarInt(playerid, "fanLocation", loc);
	ShowPlayerDialog(playerid, DIALOG_GPS_FANN, DIALOG_STYLE_TABLIST_HEADERS, "Nearest Public Property", fanstr, "Pilih", "Kembali");
	return 1;
}

FannBiz(playerid, select, Float:range = 1000.0)
{
	new tmpcount;
	if(select < 1 && select > MAX_BISNIS) return -1;
	foreach(new id : Bisnis) if(IsPlayerInRangeOfPoint(playerid, range, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ]) && bData[id][bLocked] == 0)
	{
		tmpcount++;
		if(tmpcount == select)
		{
			return id;
		}
	}
	return -1;
}

FannPark(playerid, select, Float:range = 1000.0)
{
	new tmpcount;
	if(select < 1 && select > MAX_PARKPOINT) return -1;
	foreach(new id : Parks) if(IsPlayerInRangeOfPoint(playerid, range, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ]))
	{
		tmpcount++;
		if(tmpcount == select)
		{
			return id;
		}
	}
	return -1;
}

FannGasStation(playerid, select, Float:range = 1000.0)
{
	new tmpcount;
	if(select < 1 && select > MAX_GSTATION) return -1;
	foreach(new id : GStation) if(IsPlayerInRangeOfPoint(playerid, range, gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]))
	{
		tmpcount++;
		if(tmpcount == select)
		{
			return id;
		}
	}
	return -1;
}

FannATM(playerid, select, Float:range = 1000.0)
{
	new tmpcount;
	if(select < 1 && select > MAX_ATM) return -1;
	foreach(new id : ATMS) if(IsPlayerInRangeOfPoint(playerid, range, AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ]))
	{
		tmpcount++;
		if(tmpcount == select)
		{
			return id;
		}
	}
	return -1;
}

FannModshop(playerid, select, Float:range = 1000.0)
{
	new tmpcount;
	if(select < 1 && select > MAX_MODSHOP) return -1;
	Loop(id, MAX_MODSHOP, 1) if(ModsPoint[id][ModsExist] && IsPlayerInRangeOfPoint(playerid, range, ModsPoint[id][ModsPos][0], ModsPoint[id][ModsPos][1], ModsPoint[id][ModsPos][2]))
	{
		tmpcount++;
		if(tmpcount == select)
		{
			return id;
		}
	}
	return -1;
}

/*FannDealer(playerid, select, Float:range = 1000.0)
{
	new tmpcount;
	if(select < 1 && select > MAX_DEALERSHIP) return -1;
	foreach(new id : Dealer) if(IsPlayerInRangeOfPoint(playerid, range, DealerData[id][dealerPos][0], DealerData[id][dealerPos][1], DealerData[id][dealerPos][2]) && DealerData[id][dealerStatus] == 0)
	{
		tmpcount++;
		if(tmpcount == select)
		{
			return id;
		}
	}
	return -1;
}*/

FannWorkshop(playerid, select, Float:range = 1000.0)
{
	new tmpcount;
	if(select < 1 && select > MAX_WORKSHOP) return -1;
	foreach(new id : Workshop) if(IsPlayerInRangeOfPoint(playerid, range, wsData[id][wX], wsData[id][wY], wsData[id][wZ]) && wsData[id][wStatus] == 1)
	{
		tmpcount++;
		if(tmpcount == select)
		{
			return id;
		}
	}
	return -1;
}