/*  Dten Tunning Functions
 *
 *  (c) Copyright 2012-2012, Dten Team
 *
 */

#if defined _tunning_included
	#endinput
#endif
#define _tunning_included
#pragma library tunning

#define nitro 1010
#define rodawire 1080
#define suspensao 1087

/*
native ChangeVehicleNeon(vehicleid, neonid);
native ChangeVehicleSubwoofer(vehicleid, subwooferid);
native AutoTunningRun(vehicleid);
native AutoTunningRemove(vehicleid);
*/

new bool:NeonALready[MAX_VEHICLES][6];
new bool:SubALready[MAX_VEHICLES][5];
new Neon[MAX_VEHICLES][12];
new Sub[MAX_VEHICLES][6];

stock ChangeVehicleNeon(vehicleid, neonid)
{
	if(neonid == 0)
	{
		if(NeonALready[vehicleid][0] == false)
		{
			NeonALready[vehicleid][0] = true;
			NeonALready[vehicleid][1] = false;
			NeonALready[vehicleid][2] = false;
			NeonALready[vehicleid][3] = false;
			NeonALready[vehicleid][4] = false;
			NeonALready[vehicleid][5] = false;

			if(IsValidDynamicObject(Neon[vehicleid][2]) &&
				IsValidDynamicObject(Neon[vehicleid][3]))
			{
				DestroyDynamicObject(Neon[vehicleid][2]);
				DestroyDynamicObject(Neon[vehicleid][3]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][4]) &&
				IsValidDynamicObject(Neon[vehicleid][5]))
			{
				DestroyDynamicObject(Neon[vehicleid][4]);
				DestroyDynamicObject(Neon[vehicleid][5]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][6]) &&
				IsValidDynamicObject(Neon[vehicleid][7]))
			{
				DestroyDynamicObject(Neon[vehicleid][6]);
				DestroyDynamicObject(Neon[vehicleid][7]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][8]) &&
				IsValidDynamicObject(Neon[vehicleid][9]))
			{
				DestroyDynamicObject(Neon[vehicleid][8]);
				DestroyDynamicObject(Neon[vehicleid][9]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][10]) &&
				IsValidDynamicObject(Neon[vehicleid][11]))
			{
				DestroyDynamicObject(Neon[vehicleid][10]);
				DestroyDynamicObject(Neon[vehicleid][11]);
			}
			Neon[vehicleid][0] = CreateDynamicObject(18648, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Neon[vehicleid][1] = CreateDynamicObject(18648, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][0], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][1], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	if(neonid == 1)
	{
		if(NeonALready[vehicleid][1] == false)
		{
			NeonALready[vehicleid][0] = false;
			NeonALready[vehicleid][1] = true;
			NeonALready[vehicleid][2] = false;
			NeonALready[vehicleid][3] = false;
			NeonALready[vehicleid][4] = false;
			NeonALready[vehicleid][5] = false;

			if(IsValidDynamicObject(Neon[vehicleid][0]) &&
				IsValidDynamicObject(Neon[vehicleid][1]))
			{
				DestroyDynamicObject(Neon[vehicleid][0]);
				DestroyDynamicObject(Neon[vehicleid][1]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][4]) &&
				IsValidDynamicObject(Neon[vehicleid][5]))
			{
				DestroyDynamicObject(Neon[vehicleid][4]);
				DestroyDynamicObject(Neon[vehicleid][5]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][6]) &&
				IsValidDynamicObject(Neon[vehicleid][7]))
			{
				DestroyDynamicObject(Neon[vehicleid][6]);
				DestroyDynamicObject(Neon[vehicleid][7]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][8]) &&
				IsValidDynamicObject(Neon[vehicleid][9]))
			{
				DestroyDynamicObject(Neon[vehicleid][8]);
				DestroyDynamicObject(Neon[vehicleid][9]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][10]) &&
				IsValidDynamicObject(Neon[vehicleid][11]))
			{
				DestroyDynamicObject(Neon[vehicleid][10]);
				DestroyDynamicObject(Neon[vehicleid][11]);
			}
			Neon[vehicleid][2] = CreateDynamicObject(18649, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Neon[vehicleid][3] = CreateDynamicObject(18649, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][2], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][3], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	if(neonid == 2)
	{
		if(NeonALready[vehicleid][2] == false)
		{
			NeonALready[vehicleid][0] = false;
			NeonALready[vehicleid][1] = false;
			NeonALready[vehicleid][2] = true;
			NeonALready[vehicleid][3] = false;
			NeonALready[vehicleid][4] = false;
			NeonALready[vehicleid][5] = false;

			if(IsValidDynamicObject(Neon[vehicleid][0]) &&
				IsValidDynamicObject(Neon[vehicleid][1]))
			{
				DestroyDynamicObject(Neon[vehicleid][0]);
				DestroyDynamicObject(Neon[vehicleid][1]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][2]) &&
				IsValidDynamicObject(Neon[vehicleid][3]))
			{
				DestroyDynamicObject(Neon[vehicleid][2]);
				DestroyDynamicObject(Neon[vehicleid][3]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][6]) &&
				IsValidDynamicObject(Neon[vehicleid][7]))
			{
				DestroyDynamicObject(Neon[vehicleid][6]);
				DestroyDynamicObject(Neon[vehicleid][7]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][8]) &&
				IsValidDynamicObject(Neon[vehicleid][9]))
			{
				DestroyDynamicObject(Neon[vehicleid][8]);
				DestroyDynamicObject(Neon[vehicleid][9]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][10]) &&
				IsValidDynamicObject(Neon[vehicleid][11]))
			{
				DestroyDynamicObject(Neon[vehicleid][10]);
				DestroyDynamicObject(Neon[vehicleid][11]);
			}
			Neon[vehicleid][4] = CreateDynamicObject(18647, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Neon[vehicleid][5] = CreateDynamicObject(18647, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][4], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][5], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	if(neonid == 3)
	{
		if(NeonALready[vehicleid][3] == false)
		{
			NeonALready[vehicleid][0] = false;
			NeonALready[vehicleid][1] = false;
			NeonALready[vehicleid][2] = false;
			NeonALready[vehicleid][3] = true;
			NeonALready[vehicleid][4] = false;
			NeonALready[vehicleid][5] = false;

			if(IsValidDynamicObject(Neon[vehicleid][0]) &&
				IsValidDynamicObject(Neon[vehicleid][1]))
			{
				DestroyDynamicObject(Neon[vehicleid][0]);
				DestroyDynamicObject(Neon[vehicleid][1]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][2]) &&
				IsValidDynamicObject(Neon[vehicleid][3]))
			{
				DestroyDynamicObject(Neon[vehicleid][2]);
				DestroyDynamicObject(Neon[vehicleid][3]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][4]) &&
				IsValidDynamicObject(Neon[vehicleid][5]))
			{
				DestroyDynamicObject(Neon[vehicleid][4]);
				DestroyDynamicObject(Neon[vehicleid][5]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][8]) &&
				IsValidDynamicObject(Neon[vehicleid][9]))
			{
				DestroyDynamicObject(Neon[vehicleid][8]);
				DestroyDynamicObject(Neon[vehicleid][9]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][10]) &&
				IsValidDynamicObject(Neon[vehicleid][11]))
			{
				DestroyDynamicObject(Neon[vehicleid][10]);
				DestroyDynamicObject(Neon[vehicleid][11]);
			}
			Neon[vehicleid][6] = CreateDynamicObject(18650, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Neon[vehicleid][7] = CreateDynamicObject(18650, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][6], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][7], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	if(neonid == 4)
	{
		if(NeonALready[vehicleid][4] == false)
		{
			NeonALready[vehicleid][0] = false;
			NeonALready[vehicleid][1] = false;
			NeonALready[vehicleid][2] = false;
			NeonALready[vehicleid][3] = false;
			NeonALready[vehicleid][4] = true;
			NeonALready[vehicleid][5] = false;

			if(IsValidDynamicObject(Neon[vehicleid][0]) &&
				IsValidDynamicObject(Neon[vehicleid][1]))
			{
				DestroyDynamicObject(Neon[vehicleid][0]);
				DestroyDynamicObject(Neon[vehicleid][1]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][2]) &&
				IsValidDynamicObject(Neon[vehicleid][3]))
			{
				DestroyDynamicObject(Neon[vehicleid][2]);
				DestroyDynamicObject(Neon[vehicleid][3]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][4]) &&
				IsValidDynamicObject(Neon[vehicleid][5]))
			{
				DestroyDynamicObject(Neon[vehicleid][4]);
				DestroyDynamicObject(Neon[vehicleid][5]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][6]) &&
				IsValidDynamicObject(Neon[vehicleid][7]))
			{
				DestroyDynamicObject(Neon[vehicleid][6]);
				DestroyDynamicObject(Neon[vehicleid][7]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][10]) &&
				IsValidDynamicObject(Neon[vehicleid][11]))
			{
				DestroyDynamicObject(Neon[vehicleid][10]);
				DestroyDynamicObject(Neon[vehicleid][11]);
			}
			Neon[vehicleid][8] = CreateDynamicObject(18652, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Neon[vehicleid][9] = CreateDynamicObject(18652, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][8], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][9], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	if(neonid == 5)
	{
		if(NeonALready[vehicleid][5] == false)
		{
			NeonALready[vehicleid][0] = false;
			NeonALready[vehicleid][1] = false;
			NeonALready[vehicleid][2] = false;
			NeonALready[vehicleid][3] = false;
			NeonALready[vehicleid][4] = false;
			NeonALready[vehicleid][5] = true;

			if(IsValidDynamicObject(Neon[vehicleid][0]) &&
				IsValidDynamicObject(Neon[vehicleid][1]))
			{
				DestroyDynamicObject(Neon[vehicleid][0]);
				DestroyDynamicObject(Neon[vehicleid][1]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][2]) &&
				IsValidDynamicObject(Neon[vehicleid][3]))
			{
				DestroyDynamicObject(Neon[vehicleid][2]);
				DestroyDynamicObject(Neon[vehicleid][3]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][4]) &&
				IsValidDynamicObject(Neon[vehicleid][5]))
			{
				DestroyDynamicObject(Neon[vehicleid][4]);
				DestroyDynamicObject(Neon[vehicleid][5]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][6]) &&
				IsValidDynamicObject(Neon[vehicleid][7]))
			{
				DestroyDynamicObject(Neon[vehicleid][6]);
				DestroyDynamicObject(Neon[vehicleid][7]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][8]) &&
				IsValidDynamicObject(Neon[vehicleid][9]))
			{
				DestroyDynamicObject(Neon[vehicleid][8]);
				DestroyDynamicObject(Neon[vehicleid][9]);
			}
			Neon[vehicleid][10] = CreateDynamicObject(18651, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Neon[vehicleid][11] = CreateDynamicObject(18651, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][10], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][11], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	if(neonid == 6)
	{
		if(IsValidDynamicObject(Neon[vehicleid][0]) &&
			IsValidDynamicObject(Neon[vehicleid][1]))
		{
			DestroyDynamicObject(Neon[vehicleid][0]);
			DestroyDynamicObject(Neon[vehicleid][1]);
		}
		if(IsValidDynamicObject(Neon[vehicleid][2]) &&
			IsValidDynamicObject(Neon[vehicleid][3]))
		{
			DestroyDynamicObject(Neon[vehicleid][2]);
			DestroyDynamicObject(Neon[vehicleid][3]);
		}
		if(IsValidDynamicObject(Neon[vehicleid][4]) &&
			IsValidDynamicObject(Neon[vehicleid][5]))
		{
			DestroyDynamicObject(Neon[vehicleid][4]);
			DestroyDynamicObject(Neon[vehicleid][5]);
		}
		if(IsValidDynamicObject(Neon[vehicleid][6]) &&
			IsValidDynamicObject(Neon[vehicleid][7]))
		{
			DestroyDynamicObject(Neon[vehicleid][6]);
			DestroyDynamicObject(Neon[vehicleid][7]);
		}
		if(IsValidDynamicObject(Neon[vehicleid][8]) &&
			IsValidDynamicObject(Neon[vehicleid][9]))
		{
			DestroyDynamicObject(Neon[vehicleid][8]);
			DestroyDynamicObject(Neon[vehicleid][9]);
		}
		if(IsValidDynamicObject(Neon[vehicleid][10]) &&
			IsValidDynamicObject(Neon[vehicleid][11]))
		{
			DestroyDynamicObject(Neon[vehicleid][10]);
			DestroyDynamicObject(Neon[vehicleid][11]);
		}
	}
	return 1;
}

