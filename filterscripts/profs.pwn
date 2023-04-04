#include <a_samp>
//=================== Honestas =========================
#define MOTORISTA 1
#define PARAMEDICO 2
#define PADRE 3
#define MECANICO 4
#define DESEMPREGADO 5
//=================== Máfia =======================
#define ASSASINO 6
#define TERRORISTA 7
#define PROSTITUTA 8
#define MATADOR 9
#define LADRAO 10

//Lucas Viadinho \?/
#define CAMINHONEIRO
#define SORVETEIRO
#define BANQUEIRO
#define STUNTER
#define BISPO
#define PAPA
#define DANCARINA
#define CABELEIREIRA
#define GUARDACOSTAS

//==================  Cores =======================
#define COR_MOTORISTA 0xC223B3AA
#define COR_PARAMEDICO 0x8000FFAA
#define COR_PADRE 0x000080AA
#define COR_MECANICO 0x00FF00AA
#define COR_DESEMPREGADO 0xC0C0C0AA

#define COR_ASSASINO 0x979D4FAA
#define COR_TERRORISTA 0x8080C0AA
#define COR_PROSTITUTA 0x00FFFFAA
#define COR_MATADOR 0x008000AA
#define COR_LADRAO 0xFF8000AA

//======================== news ==============================
new Prof[MAX_PLAYERS];
//========================== Menus ===========================
new Menu:honestas;
new Menu:menuprof;
new Menu:mafia;
//========================== Forwards ========================
forward SaiuDoMenu(playerid);

public OnFilterScriptInit()
{

//========================= Ìcones ===========================
        AddStaticPickup(1239, 1, 1480.9662,-1771.1660,18.7958);
//========================= Profissoes =======================

        menuprof = CreateMenu("~r~Profissoes", 0, 200.0, 100.0, 150.0, 150.0);
        AddMenuItem(menuprof, 0, "Honestas");
        AddMenuItem(menuprof, 0, "Desonestas");
        AddMenuItem(menuprof, 0, "Governo");
        AddMenuItem(menuprof, 0, "Transporte");
        AddMenuItem(menuprof, 0, "Outros");
        AddMenuItem(menuprof, 0, "<Sair>");

		honestas = CreateMenu("~r~Honestas", 0, 200.0, 100.0, 150.0, 150.0);
        AddMenuItem(honestas, 0, "Motorista Particular");
        AddMenuItem(honestas, 0, "Paramedico");
        AddMenuItem(honestas, 0, "Padre");
        AddMenuItem(honestas, 0, "Mecanico");
        AddMenuItem(honestas, 0, "Desempregado");
        AddMenuItem(honestas, 0, "<Sair>");

		honestas = CreateMenu("~r~Mafia", 0, 200.0, 100.0, 150.0, 150.0);
        AddMenuItem(mafia, 0, "Assasino");
        AddMenuItem(mafia, 0, "Terrorista");
        AddMenuItem(mafia, 0, "Prostituta");
        AddMenuItem(mafia, 0, "Matador de aluguel");
        AddMenuItem(mafia, 0, "Ladrao");
        AddMenuItem(mafia, 0, "<Sair>");

        return 1;
}


public OnPlayerCommandText(playerid, cmdtext[])
{
//===========================Comandos por rangepoint============================
        if(!strcmp("/entrar",cmdtext))
        {
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 1480.8444,-1771.5194,18.7958))
        {
        SetPlayerInterior(playerid,18);
        SetPlayerPos(playerid,1710.433715,-1669.379272,20.225049);
        } else {
        SendClientMessage(playerid,0xFFFF00AA,"|ERRO| Você não esta na porta de entrada da Agencia de empregos!");
        }
        return 1;
        }

        if(!strcmp("/sair",cmdtext))
        {
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 1702.2474,-1667.6266,20.2188))
        {
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, 1480.8920, -1763.1388, 18.7958);
        } else {
        SendClientMessage(playerid,0xFFFF00AA,"|ERRO| Você não esta na porta de saida da Agencia de empregos!");
        }
        return 1;
        }


//===================== Comandos ========================
        if(strcmp("/profs", cmdtext, true) == 0)
        {
        TogglePlayerControllable(playerid, false);
        ShowMenuForPlayer(menuprof, playerid);
        return 1;
        }
        return 0;
        }

