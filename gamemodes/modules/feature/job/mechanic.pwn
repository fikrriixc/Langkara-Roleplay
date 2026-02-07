//join 1627.54, -1785.21, 13.52
//point 1607.16, -1831.15, 13.70
//point 1604.71, -1814.39, 13.45
// 1634.59, -1841.24, 13.54
// 1651.04, -1835.13, 13.54

CreateJoinMechPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, 1627.54, -1785.21, 13.52, -1);
	format(strings, sizeof(strings), "[MECH JOBS]\n{ffffff}Jadilah Pekerja Mekanik disini\n{7fff00}/getjob /accept job");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1627.54, -1785.21, 13.52, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Taxi
}

IsAtMech(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 15.0, 1607.16, -1831.15, 13.70) || IsPlayerInRangeOfPoint(playerid, 15.0, 1604.71, -1814.39, 13.45) ||
			IsPlayerInRangeOfPoint(playerid, 15.0, 1634.59, -1841.24, 13.54) || IsPlayerInRangeOfPoint(playerid, 15.0, 1651.04, -1835.13, 13.54) ||
			//IsPlayerInRangeOfPoint(playerid, 15.0, 298.59, -248.54, 1.60) || IsPlayerInRangeOfPoint(playerid, 10.0, 266.20, -253.32, 1.59)
			IsPlayerInRangeOfPoint(playerid, 30, -73.94, -1579.71, 2.61) || 
			IsPlayerInRangeOfPoint(playerid, 15.0, -1855.5630,-0.8536,15.2907) || IsPlayerInRangeOfPoint(playerid, 15.0, -1855.4130,7.3143,15.2907) ||
			IsPlayerInRangeOfPoint(playerid, 15.0, -1854.5592,16.4390,15.2907) || IsPlayerInRangeOfPoint(playerid, 15.0, -1854.6669,24.9225,15.2907) ||
			IsPlayerInRangeOfPoint(playerid, 15.0, -1854.7661,37.5907,15.2907) || IsPlayerInRangeOfPoint(playerid, 15.0, -1854.4707,46.6991,15.2907) ||
			IsPlayerInRangeOfPoint(playerid, 15.0, -1854.2528,55.4863,15.2907) || IsPlayerInRangeOfPoint(playerid, 15.0, -1854.0594,64.6941,15.2907) ||
			IsPlayerInRangeOfPoint(playerid, 15.0, -1853.6832,101.4869,15.2025) || IsPlayerInRangeOfPoint(playerid, 15.0, -1855.7808,107.5902,15.2025) ||
			IsPlayerInRangeOfPoint(playerid, 20.0,-81.95, -1571.55, 2.61) || IsPlayerInRangeOfPoint(playerid, 20.0, 1264.85, -2026.17, 59.53))
		{
			return 1;
		}
		foreach(new i : Workshop)
		{
			if(IsPlayerInRangeOfPoint(playerid, 45.0, wsData[i][wX], wsData[i][wY], wsData[i][wZ])) 
			{
				if(IsWorkshopOwner(playerid, i) || IsWorkshopEmploye(playerid, i))
					return 1;
			}
		}
	}
	return 0;
}

