/*


                        Por RICOP522




*/

#include <a_samp>
#include <a_mysql>
#include <foreach>
#include <zcmd>
#include <streamer>
#include <ricop>

native sscanf(const data[], const format[], {Float,_}:...);
native unformat(const data[], const format[], {Float,_}:...) = sscanf;

#undef MAX_PLAYERS
#define MAX_PLAYERS (50)

#define SERVER_NOME                             " Meu servidor "
#define SERVER_MAPA                             "LS/SF"

#define COLOR_PINK 0xFFC0CBFF
#define COLOR_RED 0xFF0000FF
#define COLOR_GREEN 0x008000FF
#define COLOR_DARKBLUE 0x00008BFF
#define COLOR_CADETBLUE 0x5F9EA0FF
#define COLOR_LIGHTBLUE 0xADD8E6FF
#define COLOR_YELLOW 0xECD400F6
#define COLOR_LIGHTGREEN 0x90EE90FF
#define COLOR_PEACHPUFF 0xFFDAB9FF
#define LIGHTBLUE2 0xF6BB0AA
#define COLOR_GREY 0x808080FF
#define COLOR_ORANGE 0xFFA500FF
#define COLOR_BISQUE 0xFFE4C4FF
#define COLOR_BLANCHEDALMOND 0xFFEBCDFF

#define CYELLOW "{9DBD1E}"
#define CORANGE "{E68C0E}"
#define CBLUE   "{39AACC}"
#define CLGREEN "{30DB52}"
#define CDGREEN "{6FA828}"
#define CWHITE  "{FFFFFF}"
#define CREDISH "{CF0C43}"
#define CRED    "{FF0000}"
#define CLBLUE  "{55C2CF}"
#define CCADET  "{5F9EA0}"
#define CPINK   "{FC08CB}"
#define CDBLUE  "{1500FF}"
#define CAQUA   "{5CFFE9}"
#define CGREY   "{7D8584}"
#define CMAROON "{912514}"
#define CCORAL  "{FF7F50}"
#define CRACE   "{F2DDC4}"
#define CRACE2  "{2CC900}"
#define CGAME1  "{E8DB20}"
#define CGAME2  "{BA80BA}"
#define CMINIG1 "{648832}"
#define CMINIG2 "{4F927F}"

//                                      Dados do MYSQL
#define SQL_HOST 																"localhost"
#define SQL_USER 																"root"
#define SQL_PASS 																""
#define SQL_DB 																	"minhadb"
#define mysql_fetch_row(%1) 													mysql_fetch_row_format(%1,"|")

#if !defined FALSE
    stock bool:FALSE = false;
#endif

// Dialog IDS
#define LOGIN																	(1)
#define REGISTER																(2)

