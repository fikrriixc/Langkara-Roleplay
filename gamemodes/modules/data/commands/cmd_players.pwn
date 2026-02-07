//-------------[ Player Commands ]-------------//
CMD:help(playerid, params[])
{
	new str[512], info[512];
	format(str, sizeof(str), "Account Commands\nGeneral Commands\nVehicle Commands\nJob Commands\nFaction/Family Commands\nAuto RP\nBusiness Commands\nHouse Commands\nWorkshop Commands\nBoombox Command\nDonate\nServer Credits\n");
	strcat(info, str);
	if(PlayerData[playerid][pRobLeader] > 0 || PlayerData[playerid][pMemberRob] > -1)
	{
		format(str, sizeof(str), "Robbery Commands");
		strcat(info, str);	
	}
	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Help Menu", info, "Select", "Close");
	return 1;
}

CMD:changepass(playerid)
{
    if(PlayerData[playerid][IsLoggedIn] == false)
		return SendErrorMessage(playerid, "Kamu harus login sebelum menggantinya!");

	ShowPlayerDialog(playerid, DIALOG_PASSWORD, DIALOG_STYLE_INPUT, ""WHITE_E"Change your password", "Masukkan Password untuk menggantinya!", "Change", "Exit");
	InfoTD_MSG(playerid, 3000, "~g~~h~Masukkan password yang sebelum nya anda pakai!");
	return 1;
}

CMD:destroycp(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return SendErrorMessage(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini!");

	if(PlayerData[playerid][pSideJob] > 1 || PlayerData[playerid][pCP] > 1)
		return SendErrorMessage(playerid, "Harap selesaikan Pekerjaan mu terlebih dahulu!");

	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	SendServerMessage(playerid, "Menghapus Checkpoint Sukses");
	return 1;
}

CMD:credits(playerid)
{
	new line1[1200], line2[300], line3[500];
	strcat(line3, ""LB_E"Coder: "YELLOW_E"HopePride Developer\n");
	strcat(line3, ""LB_E"Helped by: "YELLOW_E"Administrator Team\n");
	strcat(line3, ""LB_E"Managed by: "YELLOW_E"Vall, Fann\n");
	strcat(line3, ""LB_E"Support Mapper: "YELLOW_E"HopePride Mapper\n");
	strcat(line3, ""LB_E"Support Website: "YELLOW_E"Fann\n");
	format(line2, sizeof(line2), ""LB_E"Server Support: "YELLOW_E"%s & All SA-MP Team\n\n\
	"GREEN_E"Terima kasih telah bergabung dengan kami! Copyright - HP:RP 2025 | Fann.", PlayerData[playerid][pName]);
	format(line1, sizeof(line1), "%s%s", line3, line2);
   	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Server Credits", line1, "OK", "");
	return 1;
}

CMD:starterpack(playerid, params[])
{
	if(PlayerData[playerid][pClaimed])
		return SendErrorMessage(playerid, "Tidak dapat mengambil 2x starterpack!");

	new fanid;
	if((fanid = Vehicle_Create(playerid, 468, random(255), random(255), 2500, true)) == -1)
		return 1;

	PlayerData[playerid][pClaimed] = true;
	Inventory_Add(playerid, "Snack", 5);
	Inventory_Add(playerid, "Mineral Water", 5);
	PlayerData[playerid][pBankMoney] += 5000;

	UpdatePlayerData(playerid);

	clearchat(playerid);
	SendInfoMessage(playerid, "Kamu telah melakukan pengambilan starterpack!");
	SendInfoMessage(playerid, "Reward yang kamu dapat :");
	SendClientMessage(playerid, ARWIN, "----------------------------------------");
	SendClientMessage(playerid, ARWIN, "{0077ff}1. {ffffff}Snack & Mineral Water: 5");
	SendClientMessage(playerid, ARWIN, "{0077ff}2. {ffffff}Bank Balance: {00ff00}$5.000");
	SendClientMessage(playerid, ARWIN, "{0077ff}3. {ffffff}Motor Sanchez");
	SendClientMessage(playerid, ARWIN, "----------------------------------------");

	SendServerMessage(playerid, "Pembelian ponsel terdapat pada {ffff00}Bisnis dengan Tipe Market{ffffff}.");

	SetTimerEx("PutInToVeh", 500, false, "dd", playerid, fanid);
	return 1;
}

public:PutInToVeh(playerid, fanid)
{
	if(IsValidVehicle(VehicleData[fanid][cVeh]))
		PutPlayerInVehicle(playerid, VehicleData[fanid][cVeh], 0);

	return 1;
}

CMD:vip(playerid)
{
	new longstr2[3500];
	strcat(longstr2, ""RED_E"...:::... "DOOM_"VIP Donate List HopePride Roleplay "RED_E"...:::...\n");
    strcat(longstr2, "Kamu dapat membeli di discord kami!");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "VIP SYSTEM", longstr2, "Close", "");
	return 1;
}

CMD:donate(playerid)
{
    new line3[3500];
    strcat(line3, ""RED_E"...:::... "DOOM_"Donate List HopePride Roleplay "RED_E"...:::...\n");
    strcat(line3, "Kamu dapat membeli di discord kami!");

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "DONATE LIST", line3, "Okay", "");
	return 1;
}

CMD:togphone(playerid)
{
	if(IsAtEvent[playerid] == 1)
		return SendErrorMessage(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(PlayerData[playerid][pPhone] == 0) return SendErrorMessage(playerid, "Anda tidak memiliki Ponsel!");
	if(PlayerData[playerid][pUsePhone] == 1)
	{
		PlayerData[playerid][pUsePhone] = 0;
		PlayerData[playerid][pTogPhone] = 0;
		SendServerMessage(playerid, "Berhasil mematikan Handphone");
		return 0;
	}
	if(PlayerData[playerid][pUsePhone] == 0)
	{
		PlayerData[playerid][pUsePhone] = 1;
		SendServerMessage(playerid, "Berhasil menyalakan Handphone");
		return 0;
	}
	return 1;
}

CMD:email(playerid)
{
    if(PlayerData[playerid][IsLoggedIn] == false)
		return SendErrorMessage(playerid, "Kamu harus login!");

	ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, ""WHITE_E"Set Email", ""WHITE_E"Masukkan Email.\nIni akan digunakan sebagai ganti kata sandi.\n\n"RED_E"* "WHITE_E"Email mu tidak akan termunculkan untuk Publik\n"RED_E"* "WHITE_E"Email hanya berguna untuk verifikasi Password yang terlupakan dan berita lainnya\n\
	"RED_E"* "WHITE_E"Be sure to double-check and enter a valid email address!", "Enter", "Exit");
	return 1;
}

CMD:savestats(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return SendErrorMessage(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(PlayerData[playerid][IsLoggedIn] == false)
		return SendErrorMessage(playerid, "Kamu belum login!");
		
	UpdatePlayerData(playerid);
	SendServerMessage(playerid, "Statistik Anda sukses disimpan kedalam Database!");
	return 1;
}

CMD:gshop(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return SendErrorMessage(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new Dstring[512];
	format(Dstring, sizeof(Dstring), "Gold Shop\tPrice\n\
	Instant Change Name\t500 Gold\n");
	format(Dstring, sizeof(Dstring), "%sClear Warning\t1000 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 1(7 Days)\t150 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 2(7 Days)\t250 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 3(7 Days)\t500 Gold\n", Dstring);
	ShowPlayerDialog(playerid, DIALOG_GOLDSHOP, DIALOG_STYLE_TABLIST_HEADERS, "Gold Shop", Dstring, "Buy", "Cancel");
	return 1;
}

CMD:mypos(playerid, params[])
{
	new int, Float:px,Float:py,Float:pz, Float:a;
	GetPlayerPos(playerid, px, py, pz);
	GetPlayerFacingAngle(playerid, a);
	int = GetPlayerInterior(playerid);
	SendClientMessage(playerid, COLOR_WHITE, "Lokasi Anda Saat Ini: %s (%0.2f, %0.2f, %0.2f, %0.2f) Int = %d", GetLocation(px, py, pz), px, py, pz, a, int);
	return 1;
}

CMD:death(playerid, params[])
{
    if(PlayerData[playerid][pInjured] == 0)
        return SendErrorMessage(playerid, "Kamu belum injured.");
		
	if(PlayerData[playerid][pJail] > 0)
		return SendErrorMessage(playerid, "Kamu tidak bisa menggunakan ini saat diJail!");
		
	if(PlayerData[playerid][pArrest] > 0)
		return SendErrorMessage(playerid, "Kamu tidak bisa melakukan ini saat tertangkap polisi!");

    if((gettime()-GetPVarInt(playerid, "GiveUptime")) < 100)
        return SendErrorMessage(playerid, "Kamu harus menunggu 3 menit untuk kembali kerumah sakit");
        
	if(GetFaction_Count(3, false) > 0)
		return SendErrorMessage(playerid, "Kamu tidak menggunakan command ini ketika ada EMS!");
	
    SendServerMessage(playerid, "Kamu telah terbangun dari pingsan.");
	PlayerData[playerid][pHospitalTime] = 0;
	PlayerData[playerid][pHospital] = 1;
    return 1;
}

CMD:health(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return SendErrorMessage(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new hstring[512], info[512];
	new hh = PlayerData[playerid][pHead];
	new hp = PlayerData[playerid][pPerut];
	new htk = PlayerData[playerid][pRHand];
	new htka = PlayerData[playerid][pLHand];
	new hkk = PlayerData[playerid][pRFoot];
	new hkka = PlayerData[playerid][pLFoot];
	format(hstring, sizeof(hstring),"Bagian Tubuh\tKondisi\n{ffffff}Kepala\t{7fffd4}%d.0%\n{ffffff}Perut\t{7fffd4}%d.0%\n{ffffff}Tangan Kanan\t{7fffd4}%d.0%\n{ffffff}Tangan Kiri\t{7fffd4}%d.0%\n",hh,hp,htk,htka);
	strcat(info, hstring);
    format(hstring, sizeof(hstring),"{ffffff}Kaki Kanan\t{7fffd4}%d.0%\n{ffffff}Kaki Kiri\t{7fffd4}%d.0%\n",hkk,hkka);
    strcat(info, hstring);
    ShowPlayerDialog(playerid, DIALOG_HEALTH, DIALOG_STYLE_TABLIST_HEADERS,"Health Condition",info,"Oke","");
    return 1;
}

CMD:sleep(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return SendErrorMessage(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(PlayerData[playerid][pInjured] == 1)
        return SendErrorMessage(playerid, "Kamu tidak bisa melakukan ini disaat yang tidak tepat!");
	
	if(PlayerData[playerid][pInHouse] == -1)
		return SendErrorMessage(playerid, "Kamu tidak berada didalam rumah.");
	
	InfoTD_MSG(playerid, 10000, "Sleeping... Harap Tunggu");
	TogglePlayerControllable(playerid, false);
	new time = (100 - PlayerData[playerid][pEnergy]) * (400);
    SetTimerEx("UnfreezeSleep", time, false, "i", playerid);
	switch(random(6))
	{
		case 0: ApplyAnimation(playerid, "INT_HOUSE", "BED_In_L",4.1,false,false,false,true,1);
		case 1: ApplyAnimation(playerid, "INT_HOUSE", "BED_In_R",4.1,false,false,false,true,1);
		case 2: ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_L",4.1,true,false,false,true,1);
		case 3: ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_R",4.1,true,false,false,true,1);
		case 4: ApplyAnimation(playerid, "INT_HOUSE", "BED_Out_L",4.1,false,true,true,false,0);
		case 5: ApplyAnimation(playerid, "INT_HOUSE", "BED_Out_R",4.1,false,true,true,false,0);
	}
	return 1;
}

CMD:time(playerid)
{
	if(PlayerData[playerid][IsLoggedIn] == false)
		return SendErrorMessage(playerid, "Kamu harus login!");
		
	new line2[1200],
			drivelic[64],
			robtime[64];

	new paycheck = 3600 - PlayerData[playerid][pPaycheck];
	if(paycheck < 1)
	{
		paycheck = 0;
	}

	if(PlayerData[playerid][pDriveDelay] != 0)
	{
		format(drivelic, sizeof(drivelic), "{FFFF00}%s remaining", ReturnTimelapse(gettime(), PlayerData[playerid][pDriveDelay]));
	}
	else
		drivelic = "{00ff00}Available";
	
	if(PlayerData[playerid][pRobTime] != 0)
	{
		format(robtime, sizeof(robtime), "{FFFF00}%s remaining", ReturnTimelapse(gettime(), PlayerData[playerid][pRobTime]));
	}
	else
		drivelic = "{00ff00}Available";

	format(line2, sizeof(line2), ""WHITE_E"Paycheck Time: "YELLOW_E"%d remaining\n"WHITE_E"Delay Drive-Lic: %s\n"WHITE_E"Delay Robbery: %s\n"WHITE_E"Delay Job: "RED_E"%d Detik\n"WHITE_E"Delay Side Job: "RED_E"%d Detik\n"WHITE_E"Plant Time(Farmer): "RED_E"%d Detik\n"WHITE_E"Arrest Time: "RED_E"%d Detik\n"WHITE_E"Jail Time: "RED_E"%d Detik\n", paycheck, drivelic, robtime, PlayerData[playerid][pJobTime], PlayerData[playerid][pSideJobTime], PlayerData[playerid][pPlantTime], PlayerData[playerid][pArrestTime], PlayerData[playerid][pJailTime]);
   	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Time", line2, "Oke", "");
	return 1;
}

CMD:idcard(playerid, params[])
{
	if(PlayerData[playerid][pIDCard] == 0) return SendErrorMessage(playerid, "Anda tidak memiliki id card!");
	new sext[40];
	if(PlayerData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	SendNearbyMessage(playerid, 20.0, COLOR_GREEN, "[ID-Card] "GREY3_E"Name: %s | Gender: %s | Birthday: %s | Expire: %s.", PlayerData[playerid][pName], sext, PlayerData[playerid][pAge], ReturnTimelapse(gettime(), PlayerData[playerid][pIDCardTime]));
	return 1;
}

CMD:drivelic(playerid, params[])
{
	if(PlayerData[playerid][pDriveLic] == 0) return SendErrorMessage(playerid, "Anda tidak memiliki Driving License/SIM!");
	new sext[40];
	if(PlayerData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	SendNearbyMessage(playerid, 20.0, COLOR_GREEN, "[Drive-Lic] "GREY3_E"Name: %s | Gender: %s | Birthday: %s | Expire: %s.", PlayerData[playerid][pName], sext, PlayerData[playerid][pAge], PlayerData[playerid][pDriveLicTime] == 0 ? "Expired, Renew it now" : ReturnTimelapse(gettime(), PlayerData[playerid][pDriveLicTime]));
	return 1;
}

CMD:newidcard(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1396.2109, -4.3407, 1000.8535)) return SendErrorMessage(playerid, "Anda harus berada di City Hall!");
	if(PlayerData[playerid][pIDCard] != 0) return SendErrorMessage(playerid, "Anda sudah memiliki ID Card!");
	if(GetPlayerMoney(playerid) < 50) return SendErrorMessage(playerid, "Anda butuh $50 untuk membuat ID Card");
	new sext[40], mstr[128];
	if(PlayerData[playerid][pGender] == 1) { sext = "Laki-Laki"; } else { sext = "Perempuan"; }
	format(mstr, sizeof(mstr), "{FFFFFF}Nama: %s\nNegara: San Andreas\nTgl Lahir: %s\nJenis Kelamin: %s\nBerlaku hingga 14 hari!", PlayerData[playerid][pName], PlayerData[playerid][pAge], sext);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "ID-Card", mstr, "Tutup", "");
	PlayerData[playerid][pIDCard] = 1;
	PlayerData[playerid][pIDCardTime] = gettime() + (15 * 86400);
	GivePlayerMoneyEx(playerid, -50);
	Server_AddMoney(50);
	return 1;
}

CMD:newage(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1396.2109, -4.3407, 1000.8535)) return SendErrorMessage(playerid, "Anda harus berada di City Hall!");
	//if(PlayerData[playerid][pIDCard] != 0) return SendErrorMessage(playerid, "Anda sudah memiliki ID Card!");
	if(GetPlayerMoney(playerid) < 300) return SendErrorMessage(playerid, "Anda butuh $300 untuk mengganti tgl lahir anda!");
	if(PlayerData[playerid][IsLoggedIn] == false) return SendErrorMessage(playerid, "Anda harus login terlebih dahulu!");
	ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Change", "Cancel");
	return 1;
}

CMD:payticket(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 246.45, 118.53, 1003.21)) return SendErrorMessage(playerid, "Anda harus berada di kantor SAPD!");
	
	new vehid;
	if(sscanf(params, "d", vehid))
		return SendSyntaxMessage(playerid, "/payticket [vehid] | /v insu(/myinsu) - for find vehid");
		
	if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
		return SendErrorMessage(playerid, "Invalid id");
		
	foreach(new i : PlayerVehicles)
	{
		if(vehid == VehicleData[i][cID])
		{
			if(VehicleData[i][cOwner] == PlayerData[playerid][pID])
			{
				new ticket = VehicleData[i][cTicket];
				
				if(ticket > GetPlayerMoney(playerid))
					return SendErrorMessage(playerid, "Not enough money! check your ticket in /v insu.");
					
				if(ticket > 0)
				{
					GivePlayerMoneyEx(playerid, -ticket);
					VehicleData[i][cTicket] = 0;
					SendInfoMessage(playerid, "Anda telah berhasil membayar ticket tilang kendaraan %s(id: %d) sebesar "RED_E"%s", GetVehicleName(vehid), vehid, FormatMoney(ticket));
					return 1;
				}
			}
			else return SendErrorMessage(playerid, "Kendaraan ini bukan milik anda! /v insu(/myinsu) - for find vehid");
		}
	}
	return 1;
}

