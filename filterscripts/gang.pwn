/*
[=================================================================================]
					X	SISTEMA DE GANGS V2.0 - BY SUB_ZERO0_   X
					X		   NÃO RETIRE OS CRÉDITOS!          X
		X CRÉDITOS X
	X PRINCIPAIS X
 - Criação: Sub_Zero0_

    X FUNÇÕES X
 - Split: Sa-mp wiki
 - DOF2: Double-o-Seven

    X SECUNDÁRIOS X
 - Idealização: Servidores de GangWar do SA-MP
 - Testers: MentoS e BreaK
 - Agradecimentos: Equipe de desenvolvimento do SA-MP e aos membros de seu fórum.
[=================================================================================]
*/
#include <a_samp>
#include <dof2>
#include <gsystem>

#define PlayersFile 	"PlayersGang.sub"
#define GangsFile 		"Gangs.sub"

#define MAX_GANGS 		256                 //Máxima quantidade de gangs
#define RESERVED_NAME 	"c_gangs"           //
#define GANG_MEMBERS    100                 //Máxima quantidade de membros em 1 gang
#define GANG_CONVIDADOS 5                   //Máxima quantidade de convidados em 1 gang
#define STRING_MEMBROS  2048

//VOCE POSSUI O TERRITORY WAR?
//#define TERRITORY_WAR                     //Tire as '//' se você tem o TerritoryWar

//GANGS DEFAULT
#define CUSTO_GANG 		-10000
#define MIN_ATK         1000
#define LEMA_DEFAULT 	"Gang sem lema... :("
#define COR_DEFAULT 	0xCCCCCCFF
#define GRANA_DEFAULT   0
#define SKIN_DEFAULT  	0
#define BANCOL_DEFAULT  4
#define POS_NV5	       	"Líder"
#define POS_NV4	       	"Sub-Líder"
#define POS_NV3	       	"Comandante"
#define POS_NV2	       	"Membro"
#define POS_NV1	       	"Recruta"
#define POS_NV0	       	"Convidado"

//GANGS DEFAULT SAIR
#define COR_SAIR	 	0xFFFFFFFF
#define SKIN_SAIR   	0

#define FILTERSCRIPT

new GangLevel[MAX_PLAYERS]=0, GangID[MAX_PLAYERS]=0;
new TempID[MAX_PLAYERS], Convite[MAX_PLAYERS]=0;
new BancoGG[MAX_GANGS];
#if defined TERRITORY_WAR
new TerrisGG[MAX_GANGS];
#endif

stock CriarGang(playerid,gangid,inputtext[])
{
	new File:file = fopen(FormatGang(gangid),io_write);
	fclose(file);
	DOF2_SetString(FormatGang(gangid),"Nome",inputtext);
	new name[MAX_PLAYER_NAME];GetPlayerName(playerid,name,sizeof(name));
	DOF2_SetString(FormatGang(gangid),"Lider",name);
	DOF2_SetString(FormatGang(gangid),"Lema",LEMA_DEFAULT);
	DOF2_SetHex(FormatGang(gangid),"Cor",COR_DEFAULT);
	DOF2_SetInt(FormatGang(gangid),"Banco",GRANA_DEFAULT);
	BancoGG[gangid]=GRANA_DEFAULT;
	DOF2_SetInt(FormatGang(gangid),"BancoL",BANCOL_DEFAULT);
	DOF2_SetInt(FormatGang(gangid),"Skin1",SKIN_DEFAULT);
	DOF2_SetInt(FormatGang(gangid),"Skin2",SKIN_DEFAULT);
	DOF2_SetInt(FormatGang(gangid),"Skin3",SKIN_DEFAULT);
	DOF2_SetInt(FormatGang(gangid),"Skin4",SKIN_DEFAULT);
	DOF2_SetInt(FormatGang(gangid),"Skin5",SKIN_DEFAULT);
	#if defined TERRITORY_WAR
	DOF2_SetInt(FormatGang(gangid),"Territorios",0);
	TerrisGG[gangid]=GRANA_DEFAULT;
	#endif
	DOF2_SetString(FormatGang(gangid),"Membros","");
	DOF2_SetInt(FormatGang(gangid),"NMembros",1);
	MudarGangPlayer(playerid,gangid);
	GangID[playerid]=gangid;
	SetPVarInt(playerid,"GangID",gangid);
	GangLevel[playerid]=5;
	DOF2_SaveFile();
	new num=DOF2_GetInt(GangF(GangsFile),RESERVED_NAME);
	if(gangid==num) DOF2_SetInt(GangF(GangsFile),RESERVED_NAME,(num+1));
	DOF2_SetInt(GangF(PlayersFile),name,gangid);
	DOF2_SaveFile();
	return 1;
}

forward AtualizarBanco(gangid,quantianova);
public AtualizarBanco(gangid,quantianova)
{
    DOF2_SetInt(FormatGang(gangid),"Banco",DOF2_GetInt(FormatGang(gangid),"Banco")+quantianova);
    BancoGG[gangid]+=quantianova;
}

stock AtualizarPlayerGang(playerid,ex=0)
{
	new gangid;
	if(ex==1)
	{
	    gangid=GangID[playerid];
	    SetPlayerColor(playerid,DOF2_GetHex(FormatGang(gangid),"Cor"));
	    return 1;
	}
	new name[MAX_PLAYER_NAME];GetPlayerName(playerid,name,sizeof(name));
	if(!DOF2_IsSet(GangF(PlayersFile),name))
	{
	    //foi kickado online
	    GangID[playerid]=0;
	    SetPVarInt(playerid,"GangID",0);
	    GangLevel[playerid]=0;
	    SetPlayerColor(playerid,COR_SAIR);
	    SetPlayerSkin(playerid,SKIN_SAIR);
	    return 1;
	}
	gangid = DOF2_GetInt(GangF(PlayersFile),name);
	if(!fexist(FormatGang(gangid)))
	{
	    //gang foi deletada
        GangID[playerid]=0;
        SetPVarInt(playerid,"GangID",0);
	    GangLevel[playerid]=0;
	    SetPlayerColor(playerid,COR_SAIR);
	    SetPlayerSkin(playerid,SKIN_SAIR);
	}
	//tudo Ok
	GangID[playerid]=gangid;
	SetPVarInt(playerid,"GangID",gangid);
	SetPlayerColor(playerid,DOF2_GetHex(FormatGang(gangid),"Cor"));
	if(!strcmp(DOF2_GetString(FormatGang(gangid),"Lider"),name)) {GangLevel[playerid]=5;}
	else
	{
	    new skinl[6];
	    format(skinl,6,"Skin%i",DOF2_GetInt(FormatGang(gangid),name));
		GangLevel[playerid]=DOF2_GetInt(FormatGang(gangid),name);
	}
	return 1;
}

stock CriarArqs()
{
	if(!fexist(GangF(PlayersFile)))
	{
		new File:pg = fopen(GangF(PlayersFile),io_write);
		fclose(pg);
	}
	if(!fexist(GangF(GangsFile)))
	{
		new File:pg = fopen(GangF(GangsFile),io_write);
		fclose(pg);
		DOF2_SetInt(GangF(GangsFile),RESERVED_NAME,1);
		DOF2_SaveFile();
	}
	return 1;
}

#if defined TERRITORY_WAR
forward AtualizarTerris(gangid,terris);
public AtualizarTerris(gangid,terris)
{
	TerrisGG[gangid]=terris;
}
#endif

