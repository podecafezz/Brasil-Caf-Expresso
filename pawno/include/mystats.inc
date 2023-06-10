#if defined _mystats_included
  #endinput
#endif

#include <a_samp>
#include <dutils>
#include <a_aDini>
#include <a_asavegang>

#pragma tabsize 0

//#define BantFile 				"Administracao/Nicks_Banidos_Temp.txt"
//#define BantipFile 			"Administracao/IPs_Banidos_Temp.txt"
#define BanFile 				"Administracao/Info_Banidos.ini"
//#define BanipFile 			"Administracao/IPs_Banidos_Perm.txt"
#define BanTempSistema          "Administracao/Timer_Banidos.ini"
#define AreasDominadas  		"AreasDominadas.txt"
#define BasesDominadas  		"BasesDominadas.txt"
#define PropriedadesDominadas	"PropriedadesDominadas.txt"
#define Mensagens       		"Mensagens.txt"
#define AntiBot      			"IPs_Liberados.txt"


#define BanidorAuto             "AntiCheat"
//colores PADROES
#define COLOR_CINZA 			0xAFAFAFAA
#define COLOR_PRETO 			0x000000AA
#define COLOR_VERDE 			0x33AA33AA
#define COLOR_VERMELHO 			0xAA3333CC
#define COLOR_AMARELO   		0xFFFF00AA
#define COLOR_BRANCO 			0xFFFFFFAA
#define COLOR_AZULFRACO 		0x46BBAA00
#define COLOR_ROXO      		0x9955DEBB
#define COLOR_LARANJA   		0xFF9900AA
#define COLOR_AZUL      		0x0000BBAA
#define COLOR_ROXOFRACO 		0xC2A2DAAA
#define COLOR_BRANCO2 			0xFFFFFFAA
#define COLOR_AZULFORTE 		0x2641FEAA
#define COLOR_VERMELHO2			0xFF0000BB
#define COLOR_VERMELHOFRACO 	0xFF6347AA
#define COLOR_VERDEFRACO 		0x9ACD32AA
#define COLOR_AMARELO2 			0xF5DEB3AA
#define COLOR_AZULMARINHO 		0x00FFFFAA
#define COLOR_BRANCO3 			0xEFEFF7AA
#define COLOR_AZULCLARO			0x33CCFFAA
#define COLOR_VERDEFRACO2		0x00FF00FF
#define COLOR_VINHO         	0xDC143CFF
#define COLOR_AZUL2         	0x20B2AAFF
#define COLOR_CINZAESCURO 		0x5f4d75ff
#define COLOR_MARRONFRACO 		0x7835002d
#define COLOR_ROSA 				0xff0084ac
#define COLOR_AMARELOQ			0xffcb84ac
#define COLOR_VINHOFORTE 		0xcf0068ff
#define COLOR_ORANGE 			0xFF8040FF
#define COLOR_YELLOW 			0xFFFF00AA
#define COLOR_RED 				0xFF0000AA
#define COLOR_WHITE  			0xFFFFFFAA
#define COLOR_ROSACHOQUE        0xFE00B0FF
#define COLOR_LARANJA2          0xff5500AA
//colores TEXTS 3D
#define COLOR_CINZAT 			0xAFAFAFFF
#define COLOR_PRETOT 			0x000000FF
#define COLOR_VERDET 			0x33AA33FF
#define COLOR_VERMELHOT 		0xAA3333FF
#define COLOR_AMARELOT   		0xFFFF00FF
#define COLOR_BRANCOT 			0xFFFFFFFF
#define COLOR_AZULFRACOT 		0x46BBAAFF
#define COLOR_ROXOT      		0x9955DEFF
#define COLOR_LARANJAT   		0xFF9900FF
#define COLOR_AZULT      		0x0000BBFF
#define COLOR_ROXOFRACOT 		0xC2A2DAFF
#define COLOR_BRANCO2T 			0xFFFFFFFF
#define COLOR_AZULFORTET 		0x2641FEFF
#define COLOR_VERMELHO2T		0xFF0000FF
#define COLOR_VERMELHOFRACOT 	0xFF6347FF
#define COLOR_VERDEFRACOT 		0x9ACD32FF
#define COLOR_AMARELO2T			0xF5DEB3FF
#define COLOR_AZULMARINHOT 		0x00FFFFFF
#define COLOR_BRANCO3T 			0xEFEFF7FF
#define COLOR_AZULCLAROT		0x33CCFFFF
#define COLOR_VERDEFRACO2T		0x00FF00FF
#define COLOR_VINHOT         	0xDC143CFF
#define COLOR_AZUL2T         	0x20B2AAFF
#define COLOR_CINZAESCUROT 		0x5f4d75FF
#define COLOR_MARRONFRACOT 		0x783500FF
#define COLOR_ROSAT				0xff0084FF
#define COLOR_AMARELOQT			0xffcb84FF
#define COLOR_VINHOFORTET 		0xcf0068FF
#define COLOR_ORANGET 			0xFF8040FF
#define COLOR_YELLOWT 			0xFFFF00FF
#define COLOR_REDT 				0xFF0000FF
#define COLOR_WHITET  			0xFFFFFFFF
#define COLOR_ROSACHOQUET       0xFE00B0FF
#define COLOR_LARANJA2T         0xff5500FF

enum PlayerStats
{
	NOME[MAX_PLAYER_NAME],
	LEVELADMIN,
	VIP,
	BANCO,
	GRANA,
	CASH,
	LEVEL,
	PRESO,
	KILL,
	DEATH,
	GANGID,
	GANGIDONLINE,
	GANGLEVEL,
	TEMPOSOLTAR,
	TIMERESPAWN,
	GGCHATBLOCK,
	PLAYEREXP,
	PLAYERGANGEXP,
	NACAO
};
new Stats[MAX_PLAYERS][PlayerStats];
new string[256];

stock PlayerName(playerid)
{
	new MeuNome[MAX_PLAYER_NAME];
	format(MeuNome,MAX_PLAYER_NAME,"%s",Stats[playerid][NOME]);
	return MeuNome;
}

stock WeaponName(weaponid)
{
	new weaponname2[30];
	GetWeaponName(weaponid,weaponname2,30);
	return weaponname2;
}

stock PlayerIp(playerid)
{
    new playip[30];
	GetPlayerIp(playerid,playip,30);
	return playip;
}
