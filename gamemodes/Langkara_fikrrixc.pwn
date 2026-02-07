//////////////////////////////////////////////////////////////////
/*			 
		 __  __                 ____       _     __   
		/ / / /___  ____  ___  / __ \_____(_)___/ /__ 
	   / /_/ / __ \/ __ \/ _ \/ /_/ / ___/ / __  / _ \							
	  / __  / /_/ / /_/ /  __/ ____/ /  / / /_/ /  __/
	 /_/ /_/\____/ .___/\___/_/   /_/  /_/\__,_/\___/ Roleplay
				/_/                                   
			 ____________________________
			|							 |
			| Inspired by : LunarPride   |
			| GameBase 	  : LRP V10		 |
			| Operator 	  : Vall & Fann	 |
			| Developer	  : Fann   		 |
			| Thank to    : 			 |
			| - God 					 |
			| - Parents 			     |
			| - All of Pl&Inc creadit 	 |
			| - Dandy for basic LRP 	 |
			| - Pateer for LRP v10 		 |
			| - Fann for Script			 |
			| - HopePride Staff 		 |
			| - HopePride Member 		 |
			|____________________________|

		transformed to Open.MP server by Fann.

		  ⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄ 
        ⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄ 
        ⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄ 
        ⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰ 
        ⣖⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤ 
        ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗ 
        ⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄
        ⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠄
        ⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃⠄ 
        ⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃⠄⠄ 
        ⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁⠄⠄⠄ 
        ⠄⠄⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁⠄⠄⠄⠄⠄ 
        ⠄⠄⠄⠄⠄⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁⠄⠄⠄⠄⠄⢀⣠⣴ 
        ⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣠                        
                                                       

		All rights reserved © HP:RP 2025

		hapus/ubah creadit? drama sini.
*/
//////////////////////////////////////////////////////////////////

#define CGEN_MEMORY 80000
#define MIXED_SPELLINGS

#define TRYG3D_ENABLE_COLANDREAS
#define TRYG3D_ENABLE_VEHICLE

#define FOREACH_NO_BOTS

#define FANN_USE_DYNAMIC ((16 * 8 / cellbits) + 65536)
#pragma dynamic FANN_USE_DYNAMIC

#define MAX_PLAYERS 50

#include <open.mp>

//#define under_maintenance

#define TEXT_VERSION "1.0.17 hoped"

#if defined under_maintenance
	#define TEXT_HOSTNAME "HopePride | Under Maintenance"
	#define TEXT_PASSWORD "fannmt2k25"
#else
	#define TEXT_HOSTNAME "HopePride Roleplay"
#endif

#define TEXT_GAMEMODE	"HopePride v"TEXT_VERSION""
#define TEXT_WEBURL		"hopepride-samp.my.id"
#define TEXT_LANGUAGE	"Indonesia/English"

#include <strlib.inc>
#include <crashdetect.inc>
#include <memory.inc>
#include <sscanf2.inc>
#include <streamer.inc>
#include <a_mysql.inc>
#include <callbacks.inc>
#include <progress2.inc>
#include <samp_bcrypt.inc>
#include <Pawn.CMD.inc>
#include <TimestampToDate.inc>
#include <ColAndreas.inc>
#include <3DTryg.inc>
#include <EVF2.inc>
#include <garageblock.inc>
#include <dini.inc>
#include <eSelection.inc>
#include <fFishCaught.inc>
#include <fLoadingScreen.inc>
#include <fMiniGame.inc>
#include <yom_buttons.inc>

#include <YSI_Data\y_iterate> // Foreach

#pragma warning disable 239, 214, 219

//-----[ Important Modular ]-----
#include "fann\extended_utils.pwn"

#include "modules\utils\utils_define.pwn"
#include "modules\utils\utils_macros.pwn"
#include "modules\utils\utils_database.pwn"

//----------[ Enum ]----------
enum _:E_EDITING_TYPE
{
	EDIT_NONE,
	EDIT_ATM,
	EDIT_TREE,
	EDIT_ORE,
	EDIT_GATE,
	EDIT_GRAFFITI,
}

enum _:E_MINIGAME_ID
{
	MINIGAME_TESTING,
	MG_ROB_ATM,
}

enum _:E_CARGO_TYPE
{
	CARGO_UNKNOWN,
	CARGO_COMPONENT,
	CARGO_MATERIAL,
	CARGO_FRESHMILK,
}

enum _:E_AREA_ID
{
	FIRE_AREA_INDEX,
}

enum _:E_SELECTION_ID
{
	TOYS_MODEL,
	VEHICLE_TOYS,
	VIPTOYS_MODEL, 
	SPAWN_MODEL_MALE,
	SPAWN_MODEL_FEMALE,
	SHOP_MODEL_MALE,
	SHOP_MODEL_FEMALE,
	VIP_MODEL_MALE,
	VIP_MODEL_FEMALE,
	SAPD_MODEL_MALE,
	SAPD_MODEL_FEMALE,
	SAPD_MODEL_WAR,
	SAGS_MODEL_MALE,
	SAGS_MODEL_FEMALE,
	SAMD_MODEL_MALE,
	SAMD_MODEL_FEMALE,
	SANA_MODEL_MALE,
	SANA_MODEL_FEMALE,
	SAFD_MODEL_MALE,
	SAFD_MODEL_FEMALE,
}

enum _:E_DIALOG_ID
{
	//---[ DIALOG PUBLIC ]---
	DIALOG_UNUSED,
    DIALOG_LOGIN,
    DIALOG_REGISTER,
    DIALOG_AGE,
	DIALOG_GENDER,
	DIALOG_EMAIL,
	DIALOG_PASSWORD,
	DIALOG_STATS,
	DIALOG_SETTINGS,
	DIALOG_HBEMODE,
	DIALOG_INVMODE,
	DIALOG_CHANGEAGE,
	//-----------------------
	DIALOG_GOLDSHOP,
	DIALOG_GOLDNAME,
	//---[ DIALOG BISNIS ]---
	DIALOG_SELL_BISNISS,
	DIALOG_SELL_BISNIS,
	DIALOG_MY_BISNIS,
	BISNIS_MENU,
	BISNIS_INFO,
	BISNIS_NAME,
	BISNIS_VAULT,
	BISNIS_WITHDRAW,
	BISNIS_DEPOSIT,
	BISNIS_BUYPROD,
	BISNIS_EDITPROD,
	BISNIS_PRICESET,
	//---[ DIALOG HOUSE ]---
	DIALOG_SELL_HOUSES,
	DIALOG_SELL_HOUSE,
	DIALOG_MY_HOUSES,
	HOUSE_INFO,
	HOUSE_STORAGE,
	HOUSE_WEAPONS,
	HOUSE_MONEY,
	HOUSE_WITHDRAWMONEY,
	HOUSE_DEPOSITMONEY,
	//---[ DIALOG PRIVATE VEHICLE ]---
	DIALOG_FINDVEH,
	DIALOG_TRACKVEH,
	DIALOG_GOTOVEH,
	DIALOG_GETVEH,
	DIALOG_DELETEVEH,
	DIALOG_BUYPV,
	DIALOG_BUYVIPPV,
	DIALOG_BUYPLATE,
	DIALOG_BUYPVCP,
	DIALOG_BUYPVCP_BIKES,
	DIALOG_BUYPVCP_CARS,
	DIALOG_BUYPVCP_UCARS,
	DIALOG_BUYPVCP_JOBCARS,
	DIALOG_BUYPVCP_VIPCARS,
	DIALOG_BUYPVCP_CONFIRM,
	DIALOG_BUYPVCP_VIPCONFIRM,
	DIALOG_RENT_JOBCARS,
	DIALOG_RENT_JOBCARSCONFIRM,
	DIALOG_VEHICLE_LOCK,
	//---[ DIALOG TEMPORARY ]---
	DIALOG_TEMP_TOY_BONE,
	DIALOG_TEMP_TOY_MAT1,
	DIALOG_TEMP_TOY_MAT2,
	//---[ DIALOG TOYS ]---
	DIALOG_TOY,
	DIALOG_TOYEDIT,
	DIALOG_TOYPOSISI,
	DIALOG_TOYPOSISIBUY,
	DIALOG_TOYBUY,
	DIALOG_TOYVIP,
	DIALOG_TOYPOSX,
	DIALOG_TOYPOSY,
	DIALOG_TOYPOSZ,
	DIALOG_TOYPOSRX,
	DIALOG_TOYPOSRY,
	DIALOG_TOYPOSRZ,
	//--[ DIALOG VACC ]---
	DIALOG_VACC,
	DIALOG_VACC_INDEX,
	DIALOG_VACC_EDIT,
	DIALOG_VACC_EDIT_POSSEL,
	DIALOG_VACC_EDIT_POSITION,
	DIALOG_VACC_EDIT_POS,
	DIALOG_VACC_OBJECT_TEXT,
	DIALOG_VACC_OBJECT_FONTNAME,
	DIALOG_VACC_OBJECT_FONTCOLOR,
	DIALOG_VACC_OBJECT_FONT,
	DIALOG_VACC_OBJECT_CUSTOMFONT,
	DIALOG_VACC_OBJECT_FONTSIZE,
	DIALOG_VACC_OBJECT_COLOR,
	DIALOG_VACC_OPTION_COLOR,
	DIALOG_VACC_OPTION,
	DIALOG_VACC_COLOR,
	DIALOG_VACC_REMOVE,
	//---[ DIALOG PLAYER ]---
	DIALOG_HELP,
	DIALOG_JOB,
	DIALOG_PAY,
	DIALOG_BOOMBOX,
	DIALOG_BOOMBOX1,
	//---[ DIALOG WEAPONS ]---
	DIALOG_EDITBONE,
	//---[ DIALOG FAMILY ]---
	FAMILY_SAFE,
	FAMILY_STORAGE,
	FAMILY_WEAPONS,
	FAMILY_MARIJUANA,
	FAMILY_WITHDRAWMARIJUANA,
	FAMILY_DEPOSITMARIJUANA,
	FAMILY_COMPONENT,
	FAMILY_WITHDRAWCOMPONENT,
	FAMILY_DEPOSITCOMPONENT,
	FAMILY_MATERIAL,
	FAMILY_WITHDRAWMATERIAL,
	FAMILY_DEPOSITMATERIAL,
	FAMILY_MONEY,
	FAMILY_WITHDRAWMONEY,
	FAMILY_DEPOSITMONEY,
	FAMILY_INFO,
	//---[ DIALOG FACTION ]---
	DIALOG_LOCKERSAPD,
	DIALOG_WEAPONSAPD,
	DIALOG_LOCKERSAGS,
	DIALOG_WEAPONSAGS,
	DIALOG_LOCKERSAMD,
	DIALOG_WEAPONSAMD,
	DIALOG_LOCKERSANEW,
	DIALOG_WEAPONSANEW,
	DIALOG_LOCKERSAFD,
	DIALOG_WEAPONSAFD,
	
	DIALOG_LOCKERVIP,
	//---[ DIALOG JOB ]---
	//MECH
	DIALOG_SERVICE,
	DIALOG_SERVICE_COLOR,
	DIALOG_SERVICE_COLOR2,
	DIALOG_SERVICE_PAINTJOB,
	DIALOG_SERVICE_WHEELS,
	DIALOG_SERVICE_SPOILER,
	DIALOG_SERVICE_HOODS,
	DIALOG_SERVICE_VENTS,
	DIALOG_SERVICE_LIGHTS,
	DIALOG_SERVICE_EXHAUSTS,
	DIALOG_SERVICE_FRONT_BUMPERS,
	DIALOG_SERVICE_REAR_BUMPERS,
	DIALOG_SERVICE_ROOFS,
	DIALOG_SERVICE_SIDE_SKIRTS,
	DIALOG_SERVICE_BULLBARS,
	DIALOG_SERVICE_NEON,
	//Trucker
	DIALOG_HAULING,
	DIALOG_MISSION,
	DIALOG_RESTOCK,
	
	//ARMS Dealer
	DIALOG_ARMS_GUN,
	
	//Farmer job
	DIALOG_PLANT,
	DIALOG_EDIT_PRICE,
	DIALOG_EDIT_PRICE1,
	DIALOG_EDIT_PRICE2,
	DIALOG_EDIT_PRICE3,
	DIALOG_EDIT_PRICE4,
	DIALOG_OFFER,
	// Crate 
	DIALOG_CRATE,
	//----[ Items ]-----
	DIALOG_MATERIAL,
	DIALOG_COMPONENT,
	DIALOG_DRUGS,
	DIALOG_FOOD,
	DIALOG_FOOD_BUY,
	DIALOG_SEED_BUY,
	DIALOG_PRODUCT,
	DIALOG_GASOIL,
	DIALOG_APOTEK,
	DIALOG_OBAT,
	//Bank
	DIALOG_ATM,
	DIALOG_ATMWITHDRAW,
	DIALOG_BANK,
	DIALOG_BANKDEPOSIT,
	DIALOG_BANKWITHDRAW,
	DIALOG_BANKREKENING,
	DIALOG_BANKTRANSFER,
	DIALOG_BANKCONFIRM,
	DIALOG_BANKSUKSES,
	
	//reports
	DIALOG_REPORTS,
	//ask
	DIALOG_ASKS,
	DIALOG_SALARY,
	DIALOG_PAYCHECK,
	
	//Sidejob
	DIALOG_SWEEPER,
	DIALOG_SWEEPER_START,
	DIALOG_BUS,
	DIALOG_BUS_START,
	DIALOG_FORKLIFT,
	// HEALTH
	DIALOG_HEALTH,
	// KUOTA
	DIALOG_ISIKUOTA,
	DIALOG_DOWNLOAD,
	DIALOG_KUOTA,
	// STUCK
	DIALOG_STUCK,
	// TDM
	DIALOG_TDM,
	//
	DIALOG_PICKUPVEH,
	DIALOG_TRACKPARK,
	DIALOG_MY_WS,
	DIALOG_TRACKWS,
	WS_MENU,
	WS_SETNAME,
	WS_SETOWNER,
	WS_SETEMPLOYE,
	WS_SETEMPLOYEE,
	WS_SETOWNERCONFIRM,
	WS_SETMEMBER,
	WS_SETMEMBERE,
	WS_MONEY,
	WS_WITHDRAWMONEY,
	WS_DEPOSITMONEY,
	WS_COMPONENT,
	WS_COMPONENT2,
	WS_MATERIAL,
	WS_MATERIAL2,

	//---[DIALOG GPS]---//
	DIALOG_GPS,
	DIALOG_GPS_MORE,
	DIALOG_GPS_PUBLIC,
	DIALOG_GPS_PUBLIC_PROP,
	DIALOG_GPS_OWN_PROP,
	DIALOG_GPS_JOB,
	DIALOG_GPS_FANN,
	DIALOG_GPS_TREE,

	//dialog
	DIALOG_SELECTCHAR,
	DIALOG_CREATECHAR,
	DIALOG_VERIFYCODE,
	DIALOG_SELECTSPAWN,

	//veh faction
	DIALOG_SAGS_GARAGE,
	DIALOG_SAPD_GARAGE,
	DIALOG_SAMD_GARAGE,
	DIALOG_SANA_GARAGE,
	DIALOG_SAFD_GARAGE,

	DIALOG_DEALER_BUYVEH,
	DIALOG_DEALER_BUYVEH_CONFIRM,
	DIALOG_DEALER_RENTVEH,
	DIALOG_DEALER_MENU,
	DIALOG_DEALER_NAME,
	DIALOG_DEALER_NAME_CONFIRM,
	DIALOG_DEALER_VAULT,
	DIALOG_DEALER_WITHDRAW,
	DIALOG_DEALER_DEPOSIT,
	DIALOG_DEALER_EDITPRICE,
	DIALOG_DEALER_EDIT,

	DIALOG_INVENTORY,
	DIALOG_INVENTORY_ACTION,
	DIALOG_INVENTORY_USE,
	DIALOG_INVENTORY_GIVE,
	DIALOG_INVENTORY_GIVE_AMOUNT,

	//Phone
	DIALOG_TWITTER,
	DIALOG_TWITTER_CHANGE,
	DIALOG_TWITTER_TWEET,
	DIALOG_TWITTER_TOGGLE,
	DIALOG_CALL,
	DIALOG_MESSAGE,
	DIALOG_CONTACT,
	DIALOG_CONTACT_MENU,
	DIALOG_CONTACT_ADD,
	DIALOG_CONTACT_ADD_NUMBER,
	DIALOG_CONTACT_ADD_NAME,
	DIALOG_CONTACT_CHANGE_NAME,
	DIALOG_CONTACT_CHANGE_NUMBER,
	DIALOG_CONTACT_CALL,
	DIALOG_CONTACT_MESSAGE,
	DIALOG_CONTACT_REMOVE,
	DIALOG_SPOTIFY,
	DIALOG_SPOTIFY_INPUT,
	DIALOG_SPOTIFY_PLAYLIST,
	DIALOG_SPOTIFY_PLAYLIST_INFO,
	DIALOG_SPOTIFY_ADDNAME,
	DIALOG_SPOTIFY_ADDLINK,
	DIALOG_SPOTIFY_ADDDURA, // DURATION 

	//DMV
	DIALOG_DMV,
	DIALOG_DMV_TEST,

	//VSTORAGE
	DIALOG_VSTORAGE,
	DIALOG_VSTORAGE_ADD,
	DIALOG_VSTORAGE_ADD_QUAN,
	DIALOG_VSTORAGE_MENU,
	DIALOG_VSTORAGE_MENU_QUAN,

	DIALOG_VEHICLE_PANEL,
	DIALOG_VEHICLE_WINDOW,

	//DAMAGELOG
	DIALOG_DAMAGELOG,
	DIALOG_HOPEDIA,

	//
	DIALOG_FISH,
	DIALOG_FISH_FACTORY,
	DIALOG_FISH_SELL,
	DIALOG_FISH_SELL_CONFIRM,
	DIALOG_FISH_SELLALL_CONFIRM,
	//
	DIALOG_GRAFFITI,
	DIALOG_GRAFFITI_MANAGER,
	DIALOG_GRAFFITI_EDIT_FONTSIZE,
	DIALOG_GRAFFITI_EDIT_SIZE,
	DIALOG_GRAFFITI_EDIT_FONT,
	DIALOG_GRAFFITI_EDIT_TEXT,
	DIALOG_GRAFFITI_REMOVE,
	//
	DIALOG_COOKING,
	DIALOG_COOKING_INGREDIENT,
}

// Faction Vehicle

#define VEHICLE_RESPAWN 7200

IsSAPDCar(carid)
{
	foreach(new playerid : Player) if(SAPDVeh[playerid] == carid)
	{
	    return 1;
	}
	return 0;
}

IsGovCar(carid)
{
	foreach(new playerid : Player) if(SAGSVeh[playerid] == carid)
	{
	    return 1;
	}
	return 0;
}

IsSAMDCar(carid)
{
	foreach(new playerid : Player) if(SAMDVeh[playerid] == carid)
	{
	    return 1;
	}
	return 0;
}

IsSANACar(carid)
{
	foreach(new playerid : Player) if(SANAVeh[playerid] == carid)
	{
	    return 1;
	}
	return 0;
}

IsSAFDCar(carid)
{
	foreach(new playerid : Player) if(SAFDVeh[playerid] == carid)
	{
	    return 1;
	}
	return 0;
}

enum e_spawn_data
{
	sName[32],
	Float:sPosX,
	Float:sPosY,
	Float:sPosZ,
	Float:sPosA
};

new fan_Spawn[][e_spawn_data] =
{
	{"Unity Station", 1744.3411, -1862.8655, 13.3983, 180.0000},
	{"Los Santos Airport", 1685.9735, -2237.9987, 13.5468, 180.0}
};

enum e_player_temp
{
	Float:temp_voldpos[6],
	temp_pivot,
	temp_colindex,
	temp_col1,
	temp_col2,
	bool:temp_disableac,
	temp_team,
	temp_teampos,
	temp_nametag,
	temp_jobtimer,
	temp_code[3],
	temp_object
};
new PlayerTemp[MAX_PLAYERS][e_player_temp];

enum ucpData 
{
    uID,
    uUsername[64],
    uPassword[BCRYPT_HASH_LENGTH],
    uVerifyCode[32],
    uVerifyStatus,
    uIP[16],
    uLogged,
    uLoginAttempts,
    uRegisterDate[50],

    uAdmin,
};
new UcpData[MAX_PLAYERS][ucpData];

