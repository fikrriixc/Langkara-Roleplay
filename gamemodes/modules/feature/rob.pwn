/*
	AKU CINTA MERAMPOK!!!!!!!!!
	AKU CINTA!!!!!

	AKU MAU JADI PERAMPOK HANDAL!!
	AKU MAU JADI PENGOCOK HANDAL!!
*/

CMD:makerobteam(playerid, params[])
{
	if(PlayerData[playerid][pLevel] < 7)
		return SendErrorMessage(playerid, "Kamu harus level 7 untuk membuat tim!");

	if(PlayerData[playerid][pRobTime] != 0)
		return SendErrorMessage(playerid, "Kamu baru baru ini sudah melakukan perampokan, tunggu 1 hari untuk melakukannya kembali.");

	if(PlayerData[playerid][pMemberRob] != -1)
		return SendErrorMessage(playerid, "Kamu sudah bergabung kedalam tim lain!");

	if(PlayerData[playerid][pRobLeader] != 0)
		return SendErrorMessage(playerid, "Kamu sudah membuat tim sebelumnya!");

	PlayerData[playerid][pRobLeader] = 1;
	PlayerData[playerid][pRobMember] = 0;
	SendServerMessage(playerid, "Kamu berhasil membuat tim untuk melakukan {ffff00}Robbery{ffffff}.");
	SendInfoMessage(playerid, "Gunakan {00ff00}/help -> Robbery Commands{ffffff} untuk mengetahui command!");

	SendStaffMessage(COLOR_LRED, "%s[%d] telah membuat robbery team.", NormalName(playerid), playerid);
	return 1;
}

CMD:disbandteam(playerid, params[])
{
	if(PlayerData[playerid][pLevel] < 7)
		return SendErrorMessage(playerid, "Kamu harus level 7 untuk membuat tim!");

	if(PlayerData[playerid][pRobLeader] != 1)
		return SendErrorMessage(playerid, "Kamu bukan leader dari tim!");

	foreach(new ii : Player) 
	{
		if(PlayerData[ii][pMemberRob] == playerid)
		{
			SendServerMessage(ii, "* Pemimpin Perampokan anda telah membubarkan tim!");
			PlayerData[ii][pMemberRob] = -1;
		}
	}
	PlayerData[playerid][pRobLeader] = 0;
	PlayerData[playerid][pRobMember] = 0;
	SendServerMessage(playerid, "Kamu berhasil membubarkan tim untuk melakukan {ffff00}Robbery{ffffff}.");
	return 1;
}

CMD:robinvite(playerid, params[])
{
	if(PlayerData[playerid][pRobTime] != 0)
		return SendErrorMessage(playerid, "Kamu baru baru ini sudah melakukan perampokan, tunggu 1 hari untuk melakukannya kembali.");

	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/robinvite [playerid/PartOwName]");

    if(!IsPlayerConnected(otherid))
		return SendErrorMessage(playerid, "Invalid ID.");
	
	if(otherid == playerid)
		return SendErrorMessage(playerid, "Invalid ID.");

	if(!NearPlayer(playerid, otherid, 5.0))
	    return SendErrorMessage(playerid, "You must be near this player.");

	if(PlayerData[playerid][pLevel] < 7)
		return SendErrorMessage(playerid, "Kamu harus level 7 untuk menginvite orang untuk robbing");

	if(PlayerData[otherid][pLevel] < 7)
		return SendErrorMessage(playerid, "Anggota harus level 7 untuk melakukan robbing");

	if(PlayerData[playerid][pFaction] != 0)
		return SendErrorMessage(playerid, "Anggota faction tidak bisa melakukan ini");

	if(PlayerData[otherid][pFaction] != 0)
		return SendErrorMessage(playerid, "Kamu tidak bisa menginvite anggota faction");

	if(PlayerData[otherid][pRobTime] != 0)
		return SendErrorMessage(playerid, "Orang tersebut baru baru ini sudah melakukan perampokan.");

	if(PlayerData[otherid][pRobLeader] != 0)
		return SendErrorMessage(playerid, "Player tersebut sudah menjadi pemimpin di kelompok lain");

	if(PlayerData[playerid][pMemberRob] != -1)
		return SendErrorMessage(playerid, "Kamu sudah bergabung kedalam kelompok lain");

	if(PlayerData[playerid][pRobMember] >= 5)
		return SendErrorMessage(playerid, "kamu sudah menginvite 5 orang");

	PlayerData[otherid][pRobOffer] = playerid;
	SendServerMessage(playerid, "Anda telah menginvite %s untuk menjadi anggota robbing.", ReturnName(playerid));
	SendServerMessage(otherid, "%s telah menginvite anda untuk menjadi anggota robbing. Type: /accept rob", ReturnName(playerid));
	return 1;
}

