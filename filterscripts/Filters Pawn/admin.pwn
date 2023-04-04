//==============================================================================
#include <a_samp>
#include <lethaldudb2>
//==============================================================================
#pragma dynamic 145000
//==============================================================================
/*
|===============================================|
|		--== ADM Script By [FCT]Diego ==--      |
|         -==  Version 1.0  ==--                |
|===============================================|
*/
//==============================================================================
#define USE_MENUS       	// Comment to remove all menus.  Uncomment to enable menus
//#define DISPLAY_CONFIG 	// displays configuration in console window on filterscript load
#define SAVE_LOGS           // Comment if your server runs linux (logs wont be saved)
#define ENABLE_SPEC         // Comment if you are using a spectate system already
#define USE_STATS           // Comment to disable /stats
#define ANTI_MINIGUN        // Displays who has a minigun
//#define USE_AREGISTER       // Changes /register, /login etc to  /areister, /alogin etc
//#define HIDE_ADMINS 		// Displays number of admins online instead of level and names
#define ENABLE_FAKE_CMDS   	// Comment to disable /fakechat, /fakedeath, /fakecmd commanads
//==============================================================================
#define MAX_WARNINGS 3      // /warn command
#define MAX_REPORTS 7
#define MAX_CHAT_LINES 7
#define SPAM_MAX_MSGS 5
#define SPAM_TIMELIMIT 8 // SECONDS
#define PING_MAX_EXCEEDS 4
#define PING_TIMELIMIT 60 // SECONDS
#define MAX_FAIL_LOGINS 4
//==============================================================================
new AdminArea[6] = {
377, 	// X
170, 	// Y
1008, 	// Z
90,     // Angle
3,      // Interior
0		// Virtual World
};
//==============================================================================
#define blue 0x375FFFFF
#define red 0xFF0000AA
#define green 0x33FF33AA
#define yellow 0xFFFF00AA
#define grey 0xC0C0C0AA
#define blue1 0x2641FEAA
#define lightblue 0x33CCFFAA
#define orange 0xFF9900AA
#define black 0x2C2727AA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_PURPLE 0x800080AA
#define COLOR_BLACK 0x000000AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_GREEN1 0x33AA33AA
#define COLOR_BROWN 0xA52A2AAA
//==============================================================================
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
//==============================================================================
#define UpperToLower(%1) for ( new ToLowerChar; ToLowerChar < strlen( %1 ); ToLowerChar ++ ) if ( %1[ ToLowerChar ]> 64 && %1[ ToLowerChar ] < 91 ) %1[ ToLowerChar ] += 32
//==============================================================================
#define ADMIN_SPEC_TYPE_NONE 0
#define ADMIN_SPEC_TYPE_PLAYER 1
#define ADMIN_SPEC_TYPE_VEHICLE 2
//==============================================================================
enum PlayerData
{
	Registered,
	LoggedIn,
	Level,
	Muted,
	Caps,
	Jailed,
	JailTime,
	Frozen,
	FreezeTime,
	Kills,
	Deaths,
	hours,
	mins,
	secs,
	TotalTime,
	ConnectTime,
 	MuteWarnings,
	Warnings,
	Spawned,
	TimesSpawned,
	God,
	GodCar,
	DoorsLocked,
	SpamCount,
	SpamTime,
	PingCount,
	PingTime,
	BotPing,
	pPing[PING_MAX_EXCEEDS],
	blip,
	blipS,
	pColour,
	pCar,
	SpecID,
	SpecType,
	bool:AllowedIn,
	FailLogin,
};
//==============================================================================
new PlayerInfo[MAX_PLAYERS][PlayerData];
//==============================================================================
enum ServerData
{
	MaxPing,
	ReadPMs,
	ReadCmds,
	MaxAdminLevel,
	AdminOnlySkins,
	AdminSkin,
	AdminSkin2,
	NameKick,
	PartNameKick,
	AntiBot,
	AntiSpam,
 	AntiSwear,
 	NoCaps,
	Locked,
	Password[128],
	GiveWeap,
	GiveMoney,
	ConnectMessages,
	AdminCmdMsg,
	AutoLogin,
	MaxMuteWarnings,
	DisableChat,
	MustLogin,
	MustRegister,
};
//==============================================================================
new ServerInfo[ServerData];
//==============================================================================
new Float:Pos[MAX_PLAYERS][4];
//==============================================================================
new Chat[MAX_CHAT_LINES][128];
//==============================================================================
new PingTimer;
new GodTimer;
new BlipTimer[MAX_PLAYERS];
new JailTimer[MAX_PLAYERS];
new FreezeTimer[MAX_PLAYERS];
new LockKickTimer[MAX_PLAYERS];
//==============================================================================
new CountDown = -1, cdt[MAX_PLAYERS] = -1;
new InDuel[MAX_PLAYERS];
//==============================================================================
new BadNames[100][100],
    BadNameCount = 0,
	BadPartNames[100][100],
    BadPartNameCount = 0,
    ForbiddenWords[100][100],
    ForbiddenWordCount = 0;
