/*http://forum.sa-mp.com/showthread.php?t=548602*/
//------------------------------------------------------------------------------------------------
	/*Include*/
#include a_samp
#include streamer
#include zcmd
//------------------------------------------------------------------------------------------------
#define FILTERSCRIPT
#if defined FILTERSCRIPT
#endif
//------------------------------------------------------------------------------------------------
#if defined CREDITO
**********************************
*  Nome: Drive Thru			     *
*  Versão: 1.6	                 *
*  Criador : Learning			 *
*  Data: 13. Janeiro. 2015       *
**********************************
#endif
//------------------------------------------------------------------------------------------------
	/*Cores*/
#define     VERMELHO    0xFF0000FF
#define     AZUL        0x1E90FFFF
//------------------------------------------------------------------------------------------------
	/*Dialog*/
#define		DriveThru  02015
#define     Bebida     12015
#define     Lanche     22015
#define     DVS        32015
//------------------------------------------------------------------------------------------------
/*Defines*/
new DV[6], DThru[1200];
//------------------------------------------------------------------------------------------------
public OnFilterScriptInit()
{
								/*Objetos*/
	//Lampadas
	CreateDynamicObject(3666,796.2999900,-1632.8000000,12.9000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3666,804.2999900,-1633.0000000,13.1000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3666,2402.7000000,-1509.9000000,23.3000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3666,2402.7002000,-1501.9004000,23.3000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3666,1183.8000000,-898.0999800,42.8000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3666,1185.2000000,-906.4000200,42.8000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3666,-2348.2000000,-156.6000100,34.8000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3666,-2348.2000000,-148.2000000,34.8000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3666,1861.1000000,2089.6001000,10.3000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3666,1861.0000000,2080.8999000,10.3000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3666,2483.8999000,2017.9000000,10.3000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3666,2483.8000000,2026.7000000,10.3000000,0.0000000,0.0000000,0.0000000); //
	//Posters
	CreateDynamicObject(2642,2483.7000000,2018.5000000,11.0000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2642,1861.3000000,2089.1001000,11.0000000,0.0000000,0.0000000,170.0000000); //
	CreateDynamicObject(2642,-2347.6884800,-148.8769500,36.1853800,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2642,-2347.7000000,-148.6000100,35.3000000,0.0000000,0.0000000,178.0000000); //
	CreateDynamicObject(2642,795.2999900,-1632.9000000,13.3000000,0.0000000,0.0000000,210.0000000); //
	CreateDynamicObject(2642,1184.2000000,-905.7999900,43.2000000,0.0000000,0.0000000,220.0000000); //
	CreateDynamicObject(2642,2401.8000000,-1502.0000000,23.8000000,0.0000000,0.0000000,220.0000000); //
	//Bases
	CreateDynamicObject(3881,799.7999900,-1635.4000000,14.3000000,0.0000000,0.0000000,270.0000000); //
	CreateDynamicObject(3881,2404.3999000,-1506.4000000,24.9000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3881,1186.4000000,-902.4000200,43.8000000,0.0000000,0.0000000,8.0000000); //
	CreateDynamicObject(3881,-2346.7000000,-152.8999900,36.2000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3881,1862.5000000,2084.7000000,11.7000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3881,2483.2000000,2022.8000000,11.9000000,0.0000000,0.0000000,180.0000000); //
//------------------------------------------------------------------------------------------------
	/*TextLabel*/
	Create3DTextLabel("{FF1E1E}DriveThru", 0xFFD700FF, 2401.9275,-1506.4696,23.3550, 40.0, 0, 0);
	Create3DTextLabel("{FF1E1E}DriveThru", 0xFFD700FF, 800.5552,-1629.6398,12.9030, 40.0, 0, 0);
	Create3DTextLabel("{FF1E1E}DriveThru", 0xFFD700FF, 2486.0686,2022.3807,10.3402, 40.0, 0, 0);
	Create3DTextLabel("{FF1E1E}DriveThru", 0xFFD700FF, 1179.7521,-902.8798,42.8330, 40.0, 0, 0);
	Create3DTextLabel("{FF1E1E}DriveThru", 0xFFD700FF, 1857.3107,2081.2676,10.3387, 40.0, 0, 0);
	Create3DTextLabel("{FF1E1E}DriveThru", 0xFFD700FF, -2350.0037,-155.5846,34.8405, 40.0, 0, 0);
//------------------------------------------------------------------------------------------------
	/*CheckPoint*/
	new playerid;
	DV[0] = SetPlayerCheckpoint(playerid, 2401.9275,-1506.4696,23.3550, 5.0);
	DV[1] = SetPlayerCheckpoint(playerid, 1179.7521,-902.8798,42.8330, 5.0);
	DV[2] = SetPlayerCheckpoint(playerid, 800.5552,-1629.6398,12.9030, 5.0);
	DV[3] = SetPlayerCheckpoint(playerid, 1857.3107,2081.2676,10.3387, 5.0);
	DV[4] = SetPlayerCheckpoint(playerid, 2486.0686,2022.3807,10.3402, 5.0);
	DV[5] = SetPlayerCheckpoint(playerid, -2350.0037,-155.5846,34.8405, 5.0);
//------------------------------------------------------------------------------------------------
	print("| Drive Thru | Ligado !");
	print("By : Learning");
	print("http://forum.sa-mp.com/showthread.php?t=548602");
	return 1;
}
//------------------------------------------------------------------------------------------------
	/*Comando*/
