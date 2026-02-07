CreateJoinLumberPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, -265.87, -2213.63, 29.04, -1, -1, -1, 5.0);
	format(strings, sizeof(strings), "[LUMBER JOBS]\n{ffffff}Jadilah Pekerja Lumber disini\n{7fffd4}/getjob /accept job");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -265.87, -2213.63, 29.04, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // lumber
}

#define MAX_TREES 100
#define TREE_RESPAWN 1800

enum    E_TREE
{
	// loaded from db
	Float: treeX,
	Float: treeY,
	Float: treeZ,
	Float: treeRX,
	Float: treeRY,
	Float: treeRZ,
	// temp
	treeLumber,
	treeSeconds,
	bool: treeGettingCut,
	treeObjID,
	Text3D: treeLabel,
	treeTimer
}

new TreeData[MAX_TREES][E_TREE],
	Iterator:Trees<MAX_TREES>;
	
SetPlayerLookAt(playerid, Float:x, Float:y)
{
	// somewhere on samp forums, couldn't find the source
	new Float:Px, Float:Py, Float: Pa;
	GetPlayerPos(playerid, Px, Py, Pa);
	Pa = floatabs(atan((y-Py)/(x-Px)));
	if (x <= Px && y >= Py) Pa = floatsub(180, Pa);
	else if (x < Px && y < Py) Pa = floatadd(Pa, 180);
	else if (x >= Px && y <= Py) Pa = floatsub(360.0, Pa);
	Pa = floatsub(Pa, 90.0);
	if (Pa >= 360.0) Pa = floatsub(Pa, 360.0);
	SetPlayerFacingAngle(playerid, Pa);
}

GetClosestTree(playerid, Float: range = 3.0)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : Trees)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, TreeData[i][treeX], TreeData[i][treeY], TreeData[i][treeZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}
	return id;
}

Player_ResetCutting(playerid)
{
	if(!IsPlayerConnected(playerid) || PlayerData[playerid][CuttingTreeID] == -1) return 0;
	new id = PlayerData[playerid][CuttingTreeID];
	TreeData[id][treeGettingCut] = false;
	if(TreeData[id][treeSeconds] < 1) Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[id][treeLabel], E_STREAMER_COLOR, 0x2ECC71FF);
	
	ClearAnimations(playerid);
    TogglePlayerControllable(playerid, true);
    PlayerData[playerid][CuttingTreeID] = -1;
    
    if(PlayerData[playerid][pActivity] != -1)
	{
	    KillTimer(PlayerData[playerid][pActivity]);
		PlayerData[playerid][pActivity] = -1;
		PlayerData[playerid][pActivityTime] = 0;
	}
	PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
	return 1;
}

Player_DropLumber(playerid, death_drop = 0)
{
    if(!IsPlayerConnected(playerid) || !PlayerData[playerid][CarryingLumber]) return 0;
    new id = Iter_Free(Lumbers);
    if(id != -1)
    {
        new Float: x, Float: y, Float: z, Float: a, label[128];
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);
        GetPlayerName(playerid, LumberData[id][lumberDroppedBy], MAX_PLAYER_NAME);

		if(!death_drop)
		{
		    x += (1.0 * floatsin(-a, degrees));
			y += (1.0 * floatcos(-a, degrees));
			
			ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, false, true, true, false, 0, SYNC_ALL);
		}

		LumberData[id][lumberSeconds] = LUMBER_LIFETIME;
		LumberData[id][lumberObjID] = CreateDynamicObject(19793, x, y, z - 0.9, 0.0, 0.0, a);
		
		format(label, sizeof(label), "Lumber (%d)\n"WHITE_E"Dropped By "GREEN_E"%s\n"WHITE_E"%s\nUse /lumber pickup.", id, LumberData[id][lumberDroppedBy], ConvertToMinutes(LUMBER_LIFETIME));
		LumberData[id][lumberLabel] = CreateDynamic3DTextLabel(label, COLOR_GREEN, x, y, z - 0.7, 5.0, .testlos = 1);
		
		LumberData[id][lumberTimer] = SetTimerEx("RemoveLumber", 1000, true, "i", id);
		Iter_Add(Lumbers, id);
    }
    
    Player_RemoveLumber(playerid);
	return 1;
}

