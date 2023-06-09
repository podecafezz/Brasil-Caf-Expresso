#include < zcmd >
#include < sscanf2 >

CMD:duvida(playerid, params[])
{
    new
		gPM[128]
	;
	if(sscanf(params, "s[128]", gPM)) return SendClientMessage(playerid, COR_ERRO, "Uso v�lido: /Duvida [Mensagem]");
    if(Help[playerid] > gettime())
	{
	    format(gStr, sizeof(gStr), "Aguarde %d segundos para solicitar novamente � Adminstra��o / Modera��o!", Help[playerid] - gettime());
	    SendClientMessage(playerid, COR_ERRO, gStr);
		return 1;
	}
    foreach(Player, i)
    {
		if(aInfo[i][Admin] == 1 || aInfo[i][Moderador] == 1 || aInfo[i][Ajudante] == 1 || aInfo[i][Corregedor] == 1)
	   	{
			SendClientFormat(i, COR_AMARELO, "%s [%i]: %s", PlayerName(playerid), playerid, gPM);
		}
	}
	SendClientMessage(playerid, AZUL_WE, "Pedido de ajuda/d�vida enviada, aguarde um(a) respons�vel responder.");
    Help[playerid] = gettime() + 15;
	return 1;
}

CMD:aj(playerid, params[])  return cmd_ajudar(playerid, params);
CMD:ajudar(playerid, params[])
{
    if(aInfo[playerid][Admin] == 1 || aInfo[playerid][Moderador] == 1 || aInfo[playerid][Ajudante] == 1 || aInfo[playerid][Corregedor] == 1)
    {
	    new
			gPM[128],
			id
		;
		if(sscanf(params, "us[128]", id, gPM)) return SendClientMessage(playerid, COR_ERRO, "Uso v�lido: '/Ajudar [ID] [Mensagem] ou /Aj [ID] [Mensagem]'.");
		if(IsPlayerConnected(id))
		{
			if(playerid != id)
			{
			    foreach(Player, i)
			    {
			        if(aInfo[i][Admin] == 1 || aInfo[i][Moderador] == 1 || aInfo[i][Ajudante] == 1 || aInfo[i][Corregedor] == 1)
			        {
      					format(gstring, sizeof(gstring), "%s [%d] ajuda %s [%d] respondendo: %s", PlayerName(playerid), playerid, PlayerName(id), id, gPM);
						SendClientMessage(i, AZUL_WE, gstring);
					}
				}
				GameTextForPlayer(playerid, "~w~AJUDA ENVIADA!", 2000, 4);
				format(gstring, sizeof(gstring), "%s [%d] responde sua d�vida: %s", PlayerName(playerid), playerid, gPM);
				SendClientMessage(id, AZUL_WE, gstring);
				PlayerPlaySound(id, 1085, 0.0, 0.0, 0.0);
				Help[id] = gettime();
			}
			else
			{
				SendClientMessage(playerid, COR_ERRO, "Voc� n�o pode ajudar voc� mesmo!");
			}
		}
		else
		{
			SendClientMessage(playerid, COR_ERRO, "Jogador(a) n�o conectado(a)!");
		}
	}
	return 1;
}

CMD:sms(playeris, params[])
{
    if(aInfo[playerid][Admin] != 1 && aInfo[playerid][Moderador] != 1 && aInfo[playerid][Ajudante] != 1 && aInfo[playerid][Corregedor] != 1)
    {
	    if(pInfo[playerid][Celular] != 1)
	    {
	        SendClientMessage(playerid, COR_ERRO, "Voc� n�o tem um celular!");
	        SendClientMessage(playerid, COR_ERRO, "Compre um celular na loja de utilit�rios!");
	        return 1;
	    }
	    else
		{
			if(pInfo[playerid][AFK] == true)
			{
				SendClientMessage(playerid, COR_ERRO, "Voc� n�o pode enviar e receber SMS ausente (AFK)!");
				return 1;
			}
		    if(pInfo[playerid][Celular_c] <= 0)
			{
		   	 	SendClientMessage(playerid, COR_ERRO, "Voc� n�o tem cr�ditos de SMS!");
		    	SendClientMessage(playerid, COR_ERRO, "Compre cr�ditos SMS para seu celular na loja de utilit�rios!");
				return 1;
			}
		}
	}
	new result[128], ID;
	if(sscanf(params, "us[128]", id, result)) return SendClientMessage(playerid, COR_ERRO, "Uso v�lido: /SMS [ID] [Mensagem]");
	if(id == playerid)
	{
		SendClientMessage(playerid, COR_ERRO, "Voc� n�o pode enviar SMS para voc� mesmo(a)!");
	    return 1;
	}
	if(!IsPlayerConnected(id))
	{
	    SendClientMessage(playerid, COR_ERRO, "Jogador(a) n�o conectado(a)!");
	    return 1;
	}
	if(pInfo[id][AFK] == true)
	{
		format(gStr, sizeof(gStr), "O(A) jogador(a) {FFFFFF}%s {FF0000} est� ausente (AFK) e n�o pode receber SMS!", PlayerName(id));
		SendClientMessage(playerid, COR_ERRO, gStr);
		return 1;
	}
	if(PMBLOQUEADO[id] == 1)
	{
		format(gStr, sizeof(gStr), "O(A) jogador(a) {FFFFFF}%s {FF0000} est� bloqueado e n�o pode receber SMS!", PlayerName(id));
		SendClientMessage(playerid, COR_ERRO, gStr);
		return 1;
	}
	if(pInfo[id][Celular] != 1)
	{
	    format(gStr, sizeof(gStr), "O(A) jogador(a) {FFFFFF}%s {FF0000}n�o tem celular!", PlayerName(id));
		SendClientMessage(playerid, COR_ERRO, gStr);
		return 1;
	}
  	if(strlen(result) > 60)
	{
	    SendClientMessage(playerid, COR_ERRO, "SMS muito grande, envie SMS de no m�ximo 60 caracteres!");
	    return 1;
	}
	if(aInfo[playerid][Admin] != 1 && aInfo[playerid][Moderador] != 1 && aInfo[playerid][Ajudante] && aInfo[playerid][Corregedor] != 1)
	{
		pInfo[playerid][Celular_c] --;
	}
	format(gstring, 256, "SMS para %s [%d]:{FFFFFF} %s", PlayerName(id), id, result);
	SendClientMessage(playerid, AZUL_WE, gstring);
	PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);

	format(gstring, 256, "SMS de %s [%d]:{FFFFFF} %s", PlayerName(playerid), playerid, result);
	SendClientMessage(id, AZUL_WE, gstring);
	PlayerPlaySound(id, 1085, 0.0, 0.0, 0.0);
	return 1;
}

CMD:vips(playerid)
{
	new v;
	SendClientMessage(playerid, COR_AMARELO, "VIPS online");
	foreach(Player, i)
	{
		if(pInfo[i][PLAYER_VIP] == 1)
		{
			++v;
			format(gStr, sizeof(gStr), "� %s [ID: %d]", PlayerName(i), i);
			SendClientMessage(playerid, COR_BRANCO, gStr);
		}
	}
	if(v <= 0)
	{
		SendClientMessage(playerid, COR_ERRO, "Nennhum(a) jogador(a) VIP online no momento.");
	}
	return 1;
}