stock ChangeVehicleSubwoofer(vehicleid, subwooferid)
{
	if(subwooferid == 0)																		   // Super Subwoofer
	{
		if(SubALready[vehicleid][0] == false)
		{
			SubALready[vehicleid][0] = true;
			SubALready[vehicleid][1] = false;
			SubALready[vehicleid][2] = false;
			SubALready[vehicleid][3] = false;
			SubALready[vehicleid][4] = false;

			if(IsValidDynamicObject(Sub[vehicleid][1]) && IsValidDynamicObject(Sub[vehicleid][2]))
			{
				DestroyDynamicObject(Sub[vehicleid][1]);
				DestroyDynamicObject(Sub[vehicleid][2]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][3]))
			{
				DestroyDynamicObject(Sub[vehicleid][3]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][4]))
			{
				DestroyDynamicObject(Sub[vehicleid][4]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][5]))
			{
				DestroyDynamicObject(Sub[vehicleid][5]);
			}
			Sub[vehicleid][0] = CreateDynamicObject(2232, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Sub[vehicleid][0], vehicleid, 0.025002, -1.729998, -0.020000, -74.369995, 87.133476, -3.015000);
		}
	}
	if(subwooferid == 1)																		   // Medium Subwoofer
	{
		if(SubALready[vehicleid][1] == false)
		{
			SubALready[vehicleid][0] = false;
			SubALready[vehicleid][1] = true;
			SubALready[vehicleid][2] = false;
			SubALready[vehicleid][3] = false;
			SubALready[vehicleid][4] = false;

			if(IsValidDynamicObject(Sub[vehicleid][0]))
			{
				DestroyDynamicObject(Sub[vehicleid][0]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][3]))
			{
				DestroyDynamicObject(Sub[vehicleid][3]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][4]))
			{
				DestroyDynamicObject(Sub[vehicleid][4]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][5]))
			{
				DestroyDynamicObject(Sub[vehicleid][5]);
			}
			Sub[vehicleid][1] = CreateDynamicObject(2231, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Sub[vehicleid][2] = CreateDynamicObject(2231, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Sub[vehicleid][1], vehicleid, -0.039997, -2.190002, -0.229999, -85.424964, 84.419967, -6.030000);
			AttachDynamicObjectToVehicle(Sub[vehicleid][2], vehicleid, -0.829996, -2.190002, -0.229999, -85.424964, 84.419967, -6.030000);
		}
	}
	if(subwooferid == 2)																		   // Normal Subwoofer
	{
		if(SubALready[vehicleid][2] == false)
		{
			SubALready[vehicleid][0] = false;
			SubALready[vehicleid][1] = false;
			SubALready[vehicleid][2] = true;
			SubALready[vehicleid][3] = false;
			SubALready[vehicleid][4] = false;

			if(IsValidDynamicObject(Sub[vehicleid][0]))
			{
				DestroyDynamicObject(Sub[vehicleid][0]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][1]) && IsValidDynamicObject(Sub[vehicleid][2]))
			{
				DestroyDynamicObject(Sub[vehicleid][1]);
				DestroyDynamicObject(Sub[vehicleid][2]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][4]))
			{
				DestroyDynamicObject(Sub[vehicleid][4]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][5]))
			{
				DestroyDynamicObject(Sub[vehicleid][5]);
			}
			Sub[vehicleid][3] = CreateDynamicObject(2230, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Sub[vehicleid][3], vehicleid, -0.664996, -2.190002, -0.229999, -85.424964, 84.419967, -6.030000);
		}
	}
	if(subwooferid == 3)																		   // Sub 1
	{
		if(SubALready[vehicleid][3] == false)
		{
			SubALready[vehicleid][0] = false;
			SubALready[vehicleid][1] = false;
			SubALready[vehicleid][2] = false;
			SubALready[vehicleid][3] = true;
			SubALready[vehicleid][4] = false;

			if(IsValidDynamicObject(Sub[vehicleid][0]))
			{
				DestroyDynamicObject(Sub[vehicleid][0]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][1]) && IsValidDynamicObject(Sub[vehicleid][2]))
			{
				DestroyDynamicObject(Sub[vehicleid][1]);
				DestroyDynamicObject(Sub[vehicleid][2]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][3]))
			{
				DestroyDynamicObject(Sub[vehicleid][3]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][5]))
			{
				DestroyDynamicObject(Sub[vehicleid][5]);
			}
			Sub[vehicleid][4] = CreateDynamicObject(2229, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Sub[vehicleid][4], vehicleid, -0.649996, -2.190002, -0.229999, -85.424964, 84.419967, -6.030000);
		}
	}
	if(subwooferid == 4)																		   // Sub 2
	{
		if(SubALready[vehicleid][4] == false)
		{
			SubALready[vehicleid][0] = false;
			SubALready[vehicleid][1] = false;
			SubALready[vehicleid][2] = false;
			SubALready[vehicleid][3] = false;
			SubALready[vehicleid][4] = true;

			if(IsValidDynamicObject(Sub[vehicleid][0]))
			{
				DestroyDynamicObject(Sub[vehicleid][0]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][1]) && IsValidDynamicObject(Sub[vehicleid][2]))
			{
				DestroyDynamicObject(Sub[vehicleid][1]);
				DestroyDynamicObject(Sub[vehicleid][2]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][3]))
			{
				DestroyDynamicObject(Sub[vehicleid][3]);
			}
			if(IsValidDynamicObject(Sub[vehicleid][4]))
			{
				DestroyDynamicObject(Sub[vehicleid][4]);
			}
			Sub[vehicleid][5] = CreateDynamicObject(1840, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Sub[vehicleid][5], vehicleid, -0.264997, -1.639998, 0.105000, 29.144989, 89.444953, 0.000000);
		}
	}
	if(subwooferid == 5)
	{
		if(IsValidDynamicObject(Sub[vehicleid][0]))
		{
			DestroyDynamicObject(Sub[vehicleid][0]);
		}
		if(IsValidDynamicObject(Sub[vehicleid][1]) && IsValidDynamicObject(Sub[vehicleid][2]))
		{
			DestroyDynamicObject(Sub[vehicleid][1]);
			DestroyDynamicObject(Sub[vehicleid][2]);
		}
		if(IsValidDynamicObject(Sub[vehicleid][3]))
		{
			DestroyDynamicObject(Sub[vehicleid][3]);
		}
		if(IsValidDynamicObject(Sub[vehicleid][4]))
		{
			DestroyDynamicObject(Sub[vehicleid][4]);
		}
		if(IsValidDynamicObject(Sub[vehicleid][5]))
		{
			DestroyDynamicObject(Sub[vehicleid][5]);
		}
	}
	return 1;
}