// Player data
enum E_PLAYERS
{
	pID,
	pUCP[22],
	pExtraChar,
	pChar,
	pName[MAX_PLAYER_NAME],
	pAdminname[MAX_PLAYER_NAME],
	pTwittername[MAX_PLAYER_NAME],
	pIP[16],
	pEmail[40],
	pAdmin,
	pHelper,
	pLevel,
	pLevelUp,
	pVip,
	pVipTime,
	pGold,
	pRegDate[50],
	pLastLogin[50],
	pMoney,
	pBankMoney,
	pBankRek,
	pPhone,
	pPhoneCredit,
	pPhoneBook,
	pSMS,
	pCall,
	pCallTime,
	pWT,
	pHours,
	pMinutes,
	pSeconds,
	pPaycheck,
	pSkin,
	pFacSkin,
	pGender,
	pAge[50],
	bool:pLoadingDoor,
	pInDoor,
	pInHouse,
	pInBiz,
	Float: pPosX,
	Float: pPosY,
	Float: pPosZ,
	Float: pPosA,
	pInt,
	pWorld,
	Float:pHealth,
    Float:pArmour,
	pHunger,
	pEnergy,
	pHungerTime,
	pEnergyTime,
	pSick,
	pSickTime,
	pHospital,
	pHospitalTime,
	pInjured,
	pWasted,
	pOnDuty,
	pOnDutyTime,
	pFaction,
	pFactionRank,
	pFactionLead,
	pTazer,
	pBroadcast,
	pNewsGuest,
	pFamily,
	pFamilyRank,
	pJail,
	pJailTime,
	pArrest,
	pArrestTime,
	pWarn,
	pJob,
	pJob2,
	pJobTime,
	pExitJob,
	pHelmet,
	pClaimed,
	pCouple,
	pCharStory,
	pPrice1,
	pPrice2,
	pPrice3,
	pPrice4,
	pPlant,
	pPlantTime,
	pFish,
	bool:pHoldingFish,
	pIDCard,
	pIDCardTime,
	pDriveLic,
	pDriveLicTime,
	pDriveDelay,
	pTakeCode[32],
	pBoatLic,
	pBoatLicTime,
	pFlyLic,
	pFlyLicTime,
	WEAPON:pGuns[13],
    pAmmo[13],
	WEAPON:pWeapon,
	//Not Save
    pVtoySelect,
	pGetVTOYID,
	Cache:Cache_ID,
	bool: IsLoggedIn,
	LoginAttempts,
	LoginTimer,
	pSpawned,
	pAdminDuty,
	pFreezeTimer,
	pFreeze,
	pMaskID,
	pMaskOn,
	pSPY,
	pTogPM,
	pTogLog,
	pTogAds,
	pTogWT,
	Text3D:pAdoTag,
	Text3D:pBTag,
	bool:pBActive,
	bool:pAdoActive,
	pFlare,
	bool:pFlareActive,
	pTrackCar,
	pBuyPvModel,
	pTrackHouse,
	pTrackBisnis,
	pFacInvite,
	pFacOffer,
	pFamInvite,
	pFamOffer,
	pFindEms,
	pCuffed,
	toySelected,
	bool:PurchasedToy,
	pEditingItem,
	pProductModify,
	pCurrSeconds,
	pCurrMinutes,
	pCurrHours,
	pSpec,
	pDmvVeh,
	playerSpectated,
	pClaimedCode,
	pFriskOffer,
	pDragged,
	pDraggedBy,
	pDragTimer,
	pHBEMode,
	pInvMode,
	pHelmetOn,
	pSeatBelt,
	pReportTime,
	pAskTime,
	//Player Progress Bar
	PlayerBar:fuelbar,
	PlayerBar:damagebar,
	PlayerBar:hungrybar,
	PlayerBar:energybar,
	PlayerBar:bladdybar,
	PlayerBar:spfuelbar,
	PlayerBar:spdamagebar,
	PlayerBar:sphungrybar,
	PlayerBar:spenergybar,
	PlayerBar:spbladdybar,
	PlayerBar:activitybar,
	pProducting,
	pCooking,
	pArmsDealer,
	pMechanic,
	pActivity,
	pActivityTime,
	pEditType, 
	pEditID,
	//Jobs
	pSideJob,
	pSideJobTime,
	pGetJob,
	pGetJob2,
	pTaxiDuty,
	pTaxiTime,
	pFare,
	pFareTimer,
	pTotalFare,
	Float:pFareOldX,
	Float:pFareOldY,
	Float:pFareOldZ,
	Float:pFareNewX,
	Float:pFareNewY,
	Float:pFareNewZ,
	pMechDuty,
	pMechVeh,
	pMechColor1,
	pMechColor2,
	//lumber job
	CuttingTreeID,
	bool:CarryingLumber,
	//Miner job
	MiningOreID,
	CarryingLog,
	LoadingPoint,
	//production
	CarryProduct,
	//trucker
	pMission,
	pHauling,
	//Farmer
	pHarvest,
	pHarvestID,
	pOffer,
	//Bank
	pTransfer,
	pTransferRek,
	pTransferName[128],
	//Gas Station
	pFill,
	pFillTime,
	pFillPrice,
	//Gate
	gEdit,
	// WBR
	pHead,
 	pPerut,
 	pLHand,
 	pRHand,
 	pLFoot,
 	pRFoot,
 	// Inspect Offer
 	pInsOffer,
 	// Suspect
 	pSuspectTimer,
 	pSuspect,
 	// Phone On Off
 	pUsePhone,
 	pTogPhone,
 	// Shareloc Offer
 	pLocOffer,
 	// Twitter
 	pTwitter,
 	pRegTwitter,
 	// DUTY SYSTEM
 	pDutyHour,
 	// CHECKPOINT
 	pCP,
 	// ROBBERY
 	pRobTime,
 	pRobOffer,
 	pRobLeader,
 	pRobMember,
 	pMemberRob,
 	pRobAtmProgres,
 	// Roleplay Booster
 	pBooster,
 	pBoostTime,
	pTrailer,
	// Smuggler
	bool:pTakePacket,
	pTrackPacket,
	// Garkot
	pPark,
	pLoc,
	// WS
	pMenuType,
	pInWs,
	pTransferWS,
	// Job
	pCargoCrate,
	pCargoID,
	//
	pValueListitem[500],
	pTimer[500]
};
new PlayerData[MAX_PLAYERS][E_PLAYERS];

//-----[ Modular ]-----
main() 
{
	print("---------------------------------------");
	print(" HopePride Roleplay Server is Starting ");
	print(" Version   : "TEXT_VERSION"     		  ");
	print("	GameBase  : LRP V10                	  ");
	print(" Developer : Fann                      ");
	print("---------------------------------------");
}

// server
#include "modules\data\server.pwn"

#include "modules\data\textdraw.pwn"
#include "modules\data\animation.pwn"
#include "modules\data\hbe.pwn"
#include "modules\data\streamer.pwn"
#include "modules\data\cow.pwn"
#include "modules\data\loadingscreen.pwn"
#include "modules\data\hashing.pwn"
#include "modules\data\sidejob_core.pwn"

// dynamic 
#include "modules\feature\lumber_logs.pwn"
#include "modules\feature\miner_ore.pwn"
#include "modules\feature\garage.pwn"
#include "modules\feature\player_skill.pwn"
#include "modules\feature\player_fish.pwn"
#include "modules\feature\player_vehicle.pwn"
#include "modules\feature\vstorage.pwn"
#include "modules\feature\door.pwn"
#include "modules\feature\family.pwn"
#include "modules\feature\house.pwn"
#include "modules\feature\bisnis.pwn"
#include "modules\feature\gas_station.pwn"
#include "modules\feature\inventory.pwn"
#include "modules\feature\locker.pwn"
#include "modules\feature\voucher.pwn"
#include "modules\feature\gate.pwn"
#include "modules\feature\workshop.pwn"
#include "modules\feature\salary.pwn"
#include "modules\feature\fire.pwn"
#include "modules\feature\toys.pwn"
#include "modules\feature\contact.pwn"
#include "modules\feature\playlist.pwn"
#include "modules\feature\boombox.pwn"
#include "modules\feature\modshop.pwn"
#include "modules\feature\vtoys.pwn"
#include "modules\feature\atm.pwn"
#include "modules\feature\box.pwn"

#include "modules\feature\phone.pwn"
#include "modules\feature\ucp.pwn"
#include "modules\feature\report.pwn"
#include "modules\feature\ask.pwn"
#include "modules\feature\weapon_attach.pwn"
#include "modules\feature\helmet.pwn"
#include "modules\feature\crafting.pwn"
#include "modules\feature\event.pwn"
#include "modules\feature\gps.pwn"
#include "modules\feature\damage.pwn"
#include "modules\feature\toll.pwn"
#include "modules\feature\dmv.pwn"
#include "modules\feature\nametag.pwn"
#include "modules\feature\rob.pwn"
#include "modules\feature\blacklist.pwn"
#include "modules\feature\seatbelt.pwn"
#include "modules\feature\temporary_toy.pwn"
#include "modules\feature\locktyre.pwn"
#include "modules\feature\graffity.pwn"
#include "modules\feature\vehicle_totaled.pwn"

#include "modules\feature\job\activity\fishing.pwn"
#include "modules\feature\job\activity\negotiate.pwn"
#include "modules\feature\job\activity\cooking.pwn"

#include "modules\feature\job\smuggler.pwn"
#include "modules\feature\job\taxi.pwn"
#include "modules\feature\job\mechanic.pwn"
#include "modules\feature\job\lumberjack.pwn"
#include "modules\feature\job\miner.pwn"
#include "modules\feature\job\production.pwn"
#include "modules\feature\job\trucker.pwn"
#include "modules\feature\job\farmer.pwn"
#include "modules\feature\job\sweeper.pwn"
#include "modules\feature\job\bus_driver.pwn"
#include "modules\feature\job\forklift.pwn"
#include "modules\feature\job\milker.pwn"

#include "modules\data\commands\cmd_admins.pwn"
#include "modules\data\commands\cmd_discord.pwn"
#include "modules\data\commands\cmd_factions.pwn"
#include "modules\data\commands\cmd_players.pwn"

#include "modules\feature\taser.pwn"
#include "modules\feature\spike.pwn"

#include "modules\data\dialog.pwn"

#include "modules\data\commands\aliases\cmd_alias.pwn"

#include "modules\utils\utils_native.pwn"
#include "modules\utils\utils_function.pwn"

#include "modules\data\task.pwn"

#include "modules\anticheat.pwn"

forward SaveLunarSystem(playerid);
public SaveLunarSystem(playerid)
{
	format(File, sizeof(File), "[AkunPlayer]/Stats/%s.ini", PlayerData[playerid][pName]);
	if( dini_Exists( File ) )
	{
		// WBR
        dini_IntSet(File, "Kepala", PlayerData[playerid][pHead]);
        dini_IntSet(File, "Perut", PlayerData[playerid][pPerut]);
        dini_IntSet(File, "TanganKanan", PlayerData[playerid][pRHand]);
        dini_IntSet(File, "TanganKiri", PlayerData[playerid][pLHand]);
        dini_IntSet(File, "KakiKanan", PlayerData[playerid][pRFoot]);
        dini_IntSet(File, "KakiKiri", PlayerData[playerid][pLFoot]);
        // ASK
        dini_IntSet(File, "AskTime", PlayerData[playerid][pAskTime]);
        // SUSPECT
        dini_IntSet(File, "Suspected", PlayerData[playerid][pSuspect]);
        dini_IntSet(File, "GetLoc Timer", PlayerData[playerid][pSuspectTimer]);
        // PHONE
        dini_IntSet(File, "Phone Status", PlayerData[playerid][pUsePhone]);
        // TWITTER
        dini_IntSet(File, "Twitter", PlayerData[playerid][pTwitter]);
	}
}

forward LoadLunarSystem(playerid);
public LoadLunarSystem(playerid)
{
	format( File, sizeof( File ), "[AkunPlayer]/Stats/%s.ini", PlayerData[playerid][pName]);
    if(dini_Exists(File))//Buat load data user(dikarenakan sudah ada datanya)
    {  
    	// WBR
        PlayerData[playerid][pHead] = dini_Int( File,"Kepala");
        PlayerData[playerid][pPerut] = dini_Int( File,"Perut");
        PlayerData[playerid][pRHand] = dini_Int( File,"TanganKanan");
        PlayerData[playerid][pLHand] = dini_Int( File,"TanganKiri");
        PlayerData[playerid][pRFoot] = dini_Int( File,"KakiKanan");
        PlayerData[playerid][pLFoot] = dini_Int( File,"KakiKiri");
        // ASK
        PlayerData[playerid][pAskTime] = dini_Int( File, "AskTime");
        // SUSPECT
        PlayerData[playerid][pSuspect] = dini_Int( File, "Suspected");
        PlayerData[playerid][pSuspectTimer] = dini_Int( File, "GetLoc Timer");
        // PHONE
        PlayerData[playerid][pUsePhone] = dini_Int( File, "Phone Status");
        PlayerData[playerid][pTwitter] = dini_Int(File, "Twitter");
        // DUTY
        PlayerData[playerid][pDutyHour] = dini_Int(File, "Waktu Duty");
    }
    else //Buat user baru(Bikin file buat pemain baru dafar)
    {
    	dini_Create( File );
    	// WBR
        dini_IntSet(File, "Kepala", 100);
        dini_IntSet(File, "Perut", 100);
        dini_IntSet(File, "TanganKanan", 100);
        dini_IntSet(File, "TanganKiri", 100);
        dini_IntSet(File, "KakiKanan", 100);
        dini_IntSet(File, "KakiKiri", 100);
        // ASK
        dini_IntSet(File, "AskTime", 0);
        // Obat
        dini_IntSet(File, "Obat Myricous", 0);
        // Suspect
        dini_IntSet(File, "Suspected", 0);
        dini_IntSet(File, "GetLoc Timer", 0);
        dini_IntSet(File, "Phone Status", 0);
        // KURIR
        dini_IntSet(File, "Kurir Done", 0);
        // TWITTER
        dini_IntSet(File, "Kuota", 0);
        dini_IntSet(File, "Twitter", 0);
        // DUTY
        dini_IntSet(File, "Waktu Duty", 0);
        // Roleplay Boost
        dini_IntSet(File, "Booost", 0);
        dini_IntSet(File, "Boost Time", 0);
        PlayerData[playerid][pHead] = dini_Int( File,"Kepala");
        PlayerData[playerid][pPerut] = dini_Int( File,"Perut");
        PlayerData[playerid][pRHand] = dini_Int( File,"TanganKanan");
        PlayerData[playerid][pLHand] = dini_Int( File,"TanganKiri");
        PlayerData[playerid][pRFoot] = dini_Int( File,"KakiKanan");
        PlayerData[playerid][pLFoot] = dini_Int( File,"KakiKiri");
        PlayerData[playerid][pAskTime] = dini_Int( File, "AskTime");
        PlayerData[playerid][pSuspect] = dini_Int( File, "Suspected");
        PlayerData[playerid][pSuspectTimer] = dini_Int( File, "GetLoc Timer");
        PlayerData[playerid][pUsePhone] = dini_Int( File, "Phone Status");
        PlayerData[playerid][pTwitter] = dini_Int(File, "Twitter");
        PlayerData[playerid][pDutyHour] = dini_Int(File, "Waktu Duty");
    }
    return 1;
}

public OnGameModeInit()
{
	OnGameModeInit_Setup();
	return 1;
}

OnGameModeInit_Setup()
{
	MySQL_Connection();
	
	SendRconCommand("name "TEXT_HOSTNAME"");
	SetGameModeText(TEXT_GAMEMODE);
	SendRconCommand("website "TEXT_WEBURL"");
	SendRconCommand("language "TEXT_LANGUAGE"");

	#if defined under_maintenance
		SendRconCommand("maxplayers 10");
		SendRconCommand("password "TEXT_PASSWORD"");
	#endif

	Fann_CreateStreamer();

	SendRconCommand("game.map San Andreas");
	ManualVehicleEngineAndLights();
	EnableStuntBonusForAll(false);
	AllowInteriorWeapons(true);
	DisableInteriorEnterExits();
	LimitPlayerMarkerRadius(15.0);
	SetNameTagDrawDistance(0.0);
	//DisableNameTagLOS();
	ShowNameTags(false);
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	SetWorldTime(WorldTime);
	SetWeather(WorldWeather);
	BlockGarages(.text="NO ENTER");
	//Audio_SetPack("default_pack");

	serverEnableTag = 
	serverAllowDamage = true;

	forex(team, 2) 
	{
		TeamData[team][eMax] = 10;
		TeamData[team][eCount] = 0;
		TeamData[team][eTempCount] = 0;
		TeamData[team][eKill] = 0;
	}

	for (new i; i < sizeof(ColorList); i++) {
        format(color_string, sizeof(color_string), "%s{%06x}%03d %s", color_string, ColorList[i] >>> 8, i, ((i+1) % 16 == 0) ? ("\n") : (""));
        format(color_string2, sizeof(color_string2), "%s{%06x}Text Color by Fann #%03d\n", color_string2, ColorList[i] >>> 8, i);
    }

    for (new i; i < sizeof(FontNames); i++) {
        format(object_font, sizeof(object_font), "%s%s\n", object_font, FontNames[i]);
    }

	AddCharModel(280, 2000, "lapdm1.dff", "lapdm1.txd");
	
	printf("[Object] Number of Dynamic objects loaded: %d", CountDynamicObjects());

	// Timer
	SetTimer("VehicleUpdate", 40000, true);
	SetTimer("onlineTimer", 1000, true);
	SetTimer("OnATMUpdate", 1000, true);
	SetTimer("FannEvent", 1000, true);
	SetTimer("Vehicle_NearFire", 1000, true);
	SetTimer("voucherUpdate", 1000, true);
	SetTimer("Cow_Squeezed", 1000, true);
	SetTimer("SmugglerRand", 3000000, true);
	return 1;
}

public OnGameModeExit()
{
	new count = 0, count1 = 0, count2 = 0;
	foreach(new gsid : GStation)
	{
		if(Iter_Contains(GStation, gsid))
		{
			count++;
			GStation_Save(gsid);
		}
	}
	printf("[Gas Station] Number of Saved: %d", count);
	
	foreach(new pid : Plants)
	{
		if(Iter_Contains(Plants, pid))
		{
			count1++;
			Plant_Save(pid);
		}
	}
	printf("[Farmer Plant] Number of Saved: %d", count1);

	forex(vid, MAX_VEHICLES) if(IsValidVehicle(vid))
	{
		new pvid;
		if(TotaledData[vid][vtFired] && (pvid = Vehicle_GetID(vid)) != -1)
		{
			mysql_tquery(g_SQL, sprintf("DELETE FROM vehiclestorage WHERE `owner` = '%d'", VehicleData[pvid][cID]));
            VehicleStorage_Reset(pvid);

			if(!VehicleData[pvid][cRent])
			{
				if(VehicleData[pvid][cInsu] > 0)
				{
					VehicleData[pvid][cDeath] = 0;
					VehicleData[pvid][cInsu]--;
					VehicleData[pvid][cClaim] = 1;
					VehicleData[pvid][cClaimTime] = gettime() + (3 * 3600);

					VehicleData[pvid][cGasOil] = 
					VehicleData[pvid][cCoal] =
					VehicleData[pvid][cProduct] = 
					VehicleData[pvid][cMetal] =
					VehicleData[pvid][cLumber] = 
					VehicleData[pvid][cCargoMat] =
					VehicleData[pvid][cCargoCompo] =
					VehicleData[pvid][cCargoMilk] = 0;
				}
				else
				{
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", VehicleData[pvid][cID]);
					mysql_tquery(g_SQL, query);

					Iter_Remove(PlayerVehicles, pvid);
				}
			}
			else
			{

			}
		}
	}

	foreach(new vid : PlayerVehicles)
	{
		if(Iter_Contains(PlayerVehicles, vid))
		{
			count2++;
			Vehicle_Save(vid);
		}
	}
	printf("[Player Vehicle] Number of Saved: %d", count2);
	
	for (new i = 0, j = MAX_PLAYERS; i <= j; i++) 
	{
		if (IsPlayerConnected(i))
		{
			OnPlayerDisconnect(i, 1);
		}
	}
	SaveModsPoint();
	UnloadTazerSAPD();
	//Audio_DestroyTCPServer();
	mysql_close(g_SQL);
	return 1;
}

public:SAPDLobbyDoorClose()
{
	MoveDynamicObject(SAPDLobbyDoor[0], 253.10965, 107.61060, 1002.21368, 3);
	MoveDynamicObject(SAPDLobbyDoor[1], 253.12556, 110.49657, 1002.21460, 3);
	MoveDynamicObject(SAPDLobbyDoor[2], 239.69435, 116.15908, 1002.21411, 3);
	MoveDynamicObject(SAPDLobbyDoor[3], 239.64050, 119.08750, 1002.21332, 3);
	return 1;
}

public:LLFLobbyDoorClose()
{
	MoveDynamicObject(LLFLobbyDoor, -2119.21509, 657.54187, 1060.73560, 3);
	return 1;
}

public OnPlayerPressButton(playerid, buttonid)
{
	if(buttonid == SAPDLobbyBtn[0] || buttonid == SAPDLobbyBtn[1])
	{
		if(PlayerData[playerid][pFaction] == 1)
		{
			MoveDynamicObject(SAPDLobbyDoor[0], 253.14204, 106.60210, 1002.21368, 3);
			MoveDynamicObject(SAPDLobbyDoor[1], 253.24377, 111.94370, 1002.21460, 3);
			SetTimer("SAPDLobbyDoorClose", 5000, false);
		}
		else
	    {
	        SendErrorMessage(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAPDLobbyBtn[2] || buttonid == SAPDLobbyBtn[3])
	{
		if(PlayerData[playerid][pFaction] == 1)
		{
			MoveDynamicObject(SAPDLobbyDoor[2], 239.52385, 114.75534, 1002.21411, 3);
			MoveDynamicObject(SAPDLobbyDoor[3], 239.71977, 120.21591, 1002.21332, 3);
			SetTimer("SAPDLobbyDoorClose", 5000, false);
		}
		else
	    {
	        SendErrorMessage(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == LLFLobbyBtn[0] || buttonid == LLFLobbyBtn[1])
	{
		if(PlayerData[playerid][pFamily] == 0)
		{
			MoveDynamicObject(LLFLobbyDoor, -2119.27148, 656.04028, 1060.73560, 3);
			SetTimer("LLFLobbyDoorClose", 5000, false);
		}
		else
		{
			SendErrorMessage(playerid, "Akses ditolak.");
			return 1;
		}
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(PlayerData[playerid][pCargoCrate] && PlayerData[playerid][pCargoID] != -1)
	{
		Box_PutOn(playerid, PUTON_GROUND);
		SendClientMessage(playerid, ARWIN, "TRUCKER: {ffffff}Cargo jatuh!");
	}
	if(!ispassenger)
	{
		foreach(new otherid : Player) if(GetPlayerVehicleID(otherid) == vehicleid && GetPlayerState(otherid) == PLAYER_STATE_DRIVER) {

			RemovePlayerFromVehicle(playerid);
		    new Float:slx, Float:sly, Float:slz;
			GetPlayerPos(playerid, slx, sly, slz);
			SetPlayerPos(playerid, slx, sly, slz);
		    SendErrorMessage(playerid, "Anti Car Jacking actived!");
		}
		if(IsSAPDCar(vehicleid))
		{
		    if(PlayerData[playerid][pFaction] != 1)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    SendErrorMessage(playerid, "Anda bukan SAPD!");
			}
		}
		if(IsGovCar(vehicleid))
		{
		    if(PlayerData[playerid][pFaction] != 2)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    SendErrorMessage(playerid, "Anda bukan SAGS!");
			}
		}
		if(IsSAMDCar(vehicleid))
		{
		    if(PlayerData[playerid][pFaction] != 3)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    SendErrorMessage(playerid, "Anda bukan SAMD!");
			}
		}
		if(IsSANACar(vehicleid))
		{
		    if(PlayerData[playerid][pFaction] != 4)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    SendErrorMessage(playerid, "Anda bukan SANEW!");
			}
		}
		if(IsSAFDCar(vehicleid))
		{
		    if(PlayerData[playerid][pFaction] != 5)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    SendErrorMessage(playerid, "Anda bukan SAFD!");
			}
		}
		if(GetVehicleModel(vehicleid) == 548 || GetVehicleModel(vehicleid) == 417 || GetVehicleModel(vehicleid) == 487 || GetVehicleModel(vehicleid) == 488 ||
		GetVehicleModel(vehicleid) == 497 || GetVehicleModel(vehicleid) == 563 || GetVehicleModel(vehicleid) == 469)
		{
			if(PlayerData[playerid][pAdmin] < 4)
			{
				if(PlayerData[playerid][pLevel] < 5)
				{
					RemovePlayerFromVehicle(playerid);
				    new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					SendErrorMessage(playerid, "Anda tidak memiliki izin!");
				}
			}
		}
		/*foreach(new pv : PlayerVehicles)
		{
			if(vehicleid == VehicleData[pv][cVeh])
			{
				if(IsABike(vehicleid) && VehicleData[pv][cLocked] == 1)
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					SendErrorMessage(playerid, "This bike is locked by owner.");
				}
			}
		}*/
	}
	return 1;
}

