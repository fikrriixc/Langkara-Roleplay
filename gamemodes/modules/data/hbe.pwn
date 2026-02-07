HBE_Show(playerid, type)
{
	if(type == 1)
	{
		PlayerTextDrawShow(playerid, grey_6[playerid]);
		PlayerTextDrawShow(playerid, yellow_2[playerid]);
		PlayerTextDrawShow(playerid, yellow_3[playerid]);
		PlayerTextDrawShow(playerid, PlayerTD[playerid][7]);
		PlayerTextDrawShow(playerid, PlayerTD[playerid][8]);
		PlayerTextDrawShow(playerid, hunger[playerid]);
		PlayerTextDrawShow(playerid, thrist[playerid]);
	}
	else if(type == 2)
	{
		PlayerTextDrawShow(playerid, DRINKBG_0[playerid]);
		PlayerTextDrawShow(playerid, DRINKBG_1[playerid]);
		PlayerTextDrawShow(playerid, DRINKBG_2[playerid]);
		PlayerTextDrawShow(playerid, DRINK[playerid]);
		PlayerTextDrawShow(playerid, FOODBG_0[playerid]);
		PlayerTextDrawShow(playerid, FOODBG_1[playerid]);
		PlayerTextDrawShow(playerid, FOODBG_2[playerid]);
		PlayerTextDrawShow(playerid, FOOD[playerid]);
		PlayerTextDrawShow(playerid, MONEYBG_0[playerid]);
		PlayerTextDrawShow(playerid, MONEYBG_1[playerid]);
		PlayerTextDrawShow(playerid, MONEYBG_2[playerid]);
		PlayerTextDrawShow(playerid, MONEYHUD[playerid]);
		PlayerTextDrawShow(playerid, MONEY[playerid]);
		PlayerTextDrawShow(playerid, NAME[playerid]);

		ShowPlayerProgressBar(playerid, FOODPROGRESS[playerid]);
		ShowPlayerProgressBar(playerid, DRINKPROGRESS[playerid]);
	}
	return 1;
}

HBE_Hide(playerid, type)
{
	if(type == 1)
	{
		PlayerTextDrawHide(playerid, grey_6[playerid]);
		PlayerTextDrawHide(playerid, yellow_2[playerid]);
		PlayerTextDrawHide(playerid, yellow_3[playerid]);
		PlayerTextDrawHide(playerid, PlayerTD[playerid][7]);
		PlayerTextDrawHide(playerid, PlayerTD[playerid][8]);
		PlayerTextDrawHide(playerid, hunger[playerid]);
		PlayerTextDrawHide(playerid, thrist[playerid]);
	}
	else if(type == 2)
	{
		PlayerTextDrawHide(playerid, DRINKBG_0[playerid]);
		PlayerTextDrawHide(playerid, DRINKBG_1[playerid]);
		PlayerTextDrawHide(playerid, DRINKBG_2[playerid]);
		PlayerTextDrawHide(playerid, DRINK[playerid]);
		PlayerTextDrawHide(playerid, FOODBG_0[playerid]);
		PlayerTextDrawHide(playerid, FOODBG_1[playerid]);
		PlayerTextDrawHide(playerid, FOODBG_2[playerid]);
		PlayerTextDrawHide(playerid, FOOD[playerid]);
		PlayerTextDrawHide(playerid, MONEYBG_0[playerid]);
		PlayerTextDrawHide(playerid, MONEYBG_1[playerid]);
		PlayerTextDrawHide(playerid, MONEYBG_2[playerid]);
		PlayerTextDrawHide(playerid, MONEYHUD[playerid]);
		PlayerTextDrawHide(playerid, MONEY[playerid]);
		PlayerTextDrawHide(playerid, NAME[playerid]);

		HidePlayerProgressBar(playerid, FOODPROGRESS[playerid]);
		HidePlayerProgressBar(playerid, DRINKPROGRESS[playerid]);
	}
	return 1;
}

