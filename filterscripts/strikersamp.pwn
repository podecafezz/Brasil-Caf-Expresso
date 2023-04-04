//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= System FilterScripting/Conteudo/Creditos by MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
/*
O sistema de GangZones Dominavel foi feito por Min MatriXBorn.Alguns dos Textos no FS-FilterScripting
Vem de um GameMode Criado por ViniBorn e Devastador sendo assim Achei interesante e implantei no FS.
Esse FS contem 19 Gangz e 1 Gangzone para Adicionar mais GZ so Segui todos os Metodos feito por min
Obrigado bom uso.
Acesse: www.strikersamp.blogspot.com
*/
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= The end System FilterScripting/Conteudo/Credts by MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#include <a_samp>
#include <core>
#include <float>
#include <cpstream>
#include <dudb>
#include <streamer>
#include <PSF>
#include <Dini>
#include <SInclude>
#pragma unused ret_memcpy
#pragma tabsize 0

// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
//-=-=-=-=-=-=-=-=-=-=-=-= Defines System By MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#define GREY 0xCECECEFF
#define COLOR_WHITE 0xFFFFFFAA
#define MAX_GZS           1
#define COLOR_LIGHTRED 0xFF6A6AFF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_LIGHTGREY 0xBDBDBDFF
#define MAXPLAYERS 100
//-=-=-=-=-=-=-=-=-=-=-=-= The End Defines System By MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
//-=-=-=-=-=-=-=-=-=-=-=- System de Anti DeAmx By MatriXBorn =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
AntiDeAMX()
{
    new a[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}
//-=-=-=-=-=-=-=-=-=-=-=- Fim System de Anti DeAmx By MatriXBorn =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
//-=-=-=-=-=-=-=-=-=-=-=-= Statics Constant By MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
static const GangZoneS[][128] = {
{""},
{"Traficantes - SF-Desativado | COORDENADA:"},
{"Mafia Italiana - SF | COORDENADA:"}
};
//-=-=-=-=-=-=-=-=-=-=-=-= The end Statics Constant By MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= System GangZones By MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
new cpzone[MAX_PLAYERS][MAX_GZS+1];
new lastcp[MAX_PLAYERS];
new MAFIA;//GangZone Mafia - SF
new CPmafia;//CheckPoint GangZOne Mafia - SF
new TeamGang[MAX_PLAYERS];
new gzcolor[1] = {0x0080FF96};
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= The End System GangZones By MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
//-=-=-=-=-=-=-=-=-=-=-=-= ForWards By MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
forward ZoneCheckpointChecker();//
//-=-=-=-=-=-=-=-=-=-=-=-= The End ForWards By MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if defined FILTERSCRIPT

// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnFilterScriptInit()
{
main()

{

	print("\n------------------------------------------------");
	print("   FilterScript Criado por MatriXborn não retire os Creditos              \n");
	print("   Acesse: www.strikersamp.blogspot.com     \n");
	print("   GangZOnes em San Fiero.!!!!!             \n");
	print("------------------------------------------------\n");
	return 1;
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Striker Samp - Tudo Para Seu Servidor SA-MP");
	print("----------------------------------\n");
}

#endif
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnGameModeInit()
{
	SetGameModeText("System GangZones by MatriXBorn - Striker Samp");
	SetTimer("ZoneCheckpointChecker", 1000, true);
//-=-=-=-=-=-=-=-=-=-=-=-= System GangZone in ChekcPoint - SF by MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=
    MAFIA = GangZoneCreate(-2134.868896, 1044.143554, -1942.868896, 1188.143554);
    CPmafia = CPS_AddCheckpoint(-2038.4563,1114.3975,53.2891,3,100);
    #pragma unused CPmafia
//-=-=-=-=-=-=-=-=-=-=-=-= The End System GangZone in ChekcPoint - SF by MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=
    AddPlayerClass(264, -772.1858, 1436.0601, 13.789, 93.8632, 0, 0, 0, 0, 0, 0);// Skin Nascera perto GZ - SF
    AddPlayerClass(124, -2695.1189, 912.5869, 67.5938, 358.2706, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(93, -2697.4844, 914.4119, 67.5938, 358.6218, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(285, -1636.0918, 661.462, 7.1875, 270.0119, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(287, -1324.9018, 497.4291, 11.1953, 140.6434, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(123, -2187.0582, 706.6134, 53.8905, 262.5324, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(169, -2187.0582, 706.6134, 53.8905, 262.5324, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(167, -2667.0545, 265.5968, 4.3358, 357.8497, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(163, -1834.9421, 1044.6853, 46.0859, 5.2774, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(141, -1834.9421, 1044.6853, 46.0859, 5.2774, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(29, -2127.8877, 236.869, 37.1403, 316.1893, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(28,-2127.9453,239.2886,37.4643,285.4494,0,0,0,0,0,0);
	AddPlayerClass(195, -2127.8877, 236.869, 37.1403, 316.1893, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(68, -2644.1951, -276.936, 7.5085, 135.0036, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(91, -2644.1951, -276.936, 7.5085, 135.0036, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(162, -688.0447, 936.8012, 13.6328, 174.9611, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(11,-2908.6211,-34.4791,3.5334,270.7226,0,0,0,0,0,0);
	AddPlayerClass(171,-2908.6211,-34.4791,3.5334,270.7226,0,0,0,0,0,0);
	AddPlayerClass(108,-2023.0201,-397.9724,35.5313,352.1899,0,0,0,0,0,0);
	AddPlayerClass(110,-2023.0201,-397.9724,35.5313,352.1899,0,0,0,0,0,0);
	AddPlayerClass(104,-2145.8943,-243.7063,36.5156,47.3138,0,0,0,0,0,0);
	AddPlayerClass(102,-2145.5537,-243.4607,36.5156,43.5537,0,0,0,0,0,0);
	AddPlayerClass(0,-2618.7932,1409.4526,7.0938,189.8584,0,0,0,0,0,0);
	AddPlayerClass(106,-2618.7932,1409.4526,7.0938,189.8584,0,0,0,0,0,0);
	AddPlayerClass(107,-2618.7932,1409.4526,7.0938,189.8584,0,0,0,0,0,0);
    AddPlayerClass(1,-1461.5476,1489.9932,8.2578,150.3780,0,0,0,0,0,0);
	AddPlayerClass(78,-1732.0082,29.7053,3.5547,92.4108,0,0,0,0,0,0);
	AddPlayerClass(79,-1732.0082,29.7053,3.5547,92.4108,0,0,0,0,0,0);
    AddPlayerClass(113,-2043.5026,1105.5787,53.2891,79.6094,0,0,0,0,0,0);
    AddPlayerClass(112,-2043.5026,1105.5787,53.2891,79.6094,0,0,0,0,0,0);
    AddPlayerClass(111,-2043.5026,1105.5787,53.2891,79.6094,0,0,0,0,0,0);
    AddPlayerClass(30,-2947.3794,487.8499,2.4273,180.7329,0,0,0,0,0,0); //
    AddPlayerClass(73,-2947.3794,487.8499,2.4273,180.7329,0,0,0,0,0,0); //
    AddPlayerClass(101,-2947.3794,487.8499,2.4273,180.7329,0,0,0,0,0,0); //
    AddPlayerClass(59,-1545.5238,-440.5222,6.0000,44.9114,0,0,0,0,0,0); //
    AddPlayerClass(60,-1545.5238,-440.5222,6.0000,44.9114,0,0,0,0,0,0); //
    AddPlayerClass(98,-1545.5238,-440.5222,6.0000,44.9114,0,0,0,0,0,0); //
    return 1;
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnGameModeExit()
{
	return 1;
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnPlayerRequestClass(playerid, classid)
{
	if(!classid)
	{
		GameTextForPlayer(playerid, "~p~GANG DO BOZO JAMES~n~~r~", 2000, 3);
		SetPlayerColor(playerid, 0x80FF0096);
		TeamGang[playerid] = 1;
		SetPlayerTeam(playerid, 0);
	}
	else if(classid == 1)
	{
		GameTextForPlayer(playerid, "            ~p~GANG DOS BOYZINHOS         ~r~", 2000, 3);
		SetPlayerColor(playerid, 0x80000096);
		TeamGang[playerid] = 2;
		SetPlayerTeam(playerid, 1);
	}
	else if(classid == 2)
	{
		GameTextForPlayer(playerid, "            ~p~GANG DOS BOYZINHOS         ~r~", 2000, 3);
		SetPlayerColor(playerid, 0x80000096);
		TeamGang[playerid] = 2;
		SetPlayerTeam(playerid, 1);
	}
	else if(classid == 3)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS GATE~n~~r~", 2000, 3);
		SetPlayerColor(playerid, 0xFF800096);
		TeamGang[playerid] = 3;
		SetPlayerTeam(playerid, 2);
	}
	else if(classid == 4)
	{
		GameTextForPlayer(playerid, "            ~p~GANG DOS MILITARES          ~r~", 2000, 3);
		SetPlayerColor(playerid, 0x00008096);
		TeamGang[playerid] = 4;
		SetPlayerTeam(playerid, 3);
	}
	else if(classid == 5)
	{
		GameTextForPlayer(playerid, "            ~p~GANG DOS CHINESES         ~r~", 2000, 3);
		SetPlayerColor(playerid, 0xFF00FF96);
		TeamGang[playerid] = 5;
		SetPlayerTeam(playerid, 4);
	}
	else if(classid == 6)
	{
		GameTextForPlayer(playerid, "            ~p~GANG DOS CHINESES            ~r~", 2000, 3);
		SetPlayerColor(playerid, 0xFF00FF96);
		TeamGang[playerid] = 5;
		SetPlayerTeam(playerid, 4);
	}
	else if(classid == 7)
	{
		GameTextForPlayer(playerid, "            ~p~GANG DOS FRANGOS           ~r~", 2000, 3);
		SetPlayerColor(playerid, 0xFF000096);
		TeamGang[playerid] = 6;
		SetPlayerTeam(playerid, 5);
	}
	else if(classid == 8)
	{
		GameTextForPlayer(playerid, "            ~p~GANG DOS AGENTES         ~r~", 2000, 3);
		SetPlayerColor(playerid, 0x80808096);
		TeamGang[playerid] = 7;
		SetPlayerTeam(playerid, 6);
	}
	else if(classid == 9)
	{
		GameTextForPlayer(playerid, "            ~p~GANG DOS AGENTES         ~r", 2000, 3);
		SetPlayerColor(playerid, 0x80808096);
		TeamGang[playerid] = 7;
		SetPlayerTeam(playerid, 6);
	}
	else if(classid == 10)
	{
		GameTextForPlayer(playerid, "        ~p~GANG DOS NOIAS         ~r~", 2000, 3);
		SetPlayerColor(playerid, 0x0080FF96);
		TeamGang[playerid] = 8;
		SetPlayerTeam(playerid, 7);
	}
	else if(classid == 11)
	{
		GameTextForPlayer(playerid, "        ~p~GANG DOS NOIAS         ~r~", 2000, 3);
		SetPlayerColor(playerid, 0x0080FF96);
		TeamGang[playerid] = 8;
		SetPlayerTeam(playerid, 7);
	}
	else if(classid == 12)
	{
		GameTextForPlayer(playerid, "        ~p~GANG DOS NOIAS         ~r~", 2000, 3);
		SetPlayerColor(playerid, 0x0080FF96);
		TeamGang[playerid] = 8;
		SetPlayerTeam(playerid, 7);
	}
	else if(classid == 13)
	{
		GameTextForPlayer(playerid, "            ~p~GANG DOS GANGSTERS         ~r~", 2000, 3);
		SetPlayerColor(playerid, 0xFFFF0096);
		TeamGang[playerid] = 10;
		SetPlayerTeam(playerid, 9);
	}
	else if(classid == 14)
	{
		GameTextForPlayer(playerid, "            ~p~GANG DOS GANGSTERS         ~r~", 2000, 3);
		SetPlayerColor(playerid, 0xFFFF0096);
		TeamGang[playerid] = 10;
		SetPlayerTeam(playerid, 9);
	}
	else if(classid == 15)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS COVEIROS~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0x80400096);
		TeamGang[playerid] = 11;
		SetPlayerTeam(playerid, 10);
	}
	else if(classid == 16)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS MANOBRISTAS~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0x00000096);
		TeamGang[playerid] = 12;
		SetPlayerTeam(playerid, 11);
	}
	else if(classid == 17)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS MANOBRISTAS~r~~n~r", 2000, 3);
		SetPlayerColor(playerid, 0x00000096);
		TeamGang[playerid] = 12;
		SetPlayerTeam(playerid, 11);
	}
	else if(classid == 18)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS VAGOS~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0xFFFF8096);
		TeamGang[playerid] = 13;
		SetPlayerTeam(playerid, 12);
	}
	else if(classid == 19)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS VAGOS~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0xFFFF8096);
		TeamGang[playerid] = 13;
		SetPlayerTeam(playerid, 12);
	}
	else if(classid == 20)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS BALLAS~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0x80008096);
		TeamGang[playerid] = 14;
		SetPlayerTeam(playerid, 12);
	}
    else if(classid == 21)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS BALLAS~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0x80008096);
		TeamGang[playerid] = 14;
		SetPlayerTeam(playerid, 12);
	}
	else if(classid == 22)
	{
		GameTextForPlayer(playerid, "~p~GANG DO CJ~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0x00800096);
		TeamGang[playerid] = 15;
		SetPlayerTeam(playerid, 13);
	}
	else if(classid == 23)
	{
		GameTextForPlayer(playerid, "~p~GANG DO CJ~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0x00800096);
		TeamGang[playerid] = 15;
		SetPlayerTeam(playerid, 13);
	}
	else if(classid == 24)
	{
		GameTextForPlayer(playerid, "~p~GANG DO CJ~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0x00800096);
		TeamGang[playerid] = 15;
		SetPlayerTeam(playerid, 13);
	}
	else if(classid == 25)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS PIRATAS~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0x00FFFF96);
		TeamGang[playerid] = 16;
		SetPlayerTeam(playerid, 14);
	}
	else if(classid == 26)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS MeNDINGOS~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0xFFFFFF96);
		TeamGang[playerid] = 17;
		SetPlayerTeam(playerid, 15);
	}
	else if(classid == 27)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS MeNDINGOS~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0xFFFFFF96);
		TeamGang[playerid] = 17;
		SetPlayerTeam(playerid, 15);
	}
	else if(classid == 28)
	{
		GameTextForPlayer(playerid, "~p~GANG Da MAFIA ITALIANA~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0xFF808096);
		TeamGang[playerid] = 18;
		SetPlayerTeam(playerid, 16);
	}
	else if(classid == 29)
	{
		GameTextForPlayer(playerid, "~p~GANG Da MAFIA ITALIANA~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0xFF808096);
		TeamGang[playerid] = 18;
		SetPlayerTeam(playerid, 16);
	}
	else if(classid == 30)
	{
		GameTextForPlayer(playerid, "~p~GANG Da MAFIA ITALIANA~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0xFF808096);
		TeamGang[playerid] = 18;
		SetPlayerTeam(playerid, 16);
	}
	else if(classid == 31)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS TRAFICANTES~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0xDC143CAA);
		TeamGang[playerid] = 19;
		SetPlayerTeam(playerid, 17);
	}
	else if(classid == 32)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS TRAFICANTES~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0xDC143CAA);
		TeamGang[playerid] = 19;
		SetPlayerTeam(playerid, 17);
	}
	else if(classid == 33)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS TRAFICANTES~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0xDC143CAA);
		TeamGang[playerid] = 19;
		SetPlayerTeam(playerid, 17);
		}
	else if(classid == 34)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS BAD BOYS~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0x00A3C0AA);
		TeamGang[playerid] = 20;
		SetPlayerTeam(playerid, 18);
	}
	else if(classid == 35)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS BAD BOYS~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0x00A3C0AA);
		TeamGang[playerid] = 20;
		SetPlayerTeam(playerid, 18);
	}
	else if(classid == 36)
	{
		GameTextForPlayer(playerid, "~p~GANG DOS BAD BOYS~r~~n~", 2000, 3);
		SetPlayerColor(playerid, 0x00A3C0AA);
		TeamGang[playerid] = 20;
		SetPlayerTeam(playerid, 18);
	}


	if(16 != classid)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerInterior(playerid, 17);
		SetPlayerPos(playerid, 489.4576, -15.1996, 1000.6796);
		SetPlayerCameraPos(playerid, 484.9201, -11.7566, 1000.6796);
		SetPlayerCameraLookAt(playerid, 489.4576, -15.1996, 1000.6796);
		SetPlayerFacingAngle(playerid, 51.5555);
		ApplyAnimation(playerid, "Dancing", "Dan_Loop_A", 5.0, 1, 0, 0, 0, 0);
	}
	return 1;
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, 0xFFFF00AA, "FS feito por MatriXborn Complementos de GM by Devastador");
	SendClientMessage(playerid, 0xFFFF00AA, "use /gangzones para vizuaizar as GangsZones");
    SendClientMessage(playerid, 0xFFFF00AA, "Achou Bug? Comunique a yurisummy@hotmail.com!");
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= system GangZoneShowForPlayer By MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
GangZoneShowForPlayer(playerid, MAFIA, gzcolor[0]);
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= The End system GangZoneShowForPlayer By MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
return 1;
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnPlayerSpawn(playerid)
{
SetPlayerInterior(playerid, 0);
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= System  Complemente DeAMX by MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=
		AntiDeAMX();
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= The end System  Complemente DeAMX by MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=
			if(TeamGang[playerid] == 1)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 32, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 14, 1);
		GivePlayerWeapon(playerid, 16, 5);
		GivePlayerWeapon(playerid, 26, 90);
	}
	else if(TeamGang[playerid] == 2)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 31, 450);
		GivePlayerWeapon(playerid, 28, 400);
		GivePlayerWeapon(playerid, 24, 50);
		GivePlayerWeapon(playerid, 5, 1);
		GivePlayerWeapon(playerid, 16, 5);
		GivePlayerWeapon(playerid, 26, 90);
	}
	else if(TeamGang[playerid] == 3)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 31, 450);
		GivePlayerWeapon(playerid, 29, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 3, 1);
		GivePlayerWeapon(playerid, 16, 5);
		GivePlayerWeapon(playerid, 27, 90);
	}
	else if(TeamGang[playerid] == 4)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 31, 450);
		GivePlayerWeapon(playerid, 29, 400);
		GivePlayerWeapon(playerid, 24, 50);
		GivePlayerWeapon(playerid, 4, 1);
		GivePlayerWeapon(playerid, 16, 5);
		GivePlayerWeapon(playerid, 27, 90);
	}
	else if(TeamGang[playerid] == 5)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 32, 400);
		GivePlayerWeapon(playerid, 23, 50);
		GivePlayerWeapon(playerid, 8, 1);
		GivePlayerWeapon(playerid, 16, 5);
		GivePlayerWeapon(playerid, 26, 90);
	}
	else if(TeamGang[playerid] == 6)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 32, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 9, 1);
		GivePlayerWeapon(playerid, 16, 5);
		GivePlayerWeapon(playerid, 26, 90);
	}
	else if(TeamGang[playerid] == 7)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 32, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 15, 1);
		GivePlayerWeapon(playerid, 16, 5);
		GivePlayerWeapon(playerid, 27, 90);
		GivePlayerWeapon(playerid, 46, 1);
		GivePlayerWeapon(playerid, 34, 30);
	}
	else if(TeamGang[playerid] == 8)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 31, 450);
		GivePlayerWeapon(playerid, 28, 400);
		GivePlayerWeapon(playerid, 24, 50);
		GivePlayerWeapon(playerid, 7, 1);
		GivePlayerWeapon(playerid, 16, 5);
		GivePlayerWeapon(playerid, 25, 90);
	}
	else if(TeamGang[playerid] == 9)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 32, 400);
		GivePlayerWeapon(playerid, 23, 50);
		GivePlayerWeapon(playerid, 2, 1);
		GivePlayerWeapon(playerid, 16, 5);
		GivePlayerWeapon(playerid, 26, 90);
	}
	else if(TeamGang[playerid] == 10)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 28, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 6, 1);
		GivePlayerWeapon(playerid, 26, 90);
		GivePlayerWeapon(playerid, 16, 5);
	}
	else if(TeamGang[playerid] == 11)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 28, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 15, 1);
		GivePlayerWeapon(playerid, 26, 90);
		GivePlayerWeapon(playerid, 16, 5);
	}
	else if(TeamGang[playerid] == 12)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 28, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 15, 1);
		GivePlayerWeapon(playerid, 26, 90);
		GivePlayerWeapon(playerid, 16, 5);
	}
	else if(TeamGang[playerid] == 13)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 28, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 15, 1);
		GivePlayerWeapon(playerid, 26, 90);
		GivePlayerWeapon(playerid, 16, 5);
	}
	else if(TeamGang[playerid] == 14)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 28, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 15, 1);
		GivePlayerWeapon(playerid, 26, 90);
		GivePlayerWeapon(playerid, 16, 5);
	}
	else if(TeamGang[playerid] == 15)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 28, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 15, 1);
		GivePlayerWeapon(playerid, 26, 90);
		GivePlayerWeapon(playerid, 16, 5);
	}
	else if(TeamGang[playerid] == 16)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 28, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 15, 1);
		GivePlayerWeapon(playerid, 26, 90);
		GivePlayerWeapon(playerid, 16, 5);
	}
	else if(TeamGang[playerid] == 17)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 28, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 15, 1);
		GivePlayerWeapon(playerid, 26, 90);
		GivePlayerWeapon(playerid, 16, 5);
	}
	else if(TeamGang[playerid] == 18)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 28, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 15, 1);
		GivePlayerWeapon(playerid, 26, 90);
		GivePlayerWeapon(playerid, 16, 5);
	}
	else if(TeamGang[playerid] == 19)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 450);
		GivePlayerWeapon(playerid, 28, 400);
		GivePlayerWeapon(playerid, 22, 50);
		GivePlayerWeapon(playerid, 15, 1);
		GivePlayerWeapon(playerid, 26, 90);
		GivePlayerWeapon(playerid, 16, 5);
	}
	return 0;
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnVehicleSpawn(vehicleid)
{
	return 1;
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnPlayerText(playerid, text[])
{
	return 1;
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnPlayerCommandText(playerid, cmdtext[])
{
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= System names gangZones by MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	if(strcmp(cmdtext, "/gangzones", true) == 0) {
        new string[sizeof(GangZoneS)*128];
 		format(string,1024," System GangZone by MatriXborn");
		for(new i=1; i <sizeof(GangZoneS); i ++)
			format(string,sizeof(string),"%s\n - %s",string,GangZoneS[i]);
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= The end System names gangZones by MatriXBorn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
		ShowPlayerDialog(playerid, 94, DIALOG_STYLE_MSGBOX,"\t-_-_- Nome das GangZones -_-_-_-_-", string, "OK", "Sair");
		return 1;
	}
	return 0;
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
public OnPlayerLeaveCheckpoint(playerid)
{
new checkpointid = lastcp[playerid];
if(checkpointid > 0 && checkpointid <= MAX_GZS+1)
{
cpzone[playerid][checkpointid] = 0; //saiu do CP...
GangZoneStopFlashForAll(checkpointid-1);
}
 return SendClientMessage(playerid,COLOR_RED,"-OperServ- Você saiu da GangZone.!!!");
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
//==============================================================================
public ZoneCheckpointChecker()
{
new string[MAX_PLAYERS];
for(new i; i < MAX_PLAYERS; i++)
{
if(!IsPlayerConnected(i))continue;
if(CPS_GetPlayerCheckpoint(i) > 0 && CPS_GetPlayerCheckpoint(i) <= MAX_GZS+1 &&
gzcolor[CPS_GetPlayerCheckpoint(i)-1] != GetPlayerColor(i))
//Warning: se o Player for da mesma cor da GangZone não Dominara
{
if(cpzone[i][CPS_GetPlayerCheckpoint(i)] < 15)
{
cpzone[i][CPS_GetPlayerCheckpoint(i)]++;
new tmp[11];
format(tmp, sizeof tmp, "~w~%2d/15", cpzone[i][CPS_GetPlayerCheckpoint(i)]);
GameTextForPlayer(i, tmp, 1001, 4);
GangZoneFlashForAll(CPS_GetPlayerCheckpoint(i)-1, GetPlayerColor(i));
}else if(cpzone[i][CPS_GetPlayerCheckpoint(i)] == 15)
{
GivePlayerMoney(i, 200);
GameTextForPlayer(i, "~r~area dominada!", 4000, 1);
gzcolor[CPS_GetPlayerCheckpoint(i)-1] = GetPlayerColor(i);
GangZoneStopFlashForAll(CPS_GetPlayerCheckpoint(i)-1);
GangZoneHideForAll(CPS_GetPlayerCheckpoint(i)-1);
GangZoneShowForAll(CPS_GetPlayerCheckpoint(i)-1, GetPlayerColor(i));//a gz fica da cor do player
format(string, sizeof(string), "-OperGangZone- Tem uma {00FFFF}'Gang' {F6F6F6}que está dominando Tudo.! O Sistema de gangZOne do MatriXborn Funfa.!");
SendClientMessageToAll(COLOR_WHITE, string);
}
}
}
}
// Striker Samp - Tudo Para Seu Servidor SA-MP
// www.strikersamp.blogspot.com