//==============================================================================
new Reports[MAX_REPORTS][128];
new PingPos;
new VehicleNames[212][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
	"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};
//==============================================================================
public OnFilterScriptInit()
{
	if(!fexist("ladmin/"))
	{
	    print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
	  	SetTimerEx("PrintWarning",2500,0,"s","ladmin");
		return 1;
	}
	if(!fexist("ladmin/logs/"))
	{
	    print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
	  	SetTimerEx("PrintWarning",2500,0,"s","ladmin/logs");
		return 1;
	}
	if(!fexist("ladmin/config/"))
	{
	    print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
	  	SetTimerEx("PrintWarning",2500,0,"s","ladmin/config");
		return 1;
	}
	if(!fexist("ladmin/users/"))
	{
	    print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
	  	SetTimerEx("PrintWarning",2500,0,"s","ladmin/users");
		return 1;
	}
//==============================================================================
	UpdateConfig();
//==============================================================================
	#if defined DISPLAY_CONFIG
	ConfigInConsole();
	#endif
//==============================================================================
	#if defined USE_MENUS
	#endif
//==============================================================================
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) OnPlayerConnect(i);
	for(new i = 1; i < MAX_CHAT_LINES; i++) Chat[i] = "<none>";
	for(new i = 1; i < MAX_REPORTS; i++) Reports[i] = "<none>";
//==============================================================================
	PingTimer = SetTimer("PingKick",5000,1);
	GodTimer = SetTimer("GodUpdate",2000,1);
//==============================================================================
	new year,month,day;	getdate(year, month, day);
	new hour,minute,second; gettime(hour,minute,second);
//==============================================================================
	return 1;
}
//==============================================================================
public OnFilterScriptExit()
{
//==============================================================================
	KillTimer(PingTimer);
	KillTimer(GodTimer);
	#if defined USE_MENUS
	#endif
//==============================================================================
	new year,month,day;	getdate(year, month, day);
	new hour,minute,second; gettime(hour,minute,second);
	return 1;
}
//==============================================================================
public OnPlayerConnect(playerid)
{
	PlayerInfo[playerid][Deaths] = 0;
	PlayerInfo[playerid][Kills] = 0;
	PlayerInfo[playerid][Jailed] = 0;
	PlayerInfo[playerid][Frozen] = 0;
	PlayerInfo[playerid][Level] = 0;
	PlayerInfo[playerid][LoggedIn] = 0;
	PlayerInfo[playerid][Registered] = 0;
	PlayerInfo[playerid][God] = 0;
	PlayerInfo[playerid][GodCar] = 0;
	PlayerInfo[playerid][TimesSpawned] = 0;
	PlayerInfo[playerid][Muted] = 0;
	PlayerInfo[playerid][MuteWarnings] = 0;
	PlayerInfo[playerid][Warnings] = 0;
	PlayerInfo[playerid][Caps] = 0;
	PlayerInfo[playerid][DoorsLocked] = 0;
	PlayerInfo[playerid][pCar] = -1;
	for(new i; i<PING_MAX_EXCEEDS; i++) PlayerInfo[playerid][pPing][i] = 0;
	PlayerInfo[playerid][SpamCount] = 0;
	PlayerInfo[playerid][SpamTime] = 0;
	PlayerInfo[playerid][PingCount] = 0;
	PlayerInfo[playerid][PingTime] = 0;
	PlayerInfo[playerid][FailLogin] = 0;
	PlayerInfo[playerid][ConnectTime] = gettime();
//==============================================================================
	new PlayerName[MAX_PLAYER_NAME], string[128], str[128], file[256];
	GetPlayerName(playerid, PlayerName, MAX_PLAYER_NAME);
	new tmp3[50]; GetPlayerIp(playerid,tmp3,50);
//==============================================================================
    if (dUserINT(PlayerName2(playerid)).("banned") == 1)
    {
        SendClientMessage(playerid, red, "[AVISO]: Este nome está banido deste servidor!");
		format(string,sizeof(string),"[FCT]Hexa-ADM kickou %s ID:%d! Motivo: Nome banido do server!",PlayerName,playerid);
		SendClientMessageToAll(grey, string);  print(string);
		SaveToFile("KickLog",string);  Kick(playerid);
    }
//==============================================================================
	if(ServerInfo[NameKick] == 1) {
		for(new s = 0; s < BadNameCount; s++) {
  			if(!strcmp(BadNames[s],PlayerName,true)) {
				SendClientMessage(playerid,red, "[AVISO]: Seu nome está em nossa lista negra, você foi kickado.");
				format(string,sizeof(string),"[FCT]Hexa-ADM kickou %s ID:%d! Motivo: Nome proibido!",PlayerName,playerid);
				SendClientMessageToAll(grey, string);  print(string);
				SaveToFile("KickLog",string);  Kick(playerid);
				return 1;
			}
		}
	}
//==============================================================================
	if(ServerInfo[PartNameKick] == 1) {
		for(new s = 0; s < BadPartNameCount; s++) {
			new pos;
			while((pos = strfind(PlayerName,BadPartNames[s],true)) != -1) for(new i = pos, j = pos + strlen(BadPartNames[s]); i < j; i++)
			{
				SendClientMessage(playerid,red, "Seu nome não é permitido neste servidor, você foi kickado.");
				format(string,sizeof(string),"[FCT]Hexa-ADM kickou %s ID:%d! Motivo: Nome proibido!",PlayerName,playerid);
				SendClientMessageToAll(grey, string);  print(string);
				SaveToFile("KickLog",string);  Kick(playerid);
				return 1;
			}
		}
	}
//==============================================================================
	if(strlen(dini_Get("ladmin/config/aka.txt", tmp3)) == 0) dini_Set("ladmin/config/aka.txt", tmp3, PlayerName);
 	else
	{
	    if( strfind( dini_Get("ladmin/config/aka.txt", tmp3), PlayerName, true) == -1 )
		{
		    format(string,sizeof(string),"%s,%s", dini_Get("ladmin/config/aka.txt",tmp3), PlayerName);
		    dini_Set("ladmin/config/aka.txt", tmp3, string);
		}
	}
//==============================================================================
	if(!udb_Exists(PlayerName2(playerid))) SendClientMessage(playerid,orange, " ");
	else
	{
	    PlayerInfo[playerid][Registered] = 1;
		format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(PlayerName));
		new tmp2[256]; tmp2 = dini_Get(file,"ip");
		if( (!strcmp(tmp3,tmp2,true)) && (ServerInfo[AutoLogin] == 1) )
		{
			LoginPlayer(playerid);
			if(PlayerInfo[playerid][Level] > 0)
			{
				format(string,sizeof(string)," ", PlayerInfo[playerid][Level] );
				SendClientMessage(playerid,green,string);
       		}
	   		else SendClientMessage(playerid,green," ");
  	    }
 		else SendClientMessage(playerid, green, " ");
	}
 	return 1;
}
//==============================================================================
public OnPlayerDisconnect(playerid, reason)
{
	new PlayerName[MAX_PLAYER_NAME], str[128];
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));

	if(ServerInfo[ConnectMessages] == 1)
	{
		switch (reason) {
		}
		SendClientMessageToAll(grey, str);
	}
	if(PlayerInfo[playerid][LoggedIn] == 1)	SavePlayer(playerid);
	if(udb_Exists(PlayerName2(playerid))) dUserSetINT(PlayerName2(playerid)).("loggedin",0);
  	PlayerInfo[playerid][LoggedIn] = 0;
	PlayerInfo[playerid][Level] = 0;
	PlayerInfo[playerid][Jailed] = 0;
	PlayerInfo[playerid][Frozen] = 0;
	if(PlayerInfo[playerid][Jailed] == 1) KillTimer( JailTimer[playerid] );
	if(PlayerInfo[playerid][Frozen] == 1) KillTimer( FreezeTimer[playerid] );
	if(ServerInfo[Locked] == 1)	KillTimer( LockKickTimer[playerid] );
	if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
	#if defined ENABLE_SPEC
	for(new x=0; x<MAX_PLAYERS; x++)
	    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid)
   		   	AdvanceSpectate(x);
	#endif
 	return 1;
}
//==============================================================================
forward DelayKillPlayer(playerid);
//==============================================================================
public DelayKillPlayer(playerid)
{
	SetPlayerHealth(playerid,0.0);
	ForceClassSelection(playerid);
}
//==============================================================================
public OnPlayerDeath(playerid, killerid, reason)
{
	#if defined USE_STATS
    PlayerInfo[playerid][Deaths]++;
	#endif
    InDuel[playerid] = 0;
    
	if(IsPlayerConnected(killerid) && killerid != INVALID_PLAYER_ID)
	{
		#if defined USE_STATS
		PlayerInfo[killerid][Kills]++;
	    #endif
	    
		if(InDuel[playerid] == 1 && InDuel[killerid] == 1)
		{
			GameTextForPlayer(playerid,"Perdedor !",3000,3);
			GameTextForPlayer(killerid,"Vencedor !",3000,3);
			InDuel[killerid] = 0;
			SetPlayerPos(killerid, 0.0, 0.0, 0.0);
			SpawnPlayer(killerid);
		}
		else if(InDuel[playerid] == 1 && InDuel[killerid] == 0)
		{
			GameTextForPlayer(playerid,"Perdedor !",3000,3);
		}
	}

	#if defined ENABLE_SPEC
	for(new x=0; x<MAX_PLAYERS; x++)
	    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid)
	       AdvanceSpectate(x);
	#endif
	

	return 1;
}
//==============================================================================
public OnPlayerText(playerid, text[])
{
	if(text[0] == '#' && PlayerInfo[playerid][Level] >= 1) {
	    new string[128]; GetPlayerName(playerid,string,sizeof(string));
		format(string,sizeof(string),"Admin Chat: %s: %s",string,text[1]); MessageToAdmins(green,string);
	    return 0;
	}

	if(ServerInfo[DisableChat] == 1) {
		SendClientMessage(playerid,red,"[AVISO]: O chat foi desativado!");
	 	return 0;
	}
	
 	if(PlayerInfo[playerid][Muted] == 1)
	{
 		PlayerInfo[playerid][MuteWarnings]++;
 		new string[128];
		if(PlayerInfo[playerid][MuteWarnings] < ServerInfo[MaxMuteWarnings]) {
			format(string, sizeof(string),"[AVISO]: Você foi calado, se você continuar a fazer flood você vai ser kickado! (%d / %d)", PlayerInfo[playerid][MuteWarnings], ServerInfo[MaxMuteWarnings] );
			SendClientMessage(playerid,red,string);
		} else {
			SendClientMessage(playerid,red,"[AVISO]: Você foi avisado! Agora você foi kickado");
			format(string, sizeof(string),"[FCT]Hexa-ADM kickou %s (ID %d) por fazer flood", PlayerName2(playerid), playerid);
			SendClientMessageToAll(grey,string);
			SaveToFile("KickLog",string); Kick(playerid);
		} return 0;
	}

	if(ServerInfo[AntiSpam] == 1 && (PlayerInfo[playerid][Level] == 0 && !IsPlayerAdmin(playerid)) )
	{
		if(PlayerInfo[playerid][SpamCount] == 0) PlayerInfo[playerid][SpamTime] = TimeStamp();

	    PlayerInfo[playerid][SpamCount]++;
		if(TimeStamp() - PlayerInfo[playerid][SpamTime] > SPAM_TIMELIMIT) {
			PlayerInfo[playerid][SpamCount] = 0;
			PlayerInfo[playerid][SpamTime] = TimeStamp();
		}
		else if(PlayerInfo[playerid][SpamCount] == SPAM_MAX_MSGS) {
			new string[64]; format(string,sizeof(string),"[FCT]Hexa-ADM kickou %s (Flood - Spam)", PlayerName2(playerid));
			SendClientMessageToAll(grey,string); print(string);
			SaveToFile("KickLog",string);
			Kick(playerid);
		}
		else if(PlayerInfo[playerid][SpamCount] == SPAM_MAX_MSGS-1) {
			SendClientMessage(playerid,red,"[AVISO]: Pare de Spam! Próximo vez é kick!");
			return 0;
		}
	}

	if(ServerInfo[AntiSwear] == 1 && PlayerInfo[playerid][Level] < ServerInfo[MaxAdminLevel])
	for(new s = 0; s < ForbiddenWordCount; s++)
    {
		new pos;
		while((pos = strfind(text,ForbiddenWords[s],true)) != -1) for(new i = pos, j = pos + strlen(ForbiddenWords[s]); i < j; i++) text[i] = '*';
	}

	if(PlayerInfo[playerid][Caps] == 1) UpperToLower(text);
	if(ServerInfo[NoCaps] == 1) UpperToLower(text);

	for(new i = 1; i < MAX_CHAT_LINES-1; i++) Chat[i] = Chat[i+1];
 	new ChatSTR[128]; GetPlayerName(playerid,ChatSTR,sizeof(ChatSTR)); format(ChatSTR,128,"[lchat]%s: %s",ChatSTR, text[0] );
	Chat[MAX_CHAT_LINES-1] = ChatSTR;
	return 1;
}
//==============================================================================
forward HighLight(playerid);
//==============================================================================
public HighLight(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	if(PlayerInfo[playerid][blipS] == 0) { SetPlayerColor(playerid, 0xFF0000AA); PlayerInfo[playerid][blipS] = 1; }
	else { SetPlayerColor(playerid, 0x33FF33AA); PlayerInfo[playerid][blipS] = 0; }
	return 0;
}
//==============================================================================
dcmd_dararma(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USO: /giveweapon [playerid] [id arma/nome arma] [munição]");
		new player1 = strval(tmp), weap, ammo, WeapName[32], string[128];
		if(!strlen(tmp3) || !IsNumeric(tmp3) || strval(tmp3) <= 0 || strval(tmp3) > 99999) ammo = 500; else ammo = strval(tmp3);
		if(!IsNumeric(tmp2)) weap = GetWeaponIDFromName(tmp2); else weap = strval(tmp2);
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
        	if(!IsValidWeapon(weap)) return SendClientMessage(playerid,red,"ERRO: ID da arma inválido");
			CMDMessageToAdmins(playerid,"GIVEWEAPON");
			GetWeaponName(weap,WeapName,32);
			format(string, sizeof(string), "Você deu a \"%s\" uma %s (%d) com %d balas de munição", PlayerName2(player1), WeapName, weap, ammo); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" deu a você uma %s (%d) com %d balas de munição", PlayerName2(playerid), WeapName, weap, ammo); SendClientMessage(player1,blue,string); }
   			return GivePlayerWeapon(player1, weap, ammo);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setarvida(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /sethealth [playerid] [valor]");
		if(strval(tmp2) < 0 || strval(tmp2) > 100 && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid, red, "ERRO: Valor de saúde inválida");
		new player1 = strval(tmp), health = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETHEALTH");
			format(string, sizeof(string), "Você definiu a saúde de \"%s\" para '%d", pName(player1), health); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu sua saúde para '%d'", pName(playerid), health); SendClientMessage(player1,blue,string); }
   			return SetPlayerHealth(player1, health);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setarcolete(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /setarmour [playerid] [valor]");
		if(strval(tmp2) < 0 || strval(tmp2) > 100 && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid, red, "ERRO: Valor de colete inválido");
		new player1 = strval(tmp), armour = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETARMOUR");
			format(string, sizeof(string), "Você definiu o colete de  \"%s\" para '%d", pName(player1), armour); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu seu colete para '%d'", pName(playerid), armour); SendClientMessage(player1,blue,string); }
   			return SetPlayerArmour(player1, armour);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setargrana(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /setcash [playerid] [valor]");
		new player1 = strval(tmp), cash = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETCASH");
			format(string, sizeof(string), "Você definiu a grana de \"%s\" para '$%d", pName(player1), cash); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu sua grana para '$%d'", pName(playerid), cash); SendClientMessage(player1,blue,string); }
			ResetPlayerMoney(player1);
   			return GivePlayerMoney(player1, cash);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setscore(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /setscore [playerid] [score]");
		new player1 = strval(tmp), score = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETSCORE");
			format(string, sizeof(string), "Você definiu o score de \"%s\" para '%d' ", pName(player1), score); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu seu score para '%d'", pName(playerid), score); SendClientMessage(player1,blue,string); }
   			return SetPlayerScore(player1, score);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setarskin(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /setskin [playerid] [skin id]");
		new player1 = strval(tmp), skin = strval(tmp2), string[128];
		if(!IsValidSkin(skin)) return SendClientMessage(playerid, red, "ERRO: ID da skin inválido");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETSKIN");
			format(string, sizeof(string), "Você definiu a skin de \"%s\" para '%d", pName(player1), skin); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu seu skin para '%d'", pName(playerid), skin); SendClientMessage(player1,blue,string); }
   			return SetPlayerSkin(player1, skin);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setwanted(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /setwanted [playerid] [nivel]");
		new player1 = strval(tmp), wanted = strval(tmp2), string[128];
//		if(wanted > 6) return SendClientMessage(playerid, red, "ERROR: Invaild wanted level");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETWANTED");
			format(string, sizeof(string), "Você definiu o nível de procurado de \"%s\" para '%d", pName(player1), wanted); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu seu nível de procurado para '%d'", pName(playerid), wanted); SendClientMessage(player1,blue,string); }
   			return SetPlayerWantedLevel(player1, wanted);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setname(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USO: /setname [playerid] [novo nome]");
		new player1 = strval(tmp), length = strlen(tmp2), string[128];
		if(length < 3 || length > MAX_PLAYER_NAME) return SendClientMessage(playerid,red,"ERRO: Comprimento do Nome Incorreto");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETNAME");
			format(string, sizeof(string), "Você definiu o nome de \"%s\" para \"%s\" ", pName(player1), tmp2); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu seu nome para \"%s\" ", pName(playerid), tmp2); SendClientMessage(player1,blue,string); }
			SetPlayerName(player1, tmp2);
   			return OnPlayerConnect(player1);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setcolor(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) {
			SendClientMessage(playerid, red, "USO: /setcolor [playerid] [Cor]");
			return SendClientMessage(playerid, red, "Cores: 0=preto 1=branco 2=vermelho 3=laranja 4=amarelo 5=verde 6=azul 7=roxo 8=marrom 9=rosa");
		}
		new player1 = strval(tmp), Colour = strval(tmp2), string[128], colour[24];
		if(Colour > 9) return SendClientMessage(playerid, red, "Cores: 0=preto 1=branco 2=vermelho 3=laranja 4=amarelo 5=verde 6=azul 7=roxo 8=marrom 9=rosa");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
	        CMDMessageToAdmins(playerid,"SETCOLOR");
			switch (Colour)
			{
			    case 0: { SetPlayerColor(player1,black); colour = "Preto"; }
			    case 1: { SetPlayerColor(player1,COLOR_WHITE); colour = "Branco"; }
			    case 2: { SetPlayerColor(player1,red); colour = "Vermelho"; }
			    case 3: { SetPlayerColor(player1,orange); colour = "Laranja"; }
				case 4: { SetPlayerColor(player1,orange); colour = "Amarelo"; }
				case 5: { SetPlayerColor(player1,COLOR_GREEN1); colour = "Verde"; }
				case 6: { SetPlayerColor(player1,COLOR_BLUE); colour = "Azul"; }
				case 7: { SetPlayerColor(player1,COLOR_PURPLE); colour = "Roxo"; }
				case 8: { SetPlayerColor(player1,COLOR_BROWN); colour = "Marro"; }
				case 9: { SetPlayerColor(player1,COLOR_PINK); colour = "Rosa"; }
			}
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu sua cor para '%s' ", pName(playerid), colour); SendClientMessage(player1,blue,string); }
			format(string, sizeof(string), "Você definiu a cor de \"%s\" para '%s' ", pName(player1), colour);
   			return SendClientMessage(playerid,blue,string);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setweather(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /setweather [playerid] [id do clima]");
		new player1 = strval(tmp), weather = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETWEATHER");
			format(string, sizeof(string), "Você definiu o clima de \"%s\" para '%d", pName(player1), weather); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu seu clima para '%d'", pName(playerid), weather); SendClientMessage(player1,blue,string); }
			SetPlayerWeather(player1,weather); PlayerPlaySound(player1,1057,0.0,0.0,0.0);
   			return PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setarhora(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /setarhora [playerid] [horas]");
		new player1 = strval(tmp), time = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETTIME");
			format(string, sizeof(string), "Você definiu o horário de \"%s\" para %d:00", pName(player1), time); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu seu horário para %d:00", pName(playerid), time); SendClientMessage(player1,blue,string); }
			PlayerPlaySound(player1,1057,0.0,0.0,0.0);
   			return SetPlayerTime(player1, time, 0);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setworld(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /setworld [playerid] [mundo virtual]");
		new player1 = strval(tmp), time = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETWORLD");
			format(string, sizeof(string), "Você definiu o mundo virtual de \"%s\" para '%d'", pName(player1), time); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu seu mundo virtual para '%d' ", pName(playerid), time); SendClientMessage(player1,blue,string); }
			PlayerPlaySound(player1,1057,0.0,0.0,0.0);
   			return SetPlayerVirtualWorld(player1, time);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setinterior(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /setinterior [playerid] [interior]");
		new player1 = strval(tmp), time = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETINTERIOR");
			format(string, sizeof(string), "Você definiu o interior de \"%s\" para '%d' ", pName(player1), time); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu seu interior para '%d' ", pName(playerid), time); SendClientMessage(player1,blue,string); }
			PlayerPlaySound(player1,1057,0.0,0.0,0.0);
   			return SetPlayerInterior(player1, time);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setmytime(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /setmytime [horas]");
		new time = strval(params), string[128];
		CMDMessageToAdmins(playerid,"SETMYTIME");
		format(string,sizeof(string),"Você definiu o seu horário para %d:00", time); SendClientMessage(playerid,blue,string);
		return SetPlayerTime(playerid, time, 0);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_force(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /force [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"FORCE");
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" obrigou você a retornar para a seleção de classes", pName(playerid) ); SendClientMessage(player1,blue,string); }
			format(string,sizeof(string),"Você obrigou \"%s\" para a seleção de classes", pName(player1)); SendClientMessage(playerid,blue,string);
			ForceClassSelection(player1);
			return SetPlayerHealth(player1,0.0);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_eject(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /eject [playerid]");
		new player1 = strval(params), string[128], Float:x, Float:y, Float:z;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(IsPlayerInAnyVehicle(player1)) {
		       	CMDMessageToAdmins(playerid,"EJECT");
				if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" ejetou você do seu veículo", pName(playerid) ); SendClientMessage(player1,blue,string); }
				format(string,sizeof(string),"Você ejetou \"%s\" do seu veículo", pName(player1)); SendClientMessage(playerid,blue,string);
    		   	GetPlayerPos(player1,x,y,z);	
				return SetPlayerPos(player1,x,y,z+3);
			} else return SendClientMessage(playerid,red,"ERRO: O jogador não está em um veículo");
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_lockcar(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 2) {
	    if(IsPlayerInAnyVehicle(playerid)) {
		 	for(new i = 0; i < MAX_PLAYERS; i++) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,false,true);
			CMDMessageToAdmins(playerid,"LOCKCAR");
			PlayerInfo[playerid][DoorsLocked] = 1;
			new string[128]; format(string,sizeof(string),"Administrador \"%s\" trancou o seu carro", pName(playerid));
			return SendClientMessageToAll(blue,string);
		} else return SendClientMessage(playerid,red,"ERRO: Você precisa estar em um veículo para trancar as portas");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_unlockcar(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 2) {
	    if(IsPlayerInAnyVehicle(playerid)) {
		 	for(new i = 0; i < MAX_PLAYERS; i++) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,false,false);
			CMDMessageToAdmins(playerid,"UNLOCKCAR");
			PlayerInfo[playerid][DoorsLocked] = 0;
			new string[128]; format(string,sizeof(string),"Administrador \"%s\" destrancou o seu carro", pName(playerid));
			return SendClientMessageToAll(blue,string);
		} else return SendClientMessage(playerid,red,"ERRO: Você precisa estar em um veículo para trancar as portas");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_burn(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /burn [playerid]");
		new player1 = strval(params), string[128], Float:x, Float:y, Float:z;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"BURN");
			format(string, sizeof(string), "Você torrou \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" torrou você", pName(playerid)); SendClientMessage(player1,blue,string); }
			GetPlayerPos(player1, x, y, z);
			return CreateExplosion(x, y , z + 3, 1, 10);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_spawnplayer(playerid,params[])
{
	return dcmd_spawn(playerid,params);
}
//==============================================================================
dcmd_spawn(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /spawn [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SPAWN");
			format(string, sizeof(string), "Você spawnou \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" spawnou você", pName(playerid)); SendClientMessage(player1,blue,string); }
			SetPlayerPos(player1, 0.0, 0.0, 0.0);
			return SpawnPlayer(player1);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_disarm(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /disarm [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"DISARM");  PlayerPlaySound(player1,1057,0.0,0.0,0.0);
			format(string, sizeof(string), "Você desarmou \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" desarmou você", pName(playerid)); SendClientMessage(player1,blue,string); }
			ResetPlayerWeapons(player1);
			return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_crash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /crash [playerid]");
		new player1 = strval(params), string[128], Float:X,Float:Y,Float:Z;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
   			CMDMessageToAdmins(playerid,"CRASH");
	        GetPlayerPos(player1,X,Y,Z);
	   		new objectcrash = CreatePlayerObject(player1,11111111,X,Y,Z,0,0,0);
			DestroyObject(objectcrash);
			format(string, sizeof(string), "Você crashou o game de \"%s\"", pName(player1) );
			return SendClientMessage(playerid,blue, string);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_ip(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /ip [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"IP");
			new tmp3[50]; GetPlayerIp(player1,tmp3,50);
			format(string,sizeof(string),"IP de \"%s\" é: '%s'", pName(player1), tmp3);
			return SendClientMessage(playerid,blue,string);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_bankrupt(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /bankrupt [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"BANKRUPT");
			format(string, sizeof(string), "Você resetou a grana de \"%s\"", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" resetou a sua grana'", pName(playerid)); SendClientMessage(player1,blue,string); }
   			return ResetPlayerMoney(player1);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_sbankrupt(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /sbankrupt [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"BANKRUPT");
			format(string, sizeof(string), "Você resetou silenciosamente a grana de \"%s\"", pName(player1)); SendClientMessage(playerid,blue,string);
   			return ResetPlayerMoney(player1);
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_kill(playerid,params[]) {
	#pragma unused params
	return SetPlayerHealth(playerid,0.0);
}
//==============================================================================
dcmd_time(playerid,params[]) {
	#pragma unused params
	new string[64], hour,minuite,second; gettime(hour,minuite,second);
	format(string, sizeof(string), "~g~|~w~%d:%d~g~|", hour, minuite);
	return GameTextForPlayer(playerid, string, 5000, 1);
}
//==============================================================================
dcmd_ubound(playerid,params[]) {
 	if(PlayerInfo[playerid][Level] >= 3) {
		if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /ubound [playerid]");
	    new string[128], player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"UBOUND");
			SetPlayerWorldBounds(player1, 9999.9, -9999.9, 9999.9, -9999.9 );
			format(string, sizeof(string), "Administrador %s removeu o seu mundo de fronteiras", PlayerName2(playerid)); if(player1 != playerid) SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"Você removeu o mundo de fronteiras de %s", PlayerName2(player1));
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Jogador não conectado");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_lhelp(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] && PlayerInfo[playerid][Level] >= 1) {
		SendClientMessage(playerid,blue,"--== [ Ajuda LAdmin ] ==--");
		SendClientMessage(playerid,blue, "Para os comandos de admin digite:  /comandos   |   Créditos: /lcredits");
		SendClientMessage(playerid,blue, "Comandos da conta são: /registrar, /logar, /changepass, /stats, /resetstats.  Também  /time, /report");
		SendClientMessage(playerid,blue, "Há 5 níveis. Admins nível 5 são imunes aos comandos");
		SendClientMessage(playerid,blue, "IMPORTANTE: O filterscript deve ser recarregado se você mudar o gamemode");
		}
	else if(PlayerInfo[playerid][LoggedIn] && PlayerInfo[playerid][Level] < 1) {
	 	SendClientMessage(playerid,green, "Seus comandos são: /registrar, /logar, /report, /stats, /time, /changepass, /resetstats, /getid");
 	}
	else if(PlayerInfo[playerid][LoggedIn] == 0) {
 	SendClientMessage(playerid,green, "Seus comandos são: /time, /getid     (Você não está logado, logue para mais comandos)");
	} return 1;
}
//==============================================================================
dcmd_admcmds(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
   	    SendClientMessage(playerid, 0x000000AA, ".•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.");
		SendClientMessage(playerid,lightblue,"[GERAL]: menu, announce, write, miniguns, spec(off), move, countdown, giveweapon");
		SendClientMessage(playerid,lightblue,"[GERAL]: slap, warn, kick, ban, explode, jail, freeze, mute, god, godcar");
		SendClientMessage(playerid,lightblue,"[GERAL]: setlevel, givecar, jetpack");
		SendClientMessage(playerid,lightblue,"[VEICULO]: flip, repair, lockcar, eject, car, bike, plane, heli, barco, nos, cm");
		SendClientMessage(playerid,lightblue,"[TELES]: ir, trazer, get, teleplayer, tele, vgoto, lgoto, moveplayer");
		SendClientMessage(playerid,lightblue,"[DEFINIR]: set(cash/health/armour/gravity/name/time/weather/skin/colour/wanted/templevel)");
		SendClientMessage(playerid,lightblue,"[DEFINIR TODOS]: setall(world/weather/wanted/time/score/cash)");
		SendClientMessage(playerid,lightblue,"[DEFINIR TODOS]: giveallweapon, healall, armourall, freezeall, kickall, ejectall, killall, disarmall, slapall, spawnall");
   	    SendClientMessage(playerid, 0x000000AA, ".•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.");
    }
	return 1;
}
//==============================================================================
dcmd_admincomandos(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
   	    SendClientMessage(playerid, 0x000000AA, ".•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.");
		SendClientMessage(playerid,lightblue,"/nivel1, /nivel2, /nivel3, /nivel4, /nivel5, /rcon ladmin");
		SendClientMessage(playerid,lightblue,"Comandos do Jogador: /registrar, /logar, /report, /stats, /time, /changepass, /resetstats, /getid");
   	    SendClientMessage(playerid, 0x000000AA, ".•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.");
    }
	return 1;
}
//==============================================================================
dcmd_nivel1(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---= Comandos de Admin Nível 1 =---");
		SendClientMessage(playerid,lightblue,"getinfo, weaps, vr, repair, ltune, lhy, nos, lp, asay, ping, lslowmo, ct,");
		SendClientMessage(playerid,lightblue,"morning, adminarea, reports, richlist, miniguns, saveplace, gotoplace,");
		SendClientMessage(playerid,lightblue,"saveskin, useskin, dontuseskin, setmytime, ip, lconfig.");
	}
	return 1;
}
//==============================================================================
dcmd_nivel2(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---= Comandos de Admin Nível 2 =---");
		SendClientMessage(playerid,lightblue,"giveweapon, setcolor, lockcar, unlockcar, burn, spawn, disarm, carro, bike,");
		SendClientMessage(playerid,lightblue,"heli, barco, plane, hightlight, announce, announce2, screen, jetpack, flip,");
		SendClientMessage(playerid,lightblue,"ir, vgoto, lgoto, fuck, warn, slap, jailed, frozen, mute, unmute, muted,");
		SendClientMessage(playerid,lightblue,"laston, spec, specoff, specvehicle, cc, menu, tele, cm, ltmenu,");
		SendClientMessage(playerid,lightblue,"write.");
	}
	return 1;
}
//==============================================================================
dcmd_nivel3(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---= Comandos de Admin Nível 3 =---");
		SendClientMessage(playerid,lightblue,"sethealth, setarmour, setcash, setscore, setskin, setwanted, setname, setweather,");
		SendClientMessage(playerid,lightblue,"settime, setworld, setinterior, force, eject, bankrupt, sbankrupt, ubound, larmas,");
		SendClientMessage(playerid,lightblue,"lammo, countdown, duel, car, carhealth, carcolor, setping, setgravity, delcar,");
		SendClientMessage(playerid,lightblue,"teleplayer, vget, givecar, trazer, get, kick, explode, jail, unjail, freeze, ");
		SendClientMessage(playerid,lightblue,"unfreeze, akill, aka, disablechat, clearallchat, caps, move, moveplayer, healall,");
		SendClientMessage(playerid,lightblue,"armourall, setallskin, setallwanted, setallweather, setalltime, setallworld,");
		SendClientMessage(playerid,lightblue,"setallscore, setallcash, giveallcash, giveallweapon, lweather, ltime, lweapons, setpass");
	}
	return 1;
}
//==============================================================================
dcmd_nivel4(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---= Comandos de Admin Nível 4 =---");
		SendClientMessage(playerid,lightblue,"enable, disable, ban, rban, settemplevel, crash, spam, god, godcar, die, uconfig,");
		SendClientMessage(playerid,lightblue,"botcheck, lockserver, unlockserver, forbidname, forbidword, ");
		SendClientMessage(playerid,lightblue,"fakedeath, spawnall, muteall, unmuteall, getall, killall, freezeall,");
		SendClientMessage(playerid,lightblue,"unfreezeall, kickall, slapalll, explodeall, disarmall, ejectall.");
	}
	return 1;
}
//==============================================================================
dcmd_nivel5(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---= Comandos de Admin Nível 5 =---");
		SendClientMessage(playerid,lightblue,"god, sgod, setlevel, pickup, object, fakechat.");
	}
	return 1;
}
//==============================================================================
dcmd_getinfo(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USO: /getinfo [playerid]");
	    new player1, string[128];
	    player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		    new Float:player1health, Float:player1armour, playerip[128], Float:x, Float:y, Float:z, tmp2[256], file[256],
				year, month, day, P1Jailed[4], P1Frozen[4], P1Logged[4], P1Register[4], RegDate[256], TimesOn;

			GetPlayerHealth(player1,player1health);
			GetPlayerArmour(player1,player1armour);
	    	GetPlayerIp(player1, playerip, sizeof(playerip));
	    	GetPlayerPos(player1,x,y,z);
			getdate(year, month, day);
			format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(PlayerName2(player1)));

			if(PlayerInfo[player1][Jailed] == 1) P1Jailed = "Sim"; else P1Jailed = "Não";
			if(PlayerInfo[player1][Frozen] == 1) P1Frozen = "Sim"; else P1Frozen = "Não";
			if(PlayerInfo[player1][LoggedIn] == 1) P1Logged = "Sim"; else P1Logged = "Não";
			if(fexist(file)) P1Register = "Sim"; else P1Register = "Não";
			if(dUserINT(PlayerName2(player1)).("LastOn")==0) tmp2 = "Nunca"; else tmp2 = dini_Get(file,"LastOn");
			if(strlen(dini_Get(file,"RegisteredDate")) < 3) RegDate = "n/a"; else RegDate = dini_Get(file,"RegisteredDate");
			TimesOn = dUserINT(PlayerName2(player1)).("TimesOnServer");

		    new Sum, Average, w;
			while (w < PING_MAX_EXCEEDS) {
				Sum += PlayerInfo[player1][pPing][w];
				w++;
			}
			Average = (Sum / PING_MAX_EXCEEDS);

	  		format(string, sizeof(string),"(Player Info)  ---====> Nome: %s  ID: %d <====---", PlayerName2(player1), player1);
			SendClientMessage(playerid,lightblue,string);
		  	format(string, sizeof(string),"Saúde: %d  Colete: %d  Score: %d  Dinheiro: %d  Skin: %d  IP: %s  Ping: %d  Média Ping: %d",floatround(player1health),floatround(player1armour),
			GetPlayerScore(player1),GetPlayerMoney(player1),GetPlayerSkin(player1),playerip,GetPlayerPing(player1), Average );
			SendClientMessage(playerid,red,string);
			format(string, sizeof(string),"Interior: %d  Mundo Virtual: %d  Nível Procurado: %d  X %0.1f  Y %0.1f  Z %0.1f", GetPlayerInterior(player1), GetPlayerVirtualWorld(player1), GetPlayerWantedLevel(player1), Float:x,Float:y,Float:z);
			SendClientMessage(playerid,orange,string);
			format(string, sizeof(string),"Tempo No Server: %d  Matou: %d  Morreu: %d  Relação: %0.2f  Nível Admin: %d", TimesOn, PlayerInfo[player1][Kills], PlayerInfo[player1][Deaths], Float:PlayerInfo[player1][Kills]/Float:PlayerInfo[player1][Deaths], PlayerInfo[player1][Level] );
			SendClientMessage(playerid,yellow,string);
			format(string, sizeof(string),"Registrado: %s  Logado: %s  Na Cadeia: %s  Congelado: %s", P1Register, P1Logged, P1Jailed, P1Frozen );
			SendClientMessage(playerid,green,string);
			format(string, sizeof(string),"Progresso No Server: %s  Data de Registro: %s  Data de Hoje: %d/%d/%d", tmp2, RegDate, day,month,year );
			SendClientMessage(playerid,COLOR_GREEN,string);
//==============================================================================
			if(IsPlayerInAnyVehicle(player1)) {
				new Float:VHealth, carid = GetPlayerVehicleID(playerid); GetVehicleHealth(carid,VHealth);
				format(string, sizeof(string),"ID do Veículo: %d  Modelo: %d  Nome do Veículo: %s  Energia do Veículo: %d",carid, GetVehicleModel(carid), VehicleNames[GetVehicleModel(carid)-400], floatround(VHealth) );
				SendClientMessage(playerid,COLOR_BLUE,string);
			}
//==============================================================================
			new slot, ammo, weap, Count, WeapName[24], WeapSTR[128], p; WeapSTR = "Armas: ";
			for (slot = 0; slot < 14; slot++) {	GetPlayerWeaponData(player1, slot, weap, ammo); if( ammo != 0 && weap != 0) Count++; }
			if(Count < 1) return SendClientMessage(playerid,lightblue,"Jogador não tem armas");
			else {
				for (slot = 0; slot < 14; slot++)
				{
					GetPlayerWeaponData(player1, slot, weap, ammo);
					if (ammo > 0 && weap > 0)
					{
						GetWeaponName(weap, WeapName, sizeof(WeapName) );
						if (ammo == 65535 || ammo == 1) format(WeapSTR,sizeof(WeapSTR),"%s%s (1)",WeapSTR, WeapName);
						else format(WeapSTR,sizeof(WeapSTR),"%s%s (%d)",WeapSTR, WeapName, ammo);
						p++;
						if(p >= 5) { SendClientMessage(playerid, lightblue, WeapSTR); format(WeapSTR, sizeof(WeapSTR), "Armas: "); p = 0;
						} else format(WeapSTR, sizeof(WeapSTR), "%s,  ", WeapSTR);
					}
				}
				if(p <= 4 && p > 0) {
					string[strlen(string)-3] = '.';
				    SendClientMessage(playerid, lightblue, WeapSTR);
				}
			}
			return 1;
		} else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"ERROR: Você precisa ser administrador nível 2 para usar este comando");
}
//==============================================================================
dcmd_countdown(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 3) {
        if(CountDown == -1) {
			CountDown = 6;
			SetTimer("countdown",1000,0);
			return CMDMessageToAdmins(playerid,"COUNTDOWN");
		} else return SendClientMessage(playerid,red,"ERRO: Contagem em progresso");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_reparar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if (IsPlayerInAnyVehicle(playerid)) {
			GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
			GetVehicleZAngle(GetPlayerVehicleID(playerid), Pos[playerid][3]);
			SetPlayerCameraPos(playerid, 1929.0, 2137.0, 11.0);
			SetPlayerCameraLookAt(playerid,1935.0, 2138.0, 11.5);
			SetVehiclePos(GetPlayerVehicleID(playerid), 1974.0,2162.0,11.0);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), -90);
			SetTimerEx("RepairCar",1000,0,"i",playerid);
	    	return SendClientMessage(playerid,blue,"[AVISO]: Seu carro estará pronto em 1 segundo");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não está em um veículo");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Normal para usar este comando!");
}
//==============================================================================
dcmd_ltune(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
        new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
        switch(LModel)
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
			return SendClientMessage(playerid,red,"ERRO: Você não pode tunar este veículo");
		}
        CMDMessageToAdmins(playerid,"LTUNE");
		SetVehicleHealth(LVehicleID,2000.0);
		TuneLCar(LVehicleID);
		return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"Erro: Você não está em um veículo!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Normal para usar este comando!");
}
//==============================================================================
dcmd_lhy(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
        new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
        switch(LModel)
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
			return SendClientMessage(playerid,red,"ERRO: Você não pode tunar este veículo!");
		}
        AddVehicleComponent(LVehicleID, 1087);
		return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"Erro: Você não está em um veículo");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Normal para usar este comando!");
}
//==============================================================================
dcmd_carro(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,415);
			CMDMessageToAdmins(playerid,"CARRO");
			return SendClientMessage(playerid,blue,"Aproveite o seu novo carro");
		} else return SendClientMessage(playerid,red,"Erro: Você já tem um veículo");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Super para usar este comando");
}
//==============================================================================
dcmd_bike(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,522);
			CMDMessageToAdmins(playerid,"BIKE");
			return SendClientMessage(playerid,blue,"Aproveite a sua nova moto");
		} else return SendClientMessage(playerid,red,"Erro: Você já tem um veículo");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Super para usar este comando");
}
//==============================================================================
dcmd_heli(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,487);
			CMDMessageToAdmins(playerid,"HELI");
			return SendClientMessage(playerid,blue,"Aproveite o seu novo helicóptero");
		} else return SendClientMessage(playerid,red,"Erro: Você já tem um veículo");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Super para usar este comando");
}
//==============================================================================
dcmd_barco(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,493);
			CMDMessageToAdmins(playerid,"BARCO");
			return SendClientMessage(playerid,blue,"Aproveite o seu novo barco");
		} else return SendClientMessage(playerid,red,"Erro: Você já tem um veículo");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Super para usar este comando");
}
//==============================================================================
dcmd_plane(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,513);
			CMDMessageToAdmins(playerid,"PLANE");
			return SendClientMessage(playerid,blue,"Aproveite o seu novo avião");
		} else return SendClientMessage(playerid,red,"Erro: Você já tem um veículo");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Super para usar este comando");
}
//==============================================================================
dcmd_nos(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
	        switch(GetVehicleModel( GetPlayerVehicleID(playerid) )) {
				case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
				return SendClientMessage(playerid,red,"ERRO: Você não pode tunar este veículo!");
			}
	        AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
			return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERRO: Você deve estar em um veículo.");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_linkcar(playerid,params[]) {
	#pragma unused params
	if(IsPlayerInAnyVehicle(playerid)) {
    	LinkVehicleToInterior(GetPlayerVehicleID(playerid),GetPlayerInterior(playerid));
	    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),GetPlayerVirtualWorld(playerid));
	    return SendClientMessage(playerid,lightblue, "Seu veículo está agora no seu mundo virtual e interior");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar em um veículo.");
 }
