#include <a_samp>
#include <streamer>

new PortaoCondominioLS;

#if defined FILTERSCRIPT
#else
#endif

public OnGameModeInit()
{
PortaoCondominioLS = CreateObject(980, 836.09997558594, -2589.1999511719, 127.80000305176, 0.0000, 0.0000, 0.0000);

return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
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
