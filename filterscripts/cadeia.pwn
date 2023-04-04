/****************************************************************************
 *                                                                          *
 *                              -- CADEIA --                                *
 *                                                                          *
 *                              (FilterScript)                              *
 *                                                                          *
 *                              -- by Lós --                                *
 *                                                                          *
 *                     Thanks to Shelby by his Sexy Ass.                    *
 ****************************************************************************/

//============== [ INCLUDES ]=============//
#include        <       a_samp      >
#include        <       zcmd        >
#include        <       DOF2        >
#include        <       sscanf2     >
#include        <       foreach     >

//============== [ CONFIGURAÇÕES ] =============//
#define         COORDENADAS_CADEIA          /*X da cadeia*/, /*Y da cadeia*/, /*Z da cadeia*/
#define         INTERIOR_CADEIA             /*ID DO INTERIOR DA CADEIA*/

#define         ARQUIVO                     "Cadeia/%s.ini"

//============== [ DEACLARAÇÕES ] =============//
new
    G_PLAYER_PRESO_CADEIA_ADMIN[MAX_PLAYERS],
    G_TEMPO_CADEIA[MAX_PLAYERS],
    G_TEMPO_RESTANTE_CADEIA[MAX_PLAYERS],
    G_TEMPO_DA_CADEIA[MAX_PLAYERS];

forward TirarDaCadeia(id);
forward VerificarTempoRestante(id);

//============== [ PUBLICS ] ===================//
public OnFilterScriptExit()
{
    DOF2_Exit();
    return 1;
}

public OnPlayerDisconnect(playerid)
{
    if(G_PLAYER_PRESO_CADEIA_ADMIN[playerid] == 1) return S_SALVAR_CADEIA(playerid);
    return 1;
}

public VerificarTempoRestante(id)
{
    G_TEMPO_RESTANTE_CADEIA[id]--;
    new L_TIMER;
    if(G_TEMPO_RESTANTE_CADEIA[id] == 0) KillTimer(L_TIMER);
    L_TIMER = SetTimerEx("VerificarTempoRestante", 1000, false, "i", id);
    return 1;
}


public TirarDaCadeia(id)
{
    SpawnPlayer(id);
    S_REMOVER_CADEIA(id);
    G_PLAYER_PRESO_CADEIA_ADMIN[id] = 0;
    G_TEMPO_DA_CADEIA[id] = 0;
    KillTimer(G_TEMPO_CADEIA[id]);
    return 1;
}

public OnPlayerSpawn(playerid)
{
    new L_CAMINHO_ARQUIVO[50]; format(L_CAMINHO_ARQUIVO, sizeof(L_CAMINHO_ARQUIVO), ARQUIVO, S_GET_PLAYER_NAME(playerid));
	if(DOF2_FileExists(L_CAMINHO_ARQUIVO))
    {
        SendClientMessage(playerid, -1, "Você estava preso e voltou para prisão!");
        SetPlayerPos(playerid, COORDENADAS_CADEIA);
        G_PLAYER_PRESO_CADEIA_ADMIN[playerid] = 1;
       	G_TEMPO_RESTANTE_CADEIA[playerid] = (playerid, DOF2_GetInt(L_CAMINHO_ARQUIVO, "Tempo"));
        G_TEMPO_CADEIA[playerid] = SetTimerEx("TirarDaCadeia", G_TEMPO_RESTANTE_CADEIA[playerid], false, "i", "playerid");
        return 1;
    }
    return 1;
}