//==============================================================================
dcmd_car(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index); tmp3 = strtok(params,Index);
	    if(!strlen(tmp)) return SendClientMessage(playerid, red, "USO: /car [Modelid/Nome] [cor1] [cor2]");
		new car, colour1, colour2, string[128];
   		if(!IsNumeric(tmp)) car = GetVehicleModelIDFromName(tmp); else car = strval(tmp);
		if(car < 400 || car > 611) return  SendClientMessage(playerid, red, "ERRO: Modelo de Veículo Inválido");
		if(!strlen(tmp2)) colour1 = random(126); else colour1 = strval(tmp2);
		if(!strlen(tmp3)) colour2 = random(126); else colour2 = strval(tmp3);
		if(PlayerInfo[playerid][pCar] != -1 && !IsPlayerAdmin(playerid) ) CarDeleter(PlayerInfo[playerid][pCar]);
		new LVehicleID,Float:X,Float:Y,Float:Z, Float:Angle,int1;	GetPlayerPos(playerid, X,Y,Z);	GetPlayerFacingAngle(playerid,Angle);   int1 = GetPlayerInterior(playerid);
		LVehicleID = CreateVehicle(car, X+3,Y,Z, Angle, colour1, colour2, -1); LinkVehicleToInterior(LVehicleID,int1);
		PlayerInfo[playerid][pCar] = LVehicleID;
		CMDMessageToAdmins(playerid,"CAR");
		format(string, sizeof(string), "%s spawnou um \"%s\" (Modelo:%d) cores (%d, %d), at %0.2f, %0.2f, %0.2f", pName(playerid), VehicleNames[car-400], car, colour1, colour2, X, Y, Z);
        SaveToFile("CarSpawns",string);
		format(string, sizeof(string), "Você spawnou um \"%s\" (Modelo:%d) cores (%d, %d)", VehicleNames[car-400], car, colour1, colour2);
		return SendClientMessage(playerid,lightblue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Hiper para usar este comando");
}
//==============================================================================
dcmd_carhealth(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /carhealth [playerid] [valor]");
		new player1 = strval(tmp), health = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
            if(IsPlayerInAnyVehicle(player1)) {
		       	CMDMessageToAdmins(playerid,"CARHEALTH");
				format(string, sizeof(string), "Você definiu a energia do veículo de \"%s\" para '%d", pName(player1), health); SendClientMessage(playerid,blue,string);
				if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" definiu a energia do seu veículo para '%d'", pName(playerid), health); SendClientMessage(player1,blue,string); }
   				return SetVehicleHealth(GetPlayerVehicleID(player1), health);
			} else return SendClientMessage(playerid,red,"ERRO: O jogador não está em um veículo");
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_corveiculo(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index); tmp3 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !strlen(tmp3) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /corveiculo [playerid] [cor1] [cor2]");
		new player1 = strval(tmp), colour1, colour2, string[128];
		if(!strlen(tmp2)) colour1 = random(126); else colour1 = strval(tmp2);
		if(!strlen(tmp3)) colour2 = random(126); else colour2 = strval(tmp3);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
            if(IsPlayerInAnyVehicle(player1)) {
		       	CMDMessageToAdmins(playerid,"CARCOLOUR");
				format(string, sizeof(string), "Você mudou a cor de \"%s\" %s para '%d,%d'", pName(player1), VehicleNames[GetVehicleModel(GetPlayerVehicleID(player1))-400], colour1, colour2 ); SendClientMessage(playerid,blue,string);
				if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" mudou a cor do seu %s para '%d,%d''", pName(playerid), VehicleNames[GetVehicleModel(GetPlayerVehicleID(player1))-400], colour1, colour2 ); SendClientMessage(player1,blue,string); }
   				return ChangeVehicleColor(GetPlayerVehicleID(player1), colour1, colour2);
			} else return SendClientMessage(playerid,red,"ERRO: O jogador não está em um veículo");
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_god(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
    	if(PlayerInfo[playerid][God] == 0)	{
   	    	PlayerInfo[playerid][God] = 1;
    	    SetPlayerHealth(playerid,100000);
			GivePlayerWeapon(playerid,16,50000); GivePlayerWeapon(playerid,26,50000);
           	SendClientMessage(playerid,green,"Modo Deus Ativado");
			return CMDMessageToAdmins(playerid,"GOD");
		} else {
   	        PlayerInfo[playerid][God] = 0;
       	    SendClientMessage(playerid,red,"Modo Deus desativado!");
        	SetPlayerHealth(playerid, 100);
		} return GivePlayerWeapon(playerid,35,0);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ter nível 3 para usar este comando!");
}
//==============================================================================
dcmd_sgod(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
   		if(PlayerInfo[playerid][God] == 0)	{
        	PlayerInfo[playerid][God] = 1;
	        SetPlayerHealth(playerid,100000);
			GivePlayerWeapon(playerid,16,50000); GivePlayerWeapon(playerid,26,50000);  GivePlayerWeapon(playerid,38,50000);
            return SendClientMessage(playerid,green,"Modo Deus Dono Ativado!");
		} else	{
   	        PlayerInfo[playerid][God] = 0;
            SendClientMessage(playerid,red,"Modo Deus Dono desativado!");
	        SetPlayerHealth(playerid, 100); return GivePlayerWeapon(playerid,35,0);	}
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Dono para usar este comando!");
}
//==============================================================================
dcmd_godcar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
		if(IsPlayerInAnyVehicle(playerid)) {
	    	if(PlayerInfo[playerid][GodCar] == 0) {
        		PlayerInfo[playerid][GodCar] = 1;
   				CMDMessageToAdmins(playerid,"GODCAR");
            	return SendClientMessage(playerid,green,"Modo Carro Deus Ativado!");
			} else {
	            PlayerInfo[playerid][GodCar] = 0;
    	        return SendClientMessage(playerid,red,"Modo Carro Deus DesativadO!"); }
		} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa estar em um carro para usar este comando!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_die(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
		new Float:x, Float:y, Float:z ;
		GetPlayerPos( playerid, Float:x, Float:y, Float:z );
		CreateExplosion(Float:x+10, Float:y, Float:z, 8,10.0);
		CreateExplosion(Float:x-10, Float:y, Float:z, 8,10.0);
		CreateExplosion(Float:x, Float:y+10, Float:z, 8,10.0);
		CreateExplosion(Float:x, Float:y-10, Float:z, 8,10.0);
		CreateExplosion(Float:x+10, Float:y+10, Float:z, 8,10.0);
		CreateExplosion(Float:x-10, Float:y+10, Float:z, 8,10.0);
		return CreateExplosion(Float:x-10, Float:y-10, Float:z, 8,10.0);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando!");
}
//==============================================================================
dcmd_getid(playerid,params[]) {
	if(!strlen(params)) return SendClientMessage(playerid,blue,"[ERRO]: Use /getid [parte do nick/id]");
	new found, string[128], playername[MAX_PLAYER_NAME];
	format(string,sizeof(string),"Procurando por: \"%s\" ",params);
	SendClientMessage(playerid,blue,string);
	for(new i=0; i <= MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
	  		GetPlayerName(i, playername, MAX_PLAYER_NAME);
			new namelen = strlen(playername);
			new bool:searched=false;
	    	for(new pos=0; pos <= namelen; pos++)
			{
				if(searched != true)
				{
					if(strfind(playername,params,true) == pos)
					{
		                found++;
						format(string,sizeof(string),"%d. %s (ID %d)",found,playername,i);
						SendClientMessage(playerid, green ,string);
						searched = true;
					}
				}
			}
		}
	}
	if(found == 0) SendClientMessage(playerid, lightblue, "Nenhum jogador com este nick");
	return 1;
}
//==============================================================================
dcmd_asay(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
 		if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /asay [texto]");
		new string[128]; format(string, sizeof(string), "**Admin %s: %s", PlayerName2(playerid), params[0] );
		return SendClientMessageToAll(COLOR_PINK,string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Super para usar este comando");
}
//==============================================================================
dcmd_setping(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
 		if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /setping [ping]   Coloque 0 para desligar");
	    new string[128], ping = strval(params);
		ServerInfo[MaxPing] = ping;
		CMDMessageToAdmins(playerid,"SETPING");
		new file[256]; format(file,sizeof(file),"ladmin/config/Config.ini");
		dini_IntSet(file,"MaxPing",ping);
		for(new i = 0; i <= MAX_PLAYERS; i++) if(IsPlayerConnected(i)) PlayerPlaySound(i,1057,0.0,0.0,0.0);
		if(ping == 0) format(string,sizeof(string),"Administrador %s desligou o limite de ping", PlayerName2(playerid), ping);
		else format(string,sizeof(string),"Administrador %s definiu o limite máximo de ping para %d", PlayerName2(playerid), ping);
		return SendClientMessageToAll(blue,string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Hiper para usar este comando");
}
//==============================================================================
dcmd_ping(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /ping [playerid]");
		new player1 = strval(params), string[128];
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		    new Sum, Average, x;
			while (x < PING_MAX_EXCEEDS) {
				Sum += PlayerInfo[player1][pPing][x];
				x++;
			}
			Average = (Sum / PING_MAX_EXCEEDS);
			format(string, sizeof(string), "\"%s\" (id %d) Média Ping: %d   (Últimas leituras de ping: %d, %d, %d, %d)", PlayerName2(player1), player1, Average, PlayerInfo[player1][pPing][0], PlayerInfo[player1][pPing][1], PlayerInfo[player1][pPing][2], PlayerInfo[player1][pPing][3] );
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Jogador não conectado");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_gps(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USO: /gps [playerid]");
	    new player1, playername[MAX_PLAYER_NAME], string[128];
	    player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		 	GetPlayerName(player1, playername, sizeof(playername));
	 	    if(PlayerInfo[player1][blip] == 0) {
				CMDMessageToAdmins(playerid,"HIGHLIGHT");
				PlayerInfo[player1][pColour] = GetPlayerColor(player1);
				PlayerInfo[player1][blip] = 1;
				BlipTimer[player1] = SetTimerEx("HighLight", 1000, 1, "i", player1);
				format(string,sizeof(string),"Você ligou o gps para %s", playername);
			} else {
				KillTimer( BlipTimer[player1] );
				PlayerInfo[player1][blip] = 0;
				SetPlayerColor(player1, PlayerInfo[player1][pColour] );
				format(string,sizeof(string),"Você desligou o gps para %s", playername);
			}
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Jogador não conectado");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setgravity(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)||!(strval(params)<=50&&strval(params)>=-50)) return SendClientMessage(playerid,red,"USO: /setgravity <-50.0 - 50.0> valor padrão: 0.008");
        CMDMessageToAdmins(playerid,"SETGRAVITY");
		new string[128],adminname[MAX_PLAYER_NAME]; GetPlayerName(playerid, adminname, sizeof(adminname)); new Float:Gravity = floatstr(params);format(string,sizeof(string),"Administrador %s definiu a gravidade para %f",adminname,Gravity);
		SetGravity(Gravity); return SendClientMessageToAll(blue,string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_lcredits(playerid,params[]) {
	#pragma unused params
	return SendClientMessage(playerid,green,"LAdmin. Script Admin para sa-mp 0.2.x. Criado por LethaL. Tradução por Stallone. Versão: 4. Lançado: 07/2008");
}
//==============================================================================
dcmd_serverinfo(playerid,params[]) {
	#pragma unused params
    new TotalVehicles = CreateVehicle(411, 0, 0, 0, 0, 0, 0, 1000);    DestroyVehicle(TotalVehicles);
	new numo = CreateObject(1245,0,0,1000,0,0,0);	DestroyObject(numo);
	new nump = CreatePickup(371,2,0,0,1000);	DestroyPickup(nump);
	new gz = GangZoneCreate(3,3,5,5);	GangZoneDestroy(gz);

	new model[250], nummodel;
	for(new i=1;i<TotalVehicles;i++) model[GetVehicleModel(i)-400]++;
	for(new i=0;i<250;i++)	if(model[i]!=0)	nummodel++;

	new string[256];
	format(string,sizeof(string),"Info Server: [ Jogadores Conectados: %d || Máximo de Jogadores: %d ] [Relação %0.2f ]",ConnectedPlayers(),GetMaxPlayers(),Float:ConnectedPlayers() / Float:GetMaxPlayers() );
	SendClientMessage(playerid,green,string);
	format(string,sizeof(string),"Info Server: [ Veículos: %d || Modelos %d || Jogadores em Veículo: %d || No Carro %d / Na Moto %d ]",TotalVehicles-1,nummodel, InVehCount(),InCarCount(),OnBikeCount() );
	SendClientMessage(playerid,green,string);
	format(string,sizeof(string),"Info Server: [ Objetos: %d || Pickups %d || Zonas de Gang %d ]",numo-1, nump, gz);
	SendClientMessage(playerid,green,string);
	format(string,sizeof(string),"Info Server: [ Jogadores Na Cadeia %d || Jogadores Congelados %d || Calados %d ]",JailedPlayers(),FrozenPlayers(), MutedPlayers() );
	return SendClientMessage(playerid,green,string);
}
//==============================================================================
dcmd_ann(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
    	if(!strlen(params)) return SendClientMessage(playerid,red,"USO: /ann <texto>");
    	CMDMessageToAdmins(playerid,"ANN(anunciar)");
		return GameTextForAll(params,4000,3);
    } else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Super para usar este comando");
}
//==============================================================================
dcmd_ann2(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
        new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index) ,tmp3 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!strlen(tmp3)) return SendClientMessage(playerid,red,"USO: /ann2 <estilo> <tempo> <texto>");
		if(!(strval(tmp) >= 0 && strval(tmp) <= 6) || strval(tmp) == 2)	return SendClientMessage(playerid,red,"ERRO: Estilo de gametext inválido. Estilos: 0 - 6");
		CMDMessageToAdmins(playerid,"Ann2(anunciar modelo2)");
		return GameTextForAll(params[(strlen(tmp)+strlen(tmp2)+2)], strval(tmp2), strval(tmp));
    } else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Super para usar este comando");
}
//==============================================================================
dcmd_lslowmo(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		new Float:x, Float:y, Float:z; GetPlayerPos(playerid, x, y, z); CreatePickup(1241, 4, x, y, z);
		return CMDMessageToAdmins(playerid,"LSLOWMO");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_jetpack(playerid,params[]) {
    if(!strlen(params))	{
    	if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
			SendClientMessage(playerid,blue,"Jetpack Spawned.");
			CMDMessageToAdmins(playerid,"JETPACK");
			return SetPlayerSpecialAction(playerid, 2);
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else {
	    new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
    	player1 = strval(params);
		if(PlayerInfo[playerid][Level] >= 4)	{
		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid)	{
				CMDMessageToAdmins(playerid,"JETPACK");		SetPlayerSpecialAction(player1, 2);
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				format(string,sizeof(string),"Administrador \"%s\" deu a você um jetpack",adminname); SendClientMessage(player1,blue,string);
				format(string,sizeof(string),"Você deu a %s um jetpack", playername);
				return SendClientMessage(playerid,blue,string);
			} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado ou é você mesmo!");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	}
}
//==============================================================================
dcmd_flip(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) {
		    if(IsPlayerInAnyVehicle(playerid)) {
			new VehicleID, Float:X, Float:Y, Float:Z, Float:Angle; GetPlayerPos(playerid, X, Y, Z); VehicleID = GetPlayerVehicleID(playerid);
			GetVehicleZAngle(VehicleID, Angle);	SetVehiclePos(VehicleID, X, Y, Z); SetVehicleZAngle(VehicleID, Angle); SetVehicleHealth(VehicleID,1000.0);
			CMDMessageToAdmins(playerid,"FLIP"); return SendClientMessage(playerid, blue,"Veículo Desvirado. Você também pode fazer /flip [playerid]");
			} else return SendClientMessage(playerid,red,"Erro: Você não está em um veículo. Você também pode fazer /flip [playerid]");
		}
	    new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
	    player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"FLIP");
			if (IsPlayerInAnyVehicle(player1)) {
				new VehicleID, Float:X, Float:Y, Float:Z, Float:Angle; GetPlayerPos(player1, X, Y, Z); VehicleID = GetPlayerVehicleID(player1);
				GetVehicleZAngle(VehicleID, Angle);	SetVehiclePos(VehicleID, X, Y, Z); SetVehicleZAngle(VehicleID, Angle); SetVehicleHealth(VehicleID,1000.0);
				CMDMessageToAdmins(playerid,"FLIP");
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				format(string,sizeof(string),"Administrador %s desvirou o seu veículo",adminname); SendClientMessage(player1,blue,string);
				format(string,sizeof(string),"Você desvirou o veículo de %s", playername);
				return SendClientMessage(playerid, blue,string);
			} else return SendClientMessage(playerid,red,"Erro: Este jogador não está em um veículo");
		} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado ou é você mesmo!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_delcar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) return EraseVehicle(GetPlayerVehicleID(playerid));
	else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_ct(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(!IsPlayerInAnyVehicle(playerid)) {
			if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
			new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
	        LVehicleIDt = CreateVehicle(560,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,LVehicleIDt,0); CMDMessageToAdmins(playerid,"CarroTunado");	    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);
			AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
		    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
		    AddVehicleComponent(LVehicleIDt, 1080);	AddVehicleComponent(LVehicleIDt, 1086); AddVehicleComponent(LVehicleIDt, 1087); AddVehicleComponent(LVehicleIDt, 1010);	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	ChangeVehiclePaintjob(LVehicleIDt,0);
	   	   	SetVehicleVirtualWorld(LVehicleIDt, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(LVehicleIDt, GetPlayerInterior(playerid));
			return PlayerInfo[playerid][pCar] = LVehicleIDt;
		} else return SendClientMessage(playerid,red,"Erro: Você já tem um veículo");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Normal para usar este comando!");
}
//==============================================================================
dcmd_warp(playerid,params[])
{
	return dcmd_teleplayer(playerid,params);
}
//==============================================================================
dcmd_teleplayer(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /teleplayer [playerid] para [playerid]");
		new player1 = strval(tmp), player2 = strval(tmp2), string[128], Float:plocx,Float:plocy,Float:plocz;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
 		 	if(IsPlayerConnected(player2) && player2 != INVALID_PLAYER_ID) {
	 		 	CMDMessageToAdmins(playerid,"TELEPLAYER");
				GetPlayerPos(player2, plocx, plocy, plocz);
				new intid = GetPlayerInterior(player2);	SetPlayerInterior(player1,intid);
				SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(player2));
				if (GetPlayerState(player1) == PLAYER_STATE_DRIVER)
				{
					new VehicleID = GetPlayerVehicleID(player1);
					SetVehiclePos(VehicleID, plocx, plocy+4, plocz); LinkVehicleToInterior(VehicleID,intid);
					SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(player2) );
				}
				else SetPlayerPos(player1,plocx,plocy+2, plocz);
				format(string,sizeof(string),"Administrador \"%s\" teleportou \"%s\" para a localização de \"%s\"", pName(playerid), pName(player1), pName(player2) );
				SendClientMessage(player1,blue,string); SendClientMessage(player2,blue,string);
				format(string,sizeof(string),"Você teleportou \"%s\" para a localização de \"%s\"", pName(player1), pName(player2) );
 		 	    return SendClientMessage(playerid,blue,string);
 		 	} else return SendClientMessage(playerid, red, "Jogador2 não está conectado");
		} else return SendClientMessage(playerid, red, "Jogador1 não está conectado");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_ir(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USO: /ir [playerid]");
	    new player1, string[128];
		if(!IsNumeric(params)) player1 = ReturnPlayerID(params);
	   	else player1 = strval(params);
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"Ir");
			new Float:x, Float:y, Float:z;	GetPlayerPos(player1,x,y,z); SetPlayerInterior(playerid,GetPlayerInterior(player1));
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(player1));
			if(GetPlayerState(playerid) == 2) {
				SetVehiclePos(GetPlayerVehicleID(playerid),x+3,y,z);	LinkVehicleToInterior(GetPlayerVehicleID(playerid),GetPlayerInterior(player1));
				SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),GetPlayerVirtualWorld(player1));
			} else SetPlayerPos(playerid,x+2,y,z);
			format(string,sizeof(string),"[VB]Admin: Você foi teleportado para \"%s\"", pName(player1));
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado ou é você mesmo!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_vgoto(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USO: /vgoto [vehicleid]");
	    new player1, string[128];
	    player1 = strval(params);
		CMDMessageToAdmins(playerid,"VGOTO");
		new Float:x, Float:y, Float:z;	GetVehiclePos(player1,x,y,z);
		SetPlayerVirtualWorld(playerid,GetVehicleVirtualWorld(player1));
		if(GetPlayerState(playerid) == 2) {
			SetVehiclePos(GetPlayerVehicleID(playerid),x+3,y,z);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetVehicleVirtualWorld(player1) );
		} else SetPlayerPos(playerid,x+2,y,z);
		format(string,sizeof(string),"Você foi teleportado para o veículo de id %d", player1);
		return SendClientMessage(playerid,blue,string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_vget(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USO: /vget [vehicleid]");
	    new player1, string[128];
	    player1 = strval(params);
		CMDMessageToAdmins(playerid,"VGET");
		new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z);
		SetVehiclePos(player1,x+3,y,z);
		SetVehicleVirtualWorld(player1,GetPlayerVirtualWorld(playerid));
		format(string,sizeof(string),"Você trouxe o veículo de id %d para sua localização", player1);
		return SendClientMessage(playerid,blue,string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_lgoto(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
		new Float:x, Float:y, Float:z;
        new tmp[256], tmp2[256], tmp3[256];
		new string[128], Index;	tmp = strtok(params,Index); tmp2 = strtok(params,Index); tmp3 = strtok(params,Index);
    	if(!strlen(tmp) || !strlen(tmp2) || !strlen(tmp3)) return SendClientMessage(playerid,red,"USO: /lgoto [x] [y] [z]");
	    x = strval(tmp);		y = strval(tmp2);		z = strval(tmp3);
		CMDMessageToAdmins(playerid,"LGOTO");
		if(GetPlayerState(playerid) == 2) SetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
		else SetPlayerPos(playerid,x,y,z);
		format(string,sizeof(string),"Você foi teleportado para %f, %f, %f", x,y,z); return SendClientMessage(playerid,blue,string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_givecar(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USO: /givecar [playerid]");
	    new player1 = strval(params), playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
	    if(IsPlayerInAnyVehicle(player1)) return SendClientMessage(playerid,red,"ERRO: O jogador já tem um veículo");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GIVECAR");
			new Float:x, Float:y, Float:z;	GetPlayerPos(player1,x,y,z);
			CarSpawner(player1,415);
			GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
			format(string,sizeof(string),"Administrador %s deu a você um carro",adminname);	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"Você deu a %s um carro", playername); return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado ou é você mesmo!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_trazer(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /trazer [playerid]");
    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
		player1 = strval(params);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"Trazer");
			new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z); SetPlayerInterior(player1,GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(playerid));
			if(GetPlayerState(player1) == 2)	{
			    new VehicleID = GetPlayerVehicleID(player1);
				SetVehiclePos(VehicleID,x+3,y,z);   LinkVehicleToInterior(VehicleID,GetPlayerInterior(playerid));
				SetVehicleVirtualWorld(GetPlayerVehicleID(player1),GetPlayerVirtualWorld(playerid));
			} else SetPlayerPos(player1,x+2,y,z);
			GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
			format(string,sizeof(string),"[VB]Admin: Você foi teleportado para a localização do Administrador: %s",adminname);	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"[VB]Admin: Você teleportou %s para sua localização", playername); return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado ou é você mesmo!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_get(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3|| IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /get [playerid]");
    	new player1, string[128];
		if(!IsNumeric(params)) player1 = ReturnPlayerID(params);
	   	else player1 = strval(params);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GET");
			new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z); SetPlayerInterior(player1,GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(playerid));
			if(GetPlayerState(player1) == 2)	{
			    new VehicleID = GetPlayerVehicleID(player1);
				SetVehiclePos(VehicleID,x+3,y,z);   LinkVehicleToInterior(VehicleID,GetPlayerInterior(playerid));
				SetVehicleVirtualWorld(GetPlayerVehicleID(player1),GetPlayerVirtualWorld(playerid));
			} else SetPlayerPos(player1,x+2,y,z);
			format(string,sizeof(string),"Você foi teleportado para a localização do Administrador \"%s\"", pName(playerid) );	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"Você teleportou \"%s\" para sua localização", pName(player1) );
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado ou é você mesmo!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_fuck(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /fuck [playerid]");
    	new player1 = strval(params), string[128], NewName[MAX_PLAYER_NAME];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"FUCK");
			SetPlayerHealth(player1,1.0); SetPlayerArmour(player1,0.0); ResetPlayerWeapons(player1);ResetPlayerMoney(player1);GivePlayerWeapon(player1,12,1);
			SetPlayerSkin(player1, 137); SetPlayerScore(player1, 0); SetPlayerColor(player1,COLOR_PINK); SetPlayerWeather(player1,19); SetPlayerWantedLevel(player1,6);
			format(NewName,sizeof(NewName),"[N00B]%s", pName(player1) ); SetPlayerName(player1,NewName);
			if(IsPlayerInAnyVehicle(player1)) EraseVehicle(GetPlayerVehicleID(player1));
			if(player1 != playerid)	{ format(string,sizeof(string),"~w~%s: ~r~Vai Se Fuder", pName(playerid) ); GameTextForPlayer(player1, string, 2500, 3); }
			format(string,sizeof(string),"Vai tomar no seu cu, \"%s\"", pName(player1) ); return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Jogador não conectado");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_warn(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2) {
	    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USO: /warn [playerid] [motivo]");
    	new warned = strval(tmp), str[128];
		if(PlayerInfo[warned][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
	 	if(IsPlayerConnected(warned) && warned != INVALID_PLAYER_ID) {
 	    	if(warned != playerid) {
			    CMDMessageToAdmins(playerid,"WARN");
				PlayerInfo[warned][Warnings]++;
				if( PlayerInfo[warned][Warnings] == MAX_WARNINGS) {
					format(str, sizeof (str), "***Administrador \"%s\" kickou \"%s\".  (Motivo: %s) (Aviso: %d/%d)***", pName(playerid), pName(warned), params[1+strlen(tmp)], PlayerInfo[warned][Warnings], MAX_WARNINGS);
					SendClientMessageToAll(grey, str);
					SaveToFile("KickLog",str);	Kick(warned);
					return PlayerInfo[warned][Warnings] = 0;
				} else {
					format(str, sizeof (str), "***Administrador \"%s\" deu a \"%s\" uma advertência.  (Motivo: %s) (Aviso: %d/%d)***", pName(playerid), pName(warned), params[1+strlen(tmp)], PlayerInfo[warned][Warnings], MAX_WARNINGS);
					return SendClientMessageToAll(yellow, str);
				}
			} else return SendClientMessage(playerid, red, "ERRO: Você não pode advertir você mesmo");
		} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_kick(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
	    if(PlayerInfo[playerid][Level] >= 3) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /kick [playerid] [motivo]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				CMDMessageToAdmins(playerid,"KICK");
				if(!strlen(tmp2)) {
					format(string,sizeof(string),"%s foi kickado pelo Administrador %s [nenhuma razão dada] ",playername,adminname); SendClientMessageToAll(grey,string);
					SaveToFile("KickLog",string); print(string); return Kick(player1);
				} else {
					format(string,sizeof(string),"%s foi kickado pelo Administrador %s [Motivo: %s] ",playername,adminname,params[2]); SendClientMessageToAll(grey,string);
					SaveToFile("KickLog",string); print(string); return Kick(player1); }
			} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado ou é você mesmo! ou é um admin com nível alto");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_ban(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 4) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /ban [playerid] [motivo]");
			if(!strlen(tmp2)) return SendClientMessage(playerid, red, "ERRO: Você deve dar um motivo");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
				new year,month,day,hour,minuite,second; getdate(year, month, day); gettime(hour,minuite,second);
				CMDMessageToAdmins(playerid,"BAN");
				format(string,sizeof(string),"%s foi banido pelo Administrador %s [Motivo: %s] [Data: %d/%d/%d] [Hora: %d:%d]",playername,adminname,params[2],day,month,year,hour,minuite);
				SendClientMessageToAll(grey,string);
				SaveToFile("BanLog",string);
				print(string);
				if(udb_Exists(PlayerName2(player1)) && PlayerInfo[player1][LoggedIn] == 1) dUserSetINT(PlayerName2(player1)).("banned",1);
				format(string,sizeof(string),"banido pelo Administrador %s. Motivo: %s", adminname, params[2] );
				return BanEx(player1, string);
			} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado ou é você mesmo! ou é um admin com nível alto");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_rban(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 4) {
		    new ip[128], tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /rban [playerid] [motivo]");
			if(!strlen(tmp2)) return SendClientMessage(playerid, red, "ERRO: Você deve dar um motivo");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
				new year,month,day,hour,minuite,second; getdate(year, month, day); gettime(hour,minuite,second);
				CMDMessageToAdmins(playerid,"RBAN");
				format(string,sizeof(string),"%s foi banido pela faixa do n. IP pelo Administrador %s [Motivo: %s] [Data: %d/%d/%d] [Hora: %d:%d]",playername,adminname,params[2],day,month,year,hour,minuite);
				SendClientMessageToAll(grey,string);
				SaveToFile("BanLog",string);
				print(string);
				if(udb_Exists(PlayerName2(player1)) && PlayerInfo[player1][LoggedIn] == 1) dUserSetINT(PlayerName2(player1)).("banned",1);
				GetPlayerIp(player1,ip,sizeof(ip));
	            strdel(ip,strlen(ip)-2,strlen(ip));
    	        format(ip,128,"%s**",ip);
				format(ip,128,"banip %s",ip);
            	SendRconCommand(ip);
				return 1;
			} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado ou é você mesmo! ou é um admin com nível alto");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_tapa(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /tapa [playerid] [motivo]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);
			
		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				CMDMessageToAdmins(playerid,"SLAP");
		        new Float:Health, Float:x, Float:y, Float:z; GetPlayerHealth(player1,Health); SetPlayerHealth(player1,Health-25);
				GetPlayerPos(player1,x,y,z); SetPlayerPos(player1,x,y,z+5); PlayerPlaySound(playerid,1190,0.0,0.0,0.0); PlayerPlaySound(player1,1190,0.0,0.0,0.0);

				if(strlen(tmp2)) {
					format(string,sizeof(string),"Você levou uma surra do Administrador %s %s ",adminname,params[2]);	SendClientMessage(player1,red,string);
					format(string,sizeof(string),"Você deu uma porrada em %s %s ",playername,params[2]); return SendClientMessage(playerid,blue,string);
				} else {
					format(string,sizeof(string),"Você levou uma surra do Administrador %s ",adminname);	SendClientMessage(player1,red,string);
					format(string,sizeof(string),"Você deu uma porrada em %s",playername); return SendClientMessage(playerid,blue,string); }
			} else return SendClientMessage(playerid, red, "Jogador não conectado ou é um admin com nível alto");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_explode(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 3) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /explode [playerid] [motivo]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername)); 	GetPlayerName(playerid, adminname, sizeof(adminname));
				CMDMessageToAdmins(playerid,"EXPLODE");
				new Float:burnx, Float:burny, Float:burnz; GetPlayerPos(player1,burnx, burny, burnz); CreateExplosion(burnx, burny , burnz, 7,10.0);

				if(strlen(tmp2)) {
					format(string,sizeof(string),"Você foi estourado pelo Administrador %s [motivo: %s]",adminname,params[2]); SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"Você detonou %s [motivo: %s]", playername,params[2]); return SendClientMessage(playerid,blue,string);
				} else {
					format(string,sizeof(string),"Você foi estourado pelo Administrador %s",adminname); SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"Você detonou %s", playername); return SendClientMessage(playerid,blue,string); }
			} else return SendClientMessage(playerid, red, "Jogador não conectado ou é um admin com nível alto");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_jail(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 3) {
		    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /jail [playerid] [minutos] [motivo]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				if(PlayerInfo[player1][Jailed] == 0) {
					GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
					new jtime = strval(tmp2);
					if(jtime == 0) jtime = 9999;

			       	CMDMessageToAdmins(playerid,"JAIL");
					PlayerInfo[player1][JailTime] = jtime*1000*60;
    			    SetTimerEx("JailPlayer",5000,0,"d",player1);
		    	    SetTimerEx("Jail1",1000,0,"d",player1);
		        	PlayerInfo[player1][Jailed] = 1;

					if(jtime == 9999) {
						if(!strlen(params[strlen(tmp2)+1])) format(string,sizeof(string),"Administrador %s prendeu %s ",adminname, playername);
						else format(string,sizeof(string),"Administrador %s prendeu %s [motivo: %s]",adminname, playername, params[strlen(tmp)+1] );
   					} else {
						if(!strlen(tmp3)) format(string,sizeof(string),"Administrador %s prendeu %s por %d minutos",adminname, playername, jtime);
						else format(string,sizeof(string),"Administrador %s prendeu %s por %d minutos [motivo: %s]",adminname, playername, jtime, params[strlen(tmp2)+strlen(tmp)+1] );
					}
	    			return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "O jogador já está na cadeia");
			} else return SendClientMessage(playerid, red, "Jogador não conectado ou é um admin com nível alto");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_unjail(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 3) {
		    new tmp[256], Index; tmp = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /unjail [playerid]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				if(PlayerInfo[player1][Jailed] == 1) {
					GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
					format(string,sizeof(string),"Administrador %s libertou você",adminname);	SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"Administrador %s libertou %s",adminname, playername);
					JailRelease(player1);
					return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "O jogador não está na cadeia");
			} else return SendClientMessage(playerid, red, "Jogador não conectado ou é um admin com nível alto");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_jailed(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
	 		new bool:First2 = false, Count, adminname[MAX_PLAYER_NAME], string[128], i;
		    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Jailed]) Count++;
			if(Count == 0) return SendClientMessage(playerid,red, "Nenhum jogador preso");

		    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Jailed]) {
	    		GetPlayerName(i, adminname, sizeof(adminname));
				if(!First2) { format(string, sizeof(string), "Jogadores Presos: (%d)%s", i,adminname); First2 = true; }
		        else format(string,sizeof(string),"%s, (%d)%s ",string,i,adminname);
	        }
		    return SendClientMessage(playerid,COLOR_WHITE,string);
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_freeze(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 3) {
		    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /freeze [playerid] [minutos] [motivo]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][Frozen] == 0) {
					GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
					new ftime = strval(tmp2);
					if(ftime == 0) ftime = 9999;

			       	CMDMessageToAdmins(playerid,"FREEZE");
					TogglePlayerControllable(player1,false); PlayerInfo[player1][Frozen] = 1; PlayerPlaySound(player1,1057,0.0,0.0,0.0);
					PlayerInfo[player1][FreezeTime] = ftime*1000*60;
			        FreezeTimer[player1] = SetTimerEx("UnFreezeMe",PlayerInfo[player1][FreezeTime],0,"d",player1);

					if(ftime == 9999) {
						if(!strlen(params[strlen(tmp2)+1])) format(string,sizeof(string),"Administrador %s congelou %s ",adminname, playername);
						else format(string,sizeof(string),"Administrador %s congelou %s [motivo: %s]",adminname, playername, params[strlen(tmp)+1] );
	   				} else {
						if(!strlen(tmp3)) format(string,sizeof(string),"Administrador %s congelou %s por %d minutos",adminname, playername, ftime);
						else format(string,sizeof(string),"Administrador %s congelou %s por %d minutos [motivo: %s]",adminname, playername, ftime, params[strlen(tmp2)+strlen(tmp)+1] );
					}
		    		return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Jogador já está congelado");
			} else return SendClientMessage(playerid, red, "Jogador não conectado ou é um admin com nível alto");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_unfreeze(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
	    if(PlayerInfo[playerid][Level] >= 3|| IsPlayerAdmin(playerid)) {
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /unfreeze [playerid]");
	    	new player1, string[128];
			player1 = strval(params);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		 	    if(PlayerInfo[player1][Frozen] == 1) {
			       	CMDMessageToAdmins(playerid,"UNFREEZE");
					UnFreezeMe(player1);
					format(string,sizeof(string),"Administrador %s descongelou você", PlayerName2(playerid) ); SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"Administrator %s descongelou %s", PlayerName2(playerid), PlayerName2(player1));
		    		return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Jogador não está congelado");
			} else return SendClientMessage(playerid, red, "Jogador não conectado ou é um admin com nível alto");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_frozen(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
	 		new bool:First2 = false, Count, adminname[MAX_PLAYER_NAME], string[128], i;
		    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Frozen]) Count++;
			if(Count == 0) return SendClientMessage(playerid,red, "Nenhum jogador congelado");
			
		    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Frozen]) {
	    		GetPlayerName(i, adminname, sizeof(adminname));
				if(!First2) { format(string, sizeof(string), "Jogadores Congelados: (%d)%s", i,adminname); First2 = true; }
		        else format(string,sizeof(string),"%s, (%d)%s ",string,i,adminname);
	        }
		    return SendClientMessage(playerid,COLOR_WHITE,string);
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_mute(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /mute [playerid] [motivo]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
		 	    if(PlayerInfo[player1][Muted] == 0) {
					GetPlayerName(player1, playername, sizeof(playername)); 	GetPlayerName(playerid, adminname, sizeof(adminname));
					CMDMessageToAdmins(playerid,"MUTE");
					PlayerPlaySound(player1,1057,0.0,0.0,0.0);  PlayerInfo[player1][Muted] = 1; PlayerInfo[player1][MuteWarnings] = 0;

					if(strlen(tmp2)) {
						format(string,sizeof(string),"Você foi calado pelo Administrador %s [motivo: %s]",adminname,params[2]); SendClientMessage(player1,blue,string);
						format(string,sizeof(string),"Você calou %s [motivo: %s]", playername,params[2]); return SendClientMessage(playerid,blue,string);
					} else {
						format(string,sizeof(string),"Você foi calado pelo Administrador %s",adminname); SendClientMessage(player1,blue,string);
						format(string,sizeof(string),"Você calou %s", playername); return SendClientMessage(playerid,blue,string); }
				} else return SendClientMessage(playerid, red, "Jogador já está calado");
			} else return SendClientMessage(playerid, red, "Jogador não conectado ou é um admin com nível alto");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_unmute(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /unmute [playerid]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(params);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
		 	    if(PlayerInfo[player1][Muted] == 1) {
					GetPlayerName(player1, playername, sizeof(playername)); 	GetPlayerName(playerid, adminname, sizeof(adminname));
					CMDMessageToAdmins(playerid,"UNMUTE");
					PlayerPlaySound(player1,1057,0.0,0.0,0.0);  PlayerInfo[player1][Muted] = 0; PlayerInfo[player1][MuteWarnings] = 0;
					format(string,sizeof(string),"Você foi desmutado pelo Administrador %s",adminname); SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"Você desmutou %s", playername); return SendClientMessage(playerid,blue,string);
				} else return SendClientMessage(playerid, red, "Jogador não está calado");
			} else return SendClientMessage(playerid, red, "Jogador não conectado ou é um admin com nível alto");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================//==============================================================================