CMD:buyplate(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 240.80, 112.95, 1003.21)) return SendErrorMessage(playerid, "Anda harus berada di SAPD!");
		
	new vehid;
	if(sscanf(params, "d", vehid)) return SendSyntaxMessage(playerid, "/buyplate [vehid] | /v my(/mypv) - for find vehid");
	
	if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
		return SendErrorMessage(playerid, "Invalid id");
			
	foreach(new i : PlayerVehicles)
	{
		if(vehid == VehicleData[i][cVeh])
		{
			if(VehicleData[i][cOwner] == PlayerData[playerid][pID])
			{
				if(VehicleData[i][cPlateTime] != 0) return SendErrorMessage(playerid, "Masa aktif plate masih berlaku!");
				if(GetPlayerMoney(playerid) < 500) return SendErrorMessage(playerid, "Anda butuh $500 untuk membeli Plate baru.");
				GivePlayerMoneyEx(playerid, -500);
				new rand = RandomEx(1111, 9999);
				format(VehicleData[i][cPlate], 32, "HP-%d", rand);
				SetVehicleNumberPlate(VehicleData[i][cVeh], VehicleData[i][cPlate]);
				VehicleData[i][cPlateTime] = gettime() + (15 * 86400);
				SendInfoMessage(playerid, "Model: %s || New plate: %s || Plate Time: %s || Plate Price: $500", GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cPlate], ReturnTimelapse(gettime(), VehicleData[i][cPlateTime]));
			}
			else return SendErrorMessage(playerid, "ID kendaraan ini bukan punya mu! gunakan /v my(/mypv) untuk mencari ID.");
		}
	}
	return 1;
}

CMD:buyinsu(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1133.8127, -1808.4134, 1241.9125)) return SendErrorMessage(playerid, "Anda harus berada di Insurance Agency!");
		
	new vehid;
	if(sscanf(params, "d", vehid)) return SendSyntaxMessage(playerid, "/buyinsu [vehid] | /v my(mypv) - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "Invalid id");
			
	foreach(new i : PlayerVehicles)
	{
		if(vehid == VehicleData[i][cVeh])
		{
			if(VehicleData[i][cOwner] == PlayerData[playerid][pID] && VehicleData[i][cClaim] == 0)
			{
				if(GetPlayerMoney(playerid) < 500) return SendErrorMessage(playerid, "Anda butuh $500 untuk membeli Insurance.");
				GivePlayerMoneyEx(playerid, -500);
				VehicleData[i][cInsu]++;
				SendInfoMessage(playerid, "Model: %s || Total Insurance: %d || Insurance Price: $500", GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cInsu]);
			}
			else return SendErrorMessage(playerid, "ID kendaraan ini bukan punya mu! gunakan /v my(/mypv) untuk mencari ID.");
		}
	}
	return 1;
}

CMD:claimpv(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1133.8127, -1808.4134, 1241.9125)) return SendErrorMessage(playerid, "Anda harus berada di Insurance Agency!");
	
	new vehid;
	if(sscanf(params, "d", vehid))
		return SendSyntaxMessage(playerid, "/claimpv [vehid] | /v insu(myinsu) - for find vehid");

	foreach(new i : PlayerVehicles)
	{
		if(VehicleData[i][cID] == vehid)
		{
			if(VehicleData[i][cOwner] == PlayerData[playerid][pID])
			{
				if(VehicleData[i][cClaim] == 1 && VehicleData[i][cClaimTime] == 0)
				{
					VehicleData[i][cClaim] = 0;
					
					if(IsAHelicopter(VehicleData[i][cVeh]) || IsAPlane(VehicleData[i][cVeh]))
					{
						switch(random(2))
						{
							case 0:
							{
								VehicleData[i][cPosX] = 1065.3728;
								VehicleData[i][cPosY] = -1801.6561;
								VehicleData[i][cPosZ] = 13.3849;
								VehicleData[i][cPosA] = 87.9305;
							}
							case 1:
							{
								VehicleData[i][cPosX] = 1067.6130;
								VehicleData[i][cPosY] = -1792.6672;
								VehicleData[i][cPosZ] = 13.3642;
								VehicleData[i][cPosA] = 89.1621;
							}
						}
					}
					else if(IsABoat(VehicleData[i][cVeh]))
					{
						switch(random(2))
						{
							case 0:
							{
								VehicleData[i][cPosX] = 937.2368;
								VehicleData[i][cPosY] = -1925.8067;
								VehicleData[i][cPosZ] = 0.2635;
								VehicleData[i][cPosA] = 90.2047;
							}
							case 1:
							{
								VehicleData[i][cPosX] = 943.5432;
								VehicleData[i][cPosY] = -1940.5114;
								VehicleData[i][cPosZ] = 0.3532;
								VehicleData[i][cPosA] = 87.3404;
							}
						}
					}
					else
					{
						switch(random(3))
						{
							case 0:
							{
								VehicleData[i][cPosX] = 1080.4114;
								VehicleData[i][cPosY] = -1769.7536;
								VehicleData[i][cPosZ] = 13.0604;
								VehicleData[i][cPosA] = 91.3388;
							}
							case 1:
							{
								VehicleData[i][cPosX] = 1081.1251;
								VehicleData[i][cPosY] = -1757.7645;
								VehicleData[i][cPosZ] = 13.0877;
								VehicleData[i][cPosA] = 91.2780;
							}
							case 2:
							{
								VehicleData[i][cPosX] = 1081.0792;
								VehicleData[i][cPosY] = -1763.8256;
								VehicleData[i][cPosZ] = 13.0743;
								VehicleData[i][cPosA] = 90.9556;
							}
						}
					}

					OnPlayerVehicleRespawn(i);

					SetTimerEx("LoadAfterInsu", 500, false, "dd", playerid, i);

					SendInfoMessage(playerid, "Anda telah mengclaim {ffff00}%s{ffffff} anda.", GetVehicleModelName(VehicleData[i][cModel]));
				}
				else
					SendErrorMessage(playerid, "Sekarang belum saatnya mengclaim %s anda!", GetVehicleModelName(VehicleData[i][cModel]));
			}
			else 
				SendErrorMessage(playerid, "ID kendaraan ini bukan punya mu! gunakan /v insu(/myinsu) untuk mencari ID.");
			
		}
	}
	return 1;
}

public:LoadAfterInsu(playerid, i)
{
	Vehicle_ObjectUpdateAll(i);

	SetValidVehicleHealth(VehicleData[i][cVeh], 1500);
	SetVehicleFuel(VehicleData[i][cVeh], 100);

	LinkVehicleToInterior(VehicleData[i][cVeh], 0);
	SetVehicleVirtualWorld(VehicleData[i][cVeh], 0);
	SetVehiclePos(VehicleData[i][cVeh], VehicleData[i][cPosX], VehicleData[i][cPosY], VehicleData[i][cPosZ]);
	SetVehicleZAngle(VehicleData[i][cVeh], VehicleData[i][cPosA]);
	return 1;
}