stock MudarGangPlayer(playerid,gangid)
{
	GangID[playerid]=gangid;
	SetPVarInt(playerid,"GangID",gangid);
	new name[MAX_PLAYER_NAME];GetPlayerName(playerid,name,sizeof(name));
	if(gangid==0) DOF2_Unset(GangF(PlayersFile),name);
	else DOF2_SetInt(GangF(PlayersFile),name,gangid);
	AtualizarPlayerGang(playerid);
	DOF2_SaveFile();
	return 1;
}

stock TemGangF(id)
{
    new name[MAX_PLAYER_NAME];
	GetPlayerName(id,name,sizeof(name));
	if(GangID[id]!=0)
	{
	    return 4;
	}
	else
	{
		if(DOF2_IsSet(GangF(PlayersFile),name))//ele ta no arquivo?
		{
		    new gangid = DOF2_GetInt(GangF(PlayersFile),name);
		    if(!fexist(FormatGang(gangid))) return 3;//naõ existe mais essa gang
		    else
		    {
				if(DOF2_IsSet(FormatGang(gangid),name)||!strcmp(DOF2_GetString(FormatGang(gangid),"Lider"),name)) return 1;//esta tudo Ok
				else
				{
					DOF2_Unset(GangF(PlayersFile),name);
					DOF2_SaveFile();
					return 2;//ele foi kickado enquanto estava off
				}
			}
		}
	}
	return 0;
}

stock GetNewGangID()
{
    new i=DOF2_GetInt(GangF(GangsFile),RESERVED_NAME);
    if(i>=MAX_GANGS)
    {
        for(new f=1;f<MAX_GANGS;f++)
            if(!fexist(FormatGang(f))) {i=f;break;}
    }
    return i;
}

#if defined FILTERSCRIPT
public OnFilterScriptInit()
{
	print("\n===================================================");
	print(" Carregando Gang System [0.3d]");
	print(" Versao: 2.0.0 - By: Sub_Zero0_");
	print(" ");
	print(" Verificando a pasta /gangs/ ...");
	CriarArqs();
	print(" Pasta e arquivos básicos: OK");
	print(" ");
	print(" Carregado com sucesso!");
	print("===================================================\n");
	for(new gangid=1;gangid<MAX_GANGS;gangid++)
	    if(fexist(FormatGang(gangid)))
	        BancoGG[gangid]=DOF2_GetInt(FormatGang(gangid),"Banco");
	//Anti-Descompiler
	new a[][15] = { "?","0","?" };
	#pragma unused a
	new b[][15] = { "?","?" };
	#pragma unused b
	new c[][10] = { "?","?","?"};
	#pragma unused c
	//Fim
	return 1;
}
public OnFilterScriptExit()
{
	print("\n==============================================");
	print(" Descarregando Gang System [0.3d]");
	print(" Versao: 2.0.0 - By: Sub_Zero0_");
	print("==============================================\n");
	DOF2_Exit();
	return 1;
}
#else
main()
{
}
#endif

