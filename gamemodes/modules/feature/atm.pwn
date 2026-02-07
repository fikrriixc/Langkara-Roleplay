
enum    E_ATM
{
	// loaded from db
	Float: atmX,
	Float: atmY,
	Float: atmZ,
	Float: atmRX,
	Float: atmRY,
	Float: atmRZ,
	atmInt,
	atmWorld,
	atmRobbery,
	// temp
	atmObjID,
	Text3D: atmLabel
}

new AtmData[MAX_ATM][E_ATM],
	Iterator:ATMS<MAX_ATM>;
	
GetClosestATM(playerid, Float: range = 3.0)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : ATMS)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, AtmData[i][atmX], AtmData[i][atmY], AtmData[i][atmZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist && GetPlayerInterior(playerid) == AtmData[i][atmInt] && GetPlayerVirtualWorld(playerid) == AtmData[i][atmWorld])
		{
			dist = tempdist;
			id = i;
		}
	}
	return id;
}

public:LoadATM()
{
	new rows;
	cache_get_row_count(rows);
	if(rows)
  	{
 		new id;
		forex(i, rows)
		{
		    cache_get_value_name_int(i, "id", id);
			cache_get_value_name_float(i, "posx", AtmData[id][atmX]);
			cache_get_value_name_float(i, "posy", AtmData[id][atmY]);
			cache_get_value_name_float(i, "posz", AtmData[id][atmZ]);
			cache_get_value_name_float(i, "posrx", AtmData[id][atmRX]);
			cache_get_value_name_float(i, "posry", AtmData[id][atmRY]);
			cache_get_value_name_float(i, "posrz", AtmData[id][atmRZ]);
			cache_get_value_name_int(i, "interior", AtmData[id][atmInt]);
			cache_get_value_name_int(i, "world", AtmData[id][atmWorld]);
			cache_get_value_name_int(i, "robbery", AtmData[id][atmRobbery]);
			//AtmData[id][atmMap] = CreateDynamicMapIcon(ATMIslem[id][atmPos][0], ATMIslem[id][atmPos][1], ATMIslem[id][atmPos][2], 52, -1, -1, -1, -1, 100.0, 1);
			//AtmData[id][atmCP] = CreateDynamicCP(ATMrowsslem[id][atmPos][0], ATMIslem[id][atmPos][1], ATMIslem[id][atmPos][2], 1.5, -1, -1, -1, 3.0);
			Iter_Add(ATMS, id);

			Atm_RefreshLabel(id);
		}
		printf("[Dynamic ATM] Number of Loaded: %d.", rows);
	}
}

Atm_Save(id)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE atms SET posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f', interior='%d', world='%d', robbery='%d' WHERE id='%d'",
	AtmData[id][atmX],
	AtmData[id][atmY],
	AtmData[id][atmZ],
	AtmData[id][atmRX],
	AtmData[id][atmRY],
	AtmData[id][atmRZ],
	AtmData[id][atmInt],
	AtmData[id][atmWorld],
	AtmData[id][atmRobbery],
	id
	);
	return mysql_tquery(g_SQL, cQuery);
}

Atm_RefreshLabel(id)
{
	if(!Iter_Contains(ATMS, id)) return 0;
	if(IsValidDynamicObject(AtmData[id][atmObjID])) DestroyDynamicObject(AtmData[id][atmObjID]);
	if(IsValidDynamic3DTextLabel(AtmData[id][atmLabel])) DestroyDynamic3DTextLabel(AtmData[id][atmLabel]);

	new str[256], objid;
	if(AtmData[id][atmRobbery] != 0)
	{
		objid = 3067;
		format(str, sizeof(str), "[ID: %d]\n"W"Status: "RED_E"Broken\n"W"this atm can not be used", id);
	}
	else
	{
		objid = 19324;
		format(str, sizeof(str), "[ID: %d]\n"W"Status: "LG_E"Active\n"W"Use "YELLOW_E"/atm"W" here", id);
	}

	AtmData[id][atmObjID] = CreateDynamicObject(objid, AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ], AtmData[id][atmRX], AtmData[id][atmRY], AtmData[id][atmRZ], AtmData[id][atmWorld], AtmData[id][atmInt], -1, 10.0, 10.0);
	AtmData[id][atmLabel] = CreateDynamic3DTextLabel(str, ARWIN, AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ] + 0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, AtmData[id][atmWorld], AtmData[id][atmInt], -1, 10.0);
	return 1;
}

Atm_BeingEdited(id)
{
	if(!Iter_Contains(ATMS, id)) return 0;
	foreach(new i : Player) if(PlayerData[i][pEditType] == EDIT_ATM && PlayerData[i][pEditID] == id) return 1;
	return 0;
}

CMD:createatm(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new id = Iter_Free(ATMS), query[512];
	if(id == -1) return SendErrorMessage(playerid, "Can't add any more ATM.");
 	new Float: x, Float: y, Float: z;
 	GetPlayerPos(playerid, x, y, z);
 	/*GetPlayerFacingAngle(playerid, a);
 	x += (3.0 * floatsin(-a, degrees));
	y += (3.0 * floatcos(-a, degrees));
	z -= 1.0;*/
	
	AtmData[id][atmX] = x;
	AtmData[id][atmY] = y;
	AtmData[id][atmZ] = z;
	AtmData[id][atmRX] = AtmData[id][atmRY] = AtmData[id][atmRZ] = 0.0;
	AtmData[id][atmInt] = GetPlayerInterior(playerid);
	AtmData[id][atmWorld] = GetPlayerVirtualWorld(playerid);
	Iter_Add(ATMS, id);

	Atm_RefreshLabel(id);
	
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO atms SET id='%d', posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f', interior='%d', world='%d'", id, AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ], AtmData[id][atmRX], AtmData[id][atmRY], AtmData[id][atmRZ], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	mysql_tquery(g_SQL, query, "OnAtmCreated", "ii", playerid, id);
	return 1;
}

