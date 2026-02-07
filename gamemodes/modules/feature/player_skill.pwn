// Player Skill (Skills)
// by Fann (XaeraPride Developer)

enum e_playerskill_data
{
	sID,
	sName[32],
	sLevel,
	sExp,

	// not saved
	bool:sExist
};

enum e_skill_data
{
	sName[32],
	sDescription[128]
};

new const SkillsData[][e_skill_data] =
{
    {"Fishing Ability", "Decreases time to catch fish, probably leading to catch better fish."},
    {"Cooking Ability", "Improves quality of cooked food, and probably decreases ingredients needed."},
    {"Mechanic Ability", "Increases vehicle repair speed and unlock some modify part."},
    {"Negotiate Ability", "Better prices when buying/selling items."},
    {"Medical Ability", "Enhances healing speed and effectiveness of medical items, and increases HP when using medical items."}
};

new    
    SkillData[MAX_PLAYERS][MAX_SKILLS][e_playerskill_data]
;

Skill_Load(playerid)
{
    mysql_query(g_SQL, sprintf("SELECT * FROM `player_skill` WHERE owner = '%d'", PlayerData[playerid][pID]), true);

    new rows = cache_num_rows();
    if(rows) forex(fan, rows)
    {
        cache_get_value_name_int(fan, "id", SkillData[playerid][fan][sID]);
        cache_get_value_name(fan, "name", SkillData[playerid][fan][sName]);
        cache_get_value_name_int(fan, "level", SkillData[playerid][fan][sLevel]);
        cache_get_value_name_int(fan, "exp", SkillData[playerid][fan][sExp]);

        SkillData[playerid][fan][sExist] = true;
    }
    printf("[SKILL] loaded %d skills for %s", rows, PlayerData[playerid][pName]);
    return 1;
}

Skill_Save(playerid, skillid = -1)
{
    if(skillid == -1)
    {
        forex(i, MAX_SKILLS)
        {
            if(SkillData[playerid][i][sExist])
            {
                mysql_tquery(g_SQL, sprintf("UPDATE `player_skill` SET name = '%s', level = '%d', exp = '%d' WHERE ownerid = '%d' AND id = '%d'",
                    SQL_EscapeString(SkillData[playerid][i][sName]),
                    SkillData[playerid][i][sLevel],
                    SkillData[playerid][i][sExp],
                    PlayerData[playerid][pID],
                    SkillData[playerid][i][sID]
                ));
            }
        }
        printf("[SERVER-OUTPUT] Skill_Save(): has saved skills for %s", PlayerData[playerid][pName]);
    }
    else 
    {
        if(SkillData[playerid][skillid][sExist])
        {
            mysql_tquery(g_SQL, sprintf("UPDATE `player_skill` SET name = '%s', level = '%d', exp = '%d' WHERE owner = '%d' AND id = '%d'",
                SQL_EscapeString(SkillData[playerid][skillid][sName]),
                SkillData[playerid][skillid][sLevel],
                SkillData[playerid][skillid][sExp],
                PlayerData[playerid][pID],
                SkillData[playerid][skillid][sID]
            ));
        }
        printf("[SERVER-OUTPUT] Skill_Save(): has saved skills for %s", PlayerData[playerid][pName]);
    }
    return 1;
}

Skill_Has(playerid, const skill_name[])
{
    forex(i, MAX_SKILLS)
    {
        if(SkillData[playerid][i][sExist] && !strcmp(SkillData[playerid][i][sName], skill_name))
        {
            return 1;
        }
    }
    return 0;
}

Skill_GetLevel(playerid, const skill_name[])
{
    if(Skill_Has(playerid, skill_name))
    {
        forex(i, MAX_SKILLS)
        {
            if(!strcmp(SkillData[playerid][i][sName], skill_name))
            {
                return SkillData[playerid][i][sLevel];
            }
        }
    }
    return -1;
}

Skill_GetID(playerid, const skill_name[])
{
    if(Skill_Has(playerid, skill_name))
    {
        forex(i, MAX_SKILLS)
        {
            if(!strcmp(SkillData[playerid][i][sName], skill_name))
            {
                return i;
            }
        }
    }
    return -1;
}

Skill_GetFreeID(playerid)
{
    forex(i, MAX_SKILLS)
    {
        if(!SkillData[playerid][i][sExist])
        {
            return i;
        }
    }
    return -1;
}

