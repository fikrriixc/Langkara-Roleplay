// Drive School Test
#include <YSI_Coding\y_hooks>

new DMVQuest[][256] =
{
	"Apa yang harus kamu lakukan ketika lampu merah?",
	"Apa yang akan kamu lakukan ketika melihat penyebrang di trotoar?",
	"Apa nama plate yang digunakan di kota Hope?",
	"Di mana bagian kendaraan yang wajib dipasang Plate?",
	"Berapa maksimal kecepatan di kota?",
	"Sebelum mulai berkendara, apa yang dipastikan terlebih dahulu?",
	"Apa arti rambu lalu lintas berwarna kuning?",
	"Saat melihat Truck Fire Department/Ambulance/Police dengan sirine menyala di belakangmu, apa yang harus kamu lakukan?",
	"Apa sisi jalan yang diterapkan di kota Hope?",
	"Berapa maksimal kecepatan sebuah kendaraan saat melaju?"
};

enum e_dmvanswer_data
{
	dAnswer1[128],
	dAnswer2[128],
	dAnswer3[128],
	dAnswer4[128],
	dAnswer
};

new DMVAns[][e_dmvanswer_data] =
{
	{"Berlomba", "Berhenti", "Kayang", "Terus maju", 2},
	{"Menabraknya", "Melihat rambu lalu lintas", "Membiarkannya menyebrang dengan berhenti", "Menelpon Polisi", 3},
	{"HP-NoPlate", "SA-NoPlate", "RP-NoPlate", "GX-NoPlate", 1},
	{"Depan saja", "Belakang saja", "Atas dan Bawah", "Depan dan Belakang", 4},
	{"125mph", "80mph", "100mph", "150mph", 2},
	{"Memastikan bahan bakar penuh", "Memastikan rem berfungsi", "Memastikan semua penumpang memakai sabuk pengaman", "Memastikan lampu menyala", 3},
	{"Hati-hati", "Berhenti", "Mempercepat", "Melambat", 1},
	{"Mempercepat dan menyalip kendaraan tersebut", "Berhenti dan membiarkan kendaraan tersebut lewat", "Melambat dan menepi ke sisi jalan", "Terus berkendara seperti biasa", 3},
	{"Kanan", "Kiri", "Tengah", "Semua bagian jalan", 2},
	{"85mph", "75mph", "65mph", "95mph", 3}
};

new Float:DMVRoute[][] =
{
	{2067.5439, -1913.3739, 13.3262},
	{2081.8598, -1913.5539, 13.1544},
	{2094.0812, -1896.8615, 13.1577},
	{2221.1606, -1894.6835, 13.1624},
	{2230.9272, -1649.4246, 15.0893},
	{2200.8205, -1641.6983, 15.0867},
	{2215.2966, -1382.3560, 23.6076},
	{2109.5971, -1381.8048, 23.6078},
	{2110.3212, -1459.4383, 23.6092},
	{1853.0379, -1458.1097, 13.1779},
	{1852.8114, -1259.3168, 13.1707},
	{1834.9149, -1258.4704, 13.2484},
	{1452.1889, -1297.3128, 13.1622},
	{1426.9428, -1592.3293, 13.1621},
	{1427.3402, -1734.4533, 13.1624},
	{1568.0484, -1734.7875, 13.1624},
	{1566.0029, -1875.3397, 13.1623},
	{1676.2780, -1869.8786, 13.1620},
	{1702.0650, -1814.4497, 13.1446},
	{1819.1614, -1834.8007, 13.1932},
	{1832.4353, -1934.6396, 13.1506},
	{2056.9328, -1933.8338, 13.1347},
	{2056.8090, -1919.2095, 13.3280},
	{0.0, 0.0, 0.0} // finished
};

DMV_GetAnswerCorrect(ansid, selected)
{
	if(DMVAns[ansid][dAnswer] == selected)
		return 1;

	return 0;
}

