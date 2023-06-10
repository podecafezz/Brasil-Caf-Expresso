/*				 _       _____
				| |     | ____|
				| |     | |__
				| |     |  __|
				| |___  | |___
				|_____| |_____|
_________________________________________________
|             Scriptname : Ultimate AntiCheat	  |
|             Version : 1.3                       |
|                                                 |
|   A Production from the LE Script Team          |
|                13.02.2009                       |
|   Last Update: 13.04.2009                       |
|                                                 |
|   Mainscripter: [HC]Littlejohnny                |
|   Co-Scripter: [HC]E4sTsId3			          |
|   Tester: [HC]Littlejohnny		              |
|									              |
|   Credits:                                      |
|   eAdmin - Weaponhack/Badnames/Badwords  		  |
|   Seif_  - AntiMoneyHack & AntiAmmoHack  		  |
|   JunkBuster  - Plug&Play & AntiPos/CarJackHack |
|_________________________________________________|
|                                                 |
|   ICQ Messenger:  492-670-404 (Littlejohnny)    |
|					456-118-961 (E4sTsId3)        |
|                                                 |
|       Copyright 2009 by LE Script Team          |
|_________________________________________________|
*/

#if defined _UAC_included
  #endinput
#endif

#include <a_samp>
#include <dini>

#define _UAC_included
#pragma library UAC
#pragma tabsize 0
#include <a_samp>

#define CONFIG_FILE "PAC/PAC_Config.ini"

/*
native GivePlayerGun(playerid, weaponid, ammo);
native IsValidWeapon(weaponid);
native GivePlayerCash(playerid, amount);
native TakePlayerCash(playerid, amount);
native SetPlayerCash(playerid, amount);
native ResetPlayerCash(playerid);
native GetPlayerCash(playerid);
native PutPlayerIntoVehicle(playerid,vehicleid,seatid);
native SetPlayerToPos(playerid,Float:x,Float:y,Float:z);
native SetVehicleToPos(vehicleid,Float:x,Float:y,Float:z);
native GetName(playerid);
native GetDistanceToPoint(playerid,Float:x,Float:y,Float:z);
*/

forward UAC_OnPlayerStateChange(playerid, newstate, oldstate);
forward UAC_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
forward UAC_OnPlayerCommandText(playerid, cmdtext[]);
forward UAC_OnPlayerText(playerid, text[]);
forward UAC_OnPlayerConnect(playerid);
forward UAC_OnPlayerSpawn(playerid);
forward UAC_OnPlayerDisconnect(playerid,reason);
forward UAC_OnGameModeInit();
forward UAC_OnGameModeExit();
forward UAC_OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);
forward UAC_OnPlayerDeath(playerid,killerid,reason);

new Spawned[MAX_PLAYERS];
forward SpawnedInWorld(playerid);

//========================== [UAC Options] ===================================//
/*
Estas são as configurações ! O servidor criará um ficheiro chamado UAC_Config.ini
na sua primeira inicialização ! Este ficheiro será creado sempre que o mesmo
não exista ! Poderá eliminar o ficheiro e mudar as Opções e o servidor criará
uma nova Configuração com novas Opções.
*/

new HealthCheck = 1;        // Activado (1) / Desactivado (0) a Verificação de Energia
new ArmourCheck = 0;      	// Activado (1) / Desactivado (0) a Verificação de Colete
new JetpackCheck = 0;       // Activado (1) / Desactivado (0) a Verificação de Jetpack
new WeaponCheck = 1;        // Activado (1) / Desactivado (0) a Verificação de Armas
new MoneyCheck = 0;         // Activado (1) / Desactivado (0) a Verificação de Dinheiro
new AmmoCheck = 0;        	// Activado (1) / Desactivado (0) a Verificação de Munições
new BotCheck = 0;        	// Activado (1) / Desactivado (0) a Verificação de Bot
new PosCheck = 1;        	// Activado (1) / Desactivado (0) a Verificação de Pos

new HealthTimer,
	ArmourTimer,
	JetpackTimer,
	WeaponTimer,
	MoneyTimer,
	AmmoTimer,
	BotTimer,
	PosTimer;