CMD:sellpv(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1133.8127, -1808.4134, 1241.9125)) return SendErrorMessage(playerid, "Anda harus berada di Insurance Agency!");
	
	new vehid;
	if(sscanf(params, "d", vehid)) return SendSyntaxMessage(playerid, "/sellpv [vehid] | /v my(mypv) - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "Invalid id");
			
	foreach(new i : PlayerVehicles)
	{
		if(vehid == VehicleData[i][cVeh])
		{
			if(VehicleData[i][cOwner] == PlayerData[playerid][pID])
			{
				if(!IsValidVehicle(VehicleData[i][cVeh])) return SendErrorMessage(playerid, "Your vehicle is not spanwed!");
				if(VehicleData[i][cRent] != 0) return SendErrorMessage(playerid, "You can't sell rental vehicle!");
				new pay = VehicleData[i][cPrice] / 2;
				GivePlayerMoneyEx(playerid, pay);
				
				SendInfoMessage(playerid, "Anda menjual kendaraan model %s(%d) dengan seharga "LG_E"%s", GetVehicleName(vehid), GetVehicleModel(vehid), FormatMoney(pay));
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", VehicleData[i][cID]);
				mysql_tquery(g_SQL, query);
				if(IsValidVehicle(VehicleData[i][cVeh])) DestroyVehicle(VehicleData[i][cVeh]);
				VehicleData[i][cVeh] = INVALID_VEHICLE_ID;
				Iter_Remove(PlayerVehicles, i);
			}
			else return SendErrorMessage(playerid, "ID kendaraan ini bukan punya mu! gunakan /v my(/mypv) untuk mencari ID.");
		}
	}
	return 1;
}

CMD:newrek(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -982.49, 1448.46, 1340.62)) return SendErrorMessage(playerid, "Anda harus berada di Bank!");
	if(GetPlayerMoney(playerid) < 50) return SendErrorMessage(playerid, "Not enough money!");
	new query[128], rand = RandomEx(111111, 999999);
	new rek = rand+PlayerData[playerid][pID];
	mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
	mysql_tquery(g_SQL, query, "BankRek", "id", playerid, rek);
	SendInfoMessage(playerid, "New rekening bank!");
	GivePlayerMoneyEx(playerid, -50);
	Server_AddMoney(50);
	return 1;
}

CMD:bank(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -983.95, 1448.46, 1340.62)) return SendErrorMessage(playerid, "Anda harus berada di bank point!");
	new tstr[128];
	format(tstr, sizeof(tstr), ""ORANGE_E"No Rek: "LB_E"%d", PlayerData[playerid][pBankRek]);
	ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, tstr, "Deposit Money\nWithdraw Money\nCheck Balance\nTransfer Money\nSign Paycheck", "Select", "Cancel");
	return 1;
}

CMD:pay(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return SendErrorMessage(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new money, otherid, mstr[128];
	if(sscanf(params, "ud", otherid, money))
	{
	    SendSyntaxMessage(playerid, "/pay <ID/Name> <amount>");
	    return true;
	}
	
	if(PlayerData[playerid][pLevel] < 2)
		return SendErrorMessage(playerid, "You must level 2 to pay!");

	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return SendErrorMessage(playerid, "Player disconnect atau tidak berada didekat anda.");

 	if(otherid == playerid)
		return SendErrorMessage(playerid, "You can't send yourself money!");
	if(PlayerData[playerid][pMoney] < money)
		return SendErrorMessage(playerid, "You don't have enough money to send!");
	if(money > 1000000 && PlayerData[playerid][pAdmin] == 0)
		return SendErrorMessage(playerid, "You can't send more than $1,000,000 at once!");
	if(money < 1)
		return SendErrorMessage(playerid, "You can't send anyone less than $1!");
		
	format(mstr, sizeof(mstr), ""WHITEP_E"Are you sure you want to send %s(%d) "GREEN_E"%s?", ReturnName(otherid), otherid, FormatMoney(money));
	ShowPlayerDialog(playerid, DIALOG_PAY, DIALOG_STYLE_MSGBOX, ""GREEN_E"Send Money", mstr, "Send", "Cancel");

	SetPVarInt(playerid, "gcAmount", money);
	SetPVarInt(playerid, "gcPlayer", otherid);
	return 1;
}

CMD:settwittername(playerid, params[])
{
	new aname[128], otherid, query[128], string[63];
	if(sscanf(params, "s[128]", aname))
	{
	    SendSyntaxMessage(playerid, "/settwittername <Twitter name>");
	    return true;
	}
	
	format(string, sizeof(string), "%s", aname);
	PlayerData[otherid][pRegTwitter] = 1;
	mysql_format(g_SQL, query, sizeof(query), "SELECT twittername FROM players WHERE twittername='%s'", aname);
	mysql_tquery(g_SQL, query, "ChangeTwitterName", "is", playerid, aname);
	return 1;
}

CMD:tw(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Sistem Ini tidak dapat digunakan di OOC Zone");

	if(PlayerData[playerid][pPhone] < 1)
		return SendErrorMessage(playerid, "Anda belum memiliki Ponsel");

	if(PlayerData[playerid][pUsePhone] < 1)
		return SendErrorMessage(playerid, "Ponsel anda sedang mati");

    if(!strcmp(PlayerData[playerid][pTwittername], "None"))
		return SendErrorMessage(playerid, "Kamu tidak memiliki nama pada user Twitter mu!");

	if(isnull(params))
	{
	    SendSyntaxMessage(playerid, "/tw <text>");
	    return true;
	}

    // Decide about multi-line msgs
	new i = -1;
	new line[512];
	if(PlayerData[playerid][pPhoneCredit] < 1)
		return SendErrorMessage(playerid, "Phone Credit tidak mencukupi.");

	if(strlen(params) > 70)
	{
		i = strfind(params, " ", false, 60);
		if(i > 80 || i == -1) i = 70;

		// store the second line text
		line = " ";
		strcat(line, params[i]);

		// delete the rest from msg
		params[i] = EOS;
	}
	new mstr[512];
	format(mstr, sizeof(mstr), "{1e90ff}[TWITTER] {7fffd4}@%s :{ffffff}%s", PlayerData[playerid][pTwittername], params);
	PlayerData[playerid][pPhoneCredit] -= 1;
	foreach(new ii : Player) 
	{
		if(PlayerData[ii][pUsePhone] && !PlayerData[ii][pTogLog])
		{
			SendClientMessage(ii, COLOR_LB, mstr);	
		}
	}
	if(i != -1)
	{
		foreach(new ii : Player)
		{
			if(PlayerData[ii][pUsePhone] && !PlayerData[ii][pTogLog])
			{
				SendClientMessage(ii, COLOR_LB, line);
			}
		}
	}
	return true;
}

CMD:stats(playerid, params[])
{
	if(PlayerData[playerid][IsLoggedIn] == false)
	{
	    SendErrorMessage(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	
	DisplayStats(playerid, playerid);
	return 1;
}

CMD:settings(playerid)
{
	if(PlayerData[playerid][IsLoggedIn] == false)
	{
	    SendErrorMessage(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	
	new str[1024], hbemode[64], invmode[64], togpm[64], toglog[64], togads[64], togwt[64];
	if(PlayerData[playerid][pHBEMode] == 1)
	{
		hbemode = ""LG_E"Simple";
	}
	else if(PlayerData[playerid][pHBEMode] == 2)
	{
		hbemode = ""LG_E"Modern";
	}
	else
	{
		hbemode = ""RED_E"Disable";
	}

	if(PlayerData[playerid][pInvMode] == 1)
	{
		invmode = ""LG_E"Dialog";
	}
	else if(PlayerData[playerid][pInvMode] == 2)
	{
		invmode = ""LG_E"Textdraw";
	}
	else
	{
		hbemode = ""RED_E"Disable";
	}
	
	if(PlayerData[playerid][pTogPM] == 0)
	{
		togpm = ""RED_E"Disable";
	}
	else
	{
		togpm = ""LG_E"Enable";
	}
	
	if(PlayerData[playerid][pTogLog] == 0)
	{
		toglog = ""RED_E"Disable";
	}
	else
	{
		toglog = ""LG_E"Enable";
	}
	
	if(PlayerData[playerid][pTogAds] == 0)
	{
		togads = ""RED_E"Disable";
	}
	else
	{
		togads = ""LG_E"Enable";
	}
	
	if(PlayerData[playerid][pTogWT] == 0)
	{
		togwt = ""RED_E"Disable";
	}
	else
	{
		togwt = ""LG_E"Enable";
	}
	
	format(str, sizeof(str), "Settings\tStatus\n"WHITEP_E"Email:\t"GREY3_E"%s\n"WHITEP_E"Change Password\n"WHITEP_E"HBE Mode:\t%s\n"/*"WHITEP_E"Inventory Mode:\t%s\n*/""WHITEP_E"Toggle PM:\t%s\n"WHITEP_E"Toggle Log Server:\t%s\n"WHITEP_E"Toggle Ads:\t%s\n"WHITEP_E"Toggle WT:\t%s",
	PlayerData[playerid][pEmail], 
	hbemode, 
	//invmode,
	togpm,
	toglog,
	togads,
	togwt
	);
	
	ShowPlayerDialog(playerid, DIALOG_SETTINGS, DIALOG_STYLE_TABLIST_HEADERS, "Settings", str, "Set", "Close");
	return 1;
}

CMD:getjob(playerid, params[])
{
	if(PlayerData[playerid][pIDCard] <= 0)
		return SendErrorMessage(playerid, "Kamu tidak memiliki ID-Card.");
		
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		return SendErrorMessage(playerid, "Kamu tidak bisa melalukannya sekarang!");
	
	if(PlayerData[playerid][pJob] == 0 || (PlayerData[playerid][pJob2] == 0 && PlayerData[playerid][pVip] > 0))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, -2159.04, 640.36, 1052.38))
		{
			PlayerData[playerid][pGetJob] = 1;
			SendInfoMessage(playerid, "Anda telah berhasil mendaftarkan job Taxi. /accept job untuk konfirmasi.");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1627.54, -1785.21, 13.52))
		{
			PlayerData[playerid][pGetJob] = 2;
			SendInfoMessage(playerid, "Anda telah berhasil mendaftarkan job mechanic. /accept job untuk konfirmasi.");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, -265.87, -2213.63, 29.04))
		{
			PlayerData[playerid][pGetJob] = 3;
			SendInfoMessage(playerid, "Anda telah berhasil mendaftarkan job lumber jack. /accept job untuk konfirmasi.");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, -77.38, -1136.52, 1.07))
		{
			PlayerData[playerid][pGetJob] = 4;
			SendInfoMessage(playerid, "Anda telah berhasil mendaftarkan job trucker. /accept job untuk konfirmasi.");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 319.94, 874.77, 20.39))
		{
			PlayerData[playerid][pGetJob] = 5;
			SendInfoMessage(playerid, "Anda telah berhasil mendaftarkan job miner. /accept job untuk konfirmasi.");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, -283.02, -2174.36, 28.66))
		{
			PlayerData[playerid][pGetJob] = 6;
			SendInfoMessage(playerid, "Anda telah berhasil mendaftarkan job production. /accept job untuk konfirmasi.");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, -383.67, -1438.90, 26.32))
		{
			PlayerData[playerid][pGetJob] = 7;
			SendInfoMessage(playerid, "Anda telah berhasil mendaftarkan job farmer. /accept job untuk konfirmasi.");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 988.890563, -1349.136962, 13.545228))
		{
			PlayerData[playerid][pGetJob] = 8;
			SendInfoMessage(playerid, "Anda telah berhasil mendaftarkan job kurir. /accept job untuk konfirmasi.");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, 977.34, -771.49, 112.20))
		{
			if(PlayerData[playerid][pLevel] < 5) return SendErrorMessage(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
			PlayerData[playerid][pGetJob] = 12;
			SendInfoMessage(playerid, "Anda telah berhasil mendaftarkan job Smuggler. /accept job untuk konfirmasi.");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, 300.1200, 1141.2943, 9.1374))
		{
			PlayerData[playerid][pGetJob] = 9;
			SendInfoMessage(playerid, "Anda telah berhasil mendaftarkan job Milker. /accept job untuk konfirmasi.");
		}
		else return SendErrorMessage(playerid, "Anda sudah memiliki job atau tidak berada di dekat pendaftaran job.");
	}
	return 1;
}

