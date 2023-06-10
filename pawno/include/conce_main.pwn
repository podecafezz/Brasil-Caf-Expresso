/*
	World Evolution RPG

	Versao: BETA 2;
	Autor : Diego Rodrigues;

	Modulo Concessionaria

	NOTAS: //
		Loads desativaodos para o beta 2;
		Pastas:
			concessionaria/concessionarias,
			concessionaria/playerVeiculos,
			concessionaria/concessionariaVeiculos;
*/

native IsValidVehicle(vehicleid);

#define MAX_PLAYER_VEHICLE  6
#define MAX_SERVER_CONCE    30
#define MAX_CONCE_VEICULOS  200

new PlayerText:conce_menu_comprar[MAX_PLAYERS][3];
new PlayerText:conce_menu_cancelar[MAX_PLAYERS];
new PlayerText:conce_menu_bcomprar[MAX_PLAYERS];
new PlayerText:conce_menu_comprar_text[MAX_PLAYERS];
new PlayerText:conce_menu_editar[MAX_PLAYERS];
new PlayerText:conce_menu_testar[MAX_PLAYERS];

enum {
        VEHICLE_FRONT, VEHICLE_BACK, VEHICLE_LEFT, VEHICLE_RIGHT
}
enum enum_playerVeiculo {
	veiculoVeiculo,
	
	bool:veiculoAtivo, //Veiculo comprado?
	bool:veiculoPorta, //Trancado?
	bool:veiculoMotor, //Ligado?
	bool:veiculoPortaMalas,
	veiculoGasolina,
	
	Float:veiculoX,
	Float:veiculoY,
	Float:veiculoZ,
	Float:veiculoRot,

	veiculoModelo,
	veiculoCor[2],
	veiculoComponentes[13]
}
enum enum_serverConce {
	bool:conceAtiva,
	Text3D:conceText3D,
	Float:concePosition[3],
	concePickUp
}
enum enum_conceVeiculo {
	conceVeiculoVeiculo,

	bool:conceVeiculoAtivo,     //se existe ou nao
	bool:conceVeiculoCompravel, //remove ou adiciona a possibilidade de compra 
	conceVeiculoPreco,
	conceVeiculoModel,
	conceVeiculoConcessionaria,
	
	Float:conceVeiculoPosX,
	Float:conceVeiculoPosY,
	Float:conceVeiculoPosZ,
	Float:conceVeiculoPosRot,
	
	Text3D:conceVeiculoText3D,
	conceVeiculoCor[2],
}

new playerVeiculo[MAX_PLAYERS][MAX_PLAYER_VEHICLE][enum_playerVeiculo];
new serverConce[MAX_SERVER_CONCE][enum_serverConce];
new conceVeiculo[MAX_CONCE_VEICULOS][enum_conceVeiculo];
new conceTestVeiculo[MAX_PLAYERS],  timerConceTest[MAX_PLAYERS];

