// Box for Cargoship (Trucker Job Needed)
// by Fann

#include <YSI_Coding\y_hooks>

enum _:e_puton_type 
{
    PUTON_GROUND,
    PUTON_VEHICLE,
    PUTON_SELL
};

enum e_boxes_data 
{
    bID,
    bType,
    bWeight,
    bInVehicle,
    Float:bPos[4],
    // not saved
    bool:bPickup,
    bObject,
    Text3D:bLabel
};

new BoxData[MAX_BOX][e_boxes_data],
    Iterator:Boxes<MAX_BOX>;

public:LoadBox() 
{
    new rows = cache_num_rows();
    if(rows) forex(fan, rows)
    {
        cache_get_value_name_int(fan, "id", BoxData[fan][bID]);
        cache_get_value_name_int(fan, "type", BoxData[fan][bType]);
        cache_get_value_name_int(fan, "weight", BoxData[fan][bWeight]);
        cache_get_value_name_int(fan, "in_vehicle", BoxData[fan][bInVehicle]);
        cache_get_value_name_float(fan, "x", BoxData[fan][bPos][0]);
        cache_get_value_name_float(fan, "y", BoxData[fan][bPos][1]);
        cache_get_value_name_float(fan, "z", BoxData[fan][bPos][2]);
        cache_get_value_name_float(fan, "angle", BoxData[fan][bPos][3]);

        Iter_Add(Boxes, fan);
        Box_RefreshLabel(fan);
    }
    printf("[Dynamic Box] Loaded %d boxes from database.", rows);
}

Box_Save(boxid) 
{
    new fanQuery[5000];
    format(fanQuery, sizeof(fanQuery), "UPDATE `boxes` SET ");
    format(fanQuery, sizeof(fanQuery), "%s`type` = '%d', ", fanQuery, BoxData[boxid][bType]);
    format(fanQuery, sizeof(fanQuery), "%s`weight` = '%d', ", fanQuery, BoxData[boxid][bWeight]);
    format(fanQuery, sizeof(fanQuery), "%s`in_vehicle` = '%d', ", fanQuery, BoxData[boxid][bInVehicle]);
    format(fanQuery, sizeof(fanQuery), "%s`x` = '%f', ", fanQuery, BoxData[boxid][bPos][0]);
    format(fanQuery, sizeof(fanQuery), "%s`y` = '%f', ", fanQuery, BoxData[boxid][bPos][1]);
    format(fanQuery, sizeof(fanQuery), "%s`z` = '%f', ", fanQuery, BoxData[boxid][bPos][2]);
    format(fanQuery, sizeof(fanQuery), "%s`angle` = '%f' ", fanQuery, BoxData[boxid][bPos][3]);
    format(fanQuery, sizeof(fanQuery), "%sWHERE `id` = '%d'", fanQuery, BoxData[boxid][bID]);
    mysql_tquery(g_SQL, fanQuery);
}

Box_GetType(boxid)
{
    new fantype[32];
    switch(BoxData[boxid][bType])
    {
        case CARGO_COMPONENT: fantype = "Component Crate";
        case CARGO_MATERIAL: fantype = "Material Crate";
        case CARGO_FRESHMILK: fantype = "Fresh Milk Crate";
        default: fantype = "Unknown";
    }
    return fantype;
}

Box_RefreshLabel(boxid) 
{
    if(!Iter_Contains(Boxes, boxid))
        return 0;

    if(IsValidDynamicObject(BoxData[boxid][bObject]))
        DestroyDynamicObject(BoxData[boxid][bObject]);

    if(IsValidDynamic3DTextLabel(BoxData[boxid][bLabel]))
        DestroyDynamic3DTextLabel(BoxData[boxid][bLabel]);

    new fantext[256];
    format(fantext, sizeof(fantext), "[ID: %d]\n"W"Type: {ffff00}%s\n"W"Weight: %d kg", BoxData[boxid][bID], Box_GetType(boxid), BoxData[boxid][bWeight]);
    if(BoxData[boxid][bInVehicle] == -1 && !BoxData[boxid][bPickup])
    {
        BoxData[boxid][bLabel] = CreateDynamic3DTextLabel(fantext, ARWIN, BoxData[boxid][bPos][0], BoxData[boxid][bPos][1], BoxData[boxid][bPos][2] + 0.05, 10.0);
        BoxData[boxid][bObject] = CreateDynamicObject(1271, BoxData[boxid][bPos][0], BoxData[boxid][bPos][1], BoxData[boxid][bPos][2], 0.0, 0.0, BoxData[boxid][bPos][3]);
    }
    return 1;
}

