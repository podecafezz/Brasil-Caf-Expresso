//FilterScript Ant-Niex Boot By:Gabriel Hornet.
//Exclusividade www.homehots.net
//Bom,Minha Primeira fs de prote��o ta ae.. Se Forem Postar em Seus blogs,N�o Sejam NOobS Cr�ditos..
//Exclusivo Para www.homehots.net

#include <a_samp> // Include do SAMP
#define MAX_CONNECTIONS_FROM_IP 1 // N�o Mudar

//---------------------------------------------

public OnFilterScriptInit()
{
    printf("\n*** FilterSscript Ant Niex-Boot Inicializada e Crarregada. Maximo de conex�es a partir de 1 IP = %d\n",MAX_CONNECTIONS_FROM_IP);
}

//---------------------------------------------
//GetNumberOfPlayersOnThisIP
// Retorna o n�mero de jogadores de liga��o do
// Fornecido endere�o IP

stock GetNumberOfPlayersOnThisIP(test_ip[])
{
    new against_ip[32+1];
    new x = 0;
    new ip_count = 0;
    for(x=0; x<MAX_PLAYERS; x++) {
        if(IsPlayerConnected(x)) {
            GetPlayerIp(x,against_ip,32);
            if(!strcmp(against_ip,test_ip)) ip_count++;
        }
    }
    return ip_count;
}

//---------------------------------------------

public OnPlayerConnect(playerid)
{
    new connecting_ip[32+1];
    GetPlayerIp(playerid,connecting_ip,32);
    new num_players_on_ip = GetNumberOfPlayersOnThisIP(connecting_ip);

    if(num_players_on_ip > MAX_CONNECTIONS_FROM_IP) {
        printf("Ant-NiexBoot: leitor de liga��o (% d) excedido% d conex�es IP de% s.", playerid, MAX_CONNECTIONS_FROM_IP, connecting_ip);
        Kick(playerid);
        return 1;
    }

    return 0;
}

//---------------------------------------------

// EEEEEEEEEEEEEEEE
// EE
// EE
// EE
// EE
// EE
// EE     E      EE
// EE            EE
// EE            EE
// EEEEEEEEEEEEEEEE
