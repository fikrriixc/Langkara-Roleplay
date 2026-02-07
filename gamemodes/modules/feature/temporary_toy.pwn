// Temporary Toy to adjust Coordinate
// by Fann

#include <YSI_Coding\y_hooks>

new
    bool:tempToy[MAX_PLAYERS],
    tempToyModel[MAX_PLAYERS],
    tempToyBone[MAX_PLAYERS],
    Float:tempToyPos[MAX_PLAYERS][6],
    Float:tempToySize[MAX_PLAYERS][3],
    tempToyMaterial[MAX_PLAYERS][2]
;

void:cleanupTemporaryToy(playerid)
{
    tempToy[playerid] = false;
    tempToyModel[playerid] = -1;
    tempToyBone[playerid] = 0;
    forex(fann, 6) tempToyPos[playerid][fann] = 0.0;
    forex(fann, 3) tempToySize[playerid][fann] = 1.0;
    forex(fann, 2) tempToyMaterial[playerid][fann] = 0;
}

TempToy_Update(playerid) 
{
    SetPlayerAttachedObject
    (
        playerid, 
        BOX_INDEX, 
        tempToyModel[playerid], 
        tempToyBone[playerid], 
        tempToyPos[playerid][0],
        tempToyPos[playerid][1],
        tempToyPos[playerid][2],
        tempToyPos[playerid][3],
        tempToyPos[playerid][4],
        tempToyPos[playerid][5],
        tempToySize[playerid][0],
        tempToySize[playerid][1],
        tempToySize[playerid][2],
        tempToyMaterial[playerid][0],
        tempToyMaterial[playerid][1]
    );
}

CMD:toysfann(playerid, params[])
{
    if(!IsPlayerFann(playerid))
        return PermissionError(playerid);

    new model, string[900];
    if(sscanf(params, "d", model))
        return SendSyntaxMessage(playerid, "/toysfann [object model]");

    SetPVarInt(playerid, "tempToyModel", model);

    strcat(string, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
	strcat(string, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");

    ShowPlayerDialog(playerid, DIALOG_TEMP_TOY_BONE, DIALOG_STYLE_LIST, "Player Toys", string, "Select", "Cancel");
    return 1;
}

CMD:edittoys(playerid, params[])
{
    if(!IsPlayerFann(playerid))
        return PermissionError(playerid);

    if(!tempToy[playerid])
        return SendErrorMessage(playerid, "Pasang toy terlebih dahulu!");

    EditAttachedObject(playerid, BOX_INDEX);
    return 1;
}

CMD:destroytoy(playerid, params[])
{
    if(!IsPlayerFann(playerid))
        return PermissionError(playerid);

    if(!tempToy[playerid])
        return SendErrorMessage(playerid, "Pasang toy terlebih dahulu!");

    if(IsPlayerAttachedObjectSlotUsed(playerid, BOX_INDEX))
    {
        RemovePlayerAttachedObject(playerid, BOX_INDEX);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    }
    SendCustomMessage(playerid, "TEMP", "Toy was unattached");
    cleanupTemporaryToy(playerid);
    return 1;
}

CMD:changetoymat(playerid, params[])
{
    if(!IsPlayerFann(playerid))
        return PermissionError(playerid);

    if(!tempToy[playerid]) 
        return SendErrorMessage(playerid, "Pasang toy terlebih dahulu!");

    ShowPlayerDialog(playerid, DIALOG_TEMP_TOY_MAT1, DIALOG_STYLE_INPUT, "Change Material 1", color_string2, "Select", "Cancel");
    return 1;
}

CMD:savetoy(playerid, params[])
{
    if(!IsPlayerFann(playerid))
        return PermissionError(playerid);

    if(!tempToy[playerid])
        return SendErrorMessage(playerid, "Pasang toy terlebih dahulu!");

    new String[5000], File:log;
	log = fopen("savedtoys.txt", io_append);
    format(String, sizeof(String), "SetPlayerAttachedObject(playerid, 9, %d, %d, %f, %f, %f, %f, %f, %f, %f, %f, %f, %d, %d); // %s \r\n", 
        tempToyModel[playerid], 
        tempToyBone[playerid], 
        tempToyPos[playerid][0],
        tempToyPos[playerid][1],
        tempToyPos[playerid][2],
        tempToyPos[playerid][3],
        tempToyPos[playerid][4],
        tempToyPos[playerid][5],
        tempToySize[playerid][0],
        tempToySize[playerid][1],
        tempToySize[playerid][2],
        tempToyMaterial[playerid][0],
        tempToyMaterial[playerid][1],
        params
    );

    fwrite(log, String);
    fclose(log);
    SendCustomMessage(playerid, "TEMP", "Location saved.");
    return 1;
}

// Hook

hook OnPlayerEditAttachedObject(playerid, EDIT_RESPONSE:response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    if(tempToy[playerid]) 
    {
        if(response == EDIT_RESPONSE_FINAL)
        {
            tempToyPos[playerid][0] = fOffsetX;
            tempToyPos[playerid][1] = fOffsetY;
            tempToyPos[playerid][2] = fOffsetZ;
            tempToyPos[playerid][3] = fRotX;
            tempToyPos[playerid][4] = fRotY;
            tempToyPos[playerid][5] = fRotZ;
            tempToySize[playerid][0] = fScaleX;
            tempToySize[playerid][1] = fScaleY;
            tempToySize[playerid][2] = fScaleZ;

            TempToy_Update(playerid);

            SendCustomMessage(playerid, "TEMP", "Toy position saved, use /savetoy to saved it to file!");
        }
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_TEMP_TOY_BONE)
    {
        if(response) 
        {
            if(IsPlayerAttachedObjectSlotUsed(playerid, BOX_INDEX))
            {
                RemovePlayerAttachedObject(playerid, BOX_INDEX);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
            }

            tempToy[playerid] = true;
            tempToyBone[playerid] = listitem+1;
            tempToyModel[playerid] = GetPVarInt(playerid, "tempToyModel");
            forex(fann, 6) tempToyPos[playerid][fann] = 0.0;
            forex(fann, 3) tempToySize[playerid][fann] = 1.0;
            forex(fann, 2) tempToyMaterial[playerid][fann] = 0;
            
	        TempToy_Update(playerid);
        }
    }
    if(dialogid == DIALOG_TEMP_TOY_MAT1)
    {
        if(response) 
        {
            SetPVarInt(playerid, "tempToyMat1", listitem);
            ShowPlayerDialog(playerid, DIALOG_TEMP_TOY_MAT2, DIALOG_STYLE_INPUT, "Change Material 2", color_string2, "Select", "Cancel");
        }
    }
    if(dialogid == DIALOG_TEMP_TOY_MAT2)
    {
        if(response) 
        {
            new listitem2 = GetPVarInt(playerid, "tempToyMat1");

            tempToyMaterial[playerid][0] = RGBAToARGB(ColorList[listitem2]);
            tempToyMaterial[playerid][1] = RGBAToARGB(ColorList[listitem]);

            TempToy_Update(playerid);
            SendCustomMessage(playerid, "TEMP", "You have set toy material color to {%06x}Text{ffffff} and {%06x}Text{ffffff}!", ColorList[listitem2] >>> 8, ColorList[listitem] >>> 8);
        }
    }
    return 1;
}