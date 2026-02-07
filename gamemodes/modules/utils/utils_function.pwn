
//----------[ Function Login Register]----------
public:OnFannLoaded(playerid)
{
    if (cache_num_rows())
    {
        cache_get_value_name(0, "ucp", UcpData[playerid][uUsername], 64);
        SetPlayerName(playerid, UcpData[playerid][uUsername]);

        new query[5000];
        mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `ucp` WHERE `username` = '%e' LIMIT 1;", UcpData[playerid][uUsername]);
        mysql_tquery(g_SQL, query, "OnUCPLoaded", "d", playerid);
    }
    else
    {
        new fan[5000];
        format(fan, sizeof(fan), ""WHITE_E"Selamat Datang di "RED_E"HopePride"WHITE_E"!\n\nNama Karakter: %s\nStatus: "RED_E"Tidak Terdaftar"WHITE_E"\nVersion: "GREY_E""TEXT_VERSION""WHITE_E"\n\nSilahkan register di Discord HopePride terlebih dahulu:\nhttps://discord.gg/qtwh4FRBCG", GetName(playerid));
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Unregistered", fan, "Ok", "");
        KickEx(playerid);
    }
    return 1;
}

public:OnUCPLoaded(playerid)
{
    new rows = cache_num_rows();
    if (rows)
    {
        cache_get_value_name_int(0, "id", UcpData[playerid][uID]);
        cache_get_value_name_int(0, "admin", UcpData[playerid][uAdmin]);
        cache_get_value_name(0, "username", UcpData[playerid][uUsername], 64);
        cache_get_value_name(0, "password", UcpData[playerid][uPassword], BCRYPT_HASH_LENGTH);
        cache_get_value_name(0, "ip", UcpData[playerid][uIP], 16);
        cache_get_value_name(0, "verifycode", UcpData[playerid][uVerifyCode]);
        cache_get_value_name_int(0, "verifystatus", UcpData[playerid][uVerifyStatus]);
        cache_get_value_name(0, "registerdate", UcpData[playerid][uRegisterDate]);

        if (Blacklist_CheckByName(UcpData[playerid][uUsername]))
        {
            return Blacklist_Menu(playerid, true);
        }
  
	    foreach(new fan : Player) if(fan != playerid && !strcmp(UcpData[fan][uUsername], UcpData[playerid][uUsername]))
        {
            SendServerMessage(fan, "Ada seseorang yang ingin memasuki akun UCPmu!");
            SendServerMessage(playerid, "UCP ini sedang dipakai!");
            KickEx(playerid);
            return 1;
        }

        //SendClientMessage(playerid, ARWIN, "FANN: {ffffff}Loading music...");
        //PlayAudioStreamForPlayer(playerid, "http://k.top4top.io/m_3427cbj4g9.mp3");

        new fan[256];
        if (UcpData[playerid][uVerifyStatus])
        {
            if (strlen(UcpData[playerid][uPassword]) > 0)
            {
                format(fan, sizeof(fan), ""WHITE_E"Selamat Datang di "LB_E"HopePride"WHITE_E", %s!\n\nNama UCP: %s\nStatus: "GREEN_E"Sudah Terdaftar"WHITE_E"\nVersion: "GREY_E""TEXT_VERSION""WHITE_E"\n\nMasukan password akun mu:", UcpData[playerid][uUsername], UcpData[playerid][uUsername]);
                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", fan, "Masuk", "");
            }
            else
            {
                format(fan, sizeof(fan), ""WHITE_E"Selamat Datang di "LB_E"HopePride"WHITE_E", %s!\n\nNama UCP: %s\nStatus: "LRED_E"Sudah Terdaftar tapi belum memiliki password"WHITE_E"\nVersion: "GREY_E""TEXT_VERSION""WHITE_E"\n\nMasukan password yang ingin kamu masukan:", UcpData[playerid][uUsername], UcpData[playerid][uUsername]);
                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", fan, "Daftarkan", "");
            }
        }
        else
        {
            format(fan, sizeof(fan), ""WHITE_E"Selamat Datang di "LB_E"HopePride"WHITE_E", %s!\n\nNama UCP: %s\nStatus: "LRED_E"Sudah Terdaftar tapi belum Verifikasi"WHITE_E"\nVersion: "GREY_E""TEXT_VERSION""WHITE_E"\n\nMasukan PIN yang diberi oleh bot kami:", UcpData[playerid][uUsername], UcpData[playerid][uUsername]);
            ShowPlayerDialog(playerid, DIALOG_VERIFYCODE, DIALOG_STYLE_INPUT, "Verifikasi Kode", fan, "Masukan", "");
        }
    }
    else
    {
        new fan[256];
        format(fan, sizeof(fan), ""WHITE_E"Selamat Datang di "RED_E"HopePride"WHITE_E"!\n\nNama UCP: %s\nStatus: "RED_E"Tidak Terdaftar"WHITE_E"\nVersion: "GREY_E""TEXT_VERSION""WHITE_E"\n\nSilahkan register di Discord HopePride terlebih dahulu:\nhttps://discord.gg/qtwh4FRBCG", GetName(playerid));
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Unregistered", fan, "Ok", "");
        KickEx(playerid);
    }
    return 1;
}

