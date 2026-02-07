// Fishing Activity
// by Fann

#include <YSI_Coding\y_hooks>

new
    Float:fishProgress[MAX_PLAYERS],
    Float:luckProgress[MAX_PLAYERS],
    Float:luckCatch[MAX_PLAYERS],
    bool:luckUp[MAX_PLAYERS],
    bool:fishing[MAX_PLAYERS],
    bool:counter[MAX_PLAYERS],
    fishTimer[MAX_PLAYERS],
    fishCounter[MAX_PLAYERS],
    bool:rodAttached[MAX_PLAYERS]
;

Fishing_TextDraw(playerid, bool:luck = false, bool:show = true)
{
    if(show)
    {
        if(luck)
        {
            forex(fann, 5) PlayerTextDrawShow(playerid, fishingBarTextDraw[playerid][fann]);
            PlayerTextDrawShow(playerid, fishingBarProgress[playerid]);
            PlayerTextDrawShow(playerid, fishingBarLuck[playerid]);
        }
        else
        {
            forex(fann, 15) PlayerTextDrawShow(playerid, fishingTextDraw[playerid][fann]);
        }
    }
    else
    {
        if(luck)
        {
            forex(fann, 5) PlayerTextDrawHide(playerid, fishingBarTextDraw[playerid][fann]);
            PlayerTextDrawHide(playerid, fishingBarProgress[playerid]);
            PlayerTextDrawHide(playerid, fishingBarLuck[playerid]);
        }
        else
        {
            forex(fann, 15) PlayerTextDrawHide(playerid, fishingTextDraw[playerid][fann]);
        }
    }
}

Fishing_Start(playerid, bool:fcounter)
{
    Fishing_TextDraw(playerid, fcounter, true);
    luckUp[playerid] = true;
    luckProgress[playerid] = 
    luckCatch[playerid] = 0;
    PlayerTextDrawTextSize(playerid, fishingBarProgress[playerid], 5.0, -55.0 * 0.0 / 100.0);
    fishTimer[playerid] = SetTimerEx("fish_counter", 50, true, "d", playerid);
}

public:fish_counter(playerid)
{
    if(luckUp[playerid])
    {
        luckProgress[playerid] += 10;
        luckCatch[playerid] += 0.2;
        if(luckProgress[playerid] >= 100)
        {
            luckUp[playerid] = false;
        }
    }
    else 
    {
        luckProgress[playerid] -= 10;
        luckCatch[playerid] -= 0.2;
        if(luckProgress[playerid] <= 0)
        {
            luckUp[playerid] = true;
        }
    }

    PlayerTextDrawSetString(playerid, fishingBarLuck[playerid], "x%.1f%", luckCatch[playerid]);
    PlayerTextDrawTextSize(playerid, fishingBarProgress[playerid], 5.0, -55.0 * luckProgress[playerid] / 100.0);

    PlayerTextDrawShow(playerid, fishingBarProgress[playerid]);
    return 1;
}

public:fish_catching(playerid)
{
    fishProgress[playerid] -= 5.0;
    PlayerTextDrawSetString(playerid, fishingTextDraw[playerid][13], "Click Fast!");
    PlayerTextDrawSetString(playerid, fishingTextDraw[playerid][14], "(%03d)", fishCounter[playerid]);
    PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][5], -111.0 * fishProgress[playerid] / 100.0, 21);
    PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][6], 111.0 * fishProgress[playerid] / 100.0, 21);

    PlayerTextDrawShow(playerid, fishingTextDraw[playerid][5]);
    PlayerTextDrawShow(playerid, fishingTextDraw[playerid][6]);

    if(fishProgress[playerid] >= 100.0)
    {
        KillTimer(fishTimer[playerid]);
        Fishing_TextDraw(playerid, false, false);
        Fishing_TextDraw(playerid, true, false);

        fishCounter[playerid] = 0;
        fishProgress[playerid] = 
        luckProgress[playerid] = 0;
        fishing[playerid] = false;

        Fishing_Done(playerid);
    }
    else if(fishProgress[playerid] <= 0.0)
    {
        KillTimer(fishTimer[playerid]);
        Fishing_TextDraw(playerid, false, false);
        Fishing_TextDraw(playerid, true, false);

        fishCounter[playerid] = 0;
        fishProgress[playerid] = 
        luckProgress[playerid] = 0;
        fishing[playerid] = false;

        TogglePlayerControllable(playerid, true);
        ClearAnimations(playerid);

        Inventory_Remove(playerid, "Worm");

        SendCustomMessage(playerid, "FISH", "Kamu gagal menangkap ikan, dan umpannya terbuang!");
    }
    return 1;
}

