#include "modules\utils\utils_colours.pwn"

// how many seconds until it kicks the player for taking too long to login
#define		SECONDS_TO_LOGIN 	200

// default spawn point: Las Venturas (The High Roller)
#define 	DEFAULT_POS_X 		1744.3411
#define 	DEFAULT_POS_Y 		-1862.8655
#define 	DEFAULT_POS_Z 		13.3983
#define 	DEFAULT_POS_A 		270.0000

#define GetAName(%0)                                            PlayerData[playerid][pAdminname]
#define NormalName(%0)                                          CharacterList[%0][PlayerData[%0][pChar]]
#define ReturnAdminName(%0)                                     UcpData[%0][uUsername]
#define GetFaction(%0,%1)                                       (PlayerData[%0][pFaction] == %1 || PlayerData[%0][pFactionLead] == %1)
#define ReturnName                                              NameTag_Config
#define Cow_GetData(%0, %1)                                     Fann@CowData[%0][%1]
#define GetVehicleSpeed                                         EVF::GetVehicleSpeed
#define GetDistance3D                                           Tryg3D::GetDistance3D
#define GetPlayerWeaponEx                                       WEAPON:Fann_GetPlayerWeaponEx
#define IsPlayerLogged(%0)                                      (IsPlayerConnected(%0) && PlayerData[%0][IsLoggedIn])
#define IsPlayerFann(%0)                                        (!strcmp(UcpData[%0][uUsername], "Fann"))
#define rumus_pajak(%0)                                         (%0 / 100) * 5
#define GetMoney(%0)                                            PlayerData[%0][pMoney]
#define GiveMoney                                               GivePlayerMoneyEx
#define GetVehicleBoot(%0,%1,%2,%3)				                GetVehicleOffset((%0),OffsetTypes:0,(%1),(%2),(%3))

#define RGBAToARGB(%0) (%0 >>> 8 | %0 << 24)

#define Fire_GetInside(%0)      playerInsideFire[%0]
#define Fire_SetInside(%0,%1)   playerInsideFire[%0]=%1

//Android Client Check
//#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0

#define Loop(%0,%1,%2) for(new %0 = %2; %0 < %1; %0++)
#define forex(%0,%1) for(new %0; %0 < %1; %0++)

#define LIMIT_PER_PLAYER 3

#define LUMBER_LIFETIME     100
#define LUMBER_LIMIT        10

#define LOG_LIFETIME 100
#define LOG_LIMIT 10

#define TASER_BASETIME  (3)     // player will get tased for at least 3 seconds
#define TASER_INDEX     (9)     // setplayerattachedobject index for taser object

#define OBJECT_TYPE_BODY                    1
#define OBJECT_TYPE_TEXT                    2
#define VEHICLE_OBJECT_PRICE                100
#define VEHICLE_OBJECT_EDIT_PRICE           10

// Message
#define public:%0(%1) forward %0(%1); public %0(%1)
#define SendServerMessage(%1,%2) SendClientMessage(%1, ARWIN, "SERVER: "WHITE_E""%2)
#define SendInfoMessage(%1,%2) SendClientMessage(%1, ARWIN, "INFO: "WHITE_E""%2)
#define SendVehicleMessage(%1,%2) SendClientMessage(%1, ARWIN, "VEHICLE: "WHITE_E""%2)
#define SendSyntaxMessage(%1,%2) SendClientMessage(%1, COLOR_GREY3, "SYNTAX: "%2)
#define SendErrorMessage(%1,%2) SendClientMessage(%1, COLOR_GREY3, "ERROR: "%2)
#define SendCustomMessage(%1,%2,%3) SendClientMessage(%1, ARWIN, %2": {ffffff}"%3)
#define PermissionError(%0) SendErrorMessage(%0, "You dont have any access to use this!")