Player_RemoveLumber(playerid)
{
	if(!IsPlayerConnected(playerid) || !PlayerData[playerid][CarryingLumber]) return 0;
	RemovePlayerAttachedObject(playerid, 9);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	PlayerData[playerid][CarryingLumber] = false;
	return 1;
}

public:RespawnTree(id)
{
	new label[96];
	if(TreeData[id][treeSeconds] > 1) 
	{
	    TreeData[id][treeSeconds]--;
	    
	    format(label, sizeof(label), "Tree (%d)\n{FFFFFF}%s", id, ConvertToMinutes(TreeData[id][treeSeconds]));
		UpdateDynamic3DTextLabelText(TreeData[id][treeLabel], COLOR_GREEN, label);
	}
	else if(TreeData[id][treeSeconds] == 1) 
	{
	    KillTimer(TreeData[id][treeTimer]);

	    TreeData[id][treeLumber] = 0;
	    TreeData[id][treeSeconds] = 0;
	    TreeData[id][treeTimer] = -1;
	    
	    SetDynamicObjectPos(TreeData[id][treeObjID], TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ]);
     	SetDynamicObjectRot(TreeData[id][treeObjID], TreeData[id][treeRX], TreeData[id][treeRY], TreeData[id][treeRZ]);
     	
     	format(label, sizeof(label), "Tree (%d)\n", id);
     	UpdateDynamic3DTextLabelText(TreeData[id][treeLabel], COLOR_GREEN, label);
	}
	return 1;
}
	
public:LoadTrees()
{
    new tid;
	
	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", tid);
			cache_get_value_name_float(i, "posx", TreeData[tid][treeX]);
			cache_get_value_name_float(i, "posy", TreeData[tid][treeY]);
			cache_get_value_name_float(i, "posz", TreeData[tid][treeZ]);
			cache_get_value_name_float(i, "posrx", TreeData[tid][treeRX]);
			cache_get_value_name_float(i, "posry", TreeData[tid][treeRY]);
			cache_get_value_name_float(i, "posrz", TreeData[tid][treeRZ]);
			
			new label[64];
			format(label, sizeof(label), "Tree (%d)\n", tid);
			TreeData[tid][treeLabel] = CreateDynamic3DTextLabel(label, COLOR_GREEN, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ] + 1.5, 5.0);
			TreeData[tid][treeObjID] = CreateDynamicObject(657, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ], TreeData[tid][treeRX], TreeData[tid][treeRY], TreeData[tid][treeRZ]);
			Iter_Add(Trees, tid);
			
			TreeData[tid][treeGettingCut] = false;
			TreeData[tid][treeSeconds] = 0;
		}
		printf("[Dynamic Tree] Number of Loaded: %d.", rows);
	}
}

Tree_Save(tid)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE trees SET posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f' WHERE id='%d'",
	TreeData[tid][treeX],
	TreeData[tid][treeY],
	TreeData[tid][treeZ],
	TreeData[tid][treeRX],
	TreeData[tid][treeRY],
	TreeData[tid][treeRZ],
	tid
	);
	return mysql_tquery(g_SQL, cQuery);
}

Tree_Refresh(tid)
{
    if(!Iter_Contains(Trees, tid)) return 0;
    new label[96];
    
    if(TreeData[tid][treeLumber] > 0) {
	    format(label, sizeof(label), "Tree (%d)\n"WHITE_E"Lumber: "GREEN_E"%d\n"WHITE_E"Use /lumber take.", tid, TreeData[tid][treeLumber]);
		UpdateDynamic3DTextLabelText(TreeData[tid][treeLabel], COLOR_GREEN, label);
	}else{
	    TreeData[tid][treeTimer] = SetTimerEx("RespawnTree", 1000, true, "i", tid);
	    
	    format(label, sizeof(label), "Tree (%d)\n"WHITE_E"%s", tid, ConvertToMinutes(TreeData[tid][treeSeconds]));
		UpdateDynamic3DTextLabelText(TreeData[tid][treeLabel], COLOR_GREEN, label);
	}
	
	return 1;
}

Tree_BeingEdited(id)
{
	if(!Iter_Contains(Trees, id)) return 0;
	foreach(new i : Player) if(PlayerData[i][pEditType] == EDIT_TREE && PlayerData[i][pEditID] == id) return 1;
	return 0;
}