DMV_ShowDialog(playerid)
{
	new fanstr[500], ansid = GetPVarInt(playerid, "dmvQuest");
	format(fanstr, sizeof(fanstr), "%s\n", DMVQuest[ansid]);
	
	strcat(fanstr, sprintf("%s\n", DMVAns[ansid][dAnswer1]));
	strcat(fanstr, sprintf("%s\n", DMVAns[ansid][dAnswer2]));
	strcat(fanstr, sprintf("%s\n", DMVAns[ansid][dAnswer3]));
	strcat(fanstr, sprintf("%s\n", DMVAns[ansid][dAnswer4]));

	ShowPlayerDialog(playerid, DIALOG_DMV_TEST, DIALOG_STYLE_TABLIST_HEADERS, "DMV Test", fanstr, "Select", "");
	return 1;
}

DMV_ResetVariables(playerid)
{
	SetPVarInt(playerid, "dmvQuest", 0);
	SetPVarInt(playerid, "dmvWrong", 0);
	SetPVarInt(playerid, "dmvTest", 0);
	SetPVarInt(playerid, "dmvPoint", -1);
	SetPVarInt(playerid, "dmvTotalAnswer", 0);

	if(IsValidVehicle(PlayerData[playerid][pDmvVeh]))
		DestroyVehicle(PlayerData[playerid][pDmvVeh]);

	PlayerData[playerid][pDmvVeh] = INVALID_VEHICLE_ID;
	return 1;
}

DMV_FailedTest(playerid)
{
	DMV_ResetVariables(playerid);

	DisablePlayerCheckpoint(playerid);
	PlayerData[playerid][pDriveDelay] = gettime() + (3600);
	return 1;
}

DMV_EnterCheckpoint(playerid)
{
	if(GetPVarInt(playerid, "dmvTest") == 2)
	{
		if(IsPlayerInVehicle(playerid, PlayerData[playerid][pDmvVeh]))
		{
			if(GetVehicleSpeed(PlayerData[playerid][pDmvVeh]) < 85)
			{
				new point = GetPVarInt(playerid, "dmvPoint");
				if(IsPlayerInRangeOfPoint(playerid, 3.5, DMVRoute[point][0], DMVRoute[point][1], DMVRoute[point][2]))
				{
					point++;
					if(DMVRoute[point][0] != 0.0 && DMVRoute[point][1] != 0.0 && DMVRoute[point][2] != 0.0)
					{
						SetPVarInt(playerid, "dmvPoint", point);
						SetPlayerCheckpoint(playerid, DMVRoute[point][0], DMVRoute[point][1], DMVRoute[point][2], 3.5);
					}
					else
					{
						PlayerData[playerid][pDriveLic] = 1;
						PlayerData[playerid][pDriveLicTime] = gettime() + (15 * 86400);

						DisablePlayerCheckpoint(playerid);

						SendClientMessage(playerid, ARWIN, "DMV: {FFFFFF}Selamat! kamu berhasil mendapatkan {ffff00}Drive-Lic{ffffff} dengan masa aktif 14 hari.");
						SendClientMessage(playerid, ARWIN, "DMV: {FFFFFF}Kamu dapat perpanjang {FFFF00}Drive-Lic{ffffff} di {00FF00}DMV{ffffff}. Happy Driving!");
						
						PlayerPlaySound(playerid, SOUND_DMV_PASS_END);
						DMV_ResetVariables(playerid);
						UpdatePlayerData(playerid);
					}
				}
			}
			else
			{
				DMV_FailedTest(playerid);

				SendClientMessage(playerid, ARWIN, "DMV: {FFFFFF}Kamu telah gagal melakukan test dikarenakan {ff0000}Melebihi batas kecepatan{ffffff}.");
			}
		}
		else
		{
			DMV_FailedTest(playerid);

			SendClientMessage(playerid, ARWIN, "DMV: {FFFFFF}Kamu telah gagal melakukan test dikarenakan {ff0000}Keluar dari Kendaraan{ffffff}.");
		}
	}
	return 1;
}