//======================= [Anti-HealthHack] ==================================//
forward AntiHealthHack();
new Float:healthx;

//======================= [Anti-ArmourHack] ==================================//
forward AntiArmourHack();
new Float:armour;

//======================= [Anti-JetPackHack] =================================//
forward AntiJetpack();

//======================= [Anti-WeaponHack] ==================================//
forward AntiWeaponHack();
forward AntiAmmoHack();
#define MAX_WEAPONS		46
#define UAC_MAX_AMMO    50      // Máximo Número de Munições, como diferença
enum Winfo
{
	Weapon[13]
}
new Ammo[MAX_PLAYERS][MAX_WEAPONS];
new Gun[MAX_PLAYERS][Winfo];

//========================== [Anti-Spam] =====================================//
forward ResetSpam(playerid);
forward ResetSpamCMD(playerid);
forward ResetMute(playerid);
#define MAX_SPAM_MESSAGES 	3
#define MAX_SPAM_CMDS 		3
new Spam[MAX_PLAYERS];
new SpamCMD[MAX_PLAYERS];
new Mute[MAX_PLAYERS];

//====================== [Anti-MoneyHack] ====================================//
#define UAC_MAX_MONEY	5000 	// Máximo Número de Dinheiro, como diferença
new UAC_Money[MAX_PLAYERS];
forward AntiMoneyHack();

//===================== [Anti-CarJackHack] ===================================//
new InVehicle[MAX_PLAYERS];

//===================== [Anti-PositionHack] ==================================//
new Float:NewPos[MAX_PLAYERS][3];
new PosHackCheckTime[MAX_PLAYERS];
forward AntiPositionHack();

//========================== [Anti-HighPing] =================================//
#define MAX_PING 400
forward HighPingKick();

//========================== [ForbiddenWords] ================================//
#define FWORDS "PAC/Badwords.cfg"
new ForbiddenWords[100][100], ForbiddenWordCount = 0;

//========================== [ForbiddenNames] ================================//
#define BNAMES "PAC/Badnames.cfg"
new BadNames[100][100], BadNameCount = 0;

//========================== [Anti-Bot] ======================================//
forward AntiBot();

//=========================== [Colors] =======================================//
#define RED 		0x00F600AA
#define LIGHTGREEN 	0x00F600AA

//==========================[ Config-Loader ]=================================//
stock GetConfigFile()
{
	new cf[256];
	format(cf,sizeof(cf), "%s", CONFIG_FILE);
	return cf;
}

stock LoadConfigFile()
{
	new file[256];
	file = GetConfigFile();
	
	if(!dini_Exists(file))
	{
		dini_Create(file);
	    dini_IntSet(file, "Health", HealthCheck);
	    dini_IntSet(file, "Armour", ArmourCheck);
	    dini_IntSet(file, "Jetpack", JetpackCheck);
	    dini_IntSet(file, "Weapon", WeaponCheck);
	    dini_IntSet(file, "Money", MoneyCheck);
	    dini_IntSet(file, "Ammo", AmmoCheck);
	    dini_IntSet(file, "Bot", BotCheck);
	    dini_IntSet(file, "Pos", PosCheck);
	} else {
	    HealthCheck = dini_Int(file, "Health");
		ArmourCheck = dini_Int(file, "Armour");
		JetpackCheck = dini_Int(file, "Jetpack");
		WeaponCheck = dini_Int(file, "Weapon");
		MoneyCheck = dini_Int(file, "Money");
		AmmoCheck = dini_Int(file, "Ammo");
		BotCheck = dini_Int(file, "Bot");
		PosCheck = dini_Int(file, "Pos");
	}
}