public:OnCharacterCheck(playerid, name[])
{
    new rows = cache_num_rows();
    if (rows > 0)
    {
        ShowPlayerDialog(playerid, DIALOG_CREATECHAR, DIALOG_STYLE_INPUT, "Create Character", ""WHITE_E"Masukkan nama karakter, maksimal 24 karakter\n\nContoh: "YELLOW_E"Sean_Rutledge, Eddison_Murphy dan lainnya.", "Create", "Back");
    }
    else
    {
        new characterQuery[178];
        mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "INSERT INTO players ( username, ucp, reg_date ) VALUES ('%s', '%s', CURRENT_TIMESTAMP())", name, GetName(playerid));
        mysql_tquery(g_SQL, characterQuery, "OnPlayerRegister", "d", playerid);

        SetPlayerName(playerid, name);
        format(PlayerData[playerid][pName], MAX_PLAYER_NAME, name);
    }
}

public:AssignPlayerData(playerid)
{
    new aname[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME], twname[MAX_PLAYER_NAME], email[40], age[128], ip[128], regdate[50], lastlogin[50];
    cache_get_value_name_int(0, "reg_id", PlayerData[playerid][pID]);
    if (PlayerData[playerid][pID] < 1)
    {
        SendErrorMessage(playerid, "Database player not found!");
        KickEx(playerid);
        return 1;
    }
    cache_get_value_name(0, "username", name);
    format(PlayerData[playerid][pName], MAX_PLAYER_NAME, "%s", name);
    cache_get_value_name(0, "adminname", aname);
    format(PlayerData[playerid][pAdminname], MAX_PLAYER_NAME, "%s", aname);
    cache_get_value_name(0, "twittername", twname);
    format(PlayerData[playerid][pTwittername], MAX_PLAYER_NAME, "%s", twname);
    cache_get_value_name(0, "ip", ip);
    format(PlayerData[playerid][pIP], 128, "%s", ip);
    cache_get_value_name(0, "email", email);
    format(PlayerData[playerid][pEmail], 40, "%s", email);
    cache_get_value_name_int(0, "admin", PlayerData[playerid][pAdmin]);
    cache_get_value_name_int(0, "helper", PlayerData[playerid][pHelper]);
    cache_get_value_name_int(0, "level", PlayerData[playerid][pLevel]);
    cache_get_value_name_int(0, "levelup", PlayerData[playerid][pLevelUp]);
    cache_get_value_name_int(0, "vip", PlayerData[playerid][pVip]);
    cache_get_value_name_int(0, "vip_time", PlayerData[playerid][pVipTime]);
    cache_get_value_name_int(0, "gold", PlayerData[playerid][pGold]);
    cache_get_value_name(0, "reg_date", regdate);
    format(PlayerData[playerid][pRegDate], 128, "%s", regdate);
    cache_get_value_name(0, "last_login", lastlogin);
    format(PlayerData[playerid][pLastLogin], 128, "%s", lastlogin);
    cache_get_value_name_int(0, "money", PlayerData[playerid][pMoney]);
    cache_get_value_name_int(0, "bmoney", PlayerData[playerid][pBankMoney]);
    cache_get_value_name_int(0, "brek", PlayerData[playerid][pBankRek]);
    cache_get_value_name_int(0, "phone", PlayerData[playerid][pPhone]);
    cache_get_value_name_int(0, "phonecredit", PlayerData[playerid][pPhoneCredit]);
    cache_get_value_name_int(0, "phonebook", PlayerData[playerid][pPhoneBook]);
    cache_get_value_name_int(0, "wt", PlayerData[playerid][pWT]);
    cache_get_value_name_int(0, "hours", PlayerData[playerid][pHours]);
    cache_get_value_name_int(0, "minutes", PlayerData[playerid][pMinutes]);
    cache_get_value_name_int(0, "seconds", PlayerData[playerid][pSeconds]);
    cache_get_value_name_int(0, "paycheck", PlayerData[playerid][pPaycheck]);
    cache_get_value_name_int(0, "skin", PlayerData[playerid][pSkin]);
    cache_get_value_name_int(0, "facskin", PlayerData[playerid][pFacSkin]);
    cache_get_value_name_int(0, "gender", PlayerData[playerid][pGender]);
    cache_get_value_name(0, "age", age);
    format(PlayerData[playerid][pAge], 128, "%s", age);
    cache_get_value_name_int(0, "indoor", PlayerData[playerid][pInDoor]);
    cache_get_value_name_int(0, "inhouse", PlayerData[playerid][pInHouse]);
    cache_get_value_name_int(0, "inbiz", PlayerData[playerid][pInBiz]);
    cache_get_value_name_float(0, "posx", PlayerData[playerid][pPosX]);
    cache_get_value_name_float(0, "posy", PlayerData[playerid][pPosY]);
    cache_get_value_name_float(0, "posz", PlayerData[playerid][pPosZ]);
    cache_get_value_name_float(0, "posa", PlayerData[playerid][pPosA]);
    cache_get_value_name_int(0, "interior", PlayerData[playerid][pInt]);
    cache_get_value_name_int(0, "world", PlayerData[playerid][pWorld]);
    cache_get_value_name_float(0, "health", PlayerData[playerid][pHealth]);
    cache_get_value_name_float(0, "armour", PlayerData[playerid][pArmour]);
    cache_get_value_name_int(0, "hunger", PlayerData[playerid][pHunger]);
    cache_get_value_name_int(0, "energy", PlayerData[playerid][pEnergy]);
    cache_get_value_name_int(0, "sick", PlayerData[playerid][pSick]);
    cache_get_value_name_int(0, "claimedcode", PlayerData[playerid][pClaimedCode]);
    cache_get_value_name_int(0, "hospital", PlayerData[playerid][pHospital]);
    cache_get_value_name_int(0, "injured", PlayerData[playerid][pInjured]);
    cache_get_value_name_int(0, "booster", PlayerData[playerid][pBooster]);
    cache_get_value_name_int(0, "boosttime", PlayerData[playerid][pBoostTime]);
    cache_get_value_name_int(0, "duty", PlayerData[playerid][pOnDuty]);
    cache_get_value_name_int(0, "dutytime", PlayerData[playerid][pOnDutyTime]);
    cache_get_value_name_int(0, "faction", PlayerData[playerid][pFaction]);
    cache_get_value_name_int(0, "factionrank", PlayerData[playerid][pFactionRank]);
    cache_get_value_name_int(0, "factionlead", PlayerData[playerid][pFactionLead]);
    cache_get_value_name_int(0, "family", PlayerData[playerid][pFamily]);
    cache_get_value_name_int(0, "familyrank", PlayerData[playerid][pFamilyRank]);
    cache_get_value_name_int(0, "robtime", PlayerData[playerid][pRobTime]);
    cache_get_value_name_int(0, "jail", PlayerData[playerid][pJail]);
    cache_get_value_name_int(0, "jail_time", PlayerData[playerid][pJailTime]);
    cache_get_value_name_int(0, "arrest", PlayerData[playerid][pArrest]);
    cache_get_value_name_int(0, "arrest_time", PlayerData[playerid][pArrestTime]);
    cache_get_value_name_int(0, "warn", PlayerData[playerid][pWarn]);
    cache_get_value_name_int(0, "job", PlayerData[playerid][pJob]);
    cache_get_value_name_int(0, "job2", PlayerData[playerid][pJob2]);
    cache_get_value_name_int(0, "jobtime", PlayerData[playerid][pJobTime]);
    cache_get_value_name_int(0, "sidejobtime", PlayerData[playerid][pSideJobTime]);
    cache_get_value_name_int(0, "exitjob", PlayerData[playerid][pExitJob]);
    cache_get_value_name_int(0, "taxitime", PlayerData[playerid][pTaxiTime]);
    cache_get_value_name_int(0, "price1", PlayerData[playerid][pPrice1]);
    cache_get_value_name_int(0, "price2", PlayerData[playerid][pPrice2]);
    cache_get_value_name_int(0, "price3", PlayerData[playerid][pPrice3]);
    cache_get_value_name_int(0, "price4", PlayerData[playerid][pPrice4]);
    cache_get_value_name_int(0, "plant", PlayerData[playerid][pPlant]);
    cache_get_value_name_int(0, "plant_time", PlayerData[playerid][pPlantTime]);
    cache_get_value_name_int(0, "idcard", PlayerData[playerid][pIDCard]);
    cache_get_value_name_int(0, "idcard_time", PlayerData[playerid][pIDCardTime]);
    cache_get_value_name_int(0, "drivelic", PlayerData[playerid][pDriveLic]);
    cache_get_value_name_int(0, "drivelic_time", PlayerData[playerid][pDriveLicTime]);
    cache_get_value_name_int(0, "drivelic_delay", PlayerData[playerid][pDriveDelay]);
    cache_get_value_name_int(0, "couple", PlayerData[playerid][pCouple]);
    cache_get_value_name_int(0, "charstory", PlayerData[playerid][pCharStory]);
    cache_get_value_name_int(0, "claimed", PlayerData[playerid][pClaimed]);
    cache_get_value_name_int(0, "hbemode", PlayerData[playerid][pHBEMode]);
    cache_get_value_name_int(0, "invmode", PlayerData[playerid][pInvMode]);
    cache_get_value_name_int(0, "togpm", PlayerData[playerid][pTogPM]);
    cache_get_value_name_int(0, "toglog", PlayerData[playerid][pTogLog]);
    cache_get_value_name_int(0, "togads", PlayerData[playerid][pTogAds]);
    cache_get_value_name_int(0, "togwt", PlayerData[playerid][pTogWT]);

    new fann_weapon[13];
    forex(fan, 13)
    {
        cache_get_value_name_int(0, sprintf("Gun%d", fan + 1), fann_weapon[fan]);
        cache_get_value_name_int(0, sprintf("Ammo%d", fan + 1), PlayerData[playerid][pAmmo][fan]);

        PlayerData[playerid][pGuns][fan] = WEAPON:fann_weapon[fan];
    }   

    for (new fan; fan < 17; fan++)
    {
        WeaponSettings[playerid][WEAPON:fan][Position][0] = -0.116;
        WeaponSettings[playerid][WEAPON:fan][Position][1] = 0.189;
        WeaponSettings[playerid][WEAPON:fan][Position][2] = 0.088;
        WeaponSettings[playerid][WEAPON:fan][Position][3] = 0.0;
        WeaponSettings[playerid][WEAPON:fan][Position][4] = 44.5;
        WeaponSettings[playerid][WEAPON:fan][Position][5] = 0.0;
        WeaponSettings[playerid][WEAPON:fan][Bone] = 1;
        WeaponSettings[playerid][WEAPON:fan][Hidden] = false;
    }
    WeaponTick[playerid] = 0;
    EditingWeapon[playerid] = 0;
    new string[128];
    mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM weaponsettings WHERE Owner = '%d'", PlayerData[playerid][pID]);
    mysql_tquery(g_SQL, string, "OnWeaponsLoaded", "d", playerid);

    KillTimer(PlayerData[playerid][LoginTimer]);
    PlayerData[playerid][LoginTimer] = 0;
    PlayerData[playerid][IsLoggedIn] = true;

    TogglePlayerSpectating(playerid, false);

    UpdateWeapons(playerid);

    ShowLoadingScreen(playerid, "Character", NormalName(playerid), InfoServer, "LoadingCharacter");
    SetSpawnInfo(playerid, NO_TEAM, PlayerData[playerid][pSkin], PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ], PlayerData[playerid][pPosA], WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);
    SpawnPlayer(playerid);

    foreach (new other : Player) if (!PlayerData[other][pTogLog])
    {
        if (IsPlayerInRangeOfPoint(other, 80.0, PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ]))
        {
            SendClientMessage(other, COLOR_GREEN, "[JOIN]: {ffff00}%s{ffffff} telah masuk ke dalam kota.", PlayerData[playerid][pName]);
        }
    }

    MySQL_LoadPlayerToys(playerid);
    Vehicle_Load(playerid);
    Contact_Load(playerid);
    Playlist_Load(playerid);
    Inventory_Load(playerid);
    Skill_Load(playerid);
    Fish_Load(playerid);
    return 1;
}

