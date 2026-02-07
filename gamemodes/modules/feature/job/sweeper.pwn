// Sweeper Sidejob
// Build by Fann

new const Float:SweeperRoute[][][3] =
{
    // Route 1
    {
        {1315.6332,-1569.6871,13.1080},
        {1334.2397,-1509.6725,13.1079},
        {1359.6375,-1421.8394,13.1079},
        {1320.4907,-1393.2935,13.0604},
        {1265.2231,-1392.7772,12.8837},
        {1262.3806,-1278.8788,13.0431},
        {1196.2695,-1278.1820,13.0658},
        {1195.9363,-1392.5574,12.8965},
        {1061.2185,-1392.6384,13.2145},
        {1057.5387,-1452.7839,13.0901},
        {1035.7518,-1557.8513,13.0819},
        {1034.5358,-1713.1666,13.1099},
        {1146.7697,-1714.7200,13.5064},
        {1294.3937,-1715.1047,13.1080},
        {1295.0546,-1854.7382,13.1079},
        {1391.5858,-1875.5431,13.1080},
        {1391.3439,-1735.1486,13.1149},
        {1431.0377,-1735.5879,13.1080},
        {1432.7080,-1590.3550,13.1158},
        {1380.1821,-1584.3375,13.0956},
        {1385.16,-1556.59,13.69},
        {0.0, 0.0, 0.0},
        {0.0, 0.0, 0.0},
        {0.0, 0.0, 0.0},
        {0.0, 0.0, 0.0},
        {0.0, 0.0, 0.0}
    },
    // Route 2
    {
        {1416.0228,-1594.5168,13.0894},
        {1525.9496,-1594.5038,13.1157},
        {1527.2015,-1715.2076,13.1079},
        {1571.0892,-1734.6486,13.1097},
        {1690.6659,-1734.9031,13.1183},
        {1818.2689,-1734.5735,13.1080},
        {1845.8044,-1754.4082,13.1078},
        {1942.1942,-1755.0146,13.1079},
        {1938.5110,-1612.4591,13.1079},
        {1825.5416,-1609.9858,13.1058},
        {1713.6425,-1591.8118,13.0866},
        {1661.5282,-1590.5726,13.1173},
        {1660.4248,-1439.5377,13.1079},
        {1609.1470,-1438.1656,13.1080},
        {1611.2473,-1297.4122,17.0064},
        {1468.8929,-1296.1992,13.1611},
        {1452.1372,-1316.3556,13.1080},
        {1452.2960,-1423.8989,13.1079},
        {1434.2109,-1535.4905,13.1026},
        {1427.3871,-1588.5927,13.1157},
        {1380.1821,-1584.3375,13.0956},
        {1385.16,-1556.59,13.69},
        {0.0, 0.0, 0.0},
        {0.0, 0.0, 0.0},
        {0.0, 0.0, 0.0},
        {0.0, 0.0, 0.0}
    },
    // Route 3
    {
        {1426.1704,-1594.1392,13.1160},
        {1427.2870,-1647.9890,13.0908},
        {1426.7964,-1716.4054,13.1079},
        {1388.7852,-1729.7666,13.1080},
        {1386.4607,-1853.6068,13.1079},
        {1401.3813,-1875.2633,13.1080},
        {1514.1666,-1875.0796,13.1080},
        {1603.3969,-1875.4104,13.1079},
        {1686.2434,-1858.6086,13.1119},
        {1691.8575,-1816.6533,13.1140},
        {1751.7976,-1824.4037,13.1130},
        {1817.7424,-1834.1172,13.1392},
        {1820.9419,-1933.1539,13.1024},
        {1945.3389,-1934.7996,13.1079},
        {1963.7144,-1877.2684,13.1079},
        {1963.9944,-1750.3612,13.1080},
        {1835.4379,-1749.7634,13.1080},
        {1807.3591,-1730.6323,13.1158},
        {1670.0962,-1729.3608,13.1079},
        {1543.2943,-1729.9379,13.1079},
        {1436.1337,-1730.5010,13.1079},
        {1431.6207,-1679.4716,13.1079},
        {1432.3372,-1590.7336,13.1160},
        {1380.1821,-1584.3375,13.0956},
        {1385.16,-1556.59,13.69},
        {0.0, 0.0, 0.0}
    }
};

