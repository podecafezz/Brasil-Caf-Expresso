/*					
					********************************
						nLibrary - Neon Library
					********************************
Description:
	Allows you to attach neons to the selected vehicle.
Version:
	1.5
Developer:
	Luke "Shelby" Godoy.
ChangeLOG:
	20/10/2011:
		Small fixes.
	20/06/2011:
		Buzzer can be used with neons.
	19/06/2011:
		Buzzer(neon) available for attachment.
	18/06/2011:
		Improvement in the speed of the functions 'GetVehicleNeonColor' & 'IsVehicleUsingNeon'
		Thanks to: ScripterTroll.
		Changes in native 'IsVehicleUsingNeon'.
	17/06/2011:
		First version.
Thanks To:
	CiNyC - Insanity Vehicle Attachment Editor
Natives:
	native AttachNeonToVehicle(vehicleid, neonid);
	native RemoveNeonFromVehicle(vehicleid);
	native IsVehicleUsingNeon(vehicleid);
	native GetVehicleNeonColor(vehicleid);
	native IsVehicleUsingBuzzer(vehicleid);
	native RemoveBuzzerFromVehicle(vehicleid);
*/

#include <a_samp>
#if defined _nLibrary_included
	#endinput
#endif

#define _nLibrary_included
#define NEON_BLUE 								(0)
#define NEON_PINK 								(1)
#define NEON_YELLOW 							(2)
#define NEON_GREEN	 							(3)
#define NEON_RED								(4)
#define NEON_WHITE								(5)
#define NEON_POLICE								(6)

#define GetVehicleNeonColor(%0) NEON_COR[%0]
#define IsVehicleUsingNeon(%0) IsValidObject(NEON_ONE[%0])
#define IsVehicleUsingBuzzer(%0) IsValidObject(NEON_THR[%0])
#define RemoveBuzzerFromVehicle(%0); DestroyObject(NEON_THR[%0]); \ 
NEON_THR[%0] = INVALID_OBJECT_ID;

new NEON_ONE[MAX_VEHICLES] = {INVALID_OBJECT_ID, ...};
new NEON_TWO[MAX_VEHICLES] = {INVALID_OBJECT_ID, ...};
new NEON_THR[MAX_VEHICLES] = {INVALID_OBJECT_ID, ...};
new NEON_COR[MAX_VEHICLES][10];

stock Bike(vehicleid)
{   
	new model = GetVehicleModel(vehicleid);
 	if(model == 522 || model == 462 || model == 521 || model == 461 || model == 463 || model == 581 || model == 448 || model == 586 || model == 523 || model == 468 || model == 471 || model == 509 || model == 510 || model == 481) return 1;
	return 0;
}