// Private Vehicle Components
new pv_spoiler[20][] =
{
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};
new pv_nitro[3][] =
{
    {1008},
    {1009},
    {1010}
};
new pv_fbumper[23][] =
{
    {1117},
    {1152},
    {1153},
    {1155},
    {1157},
    {1160},
    {1165},
    {1166},
    {1169},
    {1170},
    {1171},
    {1172},
    {1173},
    {1174},
    {1175},
    {1179},
    {1181},
    {1182},
    {1185},
    {1188},
    {1189},
    {1190},
    {1191}
};
new pv_rbumper[22][] =
{
    {1140},
    {1141},
    {1148},
    {1149},
    {1150},
    {1151},
    {1154},
    {1156},
    {1159},
    {1161},
    {1167},
    {1168},
    {1176},
    {1177},
    {1178},
    {1180},
    {1183},
    {1184},
    {1186},
    {1187},
    {1192},
    {1193}
};
new pv_exhaust[28][] =
{
    {1018},
    {1019},
    {1020},
    {1021},
    {1022},
    {1028},
    {1029},
    {1037},
    {1043},
    {1044},
    {1045},
    {1046},
    {1059},
    {1064},
    {1065},
    {1066},
    {1089},
    {1092},
    {1104},
    {1105},
    {1113},
    {1114},
    {1126},
    {1127},
    {1129},
    {1132},
    {1135},
    {1136}
};
new pv_bventr[2][] =
{
    {1142},
    {1144}
};
new pv_bventl[2][] =
{
    {1143},
    {1145}
};
new pv_bscoop[4][] =
{
	{1004},
	{1005},
	{1011},
	{1012}
};
new pv_roof[17][] =
{
    {1006},
    {1032},
    {1033},
    {1035},
    {1038},
    {1053},
    {1054},
    {1055},
    {1061},
    {1067},
    {1068},
    {1088},
    {1091},
    {1103},
    {1128},
    {1130},
    {1131}
};
new pv_lskirt[21][] =
{
    {1007},
    {1026},
    {1031},
    {1036},
    {1039},
    {1042},
    {1047},
    {1048},
    {1056},
    {1057},
    {1069},
    {1070},
    {1090},
    {1093},
    {1106},
    {1108},
    {1118},
    {1119},
    {1133},
    {1122},
    {1134}
};
new pv_rskirt[21][] =
{
    {1017},
    {1027},
    {1030},
    {1040},
    {1041},
    {1051},
    {1052},
    {1062},
    {1063},
    {1071},
    {1072},
    {1094},
    {1095},
    {1099},
    {1101},
    {1102},
    {1107},
    {1120},
    {1121},
    {1124},
    {1137}
};
new pv_hydraulics[1][] =
{
    {1087}
};
new pv_base[1][] =
{
    {1086}
};
new pv_rbbars[4][] =
{
    {1109},
    {1110},
    {1123},
    {1125}
};
new pv_fbbars[2][] =
{
    {1115},
    {1116}
};
new pv_wheels[17][] =
{
    {1025},
    {1073},
    {1074},
    {1075},
    {1076},
    {1077},
    {1078},
    {1079},
    {1080},
    {1081},
    {1082},
    {1083},
    {1084},
    {1085},
    {1096},
    {1097},
    {1098}
};
new pv_lights[2][] =
{
	{1013},
	{1024}
};

//Mechanic jobs
CMD:mechduty(playerid, params[])
{
	if(PlayerData[playerid][pJob] == 2 || PlayerData[playerid][pJob2] == 2)
	{		
		if(PlayerData[playerid][pMechDuty] == 0)
		{
			PlayerData[playerid][pMechDuty] = 1;
			SetPlayerColor(playerid, COLOR_ORANGE);
			//SendClientMessageToAll(COLOR_GREEN, "[MECH]"WHITE_E" %s is now on Mehcanic Duty. Type \"/call 1222\" to call a taxi!", ReturnName(playerid, 0));
		}
		else
		{
			PlayerData[playerid][pMechDuty] = 0;
			SetPlayerColor(playerid, COLOR_WHITE);
			SendServerMessage(playerid, "Anda telah off dari mech duty!");
		}
	}
	else 
		SendErrorMessage(playerid, "Anda bukan pekerja mechanic!");
	
	return 1;
}