public OnGameModeInit()
{
	print("|*****************************|");
	print("|  _   _       ___   _____    |");
	print("| | | | |     /   | |  ___|   |");
	print("| | | | |    / /| | | |       |");
	print("| | | | |   / / | | | |       |");
	print("| | |_| |  / /  | | | |___    |");
	print("| |_____| /_/   |_| |_____|   |");
	print("|*****************************|");
	print("|  Ultimate Anticheat loaded  |");
	print("|*****************************|");
	print("| Script by : LE Script Team  |");
	print("|*****************************|");
	
	
	LoadConfigFile();

	if(HealthCheck == 1) // Se a Verificação de Energia estiver Activada
	{
		HealthTimer = SetTimer("AntiHealthHack",  	3000,    1); 	// Todos 3.0  Segundos uma verificação
	}
	if(ArmourCheck == 1) // If Se a Verificação de Colete estiver Activada
	{
		ArmourTimer = SetTimer("AntiArmourHack",  	3000,    1); 	// Todos 3.0  Segundos uma verificação
	}
	if(JetpackCheck == 1) // Se a Verificação de Jectpack estiver Activada
	{
		JetpackTimer = SetTimer("AntiJetpack",  	700,    1); 	// Todos 0.7  Segundos uma verificação
	}
	if(WeaponCheck == 1) // Se a Verificação de Armas estiver Activada
	{
		WeaponTimer = SetTimer("AntiWeaponHack",  	800,    1); 	// Todos 0.8  Segundos uma verificação
	}
	if(MoneyCheck == 1) // Se a Verificação de Dinheiro estiver Activada
	{
		MoneyTimer = SetTimer("AntiMoneyHack",  	4000, 	1); 	// Todos 4  Segundos uma verificação
	}
	if(AmmoCheck == 1) // Se a Verificação de Munições estiver Activada
	{
		AmmoTimer = SetTimer("AntiAmmoHack",		5000, 	1);     // Todos 5  Segundos uma verificação
	}
	if(BotCheck == 1) // Se a Verificação de Bot estiver Activada
	{
		BotTimer = SetTimer("AntiBot", 	 			150000, 1);     // Todos 2,5  Segundos uma verificação
	}
	if(PosCheck == 1) // Se a Verificação de Pos estiver Activada
	{
		PosTimer = SetTimer("AntiPositionHack", 	1000, 1);     	// Jede  Segundos uma verificação
	}

	SetTimer("ResetMute",  	 	300000, 1); 	// Todos 5 	Minutos uma reiniciação
	SetTimer("PingKick", 	 	10000,  1);     // Todos 10   Segundos uma verificação

	ForbiddenWordsLoad();
	ForbiddenNamesLoad();                
	return CallLocalFunction("UAC_OnGameModeInit","");
}

public OnGameModeExit()
{
    print("|*******************************|");
	print("|    _   _       ___   _____    |");
	print("|   | | | |     /   | |  ___|   |");
	print("|   | | | |    / /| | | |       |");
	print("|   | | | |   / / | | | |       |");
	print("|   | |_| |  / /  | | | |___    |");
	print("|   |_____| /_/   |_| |_____|   |");
	print("|*******************************|");
	print("|  Ultimate Anticheat unloaded  |");
	print("|*******************************|");
	print("|  Script by : LE Script Team   |");
	print("|*******************************|");

	KillTimer(HealthTimer);
	KillTimer(ArmourTimer);
	KillTimer(JetpackTimer);
	KillTimer(WeaponTimer);
	KillTimer(MoneyTimer);
	KillTimer(AmmoTimer);
	KillTimer(BotTimer);
	KillTimer(PosTimer);
	return CallLocalFunction("UAC_OnGameModeExit","");
}

public OnPlayerConnect(playerid)
{
	new string[128];
	Spawned[playerid] = 0;
	Spam[playerid] = 0;
	SpamCMD[playerid] = 0;
	Mute[playerid] = 0;
	PosHackCheckTime[playerid] = 0;
	InVehicle[playerid] = 0;

	for(new weapon = 0; weapon <= MAX_WEAPONS; weapon++)
	{
	 	Ammo[playerid][weapon] = 0;
	}

	for(new s = 0; s < BadNameCount; s++)
	{
		if(!strcmp(BadNames[s],GetName(playerid),true))
		{
			SendClientMessage(playerid, RED, " ~ [Perfect Anti Cheater]: Você tomou kick por usar nick proibido! (BadName)");
			format(string, sizeof(string), " ~ [Perfect Anti Cheater]: %s (id:%d) tomou kick por usar nick proibido! (BadName)", GetName(playerid), playerid);
			SendClientMessageToAll(LIGHTGREEN, string);
			Kick(playerid);
			return 1;
		}
	}
	return CallLocalFunction("UAC_OnPlayerConnect","i",playerid);
}

