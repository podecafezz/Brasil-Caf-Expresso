/*******************************************************************************
* Anti-Airbreak script por D0erf|er                                             *
* Este anti-cheat detecta airbreak se estiver ligado  (mesmo sem se mover)      *
*******************************************************************************/
// -v1.1b ASuportes para anti a pé airbreak agora.
/* -v1.2
    Melhorias no anti car airbreak
	/toggleaairbreak: ligar/desligar airbreak.
	/pairbreaicount (id): ver o atual airbreakcount de um player.
   -v2.0
	Detecta airbreak que estão a pé enquanto key_sprint está precionada.
	Corrigido um bug no anti a pé airbreak que conduziu a proibição de errado quando um jogador deu origem a outro jogador pé. */
	
// TRADUZIDO POR [TLB]AMBRÓSIO AMELIO
	
#include <a_samp>

//Settings
#define UPDATE_COUNT 5
#define POSSIBLE_AIRBREAK_COUNT_CAR 9
#define POSSIBLE_AIRBREAK_COUNT_ONFOOT 7
//Settings end

new pupdates[MAX_PLAYERS],airbreakcount[MAX_PLAYERS],running=1;

public OnFilterScriptInit()
{
	new c;
	c=POSSIBLE_AIRBREAK_COUNT_CAR;
	if(c < 7)
	{
	    print("PERIGO: POSSIVEL_AIRBREAK_USANDO_CARRO é < 7, deve ser pelo menos >=7!!!");
	    running=0;
	    print("Anti Airbreak está agora desligado.");
	}
	c=POSSIBLE_AIRBREAK_COUNT_ONFOOT;
	if(c < 5)
	{
	    print("PERIGO: POSSIVEL_AIRBREAK_ANDANDO_APE é < 5, deve ser pelo menos >=5!!!");
	    running=0;
	    print("Anti Airbreak está agora desligado.");
	}
	return 1;
}

public OnPlayerCommandText(playerid,cmdtext[])
{
	if(!IsPlayerAdmin(playerid)) return 0;

	if(strcmp(cmdtext, "/toggleaairbreak", true) == 0)
	{
		switch(running)
		{
		 	case 0: {running=1; SendClientMessage(playerid,0xFF0000FF,"Anti-Airbreak foi ligado!");}
			case 1: {running=0; SendClientMessage(playerid,0xFF0000FF,"Anti-Airbreak foi desligado!");}
		}
		return 1;
	}
	
	new cmd[128];
	new idx;
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/pairbreakcount", true) == 0)
	{
	    new tmp[128];
	    tmp=strtok(cmdtext,idx);
	    if(!strlen(tmp)) { SendClientMessage(playerid,0xFF0000FF,"Use: /pairbreakcount (id)"); return 1; }
		new id = strval(tmp);
		new str[60],name[MAX_PLAYER_NAME];
		GetPlayerName(id,name,MAX_PLAYER_NAME);
		format(str,sizeof(str),"%s's atual airbreakcount é %d",name,airbreakcount[id]);
		SendClientMessage(playerid,0xFF0000FF,str);
		return 1;
	}
	
	return 0;
}

