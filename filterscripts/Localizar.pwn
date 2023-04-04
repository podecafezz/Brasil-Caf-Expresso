#include "a_samp"
#include "cpstream"
#include "zcmd"
#include "progress"
#include "DOF2"
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
#define FILTERSCRIPT
#if defined FILTERSCRIPT
#endif
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
#if defined CREDITO
****************************************
*  Nome: DriveThru + Fome, Sede & Sono *
*  Versão: 3.7                   	   *
*  Atualizado Por: Darkness        	   *
*  Data: 12. Janeiro. 2017             *
****************************************
#endif
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
#define     VERMELHO    0xFF0000FF
#define     AZUL        0x1E90FFFF
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	/*Dialog*/
#define		DriveThru  998
#define     Bebida     997
#define     Lanche     996
#define     DVS        995
#define     D_COMANDS  994
#define     D_HOTEL    993

#define DVFOMESEDESONO "/DRIVETHRUFOMESEDESONO/%s.ini"
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*Defines*/
new CheckC_DV1, CheckC_DV2, CheckC_DV3, CheckC_DV4, CheckC_DV5, CheckC_DV6, CheckC_HT;
new DThru[1200], DThru2[1200], Text:TextoFome, Bar:PGFOME, Text:TextoSede, Bar:PGSEDE, Text:TextoSono, Bar:PGSONO,\
arquivado[100], bool:MorreuFome[MAX_PLAYERS], bool:MorreuSede[MAX_PLAYERS], Float:vida, ContagemSono[MAX_PLAYERS], bool:AlugouQuarto[MAX_PLAYERS],\
entradahotel, saidahotel;

