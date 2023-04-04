#include <a_samp>
#include <dudb>
#include <dini>
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define MAX_HOUSES 100
new HOUSE_STATS = 0; //0 Means housestats on pickup pickup, 1 means only housestats on /housestats command.

#define c_y 0xFFFF00AA
#define c_r 0xAA3333AA
new HousePickup[MAX_HOUSES];
new playerinterior[MAX_PLAYERS]=-1;
new inhousepickup[MAX_PLAYERS];
new playericonhouse[MAX_PLAYERS];
new Float:housex, Float:housey, Float:housez;
new housemapicon[MAX_PLAYERS];
new playerworld[MAX_PLAYERS];

enum HouseInfo
{
	Name[24],
	Renter[24],
	Rentable,
	Rentcost,
	Cost,
	Sell,
	Interior,
	Virtualworld,
	Locked,
	Float:InteriorX,
	Float:InteriorY,
	Float:InteriorZ,
	Float:iconx,
	Float:icony,
	Float:iconz,
	Rentfee
}
new hInfo[MAX_HOUSES][HouseInfo];

enum HouseCarInfo
{
	HouseCar,
	GotCar,
	Houseid,
	CarModel,
	Float:CarX,
	Float:CarY,
	Float:CarZ,
	CarColor1,
	CarColor2,
	Respawn_Delay,
	NewCar
}
new cInfo[MAX_HOUSES][HouseCarInfo];

#define FILTERSCRIPT
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
    AddEmpresa(0, 0,0,0, 2496.049804,-1695.238159,1014.742187, 150000, 150000, 3, 0);// ISSO È PRA N DAR BUG N DELETE
    AddEmpresa(1, 1835.7864,-1681.4874,13.3752, 493.7515,-21.6954,1000.6797, 999999999, 99999999, 17, 0);// empresa do guto
    AddEmpresa(2, -2624.1709,1411.4517,7.0938, -2645.4583,1407.8395,906.2734, 999999999, 99999999, 3, 0);// empresa do luks
    AddEmpresa(3, 379.4948,-2020.6121,7.8301, -227.027999,1401.229980,27.765625, 999999999, 99999999, 18, 0);// empresa do fab
    AddEmpresa(4, 1368.2424,-1279.8318,13.5469, 286.148986,-40.644397,1001.515625, 1000, 1000, 1, 0);//
	return 0;
}

public OnFilterScriptExit()
{
	for(new i=0;i<MAX_HOUSES;i++)
	{
	    DestroyPickup(HousePickup[i]);
	    DestroyVehicle(cInfo[i][HouseCar]);
	}
	return 0;
}

#else
#endif

