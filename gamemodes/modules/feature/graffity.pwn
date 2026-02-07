// Graffiti / Wall Tag
// by Fann

#include <YSI_Coding\y_hooks>

enum e_graffity_data
{
    gID,
    gOwner, // pID
    gText[128],
    gTextFont[24],
    gFontSize,
    gSize,
    gModel, 
    Float:gPos[6],
    //unsaved
    gObject
};

new
    GraffitiData[MAX_GRAFFITI][e_graffity_data],
    Iterator:Graffity<MAX_GRAFFITI>
;

public:LoadGraffiti()
{
    new rows = cache_num_rows();
    if(rows) forex(fan, rows) 
    {
        cache_get_value_name_int(fan, "id", GraffitiData[fan][gID]);
        cache_get_value_name_int(fan, "owner", GraffitiData[fan][gOwner]);
        cache_get_value_name_int(fan, "model", GraffitiData[fan][gModel]);
        cache_get_value_name_int(fan, "fontsize", GraffitiData[fan][gFontSize]);
        cache_get_value_name_int(fan, "size", GraffitiData[fan][gSize]);
        cache_get_value_name(fan, "text", GraffitiData[fan][gText]);
        cache_get_value_name(fan, "font", GraffitiData[fan][gTextFont]);

        cache_get_value_name_float(fan, "x", GraffitiData[fan][gPos][0]);
        cache_get_value_name_float(fan, "y", GraffitiData[fan][gPos][1]);
        cache_get_value_name_float(fan, "z", GraffitiData[fan][gPos][2]);
        cache_get_value_name_float(fan, "rx", GraffitiData[fan][gPos][3]);
        cache_get_value_name_float(fan, "ry", GraffitiData[fan][gPos][4]);
        cache_get_value_name_float(fan, "rz", GraffitiData[fan][gPos][5]);

        Iter_Add(Graffity, fan);
        Graffiti_RefreshObject(fan);
    }
    printf("[Dynamic Graffity] Loaded %d from database", rows);
    return 1;
}

Graffiti_Save(gid)
{
    new fanQuery[5000];
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "UPDATE `graffiti` SET ");
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s`owner` = '%d', ", fanQuery, GraffitiData[gid][gOwner]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s`model` = '%d', ", fanQuery, GraffitiData[gid][gModel]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s`fontsize` = '%d', ", fanQuery, GraffitiData[gid][gFontSize]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s`size` = '%d', ", fanQuery, GraffitiData[gid][gSize]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s`text` = '%e', ", fanQuery, SQL_EscapeString(GraffitiData[gid][gText]));
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s`font` = '%e', ", fanQuery, SQL_EscapeString(GraffitiData[gid][gTextFont]));
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s`x` = '%f', ",  fanQuery, GraffitiData[gid][gPos][0]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s`y` = '%f', ",  fanQuery, GraffitiData[gid][gPos][1]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s`z` = '%f', ",  fanQuery, GraffitiData[gid][gPos][2]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s`rx` = '%f', ", fanQuery, GraffitiData[gid][gPos][3]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s`ry` = '%f', ", fanQuery, GraffitiData[gid][gPos][4]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%s`rz` = '%f' ",  fanQuery, GraffitiData[gid][gPos][5]);
    mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%sWHERE `id` = '%d'", fanQuery, GraffitiData[gid][gID]);

    mysql_tquery(g_SQL, fanQuery);
    return 1;
}

Graffiti_RefreshObject(gid)
{
    if(IsValidDynamicObject(GraffitiData[gid][gObject]))
        DestroyDynamicObject(GraffitiData[gid][gObject]);

    GraffitiData[gid][gObject] = CreateDynamicObject(
        GraffitiData[gid][gModel], 
        GraffitiData[gid][gPos][0],
        GraffitiData[gid][gPos][1],
        GraffitiData[gid][gPos][2],
        GraffitiData[gid][gPos][3],
        GraffitiData[gid][gPos][4],
        GraffitiData[gid][gPos][5]
    );

    SetDynamicObjectMaterialText(
        GraffitiData[gid][gObject], 
        0, 
        GraffitiData[gid][gText],
        GraffitiData[gid][gSize],
        GraffitiData[gid][gTextFont],
        GraffitiData[gid][gFontSize],
        1,
        0xFFFFFFFF, 
        0x00000000,
        1
    );
    return 1;
}