// Outros
enum rick_p
{
    pLayaName[24],
	pPassword[35],
	pMatou,
	pMorreu,
	pDinheiro,
	pAdmin,
	Float:pPosX,
	Float:pPosY,
	Float:pPosZ,
	pInt,
    pSkin,
    pBanco,
    pLevel,
    pTut
}
new PlayerInfo[MAX_PLAYERS][rick_p];
new u_Msg[128], Query[700]; //Global Query :D
new msg[128];
new VehicleNames[212][] =
{
	"400 - Landstalker",		"401 - Bravura",   			"402 - Buffalo",   	"403 - Linerunner",   		"404 - Pereniel",   	"405 - Sentinel",   	"406 - Dumper",   			"407 - Firetruck",   	"408 - Trashmaster",   	"409 - Stretch",
	"410 - Manana",				"411 - Infernus",   		"412 - Voodoo",   	"413 - Pony",   			"414 - Mule",   		"415 - Cheetah",   		"416 - Ambulance",   		"417 - Leviathan",   	"418 - Moonbeam",   	"419 - Esperanto",   		"420 - Taxi",
	"421 - Washington",			"422 - Bobcat",   			"423 - Mr Whoopee",	"424 - BF Injection",   	"425 - Hunter",   		"426 - Premier",   		"427 - Enforcer",   		"428 - Securicar",   	"429 - Banshee",   		"430 - Predator",
	"431 - Bus",   				"432 - Rhino",   			"433 - Barracks",   "434 - Hotknife",   		"435 - Trailer",   		"436 - Previon",   		"437 - Coach",   			"438 - Cabbie",   		"439 - Stallion",   	"440 - Rumpo",   			"441 - RC Bandit",		"442 - Romero",
	"443 - Packer",   			"444 - Monster",   			"445 - Admiral",   	"446 - Squalo",   			"447 - Seasparrow",   	"448 - Pizzaboy",   	"449 - Tram",   			"450 - Trailer",   		"451 - Turismo",   		"452 - Speeder",   			"453 - Reefer",   		"454 - Tropic",   		"455 - Flatbed",
	"456 - Yankee",   			"457 - Caddy",   			"458 - Solair",   	"459 - Berkley's RC Van",   "460 - Skimmer",   		"461 - PCJ-600",   		"462 - Faggio",   			"463 - Freeway",   		"464 - RC Baron",   	"465 - RC Raider",
	"466 - Glendale",   		"467 - Oceanic",   			"468 - Sanchez",   	"469 - Sparrow",   			"470 - Patriot",   		"471 - Quad",   		"472 - Coastguard",   		"473 - Dinghy",   		"474 - Hermes",   		"475 - Sabre",   			"476 - Rustler",
	"477 - ZR350",   			"478 - Walton",   			"479 - Regina",   	"480 - Comet",   			"481 - BMX",   			"482 - Burrito",   		"483 - Camper",   			"484 - Marquis",   		"485 - Baggage",   		"486 - Dozer",   			"487 - Maverick",   	"488 - News Chopper",
	"489 - Rancher",   			"490 - FBI Rancher",   		"491 - Virgo",   	"492 - Greenwood",   		"493 - Jetmax",   		"494 - Hotring",   		"495 - Sandking",   		"496 - Blista Compact",	"497 - Police Maverick",
	"498 - Boxville",   		"499 - Benson",   			"500 - Mesa",   	"501 - RC Goblin",   		"502 - Hotring Racer",	"503 - Hotring Racer",	"504 - Bloodring Banger",   "505 - Rancher",   		"506 - Super GT",
	"507 - Elegant",   			"508 - Journey",   			"509 - Bike",   	"510 - Mountain Bike",   	"511 - Beagle",   		"512 - Cropdust",   	"513 - Stunt",   			"514 - Tanker",   		"515 - RoadTrain",   	"516 - Nebula",   			"517 - Majestic",
	"518 - Buccaneer",   		"519 - Shamal",   			"520 - Hydra",   	"521 - FCR-900",   			"522 - NRG-500",   		"523 - HPV1000",   		"524 - Cement Truck",   	"525 - Tow Truck",   	"526 - Fortune",   		"527 - Cadrona",   			"528 - FBI Truck",
	"529 - Willard",   			"530 - Forklift",   		"531 - Tractor",   	"532 - Combine",   			"533 - Feltzer",   		"534 - Remington",   	"535 - Slamvan",   			"536 - Blade",   		"537 - Freight",   		"538 - Streak",   			"539 - Vortex",   		"540 - Vincent",
	"541 - Bullet",   			"542 - Clover",   			"543 - Sadler",   	"544 - Firetruck",   		"545 - Hustler",   		"546 - Intruder",   	"547 - Primo",   			"548 - Cargobob",   	"549 - Tampa",   		"550 - Sunrise",   			"551 - Merit",   		"552 - Utility",
	"553 - Nevada",   			"554 - Yosemite",   		"555 - Windsor",   	"556 - Monster",   			"557 - Monster",   		"558 - Uranus",   		"559 - Jester",   			"560 - Sultan",   		"561 - Stratum",   		"562 - Elegy",   			"563 - Raindance",   	"564 - RC Tiger",
	"565 - Flash",   			"566 - Tahoma",   			"567 - Savanna",   	"568 - Bandito",   			"569 - Freight",   		"570 - Trailer",   		"571 - Kart",   			"572 - Mower",   		"573 - Duneride",   	"574 - Sweeper",   			"575 - Broadway",
	"576 - Tornado",   			"577 - AT-400",   			"578 - DFT-30",   	"579 - Huntley",   			"580 - Stafford",   	"581 - BF-400",   		"582 - Newsvan",   			"583 - Tug",   			"584 - Trailer",   		"585 - Emperor",   			"586 - Wayfarer",
	"587 - Euros",   			"588 - Hotdog",   			"589 - Club",   	"590 - Trailer",   			"591 - Trailer",   		"592 - Andromada",   	"593 - Dodo",   			"594 - RC Cam",   		"595 - Launch",   		"596 - Police Car (LSPD)",   "597 - Police Car (SFPD)",
	"598 - Police Car (LVPD)",   "599 - Police Ranger",   	"600 - Picador",   	"601 - S.W.A.T. Van",   	"602 - Alpha",   		"603 - Phoenix",   		"604 - Glendale",   		"605 - Sadler",   		"606 - Luggage Trailer A",
	"607 - Luggage Trailer B",   "608 - Stair Trailer",   	"609 - Boxville",	"610 - Farm Plow",   		"611 - Utility Trailer"
};