CMD:frisk(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return SendErrorMessage(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new otherid;
	if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/frisk [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "Player tidak berada didekat mu.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "Kamu tidak bisa memeriksa dirimu sendiri.");

    PlayerData[otherid][pFriskOffer] = playerid;

    SendInfoMessage(otherid, "%s has offered to frisk you (type \"/accept frisk or /deny frisk\").", ReturnName(playerid));
    SendInfoMessage(playerid, "You have offered to frisk %s.", ReturnName(otherid));
	return 1;
}

CMD:inspect(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return SendErrorMessage(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new otherid;
	if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/inspect [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "Player tidak berada didekat mu.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "Kamu tidak bisa memeriksa dirimu sendiri.");

    PlayerData[otherid][pInsOffer] = playerid;

    SendInfoMessage(otherid, "%s has offered to inspect you (type \"/accept inspect or /deny inspect\").", ReturnName(playerid));
    SendInfoMessage(playerid, "You have offered to inspect %s.", ReturnName(otherid));
	return 1;
}

CMD:reqloc(playerid, params[])
{
	new otherid;
	if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/reqloc [playerid/PartOfName]");

    if(PlayerData[playerid][pPhone] < 1)
    	return SendErrorMessage(playerid, "Anda tidak memiliki Handphone");

    if(PlayerData[playerid][pUsePhone] == 0)
    	return SendErrorMessage(playerid, "Ponsel anda masih offline");

    if(PlayerData[otherid][pPhone] < 1)
    	return SendErrorMessage(playerid, "Tujuan tidak memiliki Handphone");

    if(PlayerData[otherid][pUsePhone] == 0)
    	return SendErrorMessage(playerid, "Ponsel yang anda tuju masih offline");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "Kamu tidak bisa meminta lokasi kepada anda sendiri.");

    PlayerData[otherid][pLocOffer] = playerid;

    SendInfoMessage(otherid, "%s has offered to request share his location (type \"/accept reqloc or /deny reqloc\").", ReturnName(playerid));
    SendInfoMessage(playerid, "You have offered to share your location %s.", ReturnName(otherid));
	return 1;
}

CMD:accept(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return SendErrorMessage(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            SendSyntaxMessage(playerid, "USAGE: /accept [name]");
            SendInfoMessage(playerid, "Names: faction, family, drag, frisk, inspect, job, reqloc, rob");
            return 1;
        }
		if(strcmp(params,"faction",true) == 0) 
		{
            if(IsPlayerConnected(PlayerData[playerid][pFacOffer])) 
			{
                if(PlayerData[playerid][pFacInvite] > 0) 
				{
                    PlayerData[playerid][pFaction] = PlayerData[playerid][pFacInvite];
					PlayerData[playerid][pFactionRank] = 1;
					SendInfoMessage(playerid, "Anda telah menerima invite faction dari %s", PlayerData[PlayerData[playerid][pFacOffer]][pName]);
					SendInfoMessage(PlayerData[playerid][pFacOffer], "%s telah menerima invite faction yang anda tawari", PlayerData[playerid][pName]);
					PlayerData[playerid][pFacInvite] = 0;
					PlayerData[playerid][pFacOffer] = -1;
					PlayerData[playerid][pFacSkin] = -1;
				}
				else
				{
					SendErrorMessage(playerid, "Invalid faction id!");
					return 1;
				}
            }
            else 
			{
                SendErrorMessage(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		if(strcmp(params,"family",true) == 0) 
		{
            if(IsPlayerConnected(PlayerData[playerid][pFamOffer])) 
			{
                if(PlayerData[playerid][pFamInvite] > -1) 
				{
                    PlayerData[playerid][pFamily] = PlayerData[playerid][pFamInvite];
					PlayerData[playerid][pFamilyRank] = 1;
					SendInfoMessage(playerid, "Anda telah menerima invite family dari %s", PlayerData[PlayerData[playerid][pFamOffer]][pName]);
					SendInfoMessage(PlayerData[playerid][pFamOffer], "%s telah menerima invite family yang anda tawari", PlayerData[playerid][pName]);
					PlayerData[playerid][pFamInvite] = 0;
					PlayerData[playerid][pFamOffer] = -1;
				}
				else
				{
					SendErrorMessage(playerid, "Invalid family id!");
					return 1;
				}
            }
            else 
			{
                SendErrorMessage(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		else if(strcmp(params,"drag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return SendErrorMessage(playerid, "Player itu Disconnect.");
        
			if(!NearPlayer(playerid, dragby, 5.0))
				return SendErrorMessage(playerid, "Kamu harus didekat Player.");
        
			PlayerData[playerid][pDragged] = 1;
			PlayerData[playerid][pDraggedBy] = dragby;

			PlayerData[playerid][pDragTimer] = SetTimerEx("DragUpdate", 1000, true, "ii", dragby, playerid);
			SendNearbyMessage(dragby, 30.0, COLOR_PURPLE, "* %s grabs %s and starts dragging them, (/undrag).", ReturnName(dragby), ReturnName(playerid));
			return true;
		}
		else if(strcmp(params,"frisk",true) == 0)
		{
			if(PlayerData[playerid][pFriskOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(PlayerData[playerid][pFriskOffer]))
				return SendErrorMessage(playerid, "Player tersebut belum masuk!");
			
			if(!NearPlayer(playerid, PlayerData[playerid][pFriskOffer], 5.0))
				return SendErrorMessage(playerid, "Kamu harus didekat Player.");
				
			Inventory_Show(PlayerData[playerid][pFriskOffer], playerid);
			SendServerMessage(playerid, "Anda telah berhasil menaccept tawaran frisk kepada %s.", ReturnName(PlayerData[playerid][pFriskOffer]));
			PlayerData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"inspect",true) == 0)
		{
			if(PlayerData[playerid][pInsOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(PlayerData[playerid][pFriskOffer]))
				return SendErrorMessage(playerid, "Player tersebut belum masuk!");
			
			if(!NearPlayer(playerid, PlayerData[playerid][pInsOffer], 5.0))
				return SendErrorMessage(playerid, "Kamu harus didekat Player.");
				
			new hstring[512], info[512];
			new hh = PlayerData[playerid][pHead];
			new hp = PlayerData[playerid][pPerut];
			new htk = PlayerData[playerid][pRHand];
			new htka = PlayerData[playerid][pLHand];
			new hkk = PlayerData[playerid][pRFoot];
			new hkka = PlayerData[playerid][pLFoot];
			format(hstring, sizeof(hstring),"Bagian Tubuh\tKondisi\n{ffffff}Kepala\t{7fffd4}%d.0%\n{ffffff}Perut\t{7fffd4}%d.0%\n{ffffff}Tangan Kanan\t{7fffd4}%d.0%\n{ffffff}Tangan Kiri\t{7fffd4}%d.0%\n",hh,hp,htk,htka);
			strcat(info, hstring);
			format(hstring, sizeof(hstring),"{ffffff}Kaki Kanan\t{7fffd4}%d.0%\n{ffffff}Kaki Kiri\t{7fffd4}%d.0%\n",hkk,hkka);
			strcat(info, hstring);
			ShowPlayerDialog(PlayerData[playerid][pInsOffer],DIALOG_HEALTH,DIALOG_STYLE_TABLIST_HEADERS,"Health Condition",info,"Oke","");
			SendServerMessage(playerid, "Anda telah berhasil menaccept tawaran Inspect kepada %s.", ReturnName(PlayerData[playerid][pInsOffer]));
			PlayerData[playerid][pInsOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"job",true) == 0) 
		{
			if(PlayerData[playerid][pGetJob] > 0)
			{
				PlayerData[playerid][pJob] = PlayerData[playerid][pGetJob];
				SendInfoMessage(playerid, "Anda telah berhasil mendapatkan pekerjaan baru. gunakan /help untuk informasi.");
				PlayerData[playerid][pGetJob] = 0;
				PlayerData[playerid][pExitJob] = gettime() + (1 * 86400);
			}
			else if(PlayerData[playerid][pGetJob2] > 0)
			{
				PlayerData[playerid][pJob2] = PlayerData[playerid][pGetJob2];
				SendInfoMessage(playerid, "Anda telah berhasil mendapatkan pekerjaan baru. gunakan /help untuk informasi.");
				PlayerData[playerid][pGetJob2] = 0;
				PlayerData[playerid][pExitJob] = gettime() + (1 * 86400);
			}
		}
		else if(strcmp(params,"reqloc",true) == 0)
		{
			if(PlayerData[playerid][pLocOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(PlayerData[playerid][pLocOffer]))
				return SendErrorMessage(playerid, "Player tersebut belum masuk!");
				
			new Float:sX, Float:sY, Float:sZ;
			GetPlayerPos(playerid, sX, sY, sZ);
			SetPlayerCheckpoint(PlayerData[playerid][pLocOffer], sX, sY, sZ, 5.0);
			SendServerMessage(playerid, "Anda telah berhasil menaccept tawaran Share Lokasi kepada %s.", ReturnName(PlayerData[playerid][pLocOffer]));
			SendServerMessage(PlayerData[playerid][pLocOffer], "Lokasi %s telah tertandai.", ReturnName(playerid));
			PlayerData[playerid][pLocOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"rob",true) == 0)
		{
			if(PlayerData[playerid][pRobOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(PlayerData[playerid][pRobOffer]))
				return SendErrorMessage(playerid, "Player tersebut belum masuk!");
			
			SendServerMessage(playerid, "Anda telah berhasil menaccept tawaran bergabung kedalam Robbery %s.", ReturnName(PlayerData[playerid][pRobOffer]));
			SendServerMessage(PlayerData[playerid][pRobOffer], "%s Menerima ajakan Robbing anda.", ReturnName(playerid));
			PlayerData[PlayerData[playerid][pRobOffer]][pRobMember] += 1;
			PlayerData[playerid][pRobOffer] = INVALID_PLAYER_ID;
			PlayerData[playerid][pMemberRob] = playerid;
		}
	}
	return 1;
}

CMD:deny(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return SendErrorMessage(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            SendSyntaxMessage(playerid, "USAGE: /deny [name]");
            SendInfoMessage(playerid, "Names: faction, drag, frisk, inspect, job1, job2, reqloc, rob");
            return 1;
        }
		if(strcmp(params,"faction",true) == 0) 
		{
            if(PlayerData[playerid][pFacOffer] > -1) 
			{
                if(PlayerData[playerid][pFacInvite] > 0) 
				{
					SendInfoMessage(playerid, "Anda telah menolak faction dari %s", ReturnName(PlayerData[playerid][pFacOffer]));
					SendInfoMessage(PlayerData[playerid][pFacOffer], "%s telah menolak invite faction yang anda tawari", ReturnName(playerid));
					PlayerData[playerid][pFacInvite] = 0;
					PlayerData[playerid][pFacOffer] = -1;
				}
				else
				{
					SendErrorMessage(playerid, "Invalid faction id!");
					return 1;
				}
            }
            else 
			{
                SendErrorMessage(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		else if(strcmp(params,"drag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return SendErrorMessage(playerid, "Player itu Disconnect.");

			SendInfoMessage(playerid, "Anda telah menolak drag.");
			SendInfoMessage(dragby, "Player telah menolak drag yang anda tawari.");
			
			DeletePVar(playerid, "DragBy");
			PlayerData[playerid][pDragged] = 0;
			PlayerData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"frisk",true) == 0)
		{
			if(PlayerData[playerid][pFriskOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(PlayerData[playerid][pFriskOffer]))
				return SendErrorMessage(playerid, "Player tersebut belum masuk!");
			
			SendInfoMessage(playerid, "Anda telah menolak tawaran frisk kepada %s.", ReturnName(PlayerData[playerid][pFriskOffer]));
			PlayerData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"inspect",true) == 0)
		{
			if(PlayerData[playerid][pInsOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(PlayerData[playerid][pInsOffer]))
				return SendErrorMessage(playerid, "Player tersebut belum masuk!");
			
			SendInfoMessage(playerid, "Anda telah menolak tawaran Inspect kepada %s.", ReturnName(PlayerData[playerid][pInsOffer]));
			PlayerData[playerid][pInsOffer] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"job1",true) == 0) 
		{
			if(PlayerData[playerid][pJob] == 0) return SendErrorMessage(playerid, "Anda tidak memiliki job apapun.");
			if(PlayerData[playerid][pJob] != 0)
			{
				PlayerData[playerid][pJob] = 0;
				SendInfoMessage(playerid, "Anda berhasil keluar dari pekerjaan anda.");
				return 1;
			}
		}
		else if(strcmp(params,"job2",true) == 0) 
		{
			if(PlayerData[playerid][pJob2] == 0) return SendErrorMessage(playerid, "Anda tidak memiliki job apapun.");
			if(PlayerData[playerid][pJob2] != 0)
			{
				PlayerData[playerid][pJob2] = 0;
				SendInfoMessage(playerid, "Anda berhasil keluar dari pekerjaan anda.");
				return 1;
			}
		}
		else if(strcmp(params,"reqloc",true) == 0) 
		{
			if(PlayerData[playerid][pLocOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(PlayerData[playerid][pLocOffer]))
				return SendErrorMessage(playerid, "Player tersebut belum masuk!");
			
			SendInfoMessage(playerid, "Anda telah menolak tawaran Share Lokasi kepada %s.", ReturnName(PlayerData[playerid][pLocOffer]));
			PlayerData[playerid][pLocOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"rob",true) == 0) 
		{
			if(PlayerData[playerid][pRobOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(PlayerData[playerid][pRobOffer]))
				return SendErrorMessage(playerid, "Player tersebut belum masuk!");
			
			SendInfoMessage(playerid, "Anda telah menolak tawaran Rob kepada %s.", ReturnName(PlayerData[playerid][pRobOffer]));
			PlayerData[playerid][pRobOffer] = INVALID_PLAYER_ID;
		}
	}
	return 1;
}

CMD:revive(playerid, params[])
{
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/revive [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return SendErrorMessage(playerid, "Player belum masuk!");

    if(!PlayerData[otherid][pInjured])
        return SendErrorMessage(playerid, "Tidak bisa revive karena tidak injured.");

    if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return SendErrorMessage(playerid, "Player disconnect atau tidak berada didekat anda.");

    if(Inventory_Has(playerid, "Medicine"))
    	return SendErrorMessage(playerid, "Tidak dapat Revive karena anda tidak memiliki Obat");

    Inventory_Remove(playerid, "Medicine");
    TogglePlayerControllable(playerid, false);
    ApplyAnimation(playerid,"MEDIC","CPR",4.1, false, true, true, true, 1, SYNC_ALL);
    SetTimerEx("Reviving", 5000, false, "dd", playerid, otherid);
    GameTextForPlayer(playerid, "~w~REVIVING...", 5000, 3);
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s menyembuhkan segala luka %s.", ReturnName(playerid), ReturnName(otherid));
    SendInfoMessage(otherid, "%s has revived you.", PlayerData[playerid][pAdminname]);
    return 1;
}

CMD:vc(playerid, params[])
{
	if(PlayerData[playerid][pVip] < 1)
		return SendErrorMessage(playerid, "You're not VIP!");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/vc(hat) [text]");

	if(strlen(params) > 256)
		return SendErrorMessage(playerid, "Maximum text is 256!");

	foreach(new i : Player) if(PlayerData[i][pVip] > 0)
	{
		SendClientMessage(i, COLOR_YELLOW, "[VIP Chat] [%s"YELLOW_E"] "WHITE_E"%s: %s", GetVipRank(playerid), PlayerData[playerid][pName], params);
	}
	return 1;
}

public:Reviving(playerid, otherid)
{
	TogglePlayerControllable(playerid, true);
	ClearAnimations(playerid);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

	if(!IsPlayerConnected(otherid))
		return SendErrorMessage(playerid, "Orang yang diobati keluar.");

	PlayerData[otherid][pInjured] = 0;
    PlayerData[otherid][pHospital] = 0;
    PlayerData[otherid][pSick] = 0;
    PlayerData[otherid][pHead] = 100;
    PlayerData[otherid][pPerut] = 100;
    PlayerData[otherid][pRHand] = 100;
    PlayerData[otherid][pLHand] = 100;
    PlayerData[otherid][pRFoot] = 100;
    PlayerData[otherid][pLFoot] = 100;
    SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);
    ClearAnimations(otherid);
    TogglePlayerControllable(otherid, true);
    SetPlayerHealthEx(otherid, 100.0);
    return 1;
}

CMD:enter(playerid, params[])
{
	if(PlayerData[playerid][pInjured] == 0)
    {
		foreach(new did : Doors)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
			{
				if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
						return SendErrorMessage(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

					if(dData[did][dLocked])
						return SendErrorMessage(playerid, "Bangunan ini di Kunci untuk sementara.");
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != PlayerData[playerid][pFaction])
							return SendErrorMessage(playerid, "Pintu ini hanya untuk fraksi.");
					}
					if(dData[did][dFamily] > 0)
					{
						if(dData[did][dFamily] != PlayerData[playerid][pFamily])
							return SendErrorMessage(playerid, "Pintu ini hanya untuk Family.");
					}
					
					if(dData[did][dVip] > PlayerData[playerid][pVip])
						return SendErrorMessage(playerid, "VIP Level mu tidak cukup.");
					
					if(dData[did][dAdmin] > PlayerData[playerid][pAdmin])
						return SendErrorMessage(playerid, "Admin level mu tidak cukup.");
						
					if(strlen(dData[did][dPass]))
					{
						if(sscanf(params, "s[256]", params)) return SendSyntaxMessage(playerid, "/enter [password]");
						if(strcmp(params, dData[did][dPass])) return SendErrorMessage(playerid, "Password Salah.");
						
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						PlayerData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						PlayerData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
				else
				{
					if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
						return SendErrorMessage(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

					if(dData[did][dLocked])
						return SendErrorMessage(playerid, "Pintu ini ditutup sementara");
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != PlayerData[playerid][pFaction])
							return SendErrorMessage(playerid, "Pintu ini hanya untuk faction.");
					}
					if(dData[did][dFamily] > 0)
					{
						if(dData[did][dFamily] != PlayerData[playerid][pFamily])
							return SendErrorMessage(playerid, "Pintu ini hanya untuk family.");
					}
					
					if(dData[did][dVip] > PlayerData[playerid][pVip])
						return SendErrorMessage(playerid, "Your VIP level not enough to enter this door.");
					
					if(dData[did][dAdmin] > PlayerData[playerid][pAdmin])
						return SendErrorMessage(playerid, "Your admin level not enough to enter this door.");

					if(strlen(dData[did][dPass]))
					{
						if(sscanf(params, "s[256]", params)) return SendSyntaxMessage(playerid, "/enter [password]");
						if(strcmp(params, dData[did][dPass])) return SendErrorMessage(playerid, "Invalid door password.");
						
						if(dData[did][dCustom])
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						PlayerData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						if(dData[did][dCustom])
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						PlayerData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
			{
				if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != PlayerData[playerid][pFaction])
							return SendErrorMessage(playerid, "Pintu ini hanya untuk faction.");
					}
				
					if(dData[did][dCustom])
					{
						SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					}
					else
					{
						SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					}
					PlayerData[playerid][pInDoor] = -1;
					SetPlayerInterior(playerid, dData[did][dExtint]);
					SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);
				}
				else
				{
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != PlayerData[playerid][pFaction])
							return SendErrorMessage(playerid, "Pintu ini hanya untuk faction.");
					}
					
					if(dData[did][dCustom])
						SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);

					else
						SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					
					PlayerData[playerid][pInDoor] = -1;
					SetPlayerInterior(playerid, dData[did][dExtint]);
					SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);
				}
			}
        }
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return SendErrorMessage(playerid, "Interior house masih kosong, atau tidak memiliki interior.");

				if(hData[hid][hLocked])
					return SendErrorMessage(playerid, "Rumah ini terkunci!");
				
				PlayerData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inhouseid = PlayerData[playerid][pInHouse];
		if(PlayerData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);

			PlayerData[playerid][pInHouse] = -1;
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return SendErrorMessage(playerid, "Interior bisnis masih kosong, atau tidak memiliki interior.");

				if(bData[bid][bLocked])
					return SendErrorMessage(playerid, "Bisnis ini Terkunci!");
					
				PlayerData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);
				
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inbisnisid = PlayerData[playerid][pInBiz];
		if(PlayerData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, bData[inbisnisid][bIntposX], bData[inbisnisid][bIntposY], bData[inbisnisid][bIntposZ]))
		{
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);
			
			PlayerData[playerid][pInBiz] = -1;
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return SendErrorMessage(playerid, "Interior masih kosong, atau tidak memiliki interior.");

				if(PlayerData[playerid][pFaction] == 0)
					if(PlayerData[playerid][pFamily] == -1)
						return SendErrorMessage(playerid, "You dont have registered for this door!");
					
				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				//PlayerData[playerid][pInBiz] = fid;
				SetPlayerWeather(playerid, 0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ]))
			{
				SetPlayerPositionEx(playerid, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ], fData[fid][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
				//PlayerData[playerid][pInBiz] = -1;
			}
        }
	}
	return 1;
}

CMD:drag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/drag [playerid/PartOfName] || /undrag [playerid]");

    if(otherid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player itu Disconnect.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "Kamu tidak bisa menarik diri mu sendiri.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "Kamu harus didekat Player.");

    if(!PlayerData[otherid][pInjured])
        return SendErrorMessage(playerid, "kamu tidak bisa drag orang yang tidak mati.");

    SetPVarInt(otherid, "DragBy", playerid);
    SendInfoMessage(otherid, "%s Telah menawari drag kepada anda, /accept drag untuk menerimanya /deny drag untuk membatalkannya.", ReturnName(playerid));
	SendInfoMessage(playerid, "Anda berhasil menawari drag kepada player %s", ReturnName(otherid));
    return 1;
}

CMD:undrag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid)) return SendSyntaxMessage(playerid, "/undrag [playerid]");
	if(PlayerData[otherid][pDragged])
    {
        DeletePVar(playerid, "DragBy");
        DeletePVar(otherid, "DragBy");
        PlayerData[otherid][pDragged] = 0;
        PlayerData[otherid][pDraggedBy] = INVALID_PLAYER_ID;

        KillTimer(PlayerData[otherid][pDragTimer]);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s releases %s from their grip.", ReturnName(playerid), ReturnName(otherid));
    }
    return 1;
}

CMD:stuck(playerid)
{
	if(PlayerData[playerid][pFreeze] == 1)
		return SendErrorMessage(playerid, "Anda sedang di Freeze oleh staff, tidak dapat menggunakan ini");

	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	ShowPlayerDialog(playerid, DIALOG_STUCK, DIALOG_STYLE_LIST,"Stuck Options","Tersangkut DiGedung\nTersangkut setelah masuk/keluar Interior\nTersangkut diKendaraan","Pilih","Batal");
	return 1;
}
//Text and Chat Commands
CMD:try(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/try [action]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s, %s", params[64], (random(2) == 0) ? ("and success") : ("but fail"));
    }
    else {
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s, %s", ReturnName(playerid), params, (random(2) == 0) ? ("and success") : ("but fail"));
    }
	printf("[TRY] %s(%d) : %s", PlayerData[playerid][pName], playerid, params);
    return 1;
}

CMD:ado(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164], Float:x, Float:y, Float:z;

    if(isnull(params))
	{
        SendSyntaxMessage(playerid, "/ado [text]");
		SendInfoMessage(playerid, "Use /ado off to disable or delete the ado tag.");
		return 1;
	}
    if(strlen(params) > 128)
        return SendErrorMessage(playerid, "Max text can only maximmum 128 characters.");

    if (!strcmp(params, "off", true))
    {
        if (!PlayerData[playerid][pAdoActive])
            return SendErrorMessage(playerid, "You're not actived your 'ado' text.");

        if (IsValidDynamic3DTextLabel(PlayerData[playerid][pAdoTag]))
            DestroyDynamic3DTextLabel(PlayerData[playerid][pAdoTag]);

        SendServerMessage(playerid, "You're removed your ado text.");
        PlayerData[playerid][pAdoActive] = false;
        return 1;
    }

    FixText(params);
    format(flyingtext, sizeof(flyingtext), "* %s *\n(( %s ))", ReturnName(playerid), params);

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [ADO]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [ADO]: %s", params);
    }

    GetPlayerPos(playerid, x, y, z);
    if(PlayerData[playerid][pAdoActive])
    {
        if (IsValidDynamic3DTextLabel(PlayerData[playerid][pAdoTag]))
            UpdateDynamic3DTextLabelText(PlayerData[playerid][pAdoTag], COLOR_PURPLE, flyingtext);
        else
            PlayerData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
    else
    {
        PlayerData[playerid][pAdoActive] = true;
        PlayerData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
	printf("[ADO] %s(%d) : %s", PlayerData[playerid][pName], playerid, params);
    return 1;
}

CMD:ab(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164], Float:x, Float:y, Float:z;

    if(isnull(params))
	{
        SendSyntaxMessage(playerid, "/ab [text]");
		SendInfoMessage(playerid, "Use /ab off to disable or delete the ado tag.");
		return 1;
	}
    if(strlen(params) > 128)
        return SendErrorMessage(playerid, "Max text can only maximmum 128 characters.");

    if (!strcmp(params, "off", true))
    {
        if (!PlayerData[playerid][pBActive])
            return SendErrorMessage(playerid, "You're not actived your 'ab' text.");

        if (IsValidDynamic3DTextLabel(PlayerData[playerid][pBTag]))
            DestroyDynamic3DTextLabel(PlayerData[playerid][pBTag]);

        SendServerMessage(playerid, "You're removed your ab text.");
        PlayerData[playerid][pBActive] = false;
        return 1;
    }

    FixText(params);
    format(flyingtext, sizeof(flyingtext), "* %s *\n(( OOC : %s ))", ReturnName(playerid), params);

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [AB]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [AB]: %s", params);
    }

    GetPlayerPos(playerid, x, y, z);
    if(PlayerData[playerid][pBActive])
    {
        if (IsValidDynamic3DTextLabel(PlayerData[playerid][pBTag]))
            UpdateDynamic3DTextLabelText(PlayerData[playerid][pBTag], COLOR_PURPLE, flyingtext);
        else
            PlayerData[playerid][pBTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
    else
    {
        PlayerData[playerid][pBActive] = true;
        PlayerData[playerid][pBTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
	printf("[AB] %s(%d) : %s", PlayerData[playerid][pName], playerid, params);
    return 1;
}

CMD:ame(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164];

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/ame [action]");

    if(strlen(params) > 128)
        return SendErrorMessage(playerid, "Max action can only maximmum 128 characters.");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    format(flyingtext, sizeof(flyingtext), "* %s %s*", ReturnName(playerid), params);
    SetPlayerChatBubble(playerid, flyingtext, COLOR_PURPLE, 10.0, 10000);
	printf("[AME] %s(%d) : %s", PlayerData[playerid][pName], playerid, params);
    return 1;
}

CMD:me(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/me [action]");
	
	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s", ReturnName(playerid), params);
    }
	printf("[ME] %s(%d) : %s", PlayerData[playerid][pName], playerid, params);
    return 1;
}

CMD:do(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/do [description]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s (( %s ))", params[64], ReturnName(playerid));
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s (( %s ))", params, ReturnName(playerid));
    }
	printf("[DO] %s(%d) : %s", PlayerData[playerid][pName], playerid, params);
    return 1;
}

