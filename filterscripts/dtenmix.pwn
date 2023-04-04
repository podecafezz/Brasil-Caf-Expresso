#include <a_samp>

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("   DtenMix Filterscript by Dyow_Deyv    ");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SendClientMessage(playerid, 0xFFFF00AA, "");
	SendClientMessage(playerid, 0xFFFF00AA, "");
	SendClientMessage(playerid, 0xFFFF00AA, "Para escutar uma Web Rádio digite /dtenmix");
	SendClientMessage(playerid, 0xFFFF00AA, "");
	SendClientMessage(playerid, 0xFFFF00AA, "");
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/dtenmix", cmdtext, true, 10) == 0)
	{
		ShowPlayerDialog(playerid, 5673, DIALOG_STYLE_MSGBOX, "DtenMix", "{00FFEE}Crie já sua Web Rádio e coloque tocando em seu serviror.\n{00FF00}Veja em www.dtenhost.com.br\n{FFFF00}Confira os planos de Streaming de Áudio.", "Play", "Stop");
		return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 5673)
	{
		if(response == 1)
		{
			PlayAudioStreamForPlayer(playerid, "http://96.9.174.37:9996", 0.0, 0.0, 0.0, 50.0, 0);
		}
		else
		{
			StopAudioStreamForPlayer(playerid);
		}
	}
	return 0;
}
