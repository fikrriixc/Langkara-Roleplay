CreateJoinTruckPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, -77.38, -1136.52, 1.07, -1);
	format(strings, sizeof(strings), "[TRUCKER JOBS]\n{ffffff}Jadilah Pekerja Trucker disini\n{7fffd4}/getjob /accept job");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -77.38, -1136.52, 1.07, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // truck
}

//Mission
GetRestockBisnis()
{
	new tmpcount;
	foreach(new id : Bisnis)
	{
	    if(bData[id][bRestock] == 1)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockBisnisID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_BISNIS) return -1;
	foreach(new id : Bisnis)
	{
	    if(bData[id][bRestock] == 1)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

/*GetRestockDealer()
{
	new tmpcount;
	foreach(new id : Dealer)
	{
	    if(DealerData[id][dealerRestock] == 1)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockDealerID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_DEALERSHIP) return -1;
	foreach(new id : Dealer)
	{
	    if(DealerData[id][dealerRestock] == 1)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}*/

//Hauling
GetRestockGStation()
{
	new tmpcount;
	foreach(new id : GStation)
	{
	    if(gsData[id][gsStock] < 7000)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockGStationID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_GSTATION) return -1;
	foreach(new id : GStation)
	{
	    if(gsData[id][gsStock] < 7000)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

//Mission Commands
CMD:mission(playerid, params[])
{
	if(PlayerData[playerid][pJob] == 4 || PlayerData[playerid][pJob2] == 4)
	{
		new fanstr[328];
		strcat(fanstr, "Mission\tStatus\n");
		format(fanstr, sizeof(fanstr), "\
			Restock Bisnis\t%s\n\
			Restock Dealership\tComing Soon\n\
			Restock Component\t%s\n\
			Restock Material\t%s\n\
			Restock Product\t%s", fanstr,
			GetRestockBisnis() > 0 ? ("{00ff00}Available{ffffff}") : ("{ff0000}Not Today{ffffff}")/*,
			GetRestockDealer() > 0 ? ("{00ff00}Available{ffffff}") : ("{ff0000}Not Today{ffffff}")*/,
			Component < 1000 ? ("{00ff00}Available{ffffff}") : ("{ff0000}Not Today{ffffff}"),
			Material < 1000 ? ("{00ff00}Available{ffffff}") : ("{ff0000}Not Today{ffffff}"),
			Product < 100 ? ("{00ff00}Available{ffffff}") : ("{ff0000}Not Today{ffffff}"));

		ShowPlayerDialog(playerid, DIALOG_MISSION, DIALOG_STYLE_TABLIST_HEADERS, "Mission", fanstr, "Select", "Back");
	}
	else return SendErrorMessage(playerid, "You are not trucker job.");
	return 1;
}

CMD:storeproduct(playerid, params[])
{
	if(PlayerData[playerid][pJob] == 4 || PlayerData[playerid][pJob2] == 4)
	{
		new id = PlayerData[playerid][pMission], vehicleid = GetPlayerVehicleID(playerid), carid, total, Float:percent, pay, convert;
		if(id == -1) return SendErrorMessage(playerid, "You dont have mission.");
		if(GetPVarInt(playerid, "fanMission") == 0)
		{
			if(IsPlayerInRangeOfPoint(playerid, 4.8, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ]))
			{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsATruck(vehicleid)) return SendErrorMessage(playerid, "Anda harus mengendarai truck.");
				if(VehProduct[vehicleid] < 1) return SendErrorMessage(playerid, "Product is empty in this vehicle.");
				total = VehProduct[vehicleid] * ProductPrice;
				percent = (total / 100) * 50;
				convert = floatround(percent, floatround_floor);
				pay = total + convert;
				bData[id][bProd] += VehProduct[vehicleid];
				bData[id][bMoney] -= pay;
				SendInfoMessage(playerid, "Anda menjual "RED_E"%d "WHITE_E"product dengan seharga "GREEN_E"%s", VehProduct[vehicleid], FormatMoney(pay));
				GivePlayerMoneyEx(playerid, pay);
				if((carid = Vehicle_Nearest(playerid)) != -1)
				{
					VehicleData[carid][cProduct] = 0;
					SendInfoMessage(playerid, "Anda mendapatkan uang 50 percent dari hasil stock product anda.");
				}
				VehProduct[vehicleid] = 0;
				PlayerData[playerid][pMission] = -1;
				Bisnis_Save(id);
				Bisnis_Refresh(id);
			}
			else return SendErrorMessage(playerid, "Anda harus berada didekat dengan bisnis mission anda.");
		}
		/*else if(GetPVarInt(playerid, "fanMission") == 1)
		{
			if(IsPlayerInRangeOfPoint(playerid, 4.8, DealerData[id][dealerPos][0], DealerData[id][dealerPos][1], DealerData[id][dealerPos][2]))
			{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsATruck(vehicleid)) return SendErrorMessage(playerid, "Anda harus mengendarai truck.");
				if(VehProduct[vehicleid] < 1) return SendErrorMessage(playerid, "Product is empty in this vehicle.");
				total = VehProduct[vehicleid] * ProductPrice;
				percent = (total / 100) * 50;
				convert = floatround(percent, floatround_floor);
				pay = total + convert;
				DealerData[id][dealerStock] += VehProduct[vehicleid];
				DealerData[id][dealerVault] -= pay;
				SendInfoMessage(playerid, "Anda menjual "RED_E"%d "WHITE_E"product dengan seharga "GREEN_E"%s", VehProduct[vehicleid], FormatMoney(pay));
				GivePlayerMoneyEx(playerid, pay);
				if((carid = Vehicle_Nearest(playerid)) != -1)
				{
					VehicleData[carid][cProduct] = 0;
					SendInfoMessage(playerid, "Anda mendapatkan uang 50 percent dari hasil stock product anda.");
				}
				VehProduct[vehicleid] = 0;
				PlayerData[playerid][pMission] = -1;
				Dealer_Save(id);
				Dealer_Refresh(id);
			}
			else return SendErrorMessage(playerid, "Anda harus berada didekat dengan bisnis mission anda.");
		}*/
		else
			return SendErrorMessage(playerid, "Unknown mission!");
	}
	else return SendErrorMessage(playerid, "You are not trucker job.");
	return 1;
}


//Hauling Commands
CMD:hauling(playerid, params[])
{
	if(PlayerData[playerid][pJob] == 4 || PlayerData[playerid][pJob2] == 4)
	{
		if(GetRestockGStation() <= 0) return SendErrorMessage(playerid, "Hauling sedang kosong.");
		new id, count = GetRestockGStation(), hauling[128], lstr[512];
		
		strcat(hauling,"#\tLocation\n",sizeof(hauling));
		Loop(itt, (count + 1), 1)
		{
			id = ReturnRestockGStationID(itt);
			if(itt == count)
			{
				format(lstr,sizeof(lstr), "%d\t%s\n", id, GetLocation(gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]));	
			}
			else format(lstr,sizeof(lstr), "%d\t%s\n", id, GetLocation(gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]));
			strcat(hauling,lstr,sizeof(hauling));
		}
		ShowPlayerDialog(playerid, DIALOG_HAULING, DIALOG_STYLE_TABLIST_HEADERS,"Hauling",hauling,"Start","Cancel");
	}
	else return SendErrorMessage(playerid, "You are not trucker job.");
	return 1;
}

