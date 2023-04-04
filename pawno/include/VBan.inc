/*
	Nome: VBan
	Descrição: Sistema de bans
	Autor: ViniBorn
	Contato: vini-elite@hotmail.com
*/

#include <Dini>

#define BanDir "/Bans/%s.ini" // Diretório dos bans
#define CorErro 0xAFAFAFAA
#define CorBan 0xE11D36AA

new VIP[32], Vnewban[32], Vstring[128], NICKBAN[20];

stock VBanID(playerid, giveid, motivo[])
{
	format(NICKBAN, 20, VBPlayer(giveid));
	if(playerid > -1)
	{
		format(Vstring, 128, "O(A) jogador(a) %s foi banido(a) por %s. Motivo: %s", VBPlayer(giveid), VBPlayer(playerid), motivo);
		SendClientMessageToAll(CorBan, Vstring);
		GetPlayerIp(giveid, VIP, sizeof(VIP));
		format(Vnewban, 32, BanDir, VIP);
		dini_Create(Vnewban);
		VBanSaveInfo(playerid, Vnewban, motivo);
		format(Vnewban, 32, BanDir, VBPlayer(giveid));
		dini_Create(Vnewban);
		VBanSaveInfo(playerid, Vnewban, motivo);
	}
	else
	{
		format(Vstring, 128, "O(A) jogador(a) %s foi banido(a) por DtenBot. Motivo: %s", VBPlayer(giveid), motivo);
		SendClientMessageToAll(CorBan, Vstring);
		format(Vnewban, 32, BanDir, VBPlayer(giveid));
		dini_Create(Vnewban);
		VBanSaveInfo(-1, Vnewban, motivo);
	}
	if(IsPlayerConnected(giveid))
	{
		if(IsPlayerNPC(giveid))
		{
			Ban(giveid);
		}
		else
		{
			VBanLoadInfo(giveid, Vnewban);
			Ban(giveid);
		}
	}
	return 1;
}

stock VBanNick(playerid, nick[], motivo[])
{
	format(Vnewban, 32, BanDir, nick);
	if(dini_Exists(Vnewban))
	{
		return SendClientMessage(playerid, CorErro, "Este nick já está banido!");
	}
	new giveid = VBReturnUser(nick);
	if(!IsPlayerConnected(giveid))
	{
		format(NICKBAN, 20, nick);
		format(Vstring, 128, "O nick %s foi banido por %s. Motivo: %s", nick, VBPlayer(playerid), motivo);
		SendClientMessageToAll(CorBan, Vstring);
		dini_Create(Vnewban);
		return VBanSaveInfo(playerid, Vnewban, motivo);
	}
	else
	{
		return VBanID(playerid, giveid, motivo);
	}
}

stock VBanIP(playerid, IP2[], motivo[])
{
	format(Vnewban, 32, BanDir, IP2);
	if(dini_Exists(Vnewban))
	{
		return SendClientMessage(playerid, CorErro, "Este IP já está banido!");
	}
	if(playerid > -1)
	{
		new ban;
		for(new i=0, j = MAX_PLAYERS; i < j; i++)
		{
			if(IsPlayerConnected(i))
			{
				GetPlayerIp(i, VIP, sizeof(VIP));
				if(!strcmp(VIP, IP2))
				{
				ban++;
				VBanID(playerid, i, motivo);
				}
			}
			if(ban == 0)
			{
				dini_Create(Vnewban);
				format(Vstring, 128, "O IP %s foi banido por %s. Motivo: %s", IP2, VBPlayer(playerid), motivo);
				SendClientMessageToAll(CorBan, Vstring);
				VBanSaveInfo(playerid, Vnewban, motivo);
			}
		}
	}
	else
	{
		format(Vnewban, 32, BanDir, IP2);
		dini_Create(Vnewban);
		format(Vstring, 128, "O IP %s foi banido por DtenBot. Motivo: Ban Evade", IP2);
		SendClientMessageToAll(CorBan, Vstring);
		VBanSaveInfo(-1, Vnewban, "Ban Evade");
	}
	return 1;
}

stock VUnBan(playerid, Arq[])
{
	format(Vnewban, 32, BanDir, Arq);
	if(!dini_Exists(Vnewban))
	{
		return SendClientMessage(playerid, CorErro, "Ban inexistente!");
	}
	new BANNEDIP[32];
	new RCONUNBANIP[128];
	format(BANNEDIP, 32, BanDir, dini_Get(Vnewban, "IP"));
	format(RCONUNBANIP, 128, "unbanip %s", dini_Get(Vnewban, "IP"));
	if(dini_Exists(BANNEDIP))
	{
		new BANNEDACC[32];
		if(VBIsIP(Arq))
		{
			format(Vstring, 128, "O IP %s(%s) foi desbanido por %s.", Arq, dini_Get(Vnewban, "Nick"), VBPlayer(playerid));
		}
		else
		{
			format(Vstring, 128, "A conta %s(%s) foi desbanida por %s.", Arq, dini_Get(Vnewban, "IP"), VBPlayer(playerid));
		}
		format(BANNEDACC, 32, BanDir, dini_Get(Vnewban, "Nick"));
		SendRconCommand(RCONUNBANIP);
		dini_Remove(BANNEDACC);
		dini_Remove(BANNEDIP);
	}
	else
	{
		format(Vstring, 128, "A conta %s foi desbanida por %s.", Arq, VBPlayer(playerid));
	}
	SendClientMessageToAll(0x10B4EEAA, Vstring);
	dini_Remove(Vnewban);
	return 1;
}