stock AttachNeonToVehicle(vehicleid, neonid /*, playerid = INVALID_PLAYER_ID*/ )
{
    switch(neonid)
    {
		case NEON_BLUE:
		{
			DestroyObject(NEON_ONE[vehicleid]); DestroyObject(NEON_TWO[vehicleid]);
			if(Bike(vehicleid)){NEON_ONE[vehicleid] = CreateObject(18648,0,0,0,0,0,0); AttachObjectToVehicle(NEON_ONE[vehicleid], vehicleid, 0.0, 0.0, -0.70, 0.0, 0.0, 0.0); NEON_TWO[vehicleid] = INVALID_OBJECT_ID; return 1;}
			NEON_ONE[vehicleid] = CreateObject(18648,0,0,0,0,0,0); NEON_TWO[vehicleid] = CreateObject(18648,0,0,0,0,0,0);
			AttachObjectToVehicle(NEON_ONE[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0); 
			AttachObjectToVehicle(NEON_TWO[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			NEON_COR[vehicleid] = "Blue";
			return 1;
		}
		case NEON_PINK:
		{
			DestroyObject(NEON_ONE[vehicleid]); DestroyObject(NEON_TWO[vehicleid]);
			if(Bike(vehicleid)){NEON_ONE[vehicleid] = CreateObject(18651,0,0,0,0,0,0); AttachObjectToVehicle(NEON_ONE[vehicleid], vehicleid, 0.0, 0.0, -0.70, 0.0, 0.0, 0.0); NEON_TWO[vehicleid] = INVALID_OBJECT_ID; return 1;}
			NEON_ONE[vehicleid] = CreateObject(18651,0,0,0,0,0,0); NEON_TWO[vehicleid] = CreateObject(18651,0,0,0,0,0,0);
			AttachObjectToVehicle(NEON_ONE[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0); 
			AttachObjectToVehicle(NEON_TWO[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			NEON_COR[vehicleid] = "Pink";
			return 1;
		}
		case NEON_YELLOW:
		{
			DestroyObject(NEON_ONE[vehicleid]); DestroyObject(NEON_TWO[vehicleid]);
			if(Bike(vehicleid)){NEON_ONE[vehicleid] = CreateObject(18650,0,0,0,0,0,0); AttachObjectToVehicle(NEON_ONE[vehicleid], vehicleid, 0.0, 0.0, -0.70, 0.0, 0.0, 0.0); NEON_TWO[vehicleid] = INVALID_OBJECT_ID; return 1;}
			NEON_ONE[vehicleid] = CreateObject(18650,0,0,0,0,0,0); NEON_TWO[vehicleid] = CreateObject(18650,0,0,0,0,0,0);
			AttachObjectToVehicle(NEON_ONE[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0); 
			AttachObjectToVehicle(NEON_TWO[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			NEON_COR[vehicleid] = "Yellow";
			return 1;
		}
		case NEON_GREEN:
		{
			DestroyObject(NEON_ONE[vehicleid]); DestroyObject(NEON_TWO[vehicleid]);
			if(Bike(vehicleid)){NEON_ONE[vehicleid] = CreateObject(18649,0,0,0,0,0,0); AttachObjectToVehicle(NEON_ONE[vehicleid], vehicleid, 0.0, 0.0, -0.70, 0.0, 0.0, 0.0); NEON_TWO[vehicleid] = INVALID_OBJECT_ID; return 1;}
			NEON_ONE[vehicleid] = CreateObject(18649,0,0,0,0,0,0); NEON_TWO[vehicleid] = CreateObject(18649,0,0,0,0,0,0);
			AttachObjectToVehicle(NEON_ONE[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0); 
			AttachObjectToVehicle(NEON_TWO[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			NEON_COR[vehicleid] = "Green";
			return 1;
		}
		case NEON_RED:
		{
			DestroyObject(NEON_ONE[vehicleid]); DestroyObject(NEON_TWO[vehicleid]);
			if(Bike(vehicleid)){NEON_ONE[vehicleid] = CreateObject(18647,0,0,0,0,0,0); AttachObjectToVehicle(NEON_ONE[vehicleid], vehicleid, 0.0, 0.0, -0.70, 0.0, 0.0, 0.0); NEON_TWO[vehicleid] = INVALID_OBJECT_ID; return 1;}
			NEON_ONE[vehicleid] = CreateObject(18647,0,0,0,0,0,0); NEON_TWO[vehicleid] = CreateObject(18647,0,0,0,0,0,0);
			AttachObjectToVehicle(NEON_ONE[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0); 
			AttachObjectToVehicle(NEON_TWO[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			NEON_COR[vehicleid] = "Red";
			return 1;
		}
		case NEON_WHITE:
		{
			DestroyObject(NEON_ONE[vehicleid]); DestroyObject(NEON_TWO[vehicleid]);
			if(Bike(vehicleid)){NEON_ONE[vehicleid] = CreateObject(18652,0,0,0,0,0,0); AttachObjectToVehicle(NEON_ONE[vehicleid], vehicleid, 0.0, 0.0, -0.70, 0.0, 0.0, 0.0); NEON_TWO[vehicleid] = INVALID_OBJECT_ID; return 1;}
			NEON_ONE[vehicleid] = CreateObject(18652,0,0,0,0,0,0); NEON_TWO[vehicleid] = CreateObject(18652,0,0,0,0,0,0);
			AttachObjectToVehicle(NEON_ONE[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0); 
			AttachObjectToVehicle(NEON_TWO[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			NEON_COR[vehicleid] = "White";
			return 1;
		}
		case NEON_POLICE:
		{
			if(Bike(vehicleid)){NEON_THR[vehicleid] = CreateObject(18646,0,0,0,0,0,0); AttachObjectToVehicle(NEON_THR[vehicleid], vehicleid, 0.014999, 0.724999, 0.669999, 0.0, 0.0, 0.0); return 1;}
			NEON_THR[vehicleid] = CreateObject(18646,0,0,0,0,0,0);
			AttachObjectToVehicle(NEON_THR[vehicleid], vehicleid, -0.5, -0.2, 0.8, 2.0, 2.0, 3.0); 
			return 1;
		}
		default:
		{
			/*if(playerid != INVALID_PLAYER_ID) SendClientMessage(playerid, 0xA9C4E4FF, "Cor do neon inválida.");*/
			print("ERROR: Invalid neon color.");
		}
    }
    return 1;
}

stock RemoveNeonFromVehicle(vehicleid)
{
    DestroyObject(NEON_ONE[vehicleid]);
    DestroyObject(NEON_TWO[vehicleid]);
	NEON_ONE[vehicleid] = INVALID_OBJECT_ID;
	NEON_TWO[vehicleid] = INVALID_OBJECT_ID;
	NEON_COR[vehicleid] = "None";
    return 1;
}