Skill_Get(playerid, skillid)
{
    new fanstr[385], progress[385];
    if(SkillData[playerid][skillid][sExist])
    {
        format(fanstr, sizeof(fanstr), "[{ffffff}]");

        forex(fan, 30)
        {
            if(SkillData[playerid][skillid][sExp] >= ((SkillData[playerid][skillid][sLevel] * 30 - 30)+(fan+1)))
            {
                strcat(progress, "{00ff00}|");
            }
            else
            {
                strcat(progress, "{808080}-");
            }
        }

        strins(fanstr, progress, 1);
    }
    return fanstr;
}

Skill_NameValid(const skill_name[])
{
    forex(i, MAX_SKILLS)
    {
        if(!strcmp(SkillsData[i][sName], skill_name))
        {
            return 1;
        }
    }
    return 0;
}

Skill_Earned(playerid, const skill_name[], expamount, lvl = 0)
{
    new skillid;
    if((skillid = Skill_GetID(playerid, skill_name)) != -1)
    {
        SkillData[playerid][skillid][sExp] += expamount;
        if(SkillData[playerid][skillid][sExp] >= (SkillData[playerid][skillid][sLevel] * 30))
        {
            if(SkillData[playerid][skillid][sLevel] < 10)
            {
                SkillData[playerid][skillid][sLevel]++;
                SkillData[playerid][skillid][sExp] = 0;
                SendInfoMessage(playerid, "Skill {ffff00}%s{ffffff} telah naik menjadi {00ff00}level %d{ffffff}!", skill_name, SkillData[playerid][skillid][sLevel]);
            }
            else
            {
                SkillData[playerid][skillid][sExp] = (SkillData[playerid][skillid][sLevel] * 30);
            }
        }
        Skill_Save(playerid, skillid);
        return 1;
    }
    else
    {
        if((skillid = Skill_GetFreeID(playerid)) != -1)
        {
            if(!Skill_NameValid(skill_name))
            {
                SendErrorMessage(playerid, "Invalid skill name!");
                return 0;
            }
            SkillData[playerid][skillid][sExist] = true;
            format(SkillData[playerid][skillid][sName], 32, skill_name);

            if(lvl == 0)
                SkillData[playerid][skillid][sLevel] = 1;
            else
            {
                SkillData[playerid][skillid][sLevel] = lvl;
                expamount = SkillData[playerid][skillid][sLevel] * 30 - 30; // auto set exp ke 30(default) sebelum level up atau bisa dibilang 0 di level tersebut
            }

            SkillData[playerid][skillid][sExp] = expamount;

            mysql_tquery(g_SQL, sprintf("INSERT INTO `player_skill` (owner) VALUES(%d)", PlayerData[playerid][pID]), "Skill_Created", "ii", playerid, skillid);
            return 1;
        }
    }
    SendErrorMessage(playerid, "Skill sudah penuh");
    return 0;
}

public:Skill_Created(playerid, skillid)
{
    SkillData[playerid][skillid][sID] = cache_insert_id();
    Skill_Save(playerid, skillid);
    return 1;
}

Skill_Default(playerid)
{
    Skill_Earned(playerid, "Fishing Ability", 0);
    Skill_Earned(playerid, "Cooking Ability", 0);
    Skill_Earned(playerid, "Mechanic Ability", 0);
    if(random(100)+1 > 90) // 10% chance to start with player have Negotiate Ability
    {
        Skill_Earned(playerid, "Negotiate Ability", 0);
    }
    if(random(100)+1 > 50) // 50% chance to start with player have Medical Ability
    {
        switch(random(100)+1)
        {
            case 80..89: Skill_Earned(playerid, "Medical Ability", 0, 2); // 10% will get level 2
            case 90..99: Skill_Earned(playerid, "Medical Ability", 0, 4); // 10% will get level 4
            case 100: Skill_Earned(playerid, "Medical Ability", 0, 10); // 1% will get level 10
            default: Skill_Earned(playerid, "Medical Ability", 0); // 1-79% will get level 1
        }
    }
    return 1;
}

Skill_PlayerShow(playerid, targetid = 5000)
{
    if(!IsPlayerLogged(targetid))
        targetid = playerid;

    new fanstr[5000];

    strcat(fanstr, "No\tSkill\tLevel\tProgress\n");
    forex(i, MAX_SKILLS) 
    {
        if(SkillData[targetid][i][sExist])
        {
            format(fanstr, sizeof(fanstr), "%s%d\t%s\t%d\t%s\n", fanstr, i+1, SkillData[targetid][i][sName], SkillData[targetid][i][sLevel], Skill_Get(targetid, i));
        }
    }
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Your Skills", fanstr, "OKAY", "");
    return 1;
}

