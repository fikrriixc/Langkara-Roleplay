// -279.67, -2148.42, 28.54 buy product
//-249.79, -2148.05, 29.30 point1
//-244.14, -2146.05, 29.30 point2
//-250.88, -2143.23, 29.32 point 3
//-245.74, -2141.65, 29.32 point4
CreateJoinProductionPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, -283.02, -2174.36, 28.66, -1);
	format(strings, sizeof(strings), "[PRODUCTION JOBS]\n{ffffff}Jadilah Pekerja Production disini\n{7fffd4}/getjob /accept job");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -283.02, -2174.36, 28.66, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job
	
	format(strings, sizeof(strings), "[PRODUCTION JOBS]\n{FFFFFF}/createproduct");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -249.79, -2148.05, 29.30, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job
	
	format(strings, sizeof(strings), "[PRODUCTION JOBS]\n{FFFFFF}/createproduct");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -244.14, -2146.05, 29.30, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job
	
	format(strings, sizeof(strings), "[PRODUCTION JOBS]\n{FFFFFF}/createproduct");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -250.88, -2143.23, 29.32, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job
	
	format(strings, sizeof(strings), "[PRODUCTION JOBS]\n{FFFFFF}/createproduct");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -245.74, -2141.65, 29.32, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job
}


CMD:createproduct(playerid, params[])
{
	if(PlayerData[playerid][pJobTime] > 0) return SendErrorMessage(playerid, "Anda harus menunggu "GREY2_E"%d "WHITE_E"detik untuk bisa bekerja kembali.", PlayerData[playerid][pJobTime]);
	if(PlayerData[playerid][pJob] == 6 || PlayerData[playerid][pJob2] == 6)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, -249.79, -2148.05, 29.30) || IsPlayerInRangeOfPoint(playerid, 2.0, -244.14, -2146.05, 29.30)
		|| IsPlayerInRangeOfPoint(playerid, 2.0, -250.88, -2143.23, 29.32) || IsPlayerInRangeOfPoint(playerid, 2.0, -245.74, -2141.65, 29.32))
		{
			new type;
			if(sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/createproduct [type, 1.Food 2.Clothes 3.Equipment");
			
			if(type < 1 || type > 3) return SendErrorMessage(playerid, "Invalid type id.");
			
			if(type == 1)
			{
				if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "Anda masih memiliki activity progress!");
				if(Inventory_Has(playerid, "Food") < 40) return SendErrorMessage(playerid, "Food tidak cukup!(Minimal: 40).");
				if(PlayerData[playerid][CarryProduct] != 0) return SendErrorMessage(playerid, "Anda sedang membawa sebuah product");
				Inventory_Remove(playerid, "Food", 40);
				
				TogglePlayerControllable(playerid, false);
				SendInfoMessage(playerid, "Anda sedang memproduksi bahan makanan dengan 40 food!");
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, false, false, false, false, 0, SYNC_ALL);
				PlayerData[playerid][pProducting] = SetTimerEx("CreateProduct", 1000, true, "id", playerid, 1);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Creating...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			}
			else if(type == 2)
			{
				if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "Anda masih memiliki activity progress!");
				if(Inventory_Has(playerid, "Material") < 40) return SendErrorMessage(playerid, "Material tidak cukup!(Butuh: 40).");
				if(PlayerData[playerid][CarryProduct] != 0) return SendErrorMessage(playerid, "Anda sedang membawa sebuah product");
				Inventory_Remove(playerid, "Material", 40);
				
				TogglePlayerControllable(playerid, false);
				SendInfoMessage(playerid, "Anda sedang memproduksi baju dengan 40 material!");
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, false, false, false, false, 0, SYNC_ALL);
				PlayerData[playerid][pProducting] = SetTimerEx("CreateProduct", 1000, true, "id", playerid, 2);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Creating...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				
			}
			else if(type == 3)
			{
				if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "Anda masih memiliki activity progress!");
				if(Inventory_Has(playerid, "Material") < 40) return SendErrorMessage(playerid, "Material tidak cukup!(Butuh: 40).");
				if(Inventory_Has(playerid, "Component") < 20) return SendErrorMessage(playerid, "Component tidak cukup!(Butuh: 20).");
				if(PlayerData[playerid][CarryProduct] != 0) return SendErrorMessage(playerid, "Anda sedang membawa sebuah product");
				Inventory_Remove(playerid, "Material", 40);
				Inventory_Remove(playerid, "Component", 20);
				
				TogglePlayerControllable(playerid, false);
				SendInfoMessage(playerid, "Anda sedang memproduksi equipment dengan 40 material dan 20 component!");
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, false, false, false, false, 0, SYNC_ALL);
				PlayerData[playerid][pProducting] = SetTimerEx("CreateProduct", 1000, true, "id", playerid, 3);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Creating...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			}
		}
		else return SendErrorMessage(playerid, "You're not near in production warehouse.");
	}
	else SendErrorMessage(playerid, "Anda bukan pekerja sebagai operator produksi.");
	return 1;
}

