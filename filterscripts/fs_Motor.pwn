// Sistema feito por felipe Melo
// nao tire os creditos!!!!
#define FILTERSCRIPT
#define LARANJA 0xFF6600AA
#define Branco 0xFFFFFFFF
#define Verde  0x21DD00FF
#include <a_samp>

#if defined FILTERSCRIPT
new luz[MAX_PLAYERS];
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Fs de Ligar ou Desligar Motor/Farol");
	print(" By:Felipe Melo");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
SendClientMessage(playerid, Verde, "lk");
return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
if(newstate == PLAYER_STATE_DRIVER)
{
	SendClientMessage(playerid, Branco, "| INFO | Para ligar ou desligar o veiculo pressione a tecla '{CECECE}Y{FFFFFF}' Para ligar Farol pressione '{CECECE}2{FFFFFF}'");
}
return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
if(newkeys == KEY_SUBMISSION && IsPlayerInAnyVehicle(playerid))
		 {
		 	new engine, lights, alarm, doors, bonnet, boot, objective;
		    if(luz[playerid] == 0)
			{
				new veh = GetPlayerVehicleID(playerid);
				GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(veh, engine, VEHICLE_PARAMS_ON, alarm, doors, bonnet, boot, objective);
				luz[playerid] = 1;
				SendClientMessage(playerid, Verde, "| INFO | Farol ligado");

			}
			else if(luz[playerid] == 1)
			{
				new veh = GetPlayerVehicleID(playerid);
				GetVehicleParamsEx(veh, engine, lights, alarm,doors, bonnet, boot, objective);
				SetVehicleParamsEx(veh, engine, VEHICLE_PARAMS_OFF, alarm, doors, bonnet, boot, objective);
			    luz[playerid] = 0;
			    SendClientMessage(playerid, Verde, "| INFO | Farol Desligado");
			}
  }
  
  if(newkeys == KEY_YES && IsPlayerInAnyVehicle(playerid))
		 {
		 new mot, lu, alar, por, cap, porma, ob;
		 new vehicleid = GetPlayerVehicleID(playerid);
		 GetVehicleParamsEx(vehicleid, mot, lu, alar, por, cap, porma, ob);
		 if(mot == VEHICLE_PARAMS_OFF)
         {
         SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, lu, alar, por, cap, porma, ob);
         SendClientMessage(playerid, Verde, "| INFO | Veiculo ligado!");
	     }else{
	     SendClientMessage(playerid,Verde, "| INFO | Veiculo desligado!");
         SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, lu, alar, por, cap, porma, ob);
		}
}
return 1;
}
#endif
