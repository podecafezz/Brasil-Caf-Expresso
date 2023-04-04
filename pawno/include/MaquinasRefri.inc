/*------------------------------------------------------------------------------
                                        *********************************************
                                                        mLibrary - Machine Library.
                                        *********************************************
Description:
        A library that allows you to add machines sprunks (running) the map.
Version:
        2.0
Developer:
        Luke "Shelby" Godoy.
ChangeLOG:
        14/10/2011:
                Added two new machines.
                Machines are now toggleable between active and desactive.
                Machines recover life can be configurated.
        13/10/2011:
                First release.
Thanks to:
        Y_Less                                                                  - Easy way to hook callbacks
        Equipe SA-MP(past\present\future)               - SAMP.
------------------------------------------------------------------------------*/

#include < a_samp >

#if defined _mLibrary_included
        #endinput
#endif

#define _mLibrary_included
#define MAX_MACHINES    128
#define MACHINE_CANDY   956
#define MACHINE_SPRUNK  955
#define MACHINE_SODA    1302

/*Natives
native CreateMachine(machineid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:life = 35.0, bool:active = true);
native GetXYInFrontOfMachine(machineid, &Float:x, &Float:y, Float:distance);
native GetMachineRotation(machineid, &Float:rx, &Float:ry, &Float:rz);
native SetMachineRotation(machineid, Float:rx, Float:ry, Float:rz);
native GetMachineRotation(machineid, &Float:x, &Float:y, &Float:z);
native SetMachinePos(machineid, Float:x, Float:y, Float:z);
native SetMachineActive(machineid, bool:active);
native GetMachineActive(machineid);
native DeleteMachine(machineid);
native mexist(machineid);*/

enum mlbdef
{
        Float:M_X,
        Float:M_Y,
        Float:M_Z,
        Float:M_RX,
        Float:M_RY,
        Float:M_RZ,
        bool:M_ACTIVE,
        Float:M_LIFE,
        M_ID,
};

static
                gMTotal,
                MACHINES[MAX_MACHINES][mlbdef];

stock
        CreateMachine(machineid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:life = 35.0, bool:active = true)
{
        new MID = SearchMachines();
        if(MID == -1){ print("SCRIPT_ERROR 487: Limite de maquinas foi ultrapassado! (mLibrary.inc)"); return 0;}
        if(machineid == MACHINE_SPRUNK || machineid == MACHINE_SODA || machineid == MACHINE_CANDY){}else{ printf("SCRIPT_ERROR 374: ID da Maquina invalido! (mLibrary.inc) (ID usado: %i - ID valido: 955, 956 ou 1302)", machineid); return 0;}
        MACHINES[MID][M_ID] = CreateObject(machineid, x, y, z, rx, ry, rz, 300.0);
        MACHINES[MID][M_X] = x;
        MACHINES[MID][M_Y] = y;
        MACHINES[MID][M_Z] = z;
        MACHINES[MID][M_RX] = rx;
        MACHINES[MID][M_RY] = ry;
        MACHINES[MID][M_RZ] = rz;
        MACHINES[MID][M_RZ] = rz;
        MACHINES[MID][M_LIFE] = life;
        MACHINES[MID][M_ACTIVE] = active;
        gMTotal++;
        return MID;
}

stock
        DeleteMachine(machineid)
{
        if(!MACHINES[machineid][M_ID]) return 0;
        gMTotal--;
    DestroyObject(MACHINES[machineid][M_ID]);
    MACHINES[machineid][M_ID] = 0;
    return 1;
}

stock
        mexist(machineid) return (!MACHINES[machineid][M_ID]) ? 0 : 1;

stock
        SearchMachines()
{
        for(new m = 1; m < MAX_MACHINES; m++) if(!MACHINES[m][M_ID]) return m;
        return -1;
}