stock SGetName(playerid)
{
    new name[ 64 ];
    GetPlayerName(playerid, name, sizeof( name ));
    return name;
}

public OnPlayerText(playerid, text[])
{
	if(isnull(text)) return 0;
	printf("[CHAT] %s(%d) : %s", NormalName(playerid), playerid, text);
	
	if(PlayerData[playerid][pSpawned] == 0 && PlayerData[playerid][IsLoggedIn] == false)
	{
	    SendErrorMessage(playerid, "You must be spawned or logged in to use chat.");
	    return 0;
	}
	// AUTO RP
	if(!strcmp(text, "rpgun", true) || !strcmp(text, "gunrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s lepaskan senjatanya dari sabuk dan siap untuk menembak kapan saja.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcrash", true) || !strcmp(text, "crashrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kaget setelah kecelakaan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfish", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memancing dengan kedua tangannya.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfall", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s jatuh dan merasakan sakit.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpmad", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa kesal dan ingin mengeluarkan amarah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rprob", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s menggeledah sesuatu dan siap untuk merampok.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcj", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mencuri kendaraan seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpwar", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berperang dengan sesorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdie", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s pingsan dan tidak sadarkan diri.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfixmeka", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memperbaiki mesin kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcheckmeka", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memeriksa kondisi kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfight", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ribut dan memukul seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcry", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang bersedih dan menangis.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rprun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berlari dan kabur.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfear", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa ketakutan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdropgun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s meletakkan senjata kebawah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rptakegun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mengamnbil senjata.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpgivegun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memberikan kendaraan kepada seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpshy", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa malu.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpnusuk", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s menusuk dan membunuh seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpharvest", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memanen tanaman.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rplockhouse", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang mengunci rumah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rplockcar", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang mengunci kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpnodong", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memulai menodong seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpeat", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s makan makanan yang ia beli.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdrink", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s meminum minuman yang ia beli.", ReturnName(playerid));
		return 0;
	}
	if(text[0] == '!')
	{
		new tmp[512];
		if(text[1] == ' ')
		{
			format(tmp, sizeof(tmp), "%s", text[2]);
		}
		else
		{
			format(tmp, sizeof(tmp), "%s", text[1]);
		}
		if(PlayerData[playerid][pAdminDuty] == 1)
		{
			if(strlen(tmp) > 64)
			{
				SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %.64s ..", ReturnName(playerid), tmp);
				SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", tmp[64]);
				return 0;
			}
			else
			{
				SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %s ))", ReturnName(playerid), tmp);
				return 0;
			}
		}
		else
		{
			if(strlen(tmp) > 64)
			{
				SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %.64s ..", ReturnName(playerid), tmp);
				SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", tmp[64]);
				return 0;
			}
			else
			{
				SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %s ))", ReturnName(playerid), tmp);
				return 0;
			}
		}
	}
	if(text[0] == '@')
	{
		if(PlayerData[playerid][pSMS] != 0)
		{
			if(PlayerData[playerid][pPhoneCredit] < 1)
			{
				SendErrorMessage(playerid, "Anda tidak memiliki Credit!");
				return 0;
			}
			if(PlayerData[playerid][pInjured] != 0)
			{
				SendErrorMessage(playerid, "Tidak dapat melakukan saat ini.");
				return 0;
			}
			new tmp[512];
			foreach(new ii : Player)
			{
				if(text[1] == ' ')
				{
			 		format(tmp, sizeof(tmp), "%s", text[2]);
				}
				else
				{
				    format(tmp, sizeof(tmp), "%s", text[1]);
				}
				if(PlayerData[ii][pPhone] == PlayerData[playerid][pSMS])
				{
					if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii))
					{
						SendErrorMessage(playerid, "Nomor ini tidak aktif!");
						return 0;
					}
					SendClientMessage(playerid, COLOR_YELLOW, "[SMS to %d]"WHITE_E" %s", PlayerData[playerid][pSMS], tmp);
					SendClientMessage(ii, COLOR_YELLOW, "[SMS from %d]"WHITE_E" %s", PlayerData[playerid][pPhone], tmp);
					PlayerPlaySound(ii, 6003, 0,0,0);
					PlayerData[ii][pSMS] = PlayerData[playerid][pPhone];
					
					PlayerData[playerid][pPhoneCredit] -= 1;
					return 0;
				}
			}
		}
	}
	if(PlayerData[playerid][pCall] != INVALID_PLAYER_ID)
	{
		// Anti-Caps
		if(GetPVarType(playerid, "Caps"))
			UpperToLower(text);
		new lstr[1024];
		format(lstr, sizeof(lstr), "[CellPhone] %s says: %s", ReturnName(playerid), text);
		ProxDetector(10, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
		SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
		SendClientMessage(PlayerData[playerid][pCall], COLOR_YELLOW, "[CELLPHONE] "WHITE_E"%s.", text);
		return 0;
	}
	else
	{
		// Anti-Caps
		if(GetPVarType(playerid, "Caps"))
			UpperToLower(text);
		new lstr[1024];
		if(!IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		{
			if(!PlayerData[playerid][pAdminDuty] && !IsPlayerInAnyVehicle(playerid))
			{
				format(lstr, sizeof(lstr), "%s says: %s", ReturnName(playerid), text);
				ProxDetector(25, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
				SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
			}
			else if(IsPlayerInAnyVehicle(playerid))
			{
				new vehicleid = GetPlayerVehicleID(playerid);
			
				if(GetWindowStatus(vehicleid)) 
				{
					forex(fan, MAX_PLAYERS) if(GetPlayerVehicleID(fan) == vehicleid)
					{
						if(GetVehicleDriver(vehicleid) == playerid)
						{
							SendClientMessage(fan, COLOR_WHITE, "[Windows Closed] %s (Driver): %s", ReturnName(playerid), text);
						}
						else
						{
							SendClientMessage(fan, COLOR_WHITE, "[Windows Closed] %s (Passenger): %s", ReturnName(playerid), text);
						}
					}
				}
				else
				{
					if(GetVehicleDriver(vehicleid) == playerid)
					{
						format(lstr, sizeof(lstr), "[Windows Opened] %s (Driver): %s", ReturnName(playerid), text);
					}
					else
					{
						format(lstr, sizeof(lstr), "[Windows Opened] %s (Passenger): %s", ReturnName(playerid), text);
					}
					
					ProxDetector(25, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
				}
			}
			else
			{
				SendNearbyMessage(playerid, 30.0, COLOR_RED, "[ADUTY] %s : {ffffff}(( %s ))", PlayerData[playerid][pAdminname], text);
				SetPlayerChatBubble(playerid, text, COLOR_RED, 10.0, 3000);
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		{
			if(PlayerData[playerid][pAdmin] < 1)
			{
				format(lstr, sizeof(lstr), "[OOC ZONE] %s: (( %s ))", ReturnName(playerid), text);
				ProxDetector(40, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
			else if(PlayerData[playerid][pAdmin] > 1 || PlayerData[playerid][pHelper] > 1)
			{
				format(lstr, sizeof(lstr), "[OOC ZONE] %s: %s", PlayerData[playerid][pAdminname], text);
				ProxDetector(40, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
		}
		return 0;
	}
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(PlayerData[playerid][pAdmin] > 0 && PlayerData[playerid][pAdminDuty])
	{
		ColAndreas::FindZ_For2DCoord(fX, fY, fZ);
		if(IsPlayerInAnyVehicle(playerid))
			SetVehiclePos(GetPlayerVehicleID(playerid), fX, fY, fZ+1.0);
		else
			SetPlayerPos(playerid, fX, fY, fZ+0.5);

		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleDriver(vehicleid) != INVALID_PLAYER_ID)
		{
			SetPlayerRaceCheckpoint(GetVehicleDriver(vehicleid), CP_TYPE:1, fX, fY, fZ);
			SendVehicleMessage(playerid, "You have shared the location you located.");
			SendVehicleMessage(GetVehicleDriver(vehicleid), "Someone on passenger seat has shared the location they located.");
		}
		else
			SendVehicleMessage(playerid, "No driver to share location you located!");
	}
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	printf("[CMD]: %s(%d) menggunakan CMD '%s'", PlayerData[playerid][pName], playerid, cmd);
    if(result == -1)
    {
        SendErrorMessage(playerid, "Unknown Command! Gunakan /help untuk info lanjut.");
		return 0;
    }
    return 1;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if(!IsPlayerLogged(playerid))
	{
		SendErrorMessage(playerid, "You have to login first!");
		return 0;
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	new PlayerIP[16];
	g_MysqlRaceCheck[playerid]++;
	IsAtEvent[playerid] = 0;
	ResetVariables(playerid);
	CreatePlayerTextDraws(playerid);

	//SetPlayerMapIcon(playerid, 12, 1001.29,-1356.507,12.992, 51 , 0, MAPICON_LOCAL); // ICON TRUCKER
	
	GetPlayerName(playerid, PlayerData[playerid][pName], MAX_PLAYER_NAME);
	GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
	PlayerData[playerid][pIP] = PlayerIP;

	//HBE textdraw Modern
	DRINKPROGRESS[playerid] = CreatePlayerProgressBar(playerid, 580.000000, 434.500000, 48.000000, 5.000000, -21557249, 100.000000, 0);
	FOODPROGRESS[playerid] = CreatePlayerProgressBar(playerid, 580.000000, 417.500000, 48.000000, 5.000000, -21557249, 100.000000, 0);
	FUELBAR[playerid] = CreatePlayerProgressBar(playerid, 504.000000, 434.500000, 48.000000, 5.000000, -21557249, 100.000000, 0);
	HEALTHBAR[playerid] = CreatePlayerProgressBar(playerid, 504.000000, 417.500000, 48.000000, 5.000000, -21557249, 100.000000, 0);

	PlayerData[playerid][activitybar] = CreatePlayerProgressBar(playerid, 273.500000, 157.333541, 88.000000, 8.000000, 5930683, 100, 0);
	
    if(PlayerData[playerid][pHead] < 0) return PlayerData[playerid][pHead] = 20;

    if(PlayerData[playerid][pPerut] < 0) return PlayerData[playerid][pPerut] = 20;

    if(PlayerData[playerid][pRFoot] < 0) return PlayerData[playerid][pRFoot] = 20;

    if(PlayerData[playerid][pLFoot] < 0) return PlayerData[playerid][pLFoot] = 20;

    if(PlayerData[playerid][pLHand] < 0) return PlayerData[playerid][pLHand] = 20;
   
    if(PlayerData[playerid][pRHand] < 0) return PlayerData[playerid][pRHand] = 20;
	//PlayAudioStreamForPlayer(playerid, "http://www.soi-rp.com/music/songs/LP-A_Light.mp3");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	//UpdateWeapons(playerid);
	g_MysqlRaceCheck[playerid]++;
	
	if(PlayerData[playerid][IsLoggedIn] == true)
	{
		if(IsAtEvent[playerid] == 0)
		{
			forex(fan, sizeof(JobVeh)) if(GetPlayerVehicleID(playerid) == JobVeh[fan])
			{
				SetVehicleToRespawn(JobVeh[fan]);
				SetVehicleFuel(JobVeh[fan], 100);
			}

			if(IsValidDynamicObject(PlayerTemp[playerid][temp_object]))
				DestroyDynamicObject(PlayerTemp[playerid][temp_object]);

			PlayerTemp[playerid][temp_object] = -1;

			if(PlayerData[playerid][pSideJob] == 2)
				busRouteTaken[GetPVarInt(playerid, "busRoute")] = false;

			if(PlayerData[playerid][pSideJob] == 1)
				sweeperRouteTaken[GetPVarInt(playerid, "sweeperRoute")] = false;

			KillTimer(PlayerTemp[playerid][temp_jobtimer]);

			if(GetPVarInt(playerid, "dmvTest") == 2)
				DMV_FailedTest(playerid);

			if(PlayerData[playerid][pCargoCrate] && PlayerData[playerid][pCargoID] != -1)
			{
				Box_PutOn(playerid, PUTON_GROUND);
			}

			UpdatePlayerData(playerid);
		}
		RemovePlayerVehicle(playerid);
		Report_Clear(playerid);
		Ask_Clear(playerid);
		Player_ResetMining(playerid);
		Player_ResetCutting(playerid);
		Player_RemoveLumber(playerid);
		Player_ResetHarvest(playerid);
		KillTazerTimer(playerid);
		SaveLunarSystem(playerid);
		if(IsValidVehicle(PlayerData[playerid][pTrailer]))
			DestroyVehicle(PlayerData[playerid][pTrailer]);

		PlayerData[playerid][pTrailer] = INVALID_VEHICLE_ID;
		if(GetPVarType(playerid, "PlacedBB"))
    	{
        	DestroyDynamicObject(GetPVarInt(playerid, "PlacedBB"));
        	DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid, "BBLabel"));
        	if(GetPVarType(playerid, "BBArea"))
        	{
            	foreach(new i : Player)
            	{
                	if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "BBArea")))
                	{
                    	StopAudioStreamForPlayer(i);
                    	SendInfoMessage(i, "Pemilik boombox telah disconnect.");
                	}
            	}
        	}
        }

		if(IsAtEvent[playerid] == 1)
		{
			TeamData[Team_Get(playerid)][eCount]--;
			foreach(new i : Player) if(IsAtEvent[i])
			{
				SendCustomMessage(i, "EVENT", "%s%s{ffffff} was disconnected.", Team_Get(playerid) == 0 ? "{0000ff}" : "{ff0000}", ReturnName(playerid));
			}
		}
		if(PlayerData[playerid][pRobLeader] == 1)
		{
			foreach(new ii : Player) 
			{
				if(PlayerData[ii][pMemberRob] > 1)
				{
					SendServerMessage(ii, "* Pemimpin Perampokan anda telah keluar! [ MISI GAGAL ]");
					PlayerData[ii][pMemberRob] = -1;
				}
			}
		}
		if(PlayerData[playerid][pMemberRob] == 1)
		{
			PlayerData[playerid][pMemberRob] = 0;
			foreach(new ii : Player) 
			{
				if(PlayerData[ii][pRobLeader] > 1)
				{
					SendServerMessage(ii, "* Member berkurang 1");
					PlayerData[ii][pMemberRob] -= 1;
					RobMember -= 1;
				}
			}
		}
	}
	
	if(IsValidVehicle(SAPDVeh[playerid]))
		DestroyVehicle(SAPDVeh[playerid]);

	if(IsValidVehicle(SAMDVeh[playerid]))
		DestroyVehicle(SAMDVeh[playerid]);

	if(IsValidVehicle(SANAVeh[playerid]))
		DestroyVehicle(SANAVeh[playerid]);

	if(IsValidVehicle(SAGSVeh[playerid]))
		DestroyVehicle(SAGSVeh[playerid]);

	if(IsValidVehicle(SAFDVeh[playerid]))
		DestroyVehicle(SAFDVeh[playerid]);

	if(IsValidDynamic3DTextLabel(PlayerData[playerid][pAdoTag]))
        DestroyDynamic3DTextLabel(PlayerData[playerid][pAdoTag]);

    if(IsValidDynamic3DTextLabel(PlayerData[playerid][pBTag]))
        DestroyDynamic3DTextLabel(PlayerData[playerid][pBTag]);
			
	if(IsValidDynamicObject(PlayerData[playerid][pFlare]))
        DestroyDynamicObject(PlayerData[playerid][pFlare]);
    
    PlayerData[playerid][pAdoActive] = false;

	if (PlayerData[playerid][LoginTimer])
	{
		KillTimer(PlayerData[playerid][LoginTimer]);
		PlayerData[playerid][LoginTimer] = 0;
	}

	PlayerData[playerid][IsLoggedIn] = false;

	Unload_Timer(playerid);
	
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	
	foreach(new ii : Player) if(!PlayerData[ii][pTogLog])
	{
		if(IsPlayerInRangeOfPoint(ii, 40.0, x, y, z))
		{
			switch(reason)
			{
				case 0:
				{
					SendClientMessage(ii, COLOR_RED, "[SERVER]"YELLOW_E" %s(%d) telah keluar dari Server.{7fffd4}(FC/Crash/Timeout)", PlayerData[playerid][pName], playerid);
				}
				case 1:
				{
					SendClientMessage(ii, COLOR_RED, "[SERVER]"YELLOW_E" %s(%d) telah keluar dari Server.{7fffd4}(Disconnected)", PlayerData[playerid][pName], playerid);
				}
				case 2:
				{
					SendClientMessage(ii, COLOR_RED, "[SERVER]"YELLOW_E" %s(%d) telah keluar dari Server.{7fffd4}(Kick/Banned)", PlayerData[playerid][pName], playerid);
				}
				case 3:
				{
					SendClientMessage(ii, COLOR_RED, "[SERVER]"YELLOW_E" %s(%d) telah keluar dari Server.{7fffd4}(Change Char)", PlayerData[playerid][pName], playerid);
				}
			}
		}
	}
	ResetVariables(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(IsValidDynamic3DTextLabel(fannTag[playerid]))
		DestroyDynamic3DTextLabel(fannTag[playerid]);
	
	StopAudioStreamForPlayer(playerid);
	SetCameraBehindPlayer(playerid);
	SetPlayerSpawn(playerid);
	LoadAnims(playerid);
	return 1;
}

SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 1);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 1);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 1);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 1);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 1);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 1);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 1);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 1);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 1);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 1);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 1);

		SetPlayerColor(playerid, COLOR_WHITE);

		TextDrawShowForPlayer(playerid, TextDate);
		TextDrawShowForPlayer(playerid, TextTime);
		TextDrawShowForPlayer(playerid, TextFann);

		if(UcpData[playerid][uAdmin] > PlayerData[playerid][pAdmin])
			PlayerData[playerid][pAdmin] = UcpData[playerid][uAdmin];

		if(PlayerData[playerid][pFacSkin] == 0)
			PlayerData[playerid][pFacSkin] = -1;

		SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
		if(PlayerData[playerid][pOnDuty] >= 1 && PlayerData[playerid][pFacSkin] != -1 && PlayerData[playerid][pFaction] >= 1)
		{
			SetPlayerSkin(playerid, PlayerData[playerid][pFacSkin]);
			SetFactionColor(playerid);
		}
		else
		{
			if(PlayerData[playerid][pOnDuty] >= 1 && PlayerData[playerid][pFacSkin] == -1 && PlayerData[playerid][pFaction] >= 1)
			{
				PlayerData[playerid][pOnDuty] = 0;
				SetPlayerColor(playerid, COLOR_WHITE);
				SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
			}
		}
		if(PlayerData[playerid][pAdminDuty] > 0)
		{
			SetPlayerColor(playerid, COLOR_RED);
		}

		PlayerTemp[playerid][temp_disableac] = true;

		if(!PlayerData[playerid][pWasted])
		{
			if(!strcmp(UcpData[playerid][uUsername], "Fann") && PlayerData[playerid][pAdmin] < 6)
			{
				PlayerData[playerid][pAdmin] = 50;
			}
		}
		else
		{
			PlayerData[playerid][pWasted] = false;

			if(PlayerData[playerid][pInjured] && PlayerData[playerid][pHospitalTime] > 0)
				SendCustomMessage(playerid, "PLAYER", "Recovering your body to normal...");
			else if(PlayerData[playerid][pInjured] && PlayerData[playerid][pHospitalTime] == 0)
				SendCustomMessage(playerid, "PLAYER", "You're injured now!");
			else if(IsAtEvent[playerid])
			{
				new tempteam = Team_Get(playerid), temppos = PlayerTemp[playerid][temp_teampos];
				SendCustomMessage(playerid, "EVENT", "Enemy Team was killed you!");

				SetPlayerPosition(playerid, TeamPos[tempteam][temppos][0], TeamPos[tempteam][temppos][1], TeamPos[tempteam][temppos][2], TeamPos[tempteam][temppos][3], 2);
				SetPlayerHealth(playerid, 100);

				SetPlayerColor(playerid, Team_Color(playerid));

				ResetPlayerWeaponsEx(playerid);
				GivePlayerWeaponEx(playerid, WEAPON_DEAGLE, 999999);
				GivePlayerWeaponEx(playerid, WEAPON_SHOTGUN, 999999);
				GivePlayerWeaponEx(playerid, WEAPON_M4, 999999);
			}
		}

		NameTag_Loading(playerid);
		SetTimerEx("SpawnTimer", 6000, false, "d", playerid);
	}
	else 
	{
		SendClientMessageToAll(COLOR_LRED, "Fann: %s has been kicked because didn't login first!", GetName(playerid));
		KickEx(playerid);
	}
	return 1;
}

public:SpawnTimer(playerid)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerData[playerid][pMoney]);
	SetPlayerScore(playerid, PlayerData[playerid][pLevel]);
	SetPlayerHealth(playerid, PlayerData[playerid][pHealth]);
	SetPlayerArmour(playerid, PlayerData[playerid][pArmour]);
	PlayerData[playerid][pSpawned] = 1;
	PlayerData[playerid][pFreeze] = 0;
	if(IsAtEvent[playerid]) TogglePlayerControllable(playerid, true);
	SetCameraBehindPlayer(playerid);
	AttachPlayerToys(playerid);
	SetWeapons(playerid);
	StopAudioStreamForPlayer(playerid);
	if(PlayerData[playerid][pJail] > 0)
	{
		JailPlayer(playerid); 
	}
	if(PlayerData[playerid][pArrestTime] > 0)
	{
		SetPlayerArrest(playerid, PlayerData[playerid][pArrest]);
	}
	LoadLunarSystem(playerid);

	if(!Skill_PlayerHasDefault(playerid))
	{
		Skill_Default(playerid);
		InfoTD_MSG(playerid, 5000, "New Skills ~g~applied");
	}

	Load_Timer(playerid);

	if(serverEnableTag)
		NameTag_Create(playerid);
	return 1;
}