CMD:drivethru(playerid)
{
	if(!IsPlayerInAnyVehicle( playerid ))
	{
		SendClientMessage( playerid, VERMELHO, "| Drive Thru | Você não está em um veículo !" );
		return 1;
	}
	if( !IsPlayerInRangeOfPoint(playerid, 5.0, 2401.9275,-1506.4696,23.3550) && !IsPlayerInRangeOfPoint(playerid, 5.0, 1179.7521,-902.8798,42.8330)
	&& !IsPlayerInRangeOfPoint(playerid, 5.0, 800.5552,-1629.6398,12.9030) && !IsPlayerInRangeOfPoint(playerid, 5.0, 1857.3107,2081.2676,10.3387)
	&& !IsPlayerInRangeOfPoint(playerid, 5.0, 2486.0686,2022.3807,10.3402) && !IsPlayerInRangeOfPoint(playerid, 5.0, -2350.0037,-155.5846,34.8405))
	return SendClientMessage(playerid,VERMELHO,"| ERRO | Você não está em um Drive Thru !");
	ShowPlayerDialog(playerid,DriveThru,DIALOG_STYLE_LIST,"Cardápio Drive Thru","{FF0000}- {5F9EA0}Bebida\n{FF0000}- {5F9EA0}Lanche\n","Comprar","Cancelar");
	return 1;
}
CMD:dvs(playerid)
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem Permissão !");
	ShowPlayerDialog(playerid, DVS, DIALOG_STYLE_LIST, "Drive Thru","LS - Drive Thru\nLS[2] - Drive Thru\nLS[3] - Drive Thru\nSF - Drive Thru\
	\nLV - Drive Thru\nLV[2] - Drive Thru\n", "Selecionar", "Cancelar");
	return 1;
}
//------------------------------------------------------------------------------------------------
public OnPlayerEnterCheckpoint(playerid)
{
	if(!DV[0] && !DV[1] && !DV[2] && !DV[3] && !DV[4] && !DV[5] && !IsPlayerInAnyVehicle(playerid))
	    return 1;
	SendClientMessage(playerid, 0xFF0000FF, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, 0x1E90FFFF, " Olá {FFFFFF}Trabalhador, {1E90FF}você está no {FFFFFF}DriveThru {1E90FF}!");
	SendClientMessage(playerid, 0x1E90FFFF, " Para vê nossas Ofertas --> {FFFFFF}/DriveThru");
	SendClientMessage(playerid, 0xFF0000FF, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}
//------------------------------------------------------------------------------------------------
	/*Dialog*/
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DriveThru)
	{
		if(response)
		{
			switch(listitem)
			{
	          	case 0://Bebida
	            {
	                strcat(DThru, "Agua Natural - {3DB134}$3,00\nAgua c. Gás - {3DB134}$3,00\nCoca-Cola - {3DB134}$7,00\nGuarana - {3DB134}$5,00\nFanta Uva - {3DB134}$4,00\n");
	                strcat(DThru, "Fanta Laranja - {3DB134}$4,00\nItubaina - {3DB134}$4,00\nSprite - {3DB134}$3,00\nKuat - {3DB134}$3,00\nSuco de Maçã - {3DB134}$2,00\n");
	                strcat(DThru, "Suco de Laranja - {3DB134}$2,00\nSuco de Limão - {3DB134}$2,00\nSuco de Maracuja - {3DB134}$2,00\nSuco de Morango - {3DB134}$2,00\n");
	                strcat(DThru, "Suco de Abacaxi - {3DB134}$2,00\nCafé - {3DB134}$3,00\nCafé c.Leite - {3DB134}$3,00");
	                ShowPlayerDialog(playerid, Bebida, DIALOG_STYLE_LIST, "Bebidas", DThru, "Comprar", "Sair");
	            }
				case 1://Lanche
				{
	                strcat(DThru, "Arroz & Feijão - {3DB134}$25,00\nFeijoada - {3DB134}$18,00\nLasanha d.Frango - {3DB134}$35,00\nLasanha d.Carne - {3DB134}$35,00\n");
	                strcat(DThru, "Porção d.Frango F - {3DB134}$20,00\nPorção d.Batata F - {3DB134}$22,00\nPorção d.Mandioca - {3DB134}$18,00\nPastel - {3DB134}$5,00\n");
	                strcat(DThru, "Esfirra d.Carne - {3DB134}$4,00\nEsfirra d.Frango - {3DB134}$4,00\nPizza d. Queijo - {3DB134}$24,00\nPizza d.Calabresa - {3DB134}$25,00\n");
	                strcat(DThru, "Pizza d.Bacon - {3DB134}$30,00\nPizza d.Bauru - {3DB134}$23,00");
	                ShowPlayerDialog(playerid, Lanche, DIALOG_STYLE_LIST, "Comidas", DThru, "Comprar", "Sair");
				}
			}
		}
	}