#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define RELEASED(%0) \
    (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define HOLDING(%0) \
    ((newkeys & %0) == %0)
    
//Converter
#define minplus(%1) \
        (((%1) < 0) ? (-(%1)) : ((%1)))

// AntiCaps
#define UpperToLower(%1) for( new ToLowerChar; ToLowerChar < strlen( %1 ); ToLowerChar ++ ) if ( %1[ ToLowerChar ]> 64 && %1[ ToLowerChar ] < 91 ) %1[ ToLowerChar ] += 32

// Banneds
const BAN_MASK = (-1 << (32 - (/*this is the CIDR ip detection range [def: 26]*/26)));

//---------[ Define Faction ]-----
#define SAPD	1
#define	SAGS	2
#define SAMD	3
#define SANEW	4
#define SAFD    5
//---------[ JOB ]---------//
#define BOX_INDEX            9 // Index Box Barang
//---------[ MAX ID ]---------//
#define MAX_CHARACTERS              3
#define MAX_ATM                     50
#define MAX_LOCKERS                 35
#define MAX_DOOR                    500
#define MAX_FAMILY                  100
#define MAX_CONTACT                 300 // per player
#define MAX_DROP_WEAPON             5000
#define MAX_BISNIS                  500
#define MAX_HOUSES                  500
#define MAX_PARKPOINT               300
#define MAX_GSTATION                50
#define MAX_GATES                   500
#define MAX_LUMBERS                 50
#define MAX_LOG                     100
#define MAX_PRIVATE_VEHICLE         1000
#define MAX_PLAYER_VEHICLE          3
#define MAX_REPORTS                 50
#define MAX_ASKS                    50
#define MAX_SPIKESTRIPS             200
#define MAX_WORKSHOP                100
#define MAX_WORKSHOP_EMPLOYEE       3
#define MAX_WORKSHOP_INT            7000
#define MAX_MODSHOP                 20
#define MAX_INVENTORY               20 // per player
#define MAX_INVITEMS                sizeof(InvData)
#define MAX_INVALIAS                sizeof(InvAlias)
#define MAX_LISTED_DAMAGE           55 // per player
#define MAX_DYNAMIC_FIRE            500
#define MAX_COW                     sizeof(Fann@CowData)
#define MAX_PLAYLIST                20 // per player
#define MAX_VSTORAGE                5 // per vehicle
#define MAX_VEHICLE_OBJECT          5 // per vehicle
#define MAX_COLOR_MATERIAL          5
#define MAX_BOX                     5000
#define MAX_SKILLS                  sizeof(SkillsData)
#define MAX_FISH                    10 // per player
#define MAX_GRAFFITI                5000 
#define MAX_COOK                    sizeof(CookMenu)

//---------[ INVALID ID ]---------//
#define INVALID_DAMAGE_ID           -1
#define INVALID_FIRE_ID             -1

//---------[ Bodyparts ]---------//
#define BODY_PART_TORSO             (3)
#define BODY_PART_GROIN             (4)
#define BODY_PART_LEFT_ARM          (5)
#define BODY_PART_RIGHT_ARM         (6)
#define BODY_PART_LEFT_LEG          (7)
#define BODY_PART_RIGHT_LEG         (8)
#define BODY_PART_HEAD              (9)

//---------[ Sounds ]---------//
#define SOUND_CHECKPOINT		(1139)
#define SOUND_GET_ITEM			(40405)
#define SOUND_NOTIF_BOX			(30801)
#define SOUND_LOCK_CAR_DOOR     (24600)
#define SOUND_LOGIN_START       (1185)
#define SOUND_LOGIN_END         (1186)
#define SOUND_DMV_PASS_START    (1187)
#define SOUND_DMV_PASS_END      (1188)
#define SOUND_SLAP              (1190)
#define SOUND_CAR_MOD           (1133)
#define SOUND_FUEL_DECREASE     (1131)
#define SOUND_FIREALARM_START   (3401)
#define SOUND_FIREALARM_END     (3402)
#define MDC_ERROR               (21001)
#define MDC_SELECT              (21000)
#define MDC_OPEN                (45400)

//--------[ Locations ]--------//
#define LOC_SELLFISH 		2845.1232, -1504.7905, 11.4434
#define LOC_FISHFACTORY 	1358.1546, 1340.1357, 10.8862