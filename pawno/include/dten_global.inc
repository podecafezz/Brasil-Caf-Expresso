/*  Dten Global Functions
 *
 *  (c) Copyright 2012-2012, Dten Team
 *
 */

#if defined _global_included
	#endinput
#endif
#define _global_included
#pragma library global

// Arquivos
#define PASTA_CONTAS "/Contas/%s.ini"
#define PASTA_VIPS "/Vips/%s.ini"
#define PASTA_CASAS "/Casas/casa%d.ini"
#define PASTA_PROPS "/Props/prop%d.ini"
#define PASTA_CONCE "/Conce/carro%d.ini"
#define PASTA_Int "/Interiores/int%d.ini"
#define PASTA_PORTOES "/Portoes/p%d.ini"

/*
native GetPlayerNameEx(playerid);
native GetPlayerIPEx(playerid);
native ReconnectPlayer(playerid);
native CreateFileAccount(newfile[], passx[]);
native RenameFileAccount(oldfile[], newfile[]);
native SoltarPlayer(presoid);
native PrenderPlayer(presoid);
*/

new file[128];
new file2[128];
new STRX[256];

new Preso[MAX_PLAYERS] = 0;
new preso[MAX_PLAYERS] = 0;
new algemado[MAX_PLAYERS] = 0;
new infratores[MAX_PLAYERS] = 0;
new Procurados[MAX_PLAYERS] = 0;
new presonadp[MAX_PLAYERS] = -1;
new PRAND[MAX_PLAYERS];

enum PrEnumSF
{
	Float:prX,
	Float:prY,
	Float:prZ
};

new CadeiasSF[4][PrEnumSF] =
{
	{227.0059, 108.5802, 999.0156},
	{222.8550, 108.4233, 999.0156},
	{219.0326, 108.8183, 999.0156},
	{214.9467, 108.5256, 999.0156}
};

stock GetPlayerNameEx(playerid)
{
	new PlayerNameLevel[MAX_PLAYER_NAME];
	GetPlayerName(playerid, PlayerNameLevel, MAX_PLAYER_NAME);
	return PlayerNameLevel;
}

stock GetPlayerIPEx(playerid)
{
	new PlayerIPLevel[20];
	GetPlayerIp(playerid, PlayerIPLevel, sizeof(PlayerIPLevel));
	return PlayerIPLevel;
}

stock ReconnectPlayer(playerid)
{
	OnPlayerDisconnect(playerid, 3);
	SetTimerEx("OnPlayerConnect", 1000, false, "e", playerid);
	return 0;
}

stock CreateFileAccount(newfile[], passx[])
{
	dini_Create(newfile);
	dini_Set(newfile, "Senha", passx);
	dini_IntSet(newfile, "Skin", 0);
	dini_IntSet(newfile, "Profissao", 0);
	dini_IntSet(newfile, "ContaBancaria", 0);
	dini_IntSet(newfile, "SaldoBancario", 0);
	dini_IntSet(newfile, "Dinheiro", 15000);
	dini_IntSet(newfile, "Combustivel", 200);
	dini_IntSet(newfile, "Celular", 0);
	dini_IntSet(newfile, "CartaoTelefonico", 0);
	dini_IntSet(newfile, "MP3", 0);
	dini_IntSet(newfile, "LaserP", 0);
	dini_IntSet(newfile, "TCapacete", 0);
	dini_IntSet(newfile, "AntiHS", 0);
	dini_IntSet(newfile, "Sexo", 0);
	dini_IntSet(newfile, "HabTerrestre", 0);
	dini_IntSet(newfile, "HabAerea", 0);
	dini_IntSet(newfile, "HabNautica", 0);
	dini_IntSet(newfile, "Matou", 0);
	dini_IntSet(newfile, "Morreu", 0);
	dini_IntSet(newfile, "Preso", 0);
	dini_IntSet(newfile, "Bloco", 0);
	dini_IntSet(newfile, "Casa", 0);
	dini_IntSet(newfile, "Prop", 0);
	dini_IntSet(newfile, "Carta", 0);
	dini_Set(newfile, "Lembrete", "Nada");
	dini_IntSet(newfile, "Casado", 0);
	dini_Set(newfile, "CasouCom", "Ninguem");
	dini_IntSet(newfile, "Continuar", 0);
	dini_IntSet(newfile, "novato", 1);
	dini_IntSet(newfile, "Porte", 0);
	dini_IntSet(newfile, "Carteira", 0);
	dini_IntSet(newfile, "Level", 50);
	dini_IntSet(newfile, "Faculdade", 30);
	dini_IntSet(newfile, "UsouConce", 0);
	dini_IntSet(newfile, "VIP", 0);
	dini_IntSet(newfile, "aAdmin", 0);
	dini_IntSet(newfile, "Admin", 0);
	return 0;
}