HBEVeh_Show(playerid, type)
{
	if(type == 1)
	{
		PlayerTextDrawShow(playerid, grey_0[playerid]);
		PlayerTextDrawShow(playerid, yellow_0[playerid]);
		PlayerTextDrawShow(playerid, yellow_1[playerid]);
		PlayerTextDrawShow(playerid, vehspeed[playerid]);
		PlayerTextDrawShow(playerid, vehfuel[playerid]);
		PlayerTextDrawShow(playerid, engine_0[playerid]);
		PlayerTextDrawShow(playerid, engine_1[playerid]);
		PlayerTextDrawShow(playerid, engine_2[playerid]);
		PlayerTextDrawShow(playerid, engine_3[playerid]);
		PlayerTextDrawShow(playerid, engine_4[playerid]);
		PlayerTextDrawShow(playerid, engine_5[playerid]);
		PlayerTextDrawShow(playerid, engine_6[playerid]);
		PlayerTextDrawShow(playerid, engine_7[playerid]);
		PlayerTextDrawShow(playerid, unlock_0[playerid]);
		PlayerTextDrawShow(playerid, grey_1[playerid]);
		PlayerTextDrawShow(playerid, unlock_1[playerid]);
		PlayerTextDrawShow(playerid, grey_2[playerid]);
		PlayerTextDrawShow(playerid, unlock_2[playerid]);
		PlayerTextDrawShow(playerid, grey_3[playerid]);
		PlayerTextDrawShow(playerid, grey_4[playerid]);
		PlayerTextDrawShow(playerid, grey_5[playerid]);

		for(new i; i < 7; i++)
			PlayerTextDrawShow(playerid, PlayerTD[playerid][i]);
	}
	else if(type == 2)
	{
		PlayerTextDrawShow(playerid, F_0[playerid]);
		PlayerTextDrawShow(playerid, F_1[playerid]);
		PlayerTextDrawShow(playerid, F_2[playerid]);
		PlayerTextDrawShow(playerid, FUELICON[playerid]);
		PlayerTextDrawShow(playerid, H_0[playerid]);
		PlayerTextDrawShow(playerid, H_1[playerid]);
		PlayerTextDrawShow(playerid, H_2[playerid]);
		PlayerTextDrawShow(playerid, HEALTHICON[playerid]);
		PlayerTextDrawShow(playerid, S_0[playerid]);
		PlayerTextDrawShow(playerid, S_1[playerid]);
		PlayerTextDrawShow(playerid, S_2[playerid]);
		PlayerTextDrawShow(playerid, SPEEDICON[playerid]);
		PlayerTextDrawShow(playerid, SPEED[playerid]);
		PlayerTextDrawShow(playerid, VEHICLENAME[playerid]);

		ShowPlayerProgressBar(playerid, FUELBAR[playerid]);
		ShowPlayerProgressBar(playerid, HEALTHBAR[playerid]);
	}
	return 1;
}

HBEVeh_Hide(playerid, type)
{
	if(type == 1)
	{
		PlayerTextDrawHide(playerid, grey_0[playerid]);
		PlayerTextDrawHide(playerid, yellow_0[playerid]);
		PlayerTextDrawHide(playerid, yellow_1[playerid]);
		PlayerTextDrawHide(playerid, vehspeed[playerid]);
		PlayerTextDrawHide(playerid, vehfuel[playerid]);
		PlayerTextDrawHide(playerid, engine_0[playerid]);
		PlayerTextDrawHide(playerid, engine_1[playerid]);
		PlayerTextDrawHide(playerid, engine_2[playerid]);
		PlayerTextDrawHide(playerid, engine_3[playerid]);
		PlayerTextDrawHide(playerid, engine_4[playerid]);
		PlayerTextDrawHide(playerid, engine_5[playerid]);
		PlayerTextDrawHide(playerid, engine_6[playerid]);
		PlayerTextDrawHide(playerid, engine_7[playerid]);
		PlayerTextDrawHide(playerid, unlock_0[playerid]);
		PlayerTextDrawHide(playerid, grey_1[playerid]);
		PlayerTextDrawHide(playerid, unlock_1[playerid]);
		PlayerTextDrawHide(playerid, grey_2[playerid]);
		PlayerTextDrawHide(playerid, unlock_2[playerid]);
		PlayerTextDrawHide(playerid, grey_3[playerid]);
		PlayerTextDrawHide(playerid, grey_4[playerid]);
		PlayerTextDrawHide(playerid, grey_5[playerid]);

		for(new i; i < 7; i++)
			PlayerTextDrawHide(playerid, PlayerTD[playerid][i]);
	}
	else if(type == 2)
	{
		PlayerTextDrawHide(playerid, F_0[playerid]);
		PlayerTextDrawHide(playerid, F_1[playerid]);
		PlayerTextDrawHide(playerid, F_2[playerid]);
		PlayerTextDrawHide(playerid, FUELICON[playerid]);
		PlayerTextDrawHide(playerid, H_0[playerid]);
		PlayerTextDrawHide(playerid, H_1[playerid]);
		PlayerTextDrawHide(playerid, H_2[playerid]);
		PlayerTextDrawHide(playerid, HEALTHICON[playerid]);
		PlayerTextDrawHide(playerid, S_0[playerid]);
		PlayerTextDrawHide(playerid, S_1[playerid]);
		PlayerTextDrawHide(playerid, S_2[playerid]);
		PlayerTextDrawHide(playerid, SPEEDICON[playerid]);
		PlayerTextDrawHide(playerid, SPEED[playerid]);
		PlayerTextDrawHide(playerid, VEHICLENAME[playerid]);

		HidePlayerProgressBar(playerid, FUELBAR[playerid]);
		HidePlayerProgressBar(playerid, HEALTHBAR[playerid]);
	}
	TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
	return 1;
}

ConvertHBEColor(Float:value) 
{
    new color;
    if(value >= 90 && value <= 100)
        color = 0x15a014FF;
    else if(value >= 80 && value < 90)
        color = 0x1b9913FF;
    else if(value >= 70 && value < 80)
        color = 0x1a7f08FF;
    else if(value >= 60 && value < 70)
        color = 0x326305FF;
    else if(value >= 50 && value < 60)
        color = 0x375d04FF;
    else if(value >= 40 && value < 50)
        color = 0x603304FF;
    else if(value >= 30 && value < 40)
        color = 0xd72800FF;
    else if(value >= 10 && value < 30)
        color = 0xfb3508FF;
    else if(value >= 0 && value < 10)
        color = 0xFF0000FF;
    else 
        color = COLOR_WHITE;

    return color;
}