public:OnPlayerRegister(playerid)
{
    if (PlayerData[playerid][IsLoggedIn] == true)
        return SendErrorMessage(playerid, "You already logged in!");

    PlayerData[playerid][pID] = cache_insert_id();
    PlayerData[playerid][IsLoggedIn] = true;

    PlayerData[playerid][pPosX] = DEFAULT_POS_X;
    PlayerData[playerid][pPosY] = DEFAULT_POS_Y;
    PlayerData[playerid][pPosZ] = DEFAULT_POS_Z;
    PlayerData[playerid][pPosA] = DEFAULT_POS_A;
    PlayerData[playerid][pInt] = 0;
    PlayerData[playerid][pWorld] = 0;
    PlayerData[playerid][pGender] = 0;

    format(PlayerData[playerid][pAdminname], MAX_PLAYER_NAME, "None");
    format(PlayerData[playerid][pEmail], 40, "None");
    PlayerData[playerid][pHealth] = 100.0;
    PlayerData[playerid][pArmour] = 0.0;
    PlayerData[playerid][pLevel] = 1;
    PlayerData[playerid][pHunger] = 100;
    PlayerData[playerid][pEnergy] = 100;
    PlayerData[playerid][pMoney] = 250;
    PlayerData[playerid][pBankMoney] = 200;

    new query[128], rand = RandomEx(111111, 999999);
    new rek = rand + PlayerData[playerid][pID];
    mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
    mysql_tquery(g_SQL, query, "BankRek", "id", playerid, rek);

    ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir\n(Tgl/Bulan/Tahun)\nMisal : 15/04/1998", "Enter", "Batal");
    return 1;
}

