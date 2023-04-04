// Filterscript de Eventos
// Criado Por Gabriel_Santos
// Creditos: Jonathan Feitosa

#include <a_samp>
#include <sscanf2>
#include <zcmd>

#define COR_VERMELHA 0xF66767AA
#define COR_BRANCO   0xFFFFFFAA
#define COR_AZUL     0x447FECAA
enum SystemEvento
{
	Float:Health,
	Float:Colete,
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	grana,
	interior,
	ang,
	Skin,
};
new Eventos[MAX_PLAYERS][SystemEvento];
enum SistemaEventos
{
	bool:Eventoiniciado,
	bool:Eventotrancado,
	bool:Eventodestrancado,
	bool:Entrar,
	bool:Eventocontagem,
	interior,
};
new Gabriel[MAX_PLAYERS][SistemaEventos];
new Float:ex,Float:ey,Float:ez;
new Float:entroux,Float:entrouy,Float:entrouz;
new entraram;
new CountDown = -1;
new Veiculos[MAX_VEHICLES];
new VeiculosCriados = 0;
forward countdown();


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Filterscript Eventos v1.0 Ligado");
	print(" Feito Por Gabriel_Santos");
	print("--------------------------------------\n");
	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, COR_AZUL,"Esse Servidor Conta com Um Sistema de Eventos Criado Por Gabriel_Santos.");
    Gabriel[playerid][Eventoiniciado] = false;
    Gabriel[playerid][Eventodestrancado] = false;
    Gabriel[playerid][Eventotrancado] = false;
    Gabriel[playerid][Entrar] = false;
	return 1;
}
forward OnPlayerCommandReceived(playerid, cmdtext[]);
public OnPlayerCommandReceived(playerid, cmdtext[])
{
    return 1;
}
forward OnPlayerCommandPerformed(playerid, cmdtext[], success);
public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
    Gabriel[playerid][Entrar] = false;
    SetPlayerVirtualWorld(playerid, 0);
	return 1;
}
//INICIO COMANDOS DO SISTEMA
new streventu[128];
new admnick[20];
new string[256];