ConvertToMinutes(time)
{
    // http://forum.sa-mp.com/showpost.php?p=3223897&postcount=11
    new string[15];//-2000000000:00 could happen, so make the string 15 chars to avoid any errors
    format(string, sizeof(string), "%02d:%02d", time / 60, time % 60);
    return string;
}

//-------[ commands ]----------

CMD:createtree(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
	new tid = Iter_Free(Trees), query[512];
	if(tid == -1) return SendErrorMessage(playerid, "Can't add any more trees.");
 	new Float: x, Float: y, Float: z, Float: a;
 	GetPlayerPos(playerid, x, y, z);
 	GetPlayerFacingAngle(playerid, a);
 	x += (3.0 * floatsin(-a, degrees));
	y += (3.0 * floatcos(-a, degrees));
	z -= 1.0;
	
	TreeData[tid][treeX] = x;
	TreeData[tid][treeY] = y;
	TreeData[tid][treeZ] = z;
	TreeData[tid][treeRX] = TreeData[tid][treeRY] = TreeData[tid][treeRZ] = 0.0;
	
	new label[96];
	format(label, sizeof(label), "Tree (%d)\n", tid);
	TreeData[tid][treeLabel] = CreateDynamic3DTextLabel(label, COLOR_GREEN, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ] + 1.5, 5.0);
	TreeData[tid][treeObjID] = CreateDynamicObject(657, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ], TreeData[tid][treeRX], TreeData[tid][treeRY], TreeData[tid][treeRZ]);
	Iter_Add(Trees, tid);
	
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO trees SET id='%d', posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f'", tid, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ], TreeData[tid][treeRX], TreeData[tid][treeRY], TreeData[tid][treeRZ]);
	mysql_tquery(g_SQL, query, "OnTreeCreated", "di", playerid, tid);
	return 1;
}

public:OnTreeCreated(playerid, tid)
{
	Tree_Save(tid);
	
	PlayerData[playerid][pEditType] = EDIT_TREE;
	PlayerData[playerid][pEditID] = tid;
	EditDynamicObject(playerid, TreeData[tid][treeObjID]);
	SendServerMessage(playerid, "Tree created.");
	SendServerMessage(playerid, "You can edit it right now, or cancel editing and edit it some other time.");
	return 1;
}

CMD:edittree(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
    if(PlayerData[playerid][pEditType] != EDIT_NONE) return SendErrorMessage(playerid, "You're already editing.");
	new tid;
	if(sscanf(params, "i", tid)) return SendSyntaxMessage(playerid, "/edittree [tree id]");
	if(!Iter_Contains(Trees, tid)) return SendErrorMessage(playerid, "Invalid ID.");
	if(TreeData[tid][treeGettingCut]) return SendErrorMessage(playerid, "Can't edit specified tree because its getting cut down.");
	if(!IsPlayerInRangeOfPoint(playerid, 30.0, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ])) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near the tree you want to edit.");
	PlayerData[playerid][pEditType] = EDIT_TREE;
	PlayerData[playerid][pEditID] = tid;
	EditDynamicObject(playerid, TreeData[tid][treeObjID]);
	return 1;
}

CMD:removetree(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new tid, query[512];
	if(sscanf(params, "i", tid)) return SendSyntaxMessage(playerid, "/removetree [tree id]");
	if(!Iter_Contains(Trees, tid)) return SendErrorMessage(playerid, "Invalid ID.");
	if(TreeData[tid][treeGettingCut]) return SendErrorMessage(playerid, "Can't remove specified tree because its getting cut down.");
	if(Tree_BeingEdited(tid)) return SendErrorMessage(playerid, "Can't remove specified tree because its being edited.");
	DestroyDynamicObject(TreeData[tid][treeObjID]);
	DestroyDynamic3DTextLabel(TreeData[tid][treeLabel]);
	if(TreeData[tid][treeTimer] != -1) KillTimer(TreeData[tid][treeTimer]);
	
	TreeData[tid][treeLumber] = TreeData[tid][treeSeconds] = 0;
	TreeData[tid][treeObjID] = TreeData[tid][treeTimer] = -1;
	TreeData[tid][treeLabel] = Text3D: -1;
	Iter_Remove(Trees, tid);
	
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM trees WHERE id=%d", tid);
	mysql_tquery(g_SQL, query);
	SendServerMessage(playerid, "Tree removed.");
	return 1;
}