public OnPlayerCommandText(playerid, cmdtext[])
{

    dcmd(comprarempresa,14,cmdtext);
	dcmd(venderempresa,13,cmdtext);
	dcmd(entrarempresa,13,cmdtext);
	dcmd(sairempresa,11,cmdtext);
	dcmd(fecharempresa,13,cmdtext);
	dcmd(abrirempresa,12,cmdtext);
	dcmd(infoempresa,11,cmdtext);
	dcmd(comandosempresa,11,cmdtext);
	return 0;
}
AddEmpresa(houseid, Float:iconX, Float:iconY, Float:iconZ, Float:interiorX, Float:interiorY, Float:interiorZ, Costa, Sella, Interiora, virtualworld)
{
	new house[256];
	format(house, sizeof(house), "Empresas/houseid%d",houseid);
	if(!dini_Exists(house))
	{
		dini_Create(house);
		format(hInfo[houseid][Name], 24, "ForSale");
		dini_Set(house, "Name", "ForSale");
		format(hInfo[houseid][Renter], 24, "ForRent");
		dini_Set(house, "Renter", "ForRent");
		hInfo[houseid][Rentable] = 0;
		dini_IntSet(house, "Rentable", 0);
		hInfo[houseid][Rentcost] = 0;
		dini_IntSet(house, "Rentcost", 0);
		hInfo[houseid][Cost] = Costa;
		dini_IntSet(house, "Cost", Costa);
		hInfo[houseid][Sell] = Sella;
		dini_IntSet(house, "Sell", Sella);
		hInfo[houseid][Interior] = Interiora;
		dini_IntSet(house, "Interior", Interiora);
		dini_IntSet(house, "Virtualworld", virtualworld);
		hInfo[houseid][Virtualworld] = virtualworld;
		hInfo[houseid][Locked] = 1;
		dini_IntSet(house, "Locked", 1);
		hInfo[houseid][InteriorX] = interiorX;
		hInfo[houseid][InteriorY] = interiorY;
		hInfo[houseid][InteriorZ] = interiorZ;
		dini_FloatSet(house, "X", interiorX);
		dini_FloatSet(house, "Y", interiorY);
		dini_FloatSet(house, "Z", interiorZ);
		dini_IntSet(house, "RentPay", 0);
		dini_IntSet(house, "RentGet", 0);
		cInfo[houseid][HouseCar] = 429;
		dini_IntSet(house, "HouseCar", 0);
		cInfo[houseid][CarModel] = 429;
		dini_IntSet(house, "CarModel", 0);
		cInfo[houseid][CarX] = 0;
		cInfo[houseid][CarY] = 0;
		cInfo[houseid][CarZ] = 0;
		dini_FloatSet(house, "CarX", 0);
		dini_FloatSet(house, "CarY", 0);
		dini_FloatSet(house, "CarZ", 0);
		cInfo[houseid][CarColor1] = 0;
		cInfo[houseid][CarColor2] = 0;
		dini_IntSet(house, "CarColor1", 0);
		dini_IntSet(house, "CarColor2", 0);
		cInfo[houseid][GotCar] = 0;
		print("-");
		print("--------------House Created--------------");
		printf("- Houseid: %d", houseid);
		printf("- Buy Cost: %d", Costa);
		printf("- Sell Cost: %d", Sella);
		printf("- Interior: %d", Interiora);
		printf("- VirtualWorld: %d", virtualworld);
		print("-----------------------------------------");
		print("-");
	}
	else
	{
	    format(hInfo[houseid][Name], 24, dini_Get(house, "Name"));
	    format(hInfo[houseid][Renter], 24, dini_Get(house, "Renter"));
		hInfo[houseid][Rentable] = dini_Int(house, "Rentable");
		hInfo[houseid][Rentcost] = dini_Int(house, "Rentcost");
	    hInfo[houseid][Cost] = dini_Int(house, "Cost");
	    hInfo[houseid][Sell] = dini_Int(house, "Sell");
	    hInfo[houseid][Interior] = dini_Int(house, "Interior");
	    hInfo[houseid][Locked] = dini_Int(house, "Locked");
	    hInfo[houseid][InteriorX] = dini_Float(house, "X");
	    hInfo[houseid][InteriorY] = dini_Float(house, "Y");
		hInfo[houseid][InteriorZ] = dini_Float(house, "Z");
		hInfo[houseid][Virtualworld] = dini_Int(house, "Virtualworld");
	}
    hInfo[houseid][iconx]=iconX;
	hInfo[houseid][icony]=iconY;
	hInfo[houseid][iconz]=iconZ;
	format(house, sizeof(house), "Empresas/houseid%d",houseid);
	if(strcmp(hInfo[playericonhouse[houseid]][Name],"ForSale",true)==0)
	{
		HousePickup[houseid] = CreatePickup(1254, 23, iconX, iconY, iconZ);//not bought
	}
	else
	{
		HousePickup[houseid] = CreatePickup(1313,24, iconX, iconY, iconZ);//bought
	}
}