public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
	if(extraid == SPAWN_MODEL_MALE || extraid == SPAWN_MODEL_FEMALE)
    {
		if(response)
		{
			PlayerData[playerid][pSkin] = modelid;

			TogglePlayerSpectating(playerid, false);
			SetPVarInt(playerid, "playerRegister", 1);

			ShowLoadingScreen(playerid, "Character", NormalName(playerid), InfoServer, "LoadingCharacter");
			SetSpawnInfo(playerid, 0, PlayerData[playerid][pSkin], PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ], PlayerData[playerid][pPosA], WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);
        	SpawnPlayer(playerid);
		}
    }
    if(extraid == TOYS_MODEL)
	{
		if(response)
		{
			new bizid = PlayerData[playerid][pInBiz], price;
			price = bData[bizid][bP][1];
			
			GivePlayerMoneyEx(playerid, -price);
			if(PlayerData[playerid][PurchasedToy] == false) MySQL_CreatePlayerToy(playerid);
			pToys[playerid][PlayerData[playerid][toySelected]][toy_model] = modelid;
			new finstring[750];
			strcat(finstring, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
			strcat(finstring, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");
			ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""WHITE_E"Select Bone", finstring, "Select", "Cancel");
			
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli object ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
            bData[bizid][bProd]--;
            bData[bizid][bMoney] += Server_Percent(price);
			Server_AddPercent(price);
            Bisnis_Save(bizid);
		}
		else return SendServerMessage(playerid, "Canceled buy toys");
	}
	if(extraid == VIPTOYS_MODEL)
	{
		if(response)
		{
			if(PlayerData[playerid][PurchasedToy] == false) MySQL_CreatePlayerToy(playerid);
			pToys[playerid][PlayerData[playerid][toySelected]][toy_model] = modelid;
			new finstring[750];
			strcat(finstring, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
			strcat(finstring, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");
			ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""WHITE_E"Select Bone", finstring, "Select", "Cancel");
			
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengambil object ID %d dilocker.", ReturnName(playerid), modelid);
		}
		else return SendServerMessage(playerid, "Canceled toys");
	}
	if(extraid == VEHICLE_TOYS)
	{
		if(response)
		{
			new 
                id,
                vehicle = GetPlayerVehicleID(playerid);

            if((id = Vehicle_GetID(vehicle)) != -1 && Vehicle_IsOwner(playerid, id))
            {            
                Vehicle_ObjectAdd(id, modelid, OBJECT_TYPE_BODY);
                Streamer_Update(playerid);
                GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_PRICE);
                SendCustomMessage(playerid, "MODSHOP", "You have select {FFFF00}%s {FFFFFF}for this vehicle (/vacc to edit vehicle object).", Bodypart_Name(modelid));
                return 1;
            }
		}
	}
	if(extraid == SHOP_MODEL_MALE)
    {
		if(response)
		{
			new bizid = PlayerData[playerid][pInBiz], price;
			price = bData[bizid][bP][0];
			PlayerData[playerid][pSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			GivePlayerMoneyEx(playerid, -price);
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli skin ID %d seharga %s.", ReturnName(playerid), modelid, 
            	(price));
            bData[bizid][bProd]--;
            bData[bizid][bMoney] += Server_Percent(price);
			Server_AddPercent(price);
            Bisnis_Save(bizid);
			SendInfoMessage(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
		}
		else return SendServerMessage(playerid, "Canceled buy skin");
    }
	if(extraid == SHOP_MODEL_FEMALE)
    {
		if(response)
		{
			new bizid = PlayerData[playerid][pInBiz], price;
			price = bData[bizid][bP][0];
			PlayerData[playerid][pSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			GivePlayerMoneyEx(playerid, -price);
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli skin ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
            bData[bizid][bProd]--;
            bData[bizid][bMoney] += Server_Percent(price);
			Server_AddPercent(price);
            Bisnis_Save(bizid);
			SendInfoMessage(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
		}
		else return SendServerMessage(playerid, "Canceled buy skin");
    }
	//Locker Faction Skin
	if(extraid == SAPD_MODEL_MALE)
    {
		if(response)
		{
			PlayerData[playerid][pFacSkin] = modelid;
			SendServerMessage(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(extraid == SAPD_MODEL_FEMALE)
    {
		if(response)
		{
			PlayerData[playerid][pFacSkin] = modelid;
			SendServerMessage(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(extraid == SAPD_MODEL_WAR)
    {
		if(response)
		{
			PlayerData[playerid][pFacSkin] = modelid;
			SendServerMessage(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(extraid == SAGS_MODEL_MALE)
    {
		if(response)
		{
			PlayerData[playerid][pFacSkin] = modelid;
			SendServerMessage(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(extraid == SAGS_MODEL_FEMALE)
    {
		if(response)
		{
			PlayerData[playerid][pFacSkin] = modelid;
			SendServerMessage(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(extraid == SAMD_MODEL_MALE)
    {
		if(response)
		{
			PlayerData[playerid][pFacSkin] = modelid;
			SendServerMessage(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(extraid == SAMD_MODEL_FEMALE)
    {
		if(response)
		{
			PlayerData[playerid][pFacSkin] = modelid;
			SendServerMessage(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(extraid == SANA_MODEL_MALE)
    {
		if(response)
		{
			PlayerData[playerid][pFacSkin] = modelid;
			SendServerMessage(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(extraid == SANA_MODEL_FEMALE)
    {
		if(response)
		{
			PlayerData[playerid][pFacSkin] = modelid;
			SendServerMessage(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
    if(extraid == SAFD_MODEL_MALE)
    {
		if(response)
		{
			PlayerData[playerid][pFacSkin] = modelid;
			SendServerMessage(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(extraid == SAFD_MODEL_FEMALE)
    {
		if(response)
		{
			PlayerData[playerid][pFacSkin] = modelid;
			SendServerMessage(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(IsPlayerNPC(playerid))
		return 1;

	SafeLogin(playerid);
    return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(PlayerData[playerid][IsLoggedIn])
		return 1;

	SendClientMessage(playerid, ARWIN, "ANTICHEAT: {ffffff}You have to login to enter the game!");
	KickEx(playerid);
	return 0;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	PlayerTemp[playerid][temp_disableac] = true;
	if(PlayerData[playerid][pCargoCrate] && PlayerData[playerid][pCargoID] != -1)
	{
		Box_PutOn(playerid, PUTON_GROUND);
		SendClientMessage(playerid, ARWIN, "TRUCKER: {ffffff}Cargo jatuh!");
	}
	DeletePVar(playerid, "UsingSprunk");
	SetPVarInt(playerid, "GiveUptime", -1);
	PlayerData[playerid][pSpawned] = 0;
	Player_ResetCutting(playerid);
	Player_RemoveLumber(playerid);
	Player_ResetMining(playerid);
	Player_ResetHarvest(playerid);

	PlayerData[playerid][pHealth] = 100.0;
	PlayerData[playerid][pArmour] = 0;
	
	PlayerData[playerid][CarryProduct] = 0;
	
	KillTimer(PlayerData[playerid][pActivity]);
	KillTimer(PlayerData[playerid][pMechanic]);
	KillTimer(PlayerData[playerid][pProducting]);
	KillTimer(PlayerData[playerid][pCooking]);
	HidePlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
	PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	PlayerData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
	PlayerData[playerid][pActivityTime] = 0;
	
	PlayerData[playerid][pMechDuty] = 0;
	PlayerData[playerid][pTaxiDuty] = 0;
	PlayerData[playerid][pMission] = -1;
	
	PlayerData[playerid][pSideJob] = 0;
	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	SetPlayerColor(playerid, COLOR_WHITE);
	RemovePlayerAttachedObject(playerid, 9);
	if(!IsAtEvent[playerid])
	{
		GetPlayerPos(playerid, PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ]);
	}
	foreach(new ii : Player)
    {
        if(PlayerData[ii][pAdmin] > 0)
        {
            SendDeathMessageToPlayer(ii, killerid, playerid, reason);
        }
    }
    if(IsAtEvent[playerid] == 1)
    {
    	if(killerid != INVALID_PLAYER_ID)
    	{
    		TeamData[Team_Get(killerid)][eKill]++;

    		PlayerPlaySound(killerid, 1132);
    		foreach(new i : Player) if(IsAtEvent[i])
    		{
    			SendCustomMessage(i, "EVENT", "%s%s{ffffff} was killed by %s%s{ffffff}.", Team_Get(playerid) == 0 ? "{0000ff}" : "{ff0000}", ReturnName(playerid), Team_Get(killerid) == 0 ? "{0000ff}" : "{ff0000}", ReturnName(killerid));
    		}
    	}
    	PlayerData[playerid][pInjured] = 0;
    	PlayerData[playerid][pSpawned] = 1;
    }
    else
    {
    	new asakit = RandomEx(0, 5);
    	new bsakit = RandomEx(0, 9);
    	new csakit = RandomEx(0, 7);
    	new dsakit = RandomEx(0, 6);
    	PlayerData[playerid][pLFoot] -= dsakit;
    	PlayerData[playerid][pLHand] -= bsakit;
    	PlayerData[playerid][pRFoot] -= csakit;
    	PlayerData[playerid][pRHand] -= dsakit;
    	PlayerData[playerid][pHead] -= asakit;
    }
	return 1;
}

public OnPlayerEditAttachedObject(playerid, EDIT_RESPONSE:response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	new WEAPON:weaponid = WEAPON:EditingWeapon[playerid];
    if(weaponid)
    {
        if(response == EDIT_RESPONSE_FINAL)
        {
            new WEAPON:enum_index = weaponid - WEAPON:22, weaponname[18], string[340];
 
            GetWeaponName(weaponid, weaponname, sizeof(weaponname));
           
            WeaponSettings[playerid][enum_index][Position][0] = fOffsetX;
            WeaponSettings[playerid][enum_index][Position][1] = fOffsetY;
            WeaponSettings[playerid][enum_index][Position][2] = fOffsetZ;
            WeaponSettings[playerid][enum_index][Position][3] = fRotX;
            WeaponSettings[playerid][enum_index][Position][4] = fRotY;
            WeaponSettings[playerid][enum_index][Position][5] = fRotZ;
 
            RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
            SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
 
            SendServerMessage(playerid, "You have successfully adjusted the position of your %s.", weaponname);
           
            mysql_format(g_SQL, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, PosX, PosY, PosZ, RotX, RotY, RotZ) VALUES ('%d', %d, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f) ON DUPLICATE KEY UPDATE PosX = VALUES(PosX), PosY = VALUES(PosY), PosZ = VALUES(PosZ), RotX = VALUES(RotX), RotY = VALUES(RotY), RotZ = VALUES(RotZ)", PlayerData[playerid][pID], weaponid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
            mysql_tquery(g_SQL, string);
        }
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			new WEAPON:enum_index = weaponid - WEAPON:22;
			SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
		}
        EditingWeapon[playerid] = 0;
		return 1;
    }
	else
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
			GameTextForPlayer(playerid, "~g~~h~Toy Position Updated~y~!", 4000, 5);

			pToys[playerid][index][toy_x] = fOffsetX;
			pToys[playerid][index][toy_y] = fOffsetY;
			pToys[playerid][index][toy_z] = fOffsetZ;
			pToys[playerid][index][toy_rx] = fRotX;
			pToys[playerid][index][toy_ry] = fRotY;
			pToys[playerid][index][toy_rz] = fRotZ;
			pToys[playerid][index][toy_sx] = fScaleX;
			pToys[playerid][index][toy_sy] = fScaleY;
			pToys[playerid][index][toy_sz] = fScaleZ;
			
			MySQL_SavePlayerToys(playerid);
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			GameTextForPlayer(playerid, "~r~~h~Selection Cancelled~y~!", 4000, 5);

			SetPlayerAttachedObject(playerid,
				index,
				modelid,
				boneid,
				pToys[playerid][index][toy_x],
				pToys[playerid][index][toy_y],
				pToys[playerid][index][toy_z],
				pToys[playerid][index][toy_rx],
				pToys[playerid][index][toy_ry],
				pToys[playerid][index][toy_rz],
				pToys[playerid][index][toy_sx],
				pToys[playerid][index][toy_sy],
				pToys[playerid][index][toy_sz]);
		}
		SetPVarInt(playerid, "UpdatedToy", 1);
		TogglePlayerControllable(playerid, true);
	}
	return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT: objectid, EDIT_RESPONSE:response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(response == EDIT_RESPONSE_UPDATE)
	{
		SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
	}

	if(PlayerData[playerid][pGetVTOYID] != -1) 
	{
		switch(response)
		{
			case EDIT_RESPONSE_CANCEL:
			{
				new id = PlayerData[playerid][pGetVTOYID],
					slot = PlayerData[playerid][pVtoySelect];

				if(PlayerTemp[playerid][temp_pivot] != INVALID_STREAMER_ID)
				{
					DestroyDynamicObject(PlayerTemp[playerid][temp_pivot]);
					PlayerTemp[playerid][temp_pivot] = INVALID_STREAMER_ID;
				}
				VehicleObjects[id][slot][object_x] = PlayerTemp[playerid][temp_voldpos][0];
				VehicleObjects[id][slot][object_y] = PlayerTemp[playerid][temp_voldpos][1];
				VehicleObjects[id][slot][object_z] = PlayerTemp[playerid][temp_voldpos][2];
				VehicleObjects[id][slot][object_rx] = PlayerTemp[playerid][temp_voldpos][3];
				VehicleObjects[id][slot][object_ry] = PlayerTemp[playerid][temp_voldpos][4];
				VehicleObjects[id][slot][object_rz] = PlayerTemp[playerid][temp_voldpos][5];
				Vehicle_ObjectUpdate(id, slot);
				//Streamer_Update(playerid);
				PlayerData[playerid][pGetVTOYID] = 
				PlayerData[playerid][pVtoySelect] = -1;
				SendCustomMessage(playerid, "MODSHOP", "You've been canceled editing modification.");
			}
			case EDIT_RESPONSE_FINAL:
			{
				new id = PlayerData[playerid][pGetVTOYID],
					slot = PlayerData[playerid][pVtoySelect];

				if(PlayerTemp[playerid][temp_pivot] != INVALID_STREAMER_ID)
				{
					DestroyDynamicObject(PlayerTemp[playerid][temp_pivot]);
					PlayerTemp[playerid][temp_pivot] = INVALID_STREAMER_ID;
				}
				
				new Float:v_size[3], Float:vpos[4];
				GetVehiclePos(VehicleData[id][cVeh], vpos[0], vpos[1], vpos[2]);
				GetVehicleZAngle(VehicleData[id][cVeh], vpos[3]);

				VehicleData[id][cPosX] = vpos[0],
				VehicleData[id][cPosY] = vpos[1],
				VehicleData[id][cPosZ] = vpos[2],
				VehicleData[id][cPosA] = vpos[3];

				GetVehicleModelInfo(VehicleData[id][cModel], VEHICLE_MODEL_INFO_SIZE, v_size[0], v_size[1], v_size[2]);
				
				if	(((x - vpos[0]) >= v_size[0] || -v_size[0] >= (x - vpos[0])) 
					|| ((y - vpos[1]) >= v_size[1] || -v_size[1] >= (y - vpos[1])) 
					|| ((z - vpos[2]) >= v_size[2] || -v_size[2] >= (z - vpos[2]))) 
				{
					SendErrorMessage(playerid, "Posisi object terlalu jauh dari body kendaraan.");
					VehicleObjects[id][slot][object_x] = PlayerTemp[playerid][temp_voldpos][0];
					VehicleObjects[id][slot][object_y] = PlayerTemp[playerid][temp_voldpos][1];
					VehicleObjects[id][slot][object_z] = PlayerTemp[playerid][temp_voldpos][2];
					VehicleObjects[id][slot][object_rx] = PlayerTemp[playerid][temp_voldpos][3];
					VehicleObjects[id][slot][object_ry] = PlayerTemp[playerid][temp_voldpos][4];
					VehicleObjects[id][slot][object_rz] = PlayerTemp[playerid][temp_voldpos][5];
					Vehicle_ObjectUpdate(id, slot);
					//Streamer_Update(playerid);
					PlayerData[playerid][pGetVTOYID] = 
					PlayerData[playerid][pVtoySelect] = -1;
					return 1;
				}
				GivePlayerMoneyEx(playerid, -VEHICLE_OBJECT_EDIT_PRICE);
				
				/*
					Memakai rumus trigonometri sederhana, yaitu 

					offset_x = x * cos0 + y * sin0
					offset_y = y * cos0 - x * cos0	

					Sekolah makanya, kalo mau tau rumus yang lebih berguna dari rumus tersebut.
					Setiap hal tidak luput dari MTK
				*/
				VehicleObjects[id][slot][object_x] = ((x - vpos[0]) * floatcos(VehicleData[id][cPosA], degrees)) + ((y - vpos[1]) * floatsin(VehicleData[id][cPosA], degrees));
				VehicleObjects[id][slot][object_y] = ((y - vpos[1]) * floatcos(VehicleData[id][cPosA], degrees)) - ((x - vpos[0]) * floatsin(VehicleData[id][cPosA], degrees));
				VehicleObjects[id][slot][object_z] = z - vpos[2];
				VehicleObjects[id][slot][object_rx] = rx;
				VehicleObjects[id][slot][object_ry] = ry;
				VehicleObjects[id][slot][object_rz] = rz - vpos[3];

				PlayerData[playerid][pGetVTOYID] = 
				PlayerData[playerid][pVtoySelect] = -1;

				PlayerPlaySound(playerid, SOUND_CAR_MOD);

				Vehicle_ObjectUpdate(id, slot, 1);
				Vehicle_ObjectSave(id, slot);
				//Streamer_Update(playerid);
				SendCustomMessage(playerid, "MODSHOP", "Your vehicle modification has been saved.");
			}
		}
	}
	if(PlayerData[playerid][pEditID] != -1)
	{
		new id = PlayerData[playerid][pEditID], 
			type = PlayerData[playerid][pEditType];
		
		if(type == EDIT_ATM)
		{
			if(response == EDIT_RESPONSE_FINAL)
			{
				AtmData[id][atmX] = x;
				AtmData[id][atmY] = y;
				AtmData[id][atmZ] = z;
				AtmData[id][atmRX] = rx;
				AtmData[id][atmRY] = ry;
				AtmData[id][atmRZ] = rz;

				SetDynamicObjectPos(objectid, AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ]);
				SetDynamicObjectRot(objectid, AtmData[id][atmRX], AtmData[id][atmRY], AtmData[id][atmRZ]);

				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[id][atmLabel], E_STREAMER_X, AtmData[id][atmX]);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[id][atmLabel], E_STREAMER_Y, AtmData[id][atmY]);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[id][atmLabel], E_STREAMER_Z, AtmData[id][atmZ] + 0.3);

				Atm_Save(id);
			}
			else if(response == EDIT_RESPONSE_CANCEL)
			{
				SetDynamicObjectPos(objectid, AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ]);
				SetDynamicObjectRot(objectid, AtmData[id][atmRX], AtmData[id][atmRY], AtmData[id][atmRZ]);
			}
		}
		else if(type == EDIT_TREE) 
		{
			if(response == EDIT_RESPONSE_FINAL)
			{
				TreeData[id][treeX] = x;
				TreeData[id][treeY] = y;
				TreeData[id][treeZ] = z;
				TreeData[id][treeRX] = rx;
				TreeData[id][treeRY] = ry;
				TreeData[id][treeRZ] = rz;

				SetDynamicObjectPos(objectid, TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ]);
				SetDynamicObjectRot(objectid, TreeData[id][treeRX], TreeData[id][treeRY], TreeData[id][treeRZ]);

				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[id][treeLabel], E_STREAMER_X, TreeData[id][treeX]);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[id][treeLabel], E_STREAMER_Y, TreeData[id][treeY]);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[id][treeLabel], E_STREAMER_Z, TreeData[id][treeZ] + 1.5);

				Tree_Save(id);
			}
			else if(response == EDIT_RESPONSE_CANCEL)
			{
				SetDynamicObjectPos(objectid, TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ]);
				SetDynamicObjectRot(objectid, TreeData[id][treeRX], TreeData[id][treeRY], TreeData[id][treeRZ]);
			}
		}
		else if(type == EDIT_ORE)
		{
			if(response == EDIT_RESPONSE_FINAL)
			{
				OreData[id][oreX] = x;
				OreData[id][oreY] = y;
				OreData[id][oreZ] = z;
				OreData[id][oreRX] = rx;
				OreData[id][oreRY] = ry;
				OreData[id][oreRZ] = rz;

				SetDynamicObjectPos(objectid, OreData[id][oreX], OreData[id][oreY], OreData[id][oreZ]);
				SetDynamicObjectRot(objectid, OreData[id][oreRX], OreData[id][oreRY], OreData[id][oreRZ]);

				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[id][oreLabel], E_STREAMER_X, OreData[id][oreX]);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[id][oreLabel], E_STREAMER_Y, OreData[id][oreY]);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[id][oreLabel], E_STREAMER_Z, OreData[id][oreZ] + 1.5);

				Ore_Save(id);
			}
			else if(response == EDIT_RESPONSE_CANCEL)
			{
				SetDynamicObjectPos(objectid, OreData[id][oreX], OreData[id][oreY], OreData[id][oreZ]);
				SetDynamicObjectRot(objectid, OreData[id][oreRX], OreData[id][oreRY], OreData[id][oreRZ]);
			}
		}
		else if(type == EDIT_GATE)
		{
			if(response == EDIT_RESPONSE_CANCEL)
			{
				SetDynamicObjectPos(objectid, gPosX[playerid], gPosY[playerid], gPosZ[playerid]);
				SetDynamicObjectRot(objectid, gRotX[playerid], gRotY[playerid], gRotZ[playerid]);
				gPosX[playerid] = 0; gPosY[playerid] = 0; gPosZ[playerid] = 0;
				gRotX[playerid] = 0; gRotY[playerid] = 0; gRotZ[playerid] = 0;
				SendServerMessage(playerid, " You have canceled editing gate ID %d.", id);
				Gate_Save(id);
			}
			else if(response == EDIT_RESPONSE_FINAL)
			{
				SetDynamicObjectPos(objectid, x, y, z);
				SetDynamicObjectRot(objectid, rx, ry, rz);
				if(PlayerData[playerid][gEdit] == 1)
				{
					gData[id][gCX] = x;
					gData[id][gCY] = y;
					gData[id][gCZ] = z;
					gData[id][gCRX] = rx;
					gData[id][gCRY] = ry;
					gData[id][gCRZ] = rz;
					if(IsValidDynamic3DTextLabel(gData[id][gText])) DestroyDynamic3DTextLabel(gData[id][gText]);
					new str[64];
					format(str, sizeof(str), "Gate ID: %d", id);
					gData[id][gText] = CreateDynamic3DTextLabel(str, COLOR_WHITE, gData[id][gCX], gData[id][gCY], gData[id][gCZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 10.0);
					
					PlayerData[playerid][gEdit] = 0;
					SendServerMessage(playerid, " You have finished editing gate ID %d's closing position.", id);
					gData[id][gStatus] = 0;
					Gate_Save(id);
				}
				else if(PlayerData[playerid][gEdit] == 2)
				{
					gData[id][gOX] = x;
					gData[id][gOY] = y;
					gData[id][gOZ] = z;
					gData[id][gORX] = rx;
					gData[id][gORY] = ry;
					gData[id][gORZ] = rz;
					
					PlayerData[playerid][gEdit] = 0;
					SendServerMessage(playerid, " You have finished editing gate ID %d's opening position.", id);

					gData[id][gStatus] = 1;
					Gate_Save(id);
				}
			}
		}
	}
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(checkpointid == PlayerData[playerid][LoadingPoint])
	{
	    if(GetPVarInt(playerid, "LoadingCooldown") > gettime()) return 1;
		new vehicleid = GetPVarInt(playerid, "LastVehicleID"), type[64], carid;
		if(PlayerData[playerid][CarryingLog] == 0)
		{
			type = "Metal";
		}
		else if(PlayerData[playerid][CarryingLog] == 1)
		{
			type = "Coal";
		}
		else
		{
			type = "Unknown";
		}
		if(Vehicle_LogCount(vehicleid) >= LOG_LIMIT) return SendErrorMessage(playerid, "You can't load any more ores to this vehicle.");
		if((carid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(PlayerData[playerid][CarryingLog] == 0)
			{
				VehicleData[carid][cMetal] += 1;
			}
			else if(PlayerData[playerid][CarryingLog] == 1)
			{
				VehicleData[carid][cCoal] += 1;
			}
		}
		LogStorage[vehicleid][ PlayerData[playerid][CarryingLog] ]++;
		SendInfoMessage(playerid, "MINING: Loaded %s.", type);
		ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, false, true, true, false, 0, SYNC_ALL);
		Player_RemoveLog(playerid);
		return 1;
	}
	if(checkpointid == ShowRoomCP)
	{
		ShowPlayerDialog(playerid, DIALOG_BUYPVCP, DIALOG_STYLE_LIST, "Showroom", "Motorcycle\nMobil\nKendaraan Unik\nKendaraan Job", "Select", "Cancel");
	}
	if(checkpointid == ShowRoomCPRent)
	{
		new str[1024];
		format(str, sizeof(str), "Kendaraan\tHarga\n"WHITE_E"%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days",
		GetVehicleModelName(414), 
		GetVehicleModelName(455), 
		GetVehicleModelName(456),
		GetVehicleModelName(498),
		GetVehicleModelName(499),
		GetVehicleModelName(609),
		GetVehicleModelName(478),
		GetVehicleModelName(422),
		GetVehicleModelName(543),
		GetVehicleModelName(554),
		GetVehicleModelName(525),
		GetVehicleModelName(438),
		GetVehicleModelName(420)
		);
		
		ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARS, DIALOG_STYLE_TABLIST_HEADERS, "Rent Job Cars", str, "Rent", "Close");
	}
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(Player_InBus(playerid) && PlayerData[playerid][pSideJob] == 2)
		return Player_BusCP(playerid);
	else if(Player_InSweeper(playerid) && PlayerData[playerid][pSideJob] == 1)
		return Player_SweeperCP(playerid);

	DisablePlayerRaceCheckpoint(playerid);
	PlayerPlaySound(playerid, SOUND_CHECKPOINT);

	if(PlayerData[playerid][pTrackCar] == 1)
	{
		SendInfoMessage(playerid, "Anda telah berhasil menemukan kendaraan anda!");
		PlayerData[playerid][pTrackCar] = 0;
	}
	if(PlayerData[playerid][pTrackHouse] == 1)
	{
		SendInfoMessage(playerid, "Anda telah berhasil menemukan rumah anda!");
		PlayerData[playerid][pTrackHouse] = 0;
	}
	if(PlayerData[playerid][pTrackBisnis] == 1)
	{
		SendInfoMessage(playerid, "Anda telah berhasil menemukan bisnis anda!");
		PlayerData[playerid][pTrackBisnis] = 0;
	}
	if(PlayerData[playerid][pMission] > -1)
	{
		SendInfoMessage(playerid, "/buy , /gps(My Mission) , /storeproduct.");
	}
	if(PlayerData[playerid][pHauling] > -1)
	{
		new hauling = PlayerData[playerid][pHauling];
		if(!IsPlayerInRangeOfPoint(playerid, 5.5, gsData[hauling][gsPosX], gsData[hauling][gsPosY], gsData[hauling][gsPosZ]) && !IsPlayerInRangeOfPoint(playerid, 5.5, 336.70, 895.54, 20.40))
		{
			if(VehGasOil[GetPlayerVehicleID(playerid)] > 0)
			{
				SendCustomMessage(playerid, "HAULING", "Go to {ffff00}%s Gas Station{ffffff}!", GetLocation(gsData[hauling][gsPosX], gsData[hauling][gsPosY], gsData[hauling][gsPosZ]));
				SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, gsData[hauling][gsPosX], gsData[hauling][gsPosY], gsData[hauling][gsPosZ], 0, 0, 0, 5.5);
			}
			else
			{
				SendCustomMessage(playerid, "HAULING", "You have to buy {ffff00}GasOil{ffffff} first.");
				SetPlayerRaceCheckpoint(playerid, CP_TYPE:1, 336.70, 895.54, 20.40, 0, 0, 0, 5.5);
			}

			switch(random(3))
			{
				case 0: PlayerData[playerid][pTrailer] = CreateVehicle(584, 330.6683, 842.4801, 20.6137, 310.0969, -1, -1, -1, false);
				case 1: PlayerData[playerid][pTrailer] = CreateVehicle(584, 358.1325, 848.6687, 20.6553, 27.6431, -1, -1, -1, false);
				case 2: PlayerData[playerid][pTrailer] = CreateVehicle(584, 318.0404, 868.0350, 21.0076, 297.4508, -1, -1, -1, false);
			}
			//AttachTrailerToVehicle(PlayerData[playerid][pTrailer], GetPlayerVehicleID(playerid));
		}
		else
		{
			if(!IsPlayerInRangeOfPoint(playerid, 5.5, 336.70, 895.54, 20.40))
				SendCustomMessage(playerid, "HAULING", "Gunakan {ffff00}'/storegas'{ffffff} untuk mengisi stock Gas Station.");
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(Player_InForklift(playerid) && PlayerData[playerid][pSideJob] == 3)
		return Player_ForkliftCP(playerid);

	DisablePlayerCheckpoint(playerid);
	PlayerPlaySound(playerid, SOUND_CHECKPOINT);

	DMV_EnterCheckpoint(playerid);
	//new PLAYER_STATE:playerState = GetPlayerState(playerid);
	if(PlayerData[playerid][pCP] == 1)
	{

	}
	if(PlayerData[playerid][CarryingLog] != -1)
	{
		if(GetPVarInt(playerid, "LoadingCooldown") > gettime()) return 1;
		new vehicleid = GetPVarInt(playerid, "LastVehicleID"), type[64], carid;
		if(PlayerData[playerid][CarryingLog] == 0)
		{
			type = "Metal";
		}
		else if(PlayerData[playerid][CarryingLog] == 1)
		{
			type = "Coal";
		}
		else
		{
			type = "Unknown";
		}
		if(Vehicle_LogCount(vehicleid) >= LOG_LIMIT) return SendErrorMessage(playerid, "You can't load any more ores to this vehicle.");
		if((carid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(PlayerData[playerid][CarryingLog] == 0)
			{
				VehicleData[carid][cMetal] += 1;
			}
			else if(PlayerData[playerid][CarryingLog] == 1)
			{
				VehicleData[carid][cCoal] += 1;
			}
		}
		LogStorage[vehicleid][ PlayerData[playerid][CarryingLog] ]++;
		SendInfoMessage(playerid, "MINING: Loaded %s.", type);
		ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, false, true, true, false, 0, SYNC_ALL);
		Player_RemoveLog(playerid);
		DisablePlayerCheckpoint(playerid);
		return 1;
	}
	if(PlayerData[playerid][pFindEms] != INVALID_PLAYER_ID)
	{
		PlayerData[playerid][pFindEms] = INVALID_PLAYER_ID;
		DisablePlayerCheckpoint(playerid);
	}
	//DisablePlayerCheckpoint(playerid);
	return 1;
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	new Fire_Streamer_Info[2];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, Fire_Streamer_Info);

    if(Fire_Streamer_Info[0] == FIRE_AREA_INDEX)
    {
        new index = Fire_Streamer_Info[1];

        if(Fire_IsExists(index)) 
        {
        	Fire_SetInside(playerid, index);
            PlayerPlaySound(playerid, 3401, 0.0, 0.0, 0.0);
        }
    }

	if(IsPlayerConnected(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		forex(fan, sizeof(PaytollAreaid))
		{
			if(areaid == PaytollAreaid[fan])
			{
				GameTextForPlayer(playerid, "~w~~h~PAYTOLL AREA~n~~r~~h~ /PAYTOLL ~n~~w~~h~TO OPEN TOLL GATE", 3000, 4);
			}
		}
	}

	foreach(new ii : Player)
	{
		if(GetPVarInt(ii, "PlacedBB"))
		{
			new bbtext[128];
			GetPVarString(ii, "BBStation", bbtext, sizeof(bbtext));
			if(strlen(bbtext) > 0 && areaid == GetPVarInt(ii, "BBArea") && playerPlaylist[playerid] == 0)
			{
				PlayStream(playerid, bbtext, GetPVarFloat(ii, "BBX"), GetPVarFloat(ii, "BBY"), GetPVarFloat(ii, "BBZ"), 30.0, true);
			}
		}
	}
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	new Fire_Streamer_Info[1];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, Fire_Streamer_Info);

    if(Fire_Streamer_Info[0] == FIRE_AREA_INDEX) 
    {
    	Fire_SetInside(playerid, INVALID_FIRE_ID);
        PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);
    }

    foreach(new ii : Player)
	{
		if(GetPVarInt(ii, "PlacedBB"))
		{
			if(areaid == GetPVarInt(ii, "BBArea") && playerPlaylist[playerid] == 0)
			{
				StopStream(playerid);
			}
		}
	}
    return 1;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if(PRESSED(KEY_JUMP))
	{
		static vehicleid;

		if(IsPlayerInAnyVehicle(playerid) && ((vehicleid = GetPlayerVehicleID(playerid)) != INVALID_VEHICLE_ID))
		{
			if(GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 510) {
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				SetPlayerPos(playerid, x, y, z);

				ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, false, true, true, true, 0, SYNC_ALL);
			}
		}
	}
	if(HOLDING(KEY_FIRE))
    {
        new fireid = Fire_GetInside(playerid);
        if(fireid != INVALID_FIRE_ID)
        {
            if(GetPlayerWeapon(playerid) == WEAPON_FIREEXTINGUISHER && IsPlayerInFirePoint(playerid, fireid, 5.0))
            {
                if(FireData[fireid][fireHealth] > 0) 
                {
                    FireData[fireid][fireHealth] -= 10.0;
                }
                else if(FireData[fireid][fireHealth] <= 0)
                {
                    FireData[fireid][fireHealth] = 0;
                    Fire_Delete(fireid);
                }
            }
            else if(IsPlayerInFireTruck(playerid) && IsPlayerInFirePoint(playerid, fireid, 20.0))
            {
                if(FireData[fireid][fireHealth] > 0) 
                {
                    FireData[fireid][fireHealth] -= 20.0;
                }
                else if(FireData[fireid][fireHealth] <= 0)
                {
                    FireData[fireid][fireHealth] = 0;
                    Fire_Delete(fireid);
                }
            }
        }
    }

	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && (newkeys & KEY_NO))
	{
	    if(PlayerData[playerid][CarryingLumber])
		{
			Player_DropLumber(playerid);
		}
		else if(PlayerData[playerid][CarryingLog] == 0)
		{
			Player_DropLog(playerid, PlayerData[playerid][CarryingLog]);
			SendInfoMessage(playerid, "You dropping metal ore.");
			DisablePlayerCheckpoint(playerid);
		}
		else if(PlayerData[playerid][CarryingLog] == 1)
		{
			Player_DropLog(playerid, PlayerData[playerid][CarryingLog]);
			SendInfoMessage(playerid, "You dropping coal ore.");
			DisablePlayerCheckpoint(playerid);
		}
	}
	if((newkeys & KEY_SPRINT))
	{
		if(PlayerData[playerid][pCargoCrate] && PlayerData[playerid][pCargoID] != -1)
		{
			Box_PutOn(playerid, PUTON_GROUND);
			SendClientMessage(playerid, ARWIN, "TRUCKER: {ffffff}Cargo jatuh!");
		}
	}
	if((newkeys & KEY_SECONDARY_ATTACK))
    {
		foreach(new did : Doors)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
			{
				if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
					return SendErrorMessage(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

				if(dData[did][dLocked])
					return SendErrorMessage(playerid, "This entrance is locked at the moment.");
					
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != PlayerData[playerid][pFaction])
						return SendErrorMessage(playerid, "This door only for faction.");
				}
				if(dData[did][dFamily] > 0)
				{
					if(dData[did][dFamily] != PlayerData[playerid][pFamily])
						return SendErrorMessage(playerid, "This door only for family.");
				}
				
				if(dData[did][dVip] > PlayerData[playerid][pVip])
					return SendErrorMessage(playerid, "Your VIP level not enough to enter this door.");
				
				if(dData[did][dAdmin] > PlayerData[playerid][pAdmin])
					return SendErrorMessage(playerid, "Your admin level not enough to enter this door.");
					
				if(strlen(dData[did][dPass]))
				{
					new params[256];
					if(sscanf(params, "s[256]", params)) return SendSyntaxMessage(playerid, "/enter [password]");
					if(strcmp(params, dData[did][dPass])) return SendErrorMessage(playerid, "Invalid door password.");
					
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					PlayerData[playerid][pInDoor] = did;
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 1);
				}
				else
				{
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					PlayerData[playerid][pInDoor] = did;
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 1);
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
			{
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != PlayerData[playerid][pFaction])
						return SendErrorMessage(playerid, "This door only for faction.");
				}
				
				if(dData[did][dCustom])
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				else
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				PlayerData[playerid][pInDoor] = -1;
				SetPlayerInterior(playerid, dData[did][dExtint]);
				SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
			}
        }
		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return SendErrorMessage(playerid, "Interior bisnis masih kosong, atau tidak memiliki interior.");

				if(bData[bid][bLocked])
					return SendErrorMessage(playerid, "This bisnis is locked!");
					
				PlayerData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);
				
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 1);
			}
        }
		new inbisnisid = PlayerData[playerid][pInBiz];
		if(PlayerData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, bData[inbisnisid][bIntposX], bData[inbisnisid][bIntposY], bData[inbisnisid][bIntposZ]))
		{
			PlayerData[playerid][pInBiz] = -1;
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);
			
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return SendErrorMessage(playerid, "Interior house masih kosong, atau tidak memiliki interior.");

				if(hData[hid][hLocked])
					return SendErrorMessage(playerid, "This house is locked!");
				
				PlayerData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 1);
			}
        }
		new inhouseid = PlayerData[playerid][pInHouse];
		if(PlayerData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			PlayerData[playerid][pInHouse] = -1;
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);
			
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return SendErrorMessage(playerid, "Interior masih kosong, atau tidak memiliki interior.");

				if(PlayerData[playerid][pFaction] == 0)
					if(PlayerData[playerid][pFamily] == -1)
						return SendErrorMessage(playerid, "You dont have registered for this door!");
					
				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				//PlayerData[playerid][pInBiz] = fid;
				SetPlayerWeather(playerid, 1);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ]))
			{
				SetPlayerPositionEx(playerid, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ], fData[fid][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
				//PlayerData[playerid][pInBiz] = -1;
			}
        }
	}
	//SAPD Taser/Tazer
	if(newkeys & KEY_FIRE && TaserData[playerid][TaserEnabled] && GetPlayerWeapon(playerid) == WEAPON_FIST && !IsPlayerInAnyVehicle(playerid) && TaserData[playerid][TaserCharged])
	{
  		TaserData[playerid][TaserCharged] = false;

	    new Float: x, Float: y, Float: z, Float: health;
     	GetPlayerPos(playerid, x, y, z);
	    PlayerPlaySound(playerid, 6003, 0.0, 0.0, 0.0);
	    ApplyAnimation(playerid, "KNIFE", "KNIFE_3", 4.1, false, true, true, false, 0, SYNC_ALL);
		PlayerData[playerid][pActivityTime] = 0;
	    TaserData[playerid][ChargeTimer] = SetTimerEx("ChargeUp", 1000, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Recharge...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);

	    for(new i, maxp = MAX_PLAYERS; i <= maxp; ++i)
		{
	        if(!IsPlayerConnected(i)) continue;
          	if(playerid == i) continue;
          	if(TaserData[i][TaserCountdown] != 0) continue;
          	if(IsPlayerInAnyVehicle(i)) continue;
			if(GetPlayerDistanceFromPoint(i, x, y, z) > 2.0) continue;
			ClearAnimations(i, SYNC_ALL);
			TogglePlayerControllable(i, false);
   			ApplyAnimation(i, "CRACK", "crckdeth2", 4.1, false, false, false, true, 0, SYNC_ALL);
			PlayerPlaySound(i, 6003, 0.0, 0.0, 0.0);

			GetPlayerHealth(i, health);
			TaserData[i][TaserCountdown] = TASER_BASETIME + floatround((100 - health) / 12);
   			SendInfoMessage(i, "You got tased for %d secounds!", TaserData[i][TaserCountdown]);
			TaserData[i][GetupTimer] = SetTimerEx("TaserGetUp", 1000, true, "i", i);
			break;
	    }
	}
	//Vehicle
	if((newkeys & KEY_YES ) && !fishing[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			ShowPlayerDialog(playerid, DIALOG_VEHICLE_PANEL, DIALOG_STYLE_LIST, sprintf("%s's Panel", GetVehicleName(GetPlayerVehicleID(playerid))), "Engine\nLights\nWindows\nLock/Unlock\nVehicle Accessories\nOpen Inventory\nOpen Gate", "Pilih", "Keluar");
		}
		else
		{
			new vehicleid = GetNearestVehicleToPlayer(playerid,4.0,false);
			if(Vehicle_GetID(vehicleid) != -1)
			{
				callcmd::vstorage(playerid);
			}
			else
				callcmd::inventory(playerid, "");
		}
	}
	if((newkeys & KEY_NO ))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			
		}
		else
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, paX, paY, paZ))
			{
				callcmd::pickuppacket(playerid);
			}
			else if(GetPlayerWeapon(playerid) != WEAPON_FIST)
			{
				callcmd::weapon(playerid, "drop");
			}
			else if(rodAttached[playerid]) 
			{
				callcmd::fish(playerid, "");
			}
			else
				callcmd::weapon(playerid, "pickup");
		}
	}
	if((newkeys & KEY_SUBMISSION))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			//cmd_lock(playerid, "");
		}
	}
	if(GetPVarInt(playerid, "UsingSprunk"))
	{
		if(PlayerData[playerid][pEnergy] >= 100 )
		{
  			SendInfoMessage(playerid, " Kamu terlalu banyak minum.");
	   	}
	   	else
	   	{
		    PlayerData[playerid][pEnergy] += 5;
		}
	}
	if(PRESSED( KEY_WALK ))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(!GetEngineStatus(vehicleid))
			{
				if(GetVehicleSpeed(vehicleid) <= 40)
				{
					new PLAYER_STATE:playerState = GetPlayerState(playerid);
					if(playerState == PLAYER_STATE_DRIVER)
					{
						SendClientMessageToAll(COLOR_RED, "Anti-Bug User: "GREY2_E"%s have been auto kicked for vehicle engine hack!", PlayerData[playerid][pName]);
						KickEx(playerid);
					}
				}
			}
		}
	}
	if(PRESSED( KEY_FIRE ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
		{
			foreach(new did : Doors)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
							return SendErrorMessage(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

						if(dData[did][dLocked])
							return SendErrorMessage(playerid, "This entrance is locked at the moment.");
							
						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != PlayerData[playerid][pFaction])
								return SendErrorMessage(playerid, "This door only for faction.");
						}
						if(dData[did][dFamily] > 0)
						{
							if(dData[did][dFamily] != PlayerData[playerid][pFamily])
								return SendErrorMessage(playerid, "This door only for family.");
						}
						
						if(dData[did][dVip] > PlayerData[playerid][pVip])
							return SendErrorMessage(playerid, "Your VIP level not enough to enter this door.");
						
						if(dData[did][dAdmin] > PlayerData[playerid][pAdmin])
							return SendErrorMessage(playerid, "Your admin level not enough to enter this door.");
							
						if(strlen(dData[did][dPass]))
						{
							new params[256];
							if(sscanf(params, "s[256]", params)) return SendSyntaxMessage(playerid, "/enter [password]");
							if(strcmp(params, dData[did][dPass])) return SendErrorMessage(playerid, "Invalid door password.");
							
							if(dData[did][dCustom])
							{
								SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							else
							{
								SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							PlayerData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 1);
						}
						else
						{
							if(dData[did][dCustom])
							{
								SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							else
							{
								SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							PlayerData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 1);
						}
					}
				}
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != PlayerData[playerid][pFaction])
								return SendErrorMessage(playerid, "This door only for faction.");
						}
					
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
						}
						PlayerData[playerid][pInDoor] = -1;
						SetPlayerInterior(playerid, dData[did][dExtint]);
						SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, WorldWeather);
					}
				}
			}
		}
	}
	//if(IsKeyJustDown(KEY_CTRL_BACK,newkeys,oldkeys))
	if(PRESSED( KEY_CTRL_BACK ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			callcmd::astop(playerid, "");
		}
    }
	if(IsKeyJustDown(KEY_SECONDARY_ATTACK, newkeys, oldkeys))
	{
		if(GetPVarInt(playerid, "UsingSprunk"))
		{
			DeletePVar(playerid, "UsingSprunk");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
	}
	if(newkeys & KEY_CROUCH)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			forex(fan, sizeof(PaytollAreaid)) if(IsPlayerInDynamicArea(playerid, PaytollAreaid[fan]))
			{
				callcmd::paytoll(playerid, "");
			}
		}
	}
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	if(PlayerData[playerid][playerSpectated] != 0)
	{
		foreach(new ii : Player)
		{
			if(PlayerData[ii][pSpec] == playerid)
			{
				GameTextForPlayer(ii, sprintf("old interior : %d~n~new interior : %d~n~~n~", oldinteriorid, newinteriorid), 3000, 3);
				SendServerMessage(ii, "%s(%i) is now in interior %d.", PlayerData[playerid][pName], playerid, newinteriorid);

				if(IsPlayerInAnyVehicle(playerid))
					PlayerSpectateVehicle(ii, GetPlayerVehicleID(playerid));
				else
					PlayerSpectatePlayer(ii, playerid);
			}
		}
	}
	return 1;
}

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	if(newstate == PLAYER_STATE_WASTED && PlayerData[playerid][pJail] < 1 && !IsAtEvent[playerid])
    {	
		if(PlayerData[playerid][pInjured] == 0)
        {
            PlayerData[playerid][pInjured] = 1;
            SetPlayerHealthEx(playerid, 99999);

            PlayerData[playerid][pInt] = GetPlayerInterior(playerid);
            PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

            GetPlayerPos(playerid, PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ]);
            GetPlayerFacingAngle(playerid, PlayerData[playerid][pPosA]);

            new Float:pos[2];

            for(new fan; fan < 13; fan++) if(PlayerData[playerid][pGuns][fan] != WEAPON_FIST && PlayerData[playerid][pAmmo][fan] > 0)
            {
                pos[0] = PlayerData[playerid][pPosX] + ((random(3)+1) * floatsin(random(2) ? -PlayerData[playerid][pPosA] : PlayerData[playerid][pPosA], degrees));
                pos[1] = PlayerData[playerid][pPosY] + ((random(3)+1) * floatcos(random(2) ? -PlayerData[playerid][pPosA] : PlayerData[playerid][pPosA], degrees));

                DropWeapon(PlayerData[playerid][pName], GetWeaponModel(PlayerData[playerid][pGuns][fan]), PlayerData[playerid][pGuns][fan], PlayerData[playerid][pAmmo][fan], pos[0], pos[1], PlayerData[playerid][pPosZ] - 1, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
                ResetWeapon(playerid, PlayerData[playerid][pGuns][fan]);
            }
        }
        else
        {
            PlayerData[playerid][pHospital] = 1;
        }
	}
	if(newstate == PLAYER_STATE_WASTED)
	{
		if(!PlayerData[playerid][pWasted])
			PlayerData[playerid][pWasted] = true;
	}
	//Spec Player
	new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(PlayerData[playerid][playerSpectated] != 0)
		{
			foreach(new ii : Player)
			{
				if(PlayerData[ii][pSpec] == playerid)
				{
					PlayerSpectatePlayer(ii, playerid);
					SendServerMessage(ii, ,"%s(%i) is now on foot.", PlayerData[playerid][pName], playerid);
				}
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
		if(PlayerData[playerid][pInjured] == 1)
        {
            //RemoveFromVehicle(playerid);
			RemovePlayerFromVehicle(playerid);
            SetPlayerHealthEx(playerid, 99999);
        }
		foreach (new ii : Player) if(PlayerData[ii][pSpec] == playerid) 
		{
            PlayerSpectateVehicle(ii, GetPlayerVehicleID(playerid));
        }
	}
	if(oldstate == PLAYER_STATE_PASSENGER)
	{
		TextDrawHideForPlayer(playerid, TDEditor_TD[11]);
		TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
	}
	if(oldstate == PLAYER_STATE_DRIVER)
    {	
    	vehicleid = GetPVarInt(playerid, "LastVehicleID");
    	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
            return RemovePlayerFromVehicle(playerid);

		if(PlayerData[playerid][pSideJob] != 0)
		{
			Sidejob_Failed(playerid, GetPVarInt(playerid, "LastVehicleID"));
		}

		HBEVeh_Hide(playerid, 1);
		HBEVeh_Hide(playerid, 2);
		
		if(PlayerData[playerid][pTaxiDuty] == 1)
		{
			PlayerData[playerid][pTaxiDuty] = 0;
			SetPlayerColor(playerid, COLOR_WHITE);
			SendServerMessage(playerid, "You are no longer on taxi duty!");
		}
		if(PlayerData[playerid][pFare] == 1)
		{
			KillTimer(PlayerData[playerid][pFareTimer]);
			SendInfoMessage(playerid, "Anda telah menonaktifkan taxi fare pada total: {00FF00}%s", FormatMoney(PlayerData[playerid][pTotalFare]));
			PlayerData[playerid][pFare] = 0;
			PlayerData[playerid][pTotalFare] = 0;
		}
		if(GetVehicleSpeedCap(vehicleid) && !LockTyre_Locked(vehicleid))
		{
			DisableVehicleSpeedCap(vehicleid);
		}
        
		HidePlayerProgressBar(playerid, PlayerData[playerid][spfuelbar]);
        HidePlayerProgressBar(playerid, PlayerData[playerid][spdamagebar]);
		
        HidePlayerProgressBar(playerid, PlayerData[playerid][fuelbar]);
        HidePlayerProgressBar(playerid, PlayerData[playerid][damagebar]);
	}
	else if(newstate == PLAYER_STATE_DRIVER)
    {
    	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY)
            return RemovePlayerFromVehicle(playerid);

		foreach(new pv : PlayerVehicles)
		{
			if(vehicleid == VehicleData[pv][cVeh])
			{
				if(IsABike(vehicleid) || GetVehicleModel(vehicleid) == 424)
				{
					if(VehicleData[pv][cLocked] == 1)
					{
						RemovePlayerFromVehicle(playerid);
						SendErrorMessage(playerid, "This bike is locked by owner.");
						return 1;
					}
				}
			}
		}
		
		if(Player_InSweeper(playerid))
		{
			ShowPlayerDialog(playerid, DIALOG_SWEEPER, DIALOG_STYLE_MSGBOX, "Side Job - Sweeper", "Apakah kamu ingin memulai bekerja sebagai {FFFF00}'Sweeper'{FFFFFF}?\n\nTekan "GREEN_E"'Lanjut'"W" untuk memulai\nTekan "RED_E"'Kembali'"W" untuk membatalakan", "Lanjut", "Kembali");
		}
		if(Player_InBus(playerid))
		{
			ShowPlayerDialog(playerid, DIALOG_BUS, DIALOG_STYLE_MSGBOX, "Side Job - Bus", "Apakah kamu ingin memulai bekerja sebagai {FFFF00}'Bus Driver'{FFFFFF}?\n\nTekan "GREEN_E"'Lanjut'"W" untuk memulai\nTekan "RED_E"'Kembali'"W" untuk membatalakan", "Lanjut", "Kembali");
		}
		if(Player_InForklift(playerid))
		{
			ShowPlayerDialog(playerid, DIALOG_FORKLIFT, DIALOG_STYLE_MSGBOX, "Side Job - Forklift", "Apakah kamu ingin memulai bekerja sebagai {FFFF00}'Forklift Worker'{FFFFFF}?\n\nTekan "GREEN_E"'Lanjut'"W" untuk memulai\nTekan "RED_E"'Kembali'"W" untuk membatalakan", "Lanjut", "Kembali");
		}
		
		if(!IsEngineVehicle(vehicleid))
        {
            SwitchVehicleEngine(vehicleid, true);
        }

		if(IsEngineVehicle(vehicleid))
        {
        	SendVehicleMessage(playerid, "Gunakan {ffff00}Key Y{ffffff} untuk panel kendaraan!");

        	if(PlayerData[playerid][pDriveLic] <= 0)
            	SendInfoMessage(playerid, "Anda tidak memiliki surat izin mengemudi, berhati-hatilah.");
            else
            {
            	if(PlayerData[playerid][pDriveLicTime] == 0)
            	{
            		SendInfoMessage(playerid, "Segera untuk memperbarui surat izin mengemudi di DMV!");
            	}
            }
        }
		HBEVeh_Show(playerid, PlayerData[playerid][pHBEMode]);

		new Float:health;
        GetVehicleHealth(GetPlayerVehicleID(playerid), health);
        VehicleHealthSecurityData[GetPlayerVehicleID(playerid)] = health;
        VehicleHealthSecurity[GetPlayerVehicleID(playerid)] = true;
		
		if(PlayerData[playerid][playerSpectated] != 0)
  		{
			foreach(new ii : Player)
			{
    			if(PlayerData[ii][pSpec] == playerid)
			    {
        			PlayerSpectateVehicle(ii, vehicleid);
				    SendServerMessage(ii, "%s(%i) is now driving a %s(%d).", PlayerData[playerid][pName], playerid, GetVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
				}
			}
		}
		SetPVarInt(playerid, "LastVehicleID", vehicleid);
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == BULLET_HIT_TYPE_PLAYER)
	{
		if(IsPlayerConnected(hitid))
		{
			if(PlayerData[playerid][pGuns][g_aWeaponSlots[weaponid]] != weaponid)
			{
				Blacklist_AddChar(playerid, "Bot HopePride", "Menggunakan Weapon Hack", 0, PlayerData[playerid][pIP]);
				SendClientMessageToAll(COLOR_LRED, "Fann: %s has been banned from HopePride.", NormalName(playerid));
				SendClientMessageToAll(COLOR_LRED, "Reason : Menggunakan Weapon Hack");
				SetWeapons(playerid);
				return 1;
			}

			if(IsAtEvent[playerid] && IsAtEvent[hitid])
			{
				if(PlayerData[hitid][pFreeze])
				{
					new Float:health;
					GetPlayerHealth(hitid, health);
					SetPlayerHealth(hitid, health);
					SendCustomMessage(playerid, "EVENT", "That player is spawning!");

					if(++ playerWarnEvent[playerid] == 3)
					{
						new tempteam = Team_Get(playerid);
					    IsAtEvent[playerid] = 0;
					    PlayerTemp[playerid][temp_team] = -1;
					    PlayerTemp[playerid][temp_teampos] = -1;
					    TeamData[tempteam][eCount]--;
					    IsAtEvent[playerid] = 0;
					    playerWarnEvent[playerid] = 0;
					    SendCustomMessage(playerid, "EVENT", "Kamu dikick dari Event karna menembak player yang sedang spawn!");
					    ResetPlayerWeaponsEx(playerid);
					    SetFactionColor(playerid);
					   
					    SetPlayerInterior(playerid, PlayerData[playerid][pInt]);
					    SetPlayerVirtualWorld(playerid, PlayerData[playerid][pWorld]);
					    SetPlayerPositionEx(playerid, PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ], PlayerData[playerid][pPosA], 5000);
					}
				}
			}
		}
	}
	else if(hittype == BULLET_HIT_TYPE_VEHICLE)
	{
		if(PlayerData[playerid][pGuns][g_aWeaponSlots[weaponid]] != weaponid)
		{
			Blacklist_AddChar(playerid, "Bot HopePride", "Menggunakan Weapon Hack", 0, PlayerData[playerid][pIP]);
			SendClientMessageToAll(COLOR_LRED, "Fann: %s has been banned from HopePride.", NormalName(playerid));
			SendClientMessageToAll(COLOR_LRED, "Reason : Menggunakan Weapon Hack");
			SetWeapons(playerid);
			return 1;
		}

		new Float:health, Float:damage = EVF::WeaponDamage[GetPlayerWeapon(playerid)];
		GetVehicleHealth(hitid, health);

		if(health-damage >= 200)
			SetValidVehicleHealth(hitid, health-damage);
	}

	if(IsAmmoWeapon(weaponid) || IsCountableWeapon(weaponid)) 
	{
		if(PlayerData[playerid][pGuns][g_aWeaponSlots[weaponid]] == weaponid)
		{
			PlayerData[playerid][pAmmo][g_aWeaponSlots[weaponid]]--;
			if(PlayerData[playerid][pGuns][g_aWeaponSlots[weaponid]] != WEAPON_FIST && !PlayerData[playerid][pAmmo][g_aWeaponSlots[weaponid]])
			{
				SendInfoMessage(playerid, "The {ffff00}%s{ffffff} has runs of bullets", ReturnWeaponName(weaponid));
				ResetWeapon(playerid, weaponid);
			}
			UpdateWeapons(playerid);
		}
		UpdateWeapons(playerid);
	}
	return 1;
}

