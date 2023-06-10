/*
*            Include S_AntiSpawn v1.0
*       (c) Copyright 2012 by [S]trong
*
* @Autor     : [S]trong
* @Data      : 13 de janeiro de 2012
* @Requer    : Include a_samp (por SA-MP Team)
*
*
* Include desenvolvida com fim de nao permitir o hack de puxar carros
*
*
*
*/
#include <a_samp>
new
    vehicleTime[MAX_PLAYERS],
        lastVehicle[MAX_PLAYERS]
;

forward S_OnPlayerUpdate(playerid);

public OnPlayerUpdate(playerid)
{
    new vehicleID = GetPlayerVehicleID(playerid);
    if(lastVehicle[playerid] != vehicleID)
    {
        lastVehicle[playerid] = vehicleID;
        if(GetVehicleModel(vehicleID))
        {
            CallRemoteFunction("OnPlayerChangeVehicle","ii", playerid, vehicleID);
        }
    }
    return CallRemoteFunction("OnPlayerUpdate","i", playerid);
}

forward OnPlayerChangeVehicle(playerid, vehicleid);
public OnPlayerChangeVehicle(playerid, vehicleid)
{
    #pragma unused vehicleid
    if((GetTickCount() - vehicleTime[playerid]) < 250)
    {
        Kick(playerid);
    }
    vehicleTime[playerid] = GetTickCount();
}

stock S_PutPlayerInVehicle(playerid, vehicleid, seatid)
{
    vehicleTime[playerid] = GetTickCount();
    return PutPlayerInVehicle(playerid, vehicleid, seatid);
}
#if defined _ALS_PutPlayerInVehicle
    #undef PutPlayerInVehicle
#else
    #define _ALS_PutPlayerInVehicle
#endif
#define PutPlayerInVehicle S_PutPlayerInVehicle
#if defined _ALS_OnPlayerUpdate
    #undef OnPlayerUpdate
#else
    #define _ALS_OnPlayerUpdate
#endif
    #define OnPlayerUpdate S_OnPlayerUpdate