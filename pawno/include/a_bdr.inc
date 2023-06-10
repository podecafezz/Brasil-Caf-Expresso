/* Funções SA:MP - [BDR] Clan
 *
 *  © Copyright 2005-2008, [BDR] Clan™ - Todos os direitos Reservados.
 *
 */

#if defined _samp_included
	#endinput
#endif
#define _samp_included
#pragma library samp

#pragma tabsize 4

#include <a_sampmysql>
#include <core>
#include <float>
#include <string>
#include <file>
#include <time>
#include <datagram>
#include <a_players>
#include <a_vehicles>
#include <a_objects>
#include <a_sampdb>


//===================================================
// Natives
//===================================================

//Uteis
native print(const string[]);
native printf(const format[], {Float,_}:...);
native format(output[], len, const format[], {Float,_}:...);
native SendClientMessage(playerid, color, const message[]);
native SendClientMessageToAll(color, const message[]);
native SendPlayerMessageToPlayer(playerid, senderid, const message[]);
native SendPlayerMessageToAll(senderid, const message[]);
native SendDeathMessage(killer,killee,weapon);
native GameTextForAll(const string[],time,style);
native GameTextForPlayer(playerid,const string[],time,style);
native SetTimer(funcname[], interval, repeating);
native SetTimerEx(funcname[], interval, repeating, const format[], {Float,_}:...);
native KillTimer(timerid);
native GetTickCount();
native GetMaxPlayers();
native LimitGlobalChatRadius(Float:chat_radius);
native CallRemoteFunction(const function[], const format[], {Float,_}:...);
native CallLocalFunction(const function[], const format[], {Float,_}:...);
native Float:asin(Float:value);
native Float:acos(Float:value);
native Float:atan(Float:value);
native Float:atan2(Float:x, Float:y);

