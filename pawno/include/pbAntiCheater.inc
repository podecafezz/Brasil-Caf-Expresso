////////////////////////////////////////////////////////////////////////////////
//
//
//        #### ########   ######     ######## ########    ###    ##     ##
//         ##  ##     ## ##    ##       ##    ##         ## ##   ###   ###
//         ##  ##     ## ##             ##    ##        ##   ##  #### ####
//         ##  ########   ######        ##    ######   ##     ## ## ### ##
//         ##  ##              ##       ##    ##       ######### ##     ##
//         ##  ##        ##    ##       ##    ##       ##     ## ##     ##
//        #### ##         ######        ##    ######## ##     ## ##     ##
//
//
//          Por Bruno da Silva (iPs DraKiNs) e  Paulo (iPs Paulo)
//
//          Acesse meu blog sobre programa��o www.brunodasilva.com.br
//
//			--------------------------------------------
//
//			Detectar:
//				Bot,
//				Death Flood,
//				Surf Vehicle,
//				Car Teleport,
//				State Hack,
//				No-Reload,
//				Weapon Hack,
//				Ammo Hack,
//				Freeze Hack,
//				Score Hack,
//				Money Hack,
//				Publish Text,
//				Offend Text,
//				Flood Text,
//				Teleport Hack,
//				Air Break,
//				Player Bugger,
//				High Ping,
//				Spider Hack,
//				CP Race Hack,
//				Speed Hack,
//				Player Speed Hack,
//				Fly Hack
//
//			--------------------------------------------
//
//					www.brunodasilva.com.br
//
//					Ingresse tamb�m na [iPs]TeaM
//					wwww.ips-team.forumeiros.com
//
//////////////////////////////////////////////////////////////////////////////////

enum {
	// Anti DDos Bots
	PLAYER_BOT_LEVEL3,
	PLAYER_BOT_LEVEL2,
	PLAYER_BOT_LEVEL1,

	// Anti Cleo4 Fake-kill
	PLAYER_DEATHFLOOD_LEVEL3,
	PLAYER_DEATHFLOOD_LEVEL2,
	PLAYER_DEATHFLOOD_LEVEL1,

	// Anti Bug Cars
	PLAYER_SURF_VEHICLE,
	PLAYER_CAR_TELEPORT,
	PLAYER_STATE_HACK,

	// Ammo Weapon
	PLAYER_NORELOAD_HACK,
	PLAYER_WEAPON_HACK,
	PLAYER_AMMO_HACK,


	// hackings
	PLAYER_FREEZE_HACK,
	PLAYER_SCORE_HACK,
	PLAYER_MONEY_HACK,

	// Text Chat
	PLAYER_PUBLISH_TEXT,
	PLAYER_OFFEND_TEXT,
	PLAYER_FLOOD_TEXT,

	// pos cheat
	PLAYER_TELEPORT_HACK,
	PLAYER_AIRBREAK_HACK,
	PLAYER_BUGGER_HACK,

	// outros
	PLAYER_HIGH_PING,
	PLAYER_SPIDER_HACK,
	PLAYER_CPRACE_HACK,
	PLAYER_SPEED_HACK,
	PLAYER_PSPEED_HACK,
	PLAYER_FLY_HACK
}


new connect = -1,
	Float: g_ucPos[4],
	databaseIP[MAX_PLAYERS][20],
	Float:g_diferencasAngle[MAX_VEHICLES],
	vehVelocity[MAX_VEHICLES],
	bool: vehRespawn[MAX_VEHICLES],
	bool: pOPC,
	bool: pOPS,
	bool: pOPDI,
	bool: pOPT,
	bool: pOPD,
	bool: pOVM,
	bool: pOPERCP,
	bool: pOPU,
	bool: pOPSC,
	bool: pOUVU;

forward OnPlayerHacking(playerid, hackid);

#define INVALID_CHAT_BLOCK
#define SERVER_SIDE_DELAY   (0002)
#define MAX_DISTANCE_DEF    (83.1)
#define MAX_PING            (0800)


// =============================================================================
//
// OBSERVA��ES IMPORTANTES:

// #define INVALID_CHAT_BLOCK
// Em caso de n�o quiser bloquear o texto em caso de texto inv�lido
// Texto inv�lido, spam, flood, palavreado, ofensa, publica��o. etc

// Ping acima de 1 segundo (1000 ms) poder� ocorrer graves problemas de precis�o no anti cheater.
// Em caso de ping muito elevado aconselha-se o uso de SERVER_SIDE_DELAY elevado para maior precis�o

// SERVER_SIDE_DELAY equivale ao tempo de delay entre o uso de uma fun��o registrada
// que influencia no detectamento do anti cheater. Aconselh�vel 1 a 5 segundos.
// Dependendo da conex�o do servidor voc� coloca maior delay ou menor dealay

// MAX_DISTANCE_DEF � essencial para busca e detec��o de anti-teleport e air break
// O n�mero padr�o foi calculado e n�o houve bugs por parte do sistema
// A �nica coisa que pode influenciar ser� o sistema de SetPlayerPos. Mas o SERVER_SIDE_DELAY supriu isto com precis�o

// Este sistema apenas detecta cheaters. � aconselhav�l a checagem de um administrador real antes de aplicar o banimento.

// ========================================================================================================

#define pFunction%0(%1) %0(%1); public%0(%1)
#define Hook%0(%1)  stock%0_Ex(%1)

