#include "PGD"

#define VGS_MALBOT_INCLUDE

#define ARQ_VGSAMBCFG "VGS Anti MalBot CFG.txt"
#define ARQ_VGSAMBLOG "VGS Anti MalBot Log.txt"


/*
native vgsamb_ChecarNomeMalBot(playerid);
*/

new
	kickados,
	banidos,
	FExpulso,
	vgsamb_Nome[MAX_PLAYER_NAME],
	vgsamb_IP[20],
	vgsamb_np[][] =
	{
		"Banir",
		"Kickar"
	},
	vgsamb_NomeMalBot[][] =
	{
		"com1",
		"com2",
		"com3",
		"com4",
		"com5",
		"com6",
		"com7",
		"com8",
		"com9",
		"lpt1",
		"lpt2",
		"lpt3",
		"lpt4",
		"lpt5",
		"lpt6",
		"lpt7",
		"lpt8",
		"lpt9",
		"nul",
		"clock$",
		"aux",
		"prn",
		"con",
		"Carl",
		"Rocky",
		"Pepe",
		"Arnoldo",
		"SgtPepper",
		"Pepsi",
		"Pepno",
		"Azucar",
		"Vino_Toro",
		"Zoquete",
		"Pacman",
		"Batman",
		"AquilesBrinco",
		"Manfrey",
		"Sopapeala",
		"Papirola",
		"Sony",
		"[ViP]Labrik",
		"[MT]Lavis"
	};
	
stock vgsamb_Definir()
{
	if(!pgd_ArquivoExiste(ARQ_VGSAMBCFG)) pgd_EscreverInt(ARQ_VGSAMBCFG, "Banir", ":", 1);
	new checar = pgd_CarregarInt(ARQ_VGSAMBCFG, "Banir", ":");
	if(checar) FExpulso = 0;
	else FExpulso = 1;
}

stock vgsamb_SalvarDef(valor)
{
    FExpulso = valor;
	pgd_EscreverInt(ARQ_VGSAMBCFG, "Banir", ":", FExpulso);
}

stock BotLog(log[])
{
	new
		strlog[162],
		Hora, Minuto, Segundo, Dia, Mes, Ano;

    gettime(Hora, Minuto, Segundo);
    getdate(Ano, Mes, Dia);
 	format(strlog, sizeof(strlog), "[%d/%d/%d %d:%d:%d] %s\r\n", Dia, Mes, Ano, Hora, Minuto, Segundo, log);
	pgd_EscreverArquivo(ARQ_VGSAMBLOG, strlog);
}

stock vgsamb_ChecarNomeMalBot(playerid)
{
	GetPlayerName(playerid, vgsamb_Nome, sizeof(vgsamb_Nome));
	new tAB = sizeof(vgsamb_NomeMalBot);
	for(new n; n < tAB; n++)
	{
	    if(!strcmp(vgsamb_Nome, vgsamb_NomeMalBot[n], true))
		{
            if(!FExpulso) vgsamb_Punir(playerid, vgsamb_Nome, "BANIDO");
			else vgsamb_Punir(playerid, vgsamb_Nome, "KICKADO");
		}
	}
}

stock vgsamb_Punir(playerid, nome[], modo[])
{
	new	string[132];
	GetPlayerIp(playerid, vgsamb_IP, sizeof(vgsamb_IP));
	
	format(string, sizeof(string), "[VGS Anti MalBot]: Você foi %s! Motivo: MalBot!", modo);
    SendClientMessage(playerid, 0xEE0000AA, string);
	format(string, sizeof(string), "[VGS Anti MalBot]: IP %s %s por tentar sabotar o servidor (MalBot).", vgsamb_IP, modo);
    SendClientMessageToAll(0xEE0000AA, string);
	printf("[VGS Anti MalBot]: IP %s kickado por tentar sabotar o servidor.",vgsamb_IP);
	format(string, sizeof(string), "%s: %s ( IP %s )", modo, nome, vgsamb_IP);
	BotLog(string);
	if(!strcmp(modo, "kickado", true))
	{
		kickados++;
		Kick(playerid);
	}
	else
	{
		banidos++;
		Ban(playerid);
	}
}

