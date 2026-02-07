// Sidejob Bus
// Inspired by Unity Gamers Roleplay
// Build by Fann

enum e_sidejobbus_data
{
	Float:bPosX,
	Float:bPosY,
	Float:bPosZ,
	bool:bWait
};

new const stock BusRoute[][][e_sidejobbus_data] =
{
    // Route 1
    {
        {1056.2252, -1328.4484, 13.0893, false},
        {1060.1982, -1407.8023, 13.1182, false},
        {1339.7512, -1406.1884, 13.0384, false},
        {1306.3637, -1855.3937, 13.0900, false},
        {1527.3968, -1886.1958, 13.2437, false},
        {1788.9730, -2168.8205, 13.0898, true},
        {1961.5853, -1930.8852, 13.0890, false},
        {1824.2197, -1924.4671, 13.0906, false},
        {1824.3470, -1852.7259, 13.1213, false},
        {1865.3669, -1466.7999, 13.0903, false},
        {2115.5161, -1463.9348, 23.5318, false},
        {2088.1228, -1381.1146, 23.5349, true},
        {2056.2951, -1080.3917, 24.4264, false},
        {1877.1104, -1045.9467, 23.3927, false},
        {1845.7684, -1178.9250, 23.3476, false},
        {1579.7189, -1150.9376, 23.5979, false},
        {1455.9471, -1031.7312, 23.3632, true},
        {1370.7440, -1023.6841, 26.2295, false},
        {1366.4855, -930.4343, 33.8940, false},
        {934.9320, -963.5938, 38.0444, false},
        {741.9313, -1057.8843, 23.0216, false},
        {619.9476, -1213.2727, 17.8112, false},
        {624.3613, -1364.6081, 13.1513, true},
        {653.4861, -1405.5262, 13.1082, false},
        {919.4390, -1405.8571, 12.9700, false},
        {920.0567, -1328.1943, 13.1755, false},
        {1002.7592, -1333.8193, 13.0893, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false}
    },
    // Route 2
    {
        {800.0700, -1317.9040, 13.0897, false},
        {637.7045, -1319.7327, 13.0817, false},
        {626.2348, -1184.5938, 18.7518, false},
        {37.8269, -1292.5130, 13.3968, false},
        {-114.4041, -1423.2570, 12.3566, false},
        {-41.1526, -1409.1296, 11.2448, false},
        {-45.5751, -1496.2319, 1.5178, false},
        {-109.5203, -1166.4279, 2.3466, true},
        {-116.6506, -977.8545, 25.0062, false},
        {48.1106, -539.8789, 9.8952, false},
        {-289.4266, -153.5882, 1.3599, false},
        {181.1388, -213.7110, 1.1327, false},
        {335.1893, -194.3424, 0.4504, true},
        {346.3038, -144.2984, 1.2344, false},
        {529.0880, -142.1224, 37.5353, false},
        {1179.6115, -170.0256, 40.3051, false},
        {1258.2947, -427.3402, 3.1604, false},
        {1179.1594, -681.4006, 61.5927, false},
        {1159.4910, -960.3660, 42.3897, false},
        {1158.8312, -1141.3565, 23.3626, false},
        {1056.1345, -1140.8187, 23.3716, false},
        {1055.7839, -1318.8133, 13.0907, false},
        {1002.7592, -1333.8193, 13.0893, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false},
        {0.0, 0.0, 0.0, false}
    },
    // Route 3
    {
        {631.9332, -1317.9509, 13.6356, false},
        {631.3235, -1316.7475, 13.2854, false},
        {624.7666, -1727.2167, 13.6581, false},
        {387.4186, -1699.2850, 7.6164, true},
        {143.3844, -1564.3625, 10.2739, false},
        {168.6896, -1739.4127, 4.1051, true},
        {339.9109, -1749.3632, 4.1452, false},
        {367.4196, -1775.4553, 5.0391, false},
        {429.8540, -1774.3160, 4.9973, false},
        {482.5812, -1724.8475, 10.8031, false},
        {949.8886, -1794.5336, 13.7373, false},
        {1049.9676, -1926.7222, 12.6614, false},
        {1320.4609, -2464.5520, 7.3633, false},
        {1359.9885, -2437.0793, 7.7271, false},
        {1348.9945, -2314.3554, 13.0898, false},
        {1492.6542, -2333.1845, 13.0952, false},
        {1573.9189, -2299.8222, 13.0554, false},
        {1640.1367, -2321.9140, 13.0898, false},
        {1735.4000, -2305.7819, 13.0830, false},
        {1714.1530, -2251.4797, 13.0897, false},
        {1645.6041, -2251.2783, 13.0346, true},
        {1573.6306, -2264.0024, 13.0892, false},
        {1524.0256, -2283.5202, 13.0900, false},
        {1478.8912, -2237.6584, 13.0896, false},
        {1455.6953, -2192.3354, 13.6292, false},
        {1322.6455, -2192.9121, 21.4029, false},
        {1321.5976, -2258.9182, 13.0898, false},
        {1330.1044, -2283.9221, 13.0978, false},
        {1306.5441, -2446.7934, 7.3705, false},
        {1114.2742, -2358.4494, 11.6007, true},
        {1037.4006, -1801.8947, 13.3671, false},
        {1056.2252, -1328.4484, 13.0893, false},
        {1002.7592, -1333.8193, 13.0893, false},
        {0.0, 0.0, 0.0, false}
    }
};