AddHouseCar(houseid, modelid, Float:Carx, Float:Cary, Float:Carz, color1, color2, respawn_delay)
{
	new house[256];
	format(house, sizeof(house), "Empresas/houseid%d",houseid);
	if(dini_Exists(house))
	{
	    cInfo[houseid][GotCar] = 1;
		if(dini_Int(house, "CarModel")==0)
		{
		    dini_IntSet(house, "CarModel", modelid);
		    cInfo[houseid][CarModel] = modelid;
		    cInfo[houseid][CarX] = Carx;
			cInfo[houseid][CarY] = Cary;
			cInfo[houseid][CarZ] = Carz;
			dini_FloatSet(house, "CarX", Carx);
			dini_FloatSet(house, "CarY", Cary);
			dini_FloatSet(house, "CarZ", Carz);
			cInfo[houseid][CarColor1] = color1;
			cInfo[houseid][CarColor2] = color2;
			dini_IntSet(house, "CarColor1", color1);
			dini_IntSet(house, "CarColor2", color2);
			dini_IntSet(house, "Respawn_Delay", respawn_delay);
			cInfo[houseid][Respawn_Delay] = respawn_delay;
 			cInfo[houseid][HouseCar] = CreateVehicle(cInfo[houseid][CarModel], Carx, Cary, Carz, 0.0, color1, color2, respawn_delay);
		    print("-");
			print("--------------Car Created--------------");
			printf("- Car Houseid: %d", houseid);
			printf("- Modelid: %d", modelid);
			printf("- Color 1: %d", color1);
			printf("- Color 2: %d", color2);
			printf("- Respawn Delay: %d", respawn_delay);
			print("---------------------------------------");
			print("-");
		}
		else
		{
		    cInfo[houseid][CarModel] = dini_Int(house, "CarModel");
		}
		cInfo[houseid][CarX] = dini_Int(house, "CarX");
		cInfo[houseid][CarY] = dini_Int(house, "CarY");
		cInfo[houseid][CarZ] = dini_Int(house, "CarZ");
		cInfo[houseid][CarColor1] = dini_Int(house, "CarColor1");
		cInfo[houseid][CarColor2] = dini_Int(house, "CarColor2");
		cInfo[houseid][Respawn_Delay] = dini_Int(house, "Respawn_Delay");
 		cInfo[houseid][HouseCar] = CreateVehicle(cInfo[houseid][CarModel], Carx, Cary, Carz, 0.0, color1, color2, respawn_delay);
	}
}

/*stock SpawnPlayerAtHouse(playerid)
{	new str1[256],pname[24],str[256];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(str1, sizeof(str1), "Empresas/Users/%s", udb_encode(pname));
	if (dini_Exists(str1))
	{
		if(dini_Int(str1,"Houseid")!=-255)
		{
			new Float:x,Float:y,Float:z;
			str = dini_Get(str1,"SpawnInt");
			SetPlayerInterior(playerid, strval(str));
			playerinterior[playerid] = strval(str);
    		x = dini_Float(str1,"SpawnX");
	  		y = dini_Float(str1,"SpawnY");
	  		z = dini_Float(str1,"SpawnZ");
			SetPlayerPos(playerid, x, y, z);
		}
	}
	return 1;
} */

public OnPlayerSpawn(playerid)
{
    /*SpawnPlayerAtHouse(playerid); */
}

GetHouseStats(playerid, pickupid)
{
	for(new i=0;i<MAX_HOUSES;i++)
	{
		if(pickupid==HousePickup[i])
	   	{
	   	    if(HOUSE_STATS==0)
		 	{
				new str2[256];
	    		format(str2, sizeof(str2), "|EMPRESAS| Dono atual: %s", hInfo[i][Name]);
	    		SendClientMessage(playerid, c_y, str2);
	    		if(strcmp(hInfo[i][Renter],"ForRent",true))
	    		{
	    			format(str2, sizeof(str2), ": %s", hInfo[i][Renter]);
	    			SendClientMessage(playerid, c_y, str2);
				}
	    		format(str2,sizeof(str2),"|EMPRESAS|Custo da Empresa: %i",hInfo[i][Cost]);
	    		SendClientMessage(playerid, c_y, str2);
	    	}
	    	inhousepickup[playerid] = GetTickCount();
	    	playericonhouse[playerid] = i;
	    }
	}
}

dcmd_venderempresa(playerid,params[])
{
	#pragma unused params
	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "|ERRO| Você não está no ícone de uma empresa");
    		return 1;
	}
	new str[255],str1[256],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Empresas/houseid%d", playericonhouse[playerid]);
	if (strcmp(hInfo[playericonhouse[playerid]][Name],pname,false)) return SendClientMessage(playerid, c_r, "|ERRO| Essa casa não é sua");
 	SendClientMessage(playerid, c_y, "|EMPRESAS| Você vendeu sua empresa");
  	format(str, sizeof(str), "%s has sold houseid 0",pname);
	print(str);
	GivePlayerMoney(playerid, hInfo[playericonhouse[playerid]][Sell]);
    dini_Set(str1, "Name", "ForSale");
    hInfo[playericonhouse[playerid]][Locked] = dini_IntSet(str1,"Locked",1);
    format(hInfo[playericonhouse[playerid]][Name],255,"ForSale");
	format(str1, sizeof(str1), "Empresas/Users/%s", udb_encode(pname));
	if (!dini_Exists(str1)) dini_Create(str1);
	dini_IntSet(str1, "Houseid", -255);
	DestroyPickup(HousePickup[playericonhouse[playerid]]);
	HousePickup[playericonhouse[playerid]] = CreatePickup(1273, 23, hInfo[playericonhouse[playerid]][iconx], hInfo[playericonhouse[playerid]][icony], hInfo[playericonhouse[playerid]][iconz]);
	RemovePlayerMapIcon(playerid, housemapicon[playerid]);
 	return 1;
}

