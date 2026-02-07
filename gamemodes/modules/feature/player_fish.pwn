// Player Fish (ownable)
// by Fann

enum e_playerfish_data
{
	fID,
	fName[32],
	Float:fWeight,

	// not saved
	bool:fExist
};

enum e_fish_data
{
	fName[32],
	fRarity[32],
    fModel,
	Float:fMinWeight,
	Float:fMaxWeight,
	fSellPrice
};

new FishData[MAX_PLAYERS][MAX_FISH][e_playerfish_data],
    FishingData[][e_fish_data] =
    {
        // kenapa dilebihkan? karna biar lebih sudah dapetin yang paling bawah

        // Common
        {"Salmon", "Common", 19630, 2.2, 5.5, 50},
        {"Salmon", "Common", 19630, 2.2, 5.5, 50},
        {"Salmon", "Common", 19630, 2.2, 5.5, 50},
        {"Salmon", "Common", 19630, 2.2, 5.5, 50},
        {"Trout", "Common", 19630, 2.1, 4.3, 40},
        {"Trout", "Common", 19630, 2.1, 4.3, 40},
        {"Trout", "Common", 19630, 2.1, 4.3, 40},
        {"Mas Juvenile", "Common", 19630, 2.5, 3.9, 35},
        {"Mas Juvenile", "Common", 19630, 2.5, 3.9, 35},
        {"Mas Juvenile", "Common", 19630, 2.5, 3.9, 35},
        {"Mujair Kecil", "Common", 1600, 3.1, 4.5, 30},
        // Uncommon
        {"Catfish", "Uncommon", 1604, 2.3, 7.0, 80},
        {"Catfish", "Uncommon", 1604, 2.3, 7.0, 80},
        {"Catfish", "Uncommon", 1604, 2.3, 7.0, 80},
        {"Catfish", "Uncommon", 1604, 2.3, 7.0, 80},
        {"Bass", "Uncommon", 19630, 2.0, 10.0, 90},
        {"Bass", "Uncommon", 19630, 2.0, 10.0, 90},
        {"Bass", "Uncommon", 19630, 2.0, 10.0, 90},
        {"Lele Muda", "Uncommon", 1599, 2.5, 10.2, 84},
        {"Lele Muda", "Uncommon", 1599, 2.5, 10.2, 84},
        {"Mujair Besar", "Uncommon", 1600, 3.1, 10.5, 82},
        // Rare
        {"Pike", "Rare", 19630, 2.5, 10.0, 150},
        {"Pike", "Rare", 19630, 2.5, 10.0, 150},
        {"Pike", "Rare", 19630, 2.5, 10.0, 150},
        {"Tuna", "Rare", 19630, 2.8, 15.0, 250},
        {"Tuna", "Rare", 19630, 2.8, 15.0, 250},
        {"Tuna", "Rare", 19630, 2.8, 15.0, 250},
        {"Tuna", "Rare", 19630, 2.8, 15.0, 250},
        {"Marlin Kecil", "Rare", 1599, 2.9, 19.0, 260},
        {"Lele Dewasa", "Rare", 1599, 3.0, 25.0, 260},
        // Epic
        {"Mackerel", "Epic", 1600, 3.0, 20.0, 400},
        {"Mackerel", "Epic", 1600, 3.0, 20.0, 400},
        {"Mackerel", "Epic", 1600, 3.0, 20.0, 400},
        {"Marlin", "Epic", 1599, 3.5, 30.0, 600},
        {"Marlin", "Epic", 1599, 3.5, 30.0, 600},
        {"Marlin", "Epic", 1599, 3.5, 30.0, 600},
        {"Aurora", "Epic", 1600, 3.74, 50.0, 645},
        {"Hiu Juvenile", "Epic", 1608, 3.7, 50.0, 650},
        // Legendary
        {"Swordfish", "Legendary", 6865, 4.0, 40.0, 1000}, 
        {"Swordfish", "Legendary", 6865, 4.0, 40.0, 1000},
        {"Swordfish", "Legendary", 6865, 4.0, 40.0, 1000},
        {"Swordfish", "Legendary", 6865, 4.0, 40.0, 1000},
        {"Swordfish", "Legendary", 6865, 4.0, 40.0, 1000},
        {"Goldfish", "Legendary", 1599, 5.0, 50.0, 1500},
        {"Goldfish", "Legendary", 1599, 5.0, 50.0, 1500},
        {"Goldfish", "Legendary", 1599, 5.0, 50.0, 1500},
        {"Goldfish", "Legendary", 1599, 5.0, 50.0, 1500},
        {"Goldfish", "Legendary", 1599, 5.0, 50.0, 1500},
        {"Turtle", "Legendary", 1609, 10.0, 70.0, 2000},
        {"Turtle", "Legendary", 1609, 10.0, 70.0, 2000},
        {"Turtle", "Legendary", 1609, 10.0, 70.0, 2000},
        {"Dolphin", "Legendary", 1607, 20.0, 100.0, 3500},
        {"Dolphin", "Legendary", 1607, 20.0, 100.0, 3500},
        {"Megalodon", "Legendary", 1608, 25.0, 150.0, 3000},
        {"Lele Mas Amba", "Legendary", 1599, 30.0, 170.0, 4000},
        {"Mas Amba Megalodon", "Legendary", 1608, 60.0, 250.0, 5000}
    },
    FishRarityColor[] =
    {
        0xFFFFFFFF,
        0x63636363,
        0x20BD9Bff,
        0x0000ffff,
        0x800080ff,
        0xffa500ff
    }
