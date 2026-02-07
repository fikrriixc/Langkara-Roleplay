public:OnPlayerVerifyPassword(playerid, bool:success)
{
    if(success)
    {
        UcpData[playerid][uLogged] = 1;
        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "SELECT `username`, `level`, `last_login` FROM `players` WHERE `ucp` = '%e' LIMIT 8;", SQL_EscapeString(UcpData[playerid][uUsername]));
        mysql_tquery(g_SQL, query, "OnCharacterLoaded", "d", playerid);
    }
    else
    {
        if (++UcpData[playerid][uLoginAttempts] >= 3) 
        {
            UcpData[playerid][uLoginAttempts] = 0;
            SendErrorMessage(playerid, "Anda telah memasukkan password yang salah sebanyak 3 kali.");
            SendErrorMessage(playerid, "Anda akan dikick.");
            KickEx(playerid);
        } 
        else 
        {
            new fan[500];
            format(fan, sizeof(fan), ""WHITE_E"Selamat Datang di {0077FF}HopePride"WHITE_E", %s!\n\nNama UCP: %s\nStatus: "GREEN_E"Sudah Terdaftar"WHITE_E"\nVersion: "GREY_E""TEXT_VERSION""WHITE_E"\n\nPassword salah! Attempt: %d/3:", UcpData[playerid][uUsername], UcpData[playerid][uUsername], UcpData[playerid][uLoginAttempts]);
            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", fan, "Masuk", "");
        }
    }
    return 1;
}

public:OnPlayerPasswordAdd(playerid, hashid)
{
    new hash[BCRYPT_HASH_LENGTH];
    bcrypt_get_hash(hash);
    GetPlayerIp(playerid, UcpData[playerid][uIP], 16);
    GetPlayerName(playerid, UcpData[playerid][uUsername], MAX_PLAYER_NAME + 1);
    format(UcpData[playerid][uPassword], BCRYPT_HASH_LENGTH, hash);

    new query[500];
    mysql_format(g_SQL, query,sizeof(query), "UPDATE ucp SET password = '%s', ip = '%s' WHERE username = '%s'", SQL_EscapeString(UcpData[playerid][uPassword]), SQL_EscapeString(UcpData[playerid][uIP]), SQL_EscapeString(UcpData[playerid][uUsername]));
    mysql_query(g_SQL, query);
    
    format(query, sizeof(query), "SELECT `username` FROM `players` WHERE `ucp` = '%s'", SQL_EscapeString(UcpData[playerid][uUsername]));
    mysql_tquery(g_SQL, query, "OnCharacterLoaded", "d", playerid); 
    return 1;
}

public:OnPlayerChangePassword(playerid, hashid)
{
    new hash[BCRYPT_HASH_LENGTH];
    bcrypt_get_hash(hash);
    format(UcpData[playerid][uPassword], sizeof(hash), hash);

    new query[512];
    mysql_format(g_SQL, query, sizeof(query), "UPDATE ucp SET password='%s' WHERE username='%d'", SQL_EscapeString(UcpData[playerid][uPassword]), UcpData[playerid][uUsername]);
    mysql_tquery(g_SQL, query);
    SendServerMessage(playerid, "Your password has been updated!");
    return 1;
}

public:OnPlayerChangePlayerPassword(playerid, hashid)
{
    new cPlayer[MAX_PLAYER_NAME], newpass[20], hash[BCRYPT_COST];
    GetPVarString(playerid, "cPlayer", cPlayer);
	GetPVarString(playerid, "newpass", newpass);
    bcrypt_get_hash(hash);

    new query[512];
    SendServerMessage(playerid, "Password for %s has been set to \"%s\"", cPlayer, newpass);

    mysql_format(g_SQL, query, sizeof(query), "UPDATE ucp SET password='%s' WHERE username='%s'", SQL_EscapeString(hash), SQL_EscapeString(cPlayer));
    mysql_tquery(g_SQL, query);
    return 1;
}