Skill_PlayerHasDefault(playerid)
{
    if(Skill_Has(playerid, "Fishing Ability") &&
       Skill_Has(playerid, "Cooking Ability") &&
       Skill_Has(playerid, "Mechanic Ability"))
    {
        return 1;
    }
    return 0;
}

Skill_GetSkillsID(const skill_name[])
{
    forex(i, sizeof(SkillsData)) if(!strcmp(SkillsData[i][sName], skill_name))
        return i;

    return -1;
}

CMD:skills(playerid, params[])
{
    Skill_PlayerShow(playerid);
    return 1;
}

CMD:addskill(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 6)
        return PermissionError(playerid);
    
    new targetid, skill_name[32];
    if(sscanf(params, "us[32]", targetid, skill_name))
        return SendSyntaxMessage(playerid, "/addskill [player id/name] [skill name]");

    if(Skill_GetSkillsID(skill_name) == -1)
        return SendErrorMessage(playerid, "Skill Name is doesn't exist");

    if(!IsPlayerLogged(targetid))
        return SendErrorMessage(playerid, "Player tersebut tidak ada di server!");

    new skillexp = 0;
    if(Skill_Has(targetid, skill_name))
        skillexp = SkillData[playerid][Skill_GetID(playerid, skill_name)][sExp];

    Skill_Earned(targetid, skill_name, skillexp);
    return 1;
}

CMD:fanskill(playerid, params[])
{
    forex(fan, MAX_SKILLS) if(SkillData[playerid][fan][sExist])
    {
        SkillData[playerid][fan][sID] = 0;
        SkillData[playerid][fan][sLevel] = 0;
        SkillData[playerid][fan][sExp] = 0;

        SkillData[playerid][fan][sExist] = false;
    }
    mysql_tquery(g_SQL, sprintf("DELETE FROM `player_skill` WHERE owner = '%d'", PlayerData[playerid][pID]));

    Skill_Default(playerid);
    InfoTD_MSG(playerid, 5000, "New Skill ~g~applied~w~!");
    return 1;
}

CMD:editskills(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    new skillid, string[128], amount;
    if(sscanf(params, "ds[128]d", skillid, string, amount))
    {
        SendSyntaxMessage(playerid, "/editskills [skillid] [level/exp] [value]");
        return 1;
    }

    if(!SkillData[playerid][skillid][sExist])
        return SendErrorMessage(playerid, "Skill tersebut tidak ada!");

    if(!strcmp(string, "level"))
    {
        if(amount < 1) amount = 1;
        if(amount > 10) amount = 10;
        
        if(amount > 1)
            SkillData[playerid][skillid][sExp] = (SkillData[playerid][skillid][sExp]/(30*SkillData[playerid][skillid][sLevel])) +  ((amount * 30) - 30); // set exp sesuai dengan level (level 2 = 60 exp - 30 = 0(di level tersebut))

        SkillData[playerid][skillid][sLevel] = amount;
    }
    else if(!strcmp(string, "exp"))
    {
        if(amount < 0) 
            amount = 0;

        if(amount >= 30)
            amount = 29;

        if(SkillData[playerid][skillid][sLevel] > 1) 
            amount = ((SkillData[playerid][skillid][sLevel] * 30) - 30) + amount; // set exp sesuai dengan level (level 2 = 60 exp - 30 = 0(di level tersebut) + amount = exp yang diinput admin)

        SkillData[playerid][skillid][sExp] = amount;
    }
    else
        return SendSyntaxMessage(playerid, "/editskills [skillid] [level/exp] [value]");

    Skill_Save(playerid, skillid);
    SendAdminMessage(COLOR_LRED, "AdmCmd: %s has edited %s's %s to %d", GetAName(playerid), SkillData[playerid][skillid][sName], string, amount);
    return 1;
}

Skill_IncreasePercentBySkillLevel(playerid, const skill_name[], base_chance)
{
    new skillid = Skill_GetID(playerid, skill_name);
    if(skillid != -1)
    {
        return base_chance + (SkillData[playerid][skillid][sLevel] * 2); // each skill level adds 2% chance
    }
    return base_chance;
}