public:BankRek(playerid, brek)
{
    if (cache_num_rows() > 0)
    {
        //Rekening Exist
        new query[128], rand = RandomEx(11111, 99999);
        new rek = rand + PlayerData[playerid][pID];
        mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
        mysql_tquery(g_SQL, query, "BankRek", "is", playerid, rek);
        SendInfoMessage(playerid, "Your Bank rekening number is same with someone. We will research new.");
    }
    else
    {
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET brek='%d' WHERE reg_id=%d", brek, PlayerData[playerid][pID]);
        mysql_tquery(g_SQL, query);
        PlayerData[playerid][pBankRek] = brek;
    }
    return true;
}

public:PhoneNumber(playerid, phone)
{
    if (cache_num_rows() > 0)
    {
        //Rekening Exist
        new query[128], rand = RandomEx(1111, 9888);
        new phones = rand + PlayerData[playerid][pID];
        mysql_format(g_SQL, query, sizeof(query), "SELECT phone FROM players WHERE phone='%d'", phones);
        mysql_tquery(g_SQL, query, "PhoneNumber", "is", playerid, phones);
        SendInfoMessage(playerid, "Your Phone number is same with someone. We will research new.");
    }
    else
    {
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET phone='%d' WHERE reg_id=%d", phone, PlayerData[playerid][pID]);
        mysql_tquery(g_SQL, query);
        PlayerData[playerid][pPhone] = phone;
    }
    return true;
}

