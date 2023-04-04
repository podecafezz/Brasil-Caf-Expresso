////////////////////////////////////////////////////////////////////////////////
//
//
//        #### ########   ######     ######## ########    ###    ##     ##
//         ##  ##     ## ##    ##       ##    ##         ## ##   ###   ###
//         ##  ##     ## ##             ##    ##        ##   ##  #### ####
//         ##  ########   ######        ##    ######   ##     ## ## ### ##
//         ##  ##              ##       ##    ##       ######### ##     ##
//         ##  ##        ##    ##       ##    ##       ##     ## ##     ##
//        #### ##         ######        ##    ######## ##     ## ##     ##
//
//
//            Criado por Bruno da Silva (iPs DraKiNs) and [S]trong 
//                           Special thanks to Double-O-Seven
//
//                        !!!   NOW COMPACTIBLE DINI AND DOF2 FILES   !!!
//
//          Acesse meu blog sobre programação www.ips-team.blogspot.com
//
//          [iPs]TeaM soluções de programação em geral (agora com cursos)
//
//          		www.ips-team.6te.net/smforum (contate-nos)
//
//              [iPs]Ini Files (pós fini 5.0) Versão 3.0 (ultra rápido)
//
//
/////////////////////////////////////////////////////////////////////////////////


// Funções Atuais:

//   CallBack INI_WriteString("key", "valor")
//   CallBack INI_WriteFloat("key", valor)
//   CallBack INI_WriteInt("key", valor)
//   CallBack INI_WriteBool("key", bool:valor)

//   CallBack INI_ReadString("key")
//   CallBack INI_ReadInt("key")
//   CallBack INI_ReadFloat("key")
//   CallBack INI_ReadBool("key")

//   CallBack INI_Create()
//   CallBack INI_Delete()
//   CallBack INI_Open("arquivo")

//   CallBack INI_Isset("tag")
//   CallBack INI_Print()

//   CallBack INI_Close()
//   CallBack INI_Save()

#pragma dynamic 45000 
#define MAX_LINES		999
#define MAX_CHARS	256

#define CallBack%0(%1)	stock %0(%1)
#define Variable%0<%1>      	static stock %0[%1]


#define strcpy(%0,%1,%2)		strcat((%0[0] = EOS, %0), %1, %2 + 1)

#define INI_Isset(%0)			(INI_ReadInt(tagExists) == 0xFF)
#define INI_Create(%1)			fclose(fopen(%1, io_write))
#define INI_WriteBool(%0, %1) 		INI_WriteString(%0, %1 ? ("true") : ("false"))
#define INI_ReadInt(%0)			strval(INI_ReadString(%0))
#define INI_ReadFloat(%0)		floatstr(INI_ReadString(%0))
#define INI_Delete(%0)			fremove(%0)

////////////////////////////////////////////////////////////////////////////////




Variable nomeKey		<MAX_LINES>[MAX_CHARS >>> 1];
Variable valorKey		<MAX_LINES>[MAX_CHARS >>> 1];
Variable valorNumerico	<MAX_LINES>;
Variable nomeArquivo	<MAX_CHARS / 2>;
new totalLinhas = 0;

////////////////////////////////////////////////////////////////////////////////


static stringTemporariaRetornar[MAX_CHARS / 2] = "255";

CallBack INI_ReadString(keyGet[])
{	
	new i = 0, valorGetNumerico = INI_HashString(keyGet);

	
	for(i = 0;  i != totalLinhas ; ++i) if(valorGetNumerico == valorNumerico[i])
	{		
		if(strcmp(nomeKey[i], keyGet, false)) continue;

		return valorKey[i];
	}	
	return stringTemporariaRetornar;
}



////////////////////////////////////////////////////////////////////////////////

CallBack INI_Open(arquivoLer[])
{
	if((strlen(nomeKey[0]) || strlen(valorKey[0]))) INI_Save(), INI_Close();

	new
		bufferArquivo[MAX_CHARS],

		linhasArquivo = 0xFFFFFFFF,

		bufferIntArquivo = 0xFFFFFFFF,

		File:arquivoFopen = fopen(arquivoLer, io_read);


	format(nomeArquivo, MAX_CHARS >>> 2, arquivoLer);

	while(fread(arquivoFopen, bufferArquivo))
	{

		bufferIntArquivo = strfind(bufferArquivo, "=", true);

		if(bufferIntArquivo == -1 || bufferIntArquivo > MAX_CHARS) continue;
		
		#if defined DOF2_SetInt
		{
			++bufferIntArquivo;
		}
		#endif 

		bufferArquivo[strlen(bufferArquivo) - 2]  = '\0';

		format(valorKey[++linhasArquivo], MAX_CHARS >>> 1, bufferArquivo[bufferIntArquivo+1]);

		#if defined DOF2_SetInt
		{
			bufferIntArquivo =- 2;
		}
		#endif 

		bufferArquivo[bufferIntArquivo] = EOS;

		format(nomeKey[linhasArquivo], MAX_CHARS >>> 1, bufferArquivo);

		valorNumerico[linhasArquivo] = INI_HashString(bufferArquivo);


	}
	totalLinhas = linhasArquivo+1;

	return fclose(arquivoFopen), true;
}