new Float:QuartosHotel[8][3] ={
    {2244.4512,-1159.6351,1029.7969}, {2238.6926,-1159.6136,1029.7969}, {2238.4946,-1170.6606,1029.7969},
    {2225.6917,-1185.7908,1029.7969}, {2209.5791,-1191.3101,1029.7969}, {2196.1775,-1173.0626,1029.8043},
    {2190.6311,-1156.9851,1029.7969}, {2196.1338,-1157.1234,1029.7969}};

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
public OnPlayerConnect(playerid)
{
	SetTimerEx("Correcao", 1000, false, "i", playerid);
	ShowProgressBarForPlayer(playerid, PGFOME);
	ShowProgressBarForPlayer(playerid, PGSEDE);
	ShowProgressBarForPlayer(playerid, PGSONO);
	TextDrawShowForPlayer(playerid, TextoFome);
	TextDrawShowForPlayer(playerid, TextoSede);
	TextDrawShowForPlayer(playerid, TextoSono);
	SetTimerEx("FOME", 213000, true, "i", playerid);
	SetTimerEx("SEDE", 72000, true, "i", playerid);
	SetTimerEx("SONO", 380000, true, "i", playerid);
	format(arquivado, sizeof(arquivado), DVFOMESEDESONO, NomeDoJogador(playerid));
	if(DOF2_FileExists(arquivado))
	{
		SetPVarInt(playerid,"FOME", DOF2_GetInt(arquivado, "FOME"));
		SetPVarInt(playerid,"SEDE", DOF2_GetInt(arquivado, "SEDE"));
		SetPVarInt(playerid,"SONO", DOF2_GetInt(arquivado, "SONO"));
		SetProgressBarValue(PGFOME, DOF2_GetInt(arquivado, "FOME"));
		SetProgressBarValue(PGSEDE, DOF2_GetInt(arquivado, "SEDE"));
		SetProgressBarValue(PGSONO, DOF2_GetInt(arquivado, "SONO"));
		UpdateProgressBar(PGFOME, playerid);
		UpdateProgressBar(PGSEDE, playerid);
		UpdateProgressBar(PGSONO, playerid);  }else{
		DOF2_CreateFile(arquivado);
		DOF2_SetInt(arquivado, "FOME", 100);
		DOF2_SetInt(arquivado, "SEDE", 100);
		DOF2_SetInt(arquivado, "SONO", 100);
		SetPVarInt(playerid,"FOME", DOF2_GetInt(arquivado, "FOME"));
		SetPVarInt(playerid,"SEDE", DOF2_GetInt(arquivado, "SEDE"));
		SetPVarInt(playerid,"SONO", DOF2_GetInt(arquivado, "SONO"));
		SetProgressBarValue(PGFOME, DOF2_GetInt(arquivado, "FOME"));
		SetProgressBarValue(PGSEDE, DOF2_GetInt(arquivado, "SEDE"));
		SetProgressBarValue(PGSONO, DOF2_GetInt(arquivado, "SONO"));
		UpdateProgressBar(PGFOME, playerid);
		UpdateProgressBar(PGSEDE, playerid);
		UpdateProgressBar(PGSONO, playerid);
		DOF2_SaveFile();
	}
	entradahotel = CreatePickup(1239, 23, 328.5529,-1513.7094,36.0391, -1); //Los Santos
	saidahotel = CreatePickup(1239, 23, 2214.4348,-1150.5187,1025.7969, -1); //Los Santos
//---------------------------------------- Hotel -----------------------------------------------
 	SetPlayerMapIcon(playerid, 0, 328.5529, -1513.7094, 36.0391, 40, 0); // LS
    //---------------------------------------- DriveThru --------------------------------------------
    SetPlayerMapIcon(playerid, 1, 2401.9275, -1506.4696, 23.3550, 50, 0);
    SetPlayerMapIcon(playerid, 2, 800.5552, -1629.6398, 12.9030, 50, 0);
    SetPlayerMapIcon(playerid, 3, 2486.0686, 2022.3807, 10.3402, 50, 0);
    SetPlayerMapIcon(playerid, 4, 1179.7521, -902.8798, 42.8330, 50, 0);
    SetPlayerMapIcon(playerid, 5, 1857.3107, 2081.2676, 10.3387, 50, 0);
    SetPlayerMapIcon(playerid, 6, -2350.0037, -155.5846, 34.8405, 50, 0);
	return 1;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == entradahotel) SendClientMessage(playerid, -1, "| INFO | Para entrar no Hotel use {CECECE}'/entrar'");
	if(pickupid == saidahotel) SendClientMessage(playerid, -1, "| INFO | Para sair do Hotel use {CECECE}'/sair'");
	return 0;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid)
{
    SaveDVFOMESEDESONO(playerid);
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
public OnFilterScriptInit()
{
    DisableInteriorEnterExits();

	//Barrinha
	PGFOME = CreateProgressBar(553.00, 300.00, 55.50, 3.20, -16776961, 100.0);
	SetProgressBarValue(PGFOME,100);
	//Letra
	TextoFome = TextDrawCreate(562.111083, 278.257659, "Fome");
    TextDrawLetterSize(TextoFome, 0.514444, 1.769245);
    TextDrawAlignment(TextoFome, 1);
    TextDrawColor(TextoFome, -1);
    TextDrawSetShadow(TextoFome, 0);
    TextDrawSetOutline(TextoFome, 1);
    TextDrawBackgroundColor(TextoFome, 255);
    TextDrawFont(TextoFome, 0);
    TextDrawSetProportional(TextoFome, 1);

	//Barrinha
	PGSEDE = CreateProgressBar(553.00, 331.00, 55.50, 3.20, 16711935, 100.0);
	SetProgressBarValue(PGSEDE,100);
	//Letra
	TextoSede = TextDrawCreate(562.222290, 307.626708, "Sede");
	TextDrawFont(TextoSede,1);
	TextDrawLetterSize(TextoSede, 0.496666, 1.823999);
	TextDrawAlignment(TextoSede, 1);
    TextDrawColor(TextoSede, -1);
    TextDrawSetShadow(TextoSede, 0);
    TextDrawSetOutline(TextoSede, 1);
    TextDrawBackgroundColor(TextoSede, 255);
    TextDrawFont(TextoSede, 0);
    TextDrawSetProportional(TextoSede, 1);

	//Barrinha
	PGSONO = CreateProgressBar(553.00, 363.00, 55.50, 3.20, 0x0080FFFF, 100.0);
	SetProgressBarValue(PGSONO,100);
	//Letra
	TextoSono = TextDrawCreate(562.222412, 339.982208, "Sono");
	TextDrawFont(TextoSono,1);
	TextDrawLetterSize(TextoSono, 0.487777, 1.774221);
    TextDrawAlignment(TextoSono, 1);
    TextDrawColor(TextoSono, -1);
    TextDrawSetShadow(TextoSono, 0);
    TextDrawSetOutline(TextoSono, 1);
    TextDrawBackgroundColor(TextoSono, 255);
    TextDrawFont(TextoSono, 0);
    TextDrawSetProportional(TextoSono, 1);

								/*Objetos*/
	//Lampadas
	CreateObject(3666,796.2999900,-1632.8000000,12.9000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3666,804.2999900,-1633.0000000,13.1000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3666,2402.7000000,-1509.9000000,23.3000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3666,2402.7002000,-1501.9004000,23.3000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3666,1183.8000000,-898.0999800,42.8000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3666,1185.2000000,-906.4000200,42.8000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3666,-2348.2000000,-156.6000100,34.8000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3666,-2348.2000000,-148.2000000,34.8000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3666,1861.1000000,2089.6001000,10.3000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3666,1861.0000000,2080.8999000,10.3000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3666,2483.8999000,2017.9000000,10.3000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3666,2483.8000000,2026.7000000,10.3000000,0.0000000,0.0000000,0.0000000); //
	//Posters
	CreateObject(2642,2483.7000000,2018.5000000,11.0000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(2642,1861.3000000,2089.1001000,11.0000000,0.0000000,0.0000000,170.0000000); //
	CreateObject(2642,-2347.6884800,-148.8769500,36.1853800,0.0000000,0.0000000,0.0000000); //
	CreateObject(2642,-2347.7000000,-148.6000100,35.3000000,0.0000000,0.0000000,178.0000000); //
	CreateObject(2642,795.2999900,-1632.9000000,13.3000000,0.0000000,0.0000000,210.0000000); //
	CreateObject(2642,1184.2000000,-905.7999900,43.2000000,0.0000000,0.0000000,220.0000000); //
	CreateObject(2642,2401.8000000,-1502.0000000,23.8000000,0.0000000,0.0000000,220.0000000); //
	//Bases
	CreateObject(3881,799.7999900,-1635.4000000,14.3000000,0.0000000,0.0000000,270.0000000); //
	CreateObject(3881,2404.3999000,-1506.4000000,24.9000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3881,1186.4000000,-902.4000200,43.8000000,0.0000000,0.0000000,8.0000000); //
	CreateObject(3881,-2346.7000000,-152.8999900,36.2000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3881,1862.5000000,2084.7000000,11.7000000,0.0000000,0.0000000,0.0000000); //
	CreateObject(3881,2483.2000000,2022.8000000,11.9000000,0.0000000,0.0000000,180.0000000); //
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	/*TextLabel*/
	Create3DTextLabel("{FF1E1E}DriveThru", 0xFFD700FF, 2401.9275,-1506.4696,23.3550, 40.0, 0, 0);
	Create3DTextLabel("{FF1E1E}DriveThru", 0xFFD700FF, 800.5552,-1629.6398,12.9030, 40.0, 0, 0);
	Create3DTextLabel("{FF1E1E}DriveThru", 0xFFD700FF, 2486.0686,2022.3807,10.3402, 40.0, 0, 0);
	Create3DTextLabel("{FF1E1E}DriveThru", 0xFFD700FF, 1179.7521,-902.8798,42.8330, 40.0, 0, 0);
	Create3DTextLabel("{FF1E1E}DriveThru", 0xFFD700FF, 1857.3107,2081.2676,10.3387, 40.0, 0, 0);
	Create3DTextLabel("{FF1E1E}DriveThru", 0xFFD700FF, -2350.0037,-155.5846,34.8405, 40.0, 0, 0);
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	/*CheckPoint*/
	CheckC_DV1 = CPS_AddCheckpoint(2401.9275,-1506.4696,23.3550, 5.0, 20);
	CheckC_DV2 = CPS_AddCheckpoint(1179.7521,-902.8798,42.8330, 5.0, 20);
	CheckC_DV3 = CPS_AddCheckpoint(800.5552,-1629.6398,12.9030, 5.0, 20);
	CheckC_DV4 = CPS_AddCheckpoint(1857.3107,2081.2676,10.3387, 5.0, 20);
	CheckC_DV5 = CPS_AddCheckpoint(2486.0686,2022.3807,10.3402, 5.0, 20);
	CheckC_DV6 = CPS_AddCheckpoint(-2350.0037,-155.5846,34.8405, 5.0, 20);
	CheckC_HT = CPS_AddCheckpoint(2217.3391, -1146.4551, 1025.7969, 2.0, 20); //Hotel
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	print("Sistema de DriveThru + Fome, Sede & Sono LIGADO !");
	print("By : Learning");
	print("http://forum.sa-mp.com/showthread.php?t=548602");
	return 1;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
public OnFilterScriptExit()
{
	DOF2_Exit();
	return 0;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	/*Comando*/
CMD:entrar(playerid)
{
	SetPlayerInterior(playerid, 15);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid,2218.5337,-1150.3634,1025.7969);
	return 1;
}

CMD:sair(playerid)
{
	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,335.1270, -1519.3262, 35.8672);
	SetPlayerVirtualWorld(playerid, 0);
	GameTextForPlayer(playerid, "~w~Los Santos", 5000, 1);
	return 1;
}

CMD:ls(playerid)
{
	SetPlayerPos(playerid,335.1270, -1519.3262, 35.8672);
	return 1;
}

CMD:alugarquarto(playerid)
{
    new check = CPS_GetPlayerCheckpoint(playerid);
    if(check != CheckC_HT) return SendClientMessage(playerid, VERMELHO, "[!] Você não está em um Hotel!");
	ShowPlayerDialog(playerid, D_HOTEL, DIALOG_STYLE_MSGBOX,"Hotel","Aqui você podera alugar um quarto\nno valor de 100R$.\nDeseja alugar?","Alugar","Cancelar");
    return 1;
}

CMD:drivethru(playerid)
{
	if(!IsPlayerInAnyVehicle( playerid )) return SendClientMessage( playerid, VERMELHO, "| ERRO | Comando inválido!" );
	if( !IsPlayerInRangeOfPoint(playerid, 5.0, 2401.9275,-1506.4696,23.3550) && !IsPlayerInRangeOfPoint(playerid, 5.0, 1179.7521,-902.8798,42.8330)
	&& !IsPlayerInRangeOfPoint(playerid, 5.0, 800.5552,-1629.6398,12.9030) && !IsPlayerInRangeOfPoint(playerid, 5.0, 1857.3107,2081.2676,10.3387)
	&& !IsPlayerInRangeOfPoint(playerid, 5.0, 2486.0686,2022.3807,10.3402) && !IsPlayerInRangeOfPoint(playerid, 5.0, -2350.0037,-155.5846,34.8405))
	return SendClientMessage(playerid,-1,"[!] {FF0000}Você não está em um Drive Thru !");
	ShowPlayerDialog(playerid,DriveThru,DIALOG_STYLE_LIST,"Cardápio Drive Thru","{FF0000}- {5F9EA0}Bebida\n{FF0000}- {5F9EA0}Lanche\n","Comprar","Cancelar");
	return 1;
}

CMD:dvs(playerid)
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xFF0000FF,"| ERRO | Comando inválido!");
	ShowPlayerDialog(playerid, DVS, DIALOG_STYLE_LIST, "Drive Thru","LS - Drive Thru\nLS[2] - Drive Thru\nLS[3] - Drive Thru\nSF - Drive Thru\
	\nLV - Drive Thru\nLV[2] - Drive Thru\n", "Selecionar", "Cancelar");
	return 1;
}