strtok(const text[], &index)
{
	new length = strlen(text);
	while ((index < length) && (text[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (text[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = text[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

public OnPlayerUpdate(playerid)
{
	// ANTIAIRBREAK
	pupdates[playerid]++;
	if(pupdates[playerid] > UPDATE_COUNT && running == 1)
	{
	    pupdates[playerid]=0;
	    new check;
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsVehicleValid(GetPlayerVehicleID(playerid)))
		{
			new Float:vx,Float:vy,Float:vz;
			GetVehicleVelocity(GetPlayerVehicleID(playerid),vx,vy,vz);
			if(vx==0.0 && vy==0.0 && vz < -0.0032 && vz > -0.022)
			{
				if(IsPlayerInWater(playerid)==0)
				{
				check=1;
				}
				else
				{
				check=3;
				}
			}
		}
		else
		{
		    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT && GetPlayerSurfingVehicleID(playerid)==INVALID_VEHICLE_ID)
		    {
				new Float:vx,Float:vy,Float:vz,Float:px,Float:py,Float:pz;
				GetPlayerVelocity(playerid,vx,vy,vz);
				pupdates[playerid]=0;
    			new keys,ud,lr;
			    GetPlayerKeys(playerid,keys,ud,lr);
			    if (keys & KEY_SPRINT)
			    {
				    if(-0.022 < vz < -0.0040 && -0.235 < vx < 0.235 && -0.235 < vy < 0.235)
				    {
				        if(!IsPlayerInRangeOfPoint(playerid,2.0,GetPVarFloat(playerid,"oposx"),GetPVarFloat(playerid,"oposy"),GetPVarFloat(playerid,"oposz")) || -0.5>(GetPVarFloat(playerid,"oposz")-pz)>-0.1 || 0.075>(GetPVarFloat(playerid,"oposz")-pz)>-0.075)
      					{
							if(IsPlayerInWater(playerid)==0)
							{
								check=2;
								if(airbreakcount[playerid] > (POSSIBLE_AIRBREAK_COUNT_ONFOOT-2))
								{
								    SetPlayerVelocity(playerid,0.3,0.3,0.3);
								}
							}
							else
							{
								check=3;
							}
				        }
				        SetPVarFloat(playerid,"oposx",px);
				        SetPVarFloat(playerid,"oposy",py);
				        SetPVarFloat(playerid,"oposz",pz);
				    }
			    }
	    		else
	    		{
				    if(-0.022 < vz < -0.0040 && -0.121 < vx < 0.121 && -0.121 < vy < 0.121)
				    {
				        if(!IsPlayerInRangeOfPoint(playerid,2.0,GetPVarFloat(playerid,"oposx"),GetPVarFloat(playerid,"oposy"),GetPVarFloat(playerid,"oposz")) || -0.5>(GetPVarFloat(playerid,"oposz")-pz)>-0.1 || 0.075>(GetPVarFloat(playerid,"oposz")-pz)>-0.075)
      					{
							if(IsPlayerInWater(playerid)==0)
							{
								check=2;
								if(airbreakcount[playerid] > (POSSIBLE_AIRBREAK_COUNT_ONFOOT-2))
								{
								    SetPlayerVelocity(playerid,0.3,0.3,0.3);
								}
							}
							else
							{
								check=3;
							}
				        }
				        SetPVarFloat(playerid,"oposx",px);
				        SetPVarFloat(playerid,"oposy",py);
				        SetPVarFloat(playerid,"oposz",pz);
				    }
				}
		    }
		}
		if(check > 0)
		{
			if(check < 3)
			{
			    new POSSIBLE_AIRBREAK_COUNT;
				switch(check)
	 			{
		 			case 1: POSSIBLE_AIRBREAK_COUNT=POSSIBLE_AIRBREAK_COUNT_CAR;
			 		case 2: POSSIBLE_AIRBREAK_COUNT=POSSIBLE_AIRBREAK_COUNT_ONFOOT;
		 		}
				airbreakcount[playerid]++;
				if(airbreakcount[playerid] > POSSIBLE_AIRBREAK_COUNT)
				{
						airbreakcount[playerid]=0;
			 			new ip[20],name[24];
				 		GetPlayerName(playerid,name,sizeof(name));
				 		GetPlayerIp(playerid,ip,sizeof(ip));
				 		switch(check)
				 		{
					 		case 1:printf("Airbreak: %s(%s) foi banido. Reação: Airbreak [CARRO] [by D0erf|er]",name,ip);
					 		case 2:printf("Airbreak: %s(%s) foi banido. Reação: Airbreak [A PÉ] [by D0erf|er]",name,ip);
				 		}
						Ban(playerid);
				}
			}
		}
		else
		{
	 		airbreakcount[playerid]=0;
		}
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	airbreakcount[playerid]=0;
	return 1;
}

stock IsVehicleValid(id)
{
	new type=GetVehicleModel(id);
	new blocked[]={ 548, 425, 417, 487, 488, 497, 563, 447, 469, 520 };
	for(new i;i<sizeof(blocked);i++)
	{
		if(type == blocked[i])
		{
			return 0;
		}
	}
	return 1;
}

stock IsPlayerInArea(playerid, Float:max_x, Float:min_x, Float:max_y, Float:min_y)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	if(X <= max_x && X >= min_x && Y <= max_y && Y >= min_y) return 1;
	return 0;
}

stock IsPlayerInWater(playerid)
{
	new Float:x,Float:y,Float:pz;
	GetPlayerPos(playerid,x,y,pz);
	if (
 	(IsPlayerInArea(playerid, 2032.1371, 1841.2656, 1703.1653, 1467.1099) && pz <= 9.0484) //lv piratenschiff
  	|| (IsPlayerInArea(playerid, 2109.0725, 2065.8232, 1962.5355, 10.8547) && pz <= 10.0792) //lv visage
  	|| (IsPlayerInArea(playerid, -492.5810, -1424.7122, 2836.8284, 2001.8235) && pz <= 41.06) //lv staucamm
  	|| (IsPlayerInArea(playerid, -2675.1492, -2762.1792, -413.3973, -514.3894) && pz <= 4.24) //sf südwesten kleiner teich
  	|| (IsPlayerInArea(playerid, -453.9256, -825.7167, -1869.9600, -2072.8215) && pz <= 5.72) //sf gammel teich
  	|| (IsPlayerInArea(playerid, 1281.0251, 1202.2368, -2346.7451, -2414.4492) && pz <= 9.3145) //ls neben dem airport
  	|| (IsPlayerInArea(playerid, 2012.6154, 1928.9028, -1178.6207, -1221.4043) && pz <= 18.45) //ls mitte teich
  	|| (IsPlayerInArea(playerid, 2326.4858, 2295.7471, -1400.2797, -1431.1266) && pz <= 22.615) //ls weiter südöstlich
  	|| (IsPlayerInArea(playerid, 2550.0454, 2513.7588, 1583.3751, 1553.0753) && pz <= 9.4171) //lv pool östlich
  	|| (IsPlayerInArea(playerid, 1102.3634, 1087.3705, -663.1653, -682.5446) && pz <= 112.45) //ls pool nordwestlich
  	|| (IsPlayerInArea(playerid, 1287.7906, 1270.4369, -801.3882, -810.0527) && pz <= 87.123) //pool bei maddog's haus oben
  	|| (pz < 1.5)
	)
	{
	    return 1;
	}
	return 0;
}