stock AutoTunningRun(vehicleid)
{
	if(GetVehicleModel(vehicleid) == 562)
	{
		AddVehicleComponent(vehicleid, 1046);
		AddVehicleComponent(vehicleid, 1171);
		AddVehicleComponent(vehicleid, 1149);
		AddVehicleComponent(vehicleid, 1035);
		AddVehicleComponent(vehicleid, 1147);
		AddVehicleComponent(vehicleid, 1036);
		AddVehicleComponent(vehicleid, 1040);
		AddVehicleComponent(vehicleid, nitro);
		AddVehicleComponent(vehicleid, rodawire);
		AddVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 2);
	}
	if(GetVehicleModel(vehicleid) == 560)
	{
		AddVehicleComponent(vehicleid, 1028);
		AddVehicleComponent(vehicleid, 1169);
		AddVehicleComponent(vehicleid, 1141);
		AddVehicleComponent(vehicleid, 1032);
		AddVehicleComponent(vehicleid, 1138);
		AddVehicleComponent(vehicleid, 1026);
		AddVehicleComponent(vehicleid, 1027);
		AddVehicleComponent(vehicleid, nitro);
		AddVehicleComponent(vehicleid, rodawire);
		AddVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 2);
	}
	if(GetVehicleModel(vehicleid) == 565)
	{
		AddVehicleComponent(vehicleid, 1046);
		AddVehicleComponent(vehicleid, 1153);
		AddVehicleComponent(vehicleid, 1150);
		AddVehicleComponent(vehicleid, 1054);
		AddVehicleComponent(vehicleid, 1049);
		AddVehicleComponent(vehicleid, 1047);
		AddVehicleComponent(vehicleid, 1051);
		AddVehicleComponent(vehicleid, nitro);
		AddVehicleComponent(vehicleid, rodawire);
		AddVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 2);
	}
	if(GetVehicleModel(vehicleid) == 559)
	{
		AddVehicleComponent(vehicleid, 1065);
		AddVehicleComponent(vehicleid, 1160);
		AddVehicleComponent(vehicleid, 1159);
		AddVehicleComponent(vehicleid, 1067);
		AddVehicleComponent(vehicleid, 1162);
		AddVehicleComponent(vehicleid, 1069);
		AddVehicleComponent(vehicleid, 1071);
		AddVehicleComponent(vehicleid, nitro);
		AddVehicleComponent(vehicleid, rodawire);
		AddVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 1);
	}
	if(GetVehicleModel(vehicleid) == 561)
	{
		AddVehicleComponent(vehicleid, 1064);
		AddVehicleComponent(vehicleid, 1155);
		AddVehicleComponent(vehicleid, 1154);
		AddVehicleComponent(vehicleid, 1055);
		AddVehicleComponent(vehicleid, 1158);
		AddVehicleComponent(vehicleid, 1056);
		AddVehicleComponent(vehicleid, 1062);
		AddVehicleComponent(vehicleid, nitro);
		AddVehicleComponent(vehicleid, rodawire);
		AddVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 2);
	}
	if(GetVehicleModel(vehicleid) == 558)
	{
		AddVehicleComponent(vehicleid, 1089);
		AddVehicleComponent(vehicleid, 1166);
		AddVehicleComponent(vehicleid, 1168);
		AddVehicleComponent(vehicleid, 1088);
		AddVehicleComponent(vehicleid, 1164);
		AddVehicleComponent(vehicleid, 1090);
		AddVehicleComponent(vehicleid, 1094);
		AddVehicleComponent(vehicleid, nitro);
		AddVehicleComponent(vehicleid, rodawire);
		AddVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 2);
	}
	if(GetVehicleModel(vehicleid) == 575)
	{
		AddVehicleComponent(vehicleid, 1044);
		AddVehicleComponent(vehicleid, 1174);
		AddVehicleComponent(vehicleid, 1176);
		AddVehicleComponent(vehicleid, 1042);
		AddVehicleComponent(vehicleid, 1099);
		AddVehicleComponent(vehicleid, nitro);
		AddVehicleComponent(vehicleid, rodawire);
		AddVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 0);
	}
	if(GetVehicleModel(vehicleid) == 534)
	{
		AddVehicleComponent(vehicleid, 1126);
		AddVehicleComponent(vehicleid, 1179);
		AddVehicleComponent(vehicleid, 1180);
		AddVehicleComponent(vehicleid, 1122);
		AddVehicleComponent(vehicleid, 1101);
		AddVehicleComponent(vehicleid, 1125);
		AddVehicleComponent(vehicleid, 1123);
		AddVehicleComponent(vehicleid, 1100);
		AddVehicleComponent(vehicleid, nitro);
		AddVehicleComponent(vehicleid, rodawire);
		AddVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 2);
	}
	if(GetVehicleModel(vehicleid) == 536)
	{
		AddVehicleComponent(vehicleid, 1104);
		AddVehicleComponent(vehicleid, 1182);
		AddVehicleComponent(vehicleid, 1184);
		AddVehicleComponent(vehicleid, 1108);
		AddVehicleComponent(vehicleid, 1107);
		AddVehicleComponent(vehicleid, nitro);
		AddVehicleComponent(vehicleid, rodawire);
		AddVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 1);
	}
	if(GetVehicleModel(vehicleid) == 567)
	{
		AddVehicleComponent(vehicleid, 1129);
		AddVehicleComponent(vehicleid, 1189);
		AddVehicleComponent(vehicleid, 1187);
		AddVehicleComponent(vehicleid, 1102);
		AddVehicleComponent(vehicleid, 1133);
		AddVehicleComponent(vehicleid, nitro);
		AddVehicleComponent(vehicleid, rodawire);
		AddVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 2);
	}
	if(GetVehicleModel(vehicleid) == 420)
	{
		AddVehicleComponent(vehicleid, 1010);
		AddVehicleComponent(vehicleid, 1087);
		AddVehicleComponent(vehicleid, 1081);
		AddVehicleComponent(vehicleid, 1139);
	}
	if(GetVehicleModel(vehicleid) == 400)
	{
		AddVehicleComponent(vehicleid, 1010);
		AddVehicleComponent(vehicleid, 1087);
		AddVehicleComponent(vehicleid, 1018);
		AddVehicleComponent(vehicleid, 1013);
		AddVehicleComponent(vehicleid, 1081);
		AddVehicleComponent(vehicleid, 1086);
	}
	if(GetVehicleModel(vehicleid) == 401)
	{
		AddVehicleComponent(vehicleid, 1086);
		AddVehicleComponent(vehicleid, 1139);
		AddVehicleComponent(vehicleid, 1081);
		AddVehicleComponent(vehicleid, 1010);
		AddVehicleComponent(vehicleid, 1087);
		AddVehicleComponent(vehicleid, 1012);
		AddVehicleComponent(vehicleid, 1013);
		AddVehicleComponent(vehicleid, 1042);
		AddVehicleComponent(vehicleid, 1043);
		AddVehicleComponent(vehicleid, 1018);
		AddVehicleComponent(vehicleid, 1006);
		AddVehicleComponent(vehicleid, 1007);
		AddVehicleComponent(vehicleid, 1017);
	}
	if(GetVehicleModel(vehicleid) == 576)
	{
		AddVehicleComponent(vehicleid, 1191);
		AddVehicleComponent(vehicleid, 1193);
		AddVehicleComponent(vehicleid, 1010);
		AddVehicleComponent(vehicleid, 1018);
		AddVehicleComponent(vehicleid, 1081);
		AddVehicleComponent(vehicleid, 1087);
		AddVehicleComponent(vehicleid, 1134);
		AddVehicleComponent(vehicleid, 1137);
		ChangeVehiclePaintjob(vehicleid, 2);
	}
	else
	{
		AddVehicleComponent(vehicleid, nitro);
		AddVehicleComponent(vehicleid, rodawire);
		AddVehicleComponent(vehicleid, suspensao);
	}
	return 1;
}