Graffiti_Create(playerid, model, text[], font[], Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    new gid;
    if((gid = Iter_Free(Graffity)) != -1)
    {
        GraffitiData[gid][gModel] = model;
        GraffitiData[gid][gOwner] = PlayerData[playerid][pID];
        format(GraffitiData[gid][gText], 128, text);
        format(GraffitiData[gid][gTextFont], 24, font);
        GraffitiData[gid][gPos][0] = x;
        GraffitiData[gid][gPos][1] = y;
        GraffitiData[gid][gPos][2] = z;
        GraffitiData[gid][gPos][3] = rx;
        GraffitiData[gid][gPos][4] = ry;
        GraffitiData[gid][gPos][5] = rz;
        
        GraffitiData[gid][gFontSize] = 25;
        GraffitiData[gid][gSize] = 40;

        Graffiti_RefreshObject(gid);
        Iter_Add(Graffity, gid);

        mysql_tquery(g_SQL, "INSERT INTO `graffiti` (`model`) VALUES('0')", "OnGraffitiCreated", "d", gid);
    }
    return gid;
}

public:OnGraffitiCreated(gid)
{
    GraffitiData[gid][gID] = cache_insert_id();
    Graffiti_Save(gid);
}

Graffiti_Near(playerid, Float:range = 2.0)
{
    foreach(new gid : Graffity) if(IsPlayerInRangeOfPoint(playerid, range, GraffitiData[gid][gPos][0], GraffitiData[gid][gPos][1], GraffitiData[gid][gPos][2]))
        return gid;

    return -1;
}

Graffiti_EditMenu(playerid, gid)
{
    if(!Iter_Contains(Graffity, gid))
        return SendErrorMessage(playerid, "Graffiti tidak ditemukan.");

    new fanstr[500];
    strcat(fanstr, sprintf("Graffiti ID\t:\t%d\n", gid), sizeof(fanstr));
    strcat(fanstr, sprintf("Maker\t:\t%s\n", GetNameByID(GraffitiData[gid][gOwner])), sizeof(fanstr));
    strcat(fanstr, sprintf("Font Size\t:\t%d\n", GraffitiData[gid][gFontSize]), sizeof(fanstr));
    strcat(fanstr, sprintf("Size\t:\t%d\n", GraffitiData[gid][gSize]), sizeof(fanstr));
    strcat(fanstr, sprintf("Font\t:\t%s\n", GraffitiData[gid][gTextFont]), sizeof(fanstr));
    strcat(fanstr, "Edit Text\n", sizeof(fanstr));
    strcat(fanstr, "{ff0000}Remove Graffiti");

    ShowPlayerDialog
    (
        playerid, 
        DIALOG_GRAFFITI_MANAGER, 
        DIALOG_STYLE_LIST, 
        sprintf
        (
            "Database ID: %d | Location: %s", 
            GraffitiData[gid][gID], 
            GetLocation(GraffitiData[gid][gPos][0], GraffitiData[gid][gPos][1], GraffitiData[gid][gPos][2])
        ), 
        fanstr,
        "Select", 
        "Close"
    );
    return 1;
}

CMD:graffiti(playerid, params[])
{
    if(PlayerData[playerid][pLevel] < 4)
        return SendErrorMessage(playerid, "You cannot use this now!");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new Float:tx, Float:ty, Float:tz;
    if (Tryg3D::GetPointInWallForPoint(x, y, z, 10.0, tx, ty, tz, 1.0))
    {
		if(GetPlayerDistanceFromPoint(playerid, tx, ty, tz) > 2.0) 
        {
            ShowPlayerDialog(playerid, DIALOG_GRAFFITI, DIALOG_STYLE_MSGBOX, "Graffity", "Kamu terlalu jauh dari dinding! Apa kamu mau\nmembuat {ffff00}Graffiti{ffffff} dari posisimu sekarang?", "Ya", "Tutup");
            return 1;
        }
        SetPlayerLookAt(playerid, tx, ty);

		new Float:z_angle;
		Tryg3D::GetRotationFor2Point2D(x,y,tx,ty,z_angle);

		new tmpobjid = CreateDynamicObject(19482, tx, ty, tz, 0.0, 0.0, z_angle-90);
        PlayerTemp[playerid][temp_object] = tmpobjid;
        PlayerData[playerid][pEditType] = EDIT_GRAFFITI;
		SetDynamicObjectMaterialText(tmpobjid, 0, "Graffiti Hope", 40, "Arial", 25, 1, RGBAToARGB(ARWIN), 0x00000000, 1);
        EditDynamicObject(playerid, tmpobjid);
    }
    return 1;
}