stock RenameFileAccount(oldfile[], newfile[])
{
	new mnsenha[256];
	new mnskin;
	new mnprocurado;
	new mnlutas;
	new mnpreso;
	new mnentrevista;
	new mnsaldobancario;
	new mndinheiro;
	new mncombustivel;
	new mnprof;
	new mncel;
	new mnbloco;
	new mnlevel;
	new mntempo;
	new mnexp;
	new mnmp3;
	new mnlaser;
	new mncapacete;
	new mnantihs;
	new mnsexo;
	new mnporte;
	new mncarteira;
	new mnhabt;
	new mnhabn;
	new mnhaba;
	new mncontabancaria;
	new mndm;
	new mnmatou;
	new mnmorreu;
	new mncasa;
	new Float:mncasax;
	new Float:mncasay;
	new Float:mncasaz;
	new mnprop;
	new Float:mnpropx;
	new Float:mnpropy;
	new Float:mnpropz;
	new mnlembrete[256];
	new mncasado;
	new mncasoucom[256];
	new mnfacul;
	new mnroubobanco;
	new mnhotel;
	new mnluta;
	new mnusouconce;
	new mnvip;
	new mnaadmin;
	new mnadmin;

	mnsenha = dini_Get(oldfile, "Senha");
	mnskin = dini_Int(oldfile, "Skin");
	mnprocurado = dini_Int(oldfile, "Procurado");
	mnlutas = dini_Int(oldfile, "Lutas");
	mnpreso = dini_Int(oldfile, "Preso");
	mnentrevista = dini_Int(oldfile, "Entrevista");
	mnsaldobancario = dini_Int(oldfile, "SaldoBancario");
	mndinheiro = dini_Int(oldfile, "Dinheiro");
	mncombustivel = dini_Int(oldfile, "Combustivel");
	mnprof = dini_Int(oldfile, "Profissao");
	mncel = dini_Int(oldfile, "Celular");
	mnbloco = dini_Int(oldfile, "Bloco");
	mnlevel = dini_Int(oldfile, "Level");
	mntempo = dini_Int(oldfile, "Tempo");
	mnexp = dini_Int(oldfile, "EXP");
	mnmp3 = dini_Int(oldfile, "MP3");
	mnlaser = dini_Int(oldfile, "LaserP");
	mncapacete = dini_Int(oldfile, "TCapacete");
	mnantihs = dini_Int(oldfile, "AntiHS");
	mnsexo = dini_Int(oldfile, "Sexo");
	mnporte = dini_Int(oldfile, "Porte");
	mncarteira = dini_Int(oldfile, "Carteira");
	mnhabt = dini_Int(oldfile, "HabTerrestre");
	mnhabn = dini_Int(oldfile, "HabNautica");
	mnhaba = dini_Int(oldfile, "HabAerea");
	mncontabancaria = dini_Int(oldfile, "ContaBancaria");
	mndm = dini_Int(oldfile, "DM");
	mnmatou = dini_Int(oldfile, "Matou");
	mnmorreu = dini_Int(oldfile, "Morreu");
	mncasa = dini_Int(oldfile, "Casa");
	mncasax = dini_Float(oldfile, "CasaX");
	mncasay = dini_Float(oldfile, "CasaY");
	mncasaz = dini_Float(oldfile, "CasaZ");
	mnprop = dini_Int(oldfile, "Prop");
	mnpropx = dini_Float(oldfile, "PropX");
	mnpropy = dini_Float(oldfile, "PropY");
	mnpropz = dini_Float(oldfile, "PropZ");
	mnlembrete = dini_Get(oldfile, "Lembrete");
	mncasado = dini_Int(oldfile, "Casado");
	mncasoucom = dini_Get(oldfile, "CasouCom");
	mnfacul = dini_Int(oldfile, "Faculdade");
	mnroubobanco = dini_Int(oldfile, "rouboubanco");
	mnhotel = dini_Int(oldfile, "Hotel");
	mnluta = dini_Int(oldfile, "Luta");
	mnusouconce = dini_Int(oldfile, "UsouConce");
	mnvip = dini_Int(oldfile, "VIP");
	mnaadmin = dini_Int(oldfile, "aAdmin");
	mnadmin = dini_Int(oldfile, "Admin");
	dini_Remove(oldfile);

	dini_Create(newfile);
	dini_Set(newfile, "Senha", mnsenha);
	dini_IntSet(newfile, "Skin", mnskin);
	dini_IntSet(newfile, "Procurado", mnprocurado);
	dini_IntSet(newfile, "Lutas", mnlutas);
	dini_IntSet(newfile, "Preso", mnpreso);
	dini_IntSet(newfile, "Entrevista", mnentrevista);
	dini_IntSet(newfile, "SaldoBancario", mnsaldobancario);
	dini_IntSet(newfile, "Dinheiro", mndinheiro);
	dini_IntSet(newfile, "Combustivel", mncombustivel);
	dini_IntSet(newfile, "Profissao", mnprof);
	dini_IntSet(newfile, "Celular", mncel);
	dini_IntSet(newfile, "Bloco", mnbloco);
	dini_IntSet(newfile, "Level", mnlevel);
	dini_IntSet(newfile, "Tempo", mntempo);
	dini_IntSet(newfile, "EXP", mnexp);
	dini_IntSet(newfile, "MP3", mnmp3);
	dini_IntSet(newfile, "LaserP", mnlaser);
	dini_IntSet(newfile, "TCapacete", mncapacete);
	dini_IntSet(newfile, "AntiHS", mnantihs);
	dini_IntSet(newfile, "Sexo", mnsexo);
	dini_IntSet(newfile, "Porte", mnporte);
	dini_IntSet(newfile, "Carteira", mncarteira);
	dini_IntSet(newfile, "HabTerrestre", mnhabt);
	dini_IntSet(newfile, "HabNautica", mnhabn);
	dini_IntSet(newfile, "HabAerea", mnhaba);
	dini_IntSet(newfile, "ContaBancaria", mncontabancaria);
	dini_IntSet(newfile, "DM", mndm);
	dini_IntSet(newfile, "Matou", mnmatou);
	dini_IntSet(newfile, "Morreu", mnmorreu);
	dini_IntSet(newfile, "Casa", mncasa);
	dini_FloatSet(newfile, "CasaX", mncasax);
	dini_FloatSet(newfile, "CasaY", mncasay);
	dini_FloatSet(newfile, "CasaZ", mncasaz);
	dini_IntSet(newfile, "Prop", mnprop);
	dini_FloatSet(newfile, "PropX", mnpropx);
	dini_FloatSet(newfile, "PropY", mnpropy);
	dini_FloatSet(newfile, "PropZ", mnpropz);
	dini_Set(newfile, "Lembrete", mnlembrete);
	dini_IntSet(newfile, "Casado", mncasado);
	dini_Set(newfile, "CasouCom", mncasoucom);
	dini_IntSet(newfile, "Faculdade", mnfacul);
	dini_IntSet(newfile, "rouboubanco", mnroubobanco);
	dini_IntSet(newfile, "Hotel", mnhotel);
	dini_IntSet(newfile, "Luta", mnluta);
	dini_IntSet(newfile, "MN", 0);
	dini_IntSet(newfile, "UsouConce", mnusouconce);
	dini_IntSet(newfile, "VIP", mnvip);
	dini_IntSet(newfile, "aAdmin", mnaadmin);
	dini_IntSet(newfile, "Admin", mnadmin);
	return 0;
}