CMD:gototree(playerid, params[])
{
	new tid;
	if(PlayerData[playerid][pAdmin] < 4)
        return PermissionError(playerid);
		
	if(sscanf(params, "d", tid))
		return SendSyntaxMessage(playerid, "/gototree [id]");
	if(!Iter_Contains(Trees, tid)) return SendErrorMessage(playerid, "The tree you specified ID of doesn't exist.");
	SetPlayerPosition(playerid, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ], 2.0);
	PlayerData[playerid][pInBiz] = -1;
	PlayerData[playerid][pInHouse] = -1;
	PlayerData[playerid][pInDoor] = -1;
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
	SendServerMessage(playerid, "You has teleport to house id %d", tid);
	return 1;
}

CMD:lumber(playerid, params[])
{
	if(PlayerData[playerid][pJob] == 3 || PlayerData[playerid][pJob2] == 3)
	{
		if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Anda harus keluar dari kendaraan.");
		if(isnull(params)) return SendSyntaxMessage(playerid, "/lum [cut/take/load/unload/pickup/sell]");
		
		if(!strcmp(params, "cut", true))
		{
			if(PlayerData[playerid][CarryingLumber]) return Player_DropLumber(playerid);
				
			if(GetPlayerWeapon(playerid) == WEAPON_CHAINSAW && PlayerData[playerid][CuttingTreeID] == -1 && !PlayerData[playerid][CarryingLumber])
			{
				if(PlayerData[playerid][pJobTime] > 0) return SendErrorMessage(playerid, "Anda harus menunggu "GREY2_E"%d "WHITE_E"detik untuk bisa bekerja kembali.", PlayerData[playerid][pJobTime]);
				
				new tid = GetClosestTree(playerid);

				if(tid != -1)
				{
					if(!Tree_BeingEdited(tid) && !TreeData[tid][treeGettingCut] && TreeData[tid][treeSeconds] < 1)
					{
						SetPlayerLookAt(playerid, TreeData[tid][treeX], TreeData[tid][treeY]);

						Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[tid][treeLabel], E_STREAMER_COLOR, 0xE74C3CFF);
						PlayerData[playerid][pActivity] = SetTimerEx("CutTree", 1000, true, "i", playerid);
						PlayerData[playerid][CuttingTreeID] = tid;
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Cutting...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
						TogglePlayerControllable(playerid, false);
						SetPlayerArmedWeapon(playerid, WEAPON_CHAINSAW);
						ApplyAnimation(playerid, "CHAINSAW", "WEAPON_csaw", 4.1, true, false, false, true, 0, SYNC_ALL);

						TreeData[tid][treeGettingCut] = true;
	
					}
					else return SendErrorMessage(playerid, "This tree is not ready.");
				}
				else return SendErrorMessage(playerid, "Invalid tree id");
			}
			else return SendErrorMessage(playerid, "You need to pickup the chainsaw.");
		}
		else if(!strcmp(params, "take", true))
		{
			// taking from a cut tree
			if(PlayerData[playerid][CarryingLumber]) return SendErrorMessage(playerid, "You're already carrying a log.");
			new tid = GetClosestTree(playerid);
			if(tid == -1) return SendErrorMessage(playerid, "You're not near a tree.");
			if(TreeData[tid][treeSeconds] < 1) return SendErrorMessage(playerid, "This tree isn't cut.");
			if(TreeData[tid][treeLumber] < 1) return SendErrorMessage(playerid, "This tree doesn't have any logs.");
			TreeData[tid][treeLumber]--;
			Tree_Refresh(tid);
			
			Player_GiveLumber(playerid);
			SendInfoMessage(playerid, "You've taken a log from the cut tree.");
		}
		else if(!strcmp(params, "load", true))
		{
			// loading to a bobcat
			new carid;
			if(!PlayerData[playerid][CarryingLumber]) return SendErrorMessage(playerid, "You're not carrying a log.");
			new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
			if(vehicleid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "You not in near any vehicles.");
			if(!IsAPickup(vehicleid)) return SendErrorMessage(playerid, "You're not near a pickup car.");

			if(Vehicle_LumberCount(vehicleid) >= LUMBER_LIMIT) return SendErrorMessage(playerid, "You can't load any more logs to this vehicle.");
			if((carid = Vehicle_Nearest(playerid)) != -1)
			{
				if(IsValidVehicle(VehicleData[carid][cVeh]))
				{
					VehicleData[carid][cLumber] += 1;
				}
			}
			if(IsValidVehicle(vehicleid))
			{
				for(new i; i < LUMBER_LIMIT; i++)
				{
					if(!IsValidDynamicObject(LumberObjects[vehicleid][i]))
					{
						LumberObjects[vehicleid][i] = CreateDynamicObject(19793, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
						AttachDynamicObjectToVehicle(LumberObjects[vehicleid][i], vehicleid, LumberAttachOffsets[i][0], LumberAttachOffsets[i][1], LumberAttachOffsets[i][2], 0.0, 0.0, LumberAttachOffsets[i][3]);
						break;
					}
				}
			}
			Streamer_Update(playerid);
			Player_RemoveLumber(playerid);
			SendInfoMessage(playerid, "Loaded a log.");
			#pragma unused carid
		}
		else if(!strcmp(params, "unload")) 
		{
			// taking from a bobcat
			new carid;
			if(PlayerData[playerid][CarryingLumber]) return SendErrorMessage(playerid, "You're already carrying a log.");
			new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
			if(vehicleid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "You not in near any vehicles.");
			if(!IsAPickup(vehicleid)) return SendErrorMessage(playerid, "You're not near a pickupcar.");

			if(Vehicle_LumberCount(vehicleid) < 1) return SendErrorMessage(playerid, "This vehicle doesn't have any logs.");
			if((carid = Vehicle_Nearest(playerid)) != -1)
			{
				if(IsValidVehicle(VehicleData[carid][cVeh]))
				{
					VehicleData[carid][cLumber] -= 1;
				}
			}
			if(IsValidVehicle(vehicleid))
			{
				for(new i = (LUMBER_LIMIT - 1); i >= 0; i--)
				{
					if(IsValidDynamicObject(LumberObjects[vehicleid][i]))
					{
						DestroyDynamicObject(LumberObjects[vehicleid][i]);
						LumberObjects[vehicleid][i] = -1;
						break;
					}
				}
			}
			Streamer_Update(playerid);
			Player_GiveLumber(playerid);
			SendInfoMessage(playerid, "You've taken a log from the Bobcat.");
			// done
		}
		else if(!strcmp(params, "pickup")) 
		{
			// taking from ground
			if(PlayerData[playerid][CarryingLumber]) return SendErrorMessage(playerid, "You're already carrying a log.");
			new tid = GetClosestLumber(playerid);
			if(tid == -1) return SendErrorMessage(playerid, "You're not near a log.");
			LumberData[tid][lumberSeconds] = 1;
			RemoveLumber(tid);
			
			Player_GiveLumber(playerid);
			SendInfoMessage(playerid, "You've taken a log from ground.");
			// done
		}
		else if(!strcmp(params, "sell")) 
		{
			// selling a log
			if(!PlayerData[playerid][CarryingLumber]) return SendErrorMessage(playerid, "You're not carrying a log.");
			if(!IsPlayerInRangeOfPoint(playerid, 3.0, -258.54, -2189.92, 28.97)) return SendErrorMessage(playerid, "You're not near a lumber warehouse.");
			Player_RemoveLumber(playerid);
			GivePlayerMoneyEx(playerid, LumberPrice);
			Server_MinMoney(LumberPrice);
			Material += 10;
			PlayerData[playerid][pJobTime] += 8;
			SendInfoMessage(playerid, "Sold a lumber for "GREEN_E"%s.", FormatMoney(LumberPrice));
			// done
		}
	}
	else return SendErrorMessage(playerid, "anda bukan pekerja lumber!");
	return 1;
}