stock
        SetMachinePos(machineid, Float:x, Float:y, Float:z)
{
        if(!MACHINES[machineid][M_ID]) return 0;
        MACHINES[machineid][PBP_X] = x;
        MACHINES[machineid][PBP_Y] = y;
        MACHINES[machineid][PBP_Z] = z;
        return SetObjectPos(MACHINES[machineid][M_ID], x, y, z);
}

stock
        SetMachineRotation(machineid, Float:rx, Float:ry, Float:rz)
{
        if(!MACHINES[machineid][M_ID]) return 0;
        MACHINES[machineid][M_RX] = rx;
        MACHINES[machineid][M_RY] = ry;
        MACHINES[machineid][M_RZ] = rz;
        return SetObjectRot(MACHINES[machineid][M_ID], rx, ry, rz);
}

stock
        GetMachinePos(machineid, &Float:x, &Float:y, &Float:z)
{
        if(!MACHINES[machineid][M_ID])
        {
            x = 0.0;
            y = 0.0;
            z = 0.0;
        }
        x = MACHINES[machineid][M_X];
        y = MACHINES[machineid][M_Y];
        z = MACHINES[machineid][M_Z];
}

stock
        GetMachineRotation(machineid, &Float:rx, &Float:ry, &Float:rz)
{
        if(!MACHINES[machineid][M_ID]){
            rx = 0.0;
            ry = 0.0;
            rz = 0.0;}
        rx = MACHINES[machineid][M_RX];
        ry = MACHINES[machineid][M_RY];
        rz = MACHINES[machineid][M_RZ];
}

stock
        GetXYInFrontOfMachine(machineid, &Float:x, &Float:y, Float:distance)
{
        new
                Float:rotz,
                Float:xs,
                Float:ys,
                Float:zs;
        GetObjectPos(machineid, x, y, zs);
        GetObjectRot(machineid, xs, ys, rotz);
        x += (distance * floatsin(-rotz, degrees));
        y += (distance * floatcos(-rotz, degrees));
}

stock
        SetMachineActive(machineid, bool:active)
{
        if(!MACHINES[machineid][M_ID]) return 0;
        MACHINES[machineid][M_ACTIVE] = active;
}

stock
        GetMachineActive(machineid)
{
        if(!MACHINES[machineid][M_ID]) return 0;
        return MACHINES[machineid][M_ACTIVE];
}

stock
        SetMachineRecover(machineid, Float:life)
{
        if(!MACHINES[machineid][M_ID]) return 0;
        MACHINES[machineid][M_LIFE] = life;
}

stock
        GetMachineRecover(machineid)
{
        if(!MACHINES[machineid][M_ID]) return 0;
        return floatround(MACHINES[machineid][M_LIFE]);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
        if(newkeys == 16)
        {
                new
                        Float:machpos[2];
                for(new m = 1; m <= gMTotal; m++)
                {
                        if(MACHINES[m][M_ID])
                        {
                                if(IsPlayerInRangeOfPoint(playerid, 1.1, MACHINES[m][M_X], MACHINES[m][M_Y], MACHINES[m][M_Z]) && MACHINES[m][M_ACTIVE])
                                {
                                        SetPlayerFacingAngle(playerid, GetXYInFrontOfMachine(m, machpos[0], machpos[1], 1.0));
                                        ApplyAnimation(playerid, "VENDING", "VEND_USE", 10.0, 0, 0, 0, 0, 0, 1);
                                        new Float:MyHealth;
                                        GetPlayerHealth(playerid, MyHealth);
                                        if (MyHealth+MACHINES[m][M_LIFE] < 100)
                                        {
                                                SetPlayerHealth(playerid, MyHealth+MACHINES[m][M_LIFE]);
                                        }
                                        else
                                        {
                                                SetPlayerHealth(playerid, 100);
                                        }
                                }
                        }
                }
        }
        return CallLocalFunction("mLibrary_OnPlayerKeyStateChange", "");
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange mLibrary_OnPlayerKeyStateChange
forward mLibrary_OnPlayerKeyStateChange();