hook OnPlayerConnect(playerid) 
{
    fishCounter[playerid] = 0;
    fishProgress[playerid] = 
    luckProgress[playerid] = 0;
    fishing[playerid] = false;

    if(IsValidTimer(fishTimer[playerid])) KillTimer(fishTimer[playerid]);
    Fishing_TextDraw(playerid, false, false);
    Fishing_TextDraw(playerid, true, false);
    return 1;
}

hook OnPlayerUpdate(playerid) 
{
    if(IsValidTimer(fishTimer[playerid]))
    {
        if(!fishing[playerid]) 
        {
            KillTimer(fishTimer[playerid]);
            SendServerMessage(playerid, "You're detected was fishing, now you're don't!");
        }
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
    if((newkeys & KEY_YES) && fishing[playerid])
    {
        if(!counter[playerid])
        {
            fishProgress[playerid] += 15.0;
            fishCounter[playerid]++;
        }
        else
        {
            KillTimer(fishTimer[playerid]);
            
            PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][5], -111.0 * 50.0 / 100.0, 21);
            PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][6], 111.0 * 50.0 / 100.0, 21);

            Fishing_TextDraw(playerid, false, true);
            Fishing_TextDraw(playerid, true, false);

            new fishingLevel = Skill_GetLevel(playerid, "Fishing Ability");
            if (fishingLevel <= 1) fishingLevel = 0; // no reduction for level 0 and 1

            new baseSeconds = 90;
            new reducedSeconds = baseSeconds - (fishingLevel * 10 - 10); // 1 level = 10 seconds reduction

            fishProgress[playerid] = 50.0;
            if(reducedSeconds != 0)
            {
                fishTimer[playerid] = SetTimerEx("fish_wait", 200, true, "d", playerid);
                PlayerData[playerid][pActivity] = SetTimerEx("Fishing_Catching", reducedSeconds * 1000, false, "i", playerid);
                PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Memancing...");
                PlayerTextDrawSetString(playerid, fishingTextDraw[playerid][13], " Wait for Fish...");
                PlayerTextDrawHide(playerid, fishingTextDraw[playerid][14]);

                if(IsPlayerFann(playerid))
                    GameTextForPlayer(playerid,"Memancing~n~Fishing Time: %d seconds", 5000, 3, reducedSeconds);
            }
            else 
            {
                fishCounter[playerid] = 0;
                counter[playerid] = false;
                fishTimer[playerid] = SetTimerEx("fish_catching", 200, true, "d", playerid);
                SendCustomMessage(playerid, "FISH", "You got %.1f percent chance of lucky", luckCatch[playerid]);
            }
            ApplyAnimation(playerid, "SWORD", "sword_block", 50.0, false, true, false, true, 1);
        }
    }
    return 1;
}

public:fish_wait(playerid) 
{
    if(luckUp[playerid])
    {
        fishProgress[playerid] += random(10)+1;
        if(fishProgress[playerid] >= 100)
        {
            luckUp[playerid] = false;
        }
    }
    else 
    {
        fishProgress[playerid] -= random(10)+1;
        if(fishProgress[playerid] <= 0)
        {
            luckUp[playerid] = true;
        }
    }
    PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][5], -111.0 * fishProgress[playerid] / 100.0, 21);
    PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][6], 111.0 * fishProgress[playerid] / 100.0, 21);

    PlayerTextDrawShow(playerid, fishingTextDraw[playerid][5]);
    PlayerTextDrawShow(playerid, fishingTextDraw[playerid][6]);
}

public:Fishing_Catching(playerid)
{
    if(IsValidTimer(fishTimer[playerid]))
        KillTimer(fishTimer[playerid]);

    PlayerPlaySound(playerid, SOUND_CHECKPOINT);
    counter[playerid] = false;
    fishCounter[playerid] = 0;
    fishTimer[playerid] = SetTimerEx("fish_catching", 200, true, "d", playerid);
    PlayerTextDrawShow(playerid, fishingTextDraw[playerid][14]);
    SendCustomMessage(playerid, "FISH", "You got %.1f percent chance of lucky", luckCatch[playerid]);
    return 1;
}

