/*===========================================================================
           Filterscript programado por [NRG]Dark
                   dark_eagn@hotmail.com

           "O Plágio é a característica principal de imbecis sem criatividade"
           Diga não ao plágio!!
===========================================================================*/


#define FILTERSCRIPT

#include <a_samp>
#include <streamer>
#include <DOF2>
#include <zcmd>
#include <sscanf2>

#define PASTA_ARVORES   "/Natal/Arvore%d.ini"
#define MAX_ARVORES   25

#define Vermelho        0xFF0000AA


forward CriarArvore(Float:X,Float:Y,Float:Z);
forward DeletarArvore(arvoreid);
forward CarregarArvores();

new Chapeu[MAX_PLAYERS];
new Arvore[MAX_ARVORES][4];
new ProximaArvore;
new arquivo[128];
new Text3D:Id[MAX_ARVORES];
new cmd[256];

public OnFilterScriptInit()
{
	print(" [FS] Natal Carregado");
    CarregarArvores();
    SetTimer("Mensagem",300000,1);
	return 1;
}

public OnFilterScriptExit()
{
	print(" [FS] Natal Descarregado");
    DOF2_Exit();
	return 1;
}


CMD:criararvore(playerid, params[]) {
	if(IsPlayerAdmin(playerid)){
		new Float:X,Float:Y,Float:Z;
		GetPlayerPos(playerid,X,Y,Z);
		for(new i=0;i<=MAX_ARVORES;i++){
			format(arquivo,sizeof(arquivo),PASTA_ARVORES,i);
			if(!DOF2_FileExists(arquivo)){
				DOF2_CreateFile(arquivo);
				DOF2_SetFloat(arquivo,"posX",X);
				DOF2_SetFloat(arquivo,"posX",X);
				DOF2_SetFloat(arquivo,"posY",Y);
				DOF2_SetFloat(arquivo,"posZ",Z);
				CriarArvore(X,Y,Z);
				SendClientMessage(playerid,-1,"Arvore Criada!");
				return 1;
			}
		}
		SendClientMessage(playerid,Vermelho,"Limite de arvores atingido!");
	}
	return 1;
}



CMD:excluirarvore(playerid, params[]) {
	if (IsPlayerAdmin(playerid)) {
		new arvoreid;
		if (sscanf(params, "d", arvoreid)) {
			SendClientMessage(playerid, 0x008040AA, "(ERRO) Use: /excluirarvore [id].");
			return 1;
		} else {
			if (arvoreid < 0 || arvoreid > MAX_ARVORES) return SendClientMessage(playerid, Vermelho, "Id Inválido!");
			DeletarArvore(arvoreid);
			SendClientMessage(playerid, -1, "Arvore Excluida!");
		}
	}
 	return 1;
}

CMD:comandosnatal(playerid, params[]) {
	if(IsPlayerAdmin(playerid)){
		SendClientMessage(playerid,0xFF0000AA,"========== Comandos Natal ===========");
		SendClientMessage(playerid,0xFFFFFFAA,"/criararvore");
		SendClientMessage(playerid,0xFFFFFFAA,"/excluirarvore");
		SendClientMessage(playerid,0xFFFFFFAA,"/mostrarids  -  /ocultarids");
		SendClientMessage(playerid,0xFF0000AA,"========== Comandos Natal ===========");
	}
	return 1;
}


CMD:chapeu(playerid, params[]) {
	if(Chapeu[playerid]==0){
		SetPlayerAttachedObject(playerid,1,19066,2,0.13,0.0,0.0,90,90.0,0.0);
		Chapeu[playerid] = 1;
		SendClientMessage(playerid,-1,"Chapéu de Natal On");
		}else{
		RemovePlayerAttachedObject(playerid,1);
		SendClientMessage(playerid,-1,"Chapéu de Natal Off");
        Chapeu[playerid] = 0;
	}
	return 1;
}

CMD:ocultarids(playerid, params[]) {
	if(IsPlayerAdmin(playerid)){
		OcultarIds();
		SendClientMessage(playerid,-1,"Ids Ocultados!");
	}
	return 1;
}

CMD:mostrarids(playerid, params[]) {
	if(IsPlayerAdmin(playerid)){
		MostrarIds();
		SendClientMessage(playerid,-1,"Ids Exibidos!");
	}
	return 1;
}



public CriarArvore(Float:X,Float:Y,Float:Z)
{
    Arvore[ProximaArvore][0] = CreateDynamicObject(19076, X-0.39, Y+0.67, Z-0.9,   0.00, 0.00, 0.00); //Arvore
    Arvore[ProximaArvore][1] = CreateDynamicObject(19056, X-1.39, Y+0.10, Z-0.2,   0.00, 0.00, 0.00);
    Arvore[ProximaArvore][2] = CreateDynamicObject(19057, X+1.39, Y+0.45, Z-0.2,   0.00, 0.00, 0.00);
    Arvore[ProximaArvore][3] = CreateDynamicObject(19054, X-0.07, Y-0.67, Z-0.2,   0.00, 0.00, 0.00);
    ProximaArvore++;
    return (ProximaArvore-1);
}

public DeletarArvore(arvoreid)
{
    DestroyDynamicObject(Arvore[arvoreid][0]);
    DestroyDynamicObject(Arvore[arvoreid][1]);
    DestroyDynamicObject(Arvore[arvoreid][2]);
    DestroyDynamicObject(Arvore[arvoreid][3]);
    format(arquivo,128,PASTA_ARVORES,arvoreid);
    DOF2_RemoveFile(arquivo);
    ProximaArvore--;
    return 1;
}

public CarregarArvores()
{
    new string[128];
    new counter;
    for(new i=0;i<=MAX_ARVORES;i++){
        format(string,sizeof(string),PASTA_ARVORES,i);
        if(DOF2_FileExists(string)){
             CriarArvore(DOF2_GetFloat(string,"posX"),DOF2_GetFloat(string,"posY"),DOF2_GetFloat(string,"posZ"));
             counter++;
        }
    }
    format(string,sizeof(string),"%d árvores de natal carregadas!!",counter);
    if(counter>0) print(string);
    return 1;
}

stock MostrarIds()
{
    new str[50];
    for(new i=0;i<=MAX_ARVORES;i++){
        format(arquivo,128,PASTA_ARVORES,i);
        if(DOF2_FileExists(arquivo)){
            format(str,50,"Arvore id: %d",i);
            Id[i] = Create3DTextLabel(str,0xFFFF80AA,DOF2_GetFloat(arquivo,"posX"),DOF2_GetFloat(arquivo,"posY"),DOF2_GetFloat(arquivo,"posZ"),20.0,0);
        }
    }
    return 1;
}

stock OcultarIds()
{
    for(new i=0;i<=MAX_ARVORES;i++){
        Delete3DTextLabel(Id[i]);
    }
    return 1;
}

forward Mensagem();
public Mensagem(){
    SendClientMessageToAll(0xFFFFFFAA,"[!]{76EE00} Para solicitar uma ajuda Use: ~~> /Duvida");
    return 1;
}


public OnPlayerCommandReceived(playerid, cmdtext[])
{
    cmd = #;
    strcat(cmd, cmdtext);
    return 1;
}