main()
{
    print("----------------------------------------------------");
    print("                       Gamemode por Ricop522        ");
    print("                       carregado com sucesso !      ");
    print("----------------------------------------------------");
}

public OnGameModeInit()
{
	new stuff[128];
    mysql_connect(SQL_HOST, SQL_USER, SQL_DB, SQL_PASS);
	mysql_debug(1);
    mysql_query("CREATE TABLE IF NOT EXISTS playerinfo(user VARCHAR(24) NOT NULL, password VARCHAR(40) NOT NULL, matou INT(20) NOT NULL, morreu INT(20) NOT NULL, dinheiro INT(20) NOT NULL, admin INT(20) NOT NULL, posx INT(20) NOT NULL, posy INT(20) NOT NULL, posz INT(20) NOT NULL, interior INT(20) NOT NULL, skin INT(20) NOT NULL, banco INT(20) NOT NULL, level INT(20) NOT NULL, tutorial INT(20) NOT NULL)");

	SetGameModeText("MySQL 0.3");
	format(stuff, 128, "hostname %s", SERVER_NOME);
	SendRconCommand(stuff);
	format(stuff, 128, "mapname %s", SERVER_MAPA);
	SendRconCommand(stuff);

    return 1;
}

public OnGameModeExit()
{
	mysql_close();
	return 1;
}

public OnPlayerConnect(playerid)
{
	resetarVariaveis(playerid);
    iniciarConexao(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	salvarPlayer(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerSpawn(playerid);
    return 1;
}

forward SetPlayerSpawn(playerid);
public SetPlayerSpawn(playerid)
{
    SetPlayerInterior(playerid, PlayerInfo[playerid][pInt]);
	SetPlayerPos(playerid, PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY],PlayerInfo[playerid][pPosZ]); // Warp the player
    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
    return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID) PlayerInfo[playerid][pMatou] += 1;
    PlayerInfo[playerid][pMorreu] += 1;
	return 1;
}

public OnPlayerText(playerid, text[])
{
    format(msg, 128, "%s (%i): %s", pName(playerid), playerid, text);
    SendClientMessageToAll(-1, msg);
    SetPlayerChatBubble(playerid, msg, COLOR_PINK, 100.0, 10000);
	return 0;
}