;

Fish_Load(playerid)
{
    mysql_query(g_SQL, sprintf("SELECT * FROM `player_fish` WHERE owner = '%d'", PlayerData[playerid][pID]), true);

    new rows = cache_num_rows();
    if(rows) forex(fan, rows)
    {
        cache_get_value_name_int(fan, "id", FishData[playerid][fan][fID]);
        cache_get_value_name(fan, "name", FishData[playerid][fan][fName]);
        cache_get_value_name_float(fan, "weight", FishData[playerid][fan][fWeight]);

        FishData[playerid][fan][fExist] = true;
    }
    printf("[PLAYER FISH]: has loaded %d fishes for %s", rows, PlayerData[playerid][pName]);
    return 1;
}

Fish_Delete(playerid, fishid)
{
    if(FishData[playerid][fishid][fExist])
    {
        mysql_tquery(g_SQL, sprintf("DELETE FROM `player_fish` WHERE owner = '%d' AND id = '%d'",
            PlayerData[playerid][pID],
            FishData[playerid][fishid][fID]
        ));
        Fish_Reset(playerid, fishid);
    }
    return 1;
}

Fish_Reset(playerid, fishid)
{
    FishData[playerid][fishid][fID] = -1;
    format(FishData[playerid][fishid][fName], 32, "");
    FishData[playerid][fishid][fWeight] = 0;
    FishData[playerid][fishid][fExist] = false;
    return 1;
}

/*Fish_Reorder(playerid, fishid)
{
	if(FishData[playerid][fishid][fWeight] == 0.0)
		Fish_Reset(playerid, fishid);

    // 1. Cek slot kosong sebelum fishid
    forex(i, fishid)
    {
        if (!FishData[playerid][i][fExist])
        {
            // Cari slot setelah fishid yang masih aktif
            Loop(j, MAX_FISH, i+1)
            {
                if (FishData[playerid][j][fExist])
                {
                    // Pindahkan data dari j ke i
                    FishData[playerid][i][fID] = FishData[playerid][j][fID];
                    format(FishData[playerid][i][fName], 32, "%s", FishData[playerid][j][fName]);
                    FishData[playerid][i][fWeight] = FishData[playerid][j][fWeight];
                    FishData[playerid][i][fExist] = true;

                    // Reset slot j
                    Fish_Reset(playerid, j);
                }
            }
        }
    }

    // 2. Pastikan semua slot setelah fishid diisi ulang ke slot kosong terdekat
    Loop(i, MAX_FISH, fishid+1)
    {
        if (!FishData[playerid][i][fExist])
        {
            Loop(j, MAX_FISH, i+1)
            {
                if (FishData[playerid][j][fExist])
                {
                    // Pindahkan data dari j ke i
                    FishData[playerid][i][fID] = FishData[playerid][j][fID];
                    format(FishData[playerid][i][fName], 32, "%s", FishData[playerid][j][fName]);
                    FishData[playerid][i][fWeight] = FishData[playerid][j][fWeight];
                    FishData[playerid][i][fExist] = true;

                    // Reset slot j
                    Fish_Reset(playerid, j);
				}
			}
		}
	}
    return 1;
}

Fish_GetID(playerid, const fish_name[])
{
    forex(i, MAX_FISH)
    {
        if(FishData[playerid][i][fExist] && !strcmp(FishData[playerid][i][fName], fish_name))
        {
            return i;
        }
    }
    return -1;
}*/