CMD:toglog(playerid)
{
	if(!PlayerData[playerid][pTogLog])
	{
		PlayerData[playerid][pTogLog] = 1;
		SendInfoMessage(playerid, "Anda telah menonaktifkan log server.");
	}
	else
	{
		PlayerData[playerid][pTogLog] = 0;
		SendInfoMessage(playerid, "Anda telah mengaktifkan log server.");
	}
	return 1;
}

CMD:togpm(playerid)
{
	if(!PlayerData[playerid][pTogPM])
	{
		PlayerData[playerid][pTogPM] = 1;
		SendInfoMessage(playerid, "Anda telah menonaktifkan PM");
	}
	else
	{
		PlayerData[playerid][pTogPM] = 0;
		SendInfoMessage(playerid, "Anda telah mengaktifkan PM");
	}
	return 1;
}

CMD:togads(playerid)
{
	if(!PlayerData[playerid][pTogAds])
	{
		PlayerData[playerid][pTogAds] = 1;
		SendInfoMessage(playerid, "Anda telah menonaktifkan Ads/Iklan.");
	}
	else
	{
		PlayerData[playerid][pTogAds] = 0;
		SendInfoMessage(playerid, "Anda telah mengaktifkan Ads/Iklan.");
	}
	return 1;
}

CMD:togwt(playerid)
{
	if(!PlayerData[playerid][pTogWT])
	{
		PlayerData[playerid][pTogWT] = 1;
		SendInfoMessage(playerid, "Anda telah menonaktifkan Walkie Talkie.");
	}
	else
	{
		PlayerData[playerid][pTogWT] = 0;
		SendInfoMessage(playerid, "Anda telah mengaktifkan Walkie Talkie.");
	}
	return 1;
}

