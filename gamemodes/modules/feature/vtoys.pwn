// Vehicle Toys
#include <YSI_Coding\y_hooks>

enum e_vehicle_object 
{
    object_id,
    object_vehicle,
    object_type,
    object_model,
    object_color[MAX_COLOR_MATERIAL],

    object_text[128],
    object_fonts[24],
    object_fontsize,
    object_fontcolor,

    object_streamer,
    
    bool:object_exists,
    object_toggle,

    Float:object_x,
    Float:object_y,
    Float:object_z,
    Float:object_rx,
    Float:object_ry,
    Float:object_rz
};
new VehicleObjects[MAX_PRIVATE_VEHICLE][MAX_VEHICLE_OBJECT][e_vehicle_object];

enum e_body_data 
{
    Id,
    Model[37]
};

new BodyWork[][e_body_data] = 
{
    {1000,"Generic Spoiler"},
    {1001,"Generic Spoiler"},
    {1002,"Generic Spoiler"},
    {1003,"Generic Spoiler"},
    {1004,"Bonnet Scoop"},
    {1005,"Bonnet Scoop"},
    {1006,"Generic Vehicle Roof-Scoop"},
    {1007,"Generic Vehicle Side Skirt (L)"},
    {1011,"Bonnet Scoop"},
    {1012,"Bonnet Scoop"},
    {1013,"Round Fog Lamps"},
    {1014,"Generic Spoiler"},
    {1015,"Generic Spoiler"},
    {1016,"Generic Spoiler"},
    {1017,"Generic Vehicle Side Skirt (R)"},
    {1018,"Curved Twin Cylinder Generic Exhaust"},
    {1019,"Twin Cylinder Generic Exhaust"},
    {1020,"Large Generic Exhaust"},
    {1021,"Medium Generic Exhaust"},
    {1022,"Small Generic Exhaust"},
    {1023,"Generic Spoiler"},
    {1024,"Square Fog Lamps"},
    {1026,"Sultan Side Skirt Type 1 (L)"},
    {1027,"Sultan Side Skirt Type 1 (R)"},
    {1028,"Sultan Exhaust Type 1"},
    {1029,"Sultan Exhaust Type 2"},
    {1030,"Sultan Side Skirt Type 2 (R)"},
    {1031,"Sultan Side Skirt Type 1 (L)"},
    {1032,"Sultan Roof Scoop type 1"},
    {1033,"Sultan Roof Scoop type 2"},
    {1169,"Sultan Front Bumper type 1"},
    {1170,"Sultan Front Bumper type 2"},
    {1138,"Sultan Spoiler type 1"},
    {1139,"Sultan Spoiler type 2"},
    {1140,"Sultan Rear Bumper type 2"},
    {1141,"Sultan Rear Bumper type 1"},
    {1146,"Elegy Spoiler type 2"},
    {1147,"Elegy Spoiler type 1"},
    {1148,"Elegy Rear Bumper type 2"},
    {1149,"Elegy Rear Bumper type 1"},
    {1150,"Flash Rear Bumper type 1"},
    {1151,"Flash Rear Bumper type 2"},
    {1152,"Flash Front Bumper type 2"},
    {1153,"Flash Front Bumper type 1"},
    {1154,"Stratum Rear Bumper type 1"},
    {1155,"Stratum Front Bumper type 1"},
    {1156,"Stratum Rear Bumper type 2"},
    {1157,"Stratum Front Bumper type 2"},
    {1158,"Jester Spoiler type 2"},
    {1159,"Jester Rear Bumper type 1"},
    {1160,"Jester Front bumper type 1"},
    {1161,"Jester Rear bumper type2"},
    {1162,"Jester Spoiler type 1"},
    {1163,"Uranus Spoiler type 2"},
    {1164,"Uranus Spoiler type 1"},
    {1165,"Uranus Front Bumper type 2"},
    {1166,"Uranus Rear Bumper type 2"},
    {1167,"Uranus Front Bumper type 1"},
    {1168,"Uranus Rear Bumper type 1"},
    {1171,"Elegy Front Bumper type 1"},
    {1172,"Elegy Front Bumper type 2"},
    {1173,"Jester Front Bumper type 2"},
    {1174,"Broadway Front Bumper type 1"},
    {1175,"Broadway Front Bumper type 2"},
    {1176,"Broadway Rear Bumper type 1"},
    {1178,"Remington Rear Bumper type 2"},
    {1179,"Remington Front Bumper type 1"},
    {1180,"Remington Rear Bumper type 2"},
    {1181,"Blade Front Bumper type 2"},
    {1182,"Blade Front Bumper type 1"},
    {1183,"Blade Rear Bumper type 2"},
    {1184,"Blade Rear Bumper type 1"},
    {1185,"Remington Front Bumper type 2"},
    {1186,"Savanna Rear Bumper type 2"},
    {1187,"Savanna Rear Bumper type 1"},
    {1188,"Savanna Front Bumper type 2"},
    {1189,"Savanna Front Bumper type 1"},
    {1190,"Tornado Rear Bumper type 1"},
    {1191,"Tornado Rear Bumper type 2"},
    {1192,"Tornado Front Bumper type 1"},
    {1193,"Tornado Front Bumper type 2"},
    {1034,"Elegy Exhaust type 1"},
    {1035,"Elegy Roof Scoop Type 1"},
    {1036,"Elegy Side Skirt type 1 (L)"},
    {1037,"Elegy Exhaust Type 2"},
    {1038,"Elegy Roof Scoop type 2"},
    {1039,"Elegy Side Skirt type 2 (L)"},
    {1040,"Elegy Side Skirt type 1 (R)"},
    {1041,"Elegy Side Skirt type 2 (R)"},
    {1042,"Broadway Side Skirt (L)"},
    {1043,"Broadway Exhaust type 2"},
    {1044,"Broadway Exhaust type 1"},
    {1045,"Flash Exhaust type 2"},
    {1046,"Flash Exhaust type 1"},
    {1047,"Flash Side Skirt type 1 (L)"},
    {1048,"Flash Side Skirt type 2 (L)"},
    {1049,"Flash Spoiler type 1"},
    {1050,"Flash Spoiler type 2"},
    {1051,"Flash Side Skirt type 1 (R)"},
    {1052,"Flash Side Skirt type 2 (R)"},
    {1053,"Flash Roof Scoop type 2"},
    {1054,"Flash Roof Scoop type 1"},
    {1055,"Stratum Roof Scoop type 1"},
    {1056,"Stratum Side Skirt type 1 (L)"},
    {1057,"Stratum Side Skirt type 2 (L)"},
    {1058,"Stratum Spoiler type 1"},
    {1059,"Stratum Exhaust type 2"},
    {1060,"Stratum Spoiler type 2"},
    {1061,"Stratum Roof Scoop type 2"},
    {1062,"Stratum Side Skirt type 1 (R)"},
    {1063,"Stratum Side Skirt type 2 (R)"},
    {1064,"Stratum Exhaust type 1"},
    {1065,"Jester Exhaust type 1"},
    {1066,"Jester Exhaust type 2"},
    {1067,"Jester Roof Scoop type 1"},
    {1068,"Jester Roof Scoop type 2"},
    {1069,"Jester Side Skirt type 1 (L)"},
    {1070,"Jester Side Skirt type 2 (L)"},
    {1071,"Jester Side Skirt type 1 (R)"},
    {1072,"Jester Side Skirt type 2 (R)"},
    {1088,"Uranus Roof Scoop 1"},
    {1089,"Uranus Exhaust Type 1"},
    {1090,"Uranus Side Skirt type 1 (L)"},
    {1091,"Uranus Roof Scoop 2"},
    {1092,"Uranus Exhaust Type 2"},
    {1093,"Uranus Side Skirt type 2 (L)"},
    {1094,"Uranus Side Skirt type 1 (R)"},
    {1095,"Uranus Side Skirt type 2 (R)"},
    {1099,"Broadway Side Skirt (R)"},
    {1100,"Remington Misc. Part 1"},
    {1101,"Remington Side Skirt type 1 (R)"},
    {1102,"Savanna Side Skirt (R)"},
    {1103,"Blade Roof type 2"},
    {1104,"Blade Exhaust type 1"},
    {1105,"Blade Exhaust type 2"},
    {1106,"Remington Side Skirt type 2 (L)"},
    {1107,"Blade Side Skirt (R)"},
    {1108,"Blade Side Skirt (L)"},
    {1109,"Slamvan Rear Bullbars type 1"},
    {1110,"Slamvan Rear Bullbars type 2"},
    {1111,"Slamvan hood ornament 1 (not used)"},
    {1112,"Slamvan hood ornament 2 (not used)"},
    {1113,"Slamvan Exhaust type 1"},
    {1114,"Slamvan Exhaust type 2"},
    {1115,"Slamvan Front Bullbars type 1"},
    {1116,"Slamvan Front Bullbars type 2"},
    {1117,"Slamvan Front Bumper"},
    {1118,"Slamvan Side Skirt type 1 (L)"},
    {1119,"Slamvan Side Skirt type 2 (L)"},
    {1120,"Slamvan Side Skirt type 1 (R)"},
    {1121,"Slamvan Side Skirt type 2 (R)"},
    {1122,"Remington Side Skirt type 1 (L)"},
    {1123,"Remington Misc. Part 2"},
    {1124,"Remington Side Skirt type 2 (R)"},
    {1125,"Remington Misc. Part 3"},
    {1126,"Remington Exhaust type 1"},
    {1127,"Remington Exhaust type 2"},
    {1128,"Blade Roof Type 1"},
    {1129,"Savanna Exhaust type 1"},
    {1130,"Savanna Roof type 1"},
    {1131,"Savanna Roof type 2"},
    {1132,"Savanna Exhaust type 2"},
    {1133,"Savanna Side Skirt (L)"},
    {1134,"Tornado Side Skirt (L)"},
    {1135,"Tornado Exhaust type 2"},
    {1136,"Tornado Exhaust type 1"},
    {1137,"Tornado Side Skirt (R)"},
    {1142,"Oval Bonnet Vents (R)"},
    {1143,"Oval Bonnet Vents (L)"},
    {1144,"Square Bonnet Vents (R)"},
    {1145,"Square Bonnet Vents (L)"},
    {19310,"Taxi Cab White"},
    {19311,"Taxi Cab Black"},
    {18646,"Police_Light1"},
    {19797,"Police_Visor_Strobe1"},
    {19306,"Red_flag1"},
    {19307,"Blue_flag2"},
    {19620,"Light_Bar1"},
    {11701,"Ambulance_Lights1"},
    {19419,"Police_lights01"},
    {19834,"PoliceLine1"}
};