Fish_GetFreeID(playerid)
{
    forex(i, MAX_FISH)
    {
        if(!FishData[playerid][i][fExist])
        {
            return i;
        }
    }
    return -1;
}

Fish_GetRarity(const fish_name[])
{
    new fishid, fanstr[256];
    if((fishid = Fish_GetFishingID(fish_name)) != -1)
    {
        format(fanstr, sizeof(fanstr), FishingData[fishid][fRarity]);
    }
    else
        format(fanstr, sizeof(fanstr), "None");

    return fanstr;
}

Fish_RarityConvert(const fish_name[]) 
{
    new rarity[32];
    format(rarity, sizeof(rarity), "%s", Fish_GetRarity(fish_name));
    if(!strcmp(rarity, "Common")) 
    {
        return 0;
    } 
    else if(!strcmp(rarity, "Uncommon")) 
    {
        return 1;
    } 
    else if(!strcmp(rarity, "Rare")) 
    {
        return 2;
    } 
    else if(!strcmp(rarity, "Epic")) 
    {
        return 3;
    } 
    else if(!strcmp(rarity, "Legendary")) 
    {
        return 4;
    }
    return -1;
}

Fish_RarityWithColor(const fish_name[])
{
    new rarity[500], fishid;

    if((fishid = Fish_GetFishingID(fish_name))   == -1)
        return rarity;

    format(rarity, sizeof(rarity), "%s", FishingData[fishid][fRarity]);
    if(!strcmp(rarity, "Common")) 
    {
        format(rarity, sizeof(rarity), "{636363}Common{ffffff}");
    } 
    else if(!strcmp(rarity, "Uncommon")) 
    {
        format(rarity, sizeof(rarity), "{20BD9B}Uncommon{ffffff}");
    } 
    else if(!strcmp(rarity, "Rare")) 
    {
        format(rarity, sizeof(rarity), "{0000ff}Rare{ffffff}");
    } 
    else if(!strcmp(rarity, "Epic")) 
    {
        format(rarity, sizeof(rarity), "{800080}Epic{ffffff}");
    } 
    else if(!strcmp(rarity, "Legendary")) 
    {
        format(rarity, sizeof(rarity), "{ffa500}Legendary{ffffff}");
    }
    return rarity;
}

Fish_ColorByRarity(const fish_name[])
{
    new rarity[500], fishid;

    if((fishid = Fish_GetFishingID(fish_name))   == -1)
        return rarity;

    format(rarity, sizeof(rarity), "%s", FishingData[fishid][fRarity]);
    if(!strcmp(rarity, "Common")) 
    {
        format(rarity, sizeof(rarity), "{636363}");
    } 
    else if(!strcmp(rarity, "Uncommon")) 
    {
        format(rarity, sizeof(rarity), "{20BD9B}");
    } 
    else if(!strcmp(rarity, "Rare")) 
    {
        format(rarity, sizeof(rarity), "{0000ff}");
    } 
    else if(!strcmp(rarity, "Epic")) 
    {
        format(rarity, sizeof(rarity), "{800080}");
    } 
    else if(!strcmp(rarity, "Legendary")) 
    {
        format(rarity, sizeof(rarity), "{ffa500}");
    }
    return rarity;
}

Fish_Model(const fish_name[])
{
    new fishid;
    if((fishid = Fish_GetFishingID(fish_name)) == -1)
        return 0;

    return FishingData[fishid][fModel];
}

