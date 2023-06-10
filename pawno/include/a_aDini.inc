/*
 *            Dini 1.5.1
 *       (c) Copyright 2006 by DracoBlue
 *
 * @author    : DracoBlue (http://dracoblue.com)
 * @date      : 13th May 2006
 * @update    : 3rd June 2007
 * @require   : DUtils 1.8
 *
 * This file is provided as is (no warranties).
 *
 * Feel free to use it, a little message in
 * about box is honouring thing, isn't it?
 *
 */

#if defined _dini_included
  #endinput
#endif

#define _dini_included
#pragma library dutils
#pragma unused ret_memcpy
#pragma unused strtok

#include <a_samp>
#include <dutils>

/*
native dini_Exists(filename[]);
native dini_Remove(filename[]);
native dini_Create(filename[]);
native dini_CreatePlayer(filename[], pwd[]);
native dini_PRIVATE_ExtractKey(line[]);
native dini_PRIVATE_ExtractValue(line[]);
native dini_Set(filename[],key[],value[]);
native dini_IntSet(filename[],key[],value);
native dini_Int(filename[],key[]);
native Float:dini_Float(filename[],key[]);
native dini_Bool(filename[],key[]);
native dini_BoolSet(filename[],key[],value);
native dini_Unset(filename[],key[]);
native dini_Get(filename[],key[]);
native dini_Isset(filename[],key[]);
native dini_ExistsPlayer(filename[]);
native dini_RemovePlayer(filename[]);
native dini_CreatePlayer(filename[], pwd[]);
native dini_SetPlayer(filename[],key[],value[]);
native dini_IntSetPlayer(filename[],key[],value);
native dini_IntPlayer(filename[],key[]);
native Float:dini_FloatPlayer(filename[],key[]);
native dini_BoolPlayer(filename[],key[]);
native dini_BoolSetPlayer(filename[],key[],value);
native dini_UnsetPlayer(filename[],key[]);
native dini_GetPlayer(filename[],key[]);
native dini_IssetPlayer(filename[],key[]);*/

new BadNames[26][6] = {"con","nul","aux","prn","com0","com1","com2","com3","com4","com5","com6","com7","com8","com9","com10",
"ltp0","ltp1","ltp2","ltp3","ltp4","ltp5","ltp6","ltp7","ltp8","ltp9","ltp10"};