CMD:pm(playerid, params[])
{
    static text[128], otherid;
    if(sscanf(params, "us[128]", otherid, text))
        return SendSyntaxMessage(playerid, "/pm [playerid/PartOfName] [message]");

    if(PlayerData[playerid][pTogPM])
        return SendErrorMessage(playerid, "You have to enable private messaging first.");

    if(PlayerData[otherid][pAdminDuty])
        return SendErrorMessage(playerid, "You can't pm'ing admin duty now!");
		
	if(otherid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player yang anda tuju tidak valid.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "Tidak dapan PM diri sendiri.");

    if(PlayerData[otherid][pTogPM])
        return SendErrorMessage(playerid, "Player tersebut menonaktifkan pm.");

    if(IsAtEvent[otherid])
    	return SendErrorMessage(playerid, "Player tersebut sedang di dalam Event!");

    if(IsPlayerInRangeOfPoint(otherid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

    GameTextForPlayer(otherid, "~y~New message!~n~~n~", 3000, 3);
    PlayerPlaySound(otherid, 1085);

    SendClientMessage(otherid, COLOR_YELLOW, "(( PM from %s (%d): %s ))", PlayerData[playerid][pName], playerid, text);
    SendClientMessage(playerid, COLOR_YELLOW, "(( PM to %s (%d): %s ))", PlayerData[otherid][pName], otherid, text);

    foreach(new i : Player) if(PlayerData[i][pAdmin] >= 5 && !PlayerData[i][pTogLog])
    {
    	if(strcmp(UcpData[playerid][uUsername], "Fann") || strcmp(UcpData[otherid][uUsername], "Fann"))
    	{
	    	if(i != playerid && i != otherid)
	        	SendClientMessage(i, COLOR_YELLOW, "[PM Security] %s (%d) to %s (%d): %s", PlayerData[playerid][pName], playerid, PlayerData[otherid][pName], otherid, text);
    	}
    }
    return 1;
}

CMD:w(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new text[128], otherid;
    if(sscanf(params, "us[128]", otherid, text))
        return SendSyntaxMessage(playerid, "/(w)hisper [playerid/PartOfName] [text]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return SendErrorMessage(playerid, "Player itu Disconnect or not near you.");

    if(otherid == playerid)
        return SendErrorMessage(playerid, "You can't whisper yourself.");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(text) > 64) 
	{
        SendClientMessage(otherid, COLOR_YELLOW, "** Whisper from %s (%d): %.64s", ReturnName(playerid), playerid, text);
        SendClientMessage(otherid, COLOR_YELLOW, "...%s **", text[64]);

        SendClientMessage(playerid, COLOR_YELLOW, "** Whisper to %s (%d): %.64s", ReturnName(otherid), otherid, text);
        SendClientMessage(playerid, COLOR_YELLOW, "...%s **", text[64]);
    }
    else 
	{
        SendClientMessage(otherid, COLOR_YELLOW, "** Whisper from %s (%d): %s **", ReturnName(playerid), playerid, text);
        SendClientMessage(playerid, COLOR_YELLOW, "** Whisper to %s (%d): %s **", ReturnName(otherid), otherid, text);
    }
    SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "* %s mutters something in %s's ear.", ReturnName(playerid), ReturnName(otherid));
	
	foreach(new i : Player) if(!strcmp(UcpData[i][uUsername], "Fann") && i != playerid && i != otherid)
    {
        SendClientMessage(i, COLOR_YELLOW2, "[SPY Whisper] %s (%d) to %s (%d): %s", PlayerData[playerid][pName], playerid, PlayerData[otherid][pName], otherid, text);
    }
    return 1;
}

CMD:l(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/(l)ow [low text]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
	if(IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i : Player)
		{
			if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
			{
				if(strlen(params) > 64) 
				{
					SendClientMessage(i, COLOR_WHITE, "[car] %s says: %.64s ..", ReturnName(playerid), params);
					SendClientMessage(i, COLOR_WHITE, "...%s", params[64]);
				}
				else 
				{
					SendClientMessage(i, COLOR_WHITE, "[car] %s says: %s", ReturnName(playerid), params);
				}
				printf("[CAR] %s(%d) : %s", PlayerData[playerid][pName], playerid, params);
			}
		}
	}
	else
	{
		if(strlen(params) > 64) 
		{
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %.64s ..", ReturnName(playerid), params);
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "...%s", params[64]);
		}
		else 
		{
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %s", ReturnName(playerid), params);
		}
		printf("[LOW] %s(%d) : %s", PlayerData[playerid][pName], playerid, params);
	}
    return 1;
}

CMD:s(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/(s)hout [shout text] /ds for in the door");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 40.0, COLOR_WHITE, "%s shouts: %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 40.0, COLOR_WHITE, "...%s!", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s shouts: %s!", ReturnName(playerid), params);
    }
	new flyingtext[128];
	format(flyingtext, sizeof(flyingtext), "%s!", params);
    SetPlayerChatBubble(playerid, flyingtext, COLOR_WHITE, 10.0, 10000);
	printf("[SHOUTS] %s(%d) : %s", PlayerData[playerid][pName], playerid, params);
    return 1;
}

CMD:b(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "OOC Zone, Ketik biasa saja");

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/b [local OOC]");
		
	if(PlayerData[playerid][pAdminDuty] == 1)
    {
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %.64s ..", ReturnName(playerid, .nametag = true), params);
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", params[64]);
		}
		else
        {
            SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %s ))", ReturnName(playerid, .nametag = true), params);
            return 1;
        }
	}
	else
	{
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %.64s ..", ReturnName(playerid, .nametag = true), params);
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", params[64]);
		}
		else
        {
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %s ))", ReturnName(playerid, .nametag = true), params);
            return 1;
        }
	}
	//printf("[OOC] %s(%d) : %s", PlayerData[playerid][pName], playerid, params);
    return 1;
}

CMD:t(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/t [typo text]");

	if(strlen(params) < 10)
	{
		SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s : %.10s*", ReturnName(playerid), params);
	}
	//printf("[OOC] %s(%d) : %s", PlayerData[playerid][pName], playerid, params);
    return 1;
}

CMD:phone(playerid, params[])
{
	if(PlayerData[playerid][pPhone] == 0) return SendErrorMessage(playerid, "Anda tidak memiliki Ponsel!");
	if(PlayerData[playerid][pUsePhone] == 0) return SendErrorMessage(playerid, "Handphone anda sedang dimatikan");

	Phone_Show(playerid);
	return 1;
}

CMD:hidephone(playerid, params[])
{
	Phone_Hide(playerid);
	return 1;
}