Bus_LoadVehicle()
{
	JobVeh[0] = CreateVehicle(437,1014.334,-1368.111,13.495,90.000,0,0,-1);
    JobVeh[1] = CreateVehicle(437,1014.169,-1359.855,13.495,90.000,0,0,-1);
    JobVeh[2] = CreateVehicle(437,1014.217,-1352.011,13.495,90.000,0,0,-1);

    return 1;
}

Bus_ShowDialog(playerid)
{
	new fanstr[256];
	strcat(fanstr, "List Route\tStatus\n");
	strcat(fanstr, sprintf(""W"Route A\t%s\n", Bus_RouteStatus(0)), sizeof(fanstr));
	strcat(fanstr, sprintf(""W"Route B\t%s\n", Bus_RouteStatus(1)), sizeof(fanstr));
	strcat(fanstr, sprintf(""W"Route C\t%s\n", Bus_RouteStatus(2)), sizeof(fanstr));

	ShowPlayerDialog(playerid, DIALOG_BUS_START, DIALOG_STYLE_TABLIST_HEADERS, "Side Job - Bus Route", fanstr, "Pilih", "Kembali");
	return 1;
}

Bus_RouteStatus(route)
{
	new fanstr[64];
	if(busRouteTaken[route])
		format(fanstr, sizeof(fanstr), ""RED_E"Taken");
	else
		format(fanstr, sizeof(fanstr), ""GREEN_E"Available");

	return fanstr;
}

Player_InBus(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	forex(i, 3) if(vehicleid == JobVeh[i])
		return 1;

	return 0;
}

