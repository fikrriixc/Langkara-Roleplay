CMD:bbhelp(playerid)
{
	new fanstr[500];
	strcat(fanstr, "Command\tFunction\n");
	strcat(fanstr, "Lewat Inventory\tTaruh Boombox\n");
	strcat(fanstr, "/setbb\tUbah lagu di Boombox\n");
	strcat(fanstr, "/pickupbb\tMengambil Boombox");

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Boombox Help", fanstr, "Got It", "");
	return 1;
}

CMD:setbb(playerid, params[])
{
	if(GetPVarType(playerid, "PlacedBB"))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, GetPVarFloat(playerid, "BBX"), GetPVarFloat(playerid, "BBY"), GetPVarFloat(playerid, "BBZ")))
		{
			ShowPlayerDialog(playerid,DIALOG_BOOMBOX,DIALOG_STYLE_LIST,"Boombox","Turn Off Boombox\nInput URL","Select", "Cancel");
		}
		else
		{
   			return SendErrorMessage(playerid, "Kamu tidak di dekat boombox milikmu!");
		}
    }
    else
        SendErrorMessage(playerid, "Kamu belum menaruh boombox!");
	return 1;
}

CMD:pickupbb(playerid, params [])
{
	if(!GetPVarInt(playerid, "PlacedBB"))
    {
        return SendErrorMessage(playerid, "Kamu belum menaruh boombox!");
    }
	if(IsPlayerInRangeOfPoint(playerid, 3.0, GetPVarFloat(playerid, "BBX"), GetPVarFloat(playerid, "BBY"), GetPVarFloat(playerid, "BBZ")))
    {
        PickUpBoombox(playerid);
        SendInfoMessage(playerid, "Boombox telah diambil!");
    }
	else 
		SendErrorMessage(playerid, "Kamu tidak di dekat boombox!");
		
    return 1;
}

stock StopStream(playerid)
{
	DeletePVar(playerid, "pAudioStream");
    StopAudioStreamForPlayer(playerid);
}

stock PlayStream(playerid, url[], Float:posX = 0.0, Float:posY = 0.0, Float:posZ = 0.0, Float:distance = 50.0, bool:usepos = false)
{
	if(GetPVarType(playerid, "pAudioStream")) StopAudioStreamForPlayer(playerid);
	else SetPVarInt(playerid, "pAudioStream", 1);
    PlayAudioStreamForPlayer(playerid, url, posX, posY, posZ, distance, usepos);
}

stock PickUpBoombox(playerid)
{
    foreach(new i : Player)
	{
 		if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "BBArea")))
   		{
     		StopStream(i);
		}
	}
	DeletePVar(playerid, "BBArea");
	DestroyDynamicObject(GetPVarInt(playerid, "PlacedBB"));
	DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid, "BBLabel"));
	DeletePVar(playerid, "PlacedBB"); DeletePVar(playerid, "BBLabel");
 	DeletePVar(playerid, "BBX"); DeletePVar(playerid, "BBY"); DeletePVar(playerid, "BBZ");
	DeletePVar(playerid, "BBInt");
	DeletePVar(playerid, "BBVW");
	DeletePVar(playerid, "BBStation");
	return 1;
}