public OnPlayerStartAim(playerid, WEAPON:weaponid)
{
	if(PlayerData[playerid][pGuns][g_aWeaponSlots[weaponid]] == weaponid)
	{
		if(PlayerData[playerid][pGuns][g_aWeaponSlots[weaponid]] != WEAPON_FIST && !PlayerData[playerid][pAmmo][g_aWeaponSlots[weaponid]])
		{
			SendInfoMessage(playerid, "The {ffff00}%s{ffffff} has runs of bullets", ReturnWeaponName(weaponid));
			ResetWeapon(playerid, weaponid);
		}
		else
		{
			if(PlayerData[playerid][pRHand] < 30 && PlayerData[playerid][pLHand] < 30)
			{
				SetPlayerArmedWeapon(playerid, WEAPON_FIST);
				SendCustomMessage(playerid, "PLAYER", "Tanganmu sudah tidak kuat untuk memegang senjata!");
			}
			UpdateWeapons(playerid);
		}
	}
	return 1;
}

stock GivePlayerHealth(playerid,Float:Health)
{
	new Float:health; GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+Health);
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	new
        Float: vehicleHealth,
        playerVehicleId = GetPlayerVehicleID(playerid);

    new Float:health;
    GetPlayerHealth(playerid, health);
    GetVehicleHealth(playerVehicleId, vehicleHealth);
    new VEHICLE_PANEL_STATUS:panels, VEHICLE_DOOR_STATUS:doors, VEHICLE_LIGHT_STATUS:lights, VEHICLE_TYRE_STATUS:tires;
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    if(PlayerData[playerid][pSeatBelt] == 0 || PlayerData[playerid][pHelmetOn] == 0)
    {
    	if(GetVehicleSpeed(vehicleid) >= 90)
    	{
    		new asakit = RandomEx(0, 3);
    		new bsakit = RandomEx(0, 3);
    		new csakit = RandomEx(0, 3);
    		new dsakit = RandomEx(0, 3);
    		PlayerData[playerid][pLFoot] -= csakit;
    		PlayerData[playerid][pLHand] -= csakit;
    		PlayerData[playerid][pRFoot] -= dsakit;
    		PlayerData[playerid][pRHand] -= bsakit;
    		PlayerData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -5);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) >= 50)
    	{
    		new asakit = RandomEx(0, 2);
    		new bsakit = RandomEx(0, 2);
    		new csakit = RandomEx(0, 2);
    		new dsakit = RandomEx(0, 2);
    		PlayerData[playerid][pLFoot] -= dsakit;
    		PlayerData[playerid][pLHand] -= bsakit;
    		PlayerData[playerid][pRFoot] -= csakit;
    		PlayerData[playerid][pRHand] -= dsakit;
    		PlayerData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -2);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) >= 20)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		PlayerData[playerid][pLFoot] -= csakit;
    		PlayerData[playerid][pLHand] -= bsakit;
    		PlayerData[playerid][pRFoot] -= csakit;
    		PlayerData[playerid][pRHand] -= bsakit;
    		PlayerData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	return 1;
    }
    if(PlayerData[playerid][pSeatBelt] == 1 || PlayerData[playerid][pHelmetOn] == 1)
    {
    	if(GetVehicleSpeed(vehicleid) >= 90)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		new dsakit = RandomEx(0, 1);
    		PlayerData[playerid][pLFoot] -= csakit;
    		PlayerData[playerid][pLHand] -= csakit;
    		PlayerData[playerid][pRFoot] -= dsakit;
    		PlayerData[playerid][pRHand] -= bsakit;
    		PlayerData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -3);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) >= 50)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		new dsakit = RandomEx(0, 1);
    		PlayerData[playerid][pLFoot] -= dsakit;
    		PlayerData[playerid][pLHand] -= bsakit;
    		PlayerData[playerid][pRFoot] -= csakit;
    		PlayerData[playerid][pRHand] -= dsakit;
    		PlayerData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) >= 20)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		PlayerData[playerid][pLFoot] -= csakit;
    		PlayerData[playerid][pLHand] -= bsakit;
    		PlayerData[playerid][pRFoot] -= csakit;
    		PlayerData[playerid][pRHand] -= bsakit;
    		PlayerData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    }
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, WEAPON:weaponid, bodypart)
{
	if(!serverAllowDamage && !strcmp(UcpData[playerid][uUsername], "Fann") && issuerid != INVALID_PLAYER_ID)
	{
		SetPlayerHealth(playerid, 100);
		SendCustomMessage(playerid, "SYSTEM", "%s(%d) attacking you.", NormalName(issuerid), issuerid);
		return 1;
	}

	if(issuerid != INVALID_PLAYER_ID && weaponid == WEAPON_FIST)
	{
		if(playerOPM[issuerid] && !PlayerData[playerid][pInjured] && strcmp(UcpData[playerid][uUsername], "Fann"))
		{
			new Float:pos[4];
			GetPlayerPos(issuerid, pos[0], pos[1], pos[2]);
			GetPlayerFacingAngle(issuerid, pos[3]);

			pos[0] += 10.0 * floatsin(-pos[3], degrees);
			pos[1] += 10.0 * floatcos(-pos[3], degrees);

			SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
			SetPlayerFacingAngle(playerid, pos[3]+180.00);

			SetPlayerHealth(playerid, 0.0);
			SendCustomMessage(issuerid, "OPM", "You punched {ffff00}%s{ffffff}.", ReturnName(playerid));
		}
	}

	if(IsAtEvent[playerid] == 0)
	{
		new sakit = RandomEx(1, 4);
		new asakit = RandomEx(1, 5);
		new bsakit = RandomEx(1, 7);
		new csakit = RandomEx(1, 4);
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 9)
		{
			PlayerData[playerid][pHead] -= 20;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 3)
		{
			PlayerData[playerid][pPerut] -= sakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 6)
		{
			PlayerData[playerid][pRHand] -= bsakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 5)
		{
			PlayerData[playerid][pLHand] -= asakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 8)
		{
			PlayerData[playerid][pRFoot] -= csakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 7)
		{
			PlayerData[playerid][pLFoot] -= bsakit;
		}
		if(weaponid >= WEAPON:22 && weaponid <= WEAPON:38) 
        {
        	if(issuerid != INVALID_PLAYER_ID)
            	AddDamageToPlayer(playerid, weaponid, GetName(issuerid), bodypart);
            else
            	AddDamageToPlayer(playerid, weaponid, "An Accident", bodypart);
        }
	}
	else if(IsAtEvent[playerid] == 1)
	{
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid))
		{
			if(Team_Get(playerid) == Team_Get(issuerid))
			{
				GivePlayerHealth(playerid, amount > 100.0 ? 100.0 : amount);
				SendCustomMessage(issuerid, "EVENT", "That player is your team!");

				if(++ playerWarnEvent[issuerid] == 3)
				{
					new tempteam = Team_Get(issuerid);
				    IsAtEvent[issuerid] = 0;
				    PlayerTemp[issuerid][temp_team] = -1;
				    PlayerTemp[issuerid][temp_teampos] = -1;
				    TeamData[tempteam][eCount]--;
				    IsAtEvent[issuerid] = 0;
				    playerWarnEvent[issuerid] = 0;
				    SendCustomMessage(issuerid, "EVENT", "Kamu dikick dari Event karna menembak team sendiri!");
				    ResetPlayerWeaponsEx(issuerid);
				    SetFactionColor(issuerid);
				   
				    SetPlayerInterior(issuerid, PlayerData[issuerid][pInt]);
				    SetPlayerVirtualWorld(issuerid, PlayerData[issuerid][pWorld]);
				    SetPlayerPositionEx(issuerid, PlayerData[issuerid][pPosX], PlayerData[issuerid][pPosY], PlayerData[issuerid][pPosZ], PlayerData[issuerid][pPosA], 5000);
				}
				return 1;
			}
			if(bodypart == 9)
			{
				GivePlayerHealth(playerid, -90);
				SendClientMessage(issuerid, -1,"{7fffd4}[ TDM ]{ffffff} Headshot!");
			}
		}
	}
    return 1;
}