Bodypart_Name(model)
{
    new name[37];
    forex(i, sizeof(BodyWork)) if(BodyWork[i][Id] == model) {
        strunpack(name, BodyWork[i][Model], sizeof(name));
        return name;
    }
    strunpack(name, "Unknown");
    return name;
}

Vehicle_ObjectLoad(id)
{
	new query[256];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `vehicle_object` WHERE vehicle = '%d'", VehicleData[id][cID]);
	mysql_tquery(g_SQL, query, "LoadVehicleObjects", "d", id);
}

public:LoadVehicleObjects(id)
{
	if(cache_num_rows())
	{
		for(new slot = 0; slot != cache_num_rows(); slot++) if(!VehicleObjects[id][slot][object_exists])
		{
			VehicleObjects[id][slot][object_exists] = true;

			new 
				query[24]
			;
			cache_get_value(slot, "color", query, 24);
            sscanf(query, "p<|>ddddd", VehicleObjects[id][slot][object_color][0], VehicleObjects[id][slot][object_color][1], VehicleObjects[id][slot][object_color][2], VehicleObjects[id][slot][object_color][3], VehicleObjects[id][slot][object_color][4]);

			cache_get_value(slot, "text", VehicleObjects[id][slot][object_text], 128);
			cache_get_value(slot, "font", VehicleObjects[id][slot][object_fonts], 32);			

			cache_get_value_int(slot, "id", VehicleObjects[id][slot][object_id]);
			cache_get_value_int(slot, "vehicle", VehicleObjects[id][slot][object_vehicle]);
			cache_get_value_int(slot, "type", VehicleObjects[id][slot][object_type]);
			cache_get_value_int(slot, "model", VehicleObjects[id][slot][object_model]);
			cache_get_value_int(slot, "fontcolor", VehicleObjects[id][slot][object_fontcolor]);
			cache_get_value_int(slot, "fontsize", VehicleObjects[id][slot][object_fontsize]);
			cache_get_value_int(slot, "toggle", VehicleObjects[id][slot][object_toggle]);

			cache_get_value_float(slot, "x", VehicleObjects[id][slot][object_x]);
			cache_get_value_float(slot, "y", VehicleObjects[id][slot][object_y]);
			cache_get_value_float(slot, "z", VehicleObjects[id][slot][object_z]);

			cache_get_value_float(slot, "rx", VehicleObjects[id][slot][object_rx]);
			cache_get_value_float(slot, "ry", VehicleObjects[id][slot][object_ry]);
			cache_get_value_float(slot, "rz", VehicleObjects[id][slot][object_rz]); 

			if(IsValidVehicle(VehicleData[id][cVeh])) Vehicle_ObjectUpdate(id, slot);
		}
	}
	return 1;
}