stock SoltarPlayer(presoid)
{
	format(file2, sizeof(file2), PASTA_CONTAS, GetPlayerNameEx(presoid));

	preso[presoid] = 0;
	Preso[presoid] = 0;
	algemado[presoid] = 0;
	infratores[presoid] = 0;
	Procurados[presoid] = 0;

	dini_IntSet(file2, "Procurado", 0);
	dini_IntSet(file2, "Preso", 0);

	dini_IntSet(file2, "ofmaconha", 0);
	dini_IntSet(file2, "ofcocaina", 0);
	dini_IntSet(file2, "ofcrack", 0);
	dini_IntSet(file2, "tmaconha", 0);
	dini_IntSet(file2, "tcrack", 0);
	dini_IntSet(file2, "tcocaina", 0);
	dini_IntSet(file2, "Maconha", 0);
	dini_IntSet(file2, "Crack", 0);
	dini_IntSet(file2, "Cocaina", 0);

	SetPlayerWantedLevel(presoid, 0);
	SetPlayerHealth(presoid, 100.0);

	if(presonadp[presoid] == 0)
	{
		presonadp[presoid] = -1;
		SetPlayerInterior(presoid, 0);
		SetPlayerPos(presoid, 1538.7277, -1675.6129, 13.5468); // DPExLS
	}
	else if(presonadp[presoid] == 1)
	{
		presonadp[presoid] = -1;
		SetPlayerInterior(presoid, 0);
		SetPlayerPos(presoid, -1605.3535, 718.0169, 11.9474); // DPExSF
	}
	else if(presonadp[presoid] == 2)
	{
		presonadp[presoid] = -1;
		SetPlayerInterior(presoid, 0);
		SetPlayerPos(presoid, 2287.0131, 2421.5007, 10.8203); // DPExLV
	}
	else if(presonadp[presoid] == 3)
	{
		presonadp[presoid] = -1;
		SetPlayerInterior(presoid, 0);
		SetPlayerPos(presoid, -204.9153, 979.9788, 19.0849); // DPExFC
	}
	return 1;
}

