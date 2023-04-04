#include <a_samp>
#include <streamer>

new PlataformaDP;

#if defined FILTERSCRIPT
#else
#endif

public OnGameModeInit()
{
PlataformaDP = CreateObject(3095, 1570.8000488281, -1632.6999511719, 12.5, 0.0000, 0.0000, 0.0000);

return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
   	if(strcmp(cmdtext, "/sedp", true) == 0)
	{
		MoveObject(PlataformaDP,1570.8000488281, -1632.6999511719, 26.799999237061, 4.0);
        SendClientMessage(playerid, 0x9E3EFFAA, "[INFO] Subindo Elevador do departamento...");
		return 1;
	}
	if(strcmp(cmdtext, "/dedp", true) == 0)
	{
		MoveObject(PlataformaDP,1570.8000488281, -1632.6999511719, 12.5, 4.0);
        SendClientMessage(playerid, 0x9E3EFFAA, "[INFO] Decendo Elevador do departamento...");
		return 1;
	}

    return 0;
}