public:OnLoginTimeout(playerid)
{
    PlayerData[playerid][LoginTimer] = 0;

    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have been kicked for taking too long to login successfully to your account.", "Okay", "");
    KickEx(playerid);
    return 1;
}


public:_KickPlayerDelayed(playerid)
{
    Kick(playerid);
    return 1;
}

public:SafeLogin(playerid)
{
    // Main Menu Features.
    Player_SpawnCamera(playerid);

    // Checking
    SQL_CheckAccount(playerid);
}

//---------[ Textdraw ]----------

// Info textdraw timer for hiding the textdraw
public:InfoTD_MSG(playerid, ms_time, const text[])
{
    if (IsValidTimer(playerInfoTD[playerid]))
    {
        PlayerTextDrawHide(playerid, InfoTD[playerid]);
        KillTimer(playerInfoTD[playerid]);
    }

    PlayerTextDrawSetString(playerid, InfoTD[playerid], text);
    PlayerTextDrawShow(playerid, InfoTD[playerid]);
    playerInfoTD[playerid] = SetTimerEx("InfoTD_Hide", ms_time, false, "i", playerid);
}

public:InfoTD_Hide(playerid)
{
    playerInfoTD[playerid] = -1;
    PlayerTextDrawHide(playerid, InfoTD[playerid]);
}

//---------[ Twitter Function ]---------
public:ChangeTwitterName(playerid, twname[])
{
    if (cache_num_rows() > 0)
    {
        // Name Exists
        SendErrorMessage(playerid, "Akun "DARK_E"'%s' "GREY_E"telah ada! Harap gunakan yang lain", twname);
    }
    else
    {
        new query[512];
        format(query, sizeof(query), "UPDATE players SET twittername='%e' WHERE reg_id=%d", twname, PlayerData[playerid][pID]);
        mysql_tquery(g_SQL, query);
        format(PlayerData[playerid][pTwittername], MAX_PLAYER_NAME, "%s", twname);
        SendServerMessage(playerid, "You have set your twitter name to %s", twname);
    }
    return true;
}

//---------[Admin Function ]----------

public:a_ChangeAdminName(otherplayer, playerid, nname[])
{
    if (cache_num_rows() > 0)
    {
        // Name Exists
        SendErrorMessage(playerid, "Akun "DARK_E"'%s' "GREY_E"Telah ada! Harap gunakan yang lain", nname);
    }
    else
    {
        new query[512];
        format(query, sizeof(query), "UPDATE players SET adminname='%e' WHERE reg_id=%d", nname, PlayerData[otherplayer][pID]);
        mysql_tquery(g_SQL, query);
        format(PlayerData[otherplayer][pAdminname], MAX_PLAYER_NAME, "%s", nname);
        SendServerMessage(playerid, "You has set admin name player %s to %s", PlayerData[otherplayer][pName], nname);
    }
    return true;
}