dcmd_comprarempresa(playerid,params[])
{
    #pragma unused params
   	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "|ERRO| Você não está no icone de uma empresa!");
    		return 1;
	}
	new str[255],str1[255],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Empresas/Users/%s", udb_encode(pname));
	if(dini_Exists(str1))
	{
	if (dini_Int(str1, "Houseid")!=-255) return SendClientMessage(playerid, c_r, "|ERRO| Você já tem uma empresa");
	}
	format(str1, sizeof(str1), "Empresas/houseid%d", playericonhouse[playerid]);
	if (strcmp(hInfo[playericonhouse[playerid]][Name],"ForSale",true)) return SendClientMessage(playerid, c_r, "|ERRO| Essa empresa não está a venda");
	if(GetPlayerMoney(playerid)<hInfo[playericonhouse[playerid]][Cost]) return SendClientMessage(playerid, c_r, "|ERRO| Você não tem dinheiro suficiente");
	SendClientMessage(playerid, c_y, "|EMPRESAS| Você vendeu sua empresa");
	format(str, sizeof(str), "%s has bought houseid 0",pname);
	print(str);
	GivePlayerMoney(playerid, -hInfo[playericonhouse[playerid]][Cost]);
    dini_Set(str1, "Name", pname);
    hInfo[playericonhouse[playerid]][Name]=pname;
    hInfo[playericonhouse[playerid]][Locked] = dini_IntSet(str1,"Locked",0);

	format(str1, sizeof(str1), "Empresas/Users/%s", udb_encode(pname));
	if (!dini_Exists(str1)) dini_Create(str1);
	new Float:sy, Float:sx, Float:sz;
	dini_IntSet(str1, "Houseid", playericonhouse[playerid]);
	if(!dini_Isset(str1,"Rentid"))
	{
		dini_IntSet(str1, "Rentid", -255);
	}
	GetPlayerPos(playerid, sx,sy,sz);
	dini_FloatSet(str1, "SpawnX", sx);
	dini_FloatSet(str1, "SpawnY", sy);
	dini_FloatSet(str1, "SpawnZ", sz);
	dini_IntSet(str1, "SpawnInt", GetPlayerInterior(playerid));
	DestroyPickup(HousePickup[playericonhouse[playerid]]);
	HousePickup[playericonhouse[playerid]] = CreatePickup(1272, 23, hInfo[playericonhouse[playerid]][iconx], hInfo[playericonhouse[playerid]][icony], hInfo[playericonhouse[playerid]][iconz]);
	return 1;
}

dcmd_fecharempresa(playerid,params[])
{
    #pragma unused params
   	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "|ERRO| Você não está no ícone de uma Empresa");
    		return 1;
	}
	new str1[256],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Empresas/houseid%d", playericonhouse[playerid]);
	if(strcmp(hInfo[playericonhouse[playerid]][Name],pname,true)==0)
	{
 		SendClientMessage(playerid, c_y, "|EMPRESAS| Empresa Fechada com Sucesso");
    	dini_IntSet(str1,"Locked",1);
    	hInfo[playericonhouse[playerid]][Locked] = 1;
    }
    else if(strcmp(hInfo[playericonhouse[playerid]][Renter],pname,true)==0)
    {
        SendClientMessage(playerid, c_y, "|EMPRESAS| Empresa Fechada com Sucesso");
    	dini_IntSet(str1,"Locked",1);
    	hInfo[playericonhouse[playerid]][Locked] = 1;
    }
    else
    {
        SendClientMessage(playerid, c_r, "|ERRO| Essa empresa não é sua");
    }	
	return 1;
}