////////////////////////////////////////////////////////////////////////////////

CallBack INI_HashString(buffer[]) 
{
	new totalContado = 0;
	for(new i = strlen(buffer); i != -1; i--)
	{
		totalContado += buffer[i];
	}
	return  totalContado;
}

////////////////////////////////////////////////////////////////////////////////

CallBack INI_Save()
{
	new
		i = 0,
		line[MAX_CHARS]
	;

	new File:arquivoFopen = fopen(nomeArquivo, io_write);

	for( ; i != totalLinhas ; ++i)
	{		
		format(line, MAX_CHARS, "%s=%s\r\n", nomeKey[i], valorKey[i]);
		fwrite(arquivoFopen, line);
	}
	return fclose(arquivoFopen);
}

////////////////////////////////////////////////////////////////////////////////

CallBack INI_Print()
{
	for(new i ; i != totalLinhas ; ++i)
	{
		printf("%s=%s",nomeKey[i],valorKey[i]);
	}
	return true;
}

////////////////////////////////////////////////////////////////////////////////

CallBack INI_Close()
{
	nomeArquivo[0] = EOS;
	
	for(new i; i != totalLinhas ; ++i)
	{
		nomeKey[i][0] = EOS;
		valorKey[i][0] = EOS;
		valorNumerico[i] = 0;
	}	
	return totalLinhas = 0, true;
}

////////////////////////////////////////////////////////////////////////////////

CallBack INI_WriteString(keySet[], valueSet[])
{
	
	new i, valorGetNumerico = INI_HashString(keySet);


	for( ;  i != totalLinhas ; ++i) if(valorGetNumerico == valorNumerico[i])
	{
		if(strcmp(nomeKey[i], keySet, false)) continue;

		return strcpy(valorKey[i], valueSet, MAX_CHARS);		
	}
	valorNumerico[i]=valorGetNumerico ;

	return strcpy(nomeKey[i], keySet, MAX_CHARS), strcpy(valorKey[i], valueSet, MAX_CHARS), totalLinhas++, true;
}


////////////////////////////////////////////////////////////////////////////////

CallBack INI_ReadBool(keySet[], valueSet)
{
	static destinoString[20];
	format(destinoString, sizeof(destinoString), "%i", valueSet);
	return !strcmp(destinoString, "false") ? (false) : (true);
}


////////////////////////////////////////////////////////////////////////////////

CallBack INI_WriteInt(keySet[], valueSet)
{
	static destinoString[20];
	format(destinoString, sizeof(destinoString), "%i", valueSet);
	return INI_WriteString(keySet, destinoString);
}

////////////////////////////////////////////////////////////////////////////////

CallBack INI_WriteFloat(keySet[],Float:valueSet)
{
	static destinoString[20];
	format(destinoString, sizeof(destinoString), "%f", valueSet);
	
	return INI_WriteString(keySet, destinoString);
}


/*
 *            Dini 1.5.1
 *       (c) Copyright 2006 by DracoBlue
 *
 * @author    : DracoBlue (http://dracoblue.com)
 * @date      : 13th May 2006
 * @update    : 2rd Oct 2011 (Bruno da Silva bIni dini Update)
 * @require   : DUtils 1.8
 *
 * This file is provided as is (no warranties).
 *
 * Feel free to use it, a little message in
 * about box is honouring thing, isn't it?
 *
 */


#define MAX_STRING 0xFF
#if defined _dini_included
  #endinput
#endif

#define _dini_included
#pragma library dini

#if defined MAX_STRING
#define DINI_MAX_STRING MAX_STRING
#else
#define DINI_MAX_STRING 255
#endif

stock dini_Exists(filename[]) {
	return fexist(filename);
}

stock dini_Remove(filename[]) {
	return fremove(filename);
}

stock dini_Create(filename[]) {
	if (fexist(filename)) return false;
	new File:fhnd;
	fhnd=fopen(filename,io_write);
	if (fhnd) {
		fclose(fhnd);
		return true;
	}
	return false;
}

