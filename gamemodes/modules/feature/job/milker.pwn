/* Milker Man Job by Fann */

CreateJoinMilkerPoint()
{
    //JOBS
    new strings[128];
    CreateDynamicPickup(1239, 23, 300.1200, 1141.2943, 9.1374, -1);
    format(strings, sizeof(strings), "[Milker Man]\n{ffffff}Jadilah Milker Man disini\n{7fffd4}/getjob /accept job");
    CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 300.1200, 1141.2943, 9.1374, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // pemeras susu

    Cow_Spawn();
}

#if !defined _FANN_COW_DATA
    #error "[JOB\JOB_MILKER.pwn] 'COW.pwn' is missing."
#endif

public:Cow_Squeezed()
{
    forex(cowid, MAX_COW)
    {
        if(FannCowCD[cowid] > 0)
        {
            FannCowCD[cowid]--;
            if(FannCowCD[cowid] == 0)
            {
                Cow_Respawn(cowid);
            }
        }
    }
    return 1;
}

CMD:sellmilk(playerid, params[])
{
    if(PlayerData[playerid][pJob] != 9 && PlayerData[playerid][pJob2] != 9)
        return SendErrorMessage(playerid, "You aren't Milker!");

    new count;
    if(sscanf(params, "d", count))
        return SendSyntaxMessage(playerid, "/sellmilk [amount]");

    if(Inventory_Has(playerid, "Fresh Milk") < count)
        return SendErrorMessage(playerid, "You dont have that much of Fresh Milk!");

    FreshMilk += count;
    Server_MinMoney(FreshMilkPrice*count);
    GivePlayerMoneyEx(playerid, FreshMilkPrice*count);
    Inventory_Remove(playerid, "Fresh Milk", count);
    PlayerData[playerid][pJobTime] = 1200;
    SendInfoMessage(playerid, "You have been sell {ffff00}%d Fresh Milk{ffffff} for {00ff00}%s{ffffff}.", count, FormatMoney(FreshMilkPrice*count));
    return 1;
}

CMD:squeezemilk(playerid, params[])
{
    if(PlayerData[playerid][pJob] != 9 && PlayerData[playerid][pJob2] != 9)
        return SendErrorMessage(playerid, "You aren't Milker!");

    new cowid;
    if((cowid = Cow_PlayerNear(playerid)) == -1)
        return SendErrorMessage(playerid, "You are not near of the cows!");
 
    if(PlayerData[playerid][pActivityTime] > 5)
        return SendErrorMessage(playerid, "Kamu masih memiliki activity progress");

    if(PlayerData[playerid][pJobTime] > 0)
        return SendErrorMessage(playerid, "You must wait %d minute(s) %d second(s) for use this!", PlayerData[playerid][pJobTime] / 60, PlayerData[playerid][pJobTime]);

    if(FannCowCD[cowid] != 0)
        return SendErrorMessage(playerid, "This cow already squeezed, please wait 1 minute!");

    if(Inventory_Has(playerid, "Fresh Milk") >= Inventory_MaxQuantity(playerid, -1, "Fresh Milk"))
        return SendErrorMessage(playerid, "Your Fresh Milk cant more then 10!");

    TogglePlayerControllable(playerid, false);
    ApplyAnimation(playerid,"BOMBER","BOM_Plant", 4.0, true, false, false, true, 0, SYNC_ALL);
    PlayerData[playerid][pProducting] = SetTimerEx("ProgressSqueeze", 1000, true, "id", playerid, cowid);
    PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Squeezing...");
    PlayerTextDrawShow(playerid, ActiveTD[playerid]);
    ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
    return 1;
}

public:ProgressSqueeze(playerid, cowid)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(!IsValidTimer(PlayerData[playerid][pProducting])) return 0;

    if(PlayerData[playerid][pActivityTime] >= 100)
    {
        TogglePlayerControllable(playerid, true);
        KillTimer(PlayerData[playerid][pProducting]);
        PlayerData[playerid][pActivityTime] = 0;
        HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
        ClearAnimations(playerid);

        if(Inventory_Add(playerid, "Fresh Milk") == -1)
            return 1;

        FannCowCD[cowid] = 60; // 1menit
        Cow_Respawn(cowid);
    }
    else if(PlayerData[playerid][pActivityTime] < 100)
    {
        PlayerData[playerid][pActivityTime] += 10;
        SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
        ApplyAnimation(playerid,"BOMBER","BOM_Plant", 4.0, true, false, false, true, 0, SYNC_ALL);
    }
    return 1;
}