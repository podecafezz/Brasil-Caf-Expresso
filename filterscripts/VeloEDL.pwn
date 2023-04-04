/*________________________________________| Sa-mp eDl |______________________________________
=============================================================================================
||      _____   _    _   ___   ___   ___     ____   _____   _      _    _    _   ____       ||
||     | ___ | | \  | | | _ \ | _ | | __|   |    | | ___ | | \    / |  | \  | | | __ |      ||
||     ||___|| |  \ | | || || ||_|| |   |   |  __| ||___|| |  \/\/  |  |  \ | | ||  ||      ||
||     |  _  | |   \| | ||_|| |   / | __|   | |    |  _  | |        |  |   \| | ||__||      ||
||     |_| |_| |_|\___| |___/ |_|_\ |___|   |_|    |_| |_| |________|  |_|\___| |____|      ||
||                                                                                          ||
||          [eDl]Equipe Dos Leks[eDl]  -  Copyright (c) 1997-2006, ITB CompuPhase           ||   
||           -->> Pode Falar o Que Quiser!! Ownamos Mais Que Tudo Zé Mané!! <<--            ||                                                                  ||
=============================================================================================
*/

#include <a_samp>
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
#define Cor_Verde             0x22F40BAA
#define VeloEDL               1997  //Id Existente? So mudar Xd
#define VeloeDlDesativado     "[ERRO] Velocimetro Equipe Dos Leks Ja Esta Desativado"
#define VeloeDlAtivado        "[SUCESSO] Velocimetro Equipe Dos Leks Ativado Com sucesso"
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
forward VelocimetroEquipeDosLeks();
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
new Float:Lataria;
new pname[MAX_PLAYER_NAME];
new Text:TxD_Motorista[MAX_PLAYERS];// Mostrar Nome Do Motorista
new Text:TxD_Veiculo;// Mostrar Nome Do Veiculo
new Text:TxD_Velocidade[MAX_PLAYERS];// Mostrar Velocidade
new Text:TxD_Lataria[MAX_PLAYERS];
new bool:InfoVeloeDl[MAX_PLAYERS];// Status Do Velocimetro
new NomeVeiculos[212][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
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
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
public OnPlayerConnect(playerid)
{
    InfoVeloeDl[playerid] = false;
    TextDrawHideForPlayer(playerid, TxD_Velocidade[playerid]);
    TextDrawHideForPlayer(playerid, TxD_Veiculo);    
    TextDrawHideForPlayer(playerid, TxD_Motorista[playerid]);	
    TextDrawHideForPlayer(playerid, TxD_Lataria[playerid]);
    return 1;
}
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
public OnPlayerDisconnect(playerid, reason)
{
    InfoVeloeDl[playerid] = false;
    TextDrawHideForPlayer(playerid, TxD_Velocidade[playerid]);
    TextDrawHideForPlayer(playerid, TxD_Veiculo);    
    TextDrawHideForPlayer(playerid, TxD_Motorista[playerid]);	
    TextDrawHideForPlayer(playerid, TxD_Lataria[playerid]);
    return 1;
}
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
public OnPlayerCommandText(playerid, cmdtext[])
{

if(!strcmp(cmdtext, "/VeloEDL", true))
{   
    ShowPlayerDialog(playerid, VeloEDL, DIALOG_STYLE_LIST, "Velocimetro Equipe Dos Leks", "Ativar Todo Velocimetro\nDesativar Todo Velocimetro","Selecionar", "Cancelar");
    return 1 ;
}
return 0;
}

public OnPlayerDeath(playerid, killerid, reason)
{
// Esconder nossas Td na tragica morte :(
    TextDrawHideForPlayer(playerid, TxD_Velocidade[playerid]);
    TextDrawHideForPlayer(playerid, TxD_Veiculo);    
    TextDrawHideForPlayer(playerid, TxD_Motorista[playerid]);    
    TextDrawHideForPlayer(playerid, TxD_Lataria[playerid]);
	return 1;
}
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
    TextDrawShowForPlayer(playerid, TxD_Velocidade[playerid]);
    TextDrawShowForPlayer(playerid, TxD_Veiculo);   
    TextDrawShowForPlayer(playerid, TxD_Motorista[playerid]);
    TextDrawShowForPlayer(playerid, TxD_Lataria[playerid]);
    }
    if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
    {
    TextDrawHideForPlayer(playerid, TxD_Velocidade[playerid]);
    TextDrawHideForPlayer(playerid, TxD_Veiculo);    
    TextDrawHideForPlayer(playerid, TxD_Motorista[playerid]);    
    TextDrawHideForPlayer(playerid, TxD_Lataria[playerid]);
    }
	return 1;
}
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
public OnFilterScriptInit()
{
/*=-=-=--=-=-=-=-=-=-=-=-=-=-[ Velocimetro Equipe Dos Leks ]=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=*/
	SetTimer("VelocimetroEquipeDosLeks",453,1);  //<< --Velocimetro
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    TxD_Velocidade[i] = TextDrawCreate(258.000000, 399.000000,"~g~] ~r~Velocidade");// << --Localizacao do Velocimetro
    TextDrawAlignment(TxD_Velocidade[i],0);
    TextDrawBackgroundColor(TxD_Velocidade[i],255);
    TextDrawFont(TxD_Velocidade[i],2);  //<< Fonte do Velocimetro
    TextDrawLetterSize(TxD_Velocidade[i],0.299999,1.200000);// <<-- Tamanho da fonte do Velocimetro
    TextDrawColor(TxD_Velocidade[i],-16776961);
    TextDrawSetProportional(TxD_Velocidade[i],1); // Nao mexa
    TextDrawSetShadow(TxD_Velocidade[i],1); // Nao mexa
    TextDrawSetOutline(TxD_Velocidade[i], 1); // Nao mexa
	TextDrawUseBox(TxD_Velocidade[i], 0);
	TextDrawBoxColor(TxD_Velocidade[i], 50);
    }
	TxD_Veiculo = TextDrawCreate(258.000000,389.000000,"~g~] ~r~Veiculo");
    TextDrawAlignment(TxD_Veiculo,0);
    TextDrawBackgroundColor(TxD_Veiculo,255);
    TextDrawFont(TxD_Veiculo,2);  //<< Fonte do Velocimetro
    TextDrawLetterSize(TxD_Veiculo,0.299999,1.200000);// <<-- Tamanho da fonte do Velocimetro
    TextDrawColor(TxD_Veiculo,-16776961);
    TextDrawSetProportional(TxD_Veiculo,1); // Nao mexa
    TextDrawSetShadow(TxD_Veiculo,1); // Nao mexa
    TextDrawSetOutline(TxD_Veiculo, 1); // Nao mexa
	TextDrawUseBox(TxD_Veiculo, 0);
	TextDrawBoxColor(TxD_Veiculo, 50);        
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
	TxD_Motorista[i] = TextDrawCreate(258.000000,379.000000,"~g~] ~r~Motorista");
    TextDrawAlignment(TxD_Motorista[i],0);
    TextDrawBackgroundColor(TxD_Motorista[i],255);
    TextDrawFont(TxD_Motorista[i],2);  //<< Fonte do Velocimetro
    TextDrawLetterSize(TxD_Motorista[i],0.299999,1.200000);// <<-- Tamanho da fonte do Velocimetro
    TextDrawColor(TxD_Motorista[i],-16776961);
    TextDrawSetProportional(TxD_Motorista[i],1); // Nao mexa
    TextDrawSetShadow(TxD_Motorista[i],1); // Nao mexa
    TextDrawSetOutline(TxD_Motorista[i], 1); // Nao mexa
	TextDrawUseBox(TxD_Motorista[i], 0);
	TextDrawBoxColor(TxD_Motorista[i], 50);
    }
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
	TxD_Lataria[i] = TextDrawCreate(258.000000,410.000000,"~g~] ~r~Lataria");
    TextDrawAlignment(TxD_Lataria[i],0);
    TextDrawBackgroundColor(TxD_Lataria[i],255);
    TextDrawFont(TxD_Lataria[i],2);  //<< Fonte do Velocimetro
    TextDrawLetterSize(TxD_Lataria[i],0.299999,1.200000);// <<-- Tamanho da fonte do Velocimetro
    TextDrawColor(TxD_Lataria[i],-16776961);
    TextDrawSetProportional(TxD_Lataria[i],1); // Nao mexa
    TextDrawSetShadow(TxD_Lataria[i],1); // Nao mexa
    TextDrawSetOutline(TxD_Lataria[i], 1); // Nao mexa
	TextDrawUseBox(TxD_Lataria[i], 0);
	TextDrawBoxColor(TxD_Lataria[i], 50);
    }
