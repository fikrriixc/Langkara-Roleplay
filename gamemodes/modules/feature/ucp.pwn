
ShowCharacterMenu(playerid) 
{
    new name[500], count, fann_max = MAX_CHARACTERS;

    if(!strcmp(UcpData[playerid][uUsername], "Fann"))
    {
        fann_max += 5;
    }

    for (new i; i < fann_max; i ++) if(!isempty(CharacterList[playerid][i])) 
    {
        strcat(name, sprintf("%s\t%d\t%s\n", CharacterList[playerid][i], CharacterLevel[playerid][i], CharacterLastLogin[playerid][i]), sizeof(name));
        count++;
    }

    if(count < fann_max)
        strcat(name, "{ffff00}( New Character )");

    if(count < 1)
        ShowPlayerDialog(playerid, DIALOG_SELECTCHAR, DIALOG_STYLE_LIST, "Character List", name, "Select", "Quit");
    else
    {
        strins(name, "Name\tLevel\tLast Login\n", 0);
        ShowPlayerDialog(playerid, DIALOG_SELECTCHAR, DIALOG_STYLE_TABLIST_HEADERS, "Character List", name, "Select", "Quit");
    }
    return 1;
}

public:OnCharacterLoaded(playerid) 
{
    if(cache_num_rows() > 0) for (new i = 0; i < cache_num_rows(); i ++)
    {
        cache_get_value_name(i, "username", CharacterList[playerid][i], MAX_PLAYER_NAME + 1);
        cache_get_value_name_int(i, "level", CharacterLevel[playerid][i]);
        cache_get_value_name(i, "last_login", CharacterLastLogin[playerid][i], 50);
    }

    ShowCharacterMenu(playerid);
}