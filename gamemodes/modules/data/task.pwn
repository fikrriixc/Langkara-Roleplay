/*


         TASK OPTIMIZED LUNARPRIDE

*/

public:onlineTimer()
{	
	//Date and Time Textdraw
	new datestring[64];
	new hours,
	seconds,
	minutes,
	days,
	months,
	years;
	new MonthName[12][] =
	{
		"January", "February", "March", "April", "May", "June",
		"July",	"August", "September", "October", "November", "December"
	};
	getdate(years, months, days);
 	gettime(hours, minutes, seconds);
	format(datestring, sizeof datestring, "%s%d %s %s%d", ((days < 10) ? ("0") : ("")), days, MonthName[months-1], (years < 10) ? ("0") : (""), years);
	TextDrawSetString(TextDate, datestring);
	format(datestring, sizeof datestring, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
	TextDrawSetString(TextTime, datestring);

	TextDrawSetString(PhoneTD[42], "%2d:%2d", hours, minutes);

	// Increase server uptime
	up_seconds ++;
	if(up_seconds == 60)
	{
	    up_seconds = 0, up_minutes ++;
	    if(up_minutes == 60)
	    {
	        up_minutes = 0, up_hours ++;
	        if(up_hours == 24) up_hours = 0, up_days ++;
			new tstr[128], rand = RandomEx(0, 10);
			format(tstr, sizeof(tstr), ""BLUE_E"UPTIME: "WHITE_E"The server has been online for %s.", Uptime());
			SendClientMessageToAll(COLOR_WHITE, tstr);
			if(hours > 18)
			{
				SetWorldTime(0);
				WorldTime = 0;
			}
			else
			{
				SetWorldTime(hours);
				WorldTime = hours;
			}
			if(rand == 10)
				rand = 16;

			SetWeather(rand);
			WorldWeather = rand;

			if(random(100)+1 > 50)
	        {
	        	foreach(new playerid : Player) if(PlayerData[playerid][IsLoggedIn] && PlayerData[playerid][pSpawned])
	        		SendCustomMessage(playerid, "{FFFF00}DAILY", "%s", fann_dailyinfo[random(sizeof(fann_dailyinfo))]);
	        }

			// Sync Server
			//mysql_tquery(g_SQL, "OPTIMIZE TABLE `bisnis`,`houses`,`toys`,`vehicle`,`workshop`");
			//SetTimer("changeWeather", 10000, false);
		}
	}
	return 1;
}

public:PlayerDelay(playerid)
{
	if(PlayerData[playerid][IsLoggedIn] == false) return 0;
	// Booster Expired Checking
	if(PlayerData[playerid][pBooster] > 0)
	{
		if(PlayerData[playerid][pBoostTime] != 0 && PlayerData[playerid][pBoostTime] <= gettime())
		{
			SendInfoMessage(playerid, "Maaf, Booster player anda sudah habis! sekarang anda adalah player biasa!");
			PlayerData[playerid][pBooster] = 0;
			PlayerData[playerid][pBoostTime] = 0;
		}
	}
		//VIP Expired Checking
	if(PlayerData[playerid][pVip] > 0)
	{
		if(PlayerData[playerid][pVipTime] != 0 && PlayerData[playerid][pVipTime] <= gettime())
		{
			SendInfoMessage(playerid, "Maaf, Level VIP player anda sudah habis! sekarang anda adalah player biasa!");
			PlayerData[playerid][pVip] = 0;
			PlayerData[playerid][pVipTime] = 0;
		}
	}
		//ID Card Expired Checking
	if(PlayerData[playerid][pIDCard] > 0)
	{
		if(PlayerData[playerid][pIDCardTime] != 0 && PlayerData[playerid][pIDCardTime] <= gettime())
		{
			SendInfoMessage(playerid, "Masa berlaku ID Card anda telah habis, silahkan perpanjang kembali!");
			PlayerData[playerid][pIDCard] = 0;
			PlayerData[playerid][pIDCardTime] = 0;
		}
	}

	if(PlayerData[playerid][pExitJob] != 0 && PlayerData[playerid][pExitJob] <= gettime())
	{
		SendInfoMessage(playerid, "Now you can exit from your current job!");
		PlayerData[playerid][pExitJob] = 0;
	}
	if(PlayerData[playerid][pDriveLic] > 0)
	{
		if(PlayerData[playerid][pDriveLicTime] != 0 && PlayerData[playerid][pDriveLicTime] <= gettime())
		{
			SendInfoMessage(playerid, "Masa berlaku Driving anda telah habis, silahkan perpanjang kembali!");
			PlayerData[playerid][pDriveLicTime] = 0;
		}
	}

	if(PlayerData[playerid][pRobTime] != 0 && PlayerData[playerid][pRobTime] <= gettime())
	{
		SendInfoMessage(playerid, "Kamu sudah dapat melakukan Robbery kembali!");
		PlayerData[playerid][pRobTime] = 0;
	}
	
	if(PlayerData[playerid][pDriveDelay] != 0 && PlayerData[playerid][pDriveDelay] <= gettime())
	{
		SendInfoMessage(playerid, "Kamu sudah dapat melakukan test Drive-Lic kembali!");
		PlayerData[playerid][pDriveDelay] = 0;
	}

		//Player JobTime Delay
	if(PlayerData[playerid][pJobTime] > 0)
	{
		PlayerData[playerid][pJobTime]--;
	}
	if(PlayerData[playerid][pSideJobTime] > 0)
	{
		PlayerData[playerid][pSideJobTime]--;
	}
		// Duty Delay
	if(PlayerData[playerid][pDutyHour] > 0)
	{
		PlayerData[playerid][pDutyHour]--;
	}
		// Rob Delay
	if(PlayerData[playerid][pRobTime] > 0)
	{
		PlayerData[playerid][pRobTime]--;
	}
		// Get Loc timer
	if(PlayerData[playerid][pSuspectTimer] > 0)
	{
		PlayerData[playerid][pSuspectTimer]--;
	}
		//Warn Player Check
	if(PlayerData[playerid][pWarn] >= 20)
	{
		new ban_time = gettime() + (5 * 86400), query[512], PlayerIP[16], giveplayer[24];
		GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
		GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
		PlayerData[playerid][pWarn] = 0;
			//SetPlayerPosition(playerid, 227.46, 110.0, 999.02, 360.0000, 10);
		Blacklist_AddChar(playerid, "HopePride Bot", "20 Warnings Detected", ban_time, PlayerIP);
		SendClientMessageToAll(COLOR_RED, "Server: "GREY2_E"Player %s(%d) telah otomatis dibanned permanent dari server. [Reason: 20 Total Warning]", giveplayer, playerid);

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', 'Server Ban', '20 Total Warning', %i, %d)", giveplayer, PlayerIP, gettime(), ban_time);
		mysql_tquery(g_SQL, query);
		KickEx(playerid);
	}
	return 1;
}

public:FarmDetect(playerid)
{
	if(PlayerData[playerid][IsLoggedIn] == true)
	{
		if(PlayerData[playerid][pPlant] >= 20)
		{
			PlayerData[playerid][pPlant] = 0;
			PlayerData[playerid][pPlantTime] = 600;
		}
		if(PlayerData[playerid][pPlantTime] > 0)
		{
			PlayerData[playerid][pPlantTime]--;
			if(PlayerData[playerid][pPlantTime] < 1)
			{
				PlayerData[playerid][pPlantTime] = 0;
				PlayerData[playerid][pPlant] = 0;
			}
		}
		new pid = GetClosestPlant(playerid);
		if(pid != -1)
		{
			if(IsPlayerInDynamicCP(playerid, PlantData[pid][PlantCP]) && pid != -1)
			{
				new type[24], mstr[128];
				if(PlantData[pid][PlantType] == 1)
				{
					type = "Potato";
				}
				else if(PlantData[pid][PlantType] == 2)
				{
					type = "Wheat";
				}
				else if(PlantData[pid][PlantType] == 3)
				{
					type = "Orange";
				}
				else if(PlantData[pid][PlantType] == 4)
				{
					type = "Marijuana";
				}
				if(PlantData[pid][PlantTime] > 1)
				{
					format(mstr, sizeof(mstr), "~w~Plant Type: ~g~%s ~n~~w~Plant Time: ~r~%s", type, ConvertToMinutes(PlantData[pid][PlantTime]));
					InfoTD_MSG(playerid, 1000, mstr);
				}
				else
				{
					format(mstr, sizeof(mstr), "~w~Plant Type: ~g~%s ~n~~w~Plant Time: ~g~Now", type);
					InfoTD_MSG(playerid, 1000, mstr);
				}
			}
		}
	}
	return 1;
}

public:playerTimer(playerid)
{
	if(PlayerData[playerid][IsLoggedIn] == true)
	{
		PlayerData[playerid][pPaycheck] ++;

		PlayerData[playerid][pSeconds] ++, PlayerData[playerid][pCurrSeconds] ++;
		if(PlayerData[playerid][pOnDuty] >= 1)
		{
			PlayerData[playerid][pOnDutyTime]++;
		}
		if(PlayerData[playerid][pTaxiDuty] >= 1)
		{
			PlayerData[playerid][pTaxiTime]++;
		}
		if(PlayerData[playerid][pSeconds] == 60)
		{
			new scoremath = ((PlayerData[playerid][pLevel])*5);

			PlayerData[playerid][pMinutes]++, PlayerData[playerid][pCurrMinutes] ++;
			PlayerData[playerid][pSeconds] = 0, PlayerData[playerid][pCurrSeconds] = 0;

			switch(PlayerData[playerid][pMinutes])
			{
				case 20:
				{
					if(PlayerData[playerid][pBooster] == 1)
					{
						AddPlayerSalary(playerid, "Bonus Boost ( RP Booster )", 200);
					}
				}
				case 40:
				{
					if(PlayerData[playerid][pBooster] == 1)
					{
						PlayerData[playerid][pPaycheck] = 3601;
					}
					if(PlayerData[playerid][pPaycheck] >= 3600)
					{
						SendInfoMessage(playerid, "Waktunya mengambil paycheck!");
						SendServerMessage(playerid, "{ffff00}silahkan pergi ke bank atau ATM terdekat untuk mengambil paycheck.");
						PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
					}
				}
				case 60:
				{
					if(PlayerData[playerid][pPaycheck] >= 3600)
					{
						SendInfoMessage(playerid, "Waktunya mengambil paycheck!");
						SendServerMessage(playerid, "{ffff00}silahkan pergi ke bank atau ATM terdekat untuk mengambil paycheck.");
						PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
					}

					PlayerData[playerid][pHours] ++;
					PlayerData[playerid][pLevelUp] += 1;
					PlayerData[playerid][pMinutes] = 0;
					UpdatePlayerData(playerid);

					if(PlayerData[playerid][pLevelUp] >= scoremath)
					{
						new mstr[128];
						PlayerData[playerid][pLevel] += 1;
						PlayerData[playerid][pHours] ++;
						SetPlayerScore(playerid, PlayerData[playerid][pLevel]);
						format(mstr,sizeof(mstr),"~g~Level Up!~n~~w~Sekarang anda level ~r~%d", PlayerData[playerid][pLevel]);
						GameTextForPlayer(playerid, mstr, 6000, 1);
					}
				}
			}
			if(PlayerData[playerid][pCurrMinutes] == 60)
			{
				PlayerData[playerid][pCurrMinutes] = 0;
				PlayerData[playerid][pCurrHours] ++;
			}
		}
	}
	return 1;
}
