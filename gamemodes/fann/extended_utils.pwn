//////////////////////////////////////////////////////////////////
/*		

    Baca sebelum memakai.

	// FYI
	Script-script ini hanya remake dari script yg ada dari
	include-include file SA:MP & Open.MP. Di sini tidak ada yang mengubah creadit
	pembuat script asli, saya(Fann) sebagai yang melakukan remake pada script
	tersebut hanya memperbarui script tersebut tanpa pengubahan creadit sedikitpun
	agar lebih efektif untuk server HopePride.

	Script ini dipersembahkan untuk HopePride Roleplay, by Fann & Vall.

	(hadeh, jangan kayak server Ravens pokoknya. tukang ubah creadit.      )
	(ownernya juga sama aja, tukang comot + ganti creadit script comotan.  )
	(kita sebagai developer pemula, harus respect dengan developer lainnya,)
	(bukan malah memanfaatkan skill yang pemula buat ngubah creadit script )
	(orang lain. butuh validasi bukan? 									   )

	// Changes Native
	- Improve PlayerPlaySound (now it doesn't have to fill the coordinates)
	- Added clearchat (will cleaning chat for player)
	- Added GetWeather (get the weather id during any weather) unused, cuz openmp already have it
	- Added PrevModelScroll (changes page PreviewModelDialog for android) unused, cuz PreviewModelDialog has remaked by Fann to support next & prev button
	- Improve SetPlayerRaceCheckPoint (supported with Waze-GPS, and the type will changes to 1 if the next coordinate is 0)
	- Improve SetPlayerCheckPoint (supported with Waze-GPS)
	- Added IsVehicleInRangeOfPoint (if 3DTryg.inc not defined)
	- Added IsValidTimer (checking the timer is available or not) unused, cuz openmp already have it
	- Added PlayerTextdraw & GlobalTextdraw supported with samp natives (example: Fann_PlayerTextDrawFont(playerid, PlayerText:fann, 1))
	- Added IsValidSpecialAction (checking valid SPECIAL_ACTION) openmp define
	- Added IsPlayerInRangeOfVehiclePart (checking if the player has near of vehicle part)
	- Added FixTextLine (fix the text for line in paragraf)
	- Added IsNumeric (checking the string is numeric or not)
	- Added RandomFloat (get random float between min & max)
	-- if 3DTryg.inc is not defined ↓
	- Added RoundAccuracy (round float with accuracy)
	- Added QuatToEuler (convert quaternion to euler rotation)
	- Added CompressRotation (compress rotation value between 0.0 to 360.0)
	- Added GetPlayerRotation (get player rotation in euler from quaternion)
*/
//////////////////////////////////////////////////////////////////

new Fann@OpenedPrevDialog[MAX_PLAYERS];
//new Fann@WeatherID;

#if !defined DIALOG_STYLE_PREVIEW_MODEL
	#if defined _INC_open_mp
		#define DIALOG_STYLE_PREVIEW_MODEL (DIALOG_STYLE:6)
		#define DIALOG_STYLE_PREVMODEL 	   (DIALOG_STYLE_PREVIEW_MODEL)
	#else 
		#define DIALOG_STYLE_PREVIEW_MODEL 6
		#define DIALOG_STYLE_PREVMODEL 	   DIALOG_STYLE_PREVIEW_MODEL
	#endif
#endif

stock Fann_UpdateServer()
{
	new fanstr[5000];

	strcat(fanstr, "[|] Added test for 'Drive License'\n");
	strcat(fanstr, "[|] Delete old 'Drive License'\n");
	strcat(fanstr, "[|] Revamp 'Drive License' feature\n");
	strcat(fanstr, "[|] Added 'Department of Motor Vehicles' in /gps\n");
	strcat(fanstr, "[|] Added mapping near of 'Department of Motor Vehicles'\n");
	strcat(fanstr, "[-] Fixes on 'Dealership Mapping in Insurance Agency'\n");
	strcat(fanstr, "[|] Added 'Vehicle Trunk' with Y\n");
	strcat(fanstr, "[|] Now open inventory can with Y\n");
	strcat(fanstr, "[-] Fixes Any Bugs...");

	return fanstr;
}

stock Fann_PlayerPlaySound(playerid, soundid, Float:x = 0.0, Float:y = 0.0, Float:z = 0.0)
{
	if(x == 0.0 && y == 0.0 && z == 0.0)
		GetPlayerPos(playerid, x, y, z);

	return PlayerPlaySound(playerid, soundid, Float:x, Float:y, Float:z);
}

#if defined _ALS_PlayerPlaySound
	#undef PlayerPlaySound
#endif

stock Fann_clearchat(playerid)
{
	for(new fan; fan < 18; fan++)
	{
		SendClientMessage(playerid, -1, " ");
	}
	return 1;
}