//------------------------------------------------------------------------------------------------
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
					GivePlayerMoney(playerid, -3);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Agua Natural");
				}
				case 1://Coca Cola
				{
					if(GetPlayerMoney(playerid) < 7) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$7 para comprar!");
					GivePlayerMoney(playerid, -7);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Coca-Cola");
				}
				case 2://Guarana
				{
					if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$5 para comprar!");
					GivePlayerMoney(playerid, -5);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Guarana");
				}
				case 3://Fanta Uva
				{
					if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$4 para comprar!");
					GivePlayerMoney(playerid, -4);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Fanta Uva");
				}
				case 4://Fanta Laranja
				{
					if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$4 para comprar!");
					GivePlayerMoney(playerid, -4);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Fanta Laranja");
				}
				case 5://Itubaina
				{
					if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$4 para comprar!");
					GivePlayerMoney(playerid, -4);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Itubaina");
				}
				case 6://Sprit
				{
					if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$3 para comprar!");
					GivePlayerMoney(playerid, -3);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Sprit");
				}
				case 7://Kuat
				{
					if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$3 para comprar!");
					GivePlayerMoney(playerid, -3);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar uma {FFFFFF}Kuat");
				}
				case 8://Suco d.Maçã
				{
					if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$2 para comprar!");
					GivePlayerMoney(playerid, -2);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Suco de Maçã");
				}
				case 9://Suco d.Laranja
				{
					if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$2 para comprar!");
					GivePlayerMoney(playerid, -2);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Suco de Laranja");
				}
				case 10://Suco d.Limão
				{
					if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$2 para comprar!");
					GivePlayerMoney(playerid, -2);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Suco de Limão");
				}
				case 11://Suco d.Maracuja
				{
					if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$2 para comprar!");
					GivePlayerMoney(playerid, -2);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Suco de Maracuja");
				}
				case 12://Suco d.Morango
				{
					if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$2 para comprar!");
					GivePlayerMoney(playerid, -2);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Suco de Morango");
				}
				case 13://Suco d.Abacaxi
				{
					if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$2 para comprar!");
					GivePlayerMoney(playerid, -2);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de tomar um {FFFFFF}Suco de Abacaxi");
				}

				case 14:
				{

					ShowPlayerDialog(playerid, DriveThru, DIALOG_STYLE_LIST, "Cardápio Drive Thru","{FF0000}- {5F9EA0}Bebida\n{FF0000}- {5F9EA0}Lanche", "Comprar", "Cancelar");
					return 1;
				}
			}
		}
	}