Vehicle_ObjectAdd(id, model, type)
{
	for(new slot = 0; slot != MAX_VEHICLE_OBJECT; slot++) if(VehicleObjects[id][slot][object_exists] == false)
	{
		VehicleObjects[id][slot][object_exists] = true;

		VehicleObjects[id][slot][object_type] = type;
		VehicleObjects[id][slot][object_vehicle] = VehicleData[id][cID];
		VehicleObjects[id][slot][object_model] = model;		

		for(new mx = 0; mx != MAX_COLOR_MATERIAL; mx++) {
			VehicleObjects[id][slot][object_color][mx] = 1;
		}

		VehicleObjects[id][slot][object_toggle] = false;

		VehicleObjects[id][slot][object_x] = 0.0;
		VehicleObjects[id][slot][object_y] = 0.0;
		VehicleObjects[id][slot][object_z] = 0.0;

		VehicleObjects[id][slot][object_rx] = 0.0;
		VehicleObjects[id][slot][object_ry] = 0.0;
		VehicleObjects[id][slot][object_rz] = 0.0;

		if(VehicleObjects[id][slot][object_type] == OBJECT_TYPE_TEXT)
		{
			format(VehicleObjects[id][slot][object_text], 128, "Text Here");
			format(VehicleObjects[id][slot][object_fonts], 24, "Arial");
			VehicleObjects[id][slot][object_fontcolor] = 1;
			VehicleObjects[id][slot][object_fontsize] = 40;
		}

		Vehicle_ObjectUpdate(id, slot);

		mysql_tquery(g_SQL, sprintf("INSERT INTO `vehicle_object` (`vehicle`) VALUES ('%d')", VehicleObjects[id][slot][object_vehicle]), "Vehicle_ObjectDB", "dd", id, slot);
		return 1;
	}
	return 0;
}

Vehicle_ObjectSave(id, slot)
{
	if(!VehicleObjects[id][slot][object_exists])
		return 0;

	new query[1500];

	format(query, sizeof(query), "UPDATE `vehicle_object` SET `model`='%d',`toggle`='%d', `color`='%d|%d|%d|%d|%d',`type`='%d',	`x`='%f',`y`='%f',`z`='%f', `rx`='%f',`ry`='%f',`rz`='%f'",
		 VehicleObjects[id][slot][object_model], VehicleObjects[id][slot][object_toggle], VehicleObjects[id][slot][object_color][0], VehicleObjects[id][slot][object_color][1],
		 VehicleObjects[id][slot][object_color][2], VehicleObjects[id][slot][object_color][3], VehicleObjects[id][slot][object_color][4], VehicleObjects[id][slot][object_type],
		 VehicleObjects[id][slot][object_x], VehicleObjects[id][slot][object_y], VehicleObjects[id][slot][object_z], VehicleObjects[id][slot][object_rx],
		 VehicleObjects[id][slot][object_ry], VehicleObjects[id][slot][object_rz]
	);

	format(query, sizeof(query), "%s, `text`='%s',`font`='%s', `fontsize`='%d',`fontcolor`='%d' WHERE `id`='%d' AND vehicle = %d",
		 query, SQL_EscapeString(VehicleObjects[id][slot][object_text]), VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize], VehicleObjects[id][slot][object_fontcolor], VehicleObjects[id][slot][object_id], VehicleData[id][cID]
	);
	
	mysql_tquery(g_SQL, query);
	return 1;
}

Vehicle_ObjectUpdateAll(id, sync = 1)
{
    forex(slot, MAX_VEHICLE_OBJECT) if(VehicleObjects[id][slot][object_exists])
    {
        Vehicle_ObjectUpdate(id, slot, sync);
    }
    return 1;
}

Vehicle_ObjectUpdate(id, slot, sync = 1)
{    
	if(!IsValidVehicle(VehicleData[id][cVeh]))
		return 0;

	if (sync) 
    {
		if (IsValidDynamicObject(VehicleObjects[id][slot][object_streamer]))
				DestroyDynamicObject(VehicleObjects[id][slot][object_streamer]);

        GetVehiclePos(VehicleData[id][cVeh], VehicleData[id][cPosX], VehicleData[id][cPosY], VehicleData[id][cPosZ]);
        GetVehicleZAngle(VehicleData[id][cVeh], VehicleData[id][cPosA]);
		VehicleObjects[id][slot][object_streamer] = CreateDynamicObject(VehicleObjects[id][slot][object_model], VehicleData[id][cPosX], VehicleData[id][cPosY], VehicleData[id][cPosZ]/*VehicleObjects[id][slot][object_x], VehicleObjects[id][slot][object_y], VehicleObjects[id][slot][object_z]*/, VehicleObjects[id][slot][object_rx], VehicleObjects[id][slot][object_ry], VehicleObjects[id][slot][object_rz]);
	}

	if(VehicleObjects[id][slot][object_type] == OBJECT_TYPE_BODY)
	{
		for(new mx = 0; mx != MAX_COLOR_MATERIAL; mx++) {
			SetDynamicObjectMaterial(VehicleObjects[id][slot][object_streamer], mx, VehicleObjects[id][slot][object_model], "none", "none", RGBAToARGB(ColorList[VehicleObjects[id][slot][object_color][mx]]));
		}
	}
	else SetDynamicObjectMaterialText(VehicleObjects[id][slot][object_streamer], 0, VehicleObjects[id][slot][object_text], OBJECT_MATERIAL_SIZE_512x512, VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize], 1, RGBAToARGB(ColorList[VehicleObjects[id][slot][object_fontcolor]]), 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[id][slot][object_streamer], E_STREAMER_DRAW_DISTANCE, 25);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[id][slot][object_streamer], E_STREAMER_STREAM_DISTANCE, 25);

	if (sync) 
    {
		AttachDynamicObjectToVehicle(VehicleObjects[id][slot][object_streamer], VehicleData[id][cVeh], VehicleObjects[id][slot][object_x], VehicleObjects[id][slot][object_y], VehicleObjects[id][slot][object_z], VehicleObjects[id][slot][object_rx], VehicleObjects[id][slot][object_ry], VehicleObjects[id][slot][object_rz]);
	}
	return 1;
}

Vehicle_ObjectDespawnAll(id)
{
    forex(slot, MAX_VEHICLE_OBJECT) if(VehicleObjects[id][slot][object_exists])
    {
        Vehicle_ObjectDespawn(id, slot);
    }
    return 1;
}

Vehicle_ObjectDespawn(id, slot)
{
    if(IsValidDynamicObject(VehicleObjects[id][slot][object_streamer]))
        DestroyDynamicObject(VehicleObjects[id][slot][object_streamer]);

    VehicleObjects[id][slot][object_streamer] = INVALID_STREAMER_ID;
    return 1;
}

