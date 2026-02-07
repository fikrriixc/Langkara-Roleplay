// Support for inventory textdraw
// Inspired by Unity Roleplay

#include <YSI_Coding\y_hooks>

enum e_playerinventory_data
{
	iID,
	iItem[32],
	iQuantity,
	// not saved
	bool:iExists
};

enum e_inventory_data
{
	iItem[32],
	iModel,
	bool:iDropAble, // same with GiveAble
	iMaxQuantity
};

enum e_inventoryalias_data
{
	iAliasName[32],
	iItemName[32]
};

new const InvData[][e_inventory_data] =
{
    {"Snack", 2768, true, 35},
    {"Mineral Water", 2958, true, 35},
    {"Fuel Can", 1650, true, 3},
    {"Fishing Rod", 18632, true, 5},
    {"Worm", 19832, true, 100},
    {"First Aid", 11738, true, 3},
    {"Medicine", 11738, true, 5},
    {"Medkit", 11738, true, 5},
    {"Mask", 19163, false, 1},
    {"Handphone", 330, false, 1},
    {"Walkie Talkie", 18868, false, 1},
    {"Marijuana", 1575, true, 50},
    {"Fish", 19630, true, 20},
    {"Component", 19627, true, 1500},
    {"Material", 19627, true, 1500},
    {"Seed", 1578, true, 200},
    {"Fresh Milk", 19570, true, 10},
    {"Milk", 19569, true, 10},
    {"Boombox", 2102, false, 1},
	{"Food", 2328, true, 500},
	{"Wheat", 3374, true, 100},
	{"Orange", 19574, true, 100},
	{"Potato", 19577, true, 100},
	//
	{"Roasted Potato", 0, true, 50},
	{"Potato Spread", 0, true, 50},
	{"Bowl of Cooked Rice", 0, true, 50},
	{"French Fries", 0, true, 50}
};

new const InvAlias[][e_inventoryalias_data] =
{
	{"Bottle of Milk", "Fresh Milk"},
	{"Phone", "Handphone"}
};

new InventoryData[MAX_PLAYERS][MAX_INVENTORY][e_playerinventory_data];

stock Inventory_Load(playerid)
{
	new fanQuery[500];
	mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "SELECT * FROM `inventory` WHERE ownerid = '%d'", PlayerData[playerid][pID]);
	mysql_query(g_SQL, fanQuery, true);

	new rows = cache_num_rows();
	if(rows) forex(i, rows)
	{
		cache_get_value_name_int(i, "id", InventoryData[playerid][i][iID]);
		cache_get_value_name(i, "item", InventoryData[playerid][i][iItem]);
		cache_get_value_name_int(i, "quantity", InventoryData[playerid][i][iQuantity]);

		InventoryData[playerid][i][iExists] = true;
	}
	printf("[SERVER-OUTPUT] Inventory_Load(): has loaded %d inventory slot for %s.", rows, PlayerData[playerid][pName]);
	return 1;
}

stock Inventory_Clear(playerid)
{
	forex(fan, MAX_INVENTORY) if(InventoryData[playerid][fan][iExists])
		Inventory_Delete(playerid, invid);

	return 1;
}

stock Inventory_Delete(playerid, invid)
{
	if(!InventoryData[playerid][invid][iExists])
	    return printf("[SERVER-OUTPUT] [ERROR] Inventory_Delete(): playerinventory with id %d is not found", invid);

	mysql_tquery(g_SQL, sprintf("DELETE FROM `inventory` WHERE id = '%d'", InventoryData[playerid][invid][iID]));
	Inventory_Reset(playerid, invid);
	return 1;
}

stock Inventory_Reset(playerid, invid, bool:disconnected = false)
{
	#pragma unused disconnected
	
	InventoryData[playerid][invid][iID] = -1;
	format(InventoryData[playerid][invid][iItem], 32, "");
	InventoryData[playerid][invid][iQuantity] = 0;
	InventoryData[playerid][invid][iExists] = false;
	return 1;
}