IsPlayerInWater(playerid)
{
	new Float:x,Float:y,Float:pz;
	GetPlayerPos(playerid,x,y,pz);
	if (
 	(IsPlayerInArea(playerid, 2032.1371, 1841.2656, 1703.1653, 1467.1099) && pz <= 9.0484) //lv piratenschiff
  	|| (IsPlayerInArea(playerid, 2109.0725, 2065.8232, 1962.5355, 10.8547) && pz <= 10.0792) //lv visage
  	|| (IsPlayerInArea(playerid, -492.5810, -1424.7122, 2836.8284, 2001.8235) && pz <= 41.06) //lv staucamm
  	|| (IsPlayerInArea(playerid, -2675.1492, -2762.1792, -413.3973, -514.3894) && pz <= 4.24) //sf südwesten kleiner teich
  	|| (IsPlayerInArea(playerid, -453.9256, -825.7167, -1869.9600, -2072.8215) && pz <= 5.72) //sf gammel teich
  	|| (IsPlayerInArea(playerid, 1281.0251, 1202.2368, -2346.7451, -2414.4492) && pz <= 9.3145) //ls neben dem airport
  	|| (IsPlayerInArea(playerid, 2012.6154, 1928.9028, -1178.6207, -1221.4043) && pz <= 18.45) //ls mitte teich
  	|| (IsPlayerInArea(playerid, 2326.4858, 2295.7471, -1400.2797, -1431.1266) && pz <= 22.615) //ls weiter südöstlich
  	|| (IsPlayerInArea(playerid, 2550.0454, 2513.7588, 1583.3751, 1553.0753) && pz <= 9.4171) //lv pool östlich
  	|| (IsPlayerInArea(playerid, 1102.3634, 1087.3705, -663.1653, -682.5446) && pz <= 112.45) //ls pool nordwestlich
  	|| (IsPlayerInArea(playerid, 1287.7906, 1270.4369, -801.3882, -810.0527) && pz <= 87.123) //pool bei maddog's haus oben
  	|| (pz < 1.5)
	)
	{
		return 1;
	}
	return 0;
}

IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (x > minx && x < maxx && y > miny && y < maxy) return 1;
	return 0;
}

IsAtFishPlace(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(IsPlayerInRangeOfPoint(playerid,1.0,403.8266,-2088.7598,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,398.7553,-2088.7490,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,396.2197,-2088.6692,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,391.1094,-2088.7976,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,383.4157,-2088.7849,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,374.9598,-2088.7979,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,369.8107,-2088.7927,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,367.3637,-2088.7925,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,362.2244,-2088.7981,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,354.5382,-2088.7979,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInWater(playerid))
		{
			return 1;
		}
	}
	return 0;
}

CMD:fishlist(playerid, params[])
{
	if(!IsPlayerFann(playerid))
		return PermissionError(playerid);

    new fanstr[5000];
    format(fanstr, sizeof(fanstr), "Fish Name\tRarity\tMin - Max Weight\tRange Value\n");
    forex(i, sizeof(FishingData))
    {
        strcat(fanstr, sprintf(""W"%s\t%s\t%.1f - %.1f kg\t{00ff00}%s\n", FishingData[i][fName], Fish_RarityWithColor(FishingData[i][fName]), FishingData[i][fMinWeight], FishingData[i][fMaxWeight], FormatMoney(FishingData[i][fSellPrice])), sizeof(fanstr));
    }

    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Fish List", fanstr, "Close", "");
    return 1;
}

CMD:myfish(playerid, params[])
{
    Fish_PlayerShow(playerid, 0);
    return 1;
}

CMD:sellfish(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 1.0, LOC_SELLFISH))
        return SendErrorMessage(playerid, "Kamu tidak berada di Fish Factory");

    Fish_PlayerShow(playerid, 1);
    return 1;
}

CMD:attachrod(playerid, params[])
{
    if(!Inventory_Has(playerid, "Fishing Rod"))
        return SendErrorMessage(playerid, "Kamu tidak memiliki pancingan!");

    if(PlayerData[playerid][pHoldingFish])
        return SendErrorMessage(playerid, "You cannot start while you are flexing!");

    rodAttached[playerid] = !rodAttached[playerid];
    if(rodAttached[playerid])
    {
        SetPlayerAttachedObject(playerid, 9, 18632, 6, 0.079376, 0.037070, 0.007706, 181.482910, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000); 
        SendInfoMessage(playerid, "You're now holding {ffff00}Fishing Rod");
    }
    else
    {
        ClearAnimations(playerid, SYNC_ALL);
        RemovePlayerAttachedObject(playerid, 9);
        SendInfoMessage(playerid, "You're now not holding {ffff00}Fishing Rod");
    }
    return 1;
}

