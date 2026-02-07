// Dynamic Playlist
// Script by Fann
#include <YSI_Coding\y_hooks>

new playerPlaylist[MAX_PLAYERS];
new playerPlaylistTimer[MAX_PLAYERS];

enum e_playlist_data
{
	sID,
	sName[32],
	sLink[64],
	sDuration[12],
	sOwner,
	bool:sExist
};
new PlaylistData[MAX_PLAYERS][MAX_PLAYLIST][e_playlist_data];

Playlist_Reset(playerid)
{
	forex(pid, MAX_PLAYLIST) if(PlaylistData[playerid][pid][sExist])
	{
		PlaylistData[playerid][pid][sID] = -1;
		PlaylistData[playerid][pid][sOwner] = -1;
		format(PlaylistData[playerid][pid][sName], 32, "");
		format(PlaylistData[playerid][pid][sLink], 64, "");
		format(PlaylistData[playerid][pid][sDuration], 12, "");
		PlaylistData[playerid][pid][sExist] = false;
	}
	return 1;
}

Playlist_FreeID(playerid)
{
	forex(pid, MAX_PLAYLIST) if(!PlaylistData[playerid][pid][sExist])
		return pid;

	return -1;
}

Playlist_Add(playerid, name[], link[], const dura[])
{
	new pid = Playlist_FreeID(playerid);
	if(pid != -1)
	{
		format(PlaylistData[playerid][pid][sName], 32, name);
		format(PlaylistData[playerid][pid][sLink], 64, link);
		format(PlaylistData[playerid][pid][sDuration], 12, dura);

		PlaylistData[playerid][pid][sExist] = true;

		mysql_tquery(g_SQL, sprintf("INSERT INTO playlist (owner) VALUES('%d')", PlayerData[playerid][pID]), "Playlist_Created", "dd", playerid, pid);
		return pid;
	}
	return -1;
}

Playlist_Save(playerid, pid)
{
	new fanQuery[5000];
	mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "UPDATE playlist SET ");
	mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%sname = '%s', ", fanQuery, SQL_EscapeString(PlaylistData[playerid][pid][sName]));
	mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%slink = '%s', ", fanQuery, SQL_EscapeString(PlaylistData[playerid][pid][sLink]));
	mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%sduration = '%s' ", fanQuery, SQL_EscapeString(PlaylistData[playerid][pid][sDuration]));
	mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "%sWHERE id = '%d'", fanQuery, PlaylistData[playerid][pid][sID]);
	mysql_tquery(g_SQL, fanQuery);
	return 1;
}

Playlist_Load(playerid)
{
	mysql_query(g_SQL, sprintf("SELECT * FROM playlist WHERE owner = '%d'", PlayerData[playerid][pID]), true);

	if(cache_num_rows())
	{
		forex(pid, cache_num_rows())
		{
			cache_get_value_name_int(pid, "id", PlaylistData[playerid][pid][sID]);
			cache_get_value_name(pid, "name", PlaylistData[playerid][pid][sName]);
			cache_get_value_name(pid, "link", PlaylistData[playerid][pid][sLink]);
			cache_get_value_name(pid, "duration", PlaylistData[playerid][pid][sDuration]);

			PlaylistData[playerid][pid][sExist] = true;
		}
		printf("[PLAYLIST] Loaded %d playlists for %s.", cache_num_rows(), PlayerData[playerid][pName]);
	}
	return 1;
}

public:Playlist_Created(playerid, pid)
{
	PlaylistData[playerid][pid][sID] = cache_insert_id();
	Playlist_Save(playerid, pid);
	return 1;
}

public:Playlist_Next(playerid, pid)
{
	if(GetPVarInt(playerid, "playerPlaylist") == pid)
	{
		if(playerPlaylist[playerid]-- == 0)
		{
			if(PlaylistData[playerid][pid+1][sExist])
			{
				pid++;
				Playlist_Play(playerid, pid, false);
			}
			else
			{
				if(PlaylistData[playerid][0][sExist])
					pid = 0;
				else
					pid = 1;

				Playlist_Play(playerid, pid, false);
			}
		}
	}
	return 1;
}