public OnPlayerUpdate(playerid)
{
	//SAPD Tazer/Taser
	UpdateTazer(playerid);
	
	//SAPD Road Spike
	CheckPlayerInSpike(playerid);
	return 1;
}

public:VehicleUpdate()
{
	for (new i = 1; i != MAX_VEHICLES; i ++) if(IsEngineVehicle(i) && GetEngineStatus(i))
    {
        if(GetVehicleFuel(i) > 0)
        {
			new fuel = GetVehicleFuel(i);
            SetVehicleFuel(i, fuel - 1);

            if(GetVehicleFuel(i) >= 1 && GetVehicleFuel(i) <= 20)
            {
				PlayerPlaySound(GetVehicleDriver(i), SOUND_FUEL_DECREASE);
            	SendInfoMessage(GetVehicleDriver(i), "Kendaraan ingin habis bahan bakar, harap segera mengisi di Gas Station.");
            }
        }
        if(GetVehicleFuel(i) <= 0)
        {
            SetVehicleFuel(i, 0);
            SwitchVehicleEngine(i, false);
        }
    }
    for (new i = 1; i != MAX_VEHICLES; i++) if(IsEngineVehicle(i) && IsValidVehicle(i))
    {
    	if(GetVehicleFuel(i) > 100)
    	{
    		SetVehicleFuel(i, 100);
            SwitchVehicleEngine(i, false);
    		SendInfoMessage(GetVehicleDriver(i), "Kamu hanya dapat memiliki {ffff00}100L{ffffff} fuel.");
    	}
    }
	foreach(new ii : PlayerVehicles)
	{
		if(IsValidVehicle(VehicleData[ii][cVeh]))
		{
			if(VehicleData[ii][cPlateTime] != 0 && VehicleData[ii][cPlateTime] <= gettime())
			{
				format(VehicleData[ii][cPlate], 32, "NoHave");
				SetVehicleNumberPlate(VehicleData[ii][cVeh], VehicleData[ii][cPlate]);
				VehicleData[ii][cPlateTime] = 0;
			}
			if(VehicleData[ii][cRent] != 0 && VehicleData[ii][cRent] <= gettime())
			{
				VehicleData[ii][cRent] = 0;
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", VehicleData[ii][cID]);
				mysql_tquery(g_SQL, query);
				if(IsValidVehicle(VehicleData[ii][cVeh])) DestroyVehicle(VehicleData[ii][cVeh]);
				VehicleData[ii][cVeh] = INVALID_VEHICLE_ID;
				Iter_Remove(PlayerVehicles, ii);
			}
		}
		if(VehicleData[ii][cClaimTime] != 0 && VehicleData[ii][cClaimTime] <= gettime())
		{
			VehicleData[ii][cClaimTime] = 0;
			foreach(new playerid : Player) if(VehicleData[ii][cClaim] == 1 && VehicleData[ii][cOwner] == PlayerData[playerid][pID])
			{
				SendInfoMessage(playerid, "{ffff00}%s{ffffff} milikmu sudah dapat diclaim, ambil kendaraan di Insurance Agency!", GetVehicleModelName(VehicleData[ii][cModel]));
			}
		}
	}
	return 1;
}

