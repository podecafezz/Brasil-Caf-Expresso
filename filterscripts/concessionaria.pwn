
#define PRESSED(%0) 			\
									(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define JFSCON     				\
									"Concessionaria/Veiculos/Dono_%s.ini"
#define AdicionarVIP			\
									0 // Restrição para VIP Comprar carros ! Bote 1 se quiser usar
#define MaxCarros				\
									100  // MaxCarros  = 50 + 1 NULL !!!!
#define PrecoCarros				\
									10000 // Preço dos Carros ao Comprar
#define GranaVenderCarro		\
									80000 // Grana ao Vender seu Carro !
#define JFSQuantCarrosTextD		\
									98
#define CARROSPAGINA 			\
									21
#define CARROSLINHA  			\
								 	7
#define jCOR_FUNDO              \
                                    0xF0F8FFFF


#include <a_samp>
#include <dof2>
#include <zcmd>



//	   ---	   Preço veículos
#define 	PRECO_ADMIRAL 			30000
#define 	PRECO_ALPHA 			64000
#define 	PRECO_BANSHEE           150000
#define 	PRECO_BANDITO 			32000
#define 	PRECO_BF_INJECTION 		20000
#define 	PRECO_BLADE 			60000
#define 	PRECO_BLISTA_COMPACT 	15000
#define 	PRECO_BLOODRING_BANGER 	45000
#define 	PRECO_BOBCAT 			32000
#define 	PRECO_BOXVILLE 			26000
#define 	PRECO_BRAVURA 			33000
#define 	PRECO_BROADWAY 			64000
#define 	PRECO_BUCCANEER 		40000
#define 	PRECO_BUFFALO 			70000
#define 	PRECO_PERENNIEL         19000
#define 	PRECO_BULLET            200000
#define 	PRECO_BURRITO 			48000
#define 	PRECO_CAMPER 			14500
#define 	PRECO_CHEETAH 			65000
#define 	PRECO_CLOVER 			25000
#define 	PRECO_CLUB 				47000
#define 	PRECO_COMET             30500
#define 	PRECO_ELEGANT 			49000
#define 	PRECO_ELEGY 			98000
#define 	PRECO_EMPEROR 			55000
#define 	PRECO_ESPERANTO 		22000
#define 	PRECO_EUROS 			74000
#define 	PRECO_FELTZER 			33000
#define 	PRECO_FLASH 			82000
#define 	PRECO_GLENDALE 			26000
#define 	PRECO_GREENWOOD 		20000
#define 	PRECO_HERMES 			41000
#define 	PRECO_HOTKNIFE 			66000
#define 	PRECO_HOTRING 			200000
#define 	PRECO_HUNTLEY 			160000
#define 	PRECO_HUSTLER 			59000
#define 	PRECO_INFERNUS          600000
#define 	PRECO_JESTER 			140000
#define 	PRECO_KART 				14000
#define 	PRECO_LANDSTALKER       130000
#define 	PRECO_MAJESTIC 			37000
#define 	PRECO_MESA 				56000
#define 	PRECO_MOONBEAM 			51000
#define 	PRECO_PERENNIEL 		19000
#define 	PRECO_PHOENIX 			150000
#define 	PRECO_PICADOR 			21000
#define 	PRECO_RANCHER 			84000
#define 	PRECO_REMINGTON 		57000
#define 	PRECO_SABRE 			45000
#define 	PRECO_SADLER 			24000
#define 	PRECO_SANDKING 			80000
#define 	PRECO_SAVANNA 			78000
#define 	PRECO_SLAMVAM 			45000
#define 	PRECO_STAFFORD          175000
#define 	PRECO_STRATUM 			67500
#define 	PRECO_STRETCH           105000
#define 	PRECO_SULTAN 			74000
#define 	PRECO_SUNRISE 			51000
#define 	PRECO_SUPER_GT 			200000
#define 	PRECO_TORNADO 			63000
#define 	PRECO_TURISMO 			150000
#define 	PRECO_URANOS 			77000
#define 	PRECO_VINCENT 			42000
#define 	PRECO_VIRGO 			22000
#define 	PRECO_VOODOO 			53000
#define 	PRECO_WALTON 			7500
#define 	PRECO_WASHINGTON 		67000
#define 	PRECO_WILLARD 			37000
#define 	PRECO_YOSEMITE 			77000
#define 	PRECO_ZR_350 			127500
#define 	PRECO_BF_400            10000
#define 	PRECO_BIKE 				300
#define 	PRECO_BMX               750
#define 	PRECO_FAGGIO 			5000
#define 	PRECO_FCR_900 			40000
#define 	PRECO_FREEWAY 			74500
#define 	PRECO_NRG_500 			89000
#define 	PRECO_PCJ_600 			12500
#define 	PRECO_QUAD 				7500
#define 	PRECO_SANCHEZ 			10000
#define 	PRECO_WAYFARER 			20000
#define 	PRECO_URANUS 			75000



new Float:VRandSpawn[][4] =
{
    {533.8918,-1319.3507,16.8116,95.7052},
    {533.8918,-1319.3507,16.8116,95.7052},
    {533.8918,-1319.3507,16.8116,95.7052},
    {533.8918,-1319.3507,16.8116,95.7052},
    {533.8918,-1319.3507,16.8116,95.7052},
    {533.8918,-1319.3507,16.8116,95.7052},
    {2533.8918,-1319.3507,16.8116,95.7052},
    {533.8918,-1319.3507,16.8116,95.7052}
};

new gItemList[JFSQuantCarrosTextD] =
{
	400,401,402,404,405,410,411,412,413,414,415,418,419,421,422,424,426,429,434,436,439,440,442,
	443,445, 451,458,459,461,462,463,466,467,468,471,474,475, 477,478,479,480,
	482,483,485,489,491,492,494,495,496,500,502, 503, 504,505,506,507,508, 516,517,518,521,522,
	526,527,529,533,534,535, 526, 540, 541,542,543, 547,549,550,551,555,559,560,561,562, 565,566,
	567,575,576,579,579,580,581, 585,587,589,600,602,603,
};

enum JFSInformacoes
{
	JFSModelo,
	JFSDono[MAX_PLAYER_NAME],
    Float:JFSCorX,
    Float:JFSCorY,
    Float:JFSCorZ,
    Float:JFSAngulo,
    JFSCor1,
    JFSCor2,
    JFSCofre,
    JFSPlaca
};



new
    JFSCarros[MaxCarros][JFSInformacoes],
	JFSID[MaxCarros],
	CarroJFS[MaxCarros],
	gTotalItems = JFSQuantCarrosTextD,
	PlayerText:gCurrentPageTextDrawId[MaxCarros],
	PlayerText:gHeaderTextDrawId[MaxCarros],
	PlayerText:gBackgroundTextDrawId[MaxCarros],
	PlayerText:gNextButtonTextDrawId[MaxCarros],
	PlayerText:gPrevButtonTextDrawId[MaxCarros],
	PlayerText:gSelectionItems[MaxCarros][CARROSPAGINA],
	gSelectionItemsTag[MaxCarros][CARROSPAGINA],
	gItemAt[MaxCarros],
	Celulas[124],
	JFSCheck[MaxCarros]
;




public OnFilterScriptInit()
{
 	Create3DTextLabel("Concessionária\nAperte 'Y' para utilizar", -1, 548.3907, -1287.7068, 16.7539, 40.0, 0);
 	format(Celulas, sizeof(Celulas), "/Concessionaria");
 	if(!DOF2::FileExists(Celulas))
 	{
        for(new x=0; x < 20; ++x) {
		print("[Concessionária] - NÃO EXISTE A PASTA Concessionaria NO SCRIPTFILES ! CRIE AGORA !");
		}
		SendRconCommand("exit");
	}
 	format(Celulas, sizeof(Celulas), "/Concessionaria/Veiculos");
 	if(!DOF2::FileExists(Celulas))
 	{
        for(new x=0; x < 20; ++x) {
		print("[Concessionária] - NÃO EXISTE A PASTA Veiculos EM Concessionaria NOS SCRIPTFILES ! CRIE AGORA !");
		}
		SendRconCommand("exit");
	}
	print("[Concessionária] - Carregado com Sucesso !");
	return true;
}

public OnFilterScriptExit()
{
	DOF2::Exit();
	return true;
}

public OnPlayerConnect(playerid)
{
    CarregarCarro(playerid);
    gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;

    for(new x=0; x < CARROSPAGINA; x++) {
        gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
	}

	gItemAt[playerid] = 0;

	return true;
}

public OnPlayerDisconnect(playerid)
{
    JFSDestroyVehicle(playerid);
	return true;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
   	if(GetPVarInt(playerid, "JFSTextAtivado") == 0) return false;

	if(clickedid == Text:INVALID_TEXT_DRAW) {
        DestroySelectionMenu(playerid);
        SetPVarInt(playerid, "JFSTextAtivado", 0);
        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        return true;
	}
	return false;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(GetPVarInt(playerid, "JFSTextAtivado") == 0) return false;
	new curpage = GetPVarInt(playerid, "JFSPagina");

	if(playertextid == gNextButtonTextDrawId[playerid])
	{
	    if(curpage < (GETNumeroPaginas() - 1))
		{
	        SetPVarInt(playerid, "JFSPagina", curpage + 1);
	        ShowPlayerModelPreviews(playerid);
         	UpdatePageTextDraw(playerid);
         	PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
		} else {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return true;
	}
	if(playertextid == gPrevButtonTextDrawId[playerid])
	{
	    if(curpage > 0)
		{
	    	SetPVarInt(playerid, "JFSPagina", curpage - 1);
	    	ShowPlayerModelPreviews(playerid);
	    	UpdatePageTextDraw(playerid);
	    	PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
		} else {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return true;
	}
	new x=0;
	while(x != CARROSPAGINA)
	{
	    if(GetPlayerMoney(playerid) < PrecoCarros) return SendClientMessage(playerid, -1, "| ERRO | Você não tem dinheiro suficiente ! R$80.000");
	    if(playertextid == gSelectionItems[playerid][x])
		{
	        JFSComprouVeiculo(playerid, x);
	        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
	        DestroySelectionMenu(playerid);
	        CancelSelectTextDraw(playerid);
        	SetPVarInt(playerid, "JFSTextAtivado", 0);
        	return true;
		}
		x++;
	}
	return false;
}

public OnPlayerCommandText(playerid, cmdtext[]) return false;

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (PRESSED(KEY_YES))
	{
	    if(IsPlayerInRangeOfPoint(playerid, 1.0, 548.3907, -1287.7068, 16.7539))
	    {
			if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, "| ERRO | Você Não comprar veiculo dentro de um.");
			if((CarroJFS[playerid] == 1)) return SendClientMessage(playerid, -1, "| ERRO | Você Já Tem um Veiculo.");
			#if(AdicionarVIP == 1)
			if(VariavelVIP < 1)  return SendClientMessage(playerid, -1, "| ERRO | Você Não é VIP.");
			#endif
			DestroySelectionMenu(playerid);
	    	SetPVarInt(playerid, "JFSTextAtivado", 1);
	    	CreateSelectionMenu(playerid);
	    	SelectTextDraw(playerid, 0xACCBF1FF);
		}
	}
	return true;
}


CMD:excluirveiculo(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xDEEE20FF, "| ERRO | Comando inválido");
	format(Celulas, sizeof(Celulas), JFSCON, PlayerName(playerid));
	if(!DOF2::FileExists(Celulas)) return SendClientMessage(playerid, -1, "Esse Úsuario não tem veiculo!");
	format(Celulas, sizeof(Celulas), "Arquivo Veiculo_%s.ini Excluido com Sucesso dos ScriptFiles !", PlayerName(playerid));
	SendClientMessage(playerid, -1, Celulas);
	DOF2::RemoveFile(Celulas);
	DOF2::SaveFile();
	if(IsPlayerConnected(strlen(PlayerName(playerid))))
	{
	    JFSID[strlen(params)] = 0;
	    DestroyVehicle(JFSID[strlen(PlayerName(playerid))]);
	}
	return true;
}

