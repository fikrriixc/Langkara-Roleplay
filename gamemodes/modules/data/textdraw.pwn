//------------[ Textdraw ]------------

//fishing
new PlayerText:fishingTextDraw[MAX_PLAYERS][15];
new PlayerText:fishingBarTextDraw[MAX_PLAYERS][5];

new PlayerText:fishingBarProgress[MAX_PLAYERS];
new PlayerText:fishingBarLuck[MAX_PLAYERS];

//Info textdraw
new PlayerText:InfoTD[MAX_PLAYERS];
new Text:TextTime, Text:TextDate;
new Text:TDEditor_TD[12];

//Hehe
new Text:TextFann;

/*public:TDUpdates()
{
	foreach(new playerid : Player) if(PlayerData[playerid][IsLoggedIn])
	{
		TextDrawHideForPlayer(playerid, FannText[0]);
		TextDrawHideForPlayer(playerid, FannText[1]);
		if(!fannchanged)
		{
			TextDrawColor(FannText[0], 16777215);
			TextDrawColor(FannText[1], -1);
			fannchanged = true;
		}
		else
		{
			TextDrawColor(FannText[1], 16777215);
			TextDrawColor(FannText[0], -1);
			fannchanged = false;
		}
		TextDrawShowForPlayer(playerid, FannText[0]);
		TextDrawShowForPlayer(playerid, FannText[1]);
	}
}*/

//Phone
new Text:PhoneTD[183];
new Text:AppTambahan[26];
new Text:PowerButton;
new Text:BankButton;
new Text:HopeButton;
new Text:XButton;
new Text:CameraButton;
new Text:CallButton;
new Text:MessageButton;
new Text:ContactButton;
new Text:SettingButton;
new Text:VehicleButton;
new Text:MapsButton;
new Text:SpotifyButtonHome;
new Text:SpotifyTextHome;

//Modern HBE
new PlayerText:DRINKBG_0[MAX_PLAYERS];
new PlayerText:DRINKBG_1[MAX_PLAYERS];
new PlayerText:DRINKBG_2[MAX_PLAYERS];
new PlayerText:DRINK[MAX_PLAYERS];
new PlayerText:FOODBG_0[MAX_PLAYERS];
new PlayerText:FOODBG_1[MAX_PLAYERS];
new PlayerText:FOODBG_2[MAX_PLAYERS];
new PlayerText:FOOD[MAX_PLAYERS];
new PlayerText:MONEYBG_0[MAX_PLAYERS];
new PlayerText:MONEYBG_1[MAX_PLAYERS];
new PlayerText:MONEYBG_2[MAX_PLAYERS];
new PlayerText:MONEYHUD[MAX_PLAYERS];
new PlayerText:MONEY[MAX_PLAYERS];
new PlayerText:NAME[MAX_PLAYERS];
new PlayerBar:DRINKPROGRESS[MAX_PLAYERS];
new PlayerBar:FOODPROGRESS[MAX_PLAYERS];

new PlayerText:F_0[MAX_PLAYERS];
new PlayerText:F_1[MAX_PLAYERS];
new PlayerText:F_2[MAX_PLAYERS];
new PlayerText:FUELICON[MAX_PLAYERS];
new PlayerText:H_0[MAX_PLAYERS];
new PlayerText:H_1[MAX_PLAYERS];
new PlayerText:H_2[MAX_PLAYERS];
new PlayerText:HEALTHICON[MAX_PLAYERS];
new PlayerText:S_0[MAX_PLAYERS];
new PlayerText:S_1[MAX_PLAYERS];
new PlayerText:S_2[MAX_PLAYERS];
new PlayerText:SPEED[MAX_PLAYERS];
new PlayerText:SPEEDICON[MAX_PLAYERS];
new PlayerText:VEHICLENAME[MAX_PLAYERS];
new PlayerBar:FUELBAR[MAX_PLAYERS];
new PlayerBar:HEALTHBAR[MAX_PLAYERS];

// Simple HBE
new PlayerText:grey_6[MAX_PLAYERS];
new PlayerText:yellow_2[MAX_PLAYERS];
new PlayerText:yellow_3[MAX_PLAYERS];
new PlayerText:hunger[MAX_PLAYERS];
new PlayerText:thrist[MAX_PLAYERS];

new PlayerText:PlayerTD[MAX_PLAYERS][9]; // 7, 8 is hunger & thirst part
new PlayerText:grey_0[MAX_PLAYERS];
new PlayerText:yellow_0[MAX_PLAYERS];
new PlayerText:yellow_1[MAX_PLAYERS];
new PlayerText:vehspeed[MAX_PLAYERS];
new PlayerText:vehfuel[MAX_PLAYERS];
new PlayerText:engine_0[MAX_PLAYERS];
new PlayerText:engine_1[MAX_PLAYERS];
new PlayerText:engine_2[MAX_PLAYERS];
new PlayerText:engine_3[MAX_PLAYERS];
new PlayerText:engine_4[MAX_PLAYERS];
new PlayerText:engine_5[MAX_PLAYERS];
new PlayerText:engine_6[MAX_PLAYERS];
new PlayerText:engine_7[MAX_PLAYERS];
new PlayerText:unlock_1[MAX_PLAYERS];
new PlayerText:grey_1[MAX_PLAYERS];
new PlayerText:unlock_0[MAX_PLAYERS];
new PlayerText:grey_2[MAX_PLAYERS];
new PlayerText:unlock_2[MAX_PLAYERS];
new PlayerText:grey_3[MAX_PLAYERS];
new PlayerText:grey_4[MAX_PLAYERS];
new PlayerText:grey_5[MAX_PLAYERS];

new Text:DPvehfare[MAX_PLAYERS];

new PlayerText:ActiveTD[MAX_PLAYERS],
	PlayerText:CASHTD[MAX_PLAYERS];

