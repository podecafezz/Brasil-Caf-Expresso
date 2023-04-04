#include <a_samp>
#include <streamer>
//no Topo do GM
new teste;
new lf;
new PortaoCondominioLS;

#if defined FILTERSCRIPT
#else
#endif

public OnGameModeInit()
{
PortaoCondominioLS = CreateObject(980, 836.09997558594, -2589.1999511719, 127.80000305176, 0.0000, 0.0000, 0.0000);


//OnGameModeInit
teste = CreateObject(980, 1534.7081,-1450.9193,13.3907,0.0000,0.0000,0.0000);

//PortaoLuis
lf = CreateObject(2990, 282.7178,-1320.3519,56.8307,0.0000,0.0000,37.8000);



return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{

//comando
	if(strcmp(#/ad, cmdtext, true) == 0)
{
    MoveObject(teste, 1534.7081,-1450.9193,20.3907,3,0.0000,0.0000,0.0000);
    SetTimer(#Moveteste, 5000, 0);
    SendClientMessage(playerid, 0x2641FEFF, #Portao aberto);
    return true;
}
//Casa do Luis
	if(strcmp(#/lf, cmdtext, true) == 0)
{
    MoveObject(lf, 282.7178,-1320.3519,63.8307,3,0.0000,0.0000,37.8000);
    SetTimer(#Movelf, 5000, 0);
    SendClientMessage(playerid, 0x2641FEFF, #Portao aberto);
    return true;
}

   	if(strcmp(cmdtext, "/apcls", true) == 0)
	{
		MoveObject(PortaoCondominioLS,836.09997558594, -2589.1999511719, 133.30000305176, 3.0);
        SendClientMessage(playerid, 0x9E3EFFAA, "[INFO] Abrindo PORTAO do Condominio LS...");
		return 1;
	}
	if(strcmp(cmdtext, "/fpcls", true) == 0)
	{
		MoveObject(PortaoCondominioLS,836.09997558594, -2589.1999511719, 127.80000305176, 3.0);
        SendClientMessage(playerid, 0x9E3EFFAA, "[INFO] Fechando PORTAO do condominio LS...");
		return 1;
	}

    return 0;
}


//No fim do GM
forward Moveteste();
public Moveteste()
{
    MoveObject(teste,1534.7081, -1450.9193, 13.3907,3,0.0000, 0.0000, 0.0000);
    return true;
}
//Portao do Luis Fim
forward Movelf();
public Movelf()
{
    MoveObject(lf,282.7178, -1320.3519, 56.8307,3,0.0000, 0.0000, 37.8000);
    return true;
}