CMD:menuveiculo(playerid, params[])
{
    format(Celulas, sizeof(Celulas), JFSCON, PlayerName(playerid));
	if (!DOF2::FileExists(Celulas)) return SendClientMessage ( playerid , -1 , "| ERRO | Você não tem um veiculo!" ) ;
 	if (!IsPlayerInVehicle(playerid, JFSID[playerid])) return SendClientMessage (playerid , -1 , "Você não está em seu veiculo." ) ;
	ShowPlayerDialog(playerid, 7337, DIALOG_STYLE_LIST, "Menu Veiculo", "Estacionar Aqui\nCor do Veiculo\nVender Veiculo\nPlaca do Veiculo", "Selecionar", "Cancelar");
	return true;
}

CMD:irla(playerid, params[])
{
//    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xDEEE20FF, "Apenas Para Administrador Logado na RCON!");
    SetPlayerPos(playerid, 548.3907, -1287.7068, 16.7539);
    return true;
}

CMD:localizarveiculo(playerid, params[])
{
    format(Celulas, sizeof(Celulas), JFSCON, PlayerName(playerid));
	if (!DOF2::FileExists(Celulas)) return SendClientMessage ( playerid , -1 , "| ERRO | Você não tem um veiculo!" ) ;
	JFSCheck[playerid] = 1;
	static Float:CordX, Float:CordY, Float:CordZ;
	GetVehiclePos(JFSID[playerid], CordX, CordY, CordZ);
	SetPlayerCheckpoint (playerid , CordX, CordY, CordZ, 10.0);
 	SendClientMessage(playerid , -1, "| INFO | O Seu Veículo foi Marcado no Mapa!");
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
  	  if(dialogid == 7337)
	  {
			if(response)
			{
			    if(listitem == 0)
			    {
   					new VeiculoID = JFSID[playerid];
    				static Float:CordX, Float:CordY, Float:CordZ, Float:Angulo;
 			    	GetVehiclePos(VeiculoID, CordX, CordY, CordZ);
					GetVehicleZAngle(VeiculoID, Angulo);
					JFSCarros[playerid][JFSCorX] = CordX;
					JFSCarros[playerid][JFSCorY] = CordY;
					JFSCarros[playerid][JFSCorZ] = CordZ;
					JFSCarros[playerid][JFSAngulo] = Angulo;
			      	DestroyVehicle(VeiculoID);
      				JFSID[playerid] = CreateVehicle(JFSCarros[playerid][JFSModelo], JFSCarros[playerid][JFSCorX], JFSCarros[playerid][JFSCorY], JFSCarros[playerid][JFSCorZ], JFSCarros[playerid][JFSAngulo], JFSCarros[playerid][JFSCor1] , JFSCarros[playerid][JFSCor2], 0);
    				PutPlayerInVehicle(playerid, JFSID[playerid], 0);
					SendClientMessage(playerid, -1, "| INFO | Seu Veiculo vai da Spawn Aqui Agora!");
					SalvarArquivos(playerid);
          		}
			    if(listitem == 1)
			    {
			      	ShowPlayerDialog(playerid, 3773, DIALOG_STYLE_INPUT, "Concessionária - Cor", "DIGITE O ID DA COR 1 DE SEU VEICULO\n\n\nPS: As Cores Foram Modificadas na versão 0.3x.", "Comprar", "Cancelar");
				}
			    if(listitem == 2)
			    {
			      	format(Celulas, sizeof(Celulas), "Concessionária - Seu Veiculo Será Vendido Por %d.\n\nCaso Queria Vender seu Veículo, Confirme Abaixo.\n\n", GranaVenderCarro);
			      	ShowPlayerDialog(playerid, 4217, DIALOG_STYLE_MSGBOX, "Concessionária - Vender Veiculo", Celulas, "Confirmar", "Cancelar");
				}
			    if(listitem == 3)
			    {
			      	ShowPlayerDialog(playerid, 2461, DIALOG_STYLE_INPUT, "Concessionária - Placa", "DIGITE A PLACA DO SEU VEICULO\n\n", "Trocar", "Cancelar");
				}
          	}
          	return true;
      }
   	  if(dialogid == 4217)
	  {
			if(response)
			{
			    format(Celulas, sizeof(Celulas), JFSCON, PlayerName(playerid));
			   	DOF2::RemoveFile(Celulas);
			  	DOF2::SaveFile();
			  	DestroyVehicle(JFSID[playerid]);
          		CarroJFS[playerid] = 0;
  				RemovePlayerFromVehicle(playerid);
  				format(Celulas, sizeof(Celulas), "| Concessionária | Você Vendeu seu veiculo e ganhou %d.", GranaVenderCarro);
  				SendClientMessage(playerid, -1, Celulas);
  				GivePlayerMoney(playerid, GranaVenderCarro);
			}
          	return true;
      }
   	  if(dialogid == 2461)
	  {
			if(response)
			{
			    if(strlen(inputtext) > 1 && strlen(inputtext) < 9)
			    {
			        format(Celulas,sizeof(Celulas),"%s", inputtext);
					static Float:CordX, Float:CordY, Float:CordZ, Float:Angulo;
	       			new VeiculoID = JFSID[playerid];
				    SetVehicleNumberPlate(VeiculoID, Celulas);
				    GetVehiclePos(VeiculoID, CordX, CordY, CordZ);
					GetVehicleZAngle(VeiculoID, Angulo);
					SetVehicleToRespawn(VeiculoID);
					SetVehiclePos(VeiculoID, CordX, CordY, CordZ);
	                SetVehicleZAngle(VeiculoID, Angulo);
					PutPlayerInVehicle(playerid, VeiculoID, 0);
					format(JFSCarros[playerid][JFSPlaca] , 9,"%s", inputtext);
					SalvarArquivos(playerid);
				}
				else SendClientMessage(playerid, -1, "{FF0000}| ERRO | Apenas Caractéristicas de 2 a 8 !");
			}
          	return true;
      }
   	  if(dialogid == 3773)
	  {
			if(response)
			{
       			new VeiculoID = JFSID[playerid];
			    if(!strval(inputtext)) return SendClientMessage(playerid, -1, "{FF0000}| ERRO | Apenas Numeros!"), true;
			    if(strval(inputtext) < 0 || strval(inputtext) > 255) return SendClientMessage(playerid, -1, "{FF0000}| ERRO | Existes Cores Apenas Entre 0 á 255."), true;
                JFSCarros[playerid][JFSCor1] = strval(inputtext);
                ChangeVehicleColor(VeiculoID, JFSCarros[playerid][JFSCor1], -1);
				ShowPlayerDialog(playerid, 7733, DIALOG_STYLE_INPUT, "Concessionária - Cor", "DIGITE O ID DA COR 2 DE SEU VEICULO\n\n\nPS: As Cores Foram Modificadas na versão 0.3x.", "Comprar", "Cancelar");
          	}
          	return true;
      }
   	  if(dialogid == 7733)
	  {
			if(response)
			{
			    new VeiculoID = JFSID[playerid];
			    if(!strval(inputtext)) return SendClientMessage(playerid, -1, "{FF0000}| ERRO | Apenas Numeros!"), ShowPlayerDialog(playerid, 7733, DIALOG_STYLE_INPUT, "JFS Concessionária v1.0 - Cor", "DIGITE O ID DA COR 2 DE SEU VEICULO\n\n\nPS: As Cores Foram Modificadas na versão 0.3x.", "Comprar", "Cancelar"), true;
			    if(strval(inputtext) < 0 || strval(inputtext) > 255) return SendClientMessage(playerid, -1, "{FF0000}| ERRO | Existes Cores Apenas Entre 0 á 255."), ShowPlayerDialog(playerid, 7733, DIALOG_STYLE_INPUT, "JFS Concessionária v1.0 - Cor", "DIGITE O ID DA COR 2 DE SEU VEICULO\n\n\nPS: As Cores Foram Modificadas na versão 0.3x.", "Comprar", "Cancelar"), true;
                JFSCarros[playerid][JFSCor2] = strval(inputtext);
                ChangeVehicleColor(VeiculoID, JFSCarros[playerid][JFSCor1], JFSCarros[playerid][JFSCor2]);
                SendClientMessage(playerid, -1, "| INFO | Cores Definidas com Sucesso!");
                SalvarArquivos(playerid);
          	}
          	else ShowPlayerDialog(playerid, 7733, DIALOG_STYLE_INPUT, "Concessionária - Cor", "DIGITE O ID DA COR 2 DE SEU VEICULO\n\n\n", "Comprar", "Cancelar");
          	return true;
      }
      return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	    if(newstate == PLAYER_STATE_DRIVER)
	    {
			for(new carro, JFS = sizeof(JFSCarros); carro != JFS; carro++)
        	{
        		if(JFSID[carro] == GetPlayerVehicleID(playerid) && strcmp(PlayerName(playerid), JFSCarros[carro][JFSDono], true))
        		{
	         		format(Celulas, sizeof(Celulas), "{FFFF00}| INFO | Este veículo pertence ao jogador{FFFFFF} %s{FFFF00} e você não pode dirigí-lo.", JFSCarros[carro][JFSDono]);
	         		SendClientMessage(playerid, -1, Celulas);
	         		RemovePlayerFromVehicle(playerid);
        		}
        		if(JFSID[carro] == GetPlayerVehicleID(playerid) && !strcmp(PlayerName(playerid), JFSCarros[carro][JFSDono], true))
        		{
	         		SendClientMessage(playerid, -1, "| INFO | Bem Vindo ao Seu Veiculo Concessionária Use: /menuveiculo");
        		}
        	}
	    }
    	return true;
}