Player_BusCP(playerid)
{
	new bCount = GetPVarInt(playerid, "busCount"), bRoute = GetPVarInt(playerid, "busRoute");

	if(BusRoute[bRoute][bCount+1][bPosX] != 0.0 && BusRoute[bRoute][bCount+1][bPosY] != 0.0 && BusRoute[bRoute][bCount+1][bPosZ] != 0.0)
	{
		if(BusRoute[bRoute][bCount][bWait])
		{
			SetPVarInt(playerid, "busCountD", 10);
			GameTextForPlayer(playerid, "Wait: 10", 1000, 3);

			PlayerTemp[playerid][temp_jobtimer] = SetTimerEx("Bus_Wait", 1000, true, "d", playerid);
			return 1;
		}
		else 
		{	
	        PlayerPlaySound(playerid, SOUND_CHECKPOINT);
			if(BusRoute[bRoute][bCount+2][bPosX] != 0.0 && BusRoute[bRoute][bCount+2][bPosY] != 0.0 && BusRoute[bRoute][bCount+2][bPosZ] != 0.0)
				SetPlayerRaceCheckpoint(playerid, CP_TYPE_GROUND_NORMAL, BusRoute[bRoute][bCount+1][bPosX], BusRoute[bRoute][bCount+1][bPosY], BusRoute[bRoute][bCount+1][bPosZ], BusRoute[bRoute][bCount+2][bPosX], BusRoute[bRoute][bCount+2][bPosY], BusRoute[bRoute][bCount+2][bPosZ], 5.0);
			else
				SetPlayerRaceCheckpoint(playerid, CP_TYPE_GROUND_FINISH, BusRoute[bRoute][bCount+1][bPosX], BusRoute[bRoute][bCount+1][bPosY], BusRoute[bRoute][bCount+1][bPosZ], BusRoute[bRoute][bCount+2][bPosX], BusRoute[bRoute][bCount+2][bPosY], BusRoute[bRoute][bCount+2][bPosZ], 5.0);
		}

		SetPVarInt(playerid, "busCount", bCount+1);
	}
	else
	{
		new BonusRoute, TotalSalary;
		switch(bRoute)
		{
			case 0: BonusRoute = RandomEx(40, 60);
			case 1: BonusRoute = RandomEx(50, 70);
			case 2: BonusRoute = RandomEx(60, 100);
		}
		TotalSalary = 400+BonusRoute;
		AddPlayerSalary(playerid, "Bus Driver (SideJob)", TotalSalary);

		Sidejob_SuccessMSG(playerid, PlayerData[playerid][pSideJob]);
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));

		DisablePlayerRaceCheckpoint(playerid);

		busRouteTaken[bRoute] = false;

		PlayerTemp[playerid][temp_jobtimer] = -1;
		PlayerData[playerid][pSideJob] = 0;
		SetPVarInt(playerid, "busRoute", -1);
		SetPVarInt(playerid, "busCount", -1);
		SetPVarInt(playerid, "busCountD", 0);
	}
	return 1;
}

public:Bus_Wait(playerid)
{
	new bRoute = GetPVarInt(playerid, "busRoute"), bCount = GetPVarInt(playerid, "busCount");
	if(IsPlayerInRaceCheckpoint(playerid))
	{
		SetPVarInt(playerid, "busCountD", GetPVarInt(playerid, "busCountD")-1);
		if(GetPVarInt(playerid, "busCountD") != 0)
		{
			GameTextForPlayer(playerid, sprintf("Wait: %d", GetPVarInt(playerid, "busCountD")), 1000, 3);
		}
		else
		{
			KillTimer(PlayerTemp[playerid][temp_jobtimer]);

			SetPVarInt(playerid, "busCount", bCount+1);
            bCount++;
	        PlayerPlaySound(playerid, SOUND_CHECKPOINT);
			SetPlayerRaceCheckpoint(playerid, CP_TYPE_GROUND_NORMAL, BusRoute[bRoute][bCount][bPosX], BusRoute[bRoute][bCount][bPosY], BusRoute[bRoute][bCount][bPosZ], BusRoute[bRoute][bCount+1][bPosX], BusRoute[bRoute][bCount+1][bPosY], BusRoute[bRoute][bCount+1][bPosZ], 5.0);
		}
	}
	else
	{
        KillTimer(PlayerTemp[playerid][temp_jobtimer]);

		SetPVarInt(playerid, "busCountD", 10);
		SetPlayerRaceCheckpoint(playerid, CP_TYPE_GROUND_NORMAL, BusRoute[bRoute][bCount][bPosX], BusRoute[bRoute][bCount][bPosY], BusRoute[bRoute][bCount][bPosZ], BusRoute[bRoute][bCount+1][bPosX], BusRoute[bRoute][bCount+1][bPosY], BusRoute[bRoute][bCount+1][bPosZ], 5.0);
	}
	return 1;
}