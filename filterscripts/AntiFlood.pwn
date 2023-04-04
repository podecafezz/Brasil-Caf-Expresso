#include <a_samp>
#include <utils>
#include "../include/gl_common"

#define ColorFlood 0x24B1DBAA
#define TimerFlood 1500
#define AlertFlood 4

new FloodAlert[MAX_PLAYERS],
	FloodTimer[MAX_PLAYERS];
forward RemoveFlood(playerid);

public OnFilterScriptInit()
{
	print(",        [ON]        .");
	print("| Sistema Anti Flood |");
	print("`    By: Dr_Pawno    ´");
	return 1;
}

public OnFilterScriptExit()
{
	print(",        [OFF]       .");
	print("| Sistema Anti Flood |");
	print("`    By: Dr_Pawno    ´");
	return 1;
}

public OnPlayerConnect(playerid)
{
	FloodAlert[playerid] = 0; FloodTimer[playerid] = 0;
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new string[126];
	KillTimer(FloodTimer[playerid]);
	FloodTimer[playerid] = SetTimerEx("RemoveFlood", TimerFlood, 0, "i", playerid);
	FloodAlert[playerid] ++;
	if(FloodAlert[playerid] > 1 && FloodAlert[playerid] < AlertFlood-1)
	{
	    format(string, sizeof(string), "[Anti-Flood] Você tem {FFFF00}%d/%d{24B1DB} avisos.", FloodAlert[playerid], AlertFlood);
	    SendClientMessage(playerid, ColorFlood, string);
	}
	if(FloodAlert[playerid] == AlertFlood-1)
	{
	    format(string, sizeof(string), "[Anti-Flood] Você tem {FFFF00}%d/%d{24B1DB} avisos. Mais um e você será Kickado.", FloodAlert[playerid], AlertFlood);
	    SendClientMessage(playerid, ColorFlood, string);
	}
	if(FloodAlert[playerid] == AlertFlood)
	{
	    format(string, sizeof(string), "[Anti-Flood] Você tem {FFFF00}%d/%d{24B1DB} avisos. Você foi Kickado.", FloodAlert[playerid], AlertFlood);
	    SendClientMessage(playerid, ColorFlood, string);
		Kick(playerid);
		new pname[MAX_PLAYER_NAME]; GetPlayerName(playerid, pname, sizeof(pname));
		format(string, sizeof(string), "[Anti-Flood] {FFFF00}%s{24B1DB} foi kickado por Flood.", pname);
		SendClientMessageToAll(ColorFlood, string);
		return 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	// New
	new comando[126],
		string[256],
		index,
		pname[MAX_PLAYER_NAME];

	// Comando
	comando = strtok(cmdtext, index);
	if(!strcmp("/resetarflood", comando, true))
	{
		// Não é Admin Rcon
		if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, ColorFlood, "[Anti-Flood] Você não é Admin RCON.");
		
	    // New (Resposta)
	    new resposta[MAX_PLAYER_NAME];
		resposta = strtok(cmdtext, index);

	    // Sem Resposta
	    if(!strlen(resposta)) return SendClientMessage(playerid, ColorFlood, "[Anti-Flood] /ResetarFlood [PlayerID/NOME]");
	    
	    // Definir Resposta Como Jogador
	    new player = ReturnUser(resposta);
	    
	    // sizeof Não Conectado
	    if(!IsPlayerConnected(playerid)) return SendClientMessage(playerid, ColorFlood, "[Anti-Flood] Jogador Não Conectado.");
	    
	    // Funções Do Player
	    GetPlayerName(playerid, pname, sizeof(pname));
	    format(string, sizeof(string), "[Anti-Flood] {FFFF00}%s{24B1DB} resetou o seu Flood.", pname);
	    SendClientMessage(player, ColorFlood, string);
	    FloodAlert[player] = 0;
	    
	    // Funções Do PlayerID
	    GetPlayerName(player, pname, sizeof(pname));
	    format(string, sizeof(string), "[Anti-Flood] Você resetou o Flood de {FFFF00}%s{24B1DB}.", pname);
	    SendClientMessage(playerid, ColorFlood, string);
	    return 1;
	}
	return 0;
}

public RemoveFlood(playerid)
{
	KillTimer(FloodTimer[playerid]);
	FloodAlert[playerid] = 0;
	return 1;
}