public OnPlayerEnterCheckpoint (playerid)
{
    if (JFSCheck[playerid] == 1 )
    {
        SendClientMessage (playerid , -1 , "| INFO | Aqui Está Seu Veículo!");
        DisablePlayerCheckpoint (playerid);
        return true;
    }
    return true;
}


stock PlayerName(playerid)
{
    new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name, sizeof(Name));
	return Name;
}



stock SalvarArquivos(playerid)
{
    format(Celulas, sizeof(Celulas), JFSCON, PlayerName(playerid));
    if(!DOF2::FileExists(Celulas)) DOF2::CreateFile(Celulas), DOF2::SetString(Celulas,"Dono", PlayerName(playerid));
    JFSCarros[playerid][JFSDono] = PlayerName(playerid);
  	format(JFSCarros[playerid][JFSDono], MAX_PLAYER_NAME, DOF2::GetString(Celulas, "Dono"));
    DOF2::SetString(Celulas,"Dono", JFSCarros[playerid][JFSDono]);
	DOF2::SetInt(Celulas,"Modelo", JFSCarros[playerid][JFSModelo]);
	DOF2::SetFloat(Celulas,"CorX", JFSCarros[playerid][JFSCorX]);
	DOF2::SetFloat(Celulas,"CorY", JFSCarros[playerid][JFSCorY]);
	DOF2::SetFloat(Celulas,"CorZ", JFSCarros[playerid][JFSCorZ]);
	DOF2::SetFloat(Celulas,"Angulo", JFSCarros[playerid][JFSAngulo]);
	DOF2::SetInt(Celulas,"Cor1", JFSCarros[playerid][JFSCor1]);
	DOF2::SetInt(Celulas,"Cor2", JFSCarros[playerid][JFSCor2]);
	DOF2::SetString(Celulas,"Placa", JFSCarros[playerid][JFSPlaca]);
	DOF2::SetInt(Celulas,"Cofre", JFSCarros[playerid][JFSCofre]);

	format(JFSCarros[playerid][JFSDono], MAX_PLAYER_NAME, DOF2::GetString(Celulas, "Dono"));
	DOF2::GetString(Celulas, "Dono", JFSCarros[playerid][JFSDono]);
 	JFSCarros[playerid][JFSModelo] = DOF2::GetInt(Celulas, "Modelo");
  	JFSCarros[playerid][JFSCorX] = DOF2::GetFloat(Celulas, "CorX");
   	JFSCarros[playerid][JFSCorY] = DOF2::GetFloat(Celulas, "CorY");
   	JFSCarros[playerid][JFSCorZ] = DOF2::GetFloat(Celulas, "CorZ");
   	JFSCarros[playerid][JFSAngulo] = DOF2::GetFloat(Celulas, "Angulo");
	JFSCarros[playerid][JFSCor1] = DOF2::GetInt(Celulas, "Cor1");
	JFSCarros[playerid][JFSCor2] = DOF2::GetInt(Celulas, "Cor2");
	DOF2::GetString(Celulas, "Placa", JFSCarros[playerid][JFSPlaca]);
	JFSCarros[playerid][JFSCofre] = DOF2::GetInt(Celulas, "Cofre");
	DOF2::SaveFile();
	return true;
}

