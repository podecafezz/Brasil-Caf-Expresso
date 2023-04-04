#include <a_samp>
#include <streamer>

new Portaodepartamento;

#if defined FILTERSCRIPT
#else
#endif

public OnGameModeInit()
{
Portaodepartamento = CreateObject(980, 1555, -1620.3000488281, 15.300000190735, 0.0000, 0.0000, 0.0000);

return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
   	if(strcmp(cmdtext, "/ad", true) == 0)
	{
		MoveObject(Portaodepartamento,1555, -1620.3000488281, 20.799999237061, 3.0);
        SendClientMessage(playerid, 0x9E3EFFAA, "[INFO] Abrindo PORTAO do Delegica...");
		return 1;
	}
	if(strcmp(cmdtext, "/fd", true) == 0)
	{
		MoveObject(Portaodepartamento,1555, -1620.3000488281, 15.300000190735, 3.0);
        SendClientMessage(playerid, 0x9E3EFFAA, "[INFO] Fechando PORTAO do Delegica...");
		return 1;
	}

    return 0;
}