//Jogo
native SetGameModeText(const string[]);
native SetTeamCount(count);
native AddPlayerClass(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
native AddPlayerClassEx(teamid, modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
native AddStaticVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2);
native AddStaticVehicleEx(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, respawn_delay);
native AddStaticPickup(model,type,Float:X,Float:Y,Float:Z);
native CreatePickup(model, type, Float:X, Float:Y, Float:Z);
native DestroyPickup(pickup);
native ShowNameTags(show);
native ShowPlayerMarkers(show);
native GameModeExit();
native SetWorldTime(hour);
native GetWeaponName(weaponid, const weapon[], len);
native EnableTirePopping(enable);
native AllowInteriorWeapons(allow);
native SetWeather(weatherid);
native SetGravity(Float:gravity);
native AllowAdminTeleport(allow);
native SetDeathDropAmount(amount);
native CreateExplosion(Float:X, Float:Y, Float:Z, type, Float:Radius);
native SetDisabledWeapons(...);
native EnableZoneNames(enable);
native UsePlayerPedAnims();    //Faz com que os personagens do jogo corram e façam ações como se fosse o CJ.
native DisableInteriorEnterExits();   //Desativa a possibilidade do jogador entrar ou sair de dentro de um determinado interior.
native SetNameTagDrawDistance(Float:distance); //Determina a distância que um jogador vê o nome de outro jogado (consegue ler).

//Administrador
native IsPlayerAdmin(playerid);
native Kick(playerid);
native Ban(playerid);
native BanEx(playerid, const reason[]);
native SendRconCommand(command[]);
native GetServerVarAsString(const varname[], buffer[], len);
native GetServerVarAsInt(const varname[]);
native GetServerVarAsBool(const varname[]);

//Criar Menus e outras funções dele
native Menu:CreateMenu(const title[], columns, Float:x, Float:y, Float:col1width, Float:col2width = 0.0);
native DestroyMenu(Menu:menuid);
native AddMenuItem(Menu:menuid, column, const menutext[]);
native SetMenuColumnHeader(Menu:menuid, column, const columnheader[]);
native ShowMenuForPlayer(Menu:menuid, playerid);
native HideMenuForPlayer(Menu:menuid, playerid);
native IsValidMenu(Menu:menuid);
native DisableMenu(Menu:menuid);
native DisableMenuRow(Menu:menuid, row);
native Menu:GetPlayerMenu(playerid);

//Texto em Text Draw
native Text:TextDrawCreate(Float:x, Float:y, text[]);
native TextDrawDestroy(Text:text);
native TextDrawLetterSize(Text:text, Float:x, Float:y);
native TextDrawTextSize(Text:text, Float:x, Float:y);
native TextDrawAlignment(Text:text, alignment);
native TextDrawColor(Text:text, color);
native TextDrawUseBox(Text:text, use);
native TextDrawBoxColor(Text:text, color);
native TextDrawSetShadow(Text:text, size);
native TextDrawSetOutline(Text:text, size);
native TextDrawBackgroundColor(Text:text, color);
native TextDrawFont(Text:text, font);
native TextDrawSetProportional(Text:text, set);
native TextDrawShowForPlayer(playerid, Text:text);
native TextDrawHideForPlayer(playerid, Text:text);
native TextDrawShowForAll(Text:text);
native TextDrawHideForAll(Text:text);
native TextDrawSetString(Text:text, string[]);

//Zona de gangues

native GangZoneCreate(Float:minx, Float:miny, Float:maxx, Float:maxy);
native GangZoneDestroy(zone);
native GangZoneShowForPlayer(playerid, zone, color);
native GangZoneShowForAll(zone, color);
native GangZoneHideForPlayer(playerid, zone);
native GangZoneHideForAll(zone);
native GangZoneFlashForPlayer(playerid, zone, flashcolor);
native GangZoneFlashForAll(zone, flashcolor);
native GangZoneStopFlashForPlayer(playerid, zone);
native GangZoneStopFlashForAll(zone);

//===================================================
// Defines
//===================================================

//Estados do jogador
#define PLAYER_STATE_NONE						(0)
#define PLAYER_STATE_ONFOOT						(1)
#define PLAYER_STATE_DRIVER						(2)
#define PLAYER_STATE_PASSENGER					(3)
#define PLAYER_STATE_EXIT_VEHICLE				(4) //(Usado internamente)
#define PLAYER_STATE_ENTER_VEHICLE_DRIVER		(5) //(Usado internamente)
#define PLAYER_STATE_ENTER_VEHICLE_PASSENGER	(6) //(Usado internamente)
#define PLAYER_STATE_WASTED						(7)
#define PLAYER_STATE_SPAWNED					(8)
#define PLAYER_STATE_SPECTATING					(9)

//Miscelânia
#define MAX_PLAYER_NAME							(24)
#define MAX_PLAYERS								(200)
#define MAX_VEHICLES							(700)
#define INVALID_PLAYER_ID						(255)
#define INVALID_VEHICLE_ID						(0xFFFF)
#define NO_TEAM									(255)
#define MAX_OBJECTS								(150)
#define INVALID_OBJECT_ID						(255)
#define MAX_GANG_ZONES							(1024)
#define MAX_TEXT_DRAWS							(1024)
#define MAX_MENUS								(128)
#define INVALID_MENU							(0xFF)
#define INVALID_TEXT_DRAW						(0xFFFF)
#define INVALID_GANG_ZONE						(-1)

//Armas
#define WEAPON_BRASSKNUCKLE				(1)
#define WEAPON_GOLFCLUB					(2)
#define WEAPON_NITESTICK				(3)
#define WEAPON_KNIFE					(4)
#define WEAPON_BAT						(5)
#define WEAPON_SHOVEL					(6)
#define WEAPON_POOLSTICK				(7)
#define WEAPON_KATANA					(8)
#define WEAPON_CHAINSAW					(9)
#define WEAPON_DILDO					(10)
#define WEAPON_DILDO2					(11)
#define WEAPON_VIBRATOR					(12)
#define WEAPON_VIBRATOR2				(13)
#define WEAPON_FLOWER					(14)
#define WEAPON_CANE						(15)
#define WEAPON_GRENADE					(16)
#define WEAPON_TEARGAS					(17)
#define WEAPON_MOLTOV					(18)
#define WEAPON_COLT45					(22)
#define WEAPON_SILENCED					(23)
#define WEAPON_DEAGLE					(24)
#define WEAPON_SHOTGUN					(25)
#define WEAPON_SAWEDOFF					(26)
#define WEAPON_SHOTGSPA					(27)
#define WEAPON_UZI						(28)
#define WEAPON_MP5						(29)
#define WEAPON_AK47						(30)
#define WEAPON_M4						(31)
#define WEAPON_TEC9						(32)
#define WEAPON_RIFLE					(33)
#define WEAPON_SNIPER					(34)
#define WEAPON_ROCKETLAUNCHER			(35)
#define WEAPON_HEATSEEKER				(36)
#define WEAPON_FLAMETHROWER				(37)
#define WEAPON_MINIGUN					(38)
#define WEAPON_SATCHEL					(39)
#define WEAPON_BOMB						(40)
#define WEAPON_SPRAYCAN					(41)
#define WEAPON_FIREEXTINGUISHER			(42)
#define WEAPON_CAMERA					(43)
#define WEAPON_PARACHUTE				(46)
#define WEAPON_VEHICLE					(49)
#define WEAPON_DROWN					(53)
#define WEAPON_COLLISION				(54)

//Chaves/Teclado
#define KEY_ACTION				(1)
#define KEY_CROUCH				(2)
#define KEY_FIRE				(4)
#define KEY_SPRINT				(8)
#define KEY_SECONDARY_ATTACK	(16)
#define KEY_JUMP				(32)
#define KEY_LOOK_RIGHT			(64)
#define KEY_HANDBRAKE			(128)
#define KEY_LOOK_LEFT			(256)
#define KEY_SUBMISSION			(512)
#define KEY_LOOK_BEHIND			(512)
#define KEY_WALK				(1024)
#define KEY_ANALOG_UP			(2048)
#define KEY_ANALOG_DOWN			(4096)
#define KEY_ANALOG_RIGHT		(16384)
#define KEY_ANALOG_LEFT			(8192)

#define KEY_UP					(65408)
#define KEY_DOWN				(128)
#define KEY_LEFT				(65408)
#define KEY_RIGHT				(128)

//===================================================
// Forwards
//===================================================

forward OnGameModeInit();
forward OnGameModeExit();
forward OnFilterScriptInit();
forward OnFilterScriptExit();
forward OnPlayerConnect(playerid);
forward OnPlayerDisconnect(playerid, reason);
forward OnPlayerSpawn(playerid);
forward OnPlayerDeath(playerid, killerid, reason);
forward OnVehicleSpawn(vehicleid);
forward OnVehicleDeath(vehicleid, killerid);
forward OnPlayerText(playerid, text[]);
forward OnPlayerCommandText(playerid, cmdtext[]);
forward OnPlayerInfoChange(playerid);
forward OnPlayerRequestClass(playerid, classid);
forward OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
forward OnPlayerExitVehicle(playerid, vehicleid);
forward OnPlayerStateChange(playerid, newstate, oldstate);
forward OnPlayerEnterCheckpoint(playerid);
forward OnPlayerLeaveCheckpoint(playerid);
forward OnPlayerEnterRaceCheckpoint(playerid);
forward OnPlayerLeaveRaceCheckpoint(playerid);
forward OnRconCommand(cmd[]);
forward OnPlayerPrivmsg(playerid, recieverid, text[]);
forward OnPlayerRequestSpawn(playerid);
forward OnObjectMoved(objectid);
forward OnPlayerObjectMoved(playerid, objectid);
forward OnPlayerPickUpPickup(playerid, pickupid);
forward OnVehicleMod(vehicleid, componentid);
forward OnVehiclePaintjob(vehicleid, paintjobid);
forward OnVehicleRespray(vehicleid, color1, color2);
forward OnPlayerSelectedMenuRow(playerid, row);
forward OnPlayerExitedMenu(playerid);
forward OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);
forward OnPlayerKeyStateChange(playerid, newkeys, oldkeys);