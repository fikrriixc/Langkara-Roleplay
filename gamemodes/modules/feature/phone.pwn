// Code by Fann
// Textdraw by Unknown People

#include <YSI_Coding\y_hooks>

Phone_Show(playerid)
{
	forex(fan, 183)
		TextDrawShowForPlayer(playerid, PhoneTD[fan]);

	if(PlayerData[playerid][pVip] > 1 || !strcmp(UcpData[playerid][uUsername], "Fann"))
	{
		TextDrawShowForPlayer(playerid, AppTambahan[0]);
	    TextDrawShowForPlayer(playerid, AppTambahan[1]);
	    TextDrawShowForPlayer(playerid, AppTambahan[2]);
	    TextDrawShowForPlayer(playerid, AppTambahan[3]);
	    TextDrawShowForPlayer(playerid, AppTambahan[4]);
	    TextDrawShowForPlayer(playerid, AppTambahan[5]);
	    TextDrawShowForPlayer(playerid, AppTambahan[18]);
	    TextDrawShowForPlayer(playerid, AppTambahan[19]);
	    TextDrawShowForPlayer(playerid, AppTambahan[20]);
	    TextDrawShowForPlayer(playerid, AppTambahan[21]);
	    TextDrawShowForPlayer(playerid, AppTambahan[22]);
	    TextDrawShowForPlayer(playerid, AppTambahan[23]);
	    TextDrawShowForPlayer(playerid, AppTambahan[24]);
	}

	TextDrawShowForPlayer(playerid, PowerButton);
	TextDrawShowForPlayer(playerid, BankButton);
	TextDrawShowForPlayer(playerid, HopeButton);
	TextDrawShowForPlayer(playerid, XButton);
	TextDrawShowForPlayer(playerid, CameraButton);
	TextDrawShowForPlayer(playerid, CallButton);
	TextDrawShowForPlayer(playerid, MessageButton);
	TextDrawShowForPlayer(playerid, ContactButton);
	TextDrawShowForPlayer(playerid, SettingButton);
	TextDrawShowForPlayer(playerid, VehicleButton);
	TextDrawShowForPlayer(playerid, MapsButton);
	TextDrawShowForPlayer(playerid, SpotifyButtonHome);
	TextDrawShowForPlayer(playerid, SpotifyTextHome);

	SelectTextDraw(playerid, -1);
}