CMD:storegas(playerid, params[])
{
	if(PlayerData[playerid][pJob] == 4 || PlayerData[playerid][pJob2] == 4)
	{
		new id = PlayerData[playerid][pHauling], vehicleid = GetPlayerVehicleID(playerid), carid, total, Float:percent, pay, convert;
		if(id == -1) return SendErrorMessage(playerid, "You dont have hauling.");
		if(IsPlayerInRangeOfPoint(playerid, 5.5, gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]))
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsAHaulTruck(vehicleid)) return SendErrorMessage(playerid, "Anda harus mengendarai truck.");
			if(!IsTrailerAttachedToVehicle(vehicleid)) return SendErrorMessage(playerid, "Your Vehicle Trailer is not even attached");

			if(VehGasOil[vehicleid] < 1) return SendErrorMessage(playerid, "GasOil is empty in this vehicle.");
			DetachTrailerFromVehicle(vehicleid);

			DestroyVehicle(GetVehicleTrailer(vehicleid));
			PlayerData[playerid][pTrailer] = INVALID_VEHICLE_ID;

			total = VehGasOil[vehicleid] * GasOilPrice;
			percent = (total / 100) * 35;
			convert = floatround(percent, floatround_ceil);
			pay = total + convert;
			gsData[id][gsStock] += VehGasOil[vehicleid];
			Server_MinMoney(pay);
			SendInfoMessage(playerid, "Anda menjual "RED_E"%d "WHITE_E"liters gas oil dengan harga "GREEN_E"%s", VehGasOil[vehicleid], FormatMoney(pay));
			AddPlayerSalary(playerid, "Hauling Mission(Job Trucker)", pay);
			if((carid = Vehicle_GetID(vehicleid)) != -1)
			{
				VehicleData[carid][cGasOil] = 0;
				SendInfoMessage(playerid, "Anda mendapatkan uang {00ff00}35 percent{ffffff} dari hasil stock liters gas oil anda.");
			}
			
			PlayerPlaySound(playerid, 183);
			VehGasOil[vehicleid] = 0;
			PlayerData[playerid][pHauling] = -1;
			PlayerData[playerid][pJobTime] = 1200;
			GStation_Refresh(id);
			GStation_Save(id);
			DisablePlayerRaceCheckpoint(playerid);
		}
		else return SendErrorMessage(playerid, "Anda harus berada didekat dengan gas oil hauling anda.");
	}
	else return SendErrorMessage(playerid, "You are not trucker job.");
	return 1;
}