public OnPlayerDisconnect(playerid, reason)
{
	#pragma unused reason
	Spawned[playerid] = 0;
	Spam[playerid] = 0;
	SpamCMD[playerid] = 0;
	Mute[playerid] = 0;

	for(new weapon = 0; weapon <= MAX_WEAPONS; weapon++)
	{
	 	Ammo[playerid][weapon] = 0;
	}
	return CallLocalFunction("UAC_OnPlayerDisconnect","ii",playerid,reason);
}

public OnPlayerSpawn(playerid)
{
	SetTimerEx("SpawnedInWorld", 3000, 0, "d", playerid);
	PosHackCheckTime[playerid] = 5;
	return CallLocalFunction("UAC_OnPlayerSpawn","i",playerid);
}

public OnPlayerDeath(playerid,killerid,reason)
{
	Spawned[playerid] = 0;
	return CallLocalFunction("UAC_OnPlayerDeath","iii",playerid,killerid,reason);
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
    PosHackCheckTime[playerid] = 5;
    return CallLocalFunction("UAC_OnPlayerInteriorChange","iii",playerid, newinteriorid, oldinteriorid);
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	InVehicle[playerid] = 1;
	return CallLocalFunction("UAC_OnPlayerEnterVehicle","iii",playerid, vehicleid, ispassenger);
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_SPECTATING && !IsPlayerAdmin(playerid))
	{
	    Ban(playerid);
 	}
	if(newstate == PLAYER_STATE_DRIVER && InVehicle[playerid] == 0)
	{
	    Kick(playerid);
		InVehicle[playerid] = 0;
	}
	return CallLocalFunction("UAC_OnPlayerStateChange","iii",playerid, newstate, oldstate);
}

public OnPlayerText(playerid, text[])
{
    new string[128];
	if(Mute[playerid] == 1)
	{
	    SendClientMessage(playerid, RED, " ~ [Perfect Anti Cheater]: Você foi calado(a), não pode escrever!");
	    return 0;
	}

	Spam[playerid]++;
	SetTimerEx("ResetSpam", 3000, 0, "d", playerid);
	if(Spam[playerid] > MAX_SPAM_MESSAGES)
	{
  		Mute[playerid] = 1;
  		SendClientMessage(playerid, RED, " ~ [Perfect Anti Cheater]: Você foi calado(a) por 5 minutos!");
		format(string, sizeof(string), " ~ [Perfect Anti Cheater]: %s (id:%d) foi calado(a) por 5 Minutos!", GetName(playerid), playerid);
		SendClientMessageToAll(LIGHTGREEN, string);
		return 0;
	}

	for(new s = 0; s < ForbiddenWordCount; s++)
    {
		new pos;
		while((pos = strfind(text,ForbiddenWords[s],true)) != -1) for(new i = pos, j = pos + strlen(ForbiddenWords[s]); i < j; i++) text[i] = '*';
	}
	return CallLocalFunction("UAC_OnPlayerText","is",text);
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	SpamCMD[playerid]++;
	SetTimerEx("ResetSpamCMD", 4000, 0, "d", playerid);
	if(Spam[playerid] > MAX_SPAM_CMDS)
	{
		SendClientMessage(playerid, RED, " ~ [Perfect Anti Cheater]: Por favor não abuse dos comandos ! (Os comandos foram bloqueados por 5 segundos)");
		return 0;
	}
	return CallLocalFunction("UAC_OnPlayerCommandText","is",playerid,cmdtext);
}

public ResetSpam(playerid)
{
	Spam[playerid] = 0;
	return 1;
}

public ResetMute(playerid)
{
    if(Mute[playerid] == 1)
	{
		Mute[playerid] = 0;
	}
	return 1;
}

