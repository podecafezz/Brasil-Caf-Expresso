#include "a_samp.inc"

new mute[MAX_PLAYERS][2];
new LockServ;

forward playermute(playerid);

public OnFilterScriptInit()
{
	print("\n___________________________________________");
	print("          Comandos Extras para Rcon          ");
	print("___________________________________________\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
	mute[playerid][0] = 0;
	if(LockServ == 1)
	{
		Kick(playerid);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	mute[playerid][0] = 0;
	return 1;
}

public OnPlayerText(playerid)
{
	if(mute[playerid][0] > 1)
	{
		return 0;
	}
	return 1;
}

public OnRconCommand(cmd[])
{
	new cmdEx[256], idx;
	cmdEx = strtok(cmd, idx);

	if(!strcmp(cmd, "extra", true))
	{
		SendRconCommand("echo  Comandos Extras para RCON:");
		SendRconCommand("echo  congelar [ID]");
		SendRconCommand("echo  descongelar [ID]");
		SendRconCommand("echo  mutar [ID] [segundos 0 à 600]");
		SendRconCommand("echo  desmutar [ID]");
		SendRconCommand("echo  setarvida [ID] [vida de 0 à 100]");
		SendRconCommand("echo  setarcolete [ID] [colete de 0 à 100]");
		SendRconCommand("echo  setardinheiro [ID] [dinheiro de 0 à 9999999]");
		SendRconCommand("echo  nivelprocurado [ID] [nível de procura de 0 à 6]");
		SendRconCommand("echo  anunciar [mensagem]");
		SendRconCommand("echo  trancarserver [0 = Aberto / 1 = Fechado]");
		SendRconCommand("echo  kikartodos");
		SendRconCommand("echo  kikarid [ID], [outro ID] [outro ID quantos quiser...]");
		SendRconCommand("echo  ejetar [ID]");
		SendRconCommand("echo  disarmar [ID]");
		SendRconCommand("echo  dararma [ID] [ID da arma] [Quantia da munição]");
		SendRconCommand("echo  setarhora [horário]");
		SendRconCommand("echo  admins");
		SendRconCommand("echo  respawn [ID]");
		SendRconCommand("echo  setarcor [ID] [cor]");
		SendRconCommand("echo  radiochat [Texto]");
		SendRconCommand("echo  fixrun");
		SendRconCommand("echo  setarnome [ID] [novo nome]");
		return 1;
	}

	if(!strcmp(cmdEx, "congelar", true))
	{
		new id;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo congelar [ID]");
			return 1;
		}
		id = strval(cmdEx);
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		TogglePlayerControllable(id, 0);
		return 1;
	}

	if(!strcmp(cmdEx, "descongelar", true))
	{
		new id;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo descongelar [ID]");
			return 1;
		}
		id = strval(cmdEx);
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		TogglePlayerControllable(id, 1);
		return 1;
	}

	if(!strcmp(cmdEx, "mutar", true))
	{
		new id, seconds;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo mutar [ID] [segundos 0 à 600]");
			return 1;
		}
		id = strval(cmdEx);
		cmdEx = strtok(cmd,idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo mutar [ID] [segundos 0 à 600]");
			return 1;
		}
		seconds = strval(cmdEx);
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		if(seconds < 0 || seconds > 600)
		{
			SendRconCommand("echo Segundos de 0 à 600!");
			return 1;
		}
		mute[id][0] = seconds;
		mute[id][1] = SetTimerEx("playermute", 1000, 1, "i", id);
		return 1;
	}

	if(!strcmp(cmdEx, "desmutar", true))
	{
		new id;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo desmutar [ID]");
			return 1;
		}
		id = strval(cmdEx);
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		if(mute[id][0] == 0)
		{
		    new str[256];
		    format(str, sizeof(str), "echo Jogador ID %i não está mudo.", id);
			SendRconCommand(str);
			return 1;
		}
		mute[id][0] = 0;
		return 1;
	}

	if(!strcmp(cmdEx, "setarvida", true))
	{
		new id, health;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo setarvida [ID] [vida de 0 à 100]");
			return 1;
		}
		id = strval(cmdEx);
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo setarvida [ID] [vida de 0 à 100]");
			return 1;
		}
		health = strval(cmdEx);
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		if(health < 0 || health > 100)
		{
			SendRconCommand("echo A vida tem de ser de 0 à 100.");
			return 1;
		}
		SetPlayerHealth(id, health);
		return 1;
	}

	if(!strcmp(cmdEx, "setarcolete", true))
	{
		new id, armour;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo setarcolete [ID] [colete de 0 - 100]");
			return 1;
		}
		id = strval(cmdEx);
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo setarcolete [ID] [colete de 0 - 100]");
			return 1;
		}
		armour = strval(cmdEx);
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		if(armour < 0 || armour > 100)
		{
			SendRconCommand("echo Colete somente de 0 à 100.");
			return 1;
		}
		SetPlayerArmour(id, armour);
		return 1;
	}

	if(!strcmp(cmdEx, "setardinheiro", true))
	{
		new id, money;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo setardinheiro [ID] [dinheiro de 0 à 9999999]");
			return 1;
		}
		id = strval(cmdEx);
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo setardinheiro [ID] [dinheiro de 0 à 9999999]");
			return 1;
		}
		money = strval(cmdEx);
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		if(money < 0 || money > 99999999)
		{
			SendRconCommand("echo Dinheiro somente de 0 - 9999999.");
			return 1;
		}
		GivePlayerMoney(id, money-GetPlayerMoney(id));
		return 1;
	}

	if(!strcmp(cmdEx, "nivelprocurado", true))
	{
		new id, wanted;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo nivelprocurado [ID] [nivel de procurado de 0 à 6]");
			return 1;
		}
		id = strval(cmdEx);
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo nivelprocurado [ID] [nivel de procurado de 0 à 6]");
			return 1;
		}
		wanted = strval(cmdEx);
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		if(wanted < 0 || wanted > 6)
		{
			SendRconCommand("echo Nível de procurado somente de 0 à 6.");
			return 1;
		}
		SetPlayerWantedLevel(id, wanted);
		return 1;
	}

	if(!strcmp(cmdEx, "anunciar", true))
	{
		cmdEx = strrest(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo anunciar [mensagem]");
			return 1;
		}
		ClearChatboxForAll(30);
		GameTextForAll(cmdEx, 5000, 6);
		return 1;
	}

	if(!strcmp(cmdEx, "trancarserver", true))
	{
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo trancarserver [0 = Aberto / 1 = Fechado]");
			return 1;
		}
		LockServ = strval(cmdEx);
		return 1;
	}

	if(!strcmp(cmd, "kikartodos", true))
	{
		for(new all=0; all<=GetMaxPlayers(); all++)
		{
			if(IsPlayerConnected(all))
			{
				Kick(all);
			}
		}
		return 1;
	}

	if(!strcmp(cmdEx, "kikarid", true))
	{
		new id;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo kikarid [ID], [outro ID] [outro ID quantos quiser...]");
			return 1;
		}
		while(strlen(cmdEx) != 0)
		{
			id = strval(cmdEx);
			if(IsPlayerConnected(id))
			{
				Kick(id);
			}
			cmdEx = strtok(cmd, idx);
		}
		return 1;
	}

	if(!strcmp(cmdEx, "ejetar", true))
	{
		new id;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo ejetar [ID]");
			return 1;
		}
		id = strval(cmdEx);
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		RemovePlayerFromVehicle(id);
		return 1;
	}

	if(!strcmp(cmdEx, "disarmar", true))
	{
		new id;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo disarmar [ID]");
			return 1;
		}
		id = strval(cmdEx);
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		ResetPlayerWeapons(id);
		return 1;
	}

	if(!strcmp(cmdEx, "dararma", true))
	{
		new id, weaponid, ammo;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo dararma [ID] [ID da arma] [Quantia da munição]");
			return 1;
		}
		id = strval(cmdEx);
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo dararma [ID] [ID da arma] [Quantia da munição]");
			return 1;
		}
		weaponid = strval(cmdEx);
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			ammo = 500;
		}
		else
		{
			ammo = strval(cmdEx);
		}
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		GivePlayerWeapon(id, weaponid, ammo);
		return 1;
	}

	if(!strcmp(cmdEx, "setarhora", true))
	{
		new hour;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo setarhora [Horário]");
			return 1;
		}
		hour = strval(cmdEx);
		SetWorldTime(hour);
		return 1;
	}

	if(!strcmp(cmd, "admins", true))
	{
		new name[MAX_PLAYERS][MAX_PLAYER_NAME], admins=0, str[256];
		for(new i=0; i<=GetMaxPlayers(); i++)
		{
			if(IsPlayerConnected(i) && IsPlayerAdmin(i))
			{
				admins++;
				GetPlayerName(i, name[i], sizeof(name));
				format(str, sizeof(str), "echo Administradores online: (%i):", admins);
				SendRconCommand(str);
				for(new n=0; n<admins; n++)
				{
				    format(str, sizeof(str), "echo %i. %s [%i]", n, name[i], i);
					SendRconCommand(str);
				}
			}
		}
		return 1;
	}

	if(!strcmp(cmdEx, "respawn", true))
	{
		new id;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo respawn [ID]");
			return 1;
		}
		id = strval(cmdEx);
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		SpawnPlayer(id);
		return 1;
	}

	if(!strcmp(cmdEx, "setarcor", true))
	{
		new id, color;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo setarcor [ID] [cor]");
			return 1;
		}
		id = strval(cmdEx);
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo setarcor [ID] [cor]");
			return 1;
		}
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		if(!IsHex(cmdEx))
		{
			SendRconCommand("echo Cor inválido.");
			return 1;
		}
		color = strhex(cmdEx);
		SetPlayerColor(id, color);
		return 1;
	}

	if(!strcmp(cmdEx, "radiochat", true))
	{
		new Float:radius;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo radiochat [Texto]");
			return 1;
		}
		radius = floatstr(cmdEx);
		LimitGlobalChatRadius(radius);
		return 1;
	}

	if(!strcmp(cmdEx, "fixrun", true))
	{
		SendRconCommand("echo Agora os jogadores correram normalmente.");
		UsePlayerPedAnims();
		return 1;
	}

	if(!strcmp(cmdEx, "setarnome", true))
	{
		new id;
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo setarnome [ID] [novo nome]");
			return 1;
		}
		id = strval(cmdEx);
		cmdEx = strtok(cmd, idx);
		if(!strlen(cmdEx))
		{
			SendRconCommand("echo setarnome [ID] [novo nome]");
			return 1;
		}
		if(!IsPlayerConnected(id))
		{
			SendRconCommand("echo ID Inválido.");
			return 1;
		}
		new BadNameChars[][2] = {"/","`","~","!","@","#","$","%","^","&","*","(",")","-","=","+",".",",","<",">","[","]","{","}","|",":",";","'"};
		for(new i=0; i<sizeof(BadNameChars); i++)
		{
			if(strfind(cmdEx, BadNameChars[i], true) != -1 || strlen(cmdEx) > MAX_PLAYERS)
			{
				SendRconCommand("echo Nome inválido (Bad Nickname)");
				SendRconCommand("echo Somente use letras em maisculas, minusculas e números.");
				return 1;
			}
		}
		SetPlayerName(id, cmdEx);
		return 1;
	}

	new string2[256];
	format(string2, sizeof(string2), "echo Você digitou: %s - Comando inválido.", cmd);
	SendRconCommand(string2);
	return 1;
}