public:OnAtmCreated(playerid, id)
{
	Atm_Save(id);
	SendServerMessage(playerid, "You has created ATM id: %d.", id);
	return 1;
}

public:OnATMUpdate() {

	foreach(new id : ATMS) {

		if(AtmData[id][atmRobbery] != 0 && AtmData[id][atmRobbery] <= gettime()) {

			AtmData[id][atmRobbery] = 0;
			Atm_Save(id);
			Atm_RefreshLabel(id);
			SendAdminMessage(COLOR_LRED, "ATM ID: %d sudah bisa digunakan kembali!", id);
		}
	}
	return 1;
}

CMD:editatm(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	
	if(PlayerData[playerid][pEditType] != EDIT_NONE) return SendErrorMessage(playerid, "You're already editing.");

	new id, edit[32];
	if(sscanf(params, "is[32]", id, edit)) {
		SendSyntaxMessage(playerid, "/editatm [id] [edit]");
		SendClientMessage(playerid, ARWIN, "EDIT: {FFFFFF}position, robbery");
		return 1;
	} 
	if(!Iter_Contains(ATMS, id)) return SendErrorMessage(playerid, "Invalid ID.");
	if(!strcmp(edit, "position")) {

		if(!IsPlayerInRangeOfPoint(playerid, 30.0, AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ])) 
			return SendErrorMessage(playerid, "You're not near the atm you want to edit.");

		PlayerData[playerid][pEditType] = EDIT_ATM;
		PlayerData[playerid][pEditID] = id;
		EditDynamicObject(playerid, AtmData[id][atmObjID]);
	}
	else if(!strcmp(edit, "robbery")) {

		if(AtmData[id][atmRobbery] == 0)
			return SendErrorMessage(playerid, "Error untuk ATM ini!");

		AtmData[id][atmRobbery] = 0;
		Atm_Save(id);
		Atm_RefreshLabel(id);
		SendServerMessage(playerid, "Kamu telah membuat atm %d bisa digunakan kembali.", id);
		return 1;
	}
	return 1;
}

CMD:removeatm(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new id, query[512];
	if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/removeatm [id]");
	if(!Iter_Contains(ATMS, id)) return SendErrorMessage(playerid, "Invalid ID.");
	
	if(Atm_BeingEdited(id)) return SendErrorMessage(playerid, "Can't remove specified atm because its being edited.");
	DestroyDynamicObject(AtmData[id][atmObjID]);
	DestroyDynamic3DTextLabel(AtmData[id][atmLabel]);
	
	AtmData[id][atmX] = AtmData[id][atmY] = AtmData[id][atmZ] = AtmData[id][atmRX] = AtmData[id][atmRY] = AtmData[id][atmRZ] = 0.0;
	AtmData[id][atmInt] = AtmData[id][atmWorld] = 0;
	AtmData[id][atmObjID] = -1;
	AtmData[id][atmLabel] = Text3D: -1;
	Iter_Remove(ATMS, id);
	
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM atms WHERE id=%d", id);
	mysql_tquery(g_SQL, query);
	SendServerMessage(playerid, "Menghapus ID Atm %d.", id);
	return 1;
}

CMD:gotoatm(playerid, params[])
{
	new id;
	if(PlayerData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
		
	if(sscanf(params, "d", id))
		return SendSyntaxMessage(playerid, "/gotoatm [id]");
	if(!Iter_Contains(ATMS, id)) return SendErrorMessage(playerid, "ATM ID tidak ada.");
	
	SetPlayerPosition(playerid, AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ], 2.0);
    SetPlayerInterior(playerid, AtmData[id][atmInt]);
    SetPlayerVirtualWorld(playerid, AtmData[id][atmWorld]);
	SendServerMessage(playerid, "Teleport ke ID ATM %d", id);
	return 1;
}

CMD:atm(playerid, params[])
{
	if(PlayerData[playerid][IsLoggedIn] == false) return SendErrorMessage(playerid, "Kamu harus login!");
	if(PlayerData[playerid][pInjured] >= 1) return SendErrorMessage(playerid, "Kamu tidak bisa melakukan ini!");
	new id;
	id = GetClosestATM(playerid);
	
	if(id > -1)
	{
		if(AtmData[id][atmRobbery] != 0)
			return SendErrorMessage(playerid, "You can use this ATM after: %s.", ReturnTimelapse(gettime(), AtmData[id][atmRobbery]));

		new tstr[128];
		format(tstr, sizeof(tstr), ""ORANGE_E"No Rek: "LB_E"%d", PlayerData[playerid][pBankRek]);
		ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_LIST, tstr, "Check Balance\nWithdraw Money\nTransfer Money\nSign Paycheck", "Select", "Cancel");
	}
	else
		SendErrorMessage(playerid, "There is no ATM nearby.");

	return 1;
}