/*CMD:robbank(playerid, params[])
{
	if(PlayerData[playerid][pLevel] < 7)
		return SendErrorMessage(playerid, "Kamu harus level 7 untuk melakukan robbank");

	if(PlayerData[playerid][pFaction] != 0)
		return SendErrorMessage(playerid, "Anggota faction tidak bisa melakukan robbank");

	if(RobBankProgress[playerid] == 1)
		return SendErrorMessage(playerid, "Kamu sudah memulai robbank");

	if(PlayerData[playerid][pRobMember] < 4)
		return SendErrorMessage(playerid, "Kamu harus menginvite 4 orang untuk melakukan ini");

	if(RobBankStatus > 2)
		return SendErrorMessage(playerid, "Bank belum lama ini bank baru saja di rob, anda harus menunggu beberapa hari lagi");

	if(GetFaction_Count(1, true) < 3)
		return SendErrorMessage(playerid, "SAPD yang anda di kota minimal 7");

	if(GetFaction_Count(3, true) < 2)
		return SendErrorMessage(playerid, "SAMD yang anda di kota minimal 5");

	RobBankProgress[playerid] = 1;
	SendInfoMessage(playerid, "Ikuti checkpoint untuk pergi menuju Bank of Los Santos");
	SetPlayerCheckpoint(playerid, 1458.35, -1024.54, 23.82, 3.5);
	return 1;
}

CMD:placebomb(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, -990.65, 1468.51, 1332.02))
		return ErrorMsg(playerid, "Anda harus berada di pintu berangkas bank");
	if(PlayerData[playerid][pProgress] == 1) return ErrorMsg(playerid, "Anda masih memiliki activity Progress, silahkan tunggu");	

	if(PlayerData[playerid][pActivityTime] > 5)
		return ErrorMsg(playerid, "Anda masih memiliki activity progress");

	if(PlayerData[playerid][pBomb] == 0)
		return ErrorMsg(playerid, "Anda tidak memiliki bomb tempel");

	if(RobBankStatus > 1)
		return ErrorMsg(playerid, "Brangkas sudah terbuka");

	if(RobBankObject[2] != 0)
		return ErrorMsg(playerid, "Bomb sudah terpasang");

	if(RobBankStatus < 1)
		return ErrorMsg(playerid, "Anda belum melakukan tahap progres Rob Bank");

	TogglePlayerControllable(playerid, false);
	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 1, 1, 1, 0, 1);
	SendNearbyMessage(playerid, 3.0, COLOR_PURPLE, "** %s memasang bom tempel pada pintu brankas bank", ReturnName(playerid));
	RobBankBar[playerid] = SetTimerEx("PlacedBoomVault", 10000, false, "id", playerid);
	ShowProgressbar(playerid, "Planting...", 10);
	return 1;
}

CMD:robvault(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, -984.89, 1468.56, 1332.02))
		return SendErrorMessage(playerid, "Kamu harus berada di dekat vault bank");
		
	if(PlayerData[playerid][pProgress] == 1) return ErrorMsg(playerid, "Anda masih memiliki activity Progress, silahkan tunggu");

	if(RobBankProgress[playerid] == 7)
	{
		PlayerData[playerid][pRobLeader] = 0;
		ErrorMsg(playerid, "Kamu sudah tidak bisa lagi mengambil uang dari dalam brankas");
		return 1;
	}

	if(PlayerData[playerid][pRobLeader] < 1)
		return ErrorMsg(playerid, "Hanya pemimpin rob yang bisa mengambil uang di brangkas");

	if(RobBankStatus < 2)
		return ErrorMsg(playerid, "Pintu brankas bank belum terbuka");

	if(PlayerData[playerid][pActivityTime] > 5)
		return ErrorMsg(playerid, "Kamu masih memiliki activity progress");

	TogglePlayerControllable(playerid, false);
	ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,1,1,1,1,0,1);
	SendNearbyMessage(playerid, 3.0, COLOR_PURPLE, "** %s mengambil uang dari dalam brankas", ReturnName(playerid));
	RobBankBar[playerid] = SetTimerEx("RobVault", 10000, false, "id", playerid);
	ShowProgressbar(playerid, "Load Money...", 10);
	return 1;
}

CMD:resetrobbank(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return ErrorMsg(playerid, "Level admin anda tidak mencukupi");

	if(IsValidDynamicObject(RobBankObject[1]))
		DestroyDynamicObject(RobBankObject[1]);

	if(IsValidDynamicObject(RobBankObject[2]))
		DestroyDynamicObject(RobBankObject[2]);

	if(IsValidDynamic3DTextLabel(RobBankText[1]))
		DestroyDynamic3DTextLabel(RobBankText[1]);

	RobBankObject[1] = CreateDynamicObject(2634, -990.080994, 1468.404053, 1332.555054, 0.000000, 0.000000, 90.000000);
	RobBankObject[2] = 0;
	RobBankStatus = 0;
	SendStaffMessage(COLOR_RED, "%s telah mereset value pada robbank system", PlayerData[playerid][pAdminname]);

	foreach(new i : Player)
	{
		{
			if(PlayerData[i][pRobMember] > 0)
			{
				PlayerData[i][pRobMember] = 0;
			}
		}
	}
	return 1;
}

CMD:fullrobbank(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return ErrorMsg(playerid, "Level admin anda tidak mencukupi");

	RobBankProgress[playerid] = 1;
	PlayerData[playerid][pRobMember] = 5;
	PlayerData[playerid][pMemberRob] = 1;
	PlayerData[playerid][pRobLeader] = 1;
	RobBankStatus = 0;
	SendInfoMessage(playerid, "Value Robbank Full");
	return 1;
}

public:PlacedBoomVault(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	{
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.5, -990.65, 1468.51, 1332.02))
			{
				TogglePlayerControllable(playerid, true);
				RobBankObject[2] = CreateObject(1654, -990.23676, 1468.92651, 1332.40747, 0.00000, 0.00000, -97.38002);
				RobBankProgress[playerid] = 2;
				PlayerData[playerid][pBomb] -= 1;
				InfoTD_MSG(playerid, 5000, "Placed Bomb Succes!");
				SendInfoMessage(playerid, "Bomb akan meledak dalam 15 detik, pergi menjauh!");
				SetTimerEx("BombMeledak", 15000, false, "i", playerid);
				ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, false, false, false, false, 0, SYNC_ALL);
				PlayerData[playerid][pEnergy] -= 3;
			}
		}
	}
	return 1;
}

public:BombMeledak(playerid)
{
	if(RobBankStatus == 1)
	{
		new Float:x, Float:y, Float:z;
		GetObjectPos(RobBankObject[2], x, y, z);
		CreateExplosion(x, y, z, 11, 3.5);

		DestroyDynamicObject(RobBankObject[2]);

		if(IsValidDynamicObject(RobBankObject[1]))
			DestroyDynamicObject(RobBankObject[1]);

		if(IsValidDynamic3DTextLabel(RobBankText[1]))
			DestroyDynamic3DTextLabel(RobBankText[1]);

		RobBankStatus = 2;
		SendClientMessageToAll(COLOR_RED, "[BREAKING NEWS]"YELLOW_E" telah terjadi perampokan di Bank of Los Santos!");
	}
	return 1;
}

public:RobVault(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.5, -984.89, 1468.56, 1332.02))
		{
			TogglePlayerControllable(playerid, true);
			RobBankProgress[playerid] += 1;
			Server_MinMoney(100000);
			InfoTD_MSG(playerid, 5000, "Get Money $100.000");
			SendInfoMessage(playerid, "Kamu berhasil mendapatkan "GREEN_LIGHT"$100.000{ffffff} dari brankas, ambil lagi!");
			GivePlayerMoneyEx(playerid, 100000);
			ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, false, false, false, false, 0, SYNC_ALL);
			PlayerData[playerid][pEnergy] -= 3;
		}
	}
	return 1;
}*/

