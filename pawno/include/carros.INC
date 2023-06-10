#include <a_samp>

#define MAX_STREAM_VEHICLES     1000

forward KID_OnStreamerInit();
forward KID_CheckStreamVehicles();
forward KID_UpdateStreamVehicles();
forward KID_CheckRespawnDelay(vehicleid);
forward KID_AddStaticVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2);
forward KID_AddStaticVehicleEx(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, respawn_delay);
forward KID_CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay);
forward KID_DestroyVehicle(vehicleid);
forward KID_GetVehiclePos(vehicleid, &Float:x, &Float:y, &Float:z);
forward KID_SetVehiclePos(vehicleid, Float:x, Float:y, Float:z);
forward KID_GetVehicleZAngle(vehicleid, &Float:z_angle);
forward KID_SetVehicleZAngle(vehicleid, Float:z_angle);
forward KID_GetVehicleModel(vehicleid);
forward KID_PrintMaxVehicles();
forward KID_IsABike(vehicleid);
forward KID_IsAnAirVehicle(vehicleid);
forward KID_IsAMotorBike(vehicleid);
forward KID_IsACopCar(vehicleid);
forward KID_IsABoat(vehicleid);
forward KID_WasMoved(vehicleid);

/*

Natives...

native KID_OnStreamerInit();
native KID_AddStaticVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2);
native KID_AddStaticVehicleEx(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, respawn_delay);
native KID_CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay);
native KID_DestroyVehicle(vehicleid);
native KID_GetVehiclePos(vehicleid, &Float:x, &Float:y, &Float:z);
native KID_SetVehiclePos(vehicleid, Float:x, Float:y, Float:z);
native KID_GetVehicleZAngle(vehicleid, &Float:z_angle);
native KID_SetVehicleZAngle(vehicleid, Float:z_angle);
native KID_GetVehicleModel(vehicleid);
native KID_IsABike(vehicleid);
native KID_IsAnAirVehicle(vehicleid);
native KID_IsAMotorBike(vehicleid);
native KID_IsACopCar(vehicleid);
native KID_IsABoat(vehicleid);

*/

stock GetDist(playerid, Float:x2, Float:y2, Float:z2)
{
	new Float:x1, Float:y1, Float:z1;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(x2, x1)), 2) + floatpower(floatabs(floatsub(y2, y1)), 2) + floatpower(floatabs(floatsub(z2, z1)), 2));
	return floatround(tmpdis);
}

enum vInfo
{
	vModel,
	Float:vPosX,
	Float:vPosY,
	Float:vPosZ,
	Float:vPosZ_Angle,
	Float:vAtPosX,
	Float:vAtPosY,
	Float:vAtPosZ,
	Float:vAtPosZ_Angle,
    vCor1,
	vCor2,
	vRespawnDelay
}

new VehicleInfo[MAX_STREAM_VEHICLES][vInfo];
new bool:UsedVSlot[MAX_STREAM_VEHICLES];
new bool:isspawned[MAX_STREAM_VEHICLES];
new vehicles;

public KID_OnStreamerInit()
{
	print("         .::Streamer de Veiculos::.  \r");
    print("        ----------------------------   \r");
	print("          .::Criado por tHe_kiD::.      \r");
	print("       .::Data de Criacao: 5/11/08::.    \r");
	print("                .::2008::.       \r");
	SetTimer("KID_CheckStreamVehicles", 100, true);
 	SetTimer("KID_UpdateStreamVehicles", 100, true);
	return 1;
}

public KID_CheckStreamVehicles()
{
	for( new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i)) return false;
		for( new v = 0; v < MAX_STREAM_VEHICLES; v++)
		{
			if(!UsedVSlot[v]) return false;
			if( !isspawned[v] )
   			{
   			    if( GetDist(i, VehicleInfo[v][vAtPosX], VehicleInfo[v][vAtPosY], VehicleInfo[v][vAtPosZ]) < 500 )
   			    {
					CreateVehicle(VehicleInfo[v][vModel], VehicleInfo[v][vAtPosX], VehicleInfo[v][vAtPosY], VehicleInfo[v][vAtPosZ], VehicleInfo[v][vAtPosZ_Angle], VehicleInfo[v][vCor1], VehicleInfo[v][vCor2], -1);
					isspawned[v] = true;
				  //if((VehicleInfo[v][vRespawnDelay] > -1) && (KID_WasMoved(v)))
                    SetTimerEx("KID_CheckRespawnDelay", VehicleInfo[v][vRespawnDelay], true, "i", v);
					break;
				}
			}
			else
			{
                if(GetDist(i, VehicleInfo[v][vAtPosX], VehicleInfo[v][vAtPosY], VehicleInfo[v][vAtPosZ]) > 500)
				{
					DestroyVehicle(v);
					isspawned[v] = false;
					break;
				}
			}
   		}
	}
	return true;
}