public ResetSpamCMD(playerid)
{
	SpamCMD[playerid] = 0;
	return 1;
}

public SpawnedInWorld(playerid)
{
	Spawned[playerid] = 1;
	return 1;
}

//============================================================================//
public AntiHealthHack()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		    GetPlayerHealth(i, healthx);
		    if(healthx > 100)
		    {
    			Kick(i);
   			}
		}
	}
	return 1;
}

//============================================================================//
public AntiArmourHack()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		    GetPlayerArmour(i, armour);
		    if(armour > 100)
		    {
    			Kick(i);
    		}
		}
	}
	return 1;
}

//============================================================================//
public AntiJetpack()
{
new string[128];
for(new i; i < MAX_PLAYERS; i++)
{
    if(IsPlayerConnected(i) && Spawned[i] == 1)
	{
		if(GetPlayerSpecialAction(i) == 2) //Jetpack
		{
		    SendClientMessage(i, RED, " ~ [Perfect Anti Cheater]: Você tomou kick por usar um JetPack!");
			format(string,sizeof(string), " ~ [Perfect Anti Cheater]: %s (id:%d) tomou kick por usar um Jetpack!", GetName(i), i);
			SendClientMessageToAll(LIGHTGREEN, string);
			Kick(i);
		}
	}
}
return 1;
}

//============================================================================//
public AntiWeaponHack()
{
	new string[128];
	for(new i; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		new weapon;
		new ammo;
		GetPlayerWeaponData(i, 7, weapon, ammo);
		if(weapon == 38 && ammo >= 1)
		{
		SendClientMessage(i, RED, " ~ [Perfect Anti Cheater]: Você tomou ban por usar uma Minigun ! (WeaponHack)");
		format(string, sizeof(string), " ~ [Perfect Anti Cheater]: %s (id:%d) tomou ban, por usar uma Minigun ! (WeaponHack)", GetName(i), i);
		SendClientMessageToAll(LIGHTGREEN, string);
		Ban(i);
		}
		if(weapon == 36 && ammo >= 1)
		{
		SendClientMessage(i, RED, " ~ [Perfect Anti Cheater]: Você tomou ban por usar um Rocketlauncher ! (WeaponHack)");
		format(string, sizeof(string), "== ANTI-CHEAT: %s (id:%d) tomou ban, por usar um Rocketlauncher ! (WeaponHack)", GetName(i), i);
		SendClientMessageToAll(LIGHTGREEN, string);
		Ban(i);
		}
		if(weapon == 35 && ammo >= 1)
		{
		SendClientMessage(i, RED, " ~ [Perfect Anti Cheater]: Você tomou ban por usar um Rocketlauncher ! (WeaponHack)");
		format(string, sizeof(string), " ~ [Perfect Anti Cheater]:  %s (id:%d) tomou ban, por usar um Rocketlauncher ! (WeaponHack)t", GetName(i), i);
		SendClientMessageToAll(LIGHTGREEN, string);
		Ban(i);
		}
		if(weapon == 40 && ammo >= 1)
		{
		SendClientMessage(i, RED, " ~ [Perfect Anti Cheater]: Você tomou ban por usar Satchel Charges ! (WeaponHack)");
		format(string, sizeof(string), " ~ [Perfect Anti Cheater]:  %s (id:%d) tomou ban, por usar Stachel Charges ! (WeaponHack)", GetName(i), i);
		SendClientMessageToAll(LIGHTGREEN, string);
		Ban(i);
		}
		}
	}
	return 1;
}

stock GivePlayerGun(playerid, weaponid, ammo) // Thx to Seif
{
	Gun[playerid][Weapon][WeaponSlot(weaponid)] = weaponid;
	Ammo[playerid][weaponid] = ammo;
	GivePlayerWeapon(playerid, weaponid, ammo);
}