CMD:editgraffiti(playerid, params[])
{
    new gid;
    if((gid = Graffiti_Near(playerid)) != -1)
    {
        Graffiti_EditMenu(playerid, gid);
    }
    else
    {
        SendErrorMessage(playerid, "Tidak ada graffiti di dekatmu.");
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_GRAFFITI)
    {
        if(response)
        {
            if(PlayerData[playerid][pEditType] == EDIT_GRAFFITI)
            {
                if(isnull(inputtext))
                {
                    ShowPlayerDialog(playerid, DIALOG_GRAFFITI, DIALOG_STYLE_INPUT, "Graffity", "Masukkan teks graffiti kamu:", "Buat", "");
                    return 1;
                }

                FixText(inputtext);
                new gid = Graffiti_Create(
                    playerid,
                    19482,
                    ColouredText(inputtext),
                    "Arial",
                    PlayerTemp[playerid][temp_voldpos][0],
                    PlayerTemp[playerid][temp_voldpos][1],
                    PlayerTemp[playerid][temp_voldpos][2],
                    PlayerTemp[playerid][temp_voldpos][3],
                    PlayerTemp[playerid][temp_voldpos][4],
                    PlayerTemp[playerid][temp_voldpos][5]
                );

                if(gid == -1)
                {
                    SendErrorMessage(playerid, "Gagal membuat graffiti. Kapasitas penuh.");
                    return 1;
                }

                SendServerMessage(playerid, "Graffiti berhasil dibuat di lokasi {ffff00}%s{ffffff}.", GetLocation(PlayerTemp[playerid][temp_voldpos][0], PlayerTemp[playerid][temp_voldpos][1], PlayerTemp[playerid][temp_voldpos][2]));
                SendServerMessage(playerid, "Gunakan /editgraffiti %d untuk mengedit graffiti kamu.", gid);

                forex(fan, 6) PlayerTemp[playerid][temp_voldpos][fan] = 0.0;
                PlayerData[playerid][pEditType] = EDIT_NONE;
            }
            else
            {
                new Float:pos[4];
                GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
                GetPlayerFacingAngle(playerid, pos[3]);

                pos[0] += 1.0 * floatsin(-pos[3], degrees);
                pos[1] += 1.0 * floatcos(-pos[3], degrees);
                pos[2] += 0.5;
                pos[3] -= 180.0;

                forex(fan, 6) PlayerTemp[playerid][temp_voldpos][fan] = 0.0;

                new tmpobjid = CreateDynamicObject(19482, pos[0], pos[1], pos[2], 0.0, 0.0, pos[3]);
                PlayerTemp[playerid][temp_object] = tmpobjid;
                PlayerData[playerid][pEditType] = EDIT_GRAFFITI;
                SetDynamicObjectMaterialText(tmpobjid, 0, "Graffiti Hope", 40, "Arial", 20, 1, RGBAToARGB(ARWIN), 0x00000000, 1);
                EditDynamicObject(playerid, tmpobjid);
            }
        }
        else
        {
            if(PlayerData[playerid][pEditType] == EDIT_GRAFFITI)
            {
                PlayerTemp[playerid][temp_object] = -1;
                forex(fan, 6) PlayerTemp[playerid][temp_voldpos][fan] = 0.0;
                PlayerData[playerid][pEditType] = EDIT_NONE;
                SendServerMessage(playerid, "Kamu batal membuat graffiti.");
            }
        }
    }
    if(dialogid == DIALOG_GRAFFITI_MANAGER)
    {
        if(response)
        {
            new gid = Graffiti_Near(playerid);
            if(!Iter_Contains(Graffity, gid))
                return SendErrorMessage(playerid, "Graffiti tidak ditemukan.");

            switch(listitem)
            {
                case 2: ShowPlayerDialog(playerid, DIALOG_GRAFFITI_EDIT_FONTSIZE, DIALOG_STYLE_INPUT, "Edit Font Size", "Masukkan ukuran font (10-100):", "Simpan", "");
                case 3: ShowPlayerDialog(playerid, DIALOG_GRAFFITI_EDIT_SIZE, DIALOG_STYLE_INPUT, "Edit Size", "Masukkan ukuran graffiti (1-14):", "Simpan", "");
                case 4: ShowPlayerDialog(playerid, DIALOG_GRAFFITI_EDIT_FONT, DIALOG_STYLE_LIST, "Edit Font", object_font, "Simpan", "");
                case 5: ShowPlayerDialog(playerid, DIALOG_GRAFFITI_EDIT_TEXT, DIALOG_STYLE_INPUT, "Edit Text", "Masukkan teks graffiti:", "Simpan", "");
                case 6: ShowPlayerDialog(playerid, DIALOG_GRAFFITI_REMOVE, DIALOG_STYLE_MSGBOX, "Remove Graffiti", "Apakah kamu yakin ingin menghapus graffiti ini?", "Ya", "Tidak");
                default: Graffiti_EditMenu(playerid, gid);
            }
        }
    }
    if(dialogid == DIALOG_GRAFFITI_EDIT_FONTSIZE)
    {
        if(response)
        {
            new gid = Graffiti_Near(playerid);
            if(!Iter_Contains(Graffity, gid))
                return SendErrorMessage(playerid, "Graffiti tidak ditemukan.");

            new fontsize = strval(inputtext);
            if(fontsize < 10 || fontsize > 100)
                return SendErrorMessage(playerid, "Ukuran font harus antara 10 hingga 100.");

            GraffitiData[gid][gFontSize] = fontsize;
            Graffiti_RefreshObject(gid);
            Graffiti_Save(gid);

            SendServerMessage(playerid, "Ukuran font graffiti berhasil diubah menjadi %d.", fontsize);
        }
        else
        {
            Graffiti_EditMenu(playerid, Graffiti_Near(playerid));
        }
    }
    if(dialogid == DIALOG_GRAFFITI_EDIT_SIZE)
    {
        if(response)
        {
            new gid = Graffiti_Near(playerid);
            if(!Iter_Contains(Graffity, gid))
                return SendErrorMessage(playerid, "Graffiti tidak ditemukan.");

            new size = strval(inputtext);
            if(size < 1 || size > 14)
                return SendErrorMessage(playerid, "Ukuran graffiti harus antara 1 hingga 14.");

            GraffitiData[gid][gSize] = size * 10;
            Graffiti_RefreshObject(gid);
            Graffiti_Save(gid);

            SendServerMessage(playerid, "Ukuran graffiti berhasil diubah menjadi %d.", size);
        }
        else
        {
            Graffiti_EditMenu(playerid, Graffiti_Near(playerid));
        }
    }
    if(dialogid == DIALOG_GRAFFITI_EDIT_FONT)
    {
        if(response)
        {
            new gid = Graffiti_Near(playerid);
            if(!Iter_Contains(Graffity, gid))
                return SendErrorMessage(playerid, "Graffiti tidak ditemukan.");

            format(GraffitiData[gid][gTextFont], 24, FontNames[listitem]);
            Graffiti_RefreshObject(gid);
            Graffiti_Save(gid);

            SendServerMessage(playerid, "Font graffiti berhasil diubah menjadi %s.", FontNames[listitem]);
        }
        else
        {
            Graffiti_EditMenu(playerid, Graffiti_Near(playerid));
        }
    }
    if(dialogid == DIALOG_GRAFFITI_EDIT_TEXT)
    {
        if(response)
        {
            new gid = Graffiti_Near(playerid);
            if(!Iter_Contains(Graffity, gid))
                return SendErrorMessage(playerid, "Graffiti tidak ditemukan.");

            FixText(inputtext);
            format(GraffitiData[gid][gText], 128, ColouredText(inputtext));
            Graffiti_RefreshObject(gid);
            Graffiti_Save(gid);

            SendServerMessage(playerid, "Teks graffiti berhasil diubah.");
        }
        else
        {
            Graffiti_EditMenu(playerid, Graffiti_Near(playerid));
        }
    }
    if(dialogid == DIALOG_GRAFFITI_REMOVE)
    {
        if(response)
        {
            new gid = Graffiti_Near(playerid), fanQuery[500];
            if(!Iter_Contains(Graffity, gid))
                return SendErrorMessage(playerid, "Graffiti tidak ditemukan.");

            DestroyDynamicObject(GraffitiData[gid][gObject]);
            Iter_Remove(Graffity, gid);

            mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "DELETE FROM `graffiti` WHERE `id` = '%d'", GraffitiData[gid][gID]);
            mysql_tquery(g_SQL, fanQuery);

            SendServerMessage(playerid, "Graffiti berhasil dihilangkan.");
        }
        else
        {
            Graffiti_EditMenu(playerid, Graffiti_Near(playerid));
        }
    }
    return 1;
}