stock Inventory_Has(playerid, const item[])
{
	forex(fan, MAX_INVENTORY) if(InventoryData[playerid][fan][iExists])
	{
		if(!strcmp(item, InventoryData[playerid][fan][iItem]) && 0 < InventoryData[playerid][fan][iQuantity])
			return InventoryData[playerid][fan][iQuantity];
	}
	return 0;
}

stock Inventory_GetItemID(playerid, const item[])
{
	forex(fan, MAX_INVENTORY) if(InventoryData[playerid][fan][iExists]) 
	{
		if(!strcmp(InventoryData[playerid][fan][iItem], item)) 
		{
			printf("[SERVER-OUTPUT] [INFO] Inventory_GetItemID(): itemid founded %d!", fan);
			return fan;
		}
	}
	print("[SERVER-OUTPUT] [INFO] Inventory_GetItemID(): itemid not founded!");
	return -1;
}

stock Inventory_GetFreeID(playerid)
{
	forex(fan, MAX_INVENTORY) if(!InventoryData[playerid][fan][iExists])
	{
		return fan;
	}
	return -1;
}

stock Inventory_MaxQuantity(playerid, invid, const name[] = "")
{
	forex(i, MAX_INVITEMS) 
	{
		if(strlen(name) > 0)
		{
			if(!strcmp(name, InvData[i][iItem]))
				return InvData[i][iMaxQuantity];
		}
		else
		{
			if(!strcmp(InventoryData[playerid][invid][iItem], InvData[i][iItem]))
				return InvData[i][iMaxQuantity];
		}
	}

	return 0;
}

stock Inventory_DropAble(playerid, invid)
{
	forex(i, MAX_INVITEMS) if(!strcmp(InventoryData[playerid][invid][iItem], InvData[i][iItem]))
		return InvData[i][iDropAble];

	return false;
}

stock Inventory_Model(playerid, invid)
{
	forex(fan, MAX_INVITEMS) if(!strcmp(InventoryData[playerid][invid][iItem], InvData[fan][iItem]))
		return InvData[fan][iModel];

	return -1;
}

stock Inventory_Set(playerid, const item[], amount)
{
	new itemid = Inventory_GetItemID(playerid, item);
	forex(i, MAX_INVITEMS) if(!strcmp(InvData[i][iItem], item))
	{
		if(amount > InvData[i][iMaxQuantity])
		{
			SendErrorMessage(playerid, "Jumlah item mencapai jumlah maksimal!");
			return -1;
		}
	}

	if(itemid == -1 && amount > 0)
		return Inventory_Add(playerid, item, amount);
	else if (amount > 0 && itemid != -1)
	    return Inventory_SetQuantity(playerid, item, amount);
	else if (amount < 1 && itemid != -1)
	    return Inventory_Remove(playerid, item, -1);

	SendErrorMessage(playerid, "Kamu tidak dapat menambah item ke inventory karna server sudah tidak dapat memuat.");
	return -1;
}

stock Inventory_SetQuantity(playerid, const item[], quantity)
{
	new itemid = Inventory_GetItemID(playerid, item);
	forex(i, MAX_INVITEMS) if(!strcmp(InvData[i][iItem], item))
	{
		if(quantity > InvData[i][iMaxQuantity])
		{
			SendErrorMessage(playerid, "Item ini mencapai jumlah maksimal!");
			return -1;
		}
	}

	if(itemid != -1)
	{
		InventoryData[playerid][itemid][iQuantity] = quantity;
	    mysql_tquery(g_SQL, sprintf("UPDATE `inventory` SET `quantity` = '%d' WHERE `id` = '%d'", quantity, InventoryData[playerid][itemid][iID]));
	    return itemid;
	}
	SendErrorMessage(playerid, "Item tidak ditemukan!");
	return -1;
}

stock Inventory_Remove(playerid, const item[], quantity = 1)
{
	new itemid = Inventory_GetItemID(playerid, item);
	if(itemid != -1)
	{
	    if(InventoryData[playerid][itemid][iQuantity] > 0)
	    {
	        InventoryData[playerid][itemid][iQuantity] -= quantity;
		}
		if(quantity == -1 || InventoryData[playerid][itemid][iQuantity] < 1)
		{
			Inventory_Delete(playerid, itemid);
		}
		else if (quantity != -1 && InventoryData[playerid][itemid][iQuantity] > 0)
		{
            mysql_tquery(g_SQL, sprintf("UPDATE `inventory` SET `quantity` = '%d' WHERE `id` = '%d'", InventoryData[playerid][itemid][iQuantity], InventoryData[playerid][itemid][iID]));
		}
		return itemid;
	}
	SendErrorMessage(playerid, "Item tidak ditemukan!");
	return -1;
}

