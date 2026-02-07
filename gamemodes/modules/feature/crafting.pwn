// Modified from LRP by Fann
#include <YSI_Coding\y_hooks>

enum E_CRAFT_DATA
{
	WEAPON:cGun,
	cAmmo,
	cMat,
	cComp,
	cPrice
};

new const CraftingData[][E_CRAFT_DATA] =
{
	//Gun				Ammo	Mat		Comp	Price
	{WEAPON_SILENCED,	70,   200,	   150,	   5000},		
	{WEAPON_COLT45,   70,	   100,	   100,	   500},		
	{WEAPON_DEAGLE,		70,		300,	350,	7000},		
	{WEAPON_SHOTGUN,	50,		500,	500,	8000}	
};

CreateArmsPoint()
{
	new strings[128];
	CreateDynamicPickup(1239, 23, 525.2413, -2335.4072, 508.6937, -1);
	format(strings, sizeof(strings), "{7fffd4}[Black Market]\n{ffff00}/crafting {FFFFFF}- Create Illegal Weapons");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 525.2413, -2335.4072, 508.6937, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
}

CMD:crafting(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, 525.2413, -2335.4072, 508.6937)) return SendErrorMessage(playerid, "Kamu harus diblackmarket!");
	if(PlayerData[playerid][pLevel] < 3) return SendErrorMessage(playerid, "Kamu tidak memiliki skill crafting.");
	
	new Dstring[512];
	format(Dstring, sizeof(Dstring), "Weapon\tMats\tComp\tPrice\n");
	forex(fan, sizeof(CraftingData))
	{
		format(Dstring, sizeof(Dstring), "%s{ffffff}%s\t%d\t%d\t{00ff00}%s\n", Dstring, ReturnWeaponName(CraftingData[fan][cGun]), CraftingData[fan][cMat], CraftingData[fan][cComp], FormatMoney(CraftingData[fan][cPrice]));
	}
	ShowPlayerDialog(playerid, DIALOG_ARMS_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Create Gun", Dstring, "Create", "Cancel");
	return 1;
}

public:CreateGun(playerid, WEAPON:gunid, ammo)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(PlayerData[playerid][pArmsDealer])) return 0;
	if(gunid == WEAPON_FIST || ammo == 0) return 0;
	if(PlayerData[playerid][pActivityTime] >= 100)
	{
		GivePlayerWeaponEx(playerid, gunid, ammo);
		
		SendInfoMessage(playerid, "Anda telah berhasil membuat senjata ilegal.");
		TogglePlayerControllable(playerid, true);
		InfoTD_MSG(playerid, 8000, "Weapon Created!");
		KillTimer(PlayerData[playerid][pArmsDealer]);
		PlayerData[playerid][pActivityTime] = 0;
		HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		PlayerData[playerid][pEnergy] -= 3;
		return 1;
	}
	else if(PlayerData[playerid][pActivityTime] < 100)
	{
		PlayerData[playerid][pActivityTime] += 5;
		SetPlayerProgressBarValue(playerid, PlayerData[playerid][activitybar], PlayerData[playerid][pActivityTime]);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, false, false, false, false, 0, SYNC_ALL);
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	//ARMS Dealer
	if(dialogid == DIALOG_ARMS_GUN)
	{
		if(response)
		{
			if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "Anda masih memiliki activity progress!");
			if(Inventory_Has(playerid, "Material") < CraftingData[listitem][cMat]) return SendErrorMessage(playerid, "Material tidak cukup!(Butuh: 500).");
			if(Inventory_Has(playerid, "Component") < CraftingData[listitem][cComp]) return SendErrorMessage(playerid, "Component tidak cukup!(Butuh: 500).");
			if(GetPlayerMoney(playerid) < CraftingData[listitem][cPrice]) return SendErrorMessage(playerid, "Not enough money!");
			if(PlayerHasWeaponInSlot(playerid, CraftingData[listitem][cGun]))
				return SendErrorMessage(playerid, "Kamu sudah memiliki senjata tipe yang sama!");

			Inventory_Remove(playerid, "Material", CraftingData[listitem][cMat]);
			Inventory_Remove(playerid, "Component", CraftingData[listitem][cComp]);
			GivePlayerMoneyEx(playerid, -CraftingData[listitem][cPrice]);
			
			TogglePlayerControllable(playerid, false);
			SendInfoMessage(playerid, "Anda membuat senjata ilegal dengan %d material dan %d component dengan harga %s!", CraftingData[listitem][cMat], CraftingData[listitem][cComp], FormatMoney(CraftingData[listitem][cPrice]));
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, false, false, false, false, 0, SYNC_ALL);
			PlayerData[playerid][pArmsDealer] = SetTimerEx("CreateGun", 1000, true, "idd", playerid, CraftingData[listitem][cGun], CraftingData[listitem][cAmmo]);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Creating...");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
		}
		return 1;
	}
	return 1;
}