Phone_Hide(playerid)
{
	forex(fan, 183)
		TextDrawHideForPlayer(playerid, PhoneTD[fan]);

	forex(fan, 26)
		TextDrawHideForPlayer(playerid, AppTambahan[fan]); // spotify

	TextDrawHideForPlayer(playerid, PowerButton);
	TextDrawHideForPlayer(playerid, BankButton);
	TextDrawHideForPlayer(playerid, HopeButton);
	TextDrawHideForPlayer(playerid, XButton);
	TextDrawHideForPlayer(playerid, CameraButton);
	TextDrawHideForPlayer(playerid, CallButton);
	TextDrawHideForPlayer(playerid, MessageButton);
	TextDrawHideForPlayer(playerid, ContactButton);
	TextDrawHideForPlayer(playerid, SettingButton);
	TextDrawHideForPlayer(playerid, VehicleButton);
	TextDrawHideForPlayer(playerid, MapsButton);
	TextDrawHideForPlayer(playerid, SpotifyButtonHome);
	TextDrawHideForPlayer(playerid, SpotifyTextHome);

	CancelSelectTextDraw(playerid);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_TWITTER)
	{
		if(response)
		{
			switch(listitem)
			{
				case 1: ShowPlayerDialog(playerid, DIALOG_TWITTER_CHANGE, DIALOG_STYLE_INPUT, "Twitter App", "Masukan nama twitter yang kamu inginkan:\n", "Enter", "Back");
				case 2: 
				{
					if(!strcmp(PlayerData[playerid][pTwittername], "None"))
					{
						SendInfoMessage(playerid, "Kamu harus memiliki nama twitter terlebih dahulu!");
						return ShowPlayerDialog(playerid, DIALOG_TWITTER, DIALOG_STYLE_LIST, "Twitter App", "Twitter Name\t{ffff00}%s{ffffff}\nChange Name\nTweet", "Select", "Back", PlayerData[playerid][pTwittername]);
					}

					ShowPlayerDialog(playerid, DIALOG_TWITTER_TWEET, DIALOG_STYLE_INPUT, "Twitter App", "Masukan text yang ingin kamu tweet:\n", "Enter", "Back");
				}
			}
		}
	}
	if(dialogid == DIALOG_TWITTER_CHANGE)
	{
		if(response)
		{
			if(strfind(inputtext, " ") != -1)
				return ShowPlayerDialog(playerid, DIALOG_TWITTER_CHANGE, DIALOG_STYLE_INPUT, "Twitter App", "ERROR: Tidak diperbolehkan menggunakan space/spasal \n\nMasukan nama twitter yang kamu inginkan:\n", "Enter", "Back");

			callcmd::settwittername(playerid, inputtext);
		}
		else
			ShowPlayerDialog(playerid, DIALOG_TWITTER, DIALOG_STYLE_LIST, "Twitter App", "Twitter Name\t{ffff00}%s{ffffff}\nChange Name\nTweet", "Select", "Back", PlayerData[playerid][pTwittername]);
	}
	if(dialogid == DIALOG_TWITTER_TWEET)
	{
		if(response)
		{
			callcmd::tw(playerid, inputtext);
		}
		else
			ShowPlayerDialog(playerid, DIALOG_TWITTER, DIALOG_STYLE_LIST, "Twitter App", "Twitter Name\t{ffff00}%s{ffffff}\nChange Name\nTweet", "Select", "Back", PlayerData[playerid][pTwittername]);
	}
	if(dialogid == DIALOG_CALL)
	{
		if(response)
		{
			callcmd::call(playerid, inputtext);
		}
	}
	if(dialogid == DIALOG_MESSAGE)
	{
		if(response)
		{
			new number, message[128];
			if(sscanf(inputtext, "ds[128]", number, message))
				return ShowPlayerDialog(playerid, DIALOG_MESSAGE, DIALOG_STYLE_INPUT, "Message App", "Masukan nomer panggilan yang ingin kamu beri pesan\ndan berikan pesan di samping nomer panggilan:\n", "Message", "Back");

			if(strlen(message) > 128)
				return ShowPlayerDialog(playerid, DIALOG_MESSAGE, DIALOG_STYLE_INPUT, "Message App", "ERROR: Pesan terlalu panjang!\n\nMasukan nomer panggilan yang ingin kamu beri pesan\ndan berikan pesan di samping nomer panggilan:\n", "Message", "Back");

			callcmd::sms(playerid, sprintf("%d %s", number, message));
		}
	}
	if(dialogid == DIALOG_SPOTIFY)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: ShowPlayerDialog(playerid, DIALOG_SPOTIFY_INPUT, DIALOG_STYLE_INPUT, "Spotify Play", "Masukan link Music di sini:", "Enter", "Cancel");
				case 1: Playlist_List(playerid);
				case 2: callcmd::stopsong(playerid);
			}
		}
	}
	if(dialogid == DIALOG_SPOTIFY_INPUT)
	{
		if(!response)
		{
			if(PlayerData[playerid][pVip] > 0)
			{
				ShowPlayerDialog(playerid, DIALOG_SPOTIFY, DIALOG_STYLE_TABLIST, "Spotify", "Input Link\nPlaylist", "Select", "Cancel");
			}
			else
				SendErrorMessage(playerid, "Fitur ini khusus VIP!");

			return 1;
		}

		if(strlen(inputtext) < 5 || strlen(inputtext) > 128)
			return ShowPlayerDialog(playerid, DIALOG_SPOTIFY_INPUT, DIALOG_STYLE_INPUT, "Spotify Play", "ERROR: Minimal harus memasukan 5-128 karakter\n\nMasukan link untuk Music ini:", "Play", "Back");
	
		PlayAudioStreamForPlayer(playerid, inputtext);
	}
	return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == PowerButton)
	{
		Phone_Hide(playerid);
	}
	else if(clickedid == BankButton)
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, "BankApp", "\
			No Rekening\t%d\nBank Balance\t{00ff00}%s{ffffff}\n\nPenarikan/Pemasukan dapat dilakukan di ATM terdekat\natau dilakukan di Bank secara langsung... Terimakasih :)", "Close", "", PlayerData[playerid][pBankRek], FormatMoney(PlayerData[playerid][pBankMoney]));
	}
	else if(clickedid == HopeButton)
	{
		ShowPlayerDialog(playerid, DIALOG_HOPEDIA, DIALOG_STYLE_LIST, "Hopedia", "\
			Tentang Kota Hope\nOrang-Orang populer\n", "Select", "Close");
	}
	else if(clickedid == XButton)
	{
		ShowPlayerDialog(playerid, DIALOG_TWITTER, DIALOG_STYLE_LIST, "Twitter App", "\
			Twitter Name\t{ffff00}%s{ffffff}\nChange Name\nTweet", "Select", "Back", PlayerData[playerid][pTwittername]);
	}
	else if(clickedid == CameraButton)
	{
		if(GetPVarInt(playerid, "openCam"))
		{
			new Float:x, Float:y, Float:z, Float:angle;
			GetPlayerPos(playerid, x, y, z);
			GetPlayerFacingAngle(playerid, angle);

			SetPlayerCameraLookAt(playerid, x, y, z);
			
			x += 1.0 * floatsin(-angle, degrees);
			y += 1.0 * floatcos(-angle, degrees);

			SetPlayerCameraPos(playerid, x, y, z);
			SetPVarInt(playerid, "openCam", 1);
		}
		else
		{
			SetCameraBehindPlayer(playerid);
			SetPVarInt(playerid, "openCam", 0);
		}
	}
	else if(clickedid == CallButton)
	{
		ShowPlayerDialog(playerid, DIALOG_CALL, DIALOG_STYLE_INPUT, "Call Aps", "Masukan nomer panggilan yang ingin kamu panggil:\n", "Call", "Back");
	}
	else if(clickedid == MessageButton)
	{
		ShowPlayerDialog(playerid, DIALOG_MESSAGE, DIALOG_STYLE_INPUT, "Message App", "Masukan nomer panggilan yang ingin kamu beri pesan\ndan berikan pesan di samping nomer panggilan:\n", "Message", "Back");
	}
	else if(clickedid == ContactButton)
	{
		Contact_List(playerid);
	}
	else if(clickedid == SettingButton)
	{
		callcmd::settings(playerid);
	}
	else if(clickedid == VehicleButton)
	{
		callcmd::v(playerid, "my");
	}
	else if(clickedid == MapsButton)
	{
		callcmd::gps(playerid, "");
	}
	else if(clickedid == SpotifyButtonHome)
	{
		//ShowPlayerDialog(playerid, DIALOG_SPOTIFY, DIALOG_STYLE_TABLIST, "Spotify", "Input Link\nPlaylist\n{ff0000}Hentikan Music", "Select", "Cancel");
		if(PlayerData[playerid][pVip] > 1)
		{
			ShowPlayerDialog(playerid, DIALOG_SPOTIFY, DIALOG_STYLE_TABLIST, "Spotify", "Input Link\nPlaylist", "Select", "Cancel");
		}
		else
		{
			if(strcmp(UcpData[playerid][uUsername], "Fann"))
				SendErrorMessage(playerid, "Fitur ini khusus VIP!");
			else
				ShowPlayerDialog(playerid, DIALOG_SPOTIFY, DIALOG_STYLE_TABLIST, "Spotify", "Input Link\nPlaylist", "Select", "Cancel");
		}
	}
	return 1;
}