stock Inventory_Add(playerid, const item[], quantity = 1)
{
	forex(i, MAX_INVITEMS) if(!strcmp(InvData[i][iItem], item))
	{
		if(Inventory_Has(playerid, item)+quantity > InvData[i][iMaxQuantity])
		{
			SendErrorMessage(playerid, "Item ini sudah mencapai jumlah maksimal!");
			return -1;
		}
	}

	new itemid = Inventory_GetItemID(playerid, item);
	if(itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if(itemid != -1)
	    {
			InventoryData[playerid][itemid][iExists] = true;
	        InventoryData[playerid][itemid][iQuantity] = quantity;

	        forex(i, MAX_INVITEMS) if(!strcmp(InvData[i][iItem], item, true))
	        	format(InventoryData[playerid][itemid][iItem], 32, InvData[i][iItem]);

			mysql_tquery(g_SQL, sprintf("INSERT INTO `inventory` (`ownerid`, `item`, `quantity`) VALUES('%d', '%s', '%d')", PlayerData[playerid][pID], InventoryData[playerid][itemid][iItem], InventoryData[playerid][itemid][iQuantity]), "Inventory_Created", "dd", playerid, itemid);
	        return itemid;
		}
		SendErrorMessage(playerid, "Kamu tidak dapat menambah item karna sudah mencapai kapasitas!");
		return -1;
	}
	else
	{
	    InventoryData[playerid][itemid][iQuantity] += quantity;
	    mysql_tquery(g_SQL, sprintf("UPDATE `inventory` SET quantity = '%d' WHERE id = '%d'", InventoryData[playerid][itemid][iQuantity], InventoryData[playerid][itemid][iID]));
	}
	return itemid;
}

public:Invetory_Created(playerid, invid)
{
	InventoryData[playerid][invid][iID] = cache_insert_id();
	return 1;
}

stock Inventory_Open(playerid)
{
	new fanList[5000], bool:found = false, num;
	strcat(fanList, "Item\tQuantity\n");
	strcat(fanList, sprintf(""LG_E"Money\t"LG_E"%s"WHITE_E"\n", FormatMoney(PlayerData[playerid][pMoney])), sizeof(fanList));
	forex(fan, MAX_INVENTORY) if(InventoryData[playerid][fan][iExists])
	{
		found = true;
		strcat(fanList, sprintf("%s\t%d\n", InventoryData[playerid][fan][iItem], InventoryData[playerid][fan][iQuantity]));
		PlayerData[playerid][pValueListitem][num+1] = fan;
		num++;
	}

	if(found)
		ShowPlayerDialog(playerid, DIALOG_INVENTORY, DIALOG_STYLE_TABLIST_HEADERS, "Inventory", fanList, "Select", "Back");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Inventory", "Kamu tidak memiliki item apapun", "Tutup", "");
	return 1;
}

stock Inventory_Show(playerid, targetid)
{
	new fanList[5000], bool:found = false, num;
	strcat(fanList, "Item\tQuantity\n");
	strcat(fanList, sprintf(""LG_E"Money\t"LG_E"%s"WHITE_E"\n", FormatMoney(PlayerData[playerid][pMoney])), sizeof(fanList));
	forex(fan, MAX_INVENTORY) if(InventoryData[playerid][fan][iExists])
	{
		found = true;
		strcat(fanList, sprintf("%s\t%d\n", InventoryData[playerid][fan][iItem], InventoryData[playerid][fan][iQuantity]));
		PlayerData[playerid][pValueListitem][num+1] = fan;
		num++;
	}

	if(found)
		ShowPlayerDialog(targetid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, sprintf("%s's Inventory", PlayerData[playerid][pName]), fanList, "Tutup", "");
	else
		ShowPlayerDialog(targetid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, sprintf("%s's Inventory", PlayerData[playerid][pName]), "%s tidak memiliki item apapun", "Tutup", "", PlayerData[playerid][pName]);
	return 1;
}