/*==============================================================================ADMIN CMDS
==============================================================================*/
CMD:creditos(playerid, params[]) return SendClientMessage(playerid, -1, "Créditos: Ricop522");
CMD:v(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "* Saia desse carro!");
    if(PlayerInfo[playerid][pAdmin] < 1336) return SendClientMessage(playerid, COLOR_RED, "Você não é admin.");
	new
		sCar,
		VehicleID,
		Float:X,
		Float:Y,
		Float:Z,
		Float:Ang,
		Int;

	if(unformat(params, "s[20]", params)) return SendClientMessage(playerid, COLOR_RED, ""#CRED"USE: "#CORANGE"/v [id/modelo]");
	sCar = GetVehicleModelIDFromName(params);
	if(sCar < 400 || sCar > 611) return SendClientMessage(playerid, COLOR_RED, "* modelo inválido!");

	GetPlayerPos(playerid,X, Y, Z);
	GetPlayerFacingAngle(playerid, Ang);
	Int = GetPlayerInterior(playerid);
	VehicleID = CreateVehicle(sCar, X, Y, Z, Ang, -1, -1, -1);

	SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(playerid));

	PutPlayerInVehicle(playerid, VehicleID, 0);
	LinkVehicleToInterior(VehicleID, Int);
	SendFMessage(playerid, -1, ""#CORANGE"Criou um: "#CBLUE"%s "#CWHITE"- "#CBLUE"%d", VehicleNames[sCar - 400], sCar);
	return 1;
}
CMD:viraradmin(playerid, params[])
    return PlayerInfo[playerid][pAdmin] = 1338;


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case REGISTER:
		{
		    if(!response)
		    {
				SendClientMessage(playerid, COLOR_GREY, "Você saiu.");
				Kick(playerid);
			}
			else
			{
			    if(!strlen(inputtext)) DialogInput(playerid, REGISTER, ""#CCADET"[Conta - Registro]", ""CYELLOW"Digite uma senha abaixo para registrar-se!", "Registrar", "Sair");

				new	EscPass[30],
					EscName[MAX_PLAYER_NAME];

				mysql_real_escape_string(pName(playerid), EscName);
				mysql_real_escape_string(inputtext, EscPass);

				format(Query, sizeof(Query), "INSERT INTO `playerinfo` (`user`, `password`) VALUES ('%s', md5('%s'))", EscName, EscPass);
				mysql_query(Query);


				SendClientMessage(playerid, COLOR_CADETBLUE, "Registrado com sucesso na nossa database.");
				GivePlayerMoney(playerid, 5000);
				
				SetPVarInt(playerid, "LoggedIN", 1);
                PlayerInfo[playerid][pPosX] = 1612.324;
				PlayerInfo[playerid][pPosY] = -2330.167;
				PlayerInfo[playerid][pPosZ] = 13.5469;
				PlayerInfo[playerid][pTut] = 0;
                carregarPlayer(playerid);
            }
		}
		case LOGIN:
		{
		    if(!response)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Você saiu!");
				Kick(playerid);
			}
			else
			{
			    if(!strlen(inputtext)) DialogInput(playerid, LOGIN, ""#CCADET"[Conta - Login]", ""#CYELLOW"Digite a senha da conta para registrar!", "Logar", "Sair");

				new
					EscPass[38];


				mysql_real_escape_string(inputtext, EscPass);

				format(Query, sizeof(Query), "SELECT * FROM `playerinfo` WHERE `user` = '%s' AND `password` = md5('%s')", pName(playerid), EscPass);

				mysql_query(Query);
				mysql_store_result();

				if(mysql_num_rows() > 0)
				{
				    carregarPlayer(playerid);
                    SetPVarInt(playerid, "LoggedIN", 1);
				}
				else
				{
    				SendClientMessage(playerid, COLOR_RED, "Ops, senha incorreta!");
				    DialogInput(playerid, LOGIN, ""#CCADET"[Conta - Login]", ""#CYELLOW"Você tem 3 chances antes de levar KICK automático..", "Logar", "Sair");
				}
			}
		}
	}
	return 1;
}

