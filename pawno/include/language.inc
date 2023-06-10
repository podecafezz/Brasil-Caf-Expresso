/*Sistema de Linguagem by Flávio Toribio*/

#include "a_samp"

/*
native msg(key, playerid = -1); //retorna uma mensagem, sem o parâmetro "playerid", manda com a lang global
native SetPlayerLanguage(playerid, lang[]); //define a linguagem de um jogador
native GetPlayerLanguage(playerid); //obtem a linguagem de um jogador
native SetGlobalLanguage(lang[]); //define a linguagem global do server
native GetGlobalLanguage(); //obtem a linguagem global do server
*/

new PlayerLanguage[MAX_PLAYERS][256];
new GlobalLanguage[256] = "brazilian";

stock SetPlayerLanguage(playerid, lang[])
{
	format(PlayerLanguage[playerid], 256, "%s", lang);
	return 1;
}

stock GetPlayerLanguage(playerid) return PlayerLanguage[playerid];

stock SetGlobalLanguage(lang[])
{
	format(GlobalLanguage, sizeof GlobalLanguage, "%s", lang);
	return 1;
}

stock GetGlobalLanguage() return GlobalLanguage;

/**
 * Função:      msg(key[], playerid = -1);
 * Descrição:   Retorna a mensagem definida na "key" dentro do arquivo delinguagem do playerid (se citado).
 * Parâmetro 1: key[] - Número da key definida nos arquivos de linguagem.
 * Parâmetro 2: playerid - ID do jogador para capturar sua linguagem e ]retornar a mensagem com tal linguagem.
 * Observações: Se o "playerid" não for mencionado, ou for igual a -1, a mensagem retornará na linguagem global.
 */

stock msg(key[], playerid = -1)
{
	new File:fohnd;
	new tmpres[256];
	new tmpres2[256];
	new languag[256];
	tmpres[0] = 0;
	if(playerid == -1)
	{
		format(languag, sizeof(languag), "%s.ini", GlobalLanguage);
	} else {
	    format(languag, sizeof(languag), "%s.ini", PlayerLanguage[playerid]);
	}
	fohnd = fopen(languag, io_read);
	if(!fohnd) return tmpres;
	while(fread(fohnd, tmpres))
	{
		new len = strlen(tmpres);
		if(tmpres[0] == 0) continue;
		if((tmpres[len - 1] == '\n') || (tmpres[len - 1] == '\r'))
		{
			tmpres[len - 1] = 0;
			if(tmpres[0]==0) continue;
			if((tmpres[len - 2] == '\n') || (tmpres[len - 2] == '\r')) tmpres[len - 2] = 0;
		}
		new equal;
		if(strlen(lang_PRIVATE_ini_GetKey(tmpres)) != strlen(key)) equal = 0;
    	if(!strcmp(lang_PRIVATE_ini_GetKey(tmpres), key, true)) equal = 1;
		if(equal)
		{
			tmpres2[0] = 0;
			strcat(tmpres2, lang_PRIVATE_ini_GetValue(tmpres));
			fclose(fohnd);
			return tmpres2;
		}
	}
	fclose(fohnd);
	return tmpres;
}

stock lang_PRIVATE_ini_GetKey(line[])
{
	new keyRes[256];
	keyRes[0] = 0;
    if(strfind(line, "=", true) == -1) return keyRes;
    strmid(keyRes, line, 0, strfind(line, "=", true), sizeof(keyRes));
    return keyRes;
}

stock lang_PRIVATE_ini_GetValue(line[])
{
	new valRes[256];
	valRes[0] = 0;
	if(strfind(line, "=", true) == -1) return valRes;
	strmid(valRes, line, strfind(line, "=", true) + 1, strlen(line), sizeof(valRes));
	return valRes;
}