stock VBanCheck(playerid)
{
	format(Vnewban, 32, BanDir, VBPlayer(playerid));
	if(dini_Exists(Vnewban))
	{
		VBanLoadInfo(playerid, Vnewban);
		GetPlayerIp(playerid, VIP, sizeof(VIP));
		VBanIP(-1, VIP, dini_Get(Vnewban, "Motivo"));
		return Ban(playerid);
	}
	GetPlayerIp(playerid, VIP, sizeof(VIP));
	format(Vnewban, 32, BanDir, VIP);
	if(dini_Exists(Vnewban))
	{
		VBanLoadInfo(playerid, Vnewban);
		format(NICKBAN, 20, VBPlayer(playerid));
		dini_Set(Vnewban, "Nick", NICKBAN);
		VBanID(-1, playerid, dini_Get(Vnewban, "Motivo"));
		return Ban(playerid);
	}
	return 1;
}

stock VBanLoadInfo(playerid, Varq[])
{
	if(!dini_Exists(Varq))
	{
		return SendClientMessage(playerid, CorErro, "Ban inexistente!");
	}
	new InfoString[256];
	SendClientMessage(playerid, -1, "......:::::: Banido ::::::......");
	format(InfoString, 256, "{FFFFFF}Nick: {00FF00}%s {FFFFFF}- IP: {00FF00}%s", dini_Get(Varq, "Nick"), dini_Get(Varq, "IP"));
	SendClientMessage(playerid, -1, InfoString);
	format(InfoString, 256, "{FFFFFF}Admin: {00FF00}%s {FFFFFF}- Motivo: {00FF00}%s", dini_Get(Varq, "Admin"), dini_Get(Varq, "Motivo"));
	SendClientMessage(playerid, -1, InfoString);
	format(InfoString, 256, "{FFFFFF}Data: {00FF00}%s {FFFFFF}- Horário: {00FF00}%s", dini_Get(Varq, "Data"), dini_Get(Varq, "Hora"));
	SendClientMessage(playerid, -1, InfoString);
	SendClientMessage(playerid, -1, "......:::::: Banido ::::::......");
	return 1;
}

stock VBanSaveInfo(playerid, Varq[], motivo[])
{
	new Vano, Vmes, Vdia, Vhora, Vminuto, Vsegundo;
	getdate(Vano, Vmes, Vdia);
	gettime(Vhora, Vminuto, Vsegundo);
	dini_Set(Varq, "IP", VIP);
	dini_Set(Varq, "Nick", NICKBAN);
	if(playerid > -1)
	{
		dini_Set(Varq, "Admin", VBPlayer(playerid));
	}
	else
	{
		dini_Set(Varq, "Admin", "DtenBot Admin");
	}
	format(Vstring, 32, "%02d:%02d:%02d", Vhora, Vminuto, Vsegundo);
	dini_Set(Varq, "Hora", Vstring);
	format(Vstring, 32, "%02d/%02d/%d", Vdia, Vmes, Vano);
	dini_Set(Varq, "Data", Vstring);
	dini_Set(Varq, "Motivo", motivo);
	return 1;
}

stock VBPlayer(playerid)
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	return pname;
}

stock VBReturnUser(PlayerName[])
{
	if(VBIsNumeric(PlayerName))
	{
		return strval(PlayerName);
	}
	else
	{
		new found=0, id;
		for(new i=0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				new foundname[MAX_PLAYER_NAME];
				GetPlayerName(i, foundname, MAX_PLAYER_NAME);
				new namelen = strlen(foundname);
				new bool:searched = false;
				for(new pos=0; pos <= namelen; pos++)
				{
					if(searched != true)
					{
						if(strfind(foundname, PlayerName, true) == pos)
						{
							found++;
							id = i;
						}
					}
				}
			}
		}
		if(found == 1)
		{
			return id;
		}
		else
		{
			return INVALID_PLAYER_ID;
		}
	}
}

stock VBIsIP(const string[])
{
	new count;
	for(new i = 0, j = strlen(string); i < j; i++)
	{
		if(string[i] > 47 && string[i] < 58)
		{
			count++;
		}
		if(count > 5)
		{
			return 1;
		}
	}
	return 0;
}

stock VBIsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if(string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}