Playlist_Play(playerid, pid, bool:showinfo = true)
{
	foreach(new ii : Player)
	{
		if(GetPVarInt(ii, "PlacedBB") && GetPVarInt(playerid, "pAudioStream"))
		{
			new bbtext[128];
			GetPVarString(ii, "BBStation", bbtext, sizeof(bbtext));
			if(strlen(bbtext) > 0 && IsPlayerInDynamicArea(playerid, GetPVarInt(ii, "BBArea")) && playerPlaylist[playerid] == 0)
			{
				StopStream(playerid);
				SendCustomMessage(playerid, "PLAYLIST", "Terdeteksi di dekatmu terdapat pemutar boombox!");
			}
		}
	}

	SetPVarInt(playerid, "playerPlaylist", pid);
	PlayAudioStreamForPlayer(playerid, PlaylistData[playerid][pid][sLink]);

	if(showinfo)
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Music Info", "{ffffff}Music Name : {ffff00}%s\n{ffffff}Music Duration : {ffff00}%s\n{ffffff}Music Status : {00ff00}Played", "Close", "", PlaylistData[playerid][pid][sName], PlaylistData[playerid][pid][sDuration]);
	else
		SendCustomMessage(playerid, "PLAYLIST", "You're now playing {ffff00}%s (%s){ffffff}.", PlaylistData[playerid][pid][sName], PlaylistData[playerid][pid][sDuration]);

	if(IsValidTimer(playerPlaylistTimer[playerid]))
		KillTimer(playerPlaylistTimer[playerid]);

	new duration[12];
	format(duration, sizeof(duration), PlaylistData[playerid][pid][sDuration]);
	strreplace(duration, ":", "");

	if(strval(duration) > 59)
		playerPlaylist[playerid] = (strval(duration)*60)/100;
	else
		playerPlaylist[playerid] = strval(duration);

	SetPVarInt(playerid, "playerDuration", playerPlaylist[playerid]*1000);
	playerPlaylistTimer[playerid] = SetTimerEx("Playlist_Next", 1000, true, "dd", playerid, pid);
	return 1;
}