CreatePlayerTextDraws(playerid)
{
	// Fishing
	fishingTextDraw[playerid][0] = CreatePlayerTextDraw(playerid, 201.000, 381.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][0], 270.000, 1.000);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][0], 255);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][0], true);

	fishingTextDraw[playerid][1] = CreatePlayerTextDraw(playerid, 201.000, 403.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][1], 270.000, 1.000);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][1], 255);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][1], true);

	fishingTextDraw[playerid][2] = CreatePlayerTextDraw(playerid, 201.000, 403.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][2], 1.000, -21.000);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][2], 255);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][2], true);

	fishingTextDraw[playerid][3] = CreatePlayerTextDraw(playerid, 470.000, 403.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][3], 1.000, -21.000);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][3], 255);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][3], true);

	fishingTextDraw[playerid][4] = CreatePlayerTextDraw(playerid, 313.000, 377.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][4], 47.000, 31.000);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][4], 255);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][4], true);

	fishingTextDraw[playerid][5] = CreatePlayerTextDraw(playerid, 313.000, 382.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][5], -111.000, 21.000);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][5], 16744447);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][5], 255);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][5], true);

	fishingTextDraw[playerid][6] = CreatePlayerTextDraw(playerid, 360.000, 382.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][6], 110.000, 21.000);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][6], 16744447);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][6], 255);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][6], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][6], true);

	fishingTextDraw[playerid][7] = CreatePlayerTextDraw(playerid, 381.000, 382.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][7], 1.000, 21.000);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][7], 255);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][7], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][7], true);

	fishingTextDraw[playerid][8] = CreatePlayerTextDraw(playerid, 433.000, 382.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][8], 1.000, 21.000);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][8], 255);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][8], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][8], true);

	fishingTextDraw[playerid][9] = CreatePlayerTextDraw(playerid, 293.000, 382.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][9], 1.000, 21.000);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][9], 255);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][9], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][9], true);

	fishingTextDraw[playerid][10] = CreatePlayerTextDraw(playerid, 235.000, 382.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][10], 1.000, 21.000);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][10], 255);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][10], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][10], true);

	fishingTextDraw[playerid][11] = CreatePlayerTextDraw(playerid, 313.000, 350.000, "_");
	PlayerTextDrawTextSize(playerid, fishingTextDraw[playerid][11], 49.000, 82.000);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][11], 202);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][11], 0);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][11], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][11], false);
	PlayerTextDrawSetPreviewModel(playerid, fishingTextDraw[playerid][11], 1608);
	PlayerTextDrawSetPreviewRot(playerid, fishingTextDraw[playerid][11], 0.000, 0.000, -90.000, 1.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, fishingTextDraw[playerid][11], 0, 0);

	fishingTextDraw[playerid][12] = CreatePlayerTextDraw(playerid, 332.000, 386.000, "?");
	PlayerTextDrawLetterSize(playerid, fishingTextDraw[playerid][12], 0.240, 1.199);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][12], 150);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][12], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][12], true);

	fishingTextDraw[playerid][13] = CreatePlayerTextDraw(playerid, 306.000, 363.000, "Click Fast!");
	PlayerTextDrawLetterSize(playerid, fishingTextDraw[playerid][13], 0.200, 1.099);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][13], -1);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][13], 150);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][13], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][13], true);

	fishingTextDraw[playerid][14] = CreatePlayerTextDraw(playerid, 342.000, 363.000, "(000)");
	PlayerTextDrawLetterSize(playerid, fishingTextDraw[playerid][14], 0.200, 1.099);
	PlayerTextDrawAlignment(playerid, fishingTextDraw[playerid][14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingTextDraw[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, fishingTextDraw[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, fishingTextDraw[playerid][14], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingTextDraw[playerid][14], 150);
	PlayerTextDrawFont(playerid, fishingTextDraw[playerid][14], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, fishingTextDraw[playerid][14], true);


	fishingBarTextDraw[playerid][0] = CreatePlayerTextDraw(playerid, 479.000, 185.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingBarTextDraw[playerid][0], 1.000, 56.000);
	PlayerTextDrawAlignment(playerid, fishingBarTextDraw[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingBarTextDraw[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, fishingBarTextDraw[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, fishingBarTextDraw[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingBarTextDraw[playerid][0], 255);
	PlayerTextDrawFont(playerid, fishingBarTextDraw[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingBarTextDraw[playerid][0], true);

	fishingBarTextDraw[playerid][1] = CreatePlayerTextDraw(playerid, 473.000, 185.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingBarTextDraw[playerid][1], 1.000, 56.000);
	PlayerTextDrawAlignment(playerid, fishingBarTextDraw[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingBarTextDraw[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, fishingBarTextDraw[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, fishingBarTextDraw[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingBarTextDraw[playerid][1], 255);
	PlayerTextDrawFont(playerid, fishingBarTextDraw[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingBarTextDraw[playerid][1], true);

	fishingBarTextDraw[playerid][2] = CreatePlayerTextDraw(playerid, 473.000, 185.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingBarTextDraw[playerid][2], 7.000, 1.000);
	PlayerTextDrawAlignment(playerid, fishingBarTextDraw[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingBarTextDraw[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, fishingBarTextDraw[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, fishingBarTextDraw[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingBarTextDraw[playerid][2], 255);
	PlayerTextDrawFont(playerid, fishingBarTextDraw[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingBarTextDraw[playerid][2], true);

	fishingBarTextDraw[playerid][3] = CreatePlayerTextDraw(playerid, 473.000, 241.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingBarTextDraw[playerid][3], 7.000, 1.000);
	PlayerTextDrawAlignment(playerid, fishingBarTextDraw[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingBarTextDraw[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, fishingBarTextDraw[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, fishingBarTextDraw[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingBarTextDraw[playerid][3], 255);
	PlayerTextDrawFont(playerid, fishingBarTextDraw[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingBarTextDraw[playerid][3], true);

	fishingBarTextDraw[playerid][4] = CreatePlayerTextDraw(playerid, 467.000, 246.000, "Charge");
	PlayerTextDrawLetterSize(playerid, fishingBarTextDraw[playerid][4], 0.180, 0.999);
	PlayerTextDrawAlignment(playerid, fishingBarTextDraw[playerid][4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingBarTextDraw[playerid][4], 16744447);
	PlayerTextDrawSetShadow(playerid, fishingBarTextDraw[playerid][4], 1);
	PlayerTextDrawSetOutline(playerid, fishingBarTextDraw[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingBarTextDraw[playerid][4], 150);
	PlayerTextDrawFont(playerid, fishingBarTextDraw[playerid][4], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, fishingBarTextDraw[playerid][4], true);


	fishingBarProgress[playerid] = CreatePlayerTextDraw(playerid, 474.000, 241.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, fishingBarProgress[playerid], 5.000, -55.000);
	PlayerTextDrawAlignment(playerid, fishingBarProgress[playerid], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingBarProgress[playerid], 16744447);
	PlayerTextDrawSetShadow(playerid, fishingBarProgress[playerid], 0);
	PlayerTextDrawSetOutline(playerid, fishingBarProgress[playerid], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingBarProgress[playerid], 255);
	PlayerTextDrawFont(playerid, fishingBarProgress[playerid], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, fishingBarProgress[playerid], true);

	fishingBarLuck[playerid] = CreatePlayerTextDraw(playerid, 484.000, 183.000, "xLuck");
	PlayerTextDrawLetterSize(playerid, fishingBarLuck[playerid], 0.230, 1.098);
	PlayerTextDrawAlignment(playerid, fishingBarLuck[playerid], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, fishingBarLuck[playerid], 16744447);
	PlayerTextDrawSetShadow(playerid, fishingBarLuck[playerid], 1);
	PlayerTextDrawSetOutline(playerid, fishingBarLuck[playerid], 0);
	PlayerTextDrawBackgroundColour(playerid, fishingBarLuck[playerid], 150);
	PlayerTextDrawFont(playerid, fishingBarLuck[playerid], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, fishingBarLuck[playerid], true);

	//Info textdraw
	InfoTD[playerid] = CreatePlayerTextDraw(playerid, 148.888, 361.385, "Selamat Datang!");
 	PlayerTextDrawLetterSize(playerid, InfoTD[playerid], 0.326, 1.654);
	Fann_PlayerTextDrawAlignment(playerid, InfoTD[playerid], 1);
	PlayerTextDrawColor(playerid, InfoTD[playerid], -1);
	PlayerTextDrawSetOutline(playerid, InfoTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, InfoTD[playerid], 0x000000FF);
	Fann_PlayerTextDrawFont(playerid, InfoTD[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, InfoTD[playerid], 1);
	
	ActiveTD[playerid] = CreatePlayerTextDraw(playerid, 274.000000, 176.583435, "Mengisi Ulang...");
	PlayerTextDrawLetterSize(playerid, ActiveTD[playerid], 0.374000, 1.349166);
	Fann_PlayerTextDrawAlignment(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawColor(playerid, ActiveTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, ActiveTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, ActiveTD[playerid], 255);
	Fann_PlayerTextDrawFont(playerid, ActiveTD[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ActiveTD[playerid], 0);
	
	DRINKBG_0[playerid] = CreatePlayerTextDraw(playerid, 550.500000, 424.000000, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, DRINKBG_0[playerid], 5);
	PlayerTextDrawLetterSize(playerid, DRINKBG_0[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DRINKBG_0[playerid], 35.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, DRINKBG_0[playerid], 0);
	PlayerTextDrawSetShadow(playerid, DRINKBG_0[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, DRINKBG_0[playerid], 1);
	PlayerTextDrawColor(playerid, DRINKBG_0[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, DRINKBG_0[playerid], 0);
	PlayerTextDrawBoxColor(playerid, DRINKBG_0[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, DRINKBG_0[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, DRINKBG_0[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, DRINKBG_0[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, DRINKBG_0[playerid], 1614);
	PlayerTextDrawSetPreviewRot(playerid, DRINKBG_0[playerid], 0.000000, 0.000000, -90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, DRINKBG_0[playerid], 1, 1);

	DRINKBG_1[playerid] = CreatePlayerTextDraw(playerid, 567.000000, 430.000000, "ld_dual:black");
	Fann_PlayerTextDrawFont(playerid, DRINKBG_1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, DRINKBG_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DRINKBG_1[playerid], 60.000000, 15.000000);
	PlayerTextDrawSetOutline(playerid, DRINKBG_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DRINKBG_1[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, DRINKBG_1[playerid], 1);
	PlayerTextDrawColor(playerid, DRINKBG_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, DRINKBG_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, DRINKBG_1[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, DRINKBG_1[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, DRINKBG_1[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, DRINKBG_1[playerid], 0);

	DRINKBG_2[playerid] = CreatePlayerTextDraw(playerid, 610.500000, 418.700012, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, DRINKBG_2[playerid], 5);
	PlayerTextDrawLetterSize(playerid, DRINKBG_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DRINKBG_2[playerid], 35.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, DRINKBG_2[playerid], 0);
	PlayerTextDrawSetShadow(playerid, DRINKBG_2[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, DRINKBG_2[playerid], 1);
	PlayerTextDrawColor(playerid, DRINKBG_2[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, DRINKBG_2[playerid], 0);
	PlayerTextDrawBoxColor(playerid, DRINKBG_2[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, DRINKBG_2[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, DRINKBG_2[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, DRINKBG_2[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, DRINKBG_2[playerid], 1614);
	PlayerTextDrawSetPreviewRot(playerid, DRINKBG_2[playerid], 0.000000, 180.000000, -90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, DRINKBG_2[playerid], 1, 1);

	DRINK[playerid] = CreatePlayerTextDraw(playerid, 568.000000, 432.000000, "HUD:radar_datedrink");
	Fann_PlayerTextDrawFont(playerid, DRINK[playerid], 4);
	PlayerTextDrawLetterSize(playerid, DRINK[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DRINK[playerid], 10.000000, 10.000000);
	PlayerTextDrawSetOutline(playerid, DRINK[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DRINK[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, DRINK[playerid], 1);
	PlayerTextDrawColor(playerid, DRINK[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, DRINK[playerid], 255);
	PlayerTextDrawBoxColor(playerid, DRINK[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, DRINK[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, DRINK[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, DRINK[playerid], 0);

	FOODBG_0[playerid] = CreatePlayerTextDraw(playerid, 550.000000, 401.700012, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, FOODBG_0[playerid], 5);
	PlayerTextDrawLetterSize(playerid, FOODBG_0[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FOODBG_0[playerid], 35.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, FOODBG_0[playerid], 0);
	PlayerTextDrawSetShadow(playerid, FOODBG_0[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, FOODBG_0[playerid], 1);
	PlayerTextDrawColor(playerid, FOODBG_0[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, FOODBG_0[playerid], 0);
	PlayerTextDrawBoxColor(playerid, FOODBG_0[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, FOODBG_0[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, FOODBG_0[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, FOODBG_0[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, FOODBG_0[playerid], 1614);
	PlayerTextDrawSetPreviewRot(playerid, FOODBG_0[playerid], 0.000000, 180.000000, -90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, FOODBG_0[playerid], 1, 1);

	FOODBG_1[playerid] = CreatePlayerTextDraw(playerid, 566.500000, 412.700012, "ld_dual:black");
	Fann_PlayerTextDrawFont(playerid, FOODBG_1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FOODBG_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FOODBG_1[playerid], 60.000000, 15.000000);
	PlayerTextDrawSetOutline(playerid, FOODBG_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FOODBG_1[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, FOODBG_1[playerid], 1);
	PlayerTextDrawColor(playerid, FOODBG_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FOODBG_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FOODBG_1[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, FOODBG_1[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, FOODBG_1[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, FOODBG_1[playerid], 0);

	FOODBG_2[playerid] = CreatePlayerTextDraw(playerid, 610.500000, 406.899993, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, FOODBG_2[playerid], 5);
	PlayerTextDrawLetterSize(playerid, FOODBG_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FOODBG_2[playerid], 35.000000, 51.000000);
	PlayerTextDrawSetOutline(playerid, FOODBG_2[playerid], 0);
	PlayerTextDrawSetShadow(playerid, FOODBG_2[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, FOODBG_2[playerid], 1);
	PlayerTextDrawColor(playerid, FOODBG_2[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, FOODBG_2[playerid], 0);
	PlayerTextDrawBoxColor(playerid, FOODBG_2[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, FOODBG_2[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, FOODBG_2[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, FOODBG_2[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, FOODBG_2[playerid], 1614);
	PlayerTextDrawSetPreviewRot(playerid, FOODBG_2[playerid], 0.000000, 0.000000, -90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, FOODBG_2[playerid], 1, 1);

	FOOD[playerid] = CreatePlayerTextDraw(playerid, 568.000000, 415.000000, "HUD:radar_datefood");
	Fann_PlayerTextDrawFont(playerid, FOOD[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FOOD[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FOOD[playerid], 10.000000, 10.000000);
	PlayerTextDrawSetOutline(playerid, FOOD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FOOD[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, FOOD[playerid], 1);
	PlayerTextDrawColor(playerid, FOOD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FOOD[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FOOD[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, FOOD[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, FOOD[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, FOOD[playerid], 0);

	MONEYBG_0[playerid] = CreatePlayerTextDraw(playerid, 550.500000, 390.000000, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, MONEYBG_0[playerid], 5);
	PlayerTextDrawLetterSize(playerid, MONEYBG_0[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MONEYBG_0[playerid], 35.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, MONEYBG_0[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MONEYBG_0[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, MONEYBG_0[playerid], 1);
	PlayerTextDrawColor(playerid, MONEYBG_0[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, MONEYBG_0[playerid], 0);
	PlayerTextDrawBoxColor(playerid, MONEYBG_0[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, MONEYBG_0[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, MONEYBG_0[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, MONEYBG_0[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MONEYBG_0[playerid], 1614);
	PlayerTextDrawSetPreviewRot(playerid, MONEYBG_0[playerid], 0.000000, 0.000000, -90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, MONEYBG_0[playerid], 1, 1);

	MONEYBG_1[playerid] = CreatePlayerTextDraw(playerid, 567.000000, 395.700012, "ld_dual:black");
	Fann_PlayerTextDrawFont(playerid, MONEYBG_1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, MONEYBG_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MONEYBG_1[playerid], 60.000000, 15.000000);
	PlayerTextDrawSetOutline(playerid, MONEYBG_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MONEYBG_1[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, MONEYBG_1[playerid], 1);
	PlayerTextDrawColor(playerid, MONEYBG_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, MONEYBG_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, MONEYBG_1[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, MONEYBG_1[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, MONEYBG_1[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, MONEYBG_1[playerid], 0);

	MONEYBG_2[playerid] = CreatePlayerTextDraw(playerid, 610.500000, 384.200012, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, MONEYBG_2[playerid], 5);
	PlayerTextDrawLetterSize(playerid, MONEYBG_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MONEYBG_2[playerid], 35.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, MONEYBG_2[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MONEYBG_2[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, MONEYBG_2[playerid], 1);
	PlayerTextDrawColor(playerid, MONEYBG_2[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, MONEYBG_2[playerid], 0);
	PlayerTextDrawBoxColor(playerid, MONEYBG_2[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, MONEYBG_2[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, MONEYBG_2[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, MONEYBG_2[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MONEYBG_2[playerid], 1614);
	PlayerTextDrawSetPreviewRot(playerid, MONEYBG_2[playerid], 0.000000, 180.000000, -90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, MONEYBG_2[playerid], 1, 1);

	MONEYHUD[playerid] = CreatePlayerTextDraw(playerid, 568.000000, 398.000000, "HUD:radar_cash");
	Fann_PlayerTextDrawFont(playerid, MONEYHUD[playerid], 4);
	PlayerTextDrawLetterSize(playerid, MONEYHUD[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MONEYHUD[playerid], 10.000000, 10.000000);
	PlayerTextDrawSetOutline(playerid, MONEYHUD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MONEYHUD[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, MONEYHUD[playerid], 1);
	PlayerTextDrawColor(playerid, MONEYHUD[playerid], -21557249);
	PlayerTextDrawBackgroundColor(playerid, MONEYHUD[playerid], 255);
	PlayerTextDrawBoxColor(playerid, MONEYHUD[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, MONEYHUD[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, MONEYHUD[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, MONEYHUD[playerid], 0);

	MONEY[playerid] = CreatePlayerTextDraw(playerid, 625.000000, 396.000000, "$9.999,99");
	Fann_PlayerTextDrawFont(playerid, MONEY[playerid], 2);
	PlayerTextDrawLetterSize(playerid, MONEY[playerid], 0.170833, 1.200000);
	PlayerTextDrawTextSize(playerid, MONEY[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MONEY[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MONEY[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, MONEY[playerid], 3);
	PlayerTextDrawColor(playerid, MONEY[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, MONEY[playerid], 255);
	PlayerTextDrawBoxColor(playerid, MONEY[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, MONEY[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, MONEY[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, MONEY[playerid], 0);

	NAME[playerid] = CreatePlayerTextDraw(playerid, 631.000000, 380.000000, "Ken Clarence");
	Fann_PlayerTextDrawFont(playerid, NAME[playerid], 0);
	PlayerTextDrawLetterSize(playerid, NAME[playerid], 0.266665, 1.349998);
	PlayerTextDrawTextSize(playerid, NAME[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAME[playerid], 1);
	PlayerTextDrawSetShadow(playerid, NAME[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, NAME[playerid], 3);
	PlayerTextDrawColor(playerid, NAME[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, NAME[playerid], 255);
	PlayerTextDrawBoxColor(playerid, NAME[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, NAME[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, NAME[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, NAME[playerid], 0);

	F_0[playerid] = CreatePlayerTextDraw(playerid, 533.500000, 424.000000, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, F_0[playerid], 5);
	PlayerTextDrawLetterSize(playerid, F_0[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, F_0[playerid], 35.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, F_0[playerid], 0);
	PlayerTextDrawSetShadow(playerid, F_0[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, F_0[playerid], 1);
	PlayerTextDrawColor(playerid, F_0[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, F_0[playerid], 0);
	PlayerTextDrawBoxColor(playerid, F_0[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, F_0[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, F_0[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, F_0[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, F_0[playerid], 1614);
	PlayerTextDrawSetPreviewRot(playerid, F_0[playerid], 0.000000, 0.000000, -90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, F_0[playerid], 1, 1);

	F_1[playerid] = CreatePlayerTextDraw(playerid, 489.399993, 430.000000, "ld_dual:black");
	Fann_PlayerTextDrawFont(playerid, F_1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, F_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, F_1[playerid], 60.000000, 15.000000);
	PlayerTextDrawSetOutline(playerid, F_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, F_1[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, F_1[playerid], 1);
	PlayerTextDrawColor(playerid, F_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, F_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, F_1[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, F_1[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, F_1[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, F_1[playerid], 0);

	F_2[playerid] = CreatePlayerTextDraw(playerid, 473.000000, 418.700012, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, F_2[playerid], 5);
	PlayerTextDrawLetterSize(playerid, F_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, F_2[playerid], 35.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, F_2[playerid], 0);
	PlayerTextDrawSetShadow(playerid, F_2[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, F_2[playerid], 1);
	PlayerTextDrawColor(playerid, F_2[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, F_2[playerid], 0);
	PlayerTextDrawBoxColor(playerid, F_2[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, F_2[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, F_2[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, F_2[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, F_2[playerid], 1614);
	PlayerTextDrawSetPreviewRot(playerid, F_2[playerid], 0.000000, 180.000000, -90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, F_2[playerid], 1, 1);

	FUELICON[playerid] = CreatePlayerTextDraw(playerid, 487.000000, 428.700012, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, FUELICON[playerid], 5);
	PlayerTextDrawLetterSize(playerid, FUELICON[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FUELICON[playerid], 17.000000, 16.000000);
	PlayerTextDrawSetOutline(playerid, FUELICON[playerid], 0);
	PlayerTextDrawSetShadow(playerid, FUELICON[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, FUELICON[playerid], 1);
	PlayerTextDrawColor(playerid, FUELICON[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FUELICON[playerid], 0);
	PlayerTextDrawBoxColor(playerid, FUELICON[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, FUELICON[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, FUELICON[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, FUELICON[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, FUELICON[playerid], 1650);
	PlayerTextDrawSetPreviewRot(playerid, FUELICON[playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, FUELICON[playerid], 1, 1);

	H_0[playerid] = CreatePlayerTextDraw(playerid, 533.000000, 401.200012, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, H_0[playerid], 5);
	PlayerTextDrawLetterSize(playerid, H_0[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, H_0[playerid], 35.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, H_0[playerid], 0);
	PlayerTextDrawSetShadow(playerid, H_0[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, H_0[playerid], 1);
	PlayerTextDrawColor(playerid, H_0[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, H_0[playerid], 0);
	PlayerTextDrawBoxColor(playerid, H_0[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, H_0[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, H_0[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, H_0[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, H_0[playerid], 1614);
	PlayerTextDrawSetPreviewRot(playerid, H_0[playerid], 0.000000, 180.000000, -90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, H_0[playerid], 1, 1);

	H_1[playerid] = CreatePlayerTextDraw(playerid, 489.299987, 412.700012, "ld_dual:black");
	Fann_PlayerTextDrawFont(playerid, H_1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, H_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, H_1[playerid], 60.000000, 15.000000);
	PlayerTextDrawSetOutline(playerid, H_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, H_1[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, H_1[playerid], 1);
	PlayerTextDrawColor(playerid, H_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, H_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, H_1[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, H_1[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, H_1[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, H_1[playerid], 0);

	H_2[playerid] = CreatePlayerTextDraw(playerid, 473.000000, 406.899993, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, H_2[playerid], 5);
	PlayerTextDrawLetterSize(playerid, H_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, H_2[playerid], 35.000000, 51.000000);
	PlayerTextDrawSetOutline(playerid, H_2[playerid], 0);
	PlayerTextDrawSetShadow(playerid, H_2[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, H_2[playerid], 1);
	PlayerTextDrawColor(playerid, H_2[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, H_2[playerid], 0);
	PlayerTextDrawBoxColor(playerid, H_2[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, H_2[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, H_2[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, H_2[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, H_2[playerid], 1614);
	PlayerTextDrawSetPreviewRot(playerid, H_2[playerid], 0.000000, 0.000000, -90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, H_2[playerid], 1, 1);

	HEALTHICON[playerid] = CreatePlayerTextDraw(playerid, 491.000000, 415.000000, "HUD:radar_girlfriend");
	Fann_PlayerTextDrawFont(playerid, HEALTHICON[playerid], 4);
	PlayerTextDrawLetterSize(playerid, HEALTHICON[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, HEALTHICON[playerid], 10.000000, 10.000000);
	PlayerTextDrawSetOutline(playerid, HEALTHICON[playerid], 1);
	PlayerTextDrawSetShadow(playerid, HEALTHICON[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, HEALTHICON[playerid], 1);
	PlayerTextDrawColor(playerid, HEALTHICON[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, HEALTHICON[playerid], 255);
	PlayerTextDrawBoxColor(playerid, HEALTHICON[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, HEALTHICON[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, HEALTHICON[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, HEALTHICON[playerid], 0);

	S_0[playerid] = CreatePlayerTextDraw(playerid, 533.000000, 390.000000, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, S_0[playerid], 5);
	PlayerTextDrawLetterSize(playerid, S_0[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, S_0[playerid], 35.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, S_0[playerid], 0);
	PlayerTextDrawSetShadow(playerid, S_0[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, S_0[playerid], 1);
	PlayerTextDrawColor(playerid, S_0[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, S_0[playerid], 0);
	PlayerTextDrawBoxColor(playerid, S_0[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, S_0[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, S_0[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, S_0[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, S_0[playerid], 1614);
	PlayerTextDrawSetPreviewRot(playerid, S_0[playerid], 0.000000, 0.000000, -90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, S_0[playerid], 1, 1);

	S_1[playerid] = CreatePlayerTextDraw(playerid, 489.299987, 395.700012, "ld_dual:black");
	Fann_PlayerTextDrawFont(playerid, S_1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, S_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, S_1[playerid], 60.000000, 15.000000);
	PlayerTextDrawSetOutline(playerid, S_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, S_1[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, S_1[playerid], 1);
	PlayerTextDrawColor(playerid, S_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, S_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, S_1[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, S_1[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, S_1[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, S_1[playerid], 0);

	S_2[playerid] = CreatePlayerTextDraw(playerid, 472.500000, 384.200012, "Preview_Model");
	Fann_PlayerTextDrawFont(playerid, S_2[playerid], 5);
	PlayerTextDrawLetterSize(playerid, S_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, S_2[playerid], 35.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, S_2[playerid], 0);
	PlayerTextDrawSetShadow(playerid, S_2[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, S_2[playerid], 1);
	PlayerTextDrawColor(playerid, S_2[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, S_2[playerid], 0);
	PlayerTextDrawBoxColor(playerid, S_2[playerid], 255);
	Fann_PlayerTextDrawUseBox(playerid, S_2[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, S_2[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, S_2[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, S_2[playerid], 1614);
	PlayerTextDrawSetPreviewRot(playerid, S_2[playerid], 0.000000, 180.000000, -90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, S_2[playerid], 1, 1);

	SPEED[playerid] = CreatePlayerTextDraw(playerid, 547.000000, 396.000000, "50 MPH");
	Fann_PlayerTextDrawFont(playerid, SPEED[playerid], 2);
	PlayerTextDrawLetterSize(playerid, SPEED[playerid], 0.170833, 1.200000);
	PlayerTextDrawTextSize(playerid, SPEED[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, SPEED[playerid], 0);
	PlayerTextDrawSetShadow(playerid, SPEED[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, SPEED[playerid], 3);
	PlayerTextDrawColor(playerid, SPEED[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, SPEED[playerid], 255);
	PlayerTextDrawBoxColor(playerid, SPEED[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, SPEED[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, SPEED[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, SPEED[playerid], 0);

	SPEEDICON[playerid] = CreatePlayerTextDraw(playerid, 491.000000, 398.000000, "HUD:radar_impound");
	Fann_PlayerTextDrawFont(playerid, SPEEDICON[playerid], 4);
	PlayerTextDrawLetterSize(playerid, SPEEDICON[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, SPEEDICON[playerid], 10.000000, 10.000000);
	PlayerTextDrawSetOutline(playerid, SPEEDICON[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SPEEDICON[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, SPEEDICON[playerid], 1);
	PlayerTextDrawColor(playerid, SPEEDICON[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, SPEEDICON[playerid], 255);
	PlayerTextDrawBoxColor(playerid, SPEEDICON[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, SPEEDICON[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, SPEEDICON[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, SPEEDICON[playerid], 0);

	VEHICLENAME[playerid] = CreatePlayerTextDraw(playerid, 548.000000, 380.000000, "Infernus");
	Fann_PlayerTextDrawFont(playerid, VEHICLENAME[playerid], 0);
	PlayerTextDrawLetterSize(playerid, VEHICLENAME[playerid], 0.266665, 1.349997);
	PlayerTextDrawTextSize(playerid, VEHICLENAME[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VEHICLENAME[playerid], 1);
	PlayerTextDrawSetShadow(playerid, VEHICLENAME[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, VEHICLENAME[playerid], 3);
	PlayerTextDrawColor(playerid, VEHICLENAME[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, VEHICLENAME[playerid], 255);
	PlayerTextDrawBoxColor(playerid, VEHICLENAME[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, VEHICLENAME[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, VEHICLENAME[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, VEHICLENAME[playerid], 0);

	// Simple HBE
	grey_0[playerid] = CreatePlayerTextDraw(playerid, 524.000000, 429.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, grey_0[playerid], 4);
	PlayerTextDrawLetterSize(playerid, grey_0[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, grey_0[playerid], 117.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, grey_0[playerid], 1);
	PlayerTextDrawSetShadow(playerid, grey_0[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, grey_0[playerid], 1);
	PlayerTextDrawColor(playerid, grey_0[playerid], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, grey_0[playerid], 255);
	PlayerTextDrawBoxColor(playerid, grey_0[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, grey_0[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, grey_0[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, grey_0[playerid], 0);

	yellow_0[playerid] = CreatePlayerTextDraw(playerid, 629.000000, 429.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, yellow_0[playerid], 4);
	PlayerTextDrawLetterSize(playerid, yellow_0[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, yellow_0[playerid], 11.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, yellow_0[playerid], 1);
	PlayerTextDrawSetShadow(playerid, yellow_0[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, yellow_0[playerid], 1);
	PlayerTextDrawColor(playerid, yellow_0[playerid], HOPE);
	PlayerTextDrawBackgroundColor(playerid, yellow_0[playerid], 255);
	PlayerTextDrawBoxColor(playerid, yellow_0[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, yellow_0[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, yellow_0[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, yellow_0[playerid], 0);

	yellow_1[playerid] = CreatePlayerTextDraw(playerid, 524.000000, 429.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, yellow_1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, yellow_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, yellow_1[playerid], 1.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, yellow_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, yellow_1[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, yellow_1[playerid], 1);
	PlayerTextDrawColor(playerid, yellow_1[playerid], HOPE);
	PlayerTextDrawBackgroundColor(playerid, yellow_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, yellow_1[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, yellow_1[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, yellow_1[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, yellow_1[playerid], 0);

	vehspeed[playerid] = CreatePlayerTextDraw(playerid, 574.000000, 430.000000, "245");
	Fann_PlayerTextDrawFont(playerid, vehspeed[playerid], 2);
	PlayerTextDrawLetterSize(playerid, vehspeed[playerid], 0.150000, 1.500000);
	PlayerTextDrawTextSize(playerid, vehspeed[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, vehspeed[playerid], 0);
	PlayerTextDrawSetShadow(playerid, vehspeed[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, vehspeed[playerid], 1);
	PlayerTextDrawColor(playerid, vehspeed[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, vehspeed[playerid], 255);
	PlayerTextDrawBoxColor(playerid, vehspeed[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, vehspeed[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, vehspeed[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, vehspeed[playerid], 0);

	vehfuel[playerid] = CreatePlayerTextDraw(playerid, 623.000000, 430.000000, "40L");
	Fann_PlayerTextDrawFont(playerid, vehfuel[playerid], 2);
	PlayerTextDrawLetterSize(playerid, vehfuel[playerid], 0.150000, 1.500000);
	PlayerTextDrawTextSize(playerid, vehfuel[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, vehfuel[playerid], 0);
	PlayerTextDrawSetShadow(playerid, vehfuel[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, vehfuel[playerid], 3);
	PlayerTextDrawColor(playerid, vehfuel[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, vehfuel[playerid], 255);
	PlayerTextDrawBoxColor(playerid, vehfuel[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, vehfuel[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, vehfuel[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, vehfuel[playerid], 0);

	engine_0[playerid] = CreatePlayerTextDraw(playerid, 537.000000, 435.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, engine_0[playerid], 4);
	PlayerTextDrawLetterSize(playerid, engine_0[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, engine_0[playerid], 5.500000, 7.000000);
	PlayerTextDrawSetOutline(playerid, engine_0[playerid], 1);
	PlayerTextDrawSetShadow(playerid, engine_0[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, engine_0[playerid], 1);
	PlayerTextDrawColor(playerid, engine_0[playerid], -2115814145);
	PlayerTextDrawBackgroundColor(playerid, engine_0[playerid], 255);
	PlayerTextDrawBoxColor(playerid, engine_0[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, engine_0[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, engine_0[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, engine_0[playerid], 0);

	engine_1[playerid] = CreatePlayerTextDraw(playerid, 534.000000, 435.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, engine_1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, engine_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, engine_1[playerid], 3.500000, 5.500000);
	PlayerTextDrawSetOutline(playerid, engine_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, engine_1[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, engine_1[playerid], 1);
	PlayerTextDrawColor(playerid, engine_1[playerid], -2115814145);
	PlayerTextDrawBackgroundColor(playerid, engine_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, engine_1[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, engine_1[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, engine_1[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, engine_1[playerid], 0);

	engine_2[playerid] = CreatePlayerTextDraw(playerid, 543.500000, 435.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, engine_2[playerid], 4);
	PlayerTextDrawLetterSize(playerid, engine_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, engine_2[playerid], 1.000000, 7.000000);
	PlayerTextDrawSetOutline(playerid, engine_2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, engine_2[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, engine_2[playerid], 1);
	PlayerTextDrawColor(playerid, engine_2[playerid], -2115814145);
	PlayerTextDrawBackgroundColor(playerid, engine_2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, engine_2[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, engine_2[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, engine_2[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, engine_2[playerid], 0);

	engine_3[playerid] = CreatePlayerTextDraw(playerid, 542.000000, 438.000000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, engine_3[playerid], 4);
	PlayerTextDrawLetterSize(playerid, engine_3[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, engine_3[playerid], 1.500000, 1.000000);
	PlayerTextDrawSetOutline(playerid, engine_3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, engine_3[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, engine_3[playerid], 1);
	PlayerTextDrawColor(playerid, engine_3[playerid], -2115814145);
	PlayerTextDrawBackgroundColor(playerid, engine_3[playerid], 255);
	PlayerTextDrawBoxColor(playerid, engine_3[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, engine_3[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, engine_3[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, engine_3[playerid], 0);

	engine_4[playerid] = CreatePlayerTextDraw(playerid, 532.500000, 437.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, engine_4[playerid], 4);
	PlayerTextDrawLetterSize(playerid, engine_4[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, engine_4[playerid], 1.500000, 1.000000);
	PlayerTextDrawSetOutline(playerid, engine_4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, engine_4[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, engine_4[playerid], 1);
	PlayerTextDrawColor(playerid, engine_4[playerid], -2115814145);
	PlayerTextDrawBackgroundColor(playerid, engine_4[playerid], 255);
	PlayerTextDrawBoxColor(playerid, engine_4[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, engine_4[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, engine_4[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, engine_4[playerid], 0);

	engine_5[playerid] = CreatePlayerTextDraw(playerid, 532.000000, 435.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, engine_5[playerid], 4);
	PlayerTextDrawLetterSize(playerid, engine_5[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, engine_5[playerid], 1.000000, 7.000000);
	PlayerTextDrawSetOutline(playerid, engine_5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, engine_5[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, engine_5[playerid], 1);
	PlayerTextDrawColor(playerid, engine_5[playerid], -2115814145);
	PlayerTextDrawBackgroundColor(playerid, engine_5[playerid], 255);
	PlayerTextDrawBoxColor(playerid, engine_5[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, engine_5[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, engine_5[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, engine_5[playerid], 0);

	engine_6[playerid] = CreatePlayerTextDraw(playerid, 538.000000, 434.000000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, engine_6[playerid], 4);
	PlayerTextDrawLetterSize(playerid, engine_6[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, engine_6[playerid], 0.500000, 1.500000);
	PlayerTextDrawSetOutline(playerid, engine_6[playerid], 1);
	PlayerTextDrawSetShadow(playerid, engine_6[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, engine_6[playerid], 1);
	PlayerTextDrawColor(playerid, engine_6[playerid], -2115814145);
	PlayerTextDrawBackgroundColor(playerid, engine_6[playerid], 255);
	PlayerTextDrawBoxColor(playerid, engine_6[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, engine_6[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, engine_6[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, engine_6[playerid], 0);

	engine_7[playerid] = CreatePlayerTextDraw(playerid, 534.000000, 433.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, engine_7[playerid], 4);
	PlayerTextDrawLetterSize(playerid, engine_7[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, engine_7[playerid], 8.500000, 1.000000);
	PlayerTextDrawSetOutline(playerid, engine_7[playerid], 1);
	PlayerTextDrawSetShadow(playerid, engine_7[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, engine_7[playerid], 1);
	PlayerTextDrawColor(playerid, engine_7[playerid], -2115814145);
	PlayerTextDrawBackgroundColor(playerid, engine_7[playerid], 255);
	PlayerTextDrawBoxColor(playerid, engine_7[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, engine_7[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, engine_7[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, engine_7[playerid], 0);

	unlock_1[playerid] = CreatePlayerTextDraw(playerid, 549.000000, 432.000000, "ld_beat:chit");
	Fann_PlayerTextDrawFont(playerid, unlock_1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, unlock_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, unlock_1[playerid], 7.000000, 6.000000);
	PlayerTextDrawSetOutline(playerid, unlock_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, unlock_1[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, unlock_1[playerid], 1);
	PlayerTextDrawColor(playerid, unlock_1[playerid], -2115814145);
	PlayerTextDrawBackgroundColor(playerid, unlock_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, unlock_1[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, unlock_1[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, unlock_1[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, unlock_1[playerid], 0);

	grey_1[playerid] = CreatePlayerTextDraw(playerid, 549.500000, 433.000000, "ld_beat:chit");
	Fann_PlayerTextDrawFont(playerid, grey_1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, grey_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, grey_1[playerid], 6.000000, 5.500000);
	PlayerTextDrawSetOutline(playerid, grey_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, grey_1[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, grey_1[playerid], 1);
	PlayerTextDrawColor(playerid, grey_1[playerid], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, grey_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, grey_1[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, grey_1[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, grey_1[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, grey_1[playerid], 0);

	unlock_0[playerid] = CreatePlayerTextDraw(playerid, 549.000000, 436.000000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, unlock_0[playerid], 4);
	PlayerTextDrawLetterSize(playerid, unlock_0[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, unlock_0[playerid], 7.000000, 6.500000);
	PlayerTextDrawSetOutline(playerid, unlock_0[playerid], 1);
	PlayerTextDrawSetShadow(playerid, unlock_0[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, unlock_0[playerid], 1);
	PlayerTextDrawColor(playerid, unlock_0[playerid], -2115814145);
	PlayerTextDrawBackgroundColor(playerid, unlock_0[playerid], 255);
	PlayerTextDrawBoxColor(playerid, unlock_0[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, unlock_0[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, unlock_0[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, unlock_0[playerid], 0);

	grey_2[playerid] = CreatePlayerTextDraw(playerid, 549.500000, 436.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, grey_2[playerid], 4);
	PlayerTextDrawLetterSize(playerid, grey_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, grey_2[playerid], 6.000000, 5.000000);
	PlayerTextDrawSetOutline(playerid, grey_2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, grey_2[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, grey_2[playerid], 1);
	PlayerTextDrawColor(playerid, grey_2[playerid], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, grey_2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, grey_2[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, grey_2[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, grey_2[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, grey_2[playerid], 0);

	unlock_2[playerid] = CreatePlayerTextDraw(playerid, 551.000000, 437.000000, "ld_beat:chit");
	Fann_PlayerTextDrawFont(playerid, unlock_2[playerid], 4);
	PlayerTextDrawLetterSize(playerid, unlock_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, unlock_2[playerid], 3.500000, 3.500000);
	PlayerTextDrawSetOutline(playerid, unlock_2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, unlock_2[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, unlock_2[playerid], 1);
	PlayerTextDrawColor(playerid, unlock_2[playerid], -2115814145);
	PlayerTextDrawBackgroundColor(playerid, unlock_2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, unlock_2[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, unlock_2[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, unlock_2[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, unlock_2[playerid], 0);

	PlayerTD[playerid][0] = CreatePlayerTextDraw(playerid, 559.000000, 431.500000, "ld_beat:chit");
	Fann_PlayerTextDrawFont(playerid, PlayerTD[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][0], 13.000000, 13.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][0], 0);
	Fann_PlayerTextDrawAlignment(playerid, PlayerTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][0], 50);
	Fann_PlayerTextDrawUseBox(playerid, PlayerTD[playerid][0], 1);
	Fann_PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][0], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][0], 0);

	grey_3[playerid] = CreatePlayerTextDraw(playerid, 559.700012, 432.500000, "ld_beat:chit");
	Fann_PlayerTextDrawFont(playerid, grey_3[playerid], 4);
	PlayerTextDrawLetterSize(playerid, grey_3[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, grey_3[playerid], 11.500000, 11.500000);
	PlayerTextDrawSetOutline(playerid, grey_3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, grey_3[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, grey_3[playerid], 1);
	PlayerTextDrawColor(playerid, grey_3[playerid], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, grey_3[playerid], 255);
	PlayerTextDrawBoxColor(playerid, grey_3[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, grey_3[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, grey_3[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, grey_3[playerid], 0);

	grey_4[playerid] = CreatePlayerTextDraw(playerid, 561.500000, 441.000000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, grey_4[playerid], 4);
	PlayerTextDrawLetterSize(playerid, grey_4[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, grey_4[playerid], 7.500000, 3.000000);
	PlayerTextDrawSetOutline(playerid, grey_4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, grey_4[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, grey_4[playerid], 1);
	PlayerTextDrawColor(playerid, grey_4[playerid], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, grey_4[playerid], 255);
	PlayerTextDrawBoxColor(playerid, grey_4[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, grey_4[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, grey_4[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, grey_4[playerid], 0);

	PlayerTD[playerid][1] = CreatePlayerTextDraw(playerid, 564.000000, 438.000000, "ld_beat:chit");
	Fann_PlayerTextDrawFont(playerid, PlayerTD[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][1], 3.000000, 3.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][1], 0);
	Fann_PlayerTextDrawAlignment(playerid, PlayerTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][1], 50);
	Fann_PlayerTextDrawUseBox(playerid, PlayerTD[playerid][1], 1);
	Fann_PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][1], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][1], 0);

	PlayerTD[playerid][2] = CreatePlayerTextDraw(playerid, 565.000000, 432.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, PlayerTD[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][2], 0.500000, 6.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][2], 0);
	Fann_PlayerTextDrawAlignment(playerid, PlayerTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][2], 50);
	Fann_PlayerTextDrawUseBox(playerid, PlayerTD[playerid][2], 1);
	Fann_PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][2], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][2], 0);

	PlayerTD[playerid][3] = CreatePlayerTextDraw(playerid, 602.000000, 433.000000, "ld_beat:chit");
	Fann_PlayerTextDrawFont(playerid, PlayerTD[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][3], 6.500000, 9.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][3], 0);
	Fann_PlayerTextDrawAlignment(playerid, PlayerTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][3], 50);
	Fann_PlayerTextDrawUseBox(playerid, PlayerTD[playerid][3], 1);
	Fann_PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][3], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][3], 0);

	grey_5[playerid] = CreatePlayerTextDraw(playerid, 602.500000, 433.500000, "ld_beat:chit");
	Fann_PlayerTextDrawFont(playerid, grey_5[playerid], 4);
	PlayerTextDrawLetterSize(playerid, grey_5[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, grey_5[playerid], 5.500000, 8.000000);
	PlayerTextDrawSetOutline(playerid, grey_5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, grey_5[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, grey_5[playerid], 1);
	PlayerTextDrawColor(playerid, grey_5[playerid], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, grey_5[playerid], 255);
	PlayerTextDrawBoxColor(playerid, grey_5[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, grey_5[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, grey_5[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, grey_5[playerid], 0);

	PlayerTD[playerid][4] = CreatePlayerTextDraw(playerid, 600.000000, 433.000000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, PlayerTD[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][4], 6.000000, 9.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][4], 0);
	Fann_PlayerTextDrawAlignment(playerid, PlayerTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][4], 50);
	Fann_PlayerTextDrawUseBox(playerid, PlayerTD[playerid][4], 1);
	Fann_PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][4], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][4], 0);

	PlayerTD[playerid][5] = CreatePlayerTextDraw(playerid, 601.000000, 434.000000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, PlayerTD[playerid][5], 4);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][5], 4.000000, 3.500000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][5], 0);
	Fann_PlayerTextDrawAlignment(playerid, PlayerTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][5], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][5], 50);
	Fann_PlayerTextDrawUseBox(playerid, PlayerTD[playerid][5], 1);
	Fann_PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][5], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][5], 0);

	PlayerTD[playerid][6] = CreatePlayerTextDraw(playerid, 586.000000, 434.000000, "MPH");
	Fann_PlayerTextDrawFont(playerid, PlayerTD[playerid][6], 2);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][6], 0.100000, 1.000000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][6], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][6], 0);
	Fann_PlayerTextDrawAlignment(playerid, PlayerTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][6], 50);
	Fann_PlayerTextDrawUseBox(playerid, PlayerTD[playerid][6], 0);
	Fann_PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][6], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][6], 0);

	grey_6[playerid] = CreatePlayerTextDraw(playerid, 567.000000, 412.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, grey_6[playerid], 4);
	PlayerTextDrawLetterSize(playerid, grey_6[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, grey_6[playerid], 62.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, grey_6[playerid], 1);
	PlayerTextDrawSetShadow(playerid, grey_6[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, grey_6[playerid], 1);
	PlayerTextDrawColor(playerid, grey_6[playerid], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, grey_6[playerid], 255);
	PlayerTextDrawBoxColor(playerid, grey_6[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, grey_6[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, grey_6[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, grey_6[playerid], 0);

	yellow_2[playerid] = CreatePlayerTextDraw(playerid, 629.000000, 412.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, yellow_2[playerid], 4);
	PlayerTextDrawLetterSize(playerid, yellow_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, yellow_2[playerid], 11.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, yellow_2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, yellow_2[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, yellow_2[playerid], 1);
	PlayerTextDrawColor(playerid, yellow_2[playerid], HOPE);
	PlayerTextDrawBackgroundColor(playerid, yellow_2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, yellow_2[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, yellow_2[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, yellow_2[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, yellow_2[playerid], 0);

	yellow_3[playerid] = CreatePlayerTextDraw(playerid, 567.000000, 412.500000, "ld_dual:white");
	Fann_PlayerTextDrawFont(playerid, yellow_3[playerid], 4);
	PlayerTextDrawLetterSize(playerid, yellow_3[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, yellow_3[playerid], 1.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, yellow_3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, yellow_3[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, yellow_3[playerid], 1);
	PlayerTextDrawColor(playerid, yellow_3[playerid], HOPE);
	PlayerTextDrawBackgroundColor(playerid, yellow_3[playerid], 255);
	PlayerTextDrawBoxColor(playerid, yellow_3[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, yellow_3[playerid], 1);
	Fann_PlayerTextDrawSetProportional(playerid, yellow_3[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, yellow_3[playerid], 0);

	PlayerTD[playerid][7] = CreatePlayerTextDraw(playerid, 601.000000, 416.000000, "HUD:radar_diner");
	Fann_PlayerTextDrawFont(playerid, PlayerTD[playerid][7], 4);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][7], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][7], 10.000000, 10.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][7], 0);
	Fann_PlayerTextDrawAlignment(playerid, PlayerTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][7], 50);
	Fann_PlayerTextDrawUseBox(playerid, PlayerTD[playerid][7], 1);
	Fann_PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][7], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][7], 0);

	PlayerTD[playerid][8] = CreatePlayerTextDraw(playerid, 572.000000, 416.000000, "HUD:radar_burgerShot");
	Fann_PlayerTextDrawFont(playerid, PlayerTD[playerid][8], 4);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][8], 10.000000, 10.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][8], 0);
	Fann_PlayerTextDrawAlignment(playerid, PlayerTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][8], 50);
	Fann_PlayerTextDrawUseBox(playerid, PlayerTD[playerid][8], 1);
	Fann_PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][8], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][8], 0);

	hunger[playerid] = CreatePlayerTextDraw(playerid, 586.000000, 413.000000, "100");
	Fann_PlayerTextDrawFont(playerid, hunger[playerid], 2);
	PlayerTextDrawLetterSize(playerid, hunger[playerid], 0.150000, 1.500000);
	PlayerTextDrawTextSize(playerid, hunger[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, hunger[playerid], 0);
	PlayerTextDrawSetShadow(playerid, hunger[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, hunger[playerid], 1);
	PlayerTextDrawColor(playerid, hunger[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, hunger[playerid], 255);
	PlayerTextDrawBoxColor(playerid, hunger[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, hunger[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, hunger[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, hunger[playerid], 0);

	thrist[playerid] = CreatePlayerTextDraw(playerid, 614.000000, 413.000000, "100");
	Fann_PlayerTextDrawFont(playerid, thrist[playerid], 2);
	PlayerTextDrawLetterSize(playerid, thrist[playerid], 0.150000, 1.500000);
	PlayerTextDrawTextSize(playerid, thrist[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, thrist[playerid], 0);
	PlayerTextDrawSetShadow(playerid, thrist[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, thrist[playerid], 1);
	PlayerTextDrawColor(playerid, thrist[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, thrist[playerid], 255);
	PlayerTextDrawBoxColor(playerid, thrist[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, thrist[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, thrist[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, thrist[playerid], 0);

	CASHTD[playerid] = CreatePlayerTextDraw(playerid, 607.000000, 106.000000, "");
	Fann_PlayerTextDrawFont(playerid, CASHTD[playerid], 3);
	PlayerTextDrawLetterSize(playerid, CASHTD[playerid], 0.254166, 1.250000);
	PlayerTextDrawTextSize(playerid, CASHTD[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, CASHTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, CASHTD[playerid], 0);
	Fann_PlayerTextDrawAlignment(playerid, CASHTD[playerid], 3);
	PlayerTextDrawColor(playerid, CASHTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, CASHTD[playerid], 255);
	PlayerTextDrawBoxColor(playerid, CASHTD[playerid], 50);
	Fann_PlayerTextDrawUseBox(playerid, CASHTD[playerid], 0);
	Fann_PlayerTextDrawSetProportional(playerid, CASHTD[playerid], 1);
	Fann_PlayerTextDrawSetSelectable(playerid, CASHTD[playerid], 0);
}

CreateTextDraw()
{
	PhoneTD[0] = TextDrawCreate(483.000, 190.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[0], 71.000, 247.000);
	Fann_TextDrawAlignment(PhoneTD[0], 1);
	TextDrawColor(PhoneTD[0], -421070081);
	TextDrawSetShadow(PhoneTD[0], 0);
	TextDrawSetOutline(PhoneTD[0], 0);
	TextDrawBackgroundColor(PhoneTD[0], 255);
	Fann_TextDrawFont(PhoneTD[0], 4);
	Fann_TextDrawSetProportional(PhoneTD[0], 1);

	PhoneTD[1] = TextDrawCreate(468.000, 208.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[1], 103.000, 213.000);
	Fann_TextDrawAlignment(PhoneTD[1], 1);
	TextDrawColor(PhoneTD[1], -421070081);
	TextDrawSetShadow(PhoneTD[1], 0);
	TextDrawSetOutline(PhoneTD[1], 0);
	TextDrawBackgroundColor(PhoneTD[1], 255);
	Fann_TextDrawFont(PhoneTD[1], 4);
	Fann_TextDrawSetProportional(PhoneTD[1], 1);

	PhoneTD[2] = TextDrawCreate(460.100, 181.500, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[2], 46.000, 52.000);
	Fann_TextDrawAlignment(PhoneTD[2], 1);
	TextDrawColor(PhoneTD[2], -421070081);
	TextDrawSetShadow(PhoneTD[2], 0);
	TextDrawSetOutline(PhoneTD[2], 0);
	TextDrawBackgroundColor(PhoneTD[2], 255);
	Fann_TextDrawFont(PhoneTD[2], 4);
	Fann_TextDrawSetProportional(PhoneTD[2], 1);

	PhoneTD[3] = TextDrawCreate(532.500, 181.500, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[3], 46.000, 52.000);
	Fann_TextDrawAlignment(PhoneTD[3], 1);
	TextDrawColor(PhoneTD[3], -421070081);
	TextDrawSetShadow(PhoneTD[3], 0);
	TextDrawSetOutline(PhoneTD[3], 0);
	TextDrawBackgroundColor(PhoneTD[3], 255);
	Fann_TextDrawFont(PhoneTD[3], 4);
	Fann_TextDrawSetProportional(PhoneTD[3], 1);

	PhoneTD[4] = TextDrawCreate(460.100, 394.329, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[4], 46.000, 52.000);
	Fann_TextDrawAlignment(PhoneTD[4], 1);
	TextDrawColor(PhoneTD[4], -421070081);
	TextDrawSetShadow(PhoneTD[4], 0);
	TextDrawSetOutline(PhoneTD[4], 0);
	TextDrawBackgroundColor(PhoneTD[4], 255);
	Fann_TextDrawFont(PhoneTD[4], 4);
	Fann_TextDrawSetProportional(PhoneTD[4], 1);

	PhoneTD[5] = TextDrawCreate(532.500, 394.329, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[5], 46.000, 52.000);
	Fann_TextDrawAlignment(PhoneTD[5], 1);
	TextDrawColor(PhoneTD[5], -421070081);
	TextDrawSetShadow(PhoneTD[5], 0);
	TextDrawSetOutline(PhoneTD[5], 0);
	TextDrawBackgroundColor(PhoneTD[5], 255);
	Fann_TextDrawFont(PhoneTD[5], 4);
	Fann_TextDrawSetProportional(PhoneTD[5], 1);

	PhoneTD[6] = TextDrawCreate(463.000, 185.300, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[6], 39.000, 41.000);
	Fann_TextDrawAlignment(PhoneTD[6], 1);
	TextDrawColor(PhoneTD[6], 255);
	TextDrawSetShadow(PhoneTD[6], 0);
	TextDrawSetOutline(PhoneTD[6], 0);
	TextDrawBackgroundColor(PhoneTD[6], 255);
	Fann_TextDrawFont(PhoneTD[6], 4);
	Fann_TextDrawSetProportional(PhoneTD[6], 1);

	PhoneTD[7] = TextDrawCreate(536.500, 185.300, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[7], 39.000, 41.000);
	Fann_TextDrawAlignment(PhoneTD[7], 1);
	TextDrawColor(PhoneTD[7], 255);
	TextDrawSetShadow(PhoneTD[7], 0);
	TextDrawSetOutline(PhoneTD[7], 0);
	TextDrawBackgroundColor(PhoneTD[7], 255);
	Fann_TextDrawFont(PhoneTD[7], 4);
	Fann_TextDrawSetProportional(PhoneTD[7], 1);

	PhoneTD[8] = TextDrawCreate(482.000, 191.399, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[8], 75.000, 243.899);
	Fann_TextDrawAlignment(PhoneTD[8], 1);
	TextDrawColor(PhoneTD[8], 255);
	TextDrawSetShadow(PhoneTD[8], 0);
	TextDrawSetOutline(PhoneTD[8], 0);
	TextDrawBackgroundColor(PhoneTD[8], 255);
	Fann_TextDrawFont(PhoneTD[8], 4);
	Fann_TextDrawSetProportional(PhoneTD[8], 1);

	PhoneTD[9] = TextDrawCreate(463.000, 401.398, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[9], 39.000, 41.000);
	Fann_TextDrawAlignment(PhoneTD[9], 1);
	TextDrawColor(PhoneTD[9], 255);
	TextDrawSetShadow(PhoneTD[9], 0);
	TextDrawSetOutline(PhoneTD[9], 0);
	TextDrawBackgroundColor(PhoneTD[9], 255);
	Fann_TextDrawFont(PhoneTD[9], 4);
	Fann_TextDrawSetProportional(PhoneTD[9], 1);

	PhoneTD[10] = TextDrawCreate(536.500, 401.398, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[10], 39.000, 41.000);
	Fann_TextDrawAlignment(PhoneTD[10], 1);
	TextDrawColor(PhoneTD[10], 255);
	TextDrawSetShadow(PhoneTD[10], 0);
	TextDrawSetOutline(PhoneTD[10], 0);
	TextDrawBackgroundColor(PhoneTD[10], 255);
	Fann_TextDrawFont(PhoneTD[10], 4);
	Fann_TextDrawSetProportional(PhoneTD[10], 1);

	PhoneTD[11] = TextDrawCreate(469.200, 206.470, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[11], 100.500, 215.000);
	Fann_TextDrawAlignment(PhoneTD[11], 1);
	TextDrawColor(PhoneTD[11], 255);
	TextDrawSetShadow(PhoneTD[11], 0);
	TextDrawSetOutline(PhoneTD[11], 0);
	TextDrawBackgroundColor(PhoneTD[11], 255);
	Fann_TextDrawFont(PhoneTD[11], 4);
	Fann_TextDrawSetProportional(PhoneTD[11], 1);

	PhoneTD[12] = TextDrawCreate(469.500, 191.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[12], 27.000, 32.000);
	Fann_TextDrawAlignment(PhoneTD[12], 1);
	TextDrawColor(PhoneTD[12], 1088475391);
	TextDrawSetShadow(PhoneTD[12], 0);
	TextDrawSetOutline(PhoneTD[12], 0);
	TextDrawBackgroundColor(PhoneTD[12], 255);
	Fann_TextDrawFont(PhoneTD[12], 4);
	Fann_TextDrawSetProportional(PhoneTD[12], 1);

	PhoneTD[13] = TextDrawCreate(542.799, 191.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[13], 27.000, 32.000);
	Fann_TextDrawAlignment(PhoneTD[13], 1);
	TextDrawColor(PhoneTD[13], 1088475391);
	TextDrawSetShadow(PhoneTD[13], 0);
	TextDrawSetOutline(PhoneTD[13], 0);
	TextDrawBackgroundColor(PhoneTD[13], 255);
	Fann_TextDrawFont(PhoneTD[13], 4);
	Fann_TextDrawSetProportional(PhoneTD[13], 1);

	PhoneTD[14] = TextDrawCreate(483.200, 197.100, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[14], 72.500, 232.000);
	Fann_TextDrawAlignment(PhoneTD[14], 1);
	TextDrawColor(PhoneTD[14], 1088475391);
	TextDrawSetShadow(PhoneTD[14], 0);
	TextDrawSetOutline(PhoneTD[14], 0);
	TextDrawBackgroundColor(PhoneTD[14], 255);
	Fann_TextDrawFont(PhoneTD[14], 4);
	Fann_TextDrawSetProportional(PhoneTD[14], 1);

	PhoneTD[15] = TextDrawCreate(469.500, 402.700, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[15], 27.000, 32.000);
	Fann_TextDrawAlignment(PhoneTD[15], 1);
	TextDrawColor(PhoneTD[15], 1088475391);
	TextDrawSetShadow(PhoneTD[15], 0);
	TextDrawSetOutline(PhoneTD[15], 0);
	TextDrawBackgroundColor(PhoneTD[15], 255);
	Fann_TextDrawFont(PhoneTD[15], 4);
	Fann_TextDrawSetProportional(PhoneTD[15], 1);

	PhoneTD[16] = TextDrawCreate(542.500, 402.700, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[16], 27.000, 32.000);
	Fann_TextDrawAlignment(PhoneTD[16], 1);
	TextDrawColor(PhoneTD[16], 1088475391);
	TextDrawSetShadow(PhoneTD[16], 0);
	TextDrawSetOutline(PhoneTD[16], 0);
	TextDrawBackgroundColor(PhoneTD[16], 255);
	Fann_TextDrawFont(PhoneTD[16], 4);
	Fann_TextDrawSetProportional(PhoneTD[16], 1);

	PhoneTD[17] = TextDrawCreate(474.100, 209.100, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[17], 90.944, 208.000);
	Fann_TextDrawAlignment(PhoneTD[17], 1);
	TextDrawColor(PhoneTD[17], 1088475391);
	TextDrawSetShadow(PhoneTD[17], 0);
	TextDrawSetOutline(PhoneTD[17], 0);
	TextDrawBackgroundColor(PhoneTD[17], 255);
	Fann_TextDrawFont(PhoneTD[17], 4);
	Fann_TextDrawSetProportional(PhoneTD[17], 1);

	PhoneTD[18] = TextDrawCreate(492.000, 190.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[18], 15.000, 19.000);
	Fann_TextDrawAlignment(PhoneTD[18], 1);
	TextDrawColor(PhoneTD[18], 255);
	TextDrawSetShadow(PhoneTD[18], 0);
	TextDrawSetOutline(PhoneTD[18], 0);
	TextDrawBackgroundColor(PhoneTD[18], 255);
	Fann_TextDrawFont(PhoneTD[18], 4);
	Fann_TextDrawSetProportional(PhoneTD[18], 1);

	PhoneTD[19] = TextDrawCreate(492.000, 192.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[19], 7.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[19], 1);
	TextDrawColor(PhoneTD[19], 255);
	TextDrawSetShadow(PhoneTD[19], 0);
	TextDrawSetOutline(PhoneTD[19], 0);
	TextDrawBackgroundColor(PhoneTD[19], 255);
	Fann_TextDrawFont(PhoneTD[19], 4);
	Fann_TextDrawSetProportional(PhoneTD[19], 1);

	PhoneTD[20] = TextDrawCreate(493.000, 194.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[20], 7.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[20], 1);
	TextDrawColor(PhoneTD[20], 255);
	TextDrawSetShadow(PhoneTD[20], 0);
	TextDrawSetOutline(PhoneTD[20], 0);
	TextDrawBackgroundColor(PhoneTD[20], 255);
	Fann_TextDrawFont(PhoneTD[20], 4);
	Fann_TextDrawSetProportional(PhoneTD[20], 1);

	PhoneTD[21] = TextDrawCreate(540.000, 192.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[21], 7.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[21], 1);
	TextDrawColor(PhoneTD[21], 255);
	TextDrawSetShadow(PhoneTD[21], 0);
	TextDrawSetOutline(PhoneTD[21], 0);
	TextDrawBackgroundColor(PhoneTD[21], 255);
	Fann_TextDrawFont(PhoneTD[21], 4);
	Fann_TextDrawSetProportional(PhoneTD[21], 1);

	PhoneTD[22] = TextDrawCreate(539.000, 194.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[22], 7.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[22], 1);
	TextDrawColor(PhoneTD[22], 255);
	TextDrawSetShadow(PhoneTD[22], 0);
	TextDrawSetOutline(PhoneTD[22], 0);
	TextDrawBackgroundColor(PhoneTD[22], 255);
	Fann_TextDrawFont(PhoneTD[22], 4);
	Fann_TextDrawSetProportional(PhoneTD[22], 1);

	PhoneTD[23] = TextDrawCreate(532.000, 190.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[23], 15.000, 19.000);
	Fann_TextDrawAlignment(PhoneTD[23], 1);
	TextDrawColor(PhoneTD[23], 255);
	TextDrawSetShadow(PhoneTD[23], 0);
	TextDrawSetOutline(PhoneTD[23], 0);
	TextDrawBackgroundColor(PhoneTD[23], 255);
	Fann_TextDrawFont(PhoneTD[23], 4);
	Fann_TextDrawSetProportional(PhoneTD[23], 1);

	PhoneTD[24] = TextDrawCreate(499.000, 195.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[24], 40.000, 11.000);
	Fann_TextDrawAlignment(PhoneTD[24], 1);
	TextDrawColor(PhoneTD[24], 255);
	TextDrawSetShadow(PhoneTD[24], 0);
	TextDrawSetOutline(PhoneTD[24], 0);
	TextDrawBackgroundColor(PhoneTD[24], 255);
	Fann_TextDrawFont(PhoneTD[24], 4);
	Fann_TextDrawSetProportional(PhoneTD[24], 1);

	PhoneTD[25] = TextDrawCreate(513.500, 198.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[25], 13.000, 1.500);
	Fann_TextDrawAlignment(PhoneTD[25], 1);
	TextDrawColor(PhoneTD[25], 1768516029);
	TextDrawSetShadow(PhoneTD[25], 0);
	TextDrawSetOutline(PhoneTD[25], 0);
	TextDrawBackgroundColor(PhoneTD[25], 255);
	Fann_TextDrawFont(PhoneTD[25], 4);
	Fann_TextDrawSetProportional(PhoneTD[25], 1);

	PhoneTD[26] = TextDrawCreate(529.000, 196.500, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[26], 4.000, 5.000);
	Fann_TextDrawAlignment(PhoneTD[26], 1);
	TextDrawColor(PhoneTD[26], 1768516095);
	TextDrawSetShadow(PhoneTD[26], 0);
	TextDrawSetOutline(PhoneTD[26], 0);
	TextDrawBackgroundColor(PhoneTD[26], 255);
	Fann_TextDrawFont(PhoneTD[26], 4);
	Fann_TextDrawSetProportional(PhoneTD[26], 1);

	PhoneTD[27] = TextDrawCreate(529.299, 197.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[27], 2.500, 3.500);
	Fann_TextDrawAlignment(PhoneTD[27], 1);
	TextDrawColor(PhoneTD[27], 255);
	TextDrawSetShadow(PhoneTD[27], 0);
	TextDrawSetOutline(PhoneTD[27], 0);
	TextDrawBackgroundColor(PhoneTD[27], 255);
	Fann_TextDrawFont(PhoneTD[27], 4);
	Fann_TextDrawSetProportional(PhoneTD[27], 1);

	PhoneTD[28] = TextDrawCreate(467.000, 225.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[28], 1.000, 11.000);
	Fann_TextDrawAlignment(PhoneTD[28], 1);
	TextDrawColor(PhoneTD[28], -421070081);
	TextDrawSetShadow(PhoneTD[28], 0);
	TextDrawSetOutline(PhoneTD[28], 0);
	TextDrawBackgroundColor(PhoneTD[28], 255);
	Fann_TextDrawFont(PhoneTD[28], 4);
	Fann_TextDrawSetProportional(PhoneTD[28], 1);

	PhoneTD[29] = TextDrawCreate(467.000, 245.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[29], 1.000, 19.000);
	Fann_TextDrawAlignment(PhoneTD[29], 1);
	TextDrawColor(PhoneTD[29], -421070081);
	TextDrawSetShadow(PhoneTD[29], 0);
	TextDrawSetOutline(PhoneTD[29], 0);
	TextDrawBackgroundColor(PhoneTD[29], 255);
	Fann_TextDrawFont(PhoneTD[29], 4);
	Fann_TextDrawSetProportional(PhoneTD[29], 1);

	PhoneTD[30] = TextDrawCreate(467.000, 268.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[30], 1.000, 19.000);
	Fann_TextDrawAlignment(PhoneTD[30], 1);
	TextDrawColor(PhoneTD[30], -421070081);
	TextDrawSetShadow(PhoneTD[30], 0);
	TextDrawSetOutline(PhoneTD[30], 0);
	TextDrawBackgroundColor(PhoneTD[30], 255);
	Fann_TextDrawFont(PhoneTD[30], 4);
	Fann_TextDrawSetProportional(PhoneTD[30], 1);

	PhoneTD[31] = TextDrawCreate(571.000, 251.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[31], 1.000, 28.000);
	Fann_TextDrawAlignment(PhoneTD[31], 1);
	TextDrawColor(PhoneTD[31], -421070081);
	TextDrawSetShadow(PhoneTD[31], 0);
	TextDrawSetOutline(PhoneTD[31], 0);
	TextDrawBackgroundColor(PhoneTD[31], 255);
	Fann_TextDrawFont(PhoneTD[31], 4);
	Fann_TextDrawSetProportional(PhoneTD[31], 1);

	PhoneTD[32] = TextDrawCreate(554.000, 201.300, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[32], 4.500, 2.500);
	Fann_TextDrawAlignment(PhoneTD[32], 1);
	TextDrawColor(PhoneTD[32], -1);
	TextDrawSetShadow(PhoneTD[32], 0);
	TextDrawSetOutline(PhoneTD[32], 0);
	TextDrawBackgroundColor(PhoneTD[32], 255);
	Fann_TextDrawFont(PhoneTD[32], 4);
	Fann_TextDrawSetProportional(PhoneTD[32], 1);

	PhoneTD[33] = TextDrawCreate(553.000, 200.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[33], 6.500, 0.500);
	Fann_TextDrawAlignment(PhoneTD[33], 1);
	TextDrawColor(PhoneTD[33], -1);
	TextDrawSetShadow(PhoneTD[33], 0);
	TextDrawSetOutline(PhoneTD[33], 0);
	TextDrawBackgroundColor(PhoneTD[33], 255);
	Fann_TextDrawFont(PhoneTD[33], 4);
	Fann_TextDrawSetProportional(PhoneTD[33], 1);

	PhoneTD[34] = TextDrawCreate(553.000, 204.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[34], 6.500, 0.500);
	Fann_TextDrawAlignment(PhoneTD[34], 1);
	TextDrawColor(PhoneTD[34], -1);
	TextDrawSetShadow(PhoneTD[34], 0);
	TextDrawSetOutline(PhoneTD[34], 0);
	TextDrawBackgroundColor(PhoneTD[34], 255);
	Fann_TextDrawFont(PhoneTD[34], 4);
	Fann_TextDrawSetProportional(PhoneTD[34], 1);

	PhoneTD[35] = TextDrawCreate(553.000, 200.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[35], 0.500, 4.500);
	Fann_TextDrawAlignment(PhoneTD[35], 1);
	TextDrawColor(PhoneTD[35], -1);
	TextDrawSetShadow(PhoneTD[35], 0);
	TextDrawSetOutline(PhoneTD[35], 0);
	TextDrawBackgroundColor(PhoneTD[35], 255);
	Fann_TextDrawFont(PhoneTD[35], 4);
	Fann_TextDrawSetProportional(PhoneTD[35], 1);

	PhoneTD[36] = TextDrawCreate(559.000, 200.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[36], 0.500, 4.500);
	Fann_TextDrawAlignment(PhoneTD[36], 1);
	TextDrawColor(PhoneTD[36], -1);
	TextDrawSetShadow(PhoneTD[36], 0);
	TextDrawSetOutline(PhoneTD[36], 0);
	TextDrawBackgroundColor(PhoneTD[36], 255);
	Fann_TextDrawFont(PhoneTD[36], 4);
	Fann_TextDrawSetProportional(PhoneTD[36], 1);

	PhoneTD[37] = TextDrawCreate(551.000, 200.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[37], 0.500, 4.500);
	Fann_TextDrawAlignment(PhoneTD[37], 1);
	TextDrawColor(PhoneTD[37], -1);
	TextDrawSetShadow(PhoneTD[37], 0);
	TextDrawSetOutline(PhoneTD[37], 0);
	TextDrawBackgroundColor(PhoneTD[37], 255);
	Fann_TextDrawFont(PhoneTD[37], 4);
	Fann_TextDrawSetProportional(PhoneTD[37], 1);

	PhoneTD[38] = TextDrawCreate(550.000, 201.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[38], 0.500, 3.500);
	Fann_TextDrawAlignment(PhoneTD[38], 1);
	TextDrawColor(PhoneTD[38], -1);
	TextDrawSetShadow(PhoneTD[38], 0);
	TextDrawSetOutline(PhoneTD[38], 0);
	TextDrawBackgroundColor(PhoneTD[38], 255);
	Fann_TextDrawFont(PhoneTD[38], 4);
	Fann_TextDrawSetProportional(PhoneTD[38], 1);

	PhoneTD[39] = TextDrawCreate(548.500, 202.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[39], 0.500, 2.500);
	Fann_TextDrawAlignment(PhoneTD[39], 1);
	TextDrawColor(PhoneTD[39], -1);
	TextDrawSetShadow(PhoneTD[39], 0);
	TextDrawSetOutline(PhoneTD[39], 0);
	TextDrawBackgroundColor(PhoneTD[39], 255);
	Fann_TextDrawFont(PhoneTD[39], 4);
	Fann_TextDrawSetProportional(PhoneTD[39], 1);

	PhoneTD[40] = TextDrawCreate(547.000, 203.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[40], 0.500, 1.500);
	Fann_TextDrawAlignment(PhoneTD[40], 1);
	TextDrawColor(PhoneTD[40], -1);
	TextDrawSetShadow(PhoneTD[40], 0);
	TextDrawSetOutline(PhoneTD[40], 0);
	TextDrawBackgroundColor(PhoneTD[40], 255);
	Fann_TextDrawFont(PhoneTD[40], 4);
	Fann_TextDrawSetProportional(PhoneTD[40], 1);

	PhoneTD[41] = TextDrawCreate(545.500, 204.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[41], 0.500, 0.500);
	Fann_TextDrawAlignment(PhoneTD[41], 1);
	TextDrawColor(PhoneTD[41], -1);
	TextDrawSetShadow(PhoneTD[41], 0);
	TextDrawSetOutline(PhoneTD[41], 0);
	TextDrawBackgroundColor(PhoneTD[41], 255);
	Fann_TextDrawFont(PhoneTD[41], 4);
	Fann_TextDrawSetProportional(PhoneTD[41], 1);

	PhoneTD[42] = TextDrawCreate(486.000, 201.000, "15:20");
	TextDrawLetterSize(PhoneTD[42], 0.100, 0.597);
	Fann_TextDrawAlignment(PhoneTD[42], 2);
	TextDrawColor(PhoneTD[42], -1);
	TextDrawSetShadow(PhoneTD[42], 1);
	TextDrawSetOutline(PhoneTD[42], 5);
	TextDrawBackgroundColor(PhoneTD[42], 0);
	Fann_TextDrawFont(PhoneTD[42], 1);
	Fann_TextDrawSetProportional(PhoneTD[42], 1);

	PhoneTD[43] = TextDrawCreate(477.000, 394.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[43], 22.000, 26.000);
	Fann_TextDrawAlignment(PhoneTD[43], 1);
	TextDrawColor(PhoneTD[43], -1327438081);
	TextDrawSetShadow(PhoneTD[43], 0);
	TextDrawSetOutline(PhoneTD[43], 0);
	TextDrawBackgroundColor(PhoneTD[43], 255);
	Fann_TextDrawFont(PhoneTD[43], 4);
	Fann_TextDrawSetProportional(PhoneTD[43], 1);

	PhoneTD[44] = TextDrawCreate(477.000, 402.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[44], 22.000, 26.000);
	Fann_TextDrawAlignment(PhoneTD[44], 1);
	TextDrawColor(PhoneTD[44], -1327438081);
	TextDrawSetShadow(PhoneTD[44], 0);
	TextDrawSetOutline(PhoneTD[44], 0);
	TextDrawBackgroundColor(PhoneTD[44], 255);
	Fann_TextDrawFont(PhoneTD[44], 4);
	Fann_TextDrawSetProportional(PhoneTD[44], 1);

	PhoneTD[45] = TextDrawCreate(541.000, 394.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[45], 22.000, 26.000);
	Fann_TextDrawAlignment(PhoneTD[45], 1);
	TextDrawColor(PhoneTD[45], -1327438081);
	TextDrawSetShadow(PhoneTD[45], 0);
	TextDrawSetOutline(PhoneTD[45], 0);
	TextDrawBackgroundColor(PhoneTD[45], 255);
	Fann_TextDrawFont(PhoneTD[45], 4);
	Fann_TextDrawSetProportional(PhoneTD[45], 1);

	PhoneTD[46] = TextDrawCreate(541.000, 402.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[46], 22.000, 26.000);
	Fann_TextDrawAlignment(PhoneTD[46], 1);
	TextDrawColor(PhoneTD[46], -1327438081);
	TextDrawSetShadow(PhoneTD[46], 0);
	TextDrawSetOutline(PhoneTD[46], 0);
	TextDrawBackgroundColor(PhoneTD[46], 255);
	Fann_TextDrawFont(PhoneTD[46], 4);
	Fann_TextDrawSetProportional(PhoneTD[46], 1);

	PhoneTD[47] = TextDrawCreate(489.000, 398.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[47], 62.000, 26.000);
	Fann_TextDrawAlignment(PhoneTD[47], 1);
	TextDrawColor(PhoneTD[47], -1327438081);
	TextDrawSetShadow(PhoneTD[47], 0);
	TextDrawSetOutline(PhoneTD[47], 0);
	TextDrawBackgroundColor(PhoneTD[47], 255);
	Fann_TextDrawFont(PhoneTD[47], 4);
	Fann_TextDrawSetProportional(PhoneTD[47], 1);

	PhoneTD[48] = TextDrawCreate(481.000, 404.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[48], 78.000, 13.000);
	Fann_TextDrawAlignment(PhoneTD[48], 1);
	TextDrawColor(PhoneTD[48], -1327438081);
	TextDrawSetShadow(PhoneTD[48], 0);
	TextDrawSetOutline(PhoneTD[48], 0);
	TextDrawBackgroundColor(PhoneTD[48], 255);
	Fann_TextDrawFont(PhoneTD[48], 4);
	Fann_TextDrawSetProportional(PhoneTD[48], 1);

	PhoneTD[49] = TextDrawCreate(482.100, 216.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[49], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[49], 1);
	TextDrawColor(PhoneTD[49], -1343295745);
	TextDrawSetShadow(PhoneTD[49], 0);
	TextDrawSetOutline(PhoneTD[49], 0);
	TextDrawBackgroundColor(PhoneTD[49], 255);
	Fann_TextDrawFont(PhoneTD[49], 4);
	Fann_TextDrawSetProportional(PhoneTD[49], 1);

	PhoneTD[50] = TextDrawCreate(489.100, 216.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[50], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[50], 1);
	TextDrawColor(PhoneTD[50], -1343295745);
	TextDrawSetShadow(PhoneTD[50], 0);
	TextDrawSetOutline(PhoneTD[50], 0);
	TextDrawBackgroundColor(PhoneTD[50], 255);
	Fann_TextDrawFont(PhoneTD[50], 4);
	Fann_TextDrawSetProportional(PhoneTD[50], 1);

	PhoneTD[51] = TextDrawCreate(482.100, 225.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[51], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[51], 1);
	TextDrawColor(PhoneTD[51], -1343295745);
	TextDrawSetShadow(PhoneTD[51], 0);
	TextDrawSetOutline(PhoneTD[51], 0);
	TextDrawBackgroundColor(PhoneTD[51], 255);
	Fann_TextDrawFont(PhoneTD[51], 4);
	Fann_TextDrawSetProportional(PhoneTD[51], 1);

	PhoneTD[52] = TextDrawCreate(489.100, 225.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[52], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[52], 1);
	TextDrawColor(PhoneTD[52], -1343295745);
	TextDrawSetShadow(PhoneTD[52], 0);
	TextDrawSetOutline(PhoneTD[52], 0);
	TextDrawBackgroundColor(PhoneTD[52], 255);
	Fann_TextDrawFont(PhoneTD[52], 4);
	Fann_TextDrawSetProportional(PhoneTD[52], 1);

	PhoneTD[53] = TextDrawCreate(488.100, 218.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[53], 6.000, 17.000);
	Fann_TextDrawAlignment(PhoneTD[53], 1);
	TextDrawColor(PhoneTD[53], -1343295745);
	TextDrawSetShadow(PhoneTD[53], 0);
	TextDrawSetOutline(PhoneTD[53], 0);
	TextDrawBackgroundColor(PhoneTD[53], 255);
	Fann_TextDrawFont(PhoneTD[53], 4);
	Fann_TextDrawSetProportional(PhoneTD[53], 1);

	PhoneTD[54] = TextDrawCreate(483.600, 222.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[54], 14.500, 9.000);
	Fann_TextDrawAlignment(PhoneTD[54], 1);
	TextDrawColor(PhoneTD[54], -1343295745);
	TextDrawSetShadow(PhoneTD[54], 0);
	TextDrawSetOutline(PhoneTD[54], 0);
	TextDrawBackgroundColor(PhoneTD[54], 255);
	Fann_TextDrawFont(PhoneTD[54], 4);
	Fann_TextDrawSetProportional(PhoneTD[54], 1);

	PhoneTD[55] = TextDrawCreate(501.100, 216.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[55], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[55], 1);
	TextDrawColor(PhoneTD[55], 1687547391);
	TextDrawSetShadow(PhoneTD[55], 0);
	TextDrawSetOutline(PhoneTD[55], 0);
	TextDrawBackgroundColor(PhoneTD[55], 255);
	Fann_TextDrawFont(PhoneTD[55], 4);
	Fann_TextDrawSetProportional(PhoneTD[55], 1);

	PhoneTD[56] = TextDrawCreate(508.096, 216.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[56], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[56], 1);
	TextDrawColor(PhoneTD[56], 1687547391);
	TextDrawSetShadow(PhoneTD[56], 0);
	TextDrawSetOutline(PhoneTD[56], 0);
	TextDrawBackgroundColor(PhoneTD[56], 255);
	Fann_TextDrawFont(PhoneTD[56], 4);
	Fann_TextDrawSetProportional(PhoneTD[56], 1);

	PhoneTD[57] = TextDrawCreate(501.100, 225.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[57], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[57], 1);
	TextDrawColor(PhoneTD[57], 1687547391);
	TextDrawSetShadow(PhoneTD[57], 0);
	TextDrawSetOutline(PhoneTD[57], 0);
	TextDrawBackgroundColor(PhoneTD[57], 255);
	Fann_TextDrawFont(PhoneTD[57], 4);
	Fann_TextDrawSetProportional(PhoneTD[57], 1);

	PhoneTD[58] = TextDrawCreate(508.096, 225.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[58], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[58], 1);
	TextDrawColor(PhoneTD[58], 1687547391);
	TextDrawSetShadow(PhoneTD[58], 0);
	TextDrawSetOutline(PhoneTD[58], 0);
	TextDrawBackgroundColor(PhoneTD[58], 255);
	Fann_TextDrawFont(PhoneTD[58], 4);
	Fann_TextDrawSetProportional(PhoneTD[58], 1);

	PhoneTD[59] = TextDrawCreate(507.096, 218.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[59], 6.000, 17.000);
	Fann_TextDrawAlignment(PhoneTD[59], 1);
	TextDrawColor(PhoneTD[59], 1687547391);
	TextDrawSetShadow(PhoneTD[59], 0);
	TextDrawSetOutline(PhoneTD[59], 0);
	TextDrawBackgroundColor(PhoneTD[59], 255);
	Fann_TextDrawFont(PhoneTD[59], 4);
	Fann_TextDrawSetProportional(PhoneTD[59], 1);

	PhoneTD[60] = TextDrawCreate(502.600, 222.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[60], 14.500, 9.000);
	Fann_TextDrawAlignment(PhoneTD[60], 1);
	TextDrawColor(PhoneTD[60], 1687547391);
	TextDrawSetShadow(PhoneTD[60], 0);
	TextDrawSetOutline(PhoneTD[60], 0);
	TextDrawBackgroundColor(PhoneTD[60], 255);
	Fann_TextDrawFont(PhoneTD[60], 4);
	Fann_TextDrawSetProportional(PhoneTD[60], 1);

	PhoneTD[61] = TextDrawCreate(520.098, 216.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[61], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[61], 1);
	TextDrawColor(PhoneTD[61], -167773441);
	TextDrawSetShadow(PhoneTD[61], 0);
	TextDrawSetOutline(PhoneTD[61], 0);
	TextDrawBackgroundColor(PhoneTD[61], 255);
	Fann_TextDrawFont(PhoneTD[61], 4);
	Fann_TextDrawSetProportional(PhoneTD[61], 1);

	PhoneTD[62] = TextDrawCreate(527.098, 216.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[62], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[62], 1);
	TextDrawColor(PhoneTD[62], -167773441);
	TextDrawSetShadow(PhoneTD[62], 0);
	TextDrawSetOutline(PhoneTD[62], 0);
	TextDrawBackgroundColor(PhoneTD[62], 255);
	Fann_TextDrawFont(PhoneTD[62], 4);
	Fann_TextDrawSetProportional(PhoneTD[62], 1);

	PhoneTD[63] = TextDrawCreate(520.098, 225.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[63], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[63], 1);
	TextDrawColor(PhoneTD[63], -167773441);
	TextDrawSetShadow(PhoneTD[63], 0);
	TextDrawSetOutline(PhoneTD[63], 0);
	TextDrawBackgroundColor(PhoneTD[63], 255);
	Fann_TextDrawFont(PhoneTD[63], 4);
	Fann_TextDrawSetProportional(PhoneTD[63], 1);

	PhoneTD[64] = TextDrawCreate(527.098, 225.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[64], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[64], 1);
	TextDrawColor(PhoneTD[64], -167773441);
	TextDrawSetShadow(PhoneTD[64], 0);
	TextDrawSetOutline(PhoneTD[64], 0);
	TextDrawBackgroundColor(PhoneTD[64], 255);
	Fann_TextDrawFont(PhoneTD[64], 4);
	Fann_TextDrawSetProportional(PhoneTD[64], 1);

	PhoneTD[65] = TextDrawCreate(526.098, 218.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[65], 6.000, 17.000);
	Fann_TextDrawAlignment(PhoneTD[65], 1);
	TextDrawColor(PhoneTD[65], -167773441);
	TextDrawSetShadow(PhoneTD[65], 0);
	TextDrawSetOutline(PhoneTD[65], 0);
	TextDrawBackgroundColor(PhoneTD[65], 255);
	Fann_TextDrawFont(PhoneTD[65], 4);
	Fann_TextDrawSetProportional(PhoneTD[65], 1);

	PhoneTD[66] = TextDrawCreate(521.598, 222.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[66], 14.500, 9.000);
	Fann_TextDrawAlignment(PhoneTD[66], 1);
	TextDrawColor(PhoneTD[66], -167773441);
	TextDrawSetShadow(PhoneTD[66], 0);
	TextDrawSetOutline(PhoneTD[66], 0);
	TextDrawBackgroundColor(PhoneTD[66], 255);
	Fann_TextDrawFont(PhoneTD[66], 4);
	Fann_TextDrawSetProportional(PhoneTD[66], 1);

	PhoneTD[67] = TextDrawCreate(540.197, 216.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[67], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[67], 1);
	TextDrawColor(PhoneTD[67], 1887473919);
	TextDrawSetShadow(PhoneTD[67], 0);
	TextDrawSetOutline(PhoneTD[67], 0);
	TextDrawBackgroundColor(PhoneTD[67], 255);
	Fann_TextDrawFont(PhoneTD[67], 4);
	Fann_TextDrawSetProportional(PhoneTD[67], 1);

	PhoneTD[68] = TextDrawCreate(547.197, 216.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[68], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[68], 1);
	TextDrawColor(PhoneTD[68], 1887473919);
	TextDrawSetShadow(PhoneTD[68], 0);
	TextDrawSetOutline(PhoneTD[68], 0);
	TextDrawBackgroundColor(PhoneTD[68], 255);
	Fann_TextDrawFont(PhoneTD[68], 4);
	Fann_TextDrawSetProportional(PhoneTD[68], 1);

	PhoneTD[69] = TextDrawCreate(540.197, 225.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[69], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[69], 1);
	TextDrawColor(PhoneTD[69], 1887473919);
	TextDrawSetShadow(PhoneTD[69], 0);
	TextDrawSetOutline(PhoneTD[69], 0);
	TextDrawBackgroundColor(PhoneTD[69], 255);
	Fann_TextDrawFont(PhoneTD[69], 4);
	Fann_TextDrawSetProportional(PhoneTD[69], 1);

	PhoneTD[70] = TextDrawCreate(547.197, 225.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[70], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[70], 1);
	TextDrawColor(PhoneTD[70], 1887473919);
	TextDrawSetShadow(PhoneTD[70], 0);
	TextDrawSetOutline(PhoneTD[70], 0);
	TextDrawBackgroundColor(PhoneTD[70], 255);
	Fann_TextDrawFont(PhoneTD[70], 4);
	Fann_TextDrawSetProportional(PhoneTD[70], 1);

	PhoneTD[71] = TextDrawCreate(546.197, 218.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[71], 6.000, 17.000);
	Fann_TextDrawAlignment(PhoneTD[71], 1);
	TextDrawColor(PhoneTD[71], 1887473919);
	TextDrawSetShadow(PhoneTD[71], 0);
	TextDrawSetOutline(PhoneTD[71], 0);
	TextDrawBackgroundColor(PhoneTD[71], 255);
	Fann_TextDrawFont(PhoneTD[71], 4);
	Fann_TextDrawSetProportional(PhoneTD[71], 1);

	PhoneTD[72] = TextDrawCreate(541.697, 222.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[72], 14.500, 9.000);
	Fann_TextDrawAlignment(PhoneTD[72], 1);
	TextDrawColor(PhoneTD[72], 1887473919);
	TextDrawSetShadow(PhoneTD[72], 0);
	TextDrawSetOutline(PhoneTD[72], 0);
	TextDrawBackgroundColor(PhoneTD[72], 255);
	Fann_TextDrawFont(PhoneTD[72], 4);
	Fann_TextDrawSetProportional(PhoneTD[72], 1);

	PhoneTD[73] = TextDrawCreate(482.100, 245.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[73], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[73], 1);
	TextDrawColor(PhoneTD[73], -5963521);
	TextDrawSetShadow(PhoneTD[73], 0);
	TextDrawSetOutline(PhoneTD[73], 0);
	TextDrawBackgroundColor(PhoneTD[73], 255);
	Fann_TextDrawFont(PhoneTD[73], 4);
	Fann_TextDrawSetProportional(PhoneTD[73], 1);

	PhoneTD[74] = TextDrawCreate(489.100, 245.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[74], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[74], 1);
	TextDrawColor(PhoneTD[74], -5963521);
	TextDrawSetShadow(PhoneTD[74], 0);
	TextDrawSetOutline(PhoneTD[74], 0);
	TextDrawBackgroundColor(PhoneTD[74], 255);
	Fann_TextDrawFont(PhoneTD[74], 4);
	Fann_TextDrawSetProportional(PhoneTD[74], 1);

	PhoneTD[75] = TextDrawCreate(482.100, 254.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[75], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[75], 1);
	TextDrawColor(PhoneTD[75], -5963521);
	TextDrawSetShadow(PhoneTD[75], 0);
	TextDrawSetOutline(PhoneTD[75], 0);
	TextDrawBackgroundColor(PhoneTD[75], 255);
	Fann_TextDrawFont(PhoneTD[75], 4);
	Fann_TextDrawSetProportional(PhoneTD[75], 1);

	PhoneTD[76] = TextDrawCreate(489.100, 254.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[76], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[76], 1);
	TextDrawColor(PhoneTD[76], -5963521);
	TextDrawSetShadow(PhoneTD[76], 0);
	TextDrawSetOutline(PhoneTD[76], 0);
	TextDrawBackgroundColor(PhoneTD[76], 255);
	Fann_TextDrawFont(PhoneTD[76], 4);
	Fann_TextDrawSetProportional(PhoneTD[76], 1);

	PhoneTD[77] = TextDrawCreate(488.100, 247.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[77], 6.000, 17.000);
	Fann_TextDrawAlignment(PhoneTD[77], 1);
	TextDrawColor(PhoneTD[77], -5963521);
	TextDrawSetShadow(PhoneTD[77], 0);
	TextDrawSetOutline(PhoneTD[77], 0);
	TextDrawBackgroundColor(PhoneTD[77], 255);
	Fann_TextDrawFont(PhoneTD[77], 4);
	Fann_TextDrawSetProportional(PhoneTD[77], 1);

	PhoneTD[78] = TextDrawCreate(483.600, 251.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[78], 14.500, 9.000);
	Fann_TextDrawAlignment(PhoneTD[78], 1);
	TextDrawColor(PhoneTD[78], -5963521);
	TextDrawSetShadow(PhoneTD[78], 0);
	TextDrawSetOutline(PhoneTD[78], 0);
	TextDrawBackgroundColor(PhoneTD[78], 255);
	Fann_TextDrawFont(PhoneTD[78], 4);
	Fann_TextDrawSetProportional(PhoneTD[78], 1);

	PhoneTD[79] = TextDrawCreate(501.100, 245.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[79], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[79], 1);
	TextDrawColor(PhoneTD[79], -1);
	TextDrawSetShadow(PhoneTD[79], 0);
	TextDrawSetOutline(PhoneTD[79], 0);
	TextDrawBackgroundColor(PhoneTD[79], 255);
	Fann_TextDrawFont(PhoneTD[79], 4);
	Fann_TextDrawSetProportional(PhoneTD[79], 1);

	PhoneTD[80] = TextDrawCreate(508.096, 245.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[80], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[80], 1);
	TextDrawColor(PhoneTD[80], -1);
	TextDrawSetShadow(PhoneTD[80], 0);
	TextDrawSetOutline(PhoneTD[80], 0);
	TextDrawBackgroundColor(PhoneTD[80], 255);
	Fann_TextDrawFont(PhoneTD[80], 4);
	Fann_TextDrawSetProportional(PhoneTD[80], 1);

	PhoneTD[81] = TextDrawCreate(501.100, 254.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[81], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[81], 1);
	TextDrawColor(PhoneTD[81], -1);
	TextDrawSetShadow(PhoneTD[81], 0);
	TextDrawSetOutline(PhoneTD[81], 0);
	TextDrawBackgroundColor(PhoneTD[81], 255);
	Fann_TextDrawFont(PhoneTD[81], 4);
	Fann_TextDrawSetProportional(PhoneTD[81], 1);

	PhoneTD[82] = TextDrawCreate(508.096, 254.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[82], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[82], 1);
	TextDrawColor(PhoneTD[82], -1);
	TextDrawSetShadow(PhoneTD[82], 0);
	TextDrawSetOutline(PhoneTD[82], 0);
	TextDrawBackgroundColor(PhoneTD[82], 255);
	Fann_TextDrawFont(PhoneTD[82], 4);
	Fann_TextDrawSetProportional(PhoneTD[82], 1);

	PhoneTD[83] = TextDrawCreate(507.096, 247.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[83], 6.000, 17.000);
	Fann_TextDrawAlignment(PhoneTD[83], 1);
	TextDrawColor(PhoneTD[83], -1);
	TextDrawSetShadow(PhoneTD[83], 0);
	TextDrawSetOutline(PhoneTD[83], 0);
	TextDrawBackgroundColor(PhoneTD[83], 255);
	Fann_TextDrawFont(PhoneTD[83], 4);
	Fann_TextDrawSetProportional(PhoneTD[83], 1);

	PhoneTD[84] = TextDrawCreate(502.600, 251.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[84], 14.500, 9.000);
	Fann_TextDrawAlignment(PhoneTD[84], 1);
	TextDrawColor(PhoneTD[84], -1);
	TextDrawSetShadow(PhoneTD[84], 0);
	TextDrawSetOutline(PhoneTD[84], 0);
	TextDrawBackgroundColor(PhoneTD[84], 255);
	Fann_TextDrawFont(PhoneTD[84], 4);
	Fann_TextDrawSetProportional(PhoneTD[84], 1);

	PhoneTD[85] = TextDrawCreate(482.100, 400.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[85], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[85], 1);
	TextDrawColor(PhoneTD[85], 1138842367);
	TextDrawSetShadow(PhoneTD[85], 0);
	TextDrawSetOutline(PhoneTD[85], 0);
	TextDrawBackgroundColor(PhoneTD[85], 255);
	Fann_TextDrawFont(PhoneTD[85], 4);
	Fann_TextDrawSetProportional(PhoneTD[85], 1);

	PhoneTD[86] = TextDrawCreate(489.100, 400.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[86], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[86], 1);
	TextDrawColor(PhoneTD[86], 1138842367);
	TextDrawSetShadow(PhoneTD[86], 0);
	TextDrawSetOutline(PhoneTD[86], 0);
	TextDrawBackgroundColor(PhoneTD[86], 255);
	Fann_TextDrawFont(PhoneTD[86], 4);
	Fann_TextDrawSetProportional(PhoneTD[86], 1);

	PhoneTD[87] = TextDrawCreate(482.100, 409.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[87], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[87], 1);
	TextDrawColor(PhoneTD[87], 1138842367);
	TextDrawSetShadow(PhoneTD[87], 0);
	TextDrawSetOutline(PhoneTD[87], 0);
	TextDrawBackgroundColor(PhoneTD[87], 255);
	Fann_TextDrawFont(PhoneTD[87], 4);
	Fann_TextDrawSetProportional(PhoneTD[87], 1);

	PhoneTD[88] = TextDrawCreate(489.100, 409.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[88], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[88], 1);
	TextDrawColor(PhoneTD[88], 1138842367);
	TextDrawSetShadow(PhoneTD[88], 0);
	TextDrawSetOutline(PhoneTD[88], 0);
	TextDrawBackgroundColor(PhoneTD[88], 255);
	Fann_TextDrawFont(PhoneTD[88], 4);
	Fann_TextDrawSetProportional(PhoneTD[88], 1);

	PhoneTD[89] = TextDrawCreate(488.100, 402.699, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[89], 6.000, 17.000);
	Fann_TextDrawAlignment(PhoneTD[89], 1);
	TextDrawColor(PhoneTD[89], 1138842367);
	TextDrawSetShadow(PhoneTD[89], 0);
	TextDrawSetOutline(PhoneTD[89], 0);
	TextDrawBackgroundColor(PhoneTD[89], 255);
	Fann_TextDrawFont(PhoneTD[89], 4);
	Fann_TextDrawSetProportional(PhoneTD[89], 1);

	PhoneTD[90] = TextDrawCreate(483.600, 406.699, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[90], 14.500, 9.000);
	Fann_TextDrawAlignment(PhoneTD[90], 1);
	TextDrawColor(PhoneTD[90], 1138842367);
	TextDrawSetShadow(PhoneTD[90], 0);
	TextDrawSetOutline(PhoneTD[90], 0);
	TextDrawBackgroundColor(PhoneTD[90], 255);
	Fann_TextDrawFont(PhoneTD[90], 4);
	Fann_TextDrawSetProportional(PhoneTD[90], 1);

	PhoneTD[91] = TextDrawCreate(501.100, 400.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[91], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[91], 1);
	TextDrawColor(PhoneTD[91], 1138842367);
	TextDrawSetShadow(PhoneTD[91], 0);
	TextDrawSetOutline(PhoneTD[91], 0);
	TextDrawBackgroundColor(PhoneTD[91], 255);
	Fann_TextDrawFont(PhoneTD[91], 4);
	Fann_TextDrawSetProportional(PhoneTD[91], 1);

	PhoneTD[92] = TextDrawCreate(508.096, 400.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[92], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[92], 1);
	TextDrawColor(PhoneTD[92], 1138842367);
	TextDrawSetShadow(PhoneTD[92], 0);
	TextDrawSetOutline(PhoneTD[92], 0);
	TextDrawBackgroundColor(PhoneTD[92], 255);
	Fann_TextDrawFont(PhoneTD[92], 4);
	Fann_TextDrawSetProportional(PhoneTD[92], 1);

	PhoneTD[93] = TextDrawCreate(501.100, 409.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[93], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[93], 1);
	TextDrawColor(PhoneTD[93], 1138842367);
	TextDrawSetShadow(PhoneTD[93], 0);
	TextDrawSetOutline(PhoneTD[93], 0);
	TextDrawBackgroundColor(PhoneTD[93], 255);
	Fann_TextDrawFont(PhoneTD[93], 4);
	Fann_TextDrawSetProportional(PhoneTD[93], 1);

	PhoneTD[94] = TextDrawCreate(508.096, 409.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[94], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[94], 1);
	TextDrawColor(PhoneTD[94], 1138842367);
	TextDrawSetShadow(PhoneTD[94], 0);
	TextDrawSetOutline(PhoneTD[94], 0);
	TextDrawBackgroundColor(PhoneTD[94], 255);
	Fann_TextDrawFont(PhoneTD[94], 4);
	Fann_TextDrawSetProportional(PhoneTD[94], 1);

	PhoneTD[95] = TextDrawCreate(507.096, 402.699, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[95], 6.000, 17.000);
	Fann_TextDrawAlignment(PhoneTD[95], 1);
	TextDrawColor(PhoneTD[95], 1138842367);
	TextDrawSetShadow(PhoneTD[95], 0);
	TextDrawSetOutline(PhoneTD[95], 0);
	TextDrawBackgroundColor(PhoneTD[95], 255);
	Fann_TextDrawFont(PhoneTD[95], 4);
	Fann_TextDrawSetProportional(PhoneTD[95], 1);

	PhoneTD[96] = TextDrawCreate(502.600, 406.699, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[96], 14.500, 9.000);
	Fann_TextDrawAlignment(PhoneTD[96], 1);
	TextDrawColor(PhoneTD[96], 1138842367);
	TextDrawSetShadow(PhoneTD[96], 0);
	TextDrawSetOutline(PhoneTD[96], 0);
	TextDrawBackgroundColor(PhoneTD[96], 255);
	Fann_TextDrawFont(PhoneTD[96], 4);
	Fann_TextDrawSetProportional(PhoneTD[96], 1);

	PhoneTD[97] = TextDrawCreate(520.098, 400.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[97], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[97], 1);
	TextDrawColor(PhoneTD[97], -252116993);
	TextDrawSetShadow(PhoneTD[97], 0);
	TextDrawSetOutline(PhoneTD[97], 0);
	TextDrawBackgroundColor(PhoneTD[97], 255);
	Fann_TextDrawFont(PhoneTD[97], 4);
	Fann_TextDrawSetProportional(PhoneTD[97], 1);

	PhoneTD[98] = TextDrawCreate(527.098, 400.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[98], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[98], 1);
	TextDrawColor(PhoneTD[98], 1768516095);
	TextDrawSetShadow(PhoneTD[98], 0);
	TextDrawSetOutline(PhoneTD[98], 0);
	TextDrawBackgroundColor(PhoneTD[98], 255);
	Fann_TextDrawFont(PhoneTD[98], 4);
	Fann_TextDrawSetProportional(PhoneTD[98], 1);

	PhoneTD[99] = TextDrawCreate(520.098, 409.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[99], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[99], 1);
	TextDrawColor(PhoneTD[99], -252116993);
	TextDrawSetShadow(PhoneTD[99], 0);
	TextDrawSetOutline(PhoneTD[99], 0);
	TextDrawBackgroundColor(PhoneTD[99], 255);
	Fann_TextDrawFont(PhoneTD[99], 4);
	Fann_TextDrawSetProportional(PhoneTD[99], 1);

	PhoneTD[100] = TextDrawCreate(527.098, 409.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[100], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[100], 1);
	TextDrawColor(PhoneTD[100], 16711935);
	TextDrawSetShadow(PhoneTD[100], 0);
	TextDrawSetOutline(PhoneTD[100], 0);
	TextDrawBackgroundColor(PhoneTD[100], 255);
	Fann_TextDrawFont(PhoneTD[100], 4);
	Fann_TextDrawSetProportional(PhoneTD[100], 1);

	PhoneTD[101] = TextDrawCreate(526.098, 402.699, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[101], 6.000, 17.000);
	Fann_TextDrawAlignment(PhoneTD[101], 1);
	TextDrawColor(PhoneTD[101], -252116993);
	TextDrawSetShadow(PhoneTD[101], 0);
	TextDrawSetOutline(PhoneTD[101], 0);
	TextDrawBackgroundColor(PhoneTD[101], 255);
	Fann_TextDrawFont(PhoneTD[101], 4);
	Fann_TextDrawSetProportional(PhoneTD[101], 1);

	PhoneTD[102] = TextDrawCreate(521.598, 406.699, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[102], 14.500, 9.000);
	Fann_TextDrawAlignment(PhoneTD[102], 1);
	TextDrawColor(PhoneTD[102], -252116993);
	TextDrawSetShadow(PhoneTD[102], 0);
	TextDrawSetOutline(PhoneTD[102], 0);
	TextDrawBackgroundColor(PhoneTD[102], 255);
	Fann_TextDrawFont(PhoneTD[102], 4);
	Fann_TextDrawSetProportional(PhoneTD[102], 1);

	PhoneTD[103] = TextDrawCreate(540.197, 400.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[103], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[103], 1);
	TextDrawColor(PhoneTD[103], -252116993);
	TextDrawSetShadow(PhoneTD[103], 0);
	TextDrawSetOutline(PhoneTD[103], 0);
	TextDrawBackgroundColor(PhoneTD[103], 255);
	Fann_TextDrawFont(PhoneTD[103], 4);
	Fann_TextDrawSetProportional(PhoneTD[103], 1);

	PhoneTD[104] = TextDrawCreate(547.197, 400.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[104], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[104], 1);
	TextDrawColor(PhoneTD[104], -252116993);
	TextDrawSetShadow(PhoneTD[104], 0);
	TextDrawSetOutline(PhoneTD[104], 0);
	TextDrawBackgroundColor(PhoneTD[104], 255);
	Fann_TextDrawFont(PhoneTD[104], 4);
	Fann_TextDrawSetProportional(PhoneTD[104], 1);

	PhoneTD[105] = TextDrawCreate(540.197, 409.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[105], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[105], 1);
	TextDrawColor(PhoneTD[105], -252116993);
	TextDrawSetShadow(PhoneTD[105], 0);
	TextDrawSetOutline(PhoneTD[105], 0);
	TextDrawBackgroundColor(PhoneTD[105], 255);
	Fann_TextDrawFont(PhoneTD[105], 4);
	Fann_TextDrawSetProportional(PhoneTD[105], 1);

	PhoneTD[106] = TextDrawCreate(547.197, 409.699, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[106], 11.000, 12.000);
	Fann_TextDrawAlignment(PhoneTD[106], 1);
	TextDrawColor(PhoneTD[106], -252116993);
	TextDrawSetShadow(PhoneTD[106], 0);
	TextDrawSetOutline(PhoneTD[106], 0);
	TextDrawBackgroundColor(PhoneTD[106], 255);
	Fann_TextDrawFont(PhoneTD[106], 4);
	Fann_TextDrawSetProportional(PhoneTD[106], 1);

	PhoneTD[107] = TextDrawCreate(546.197, 402.699, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[107], 6.000, 17.000);
	Fann_TextDrawAlignment(PhoneTD[107], 1);
	TextDrawColor(PhoneTD[107], -252116993);
	TextDrawSetShadow(PhoneTD[107], 0);
	TextDrawSetOutline(PhoneTD[107], 0);
	TextDrawBackgroundColor(PhoneTD[107], 255);
	Fann_TextDrawFont(PhoneTD[107], 4);
	Fann_TextDrawSetProportional(PhoneTD[107], 1);

	PhoneTD[108] = TextDrawCreate(541.697, 406.699, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[108], 14.500, 9.000);
	Fann_TextDrawAlignment(PhoneTD[108], 1);
	TextDrawColor(PhoneTD[108], -252116993);
	TextDrawSetShadow(PhoneTD[108], 0);
	TextDrawSetOutline(PhoneTD[108], 0);
	TextDrawBackgroundColor(PhoneTD[108], 255);
	Fann_TextDrawFont(PhoneTD[108], 4);
	Fann_TextDrawSetProportional(PhoneTD[108], 1);

	PhoneTD[109] = TextDrawCreate(488.000, 223.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[109], 6.000, 6.000);
	Fann_TextDrawAlignment(PhoneTD[109], 1);
	TextDrawColor(PhoneTD[109], -1);
	TextDrawSetShadow(PhoneTD[109], 0);
	TextDrawSetOutline(PhoneTD[109], 0);
	TextDrawBackgroundColor(PhoneTD[109], 255);
	Fann_TextDrawFont(PhoneTD[109], 4);
	Fann_TextDrawSetProportional(PhoneTD[109], 1);

	PhoneTD[110] = TextDrawCreate(487.000, 229.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[110], 8.000, 2.000);
	Fann_TextDrawAlignment(PhoneTD[110], 1);
	TextDrawColor(PhoneTD[110], -1);
	TextDrawSetShadow(PhoneTD[110], 0);
	TextDrawSetOutline(PhoneTD[110], 0);
	TextDrawBackgroundColor(PhoneTD[110], 255);
	Fann_TextDrawFont(PhoneTD[110], 4);
	Fann_TextDrawSetProportional(PhoneTD[110], 1);

	PhoneTD[111] = TextDrawCreate(487.000, 223.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[111], 8.000, 2.000);
	Fann_TextDrawAlignment(PhoneTD[111], 1);
	TextDrawColor(PhoneTD[111], -1);
	TextDrawSetShadow(PhoneTD[111], 0);
	TextDrawSetOutline(PhoneTD[111], 0);
	TextDrawBackgroundColor(PhoneTD[111], 255);
	Fann_TextDrawFont(PhoneTD[111], 4);
	Fann_TextDrawSetProportional(PhoneTD[111], 1);

	PhoneTD[112] = TextDrawCreate(486.000, 220.500, "/");
	TextDrawLetterSize(PhoneTD[112], 0.488, 0.298);
	Fann_TextDrawAlignment(PhoneTD[112], 1);
	TextDrawColor(PhoneTD[112], -1);
	TextDrawSetShadow(PhoneTD[112], 1);
	TextDrawSetOutline(PhoneTD[112], 1);
	TextDrawBackgroundColor(PhoneTD[112], 0);
	Fann_TextDrawFont(PhoneTD[112], 1);
	Fann_TextDrawSetProportional(PhoneTD[112], 1);

	PhoneTD[113] = TextDrawCreate(496.000, 220.500, "/");
	TextDrawLetterSize(PhoneTD[113], -0.479, 0.289);
	Fann_TextDrawAlignment(PhoneTD[113], 1);
	TextDrawColor(PhoneTD[113], -1);
	TextDrawSetShadow(PhoneTD[113], 1);
	TextDrawSetOutline(PhoneTD[113], 1);
	TextDrawBackgroundColor(PhoneTD[113], 0);
	Fann_TextDrawFont(PhoneTD[113], 1);
	Fann_TextDrawSetProportional(PhoneTD[113], 1);

	PhoneTD[114] = TextDrawCreate(496.000, 220.500, "/");
	TextDrawLetterSize(PhoneTD[114], -0.479, 0.289);
	Fann_TextDrawAlignment(PhoneTD[114], 1);
	TextDrawColor(PhoneTD[114], -1);
	TextDrawSetShadow(PhoneTD[114], 1);
	TextDrawSetOutline(PhoneTD[114], 1);
	TextDrawBackgroundColor(PhoneTD[114], 0);
	Fann_TextDrawFont(PhoneTD[114], 1);
	Fann_TextDrawSetProportional(PhoneTD[114], 1);

	PhoneTD[115] = TextDrawCreate(486.000, 220.500, "/");
	TextDrawLetterSize(PhoneTD[115], 0.488, 0.298);
	Fann_TextDrawAlignment(PhoneTD[115], 1);
	TextDrawColor(PhoneTD[115], -1);
	TextDrawSetShadow(PhoneTD[115], 1);
	TextDrawSetOutline(PhoneTD[115], 1);
	TextDrawBackgroundColor(PhoneTD[115], 0);
	Fann_TextDrawFont(PhoneTD[115], 1);
	Fann_TextDrawSetProportional(PhoneTD[115], 1);

	PhoneTD[116] = TextDrawCreate(490.000, 222.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[116], 3.000, 1.000);
	Fann_TextDrawAlignment(PhoneTD[116], 1);
	TextDrawColor(PhoneTD[116], -1);
	TextDrawSetShadow(PhoneTD[116], 0);
	TextDrawSetOutline(PhoneTD[116], 0);
	TextDrawBackgroundColor(PhoneTD[116], 255);
	Fann_TextDrawFont(PhoneTD[116], 4);
	Fann_TextDrawSetProportional(PhoneTD[116], 1);

	PhoneTD[117] = TextDrawCreate(486.000, 224.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[117], 11.000, 0.500);
	Fann_TextDrawAlignment(PhoneTD[117], 1);
	TextDrawColor(PhoneTD[117], -1343295745);
	TextDrawSetShadow(PhoneTD[117], 0);
	TextDrawSetOutline(PhoneTD[117], 0);
	TextDrawBackgroundColor(PhoneTD[117], 255);
	Fann_TextDrawFont(PhoneTD[117], 4);
	Fann_TextDrawSetProportional(PhoneTD[117], 1);

	PhoneTD[118] = TextDrawCreate(489.500, 224.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[118], 1.000, 4.500);
	Fann_TextDrawAlignment(PhoneTD[118], 1);
	TextDrawColor(PhoneTD[118], -1343295745);
	TextDrawSetShadow(PhoneTD[118], 0);
	TextDrawSetOutline(PhoneTD[118], 0);
	TextDrawBackgroundColor(PhoneTD[118], 255);
	Fann_TextDrawFont(PhoneTD[118], 4);
	Fann_TextDrawSetProportional(PhoneTD[118], 1);

	PhoneTD[119] = TextDrawCreate(491.500, 224.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[119], 1.000, 4.500);
	Fann_TextDrawAlignment(PhoneTD[119], 1);
	TextDrawColor(PhoneTD[119], -1343295745);
	TextDrawSetShadow(PhoneTD[119], 0);
	TextDrawSetOutline(PhoneTD[119], 0);
	TextDrawBackgroundColor(PhoneTD[119], 255);
	Fann_TextDrawFont(PhoneTD[119], 4);
	Fann_TextDrawSetProportional(PhoneTD[119], 1);

	PhoneTD[120] = TextDrawCreate(491.200, 235.500, "Bank");
	TextDrawLetterSize(PhoneTD[120], 0.140, 0.699);
	Fann_TextDrawAlignment(PhoneTD[120], 2);
	TextDrawColor(PhoneTD[120], -1);
	TextDrawSetShadow(PhoneTD[120], 1);
	TextDrawSetOutline(PhoneTD[120], 1);
	TextDrawBackgroundColor(PhoneTD[120], 0);
	Fann_TextDrawFont(PhoneTD[120], 1);
	Fann_TextDrawSetProportional(PhoneTD[120], 1);

	PhoneTD[121] = TextDrawCreate(503.500, 218.500, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[121], 13.000, 16.000);
	Fann_TextDrawAlignment(PhoneTD[121], 1);
	TextDrawColor(PhoneTD[121], -1);
	TextDrawSetShadow(PhoneTD[121], 0);
	TextDrawSetOutline(PhoneTD[121], 0);
	TextDrawBackgroundColor(PhoneTD[121], 255);
	Fann_TextDrawFont(PhoneTD[121], 4);
	Fann_TextDrawSetProportional(PhoneTD[121], 1);

	PhoneTD[122] = TextDrawCreate(504.299, 220.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[122], 11.300, 13.199);
	Fann_TextDrawAlignment(PhoneTD[122], 1);
	TextDrawColor(PhoneTD[122], 1687547391);
	TextDrawSetShadow(PhoneTD[122], 0);
	TextDrawSetOutline(PhoneTD[122], 0);
	TextDrawBackgroundColor(PhoneTD[122], 255);
	Fann_TextDrawFont(PhoneTD[122], 4);
	Fann_TextDrawSetProportional(PhoneTD[122], 1);

	PhoneTD[123] = TextDrawCreate(507.500, 222.500, "/");
	TextDrawLetterSize(PhoneTD[123], 0.250, 0.689);
	Fann_TextDrawAlignment(PhoneTD[123], 1);
	TextDrawColor(PhoneTD[123], -1);
	TextDrawSetShadow(PhoneTD[123], 1);
	TextDrawSetOutline(PhoneTD[123], 1);
	TextDrawBackgroundColor(PhoneTD[123], 0);
	Fann_TextDrawFont(PhoneTD[123], 1);
	Fann_TextDrawSetProportional(PhoneTD[123], 1);

	PhoneTD[124] = TextDrawCreate(512.000, 222.500, "/");
	TextDrawLetterSize(PhoneTD[124], -0.250, 0.689);
	Fann_TextDrawAlignment(PhoneTD[124], 1);
	TextDrawColor(PhoneTD[124], -1);
	TextDrawSetShadow(PhoneTD[124], 1);
	TextDrawSetOutline(PhoneTD[124], 1);
	TextDrawBackgroundColor(PhoneTD[124], 0);
	Fann_TextDrawFont(PhoneTD[124], 1);
	Fann_TextDrawSetProportional(PhoneTD[124], 1);

	PhoneTD[125] = TextDrawCreate(507.000, 227.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[125], 6.000, 1.000);
	Fann_TextDrawAlignment(PhoneTD[125], 1);
	TextDrawColor(PhoneTD[125], -1);
	TextDrawSetShadow(PhoneTD[125], 0);
	TextDrawSetOutline(PhoneTD[125], 0);
	TextDrawBackgroundColor(PhoneTD[125], 255);
	Fann_TextDrawFont(PhoneTD[125], 4);
	Fann_TextDrawSetProportional(PhoneTD[125], 1);

	PhoneTD[126] = TextDrawCreate(510.200, 235.500, "Hopedia");
	TextDrawLetterSize(PhoneTD[126], 0.108, 0.699);
	Fann_TextDrawAlignment(PhoneTD[126], 2);
	TextDrawColor(PhoneTD[126], -1);
	TextDrawSetShadow(PhoneTD[126], 1);
	TextDrawSetOutline(PhoneTD[126], 1);
	TextDrawBackgroundColor(PhoneTD[126], 0);
	Fann_TextDrawFont(PhoneTD[126], 1);
	Fann_TextDrawSetProportional(PhoneTD[126], 1);

	PhoneTD[127] = TextDrawCreate(522.000, 216.500, "/");
	TextDrawLetterSize(PhoneTD[127], 0.805, 1.998);
	Fann_TextDrawAlignment(PhoneTD[127], 1);
	TextDrawColor(PhoneTD[127], 255);
	TextDrawSetShadow(PhoneTD[127], 1);
	TextDrawSetOutline(PhoneTD[127], 1);
	TextDrawBackgroundColor(PhoneTD[127], 0);
	Fann_TextDrawFont(PhoneTD[127], 0);
	Fann_TextDrawSetProportional(PhoneTD[127], 1);

	PhoneTD[128] = TextDrawCreate(534.500, 218.500, "/");
	TextDrawLetterSize(PhoneTD[128], -0.768, 1.490);
	Fann_TextDrawAlignment(PhoneTD[128], 1);
	TextDrawColor(PhoneTD[128], 255);
	TextDrawSetShadow(PhoneTD[128], 1);
	TextDrawSetOutline(PhoneTD[128], 1);
	TextDrawBackgroundColor(PhoneTD[128], 0);
	Fann_TextDrawFont(PhoneTD[128], 3);
	Fann_TextDrawSetProportional(PhoneTD[128], 1);

	PhoneTD[129] = TextDrawCreate(533.799, 218.000, "/");
	TextDrawLetterSize(PhoneTD[129], -0.587, 1.690);
	Fann_TextDrawAlignment(PhoneTD[129], 1);
	TextDrawColor(PhoneTD[129], -1);
	TextDrawSetShadow(PhoneTD[129], 1);
	TextDrawSetOutline(PhoneTD[129], 1);
	TextDrawBackgroundColor(PhoneTD[129], 0);
	Fann_TextDrawFont(PhoneTD[129], 0);
	Fann_TextDrawSetProportional(PhoneTD[129], 1);

	PhoneTD[130] = TextDrawCreate(529.200, 235.500, "X");
	TextDrawLetterSize(PhoneTD[130], 0.170, 0.699);
	Fann_TextDrawAlignment(PhoneTD[130], 2);
	TextDrawColor(PhoneTD[130], -1);
	TextDrawSetShadow(PhoneTD[130], 1);
	TextDrawSetOutline(PhoneTD[130], 1);
	TextDrawBackgroundColor(PhoneTD[130], 0);
	Fann_TextDrawFont(PhoneTD[130], 1);
	Fann_TextDrawSetProportional(PhoneTD[130], 1);

	PhoneTD[131] = TextDrawCreate(544.500, 223.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[131], 9.000, 8.000);
	Fann_TextDrawAlignment(PhoneTD[131], 1);
	TextDrawColor(PhoneTD[131], -1448498689);
	TextDrawSetShadow(PhoneTD[131], 0);
	TextDrawSetOutline(PhoneTD[131], 0);
	TextDrawBackgroundColor(PhoneTD[131], 255);
	Fann_TextDrawFont(PhoneTD[131], 4);
	Fann_TextDrawSetProportional(PhoneTD[131], 1);

	PhoneTD[132] = TextDrawCreate(546.500, 222.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[132], 5.000, 8.000);
	Fann_TextDrawAlignment(PhoneTD[132], 1);
	TextDrawColor(PhoneTD[132], -1448498689);
	TextDrawSetShadow(PhoneTD[132], 0);
	TextDrawSetOutline(PhoneTD[132], 0);
	TextDrawBackgroundColor(PhoneTD[132], 255);
	Fann_TextDrawFont(PhoneTD[132], 4);
	Fann_TextDrawSetProportional(PhoneTD[132], 1);

	PhoneTD[133] = TextDrawCreate(546.200, 223.399, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[133], 6.000, 7.500);
	Fann_TextDrawAlignment(PhoneTD[133], 1);
	TextDrawColor(PhoneTD[133], 1887473919);
	TextDrawSetShadow(PhoneTD[133], 0);
	TextDrawSetOutline(PhoneTD[133], 0);
	TextDrawBackgroundColor(PhoneTD[133], 255);
	Fann_TextDrawFont(PhoneTD[133], 4);
	Fann_TextDrawSetProportional(PhoneTD[133], 1);

	PhoneTD[134] = TextDrawCreate(547.200, 224.399, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[134], 4.098, 5.500);
	Fann_TextDrawAlignment(PhoneTD[134], 1);
	TextDrawColor(PhoneTD[134], -1448498689);
	TextDrawSetShadow(PhoneTD[134], 0);
	TextDrawSetOutline(PhoneTD[134], 0);
	TextDrawBackgroundColor(PhoneTD[134], 255);
	Fann_TextDrawFont(PhoneTD[134], 4);
	Fann_TextDrawSetProportional(PhoneTD[134], 1);

	PhoneTD[135] = TextDrawCreate(551.200, 223.800, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[135], 2.000, 2.000);
	Fann_TextDrawAlignment(PhoneTD[135], 1);
	TextDrawColor(PhoneTD[135], 1887473919);
	TextDrawSetShadow(PhoneTD[135], 0);
	TextDrawSetOutline(PhoneTD[135], 0);
	TextDrawBackgroundColor(PhoneTD[135], 255);
	Fann_TextDrawFont(PhoneTD[135], 4);
	Fann_TextDrawSetProportional(PhoneTD[135], 1);

	PhoneTD[136] = TextDrawCreate(549.200, 235.500, "Camera");
	TextDrawLetterSize(PhoneTD[136], 0.140, 0.699);
	Fann_TextDrawAlignment(PhoneTD[136], 2);
	TextDrawColor(PhoneTD[136], -1);
	TextDrawSetShadow(PhoneTD[136], 1);
	TextDrawSetOutline(PhoneTD[136], 1);
	TextDrawBackgroundColor(PhoneTD[136], 0);
	Fann_TextDrawFont(PhoneTD[136], 1);
	Fann_TextDrawSetProportional(PhoneTD[136], 1);

	PhoneTD[137] = TextDrawCreate(487.000, 253.899, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[137], 3.000, 6.000);
	Fann_TextDrawAlignment(PhoneTD[137], 1);
	TextDrawColor(PhoneTD[137], -1);
	TextDrawSetShadow(PhoneTD[137], 0);
	TextDrawSetOutline(PhoneTD[137], 0);
	TextDrawBackgroundColor(PhoneTD[137], 255);
	Fann_TextDrawFont(PhoneTD[137], 4);
	Fann_TextDrawSetProportional(PhoneTD[137], 1);

	PhoneTD[138] = TextDrawCreate(491.500, 253.899, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[138], 3.000, 6.000);
	Fann_TextDrawAlignment(PhoneTD[138], 1);
	TextDrawColor(PhoneTD[138], -1);
	TextDrawSetShadow(PhoneTD[138], 0);
	TextDrawSetOutline(PhoneTD[138], 0);
	TextDrawBackgroundColor(PhoneTD[138], 255);
	Fann_TextDrawFont(PhoneTD[138], 4);
	Fann_TextDrawSetProportional(PhoneTD[138], 1);

	PhoneTD[139] = TextDrawCreate(488.000, 255.100, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[139], 5.000, 3.500);
	Fann_TextDrawAlignment(PhoneTD[139], 1);
	TextDrawColor(PhoneTD[139], -1);
	TextDrawSetShadow(PhoneTD[139], 0);
	TextDrawSetOutline(PhoneTD[139], 0);
	TextDrawBackgroundColor(PhoneTD[139], 255);
	Fann_TextDrawFont(PhoneTD[139], 4);
	Fann_TextDrawSetProportional(PhoneTD[139], 1);

	PhoneTD[140] = TextDrawCreate(487.000, 250.100, "/");
	TextDrawLetterSize(PhoneTD[140], 0.180, 0.597);
	Fann_TextDrawAlignment(PhoneTD[140], 1);
	TextDrawColor(PhoneTD[140], -1);
	TextDrawSetShadow(PhoneTD[140], 1);
	TextDrawSetOutline(PhoneTD[140], 1);
	TextDrawBackgroundColor(PhoneTD[140], 0);
	Fann_TextDrawFont(PhoneTD[140], 1);
	Fann_TextDrawSetProportional(PhoneTD[140], 1);

	PhoneTD[141] = TextDrawCreate(494.500, 250.100, "/");
	TextDrawLetterSize(PhoneTD[141], -0.180, 0.587);
	Fann_TextDrawAlignment(PhoneTD[141], 1);
	TextDrawColor(PhoneTD[141], -1);
	TextDrawSetShadow(PhoneTD[141], 1);
	TextDrawSetOutline(PhoneTD[141], 1);
	TextDrawBackgroundColor(PhoneTD[141], 0);
	Fann_TextDrawFont(PhoneTD[141], 1);
	Fann_TextDrawSetProportional(PhoneTD[141], 1);

	PhoneTD[142] = TextDrawCreate(489.000, 251.100, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[142], 3.000, 0.500);
	Fann_TextDrawAlignment(PhoneTD[142], 1);
	TextDrawColor(PhoneTD[142], -1);
	TextDrawSetShadow(PhoneTD[142], 0);
	TextDrawSetOutline(PhoneTD[142], 0);
	TextDrawBackgroundColor(PhoneTD[142], 255);
	Fann_TextDrawFont(PhoneTD[142], 4);
	Fann_TextDrawSetProportional(PhoneTD[142], 1);

	PhoneTD[143] = TextDrawCreate(488.299, 258.100, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[143], 2.000, 1.500);
	Fann_TextDrawAlignment(PhoneTD[143], 1);
	TextDrawColor(PhoneTD[143], -1);
	TextDrawSetShadow(PhoneTD[143], 0);
	TextDrawSetOutline(PhoneTD[143], 0);
	TextDrawBackgroundColor(PhoneTD[143], 255);
	Fann_TextDrawFont(PhoneTD[143], 4);
	Fann_TextDrawSetProportional(PhoneTD[143], 1);

	PhoneTD[144] = TextDrawCreate(491.299, 258.100, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[144], 2.000, 1.500);
	Fann_TextDrawAlignment(PhoneTD[144], 1);
	TextDrawColor(PhoneTD[144], -1);
	TextDrawSetShadow(PhoneTD[144], 0);
	TextDrawSetOutline(PhoneTD[144], 0);
	TextDrawBackgroundColor(PhoneTD[144], 255);
	Fann_TextDrawFont(PhoneTD[144], 4);
	Fann_TextDrawSetProportional(PhoneTD[144], 1);

	PhoneTD[145] = TextDrawCreate(486.497, 254.100, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[145], 2.000, 1.500);
	Fann_TextDrawAlignment(PhoneTD[145], 1);
	TextDrawColor(PhoneTD[145], -1);
	TextDrawSetShadow(PhoneTD[145], 0);
	TextDrawSetOutline(PhoneTD[145], 0);
	TextDrawBackgroundColor(PhoneTD[145], 255);
	Fann_TextDrawFont(PhoneTD[145], 4);
	Fann_TextDrawSetProportional(PhoneTD[145], 1);

	PhoneTD[146] = TextDrawCreate(493.220, 254.100, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[146], 2.000, 1.500);
	Fann_TextDrawAlignment(PhoneTD[146], 1);
	TextDrawColor(PhoneTD[146], -1);
	TextDrawSetShadow(PhoneTD[146], 0);
	TextDrawSetOutline(PhoneTD[146], 0);
	TextDrawBackgroundColor(PhoneTD[146], 255);
	Fann_TextDrawFont(PhoneTD[146], 4);
	Fann_TextDrawSetProportional(PhoneTD[146], 1);

	PhoneTD[147] = TextDrawCreate(489.220, 253.899, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[147], 3.000, 0.500);
	Fann_TextDrawAlignment(PhoneTD[147], 1);
	TextDrawColor(PhoneTD[147], -1);
	TextDrawSetShadow(PhoneTD[147], 0);
	TextDrawSetOutline(PhoneTD[147], 0);
	TextDrawBackgroundColor(PhoneTD[147], 255);
	Fann_TextDrawFont(PhoneTD[147], 4);
	Fann_TextDrawSetProportional(PhoneTD[147], 1);

	PhoneTD[148] = TextDrawCreate(490.500, 255.899, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[148], 3.000, 1.000);
	Fann_TextDrawAlignment(PhoneTD[148], 1);
	TextDrawColor(PhoneTD[148], -5963521);
	TextDrawSetShadow(PhoneTD[148], 0);
	TextDrawSetOutline(PhoneTD[148], 0);
	TextDrawBackgroundColor(PhoneTD[148], 255);
	Fann_TextDrawFont(PhoneTD[148], 4);
	Fann_TextDrawSetProportional(PhoneTD[148], 1);

	PhoneTD[149] = TextDrawCreate(488.000, 255.899, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[149], 3.000, 1.000);
	Fann_TextDrawAlignment(PhoneTD[149], 1);
	TextDrawColor(PhoneTD[149], -5963521);
	TextDrawSetShadow(PhoneTD[149], 0);
	TextDrawSetOutline(PhoneTD[149], 0);
	TextDrawBackgroundColor(PhoneTD[149], 255);
	Fann_TextDrawFont(PhoneTD[149], 4);
	Fann_TextDrawSetProportional(PhoneTD[149], 1);

	PhoneTD[150] = TextDrawCreate(491.500, 264.500, "Vehicle");
	TextDrawLetterSize(PhoneTD[150], 0.140, 0.699);
	Fann_TextDrawAlignment(PhoneTD[150], 2);
	TextDrawColor(PhoneTD[150], -1);
	TextDrawSetShadow(PhoneTD[150], 1);
	TextDrawSetOutline(PhoneTD[150], 1);
	TextDrawBackgroundColor(PhoneTD[150], 0);
	Fann_TextDrawFont(PhoneTD[150], 1);
	Fann_TextDrawSetProportional(PhoneTD[150], 1);

	PhoneTD[151] = TextDrawCreate(504.500, 247.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[151], 11.000, 14.000);
	Fann_TextDrawAlignment(PhoneTD[151], 1);
	TextDrawColor(PhoneTD[151], -16776961);
	TextDrawSetShadow(PhoneTD[151], 0);
	TextDrawSetOutline(PhoneTD[151], 0);
	TextDrawBackgroundColor(PhoneTD[151], 255);
	Fann_TextDrawFont(PhoneTD[151], 4);
	Fann_TextDrawSetProportional(PhoneTD[151], 1);

	PhoneTD[152] = TextDrawCreate(505.500, 248.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[152], 9.000, 14.000);
	Fann_TextDrawAlignment(PhoneTD[152], 1);
	TextDrawColor(PhoneTD[152], -16776961);
	TextDrawSetShadow(PhoneTD[152], 0);
	TextDrawSetOutline(PhoneTD[152], 0);
	TextDrawBackgroundColor(PhoneTD[152], 255);
	Fann_TextDrawFont(PhoneTD[152], 4);
	Fann_TextDrawSetProportional(PhoneTD[152], 1);

	PhoneTD[153] = TextDrawCreate(506.500, 249.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[153], 7.000, 14.000);
	Fann_TextDrawAlignment(PhoneTD[153], 1);
	TextDrawColor(PhoneTD[153], -16776961);
	TextDrawSetShadow(PhoneTD[153], 0);
	TextDrawSetOutline(PhoneTD[153], 0);
	TextDrawBackgroundColor(PhoneTD[153], 255);
	Fann_TextDrawFont(PhoneTD[153], 4);
	Fann_TextDrawSetProportional(PhoneTD[153], 1);

	PhoneTD[154] = TextDrawCreate(507.500, 251.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[154], 5.000, 13.000);
	Fann_TextDrawAlignment(PhoneTD[154], 1);
	TextDrawColor(PhoneTD[154], -16776961);
	TextDrawSetShadow(PhoneTD[154], 0);
	TextDrawSetOutline(PhoneTD[154], 0);
	TextDrawBackgroundColor(PhoneTD[154], 255);
	Fann_TextDrawFont(PhoneTD[154], 4);
	Fann_TextDrawSetProportional(PhoneTD[154], 1);

	PhoneTD[155] = TextDrawCreate(507.500, 251.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[155], 5.000, 5.000);
	Fann_TextDrawAlignment(PhoneTD[155], 1);
	TextDrawColor(PhoneTD[155], -1);
	TextDrawSetShadow(PhoneTD[155], 0);
	TextDrawSetOutline(PhoneTD[155], 0);
	TextDrawBackgroundColor(PhoneTD[155], 255);
	Fann_TextDrawFont(PhoneTD[155], 4);
	Fann_TextDrawSetProportional(PhoneTD[155], 1);

	PhoneTD[156] = TextDrawCreate(509.500, 264.500, "Maps");
	TextDrawLetterSize(PhoneTD[156], 0.140, 0.699);
	Fann_TextDrawAlignment(PhoneTD[156], 2);
	TextDrawColor(PhoneTD[156], -1);
	TextDrawSetShadow(PhoneTD[156], 1);
	TextDrawSetOutline(PhoneTD[156], 1);
	TextDrawBackgroundColor(PhoneTD[156], 0);
	Fann_TextDrawFont(PhoneTD[156], 1);
	Fann_TextDrawSetProportional(PhoneTD[156], 1);

	PhoneTD[157] = TextDrawCreate(532.000, 403.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[157], 1.000, 17.000);
	Fann_TextDrawAlignment(PhoneTD[157], 1);
	TextDrawColor(PhoneTD[157], -1448498689);
	TextDrawSetShadow(PhoneTD[157], 0);
	TextDrawSetOutline(PhoneTD[157], 0);
	TextDrawBackgroundColor(PhoneTD[157], 255);
	Fann_TextDrawFont(PhoneTD[157], 4);
	Fann_TextDrawSetProportional(PhoneTD[157], 1);

	PhoneTD[158] = TextDrawCreate(532.500, 415.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[158], 3.500, 1.000);
	Fann_TextDrawAlignment(PhoneTD[158], 1);
	TextDrawColor(PhoneTD[158], 16711935);
	TextDrawSetShadow(PhoneTD[158], 0);
	TextDrawSetOutline(PhoneTD[158], 0);
	TextDrawBackgroundColor(PhoneTD[158], 255);
	Fann_TextDrawFont(PhoneTD[158], 4);
	Fann_TextDrawSetProportional(PhoneTD[158], 1);

	PhoneTD[159] = TextDrawCreate(532.500, 411.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[159], 3.500, 4.000);
	Fann_TextDrawAlignment(PhoneTD[159], 1);
	TextDrawColor(PhoneTD[159], -12254977);
	TextDrawSetShadow(PhoneTD[159], 0);
	TextDrawSetOutline(PhoneTD[159], 0);
	TextDrawBackgroundColor(PhoneTD[159], 255);
	Fann_TextDrawFont(PhoneTD[159], 4);
	Fann_TextDrawSetProportional(PhoneTD[159], 1);

	PhoneTD[160] = TextDrawCreate(532.500, 407.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[160], 3.500, 4.000);
	Fann_TextDrawAlignment(PhoneTD[160], 1);
	TextDrawColor(PhoneTD[160], 1088475391);
	TextDrawSetShadow(PhoneTD[160], 0);
	TextDrawSetOutline(PhoneTD[160], 0);
	TextDrawBackgroundColor(PhoneTD[160], 255);
	Fann_TextDrawFont(PhoneTD[160], 4);
	Fann_TextDrawSetProportional(PhoneTD[160], 1);

	PhoneTD[161] = TextDrawCreate(532.500, 407.000, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[161], 3.000, 4.000);
	Fann_TextDrawAlignment(PhoneTD[161], 1);
	TextDrawColor(PhoneTD[161], 1088475391);
	TextDrawSetShadow(PhoneTD[161], 0);
	TextDrawSetOutline(PhoneTD[161], 0);
	TextDrawBackgroundColor(PhoneTD[161], 255);
	Fann_TextDrawFont(PhoneTD[161], 4);
	Fann_TextDrawSetProportional(PhoneTD[161], 1);

	PhoneTD[162] = TextDrawCreate(522.000, 404.500, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[162], 10.000, 13.000);
	Fann_TextDrawAlignment(PhoneTD[162], 1);
	TextDrawColor(PhoneTD[162], -2139062017);
	TextDrawSetShadow(PhoneTD[162], 0);
	TextDrawSetOutline(PhoneTD[162], 0);
	TextDrawBackgroundColor(PhoneTD[162], 255);
	Fann_TextDrawFont(PhoneTD[162], 4);
	Fann_TextDrawSetProportional(PhoneTD[162], 1);

	PhoneTD[163] = TextDrawCreate(523.000, 405.500, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[163], 8.000, 11.000);
	Fann_TextDrawAlignment(PhoneTD[163], 1);
	TextDrawColor(PhoneTD[163], -252116993);
	TextDrawSetShadow(PhoneTD[163], 0);
	TextDrawSetOutline(PhoneTD[163], 0);
	TextDrawBackgroundColor(PhoneTD[163], 255);
	Fann_TextDrawFont(PhoneTD[163], 4);
	Fann_TextDrawSetProportional(PhoneTD[163], 1);

	PhoneTD[164] = TextDrawCreate(523.000, 410.500, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[164], 8.000, 5.000);
	Fann_TextDrawAlignment(PhoneTD[164], 1);
	TextDrawColor(PhoneTD[164], -2139062017);
	TextDrawSetShadow(PhoneTD[164], 0);
	TextDrawSetOutline(PhoneTD[164], 0);
	TextDrawBackgroundColor(PhoneTD[164], 255);
	Fann_TextDrawFont(PhoneTD[164], 4);
	Fann_TextDrawSetProportional(PhoneTD[164], 1);

	PhoneTD[165] = TextDrawCreate(525.000, 407.500, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[165], 4.000, 4.000);
	Fann_TextDrawAlignment(PhoneTD[165], 1);
	TextDrawColor(PhoneTD[165], -2139062017);
	TextDrawSetShadow(PhoneTD[165], 0);
	TextDrawSetOutline(PhoneTD[165], 0);
	TextDrawBackgroundColor(PhoneTD[165], 255);
	Fann_TextDrawFont(PhoneTD[165], 4);
	Fann_TextDrawSetProportional(PhoneTD[165], 1);

	PhoneTD[166] = TextDrawCreate(540.598, 401.299, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[166], 17.000, 20.000);
	Fann_TextDrawAlignment(PhoneTD[166], 1);
	TextDrawColor(PhoneTD[166], 1768516095);
	TextDrawSetShadow(PhoneTD[166], 0);
	TextDrawSetOutline(PhoneTD[166], 0);
	TextDrawBackgroundColor(PhoneTD[166], 255);
	Fann_TextDrawFont(PhoneTD[166], 4);
	Fann_TextDrawSetProportional(PhoneTD[166], 1);

	PhoneTD[167] = TextDrawCreate(541.598, 402.299, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[167], 15.000, 18.000);
	Fann_TextDrawAlignment(PhoneTD[167], 1);
	TextDrawColor(PhoneTD[167], -252116993);
	TextDrawSetShadow(PhoneTD[167], 0);
	TextDrawSetOutline(PhoneTD[167], 0);
	TextDrawBackgroundColor(PhoneTD[167], 255);
	Fann_TextDrawFont(PhoneTD[167], 4);
	Fann_TextDrawSetProportional(PhoneTD[167], 1);

	PhoneTD[168] = TextDrawCreate(543.598, 404.398, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[168], 11.000, 13.500);
	Fann_TextDrawAlignment(PhoneTD[168], 1);
	TextDrawColor(PhoneTD[168], 1768516095);
	TextDrawSetShadow(PhoneTD[168], 0);
	TextDrawSetOutline(PhoneTD[168], 0);
	TextDrawBackgroundColor(PhoneTD[168], 255);
	Fann_TextDrawFont(PhoneTD[168], 4);
	Fann_TextDrawSetProportional(PhoneTD[168], 1);

	PhoneTD[169] = TextDrawCreate(545.000, 406.398, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[169], 8.000, 9.500);
	Fann_TextDrawAlignment(PhoneTD[169], 1);
	TextDrawColor(PhoneTD[169], -252116993);
	TextDrawSetShadow(PhoneTD[169], 0);
	TextDrawSetOutline(PhoneTD[169], 0);
	TextDrawBackgroundColor(PhoneTD[169], 255);
	Fann_TextDrawFont(PhoneTD[169], 4);
	Fann_TextDrawSetProportional(PhoneTD[169], 1);

	PhoneTD[170] = TextDrawCreate(546.000, 407.398, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[170], 6.000, 7.500);
	Fann_TextDrawAlignment(PhoneTD[170], 1);
	TextDrawColor(PhoneTD[170], 1768516095);
	TextDrawSetShadow(PhoneTD[170], 0);
	TextDrawSetOutline(PhoneTD[170], 0);
	TextDrawBackgroundColor(PhoneTD[170], 255);
	Fann_TextDrawFont(PhoneTD[170], 4);
	Fann_TextDrawSetProportional(PhoneTD[170], 1);

	PhoneTD[171] = TextDrawCreate(546.000, 409.000, "/");
	TextDrawLetterSize(PhoneTD[171], 0.310, 0.699);
	Fann_TextDrawAlignment(PhoneTD[171], 1);
	TextDrawColor(PhoneTD[171], -1);
	TextDrawSetShadow(PhoneTD[171], 1);
	TextDrawSetOutline(PhoneTD[171], 1);
	TextDrawBackgroundColor(PhoneTD[171], 0);
	Fann_TextDrawFont(PhoneTD[171], 1);
	Fann_TextDrawSetProportional(PhoneTD[171], 1);

	PhoneTD[172] = TextDrawCreate(546.000, 409.000, "/");
	TextDrawLetterSize(PhoneTD[172], 0.310, 0.699);
	Fann_TextDrawAlignment(PhoneTD[172], 1);
	TextDrawColor(PhoneTD[172], -1);
	TextDrawSetShadow(PhoneTD[172], 1);
	TextDrawSetOutline(PhoneTD[172], 1);
	TextDrawBackgroundColor(PhoneTD[172], 0);
	Fann_TextDrawFont(PhoneTD[172], 1);
	Fann_TextDrawSetProportional(PhoneTD[172], 1);

	PhoneTD[173] = TextDrawCreate(546.000, 413.000, "/");
	TextDrawLetterSize(PhoneTD[173], 0.319, -0.587);
	Fann_TextDrawAlignment(PhoneTD[173], 1);
	TextDrawColor(PhoneTD[173], -1);
	TextDrawSetShadow(PhoneTD[173], 1);
	TextDrawSetOutline(PhoneTD[173], 1);
	TextDrawBackgroundColor(PhoneTD[173], 0);
	Fann_TextDrawFont(PhoneTD[173], 1);
	Fann_TextDrawSetProportional(PhoneTD[173], 1);

	PhoneTD[174] = TextDrawCreate(485.699, 404.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[174], 13.000, 14.000);
	Fann_TextDrawAlignment(PhoneTD[174], 1);
	TextDrawColor(PhoneTD[174], -1);
	TextDrawSetShadow(PhoneTD[174], 0);
	TextDrawSetOutline(PhoneTD[174], 0);
	TextDrawBackgroundColor(PhoneTD[174], 255);
	Fann_TextDrawFont(PhoneTD[174], 4);
	Fann_TextDrawSetProportional(PhoneTD[174], 1);

	PhoneTD[175] = TextDrawCreate(546.000, 413.000, "/");
	TextDrawLetterSize(PhoneTD[175], 0.319, -0.587);
	Fann_TextDrawAlignment(PhoneTD[175], 1);
	TextDrawColor(PhoneTD[175], -1);
	TextDrawSetShadow(PhoneTD[175], 1);
	TextDrawSetOutline(PhoneTD[175], 1);
	TextDrawBackgroundColor(PhoneTD[175], 0);
	Fann_TextDrawFont(PhoneTD[175], 1);
	Fann_TextDrawSetProportional(PhoneTD[175], 1);

	PhoneTD[176] = TextDrawCreate(549.000, 410.500, "LD_BUM:blkdot");
	TextDrawTextSize(PhoneTD[176], 5.000, 1.000);
	Fann_TextDrawAlignment(PhoneTD[176], 1);
	TextDrawColor(PhoneTD[176], -252116993);
	TextDrawSetShadow(PhoneTD[176], 0);
	TextDrawSetOutline(PhoneTD[176], 0);
	TextDrawBackgroundColor(PhoneTD[176], 255);
	Fann_TextDrawFont(PhoneTD[176], 4);
	Fann_TextDrawSetProportional(PhoneTD[176], 1);

	PhoneTD[177] = TextDrawCreate(492.000, 408.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[177], 7.000, 7.000);
	Fann_TextDrawAlignment(PhoneTD[177], 1);
	TextDrawColor(PhoneTD[177], 1138842367);
	TextDrawSetShadow(PhoneTD[177], 0);
	TextDrawSetOutline(PhoneTD[177], 0);
	TextDrawBackgroundColor(PhoneTD[177], 255);
	Fann_TextDrawFont(PhoneTD[177], 4);
	Fann_TextDrawSetProportional(PhoneTD[177], 1);

	PhoneTD[178] = TextDrawCreate(503.699, 404.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[178], 13.000, 13.000);
	Fann_TextDrawAlignment(PhoneTD[178], 1);
	TextDrawColor(PhoneTD[178], -1);
	TextDrawSetShadow(PhoneTD[178], 0);
	TextDrawSetOutline(PhoneTD[178], 0);
	TextDrawBackgroundColor(PhoneTD[178], 255);
	Fann_TextDrawFont(PhoneTD[178], 4);
	Fann_TextDrawSetProportional(PhoneTD[178], 1);

	PhoneTD[179] = TextDrawCreate(505.699, 412.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[179], 3.000, 4.000);
	Fann_TextDrawAlignment(PhoneTD[179], 1);
	TextDrawColor(PhoneTD[179], -1);
	TextDrawSetShadow(PhoneTD[179], 0);
	TextDrawSetOutline(PhoneTD[179], 0);
	TextDrawBackgroundColor(PhoneTD[179], 255);
	Fann_TextDrawFont(PhoneTD[179], 4);
	Fann_TextDrawSetProportional(PhoneTD[179], 1);

	PhoneTD[180] = TextDrawCreate(487.000, 403.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[180], 13.000, 13.000);
	Fann_TextDrawAlignment(PhoneTD[180], 1);
	TextDrawColor(PhoneTD[180], 1138842367);
	TextDrawSetShadow(PhoneTD[180], 0);
	TextDrawSetOutline(PhoneTD[180], 0);
	TextDrawBackgroundColor(PhoneTD[180], 255);
	Fann_TextDrawFont(PhoneTD[180], 4);
	Fann_TextDrawSetProportional(PhoneTD[180], 1);

	PhoneTD[181] = TextDrawCreate(486.699, 406.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[181], 5.000, 6.000);
	Fann_TextDrawAlignment(PhoneTD[181], 1);
	TextDrawColor(PhoneTD[181], -1);
	TextDrawSetShadow(PhoneTD[181], 0);
	TextDrawSetOutline(PhoneTD[181], 0);
	TextDrawBackgroundColor(PhoneTD[181], 255);
	Fann_TextDrawFont(PhoneTD[181], 4);
	Fann_TextDrawSetProportional(PhoneTD[181], 1);

	PhoneTD[182] = TextDrawCreate(491.699, 411.000, "LD_BEAT:chit");
	TextDrawTextSize(PhoneTD[182], 5.000, 6.000);
	Fann_TextDrawAlignment(PhoneTD[182], 1);
	TextDrawColor(PhoneTD[182], -1);
	TextDrawSetShadow(PhoneTD[182], 0);
	TextDrawSetOutline(PhoneTD[182], 0);
	TextDrawBackgroundColor(PhoneTD[182], 255);
	Fann_TextDrawFont(PhoneTD[182], 4);
	Fann_TextDrawSetProportional(PhoneTD[182], 1);

	AppTambahan[0] = TextDrawCreate(520.098, 245.000, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[0], 11.000, 12.000);
    Fann_TextDrawAlignment(AppTambahan[0], 1);
    TextDrawColor(AppTambahan[0], 420746495);
    TextDrawSetShadow(AppTambahan[0], 0);
    TextDrawSetOutline(AppTambahan[0], 0);
    TextDrawBackgroundColor(AppTambahan[0], 255);
    Fann_TextDrawFont(AppTambahan[0], 4);
    Fann_TextDrawSetProportional(AppTambahan[0], 1);

    AppTambahan[1] = TextDrawCreate(527.098, 245.000, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[1], 11.000, 12.000);
    Fann_TextDrawAlignment(AppTambahan[1], 1);
    TextDrawColor(AppTambahan[1], 420746495);
    TextDrawSetShadow(AppTambahan[1], 0);
    TextDrawSetOutline(AppTambahan[1], 0);
    TextDrawBackgroundColor(AppTambahan[1], 255);
    Fann_TextDrawFont(AppTambahan[1], 4);
    Fann_TextDrawSetProportional(AppTambahan[1], 1);

    AppTambahan[2] = TextDrawCreate(520.098, 254.000, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[2], 11.000, 12.000);
    Fann_TextDrawAlignment(AppTambahan[2], 1);
    TextDrawColor(AppTambahan[2], 420746495);
    TextDrawSetShadow(AppTambahan[2], 0);
    TextDrawSetOutline(AppTambahan[2], 0);
    TextDrawBackgroundColor(AppTambahan[2], 255);
    Fann_TextDrawFont(AppTambahan[2], 4);
    Fann_TextDrawSetProportional(AppTambahan[2], 1);

    AppTambahan[3] = TextDrawCreate(527.098, 254.000, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[3], 11.000, 12.000);
    Fann_TextDrawAlignment(AppTambahan[3], 1);
    TextDrawColor(AppTambahan[3], 420746495);
    TextDrawSetShadow(AppTambahan[3], 0);
    TextDrawSetOutline(AppTambahan[3], 0);
    TextDrawBackgroundColor(AppTambahan[3], 255);
    Fann_TextDrawFont(AppTambahan[3], 4);
    Fann_TextDrawSetProportional(AppTambahan[3], 1);

    AppTambahan[4] = TextDrawCreate(526.098, 247.000, "LD_BUM:blkdot");
    TextDrawTextSize(AppTambahan[4], 6.000, 17.000);
    Fann_TextDrawAlignment(AppTambahan[4], 1);
    TextDrawColor(AppTambahan[4], 420746495);
    TextDrawSetShadow(AppTambahan[4], 0);
    TextDrawSetOutline(AppTambahan[4], 0);
    TextDrawBackgroundColor(AppTambahan[4], 255);
    Fann_TextDrawFont(AppTambahan[4], 4);
    Fann_TextDrawSetProportional(AppTambahan[4], 1);

    AppTambahan[5] = TextDrawCreate(521.598, 251.000, "LD_BUM:blkdot");
    TextDrawTextSize(AppTambahan[5], 14.500, 9.000);
    Fann_TextDrawAlignment(AppTambahan[5], 1);
    TextDrawColor(AppTambahan[5], 420746495);
    TextDrawSetShadow(AppTambahan[5], 0);
    TextDrawSetOutline(AppTambahan[5], 0);
    TextDrawBackgroundColor(AppTambahan[5], 255);
    Fann_TextDrawFont(AppTambahan[5], 4);
    Fann_TextDrawSetProportional(AppTambahan[5], 1);

    AppTambahan[6] = TextDrawCreate(540.197, 245.000, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[6], 11.000, 12.000);
    Fann_TextDrawAlignment(AppTambahan[6], 1);
    TextDrawColor(AppTambahan[6], -1);
    TextDrawSetShadow(AppTambahan[6], 0);
    TextDrawSetOutline(AppTambahan[6], 0);
    TextDrawBackgroundColor(AppTambahan[6], 255);
    Fann_TextDrawFont(AppTambahan[6], 4);
    Fann_TextDrawSetProportional(AppTambahan[6], 1);

    AppTambahan[7] = TextDrawCreate(547.197, 245.000, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[7], 11.000, 12.000);
    Fann_TextDrawAlignment(AppTambahan[7], 1);
    TextDrawColor(AppTambahan[7], -1);
    TextDrawSetShadow(AppTambahan[7], 0);
    TextDrawSetOutline(AppTambahan[7], 0);
    TextDrawBackgroundColor(AppTambahan[7], 255);
    Fann_TextDrawFont(AppTambahan[7], 4);
    Fann_TextDrawSetProportional(AppTambahan[7], 1);

    AppTambahan[8] = TextDrawCreate(540.197, 254.000, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[8], 11.000, 12.000);
    Fann_TextDrawAlignment(AppTambahan[8], 1);
    TextDrawColor(AppTambahan[8], -1);
    TextDrawSetShadow(AppTambahan[8], 0);
    TextDrawSetOutline(AppTambahan[8], 0);
    TextDrawBackgroundColor(AppTambahan[8], 255);
    Fann_TextDrawFont(AppTambahan[8], 4);
    Fann_TextDrawSetProportional(AppTambahan[8], 1);

    AppTambahan[9] = TextDrawCreate(547.197, 254.000, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[9], 11.000, 12.000);
    Fann_TextDrawAlignment(AppTambahan[9], 1);
    TextDrawColor(AppTambahan[9], -1);
    TextDrawSetShadow(AppTambahan[9], 0);
    TextDrawSetOutline(AppTambahan[9], 0);
    TextDrawBackgroundColor(AppTambahan[9], 255);
    Fann_TextDrawFont(AppTambahan[9], 4);
    Fann_TextDrawSetProportional(AppTambahan[9], 1);

    AppTambahan[10] = TextDrawCreate(546.197, 247.000, "LD_BUM:blkdot");
    TextDrawTextSize(AppTambahan[10], 6.000, 17.000);
    Fann_TextDrawAlignment(AppTambahan[10], 1);
    TextDrawColor(AppTambahan[10], -1);
    TextDrawSetShadow(AppTambahan[10], 0);
    TextDrawSetOutline(AppTambahan[10], 0);
    TextDrawBackgroundColor(AppTambahan[10], 255);
    Fann_TextDrawFont(AppTambahan[10], 4);
    Fann_TextDrawSetProportional(AppTambahan[10], 1);

    AppTambahan[11] = TextDrawCreate(541.697, 251.000, "LD_BUM:blkdot");
    TextDrawTextSize(AppTambahan[11], 14.500, 9.000);
    Fann_TextDrawAlignment(AppTambahan[11], 1);
    TextDrawColor(AppTambahan[11], -1);
    TextDrawSetShadow(AppTambahan[11], 0);
    TextDrawSetOutline(AppTambahan[11], 0);
    TextDrawBackgroundColor(AppTambahan[11], 255);
    Fann_TextDrawFont(AppTambahan[11], 4);
    Fann_TextDrawSetProportional(AppTambahan[11], 1);

    AppTambahan[12] = TextDrawCreate(482.197, 274.200, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[12], 11.000, 12.000);
    Fann_TextDrawAlignment(AppTambahan[12], 1);
    TextDrawColor(AppTambahan[12], -1717986817);
    TextDrawSetShadow(AppTambahan[12], 0);
    TextDrawSetOutline(AppTambahan[12], 0);
    TextDrawBackgroundColor(AppTambahan[12], 255);
    Fann_TextDrawFont(AppTambahan[12], 4);
    Fann_TextDrawSetProportional(AppTambahan[12], 1);

    AppTambahan[13] = TextDrawCreate(489.197, 274.200, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[13], 11.000, 12.000);
    Fann_TextDrawAlignment(AppTambahan[13], 1);
    TextDrawColor(AppTambahan[13], -1717986817);
    TextDrawSetShadow(AppTambahan[13], 0);
    TextDrawSetOutline(AppTambahan[13], 0);
    TextDrawBackgroundColor(AppTambahan[13], 255);
    Fann_TextDrawFont(AppTambahan[13], 4);
    Fann_TextDrawSetProportional(AppTambahan[13], 1);

    AppTambahan[14] = TextDrawCreate(482.197, 283.200, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[14], 11.000, 12.000);
    Fann_TextDrawAlignment(AppTambahan[14], 1);
    TextDrawColor(AppTambahan[14], -1717986817);
    TextDrawSetShadow(AppTambahan[14], 0);
    TextDrawSetOutline(AppTambahan[14], 0);
    TextDrawBackgroundColor(AppTambahan[14], 255);
    Fann_TextDrawFont(AppTambahan[14], 4);
    Fann_TextDrawSetProportional(AppTambahan[14], 1);

    AppTambahan[15] = TextDrawCreate(489.197, 283.200, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[15], 11.000, 12.000);
    Fann_TextDrawAlignment(AppTambahan[15], 1);
    TextDrawColor(AppTambahan[15], -1717986817);
    TextDrawSetShadow(AppTambahan[15], 0);
    TextDrawSetOutline(AppTambahan[15], 0);
    TextDrawBackgroundColor(AppTambahan[15], 255);
    Fann_TextDrawFont(AppTambahan[15], 4);
    Fann_TextDrawSetProportional(AppTambahan[15], 1);

    AppTambahan[16] = TextDrawCreate(488.197, 276.200, "LD_BUM:blkdot");
    TextDrawTextSize(AppTambahan[16], 6.000, 17.000);
    Fann_TextDrawAlignment(AppTambahan[16], 1);
    TextDrawColor(AppTambahan[16], -1717986817);
    TextDrawSetShadow(AppTambahan[16], 0);
    TextDrawSetOutline(AppTambahan[16], 0);
    TextDrawBackgroundColor(AppTambahan[16], 255);
    Fann_TextDrawFont(AppTambahan[16], 4);
    Fann_TextDrawSetProportional(AppTambahan[16], 1);

    AppTambahan[17] = TextDrawCreate(483.697, 280.200, "LD_BUM:blkdot");
    TextDrawTextSize(AppTambahan[17], 14.500, 9.000);
    Fann_TextDrawAlignment(AppTambahan[17], 1);
    TextDrawColor(AppTambahan[17], -1717986817);
    TextDrawSetShadow(AppTambahan[17], 0);
    TextDrawSetOutline(AppTambahan[17], 0);
    TextDrawBackgroundColor(AppTambahan[17], 255);
    Fann_TextDrawFont(AppTambahan[17], 4);
    Fann_TextDrawSetProportional(AppTambahan[17], 1);

    AppTambahan[18] = TextDrawCreate(522.700, 247.350, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[18], 13.000, 16.000);
    Fann_TextDrawAlignment(AppTambahan[18], 1);
    TextDrawColor(AppTambahan[18], 517431551);
    TextDrawSetShadow(AppTambahan[18], 0);
    TextDrawSetOutline(AppTambahan[18], 0);
    TextDrawBackgroundColor(AppTambahan[18], 255);
    Fann_TextDrawFont(AppTambahan[18], 4);
    Fann_TextDrawSetProportional(AppTambahan[18], 1);

    AppTambahan[19] = TextDrawCreate(524.700, 251.149, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[19], 9.000, 6.000);
    Fann_TextDrawAlignment(AppTambahan[19], 1);
    TextDrawColor(AppTambahan[19], 420746495);
    TextDrawSetShadow(AppTambahan[19], 0);
    TextDrawSetOutline(AppTambahan[19], 0);
    TextDrawBackgroundColor(AppTambahan[19], 255);
    Fann_TextDrawFont(AppTambahan[19], 4);
    Fann_TextDrawSetProportional(AppTambahan[19], 1);

    AppTambahan[20] = TextDrawCreate(524.700, 252.499, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[20], 9.000, 6.000);
    Fann_TextDrawAlignment(AppTambahan[20], 1);
    TextDrawColor(AppTambahan[20], 517431551);
    TextDrawSetShadow(AppTambahan[20], 0);
    TextDrawSetOutline(AppTambahan[20], 0);
    TextDrawBackgroundColor(AppTambahan[20], 255);
    Fann_TextDrawFont(AppTambahan[20], 4);
    Fann_TextDrawSetProportional(AppTambahan[20], 1);

    AppTambahan[21] = TextDrawCreate(525.100, 253.649, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[21], 8.000, 4.000);
    Fann_TextDrawAlignment(AppTambahan[21], 1);
    TextDrawColor(AppTambahan[21], 420746495);
    TextDrawSetShadow(AppTambahan[21], 0);
    TextDrawSetOutline(AppTambahan[21], 0);
    TextDrawBackgroundColor(AppTambahan[21], 255);
    Fann_TextDrawFont(AppTambahan[21], 4);
    Fann_TextDrawSetProportional(AppTambahan[21], 1);

    AppTambahan[22] = TextDrawCreate(525.100, 254.999, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[22], 8.000, 4.000);
    Fann_TextDrawAlignment(AppTambahan[22], 1);
    TextDrawColor(AppTambahan[22], 517431551);
    TextDrawSetShadow(AppTambahan[22], 0);
    TextDrawSetOutline(AppTambahan[22], 0);
    TextDrawBackgroundColor(AppTambahan[22], 255);
    Fann_TextDrawFont(AppTambahan[22], 4);
    Fann_TextDrawSetProportional(AppTambahan[22], 1);

    AppTambahan[23] = TextDrawCreate(525.600, 255.649, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[23], 7.000, 4.000);
    Fann_TextDrawAlignment(AppTambahan[23], 1);
    TextDrawColor(AppTambahan[23], 420746495);
    TextDrawSetShadow(AppTambahan[23], 0);
    TextDrawSetOutline(AppTambahan[23], 0);
    TextDrawBackgroundColor(AppTambahan[23], 255);
    Fann_TextDrawFont(AppTambahan[23], 4);
    Fann_TextDrawSetProportional(AppTambahan[23], 1);

    AppTambahan[24] = TextDrawCreate(525.600, 257.000, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[24], 7.000, 4.000);
    Fann_TextDrawAlignment(AppTambahan[24], 1);
    TextDrawColor(AppTambahan[24], 517431551);
    TextDrawSetShadow(AppTambahan[24], 0);
    TextDrawSetOutline(AppTambahan[24], 0);
    TextDrawBackgroundColor(AppTambahan[24], 255);
    Fann_TextDrawFont(AppTambahan[24], 4);
    Fann_TextDrawSetProportional(AppTambahan[24], 1);

    AppTambahan[25] = TextDrawCreate(540.750, 245.000, "LD_BEAT:chit");
    TextDrawTextSize(AppTambahan[25], 17.000, 21.000);
    Fann_TextDrawAlignment(AppTambahan[25], 1);
    TextDrawColor(AppTambahan[25], -582797313);
    TextDrawSetShadow(AppTambahan[25], 0);
    TextDrawSetOutline(AppTambahan[25], 0);
    TextDrawBackgroundColor(AppTambahan[25], 255);
    Fann_TextDrawFont(AppTambahan[25], 4);
    Fann_TextDrawSetProportional(AppTambahan[25], 1);

	PowerButton = TextDrawCreate(571.000, 251.000, "LD_BUM:blkdot");
	TextDrawTextSize(PowerButton, 27.000, 28.000);
	Fann_TextDrawAlignment(PowerButton, 1);
	TextDrawColor(PowerButton, 0);
	TextDrawSetShadow(PowerButton, 0);
	TextDrawSetOutline(PowerButton, 0);
	TextDrawBackgroundColor(PowerButton, 255);
	Fann_TextDrawFont(PowerButton, 4);
	Fann_TextDrawSetProportional(PowerButton, 1);
	Fann_TextDrawSetSelectable(PowerButton, 1);

	BankButton = TextDrawCreate(484.000, 218.000, "LD_BUM:blkdot");
	TextDrawTextSize(BankButton, 14.000, 16.000);
	Fann_TextDrawAlignment(BankButton, 1);
	TextDrawColor(BankButton, 0);
	TextDrawSetShadow(BankButton, 0);
	TextDrawSetOutline(BankButton, 0);
	TextDrawBackgroundColor(BankButton, 255);
	Fann_TextDrawFont(BankButton, 4);
	Fann_TextDrawSetProportional(BankButton, 1);
	Fann_TextDrawSetSelectable(BankButton, 1);

	HopeButton = TextDrawCreate(503.000, 218.000, "LD_BUM:blkdot");
	TextDrawTextSize(HopeButton, 14.000, 16.000);
	Fann_TextDrawAlignment(HopeButton, 1);
	TextDrawColor(HopeButton, 0);
	TextDrawSetShadow(HopeButton, 0);
	TextDrawSetOutline(HopeButton, 0);
	TextDrawBackgroundColor(HopeButton, 255);
	Fann_TextDrawFont(HopeButton, 4);
	Fann_TextDrawSetProportional(HopeButton, 1);
	Fann_TextDrawSetSelectable(HopeButton, 1);

	XButton = TextDrawCreate(522.000, 218.000, "LD_BUM:blkdot");
	TextDrawTextSize(XButton, 14.000, 16.000);
	Fann_TextDrawAlignment(XButton, 1);
	TextDrawColor(XButton, 0);
	TextDrawSetShadow(XButton, 0);
	TextDrawSetOutline(XButton, 0);
	TextDrawBackgroundColor(XButton, 255);
	Fann_TextDrawFont(XButton, 4);
	Fann_TextDrawSetProportional(XButton, 1);
	Fann_TextDrawSetSelectable(XButton, 1);

	CameraButton = TextDrawCreate(542.000, 218.000, "LD_BUM:blkdot");
	TextDrawTextSize(CameraButton, 14.000, 16.000);
	Fann_TextDrawAlignment(CameraButton, 1);
	TextDrawColor(CameraButton, 0);
	TextDrawSetShadow(CameraButton, 0);
	TextDrawSetOutline(CameraButton, 0);
	TextDrawBackgroundColor(CameraButton, 255);
	Fann_TextDrawFont(CameraButton, 4);
	Fann_TextDrawSetProportional(CameraButton, 1);
	Fann_TextDrawSetSelectable(CameraButton, 1);

	CallButton = TextDrawCreate(484.000, 403.000, "LD_BUM:blkdot");
	TextDrawTextSize(CallButton, 14.000, 16.000);
	Fann_TextDrawAlignment(CallButton, 1);
	TextDrawColor(CallButton, 0);
	TextDrawSetShadow(CallButton, 0);
	TextDrawSetOutline(CallButton, 0);
	TextDrawBackgroundColor(CallButton, 255);
	Fann_TextDrawFont(CallButton, 4);
	Fann_TextDrawSetProportional(CallButton, 1);
	Fann_TextDrawSetSelectable(CallButton, 1);

	MessageButton = TextDrawCreate(503.000, 403.000, "LD_BUM:blkdot");
	TextDrawTextSize(MessageButton, 14.000, 16.000);
	Fann_TextDrawAlignment(MessageButton, 1);
	TextDrawColor(MessageButton, 0);
	TextDrawSetShadow(MessageButton, 0);
	TextDrawSetOutline(MessageButton, 0);
	TextDrawBackgroundColor(MessageButton, 255);
	Fann_TextDrawFont(MessageButton, 4);
	Fann_TextDrawSetProportional(MessageButton, 1);
	Fann_TextDrawSetSelectable(MessageButton, 1);

	ContactButton = TextDrawCreate(522.000, 403.000, "LD_BUM:blkdot");
	TextDrawTextSize(ContactButton, 14.000, 16.000);
	Fann_TextDrawAlignment(ContactButton, 1);
	TextDrawColor(ContactButton, 0);
	TextDrawSetShadow(ContactButton, 0);
	TextDrawSetOutline(ContactButton, 0);
	TextDrawBackgroundColor(ContactButton, 255);
	Fann_TextDrawFont(ContactButton, 4);
	Fann_TextDrawSetProportional(ContactButton, 1);
	Fann_TextDrawSetSelectable(ContactButton, 1);

	SettingButton = TextDrawCreate(542.000, 403.000, "LD_BUM:blkdot");
	TextDrawTextSize(SettingButton, 14.000, 16.000);
	Fann_TextDrawAlignment(SettingButton, 1);
	TextDrawColor(SettingButton, 0);
	TextDrawSetShadow(SettingButton, 0);
	TextDrawSetOutline(SettingButton, 0);
	TextDrawBackgroundColor(SettingButton, 255);
	Fann_TextDrawFont(SettingButton, 4);
	Fann_TextDrawSetProportional(SettingButton, 1);
	Fann_TextDrawSetSelectable(SettingButton, 1);

	VehicleButton = TextDrawCreate(484.000, 248.000, "LD_BUM:blkdot");
	TextDrawTextSize(VehicleButton, 14.000, 16.000);
	Fann_TextDrawAlignment(VehicleButton, 1);
	TextDrawColor(VehicleButton, 0);
	TextDrawSetShadow(VehicleButton, 0);
	TextDrawSetOutline(VehicleButton, 0);
	TextDrawBackgroundColor(VehicleButton, 255);
	Fann_TextDrawFont(VehicleButton, 4);
	Fann_TextDrawSetProportional(VehicleButton, 1);
	Fann_TextDrawSetSelectable(VehicleButton, 1);

	MapsButton = TextDrawCreate(503.000, 248.000, "LD_BUM:blkdot");
	TextDrawTextSize(MapsButton, 14.000, 16.000);
	Fann_TextDrawAlignment(MapsButton, 1);
	TextDrawColor(MapsButton, 0);
	TextDrawSetShadow(MapsButton, 0);
	TextDrawSetOutline(MapsButton, 0);
	TextDrawBackgroundColor(MapsButton, 255);
	Fann_TextDrawFont(MapsButton, 4);
	Fann_TextDrawSetProportional(MapsButton, 1);
	Fann_TextDrawSetSelectable(MapsButton, 1);

	SpotifyButtonHome = TextDrawCreate(521.000, 246.500, "LD_BUM:blkdot");
    TextDrawTextSize(SpotifyButtonHome, 15.000, 17.000);
    Fann_TextDrawAlignment(SpotifyButtonHome, 1);
    TextDrawColor(SpotifyButtonHome, 0);
    TextDrawSetShadow(SpotifyButtonHome, 0);
    TextDrawSetOutline(SpotifyButtonHome, 0);
    TextDrawBackgroundColor(SpotifyButtonHome, 255);
    Fann_TextDrawFont(SpotifyButtonHome, 4);
    Fann_TextDrawSetProportional(SpotifyButtonHome, 1);
    Fann_TextDrawSetSelectable(SpotifyButtonHome, 1);

    SpotifyTextHome = TextDrawCreate(521.000, 265.000, "Spotify");
    TextDrawLetterSize(SpotifyTextHome, 0.140, 0.699);
    Fann_TextDrawAlignment(SpotifyTextHome, 1);
    TextDrawColor(SpotifyTextHome, -1);
    TextDrawSetShadow(SpotifyTextHome, 1);
    TextDrawSetOutline(SpotifyTextHome, 1);
    TextDrawBackgroundColor(SpotifyTextHome, 0);
    Fann_TextDrawFont(SpotifyTextHome, 1);
    Fann_TextDrawSetProportional(SpotifyTextHome, 1);

	//Date and Time
	TextDate = TextDrawCreate(71.000000, 430.000000, "18 - July - 2025");
	Fann_TextDrawFont(TextDate, 1);
	TextDrawLetterSize(TextDate, 0.308332, 1.349998);
	TextDrawTextSize(TextDate, 404.500000, 114.500000);
	TextDrawSetOutline(TextDate, 1);
	TextDrawSetShadow(TextDate, 0);
	Fann_TextDrawAlignment(TextDate, 2);
	TextDrawColor(TextDate, -1);
	TextDrawBackgroundColor(TextDate, 255);
	TextDrawBoxColor(TextDate, 50);
	Fann_TextDrawSetProportional(TextDate, 1);
	Fann_TextDrawSetSelectable(TextDate, 0);

	TextTime = TextDrawCreate(547.000000, 28.000000, "-:-:-");
    Fann_TextDrawFont(TextTime, 1);
    TextDrawLetterSize(TextTime, 0.400000, 2.000000);
    TextDrawTextSize(TextTime, 400.000000, 1.399999);
    TextDrawSetOutline(TextTime, 1);
    TextDrawSetShadow(TextTime, 0);
    Fann_TextDrawAlignment(TextTime, 1);
    TextDrawColor(TextTime, -1);
    TextDrawBackgroundColor(TextTime, 255);
    TextDrawBoxColor(TextTime, 50);
    Fann_TextDrawUseBox(TextTime, 0);
    Fann_TextDrawSetProportional(TextTime, 1);
    Fann_TextDrawSetSelectable(TextTime, 0);
	
	//Server Name
	TextFann = TextDrawCreate(490.000000, 8.000038, "~b~HopePride ~w~Community");
    TextDrawLetterSize(TextFann, 0.269998, 1.405864);
    TextDrawAlignment(TextFann, TEXT_DRAW_ALIGN_LEFT);
    TextDrawColor(TextFann, -1);
    TextDrawSetShadow(TextFann, 0);
    TextDrawSetOutline(TextFann, 1);
    TextDrawBackgroundColor(TextFann, 0x000000FF);
    TextDrawFont(TextFann, TEXT_DRAW_FONT_STANDARD);
    TextDrawSetProportional(TextFann, true);

	//HBE textdraw Modern
	TDEditor_TD[6] = TextDrawCreate(428.000000, 367.916717, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[6], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[6], 97.000000, 11.000000);
	Fann_TextDrawAlignment(TDEditor_TD[6], 1);
	TextDrawColor(TDEditor_TD[6], 16777215);
	TextDrawSetShadow(TDEditor_TD[6], 0);
	TextDrawSetOutline(TDEditor_TD[6], 0);
	TextDrawBackgroundColor(TDEditor_TD[6], 255);
	Fann_TextDrawFont(TDEditor_TD[6], 4);
	Fann_TextDrawSetProportional(TDEditor_TD[6], 0);
	TextDrawSetShadow(TDEditor_TD[6], 0);

	TDEditor_TD[7] = TextDrawCreate(428.000000, 380.750030, "Engine:");
	TextDrawLetterSize(TDEditor_TD[7], 0.248998, 1.063333);
	Fann_TextDrawAlignment(TDEditor_TD[7], 1);
	TextDrawColor(TDEditor_TD[7], -1);
	TextDrawSetShadow(TDEditor_TD[7], 0);
	TextDrawSetOutline(TDEditor_TD[7], 1);
	TextDrawBackgroundColor(TDEditor_TD[7], 255);
	Fann_TextDrawFont(TDEditor_TD[7], 1);
	Fann_TextDrawSetProportional(TDEditor_TD[7], 1);
	TextDrawSetShadow(TDEditor_TD[7], 0);

	TDEditor_TD[8] = TextDrawCreate(428.000000, 389.499969, "Speed:");
	TextDrawLetterSize(TDEditor_TD[8], 0.266499, 1.191666);
	Fann_TextDrawAlignment(TDEditor_TD[8], 1);
	TextDrawColor(TDEditor_TD[8], -1);
	TextDrawSetShadow(TDEditor_TD[8], 0);
	TextDrawSetOutline(TDEditor_TD[8], 1);
	TextDrawBackgroundColor(TDEditor_TD[8], 255);
	Fann_TextDrawFont(TDEditor_TD[8], 1);
	Fann_TextDrawSetProportional(TDEditor_TD[8], 1);
	TextDrawSetShadow(TDEditor_TD[8], 0);

	TDEditor_TD[9] = TextDrawCreate(437.000000, 411.083343, "");
	TextDrawLetterSize(TDEditor_TD[9], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[9], 13.000000, 18.000000);
	Fann_TextDrawAlignment(TDEditor_TD[9], 1);
	TextDrawColor(TDEditor_TD[9], -1);
	TextDrawSetShadow(TDEditor_TD[9], 0);
	TextDrawSetOutline(TDEditor_TD[9], 0);
	TextDrawBackgroundColor(TDEditor_TD[9], 0);
	Fann_TextDrawFont(TDEditor_TD[9], 5);
	Fann_TextDrawSetProportional(TDEditor_TD[9], 0);
	TextDrawSetShadow(TDEditor_TD[9], 0);
	TextDrawSetPreviewModel(TDEditor_TD[9], 1240);
	TextDrawSetPreviewRot(TDEditor_TD[9], 0.000000, 0.000000, 0.000000, 1.000000);

	TDEditor_TD[10] = TextDrawCreate(434.500000, 425.666595, "");
	TextDrawLetterSize(TDEditor_TD[10], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[10], 20.000000, 21.000000);
	Fann_TextDrawAlignment(TDEditor_TD[10], 1);
	TextDrawColor(TDEditor_TD[10], -1);
	TextDrawSetShadow(TDEditor_TD[10], 0);
	TextDrawSetOutline(TDEditor_TD[10], 0);
	TextDrawBackgroundColor(TDEditor_TD[10], 0);
	Fann_TextDrawFont(TDEditor_TD[10], 5);
	Fann_TextDrawSetProportional(TDEditor_TD[10], 0);
	TextDrawSetShadow(TDEditor_TD[10], 0);
	TextDrawSetPreviewModel(TDEditor_TD[10], 1650);
	TextDrawSetPreviewRot(TDEditor_TD[10], 0.000000, 0.000000, 0.000000, 1.000000);
	
	TDEditor_TD[11] = TextDrawCreate(427.000000, 400.583374, "Fare:");
	TextDrawLetterSize(TDEditor_TD[11], 0.360498, 1.022500);
	Fann_TextDrawAlignment(TDEditor_TD[11], 1);
	TextDrawColor(TDEditor_TD[11], -1);
	TextDrawSetShadow(TDEditor_TD[11], 0);
	TextDrawSetOutline(TDEditor_TD[11], 1);
	TextDrawBackgroundColor(TDEditor_TD[11], 255);
	Fann_TextDrawFont(TDEditor_TD[11], 1);
	Fann_TextDrawSetProportional(TDEditor_TD[11], 1);
	TextDrawSetShadow(TDEditor_TD[11], 0);
}
