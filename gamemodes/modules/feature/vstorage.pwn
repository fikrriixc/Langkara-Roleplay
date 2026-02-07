// Vehicle Storage by Fann
#include <YSI_Coding\y_hooks>

enum e_vehiclestorage_data
{
	vID,
	vItem[32],
	vQuantity,
	WEAPON:vWeapon,
	bool:vExist
};

new vsData[MAX_PRIVATE_VEHICLE][MAX_VSTORAGE][e_vehiclestorage_data];

VehicleStorage_Load(vehid)
{
	new cQuery[256];
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT * FROM `vehiclestorage` WHERE `owner` = %d", VehicleData[vehid][cID]);
	mysql_query(g_SQL, cQuery, true);

	if(cache_num_rows())
	{
		forex(vsid, cache_num_rows())
		{
			vsData[vehid][vsid][vExist] = true;
			cache_get_value_name_int(vsid, "id", vsData[vehid][vsid][vID]);
			cache_get_value_name(vsid, "item", vsData[vehid][vsid][vItem]);
			cache_get_value_name_int(vsid, "quantity", vsData[vehid][vsid][vQuantity]);
			cache_get_value_name_int(vsid, "weapon", _:vsData[vehid][vsid][vWeapon]);
		}
		printf("[V-STORAGE] Loaded %d storages for %s.", cache_num_rows(), GetVehicleModelName(VehicleData[vehid][cModel]));
	}
	return 1;
}

VehicleStorage_Reset(vehid)
{
	forex(vsid, MAX_VSTORAGE)
	{
		vsData[vehid][vsid][vID] = -1;
		format(vsData[vehid][vsid][vItem], 32, "");
		vsData[vehid][vsid][vWeapon] = WEAPON_FIST;
		vsData[vehid][vsid][vQuantity] = 0;
		vsData[vehid][vsid][vExist] = false;
	}
	return 1;
}

VehicleStorage_GetItemID(vehid, const item[])
{
	forex(vsid, MAX_VSTORAGE) if(vsData[vehid][vsid][vExist])
	{
		if(!strcmp(vsData[vehid][vsid][vItem], item))
			return vsid;
	}
	return -1;
}

VehicleStorage_GetFreeID(vehid)
{
	forex(vsid, MAX_VSTORAGE) if(!vsData[vehid][vsid][vExist])
		return vsid;

	return -1;
}

VehicleStorage_Add(playerid, vehid, item[], quantity = 1, WEAPON:weapon = WEAPON:-1)
{
	new itemid;
	itemid = VehicleStorage_GetItemID(vehid, item);

	if(itemid == -1)
	{
		itemid = VehicleStorage_GetFreeID(vehid);
		if(itemid != -1)
		{
			vsData[vehid][itemid][vExist] = true;
			vsData[vehid][itemid][vQuantity] = quantity;
			format(vsData[vehid][itemid][vItem], 32, item);
			if(weapon != WEAPON:-1)
				vsData[vehid][itemid][vWeapon] = weapon;

			mysql_tquery(g_SQL, sprintf("INSERT INTO vehiclestorage (owner, item, quantity, weapon) VALUES ('%d', '%s', '%d', '%d')", VehicleData[vehid][cID], SQL_EscapeString(item), quantity, vsData[vehid][itemid][vWeapon]), "OnVehicleStorageCreated", "dd", vehid, itemid);
			return itemid;
		}
		SendErrorMessage(playerid, "No any slots for this vehicle!");
		return -1;
	}
	else
	{
		vsData[vehid][itemid][vQuantity] += quantity;
		mysql_tquery(g_SQL, sprintf("UPDATE vehiclestorage SET quantity = '%d' WHERE id = '%d'", vsData[vehid][itemid][vQuantity], vsData[vehid][itemid][vID]));
	}
	return itemid;
}

public:OnVehicleStorageCreated(vehid, itemid)
{
	vsData[vehid][itemid][vID] = cache_insert_id();
	return 1;
}