dcmd_muted(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
	 		new bool:First2 = false, Count, adminname[MAX_PLAYER_NAME], string[128], i;
		    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Muted]) Count++;
			if(Count == 0) return SendClientMessage(playerid,red, "Nenhum jogador calado");

		    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Muted]) {
	    		GetPlayerName(i, adminname, sizeof(adminname));
				if(!First2) { format(string, sizeof(string), "Jogadores Calados: (%d)%s", i,adminname); First2 = true; }
		        else format(string,sizeof(string),"%s, (%d)%s ",string,i,adminname);
	        }
		    return SendClientMessage(playerid,COLOR_WHITE,string);
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_akill(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
	    if(PlayerInfo[playerid][Level] >= 3|| IsPlayerAdmin(playerid)) {
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /akill [playerid]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(params);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if( (PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel] ) )
					return SendClientMessage(playerid, red, "Você não pode matar um admin com nível alto");
				CMDMessageToAdmins(playerid,"AKILL");
				GetPlayerName(player1, playername, sizeof(playername));	GetPlayerName(playerid, adminname, sizeof(adminname));
				format(string,sizeof(string),"Administrador %s matou você",adminname);	SendClientMessage(player1,blue,string);
				format(string,sizeof(string),"Você matou %s",playername); SendClientMessage(playerid,blue,string);
				return SetPlayerHealth(player1,0.0);
			} else return SendClientMessage(playerid, red, "Jogador não conectado");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_weaps(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /weaps [playerid]");
    	new player1, string[128], string2[64], WeapName[24], slot, weap, ammo, Count, x;
		player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			format(string2,sizeof(string2),"[>> Armas %s (id:%d) <<]", PlayerName2(player1), player1); SendClientMessage(playerid,blue,string2);
			for (slot = 0; slot < 14; slot++) {	GetPlayerWeaponData(player1, slot, weap, ammo); if( ammo != 0 && weap != 0) Count++; }
			if(Count < 1) return SendClientMessage(playerid,blue,"Jogador não tem armas");

			if(Count >= 1)
			{
				for (slot = 0; slot < 14; slot++)
				{
					GetPlayerWeaponData(player1, slot, weap, ammo);
					if( ammo != 0 && weap != 0)
					{
						GetWeaponName(weap, WeapName, sizeof(WeapName) );
						if(ammo == 65535 || ammo == 1) format(string,sizeof(string),"%s%s (1)",string, WeapName );
						else format(string,sizeof(string),"%s%s (%d)",string, WeapName, ammo );
						x++;
						if(x >= 5)
						{
						    SendClientMessage(playerid, blue, string);
						    x = 0;
							format(string, sizeof(string), "");
						}
						else format(string, sizeof(string), "%s,  ", string);
					}
			    }
				if(x <= 4 && x > 0) {
					string[strlen(string)-3] = '.';
				    SendClientMessage(playerid, blue, string);
				}
		    }
		    return 1;
		} else return SendClientMessage(playerid, red, "Jogador não conectado");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_aka(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /aka [playerid]");
    	new player1, playername[MAX_PLAYER_NAME], str[128], tmp3[50];
		player1 = strval(params);
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
  		  	GetPlayerIp(player1,tmp3,50);
			GetPlayerName(player1, playername, sizeof(playername));
		    format(str,sizeof(str),"AKA: [%s id:%d] [%s] %s", playername, player1, tmp3, dini_Get("ladmin/config/aka.txt",tmp3) );
	        return SendClientMessage(playerid,blue,str);
		} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado ou é você mesmo!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_screen(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /screen [playerid] [texto]");
    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
		player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
			GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
			CMDMessageToAdmins(playerid,"SCREEN");
			format(string,sizeof(string),"Administrador %s mandou a você uma mensagem de tela",adminname);	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"Você enviou a %s uma mensagem de tela (%s)", playername, params[2]); SendClientMessage(playerid,blue,string);
			return GameTextForPlayer(player1, params[2],4000,3);
		} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado ou é você mesmo! ou é um admin com nível alto");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_laston(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2) {
    	new tmp2[256], file[256],player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], str[128];
		GetPlayerName(playerid, adminname, sizeof(adminname));

	    if(!strlen(params)) {
			format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(adminname));
			if(!fexist(file)) return SendClientMessage(playerid, red, "Erro: Arquivo não existe, jogador não registrado");
			if(dUserINT(PlayerName2(playerid)).("LastOn")==0) {	format(str, sizeof(str),"Nunca"); tmp2 = str;
			} else { tmp2 = dini_Get(file,"LastOn"); }
			format(str, sizeof(str),"Você esteve pela última vez no servidor em %s",tmp2);
			return SendClientMessage(playerid, red, str);
		}
		player1 = strval(params);
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"LASTON");
   	    	GetPlayerName(player1,playername,sizeof(playername)); format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(playername));
			if(!fexist(file)) return SendClientMessage(playerid, red, "Erro: Arquivo não existe, jogador não registrado");
			if(dUserINT(PlayerName2(player1)).("LastOn")==0) { format(str, sizeof(str),"Nunca"); tmp2 = str;
			} else { tmp2 = dini_Get(file,"LastOn"); }
			format(str, sizeof(str),"%s esteve pela última vez no servidor em %s",playername,tmp2);
			return SendClientMessage(playerid, red, str);
		} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado ou é você mesmo!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_admins(playerid,params[]) {
    #pragma unused params
	new Count[2], i, string[128];
	for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i))
	{
		if(PlayerInfo[i][Level] > 0) Count[0]++;
		if(IsPlayerAdmin(i)) Count[1]++;
	}

    #if defined HIDE_ADMINS
	if(PlayerInfo[playerid][Level] == 0) {
		if(Count[0] >= 1) {
			format(string, sizeof(string), "Existem %d Administradores Online. Use /report <id> <motivo> se você suspeita que alguém esteja usando cheat", Count[0]);
			return SendClientMessage(playerid, blue, string);
		} else return SendClientMessage(playerid, blue, "Nenhum Administrador online, apenas nosso ADM-BOT ( Hexa-ADM )!");
	}
	#endif

	if( (Count[0] == 0 && Count[1] == 0) || (Count[0] == 0 && Count[1] >= 1 && PlayerInfo[playerid][Level] == 0) ) return SendClientMessage(playerid, blue, "Nenhum Administrador online, apenas nosso ADM-BOT ( Hexa-ADM )!");

	if(Count[0] == 1) {
	    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Level] > 0) {
			format(string, sizeof(string), "Admins: %s [%d]", i, PlayerName2(i), PlayerInfo[i][Level] ); SendClientMessage(playerid, blue, string);
		}
	}

 	if(Count[0] > 1) {
	    new x; format(string, sizeof(string), "Admins: ");
	    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Level] > 0)
		{
			format(string,sizeof(string),"%s(%d)%s [%d]",string,i,PlayerName2(i),PlayerInfo[i][Level]);
			x++;
			if(x >= 5) {
			    SendClientMessage(playerid, blue, string); format(string, sizeof(string), "Admins: (Dono) "); x = 0;
			}
			else format(string, sizeof(string), "%s (DONO),  ", string);
	    }
		if(x <= 4 && x > 0) {
			string[strlen(string)-3] = '.';
		    SendClientMessage(playerid, blue, string);
		}
	}

	if( (Count[1] == 1) && (PlayerInfo[playerid][Level] > 0) ) {
	    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerAdmin(i)) {
			format(string, sizeof(string), "Rcon Admin: (%d)%s", i, PlayerName2(i)); SendClientMessage(playerid, COLOR_WHITE, string);
		}
	}
	if(Count[1] > 1) {
 		new x; format(string, sizeof(string), "RCON Admins: ");
	    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerAdmin(i))
		{
			format(string,sizeof(string),"%s(%d)%s",string,i,PlayerName2(i));
			x++;
			if(x >= 5) {
				SendClientMessage(playerid, COLOR_WHITE, string); format(string, sizeof(string), "Rcon Admins: "); x = 0;
			}
			else format(string, sizeof(string), "%s,  ", string);
	    }
		if(x <= 4 && x > 0) {
			string[strlen(string)-3] = '.';
		    SendClientMessage(playerid, COLOR_WHITE, string);
		}
	}
	return 1;
}
//==============================================================================
dcmd_morning(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
        CMDMessageToAdmins(playerid,"MORNING");
        return SetPlayerTime(playerid,7,0);
    } else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Normal para usar este comando!");
}
//==============================================================================
dcmd_adminarea(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
        CMDMessageToAdmins(playerid,"ADMINAREA");
	    SetPlayerPos(playerid, AdminArea[0], AdminArea[1], AdminArea[2]);
	    SetPlayerFacingAngle(playerid, AdminArea[3]);
	    SetPlayerInterior(playerid, AdminArea[4]);
		SetPlayerVirtualWorld(playerid, AdminArea[5]);
		return GameTextForPlayer(playerid,"Bem Vindo Admin",1000,3);
	} else {
	   	SetPlayerHealth(playerid,1.0);
   		new string[100]; format(string, sizeof(string),"%s usou o adminarea (não é admin)", PlayerName2(playerid) );
	   	MessageToAdmins(red,string);
	} return SendClientMessage(playerid,red, "ERRO: Você deve ser um administrador para usar este comando.");
}
//==============================================================================
dcmd_setlevel(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "[ERRO] Use: /setlevel [playerid] [nível]");
	    	new player1, level, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);
			if(!strlen(tmp2)) return SendClientMessage(playerid, red, "[ERRO] Use: /setlevel [playerid] [nível]");
			level = strval(tmp2);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][LoggedIn] == 1) {
					if(level > ServerInfo[MaxAdminLevel] ) return SendClientMessage(playerid,red,"[ERRO]: Nível Incorreto");
					if(level == PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"[ERRO]: Jogador já possui este nível");
	       			CMDMessageToAdmins(playerid,"SETLEVEL");
					GetPlayerName(player1, playername, sizeof(playername));	GetPlayerName(playerid, adminname, sizeof(adminname));
			       	new year,month,day;   getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);

					if(level > 0) format(string,sizeof(string),"[AVISO]: Administrador %s definiu você para Status de Administrador [nível %d]",adminname, level);
					else format(string,sizeof(string),"[AVISO]: Administrador %s definiu você para Status de Player [nível %d]",adminname, level);
					SendClientMessage(player1,blue,string);

					if(level > PlayerInfo[player1][Level]) GameTextForPlayer(player1,"~l~Promovido", 2000, 3);
					else GameTextForPlayer(player1,"~r~Rebaixado", 2000, 3);

					format(string,sizeof(string),"[AVISO] Você deu ADM para %s Nível %d em %d/%d/%d às %d:%d:%d", playername, level, day, month, year, hour, minute, second); SendClientMessage(playerid,blue,string);
					format(string,sizeof(string),"[AVISO] O administrador %s deu %s de Nível para %d em %d/%d/%d às %d:%d:%d",adminname, playername, level, day, month, year, hour, minute, second);
					SaveToFile("AdminLog",string);
					dUserSetINT(PlayerName2(player1)).("level",(level));
					PlayerInfo[player1][Level] = level;
					return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
				} else return SendClientMessage(playerid,red,"[ERRO]: O jogador deve estar registado e logado para ser admin!");
			} else return SendClientMessage(playerid, red, "[ERRO]: Jogador não conectado");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_settemplevel(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "[ERRO]: Use /settemplevel [playerid] [nível]");
	    	new player1, level, string[128];
			player1 = strval(tmp);
			level = strval(tmp2);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][LoggedIn] == 1) {
					if(level > ServerInfo[MaxAdminLevel] ) return SendClientMessage(playerid,red,"ERRO: Nível Incorreto");
					if(level == PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERRO: Jogador já possui este nível");
	       			CMDMessageToAdmins(playerid,"SETTEMPLEVEL");
			       	new year,month,day; getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);

					if(level > 0) format(string,sizeof(string),"Administrador %s definiu temporariamente você para Status de Administrador [nível %d]", pName(playerid), level);
					else format(string,sizeof(string),"Administrador %s definiu temporariamente você para Status de Player [nível %d]", pName(playerid), level);
					SendClientMessage(player1,blue,string);

					if(level > PlayerInfo[player1][Level]) GameTextForPlayer(player1,"~p~Promovido", 2000, 3);
					else GameTextForPlayer(player1,"Rebaixado", 2000, 3);

					format(string,sizeof(string),"[AVISO]: Você colocou %s para Nível %d em %d/%d/%d às %d:%d:%d", pName(player1), level, day, month, year, hour, minute, second); SendClientMessage(playerid,blue,string);
					format(string,sizeof(string),"Administrador %s colocou %s para Nível temp. %d em %d/%d/%d às %d:%d:%d",pName(playerid), pName(player1), level, day, month, year, hour, minute, second);
					SaveToFile("TempAdminLog",string);
					PlayerInfo[player1][Level] = level;
					return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
				} else return SendClientMessage(playerid,red,"ERRO: O jogador deve estar registado e logado para ser admin");
			} else return SendClientMessage(playerid, red, "Jogador não conectado");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve estar logado para usar este comando");
}
//==============================================================================
dcmd_report(playerid,params[]) {
    new reported, tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /report [playerid] [motivo]");
	reported = strval(tmp);

 	if(IsPlayerConnected(reported) && reported != INVALID_PLAYER_ID) {
		if(PlayerInfo[reported][Level] == ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode relatar este administrador");
		if(playerid == reported) return SendClientMessage(playerid,red,"ERRO: Você não pode relatar você mesmo");
		if(strlen(params) > 7) {
			new reportedname[MAX_PLAYER_NAME], reporter[MAX_PLAYER_NAME], str[128], hour,minute,second; gettime(hour,minute,second);
			GetPlayerName(reported, reportedname, sizeof(reportedname));	GetPlayerName(playerid, reporter, sizeof(reporter));
			format(str, sizeof(str), "||Novo Relato||  %s(%d) relatou %s(%d) Motivo: %s |@%d:%d:%d|", reporter,playerid, reportedname, reported, params[strlen(tmp)+1], hour,minute,second);
			MessageToAdmins(COLOR_WHITE,str);
			SaveToFile("ReportLog",str);
			format(str, sizeof(str), "Relato(%d:%d:%d): %s(%d) relatou %s(%d) Motivo: %s", hour,minute,second, reporter,playerid, reportedname, reported, params[strlen(tmp)+1]);
			for(new i = 1; i < MAX_REPORTS-1; i++) Reports[i] = Reports[i+1];
			Reports[MAX_REPORTS-1] = str;
			return SendClientMessage(playerid,yellow, "O seu relato foi enviado para os administradores online");
		} else return SendClientMessage(playerid,red,"ERRO: Deve ter uma razão válida");
	} else return SendClientMessage(playerid, red, "Jogador não está conectado");
}

dcmd_reports(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
        new ReportCount;
		for(new i = 1; i < MAX_REPORTS; i++)
		{
			if(strcmp( Reports[i], "<none>", true) != 0) { ReportCount++; SendClientMessage(playerid,COLOR_WHITE,Reports[i]); }
		}
		if(ReportCount == 0) SendClientMessage(playerid,COLOR_WHITE,"Não houve relatórios");
    } else SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Normal para usar este comando!");
	return 1;
}

