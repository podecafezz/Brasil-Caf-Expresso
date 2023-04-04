// Bots Security Script v1.0B by Amit_B
#include "a_samp.inc"
new var[MAX_PLAYERS] = {-1,...}, warns[MAX_PLAYERS] = {0,...}, bool:npc[MAX_PLAYERS] = {false,...}, MAX_PLAYERS_ = MAX_PLAYERS;
public OnFilterScriptInit()
{
	SendRconCommand("reloadbans");
	print("Bots Security Script v1.0B loaded");
	return 1;
}
public OnPlayerConnect(playerid)
{
	if(CountIP(GetIP(playerid)) >= 6) return BanAll(playerid), 0;
	MAX_PLAYERS_ = playerid > MAX_PLAYERS_ ? playerid : GetHighestID(),
	npc[playerid] = bool:IsPlayerNPC(playerid),
	var[playerid] = SetTimerEx("BSS",2500,false,"i",playerid),
	warns[playerid] = 0;
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	MAX_PLAYERS_ = GetHighestID(playerid);
	if(npc[playerid]) npc[playerid] = false;
	if(var[playerid] != -1)
	{
		KillTimer(var[playerid]);
		var[playerid] = -1;
	}
	warns[playerid] = 0;
	return 1;
}
stock CountIP(ip[])
{
	new c = 0;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && !strcmp(GetIP(i),ip)) c++;
	return c;
}
forward BSS(playerid);
public BSS(playerid)
{
	new i = GetPlayerPing(playerid);
	if(i <= 0 || i >= 50000)
	{
		if(warns[playerid] >= 1) BanAll(playerid);
		else warns[playerid]++, var[playerid] = SetTimerEx("BSS",1500,false,"i",playerid);
	}
	return 0;
}
stock GetIP(playerid)
{
	new ip[16];
	GetPlayerIp(playerid,ip,sizeof(ip));
	return ip;
}
stock BanAll(playerid)
{
	new ip[32];
	GetPlayerIp(playerid,ip,sizeof(ip));
	for(new i = 0, p = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && !npc[i])
	{
		p = GetPlayerPing(i);
		if(i == playerid || !strcmp(ip,GetIP(i)) || p <= 0 || p >= 50000)
		{
			BanEx(i,"Bot");
			if(var[i] != -1)
			{
				KillTimer(var[i]);
				var[i] = -1;
			}
		}
	}
	format(ip,sizeof(ip),"banip %s",ip);
	return SendRconCommand(ip);
}
stock GetHighestID(exceptof = INVALID_PLAYER_ID)
{
	new h = 0;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && i != exceptof && i > h) h = i;
	return h;
}