CMD:setfome(playerid)
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1,"| ERRO | Comando inválido!");
	SetProgressBarValue(PGFOME, 5);
	UpdateProgressBar(PGFOME, playerid);
	SetPVarInt(playerid,"FOME", 5);
	SendClientMessage(playerid, -1, "| Fome | {9BCD9B}Sua barra de fome foi setada para 5");
	return 1;
}

CMD:rfome(playerid)
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1,"| ERRO | Comando inválido!");
	SetProgressBarValue(PGFOME, 100);
	UpdateProgressBar(PGFOME, playerid);
	SetPVarInt(playerid,"FOME", 100);
	SendClientMessage(playerid, -1, "| Sono | {9BCD9B}Sua barra de fome foi recuperada");
	return 1;
}

CMD:setsede(playerid)
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1,"| ERRO | Comando inválido!");
	SetProgressBarValue(PGSEDE, 5);
	UpdateProgressBar(PGSEDE, playerid);
	SetPVarInt(playerid,"SEDE", 5);
	SendClientMessage(playerid, -1, "| Sede | {9BCD9B}Sua barra de sede foi setada para 5");
	return 1;
}

CMD:rsede(playerid)
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1,"| ERRO | Comando inválido!");
	SetProgressBarValue(PGSEDE, 100);
	UpdateProgressBar(PGSEDE, playerid);
	SetPVarInt(playerid,"SEDE", 100);
	SendClientMessage(playerid, -1, "| Sede | {9BCD9B}Sua barra de sede foi recuperada");
	return 1;
}