public:CreateProduct(playerid, type)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(PlayerData[playerid][pProducting])) return 0;
	if(PlayerData[playerid][pJob] == 6 || PlayerData[playerid][pJob2] == 6)
	{
		if(PlayerData[playerid][pActivityTime] >= 100)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, -249.79, -2148.05, 29.30) || IsPlayerInRangeOfPoint(playerid, 2.0, -244.14, -2146.05, 29.30)
			|| IsPlayerInRangeOfPoint(playerid, 2.0, -250.88, -2143.23, 29.32) || IsPlayerInRangeOfPoint(playerid, 2.0, -245.74, -2141.65, 29.32))
			{
				if(type == 1)
				{
					SetPlayerAttachedObject(playerid, 9, 2453, 5, 0.105, 0.086, 0.22, -80.3, 3.3, 28.7, 0.35, 0.35, 0.35);
					PlayerData[playerid][CarryProduct] = 1;
					SendInfoMessage(playerid, "Anda telah berhasil membuat bahan makanan, /sellproduct untuk menjualnya.");
					TogglePlayerControllable(playerid, true);
					InfoTD_MSG(playerid, 8000, "Food Created!");
					KillTimer(PlayerData[playerid][pProducting]);
					PlayerData[playerid][pActivityTime] = 0;
					HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					PlayerData[playerid][pEnergy] -= 3;
					ClearAnimations(playerid);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				}
				else if(type == 2)
				{
					SetPlayerAttachedObject(playerid, 9, 2391, 5, 0.105, 0.086, 0.22, -80.3, 3.3, 28.7, 0.35, 0.35, 0.35);
					PlayerData[playerid][CarryProduct] = 2;
					SendInfoMessage(playerid, "Anda telah berhasil membuat product baju, /sellproduct untuk menjualnya.");
					TogglePlayerControllable(playerid, true);
					InfoTD_MSG(playerid, 8000, "Clothes Created!");
					KillTimer(PlayerData[playerid][pProducting]);
					PlayerData[playerid][pActivityTime] = 0;
					HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					PlayerData[playerid][pEnergy] -= 3;
					ClearAnimations(playerid);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				}
				else if(type == 3)
				{
					SetPlayerAttachedObject(playerid, 9, 2912, 5, 0.105, 0.086, 0.22, -80.3, 3.3, 28.7, 0.35, 0.35, 0.35);
					PlayerData[playerid][CarryProduct] = 3;
					SendInfoMessage(playerid, "Anda telah berhasil membuat product equipment, /sellproduct untuk menjualnya.");
					TogglePlayerControllable(playerid, true);
					InfoTD_MSG(playerid, 8000, "Equipment Created!");
					KillTimer(PlayerData[playerid][pProducting]);
					PlayerData[playerid][pActivityTime] = 0;
					HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					PlayerData[playerid][pEnergy] -= 3;
					ClearAnimations(playerid);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				}
				else
				{
					KillTimer(PlayerData[playerid][pProducting]);
					PlayerData[playerid][pActivityTime] = 0;
					HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					return 1;
				}
			}
		}
		else if(PlayerData[playerid][pActivityTime] < 100)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, -249.79, -2148.05, 29.30) || IsPlayerInRangeOfPoint(playerid, 2.0, -244.14, -2146.05, 29.30)
			|| IsPlayerInRangeOfPoint(playerid, 2.0, -250.88, -2143.23, 29.32) || IsPlayerInRangeOfPoint(playerid, 2.0, -245.74, -2141.65, 29.32))
			{
				PlayerData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, false, false, false, false, 0, SYNC_ALL);
			}
		}
	}
	return 1;
}

CMD:sellproduct(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -279.67, -2148.42, 28.54)) return SendErrorMessage(playerid, "Kamu tidak didekat Warehouse.");
	if(PlayerData[playerid][CarryProduct] == 0) return SendErrorMessage(playerid, "Kamu sedang tidak memegang apapun.");
	
	if(PlayerData[playerid][CarryProduct] == 1)
	{
		RemovePlayerAttachedObject(playerid, 9);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		PlayerData[playerid][CarryProduct] = 0;
		GivePlayerMoneyEx(playerid, 600);
		
		Product += 10;
		Server_MinMoney(600);
		SendInfoMessage(playerid, "Anda menjual 10 bahan makanan dengan harga "GREEN_E"$600");
		PlayerData[playerid][pJobTime] += 480;
	}
	else if(PlayerData[playerid][CarryProduct] == 2)
	{
		RemovePlayerAttachedObject(playerid, 9);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		PlayerData[playerid][CarryProduct] = 0;
		GivePlayerMoneyEx(playerid, 650);
		
		Product += 10;
		Server_MinMoney(650);
		SendInfoMessage(playerid, "Anda menjual 10 product baju dengan harga "GREEN_E"$650");
		PlayerData[playerid][pJobTime] += 480;
	}
	else if(PlayerData[playerid][CarryProduct] == 3)
	{
		RemovePlayerAttachedObject(playerid, 9);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		PlayerData[playerid][CarryProduct] = 0;
		GivePlayerMoneyEx(playerid, 1200);
		
		Product += 10;
		Server_MinMoney(1200);
		SendInfoMessage(playerid, "Anda menjual 10 product equipment dengan harga "GREEN_E"$1.200");
		PlayerData[playerid][pJobTime] += 480;
	}
	return 1;
}
