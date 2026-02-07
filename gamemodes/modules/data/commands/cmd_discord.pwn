// Commands those needed in HopePride Features in Discord
// buat sementara doang, nanti make bot js
// by Fann

#define DCMD_PREFIX '!'

#include <YSI_Coding\y_hooks>   // by Y_Less

#tryinclude <discord-connector> // by maddinat0r
#tryinclude <discord-cmd>       // by AkshayMohan

new 
    // Discord Server
    DCC_Guild:HP_Guild,
    // Discord Role
    DCC_Role:role_warga,
    // Discord Channel
    DCC_Channel:MakeUCP
;

// hook
hook OnGameModeInit() 
{
    HP_Guild = DCC_FindGuildById("1439533544799211636");

    role_warga = DCC_FindRoleById("1439533544799211637");

    MakeUCP = DCC_FindChannelById("1454351022083539096");

    DCC_SetBotActivity("HopePride asik.");
    return 1;
}

DCMD:register(user, channel, params[]) 
{
    if(channel != MakeUCP)
        return DCC_SendChannelMessage(channel, ":x: Kamu tidak di channel yang sudah ditentukan!");

    if(isempty(params))
        return DCC_SendChannelMessage(channel, "**SYNTAX**: !register [UCP Name]");

    if(strlen(params) < 4 || strlen(params) > 32)
        return DCC_SendChannelMessage(channel, "## :x: Kamu harus memasukan nama :\nMinimal panjang : 4\nMaksimal panjang : 32");

    if(IsValidRoleplayName(params))
        return DCC_SendChannelMessage(channel, ":x: Nama UCP tidak boleh memakai nama Roleplay/Karakter!");

    new userid[DCC_ID_SIZE];
    DCC_GetUserId(user, userid);

    mysql_tquery(g_SQL, sprintf("SELECT * FROM `ucp` WHERE `discordid` = '%s'", SQL_EscapeString(userid)), "OnUserCheck", "ss", userid, params);
    return 1;
}

public:OnUserCheck(userid[], ucpname[]) 
{
    if(cache_num_rows() > 0)
    {
        new user_registered[MAX_PLAYER_NAME];
        cache_get_value_name(0, "username", user_registered);

        DCC_SendChannelMessage(MakeUCP, sprintf(":x: Kamu sudah pernah mendaftar UCP di HopePride sebagai **%s**!", user_registered));
    }
    else
    {
        mysql_tquery(g_SQL, sprintf("SELECT * FROM `ucp` WHERE `username` = '%s'", SQL_EscapeString(ucpname)), "OnUserNameCheck", "ss", userid, ucpname);
    }
    return 1;
}

public:OnUserNameCheck(userid[], ucpname[]) 
{
    if(cache_num_rows() > 0)
    {
        DCC_SendChannelMessage(MakeUCP, sprintf(":x: Nama **%s** sudah pernah terdaftar!\nMasikan yang lain.", ucpname));
    }
    else
    {
        new code[10], DCC_User:user = DCC_FindUserById(userid);
        format(code, sizeof(code), "HP-%d", RandomEx(111111, 999999));

        DCC_AddGuildMemberRole(HP_Guild, user, role_warga);
        DCC_SetGuildMemberNickname(HP_Guild, user, ucpname);

        DCC_SendChannelMessage(MakeUCP, sprintf("## Pendaftaran UCP sebagai **%s** telah berhasil dibuat!\nCheck **__Direct Message__** dari BOT HopePride sekarang!", ucpname));
		DCC_CreatePrivateChannel(user, "OnDMAfterRegister", "sss", ucpname, code, userid);
        mysql_tquery(g_SQL, sprintf("INSERT INTO `ucp` (`username`, `verifycode`, `discordid`, `registerdate`) VALUES('%s', '%s', '%s', CURRENT_TIMESTAMP())", SQL_EscapeString(ucpname), SQL_EscapeString(code), SQL_EscapeString(userid)));
    }
    return 1;
}

public:OnDMAfterRegister(ucpname[], code[], userid[])
{
    new DCC_Channel:PM, DCC_Embed:embed;
	PM = DCC_GetCreatedPrivateChannel();
    embed = DCC_CreateEmbed();

	new str1[1000], str2[1000];

    format(str1, sizeof str1, "HopePride Registry");
    DCC_SetEmbedTitle(embed, str1);
	format(str1, sizeof str1, "Terimakasih telah melakukan pendaftaran UCP di HopePrice.\nBerikut data akun UCP-mu:");
	DCC_SetEmbedDescription(embed, str1);
	format(str1, sizeof str1, "UCP NAME");
	format(str2, sizeof str2, "```%s```", ucpname);
	DCC_AddEmbedField(embed, str1, str2, true);
	format(str1, sizeof str1, "VERIFY CODE");
	format(str2, sizeof str2, "```%s```\nSalin kode tersebut untuk Verifikasi In-Game.", code);
	DCC_AddEmbedField(embed, str1, str2, true);
	DCC_SetEmbedColor(embed, 0x0077FF);

	DCC_SendChannelEmbedMessage(PM, embed);
    DCC_SendChannelMessage(PM, sprintf("Selamat melakukan Roleplay-mu di HopePride, <@%s>!\nJangan lupa membaca peraturan server sebelum bermain :)\n\n- Harm Regards", userid));
    return 1;
}