CMD:setsono(playerid)
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1,"| ERRO | Comando inválido!");
	SetProgressBarValue(PGSONO, 5);
	UpdateProgressBar(PGSONO, playerid);
	SetPVarInt(playerid,"SONO", 5);
	SendClientMessage(playerid, -1, "| Sono | Sua barra de sono foi setada para 5");
	return 1;
}

CMD:rsono(playerid)
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1,"| ERRO | Comando inválido!");
	SetProgressBarValue(PGSONO, 100);
	UpdateProgressBar(PGSONO, playerid);
	SetPVarInt(playerid,"SONO", 100);
	SendClientMessage(playerid, -1, "| Sono | Sua barra de sono foi recuperada");
	return 1;
}

CMD:pmoney(playerid)
{
	GivePlayerMoney(playerid, 150);
	SendClientMessage(playerid, -1,"[!] Você pegou R$150,00");
	return 1;
}

CMD:comandosfs(playerid)
{
	SendClientMessage(playerid, -1, "CMD : {DAA520}/SetFome  {FFFAFA}- Função : {9BCD9B}Setar barra de fome para 5 por cento");
	SendClientMessage(playerid, -1, "CMD : {DAA520}/RFome  {FFFAFA}- Função : {9BCD9B}Recuperar a barra de fome para 100 por cento");
	SendClientMessage(playerid, -1, "CMD : {DAA520}/dvs  {FFFAFA}- Função : {9BCD9B}Abrir dialog com teleportes para DriveThrus");
	SendClientMessage(playerid, -1, "CMD : {DAA520}/PMoney  {FFFAFA}- Função : {9BCD9B}Pegar 50$ para comprar/testar 'Comes & Bebis'");
	SendClientMessage(playerid, -1, "CMD : {DAA520}/SetSede  {FFFAFA}- Função : {9BCD9B}Setar barra de sede para 5 por cento");
	SendClientMessage(playerid, -1, "CMD : {DAA520}/RSede  {FFFAFA}- Função : {9BCD9B}Recuperar a barra de sede para 100 por cento");
	SendClientMessage(playerid, -1, "CMD : {DAA520}/SetSono  {FFFAFA}- Função : {9BCD9B}Setar barra de sono para 5 por cento");
	SendClientMessage(playerid, -1, "CMD : {DAA520}/RSono  {FFFAFA}- Função : {9BCD9B}Recuperar a barra de sono para 100 por cento");
	return 1;
}