// ---[ CMD ]--- //
CMD:newdrivelic(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1490.2839, 1305.6463, 1093.2963)) return SendErrorMessage(playerid, "Anda harus berada di DMV!");
	if(PlayerData[playerid][pDriveLic] != 0) return SendErrorMessage(playerid, "Anda sudah memiliki Driving License!");
	if(GetPlayerMoney(playerid) < 200) return SendErrorMessage(playerid, "Anda butuh $200 untuk membuat Driving License.");
	if(PlayerData[playerid][pDriveDelay] != 0) return SendErrorMessage(playerid, "Anda masih memiliki delay untuk membuat Drive-Lic kembali!");

	new fanstr[500];
	strcat(fanstr, sprintf("Selamat datang di DMV kota HopePride, %s!\n", PlayerData[playerid][pName]));
	strcat(fanstr, "Tempat ini dikhususkan untuk warga yang membuat Drive License\n");
	strcat(fanstr, "dan hanya membutuhkan {00ff00}$200{ffffff} dalam sekali pembuatan.\n\n");
	strcat(fanstr, "Beberapa aturan yang harus kamu taati:\n");
	strcat(fanstr, "I. Kamu akan melewati 2 test, yaitu:\n  -> Test Pengetahuan\n  -> Test Drive\n");
	strcat(fanstr, "II. Maksimal jawaban yang salah adalah 2\n");
	strcat(fanstr, "III. Jika gagal melakukan test, maka akan dikenakan {ff0000}Cooldown 2jam{ffffff}\n");
	strcat(fanstr, "IV. Maksimal kecepatan ketika melakukan test drive adalah 85mph\n");
	strcat(fanstr, "V. Ikuti setiap {ffff00}Checkpoint{ffffff}\n");
	strcat(fanstr, "VI. Kamu akan menerima {ffff00}Drive License{ffffff} jika sudah melakukan 2 test tersebut.\n\n");
	strcat(fanstr, "Apakah kamu siap melakukan pembuatan drivelic?");

	ShowPlayerDialog(playerid, DIALOG_DMV, DIALOG_STYLE_MSGBOX, "Department Motor Vehicle", fanstr, "Siap", "Tidak");
	return 1;
}

CMD:renewdrivelic(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1490.2839, 1305.6463, 1093.2963)) return SendErrorMessage(playerid, "Anda harus berada di DMV!");
	if(PlayerData[playerid][pDriveLic] == 0) return SendErrorMessage(playerid, "Anda tidak memiliki Driving License!");
	if(GetPlayerMoney(playerid) < 100) return SendErrorMessage(playerid, "Anda butuh $100 untuk memperbarui Driving License.");
	if(PlayerData[playerid][pDriveLicTime] != 0) return SendErrorMessage(playerid, "Driving License milikmu masih memiliki masa aktif!");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/renewdrivelic 'confirm' - Confirm");

	if(!strcmp(params, "confirm", true))
	{
		PlayerData[playerid][pDriveLicTime] = gettime() + (15 * 86400);
		GivePlayerMoneyEx(playerid, -100);
		Server_AddMoney(100);

		SendClientMessage(playerid, ARWIN, "DMV: {ffffff}Kamu telah memperpanjang {ffff00}Drive License{ffffff} dengan harga {00ff00}$100.0{ffffff}.");
	}
	else
		SendSyntaxMessage(playerid, "/renewdrivelic 'confirm' - Confirm");

	return 1;
}

