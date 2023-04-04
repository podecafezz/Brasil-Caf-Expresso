//============ Includes ===============//
#include a_samp
#include zcmd

//============== News =================//

new status[MAX_PLAYERS];

//============ Publics ===============//

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if(newkeys == KEY_YES && IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		Engine(playerid);
	}
	return 1;
}

public OnFilterScriptInit(){
	ManualVehicleEngineAndLights();
	printf("FS Engine carregado com sucesso!");
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate){
   if(newstate == PLAYER_STATE_DRIVER){
     SetTimerEx("Mensagem", 100, false, "i", playerid);
     }
   return 1;
}

//============ Comandos ===============//

CMD:ligarveiculo(playerid){
	new veiculo=GetPlayerVehicleID(playerid),ligado[MAX_PLAYERS];
	new lights,alarm,doors,bonnet,boot,objective;
	if(ligado[playerid]==1) return SendClientMessage(playerid,0xFF0000C8,"| ERRO | Seu Veiculo Ja Esta Ligado!");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && status[playerid]==0 && IsPlayerInAnyVehicle(playerid)){
		SetVehicleParamsEx(veiculo, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
		SendClientMessage(playerid,0x33AA33AA,"| INFO | Veículo Ligado!");
		status[playerid]=1;
		ligado[playerid]=1;
	}
	return true;
}

CMD:desligarveiculo(playerid){
	new veiculo=GetPlayerVehicleID(playerid);
	new lights,alarm,doors,bonnet,boot,objective;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && status[playerid]==1 && IsPlayerInAnyVehicle(playerid)){
		SetVehicleParamsEx(veiculo, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
		SendClientMessage(playerid,0x33AA33AA,"| INFO | Veiculo Desligado!");
		status[playerid]=0;
	}
	return true;
}
//============ Funções ===============//

stock Engine(playerid){
	new veiculo=GetPlayerVehicleID(playerid);
	new lights,alarm,doors,bonnet,boot,objective;
	if(status[playerid]==0 ){
		SetVehicleParamsEx(veiculo, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
		SendClientMessage(playerid,0x33AA33AA,"| INFO | Veiculo Ligado!");
		status[playerid]=1;
	}
	else{
		SetVehicleParamsEx(veiculo,VEHICLE_PARAMS_OFF,lights, alarm, doors, bonnet, boot, objective);
		SendClientMessage(playerid,0x33AA33AA,"| INFO | Veiculo Desligado!");
		status[playerid]=0;
	}
	return 1;
}

forward Mensagem(playerid);
public Mensagem(playerid){
    SendClientMessage(playerid,0x33AA33AA,"| INFO | Para Ligar E Desligar O Veiculo Aperte '{B6B6B6}Y' Ou /LigarVeiculo E /DesligarVeiculo!");
    return 1;
}

