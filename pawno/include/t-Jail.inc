#include <a_samp>

/*
native JailConnect(playerid)
native JailDisconnect(playerid)
native Jail(playerid, jailerid, time, const reason[])
native UnJail(playerid)
*/

new JailPN[MAX_PLAYERS][24], Jailed[MAX_PLAYERS], JailTimer[MAX_PLAYERS], Float: JailPos[MAX_PLAYERS][4], JailWeps[MAX_PLAYERS][12], JailAmmo[MAX_PLAYERS][12], jailstring[128];
forward Unjail(playerid);

stock JailConnect(playerid) return Jailed[playerid] = 0;

stock JailDisconnect(playerid)
{
	Jailed[playerid] = 0;
	KillTimer(JailTimer[playerid]);
	format(JailPN[playerid], 24, " ");
	return 1;
}

stock Jail(playerid, jailerid, time, const reason[])
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(Jailed[playerid] == 1) return 0;
	if(time < 1) return 0;
	GetPlayerName(playerid, JailPN[playerid], 24);
	GetPlayerName(jailerid, JailPN[jailerid], 24);
	if(jailerid == -1) format(jailstring, 128, "%s has been jailed by the server for %d minutes because he/she %s", JailPN[playerid], time, reason);
	else
	{
		if(!IsPlayerConnected(jailerid)) format(jailstring, 128, "%s has been jailed by the server for %d minutes because he/she %s", JailPN[playerid], time, reason);
		else format(jailstring, 128, "%s has been jailed by %s for %d minutes because he/she %s", JailPN[playerid], JailPN[jailerid], time, reason);
	}
	SendClientMessageToAll(0x33CCFFAA, jailstring);
	GetPlayerPos(playerid, JailPos[playerid][0], JailPos[playerid][1], JailPos[playerid][2]);
	GetPlayerFacingAngle(playerid, JailPos[playerid][3]);
	SetPlayerPos(playerid, 264.6288, 77.5742, 1001.0391);
	SetPlayerInterior(playerid, 6);
	for(new i = 0; i < 12; i++) GetPlayerWeaponData(playerid, i, JailWeps[playerid][i], JailAmmo[playerid][i]);
	ResetPlayerWeapons(playerid);
	JailTimer[playerid] = SetTimerEx("Unjail", time*60*1000,0, "i", playerid);
	Jailed[playerid] = 1;
	return 1;
}

public Unjail(playerid) //public because we have a timer for it
{
	if(!IsPlayerConnected(playerid)) return 1;
	if(Jailed[playerid] == 0) return 1;
	GetPlayerName(playerid, JailPN[playerid], 24);
	format(jailstring, 128, "%s has been unjailed", JailPN[playerid]);
	SendClientMessageToAll(0x33CCFFAA, jailstring);
	SetPlayerPos(playerid, JailPos[playerid][0], JailPos[playerid][1], JailPos[playerid][2]);
	SetPlayerFacingAngle(playerid, JailPos[playerid][3]);
	SetPlayerInterior(playerid, 0);
	for(new i = 0; i < 12; i++) GivePlayerWeapon(playerid, JailWeps[playerid][i], JailAmmo[playerid][i]);
	KillTimer(JailTimer[playerid]);
	Jailed[playerid] = 0;
	return 1;
}