// Loading Screen Function
// fLoadingScreen.inc v1.0 by Fann

LoadingScreen:LoadingObject(playerid)
{
    new Float:pos[4];
    Loop(fan, 4, 0) 
    {
        pos[fan] = PlayerTemp[playerid][temp_voldpos][fan];
        PlayerTemp[playerid][temp_voldpos][fan] = 0.0;
    }

    SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    SetPlayerFacingAngle(playerid, pos[3]);
    return 1;
}

LoadingScreen:LoadingObjectInVehicle(playerid)
{
    new Float:pos[4];
    Loop(fan, 4, 0) 
    {
        pos[fan] = PlayerTemp[playerid][temp_voldpos][fan];
        PlayerTemp[playerid][temp_voldpos][fan] = 0.0;
    }

    SetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);
    SetVehicleZAngle(GetPlayerVehicleID(playerid), pos[3]);
    return 1;
}

LoadingScreen:LoadingAccount(playerid)
{
    SafeLogin(playerid);
    return 1;
}

LoadingScreen:LoadingCharacter(playerid)
{
    if(GetPVarInt(playerid, "playerRegister"))
    {
        SendClientMessage(playerid, ARWIN, "[--------------------------------------------------------------]");
        SendClientMessage(playerid, -1, "Selamat datang dan Selamat Roleplaying!");
        SendClientMessage(playerid, -1, "Gunakan {ffff00}'/starterpack'{ffffff} untuk mengambil benefit.");
        SendClientMessage(playerid, ARWIN, "[--------------------------------------------------------------]");
    }
    else
    {
        SendServerMessage(playerid, "Selamat datang di kota HopePride, %s!", GetName(playerid));
        SendServerMessage(playerid, "Player : {00ff00}%d/%d{ffffff}.", Iter_Count(Player), GetMaxPlayers());
        SendCustomMessage(playerid, "FANN", "Jika perlu bantuan, gunakan : {ff0000}/ask {ffffff}atau {ff0000}/help");
        SendCustomMessage(playerid, "FANN", "Atau ada keluhan, gunakan : {ff0000}/report");
    }

    HBE_Show(playerid, PlayerData[playerid][pHBEMode]);
    return 1;
}