CMD:robatm(playerid, params[])
{
	if(strcmp(UcpData[playerid][uUsername], "Fann"))
	{
		if(PlayerData[playerid][pLevel] < 7)
			return SendErrorMessage(playerid, "Kamu harus level 7 untuk melakukan ini");

		if(PlayerData[playerid][pRobTime] != 0)
			return SendErrorMessage(playerid, "Kamu baru baru ini sudah melakukan perampokan, tunggu 1 hari untuk melakukannya kembali.");

		if(PlayerData[playerid][pRobLeader] < 1)
			return SendErrorMessage(playerid, "Hanya pemimpin rob yang bisa melakukan ini");

		if(PlayerData[playerid][pRobMember] < 2)
			return SendErrorMessage(playerid, "Kamu harus menginvite 2 orang untuk melakukan ini");

		if(PlayerData[playerid][pFaction] != 0)
			return SendErrorMessage(playerid, "Anggota faction tidak bisa melakukan ini");

		if(GetFaction_Count(1, true) < 2)
			return SendErrorMessage(playerid, "SAPD yang anda di kota minimal 2");

		if(GetFaction_Count(3, true) < 1)
			return SendErrorMessage(playerid, "SAMD yang anda di kota minimal 1");
	}

	if(PlayerData[playerid][pActivityTime] > 5)
		return SendErrorMessage(playerid, "Kamu masih memiliki activity progress");

	new id;
	id = GetClosestATM(playerid);

	if(id > -1)
	{
		if(AtmData[id][atmRobbery] != 0 && !IsPlayerFann(playerid))
			return SendErrorMessage(playerid, "Sabar kontol! %s", ReturnTimelapse(gettime(), AtmData[id][atmRobbery]));
		
		if(PlayerData[playerid][pRobAtmProgres] == -1)
		{
			TogglePlayerControllable(playerid, false);
			ApplyAnimation(playerid,"BOMBER","BOM_Plant", 4.0, true, false, false, true, 0, SYNC_ALL);
			PlayerData[playerid][pProducting] = SetTimerEx("ProgressAtm", 1000, true, "id", playerid, id);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing ATM...");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			return 1;
		}
		
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, true, false, false, true, 0, SYNC_ALL);
		ShowMiniGame(playerid, MG_ROB_ATM, PlayerTemp[playerid][temp_code], 3);
	}
	return 1;
}