Vehicle_ObjectReset(id, slot, remove = 0)
{
    if(IsValidDynamicObject(VehicleObjects[id][slot][object_streamer]))
        DestroyDynamicObject(VehicleObjects[id][slot][object_streamer]);

    VehicleObjects[id][slot][object_streamer] = INVALID_STREAMER_ID;

    VehicleObjects[id][slot][object_model] = 0;
    VehicleObjects[id][slot][object_toggle] = false;
    VehicleObjects[id][slot][object_exists] = false;

    for(new mx = 0; mx != MAX_COLOR_MATERIAL; mx++) {
	    VehicleObjects[id][slot][object_color][mx] = 1;
	}

    VehicleObjects[id][slot][object_x] = VehicleObjects[id][slot][object_y] = VehicleObjects[id][slot][object_z] = 0.0;
    VehicleObjects[id][slot][object_rx] = VehicleObjects[id][slot][object_ry] = VehicleObjects[id][slot][object_rz] = 0.0;

    if(remove) mysql_tquery(g_SQL, sprintf("DELETE FROM `vehicle_object` WHERE `id` = '%d'", VehicleObjects[id][slot][object_id]));

    VehicleObjects[id][slot][object_id] = 0;
    return 1;
}

Vehicle_ObjectEdit(playerid, id, slot)
{
	if(PlayerTemp[playerid][temp_pivot] != INVALID_STREAMER_ID)
	{
		DestroyDynamicObject(PlayerTemp[playerid][temp_pivot]);
		PlayerTemp[playerid][temp_pivot] = INVALID_STREAMER_ID;
	}
	
	GetVehiclePos(VehicleData[id][cVeh], VehicleData[id][cPosX], VehicleData[id][cPosY], VehicleData[id][cPosZ]);
    GetVehicleZAngle(VehicleData[id][cVeh], VehicleData[id][cPosA]);

	PlayerTemp[playerid][temp_voldpos][0] = VehicleObjects[id][slot][object_x];
	PlayerTemp[playerid][temp_voldpos][1] = VehicleObjects[id][slot][object_y];
	PlayerTemp[playerid][temp_voldpos][2] = VehicleObjects[id][slot][object_z];
	PlayerTemp[playerid][temp_voldpos][3] = VehicleObjects[id][slot][object_rx];
	PlayerTemp[playerid][temp_voldpos][4] = VehicleObjects[id][slot][object_ry];
	PlayerTemp[playerid][temp_voldpos][5] = VehicleObjects[id][slot][object_rz];

	DestroyDynamicObject(VehicleObjects[id][slot][object_streamer]);
	
	PlayerTemp[playerid][temp_pivot] = CreateDynamicObject(VehicleObjects[id][slot][object_model], VehicleData[id][cPosX], VehicleData[id][cPosY], VehicleData[id][cPosZ], VehicleObjects[id][slot][object_ry], VehicleObjects[id][slot][object_ry], VehicleData[id][cPosA]);
	if(VehicleObjects[id][slot][object_type] == OBJECT_TYPE_BODY)
	{
		for(new mx = 0; mx != MAX_COLOR_MATERIAL; mx++) {
			SetDynamicObjectMaterial(PlayerTemp[playerid][temp_pivot], mx, VehicleObjects[id][slot][object_model], "none", "none", RGBAToARGB(ColorList[VehicleObjects[id][slot][object_color][mx]]));
		}
	}
	else SetDynamicObjectMaterialText(PlayerTemp[playerid][temp_pivot], 0, VehicleObjects[id][slot][object_text], 512, VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize], 1, RGBAToARGB(ColorList[VehicleObjects[id][slot][object_fontcolor]]), 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	
	Streamer_Update(playerid);
	PlayerData[playerid][pGetVTOYID] = id;
	EditDynamicObject(playerid, PlayerTemp[playerid][temp_pivot]);
	return 1;
}

Vehicle_ObjectColor(playerid, id, slot)
{
	new color[155];
    for(new mx = 0; mx != MAX_COLOR_MATERIAL; mx++)  
    {
        strcat(color, sprintf("{%06x}Color #%d %s\n", ColorList[VehicleObjects[id][slot][object_color][mx]] >>> 8, mx+1, (VehicleObjects[id][slot][object_color][mx] == 1) ? ("(original)") : ("")));
    }
    ShowPlayerDialog(playerid, DIALOG_VACC_OPTION_COLOR, DIALOG_STYLE_LIST, "Select Index", color, "Select", "Close");
    return 1;
}

public:Vehicle_ObjectDB(id, slot)
{
	if(VehicleObjects[id][slot][object_exists] == false)
		return 0;

	VehicleObjects[id][slot][object_id] = cache_insert_id();

	Vehicle_ObjectSave(id, slot);
	return 1;
}

CMD:fanvtoy(playerid, params[]) 
{
    if(!IsPlayerFann(playerid)) 
        return PermissionError(playerid);

    new vehicleid, model;
    if(sscanf(params, "dd", vehicleid, model))
        return SendSyntaxMessage(playerid, "/fanvtoy [vehicleid] [modelid]");

    new vid;
    if(!IsValidVehicle(vehicleid) || (vid = Vehicle_GetID(vehicleid)) == -1) 
        return SendErrorMessage(playerid, "Invalid vehicle id!");

    Vehicle_ObjectAdd(vid, model, OBJECT_TYPE_BODY);
    Streamer_Update(playerid);
    SendCustomMessage(playerid, "VTOY", "Toy has been attached to the vehicle!");
    return 1;
}