public:LoadStats(playerid, PlayersName[])
{
    if (!cache_num_rows())
    {
        SendErrorMessage(playerid, "Account '%s' does not exist.", PlayersName);
    }
    else
    {
        new email[40], admin, helper, level, levelup, vip, viptime, coin, regdate[40], lastlogin[40], money, bmoney, brek,
            jam, menit, detik, gender, age[40], faction, family, warn, job, job2, int, world;
        cache_get_value_index(0, 0, email);
        cache_get_value_index_int(0, 1, admin);
        cache_get_value_index_int(0, 2, helper);
        cache_get_value_index_int(0, 3, level);
        cache_get_value_index_int(0, 4, levelup);
        cache_get_value_index_int(0, 5, vip);
        cache_get_value_index_int(0, 6, viptime);
        cache_get_value_index_int(0, 7, coin);
        cache_get_value_index(0, 8, regdate);
        cache_get_value_index(0, 9, lastlogin);
        cache_get_value_index_int(0, 10, money);
        cache_get_value_index_int(0, 11, bmoney);
        cache_get_value_index_int(0, 12, brek);
        cache_get_value_index_int(0, 13, jam);
        cache_get_value_index_int(0, 14, menit);
        cache_get_value_index_int(0, 15, detik);
        cache_get_value_index_int(0, 16, gender);
        cache_get_value_index(0, 17, age);
        cache_get_value_index_int(0, 18, faction);
        cache_get_value_index_int(0, 19, family);
        cache_get_value_index_int(0, 20, warn);
        cache_get_value_index_int(0, 21, job);
        cache_get_value_index_int(0, 22, job2);
        cache_get_value_index_int(0, 23, int);
        cache_get_value_index_int(0, 24, world);

        new header[248], scoremath = ((level) * 5), fac[24], Cache:checkfamily, gstr[2468], query[128];

        if (faction == 1)
        {
            fac = "San Andreas Police";
        }
        else if (faction == 2)
        {
            fac = "San Andreas Goverment";
        }
        else if (faction == 3)
        {
            fac = "San Andreas Medic";
        }
        else if (faction == 4)
        {
            fac = "San Andreas News";
        }
        else
        {
            fac = "None";
        }

        new name[40];
        if (admin == 1)
        {
            name = ""RED_E"Administrator(1)";
        }
        else if (admin == 2)
        {
            name = ""RED_E"Senior Admin(2)";
        }
        else if (admin == 3)
        {
            name = ""RED_E"Lead Admin(3)";
        }
        else if (admin == 4)
        {
            name = ""RED_E"Head Admin(4)";
        }
        else if (admin == 5)
        {
            name = ""RED_E"Server Owner(5)";
        }
        else if (helper >= 1 && admin == 0)
        {
            name = ""GREEN_E"Helper";
        }
        else
        {
            name = "None";
        }

        new name1[30];
        if (vip == 1)
        {
            name1 = ""LG_E"Regular(1)";
        }
        else if (vip == 2)
        {
            name1 = ""YELLOW_E"Premium(2)";
        }
        else if (vip == 3)
        {
            name1 = ""PURPLE_E"VIP Player(3)";
        }
        else
        {
            name1 = "None";
        }

        format(query, sizeof(query), "SELECT * FROM `familys` WHERE `ID`='%d'", family);
        checkfamily = mysql_query(g_SQL, query);

        new atext[512];

        new boost = PlayerData[playerid][pBooster];
        new boosttime = PlayerData[playerid][pBoostTime];
        if (boost == 1)
        {
            atext = "{7fff00}Yes";
        }
        else
        {
            atext = "{ff0000}No";
        }

        new rows = cache_num_rows(), fname[128];

        if (rows)
        {
            new fam[128];
            cache_get_value_name(0, "name", fam);
            format(fname, 128, fam);
        }
        else
        {
            format(fname, 128, "None");
        }

        format(header, sizeof(header), "Stats:"YELLOW_E"%s"WHITE_E" ("BLUE_E"%s"WHITE_E")", PlayersName, ReturnTime());
        format(gstr, sizeof(gstr), ""RED_E"In Character"WHITE_E"\n");
        format(gstr, sizeof(gstr), "%sGender: [%s] | Money: ["GREEN_E"%s"WHITE_E"] | Bank: ["GREEN_E"%s"WHITE_E"] | Rekening Bank: [%d] | Phone Number: [None]\n", gstr, (gender == 2) ? ("Female") : ("Male"), FormatMoney(money), FormatMoney(bmoney), brek);
        format(gstr, sizeof(gstr), "%sBirdthdate: [%s] | Job: [None] | Job2: [None] | Faction: [%s] | Family: [%s]\n\n", gstr, age, fac, fname);
        format(gstr, sizeof(gstr), "%s"RED_E"Out of Character"WHITE_E"\n", gstr);
        format(gstr, sizeof(gstr), "%sLevel score: [%d/%d] | Email: [%s] | Warning:[%d/10] | Last Login: [%s]\n", gstr, levelup, scoremath, email, warn, lastlogin);
        format(gstr, sizeof(gstr), "%sStaff: [%s"WHITE_E"] | Time Played: [%d hour(s) %d minute(s) %02d second(s)] | Gold Coin: [%d]\n", gstr, name, jam, menit, detik, coin);
        if (vip != 0)
        {
            format(gstr, sizeof(gstr), "%sInterior: [%d] | Virtual World: [%d] | Register Date: [%s] | VIP Level: [%s"WHITE_E"] | VIP Time: [%s] | Roleplay Booster: [%s"WHITE_E"] | Boost Time: [%s]", gstr, int, world, regdate, name1, ReturnTimelapse(gettime(), viptime), boost, ReturnTimelapse(gettime(), boosttime));
        }
        else
        {
            format(gstr, sizeof(gstr), "%sInterior: [%d] | Virtual World: [%d] | Register Date: [%s] | VIP Level: [%s"WHITE_E"] | VIP Time: [None] | Roleplay Booster: [%s"WHITE_E"] | Boost Time: [%s]", gstr, int, world, regdate, name1, boost, ReturnTimelapse(gettime(), boosttime));
        }
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, header, gstr, "Close", "");

        cache_delete(checkfamily);
    }
    return true;
}