// ---------------------------------------------
//  Nesta parte aparecem fun��es hookeadas
//  Elas s�o essenciais para ter controle server-side detalhado
//  Essencial para qualquer anti-hack. Controle minucioso
//  Para o funcionamento disto precisa do filterscript
//	Hookei apenas as mais importantes callbacks nativas da sa:mp.
//	Daria muito trabalho "hookear" todas
// ---------------------------------------------


Hook GivePlayerMoney(playerid, value) {
	return SetPVarInt(playerid, #registerMoney, (GetPVarInt(playerid, #registerMoney) + value)), GivePlayerMoney(playerid, value);
}

Hook ResetPlayerMoney(playerid) {
	return SetPVarInt(playerid, #registerMoney, 0), ResetPlayerMoney(playerid);
}

Hook SetPlayerScore(playerid, value){
	return SetPVarInt(playerid, #registerScore, value), SetPlayerScore(playerid, value);
}

Hook PutPlayerInVehicle(playerid,vehicleid, seatid) {
	return SetPVarInt(playerid, #registerState, (gettime() - SERVER_SIDE_DELAY)), PutPlayerInVehicle(playerid, vehicleid, seatid);
}

Hook SetVehicleVelocity(vehicleid, Float: pX, Float: pY, Float: pZ) {
	return vehVelocity[vehicleid] = gettime(), SetVehicleVelocity(vehicleid, pX, pY, pZ);
}

Hook SetPlayerPos(playerid, Float: pX, Float: pY, Float: pZ) {
	return SetPVarInt(playerid, #tPosSet, gettime()), SetPlayerPos(playerid, pX, pY, pZ);
}

Hook GivePlayerWeapon(playerid, weaponid, ammo) {
	return SetPVarInt(playerid, getSlotID(pGetWeaponSlot(weaponid)), weaponid), SetPVarInt(playerid, getSlotAmmoID(pGetWeaponSlot(weaponid)), ammo), GivePlayerWeapon(playerid, weaponid, ammo);
}

Hook ResetPlayerWeapons(playerid) {
	for(new i; i != 13; ++i) SetPVarInt(playerid, getSlotID(i), 0);
	return ResetPlayerWeapons(playerid);
}

Hook TogglePlayerC(playerid, bool: control) {
	if(control) {
		static Float: pX, Float: pY, Float: pZ;

		GetPlayerPos(playerid, pX, pY, pZ);
		SetPVarFloat(playerid, "xPosControll", pX),
		SetPVarFloat(playerid, "yPosControll", pY),
		SetPVarFloat(playerid, "zPosControll", pZ);
	} else {
		SetPVarFloat(playerid, "xPosControll", 0.0);
		SetPVarFloat(playerid, "yPosControll", 0.0);
		SetPVarFloat(playerid, "zPosControll", 0.0);
	}
	TogglePlayerControllable(playerid, control);
	return SetPVarInt(playerid, "PlayerControllable", _:!control);
}

Hook SetPlayerHealth(playerid, Float:health) {
	return SetPVarFloat(playerid,"healthServerside", health), SetPlayerHealth(playerid, health);
}

Hook SetPlayerArmour(playerid, Float:armour) {
	return SetPVarFloat(playerid,"armourServerside", armour), SetPlayerArmour(playerid, armour);
}

Hook SetVehicleToRespawn(vehicleid) {
	return vehRespawn[vehicleid] = true, SetVehicleToRespawn(vehicleid);
}

IsPlayerAiming(playerid) {
	new Anim = GetPlayerAnimationIndex(playerid);
	if(((Anim >= 1160) && (Anim <= 1163)) || (Anim == 1167) || (Anim == 1365) || (Anim == 1643) || (Anim == 1453) || (Anim == 220)) return 1;
	return 0;
}

IsPlayerInWater(playerid) { //Coords By Synchro
	static Float:fX, Float:fY, Float:fZ; GetPlayerPos(playerid, fX, fY, fZ);
	if((fX >= 2044.6 && fX <= 2192.984 && fY >= 1206.358 && fY <= 1376.552) && fZ < 0xA) return 1;
	else if((fX >= 2048.504 && fX <= 2185.174 && fY >= 1063.239 && fY <= 1202.49) && fZ < 0xA) return 1;
	else if((fX >= 2204.698 && fX <= 2204.698 && fY >= 1426.837 && fY <= 1430.705) && fZ < 0xA) return 1;
	else if((fX >= 2032.885 && fX <= 2114.887 && fY >= 1852.325 && fY <= 1991.575) && fZ < 0xC) return 1;
	else if((fX >= 2517.086 && fX <= 2606.897 && fY >= 2316.493 && fY <= 2420.93) && fZ < 0x16) return 1;
	else if((fX >= 2554.5996 && fX <= 2507.7683 && fY >= 1548.6178 && fY <= 1588.9154) && fZ < 0xF) return 1;
	else if((fX >= -2043.628 && fX <= -1973.561 && fY >= -980.9415 && fY <= -724.0283) && fZ < 0x20) return 1;
	else if((fX >= -2753.912 && fX <= -2665.071 && fY >= -522.3632 && fY <= -380.3444) && fZ < 0x05) return 1;
	else if((fX >= 1219.864 && fX <= 1292.118 && fY >= -2435.881 && fY <= -2325.344) && fZ < 0xF) return 1;
	else if((fX >= 1923.388 && fX <= 2010.854 && fY >= -1223.924 && fY <= -1168.656) && fZ < 0x16) return 1;
	else if((fX >= 1269.301 && fX <= 1314.935 && fY >= -837.0452 && fY <= -781.7769) && fZ < 0x5A) return 1;
	else if((fX >= 1087.3953 && fX <= 1102.3138 && fY >= -682.6734 && fY <= -663.0043) && fZ < 0x71) return 1;
	else if((fX >= 1268.6118 && fX <= 1291.8774 && fY >= -784.2910 && fY <= -764.6104) && fZ < 0x43D) return 1;
	else if(fZ < 0xF) return 1;
	return 0;
}

IsPlayerUsingSwimAnim(playerid) { // By Synchro
	if(IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 0;
	static animlib[32], animname[32];
	GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,animname,32);
	if(!strcmp(animlib, "SWIM", true) && !strcmp(animname, "SWIM_GLIDE", true)) return 1;
	else if(!strcmp(animlib, "SWIM", true) && !strcmp(animname, "SWIM_BREAST", true)) return 1;
	else if(!strcmp(animlib, "SWIM", true) && !strcmp(animname, "SWIM_CRAWL", true)) return 1;
	else if(!strcmp(animlib, "SWIM", true) && !strcmp(animname, "SWIM_DIVE_UNDER", true)) return 1;
	else if(!strcmp(animlib, "SWIM", true) && !strcmp(animname, "SWIM_DIVE_GLIDE", true)) return 1;
	else if(!strcmp(animlib, "SWIM", true) && !strcmp(animname, "SWIM_UNDER", true)) return 1;
	else if(!strcmp(animlib, "SWIM", true) && !strcmp(animname, "SWIM_TREAD", true)) return 1;
	return 0;
}

getSlotID(i) { // Paulor
	static stringSlot[12];
	return format(stringSlot, 12, "wHSlot%i", i), stringSlot;
}

getSlotAmmoID(i) { // Paulor
	static stringSlot[12];
	return format(stringSlot, 12, "AmmoSlot%i", i), stringSlot;
}

pGetWeaponSlot(weaponid) { // Paulor
	if(weaponid >= 0 && weaponid < 2) return 0;
	else if(weaponid > 1 && weaponid < 10) return 1;
	else if(weaponid > 21 && weaponid < 25) return 2;
	else if(weaponid > 24 && weaponid < 28) return 3;
	else if(weaponid > 27 && weaponid < 30 || weaponid == 32) return 4;
	else if(weaponid > 29 && weaponid < 32) return 5;
	else if(weaponid > 32 && weaponid < 35) return 6;
	else if(weaponid > 34 && weaponid < 39) return 7;
	else if(weaponid > 15 && weaponid < 19 || weaponid == 39) return 8;
	else if(weaponid > 40 && weaponid < 44) return 9;
	else if(weaponid > 9 && weaponid < 16) return 10;
	else if(weaponid > 43 && weaponid < 47) return 11;
	else if(weaponid == 40) return 12;
	return -1;
}

GetPlayerSpeedANTIHACK(playerid) {
	static Float: ST[3];
	GetVehicleVelocity(GetPlayerVehicleID(playerid), ST[0], ST[1], ST[2]);
	return floatround(floatmul(floatsqroot(floatadd(floatpower(ST[0], 2), floatpower(ST[1], 2))), 170.0));
}

#if !defined varGet
#define varGet(%0)	getproperty(0,%0)
#endif

#if !defined varSet
#define varSet(%0,%1) setproperty(0, %0, %1)
#endif

public OnGameModeInit() {
	pOPC = funcidx(#ExOnPlayerConnect) != -1;
	pOPS = funcidx(#ExOnPlayerSpawn) != -1;
	pOPDI = funcidx(#ExOnPlayerDisconnect) != -1;
	pOPT = funcidx(#ExOnPlayerText) != -1;
	pOPD = funcidx(#ExOnPlayerDeath) != -1;
	pOVM = funcidx(#ExOnVehicleMod) != -1;
	pOPERCP = funcidx(#ExOnPlayerEnterRaceCP) != -1;
	pOPU = funcidx(#ExOnPlayerUpdate) != -1;
	pOPSC = funcidx(#ExOnPlayerStateChange) != -1;
	pOUVU = funcidx(#ExOnUnoccupiedVehicleUpdate) != -1;
	return CallLocalFunction(#ExOnGameModeInit, #);
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit ExOnGameModeInit
forward ExOnGameModeInit();

public OnPlayerConnect(playerid) {
	registrarJogador(playerid);
	return (pOPC ? CallLocalFunction("ExOnPlayerConnect", "i", playerid) : 1);
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect ExOnPlayerConnect
forward ExOnPlayerConnect(playerid);

public OnPlayerSpawn(playerid) {
	if(!GetPVarInt(playerid, "pSpawned")) SetPVarInt(playerid, "pSpawned", true);
	return (pOPS ? CallLocalFunction("ExOnPlayerSpawn", "i", playerid) : 1);
}

#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif

#define OnPlayerSpawn ExOnPlayerSpawn
forward ExOnPlayerSpawn(playerid);

public OnPlayerDisconnect(playerid, reason) {
	// N�o retire est� parte. Isto serve para n�o enviar mensagens de desconec��o quando o player � bot ddos
	if(GetPVarInt(playerid, #jogadorDisponivel)) return false;
	return (pOPDI ? CallLocalFunction("ExOnPlayerDisconnect", "is", playerid, reason) : 1);
}

#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect ExOnPlayerDisconnect
forward ExOnPlayerDisconnect(playerid,reason);

new const palavreado[][24] = {
	"daputa", "babaca", "baitola", "piranha", "bicha", "bichona", "biscat", "bitch", "bix", "boiola", "boiolona", "buceta", "bucetudo", "cuzona", "bund", "burr", "fude", "cacet", "viad",
	"caral", "vadi", "carai", "rola", "chup", "idiot", "corno", "nocu", "eucu", "ocu", "cusa", "cusi", "cuza", "cuzinho", "piroca", "embecil", "fdp", "foda", "fode", "fuck", "fud", 
	"hetard", "homo", "imbess", "jegu", "kacet", "karai", "karaleo", "kct", "kral", "krl", "noku", "lasarent", "lazarent", "mula", "otari", "pnc", "pereb", "penis","pint", "prosti",
	"punhet", "put", "retardado", "tnc", "viad", "viadi", "vsf", "vtnc", "sobe", "vogelz", "baranga", "vagab", "broxa", "ignorant", "comed", "ejacu", "prosti", "cachorr", "surub", "peni",
	"chup", "pau", "viad", "perere", "bucet", "bicha", "bixa", "gay", "desgra", "troxa", "tomanocu", "seucu"
};

public OnPlayerText(playerid, text[]) {

	/*--------------------------------------------------
	*
	*  Anti Publica��o de IP Inteligente
	*   Usando OnPlayerText com manipula��o de strings e outros
	*   A precis�o deste sistema est� em torno de 95%
	*
	* Detecta: 127.0.0.1 | 1 2    7 .   0  0 1 etc
	-------------------------------------------------*/

	static szText[128], numerosNochat, pontosNochat, j;

	numerosNochat = -1, pontosNochat = -1, j = 0, szText[0] = EOS;

	for(new i; text[i]; i++) {

		if(text[i] >= '0' && '9' >= text[i] || (text[i] == '.' || text[i] == ':')) {
			if(text[i] == '.' || text[i] == ':') pontosNochat++;
			else numerosNochat++;
			if(numerosNochat >= 8 && pontosNochat >= 3) {
				CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_PUBLISH_TEXT);
				#if defined INVALID_CHAT_BLOCK
				return false;
				#else
				break;
				#endif
			}
		}

		switch(text[i]) {
			case '0':{ szText[j] = 'o'; j++; continue; }
			case '1':{ szText[j] = 'i'; j++; continue; }
			case '2':{ szText[j] = 'z'; j++; continue; }
			case '3':{ szText[j] = 'e'; j++; continue; }
			case '4':{ szText[j] = 'a'; j++; continue; }
			case '5':{ szText[j] = 's'; j++; continue; }
			case '6':{ szText[j] = 'g'; j++; continue; }
			case '7':{ szText[j] = 't'; j++; continue; }
			case '8':{ szText[j] = 'b'; j++; continue; }
			case 65 .. 90, 97 .. 122: { szText[j] = tolower(text[i]); j++; continue; }
		}
	}

	/*--------------------------------------------------
	*
	*  Anti Palavreado Inteligente
	*   Usando OnPlayerText com manipula��o de strings e outros
	*   A precis�o deste sistema est� em torno de 85%
	*
	* Detecta: buceta, b - u c |e t-a, buc 3 7 4 etc
	-------------------------------------------------*/

	for(new i = 0; i < sizeof(palavreado); i++) {
		if(strfind(szText, palavreado[i], false) != -1) {
			CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_OFFEND_TEXT);

			#if defined INVALID_CHAT_BLOCK
			return false;
			#else
			break;
			#endif
		}
	}

	/*--------------------------------------------------
	*
	*  Anti Flood
	*   Usando OnPlayerText com gettime e outros
	*   A precis�o deste sistema est� em torno de 95%
	*
	-------------------------------------------------*/

	if((gettime() - GetPVarInt(playerid, #floodChat)) < 3) {
		CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_FLOOD_TEXT);
		#if defined INVALID_CHAT_BLOCK
		return false;
		#endif
	}

	SetPVarInt(playerid, #floodChat, gettime());
	return (pOPT ? CallLocalFunction("ExOnPlayerText", "is", playerid, text) : 1);
}

#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif

#define OnPlayerText ExOnPlayerText
forward ExOnPlayerText(playerid, text[]);

pFunction resetBot(o) {
	varSet(databaseIP[o], 0);
	return databaseIP[o][0] = EOS;
}

pFunction registerBot(p) {

	/*--------------------------------------------------
	*
	*  Anti DDos Bots
	*   Usando GetPlayerPing/OnPlayerConnect com gettime e outros
	*   A precis�o deste sistema est� dividido em partes
	*
	*  PLAYER_BOT_LEVEL1 -> 70%
	*  PLAYER_BOT_LEVEL2 -> 90%
	*  PLAYER_BOT_LEVEL3 -> 100%
	*
	*
	-------------------------------------------------*/

	if(GetPlayerPing(p) != 0xFFFF && GetPlayerPing(p)  != 0) SetPVarInt(p, #jogadorDisponivel, 1);
	if(IsPlayerConnected(p) && GetPlayerPing(p)  == 0xFFFF) {
		static tmpip[20];
		GetPlayerIp(p, tmpip, 20);
		if(0x1c5 > (gettime() - varGet(tmpip))) {
			tmpip[(strlen(tmpip) - 1)] = 'x';
			if(varGet(tmpip) > 3) {
				return CallLocalFunction("OnPlayerHacking", "ii", p, PLAYER_BOT_LEVEL3);
			}
			CallLocalFunction("OnPlayerHacking", "ii", p, PLAYER_BOT_LEVEL2);
		}
		CallLocalFunction("OnPlayerHacking", "ii", p, PLAYER_BOT_LEVEL1);
		SetTimerEx("registerBot", 700, false, #i , p);
	}
	return false;
}

pFunction registrarJogador(playerid) {
	static tmpip[20];

	g_diferencasAngle[playerid] = 0;
	GetPlayerIp(playerid, tmpip, 20);
	varSet(tmpip, gettime()); ++connect;

	if(connect == MAX_PLAYERS - 1) {
		for(connect = 0; databaseIP[connect][0]; connect++) continue;
	}
	SetTimerEx("resetBot", 50000, false, "i", connect);

	tmpip[strlen(tmpip)-1] = 'x';
	format(databaseIP[connect], 20, tmpip);
	varSet(tmpip, varGet(tmpip) +1);

	SetPVarInt(playerid, #tPosSet, gettime());
	return SetTimerEx("registerBot", 700, false, #i , playerid);
}

public OnPlayerDeath(playerid,killerid,reason) {

	/*--------------------------------------------------
	*
	*  Anti Fake Kill
	*   Usando OnPlayerDeath com gettime e outros
	*   A precis�o deste sistema est� dividido em partes
	*
	*  PLAYER_DEATHFLOOD_LEVEL1 -> 070%
	*  PLAYER_DEATHFLOOD_LEVEL2 -> 090%
	*  PLAYER_DEATHFLOOD_LEVEL3 -> 100%
	*
	*
	-------------------------------------------------*/

	if(gettime() - GetPVarInt(playerid, #registerDeath) < 20) {
		if(GetPVarInt(playerid, #registerValDeath) > 15) {
			CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_DEATHFLOOD_LEVEL1);
		}
		if(gettime() - GetPVarInt(playerid, #registerDeath) < 2) {
			CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_DEATHFLOOD_LEVEL2);
		}
		if(gettime() - GetPVarInt(playerid, #registerDeath) < 5) {
			if(GetPVarInt(playerid, #registerValDeath) > 3) {
				CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_DEATHFLOOD_LEVEL3);
			}
		}
	}
	SetPVarInt(playerid, #registerDeath, gettime());
	SetPVarInt(playerid, #registerValDeath, GetPVarInt(playerid, #registerValDeath) +1);

	return (pOPD ? CallLocalFunction("ExOnPlayerDeath", "i", playerid) : 1);
}

#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif

#define OnPlayerDeath ExOnPlayerDeath
forward ExOnPlayerDeath(playerid, killerid, reason);

public OnVehicleMod(playerid, vehicleid, componentid) {
	if(!GetPlayerInterior(playerid)) {
		CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_CPRACE_HACK);
	}
	return (pOVM ? CallLocalFunction("ExOnVehicleMod", "ddd", playerid, vehicleid, componentid) : 1);
}

#if defined _ALS_OnVehicleMod
	#undef OnVehicleMod
#else
	#define _ALS_OnVehicleMod
#endif

#define OnVehicleMod ExOnVehicleMod
forward ExOnVehicleMod(playerid,vehicleid,componentid);

public OnPlayerEnterRaceCheckpoint(playerid) {
	if(IsPlayerInAnyVehicle(playerid)) {
		if(!GetPlayerSpeedANTIHACK(playerid)) {
			if(GetPVarInt(playerid, #checkHack) > 3) {
				CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_CPRACE_HACK);
				SetPVarInt(playerid, #checkHack, 0);
			}
			SetPVarInt(playerid, #checkHack, GetPVarInt(playerid, #checkHack)+1);
		}
	}
	return (pOPERCP ? CallLocalFunction("ExOnPlayerEnterRaceCP", "i", playerid) : 1);
}

#if defined _ALS_OnPlayerEnterRaceCP
	#undef OnPlayerEnterRaceCheckpoint
#else
	#define _ALS_OnPlayerEnterRaceCP
#endif

#define OnPlayerEnterRaceCheckpoint ExOnPlayerEnterRaceCP
forward ExOnPlayerEnterRaceCP(playerid);

public OnPlayerUpdate(playerid) {
	if(!IsPlayerNPC(playerid)) {
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {

			/*--------------------------------------------------
			*
			*  Anti Speed Hack
			*   Usando GetPlayerSpeedANTIHACK com vari�veis
			*   A precis�o deste sistema fica em torno de 100%
			*
			-------------------------------------------------*/

			if(GetPVarInt(playerid, #checkSpeedtime)) {
				if(gettime() - GetPVarInt(playerid, #checkSpeedtime) > 1) {
					TogglePlayerControllable(playerid, true);
					SetPVarInt(playerid, "checkSpeedtime", 0);
				}
			}
			if(GetPlayerSpeedANTIHACK(playerid) > 260) {
				if((gettime() - vehVelocity[GetPlayerVehicleID(playerid)]) > 10) {
					TogglePlayerControllable(playerid, false);
					SetPVarInt(playerid, "checkSpeedtime", gettime());
					return CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_SPEED_HACK), true;
				}
			}

			/*--------------------------------------------------
			*
			*  Anti Spider Car
			*   Usando GetVehicleRotationQuat
			*   A precis�o deste sistema fica em torno de 75%
			*
			-------------------------------------------------*/

			static Float:w, Float:x, Float:y, Float:z;

			GetVehicleRotationQuat(GetPlayerVehicleID(playerid), w, x, y, z);

			w = atan2(2*((y*z)+(x*w)), (-(x*x) -(y*y) +(z*z) +(w*w)));

			// OBS: Inclina��o de 5 graus. Constru��es mais inclinadas podem
			// fazer o ve�culo inclinar mais. Mas para evitar falsos reports deixe mais ou menos este valor

			if((85.0 < w < 90.0) || (-85.0 > w > -90.0)) {
				SetPVarInt(playerid, #spiderCar, GetPVarInt(playerid, #spiderCar) +1);
				if(GetPVarInt(playerid, #spiderCar) > 40) {
					CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_SPIDER_HACK);
					SetPVarInt(playerid, #spiderCar, 0);
				}
			}
		}

		/*--------------------------------------------------
		*
		*  Anti Player Bugger
		*   Usando GetPlayerPos com vari�veis server sided
		*   A precis�o deste sistema fica em torno de 99%
		*   Desbuga o jogador bugado e envia mensagem aos administradores
		*
		-------------------------------------------------*/

		static Float:x, Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);

		if(x > 0xdbb9f && y > 0xdbb9f && z > 0xdbb9f) {
			SetTimerEx("VerifBugger", 250, false, "i", playerid);
		}

		/*--------------------------------------------------
		*
		*  Anti Freeze Hack
		*   Usando GetPlayerPos com vari�veis server sided
		*   A precis�o deste sistema fica em torno de 90%
		*
		-------------------------------------------------*/

		else {
			// checar se realmente est� est� como MOVIMENTO FALSE
			if(!GetPVarInt(playerid, "PlayerControllable")) {
				GetPlayerPos(playerid, x, y, z);

				// Checar seus controle foram realmente bloqueados para diferentes de zero !

				if(GetPVarFloat(playerid,"xPosControll") && GetPVarFloat(playerid,"yPosControll") && GetPVarFloat(playerid,"zPosControll")) {
					if((GetPVarFloat(playerid,"xPosControll") != x) ||  (GetPVarFloat(playerid,"yPosControll") != y) || (GetPVarFloat(playerid,"zPosControll") != z)) {

						CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_FREEZE_HACK);

						// liberar jogador
						SetPVarInt(playerid, "PlayerControllable", 1);
					}
				}
			}

			GetPlayerPos(playerid, x, y, z);
			if(GetPVarFloat(playerid,"xposSet") != 0 && GetPVarFloat(playerid,"yposSet") != 0 && GetPVarFloat(playerid,"zposSet") != 0) {
				new Float:MAX_DISTANCE = MAX_DISTANCE_DEF;

				x = GetPVarFloat(playerid,"xposSet") - x;
				y = GetPVarFloat(playerid,"yposSet") - y;
				z = GetPVarFloat(playerid,"zposSet") - z;

				if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID) {
					MAX_DISTANCE = 7.0;
				}
				if((x > MAX_DISTANCE || x < -MAX_DISTANCE ) || (y > MAX_DISTANCE  || y < -MAX_DISTANCE ) ||  (z > MAX_DISTANCE  || z < -MAX_DISTANCE )) {
					if((gettime() - GetPVarInt(playerid, #tPosSet)) > 3 && GetPVarInt(playerid,"pSpawned")) {
						GetPlayerPos(playerid, x, y, z);
						SetTimerEx(#pCheckPos, 500, false, "ifff", playerid, x, y, z);
					}
				}
				MAX_DISTANCE = MAX_DISTANCE_DEF;
			}

			GetPlayerPos(playerid, x, y, z);

			SetPVarFloat(playerid,"xposSet", x);
			SetPVarFloat(playerid,"yposSet", y);
			SetPVarFloat(playerid,"zposSet", z);
		}

		/*--------------------------------------------------
		*
		*  Anti Ping Alto
		*   Usando GetPlayerScore com vari�veis server sided
		*   A precis�o deste sistema fica em torno de 90%
		*
		-------------------------------------------------*/

		if(GetPlayerPing(playerid) > MAX_PING) {
			CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_HIGH_PING);
		}

		/*--------------------------------------------------
		*
		*  Anti Score Hack
		*   Usando GetPlayerScore com vari�veis server sided
		*   A precis�o deste sistema fica em torno de 100%
		*
		-------------------------------------------------*/

		if(GetPlayerScore(playerid) > GetPVarInt(playerid, #registerScore)) {
			CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_SCORE_HACK);
			SetPlayerScore(playerid, GetPVarInt(playerid, #registerScore));
		}

		/*--------------------------------------------------
		*
		*  Anti Money Hack
		*   Usando GetPlayerMoney com vari�veis server sided
		*   A precis�o deste sistema fica em torno de 100%
		*
		-------------------------------------------------*/

		if(GetPlayerMoney(playerid) > GetPVarInt(playerid, #registerMoney)) {
			CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_MONEY_HACK);
			GivePlayerMoney(playerid, (ResetPlayerMoney(playerid), GetPVarInt(playerid, #registerMoney)));
		}
		
		/*--------------------------------------------------
		*
		*  Anti Player Speed Hack
		*   Usando GetPlayerVelocity com vari�veis server sided
		*   A precis�o deste sistema fica em torno de 95%
		*
		-------------------------------------------------*/
		
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
			new Float: pX, Float: pY, Float: pZ;
			GetPlayerVelocity(playerid, pX, pY, pZ);
			if(floatround(floatsqroot(floatadd(floatpower(pX, 2), floatpower(pY, 2))) * 200) > 100) {
				if(!(GetPVarInt(playerid, #WarnsSpeed) % 50)) {
					CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_PSPEED_HACK);
				}
				SetPVarInt(playerid, #WarnsSpeed, (GetPVarInt(playerid, #WarnsSpeed) + 1));
			}
		}

		/*--------------------------------------------------
		*
		*  Anti Weapons Hack
		*   Usando GetPlayerWeaponData com vari�veis server sided
		*   A precis�o deste sistema fica em torno de 100%
		*
		-------------------------------------------------*/

		static wSlot[2];
		for(new w; w != 13; ++w) {
			GetPlayerWeaponData(playerid, w, wSlot[0], wSlot[1]);
			if(GetPVarInt(playerid, getSlotID(w)) != wSlot[0] && wSlot[0] && wSlot[0] < 47) {
				CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_WEAPON_HACK);
				SetPVarInt(playerid, getSlotID(w), wSlot[0]);
			}
		}
		
		/*--------------------------------------------------
		*
		*  Anti No-Reload
		*   Usando GetPlayerAmmo com vari�veis server sided
		*   A precis�o deste sistema fica em torno de 100%
		*
		-------------------------------------------------*/
		
		static pKey[3];
		GetPlayerKeys(playerid, pKey[0], pKey[1], pKey[2]);
		if(IsPlayerAiming(playerid) && ((pKey[0] & KEY_FIRE) == KEY_FIRE || (pKey[0] & KEY_ACTION) == KEY_ACTION)) {
			if(GetPlayerWeapon(playerid) > 15 && GetPlayerWeapon(playerid) < 43 && GetPlayerAmmo(playerid) == GetPVarInt(playerid, getSlotAmmoID(pGetWeaponSlot(GetPlayerWeapon(playerid)))) && !GetPVarInt(playerid, "PlayerControllable") && !IsPlayerInAnyVehicle(playerid)) {
				SetPVarInt(playerid, #keyWarns, (GetPVarInt(playerid, #keyWarns) + 1));
				if(!(GetPVarInt(playerid, #keyWarns) % 50) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
					CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_NORELOAD_HACK);
				}
			}
			if(GetPlayerWeaponState(playerid) == WEAPONSTATE_RELOADING || GetPlayerAmmo(playerid) < GetPVarInt(playerid, getSlotAmmoID(pGetWeaponSlot(GetPlayerWeapon(playerid))))) SetPVarInt(playerid, #keyWarns, 0);
			SetPVarInt(playerid, getSlotAmmoID(pGetWeaponSlot(GetPlayerWeapon(playerid))), GetPlayerAmmo(playerid));
		}

		/*--------------------------------------------------
		*
		*  Anti Ammo Hack
		*   Usando GetPlayerAmmo com vari�veis server sided
		*   A precis�o deste sistema fica em torno de 100%
		*
		-------------------------------------------------*/

		if(GetPlayerWeapon(playerid) > 15 && GetPlayerWeapon(playerid) < 43) {
			if(GetPlayerAmmo(playerid) > GetPVarInt(playerid, getSlotAmmoID(pGetWeaponSlot(GetPlayerWeapon(playerid))))) {
				if(!IsPlayerInAnyVehicle(playerid)) {
					CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_AMMO_HACK);
				}
			}
			SetPVarInt(playerid, getSlotAmmoID(pGetWeaponSlot(GetPlayerWeapon(playerid))), GetPlayerAmmo(playerid));
		}

		/*--------------------------------------------------
		*
		*   Anti Fly Hack
		*   Usando Posi��es e Anim��es.
		*   A precis�o deste sistema fica em torno de 85%
		*
		-------------------------------------------------*/

		if(!IsPlayerInWater(playerid) && IsPlayerUsingSwimAnim(playerid)) {
			if(!(GetPVarInt(playerid, "FlyTime") % 50)) {
				CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_FLY_HACK);
				SetPVarInt(playerid, "FlyTime", 0);
			}
			SetPVarInt(playerid, "FlyTime", (GetPVarInt(playerid, "FlyTime") + 1));
		} else if(IsPlayerInWater(playerid) && IsPlayerUsingSwimAnim(playerid)) {
			SetPVarInt(playerid, "FlyTime", 0);
		}

		SetPVarInt(playerid, #registerMoney, GetPlayerMoney(playerid));
		SetPVarInt(playerid, #registerScore, GetPlayerScore(playerid));

	}
	return (pOPU ? CallLocalFunction("ExOnPlayerUpdate", "i", playerid) : 1);
}

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif

#define OnPlayerUpdate ExOnPlayerUpdate
forward ExOnPlayerUpdate(playerid);

pFunction pCheckPos(i, Float: pX, Float: pY, Float: pZ) {
	if(gettime() - GetPVarInt(i, #airBreakSet) < 10)
	return false;

	/*--------------------------------------------------
	*
	*  Anti Teleport Hack
	*   Usando GetPlayerPos com vari�veis server sided
	*   A precis�o deste sistema fica em torno de 95%
	*
	-------------------------------------------------*/

	if(IsPlayerInRangeOfPoint(i, 2.012837, pX, pY, pZ)) {
		CallLocalFunction("OnPlayerHacking", "ii", i, PLAYER_TELEPORT_HACK);
	}

	/*--------------------------------------------------
	*
	*  Anti AirBreak Hack
	*   Usando GetPlayerPos e SetPlayerPos com vari�veis server sided
	*   A precis�o deste sistema fica em torno de 95%
	*
	-------------------------------------------------*/

	else {
		CallLocalFunction("OnPlayerHacking", "ii", i, PLAYER_AIRBREAK_HACK);
		SetPVarInt(i, #airBreakSet, gettime());
	}
	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate) {

	/*--------------------------------------------------
	*
	*  Anti State Hack
	*   Usando OnPlayerStateChange com gettime
	*   A precis�o deste sistema fica em torno de 95%
	*
	-------------------------------------------------*/

	if(newstate == PLAYER_STATE_DRIVER) {
		if((gettime() - GetPVarInt(playerid, #registerState)) < 2 && (gettime() - GetPVarInt(playerid, #tPosSet)) > 3) {
			CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_STATE_HACK);
		}
		SetPVarInt(playerid, #registerState, gettime());
	}
	SetPVarInt(playerid, #spiderCar, 0);
	return (pOPSC ? CallLocalFunction("ExOnPlayerStateChange", "idi", playerid, newstate, oldstate) : 1);
}

#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif

#define OnPlayerStateChange ExOnPlayerStateChange
forward ExOnPlayerStateChange(playerid, newstate, oldstate);

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat) {

	/*--------------------------------------------------
	*
	*  Anti Surfer Vehicle
	*   Usando OnUnoccupiedVehicleUpdate com gettime e outros
	*   A precis�o deste sistema fica em torno de 85%
	*
	-------------------------------------------------*/

	GetVehiclePos(vehicleid, g_ucPos[0], g_ucPos[1], g_ucPos[2]);

	if(IsPlayerInRangeOfPoint(playerid, 1.0, g_ucPos[0], g_ucPos[1], g_ucPos[2])) {
		GetVehicleZAngle(vehicleid, g_ucPos[3]);
		if(g_diferencasAngle[vehicleid] != g_ucPos[3]) {
			if(!IsPlayerInAnyVehicle(playerid)) {
				GetPlayerPos(vehicleid, g_ucPos[1], g_ucPos[1], g_ucPos[3]);
				if(g_ucPos[3] > g_ucPos[2]) {
					SetPVarInt(playerid, #registrosUAF, GetPVarInt(playerid, #registrosUAF) +1);
					if(GetPVarInt(playerid, #registrosUAF) > 40) {
						CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_SURF_VEHICLE);
					}
				}
			}
		}
		g_diferencasAngle[vehicleid] = g_ucPos[3];
		return true;
	}

	/*--------------------------------------------------
	*
	*  Anti Teleport Vehicle
	*   Usando OnUnoccupiedVehicleUpdate com gettime e outros
	*   A precis�o deste sistema fica em torno de 85%
	*
	-------------------------------------------------*/

	else if(!IsPlayerInRangeOfPoint(playerid, 40.0, g_ucPos[0], g_ucPos[1], g_ucPos[2])) {
		if(!IsPlayerInAnyVehicle(playerid) && (gettime() - GetPVarInt(playerid, #tPosSet) > 3) && !vehRespawn[vehicleid]) {
			CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_CAR_TELEPORT);
		} else if(vehRespawn[vehicleid]) vehRespawn[vehicleid] = false;
	}
	return (pOUVU ? CallLocalFunction("ExOnUnoccupiedVehicleUpdate", "idi", vehicleid, playerid, passenger_seat) : 1);
}

#if defined _ALS_OnUnoccupiedVehicleUpdate
	#undef OnUnoccupiedVehicleUpdate
#else
	#define _ALS_OnUnoccupiedVehicleUpdate
#endif

#define OnUnoccupiedVehicleUpdate ExOnUnoccupiedVehicleUpdate
forward ExOnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat);

pFunction pVerifBugger(playerid) {
	new Float: x, Float: y, Float: z;
	GetPlayerPos(playerid, x, y, z);
	if(x > 0xdbb9f && y > 0xdbb9f && z > 0xdbb9f) SetPlayerPos(playerid, GetPVarFloat(playerid,"xposSet"),  GetPVarFloat(playerid,"yposSet"),  GetPVarFloat(playerid,"zposSet"));
	else CallLocalFunction("OnPlayerHacking", "ii", playerid, PLAYER_BUGGER_HACK);
	return 1;
}

#define GivePlayerMoney				GivePlayerMoney_Ex
#define ResetPlayerMoney			ResetPlayerMoney_Ex
#define SetPlayerScore				SetPlayerScore_Ex
#define PutPlayerInVehicle			PutPlayerInVehicle_Ex
#define SetPlayerArmour				SetPlayerArmour_Ex
#define SetPlayerHealth				SetPlayerHealth_Ex
#define	TogglePlayerControllable	TogglePlayerC_Ex
#define	GivePlayerWeapon  			GivePlayerWeapon_Ex
#define	ResetPlayerWeapons  		ResetPlayerWeapons_Ex
#define	SetPlayerPos  				SetPlayerPos_Ex
#define	SetVehicleVelocity			SetVehicleVelocity_Ex
#define	SetVehicleToRespawn			SetVehicleToRespawn_Ex

forward OnPlayerHacking(playerid, hackid);