VehicleStorage_Remove(playerid, vehid, item[], quantity = 1)
{
	new itemid = VehicleStorage_GetItemID(vehid, item);

	if(itemid == -1)
		return SendErrorMessage(playerid, "Theres no item on that slot!");

	vsData[vehid][itemid][vQuantity] -= quantity;
	if(vsData[vehid][itemid][vQuantity] <= 0)
	{
		mysql_tquery(g_SQL, sprintf("DELETE FROM vehiclestorage WHERE id = '%d'", vsData[vehid][itemid][vID]));

		vsData[vehid][itemid][vID] = -1;
		vsData[vehid][itemid][vQuantity] = 0;
		format(vsData[vehid][itemid][vItem], 32, "");
		vsData[vehid][itemid][vWeapon] = WEAPON_FIST;
		vsData[vehid][itemid][vExist] = false;
	}
	return 1;
}

VehicleStorage_Has(vehid, const itemname[])
{
	forex(vsid, MAX_VSTORAGE) if(vsData[vehid][vsid][vExist])
	{
		if(!strcmp(vsData[vehid][vsid][vItem], itemname))
			return vsData[vehid][vsid][vQuantity];
	}
	return 0;
}

VehicleStorage_AddDialog(bool:own = true)
{
	new fanstr[500];
	if(!own)
	{
		strcat(fanstr, "Money\n");
		strcat(fanstr, "First Aid\n");
		strcat(fanstr, "Medicine\n");
		strcat(fanstr, "Medkit\n");
		strcat(fanstr, "Component\n");
		strcat(fanstr, "Material\n");
		strcat(fanstr, "Marijuana\n");
		strcat(fanstr, "Holding Weapon");
	}
	return fanstr;
}

