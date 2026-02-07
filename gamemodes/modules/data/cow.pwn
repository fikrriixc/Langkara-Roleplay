/* Script Ini Mutlak buatan Fann. */

#define _FANN_COW_DATA 

enum fann_cow_data
{
    Float:fannPosX,
    Float:fannPosY,
    Float:fannPosZ,
    Float:fannPosRX,
    Float:fannPosRY,
    Float:fannPosRZ
};

new const Float:Fann@CowData[18][fann_cow_data] = 
{
    {253.528274, 1138.714965, 9.962286, 0.000000, 0.000000, 0.000000},
    {250.508880, 1142.226318, 10.284552, 0.000000, 0.000000, -39.999996},
    {243.434158, 1144.980224, 10.832365, 0.000000, 0.000000, 99.999992},
    {240.682373, 1134.258300, 10.499385, 0.000000, 0.000000, 39.999996},
    {243.032012, 1139.187744, 10.666604, 0.000000, 0.000000, 139.999984},
    {234.131500, 1131.719726, 11.036150, 0.000000, 0.000000, -119.999992},
    {255.639419, 1132.303833, 9.774570, 0.000000, 0.000000, 150.000000},
    {234.338851, 1139.482666, 11.214769, 0.000000, 0.000000, -139.999984},
    {227.262588, 1129.522338, 11.672027, 0.000000, 0.000000, 130.000000},
    {230.867797, 1144.752197, 11.790665, 0.000000, 0.000000, -39.999996},
    {219.432937, 1126.372802, 12.127441, 0.000000, 0.000000, 179.999984},
    {218.947540, 1147.630371, 12.651424, 0.000000, 0.000000, -90.000000},
    {248.989685, 1128.964477, 9.893040, 0.000000, 0.000000, 179.999984},
    {262.818328, 1125.940917, 9.226603, 0.000000, 0.000000, -141.400070},
    {219.036819, 1147.535766, 13.044311, -39.999996, 0.000000, -89.999977},
    {219.658996, 1128.218261, 12.116009, 0.000000, 0.000000, 0.000000},
    {255.352981, 1146.060668, 10.350296, 0.000000, 0.000000, 0.000000},
    {226.972854, 1136.334472, 11.913105, 0.000000, 0.000000, 0.000000}
};

new FannCow[MAX_COW],
    Text3D:FannCText[MAX_COW],
    FannCowCD[MAX_COW];

Cow_Spawn()
{
    forex(fann, MAX_COW) 
    {
        FannCowCD[fann] = 0;
        FannCow[fann] = CreateDynamicObject(19833, Fann@CowData[fann][fannPosX], Fann@CowData[fann][fannPosY], Fann@CowData[fann][fannPosZ], Fann@CowData[fann][fannPosRX], Fann@CowData[fann][fannPosRY], Fann@CowData[fann][fannPosRZ], -1, -1, -1, 900.00, 900.00); 
        FannCText[fann] = CreateDynamic3DTextLabel(FannCowCD[fann] == 0 ? "/squeezemilk" : "wait a minute", ARWIN, Fann@CowData[fann][fannPosX], Fann@CowData[fann][fannPosY], Fann@CowData[fann][fannPosZ], 3.5);
    }
    return 1;
}

Cow_Destroy(cowid = -1)
{
    if(cowid == -1)
    {
        forex(fann, MAX_COW) if(IsValidDynamicObject(FannCow[fann])) 
        {
            DestroyDynamicObject(FannCow[fann]);
            DestroyDynamic3DTextLabel(FannCText[fann]);
            FannCow[fann] = -1;
            FannCText[fann] = Text3D:-1;
        } 
    }
    else
    {
        if(IsValidDynamicObject(FannCow[cowid])) 
        {
            DestroyDynamicObject(FannCow[cowid]);
            DestroyDynamic3DTextLabel(FannCText[cowid]);
            FannCow[cowid] = -1;
            FannCText[cowid] = Text3D:-1;
        } 
    }
    return 1;
}

Cow_Respawn(cowid = -1)
{
    if(cowid == -1)
    {
        Cow_Destroy();
        Cow_Spawn();
    }
    else
    {
        Cow_Destroy(cowid);
        FannCow[cowid] = CreateDynamicObject(19833, Fann@CowData[cowid][fannPosX], Fann@CowData[cowid][fannPosY], Fann@CowData[cowid][fannPosZ], Fann@CowData[cowid][fannPosRX], Fann@CowData[cowid][fannPosRY], Fann@CowData[cowid][fannPosRZ], -1, -1, -1, 900.00, 900.00); 
        FannCText[cowid] = CreateDynamic3DTextLabel(FannCowCD[cowid] == 0 ? "/squeezemilk" : "wait a minute", ARWIN, Fann@CowData[cowid][fannPosX], Fann@CowData[cowid][fannPosY], Fann@CowData[cowid][fannPosZ], 3.5);
    }
    return 1;
}

Cow_PlayerNear(playerid, Float:range = 3.5)
{
    forex(fann, MAX_COW) if(IsPlayerInRangeOfPoint(playerid, range, Fann@CowData[fann][fannPosX], Fann@CowData[fann][fannPosY], Fann@CowData[fann][fannPosZ]))
    {
        return fann;
    }
    return -1;
}

CMD:fannrespawncow(playerid, params[])
{
    if(strcmp(UcpData[playerid][uUsername], "Fann"))
        return PermissionError(playerid);

    new cowid;
    if(sscanf(params, "D(-1)", cowid))
        return SendSyntaxMessage(playerid, "/fanndestroycow [cowid]");

    Cow_Respawn(cowid);
    return 1;
}

CMD:fanndestroycow(playerid, params[])
{
    if(strcmp(UcpData[playerid][uUsername], "Fann"))
        return PermissionError(playerid);

    new cowid;
    if(sscanf(params, "D(-1)", cowid))
        return SendSyntaxMessage(playerid, "/fanndestroycow [cowid]");

    Cow_Destroy(cowid);
    return 1;
}