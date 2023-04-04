/*---------------------------------------------------------------------------------------
----------------------------------FS DE FALA---------------------------------------------
------------------------------BY LUCAS_ALEMAO--------------------------------------------
---------------------------------------------------------------------------------------*/



#include <a_samp>
#include <zcmd>
#include <sscanf2>

#define CINZA                   0xCECECEFF
#define AMARELO                 0xFFFF00FF
#define AZUL_CLARO              0x00C2ECFF

main()
{
	print("\n");
	print("FS de fala By Lucas_Alemao Carregado com sucesso!");
	print("\n");
}

new Str[100];
new Fala[128];
new Nome[MAX_PLAYER_NAME];
new id;
public OnFilterScriptInit()
{
	return 1;
}
	CMD:falar(playerid, params[])
	{
	    new Str2[30];
		if(sscanf(params, "s[128]", Fala)) return SendClientMessage(playerid, CINZA, "Use /falar [texto]");
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    format(Str, sizeof(Str), "http://translate.google.com/translate_tts?tl=pt&q=%s", Fala);
			PlayAudioStreamForPlayer(i, Str, 0, 0, 0, 0, 0);
		}
		GetPlayerName(playerid, Nome, sizeof(Nome));
		format(Str2, sizeof(Str2), "~h~~g~%s ~y~Falando", Nome);
		GameTextForAll(Str2, 1500, 1);
		return 1;
	}
	CMD:conversar(playerid, params[])
	{
	    GetPlayerName(playerid, Nome, sizeof(Nome));
	    new fStr[100];
	    if(sscanf(params, "is[128]", id, Fala)) return SendClientMessage(playerid, CINZA, "Use /conversar [id] [texto]");
	    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, AMARELO, "Jogador Offline");
	    if(id == playerid) return SendClientMessage(playerid, AMARELO, "Você não pode conversar consigo mesmo!");
		format(Str, sizeof(Str), "http://translate.google.com/translate_tts?tl=pt&q=%s", Fala);
		PlayAudioStreamForPlayer(id, Str, 0, 0, 0, 0, 0);
		PlayAudioStreamForPlayer(playerid, Str, 0, 0, 0, 0, 0);
		format(fStr, sizeof(fStr), "O jogador {1B91E0}%s[ID:%d]{00C2EC} está conversando com você, use /conversar", Nome, playerid);
		SendClientMessage(id, AZUL_CLARO, fStr);
		return 1;
	}