stock WeaponSlot(weaponid) // Thx to Seif
{
	switch (weaponid)
	{
	    case 0,1: return 0;
	    case 2..9: return 1;
	    case 10..15: return 10;
	    case 16..18,39: return 8;
	    case 22..24: return 2;
	    case 25..27: return 3;
	    case 28,29,32: return 4;
	    case 33,34: return 6;
	    case 35..38: return 7;
	    case 41..43: return 9;
	    case 44..46: return 11;
	    default: return 12;
	}
	return true;
}

public AntiAmmoHack() // Thx to Seif
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if (IsPlayerConnected(i))
	    {
	        new weapon, ammo;
	        new string[128];
	        for(new slot=0;slot<13;slot++)
	        {
         		GetPlayerWeaponData(i, slot, weapon, ammo);
           		if (Gun[i][Weapon][slot] != weapon)
             	{
              		if (ammo > Ammo[i][weapon])
           			{
              			if ((ammo - Ammo[i][weapon]) >= UAC_MAX_AMMO)
              			{
                 			SendClientMessage(i, RED, " ~ [Perfect Anti Cheater]: Você tomou kick por usar Munições Infinitas ! (AmmoHack) !");
                 			format(string, sizeof(string), " ~ [Perfect Anti Cheater]: %s (id:%d) tomou kick, por usar Munições Infinitas ! (AmmoHack)", GetName(i), i);
							SendClientMessageToAll(LIGHTGREEN, string);
		        			Kick(i);
                    	}
                   	}
             	}
	        }
	    }
	}
}

stock IsValidWeapon(weaponid) // Thx to Seif
{
        if (weaponid > 0) return 1;
        return 0;
}

//============================================================================//
public HighPingKick()
{
	new string[256];
	for(new i = 0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
	   		new ping;
			ping = GetPlayerPing(i);
			if(ping > MAX_PING)
			{
			    format(string,sizeof(string), "~ [Perfect Anti Cheater]: Você tomou kick por ter um ping alto! (HighPing [Max Ping: %d])", MAX_PING);
	            SendClientMessage(i, RED, string);
		    	format(string,sizeof(string), "~ [Perfect Anti Cheater]: %s (id:%d) tomou kick, por ter um ping alto! (HighPing [Max Ping: %d])", GetName(i), i, MAX_PING);
		    	SendClientMessageToAll(LIGHTGREEN, string);
		    	Kick(i);
  			}
		}
	}
}

//============================================================================//
public AntiMoneyHack() // Thx to Seif
{
    for(new i = 0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
	    {
	        new money = GetPlayerMoney(i);
	        new string[128];
	        if(money > UAC_Money[i])
	        {
	            if((money - UAC_Money[i]) > UAC_MAX_MONEY)
	            {
	                SendClientMessage(i, RED, "== ANTI-CHEAT: Foste kickado por usar um Cheat de Dinheiro (MoneyHack)");
	                format(string, sizeof(string), "== ANTI-CHEAT: %s (id:%d) foi kickado, por usar um Cheat de Dinheiro ! (AmmoHack)", GetName(i), i);
					SendClientMessageToAll(LIGHTGREEN, string);
	                Kick(i);
	            }
	        }
	    }
	}
}

stock GivePlayerCash(playerid, amount) // Thx to Seif
{
	UAC_Money[playerid] += amount;
	GivePlayerMoney(playerid, amount);
}

stock TakePlayerCash(playerid, amount) // Thx to Seif
{
	UAC_Money[playerid] -= amount;
	GivePlayerMoney(playerid, -amount);
}

stock SetPlayerCash(playerid, amount)
{
	UAC_Money[playerid] == amount;
	SetPlayerMoney(playerid, amount);
}

stock ResetPlayerCash(playerid)
{
	UAC_Money[playerid] = 0;
	ResetPlayerMoney(playerid);
}

stock GetPlayerCash(playerid)
{
	return UAC_Money[playerid];
}

//============================================================================//
stock PutPlayerIntoVehicle(playerid,vehicleid,seatid)
{
	if(IsPlayerConnected(playerid))
	{
		PutPlayerInVehicle(playerid,vehicleid,seatid);
  		InVehicle[playerid] = 1;
  		return 1;
	}
	return 0;
}

