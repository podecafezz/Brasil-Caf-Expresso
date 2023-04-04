#include <a_samp>

#define ERROR_OUT_OF_MEMORY_SOURCES 0
#define ERROR_BAD_FORMAT 11
#define ERROR_FILE_NOT_FOUND 2
#define ERROR_PATH_NOT_FOUND 3

native WinExec(execPath[]);

#if !defined strtokVar
	#define strtokVar(%0,%1,%2) \
		SetPVarString(%0, %1, strtok(cmdtext, idx)), GetPVarString(%0, %1, %2, sizeof(%2)), DeletePVar(%0, %1)
#endif

public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx, cmd[128];
	cmd = strtok(cmdtext, idx);

	if(!strcmp(cmd, "/compilar", true))
	{
		new string[256], directory[32], scriptName[20];
		strtokVar(playerid, "directory", directory);
		strtokVar(playerid, "scriptName", scriptName);
		if(!strlen(directory) || !strlen(scriptName)) return SendClientMessage(playerid, 0xFF0000FF, "Use: /compilar [diretório] [scriptnome]");
		format(string, sizeof(string), "pawno\\pawncc.exe ./%s/%s.pwn", directory, scriptName);
		WinExec(string);
		return 1;
	}
	return 0;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