CMD:lum(playerid, params[]) return callcmd::lumber(playerid, params);

Vehicle_LumberCount(vehicleid)
{
	if(GetVehicleModel(vehicleid) == 0) return 0;
	new count;
	for(new i; i < LUMBER_LIMIT; i++) if(IsValidDynamicObject(LumberObjects[vehicleid][i])) count++;
	return count;
}

GetClosestLumber(playerid, Float: range = 2.0)
{
	new tid = -1, Float: dist = range, Float: tempdist, Float: pos[3];
	foreach(new i : Lumbers)
	{
		GetDynamicObjectPos(LumberData[i][lumberObjID], pos[0], pos[1], pos[2]);
	    tempdist = GetPlayerDistanceFromPoint(playerid, pos[0], pos[1], pos[2]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			tid = i;
		}
	}
	return tid;
}

Player_GiveLumber(playerid)
{
    if(!IsPlayerConnected(playerid)) return 0;
	PlayerData[playerid][CarryingLumber] = true;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	SetPlayerAttachedObject(playerid, 9, 19793, 6, 0.077999, 0.043999, -0.170999, -13.799953, 79.70, 0.0);
	
	SendInfoMessage(playerid, "You can press "GREEN_E"'N' "WHITE_E"to drop your log.");
	return 1;
}