//============================================================================//
stock SetPlayerToPos(playerid,Float:x,Float:y,Float:z)
{
	if(IsPlayerConnected(playerid))
	{
		SetPlayerPos(playerid,x,y,z);
  		NewPos[playerid][0] = x;
    	NewPos[playerid][1] = y;
     	NewPos[playerid][2] = z;
      	PosHackCheckTime[playerid] = 5;
       	return 1;
	}
	return 0;
}

stock SetVehicleToPos(vehicleid,Float:x,Float:y,Float:z)
{
	SetVehiclePos(vehicleid,x,y,z);
	for(new i=0;i<MAX_PLAYERS;i++)
	{
				if(IsPlayerInAnyVehicle(i))
      {
  			if(IsPlayerConnected(i) && GetPlayerVehicleID(i) == vehicleid)
   			{
      			NewPos[i][0] = x;
	        	NewPos[i][1] = y;
		        NewPos[i][2] = z;
		        PosHackCheckTime[i] = 5;
			    }
			}
		return 1;
	}
	return 0;
}

public AntiPositionHack()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
 		if(IsPlayerConnected(i))
	    {
	    	if(!PosHackCheckTime[i])
		    {
				if(GetDistanceToPoint(i,NewPos[i][0],NewPos[i][1],NewPos[i][2]) > 500 && GetPlayerState(i) != PLAYER_STATE_PASSENGER)
				{
					Kick(i);
				}
			}
			else
			PosHackCheckTime[i]--;
			GetPlayerPos(i,NewPos[i][0],NewPos[i][1],NewPos[i][2]);
			}
		}
	return 1;
}

//============================================================================//
stock ForbiddenWordsLoad()
{
    new File:file;
	new xstring[100];

	ForbiddenWordCount = 0;

	if((file = fopen(FWORDS,io_read)))
	{
	while(fread(file,xstring))
	{
 	for(new i = 0, j = strlen(xstring); i < j; i++) if(xstring[i] == '\n' || xstring[i] == '\r') xstring[i] = '\0';
 	ForbiddenWords[ForbiddenWordCount] = xstring;
 	ForbiddenWordCount++;
	}
	fclose(file);	printf("== ANTI-CHEAT: %d forbidden Words loaded", ForbiddenWordCount);
	}
}

stock ForbiddenNamesLoad()
{
    new File:file;
	new string[100];

 	BadNameCount = 0;

	if((file = fopen(BNAMES,io_read)))
	{
	while(fread(file,string))
	{
 	for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
 	BadNames[BadNameCount] = string;
 	BadNameCount++;
	}
	fclose(file);	printf("== ANTI-CHEAT: %d forbidden Names loaded", BadNameCount);
	}
}

//============================================================================//
public AntiBot()
{
	for(new i = 0; i<MAX_PLAYERS; i++)
 	{
  		if(IsPlayerConnected(i))
  		{
   			if(GetPlayerPing(i) < 1)
   			{
    			Kick(i);
   			}
  		}
 	}
}

//============================================================================//
stock GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));

	return name;
}

stock GetDistanceToPoint(playerid,Float:x,Float:y,Float:z)
{
	new Float:dis;
	new Float:x1,Float:y1,Float:z1;
	if (!IsPlayerConnected(playerid)) return -1;
	GetPlayerPos(playerid,x1,y1,z1);
	dis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
	return floatround(dis);
}

#define OnPlayerStateChange UAC_OnPlayerStateChange
#define OnPlayerEnterVehicle UAC_OnPlayerEnterVehicle
#define OnPlayerCommandText UAC_OnPlayerCommandText
#define OnPlayerText UAC_OnPlayerText
#define OnPlayerConnect UAC_OnPlayerConnect
#define OnPlayerDisconnect UAC_OnPlayerDisconnect
#define OnGameModeInit UAC_OnGameModeInit
#define OnGameModeExit UAC_OnGameModeExit
#define OnPlayerSpawn UAC_OnPlayerSpawn
#define OnPlayerInteriorChange UAC_OnPlayerInteriorChange
#define OnPlayerDeath UAC_OnPlayerDeath