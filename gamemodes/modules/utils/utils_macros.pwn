// MySQL connection handle
new MySQL:g_SQL = MYSQL_INVALID_HANDLE; 

new object_font[500], color_string[3256], color_string2[5000];

//====== QUIZ
new quiz,
	answers[256],
	answermade,
	qprs;

new RobMember = 0;
// EVENT SYSTEM
new EventCreated = 0, EventStarted = 0, EventPrize = 500, EventTime = 0;
new EventLocked = 0;
new IsAtEvent[MAX_PLAYERS];

new playerFillFuel[MAX_PLAYERS];
new playerInfoTD[MAX_PLAYERS];
new playerOPM[MAX_PLAYERS];
new playerJetpack[MAX_PLAYERS];
new playerWarnEvent[MAX_PLAYERS];

new serverAllowDamage; // to fann only
new serverEnableTag;

//new fannchanged;

// Countdown
new Count = -1;
new countTimer;
new showCD[MAX_PLAYERS];
new CountText[5][5] =
{
	"~r~1",
	"~g~2",
	"~y~3",
	"~g~4",
	"~b~5"
};

// info
new const InfoServer[][128] =
{
	"Bermain di ~b~HopePride~w~ seseru itu!",
	"Jangan pernah percaya ~r~omongan manis~w~ orang lain kalau tidak mau~n~~y~menyesal~w~.",
	"~b~HopePride~w~ v"TEXT_VERSION" by ~y~Fann~w~.",
	"Aku suka dia, dianya gak suka aku :(",
	"Butuh bantuan? gunakan ~y~'/help'~w~ yang mungkin membantu, atau ~y~'/ask'~n~~w~bertanya pdada administrator online.",
	"Punya keluhan? report ke ~y~'/report'~w~.",
	"Menemukan bug? langsung report ke ~y~'/report'~w~ atau report ke ~b~Discord~w~ resmi HopePride!",
	"Cuman HopePride yang asik, yang lain asik sendiri :v",
	"Nungguin apa? ~r~nungguin hal yang tidak pasti :(",
	"~b~#HopePrideJaya ~w~&~b~ #HopePrideSukses",
	"~p~Tunggu ya, sayang."
};

// WBR
new File[128];

// Server Uptime
new up_days,
	up_hours,
	up_minutes,
	up_seconds,
	WorldTime = 10,
	WorldWeather = 24;

// Faction Vehicle
new SAPDVeh[MAX_PLAYERS],
	SAMDVeh[MAX_PLAYERS],
	SAGSVeh[MAX_PLAYERS],
	SANAVeh[MAX_PLAYERS],
	SAFDVeh[MAX_PLAYERS];

//Showroom Checkpoint
new ShowRoomCP,
	ShowRoomCPRent;

//NameTag
new Text3D:fannTag[MAX_PLAYERS];

//Robb
//new RobBankProgress[MAX_PLAYERS];

// Duty Timer

new DutyTimer[MAX_PLAYERS];

new playerInsideFire[MAX_PLAYERS] = {INVALID_FIRE_ID, ...};

// Yom Button
new 
	SAPDLobbyBtn[4],
	SAPDLobbyDoor[4],
	LLFLobbyBtn[2],
	LLFLobbyDoor;

new TogOOC = 1;

new CharacterList[MAX_PLAYERS][MAX_CHARACTERS+5][MAX_PLAYER_NAME];
new CharacterLevel[MAX_PLAYERS][MAX_CHARACTERS+5];
new CharacterLastLogin[MAX_PLAYERS][MAX_CHARACTERS+5][50];

new g_MysqlRaceCheck[MAX_PLAYERS];

//---------- SMUGGLER

new Text3D:packetLabel,
	packetObj,
	Float:paX, 
	Float:paY, 
	Float:paZ;

//------[ Trucker ]--------

new VehProduct[MAX_VEHICLES];
new VehGasOil[MAX_VEHICLES];

//------[ Job/Activity ]------
new JobVeh[15];

new bool:busRouteTaken[3] = false;
new bool:sweeperRouteTaken[3] = false;

// ------------------------
// eSelection.inc
// ------------------------

new SpawnSkinMale[] =
{
	1, 2, 3, 4, 5, 6, 7, 14, 100, 299
};

new SpawnSkinFemale[] =
{
	9, 10, 11, 12, 13, 31, 38, 39, 40, 41
};


new SAPDSkinMale[] =
{
	280, 281, 282, 283, 284, 288, 300, 301, 302, 303, 304, 305, 310, 311, 165, 166, 265, 266, 267,
	121, 285, 286, 287, 117, 118, 165, 166
};

new SAPDSkinFemale[] =
{
	306, 307, 309, 148, 150
};

new SAGSSkinMale[] =
{
	171, 17, 71, 147, 187, 165, 166, 163, 164, 255, 295, 294, 303, 304, 305, 189, 253
};

new SAGSSkinFemale[] =
{
	9, 11, 76, 141, 150, 219, 169, 172, 194, 263
};

new SAMDSkinMale[] =
{
	70, 187, 303, 304, 305, 274, 275, 276, 277, 278, 279, 165, 71, 177
};

new SAMDSkinFemale[] =
{
	308, 76, 141, 148, 150, 169, 172, 194, 219
};

new SANASkinMale[] =
{
	171, 187, 189, 240, 303, 304, 305, 20, 59
};

new SANASkinFemale[] =
{
	172, 194, 211, 216, 219, 233, 11, 9
};

new SAFDSkinMale[] =
{
	277, 278, 279
};

new SAFDSkinFemale[] =
{
	219, 211, 150
};