dcmd_abrirempresa(playerid,params[])
{
    #pragma unused params
   	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "|ERRO| Você não está no ícone de uma empresa");
    		return 1;
	}
	new str1[256],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Empresas/houseid%d", playericonhouse[playerid]);
	if(strcmp(hInfo[playericonhouse[playerid]][Name],pname,true)==0)
	{
 		SendClientMessage(playerid, c_y, "|EMPRESAS| Você abriu sua empresa");
    	dini_IntSet(str1,"Locked",0);
    	hInfo[playericonhouse[playerid]][Locked] = 0;
    }
    else if(strcmp(hInfo[playericonhouse[playerid]][Renter],pname,true)==0)
    {
        SendClientMessage(playerid, c_y, "|EMPRESAS| empresa destrancada com sucesso!");
    	dini_IntSet(str1,"Locked",0);
    	hInfo[playericonhouse[playerid]][Locked] = 0;
    }
    else
    {
        SendClientMessage(playerid, c_r, "|ERRO| Essa empresa não é sua");
    }
	return 1;
}

dcmd_entrarempresa(playerid,params[])
{
    #pragma unused params
	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "|ERRO| Você não está no ícone de uma empresa");
    		return 1;
	}
	new str1[255],pname[24];
	GetPlayerPos(playerid, housex, housey, housez);
	format(str1, sizeof(str1), "Empresas/houseid%d", playericonhouse[playerid]);
	GetPlayerName(playerid, pname, 24);
	if(hInfo[playericonhouse[playerid]][Locked]==1) return SendClientMessage(playerid, c_r, "|ERRO| Esta empresa está trancada");
    playerworld[playerid] = GetPlayerVirtualWorld(playerid);
 	SendClientMessage(playerid, c_y, "You entered the house!");
    SetPlayerVirtualWorld(playerid, hInfo[playericonhouse[playerid]][Virtualworld]);
    SetPlayerInterior(playerid, hInfo[playericonhouse[playerid]][Interior]);
	SetPlayerPos(playerid, hInfo[playericonhouse[playerid]][InteriorX], hInfo[playericonhouse[playerid]][InteriorY], hInfo[playericonhouse[playerid]][InteriorZ]);
	playerinterior[playerid] = hInfo[playericonhouse[playerid]][Interior];
   	return 1;
}

dcmd_sairempresa(playerid,params[])
{
    #pragma unused params

	if(GetPlayerInterior(playerid)==playerinterior[playerid])
	{
		SetPlayerPos(playerid, housex, housey, housez);
		SetPlayerInterior(playerid, playerworld[playerid]);
	}
	else
	{
		SendClientMessage(playerid, c_r, "|ERRO| Você não está dentro de uma empresa");
	}
   	return 1;
}


dcmd_comandosempresa(playerid,params[])
{
	#pragma unused params
	SendClientMessage(playerid, c_y, "-------------");
	SendClientMessage(playerid, c_y, "Comandos da empresa");
	SendClientMessage(playerid, c_y, "-------------");
	SendClientMessage(playerid, c_y, "/fecharempresa");
	SendClientMessage(playerid, c_y, "/abrirempresa");
 	SendClientMessage(playerid, c_y, "/comprarempresa");
  	SendClientMessage(playerid, c_y, "/venderempresa");
    SendClientMessage(playerid, c_y, "/infoempresa");
	SendClientMessage(playerid, c_y, "-------------");
	return 1;
}

dcmd_infoempresa(playerid,params[])
{
	#pragma unused params
	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "|ERRO|Você não está no icone de uma casa ");
    		return 1;
	}
	new str[256];
	format(str, sizeof(str), "Owner: %s", hInfo[playericonhouse[playerid]][Name]);
	SendClientMessage(playerid, c_y, str);
	format(str, sizeof(str), "Cost: $%d", hInfo[playericonhouse[playerid]][Cost]);
	SendClientMessage(playerid, c_y, str);
	format(str, sizeof(str), "Renter: %s", hInfo[playericonhouse[playerid]][Renter]);
	SendClientMessage(playerid, c_y, str);
	format(str, sizeof(str), "Rentcost: $%d / hour", hInfo[playericonhouse[playerid]][Rentcost]);
	SendClientMessage(playerid, c_y, str);
	return 1;
}