//------------------------------------------------------------------------------------------------
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
					GivePlayerMoney(playerid, -25);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer um {FFFFFF}Arroz & Feijão");
				}
				case 1://Feijoada
				{
					if(GetPlayerMoney(playerid) < 18) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$18 para comprar!");
					GivePlayerMoney(playerid, -18);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Feijoada");
				}
				case 2://Lasanha d.Frango
				{
					if(GetPlayerMoney(playerid) < 35) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$35 para comprar!");
					GivePlayerMoney(playerid, -35);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Lasanha de Frango");
				}
				case 3://Lazanha d.Carne
				{
					if(GetPlayerMoney(playerid) < 35) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$35 para comprar!");
					GivePlayerMoney(playerid, -35);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Lasanha de Carne");
				}
				case 4://Porção d.Frango F
				{
					if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$20 para comprar!");
					GivePlayerMoney(playerid, -20);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Porção de Frango Frito");
				}
				case 5://Porção d.Batata F
				{
					if(GetPlayerMoney(playerid) < 22) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$22 para comprar!");
					GivePlayerMoney(playerid, -22);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Porção de Batata Frita");
				}
				case 6://Porção d.Mandioca F
				{
					if(GetPlayerMoney(playerid) < 18) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$18 para comprar!");
					GivePlayerMoney(playerid, -18);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Porção de Mandioca Frita");
				}
				case 7://Pastel
				{
					if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$5 para comprar!");
					GivePlayerMoney(playerid, -5);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer um {FFFFFF}Pastel");
				}
				case 8://Esfirra de Carne
				{
					if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$4 para comprar!");
					GivePlayerMoney(playerid, -4);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Esfirra de Carne");
				}
				case 9://Esfirra de Carne
				{
					if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$4 para comprar!");
					GivePlayerMoney(playerid, -4);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Esfirra de Frango");
				}
				case 10://Pizza de Queijo
				{
					if(GetPlayerMoney(playerid) < 24) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$24 para comprar!");
					GivePlayerMoney(playerid, -24);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Pizza de Queijo");
				}
				case 11://Pizza de Calabresa
				{
					if(GetPlayerMoney(playerid) < 25) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$25 para comprar!");
					GivePlayerMoney(playerid, -25);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Pizza de Calabresa");
				}
				case 12://Pizza de Bacon
				{
					if(GetPlayerMoney(playerid) < 25) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$25 para comprar!");
					GivePlayerMoney(playerid, -25);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Pizza de Bacon");
				}
				case 13://Pizza de Bauru
				{
					if(GetPlayerMoney(playerid) < 30) return SendClientMessage(playerid, 0xFF0000FF,"| DriveThru | Você não tem R$30 para comprar!");
					GivePlayerMoney(playerid, -30);
					SetPlayerHealth( playerid, 100.0 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você acabou de comer uma {FFFFFF}Pizza de Bauru");
				}
				case 14:
				{
					ShowPlayerDialog(playerid, DriveThru, DIALOG_STYLE_LIST, "Cardápio Drive Thru","{FF0000}- {5F9EA0}Bebida\n{FF0000}- {5F9EA0}Lanche", "Comprar", "Cancelar");
					return 1;
				}
			}
		}
	}
//------------------------------------------------------------------------------------------------
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
				}
				case 1://LS[2]
				{
				    SetPlayerPos( playerid, 800.5552,-1629.6398,12.9030 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você foi para o Drive Thru de{FFFFFF}LS[2]");
				}
				case 2://LS[3]
				{
				    SetPlayerPos( playerid, 1179.7521,-902.8798,42.8330 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você foi para o Drive Thru de{FFFFFF}LS[3]");
				}
				case 3://SF
				{
				    SetPlayerPos( playerid, -2350.0037,-155.5846,34.8405 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você foi para o Drive Thru de{FFFFFF}SF");
				}
				case 4://LV
				{
				    SetPlayerPos( playerid, 1857.3107,2081.2676,10.3387 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você foi para o Drive Thru de{FFFFFF}LV");
				}
				case 5://LV[2]
				{
				    SetPlayerPos( playerid, 2486.0686,2022.3807,10.3402 );
					SendClientMessage(playerid, 0x1E90FFFF,"| DriveThru | Você foi para o Drive Thru de{FFFFFF}LV[2]");
				}
			}
		}
	}
	return 1;
}
//------------------------------------------------------------------------------------------------
/*http://forum.sa-mp.com/showthread.php?t=548602*/