new ShopSkinMale[] =
{
    1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33,
	34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 68, 72, 73,
	78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
	110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133,
	134, 135, 136, 137, 142, 143, 144, 146, 153, 154, 156, 158, 159, 160, 161, 162, 167, 168, 170,
	171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 188, 189, 190, 200, 202, 203,
	204, 206, 208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240, 241,
	242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289, 290, 291, 292, 293,
	294, 296, 297, 299
};

new ShopSkinFemale[]=
{
    9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69, 75, 76, 77, 85, 88, 89, 90, 91, 92,
	93, 129, 130, 131, 138, 140, 141, 145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195, 196,
	197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245,
	246, 251, 256, 257, 263, 298
};

new VipSkinMale[] =
{
	1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33,
	34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 68, 72, 73,
	78, 79, 80, 81, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
	110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133,
	134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170,
	171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 200, 202, 203,
	204, 206, 208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240, 241,
	242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289, 290, 291, 292, 293,
	294, 295, 296, 297, 299
};

new VipSkinFemale[] =
{
	9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69, 75, 76, 77, 85, 88, 89, 90, 91, 92,
	93, 129, 130, 131, 138, 140, 141, 145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195, 196,
	197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245,
	246, 251, 256, 257, 263, 298
};

new ToysModel[] =
{
	19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022,
	19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19033, 19034, 19035, 19801, 18891, 18892, 18893,
	18894, 18895, 18896, 18897, 18898, 18899, 18900, 18901, 18902, 18903, 18904, 18905, 18906, 18907, 18908, 18909, 18910,
	18911, 18912, 18913, 18914, 18915, 18916, 18917, 18918, 18919, 18920, 19036, 19037, 19038, 19557, 11704, 19472, 18974,
	19163, 19064, 19160, 19352, 19528, 19330, 19331, 18921, 18922, 18923, 18924, 18925, 18926, 18927, 18928, 18929, 18930,
	18931, 18932, 18933, 18934, 18935, 18939, 18940, 18941, 18942, 18943, 18944, 18945, 18946, 18947, 18948, 18949, 18950,
	18951, 18953, 18954, 18960, 18961, 19098, 19096, 18964, 18967, 18968, 18969, 19106, 19113, 19114, 19115, 18970, 18638,
	19553, 19558, 19554, 18971, 18972, 18973, 19101, 19116, 19117, 19118, 19119, 19120, 18952, 18645, 19039, 19040, 19041,
	19042, 19043, 19044, 19045, 19046, 19047, 19053, 19421, 19422, 19423, 19424, 19274, 19518, 19077, 19517, 19317, 19318,
	19319, 19520, 1550, 19592, 19621, 19622, 19623, 19624, 19625, 19626, 19555, 19556, 19469, 19085, 19559, 19904, 19942,
	19944, 11745, 19773, 18639, 18640, 18641, 18635, 18633, 3028, 11745, 19142, 371, 336, 1242, 2967, 3016, 11718, 19141,
	19137, 19607, 19086, 18637, 18642, 19590, 918, 19306, 19307, 6865
};

new const g_aWeaponSlots[MAX_WEAPONS] = 
{
    0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 8, 8, 8, 0, 0, 0, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4, 6, 6, 7, 7, 7, 7, 8, 12, 9, 9, 9, 11, 11, 11
};

new fann_dailyinfo[][256] = 
{
	"Jangan lupa untuk selalu {00ff00}/savestats{ffffff} ya...",
	"Butuh keluhan? atau pertanyaan? pakai {00ff00}/report{ffffff} atau {00ff00}/ask{ffffff}!",
	"Jangan lupa ajak temanmu untuk main di "LB_E"HopePride{ffffff} Roleplay!",
	"Menemukan Cheater? Laporkan lewat "BLUE_E"Discord{ffffff} atau {ff0000}/report",
	"Ada saran untuk update HopePride kedepannya? Ajukan saranmu lewat "BLUE_E"Discord",
	"Menemukan Bug? Laporkan lewat "BLUE_E"Discord{ffffff} atau {ff0000}/report",
	"Kalau roleplay asikin aja. #mainbarengravens",
	"Menemukan Pelanggar BR? Laporkan lewat "BLUE_E"Discord{ffffff} atau {ff0000}/report",
	"Apa Character/UCP kalian terbanned tanpa alasan? atau tidak merasa melakukan? Appeal di "BLUE_E"Discord{ffffff}!"
};

new const ColorList[] = {
    0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
    0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
    0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
    0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
    0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
    0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
    0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
    0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
    0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
    0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
    0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
    0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
    0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF, 0x177517FF, 0x210606FF,
    0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF, 0xB7B7B7FF, 0x464C8DFF,
    0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF, 0x1E1D13FF, 0x1E1306FF,
    0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF, 0x992E1EFF, 0x2C1E08FF,
    0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF, 0x481A0EFF, 0x7A7399FF,
    0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF, 0x7B3E7EFF, 0x3C1737FF,
    0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF, 0x163012FF, 0x16301BFF,
    0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF, 0x2B3C99FF, 0x3A3A0BFF,
    0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF, 0x2C5089FF, 0x15426CFF,
    0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF, 0x995C52FF, 0x99581EFF,
    0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF, 0x96821DFF, 0x197F19FF,
    0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF, 0x8A653AFF, 0x732617FF,
    0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF, 0x561A28FF, 0x4E0E27FF,
    0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};

new const FontNames[][] = 
{
    "Arial",
    "Calibri",
    "Comic Sans MS",
    "Georgia",
    "Times New Roman",
    "Consolas",
    "Constantia",
    "Corbel",
    "Courier New",
    "Impact",
    "Lucida Console",
    "Palatino Linotype",
    "Tahoma",
    "Trebuchet MS",
    "Verdana"
};

new const WindowName[][32] =
{
	"Driver Window",
	"Passenger Window",
	"Back Left Window",
	"Back Right Window"
};