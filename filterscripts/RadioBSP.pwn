
#include <a_samp>

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("   BRG Filterscript by Dyow_Deyv    ");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SendClientMessage(playerid, 0xFFFF00AA, "");
	SendClientMessage(playerid, 0xFFFF00AA, "");
	SendClientMessage(playerid, 0xFFFF00AA, "Para escutar uma Web Rádio digite /RadioBSP");
	SendClientMessage(playerid, 0xFFFF00AA, "");
	SendClientMessage(playerid, 0xFFFF00AA, "");
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/RadioBSP", cmdtext, true, 10) == 0)
	{
		ShowPlayerDialog(playerid, 5673, DIALOG_STYLE_MSGBOX, "[BSP]Brasil São Paulo[RPG] ", "{00FFEE}Em Breve teremos mais opiçoes de Radio.\n{00FF00}\n{FFFF00}Radio [BRG]Brasil São Paulo[RPG].", "Play", "Stop");
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
			PlayAudioStreamForPlayer(playerid, "http://tuner.hit104.com:80", 0.0, 0.0, 0.0, 50.0, 0);
		}
		else
		{
			StopAudioStreamForPlayer(playerid);
		}
	}
	return 0;
}