public:CutTree(playerid)
{
    if(PlayerData[playerid][CuttingTreeID] != -1)
	{
		new tid = PlayerData[playerid][CuttingTreeID];
		
		if(PlayerData[playerid][pActivityTime] >= 100)
		{
			TreeData[tid][treeLumber] = 5;
			TreeData[tid][treeSeconds] = TREE_RESPAWN;
			Player_ResetCutting(playerid);
			Tree_Refresh(tid);
			
			InfoTD_MSG(playerid, 8000, "Cutting tree done!");
			KillTimer(PlayerData[playerid][pActivity]);
			PlayerData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			PlayerData[playerid][pEnergy] -= 3;
			ClearAnimations(playerid);
			StopLoopingAnim(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			//TogglePlayerControllable(playerid, true);
			MoveDynamicObject(TreeData[tid][treeObjID], TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ] + 0.03, 0.025, TreeData[tid][treeRX], TreeData[tid][treeRY] - 80.0, TreeData[tid][treeRZ]);
			Streamer_Update(playerid);
			return 1;
		}
		else if(PlayerData[playerid][pActivityTime] < 100)
		{
			PlayerData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
		}
	}

	return 1;
}

public:RemoveLumber(tid)
{
	if(!Iter_Contains(Lumbers, tid)) return 1;
	
	if(LumberData[tid][lumberSeconds] > 1) 
	{
	    LumberData[tid][lumberSeconds]--;

        new label[128];
	    format(label, sizeof(label), "Lumber (%d)\n"WHITE_E"Dropped By "GREEN_E"%s\n"WHITE_E"%s\nUse /lumber pickup.", tid, LumberData[tid][lumberDroppedBy], ConvertToMinutes(LumberData[tid][lumberSeconds]));
		UpdateDynamic3DTextLabelText(LumberData[tid][lumberLabel], COLOR_GREEN, label);
	}
	else if(LumberData[tid][lumberSeconds] == 1) 
	{
	    KillTimer(LumberData[tid][lumberTimer]);
	    DestroyDynamicObject(LumberData[tid][lumberObjID]);
		DestroyDynamic3DTextLabel(LumberData[tid][lumberLabel]);
		
	    LumberData[tid][lumberTimer] = -1;
        LumberData[tid][lumberObjID] = -1;
        LumberData[tid][lumberLabel] = Text3D: -1;

		Iter_Remove(Lumbers, tid);
	}
	
	return 1;
}

GPS_TreeLocForPlayer(playerid)
{
	if(PlayerData[playerid][pJob] != 3 && PlayerData[playerid][pJob2] != 3)
		return SendErrorMessage(playerid, "Kamu bukan seorang pekerja LumberJack!");

	new fanstr[5000], status[64];
	strcat(fanstr, "#\tLocation\tStatus\tDistance\n");
	foreach(new tree : Trees)
	{
		if(TreeData[tree][treeSeconds] >= 1)
			status = "{ff0000}Not Ready{ffffff}";
		else
			status = "{00ff00}Available{ffffff}";

		format(fanstr, sizeof(fanstr), "%s%d\t%s\t%s\t%.2f\n", fanstr, tree, GetLocation(TreeData[tree][treeX], TreeData[tree][treeY], TreeData[tree][treeZ]), status, GetPlayerDistanceFromPoint(playerid, TreeData[tree][treeX], TreeData[tree][treeY], TreeData[tree][treeZ]));
	}

	ShowPlayerDialog(playerid, DIALOG_GPS_TREE, DIALOG_STYLE_TABLIST_HEADERS, "Tree Location", fanstr, "Pilih", "Kembali");
	return 1;
}
