/*============================================================================*\
|                     INCLUDE FEITO POR ..::STAKLINE::..                        |
|           Originalmente postada em: WWW.HOMEHOTS.BLOGSPOT.COM                 |
\*============================================================================*/

#include <a_samp>
#if defined _SdL_included
#endinput
#endif
#define _SdL_included
#pragma library SdL

/*
native SDL_GetPlayerLevel(playerid)
native SDL_SetPlayerLevel(playerid, level)
*/ 
forward SDL_GetPlayerLevel(playerid);
public SDL_GetPlayerLevel(playerid)
{
		new Argument[1][10], entry[256], str[32], nome[MAX_PLAYER_NAME], sdl_level[MAX_PLAYERS];

		GetPlayerName(playerid, nome, sizeof(nome));
		format(str, sizeof(str), "SDL_Players/%s.sdl", nome);
		new File: Arquivo = fopen(str, io_read);
	    if (Arquivo)
		{
                
				fread(Arquivo, entry);
				sdl_split(entry, Argument, ',');
                sdl_level[playerid]			=  	  strval(Argument[0]);
				fclose(Arquivo);
		}
		return sdl_level[playerid];
}

forward SDL_SetPlayerLevel(playerid,level);
public SDL_SetPlayerLevel(playerid, level)
{
	new str[32];
	new nome[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nome, sizeof(nome));
	format(str, sizeof(str), "SDL_Players/%s.sdl", nome);
	new entry[128];
	new File: Arquivo = fopen(str, io_write);
	format(entry, 128, "%d",level);
	fwrite(Arquivo, entry);   
	fclose(Arquivo);
}

forward sdl_split(const strsrc[], strdest[][], delimiter);
public sdl_split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}
/*============================================================================*\
|                     INCLUDE FEITO POR ..::STAKLINE::..                        |
|                     VISITEM -=> WWW.HOMEHOTS.BLOGSPOT.COM                     |
\*============================================================================*/
