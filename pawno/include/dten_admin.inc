/*  Dten Admin Functions
 *
 *  (c) Copyright 2012-2012, Dten Team
 *
 */

#if defined _admin_included
	#endinput
#endif
#define _admin_included
#pragma library admin

/*
native SetPlayerAdmin(playerid, lvl);
*/

#define tcadm 0x33AAFFFF

new pAdmin[MAX_PLAYERS];
new admin[MAX_PLAYERS];

stock PlayerSetPlayerAdmin(playerid, plid, lvl)
{
	new strfile[128], string[256];

	format(strfile, sizeof(strfile), PASTA_CONTAS, GetPlayerNameEx(plid));
	if(playerid != -1)
	{
		if(lvl >= 1)
		{
			admin[plid] = 1;
			pAdmin[plid] = lvl;
			dini_IntSet(strfile, "Admin", lvl);
			dini_IntSet(strfile, "aAdmin", 1);
			format(string, sizeof(string), "%s (%d) (») Promoveu: %s (%d) para ADM (») Level: %d", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(plid), plid, lvl);
			SendClientMessageToAll(tcadm, string);
		}
		if(lvl == 0)
		{
			admin[plid] = 0;
			pAdmin[plid] = 0;
			dini_IntSet(strfile, "Admin", 0);
			dini_IntSet(strfile, "aAdmin", 0);
			format(string, sizeof(string), "%s (%d) (») Retirou ADM do(a): %s (%d)", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(plid), plid);
			SendClientMessageToAll(tcadm, string);
		}
	}
	else
	{
		if(lvl >= 1)
		{
			admin[plid] = 1;
			pAdmin[plid] = lvl;
			dini_IntSet(strfile, "Admin", lvl);
			dini_IntSet(strfile, "aAdmin", 1);
			format(string, sizeof(string), "DtenBot (») Promoveu: %s (%d) para ADM (») Level: %d", GetPlayerNameEx(plid), plid, lvl);
			SendClientMessageToAll(tcadm, string);
		}
		if(lvl == 0)
		{
			admin[plid] = 0;
			pAdmin[plid] = 0;
			dini_IntSet(strfile, "Admin", 0);
			dini_IntSet(strfile, "aAdmin", 0);
			format(string, sizeof(string), "DtenBot (») Retirou ADM do(a): %s (%d)", GetPlayerNameEx(plid), plid);
			SendClientMessageToAll(tcadm, string);
		}
	}
	return 1;
}