Box_Delete(boxid) 
{
    if(!Iter_Contains(Boxes, boxid))
        return 0;

    if(IsValidDynamicObject(BoxData[boxid][bObject]))
        DestroyDynamicObject(BoxData[boxid][bObject]);

    if(IsValidDynamic3DTextLabel(BoxData[boxid][bLabel]))
        DestroyDynamic3DTextLabel(BoxData[boxid][bLabel]);

    new fanQuery[256];
    format(fanQuery, sizeof(fanQuery), "DELETE FROM `boxes` WHERE `id` = '%d'", BoxData[boxid][bID]);
    mysql_tquery(g_SQL, fanQuery);

    Iter_Remove(Boxes, boxid);
    return 1;
}

/*Box_PickupedBy(boxid)
{
    forex(playerid, MAX_PLAYERS)
    {
        if(PlayerData[playerid][pCargoCrate] && PlayerData[playerid][pCargoID] == boxid)
            return playerid;
    }
    return INVALID_PLAYER_ID;
}*/

Box_InVehicleCount(carid)
{
    new count = 0;
    
    foreach(new boxid : Boxes)
    {
        if(BoxData[boxid][bInVehicle] == VehicleData[carid][cID])
            count++;
    }
    return count;
}

Box_PickUp(playerid, boxid)
{
	if(BoxData[boxid][bType] == CARGO_UNKNOWN)
		return SendErrorMessage(playerid, "Invalid Cargo!");

	if(IsPlayerAttachedObjectSlotUsed(playerid, BOX_INDEX))
	{
		RemovePlayerAttachedObject(playerid, BOX_INDEX);
    	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    	PlayerData[playerid][pCargoCrate] = false; 
	}

    BoxData[boxid][bPickup] = true;
    BoxData[boxid][bInVehicle] = -1;
    Box_RefreshLabel(boxid);

	SetPlayerAttachedObject(playerid, BOX_INDEX, 1271, 5, 0.137832, 0.176979, 0.151424, 96.305931, 185.363006, 20.328088, 0.699999, 0.800000, 0.699999);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    PlayerData[playerid][pCargoCrate] = true; 
    PlayerData[playerid][pCargoID] = boxid;
    return 1;
}

Box_PutOn(playerid, type)
{
    new boxid = PlayerData[playerid][pCargoID];
    if(boxid != PlayerData[playerid][pCargoID])
        return SendErrorMessage(playerid, "You are not carrying this cargo!");

	if(!IsPlayerAttachedObjectSlotUsed(playerid, BOX_INDEX))
		return 0;

    BoxData[boxid][bPickup] = false;
    BoxData[boxid][bInVehicle] = -1;

    if(type == PUTON_GROUND)
    {
        GetPlayerPos(playerid, BoxData[boxid][bPos][0], BoxData[boxid][bPos][1], BoxData[boxid][bPos][2]);
        BoxData[boxid][bPos][2] -= 0.655;
        GetPlayerFacingAngle(playerid, BoxData[boxid][bPos][3]);

        BoxData[boxid][bPos][0] += 1.0 * floatcos(-BoxData[boxid][bPos][3], degrees);
        BoxData[boxid][bPos][1] += 1.0 * floatsin(-BoxData[boxid][bPos][3], degrees);
    }
    else if(type == PUTON_VEHICLE)
    {
        new vehicleid = GetNearestVehicleToPlayer(playerid,4.0,false), carid;
	
        if(vehicleid == INVALID_VEHICLE_ID)
            return SendErrorMessage(playerid, "Kamu tidak di dekat kendaraan apapun!");

        if((carid = Vehicle_GetID(vehicleid)) != -1)
        {
            if(Vehicle_IsOwner(playerid, carid))
            {
                if(!GetTrunkStatus(vehicleid) && !IsABike(vehicleid)) return SendErrorMessage(playerid, "Please open the vehicle trunk!");

                BoxData[boxid][bInVehicle] = VehicleData[carid][cID];

                SendCustomMessage(playerid, "CRATE", "You have put the cargo box into your vehicle trunk.");
            }
            else
            {
                BoxData[boxid][bPickup] = true;
                BoxData[boxid][bInVehicle] = -1;
                return SendErrorMessage(playerid, "Kamu bukan pemilik kendaraan ini!");
            }
        }
        else
        {
            BoxData[boxid][bPickup] = true;
            BoxData[boxid][bInVehicle] = -1;
            return SendErrorMessage(playerid, "Something went wrong! please try again later.");
        }
    }
    else if(type == PUTON_SELL)
    {
        new gajirumus;
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2460.7436, -2120.3706, 13.5529))
		{
			if(BoxData[boxid][bType] != CARGO_MATERIAL)
				return SendErrorMessage(playerid, "Kamu membawa cargo yang berbeda type!");

			gajirumus = MaterialPrice + (50 * BoxData[boxid][bWeight]);
			Material += 100 * BoxData[boxid][bWeight];
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 315.07, 926.53, 20.46))
		{
			if(BoxData[boxid][bType] != CARGO_COMPONENT)
				return SendErrorMessage(playerid, "Kamu membawa cargo yang berbeda type!");

			gajirumus = ComponentPrice + (50 * BoxData[boxid][bWeight]);
			Component += 100 * BoxData[boxid][bWeight];
		}
		else if(BoxData[boxid][bType] == CARGO_FRESHMILK)
		{
			new id = PlayerData[playerid][pMission];
			if(id == -1) return SendErrorMessage(playerid, "You dont have any mission!");

			if(IsPlayerInRangeOfPoint(playerid, 4.8, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ]))
			{
                gajirumus = FreshMilkPrice + (15 * BoxData[boxid][bWeight]);
				bData[id][bProd] += 5 * BoxData[boxid][bWeight];
				bData[id][bMoney] -= gajirumus;
				PlayerData[playerid][pMission] = -1;
				Bisnis_Save(id);
				Bisnis_Refresh(id);
			}
			else 
            {
                BoxData[boxid][bPickup] = true;
                BoxData[boxid][bInVehicle] = -1;
                return SendErrorMessage(playerid, "Anda harus berada didekat dengan bisnis mission anda.");
            }
		}
		else
        {
            BoxData[boxid][bPickup] = true;
            BoxData[boxid][bInVehicle] = -1;
			return SendErrorMessage(playerid, "Kamu tidak berada di salah satu point!");
        }
        GivePlayerMoneyEx(playerid, gajirumus);
		Server_MinMoney(gajirumus);
        SendCustomMessage(playerid, "CRATE", "You have sold the cargo box.");

        Box_Delete(boxid);
        RemovePlayerAttachedObject(playerid, BOX_INDEX);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, false, false, false, false, 0, SYNC_ALL);
        PlayerData[playerid][pCargoCrate] = false;
        PlayerData[playerid][pCargoID] = -1;
        return 1;
    }

    Box_Save(boxid);
    Box_RefreshLabel(boxid);

	RemovePlayerAttachedObject(playerid, BOX_INDEX);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    PlayerData[playerid][pCargoCrate] = false;
    PlayerData[playerid][pCargoID] = -1;
    return 1;
}

