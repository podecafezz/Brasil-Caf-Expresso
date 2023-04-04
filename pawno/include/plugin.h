//
//		Arquivo: plugin.h
//
//		Autor: Victor
//
//		Data: 11/09/2012
//

#pragma once

#include "main.h"
#include "arquivos.h"

typedef void (*logprintf_t)(char* format, ...);
logprintf_t logprintf;

void **ppPluginData;

extern void *pAMXFunctions;

CArquivos* cArquivos;