stock udb_hash(buf[])
{
	new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

stock codificador(senha[])
{
	for(new a=0; a < strlen(senha); a++)
	{
	    if(senha[a]>=65 && senha[a]<=77)
	    {
	        senha[a] += 13;
	    }
	    else if(senha[a]>77 && senha[a]<=90)
	    {
	        senha[a] -= 13;
	    }
	    else if(senha[a]>=48 && senha[a]<=52)
	    {
	        senha[a] += 5;
	    }
	    else if(senha[a]>52 && senha[a]<=57)
	    {
	        senha[a] -= 5;
	    }
	    else if(senha[a]>=97 && senha[a]<=109)
	    {
	        senha[a] += 13;
	    }
	    else if(senha[a]>109 && senha[a]<=122)
	    {
	        senha[a] -= 13;
	    }
	}
}

stock  dini_Exists(filename[])
{
	if (fexist(filename)) return true;
	return false;
}

stock  dini_Remove(filename[])
{
	if (!fexist(filename)) return false;
	fremove(filename);
	return true;
}

stock  dini_Create(filename[])
{
	new File:fhnd;
	if (fexist(filename)) return false;
	fhnd=fopen(filename,io_write);
	fclose(fhnd);
	return true;
}

stock udb_UserSetInt(filename[],key[],value)
{
	return dini_IntSet(filename,key,value);
}

stock udb_UserInt(filename[],key[])
{
	return dini_Int(filename,key);
}

stock udb_CheckLogin(filename[],pwd[])
{
	new fname[MAX_STRING];
	for(new i=0; i < strlen(filename); i++)
  	{
       	if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
  	format(fname,sizeof(fname),"Contas/%s.txt",filename);
  	if(udb_UserInt(fname,"Senha")==udb_hash(pwd)) return true;
  	return false;
}

stock  dini_PRIVATE_ExtractKey(line[])
{
	new tmp[MAX_STRING];
	tmp[0]=0;
	if (strfind(line,"=",true)==-1) return tmp;
	set(tmp,strlower(ret_memcpy(line,0,strfind(line,"=",true))));
	return tmp;
}

stock  dini_PRIVATE_ExtractValue(line[])
{
    new tmp[MAX_STRING];
    tmp[0]=0;
    if (strfind(line,"=",true)==-1)
	{
        return tmp;
    }
    set(tmp,ret_memcpy(line,strfind(line,"=",true)+1,strlen(line)));
    return tmp;
}

stock  dini_Set(filename[],key[],value[])
{
	new File:fohnd, File:fwhnd;
	new bool:wasset=false;
	new tmpres[MAX_STRING];
	if (key[0]==0) return false; /* If we have no sign in key, it can't be set*/
	format(tmpres,sizeof(tmpres),"%s.part",filename);
	fohnd=fopen(filename,io_read);
	if (!fohnd) return false;
	fremove(tmpres);
	fwhnd=fopen(tmpres,io_write);
	//  if (!fwhnd) return false;
	while (fread(fohnd,tmpres))
	{
		StripNewLine(tmpres);
		if ((!wasset)&&(equal(dini_PRIVATE_ExtractKey(tmpres),key,true))) {
			/* We've got what needs to be replaced! */
			format(tmpres,sizeof(tmpres),"%s=%s",key,value);
			wasset=true;
		}
		fwrite(fwhnd,tmpres);
		fwrite(fwhnd,"\r\n");
	}

	if (!wasset) {
		format(tmpres,sizeof(tmpres),"%s=%s",key,value);
		fwrite(fwhnd,tmpres);
		fwrite(fwhnd,"\r\n");
	}

	fclose(fohnd);
	fclose(fwhnd);

	format(tmpres,sizeof(tmpres),"%s.part",filename);
	if (fcopytextfile(tmpres,filename))
	{
		return fremove(tmpres);
	}
	return false;
}


stock  dini_IntSet(filename[],key[],value)
{
   new valuestring2[MAX_STRING];
   format(valuestring2,sizeof(valuestring2),"%d",value);
   return dini_Set(filename,key,valuestring2);
}

stock  dini_Int(filename[],key[])
{
   return strval(dini_Get(filename,key));
}

stock  dini_FloatSet(filename[],key[],Float:value)
{
   new valuestring2[MAX_STRING];
   format(valuestring2,sizeof(valuestring2),"%f",value);
   return dini_Set(filename,key,valuestring2);
}

stock  Float:dini_Float(filename[],key[])
{
   return floatstr(dini_Get(filename,key));
}

stock  dini_Bool(filename[],key[])
{
   return strval(dini_Get(filename,key));
}

stock  dini_BoolSet(filename[],key[],value)
{
   new valuestring2[MAX_STRING];
   format(valuestring2,sizeof(valuestring2),"%d",value);
   return dini_Set(filename,key,valuestring2);
}

stock  dini_Unset(filename[],key[])
{
	new File:fohnd, File:fwhnd;
	new tmpres[MAX_STRING];
	format(tmpres,sizeof(tmpres),"%s.part",filename);
	fohnd=fopen(filename,io_read);
	if (!fohnd) return false;
	fremove(tmpres);
	fwhnd=fopen(tmpres,io_write);
	//  if (!fwhnd) return false;
	while (fread(fohnd,tmpres)) {
		StripNewLine(tmpres);
		if (equal(dini_PRIVATE_ExtractKey(tmpres),key,true))
		{
			/* We've got what needs to be removed! */
		}
		else
		{
			format(tmpres,sizeof(tmpres),"%s",tmpres);
			fwrite(fwhnd,tmpres);
			fwrite(fwhnd,"\r\n");
		}
	}

	fclose(fohnd);
	fclose(fwhnd);

	format(tmpres,sizeof(tmpres),"%s.part",filename);
	if (fcopytextfile(tmpres,filename)) {
		return fremove(tmpres);
	}
	return false;
}

stock  dini_Get(filename[],key[])
{
	new File:fohnd;
	new tmpres[MAX_STRING];
	new tmpres2[MAX_STRING];
	tmpres[0]=0;
	fohnd=fopen(filename,io_read);
	if (!fohnd) return tmpres;
	while (fread(fohnd,tmpres))
	{
		StripNewLine(tmpres);
		if (equal(dini_PRIVATE_ExtractKey(tmpres),key,true))
		{
			/* We've got what we need */
			tmpres2[0]=0;
			strcat(tmpres2,dini_PRIVATE_ExtractValue(tmpres));
			fclose(fohnd);
			return tmpres2;
		}
	}
	fclose(fohnd);
	return tmpres;
}


stock  dini_Isset(filename[],key[])
{
	new File:fohnd;
	new tmpres[MAX_STRING];
	fohnd=fopen(filename,io_read);
	if (!fohnd) return false;
	while (fread(fohnd,tmpres))
	{
		StripNewLine(tmpres);
		if (equal(dini_PRIVATE_ExtractKey(tmpres),key,true))
		{
			/* We've got what we need */
			fclose(fohnd);
			return true;
		}
	}
	fclose(fohnd);
	return false;
}

stock  dini_ExistsPlayerEx(filename[])
{
    for(new d=0; d < sizeof(BadNames); d++) if(strfind(filename,BadNames[d],true)==0) return 0;
    new string2[256];
    new oldname[256];
    new oldname2[256];
    format(oldname2,256,"%s",filename);
    format(oldname,256,"Contas/%s.txt",filename);
    for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	if(fexist(oldname))
	{
	    new newname[256], senha[256];
	    format(newname,256,"Contas/%sa.txt",filename);
		frename(oldname,newname);
		if(fexist(string2)) fremove(string2);
		frename(newname,string2);
		if(!dini_Isset(string2,"AntiBug"))
		{
			format(senha,256,"%s",dini_Get(string2,"Senha"));
			dini_IntSet(string2,"AntiBug",1);
			dini_Unset(string2,"Senha");
			dini_Set(string2,"Senha",senha);
		}
	}
	format(filename,256,"%s",oldname2);
	if(fexist(string2)) return true;
	return false;
}

stock  dini_ExistsPlayer(filename[])
{
    new string2[256];
    new oldname[256];
    new oldname2[256];
    format(oldname2,256,"%s",filename);
    format(oldname,256,"Contas/%s.txt",filename);
    for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
    format(string2,sizeof(string2),"Contas/%s.txt",filename);
    format(filename,256,"%s",oldname2);
    if(fexist(string2) || fexist(oldname)) return true;
    return false;
}

stock dini_CreatePlayer(filename[], pwd[])
{
    for(new d=0; d < sizeof(BadNames); d++) if(strfind(filename,BadNames[d],true)==0) return 0;
	new File:fhnd;
	new string2[256];
    new oldname[256];
    format(oldname,256,"%s",filename);
	for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	format(filename,256,"%s",oldname);
	if(fexist(string2)) return false;
	fhnd=fopen(string2,io_write);
	dini_IntSet(string2,"AntiBug",1);
	udb_UserSetInt(string2,"Senha",udb_hash(pwd));
	fclose(fhnd);
	return true;
}

stock  dini_RemovePlayer(filename[])
{
    for(new d=0; d < sizeof(BadNames); d++) if(strfind(filename,BadNames[d],true)==0) return 0;
    new string2[256];
    new oldname[256];
    format(oldname,256,"%s",filename);
    for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	format(filename,256,"%s",oldname);
	if (!fexist(string2)) return false;
	fremove(string2);
	return true;
}

stock  dini_SetPlayer(filename[],key[],value[])
{
	//if(!dini_ExistsPlayer(filename)) return 0;
    new string2[256];
    new oldname[256];
    format(oldname,256,"%s",filename);
    for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	format(filename,256,"%s",oldname);
    return dini_Set(string2,key,value);
}

stock  dini_IntSetPlayer(filename[],key[],value)
{
    //if(!dini_ExistsPlayer(filename)) return 0;
    new string2[256];
    new oldname[256];
    format(oldname,256,"%s",filename);
    for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	format(filename,256,"%s",oldname);
    return dini_IntSet(string2,key,value);
}

stock  dini_IntPlayer(filename[],key[])
{
    //if(!dini_ExistsPlayer(filename)) return 0;
    new string2[256];
    new oldname[256];
    format(oldname,256,"%s",filename);
    for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	format(filename,256,"%s",oldname);
   	return dini_Int(string2,key);
}

stock  dini_FloatSetPlayer(filename[],key[],Float:value)
{
    //if(!dini_ExistsPlayer(filename)) return 0;
    new string2[256];
    new oldname[256];
    format(oldname,256,"%s",filename);
    for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	format(filename,256,"%s",oldname);
	return dini_FloatSet(string2,key,value);
}

stock  Float:dini_FloatPlayer(filename[],key[])
{
    //if(!dini_ExistsPlayer(filename)) return 0;
    new string2[256];
    new oldname[256];
    format(oldname,256,"%s",filename);
    for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	format(filename,256,"%s",oldname);
   	return Float:dini_Float(string2,key);
}

stock  dini_BoolPlayer(filename[],key[])
{
    //if(!dini_ExistsPlayer(filename)) return 0;
    new string2[256];
    new oldname[256];
    format(oldname,256,"%s",filename);
    for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	format(filename,256,"%s",oldname);
   	return dini_Bool(string2,key);
}

stock  dini_BoolSetPlayer(filename[],key[],value)
{
    //if(!dini_ExistsPlayer(filename)) return 0;
    new string2[256];
    new oldname[256];
    format(oldname,256,"%s",filename);
    for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	format(filename,256,"%s",oldname);
   	return dini_BoolSet(string2,key,value);
}

stock  dini_UnsetPlayer(filename[],key[])
{
    //if(!dini_ExistsPlayer(filename)) return 0;
    new string2[256];
    new oldname[256];
    format(oldname,256,"%s",filename);
	for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	format(filename,256,"%s",oldname);
	return dini_Unset(string2,key);
}

stock  dini_GetPlayer(filename[],key[])
{
    //if(!dini_ExistsPlayer(filename)) return 0;
    new string2[256];
    new oldname[256];
    format(oldname,256,"%s",filename);
    for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	format(string2,sizeof(string2),dini_Get(string2,key));
	format(filename,256,"%s",oldname);
    return string2;
}

stock  dini_IssetPlayer(filename[],key[])
{
    //if(!dini_ExistsPlayer(filename)) return 0;
    new string2[256];
    new oldname[256];
    format(oldname,256,"%s",filename);
    for(new i=0; i < strlen(filename); i++)
    {
        if(filename[i]>=65 && filename[i]<=90)
        {
            filename[i] += 32;
        }
    }
	format(string2,sizeof(string2),"Contas/%s.txt",filename);
	format(filename,256,"%s",oldname);
    return dini_Isset(string2,key);
}
