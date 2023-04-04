#include <a_samp>
#include <streamer>

new Portaoconce2;

#if defined FILTERSCRIPT
#else
#endif

public OnGameModeInit()
{
Portaoconce2 = CreateObject(980, 2907.3999023438, 2402.8999023438, 12.39999961853, 0.0000, 0.0000, 0.0000);

return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
   	if(strcmp(cmdtext, "/apc", true) == 0)
	{
		MoveObject(Portaoconce2,2907.3999023438, 2402.8999023438, 17.89999961853, 3.0);
        SendClientMessage(playerid, 0x9E3EFFAA, "[INFO] Abrindo PORTAO da conce...");
		return 1;
	}
	if(strcmp(cmdtext, "/fpc", true) == 0)
	{
		MoveObject(Portaoconce2,2907.3999023438, 2402.8999023438, 12.39999961853, 3.0);
        SendClientMessage(playerid, 0x9E3EFFAA, "[INFO] Fechando PORTAO da conce...");
		return 1;
	}

    return 0;
}


