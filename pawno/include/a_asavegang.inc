#include <a_samp>

#if defined _SaveGang_included
  #endinput
#endif

#define _SaveGang_included
#pragma library dutils

stock PlayerName2(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
 	new tmp[MAX_STRING];
  	set(tmp,udb_encode(name));
	return tmp;
}

stock  dini_ExistsGang(filename)
{
    new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
	if(fexist(string2)) return true;
	return false;
}

stock  dini_CreateGang(filename)
{
	new File:fhnd;
	new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
	if(fexist(string2)) return false;
	fhnd=fopen(string2,io_write);
	fclose(fhnd);
	return true;
}

stock  dini_RemoveGang(filename)
{
    new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
	if(!fexist(string2)) return false;
	fremove(string2);
	return true;
}

stock  dini_SetGang(filename,key[],value[])
{
    new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
    dini_Set(string2,key,value);
    return 0;
}

stock  dini_IntSetGang(filename,key[],value)
{
    new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
    return dini_IntSet(string2,key,value);
}

stock  dini_IntGang(filename,key[])
{
    new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
   	return dini_Int(string2,key);
}

stock  dini_FloatSetGang(filename,key[],Float:value)
{
    new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
	return dini_FloatSet(string2,key,value);
}

stock  Float:dini_FloatGang(filename,key[])
{
    new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
   	return Float:dini_Float(string2,key);
}

stock  dini_BoolGang(filename,key[])
{
    new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
   	return dini_Bool(string2,key);
}

stock  dini_BoolSetGang(filename,key[],value)
{
    new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
   	return dini_BoolSet(string2,key,value);
}

stock  dini_UnsetGang(filename,key[])
{
	new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
	dini_Unset(string2,key);
	return 0;
}

stock  dini_GetGang(filename,key[])
{
    new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
    format(string2,sizeof(string2),dini_Get(string2,key));
    return string2;
}

stock  dini_IssetGang(filename,key[])
{
    new string2[256];
	format(string2,sizeof(string2),"Gangs/gangid%d.txt",filename);
    return dini_Isset(string2,key);
}

stock CreateGang(gangid,gangname[],playerid)
{
	new string2[25];
	if(!dini_ExistsGang(gangid))
	{
	    dini_CreateGang(gangid);
	    dini_SetGang(gangid, "GangName", gangname);
	    dini_IntSetGang(gangid, "Lider", 1);
     	dini_IntSetGang(gangid, "SLider", 0);
     	dini_IntSetGang(gangid, "SubLiderOnline",0);
	    dini_IntSetGang(gangid, "Membros", 1);
	    dini_IntSetGang(gangid, "MembrosOnline",1);
	    dini_IntSetGang(gangid, "Grana", 0);
		dini_IntSetGang(gangid, "Kills", 0);
		dini_IntSetGang(gangid, "Deaths", 0);
		dini_IntSetGang(gangid, "MinGzs",0);
		dini_IntSetGang(gangid, "MinTerritorios",0);
		dini_IntSetGang(gangid, "MinColonias",0);
		dini_IntSetGang(gangid, "GangBase",0);
		dini_IntSetGang(gangid, "GangLevel",1);
		dini_IntSetGang(gangid, "GangWExp",0);
		dini_IntSetGang(gangid, "GangExp",10);
		format(string2,sizeof(string2),"%x",GetPlayerColor(playerid));
		dini_SetGang(gangid, "Color", string2);
	}
	return 1;
}

stock DeleteGang(gangid)
{
	if(dini_ExistsGang(gangid))
	{
	    dini_RemoveGang(gangid);
	}
	return 1;
}

stock GangGiveSLider(gangid)
{
    return dini_IntSetGang(gangid, "SLider",dini_IntGang(gangid, "SLider")+1);
}

stock GangTirarSLider(gangid)
{
    return dini_IntSetGang(gangid, "SLider",dini_IntGang(gangid, "SLider")-1);
}

stock PlayerEnterGang(gangid)
{
    return dini_IntSetGang(gangid, "Membros", dini_IntGang(gangid, "Membros")+1);
}

stock PlayerExitGang(gangid)
{
    return dini_IntSetGang(gangid, "Membros", dini_IntGang(gangid, "Membros")-1);
}

/*
native CreateGang(gangid,gangname[],playerid);
native CreateGangEspecial(gangid);
native DeleteGang(gangid);
native GangGiveSLider(gangid);
native GangTirarSLider(gangid);
native PlayerEnterGang(gangid);
native PlayerExitGang(gangid);
native dini_ExistsGang(gangid);
native dini_RemoveGang(gangid);
native dini_CreateGang(gangid);
native dini_SetGang(gangid,key[],value[]);
native dini_IntSetGang(gangid,key[],value);
native dini_IntGang(gangid,key[]);
native Float:dini_FloatGang(gangid,key[]);
native dini_BoolGang(gangid,key[]);
native dini_BoolSetGang(gangid,key[],value);
native dini_UnsetGang(gangid,key[]);
native dini_GetGang(gangid,key[]);
native dini_IssetGang(gangid,key[]);
*/