public:CheckPlayerIP(playerid, zplayerIP[])
{
    new count = cache_num_rows(), datez, line[248], tstr[64], lstr[128];
    if (count)
    {
        datez = 0;
        line = "";
        format(line, sizeof(line), "Names matching IP: %s:\n\n", zplayerIP);
        for (new i = 0; i != count; i++)
        {
            // Get the name  ache and append it to the dialog content
            cache_get_value_index(i, 0, lstr);
            strcat(line, lstr);
            datez ++;

            if (datez == 5)
                strcat(line, "\n"), datez = 0;
            else
                strcat(line, "\t\t");
        }

        tstr = "{ACB5BA}Aliases for {70CAFA}", strcat(tstr, zplayerIP);
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, tstr, line, "Close", "");
    }
    else
    {
        SendErrorMessage(playerid, "No other accounts from this IP!");
    }
    return 1;
}

public:CheckPlayerIP2(playerid, zplayerIP[])
{
    new rows = cache_num_rows(), datez, line[248], tstr[64], lstr[128];
    if (!rows)
    {
        SendErrorMessage(playerid, "No other accounts from this IP!");
    }
    else
    {
        datez = 0;
        line = "";
        format(line, sizeof(line), "Names matching IP: %s:\n\n", zplayerIP);
        for (new i = 0; i != rows; i++)
        {
            // Get the name from the cache and append it to the dialog content
            cache_get_value_index(i, 0, lstr);
            strcat(line, lstr);
            datez ++;

            if (datez == 5)
                strcat(line, "\n"), datez = 0;
            else
                strcat(line, "\t\t");
        }

        tstr = "{ACB5BA}Aliases for {70CAFA}", strcat(tstr, zplayerIP);
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, tstr, line, "Close", "");
    }
    return 1;
}

public:JailPlayer(playerid)
{
    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
    SetPlayerPositionEx(playerid, -310.64, 1894.41, 34.05, 178.17, 2000);
    SetPlayerInterior(playerid, 10);
    SetPlayerVirtualWorld(playerid, 100);
    SetPlayerWantedLevel(playerid, 0);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    //ResetPlayerWeaponsEx(playerid);
    PlayerData[playerid][pInBiz] = -1;
    PlayerData[playerid][pInHouse] = -1;
    PlayerData[playerid][pInDoor] = -1;
    PlayerData[playerid][pCuffed] = 0;
    PlayerPlaySound(playerid, 1186, 0, 0, 0);
    return true;
}

//-----------[ Banneds Function ]----------

public:OnOBanQueryData(adminid, NameToBan[], banReason[], banTime)
{
    new mstr[512];
    mstr = "";
    if (!cache_num_rows())
    {
        SendErrorMessage(adminid, "Account '%s' does not exist.", NameToBan);
    }
    else
    {
        new datez, PlayerIP[16];
        cache_get_value_index(0, 0, PlayerIP);
        if (banTime != 0)
        {
            datez = gettime() + (banTime * 86400);
            SendServerMessage(adminid, "You have temp-banned %s (IP: %s) from the server.", NameToBan, PlayerIP);
            SendClientMessageToAll(COLOR_RED, "Server: "GREY2_E"Admin %s telah membanned offline player %s selama %d hari. [Reason: %s]", PlayerData[adminid][pAdminname], NameToBan, banTime, banReason);
        }
        else
        {
            SendServerMessage(adminid, "You have permanent-banned %s (IP: %s) from the server.", NameToBan, PlayerIP);
            SendClientMessageToAll(COLOR_RED, "Server: "GREY2_E"Admin %s telah membanned offline player %s secara permanent. [Reason: %s]", PlayerData[adminid][pAdminname], NameToBan, banReason);
        }
        new query[512];
        mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', '%s', '%s', UNIX_TIMESTAMP(), %d)", NameToBan, PlayerIP, PlayerData[adminid][pAdminname], banReason, datez);
        mysql_tquery(g_SQL, query);
    }
    return true;
}


//-------------[ Player Update Function ]----------
stock GetName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

public:DragUpdate(playerid, targetid)
{
    if (PlayerData[targetid][pDragged] && PlayerData[targetid][pDraggedBy] == playerid)
    {
        static Float:fX,
               Float:fY,
               Float:fZ,
               Float:fAngle;

        GetPlayerPos(playerid, fX, fY, fZ);
        GetPlayerFacingAngle(playerid, fAngle);

        fX -= 3.0 * floatsin(-fAngle, degrees);
        fY -= 3.0 * floatcos(-fAngle, degrees);

        SetPlayerPos(targetid, fX, fY, fZ);
        SetPlayerInterior(targetid, GetPlayerInterior(playerid));
        SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
        //ApplyAnimation(targetid, "PED", "BIKE_fall_off", 4.1, false, true, true, true, 0, SYNC_ALL);
        ApplyAnimation(targetid, "PED", "WALK_civi", 4.1, true, true, true, true, 1);
    }
    return 1;
}

