// Contact
#include <YSI_Coding\y_hooks>

enum e_contact_data
{
	cID,
	cName[MAX_PLAYER_NAME],
	cNumber,
	cOwner,
	//not saved
	bool:cExists
}

new ContactData[MAX_PLAYERS][MAX_CONTACT][e_contact_data];

Contact_Reset(playerid)
{
	forex(fan, MAX_CONTACT) if(ContactData[playerid][fan][cExists])
	{
		ContactData[playerid][fan][cID] = -1;
		ContactData[playerid][fan][cOwner] = -1;
		ContactData[playerid][fan][cNumber] = 0;
		format(ContactData[playerid][fan][cName], MAX_PLAYER_NAME, "-");

		ContactData[playerid][fan][cExists] = false;
	}
	return 1;
}

Contact_Delete(playerid, cid)
{
	new fanQuery[500];
	mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "DELETE FROM contact WHERE id = '%d'", cid);
	mysql_tquery(g_SQL, fanQuery);

	ContactData[playerid][cid][cID] = -1;
	ContactData[playerid][cid][cOwner] = -1;
	ContactData[playerid][cid][cNumber] = 0;
	format(ContactData[playerid][cid][cName], MAX_PLAYER_NAME, "-");

	ContactData[playerid][cid][cExists] = false;
	return 1;
}

Contact_Load(playerid)
{
	new fanQuery[500];
	mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "SELECT * FROM `contact` WHERE ownerid = '%d'", PlayerData[playerid][pID]);
	mysql_query(g_SQL, fanQuery, true);

	if(cache_num_rows()) forex(fan, cache_num_rows())
	{
		cache_get_value_name_int(fan, "id", ContactData[playerid][fan][cID]);
		cache_get_value_name_int(fan, "ownerid", ContactData[playerid][fan][cOwner]);
		cache_get_value_name(fan, "name", ContactData[playerid][fan][cName]);
		cache_get_value_name_int(fan, "number", ContactData[playerid][fan][cNumber]);

		ContactData[playerid][fan][cExists] = true;
	}
	printf("[CONTACT] Loaded %d contacts for %s.", cache_num_rows(), PlayerData[playerid][pName]);
	return 1;
}

Contact_Save(playerid)
{
	new fanQuery[5000];
	forex(fan, MAX_CONTACT) if(ContactData[playerid][fan][cExists])
	{
		format(fanQuery, sizeof(fanQuery), "UPDATE contact SET ");
		format(fanQuery, sizeof(fanQuery), "%sid = '%d', ", fanQuery, ContactData[playerid][fan][cID]);
		format(fanQuery, sizeof(fanQuery) ,"%sownerid = '%d', ", fanQuery, ContactData[playerid][fan][cOwner]);
		format(fanQuery, sizeof(fanQuery) ,"%sname = '%s', ", fanQuery, ContactData[playerid][fan][cName]);
		format(fanQuery, sizeof(fanQuery) ,"%snumber = '%d' ", fanQuery, ContactData[playerid][fan][cNumber]);

		format(fanQuery, sizeof(fanQuery), "%sWHERE id = '%d'", fanQuery, ContactData[playerid][fan][cID]);
		mysql_tquery(g_SQL, fanQuery);
	}
	return 1;
}

Contact_Status(playerid, cid)
{
	new fanstr[256];
	
	format(fanstr, sizeof(fanstr), "{ff0000}Offline{ffffff}");
	foreach(new players : Player) if(ContactData[playerid][cid][cNumber] == PlayerData[players][pPhone])
	{
		format(fanstr, sizeof(fanstr), "{00ff00}Online{ffffff}");
	}

	return fanstr;
}

Contact_List(playerid)
{
	new fanstr[5000], num;
	strcat(fanstr, "Name\tNumber\tStatus\n");
	forex(fan, MAX_CONTACT) if(ContactData[playerid][fan][cExists])
	{
		strcat(fanstr, sprintf("%s\t%d\t%s\n", ContactData[playerid][fan][cName], ContactData[playerid][fan][cNumber], Contact_Status(playerid, fan)));
		PlayerData[playerid][pValueListitem][num] = fan;
		num++;
	}

	if(Contact_Count(playerid) < MAX_CONTACT)
		strcat(fanstr, "{ffff00}( Add Contact ){ffffff}");

	ShowPlayerDialog(playerid, DIALOG_CONTACT, DIALOG_STYLE_TABLIST_HEADERS, "Contact", fanstr, "Select", "Back");
	return 1;
}

Contact_Count(playerid)
{
	new count = 0;
	forex(fan, MAX_CONTACT) if(ContactData[playerid][fan][cExists])
		count++;

	return count;
}

Contact_FreeID(playerid)
{
	if(Contact_Count(playerid) >= MAX_CONTACT)
		return -1;

	forex(fan, MAX_CONTACT) if(!ContactData[playerid][fan][cExists])
		return fan;

	return -1;
}