Sweeper_LoadVehicle()
{
	JobVeh[3] = CreateVehicle(574,1392.5072, -1557.1420, 13.3316, 96.9866,1,1,-1);
    JobVeh[4] = CreateVehicle(574,1391.8308, -1559.9460, 13.3331, 92.8360,1,1,-1);
    JobVeh[5] = CreateVehicle(574,1391.1074, -1563.0504, 13.3337, 99.5275,1,1,-1);
    
	return 1;
}

Sweeper_ShowDialog(playerid)
{
	new fanstr[256];
	strcat(fanstr, "List Route\tStatus\n", sizeof(fanstr));
	strcat(fanstr, sprintf(""W"Route A\t%s\n", Sweeper_RouteStatus(0)), sizeof(fanstr));
	strcat(fanstr, sprintf(""W"Route B\t%s\n", Sweeper_RouteStatus(1)), sizeof(fanstr));
	strcat(fanstr, sprintf(""W"Route C\t%s\n", Sweeper_RouteStatus(2)), sizeof(fanstr));

	ShowPlayerDialog(playerid, DIALOG_SWEEPER_START, DIALOG_STYLE_TABLIST_HEADERS, "Side Job - Sweeper", fanstr, "Pilih", "Kembali");
	return 1;
}

Sweeper_RouteStatus(route)
{
	new fanstr[64];
	if(sweeperRouteTaken[route])
		format(fanstr, sizeof(fanstr), ""RED_E"Taken");
	else
		format(fanstr, sizeof(fanstr), ""GREEN_E"Availaible");

	return fanstr;
}

Player_InSweeper(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	Loop(i, 6, 2) if(vehicleid == JobVeh[i])
		return 1;

	return 0;
}

Player_SweeperCP(playerid)
{
	new bCount = GetPVarInt(playerid, "sweeperCount"), bRoute = GetPVarInt(playerid, "sweeperRoute");

	if(SweeperRoute[bRoute][bCount+1][0] != 0.0 && SweeperRoute[bRoute][bCount+1][1] != 0.0 && SweeperRoute[bRoute][bCount+1][2] != 0.0)
	{
		if(SweeperRoute[bRoute][bCount+2][0] != 0.0 && SweeperRoute[bRoute][bCount+2][1] != 0.0 && SweeperRoute[bRoute][bCount+2][2] != 0.0)
			SetPlayerRaceCheckpoint(playerid, CP_TYPE_GROUND_NORMAL, SweeperRoute[bRoute][bCount+1][0], SweeperRoute[bRoute][bCount+1][1], SweeperRoute[bRoute][bCount+1][2], SweeperRoute[bRoute][bCount+2][0], SweeperRoute[bRoute][bCount+2][1], SweeperRoute[bRoute][bCount+2][2], 5.0);
		else
			SetPlayerRaceCheckpoint(playerid, CP_TYPE_GROUND_FINISH, SweeperRoute[bRoute][bCount+1][0], SweeperRoute[bRoute][bCount+1][1], SweeperRoute[bRoute][bCount+1][2], SweeperRoute[bRoute][bCount+2][0], SweeperRoute[bRoute][bCount+2][1], SweeperRoute[bRoute][bCount+2][2], 5.0);
	
	    PlayerPlaySound(playerid, SOUND_CHECKPOINT);
		SetPVarInt(playerid, "sweeperCount", bCount+1);
	}
	else
	{
		new BonusRoute, TotalSalary;
		switch(bRoute)
		{
			case 0: BonusRoute = RandomEx(50, 100);
			case 1: BonusRoute = RandomEx(75, 120);
			case 2: BonusRoute = RandomEx(80, 130);
		}
		TotalSalary = 300+BonusRoute;
		AddPlayerSalary(playerid, "Sweeper (SideJob)", TotalSalary);

		Sidejob_SuccessMSG(playerid, PlayerData[playerid][pSideJob]);
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));

		DisablePlayerRaceCheckpoint(playerid);

		sweeperRouteTaken[bRoute] = false;

		PlayerData[playerid][pSideJob] = 0;
		SetPVarInt(playerid, "sweeperRoute", -1);
		SetPVarInt(playerid, "sweeperCount", -1);
	}
	return 1;
}