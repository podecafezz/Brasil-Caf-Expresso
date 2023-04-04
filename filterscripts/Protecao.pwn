//FilterScript Ant-Niex Boot By:Gabriel Hornet.
//Exclusividade www.homehots.net
//Bom,Minha Primeira fs de proteção ta ae.. Se Forem Postar em Seus blogs,Não Sejam NOobS Créditos..
//Exclusivo Para www.homehots.net

#include <a_samp> // Include do SAMP
#define MAX_CONNECTIONS_FROM_IP 1 // Não Mudar

//---------------------------------------------

public OnFilterScriptInit()
{
    printf("\n*** FilterSscript Ant Niex-Boot Inicializada e Crarregada. Maximo de conexões a partir de 1 IP = %d\n",MAX_CONNECTIONS_FROM_IP);
}

//---------------------------------------------
//GetNumberOfPlayersOnThisIP
// Retorna o número de jogadores de ligação do
// Fornecido endereço IP

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
        printf("Ant-NiexBoot: leitor de ligação (% d) excedido% d conexões IP de% s.", playerid, MAX_CONNECTIONS_FROM_IP, connecting_ip);
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