Contact_Add(playerid, number, name[])
{
	new cid;
	if((cid = Contact_FreeID(playerid)) != -1)
	{
		ContactData[playerid][cid][cExists] = true;
		ContactData[playerid][cid][cOwner] = PlayerData[playerid][pID];
		format(ContactData[playerid][cid][cName], MAX_PLAYER_NAME, name);
		ContactData[playerid][cid][cNumber] = number;

		mysql_tquery(g_SQL, "INSERT INTO contact (number) VALUES(0)", "Contact_Added", "dd", playerid, cid);
		return cid;
	}
	else
		SendErrorMessage(playerid, "Kamu tidak memiliki slot contact lagi!");

	return -1;
}

public:Contact_Added(playerid, cid)
{
	ContactData[playerid][cid][cID] = cache_insert_id();

	Contact_Save(playerid);
	return 1;
}

// ---[ DIALOG ]--- //
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_CONTACT)
	{
		if(response)
		{
			new cid = PlayerData[playerid][pValueListitem][listitem];
			ResetValueListitem(playerid);

			if(!ContactData[playerid][cid][cExists])
				return ShowPlayerDialog(playerid, DIALOG_CONTACT_ADD, DIALOG_STYLE_INPUT, "Contact Add", "Masukan nomer telepon yang ingin kamu masukan contact:\n", "Enter", "Back");

			SetPVarInt(playerid, "cid", cid);
			ShowPlayerDialog(playerid, DIALOG_CONTACT_MENU, DIALOG_STYLE_TABLIST, sprintf("Contact: %s", ContactData[playerid][cid][cName]), "\
				Change Name\n\
				Change Number\n\
				Call\n\
				Message\n\
				Remove Contact\n", "Select", "Back");
		}
	}
	if(dialogid == DIALOG_CONTACT_ADD)
	{
		if(response)
		{
			new number;
			if(sscanf(inputtext, "d", number))
				return ShowPlayerDialog(playerid, DIALOG_CONTACT_ADD, DIALOG_STYLE_INPUT, "Contact Add", "Masukan nomer telepon yang ingin kamu masukan contact:\n", "Enter", "Back");

			SetPVarInt(playerid, "cNumber", number);
			ShowPlayerDialog(playerid, DIALOG_CONTACT_ADD_NAME, DIALOG_STYLE_INPUT, "Contact Add", "Masukan nama contact yang ingin kamu masukan contact:\n", "Enter", "Back");
		}
		else
			Contact_List(playerid);
	}
	if(dialogid == DIALOG_CONTACT_ADD_NAME)
	{
		if(response)
		{
			new cid, name[MAX_PLAYER_NAME];
			if(sscanf(inputtext, "s[24]", name))
				return ShowPlayerDialog(playerid, DIALOG_CONTACT_ADD, DIALOG_STYLE_INPUT, "Contact Add", "Masukan nomer telepon yang ingin kamu masukan contact:\n", "Enter", "Back");

			if(strlen(name) > 24)
				return ShowPlayerDialog(playerid, DIALOG_CONTACT_ADD, DIALOG_STYLE_INPUT, "Contact Add", "ERROR: Nama terlalu panjang! Maksimal 24 karakter.\n\nMasukan nomer telepon yang ingin kamu masukan contact:\n", "Enter", "Back");

			new number = GetPVarInt(playerid, "cNumber");
			if((cid = Contact_Add(playerid, number, name)) == -1)
				return 1;

			SendInfoMessage(playerid, "Kamu telah {00ff00}menyimpan{ffff00} %s(%d){ffffff} sebagai contact.", ContactData[playerid][cid][cName], ContactData[playerid][cid][cNumber]);
			Contact_List(playerid);
		}
		else
			ShowPlayerDialog(playerid, DIALOG_CONTACT_ADD, DIALOG_STYLE_INPUT, "Contact Add", "Masukan nomer telepon yang ingin kamu masukan contact:\n", "Enter", "Back");
	}
	if(dialogid == DIALOG_CONTACT_MENU)
	{
		if(response)
		{
			new cid = GetPVarInt(playerid, "cid");
			switch(listitem)
			{
				case 0: ShowPlayerDialog(playerid, DIALOG_CONTACT_CHANGE_NAME, DIALOG_STYLE_INPUT, "Contact Change Name", sprintf("Contact Name : {ffff00}%s{ffffff}\n\nMasukan nama yang ingin kamu ganti:\n", ContactData[playerid][cid][cName]), "Change", "Back");
				case 1: ShowPlayerDialog(playerid, DIALOG_CONTACT_CHANGE_NUMBER, DIALOG_STYLE_INPUT, "Contact Change Number", sprintf("Contact Number : {ffff00}%d{ffffff}\n\nMasukan phone number yang ingin kamu ganti:\n", ContactData[playerid][cid][cNumber]), "Change", "Back");
				case 2:
				{
					callcmd::call(playerid, sprintf("%d", ContactData[playerid][cid][cNumber]));
				}
				case 3: ShowPlayerDialog(playerid, DIALOG_CONTACT_MESSAGE, DIALOG_STYLE_INPUT, "Contact Message", sprintf("Contact Name : {ffff00}%s{ffffff}\nContact Number : {ffff00}%d{ffffff}\n\nMasukan pesan yang ingin kamu kirim:\n", ContactData[playerid][cid][cName], ContactData[playerid][cid][cNumber]), "Message", "Back");
				case 5:
				{
					SendInfoMessage(playerid, "Kamu telah {ff0000}menghapus{ffffff} contact {ffff00}%s(%d){ffffff} dari contact list.", ContactData[playerid][cid][cName], ContactData[playerid][cid][cNumber]);
					Contact_Delete(playerid, cid);

					Contact_List(playerid);
				}
			}
		}
		else
			Contact_List(playerid);
	}
	if(dialogid == DIALOG_CONTACT_CHANGE_NAME)
	{
		new cid = GetPVarInt(playerid, "cid");
		if(response)
		{
			new name[MAX_PLAYER_NAME];
			if(sscanf(inputtext, "s[24]", name))
				return ShowPlayerDialog(playerid, DIALOG_CONTACT_ADD, DIALOG_STYLE_INPUT, "Contact Add", "Masukan nomer telepon yang ingin kamu masukan contact:\n", "Enter", "Back");

			if(strlen(name) > 24)
				return ShowPlayerDialog(playerid, DIALOG_CONTACT_ADD, DIALOG_STYLE_INPUT, "Contact Add", "ERROR: Nama terlalu panjang! Maksimal 24 karakter.\n\nMasukan nomer telepon yang ingin kamu masukan contact:\n", "Enter", "Back");

			format(ContactData[playerid][cid][cName], MAX_PLAYER_NAME, name);

			SendInfoMessage(playerid, "Kamu telah mengubah nama{ffff00} %s(%d){ffffff} sebagai contact.", ContactData[playerid][cid][cName], ContactData[playerid][cid][cNumber]);
			Contact_List(playerid);
		}
		else
			ShowPlayerDialog(playerid, DIALOG_CONTACT_MENU, DIALOG_STYLE_TABLIST, sprintf("Contact: %s", ContactData[playerid][cid][cName]), "\
				Change Name\n\
				Change Number\n\
				Call\n\
				Message\n\
				Remove Contact\n", "Select", "Back");
	}
	if(dialogid == DIALOG_CONTACT_CHANGE_NUMBER)
	{
		new cid = GetPVarInt(playerid, "cid");
		if(response)
		{
			new number;
			if(sscanf(inputtext, "d", number))
				return ShowPlayerDialog(playerid, DIALOG_CONTACT_CHANGE_NUMBER, DIALOG_STYLE_INPUT, "Contact Change Name", sprintf("Contact Name : {ffff00}%s{ffffff}\n\nMasukan nama yang ingin kamu ganti:\n", ContactData[playerid][cid][cName]), "Change", "Back");

			if(!IsNumeric(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_CONTACT_CHANGE_NUMBER, DIALOG_STYLE_INPUT, "Contact Change Name", sprintf("ERROR: Kamu hanya bisa memasukan angka!\n\nContact Name : {ffff00}%s{ffffff}\n\nMasukan nama yang ingin kamu ganti:\n", ContactData[playerid][cid][cName]), "Change", "Back");

			ContactData[playerid][cid][cNumber] = number;
			SendInfoMessage(playerid, "Kamu telah mengubah contact number {ffff00} %s(%d){ffffff}.", ContactData[playerid][cid][cName], ContactData[playerid][cid][cNumber]);
			Contact_List(playerid);
		}
		else
			ShowPlayerDialog(playerid, DIALOG_CONTACT_MENU, DIALOG_STYLE_TABLIST, sprintf("Contact: %s", ContactData[playerid][cid][cName]), "\
				Change Name\n\
				Change Number\n\
				Call\n\
				Message\n\
				Remove Contact\n", "Select", "Back");
	}
	if(dialogid == DIALOG_CONTACT_MESSAGE)
	{
		if(response)
		{
			new cid = GetPVarInt(playerid, "cid");
			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_CONTACT_MESSAGE, DIALOG_STYLE_INPUT, "Contact Message", sprintf("Contact Name : {ffff00}%s{ffffff}\nContact Number : {ffff00}%d{ffffff}\n\nMasukan pesan yang ingin kamu kirim:\n", ContactData[playerid][cid][cName], ContactData[playerid][cid][cNumber]), "Message", "Back");

			callcmd::sms(playerid, sprintf("%d %s", ContactData[playerid][cid][cNumber], inputtext));
		}
	}
	return 1;
}