CMD:service(playerid, params[])
{
	if(PlayerData[playerid][pJob] == 2 || PlayerData[playerid][pJob2] == 2)
	{
		if(PlayerData[playerid][pMechVeh] == INVALID_VEHICLE_ID)
		{
			new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
			if(!GetHoodStatus(vehicleid) && !IsAMotor(vehicleid)) return SendErrorMessage(playerid,"Please open the vehicle Hood before checking services");
			
			if(vehicleid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "You not in near any vehicles.");
			if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");

			foreach(new i : PlayerVehicles)
			{
				if(VehicleData[i][cVeh] == vehicleid)
				{
					SendVehicleMessage(GetVehicleOwner(i),"Your {7fffd4}%s{ffffff} is on process checked by %s", GetVehicleModelName(VehicleData[i][cModel]), ReturnName(playerid));
				}
			}
			
			SendInfoMessage(playerid, "Don't move from your position or you will failed to checking this vehicle!");
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, true, false, false, true, 0, SYNC_ALL);
			PlayerData[playerid][pMechanic] = SetTimerEx("CheckCar", 1000, true, "dd", playerid, vehicleid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Checking...");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			return 1;
		}
		
		if(GetNearestVehicleToPlayer(playerid, 3.5, false) == PlayerData[playerid][pMechVeh])
		{
			if(!GetHoodStatus(PlayerData[playerid][pMechVeh])) return SendErrorMessage(playerid,"Please open the vehicle Hood before checking services");

			new Dstring[1800], Float:health, engine;
			new VEHICLE_PANEL_STATUS:panels, VEHICLE_DOOR_STATUS:doors, VEHICLE_LIGHT_STATUS:light, VEHICLE_TYRE_STATUS:tires, body;
			GetVehicleHealth(PlayerData[playerid][pMechVeh], health);
			if(health > 1000.0) health = 1000.0;
			if(health > 2000.0) health = 2000.0;
			if(health > 3000.0) health = 3000.0;
			if(health > 4500.0) health = 4500.0;
			if(health > 0.0) health *= -1;
			engine = floatround(health, floatround_round) / 10 + 100;
			
			GetVehicleDamageStatus(PlayerData[playerid][pMechVeh], panels, doors, light, tires);
		    new cpanels = _:panels / 1000000;
		    new lights = _:light / 2;
		    new pintu;
		    if(doors != VEHICLE_DOOR_STATUS_NONE) pintu = 5;
		    if(doors == VEHICLE_DOOR_STATUS_NONE) pintu = 0;
		    body = cpanels + lights + pintu + 20;
			
			format(Dstring, sizeof(Dstring), "Service Name\tRequirement\n");
			format(Dstring, sizeof(Dstring), "%sEngine Fix\t%d\n", Dstring, engine);
			format(Dstring, sizeof(Dstring), "%sBody Fix\t%d Component\n", Dstring, body);
			format(Dstring, sizeof(Dstring), "%sSpray Car\t40 Component\n", Dstring);
			format(Dstring, sizeof(Dstring), "%sPaint Job Car\t60 Component\n", Dstring);
			foreach(new id : Workshop)
			{
				if(IsPlayerInRangeOfPoint(playerid, 50.0, wsData[id][wX], wsData[id][wY], wsData[id][wZ]))
				{
					if(IsWorkshopOwner(playerid, id) || IsWorkshopEmploye(playerid, id))
					{		
						format(Dstring, sizeof(Dstring), "%sWheels Car\t65 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sSpoiler Car\t60 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sHood Car\t70 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sVents Car\t70 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sLights Car\t70 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sExhausts\t80 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sFront bumpers\t100 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sRear Bumpers\t100 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sRoofs Car\t70 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sSide skirts\t90 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sBullbars\t50 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sStereo\t150 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sHydraulics\t150 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sNitro 1\t250 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sNitro 2\t375 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sNitro 3\t500 Component\n", Dstring);
						format(Dstring, sizeof(Dstring), "%sNeon\t450 Component\n", Dstring);
					}
				}
			}
			ShowPlayerDialog(playerid, DIALOG_SERVICE, DIALOG_STYLE_TABLIST_HEADERS, "Mech Service", Dstring, "Service", "Cancel");
		}
		else
		{
			KillTimer(PlayerData[playerid][pMechanic]), PlayerData[playerid][pMechanic] = -1;
			HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			PlayerData[playerid][pActivityTime] = 0;
			SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
			return 1;
		}
	}
	else return SendErrorMessage(playerid, "Anda bukan pekerja mechanic!");
	return 1;
}