stock CarregarCarro(playerid)
{
    format(Celulas, sizeof(Celulas), JFSCON, PlayerName(playerid));
    if(DOF2::FileExists(Celulas))
    {
        format(JFSCarros[playerid][JFSDono], MAX_PLAYER_NAME, DOF2::GetString(Celulas, "Dono"));
		DOF2::GetString(Celulas, "Dono", JFSCarros[playerid][JFSDono]);
	    JFSCarros[playerid][JFSModelo] = DOF2::GetInt(Celulas, "Modelo");
	    JFSCarros[playerid][JFSCorX] = DOF2::GetFloat(Celulas, "CorX");
	    JFSCarros[playerid][JFSCorY] = DOF2::GetFloat(Celulas, "CorY");
	   	JFSCarros[playerid][JFSCorZ] = DOF2::GetFloat(Celulas, "CorZ");
	   	JFSCarros[playerid][JFSAngulo] = DOF2::GetFloat(Celulas, "Angulo");
		JFSCarros[playerid][JFSCor1] = DOF2::GetInt(Celulas, "Cor1");
	   	JFSCarros[playerid][JFSCor2] = DOF2::GetInt(Celulas, "Cor2");
	   	JFSCarros[playerid][JFSCofre] = DOF2::GetInt(Celulas, "Cofre");
	   	DOF2::GetString(Celulas, "Placa", JFSCarros[playerid][JFSPlaca]);
        DOF2::SaveFile();
	    JFSCreateVehicle(playerid);
    }
	return true;
}