// ---[ COMMAND ]--- //
CMD:inventory(playerid, params[])
{
	Inventory_Open(playerid);
	return 1;
}

CMD:setitem(playerid, params[])
{
	new targetid, item[32], amount;
	if(PlayerData[playerid][pAdmin] < 6)
	    return PermissionError(playerid);

	if(sscanf(params, "uds[32]", targetid, amount, item))
	    return SendSyntaxMessage(playerid, "/setitem [player name/id] [amount] [item name]");

	if(!PlayerData[targetid][pSpawned])
		return SendErrorMessage(playerid, "Target tidak diketahui!");

	forex(i, MAX_INVITEMS) if(!strcmp(InvData[i][iItem], item, true))
	{
        if(Inventory_Set(targetid, InvData[i][iItem], amount) == -1)
        	return 1;

        if(!strcmp(InvData[i][iItem], "Handphone"))
        {
        	new fanQuery[500], phone = RandomEx(1111, 9888)+PlayerData[targetid][pID];
			mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "SELECT phone FROM players WHERE phone='%d'", phone);
			mysql_tquery(g_SQL, fanQuery, "PhoneNumber", "id", targetid, phone);
        }
		return SendServerMessage(playerid, "Kamu telah mengatur Inventory %s dengan %s: %d jumlah.", PlayerData[targetid][pName], InvData[i][iItem], amount);
	}
	SendErrorMessage(playerid, "Item tidak diketahui! '/itemlist' untuk melihat list item");
	return 1;
}

CMD:ainventory(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new targetid;
	if(sscanf(params, "u", targetid))
		return SendSyntaxMessage(playerid, "/ainv(entory) [player name/id]");

	if(!PlayerData[targetid][pSpawned])
		return SendErrorMessage(playerid, "Target tidak diketahui!");

	Inventory_Show(targetid, playerid);
	return 1;
}

CMD:itemlist(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new fanstr[1024];
	strcat(fanstr, "Item\tMax Quantity\tDrop Able\n");
	forex(i, MAX_INVITEMS) 
		strcat(fanstr, sprintf("%s\t%d\t%s\n", InvData[i][iItem], InvData[i][iMaxQuantity], InvData[i][iDropAble] ? "true" : "false"));

	return ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "List of Items", fanstr, "Select", "Cancel");
}

