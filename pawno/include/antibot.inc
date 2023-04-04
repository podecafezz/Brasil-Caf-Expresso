//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//
/* ANTI-RECONNECT - © iPLEOMAX 2011 */
/* Do not remove the credits!       */
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//
/*

     Include feito por: iPLEOMAX
	 Linguagem (include): BR/PT
     Editado por: Skoolz.mk
	 Obrigado por baixar!        */

#if !defined _samp_included
    #tryinclude <a_samp>
    #if !defined _samp_included
        #error a_samp.inc must be included before using this.
    #endif
#endif

/*
native ARKick(playerid);
native ARConnect(playerid);
native ARDisconnect(playerid);
native ARIgnore(playerid);
*/

#define ARConnect(%0) AR_OnPlayerConnect(%0)
#define ARDisconnect(%0) AR_OnPlayerDisconnect(%0)
#define ARIgnore(%0) IPDATA[%0][Ignore] = true

#define MAX_R_ATTEMPTS 3
#define STATUS_SECONDS 20
#define RESET_CHECK 10

#define PUB:%1(%2) forward %1(%2); public %1(%2)

enum IP_DATA
{
	IP_ADDRESS[16],
	bool:Crashing,
	bool:Ignore
};

new
	IPDATA[MAX_PLAYERS][IP_DATA],
	Text:CrashTD,
	JoinAttempts,
	JoinIP[16]
;

PUB:AR_OnPlayerConnect(playerid)
{
	new CurIP[16]; GetPlayerIp(playerid, CurIP, sizeof CurIP);
	for(new i=0; i<MAX_PLAYERS; i++)
    {
    	if(strlen(IPDATA[i][IP_ADDRESS]) > 2 && !strcmp(CurIP,IPDATA[i][IP_ADDRESS],false))
     	{
      		printf("ID: %i Pode estar estar tentando fazer uma reconnect!",playerid);
            CrashPlayer(playerid, CurIP);
            break;
        }
	}
    if (!strcmp(CurIP, JoinIP, false))
	{
	    JoinAttempts++;
	    if (JoinAttempts >= MAX_R_ATTEMPTS)
	    {
	        CrashPlayer(playerid, CurIP);
	    }
	} else JoinAttempts = 0;
    GetPlayerIp(playerid, JoinIP, sizeof(JoinIP));
	return true;
}

PUB:AR_OnPlayerDisconnect(playerid)
{
	TextDrawHideForPlayer(playerid, CrashTD);
	IPDATA[playerid][Crashing] = false;
	IPDATA[playerid][Ignore] = false;
	return true;
}

PUB:CrashPlayer(playerid, playerIP[])
{
	new pName[MAX_PLAYER_NAME], string[566];
	GetPlayerName(playerid, pName, sizeof(pName));
	if(IPDATA[playerid][Crashing]) return true;
	IPDATA[playerid][Crashing] = true;
    printf("Houve uma RECONNECT no servidor %s(ID: %i)  IP: %s ",pName, playerid,playerIP);
	GameTextForPlayer(playerid, "~RECONNECT# NEVER~!~*%~",1000,3);
	GameTextForPlayer(playerid, "~MORRE*** ~HAHA",1000,3);
	GameTextForPlayer(playerid, "OTARIO ~xD",1000,3);
	TextDrawDestroy(CrashTD);
	CrashTD = TextDrawCreate(320,240,"~WTF");
	TextDrawShowForPlayer(playerid, CrashTD);
	format(string, sizeof(string), "{F81414}(»){FFFFFF} %s(%i) foi banido. Motivo: Reconnect de BOTS", pName, playerid);
	SendClientMessageToAll(-1, string);
    Ban(playerid);

	SetTimerEx("CrashStatus",STATUS_SECONDS*1000,false,"ds",playerid,playerIP);
	return true;
}

PUB:CrashStatus(playerid, playerIP[])
{
	new CurIP[16]; GetPlayerIp(playerid, CurIP, sizeof CurIP);
	if(IsPlayerConnected(playerid) && !strcmp(CurIP,playerIP,false))
	{ printf("Não foi crashado o player: ID %i. [ERRO]",playerid); }
	else
	{
	printf("(ID: %i) - (IP: %s) Foi CRASHADO com sucesso!",playerid,playerIP);
	}
	return true;
}

PUB:ARKick(playerid)
{
	if(!IPDATA[playerid][Ignore])
	{
		GetPlayerIp(playerid, IPDATA[playerid][IP_ADDRESS], 16);
		new rchck = RESET_CHECK;
		if(rchck != 0) SetTimerEx("ResetIPSlot", RESET_CHECK*1000, false, "d", playerid);
	}
	printf("{F81414}(AR-iPLEOMAX){FFFFFF} ARKick foi usado em (ID: %i).",playerid);
	Kick(playerid);
	return true;
}

PUB:ResetIPSlot(ipslotid)
{
	printf("[info] Resetted saved IP Slot %i [%s]",ipslotid, IPDATA[ipslotid][IP_ADDRESS]);
	format(IPDATA[ipslotid][IP_ADDRESS],16,"_");
	return true;
}

/*

     Include feito por: iPLEOMAX
	 Linguagem (include): BR/PT
     Editado por: Skoolz.mk
	 Obrigado por baixar!        */