public OnPlayerConnect(playerid)
{
    GangID[playerid]=0;
    SetPVarInt(playerid,"GangID",0);
	GangLevel[playerid]=0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	GangID[playerid]=0;
	SetPVarInt(playerid,"GangID",0);
	GangLevel[playerid]=0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	new r=TemGangF(playerid);
	if(r==1) AtualizarPlayerGang(playerid);
	else if(r==4) AtualizarPlayerGang(playerid,1);
	else if(r==0) {GangID[playerid]=0;SetPVarInt(playerid,"GangID",0);}
	else if(r==2)
	{
		GangID[playerid]=0;
		SetPVarInt(playerid,"GangID",0);
		SendClientMessage(playerid,vermelho,"[SERVER] Você foi kickado ou não está na gang.");
	}
	else if(r==3)
	{
		GangID[playerid]=0;
		SetPVarInt(playerid,"GangID",0);
		SendClientMessage(playerid,vermelho,"[SERVER] A gang que você estava não existe mais.");
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(text[0]=='!'&&GangID[playerid]!=0)
	{
	    new fm[128],fm2[128],resto[128];
	    if(GangLevel[playerid]>3&&text[1]=='!')
	    {
	        new nml[MAX_PLAYER_NAME];
	        GetPlayerName(playerid,nml,sizeof(nml));
	        strmid(resto,text,2,strlen(text),128);
	        if(GangLevel[playerid]==5)
		    {
		    	format(fm,128,"~b~%s: %s",POS_NV5,resto);
		    	format(fm2,128,"[GANG CHAT] %s %s: %s",POS_NV5,nml,resto);
		    }
		    else
		    {
		        format(fm,128,"~b~%s: %s",POS_NV4,resto);
		    	format(fm2,128,"[GANG CHAT] %s %s: %s",POS_NV4,nml,resto);
		    }
	        for(new i=0;i<MAX_PLAYERS;i++)
                if(IsPlayerConnected(i))
		        	if(GangID[playerid]==GangID[i])
		        	{
		            	GameTextForPlayer(i,fm,5000,3);
		            	SendClientMessage(i,azul,fm2);
					}
	        return 0;
	    }
	    strmid(resto,text,1,strlen(text),128);
	    new name[MAX_PLAYER_NAME];GetPlayerName(playerid,name,sizeof(name));
 		switch(GangLevel[playerid])
 		{
 		    case 0:
 		        format(fm,128,"[GANG CHAT] (%s) %s: %s",POS_NV0,name,resto);
 		    case 1:
 		        format(fm,128,"[GANG CHAT] (%s) %s: %s",POS_NV1,name,resto);
            case 2:
 		        format(fm,128,"[GANG CHAT] (%s) %s: %s",POS_NV2,name,resto);
            case 3:
 		        format(fm,128,"[GANG CHAT] (%s) %s: %s",POS_NV3,name,resto);
            case 4:
 		        format(fm,128,"[GANG CHAT] (%s) %s: %s",POS_NV4,name,resto);
            case 5:
 		        format(fm,128,"[GANG CHAT] (%s) %s: %s",POS_NV5,name,resto);
 		}
	    for(new i=0;i<MAX_PLAYERS;i++)
	        if(IsPlayerConnected(i))
		        if(GangID[playerid]==GangID[i])
		            SendClientMessage(i,azul,fm);
		return 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(gang,4,cmdtext);
	if(!strcmp("/gangs",cmdtext,true))
	{
	    new Gangs[MAX_GANGS],fmt[64];
		SendClientMessage(playerid,laranja,"|- Gangs online no momento -|");
		for(new i=0;i<MAX_PLAYERS;i++)
		    if(IsPlayerConnected(i))
		        if(Gangs[GangID[i]]!=2&&GangID[i]!=0)
		        {
		            Gangs[GangID[i]]=2;
		            format(fmt,64,"|- %s - ID: %d",DOF2_GetString(FormatGang(GangID[i]),"Nome"),GangID[i]);
		            SendClientMessage(playerid,branco,fmt);
		        }
		return 1;
	}
	return 0;
}

dcmd_gang(playerid,params[])
{
	if(!params[0]) {
	        ShowPlayerDialog(playerid,425,DIALOG_STYLE_LIST,"Comando /gang","Informações do /gang\nCriar\nConvite\nKick\nEntrar\nBanco\nSair\nInfo\nSkin\nCor\nLema\nMembros\nLevel\nAtk\nLider\nDeletar (Admin)","Ok","Sair");
			return 1;
	}
	if(!strcmp(params[0],"criar",true)) {
		if(GangID[playerid]!=0) return SendClientMessage(playerid,amarelo,"[SERVER] Você já participa de uma gang, saia dela!");
		if(GetNewGangID()>=MAX_GANGS) return SendClientMessage(playerid,amarelo,"[SERVER] O máximo de gangs no servidor foi atingido!");
		new str[128];format(str,128,"[SERVER] Você deve ter R$%d para criar uma gang!",CUSTO_GANG*-1);
		if(GetPlayerMoney(playerid)<CUSTO_GANG) return SendClientMessage(playerid,amarelo,str);
		ShowPlayerDialog(playerid,400,DIALOG_STYLE_INPUT,"===== Gang - Criar =====","Digite o nome da gang a baixo:\nSerá cobrada uma taxa de $10000 para criar sua gang!","Criar","Sair");
	}
	if(!strcmp(params[0],"kick",true)) {
		if(GangID[playerid]==0) return SendClientMessage(playerid,amarelo,"[SERVER] Você não tem gang!");
		if(GangLevel[playerid]<3) return SendClientMessage(playerid,amarelo,"[SERVER] Você deve ser comandante, sub-líder ou líder da gang para kickar outros membros!");
	    ShowPlayerDialog(playerid,401,DIALOG_STYLE_INPUT,"Gang - Kick","Digite o nome a baixo:","Kickar","Sair");
	}
	if(!strcmp(params[0],"convite",true)) {
		if(GangID[playerid]==0) return SendClientMessage(playerid,amarelo,"[SERVER] Você não tem gang!");
		if(GangLevel[playerid]<2) return SendClientMessage(playerid,amarelo,"[SERVER] Você deve ser membro, comandante, sub-líder ou líder da gang para convidar pessoas!");
		if(DOF2_GetInt(FormatGang(GangID[playerid]),"NMembros")>=GANG_MEMBERS) return SendClientMessage(playerid,amarelo,"[SERVER] O limite máximo de jogadores em uma gang foi atingido!");
		new ResultM;
		for(new f=0;f<MAX_PLAYERS;f++) {
			if(GangID[f]==GangID[playerid]&&GangLevel[f]==0) {
			    ResultM++;
			}
		}
		if(ResultM>=GANG_CONVIDADOS) return SendClientMessage(playerid,amarelo,"[SERVER] O limite máximo de convidados em uma gang foi atingido!");
		ShowPlayerDialog(playerid,422,DIALOG_STYLE_INPUT,"===== Gang - Convite =====","Digite o ID do jogador a baixo:","Convidar","Sair");
	}
	if(!strcmp(params[0],"info",true)) {
		ShowPlayerDialog(playerid,402,DIALOG_STYLE_INPUT,"===== Gang - Info =====","Digite o ID da gang:","Ver","Sair");
	}
	if(!strcmp(params[0],"skin",true)) {
	    if(GangID[playerid]==0) return SendClientMessage(playerid,amarelo,"[SERVER] Você não tem gang!");
		if(GangLevel[playerid]<4) return SendClientMessage(playerid,amarelo,"[SERVER] Você deve ser no mínimo sub-líder da gang para mudar as skins!");
		ShowPlayerDialog(playerid,403,DIALOG_STYLE_LIST,"Gang - Skin","Líder\nSub-Líder\nComandante\nMembro\nRecruta","Mudar","Sair");
	}
	if(!strcmp(params[0],"cor",true)) {
		if(GangID[playerid]==0) return SendClientMessage(playerid,amarelo,"[SERVER] Você não tem gang!");
		if(GangLevel[playerid]<5) return SendClientMessage(playerid,amarelo,"[SERVER] Você deve ser o líder da gang para mudar a cor dela!");
		ShowPlayerDialog(playerid,409,DIALOG_STYLE_INPUT,"===== Gang - Cor =====","Coloque a cor (6 letras ou números Ex.: FFFX1X (COD. RGB))","Mudar","Sair");
	}
	if(!strcmp(params[0],"lema",true)) {
		if(GangID[playerid]==0) return SendClientMessage(playerid,amarelo,"[SERVER] Você não tem gang!");
		if(GangLevel[playerid]<5) return SendClientMessage(playerid,amarelo,"[SERVER] Você deve ser o líder da gang para mudar o lema da gang!");
		ShowPlayerDialog(playerid,410,DIALOG_STYLE_INPUT,"===== Gang - Lema =====","Coloque o lema a baixo:","Mudar","Sair");
	}
	if(!strcmp(params[0],"level",true)) {
		if(GangID[playerid]==0) return SendClientMessage(playerid,amarelo,"[SERVER] Você não tem gang!");
		if(GangLevel[playerid]<3) return SendClientMessage(playerid,amarelo,"[SERVER] Você deve ser no mínimo comandante da gang para mudar os leveis!");
		ShowPlayerDialog(playerid,411,DIALOG_STYLE_INPUT,"===== Gang - Level =====","Coloque o ID do jogador a baixo:","Continuar","Sair");
	}
	if(!strcmp(params[0],"membros",true)) {
	    ShowPlayerDialog(playerid,420,DIALOG_STYLE_INPUT,"===== Gang - Membros =====","Digite o ID da gang:","Ver","Sair");
	}
	if(!strcmp(params[0],"atk",true)) {
		if(GangID[playerid]==0) return SendClientMessage(playerid,amarelo,"[SERVER] Você não tem gang!");
		if(GangLevel[playerid]<3) return SendClientMessage(playerid,amarelo,"[SERVER] Você no mínimo deve ser comandante da gang para dar /gang  atk!");
		for(new d=0;d<MAX_PLAYERS;d++) {
		    if(IsPlayerConnected(d))
		    	if(GangID[d]==GangID[playerid])
		    	return 1;
		}
		SendClientMessage(playerid,amarelo,"[SERVER] Anti-TK atualizado.");
	}
	if(!strcmp(params[0],"lider",true)) {
		if(GangID[playerid]==0) return SendClientMessage(playerid,amarelo,"[SERVER] Você não tem gang!");
		if(GangLevel[playerid]<5) return SendClientMessage(playerid,amarelo,"[SERVER] Você deve ser o líder para utilizar este comando!");
	    ShowPlayerDialog(playerid,413,DIALOG_STYLE_INPUT,"Gang - Líder","Coloque o ID para quem você quer passar o cargo de Líder de sua gang.","Passar","Sair");
	}
	if(!strcmp(params[0],"entrar",true)) {
		if(GangID[playerid]!=0) return SendClientMessage(playerid,amarelo,"[SERVER] Você já está em uma gang!");
		if(Convite[playerid]==0) return SendClientMessage(playerid,amarelo,"[SERVER] Você não foi convidado a entrar em nenhuma gang!");
		if(DOF2_GetInt(FormatGang(Convite[playerid]),"NMembros")>=GANG_MEMBERS) return SendClientMessage(playerid,amarelo,"[SERVER] Esta gang atingiu o máximo de players!");
		GangID[playerid]=Convite[playerid];
		Convite[playerid]=0;
		SetPVarInt(playerid,"GangID",GangID[playerid]);
		SetPlayerColor(playerid,HexToInt(DOF2_GetString(FormatGang(GangID[playerid]),"Cor")));
		new strmenn[128],nm1[25],strmenn2[128];
		GetPlayerName(playerid,nm1,25);
		format(strmenn,128,"[SERVER] %s (ID:%d) entrou na gang!",nm1,playerid);
		format(strmenn2,128,"[SERVER] Você entrou na gang: %s!",DOF2_GetString(FormatGang(GangID[playerid]),"Nome"));
        SendClientMessage(playerid,laranja,strmenn2);
        for(new allgp=0;allgp<MAX_PLAYERS;allgp++)
            if(IsPlayerConnected(allgp))
            	if(GangID[playerid]==GangID[allgp])
					SendClientMessage(allgp,laranja,strmenn);
	}
	if(!strcmp(params[0],"sair",true)) {
		if(GangID[playerid]==0) return SendClientMessage(playerid,amarelo,"[SERVER] Você não tem gang!");
		new strmenn[128],nm1[MAX_PLAYER_NAME];
		GetPlayerName(playerid,nm1,sizeof(nm1));
		DOF2_Unset(GangF(PlayersFile),nm1);
		new form[STRING_MEMBROS];
		if(GangLevel[playerid]==5) {
		    DOF2_Unset(GangF(GangsFile),DOF2_GetString(FormatGang(GangID[playerid]),"Nome"));
		    DOF2_SaveFile();
		    #if defined TERRITORY_WAR
			CallRemoteFunction("AtualizarGG","dds",GangID[playerid],1," ");
			#endif
	    	fremove(FormatGang(GangID[playerid]));
	    	format(strmenn,128,"[SERVER] O líder abandonou a gang e ela foi destruida!");
	    	new ggid=GangID[playerid];
	      	for(new allgp=0;allgp<MAX_PLAYERS;allgp++) {
                if(IsPlayerConnected(allgp))
		        	if(ggid==GangID[allgp]) {
						SendClientMessage(allgp,laranja,strmenn);
						GetPlayerName(allgp,nm1,sizeof(nm1));
						DOF2_Unset(GangF(PlayersFile),nm1);
						GangID[allgp]=0;
						SetPVarInt(allgp,"GangID",0);
						MudarGangPlayer(allgp,0);
	    				GangLevel[allgp]=0;
				    }
			}
			DOF2_SaveFile();
	    	return 1;
		}
		if(GangLevel[playerid]>0)
		{
			strcat(form,DOF2_GetString(FormatGang(GangID[playerid]),"Membros"));
			new pos=strfind(form,nm1);
			strdel(form,pos-1,pos+strlen(nm1));
			DOF2_SetString(FormatGang(GangID[playerid]),"Membros",form);
			DOF2_SetInt(FormatGang(GangID[playerid]),"NMembros",DOF2_GetInt(FormatGang(GangID[playerid]),"NMembros")-1);
			DOF2_SaveFile();
		}
		format(strmenn,128,"[SERVER] Você saiu da gang: %s!",DOF2_GetString(FormatGang(GangID[playerid]),"Nome"));
        SendClientMessage(playerid,laranja,strmenn);
        format(strmenn,128,"[SERVER] %s (ID:%d) saiu da gang.",nm1,playerid);
        for(new allgp=0;allgp<MAX_PLAYERS;allgp++)
            if(IsPlayerConnected(allgp))
            	if(GangID[playerid]==GangID[allgp])
					SendClientMessage(allgp,laranja,strmenn);
		MudarGangPlayer(playerid,0);
		return 1;
	}
	if(!strcmp(params[0],"banco",true)) {
		if(GangID[playerid]==0) return SendClientMessage(playerid,amarelo,"[SERVER] Você não tem gang!");
		if(DOF2_GetInt(FormatGang(GangID[playerid]),"BancoL")>GangLevel[playerid]) return SendClientMessage(playerid,amarelo,"[SERVER] Seu nível na gang não é alto o suficiente para usar o banco!");
		new IntId=GetPlayerInterior(playerid);
		if(IntId!=16&&IntId!=17&&IntId!=18&&IntId!=4&&IntId!=6&&IntId!=10) return SendClientMessage(playerid,amarelo,"[SERVER] Você não está em uma 24/7!");
		ShowPlayerDialog(playerid,414,DIALOG_STYLE_LIST,"Gang - Banco","Saldo\nSacar\nDepositar\nBloquear banco para... (Líder)","Ok","Sair");
	}
	if(!strcmp(params[0],"deletar",true)) {
	    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,amarelo,"[SERVER] Você não é ADMIN RCON!");
	    ShowPlayerDialog(playerid,424,DIALOG_STYLE_INPUT,"Gang - Deletar","Digite o ID da gang para ser deletada:\nObs: Depois de clicado o 'Deletar' não há volta.","Deletar","Sair");
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid==400)
	{
	    if(response)
	    {
	        new gangid=GetNewGangID();
	        if(!strcmp(inputtext,RESERVED_NAME)) return SendClientMessage(playerid,amarelo,"[SERVER] Nome bloqueado para uso!");
	        if(gangid>=MAX_GANGS) return SendClientMessage(playerid,amarelo,"[SERVER] O máximo de gangs no servidor foi atingido!");
			GivePlayerMoney(playerid,CUSTO_GANG);
			CriarGang(playerid,gangid,inputtext);
			ShowPlayerDialog(playerid,409,DIALOG_STYLE_INPUT,"===== Gang - Cor =====","Coloque a cor (6 letras ou números Ex.: FFFX1X (COD. RGB))","Mudar","Sair");
	    }
		return 1;
	}
	if(dialogid==401)
	{
	    if(response)
	    {
	        //kickar
	        new id=-1;
	        new form[STRING_MEMBROS];
	        new name[MAX_PLAYER_NAME],name2[MAX_PLAYER_NAME],fm[128];
	        GetPlayerName(playerid,name2,sizeof(name2));
	        if(!strcmp(name2,inputtext)) return SendClientMessage(playerid,amarelo,"[SERVER] Você não pode se kickar!");
	        //checkagem online
			for(new i=0;i<MAX_PLAYERS;i++)
			{
			    if(IsPlayerConnected(i))
			    {
				    GetPlayerName(i,name,sizeof(name));
				    if(!strcmp(name,inputtext))
				    {
				        id=i;
				        //Player ta online e com este nick
				        if(GangID[id]!=GangID[playerid]) return SendClientMessage(playerid,amarelo,"[SERVER] Este jogador não é de sua gang!");
				        if(GangLevel[id]>=GangLevel[playerid]) return SendClientMessage(playerid,amarelo,"[SERVER] Seu rank na gang deve ser maior do que de quem você quer kickar!");
				        if(GangLevel[id]>0)
						{
						    strcat(form,DOF2_GetString(FormatGang(GangID[playerid]),"Membros"));
							new pos=strfind(form,inputtext);
							strdel(form,pos-1,pos+strlen(inputtext));
							DOF2_SetString(FormatGang(GangID[playerid]),"Membros",form);
							DOF2_Unset(FormatGang(GangID[playerid]),name);
							DOF2_SetInt(FormatGang(GangID[playerid]),"NMembros",DOF2_GetInt(FormatGang(GangID[playerid]),"NMembros")-1);
							DOF2_SaveFile();
						}
				        GangLevel[id]=0;
				        format(fm,128,"[GANG CHAT] %s foi kickado da gang por %s.",name,name2);
				        for(new e=0;e<MAX_PLAYERS;e++)
				            if(IsPlayerConnected(e))
				            	if(GangID[e]==GangID[playerid]&&e!=id)
				                	SendClientMessage(e,azul,fm);
				        format(fm,128,"[SERVER] Você kickado da gang por %s.",name2);
				        SendClientMessage(id,amarelo,fm);
				        MudarGangPlayer(id,0);
				        break;
				    }
			    }
			}
			//ta off?
			if(id==-1)
			{
			    if(DOF2_IsSet(FormatGang(GangID[playerid]),inputtext))
			    {
			    	DOF2_Unset(FormatGang(GangID[playerid]),inputtext);
					strcat(form,DOF2_GetString(FormatGang(GangID[playerid]),"Membros"));
					new pos=strfind(form,inputtext);
					strdel(form,pos-1,pos+strlen(inputtext));
					DOF2_SetString(FormatGang(GangID[playerid]),"Membros",form);
					DOF2_SaveFile();
					format(fm,128,"[GANG CHAT] %s foi kickado da gang por %s.",inputtext,name2);
			        for(new e=0;e<MAX_PLAYERS;e++)
			            if(IsPlayerConnected(e))
			            	if(GangID[e]==GangID[playerid]&&e!=id)
			                	SendClientMessage(id,azul,fm);
				}
				else SendClientMessage(playerid,amarelo,"[SERVER] Player não encontrado.");
			}
	    }
		return 1;
	}
	if(dialogid==403)
	{
	    if(response)
	    {
			if(listitem==0) {if(GangLevel[playerid]<5) return SendClientMessage(playerid,amarelo,"[SERVER] Seu rank é menor do que o qual você quer editar!"); else ShowPlayerDialog(playerid,404,DIALOG_STYLE_INPUT,"Gang - Skin - Líder","Coloque o ID da skin do Líder:","Mudar","Sair");}
			else if(listitem==1) {ShowPlayerDialog(playerid,405,DIALOG_STYLE_INPUT,"Gang - Skin - Sub-Líder","Coloque o ID da skin dos Sub-Líderes:","Mudar","Sair");}
			else if(listitem==2) {ShowPlayerDialog(playerid,406,DIALOG_STYLE_INPUT,"Gang - Skin - Comandantes","Coloque o ID da skin dos Comandantes:","Mudar","Sair");}
			else if(listitem==3) {ShowPlayerDialog(playerid,407,DIALOG_STYLE_INPUT,"Gang - Skin - Membros","Coloque o ID da skin dos Membros:","Mudar","Sair");}
			else if(listitem==4) {ShowPlayerDialog(playerid,408,DIALOG_STYLE_INPUT,"Gang - Skin - Recrutas","Coloque o ID da skin dos Recrutas:","Mudar","Sair");}
		}
  		return 1;
	}
	if(dialogid>403&&dialogid<409)
	{
	    new skin = strval(inputtext);
	    if(!response) return 1;
	    if(skin < 0 || skin > 299) return SendClientMessage(playerid,amarelo,"[SERVER] Skin inválida.");
		switch(dialogid)
		{
		    case 404:
		    {
		        DOF2_SetInt(FormatGang(GangID[playerid]),"Skin5",skin);
		        DOF2_SaveFile();
				SetPlayerSkin(playerid,skin);
			}
			case 405:
			{
			    DOF2_SetInt(FormatGang(GangID[playerid]),"Skin4",skin);
			    DOF2_SaveFile();
			    for(new i=0;i<MAX_PLAYERS;i++)
			        if(IsPlayerConnected(i))
			        	if(GangID[i]==GangID[playerid]&&GangLevel[i]==4)
			            	SetPlayerSkin(i,skin);
			}
            case 406:
            {
			    DOF2_SetInt(FormatGang(GangID[playerid]),"Skin3",skin);
			    DOF2_SaveFile();
			    for(new i=0;i<MAX_PLAYERS;i++)
			        if(IsPlayerConnected(i))
			        	if(GangID[i]==GangID[playerid]&&GangLevel[i]==3)
			            	SetPlayerSkin(i,skin);
			}
            case 407:
            {
			    DOF2_SetInt(FormatGang(GangID[playerid]),"Skin2",skin);
			    DOF2_SaveFile();
			    for(new i=0;i<MAX_PLAYERS;i++)
			        if(IsPlayerConnected(i))
			        	if(GangID[i]==GangID[playerid]&&GangLevel[i]==2)
			            	SetPlayerSkin(i,skin);
			}
            case 408:
            {
			    DOF2_SetInt(FormatGang(GangID[playerid]),"Skin1",skin);
			    DOF2_SaveFile();
			    for(new i=0;i<MAX_PLAYERS;i++)
			        if(IsPlayerConnected(i))
			        	if(GangID[i]==GangID[playerid]&&GangLevel[i]==1)
			            	SetPlayerSkin(i,skin);
			}
		}
	}
	if(dialogid==409)
	{
	    if(response)
	    {
	        if(strlen(inputtext)!=6) return SendClientMessage(playerid,amarelo,"[SERVER] Cor inválida!");
			new fm2[11];
			format(fm2,11,"0x%sFF",inputtext);
			#if defined TERRITORY_WAR
			new fm3[11];
			format(fm3,11,"0x%s66",inputtext);
			CallRemoteFunction("AtualizarGG","dds",GangID[playerid],0,fm3);
			#endif
			DOF2_SetHex(FormatGang(GangID[playerid]),"Cor",HexToInt(fm2));
			DOF2_SaveFile();
			for(new i=0;i<MAX_PLAYERS;i++)
			    if(IsPlayerConnected(i))
				    if(GangID[playerid]==GangID[i])
				    {
				        SetPlayerColor(i,HexToInt(fm2));
				        SendClientMessage(i,HexToInt(fm2),"[SERVER] A cor da gang foi mudada para a cor desta mensagem.");
					}
	    }
	    return 1;
	}
	if(dialogid==410)
	{
	    if(response)
	    {
	        if(strlen(inputtext)>70) return SendClientMessage(playerid,amarelo,"[SERVER] Lema muito grande!");
			new fm2[128];format(fm2,128,"[SERVER] NOVO LEMA: %s",inputtext);
			DOF2_SetString(FormatGang(GangID[playerid]),"Lema",inputtext);
			DOF2_SaveFile();
			for(new i=0;i<MAX_PLAYERS;i++)
			    if(IsPlayerConnected(i))
			    	if(GangID[playerid]==GangID[i])
			        	SendClientMessage(i,azul,fm2);
	    }
	    return 1;
	}
	if(dialogid==411)
	{
	    if(response)
	    {
	        new id = strval(inputtext);
	        if(!IsPlayerConnected(id)) return SendClientMessage(playerid,amarelo,"[SERVER] Este ID não está online!");
	        if(GangID[id]!=GangID[playerid]) return SendClientMessage(playerid,amarelo,"[SERVER] Este player não é de sua gang!");
			new nm[MAX_PLAYER_NAME];GetPlayerName(id,nm,sizeof(nm));
	        new fm[50];format(fm,50,"Coloque o nível: (Rank atual é %i)",GangLevel[id]);
	        TempID[playerid]=id;
            ShowPlayerDialog(playerid,412,DIALOG_STYLE_INPUT,"Gang - Level",fm,"Continuar","Sair");
	    }
	    return 1;
	}
	if(dialogid==412)
	{
	    if(response)
	    {
	        new lvlnovo = strval(inputtext);
			new id = TempID[playerid];
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,amarelo,"[SERVER] Este ID não está online!");
	        if(GangID[id]!=GangID[playerid]) return SendClientMessage(playerid,amarelo,"[SERVER] Este player não é de sua gang!");
	        if(lvlnovo==GangLevel[id]) return SendClientMessage(playerid,amarelo,"[SERVER] Este player já está nesse level!");
	        if(lvlnovo>=GangLevel[playerid]) return SendClientMessage(playerid,amarelo,"[SERVER] Você só pode setar ranks menores que o seu!");
			if(lvlnovo>=GangLevel[playerid]) return SendClientMessage(playerid,amarelo,"[SERVER] Você só pode setar ranks menores que o seu!");
			if(GangLevel[id]>=GangLevel[playerid]) return SendClientMessage(playerid,amarelo,"[SERVER] Você só pode setar ranks menores que o seu!");
	        new nm[MAX_PLAYER_NAME];GetPlayerName(id,nm,sizeof(nm));
	        if(GangLevel[id]==0)
			{
				DOF2_SetInt(FormatGang(GangID[playerid]),nm,lvlnovo);
				DOF2_SetInt(GangF(PlayersFile),nm,GangID[playerid]);
				DOF2_SetInt(FormatGang(GangID[playerid]),"NMembros",DOF2_GetInt(FormatGang(GangID[playerid]),"NMembros")+1);
				new fm[STRING_MEMBROS];format(fm,sizeof(fm),"%s,%s",DOF2_GetString(FormatGang(GangID[playerid]),"Membros"),nm);
				DOF2_SetString(FormatGang(GangID[playerid]),"Membros",fm);
				DOF2_SaveFile();
				GangLevel[id]=lvlnovo;
			}
			else
			{
		        new lvl = DOF2_GetInt(FormatGang(GangID[playerid]),nm);
		        if(GangLevel[playerid]<=lvl) return SendClientMessage(playerid,amarelo,"[SERVER] Seu rank deve ser maior do que de quem você quer mudar!");
				if(lvlnovo>0)
				{
					DOF2_SetInt(FormatGang(GangID[playerid]),nm,lvlnovo);
					DOF2_SaveFile();
				}
				else
				{
					DOF2_Unset(FormatGang(GangID[playerid]),nm);
					DOF2_Unset(GangF(PlayersFile),nm);
					DOF2_SetInt(FormatGang(GangID[playerid]),"NMembros",DOF2_GetInt(FormatGang(GangID[playerid]),"NMembros")-1);
					new form[STRING_MEMBROS];
					strcat(form,DOF2_GetString(FormatGang(GangID[playerid]),"Membros"));
					new pos=strfind(form,nm);
					strdel(form,pos-1,pos+strlen(nm));
					DOF2_SetString(FormatGang(GangID[playerid]),"Membros",form);
					DOF2_SaveFile();
				}
			}
			new nm1[MAX_PLAYER_NAME];GetPlayerName(playerid,nm1,sizeof(nm1));
			new nomelvl[15], lvlvelho[15];
			switch(lvlnovo)
			{
 				case 0: nomelvl=POS_NV0;
	    		case 1: nomelvl=POS_NV1;
				case 2: nomelvl=POS_NV2;
				case 3: nomelvl=POS_NV3;
				case 4: nomelvl=POS_NV4;
			}
			switch(GangLevel[playerid])
			{
				case 3: lvlvelho=POS_NV3;
				case 4: lvlvelho=POS_NV4;
				case 5: lvlvelho=POS_NV5;
			}
			new fm[128];format(fm,128,"[SERVER] O %s %s mudou o rank de %s para %s.",lvlvelho,nm1,nm,nomelvl);
			for(new i=0;i<MAX_PLAYERS;i++)
   				if(IsPlayerConnected(i))
					if(GangID[playerid]==GangID[i])
				      	SendClientMessage(i,azul,fm);
			for(new idp=0;idp<MAX_PLAYERS;idp++)
				if(IsPlayerConnected(idp))
	   			{
					GetPlayerName(idp,nm1,sizeof(nm1));
					if(!strcmp(nm1,nm))
				 	{
				     	GangLevel[idp]=lvlnovo;
				   		break;
					}
	    		}
	    }
	    return 1;
	}
	if(dialogid==413)
	{
	    if(response)
	    {
			new id = strval(inputtext);
	        if(!IsPlayerConnected(id)) return SendClientMessage(playerid,amarelo,"[SERVER] ID não conectado!");
	        if(GangID[playerid]!=GangID[id]) return SendClientMessage(playerid,amarelo,"[SERVER] Este ID é de uma gang diferente!");
	        if(GangLevel[id]!=4) return SendClientMessage(playerid,amarelo,"[SERVER] Você só pode dar Líder a um Sub-Líder!");
	        GangLevel[playerid]=4;
	        GangLevel[id]=5;
	        new name1[MAX_PLAYER_NAME],name2[MAX_PLAYER_NAME];
	        GetPlayerName(playerid,name1,sizeof(name1));GetPlayerName(id,name2,sizeof(name2));
	        DOF2_SetString(FormatGang(GangID[playerid]),"Lider",name2);
	        DOF2_SetInt(FormatGang(GangID[playerid]),name1,4);
	        DOF2_Unset(FormatGang(GangID[playerid]),name2);
	        new form[STRING_MEMBROS];
			strcat(form,DOF2_GetString(FormatGang(GangID[playerid]),"Membros"));
			new pos=strfind(form,name2);
			strdel(form,pos-1,pos+strlen(name2));
			DOF2_SetString(FormatGang(GangID[playerid]),"Membros",form);
			format(form,sizeof(form),"%s,%s",DOF2_GetString(FormatGang(GangID[playerid]),"Membros"),name1);
			DOF2_SetString(FormatGang(GangID[playerid]),"Membros",form);
	        DOF2_SaveFile();
	        new msg[128];format(msg,128,"[SERVER] A liderança da gang foi trocada de %s(ID:%d) para %s(ID:%d)!",name1,playerid,name2,id);
            for(new i=0;i<MAX_PLAYERS;i++)
                if(IsPlayerConnected(i))
                    if(GangID[i]==GangID[playerid])
                        SendClientMessage(i,azul,msg);
	    }
	    return 1;
	}
	if(dialogid==414)
	{
	    if(response)
	    {
			//saldo, sacar, depositar, nv
			if(listitem==0)
			{
				new s[64];format(s,64,"Sua gang possui no banco:\nR$%d",BancoGG[GangID[playerid]]);
				ShowPlayerDialog(playerid,415,DIALOG_STYLE_MSGBOX,"Gang - Banco - Saldo",s,"Ok","");
			}
			else if(listitem==1) ShowPlayerDialog(playerid,416,DIALOG_STYLE_INPUT,"Gang - Banco - Sacar","Digite a quantia que deseja sacar:","Sacar","Sair");
			else if(listitem==2) ShowPlayerDialog(playerid,417,DIALOG_STYLE_INPUT,"Gang - Banco - Depositar","Digite a quantia que deseja depositar:","Depositar","Sair");
			else
			{
			    if(GangLevel[playerid]!=5) return SendClientMessage(playerid,amarelo,"[SERVER] Função apenas para líderes de gangs!");
			    new msg[128];format(msg,128,"%s\n%s\n%s\n%s\n%s\n",POS_NV1,POS_NV2,POS_NV3,POS_NV4,POS_NV5);
			    ShowPlayerDialog(playerid,418,DIALOG_STYLE_LIST,"Gang - Banco - Bloquear banco para...",msg,"Depositar","Sair");
			}
	    }
	    return 1;
	}
	if(dialogid==416)
	{
	    if(response)
	    {
			new money = strval(inputtext);
			if(money<0) return SendClientMessage(playerid,amarelo,"[SERVER] Quantia negativa!");
   			new bancogang=BancoGG[GangID[playerid]];
			if(bancogang<money) return SendClientMessage(playerid,amarelo,"[SERVER] O banco de sua gang não possui esse dinheiro!");
			GivePlayerMoney(playerid,money);
			BancoGG[GangID[playerid]]-=money;
			DOF2_SetInt(FormatGang(GangID[playerid]),"Banco",BancoGG[GangID[playerid]]);
			DOF2_SaveFile();
			new nome[MAX_PLAYER_NAME],msg[128];
			GetPlayerName(playerid,nome,sizeof(nome));
			switch(GangLevel[playerid])
			{
			    case 1: format(msg,128,"[SERVER] O %s %s sacou R$%d do banco da gang.",POS_NV1,nome,money);
			    case 2: format(msg,128,"[SERVER] O %s %s sacou R$%d do banco da gang.",POS_NV2,nome,money);
			    case 3: format(msg,128,"[SERVER] O %s %s sacou R$%d do banco da gang.",POS_NV3,nome,money);
			    case 4: format(msg,128,"[SERVER] O %s %s sacou R$%d do banco da gang.",POS_NV4,nome,money);
			    case 5: format(msg,128,"[SERVER] O %s %s sacou R$%d do banco da gang.",POS_NV5,nome,money);
			}
			for(new i=0;i<MAX_PLAYERS;i++)
			    if(IsPlayerConnected(i))
			        if(GangID[i]==GangID[playerid])
			            SendClientMessage(i,azul,msg);
	    }
	    return 1;
	}
	if(dialogid==417)
	{
	    if(response)
	    {
			new money = strval(inputtext);
			if(money<0) return SendClientMessage(playerid,amarelo,"[SERVER] Quantia negativa!");
			if(GetPlayerMoney(playerid)<money) return SendClientMessage(playerid,amarelo,"[SERVER] Você não possui esse dinheiro!");
			GivePlayerMoney(playerid,-(money));
			BancoGG[GangID[playerid]]+=money;
			DOF2_SetInt(FormatGang(GangID[playerid]),"Banco",BancoGG[GangID[playerid]]);
			DOF2_SaveFile();
			new nome[MAX_PLAYER_NAME],msg[128];
			GetPlayerName(playerid,nome,sizeof(nome));
			switch(GangLevel[playerid])
			{
			    case 1: format(msg,128,"[SERVER] O %s %s depositou R$%d no banco da gang.",POS_NV1,nome,money);
			    case 2: format(msg,128,"[SERVER] O %s %s depositou R$%d no banco da gang.",POS_NV2,nome,money);
			    case 3: format(msg,128,"[SERVER] O %s %s depositou R$%d no banco da gang.",POS_NV3,nome,money);
			    case 4: format(msg,128,"[SERVER] O %s %s depositou R$%d no banco da gang.",POS_NV4,nome,money);
			    case 5: format(msg,128,"[SERVER] O %s %s depositou R$%d no banco da gang.",POS_NV5,nome,money);
			}
			for(new i=0;i<MAX_PLAYERS;i++)
			    if(IsPlayerConnected(i))
			        if(GangID[i]==GangID[playerid])
			            SendClientMessage(i,azul,msg);
	    }
	    return 1;
	}
	if(dialogid==418)
	{
	    if(response)
	    {
	        new nvmin[20];
	        switch(listitem)
	        {
				case 0: nvmin=POS_NV1;
				case 1: nvmin=POS_NV2;
				case 2: nvmin=POS_NV3;
				case 3: nvmin=POS_NV4;
				case 4: nvmin=POS_NV5;
	        }
			DOF2_SetInt(FormatGang(GangID[playerid]),"BancoL",listitem+2);
			DOF2_SaveFile();
			new nome[MAX_PLAYER_NAME],msg[128];
			GetPlayerName(playerid,nome,sizeof(nome));
			format(msg,128,"[SERVER] O %s %s mudou o nível mínimo para usar o banco para: %s",POS_NV5,nome,nvmin);
			for(new i=0;i<MAX_PLAYERS;i++)
			    if(IsPlayerConnected(i))
			        if(GangID[i]==GangID[playerid])
			            SendClientMessage(i,azul,msg);
	    }
	    return 1;
	}
	if(dialogid==402)
	{
	    if(response)
	    {
	        new gangid=strval(inputtext);
			if(strlen(inputtext)==0)
				if(GangID[playerid]!=0)
			    	gangid = GangID[playerid];
				else return SendClientMessage(playerid,amarelo,"[SERVER] Gang não encontrada!");
			else
				if(!fexist(FormatGang(gangid))) return SendClientMessage(playerid,amarelo,"[SERVER] Gang não encontrada!");
			new fm[256],name22[MAX_PLAYER_NAME],temp[64];
			#if defined TERRITORY_WAR
			format(fm,256,"Nome: %s (ID:%d)\nLíder: %s\nTerritórios: %d\nMembros: %d\n\nLema: %s\n\nMembros online:",DOF2_GetString(FormatGang(gangid),"Nome"),gangid,DOF2_GetString(FormatGang(gangid),"Lider"),TerrisGG[gangid],DOF2_GetInt(FormatGang(gangid),"NMembros"),DOF2_GetString(FormatGang(gangid),"Lema"));
			#else
			format(fm,256,"Nome: %s (ID:%d)\nLíder: %s\nMembros: %d\n\nLema: %s\n\nMembros online:",DOF2_GetString(FormatGang(gangid),"Nome"),gangid,DOF2_GetString(FormatGang(gangid),"Lider"),DOF2_GetInt(FormatGang(gangid),"NMembros"),DOF2_GetString(FormatGang(gangid),"Lema"));
			#endif
			for(new e=5;e>-1;e--)
				for(new i=0;i<MAX_PLAYERS;i++)
				    if(IsPlayerConnected(i))
				        if(GangID[i]==gangid)
							if(GangLevel[i]==e)
							{
					            GetPlayerName(i,name22,sizeof(name22));
					            switch(GangLevel[i])
					            {
									case 0: {format(temp,64,"\n%s %s",POS_NV0,name22);}
									case 1: {format(temp,64,"\n%s %s",POS_NV1,name22);}
									case 2: {format(temp,64,"\n%s %s",POS_NV2,name22);}
									case 3: {format(temp,64,"\n%s %s",POS_NV3,name22);}
									case 4: {format(temp,64,"\n%s %s",POS_NV4,name22);}
									case 5: {format(temp,64,"\n%s %s",POS_NV5,name22);}
								}
								strcat(fm,temp);
							}
			strcat(fm,"\n\nPara saber todos os membros: /gang membros");
			ShowPlayerDialog(playerid,419,DIALOG_STYLE_MSGBOX,"Gang - Info",fm,"Ok","");
	    }
	    return 1;
	}
	if(dialogid==420)
	{
	    if(response)
	    {
   			new gangid=strval(inputtext);
			if(strlen(inputtext)==0)
				if(GangID[playerid]!=0)
			    	gangid = GangID[playerid];
				else return SendClientMessage(playerid,amarelo,"[SERVER] Gang não encontrada!");
			else
				if(!fexist(FormatGang(gangid))) return SendClientMessage(playerid,amarelo,"[SERVER] Gang não encontrada!");
  	 		new novo[40],lmembros[STRING_MEMBROS],nome[MAX_PLAYER_NAME];
			format(novo,40,"\n(%s) %s",POS_NV5,DOF2_GetString(FormatGang(gangid),"Lider"));
			strcat(lmembros,novo);
			if(strlen(DOF2_GetString(FormatGang(gangid),"Membros"))!=0)
			{
			    new membros[GANG_MEMBERS][MAX_PLAYER_NAME];
			    split(DOF2_GetString(FormatGang(gangid),"Membros"),membros,',');
				new nvl;
				for(new nv=4;nv>0;nv--)
					for(new e=0;e<GANG_MEMBERS;e++)
					    if(strlen(membros[e])!=0){
					    {
					        nvl=DOF2_GetInt(FormatGang(gangid),membros[e]);
					        if(nvl==nv)
					        {
			       				switch(nvl)
			       				{
			       				    case 1: format(novo,40,"\n(%s) %s",POS_NV1,membros[e]);
			       				    case 2: format(novo,40,"\n(%s) %s",POS_NV2,membros[e]);
			       				    case 3: format(novo,40,"\n(%s) %s",POS_NV3,membros[e]);
			       				    case 4: format(novo,40,"\n(%s) %s",POS_NV4,membros[e]);
			       				}
			 					strcat(lmembros,novo);
							}
						}
					}
			}
			for(new i=0;i<MAX_PLAYERS;i++)
			    if(IsPlayerConnected(i))
				    if(gangid==GangID[i])
				        if(GangLevel[i]==0) {
				            GetPlayerName(i,nome,sizeof(nome));
							format(novo,40,"\n(%s) %s",POS_NV0,nome);
	 						strcat(lmembros,novo);
						}
			ShowPlayerDialog(playerid,421,DIALOG_STYLE_MSGBOX,"Gang - Membros",lmembros,"Ok","");
		}
		return 1;
	}
	if(dialogid==422)
	{
	    if(response)
	    {
	        new id = strval(inputtext);
	        if(!IsPlayerConnected(id)) return SendClientMessage(playerid,amarelo,"[SERVER] Este ID não está online!");
	        if(Convite[id]==GangID[playerid]) return SendClientMessage(playerid,amarelo,"[SERVER] Este ID já está com um convite para esta gang!");
	        if(GangID[id]!=0) return SendClientMessage(playerid,amarelo,"[SERVER] Este player já está em uma gang!");
	        if(playerid==id) return SendClientMessage(playerid,amarelo,"[SERVER] Este é seu ID!");
		 	Convite[id]=GangID[playerid];
		 	new nomep[MAX_PLAYER_NAME];GetPlayerName(playerid,nomep,sizeof(nome));
		 	new nome2[MAX_PLAYER_NAME];GetPlayerName(id,nome2,sizeof(nome2));
		 	new fm[128];
		 	switch(GangLevel[playerid])
		 	{
		 	    case 2: format(fm,128,"[SERVER] (%s) %s (ID:%d) convidou %s (ID:%d) para entrar na gang.",POS_NV2,nomep,playerid,nome2,id);
		 	    case 3: format(fm,128,"[SERVER] (%s) %s (ID:%d) convidou %s (ID:%d) para entrar na gang.",POS_NV3,nomep,playerid,nome2,id);
		 	    case 4: format(fm,128,"[SERVER] (%s) %s (ID:%d) convidou %s (ID:%d) para entrar na gang.",POS_NV4,nomep,playerid,nome2,id);
		 	    case 5: format(fm,128,"[SERVER] (%s) %s (ID:%d) convidou %s (ID:%d) para entrar na gang.",POS_NV5,nomep,playerid,nome2,id);
		 	}
		 	for(new i=0;i<MAX_PLAYERS;i++)
		 	    if(IsPlayerConnected(i))
		 	        if(GangID[playerid]==GangID[i])
		 				SendClientMessage(i,verde,fm);
			format(fm,128,"[SERVER] %s (ID:%d) convidou você para entrar na gang %s (ID:%d), para aceitar: /gang entrar",nomep,playerid,DOF2_GetString(FormatGang(GangID[playerid]),"Nome"),GangID[playerid]);
			SendClientMessage(id,verde,fm);
	    }
	    return 1;
	}
	if(dialogid==424)
	{
	    if(response)
	    {
	        if(strlen(inputtext)==0) return SendClientMessage(playerid,amarelo,"[SERVER] Digite o ID!");
	        new id=strval(inputtext);
	        if(!fexist(FormatGang(id))) return SendClientMessage(playerid,amarelo,"[SERVER] Não existe gang com este ID!");
	        new strmenn[128],nm1[MAX_PLAYER_NAME];
			GetPlayerName(playerid,nm1,sizeof(nm1));
		    DOF2_Unset(GangF(GangsFile),DOF2_GetString(FormatGang(id),"Nome"));
		    DOF2_SaveFile();
      		#if defined TERRITORY_WAR
			CallRemoteFunction("AtualizarGG","dds",id,1," ");
			#endif
	    	format(strmenn,128,"[SERVER] O Admin %s deletou a gang %s.",nm1,DOF2_GetString(FormatGang(id),"Nome"));
	    	SendClientMessageToAll(vermelho,strmenn);
	    	fremove(FormatGang(id));
	      	for(new allgp=0;allgp<MAX_PLAYERS;allgp++) {
                if(IsPlayerConnected(allgp))
		        	if(id==GangID[allgp]) {
						GetPlayerName(allgp,nm1,sizeof(nm1));
						DOF2_Unset(GangF(PlayersFile),nm1);
						GangID[allgp]=0;
						SetPVarInt(allgp,"GangID",0);
						MudarGangPlayer(allgp,0);
	    				GangLevel[allgp]=0;
				    }
			}
			DOF2_SaveFile();
	    }
	    return 1;
	}
	if(dialogid==425)
	{
	    if(response)
	    {
	        switch(listitem)
	        {
	            case 0:
				{
					new tst[800];
					format(tst,800,"{FF4500}FORMA RÁPIDA: /gang [Criar/Convite/Kick/Entrar/Banco/Sair/Info/Skin/Cor/Lema/Membros/Level/Atk/Lider/Deletar]\n\n{FFFFFF}Função de cada comando:\n - Criar: Cria sua gang.\n - Convite: Convida um jogador para sua gang.\n - Kick: Kicka um player da sua gang.\n - Entrar: Aceita o convite de uma gang.\n - Banco: Banco da gang.\n - Sair: Sai de sua gang atual.\n - Info: Mostra as informações de uma gang.");
					strcat(tst,"\n - Skin: Seta as skins dos membros.\n - Cor: Seta a cor da gang e seus membros.\n - Lema: Seta o lema da gang.\n - Membros: Vê os membros de uma gang.\n - Level: Seta o level de um membro na gang.\n - Atk: Atualiza o anti-team kill da gang.\n - Lider: Muda o Líder da gang.\n - Deletar(Admin): Deleta gangs.\n\n{FFFF00}Leveis na Gang:");
					new nvs[128];format(nvs,128," 0- %s / 1- %s / 2- %s / 3- %s / 4- %s / 5- %s",POS_NV0,POS_NV1,POS_NV2,POS_NV3,POS_NV4,POS_NV5);
					strcat(tst,nvs);
					ShowPlayerDialog(playerid,423,DIALOG_STYLE_MSGBOX,"Informações do /gang",tst,"Ok","");
				}
				case 1: {dcmd_gang(playerid,"criar");}
				case 2: {dcmd_gang(playerid,"convite");}
				case 3: {dcmd_gang(playerid,"kick");}
				case 4: {dcmd_gang(playerid,"entrar");}
				case 5: {dcmd_gang(playerid,"banco");}
				case 6: {dcmd_gang(playerid,"sair");}
				case 7: {dcmd_gang(playerid,"info");}
				case 8: {dcmd_gang(playerid,"skin");}
				case 9: {dcmd_gang(playerid,"cor");}
				case 10: {dcmd_gang(playerid,"lema");}
				case 11: {dcmd_gang(playerid,"membros");}
				case 12: {dcmd_gang(playerid,"level");}
				case 13: {dcmd_gang(playerid,"atk");}
				case 14: {dcmd_gang(playerid,"lider");}
				case 15: {dcmd_gang(playerid,"deletar");}
			}
	    }
	    return 1;
	}
	return 0;
}