VehicleStorage_Open(playerid, bool:sapdmode = false)
{
	new vehid = GetPVarInt(playerid, "vStorageID"), fanstr[5000], num;
	strcat(fanstr, "Item\tQuantity\n");
	forex(vsid, MAX_VSTORAGE) if(vsData[vehid][vsid][vExist])
	{
		strcat(fanstr, sprintf("{FFFFFF}%s\t%s\n", vsData[vehid][vsid][vItem], FormatMoney(vsData[vehid][vsid][vQuantity], false)), sizeof(fanstr));
		PlayerData[playerid][pValueListitem][num] = vsid;
		num++;
	}

	if(!sapdmode && num < MAX_VSTORAGE)
		strcat(fanstr, "{ffff00}( Add Item )");
		
	if(sapdmode)
		SetPVarInt(playerid, "sapdmode", 1);

	ShowPlayerDialog(playerid, DIALOG_VSTORAGE, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Trunk", fanstr, sapdmode ? "Take" : "Select", "Back");
	return 1;
}

// HOOK DIALOG
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_VSTORAGE)
	{
		if(!response)
			return 1;

		new vehid = GetPVarInt(playerid, "vStorageID");

		if(!IsValidVehicle(VehicleData[vehid][cVeh]))
			return SendErrorMessage(playerid, "Terjadi kesalahan pada kendaraan!");

		new itemid = PlayerData[playerid][pValueListitem][listitem];
		ResetValueListitem(playerid);

		SetPVarInt(playerid, "storageID", itemid);
		if(!vsData[vehid][itemid][vExist])
		{
			if(!GetPVarInt(playerid, "sapdmode"))
				return ShowPlayerDialog(playerid, DIALOG_VSTORAGE_ADD, DIALOG_STYLE_LIST, sprintf("%s's Trunk", GetVehicleModelName(VehicleData[vehid][cModel])), VehicleStorage_AddDialog(false), "Select", "Close");
			else
			{
				VehicleStorage_Open(playerid);
				return SendErrorMessage(playerid, "Slot ini kosong!");
			}
		}

		if(vsData[vehid][itemid][vWeapon] != WEAPON_FIST)
		{
			if(PlayerHasWeaponInSlot(playerid, vsData[vehid][itemid][vWeapon]))
				return SendErrorMessage(playerid, "Kamu sudah memiliki senjata tipe yang sama!");

			PlayerTemp[playerid][temp_disableac] = true;
			GivePlayerWeaponEx(playerid, vsData[vehid][itemid][vWeapon], vsData[vehid][itemid][vQuantity]);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has took %s with %d ammo from %s's trunk.", ReturnName(playerid), ReturnWeaponName(vsData[vehid][itemid][vWeapon]), vsData[vehid][itemid][vQuantity], GetVehicleName(VehicleData[vehid][cVeh]));

			SetPVarInt(playerid, "sapdmode", 0);
			VehicleStorage_Remove(playerid, vehid, vsData[vehid][itemid][vItem], vsData[vehid][itemid][vQuantity]);
		}
		else
		{
			ShowPlayerDialog(playerid, DIALOG_VSTORAGE_MENU, DIALOG_STYLE_INPUT, sprintf("%s's Trunk", GetVehicleModelName(VehicleData[vehid][cModel])), "Item : {ffff00}%s\n{ffffff}Quantity : {ffff00}%d\n\n{ffffff}Masukan jumlah pada item tersebut yang ingin kamu ambil:", "Ambil", "Back", vsData[vehid][itemid][vItem], vsData[vehid][itemid][vQuantity]);
		}
	}
	if(dialogid == DIALOG_VSTORAGE_MENU)
	{
		if(!response)
			return 1;

		new vehid = GetPVarInt(playerid, "vStorageID"), itemid = GetPVarInt(playerid, "storageID"), amount = strval(inputtext);
	
		if(amount < 1) return ShowPlayerDialog(playerid, DIALOG_VSTORAGE_MENU, DIALOG_STYLE_INPUT, sprintf("%s's Trunk", GetVehicleModelName(VehicleData[vehid][cModel])), "ERROR: Kamu harus memasukan jumlah!\n\nItem : {ffff00}%s\n{ffffff}Quantity : {ffff00}%d\n\n{ffffff}Masukan jumlah pada item tersebut yang ingin kamu ambil:", "Ambil", "Back", vsData[vehid][itemid][vItem], vsData[vehid][itemid][vQuantity]);
		if(VehicleStorage_Has(vehid, vsData[vehid][itemid][vItem]) < amount) return ShowPlayerDialog(playerid, DIALOG_VSTORAGE_MENU, DIALOG_STYLE_INPUT, sprintf("%s's Trunk", GetVehicleModelName(VehicleData[vehid][cModel])), "ERROR: Penyimpanan tidak memiliki sebanyak itu!\n\nItem : {ffff00}%s\n{ffffff}Quantity : {ffff00}%d\n\n{ffffff}Masukan jumlah pada item tersebut yang ingin kamu ambil:", "Ambil", "Back", vsData[vehid][itemid][vItem], vsData[vehid][itemid][vQuantity]);

		if(strcmp(vsData[vehid][itemid][vItem], "Money"))
		{
			if(Inventory_Add(playerid, vsData[vehid][itemid][vItem], amount) == -1)
				return VehicleStorage_Open(playerid);
		}
		else
			GivePlayerMoneyEx(playerid, amount);

		SetPVarInt(playerid, "sapdmode", 0);
		VehicleStorage_Remove(playerid, vehid, vsData[vehid][itemid][vItem], amount);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has took %s from %s's storage.", ReturnName(playerid), vsData[vehid][itemid][vItem], GetVehicleName(VehicleData[vehid][cVeh]));
	}
	if(dialogid == DIALOG_VSTORAGE_ADD)
	{
		if(!response)
			return 1;

		new vehid = GetPVarInt(playerid, "vStorageID"), itemname[32];
		switch(listitem)
		{
			case 0: itemname = "Money";
			case 1: itemname = "First Aid";
			case 2: itemname = "Medicine";
			case 3: itemname = "Medkit";
			case 4: itemname = "Component";
			case 5: itemname = "Material";
			case 6: itemname = "Marijuana";
			case 7: 
			{
				if(GetPlayerWeapon(playerid) == WEAPON_FIST)
					return SendErrorMessage(playerid, "Kamu harus memegang senjata!");

				if(PlayerData[playerid][pGuns][g_aWeaponSlots[GetPlayerWeapon(playerid)]] != GetPlayerWeapon(playerid))
					return SendErrorMessage(playerid, "Something went wrong!");

				if(VehicleStorage_Add(playerid, vehid, ReturnWeaponName(GetPlayerWeapon(playerid)), PlayerData[playerid][pAmmo][g_aWeaponSlots[GetPlayerWeapon(playerid)]], GetPlayerWeapon(playerid)) == -1)
					return 1;

				PlayerData[playerid][pGuns][g_aWeaponSlots[GetPlayerWeapon(playerid)]] = WEAPON_FIST;
            	PlayerData[playerid][pAmmo][g_aWeaponSlots[GetPlayerWeapon(playerid)]] = 0;

            	SetWeapons(playerid);
            	return 1;
			}
		}

		if(strcmp(itemname, "Money") && Inventory_Has(playerid, itemname) < 1)
			return SendErrorMessage(playerid, "Kamu tidak memiliki item tersebut!");

		SetPVarString(playerid, "itemName", itemname);
		ShowPlayerDialog(playerid, DIALOG_VSTORAGE_ADD_QUAN, DIALOG_STYLE_INPUT, sprintf("%s's Trunk", GetVehicleModelName(VehicleData[vehid][cModel])), "Masukan jumlah item untuk dimasukan:", "Enter", "Back");
	}
	if(dialogid == DIALOG_VSTORAGE_ADD_QUAN)
	{
		if(!response)
			return 1;

		new vehid = GetPVarInt(playerid, "vStorageID"), itemname[32], amount = strval(inputtext);
		GetPVarString(playerid, "itemName", itemname, sizeof(itemname));

		if(amount < 1) return ShowPlayerDialog(playerid, DIALOG_VSTORAGE_ADD_QUAN, DIALOG_STYLE_INPUT, sprintf("%s's Trunk", GetVehicleModelName(VehicleData[vehid][cModel])), "ERROR: Kamu harus memasukan jumlah!\n\nMasukan jumlah item untuk dimasukan:", "Enter", "Back");
		if(strcmp(itemname, "Money") && Inventory_Has(playerid, itemname) < amount) return ShowPlayerDialog(playerid, DIALOG_VSTORAGE_ADD_QUAN, DIALOG_STYLE_INPUT, sprintf("%s's Trunk", GetVehicleModelName(VehicleData[vehid][cModel])), "ERROR: Kamu tidak memiliki sebanyak itu!\n\nMasukan jumlah item untuk dimasukan:", "Enter", "Back");
		if(!strcmp(itemname, "Money") && GetPlayerMoney(playerid) < amount) return ShowPlayerDialog(playerid, DIALOG_VSTORAGE_ADD_QUAN, DIALOG_STYLE_INPUT, sprintf("%s's Trunk", GetVehicleModelName(VehicleData[vehid][cModel])), "ERROR: Kamu tidak memiliki sebanyak itu!\n\nMasukan jumlah item untuk dimasukan:", "Enter", "Back");

		if(VehicleStorage_Add(playerid, vehid, itemname, amount) == -1)
			return 1;

		if(strcmp(itemname, "Money"))
			Inventory_Remove(playerid, itemname, amount);
		else
			GivePlayerMoneyEx(playerid, -amount);

		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has place %s to %s's storage.", ReturnName(playerid), itemname, GetVehicleName(VehicleData[vehid][cVeh]));
	}
	return 1;
}

CMD:vstorage(playerid)
{
	new vehicleid = GetNearestVehicleToPlayer(playerid,4.0,false), carid;
	
	if(vehicleid == INVALID_VEHICLE_ID)
		return SendErrorMessage(playerid, "Kamu tidak di dekat kendaraan apapun!");

	if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Kamu harus keluar dari kendaraan!");

	if((carid = Vehicle_GetID(vehicleid)) != -1)
	{
		if(Vehicle_IsOwner(playerid, carid))
		{
			if(!GetTrunkStatus(vehicleid) && !IsABike(vehicleid)) return SendErrorMessage(playerid, "Please open the vehicle trunk!");

			SetPVarInt(playerid, "vStorageID", carid);
			VehicleStorage_Open(playerid);
		}
		else
			SendErrorMessage(playerid, "Kamu bukan pemilik kendaraan ini!");
	}
	else
		SendErrorMessage(playerid, "Something went wrong! please try again later.");
	return 1;
}