Fish_Add(playerid, const fish_name[], Float:fish_weight)
{
    new fishid;
    if((fishid = Fish_GetFreeID(playerid)) == -1) 
        return 0; 

    FishData[playerid][fishid][fExist] = true;
    FishData[playerid][fishid][fID] = fishid;
    FishData[playerid][fishid][fWeight] = fish_weight;
    format(FishData[playerid][fishid][fName], 32, "%s", fish_name);
    ShowFishForPlayer(playerid, fish_name, Fish_GetRarity(fish_name), Fish_Model(fish_name), fish_weight, FishRarityColor[Fish_RarityConvert(fish_name)+1]);

    mysql_tquery(g_SQL, sprintf("INSERT INTO `player_fish` (owner, id, name, weight) VALUES ('%d', '%d', '%s', '%f')",
        PlayerData[playerid][pID],
        fishid,
        SQL_EscapeString(FishData[playerid][fishid][fName]),
        fish_weight
    ), "Fish_Added", "dd", playerid, fishid);
    return 1;
}

public:Fish_Added(playerid, fishid)
{
    FishData[playerid][fishid][fID] = cache_insert_id();
    return 1;
}

/*Fish_Remove(playerid, fishid, Float:fish_weight = 500.0)
{
    if(FishData[playerid][fishid][fExist])
    {
        if(fish_weight == 500.0)
            fish_weight = FishData[playerid][fishid][fWeight];

        FishData[playerid][fishid][fWeight] -= fish_weight;
        if(FishData[playerid][fishid][fWeight] <= 0.0)
        {
            Fish_Delete(playerid, fishid);
        }
        else
        {
            mysql_tquery(g_SQL, sprintf("UPDATE player_fish SET weight = '%f' WHERE owner = '%d' AND id = '%d'",
                FishData[playerid][fishid][fWeight],
                PlayerData[playerid][pID],
                FishData[playerid][fishid][fID]
            ));
        }
    }
    return 1;
}*/

Fish_GetFishingID(const fish_name[])
{
    forex(i, sizeof(FishingData)) if(!strcmp(FishingData[i][fName], fish_name))
    {
        return i;
    }
    return -1;
}

Fish_RandomFishByRarity(const rarity_name[])
{
    new fish[sizeof(FishingData)], count = 0;
    forex(i, sizeof(FishingData))
    {
        if(!strcmp(FishingData[i][fRarity], rarity_name))
        {
            fish[count] = i;
            count++;
        }
    }
    if(count > 0)
    {
        new newcatch = random(count);
        forex(i, count)
        {
            if(random(100)+1 < (100 / count))
            {
                newcatch = i;
            }
        }
        return fish[newcatch];
    }
    return -1;
}

Fish_PlayerShow(playerid, type = 0 /* 0 - Show all, 1 - Show for sell */)
{
    new fanstr[5000], Float:fishprice;
    if(type == 1)
    {
        strcat(fanstr, "Fish\tWeight\tPrice\n");

        new index = 0;
        forex(i, MAX_FISH) if(FishData[playerid][i][fExist])
        {
            PlayerData[playerid][pValueListitem][index] = i;
            index++;
            fishprice = FishingData[Fish_GetFishingID(FishData[playerid][i][fName])][fSellPrice] + rumus_pajak(FishingData[Fish_GetFishingID(FishData[playerid][i][fName])][fSellPrice]*FishData[playerid][i][fWeight]);
            strcat(fanstr, sprintf("{ffff00}%s\t{ffffff}%.2f kg\t{00ff00}%s\n", FishData[playerid][i][fName], FishData[playerid][i][fWeight], FormatMoney(floatround(fishprice))), sizeof(fanstr));
        }
        strcat(fanstr, "{ffffff}Sell All");
        ShowPlayerDialog(playerid, DIALOG_FISH_SELL, DIALOG_STYLE_TABLIST_HEADERS, "Sell Fish", fanstr, "Sell", "Close");
    }
    else
    {
        new num;
        strcat(fanstr, "Fish\tWeight\n");

        forex(i, MAX_FISH) if(FishData[playerid][i][fExist])
        {
            PlayerData[playerid][pValueListitem][num] = i;
            num++;
            strcat(fanstr, sprintf("{ffff00}%s\t{ffffff}%.2f kg\n", FishData[playerid][i][fName], FishData[playerid][i][fWeight]), sizeof(fanstr));
        }

        ShowPlayerDialog(playerid, DIALOG_FISH, DIALOG_STYLE_TABLIST_HEADERS, "My Fish", fanstr, "Flexing", "Close");
    }
    return 1;
}