//Mech JOB
public:CheckCar(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(PlayerData[playerid][pMechanic])) return 0;
	if(PlayerData[playerid][pJob] == 2 || PlayerData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
		{
			if(PlayerData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				PlayerData[playerid][pMechVeh] = vehicleid;
				InfoTD_MSG(playerid, 8000, "Checking done!");
				//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has successfully refulling the vehicle.", ReturnName(playerid));
				KillTimer(PlayerData[playerid][pMechanic]);
				PlayerData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(PlayerData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				PlayerData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
			}
			else
			{
				SendErrorMessage(playerid, "Checking fail! Anda tidak berada didekat kendaraan tersebut!");
				KillTimer(PlayerData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				PlayerData[playerid][pActivityTime] = 0;
				PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
				ClearAnimations(playerid);
			}
		}
		else
		{
			SendErrorMessage(playerid, "Checking fail! Anda tidak berada didekat kendaraan tersebut!");
			KillTimer(PlayerData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			PlayerData[playerid][pActivityTime] = 0;
			PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			ClearAnimations(playerid);
			return 1;
		}
	}
	return 1;
}

public:BodyFix(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(PlayerData[playerid][pMechanic])) return 0;
	if(PlayerData[playerid][pJob] == 2 || PlayerData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
		{
			if(PlayerData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				new VEHICLE_PANEL_STATUS:panels, VEHICLE_DOOR_STATUS:doors, VEHICLE_LIGHT_STATUS:light, VEHICLE_TYRE_STATUS:tires;
				GetVehicleDamageStatus(vehicleid, panels, doors, light, tires);		
				UpdateVehicleDamageStatus(vehicleid, VEHICLE_PANEL_STATUS_NONE, VEHICLE_DOOR_STATUS_NONE, VEHICLE_LIGHT_STATUS_NONE, tires);
				
				InfoTD_MSG(playerid, 8000, "Fix body done!");
				PlayerData[playerid][pMechVeh] = vehicleid;
				KillTimer(PlayerData[playerid][pMechanic]);
				PlayerData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(PlayerData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				PlayerData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
			}
			else
			{
				SendErrorMessage(playerid, "Body fix fail! Anda tidak berada didekat kendaraan tersebut!");
				KillTimer(PlayerData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				PlayerData[playerid][pActivityTime] = 0;
				PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			SendErrorMessage(playerid, "Body fix fail! Anda tidak berada didekat kendaraan tersebut!");
			KillTimer(PlayerData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			PlayerData[playerid][pActivityTime] = 0;
			PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

public:EngineFix(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(PlayerData[playerid][pMechanic])) return 0;
	if(PlayerData[playerid][pJob] == 2 || PlayerData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
		{
			if(PlayerData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				SetValidVehicleHealth(vehicleid, 1000);
				
				InfoTD_MSG(playerid, 8000, "Fix engine done!");
				PlayerData[playerid][pMechVeh] = vehicleid;
				KillTimer(PlayerData[playerid][pMechanic]);
				PlayerData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(PlayerData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				PlayerData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
			}
			else
			{
				SendErrorMessage(playerid, "Engine fix fail! Anda tidak berada didekat kendaraan tersebut!");
				KillTimer(PlayerData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				PlayerData[playerid][pActivityTime] = 0;
				PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			SendErrorMessage(playerid, "Engine fix fail! Anda tidak berada didekat kendaraan tersebut!");
			KillTimer(PlayerData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			PlayerData[playerid][pActivityTime] = 0;
			PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

public:SprayCar(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(PlayerData[playerid][pMechanic])) return 0;
	if(PlayerData[playerid][pJob] == 2 || PlayerData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
		{
			if(PlayerData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				
				ChangeVehicleColor(vehicleid, PlayerData[playerid][pMechColor1], PlayerData[playerid][pMechColor2]);
				foreach(new ii : PlayerVehicles)
				{
					if(vehicleid == VehicleData[ii][cVeh])
					{
						VehicleData[ii][cColor1] = PlayerData[playerid][pMechColor1];
						VehicleData[ii][cColor2] = PlayerData[playerid][pMechColor2];
					}
				}
				InfoTD_MSG(playerid, 8000, "Spraying done!");
				PlayerData[playerid][pMechVeh] = vehicleid;
				KillTimer(PlayerData[playerid][pMechanic]);
				PlayerData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(PlayerData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				PlayerData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
			}
			else
			{
				SendErrorMessage(playerid, "Spraying car fail! Anda tidak berada didekat kendaraan tersebut!");
				KillTimer(PlayerData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				PlayerData[playerid][pActivityTime] = 0;
				PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			SendErrorMessage(playerid, "Engine fix fail! Anda tidak berada didekat kendaraan tersebut!");
			KillTimer(PlayerData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			PlayerData[playerid][pActivityTime] = 0;
			PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

public:PaintjobCar(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(PlayerData[playerid][pMechanic])) return 0;
	if(PlayerData[playerid][pJob] == 2 || PlayerData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
		{
			if(PlayerData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				
				ChangeVehiclePaintjob(vehicleid, PlayerData[playerid][pMechColor1]);
				foreach(new ii : PlayerVehicles)
				{
					if(vehicleid == VehicleData[ii][cVeh])
					{
						VehicleData[ii][cPaintJob] = PlayerData[playerid][pMechColor1];
					}
				}
				
				InfoTD_MSG(playerid, 8000, "Painting done!");
				PlayerData[playerid][pMechVeh] = vehicleid;
				KillTimer(PlayerData[playerid][pMechanic]);
				PlayerData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(PlayerData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				PlayerData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
			}
			else
			{
				SendErrorMessage(playerid, "Spraying car fail! Anda tidak berada didekat kendaraan tersebut!");
				KillTimer(PlayerData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				PlayerData[playerid][pActivityTime] = 0;
				PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			SendErrorMessage(playerid, "Engine fix fail! Anda tidak berada didekat kendaraan tersebut!");
			KillTimer(PlayerData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			PlayerData[playerid][pActivityTime] = 0;
			PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

public:ModifCar(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(PlayerData[playerid][pMechanic])) return 0;
	if(PlayerData[playerid][pJob] == 2 || PlayerData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
		{
			if(PlayerData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				
				AddVehicleComponent(vehicleid, PlayerData[playerid][pMechColor1]);
				SavePVComponents(vehicleid, PlayerData[playerid][pMechColor1]);
				if(PlayerData[playerid][pMechColor2] != 0)
				{
					AddVehicleComponent(vehicleid, PlayerData[playerid][pMechColor2]);
					SavePVComponents(vehicleid, PlayerData[playerid][pMechColor2]);
				}
				
				InfoTD_MSG(playerid, 8000, "Modif done!");
				PlayerData[playerid][pMechVeh] = vehicleid;
				KillTimer(PlayerData[playerid][pMechanic]);
				PlayerData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
				return 1;
			}
			else if(PlayerData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				PlayerData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
			}
			else
			{
				SendErrorMessage(playerid, "Spraying car fail! Anda tidak berada didekat kendaraan tersebut!");
				KillTimer(PlayerData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				PlayerData[playerid][pActivityTime] = 0;
				PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			SendErrorMessage(playerid, "Mofid fix fail! Anda tidak berada didekat kendaraan tersebut!");
			KillTimer(PlayerData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			PlayerData[playerid][pActivityTime] = 0;
			PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}


public:NeonCar(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(PlayerData[playerid][pMechanic])) return 0;
	if(PlayerData[playerid][pJob] == 2 || PlayerData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
		{
			if(PlayerData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				if(PlayerData[playerid][pMechColor1] == 0)
				{
					SetVehicleNeonLights(vehicleid, false, PlayerData[playerid][pMechColor1], 0);
				}
				else
				{
					SetVehicleNeonLights(vehicleid, true, PlayerData[playerid][pMechColor1], 0);
				}
				foreach(new ii : PlayerVehicles)
				{
					if(vehicleid == VehicleData[ii][cVeh])
					{
						VehicleData[ii][cNeon] = PlayerData[playerid][pMechColor1];
						
						if(VehicleData[ii][cNeon] == 0)
						{
							VehicleData[ii][cTogNeon] = 0;
						}
						else
						{
							VehicleData[ii][cTogNeon] = 1;
						}
					}
				}
				
				InfoTD_MSG(playerid, 8000, "Neon done!");
				PlayerData[playerid][pMechVeh] = vehicleid;
				KillTimer(PlayerData[playerid][pMechanic]);
				PlayerData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(PlayerData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				PlayerData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
			}
			else
			{
				SendErrorMessage(playerid, "Spraying car fail! Anda tidak berada didekat kendaraan tersebut!");
				KillTimer(PlayerData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				PlayerData[playerid][pActivityTime] = 0;
				PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			SendErrorMessage(playerid, "Engine fix fail! Anda tidak berada didekat kendaraan tersebut!");
			KillTimer(PlayerData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			PlayerData[playerid][pActivityTime] = 0;
			PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}


SavePVComponents(vehicleid, componentid)
{
	foreach(new ii: PlayerVehicles)
	{
		if(vehicleid == VehicleData[ii][cVeh])
		{
			for(new s = 0; s < 20; s++)
			{
				if(componentid == pv_spoiler[s][0])
				{
					VehicleData[ii][cMod][0] = componentid;
				}
			}

			for(new s = 0; s < 3; s++)
			{
				if(componentid == pv_nitro[s][0])
				{
					VehicleData[ii][cMod][1] = componentid;
				}
			}

			for(new s = 0; s < 23; s++)
			{
				if(componentid == pv_fbumper[s][0])
				{
					VehicleData[ii][cMod][2] = componentid;
				}
			}

			for(new s = 0; s < 22; s++)
			{
				if(componentid == pv_rbumper[s][0])
				{
					VehicleData[ii][cMod][3] = componentid;
				}
			}

			for(new s = 0; s < 28; s++)
			{
				if(componentid == pv_exhaust[s][0])
				{
					VehicleData[ii][cMod][4] = componentid;
				}
			}

			for(new s = 0; s < 2; s++)
			{
				if(componentid == pv_bventr[s][0])
				{
					VehicleData[ii][cMod][5] = componentid;
				}
			}

			for(new s = 0; s < 2; s++)
			{
				if(componentid == pv_bventl[s][0])
				{
					VehicleData[ii][cMod][6] = componentid;
				}
			}

			for(new s = 0; s < 4; s++)
			{
				if(componentid == pv_bscoop[s][0])
				{
					VehicleData[ii][cMod][7] = componentid;
				}
			}

			for(new s = 0; s < 17; s++)
			{
				if(componentid == pv_roof[s][0])
				{
					VehicleData[ii][cMod][8] = componentid;
				}
			}

			for(new s = 0; s < 21; s++)
			{
				if(componentid == pv_lskirt[s][0])
				{
					VehicleData[ii][cMod][9] = componentid;
				}
			}

			for(new s = 0; s < 21; s++)
			{
				if(componentid == pv_rskirt[s][0])
				{
					VehicleData[ii][cMod][10] = componentid;
				}
			}

			for(new s = 0; s < 1; s++)
			{
				if(componentid == pv_hydraulics[s][0])
				{
					VehicleData[ii][cMod][11] = componentid;
				}
			}

			for(new s = 0; s < 1; s++)
			{
				if(componentid == pv_base[s][0])
				{
					VehicleData[ii][cMod][12] = componentid;
				}
			}

			for(new s = 0; s < 4; s++)
			{
				if(componentid == pv_rbbars[s][0])
				{
					VehicleData[ii][cMod][13] = componentid;
				}
			}

			for(new s = 0; s < 2; s++)
			{
				if(componentid == pv_fbbars[s][0])
				{
					VehicleData[ii][cMod][14] = componentid;
				}
			}

			for(new s = 0; s < 17; s++)
			{
				if(componentid == pv_wheels[s][0])
				{
					VehicleData[ii][cMod][15] = componentid;
				}
			}

			for(new s = 0; s < 2; s++)
			{
				if(componentid == pv_lights[s][0])
				{
					VehicleData[ii][cMod][16] = componentid;
				}
			}
		}
	}
	return 1;
}
