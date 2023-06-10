/*  Dten VIP's Functions
 *
 *  (c) Copyright 2012-2012, Dten Team
 *
 */

#if defined _vips_included
	#endinput
#endif
#define _vips_included
#pragma library vips

/*
native SetPlayerVIP(playerid, days);
native UnsetPlayerVIP(playerid);
native RenameFileVIP(oldfile[], newfile[]);
native CheckPlayerVIP(playerid);
native GetVIPDays(playerid);
native IsPlayerVIP(playerid);
*/

new vip[MAX_PLAYERS];
new filev[128];
new filev2[128];

stock SetPlayerVIP(playerid, days)
{
	if(IsPlayerConnected(playerid))
	{
		new VIPS[128], ACCS[128], STRV[128];

		new year, month, day;
		getdate(year, month, day);

		format(VIPS, sizeof(VIPS), PASTA_VIPS, GetPlayerNameEx(playerid));
		if(!dini_Exists(VIPS))
		{
			dini_Create(VIPS);
		}
		dini_IntSet(VIPS, "Dias", dini_Int(VIPS, "Dias")+days);
		format(STRV, sizeof(STRV), "%d/%d/%d", day, month, year);
		dini_Set(VIPS, "DataSet", STRV);

		format(ACCS, sizeof(ACCS), PASTA_CONTAS, GetPlayerNameEx(playerid));
		dini_IntSet(ACCS, "UsouConce", 0);
		dini_IntSet(ACCS, "VIP", 1);
		vip[playerid] = 1;
	}
	return 1;
}

stock RenameFileVIP(oldfile[], newfile[])
{
	new mndias;
	new mndataset[256];
	new mnusouconce;
	new mnvip;

	mndias = dini_Int(oldfile, "Dias");
	mndataset = dini_Get(oldfile, "DataSet");
	mnusouconce = dini_Int(oldfile, "UsouConce");
	mnvip = dini_Int(oldfile, "VIP");
	dini_Remove(oldfile);

	dini_Create(newfile);
	dini_IntSet(newfile, "Dias", mndias);
	dini_Set(newfile, "DataSet", mndataset);
	dini_IntSet(newfile, "UsouConce", mnusouconce);
	dini_IntSet(newfile, "VIP", mnvip);
	return 1;
}

stock UnsetPlayerVIP(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new VIPS[128], ACCS[128];

		format(VIPS, sizeof(VIPS), PASTA_VIPS, GetPlayerNameEx(playerid));
		if(dini_Exists(VIPS))
		{
			dini_Remove(VIPS);
		}
		format(ACCS, sizeof(ACCS), PASTA_CONTAS, GetPlayerNameEx(playerid));
		dini_IntSet(ACCS, "VIP", 0);
		vip[playerid] = 0;
	}
	return 1;
}

stock CheckPlayerVIP(playerid)
{
	new VIPS[128], ACCS[128], STRV[128];

	new year, month, day;
	getdate(year, month, day);

	format(ACCS, sizeof(ACCS), PASTA_CONTAS, GetPlayerNameEx(playerid));
	if(dini_Exists(ACCS))
	{
		format(VIPS, sizeof(VIPS), PASTA_VIPS, GetPlayerNameEx(playerid));
		if(dini_Exists(VIPS))
		{
			format(STRV, sizeof(STRV), "%d/%d/%d", day, month, year);
			if(strcmp(dini_Get(VIPS, "DataSet"), STRV, true) != 0)
			{
				dini_Set(VIPS, "DataSet", STRV);
				dini_IntSet(VIPS, "Dias", dini_Int(VIPS, "Dias")-1);
			}
			if(dini_Int(VIPS, "Dias") > 0)
			{
				#if defined AntiCheatUser
				CheckSet(0, playerid, false);
				SetWeaponAllowed(playerid, 38, true);
				SetWeaponAllowed(playerid, 35, true);
				SetWeaponAllowed(playerid, 36, true);
				SetWeaponAllowed(playerid, 37, true);
				SetWeaponAllowed(playerid, 39, true);
				SetWeaponAllowed(playerid, 40, true);
				#endif

				dini_IntSet(ACCS, "VIP", 1);
				vip[playerid] = 1;

				SendClientMessage(playerid, -1, "Você é um jogador VIP, aproveite!");
				SendClientMessage(playerid, -1, "Veja os comandos em /comandosvip");
			}
			else
			{
				#if defined AntiCheatUser
				CheckSet(0, playerid, true);
				SetWeaponAllowed(playerid, 38, false);
				SetWeaponAllowed(playerid, 35, false);
				SetWeaponAllowed(playerid, 36, false);
				SetWeaponAllowed(playerid, 37, false);
				SetWeaponAllowed(playerid, 39, false);
				SetWeaponAllowed(playerid, 40, false);
				#endif

				UnsetPlayerVIP(playerid);

				SendClientMessage(playerid, -1, "Seus dias de VIP acabaram!");
				SendClientMessage(playerid, -1, "Compre mais e divirta-se.");
			}
		}
		else
		{
			#if defined AntiCheatUser
			CheckSet(0, playerid, true);
			SetWeaponAllowed(playerid, 38, false);
			SetWeaponAllowed(playerid, 35, false);
			SetWeaponAllowed(playerid, 36, false);
			SetWeaponAllowed(playerid, 37, false);
			SetWeaponAllowed(playerid, 39, false);
			SetWeaponAllowed(playerid, 40, false);
			#endif

			dini_IntSet(ACCS, "VIP", 0);
			vip[playerid] = 0;
		}
	}
	return 1;
}

stock GetVIPDays(playerid)
{
	new VIPS[128];

	format(VIPS, sizeof(VIPS), PASTA_VIPS, GetPlayerNameEx(playerid));
	if(dini_Exists(VIPS))
	{
		return dini_Int(VIPS, "Dias");
	}
	else
	{
		return 0;
	}
}

stock IsPlayerVIP(playerid)
{
	return vip[playerid];
}