stock PrenderPlayer(presoid)
{
	format(file2, sizeof(file2), PASTA_CONTAS, GetPlayerNameEx(presoid));

	preso[presoid] = 1;
	Procurados[presoid] = 0;
	infratores[presoid] = 0;
	dini_IntSet(file2, "Preso", 1);
	dini_IntSet(file2, "Procurado", 0);

	ResetPlayerWeapons(presoid);
	SetPlayerHealth(presoid, 999999.0);
	SetPlayerWantedLevel(presoid, 0);
	SetPlayerInterior(presoid, 6);
	TogglePlayerControllable(presoid, 1);

	if(GetClosestDelegacia(presoid) == 0)
	{
		presonadp[presoid] = 0;
		PRAND[presoid] = random(sizeof CadeiasSF);

		SetPlayerInterior(presoid, 10);
		SetPlayerPos(presoid, CadeiasSF[PRAND[presoid]][prX], CadeiasSF[PRAND[presoid]][prY], CadeiasSF[PRAND[presoid]][prZ]); // DPExSF Prisão
	}
	else if(GetClosestDelegacia(presoid) == 1)
	{
		presonadp[presoid] = 1;
		PRAND[presoid] = random(sizeof CadeiasSF);

		SetPlayerInterior(presoid, 10);
		SetPlayerPos(presoid, CadeiasSF[PRAND[presoid]][prX], CadeiasSF[PRAND[presoid]][prY], CadeiasSF[PRAND[presoid]][prZ]); // DPExSF Prisão
	}
	else if(GetClosestDelegacia(presoid) == 2)
	{
		presonadp[presoid] = 2;
		PRAND[presoid] = random(sizeof CadeiasSF);

		SetPlayerInterior(presoid, 10);
		SetPlayerPos(presoid, CadeiasSF[PRAND[presoid]][prX], CadeiasSF[PRAND[presoid]][prY], CadeiasSF[PRAND[presoid]][prZ]); // DPExSF Prisão
	}
	else if(GetClosestDelegacia(presoid) == 3)
	{
		presonadp[presoid] = 3;
		SetPlayerInterior(presoid, 6);
		SetPlayerPos(presoid, 263.8820, 77.4002, 1001.0391); // DPExLS Prisão
	}
	return 1;
}