stock  dini_Set(filename[],key[],value[])
{
	static
		antigoFile[48]
	;

	if(!strcmp(filename, antigoFile, true) && strlen(antigoFile))
	{
		
		INI_WriteString(key, value);		
	}
	else
	{
		if(strlen(antigoFile) > 1) 
		{
			INI_Save(), INI_Close();
		}

		INI_Open(filename);

		format(antigoFile, 48, filename);

		INI_WriteString(key, value);	

		
	}	
	return true;
}


stock  dini_Get(filename[], key[]) 
{
	static
		antigoFile[48],
		retornoValue[255]
	;

	if(!strcmp(filename, antigoFile, true) && strlen(antigoFile))
	{
		return retornoValue = INI_ReadString(key), retornoValue;
	}

	if(strlen(antigoFile) > 1)
	{
		INI_Save(), INI_Close();
	}

	INI_Open(filename);
		
	format(antigoFile, 48, filename);

	return retornoValue = INI_ReadString(key), retornoValue;
}


stock dini_IntSet(filename[],key[],value) {
   new valuestring[DINI_MAX_STRING];
   format(valuestring,DINI_MAX_STRING,"%d",value);
   return dini_Set(filename,key,valuestring);
}

stock dini_Int(filename[],key[]) {
   return strval(dini_Get(filename,key));
}

stock dini_FloatSet(filename[],key[],Float:value) {
   new valuestring[DINI_MAX_STRING];
   format(valuestring,DINI_MAX_STRING,"%f",value);
   return dini_Set(filename,key,valuestring);
}

stock Float:dini_Float(filename[],key[]) {
   return floatstr(dini_Get(filename,key));
}

stock dini_Bool(filename[],key[]) {
   return strval(dini_Get(filename,key));
}

stock dini_BoolSet(filename[],key[],value) {
	if (value) {
		return dini_Set(filename,key,"1");
	}
	return dini_Set(filename,key,"0");
}

stock dini_Unset(filename[],key[]) {
	// If we have no key, it can't be set
	// we also have no chance to unset the key, if all together is bigger then the max string
	new key_length = strlen(key);
	if (key_length==0 || key_length+2>DINI_MAX_STRING) return false;
	
	new File:fohnd, File:fwhnd;
	new tmpres[DINI_MAX_STRING];
	
	// Let's remove the old *.part file if there was one.
	format(tmpres,DINI_MAX_STRING,"%s.part",filename);
	fremove(tmpres);
	
	// We'll open the source file.
	fohnd=fopen(filename,io_read);
	if (!fohnd) return false;
	
	fwhnd=fopen(tmpres,io_write);
	if (!fwhnd) {
		// we can't open the second file for writing, so .. let's close the open one and exit.
		fclose(fohnd);
		return false;
	}
	
	while (fread(fohnd,tmpres)) {
		if (
			tmpres[key_length]=='='
			&& !strcmp(tmpres, key, true, key_length)	
		) {
				// We've got what needs to be removed!
		} else {
			DINI_StripNewLine(tmpres);
			fwrite(fwhnd,tmpres);
			fwrite(fwhnd,"\r\n");
		}
	}
	
	fclose(fohnd);
	fclose(fwhnd);

	format(tmpres,DINI_MAX_STRING,"%s.part",filename);
	if (DINI_fcopytextfile(tmpres,filename)) {
		return fremove(tmpres);
	}
	return false;
}



stock  dini_Isset(filename[],key[]) {
	new File:fohnd;
	new tmpres[MAX_STRING];
	fohnd=fopen(filename,io_read);
	if (!fohnd) return false;
	while (fread(fohnd,tmpres)) {
		StripNewLine(tmpres);
		if (equal(dini_PRIVATE_ExtractKey(tmpres),key,true)) {
			/* We've got what we need */
			fclose(fohnd);
			return true;
		}
	}
	fclose(fohnd);
	return false;
}

stock DINI_StripNewLine(string[]) {
	new len = strlen(string);
	if (string[0]==0) return ;
	if ((string[len - 1] == '\n') || (string[len - 1] == '\r')) {
		string[len - 1] = 0;
		if (string[0]==0) return ;
		if ((string[len - 2] == '\n') || (string[len - 2] == '\r')) string[len - 2] = 0;
	}
}

stock DINI_fcopytextfile(oldname[],newname[]) {
	new File:ohnd,File:nhnd;
	if (!fexist(oldname)) return false;
	ohnd=fopen(oldname,io_read);
	if (!ohnd) return false;
	nhnd=fopen(newname,io_write);
	if (!nhnd) {
		fclose(ohnd);
		return false;
	}
	new tmpres[DINI_MAX_STRING];
	while (fread(ohnd,tmpres)) {
		DINI_StripNewLine(tmpres);
		format(tmpres,sizeof(tmpres),"%s\r\n",tmpres);
		fwrite(nhnd,tmpres);
	}
	fclose(ohnd);
	fclose(nhnd);
	return true;
}