dcmd_richlist(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
 		new string[128], Slot1 = -1, Slot2 = -1, Slot3 = -1, Slot4 = -1, HighestCash = -9999;
 		SendClientMessage(playerid,COLOR_WHITE,"Lista de Ricos:");

		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x)) if (GetPlayerMoney(x) >= HighestCash) {
			HighestCash = GetPlayerMoney(x);
			Slot1 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1) if (GetPlayerMoney(x) >= HighestCash) {
			HighestCash = GetPlayerMoney(x);
			Slot2 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1 && x != Slot2) if (GetPlayerMoney(x) >= HighestCash) {
			HighestCash = GetPlayerMoney(x);
			Slot3 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1 && x != Slot2 && x != Slot3) if (GetPlayerMoney(x) >= HighestCash) {
			HighestCash = GetPlayerMoney(x);
			Slot4 = x;
		}
		format(string, sizeof(string), "(%d) %s - $%d", Slot1,PlayerName2(Slot1),GetPlayerMoney(Slot1) );
		SendClientMessage(playerid,COLOR_WHITE,string);
		if(Slot2 != -1)	{
			format(string, sizeof(string), "(%d) %s - $%d", Slot2,PlayerName2(Slot2),GetPlayerMoney(Slot2) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		if(Slot3 != -1)	{
			format(string, sizeof(string), "(%d) %s - $%d", Slot3,PlayerName2(Slot3),GetPlayerMoney(Slot3) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		if(Slot4 != -1)	{
			format(string, sizeof(string), "(%d) %s - $%d", Slot4,PlayerName2(Slot4),GetPlayerMoney(Slot4) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		return 1;
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_miniguns(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
		new bool:First2 = false, Count, string[128], i, slot, weap, ammo;
		for(i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				for(slot = 0; slot < 14; slot++) {
					GetPlayerWeaponData(i, slot, weap, ammo);
					if(ammo != 0 && weap == 38) {
					    Count++;
						if(!First2) { format(string, sizeof(string), "Minigun: (%d)%s(munição%d)", i, PlayerName2(i), ammo); First2 = true; }
				        else format(string,sizeof(string),"%s, (%d)%s(munição%d) ",string, i, PlayerName2(i), ammo);
					}
				}
    	    }
		}
		if(Count == 0) return SendClientMessage(playerid,COLOR_WHITE,"Nenhum jogador tem uma minigun"); else return SendClientMessage(playerid,COLOR_WHITE,string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_uconfig(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4)
	{
		UpdateConfig();
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return CMDMessageToAdmins(playerid,"UCONFIG");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_botcheck(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		for(new i=0; i<MAX_PLAYERS; i++) BotCheck(i);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return CMDMessageToAdmins(playerid,"BOTCHECK");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_lockserver(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /lockserver [senha]");
    	new adminname[MAX_PLAYER_NAME], string[128];
		ServerInfo[Locked] = 1;
		strmid(ServerInfo[Password], params[0], 0, strlen(params[0]), 128);
		GetPlayerName(playerid, adminname, sizeof(adminname));
		format(string, sizeof(string), "Administrador \"%s\" bloqueou o server",adminname);
  		SendClientMessageToAll(red,"________________________________________");
  		SendClientMessageToAll(red," ");
		SendClientMessageToAll(red,string);
		SendClientMessageToAll(red,"________________________________________");
		for(new i = 0; i <= MAX_PLAYERS; i++) if(IsPlayerConnected(i)) { PlayerPlaySound(i,1057,0.0,0.0,0.0); PlayerInfo[i][AllowedIn] = true; }
		CMDMessageToAdmins(playerid,"LOCKSERVER");
		format(string, sizeof(string), "Administrador \"%s\" definiu a senha do server para '%s'",adminname, ServerInfo[Password] );
		return MessageToAdmins(COLOR_WHITE, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_unlockserver(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
	    if(ServerInfo[Locked] == 1) {
	    	new adminname[MAX_PLAYER_NAME], string[128];
			ServerInfo[Locked] = 0;
			strmid(ServerInfo[Password], "", 0, strlen(""), 128);
			GetPlayerName(playerid, adminname, sizeof(adminname));
			format(string, sizeof(string), "Administrador \"%s\" desbloqueou o server",adminname);
  			SendClientMessageToAll(green,"________________________________________");
	  		SendClientMessageToAll(green," ");
			SendClientMessageToAll(green,string);
			SendClientMessageToAll(green,"________________________________________");
			for(new i = 0; i <= MAX_PLAYERS; i++) if(IsPlayerConnected(i)) { PlayerPlaySound(i,1057,0.0,0.0,0.0); PlayerInfo[i][AllowedIn] = true; }
			return CMDMessageToAdmins(playerid,"UNLOCKSERVER");
		} else return SendClientMessage(playerid,red,"ERRO: Server não está bloqueado");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_senha(playerid,params[]) {
	if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /senha [senha]");
	if(ServerInfo[Locked] == 1) {
	    if(PlayerInfo[playerid][AllowedIn] == false) {
			if(!strcmp(ServerInfo[Password],params[0],true)) {
				KillTimer( LockKickTimer[playerid] );
				PlayerInfo[playerid][AllowedIn] = true;
				new string[128];
				SendClientMessage(playerid,COLOR_WHITE,"Você entrou com sucesso a senha do server e agora pode entrar");
				format(string, sizeof(string), "%s entrou com sucesso a senha do server",PlayerName2(playerid));
				return MessageToAdmins(COLOR_WHITE, string);
			} else return SendClientMessage(playerid,red,"ERRO: Senha do server incorreta");
		} else return SendClientMessage(playerid,red,"ERRO: Você já está logado");
	} else return SendClientMessage(playerid,red,"ERRO: Server não está bloqueado");
}
//==============================================================================
dcmd_forbidname(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /forbidname [nome]");
		new File:BLfile, string[128];
		BLfile = fopen("ladmin/config/ForbiddenNames.cfg",io_append);
		format(string,sizeof(string),"%s\r\n",params[1]);
		fwrite(BLfile,string);
		fclose(BLfile);
		UpdateConfig();
		CMDMessageToAdmins(playerid,"FORBIDNAME");
		format(string, sizeof(string), "Administrador \"%s\" adicionou o nome \"%s\" para a lista de nomes proibidos", pName(playerid), params );
		return MessageToAdmins(green,string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_forbidword(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /forbidword [palavra]");
		new File:BLfile, string[128];
		BLfile = fopen("ladmin/config/ForbiddenWords.cfg",io_append);
		format(string,sizeof(string),"%s\r\n",params[1]);
		fwrite(BLfile,string);
		fclose(BLfile);
		UpdateConfig();
		CMDMessageToAdmins(playerid,"FORBIDWORD");
		format(string, sizeof(string), "Administrador \"%s\" adicionou a palavra \"%s\" para a lista de palavras proibidas", pName(playerid), params );
		return MessageToAdmins(green,string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
#if defined ENABLE_SPEC
//==============================================================================
dcmd_spec(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params) || !IsNumeric(params)) return SendClientMessage(playerid, red, "USO: /spec [playerid]");
		new specplayerid = strval(params);
		if(PlayerInfo[specplayerid][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(specplayerid) && specplayerid != INVALID_PLAYER_ID) {
			if(specplayerid == playerid) return SendClientMessage(playerid, red, "ERRO: Você não pode espiar você mesmo");
			if(GetPlayerState(specplayerid) == PLAYER_STATE_SPECTATING && PlayerInfo[specplayerid][SpecID] != INVALID_PLAYER_ID) return SendClientMessage(playerid, red, "Espiar: Jogador espiando alguém");
			if(GetPlayerState(specplayerid) != 1 && GetPlayerState(specplayerid) != 2 && GetPlayerState(specplayerid) != 3) return SendClientMessage(playerid, red, "Espiar: Jogador ainda não nasceu");
			if( (PlayerInfo[specplayerid][Level] != ServerInfo[MaxAdminLevel]) || (PlayerInfo[specplayerid][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] == ServerInfo[MaxAdminLevel]) )	{
				StartSpectate(playerid, specplayerid);
				CMDMessageToAdmins(playerid,"SPEC");
				GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
				GetPlayerFacingAngle(playerid,Pos[playerid][3]);
				return SendClientMessage(playerid,blue,"Agora Espiando");
			} else return SendClientMessage(playerid,red,"ERRO: Você não pode espiar um admin com nível alto");
		} else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Super para usar este comando");
}
//==============================================================================
dcmd_specvehicle(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /specvehicle [vehicleid]");
		new specvehicleid = strval(params);
		if(specvehicleid < MAX_VEHICLES) {
			TogglePlayerSpectating(playerid, 1);
			PlayerSpectateVehicle(playerid, specvehicleid);
			PlayerInfo[playerid][SpecID] = specvehicleid;
			PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
			CMDMessageToAdmins(playerid,"SPEC VEHICLE");
			GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
			GetPlayerFacingAngle(playerid,Pos[playerid][3]);
			return SendClientMessage(playerid,blue,"Agora Espiando");
		} else return SendClientMessage(playerid,red, "ERRO: ID de Veículo Inválida");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Super para usar este comando");
}
//==============================================================================
dcmd_specoff(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
        if(PlayerInfo[playerid][SpecType] != ADMIN_SPEC_TYPE_NONE) {
			StopSpectate(playerid);
			SetTimerEx("PosAfterSpec",3000,0,"d",playerid);
			return SendClientMessage(playerid,blue,"Não Espiando Mais");
		} else return SendClientMessage(playerid,red,"ERRO: Você não está espiando");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Super para usar este comando");
}
//==============================================================================
#endif
//==============================================================================
dcmd_disablechat(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		CMDMessageToAdmins(playerid,"DISABLECHAT");
		new string[128];
		if(ServerInfo[DisableChat] == 0) {
			ServerInfo[DisableChat] = 1;
			format(string,sizeof(string),"Administrador \"%s\" desligou o chat", pName(playerid) );
		} else {
			ServerInfo[DisableChat] = 0;
			format(string,sizeof(string),"Administrador \"%s\" ligou o chat", pName(playerid) );
		} return SendClientMessageToAll(blue,string);
 	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Hiper para usar este comando");
}
//==============================================================================
dcmd_cc(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		CMDMessageToAdmins(playerid,"CLEARCHAT");
		for(new i = 0; i < 11; i++) SendClientMessageToAll(green," "); return 1;
 	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Super para usar este comando");
}
//==============================================================================
dcmd_clearallchat(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		CMDMessageToAdmins(playerid,"CLEARALLCHAT");
		for(new i = 0; i < 50; i++) SendClientMessageToAll(green," "); return 1;
 	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_caps(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USO: /caps [playerid] [\"on\" / \"off\"]");
		new player1 = strval(tmp), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERRO: Você não pode usar este comando neste admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(strcmp(tmp2,"on",true) == 0)	{
				CMDMessageToAdmins(playerid,"CAPS");
				PlayerInfo[player1][Caps] = 0;
				if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" permitiu a você o uso de letras maíusculas no chat", pName(playerid) ); SendClientMessage(playerid,blue,string); }
				format(string,sizeof(string),"Você autorizou \"%s\" para usar maiúsculas no chat", pName(player1) ); return SendClientMessage(playerid,blue,string);
			} else if(strcmp(tmp2,"off",true) == 0)	{
				CMDMessageToAdmins(playerid,"CAPS");
				PlayerInfo[player1][Caps] = 1;
				if(player1 != playerid) { format(string,sizeof(string),"Administrador \"%s\" proibiu você de usar letras maíusculas no chat", pName(playerid) ); SendClientMessage(playerid,blue,string); }
				format(string,sizeof(string),"Você proibiu \"%s\" de usar maiúsculas no chat", pName(player1) ); return SendClientMessage(playerid,blue,string);
			} else return SendClientMessage(playerid, red, "USO: /caps [playerid] [\"on\" / \"off\"]");
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_pickup(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USAGE: /pickup [pickup id]");
	    new pickup = strval(params), string[128], Float:x, Float:y, Float:z, Float:a;
	    CMDMessageToAdmins(playerid,"PICKUP");
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		x += (3 * floatsin(-a, degrees));
		y += (3 * floatcos(-a, degrees));
		CreatePickup(pickup, 2, x+2, y, z);
		format(string, sizeof(string), "CreatePickup(%d, 2, %0.2f, %0.2f, %0.2f);", pickup, x+2, y, z);
       	SaveToFile("Pickups",string);
		return SendClientMessage(playerid,yellow, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_object(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USAGE: /object [object id]");
	    new object = strval(params), string[128], Float:x, Float:y, Float:z, Float:a;
	    CMDMessageToAdmins(playerid,"OBJECT");
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		x += (3 * floatsin(-a, degrees));
		y += (3 * floatcos(-a, degrees));
		CreateObject(object, x, y, z, 0.0, 0.0, a);
		format(string, sizeof(string), "CreateObject(%d, %0.2f, %0.2f, %0.2f, 0.00, 0.00, %0.2f);", object, x, y, z, a);
       	SaveToFile("Objects",string);
		format(string, sizeof(string), "You Have Created Object %d, at %0.2f, %0.2f, %0.2f Angle %0.2f", object, x, y, z, a);
		return SendClientMessage(playerid,yellow, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_move(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /move [up / down / +x / -x / +y / -y / off]");
		new Float:X, Float:Y, Float:Z;
		if(strcmp(params,"up",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y,Z+5); SetCameraBehindPlayer(playerid); }
		else if(strcmp(params,"down",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y,Z-5); SetCameraBehindPlayer(playerid); }
		else if(strcmp(params,"+x",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X+5,Y,Z);	}
		else if(strcmp(params,"-x",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X-5,Y,Z); }
		else if(strcmp(params,"+y",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y+5,Z);	}
		else if(strcmp(params,"-y",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y-5,Z);	}
	    else if(strcmp(params,"off",true) == 0)	{
			TogglePlayerControllable(playerid,true);	}
		else return SendClientMessage(playerid,red,"USAGE: /move [up / down / +x / -x / +y / -y / off]");
		return 1;
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_moveplayer(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp)) return SendClientMessage(playerid, red, "USAGE: /moveplayer [playerid] [up / down / +x / -x / +y / -y / off]");
	    new Float:X, Float:Y, Float:Z, player1 = strval(tmp);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(strcmp(tmp2,"up",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y,Z+5); SetCameraBehindPlayer(player1);	}
			else if(strcmp(tmp2,"down",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y,Z-5); SetCameraBehindPlayer(player1);	}
			else if(strcmp(tmp2,"+x",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X+5,Y,Z);	}
			else if(strcmp(tmp2,"-x",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X-5,Y,Z); }
			else if(strcmp(tmp2,"+y",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y+5,Z);	}
			else if(strcmp(tmp2,"-y",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y-5,Z);	}
			else SendClientMessage(playerid,red,"USAGE: /moveplayer [up / down / +x / -x / +y / -y / off]");
			return 1;
		} else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
#if defined ENABLE_FAKE_CMDS
//==============================================================================
dcmd_fakedeath(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 4) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !strlen(tmp3)) return SendClientMessage(playerid, red, "USAGE: /fakedeath [killer] [killee] [weapon]");
		new killer = strval(tmp), killee = strval(tmp2), weap = strval(tmp3);
		if(!IsValidWeapon(weap)) return SendClientMessage(playerid,red,"ERROR: Invalid Weapon ID");
		if(PlayerInfo[killer][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
		if(PlayerInfo[killee][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");

        if(IsPlayerConnected(killer) && killer != INVALID_PLAYER_ID) {
	        if(IsPlayerConnected(killee) && killee != INVALID_PLAYER_ID) {
	    	  	CMDMessageToAdmins(playerid,"FAKEDEATH");
				SendDeathMessage(killer,killee,weap);
				return SendClientMessage(playerid,blue,"[AVISO]: Menssagem de Morte Fake Enviada!");
		    } else return SendClientMessage(playerid,red,"[ERRO]: Vítima não conectada!");
	    } else return SendClientMessage(playerid,red,"[ERRO]: Assassino não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_fakechat(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "[ERRO]: Use /fakechat [playerid] [text]");
		new player1 = strval(tmp);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
	        CMDMessageToAdmins(playerid,"FAKECHAT");
			SendPlayerMessageToAll(player1, params[strlen(tmp)+1]);
			return SendClientMessage(playerid,blue,"[AVISO] Fake menssagem enviada!");
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_fakecmd(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "[ERRO]: Use /fakecmd [playerid] [comando]");
		new player1 = strval(tmp);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
	        CMDMessageToAdmins(playerid,"FAKECMD");
	        CallRemoteFunction("OnPlayerCommandText", "is", player1, tmp2);
			return SendClientMessage(playerid,blue,"[AVISO]: Fake comando enviado!");
	    } else return SendClientMessage(playerid,red,"[ERRO]: Jogador não conectado!");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
#endif
//==============================================================================
dcmd_spawnall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"SPAWNAll");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerPos(i, 0.0, 0.0, 0.0); SpawnPlayer(i);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has spawned all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_muteall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"MUTEALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); PlayerInfo[i][Muted] = 1; PlayerInfo[i][MuteWarnings] = 0;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has muted all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_unmuteall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"UNMUTEAll");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); PlayerInfo[i][Muted] = 0; PlayerInfo[i][MuteWarnings] = 0;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has unmuted all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_getall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"GETAll");
		new Float:x,Float:y,Float:z, interior = GetPlayerInterior(playerid);
    	GetPlayerPos(playerid,x,y,z);
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerPos(i,x+(playerid/4)+1,y+(playerid/4),z); SetPlayerInterior(i,interior);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has teleported all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_healall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		CMDMessageToAdmins(playerid,"HEALALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerHealth(i,100.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has healed all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Hiper para usar este comando");
}
//==============================================================================
dcmd_armourall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		CMDMessageToAdmins(playerid,"ARMOURALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerArmour(i,100.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has restored all players armour", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Hiper para usar este comando");
}
//==============================================================================
dcmd_killall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"KILLALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerHealth(i,0.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has killed all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_freezeall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"FREEZEALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); TogglePlayerControllable(playerid,false); PlayerInfo[i][Frozen] = 1;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has frozen all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_unfreezeall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"UNFREEZEALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); TogglePlayerControllable(playerid,true); PlayerInfo[i][Frozen] = 0;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has unfrozen all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_kickall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"KICKALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); Kick(i);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has kicked all players", pName(playerid) );
		SaveToFile("KickLog",string);
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_slapall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"SLAPALL");
		new Float:x, Float:y, Float:z;
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1190,0.0,0.0,0.0); GetPlayerPos(i,x,y,z);	SetPlayerPos(i,x,y,z+4);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has slapped all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_explodeall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"EXPLODEALL");
		new Float:x, Float:y, Float:z;
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1190,0.0,0.0,0.0); GetPlayerPos(i,x,y,z);	CreateExplosion(x, y , z, 7, 10.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has exploded all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_disarmall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"DISARMALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); ResetPlayerWeapons(i);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has disarmed all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_ejectall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
    	CMDMessageToAdmins(playerid,"EJECTALL");
        new Float:x, Float:y, Float:z;
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
			    if(IsPlayerInAnyVehicle(i)) {
					PlayerPlaySound(i,1057,0.0,0.0,0.0); GetPlayerPos(i,x,y,z); SetPlayerPos(i,x,y,z+3);
				}
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has ejected all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Master para usar este comando");
}
//==============================================================================
dcmd_setallskin(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setallskin [skinid]");
		new var = strval(params), string[128];
		if(!IsValidSkin(var)) return SendClientMessage(playerid, red, "ERROR: Invaild Skin ID");
       	CMDMessageToAdmins(playerid,"SETALLSKIN");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerSkin(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players skin to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setallwanted(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setallwanted [wanted level]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLWANTED");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerWantedLevel(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players wanted level to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setallweather(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setallweather [weather ID]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLWEATHER");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerWeather(i, var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players weather to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setalltime(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setalltime [hour]");
		new var = strval(params), string[128];
		if(var > 24) return SendClientMessage(playerid, red, "ERROR: Invalid hour");
       	CMDMessageToAdmins(playerid,"SETALLTIME");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerTime(i, var, 0);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players time to '%d:00'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setallworld(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setallworld [virtual world]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLWORLD");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerVirtualWorld(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players virtual worlds to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setallscore(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setallscore [score]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLSCORE");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerScore(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players scores to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_setallcash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setallcash [Amount]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLCASH");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				ResetPlayerMoney(i);
				GivePlayerMoney(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players cash to '$%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_giveallcash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /giveallcash [Amount]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"GIVEALLCASH");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				GivePlayerMoney(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has given all players '$%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
dcmd_giveallweapon(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index, ammo, weap, WeapName[32], string[128]; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) ) return SendClientMessage(playerid, red, "USAGE: /giveallweapon [weapon id/weapon name] [ammo]");
		if(!strlen(tmp2) || !IsNumeric(tmp2) || strval(tmp2) <= 0 || strval(tmp2) > 99999) ammo = 500;
		if(!IsNumeric(tmp)) weap = GetWeaponIDFromName(tmp); else weap = strval(tmp);
	  	if(!IsValidWeapon(weap)) return SendClientMessage(playerid,red,"ERROR: Invalid weapon ID");
      	CMDMessageToAdmins(playerid,"GIVEALLWEAPON");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				GivePlayerWeapon(i,weap,ammo);
			}
		}
		GetWeaponName(weap, WeapName, sizeof(WeapName) );
		format(string,sizeof(string),"Administrator \"%s\" has given all players a %s (%d) with %d rounds of ammo", pName(playerid), WeapName, weap, ammo);
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
#if defined USE_MENUS
//==============================================================================
#endif
//==============================================================================
dcmd_gotoplace(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1 && PlayerInfo[playerid][Level] >= 1)	{
	    if (dUserINT(PlayerName2(playerid)).("x")!=0) {
		    PutAtPos(playerid);
			SetPlayerVirtualWorld(playerid, (dUserINT(PlayerName2(playerid)).("world")) );
			return SendClientMessage(playerid,yellow,"You have successfully teleported to your saved place");
		} else return SendClientMessage(playerid,red,"ERROR: You must save a place before you can teleport to it");
	} else return SendClientMessage(playerid,red, "ERRO: Você deve ser um administrador para usar este comando");
}
//==============================================================================
dcmd_saveplace(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1 && PlayerInfo[playerid][Level] >= 1)	{
		new Float:x,Float:y,Float:z, interior;
		GetPlayerPos(playerid,x,y,z);	interior = GetPlayerInterior(playerid);
		dUserSetINT(PlayerName2(playerid)).("x",floatround(x));
		dUserSetINT(PlayerName2(playerid)).("y",floatround(y));
		dUserSetINT(PlayerName2(playerid)).("z",floatround(z));
		dUserSetINT(PlayerName2(playerid)).("interior",interior);
		dUserSetINT(PlayerName2(playerid)).("world", (GetPlayerVirtualWorld(playerid)) );
		return SendClientMessage(playerid,yellow,"You have successfully saved these coordinates");
	} else return SendClientMessage(playerid,red, "ERRO: Você deve ser um administrador para usar este comando");
}
//==============================================================================
dcmd_saveskin(playerid,params[]) {
 	if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn] == 1) {
		if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /saveskin [skinid]");
		new string[128], SkinID = strval(params);
		if((SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID <= 73)||(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 264)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299))
		{
 			dUserSetINT(PlayerName2(playerid)).("FavSkin",SkinID);
		 	format(string, sizeof(string), "You have successfully saved this skin (ID %d)",SkinID);
		 	SendClientMessage(playerid,yellow,string);
			SendClientMessage(playerid,yellow,"Type: /useskin to use this skin when you spawn or /dontuseskin to stop using skin");
			dUserSetINT(PlayerName2(playerid)).("UseSkin",1);
		 	return CMDMessageToAdmins(playerid,"SAVESKIN");
		} else return SendClientMessage(playerid, green, "ERROR: Invalid Skin ID");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve ser um administrador para usar este comando");
}
//==============================================================================
dcmd_useskin(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn] == 1) {
	    dUserSetINT(PlayerName2(playerid)).("UseSkin",1);
    	SetPlayerSkin(playerid,dUserINT(PlayerName2(playerid)).("FavSkin"));
		return SendClientMessage(playerid,yellow,"Skin now in use");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve ser um administrador para usar este comando");
}
//==============================================================================
dcmd_dontuseskin(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn] == 1) {
	    dUserSetINT(PlayerName2(playerid)).("UseSkin",0);
		return SendClientMessage(playerid,yellow,"Skin will no longer be used");
	} else return SendClientMessage(playerid,red,"ERRO: Você deve ser um administrador para usar este comando");
}
//==============================================================================
#if defined USE_AREGISTER
//==============================================================================
dcmd_adminregister(playerid,params[])
{
    if (PlayerInfo[playerid][LoggedIn] == 1) return SendClientMessage(playerid,red,"ACCOUNT: You are already registered and logged in.");
    if (udb_Exists(PlayerName2(playerid))) return SendClientMessage(playerid,red,"ACCOUNT: This account already exists, please use '/alogin [password]'.");
    if (strlen(params) == 0) return SendClientMessage(playerid,red,"ACCOUNT: Correct usage: '/aregister [password]'");
    if (strlen(params) < 4 || strlen(params) > 20) return SendClientMessage(playerid,red,"ACCOUNT: Password length must be greater than three characters");
    if (udb_Create(PlayerName2(playerid),params))
	{
    	new file[256],name[MAX_PLAYER_NAME], tmp3[100];
    	new strdate[20], year,month,day;	getdate(year, month, day);
		GetPlayerName(playerid,name,sizeof(name)); format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(name));
     	GetPlayerIp(playerid,tmp3,100);	dini_Set(file,"ip",tmp3);
	    dUserSetINT(PlayerName2(playerid)).("registered",1);
   		format(strdate, sizeof(strdate), "%d/%d/%d",day,month,year);
		dini_Set(file,"RegisteredDate",strdate);
		dUserSetINT(PlayerName2(playerid)).("loggedin",1);
		dUserSetINT(PlayerName2(playerid)).("banned",0);
		dUserSetINT(PlayerName2(playerid)).("level",0);
	    dUserSetINT(PlayerName2(playerid)).("LastOn",0);
    	dUserSetINT(PlayerName2(playerid)).("money",0);
    	dUserSetINT(PlayerName2(playerid)).("kills",0);
	   	dUserSetINT(PlayerName2(playerid)).("deaths",0);
	    PlayerInfo[playerid][LoggedIn] = 1;
	    PlayerInfo[playerid][Registered] = 1;
	    SendClientMessage(playerid, green, "ACCOUNT: You are now registered, and have been automaticaly logged in");
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return 1;
	}
    return 1;
}
//==============================================================================
dcmd_alogin(playerid,params[])
{
    if (PlayerInfo[playerid][LoggedIn] == 1) return SendClientMessage(playerid,red,"ACCOUNT: You are already logged in.");
    if (!udb_Exists(PlayerName2(playerid))) return SendClientMessage(playerid,red,"ACCOUNT: Account doesn't exist, please use '/aregister [password]'.");
    if (strlen(params)==0) return SendClientMessage(playerid,red,"ACCOUNT: Correct usage: '/alogin [password]'");
    if (udb_CheckLogin(PlayerName2(playerid),params))
	{
	   	new file[256], tmp3[100], string[128];
	   	format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(PlayerName2(playerid)) );
   		GetPlayerIp(playerid,tmp3,100);
	   	dini_Set(file,"ip",tmp3);
		LoginPlayer(playerid);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		if(PlayerInfo[playerid][Level] > 0) {
			format(string,sizeof(string),"ACCOUNT: Successfully Logged In. (Level %d)", PlayerInfo[playerid][Level] );
			return SendClientMessage(playerid,green,string);
       	} else return SendClientMessage(playerid,green,"ACCOUNT: Successfully Logged In");
	}
	else {
		PlayerInfo[playerid][FailLogin]++;
		printf("LOGIN: %s has failed to login, Wrong password (%s) Attempt (%d)", PlayerName2(playerid), params, PlayerInfo[playerid][FailLogin] );
		if(PlayerInfo[playerid][FailLogin] == MAX_FAIL_LOGINS)
		{
			new string[128]; format(string, sizeof(string), "%s has been kicked (Failed Logins)", PlayerName2(playerid) );
			SendClientMessageToAll(grey, string); print(string);
			Kick(playerid);
		}
		return SendClientMessage(playerid,red,"ACCOUNT: Login failed! Incorrect Password");
	}
}
//==============================================================================
dcmd_mudarsenha(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1)	{
		if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /achangepass [new password]");
		if(strlen(params) < 4) return SendClientMessage(playerid,red,"ACCOUNT: Incorrect password length");
		new string[128];
		dUserSetINT(PlayerName2(playerid)).("password_hash",udb_hash(params) );
		dUserSet(PlayerName2(playerid)).("Password",params);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
        format(string, sizeof(string),"ACCOUNT: You have successfully changed your password to [ %s ]",params);
		return SendClientMessage(playerid,yellow,string);
	} else return SendClientMessage(playerid,red, "ERROR: You must have an account to use this command");
}
//==============================================================================
dcmd_asetpass(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3) {
	    new string[128], tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USAGE: /asetpass [playername] [new password]");
		if(strlen(tmp2) < 4 || strlen(tmp2) > MAX_PLAYER_NAME) return SendClientMessage(playerid,red,"ERROR: Incorrect password length");
		if(udb_Exists(tmp)) {
			dUserSetINT(tmp).("password_hash", udb_hash(tmp2));
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
    	    format(string, sizeof(string),"ACCOUNT: You have successfully set \"%s's\" account password to \"%s\"", tmp, tmp2);
			return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red, "ERROR: This player doesnt have an account");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
#if defined USE_STATS
//==============================================================================
dcmd_aresetstats(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1)	{
	   	dUserSetINT(PlayerName2(playerid)).("oldkills",PlayerInfo[playerid][Kills]);
	   	dUserSetINT(PlayerName2(playerid)).("olddeaths",PlayerInfo[playerid][Deaths]);
		PlayerInfo[playerid][Kills] = 0;
		PlayerInfo[playerid][Deaths] = 0;
		dUserSetINT(PlayerName2(playerid)).("kills",PlayerInfo[playerid][Kills]);
	   	dUserSetINT(PlayerName2(playerid)).("deaths",PlayerInfo[playerid][Deaths]);
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return SendClientMessage(playerid,yellow,"ACCOUNT: You have successfully reset your stats. Your kills and deaths are: 0");
	} else return SendClientMessage(playerid,red, "ERROR: You must have an account to use this command");
}
//==============================================================================
dcmd_astats(playerid,params[]) {
	new string[128], pDeaths, player1, h, m, s;
	if(!strlen(params)) player1 = playerid;
	else player1 = strval(params);

	if(IsPlayerConnected(player1)) {
	    TotalGameTime(player1, h, m, s);
 		if(PlayerInfo[player1][Deaths] == 0) pDeaths = 1; else pDeaths = PlayerInfo[player1][Deaths];
 		format(string, sizeof(string), "| %s's Stats:  Kills: %d | Deaths: %d | Ratio: %0.2f | Money: $%d | Time: %d hrs %d mins %d secs |",PlayerName2(player1), PlayerInfo[player1][Kills], PlayerInfo[player1][Deaths], Float:PlayerInfo[player1][Kills]/Float:pDeaths,GetPlayerMoney(player1), h, m, s);
		return SendClientMessage(playerid, green, string);
	} else return SendClientMessage(playerid, red, "Jogador Não Conectado!");
}
//==============================================================================
#endif
//==============================================================================
#else
//==============================================================================
dcmd_adminregistrar(playerid,params[])
{
    if (PlayerInfo[playerid][LoggedIn] == 1) return SendClientMessage(playerid,red,"[ERRO]: Você já está registrado e logado.");
    if (udb_Exists(PlayerName2(playerid))) return SendClientMessage(playerid,red,"[ERRO]: Esta conta já existe, por favor use '/logar [senha]'.");
    if (strlen(params) == 0) return SendClientMessage(playerid,red,"[ERRO]: Uso correto: '/registrar [senha]'");
    if (strlen(params) < 4 || strlen(params) > 20) return SendClientMessage(playerid,red,"[ERRO]: O tamanho da senha deve ser maior que três caracteres!");
    if (udb_Create(PlayerName2(playerid),params))
	{
    	new file[256],name[MAX_PLAYER_NAME], tmp3[100];
    	new strdate[20], year,month,day;	getdate(year, month, day);
		GetPlayerName(playerid,name,sizeof(name)); format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(name));
     	GetPlayerIp(playerid,tmp3,100);	dini_Set(file,"ip",tmp3);
	    dUserSetINT(PlayerName2(playerid)).("registered",1);
   		format(strdate, sizeof(strdate), "%d/%d/%d",day,month,year);
		dini_Set(file,"RegisteredDate",strdate);
		dUserSetINT(PlayerName2(playerid)).("loggedin",1);
		dUserSetINT(PlayerName2(playerid)).("banned",0);
		dUserSetINT(PlayerName2(playerid)).("level",0);
	    dUserSetINT(PlayerName2(playerid)).("LastOn",0);
    	dUserSetINT(PlayerName2(playerid)).("money",0);
    	dUserSetINT(PlayerName2(playerid)).("kills",0);
	   	dUserSetINT(PlayerName2(playerid)).("deaths",0);
	   	dUserSetINT(PlayerName2(playerid)).("hours",0);
	   	dUserSetINT(PlayerName2(playerid)).("minutes",0);
	   	dUserSetINT(PlayerName2(playerid)).("seconds",0);
	    PlayerInfo[playerid][LoggedIn] = 1;
	    PlayerInfo[playerid][Registered] = 1;
	    SendClientMessage(playerid, green, "[ERRO]: Você agora está registrado, e foi automaticamente logado!");
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return 1;
	}
    return 1;
}
//==============================================================================
dcmd_adminlogar(playerid,params[])
{
    if (PlayerInfo[playerid][LoggedIn] == 1) return SendClientMessage(playerid,red,"[ERRO]: Você já está logado.");
    if (!udb_Exists(PlayerName2(playerid))) return SendClientMessage(playerid,red,"[ERRO]: Essa conta não existe, por favor use '/adminregistrar [senha]'.");
    if (strlen(params)==0) return SendClientMessage(playerid,red,"[ERRO]: Use correto: '/logar [senha]'");
    if (udb_CheckLogin(PlayerName2(playerid),params))
	{
		new file[256], tmp3[100], string[128];
	   	format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(PlayerName2(playerid)) );
   		GetPlayerIp(playerid,tmp3,100);
	   	dini_Set(file,"ip",tmp3);
		LoginPlayer(playerid);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		if(PlayerInfo[playerid][Level] > 0) {
			format(string,sizeof(string),"CONTA: Logado com Sucesso. (Nível %d)", PlayerInfo[playerid][Level] );
			return SendClientMessage(playerid,green,string);
       	} else return SendClientMessage(playerid,green,"CONTA: Logado com Sucesso");
	}
	else {
		PlayerInfo[playerid][FailLogin]++;
		printf("LOGIN: %s has failed to login, Wrong password (%s) Attempt (%d)", PlayerName2(playerid), params, PlayerInfo[playerid][FailLogin] );
		if(PlayerInfo[playerid][FailLogin] == MAX_FAIL_LOGINS)
		{
			new string[128]; format(string, sizeof(string), "%s foi kickado (Falhou no Login)", PlayerName2(playerid) );
			SendClientMessageToAll(grey, string);
			print(string);
			Kick(playerid);
		}
		return SendClientMessage(playerid,red,"CONTA: Falha no login! Senha Incorreta");
	}
}
//==============================================================================
dcmd_mudarsenha(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1)	{
		if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /changepass [new password]");
		if(strlen(params) < 4) return SendClientMessage(playerid,red,"ACCOUNT: Incorrect password length");
		new string[128];
		dUserSetINT(PlayerName2(playerid)).("password_hash",udb_hash(params) );
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
        format(string, sizeof(string),"ACCOUNT: You have successfully changed your password to \"%s\"",params);
		return SendClientMessage(playerid,yellow,string);
	} else return SendClientMessage(playerid,red, "ERROR: You must have an account to use this command");
}
//==============================================================================
dcmd_setpass(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3) {
	    new string[128], tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setpass [playername] [new password]");
		if(strlen(tmp2) < 4 || strlen(tmp2) > MAX_PLAYER_NAME) return SendClientMessage(playerid,red,"ERROR: Incorrect password length");
		if(udb_Exists(tmp)) {
			dUserSetINT(tmp).("password_hash", udb_hash(tmp2));
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
    	    format(string, sizeof(string),"ACCOUNT: You have successfully set \"%s's\" account password to \"%s\"", tmp, tmp2);
			return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red, "ERROR: This player doesnt have an account");
	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
}
//==============================================================================
#if defined USE_STATS
//==============================================================================
dcmd_resetstats(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1)	{
		// save as backup
	   	dUserSetINT(PlayerName2(playerid)).("oldkills",PlayerInfo[playerid][Kills]);
	   	dUserSetINT(PlayerName2(playerid)).("olddeaths",PlayerInfo[playerid][Deaths]);
		// stats reset
		PlayerInfo[playerid][Kills] = 0;
		PlayerInfo[playerid][Deaths] = 0;
		dUserSetINT(PlayerName2(playerid)).("kills",PlayerInfo[playerid][Kills]);
	   	dUserSetINT(PlayerName2(playerid)).("deaths",PlayerInfo[playerid][Deaths]);
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return SendClientMessage(playerid,yellow,"ACCOUNT: You have successfully reset your stats. Your kills and deaths are: 0");
	} else return SendClientMessage(playerid,red, "ERROR: You must have an account to use this command");
}
//==============================================================================
#endif
//==============================================================================
#if defined USE_STATS
dcmd_stats(playerid,params[]) {
	new string[128], pDeaths, player1, h, m, s;
	if(!strlen(params)) player1 = playerid;
	else player1 = strval(params);

	if(IsPlayerConnected(player1)) {
	    TotalGameTime(player1, h, m, s);
 		if(PlayerInfo[player1][Deaths] == 0) pDeaths = 1; else pDeaths = PlayerInfo[player1][Deaths];
 		format(string, sizeof(string), "| %s's Stats:  Matou: %d | Morreu: %d | Relação: %0.2f | Dinheiro: $%d | Score: %d | Tempo: %d hrs %d mins %d secs |",PlayerName2(player1), PlayerInfo[player1][Kills], PlayerInfo[player1][Deaths], Float:PlayerInfo[player1][Kills]/Float:pDeaths,GetPlayerMoney(player1),GetPlayerScore(player1),h, m, s);
		return SendClientMessage(playerid, green, string);
	} else return SendClientMessage(playerid, red, "Jogador não conectado");
}
//==============================================================================
#endif
#endif
//==============================================================================
LoginPlayer(playerid)
{
	if(ServerInfo[GiveMoney] == 1) {ResetPlayerMoney(playerid); GivePlayerMoney(playerid, dUserINT(PlayerName2(playerid)).("money") ); }
	SetPlayerScore(playerid,dUserINT(PlayerName2(playerid)).("score"));
	dUserSetINT(PlayerName2(playerid)).("loggedin",1);
	PlayerInfo[playerid][Deaths] = (dUserINT(PlayerName2(playerid)).("deaths"));
	PlayerInfo[playerid][Kills] = (dUserINT(PlayerName2(playerid)).("kills"));
 	PlayerInfo[playerid][Level] = (dUserINT(PlayerName2(playerid)).("level"));
   	PlayerInfo[playerid][hours] = dUserINT(PlayerName2(playerid)).("hours");
   	PlayerInfo[playerid][mins] = dUserINT(PlayerName2(playerid)).("minutes");
   	PlayerInfo[playerid][secs] = dUserINT(PlayerName2(playerid)).("seconds");
	PlayerInfo[playerid][Registered] = 1;
 	PlayerInfo[playerid][LoggedIn] = 1;
}
//==============================================================================
public OnPlayerCommandText(playerid, cmdtext[])
{
    if(PlayerInfo[playerid][Jailed] == 1 && PlayerInfo[playerid][Level] < 1) return
	    SendClientMessage(playerid,red,"You cannot use commands in jail");
//==============================================================================
	new cmd[256], string[128], tmp[256], idx;
	cmd = strtok(cmdtext, idx);
//==============================================================================
	#if defined USE_AREGISTER
	  	dcmd(adminregister,13,cmdtext);
		dcmd(adminlogin,10,cmdtext);
  		dcmd(achangepass,11,cmdtext);
	  	dcmd(asetpass,8,cmdtext);
	  	#if defined USE_STATS
		dcmd(astats,6,cmdtext);
		dcmd(aresetstats,11,cmdtext);
		#endif
//==============================================================================
	#else
//==============================================================================
  		dcmd(adminregistrar,14,cmdtext);
		dcmd(adminlogar,10,cmdtext);
	  	dcmd(mudarsenha,10,cmdtext);
	  	dcmd(setpass,7,cmdtext);
	  	#if defined USE_STATS
		dcmd(stats,5,cmdtext);
		dcmd(resetstats,10,cmdtext);
		#endif
//==============================================================================
	#endif
//==============================================================================
	dcmd(report,6,cmdtext);
	dcmd(reports,7,cmdtext);
//==============================================================================
	if(ServerInfo[ReadCmds] == 1)
	{
		format(string, sizeof(string), "[VB]Admin: %s (ID: %d) digitou o comando: %s", pName(playerid),playerid,cmdtext);
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				if( (PlayerInfo[i][Level] > PlayerInfo[playerid][Level]) && (PlayerInfo[i][Level] > 1) && (i != playerid) ) {
					SendClientMessage(i, grey, string);
				}
			}
		}
	}
//==============================================================================
	#if defined ENABLE_SPEC
	dcmd(spec,4,cmdtext);
	dcmd(specoff,7,cmdtext);
	dcmd(specvehicle,11,cmdtext);
	#endif
//==============================================================================
	dcmd(disablechat,11,cmdtext);
	dcmd(cc,2,cmdtext);
	dcmd(clearallchat,12,cmdtext);
	dcmd(caps,4,cmdtext);
//==============================================================================
	dcmd(delcar,6,cmdtext);
	dcmd(lockcar,7,cmdtext);
	dcmd(unlockcar,9,cmdtext);
	dcmd(carhealth,9,cmdtext);
	dcmd(corveiculo,10,cmdtext);
	dcmd(car,3,cmdtext);
    dcmd(reparar,7,cmdtext);
    dcmd(ltune,5,cmdtext);
    dcmd(lhy,3,cmdtext);
    dcmd(carro,5,cmdtext);
    dcmd(bike,4,cmdtext);
    dcmd(heli,4,cmdtext);
	dcmd(barco,5,cmdtext);
    dcmd(nos,3,cmdtext);
    dcmd(plane,5,cmdtext);
    dcmd(vgoto,5,cmdtext);
    dcmd(vget,4,cmdtext);
    dcmd(givecar,7,cmdtext);
    dcmd(flip,4,cmdtext);
    dcmd(ct,2,cmdtext);
	dcmd(linkcar,7,cmdtext);
//==============================================================================
    dcmd(crash,5,cmdtext);
	dcmd(ip,2,cmdtext);
	dcmd(force,5,cmdtext);
	dcmd(burn,4,cmdtext);
	dcmd(spawn,5,cmdtext);
	dcmd(spawnplayer,11,cmdtext);
	dcmd(disarm,6,cmdtext);
	dcmd(eject,5,cmdtext);
	dcmd(bankrupt,8,cmdtext);
	dcmd(sbankrupt,9,cmdtext);
	dcmd(setworld,8,cmdtext);
	dcmd(setinterior,11,cmdtext);
    dcmd(ubound,6,cmdtext);
	dcmd(setwanted,9,cmdtext);
	dcmd(setcolor,8,cmdtext);
	dcmd(setarhora,9,cmdtext);
	dcmd(setweather,10,cmdtext);
	dcmd(setname,7,cmdtext);
	dcmd(setarskin,9,cmdtext);
	dcmd(setscore,8,cmdtext);
	dcmd(setargrana,10,cmdtext);
	dcmd(setarvida,9,cmdtext);
	dcmd(setarcolete,11,cmdtext);
	dcmd(dararma,7,cmdtext);
	dcmd(warp,4,cmdtext);
	dcmd(teleplayer,10,cmdtext);
    dcmd(ir,2,cmdtext);
    dcmd(trazer,6,cmdtext);
    dcmd(get,3,cmdtext);
    dcmd(setlevel,8,cmdtext);
    dcmd(settemplevel,12,cmdtext);
    dcmd(fuck,4,cmdtext);
    dcmd(warn,4,cmdtext);
    dcmd(kick,4,cmdtext);
    dcmd(ban,3,cmdtext);
    dcmd(rban,4,cmdtext);
    dcmd(tapa,4,cmdtext);
    dcmd(explode,7,cmdtext);
    dcmd(jail,4,cmdtext);
    dcmd(unjail,6,cmdtext);
    dcmd(jailed,6,cmdtext);
    dcmd(freeze,6,cmdtext);
    dcmd(unfreeze,8,cmdtext);
    dcmd(frozen,6,cmdtext);
    dcmd(mute,4,cmdtext);
    dcmd(unmute,6,cmdtext);
    dcmd(muted,5,cmdtext);
    dcmd(akill,5,cmdtext);
    dcmd(weaps,5,cmdtext);
    dcmd(screen,6,cmdtext);
    dcmd(lgoto,5,cmdtext);
    dcmd(aka,3,cmdtext);
    dcmd(gps,3,cmdtext);
//==============================================================================
	dcmd(healall,7,cmdtext);
	dcmd(armourall,9,cmdtext);
	dcmd(muteall,7,cmdtext);
	dcmd(unmuteall,9,cmdtext);
	dcmd(killall,7,cmdtext);
	dcmd(getall,6,cmdtext);
	dcmd(spawnall,8,cmdtext);
	dcmd(freezeall,9,cmdtext);
	dcmd(unfreezeall,11,cmdtext);
	dcmd(explodeall,10,cmdtext);
	dcmd(kickall,7,cmdtext);
	dcmd(slapall,7,cmdtext);
	dcmd(ejectall,8,cmdtext);
	dcmd(disarmall,9,cmdtext);
	dcmd(setallskin,10,cmdtext);
	dcmd(setallwanted,12,cmdtext);
	dcmd(setallweather,13,cmdtext);
	dcmd(setalltime,10,cmdtext);
	dcmd(setallworld,11,cmdtext);
	dcmd(setallscore,11,cmdtext);
	dcmd(setallcash,10,cmdtext);
	dcmd(giveallcash,11,cmdtext);
	dcmd(giveallweapon,13,cmdtext);
//==============================================================================
	dcmd(lslowmo,7,cmdtext);
    dcmd(god,3,cmdtext);
    dcmd(sgod,4,cmdtext);
    dcmd(godcar,6,cmdtext);
    dcmd(die,3,cmdtext);
    dcmd(jetpack,7,cmdtext);
    dcmd(admins,6,cmdtext);
    dcmd(morning,7,cmdtext);
//==============================================================================
    dcmd(saveplace,9,cmdtext);
	dcmd(gotoplace,9,cmdtext);
	dcmd(saveskin,8,cmdtext);
	dcmd(useskin,7,cmdtext);
	dcmd(dontuseskin,11,cmdtext);
//==============================================================================
    dcmd(setping,7,cmdtext);
	dcmd(setgravity,10,cmdtext);
    dcmd(uconfig,7,cmdtext);
    dcmd(forbidname,10,cmdtext);
    dcmd(forbidword,10,cmdtext);
//==============================================================================
	dcmd(setmytime,9,cmdtext);
	dcmd(kill,4,cmdtext);
	dcmd(time,4,cmdtext);
	dcmd(lhelp,5,cmdtext);
	dcmd(admcmds,7,cmdtext);
	dcmd(admincomandos,13,cmdtext);
	dcmd(nivel1,6,cmdtext);
	dcmd(nivel2,6,cmdtext);
	dcmd(nivel3,6,cmdtext);
	dcmd(nivel4,6,cmdtext);
	dcmd(nivel5,6,cmdtext);
 	dcmd(lcredits,8,cmdtext);
 	dcmd(serverinfo,10,cmdtext);
    dcmd(getid,5,cmdtext);
	dcmd(getinfo,7,cmdtext);
    dcmd(laston,6,cmdtext);
	dcmd(ping,4,cmdtext);
    dcmd(countdown,9,cmdtext);
    dcmd(asay,4,cmdtext);
	dcmd(senha,5,cmdtext);
	dcmd(lockserver,10,cmdtext);
	dcmd(unlockserver,12,cmdtext);
    dcmd(adminarea,9,cmdtext);
    dcmd(ann,3,cmdtext);
    dcmd(ann2,4,cmdtext);
    dcmd(richlist,8,cmdtext);
    dcmd(miniguns,8,cmdtext);
    dcmd(botcheck,8,cmdtext);
    dcmd(object,6,cmdtext);
    dcmd(pickup,6,cmdtext);
    dcmd(move,4,cmdtext);
    dcmd(moveplayer,10,cmdtext);
//==============================================================================
    #if defined ENABLE_FAKE_CMDS
	dcmd(fakedeath,9,cmdtext);
	dcmd(fakechat,8,cmdtext);
	dcmd(fakecmd,7,cmdtext);
	#endif
//==============================================================================
    #if defined USE_MENUS
    #endif
//==============================================================================
 	if(strcmp(cmd, "/spam", true) == 0)	{
		if(PlayerInfo[playerid][Level] >= 5) {
		    tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, red, "[ERRO]: Use /spam [Colour] [Text]");
			return SendClientMessage(playerid, red, "Cores: 0=Preto 1=Branco 2=Vermelho 3=Laranja 4=Amarelo 5=Verde 6=Azul.");
				return 1;
			}
			new Colour = strval(tmp);
			if(Colour > 9 ) return SendClientMessage(playerid, red, "Cores: 0=Preto 1=Branco 2=Vermelho 3=Laranja 4=Amarelo 5=Verde 6=Azul.");
			tmp = strtok(cmdtext, idx);

			format(string,sizeof(string),"%s",cmdtext[8]);

	        if(Colour == 0) 	 for(new i; i < 50; i++) SendClientMessageToAll(black,string);
	        else if(Colour == 1) for(new i; i < 50; i++) SendClientMessageToAll(COLOR_WHITE,string);
	        else if(Colour == 2) for(new i; i < 50; i++) SendClientMessageToAll(red,string);
	        else if(Colour == 3) for(new i; i < 50; i++) SendClientMessageToAll(orange,string);
	        else if(Colour == 4) for(new i; i < 50; i++) SendClientMessageToAll(yellow,string);
	        else if(Colour == 5) for(new i; i < 50; i++) SendClientMessageToAll(COLOR_GREEN1,string);
	        else if(Colour == 6) for(new i; i < 50; i++) SendClientMessageToAll(COLOR_BLUE,string);
	        else if(Colour == 7) for(new i; i < 50; i++) SendClientMessageToAll(COLOR_PURPLE,string);
	        else if(Colour == 8) for(new i; i < 50; i++) SendClientMessageToAll(COLOR_BROWN,string);
	        else if(Colour == 9) for(new i; i < 50; i++) SendClientMessageToAll(COLOR_PINK,string);
			return 1;
		} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Dono para usar este comando!");
	}