public:UnfreezeSleep(playerid)
{
    TogglePlayerControllable(playerid, true);
    PlayerData[playerid][pEnergy] = 100;
    PlayerData[playerid][pHunger] -= 3;
    ClearAnimations(playerid);
    StopLoopingAnim(playerid);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    InfoTD_MSG(playerid, 3000, "Sleeping Done!");
    return 1;
}

public:RefullCar(playerid, vehicleid)
{
    if (!IsPlayerConnected(playerid)) return 0;
    //if(!IsValidVehicle(vehicleid)) return 0;
    if (!IsValidTimer(PlayerData[playerid][pActivity])) return 0;
    if (GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
    {
        if (PlayerData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
        {
            new fuels = GetVehicleFuel(vehicleid);

            SetVehicleFuel(vehicleid, fuels + 300);
            InfoTD_MSG(playerid, 8000, "Refulling done!");
            //SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has successfully refulling the vehicle.", ReturnName(playerid));
            KillTimer(PlayerData[playerid][pActivity]);
            PlayerData[playerid][pActivityTime] = 0;
            HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
            PlayerTextDrawHide(playerid, ActiveTD[playerid]);
        }
        else if (PlayerData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
        {
            PlayerData[playerid][pActivityTime] += 5;
            SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
        }
        else
        {
            SendErrorMessage(playerid, "Refulling fail! Anda tidak berada didekat kendaraan tersebut!");
            KillTimer(PlayerData[playerid][pActivity]);
            PlayerData[playerid][pActivityTime] = 0;
            HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
            PlayerTextDrawHide(playerid, ActiveTD[playerid]);
        }
    }
    else
    {
        SendErrorMessage(playerid, "Refulling fail! Anda tidak berada didekat kendaraan tersebut!");
        KillTimer(PlayerData[playerid][pActivity]);
        PlayerData[playerid][pActivityTime] = 0;
        HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
        return 1;
    }
    return 1;
}

//Bank
public:SearchRek(playerid, rek)
{
    if (!cache_num_rows())
    {
        // Rekening tidak ada
        SendErrorMessage(playerid, "Rekening bank "YELLOW_E"'%d' "WHITE_E"tidak terdaftar!", rek);
        PlayerData[playerid][pTransfer] = 0;

    }
    else
    {
        // Proceed
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "SELECT username,brek FROM players WHERE brek='%d'", rek);
        mysql_tquery(g_SQL, query, "SearchRek2", "id", playerid, rek);
    }
}

public:SearchRek2(playerid, rek)
{
    if (cache_num_rows())
    {
        new name[128], brek, mstr[128];
        cache_get_value_index(0, 0, name);
        cache_get_value_index_int(0, 1, brek);

        //format(PlayerData[playerid][pTransferName], 128, "%s" name);
        PlayerData[playerid][pTransferName] = name;
        PlayerData[playerid][pTransferRek] = brek;
        format(mstr, sizeof(mstr), ""WHITE_E"No Rek Target: "YELLOW_E"%d\n"WHITE_E"Nama Target: "YELLOW_E"%s\n"WHITE_E"Jumlah: "GREEN_E"%s\n\n"WHITE_E"Anda yakin akan melanjutkan mentransfer?", brek, name, FormatMoney(PlayerData[playerid][pTransfer]));
        ShowPlayerDialog(playerid, DIALOG_BANKCONFIRM, DIALOG_STYLE_MSGBOX, ""LB_E"Bank", mstr, "Transfer", "Cancel");
    }
    return true;
}

//----------[ JOB FUNCTION ]-------------

//Server Timer
public:pCountDown()
{
    Count--;
    if (0 >= Count)
    {
        Count = -1;
        KillTimer(countTimer);
        foreach (new ii : Player)
        {
            if (showCD[ii] == 1)
            {
                GameTextForPlayer(ii, "~w~GO~r~!~g~!~b~!", 2500, 6);
                PlayerPlaySound(ii, 1057, 0, 0, 0);
                showCD[ii] = 0;
                if (IsAtEvent[ii] == 1)
                {
                    TogglePlayerControllable(ii, true);
                }
            }
        }
    }
    else
    {
        foreach (new ii : Player)
        {
            if (showCD[ii] == 1)
            {
                GameTextForPlayer(ii, CountText[Count - 1], 2500, 6);
                PlayerPlaySound(ii, 1056, 0, 0, 0);
            }
        }
    }
    return 1;
}


//----------[ Other Function ]-----------

public:SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z, Float:a)
{
    if (!IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
        return 0;

    PlayerData[playerid][pFreeze] = 0;
    SetPlayerPos(playerid, x, y, z);
    SetPlayerFacingAngle(playerid, a);
    TogglePlayerControllable(playerid, true);
    return 1;
}

public:SetVehicleToUnfreeze(playerid, vehicleid, Float:x, Float:y, Float:z, Float:a)
{
    if (!IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
        return 0;

    PlayerData[playerid][pFreeze] = 0;
    SetVehiclePos(vehicleid, x, y, z);
    SetVehicleZAngle(vehicleid, a);
    TogglePlayerControllable(playerid, true);
    return 1;
}