new VehicleNames[][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Perennial","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
	"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};

command(ajudaconce, playerid, params []) {
	if(IsPlayerAdmin(playerid)) {
		SendClientMessage(playerid, -1, "");
		SendClientMessage(playerid, -1, "Comandos dispoveis para a adminsitracao:");
		SendClientMessage(playerid, -1, "			/aconce /adicionarveiculo /editarconceveiculo");
		SendClientMessage(playerid, -1, "");
		
	}
	SendClientMessage(playerid, -1, "");
	SendClientMessage(playerid, -1, "Comanods dispoveis para o jogador:");
	SendClientMessage(playerid, -1, " 			/null");
	SendClientMessage(playerid, -1, "");
	return true;
}
command(motor, playerid, params []) {
	new engine, lights, alarm, doors, bonnet, boot, objective;
	if(!IsPlayerInAnyVehicle(playerid)) return true;
	for(new i = 0; i < MAX_PLAYER_VEHICLE; i++) {
		if(GetPlayerVehicleID(playerid) != playerVeiculo[playerid][i][veiculoVeiculo]) continue;
		if(playerVeiculo[playerid][i][veiculoMotor] == true) {
			playerVeiculo[playerid][i][veiculoMotor] = false;
			GetVehicleParamsEx(playerVeiculo[playerid][i][veiculoVeiculo], engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(playerVeiculo[playerid][i][veiculoVeiculo], 0, lights, alarm, 1, bonnet, boot, objective);				
			return true;
		}
		else if(playerVeiculo[playerid][i][veiculoMotor] == false) {
			playerVeiculo[playerid][i][veiculoMotor] = true;
			GetVehicleParamsEx(playerVeiculo[playerid][i][veiculoVeiculo], engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(playerVeiculo[playerid][i][veiculoVeiculo], 1, lights, alarm, 1, bonnet, boot, objective);				
			return true;
		}
	}
	GetPlayerVehicleID(playerid);
	GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
	if(engine == 1) SetVehicleParamsEx(GetPlayerVehicleID(playerid), 0, lights, alarm, boot, bonnet, boot, objective);
	else if(engine == 0) SetVehicleParamsEx(GetPlayerVehicleID(playerid), 1, lights, alarm, boot, bonnet, boot, objective);
	return true;
}

command(criarv, playerid, params []) {
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	return CreateVehicle(411, x, y, z, 0.0, 1, 1, -1);
}

command(aconce, playerid, params []) { //comando para editar e criar concessionarias
	if(!IsPlayerAdmin(playerid)) return true;
	new arquivo[128];
	new subCommand[32], indexCommand, string[128];
	if(sscanf(params, "sI(-1)", subCommand, indexCommand)) {
		SendClientMessage(playerid, 0x2196F3FF, "Concessionaria, veja os comandos disponveis abaixo:");
		SendClientMessage(playerid, 0x64B5F6FF, "		criar, apagar [index], mover [index]");
		SendClientMessage(playerid, 0x9E9E9EFF, "		[exemplo] /conce criar");
		return true;
	}
	if(!strcmp(subCommand, "criar", true)) {
		for(new i = 0; i < MAX_SERVER_CONCE; i++) {
			if(serverConce[i][conceAtiva] == true) continue;
			new Float:playerX, Float:playerY, Float:playerZ;
			GetPlayerPos(playerid, playerX, playerY, playerZ);
			serverConce[i][concePosition][0] = playerX;
			serverConce[i][concePosition][1] = playerY;
			serverConce[i][concePosition][2] = playerZ;	
			serverConce[i][conceAtiva] = true;
			
			format(string, sizeof string, "[Concessionaria %d]", i);
			serverConce[i][conceText3D] = Create3DTextLabel(string, 0x008080FF, playerX, playerY, playerZ, 5.0, 0, 0);
			serverConce[i][concePickUp] = CreatePickup(1074, 0, playerX, playerY, playerZ, 0);
			format(string, sizeof string, "Concessionaria %d criada com sucesso.", i);
			SendClientMessage(playerid, 0x2196F3FF, string);

			format(arquivo, sizeof arquivo, "concessionaria/concessionarias/%d", i);			
			
			DOF2_CreateFile(arquivo);
			DOF2_SetBool(arquivo, "conceAtiva", serverConce[i][conceAtiva]);
			
			DOF2_SetFloat(arquivo, "concePosition1", serverConce[i][concePosition][0]);
			DOF2_SetFloat(arquivo, "concePosition2", serverConce[i][concePosition][1]);
			DOF2_SetFloat(arquivo, "concePosition3", serverConce[i][concePosition][2]);
			DOF2_SaveFile();
			break;
		}
	}
	else if(!strcmp(subCommand, "apagar", true)) {
		if(indexCommand == -1) return true;
		for(new i = 0; i < MAX_SERVER_CONCE; i++) {
			if(IsPlayerInRangeOfPoint(playerid, 1.0, serverConce[indexCommand][concePosition][0], serverConce[indexCommand][concePosition][1], serverConce[indexCommand][concePosition][2])) {
				Delete3DTextLabel(serverConce[indexCommand][conceText3D]);
				DestroyPickup(serverConce[indexCommand][concePickUp]);
				format(string, sizeof string, "Voce apagou a concessionaria index %d.", indexCommand);
				SendClientMessage(playerid, -1, string);
				serverConce[indexCommand][conceAtiva] = false;
				
				format(arquivo, sizeof arquivo, "concessionaria/concessionarias/%d", i);
				DOF2_RemoveFile(arquivo);
				break;
			}
		}
	}
	else if(!strcmp(subCommand, "mover", true)) {
		if(indexCommand == -1) return true;
		if(serverConce[indexCommand][conceAtiva] == false) return SendClientMessage(playerid, -1, "Nao existe nenhuma concessionaria com este index");
		new Float:playerX, Float:playerY, Float:playerZ;
		GetPlayerPos(playerid, playerX, playerY, playerZ);
		serverConce[indexCommand][concePosition][0] = playerX;
		serverConce[indexCommand][concePosition][1] = playerY;
		serverConce[indexCommand][concePosition][2] = playerZ;
		
		format(string, sizeof string, "[Concessionaria %d]", indexCommand);
		
		Delete3DTextLabel(serverConce[indexCommand][conceText3D]);
		DestroyPickup(serverConce[indexCommand][concePickUp]);
		serverConce[indexCommand][conceText3D] = Create3DTextLabel(string, 0x008080FF, playerX, playerY, playerZ, 5.0, 0, 0);
		serverConce[indexCommand][concePickUp] = CreatePickup(1074, 0, playerX, playerY, playerZ, 0);
		
		format(string, sizeof string, "Concessionaria %d movida com sucesso.", indexCommand);
		SendClientMessage(playerid, -1, string);

		format(arquivo, sizeof arquivo, "concessionaria/concessionarias/%d", indexCommand);
		
		DOF2_SetFloat(arquivo, "concePosition1", serverConce[indexCommand][concePosition][0]);
		DOF2_SetFloat(arquivo, "concePosition2", serverConce[indexCommand][concePosition][1]);
		DOF2_SetFloat(arquivo, "concePosition3", serverConce[indexCommand][concePosition][2]);
		DOF2_SaveFile();
		return true;
	}
	return true;
}
command(adicionarveiculo, playerid, params []) { //adicionar veiculo a concessionaria
	if(!IsPlayerAdmin(playerid)) return true;
	new subConce, subModel[32], subModelIndex, subCor1, subCor2, subPreco, subCompravel, string[128];
	if(sscanf(params, "I(-1)SIII(-1)I(-1)", subConce, subModel, subCor1, subCor2, subPreco, subCompravel)) {
		SendClientMessage(playerid, 0x2196F3FF, "Concessionaria, veja os comandos disponveis abaixo:");
		SendClientMessage(playerid, 0x90CAF9FF, "		adicionar, editar");
		SendClientMessage(playerid, 0x9E9E9EFF, "		[exemplo] /adicionarveiculo [concessionaria] [modelo] [cor1] [cor2] [preco]");
	}
	new engine, lights, alarm, doors, bonnet, boot, objective;
	if(subPreco == -1) return SendClientMessage(playerid, 0x9E9E9EFF, "/av adicionar [concessionaria] [modelo] [cor1] [cor2] [preco]");
	if(serverConce[subConce][conceAtiva] == false) return SendClientMessage(playerid, -1, "Esta concessionaria não existe.");
	if(IsNumeric(subModel)) subModelIndex = strval(subModel);
	else subModelIndex = GetVehicleModelFromName(subModel);
	if(subModelIndex < 400 || subModelIndex > 611) return SendClientMessage(playerid, -1, "Modelo invalido!");
	for(new i = 0; i < MAX_CONCE_VEICULOS; i++) {
		if(conceVeiculo[i][conceVeiculoAtivo] == true) continue;
		if(subCompravel == -1) conceVeiculo[i][conceVeiculoCompravel] = false;
		else conceVeiculo[i][conceVeiculoCompravel] = true;
		
		conceVeiculo[i][conceVeiculoAtivo] = true;

		conceVeiculo[i][conceVeiculoModel] = subModelIndex;
		conceVeiculo[i][conceVeiculoPreco] = subPreco;
		conceVeiculo[i][conceVeiculoConcessionaria] = subConce;
		conceVeiculo[i][conceVeiculoPosX] = serverConce[subConce][concePosition][0];
		conceVeiculo[i][conceVeiculoPosY] = serverConce[subConce][concePosition][1];
		conceVeiculo[i][conceVeiculoPosZ] = serverConce[subConce][concePosition][2];
		conceVeiculo[i][conceVeiculoPosRot] = 0.0;
		
		conceVeiculo[i][conceVeiculoCor][0] = subCor1;
		conceVeiculo[i][conceVeiculoCor][1] = subCor2;
		
		conceVeiculo[i][conceVeiculoVeiculo] = CreateVehicle(subModelIndex, serverConce[subConce][concePosition][0], serverConce[subConce][concePosition][1], serverConce[subConce][concePosition][2], 0.0, subCor1, subCor2, -1);

		format(string, sizeof string, "[Concessionaria %d]\nPreco:%d\nVeiculo:%s %d", subConce, subPreco, VehicleNames[subModelIndex-400], conceVeiculo[i][conceVeiculoVeiculo]);
		conceVeiculo[i][conceVeiculoText3D] = Create3DTextLabel(string, -1, 0, 0, 0, 5.0, 0);
		Attach3DTextLabelToVehicle(conceVeiculo[i][conceVeiculoText3D], conceVeiculo[i][conceVeiculoVeiculo], 0, 0, 0);

		GetVehicleParamsEx(conceVeiculo[i][conceVeiculoVeiculo], engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(conceVeiculo[i][conceVeiculoVeiculo], 0, lights, alarm, doors, bonnet, boot, objective);
		
		new arquivo[128];
		format(arquivo, sizeof arquivo, "concessionaria/concessionariaVeiculos/%d", i);
		
		DOF2_CreateFile(arquivo);
		DOF2_SetBool(arquivo, "conceVeiculoAtivo", conceVeiculo[i][conceVeiculoAtivo]);
		DOF2_SetBool(arquivo, "conceVeiculoCompravel", conceVeiculo[i][conceVeiculoCompravel]);
		
		DOF2_SetInt(arquivo, "conceVeiculoPreco", conceVeiculo[i][conceVeiculoPreco]);
		DOF2_SetInt(arquivo, "conceVeiculoModel", conceVeiculo[i][conceVeiculoModel]);
		DOF2_SetInt(arquivo, "conceVeiculoConcessionaria", conceVeiculo[i][conceVeiculoConcessionaria]);
		
		DOF2_SetFloat(arquivo, "conceVeiculoPosX", conceVeiculo[i][conceVeiculoPosX]);
		DOF2_SetFloat(arquivo, "conceVeiculoPosY", conceVeiculo[i][conceVeiculoPosY]);
		DOF2_SetFloat(arquivo, "conceVeiculoPosZ", conceVeiculo[i][conceVeiculoPosZ]);
		DOF2_SetFloat(arquivo, "conceVeiculoPosRot", conceVeiculo[i][conceVeiculoPosRot]);
	
		DOF2_SetInt(arquivo, "conceVeiculoCor1", conceVeiculo[i][conceVeiculoCor][0]);
		DOF2_SetInt(arquivo, "conceVeiculoCor2", conceVeiculo[i][conceVeiculoCor][1]);
		DOF2_SaveFile();
		break;
	}
	return true;	
}
command(editarconceveiculo, playerid, params []) { //usado para editar veiculo da concessionaria
	new arquivo[128];
	if(GetPVarInt(playerid, "conce_admin_vehicle_edit") == 0) return true;
	new vehicleid = GetPVarInt(playerid, "conce_admin_vehicle_edit_index");
	new subCommand[32], indexCommand[2], string[128];
	if(sscanf(params, "s[32]I(-1)I(-1)", subCommand, indexCommand[0], indexCommand[1])) {
		SendClientMessage(playerid, 0x424242FF, "Para fazer uma alteracao nesse veiculo use os comandos abaixo:");
		SendClientMessage(playerid, -1, " {BDBDBD}subcomandos:{FFFFFF} {9E9E9E}posicao, cor, preco, conce; {BDBDBD}(veja mais informacoes abaixo).");
		SendClientMessage(playerid, -1, "		{9E9E9E}/{FFFFFF}editarconceveiculo {9E9E9E}posicao{FFFFFF} (salva a posicao onde o veiculo se encontra)");
		SendClientMessage(playerid, -1, "		{9E9E9E}/{FFFFFF}editarconceveiculo {9E9E9E}cor{FFFFFF} {BDBDBD}[cor1] [cor2]{FFFFFF} (edita as cores do veiculo)");
		SendClientMessage(playerid, -1, "		{9E9E9E}/{FFFFFF}editarconceveiculo {9E9E9E}preco{FFFFFF} {BDBDBD}[preco]{FFFFFF} (edita o preco do veiculo)");
		SendClientMessage(playerid, -1, "		{9E9E9E}/{FFFFFF}editarconceveiculo {9E9E9E}conce{FFFFFF} {BDBDBD}[conce]{FFFFFF} (edita a concessionaria do veiculo)");
		return true;
	}
	if(!strcmp(subCommand, "posicao", true)) {
		new Float:vehicleX, Float:vehicleY, Float:vehicleZ, Float:vehicleRot;
		GetVehiclePos(vehicleid, vehicleX, vehicleY, vehicleZ);
		GetVehicleZAngle(vehicleid, vehicleRot);
		for(new i = 0; i < MAX_CONCE_VEICULOS; i++) {
			if(conceVeiculo[i][conceVeiculoVeiculo] != vehicleid) continue;
			conceVeiculo[i][conceVeiculoPosX] = vehicleX;
			conceVeiculo[i][conceVeiculoPosY] = vehicleY;
			conceVeiculo[i][conceVeiculoPosZ] = vehicleZ;
			conceVeiculo[i][conceVeiculoPosRot] = vehicleRot;
			SendClientMessage(playerid, -1, "A posicao foi alterada com sucesso.");
			
			format(arquivo, sizeof arquivo, "concessionaria/concessionariaVeiculos/%d", i);
			
			DOF2_SetFloat(arquivo, "conceVeiculoPosX", conceVeiculo[i][conceVeiculoPosX]);
			DOF2_SetFloat(arquivo, "conceVeiculoPosY", conceVeiculo[i][conceVeiculoPosY]);
			DOF2_SetFloat(arquivo, "conceVeiculoPosZ", conceVeiculo[i][conceVeiculoPosZ]);
			DOF2_SetFloat(arquivo, "conceVeiculoPosRot", conceVeiculo[i][conceVeiculoPosRot]);
			DOF2_SaveFile();
			break;
		}
		return true;
	}
	else if(!strcmp(subCommand, "cor", true)) {
		if(indexCommand[0] == -1 || indexCommand[1] == -1) return true;
		for(new i = 0; i < MAX_CONCE_VEICULOS; i++) {
			if(conceVeiculo[i][conceVeiculoVeiculo] != vehicleid) continue;
			conceVeiculo[i][conceVeiculoCor][0] = indexCommand[0];
			conceVeiculo[i][conceVeiculoCor][1] = indexCommand[1];
			
			format(arquivo, sizeof arquivo, "concessionaria/concessionariaVeiculos/%d", i);
			
			DOF2_SetInt(arquivo, "conceVeiculoCor1", conceVeiculo[i][conceVeiculoCor][0]);
			DOF2_SetInt(arquivo, "conceVeiculoCor2", conceVeiculo[i][conceVeiculoCor][1]);
			DOF2_SaveFile();
			break;
		}
		ChangeVehicleColor(vehicleid, indexCommand[0], indexCommand[1]);
		SendClientMessage(playerid, -1, "As cores foram alteradas com sucesso.");
		return true;
	}
	else if(!strcmp(subCommand, "preco", true)) {
		if(indexCommand[0] == -1) return true;
		for(new i = 0; i < MAX_CONCE_VEICULOS; i++) {
			if(conceVeiculo[i][conceVeiculoVeiculo] != vehicleid) continue;
			conceVeiculo[i][conceVeiculoPreco] = indexCommand[0];
			Delete3DTextLabel(conceVeiculo[i][conceVeiculoText3D]);
			format(string, sizeof string, "[Concessionaria %d]\nPreco:%d\nVeiculo:%s %d", conceVeiculo[i][conceVeiculoConcessionaria], conceVeiculo[i][conceVeiculoPreco], VehicleNames[conceVeiculo[i][conceVeiculoModel]-400], conceVeiculo[i][conceVeiculoVeiculo]);
			conceVeiculo[i][conceVeiculoText3D] = Create3DTextLabel(string, -1, 0, 0, 0, 5.0, 0);
			Attach3DTextLabelToVehicle(conceVeiculo[i][conceVeiculoText3D], conceVeiculo[i][conceVeiculoVeiculo], 0, 0, 0);
			SendClientMessage(playerid, -1, "O preco foi alterado com sucesso.");
			
			format(arquivo, sizeof arquivo, "concessionaria/concessionariaVeiculos/%d", i);
			DOF2_SetInt(arquivo, "conceVeiculoPreco", conceVeiculo[i][conceVeiculoPreco]);
			DOF2_SaveFile();
			break;
		}
		return true;
	}
	else if(!strcmp(subCommand, "conce", true)) {
		if(indexCommand[0] == -1) return true;
		for(new i = 0; i < MAX_CONCE_VEICULOS; i++) {
			if(conceVeiculo[i][conceVeiculoVeiculo] != vehicleid) continue;
			conceVeiculo[i][conceVeiculoConcessionaria] = indexCommand[0];
			Delete3DTextLabel(conceVeiculo[i][conceVeiculoText3D]);
			format(string, sizeof string, "[Concessionaria %d]\nPreco:%d\nVeiculo:%s %d", conceVeiculo[i][conceVeiculoConcessionaria], conceVeiculo[i][conceVeiculoPreco], VehicleNames[conceVeiculo[i][conceVeiculoModel]-400], conceVeiculo[i][conceVeiculoVeiculo]);
			conceVeiculo[i][conceVeiculoText3D] = Create3DTextLabel(string, -1, 0, 0, 0, 5.0, 0);
			Attach3DTextLabelToVehicle(conceVeiculo[i][conceVeiculoText3D], conceVeiculo[i][conceVeiculoVeiculo], 0, 0, 0);
			SendClientMessage(playerid, -1, "A concessionaria foi alterada com sucesso.");

			format(arquivo, sizeof arquivo, "concessionaria/concessionariaVeiculos/%d", i);
			DOF2_SetInt(arquivo, "conceVeiculoPreco", conceVeiculo[i][conceVeiculoPreco]);
			DOF2_SaveFile();
			break;
		}
		return true;
	}
	return true;
}
command(dinheiro, playerid, params []) { //??
	GivePlayerMoney(playerid, 10000000);
	return true;
}

conceOnFilterScriptInit() {
	//LoadConce();
	//LoadConceVehicles();
	return true;
}
conceOnFilterScriptExit() {
	DOF2_Exit();
	return true;
}
conceOnPlayerUpdate(playerid) {
	if(IsPlayerInAnyVehicle(playerid)) {
		if(GetPVarInt(playerid, "conce_menu_ativa") == 1) {
			SetPVarInt(playerid, "conce_menu_ativa", 0);
			PlayerTextDrawShow(playerid, conce_menu_bcomprar[playerid]);
			PlayerTextDrawShow(playerid, conce_menu_cancelar[playerid]);
			PlayerTextDrawShow(playerid, conce_menu_comprar[playerid][0]);
			PlayerTextDrawShow(playerid, conce_menu_comprar[playerid][1]);
			PlayerTextDrawShow(playerid, conce_menu_comprar[playerid][2]);
			PlayerTextDrawShow(playerid, conce_menu_testar[playerid]);
			if(IsPlayerAdmin(playerid)) PlayerTextDrawShow(playerid, conce_menu_editar[playerid]);
			PlayerTextDrawShow(playerid, conce_menu_comprar_text[playerid]);
			SelectTextDraw(playerid, 0x00FF00FF);
			return true;
		}
		return true;
	}
	return true;
}
conceOnPlayerConnect(playerid) {
	LoadPlayerVehicles(playerid);
	
	conce_menu_comprar[playerid][0] = CreatePlayerTextDraw(playerid, 222.532913, 168.416687, "box");
	PlayerTextDrawLetterSize(playerid, conce_menu_comprar[playerid][0], 0.000000, 10.046852);
	PlayerTextDrawTextSize(playerid, conce_menu_comprar[playerid][0], 410.907745, 0.000000);
	PlayerTextDrawAlignment(playerid, conce_menu_comprar[playerid][0], 1);
	PlayerTextDrawColor(playerid, conce_menu_comprar[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, conce_menu_comprar[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, conce_menu_comprar[playerid][0], -2139062017);
	PlayerTextDrawSetShadow(playerid, conce_menu_comprar[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, conce_menu_comprar[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, conce_menu_comprar[playerid][0], 255);
	PlayerTextDrawFont(playerid, conce_menu_comprar[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, conce_menu_comprar[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, conce_menu_comprar[playerid][0], 0);

	conce_menu_comprar[playerid][1] = CreatePlayerTextDraw(playerid, 222.532821, 168.416671, "Veiculo");
	PlayerTextDrawLetterSize(playerid, conce_menu_comprar[playerid][1], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, conce_menu_comprar[playerid][1], 410.724609, 0.000000);
	PlayerTextDrawAlignment(playerid, conce_menu_comprar[playerid][1], 1);
	PlayerTextDrawColor(playerid, conce_menu_comprar[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, conce_menu_comprar[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, conce_menu_comprar[playerid][1], 1111638783);
	PlayerTextDrawSetShadow(playerid, conce_menu_comprar[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, conce_menu_comprar[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, conce_menu_comprar[playerid][1], 255);
	PlayerTextDrawFont(playerid, conce_menu_comprar[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, conce_menu_comprar[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, conce_menu_comprar[playerid][1], 0);

	conce_menu_cancelar[playerid] = CreatePlayerTextDraw(playerid, 369.180328, 245.416671, "Cancelar");
	PlayerTextDrawLetterSize(playerid, conce_menu_cancelar[playerid], 0.296456, 1.296663);
	PlayerTextDrawTextSize(playerid, conce_menu_cancelar[playerid], 409.487640, 10.000000);
	PlayerTextDrawAlignment(playerid, conce_menu_cancelar[playerid], 1);
	PlayerTextDrawColor(playerid, conce_menu_cancelar[playerid], -1);
	PlayerTextDrawUseBox(playerid, conce_menu_cancelar[playerid], 1);
	PlayerTextDrawBoxColor(playerid, conce_menu_cancelar[playerid], 1111638783);
	PlayerTextDrawSetShadow(playerid, conce_menu_cancelar[playerid], 0);
	PlayerTextDrawSetOutline(playerid, conce_menu_cancelar[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, conce_menu_cancelar[playerid], 255);
	PlayerTextDrawFont(playerid, conce_menu_cancelar[playerid], 1);
	PlayerTextDrawSetProportional(playerid, conce_menu_cancelar[playerid], 1);
	PlayerTextDrawSetShadow(playerid, conce_menu_cancelar[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, conce_menu_cancelar[playerid], true);

	conce_menu_bcomprar[playerid] = CreatePlayerTextDraw(playerid, 369.180328, 226.750030, "Comprar");
	PlayerTextDrawLetterSize(playerid, conce_menu_bcomprar[playerid], 0.296456, 1.296663);
	PlayerTextDrawTextSize(playerid, conce_menu_bcomprar[playerid], 409.487640, 10.000000);
	PlayerTextDrawAlignment(playerid, conce_menu_bcomprar[playerid], 1);
	PlayerTextDrawColor(playerid, conce_menu_bcomprar[playerid], -1);
	PlayerTextDrawUseBox(playerid, conce_menu_bcomprar[playerid], 1);
	PlayerTextDrawBoxColor(playerid, conce_menu_bcomprar[playerid], -1633771777);
	PlayerTextDrawSetShadow(playerid, conce_menu_bcomprar[playerid], 0);
	PlayerTextDrawSetOutline(playerid, conce_menu_bcomprar[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, conce_menu_bcomprar[playerid], 255);
	PlayerTextDrawFont(playerid, conce_menu_bcomprar[playerid], 1);
	PlayerTextDrawSetProportional(playerid, conce_menu_bcomprar[playerid], 1);
	PlayerTextDrawSetShadow(playerid, conce_menu_bcomprar[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, conce_menu_bcomprar[playerid], true);

	conce_menu_testar[playerid] = CreatePlayerTextDraw(playerid, 369.180297, 208.083419, "Testar");
	PlayerTextDrawLetterSize(playerid, conce_menu_testar[playerid], 0.296456, 1.296663);
	PlayerTextDrawTextSize(playerid, conce_menu_testar[playerid], 409.487609, 10.000000);
	PlayerTextDrawAlignment(playerid, conce_menu_testar[playerid], 1);
	PlayerTextDrawColor(playerid, conce_menu_testar[playerid], -1);
	PlayerTextDrawUseBox(playerid, conce_menu_testar[playerid], 1);
	PlayerTextDrawBoxColor(playerid, conce_menu_testar[playerid], -1633771777);
	PlayerTextDrawSetShadow(playerid, conce_menu_testar[playerid], 0);
	PlayerTextDrawSetOutline(playerid, conce_menu_testar[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, conce_menu_testar[playerid], 255);
	PlayerTextDrawFont(playerid, conce_menu_testar[playerid], 1);
	PlayerTextDrawSetProportional(playerid, conce_menu_testar[playerid], 1);
	PlayerTextDrawSetShadow(playerid, conce_menu_testar[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, conce_menu_testar[playerid], true);

	conce_menu_comprar[playerid][2] = CreatePlayerTextDraw(playerid, 213.462631, 172.500015, "");
	PlayerTextDrawLetterSize(playerid, conce_menu_comprar[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, conce_menu_comprar[playerid][2], 106.398239, 104.583351);
	PlayerTextDrawAlignment(playerid, conce_menu_comprar[playerid][2], 1);
	PlayerTextDrawColor(playerid, conce_menu_comprar[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, conce_menu_comprar[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, conce_menu_comprar[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, conce_menu_comprar[playerid][2], -196921856);
	PlayerTextDrawFont(playerid, conce_menu_comprar[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, conce_menu_comprar[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, conce_menu_comprar[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, conce_menu_comprar[playerid][2], 562);
	PlayerTextDrawSetPreviewRot(playerid, conce_menu_comprar[playerid][2], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, conce_menu_comprar[playerid][2], 1, 1);

	conce_menu_comprar_text[playerid] = CreatePlayerTextDraw(playerid, 298.901733, 211.000015, "Modelo: Elegy~n~Preco: 10000000");
	PlayerTextDrawLetterSize(playerid, conce_menu_comprar_text[playerid], 0.197595, 1.203330);
	PlayerTextDrawAlignment(playerid, conce_menu_comprar_text[playerid], 1);
	PlayerTextDrawColor(playerid, conce_menu_comprar_text[playerid], -1);
	PlayerTextDrawSetShadow(playerid, conce_menu_comprar_text[playerid], 0);
	PlayerTextDrawSetOutline(playerid, conce_menu_comprar_text[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, conce_menu_comprar_text[playerid], 255);
	PlayerTextDrawFont(playerid, conce_menu_comprar_text[playerid], 1);
	PlayerTextDrawSetProportional(playerid, conce_menu_comprar_text[playerid], 1);
	PlayerTextDrawSetShadow(playerid, conce_menu_comprar_text[playerid], 0);

	conce_menu_editar[playerid] = CreatePlayerTextDraw(playerid, 369.180267, 189.416839, "Editar");
	PlayerTextDrawLetterSize(playerid, conce_menu_editar[playerid], 0.296456, 1.296663);
	PlayerTextDrawTextSize(playerid, conce_menu_editar[playerid], 409.487426, 10.000000);
	PlayerTextDrawAlignment(playerid, conce_menu_editar[playerid], 1);
	PlayerTextDrawColor(playerid, conce_menu_editar[playerid], -1);
	PlayerTextDrawUseBox(playerid, conce_menu_editar[playerid], 1);
	PlayerTextDrawBoxColor(playerid, conce_menu_editar[playerid], 563540991);
	PlayerTextDrawSetShadow(playerid, conce_menu_editar[playerid], 0);
	PlayerTextDrawSetOutline(playerid, conce_menu_editar[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, conce_menu_editar[playerid], 255);
	PlayerTextDrawFont(playerid, conce_menu_editar[playerid], 1);
	PlayerTextDrawSetProportional(playerid, conce_menu_editar[playerid], 1);
	PlayerTextDrawSetShadow(playerid, conce_menu_editar[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, conce_menu_editar[playerid], true);
	return true;
}
conceOnPlayerDisconnect(playerid) {
	for(new i = 0;i < MAX_PLAYER_VEHICLE; i++) {
		DestroyVehicle(playerVeiculo[playerid][i][veiculoVeiculo]);
	}
	return true;
}
conceOnPlayerEnterVehicle(playerid, vehicleid) {
	new string[128];
	for(new player = 0; player < MAX_PLAYERS; player++) {
		for(new i = 0; i < MAX_PLAYER_VEHICLE; i++) {
			if(playerVeiculo[player][i][veiculoVeiculo] != vehicleid) continue;
			format(string, sizeof string, "Este veiculo pertence a %s", GetName(player));
			SendClientMessage(playerid, -1, string);
			break;
		}
	}
	for(new i = 0; i < MAX_VEHICLES; i++) {
		if(vehicleid == conceVeiculo[i][conceVeiculoVeiculo]) {
			SetPVarInt(playerid, "conce_menu_ativa", 1);
			format(string, sizeof string, "Modelo: %s~n~Preco: R$%d", VehicleNames[conceVeiculo[i][conceVeiculoModel]-400], conceVeiculo[i][conceVeiculoPreco]);
			PlayerTextDrawSetPreviewModel(playerid, conce_menu_comprar[playerid][2], conceVeiculo[i][conceVeiculoModel]);
			PlayerTextDrawSetString(playerid, conce_menu_comprar_text[playerid], string);
			break;
		}
	}
    return true;
}
conceOnPlayerExitVehicle(playerid, vehicleid) {
	if(vehicleid == GetPVarInt(playerid, "conce_admin_vehicle_edit_index")) {
		new string[128];
		if(GetPVarInt(playerid, "conce_admin_vehicle_edit") == 0) return true;
		SetPVarInt(playerid, "conce_admin_vehicle_edit_index", 0);
		SetPVarInt(playerid, "conce_admin_vehicle_edit", 0);

		for(new i = 0; i < MAX_CONCE_VEICULOS; i++) {
			if(conceVeiculo[i][conceVeiculoVeiculo] != vehicleid) continue; 
			DestroyVehicle(conceVeiculo[i][conceVeiculoVeiculo]);

			conceVeiculo[i][conceVeiculoVeiculo] =  CreateVehicle(conceVeiculo[i][conceVeiculoModel], conceVeiculo[i][conceVeiculoPosX], conceVeiculo[i][conceVeiculoPosY], conceVeiculo[i][conceVeiculoPosZ], conceVeiculo[i][conceVeiculoPosRot], conceVeiculo[i][conceVeiculoCor][0], conceVeiculo[i][conceVeiculoCor][1], -1);

			Delete3DTextLabel(conceVeiculo[i][conceVeiculoText3D]);
			format(string, sizeof string, "[Concessionaria %d]\nPreco:%d\nVeiculo:%s %d", conceVeiculo[i][conceVeiculoConcessionaria], conceVeiculo[i][conceVeiculoPreco], VehicleNames[conceVeiculo[i][conceVeiculoModel]-400], conceVeiculo[i][conceVeiculoVeiculo]);
			conceVeiculo[i][conceVeiculoText3D] = Create3DTextLabel(string, -1, 0, 0, 0, 5.0, 0);
			Attach3DTextLabelToVehicle(conceVeiculo[i][conceVeiculoText3D], conceVeiculo[i][conceVeiculoVeiculo], 0, 0, 0);		
			
			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(GetPlayerVehicleID(playerid), 0, lights, alarm, 0, bonnet, boot, objective);
		}
		return true;
	}
    return 1;
}
conOnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {
	new arquivo[128];
	if(playertextid == conce_menu_cancelar[playerid]) {
		SendClientMessage(playerid, -1, "TextDrawCancel selecionada;");
		PlayerTextDrawHide(playerid, conce_menu_bcomprar[playerid]);
		PlayerTextDrawHide(playerid, conce_menu_cancelar[playerid]);
		PlayerTextDrawHide(playerid, conce_menu_comprar[playerid][0]);
		PlayerTextDrawHide(playerid, conce_menu_comprar[playerid][1]);
		PlayerTextDrawHide(playerid, conce_menu_comprar[playerid][2]);
		PlayerTextDrawHide(playerid, conce_menu_testar[playerid]);
		PlayerTextDrawHide(playerid, conce_menu_editar[playerid]);
		PlayerTextDrawHide(playerid, conce_menu_comprar_text[playerid]);
		CancelSelectTextDraw(playerid);
		RemovePlayerFromVehicle(playerid);
		return true;			
	}
	else if(playertextid == conce_menu_bcomprar[playerid]) {
		new playerMoney = GetPlayerMoney(playerid);
		new vehicleid = GetPlayerVehicleID(playerid);
		for(new i = 0; i < MAX_CONCE_VEICULOS; i++) {
			if(vehicleid == conceVeiculo[i][conceVeiculoVeiculo]) {
				if(conceVeiculo[i][conceVeiculoPreco] > playerMoney) return SendClientMessage(playerid, -1, "Voce nao tem dinheiro suficiente");
				if(conceVeiculo[i][conceVeiculoCompravel] == true) return SendClientMessage(playerid, -1, "Este veiculo nao pode ser comprado, pois foi desativado");
				for(new a; a < MAX_PLAYER_VEHICLE; a++) {
					if(playerVeiculo[playerid][a][veiculoAtivo] == true) continue;
					GivePlayerMoney(playerid, -conceVeiculo[i][conceVeiculoPreco]);

					new conceid = conceVeiculo[i][conceVeiculoConcessionaria];
					
					playerVeiculo[playerid][a][veiculoAtivo] = true;
					playerVeiculo[playerid][a][veiculoPorta] = false;
					playerVeiculo[playerid][a][veiculoMotor] = false;
					playerVeiculo[playerid][i][veiculoPortaMalas] = false;
					
					playerVeiculo[playerid][a][veiculoGasolina] = 100;
					
					playerVeiculo[playerid][a][veiculoX] = serverConce[conceid][concePosition][0];
					playerVeiculo[playerid][a][veiculoY] = serverConce[conceid][concePosition][1];
					playerVeiculo[playerid][a][veiculoZ] = serverConce[conceid][concePosition][2];
					playerVeiculo[playerid][a][veiculoRot] = 0.0;
					
					playerVeiculo[playerid][a][veiculoCor][0] = 1;
					playerVeiculo[playerid][a][veiculoCor][1] = 1;
					playerVeiculo[playerid][a][veiculoModelo] = conceVeiculo[i][conceVeiculoModel];
					
					playerVeiculo[playerid][a][veiculoVeiculo] = CreateVehicle(playerVeiculo[playerid][a][veiculoModelo], playerVeiculo[playerid][a][veiculoX], playerVeiculo[playerid][a][veiculoY], playerVeiculo[playerid][a][veiculoZ], playerVeiculo[playerid][a][veiculoRot], 1, 1, -1);
					new engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(playerVeiculo[playerid][i][veiculoVeiculo], engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(playerVeiculo[playerid][i][veiculoVeiculo], 0, lights, alarm, 1, bonnet, boot, objective);

					format(arquivo, sizeof arquivo, "concessionaria/playerVeiculos/%s_%d", GetName(playerid), i);
					DOF2_CreateFile(arquivo);
					DOF2_SetBool(arquivo, "veiculoAtivo", playerVeiculo[playerid][i][veiculoAtivo]);
					DOF2_SetBool(arquivo, "veiculoPorta", playerVeiculo[playerid][i][veiculoPorta]);
					DOF2_SetBool(arquivo, "veiculoMotor", playerVeiculo[playerid][i][veiculoMotor]);
					DOF2_SetBool(arquivo, "veiculoPortaMalas", playerVeiculo[playerid][i][veiculoPortaMalas]);
					
					DOF2_SetInt(arquivo, "veiculoGasolina", playerVeiculo[playerid][i][veiculoGasolina]);
					
					DOF2_SetFloat(arquivo, "veiculoX", playerVeiculo[playerid][i][veiculoX]);
					DOF2_SetFloat(arquivo, "veiculoY", playerVeiculo[playerid][i][veiculoY]);
					DOF2_SetFloat(arquivo, "veiculoZ", playerVeiculo[playerid][i][veiculoZ]);
					DOF2_SetFloat(arquivo, "veiculoRot", playerVeiculo[playerid][i][veiculoRot]);
				
					DOF2_SetInt(arquivo, "veiculoCor_0", playerVeiculo[playerid][i][veiculoCor][0]);
					DOF2_SetInt(arquivo, "veiculoCor_0", playerVeiculo[playerid][i][veiculoCor][1]);
					DOF2_SetInt(arquivo, "veiculoModelo", playerVeiculo[playerid][i][veiculoModelo]);
					DOF2_SaveFile();
					
					break;
				}
			}
		}
		return true;
	}
	else if(playertextid == conce_menu_testar[playerid]) {
		new vehicleid = GetPlayerVehicleID(playerid), vehiclemodel = GetVehicleModel(vehicleid);
		SetPVarInt(playerid, "conceTestDriveIndex", vehicleid);
		conceTestVeiculo[playerid] = CreateVehicle(vehiclemodel, 1403.8186, -2490.6865, 13.3337, 272.7549, 1, 1, -1);
		PutPlayerInVehicle(playerid, conceTestVeiculo[playerid], 0);
		SetPVarInt(playerid, "conce_timer", 0);
		timerConceTest[playerid] = SetTimerEx("concessionariaTestDrive", 1000, true, "i", playerid);

		PlayerTextDrawHide(playerid, conce_menu_bcomprar[playerid]);
		PlayerTextDrawHide(playerid, conce_menu_cancelar[playerid]);
		PlayerTextDrawHide(playerid, conce_menu_comprar[playerid][0]);
		PlayerTextDrawHide(playerid, conce_menu_comprar[playerid][1]);
		PlayerTextDrawHide(playerid, conce_menu_comprar[playerid][2]);
		PlayerTextDrawHide(playerid, conce_menu_testar[playerid]);
		PlayerTextDrawHide(playerid, conce_menu_editar[playerid]);
		PlayerTextDrawHide(playerid, conce_menu_comprar_text[playerid]);
		CancelSelectTextDraw(playerid);		
		return true;
	}
	else if(playertextid == conce_menu_editar[playerid]) {
		SetPVarInt(playerid, "conce_admin_vehicle_edit", 1); //editando
		SetPVarInt(playerid, "conce_admin_vehicle_edit_index", GetPlayerVehicleID(playerid)); //editando veiculo id

		PlayerTextDrawHide(playerid, conce_menu_bcomprar[playerid]);
		PlayerTextDrawHide(playerid, conce_menu_cancelar[playerid]);
		PlayerTextDrawHide(playerid, conce_menu_comprar[playerid][0]);
		PlayerTextDrawHide(playerid, conce_menu_comprar[playerid][1]);
		PlayerTextDrawHide(playerid, conce_menu_comprar[playerid][2]);
		PlayerTextDrawHide(playerid, conce_menu_testar[playerid]);
		PlayerTextDrawHide(playerid, conce_menu_editar[playerid]);
		PlayerTextDrawHide(playerid, conce_menu_comprar_text[playerid]);
		CancelSelectTextDraw(playerid);

		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(GetPlayerVehicleID(playerid), 1, lights, alarm, 1, bonnet, boot, objective);
		
		SendClientMessage(playerid, -1, "Voce entrou no modo de edicao, voce ja pode andar com o veiculo para mudar seu spawn ou use /editarveiculo.");
		SendClientMessage(playerid, -1, "Para finalizar basta sair do veiculo..");
		return true;
	}
	return true;
}
conceOnPlayerKeyStateChange(playerid, newkeys) {
	new engine, lights, alarm, doors, bonnet, boot, objective, arquivo[128];
	if(newkeys == KEY_WALK)  {
		new Float:x, Float:y, Float:z;
		for(new i = 0; i < MAX_VEHICLES; i++) {
			GetVehiclePos(i, x, y, z);
			for(new a = 0; a < MAX_PLAYER_VEHICLE; a++) {
				if(i != playerVeiculo[playerid][a][veiculoVeiculo]) continue;
				if(!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z)) continue;
				if(GetPlayerVehicleSide(playerid, playerVeiculo[playerid][a][veiculoVeiculo]) == VEHICLE_LEFT || VEHICLE_RIGHT == GetPlayerVehicleSide(playerid, i)) {
					if(playerVeiculo[playerid][a][veiculoPorta] == false) {
						playerVeiculo[playerid][a][veiculoPorta] = true;
						GetVehicleParamsEx(playerVeiculo[playerid][a][veiculoVeiculo], engine, lights, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(playerVeiculo[playerid][a][veiculoVeiculo], engine, lights, alarm, 1, bonnet, boot, objective);
						GameTextForPlayer(playerid, "c TRANCADO", 1000, 6);
						format(arquivo, sizeof arquivo, "concessionaria/playerVeiculos/%s_%d", GetName(playerid), i);
						return true;
					}
					else if(playerVeiculo[playerid][a][veiculoPorta] == true) {
						playerVeiculo[playerid][a][veiculoPorta] = false;
						GetVehicleParamsEx(playerVeiculo[playerid][a][veiculoVeiculo], engine, lights, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(playerVeiculo[playerid][a][veiculoVeiculo], engine, lights, alarm, 0, bonnet, boot, objective);
						GameTextForPlayer(playerid, "c ABERTO", 1000, 6);
						format(arquivo, sizeof arquivo, "concessionaria/playerVeiculos/%s_%d", GetName(playerid), i);
						return true;
					}
					break;
				}
				else if(GetPlayerVehicleSide(playerid, playerVeiculo[playerid][a][veiculoVeiculo]) == VEHICLE_BACK) {
					if(playerVeiculo[playerid][a][veiculoPortaMalas] == true) {
						playerVeiculo[playerid][a][veiculoPortaMalas] = false;
						GetVehicleParamsEx(playerVeiculo[playerid][a][veiculoVeiculo], engine, lights, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(playerVeiculo[playerid][a][veiculoVeiculo], engine, lights, alarm, doors, bonnet, 0, objective);
						GameTextForPlayer(playerid, "PORTAMALAS FECHADO", 1000, 6);
						format(arquivo, sizeof arquivo, "concessionaria/playerVeiculos/%s_%d", GetName(playerid), i);
						DOF2_SetBool(arquivo, "veiculoPorta", playerVeiculo[playerid][i][veiculoPorta]);
						return true;
					}
					else if(playerVeiculo[playerid][a][veiculoPortaMalas] == false) {
						playerVeiculo[playerid][a][veiculoPortaMalas] = true;
						GetVehicleParamsEx(playerVeiculo[playerid][a][veiculoVeiculo], engine, lights, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(playerVeiculo[playerid][a][veiculoVeiculo], engine, lights, alarm, doors, bonnet, 1, objective);
						GameTextForPlayer(playerid, "PORTAMALAS ABERTO", 1000, 6);
						format(arquivo, sizeof arquivo, "concessionaria/playerVeiculos/%s_%d", GetName(playerid), i);
						DOF2_SetBool(arquivo, "veiculoPortaMalas", playerVeiculo[playerid][i][veiculoPortaMalas]);
						return true;						
					}
					break;
				}
			}
		}	
	}
	return 1;
}

forward concessionariaTestDrive(playerid);
public concessionariaTestDrive(playerid) {
	new string[3];
	if(GetPVarInt(playerid, "conce_timer") < 20) {
		SetPVarInt(playerid, "conce_timer", GetPVarInt(playerid, "conce_timer") + 1);
		format(string, sizeof string, "%d", 20 - GetPVarInt(playerid, "conce_timer"));
		GameTextForPlayer(playerid, string, 1000, 6);
	} else {
		new vehicleid, Float:vehicleX, Float:vehicleY, Float:vehicleZ;
		vehicleid = GetPVarInt(playerid, "conceTestDriveIndex");
		GetVehiclePos(vehicleid, vehicleX, vehicleY, vehicleZ);
		SetPlayerPos(playerid, vehicleX, vehicleY, vehicleZ + 2.0);
		DestroyVehicle(conceTestVeiculo[playerid]);
		
		SetPVarInt(playerid, "conceTestDriveIndex", 0);
		
		SetPVarInt(playerid, "conce_timer", 0);
		KillTimer(timerConceTest[playerid]);
		return true;
	}
	return true;
}

stock LoadConce() {
	new string[128], arquivo[128];
	for(new i = 0; i < MAX_SERVER_CONCE; i++) {
		format(arquivo, sizeof arquivo, "concessionaria/concessionarias/%d", i);
		if(DOF2_FileExists(arquivo)) {
			serverConce[i][conceAtiva] = DOF2_GetBool(arquivo, "conceAtiva");
			
			serverConce[i][concePosition][0] = DOF2_GetFloat(arquivo, "concePosition1");
			serverConce[i][concePosition][1] = DOF2_GetFloat(arquivo, "concePosition2");
			serverConce[i][concePosition][2] = DOF2_GetFloat(arquivo, "concePosition3");

			format(string, sizeof string, "[Concessionaria %d]", i);
			serverConce[i][conceText3D] = Create3DTextLabel(string, 0x008080FF, serverConce[i][concePosition][0], serverConce[i][concePosition][1], serverConce[i][concePosition][2], 5.0, 0, 0);
			serverConce[i][concePickUp] = CreatePickup(1074, 0, serverConce[i][concePosition][0], serverConce[i][concePosition][1], serverConce[i][concePosition][2], 0);	
		}
	}
	return true;
}
stock LoadConceVehicles() {
	new arquivo[128], string[128];
	new engine, lights, alarm, doors, bonnet, boot, objective;
	for(new i = 0; i < MAX_CONCE_VEICULOS; i++) {
		format(arquivo, sizeof arquivo, "concessionaria/concessionariaVeiculos/%d", i);
		if(DOF2_FileExists(arquivo)) {
			
			conceVeiculo[i][conceVeiculoAtivo] = DOF2_GetBool(arquivo, "conceVeiculoAtivo");
			conceVeiculo[i][conceVeiculoCompravel] = DOF2_GetBool(arquivo, "conceVeiculoCompravel");
			
			conceVeiculo[i][conceVeiculoPreco] = DOF2_GetInt(arquivo, "conceVeiculoPreco");
			conceVeiculo[i][conceVeiculoModel] = DOF2_GetInt(arquivo, "conceVeiculoModel");
			conceVeiculo[i][conceVeiculoConcessionaria] = DOF2_GetInt(arquivo, "conceVeiculoConcessionaria");
			conceVeiculo[i][conceVeiculoCor][0] = DOF2_GetInt(arquivo, "conceVeiculoCor1");
			conceVeiculo[i][conceVeiculoCor][1] = DOF2_GetInt(arquivo, "conceVeiculoCor2");
			
			conceVeiculo[i][conceVeiculoPosX] = DOF2_GetInt(arquivo, "conceVeiculoPosX");
			conceVeiculo[i][conceVeiculoPosY] = DOF2_GetInt(arquivo, "conceVeiculoPosY");
			conceVeiculo[i][conceVeiculoPosZ] = DOF2_GetInt(arquivo, "conceVeiculoPosZ");
			conceVeiculo[i][conceVeiculoPosRot] = DOF2_GetInt(arquivo, "conceVeiculoPosRot");

			conceVeiculo[i][conceVeiculoVeiculo] =  CreateVehicle(conceVeiculo[i][conceVeiculoModel], conceVeiculo[i][conceVeiculoPosX], conceVeiculo[i][conceVeiculoPosY], conceVeiculo[i][conceVeiculoPosZ], conceVeiculo[i][conceVeiculoPosRot], conceVeiculo[i][conceVeiculoCor][0], conceVeiculo[i][conceVeiculoCor][1], -1);

			format(string, sizeof string, "[Concessionaria %d]\nPreco:%d\nVeiculo:%s %d", conceVeiculo[i][conceVeiculoConcessionaria], conceVeiculo[i][conceVeiculoPreco], VehicleNames[conceVeiculo[i][conceVeiculoModel]-400], conceVeiculo[i][conceVeiculoVeiculo]);
			conceVeiculo[i][conceVeiculoText3D] = Create3DTextLabel(string, -1, 0, 0, 0, 5.0, 0);
			Attach3DTextLabelToVehicle(conceVeiculo[i][conceVeiculoText3D], conceVeiculo[i][conceVeiculoVeiculo], 0, 0, 0);
			
			GetVehicleParamsEx(conceVeiculo[i][conceVeiculoVeiculo], engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(conceVeiculo[i][conceVeiculoVeiculo], 0, lights, alarm, 0, bonnet, boot, objective);
		}
	}
	return true;
}
stock LoadPlayerVehicles(playerid) {
	new arquivo[128], string[128];
	new engine, lights, alarm, doors, bonnet, boot, objective;
	for(new i = 0; i < MAX_PLAYER_VEHICLE; i++) {
		format(arquivo, sizeof arquivo, "concessionaria/playerVeiculos/%s_%d", GetName(playerid), i);
		if(DOF2_FileExists(arquivo)) {
			
			playerVeiculo[playerid][i][veiculoAtivo] = DOF2_GetBool(arquivo, "veiculoAtivo");
			playerVeiculo[playerid][i][veiculoPorta] = DOF2_GetBool(arquivo, "veiculoPorta");
			playerVeiculo[playerid][i][veiculoMotor] = DOF2_GetBool(arquivo, "veiculoMotor");
			
			playerVeiculo[playerid][i][veiculoGasolina] = DOF2_GetInt(arquivo, "veiculoGasolina");
			
			playerVeiculo[playerid][i][veiculoX] = DOF2_GetFloat(arquivo, "veiculoX");
			playerVeiculo[playerid][i][veiculoY] = DOF2_GetFloat(arquivo, "veiculoY");
			playerVeiculo[playerid][i][veiculoZ] = DOF2_GetFloat(arquivo, "veiculoZ");
			playerVeiculo[playerid][i][veiculoRot] = DOF2_GetFloat(arquivo, "veiculoRot");
		
			playerVeiculo[playerid][i][veiculoCor][0] = DOF2_GetInt(arquivo, "veiculoCor_0");
			playerVeiculo[playerid][i][veiculoCor][1] = DOF2_GetInt(arquivo, "veiculoCor_0");
			playerVeiculo[playerid][i][veiculoModelo] = DOF2_GetInt(arquivo, "veiculoModelo");
			for(new Comp = 0; Comp < 13; Comp++) {
				format(string, sizeof string, "veiculoComponentes_%d", Comp);
				playerVeiculo[playerid][i][veiculoComponentes][Comp] = DOF2_GetInt(arquivo, string);
			}

			playerVeiculo[playerid][i][veiculoVeiculo] =  CreateVehicle(playerVeiculo[playerid][i][veiculoModelo], playerVeiculo[playerid][i][veiculoX], playerVeiculo[playerid][i][veiculoY], playerVeiculo[playerid][i][veiculoZ], playerVeiculo[playerid][i][veiculoRot], playerVeiculo[playerid][i][veiculoCor][0], playerVeiculo[playerid][i][veiculoCor][1], -1);

			GetVehicleParamsEx(playerVeiculo[playerid][i][veiculoVeiculo], engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(playerVeiculo[playerid][i][veiculoVeiculo], 0, lights, alarm, 1, bonnet, boot, objective);
		}
	}
	return true;
}

stock GetName(playerid) {
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	return pName;
}
stock IsNumeric(const string[]) {
	for(new i=0; string[i]; i++) {
		if(string[i] < '0' || string[i] > '9') return 0;
	}
	return true;
}
stock GetVehicleModelFromName(const vname[]) {
	for(new i=0; i < sizeof(VehicleNames); i++) {
		if(strfind(VehicleNames[i], vname, true) != -1) return i + 400;
	}
	return -1;
}
 
GetPlayerVehicleSide(playerid, vehicleid) {
        static Float:x[5],Float:y[5],Float:z[5];
 
        GetPosBetweenVehicle(vehicleid, x[0], y[0], z[0],.dangle = -000.0); // atras
        GetPosBetweenVehicle(vehicleid, x[1], y[1], z[1],.dangle = -180.0); // frente
        GetPosBetweenVehicle(vehicleid, x[2], y[2], z[2],.dangle = -090.0); // esquerda
        GetPosBetweenVehicle(vehicleid, x[3], y[3], z[3],.dangle =  090.0); // direita
 
        z[0] = GetPlayerDistanceFromPoint(playerid, x[0], y[0], z[0]);
        z[1] = GetPlayerDistanceFromPoint(playerid, x[1], y[1], z[1]);
        z[2] = GetPlayerDistanceFromPoint(playerid, x[2], y[2], z[2]);
        z[3] = GetPlayerDistanceFromPoint(playerid, x[3], y[3], z[3]);
 
        if(z[0]<z[1])
        if(z[0]<z[2])
        if(z[0]<z[3])
        return VEHICLE_BACK;
 
        if(z[1]<z[2])
        if(z[1]<z[3])
        return VEHICLE_FRONT;
 
 
        if(z[2]<z[3])
        return VEHICLE_LEFT;
 
        return VEHICLE_RIGHT;
 
}
stock GetPosBetweenVehicle(vehicleid, &Float:x, &Float:y, &Float:z, Float:offset=0.5, Float:dangle = 0.0) {
        new Float:vehicleSize[3], Float:vehiclePos[3];
        GetVehiclePos(vehicleid, vehiclePos[0], vehiclePos[1], vehiclePos[2]);
        GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, vehicleSize[0], vehicleSize[1], vehicleSize[2]);
        GetXYBehindVehicle(vehicleid, vehiclePos[0], vehiclePos[1], (vehicleSize[1]/2)+offset, dangle);
        x = vehiclePos[0];
        y = vehiclePos[1];
        z = vehiclePos[2];
        return 1;
}
GetXYBehindVehicle(vehicleid, &Float:q, &Float:w, Float:distance, Float:dangle = 0.0) {
        new Float:a;
        GetVehiclePos(vehicleid, q, w, a);
        GetVehicleZAngle(vehicleid, a);
        q += (distance * -floatsin(-a-dangle, degrees));
        w += (distance * -floatcos(-a-dangle, degrees));
}