//==============================================================================
 	if(strcmp(cmd, "/escrever", true) == 0) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, red, "[ERRO]: Use /escrever [cor] [texto]");
			return SendClientMessage(playerid, red, "Cores: 0=Preto 1=Branco 2=Vermelho 3=Laranja 4=Amarelo 5=Verde 6=Azul.");
	 	}
		new Colour;
		Colour = strval(tmp);
		if(Colour > 9 )	{
			SendClientMessage(playerid, red, "[ERRO]: Use /escrever [cor] [texto]");
			return SendClientMessage(playerid, red, "Cores: 0=Preto 1=Branco 2=Vermelho 3=Laranja 4=Amarelo 5=Verde 6=Azul.");
		}
		tmp = strtok(cmdtext, idx);

        CMDMessageToAdmins(playerid,"WRITE");

        if(Colour == 0) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(black,string); return 1;	}
        else if(Colour == 1) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_WHITE,string); return 1;	}
        else if(Colour == 2) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(red,string); return 1;	}
        else if(Colour == 3) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(orange,string); return 1;	}
        else if(Colour == 4) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(yellow,string); return 1;	}
        else if(Colour == 5) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_GREEN1,string); return 1;	}
        else if(Colour == 6) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_BLUE,string); return 1;	}
        else if(Colour == 7) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_PURPLE,string); return 1;	}
        else if(Colour == 8) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_BROWN,string); return 1;	}
        else if(Colour == 9) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_PINK,string); return 1;	}
        return 1;
	} else return SendClientMessage(playerid,red,"[ERRO]: Você precisa ser ADM Normal para usar este comando!");
	}