Box_Create(playerid, type, weight, bool:pickuped = true)
{
    new boxid;
    if((boxid = Iter_Free(Boxes)) != -1)
    {
        BoxData[boxid][bType] = type;
        BoxData[boxid][bWeight] = weight;
        BoxData[boxid][bInVehicle] = -1;
        GetPlayerPos(playerid, BoxData[boxid][bPos][0], BoxData[boxid][bPos][1], BoxData[boxid][bPos][2]);
        BoxData[boxid][bPos][2] -= 0.655;
        GetPlayerFacingAngle(playerid, BoxData[boxid][bPos][3]);
        BoxData[boxid][bPickup] = pickuped;

        if(pickuped)
            Box_PickUp(playerid, boxid);

        Iter_Add(Boxes, boxid);
        mysql_tquery(g_SQL, "INSERT INTO `boxes` (`type`) VALUES ('0')", "OnBoxCreated", "d", boxid);
        return boxid;
    }
    return -1;
}

public:OnBoxCreated(boxid)
{
    BoxData[boxid][bID] = cache_insert_id();
    Box_Save(boxid);
    Box_RefreshLabel(boxid);
    return 1;
}

Box_GetNearest(playerid, Float:range = 4.0)
{
    foreach(new boxid : Boxes) if(IsPlayerInRangeOfPoint(playerid, range, BoxData[boxid][bPos][0], BoxData[boxid][bPos][1], BoxData[boxid][bPos][2]) && !BoxData[boxid][bPickup] && BoxData[boxid][bInVehicle] == -1)
    {
        return boxid;
    }
    return -1;
}

CMD:createbox(playerid, params[])
{
    if(!IsPlayerFann(playerid))
        return PermissionError(playerid);

    new type, weight, pickuped;
    if(sscanf(params, "ddD(0)", type, weight, pickuped))
        return SendSyntaxMessage(playerid, "/createbox [type] [weight] [pickuped(0/1)]");

    if(type < CARGO_COMPONENT || type > CARGO_FRESHMILK)
        return SendErrorMessage(playerid, "Invalid cargo type!");

    if(weight <= 0)
        return SendErrorMessage(playerid, "Weight must be greater than 0!");

    new boxid;
    if((boxid = Box_Create(playerid, type, weight, bool:pickuped)) != -1)
    {
        SendServerMessage(playerid, "You have created a new cargo box (ID: %d).", BoxData[boxid][bID]);
    }
    else
    {
        SendErrorMessage(playerid, "Failed to create cargo box. Please try again later.");
    }
    return 1;
}