stock JFSCreateVehicle(playerid)
{
    CarroJFS[playerid] = 1;
    JFSID[playerid] = CreateVehicle(JFSCarros[playerid][JFSModelo], JFSCarros[playerid][JFSCorX], JFSCarros[playerid][JFSCorY], JFSCarros[playerid][JFSCorZ], JFSCarros[playerid][JFSAngulo], JFSCarros[playerid][JFSCor1] , JFSCarros[playerid][JFSCor2], 0);
   	SetVehicleNumberPlate(JFSID[playerid], JFSCarros[playerid][JFSPlaca]);
	return true;
}

stock JFSDestroyVehicle(playerid)
{
    format(Celulas, sizeof(Celulas), JFSCON, PlayerName(playerid));
	if(DOF2::FileExists(Celulas)) DestroyVehicle(JFSID[playerid]), CarroJFS[playerid] = 0;
	return true;
}

GETNumeroPaginas()
{
	if((gTotalItems >= CARROSPAGINA) && (gTotalItems % CARROSPAGINA) == 0)
	{
		return (gTotalItems / CARROSPAGINA);
	}
	else return (gTotalItems / CARROSPAGINA) + 1;
}

PlayerText:CreateCurrentPageTextDraw(playerid, Float:Xpos, Float:Ypos)
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, "0/0");
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}
PlayerText:CreatePlayerDialogButton(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, button_text[])
{
 	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, button_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 1);
   	PlayerTextDrawBoxColor(playerid, txtInit, 60);
   	PlayerTextDrawBackgroundColor(playerid, txtInit,5);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 0);
    PlayerTextDrawColor(playerid, txtInit, 0xFFFFFFFF);
    PlayerTextDrawSetSelectable(playerid, txtInit, 1);
    PlayerTextDrawAlignment(playerid, txtInit, 2);
    PlayerTextDrawTextSize(playerid, txtInit, Height, Width);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