/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-[ Velocimetro Equipe Dos Leks ]=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
    return 1;
}
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
public OnFilterScriptExit()
{
	return 1;
}
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
if(dialogid == VeloEDL){
if(response){
if(listitem == 0)// Velocimetro Ativado
{
if(InfoVeloeDl[playerid] == true)
if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || PLAYER_STATE_PASSENGER){
SendClientMessage(playerid, Cor_Verde, VeloeDlAtivado);
TextDrawShowForPlayer(playerid, TxD_Velocidade[playerid]);
TextDrawShowForPlayer(playerid, TxD_Veiculo);   
TextDrawShowForPlayer(playerid, TxD_Motorista[playerid]);
TextDrawShowForPlayer(playerid, TxD_Lataria[playerid]);
InfoVeloeDl[playerid] = true;
}
}   		
if(listitem == 1)// Velocimetro Desativado
{
if(InfoVeloeDl[playerid] == false) return SendClientMessage(playerid, Cor_Verde, VeloeDlDesativado);
if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || PLAYER_STATE_PASSENGER){
SendClientMessage(playerid, Cor_Verde, "[INFO]: Velcimetro Equipe Dos Leks Desativado Com Sucesso");
TextDrawHideForPlayer(playerid, TxD_Velocidade[playerid]);
TextDrawHideForPlayer(playerid, TxD_Veiculo);    
TextDrawHideForPlayer(playerid, TxD_Motorista[playerid]);
TextDrawHideForPlayer(playerid, TxD_Lataria[playerid]);
InfoVeloeDl[playerid] = false;
}
}
}
}

