#include <a_samp>
new antifakekill[MAX_PLAYERS];
public OnFilterScriptInit()
{
    print(" Anti Fake Kill ");
    return 1;
}

public OnPlayerText(playerid, text[])
{
   if(strfind(text,"!kill",true) == 0) return Ban(playerid);
   if(strfind(text,"www.ec-clan.ru",true) == 0) return Ban(playerid);
   if(strfind(text,"www.Niex.cc",true) == 0) return Ban(playerid);
   if(strfind(text,"www.samphax.tk",true) ==0) return Ban(playerid);
   return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    antifakekill[playerid] ++;
    SetTimerEx("antifakekill2", 1000,false,"i",playerid);
    return 1;
}

forward antifakekill2(playerid);
public antifakekill2(playerid)
{
    antifakekill[playerid] --;
    if(antifakekill[playerid] > 5)
    {
        SendClientMessage(playerid, 0xFF0000AA, "Este servidor esta protegido por um Anti Fake Kill");
        Ban(playerid);
    }
    return 1;
}