stock Fann_IsPlayerOpenPrev(playerid)
{
	return Fann@OpenedPrevDialog[playerid];
}

stock Fann_SetPlayerRaceCheckpoint(playerid, CP_TYPE:type, Float:x, Float:y, Float:z, Float:nextx = 0.0, Float:nexty = 0.0, Float:nextz = 0.0, Float:size = 3.5)
{
	#if defined include_waze_gps
		if(IsValidWazeGPS(playerid))
			StopWazeGPS(playerid);

		SetPlayerWaze(playerid, x, y, z);
	#endif

	if(nextx == 0.0 && nexty == 0.0 && nextz == 0.0)
		type = CP_TYPE_GROUND_FINISH;

	return SetPlayerRaceCheckpoint(playerid, type, x, y, z, nextx, nexty, nextz, size);
}

#if defined _ALS_SetPlayerRaceCheckpoint
	#undef SetPlayerRaceCheckpoint
#endif

stock Fann_SetPlayerCheckpoint(playerid, Float:x, Float:y, Float:z, Float:size = 3.5)
{
	#if defined include_waze_gps
		if(IsValidWazeGPS(playerid))
			StopWazeGPS(playerid);

		SetPlayerWaze(playerid, x, y, z);
	#endif

	return SetPlayerCheckpoint(playerid, x, y, z, size);
}

#if defined _ALS_SetPlayerCheckpoint
	#undef SetPlayerCheckpoint
#endif

#if !defined IsVehicleInRangeOfPoint
	stock Fann_IsVehicleInRangeOfPoint(vehicleid, Float:range, Float:x, Float:y, Float:z)
	{
		if(!IsValidVehicle(vehicleid))
			return 0;

		new Float:vPos[3];
		GetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
		#if defined Try3D_GetDistance3DD
			if(Try3D_GetDistance3DD(vPos[0], vPos[1], vPos[2], x, y, z) > range)
				return 0;
		#else
			if(VectorSize((vPos[0])-(x),(vPos[1])-(y),(vPos[2])-(z)) > range)
				return 0;
		#endif

		return 1;
	}
#endif

stock bool:Fann_KillTimer(&timerid)
{
	if(!IsValidTimer(timerid))
		return false;

	KillTimer(timerid);
	timerid = -1;
	return true;
}

#if defined _ALS_KillTimer
	#undef KillTimer 
#endif

stock Fann_CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay=0, bool:addsiren=false)
{
	new vehicleid = CreateVehicle(vehicletype, x, y, z, rotation, color1, color2, respawn_delay, addsiren);

	if(IsValidVehicle(vehicleid))
	{
		SetVehicleFuel(vehicleid, 100);
	}
	return vehicleid;
}

#if defined _ALS_CreateVehicle
	#undef CreateVehicle 
#endif

stock Float:Fann_CompressRotation(Float:rotation)
	return (rotation-floatround(rotation/360.0,floatround_floor)*360.0);

stock bool:Fann_PlayerTextDrawFont(playerid, PlayerText:playertext, font)
	return PlayerTextDrawFont(playerid, playertext, TEXT_DRAW_FONT:font);

stock bool:Fann_PlayerTextDrawAlignment(playerid, PlayerText:playertext, alignment)
	return PlayerTextDrawAlignment(playerid, playertext, TEXT_DRAW_ALIGN:alignment);

stock bool:Fann_PlayerTextDrawSetSelectable(playerid, PlayerText:playertext, option)
	return PlayerTextDrawSetSelectable(playerid, playertext, bool:option);

stock bool:Fann_PlayerTextDrawSetProportional(playerid, PlayerText:playertext, option)
	return PlayerTextDrawSetProportional(playerid, playertext, bool:option);

stock bool:Fann_PlayerTextDrawUseBox(playerid, PlayerText:playertext, option)
	return PlayerTextDrawUseBox(playerid, playertext, bool:option);

stock bool:Fann_TextDrawFont(Text:text, font)
	return TextDrawFont(text, TEXT_DRAW_FONT:font);

stock bool:Fann_TextDrawAlignment(Text:text, alignment)
	return TextDrawAlignment(text, TEXT_DRAW_ALIGN:alignment);

stock bool:Fann_TextDrawSetSelectable(Text:text, option)
	return TextDrawSetSelectable(text, bool:option);

stock bool:Fann_TextDrawSetProportional(Text:text, option)
	return TextDrawSetProportional(text, bool:option);

stock bool:Fann_TextDrawUseBox(Text:text, option)
	return TextDrawUseBox(text, bool:option);

stock bool:Fann_IsValidSpecialAction(SPECIAL_ACTION:actionid)
{
	static action;
	action = _:actionid;
	switch(action)
	{
		case 0..8: return true;
		case 10..13: return true;
		case 20..25: return true;
		case 68: return true;
	}
	return false;
}

