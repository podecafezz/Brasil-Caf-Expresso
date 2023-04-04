//------------------------------------------------------------------------------
//FS de Casas feito por [FCT]RedMetaL
//------------------------------------------------------------------------------
#include <a_samp>
#include <dudb>
#include <dini>
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
//------------------------------------------------------------------------------
#define MAX_HOUSES 100
//------------------------------------------------------------------------------
new HOUSE_STATS = 0; //0 Means housestats on pickup pickup, 1 means only housestats on /housestats command.
//------------------------------------------------------------------------------
new HousePickup[MAX_HOUSES];
new playerinterior[MAX_PLAYERS]=-1;
new inhousepickup[MAX_PLAYERS];
new playericonhouse[MAX_PLAYERS];
new Float:housex, Float:housey, Float:housez;
new housemapicon[MAX_PLAYERS];
new playerworld[MAX_PLAYERS];
//------------------------------------------------------------------------------
enum HouseInfo
{
	Name[24],
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
}
//------------------------------------------------------------------------------
new hInfo[MAX_HOUSES][HouseInfo];
//------------------------------------------------------------------------------
#define FILTERSCRIPT
#if defined FILTERSCRIPT
//------------------------------------------------------------------------------
public OnFilterScriptInit()
{
//------------------------------------------------------------------------------
    AddHouse(0, 0,0,-20, 2496.049804,-1695.238159,1014.742187, 150000, 150000, 3, 0);
    AddHouse(1, -2471.9082,2450.1716,17.3230, 2324.419921,-1145.568359,1050.710083, 150000, 150000, 12, 0);// Casa ID 0
    AddHouse(2, 727.8948,-1276.4315,13.6484, 1212.019897,-28.663099,1000.953125, 350000, 350000, 3, 0);// Casa ID 1
    AddHouse(3, -368.8651,1168.5264,20.2719, 2527.654052,-1679.388305,1015.498596, 750000, 175000, 1, 0);// Casa ID 2
//------------------------------------------------------------------------------
//--------------Labels-------------
Create3DTextLabel("Casa ID 0", 0xAFAFAFAA, -2471.9082,2450.1716,18.0, 50, 0); //Casa ID 0
Create3DTextLabel("Casa ID 1", 0xAFAFAFAA, 727.8948,-1276.4315,14.4, 50, 0);  //Casa ID 1
Create3DTextLabel("Casa ID 2", 0xAFAFAFAA, -368.8651,1168.5264,24.0, 50, 0);  //Casa ID 2
//------------------------------------------------------------------------------
}
//------------------------------------------------------------------------------
public OnFilterScriptExit()
{
	for(new i=0;i<MAX_HOUSES;i++)
	{
	    DestroyPickup(HousePickup[i]);
	}
	return 0;
}
//------------------------------------------------------------------------------
#else
#endif
//------------------------------------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
{
    dcmd(comprarcasa,11,cmdtext);
	dcmd(vendercasa,10,cmdtext);
	dcmd(entrarcasa,10,cmdtext);
	dcmd(saircasa,8,cmdtext);
	dcmd(fecharcasa,10,cmdtext);
	dcmd(abrircasa,9,cmdtext);
	return 0;
}
//------------------------------------------------------------------------------
AddHouse(houseid, Float:iconX, Float:iconY, Float:iconZ, Float:interiorX, Float:interiorY, Float:interiorZ, Costa, Sella, Interiora, virtualworld)
//------------------------------------------------------------------------------
{
	new house[256];
	format(house, sizeof(house), "Houses/houseid%d",houseid);
	if(!dini_Exists(house))
	{
		dini_Create(house);
		format(hInfo[houseid][Name], 24, "A Venda");
		dini_Set(house, "Name", "A Venda");
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
	}
	else
	{
	    format(hInfo[houseid][Name], 24, dini_Get(house, "Name"));
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
	format(house, sizeof(house), "Houses/houseid%d",houseid);
	if(strcmp(hInfo[playericonhouse[houseid]][Name],"A Venda",true)==0)
	{
		HousePickup[houseid] = CreatePickup(1273, 23, iconX, iconY, iconZ);//not bought
	}
	else
	{
		HousePickup[houseid] = CreatePickup(1272,23, iconX, iconY, iconZ);//bought
	}
}
//------------------------------------------------------------------------------
stock SpawnPlayerAtHouse(playerid)
{
	new str1[256],pname[24],str[256];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(str1, sizeof(str1), "Houses/Users/%s", udb_encode(pname));
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
}
//------------------------------------------------------------------------------
public OnPlayerSpawn(playerid)
{
    SpawnPlayerAtHouse(playerid);
}
//------------------------------------------------------------------------------
GetHouseStats(playerid, pickupid)
{
	for(new i=0;i<MAX_HOUSES;i++)
	{
		if(pickupid==HousePickup[i])
	   	{
	   	    if(HOUSE_STATS==0)
		 	{
				new str2[256];
	    		format(str2, sizeof(str2), "|INFO| Dono atual: %s", hInfo[i][Name]);
	    		SendClientMessage(playerid, 0xADFF2FAA, str2);
	    		{
				}
	    		format(str2,sizeof(str2),"|INFO| Valor: %i",hInfo[i][Cost]);
	    		SendClientMessage(playerid, 0xADFF2FAA, str2);
	    	}
	    	inhousepickup[playerid] = GetTickCount();
	    	playericonhouse[playerid] = i;
	    }
	}
}
//------------------------------------------------------------------------------
dcmd_vendercasa(playerid,params[])
{
	#pragma unused params
	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Você não está no ícone de uma casa!");
    		return 1;
	}
	new str[255],str1[256],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	if (strcmp(hInfo[playericonhouse[playerid]][Name],pname,false)) return SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Essa casa não é sua!");
 	SendClientMessage(playerid, 0x33CCFFAA, "Você vendeu sua casa!");
  	format(str, sizeof(str), "|INFO]: %s vendeu a casa dele!",pname);
	print(str);
	GivePlayerMoney(playerid, hInfo[playericonhouse[playerid]][Sell]);
    dini_Set(str1, "Name", "A Venda");
    hInfo[playericonhouse[playerid]][Locked] = dini_IntSet(str1,"Locked",1);
    format(hInfo[playericonhouse[playerid]][Name],255,"A Venda");
	format(str1, sizeof(str1), "Houses/Users/%s", udb_encode(pname));
	if (!dini_Exists(str1)) dini_Create(str1);
	dini_IntSet(str1, "Houseid", -255);
	DestroyPickup(HousePickup[playericonhouse[playerid]]);
	HousePickup[playericonhouse[playerid]] = CreatePickup(1273, 23, hInfo[playericonhouse[playerid]][iconx], hInfo[playericonhouse[playerid]][icony], hInfo[playericonhouse[playerid]][iconz]);
	RemovePlayerMapIcon(playerid, housemapicon[playerid]);
 	return 1;
}
//------------------------------------------------------------------------------
dcmd_comprarcasa(playerid,params[])
{
    #pragma unused params
   	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Você não está no icone de uma casa!");
    		return 1;
	}
	new str[255],str1[255],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Houses/Users/%s", udb_encode(pname));
	if(dini_Exists(str1))
	{
	if (dini_Int(str1, "Houseid")!=-255) return SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Você já tem uma casa!");
	}
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	if (strcmp(hInfo[playericonhouse[playerid]][Name],"A Venda",true)) return SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Essa casa não está a venda");
	if(GetPlayerMoney(playerid)<hInfo[playericonhouse[playerid]][Cost]) return SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Você não tem dinheiro suficiente");
	SendClientMessage(playerid, 0x33CCFFAA, "Você comprou essa casa!");
	format(str, sizeof(str), "|INFO|: %s Comprou uma casa",pname);
	print(str);
	GivePlayerMoney(playerid, -hInfo[playericonhouse[playerid]][Cost]);
    dini_Set(str1, "Name", pname);
    hInfo[playericonhouse[playerid]][Name]=pname;
    hInfo[playericonhouse[playerid]][Locked] = dini_IntSet(str1,"Locked",0);

	format(str1, sizeof(str1), "Houses/Users/%s", udb_encode(pname));
	if (!dini_Exists(str1)) dini_Create(str1);
	new Float:sy, Float:sx, Float:sz;
	dini_IntSet(str1, "Houseid", playericonhouse[playerid]);
	{
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
//------------------------------------------------------------------------------
dcmd_fecharcasa(playerid,params[])
{
    #pragma unused params
   	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Você não esta no icone de uma casa!");
    		return 1;
	}
	new str1[256],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	if(strcmp(hInfo[playericonhouse[playerid]][Name],pname,true)==0)
	{
 		SendClientMessage(playerid, 0x33CCFFAA, "|INFO|: Casa Fechada com Sucesso!");
    	dini_IntSet(str1,"Locked",1);
    	hInfo[playericonhouse[playerid]][Locked] = 1;
    }
    else if(strcmp(hInfo[playericonhouse[playerid]][Sell],pname,true)==0)
    {
        SendClientMessage(playerid, 0x33CCFFAA, "|INFO|:Casa Fechada com Sucesso!");
    	dini_IntSet(str1,"Locked",1);
    	hInfo[playericonhouse[playerid]][Locked] = 1;
    }
    else
    {
        SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Essa casa não é sua!");
    }	
	return 1;
}
//------------------------------------------------------------------------------
dcmd_abrircasa(playerid,params[])
{
    #pragma unused params
   	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Você não está no ícone de uma casa");
    		return 1;
	}
	new str1[256],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	if(strcmp(hInfo[playericonhouse[playerid]][Name],pname,true)==0)
	{
 		SendClientMessage(playerid, 0x33CCFFAA, "|INFO|: Você abriu sua casa!");
    	dini_IntSet(str1,"Locked",0);
    	hInfo[playericonhouse[playerid]][Locked] = 0;
    }
    else if(strcmp(hInfo[playericonhouse[playerid]][Sell],pname,true)==0)
    {
        SendClientMessage(playerid, 0x33CCFFAA, "|INFO|: Você abriu sua casa!");
    	dini_IntSet(str1,"Locked",0);
    	hInfo[playericonhouse[playerid]][Locked] = 0;
    }
    else
    {
        SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Essa casa não é sua!");
    }
	return 1;
}
//------------------------------------------------------------------------------
dcmd_entrarcasa(playerid,params[])
{
    #pragma unused params
	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Você não está no ícone de uma casa!");
    		return 1;
	}
	new str1[255],pname[24];
	GetPlayerPos(playerid, housex, housey, housez);
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	GetPlayerName(playerid, pname, 24);
	if(hInfo[playericonhouse[playerid]][Locked]==1) return SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Esta casa está trancada!");
    playerworld[playerid] = GetPlayerVirtualWorld(playerid);
 	SendClientMessage(playerid, 0x33CCFFAA, "Você entrou na casa!");
    SetPlayerVirtualWorld(playerid, hInfo[playericonhouse[playerid]][Virtualworld]);
    SetPlayerInterior(playerid, hInfo[playericonhouse[playerid]][Interior]);
	SetPlayerPos(playerid, hInfo[playericonhouse[playerid]][InteriorX], hInfo[playericonhouse[playerid]][InteriorY], hInfo[playericonhouse[playerid]][InteriorZ]);
	playerinterior[playerid] = hInfo[playericonhouse[playerid]][Interior];
   	return 1;
}
//------------------------------------------------------------------------------
dcmd_saircasa(playerid,params[])
{
    #pragma unused params

	if(GetPlayerInterior(playerid)==playerinterior[playerid])
	{
		SetPlayerPos(playerid, housex, housey, housez);
		SetPlayerInterior(playerid, playerworld[playerid]);
	}
	else
	{
		SendClientMessage(playerid, 0xFFE4C4AA, "|ERRO| Você não está dentro de uma casa!");
	}
   	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerPickUpPickup(playerid, pickupid)
{
	GetHouseStats(playerid, pickupid);
	return 0;
}
//------------------------------------------------------------------------------
stock sscanf(string[], format[], {Float,_}:...)
{
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs();
	while (paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos++])
		{
			case '\0':
			{
				return 0;
			}
			case 'i', 'd':
			{
				new
					neg = 1,
					num = 0,
					ch = string[stringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = string[++stringPos];
				}
				do
				{
					stringPos++;
					if (ch >= '0' && ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return 1;
					}
				}
				while ((ch = string[stringPos]) && ch != ' ');
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					ch,
					num = 0;
				while ((ch = string[stringPos++]))
				{
					switch (ch)
					{
						case 'x', 'X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						case ' ':
						{
							break;
						}
						default:
						{
							return 1;
						}
					}
				}
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':
			{
				new tmp[25];
				strmid(tmp, string, stringPos, stringPos+sizeof(tmp)-2);
				setarg(paramPos, 0, _:floatstr(tmp));
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while ((ch = string[stringPos++]) && ch != ' ')
					{
						setarg(paramPos, i++, ch);
					}
					if (!i) return 1;
				}
				else
				{
					while ((ch = string[stringPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while (string[stringPos] && string[stringPos] != ' ')
		{
			stringPos++;
		}
		while (string[stringPos] == ' ')
		{
			stringPos++;
		}
		paramPos++;
	}
	while (format[formatPos] == 'z') formatPos++;
	return format[formatPos];
}
//------------------------------------------------------------------------------