public OnPlayerSelectedMenuRow(playerid, row)
{
//====================== Todas ===============================

    new Menu:menu = GetPlayerMenu(playerid);

    if(menu == menuprof)
        {
                switch(row)
                {
                        case 0:
                        {
                        ShowMenuForPlayer(honestas, playerid);
                        }
                        case 1:
                        {
						//botar
                        }
                        case 2:
                        {
						//botar
                        }
                        case 3:
                        {
                        //botar
                        }
                        case 4:
                        {
						//botar
                        }
                        case 5:
                        {
                        HideMenuForPlayer(menuprof, playerid);
                        }
                }
                TogglePlayerControllable(playerid, 0);
        }
//======================= Honestas ==========================
	else if(menu == honestas)
	{
		switch(row)
		{
			case 0:
   			{
                 GivePlayerWeapon(playerid, 15 , 1);
                 Prof[playerid] = MOTORISTA;
				 SendClientMessage(playerid,COR_MOTORISTA,"[INFO] Profissao Alterada com sucesso para: Motorista Particular.");

                 }
			case 1:
   			{
			     GivePlayerWeapon(playerid, 14 , 1);
                 Prof[playerid] = PARAMEDICO;
 				 SendClientMessage(playerid,COR_PARAMEDICO,"[INFO] Profissao Alterada com sucesso para: Paramédico.");

      		}
			case 2:
   			{
                 GivePlayerWeapon(playerid, 15 , 1);
                 Prof[playerid] = PADRE;
				 SendClientMessage(playerid,COR_PADRE,"[INFO] Profissao Alterada com sucesso para: Padre.");

      		}
			case 3:
   			{
				 GivePlayerWeapon(playerid, 2 , 1);
                 GivePlayerWeapon(playerid, 41 , 1);
                 Prof[playerid] = MECANICO;
				 SendClientMessage(playerid,COR_MECANICO,"[INFO] Profissao Alterada com sucesso para: Mecânico.");

      		}
			case 4:
   			{
                 GivePlayerWeapon(playerid, 6 , 1);
                 Prof[playerid] = DESEMPREGADO;
				 SendClientMessage(playerid,COR_DESEMPREGADO,"[INFO] Profissao Alterada com sucesso para: Desempregado.");

      		}
			case 5:
   			{
      		HideMenuForPlayer(honestas, playerid);
      		}

		}
	}

//========================== Desonestas ==================================

	else if(menu == mafia)
	{
		switch(row)
		{
			case 0:
   			{
                 GivePlayerWeapon(playerid, 15 , 1);
                 Prof[playerid] = ASSASINO;
                 SetPlayerColor(playerid, COR_ASSASINO);
				 SendClientMessage(playerid,COR_ASSASINO,"[INFO] Profissao Alterada com sucesso para: Assasino.");

      		}
			case 1:
   			{
			     GivePlayerWeapon(playerid, 14 , 1);
                 Prof[playerid] = TERRORISTA;
				 SendClientMessage(playerid,COR_TERRORISTA,"[INFO] Profissao Alterada com sucesso para: Terrorista.");
      		}
			case 2:
   			{
                 GivePlayerWeapon(playerid, 15 , 1);
                 Prof[playerid] = PROSTITUTA;
				 SendClientMessage(playerid,COR_PROSTITUTA,"[INFO] Profissao Alterada com sucesso para: Prostituta.");
      		}
			case 3:
   			{
				 GivePlayerWeapon(playerid, 2 , 1);
                 GivePlayerWeapon(playerid, 41 , 1);
                 Prof[playerid] = MATADOR;
				 SendClientMessage(playerid,COR_MATADOR,"[INFO] Profissao Alterada com sucesso para: Matador.");
      		}
			case 4:
   			{
                 GivePlayerWeapon(playerid, 6 , 1);
                 Prof[playerid] = LADRAO;
				 SendClientMessage(playerid,COR_LADRAO,"[INFO] Profissao Alterada com sucesso para: Ladrão");
      		}
			case 5:
   			{
      		HideMenuForPlayer(mafia, playerid);
      		}

		}
	}

    return 1;
}