CMD:crate(playerid, params[])
{
    if(PlayerData[playerid][pJob] != 4 && PlayerData[playerid][pJob2] != 4)
		return SendErrorMessage(playerid, "You're not a Trucker!");
        
    new name[32];
    if(sscanf(params, "s[32]", name))
    {
        SendSyntaxMessage(playerid, "/crate [name]");
        SendCustomMessage(playerid, "NAME", "putdown, putin, pickup, list, sell");
        return 1;
    }

    if(!strcmp(name, "putdown", true))
    {
        new boxid = PlayerData[playerid][pCargoID];
        if(boxid == -1)
            return SendErrorMessage(playerid, "You are not carrying any cargo box!");

        Box_PutOn(playerid, PUTON_GROUND);
        ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, false, false, false, false, 0, SYNC_ALL);
        SendCustomMessage(playerid, "CRATE", "You have put down the cargo box.");
    }
    else if(!strcmp(name, "putin", true))
    {
        new boxid = PlayerData[playerid][pCargoID];
        if(boxid == -1)
            return SendErrorMessage(playerid, "You are not carrying any cargo box!");

        new vehicleid = GetNearestVehicleToPlayer(playerid,4.0,false);
	
        if(vehicleid == INVALID_VEHICLE_ID)
            return SendErrorMessage(playerid, "Kamu tidak di dekat kendaraan apapun!");

        if(IsPlayerInAnyVehicle(playerid))
            return SendErrorMessage(playerid, "Kamu harus keluar dari kendaraan!");

        Box_PutOn(playerid, PUTON_VEHICLE);
        ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, false, false, false, false, 0, SYNC_ALL);
    }
    else if(!strcmp(name, "pickup", true))
    {
        new boxid;
        if((boxid = Box_GetNearest(playerid, 4.0)) == -1)
            return SendErrorMessage(playerid, "There is no cargo box nearby!");

        Box_PickUp(playerid, boxid);
        ApplyAnimation(playerid, "CARRY", "liftup", 4.1, false, false, false, false, 0, SYNC_ALL);
        SendServerMessage(playerid, "You have picked up the cargo box (ID: %d).", BoxData[boxid][bID]);
    }
    else if(!strcmp(name, "list", true))
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            new carid = Vehicle_GetID(GetPlayerVehicleID(playerid));
            if(carid == -1)
                return SendErrorMessage(playerid, "Something went wrong! please try again later.");

            SendServerMessage(playerid, "---- Cargo Box List (%d Found) ----", Box_InVehicleCount(carid));
            foreach(new boxid : Boxes) if(BoxData[boxid][bInVehicle] == VehicleData[carid][cID])
            {
                SendServerMessage(playerid, "ID: %d | Type: %s | Weight: %d kg", BoxData[boxid][bID], Box_GetType(boxid), BoxData[boxid][bWeight], (BoxData[boxid][bInVehicle] != -1) ? "Yes" : "No");
            }
            SendServerMessage(playerid, "-----------------------------------------");
        }
        else
        {
            new vehicleid = GetNearestVehicleToPlayer(playerid,4.0,false), carid;

            if(vehicleid == INVALID_VEHICLE_ID)
                return SendErrorMessage(playerid, "Kamu tidak di dekat kendaraan apapun!");

            if((carid = Vehicle_GetID(vehicleid)) != -1)
            {
                new fanstr[5000], count;
                format(fanstr, sizeof(fanstr), "#\tType\tWeight(kg)");
                foreach(new boxid : Boxes) if(BoxData[boxid][bInVehicle] == VehicleData[carid][cID])
                {
                    format(fanstr, sizeof(fanstr), "%s\n%d.\t%s\t%d", fanstr, BoxData[boxid][bID], Box_GetType(boxid), BoxData[boxid][bWeight]);
                    PlayerData[playerid][pValueListitem][count] = boxid;
                    count++;
                }

                ShowPlayerDialog(playerid, DIALOG_CRATE, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Cargo Box List (%d Found)", count), fanstr, "Pickup", "Close");
            }
            else 
                SendErrorMessage(playerid, "Something went wrong! please try again later.");
        }
    }
    else if(!strcmp(name, "sell", true))
    {
        Box_PutOn(playerid, PUTON_SELL);
    }
    else
    {
        SendSyntaxMessage(playerid, "/crate [name]");
        SendCustomMessage(playerid, "NAME", "putdown, putin, pickup, list, sell");
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_CRATE)
    {
        if(response)
        {
            new boxid = PlayerData[playerid][pValueListitem][listitem];
            if(boxid != -1)
            {
                Box_PickUp(playerid, boxid);
                SendVehicleMessage(playerid, "You have picked up the cargo box from vehicle.");
            }
            else 
                SendErrorMessage(playerid, "Something went wrong! please try again later.");

            ResetValueListitem(playerid);
        }
    }
    return 1;
}