//============== [ COMANDOS ] ===================//
CMD:cadeia(playerid, params[])
{
    new L_ID, L_TEMPO, L_MOTIVO[60], L_STRING[128];
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "Você não é administrador logado na RCON!");
    if(sscanf(params, "uds", L_ID, L_TEMPO, L_MOTIVO)) return SendClientMessage(playerid, -1, "Use: /cadeia {00E5FF}[ID] [Tempo (em minutos)] [Motivo]");
    if(G_PLAYER_PRESO_CADEIA_ADMIN[L_ID] == 1) return SendClientMessage(playerid, -1, "Este player já está preso!");
    SetPlayerPos(L_ID, COORDENADAS_CADEIA);
    SetPlayerInterior(L_ID, INTERIOR_CADEIA);
    G_PLAYER_PRESO_CADEIA_ADMIN[L_ID] = 1;
    format(L_STRING, sizeof(L_STRING), "%s colocou %s na cadeia. Motivo: %s", S_GET_PLAYER_NAME(playerid), S_GET_PLAYER_NAME(L_ID), L_MOTIVO);
    SendClientMessageToAll(-1, L_STRING);
    G_TEMPO_DA_CADEIA[L_ID] = L_TEMPO*60000;
    G_TEMPO_RESTANTE_CADEIA[L_ID] = G_TEMPO_DA_CADEIA[L_ID];
    VerificarTempoRestante(L_ID);
    G_PLAYER_PRESO_CADEIA_ADMIN[playerid] = 1;
    G_TEMPO_CADEIA[L_ID] = SetTimerEx("TirarDaCadeia", G_TEMPO_RESTANTE_CADEIA[L_ID], false, "i", L_ID);
    S_SALVAR_CADEIA(L_ID);
    return 1;
}

CMD:soltar(playerid, params[])
{
    new L_ID, L_MOTIVO[60], L_STRING[128];
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "Você não é administrador logado na RCON!");
    if(G_PLAYER_PRESO_CADEIA_ADMIN[L_ID] == 0) return SendClientMessage(playerid, -1, "Este player já está solto!");
    if(sscanf(params, "us", L_ID, L_MOTIVO)) return SendClientMessage(playerid, -1, "Use: /soltar {00E5FF}[ID] [Motivo]");
    format(L_STRING, sizeof(L_STRING), "%s retirou %s da cadeia. Motivo: %s", S_GET_PLAYER_NAME(playerid), S_GET_PLAYER_NAME(L_ID), L_MOTIVO);
    SendClientMessageToAll(-1, L_STRING);
    return TirarDaCadeia(L_ID);
}

CMD:tempocadeia(playerid)
{
    new L_STRING[128];
    if(G_PLAYER_PRESO_CADEIA_ADMIN[playerid] == 0) return SendClientMessage(playerid, -1, "Você não está preso!");
    format(L_STRING, sizeof(L_STRING), "Você ainda vai ficar preso por %d segundos.", G_TEMPO_RESTANTE_CADEIA[playerid]);
    return SendClientMessageToAll(-1, L_STRING);
}

CMD:presos(playerid)
{
    new L_STRING[128];
    foreach(new i : Player)
    {
        if(G_PLAYER_PRESO_CADEIA_ADMIN[i] == 1)
        {
            format(L_STRING, sizeof(L_STRING), "%s. Cadeia: Admin. Tempo: %d segundos.", S_GET_PLAYER_NAME(i), G_TEMPO_RESTANTE_CADEIA[i]);
            SendClientMessageToAll(-1, L_STRING);
        }
    }
    return 1;
}

//============== [ STOCKS ] ===================//
stock S_SALVAR_CADEIA(id)
{
    new L_CAMINHO_ARQUIVO[50]; format(L_CAMINHO_ARQUIVO, sizeof(L_CAMINHO_ARQUIVO), ARQUIVO, S_GET_PLAYER_NAME(id));
	if(!DOF2_FileExists(L_CAMINHO_ARQUIVO)) DOF2_CreateFile(L_CAMINHO_ARQUIVO);
    DOF2_SetInt(L_CAMINHO_ARQUIVO, "Tempo", G_TEMPO_RESTANTE_CADEIA[id]);
    return 1;
}

stock S_REMOVER_CADEIA(id)
{
    new L_CAMINHO_ARQUIVO[50]; format(L_CAMINHO_ARQUIVO, sizeof(L_CAMINHO_ARQUIVO), ARQUIVO, S_GET_PLAYER_NAME(id));
	if(DOF2_FileExists(L_CAMINHO_ARQUIVO)) return DOF2_RemoveFile(L_CAMINHO_ARQUIVO);
    G_PLAYER_PRESO_CADEIA_ADMIN[id] = 0;
    return 1;
}

stock S_GET_PLAYER_NAME(playerid)
{
    new L_N[MAX_PLAYER_NAME]; GetPlayerName(playerid, L_N, MAX_PLAYER_NAME); return L_N;
}