CMD:vacc(playerid, params[])
{
    new 
        id,
        str[255];

    if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return SendErrorMessage(playerid, "Kamu harus mengendarai kendaraan!");

    if(Player_NearModshop(playerid) != 0)
    {
        if((id = Vehicle_GetID(GetPlayerVehicleID(playerid))) != -1 && Vehicle_IsOwner(playerid, id))
        {
            if(GetEngineStatus(GetPlayerVehicleID(playerid)))
                return SendErrorMessage(playerid, "Turn off vehicle engine first.");

            for (new i = 0; i < MAX_VEHICLE_OBJECT; i++)
            {
                if (PlayerData[playerid][pVipTime] > 0) {
                    if(VehicleObjects[id][i][object_exists]) format(str, sizeof(str), "%s%d: %s\n", str, i+1, (VehicleObjects[id][i][object_type] == OBJECT_TYPE_BODY) ? (Bodypart_Name(VehicleObjects[id][i][object_model])) : ("Sticker"));
                    else format(str, sizeof(str), "%s%d: Empty\n", str, i+1);
                } 
                else 
                {
                    if (i < 5) 
                    {
                        if(VehicleObjects[id][i][object_exists]) format(str, sizeof(str), "%s%d: %s\n", str, i+1, (VehicleObjects[id][i][object_type] == OBJECT_TYPE_BODY) ? (Bodypart_Name(VehicleObjects[id][i][object_model])) : ("Sticker"));
                        if (!VehicleObjects[id][i][object_exists]) format(str,sizeof(str),"%s%d: Empty\n",str,i+1);
                    }
                }
            }
            PlayerData[playerid][pGetVTOYID] = id;
            ShowPlayerDialog(playerid, DIALOG_VACC, DIALOG_STYLE_LIST, "Vehicle Accesories", str, "Select", "Close");
            return 1;
        }  
        SendErrorMessage(playerid, "Kendaraan ini bukan milikmu!");
        return 1;
    }
    SendErrorMessage(playerid, "Anda tidak berada di modshop!");    
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_VACC)
    {
        if(response)
        {
            new id = PlayerData[playerid][pGetVTOYID];

            if(Iter_Contains(PlayerVehicles, id))
            {
                if(GetEngineStatus(GetPlayerVehicleID(playerid)))
                    return SendErrorMessage(playerid, "Turn off vehicle engine first.");

                if(!VehicleObjects[id][listitem][object_exists]) 
                {
                    if (GetPlayerMoney(playerid) < VEHICLE_OBJECT_PRICE)
                        return SendErrorMessage(playerid, "You don't have %s for install mods.", FormatMoney(VEHICLE_OBJECT_PRICE));

                    ShowPlayerDialog(playerid, DIALOG_VACC_INDEX, DIALOG_STYLE_LIST, "Select Type", "Sticker\nMods", "Select", "Back");
                    return 1;
                }

                if (GetPlayerMoney(playerid) < VEHICLE_OBJECT_EDIT_PRICE)
                    return SendErrorMessage(playerid, "You don't have %s for editing mods.", FormatMoney(VEHICLE_OBJECT_EDIT_PRICE));
                    
                PlayerData[playerid][pVtoySelect] = listitem;
                ShowPlayerDialog(playerid, DIALOG_VACC_EDIT, DIALOG_STYLE_LIST, "Vehicle Accesories > Edit", "%s\nEdit Position\nRemove From Vehicle", "Select", "Back", VehicleObjects[id][listitem][object_type] == OBJECT_TYPE_BODY ? ("Set Color") : ("Edit Text"));
            }
            else SendErrorMessage(playerid, "This vehicle object does'nt exists."), PlayerData[playerid][pGetVTOYID] = -1;
        }
    }
    if(dialogid == DIALOG_VACC_INDEX)
    {
        if (response) 
        {
            switch (listitem) 
            {
                case 0: 
                {
                    new
                        vehicleid = GetPlayerVehicleID(playerid),
                        id;

                    if ((id = Vehicle_GetID(vehicleid)) != -1 && Vehicle_IsOwner(playerid, id)) 
                    {
                        Vehicle_ObjectAdd(id, 18659, OBJECT_TYPE_TEXT);
                        Streamer_Update(playerid);
                        GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_PRICE);
                        SendCustomMessage(playerid, "MODSHOP", "You have select "YELLOW_E"Sticker "WHITE_E"for this vehicle (/vacc to edit vehicle object).");
                        return 1;
                    }
                }
                case 1: 
                {
                    new 
                        vehicleid = GetPlayerVehicleID(playerid);

                    if(IsAMotor(vehicleid))
                        return SendErrorMessage(playerid, "This vehicle isn't supported with mods!");

                    new list[181];
                    forex(i, sizeof(BodyWork))
                    {
                        list[i] = BodyWork[i][Id];
                    }
                    ShowModelSelectionMenu(playerid, "Vehicle Mod", VEHICLE_TOYS, list, sizeof(list));
                }
            }
        } 
        else callcmd::vacc(playerid, "\1");
    }
    if(dialogid == DIALOG_VACC_EDIT)
    {   
        if(response)
        {
            new slot = PlayerData[playerid][pVtoySelect],
                id = PlayerData[playerid][pGetVTOYID];

            switch(listitem)
            {
                case 0: 
                {
                    if(VehicleObjects[id][slot][object_type] == OBJECT_TYPE_BODY) Vehicle_ObjectColor(playerid, id, slot);
                    else ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_TEXT, DIALOG_STYLE_TABLIST_HEADERS, "Edit Text", "Option\tData\nChange\t%s\nFont Color\t{%06x}%d\nFont Name\t%s\nFont Size\t%d", "Select", "Back", VehicleObjects[id][slot][object_text], ColorList[VehicleObjects[id][slot][object_fontcolor]] >>> 8, VehicleObjects[id][slot][object_fontcolor], VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize]);
                }
                case 1: 
                {
                    ShowPlayerDialog(playerid, DIALOG_VACC_EDIT_POSSEL, DIALOG_STYLE_LIST, "Edit Position", "For PC\nFor Android", "Select", "Close");
                }
                case 2: ShowPlayerDialog(playerid, DIALOG_VACC_REMOVE, DIALOG_STYLE_MSGBOX, "Remove Confirmation", "Do you want to remove this object vehicle?.", "Yes", "No (Close)");
            }
        }
        else callcmd::vacc(playerid, "\1");
    }
    if(dialogid == DIALOG_VACC_EDIT_POSSEL)
    {
        if (response) 
        {
            new slot = PlayerData[playerid][pVtoySelect],
                id = PlayerData[playerid][pGetVTOYID];

            switch (listitem) 
            {
                // For PC
                case 0: Vehicle_ObjectEdit(playerid, id, slot);

                // For Android
                case 1: 
                {
                    new str[256];
                    format(str,sizeof(str),"Position\tValue\n");
                    format(str,sizeof(str),"%sX\t%.3f\n",str,VehicleObjects[ id ][ slot ][object_x]);
                    format(str,sizeof(str),"%sY\t%.3f\n",str,VehicleObjects[ id ][ slot ][object_y]);
                    format(str,sizeof(str),"%sZ\t%.3f\n",str,VehicleObjects[ id ][ slot ][object_z]);
                    format(str,sizeof(str),"%sRX\t%.3f\n",str,VehicleObjects[ id ][ slot ][object_rx]);
                    format(str,sizeof(str),"%sRY\t%.3f\n",str,VehicleObjects[ id ][ slot ][object_ry]);
                    format(str,sizeof(str),"%sRZ\t%.3f",str,VehicleObjects[ id ][ slot ][object_rz]);
                    ShowPlayerDialog(playerid, DIALOG_VACC_EDIT_POSITION, DIALOG_STYLE_TABLIST_HEADERS, "Edit Position Android", str, "Change", "Close");
                }
            }
        }
    }
    if(dialogid == DIALOG_VACC_EDIT_POSITION)
    {
        if (response) 
        {
            new str[256],
                slot = PlayerData[playerid][pVtoySelect],
                id = PlayerData[playerid][pGetVTOYID];

            switch (listitem) 
            {
                // X
                case 0: 
                {
                    SetPVarInt(playerid, "editPosVehObject", 1);
                    format(str,sizeof(str),"Current Value: {FFFFFF}%.3f", VehicleObjects[ id ][ slot ][object_x]);
                    ShowPlayerDialog(playerid, DIALOG_VACC_EDIT_POS, DIALOG_STYLE_INPUT, "X Position", str, "Set", "Close");
                }
                // Y
                case 1: 
                {
                    SetPVarInt(playerid, "editPosVehObject", 2);
                    format(str,sizeof(str),"Current Value: {FFFFFF}%.3f", VehicleObjects[ id ][ slot ][object_y]);
                    ShowPlayerDialog(playerid, DIALOG_VACC_EDIT_POS, DIALOG_STYLE_INPUT, "Y Position", str, "Set", "Close");
                }
                // Z
                case 2: 
                {
                    SetPVarInt(playerid, "editPosVehObject", 3);
                    format(str,sizeof(str),"Current Value: {FFFFFF}%.3f", VehicleObjects[ id ][ slot ][object_z]);
                    ShowPlayerDialog(playerid, DIALOG_VACC_EDIT_POS, DIALOG_STYLE_INPUT, "Z Position", str, "Set", "Close");
                }
                // RX
                case 3: 
                {
                    SetPVarInt(playerid, "editPosVehObject", 4);
                    format(str,sizeof(str),"Current Value: {FFFFFF}%.3f", VehicleObjects[ id ][ slot ][object_rx]);
                    ShowPlayerDialog(playerid, DIALOG_VACC_EDIT_POS, DIALOG_STYLE_INPUT, "RX Position", str, "Set", "Close");
                }
                // RY
                case 4: 
                {
                    SetPVarInt(playerid, "editPosVehObject", 5);
                    format(str,sizeof(str),"Current Value: {FFFFFF}%.3f", VehicleObjects[ id ][ slot ][object_ry]);
                    ShowPlayerDialog(playerid, DIALOG_VACC_EDIT_POS, DIALOG_STYLE_INPUT, "RY Position", str, "Set", "Close");
                }
                // RZ
                case 5: 
                {
                    SetPVarInt(playerid, "editPosVehObject", 6);
                    format(str,sizeof(str),"Current Value: {FFFFFF}%.3f", VehicleObjects[ id ][ slot ][object_rz]);
                    ShowPlayerDialog(playerid, DIALOG_VACC_EDIT_POS, DIALOG_STYLE_INPUT, "RZ Position", str, "Set", "Close");
                }
            }
        }
    }
    if(dialogid == DIALOG_VACC_EDIT_POS)
    {
        if (response) 
        {
            new Float:value = floatstr(inputtext),
                slot = PlayerData[playerid][pVtoySelect],
                id = PlayerData[playerid][pGetVTOYID],
                Float:v_size[3];

            GetVehicleModelInfo(VehicleData[id][cModel], VEHICLE_MODEL_INFO_SIZE, v_size[0], v_size[1], v_size[2]);

            if (GetPVarInt(playerid, "editPosVehObject") == 1 && (value >= v_size[0] || -v_size[0] >= VehicleObjects[ id ][ slot ][object_x]) || 
            GetPVarInt(playerid, "editPosVehObject") == 2 && (value >= v_size[1] || -v_size[1] >= value) ||
            GetPVarInt(playerid, "editPosVehObject") == 3 && (value >= v_size[2] || -v_size[2] >= value)) 
            {
                InfoTD_MSG(playerid, 5000, "Posisi object terlalu jauh dari body kendaraan.");
                return 1;
            }

            PlayerPlaySound(playerid, SOUND_CAR_MOD);

            switch (GetPVarInt(playerid, "editPosVehObject")) 
            {
                // X Position
                case 1: 
                {
                    VehicleObjects[ id ][ slot ][object_x] = value;
                    GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);
                    Vehicle_ObjectUpdate(id, slot, 0);
                    Vehicle_ObjectSave(id, slot);
                    SendCustomMessage(playerid, "MODSHOP", "Vehicle object saved!");
                }
                // Y Position
                case 2: 
                {
                    VehicleObjects[ id ][ slot ][object_y] = value;
                    GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);
                    Vehicle_ObjectUpdate(id, slot, 0);
                    Vehicle_ObjectSave(id, slot);
                    SendCustomMessage(playerid, "MODSHOP", "Vehicle object saved!");
                }
                // Z Position
                case 3: 
                {
                    VehicleObjects[ id ][ slot ][object_z] = value;
                    GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);
                    Vehicle_ObjectUpdate(id, slot, 0);
                    Vehicle_ObjectSave(id, slot);
                    SendCustomMessage(playerid, "MODSHOP", "Vehicle object saved!");
                }
                // RX Position
                case 4: 
                {
                    VehicleObjects[ id ][ slot ][object_rx] = value;
                    GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);
                    Vehicle_ObjectUpdate(id, slot, 0);
                    Vehicle_ObjectSave(id, slot);
                    SendCustomMessage(playerid, "MODSHOP", "Vehicle object saved!");
                }
                // RY Position
                case 5: 
                {
                    VehicleObjects[ id ][ slot ][object_ry] = value;
                    GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);
                    Vehicle_ObjectUpdate(id, slot, 0);
                    Vehicle_ObjectSave(id, slot);
                    SendCustomMessage(playerid, "MODSHOP", "Vehicle object saved!");
                }
                // RZ Position
                case 6: 
                {
                    VehicleObjects[ id ][ slot ][object_rz] = value;
                    GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);
                    Vehicle_ObjectUpdate(id, slot, 0);
                    Vehicle_ObjectSave(id, slot);
                    SendCustomMessage(playerid, "MODSHOP", "Vehicle object saved!");
                }
            }
        }
    }
    if(dialogid == DIALOG_VACC_OBJECT_TEXT)
    {
        new slot = PlayerData[playerid][pVtoySelect],
            id = PlayerData[playerid][pGetVTOYID];

        if(response)
        {
            switch(listitem)
            {
                case 0: ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_FONTNAME, DIALOG_STYLE_INPUT, "Change Text ...", "Masukkan teks untuk mengubah teks pada kendaraan.\nTeks minimal 0 - 128 karakter.", "Set", "Back");
                case 1: ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_FONTCOLOR, DIALOG_STYLE_INPUT, "Font Color", color_string, "Set", "Back");
                case 2: 
                {
                    new fonts[256];
                    for (new i; i < sizeof(FontNames); i++) 
                    {
                        strcat(fonts,FontNames[i],sizeof(fonts));
                        strcat(fonts,"\n",sizeof(fonts));
                    }
                    strcat(fonts,"Custom",sizeof(fonts));
                    ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_FONT, DIALOG_STYLE_LIST, "Font Name", fonts, "Set", "Back");
                }
                case 3: ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_FONTSIZE, DIALOG_STYLE_INPUT, "Font Size", "Masukkan ukuran tulisan, ukuran minimal 1 dan maksimal 255.\nPenyalahgunaan akan mendapat sanksi berupa "RED_E"BANNED.", "Set", "Back");
            }
        }
        else ShowPlayerDialog(playerid, DIALOG_VACC_EDIT, DIALOG_STYLE_LIST, "Vehicle Accesories > Edit", "%s\nEdit Position\nRemove From Vehicle", "Select", "Back", VehicleObjects[id][slot][object_type] == OBJECT_TYPE_BODY ? ("Set Color") : ("Edit Text"));
    }
    if(dialogid == DIALOG_VACC_OBJECT_FONTNAME)
    {
        new slot = PlayerData[playerid][pVtoySelect],
            id = PlayerData[playerid][pGetVTOYID];

        if(response)
        {
            if(strlen(inputtext) < 0 || strlen(inputtext) > 128)
                return ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_FONTNAME, DIALOG_STYLE_INPUT, "Change Text ...", "Masukkan teks untuk mengubah teks pada kendaraan.\nTeks minimal 0 - 128 karakter.", "Set", "Close");

            FixText(inputtext);
            format(VehicleObjects[id][slot][object_text], 128, ColouredText(inputtext));
            GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);
            Vehicle_ObjectUpdate(id, slot, 0);
            Vehicle_ObjectSave(id, slot);

            ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_TEXT, DIALOG_STYLE_TABLIST_HEADERS, "Edit Text", "Option\tData\nChange\t%s\nFont Color\t{%06x}%d\nFont Name\t%s\nFont Size\t%d", "Select", "Back", VehicleObjects[id][slot][object_text], ColorList[VehicleObjects[id][slot][object_fontcolor]] >>> 8, VehicleObjects[id][slot][object_fontcolor], VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize]);
        }
        else ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_TEXT, DIALOG_STYLE_TABLIST_HEADERS, "Edit Text", "Option\tData\nChange\t%s\nFont Color\t{%06x}%d\nFont Name\t%s\nFont Size\t%d", "Select", "Back", VehicleObjects[id][slot][object_text], ColorList[VehicleObjects[id][slot][object_fontcolor]] >>> 8, VehicleObjects[id][slot][object_fontcolor], VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize]);
    }
    if(dialogid == DIALOG_VACC_OBJECT_FONTCOLOR)
    {
        new slot = PlayerData[playerid][pVtoySelect],
            id = PlayerData[playerid][pGetVTOYID],
            color = strval(inputtext);

        if(response)
        {
            if(!(0 <= color <= sizeof(ColorList)-1))
                return ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_FONTCOLOR, DIALOG_STYLE_INPUT, "Font Color", color_string, "Set", "Close");

            VehicleObjects[id][slot][object_fontcolor] = color;
            GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);
            Vehicle_ObjectUpdate(id, slot, 0);
            Vehicle_ObjectSave(id, slot);

            ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_TEXT, DIALOG_STYLE_TABLIST_HEADERS, "Edit Text", "Option\tData\nChange\t%s\nFont Color\t{%06x}%d\nFont Name\t%s\nFont Size\t%d", "Select", "Back", VehicleObjects[id][slot][object_text], ColorList[VehicleObjects[id][slot][object_fontcolor]] >>> 8, VehicleObjects[id][slot][object_fontcolor], VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize]);
        }
        else ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_TEXT, DIALOG_STYLE_TABLIST_HEADERS, "Edit Text", "Option\tData\nChange\t%s\nFont Color\t{%06x}%d\nFont Name\t%s\nFont Size\t%d", "Select", "Back", VehicleObjects[id][slot][object_text], ColorList[VehicleObjects[id][slot][object_fontcolor]] >>> 8, VehicleObjects[id][slot][object_fontcolor], VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize]);
    }
    if(dialogid == DIALOG_VACC_OBJECT_FONT)
    {
        new slot = PlayerData[playerid][pVtoySelect],
        id = PlayerData[playerid][pGetVTOYID];

        if(response)
        {
            if (listitem < sizeof(FontNames)) 
            {
                format(VehicleObjects[id][slot][object_fonts], 32, inputtext);
                GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);

                Vehicle_ObjectUpdate(id, slot, 0);
                Vehicle_ObjectSave(id, slot);

                ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_TEXT, DIALOG_STYLE_TABLIST_HEADERS, "Edit Text", "Option\tData\nChange\t%s\nFont Color\t{%06x}%d\nFont Name\t%s\nFont Size\t%d", "Select", "Back", VehicleObjects[id][slot][object_text], ColorList[VehicleObjects[id][slot][object_fontcolor]] >>> 8, VehicleObjects[id][slot][object_fontcolor], VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize]);
            } 
            else ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_CUSTOMFONT, DIALOG_STYLE_INPUT, "Custom Font Name", "Input font name:", "Input", "Back");
        }
        else ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_TEXT, DIALOG_STYLE_TABLIST_HEADERS, "Edit Text", "Option\tData\nChange\t%s\nFont Color\t{%06x}%d\nFont Name\t%s\nFont Size\t%d", "Select", "Back", VehicleObjects[id][slot][object_text], ColorList[VehicleObjects[id][slot][object_fontcolor]] >>> 8, VehicleObjects[id][slot][object_fontcolor], VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize]);
    }
    if(dialogid == DIALOG_VACC_OBJECT_CUSTOMFONT)
    {
        new slot = PlayerData[playerid][pVtoySelect],
            id = PlayerData[playerid][pGetVTOYID];

        if (response) 
        {
            if (isnull(inputtext))
                return SendErrorMessage(playerid, "Invalid input!");

            format(VehicleObjects[id][slot][object_fonts], 32, inputtext);
            GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);

            Vehicle_ObjectUpdate(id, slot, 0);
            Vehicle_ObjectSave(id, slot);

            ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_TEXT, DIALOG_STYLE_TABLIST_HEADERS, "Edit Text", "Option\tData\nChange\t%s\nFont Color\t{%06x}%d\nFont Name\t%s\nFont Size\t%d", "Select", "Back", VehicleObjects[id][slot][object_text], ColorList[VehicleObjects[id][slot][object_fontcolor]] >>> 8, VehicleObjects[id][slot][object_fontcolor], VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize]);
        } 
        else ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_TEXT, DIALOG_STYLE_TABLIST_HEADERS, "Edit Text", "Option\tData\nChange\t%s\nFont Color\t{%06x}%d\nFont Name\t%s\nFont Size\t%d", "Select", "Back", VehicleObjects[id][slot][object_text], ColorList[VehicleObjects[id][slot][object_fontcolor]] >>> 8, VehicleObjects[id][slot][object_fontcolor], VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize]);
    }
    if(dialogid == DIALOG_VACC_OBJECT_FONTSIZE)
    {
        new slot = PlayerData[playerid][pVtoySelect],
            id = PlayerData[playerid][pGetVTOYID];

        if(response)
        {
            if(strval(inputtext) < 1 || strval(inputtext) > 255)
                return ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_FONTSIZE, DIALOG_STYLE_INPUT, "Font Size", "Masukkan ukuran tulisan, ukuran minimal 1 dan maksimal 255.\nPenyalahgunaan akan mendapat sanksi berupa {FF0000}BANNED.", "Set", "Close");

            VehicleObjects[id][slot][object_fontsize] = strval(inputtext);
            GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);

            Vehicle_ObjectUpdate(id, slot, 0);
            Vehicle_ObjectSave(id, slot);

            ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_TEXT, DIALOG_STYLE_TABLIST_HEADERS, "Edit Text", "Option\tData\nChange\t%s\nFont Color\t{%06x}%d\nFont Name\t%s\nFont Size\t%d", "Select", "Back", VehicleObjects[id][slot][object_text], ColorList[VehicleObjects[id][slot][object_fontcolor]] >>> 8, VehicleObjects[id][slot][object_fontcolor], VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize]);
        }
        else ShowPlayerDialog(playerid, DIALOG_VACC_OBJECT_TEXT, DIALOG_STYLE_TABLIST_HEADERS, "Edit Text", "Option\tData\nChange\t%s\nFont Color\t{%06x}%d\nFont Name\t%s\nFont Size\t%d", "Select", "Back", VehicleObjects[id][slot][object_text], ColorList[VehicleObjects[id][slot][object_fontcolor]] >>> 8, VehicleObjects[id][slot][object_fontcolor], VehicleObjects[id][slot][object_fonts], VehicleObjects[id][slot][object_fontsize]);
    }
    if(dialogid == DIALOG_VACC_OPTION_COLOR)
    {
        new slot = PlayerData[playerid][pVtoySelect],
            id = PlayerData[playerid][pGetVTOYID];

        if(response)
        {
            new col1, col2;

            GetVehicleColor(VehicleData[id][cVeh], col1, col2);
            
            PlayerTemp[playerid][temp_colindex] = listitem;
            PlayerTemp[playerid][temp_col1] = col1;
            PlayerTemp[playerid][temp_col2] = col2;

            ShowPlayerDialog(playerid, DIALOG_VACC_OPTION, DIALOG_STYLE_LIST, "Select Option", "Original Color\n{%06x}Veh Color 1\n{%06x}Veh Color 2\n{FFFFFF}Custom Color", "Select", "Back", ColorList[col1] >>> 8, ColorList[col2] >>> 8);
        }
        else ShowPlayerDialog(playerid, DIALOG_VACC_EDIT, DIALOG_STYLE_LIST, "Vehicle Accesories > Edit", "%s\nEdit Position\nRemove From Vehicle", "Select", "Back", VehicleObjects[id][slot][object_type] == OBJECT_TYPE_BODY ? ("Set Color") : ("Edit Text"));
    }
    if(dialogid == DIALOG_VACC_OPTION)
    {
        new slot = PlayerData[playerid][pVtoySelect],
            id = PlayerData[playerid][pGetVTOYID],
            list = PlayerTemp[playerid][temp_colindex];

        if(response)
        {
            switch(listitem)
            {
                case 0: VehicleObjects[ id ][ slot ][ object_color ][ list ] = 1;
                case 1: VehicleObjects[ id ][ slot ][ object_color ][ list ] = PlayerTemp[playerid][temp_col1];
                case 2: VehicleObjects[ id ][ slot ][ object_color ][ list ] = PlayerTemp[playerid][temp_col2];                
                case 3: 
                {
                    ShowPlayerDialog(playerid, DIALOG_VACC_COLOR, DIALOG_STYLE_INPUT, "Set Object Color", color_string, "Select", "Close");
                    return 0;
                }
            }
            GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);
            Vehicle_ObjectColor(playerid, id, slot);
            Vehicle_ObjectUpdate(id, slot, 1);
            Vehicle_ObjectSave(id, slot);
        }
        else ShowPlayerDialog(playerid, DIALOG_VACC_EDIT, DIALOG_STYLE_LIST, "Vehicle Accesories > Edit", "%s\nEdit Position\nRemove From Vehicle", "Select", "Back", VehicleObjects[id][slot][object_type] == OBJECT_TYPE_BODY ? ("Set Color") : ("Edit Text"));
    }
    if(dialogid == DIALOG_VACC_COLOR)
    {
        if(response)
        {
            new slot = PlayerData[playerid][pVtoySelect],
                id = PlayerData[playerid][pGetVTOYID],
                list = PlayerTemp[playerid][temp_colindex],
                color = strval(inputtext);
            
            if(!(0 <= color <= sizeof(ColorList)-1))
            { 
                ShowPlayerDialog(playerid, DIALOG_VACC_COLOR, DIALOG_STYLE_INPUT, "Set Object Color", color_string, "Select", "Close");
        
                return SendErrorMessage(playerid, "Invalid color ID.");
            }

            VehicleObjects[id][slot][object_color][list] = color;
        
            for(new mx = 0; mx != MAX_COLOR_MATERIAL; mx++) 
            {
                SetDynamicObjectMaterial(VehicleObjects[id][slot][object_streamer], mx, VehicleObjects[id][slot][object_model], "none", "none", RGBAToARGB(ColorList[VehicleObjects[id][slot][object_color][mx]]));
            }
            ShowPlayerDialog(playerid, DIALOG_VACC_EDIT, DIALOG_STYLE_LIST, "Vehicle Accesories > Edit", "%s\nEdit Position\nRemove From Vehicle", "Select", "Back", VehicleObjects[id][slot][object_type] == OBJECT_TYPE_BODY ? ("Set Color") : ("Edit Text"));
        }
    }
    if(dialogid == DIALOG_VACC_REMOVE)
    {
        if(response)
        {
            new slot = PlayerData[playerid][pVtoySelect],
                id = PlayerData[playerid][pGetVTOYID];

            Vehicle_ObjectReset(id, slot, true);

            SendCustomMessage(playerid, "VACC","You have remove this object from this vehicle.");

            PlayerData[playerid][pGetVTOYID] = -1;
        }
    }
    return 1;
}