PlayerText:CreatePlayerHeaderTextDraw(playerid, Float:Xpos, Float:Ypos, header_text[])
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, header_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 1.25, 3.0);
	PlayerTextDrawFont(playerid, txtInit, 0);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xFFFFFFFF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

PlayerText:CreatePlayerBackgroundTextDraw(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height)
{
	new PlayerText:txtBackground = CreatePlayerTextDraw(playerid, Xpos, Ypos,
	"                                            ~n~");
    PlayerTextDrawUseBox(playerid, txtBackground, 1);
    PlayerTextDrawBoxColor(playerid, txtBackground, 60);
	PlayerTextDrawLetterSize(playerid, txtBackground, 5.0, 5.0);
	PlayerTextDrawFont(playerid, txtBackground, 0);
	PlayerTextDrawSetShadow(playerid, txtBackground, 0);
    PlayerTextDrawSetOutline(playerid, txtBackground, 0);
    PlayerTextDrawColor(playerid, txtBackground, 0xFFFFFFFF);
    PlayerTextDrawTextSize(playerid, txtBackground, Width, Height);
   	PlayerTextDrawBackgroundColor(playerid, txtBackground,0xFFFFFFFF);
    PlayerTextDrawShow(playerid, txtBackground);
    return txtBackground;
}