return 1;
}
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
public VelocimetroEquipeDosLeks()
{

for(new i; i < GetMaxPlayers(); i++)
{
if(IsPlayerConnected(i))
{
if(IsPlayerInAnyVehicle(i))
{
new String[100];
new speed = GetPlayerSpeed(i,true);
format(String,100,"~g~] ~r~Velocidade ~w~%d km/h",speed);
if(!speed || speed < 0) {  /*__Velocidade__*/
TextDrawSetString(TxD_Velocidade[i],"~g~] ~r~Velocidade ~w~0 km/h");
}
TextDrawSetString(TxD_Velocidade[i],String);
}
new string[68];           /*__Veiculo_-*/
format(string,sizeof(string),"~g~] ~r~Veiculo ~w~%s", NomeVeiculos[GetVehicleModel(GetPlayerVehicleID(i))-400]);
TextDrawSetString(TxD_Veiculo, string);
TextDrawShowForPlayer(i, TxD_Veiculo);
                         /*__Motorista__*/
format(string,sizeof(string),"~g~] ~r~Motorista ~w~%s", pname);
GetPlayerName(i, pname, sizeof(pname));
TextDrawSetString(TxD_Motorista[i], string);
TextDrawShowForPlayer(i, TxD_Motorista[i]);
                        /*__Lataria__*/
GetVehicleHealth(GetPlayerVehicleID(i), Lataria);
TextDrawHideForPlayer(i, TxD_Lataria[i]);
format(string,sizeof(string),"~g~] ~r~Lataria ~w~%0.0f%%", Lataria);
TextDrawSetString(TxD_Lataria[i], string);
TextDrawShowForPlayer(i, TxD_Lataria[i]);
}
}

return 1;
}
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
stock nome(playerid)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, sizeof(pname));
return pname;
}
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
stock GetPlayerSpeed2D(playerid,bool:kmh) // by misco edit by gamer_z
{
new Float:Vx,Float:Vy,Float:Vz,Float:rtn;
if(IsPlayerInAnyVehicle(playerid))
GetVehicleVelocity(GetPlayerVehicleID(playerid),Vx,Vy,Vz); 
else GetPlayerVelocity(playerid,Vx,Vy,Vz);
rtn = floatsqroot(Vx*Vx + Vy*Vy);
return kmh?floatround(rtn * 100 * 1.63):floatround(rtn * 100);
}
/*---------------------------------------------------------------------------------------------
                      _-= SA-MP EDL =-_  Tudo Para Seu Servidor Sa-mp
                         Acesse ->>> www.sa-mpedl.blogspot.com
 ----------------------------------------------------------------------------------------------*/
stock GetPlayerSpeed(playerid,bool:kmh) // by misco edit by gamer_z
{
new Float:Vx,Float:Vy,Float:Vz,Float:rtn;
if(IsPlayerInAnyVehicle(playerid)) 
GetVehicleVelocity(GetPlayerVehicleID(playerid),Vx,Vy,Vz); 
else GetPlayerVelocity(playerid,Vx,Vy,Vz);
rtn = floatsqroot(Vx*Vx + Vy*Vy + Vz*Vz);
return kmh?floatround(rtn * 100 * 1.63):floatround(rtn * 100);
}
/*___________________________| Sa-mp eDl |_____________________________
=======================================================================
||                              _____                                ||
||                             |     \                               ||
||                       ___   |  ___ \    _                         ||
||           \          | __|  | |   | |  | |        /               ||
||    ------\ \         ||__   | |   | |  | |       / /-------       ||
||    ------/ /         | __|  | |   | |  | |       \ \-------       ||
||           /          ||__   | |   | |  | |        \               ||
||                      |___|  | |___| |  |_|                        ||
||                             |      /                              ||
||                             |_____/  [eDl]Equipe Dos Leks[eDl]    ||
||                                                                   ||                                                                   
=======================================================================
 -->> Pode Falar o Que Quiser!! Ownamos Mais Que Tudo Zé Mané!! <<--
*/