public KID_UpdateStreamVehicles()
{
    new Float:atX, Float:atY, Float:atZ, Float:atAngle;
    for( new i = 0; i < MAX_PLAYERS; i++)
	{
		for( new v = 0; v < MAX_STREAM_VEHICLES; v++)
		{
			if( v == GetPlayerVehicleID(i) )
			{
				GetVehiclePos(v, atX, atY, atZ);
				GetVehicleZAngle(v, atAngle);
				VehicleInfo[v][vAtPosX] = atX;
    			VehicleInfo[v][vAtPosY] = atY;
    			VehicleInfo[v][vAtPosZ] = atZ;
    			VehicleInfo[v][vAtPosZ_Angle] = atAngle;
    			return true;
    		}
    	}
    }
	return false;
}

public KID_CheckRespawnDelay(vehicleid)
{
	for( new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerInVehicle(i, vehicleid)) return false;
	}
	DestroyVehicle(vehicleid);
	VehicleInfo[vehicleid][vAtPosX] = VehicleInfo[vehicleid][vPosX];
    VehicleInfo[vehicleid][vAtPosY] = VehicleInfo[vehicleid][vPosY];
    VehicleInfo[vehicleid][vAtPosZ] = VehicleInfo[vehicleid][vPosZ];
    VehicleInfo[vehicleid][vAtPosZ_Angle] = VehicleInfo[vehicleid][vPosZ_Angle];
    isspawned[vehicleid] = false;
	return 1;
}

public KID_WasMoved(vehicleid)
{
	if(VehicleInfo[vehicleid][vAtPosX] == VehicleInfo[vehicleid][vPosX])
	{
    	if(VehicleInfo[vehicleid][vAtPosY] == VehicleInfo[vehicleid][vPosY])
    	{
    		if(VehicleInfo[vehicleid][vAtPosZ] == VehicleInfo[vehicleid][vPosZ])
    		{
   				if(VehicleInfo[vehicleid][vAtPosZ_Angle] == VehicleInfo[vehicleid][vPosZ_Angle]) return true;
                else return false;
			}
			return false;
		}
		return false;
	}
	return false;
}

public KID_AddStaticVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2)
{
	if(vehicles >= MAX_STREAM_VEHICLES) return false;
    VehicleInfo[vehicles][vModel] = modelid;
    VehicleInfo[vehicles][vPosX] = spawn_x;
    VehicleInfo[vehicles][vPosY] = spawn_y;
    VehicleInfo[vehicles][vPosZ] = spawn_z;
    VehicleInfo[vehicles][vPosZ_Angle] = z_angle;
    VehicleInfo[vehicles][vAtPosX] = spawn_x;
    VehicleInfo[vehicles][vAtPosY] = spawn_y;
    VehicleInfo[vehicles][vAtPosZ] = spawn_z;
    VehicleInfo[vehicles][vAtPosZ_Angle] = z_angle;
    VehicleInfo[vehicles][vCor1] = color1;
    VehicleInfo[vehicles][vCor2] = color2;
    VehicleInfo[vehicles][vRespawnDelay] = 60000;
    UsedVSlot[vehicles] = true;
    vehicles++;
    return vehicles;
}

public KID_AddStaticVehicleEx(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, respawn_delay)
{
	if(vehicles >= MAX_STREAM_VEHICLES) return false;
    VehicleInfo[vehicles][vModel] = modelid;
    VehicleInfo[vehicles][vPosX] = spawn_x;
    VehicleInfo[vehicles][vPosY] = spawn_y;
    VehicleInfo[vehicles][vPosZ] = spawn_z;
    VehicleInfo[vehicles][vPosZ_Angle] = z_angle;
    VehicleInfo[vehicles][vAtPosX] = spawn_x;
    VehicleInfo[vehicles][vAtPosY] = spawn_y;
    VehicleInfo[vehicles][vAtPosZ] = spawn_z;
    VehicleInfo[vehicles][vAtPosZ_Angle] = z_angle;
    VehicleInfo[vehicles][vCor1] = color1;
    VehicleInfo[vehicles][vCor2] = color2;
    VehicleInfo[vehicles][vRespawnDelay] = respawn_delay;
    UsedVSlot[vehicles] = true;
    vehicles++;
    return vehicles;
}

public KID_CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay)
{
	if(vehicles >= MAX_STREAM_VEHICLES) return false;
    VehicleInfo[vehicles][vModel] = vehicletype;
    VehicleInfo[vehicles][vPosX] = x;
    VehicleInfo[vehicles][vPosY] = y;
    VehicleInfo[vehicles][vPosZ] = z;
    VehicleInfo[vehicles][vPosZ_Angle] = rotation;
    VehicleInfo[vehicles][vAtPosX] = x;
    VehicleInfo[vehicles][vAtPosY] = y;
    VehicleInfo[vehicles][vAtPosZ] = z;
    VehicleInfo[vehicles][vAtPosZ_Angle] = rotation;
    VehicleInfo[vehicles][vCor1] = color1;
    VehicleInfo[vehicles][vCor2] = color2;
    VehicleInfo[vehicles][vRespawnDelay] = respawn_delay;
    UsedVSlot[vehicles] = true;
    vehicles++;
    return vehicles;
}

