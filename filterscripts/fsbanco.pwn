//==============================================================================
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//|        Fs de banco criado por [FCT]Diego         |
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//==============================================================================
#include <a_samp>
#include <a_objects>
#include <core>
#include <float>
#include <dutils>
#include <dudb>
#include <c_vehicleinfo>
#include <a_players>
#include <dini>
#include <cpstream>
//==============================================================================
#define COR_GROOVE 0x5B47B8AA
//==============================================================================
#pragma tabsize 0
//==============================================================================
new dconta[MAX_PLAYERS];
new Nome[MAX_PLAYER_NAME];
new banco1;
new banco2;
new banco3;
new banco4;
new banco5;
//==============================================================================
public OnPlayerConnect(playerid)
{
new string[246];
GetPlayerName(playerid,Nome,sizeof(Nome));
format(string,sizeof(string),"%s.ini",Nome);
if(!dini_Exists(string)){
dini_Create(string);
dconta[playerid] = 0;
} else GivePlayerMoney(playerid,dini_Int(string,"Depositado"));
}
//==============================================================================
public OnFilterScriptInit()
{
    Create3DTextLabel("Banco", 0x6D9AABAA, -1550.3021,1061.9955,7.0, 50, 0);
    Create3DTextLabel("Banco", 0x6D9AABAA, -2276.2776,533.9462,34.7,2, 50, 0);
    Create3DTextLabel("Banco", 0x6D9AABAA, 1243.4810,-1702.6155,13.200, 50, 0);
    Create3DTextLabel("Banco", 0x6D9AABAA, 1286.8013,-1310.9182,13.200, 50, 0);
    Create3DTextLabel("Banco", 0x6D9AABAA, 1937.8323,2303.5337,10.500, 50, 0);
    CreateObject(2942, -1550.3021,1061.9955,7.0, 0.000000, 0.000000, 270); // Banco SF 01
    CreateObject(2942, -2276.2776,533.9462,34.7, 0.000000, 0.000000, 90); // Banco SF 02
    CreateObject(2942, 1243.4810,-1702.6155,13.200, 0.000000, 0.000000, 0); // Banco LS 01
    CreateObject(2942, 1286.8013,-1310.9182,13.200, 0.000000, 0.000000, 270); // Banco LS 02
    CreateObject(2942, 1937.8323,2303.5337,10.500, 0.000000, 0.000000, 270); // Banco LV 01
    banco1 = CPS_AddCheckpoint(-1550.3021,1061.9955,7.0,2.0,80);
    banco2 = CPS_AddCheckpoint(-2276.2776,533.9462,34.7,2.0,80);
    banco3 = CPS_AddCheckpoint(1243.4810,-1702.6155,13.200,2.0,80);
    banco4 = CPS_AddCheckpoint(1286.8013,-1310.9182,13.200,2.0,80);
    banco5 = CPS_AddCheckpoint(1937.8323,2303.5337,10.500,2.0,80);
    return 1;
    }
