#include <a_samp>
//------------------------------------------------------------------------------
public OnFilterScriptInit()
{
return 1;
}
public OnFilterScriptExit()
{
return 1;
}
//------------------------------------------------------------------------------
public OnPlayerConnect(playerid)
{
return 1;
}
//------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid)
{
return 1;
}
//------------------------------------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
{
//------------------------------------------------------------------------------
//CMD List Anims
if(strcmp("/anims", cmdtext, true) == 0)
{
SendClientMessage(playerid, 0x000000AA, ".•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.");
SendClientMessage(playerid,  0xADFF2FAA, "Faction RPG Lista de Anims");
SendClientMessage(playerid,  0xFFE4C4AA, "/renderse /ligar /desligar /bebado /bomba /apontar /observar ");
SendClientMessage(playerid,  0xADFF2FAA, "/roubar /deitar /abaixar /vomitar /comer /acenar /passaramao");
SendClientMessage(playerid,  0xFFE4C4AA, "/cobrar /overdose /fumar /fumar2 /sentar /conversar /fodase");
SendClientMessage(playerid, 0x000000AA, ".•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.•.");
return 1;
//------------------------------------------------------------------------------
if(strcmp("/renderse", cmdtext, true) == 0)
{
SetPlayerSpecialAction(playerid, 10);
return 1;
}
if(strcmp("/ligar", cmdtext, true) == 0)
{
SetPlayerSpecialAction(playerid, 11);
return 1;
}
if(strcmp("/desligar", cmdtext, true) == 0)
{
SetPlayerSpecialAction(playerid, 13);
return 1;
}
if(strcmp("/bebado", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 0);
return 1;
}
if(strcmp("/bomba", cmdtext, true) == 0)
{
ClearAnimations(playerid);
ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
return 1;
}
if(strcmp("/apontar", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1);
return 1;
}
if(strcmp("/roubar", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0);
return 1;
}
if(strcmp("/deitar", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0);
return 1;
}
if(strcmp("/abaixar", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0);
return 1;
}
if(strcmp("/vomitar", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0);
return 1;
}
if(strcmp("/comer", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);
return 1;
}
if(strcmp("/acenar", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0);
return 1;
}
if(strcmp("/passaramao", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
return 1;
}
if(strcmp("/cobrar", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
return 1;
}
if(strcmp("/overdose", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
return 1;
}
if(strcmp("/fumar", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0);
return 1;
}
if(strcmp("/fumar2", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0);
return 1;
}
if(strcmp("/sentar", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0);
return 1;
}
if(strcmp("/conversar", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.0, 0, 0, 0, 0, 0);
return 1;
}
if(strcmp("/fodase", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "PED", "fucku", 4.0, 0, 0, 0, 0, 0);
return 1;
}
if(strcmp("/observar", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "BAR", "dnk_stndF_loop", 4.0, 1, 0, 0, 0, 0);
return 1;
}
}
}
//------------------------------------------------------------------------------