stock AutoTunningRemove(vehicleid)
{
	if(GetVehicleModel(vehicleid) == 562)
	{
		RemoveVehicleComponent(vehicleid, 1046);
		RemoveVehicleComponent(vehicleid, 1171);
		RemoveVehicleComponent(vehicleid, 1149);
		RemoveVehicleComponent(vehicleid, 1035);
		RemoveVehicleComponent(vehicleid, 1147);
		RemoveVehicleComponent(vehicleid, 1036);
		RemoveVehicleComponent(vehicleid, 1040);
		RemoveVehicleComponent(vehicleid, nitro);
		RemoveVehicleComponent(vehicleid, rodawire);
		RemoveVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 3);
	}
	if(GetVehicleModel(vehicleid) == 560)
	{
		RemoveVehicleComponent(vehicleid, 1028);
		RemoveVehicleComponent(vehicleid, 1169);
		RemoveVehicleComponent(vehicleid, 1141);
		RemoveVehicleComponent(vehicleid, 1032);
		RemoveVehicleComponent(vehicleid, 1138);
		RemoveVehicleComponent(vehicleid, 1026);
		RemoveVehicleComponent(vehicleid, 1027);
		RemoveVehicleComponent(vehicleid, nitro);
		RemoveVehicleComponent(vehicleid, rodawire);
		RemoveVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 3);
	}
	if(GetVehicleModel(vehicleid) == 565)
	{
		RemoveVehicleComponent(vehicleid, 1046);
		RemoveVehicleComponent(vehicleid, 1153);
		RemoveVehicleComponent(vehicleid, 1150);
		RemoveVehicleComponent(vehicleid, 1054);
		RemoveVehicleComponent(vehicleid, 1049);
		RemoveVehicleComponent(vehicleid, 1047);
		RemoveVehicleComponent(vehicleid, 1051);
		RemoveVehicleComponent(vehicleid, nitro);
		RemoveVehicleComponent(vehicleid, rodawire);
		RemoveVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 3);
	}
	if(GetVehicleModel(vehicleid) == 559)
	{
		RemoveVehicleComponent(vehicleid, 1065);
		RemoveVehicleComponent(vehicleid, 1160);
		RemoveVehicleComponent(vehicleid, 1159);
		RemoveVehicleComponent(vehicleid, 1067);
		RemoveVehicleComponent(vehicleid, 1162);
		RemoveVehicleComponent(vehicleid, 1069);
		RemoveVehicleComponent(vehicleid, 1071);
		RemoveVehicleComponent(vehicleid, nitro);
		RemoveVehicleComponent(vehicleid, rodawire);
		RemoveVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 3);
	}
	if(GetVehicleModel(vehicleid) == 561)
	{
		RemoveVehicleComponent(vehicleid, 1064);
		RemoveVehicleComponent(vehicleid, 1155);
		RemoveVehicleComponent(vehicleid, 1154);
		RemoveVehicleComponent(vehicleid, 1055);
		RemoveVehicleComponent(vehicleid, 1158);
		RemoveVehicleComponent(vehicleid, 1056);
		RemoveVehicleComponent(vehicleid, 1062);
		RemoveVehicleComponent(vehicleid, nitro);
		RemoveVehicleComponent(vehicleid, rodawire);
		RemoveVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 3);
	}
	if(GetVehicleModel(vehicleid) == 558)
	{
		RemoveVehicleComponent(vehicleid, 1089);
		RemoveVehicleComponent(vehicleid, 1166);
		RemoveVehicleComponent(vehicleid, 1168);
		RemoveVehicleComponent(vehicleid, 1088);
		RemoveVehicleComponent(vehicleid, 1164);
		RemoveVehicleComponent(vehicleid, 1090);
		RemoveVehicleComponent(vehicleid, 1094);
		RemoveVehicleComponent(vehicleid, nitro);
		RemoveVehicleComponent(vehicleid, rodawire);
		RemoveVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 3);
	}
	if(GetVehicleModel(vehicleid) == 575)
	{
		RemoveVehicleComponent(vehicleid, 1044);
		RemoveVehicleComponent(vehicleid, 1174);
		RemoveVehicleComponent(vehicleid, 1176);
		RemoveVehicleComponent(vehicleid, 1042);
		RemoveVehicleComponent(vehicleid, 1099);
		RemoveVehicleComponent(vehicleid, nitro);
		RemoveVehicleComponent(vehicleid, rodawire);
		RemoveVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 3);
	}
	if(GetVehicleModel(vehicleid) == 534)
	{
		RemoveVehicleComponent(vehicleid, 1126);
		RemoveVehicleComponent(vehicleid, 1179);
		RemoveVehicleComponent(vehicleid, 1180);
		RemoveVehicleComponent(vehicleid, 1122);
		RemoveVehicleComponent(vehicleid, 1101);
		RemoveVehicleComponent(vehicleid, 1125);
		RemoveVehicleComponent(vehicleid, 1123);
		RemoveVehicleComponent(vehicleid, 1100);
		RemoveVehicleComponent(vehicleid, nitro);
		RemoveVehicleComponent(vehicleid, rodawire);
		RemoveVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 3);
	}
	if(GetVehicleModel(vehicleid) == 536)
	{
		RemoveVehicleComponent(vehicleid, 1104);
		RemoveVehicleComponent(vehicleid, 1182);
		RemoveVehicleComponent(vehicleid, 1184);
		RemoveVehicleComponent(vehicleid, 1108);
		RemoveVehicleComponent(vehicleid, 1107);
		RemoveVehicleComponent(vehicleid, nitro);
		RemoveVehicleComponent(vehicleid, rodawire);
		RemoveVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 3);
	}
	if(GetVehicleModel(vehicleid) == 567)
	{
		RemoveVehicleComponent(vehicleid, 1129);
		RemoveVehicleComponent(vehicleid, 1189);
		RemoveVehicleComponent(vehicleid, 1187);
		RemoveVehicleComponent(vehicleid, 1102);
		RemoveVehicleComponent(vehicleid, 1133);
		RemoveVehicleComponent(vehicleid, nitro);
		RemoveVehicleComponent(vehicleid, rodawire);
		RemoveVehicleComponent(vehicleid, suspensao);
		ChangeVehiclePaintjob(vehicleid, 3);
	}
	if(GetVehicleModel(vehicleid) == 420)
	{
		RemoveVehicleComponent(vehicleid, 1010);
		RemoveVehicleComponent(vehicleid, 1087);
		RemoveVehicleComponent(vehicleid, 1081);
		RemoveVehicleComponent(vehicleid, 1139);
	}
	if(GetVehicleModel(vehicleid) == 400)
	{
		RemoveVehicleComponent(vehicleid, 1010);
		RemoveVehicleComponent(vehicleid, 1087);
		RemoveVehicleComponent(vehicleid, 1018);
		RemoveVehicleComponent(vehicleid, 1013);
		RemoveVehicleComponent(vehicleid, 1081);
		RemoveVehicleComponent(vehicleid, 1086);
	}
	if(GetVehicleModel(vehicleid) == 401)
	{
		RemoveVehicleComponent(vehicleid, 1086);
		RemoveVehicleComponent(vehicleid, 1139);
		RemoveVehicleComponent(vehicleid, 1081);
		RemoveVehicleComponent(vehicleid, 1010);
		RemoveVehicleComponent(vehicleid, 1087);
		RemoveVehicleComponent(vehicleid, 1012);
		RemoveVehicleComponent(vehicleid, 1013);
		RemoveVehicleComponent(vehicleid, 1042);
		RemoveVehicleComponent(vehicleid, 1043);
		RemoveVehicleComponent(vehicleid, 1018);
		RemoveVehicleComponent(vehicleid, 1006);
		RemoveVehicleComponent(vehicleid, 1007);
		RemoveVehicleComponent(vehicleid, 1017);
	}
	if(GetVehicleModel(vehicleid) == 576)
	{
		RemoveVehicleComponent(vehicleid, 1191);
		RemoveVehicleComponent(vehicleid, 1193);
		RemoveVehicleComponent(vehicleid, 1010);
		RemoveVehicleComponent(vehicleid, 1018);
		RemoveVehicleComponent(vehicleid, 1081);
		RemoveVehicleComponent(vehicleid, 1087);
		RemoveVehicleComponent(vehicleid, 1134);
		RemoveVehicleComponent(vehicleid, 1137);
		ChangeVehiclePaintjob(vehicleid, 3);
	}
	else
	{
		RemoveVehicleComponent(vehicleid, nitro);
		RemoveVehicleComponent(vehicleid, rodawire);
		RemoveVehicleComponent(vehicleid, suspensao);
	}
	return 1;
}