/*Fish_Has(playerid, const fish_name[])
{
    forex(i, MAX_FISH)
    {
        if(FishData[playerid][i][fExist] && !strcmp(FishData[playerid][i][fName], fish_name))
        {
            return 1;
        }
    }
    return 0;
}*/

Fish_Flexing(playerid, const fish_name[])
{
    new id; 
    if((id = Fish_GetFishingID(fish_name)) != -1)
    {
        switch(FishingData[id][fModel])
        {
            case 19630: SetPlayerAttachedObject(playerid, 9, 19630, 6, 0.090000, 0.104999, -0.119999, -105.000000, -7.500000, -93.000000, 2.770004, 1.539999, 2.545002, 0, 0); // ikan kecil 2 
            case 1599: SetPlayerAttachedObject(playerid, 9, 1599, 6, 0.150000, 0.164999, -0.164999, -103.500000, 15.000000, -9.000000, 1.000000, 1.284999, 1.059999, 0, 0); // ikan kecil 3 
            case 1600: SetPlayerAttachedObject(playerid, 9, 1600, 6, 0.150000, 0.164999, -0.164999, -103.500000, 15.000000, -9.000000, 1.000000, 1.284999, 1.059999, 0, 0); // ikan kecil 3 
            case 1608: SetPlayerAttachedObject(playerid, 9, 1608, 6, 0.000000, 0.854999, 0.614999, -103.500000, 1.500000, -16.500000, 0.400000, 0.625000, 0.595000, 0, 0); // hiu
            case 1604: SetPlayerAttachedObject(playerid, 9, 1604, 6, 0.134999, 0.089999, -0.120000, -106.500000, -10.500000, -9.000000, 1.074999, 1.659999, 1.000000, 0, 0); // ikan kecil 1 
            case 1609: SetPlayerAttachedObject(playerid, 9, 1609, 6, 0.419999, 0.059999, -0.135000, 72.000000, -183.000000, -16.500000, 0.595000, 0.490000, 0.625000, 0, 0); // kura2 
            default: return 0;
        }
        return 1;
    }
    return 0;
}

