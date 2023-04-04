//
//		Arquivo: plugin.cpp
//
//		Autor: Victor
//
//		Data: 11/09/2012
//

#include "plugin.h"
#include "natives.h"

PLUGIN_EXPORT bool PLUGIN_CALL Load(void **ppData)
{
	pAMXFunctions = ppData[PLUGIN_DATA_AMX_EXPORTS];
	logprintf = (logprintf_t)ppData[PLUGIN_DATA_LOGPRINTF];	
		
	cArquivos = new CArquivos();
	
	logprintf("===============================\n\n");
	logprintf("Victor's Debug carregado\n\n");
	logprintf("===============================\n");
	
	return 1;
}

PLUGIN_EXPORT void PLUGIN_CALL Unload()
{
	logprintf("===============================\n\n");
	logprintf("Victor's Debug descarregado\n\n");
	logprintf("===============================\n");
}

AMX_NATIVE_INFO Natives[MAX_NATIVES+1] =
{
	{ "plugin_MarcarUltimaFuncao", MarcarUltimaFuncao },	
	{ "plugin_LerUltimaFuncao", LerUltimaFuncao },
	{ NULL, NULL },
};

PLUGIN_EXPORT unsigned int PLUGIN_CALL Supports()
{
   return SUPPORTS_VERSION | SUPPORTS_AMX_NATIVES;
}

PLUGIN_EXPORT int PLUGIN_CALL AmxLoad(AMX *amx)
{
	return amx_Register(amx, Natives, -1);
}

PLUGIN_EXPORT int PLUGIN_CALL AmxUnload(AMX *amx)
{
	return AMX_ERR_NONE;
}

