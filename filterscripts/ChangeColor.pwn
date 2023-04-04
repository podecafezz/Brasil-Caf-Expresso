#include <a_samp>
#include <dini>
#include <nLibrary>
#include <a_vehicles>
#include <foreach>
#include <MapAndreas>
#include <streamer>
#include <ZGetVehName>
#include <mSelection>
#include <TimestampToDate>

#include <sscanf2>

#define FILTERSCRIPT
#if defined FILTERSCRIPT
public OnFilterScriptInit()
{
	print("=====================================");
    print("*                                   *");
    print("*                                   *");
    print("*Criado Totalmente Por: Darkness    *");
    print("*                                   *");
    print("*                                   *");
	print("=====================================");
	return 1;
}

public OnFilterScriptExit()
{
    return 1;
}
public OnPlayerConnect(playerid)
{
return 1;
}

new pAdmin[MAX_PLAYERS];

//teste
CargoAdmin(playerid)
{
    new var[17];
    switch(pAdmin[playerid])
    {
        case 1: var = "Ajudante";
        case 3: var = "Moderador(a)";
        case 4: var = "Administrador(a)";
        case 5: var = "Staff";
    }
    return var;
}

//========================COMANDOS AKI==========================================
public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp(cmdtext, "/Coradmmm",true) == 0)
{
        SendClientMessage(playerid, 0x1E90FFAA ,"============================ CORES ============================");
        SendClientMessage(playerid, 0x00FF7FAA ,"CORES DISPONIVEIS:\n");
		SendClientMessage(playerid, 0xFF0606FF ,">>>>>>>>>>>>{F60000}/Vermelho\n - {21DD00}/Verde\n - {FF6EB4}/Rosa\n - {0000FF}/Azul\n - {FFFFFF}/Branco\n  " );
        SendClientMessage(playerid, 0xFF0606FF ,">>>>>>>>>>>>{9400D3}/Roxo\n - {00F5FF}/Turquesa\n - {1E90FF}/Azul C\n - {FFFF00}/Amarelo\n - {000000}/Preto\n");
		SendClientMessage(playerid, 0x0000FFAA ,">>>>>>>>>>>>{00BFFF}/azul f\n - {CD661D}/chocolate\n - {8968CD}/Roxo M\n - {FF1493}/Rosa p\n - {FFA500}/Laranja\n");
		SendClientMessage(playerid, 0x0000FFAA , "Uso Correto do Comando é EX: /azul , /preto , /verde e assim por Diante");
		SendClientMessage(playerid, 0x1E90FFAA ,"============================ CORES ============================");
	    return 1;
		    }
//==============================================================================
    if (strcmp(cmdtext, "/aazul", true)==0)
    {
		SetPlayerColor(playerid, 0x0000FFAA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/vermelholm", true)==0)
{
		SetPlayerColor(playerid, 0x8A0000AA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/pretoo", true)==0)
{
		SetPlayerColor(playerid, 0x00000AA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/aamarelo", true)==0)
{
		SetPlayerColor(playerid, 0xFFFF00AA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/aaposentado", true)==0)
{
		SetPlayerColor(playerid, 0x8A6969AA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/llaranja", true)==0)
{
		SetPlayerColor(playerid, 0xFFA500AA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/rrosa", true)==0)
{
		SetPlayerColor(playerid, 0xFF6EB4AA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/vverde", true)==0)
{
		SetPlayerColor(playerid, 0x21DD00AA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/bbranco", true)==0)
{
		SetPlayerColor(playerid, 0xFFFFFFAA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/vvermelho", true)==0)
{
		SetPlayerColor(playerid, 0xF60000AA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/aazul c", true)==0)
{
		SetPlayerColor(playerid, 0x1E90FFAA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/rroxo", true)==0)
{
		SetPlayerColor(playerid, 0x9400D3AA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/tturquesa", true)==0)
{
		SetPlayerColor(playerid, 0x00F5FFAA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/aazul f", true)==0)
{
		SetPlayerColor(playerid, 0x00BFFFAA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/cchocolate", true)==0)
{
		SetPlayerColor(playerid, 0xCD661DAA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/rRoxo m", true)==0)
{
		SetPlayerColor(playerid, 0x8968CDAA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/pPetroleiro m", true)==0)
{
		SetPlayerColor(playerid, 0x84CFF5AA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    if (strcmp(cmdtext, "/rrosa p", true)==0)
{}
        if(pAdmin[playerid] == 1 || pAdmin[playerid] == 2 || pAdmin[playerid] == 3 || pAdmin[playerid] == 4 || pAdmin[playerid] == 5){
		SetPlayerColor(playerid, 0xFF1493AA);
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		SendClientMessageToAll( 0x0000FFAA, string);
		SendClientMessage(playerid, 0xFF0606FF , "[INFO:] Cor do Seu Nick Foi Mudada Com Sucesso Comando Criado Por: Darkness");
		return 1;
}
//==============================================================================
    return 0;
}
//==============================================================================

#endif
