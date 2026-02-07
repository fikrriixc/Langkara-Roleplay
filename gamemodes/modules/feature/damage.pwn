#include <YSI_Coding\y_hooks>

enum E_DAMAGE_DATA 
{
    bool:damageExists,
    damageID,
    WEAPON:damageWeapon,
    damageTime,
    damageBodypart,
    damageIssuer[MAX_PLAYER_NAME],
    damageAmount
};
new DamageData[MAX_PLAYERS][MAX_LISTED_DAMAGE][E_DAMAGE_DATA];

ReturnDuration(time, bool:use_ago = true)
{
	new
	    str[32];

	if (time < 0 || time == gettime()) 
    {
	    format(str, sizeof(str), "Never");
	    return str;
	}
	else if (time < 60)
		format(str, sizeof(str), "%d seconds", time);

	else if (time >= 0 && time < 60)
		format(str, sizeof(str), "%d seconds", time);

	else if (time >= 60 && time < 3600)
		format(str, sizeof(str), (time >= 120) ? ("%d minutes") : ("%d minute"), time / 60);

	else if (time >= 3600 && time < 86400)
		format(str, sizeof(str), (time >= 7200) ? ("%d hours") : ("%d hour"), time / 3600);

	else if (time >= 86400 && time < 2592000)
 		format(str, sizeof(str), (time >= 172800) ? ("%d days") : ("%d day"), time / 86400);

	else if (time >= 2592000 && time < 31536000)
 		format(str, sizeof(str), (time >= 5184000) ? ("%d months") : ("%d month"), time / 2592000);

	else if (time >= 31536000)
		format(str, sizeof(str), (time >= 63072000) ? ("%d years") : ("%d year"), time / 31536000);

	if(use_ago) strcat(str, " ago");

	return str;
}

GetDamageFreeID(playerid) 
{
    new index = -1;
    for(new i = 0; i < MAX_LISTED_DAMAGE; i++) if(!DamageData[playerid][i][damageExists]) 
    {
        index = i;
        break;
    }
    return index;
}

GetSameDamageInfo(playerid, WEAPON:weaponid, const issuer[], bodypart) 
{
    new index = -1;
    for(new i = 0; i < MAX_LISTED_DAMAGE; i++) if(DamageData[playerid][i][damageExists]) 
    {
        if(DamageData[playerid][i][damageBodypart] == bodypart && DamageData[playerid][i][damageWeapon] == weaponid && !strcmp(issuer, DamageData[playerid][i][damageIssuer])) 
        {
            index  = i;
            break;
        }
    }
    return index;
}

AddDamageToPlayer(playerid, WEAPON:weaponid, const issuer[], bodypart) 
{
    new
        id;

    if((id = GetSameDamageInfo(playerid, weaponid, issuer, bodypart)) != -1) 
    {
        DamageData[playerid][id][damageAmount]++;
        DamageData[playerid][id][damageTime] = gettime();
        // Update the damagelog.

    }
    else
    {
        if((id = GetDamageFreeID(playerid)) != -1) 
        {
            DamageData[playerid][id][damageWeapon] = weaponid;
            DamageData[playerid][id][damageAmount]++;
            DamageData[playerid][id][damageBodypart] = bodypart;
            DamageData[playerid][id][damageTime] = gettime();
            format(DamageData[playerid][id][damageIssuer], MAX_PLAYER_NAME, issuer);
            DamageData[playerid][id][damageExists] = true;

            // Issue new damagelog.
        }
    }
    return 1;
}

Damage_ResetVariables(playerid) 
{
    for(new i = 0; i < MAX_LISTED_DAMAGE; i++) 
    {
        DamageData[playerid][i][damageAmount] = 0;
        DamageData[playerid][i][damageBodypart] = 0;
        DamageData[playerid][i][damageExists] = false;
        DamageData[playerid][i][damageTime] = 0;
    }
}

GetBodyPartName(bodypart)
{
    new body_part[11];
    switch(bodypart)
    {
        case BODY_PART_TORSO: body_part = "Torso";
        case BODY_PART_GROIN: body_part = "Groin";
        case BODY_PART_LEFT_ARM: body_part = "Left Arm";
        case BODY_PART_RIGHT_ARM: body_part = "Right Arm";
        case BODY_PART_LEFT_LEG: body_part = "Left Leg";
        case BODY_PART_RIGHT_LEG: body_part = "Right Leg";
        case BODY_PART_HEAD: body_part = "Head";
        default: body_part = "None";
    }
    return body_part;
}

CountPlayerDamage(playerid) 
{
    new count = 0;
    for(new i = 0; i < MAX_LISTED_DAMAGE; i++) if(DamageData[playerid][i][damageExists]) 
    {
        count++;
    }
    return count;
}

ShowDamageToPlayer(playerid, show_to_id) 
{
    if(!IsPlayerConnected(playerid))
        return 0;

    if(!IsPlayerConnected(show_to_id))
        return 0;

    if(!CountPlayerDamage(playerid)) 
        return SendErrorMessage(show_to_id, "Tidak ada damagelog yang valid!");

    new string[1012], weapon_name[24];

    format(string, sizeof(string), "Weapon\tBullet(s)\tBodypart\tLast Updated\n");
    for(new i = 0; i < MAX_LISTED_DAMAGE; i++) if(DamageData[playerid][i][damageExists]) 
    {
        GetWeaponName(DamageData[playerid][i][damageWeapon], weapon_name, 24);

        format(string, sizeof(string), "%s%s\t%d bullet\t%s\t%s\n", 
            string, weapon_name, DamageData[playerid][i][damageAmount], GetBodyPartName(DamageData[playerid][i][damageBodypart]), ReturnDuration(gettime() - DamageData[playerid][i][damageTime]));
    }
    return ShowPlayerDialog(playerid, DIALOG_DAMAGELOG, DIALOG_STYLE_TABLIST_HEADERS, "Damagelog", string, "Check Issuer", "Close");
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_DAMAGELOG)
    {
        if(response)
        {
            ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, sprintf("ID: %d | Bodypart: %s", listitem, GetBodyPartName(DamageData[playerid][listitem][damageBodypart])),
                "Issuer : {ff0000}%s{ffffff}\nLast Updated : %s", "Close", "", DamageData[playerid][listitem][damageIssuer], ReturnDuration(gettime() - DamageData[playerid][listitem][damageTime]));
        }
    }
    return 1;
}

CMD:damagelog(playerid, params[])
{
    ShowDamageToPlayer(playerid, playerid);
    return 1;
}