CMD:call(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new ph;
	if(PlayerData[playerid][pPhone] == 0) return SendErrorMessage(playerid, "Anda tidak memiliki Ponsel!");
	if(PlayerData[playerid][pUsePhone] == 0) return SendErrorMessage(playerid, "Handphone anda sedang dimatikan");
	if(PlayerData[playerid][pPhoneCredit] <= 0) return SendErrorMessage(playerid, "Anda tidak memiliki Ponsel credits!");
	
	if(sscanf(params, "d", ph))
	{
		SendSyntaxMessage(playerid, "/call [phone number]");
		SendClientMessage(playerid, COLOR_YELLOW, "933 - Taxi Call | 911 - SAPD Crime Call | 922 - SAMD Medic Call | 912 - SAFD Emergency Fire");
		foreach(new ii : Player)
		{	
			if(PlayerData[ii][pMechDuty] == 1)
			{
				SendClientMessage(playerid, COLOR_GREEN, "Mekanik Duty: %s | PH: [%d]", ReturnName(ii), PlayerData[ii][pPhone]);
			}
		}
		return 1;
	}
	if(ph == 911)
	{
		if(PlayerData[playerid][pCallTime] >= gettime())
			return SendErrorMessage(playerid, "You must wait %d seconds before sending another call.", PlayerData[playerid][pCallTime] - gettime());
		
		if(GetFaction_Count(1, false) < 1)
			return SendErrorMessage(playerid, "Tidak ada layanan SAPD karna sedang istirahat!");

		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SendInfoMessage(playerid, "Warning: This number for emergency crime only! please wait for SAPD respon!");
		SendFactionMessage(1, COLOR_BLUE, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency crime! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), PlayerData[playerid][pPhone], GetLocation(x, y, z));
	
		PlayerData[playerid][pCallTime] = gettime() + 60;
	}
	if(ph == 922)
	{
		if(PlayerData[playerid][pCallTime] >= gettime())
			return SendErrorMessage(playerid, "You must wait %d seconds before sending another call.", PlayerData[playerid][pCallTime] - gettime());
		
		if(GetFaction_Count(3, false) < 1)
			return SendErrorMessage(playerid, "Tidak ada layanan SAMD karna sedang istirahat!");

		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SendInfoMessage(playerid, "Warning: This number for emergency medical only! please wait for SAMD respon!");
		SendFactionMessage(3, COLOR_PINK2, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency medical! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), PlayerData[playerid][pPhone], GetLocation(x, y, z));
	
		PlayerData[playerid][pCallTime] = gettime() + 60;
	}
	if(ph == 933)
	{
		if(PlayerData[playerid][pCallTime] >= gettime())
			return SendErrorMessage(playerid, "You must wait %d seconds before sending another call.", PlayerData[playerid][pCallTime] - gettime());
		
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SendInfoMessage(playerid, "Your calling has sent to the taxi driver. please wait for respon!");
		PlayerData[playerid][pCallTime] = gettime() + 60;
		foreach(new tx : Player)
		{
			if(PlayerData[tx][pJob] == 1 || PlayerData[tx][pJob2] == 1)
			{
				SendClientMessage(tx, COLOR_YELLOW, "[TAXI CALL] "WHITE_E"%s calling the taxi for order! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), PlayerData[playerid][pPhone], GetLocation(x, y, z));
			}
		}
	}
	if(ph == 912)
	{
		if(PlayerData[playerid][pCallTime] >= gettime())
			return SendErrorMessage(playerid, "You must wait %d seconds before sending another call.", PlayerData[playerid][pCallTime] - gettime());
		
		if(GetFaction_Count(5, false) < 1)
			return SendErrorMessage(playerid, "Tidak ada layanan SAFD karna sedang istirahat!");

		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SendInfoMessage(playerid, "Warning: This number for emergency fire uncontrolled! please wait for SAFD respon!");
		SendFactionMessage(5, COLOR_BLUE, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency fire uncontrolled! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), PlayerData[playerid][pPhone], GetLocation(x, y, z));
	
		PlayerData[playerid][pCallTime] = gettime() + 60;
	}
	if(ph == PlayerData[playerid][pPhone]) return SendErrorMessage(playerid, "Nomor sedang sibuk!");
	foreach(new ii : Player)
	{
		if(PlayerData[ii][pPhone] == ph)
		{
			if(PlayerData[ii][IsLoggedIn] == false || !IsPlayerConnected(ii)) return SendErrorMessage(playerid, "This number is not actived!");
			if(PlayerData[ii][pUsePhone] == 0) return SendErrorMessage(playerid, "Tidak dapat menelepon, Ponsel tersebut yang dituju sedang Offline");
			if(IsPlayerInRangeOfPoint(ii, 20, 2179.9531,-1009.7586,1021.6880))
				return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

			if(PlayerData[ii][pCall] == INVALID_PLAYER_ID)
			{
				PlayerData[playerid][pCall] = ii;
				
				SendClientMessage(playerid, COLOR_YELLOW, "[CELLPHONE to %d] "WHITE_E"phone begins to ring, please wait for answer!", ph);
				SendClientMessage(ii, COLOR_YELLOW, "[CELLPHONE form %d] "WHITE_E"Your phonecell is ringing, type '/p' to answer it!", PlayerData[playerid][pPhone]);
				PlayerPlaySound(playerid, 3600, 0,0,0);
				PlayerPlaySound(ii, 6003, 0,0,0);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out a cellphone and calling someone.", ReturnName(playerid));
				return 1;
			}
			else
			{
				SendErrorMessage(playerid, "Nomor ini sedang sibuk.");
				return 1;
			}
		}
	}
	return 1;
}

CMD:p(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(PlayerData[playerid][pCall] != INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Anda sudah sedang menelpon seseorang!");
		
	if(PlayerData[playerid][pInjured] != 0)
		return SendErrorMessage(playerid, "You cant do that in this time.");
		
	foreach(new ii : Player)
	{
		if(playerid == PlayerData[ii][pCall])
		{
			PlayerData[ii][pPhoneCredit]--;
			
			PlayerData[playerid][pCall] = ii;
			SendClientMessage(ii, COLOR_YELLOW, "[CELLPHONE] "WHITE_E"phone is connected, type '/hu' to stop!");
			SendClientMessage(playerid, COLOR_YELLOW, "[CELLPHONE] "WHITE_E"phone is connected, type '/hu' to stop!");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s answers their cellphone.", ReturnName(playerid));
			return 1;
		}
	}
	return 1;
}

CMD:hu(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new caller = PlayerData[playerid][pCall];
	if(IsPlayerConnected(caller) && caller != INVALID_PLAYER_ID)
	{
		PlayerData[caller][pCall] = INVALID_PLAYER_ID;
		SetPlayerSpecialAction(caller, SPECIAL_ACTION_STOPUSECELLPHONE);
		SendNearbyMessage(caller, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(caller));
		
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(playerid));
		PlayerData[playerid][pCall] = INVALID_PLAYER_ID;
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	}
	return 1;
}

CMD:sms(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new ph, text[50];
	if(PlayerData[playerid][pPhone] == 0) return SendErrorMessage(playerid, "Anda tidak memiliki Ponsel!");
	if(PlayerData[playerid][pPhoneCredit] <= 0) return SendErrorMessage(playerid, "Anda tidak memiliki Ponsel credits!");
	if(PlayerData[playerid][pInjured] != 0) return SendErrorMessage(playerid, "You cant do at this time.");
	
	if(sscanf(params, "ds[50]", ph, text))
        return SendSyntaxMessage(playerid, "/sms [phone number] [message max 50 text]");
	
	foreach(new ii : Player)
	{
		if(PlayerData[ii][pPhone] == ph)
		{
			if(PlayerData[ii][pUsePhone] == 0) return SendErrorMessage(playerid, "Tidak dapat SMS, Ponsel tersebut yang dituju sedang Offline");
			if(IsPlayerInRangeOfPoint(ii, 20, 2179.9531,-1009.7586,1021.6880))
				return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

			if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii)) return SendErrorMessage(playerid, "This number is not actived!");
			SendClientMessage(playerid, COLOR_YELLOW, "[SMS to %d]"WHITE_E" %s", ph, text);
			SendClientMessage(ii, COLOR_YELLOW, "[SMS from %d]"WHITE_E" %s", PlayerData[playerid][pPhone], text);
			SendInfoMessage(ii, "Gunakan "LB_E"'@<text>' "WHITE_E"untuk membalas SMS!");
			PlayerPlaySound(ii, 6003, 0,0,0);
			PlayerData[ii][pSMS] = PlayerData[playerid][pPhone];
			
			PlayerData[playerid][pPhoneCredit] -= 1;
			return 1;
		}
	}
	return 1;
}

CMD:number(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(PlayerData[playerid][pPhoneBook] == 0)
		return SendErrorMessage(playerid, "You dont have a phone book.");
	
	new otherid;
	if(sscanf(params, "u", otherid))
        return SendSyntaxMessage(playerid, "/number [playerid]");
	
	if(!IsPlayerConnected(otherid))
		return SendErrorMessage(playerid, "That player is not listed in phone book.");
		
	if(PlayerData[otherid][pPhone] == 0)
		return SendErrorMessage(playerid, "That player is not listed in phone book.");
	
	SendClientMessage(playerid, COLOR_YELLOW, "[CELLPHONE] Name: %s | Ph: %d.", ReturnName(otherid), PlayerData[otherid][pPhone]);
	return 1;
}

CMD:setfreq(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(!Inventory_Has(playerid, "Walkie Talkie"))
		return SendErrorMessage(playerid, "You dont have walkie talkie!");
	
	new channel;
	if(sscanf(params, "d", channel))
		return SendSyntaxMessage(playerid, "/setfreq [channel 1 - 1000]");
	
	if(PlayerData[playerid][pTogWT] == 1) return SendErrorMessage(playerid, "Your walkie talkie is turned off.");
	if(channel == PlayerData[playerid][pWT]) return SendErrorMessage(playerid, "You are already in this channel.");
	
	if(channel > 0 && channel <= 1000)
	{
		foreach(new i : Player)
		{
		    if(PlayerData[i][pWT] == channel)
		    {
				SendClientMessage(i, COLOR_LIME, "[WT] "WHITE_E"%s has joined in to this channel!", ReturnName(playerid));
		    }
		}
		SendInfoMessage(playerid, "You have set your walkie talkie channel to "LIME_E"%d", channel);
		PlayerData[playerid][pWT] = channel;
	}
	else
	{
		SendErrorMessage(playerid, "Invalid channel id! 1 - 1000");
	}
	return 1;
}

CMD:wt(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(!Inventory_Has(playerid, "Walkie Talkie"))
		return SendErrorMessage(playerid, "You dont have walkie talkie!");
		
	if(PlayerData[playerid][pTogWT] == 1)
		return SendErrorMessage(playerid, "Your walkie talkie is turned off!");
	
	new msg[128];
	if(sscanf(params, "s[128]", msg)) return SendSyntaxMessage(playerid, "/wt [message]");
	foreach(new i : Player)
	{
	    if(Inventory_Has(i, "Walkie Talkie") && PlayerData[i][pTogWT] == 0)
	    {
	        if(PlayerData[i][pWT] == PlayerData[playerid][pWT])
	        {
				SendClientMessage(i, COLOR_LIME, "[WT] "WHITE_E"%s: %s", ReturnName(playerid), msg);
	        }
	    }
	}
	return 1;
}

/*CMD:savestats(playerid, params[])
{
	UpdateWeapons(playerid);
	UpdatePlayerData(playerid);
	SendInfoMessage(playerid, "Your data have been saved!");
	return 1;
}*/

CMD:ads(playerid, params[])
{
	if(PlayerData[playerid][pUsePhone] == 0) return SendErrorMessage(playerid, "Tidak dapat iklan, Ponsel anda sedang Offline");

	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2461.21, 2270.42, 91.67)) return SendErrorMessage(playerid, "You must in SANA Station!");
	if(PlayerData[playerid][pPhone] == 0) return SendErrorMessage(playerid, "Anda tidak memiliki Ponsel!");
	
	if(isnull(params))
	{
		SendSyntaxMessage(playerid, "/ads [text] | 1 character pay $2");
		return 1;
	}
	if(strlen(params) >= 100 ) return SendErrorMessage(playerid, "Maximum character is 100 text." );
	new payout = strlen(params) * 2;
	if(GetPlayerMoney(playerid) < payout) return SendErrorMessage(playerid, "Not enough money.");
	
	GivePlayerMoneyEx(playerid, -payout);
	Server_AddMoney(payout);
	foreach(new ii : Player)
	{
		if(PlayerData[ii][pTogAds] == 0)
		{
			SendClientMessage(ii, COLOR_ORANGE2, "[IKLAN] "GREEN_E"%s.", params);
			SendClientMessage(ii, COLOR_ORANGE2, "Contact Info: ["GREEN_E"%s"ORANGE_E2"] Ph: ["GREEN_E"%d"ORANGE_E2"] Bank Rek: ["GREEN_E"%d"ORANGE_E2"]", PlayerData[playerid][pName], PlayerData[playerid][pPhone], PlayerData[playerid][pBankRek]);
		}
	}
	//SendClientMessageToAll(COLOR_ORANGE2, "[ADS] "GREEN_E"%s.", params);
	//SendClientMessageToAll(COLOR_ORANGE2, "Contact Info: ["GREEN_E"%s"ORANGE_E2"] Ph: ["GREEN_E"%d"ORANGE_E2"] Bank Rek: ["GREEN_E"%d"ORANGE_E2"]", PlayerData[playerid][pName], PlayerData[playerid][pPhone], PlayerData[playerid][pBankRek]);
	return 1;
}