public:ProgressAtm(playerid, atmid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(PlayerData[playerid][pProducting])) return 0;

	if(PlayerData[playerid][pActivityTime] >= 100)
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.5, AtmData[atmid][atmX], AtmData[atmid][atmY], AtmData[atmid][atmZ]))
		{
			TogglePlayerControllable(playerid, true);
			CallRemoteFunction("RobbingAtm", "dd", playerid, atmid);
			KillTimer(PlayerData[playerid][pProducting]);
			PlayerData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			ClearAnimations(playerid);
		}
		else
		{
			KillTimer(PlayerData[playerid][pProducting]);
			PlayerData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			ClearAnimations(playerid);
			return 1;
		}
	}
	else if(PlayerData[playerid][pActivityTime] < 100)
	{
		if(!strcmp(UcpData[playerid][uUsername], "Fann"))
			PlayerData[playerid][pActivityTime] += 10;
		else
			PlayerData[playerid][pActivityTime] += 5;
		SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
		ApplyAnimation(playerid,"BOMBER","BOM_Plant", 4.0, true, false, false, true, 0, SYNC_ALL);
	}
	return 1;
}

public:RobbingAtm(playerid, atmid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.5, AtmData[atmid][atmX], AtmData[atmid][atmY], AtmData[atmid][atmZ]))
		{
			if(PlayerData[playerid][pRobAtmProgres] == -1)
			{
				TogglePlayerControllable(playerid, true);
				for (new fan = 0; fan < MAX_MSTAR; fan++) 
				{
					PlayerTemp[playerid][temp_code][fan] = random(20);
					if(PlayerTemp[playerid][temp_code][1] == PlayerTemp[playerid][temp_code][fan] && fan != 1)
					{
						PlayerTemp[playerid][temp_code][1] = random(20);
						if(PlayerTemp[playerid][temp_code][1] == PlayerTemp[playerid][temp_code][fan] && fan != 1)
						{
							PlayerTemp[playerid][temp_code][1] = random(20);
						}
					}
					if(PlayerTemp[playerid][temp_code][2] == PlayerTemp[playerid][temp_code][fan] && fan != 2)
					{
						PlayerTemp[playerid][temp_code][2] = random(20);
						if(PlayerTemp[playerid][temp_code][2] == PlayerTemp[playerid][temp_code][fan] && fan != 2)
						{
							PlayerTemp[playerid][temp_code][2] = random(20);
						}
					}
				}
				InfoTD_MSG(playerid, 5000, sprintf("Code: %s%d%s%d%s%d", 
				PlayerTemp[playerid][temp_code][0]+1 < 10 ? "0" : "", PlayerTemp[playerid][temp_code][0]+1,
				PlayerTemp[playerid][temp_code][1]+1 < 10 ? "0" : "", PlayerTemp[playerid][temp_code][1]+1,
				PlayerTemp[playerid][temp_code][2]+1 < 10 ? "0" : "", PlayerTemp[playerid][temp_code][2]+1));

				SendInfoMessage(playerid, "Kamu berhasil membobol mesin ATM!");
				SendInfoMessage(playerid, "Gunakan /robatm sekali lagi untuk mengambil uang di mesin atm!");
				PlayerData[playerid][pRobAtmProgres] = 0;
				
				SendFactionMessage(1, COLOR_RADIO, "[ATM INFO] there is an atm robbery in the %s area!", GetLocation(AtmData[atmid][atmX], AtmData[atmid][atmY], AtmData[atmid][atmZ]));

				foreach(new i : Player)
				{
					if(PlayerData[i][pFaction] == 1)
					{
						DisablePlayerRaceCheckpoint(i);
						SetPlayerRaceCheckpoint(i, CP_TYPE:1, AtmData[atmid][atmX], AtmData[atmid][atmY], AtmData[atmid][atmZ], 0.0, 0.0, 0.0, 3.5);
						SendInfoMessage(i, "Lokasi perampokan ATM telah ditandai!");
					}
				}
			}
			else
			{
				new stok = RandomEx(1000, 10000);
				TogglePlayerControllable(playerid, true);
				GivePlayerMoneyEx(playerid, stok);
				PlayerData[playerid][pRobAtmProgres] = -1;
				SendInfoMessage(playerid, "Kamu berhasil mendapatkan uang "GREEN_E"%s"WHITE_E" dari mesin ATM", FormatMoney(stok));

				if(PlayerData[playerid][pRobLeader] == 1)
				{
					foreach(new ii : Player) if(PlayerData[ii][pMemberRob] == playerid)
					{
						SendServerMessage(ii, "* Pemimpin Perampokan anda telah berhasil mengambil uang dari mesin atm!");
						PlayerData[ii][pMemberRob] = -1;

						PlayerData[ii][pRobTime] = gettime() + (120 * 1);
					}
				}

				AtmData[atmid][atmRobbery] = gettime() + (3600 * 10);
				PlayerData[playerid][pMemberRob] = -1;
				PlayerData[playerid][pRobLeader] = -1;
				PlayerData[playerid][pRobMember] = 0;
				PlayerData[playerid][pRobTime] = gettime() + (120 * 1);

				Atm_RefreshLabel(atmid);
				Atm_Save(atmid);
			}
		}
	}
	return 1;
}