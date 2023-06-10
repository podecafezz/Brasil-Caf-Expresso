//
//		Arquivo: arquivos.cpp
//
//		Autor: Victor
//
//		Data: 11/09/2012
//

#include "arquivos.h"

void CArquivos::Escrever(char *arquivo, char *texto)
{
	ofstream arq(arquivo);	

	arq << texto;
	arq.close();
	
#ifdef vDebug__DEBUG
	printf("Escrever %s - %s\n", arquivo, texto);
	Sleep(1000);
#endif
}

void CArquivos::Ler(char *arquivo, char *var)
{
	ifstream arq(arquivo);

	arq.getline(var, strlen(var));
	
#ifdef vDebug__DEBUG	
	printf("Ler %s - %s\n", arquivo, var);
	Sleep(1000);
#endif
}