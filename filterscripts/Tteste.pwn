#include <a_samp>
#include <streamer>
//no Topo do GM
new teste;

#if defined FILTERSCRIPT
#else
#endif

//OnGameModeInit
teste = CreateObject(980, 1534.7081,-1450.9193,13.3907,0.0000,0.0000,0.0000);

return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{

//comando
	if(strcmp("/ad", cmdtext, true) == 0)
{
    MoveObject(teste, 1534.7081,-1450.9193,20.3907,3,0.0000,0.0000,0.0000);
    SetTimer(#Moveteste, 5000, 0);
    SendClientMessage(playerid, 0x2641FEFF, #Portao aberto);
    return true;
}



//No fim do GM
forward Moveteste();
public Moveteste()
{
    MoveObject(teste,1534.7081, -1450.9193, 13.3907,3,0.0000, 0.0000, 0.0000);
    return true;
}