public KID_DestroyVehicle(vehicleid)
{
	if( (VehicleInfo[vehicleid][vModel] >= 400) && (VehicleInfo[vehicleid][vModel] <= 611))
	{
    	VehicleInfo[vehicleid][vModel] = 0;
    	VehicleInfo[vehicleid][vPosX] = 0.0;
    	VehicleInfo[vehicleid][vPosY] = 0.0;
    	VehicleInfo[vehicleid][vPosZ] = 0.0;
    	VehicleInfo[vehicleid][vPosZ_Angle] = 0.0;
    	VehicleInfo[vehicleid][vCor1] = 0;
    	VehicleInfo[vehicleid][vCor2] = 0;
    	UsedVSlot[vehicleid] = false;
    	vehicles--;
    	return true;
    }
    return false;
}

public KID_GetVehiclePos(vehicleid, &Float:x, &Float:y, &Float:z)
{
    if( (VehicleInfo[vehicleid][vModel] >= 400) && (VehicleInfo[vehicleid][vModel] <= 611))
	{
		x = VehicleInfo[vehicleid][vPosX];
    	y = VehicleInfo[vehicleid][vPosY];
    	z = VehicleInfo[vehicleid][vPosZ];
    	return true;
    }
    return false;
}

public KID_SetVehiclePos(vehicleid, Float:x, Float:y, Float:z)
{
    if( (VehicleInfo[vehicleid][vModel] >= 400) && (VehicleInfo[vehicleid][vModel] <= 611))
	{
		VehicleInfo[vehicleid][vPosX] = x;
		VehicleInfo[vehicleid][vPosY] = y;
		VehicleInfo[vehicleid][vPosZ] = z;
		return true;
	}
	return false;
}

public KID_GetVehicleZAngle(vehicleid, &Float:z_angle)
{
    if( (VehicleInfo[vehicleid][vModel] >= 400) && (VehicleInfo[vehicleid][vModel] <= 611))
	{
		z_angle = VehicleInfo[vehicleid][vPosZ_Angle];
		return true;
	}
	return false;
}

public KID_SetVehicleZAngle(vehicleid, Float:z_angle)
{
    if( (VehicleInfo[vehicleid][vModel] >= 400) && (VehicleInfo[vehicleid][vModel] <= 611) )
	{
		VehicleInfo[vehicleid][vPosZ_Angle] = z_angle;
		return true;
	}
	return false;
}

public KID_GetVehicleModel(vehicleid)
{
    if( (VehicleInfo[vehicleid][vModel] >= 400) && (VehicleInfo[vehicleid][vModel] <= 611) ) return VehicleInfo[vehicleid][vModel];
    return false;
}

/*
	As funções abaixo não foram criadas
	por mim, e sim modificadas para funcionar somente no meu
	streamer, o verdadeiro criador destas funções
	se chama Andre9977 (http://forum.sa-mp.com/index.php?topic=61574.0)
*/

public KID_IsABike(vehicleid)
{
    new Bikes[] = { 509, 481, 510 };
    for(new i = 0; i < sizeof(Bikes); i++)
    {
    	if(VehicleInfo[vehicleid][vModel] == Bikes[i]) return true;
    }
    return false;
}

public KID_IsAnAirVehicle(vehicleid)
{
	new AirVeh[] = { 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513, 548, 425, 417, 487, 488, 497, 563, 447, 469 };
    for(new i = 0; i < sizeof(AirVeh); i++)
    {
 	   if(VehicleInfo[vehicleid][vModel] == AirVeh[i]) return true;
    }
    return false;
}

public KID_IsAMotorBike(vehicleid)
{
	new Bikes[] = { 509, 481, 510 };
    for(new i = 0; i < sizeof(Bikes); i++)
    {
	    if(VehicleInfo[vehicleid][vModel] == Bikes[i]) return true;
    }
    return false;
}

public KID_IsACopCar(vehicleid)
{
    new Operative[] = { 523, 427, 490, 528, 596, 597, 598, 599 };
    for(new i = 0; i < sizeof(Operative); i++)
    {
		if(VehicleInfo[vehicleid][vModel] == Operative[i]) return true;
    }
    return false;
}

public KID_IsABoat(vehicleid)
{
    new Boats[] = { 472, 473, 493, 495, 484, 430, 454, 453, 452, 446 };
    for(new i = 0; i < sizeof(Boats); i++)
    {
		if(VehicleInfo[vehicleid][vModel] == Boats[i]) return true;
    }
    return false;
}