CMD:addfish(playerid, params[]) 
{
    if(!IsPlayerFann(playerid))
        return PermissionError(playerid);

    new otherid, fish_name[32], Float:weight;
    if(sscanf(params, "ufs[32]", otherid, weight, fish_name))
        return SendSyntaxMessage(playerid, "/addfish [TargetID/PartOfName] [weight] [fish_name]");

    new fishid;
    if((fishid = Fish_GetFishingID(fish_name)) == -1)
        return SendErrorMessage(playerid, "You must enter specific name, use '/fishlist' to see!");

    if(FishingData[fishid][fMinWeight] > weight || FishingData[fishid][fMaxWeight] < weight)
        return SendErrorMessage(playerid, "You must enter the right weight, use '/fishlist' to see!");

    if(Fish_Add(otherid, fish_name, weight) == -1)
        return SendErrorMessage(playerid, "Something error! please try again later!");

    SendServerMessage(playerid, "Kamu telah memberi ikan %s kepada %s dengan berat: %.2f", FishingData[fishid][fName], NormalName(otherid), weight);
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_FISH)
    {
        if(response) 
        {
            listitem = PlayerData[playerid][pValueListitem][listitem];
            ResetValueListitem(playerid);
            
            if(IsPlayerAttachedObjectSlotUsed(playerid, 9) && !PlayerData[playerid][pHoldingFish])
                return SendErrorMessage(playerid, "You cannot flexing fish while holding something!");

            PlayerData[playerid][pHoldingFish] = !PlayerData[playerid][pHoldingFish];
            if(PlayerData[playerid][pHoldingFish])
            {
                PlayerData[playerid][pFish] = listitem;
                ClearAnimations(playerid, SYNC_ALL);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                Fish_Flexing(playerid, FishData[playerid][listitem][fName]);
            }
            else
            {
                PlayerData[playerid][pFish] = -1;
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
                RemovePlayerAttachedObject(playerid, 9);
            }
        }
    }
    if(dialogid == DIALOG_FISH_FACTORY)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(GetMoney(playerid) < 100)
						return SendErrorMessage(playerid, "Kamu tidak memiliki cukup uang!");

					if(Inventory_Add(playerid, "Fishing Rod") == -1)
						return 1;

                    Server_AddMoney(100);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has paid $100 for one fishing rod.", ReturnName(playerid));
					GiveMoney(playerid, -100);
				}
				case 1:
				{
					if(GetMoney(playerid) < 5)
						return SendErrorMessage(playerid, "Kamu tidak memiliki cukup uang!");

					if(Inventory_Add(playerid, "Worm") == -1)
						return 1;

                    Server_AddMoney(5);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has paid $5 for one worm.", ReturnName(playerid));
					GiveMoney(playerid, -5);
				}
			}
		}
	}
	if(dialogid == DIALOG_FISH_SELL)
	{
		if(response)
		{
			new fishindex = PlayerData[playerid][pValueListitem][listitem];
			if(fishindex != -1)
			{
				new fishprice = floatround(FishingData[Fish_GetFishingID(FishData[playerid][fishindex][fName])][fSellPrice] + rumus_pajak(FishingData[Fish_GetFishingID(FishData[playerid][fishindex][fName])][fSellPrice]*FishData[playerid][fishindex][fWeight]));
				SetPVarInt(playerid, "fishprice", Negotiate_IncreasePrice(playerid, fishprice));
				SetPVarInt(playerid, "fishindex", fishindex);
				ShowPlayerDialog(playerid, DIALOG_FISH_SELL_CONFIRM, DIALOG_STYLE_MSGBOX, "Sell Fish", "Apakah kamu yakin ingin menjual :\n\nIkan : {ffff00}%s{ffffff}\nBerat : {ffffff}%.2f kg\nHarga : {00ff00}%s{ffffff}\n\nTekan "GREEN_E"Sell"W" untuk menjual, atau "RED_E"Back"W" untuk membatalkan.", "Sell", "Back", FishData[playerid][fishindex][fName], FishData[playerid][fishindex][fWeight], FormatMoney(GetPVarInt(playerid, "fishprice")));
			}
			else
			{
				new fishprice = 0;
				forex(i, MAX_FISH) if(FishData[playerid][i][fExist])
				{
					fishprice += floatround(FishingData[Fish_GetFishingID(FishData[playerid][i][fName])][fSellPrice] + rumus_pajak(FishingData[Fish_GetFishingID(FishData[playerid][i][fName])][fSellPrice]*FishData[playerid][i][fWeight]));
				}

				SetPVarInt(playerid, "fishprice", Negotiate_IncreasePrice(playerid, fishprice));
				ShowPlayerDialog(playerid, DIALOG_FISH_SELLALL_CONFIRM, DIALOG_STYLE_MSGBOX, "Sell Fish", "Apakah kamu yakin ingin menjual semua ikan milikmu dengan seharga {00ff00}%s{ffffff}?", "Sell", "Kembali", FormatMoney(GetPVarInt(playerid, "fishprice")));
			}

			ResetValueListitem(playerid);
		}
	}
	if(dialogid == DIALOG_FISH_SELL_CONFIRM)
	{
		if(response)
		{
			new fishprice = floatround(GetPVarFloat(playerid, "fishprice"));
			new fishindex = GetPVarInt(playerid, "fishindex");

			if(FishData[playerid][fishindex][fExist])
			{
				Fish_Delete(playerid, fishindex);
			}

			if(Skill_Has(playerid, "Negotiate Ability"))
				Skill_Earned(playerid, "Negotiate Ability", random(2)+1);

            Server_MinMoney(fishprice);
			GiveMoney(playerid, fishprice);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has sold their fish for %s.", ReturnName(playerid), FormatMoney(fishprice));
			DeletePVar(playerid, "fishindex");
			DeletePVar(playerid, "fishprice");
		}
	}
	if(dialogid == DIALOG_FISH_SELLALL_CONFIRM)
	{
		if(response)
		{
			new fishprice = GetPVarInt(playerid, "fishprice");
			forex(i, MAX_FISH) if(FishData[playerid][i][fExist])
			{
				Fish_Delete(playerid, i);
			}

			if(Skill_Has(playerid, "Negotiate Ability"))
				Skill_Earned(playerid, "Negotiate Ability", random(3)+1);

            Server_MinMoney(fishprice);
			GiveMoney(playerid, fishprice);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has sold all of their fishes for %s.", ReturnName(playerid), FormatMoney(floatround(fishprice)));
			DeletePVar(playerid, "fishprice");
		}
	}
    return 1;
}