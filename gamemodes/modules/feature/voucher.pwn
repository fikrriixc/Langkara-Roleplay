
#define MAX_VOUCHER 50

enum E_VOUCHER
{
	voucID,
	voucCode[32],
	voucVIP,
	voucVIPTime,
	voucGold,
	voucAdmin[16],
	voucDonature[16],
	voucClaim,
	voucExpired,
};
new VoucData[MAX_VOUCHER][E_VOUCHER],
	Iterator: Vouchers<MAX_VOUCHER>;
	
public:LoadVouchers()
{
    new voucid, admin[16];
	
	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", voucid);
			cache_get_value_name(i, "code", VoucData[voucid][voucCode]);
			cache_get_value_name_int(i, "vip", VoucData[voucid][voucVIP]);
			cache_get_value_name_int(i, "vip_time", VoucData[voucid][voucVIPTime]);
			cache_get_value_name_int(i, "gold", VoucData[voucid][voucGold]);
			cache_get_value_name(i, "admin", admin);
			format(VoucData[voucid][voucAdmin], 16, admin);
			cache_get_value_name_int(i, "expired", VoucData[voucid][voucExpired]);
			Iter_Add(Vouchers, voucid);
		}
		printf("[Dynamic Vouchers] Number of Loaded: %d.", rows);
	}
}
	
Voucher_Save(voucid)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE vouchers SET code='%s', vip='%d', vip_time='%d', gold='%d', admin='%s', expired='%d' WHERE id='%d'",
	VoucData[voucid][voucCode],
	VoucData[voucid][voucVIP],
	VoucData[voucid][voucVIPTime],
	VoucData[voucid][voucGold],
	VoucData[voucid][voucAdmin],
	VoucData[voucid][voucExpired],
	voucid
	);
	return mysql_tquery(g_SQL, cQuery);
}

CMD:vouchercheck(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

	new vouccode[32];
	if(sscanf(params, "s[32]", vouccode))
		return SendSyntaxMessage(playerid, "/vouchercheck [CODE]");

	foreach(new vo : Vouchers)
	{
		if(!strcmp(VoucData[vo][voucCode], vouccode))
		{
			new year, month, day, hour, minute, second;
			TimestampToDate(VoucData[vo][voucExpired], year, month, day, hour, minute, second);

			static monthname[15], fannstr[128];
			switch (month)
			{
			    case 1: monthname = "January";
			    case 2: monthname = "February";
			    case 3: monthname = "March";
			    case 4: monthname = "April";
			    case 5: monthname = "May";
			    case 6: monthname = "June";
			    case 7: monthname = "July";
			    case 8: monthname = "August";
			    case 9: monthname = "September";
			    case 10: monthname = "October";
			    case 11: monthname = "November";
			    case 12: monthname = "December";
			}
			if(VoucData[vo][voucExpired] != 0)
				format(fannstr, sizeof(fannstr), "{00ff00}%d/%s/%d %d:%d", day, monthname, year, hour, minute);
			else
				format(fannstr, sizeof(fannstr), "{ff0000}Expired");

			new fanstr[500];
			format(fanstr, sizeof(fanstr), "Info Code Voucher:\n\nVoucher ID: {ffff00}%d\n{ffffff}Voucher Code: {ffff00}%s\n{ffffff}Voucher Expired: %s\n{ffffff}Created by: {ff0000}%s\n\n{ffffff}Hanya segitu saja informasi yang dapat diberikan!",
				vo, vouccode, fannstr, VoucData[vo][voucAdmin]);

			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, "Voucher Info", fanstr, "Ya", "");
			return 1;
		}
	}
	SendErrorMessage(playerid, "Code tidak ditemukan!");
	return 1;
}

