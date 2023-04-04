#include <a_samp>
#include <streamer>

new PlataformacomdominioLS;

#if defined FILTERSCRIPT
#else
#endif

public OnGameModeInit()
{
PlataformacomdominioLS = CreateObject(6189, 836.40002441406, -2524, -2.4000000953674, 0.0000, 0.0000, 0.0000);

return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
   	if(strcmp(cmdtext, "/spcls", true) == 0)
	{
		MoveObject(PlataformacomdominioLS,836.40002441406, -2524, 110.5, 8.0);
        SendClientMessage(playerid, 0x9E3EFFAA, "[INFO] Subindo Plataforma do condominio LS...");
		return 1;
	}
	if(strcmp(cmdtext, "/dpcls", true) == 0)
	{
		MoveObject(PlataformacomdominioLS,836.40002441406, -2524, -2.4000000953674, 8.0);
        SendClientMessage(playerid, 0x9E3EFFAA, "[INFO] Decendo Plataforma do condominio LS...");
		return 1;
	}

    return 0;
}