CMD:dormir(playerid)
{
	if(GetPVarInt(playerid,"SONO") >= 75) return SendClientMessage(playerid, VERMELHO,"| SONO | Você não esta com sono!");
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 403 || 406 || 408 || 413 || 414 || 431 || 433 || 437 || 440 || 443 || 455 || 456 || 459 || 482 || 498 || 499 || 514 || 524 || 573 || 578 || 609 )
	{
		TogglePlayerControllable(playerid, true);
		SetPlayerDrunkLevel(playerid, 0);
		KillTimer(ContagemSono[playerid]);
		TogglePlayerControllable(playerid, false);
		SendClientMessage(playerid, -1, "| SONO | Vocé deitou na cama do hotel para dormir ZzzZZzz...!");
		SetTimerEx("AcordarVeiculo", 60000, false, "i", playerid);
		return 1;
	}
	/*if(  COLOQUE A FUNÇÃO DA SUA CASA PARA UTILIZAR ESTÁ PARTE  ){
		if(!(IsPlayerInRangeOfPoint(playerid, 3.0, 232.0407,1287.1119,1082.8839) || IsPlayerInRangeOfPoint(playerid, 3.0, 266.4384,1287.9473,1080.9987) || IsPlayerInRangeOfPoint(playerid, 3.0, 140.3395,1386.1359,1084.5214)
		|| IsPlayerInRangeOfPoint(playerid, 3.0, 135.6128,1385.3220,1089.0525) || IsPlayerInRangeOfPoint(playerid, 3.0, 152.3840,1376.2253,1089.0525) || IsPlayerInRangeOfPoint(playerid, 3.0, 147.9311,1385.3346,1089.0525)
		|| IsPlayerInRangeOfPoint(playerid, 3.0, 77.9491,1337.6481,1089.0231) || IsPlayerInRangeOfPoint(playerid, 3.0, 92.2879,1340.6649,1089.0265) || IsPlayerInRangeOfPoint(playerid, 3.0, 2342.0837,-1067.7916,1049.7074)
		|| IsPlayerInRangeOfPoint(playerid, 3.0, 2188.1179,-1210.1270,1049.7090) || IsPlayerInRangeOfPoint(playerid, 3.0, 2359.2795,-1132.7079,1051.4023) || IsPlayerInRangeOfPoint(playerid, 3.0, 2362.6367,-1122.4609,1051.5746)
		|| IsPlayerInRangeOfPoint(playerid, 3.0, 2198.5737,-1214.2178,1049.5664) || IsPlayerInRangeOfPoint(playerid, 3.0, 2187.7866,-1219.2948,1049.7371) || IsPlayerInRangeOfPoint(playerid, 3.0, 2258.2498,-1223.5747,1049.7917)
		|| IsPlayerInRangeOfPoint(playerid, 3.0, 2209.8884,-1071.9370,1051.3308) || IsPlayerInRangeOfPoint(playerid, 3.0, 2206.5239,-1071.9524,1051.3308) || IsPlayerInRangeOfPoint(playerid, 3.0, 2244.0154,-1080.1523,1049.5619)
		|| IsPlayerInRangeOfPoint(playerid, 3.0, 237.4120,1029.6683,1088.8088) || IsPlayerInRangeOfPoint(playerid, 3.0, 241.1674,1034.8560,1088.7943) || IsPlayerInRangeOfPoint(playerid, 3.0, 238.1896,1050.1255,1084.4961)
		|| IsPlayerInRangeOfPoint(playerid, 3.0, 228.5271,1050.1365,1084.4961) || IsPlayerInRangeOfPoint(playerid, 3.0, -275.3728,1448.5557,1089.4170) || IsPlayerInRangeOfPoint(playerid, 3.0, 225.8938,1251.3134,1082.8237)
		|| IsPlayerInRangeOfPoint(playerid, 3.0, 2241.5056,-1080.2970,1049.5619) || IsPlayerInRangeOfPoint(playerid, 3.0, 2326.3772,-1008.4699,1055.2461) || IsPlayerInRangeOfPoint(playerid, 3.0, 2285.1965,-1135.2899,1051.5265))){
			SendClientMessage(playerid, VERMELHO,"[!] Você não está em uma cama!");
			return 1;}
	}*/
	else{
		if(AlugouQuarto[playerid] == false) return SendClientMessage(playerid, VERMELHO, "[!] Você não tem casa e não alugou um quarto!");
		if(!(IsPlayerInRangeOfPoint(playerid, 3.0, 2246.6145,-1164.8956,1030.4943) || IsPlayerInRangeOfPoint(playerid, 3.0, 2235.8782,-1154.6770,1030.4943) || IsPlayerInRangeOfPoint(playerid, 3.0, 2235.8779,-1165.6445,1030.4943)
		|| IsPlayerInRangeOfPoint(playerid, 3.0, 2230.8008,-1183.2682,1030.5249) || IsPlayerInRangeOfPoint(playerid, 3.0, 2204.7166,-1193.9952,1030.5249) || IsPlayerInRangeOfPoint(playerid, 3.0, 2198.3706,-1178.1284,1030.4943)
		|| IsPlayerInRangeOfPoint(playerid, 3.0, 2187.9197,-1152.1074,1030.4943) || IsPlayerInRangeOfPoint(playerid, 3.0, 2198.4790,-1162.3024,1030.4943)))
		{
			SendClientMessage(playerid, VERMELHO,"Você não está em uma cama!");
			return 1;
		}
	}
	TogglePlayerControllable(playerid, true);
	SetPlayerDrunkLevel(playerid, 0);
	ApplyAnimation(playerid,"CRACK","crckdeth4",4.0,0,0,0,1,0);
	KillTimer(ContagemSono[playerid]);
	TogglePlayerControllable(playerid, false);
	SendClientMessage(playerid, -1, "zZzZzZzZ..");
	SetTimerEx("Acordar", 60000, false, "i", playerid);
	return 1;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DriveThru)
	{
		if(response)
		{
			switch(listitem)
			{
	          	case 0:
	  			{//Bebida
	                strcat(DThru, "Agua Natural - {3DB134}$3,00\nAgua c. Gás - {3DB134}$3,00\nCoca-Cola - {3DB134}$7,00\nGuarana - {3DB134}$5,00\nFanta Uva - {3DB134}$4,00\n");
	                strcat(DThru, "Fanta Laranja - {3DB134}$4,00\nItubaina - {3DB134}$4,00\nSprite - {3DB134}$3,00\nKuat - {3DB134}$3,00\nSuco de Maçã - {3DB134}$2,00\n");
	                strcat(DThru, "Suco de Laranja - {3DB134}$2,00\nSuco de Limão - {3DB134}$2,00\nSuco de Maracuja - {3DB134}$2,00\nSuco de Morango - {3DB134}$2,00\n");
	                strcat(DThru, "Suco de Abacaxi - {3DB134}$2,00\nCafé - {3DB134}$3,00\nCafé c.Leite - {3DB134}$3,00");
	                ShowPlayerDialog(playerid, Bebida, DIALOG_STYLE_LIST, "Bebidas", DThru, "Selecionar", "Sair");
	                return 1;
				}
				case 1:
				{//Lanche
	                strcat(DThru2, "Arroz & Feijão - {3DB134}$25,00\nFeijoada - {3DB134}$18,00\nLasanha d.Frango - {3DB134}$35,00\nLasanha d.Carne - {3DB134}$35,00\n");
	                strcat(DThru2, "Porção d.Frango F - {3DB134}$20,00\nPorção d.Batata F - {3DB134}$22,00\nPorção d.Mandioca - {3DB134}$18,00\nPastel - {3DB134}$5,00\n");
	                strcat(DThru2, "Esfirra d.Carne - {3DB134}$4,00\nEsfirra d.Frango - {3DB134}$4,00\nPizza d. Queijo - {3DB134}$24,00\nPizza d.Calabresa - {3DB134}$25,00\n");
	                strcat(DThru2, "Pizza d.Bacon - {3DB134}$30,00\nPizza d.Bauru - {3DB134}$23,00");
	                ShowPlayerDialog(playerid, Lanche, DIALOG_STYLE_LIST, "Comidas", DThru2, "Selecionar", "Sair");
	                return 1;
				}
			}
		}
	}
	/*Dialog das Bebidas*/
	if( dialogid == Bebida )
	{
		if(response)
		{
			switch(listitem)
			{
				case 0://Agua Natural
				{
					if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$3 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -3);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Agua Natural");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 1://Coca Cola
				{
					if(GetPlayerMoney(playerid) < 7) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$7 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -7);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Coca-Cola");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 2://Guarana
				{
					if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$5 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -5);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Guarana");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 3://Fanta Uva
				{
					if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$4 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -4);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Fanta Uva");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 4://Fanta Laranja
				{
					if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$4 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -4);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Fanta Laranja");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 5://Itubaina
				{
					if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$4 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -4);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Itubaina");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 6://Sprit
				{
					if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$3 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -3);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Sprit");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 7://Kuat
				{
					if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$3 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -3);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Kuat");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 8://Suco d.Maçã
				{
					if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$2 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -2);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Suco de Maçã");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 9://Suco d.Laranja
				{
					if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$2 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -2);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Suco de Laranja");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 10://Suco d.Limão
				{
					if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$2 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -2);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Suco de Limão");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 11://Suco d.Maracuja
				{
					if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$2 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -2);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Suco de Maracuja");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 12://Suco d.Morango
				{
					if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$2 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -2);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Suco de Morango");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 13://Suco d.Abacaxi
				{
					if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$2 para comprar!");
					if(GetPVarInt(playerid,"SEDE") >= 100) return SendClientMessage(playerid, VERMELHO,"| SEDE | Você está não precisa mais de bebida!");
					GivePlayerMoney(playerid, -2);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+55.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Suco de Abacaxi");
					SetPVarInt(playerid,"SEDE",GetPVarInt(playerid,"SEDE")+100);
					SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
					UpdateProgressBar(PGSEDE,playerid);
				}
				case 14:
    			{
					ShowPlayerDialog(playerid, DriveThru, DIALOG_STYLE_LIST, "Cardápio Drive Thru","{FF0000}- {5F9EA0}Bebida\n{FF0000}- {5F9EA0}Lanche", "Comprar", "Cancelar");
					return 1;
				}
			}
		}
	}
	/*Dialog das Comidas*/
	if( dialogid == Lanche )
	{
		if(response)
		{
			switch(listitem)
			{
				case 0://Arroz & Feijão
				{
					if(GetPlayerMoney(playerid) < 25) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$25 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -25);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer um {FFFFFF}Arroz & Feijão");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 1://Feijoada
				{
					if(GetPlayerMoney(playerid) < 18) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$18 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -18);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Feijoada");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 2://Lasanha d.Frango
				{
					if(GetPlayerMoney(playerid) < 35) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$35 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -35);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Lasanha de Frango");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 3://Lazanha d.Carne
				{
					if(GetPlayerMoney(playerid) < 35) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$35 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -35);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Lasanha de Carne");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 4://Porção d.Frango F
				{
					if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$20 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -20);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Porção de Frango Frito");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 5://Porção d.Batata F
				{
					if(GetPlayerMoney(playerid) < 22) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$22 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -22);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Porção de Batata Frita");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 6://Porção d.Mandioca F
				{
					if(GetPlayerMoney(playerid) < 18) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$18 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -18);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Porção de Mandioca Frita");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 7://Pastel
				{
					if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$5 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -5);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer um {FFFFFF}Pastel");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 8://Esfirra de Carne
				{
					if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$4 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -4);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Esfirra de Carne");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 9://Esfirra de Carne
				{
					if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$4 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -4);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Esfirra de Frango");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 10://Pizza de Queijo
				{
					if(GetPlayerMoney(playerid) < 24) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$24 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -24);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Pizza de Queijo");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 11://Pizza de Calabresa
				{
					if(GetPlayerMoney(playerid) < 25) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$25 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -25);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Pizza de Calabresa");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 12://Pizza de Bacon
				{
					if(GetPlayerMoney(playerid) < 25) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$25 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -25);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Pizza de Bacon");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 13://Pizza de Bauru
				{
					if(GetPlayerMoney(playerid) < 30) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$30 para comprar!");
					if(GetPVarInt(playerid,"FOME") >= 100) return SendClientMessage(playerid, VERMELHO,"| FOME | Você está satisfeito, não precisa mais de comida!");
					GivePlayerMoney(playerid, -30);
					GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida+75.0);
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Pizza de Bauru");
					SetPVarInt(playerid,"FOME",GetPVarInt(playerid,"FOME")+100);
					SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
					UpdateProgressBar(PGFOME,playerid);
				}
				case 14:
				{
					ShowPlayerDialog(playerid, DriveThru, DIALOG_STYLE_LIST, "Cardápio Drive Thru","{FF0000}- {5F9EA0}Bebida\n{FF0000}- {5F9EA0}Lanche", "Comprar", "Cancelar");
					return 1;
				}
			}
		}
	}
	/*Dialog dos teleportes*/
	if( dialogid == DVS )
	{
		if(response)
		{
			switch(listitem)
			{
				case 0://LS
				{
				    SetPlayerPos( playerid, 2401.9275,-1506.4696,23.3550 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você foi para o Drive Thru de {FFFFFF}LS");
					return 1;
				}
				case 1://LS[2]
				{
				    SetPlayerPos( playerid, 800.5552,-1629.6398,12.9030 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você foi para o Drive Thru de{FFFFFF}LS[2]");
					return 1;
				}
				case 2://LS[3]
				{
				    SetPlayerPos( playerid, 1179.7521,-902.8798,42.8330 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você foi para o Drive Thru de{FFFFFF}LS[3]");
					return 1;
				}
				case 3://SF
				{
				    SetPlayerPos( playerid, -2350.0037,-155.5846,34.8405 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você foi para o Drive Thru de{FFFFFF}SF");
					return 1;
				}
				case 4://LV
				{
				    SetPlayerPos( playerid, 1857.3107,2081.2676,10.3387 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você foi para o Drive Thru de{FFFFFF}LV");
					return 1;
				}
				case 5://LV[2]
				{
				    SetPlayerPos( playerid, 2486.0686,2022.3807,10.3402 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você foi para o Drive Thru de{FFFFFF}LV[2]");
					return 1;
				}
			}
		}
	}
	/*Dialog do Hotel*/
	if(dialogid == D_HOTEL)
	{
		if(response)
		{
			if(AlugouQuarto[playerid] == true) return SendClientMessage(playerid, -VERMELHO,"[!] Você já alugou um quarto recentemente.");
            if(GetPlayerMoney(playerid) < 150) return SendClientMessage(playerid, VERMELHO,"[!] Você não tem R$150 para alugar!");
            if(GetPVarInt(playerid,"SONO") >= 75) return SendClientMessage(playerid,VERMELHO,"[!]Você não esta com sono!");
            SendClientMessage(playerid, -1, "| NOTEL | Vocé acabou de alugar o quarto ( Digite: /Dormir )");
            new QHotel = random(sizeof(QuartosHotel));
            SetPlayerPos(playerid, QuartosHotel[QHotel][0], QuartosHotel[QHotel][1],QuartosHotel[QHotel][2]);
            GivePlayerMoney(playerid, -150);
			AlugouQuarto[playerid] = true;
		}
	}
	return 0;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
public OnPlayerEnterCheckpoint(playerid)
{
	new checknome = CPS_GetPlayerCheckpoint(playerid);
	if(checknome == CheckC_HT)
	{
	    SendClientMessage(playerid, 0x008282AA, "================ Hotel =================");
		SendClientMessage(playerid, 0xFFFFFFFF, " Bem vindo(a) ao Hotel");
		SendClientMessage(playerid, 0xFFFFFFFF, " /AlugarQuarto - Para alugar um quarto no valor de $150");
		SendClientMessage(playerid, 0x008282AA, "================ Hotel =================");
	}
	if(checknome == CheckC_DV1 || checknome == CheckC_DV2 || checknome == CheckC_DV3 || checknome == CheckC_DV4 || checknome == CheckC_DV5 || checknome == CheckC_DV6)
    {
        if(!IsPlayerInAnyVehicle(playerid)) return 1;
	    SendClientMessage(playerid, 0xFF0000FF, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		SendClientMessage(playerid, 0xFFFFFFFF, " Olá {FFFFFF}Trabalhador, {1E90FF}você está no {FFFFFF}DriveThru {1E90FF}!");
		SendClientMessage(playerid, 0xFFFFFFFF, " Para vê nossas Ofertas --> {FFFFFF}/DriveThru");
		SendClientMessage(playerid, 0xFF0000FF, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	}
	return 1;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
forward SEDE(playerid);
public SEDE(playerid)
{
	SetPVarInt(playerid,"SEDE", GetPVarInt(playerid,"SEDE")-1);
	SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
	UpdateProgressBar(PGSEDE,playerid);

	if(GetPVarInt(playerid,"SEDE") <= 5)
	{
        GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida - 20.0);
		SendClientMessage(playerid, 0xFF0000FF,"| Sede | Vá até a lanchonete comer ou irá morrer de sede!");
	}
	if(GetPVarInt(playerid,"SEDE") <= 0)
	{
		SetPlayerHealth(playerid, 0);
		SendClientMessage(playerid, 0xFF0000FF, "| Sede | Você morreu de sede!");
		MorreuSede[playerid] = true;
	}
	return 1;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
forward FOME(playerid);
public FOME(playerid)
{
	SetPVarInt(playerid,"FOME", GetPVarInt(playerid,"FOME")-1);
	SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
	UpdateProgressBar(PGFOME,playerid);

	if(GetPVarInt(playerid,"FOME") <= 5)
	{
        GetPlayerHealth(playerid,vida),SetPlayerHealth(playerid,vida - 20.0);
		SendClientMessage(playerid, 0xFF0000FF,"| Fome | Vá até a lanchonete comer ou irá morrer de fome!");
	}
	if(GetPVarInt(playerid,"FOME") <= 0)
	{
		SetPlayerHealth(playerid, 0);
		SendClientMessage(playerid, 0xFF0000FF, "| Fome | Você morreu de fome!");
		MorreuFome[playerid] = true;
	}
	return 1;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
forward SONO(playerid);
public SONO(playerid)
{
	SetPVarInt(playerid,"SONO",GetPVarInt(playerid,"SONO")-1);
	SetProgressBarValue(PGSONO, GetPVarInt(playerid,"SONO"));
	UpdateProgressBar(PGSONO,playerid);

	if(GetPVarInt(playerid,"SONO") <= 10 && GetPVarInt(playerid,"SONO") > 5)
	{
		SendClientMessage(playerid,-1,"| SONO | Você esta passando mal por excesso de sono, se não durmir podera desmaiar.");
		SetPlayerDrunkLevel(playerid, 4000);
	}
	if(GetPVarInt(playerid,"SONO") <= 0)
	{
		SetPlayerDrunkLevel(playerid, 0);
		ApplyAnimation(playerid,"CRACK","crckdeth4",4.0,0,0,0,1,0);
		KillTimer(ContagemSono[playerid]);
    	SendClientMessage(playerid,0xDCDCDCFF,"| SONO | Você tirou uma soneca por excesso de sono...");
		SetTimerEx("AcordarDes", 10000, false, "i", playerid);
		TogglePlayerControllable(playerid, false);
	}
	return 1;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
forward AcordarVeiculo(playerid);
public AcordarVeiculo(playerid)
{
	TogglePlayerControllable(playerid, true);
	SendClientMessage(playerid, 0xDCDCDCFF, "| SONO | Você acordou!");
	ContagemSono[playerid] = SetTimerEx("SONO", 1800000, true, "i", playerid);
	SetProgressBarValue(PGSONO, 100);
	UpdateProgressBar(PGSONO, playerid);
	SetPVarInt(playerid,"SONO", 100);
	return 1;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
forward Acordar(playerid);
public Acordar(playerid)
{
	TogglePlayerControllable(playerid, true);
	ClearAnimations(playerid);
	ContagemSono[playerid] = SetTimerEx("SONO", 35000, true, "i", playerid);
	SetProgressBarValue(PGSONO, 100);
	UpdateProgressBar(PGSONO, playerid);
	SetPVarInt(playerid,"SONO", 100);
	return 1;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
forward AcordarDes(playerid);
public AcordarDes(playerid)
{
	TogglePlayerControllable(playerid, true);
	ClearAnimations(playerid);
	ContagemSono[playerid] = SetTimerEx("SONO", 35000, true, "i", playerid);
	SetProgressBarValue(PGSONO, 100);
	UpdateProgressBar(PGSONO, playerid);
	SetPVarInt(playerid,"SONO", 100);
	SendClientMessage(playerid, AZUL,"[!] Você acordou do seu excesso de sono");
	return 1;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
forward SaveDVFOMESEDESONO(playerid);
public SaveDVFOMESEDESONO(playerid)
{
	format(arquivado, sizeof(arquivado), DVFOMESEDESONO, NomeDoJogador(playerid));
	if(DOF2_FileExists(arquivado))
	{
		DOF2_SetInt(arquivado,"FOME", GetPVarInt(playerid,"FOME"));
		DOF2_SetInt(arquivado,"SEDE", GetPVarInt(playerid,"SEDE"));
		DOF2_SaveFile();
	}
	return 1;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
forward Correcao(playerid);
public Correcao(playerid)
{
	if(GetPVarInt(playerid,"SEDE") > 100)
	{
		SetPVarInt(playerid,"SEDE", 100);
		SetProgressBarValue(PGSEDE, GetPVarInt(playerid,"SEDE"));
		UpdateProgressBar(PGSEDE,playerid);
	}
	if(GetPVarInt(playerid,"FOME") > 100)
	{
		SetPVarInt(playerid,"FOME", 100);
		SetProgressBarValue(PGFOME, GetPVarInt(playerid,"FOME"));
		UpdateProgressBar(PGFOME, playerid);
	}
	return 0;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
stock NomeDoJogador(playerid)
{
	new nome[MAX_PLAYER_NAME];
	GetPlayerName(playerid,nome,sizeof(nome));
	return nome;
}