//==============================================================================
	if(strcmp(cmd, "/carregarfs", true) == 0) {
	    if(PlayerInfo[playerid][Level] >= 5) {
    		new str[128]; format(str,sizeof(string),"%s",cmdtext[1]); SendRconCommand(str);
		    return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
	   	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	}
 	
	if(strcmp(cmd, "/descarregarfs", true) == 0)	 {
	    if(PlayerInfo[playerid][Level] >= 5) {
    		new str[128]; format(str,sizeof(string),"%s",cmdtext[1]); SendRconCommand(str);
		    return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
	   	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	}

	if(strcmp(cmd, "/changemode", true) == 0)	 {
	    if(PlayerInfo[playerid][Level] >= 4) {
    		new str[128]; format(str,sizeof(string),"%s",cmdtext[1]); SendRconCommand(str);
		    return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
	   	} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	}

	if(strcmp(cmd, "/reiniciar", true) == 0)	 {
		if(PlayerInfo[playerid][Level] >= 5) {
			OnFilterScriptExit(); SetTimer("RestartGM",5000,0);
            SendClientMessageToAll(red,  "O server será reiniciado, seus dados foram salvos!");
			return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	}

	if(strcmp(cmd, "/loadladmin", true) == 0)	 {
		if(PlayerInfo[playerid][Level] >= 5) {
			SendRconCommand("loadfs AdminVB");
			return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	}

	if(strcmp(cmd, "/unloadladmin", true) == 0)	 {
		if(PlayerInfo[playerid][Level] >= 5) {
			SendRconCommand("unloadfs AdminVB");
			return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	}

	if(strcmp(cmd, "/reloadladmin", true) == 0)	 {
		if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid) ) {
			SendRconCommand("reloadfs AdminVB");
			SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
			return CMDMessageToAdmins(playerid,"RELOADLADMIN");
		} else return SendClientMessage(playerid,red,"[ERRO]: Você não tem nivel de ADM suficiente para usar este comando!");
	}
	return 0;
}
//==============================================================================
#if defined ENABLE_SPEC

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	new x = 0;
	while(x!=MAX_PLAYERS) {
	    if( IsPlayerConnected(x) &&	GetPlayerState(x) == PLAYER_STATE_SPECTATING &&
			PlayerInfo[x][SpecID] == playerid && PlayerInfo[x][SpecType] == ADMIN_SPEC_TYPE_PLAYER )
   		{
   		    SetPlayerInterior(x,newinteriorid);
		}
		x++;
	}
}

//==============================================================================
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PlayerInfo[playerid][SpecID] != INVALID_PLAYER_ID)
	{
		if(newkeys == KEY_JUMP) AdvanceSpectate(playerid);
		else if(newkeys == KEY_SPRINT) ReverseSpectate(playerid);
	}
	return 1;
}

//==============================================================================
public OnPlayerEnterVehicle(playerid, vehicleid) {
	for(new x=0; x<MAX_PLAYERS; x++) {
	    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid) {
	        TogglePlayerSpectating(x, 1);
	        PlayerSpectateVehicle(x, vehicleid);
	        PlayerInfo[x][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
		}
	}
	return 1;
}

//==============================================================================
public OnPlayerStateChange(playerid, newstate, oldstate) {
	switch(newstate) {
		case PLAYER_STATE_ONFOOT: {
			switch(oldstate) {
				case PLAYER_STATE_DRIVER: OnPlayerExitVehicle(playerid,255);
				case PLAYER_STATE_PASSENGER: OnPlayerExitVehicle(playerid,255);
			}
		}
	}
	return 1;
}
//==============================================================================
#endif
//==============================================================================
public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(PlayerInfo[playerid][DoorsLocked] == 1) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),playerid,false,false);

	#if defined ENABLE_SPEC
	for(new x=0; x<MAX_PLAYERS; x++) {
    	if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid && PlayerInfo[x][SpecType] == ADMIN_SPEC_TYPE_VEHICLE) {
        	TogglePlayerSpectating(x, 1);
	        PlayerSpectatePlayer(x, playerid);
    	    PlayerInfo[x][SpecType] = ADMIN_SPEC_TYPE_PLAYER;
		}
	}
	#endif
	return 1;
}
//==============================================================================
//==============================================================================
#if defined ENABLE_SPEC
//==============================================================================
stock StartSpectate(playerid, specplayerid)
{
	for(new x=0; x<MAX_PLAYERS; x++) {
	    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid) {
	       AdvanceSpectate(x);
		}
	}
	SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
	TogglePlayerSpectating(playerid, 1);
	
	if(IsPlayerInAnyVehicle(specplayerid)) {
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specplayerid));
		PlayerInfo[playerid][SpecID] = specplayerid;
		PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
	}
	else {
		PlayerSpectatePlayer(playerid, specplayerid);
		PlayerInfo[playerid][SpecID] = specplayerid;
		PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_PLAYER;
	}
	new string[100], Float:hp, Float:ar;
	GetPlayerName(specplayerid,string,sizeof(string));
	GetPlayerHealth(specplayerid, hp);	GetPlayerArmour(specplayerid, ar);
	format(string,sizeof(string),"~n~~n~~n~~n~~n~~n~~n~~n~~w~%s - id:%d~n~< espaco - pular >~n~hp:%0.1f ar:%0.1f $%d", string,specplayerid,hp,ar,GetPlayerMoney(specplayerid) );
	GameTextForPlayer(playerid,string,25000,3);
	return 1;
}
//==============================================================================
stock StopSpectate(playerid)
{
	TogglePlayerSpectating(playerid, 0);
	PlayerInfo[playerid][SpecID] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_NONE;
	GameTextForPlayer(playerid,"~n~~n~~n~~w~Modo espionagem terminado",1000,3);
	return 1;
}
//==============================================================================
stock AdvanceSpectate(playerid)
{
    if(ConnectedPlayers() == 2) { StopSpectate(playerid); return 1; }
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PlayerInfo[playerid][SpecID] != INVALID_PLAYER_ID)
	{
	    for(new x=PlayerInfo[playerid][SpecID]+1; x<=MAX_PLAYERS; x++)
		{
	    	if(x == MAX_PLAYERS) x = 0;
	        if(IsPlayerConnected(x) && x != playerid)
			{
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] != INVALID_PLAYER_ID || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
				{
					continue;
				}
				else
				{
					StartSpectate(playerid, x);
					break;
				}
			}
		}
	}
	return 1;
}
//==============================================================================
stock ReverseSpectate(playerid)
{
    if(ConnectedPlayers() == 2) { StopSpectate(playerid); return 1; }
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PlayerInfo[playerid][SpecID] != INVALID_PLAYER_ID)
	{
	    for(new x=PlayerInfo[playerid][SpecID]-1; x>=0; x--)
		{
	    	if(x == 0) x = MAX_PLAYERS;
	        if(IsPlayerConnected(x) && x != playerid)
			{
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] != INVALID_PLAYER_ID || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
				{
					continue;
				}
				else
				{
					StartSpectate(playerid, x);
					break;
				}
			}
		}
	}
	return 1;
}
//==============================================================================
forward PosAfterSpec(playerid);
//==============================================================================
public PosAfterSpec(playerid)
{
	SetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
	SetPlayerFacingAngle(playerid,Pos[playerid][3]);
}
//==============================================================================
#endif
//==============================================================================
EraseVehicle(vehicleid)
{
    for(new players=0;players<=MAX_PLAYERS;players++)
    {
        new Float:X,Float:Y,Float:Z;
        if (IsPlayerInVehicle(players,vehicleid))
        {
            GetPlayerPos(players,X,Y,Z);
            SetPlayerPos(players,X,Y,Z+2);
            SetVehicleToRespawn(vehicleid);
        }
        SetVehicleParamsForPlayer(vehicleid,players,0,1);
    }
    SetTimerEx("VehRes",3000,0,"d",vehicleid);
    return 1;
}
//==============================================================================
forward CarSpawner(playerid,model);
//==============================================================================
public CarSpawner(playerid,model)
{
	if(IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid, red, "You already have a car!");
 	else
	{
    	new Float:x, Float:y, Float:z, Float:angle;
	 	GetPlayerPos(playerid, x, y, z);
	 	GetPlayerFacingAngle(playerid, angle);
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
	    new vehicleid=CreateVehicle(model, x, y, z, angle, -1, -1, -1);
		PutPlayerInVehicle(playerid, vehicleid, 0);
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
		LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
		ChangeVehicleColor(vehicleid,0,7);
        PlayerInfo[playerid][pCar] = vehicleid;
	}
	return 1;
}
//==============================================================================
forward CarDeleter(vehicleid);
//==============================================================================
public CarDeleter(vehicleid)
{
    for(new i=0;i<MAX_PLAYERS;i++) {
        new Float:X,Float:Y,Float:Z;
    	if(IsPlayerInVehicle(i, vehicleid)) {
    	    RemovePlayerFromVehicle(i);
    	    GetPlayerPos(i,X,Y,Z);
        	SetPlayerPos(i,X,Y+3,Z);
	    }
	    SetVehicleParamsForPlayer(vehicleid,i,0,1);
	}
    SetTimerEx("VehRes",1500,0,"i",vehicleid);
}
//==============================================================================
forward VehRes(vehicleid);
//==============================================================================
public VehRes(vehicleid)
{
    DestroyVehicle(vehicleid);
}
//==============================================================================
public OnVehicleSpawn(vehicleid)
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
        if(vehicleid==PlayerInfo[i][pCar])
		{
		    CarDeleter(vehicleid);
	        PlayerInfo[i][pCar]=-1;
        }
	}
	return 1;
}
//==============================================================================
forward TuneLCar(VehicleID);
//==============================================================================
public TuneLCar(VehicleID)
{
	ChangeVehicleColor(VehicleID,0,7);
	AddVehicleComponent(VehicleID, 1010);  AddVehicleComponent(VehicleID, 1087);
}
//==============================================================================
public OnRconCommand(cmd[])
{
	if( strlen(cmd) > 50 || strlen(cmd) == 1 ) return print("Invalid command length (exceeding 50 characters)");

	if(strcmp(cmd, "ladmin", true)==0) {
		print("Rcon Commands");
		print("info, aka, pm, asay, ann, uconfig, chat");
		return true;
	}
//==============================================================================
	if(strcmp(cmd, "info", true)==0)
	{
	    new TotalVehicles = CreateVehicle(411, 0, 0, 0, 0, 0, 0, 1000);    DestroyVehicle(TotalVehicles);
		new numo = CreateObject(1245,0,0,1000,0,0,0);	DestroyObject(numo);
		new nump = CreatePickup(371,2,0,0,1000);	DestroyPickup(nump);
		new gz = GangZoneCreate(3,3,5,5);	GangZoneDestroy(gz);

		new model[250], nummodel;
		for(new i=1;i<TotalVehicles;i++) model[GetVehicleModel(i)-400]++;
		for(new i=0;i<250;i++) { if(model[i]!=0) {	nummodel++;	}	}

		new string[256];
		print(" ===========================================================================");
		printf("                           Server Info:");
		format(string,sizeof(string),"[ Players Connected: %d || Maximum Players: %d ] [Ratio %0.2f ]",ConnectedPlayers(),GetMaxPlayers(),Float:ConnectedPlayers() / Float:GetMaxPlayers() );
		printf(string);
		format(string,sizeof(string),"[ Vehicles: %d || Models %d || Players In Vehicle: %d ]",TotalVehicles-1,nummodel, InVehCount() );
		printf(string);
		format(string,sizeof(string),"[ InCar %d  ||  OnBike %d ]",InCarCount(),OnBikeCount() );
		printf(string);
		format(string,sizeof(string),"[ Objects: %d || Pickups %d  || Gangzones %d]",numo-1, nump, gz);
		printf(string);
		format(string,sizeof(string),"[ Players In Jail %d || Players Frozen %d || Muted %d ]",JailedPlayers(),FrozenPlayers(), MutedPlayers() );
	    printf(string);
	    format(string,sizeof(string),"[ Admins online %d ]",AdminCount(), RconAdminCount() );
	    printf(string);
		print(" ===========================================================================");
		return true;
	}

	if(!strcmp(cmd, "pm", .length = 2))
	{
	    new arg_1 = argpos(cmd), arg_2 = argpos(cmd, arg_1),targetid = strval(cmd[arg_1]), message[128];

    	if ( !cmd[arg_1] || cmd[arg_1] < '0' || cmd[arg_1] > '9' || targetid > MAX_PLAYERS || targetid < 0 || !cmd[arg_2])
	        print("Usage: \"pm <playerid> <message>\"");

	    else if ( !IsPlayerConnected(targetid) ) print("This player is not connected!");
    	else
	    {
	        format(message, sizeof(message), "[RCON] PM: %s", cmd[arg_2]);
	        SendClientMessage(targetid, COLOR_WHITE, message);
   	        printf("Rcon PM '%s' sent", cmd[arg_1] );
    	}
	    return true;
	}

	if(!strcmp(cmd, "asay", .length = 4))
	{
	    new arg_1 = argpos(cmd), message[128];

    	if ( !cmd[arg_1] || cmd[arg_1] < '0') print("Usage: \"asay  <message>\" (MessageToAdmins)");
	    else
	    {
	        format(message, sizeof(message), "[RCON] MessageToAdmins: %s", cmd[arg_1]);
	        MessageToAdmins(COLOR_WHITE, message);
	        printf("Admin Message '%s' sent", cmd[arg_1] );
    	}
	    return true;
	}

	if(!strcmp(cmd, "ann", .length = 3))
	{
	    new arg_1 = argpos(cmd), message[128];
    	if ( !cmd[arg_1] || cmd[arg_1] < '0') print("Usage: \"ann  <message>\" (GameTextForAll)");
	    else
	    {
	        format(message, sizeof(message), "[RCON]: %s", cmd[arg_1]);
	        GameTextForAll(message,3000,3);
	        printf("GameText Message '%s' sent", cmd[arg_1] );
    	}
	    return true;
	}

	if(!strcmp(cmd, "msg", .length = 3))
	{
	    new arg_1 = argpos(cmd), message[128];
    	if ( !cmd[arg_1] || cmd[arg_1] < '0') print("Usage: \"msg  <message>\" (SendClientMessageToAll)");
	    else
	    {
	        format(message, sizeof(message), "[RCON]: %s", cmd[arg_1]);
	        SendClientMessageToAll(COLOR_WHITE, message);
	        printf("MessageToAll '%s' sent", cmd[arg_1] );
    	}
	    return true;
	}
	
	if(strcmp(cmd, "uconfig", true)==0)
	{
		UpdateConfig();
		print("Configuration Successfully Updated");
		return true;
	}

	if(!strcmp(cmd, "aka", .length = 3))
	{
	    new arg_1 = argpos(cmd), targetid = strval(cmd[arg_1]);

    	if ( !cmd[arg_1] || cmd[arg_1] < '0' || cmd[arg_1] > '9' || targetid > MAX_PLAYERS || targetid < 0)
	        print("Usage: aka <playerid>");
	    else if ( !IsPlayerConnected(targetid) ) print("This player is not connected!");
    	else
	    {
			new tmp3[50], playername[MAX_PLAYER_NAME];
	  		GetPlayerIp(targetid,tmp3,50);
			GetPlayerName(targetid, playername, sizeof(playername));
			printf("AKA: [%s id:%d] [%s] %s", playername, targetid, tmp3, dini_Get("ladmin/config/aka.txt",tmp3) );
    	}
	    return true;
	}

	if(!strcmp(cmd, "chat", .length = 4)) {
	for(new i = 1; i < MAX_CHAT_LINES; i++) print(Chat[i]);
    return true;
	}

	return 0;
}
//==============================================================================
//							Menus
//==============================================================================
#if defined USE_MENUS
//==============================================================================
#endif
//==============================================================================
forward countdown();
//==============================================================================
public countdown()
{
	if(CountDown==6) GameTextForAll("~p~Iniciando...",1000,6);

	CountDown--;
	if(CountDown==0)
	{
		GameTextForAll("~g~VAI~ r~!",1000,6);
		CountDown = -1;
		for(new i = 0; i < MAX_PLAYERS; i++) {
			TogglePlayerControllable(i,true);
			PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
		}
		return 0;
	}
	else
	{
		new text[7]; format(text,sizeof(text),"~w~%d",CountDown);
		for(new i = 0; i < MAX_PLAYERS; i++) {
			PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			TogglePlayerControllable(i,false);
		}
	 	GameTextForAll(text,1000,6);
	}
	
	SetTimer("countdown",1000,0);
	return 0;
}
//==============================================================================
forward Duel(player1, player2);
//==============================================================================
public Duel(player1, player2)
{
	if(cdt[player1]==6) {
		GameTextForPlayer(player1,"~r~Iniciando Duelo...",1000,6); GameTextForPlayer(player2,"~r~Iniciando Duelo...",1000,6);
	}

	cdt[player1]--;
	if(cdt[player1]==0)
	{
		TogglePlayerControllable(player1,1); TogglePlayerControllable(player2,1);
		PlayerPlaySound(player1, 1057, 0.0, 0.0, 0.0); PlayerPlaySound(player2, 1057, 0.0, 0.0, 0.0);
		GameTextForPlayer(player1,"~g~VAI~ r~!",1000,6); GameTextForPlayer(player2,"~g~VAI~ r~!",1000,6);
		return 0;
	}
	else
	{
		new text[7]; format(text,sizeof(text),"~w~%d",cdt[player1]);
		PlayerPlaySound(player1, 1056, 0.0, 0.0, 0.0); PlayerPlaySound(player2, 1056, 0.0, 0.0, 0.0);
		TogglePlayerControllable(player1,0); TogglePlayerControllable(player2,0);
		GameTextForPlayer(player1,text,1000,6); GameTextForPlayer(player2,text,1000,6);
	}

	SetTimerEx("Duel",1000,0,"dd", player1, player2);
	return 0;
}
//==============================================================================
forward Jail1(player1);
//==============================================================================
public Jail1(player1)
{
	TogglePlayerControllable(player1,false);
	new Float:x, Float:y, Float:z;	GetPlayerPos(player1,x,y,z);
	SetPlayerCameraPos(player1,x+10,y,z+10);SetPlayerCameraLookAt(player1,x,y,z);
	SetTimerEx("Jail2",1000,0,"d",player1);
}
//==============================================================================
forward Jail2(player1);
//==============================================================================
public Jail2(player1)
{
	new Float:x, Float:y, Float:z; GetPlayerPos(player1,x,y,z);
	SetPlayerCameraPos(player1,x+7,y,z+5); SetPlayerCameraLookAt(player1,x,y,z);
	if(GetPlayerState(player1) == PLAYER_STATE_ONFOOT) SetPlayerSpecialAction(player1,SPECIAL_ACTION_HANDSUP);
	GameTextForPlayer(player1,"~r~Preso pelos Admins",3000,3);
	SetTimerEx("Jail3",1000,0,"d",player1);
}
//==============================================================================
forward Jail3(player1);
//==============================================================================
public Jail3(player1)
{
	new Float:x, Float:y, Float:z; GetPlayerPos(player1,x,y,z);
	SetPlayerCameraPos(player1,x+3,y,z); SetPlayerCameraLookAt(player1,x,y,z);
}
//==============================================================================
forward JailPlayer(player1);
//==============================================================================
public JailPlayer(player1)
{
	TogglePlayerControllable(player1,true);
	SetPlayerPos(player1,197.6661,173.8179,1003.0234);
	SetPlayerInterior(player1,3);
	SetCameraBehindPlayer(player1);
	JailTimer[player1] = SetTimerEx("JailRelease",PlayerInfo[player1][JailTime],0,"d",player1);
	PlayerInfo[player1][Jailed] = 1;
}
//==============================================================================
forward JailRelease(player1);
//==============================================================================
public JailRelease(player1)
{
	KillTimer( JailTimer[player1] );
	PlayerInfo[player1][JailTime] = 0;  PlayerInfo[player1][Jailed] = 0;
	SetPlayerInterior(player1,0); SetPlayerPos(player1, 0.0, 0.0, 0.0); SpawnPlayer(player1);
	PlayerPlaySound(player1,1057,0.0,0.0,0.0);
	GameTextForPlayer(player1,"~g~Libertado ~n~Da Cadeia",3000,3);
}
//==============================================================================
forward UnFreezeMe(player1);
//==============================================================================
public UnFreezeMe(player1)
{
	KillTimer( FreezeTimer[player1] );
	TogglePlayerControllable(player1,true);   PlayerInfo[player1][Frozen] = 0;
	PlayerPlaySound(player1,1057,0.0,0.0,0.0);	GameTextForPlayer(player1,"~g~Descongelado",3000,3);
}

