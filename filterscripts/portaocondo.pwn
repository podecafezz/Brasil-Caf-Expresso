#include <a_samp>
#include <streamer>

new Portaocondo;

#if defined FILTERSCRIPT
#else
#endif

public OnGameModeInit()
{
Portaocondo = CreateObject(980, 1291.0999755859, -2227, 109.5, 0.0000, 0.0000, 0.0000);

return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
   	if(strcmp(cmdtext, "/abrirc", true) == 0)
	{
		MoveObject(Portaocondo,1291.0999755859, -2227, 115, 3.0);
        SendClientMessage(playerid, 0x9E3EFFAA, "[INFO] Abrindo PORTAO do Condo...");
		return 1;
	}
	if(strcmp(cmdtext, "/fecharc", true) == 0)
	{
		MoveObject(Portaocondo,1291.0999755859, -2227, 109.5, 3.0);
        SendClientMessage(playerid, 0x9E3EFFAA, "[INFO] Fechando PORTAO do Condo...");
		return 1;
	}

    return 0;
}