//==============================================================================
public OnPlayerCommandText(playerid,cmdtext[])
{
//==============================================================================
	new cmd[256];
	new idx;
    new tmp[256];
	cmd = strtok(cmdtext, idx);
	new string[246];
//==============================================================================
if(strcmp(cmd,"/depositar",true)==0)
{
tmp = strtok(cmdtext,idx);
new deposito;
if(!strlen(tmp))
{
SendClientMessage(playerid,0xFF0000AA,"[ERRO] Use: /depositar [valor]");
return 1;
}
deposito = strval(tmp);
tmp = strtok(cmdtext,idx);
if(IsPlayerInRangeOfPoint(playerid, 1.0, -1550.3021,1061.9955,7.0) || IsPlayerInRangeOfPoint(playerid, 1.0, -2276.2776,533.9462,34.7) || IsPlayerInRangeOfPoint(playerid, 1.0, 1243.4810,-1702.6155,13.200) ||  IsPlayerInRangeOfPoint(playerid, 1.0, 1286.8013,-1310.9182,13.200) ||  IsPlayerInRangeOfPoint(playerid, 1.0, 1937.8323,2303.5337,10.500)){
if(GetPlayerMoney(playerid) >= deposito)
{
dconta[playerid] += deposito;
format(string,sizeof(string),"[AVISO]: Vocк depositou R$%d na sua conta. (Saldo Total: R$%d)",deposito,dconta[playerid]);
SendClientMessage(playerid,0x31FF1AAA,string);
GivePlayerMoney(playerid,-deposito);
GetPlayerName(playerid,Nome,sizeof(Nome));
format(string,sizeof(string),"%s.ini",Nome);
dini_IntSet(string,"Depositado",dconta[playerid]);
} else SendClientMessage(playerid,0xFF0000AA,"[ERRO]: Saldo insuficiente.");
} else SendClientMessage(playerid,0xFF0000AA,"[ERRO]: Vocк nгo estб em um banco.");
return 1;
}
//==============================================================================
if(!strcmp("/AjudaBanco",cmdtext,true))
{
SendClientMessage(playerid, 0x000000AA, ".Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.");
SendClientMessage(playerid,0x9AD147AA,"ї Existem Vбrios Bancos por Toda San Andreas!");
SendClientMessage(playerid,0x9AD147AA,"ї Os comandos do banco sгo: /depositar, /sacar e /saldo");
SendClientMessage(playerid, 0x000000AA, ".Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.");
return 1;
}
//==============================================================================
if(strcmp(cmd,"/Sacar",true)==0)
{
tmp = strtok(cmdtext,idx);
new sacar;
if(!strlen(tmp))
{
SendClientMessage(playerid,0xFF0000AA,"|ERRO| Use: /Sacar [valor]");
return 1;
}
sacar = strval(tmp);
tmp = strtok(cmdtext,idx);
//                                             Banco 1                                                          Banco 2                                                                           Banco 3                                                                   Banco 4
if(IsPlayerInRangeOfPoint(playerid, 1.0, -1550.3021,1061.9955,7.0) || IsPlayerInRangeOfPoint(playerid, 1.0, -2276.2776,533.9462,34.7) || IsPlayerInRangeOfPoint(playerid, 1.0, 1243.4810,-1702.6155,13.200) ||  IsPlayerInRangeOfPoint(playerid, 1.0, 1286.8013,-1310.9182,13.200) ||  IsPlayerInRangeOfPoint(playerid, 1.0, 1937.8323,2303.5337,10.500)){if(dconta[playerid] >= sacar)
{
dconta[playerid] -= sacar;
format(string,sizeof(string),"[AVISO]: Vocк sacou R$%d (Saldo Total: R$%d)",sacar,dconta[playerid]);
SendClientMessage(playerid,0x31FF1AAA,string);
GivePlayerMoney(playerid,sacar);
GetPlayerName(playerid,Nome,sizeof(Nome));
format(string,sizeof(string),"%s.ini",Nome);
dini_IntSet(string,"Depositado",dconta[playerid]);
} else SendClientMessage(playerid,0xFF0000AA,"[ERRO]: Saldo insuficiente.");
} else SendClientMessage(playerid,0xFF0000AA,"[ERRO]: Vocк nгo estб em um banco.");
return 1;
}
//==============================================================================
if(strcmp(cmd, "/saldo", true) == 0)
{
SendClientMessage(playerid, COR_GROOVE, "[ERRO]: Desculpe comando em construзгo!");
return 1;
}
}
//==============================================================================
public OnPlayerEnterCheckpoint(playerid)
    {
            if(CPS_IsPlayerInCheckpoint(playerid, banco1))
    {
    SendClientMessage(playerid, 0x000000AA, ".Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para depositar dinheiro /depositar [quantia].");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para sacar dinheiro /sacar [quantia].");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para ver o seu saldo /saldo.");
    SendClientMessage(playerid, 0x000000AA, ".Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.");
    GameTextForPlayer(playerid, "~r~B~w~a~r~n~w~c~r~o", 5000, 5);
    }

            if(CPS_IsPlayerInCheckpoint(playerid, banco2))
    {
    SendClientMessage(playerid, 0x000000AA, ".Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para depositar dinheiro /depositar [quantia].");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para sacar dinheiro /sacar [quantia].");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para ver o seu saldo /saldo.");
    SendClientMessage(playerid, 0x000000AA, ".Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.");
    GameTextForPlayer(playerid, "~r~B~w~a~r~n~w~c~r~o", 5000, 5);
    }

        if(CPS_IsPlayerInCheckpoint(playerid, banco3))
    {
    SendClientMessage(playerid, 0x000000AA, ".Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para depositar dinheiro /depositar [quantia].");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para sacar dinheiro /sacar [quantia].");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para ver o seu saldo /saldo.");
    SendClientMessage(playerid, 0x000000AA, ".Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.");
    GameTextForPlayer(playerid, "~r~B~w~a~r~n~w~c~r~o", 5000, 5);
    }

    if(CPS_IsPlayerInCheckpoint(playerid, banco4))
    {
    SendClientMessage(playerid, 0x000000AA, ".Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para depositar dinheiro /depositar [quantia].");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para sacar dinheiro /sacar [quantia].");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para ver o seu saldo /saldo.");
    SendClientMessage(playerid, 0x000000AA, ".Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.");
    GameTextForPlayer(playerid, "~r~B~w~a~r~n~w~c~r~o", 5000, 5);
    }

                    if(CPS_IsPlayerInCheckpoint(playerid, banco5))
    {
    SendClientMessage(playerid, 0x000000AA, ".Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para depositar dinheiro /depositar [quantia].");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para sacar dinheiro /sacar [quantia].");
    SendClientMessage(playerid, 0x853DDCAA,"ї Para ver o seu saldo /saldo.");
    SendClientMessage(playerid, 0x000000AA, ".Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.Х.");
    GameTextForPlayer(playerid, "~r~B~w~a~r~n~w~c~r~o", 5000, 5);
    }
    return 1;
    }
//==============================================================================
    stock IsPlayerInPlace(playerid,Float:XMin,Float:YMin,Float:XMax,Float:YMax )
{
new RetValue = 0;
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z );
//==============================================================================
if( X >= XMin && Y >= YMin && X < XMax && Y < YMax )
{
  RetValue = 1;
}
return RetValue;
}
//==============================================================================
