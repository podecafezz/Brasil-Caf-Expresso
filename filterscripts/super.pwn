
#include <a_samp>

#define COR_DELETE 0xFFFF00AA

public OnFilterScriptInit()
{

//carro veiculos
AddStaticVehicle(451,2123.84570312,-816.74554443,966.90161133,92.00000000,-1,-1); //Turismo
AddStaticVehicle(451,2123.99218750,-819.74145508,966.90161133,91.99951172,-1,-1); //Turismo
AddStaticVehicle(451,2123.65136719,-823.01177979,966.90161133,91.99951172,-1,-1); //Turismo
AddStaticVehicle(451,2123.78564453,-825.75836182,966.90161133,91.99951172,-1,-1); //Turismo
AddStaticVehicle(451,2123.95605469,-829.25354004,966.90161133,91.99951172,-1,-1); //Turismo
AddStaticVehicle(451,2124.12695312,-832.74865723,966.90161133,91.99951172,-1,-1); //Turismo
AddStaticVehicle(451,2124.26123047,-835.49468994,966.90161133,91.99951172,-1,-1); //Turismo
AddStaticVehicle(451,2124.41943359,-838.74017334,966.90161133,91.99951172,-1,-1); //Turismo
AddStaticVehicle(451,2124.61425781,-842.73437500,966.90161133,91.99951172,-1,-1); //Turismo
AddStaticVehicle(451,2124.73632812,-845.23132324,966.90161133,91.99951172,-1,-1); //Turismo
AddStaticVehicle(451,2124.90722656,-848.72619629,966.90161133,91.99951172,-1,-1); //Turismo
AddStaticVehicle(451,2125.05371094,-851.72192383,966.90161133,91.99951172,-1,-1); //Turismo
AddStaticVehicle(451,2124.96264648,-854.97998047,966.90161133,91.99951172,-1,-1); //Turismo
AddStaticVehicle(411,2094.08618164,-817.71142578,966.93725586,272.00000000,-1,-1); //Infernus
AddStaticVehicle(411,2094.29394531,-820.70361328,966.93725586,271.99951172,-1,-1); //Infernus
AddStaticVehicle(411,2094.51928711,-823.94519043,966.93725586,271.99951172,-1,-1); //Infernus
AddStaticVehicle(411,2094.76123047,-827.43579102,966.93725586,271.99951172,-1,-1); //Infernus
AddStaticVehicle(411,2094.95141602,-830.17883301,966.93725586,271.99951172,-1,-1); //Infernus
AddStaticVehicle(411,2095.17651367,-833.42077637,966.93725586,271.99951172,-1,-1); //Infernus
AddStaticVehicle(411,2095.41845703,-836.91137695,966.93725586,271.99951172,-1,-1); //Infernus
AddStaticVehicle(411,2095.64331055,-840.15319824,966.93725586,271.99951172,-1,-1); //Infernus
AddStaticVehicle(411,2095.83325195,-842.89562988,966.93725586,271.99951172,-1,-1); //Infernus
AddStaticVehicle(411,2096.05834961,-846.13757324,966.93725586,271.99951172,-1,-1); //Infernus
AddStaticVehicle(411,2094.76855469,-849.65875244,966.93725586,271.99951172,-1,-1); //Infernus
AddStaticVehicle(411,2094.67675781,-852.81933594,966.93725586,271.99951172,-1,-1); //Infernus
AddStaticVehicle(411,2094.90576172,-855.83154297,966.93725586,271.99951172,-1,-1); //Infernus

//objeitos
CreateObject(5333,2069.66381836,448.81326294,265.18301392,0.00000000,25.75000000,91.75000000); //object(sanpedbigslt_las2) (1)
CreateObject(5333,2059.54492188,780.92871094,79.05332947,0.00000000,25.74645996,91.74682617); //object(sanpedbigslt_las2) (2)
CreateObject(5333,2064.60742188,614.81933594,172.04090881,0.00000000,25.74645996,91.74682617); //object(sanpedbigslt_las2) (3)
CreateObject(5333,2084.76098633,-46.11843872,542.88262939,0.00000000,25.74645996,91.74682617); //object(sanpedbigslt_las2) (4)
CreateObject(5333,2074.71191406,283.32324219,358.05578613,0.00000000,25.74645996,91.74682617); //object(sanpedbigslt_las2) (5)
CreateObject(5333,2079.71191406,119.48535156,449.96746826,0.00000000,25.74645996,91.74682617); //object(sanpedbigslt_las2) (6)
CreateObject(5333,2089.84106445,-212.05923462,636.07104492,0.00000000,25.74645996,91.74682617); //object(sanpedbigslt_las2) (7)
CreateObject(5333,2094.90209961,-377.82464600,729.12316895,0.00000000,25.74645996,91.74682617); //object(sanpedbigslt_las2) (8)
CreateObject(5333,2099.98388672,-544.47198486,822.63378906,0.00000000,25.74645996,91.74682617); //object(sanpedbigslt_las2) (9)
CreateObject(5333,2104.98583984,-707.91461182,914.42657471,0.00000000,25.74645996,91.74682617); //object(sanpedbigslt_las2) (10)
CreateObject(8040,2109.70678711,-848.03033447,966.90289307,0.00000000,0.00000000,92.00000000); //object(airprtcrprk02_lvs) (1)
CreateObject(8040,2109.76074219,-848.04974365,971.59454346,180.00000000,0.00000000,91.99951172); //object(airprtcrprk02_lvs) (2)
CreateObject(1634,2052.40625000,854.36749268,41.12936783,10.00000000,0.00000000,0.00000000); //object(landjump2) (1)
CreateObject(1634,2055.93994141,847.36291504,38.56890488,339.99938965,0.00000000,0.00000000); //object(landjump2) (2)
CreateObject(1634,2059.93554688,847.18554688,38.56890488,339.99938965,0.00000000,0.00000000); //object(landjump2) (3)
CreateObject(1634,2063.18237305,847.04193115,38.56890488,339.99938965,0.00000000,0.00000000); //object(landjump2) (4)
CreateObject(1634,2052.44335938,847.51757812,38.56890488,339.99938965,0.00000000,0.00000000); //object(landjump2) (5)
CreateObject(1634,2055.92333984,854.33850098,41.12936783,9.99755859,0.00000000,0.00000000); //object(landjump2) (9)
CreateObject(1634,2059.69116211,854.30676270,41.12936783,9.99755859,0.00000000,0.00000000); //object(landjump2) (10)
CreateObject(1634,2063.23632812,854.26116943,41.12936783,9.99755859,0.00000000,0.00000000); //object(landjump2) (11)

return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{

new stringa[MAX_PLAYERS];

if(strcmp(cmdtext, "/rampa", true) == 0) {
if(IsPlayerInAnyVehicle(playerid)) {
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,2110.3625,-867.8795,968.1179);
SetVehicleZAngle(GetPlayerVehicleID(playerid), 00.0);
new pname[MAX_PLAYERS];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(stringa, sizeof(stringa), "{00ff00}%s Foi Para a SuperRampa {00ffff}( /rampa )", pname);
SendClientMessageToAll(COR_DELETE, stringa);
ResetPlayerWeapons(playerid);
SetPlayerInterior(playerid,0);
SetPlayerArmour(playerid, 100.0);
SetPlayerHealth(playerid, 100.0);
}else{
SetPlayerPos(playerid,2110.3625,-867.8795,968.1179);
new pname[MAX_PLAYERS];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(stringa, sizeof(stringa), "{00ff00}%s Foi Para a SuperRampa {00ffff}( /rampa )", pname);
SendClientMessageToAll(COR_DELETE, stringa);
ResetPlayerWeapons(playerid);
SetPlayerInterior(playerid,0);
SetPlayerArmour(playerid, 100.0);
SetVehicleHealth(playerid, 100.0);
}
return 1;
}
return 0;
}
