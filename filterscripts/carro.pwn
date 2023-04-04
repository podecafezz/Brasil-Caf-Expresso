#include <a_samp>

#define DialogCaixaSom 12

new SomVeiculoTipo[MAX_VEHICLES];
new SomVeiculoObjeto[3][MAX_VEHICLES];
new bool:SomInstalado[MAX_VEHICLES];
new Float:SomPos[3][MAX_VEHICLES][6];

public OnFilterScriptInit()
{
	for(new i; i < MAX_VEHICLES;i++)
	{
	    if(SomInstalado[i] == true)
     	{
     	    if(SomVeiculoTipo[i] == 1)
	    		CreateSomObjeto(i,2232,0,SomPos[0][i][0],SomPos[0][i][1],SomPos[0][i][2],SomPos[0][i][3],SomPos[0][i][4],SomPos[0][i][5],300);
			else
			{
			    for(new j; j < 3;j++)
			        CreateSomObjeto(i,2232,0,SomPos[j][i][0],SomPos[j][i][1],SomPos[j][i][2],SomPos[j][i][3],SomPos[j][i][4],SomPos[j][i][5],300);
			}
		}
	}
	return 1;
}

public OnFilterScriptExit()
{
	//----------------------------------------------------------------------------------------
	//Criar os objetos de som nos veiculos ao carregar o filter script
	//Necessario salvar, carregar as variaveis do som antes de criar
	//----------------------------------------------------------------------------------------
	for(new i; i < MAX_VEHICLES ;i++)
	{
	    if(SomInstalado[i] == true)
		{
		    if(SomVeiculoTipo[i] == 1)
		    	DestroyObject(SomVeiculoObjeto[0][i]);
            else
			{
			    for(new j; j < 3;j++)
			        DestroyObject(SomVeiculoObjeto[j][i]);
   			}
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	//----------------------------------------------------------------------------------------
	//Comando de instalarsom
	//Necessario pegar a cordenada do local de tunar e colocar o if IsPlayerInRangeOfPoint
	//Tirar comentario das linhas
	//----------------------------------------------------------------------------------------

	if (strcmp("/instalarsom", cmdtext) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
		    switch (GetVehicleModel(GetPlayerVehicleID(playerid)))
		    {
			    case 400,401,402,404,405,409,410,411,412,415,418,419,
		             420,421,422,426,429,434,436,438,439,444,445,451,458,466,467,
					 470,474,475,477,478,479,480,483,489,490,491,492,494,495,496,
					 500,502,503,504,505,506,507,516,517,518,526,527,529,533,534,535,536,
					 540,541,542,543,545,546,547,549,550,551,554,555,556,557,558,559,
					 560,561,562,565,566,567,575,576,578,579,580,585,587,589,596,597,598,
					 600,602,603,604,605:
			    {
				  //if(IsPlayerInRangeOfPoint(playerid,5,Pos[0],Pos[1],Pos[2]))
				  //{
						SetVehicleParamsEx(GetPlayerVehicleID(playerid),0,0,0,0,0,1,0);
						ShowPlayerDialog(playerid, DialogCaixaSom, DIALOG_STYLE_LIST, "Som Automotivo", "Instalar Som\nEditar\nRemover Som\n", "Ok", "Cancelar");
						PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                  //}
			  	  //else
				  //   SendClientMessage(playerid, -1,"Você não está na Som & Rodas para instalar som em seu veículo!");
				}
				default:
					SendClientMessage(playerid, 0xB4B5B7FF,"Você não pode instalar som neste veículo.");
			}
		}
		else
		    SendClientMessage(playerid, 0xB4B5B7FF,"Você não pode instalar som neste veículo.");
	}
	return 0;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DialogCaixaSom)  //Dialog de instalar remover ou editar o som
    {
        if(response)
        {
            if(listitem == 0)   //instalar
            {
				ShowPlayerDialog(playerid, DialogCaixaSom + 1, DIALOG_STYLE_LIST, "Tipo de Instalação", "Caixa Deitada(R$5.000)\nTrio(R$20.000)", "Ok", "Cancelar");
			}
			if(listitem == 1)   //Editar
            {
                if(SomInstalado[GetPlayerVehicleID(playerid)] == true)
                	ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Edição", "Ok", "Cancelar");
				else
                	SendClientMessage(playerid,-1,"Seu véiculo não tem equipamento de som instalado.");
            }
			if(listitem == 2)   //Remover
			{
			    if(SomInstalado[GetPlayerVehicleID(playerid)] == true)
			    {
			        if(SomVeiculoTipo[GetPlayerVehicleID(playerid)] == 1)
			        {
		    			DestroyObject(SomVeiculoObjeto[0][GetPlayerVehicleID(playerid)]);
	    				SomPos[0][GetPlayerVehicleID(playerid)][0] = 0;
						SomPos[0][GetPlayerVehicleID(playerid)][1] = 0;
						SomPos[0][GetPlayerVehicleID(playerid)][2] = 0;
						SomPos[0][GetPlayerVehicleID(playerid)][3] = 0;
						SomPos[0][GetPlayerVehicleID(playerid)][4] = 0;
						SomPos[0][GetPlayerVehicleID(playerid)][5] = 0;
   					}
            		else
					{
			    		for(new i; i < 3;i++)
						{
			        		DestroyObject(SomVeiculoObjeto[i][GetPlayerVehicleID(playerid)]);
		    				SomPos[i][GetPlayerVehicleID(playerid)][0] = 0;
							SomPos[i][GetPlayerVehicleID(playerid)][1] = 0;
							SomPos[i][GetPlayerVehicleID(playerid)][2] = 0;
							SomPos[i][GetPlayerVehicleID(playerid)][3] = 0;
							SomPos[i][GetPlayerVehicleID(playerid)][4] = 0;
							SomPos[i][GetPlayerVehicleID(playerid)][5] = 0;
						}
   					}
			        SomInstalado[GetPlayerVehicleID(playerid)];
					SendClientMessage(playerid,-1,"Equipamento de som removido com sucesso.");
				}
				else
				    SendClientMessage(playerid,-1,"Seu véiculo não tem equipamento de som instalado.");
			}
        }
    }
    if(dialogid == DialogCaixaSom + 1) // Dialog de instalar som
    {
        if(response)
        {
            if(listitem == 0)       //Caixa deitada
            {
                SomVeiculoTipo[GetPlayerVehicleID(playerid)] = 1;
                SendClientMessage(playerid,-1,"Instalação em andamento, aguarde...");
                CreateSomObjeto(GetPlayerVehicleID(playerid),2232,0,0,-2,0,0,-90,0,300);
                ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			}
   			if(listitem == 1)      // Trio
            {
                SomVeiculoTipo[GetPlayerVehicleID(playerid)] = 2;
                SendClientMessage(playerid,-1,"Instalação em andamento aguarde.");
                CreateSomObjeto(GetPlayerVehicleID(playerid),2232,0,0,-2,0,0,0,0,300);
                CreateSomObjeto(GetPlayerVehicleID(playerid),2232,1,-0.54,-2,0,0,0,0,300);
                CreateSomObjeto(GetPlayerVehicleID(playerid),2232,2,0.54,-2,0,0,0,0,300);
                ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			}
		}
    }
    if(dialogid == DialogCaixaSom + 2) //Dialog de mover som
    {
        if(response == 0)               //Se não finalizar destroi o som
        {
            if(SomInstalado[GetPlayerVehicleID(playerid)] == false)
            {
				if(SomVeiculoTipo[GetPlayerVehicleID(playerid)] == 1)
	   			{
	    			DestroyObject(SomVeiculoObjeto[0][GetPlayerVehicleID(playerid)]);
		    		SomPos[0][GetPlayerVehicleID(playerid)][0] = 0;
					SomPos[0][GetPlayerVehicleID(playerid)][1] = 0;
					SomPos[0][GetPlayerVehicleID(playerid)][2] = 0;
					SomPos[0][GetPlayerVehicleID(playerid)][3] = 0;
					SomPos[0][GetPlayerVehicleID(playerid)][4] = 0;
					SomPos[0][GetPlayerVehicleID(playerid)][5] = 0;
	   			}
	      		else
				{
	   				for(new i; i < 3;i++)
					{
	    				DestroyObject(SomVeiculoObjeto[i][GetPlayerVehicleID(playerid)]);
	  					SomPos[i][GetPlayerVehicleID(playerid)][0] = 0;
						SomPos[i][GetPlayerVehicleID(playerid)][1] = 0;
						SomPos[i][GetPlayerVehicleID(playerid)][2] = 0;
						SomPos[i][GetPlayerVehicleID(playerid)][3] = 0;
						SomPos[i][GetPlayerVehicleID(playerid)][4] = 0;
						SomPos[i][GetPlayerVehicleID(playerid)][5] = 0;
					}
				}
				SendClientMessage(playerid,-1,"Ok, você não quis finalizar a instalação.");
			}
		}
        if(response == 1)
        {
            if(listitem == 0)
            {
				new vehicleid = GetPlayerVehicleID(playerid);
				if(SomVeiculoTipo[GetPlayerVehicleID(playerid)] == 1)
				    if(SomPos[0][vehicleid][1] <= - 0.65)
				    {
			    		CreateSomObjeto(vehicleid,2232,0,SomPos[0][vehicleid][0],SomPos[0][vehicleid][1]+ 0.05,SomPos[0][vehicleid][2],SomPos[0][vehicleid][3],SomPos[0][vehicleid][4],SomPos[0][vehicleid][5],300);
			    		SendClientMessage(playerid,-1,"Ajuste feito.");
					}
					else
					    SendClientMessage(playerid,-1,"Limite de posicionamento da caixa atingido.");
				else
				{   if(((SomPos[0][vehicleid][1] <= - 0.65) && (SomPos[1][vehicleid][1] <= - 0.65)) && (SomPos[2][vehicleid][1] <= - 0.65))
				    {
					    CreateSomObjeto(vehicleid,2232,0,SomPos[0][vehicleid][0],SomPos[0][vehicleid][1]+ 0.05,SomPos[0][vehicleid][2],SomPos[0][vehicleid][3],SomPos[0][vehicleid][4],SomPos[0][vehicleid][5],300);
					    CreateSomObjeto(vehicleid,2232,1,SomPos[1][vehicleid][0],SomPos[1][vehicleid][1]+ 0.05,SomPos[1][vehicleid][2],SomPos[1][vehicleid][3],SomPos[1][vehicleid][4],SomPos[1][vehicleid][5],300);
					    CreateSomObjeto(vehicleid,2232,2,SomPos[2][vehicleid][0],SomPos[2][vehicleid][1]+ 0.05,SomPos[2][vehicleid][2],SomPos[2][vehicleid][3],SomPos[2][vehicleid][4],SomPos[2][vehicleid][5],300);
					    SendClientMessage(playerid,-1,"Ajuste feito.");
                    }
					else
					    SendClientMessage(playerid,-1,"Limite de posicionamento da caixa atingido.");
				}
                if(SomInstalado[GetPlayerVehicleID(playerid)] == true)
                    ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Edição", "Ok", "Cancelar");
                else
                	ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			}
			if(listitem == 1)
            {
                new vehicleid = GetPlayerVehicleID(playerid);
                if(SomVeiculoTipo[GetPlayerVehicleID(playerid)] == 1)
                    if(SomPos[0][vehicleid][1] <= -2.45)
				    {
        				CreateSomObjeto(vehicleid,2232,0,SomPos[0][vehicleid][0],SomPos[0][vehicleid][1]- 0.05,SomPos[0][vehicleid][2],SomPos[0][vehicleid][3],SomPos[0][vehicleid][4],SomPos[0][vehicleid][5],300);
        				SendClientMessage(playerid,-1,"Ajuste feito.");
					}
					else
					    SendClientMessage(playerid,-1,"Limite de posicionamento da caixa atingido.");
			   	else
				{
				    if(((SomPos[0][vehicleid][1] <= -2.45) && (SomPos[1][vehicleid][1] <= -2.45)) && (SomPos[2][vehicleid][1] <= -2.45))
				    {
						CreateSomObjeto(vehicleid,2232,0,SomPos[0][vehicleid][0],SomPos[0][vehicleid][1]- 0.05,SomPos[0][vehicleid][2],SomPos[0][vehicleid][3],SomPos[0][vehicleid][4],SomPos[0][vehicleid][5],300);
					    CreateSomObjeto(vehicleid,2232,1,SomPos[1][vehicleid][0],SomPos[1][vehicleid][1]- 0.05,SomPos[1][vehicleid][2],SomPos[1][vehicleid][3],SomPos[1][vehicleid][4],SomPos[1][vehicleid][5],300);
					    CreateSomObjeto(vehicleid,2232,2,SomPos[2][vehicleid][0],SomPos[2][vehicleid][1]- 0.05,SomPos[2][vehicleid][2],SomPos[2][vehicleid][3],SomPos[2][vehicleid][4],SomPos[2][vehicleid][5],300);
					    SendClientMessage(playerid,-1,"Ajuste feito.");
     				}
                   	else
					    SendClientMessage(playerid,-1,"Limite de posicionamento da caixa atingido.");
				}
                if(SomInstalado[GetPlayerVehicleID(playerid)] == true)
                    ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Edição", "Ok", "Cancelar");
                else
                	ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			}
			if(listitem == 2)
            {   new vehicleid = GetPlayerVehicleID(playerid);
            	if(SomVeiculoTipo[GetPlayerVehicleID(playerid)] == 1)
            	    if(SomPos[0][vehicleid][2] <= 0.40)
					{
			    		CreateSomObjeto(vehicleid,2232,0,SomPos[0][vehicleid][0],SomPos[0][vehicleid][1],SomPos[0][vehicleid][2]+ 0.05,SomPos[0][vehicleid][3],SomPos[0][vehicleid][4],SomPos[0][vehicleid][5],300);
			    		SendClientMessage(playerid,-1,"Ajuste feito.");
					}
					else
					    SendClientMessage(playerid,-1,"Limite de posicionamento da caixa atingido.");
				else
				{
				    if(((SomPos[0][vehicleid][2] <= 0.40) &&(SomPos[0][vehicleid][2] <= 0.40))&&(SomPos[0][vehicleid][2] <= 0.40))
					{
					    CreateSomObjeto(vehicleid,2232,0,SomPos[0][vehicleid][0],SomPos[0][vehicleid][1],SomPos[0][vehicleid][2]+ 0.05,SomPos[0][vehicleid][3],SomPos[0][vehicleid][4],SomPos[0][vehicleid][5],300);
					    CreateSomObjeto(vehicleid,2232,1,SomPos[1][vehicleid][0],SomPos[1][vehicleid][1],SomPos[1][vehicleid][2]+ 0.05,SomPos[1][vehicleid][3],SomPos[1][vehicleid][4],SomPos[1][vehicleid][5],300);
					    CreateSomObjeto(vehicleid,2232,2,SomPos[2][vehicleid][0],SomPos[2][vehicleid][1],SomPos[2][vehicleid][2]+ 0.05,SomPos[2][vehicleid][3],SomPos[2][vehicleid][4],SomPos[2][vehicleid][5],300);
					    SendClientMessage(playerid,-1,"Ajuste feito.");
     				}
                   	else
					    SendClientMessage(playerid,-1,"Limite de posicionamento da caixa atingido.");
				}
                if(SomInstalado[GetPlayerVehicleID(playerid)] == true)
                    ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Edição", "Ok", "Cancelar");
                else
                	ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			}
			if(listitem == 3)
            {
                new vehicleid = GetPlayerVehicleID(playerid);
                if(SomVeiculoTipo[GetPlayerVehicleID(playerid)] == 1)
                    if(SomPos[0][vehicleid][2] >= -0.20)
					{
			    		CreateSomObjeto(vehicleid,2232,0,SomPos[0][vehicleid][0],SomPos[0][vehicleid][1],SomPos[0][vehicleid][2] - 0.05,SomPos[0][vehicleid][3],SomPos[0][vehicleid][4],SomPos[0][vehicleid][5],300);
			    		SendClientMessage(playerid,-1,"Ajuste feito.");
					}
					else
					    SendClientMessage(playerid,-1,"Limite de posicionamento da caixa atingido.");
                else
				{
				    if(((SomPos[0][vehicleid][2] >= -0.20) && (SomPos[0][vehicleid][2] >= -0.20)) && (SomPos[0][vehicleid][2] >= -0.20))
					{
					    CreateSomObjeto(vehicleid,2232,0,SomPos[0][vehicleid][0],SomPos[0][vehicleid][1],SomPos[0][vehicleid][2] - 0.05,SomPos[0][vehicleid][3],SomPos[0][vehicleid][4],SomPos[0][vehicleid][5],300);
	                    CreateSomObjeto(vehicleid,2232,1,SomPos[1][vehicleid][0],SomPos[1][vehicleid][1],SomPos[1][vehicleid][2] - 0.05,SomPos[1][vehicleid][3],SomPos[1][vehicleid][4],SomPos[1][vehicleid][5],300);
	                    CreateSomObjeto(vehicleid,2232,2,SomPos[2][vehicleid][0],SomPos[2][vehicleid][1],SomPos[2][vehicleid][2] - 0.05,SomPos[2][vehicleid][3],SomPos[2][vehicleid][4],SomPos[2][vehicleid][5],300);
	                    SendClientMessage(playerid,-1,"Ajuste feito.");
					}
					else
					    SendClientMessage(playerid,-1,"Limite de posicionamento da caixa atingido.");
				}
                if(SomInstalado[GetPlayerVehicleID(playerid)] == true)
                    ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Edição", "Ok", "Cancelar");
                else
                	ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			}
			if(listitem == 4)
            {
                new vehicleid = GetPlayerVehicleID(playerid);
                if(SomVeiculoTipo[GetPlayerVehicleID(playerid)] == 1)
                {
                    if(SomPos[0][vehicleid][3] <= -5)
					{
			    		CreateSomObjeto(vehicleid,2232,0,SomPos[0][vehicleid][0],SomPos[0][vehicleid][1],SomPos[0][vehicleid][2],SomPos[0][vehicleid][3] + 5.0,SomPos[0][vehicleid][4],SomPos[0][vehicleid][5],300);
			    		SendClientMessage(playerid,-1,"Ajuste feito.");
			   		}
			   		else
			   		    SendClientMessage(playerid,-1,"Limite de posicionamento da caixa atingido.");
				}
			    else
				{
				    if(((SomPos[0][vehicleid][3] <= -5) && (SomPos[0][vehicleid][3] <= -5)) && (SomPos[0][vehicleid][3] <= -5))
					{
						CreateSomObjeto(vehicleid,2232,0,SomPos[0][vehicleid][0],SomPos[0][vehicleid][1],SomPos[0][vehicleid][2],SomPos[0][vehicleid][3] + 5.0,SomPos[0][vehicleid][4],SomPos[0][vehicleid][5],300);
					    CreateSomObjeto(vehicleid,2232,1,SomPos[1][vehicleid][0],SomPos[1][vehicleid][1],SomPos[1][vehicleid][2],SomPos[1][vehicleid][3] + 5.0,SomPos[1][vehicleid][4],SomPos[1][vehicleid][5],300);
					    CreateSomObjeto(vehicleid,2232,2,SomPos[2][vehicleid][0],SomPos[2][vehicleid][1],SomPos[2][vehicleid][2],SomPos[2][vehicleid][3] + 5.0,SomPos[2][vehicleid][4],SomPos[2][vehicleid][5],300);
					    SendClientMessage(playerid,-1,"Ajuste feito.");
					}
					else
					    SendClientMessage(playerid,-1,"Limite de posicionamento da caixa atingido.");
				}
                if(SomInstalado[GetPlayerVehicleID(playerid)] == true)
                    ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Edição", "Ok", "Cancelar");
                else
                	ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			}
			if(listitem == 5)
            {
                new vehicleid = GetPlayerVehicleID(playerid);
                if(SomVeiculoTipo[GetPlayerVehicleID(playerid)] == 1)
                    if(SomPos[0][vehicleid][3] >= -85)
                    {
			    		CreateSomObjeto(vehicleid,2232,0,SomPos[0][vehicleid][0],SomPos[0][vehicleid][1],SomPos[0][vehicleid][2],SomPos[0][vehicleid][3] - 5.0,SomPos[0][vehicleid][4],SomPos[0][vehicleid][5],300);
                        SendClientMessage(playerid,-1,"Ajuste feito.");
					}
					else
	    				SendClientMessage(playerid,-1,"Limite de posicionamento da caixa atingido.");
                else
				{
				    if(((SomPos[0][vehicleid][3] >= -85) && (SomPos[0][vehicleid][3] >= -85)) && (SomPos[0][vehicleid][3] >= -85))
				    {
					    CreateSomObjeto(vehicleid,2232,0,SomPos[0][vehicleid][0],SomPos[0][vehicleid][1],SomPos[0][vehicleid][2],SomPos[0][vehicleid][3] - 5.0,SomPos[0][vehicleid][4],SomPos[0][vehicleid][5],300);
					    CreateSomObjeto(vehicleid,2232,1,SomPos[1][vehicleid][0],SomPos[1][vehicleid][1],SomPos[1][vehicleid][2],SomPos[1][vehicleid][3] - 5.0,SomPos[1][vehicleid][4],SomPos[1][vehicleid][5],300);
					    CreateSomObjeto(vehicleid,2232,2,SomPos[2][vehicleid][0],SomPos[2][vehicleid][1],SomPos[2][vehicleid][2],SomPos[2][vehicleid][3] - 5.0,SomPos[2][vehicleid][4],SomPos[2][vehicleid][5],300);
					    SendClientMessage(playerid,-1,"Ajuste feito.");
					}
					else
	    				SendClientMessage(playerid,-1,"Limite de posicionamento da caixa atingido.");
				}
                if(SomInstalado[GetPlayerVehicleID(playerid)] == true)
                    ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Edição", "Ok", "Cancelar");
                else
                	ShowPlayerDialog(playerid, DialogCaixaSom + 2, DIALOG_STYLE_LIST, "Mover Caixa De Som:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			}
			if(listitem == 6)
            {
                if(SomInstalado[GetPlayerVehicleID(playerid)] == true)
                    SendClientMessage(playerid, -1, "Edição concluída com sucesso!");
				else
				{
	                if((SomVeiculoTipo[GetPlayerVehicleID(playerid)] == 1) && (GetPlayerMoney(playerid) >= 5000))
	                {
	                    GivePlayerMoney(playerid, -5000);
	                    SomInstalado[GetPlayerVehicleID(playerid)] = true;
	                	SendClientMessage(playerid,-1,"Instalação concluída com sucesso!");
	          		}
					else if((SomVeiculoTipo[GetPlayerVehicleID(playerid)] == 2) && (GetPlayerMoney(playerid) >= 20000))
					{
	                    GivePlayerMoney(playerid, -20000);
	                    SomInstalado[GetPlayerVehicleID(playerid)] = true;
	                	SendClientMessage(playerid,-1,"Instalação concluída com sucesso!");
	          		}
	          		else
					{
					    SendClientMessage(playerid,-1,"Você não possui dinheiro suficiente.");
					    if(SomVeiculoTipo[GetPlayerVehicleID(playerid)] == 1)
			   			{
			    			DestroyObject(SomVeiculoObjeto[0][GetPlayerVehicleID(playerid)]);
				    		SomPos[0][GetPlayerVehicleID(playerid)][0] = 0;
							SomPos[0][GetPlayerVehicleID(playerid)][1] = 0;
							SomPos[0][GetPlayerVehicleID(playerid)][2] = 0;
							SomPos[0][GetPlayerVehicleID(playerid)][3] = 0;
							SomPos[0][GetPlayerVehicleID(playerid)][4] = 0;
							SomPos[0][GetPlayerVehicleID(playerid)][5] = 0;
			   			}
			      		else
						{
			   				for(new i; i < 3;i++)
							{
			    				DestroyObject(SomVeiculoObjeto[i][GetPlayerVehicleID(playerid)]);
			  					SomPos[i][GetPlayerVehicleID(playerid)][0] = 0;
								SomPos[i][GetPlayerVehicleID(playerid)][1] = 0;
								SomPos[i][GetPlayerVehicleID(playerid)][2] = 0;
								SomPos[i][GetPlayerVehicleID(playerid)][3] = 0;
								SomPos[i][GetPlayerVehicleID(playerid)][4] = 0;
								SomPos[i][GetPlayerVehicleID(playerid)][5] = 0;
							}
						}
					}
				}
			}
		}
	}
    return 0;
}

CreateSomObjeto( vehicleid, modelo, indice, Float:px, Float:py, Float:pz, Float:rx, Float:ry, Float:rz, visao)
{
	DestroyObject(SomVeiculoObjeto[indice][vehicleid]);
	SomVeiculoObjeto[indice][vehicleid] = CreateObject( modelo, px, py, pz, rx, ry, rz, visao);
	AttachObjectToVehicle(SomVeiculoObjeto[indice][vehicleid], vehicleid, px, py, pz, rx, ry, rz);
	SomPos[indice][vehicleid][0] = px;
	SomPos[indice][vehicleid][1] = py;
	SomPos[indice][vehicleid][2] = pz;
	SomPos[indice][vehicleid][3] = rx;
	SomPos[indice][vehicleid][4] = ry;
	SomPos[indice][vehicleid][5] = rz;
}


