
/*
	World Evolution RPG 1.0

	Versao: Alpha do Tikywa;
	Autor : Equipe WE;

	NOTAS: //
		EMULADOR DE GAMEMODE;
		EMULADOR DE GAMEMODE;
*/

#include a_samp
#include sscanf2
#include DOF2
#include zcmd

//#include "Modulos/inventario/inv_main.pwn"
#include "conce_main.pwn"
//#include "Modulos/velocimetro/velo_main.pwn" //nem ativa vai ficar dois velo no server-'

public OnFilterScriptInit() {
	//veloOnFilterScriptInit();
	conceOnFilterScriptInit();
	//invOnFilterScriptInit();
	return true;
}
public OnFilterScriptExit() {
	conceOnFilterScriptExit();
	return true;
}
public OnPlayerConnect(playerid) {
	conceOnPlayerConnect(playerid);
	//veloOnPlayerConnect(playerid);
	//invOnPlayerConnect(playerid);
	return true;
}
public OnPlayerDisconnect(playerid, reason) {
	conceOnPlayerDisconnect(playerid);
	return true;
}
/*public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	invOnDialogResponse(playerid, dialogid, listitem);
	return false;
}*/
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {
	//invOnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid);
	conOnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid);
	return false;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	//invOnPlayerKeyStateChange(playerid, newkeys);
	conceOnPlayerKeyStateChange(playerid, newkeys);
	return true;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {
	conceOnPlayerEnterVehicle(playerid, vehicleid);
	return true;
}
public OnPlayerExitVehicle(playerid, vehicleid) {
	conceOnPlayerExitVehicle(playerid, vehicleid);
	return true;
}
public OnPlayerUpdate(playerid) {
	//invOnPlayerUpdate(playerid);
	conceOnPlayerUpdate(playerid);
	return true;
}