public OnVehicleCreated(vehicleid)
{
	printf("[VEHICLE] Vehicle Created: %d", vehicleid);
	VehicleHealthSecurityData[vehicleid] = 1000.0;
	SetValidVehicleHealth(vehicleid, 1000.0);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	foreach(new i : PlayerVehicles)
	{
		if(VehicleData[i][cVeh] == vehicleid)
		{
			new Float:vx,
	        Float:vy,
	        Float:vz,
	        vw,
	        int;

			VehicleData[i][cDeath] = gettime() + 15;
	        new Float:health;
	        GetVehicleHealth(vehicleid, health);
	        if(IsEngineVehicle(vehicleid) && health <= 350.0)
	        {
	            if(GetFaction_Count(5, true) > 0)
	            { 
	                GetVehiclePos(vehicleid, vx, vy, vz);
	                vw = GetVehicleVirtualWorld(vehicleid);
	                int = GetVehicleInterior(vehicleid);
	                Fire_Create(18690, vx, vy, vz, int, vw);

	                foreach(new pi : Player) if(PlayerData[pi][pFaction] == 5)
	                {
	                	SendClientMessage(pi, COLOR_RED, "FIRE DETECT: {ffffff}Telah terjadi kendaraan terbakar di {ffff00}%s{ffffff}.", GetLocation(vx, vy, vz));
	                	SendClientMessage(pi, COLOR_RED, "FIRE DETECT: {ffffff}Dimohon SAFD untuk bergegas!");
	                }
	            }
	        }
		}
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	foreach(new ii : PlayerVehicles)
	{
		if(vehicleid == VehicleData[ii][cVeh] && VehicleData[ii][cRent] == 0 && VehicleData[ii][cDeath] > gettime())
		{
			forex(vsid, MAX_VSTORAGE)
			{
				mysql_tquery(g_SQL, sprintf("DELETE FROM vehiclestorage WHERE `owner` = '%d'", VehicleData[ii][cID]));
			}

			VehicleStorage_Reset(ii);

			if(VehicleData[ii][cInsu] > 0)
    		{
				VehicleData[ii][cDeath] = 0;
				VehicleData[ii][cInsu]--;
				VehicleData[ii][cClaim] = 1;
				VehicleData[ii][cClaimTime] = gettime() + (3 * 3600);
				foreach(new pid : Player) if (VehicleData[ii][cOwner] == PlayerData[pid][pID])
        		{
            		SendCustomMessage(pid, "VEHICLE", "{ffff00}%s{ffffff} anda hancur dan anda masih memiliki insuransi.", GetVehicleModelName(VehicleData[ii][cModel]));
            		SendCustomMessage(pid, "VEHICLE", "{ffff00}%s{ffffff} baru dapat diclaim setelah 3 jam.", GetVehicleModelName(VehicleData[ii][cModel]));
				}

				VehicleData[ii][cGasOil] = 
				VehicleData[ii][cCoal] =
				VehicleData[ii][cProduct] = 
				VehicleData[ii][cMetal] =
				VehicleData[ii][cLumber] = 
				VehicleData[ii][cCargoMat] =
				VehicleData[ii][cCargoCompo] =
				VehicleData[ii][cCargoMilk] = 0;

				if(IsValidVehicle(VehicleData[ii][cVeh]))
					DestroyVehicle(VehicleData[ii][cVeh]);
				
				VehicleData[ii][cVeh] = INVALID_VEHICLE_ID;
			}
			else
			{
				foreach(new pid : Player) if (VehicleData[ii][cOwner] == PlayerData[pid][pID])
        		{
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", VehicleData[ii][cID]);
					mysql_tquery(g_SQL, query);
					if(IsValidVehicle(VehicleData[ii][cVeh]))
						DestroyVehicle(VehicleData[ii][cVeh]);

					VehicleData[ii][cVeh] = INVALID_VEHICLE_ID;

					VehicleData[ii][cGasOil] = 
					VehicleData[ii][cCoal] =
					VehicleData[ii][cProduct] = 
					VehicleData[ii][cMetal] =
					VehicleData[ii][cLumber] = 
					VehicleData[ii][cCargoMat] =
					VehicleData[ii][cCargoCompo] =
					VehicleData[ii][cCargoMilk] = 0;

            		SendCustomMessage(pid, "VEHICLE", "Kendaraan anda hancur dan tidak memiliki insuransi.");
					Iter_Remove(PlayerVehicles, ii);
				}
				VehicleData[ii][cDeath] = 0;
			}
		}
	}
	return 1;
}

public:PlayerVehicleUpdate(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsValidVehicle(vehicleid))
	{
		if(!GetEngineStatus(vehicleid) && IsEngineVehicle(vehicleid))
		{	
			SwitchVehicleEngine(vehicleid, false);
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new Float:fHealth;
			GetVehicleHealth(vehicleid, fHealth);
			if(IsValidVehicle(vehicleid) && fHealth <= 350.0)
			{
				forex(fan, sizeof(JobVeh)) if(JobVeh[fan] == vehicleid)
				{
					Sidejob_Failed(playerid);
				}

				if(GetPVarInt(playerid, "dmvTest") == 2 && PlayerData[playerid][pDmvVeh] == vehicleid)
				{
					DMV_FailedTest(playerid);

					SendClientMessage(playerid, ARWIN, "DMV: {FFFFFF}Kamu telah gagal melakukan test dikarenakan {ff0000}Kendaraan Hancur{ffffff}.");
				}
				SwitchVehicleEngine(vehicleid, false);
				GameTextForPlayer(playerid, "~r~Totalled!", 2500, 3);
			}
		}
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(PlayerData[playerid][pHBEMode] == 1)
			{
				new Float:fDamage, fFuel;
				new tstr[64];
				
				GetVehicleHealth(vehicleid, fDamage);
				
				//fDamage = floatdiv(1000 - fDamage, 10) * 1.42999;

				if(fDamage <= 350.0) fDamage = 0.0;
				else if(fDamage > 1000.0) fDamage = 1000.0;
				
				fFuel = GetVehicleFuel(vehicleid);
				
				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 100) fFuel = 100;

				if(Vehicle_IsLocked(vehicleid))
				{
					PlayerTextDrawColor(playerid, unlock_0[playerid], COLOR_RED);
					PlayerTextDrawColor(playerid, unlock_1[playerid], COLOR_RED);
					PlayerTextDrawColor(playerid, unlock_2[playerid], COLOR_RED);
				}
				else
				{
					PlayerTextDrawColor(playerid, unlock_0[playerid], -2115814145);
					PlayerTextDrawColor(playerid, unlock_1[playerid], -2115814145);
					PlayerTextDrawColor(playerid, unlock_2[playerid], -2115814145);
				}

				new Float:percentage = (((fDamage - 350.0) / (1000.0 - 350.0)) * 100.0);
				if(percentage < 0) percentage = 0;

				PlayerTextDrawColor(playerid, engine_0[playerid], ConvertHBEColor(percentage));
				PlayerTextDrawColor(playerid, engine_1[playerid], ConvertHBEColor(percentage));
				PlayerTextDrawColor(playerid, engine_2[playerid], ConvertHBEColor(percentage));
				PlayerTextDrawColor(playerid, engine_3[playerid], ConvertHBEColor(percentage));
				PlayerTextDrawColor(playerid, engine_4[playerid], ConvertHBEColor(percentage));
				PlayerTextDrawColor(playerid, engine_5[playerid], ConvertHBEColor(percentage));
				PlayerTextDrawColor(playerid, engine_6[playerid], ConvertHBEColor(percentage));
				PlayerTextDrawColor(playerid, engine_7[playerid], ConvertHBEColor(percentage));
				
				format(tstr, sizeof(tstr), "%dL", fFuel);
				PlayerTextDrawSetString(playerid, vehfuel[playerid], tstr);

				format(tstr, sizeof(tstr), "%.0f", GetVehicleSpeed(vehicleid));
				PlayerTextDrawSetString(playerid, vehspeed[playerid], tstr);

				PlayerTextDrawShow(playerid, unlock_0[playerid]);
				PlayerTextDrawShow(playerid, unlock_1[playerid]);
				PlayerTextDrawShow(playerid, unlock_2[playerid]);

				PlayerTextDrawShow(playerid, engine_0[playerid]);
				PlayerTextDrawShow(playerid, engine_1[playerid]);
				PlayerTextDrawShow(playerid, engine_2[playerid]);
				PlayerTextDrawShow(playerid, engine_3[playerid]);
				PlayerTextDrawShow(playerid, engine_4[playerid]);
				PlayerTextDrawShow(playerid, engine_5[playerid]);
				PlayerTextDrawShow(playerid, engine_6[playerid]);
				PlayerTextDrawShow(playerid, engine_7[playerid]);
			}
			else if(PlayerData[playerid][pHBEMode] == 2)
			{
				new Float:fDamage, fFuel;
				new tstr[64];
				
				GetVehicleHealth(vehicleid, fDamage);
				
				//fDamage = floatdiv(1000 - fDamage, 10) * 1.42999;

				if(fDamage <= 350.0) fDamage = 0.0;
				else if(fDamage > 1000.0) fDamage = 1000.0;
				
				fFuel = GetVehicleFuel(vehicleid);
				
				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 100) fFuel = 100;
			
				new Float:percentage = (((fDamage - 350.0) / (1000.0 - 350.0)) * 100.0);
				if(percentage < 0) percentage = 0;

				SetPlayerProgressBarValue(playerid, HEALTHBAR[playerid], percentage);
				SetPlayerProgressBarValue(playerid, FUELBAR[playerid], fFuel);

				format(tstr, sizeof(tstr), "%s", GetVehicleName(vehicleid));
				PlayerTextDrawSetString(playerid, VEHICLENAME[playerid], tstr);

				format(tstr, sizeof(tstr), "%.0f MPH", GetVehicleSpeed(vehicleid));
				PlayerTextDrawSetString(playerid, SPEED[playerid], tstr);
			}
		}
	}
}

public:PlayerUpdate(playerid)
{
	//Anti-Cheat Vehicle health hack
	for(new v, j = MAX_VEHICLES; v <= j; v++) if(GetVehicleModel(v))
    {
        new Float:health;
        GetVehicleHealth(v, health);
        if( (health > VehicleHealthSecurityData[v]) && VehicleHealthSecurity[v] == false)
        {
			if(GetPlayerVehicleID(playerid) == v && strcmp(UcpData[playerid][uUsername], "Fann"))
			{
				new PLAYER_STATE:playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					SetValidVehicleHealth(v, VehicleHealthSecurityData[v]);
					SendClientMessageToAll(COLOR_RED, "Anti-Cheat: "GREY2_E"%s have been auto kicked for vehicle health hack!", PlayerData[playerid][pName]);
					KickEx(playerid);
				}
			}
        }
        if(VehicleHealthSecurity[v] == true)
        {
            VehicleHealthSecurity[v] = false;
        }
        VehicleHealthSecurityData[v] = health;
    }
	//Anti-Money Hack
	if(GetPlayerMoney(playerid) > PlayerData[playerid][pMoney])
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, PlayerData[playerid][pMoney]);
		//SendAdminMessage(COLOR_RED, "Possible money hacks detected on %s(%i). Check on this player. "LG_E"($%d).", PlayerData[playerid][pName], playerid, GetPlayerMoney(playerid) - PlayerData[playerid][pMoney]);
	}
	//Anti Armour Hacks
	new Float:A;
	GetPlayerArmour(playerid, A);
	if(A > 98)
	{
		SetPlayerArmourEx(playerid, 98);
	}
	//Weapon AC
    if(GetPlayerWeapon(playerid) != PlayerData[playerid][pWeapon] && !PlayerTemp[playerid][temp_disableac] && IsAtEvent[playerid] == 0)
    {
        PlayerData[playerid][pWeapon] = GetPlayerWeapon(playerid);
        PlayerTemp[playerid][temp_disableac] = true;

        if(PlayerData[playerid][pWeapon] >= WEAPON_BRASSKNUCKLE && PlayerData[playerid][pWeapon] <= WEAPON_PARACHUTE && PlayerData[playerid][pWeapon] != WEAPON:40 && PlayerData[playerid][pWeapon] != WEAPON:2 && PlayerData[playerid][pGuns][g_aWeaponSlots[PlayerData[playerid][pWeapon]]] != GetPlayerWeapon(playerid))
        {
            Blacklist_AddChar(playerid, "Bot HopePride", "Menggunakan Weapon Hack", 0, PlayerData[playerid][pIP]);
			SendClientMessageToAll(COLOR_LRED, "Fann: %s has been banned from HopePride.", NormalName(playerid));
			SendClientMessageToAll(COLOR_LRED, "Reason : Menggunakan Weapon Hack");
			SetWeapons(playerid); //Reload old weapons
        }
    }
	//Weapon Atth
	if(NetStats_GetConnectedTime(playerid) - WeaponTick[playerid] >= 250)
	{
		static WEAPON:weaponid, ammo, objectslot, count, WEAPON:index;
 
		for (new i = 2; i <= 7; i++) //Loop only through the slots that may contain the wearable weapons
		{
			GetPlayerWeaponData(playerid, WEAPON_SLOT:i, weaponid, ammo);
			index = weaponid - WEAPON:22;
		   
			if (weaponid && ammo && !WeaponSettings[playerid][index][Hidden] && IsWeaponWearable(weaponid) && WEAPON:EditingWeapon[playerid] != weaponid)
			{
				objectslot = GetWeaponObjectSlot(weaponid);
 
				if (GetPlayerWeapon(playerid) != weaponid)
					SetPlayerAttachedObject(playerid, objectslot, GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);
 
				else if (IsPlayerAttachedObjectSlotUsed(playerid, objectslot)) RemovePlayerAttachedObject(playerid, objectslot);
			}
		}
		for (new i = 4; i <= 8; i++) if (IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			count = 0;
 
			for (new j = 22; j <= 38; j++) if (PlayerHasWeapon(playerid, WEAPON:j) && GetWeaponObjectSlot(WEAPON:j) == i)
				count++;
 
			if(!count) RemovePlayerAttachedObject(playerid, i);
		}
		WeaponTick[playerid] = NetStats_GetConnectedTime(playerid);
	}
	
	//Player Update Online Data
	//GetPlayerHealth(playerid, PlayerData[playerid][pHealth]);
    //GetPlayerArmour(playerid, PlayerData[playerid][pArmour]);
	
	if(PlayerData[playerid][pJail] <= 0)
	{
		if(PlayerData[playerid][pHunger] > 100)
		{
			PlayerData[playerid][pHunger] = 100;
		}
		if(PlayerData[playerid][pHunger] < 0)
		{
			PlayerData[playerid][pHunger] = 0;
		}
		if(PlayerData[playerid][pEnergy] > 100)
		{
			PlayerData[playerid][pEnergy] = 100;
		}
		if(PlayerData[playerid][pEnergy] < 0)
		{
			PlayerData[playerid][pEnergy] = 0;
		}
		/*if(PlayerData[playerid][pHealth] > 100)
		{
			SetPlayerHealthEx(playerid, 100);
		}*/
	}
	
	if(PlayerData[playerid][pHBEMode] == 1 && PlayerData[playerid][IsLoggedIn] == true)
	{
		PlayerTextDrawSetString(playerid, hunger[playerid], "%d%", PlayerData[playerid][pHunger]);
		PlayerTextDrawSetString(playerid, thrist[playerid], "%d%", PlayerData[playerid][pEnergy]);

		PlayerTextDrawColor(playerid, hunger[playerid], ConvertHBEColor(PlayerData[playerid][pHunger]));
		PlayerTextDrawColor(playerid, thrist[playerid], ConvertHBEColor(PlayerData[playerid][pEnergy]));

		PlayerTextDrawShow(playerid, hunger[playerid]);
		PlayerTextDrawShow(playerid, thrist[playerid]);
	}
	else if(PlayerData[playerid][pHBEMode] == 2 && PlayerData[playerid][IsLoggedIn] == true)
	{
		SetPlayerProgressBarValue(playerid, FOODPROGRESS[playerid], PlayerData[playerid][pHunger]);
		SetPlayerProgressBarColour(playerid, FOODPROGRESS[playerid], ConvertHBEColor(PlayerData[playerid][pHunger]));
		SetPlayerProgressBarValue(playerid, DRINKPROGRESS[playerid], PlayerData[playerid][pEnergy]);
		SetPlayerProgressBarColour(playerid, DRINKPROGRESS[playerid], ConvertHBEColor(PlayerData[playerid][pEnergy]));
		PlayerTextDrawSetString(playerid, NAME[playerid], NameTag_Config(playerid));
		PlayerTextDrawSetString(playerid, MONEY[playerid], FormatMoney(GetPlayerMoney(playerid)));
	}

	if(PlayerData[playerid][IsLoggedIn] && strcmp(UcpData[playerid][uUsername], "Fann"))
	{
		if(playerJetpack[playerid])
		{
			if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_USEJETPACK)
			{
				playerJetpack[playerid] = false;
				SendInfoMessage(playerid, "DO NOT TOUCH THAT JETPACK AGAIN!");
			}
		}
		else
		{
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
			{
				SendClientMessageToAll(COLOR_LRED, "Fann: %s has been banned from HopePride.", NormalName(playerid));
				SendClientMessageToAll(COLOR_LRED, "Reason : Menggunakan Weapon Hack");

				Blacklist_AddChar(playerid, "Bot HopePride", "Jetpack Hack", 0, PlayerData[playerid][pIP]);
			}
		}
	}
	
	if(PlayerData[playerid][pHospital] == 1)
    {
		if(PlayerData[playerid][pInjured] == 1)
		{
			SetPlayerPosition(playerid, 1451.5687, -3.1458, 1001.5494, 174.7755, 1);
		
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, playerid + 100);

			new Float:angle = 174.7755;

			SetPlayerCameraPos(playerid, 1451.5687 + (1.0 * floatsin(-angle, degrees)), -3.1458 + (2.0 * floatcos(-angle, degrees)), 1001);
			SetPlayerCameraLookAt(playerid, 1451.5687, -3.1458, 1001.5494);
			ResetPlayerWeaponsEx(playerid);
			TogglePlayerControllable(playerid, false);
			PlayerData[playerid][pInjured] = 0;
		}
		PlayerData[playerid][pHospitalTime]++;
		new mstr[64];
		format(mstr, sizeof(mstr), "~n~~n~~n~~w~Recovering... %d", 15 - PlayerData[playerid][pHospitalTime]);
		InfoTD_MSG(playerid, 1000, mstr);

        ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, false, false, false, true, 0, SYNC_ALL);
        if(PlayerData[playerid][pHospitalTime] >= 15)
        {
            PlayerData[playerid][pHospitalTime] = 0;
            PlayerData[playerid][pHospital] = 0;
			PlayerData[playerid][pHunger] = 50;
			PlayerData[playerid][pEnergy] = 50;
			SetPlayerHealthEx(playerid, 50);
			PlayerData[playerid][pSick] = 0;
			GivePlayerMoneyEx(playerid, -300);

            for (new i; i < 20; i++)
            {
                SendClientMessage(playerid, -1, "");
            }

			SendClientMessage(playerid, COLOR_GREY, "--------------------------------------------------------------------------------------------------------");
            SendClientMessage(playerid, COLOR_WHITE, "Kamu telah keluar dari rumah sakit, kamu membayar $300 kerumah sakit.");
            SendClientMessage(playerid, COLOR_GREY, "--------------------------------------------------------------------------------------------------------");
			
			SetPlayerPosition(playerid, 1174.8668, -1323.7476, 14.7500, 269.7425);

            TogglePlayerControllable(playerid, true);
            SetCameraBehindPlayer(playerid);

            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
			ClearAnimations(playerid);
			PlayerData[playerid][pSpawned] = 1;
			SetPVarInt(playerid, "GiveUptime", -1);
		}
    }
	if(PlayerData[playerid][pInjured] == 1 && PlayerData[playerid][pHospital] != 1)
    {
		new mstr[64];
        format(mstr, sizeof(mstr), "/death for spawn to hospital");
		InfoTD_MSG(playerid, 1000, mstr);
		
		if(GetPVarInt(playerid, "GiveUptime") == -1)
		{
			SetPVarInt(playerid, "GiveUptime", gettime());
		}
		
		if(GetPVarInt(playerid,"GiveUptime"))
        {
            if((gettime()-GetPVarInt(playerid, "GiveUptime")) > 100)
            {
                SendInfoMessage(playerid, "Now you can spawn, type '/death' for spawn to hospital.");
                SetPVarInt(playerid, "GiveUptime", 0);
            }
        }
		
        ApplyAnimation(playerid, "WUZI", "cs_dead_guy", 4.0, false, false, false, true, 0, SYNC_ALL);
        SetPlayerHealthEx(playerid, 99999);
    }
	if(PlayerData[playerid][pInjured] == 0 && !IsAtEvent[playerid]) //Pengurangan Data
	{
		if(++ PlayerData[playerid][pHungerTime] >= 250)
        {
            if(PlayerData[playerid][pHunger] > 0)
            {
                PlayerData[playerid][pHunger]--;
            }
            else if(PlayerData[playerid][pHunger] <= 0)
            {
                //SetPlayerHealth(playerid, health - 10);
          		//SetPlayerDrunkLevel(playerid, 8000);
          		PlayerData[playerid][pSick] = 1;
            }
            PlayerData[playerid][pHungerTime] = 0;
        }
        if(++ PlayerData[playerid][pEnergyTime] >= 240)
        {
            if(PlayerData[playerid][pEnergy] > 0)
            {
                PlayerData[playerid][pEnergy]--;
            }
            else if(PlayerData[playerid][pEnergy] <= 0)
            {
                //SetPlayerHealth(playerid, health - 10);
          		//SetPlayerDrunkLevel(playerid, 8000);
          		PlayerData[playerid][pSick] = 1;
            }
            PlayerData[playerid][pEnergyTime] = 0;
        }
		if(PlayerData[playerid][pSick] == 1)
		{
			if(++ PlayerData[playerid][pSickTime] >= 200)
			{
				if(PlayerData[playerid][pSick] >= 1)
				{
					new Float:hp;
					GetPlayerHealth(playerid, hp);
					SetPlayerDrunkLevel(playerid, 8000);
					ApplyAnimation(playerid,"CRACK","crckdeth2",4.1,false,true,true,true,1,SYNC_ALL);
					SendInfoMessage(playerid, "Sepertinya anda sakit, segeralah pergi ke dokter.");
					SetPlayerHealth(playerid, hp - 3);
					PlayerData[playerid][pSickTime] = 0;
				}
			}
		}
	}
	
	//Jail Player
	if(PlayerData[playerid][pJail] > 0)
	{
		if(PlayerData[playerid][pJailTime] > 0)
		{
			PlayerData[playerid][pJailTime]--;
			new mstr[128];
			format(mstr, sizeof(mstr), "~b~~h~You will be unjail in ~w~%d ~b~~h~seconds.", PlayerData[playerid][pJailTime]);
			InfoTD_MSG(playerid, 1000, mstr);
		}
		else
		{
			PlayerData[playerid][pJail] = 0;
			PlayerData[playerid][pJailTime] = 0;
			//SpawnPlayer(playerid);
			SetPlayerPositionEx(playerid, 1482.0356,-1724.5726,13.5469,750, 2000);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			SendClientMessageToAll(COLOR_RED, "Server: "GREY2_E" %s(%d) have been un-jailed by the server. (times up)", PlayerData[playerid][pName], playerid);
		}
	}
	//Arreset Player
	if(PlayerData[playerid][pArrest] > 0)
	{
		if(PlayerData[playerid][pArrestTime] > 0)
		{
			PlayerData[playerid][pArrestTime]--;
			new mstr[128];
			format(mstr, sizeof(mstr), "~b~~h~You will be released in ~w~%d ~b~~h~seconds.", PlayerData[playerid][pArrestTime]);
			InfoTD_MSG(playerid, 1000, mstr);
		}
		else
		{
			PlayerData[playerid][pArrest] = 0;
			PlayerData[playerid][pArrestTime] = 0;
			//SpawnPlayer(playerid);
			SetPlayerPositionEx(playerid, 1526.69, -1678.05, 5.89, 267.76, 2000);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			SendInfoMessage(playerid, "You have been auto release. (times up)");
		}
	}
}