stock carregarPlayer(playerid)
{
	//Carregar
    if(mysql_fetch_row(Query))
	{
        sscanf(Query, "e<p<|>s[24]s[35]ddddfffddddd>", PlayerInfo[playerid]);
		mysql_free_result();
	}
    //Fim
    SendClientMessage(playerid, -1, "------------------------------------------------");
    SendClientMessage(playerid, 0xEEEEEEAA, "Versão: MySQL 0.3");
    SendClientMessage(playerid, 0xEEEEEEAA, "Criador: Ricop522");
    SendClientMessage(playerid, -1, "------------------------------------------------");
    SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ], 1.0, 0, 0, 0, 0, 0, 0);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
    SpawnPlayer(playerid);
    if(PlayerInfo[playerid][pTut] == 0)
    {
        SendClientMessage(playerid, -1, "Tutorial não iniciado !");
    }
    return 1;
}

stock salvarPlayer(playerid)
{
	new sQuery[500];
    if(GetPVarInt(playerid, "LoggedIN") == 1)
	{
		GetPlayerPos(playerid, PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ]);
        format(sQuery, sizeof(sQuery), "UPDATE `playerinfo` SET `matou` = %d, `morreu` = %d, `dinheiro` = %d, `admin` = %d, `posx` = %f, `posy` = %f, `posz` = %f, `interior` = %d, `skin` = %d, `banco` = %d, `level` = %d, tutorial = %d WHERE `user` = '%s'",
		PlayerInfo[playerid][pMatou],
		PlayerInfo[playerid][pMorreu],
		GetPlayerMoney(playerid),
		PlayerInfo[playerid][pAdmin],
		PlayerInfo[playerid][pPosX],
		PlayerInfo[playerid][pPosY],
		PlayerInfo[playerid][pPosZ],
		GetPlayerInterior(playerid),
		PlayerInfo[playerid][pSkin],
        PlayerInfo[playerid][pBanco],
        PlayerInfo[playerid][pLevel],
        PlayerInfo[playerid][pTut],
        pName(playerid));
		mysql_query(sQuery);
		mysql_free_result();
		return 1;
	}
	else return 0;
}

stock iniciarConexao(playerid)
{
	new EscName[MAX_PLAYER_NAME];

	mysql_real_escape_string(pName(playerid), EscName);

	format(Query, sizeof(Query), "SELECT * FROM `playerinfo` WHERE `user` = '%s'", EscName);

	mysql_query(Query);
	mysql_store_result();

	if(mysql_num_rows() != 0)
	{
		format(msg, sizeof(msg), "Bem vindo de volta %s\n\n\nInsira a senha da sua conta para continuar :", pName(playerid), playerid);
	    DialogInput(playerid, LOGIN, "[Conta - Login]", msg, "Logar", "Sair");
	}
	else
	{
	    format(msg, sizeof(msg), "Bem vindo: %s(%d)\nEssa conta não está registrada, digite a senha para registra-lá abaixo :", pName(playerid), playerid);
		DialogInput(playerid, REGISTER, "[Conta - Registro]", msg, "Registrar", "Sair");
	}
	mysql_free_result();
}

stock resetarVariaveis(playerid)
{
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pMatou] = 0;
	PlayerInfo[playerid][pMorreu] = 0;
	PlayerInfo[playerid][pDinheiro] = 0;
	PlayerInfo[playerid][pPosX] = 0.0;
	PlayerInfo[playerid][pPosY] = 0.0;
	PlayerInfo[playerid][pPosZ] = 0.0;
	PlayerInfo[playerid][pInt] = 0;
}

GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if (strfind(VehicleNames[i], vname, true) != -1)
		return i + 400;
	}
	return -1;
}

stock pName(playerid)
{
	new escname[24], Pname[24];
    GetPlayerName(playerid, Pname, 24);
	mysql_real_escape_string(Pname, escname);
	return escname;
}
