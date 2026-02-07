//----------------[ Dialog System ]--------------
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(strlen(inputtext) > 0)
		printf("[OnDialogResponse]: %s(%d) has used dialog id: %d Listitem: %d Inputtext: %s Response: %d", GetName(playerid), playerid, dialogid, listitem, inputtext, response);
	else
		printf("[OnDialogResponse]: %s(%d) has used dialog id: %d Listitem: %d Response: %d", GetName(playerid), playerid, dialogid, listitem, response);

	if(!response)
		ResetValueListitem(playerid);

	if(dialogid == DIALOG_LOGIN) 
    {
    	new fan[560];
        if (!response)
            return KickEx(playerid);

        if (isnull(inputtext))
        {
            format(fan, sizeof(fan), ""WHITE_E"Selamat Datang di "RED_E"HopePride"WHITE_E", %s!\n\nNama UCP: %s\nStatus: "GREEN_E"Sudah Terdaftar"WHITE_E"\nVersion: "GREY_E""TEXT_VERSION""WHITE_E"\n\nMasukan password akun kamu:", UcpData[playerid][uUsername], UcpData[playerid][uUsername]);
	        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", fan, "Masuk", "");
            return 1;
        }

        bcrypt_verify(playerid, "OnPlayerVerifyPassword", inputtext, UcpData[playerid][uPassword]);
    }
    if(dialogid == DIALOG_REGISTER)
    {
        if(!response) {
            SendErrorMessage(playerid, "Gagal melakukan registrasi, anda keluar dari server.");
            KickEx(playerid);
        }
        else 
        {
            if(strlen(inputtext) < 8 || strlen(inputtext) > 32)
            {
                new fan[250];
                format(fan, sizeof(fan), ""WHITE_E"Selamat Datang di "RED_E"HopePride"WHITE_E", %s!\n\nNama UCP: %s\nStatus: "LRED_E"Sudah Terdaftar tapi tidak memiliki password"WHITE_E"\nVersion: "GREY_E""TEXT_VERSION""WHITE_E"\n\nMasukan password yang ingin kamu masukan:\n(Password harus lebih dari 8 huruf dan kurang dari 32 huruf)", UcpData[playerid][uUsername], UcpData[playerid][uUsername]);
        		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", fan, "Daftarkan", "");
                return 1;
            }
            
			bcrypt_hash(playerid, "OnPlayerPasswordAdd", inputtext, BCRYPT_COST);     
		}
    }
    if(dialogid == DIALOG_VERIFYCODE)
    {
    	if(response)
    	{
    		new fan[256];
    		if(!strcmp(inputtext, UcpData[playerid][uVerifyCode]))
    		{
    			mysql_tquery(g_SQL, sprintf("UPDATE ucp SET verifystatus = '1' WHERE username = '%s'", SQL_EscapeString(UcpData[playerid][uUsername])));
    			format(fan, sizeof(fan), ""WHITE_E"Selamat Datang di "RED_E"HopePride"WHITE_E", %s!\n\nNama UCP: %s\nStatus: "LRED_E"Sudah Terdaftar"WHITE_E"\nVersion: "GREY_E""TEXT_VERSION""WHITE_E"\n\nMasukan password yang ingin kamu masukan:", UcpData[playerid][uUsername], UcpData[playerid][uUsername]);
        		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", fan, "Daftarkan", "");
    		}
    		else
    		{
    			format(fan, sizeof(fan), ""WHITE_E"Selamat Datang di "RED_E"HopePride"WHITE_E", %s!\n\nNama UCP: %s\nStatus: "LRED_E"Sudah Terdaftar tapi belum Verifikasi"WHITE_E"\nVersion: "GREY_E""TEXT_VERSION""WHITE_E"\n\nMasukan PIN yang diberi oleh bot kami:", UcpData[playerid][uUsername], UcpData[playerid][uUsername]);
        		ShowPlayerDialog(playerid, DIALOG_VERIFYCODE, DIALOG_STYLE_INPUT, "Verifikasi Kode", fan, "Masukan", "");
    		}
    	}
    }
    if(dialogid == DIALOG_SELECTCHAR)
    {
        if (!response)
            return KickEx(playerid);

        if (isempty(CharacterList[playerid][listitem]))
            return ShowPlayerDialog(playerid, DIALOG_CREATECHAR, DIALOG_STYLE_INPUT, "Create Character", ""WHITE_E"Masukkan nama karakter, maksimal 24 karakter\n\nContoh: "YELLOW_E"Sean_Rutledge, Eddison_Murphy dan lainnya.", "Create", "Back");

        PlayerData[playerid][pChar] = listitem;
        SetPlayerName(playerid, CharacterList[playerid][listitem]);

        if(!Blacklist_CheckByName(CharacterList[playerid][listitem]))
        {
        	new cQuery[256];
        	mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT * FROM `players` WHERE `username` = '%s' LIMIT 1;", SQL_EscapeString(CharacterList[playerid][listitem]));
        	mysql_tquery(g_SQL, cQuery, "AssignPlayerData", "d", playerid); 
        }
        else
        {
        	Blacklist_Menu(playerid, false);
        }
        return 1;
    }
    if(dialogid == DIALOG_CREATECHAR)
    {
        if (!response)
            return ShowCharacterMenu(playerid);

        if (!IsValidRoleplayName(inputtext) || strlen(inputtext) <= 3 && strlen(inputtext) > 24) {
            SendClientMessage(playerid, COLOR_WHITE, "Nama harus sesuai dengan aturan Roleplay, Contoh: Sean_Rutledge, Eddison_Murphy");
            return ShowPlayerDialog(playerid, DIALOG_CREATECHAR, DIALOG_STYLE_INPUT, "Create Character", ""WHITE_E"Masukkan nama karakter, maksimal 24 karakter\n\nContoh: "YELLOW_E"Sean_Rutledge, Eddison_Murphy dan lainnya.", "Create", "Back");
        }

        new cQuery[256];
        mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT * FROM `players` WHERE `username` = '%s' LIMIT 1;", SQL_EscapeString(inputtext));
        mysql_tquery(g_SQL, cQuery, "OnCharacterCheck", "is", playerid, inputtext); 
    }
	if(dialogid == DIALOG_AGE)
    {
		if(!response) return ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
		if(response)
		{
			new
				iDay,
				iMonth,
				iYear,
				day,
				month,
				year;
				
			getdate(year, month, day);

			static const
					arrMonthDays[] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

			if(sscanf(inputtext, "p</>ddd", iDay, iMonth, iYear)) {
				ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else if(iYear < 1900 || iYear > year) {
				ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tahun Lahir", "Error! Masukkan minimal tahun 1990-%d\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal", year);
			}
			else if(iMonth < 1 || iMonth > 12) {
				ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Bulan Lahir", "Error! Masukan salah satu dari 1-12 bulan\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else if(iDay < 1 || iDay > arrMonthDays[iMonth - 1]) {
				ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Error! Masukan tanggal 1-%d\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal", arrMonthDays[iMonth - 1]);
			}
			else 
			{
				format(PlayerData[playerid][pAge], 50, inputtext);
				new fanstr[256];
				forex(fan, sizeof(fan_Spawn)) 
				{
					strcat(fanstr, sprintf("%s\t\t\n", fan_Spawn[fan][sName]));
				}
				ShowPlayerDialog(playerid, DIALOG_SELECTSPAWN, DIALOG_STYLE_TABLIST, "Select FirstSpawn", fanstr, "Spawn", "");
			}
		}
		else ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
		return 1;
	}
	if(dialogid == DIALOG_SELECTSPAWN)
	{
		if(response)
		{
			PlayerData[playerid][pPosX] = fan_Spawn[listitem][sPosX];
			PlayerData[playerid][pPosY] = fan_Spawn[listitem][sPosY];
			PlayerData[playerid][pPosZ] = fan_Spawn[listitem][sPosZ];
			PlayerData[playerid][pPosA] = fan_Spawn[listitem][sPosA];

			ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male/Laki-Laki\n2. Female/Perempuan", "Pilih", "");
		}
	}	
	if(dialogid == DIALOG_GENDER)
    {
		if(!response) return ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male/Laki-Laki\n2. Female/Perempuan", "Pilih", "Batal");
		if(response)
		{
			PlayerData[playerid][pGender] = listitem + 1;
			switch(listitem) 
			{
				case 0: ShowModelSelectionMenu(playerid, "Choose Your Skin", SPAWN_MODEL_MALE, SpawnSkinMale, sizeof(SpawnSkinMale));
				case 1: ShowModelSelectionMenu(playerid, "Choose Your Skin", SPAWN_MODEL_FEMALE, SpawnSkinFemale, sizeof(SpawnSkinFemale));
			}
		}
		else ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male/Laki-Laki\n2. Female/Perempuan", "Pilih", "Batal");
		return 1;
	}
	if(dialogid == DIALOG_EMAIL)
	{
		if(response)
		{
			if(isnull(inputtext))
			{
				SendErrorMessage(playerid, "This field cannot be left empty!");
				callcmd::email(playerid);
				return 1;
			}
			if(!(2 < strlen(inputtext) < 40))
			{
				SendErrorMessage(playerid, "Please insert a valid email! Must be between 3-40 characters.");
				callcmd::email(playerid);
				return 1;
			}
			if(!IsValidPassword(inputtext))
			{
				SendErrorMessage(playerid, "Email can contain only A-Z, a-z, 0-9, _, [ ], ( )  and @");
				callcmd::email(playerid);
				return 1;
			}
			new query[512];
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET email='%e' WHERE reg_id='%d'", SQL_EscapeString(inputtext), PlayerData[playerid][pID]);
			mysql_tquery(g_SQL, query);
			SendServerMessage(playerid, "Your e-mail has been set to "YELLOW_E"%s!"WHITE_E"(relogin for /stats update)", inputtext);
			return 1;
		}
	}
	if(dialogid == DIALOG_PASSWORD)
	{
		if(response)
		{
			if(!(3 < strlen(inputtext) < 20))
			{
				SendErrorMessage(playerid, "Please insert a valid password! Must be between 4-20 characters.");
				callcmd::changepass(playerid);
				return 1;
			}
			if(!IsValidPassword(inputtext))
			{
				SendErrorMessage(playerid, "Password can contain only A-Z, a-z, 0-9, _, [ ], ( )");
				callcmd::changepass(playerid);
				return 1;
			}
			bcrypt_hash(playerid, "OnPlayerChangePassword", inputtext, BCRYPT_COST);
		}
	}
	if(dialogid == DIALOG_STATS)
	{
		if(response)
		{
			return callcmd::settings(playerid);
		}
	}
	if(dialogid == DIALOG_SETTINGS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					return callcmd::email(playerid);
				}
				case 1:
				{
					return callcmd::changepass(playerid);
				}
				case 2:
				{	
					ShowPlayerDialog(playerid, DIALOG_HBEMODE, DIALOG_STYLE_LIST, "HBE Mode", ""LG_E"Simple\n"LG_E"Modern\n"RED_E"Disable", "Set", "Close");
				}
				/*case 3:
				{
					ShowPlayerDialog(playerid, DIALOG_INVMODE, DIALOG_STYLE_LIST, "Inventory Style", ""LG_E"Dialog\n"LG_E"Textdraw", "Set", "Close");
				}*/
				case 3:
				{
					return callcmd::togpm(playerid);
				}
				case 4:
				{
					return callcmd::toglog(playerid);
				}
				case 5:
				{
					return callcmd::togads(playerid);
				}
				case 6:
				{
					return callcmd::togwt(playerid);
				}
			}
		}
	}
	if(dialogid == DIALOG_HBEMODE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					PlayerData[playerid][pHBEMode] = 1;

					HBE_Hide(playerid, 1);
					HBE_Hide(playerid, 2);

					HBEVeh_Hide(playerid, 1);
					HBEVeh_Hide(playerid, 2);
					
					HBE_Show(playerid, 1);
					if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
						HBEVeh_Show(playerid, 1);

					TextDrawShowForPlayer(playerid, TextDate);
					TextDrawShowForPlayer(playerid, TextTime);
				}
				case 1:
				{
					PlayerData[playerid][pHBEMode] = 2;

					HBE_Hide(playerid, 1);
					HBE_Hide(playerid, 2);

					HBEVeh_Hide(playerid, 1);
					HBEVeh_Hide(playerid, 2);
					
					HBE_Show(playerid, 2);
					if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
						HBEVeh_Show(playerid, 2);

					TextDrawShowForPlayer(playerid, TextDate);
					TextDrawShowForPlayer(playerid, TextTime);
				}
				case 2:
				{
					PlayerData[playerid][pHBEMode] = 0;

					HBE_Hide(playerid, 1);
					HBE_Hide(playerid, 2);

					HBEVeh_Hide(playerid, 1);
					HBEVeh_Hide(playerid, 2);
				}
			}
		}
	}
	if(dialogid == DIALOG_INVMODE)
	{
		if(response)
		{
			PlayerData[playerid][pInvMode] = listitem+1;
		}
	}
	if(dialogid == DIALOG_CHANGEAGE)
    {
		if(response)
		{
			new
				iDay,
				iMonth,
				iYear,
				day,
				month,
				year;
				
			getdate(year, month, day);

			static const
					arrMonthDays[] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

			if(sscanf(inputtext, "p</>ddd", iDay, iMonth, iYear)) {
				ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else if(iYear < 1900 || iYear > year) {
				ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Tahun Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else if(iMonth < 1 || iMonth > 12) {
				ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Bulan Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else if(iDay < 1 || iDay > arrMonthDays[iMonth - 1]) {
				ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else 
			{
				format(PlayerData[playerid][pAge], 50, inputtext);
				SendInfoMessage(playerid, "New Age for your character is "YELLOW_E"%s.", PlayerData[playerid][pAge]);
				GivePlayerMoneyEx(playerid, -300);
				Server_AddMoney(300);
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_GOLDSHOP)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(PlayerData[playerid][pGold] < 500) return SendErrorMessage(playerid, "Not enough gold!");
					ShowPlayerDialog(playerid, DIALOG_GOLDNAME, DIALOG_STYLE_INPUT, "Change Name", "Input new nickname:\nExample: Charles_Sanders\n", "Change", "Cancel");
				}
				case 1:
				{
					if(PlayerData[playerid][pGold] < 1000) return SendErrorMessage(playerid, "Not enough gold!");
					PlayerData[playerid][pGold] -= 1000;
					PlayerData[playerid][pWarn] = 0;
					SendInfoMessage(playerid, "Warning have been reseted for 1000 gold. Total Warning: 0");
				}
				case 2:
				{
					if(PlayerData[playerid][pGold] < 150) return SendErrorMessage(playerid, "Not enough gold!");
					PlayerData[playerid][pGold] -= 150;
					PlayerData[playerid][pVip] = 1;
					PlayerData[playerid][pVipTime] = gettime() + (7 * 86400);
					SendInfoMessage(playerid, "You has bought VIP level 1 for 150 gold(7 days).");
				}
				case 3:
				{
					if(PlayerData[playerid][pGold] < 250) return SendErrorMessage(playerid, "Not enough gold!");
					PlayerData[playerid][pGold] -= 250;
					PlayerData[playerid][pVip] = 2;
					PlayerData[playerid][pVipTime] = gettime() + (7 * 86400);
					SendInfoMessage(playerid, "You has bought VIP level 2 for 250 gold(7 days).");
				}
				case 4:
				{
					if(PlayerData[playerid][pGold] < 500) return SendErrorMessage(playerid, "Not enough gold!");
					PlayerData[playerid][pGold] -= 500;
					PlayerData[playerid][pVip] = 3;
					PlayerData[playerid][pVipTime] = gettime() + (7 * 86400);
					SendInfoMessage(playerid, "You has bought VIP level 3 for 500 gold(7 days).");
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_GOLDNAME)
	{
		if(response)
		{
			if(strlen(inputtext) < 4) return SendErrorMessage(playerid, "New name can't be shorter than 4 characters!"),  ShowPlayerDialog(playerid, DIALOG_GOLDNAME, DIALOG_STYLE_INPUT, ""WHITE_E"Change Name", "Enter your new name:", "Enter", "Exit");
			if(strlen(inputtext) > 20) return SendErrorMessage(playerid, "New name can't be longer than 20 characters!"),  ShowPlayerDialog(playerid, DIALOG_GOLDNAME, DIALOG_STYLE_INPUT, ""WHITE_E"Change Name", "Enter your new name:", "Enter", "Exit");
			if(!IsValidRoleplayName(inputtext))
			{
				SendErrorMessage(playerid, "Name contains invalid characters, please doublecheck!");
				ShowPlayerDialog(playerid, DIALOG_GOLDNAME, DIALOG_STYLE_INPUT, ""WHITE_E"Change Name", "Enter your new name:", "Enter", "Exit");
				return 1;
			}
			new query[512];
			mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE username='%s'", SQL_EscapeString(inputtext));
			mysql_tquery(g_SQL, query, "ChangeName", "is", playerid, inputtext);
		}
		return 1;
	}
	//-----------[ Bisnis Dialog ]------------
	if(dialogid == DIALOG_SELL_BISNISS)
	{
		if(!response) return 1;
		new str[248];
		SetPVarInt(playerid, "SellingBisnis", ReturnPlayerBisnisID(playerid, (listitem + 1)));
		format(str, sizeof(str), "Are you sure you will sell bisnis id: %d", GetPVarInt(playerid, "SellingBisnis"));
				
		ShowPlayerDialog(playerid, DIALOG_SELL_BISNIS, DIALOG_STYLE_MSGBOX, "Sell Bisnis", str, "Sell", "Cancel");
	}
	if(dialogid == DIALOG_SELL_BISNIS)
	{
		if(response)
		{
			new bid = GetPVarInt(playerid, "SellingBisnis"), price;
			price = bData[bid][bPrice] / 2;
			GivePlayerMoneyEx(playerid, price);
			SendInfoMessage(playerid, "Anda berhasil menjual bisnis id (%d) dengan setengah harga("LG_E"%s"WHITE_E") pada saat anda membelinya.", bid, FormatMoney(price));
			Bisnis_Reset(bid);
			Bisnis_Save(bid);
			Bisnis_Refresh(bid);
		}
		DeletePVar(playerid, "SellingBisnis");
		return 1;
	}
	if(dialogid == DIALOG_MY_BISNIS)
	{
		if(!response) return true;
		SetPVarInt(playerid, "ClickedBisnis", ReturnPlayerBisnisID(playerid, (listitem + 1)));
		ShowPlayerDialog(playerid, BISNIS_INFO, DIALOG_STYLE_LIST, "Bisnis Menu", "Show Information\nTrack Bisnis", "Select", "Cancel");
		return 1;
	}
	if(dialogid == BISNIS_INFO)
	{
		if(!response) return true;
		new bid = GetPVarInt(playerid, "ClickedBisnis");
		switch(listitem)
		{
			case 0:
			{
				new line9[900];
				new lock[128], type[128];
				if(bData[bid][bLocked] == 1)
				{
					lock = "{FF0000}Locked";
			
				}
				else
				{
					lock = "{00FF00}Unlocked";
				}
				if(bData[bid][bType] == 1)
				{
					type = "Fast Food";
			
				}
				else if(bData[bid][bType] == 2)
				{
					type = "Market";
				}
				else if(bData[bid][bType] == 3)
				{
					type = "Clothes";
				}
				else if(bData[bid][bType] == 4)
				{
					type = "Equipment";
				}
				else
				{
					type = "Unknow";
				}
				format(line9, sizeof(line9), "Bisnis ID: %d\nBisnis Owner: %s\nBisnis Name: %s\nBisnis Price: %s\nBisnis Type: %s\nBisnis Status: %s\nBisnis Product: %d",
				bid, bData[bid][bOwner], bData[bid][bName], FormatMoney(bData[bid][bPrice]), type, lock, bData[bid][bProd]);

				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Bisnis Info", line9, "Close","");
			}
			case 1:
			{
				PlayerData[playerid][pTrackBisnis] = 1;
				SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ], 0.0, 0.0, 0.0, 3.5);
				//SetPlayerCheckpoint(playerid, bData[bid][bExtpos][0], bData[bid][bExtpos][1], bData[bid][bExtpos][2], 4.0);
				SendInfoMessage(playerid, "Ikuti checkpoint untuk menemukan bisnis anda!");
			}
		}
		return 1;
	}
	if(dialogid == BISNIS_MENU)
	{
		new bid = PlayerData[playerid][pInBiz];
		new lock[128];
		if(bData[bid][bLocked] == 1)
		{
			lock = "Locked";
		}
		else
		{
			lock = "Unlocked";
		}
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{	
					new mstr[248], lstr[512];
					format(mstr,sizeof(mstr),"Bisnis ID %d", bid);
					format(lstr,sizeof(lstr),"Bisnis Name:\t%s\nBisnis Locked:\t%s\nBisnis Product:\t%d\nBisnis Vault:\t%s", bData[bid][bName], lock, bData[bid][bProd], FormatMoney(bData[bid][bMoney]));
					ShowPlayerDialog(playerid, BISNIS_INFO, DIALOG_STYLE_TABLIST, mstr, lstr,"Back","Close");
				}
				case 1:
				{
					new mstr[248];
					format(mstr,sizeof(mstr),"Nama sebelumnya: %s\n\nMasukkan nama bisnis yang kamu inginkan\nMaksimal 32 karakter untuk nama bisnis", bData[bid][bName]);
					ShowPlayerDialog(playerid, BISNIS_NAME, DIALOG_STYLE_INPUT,"Bisnis Name", mstr,"Done","Back");
				}
				case 2: ShowPlayerDialog(playerid, BISNIS_VAULT, DIALOG_STYLE_LIST,"Bisnis Vault","Deposit\nWithdraw","Next","Back");
				case 3:
				{
					Bisnis_ProductMenu(playerid, bid);
				}
				case 4:
				{
					if(bData[bid][bProd] > 100)
						return SendErrorMessage(playerid, "Bisnis ini masih memiliki cukup produck.");
					if(bData[bid][bMoney] < 1000)
						return SendErrorMessage(playerid, "Setidaknya anda mempunyai uang dalam bisnis anda senilai $1.000 untuk merestock product.");
					bData[bid][bRestock] = 1;
					SendInfoMessage(playerid, "Anda berhasil request untuk mengisi stock product kepada trucker, harap tunggu sampai pekerja trucker melayani.");
				}
			}
		}
		return 1;
	}
	if(dialogid == BISNIS_INFO)
	{
		if(response)
		{
			return callcmd::bm(playerid, "\0");
		}
		return 1;
	}
	if(dialogid == BISNIS_NAME)
	{
		if(response)
		{
			new bid = PlayerData[playerid][pInBiz];

			if(!Player_OwnsBisnis(playerid, PlayerData[playerid][pInBiz])) return SendErrorMessage(playerid, "You don't own this bisnis.");
			
			if (isnull(inputtext))
			{
				new mstr[512];
				format(mstr,sizeof(mstr),""RED_E"NOTE: "WHITE_E"Nama Bisnis tidak di perbolehkan kosong!\n\n"WHITE_E"Nama sebelumnya: %s\n\nMasukkan nama Bisnis yang kamu inginkan\nMaksimal 32 karakter untuk nama Bisnis", bData[bid][bName]);
				ShowPlayerDialog(playerid, BISNIS_NAME, DIALOG_STYLE_INPUT,"Bisnis Name", mstr,"Done","Back");
				return 1;
			}
			if(strlen(inputtext) > 32 || strlen(inputtext) < 5)
			{
				new mstr[512];
				format(mstr,sizeof(mstr),""RED_E"NOTE: "WHITE_E"Nama Bisnis harus 5 sampai 32 karakter.\n\n"WHITE_E"Nama sebelumnya: %s\n\nMasukkan nama Bisnis yang kamu inginkan\nMaksimal 32 karakter untuk nama Bisnis", bData[bid][bName]);
				ShowPlayerDialog(playerid, BISNIS_NAME, DIALOG_STYLE_INPUT,"Bisnis Name", mstr,"Done","Back");
				return 1;
			}
			format(bData[bid][bName], 32, ColouredText(inputtext));

			Bisnis_Refresh(bid);
			Bisnis_Save(bid);

			SendServerMessage(playerid, "Bisnis name set to: \"%s\".", bData[bid][bName]);
		}
		else return callcmd::bm(playerid, "\0");
		return 1;
	}
	if(dialogid == BISNIS_VAULT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new mstr[512];
					format(mstr,sizeof(mstr),"Uang kamu: %s.\n\nMasukkan berapa banyak uang yang akan kamu simpan di dalam bisnis ini", FormatMoney(GetPlayerMoney(playerid)));
					ShowPlayerDialog(playerid, BISNIS_DEPOSIT, DIALOG_STYLE_INPUT, "Deposit", mstr, "Deposit", "Back");
				}
				case 1:
				{
					new mstr[512];
					format(mstr,sizeof(mstr),"Business Vault: %s\n\nMasukkan berapa banyak uang yang akan kamu ambil di dalam bisnis ini", FormatMoney(bData[PlayerData[playerid][pInBiz]][bMoney]));
					ShowPlayerDialog(playerid, BISNIS_WITHDRAW, DIALOG_STYLE_INPUT,"Withdraw", mstr,"Withdraw","Back");
				}
			}
		}
		return 1;
	}
	if(dialogid == BISNIS_WITHDRAW)
	{
		if(response)
		{
			new bid = PlayerData[playerid][pInBiz];
			new amount = floatround(strval(inputtext));
			if(amount < 1 || amount > bData[bid][bMoney])
				return SendErrorMessage(playerid, "Invalid amount specified!");

			bData[bid][bMoney] -= amount;
			Bisnis_Save(bid);

			GivePlayerMoneyEx(playerid, amount);

			SendClientMessage(playerid, COLOR_LBLUE,"BUSINESS: "WHITE_E"You have withdrawn "GREEN_E"%s "WHITE_E"from the business vault.", FormatMoney(strval(inputtext)));
		}
		else
			ShowPlayerDialog(playerid, BISNIS_VAULT, DIALOG_STYLE_LIST,"Business Vault","Deposit\nWithdraw","Next","Back");
		return 1;
	}
	if(dialogid == BISNIS_DEPOSIT)
	{
		if(response)
		{
			new bid = PlayerData[playerid][pInBiz];
			new amount = floatround(strval(inputtext));
			if(amount < 1 || amount > GetPlayerMoney(playerid))
				return SendErrorMessage(playerid, "Invalid amount specified!");

			bData[bid][bMoney] += amount;
			Bisnis_Save(bid);

			GivePlayerMoneyEx(playerid, -amount);
			
			SendClientMessage(playerid, COLOR_LBLUE,"BUSINESS: "WHITE_E"You have deposit "GREEN_E"%s "WHITE_E"into the business vault.", FormatMoney(strval(inputtext)));
		}
		else
			ShowPlayerDialog(playerid, BISNIS_VAULT, DIALOG_STYLE_LIST,"Business Vault","Deposit\nWithdraw","Next","Back");
		return 1;
	}
	if(dialogid == BISNIS_BUYPROD)
	{
		static
        bizid = -1,
        price;

		if((bizid = PlayerData[playerid][pInBiz]) != -1 && response)
		{
			price = bData[bizid][bP][listitem];

			if(GetPlayerMoney(playerid) < price)
				return SendErrorMessage(playerid, "Tidak cukup uang untuk membeli!");

			if(bData[bizid][bProd] < 1)
				return SendErrorMessage(playerid, "Bisnis ini tidak memiliki stock produk!");

			if(price == 0)
				return SendErrorMessage(playerid, "Harga tidak dapat dibeli!");
				
			new Float:health;
			GetPlayerHealth(playerid,health);
			if(bData[bizid][bType] == 1)
			{
				switch(listitem)
				{
					case 0:
					{
						if(PlayerData[playerid][pHunger]+15 >= 100)
							return SendErrorMessage(playerid, "Kamu tidak membutuhkannya untuk sekarang!");

						GivePlayerMoneyEx(playerid, -price);
						PlayerData[playerid][pHunger] += 15;
						ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, false, false, false, false, 0, SYNC_ALL);
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 1:
					{
						if(PlayerData[playerid][pHunger]+15 >= 100)
							return SendErrorMessage(playerid, "Kamu tidak membutuhkannya untuk sekarang!");

						GivePlayerMoneyEx(playerid, -price);
						PlayerData[playerid][pHunger] += 15;
						ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, false, false, false, false, 0, SYNC_ALL);
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 2:
					{
						if(PlayerData[playerid][pHunger]+10 >= 100)
							return SendErrorMessage(playerid, "Kamu tidak membutuhkannya untuk sekarang!");

						GivePlayerMoneyEx(playerid, -price);
						PlayerData[playerid][pHunger] += 10;
						ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, false, false, false, false, 0, SYNC_ALL);
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 3:
					{
						if(PlayerData[playerid][pEnergy]+15 >= 100)
							return SendErrorMessage(playerid, "Kamu tidak membutuhkannya untuk sekarang!");

						GivePlayerMoneyEx(playerid, -price);
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
						PlayerData[playerid][pEnergy] += 20;
						ApplyAnimation(playerid, "VENDING", "VEND_DRINK2_P", 4.1, false, false, false, false, 0, SYNC_ALL);
					}
				}
			}
			else if(bData[bizid][bType] == 2)
			{
				switch(listitem)
				{
					case 0:
					{
						if(Inventory_Add(playerid, "Snack") == -1)
							return 1;

						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli snack seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 1:
					{
						if(Inventory_Add(playerid, "Mineral Water") == -1)
							return 1;
						
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli mineral water seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 2:
					{
						if(Inventory_Add(playerid, "Milk") == -1)
							return 1;
						
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli milk seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 3:
					{
						if(Inventory_Add(playerid, "Fuel Can") == -1)
							return 1;

						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli Gas Fuel seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 4:
					{
						if(Inventory_Add(playerid, "First Aid") == -1)
							return 1;

						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli Perban seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 5:
					{
						if(Inventory_Add(playerid, "Handphone") == -1)
							return 1;

						GivePlayerMoneyEx(playerid, -price);
						new query[128], rand = RandomEx(1111, 9888);
						new phone = rand+PlayerData[playerid][pID];
						mysql_format(g_SQL, query, sizeof(query), "SELECT phone FROM players WHERE phone='%d'", phone);
						mysql_tquery(g_SQL, query, "PhoneNumber", "id", playerid, phone);
						//PlayerData[playerid][pPhone] = ;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli phone seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 6:
					{
						GivePlayerMoneyEx(playerid, -price);
						PlayerData[playerid][pPhoneCredit] += 20;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli 20 phone credit seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 7:
					{
						GivePlayerMoneyEx(playerid, -price);
						PlayerData[playerid][pPhoneBook] = 1;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli sebuah phone book seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 8:
					{
						if(Inventory_Add(playerid, "Walkie Talkie") == -1)
							return 1;

						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli sebuah walkie talkie seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 9:
					{
						if(Inventory_Add(playerid, "Boombox") == -1)
							return 1;

						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli sebuah boombox seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
				}
			}
			else if(bData[bizid][bType] == 3)
			{
				switch(listitem)
				{
					case 0:
					{
						switch(PlayerData[playerid][pGender])
						{
							case 1: ShowModelSelectionMenu(playerid, "Choose Your Skin", SHOP_MODEL_MALE, ShopSkinMale, sizeof(ShopSkinMale));
							case 2: ShowModelSelectionMenu(playerid, "Choose Your Skin", SHOP_MODEL_FEMALE, ShopSkinFemale, sizeof(ShopSkinFemale));
						}
					}
					case 1:
					{
						new string[248];
						if(pToys[playerid][0][toy_model] == 0)
						{
							strcat(string, ""dot"Slot 1\n");
						}
						else strcat(string, ""dot"Slot 1 "RED_E"(Used)\n");

						if(pToys[playerid][1][toy_model] == 0)
						{
							strcat(string, ""dot"Slot 2\n");
						}
						else strcat(string, ""dot"Slot 2 "RED_E"(Used)\n");

						if(pToys[playerid][2][toy_model] == 0)
						{
							strcat(string, ""dot"Slot 3\n");
						}
						else strcat(string, ""dot"Slot 3 "RED_E"(Used)\n");

						if(pToys[playerid][3][toy_model] == 0)
						{
							strcat(string, ""dot"Slot 4\n");
						}
						else strcat(string, ""dot"Slot 4 "RED_E"(Used)\n");

						/*if(pToys[playerid][4][toy_model] == 0)
						{
							strcat(string, ""dot"Slot 5\n");
						}
						else strcat(string, ""dot"Slot 5 "RED_E"(Used)\n");

						if(pToys[playerid][5][toy_model] == 0)
						{
							strcat(string, ""dot"Slot 6\n");
						}
						else strcat(string, ""dot"Slot 6 "RED_E"(Used)\n");*/

						ShowPlayerDialog(playerid, DIALOG_TOYBUY, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
					}
					case 2:
					{
						if(Inventory_Add(playerid, "Mask") == -1)
							return 1;

						GivePlayerMoneyEx(playerid, -price);
						PlayerData[playerid][pMaskID] = random(90000) + 10000;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli mask seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 3:
					{
						GivePlayerMoneyEx(playerid, -price);
						PlayerData[playerid][pHelmet] = 1;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli Helmet seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
				}
			}
			else if(bData[bizid][bType] == 4)
			{
				switch(listitem)
				{
					case 0:
					{
						GivePlayerMoneyEx(playerid, -price);
						GivePlayerWeaponEx(playerid, WEAPON:1, 1);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli Brass Knuckles seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 1:
					{
						if(PlayerData[playerid][pJob] == 7 || PlayerData[playerid][pJob2] == 7)
						{
							GivePlayerMoneyEx(playerid, -price);
							GivePlayerWeaponEx(playerid, WEAPON:4, 1);
							SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli Knife seharga %s.", ReturnName(playerid), FormatMoney(price));
							bData[bizid][bProd]--;
							bData[bizid][bMoney] += Server_Percent(price);
							Server_AddPercent(price);
							Bisnis_Save(bizid);
						}
						else return SendErrorMessage(playerid, "Job farmer only!");
					}
					case 2:
					{
						GivePlayerMoneyEx(playerid, -price);
						GivePlayerWeaponEx(playerid, WEAPON:5, 1);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli Baseball Bat seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 3:
					{
						if(PlayerData[playerid][pJob] == 5 || PlayerData[playerid][pJob2] == 5)
						{
							GivePlayerMoneyEx(playerid, -price);
							GivePlayerWeaponEx(playerid, WEAPON:6, 1);
							SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli Shovel seharga %s.", ReturnName(playerid), FormatMoney(price));
							bData[bizid][bProd]--;
							bData[bizid][bMoney] += Server_Percent(price);
							Server_AddPercent(price);
							Bisnis_Save(bizid);
						}
						else return SendErrorMessage(playerid, "Job miner only!");
					}
					case 4:
					{
						if(PlayerData[playerid][pJob] == 3 || PlayerData[playerid][pJob2] == 3)
						{
							GivePlayerMoneyEx(playerid, -price);
							GivePlayerWeaponEx(playerid, WEAPON:9, 1);
							SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli Chainsaw seharga %s.", ReturnName(playerid), FormatMoney(price));
							bData[bizid][bProd]--;
							bData[bizid][bMoney] += Server_Percent(price);
							Server_AddPercent(price);
							Bisnis_Save(bizid);
						}
						else return SendErrorMessage(playerid, "Job lumber jack only!");
					}
					case 5:
					{
						GivePlayerMoneyEx(playerid, -price);
						GivePlayerWeaponEx(playerid, WEAPON:15, 1);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli Cane seharga %s.", ReturnName(playerid), FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == BISNIS_EDITPROD)
	{
		if(Player_OwnsBisnis(playerid, PlayerData[playerid][pInBiz]))
		{
			if(response)
			{
				static
					item[40],
					str[128];

				strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
				strpack(PlayerData[playerid][pEditingItem], item, 40 char);

				PlayerData[playerid][pProductModify] = listitem;
				format(str,sizeof(str), "Please enter the new product price for %s:", item);
				ShowPlayerDialog(playerid, BISNIS_PRICESET, DIALOG_STYLE_INPUT, "Business: Set Price", str, "Modify", "Back");
			}
			else
				return callcmd::bm(playerid, "\0");
		}
		return 1;
	}
	if(dialogid == BISNIS_PRICESET)
	{
		static
        item[40];
		new bizid = PlayerData[playerid][pInBiz];
		if(Player_OwnsBisnis(playerid, PlayerData[playerid][pInBiz]))
		{
			if(response)
			{
				strunpack(item, PlayerData[playerid][pEditingItem]);

				if(isnull(inputtext))
				{
					new str[128];
					format(str,sizeof(str), "Please enter the new product price for %s:", item);
					ShowPlayerDialog(playerid, BISNIS_PRICESET, DIALOG_STYLE_INPUT, "Business: Set Price", str, "Modify", "Back");
					return 1;
				}
				if(strval(inputtext) < 1 || strval(inputtext) > 5000)
				{
					new str[128];
					format(str,sizeof(str), "Please enter the new product price for %s ($1 to $5,000):", item);
					ShowPlayerDialog(playerid, BISNIS_PRICESET, DIALOG_STYLE_INPUT, "Business: Set Price", str, "Modify", "Back");
					return 1;
				}
				bData[bizid][bP][PlayerData[playerid][pProductModify]] = strval(inputtext);
				Bisnis_Save(bizid);

				SendServerMessage(playerid, "You have adjusted the price of %s to: %s!", item, FormatMoney(strval(inputtext)));
				Bisnis_ProductMenu(playerid, bizid);
			}
			else
			{
				Bisnis_ProductMenu(playerid, bizid);
			}
		}
		return 1;
	}
	//-----------[ House Dialog ]------------------
	if(dialogid == DIALOG_SELL_HOUSES)
	{
		if(!response) return 1;
		new str[248];
		SetPVarInt(playerid, "SellingHouse", ReturnPlayerHousesID(playerid, (listitem + 1)));
		format(str, sizeof(str), "Are you sure you will sell house id: %d", GetPVarInt(playerid, "SellingHouse"));
				
		ShowPlayerDialog(playerid, DIALOG_SELL_HOUSE, DIALOG_STYLE_MSGBOX, "Sell House", str, "Sell", "Cancel");
	}
	if(dialogid == DIALOG_SELL_HOUSE)
	{
		if(response)
		{
			new hid = GetPVarInt(playerid, "SellingHouse"), price;
			price = hData[hid][hPrice] / 2;
			GivePlayerMoneyEx(playerid, price);
			SendInfoMessage(playerid, "Anda berhasil menjual rumah id (%d) dengan setengah harga("LG_E"%s"WHITE_E") pada saat anda membelinya.", hid, FormatMoney(price));
			HouseReset(hid);
			House_Save(hid);
			House_Refresh(hid);
		}
		DeletePVar(playerid, "SellingHouse");
		return 1;
	}
	if(dialogid == DIALOG_MY_HOUSES)
	{
		if(!response) return 1;
		SetPVarInt(playerid, "ClickedHouse", ReturnPlayerHousesID(playerid, (listitem + 1)));
		ShowPlayerDialog(playerid, HOUSE_INFO, DIALOG_STYLE_LIST, "Houses", "Show Information\nTrack House", "Select", "Cancel");
		return 1;
	}
	if(dialogid == HOUSE_INFO)
	{
		if(!response) return 1;
		new hid = GetPVarInt(playerid, "ClickedHouse");
		switch(listitem)
		{
			case 0:
			{
				new line9[900];
				new lock[128], type[128];
				if(hData[hid][hLocked] == 1)
				{
					lock = "{FF0000}Locked";
			
				}
				else
				{
					lock = "{00FF00}Unlocked";
				}
				if(hData[hid][hType] == 1)
				{
					type = "Small";
			
				}
				else if(hData[hid][hType] == 2)
				{
					type = "Medium";
				}
				else if(hData[hid][hType] == 3)
				{
					type = "Big";
				}
				else
				{
					type = "Unknow";
				}
				format(line9, sizeof(line9), "House ID: %d\nHouse Owner: %s\nHouse Address: %s\nHouse Price: %s\nHouse Type: %s\nHouse Status: %s",
				hid, hData[hid][hOwner], hData[hid][hAddress], FormatMoney(hData[hid][hPrice]), type, lock);

				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "House Info", line9, "Close","");
			}
			case 1:
			{
				PlayerData[playerid][pTrackHouse] = 1;
				SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ], 0.0, 0.0, 0.0, 3.5);
				//SetPlayerCheckpoint(playerid, hData[hid][hExtpos][0], hData[hid][hExtpos][1], hData[hid][hExtpos][2], 4.0);
				SendInfoMessage(playerid, "Ikuti checkpoint untuk menemukan rumah anda!");
			}
		}
		return 1;
	}
	if(dialogid == HOUSE_STORAGE)
	{
		new hid = PlayerData[playerid][pInHouse];
		if(!Player_OwnsHouse(playerid, PlayerData[playerid][pInHouse])) 
			if(PlayerData[playerid][pFaction] != 1)
				return SendErrorMessage(playerid, "You don't own this house.");
		if(response)
		{
			if(listitem == 0) 
			{
				House_WeaponStorage(playerid, hid);
			}
			else if(listitem == 1) 
			{
				ShowPlayerDialog(playerid, HOUSE_MONEY, DIALOG_STYLE_LIST, "Money Safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
		}
		return 1;
	}
	if(dialogid == HOUSE_WEAPONS)
	{
		new houseid = PlayerData[playerid][pInHouse];
		if(!Player_OwnsHouse(playerid, PlayerData[playerid][pInHouse])) 
			if(PlayerData[playerid][pFaction] != 1)
				return SendErrorMessage(playerid, "You don't own this house.");
				
		if(response)
		{
			if(hData[houseid][hWeapon][listitem] != WEAPON_FIST)
			{
				GivePlayerWeaponEx(playerid, hData[houseid][hWeapon][listitem], hData[houseid][hAmmo][listitem]);

				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has taken a \"%s\" from their weapon storage.", ReturnName(playerid), ReturnWeaponName(hData[houseid][hWeapon][listitem]));

				hData[houseid][hWeapon][listitem] = WEAPON_FIST;
				hData[houseid][hAmmo][listitem] = 0;

				House_Save(houseid);
				House_WeaponStorage(playerid, houseid);
			}
			else
			{
				new
					WEAPON:weaponid = GetPlayerWeaponEx(playerid),
					ammo = GetPlayerAmmoEx(playerid);

				if(!weaponid)
					return SendErrorMessage(playerid, "You are not holding any weapon!");

				/*if(weaponid == 23 && PlayerData[playerid][pTazer])
					return SendErrorMessage(playerid, "You can't store a tazer into your safe.");

				if(weaponid == 25 && PlayerData[playerid][pBeanBag])
					return SendErrorMessage(playerid, "You can't store a beanbag shotgun into your safe.");*/

				ResetWeapon(playerid, weaponid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has stored a \"%s\" into their weapon storage.", ReturnName(playerid), ReturnWeaponName(weaponid));

				hData[houseid][hWeapon][listitem] = weaponid;
				hData[houseid][hAmmo][listitem] = ammo;

				House_Save(houseid);
				House_WeaponStorage(playerid, houseid);
			}
		}
		else
		{
			House_OpenStorage(playerid, houseid);
		}
		return 1;
	}
	if(dialogid == HOUSE_MONEY)
	{
		new houseid = PlayerData[playerid][pInHouse];
		if(!Player_OwnsHouse(playerid, PlayerData[playerid][pInHouse])) return SendErrorMessage(playerid, "You don't own this house.");
		if(response)
		{
			switch (listitem)
			{
				case 0: 
				{
					new str[128];
					format(str, sizeof(str), "Safe Balance: %s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(hData[houseid][hMoney]));
					ShowPlayerDialog(playerid, HOUSE_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				}
				case 1: 
				{
					new str[128];
					format(str, sizeof(str), "Safe Balance: %s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(hData[houseid][hMoney]));
					ShowPlayerDialog(playerid, HOUSE_DEPOSITMONEY, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				}
			}
		}
		else House_OpenStorage(playerid, houseid);
		return 1;
	}
	if(dialogid == HOUSE_WITHDRAWMONEY)
	{
		new houseid = PlayerData[playerid][pInHouse];
		if(!Player_OwnsHouse(playerid, PlayerData[playerid][pInHouse])) return SendErrorMessage(playerid, "You don't own this house.");
		
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Safe Balance: %s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(hData[houseid][hMoney]));
				ShowPlayerDialog(playerid, HOUSE_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(amount < 1 || amount > hData[houseid][hMoney])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nSafe Balance: %s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(hData[houseid][hMoney]));
				ShowPlayerDialog(playerid, HOUSE_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			hData[houseid][hMoney] -= amount;
			GivePlayerMoneyEx(playerid, amount);

			House_Save(houseid);
			House_OpenStorage(playerid, houseid);

			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %s from their house safe.", ReturnName(playerid), FormatMoney(amount));
		}
		else ShowPlayerDialog(playerid, HOUSE_MONEY, DIALOG_STYLE_LIST, "Money Safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
		return 1;
	}
	if(dialogid == HOUSE_DEPOSITMONEY)
	{
		new houseid = PlayerData[playerid][pInHouse];
		if(!Player_OwnsHouse(playerid, PlayerData[playerid][pInHouse])) return SendErrorMessage(playerid, "You don't own this house.");
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Safe Balance: %s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(hData[houseid][hMoney]));
				ShowPlayerDialog(playerid, HOUSE_DEPOSITMONEY, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			if(amount < 1 || amount > GetPlayerMoney(playerid))
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nSafe Balance: %s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(hData[houseid][hMoney]));
				ShowPlayerDialog(playerid, HOUSE_DEPOSITMONEY, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			hData[houseid][hMoney] += amount;
			GivePlayerMoneyEx(playerid, -amount);

			House_Save(houseid);
			House_OpenStorage(playerid, houseid);

			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %s into their house safe.", ReturnName(playerid), FormatMoney(amount));
		}
		else ShowPlayerDialog(playerid, HOUSE_MONEY, DIALOG_STYLE_LIST, "Money Safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
		return 1;
	}
	//------------[ Private Player Vehicle Dialog ]--------
	if(dialogid == DIALOG_FINDVEH)
	{
		new carid = PlayerData[playerid][pValueListitem][listitem];
		ResetValueListitem(playerid);

		if(response) 
		{	
			if(VehicleData[carid][cPark] != -1)
			{
				new id = VehicleData[carid][cPark];
				if(!Iter_Contains(Parks, id))
					return SendErrorMessage(playerid, "Lokasi parkir tidak ditemukan!");

				PlayerData[playerid][pTrackCar] = 1;
				//SetPlayerCheckpoint(playerid, posisi[0], posisi[1], posisi[2], 4.0);
				SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], 0.0, 0.0, 0.0, 3.5);
				SendInfoMessage(playerid, "Your car waypoint was set to \"%s\" (marked on radar).", GetLocation(ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ]));
			}
			else if(VehicleData[carid][cClaim] == 1)
			{
				SendErrorMessage(playerid, "Kendaraan tidak bisa dilacak, karna berada di Insurance!");
			}
			else
			{
				GetVehiclePos(VehicleData[carid][cVeh], VehicleData[carid][cPosX], VehicleData[carid][cPosY], VehicleData[carid][cPosZ]);
				PlayerData[playerid][pTrackCar] = 1;
				SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, VehicleData[carid][cPosX], VehicleData[carid][cPosY], VehicleData[carid][cPosZ], 0.0, 0.0, 0.0, 3.5);
				SendInfoMessage(playerid, "Your car waypoint was set to \"%s\" (marked on radar).", GetLocation(VehicleData[carid][cPosX], VehicleData[carid][cPosY], VehicleData[carid][cPosZ]));
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_TRACKVEH)
	{
		if(response) 
		{	
			new Float:posisiX, Float:posisiY, Float:posisiZ,
				carid = strval(inputtext);
			
			foreach(new veh : PlayerVehicles)
			{
				if(VehicleData[veh][cVeh] == carid)
				{
					if(IsValidVehicle(VehicleData[veh][cVeh]))
					{
						if(VehicleData[veh][cOwner] == PlayerData[playerid][pID])
						{
							GetVehiclePos(carid, posisiX, posisiY, posisiZ);
							PlayerData[playerid][pTrackCar] = 1;
							//SetPlayerCheckpoint(playerid, posisi[0], posisi[1], posisi[2], 4.0);
							SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, posisiX, posisiY, posisiZ, 0.0, 0.0, 0.0, 3.5);
							SendInfoMessage(playerid, "Your car waypoint was set to \"%s\" (marked on radar).", GetLocation(posisiX, posisiY, posisiZ));
						}
						else return SendErrorMessage(playerid, "Id kendaraan ini bukan milik anda!");
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_GOTOVEH)
	{
		if(response) 
		{
			new Float:posisiX, Float:posisiY, Float:posisiZ,
				carid = strval(inputtext);
			
			GetVehiclePos(carid, posisiX, posisiY, posisiZ);
			SendServerMessage(playerid, "Your teleport to %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), carid);
			SetPlayerPosition(playerid, posisiX, posisiY, posisiZ+3.0, 4.0, 0);
		}
		return 1;
	}
	if(dialogid == DIALOG_GETVEH)
	{
		if(response) 
		{
			new Float:posisiX, Float:posisiY, Float:posisiZ,
				carid = strval(inputtext);
			
			GetPlayerPos(playerid, posisiX, posisiY, posisiZ);
			SendServerMessage(playerid, "Your get spawn vehicle to %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), carid);
			SetVehiclePos(carid, posisiX, posisiY, posisiZ+0.5);
		}
		return 1;
	}
	if(dialogid == DIALOG_DELETEVEH)
	{
		if(response) 
		{
			new carid = strval(inputtext);
			
			//for(new i = 0; i != MAX_PRIVATE_VEHICLE; i++) if(Iter_Contains(PlayerVehicles, i))
			foreach(new i : PlayerVehicles)			
			{
				if(carid == VehicleData[i][cVeh])
				{
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", VehicleData[i][cID]);
					mysql_tquery(g_SQL, query);
					DestroyVehicle(VehicleData[i][cVeh]);
					VehicleData[i][cVeh] = INVALID_VEHICLE_ID;
					Iter_Remove(PlayerVehicles, i);
					SendServerMessage(playerid, "Your deleted private vehicle id %d (database id: %d).", VehicleData[i][cVeh], VehicleData[i][cID]);
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_VEHICLE_LOCK)
	{
		new count, Float:pos[3];
		if(response)
		{
			foreach(new i : PlayerVehicles)
			{
				if(IsValidVehicle(VehicleData[i][cVeh]))
				{
					if(Vehicle_IsOwner(playerid, i) && count++ == listitem)
					{
						GetVehiclePos(VehicleData[i][cVeh], pos[0], pos[1], pos[2]);
						if(IsPlayerInRangeOfPoint(playerid, 5.0, pos[0], pos[1], pos[2]))
						{
							PlayerPlaySound(playerid, 1145);
							VehicleData[i][cLocked] = !(VehicleData[i][cLocked]);
							PlayerPlaySound(playerid, SOUND_LOCK_CAR_DOOR);
							SwitchVehicleDoors(VehicleData[i][cVeh], bool:VehicleData[i][cLocked]);

							if(VehicleData[i][cLocked])
							{
								SwitchVehicleDoors(VehicleData[i][cVeh], true);
								GameTextForPlayer(playerid, sprintf("~w~%s ~r~Locked", GetVehicleName(VehicleData[i][cVeh])), 3000, 3);
							}
							else if(!VehicleData[i][cLocked])
							{
								SwitchVehicleDoors(VehicleData[i][cVeh], false);
								GameTextForPlayer(playerid, sprintf("~w~%s ~g~Unlocked", GetVehicleName(VehicleData[i][cVeh])), 3000, 3);
							}

						}
						else
							SendErrorMessage(playerid, "Kamu tidak di dekat kendaraan tersebut!");
					}
				}
			}
		}
	}	
	if(dialogid == DIALOG_BUYPLATE)
	{
		if(response) 
		{
			new carid = strval(inputtext);
			
			//for(new i = 0; i != MAX_PRIVATE_VEHICLE; i++) if(Iter_Contains(PlayerVehicles, i))
			foreach(new i : PlayerVehicles)
			{
				if(carid == VehicleData[i][cVeh])
				{
					if(GetPlayerMoney(playerid) < 500) return SendErrorMessage(playerid, "Anda butuh $500 untuk membeli Plate baru.");
					GivePlayerMoneyEx(playerid, -500);
					new rand = RandomEx(1111, 9999);
					format(VehicleData[i][cPlate], 32, "HP-%d", rand);
					SetVehicleNumberPlate(VehicleData[i][cVeh], VehicleData[i][cPlate]);
					VehicleData[i][cPlateTime] = gettime() + (15 * 86400);
					SendInfoMessage(playerid, "Model: %s || New plate: %s || Plate Time: %s || Plate Price: $500", GetVehicleModelName(VehicleData[i][cModel]), VehicleData[i][cPlate], ReturnTimelapse(gettime(), VehicleData[i][cPlateTime]));
				}
			}
		}
		return 1;
	}
	//--------------[ Player Toy Dialog ]-------------
	if(dialogid == DIALOG_TOY)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: //slot 1
				{
					PlayerData[playerid][toySelected] = 0;
					if(pToys[playerid][0][toy_model] == 0)
					{
						//ShowModelSelectionMenu(playerid, "Select Toy", TOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						new string[512];
						format(string, sizeof(string), ""dot"Edit Toy Position(PC Only)\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos\nPosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
						pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
						pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
					}
				}
				case 1: //slot 2
				{
					PlayerData[playerid][toySelected] = 1;
					if(pToys[playerid][1][toy_model] == 0)
					{
						//ShowModelSelectionMenu(playerid, "Select Toy", TOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						new string[512];
						format(string, sizeof(string), ""dot"Edit Toy Position(PC Only)\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos\nPosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
						pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
						pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
						//ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos", "Select", "Cancel");
					}
				}
				case 2: //slot 3
				{
					PlayerData[playerid][toySelected] = 2;
					if(pToys[playerid][2][toy_model] == 0)
					{
						//ShowModelSelectionMenu(playerid, "Select Toy", TOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						new string[512];
						format(string, sizeof(string), ""dot"Edit Toy Position(PC Only)\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos\nPosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
						pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
						pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
						//ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos", "Select", "Cancel");
					}
				}
				case 3: //slot 4
				{
					PlayerData[playerid][toySelected] = 3;
					if(pToys[playerid][3][toy_model] == 0)
					{
						//ShowModelSelectionMenu(playerid, "Select Toy", TOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						new string[512];
						format(string, sizeof(string), ""dot"Edit Toy Position(PC Only)\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos\nPosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
						pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
						pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
						//ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos", "Select", "Cancel");
					}
				}
				case 4:
				{
					if(PlayerData[playerid][PurchasedToy] == true)
					{
						for(new i = 0; i < 4; i++)
						{
							pToys[playerid][i][toy_model] = 0;
							pToys[playerid][i][toy_bone] = 1;
							pToys[playerid][i][toy_x] = 0.0;
							pToys[playerid][i][toy_y] = 0.0;
							pToys[playerid][i][toy_z] = 0.0;
							pToys[playerid][i][toy_rx] = 0.0;
							pToys[playerid][i][toy_ry] = 0.0;
							pToys[playerid][i][toy_rz] = 0.0;
							pToys[playerid][i][toy_sx] = 1.0;
							pToys[playerid][i][toy_sy] = 1.0;
							pToys[playerid][i][toy_sz] = 1.0;
							
							if(IsPlayerAttachedObjectSlotUsed(playerid, i))
							{
								RemovePlayerAttachedObject(playerid, i);
							}
						}
						new string[128];
						mysql_format(g_SQL, string, sizeof(string), "DELETE FROM toys WHERE Owner = '%s'", PlayerData[playerid][pName]);
						mysql_tquery(g_SQL, string);
						PlayerData[playerid][PurchasedToy] = false;
						GameTextForPlayer(playerid, "~r~~h~All Toy Rested!~y~!", 3000, 4);
					}
				}
				/*case 4: //slot 5
				{
					PlayerData[playerid][toySelected] = 4;
					if(pToys[playerid][4][toy_model] == 0)
					{
						//ShowModelSelectionMenu(playerid, "Select Toy", TOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						new string[512];
						format(string, sizeof(string), ""dot"Edit Toy Position(PC Only)\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos\nPosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
						pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
						pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
						//ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos", "Select", "Cancel");
					}
				}
				case 5: //slot 6
				{
					PlayerData[playerid][toySelected] = 5;
					if(pToys[playerid][5][toy_model] == 0)
					{
						//ShowModelSelectionMenu(playerid, "Select Toy", TOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						new string[512];
						format(string, sizeof(string), ""dot"Edit Toy Position(PC Only)\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos\nPosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
						pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
						pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
						//ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos", "Select", "Cancel");
					}
				}*/
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_TOYEDIT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: // edit
				{
					//if(IsPlayerAndroid(playerid))
					//	return SendErrorMessage(playerid, "You're connected from android. This feature only for PC users!");
						
					EditAttachedObject(playerid, PlayerData[playerid][toySelected]);
					InfoTD_MSG(playerid, 4000, "~b~~h~You are now editing your toy.");
				}
				case 1: // change bone
				{
					new finstring[750];

					strcat(finstring, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
					strcat(finstring, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");

					ShowPlayerDialog(playerid, DIALOG_TOYPOSISI, DIALOG_STYLE_LIST, "Player Toys", finstring, "Select", "Cancel");
				}
				case 2: // remove toy
				{
					if(IsPlayerAttachedObjectSlotUsed(playerid, PlayerData[playerid][toySelected]))
					{
						RemovePlayerAttachedObject(playerid, PlayerData[playerid][toySelected]);
					}
					pToys[playerid][PlayerData[playerid][toySelected]][toy_model] = 0;
					GameTextForPlayer(playerid, "~r~~h~Toy Removed~y~!", 3000, 4);
					SetPVarInt(playerid, "UpdatedToy", 1);
					TogglePlayerControllable(playerid, true);
				}
				case 3:	//share toy pos
				{
					SendNearbyMessage(playerid, 10.0, COLOR_GREEN, "[TOY BY %s] "WHITE_E"PosX: %.3f | PosY: %.3f | PosZ: %.3f | PosRX: %.3f | PosRY: %.3f | PosRZ: %.3f",
					ReturnName(playerid), pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
					pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
				}
				case 4: //Pos X
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Current Toy PosX: %f\nInput new Toy PosX:(Float)", pToys[playerid][PlayerData[playerid][toySelected]][toy_x]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSX, DIALOG_STYLE_INPUT, "Toy PosX", mstr, "Edit", "Cancel");
				}
				case 5: //Pos Y
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Current Toy PosY: %f\nInput new Toy PosY:(Float)", pToys[playerid][PlayerData[playerid][toySelected]][toy_y]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSY, DIALOG_STYLE_INPUT, "Toy PosY", mstr, "Edit", "Cancel");
				}
				case 6: //Pos Z
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Current Toy PosZ: %f\nInput new Toy PosZ:(Float)", pToys[playerid][PlayerData[playerid][toySelected]][toy_z]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSZ, DIALOG_STYLE_INPUT, "Toy PosZ", mstr, "Edit", "Cancel");
				}
				case 7: //Pos RX
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Current Toy PosRX: %f\nInput new Toy PosRX:(Float)", pToys[playerid][PlayerData[playerid][toySelected]][toy_rx]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSRX, DIALOG_STYLE_INPUT, "Toy PosRX", mstr, "Edit", "Cancel");
				}
				case 8: //Pos RY
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Current Toy PosRY: %f\nInput new Toy PosRY:(Float)", pToys[playerid][PlayerData[playerid][toySelected]][toy_ry]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSRY, DIALOG_STYLE_INPUT, "Toy PosRY", mstr, "Edit", "Cancel");
				}
				case 9: //Pos RZ
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Current Toy PosRZ: %f\nInput new Toy PosRZ:(Float)", pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSRZ, DIALOG_STYLE_INPUT, "Toy PosRZ", mstr, "Edit", "Cancel");
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_TOYPOSISI)
	{
		if(response)
		{
			listitem++;
			pToys[playerid][PlayerData[playerid][toySelected]][toy_bone] = listitem;
			if(IsPlayerAttachedObjectSlotUsed(playerid, PlayerData[playerid][toySelected]))
			{
				RemovePlayerAttachedObject(playerid, PlayerData[playerid][toySelected]);
			}
			listitem = PlayerData[playerid][toySelected];
			SetPlayerAttachedObject(playerid,
					listitem,
					pToys[playerid][listitem][toy_model],
					pToys[playerid][listitem][toy_bone],
					pToys[playerid][listitem][toy_x],
					pToys[playerid][listitem][toy_y],
					pToys[playerid][listitem][toy_z],
					pToys[playerid][listitem][toy_rx],
					pToys[playerid][listitem][toy_ry],
					pToys[playerid][listitem][toy_rz],
					pToys[playerid][listitem][toy_sx],
					pToys[playerid][listitem][toy_sy],
					pToys[playerid][listitem][toy_sz]);
			GameTextForPlayer(playerid, "~g~~h~Bone Changed~y~!", 3000, 4);
			SetPVarInt(playerid, "UpdatedToy", 1);
		}
		return 1;
	}
	if(dialogid == DIALOG_TOYPOSISIBUY)
	{
		if(response)
		{
			listitem++;
			pToys[playerid][PlayerData[playerid][toySelected]][toy_bone] = listitem;
			SetPlayerAttachedObject(playerid, PlayerData[playerid][toySelected], pToys[playerid][PlayerData[playerid][toySelected]][toy_model], listitem);
			//EditAttachedObject(playerid, PlayerData[playerid][toySelected]);
			InfoTD_MSG(playerid, 5000, "~g~~h~Object Attached!~n~~w~Adjust the position than click on the save icon!");
		}
		return 1;
	}
	if(dialogid == DIALOG_TOYBUY)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: //slot 1
				{
					PlayerData[playerid][toySelected] = 0;
					if(pToys[playerid][0][toy_model] == 0)
					{
						ShowModelSelectionMenu(playerid, "Select Toy", TOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy", "Select", "Cancel");
					}
				}
				case 1: //slot 2
				{
					PlayerData[playerid][toySelected] = 1;
					if(pToys[playerid][1][toy_model] == 0)
					{
						ShowModelSelectionMenu(playerid, "Select Toy", TOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy", "Select", "Cancel");
					}
				}
				case 2: //slot 3
				{
					PlayerData[playerid][toySelected] = 2;
					if(pToys[playerid][2][toy_model] == 0)
					{
						ShowModelSelectionMenu(playerid, "Select Toy", TOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy", "Select", "Cancel");
					}
				}
				case 3: //slot 4
				{
					PlayerData[playerid][toySelected] = 3;
					if(pToys[playerid][3][toy_model] == 0)
					{
						ShowModelSelectionMenu(playerid, "Select Toy", TOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy", "Select", "Cancel");
					}
				}
				case 4: //slot 5
				{
					PlayerData[playerid][toySelected] = 4;
					if(pToys[playerid][4][toy_model] == 0)
					{
						ShowModelSelectionMenu(playerid, "Select Toy", TOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy", "Select", "Cancel");
					}
				}
				case 5: //slot 6
				{
					PlayerData[playerid][toySelected] = 5;
					if(pToys[playerid][5][toy_model] == 0)
					{
						ShowModelSelectionMenu(playerid, "Select Toy", TOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy", "Select", "Cancel");
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_TOYVIP)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: //slot 1
				{
					PlayerData[playerid][toySelected] = 0;
					if(pToys[playerid][0][toy_model] == 0)
					{
						ShowModelSelectionMenu(playerid, "Select Toy", VIPTOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy", "Select", "Cancel");
					}
				}
				case 1: //slot 2
				{
					PlayerData[playerid][toySelected] = 1;
					if(pToys[playerid][1][toy_model] == 0)
					{
						ShowModelSelectionMenu(playerid, "Select Toy", VIPTOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy", "Select", "Cancel");
					}
				}
				case 2: //slot 3
				{
					PlayerData[playerid][toySelected] = 2;
					if(pToys[playerid][2][toy_model] == 0)
					{
						ShowModelSelectionMenu(playerid, "Select Toy", VIPTOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy", "Select", "Cancel");
					}
				}
				case 3: //slot 4
				{
					PlayerData[playerid][toySelected] = 3;
					if(pToys[playerid][3][toy_model] == 0)
					{
						ShowModelSelectionMenu(playerid, "Select Toy", VIPTOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy", "Select", "Cancel");
					}
				}
				case 4: //slot 5
				{
					PlayerData[playerid][toySelected] = 4;
					if(pToys[playerid][4][toy_model] == 0)
					{
						ShowModelSelectionMenu(playerid, "Select Toy", VIPTOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy", "Select", "Cancel");
					}
				}
				case 5: //slot 6
				{
					PlayerData[playerid][toySelected] = 5;
					if(pToys[playerid][5][toy_model] == 0)
					{
						ShowModelSelectionMenu(playerid, "Select Toy", VIPTOYS_MODEL, ToysModel, sizeof(ToysModel));
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", ""dot"Edit Toy Position\n"dot"Change Bone\n"dot""GREY_E"Remove Toy", "Select", "Cancel");
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_TOYPOSX)
	{
		if(response)
		{
			new Float:posisi = floatstr(inputtext);

			SetPlayerAttachedObject(playerid,
				PlayerData[playerid][toySelected],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_model],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_bone],
				posisi,
				pToys[playerid][PlayerData[playerid][toySelected]][toy_y],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_rx],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_ry],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_rz],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sx],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sy],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sz]);
			
			pToys[playerid][PlayerData[playerid][toySelected]][toy_x] = posisi;
			SetPVarInt(playerid, "UpdatedToy", 1);
			//MySQL_SavePlayerToys(playerid);
			
			new string[512];
			format(string, sizeof(string), ""dot"Edit Toy Position(PC Only)\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos\nPosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
			pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
			pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
			ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
		}
	}
	if(dialogid == DIALOG_TOYPOSY)
	{
		if(response)
		{
			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				PlayerData[playerid][toySelected],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_model],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_bone],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_x],
				posisi,
				pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_rx],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_ry],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_rz],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sx],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sy],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sz]);
			
			pToys[playerid][PlayerData[playerid][toySelected]][toy_y] = posisi;
			SetPVarInt(playerid, "UpdatedToy", 1);
			//MySQL_SavePlayerToys(playerid);
			
			new string[512];
			format(string, sizeof(string), ""dot"Edit Toy Position(PC Only)\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos\nPosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
			pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
			pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
			ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
		}
	}
	if(dialogid == DIALOG_TOYPOSZ)
	{
		if(response)
		{
			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				PlayerData[playerid][toySelected],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_model],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_bone],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_x],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_y],
				posisi,
				pToys[playerid][PlayerData[playerid][toySelected]][toy_rx],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_ry],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_rz],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sx],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sy],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sz]);
			
			pToys[playerid][PlayerData[playerid][toySelected]][toy_z] = posisi;
			SetPVarInt(playerid, "UpdatedToy", 1);
			//MySQL_SavePlayerToys(playerid);
			
			new string[512];
			format(string, sizeof(string), ""dot"Edit Toy Position(PC Only)\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos\nPosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
			pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
			pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
			ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
		}
	}
	if(dialogid == DIALOG_TOYPOSRX)
	{
		if(response)
		{
			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				PlayerData[playerid][toySelected],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_model],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_bone],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_x],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_y],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
				posisi,
				pToys[playerid][PlayerData[playerid][toySelected]][toy_ry],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_rz],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sx],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sy],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sz]);
			
			pToys[playerid][PlayerData[playerid][toySelected]][toy_rx] = posisi;
			SetPVarInt(playerid, "UpdatedToy", 1);
			//MySQL_SavePlayerToys(playerid);
			
			new string[512];
			format(string, sizeof(string), ""dot"Edit Toy Position(PC Only)\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos\nPosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
			pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
			pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
			ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
		}
	}
	if(dialogid == DIALOG_TOYPOSRY)
	{
		if(response)
		{
			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				PlayerData[playerid][toySelected],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_model],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_bone],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_x],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_y],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_rx],
				posisi,
				pToys[playerid][PlayerData[playerid][toySelected]][toy_rz],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sx],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sy],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sz]);
			
			pToys[playerid][PlayerData[playerid][toySelected]][toy_ry] = posisi;
			SetPVarInt(playerid, "UpdatedToy", 1);
			//MySQL_SavePlayerToys(playerid);
			
			new string[512];
			format(string, sizeof(string), ""dot"Edit Toy Position(PC Only)\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos\nPosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
			pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
			pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
			ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
		}
	}
	if(dialogid == DIALOG_TOYPOSRZ)
	{
		if(response)
		{
			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				PlayerData[playerid][toySelected],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_model],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_bone],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_x],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_y],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_rx],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_ry],
				posisi,
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sx],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sy],
				pToys[playerid][PlayerData[playerid][toySelected]][toy_sz]);
			
			pToys[playerid][PlayerData[playerid][toySelected]][toy_rz] = posisi;
			SetPVarInt(playerid, "UpdatedToy", 1);
			//MySQL_SavePlayerToys(playerid);
			
			new string[512];
			format(string, sizeof(string), ""dot"Edit Toy Position(PC Only)\n"dot"Change Bone\n"dot""GREY_E"Remove Toy\n"dot"Share Toy Pos\nPosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
			pToys[playerid][PlayerData[playerid][toySelected]][toy_x], pToys[playerid][PlayerData[playerid][toySelected]][toy_y], pToys[playerid][PlayerData[playerid][toySelected]][toy_z],
			pToys[playerid][PlayerData[playerid][toySelected]][toy_rx], pToys[playerid][PlayerData[playerid][toySelected]][toy_ry], pToys[playerid][PlayerData[playerid][toySelected]][toy_rz]);
			ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
		}
	}
	//-----------[ Player Commands Dialog ]----------
	if(dialogid == DIALOG_HELP)
    {
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				new str[3500];
				strcat(str, "\
					/help\tBantuan dalam ranah server\n\
					/afk\tCheck player AFK\n\
					/drag\tMenggendong player lain\n\
					/undrag\tMenurunkan player dari gendongan\n\
					/pay\tMemberi/Membayar dengan uang kepada player\n\
					/stats\tStatistik player\n\
					/items\tMembuka Inventory\n\
					/frisk\tMemeriksa Inventory player lain\n\
					/use\tMenggunakan sesuatu\n\
					/give\tMemberikan sesuatu\n\
					/idcard\tMenunjukan ID-Card\n\
					/drivelic\tMenunjukan Driving License\n\
					/phone\tMembuka menu ponsel\n\
					/togphone\tMenyalakan/Mematikan ponsel\n\
					/reqloc\tMeminta lokasi player lain\n\
					/weapon\tMenu senjata\n\
					/settings\tMenu pengaturan\n\
					/ask\tBertanya kepada admin yang online\n\
					/answer\tMenjawab quiz dari admin\n\
					/mask\tMengenakan penutup muka (Secret Identity)\n\
					/death\tUntuk menerima kematianmu\n\
					/deny\tMenolak ajakan/tawaran\n\
					/buy\tMelakukan interaksi pada Bisnis, House, dll\n\
					/health\tKondisi Kesehatan tubuh\n\
					/destroycp\tMenghapus checkpoint\n\
					/cursor\tMengatasi bug ketika menekan textdraw\n\
					/damagelog\tMemperlihatkan damage log\n\
					/seatbelt\tMemakai sabuk pengaman di kendaraan roda 4\n\
					/helmet\tMemakai helm/helmet di kendaraan roda 2\n\
					/myfish\tMelihat ikan yang kamu miliki\n\
					/fish\tMulai aktifitas memancing");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST, "Account Commands", str, "Close", "");
			}
			case 1:
			{
				new str[3500];
				strcat(str, "\
					/b\tBerbicara secara OOC\n\
					/l\tBerbicara secara berbisik (low nearby talk)\n\
					/t\tMembenarkan sebuah perkataan\n\
					/s\tBerbicara secara teriak (high nearby talk)\n\
					/pm\tMemberikan Private Message ke player (OOC)\n\
					/togpm\tAktif/Nonaktifkan Private Message dari player lain (OOC)\n\
					/w\tBerbicara secara berbisik (from player to player)\n\
					/o\tBerbicara secara terbuka (OOC)\n\
					/me\tMelakukan sesuatu (sebelum /do)\n\
					/ame\tMelakukan sesuatu sebelum dilakukan\n\
					/do\tMelakukan sesuatu (setelah /me)\n\
					/ado\tMelakukan sesuatu setelah dilakukan\n\
					/try\tMencoba melakukan sesuatu\n\
					/ab\tMelakukan sesuatu secara OOC\n\
					/clearchat(/cc)\tMenghapus riwayat chat\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST, "General Commands", str, "Close", "");
			}
			case 2:
			{
				new str[3500];
				strcat(str, "\
					/(en)gine\tMenyala/matikan mesin\n\
					/lights\tMenyalakan lampu kendaraan\n\
					/hood\tMembuka kap kendaraan\n\
					/trunk\tMembuka bagasi kendaraan\n\
					/v storage(/vstorage or press Y)\tMembuka menu bagasi kendaraan\n\
					/(un)lock\tMembuka/kunci kendaraan\n\
					/tow\tMenderek kendaraan\n\
					/untow\tMelepas derek dari kendaraan\n\
					/v park\tMemarkirkan kendaraan di tempat\n\
					/v my(/mypv)\tList kendaraan yang dimiliki\n\
					/myinsu\tList insu setiap kendaraan\n\
					/claimpv\tMengambil kendaraan di Insurance\n\
					/buyplate\tMembeli plate kendaraan\n\
					/buyinsu\tMembeli Insurance untuk kendaraan\n\
					/eject\tMenendang orang dari kendaraan");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST, "Vehicle Commands", str, "Close", "");
			}
			case 3:
			{
				new line3[500];
				strcat(line3, "{ffffff}Taxi\nMechanic\nLumberjack\nTrucker\nMiner\nProduct\nFarmer\nKurir\nMilker");
				ShowPlayerDialog(playerid, DIALOG_JOB, DIALOG_STYLE_LIST, "Job Help", line3, "Pilih", "Batal");
				return 1;
			}
			case 4:
			{
				return callcmd::factionhelp(playerid);
			}
			case 5:
			{
				new str[3500];
				strcat(str, "{7fffd4}AUTO RP: {ffffff}rpgun rpcrash rpfall rprob rpfish rpmad rpcj rpdrink\n");
				strcat(str, "{7fffd4}AUTO RP: {ffffff}rpwar rpdie rpfixmeka rpcheckmeka rpfight rpcry rpeat\n");
				strcat(str, "{7fffd4}AUTO RP: {ffffff}rpfear rpdropgun rpgivegun rptakegun rprun rpnodong\n");
				strcat(str, "{7fffd4}AUTO RP: {ffffff}rpshy rpnusuk rplock rpharvest rplockhouse rplockcar\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "AUTO RP", str, "Close", "");
			}
			case 6:
			{
				new str[3500];
				strcat(str, "\
					/buy\tMembeli bisnis\n\
					/bm\tMembuka menu bisnis (manage)\n\
					/lockbisnis\tBuka/Tutup bisnis\n\
					/mybis\tMembuka menu bisnis\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST, "Bisnis Commands", str, "Close", "");
			}
			case 7:
			{
				new str[3500];
				strcat(str, "\
					/buy\tMembeli rumah\n\
					/storage\tMembuka menu penyimpanan rumah\n\
					/lockhouse\tBuka/Tutup rumah\n\
					/myhouse\tMembuka menu rumah\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST, "House Commands", str, "Close", "");
			}
			case 8:
			{
				new str[3500];
				strcat(str, "\
					/buy\tMembeli workshop\n\
					/myws\tMembuka menu workshop\n\
					/lockws\tBuka/Tutup workshop\n\
					/service\tModifikasi kendaraan");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST, "Workshop Commands", str, "Close", "");
			}
			case 9: callcmd::bbhelp(playerid);
			case 10: callcmd::donate(playerid);
			case 11: callcmd::credits(playerid);
			case 12:
			{
				new str[3500];
				strcat(str, "\
					LEADER :\n\
					/makerobteam\tMembuat tim untuk melakukan Perampokan\n\
					/disbandteam\tMembubarkan tim\n\
					/inviterob\tUndang orang untuk merampok\n\
					/kickrob\tTendang orang dari tim perampok\n\
					/robatm\tUntuk merampok ATM\n\
					\n\
					MEMBER :\n\
					Ikuti perintah ketua.");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST, "Robbery Commands", str, "Close", "");
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_MISSION)
	{
		if(response)
		{
			SetPVarInt(playerid, "fanMission", listitem);

			new fanstr[500];
			switch(listitem)
			{
				case 0:
				{
					if(GetRestockBisnis() <= 0) return SendErrorMessage(playerid, "Mission sedang kosong.");
					new id, count = GetRestockBisnis(), mission[128], type[32], lstr[512];
					
					strcat(mission,"No\tBisnisID\tType\tName\n",sizeof(mission));
					Loop(itt, (count + 1), 1)
					{
						id = ReturnRestockBisnisID(itt);
						if(bData[id][bType] == 1)
						{
							type= "Fast Food";
						}
						else if(bData[id][bType] == 2)
						{
							type= "Market";
						}
						else if(bData[id][bType] == 3)
						{
							type= "Clothes";
						}
						else if(bData[id][bType] == 4)
						{
							type= "Ammunation";
						}
						else
						{
							type= "Unknown";
						}
						if(itt == count)
						{
							format(lstr,sizeof(lstr), "%d\t%d\t%s\t%s\n", itt, id, type, bData[id][bName]);	
						}
						else format(lstr,sizeof(lstr), "%d\t%d\t%s\t%s\n", itt, id, type, bData[id][bName]);
						strcat(mission,lstr,sizeof(mission));
					}
					ShowPlayerDialog(playerid, DIALOG_RESTOCK, DIALOG_STYLE_TABLIST_HEADERS, "Restock Bisnis", mission,"Start","Cancel");
				}
				case 1:
				{
					/*if(GetRestockDealer() <= 0) return SendErrorMessage(playerid, "Mission sedang kosong.");
					new id, count = GetRestockDealer(), mission[128], lstr[512];
					
					strcat(mission,"No\tDealerID\tType\tName\n",sizeof(mission));
					Loop(itt, (count + 1), 1)
					{
						id = ReturnRestockDealerID(itt);
						if(itt == count)
						{
							format(lstr,sizeof(lstr), "%d\t%s\t%s\n", id, Dealer_Type(id), DealerData[id][dealerName]);	
						}
						else format(lstr,sizeof(lstr), "%d\t%s\t%s\n", id, Dealer_Type(id), DealerData[id][dealerName]);
						strcat(mission,lstr,sizeof(mission));
					}
					ShowPlayerDialog(playerid, DIALOG_RESTOCK, DIALOG_STYLE_TABLIST_HEADERS, "Restock Dealership",mission,"Start","Cancel");*/
					SendCustomMessage(playerid, "FANN", "Coming soon sayang:)");
				}
				case 2:
				{
					if(Component > 1000) return SendErrorMessage(playerid, "Sedang tidak berlangsung!");

					format(fanstr, sizeof(fanstr), "Kamu ingin melakukan restock component? kamu harus membeli\n\
					{ffff00}Componemt Cargo{ffffff} di lokasi yang ada di {0077ff}'/gps > Public Locations > Component Warehouse'{ffffff}!\n\
					Jika sudah mempunyai {ffff00}Component Cargo{ffffff} kamu harus merestocknya pada {0077ff}'/gps > Public Locations > Component Store'{ffffff}\n\
					Jika butu bantuan lebih, gunakan {00ff00}'/help > Jobs Commands > Trucker'{ffffff} untuk mengetahui command");
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Restock Component Guide", fanstr, "Oke", "");
				}
				case 3:
				{
					if(Material > 1000) return SendErrorMessage(playerid, "Sedang tidak berlangsung!");

					format(fanstr, sizeof(fanstr), "Kamu ingin melakukan restock material? kamu harus membeli\n\
					{ffff00}Material Cargo{ffffff} di lokasi yang ada di {0077ff}'/gps > Public Locations > Material Warehouse'{ffffff}!\n\
					Jika sudah mempunyai {ffff00}Material Cargo{ffffff} kamu harus merestocknya pada {0077ff}'/gps > Public Locations > Material Store'{ffffff}\n\
					Jika butu bantuan lebih, gunakan {00ff00}'/help > Jobs Commands > Trucker'{ffffff} untuk mengetahui command");
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Restock Material Guide", fanstr, "Oke", "");
				}
				case 4:
				{
					if(Product > 100) return SendErrorMessage(playerid, "Sedang tidak berlangsung!");
					
					format(fanstr, sizeof(fanstr), "Kamu ingin melakukan restock product? kamu bisa membeli salah satu cargo dari\n\
					{ffff00}Beberapa Warehouse {ff0000}terkecuali Component & Material Warehouse{ffffff} di lokasi yang ada di {0077ff}'/gps > Public Locations'{ffffff}!\n\
					Jika sudah mempunyai {ffff00}Cargonya{ffffff} kamu harus merestocknya pada {0077ff}'/gps > Public Locations > Product Store'{ffffff}\n\
					Jika butu bantuan lebih, gunakan {00ff00}'/help > Jobs Commands > Trucker'{ffffff} untuk mengetahui command");
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Restock Product Guide", fanstr, "Oke", "");
				}
			}
		}
	}
	if(dialogid == DIALOG_RESTOCK)
	{
		if(response)
		{
			if(GetPVarInt(playerid, "fanMission") == 0)
			{
				new id = ReturnRestockBisnisID((listitem + 1)), vehicleid = GetPlayerVehicleID(playerid);
				if(bData[id][bMoney] < 1000)
					return SendErrorMessage(playerid, "Maaf, Bisnis ini kehabisan uang product.");
				
				if(PlayerData[playerid][pMission] > -1 || PlayerData[playerid][pHauling] > -1)
					return SendErrorMessage(playerid, "Anda sudah sedang melakukan mission/hauling!");
				
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsATruck(vehicleid)) return SendErrorMessage(playerid, "Anda harus mengendarai truck.");
					
				PlayerData[playerid][pMission] = id;
				bData[id][bRestock] = 0;
				
				new line9[900];
				format(line9, sizeof(line9), "Silahkan anda membeli stock product di gudang!\n\nBisnis ID: %d\nBisnis Owner: %s\nBisnis Name: %s\nBisnis Type: %s\n\nSetelah itu ikuti checkpoint dan antarkan ke bisnis mission anda!",
				id, bData[id][bOwner], bData[id][bName], Bisnis_GetType(id));
				SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, -279.67, -2148.42, 28.54, 0.0, 0.0, 0.0, 3.5);
				//SetPlayerCheckpoint(playerid, -279.67, -2148.42, 28.54, 3.5);
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Mission Info", line9, "Close","");
			}
			/*else
			{
				new id = ReturnRestockDealerID((listitem + 1)), vehicleid = GetPlayerVehicleID(playerid);
				if(DealerData[id][dealerVault] < 1000)
					return SendErrorMessage(playerid, "Maaf, Dealership ini kehabisan uang product.");
				
				if(PlayerData[playerid][pMission] > -1 || PlayerData[playerid][pHauling] > -1)
					return SendErrorMessage(playerid, "Anda sudah sedang melakukan mission/hauling!");
				
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsATruck(vehicleid)) return SendErrorMessage(playerid, "Anda harus mengendarai truck.");
					
				PlayerData[playerid][pMission] = id;
				DealerData[id][dealerRestock] = 0;
				
				new line9[900];
				format(line9, sizeof(line9), "Silahkan anda membeli stock product di gudang!\n\nDealership ID: %d\nDealership Owner: %s\nDealership Name: %s\nDealership Type: %s\n\nSetelah itu ikuti checkpoint dan antarkan ke dealership mission anda!",
				id, GetNameByID(DealerData[id][dealerOwner]), DealerData[id][dealerName], Dealer_Type(id));
				SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, -279.67, -2148.42, 28.54, 0.0, 0.0, 0.0, 3.5);
				//SetPlayerCheckpoint(playerid, -279.67, -2148.42, 28.54, 3.5);
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Mission Info", line9, "Close","");
			}*/
		}
	}
	if(dialogid == DIALOG_JOB)
    {
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				new str[3500];
				strcat(str, "{ffffff}Pekerjaan ini dapat anda dapatkan di Unity Station\n\n{7fffd4}CMDS: /taxiduty /fare\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Taxi Job", str, "Close", "");
			}
			case 1:
			{
				new str[3500];
				strcat(str, "{ffffff}Pekerjaan ini dapat anda dapatkan di Backside Commerce\n\n{7fffd4}CMDS: /mechduty /service\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Mechanic Job", str, "Close", "");
			}
			case 2:
			{
				new str[3500];
				strcat(str, "{ffffff}Pekerjaan ini khusus untuk Lumber Profesional\n\n{7fffd4}CMDS: /(lum)ber\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Lumber Job", str, "Close", "");
			}
			case 3:
			{
				new str[3500];
				strcat(str, "{ffffff}Pekerjaan ini dapat anda dapatkan di Flint Country\n\n{7fffd4}CMDS: /crate /mission /storeproduct /hauling /storegas /gps\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Trucker Job", str, "Close", "");
			}
			case 4:
			{
				new str[3500];
				strcat(str, "{ffffff}Pekerjaan ini dapat anda dapatkan di Las Venturas\n\n{7fffd4}CMDS: /ore\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Miner Job", str, "Close", "");
			}
			case 5:
			{
				new str[3500];
				strcat(str, "{ffffff}Pekerjaan ini dapat anda dapatkan di Flint Country arah Angel Pine\n\n{7fffd4}CMDS: /createproduct /sellproduct\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Production Job", str, "Close", "");
			}
			case 6:
			{
				new str[3500];
				strcat(str, "{ffffff}Pekerjaan ini dapat anda dapatkan di Flint Country\n\n{7fffd4}CMDS: /plant /price /offer\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Farmer Job", str, "Close", "");
			}
			case 7:
			{
				new str[3500];
				strcat(str, "{ffffff}Pekerjaan ini dapat anda dapatkan di Market\n\n{7fffd4}CMDS: /startkurir /stopkurir /angkatbox\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Farmer Job", str, "Close", "");
			}
			case 8:
			{
				new str[3500];
				strcat(str, "{ffffff}Pekerjaan ini dapat anda dapatkan di Bone County\n\n{7fffd4}CMDS: /sellmilk /squeezemilk\n");
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Milker Job", str, "Close", "");
			}
		}
	}				
	if(dialogid == DIALOG_GPS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(IsAtEvent[playerid] == 1)
						return SendErrorMessage(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini!");

					if(GetPVarInt(playerid, "dmvTest") == 2)
						return SendErrorMessage(playerid, "Kamu tidak dapat menghilangkan GPS untuk saat ini!");

					if(PlayerData[playerid][pSideJob] > 0 || PlayerData[playerid][pCP] > 0)
						return SendErrorMessage(playerid, "Harap selesaikan Pekerjaan mu terlebih dahulu!");

					DisablePlayerCheckpoint(playerid);
					DisablePlayerRaceCheckpoint(playerid);
				}
				case 1:
				{
					GPS_PublicForPlayer(playerid);
				}
				case 2:
				{
					GPS_PublicPropForPlayer(playerid);
				}
				case 3:
				{
					GPS_OwnPropForPlayer(playerid);
				}
				case 4:
				{
					GPS_JobForPlayer(playerid);
				}
				case 5:
				{
					if(PlayerData[playerid][pMission] == -1) return SendErrorMessage(playerid, "You dont have mission.");
					new id = PlayerData[playerid][pMission];
					if(GetPVarInt(playerid, "fanMission") == 0)
					{
						SendInfoMessage(playerid, "Follow the mission checkpoint to find your bisnis mission location.");
						SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ], 0.0, 0.0, 0.0, 3.5);
					}
					/*else if(GetPVarInt(playerid, "fanMission") == 1)
					{
						SendInfoMessage(playerid, "Follow the mission checkpoint to find your dealership mission location.");
						SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, DealerData[id][dealerPos][0], DealerData[id][dealerPos][1], DealerData[id][dealerPos][2], 0.0, 0.0, 0.0, 3.5);
					}*/
				}
				case 6:
				{
					if(PlayerData[playerid][pHauling] == -1) return SendErrorMessage(playerid, "You dont have hauling.");
					new id = PlayerData[playerid][pHauling];
					SendInfoMessage(playerid, "Follow the hauling checkpoint to find your gas station location.");
					//SetPlayerCheckpoint(playerid, bData[bid][bExtpos][0], bData[bid][bExtpos][1], bData[bid][bExtpos][2], 3.5);
					SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ], 0.0, 0.0, 0.0, 3.5);
				}
				case 7:
				{
					GPS_TreeLocForPlayer(playerid);
				}
			}
		}
	}
	if(dialogid == DIALOG_GPS_PUBLIC)
	{
		if(response)
		{
			forex(fan, sizeof(fan_gps)) if(fan == listitem)
			{
				SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, fan_gps[listitem][gFanX], fan_gps[listitem][gFanY], fan_gps[listitem][gFanZ], 0.0, 0.0, 0.0, 3.5);
				SendInfoMessage(playerid, "Kamu telah menandai "YELLOW_E"%s"WHITE_E" sebagai tujuan dengan jarak {ff0000}%.2f{ffffff}m.", fan_gps[listitem][gName], GetPlayerDistanceFromPoint(playerid, fan_gps[listitem][gFanX], fan_gps[listitem][gFanY], fan_gps[listitem][gFanZ]));
			}
		}
		else
			GPS_ShowForPlayer(playerid);
	}
	if(dialogid == DIALOG_GPS_OWN_PROP)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: callcmd::myhouse(playerid);
				case 1: callcmd::mybis(playerid);
				case 2: GPS_ShowForPlayer(playerid);
				case 3: callcmd::myws(playerid);
			}
		}
		else
			GPS_ShowForPlayer(playerid);
	}
	if(dialogid == DIALOG_GPS_PUBLIC_PROP)
	{
		if(response)
		{
			GPS_ShowNearbyLoc(playerid, listitem+1);
		}
		else
			GPS_ShowForPlayer(playerid);
	}
	if(dialogid == DIALOG_GPS_FANN)
	{
		if(response)
		{
			new id, name[32], Float:fan[3];
			if(GetPVarInt(playerid, "fanLocation") == 1)
			{
				id = FannBiz(playerid, listitem+1);
				if(id == -1)
					return SendErrorMessage(playerid, "Invalid ID!");
				
				format(name, sizeof(name), "Bisnis %s", bData[id][bName]);
				fan[0] = bData[id][bExtposX];
				fan[1] = bData[id][bExtposY];
				fan[2] = bData[id][bExtposZ];
			}
			else if(GetPVarInt(playerid, "fanLocation") == 2)
			{
				id = FannPark(playerid, listitem+1);
				if(id == -1)
					return SendErrorMessage(playerid, "Invalid ID!");
				
				fan[0] = ppData[id][parkX];
				fan[1] = ppData[id][parkY];
				fan[2] = ppData[id][parkZ];
				format(name, sizeof(name), "Park %s", GetLocation(fan[0], fan[1], fan[2]));
			}
			/*else if(GetPVarInt(playerid, "fanLocation") == 3)
			{
				id = FannDealer(playerid, listitem+1);
				if(id == -1)
					return SendErrorMessage(playerid, "Invalid ID!");
				
				format(name, sizeof(name), DealerData[id][dealerName]);
				fan[0] = DealerData[id][dealerPos][0];
				fan[1] = DealerData[id][dealerPos][1];
				fan[2] = DealerData[id][dealerPos][2];
			}*/
			else if(GetPVarInt(playerid, "fanLocation") == 4)
			{
				id = FannWorkshop(playerid, listitem+1);
				if(id == -1)
					return SendErrorMessage(playerid, "Invalid ID!");

				format(name, sizeof(name), "Workshop %s", wsData[id][wName]);
				fan[0] = wsData[id][wX];
				fan[1] = wsData[id][wY];
				fan[2] = wsData[id][wZ];
			}
			else if(GetPVarInt(playerid, "fanLocation") == 5)
			{
				id = FannModshop(playerid, listitem+1);
				if(id == -1)
					return SendErrorMessage(playerid, "Invalid ID!");

				format(name, sizeof(name), "ModShop %s", GetLocation(ModsPoint[id][ModsPos][0], ModsPoint[id][ModsPos][1], ModsPoint[id][ModsPos][2]));
				fan[0] = ModsPoint[id][ModsPos][0];
				fan[1] = ModsPoint[id][ModsPos][1];
				fan[2] = ModsPoint[id][ModsPos][2];
			}
			else if(GetPVarInt(playerid, "fanLocation") == 6)
			{
				id = FannGasStation(playerid, listitem+1);
				if(id == -1)
					return SendErrorMessage(playerid, "Invalid ID!");

				format(name, sizeof(name), "Gas Station %s", GetLocation(gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]));
				fan[0] = gsData[id][gsPosX];
				fan[1] = gsData[id][gsPosY];
				fan[2] = gsData[id][gsPosZ];
			}
			else if(GetPVarInt(playerid, "fanLocation") == 7)
			{
				id = FannATM(playerid, listitem+1);
				if(id == -1)
					return SendErrorMessage(playerid, "Invalid ID!");

				format(name, sizeof(name), "ATM %s", GetLocation(AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ]));
				fan[0] = AtmData[id][atmX];
				fan[1] = AtmData[id][atmY];
				fan[2] = AtmData[id][atmZ];
			}
			else
				return SendErrorMessage(playerid, "Tidak ditemukan!");

			SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, fan[0], fan[1], fan[2], 0.0, 0.0, 0.0, 3.5);
			SendInfoMessage(playerid, "Kamu telah menandai "YELLOW_E"%s"WHITE_E" sebagai tujuan dengan jarak {ff0000}%.2f{ffffff}m.", name, GetPlayerDistanceFromPoint(playerid, fan[0], fan[1], fan[2]));
		}
	}
	if(dialogid == DIALOG_GPS_JOB)
	{
		if(response)
		{
			new count;
			forex(fan, sizeof(fan_gps)) if(fan_gps[fan][gType] == gJob)
			{
				if(count++ == listitem)
				{
					SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, fan_gps[fan][gFanX], fan_gps[fan][gFanY], fan_gps[fan][gFanZ], 0.0, 0.0, 0.0, 3.5);
					SendInfoMessage(playerid, "Kamu telah menandai "YELLOW_E"%s"WHITE_E" sebagai tujuan dengan jarak {ff0000}%.2f{ffffff}m.", fan_gps[fan][gName], GetPlayerDistanceFromPoint(playerid, fan_gps[fan][gFanX], fan_gps[fan][gFanY], fan_gps[fan][gFanZ]));
				}
			}
		}
		else
			GPS_ShowForPlayer(playerid);
	}
	if(dialogid == DIALOG_GPS_TREE)
	{
		if(response)
		{
			new fan;
			foreach(new tree : Trees)
			{
				if(fan++ == listitem)
				{
					SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, TreeData[tree][treeX], TreeData[tree][treeY], TreeData[tree][treeZ], 0.0, 0.0, 0.0, 3.5);
					SendInfoMessage(playerid, "Kamu telah menandai "YELLOW_E"Tree in %s"WHITE_E" sebagai tujuan dengan jarak {ff0000}%.2f{ffffff}m.", GetLocation(TreeData[tree][treeX], TreeData[tree][treeY], TreeData[tree][treeZ]), GetPlayerDistanceFromPoint(playerid, TreeData[tree][treeX], TreeData[tree][treeY], TreeData[tree][treeZ]));
				}
			}
		}
		else
			GPS_ShowForPlayer(playerid);
	}
	if(dialogid == DIALOG_TRACKWS)
	{
		if(response)
		{
			new wid = ReturnWorkshopID((listitem + 1));

			PlayerData[playerid][pLoc] = wid;
			SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ], 0.0, 0.0, 0.0, 3.5);
			SendInfoMessage(playerid, "Workshop Checkpoint targeted! (%s)", GetLocation(wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ]));
		}
	}
	if(dialogid == DIALOG_TRACKPARK)
	{
		if(response)
		{
			new id = ReturnAnyPark((listitem + 1));

			PlayerData[playerid][pLoc] = id;
			SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], 0.0, 0.0, 0.0, 3.5);
			SendInfoMessage(playerid, "Custom Park Checkpoint targeted! (%s)", GetLocation(ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ]));
		}
	}
	if(dialogid == DIALOG_PAY)
	{
		if(response)
		{
			new mstr[128];
			new otherid = GetPVarInt(playerid, "gcPlayer");
			new money = GetPVarInt(playerid, "gcAmount");

			if(otherid == INVALID_PLAYER_ID)
				return SendErrorMessage(playerid, "Player not connected!");
			GivePlayerMoneyEx(otherid, money);
			GivePlayerMoneyEx(playerid, -money);

			format(mstr, sizeof(mstr), "Server: "YELLOW_E"You have sent %s(%i) "GREEN_E"%s", ReturnName(otherid), otherid, FormatMoney(money));
			SendClientMessage(playerid, COLOR_GREY, mstr);
			format(mstr, sizeof(mstr), "Server: "YELLOW_E"%s(%i) has sent you "GREEN_E"%s", ReturnName(playerid), playerid, FormatMoney(money));
			SendClientMessage(otherid, COLOR_GREY, mstr);
			InfoTD_MSG(playerid, 3500, "~g~~h~Money Sent!");
			InfoTD_MSG(otherid, 3500, "~g~~h~Money received!");
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "%s memberikan uang kepada %s sebesar %s", ReturnName(playerid), ReturnName(otherid), FormatMoney(money));
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "%s menerima uang dari %s sebesar %s", ReturnName(otherid), ReturnName(playerid), FormatMoney(money));
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, false, false, false, false, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, false, false, false, false, 0);
			
			new query[512];
			mysql_format(g_SQL, query, sizeof(query), "INSERT INTO logpay (player,playerid,toplayer,toplayerid,ammount,time) VALUES('%s','%d','%s','%d','%d',UNIX_TIMESTAMP())", PlayerData[playerid][pName], PlayerData[playerid][pID], PlayerData[otherid][pName], PlayerData[otherid][pID], money);
			mysql_tquery(g_SQL, query);
		}
		return 1;
	}
	//-------------[ Player Weapons Atth ]-----------
	if(dialogid == DIALOG_EDITBONE)
	{
		if(response)
		{
			new WEAPON:weaponid = WEAPON:EditingWeapon[playerid], weaponname[18], string[150];
	 
			GetWeaponName(weaponid, weaponname, sizeof(weaponname));
		   
			WeaponSettings[playerid][weaponid - WEAPON:22][Bone] = listitem + 1;

			SendServerMessage(playerid, "You have successfully changed the bone of your %s.", weaponname);
		   
			mysql_format(g_SQL, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, Bone) VALUES ('%d', %d, %d) ON DUPLICATE KEY UPDATE Bone = VALUES(Bone)", PlayerData[playerid][pID], _:weaponid, listitem + 1);
			mysql_tquery(g_SQL, string);
		}
		EditingWeapon[playerid] = 0;
	}
	//------------[ Family Dialog ]------------
	if(dialogid == FAMILY_SAFE)
	{
		if(!response) return 1;
		new fid = PlayerData[playerid][pFamily];
		switch(listitem) 
		{
			case 0: Family_OpenStorage(playerid, fid);
			case 1:
			{
				//Marijuana
				ShowPlayerDialog(playerid, FAMILY_MARIJUANA, DIALOG_STYLE_LIST, "Marijuana", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			case 2:
			{
				//Component
				ShowPlayerDialog(playerid, FAMILY_COMPONENT, DIALOG_STYLE_LIST, "Component", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			case 3:
			{
				//Material
				ShowPlayerDialog(playerid, FAMILY_MATERIAL, DIALOG_STYLE_LIST, "Material", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			case 4:
			{
				//Money
				ShowPlayerDialog(playerid, FAMILY_MONEY, DIALOG_STYLE_LIST, "Money", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
		}
		return 1;
	}
	if(dialogid == FAMILY_STORAGE)
	{
		new fid = PlayerData[playerid][pFamily];
		if(response)
		{
			if(listitem == 0) 
			{
				Family_WeaponStorage(playerid, fid);
			}
		}
		return 1;
	}
	if(dialogid == FAMILY_WEAPONS)
	{
		new fid = PlayerData[playerid][pFamily];
		if(response)
		{
			if(fData[fid][fGun][listitem] != WEAPON_FIST)
			{
				if(PlayerData[playerid][pFamilyRank] < 5)
					return SendErrorMessage(playerid, "Only boss can taken the weapon!");
					
				GivePlayerWeaponEx(playerid, WEAPON:fData[fid][fGun][listitem], fData[fid][fAmmo][listitem]);

				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has taken a \"%s\" from their weapon storage.", ReturnName(playerid), ReturnWeaponName(WEAPON:fData[fid][fGun][listitem]));

				fData[fid][fGun][listitem] = WEAPON_FIST;
				fData[fid][fAmmo][listitem] = 0;

				Family_Save(fid);
				Family_WeaponStorage(playerid, fid);
			}
			else
			{
				new
					WEAPON:weaponid = GetPlayerWeaponEx(playerid),
					ammo = GetPlayerAmmoEx(playerid);

				if(!weaponid)
					return SendErrorMessage(playerid, "You are not holding any weapon!");

				/*if(weaponid == 23 && PlayerData[playerid][pTazer])
					return SendErrorMessage(playerid, "You can't store a tazer into your safe.");

				if(weaponid == 25 && PlayerData[playerid][pBeanBag])
					return SendErrorMessage(playerid, "You can't store a beanbag shotgun into your safe.");*/

				ResetWeapon(playerid, weaponid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has stored a \"%s\" into their weapon storage.", ReturnName(playerid), ReturnWeaponName(weaponid));

				fData[fid][fGun][listitem] = weaponid;
				fData[fid][fAmmo][listitem] = ammo;

				Family_Save(fid);
				Family_WeaponStorage(playerid, fid);
			}
		}
		else
		{
			Family_OpenStorage(playerid, fid);
		}
		return 1;
	}
	if(dialogid == FAMILY_MARIJUANA)
	{
		if(response)
		{
			new fid = PlayerData[playerid][pFamily];
			if(fid == -1) return SendErrorMessage(playerid, "You don't have family.");
			if(response)
			{
				switch (listitem)
				{
					case 0: 
					{
						if(PlayerData[playerid][pFamilyRank] < 5)
							return SendErrorMessage(playerid, "Only boss can withdraw marijuana!");
							
						new str[128];
						format(str, sizeof(str), "Marijuana Balance: %d\n\nPlease enter how much marijuana you wish to withdraw from the safe:", fData[fid][fMarijuana]);
						ShowPlayerDialog(playerid, FAMILY_WITHDRAWMARIJUANA, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
					}
					case 1: 
					{
						new str[128];
						format(str, sizeof(str), "Marijuana Balance: %d\n\nPlease enter how much marijuana you wish to deposit into the safe:", fData[fid][fMarijuana]);
						ShowPlayerDialog(playerid, FAMILY_DEPOSITMARIJUANA, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
					}
				}
			}
			else callcmd::fsafe(playerid);
		}
		return 1;
	}
	if(dialogid == FAMILY_WITHDRAWMARIJUANA)
	{
		new fid = PlayerData[playerid][pFamily];
		if(fid == -1) return SendErrorMessage(playerid, "You don't have family.");
		
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Marijuana Balance: %d\n\nPlease enter how much marijuana you wish to withdraw from the safe:", fData[fid][fMarijuana]);
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWMARIJUANA, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(amount < 1 || amount > fData[fid][fMarijuana])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nMarijuana Balance: %d\n\nPlease enter how much marijuana you wish to withdraw from the safe:", fData[fid][fMarijuana]);
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWMARIJUANA, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(Inventory_Add(playerid, "Marijuana", amount) == -1)
				return 1;

			fData[fid][fMarijuana] -= amount;

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %d marijuana from their family safe.", ReturnName(playerid), amount);
			callcmd::fsafe(playerid);
			return 1;
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_DEPOSITMARIJUANA)
	{
		new fid = PlayerData[playerid][pFamily];
		if(fid == -1) return SendErrorMessage(playerid, "You don't have family.");
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Marijuana Balance: %d\n\nPlease enter how much marijuana you wish to deposit into the safe:", fData[fid][fMarijuana]);
				ShowPlayerDialog(playerid, FAMILY_DEPOSITMARIJUANA, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			if(amount < 1 || amount > Inventory_Has(playerid, "Marijuana"))
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nMarijuana Balance: %d\n\nPlease enter how much marijuana you wish to deposit into the safe:", fData[fid][fMarijuana]);
				ShowPlayerDialog(playerid, FAMILY_DEPOSITMARIJUANA, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			fData[fid][fMarijuana] += amount;
			Inventory_Remove(playerid, "Marijuana", amount);

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %d marijuana into their family safe.", ReturnName(playerid), amount);
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_COMPONENT)
	{
		if(response)
		{
			new fid = PlayerData[playerid][pFamily];
			if(fid == -1) return SendErrorMessage(playerid, "You don't have family.");
			if(response)
			{
				switch (listitem)
				{
					case 0: 
					{
						if(PlayerData[playerid][pFamilyRank] < 5)
							return SendErrorMessage(playerid, "Only boss can withdraw component!");
							
						new str[128];
						format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much component you wish to withdraw from the safe:", fData[fid][fComponent]);
						ShowPlayerDialog(playerid, FAMILY_WITHDRAWCOMPONENT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
					}
					case 1: 
					{
						new str[128];
						format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much component you wish to deposit into the safe:", fData[fid][fComponent]);
						ShowPlayerDialog(playerid, FAMILY_DEPOSITCOMPONENT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
					}
				}
			}
			else callcmd::fsafe(playerid);
		}
		return 1;
	}
	if(dialogid == FAMILY_WITHDRAWCOMPONENT)
	{
		new fid = PlayerData[playerid][pFamily];
		if(fid == -1) return SendErrorMessage(playerid, "You don't have family.");
		
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much component you wish to withdraw from the safe:", fData[fid][fComponent]);
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWCOMPONENT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(amount < 1 || amount > fData[fid][fComponent])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nComponent Balance: %d\n\nPlease enter how much component you wish to withdraw from the safe:", fData[fid][fComponent]);
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWCOMPONENT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(Inventory_Add(playerid, "Component", amount) == -1)
				return 1;

			fData[fid][fComponent] -= amount;

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %d component from their family safe.", ReturnName(playerid), amount);
			callcmd::fsafe(playerid);
			return 1;
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_DEPOSITCOMPONENT)
	{
		new fid = PlayerData[playerid][pFamily];
		if(fid == -1) return SendErrorMessage(playerid, "You don't have family.");
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much component you wish to deposit into the safe:", fData[fid][fComponent]);
				ShowPlayerDialog(playerid, FAMILY_DEPOSITCOMPONENT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			if(amount < 1 || amount > Inventory_Has(playerid, "Component"))
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nComponent Balance: %d\n\nPlease enter how much component you wish to deposit into the safe:", fData[fid][fComponent]);
				ShowPlayerDialog(playerid, FAMILY_DEPOSITCOMPONENT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			fData[fid][fComponent] += amount;
			Inventory_Remove(playerid, "Component", amount);

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %d component into their family safe.", ReturnName(playerid), amount);
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_MATERIAL)
	{
		if(response)
		{
			new fid = PlayerData[playerid][pFamily];
			if(fid == -1) return SendErrorMessage(playerid, "You don't have family.");
			if(response)
			{
				switch (listitem)
				{
					case 0: 
					{
						if(PlayerData[playerid][pFamilyRank] < 5)
							return SendErrorMessage(playerid, "Only boss can withdraw material!");
							
						new str[128];
						format(str, sizeof(str), "Material Balance: %d\n\nPlease enter how much material you wish to withdraw from the safe:", fData[fid][fMaterial]);
						ShowPlayerDialog(playerid, FAMILY_WITHDRAWMATERIAL, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
					}
					case 1: 
					{
						new str[128];
						format(str, sizeof(str), "Material Balance: %d\n\nPlease enter how much material you wish to deposit into the safe:", fData[fid][fMaterial]);
						ShowPlayerDialog(playerid, FAMILY_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
					}
				}
			}
			else callcmd::fsafe(playerid);
		}
		return 1;
	}
	if(dialogid == FAMILY_WITHDRAWMATERIAL)
	{
		new fid = PlayerData[playerid][pFamily];
		if(fid == -1) return SendErrorMessage(playerid, "You don't have family.");
		
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Material Balance: %d\n\nPlease enter how much material you wish to withdraw from the safe:", fData[fid][fMaterial]);
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWMATERIAL, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(amount < 1 || amount > fData[fid][fMaterial])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nMaterial Balance: %d\n\nPlease enter how much material you wish to withdraw from the safe:", fData[fid][fMaterial]);
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWMATERIAL, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(Inventory_Add(playerid, "Material", amount) == -1)
				return 1;
			
			fData[fid][fMaterial] -= amount;

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %d material from their family safe.", ReturnName(playerid), amount);
			callcmd::fsafe(playerid);
			return 1;
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_DEPOSITMATERIAL)
	{
		new fid = PlayerData[playerid][pFamily];
		if(fid == -1) return SendErrorMessage(playerid, "You don't have family.");
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Material Balance: %d\n\nPlease enter how much material you wish to deposit into the safe:", fData[fid][fMaterial]);
				ShowPlayerDialog(playerid, FAMILY_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			if(amount < 1 || amount > Inventory_Has(playerid, "Material"))
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nMaterial Balance: %d\n\nPlease enter how much material you wish to deposit into the safe:", fData[fid][fMaterial]);
				ShowPlayerDialog(playerid, FAMILY_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			fData[fid][fMaterial] += amount;
			Inventory_Remove(playerid, "Material", amount);

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %d material into their family safe.", ReturnName(playerid), amount);
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_MONEY)
	{
		if(response)
		{
			new fid = PlayerData[playerid][pFamily];
			if(fid == -1) return SendErrorMessage(playerid, "You don't have family.");
			if(response)
			{
				switch (listitem)
				{
					case 0: 
					{
						if(PlayerData[playerid][pFamilyRank] < 5)
							return SendErrorMessage(playerid, "Only boss can withdraw money!");
							
						new str[128];
						format(str, sizeof(str), "Money Balance: %s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(fData[fid][fMoney]));
						ShowPlayerDialog(playerid, FAMILY_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
					}
					case 1: 
					{
						new str[128];
						format(str, sizeof(str), "Money Balance: %s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(fData[fid][fMoney]));
						ShowPlayerDialog(playerid, FAMILY_DEPOSITMONEY, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
					}
				}
			}
			else callcmd::fsafe(playerid);
		}
		return 1;
	}
	if(dialogid == FAMILY_WITHDRAWMONEY)
	{
		new fid = PlayerData[playerid][pFamily];
		if(fid == -1) return SendErrorMessage(playerid, "You don't have family.");
		
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Money Balance: %s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(fData[fid][fMoney]));
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(amount < 1 || amount > fData[fid][fMoney])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nMoney Balance: %s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(fData[fid][fMoney]));
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			fData[fid][fMoney] -= amount;
			GivePlayerMoneyEx(playerid, amount);

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %s money from their family safe.", ReturnName(playerid), FormatMoney(amount));
			callcmd::fsafe(playerid);
			return 1;
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_DEPOSITMONEY)
	{
		new fid = PlayerData[playerid][pFamily];
		if(fid == -1) return SendErrorMessage(playerid, "You don't have family.");
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Money Balance: %s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(fData[fid][fMoney]));
				ShowPlayerDialog(playerid, FAMILY_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			if(amount < 1 || amount > GetPlayerMoney(playerid))
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nMoney Balance: %s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(fData[fid][fMoney]));
				ShowPlayerDialog(playerid, FAMILY_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			fData[fid][fMoney] += amount;
			GivePlayerMoneyEx(playerid, -amount);

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %s money into their family safe.", ReturnName(playerid), FormatMoney(amount));
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_INFO)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(PlayerData[playerid][pFamily] == -1)
						return SendErrorMessage(playerid, "You dont have family!");
					new query[512];
					mysql_format(g_SQL, query, sizeof(query), "SELECT name,leader,marijuana,component,material,money FROM familys WHERE ID = %d", PlayerData[playerid][pFamily]);
					mysql_tquery(g_SQL, query, "ShowFamilyInfo", "i", playerid);
				}
				case 1:
				{
					if(PlayerData[playerid][pFamily] == -1)
						return SendErrorMessage(playerid, "You dont have family!");
						
					new lstr[1024];
					format(lstr, sizeof(lstr), "Rank\tName\n");
					foreach(new i: Player)
					{
						if(PlayerData[i][pFamily] == PlayerData[playerid][pFamily])
						{
							format(lstr, sizeof(lstr), "%s%s\t%s(%d)", lstr, GetFamilyRank(i), PlayerData[i][pName], i);
							format(lstr, sizeof(lstr), "%s\n", lstr);
						}
					}
					format(lstr, sizeof(lstr), "%s\n", lstr);
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Family Online", lstr, "Close", "");
					
				}
				case 2:
				{
					if(PlayerData[playerid][pFamily] == -1)
						return SendErrorMessage(playerid, "You dont have family!");
					new query[512];
					mysql_format(g_SQL, query, sizeof(query), "SELECT username,familyrank FROM players WHERE family = %d", PlayerData[playerid][pFamily]);
					mysql_tquery(g_SQL, query, "ShowFamilyMember", "i", playerid);
				}
			}
		}
		return 1;
	}
	//------------[ VIP Locker Dialog ]----------
	if(dialogid == DIALOG_LOCKERVIP)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0: 
				{
					SetPlayerHealthEx(playerid, 100);
				}
				case 1:
				{
					GivePlayerWeaponEx(playerid, WEAPON:1, 1);
					GivePlayerWeaponEx(playerid, WEAPON:7, 1);
					GivePlayerWeaponEx(playerid, WEAPON:15, 1);
				}
				case 2:
				{
					switch (PlayerData[playerid][pGender])
					{
						case 1: ShowModelSelectionMenu(playerid, "Choose Your Skin", VIP_MODEL_MALE, VipSkinMale, sizeof(VipSkinMale));
						case 2: ShowModelSelectionMenu(playerid, "Choose Your Skin", VIP_MODEL_FEMALE, VipSkinFemale, sizeof(VipSkinFemale));
					}
				}
				case 3:
				{
					new string[248];
					if(pToys[playerid][0][toy_model] == 0)
					{
						strcat(string, ""dot"Slot 1\n");
					}
					else strcat(string, ""dot"Slot 1 "RED_E"(Used)\n");

					if(pToys[playerid][1][toy_model] == 0)
					{
						strcat(string, ""dot"Slot 2\n");
					}
					else strcat(string, ""dot"Slot 2 "RED_E"(Used)\n");

					if(pToys[playerid][2][toy_model] == 0)
					{
						strcat(string, ""dot"Slot 3\n");
					}
					else strcat(string, ""dot"Slot 3 "RED_E"(Used)\n");

					if(pToys[playerid][3][toy_model] == 0)
					{
						strcat(string, ""dot"Slot 4\n");
					}
					else strcat(string, ""dot"Slot 4 "RED_E"(Used)\n");

					/*if(pToys[playerid][4][toy_model] == 0)
					{
						strcat(string, ""dot"Slot 5\n");
					}
					else strcat(string, ""dot"Slot 5 "RED_E"(Used)\n");

					if(pToys[playerid][5][toy_model] == 0)
					{
						strcat(string, ""dot"Slot 6\n");
					}
					else strcat(string, ""dot"Slot 6 "RED_E"(Used)\n");*/

					ShowPlayerDialog(playerid, DIALOG_TOYVIP, DIALOG_STYLE_LIST, "VIP Toys", string, "Select", "Cancel");
				}
			}
		}
	}
	//-------------[ Faction Commands Dialog ]-----------
	if(dialogid == DIALOG_LOCKERSAPD)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0: 
				{
					if(PlayerData[playerid][pOnDuty] == 1)
					{
						PlayerData[playerid][pOnDuty] = 0;
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s places their badge and gun in their locker.", ReturnName(playerid));
						ResetWeapon(playerid, WEAPON:25);
						ResetWeapon(playerid, WEAPON:27);
						ResetWeapon(playerid, WEAPON:29);
						ResetWeapon(playerid, WEAPON:31);
						ResetWeapon(playerid, WEAPON:33);
						ResetWeapon(playerid, WEAPON:34);
						KillTimer(DutyTimer[playerid]);
					}
					else
					{
						if(PlayerData[playerid][pFacSkin] == -1)
							return SendErrorMessage(playerid, "Kamu harus memilih seragam di loker");

						PlayerData[playerid][pOnDuty] = 1;
						SetFactionColor(playerid);
						SetPlayerSkin(playerid, PlayerData[playerid][pFacSkin]);
						DutyTimer[playerid] = SetTimerEx("DutyHour", 1000, true, "i", playerid);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s withdraws their badge and on duty from their locker", ReturnName(playerid));
					}
				}
				case 1: 
				{
					SetPlayerHealthEx(playerid, 100);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil medical kit dari locker", ReturnName(playerid));
				}
				case 2:
				{
					SetPlayerArmourEx(playerid, 97);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil armour pelindung dari locker", ReturnName(playerid));
				}
				case 3:
				{
					if(PlayerData[playerid][pOnDuty] <= 0)
						return SendErrorMessage(playerid, "Kamu harus On duty untuk mengambil barang!");
						
					ShowPlayerDialog(playerid, DIALOG_WEAPONSAPD, DIALOG_STYLE_LIST, "SAPD Weapons", "SPRAYCAN\nPARACHUTE\nNITE STICK\nKNIFE\nCOLT45\nSILENCED\nDEAGLE\nSHOTGUN\nSHOTGSPA\nMP5\nM4\nRIFLE\nSNIPER", "Pilih", "Batal");
				}
				case 4:
				{
					if(PlayerData[playerid][pOnDuty] <= 0)
						return SendErrorMessage(playerid, "Kamu harus On duty untuk mengambil barang!");
					
					switch (PlayerData[playerid][pGender])
					{
						case 1: ShowModelSelectionMenu(playerid, "Choose Your Skin", SAPD_MODEL_MALE, SAPDSkinMale, sizeof(SAPDSkinMale));
						case 2: ShowModelSelectionMenu(playerid, "Choose Your Skin", SAPD_MODEL_FEMALE, SAPDSkinFemale, sizeof(SAPDSkinFemale));
					}
				}
				case 5:
				{
					switch (PlayerData[playerid][pGender])
					{
						case 1: ShowModelSelectionMenu(playerid, "Choose Your Skin", SAPD_MODEL_WAR, SAPDSkinMale, sizeof(SAPDSkinMale));
						case 2: ShowModelSelectionMenu(playerid, "Choose Your Skin", SAPD_MODEL_FEMALE, SAPDSkinFemale, sizeof(SAPDSkinFemale));
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_WEAPONSAPD)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0:
				{
					GivePlayerWeaponEx(playerid, WEAPON:41, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:41));
				}
				case 1:
				{
					GivePlayerWeaponEx(playerid, WEAPON:46, 1);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:46));
				}
				case 2:
				{
					GivePlayerWeaponEx(playerid, WEAPON:3, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:3));
				}
				case 3:
				{
					GivePlayerWeaponEx(playerid, WEAPON:4, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:4));
				}
				case 4:
				{
					GivePlayerWeaponEx(playerid, WEAPON:22, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:22));
				}
				case 5:
				{
					if(PlayerData[playerid][pFactionRank] < 2)
						return SendErrorMessage(playerid, "You are not allowed!");
						
					GivePlayerWeaponEx(playerid, WEAPON:23, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:23));
				}
				case 6:
				{
					if(PlayerData[playerid][pFactionRank] < 2)
						return SendErrorMessage(playerid, "You are not allowed!");
						
					GivePlayerWeaponEx(playerid, WEAPON:24, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:24));
				}	
				case 7:
				{
					if(PlayerData[playerid][pFactionRank] < 3)
						return SendErrorMessage(playerid, "You are not allowed!");
					GivePlayerWeaponEx(playerid, WEAPON:25, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:25));
				}
				case 8:
				{
					if(PlayerData[playerid][pFactionRank] < 3)
						return SendErrorMessage(playerid, "You are not allowed!");
					GivePlayerWeaponEx(playerid, WEAPON:27, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:27));
				}
				case 9:
				{
					if(PlayerData[playerid][pFactionRank] < 3)
						return SendErrorMessage(playerid, "You are not allowed!");
					GivePlayerWeaponEx(playerid, WEAPON:29, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:29));
				}
				case 10:
				{
					if(PlayerData[playerid][pFactionRank] < 4)
						return SendErrorMessage(playerid, "You are not allowed!");
					GivePlayerWeaponEx(playerid, WEAPON:31, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:31));
				}
				case 11:
				{
					if(PlayerData[playerid][pFactionRank] < 4)
						return SendErrorMessage(playerid, "You are not allowed!");
					GivePlayerWeaponEx(playerid, WEAPON:33, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:33));
				}
				case 12:
				{
					if(PlayerData[playerid][pFactionRank] < 4)
						return SendErrorMessage(playerid, "You are not allowed!");
					GivePlayerWeaponEx(playerid, WEAPON:34, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:34));
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_LOCKERSAGS)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0: 
				{
					if(PlayerData[playerid][pOnDuty] == 1)
					{
						PlayerData[playerid][pOnDuty] = 0;
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s places their badge and gun in their locker.", ReturnName(playerid));
					}
					else
					{
						if(PlayerData[playerid][pFacSkin] == -1)
							return SendErrorMessage(playerid, "Kamu harus memilih seragam di loker");

						PlayerData[playerid][pOnDuty] = 1;
						SetFactionColor(playerid);
						SetPlayerSkin(playerid, PlayerData[playerid][pFacSkin]);
						DutyTimer[playerid] = SetTimerEx("DutyHour", 1000, true, "i", playerid);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s withdraws their badge and on duty from their locker", ReturnName(playerid));
					}
				}
				case 1: 
				{
					SetPlayerHealthEx(playerid, 100);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil medical kit dari locker", ReturnName(playerid));
				}
				case 2:
				{
					SetPlayerArmourEx(playerid, 97);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil armour pelindung dari locker", ReturnName(playerid));
				}
				case 3:
				{
					if(PlayerData[playerid][pOnDuty] <= 0)
						return SendErrorMessage(playerid, "Kamu harus On duty untuk mengambil barang!");
						
					ShowPlayerDialog(playerid, DIALOG_WEAPONSAGS, DIALOG_STYLE_LIST, "SAGS Weapons", "Parachute", "Pilih", "Batal");
				}
				case 4:
				{
					switch (PlayerData[playerid][pGender])
					{
						case 1: ShowModelSelectionMenu(playerid, "Choose Your Skin", SAGS_MODEL_MALE, SAGSSkinMale, sizeof(SAGSSkinMale));
						case 2: ShowModelSelectionMenu(playerid, "Choose Your Skin", SAGS_MODEL_FEMALE, SAGSSkinFemale, sizeof(SAGSSkinFemale));
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_WEAPONSAGS)
	{
		if(response)
		{
			GivePlayerWeaponEx(playerid, WEAPON:46, 1);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:46));
		}
		return 1;
	}
	if(dialogid == DIALOG_LOCKERSAMD)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0: 
				{
					if(PlayerData[playerid][pOnDuty] == 1)
					{
						PlayerData[playerid][pOnDuty] = 0;
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s places their badge and gun in their locker.", ReturnName(playerid));
					}
					else
					{
						if(PlayerData[playerid][pFacSkin] == -1)
							return SendErrorMessage(playerid, "Kamu harus memilih seragam di loker");

						PlayerData[playerid][pOnDuty] = 1;
						SetFactionColor(playerid);
						SetPlayerSkin(playerid, PlayerData[playerid][pFacSkin]);
						DutyTimer[playerid] = SetTimerEx("DutyHour", 1000, true, "i", playerid);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s withdraws their badge and on duty from their locker", ReturnName(playerid));
					}
				}
				case 1: 
				{
					SetPlayerHealthEx(playerid, 100);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil medical kit dari locker", ReturnName(playerid));
				}
				case 2:
				{
					SetPlayerArmourEx(playerid, 97);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil armour pelindung dari locker", ReturnName(playerid));
				}
				case 3:
				{
					if(PlayerData[playerid][pOnDuty] <= 0)
						return SendErrorMessage(playerid, "Kamu harus On duty untuk mengambil barang!");
					
					ShowPlayerDialog(playerid, DIALOG_WEAPONSAMD, DIALOG_STYLE_LIST, "SAMD Weapons", "Parachute", "Pilih", "Batal");
				}
				case 4:
				{
					switch (PlayerData[playerid][pGender])
					{
						case 1: ShowModelSelectionMenu(playerid, "Choose Your Skin", SAMD_MODEL_MALE, SAMDSkinMale, sizeof(SAMDSkinMale));
						case 2: ShowModelSelectionMenu(playerid, "Choose Your Skin", SAMD_MODEL_FEMALE, SAMDSkinFemale, sizeof(SAMDSkinFemale));
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_WEAPONSAMD)
	{
		if(response)
		{
			GivePlayerWeaponEx(playerid, WEAPON:46, 1);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:46));
		}
		return 1;
	}
	if(dialogid == DIALOG_LOCKERSANEW)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0: 
				{
					if(PlayerData[playerid][pOnDuty] == 1)
					{
						PlayerData[playerid][pOnDuty] = 0;
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s places their badge and gun in their locker.", ReturnName(playerid));
					}
					else
					{
						if(PlayerData[playerid][pFacSkin] == -1)
							return SendErrorMessage(playerid, "Kamu harus memilih seragam di loker!");

						PlayerData[playerid][pOnDuty] = 1;
						SetFactionColor(playerid);
						SetPlayerSkin(playerid, PlayerData[playerid][pFacSkin]);
						DutyTimer[playerid] = SetTimerEx("DutyHour", 1000, true, "i", playerid);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s withdraws their badge and on duty from their locker", ReturnName(playerid));
					}
				}
				case 1: 
				{
					SetPlayerHealthEx(playerid, 100);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil medical kit dari locker", ReturnName(playerid));
				}
				case 2:
				{
					SetPlayerArmourEx(playerid, 97);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil armour pelindung dari locker", ReturnName(playerid));
				}
				case 3:
				{
					if(PlayerData[playerid][pOnDuty] <= 0)
						return SendErrorMessage(playerid, "Kamu harus On duty untuk mengambil barang!");
						
					ShowPlayerDialog(playerid, DIALOG_WEAPONSANEW, DIALOG_STYLE_LIST, "SAPD Weapons", "Camera\nParachute", "Pilih", "Batal");
				}
				case 4:
				{
					switch (PlayerData[playerid][pGender])
					{
						case 1: ShowModelSelectionMenu(playerid, "Choose Your Skin", SANA_MODEL_MALE, SANASkinMale, sizeof(SANASkinMale));
						case 2: ShowModelSelectionMenu(playerid, "Choose Your Skin", SANA_MODEL_FEMALE, SANASkinFemale, sizeof(SANASkinFemale));
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_WEAPONSANEW)
	{
		if(response)
		{
			new WEAPON:weapon;
			switch (listitem) 
			{
				case 0: weapon = WEAPON_CAMERA;
				case 1: weapon = WEAPON_PARACHUTE;
			}
			GivePlayerWeaponEx(playerid, weapon, 1);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(weapon));
		}
		return 1;
	}
	if(dialogid == DIALOG_LOCKERSAFD)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0: 
				{
					if(PlayerData[playerid][pOnDuty] == 1)
					{
						PlayerData[playerid][pOnDuty] = 0;
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
						ResetWeapon(playerid, WEAPON:42);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s places their badge and gun in their locker.", ReturnName(playerid));
					}
					else
					{
						if(PlayerData[playerid][pFacSkin] == -1)
							return SendErrorMessage(playerid, "Kamu harus memilih seragam di loker!");

						PlayerData[playerid][pOnDuty] = 1;
						SetFactionColor(playerid);
						SetPlayerSkin(playerid, PlayerData[playerid][pFacSkin]);
						DutyTimer[playerid] = SetTimerEx("DutyHour", 1000, true, "i", playerid);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s withdraws their badge and on duty from their locker", ReturnName(playerid));
					}
				}
				case 1: 
				{
					SetPlayerHealthEx(playerid, 100);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil medical kit dari locker", ReturnName(playerid));
				}
				case 2:
				{
					SetPlayerArmourEx(playerid, 97);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil armour pelindung dari locker", ReturnName(playerid));
				}
				case 3:
				{
					if(PlayerData[playerid][pOnDuty] <= 0)
						return SendErrorMessage(playerid, "Kamu harus On duty untuk mengambil barang!");
						
					ShowPlayerDialog(playerid, DIALOG_WEAPONSAFD, DIALOG_STYLE_LIST, "SAFD Weapons", "Fire Extinguisher\nParachute", "Pilih", "Batal");
				}
				case 4:
				{
					switch (PlayerData[playerid][pGender])
					{
						case 1: ShowModelSelectionMenu(playerid, "Choose Your Skin", SAFD_MODEL_MALE, SAFDSkinMale, sizeof(SAFDSkinMale));
						case 2: ShowModelSelectionMenu(playerid, "Choose Your Skin", SAFD_MODEL_FEMALE, SAFDSkinFemale, sizeof(SAFDSkinFemale));
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_WEAPONSAFD)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0:
				{
					GivePlayerWeaponEx(playerid, WEAPON:42, 1000);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:42));
				}
				case 1:
				{
					GivePlayerWeaponEx(playerid, WEAPON:46, 1);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(WEAPON:46));
				}
			}
		}
		return 1;
	}
	//--------[ DIALOG JOB ]--------
	if(dialogid == DIALOG_SERVICE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						new Float:health, comp;
						GetVehicleHealth(PlayerData[playerid][pMechVeh], health);
						if(health > 1000.0) health = 1000.0;
						if(health > 0.0) health *= -1;
						comp = floatround(health, floatround_round) / 10 + 100;
						
						if(Inventory_Has(playerid, "Component") < comp) return SendErrorMessage(playerid, "Component anda kurang!");
						if(comp <= 0) return SendErrorMessage(playerid, "This vehicle can't be fixing.");
						Inventory_Remove(playerid, "Component", comp);
						SendInfoMessage(playerid, "Anda memperbaiki mesin kendaraan dengan "RED_E"%d component.", comp);
						PlayerData[playerid][pMechanic] = SetTimerEx("EngineFix", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Fixing Engine...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						new VEHICLE_PANEL_STATUS:panels, VEHICLE_DOOR_STATUS:doors, VEHICLE_LIGHT_STATUS:light, VEHICLE_TYRE_STATUS:tires, comp;
						
						GetVehicleDamageStatus(PlayerData[playerid][pMechVeh], panels, doors, light, tires);
						new cpanels = _:panels / 1000000;
						new lights = _:light / 2;
						new pintu;
						if(doors != VEHICLE_DOOR_STATUS_NONE) pintu = 5;
						if(doors == VEHICLE_DOOR_STATUS_NONE) pintu = 0;
						comp = cpanels + lights + pintu + 20;
						
						if(Inventory_Has(playerid, "Component") < comp) return SendErrorMessage(playerid, "Component anda kurang!");
						if(comp <= 0) return SendErrorMessage(playerid, "This vehicle can't be fixing.");
						Inventory_Remove(playerid, "Component", comp);
						SendInfoMessage(playerid, "Anda memperbaiki body kendaraan dengan "RED_E"%d component.", comp);
						PlayerData[playerid][pMechanic] = SetTimerEx("BodyFix", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Fixing Body...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					if(IsAtMech(playerid) || IsPlayerNearWorkshop(playerid) != -1)
					{
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 40) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_COLOR, DIALOG_STYLE_INPUT, "Color ID 1", "%s\n\nSelect these color for color 1:", "Next", "Close", color_string);
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 3:
				{
					if(IsAtMech(playerid) || IsPlayerNearWorkshop(playerid) != -1)
					{
					
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 100) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_PAINTJOB, DIALOG_STYLE_INPUT, "Paintjob", "Enter the vehicle paintjob id:(0 - 2 | 3 - Remove paintJob)", "Paintjob", "Close");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 4:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 85) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_WHEELS, DIALOG_STYLE_LIST, "Wheels", "Offroad\nMega\nWires\nTwist\nGrove\nImport\nAtomic\nAhab\nVirtual\nAccess\nTrance\nShadow\nRimshine\nClassic\nCutter\nSwitch\nDollar", "Confirm", "back");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 5:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_SPOILER,DIALOG_STYLE_LIST,"Choose below","Wheel Arc. Alien Spoiler\nWheel Arc. X-Flow Spoiler\nTransfender Win Spoiler\nTransfender Fury Spoiler\nTransfender Alpha Spoiler\nTransfender Pro Spoiler\nTransfender Champ Spoiler\nTransfender Race Spoiler\nTransfender Drag Spoiler\n","Choose","back");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 6:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_HOODS, DIALOG_STYLE_LIST, "Hoods", "Fury\nChamp\nRace\nWorx\n", "Confirm", "back");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 7:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_VENTS, DIALOG_STYLE_LIST, "Vents", "Oval\nSquare\n", "Confirm", "back");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 8:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 50) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_LIGHTS, DIALOG_STYLE_LIST, "Lights", "Round\nSquare\n", "Confirm", "back");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 9:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 80) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_EXHAUSTS, DIALOG_STYLE_LIST, "Exhausts", "Wheel Arc. Alien exhaust\nWheel Arc. X-Flow exhaust\nLow Co. Chromer exhaust\nLow Co. Slamin exhaust\nTransfender Large exhaust\nTransfender Medium exhaust\nTransfender Small exhaust\nTransfender Twin exhaust\nTransfender Upswept exhaust", "Confirm", "back");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 10:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 100) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_FRONT_BUMPERS, DIALOG_STYLE_LIST, "Front bumpers", "Wheel Arc. Alien Bumper\nWheel Arc. X-Flow Bumper\nLow co. Chromer Bumper\nLow co. Slamin Bumper", "Confirm", "back");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 11:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 100) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_REAR_BUMPERS, DIALOG_STYLE_LIST, "Rear bumpers", "Wheel Arc. Alien Bumper\nWheel Arc. X-Flow Bumper\nLow co. Chromer Bumper\nLow co. Slamin Bumper", "Confirm", "back");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 12:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_ROOFS, DIALOG_STYLE_LIST, "Roofs", "Wheel Arc. Alien\nWheel Arc. X-Flow\nLow Co. Hardtop Roof\nLow Co. Softtop Roof\nTransfender Roof Scoop", "Confirm", "back");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 13:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 90) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_SIDE_SKIRTS, DIALOG_STYLE_LIST, "Side skirts", "Wheel Arc. Alien Side Skirt\nWheel Arc. X-Flow Side Skirt\nLocos Chrome Strip\nLocos Chrome Flames\nLocos Chrome Arches \nLocos Chrome Trim\nLocos Wheelcovers\nTransfender Side Skirt", "Confirm", "back");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
					SendInfoMessage(playerid, "Side blm ada.");
				}
				case 14:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 50) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_BULLBARS, DIALOG_STYLE_LIST, "Bull bars", "Locos Chrome Grill\nLocos Chrome Bars\nLocos Chrome Lights \nLocos Chrome Bullbar", "Confirm", "back");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 15:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						PlayerData[playerid][pMechColor1] = 1086;
						PlayerData[playerid][pMechColor2] = 0;
				
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{	
							if(Inventory_Has(playerid, "Component") < 150) return SendErrorMessage(playerid, "Component anda kurang!");
							Inventory_Remove(playerid, "Component", 150);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"150 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pMechColor1] = 0;
							PlayerData[playerid][pMechColor2] = 0;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 16:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						PlayerData[playerid][pMechColor1] = 1087;
						PlayerData[playerid][pMechColor2] = 0;
				
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{	
							if(Inventory_Has(playerid, "Component") < 150) return SendErrorMessage(playerid, "Component anda kurang!");
							Inventory_Remove(playerid, "Component", 150);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"150 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pMechColor1] = 0;
							PlayerData[playerid][pMechColor2] = 0;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 17:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
						PlayerData[playerid][pMechColor1] = 1009;
						PlayerData[playerid][pMechColor2] = 0;
				
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{	
							if(Inventory_Has(playerid, "Component") < 250) return SendErrorMessage(playerid, "Component anda kurang!");
							Inventory_Remove(playerid, "Component", 250);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"250 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pMechColor1] = 0;
							PlayerData[playerid][pMechColor2] = 0;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 18:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
					
						PlayerData[playerid][pMechColor1] = 1008;
						PlayerData[playerid][pMechColor2] = 0;
				
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{	
							if(Inventory_Has(playerid, "Component") < 375) return SendErrorMessage(playerid, "Component anda kurang!");
							Inventory_Remove(playerid, "Component", 375);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"375 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pMechColor1] = 0;
							PlayerData[playerid][pMechColor2] = 0;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 19:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
						PlayerData[playerid][pMechColor1] = 1010;
						PlayerData[playerid][pMechColor2] = 0;
				
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{	
							if(Inventory_Has(playerid, "Component") < 500) return SendErrorMessage(playerid, "Component anda kurang!");
							Inventory_Remove(playerid, "Component", 500);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"500 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pMechColor1] = 0;
							PlayerData[playerid][pMechColor2] = 0;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
				case 20:
				{
					if(IsPlayerNearWorkshop(playerid) != -1)
					{
						if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
						{
							if(Inventory_Has(playerid, "Component") < 450) return SendErrorMessage(playerid, "Component anda kurang!");
							ShowPlayerDialog(playerid, DIALOG_SERVICE_NEON,DIALOG_STYLE_LIST,"Neon","RED\nBLUE\nGREEN\nYELLOW\nPINK\nWHITE\nREMOVE","Choose","back");
						}
						else
						{
							KillTimer(PlayerData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							PlayerData[playerid][pActivityTime] = 0;
							SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
					else return SendErrorMessage(playerid, "You must in Mechanic Center Area!");
				}
			}
		}
	}
	if(dialogid == DIALOG_SERVICE_COLOR)
	{
		if(response)
		{
			PlayerData[playerid][pMechColor1] = floatround(strval(inputtext));
			
			if(PlayerData[playerid][pMechColor1] < 0 || PlayerData[playerid][pMechColor1] > 255)
				return ShowPlayerDialog(playerid, DIALOG_SERVICE_COLOR, DIALOG_STYLE_INPUT, "Color ID 1", "%s\n\nSelect these color for color 1:", "Next", "Close", color_string);
			
			ShowPlayerDialog(playerid, DIALOG_SERVICE_COLOR2, DIALOG_STYLE_INPUT, "Color ID 2", "%s\n\nSelect these color for color 2:", "Next", "Close", color_string);
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_COLOR2)
	{
		if(response)
		{
			PlayerData[playerid][pMechColor2] = floatround(strval(inputtext));
			
			if(PlayerData[playerid][pMechColor2] < 0 || PlayerData[playerid][pMechColor2] > 255)
				return ShowPlayerDialog(playerid, DIALOG_SERVICE_COLOR2, DIALOG_STYLE_INPUT, "Color ID 2", "%s\n\nSelect these color for color 2:", "Next", "Close", color_string);
			
			if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
			if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
			{	
				if(Inventory_Has(playerid, "Component") < 40) return SendErrorMessage(playerid, "Component anda kurang!");
				Inventory_Remove(playerid, "Component", 40);
				SendInfoMessage(playerid, "Anda mengganti warna kendaraan dengan "RED_E"30 component.");
				ApplyAnimation(playerid, "GRAFFITI", "spraycan_fire", 4.1, true, false, false, true, 0, SYNC_ALL);
				PlayerData[playerid][pMechanic] = SetTimerEx("SprayCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Spraying Car...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			}
			else
			{
				KillTimer(PlayerData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
				PlayerData[playerid][pMechColor1] = 0;
				PlayerData[playerid][pMechColor2] = 0;
				PlayerData[playerid][pActivityTime] = 0;
				SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
				return 1;
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_PAINTJOB)
	{
		if(response)
		{
			PlayerData[playerid][pMechColor1] = floatround(strval(inputtext));
			
			if(PlayerData[playerid][pMechColor1] < 0 || PlayerData[playerid][pMechColor1] > 3)
				return ShowPlayerDialog(playerid, DIALOG_SERVICE_PAINTJOB, DIALOG_STYLE_INPUT, "Paintjob", "Enter the vehicle paintjob id:(0 - 2 | 3 - Remove paintJob)", "Paintjob", "Close");
			
			if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
			if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
			{	
				if(Inventory_Has(playerid, "Component") < 100) return SendErrorMessage(playerid, "Component anda kurang!");
				Inventory_Remove(playerid, "Component", 100);
				SendInfoMessage(playerid, "Anda mengganti paintjob kendaraan dengan "RED_E"50 component.");
				ApplyAnimation(playerid, "GRAFFITI", "spraycan_fire", 4.1, true, false, false, true, 0, SYNC_ALL);
				PlayerData[playerid][pMechanic] = SetTimerEx("PaintjobCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Painting Car...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			}
			else
			{
				KillTimer(PlayerData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
				PlayerData[playerid][pMechColor1] = 0;
				PlayerData[playerid][pMechColor2] = 0;
				PlayerData[playerid][pActivityTime] = 0;
				SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
				return 1;
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_WHEELS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					PlayerData[playerid][pMechColor1] = 1025;
					PlayerData[playerid][pMechColor2] = 0;

					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 85) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 85);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					PlayerData[playerid][pMechColor1] = 1074;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					PlayerData[playerid][pMechColor1] = 1076;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					PlayerData[playerid][pMechColor1] = 1078;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 4:
				{
					PlayerData[playerid][pMechColor1] = 1081;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 5:
				{
					PlayerData[playerid][pMechColor1] = 1082;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 6:
				{
					PlayerData[playerid][pMechColor1] = 1085;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 7:
				{
					PlayerData[playerid][pMechColor1] = 1096;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 8:
				{
					PlayerData[playerid][pMechColor1] = 1097;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 9:
				{
					PlayerData[playerid][pMechColor1] = 1098;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 10:
				{
					PlayerData[playerid][pMechColor1] = 1084;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 11:
				{
					PlayerData[playerid][pMechColor1] = 1073;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 12:
				{
					PlayerData[playerid][pMechColor1] = 1075;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 13:
				{
					PlayerData[playerid][pMechColor1] = 1077;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 14:
				{
					PlayerData[playerid][pMechColor1] = 1079;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 15:
				{
					PlayerData[playerid][pMechColor1] = 1080;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 16:
				{
					PlayerData[playerid][pMechColor1] = 1083;
					PlayerData[playerid][pMechColor2] = 0;
			
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{	
						if(Inventory_Has(playerid, "Component") < 60) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 60);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"60 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_SPOILER)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								PlayerData[playerid][pMechColor1] = 1147;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								PlayerData[playerid][pMechColor1] = 1049;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								PlayerData[playerid][pMechColor1] = 1162;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								PlayerData[playerid][pMechColor1] = 1058;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								PlayerData[playerid][pMechColor1] = 1164;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								PlayerData[playerid][pMechColor1] = 1138;
								PlayerData[playerid][pMechColor2] = 0;
							}
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								PlayerData[playerid][pMechColor1] = 1146;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								PlayerData[playerid][pMechColor1] = 1050;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								PlayerData[playerid][pMechColor1] = 1158;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								PlayerData[playerid][pMechColor1] = 1060;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								PlayerData[playerid][pMechColor1] = 1163;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								PlayerData[playerid][pMechColor1] = 1139;
								PlayerData[playerid][pMechColor2] = 0;
							}
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 527 ||
						VehicleModel == 415 ||
						VehicleModel == 546 ||
						VehicleModel == 603 ||
						VehicleModel == 426 ||
						VehicleModel == 436 ||
						VehicleModel == 405 ||
						VehicleModel == 477 ||
						VehicleModel == 580 ||
						VehicleModel == 550 ||
						VehicleModel == 549)
						{
				
							PlayerData[playerid][pMechColor1] = 1001;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 518 ||
						VehicleModel == 415 ||
						VehicleModel == 546 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 405 ||
						VehicleModel == 477 ||
						VehicleModel == 580 ||
						VehicleModel == 550 ||
						VehicleModel == 549)
						{
				
							PlayerData[playerid][pMechColor1] = 1023;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 4:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 518 ||
						VehicleModel == 415 ||
						VehicleModel == 401 ||
						VehicleModel == 517 ||
						VehicleModel == 426 ||
						VehicleModel == 436 ||
						VehicleModel == 477 ||
						VehicleModel == 547 ||
						VehicleModel == 550 ||
						VehicleModel == 549)
						{
				
							PlayerData[playerid][pMechColor1] = 1003;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 5:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 589 ||
						VehicleModel == 492 ||
						VehicleModel == 547 ||
						VehicleModel == 405)
						{
				
							PlayerData[playerid][pMechColor1] = 1000;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 6:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 527 ||
						VehicleModel == 542 ||
						VehicleModel == 405)
						{
				
							PlayerData[playerid][pMechColor1] = 1014;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 7:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 527 ||
						VehicleModel == 542)
						{
				
							PlayerData[playerid][pMechColor1] = 1015;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 8:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 546 ||
						VehicleModel == 517)
						{
				
							PlayerData[playerid][pMechColor1] = 1002;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_SERVICE_HOODS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(
						VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 589 ||
						VehicleModel == 492 ||
						VehicleModel == 426 ||
						VehicleModel == 550)
						{
				
							PlayerData[playerid][pMechColor1] = 1005;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(
						VehicleModel == 401 ||
						VehicleModel == 402 ||
						VehicleModel == 546 ||
						VehicleModel == 426 ||
						VehicleModel == 550)
						{
				
							PlayerData[playerid][pMechColor1] = 1004;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 401)
						{
				
							PlayerData[playerid][pMechColor1] = 1011;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 549)
						{
				
							PlayerData[playerid][pMechColor1] = 1012;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_VENTS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 546 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 547 ||
						VehicleModel == 439 ||
						VehicleModel == 550 ||
						VehicleModel == 549)
						{
				
							PlayerData[playerid][pMechColor1] = 1142;
							PlayerData[playerid][pMechColor2] = 1143;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 589 ||
						VehicleModel == 546 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 439 ||
						VehicleModel == 550 ||
						VehicleModel == 549)
						{
				
							PlayerData[playerid][pMechColor1] = 1144;
							PlayerData[playerid][pMechColor2] = 1145;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_SERVICE_LIGHTS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 589 ||
						VehicleModel == 400 ||
						VehicleModel == 436 ||
						VehicleModel == 439)
						{
				
							PlayerData[playerid][pMechColor1] = 1013;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 589 ||
						VehicleModel == 603 ||
						VehicleModel == 400)
						{
				
							PlayerData[playerid][pMechColor1] = 1024;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_EXHAUSTS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 80) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 558 ||
						VehicleModel == 561 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								PlayerData[playerid][pMechColor1] = 1034;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								PlayerData[playerid][pMechColor1] = 1046;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								PlayerData[playerid][pMechColor1] = 1065;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								PlayerData[playerid][pMechColor1] = 1064;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								PlayerData[playerid][pMechColor1] = 1028;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								PlayerData[playerid][pMechColor1] = 1089;
								PlayerData[playerid][pMechColor2] = 0;
							}
							Inventory_Remove(playerid, "Component", 80);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"80 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 80) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 558 ||
						VehicleModel == 561 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								PlayerData[playerid][pMechColor1] = 1037;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								PlayerData[playerid][pMechColor1] = 1045;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								PlayerData[playerid][pMechColor1] = 1066;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								PlayerData[playerid][pMechColor1] = 1059;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								PlayerData[playerid][pMechColor1] = 1029;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								PlayerData[playerid][pMechColor1] = 1092;
								PlayerData[playerid][pMechColor2] = 0;
							}
							Inventory_Remove(playerid, "Component", 80);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"80 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 80) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 534 ||
						VehicleModel == 567 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 535)
						{
							if(VehicleModel == 575)
							{
								PlayerData[playerid][pMechColor1] = 1044;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 534)
							{
								PlayerData[playerid][pMechColor1] = 1126;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 567)
							{
								PlayerData[playerid][pMechColor1] = 1129;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								PlayerData[playerid][pMechColor1] = 1104;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 576)
							{
								PlayerData[playerid][pMechColor1] = 1113;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 535)
							{
								PlayerData[playerid][pMechColor1] = 1136;
								PlayerData[playerid][pMechColor2] = 0;
							}
							Inventory_Remove(playerid, "Component", 80);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"80 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 80) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 534 ||
						VehicleModel == 567 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 535)
						{
							if(VehicleModel == 575)
							{
								PlayerData[playerid][pMechColor1] = 1043;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 534)
							{
								PlayerData[playerid][pMechColor1] = 1127;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 567)
							{
								PlayerData[playerid][pMechColor1] = 1132;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								PlayerData[playerid][pMechColor1] = 1105;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 576)
							{
								PlayerData[playerid][pMechColor1] = 1135;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 535)
							{
								PlayerData[playerid][pMechColor1] = 1114;
								PlayerData[playerid][pMechColor2] = 0;
							}
							Inventory_Remove(playerid, "Component", 80);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"80 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 4:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 80) return SendErrorMessage(playerid, "Component anda kurang!");
						if(
						VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 527 ||
						VehicleModel == 542 ||
						VehicleModel == 589 ||
						VehicleModel == 400 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 426 ||
						VehicleModel == 547 ||
						VehicleModel == 405 ||
						VehicleModel == 580 ||
						VehicleModel == 550 ||
						VehicleModel == 549 ||
						VehicleModel == 477)
						{
							
							PlayerData[playerid][pMechColor1] = 1020;
							PlayerData[playerid][pMechColor2] = 0;
								
							Inventory_Remove(playerid, "Component", 80);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"80 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 5:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 80) return SendErrorMessage(playerid, "Component anda kurang!");
						if(
						VehicleModel == 527 ||
						VehicleModel == 542 ||
						VehicleModel == 400 ||
						VehicleModel == 426 ||
						VehicleModel == 436 ||
						VehicleModel == 547 ||
						VehicleModel == 405 ||
						VehicleModel == 477)
						{
							
							PlayerData[playerid][pMechColor1] = 1021;
							PlayerData[playerid][pMechColor2] = 0;
								
							Inventory_Remove(playerid, "Component", 80);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"80 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 6:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 80) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 436)
						{
							
							PlayerData[playerid][pMechColor1] = 1022;
							PlayerData[playerid][pMechColor2] = 0;
								
							Inventory_Remove(playerid, "Component", 80);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"80 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 7:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 80) return SendErrorMessage(playerid, "Component anda kurang!");
						if(
						VehicleModel == 518 ||
						VehicleModel == 415 ||
						VehicleModel == 542 ||
						VehicleModel == 546 ||
						VehicleModel == 400 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 426 ||
						VehicleModel == 436 ||
						VehicleModel == 547 ||
						VehicleModel == 405 ||
						VehicleModel == 550 ||
						VehicleModel == 549 ||
						VehicleModel == 477)
						{
							
							PlayerData[playerid][pMechColor1] = 1019;
							PlayerData[playerid][pMechColor2] = 0;
								
							Inventory_Remove(playerid, "Component", 80);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"80 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 8:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 80) return SendErrorMessage(playerid, "Component anda kurang!");
						if(
						VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 415 ||
						VehicleModel == 542 ||
						VehicleModel == 546 ||
						VehicleModel == 400 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 426 ||
						VehicleModel == 415 ||
						VehicleModel == 547 ||
						VehicleModel == 405 ||
						VehicleModel == 550 ||
						VehicleModel == 549 ||
						VehicleModel == 477)
						{
							
							PlayerData[playerid][pMechColor1] = 1018;
							PlayerData[playerid][pMechColor2] = 0;
								
							Inventory_Remove(playerid, "Component", 80);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"80 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_FRONT_BUMPERS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 100) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								PlayerData[playerid][pMechColor1] = 1171;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								PlayerData[playerid][pMechColor1] = 1153;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								PlayerData[playerid][pMechColor1] = 1160;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								PlayerData[playerid][pMechColor1] = 1155;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								PlayerData[playerid][pMechColor1] = 1166;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								PlayerData[playerid][pMechColor1] = 1169;
								PlayerData[playerid][pMechColor2] = 0;
							}
							
							Inventory_Remove(playerid, "Component", 100);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"100 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 100) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								PlayerData[playerid][pMechColor1] = 1172;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								PlayerData[playerid][pMechColor1] = 1152;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								PlayerData[playerid][pMechColor1] = 1173;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								PlayerData[playerid][pMechColor1] = 1157;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								PlayerData[playerid][pMechColor1] = 1165;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								PlayerData[playerid][pMechColor1] = 1170;
								PlayerData[playerid][pMechColor2] = 0;
							}
							
							Inventory_Remove(playerid, "Component", 100);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"100 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 100) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 534 ||
						VehicleModel == 567 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 535)
						{
							if(VehicleModel == 575)
							{
								PlayerData[playerid][pMechColor1] = 1174;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 534)
							{
								PlayerData[playerid][pMechColor1] = 1179;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 567)
							{
								PlayerData[playerid][pMechColor1] = 1189;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								PlayerData[playerid][pMechColor1] = 1182;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 576)
							{
								PlayerData[playerid][pMechColor1] = 1191;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 535)
							{
								PlayerData[playerid][pMechColor1] = 1115;
								PlayerData[playerid][pMechColor2] = 0;
							}
							
							Inventory_Remove(playerid, "Component", 100);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"100 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 100) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 534 ||
						VehicleModel == 567 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 535)
						{
							if(VehicleModel == 575)
							{
								PlayerData[playerid][pMechColor1] = 1175;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 534)
							{
								PlayerData[playerid][pMechColor1] = 1185;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 567)
							{
								PlayerData[playerid][pMechColor1] = 1188;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								PlayerData[playerid][pMechColor1] = 1181;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 576)
							{
								PlayerData[playerid][pMechColor1] = 1190;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 535)
							{
								PlayerData[playerid][pMechColor1] = 1116;
								PlayerData[playerid][pMechColor2] = 0;
							}
							
							Inventory_Remove(playerid, "Component", 100);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"100 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_REAR_BUMPERS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 100) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								PlayerData[playerid][pMechColor1] = 1149;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								PlayerData[playerid][pMechColor1] = 1150;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								PlayerData[playerid][pMechColor1] = 1159;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								PlayerData[playerid][pMechColor1] = 1154;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								PlayerData[playerid][pMechColor1] = 1168;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								PlayerData[playerid][pMechColor1] = 1141;
								PlayerData[playerid][pMechColor2] = 0;
							}
							
							Inventory_Remove(playerid, "Component", 100);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"100 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 100) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								PlayerData[playerid][pMechColor1] = 1148;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								PlayerData[playerid][pMechColor1] = 1151;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								PlayerData[playerid][pMechColor1] = 1161;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								PlayerData[playerid][pMechColor1] = 1156;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								PlayerData[playerid][pMechColor1] = 1167;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								PlayerData[playerid][pMechColor1] = 1140;
								PlayerData[playerid][pMechColor2] = 0;
							}
							
							Inventory_Remove(playerid, "Component", 100);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"100 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 100) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 534 ||
						VehicleModel == 567 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 535)
						{
							if(VehicleModel == 575)
							{
								PlayerData[playerid][pMechColor1] = 1176;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 534)
							{
								PlayerData[playerid][pMechColor1] = 1180;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 567)
							{
								PlayerData[playerid][pMechColor1] = 1187;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								PlayerData[playerid][pMechColor1] = 1184;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 576)
							{
								PlayerData[playerid][pMechColor1] = 1192;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 535)
							{
								PlayerData[playerid][pMechColor1] = 1109;
								PlayerData[playerid][pMechColor2] = 0;
							}
							
							Inventory_Remove(playerid, "Component", 100);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"100 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 100) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 534 ||
						VehicleModel == 567 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 535)
						{
							if(VehicleModel == 575)
							{
								PlayerData[playerid][pMechColor1] = 1177;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 534)
							{
								PlayerData[playerid][pMechColor1] = 1178;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 567)
							{
								PlayerData[playerid][pMechColor1] = 1186;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								PlayerData[playerid][pMechColor1] = 1183;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 576)
							{
								PlayerData[playerid][pMechColor1] = 1193;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 535)
							{
								PlayerData[playerid][pMechColor1] = 1110;
								PlayerData[playerid][pMechColor2] = 0;
							}
							
							Inventory_Remove(playerid, "Component", 100);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"100 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_ROOFS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								PlayerData[playerid][pMechColor1] = 1038;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								PlayerData[playerid][pMechColor1] = 1054;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								PlayerData[playerid][pMechColor1] = 1067;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								PlayerData[playerid][pMechColor1] = 1055;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								PlayerData[playerid][pMechColor1] = 1088;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								PlayerData[playerid][pMechColor1] = 1032;
								PlayerData[playerid][pMechColor2] = 0;
							}
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								PlayerData[playerid][pMechColor1] = 1038;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								PlayerData[playerid][pMechColor1] = 1053;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								PlayerData[playerid][pMechColor1] = 1068;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								PlayerData[playerid][pMechColor1] = 1061;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								PlayerData[playerid][pMechColor1] = 1091;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								PlayerData[playerid][pMechColor1] = 1033;
								PlayerData[playerid][pMechColor2] = 0;
							}
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 567 ||
						VehicleModel == 536)
						{
							if(VehicleModel == 567)
							{
								PlayerData[playerid][pMechColor1] = 1130;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								PlayerData[playerid][pMechColor1] = 1128;
								PlayerData[playerid][pMechColor2] = 0;
							}
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 567 ||
						VehicleModel == 536)
						{
							if(VehicleModel == 567)
							{
								PlayerData[playerid][pMechColor1] = 1131;
								PlayerData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								PlayerData[playerid][pMechColor1] = 1103;
								PlayerData[playerid][pMechColor2] = 0;
							}
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 4:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 70) return SendErrorMessage(playerid, "Component anda kurang!");
						if(
						VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 589 ||
						VehicleModel == 492 ||
						VehicleModel == 546 ||
						VehicleModel == 603 ||
						VehicleModel == 426 ||
						VehicleModel == 436 ||
						VehicleModel == 580 ||
						VehicleModel == 550 ||
						VehicleModel == 477)
						{

							PlayerData[playerid][pMechColor1] = 1006;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 70);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"70 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_SIDE_SKIRTS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 90) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								PlayerData[playerid][pMechColor1] = 1036;
								PlayerData[playerid][pMechColor2] = 1040;
							}
							if(VehicleModel == 565)
							{
								PlayerData[playerid][pMechColor1] = 1047;
								PlayerData[playerid][pMechColor2] = 1051;
							}
							if(VehicleModel == 559)
							{
								PlayerData[playerid][pMechColor1] = 1069;
								PlayerData[playerid][pMechColor2] = 1071;
							}
							if(VehicleModel == 561)
							{
								PlayerData[playerid][pMechColor1] = 1056;
								PlayerData[playerid][pMechColor2] = 1062;
							}
							if(VehicleModel == 558)
							{
								PlayerData[playerid][pMechColor1] = 1090;
								PlayerData[playerid][pMechColor2] = 1094;
							}
							if(VehicleModel == 560)
							{
								PlayerData[playerid][pMechColor1] = 1026;
								PlayerData[playerid][pMechColor2] = 1027;
							}
							
							Inventory_Remove(playerid, "Component", 90);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"90 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 90) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								PlayerData[playerid][pMechColor1] = 1039;
								PlayerData[playerid][pMechColor2] = 1041;
							}
							if(VehicleModel == 565)
							{
								PlayerData[playerid][pMechColor1] = 1048;
								PlayerData[playerid][pMechColor2] = 1052;
							}
							if(VehicleModel == 559)
							{
								PlayerData[playerid][pMechColor1] = 1070;
								PlayerData[playerid][pMechColor2] = 1072;
							}
							if(VehicleModel == 561)
							{
								PlayerData[playerid][pMechColor1] = 1057;
								PlayerData[playerid][pMechColor2] = 1063;
							}
							if(VehicleModel == 558)
							{
								PlayerData[playerid][pMechColor1] = 1093;
								PlayerData[playerid][pMechColor2] = 1095;
							}
							if(VehicleModel == 560)
							{
								PlayerData[playerid][pMechColor1] = 1031;
								PlayerData[playerid][pMechColor2] = 1030;
							}
							
							Inventory_Remove(playerid, "Component", 90);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"90 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 90) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 567)
						{
							if(VehicleModel == 575)
							{
								PlayerData[playerid][pMechColor1] = 1042;
								PlayerData[playerid][pMechColor2] = 1099;
							}
							if(VehicleModel == 536)
							{
								PlayerData[playerid][pMechColor1] = 1108;
								PlayerData[playerid][pMechColor2] = 1107;
							}
							if(VehicleModel == 576)
							{
								PlayerData[playerid][pMechColor1] = 1134;
								PlayerData[playerid][pMechColor2] = 1137;
							}
							if(VehicleModel == 567)
							{
								PlayerData[playerid][pMechColor1] = 1102;
								PlayerData[playerid][pMechColor2] = 1133;
							}
							
							Inventory_Remove(playerid, "Component", 90);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"90 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 90) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 534)
						{
				
							PlayerData[playerid][pMechColor1] = 1102;
							PlayerData[playerid][pMechColor2] = 1101;
							
							Inventory_Remove(playerid, "Component", 90);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"90 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 4:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 90) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 534)
						{
				
							PlayerData[playerid][pMechColor1] = 1106;
							PlayerData[playerid][pMechColor2] = 1124;
							
							Inventory_Remove(playerid, "Component", 90);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"90 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 5:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 90) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 535)
						{
				
							PlayerData[playerid][pMechColor1] = 1118;
							PlayerData[playerid][pMechColor2] = 1120;
							
							Inventory_Remove(playerid, "Component", 90);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"90 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 6:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 90) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 535)
						{
				
							PlayerData[playerid][pMechColor1] = 1119;
							PlayerData[playerid][pMechColor2] = 1121;
							
							Inventory_Remove(playerid, "Component", 90);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"90 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 7:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 90) return SendErrorMessage(playerid, "Component anda kurang!");
						if(
						VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 527 ||
						VehicleModel == 415 ||
						VehicleModel == 589 ||
						VehicleModel == 546 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 436 ||
						VehicleModel == 439 ||
						VehicleModel == 580 ||
						VehicleModel == 549 ||
						VehicleModel == 477)
						{
				
							PlayerData[playerid][pMechColor1] = 1007;
							PlayerData[playerid][pMechColor2] = 1017;
							
							Inventory_Remove(playerid, "Component", 90);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"90 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_BULLBARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 50) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 534)
						{
				
							PlayerData[playerid][pMechColor1] = 1100;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 50);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"50 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 50) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 534)
						{
				
							PlayerData[playerid][pMechColor1] = 1123;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 50);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"50 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 50) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 534)
						{
				
							PlayerData[playerid][pMechColor1] = 1125;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 50);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"50 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(PlayerData[playerid][pMechVeh]);
					
					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 50) return SendErrorMessage(playerid, "Component anda kurang!");
						if(VehicleModel == 534)
						{
				
							PlayerData[playerid][pMechColor1] = 1117;
							PlayerData[playerid][pMechColor2] = 0;
							
							Inventory_Remove(playerid, "Component", 50);
							SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"50 component.");
							PlayerData[playerid][pMechanic] = SetTimerEx("ModifCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Modif Car...");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						}
						else return SendErrorMessage(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_NEON)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					PlayerData[playerid][pMechColor1] = RED_NEON;

					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 450) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 450);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"450 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					PlayerData[playerid][pMechColor1] = BLUE_NEON;

					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 450) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 450);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"450 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					PlayerData[playerid][pMechColor1] = GREEN_NEON;

					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 450) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 450);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"450 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					PlayerData[playerid][pMechColor1] = YELLOW_NEON;

					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 450) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 450);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"450 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 4:
				{
					PlayerData[playerid][pMechColor1] = PINK_NEON;

					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 450) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 450);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"450 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 5:
				{
					PlayerData[playerid][pMechColor1] = WHITE_NEON;

					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 450) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 450);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"450 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 6:
				{
					PlayerData[playerid][pMechColor1] = 0;

					if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == PlayerData[playerid][pMechVeh])
					{
						if(Inventory_Has(playerid, "Component") < 450) return SendErrorMessage(playerid, "Component anda kurang!");
						Inventory_Remove(playerid, "Component", 450);
						SendInfoMessage(playerid, "Anda memodif kendaraan dengan "RED_E"450 component.");
						PlayerData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, PlayerData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Car...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
					}
					else
					{
						KillTimer(PlayerData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						PlayerData[playerid][pMechColor1] = 0;
						PlayerData[playerid][pMechColor2] = 0;
						PlayerData[playerid][pActivityTime] = 0;
						SendInfoMessage(playerid, "Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	
	if(dialogid == DIALOG_PLANT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(Inventory_Has(playerid, "Seed") < 5) return SendErrorMessage(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return SendErrorMessage(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return SendErrorMessage(playerid, "Cant plant any more plant!");
					
					if(PlayerData[playerid][pPlantTime] > 0) return SendErrorMessage(playerid, "You must wait 10 minutes for plant again!");
					
					if(IsPlayerInRangeOfPoint(playerid, 80.0, -237.43, -1357.56, 8.52) || IsPlayerInRangeOfPoint(playerid, 100.0, -475.43, -1343.56, 28.14)
					|| IsPlayerInRangeOfPoint(playerid, 50.0, -265.43, -1511.56, 5.49) || IsPlayerInRangeOfPoint(playerid, 30.0, -419.43, -1623.56, 18.87))
					{
					
						Inventory_Remove(playerid, "Seed", 5);
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						
						PlantData[id][PlantType] = 1;
						PlantData[id][PlantTime] = 1800;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						PlayerData[playerid][pPlant]++;
						SendInfoMessage(playerid, "Planting Potato.");
					}
					else return SendErrorMessage(playerid, "You must in farmer flint area!");
				}
				case 1:
				{
					if(Inventory_Has(playerid, "Seed") < 18) return SendErrorMessage(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return SendErrorMessage(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return SendErrorMessage(playerid, "Cant plant any more plant!");
					
					if(PlayerData[playerid][pPlantTime] > 0) return SendErrorMessage(playerid, "You must wait 10 minutes for plant again!");
					
					if(IsPlayerInRangeOfPoint(playerid, 80.0, -237.43, -1357.56, 8.52) || IsPlayerInRangeOfPoint(playerid, 100.0, -475.43, -1343.56, 28.14)
					|| IsPlayerInRangeOfPoint(playerid, 50.0, -265.43, -1511.56, 5.49) || IsPlayerInRangeOfPoint(playerid, 30.0, -419.43, -1623.56, 18.87))
					{
					
						Inventory_Remove(playerid, "Seed", 18);
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						
						PlantData[id][PlantType] = 2;
						PlantData[id][PlantTime] = 3600;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						PlayerData[playerid][pPlant]++;
						SendInfoMessage(playerid, "Planting Wheat.");
					}
					else return SendErrorMessage(playerid, "You must in farmer flint area!");
				}
				case 2:
				{
					if(Inventory_Has(playerid, "Seed") < 11) return SendErrorMessage(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return SendErrorMessage(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return SendErrorMessage(playerid, "Cant plant any more plant!");
					
					if(PlayerData[playerid][pPlantTime] > 0) return SendErrorMessage(playerid, "You must wait 10 minutes for plant again!");
					
					if(IsPlayerInRangeOfPoint(playerid, 80.0, -237.43, -1357.56, 8.52) || IsPlayerInRangeOfPoint(playerid, 100.0, -475.43, -1343.56, 28.14)
					|| IsPlayerInRangeOfPoint(playerid, 50.0, -265.43, -1511.56, 5.49) || IsPlayerInRangeOfPoint(playerid, 30.0, -419.43, -1623.56, 18.87))
					{
					
						Inventory_Remove(playerid, "Seed", 11);
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						
						PlantData[id][PlantType] = 3;
						PlantData[id][PlantTime] = 2700;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						PlayerData[playerid][pPlant]++;
						SendInfoMessage(playerid, "Planting Orange.");
					}
					else return SendErrorMessage(playerid, "You must in farmer flint area!");
				}
				case 3:
				{
					if(Inventory_Has(playerid, "Seed") < 50) return SendErrorMessage(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return SendErrorMessage(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return SendErrorMessage(playerid, "Cant plant any more plant!");
					
					if(PlayerData[playerid][pPlantTime] > 0) return SendErrorMessage(playerid, "You must wait 10 minutes for plant again!");
					
					if(IsPlayerInRangeOfPoint(playerid, 80.0, -237.43, -1357.56, 8.52) || IsPlayerInRangeOfPoint(playerid, 100.0, -475.43, -1343.56, 28.14)
					|| IsPlayerInRangeOfPoint(playerid, 50.0, -265.43, -1511.56, 5.49) || IsPlayerInRangeOfPoint(playerid, 30.0, -419.43, -1623.56, 18.87))
					{
						if(PlayerData[playerid][pFamily] == -1 || PlayerData[playerid][pAdmin] < 3)
							return SendErrorMessage(playerid, "Kamu bukan anggota family!");

						Inventory_Remove(playerid, "Seed", 50);
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						
						PlantData[id][PlantType] = 4;
						PlantData[id][PlantTime] = 4500;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						PlayerData[playerid][pPlant]++;
						SendInfoMessage(playerid, "Planting Marijuana.");
					}
					else return SendErrorMessage(playerid, "You must in farmer flint area!");
				}
			}
		}
	}
	if(dialogid == DIALOG_HAULING)
	{
		if(response)
		{
			new id = ReturnRestockGStationID((listitem + 1)), vehicleid = GetPlayerVehicleID(playerid);

			if(IsValidVehicle(PlayerData[playerid][pTrailer]))
			{
				DestroyVehicle(PlayerData[playerid][pTrailer]);
				PlayerData[playerid][pTrailer] = INVALID_VEHICLE_ID;
			}
			
			if(PlayerData[playerid][pHauling] > -1 || PlayerData[playerid][pMission] > -1)
				return SendErrorMessage(playerid, "Anda sudah sedang melakukan Mission/hauling!");
			
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Anda harus mengendarai truck.");
			if(!IsAHaulTruck(vehicleid)) return SendErrorMessage(playerid, "You're not in Hauling Truck ( Attachable Truck )");

			PlayerData[playerid][pHauling] = id;
			
			new line9[900];

			format(line9, sizeof(line9), "Silahkan anda mengambil trailer gas oil di gudang miner!\n\nGas Station ID: %d\nLocation: %s\n\nSetelah itu ikuti checkpoint dan antarkan ke Gas Station tujuan hauling anda!",
				id, GetLocation(gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]));
			SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, 329.82, 859.27, 21.40, 0, 0, 0, 5.5);
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Hauling Info", line9, "Close","");
		}
		return 1;
	}
	if(dialogid == DIALOG_RESTOCK)
	{
		if(response)
		{
			new id = ReturnRestockBisnisID((listitem + 1)), vehicleid = GetPlayerVehicleID(playerid);
			if(bData[id][bMoney] < 1000)
				return SendErrorMessage(playerid, "Maaf, Bisnis ini kehabisan uang product.");
			
			if(PlayerData[playerid][pMission] > -1 || PlayerData[playerid][pHauling] > -1)
				return SendErrorMessage(playerid, "Anda sudah sedang melakukan mission/hauling!");
			
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsATruck(vehicleid)) return SendErrorMessage(playerid, "Anda harus mengendarai truck.");
				
			PlayerData[playerid][pMission] = id;
			bData[id][bRestock] = 0;
			
			new line9[900];
			new type[128];
			if(bData[id][bType] == 1)
			{
				type = "Fast Food";

			}
			else if(bData[id][bType] == 2)
			{
				type = "Market";
			}
			else if(bData[id][bType] == 3)
			{
				type = "Clothes";
			}
			else if(bData[id][bType] == 4)
			{
				type = "Equipment";
			}
			else
			{
				type = "Unknow";
			}
			format(line9, sizeof(line9), "Silahkan anda membeli stock product di gudang!\n\nBisnis ID: %d\nBisnis Owner: %s\nBisnis Name: %s\nBisnis Type: %s\n\nSetelah itu ikuti checkpoint dan antarkan ke bisnis mission anda!",
			id, bData[id][bOwner], bData[id][bName], type);
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Mission Info", line9, "Close","");
		}
	}
	if(dialogid == DIALOG_PRODUCT)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			new value = amount * ProductPrice;
			new vehicleid = GetPlayerVehicleID(playerid), carid;
			new total = VehProduct[vehicleid] + amount;
			if(amount < 0 || amount > 150) return SendErrorMessage(playerid, "amount maximal 0 - 150.");
			if(GetPlayerMoney(playerid) < value) return SendErrorMessage(playerid, "Uang anda kurang.");
			if(Product < amount) return SendErrorMessage(playerid, "Product stock tidak mencukupi.");
			if(total > 150) return SendErrorMessage(playerid, "Product Maximal 150 in your vehicle tank!");
			GivePlayerMoneyEx(playerid, -value);
			VehProduct[vehicleid] += amount;
			if((carid = Vehicle_Nearest2(playerid)) != -1)
			{
				VehicleData[carid][cProduct] += amount;
			}
			
			Product -= amount;
			Server_AddMoney(value);
			SendInfoMessage(playerid, "Anda berhasil membeli "GREEN_E"%d "WHITE_E"product seharga "RED_E"%s.", amount, FormatMoney(value));
		}
	}
	if(dialogid == DIALOG_GASOIL)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			new value = amount * GasOilPrice;
			new vehicleid = GetPlayerVehicleID(playerid), carid;
			new total = VehGasOil[vehicleid] + amount;
			
			if(amount < 0 || amount > 1000) return SendErrorMessage(playerid, "amount maximal 0 - 1000.");
			if(GetPlayerMoney(playerid) < value) return SendErrorMessage(playerid, "Uang anda kurang.");
			if(GasOil < amount) return SendErrorMessage(playerid, "GasOil stock tidak mencukupi.");
			if(total > 1000) return SendErrorMessage(playerid, "Gas Oil Maximal 1000 liter in your vehicle tank!");
			GivePlayerMoneyEx(playerid, -value);
			VehGasOil[vehicleid] += amount;
			if((carid = Vehicle_Nearest2(playerid)) != -1)
			{
				VehicleData[carid][cGasOil] += amount;
			}
			
			GasOil -= amount;
			Server_AddMoney(value);
			SendInfoMessage(playerid, "Anda berhasil membeli "GREEN_E"%d "WHITE_E"liter gas oil seharga "RED_E"%s.", amount, FormatMoney(value));

			new hauling;
			if(VehGasOil[vehicleid] > 0 && (hauling = PlayerData[playerid][pHauling]) != -1)
			{
				SendCustomMessage(playerid, "HAULING", "Go to {ffff00}%s Gas Station{ffffff}!", GetLocation(gsData[hauling][gsPosX], gsData[hauling][gsPosY], gsData[hauling][gsPosZ]));
				SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, gsData[hauling][gsPosX], gsData[hauling][gsPosY], gsData[hauling][gsPosZ], 0, 0, 0, 5.5);
			}
		}
	}
	if(dialogid == DIALOG_MATERIAL)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			new value = amount * MaterialPrice;
			if(amount < 0 || amount > 500) return SendErrorMessage(playerid, "amount maximal 0 - 500.");
			if(GetPlayerMoney(playerid) < value) return SendErrorMessage(playerid, "Uang anda kurang.");
			if(Material < amount) return SendErrorMessage(playerid, "Material stock tidak mencukupi.");
			if(Inventory_Add(playerid, "Material", amount) == -1)
				return 1;

			GivePlayerMoneyEx(playerid, -value);
			Material -= amount;
			Server_AddMoney(value);
			SendInfoMessage(playerid, "Anda berhasil membeli "GREEN_E"%d "WHITE_E"material seharga "RED_E"%s.", amount, FormatMoney(value));
		}
	}
	if(dialogid == DIALOG_COMPONENT)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			new value = amount * ComponentPrice;
			if(amount < 0 || amount > 500) return SendErrorMessage(playerid, "amount maximal 0 - 500.");
			if(GetPlayerMoney(playerid) < value) return SendErrorMessage(playerid, "Uang anda kurang.");
			if(Component < amount) return SendErrorMessage(playerid, "Component stock tidak mencukupi.");
			if(Inventory_Add(playerid, "Component", amount) == -1)
				return 1;

			GivePlayerMoneyEx(playerid, -value);
			Component -= amount;
			Server_AddMoney(value);
			SendInfoMessage(playerid, "Anda berhasil membeli "GREEN_E"%d "WHITE_E"component seharga "RED_E"%s.", amount, FormatMoney(value));
		}
	}
	if(dialogid == DIALOG_DRUGS)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			new value = amount * MarijuanaPrice;
			if(amount < 0 || amount > 100) return SendErrorMessage(playerid, "amount maximal 0 - 100.");
			if(GetPlayerMoney(playerid) < value) return SendErrorMessage(playerid, "Uang anda kurang.");
			if(Marijuana < amount) return SendErrorMessage(playerid, "Marijuana stock tidak mencukupi.");
			if(Inventory_Add(playerid, "Marijuana", amount) == -1)
				return 1;

			GivePlayerMoneyEx(playerid, -value);
			Marijuana -= amount;
			Server_AddMoney(value);
			SendInfoMessage(playerid, "Anda berhasil membeli "GREEN_E"%d "WHITE_E"Marijuana seharga "RED_E"%s.", amount, FormatMoney(value));
		}
	}
	if(dialogid == DIALOG_FOOD)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					//buy food
					if(Inventory_Has(playerid, "Food") > 500) return SendErrorMessage(playerid, "Anda sudah membawa 500 Food!");
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah Food:\nFood Stock: "GREEN_E"%d\n"WHITE_E"Food Price"GREEN_E"%s /item", Food, FormatMoney(FoodPrice));
					ShowPlayerDialog(playerid, DIALOG_FOOD_BUY, DIALOG_STYLE_INPUT, "Buy Food", mstr, "Buy", "Cancel");
				}
				case 1:
				{
					//buy seed
					if(Inventory_Has(playerid, "Seed") > Inventory_MaxQuantity(playerid, -1, "Seed")) return SendErrorMessage(playerid, "Anda sudah membawa %d Seed!", Inventory_MaxQuantity(playerid, -1, "Seed"));
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah Seed:\nFood Stock: "GREEN_E"%d\n"WHITE_E"Seed Price"GREEN_E"%s /item", Food, FormatMoney(SeedPrice));
					ShowPlayerDialog(playerid, DIALOG_SEED_BUY, DIALOG_STYLE_INPUT, "Buy Seed", mstr, "Buy", "Cancel");
				}
			}
		}
	}
	if(dialogid == DIALOG_FOOD_BUY)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			new total = Inventory_Has(playerid, "Food") + amount;
			new value = amount * FoodPrice;
			if(amount < 0 || amount > 500) return SendErrorMessage(playerid, "amount maximal 0 - 500.");
			if(total > 500) return SendErrorMessage(playerid, "Food terlalu penuh di Inventory! Maximal 500.");
			if(GetPlayerMoney(playerid) < value) return SendErrorMessage(playerid, "Uang anda kurang.");
			if(Food < amount) return SendErrorMessage(playerid, "Food stock tidak mencukupi.");
			if(Inventory_Add(playerid, "Food", amount) == -1) return 1;
			GivePlayerMoneyEx(playerid, -value);
			Food -= amount;
			Server_AddMoney(value);
			SendInfoMessage(playerid, "Anda berhasil membeli "GREEN_E"%d "WHITE_E"Food seharga "RED_E"%s.", amount, FormatMoney(value));
		}
	}
	if(dialogid == DIALOG_SEED_BUY)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			new value = amount * SeedPrice;
			if(amount < 0 || amount > 100) return SendErrorMessage(playerid, "amount maximal 0 - 100.");
			if(GetPlayerMoney(playerid) < value) return SendErrorMessage(playerid, "Uang anda kurang.");
			if(Food < amount) return SendErrorMessage(playerid, "Food stock tidak mencukupi.");
			if(Inventory_Add(playerid, "Seed", amount) == -1)
				return 1;

			GivePlayerMoneyEx(playerid, -value);
			Food -= amount;
			Server_AddMoney(value);
			SendInfoMessage(playerid, "Anda berhasil membeli "GREEN_E"%d "WHITE_E"Seed seharga "RED_E"%s.", amount, FormatMoney(value));
		}
	}
	if(dialogid == DIALOG_EDIT_PRICE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Masukan harga Sprunk(1 - 500):\nPrice 1(Sprunk): "GREEN_E"%s", FormatMoney(PlayerData[playerid][pPrice1]));
					ShowPlayerDialog(playerid, DIALOG_EDIT_PRICE1, DIALOG_STYLE_INPUT, "Price 1", mstr, "Edit", "Cancel");
				}
				case 1:
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Masukan harga Snack(1 - 500):\nPrice 2(Snack): "GREEN_E"%s", FormatMoney(PlayerData[playerid][pPrice2]));
					ShowPlayerDialog(playerid, DIALOG_EDIT_PRICE2, DIALOG_STYLE_INPUT, "Price 2", mstr, "Edit", "Cancel");
				}
				case 2:
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Masukan harga Ice Cream Orange(1 - 500):\nPrice 3(Ice Cream Orange): "GREEN_E"%s", FormatMoney(PlayerData[playerid][pPrice3]));
					ShowPlayerDialog(playerid, DIALOG_EDIT_PRICE3, DIALOG_STYLE_INPUT, "Price 3", mstr, "Edit", "Cancel");
				}
				case 3:
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Masukan harga Hotdog(1 - 500):\nPrice 4(Hotdog): "GREEN_E"%s", FormatMoney(PlayerData[playerid][pPrice4]));
					ShowPlayerDialog(playerid, DIALOG_EDIT_PRICE4, DIALOG_STYLE_INPUT, "Price 4", mstr, "Edit", "Cancel");
				}
			}
		}
	}
	if(dialogid == DIALOG_EDIT_PRICE1)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			
			if(amount < 0 || amount > 500) return SendErrorMessage(playerid, "Invalid price! 1 - 500.");
			PlayerData[playerid][pPrice1] = amount;
			SendInfoMessage(playerid, "Anda berhasil mengedit price 1(Sprunk) ke "GREEN_E"%s.", FormatMoney(amount));
			return 1;
		}
	}
	if(dialogid == DIALOG_EDIT_PRICE2)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			
			if(amount < 0 || amount > 500) return SendErrorMessage(playerid, "Invalid price! 1 - 500.");
			PlayerData[playerid][pPrice2] = amount;
			SendInfoMessage(playerid, "Anda berhasil mengedit price 2(Snack) ke "GREEN_E"%s.", FormatMoney(amount));
			return 1;
		}
	}
	if(dialogid == DIALOG_EDIT_PRICE3)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			
			if(amount < 0 || amount > 500) return SendErrorMessage(playerid, "Invalid price! 1 - 500.");
			PlayerData[playerid][pPrice3] = amount;
			SendInfoMessage(playerid, "Anda berhasil mengedit price 3(Ice Cream Orange) ke "GREEN_E"%s.", FormatMoney(amount));
			return 1;
		}
	}
	if(dialogid == DIALOG_EDIT_PRICE4)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			
			if(amount < 0 || amount > 500) return SendErrorMessage(playerid, "Invalid price! 1 - 500.");
			PlayerData[playerid][pPrice4] = amount;
			SendInfoMessage(playerid, "Anda berhasil mengedit price 4(Hotdog) ke "GREEN_E"%s.", FormatMoney(amount));
			return 1;
		}
	}
	if(dialogid == DIALOG_OFFER)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new id = PlayerData[playerid][pOffer];
					if(!IsPlayerConnected(id) || !NearPlayer(playerid, id, 4.0))
						return SendErrorMessage(playerid, "You not near with offer player!");
					
					if(GetPlayerMoney(playerid) < PlayerData[id][pPrice1])
						return SendErrorMessage(playerid, "Not enough money!");
						
					if(Inventory_Has(id, "Food") < 5)
						return SendErrorMessage(playerid, "Food stock empty!");
					
					if(Inventory_Add(playerid, "Mineral Water") == -1)
						return 1;

					GivePlayerMoneyEx(id, PlayerData[id][pPrice1]);
					Inventory_Remove(id, "Food", 5);
					
					GivePlayerMoneyEx(playerid, -PlayerData[id][pPrice1]);
					
					SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s telah membeli mineral water seharga %s.", ReturnName(playerid), FormatMoney(PlayerData[id][pPrice1]));
				}
				case 1:
				{
					new id = PlayerData[playerid][pOffer];
					if(!IsPlayerConnected(id) || !NearPlayer(playerid, id, 4.0))
						return SendErrorMessage(playerid, "You not near with offer player!");
					
					if(GetPlayerMoney(playerid) < PlayerData[id][pPrice2])
						return SendErrorMessage(playerid, "Not enough money!");
					
					if(Inventory_Has(id, "Food") < 5)
						return SendErrorMessage(playerid, "Food stock empty!");

					if(Inventory_Add(playerid, "Snack") == -1)
						return 1;

					GivePlayerMoneyEx(id, PlayerData[id][pPrice2]);
					Inventory_Remove(id, "Food", 5);
					
					GivePlayerMoneyEx(playerid, -PlayerData[id][pPrice2]);
					
					SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s telah membeli snack seharga %s.", ReturnName(playerid), FormatMoney(PlayerData[id][pPrice2]));	
				}
				case 2:
				{
					new id = PlayerData[playerid][pOffer];
					if(!IsPlayerConnected(id) || !NearPlayer(playerid, id, 4.0))
						return SendErrorMessage(playerid, "You not near with offer player!");
					
					if(GetPlayerMoney(playerid) < PlayerData[id][pPrice3])
						return SendErrorMessage(playerid, "Not enough money!");
					
					if(Inventory_Has(id, "Food") < 10)
						return SendErrorMessage(playerid, "Food stock empty!");
						
					GivePlayerMoneyEx(id, PlayerData[id][pPrice3]);
					Inventory_Remove(id, "Food", 10);
					
					GivePlayerMoneyEx(playerid, -PlayerData[id][pPrice3]);
					PlayerData[playerid][pEnergy] += 30;
					
					SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s telah membeli ice cream orange seharga %s.", ReturnName(playerid), FormatMoney(PlayerData[id][pPrice3]));
				}
				case 3:
				{
					new id = PlayerData[playerid][pOffer];
					if(!IsPlayerConnected(id) || !NearPlayer(playerid, id, 4.0))
						return SendErrorMessage(playerid, "You not near with offer player!");
					
					if(GetPlayerMoney(playerid) < PlayerData[id][pPrice4])
						return SendErrorMessage(playerid, "Not enough money!");
						
					if(Inventory_Has(id, "Food") < 10)
						return SendErrorMessage(playerid, "Food stock empty!");
					
					GivePlayerMoneyEx(id, PlayerData[id][pPrice4]);
					Inventory_Remove(id, "Food", 10);
					
					GivePlayerMoneyEx(playerid, -PlayerData[id][pPrice4]);
					PlayerData[playerid][pHunger] += 30;
					
					SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s telah membeli hotdog seharga %s.", ReturnName(playerid), FormatMoney(PlayerData[id][pPrice4]));
				}
			}
		}
		PlayerData[playerid][pOffer] = -1;
	}
	if(dialogid == DIALOG_APOTEK)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(Apotek < 1) return SendErrorMessage(playerid, "Product out of stock!");
					if(GetPlayerMoney(playerid) < MedicinePrice) return SendErrorMessage(playerid, "Not enough money.");
					if(Inventory_Add(playerid, "Medicine") == -1)
						return 1;

					Apotek--;
					GivePlayerMoneyEx(playerid, -MedicinePrice);
					Server_AddMoney(MedicinePrice);
					SendInfoMessage(playerid, "Anda membeli medicine seharga "RED_E"%s,"WHITE_E" /use untuk menggunakannya.", FormatMoney(MedicinePrice));
				}
				case 1:
				{
					if(Apotek < 1) return SendErrorMessage(playerid, "Product out of stock!");
					if(PlayerData[playerid][pFaction] != 3) return SendErrorMessage(playerid, "You are not a medical member.");
					if(GetPlayerMoney(playerid) < MedkitPrice) return SendErrorMessage(playerid, "Not enough money.");
					if(Inventory_Add(playerid, "Medkit") == -1)
						return 1;

					Apotek--;
					GivePlayerMoneyEx(playerid, -MedkitPrice);
					Server_AddMoney(MedkitPrice);
					SendInfoMessage(playerid, "Anda membeli medkit seharga "RED_E"%s", FormatMoney(MedkitPrice));
				}
				case 2:
				{
					if(Apotek < 1) return SendErrorMessage(playerid, "Product out of stock!");
					if(PlayerData[playerid][pFaction] != 3) return SendErrorMessage(playerid, "You are not a medical member.");
					if(GetPlayerMoney(playerid) < 100) return SendErrorMessage(playerid, "Not enough money.");
					if(Inventory_Add(playerid, "First Aid") == -1)
						return 1;

					Apotek--;
					GivePlayerMoneyEx(playerid, -100);
					Server_AddMoney(100);
					SendInfoMessage(playerid, "Anda membeli first aid seharga "RED_E"$100");
				}
			}
		}
	}
	if(dialogid == DIALOG_ATM)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0: // Check Balance
			{
				new mstr[512];
				format(mstr, sizeof(mstr), "{F6F6F6}You have "LB_E"%s {F6F6F6}in your bank account.", FormatMoney(PlayerData[playerid][pBankMoney]));
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""LB_E"Bank", mstr, "Close", "");
			}
			case 1: // Withdraw
			{
				new mstr[128];
				format(mstr, sizeof(mstr), ""WHITE_E"My Balance: "LB_E"%s", FormatMoney(PlayerData[playerid][pBankMoney]));
				ShowPlayerDialog(playerid, DIALOG_ATMWITHDRAW, DIALOG_STYLE_LIST, mstr, "$50\n$200\n$500\n$1.000\n$5.000", "Withdraw", "Cancel");
			}
			case 2: // Transfer Money
			{
				ShowPlayerDialog(playerid, DIALOG_BANKREKENING, DIALOG_STYLE_INPUT, ""LB_E"Bank", "Masukan jumlah uang:", "Transfer", "Cancel");
			}
			case 3: //Paycheck
			{
				DisplayPaycheck(playerid);
			}
		}
	}
	if(dialogid == DIALOG_ATMWITHDRAW)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(PlayerData[playerid][pBankMoney] < 50)
						return SendErrorMessage(playerid, "Not enough balance!");
					
					GivePlayerMoneyEx(playerid, 50);
					PlayerData[playerid][pBankMoney] -= 50;
					SendInfoMessage(playerid, "ATM withdraw "LG_E"$50");
				}
				case 1:
				{
					if(PlayerData[playerid][pBankMoney] < 200)
						return SendErrorMessage(playerid, "Not enough balance!");
					
					GivePlayerMoneyEx(playerid, 200);
					PlayerData[playerid][pBankMoney] -= 200;
					SendInfoMessage(playerid, "ATM withdraw "LG_E"$200");
				}
				case 2:
				{
					if(PlayerData[playerid][pBankMoney] < 500)
						return SendErrorMessage(playerid, "Not enough balance!");
					
					GivePlayerMoneyEx(playerid, 500);
					PlayerData[playerid][pBankMoney] -= 500;
					SendInfoMessage(playerid, "ATM withdraw "LG_E"$500");
				}
				case 3:
				{
					if(PlayerData[playerid][pBankMoney] < 1000)
						return SendErrorMessage(playerid, "Not enough balance!");
					
					GivePlayerMoneyEx(playerid, 1000);
					PlayerData[playerid][pBankMoney] -= 1000;
					SendInfoMessage(playerid, "ATM withdraw "LG_E"$1.000");
				}
				case 4:
				{
					if(PlayerData[playerid][pBankMoney] < 5000)
						return SendErrorMessage(playerid, "Not enough balance!");
					
					GivePlayerMoneyEx(playerid, 5000);
					PlayerData[playerid][pBankMoney] -= 5000;
					SendInfoMessage(playerid, "ATM withdraw "LG_E"$5.000");
				}
			}
		}
	}
	if(dialogid == DIALOG_BANK)
	{
		if(!response) return true;
		switch(listitem)
		{
			case 0: // Deposit
			{
				new mstr[512];
				format(mstr, sizeof(mstr), "{F6F6F6}You have "LB_E"%s {F6F6F6}in bank account.\n\nType in the amount you want to deposit below:", FormatMoney(PlayerData[playerid][pBankMoney]));
				ShowPlayerDialog(playerid, DIALOG_BANKDEPOSIT, DIALOG_STYLE_INPUT, ""LB_E"Bank", mstr, "Deposit", "Cancel");
			}
			case 1: // Withdraw
			{
				new mstr[512];
				format(mstr, sizeof(mstr), "{F6F6F6}You have "LB_E"%s {F6F6F6}in your bank account.\n\nType in the amount you want to withdraw below:", FormatMoney(PlayerData[playerid][pBankMoney]));
				ShowPlayerDialog(playerid, DIALOG_BANKWITHDRAW, DIALOG_STYLE_INPUT, ""LB_E"Bank", mstr, "Withdraw", "Cancel");
			}
			case 2: // Check Balance
			{
				new mstr[512];
				format(mstr, sizeof(mstr), "{F6F6F6}You have "LB_E"%s {F6F6F6}in your bank account.", FormatMoney(PlayerData[playerid][pBankMoney]));
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""LB_E"Bank", mstr, "Close", "");
			}
			case 3: //Transfer Money
			{
				ShowPlayerDialog(playerid, DIALOG_BANKREKENING, DIALOG_STYLE_INPUT, ""LB_E"Bank", "Masukan jumlah uang:", "Transfer", "Cancel");
			}
			case 4:
			{
				DisplayPaycheck(playerid);
			}
		}
	}
	if(dialogid == DIALOG_BANKDEPOSIT)
	{
		if(!response) return true;
		new amount = floatround(strval(inputtext));
		if(amount > PlayerData[playerid][pMoney]) return SendErrorMessage(playerid, "You do not have the sufficient funds to make this transaction.");
		if(amount < 1) return SendErrorMessage(playerid, "You have entered an invalid amount!");

		else
		{
			new query[512], lstr[512];
			PlayerData[playerid][pBankMoney] = (PlayerData[playerid][pBankMoney] + amount);
			GivePlayerMoneyEx(playerid, -amount);
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET bmoney=%d,money=%d WHERE reg_id=%d", PlayerData[playerid][pBankMoney], PlayerData[playerid][pMoney], PlayerData[playerid][pID]);
			mysql_tquery(g_SQL, query);
			format(lstr, sizeof(lstr), "{F6F6F6}You have successfully deposited "LB_E"%s {F6F6F6}into your bank account.\n"LB_E"Current Balance: {F6F6F6}%s", FormatMoney(amount), FormatMoney(PlayerData[playerid][pBankMoney]));
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Bank", lstr, "Close", "");
		}
	}
	if(dialogid == DIALOG_BANKWITHDRAW)
	{
		if(!response) return true;
		new amount = floatround(strval(inputtext));
		if(amount > PlayerData[playerid][pBankMoney]) return SendErrorMessage(playerid, "You do not have the sufficient funds to make this transaction.");
		if(amount < 1) return SendErrorMessage(playerid, "You have entered an invalid amount!");
		else
		{
			new query[128], lstr[512];
			PlayerData[playerid][pBankMoney] = (PlayerData[playerid][pBankMoney] - amount);
			GivePlayerMoneyEx(playerid, amount);
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET bmoney=%d,money=%d WHERE reg_id=%d", PlayerData[playerid][pBankMoney], PlayerData[playerid][pMoney], PlayerData[playerid][pID]);
			mysql_tquery(g_SQL, query);
			format(lstr, sizeof(lstr), "{F6F6F6}You have successfully withdrawed "LB_E"%s {F6F6F6}from your bank account.\n"LB_E"Current Balance: {F6F6F6}%s", FormatMoney(amount), FormatMoney(PlayerData[playerid][pBankMoney]));
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Bank", lstr, "Close", "");
		}
	}
	if(dialogid == DIALOG_BANKREKENING)
	{
		if(!response) return true;
		new amount = floatround(strval(inputtext));
		if(amount > PlayerData[playerid][pBankMoney]) return SendErrorMessage(playerid, "Uang dalam rekening anda kurang.");
		if(amount < 1) return SendErrorMessage(playerid, "You have entered an invalid amount!");

		else
		{
			PlayerData[playerid][pTransfer] = amount;
			ShowPlayerDialog(playerid, DIALOG_BANKTRANSFER, DIALOG_STYLE_INPUT, ""LB_E"Bank", "Masukan nomor rekening target:", "Transfer", "Cancel");
		}
	}
	if(dialogid == DIALOG_BANKTRANSFER)
	{
		if(!response) return true;
		new rek = floatround(strval(inputtext)), query[128];
		
		mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
		mysql_tquery(g_SQL, query, "SearchRek", "id", playerid, rek);
		return 1;
	}
	if(dialogid == DIALOG_BANKCONFIRM)
	{
		if(response)
		{
			new query[128], mstr[248];
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET bmoney=bmoney+%d WHERE brek=%d", PlayerData[playerid][pTransfer], PlayerData[playerid][pTransferRek]);
			mysql_tquery(g_SQL, query);
			
			foreach(new ii : Player)
			{
				if(PlayerData[ii][pBankRek] == PlayerData[playerid][pTransferRek])
				{
					PlayerData[ii][pBankMoney] += PlayerData[playerid][pTransfer];
				}
			}
			
			PlayerData[playerid][pBankMoney] -= PlayerData[playerid][pTransfer];
			
			format(mstr, sizeof(mstr), ""WHITE_E"No Rek Target: "YELLOW_E"%d\n"WHITE_E"Nama Target: "YELLOW_E"%s\n"WHITE_E"Jumlah: "GREEN_E"%s\n\n"WHITE_E"Anda telah berhasil mentransfer!", PlayerData[playerid][pTransferRek], PlayerData[playerid][pTransferName], FormatMoney(PlayerData[playerid][pTransfer]));
			ShowPlayerDialog(playerid, DIALOG_BANKSUKSES, DIALOG_STYLE_MSGBOX, ""LB_E"Transfer Sukses", mstr, "Sukses", "");
		}
	}
	if(dialogid == DIALOG_BANKSUKSES)
	{
		if(response)
		{
			PlayerData[playerid][pTransfer] = 0;
			PlayerData[playerid][pTransferRek] = 0;
		}
	}
	if(dialogid == DIALOG_ASKS)
	{
		if(response) 
		{
			//new i = strval(inputtext);
			new i = listitem;
			new tstr[64], mstr[128], lstr[512];

			strunpack(mstr, AskData[i][askText]);
			format(tstr, sizeof(tstr), ""GREEN_E"Ask Id: #%d", i);
			format(lstr,sizeof(lstr),""WHITE_E"Asked: "GREEN_E"%s\n"WHITE_E"Question: "RED_E"%s.", PlayerData[AskData[i][askPlayer]][pName], mstr);
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX,tstr,lstr,"Close","");
		}
	}
	if(dialogid == DIALOG_REPORTS)
	{
		if(response) 
		{
			//new i = strval(inputtext);
			new i = listitem;
			new tstr[64], mstr[128], lstr[512];

			strunpack(mstr, ReportData[i][rText]);
			format(tstr, sizeof(tstr), ""GREEN_E"Report Id: #%d", i);
			format(lstr,sizeof(lstr),""WHITE_E"Reported: "GREEN_E"%s\n"WHITE_E"Reason: "RED_E"%s.", PlayerData[ReportData[i][rPlayer]][pName], mstr);
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX,tstr,lstr,"Close","");
		}
	}
	if(dialogid == DIALOG_BUYPV)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(response)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				TogglePlayerControllable(playerid, true);
				SendErrorMessage(playerid,"Anda harus berada di dalam kendaraan untuk membelinya.");
				return 1;
			}
			new cost = GetVehicleCost(GetVehicleModel(vehicleid));
			if(PlayerData[playerid][pMoney] < cost)
			{
				SendErrorMessage(playerid, "Uang anda tidak mencukupi.!");
				RemovePlayerFromVehicle(playerid);
				//new Float:slx, Float:sly, Float:slz;
				//GetPlayerPos(playerid, slx, sly, slz);
				//SetPlayerPos(playerid, slx, sly+1.2, slz+1.3);
				//TogglePlayerControllable(playerid, true);
				//SetVehicleToRespawn(vehicleid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
				return 1;
			}
			//if(playerid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Invalid player ID!");
			new count = 0, limit = MAX_PLAYER_VEHICLE + PlayerData[playerid][pVip];
			foreach(new ii : PlayerVehicles)
			{
				if(VehicleData[ii][cOwner] == PlayerData[playerid][pID])
					count++;
			}
			if(count >= limit)
			{
				SendErrorMessage(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				RemovePlayerFromVehicle(playerid);
				//new Float:slx, Float:sly, Float:slz;
				//GetPlayerPos(playerid, slx, sly, slz);
				//SetPlayerPos(playerid, slx, sly, slz+1.3);
				//TogglePlayerControllable(playerid, true);
				//SetVehicleToRespawn(vehicleid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
				return 1;
			}
			GivePlayerMoneyEx(playerid, -cost);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			color1 = 0;
			color2 = 0;
			model = GetVehicleModel(GetPlayerVehicleID(playerid));
			x = 1805.93;
			y = -1791.19;
			z = 13.54;
			a = 2.22;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", PlayerData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "OnVehBuyPV", "ddddddffff", playerid, PlayerData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			/*new cQuery[1024], model = GetVehicleModel(GetPlayerVehicleID(playerid)), color1 = 0, color2 = 0,
			Float:x = 1805.13, Float:y = -1708.09, Float:z = 13.54, Float:a = 179.23, price = GetVehicleCost(GetVehicleModel(GetPlayerVehicleID(playerid)));
			format(cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, '%f', '%f', '%f', '%f')", PlayerData[playerid][pID], model, color1, color2, price, x, y, z, a);
			MySQL_query(cQuery, false, "OnVehBuyed", "ddddddffff", playerid, PlayerData[playerid][pID], model, color1, color2, price, x, y, z, a);
			SendServerMessage(playerid, "harusnya bisaa");*/
			return 1;
		}
		else
		{
			RemovePlayerFromVehicle(playerid);
			//new Float:slx, Float:sly, Float:slz;
			//GetPlayerPos(playerid, slx, sly, slz);
			//SetPlayerPos(playerid, slx, sly, slz+1.3);
			//TogglePlayerControllable(playerid, true);
			//SetVehicleToRespawn(vehicleid);
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			return 1;
		}
	}
	if(dialogid == DIALOG_BUYVIPPV)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(response)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				TogglePlayerControllable(playerid, true);
				SendErrorMessage(playerid,"Anda harus berada di dalam kendaraan untuk membelinya.");
				return 1;
			}
			new gold = GetVipVehicleCost(GetVehicleModel(vehicleid));
			new cost = GetVehicleCost(GetVehicleModel(vehicleid));
			if(PlayerData[playerid][pGold] < gold)
			{
				SendErrorMessage(playerid, "gold anda tidak mencukupi!");
				RemovePlayerFromVehicle(playerid);
				//new Float:slx, Float:sly, Float:slz;
				//GetPlayerPos(playerid, slx, sly, slz);
				//SetPlayerPos(playerid, slx, sly, slz+1.3);
				//TogglePlayerControllable(playerid, true);
				//SetVehicleToRespawn(vehicleid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
				return 1;
			}
			//if(playerid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Invalid player ID!");
			new count = 0, limit = MAX_PLAYER_VEHICLE + PlayerData[playerid][pVip];
			foreach(new ii : PlayerVehicles)
			{
				if(VehicleData[ii][cOwner] == PlayerData[playerid][pID])
					count++;
			}
			if(count >= limit)
			{
				SendErrorMessage(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				RemovePlayerFromVehicle(playerid);
				//new Float:slx, Float:sly, Float:slz;
				//GetPlayerPos(playerid, slx, sly, slz);
				//SetPlayerPos(playerid, slx, sly, slz+1.3);
				//TogglePlayerControllable(playerid, true);
				//SetVehicleToRespawn(vehicleid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
				return 1;
			}
			PlayerData[playerid][pGold] -= gold;
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			color1 = 0;
			color2 = 0;
			model = GetVehicleModel(GetPlayerVehicleID(playerid));
			x = 1805.93;
			y = -1791.19;
			z = 13.54;
			a = 2.22;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", PlayerData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "OnVehBuyVIPPV", "ddddddffff", playerid, PlayerData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			/*new cQuery[1024], model = GetVehicleModel(GetPlayerVehicleID(playerid)), color1 = 0, color2 = 0,
			Float:x = 1805.13, Float:y = -1708.09, Float:z = 13.54, Float:a = 179.23, price = GetVehicleCost(GetVehicleModel(GetPlayerVehicleID(playerid)));
			format(cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, '%f', '%f', '%f', '%f')", PlayerData[playerid][pID], model, color1, color2, price, x, y, z, a);
			MySQL_query(cQuery, false, "OnVehBuyed", "ddddddffff", playerid, PlayerData[playerid][pID], model, color1, color2, price, x, y, z, a);
			SendServerMessage(playerid, "harusnya bisaa");*/
			return 1;
		}
		else
		{
			RemovePlayerFromVehicle(playerid);
			//new Float:slx, Float:sly, Float:slz;
			//GetPlayerPos(playerid, slx, sly, slz);
			//SetPlayerPos(playerid, slx, sly, slz+1.3);
			//TogglePlayerControllable(playerid, true);
			//SetVehicleToRespawn(vehicleid);
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			return 1;
		}
	}
	if(dialogid == DIALOG_BUYPVCP)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					//Bikes
					new str[1024];
					/*format(str, sizeof(str), "%s"WHITE_E"%s\t"LG_E"%s\n", str, GetVehicleModelName(481), FormatMoney(GetVehicleCost(481)));
					format(str, sizeof(str), "%s"WHITE_E"%s\t"LG_E"%s\n", str, GetVehicleModelName(509), FormatMoney(GetVehicleCost(509)));
					format(str, sizeof(str), "%s"WHITE_E"%s\t"LG_E"%s\n", str, GetVehicleModelName(510), FormatMoney(GetVehicleCost(510)));
					format(str, sizeof(str), "%s"WHITE_E"%s\t"LG_E"%s\n", str, GetVehicleModelName(462), FormatMoney(GetVehicleCost(462)));
					format(str, sizeof(str), "%s"WHITE_E"%s\t"LG_E"%s\n", str, GetVehicleModelName(586), FormatMoney(GetVehicleCost(586)));
					format(str, sizeof(str), "%s"WHITE_E"%s\t"LG_E"%s\n", str, GetVehicleModelName(581), FormatMoney(GetVehicleCost(581)));
					format(str, sizeof(str), "%s"WHITE_E"%s\t"LG_E"%s\n", str, GetVehicleModelName(461), FormatMoney(GetVehicleCost(461)));
					format(str, sizeof(str), "%s"WHITE_E"%s\t"LG_E"%s\n", str, GetVehicleModelName(521), FormatMoney(GetVehicleCost(521)));
					format(str, sizeof(str), "%s"WHITE_E"%s\t"LG_E"%s\n", str, GetVehicleModelName(463), FormatMoney(GetVehicleCost(463)));
					format(str, sizeof(str), "%s"WHITE_E"%s\t"LG_E"%s\n", str, GetVehicleModelName(468), FormatMoney(GetVehicleCost(468)));*/
					
					format(str, sizeof(str), "Kendaraan\tHarga\n"WHITE_E"%s\t\t"LG_E"%s\n%s\t\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n", 
					GetVehicleModelName(481), FormatMoney(GetVehicleCost(481)), 
					GetVehicleModelName(509), FormatMoney(GetVehicleCost(509)),
					GetVehicleModelName(510), FormatMoney(GetVehicleCost(510)),
					GetVehicleModelName(462), FormatMoney(GetVehicleCost(462)),
					GetVehicleModelName(586), FormatMoney(GetVehicleCost(586)),
					GetVehicleModelName(581), FormatMoney(GetVehicleCost(581)),
					GetVehicleModelName(461), FormatMoney(GetVehicleCost(461)),
					GetVehicleModelName(521), FormatMoney(GetVehicleCost(521)),
					GetVehicleModelName(463), FormatMoney(GetVehicleCost(463)),
					GetVehicleModelName(468), FormatMoney(GetVehicleCost(468))
					);
					
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_BIKES, DIALOG_STYLE_TABLIST_HEADERS, "{7fff00}Motorcycle", str, "Buy", "Close");
				}
				case 1:
				{
					//Cars
					new str[1024];
					format(str, sizeof(str), "Kendaraan\tHarga\n"WHITE_E"%s\t\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n", 
					GetVehicleModelName(400), FormatMoney(GetVehicleCost(400)), 
					GetVehicleModelName(412), FormatMoney(GetVehicleCost(412)),
					GetVehicleModelName(419), FormatMoney(GetVehicleCost(419)),
					GetVehicleModelName(426), FormatMoney(GetVehicleCost(426)),
					GetVehicleModelName(436), FormatMoney(GetVehicleCost(436)),
					GetVehicleModelName(466), FormatMoney(GetVehicleCost(466)),
					GetVehicleModelName(467), FormatMoney(GetVehicleCost(467)),
					GetVehicleModelName(474), FormatMoney(GetVehicleCost(474)),
					GetVehicleModelName(475), FormatMoney(GetVehicleCost(475)),
					GetVehicleModelName(480), FormatMoney(GetVehicleCost(480)),
					GetVehicleModelName(603), FormatMoney(GetVehicleCost(603)),
					GetVehicleModelName(421), FormatMoney(GetVehicleCost(421)),
					GetVehicleModelName(602), FormatMoney(GetVehicleCost(602)),
					GetVehicleModelName(492), FormatMoney(GetVehicleCost(492)),
					GetVehicleModelName(545), FormatMoney(GetVehicleCost(545)),
					GetVehicleModelName(489), FormatMoney(GetVehicleCost(489)),
					GetVehicleModelName(405), FormatMoney(GetVehicleCost(405)),
					GetVehicleModelName(445), FormatMoney(GetVehicleCost(445)),
					GetVehicleModelName(579), FormatMoney(GetVehicleCost(579)),
					GetVehicleModelName(507), FormatMoney(GetVehicleCost(507))
					);
					
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CARS, DIALOG_STYLE_TABLIST_HEADERS, "{7fff00}Mobil", str, "Buy", "Close");
				}
				case 2:
				{
					//Unique Cars
					new str[1024];
					format(str, sizeof(str), "Kendaraan\tHarga\n"WHITE_E"%s\t\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n", 
					GetVehicleModelName(483), FormatMoney(GetVehicleCost(483)), 
					GetVehicleModelName(534), FormatMoney(GetVehicleCost(534)),
					GetVehicleModelName(535), FormatMoney(GetVehicleCost(535)),
					GetVehicleModelName(536), FormatMoney(GetVehicleCost(536)),
					GetVehicleModelName(558), FormatMoney(GetVehicleCost(558)),
					GetVehicleModelName(559), FormatMoney(GetVehicleCost(559)),
					GetVehicleModelName(560), FormatMoney(GetVehicleCost(560)),
					GetVehicleModelName(561), FormatMoney(GetVehicleCost(561)),
					GetVehicleModelName(562), FormatMoney(GetVehicleCost(562)),
					GetVehicleModelName(565), FormatMoney(GetVehicleCost(565)),
					GetVehicleModelName(567), FormatMoney(GetVehicleCost(567)),
					GetVehicleModelName(575), FormatMoney(GetVehicleCost(575)),
					GetVehicleModelName(576), FormatMoney(GetVehicleCost(576))
					);
					
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_UCARS, DIALOG_STYLE_TABLIST_HEADERS, "{7fff00}Kendaraan Unik", str, "Buy", "Close");
				}
				case 3:
				{
					//Job Cars
					new str[1024];
					format(str, sizeof(str), "Kendaraan\tHarga\n"WHITE_E"%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s", 
					GetVehicleModelName(420), FormatMoney(GetVehicleCost(420)), 
					GetVehicleModelName(438), FormatMoney(GetVehicleCost(438)), 
					GetVehicleModelName(403), FormatMoney(GetVehicleCost(403)), 
					GetVehicleModelName(413), FormatMoney(GetVehicleCost(413)),
					GetVehicleModelName(414), FormatMoney(GetVehicleCost(414)),
					GetVehicleModelName(422), FormatMoney(GetVehicleCost(422)),
					GetVehicleModelName(440), FormatMoney(GetVehicleCost(440)),
					GetVehicleModelName(455), FormatMoney(GetVehicleCost(455)),
					GetVehicleModelName(456), FormatMoney(GetVehicleCost(456)),
					GetVehicleModelName(478), FormatMoney(GetVehicleCost(478)),
					GetVehicleModelName(482), FormatMoney(GetVehicleCost(482)),
					GetVehicleModelName(498), FormatMoney(GetVehicleCost(498)),
					GetVehicleModelName(499), FormatMoney(GetVehicleCost(499)),
					GetVehicleModelName(423), FormatMoney(GetVehicleCost(423)),
					GetVehicleModelName(588), FormatMoney(GetVehicleCost(588)),
					GetVehicleModelName(524), FormatMoney(GetVehicleCost(524)),
					GetVehicleModelName(525), FormatMoney(GetVehicleCost(525)),
					GetVehicleModelName(543), FormatMoney(GetVehicleCost(543)),
					GetVehicleModelName(552), FormatMoney(GetVehicleCost(552)),
					GetVehicleModelName(554), FormatMoney(GetVehicleCost(554)),
					GetVehicleModelName(578), FormatMoney(GetVehicleCost(578)),
					GetVehicleModelName(609), FormatMoney(GetVehicleCost(609))
					//GetVehicleModelName(530), FormatMoney(GetVehicleCost(530)) //fortklift
					);
					
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_JOBCARS, DIALOG_STYLE_TABLIST_HEADERS, "{7fff00}Kendaraan Job", str, "Buy", "Close");
				}
				case 4:
				{
					// VIP Cars
					new str[1024];
					format(str, sizeof(str), "Kendaraan\tHarga\n"WHITE_E"%s\t\t"YELLOW_E"%d gold\n%s\t"YELLOW_E"%d gold\n%s\t"YELLOW_E"%d gold\n%s\t"YELLOW_E"%d gold\n%s\t"YELLOW_E"%d gold\n%s\t"YELLOW_E"%d gold\n%s\t"YELLOW_E"%d gold\n%s\t"YELLOW_E"%d gold\n%s\t"YELLOW_E"%d gold\n%s\t"YELLOW_E"%d gold\n%s\t"YELLOW_E"%d gold\n%s\t"YELLOW_E"%d gold\n%s\t"YELLOW_E"%d gold\n", 
					GetVehicleModelName(522), GetVipVehicleCost(522), 
					GetVehicleModelName(411), GetVipVehicleCost(411), 
					GetVehicleModelName(451), GetVipVehicleCost(451),
					GetVehicleModelName(415), GetVipVehicleCost(415), 
					GetVehicleModelName(402), GetVipVehicleCost(402), 
					GetVehicleModelName(541), GetVipVehicleCost(541), 
					GetVehicleModelName(429), GetVipVehicleCost(429), 
					GetVehicleModelName(506), GetVipVehicleCost(506), 
					GetVehicleModelName(494), GetVipVehicleCost(494), 
					GetVehicleModelName(502), GetVipVehicleCost(502), 
					GetVehicleModelName(503), GetVipVehicleCost(503), 
					GetVehicleModelName(409), GetVipVehicleCost(409), 
					GetVehicleModelName(477), GetVipVehicleCost(477)
					);
					
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCARS, DIALOG_STYLE_TABLIST_HEADERS, "{7fff00}Kendaraan VIP", str, "Buy", "Close");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYPVCP_BIKES)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 481;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 509;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 510;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 462;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 586;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 581;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 461;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 521;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 463;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 468;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYPVCP_CARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 400;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 412;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 419;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 426;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 436;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 466;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 467;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 474;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 475;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 480;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 10:
				{
					new modelid = 603;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 11:
				{
					new modelid = 421;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 12:
				{
					new modelid = 602;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 13:
				{
					new modelid = 492;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 14:
				{
					new modelid = 545;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 15:
				{
					new modelid = 489;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 16:
				{
					new modelid = 405;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 17:
				{
					new modelid = 445;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 18:
				{
					new modelid = 579;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 19:
				{
					new modelid = 507;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYPVCP_UCARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 483;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 534;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 535;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 536;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 558;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 559;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 560;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 561;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 562;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 565;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 10:
				{
					new modelid = 567;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 11:
				{
					new modelid = 575;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 12:
				{
					new modelid = 576;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYPVCP_JOBCARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 420;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 438;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 403;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 413;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 414;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 422;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 440;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 455;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 456;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 478;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 10:
				{
					new modelid = 482;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 11:
				{
					new modelid = 498;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 12:
				{
					new modelid = 499;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 13:
				{
					new modelid = 423;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 14:
				{
					new modelid = 588;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 15:
				{
					new modelid = 524;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 16:
				{
					new modelid = 525;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 17:
				{
					new modelid = 543;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 18:
				{
					new modelid = 552;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 19:
				{
					new modelid = 554;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 20:
				{
					new modelid = 578;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 21:
				{
					new modelid = 609;
					new tstr[128], price = GetVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYPVCP_VIPCARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 522;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 411;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 451;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 415;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 502;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 541;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 429;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 506;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 494;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 502;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 10:
				{
					new modelid = 503;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 11:
				{
					new modelid = 409;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 12:
				{
					new modelid = 477;
					new tstr[128], price = GetVipVehicleCost(modelid);
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_RENT_JOBCARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 414;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 1:
				{
					new modelid = 455;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 2:
				{
					new modelid = 456;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 3:
				{
					new modelid = 498;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 4:
				{
					new modelid = 499;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 5:
				{
					new modelid = 609;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 6:
				{
					new modelid = 478;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 7:
				{
					new modelid = 422;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 8:
				{
					new modelid = 543;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 9:
				{
					new modelid = 554;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 10:
				{
					new modelid = 525;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 11:
				{
					new modelid = 438;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 12:
				{
					new modelid = 420;
					new tstr[128];
					PlayerData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_RENT_JOBCARSCONFIRM)
	{
		new modelid = PlayerData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return SendErrorMessage(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			if(PlayerData[playerid][pMoney] < 500)
			{
				SendErrorMessage(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + PlayerData[playerid][pVip];
			foreach(new ii : PlayerVehicles)
			{
				if(VehicleData[ii][cOwner] == PlayerData[playerid][pID])
					count++;
			}
			if(count >= limit)
			{
				SendErrorMessage(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			GivePlayerMoneyEx(playerid, -500);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2, rental;
			color1 = 0;
			color2 = 0;
			model = modelid;
			x = 1798.24;
			y = -1791.35;
			z = 13.53;
			a = 94.50;
			rental = gettime() + (1 * 86400);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`, `rental`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f', '%d')", PlayerData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
			mysql_tquery(g_SQL, cQuery, "OnVehRentPV", "ddddddffffd", playerid, PlayerData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
			return 1;
		}
		else
		{
			PlayerData[playerid][pBuyPvModel] = 0;
		}
	}
	if(dialogid == DIALOG_BUYPVCP_CONFIRM)
	{
		new modelid = PlayerData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return SendErrorMessage(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			if(PlayerData[playerid][pMoney] < cost)
			{
				SendErrorMessage(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			GivePlayerMoneyEx(playerid, -cost);
			new model, color1, color2;
			color1 = 0;
			color2 = 0;
			model = modelid;

			SetPVarFloat(playerid, "VehPosX", 1798.24);
			SetPVarFloat(playerid, "VehPosY", -1791.35);
			SetPVarFloat(playerid, "VehPosZ", 13.53);
			SetPVarFloat(playerid, "VehPosA", 94.50);
			
			if(Vehicle_Create(playerid, model, color1, color2, cost, false) == -1)
				return 1;

			SendCustomMessage(playerid, "DEALER", "You have bought {ffff00}%s{ffffff} for {00ff00}%s{ffffff}.", GetVehicleModelName(model), FormatMoney(cost));
			return 1;
		}
		else
		{
			PlayerData[playerid][pBuyPvModel] = 0;
		}
	}
	if(dialogid == DIALOG_BUYPVCP_VIPCONFIRM)
	{
		new modelid = PlayerData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return SendErrorMessage(playerid, "Invalid model id.");
			new cost = GetVipVehicleCost(modelid);
			if(PlayerData[playerid][pGold] < cost)
			{
				SendErrorMessage(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + PlayerData[playerid][pVip];
			foreach(new ii : PlayerVehicles)
			{
				if(VehicleData[ii][cOwner] == PlayerData[playerid][pID])
					count++;
			}
			if(count >= limit)
			{
				SendErrorMessage(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			PlayerData[playerid][pGold] -= cost;
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			color1 = 0;
			color2 = 0;
			model = modelid;
			x = 1798.24;
			y = -1791.35;
			z = 13.53;
			a = 94.50;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", PlayerData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "OnVehBuyVIPPV", "ddddddffff", playerid, PlayerData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			return 1;
		}
		else
		{
			PlayerData[playerid][pBuyPvModel] = 0;
		}
	}
	/*if(dialogid == DIALOG_SALARY)
	{
		if(!response) 
		{
			ListPage[playerid]--;
			if(ListPage[playerid] < 0)
			{
				ListPage[playerid] = 0;
				return 1;
			}
		}
		else
		{
			ListPage[playerid]++;
		}
		
		DisplaySalary(playerid);
		return 1;
	}*/
	if(dialogid == DIALOG_PAYCHECK)
	{
		if(response)
		{
			if(PlayerData[playerid][pPaycheck] < 3600) return SendErrorMessage(playerid, "Sekarang belum waktunya anda mengambil paycheck.");
			
			new query[512];
			mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM salary WHERE owner='%d' ORDER BY id ASC LIMIT 30", PlayerData[playerid][pID]);
			mysql_query(g_SQL, query);
			new rows = cache_num_rows();
			if(rows) 
			{
				new list[2000], date[30], info[16], money, totalduty, gajiduty, totalsal, total, pajak, hasil;
				
				totalduty = PlayerData[playerid][pOnDutyTime] + PlayerData[playerid][pTaxiTime];
				for(new i; i < rows; ++i)
				{
					cache_get_value_name(i, "info", info);
					cache_get_value_name(i, "date", date);
					cache_get_value_name_int(i, "money", money);
					totalsal += money;
				}
				
				if(totalduty > 600)
				{
					gajiduty = 600;
				}
				else
				{
					gajiduty = totalduty;
				}
				total = gajiduty + totalsal;
				pajak = total / 100 * 10;
				hasil = total - pajak;
				
				format(list, sizeof(list), "Total gaji yang masuk ke rekening bank anda adalah: "LG_E"%s", FormatMoney(hasil));
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Paycheck", list, "Close", "");
				PlayerData[playerid][pBankMoney] += hasil;
				Server_MinMoney(hasil);
				PlayerData[playerid][pPaycheck] = 0;
				PlayerData[playerid][pOnDutyTime] = 0;
				PlayerData[playerid][pTaxiTime] = 0;
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM salary WHERE owner='%d'", PlayerData[playerid][pID]);
				mysql_query(g_SQL, query);
			}
			else
			{
				new list[2000], totalduty, gajiduty, total, pajak, hasil;
				
				totalduty = PlayerData[playerid][pOnDutyTime] + PlayerData[playerid][pTaxiTime];
				
				if(totalduty > 600)
				{
					gajiduty = 600;
				}
				else
				{
					gajiduty = totalduty;
				}
				total = gajiduty;
				pajak = total / 100 * 10;
				hasil = total - pajak;
				
				format(list, sizeof(list), "Total gaji yang masuk ke rekening bank anda adalah: "LG_E"%s", FormatMoney(hasil));
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Paycheck", list, "Close", "");
				PlayerData[playerid][pBankMoney] += hasil;
				Server_MinMoney(hasil);
				PlayerData[playerid][pPaycheck] = 0;
				PlayerData[playerid][pOnDutyTime] = 0;
				PlayerData[playerid][pTaxiTime] = 0;
			}
		}
	}
	if(dialogid == DIALOG_SWEEPER)
	{
		if(response)
		{
			if(PlayerData[playerid][pSideJobTime] > 0)
			{
				SendErrorMessage(playerid, "Anda harus menunggu %d "WHITE_E"detik lagi.", PlayerData[playerid][pSideJobTime]);
				RemovePlayerFromVehicle(playerid);
				return 1;
			}
			
			Sweeper_ShowDialog(playerid);
		}
		else
		{
			RemovePlayerFromVehicle(playerid);
		}
	}
	if(dialogid == DIALOG_SWEEPER_START)
	{
		if(!response)
		{
			RemovePlayerFromVehicle(playerid);
			return 1;
		}

		if(sweeperRouteTaken[listitem])
			return Sweeper_ShowDialog(playerid);

		PlayerData[playerid][pSideJob] = 1;
		SetPVarInt(playerid, "sweeperRoute", listitem);
		SetPVarInt(playerid, "sweeperCount", 0);
		SendCustomMessage(playerid, "SIDEJOB", "Ikuti Checkpoint!");

		sweeperRouteTaken[listitem] = true;

		SetPlayerRaceCheckpoint(playerid, CP_TYPE_GROUND_NORMAL, 1378.2147,-1583.3353,13.0968, SweeperRoute[listitem][0][0], SweeperRoute[listitem][0][1], SweeperRoute[listitem][0][2], 3.0);
	}
	if(dialogid == DIALOG_BUS)
	{
		if(response)
		{
			if(PlayerData[playerid][pSideJobTime] > 0)
			{
				SendErrorMessage(playerid, "Anda harus menunggu %d detik lagi.", PlayerData[playerid][pSideJobTime]);
				RemovePlayerFromVehicle(playerid);
				return 1;
			}
			
			Bus_ShowDialog(playerid);
		}
		else
		{
			RemovePlayerFromVehicle(playerid);
		}
	}
	if(dialogid == DIALOG_BUS_START)
	{
		if(!response)
		{
			RemovePlayerFromVehicle(playerid);
			return 1;
		}

		if(busRouteTaken[listitem])
			return Bus_ShowDialog(playerid);

		PlayerData[playerid][pSideJob] = 2;
		SetPVarInt(playerid, "busRoute", listitem);
		SetPVarInt(playerid, "busCount", 0);
		SendCustomMessage(playerid, "SIDEJOB", "Ikuti Checkpoint!");

		busRouteTaken[listitem] = true;

		SetPlayerRaceCheckpoint(playerid, CP_TYPE_GROUND_NORMAL, 1002.7592, -1333.8193, 13.0893, BusRoute[listitem][0][bPosX], BusRoute[listitem][0][bPosY], BusRoute[listitem][0][bPosZ], 3.0);
	}
	if(dialogid == DIALOG_FORKLIFT)
	{
		if(response)
		{
			if(PlayerData[playerid][pSideJobTime] > 0)
			{
				SendErrorMessage(playerid, "Anda harus menunggu %d detik lagi.", PlayerData[playerid][pSideJobTime]);
				RemovePlayerFromVehicle(playerid);
				return 1;
			}
			
			PlayerData[playerid][pSideJob] = 3;
			SetPlayerCheckpoint(playerid, 2745.33, -2431.58, 13.64, 5.0);
			SendCustomMessage(playerid, "SIDEJOB", "Ikuti Checkpoint!");
		}
		else
		{
			RemovePlayerFromVehicle(playerid);
		}
	}
	if(dialogid ==  DIALOG_STUCK)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					SendStaffMessage(COLOR_RED, "[STUCK REPORT] "WHITE_E"%s (ID: %d) stuck: Tersangkut di Gedung", PlayerData[playerid][pName], playerid);
				}
				case 1:
				{
					SendStaffMessage(COLOR_RED, "[STUCK REPORT] "WHITE_E"%s (ID: %d) stuck: Tersangkut setelah keluar masuk Interior", PlayerData[playerid][pName], playerid);
				}
				case 2:
				{

					if((Vehicle_Nearest(playerid)) != -1)
					{
						new Float:vX, Float:vY, Float:vZ;
						GetPlayerPos(playerid, vX, vY, vZ);
						SetPlayerPos(playerid, vX, vY, vZ+2);
						SendStaffMessage(COLOR_RED, "[STUCK REPORT] "WHITE_E"%s (ID: %d) stuck: Tersangkut diKendaraan (Non Visual Bug)", PlayerData[playerid][pName], playerid);
					}
					else
					{
						SendErrorMessage(playerid, "Anda tidak berada didekat Kendaraan apapun");
						SendStaffMessage(COLOR_RED, "[STUCK REPORT] "WHITE_E"%s (ID: %d) stuck: Tersangkut diKendaraan (Visual Bug)", PlayerData[playerid][pName], playerid);
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_PICKUPVEH)
	{
		if(response)
		{
			new id = PlayerData[playerid][pValueListitem][listitem];

			GetPlayerPos(playerid, VehicleData[id][cPosX], VehicleData[id][cPosY], VehicleData[id][cPosZ]);
			GetPlayerFacingAngle(playerid, VehicleData[id][cPosA]);
			VehicleData[id][cPark] = -1;

			OnPlayerVehicleRespawn(id);
			
			SetPlayerPos(playerid, VehicleData[id][cPosX]-2, VehicleData[id][cPosY], VehicleData[id][cPosZ]+1);
			SendInfoMessage(playerid, "You have successfully spawned %s(ID: %d)", GetVehicleModelName(VehicleData[id][cVeh]), VehicleData[id][cVeh]);

			ResetValueListitem(playerid);
		}
	}
	if(dialogid == DIALOG_MY_WS)
	{
		if(!response) return true;
		new id = ReturnPlayerWorkshopID(playerid, (listitem + 1));
		SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, wsData[id][wX], wsData[id][wY], wsData[id][wZ], 0.0, 0.0, 0.0, 3.5);
		SendInfoMessage(playerid, "Ikuti checkpoint untuk menemukan Business anda!");
		return 1;
	}
	if(dialogid == WS_MENU)
	{
		if(response)
		{
			new id = PlayerData[playerid][pInWs];
			switch(listitem)
			{
				case 0:
				{
					if(!IsWorkshopOwner(playerid, id))
						return SendErrorMessage(playerid, "Only Workshop Owner who can use this");

					new str[256];
					format(str, sizeof str,"Current Workshop Name:\n%s\n\nInput new name to Change Workshop Name", wsData[id][wName]);
					ShowPlayerDialog(playerid, WS_SETNAME, DIALOG_STYLE_INPUT, "Change Workshop Name", str,"Change","Cancel");
				}
				case 1:
				{
					new str[556];
					format(str, sizeof str,"Name\tRank\n(%s)\tOwner\n",wsData[id][wOwner]);
					for(new z = 0; z < MAX_WORKSHOP_EMPLOYEE; z++)
					{
						format(str, sizeof str,"%s(%s)\tEmploye\n", str, wsEmploy[id][z]);
					}
					ShowPlayerDialog(playerid, WS_SETEMPLOYE, DIALOG_STYLE_TABLIST_HEADERS, "Employe Menu", str, "Change","Cancel");
				}
				case 2:
				{
					ShowPlayerDialog(playerid, WS_COMPONENT, DIALOG_STYLE_LIST, "Workshop Component", "Withdraw\nDeposit", "Select","Cancel");
				}
				case 3:
				{
					ShowPlayerDialog(playerid, WS_MATERIAL, DIALOG_STYLE_LIST, "Workshop Material", "Withdraw\nDeposit", "Select","Cancel");
				}
				case 4:
				{
					ShowPlayerDialog(playerid, WS_MONEY, DIALOG_STYLE_LIST, "Workshop Money", "Withdraw\nDeposit", "Select","Cancel");
				}
			}
		}
	}
	if(dialogid == WS_SETNAME)
	{
		if(response)
		{
			new id = PlayerData[playerid][pInWs];

			if(!IsWorkshopOwner(playerid, id))
				return SendErrorMessage(playerid, "Only Workshop Owner who can use this");

			if(strlen(inputtext) > 24) 
				return SendErrorMessage(playerid, "Maximal 24 Character");

			if(strfind(inputtext, "'", true) != -1)
				return SendErrorMessage(playerid, "You can't put ' in Workshop Name");
			
			SendClientMessage(playerid, ARWIN, "WORKSHOP: {ffffff}You've successfully set Workshop Name from {ffff00}%s{ffffff} to {7fffd4}%s", wsData[id][wName], inputtext);
			format(wsData[id][wName], 24, inputtext);
			Workshop_Save(id);
			Workshop_Refresh(id);
		}
	}
	if(dialogid == WS_SETEMPLOYE)
	{
		if(response)
		{
			new id = PlayerData[playerid][pInWs], str[256];

			if(!IsWorkshopOwner(playerid, id))
				return SendErrorMessage(playerid, "Only Workshop Owner who can use this");

			switch(listitem)
			{
				case 0:
				{
					PlayerData[playerid][pMenuType] = 0;
					format(str, sizeof str, "Current Owner:\n%s\n\nInput Player ID/Name to Change Ownership", wsData[id][wOwner]);
				}
				case 1:
				{
					PlayerData[playerid][pMenuType] = 1;
					format(str, sizeof str, "Current Employe:\n%s\n\nInput Player ID/Name to Change", wsEmploy[id][0]);
				}
				case 2:
				{
					PlayerData[playerid][pMenuType] = 2;
					format(str, sizeof str, "Current Employe:\n%s\n\nInput Player ID/Name to Change", wsEmploy[id][1]);
				}
				case 3:
				{
					PlayerData[playerid][pMenuType] = 3;
					format(str, sizeof str, "Current Employe:\n%s\n\nInput Player ID/Name to Change", wsEmploy[id][2]);
				}
			}
			ShowPlayerDialog(playerid, WS_SETEMPLOYEE, DIALOG_STYLE_INPUT, "Employe Menu", str, "Change", "Cancel");
		}
	}
	if(dialogid == WS_SETEMPLOYEE)
	{
		if(response)
		{
			new otherid, id = PlayerData[playerid][pInWs], eid = PlayerData[playerid][pMenuType];
			if(!strcmp(inputtext, "-", true))
			{
				SendClientMessage(playerid, ARWIN, "WORKSHOP: {ffffff}You've successfully removed %s from Workshop", wsEmploy[id][(eid - 1)]);
				format(wsEmploy[id][(eid - 1)], MAX_PLAYER_NAME, "-");
				Workshop_Save(id);
				return 1;
			}

			if(sscanf(inputtext,"u", otherid))
				return SendErrorMessage(playerid, "You must put Player ID/Name");

			if(!IsWorkshopOwner(playerid, id))
				return SendErrorMessage(playerid, "Only Workshop Owner who can use this");

			if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
				return SendErrorMessage(playerid, "Player itu Disconnect or not near you.");

			if(otherid == playerid)
				return SendErrorMessage(playerid, "You can't set to yourself as owner.");

			if(eid == 0)
			{
				new str[128];
				PlayerData[playerid][pTransferWS] = otherid;
				format(str, sizeof str,"Are you sure want to transfer ownership to %s?", ReturnName(otherid));
				ShowPlayerDialog(playerid, WS_SETOWNERCONFIRM, DIALOG_STYLE_MSGBOX, "Transfer Ownership", str,"Confirm","Cancel");
			}
			else if(eid > 0 && eid < 4)
			{
				format(wsEmploy[id][(eid - 1)], MAX_PLAYER_NAME, PlayerData[otherid][pName]);
				SendCustomMessage(playerid, "WORKSHOP", "You've successfully add %s to Workshop", PlayerData[otherid][pName]);
				SendCustomMessage(otherid, "WORKSHOP", "You've been hired in Workshop %s by %s", wsData[id][wName], PlayerData[playerid][pName]);
				Workshop_Save(id);
			}
			Workshop_Save(id);
			Workshop_Refresh(id);
		}
	}
	if(dialogid == WS_SETOWNERCONFIRM)
	{
		if(!response) 
			PlayerData[playerid][pTransferWS] = INVALID_PLAYER_ID;

		new otherid = PlayerData[playerid][pTransferWS], id = PlayerData[playerid][pInWs];
		if(response)
		{
			if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
				return SendErrorMessage(playerid, "Player itu Disconnect or not near you.");

			SendCustomMessage(playerid, "WORKSHOP", "You've successfully transfered %s Workshop to %s",wsData[id][wName], PlayerData[otherid][pName]);
			SendCustomMessage(otherid, "WORKSHOP", "You've been transfered to owner in %s Workshop by %s", wsData[id][wName], PlayerData[playerid][pName]);
			format(wsData[id][wOwner], MAX_PLAYER_NAME, PlayerData[otherid][pName]);
			Workshop_Save(id);
			Workshop_Refresh(id);
		}
	}
	if(dialogid == WS_COMPONENT)
	{
		if(response)
		{
			new str[256], id = PlayerData[playerid][pInWs];
			switch(listitem)
			{
				case 0:
				{
					PlayerData[playerid][pMenuType] = 1;
					format(str, sizeof str,"Current Component: %d\n\nPlease Input amount to Withdraw", wsData[id][wComp]);
				}
				case 1:
				{
					PlayerData[playerid][pMenuType] = 2;
					format(str, sizeof str,"Current Component: %d\n\nPlease Input amount to Deposit", wsData[id][wComp]);
				}
			}
			ShowPlayerDialog(playerid, WS_COMPONENT2, DIALOG_STYLE_INPUT, "Component Menu", str, "Input","Cancel");
		}
	}
	if(dialogid == WS_COMPONENT2)
	{
		if(response)
		{
			new amount = strval(inputtext), id = PlayerData[playerid][pInWs];
			if(PlayerData[playerid][pMenuType] == 1)
			{
				if(amount < 1)
					return SendErrorMessage(playerid, "Minimum amount is 1");

				if(wsData[id][wComp] < amount) return SendErrorMessage(playerid, "Not Enough Workshop Component");

				if(Inventory_Add(playerid, "Component", amount) == -1)
					return 1;

				wsData[id][wComp] -= amount;
				Workshop_Save(id);
				SendCustomMessage(playerid, "WORKSHOP", "You've successfully withdraw %d Component from Workshop", amount);
			}
			else if(PlayerData[playerid][pMenuType] == 2)
			{
				if(amount < 1)
					return SendErrorMessage(playerid, "Minimum amount is 1");

				if(Inventory_Has(playerid, "Component") < amount) return SendErrorMessage(playerid, "Not Enough Component");

				if((wsData[id][wComp] + amount) >= MAX_WORKSHOP_INT)
					return SendErrorMessage(playerid, "You've reached maximum of Component");

				Inventory_Remove(playerid, "Component", amount);
				wsData[id][wComp] += amount;
				Workshop_Save(id);
				SendCustomMessage(playerid, "WORKSHOP", "You've successfully deposit %d Component to Workshop", amount);
			}
		}
	}
	if(dialogid == WS_MATERIAL)
	{
		if(response)
		{
			new str[256], id = PlayerData[playerid][pInWs];
			switch(listitem)
			{
				case 0:
				{
					PlayerData[playerid][pMenuType] = 1;
					format(str, sizeof str,"Current Material: %d\n\nPlease Input amount to Withdraw", wsData[id][wMat]);
				}
				case 1:
				{
					PlayerData[playerid][pMenuType] = 2;
					format(str, sizeof str,"Current Material: %d\n\nPlease Input amount to Deposit", wsData[id][wMat]);
				}
			}
			ShowPlayerDialog(playerid, WS_MATERIAL2, DIALOG_STYLE_INPUT, "Material Menu", str, "Input","Cancel");
		}
	}
	if(dialogid == WS_MATERIAL2)
	{
		if(response)
		{
			new amount = strval(inputtext), id = PlayerData[playerid][pInWs];
			if(PlayerData[playerid][pMenuType] == 1)
			{
				if(amount < 1)
					return SendErrorMessage(playerid, "Minimum amount is 1");

				if(wsData[id][wMat] < amount) return SendErrorMessage(playerid, "Not Enough Workshop Material");

				if(Inventory_Add(playerid, "Material", amount) == -1)
					return -1;

				wsData[id][wMat] -= amount;
				Workshop_Save(id);
				SendCustomMessage(playerid, "WORKSHOP", "You've successfully withdraw %d Material from Workshop", amount);
			}
			else if(PlayerData[playerid][pMenuType] == 2)
			{
				if(amount < 1)
					return SendErrorMessage(playerid, "Minimum amount is 1");

				if(Inventory_Has(playerid, "Material") < amount) return SendErrorMessage(playerid, "Not Enough Material");

				if((wsData[id][wMat] + amount) >= MAX_WORKSHOP_INT)
					return SendErrorMessage(playerid, "You've reached maximum of Material");

				Inventory_Remove(playerid, "Material", amount);
				wsData[id][wMat] += amount;
				Workshop_Save(id);
				SendCustomMessage(playerid, "WORKSHOP", "You've successfully deposit %d Material to Workshop", amount);
			}
		}
	}
	if(dialogid == WS_MONEY)
	{
		if(response)
		{
			new str[264], id = PlayerData[playerid][pInWs];
			switch(listitem)
			{
				case 0:
				{
					if(!IsWorkshopOwner(playerid, id))
						return SendErrorMessage(playerid, "Only Workshop Owner who can use this");

					format(str, sizeof str, "Current Money:\n{7fff00}%s\n\n{ffffff}Input Amount to Withdraw", FormatMoney(wsData[id][wMoney]));
					ShowPlayerDialog(playerid, WS_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw Workshop Money",str,"Withdraw","Cancel");
				}
				case 1:
				{
					format(str, sizeof str, "Current Money:\n{7fff00}%s\n\n{ffffff}Input Amount to Deposit", FormatMoney(wsData[id][wMoney]));
					ShowPlayerDialog(playerid, WS_DEPOSITMONEY, DIALOG_STYLE_INPUT, "Deposit Workshop Money",str,"Deposit","Cancel");
				}
			}
		}
	}
	if(dialogid == WS_WITHDRAWMONEY)
	{
		if(response)
		{
			new amount = strval(inputtext), id = PlayerData[playerid][pInWs];

			if(amount < 1)
				return SendErrorMessage(playerid, "Minimum amount is $1");

			if(wsData[id][wMoney] < amount)
				return SendErrorMessage(playerid, "Not Enough Workshop Money");

			GivePlayerMoneyEx(playerid, amount);
			wsData[id][wMoney] -= amount;
			Workshop_Save(id);
		}
	}
	if(dialogid == WS_DEPOSITMONEY)
	{
		if(response)
		{
			new amount = strval(inputtext), id = PlayerData[playerid][pInWs];
			
			if(amount < 1)
				return SendErrorMessage(playerid, "Minimum amount is $1");

			if(PlayerData[playerid][pMoney] < amount)
				return SendErrorMessage(playerid, "Not Enough Money");

			GivePlayerMoneyEx(playerid, -amount);
			wsData[id][wMoney] += amount;
			Workshop_Save(id);
		}
	}
	if(dialogid == DIALOG_BOOMBOX)
    {
    	if(!response)
     	{
            SendClientMessage(playerid, COLOR_WHITE, " Kamu Membatalkan Music");
        	return 1;
        }
		switch(listitem)
  		{
			case 1:
			{
			    ShowPlayerDialog(playerid,DIALOG_BOOMBOX1,DIALOG_STYLE_INPUT, "Boombox Input URL", "Please put a Music URL to play the Music", "Play", "Cancel");
			}
			case 2:
			{
                if(GetPVarType(playerid, "BBArea"))
			    {
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has pick up their boombox.", ReturnName(playerid));
			        foreach(new i : Player)
					{
			            if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "BBArea")))
			            {
			                StopStream(i);
						}
					}
			        DeletePVar(playerid, "BBStation");
				}
				SendInfoMessage(playerid, "Kamu telah mematikan boombox.");
			}
        }
	}
	if(dialogid == DIALOG_BOOMBOX1)//SET URL
	{
		if(response == 1)
		{
		    if(isnull(inputtext))
		    {
		        SendErrorMessage(playerid, "Kamu harus memasukan url!");
		        return 1;
		    }
		    if(strlen(inputtext))
		    {
		        if(GetPVarType(playerid, "PlacedBB"))
				{
				    foreach(new i : Player)
					{
						if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "BBArea")) && playerPlaylist[playerid] == 0)
						{
							PlayStream(i, inputtext, GetPVarFloat(playerid, "BBX"), GetPVarFloat(playerid, "BBY"), GetPVarFloat(playerid, "BBZ"), 30.0, true);
				  		}
				  	}
			  		SetPVarString(playerid, "BBStation", inputtext);
				}
			}
		}
	}
	if(dialogid == DIALOG_VEHICLE_PANEL)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: callcmd::engine(playerid, "");
				case 1: callcmd::lights(playerid, "");
				case 2: callcmd::window(playerid, "");
				case 3: callcmd::lock(playerid, "");
				case 4: callcmd::vacc(playerid, "");
				case 5: callcmd::inventory(playerid, "");
			}
		}
	}
	if(dialogid == DIALOG_VEHICLE_WINDOW)
	{
		if(response)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(!IsValidVehicleDoor(vehicleid, listitem+1))
				return SendErrorMessage(playerid, "The Window is doesn't even exist!");

			SetVehicleWindowState(vehicleid, listitem+1, GetVehicleWindowState(vehicleid, listitem+1) == 0 ? 1 : 0);
			forex(fan, MAX_PLAYERS) if(GetPlayerVehicleID(fan) == vehicleid)
				SendVehicleMessage(fan, "The Driver has %s the %s.", GetVehicleWindowState(vehicleid, listitem+1) ? "closed" : "opened", WindowName[listitem]);
		}
	}
    return 1;
}

ResetValueListitem(playerid)
{
	forex(fan, 500) PlayerData[playerid][pValueListitem][fan] = -1;
	return 1;
}