Playlist_List(playerid)
{
	new fanstr[5000], num;
	strcat(fanstr, "Music Name\tMusic Duration\tMusic Link\n");
	forex(pid, MAX_PLAYLIST) if(PlaylistData[playerid][pid][sExist])
	{
		strcat(fanstr, sprintf("{FFFFFF}%s\t%s\t%s\n", PlaylistData[playerid][pid][sName], PlaylistData[playerid][pid][sDuration], PlaylistData[playerid][pid][sLink]), sizeof(fanstr));
		PlayerData[playerid][pValueListitem][num] = pid;
		num++;
	}

	if(num < MAX_PLAYLIST)
		strcat(fanstr, "{ffff00}( Add Playlist )");

	ShowPlayerDialog(playerid, DIALOG_SPOTIFY_PLAYLIST, DIALOG_STYLE_TABLIST_HEADERS, "My Playlist", fanstr, "Select", "Back");
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_SPOTIFY_PLAYLIST)
	{
		if(response)
		{
			listitem = PlayerData[playerid][pValueListitem][listitem];
			ResetValueListitem(playerid);
			
			if(!PlaylistData[playerid][listitem][sExist])
				return ShowPlayerDialog(playerid, DIALOG_SPOTIFY_ADDNAME, DIALOG_STYLE_INPUT, "Add Music", "Masukan nama untuk Music ini:", "Next", "Back");

			SetPVarInt(playerid, "playerPlaylist", listitem);
			ShowPlayerDialog(playerid, DIALOG_SPOTIFY_PLAYLIST_INFO, DIALOG_STYLE_TABLIST, sprintf("Playlist: %s", PlaylistData[playerid][listitem][sName]), "{00ff00}Play\t{ffffff}Mainkan music\n{ff0000}Delete\t{ffffff}Hapus dari Playlist", "Select", "Back");
		}
	}
	if(dialogid == DIALOG_SPOTIFY_PLAYLIST_INFO)
	{
		if(!response)
			return Playlist_List(playerid);

		if(!PlaylistData[playerid][GetPVarInt(playerid, "playerPlaylist")][sExist])
			return SendErrorMessage(playerid, "Invalid music!"), Playlist_List(playerid);

		new pid = GetPVarInt(playerid, "playerPlaylist");
		switch(listitem)
		{
			case 0: 
			{
				foreach(new ii : Player)
				{
					if(GetPVarInt(ii, "PlacedBB"))
					{
						new bbtext[128];
						GetPVarString(ii, "BBStation", bbtext, sizeof(bbtext));
						if(strlen(bbtext) > 0 && IsPlayerInDynamicArea(playerid, GetPVarInt(ii, "BBArea")) && playerPlaylist[playerid] == 0)
						{
							StopStream(playerid);
							SendCustomMessage(playerid, "PLAYLIST", "Terdeteksi di dekatmu terdapat pemutar boombox!");
							return 1;
						}
					}
				}

				Playlist_Play(playerid, pid);
			}
			case 1: 
			{
				mysql_tquery(g_SQL, sprintf("DELETE FROM playlist WHERE id = '%d'", PlaylistData[playerid][pid][sID]));

				SendCustomMessage(playerid, "PLAYLIST", "You have been deleted {ffff00}%s{ffffff} from Playlist.", PlaylistData[playerid][pid][sName]);

				PlaylistData[playerid][pid][sID] = -1;
				PlaylistData[playerid][pid][sExist] = false;
				format(PlaylistData[playerid][pid][sName], 32, "");
				format(PlaylistData[playerid][pid][sLink], 64, "");
				format(PlaylistData[playerid][pid][sDuration], 12, "");
			}
		}
	}
	if(dialogid == DIALOG_SPOTIFY_ADDNAME)
	{
		if(!response)
			return Playlist_List(playerid);

		if(strlen(inputtext) < 5 || strlen(inputtext) > 32)
			return ShowPlayerDialog(playerid, DIALOG_SPOTIFY_ADDNAME, DIALOG_STYLE_INPUT, "Add Music", "ERROR: Minimal harus memasukan 5-32 karakter\n\nMasukan nama untuk Music ini:", "Next", "Back");
	
		SetPVarString(playerid, "playlistName", inputtext);
		ShowPlayerDialog(playerid, DIALOG_SPOTIFY_ADDLINK, DIALOG_STYLE_INPUT, "Add Music", "Masukan link untuk Music ini:", "Save", "Back");
	}
	if(dialogid == DIALOG_SPOTIFY_ADDLINK)
	{
		if(!response)
			return Playlist_List(playerid);

		if(strlen(inputtext) < 5 || strlen(inputtext) > 64)
			return ShowPlayerDialog(playerid, DIALOG_SPOTIFY_ADDLINK, DIALOG_STYLE_INPUT, "Add Music", "ERROR: Minimal harus memasukan 5-128 karakter\n\nMasukan link untuk Music ini:", "Next", "Back");
	
		SetPVarString(playerid, "playlistLink", inputtext);
		ShowPlayerDialog(playerid, DIALOG_SPOTIFY_ADDDURA, DIALOG_STYLE_INPUT, "Add Music", ""LB_E"INFO: {FFFFFF}Kamu harus memasukan durasi yang sama persis seperti durasi music\nContoh:\n25:02 (minute:second)\n\nMasukan Durasi untuk lagu ini:", "Save", "Back");
	}
	if(dialogid == DIALOG_SPOTIFY_ADDDURA)
	{
		if(!response)
			return Playlist_List(playerid);

		new minute, second;
		if(sscanf(inputtext, "p<:>dd", minute, second))
			return ShowPlayerDialog(playerid, DIALOG_SPOTIFY_ADDDURA, DIALOG_STYLE_INPUT, "Add Music", ""LB_E"INFO: {FFFFFF}Kamu harus memasukan durasi yang sama persis seperti durasi music\nContoh:\n25:02 (minute:second)\n\nMasukan Durasi untuk lagu ini:", "Save", "Back");

		if(minute > 59)
			return ShowPlayerDialog(playerid, DIALOG_SPOTIFY_ADDDURA, DIALOG_STYLE_INPUT, "Add Music", ""LB_E"INFO: {FFFFFF}Kamu harus memasukan durasi yang sama persis seperti durasi music\nContoh:\n25:02 (minute:second)\n\nMasukan Durasi untuk lagu ini:", "Save", "Back");

		if(second > 59)
			return ShowPlayerDialog(playerid, DIALOG_SPOTIFY_ADDDURA, DIALOG_STYLE_INPUT, "Add Music", ""LB_E"INFO: {FFFFFF}Kamu harus memasukan durasi yang sama persis seperti durasi music\nContoh:\n25:02 (minute:second)\n\nMasukan Durasi untuk lagu ini:", "Save", "Back");

		new fanname[32], fanlink[64], fandura[12];
		GetPVarString(playerid, "playlistName", fanname, sizeof(fanname));
		GetPVarString(playerid, "playlistLink", fanlink, sizeof(fanlink));
		format(fandura, sizeof(fandura), "%s%d:%s%d", minute >= 10 ? "" : "0", minute, second >= 10 ? "" : "0", second);
		if(Playlist_Add(playerid, fanname, fanlink, fandura) != -1)
		{
			Playlist_List(playerid);
			SendCustomMessage(playerid, "PLAYLIST", "You have add {ffff00}%s{ffffff} to your Playlist.", fanname);
		}
		else
			SendErrorMessage(playerid, "You don't have any Free Room for Playlist left!");
	}
	return 1;
}