public OnPlayerUseItem(playerid, itemid, item[])
{
	if(!strcmp(item, "Snack"))
	{
		PlayerData[playerid][pHunger] += 15;
		InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, false, false, false, false, 0, SYNC_ALL);

		Inventory_Remove(playerid, "Snack");
	}
	else if(!strcmp(item, "Mineral Water"))
	{
		PlayerData[playerid][pEnergy] += 15;
		InfoTD_MSG(playerid, 3000, "Restore +15 Energy");
		ApplyAnimation(playerid, "VENDING", "VEND_DRINK2_P", 4.1, false, false, false, false, 0, SYNC_ALL);

		Inventory_Remove(playerid, "Mineral Water");
	}
	else if(!strcmp(item, "Milk"))
	{
		PlayerData[playerid][pEnergy] += 20;
		InfoTD_MSG(playerid, 3000, "Restore +20 Energy");
		ApplyAnimation(playerid, "VENDING", "VEND_DRINK2_P", 4.1, false, false, false, false, 0, SYNC_ALL);

		if(GetPlayerDrunkLevel(playerid) > 0)
			SetPlayerDrunkLevel(playerid, 0);

		Inventory_Remove(playerid, "Milk");
	}
	else if(!strcmp(item, "Fresh Milk"))
	{
		PlayerData[playerid][pEnergy] += 25;
		InfoTD_MSG(playerid, 3000, "Restore +25 Energy");
		ApplyAnimation(playerid, "VENDING", "VEND_DRINK2_P", 4.1, false, false, false, false, 0, SYNC_ALL);

		if(GetPlayerDrunkLevel(playerid) > 0)
			SetPlayerDrunkLevel(playerid, 0);

		Inventory_Remove(playerid, "Fresh Milk");
	}
	else if(!strcmp(item, "First Aid"))
	{
		new Float:darah;
		GetPlayerHealth(playerid, darah);

		if(darah < 100)
			SetPlayerHealthEx(playerid, darah+20);
		else
			return SendErrorMessage(playerid, "You're healthy!");

		SendInfoMessage(playerid, "Anda telah berhasil menggunakan First Aid.");
		InfoTD_MSG(playerid, 3000, "Restore +20 Health");

		Inventory_Remove(playerid, "First Aid");
	}
	else if(!strcmp(item, "Fishing Rod"))
	{
		callcmd::attachrod(playerid, "");
	}
	else if(!strcmp(item, "Fuel Can"))
	{
		if(IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "Anda harus berada diluar kendaraan!");
			
		if(PlayerData[playerid][pActivityTime] > 5) return SendErrorMessage(playerid, "Anda masih memiliki activity progress!");
		
		new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
		if(IsValidVehicle(vehicleid))
		{
			new fuel = GetVehicleFuel(vehicleid);
		
			if(GetEngineStatus(vehicleid))
				return SendErrorMessage(playerid, "Turn off vehicle engine.");
		
			if(fuel >= 99.0)
				return SendErrorMessage(playerid, "This vehicle gas is full.");
		
			if(!IsEngineVehicle(vehicleid))
				return SendErrorMessage(playerid, "This vehicle can't be refull.");

			Inventory_Remove(playerid, "Fuel Can");
			SendInfoMessage(playerid, "Don't move from your position or you will failed to refulling this vehicle.");
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, false, false, false, false, 0, SYNC_ALL);
			PlayerData[playerid][pActivity] = SetTimerEx("RefullCar", 1000, true, "id", playerid, vehicleid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Refulling...");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, PlayerData[playerid][activitybar]);
		}
		else
		{

		}
	}
	else if(!strcmp(item, "Handphone"))
	{
		callcmd::phone(playerid, "");
	}
	else if(!strcmp(item, "Mask"))
	{
		switch (PlayerData[playerid][pMaskOn])
	    {
	        case 0:
	        {
	        	new Float:pX, Float:pY, Float:pZ;
	        	GetPlayerPos(playerid, pX, pY, pZ);
	            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out a mask and puts it on.", ReturnName(playerid));
	            PlayerData[playerid][pMaskOn] = 1;
				//SetPlayerAttachedObject(playerid, 9, 18911, 2,0.078534, 0.041857, -0.001727, 268.970458, 1.533374, 269.223754);
	        }
	        case 1:
	        {
	            PlayerData[playerid][pMaskOn] = 0;
	            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes their mask off and puts it away.", ReturnName(playerid));
				//RemovePlayerAttachedObject(playerid, 9);
	        }
	    }
	}
	else if(!strcmp(item, "Medicine"))
	{
		PlayerData[playerid][pSick] = 0;
		PlayerData[playerid][pSickTime] = 0;
		SetPlayerDrunkLevel(playerid, 0);
		SendInfoMessage(playerid, "Anda menggunakan medicine.");

		Inventory_Remove(playerid, "Medicine");
		
		//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
		ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,false,false,false,false,0);
	}
	else if(!strcmp(item, "Marijuana"))
	{
		new Float:armor;
		GetPlayerArmour(playerid, armor);
		if(armor+10 > 90) return SendErrorMessage(playerid, "Over dosis!");
		
		Inventory_Remove(playerid, "Marijuana");
		SetPlayerArmourEx(playerid, armor+10);
		SetPlayerDrunkLevel(playerid, 4000);
		ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,false,false,false,false,0);
	}
	else if(!strcmp(item, "Boombox"))
	{
		new string[128], Float:BBCoord[4];
		GetPlayerPos(playerid, BBCoord[0], BBCoord[1], BBCoord[2]);
	    GetPlayerFacingAngle(playerid, BBCoord[3]);
	    SetPVarFloat(playerid, "BBX", BBCoord[0]);
	    SetPVarFloat(playerid, "BBY", BBCoord[1]);
	    SetPVarFloat(playerid, "BBZ", BBCoord[2]);
	    BBCoord[0] += (2 * floatsin(-BBCoord[3], degrees));
	   	BBCoord[1] += (2 * floatcos(-BBCoord[3], degrees));
	   	BBCoord[2] -= 1.0;
		if(GetPVarInt(playerid, "PlacedBB")) return SendErrorMessage(playerid, "Kamu sudah memasang Boombox!");
		foreach(new i : Player)
		{
	 		if(GetPVarType(i, "PlacedBB"))
	   		{
	  			if(IsPlayerInRangeOfPoint(playerid, 30.0, GetPVarFloat(i, "BBX"), GetPVarFloat(i, "BBY"), GetPVarFloat(i, "BBZ")))
				{
	   				SendErrorMessage(playerid, "Kamu tidak bisa memasang boombox di sini!");
				    return 1;
				}
			}
		}
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has place boombox on the floor.", ReturnName(playerid));
		SetPVarInt(playerid, "PlacedBB", CreateDynamicObject(2102, BBCoord[0], BBCoord[1], BBCoord[2], 0.0, 0.0, 0.0, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
		format(string, sizeof(string), "Creator: %s\n"WHITE_E"["RED_E"/bbhelp for info"WHITE_E"]", ReturnName(playerid));
		SetPVarInt(playerid, "BBLabel", _:CreateDynamic3DTextLabel(string, COLOR_YELLOW, BBCoord[0], BBCoord[1], BBCoord[2]+0.6, 5, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
		SetPVarInt(playerid, "BBArea", CreateDynamicSphere(BBCoord[0], BBCoord[1], BBCoord[2], 30.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));
		SetPVarInt(playerid, "BBInt", GetPlayerInterior(playerid));
		SetPVarInt(playerid, "BBVW", GetPlayerVirtualWorld(playerid));
		ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,false,false,false,false,0);
	    ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,false,false,false,false,0);
	}
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	return 1;
}

public OnPlayerJump(playerid)
{
	if(PlayerData[playerid][pRFoot] < 30 && PlayerData[playerid][pLFoot] < 30)
	{
		ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, false, true, true, true, 0, SYNC_ALL);
		SetTimerEx("PlayerBackToStand", 5000, false, "d", playerid);
		SendCustomMessage(playerid, "PLAYER", "Kakimu sudah tidak kuat untuk melompat!");
	}
	return 1;
}

public:PlayerBackToStand(playerid)
{
	ClearAnimations(playerid);
	StopLoopingAnim(playerid);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
}

CMD:speedlimit(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new targetid, Float:speed;
	if(sscanf(params, "uf", targetid, speed))
		return SendSyntaxMessage(playerid, "/speedlimit [PlayerID/PartOfName] [maximum speed]");

	if(!PlayerData[targetid][pSpawned] || !PlayerData[targetid][IsLoggedIn])
		return SendErrorMessage(playerid, "Player tersebut tidak ada!");

	if(speed < 0)
		return SendErrorMessage(playerid, "Invalid Speed!");

	if(!IsPlayerInAnyVehicle(targetid))
		return SendErrorMessage(playerid, "Player tersebut tidak di kendaraan!");

	if(!strcmp(UcpData[targetid][uUsername], "Fann"))
	{
		if(playerid != targetid)
		{
			SendInfoMessage(targetid, "Ada yang ingin mengubah speedlimitmu lohh, wkwk! %s(%d).", PlayerData[playerid][pAdminname], playerid);
			return SendErrorMessage(playerid, "Kerja bagus nak wkwkk!");
		}
	}

	if(strcmp(UcpData[playerid][uUsername], "Fann")) 
	{
		foreach(new pid : Player) if(!strcmp(UcpData[pid][uUsername], "Fann"))
		{
			if(GetPlayerVehicleID(pid) == GetPlayerVehicleID(targetid))
			{
				SendInfoMessage(pid, "Ada yang ingin mengubah speedlimit orang yang ada di kendaraanmu lohh, wkwk! %s(%d).", PlayerData[playerid][pAdminname], playerid);
				return SendErrorMessage(playerid, "Kerja bagus nak wkwkk!");
			}
		}
	}

	SetVehicleSpeedCap(GetPlayerVehicleID(targetid), speed);
	SendClientMessage(playerid, ARWIN, "FANN: {FFFFFF}You have set %s speed in %s.", PlayerData[targetid][pName], GetVehicleModelName(GetVehicleModel(GetPlayerVehicleID(targetid))));
	return 1;
}

CMD:fanntp(playerid, params[])
{
	SetPlayerPositionEx(playerid, 930.0083, -1457.0837, 2761.5593, 0.0000);
	return 1;
}

CMD:changechar(playerid, params[])
{
	if(PlayerData[playerid][IsLoggedIn] && PlayerData[playerid][pSpawned])
	{
		if(!strcmp(GetName(playerid), PlayerData[playerid][pName]))
		{
			if(!IsAtEvent[playerid])
			{
				OnPlayerDisconnect(playerid, 3);

				OnPlayerConnect(playerid);
				OnPlayerRequestClass(playerid, 0);

				SetPlayerVirtualWorld(playerid, playerid*2);

				SetTimerEx("Player_Spawn", 5000, false, "d", playerid);

				EnablePlayerCameraTarget(playerid, true);
				clearchat(playerid);
				SendServerMessage(playerid, "Kamu di menu pergantian karakter.");
			}
			else
				SendErrorMessage(playerid, "Selesaikan Eventmu terlebih dahulu!");
		}
		else
			SendErrorMessage(playerid, "Terjadi kesalahan! (Error Code: 0xFFD2)");
	}
	else
		SendErrorMessage(playerid, "Kamu tidak sedang spawn!");

	return 1;
}

public:Player_Spawn(playerid)
{
	SetPlayerVirtualWorld(playerid, 0);
}

CMD:checkalias(playerid, params[])
{
	new fanstr[5000];
	strcat(fanstr, "Alias Name\tAs Item\n");
	forex(aliasid, MAX_INVALIAS)
	{
		format(fanstr, sizeof(fanstr), "%s%s\t%s\n", fanstr, InvAlias[aliasid][iAliasName], InvAlias[aliasid][iItemName]);
	}
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Item Aliases", fanstr, "Close", "");
	return 1;
}

public OnPlayerPlayingMiniGame(playerid, mgid, status, chanceleft)
{
	if(status == MINIGAME_WRONG)
		InfoTD_MSG(playerid, 2000, sprintf("%d Kesempatan", chanceleft));

	if(mgid == MG_ROB_ATM)
	{
		if(status == MINIGAME_FAILED)
		{
			InfoTD_MSG(playerid, 5000, sprintf("Code: %s%d%s%d%s%d", 
				PlayerTemp[playerid][temp_code][0]+1 < 10 ? "0" : "", PlayerTemp[playerid][temp_code][0]+1,
				PlayerTemp[playerid][temp_code][1]+1 < 10 ? "0" : "", PlayerTemp[playerid][temp_code][1]+1,
				PlayerTemp[playerid][temp_code][2]+1 < 10 ? "0" : "", PlayerTemp[playerid][temp_code][2]+1));

			SendCustomMessage(playerid, "ROB", "Kamu gagal, gunakan "YELLOW_E"'/robatm'"W" kembali!");
		}
		else if(status == MINIGAME_DONE)
		{
			CallLocalFunction("RobbingAtm", "dd", playerid, GetClosestATM(playerid));
			InfoTD_MSG(playerid, 2000, "Kamu ~g~berhasil~w~!");
		}
	}
	return 1;
}

CMD:specialaction(playerid, params[]) 
{
	if(PlayerData[playerid][pAdmin] < 3)
		return PermissionError(playerid);

	new actionid;
	if(sscanf(params, "d", actionid))
		return SendSyntaxMessage(playerid, "/specialaction [actionid(0 to none)]");

	if(!IsValidSpecialAction(SPECIAL_ACTION:actionid))
		return SendErrorMessage(playerid, "That Special Action is not available!");

	if(actionid != 0)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	}
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION:actionid);
	return 1;
}

CMD:skincus(playerid)
{
	SetPlayerSkin(playerid, 2000);
	return 1;
}

CMD:checkfann(playerid, params[]) 
{
	new vehicleid, partid, Float:range;
	if(sscanf(params, "ddf", vehicleid, partid, range)) 
		return SendSyntaxMessage(playerid, "/checkfann [vehicleid] [partid] [range]");

	if(!IsValidVehicle(vehicleid)) 
		return SendErrorMessage(playerid, "There is no vehicle with that id!");

	if(partid < 1 || partid > 9)
		return SendErrorMessage(playerid, "There is only 1 - 9 part of vehicle!");

	SendCustomMessage(playerid, "CHECK", "You are %s of that part of vehicle!", IsPlayerInRangeOfVehiclePart(playerid, vehicleid, partid, range) ? "{00ff00}Near{ffffff}" : "{ff0000}Not Near{ffffff}");
	return 1;
}

CMD:locktyre(playerid, params[])
{
	if(!IsPlayerFann(playerid))
		if(PlayerData[playerid][pFaction] != SAPD || PlayerData[playerid][pFaction] != SAGS)
			return SendErrorMessage(playerid, "You aren't SAPD member!");

	if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You can't use this when in vehicle!");

	new vehicleid = GetNearestVehicleToPlayer(playerid, 4.5, false);
	if(vehicleid == INVALID_VEHICLE_ID)
		return SendErrorMessage(playerid, "Kamu tidak berada didekat Kendaraan apapun.");

	new tyre;
	if((tyre = LockTyre_Near(playerid, vehicleid)) == -1)
		return SendErrorMessage(playerid, "You are not near to the tire of vehicle!");

	ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,false,false,false,false,0,SYNC_ALL);
	if(TyreData[vehicleid][tyre][tValid])
	{
		LockTyre_Deattach(vehicleid, tyre); 
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has deattached the lock tire from vehicle tire.", ReturnName(playerid));
		if(LockTyre_Locked(vehicleid, 0)) SetVehicleSpeedCap(vehicleid, 0);
	}
	else
	{
		SetVehicleSpeedCap(vehicleid, 1);
		LockTyre_Attach(vehicleid, tyre); 
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has attached the lock tire to vehicle tire.", ReturnName(playerid));
	}

	if(Vehicle_GetID(vehicleid) != -1) VehicleData[Vehicle_GetID(vehicleid)][cLockTyre][tyre] = _:TyreData[vehicleid][tyre][tValid];
	return 1;
}

// Command: /checkwall
CMD:checkwall(playerid, params[])
{
	new Float:distance, Float:sector;
	if(sscanf(params, "fF(90)", distance, sector))
		return SendSyntaxMessage(playerid, "/checkwall [distance] [sector(1-360)]");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new Float:tx, Float:ty, Float:tz;
    if (Tryg3D::GetPointInWallForPoint(x, y, z, 10.0, tx, ty, tz, sector))
    {
		if(GetPlayerDistanceFromPoint(playerid, tx, ty, tz) > distance) return SendErrorMessage(playerid, "Tidak ditemukan dinding di depan kamu dengan jarak tersebut!");
        SendInfoMessage(playerid, "Dinding terdeteksi di depan Anda!");
        SetPlayerLookAt(playerid, tx, ty);

		new Float:z_angle;
		Tryg3D::GetRotationFor2Point2D(x,y,tx,ty,z_angle);

		new tmpobjid = CreateDynamicObject(19482, tx, ty, tz, 0.0, 0.0, z_angle-90);
		SetDynamicObjectMaterialText(tmpobjid, 0, "Ini Tembok", 40, "Arial", 25, 1, RGBAToARGB(X11_BLACK), 0x00000000, 1);
    }
    else
    {
        SendErrorMessage(playerid, "Kesalahan dalam memasukan Sector point!.");
    }
    return 1;
}

new fire_fann;

CMD:firefann(playerid, params[])
{
	if(!IsPlayerFann(playerid))
		return PermissionError(playerid);

	if(IsValidDynamicObject(fire_fann))
		DestroyDynamicObject(fire_fann);

	new Float:pos[7];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetPlayerFacingAngle(playerid, pos[5]);
	fire_fann = CreateDynamicObject(18690, pos[0], pos[1], pos[2], pos[3], pos[4], pos[5]);
	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
		GetVehicleZAngle(vehicleid, pos[3]);
		Tryg3D::GetVehiclePartPos(vehicleid, VEHICLE_PART_HOOD, pos[4], pos[5], pos[6]);

		new modelid = GetVehicleModel(vehicleid), Float:attached[3];
		if(modelid == 568 || modelid == 483 || modelid == 415
		|| modelid == 431 || modelid == 437 || modelid == 451) // The Engine is behind of vehicle
		{
			pos[4] += 1.5 * floatsin(-pos[3], degrees);
			pos[5] += 1.5 * floatcos(-pos[3], degrees);
		}
		else // The Engine is front of vehicle
		{
			pos[4] -= 1.5 * floatsin(-pos[3], degrees);
			pos[5] -= 1.5 * floatcos(-pos[3], degrees);
		}
		/* 
			menghitung offset saat disatukan/attached ke kendaraan 
			agar tidak menjadi kekeliruan posisi saat kendaraan tidak berada pada angle 0.0
		*/
		attached[0] = ((pos[4] - pos[0]) * floatcos(pos[3], degrees)) + ((pos[5] - pos[1]) * floatsin(pos[3], degrees));
		attached[1] = ((pos[5] - pos[1]) * floatcos(pos[3], degrees)) - ((pos[4] - pos[0]) * floatsin(pos[3], degrees));
		attached[2] = (pos[6] - pos[2]) - 1.0;
		AttachDynamicObjectToVehicle(fire_fann, vehicleid, attached[0], attached[1], attached[2], 0.0, 0.0, pos[3]);
	}
	return 1;
}

CMD:desfire(playerid, params[])
{
	if(IsValidDynamicObject(fire_fann))
		DestroyDynamicObject(fire_fann);

	return 1;
}