// ---[ HOOK ]--- //
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_DMV)
	{
		if(response)
		{
			DMV_ResetVariables(playerid);

			SetPVarInt(playerid, "dmvQuest", random(sizeof(DMVQuest)));
			DMV_ShowDialog(playerid);	

			SetPVarInt(playerid, "dmvTest", 1);
			GivePlayerMoneyEx(playerid, -200);
			Server_AddMoney(200);

			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);

			SetPlayerCameraLookAt(playerid, 1501.3946, 1306.3634, 1093.7810);
			InterpolateCameraPos(playerid, x, y, z, 1501.3946, 1306.3634, 1093.7810, 5000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, 1498.5045, 1306.3648, 1093.7810, 1501.3946, 1306.3634, 1093.7810, 5000, CAMERA_CUT);

			switch(random(4))
			{
				case 0:
				{
					SetPlayerPos(playerid, 1501.6998, 1306.9183, 1093.2890);
					SetPlayerFacingAngle(playerid, 264.8466);
				}
				case 1:
				{
					SetPlayerPos(playerid, 1500.2523, 1305.1260, 1093.2890);
					SetPlayerFacingAngle(playerid, 275.9335);
				}
				case 2:
				{
					SetPlayerPos(playerid, 1500.3541, 1306.9874, 1093.2890);
					SetPlayerFacingAngle(playerid, 266.8004);
				}
				case 3:
				{
					SetPlayerPos(playerid, 1501.7972, 1307.0620, 1093.2890);
					SetPlayerFacingAngle(playerid, 270.0217);
				}
			} 

			ApplyAnimation(playerid,"PED","SEAT_idle",4.1, true, false, false, false, 0, SYNC_ALL);
		}
		else
			DMV_ResetVariables(playerid);
	}
	if(dialogid == DIALOG_DMV_TEST)
	{
		if(response)
		{
			new ansid = GetPVarInt(playerid, "dmvQuest"), total_answer = GetPVarInt(playerid, "dmvTotalAnswer"), rand = random(sizeof(DMVQuest));
			if(DMV_GetAnswerCorrect(ansid, listitem+1))
			{
				if(ansid == rand)
					rand = random(sizeof(DMVQuest));

				SetPVarInt(playerid, "dmvQuest", rand);
				SetPVarInt(playerid, "dmvTotalAnswer", ++total_answer);

				if(total_answer >= (sizeof(DMVQuest)-GetPVarInt(playerid, "dmvWrong")))
				{
					ClearAnimations(playerid, SYNC_ALL);
					SendClientMessage(playerid, ARWIN, "DMV: {FFFFFF}Selamat! kamu berhasil menjawab semua pertanyaan, sekarang kamu memasuki test ke 2.");
					SendClientMessage(playerid, ARWIN, "DMV: {FFFFFF}Kamu harus berhati hati ketika menyetir.");

					SetPVarInt(playerid, "dmvTest", 2);
					SetPVarInt(playerid, "dmvPoint", 0);
					PlayerData[playerid][pDmvVeh] = CreateVehicle(401, 2055.9841, -1903.6517, 13.3265, 179.0516, 1, 1, 0);
					SetVehicleHealth(PlayerData[playerid][pDmvVeh], 1000);
					SetVehicleVirtualWorld(PlayerData[playerid][pDmvVeh], 0);
					SetVehicleFuel(PlayerData[playerid][pDmvVeh], 100);
					LinkVehicleToInterior(PlayerData[playerid][pDmvVeh], 0);

					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid, 2055.9841, -1903.6517, 13.3265);

					PutPlayerInVehicle(playerid, PlayerData[playerid][pDmvVeh], 0);
					SetPlayerCheckpoint(playerid, DMVRoute[0][0], DMVRoute[0][1], DMVRoute[0][2], 3.5);
					return 1;
				}

				DMV_ShowDialog(playerid);
			}
			else
			{
				SetPVarInt(playerid, "dmvWrong", GetPVarInt(playerid, "dmvWrong")+1);

				new wrong = GetPVarInt(playerid, "dmvWrong");
				if(wrong >= 3)
				{
					SendClientMessage(playerid, ARWIN, "DMV: {FFFFFF}Kamu telah gagal melakukan {ff0000}Test Pengetahuan{ffffff} karna terlalu banyak salah menjawab.");
					SendClientMessage(playerid, ARWIN, "DMV: {FFFFFF}Kamu tidak akan bisa melakukan test kembali selama {ff0000}1 jam{ffffff}.");

					DMV_FailedTest(playerid);

					SetPlayerPos(playerid, 1490.2839, 1305.6463, 1093.2963);
					SetCameraBehindPlayer(playerid);
					ClearAnimations(playerid, SYNC_ALL);

					DMV_ResetVariables(playerid);
				}
				else
				{
					SetPVarInt(playerid, "dmvQuest", GetPVarInt(playerid, "dmvQuest")+1);
					SendClientMessage(playerid, ARWIN, "DMV: {FFFFFF}Kamu telah salah menjawab, total kamu salah {ff0000}%d/3{ffffff}.", wrong);

					DMV_ShowDialog(playerid);
				}
			}
		}
	}
	return 1;
}

/*
	new sext[40], mstr[128];
	if(PlayerData[playerid][pGender] == 1) { sext = "Laki-Laki"; } else { sext = "Perempuan"; }
	format(mstr, sizeof(mstr), "{FFFFFF}Nama: %s\nNegara: San Andreas\nTgl Lahir: %s\nJenis Kelamin: %s\nBerlaku hingga 14 hari!", PlayerData[playerid][pName], PlayerData[playerid][pAge], sext);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Driving License", mstr, "Tutup", "");
	PlayerData[playerid][pDriveLic] = 1;
	PlayerData[playerid][pDriveLicTime] = gettime() + (15 * 86400);
*/