public playermute(playerid)
{
	while(mute[playerid][0] > 0)
	{
		mute[playerid][0]--;
	}
	if(mute[playerid][0] == 0)
	{
		KillTimer(mute[playerid][1]);
	}
	return 1;
}

stock ClearChatboxForAll(lines)
{
	for(new i = 0; i < lines; i++)
	{
		SendClientMessageToAll(-1, " ");
	}
	return 1;
}

stock strtok(const string[], &index)
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

stock strrest(const string[],index)
{
	new length = strlen(string);

	new offset = index;
	new result[256];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)) && (string[index] > '\r'))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock strhex(string[])
{
	new ret, val, i;
	if(string[0] == '0' && (string[1] == 'x' || string[1] == 'X'))
	{
		i = 2;
	}
	while(string[i])
	{
		ret <<= 4;
		val = (string[i++] - '0');
		if(val > 0x09)
		{
			val -= 0x07;
		}
		if(val > 0x0F)
		{
			val -= 0x20;
		}
		if(val < 0x01)
		{
			continue;
		}
		if(val < 0x10)
		{
			ret += val;
		}
	}
	return ret;
}

stock IsHex(string[])
{
	new i, cur;
	if(string[0] == '0' && (string[1] == 'x' || string[1] == 'X'))
	{
		i = 2;
	}
	while(string[i])
	{
		cur = string[i++];
		if((cur < '0') || (cur > '9' && cur < 'A') || (cur > 'F' && cur < 'a') || (cur > 'f'))
		{
			return false;
		}
	}
	return true;
}
