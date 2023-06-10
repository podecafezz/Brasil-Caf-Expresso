//
//		Arquivo: natives.h
//
//		Autor: Victor
//
//		Data: 11/09/2012
//

#include "plugin.h"

#define MAX_NATIVES 2

cell AMX_NATIVE_CALL MarcarUltimaFuncao(AMX *amx, cell *params)
{  	
	char *strparams = NULL;		
	amx_StrParam(amx, params[1], strparams);
	
	cArquivos->Escrever("vDebug_UF.txt", strparams);
	return 1;
}

cell AMX_NATIVE_CALL LerUltimaFuncao(AMX *amx, cell *params)
{  	
	char tmpvar[64];
	cell *addr = NULL;
	
	cArquivos->Ler("vDebug_UF.txt", tmpvar);
	
    amx_GetAddr(amx, params[1], &addr);
    amx_SetString(addr, tmpvar, 0, 0, params[1]);
	return 1;
}