// ---[ DIALOG ]--- //
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_INVENTORY)
    {
    	new name[32];
        if(response)
        {
        	if(listitem == 0)
        		return SendCustomMessage(playerid, "INV", "You have {00ff00}%s{ffffff} in your vault.", FormatMoney(PlayerData[playerid][pMoney]));

        	new itemid = PlayerData[playerid][pValueListitem][listitem];
			ResetValueListitem(playerid);
			
			if(!InventoryData[playerid][itemid][iExists])
				return SendErrorMessage(playerid, "No item in this slot!"), Inventory_Open(playerid);

			format(name, 32, InventoryData[playerid][itemid][iItem]);
			SetPVarInt(playerid, "invID", itemid);

			format(name, sizeof(name), "%s (%d/%d)", name, InventoryData[playerid][itemid][iQuantity], Inventory_MaxQuantity(playerid, itemid));
			ShowPlayerDialog(playerid, DIALOG_INVENTORY_ACTION, DIALOG_STYLE_LIST, name, "Gunakan\nBerikan\nJatuhkan", "Pilih", "Back");
		}
	}
	if(dialogid == DIALOG_INVENTORY_ACTION)
	{
		if(!response)
		{
			callcmd::inventory(playerid, "");
		}	
	    else if(response)
	    {
		    new itemid = GetPVarInt(playerid, "invID"), string[32];

		    format(string, 32, InventoryData[playerid][itemid][iItem]);
		    switch(listitem)
		    {
		        case 0:
		        {
		            CallLocalFunction("OnPlayerUseItem", "dds", playerid, itemid, string);
		        }
		        case 1:
		        {
		        	if(!Inventory_DropAble(playerid, itemid))
		        		return SendErrorMessage(playerid, "Kamu tidak dapat memberikan item ini!");

					SetPVarInt(playerid, "invID", itemid);
					ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE, DIALOG_STYLE_INPUT, "Berikan Item", "Masukan nama/id player yang ingin diberikan:", "Next", "Kembali");
		        }
		        case 2:
		        {
		        	SendServerMessage(playerid, "Coming Soon!");
		            /*if (IsPlayerInAnyVehicle(playerid))
		                return SendErrorMessage(playerid, "You can't drop items right now.");

				    if(!strcmp(string, "Cellphone"))
				        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

				    if(!strcmp(string, "GPS"))
				        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

				    if(!strcmp(string, "Portable Radio"))
				        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

				    if(!strcmp(string, "Mask"))
				        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

					else if (InventoryData[playerid][itemid][invQuantity] == 1)
					{
						if(!strcmp(string, "Rolled Weed"))
						{
							if(IsPlayerInRangeOfPoint(playerid, 5.0, -1112.0999,-1676.1182,76.3672))
							{
								new amount = InventoryData[playerid][itemid][invQuantity];
								GiveMoney(playerid, amount*1000);
								SendClientMessage(playerid, COLOR_SERVER, "DRUGS: {FFFFFF}Kamu telah menjual {FFFF00}%d Rolled Weed {FFFFFF}dan mendapatkan {00FF00}$%s", amount, FormatNumber(amount*1000));
								Inventory_Remove(playerid, "Rolled Weed");
							}
							else
							{
								DropPlayerItem(playerid, itemid);
							}
						}
						else
						{
							DropPlayerItem(playerid, itemid);
						}
					}
					else
						format(str, sizeof(str), "Item: %s - Quantity: %d\n\nPlease specify how much of this item you wish to drop:", string, InventoryData[playerid][itemid][invQuantity]),
						ShowPlayerDialog(playerid, DIALOG_DROPITEM, DIALOG_STYLE_INPUT, "Drop Item", str, "Drop", "Cancel");*/
				}
			}
		}
	}
	if(dialogid == DIALOG_INVENTORY_GIVE)
	{
		if(!response)
		{
			listitem = GetPVarInt(playerid, "invID");

			new name[32];
			format(name, sizeof(name), "%s (%d/%d)", InventoryData[playerid][listitem][iItem], InventoryData[playerid][listitem][iQuantity], Inventory_MaxQuantity(playerid, listitem));
			ShowPlayerDialog(playerid, DIALOG_INVENTORY_ACTION, DIALOG_STYLE_LIST, name, "Gunakan\nBerikan\nJatuhkan", "Pilih", "Kembali");
		}
		else if(response)
		{
			new targetid, itemid, string[32];

			if(sscanf(inputtext, "u", targetid))
				return ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE, DIALOG_STYLE_INPUT, "Berikan Item", "Masukan nama/id player yang ingin diberikan:", "Next", "Kembali");

			if(!PlayerData[targetid][pSpawned])
				return ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE, DIALOG_STYLE_INPUT, "Berikan Item", "ERROR: Target/Player tidak ditemukan!\n\nMasukan nama/id player yang ingin diberikan:", "Next", "Kembali");

			if(!NearPlayer(playerid, targetid, 6.0))
				return ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE, DIALOG_STYLE_INPUT, "Berikan Item", "ERROR: Target/Player tidak di dekatmu!\n\nMasukan nama/id player yang ingin diberikan:", "Next", "Kembali");

			if(targetid == playerid)
				return ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE, DIALOG_STYLE_INPUT, "Berikan Item", "ERROR: Kamu tidak bisa menggunakan idmu sendiri!\n\nMasukan nama/id player yang ingin diberikan:", "Next", "Kembali");

			itemid = GetPVarInt(playerid, "invID");

			if(itemid == -1)
				return 0;

			format(string, 32, InventoryData[playerid][itemid][iItem]);
			if(InventoryData[playerid][itemid][iQuantity] == 1)
			{
				new id = Inventory_Add(targetid, string);

				if(id == -1)
					return -1;

				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				PlayerPlaySound(targetid, 1052, 0.0, 0.0, 0.0);
				if(!IsPlayerInAnyVehicle(playerid))
					SetPlayerToFacePlayer(playerid, targetid);

				if(!IsPlayerInAnyVehicle(targetid))
					SetPlayerToFacePlayer(targetid, playerid);

				ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, false, false, false, false, 0);
				ApplyAnimation(targetid, "DEALER", "shop_pay", 4.0, false, false, false, false, 0);

				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s takes out a %s and gives it to %s.", ReturnName(playerid), string, ReturnName(targetid));
				SendNearbyMessage(targetid, 30.0, COLOR_PURPLE, "** %s received a %s from %s.", ReturnName(targetid), string, ReturnName(playerid));

				Inventory_Remove(playerid, string);
				//Log_Write("logs/give_log.txt", "[%s] %s (%s) has given a %s to %s (%s).", ReturnDate(), ReturnName(playerid), PlayerData[playerid][pIP], string, ReturnName(userid, 0), PlayerData[userid][pIP]);
			}
			else
			{
				ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE_AMOUNT, DIALOG_STYLE_INPUT, "Berikan Item", "Item: %s Jumlah: %d\n\nMasukan jumlah yang ingin kamu beri kepada %s:", "Berikan", "Kembali", InventoryData[playerid][itemid][iItem], InventoryData[playerid][itemid][iQuantity], ReturnName(targetid));
				SetPVarInt(playerid, "targetid", targetid);
			}
		}
	}
	if(dialogid == DIALOG_INVENTORY_GIVE_AMOUNT)
	{
		if(!response)
		{
			ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE, DIALOG_STYLE_INPUT, "Berikan Item", "Masukan nama/id player yang ingin diberikan:", "Next", "Kembali");

		}
	 	else if(response && PlayerData[GetPVarInt(playerid, "targetid")][pSpawned])
		{
			new targetid = GetPVarInt(playerid, "targetid"), itemid = GetPVarInt(playerid, "invID"), string[32];

			format(string, 32, InventoryData[playerid][itemid][iItem]);

			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE_AMOUNT, DIALOG_STYLE_INPUT, "Berikan Item", "Item: %s Jumlah: %d\n\nMasukan jumlah yang ingin kamu beri kepada %s:", "Berikan", "Kembali", InventoryData[playerid][itemid][iItem], InventoryData[playerid][itemid][iQuantity], ReturnName(targetid));

			if(strval(inputtext) < 1 || strval(inputtext) > InventoryData[playerid][itemid][iQuantity])
				return ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE_AMOUNT, DIALOG_STYLE_INPUT, "Berikan Item", "ERROR: Kamu tidak memiliki jumlah item sebanyak itu!\n\nItem: %s Jumlah: %d\n\nMasukan jumlah yang ingin kamu beri kepada %s:", "Berikan", "Kembali", InventoryData[playerid][itemid][iItem], InventoryData[playerid][itemid][iQuantity], ReturnName(targetid));

			new id = Inventory_Add(targetid, string, strval(inputtext));

			if(id == -1)
				return 1;

			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			PlayerPlaySound(targetid, 1052, 0.0, 0.0, 0.0);
			if(!IsPlayerInAnyVehicle(playerid))
				SetPlayerToFacePlayer(playerid, targetid);

			if(!IsPlayerInAnyVehicle(targetid))
				SetPlayerToFacePlayer(targetid, playerid);

			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, false, false, false, false, 0);
			ApplyAnimation(targetid, "DEALER", "shop_pay", 4.0, false, false, false, false, 0);

			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s takes out a %s and gives it to %s.", ReturnName(playerid), string, ReturnName(targetid));
			SendNearbyMessage(targetid, 30.0, COLOR_PURPLE, "** %s received a %s from %s.", ReturnName(targetid), string, ReturnName(playerid));

			Inventory_Remove(playerid, string, strval(inputtext));
			// Log_Write("logs/give_log.txt", "[%s] %s (%s) has given %d %s to %s (%s).", ReturnDate(), ReturnName(playerid), PlayerData[playerid][pIP], strval(inputtext), string, ReturnName(userid, 0), PlayerData[userid][pIP]);
		}
	}
	return 1;
}