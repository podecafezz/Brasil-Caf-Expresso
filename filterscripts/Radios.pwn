#include <a_samp>

#define RadiobyMarci 1232


public OnPlayerConnect(playerid)
{
       OnPlayerCommandText(playerid, "/audiomsg");
       return true;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if(strcmp(cmdtext,"/radios",true) == 0)
    {
        ShowPlayerDialog(playerid, RadiobyMarci, DIALOG_STYLE_LIST,"{FFFF00}Sistema de Radios {FF0000}", "{FFFF00}Radio Total Dance\n{FFFF00}Radio Sound Pop\n{FFFF00}Radio Fusion\n{FFFF00}Radio Funk Brasil\n{FFFF00}Radio Jovem Pan\n{FFFF00}Radio Atlantida\n{FFFF00}Radio Dubstep\n{00FF00}Desligar Todas Rádios","Sicronizar", "Fechar");
        return true;
    }
    return false;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == RadiobyMarci)
    {
        if(response)
        {
            if(listitem == 0)
            {
                PlayAudioStreamForPlayer(playerid, "http://74.222.2.146:9358/");
                return true;
            }
            if(listitem == 1)
            {
                PlayAudioStreamForPlayer(playerid, "http://46.165.221.218:80/");
                return true;
            }
            if(listitem == 2)
            {
                PlayAudioStreamForPlayer(playerid, "http://65.60.25.242:8004/");
                return true;
            }
            if(listitem == 3)
            {
                PlayAudioStreamForPlayer(playerid, "http://64.56.64.84:9908");
                return true;
            }
            if(listitem == 4)
            {
                PlayAudioStreamForPlayer(playerid, "http://64.15.147.220:8042/");
                return true;
            }
            if(listitem == 5)
            {
                PlayAudioStreamForPlayer(playerid, "http://189.76.158.143:50002/");
                return true;
            }
            if(listitem == 6)
            {
                PlayAudioStreamForPlayer(playerid, "http://72.232.40.182:80");
                return true;
            }
            if(listitem == 7)
            {
                SendClientMessage(playerid, -1, "{FFFF00}Você Desligou a Rádio Com Sucesso!");
                StopAudioStreamForPlayer(playerid);
                return true;
            }
            return true;
        }
        return true;
    }
    return true;
}