stock bool:Fann_IsPlayerInRangeOfVehiclePart(playerid, vehicleid, partid, Float:range = 1.0) 
{
	new Float:vx, Float:vy, Float:vz;
	Tryg3D::GetVehiclePartPos(vehicleid, partid, vx, vy, vz);
	if(!IsPlayerInRangeOfPoint(playerid, range, vx, vy, vz))
		return false; 

	return true;
}

/*stock Fann_FixTextLine(str[], max_word = 8, len = sizeof(str))
{
	new count_word, count_line = 1, alphabet;
	for(new i; i < len; i++) 
	{
		if(str[i] == ' ')
		{
			count_word++;
			if(count_word > (max_word-5) && str[i-1] == '.')
			{

			}
			else if(count_word == max_word) // new line
			{
				count_word = 0;
				count_line++;
				strdel(str, i, i);
				strins(str, "\n", i-1);
			}
		}
	}

	if(count_line > 1) return 1; // jika ada lebih dari 1 line
	else return 0;				 // Jika tidak lebih
}*/

#define PlayerPlaySound Fann_PlayerPlaySound
#define clearchat Fann_clearchat
#define IsPlayerOpenPrev Fann_IsPlayerOpenPrev
#define SetPlayerRaceCheckpoint Fann_SetPlayerRaceCheckpoint
#define SetPlayerCheckpoint Fann_SetPlayerCheckpoint
#if !defined IsVehicleInRangeOfPoint
	#define IsVehicleInRangeOfPoint Fann_IsVehicleInRangeOfPoint
#endif
#define KillTimer Fann_KillTimer
#define CreateVehicle Fann_CreateVehicle
#define CompressRotation Fann_CompressRotation
#define IsValidSpecialAction Fann_IsValidSpecialAction
#define IsPlayerInRangeOfVehiclePart Fann_IsPlayerInRangeOfVehiclePart
#if (defined IsNumeric) && (!defined isnum)
	#define isnum IsNumeric
#elseif !defined IsNumeric
	stock IsNumeric(const string[])
	{
		for (new i = 0, l = strlen(str); i != l; i ++)
		{
			if(i == 0 && str[0] == '-')
				continue;

			else if(str[i] < '0' || str[i] > '9')
				return 0;
		}
		return 1;
	}

	#if defined isnum
		#undef isnum
	#endif
	#define isnum IsNumeric
#endif
#if (defined T3_RandomFloat) && (!defined RandomFloat)
	#define RandomFloat T3_RandomFloat
#elseif !defined T3_RandomFloat
	stock Float:T3_RandomFloat(const Float:min, const Float:max, accuracy = 4)
	{
		if(min >= max) return 0.0;
		if(min < 0.0 || max < 0.0) return 0.0;
		if(accuracy < 1) accuracy = 1;
		if(accuracy > 6) accuracy = 6;
		new divValue = floatround(floatpower(10.0,accuracy)),prefix = floatround(max)-floatround(min), Float:rand_prefix = 0.0;
		if(prefix > 0) rand_prefix = 1.0 * random(prefix);
		return rand_prefix + min + (1.0*random(divValue+1)/(divValue*1.0));
	}

	#if defined RandomFloat
		#undef RandomFloat
	#endif
	#define RandomFloat T3_RandomFloat
#endif
#if defined T3_RoundAccuracy
	#define RoundAccuracy T3_RoundAccuracy
#else
	#define RoundAccuracy(%0) (floatround((%0)*10000.0)/10000.0)
#endif
#if defined T3_QuatToEuler
	#define QuatToEuler T3_QuatToEuler
#else
	stock T3_QuatToEuler(&Float:rx, &Float:ry, &Float:rz, Float:qw, Float:qx, Float:qy, Float:qz)
	{
		qw = RoundAccuracy(qw);
		qx = RoundAccuracy(qx);
		qy = RoundAccuracy(qy);
		qz = RoundAccuracy(qz);
		rx = CompressRotation(asin(2*qy*qz-2*qx*qw));
		ry = CompressRotation(-atan2(qx*qz+qy*qw,0.5-qx*qx-qy*qy));
		rz = CompressRotation(-atan2(qx*qy+qz*qw,0.5-qx*qx-qz*qz));
	}
	#define QuatToEuler T3_QuatToEuler
#endif
#if defined T3_GetPlayerRotation
	#define GetPlayerRotation T3_GetPlayerRotation
#else
	stock T3_GetPlayerRotation(const playerid, &Float:rx, &Float:ry, &Float:rz)
	{
		new Float:qw,Float:qx,Float:qy,Float:qz;
		GetPlayerRotationQuat(playerid,qw,qx,qy,qz);
		QuatToEuler(rx,ry,rz,qw,qx,qy,qz);
	}
	#define GetPlayerRotation T3_GetPlayerRotation
#endif

// Forward
forward OnPlayerUseItem(playerid, itemid, item[]);
forward OnGameModeInitEx();