CMD:ajudaevento(playerid, params[])
{
	SendClientMessage(playerid, COR_AZUL, "[EVENTO SYSTEM]: /criarevento,/trancarevento,/destrancarevento,/skinevento/finalizarevento");
	SendClientMessage(playerid, COR_AZUL, "[EVENTO SYSTEM]: /carroevento,/vidaevento,/armaevento,/coleteevento,/contagemevento,/congelarevento,/descongelarevento.");
	return 1;
}
CMD:criarevento(playerid, params[])
{
	new result[156];
    new string[256];
	if(sscanf(params, "s[124]", result)) return SendClientMessage(playerid, 0xFFFFFFAA, "Use: /criarevento [Tipo]");
    {
        GetPlayerName(playerid,admnick, 24);
		GetPlayerPos(playerid, ex, ey, ez);
        SalvarPlayer(playerid);
		Gabriel[playerid][interior] = GetPlayerInterior(playerid);
		for(new possiveis = 0; possiveis < MAX_PLAYERS; possiveis++) if(IsPlayerConnected(possiveis))
		{
			format(string,sizeof(string), "O Admin:[%s] ID:[%d] Criou um Evento de [%s] \n Para Participar Use: Sim Para Ficar onde Esta use: Não", admnick, playerid ,result);
			ShowPlayerDialog(possiveis, 2345, DIALOG_STYLE_MSGBOX, "Sistema de Eventos", string, "Sim", "Não");
			Gabriel[possiveis][Eventoiniciado] = true;
			Gabriel[possiveis][Eventotrancado] = false;
			Gabriel[possiveis][Eventodestrancado] = false;
			Gabriel[playerid][Entrar] = false;
		}
	}
	return 1;
}
CMD:finalizarevento(playerid, params[])
{
	GetPlayerName(playerid,admnick, 24);
	format(streventu, 128, "[SISTEMA DE EVENTO] O Administrador [%s] ID:[%d] Finalizou o Evento", admnick, playerid);
	SendClientMessageToAll(COR_AZUL, streventu);
	for(new possiveis = 0; possiveis < MAX_PLAYERS; possiveis++) if(IsPlayerConnected(possiveis))
	{
		GameTextForPlayer(possiveis,"~w~evento ~r~terminado", 2500, 1);
		Gabriel[possiveis][Eventotrancado] = false;
		Gabriel[possiveis][Eventoiniciado] = false;
		Gabriel[possiveis][Eventodestrancado] = false;
	}
	for(new possiveis = 0; possiveis < MAX_PLAYERS; possiveis++) if(Gabriel[playerid][Entrar] == true)
	{
		Gabriel[possiveis][Entrar] = false;
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, entroux, entrouy, entrouz);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, Gabriel[playerid][interior]);
	}
	for(new carros = 0; carros < MAX_VEHICLES; carros++)
	{
		if(Veiculos[carros])
		{
			DestroyVehicle(Veiculos[carros]);
			Veiculos[carros] = 0;
			VeiculosCriados = 0;
		}
	}
	entraram = 0;
	return 1;
}
CMD:sairevento(playerid, params[])
{
	SetPlayerVirtualWorld(playerid, 0);
	Gabriel[playerid][Entrar] = false;
	entraram -- ;
	SetPlayerPos(playerid, entroux, entrouy, entrouz);
	return 1;
}
CMD:desarmarevento(playerid, params[])
{
	for(new possiveis = 0; possiveis < MAX_PLAYERS; possiveis++) if(Gabriel[playerid][Entrar] == true)
	{
		ResetPlayerWeapons(possiveis);
		SetPlayerArmedWeapon(possiveis,0);
	}
	GetPlayerName(playerid,admnick, 24);
	format(streventu, 128, "[SISTEMA DE EVENTOS] O Administrador [%s] ID:[%d] desarmou todos jogadores do evento!", admnick, playerid);
	SendClientMessageToAll(COR_AZUL, streventu);
	return 1;
}
CMD:skinevento(playerid, params[])
{
	new skinide;
	if(sscanf(params, "d", skinide)) return SendClientMessage(playerid, COR_BRANCO, "Uso:/skinevento [ID da Skin]");
	for(new possiveis = 0; possiveis < MAX_PLAYERS; possiveis++) if(Gabriel[playerid][Entrar] == true)
	{
		SetPlayerSkin(possiveis, skinide);
	}
	return 1;
}
CMD:armaevento(playerid, params[])
{
	new gun;
	new ammo;
	if(sscanf(params, "dd", gun, ammo)) return SendClientMessage(playerid, COR_BRANCO, "Uso:/armaevento [ID da Arma][Munição]");
	for(new possiveis = 0; possiveis < MAX_PLAYERS; possiveis++) if(Gabriel[playerid][Entrar] == true)
	{
		GivePlayerWeapon(possiveis, gun, ammo);
	}
	GetPlayerName(playerid,admnick, 24);
	format(streventu, 128, "[SISTEMA DE EVENTO]O Administrador [%s] ID:[%d] deu arma [ID:%d] munição [%d] aos jogadores do evento!", admnick,playerid ,gun,ammo);
	SendClientMessageToAll(COR_AZUL, streventu);
	return 1;
}
CMD:contagemevento(playerid, params[])
{
	if(CountDown == -1)
	{
		CountDown = 6;
		SetTimer("countdown",1000,0);
		GetPlayerName(playerid,admnick, 24);
		format(streventu, 128, "[SISTEMA DE EVENTOS] O Administrador %s [ID:%d] iniciou a contagem do evento!", admnick, playerid);
		SendClientMessageToAll(COR_AZUL, streventu);
	}
	return 1;
}
CMD:congelarevento(playerid, params[])
{
	for(new possiveis = 0; possiveis < MAX_PLAYERS; possiveis++) if(Gabriel[playerid][Entrar] == true)
	{
		TogglePlayerControllable(possiveis, false);
	}
	GetPlayerName(playerid,admnick, 24);
	format(streventu, 128, "[SISTEMA DE EVENTOS] O Administrador %s [ID:%d] congelou os jogadores do evento!", admnick, playerid);
	SendClientMessageToAll(COR_AZUL, streventu);
	return 1;
}
CMD:descongelarevento(playerid, params[])
{
	for(new possiveis = 0; possiveis < MAX_PLAYERS; possiveis++) if(Gabriel[playerid][Entrar] == true)
	{
		TogglePlayerControllable(possiveis, true);
	}
	GetPlayerName(playerid,admnick, 24);
	format(streventu, 128, "[SISTEMA DE EVENTOS] O Administrador %s [ID:%s] descongelou os jogadores do evento!", admnick, playerid);
	SendClientMessageToAll(COR_AZUL, streventu);
	return 1;
}
CMD:coleteevento(playerid, params[])
{
	new colete;
	if(sscanf(params, "d", colete)) return SendClientMessage(playerid, COR_BRANCO, "Uso:/coleteevento[COLETE]");
	for(new possiveis = 0; possiveis < MAX_PLAYERS; possiveis++) if(Gabriel[playerid][Entrar] == true)
	{
		SetPlayerArmour(possiveis, colete);
	}
	GetPlayerName(playerid,admnick, 24);
	format(streventu, 128, "[SISTEMA DE EVENTOS] O Administrador %s [ID:%d] setou Colete [%d] para os jogadores do evento", admnick,playerid,colete);
	SendClientMessageToAll(COR_AZUL, streventu);
	return 1;
}
CMD:vidaevento(playerid, params[])
{
	new vida;
	if(sscanf(params, "d", vida)) return SendClientMessage(playerid, COR_BRANCO, "Uso:/vidaevento [VIDA]");
	for(new possiveis = 0; possiveis < MAX_PLAYERS; possiveis++) if(Gabriel[playerid][Entrar] == true)
	{
		SetPlayerHealth(possiveis,vida);
	}
	GetPlayerName(playerid,admnick, 24);
	format(streventu, 128, "[SISTEMA DE EVENTOS] O Administrador %s [ID:%d] setou Vida [%d] para os jogadores do evento", admnick,playerid,vida);
	SendClientMessageToAll(COR_AZUL, streventu);
	return 1;
}
CMD:carroevento(playerid, params[])
{
	new carro;
	if(sscanf(params, "d", carro)) return SendClientMessage(playerid, COR_BRANCO, "Uso:/carroevento [ID do Carro]");
	if(carro < 400 || carro > 611)
	{
		SendClientMessage(playerid, COR_VERMELHA, "  O ID do veiculo digitado está invalido! veiculos de 400 á 611");
		return 1;
	}
	for(new possiveis = 0; possiveis < MAX_PLAYERS; possiveis++) if(Gabriel[possiveis][Entrar] == true)
	{
		new Float:X = 0,Float:Y = 0,Float:Z = 0,Float:Angulo = 0;
		GetPlayerPos(possiveis, X,Y,Z);
		GetPlayerFacingAngle(playerid, Angulo);
		Veiculos[VeiculosCriados++] = CreateVehicle(carro, X, Y, Z, 0, random(126), random(126), 60000);
		LinkVehicleToInterior(Veiculos[VeiculosCriados-1], GetPlayerInterior(possiveis));
		SetVehicleVirtualWorld(Veiculos[VeiculosCriados-1], GetPlayerVirtualWorld(possiveis));
		PutPlayerInVehicle(possiveis, Veiculos[VeiculosCriados-1], 0);
	}
	GetPlayerName(playerid,admnick, 24);
	format(streventu, 128, "[SISTEMA DE EVENTOS] O Administrador %s [ID:%d] deu carro ID:%d aos jogadores do evento!", admnick,carro);
	SendClientMessageToAll(COR_AZUL, streventu);
	return 1;
}
public countdown()
{
	if(CountDown==6) GameTextForAll("~p~Starting...",1000,6);

	CountDown--;
	if(CountDown==0)
	{
		GameTextForAll("~g~GO~ r~!",1000,6);
		CountDown = -1;
		for(new i = 0; i < MAX_PLAYERS; i++) {
			TogglePlayerControllable(i,true);
			PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
		}
		return 0;
	}
	else
	{
		new text[7]; format(text,sizeof(text),"~w~%d",CountDown);
		for(new i = 0; i < MAX_PLAYERS; i++) {
			PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			TogglePlayerControllable(i,false);
		}
	 	GameTextForAll(text,1000,6);
	}

	SetTimer("countdown",1000,0);
	return 0;
}
stock SalvarPlayer(playerid)
{
	new Float: health, Float: armour, Float: SX, Float: SY, Float: SZ;
	GetPlayerHealth(playerid, health);
	GetPlayerArmour(playerid, armour);
	GetPlayerPos(playerid, SX, SY, SZ);
	Eventos[playerid][grana] = GetPlayerMoney(playerid);
	Eventos[playerid][Skin] = GetPlayerSkin(playerid);
	if (armour > 0) Eventos[playerid][Colete] = armour;
	Eventos[playerid][PosX] = SX;
	Eventos[playerid][PosY] = SY;
	Eventos[playerid][PosZ] = SZ;
	Eventos[playerid][interior] = GetPlayerInterior(playerid);
}
stock UsarPlayer(playerid)
{
	SetPlayerSkin(playerid,Eventos[playerid][Skin]);
    GivePlayerMoney(playerid, Eventos[playerid][grana]);
    SetPlayerArmour(playerid, Eventos[playerid][Colete]);
    SetPlayerPos(playerid, Eventos[playerid][PosX],
	AirtonData[playerid][PosY], Eventos[playerid][PosZ]);
	SetPlayerFacingAngle(playerid, Eventos[playerid][grana]);
	SetPlayerInterior(playerid, Eventos[playerid][grana]);
	SetPlayerInterior(playerid, Eventos[playerid][interior]);
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
		if(dialogid == 2345)
		{
 			if(response == 1)
			{
				SendClientMessage(playerid, COR_AZUL, "[EVENTOS]: voce foi para o evento");
				SalvarPlayer(playerid);
				Gabriel[playerid][Entrar] = true;
				entraram++;
				SetPlayerPos(playerid, ex, ey, ez);
				SetPlayerVirtualWorld(playerid, 5);
				SetPlayerInterior(playerid, Gabriel[playerid][interior]);
				return true;
    		}
    		if(response == 0)
   			{
  				SendClientMessage(playerid, COR_AZUL, "[EVENTOS]: voce nao foi para o evento");
                return true;
	   		}
		}
		return 1;
}
