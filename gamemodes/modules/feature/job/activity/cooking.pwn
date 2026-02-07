// Cooking System ( in house )
// by Fann

// accelerated with Cooking Ability (player skill)

#include <YSI_Coding\y_hooks>

enum e_cookingingredient_data
{
    cCookingCount,
    cName1[128],
    cName2[128],
    cName3[128],
    cName4[128]
};

new 
    CookingTime[MAX_PLAYERS],
    playerCook[MAX_PLAYERS]
;

new
    const CookMenu[][128] =
    {
        "Roasted Potato",
        "Potato Spread",
        "Bowl of Cooked Rice",
        "French Fries"
    },
    CookIngre[][e_cookingingredient_data] =
    {
        {1, "Potato", "", "", ""},
        {1, "Potato", "Wheat", "", ""},
        {1, "Wheat", "", "", ""},
        {10, "Potato", "", "", ""}
    },
    CookIngreCount[][4] =
    {
        {2, 0, 0, 0},
        {2, 2, 0, 0},
        {2, 0, 0, 0},
        {5, 0, 0, 0}
    }
;

Cook_Menu(playerid) 
{
    new fanstr[5000];
    forex(fan, MAX_COOK)
    {
        format(fanstr, sizeof(fanstr), "%s%s\n", fanstr, CookMenu[fan]);
    }

    ShowPlayerDialog(playerid, DIALOG_COOKING, DIALOG_STYLE_LIST, "Cooking", fanstr, "See Ingredients", "Back");
    return 1;
}

Cook_Ingre(cid)
{
    new fanstr[729];
    format(fanstr, sizeof(fanstr), "%s%d %s\n", fanstr, CookIngreCount[cid][0], CookIngre[cid][cName1]);
    if(!isnull(CookIngre[cid][cName2])) format(fanstr, sizeof(fanstr), "%s%d %s\n", fanstr, CookIngreCount[cid][1], CookIngre[cid][cName2]);
    if(!isnull(CookIngre[cid][cName3])) format(fanstr, sizeof(fanstr), "%s%d %s\n", fanstr, CookIngreCount[cid][2], CookIngre[cid][cName3]);
    if(!isnull(CookIngre[cid][cName4])) format(fanstr, sizeof(fanstr), "%s%d %s\n", fanstr, CookIngreCount[cid][3], CookIngre[cid][cName4]);
    return fanstr;
}

Cook_Start(playerid, cid)
{
    if(cid < 0 || cid > MAX_COOK-1)
        return 0;

    TogglePlayerControllable(playerid, false);
    CookingTime[playerid] = gettime();
    SendInfoMessage(playerid, "You have been started cooking {ffff00}%s{ffffff}.", CookMenu[cid]);
    ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, true, false, false, false, 0, SYNC_ALL);
    PlayerData[playerid][pActivityTime] = 0;
    PlayerData[playerid][pCooking] = SetTimerEx("CookingFann", 1000, true, "id", playerid, cid);
    PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Cooking %s...", CookMenu[cid]);
    PlayerTextDrawShow(playerid, ActiveTD[playerid]);
    ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
    return 1;
}