PlayerText:CreateModelPreviewTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:width, Float:height)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, "");
    PlayerTextDrawFont(playerid, txtPlayerSprite, TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawColor(playerid, txtPlayerSprite,  jCOR_FUNDO);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, width, height);
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
    PlayerTextDrawSetPreviewRot(playerid,txtPlayerSprite, -16.0, 0.0, -55.0);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, 1);
    PlayerTextDrawShow(playerid,txtPlayerSprite);
    return txtPlayerSprite;
}

JFSComprouVeiculo(playerid, Modelo)
{
	new rand = random(sizeof(VRandSpawn));
	JFSCarros[playerid][JFSModelo] = gSelectionItemsTag[playerid][Modelo];
	JFSCarros[playerid][JFSCorX] = VRandSpawn[rand][0];
	JFSCarros[playerid][JFSCorY] = VRandSpawn[rand][1];
	JFSCarros[playerid][JFSCorZ] = VRandSpawn[rand][2];
	JFSCarros[playerid][JFSAngulo] = VRandSpawn[rand][3];
	JFSCarros[playerid][JFSCor1] = -1;
	JFSCarros[playerid][JFSCor2] = -1;
 	JFSID[playerid] = CreateVehicle(JFSCarros[playerid][JFSModelo], JFSCarros[playerid][JFSCorX], JFSCarros[playerid][JFSCorY], JFSCarros[playerid][JFSCorZ], JFSCarros[playerid][JFSAngulo], JFSCarros[playerid][JFSCor1] , JFSCarros[playerid][JFSCor2], 0);
    PutPlayerInVehicle(playerid, JFSID[playerid], 0);
    CarroJFS[playerid] = 1;
    GivePlayerMoney(playerid, -PrecoCarros);
    format(Celulas, sizeof(Celulas), "~w~VEICULO COMPRADO POR ~r~%dR$", PrecoCarros);
    GameTextForPlayer(playerid, Celulas , 5000,4);
	SalvarArquivos(playerid);
}