//==============================================================================
forward RepairCar(playerid);
//==============================================================================
public RepairCar(playerid)
{
	if(IsPlayerInAnyVehicle(playerid)) SetVehiclePos(GetPlayerVehicleID(playerid),Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]+0.5);
	SetVehicleZAngle(GetPlayerVehicleID(playerid), Pos[playerid][3]);
	SetCameraBehindPlayer(playerid);
}
//==============================================================================
forward PingKick();
//==============================================================================
public PingKick()
{
	if(ServerInfo[MaxPing] != 0)
	{
	    PingPos++; if(PingPos > PING_MAX_EXCEEDS) PingPos = 0;
	    
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			PlayerInfo[i][pPing][PingPos] = GetPlayerPing(i);
			
		    if(GetPlayerPing(i) > ServerInfo[MaxPing])
			{
				if(PlayerInfo[i][PingCount] == 0) PlayerInfo[i][PingTime] = TimeStamp();

	   			PlayerInfo[i][PingCount]++;
				if(TimeStamp() - PlayerInfo[i][PingTime] > PING_TIMELIMIT)
				{
	    			PlayerInfo[i][PingTime] = TimeStamp();
					PlayerInfo[i][PingCount] = 1;
				}
				else if(PlayerInfo[i][PingCount] >= PING_MAX_EXCEEDS)
				{
				    new Sum, Average, x, string[128];
					while (x < PING_MAX_EXCEEDS) {
						Sum += PlayerInfo[i][pPing][x];
						x++;
					}
					Average = (Sum / PING_MAX_EXCEEDS);
					format(string,sizeof(string),"[FCT]Hexa-ADM kickou %s do server. (Motivo: Ping Alto (%d) | Média (%d) | Máximo permitido (%d) )", PlayerName2(i), GetPlayerPing(i), Average, ServerInfo[MaxPing] );
  		    		SendClientMessageToAll(grey,string);
					SaveToFile("KickLog",string);
					Kick(i);
				}
			}
			else if(GetPlayerPing(i) < 1 && ServerInfo[AntiBot] == 1)
		    {
				PlayerInfo[i][BotPing]++;
				if(PlayerInfo[i][BotPing] >= 3) BotCheck(i);
		    }
		    else
			{
				PlayerInfo[i][BotPing] = 0;
			}
		}
	}
//==============================================================================
	#if defined ANTI_MINIGUN
	new weap, ammo;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && PlayerInfo[i][Level] == 0)
		{
			GetPlayerWeaponData(i, 7, weap, ammo);
			if(ammo > 1 && weap == 38) {
				new string[128]; format(string,sizeof(string),"[FCT]Hexa-ADM: %s tem uma minigun com %d balas!", PlayerName2(i), ammo);
				MessageToAdmins(COLOR_WHITE,string);
			}
		}
	}
	#endif
}
//==============================================================================
forward GodUpdate();
//==============================================================================
public GodUpdate()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && PlayerInfo[i][God] == 1)
		{
			SetPlayerHealth(i,100000);
		}
		if(IsPlayerConnected(i) && PlayerInfo[i][GodCar] == 1 && IsPlayerInAnyVehicle(i))
		{
			SetVehicleHealth(GetPlayerVehicleID(i),10000);
		}
	}
}

//==============================================================================
forward ConnectedPlayers();
//==============================================================================
public ConnectedPlayers()
{
	new Connected;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) Connected++;
	return Connected;
}
//==============================================================================
forward JailedPlayers();
//==============================================================================
public JailedPlayers()
{
	new JailedCount;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Jailed] == 1) JailedCount++;
	return JailedCount;
}
//==============================================================================
forward FrozenPlayers();
//==============================================================================
public FrozenPlayers()
{
	new FrozenCount; for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Frozen] == 1) FrozenCount++;
	return FrozenCount;
}
//==============================================================================
forward MutedPlayers();
//==============================================================================
public MutedPlayers()
{
	new Count; for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Muted] == 1) Count++;
	return Count;
}
//==============================================================================
forward InVehCount();
//==============================================================================
public InVehCount()
{
	new InVeh; for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) InVeh++;
	return InVeh;
}
//==============================================================================
forward OnBikeCount();
//==============================================================================
public OnBikeCount()
{
	new BikeCount;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) {
		new LModel = GetVehicleModel(GetPlayerVehicleID(i));
		switch(LModel)
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586:  BikeCount++;
		}
	}
	return BikeCount;
}
//==============================================================================
forward InCarCount();
//==============================================================================
public InCarCount()
{
	new PInCarCount;
	for(new i = 0; i < MAX_PLAYERS; i++) {
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) {
			new LModel = GetVehicleModel(GetPlayerVehicleID(i));
			switch(LModel)
			{
				case 448,461,462,463,468,471,509,510,521,522,523,581,586: {}
				default: PInCarCount++;
			}
		}
	}
	return PInCarCount;
}
//==============================================================================
forward AdminCount();
//==============================================================================
public AdminCount()
{
	new LAdminCount;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Level] >= 1)	LAdminCount++;
	return LAdminCount;
}
//==============================================================================
forward RconAdminCount();
//==============================================================================
public RconAdminCount()
{
	new rAdminCount;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerAdmin(i)) rAdminCount++;
	return rAdminCount;
}
//==============================================================================
forward RestartGM();
//==============================================================================
public RestartGM()
{
	SendRconCommand("gmx");
}
//==============================================================================
forward UnloadFS();
//==============================================================================
public UnloadFS()
{
	SendRconCommand("unloadfs ladmin4");
}
//==============================================================================
forward PrintWarning(const string[]);
//==============================================================================
public PrintWarning(const string[])
{
    new str[128];
    print("\n\n>		WARNING:\n");
    format(str, sizeof(str), " The  %s  folder is missing from scriptfiles", string);
    print(str);
    print("\n Please Create This Folder And Reload the Filterscript\n\n");
}
//==============================================================================
forward BotCheck(playerid);
//==============================================================================
public BotCheck(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerPing(playerid) < 1)
		{
			new string[128], ip[20];  GetPlayerIp(playerid,ip,sizeof(ip));
			format(string,sizeof(string),"BOT: %s id:%d ip: %s ping: %d",PlayerName2(playerid),playerid,ip,GetPlayerPing(playerid));
			SaveToFile("BotKickLog",string);
		    SaveToFile("KickLog",string);
			printf("[FCT]Hexa-ADM: Foi detectado um BOT e kicado (Kickado %s ID:%d)", PlayerName2(playerid), playerid);
			Kick(playerid);
		}
	}
}
//==============================================================================
forward PutAtPos(playerid);
public PutAtPos(playerid)
{
	if (dUserINT(PlayerName2(playerid)).("x")!=0) {
     	SetPlayerPos(playerid, float(dUserINT(PlayerName2(playerid)).("x")), float(dUserINT(PlayerName2(playerid)).("y")), float(dUserINT(PlayerName2(playerid)).("z")) );
 		SetPlayerInterior(playerid,	(dUserINT(PlayerName2(playerid)).("interior"))	);
	}
}
//==============================================================================
forward PutAtDisconectPos(playerid);
//==============================================================================
public PutAtDisconectPos(playerid)
{
	if (dUserINT(PlayerName2(playerid)).("x1")!=0) {
    	SetPlayerPos(playerid, float(dUserINT(PlayerName2(playerid)).("x1")), float(dUserINT(PlayerName2(playerid)).("y1")), float(dUserINT(PlayerName2(playerid)).("z1")) );
		SetPlayerInterior(playerid,	(dUserINT(PlayerName2(playerid)).("interior1"))	);
	}
}
//==============================================================================
TotalGameTime(playerid, &h=0, &m=0, &s=0)
{
    PlayerInfo[playerid][TotalTime] = ( (gettime() - PlayerInfo[playerid][ConnectTime]) + (PlayerInfo[playerid][hours]*60*60) + (PlayerInfo[playerid][mins]*60) + (PlayerInfo[playerid][secs]) );

    h = floatround(PlayerInfo[playerid][TotalTime] / 3600, floatround_floor);
    m = floatround(PlayerInfo[playerid][TotalTime] / 60,   floatround_floor) % 60;
    s = floatround(PlayerInfo[playerid][TotalTime] % 60,   floatround_floor);

    return PlayerInfo[playerid][TotalTime];
}
//==============================================================================
MaxAmmo(playerid)
{
	new slot, weap, ammo;
	for (slot = 0; slot < 14; slot++)
	{
    	GetPlayerWeaponData(playerid, slot, weap, ammo);
		if(IsValidWeapon(weap))
		{
		   	GivePlayerWeapon(playerid, weap, 99999);
		}
	}
	return 1;
}
//==============================================================================
stock PlayerName2(playerid) {
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, sizeof(name));
  return name;
}
//==============================================================================
stock pName(playerid)
{
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, sizeof(name));
  return name;
}
//==============================================================================
stock TimeStamp()
{
	new time = GetTickCount() / 1000;
	return time;
}
//==============================================================================
stock PlayerSoundForAll(SoundID)
{
	for(new i = 0; i < MAX_PLAYERS; i++) PlayerPlaySound(i, SoundID, 0.0, 0.0, 0.0);
}
//==============================================================================
stock IsValidWeapon(weaponid)
{
    if (weaponid > 0 && weaponid < 19 || weaponid > 21 && weaponid < 47) return 1;
    return 0;
}
//==============================================================================
stock IsValidSkin(SkinID)
{
	if((SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID <= 73)||(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 264)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299)) return true;
	else return false;
}
//==============================================================================
stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}
//==============================================================================
stock ReturnPlayerID(PlayerName[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(strfind(pName(i),PlayerName,true)!=-1) return i;
		}
	}
	return INVALID_PLAYER_ID;
}
//==============================================================================
GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if ( strfind(VehicleNames[i], vname, true) != -1 )
			return i + 400;
	}
	return -1;
}
//==============================================================================
stock GetWeaponIDFromName(WeaponName[])
{
	if(strfind("molotov",WeaponName,true)!=-1) return 18;
	for(new i = 0; i <= 46; i++)
	{
		switch(i)
		{
			case 0,19,20,21,44,45: continue;
			default:
			{
				new name[32]; GetWeaponName(i,name,32);
				if(strfind(name,WeaponName,true) != -1) return i;
			}
		}
	}
	return -1;
}
//==============================================================================
stock DisableWord(const badword[], text[])
{
   	for(new i=0; i<256; i++)
   	{
		if (strfind(text[i], badword, true) == 0)
		{
			for(new a=0; a<256; a++)
			{
				if (a >= i && a < i+strlen(badword)) text[a]='*';
			}
		}
	}
}
//==============================================================================
argpos(const string[], idx = 0, sep = ' ')// (by yom)
{
    for(new i = idx, j = strlen(string); i < j; i++)
        if (string[i] == sep && string[i+1] != sep)
            return i+1;

    return -1;
}
//==============================================================================
forward MessageToAdmins(color,const string[]);
//==============================================================================
public MessageToAdmins(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1) if (PlayerInfo[i][Level] >= 1) SendClientMessage(i, color, string);
	}
	return 1;
}
//==============================================================================
stock CMDMessageToAdmins(playerid,command[])
{
	if(ServerInfo[AdminCmdMsg] == 0) return 1;
	new string[128]; GetPlayerName(playerid,string,sizeof(string));
	format(string,sizeof(string),"[ADMIN] %s usou o comando %s",string,command);
	return MessageToAdmins(blue,string);
}
//==============================================================================
SavePlayer(playerid)
{
   	dUserSetINT(PlayerName2(playerid)).("money",GetPlayerMoney(playerid));
    dUserSetINT(PlayerName2(playerid)).("score",GetPlayerScore(playerid));
   	dUserSetINT(PlayerName2(playerid)).("kills",PlayerInfo[playerid][Kills]);
   	dUserSetINT(PlayerName2(playerid)).("deaths",PlayerInfo[playerid][Deaths]);
//==============================================================================
	new h, m, s;
    TotalGameTime(playerid, h, m, s);
//==============================================================================
	dUserSetINT(PlayerName2(playerid)).("hours", h);
	dUserSetINT(PlayerName2(playerid)).("minutes", m);
	dUserSetINT(PlayerName2(playerid)).("seconds", s);
//==============================================================================
   	new Float:x,Float:y,Float:z, interior;
   	GetPlayerPos(playerid,x,y,z);	interior = GetPlayerInterior(playerid);
    dUserSetINT(PlayerName2(playerid)).("x1",floatround(x));
	dUserSetINT(PlayerName2(playerid)).("y1",floatround(y));
	dUserSetINT(PlayerName2(playerid)).("z1",floatround(z));
    dUserSetINT(PlayerName2(playerid)).("interior1",interior);
//==============================================================================
	new weap1, ammo1, weap2, ammo2, weap3, ammo3, weap4, ammo4, weap5, ammo5, weap6, ammo6;
	GetPlayerWeaponData(playerid,2,weap1,ammo1);// hand gun
	GetPlayerWeaponData(playerid,3,weap2,ammo2);//shotgun
	GetPlayerWeaponData(playerid,4,weap3,ammo3);// SMG
	GetPlayerWeaponData(playerid,5,weap4,ammo4);// AK47 / M4
	GetPlayerWeaponData(playerid,6,weap5,ammo5);// rifle
	GetPlayerWeaponData(playerid,7,weap6,ammo6);// rocket launcher
   	dUserSetINT(PlayerName2(playerid)).("weap1",weap1); dUserSetINT(PlayerName2(playerid)).("weap1ammo",ammo1);
  	dUserSetINT(PlayerName2(playerid)).("weap2",weap2);	dUserSetINT(PlayerName2(playerid)).("weap2ammo",ammo2);
  	dUserSetINT(PlayerName2(playerid)).("weap3",weap3);	dUserSetINT(PlayerName2(playerid)).("weap3ammo",ammo3);
	dUserSetINT(PlayerName2(playerid)).("weap4",weap4); dUserSetINT(PlayerName2(playerid)).("weap4ammo",ammo4);
  	dUserSetINT(PlayerName2(playerid)).("weap5",weap5);	dUserSetINT(PlayerName2(playerid)).("weap5ammo",ammo5);
	dUserSetINT(PlayerName2(playerid)).("weap6",weap6); dUserSetINT(PlayerName2(playerid)).("weap6ammo",ammo6);
//==============================================================================
	new	Float:health;	GetPlayerHealth(playerid, Float:health);
	new	Float:armour;	GetPlayerArmour(playerid, Float:armour);
	new year,month,day;	getdate(year, month, day);
	new strdate[20];	format(strdate, sizeof(strdate), "%d.%d.%d",day,month,year);
	new file[256]; 		format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(PlayerName2(playerid)) );
//==============================================================================
	dUserSetINT(PlayerName2(playerid)).("health",floatround(health));
    dUserSetINT(PlayerName2(playerid)).("armour",floatround(armour));
	dini_Set(file,"LastOn",strdate);
	dUserSetINT(PlayerName2(playerid)).("loggedin",0);
	dUserSetINT(PlayerName2(playerid)).("TimesOnServer",(dUserINT(PlayerName2(playerid)).("TimesOnServer"))+1);
}
//==============================================================================
#if defined USE_MENUS
//==============================================================================
#endif
//==============================================================================
#if defined DISPLAY_CONFIG
stock ConfigInConsole()
{
	print(" ________ Configuration ___________\n");
	print(" __________ Chat & Messages ______");
	if(ServerInfo[AntiSwear] == 0) print("  Anti Swear:              Disabled "); else print("  Anti Swear:             Enabled ");
	if(ServerInfo[AntiSpam] == 0)  print("  Anti Spam:               Disabled "); else print("  Anti Spam:              Enabled ");
	if(ServerInfo[ReadCmds] == 0)  print("  Read Cmds:               Disabled "); else print("  Read Cmds:              Enabled ");
	if(ServerInfo[ReadPMs] == 0)   print("  Read PMs:                Disabled "); else print("  Read PMs:               Enabled ");
	if(ServerInfo[ConnectMessages] == 0) print("  Connect Messages:        Disabled "); else print("  Connect Messages:       Enabled ");
  	if(ServerInfo[AdminCmdMsg] == 0) print("  Admin Cmd Messages:     Disabled ");  else print("  Admin Cmd Messages:     Enabled ");
	if(ServerInfo[ReadPMs] == 0)   print("  Anti capital letters:    Disabled \n"); else print("  Anti capital letters:   Enabled \n");
	print(" __________ Skins ________________");
	if(ServerInfo[AdminOnlySkins] == 0) print("  AdminOnlySkins:         Disabled "); else print("  AdminOnlySkins:         Enabled ");
	printf("  Admin Skin 1 is:         %d", ServerInfo[AdminSkin] );
	printf("  Admin Skin 2 is:         %d\n", ServerInfo[AdminSkin2] );
	print(" ________ Server Protection ______");
	if(ServerInfo[AntiBot] == 0) print("  Anti Bot:                Disabled "); else print("  Anti Bot:                Enabled ");
	if(ServerInfo[NameKick] == 0) print("  Bad Name Kick:           Disabled\n"); else print("  Bad Name Kick:           Enabled\n");
	print(" __________ Ping Control _________");
	if(ServerInfo[MaxPing] == 0) print("  Ping Control:            Disabled"); else print("  Ping Control:            Enabled");
	printf("  Max Ping:                %d\n", ServerInfo[MaxPing] );
	print(" __________ Players ______________");
	if(ServerInfo[GiveWeap] == 0) print("  Save/Give Weaps:         Disabled"); else print("  Save/Give Weaps:         Enabled");
	if(ServerInfo[GiveMoney] == 0) print("  Save/Give Money:         Disabled\n"); else print("  Save/Give Money:         Enabled\n");
	print(" __________ Other ________________");
	printf("  Max Admin Level:         %d", ServerInfo[MaxAdminLevel] );
	if(ServerInfo[Locked] == 0) print("  Server Locked:           No"); else print("  Server Locked:           Yes");
	if(ServerInfo[AutoLogin] == 0) print("  Auto Login:             Disabled\n"); else print("  Auto Login:              Enabled\n");
}
//==============================================================================
#endif
//==============================================================================
stock UpdateConfig()
{
	new file[256], File:file2, string[100]; format(file,sizeof(file),"ladmin/config/Config.ini");
	ForbiddenWordCount = 0;
	BadNameCount = 0;
	BadPartNameCount = 0;
	
	if(!dini_Exists("ladmin/config/aka.txt")) dini_Create("ladmin/config/aka.txt");
	
	if(!dini_Exists(file))
	{
		dini_Create(file);
		print("\n >Configuration File Successfully Created");
	}
//==============================================================================
	if(!dini_Isset(file,"MaxPing")) dini_IntSet(file,"MaxPing",1200);
	if(!dini_Isset(file,"ReadPms")) dini_IntSet(file,"ReadPMs",1);
	if(!dini_Isset(file,"ReadCmds")) dini_IntSet(file,"ReadCmds",1);
	if(!dini_Isset(file,"MaxAdminLevel")) dini_IntSet(file,"MaxAdminLevel",5);
	if(!dini_Isset(file,"AdminOnlySkins")) dini_IntSet(file,"AdminOnlySkins",0);
	if(!dini_Isset(file,"AdminSkin")) dini_IntSet(file,"AdminSkin",217);
	if(!dini_Isset(file,"AdminSkin2")) dini_IntSet(file,"AdminSkin2",214);
	if(!dini_Isset(file,"AntiBot")) dini_IntSet(file,"AntiBot",1);
	if(!dini_Isset(file,"AntiSpam")) dini_IntSet(file,"AntiSpam",1);
	if(!dini_Isset(file,"AntiSwear")) dini_IntSet(file,"AntiSwear",1);
	if(!dini_Isset(file,"NameKick")) dini_IntSet(file,"NameKick",1);
 	if(!dini_Isset(file,"PartNameKick")) dini_IntSet(file,"PartNameKick",1);
	if(!dini_Isset(file,"NoCaps")) dini_IntSet(file,"NoCaps",0);
	if(!dini_Isset(file,"Locked")) dini_IntSet(file,"Locked",0);
	if(!dini_Isset(file,"SaveWeap")) dini_IntSet(file,"SaveWeap",1);
	if(!dini_Isset(file,"SaveMoney")) dini_IntSet(file,"SaveMoney",1);
	if(!dini_Isset(file,"ConnectMessages")) dini_IntSet(file,"ConnectMessages",1);
	if(!dini_Isset(file,"AdminCmdMessages")) dini_IntSet(file,"AdminCmdMessages",1);
	if(!dini_Isset(file,"AutoLogin")) dini_IntSet(file,"AutoLogin",1);
	if(!dini_Isset(file,"MaxMuteWarnings")) dini_IntSet(file,"MaxMuteWarnings",4);
	if(!dini_Isset(file,"MustLogin")) dini_IntSet(file,"MustLogin",0);
	if(!dini_Isset(file,"MustRegister")) dini_IntSet(file,"MustRegister",0);
//==============================================================================
	if(dini_Exists(file))
	{
		ServerInfo[MaxPing] = dini_Int(file,"MaxPing");
		ServerInfo[ReadPMs] = dini_Int(file,"ReadPMs");
		ServerInfo[ReadCmds] = dini_Int(file,"ReadCmds");
		ServerInfo[MaxAdminLevel] = dini_Int(file,"MaxAdminLevel");
		ServerInfo[AdminOnlySkins] = dini_Int(file,"AdminOnlySkins");
		ServerInfo[AdminSkin] = dini_Int(file,"AdminSkin");
		ServerInfo[AdminSkin2] = dini_Int(file,"AdminSkin2");
		ServerInfo[AntiBot] = dini_Int(file,"AntiBot");
		ServerInfo[AntiSpam] = dini_Int(file,"AntiSpam");
		ServerInfo[AntiSwear] = dini_Int(file,"AntiSwear");
		ServerInfo[NameKick] = dini_Int(file,"NameKick");
		ServerInfo[PartNameKick] = dini_Int(file,"PartNameKick");
		ServerInfo[NoCaps] = dini_Int(file,"NoCaps");
		ServerInfo[Locked] = dini_Int(file,"Locked");
		ServerInfo[GiveWeap] = dini_Int(file,"SaveWeap");
		ServerInfo[GiveMoney] = dini_Int(file,"SaveMoney");
		ServerInfo[ConnectMessages] = dini_Int(file,"ConnectMessages");
		ServerInfo[AdminCmdMsg] = dini_Int(file,"AdminCmdMessages");
		ServerInfo[AutoLogin] = dini_Int(file,"AutoLogin");
		ServerInfo[MaxMuteWarnings] = dini_Int(file,"MaxMuteWarnings");
		ServerInfo[MustLogin] = dini_Int(file,"MustLogin");
		ServerInfo[MustRegister] = dini_Int(file,"MustRegister");
		print("\n -Configuration Settings Loaded");
	}
//==============================================================================
	if((file2 = fopen("ladmin/config/ForbiddenNames.cfg",io_read)))
	{
		while(fread(file2,string))
		{
		    for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            BadNames[BadNameCount] = string;
            BadNameCount++;
		}
		fclose(file2);	printf(" -%d Forbidden Names Loaded", BadNameCount);
	}

//==============================================================================
	if((file2 = fopen("ladmin/config/ForbiddenPartNames.cfg",io_read)))
	{
		while(fread(file2,string))
		{
		    for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            BadPartNames[BadPartNameCount] = string;
            BadPartNameCount++;
		}
		fclose(file2);	printf(" -%d Forbidden Tags Loaded", BadPartNameCount);
	}
//==============================================================================
	if((file2 = fopen("ladmin/config/ForbiddenWords.cfg",io_read)))
	{
		while(fread(file2,string))
		{
		    for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            ForbiddenWords[ForbiddenWordCount] = string;
            ForbiddenWordCount++;
		}
		fclose(file2);	printf(" -%d Forbidden Words Loaded", ForbiddenWordCount);
	}
}
//==============================================================================
forward SaveToFile(filename[],text[]);
//==============================================================================
public SaveToFile(filename[],text[])
{
	#if defined SAVE_LOGS
	new File:LAdminfile, filepath[256], string[256], year,month,day, hour,minute,second;
	getdate(year,month,day); gettime(hour,minute,second);
	
	format(filepath,sizeof(filepath),"ladmin/logs/%s.txt",filename);
	LAdminfile = fopen(filepath,io_append);
	format(string,sizeof(string),"[%d.%d.%d %d:%d:%d] %s\r\n",day,month,year,hour,minute,second,text);
	fwrite(LAdminfile,string);
	fclose(LAdminfile);
	#endif
	
	return 1;
}
//==============================================================================