public:CookingFann(playerid, cid)
{
    if(!IsValidTimer(PlayerData[playerid][pCooking]))
        return 0;

    if(PlayerData[playerid][pActivityTime] >= 100)
    {
        ClearAnimations(playerid, SYNC_ALL);
        TogglePlayerControllable(playerid, true);
        KillTimer(PlayerData[playerid][pCooking]);
        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
        HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);

        if(Inventory_Add(playerid, CookMenu[cid], CookIngre[cid][cCookingCount]) == -1)
            return 1;

        new rand[4], ingre[4], skill_level = Skill_GetLevel(playerid, "Cooking Ability");
        forex(fan, sizeof(rand)) if(CookIngreCount[cid][fan] != 0)
        {
            ingre[fan] = CookIngreCount[cid][fan];
            new increase = (skill_level * 10) / 2;
            rand[fan] = (random(100)+1) + increase;
            if(skill_level != 1 && rand[fan] > 80)
            {
                switch((random(100)+1)+increase)
                {
                    case 1..50: 
                    {
                        if(ingre[fan] > 1) ingre[fan]--;
                        else ingre[fan] = clamp(ingre[fan], 1, CookIngreCount[cid][fan]);
                    }
                    case 100: ingre[fan] = 0; 
                }
                ingre[fan] = max(1, ingre[fan]);
            }
        }
        Inventory_Remove(playerid, CookIngre[cid][cName1], ingre[0]);
        if(!isnull(CookIngre[cid][cName2])) Inventory_Remove(playerid, CookIngre[cid][cName2], ingre[1]);
        if(!isnull(CookIngre[cid][cName3])) Inventory_Remove(playerid, CookIngre[cid][cName3], ingre[2]);
        if(!isnull(CookIngre[cid][cName4])) Inventory_Remove(playerid, CookIngre[cid][cName4], ingre[3]);

        new fanstr[5000], bool:ada = false;
        format(fanstr, sizeof(fanstr), "Pemakaian Bahan-Bahan yang berubah :\n");
        forex(fan, 4) if(ingre[fan] != CookIngreCount[cid][fan])
        {
            format(fanstr, sizeof(fanstr), "%s\n"W"%s : {ff0000}%d {ffffff}-> {00ff00}%d", fanstr, CookIngre[cid][e_cookingingredient_data:fan], CookIngreCount[cid][fan], ingre[fan]);
            ada = true;
        }

        if(ada) ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Cooking", fanstr, "OKAY", "");

        Skill_Earned(playerid, "Cooking Ability", random(2)+1);
        PlayerPlaySound(playerid, SOUND_CAR_MOD);
        SendInfoMessage(playerid, "You have cooked {ffff00}%d %s{ffffff} for %s.", CookIngre[cid][cCookingCount], CookMenu[cid], ReturnDuration(gettime() - CookingTime[playerid], false));
        CookingTime[playerid] = 0;
    }
    else 
    {
        PlayerData[playerid][pActivityTime] += 1+random(Skill_GetLevel(playerid, "Cooking Ability"))+1;
        SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
    }
    return 1;
}

CMD:cook(playerid, params[]) 
{
    if(!IsPlayerFann(playerid))
    {
        new houseid = -1;
        foreach(new hid : Houses) if(IsPlayerInRangeOfPoint(playerid, 1.0, hData[hid][hKitchenposX], hData[hid][hKitchenposY], hData[hid][hKitchenposZ]))
        {
            houseid = hid;
            break;
        }

        if(houseid == -1)
            return SendErrorMessage(playerid, "You must near to kitchen");
    }

    Cook_Menu(playerid);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    CookingTime[playerid] = 0;
    playerCook[playerid] = -1;

    if(IsValidTimer(PlayerData[playerid][pCooking]))
        KillTimer(PlayerData[playerid][pCooking]);

    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    CookingTime[playerid] = 0;
    playerCook[playerid] = -1;

    if(IsValidTimer(PlayerData[playerid][pCooking]))
        KillTimer(PlayerData[playerid][pCooking]);

    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_COOKING)
    {
        if(response) 
        {
            new fanstr[5000];
            strcat(fanstr, "You need ingredients :\n");
            strcat(fanstr, Cook_Ingre(listitem));
            ShowPlayerDialog(playerid, DIALOG_COOKING_INGREDIENT, DIALOG_STYLE_MSGBOX, "Cook Ingredient(s)", fanstr, "Start Cook", "Back");
            playerCook[playerid] = listitem;
        }
    }
    if(dialogid == DIALOG_COOKING_INGREDIENT)
    {
        if(response) 
        {
            new cid = playerCook[playerid];
            if(Inventory_Has(playerid, CookIngre[cid][cName1]) < CookIngreCount[cid][0]) 
                return SendErrorMessage(playerid, "Your %s isn't enough!", CookIngre[cid][cName1]);

            if(!isnull(CookIngre[cid][cName2]) && Inventory_Has(playerid, CookIngre[cid][cName2]) < CookIngreCount[cid][1]) 
                return SendErrorMessage(playerid, "Your %s isn't enough!", CookIngre[cid][cName2]);

            if(!isnull(CookIngre[cid][cName3]) && Inventory_Has(playerid, CookIngre[cid][cName3]) < CookIngreCount[cid][2]) 
                return SendErrorMessage(playerid, "Your %s isn't enough!", CookIngre[cid][cName3]);

            if(!isnull(CookIngre[cid][cName4]) && Inventory_Has(playerid, CookIngre[cid][cName4]) < CookIngreCount[cid][3]) 
                return SendErrorMessage(playerid, "Your %s isn't enough!", CookIngre[cid][cName4]);

            Cook_Start(playerid, playerCook[playerid]);
        }
        else 
            Cook_Menu(playerid);

        playerCook[playerid] = -1;
    }
    return 1;
}