hook OnPlayerEditDynObject(playerid, STREAMER_TAG_OBJECT: objectid, EDIT_RESPONSE:response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(objectid == PlayerTemp[playerid][temp_object] && PlayerData[playerid][pEditType] == EDIT_GRAFFITI && response != EDIT_RESPONSE_UPDATE)
    {
        PlayerTemp[playerid][temp_object] = -1;
        DestroyDynamicObject(objectid);
        if(response == EDIT_RESPONSE_FINAL)
        {
            PlayerTemp[playerid][temp_voldpos][0] = x;
            PlayerTemp[playerid][temp_voldpos][1] = y;
            PlayerTemp[playerid][temp_voldpos][2] = z;
            PlayerTemp[playerid][temp_voldpos][3] = rx;
            PlayerTemp[playerid][temp_voldpos][4] = ry;
            PlayerTemp[playerid][temp_voldpos][5] = rz;

            ShowPlayerDialog(playerid, DIALOG_GRAFFITI, DIALOG_STYLE_INPUT, "Graffity", "Masukkan teks graffiti kamu:", "Buat", "");
        }
        else if(response == EDIT_RESPONSE_CANCEL)
        {
            SendServerMessage(playerid, "Kamu batal membuat graffiti.");
            forex(fan, 6) PlayerTemp[playerid][temp_voldpos][fan] = 0.0;
            PlayerData[playerid][pEditType] = EDIT_NONE;
        }
    }
    return 1;
}