CMD:fish(playerid, params[])
{
    if(!IsAtFishPlace(playerid))
        return SendErrorMessage(playerid, "Kamu tidak didekat air!");

    if(!Inventory_Has(playerid, "Fishing Rod"))
        return SendErrorMessage(playerid, "Kamu tidak memiliki pancingan!");
        
    if(!Inventory_Has(playerid, "Worm"))
        return SendErrorMessage(playerid, "Kamu tidak memiliki umpan untuk memancing!");

    if(IsValidTimer(fishTimer[playerid]))
		return SendErrorMessage(playerid, "Kamu sedang memancing!");

    if(!rodAttached[playerid])
        return SendErrorMessage(playerid, "You are not holding fishing rod!");

    if(PlayerData[playerid][pHoldingFish])
        return SendErrorMessage(playerid, "You cannot start while you are flexing!");

    fishing[playerid] = true;
    counter[playerid] = true;
    Fishing_Start(playerid, true);
    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s get ready to swings fishing rod and starts to wait for fish", ReturnName(playerid));
    TogglePlayerControllable(playerid, false);
    return 1;
}

public:Fishing_Done(playerid)
{
    PlayerData[playerid][pActivity] = 0;
    TogglePlayerControllable(playerid, true);
    ClearAnimations(playerid);

    if(!IsAtFishPlace(playerid))
    {
        SendErrorMessage(playerid, "Kamu tidak di dekat Air!");
        return 1;
    }

    

    new chance = Skill_IncreasePercentBySkillLevel(playerid, "Fishing Ability", 50); // base 50% chance to catch fish
    new randomValue = floatround(luckCatch[playerid] + random(3)) + random(100) + 1; // random value between 1 and 100 plus lucky chance
    new fishIndex = -1;

    if(randomValue <= chance)
    {
        new bonusChance = 0;
        if(Skill_GetLevel(playerid, "Fishing Ability") <= 1) bonusChance = 0;
        else bonusChance = (floatround(luckCatch[playerid]) + Skill_GetLevel(playerid, "Fishing Ability") * 2) * (random(5)+1);

        new skillexp;
        randomValue = random(100) + 1 + bonusChance; 
        if(randomValue >= 180) // Legendary fish chance
        {
            skillexp = RandomEx(3, 7);
            fishIndex = Fish_RandomFishByRarity("Legendary");
        }
        else if(randomValue >= 160) // Epic fish chance
        {
            skillexp = RandomEx(2, 6);
            fishIndex = Fish_RandomFishByRarity("Epic");
        }
        else if(randomValue <= 159 && randomValue >= 120) // Rare fish chance
        {
            skillexp = RandomEx(1, 4);
            fishIndex = Fish_RandomFishByRarity("Rare");
        }
        else if(randomValue <= 119 && randomValue >= 70) // Uncommon fish chance
        {
            skillexp = 1;
            fishIndex = Fish_RandomFishByRarity("Uncommon");
        }
        else
        {
            skillexp = 1;
            fishIndex = Fish_RandomFishByRarity("Common");
        }

        if(IsPlayerFann(playerid))
            GameTextForPlayer(playerid, sprintf("You have got %d percentage chance to catch better fish!~n~You caught a %s!", randomValue, FishingData[fishIndex][fName]), 5000, 3);

        new fishName[32];
        format(fishName, sizeof(fishName), "%s", FishingData[fishIndex][fName]);

        new Float:weight = RandomFloat(FishingData[fishIndex][fMinWeight], FishingData[fishIndex][fMaxWeight], 2);

        Fish_Add(playerid, fishName, weight);
        Inventory_Remove(playerid, "Worm", 1);
        Skill_Earned(playerid, "Fishing Ability", skillexp);
        SendInfoMessage(playerid, "Kamu menangkap %s%s{ffffff} seberat {D1D137}%.2f kg{ffffff}!", Fish_ColorByRarity(fishName), fishName, weight);
    }
    else
    {
        switch(random(3))
        {
            case 0: SendInfoMessage(playerid, "Kamu tidak mendapatkan ikan apapun kali ini.");
            case 1: SendInfoMessage(playerid, "Kamu menangkap sampah dan langsung membuangnya.");
            case 2: 
            {
                SendInfoMessage(playerid, "Kamu menangkap yang terlalu besar, menyebabkan pancingan rusak.");
                Inventory_Remove(playerid, "Fishing Rod");
                Inventory_Remove(playerid, "Worm");
            }
        }
    }
    luckCatch[playerid] = 0;
    return 1;
}