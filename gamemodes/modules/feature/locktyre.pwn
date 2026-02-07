// Lock Vehicle Tyre 
// by Fan

enum e_locktyre_data
{
    tObject,
    bool:tValid
};

new
    TyreData[MAX_VEHICLES][4][e_locktyre_data]
;

LockTyre_Locked(vehicleid, must = 1) 
{
    new count; 
    forex(fan, 4) if(TyreData[vehicleid][fan][tValid])
        count++;

    if(count < must)
        return 0; 
    
    return 1;
}

LockTyre_Near(playerid, vehicleid, Float:range = 1.0) // near of tire
{
    forex(fan, 4) if(IsPlayerInRangeOfVehiclePart(playerid, vehicleid, fan+1, range))
        return fan;

    return -1;
}

LockTyre_Attach(vehicleid, tyre)
{
    if(!TyreData[vehicleid][tyre][tValid])
    {
        if(IsValidDynamicObject(TyreData[vehicleid][tyre][tObject]))
            DestroyDynamicObject(TyreData[vehicleid][tyre][tObject]);
        
        new Float:tyrepos[3], Float:vehpos[4];
        GetVehiclePos(vehicleid, vehpos[0], vehpos[1], vehpos[2]);
        GetVehicleZAngle(vehicleid, vehpos[3]);
        Tryg3D::GetVehiclePartPos(vehicleid, tyre+1, tyrepos[0], tyrepos[1], tyrepos[2]);

        new Float:attachtyre[6];
        tyrepos[0] += 0.25 * floatsin(-vehpos[3], degrees);
        tyrepos[1] += 0.25 * floatcos(-vehpos[3], degrees);

        attachtyre[0] = ((tyrepos[0] - vehpos[0]) * floatcos(vehpos[3], degrees)) + ((tyrepos[1] - vehpos[1]) * floatsin(vehpos[3], degrees));
        attachtyre[1] = ((tyrepos[1] - vehpos[1]) * floatcos(vehpos[3], degrees)) - ((tyrepos[0] - vehpos[0]) * floatsin(vehpos[3], degrees));
        attachtyre[2] = (tyrepos[2] - vehpos[2]) - 0.2;
        attachtyre[3] = 0.0;
        attachtyre[4] = -36.0;
        attachtyre[5] = (/*-269.001 - */vehpos[3]);

        TyreData[vehicleid][tyre][tValid] = true;
        TyreData[vehicleid][tyre][tObject] = CreateDynamicObject(19094, vehpos[0], vehpos[1], vehpos[2], 0.0, 0.0, 0.0);
        forex(fan, 5) SetDynamicObjectMaterial(TyreData[vehicleid][tyre][tObject], fan, 19094, "none", "none", RGBAToARGB(COLOR_YELLOW));

        AttachDynamicObjectToVehicle(TyreData[vehicleid][tyre][tObject], vehicleid, attachtyre[0], attachtyre[1], attachtyre[2], attachtyre[3], attachtyre[4], attachtyre[5]);
        SetVehicleSpeedCap(vehicleid, 1);
    }
    return 1;
}

LockTyre_Deattach(vehicleid, tyre) 
{
    if(IsValidDynamicObject(TyreData[vehicleid][tyre][tObject]))
        DestroyDynamicObject(TyreData[vehicleid][tyre][tObject]);

    TyreData[vehicleid][tyre][tValid] = false;
    if(LockTyre_Locked(vehicleid, 0)) SetVehicleSpeedCap(vehicleid, 0);
    return 1;
}