DestroyPlayerModelPreviews(playerid)
{
	new x=0;
	while(x != CARROSPAGINA) {
	    if(gSelectionItems[playerid][x] != PlayerText:INVALID_TEXT_DRAW) {
			PlayerTextDrawDestroy(playerid, gSelectionItems[playerid][x]);
			gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
		}
		x++;
	}
}

ShowPlayerModelPreviews(playerid)
{
    new x=0;
	new Float:BaseX = 75.0;
	new Float:BaseY = 130.0 - (70.0 * 0.33);
	new linetracker = 0;

	new itemat = GetPVarInt(playerid, "JFSPagina") * CARROSPAGINA;

	DestroyPlayerModelPreviews(playerid);
	while(x != CARROSPAGINA && itemat < gTotalItems) {
	    if(linetracker == 0) {
	        BaseX = 75.0 + 25.0;
	        BaseY += 70.0 + 1.0;
		}
  		gSelectionItems[playerid][x] = CreateModelPreviewTextDraw(playerid, gItemList[itemat], BaseX, BaseY, 60.0, 70.0);
  		gSelectionItemsTag[playerid][x] = gItemList[itemat];
		BaseX += 60.0 + 1.0;
		linetracker++;
		if(linetracker == CARROSLINHA) linetracker = 0;
		itemat++;
		x++;
	}
}

UpdatePageTextDraw(playerid)
{
	new PageText[64+1];
	format(PageText, 64, "%d/%d", GetPVarInt(playerid,"JFSPagina") + 1, GETNumeroPaginas());
	PlayerTextDrawSetString(playerid, gCurrentPageTextDrawId[playerid], PageText);
}

CreateSelectionMenu(playerid)
{
    gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, 75.0, 130.0 + 20.0, 550.0, 180.0);
    gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, 75.0, 130.0, "Concessionaria");
    gCurrentPageTextDrawId[playerid] = CreateCurrentPageTextDraw(playerid, 550.0 - 30.0, 130.0 + 15.0);
    gNextButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, 550.0 - 30.0, 130.0+180.0+100.0, 50.0, 16.0, "Proximo");
    gPrevButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, 550.0 - 90.0, 130.0+180.0+100.0, 50.0, 16.0, "Anterior");

    ShowPlayerModelPreviews(playerid);
    UpdatePageTextDraw(playerid);
   	SendClientMessage(playerid, -1, "| INFO | Para Sair aperte ESC !");
}

DestroySelectionMenu(playerid)
{
	DestroyPlayerModelPreviews(playerid);

	PlayerTextDrawDestroy(playerid, gHeaderTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gBackgroundTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gCurrentPageTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gNextButtonTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gPrevButtonTextDrawId[playerid]);

	gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
}