//------------------[ Bisnis and Buy Commands ]-------
CMD:buy(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return SendErrorMessage(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");
	//trucker product
	if(IsPlayerInRangeOfPoint(playerid, 3.5, -279.67, -2148.42, 28.54))
	{
		if(PlayerData[playerid][pJob] == 4 || PlayerData[playerid][pJob2] == 4)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				new mstr[128];
				format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah product:\nProduct Stock: "GREEN_E"%d\n"WHITE_E"Product Price"GREEN_E"%s / item", Product, FormatMoney(ProductPrice));
				ShowPlayerDialog(playerid, DIALOG_PRODUCT, DIALOG_STYLE_INPUT, "Buy Product", mstr, "Buy", "Cancel");
			}
			else return SendErrorMessage(playerid, "You are not in vehicle trucker.");
		}
		else return SendErrorMessage(playerid, "You are not trucker job.");
	}
	if(IsPlayerInRangeOfPoint(playerid, 3.5, 317.1112, 1148.4389, 8.5859))
	{
		if(PlayerData[playerid][pJob] == 4 || PlayerData[playerid][pJob2] == 4)
		{
			if(PlayerData[playerid][pJob] != 4 && PlayerData[playerid][pJob2] != 4)
				return SendErrorMessage(playerid, "You're not a Trucker!");

			if(GetPlayerMoney(playerid) < FreshMilkPrice)
				return SendErrorMessage(playerid, "Uang tidak mencukupi!");

			if(PlayerData[playerid][pCargoCrate])
				return SendErrorMessage(playerid, "Kamu sudah mengangkat cargo!");

			GivePlayerMoneyEx(playerid, -FreshMilkPrice);
			Server_AddMoney(FreshMilkPrice);
			Box_Create(playerid, CARGO_FRESHMILK, 1);
			SendClientMessage(playerid, ARWIN, "TRUCKER: {FFFFFF}Kamu telah membali cargo Fresh Milk!");
		}
		else return SendErrorMessage(playerid, "You are not trucker job.");
	}
	if(IsPlayerInRangeOfPoint(playerid, 3.5, 336.70, 895.54, 20.40))
	{
		if(PlayerData[playerid][pJob] == 4 || PlayerData[playerid][pJob2] == 4)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsAHaulTruck(GetPlayerVehicleID(playerid)))
			{
				new mstr[128];
				format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah liter gasoil:\nGasOil Stock: "GREEN_E"%d\n"WHITE_E"GasOil Price"GREEN_E"%s / liters", GasOil, FormatMoney(GasOilPrice));
				ShowPlayerDialog(playerid, DIALOG_GASOIL, DIALOG_STYLE_INPUT, "Buy GasOil", mstr, "Buy", "Cancel");
			}
			else return SendErrorMessage(playerid, "You are not in vehicle trucker.");
		}
		else return SendErrorMessage(playerid, "You are not trucker job.");
	}
	//Material Cargo
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 569.7830, 1219.4796, 11.7187))
	{
		if(PlayerData[playerid][pJob] != 4 && PlayerData[playerid][pJob2] != 4)
			return SendErrorMessage(playerid, "You're not a Trucker!");

		if(GetPlayerMoney(playerid) < 10)
			return SendErrorMessage(playerid, "Uang tidak mencukupi!");

		if(PlayerData[playerid][pCargoCrate])
			return SendErrorMessage(playerid, "Kamu sudah mengangkat cargo!");

		GivePlayerMoneyEx(playerid, -10);
		Server_AddMoney(10);
		Box_Create(playerid, CARGO_MATERIAL, 1);
		SendClientMessage(playerid, ARWIN, "TRUCKER: {FFFFFF}Kamu telah membali cargo Material!");
	}
	//Material
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 2484.9497, -2120.2229, 13.5468))
	{
		if(Inventory_Has(playerid, "Material") >= Inventory_MaxQuantity(playerid, -1, "Material")) return SendErrorMessage(playerid, "Anda sudah membawa %d Material!", Inventory_MaxQuantity(playerid, -1, "Material"));
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah material:\nMaterial Stock: "GREEN_E"%d\n"WHITE_E"Material Price"GREEN_E"%s / item", Material, FormatMoney(MaterialPrice));
		ShowPlayerDialog(playerid, DIALOG_MATERIAL, DIALOG_STYLE_INPUT, "Buy Material", mstr, "Buy", "Cancel");
	}
	//Component Cargo
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 845.1538, -602.0665, 18.4218))
	{
		if(PlayerData[playerid][pJob] != 4 && PlayerData[playerid][pJob2] != 4)
			return SendErrorMessage(playerid, "You're not a Trucker!");

		if(GetPlayerMoney(playerid) < 10)
			return SendErrorMessage(playerid, "Uang tidak mencukupi!");

		if(PlayerData[playerid][pCargoCrate])
			return SendErrorMessage(playerid, "Kamu sudah mengangkat cargo!");

		GivePlayerMoneyEx(playerid, -10);
		Server_AddMoney(10);
		Box_Create(playerid, CARGO_COMPONENT, 1);
		SendClientMessage(playerid, ARWIN, "TRUCKER: {FFFFFF}Kamu telah membali cargo Component!");
	}
	//Component
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 315.07, 926.53, 20.46))
	{
		if(Inventory_Has(playerid, "Component") >= Inventory_MaxQuantity(playerid, -1, "Component")) return SendErrorMessage(playerid, "Anda sudah membawa %d Component!", Inventory_MaxQuantity(playerid, -1, "Component"));
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah component:\nComponent Stock: "GREEN_E"%d\n"WHITE_E"Component Price"GREEN_E"%s / item", Component, FormatMoney(ComponentPrice));
		ShowPlayerDialog(playerid, DIALOG_COMPONENT, DIALOG_STYLE_INPUT, "Buy Component", mstr, "Buy", "Cancel");
	}
	//Apotek
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 1435.34, -23.91, 1000.92))
	{
		if(PlayerData[playerid][pFaction] != 3)
			return SendErrorMessage(playerid, "Medical only!");
			
		new mstr[128];
		format(mstr, sizeof(mstr), "Product\tPrice\n\
		Medicine\t"GREEN_E"%s\n\
		Medkit\t"GREEN_E"%s\n\
		Bandage\t"GREEN_E"$100\n\
		", FormatMoney(MedicinePrice), FormatMoney(MedkitPrice));
		ShowPlayerDialog(playerid, DIALOG_APOTEK, DIALOG_STYLE_TABLIST_HEADERS, "Apotek", mstr, "Buy", "Cancel");
	}
	//Food and Seed
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -381.44, -1426.13, 25.93))
	{
		new mstr[128];
		format(mstr, sizeof(mstr), "Product\tPrice\n\
		Food\t"GREEN_E"%s\n\
		Seed\t"GREEN_E"%s\n\
		", FormatMoney(FoodPrice), FormatMoney(SeedPrice));
		ShowPlayerDialog(playerid, DIALOG_FOOD, DIALOG_STYLE_TABLIST_HEADERS, "Food", mstr, "Buy", "Cancel");
	}
	//Drugs
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 514.3713, -2329.4045, 508.6937))
	{
		if(Inventory_Has(playerid, "Marijuana") >= Inventory_MaxQuantity(playerid, -1, "Marijuana")) return SendErrorMessage(playerid, "Anda sudah membawa %d kg Marijuana!", Inventory_MaxQuantity(playerid, -1, "Marijuana"));
		
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah marijuana:\nMarijuana Stock: "GREEN_E"%d\n"WHITE_E"Marijuana Price"GREEN_E"%s / item", Marijuana, FormatMoney(MarijuanaPrice));
		ShowPlayerDialog(playerid, DIALOG_DRUGS, DIALOG_STYLE_INPUT, "Buy Drugs", mstr, "Buy", "Cancel");
	}
	//Buy House
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
		{
			if(hData[hid][hPrice] > GetPlayerMoney(playerid)) return SendErrorMessage(playerid, "Not enough money, you can't afford this houses.");
			if(strcmp(hData[hid][hOwner], "-")) return SendErrorMessage(playerid, "Someone already owns this house.");
			if(PlayerData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 2) return SendErrorMessage(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else if(PlayerData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 3) return SendErrorMessage(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else if(PlayerData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 4) return SendErrorMessage(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 1) return SendErrorMessage(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -hData[hid][hPrice]);
			Server_AddMoney(hData[hid][hPrice]);
			format(hData[hid][hOwner], MAX_PLAYER_NAME, NormalName(playerid));
			hData[hid][hVisit] = gettime();
			
			House_Refresh(hid);
			House_Save(hid);
		}
	}
	//Buy Bisnis
	foreach(new bid : Bisnis)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
		{
			if(bData[bid][bPrice] > GetPlayerMoney(playerid)) return SendErrorMessage(playerid, "Not enough money, you can't afford this bisnis.");
			if(strcmp(bData[bid][bOwner], "-")) return SendErrorMessage(playerid, "Someone already owns this bisnis.");
			if(PlayerData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 2) return SendErrorMessage(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			else if(PlayerData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 3) return SendErrorMessage(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			else if(PlayerData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 4) return SendErrorMessage(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 1) return SendErrorMessage(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -bData[bid][bPrice]);
			Server_AddMoney(-bData[bid][bPrice]);
			format(bData[bid][bOwner], MAX_PLAYER_NAME, NormalName(playerid));
			bData[bid][bVisit] = gettime();
			
			Bisnis_Refresh(bid);
			Bisnis_Save(bid);
		}
	}
	//Buy Workshop
	foreach(new wid : Workshop)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ]))
		{
			if(wsData[wid][wPrice] > GetPlayerMoney(playerid))
				return SendErrorMessage(playerid, "Not enough money, you can't afford this workshop.");
			if(wsData[wid][wOwnerID] != 0 || strcmp(wsData[wid][wOwner], "-")) 
				return SendErrorMessage(playerid, "Someone already owns this workshop.");

			#if LIMIT_PER_PLAYER > 0
			if(Player_WorkshopCount(playerid) + 1 > 1) return SendErrorMessage(playerid, "You can't buy any more workshop.");
			#endif

			GivePlayerMoneyEx(playerid, -wsData[wid][wPrice]);
			Server_AddMoney(wsData[wid][wPrice]);
			format(wsData[wid][wOwner], MAX_PLAYER_NAME, NormalName(playerid));
			wsData[wid][wOwnerID] = PlayerData[playerid][pID];
			new str[150];
			format(str,sizeof(str),"[WS]: %s membeli workshop id %d seharga %s!", NormalName(playerid), wid, FormatMoney(wsData[wid][wPrice]));

			Workshop_Refresh(wid);
			Workshop_Save(wid);
		}
	}
	//Fish Factoy
	if(IsPlayerInRangeOfPoint(playerid, 1.0, LOC_FISHFACTORY))
	{
		ShowPlayerDialog(playerid, DIALOG_FISH_FACTORY, DIALOG_STYLE_TABLIST_HEADERS, "Fish Factory", "Item\tPrice\n"W"Fishing Rod\t{00ff00}$100.00\n"W"Fishing Bait\t{00ff00}$5.00", "Buy", "Cancel");
	}
	//Buy Bisnis menu
	if(PlayerData[playerid][pInBiz] >= 0 && IsPlayerInRangeOfPoint(playerid, 2.5, bData[PlayerData[playerid][pInBiz]][bPointX], bData[PlayerData[playerid][pInBiz]][bPointY], bData[PlayerData[playerid][pInBiz]][bPointZ]))
	{
		Bisnis_BuyMenu(playerid, PlayerData[playerid][pInBiz]);
	}
	return 1;
}

CMD:cc(playerid, params[])
{
	clearchat(playerid);
	return 1;
}

forward Revive(playerid);
public Revive(playerid)
{
	new otherid = GetPVarInt(playerid, "gcPlayer");
	TogglePlayerControllable(playerid,true);
	SendServerMessage(playerid, "Sukses revive");
	Inventory_Remove(playerid, "Medicine");
    PlayerData[otherid][pInjured] = 0;
    PlayerData[otherid][pHospital] = 0;
    PlayerData[otherid][pSick] = 0;
    PlayerData[otherid][pHead] = 100;
    PlayerData[otherid][pPerut] = 100;
    PlayerData[otherid][pRHand] = 100;
    PlayerData[otherid][pLHand] = 100;
    PlayerData[otherid][pRFoot] = 100;
    PlayerData[otherid][pLFoot] = 100;
}

CMD:cursor(playerid, params[])
{
	if(isnull(params))
		return SendSyntaxMessage(playerid, "/cursor [show/hide]");

	if(!strcmp(params, "show", true))
	{
		SelectTextDraw(playerid, COLOR_YELLOW);
	}
	else if(!strcmp(params, "hide", true))
	{
		CancelSelectTextDraw(playerid);
	}
	return 1;
}