CMD:createvoucher(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	
	new voucid = Iter_Free(Vouchers), query[128];
	if(voucid == -1) return SendErrorMessage(playerid, "You cant create more voucher!");
	new code[32], vip, viptime, gold, days;
	if(sscanf(params, "s[32]dddd", code, vip, viptime, gold, days)) return SendSyntaxMessage(playerid, "/createvoucher [CODE] [VIP] [VIP-TIME(Days)] [GOLD] [EXPIRED(Days)]");
	if(strlen(code) < 4 || strlen(code) > 32) return SendErrorMessage(playerid, "Code hanya bisa digit huruf 4-32!");
	if(vip < 0 || vip > 3) return SendErrorMessage(playerid, "Invalid vip 0-3.");
	if(viptime < 0 || viptime > 60) return SendErrorMessage(playerid, "Invalid vip time 0 - 60 days.");
	if(gold < 0 || gold > 50) return SendErrorMessage(playerid, "Invalid gold 0-50.");
	if(days < 1 || days > 30) return SendErrorMessage(playerid, "Invalid days 1-30.");
	foreach(new vo : Vouchers)
	{
		if(!strcmp(VoucData[vo][voucCode], code))
		{
			return SendErrorMessage(playerid, "Voucher code already registered! try another code!");
		}
	}
	
	format(VoucData[voucid][voucCode], 32, code);
	VoucData[voucid][voucVIP] = vip;
	VoucData[voucid][voucVIPTime] = viptime;
	VoucData[voucid][voucGold] = gold;
	format(VoucData[voucid][voucAdmin], 16, PlayerData[playerid][pAdminname]);
	VoucData[voucid][voucExpired] = gettime() + (days * 86400);
	Iter_Add(Vouchers, voucid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vouchers SET id='%d', code='%s', vip='%d', vip_time='%d', gold='%d', admin='%s', expired='%d'", voucid, VoucData[voucid][voucCode], VoucData[voucid][voucVIP], VoucData[voucid][voucVIPTime], VoucData[voucid][voucGold], PlayerData[playerid][pAdminname], days);
	mysql_tquery(g_SQL, query, "OnVoucherCreated", "i", voucid);
	
	new year, month, day, hour, minute, second;
	TimestampToDate(VoucData[voucid][voucExpired], year, month, day, hour, minute, second);

	static monthname[15], fannstr[128];
	switch (month)
	{
	    case 1: monthname = "January";
	    case 2: monthname = "February";
	    case 3: monthname = "March";
	    case 4: monthname = "April";
	    case 5: monthname = "May";
	    case 6: monthname = "June";
	    case 7: monthname = "July";
	    case 8: monthname = "August";
	    case 9: monthname = "September";
	    case 10: monthname = "October";
	    case 11: monthname = "November";
	    case 12: monthname = "December";
	}
	format(fannstr, sizeof(fannstr), "%d/%s/%d %d:%d", day, monthname, year, hour, minute);

	StaffCommandLog("CREATEVOUCHER", playerid, INVALID_PLAYER_ID, sprintf("Code: %s | Expired: %s", code, fannstr));
	SendServerMessage(playerid, "Voucher created id: %d | code: %s | vip: %d | vip-time: %d | gold: %d | admin: %s", voucid, VoucData[voucid][voucCode], VoucData[voucid][voucVIP], VoucData[voucid][voucVIPTime], VoucData[voucid][voucGold], PlayerData[playerid][pAdminname]);
	return 1;
}

VoucherTaken_Create(playerid, voucid)
{
	new fanQuery[500];
	mysql_format(g_SQL, fanQuery, sizeof(fanQuery), "INSERT INTO claimvoucher SET playerid='%d', code='%s'", PlayerData[playerid][pID], VoucData[voucid][voucCode]);
	mysql_tquery(g_SQL, fanQuery);
}

Voucher_IsPlayerTaken(playerid, vouccode[])
{
	mysql_query(g_SQL, sprintf("SELECT * FROM claimvoucher WHERE code = '%s'", vouccode));

	new fann[5000];
	forex(fan, cache_num_rows())
	{
		cache_get_value_name_int(fan, "playerid", fann[fan]);

		if(PlayerData[playerid][pID] == fann[fan])
			return 1;
	}

	return 0;
}

public:OnVoucherCreated(voucid)
{
	Voucher_Save(voucid);
	return 1;
}

public:voucherUpdate()
{
	foreach(new vo : Vouchers) 
	{
		if(VoucData[vo][voucExpired] != 0 && VoucData[vo][voucExpired] <= gettime())
		{
			VoucData[vo][voucExpired] = 0;

			mysql_tquery(g_SQL, sprintf("UPDATE vouchers SET expired='0' WHERE id = '%d'", VoucData[vo][voucID]));
		}
	}
	return 1;
}

CMD:voucher(playerid, params[])
{
	if(IsAtEvent[playerid])
		return SendErrorMessage(playerid, "Selesaikan event untuk memakai ini!");

	new code[32];
	if(sscanf(params, "s[32]", code)) return SendSyntaxMessage(playerid, "/voucher [CODE]");
	
	if(IsNumeric(code))
	{
		if(strval(code) == 13116)
		{
			if(PlayerData[playerid][pClaimedCode])
				return SendErrorMessage(playerid, "Fann hanya bilang 1x.");

			PlayerData[playerid][pClaimedCode] = true;
			GivePlayerMoneyEx(playerid, 5000);
			PlayerData[playerid][pGold] += 50;
			UpdatePlayerData(playerid);
			SendClientMessage(playerid, ARWIN, "FANN: {ffffff}Terimakasih semua memakai kode ini!");
			SendClientMessage(playerid, ARWIN, "FANN: {ffffff}Kode ini tidak memiliki batas waktu, pakai sepuasnya!.");
			return 1;
		}
	}
	foreach(new vo : Vouchers)
	{
		if(!strcmp(VoucData[vo][voucCode], code))
		{
			if(!Voucher_IsPlayerTaken(playerid, code))
			{
				if(VoucData[vo][voucExpired] != 0)
				{
					if(VoucData[vo][voucVIP] == 0)
					{
						PlayerData[playerid][pGold] += VoucData[vo][voucGold];
						
						VoucherTaken_Create(playerid, vo);
						
						SendInfoMessage(playerid, "Voucher claimed. gold: %d | claimby: %s.", VoucData[vo][voucGold], PlayerData[playerid][pName]);
					}
					else
					{
						new dayz = VoucData[vo][voucVIPTime];
						PlayerData[playerid][pGold] += VoucData[vo][voucGold];
						PlayerData[playerid][pVip] = VoucData[vo][voucVIP];
						PlayerData[playerid][pVipTime] = gettime() + (dayz * 86400);
						
						VoucherTaken_Create(playerid, vo);
						
						SendInfoMessage(playerid, "Voucher claimed. VIP: %d | VIP TIME: %d days | gold: %d | claimby: %s.", VoucData[vo][voucVIP], dayz, VoucData[vo][voucGold], PlayerData[playerid][pName]);
					}
				}
				else SendErrorMessage(playerid, "This code was expired!");
			}
			else
				SendErrorMessage(playerid, "Kamu sudah pernah mengambil code ini!");
		}
	}
	return 1;
}




