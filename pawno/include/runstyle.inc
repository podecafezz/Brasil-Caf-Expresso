
#include <a_samp>

#define RUN_0     1
#define RUN_1     2
#define RUN_2     3
#define RUN_3     4
#define RUN_4     5
#define RUN_5     6
#define RUN_6     7
#define RUN_7     8
#define RUN_8     9
#define RUN_9     10
#define RUN_10    11
#define RUN_11    12
#define RUN_12    13

new runtime[MAX_PLAYERS];
new RunStyle[MAX_PLAYERS];
new JaCorrendo[MAX_PLAYERS];

forward RunAnim(playerid);
public  RunAnim(playerid)
{
	new keys, updown, leftright;
	GetPlayerKeys(playerid,keys,updown,leftright);
	if ((keys & KEY_SPRINT) || (keys & KEY_SECONDARY_ATTACK) || (keys & KEY_WALK) || (keys & KEY_FIRE) || (keys & KEY_JUMP))
	{
	    JaCorrendo[playerid] = 0;
	    ApplyAnimation(playerid,"PED","run_rocket",4.0,0,0,0,0,1);
	    return true;
	}
	if (GetPlayerRunStyle(playerid) == RUN_0)
	{
 	 	if ((updown & KEY_UP) || (updown & KEY_DOWN) || (leftright & KEY_LEFT) || (leftright & KEY_RIGHT))
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","run_rocket",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
	else if (GetPlayerRunStyle(playerid) == RUN_1)
	{
 	 	if (updown == KEY_UP || updown == KEY_DOWN || leftright == KEY_LEFT || leftright == KEY_RIGHT || keys == KEY_RIGHT)
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","JOG_femaleA",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
 	else if (GetPlayerRunStyle(playerid) == RUN_2)
	{
 	 	if ((updown & KEY_UP) || (updown & KEY_DOWN) || (leftright & KEY_LEFT) || (leftright & KEY_RIGHT))
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","JOG_maleA",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
	else if (GetPlayerRunStyle(playerid) == RUN_3)
	{
 		if ((updown == KEY_UP) || (updown == KEY_DOWN) || (leftright == KEY_LEFT) || (leftright == KEY_RIGHT))
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","run_civi",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
	else if (GetPlayerRunStyle(playerid) == RUN_4)
	{
 	 	if ((updown & KEY_UP) || (updown & KEY_DOWN) || (leftright & KEY_LEFT) || (leftright & KEY_RIGHT))
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","run_fat",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
	else if (GetPlayerRunStyle(playerid) == RUN_5)
	{
 	 	if ((updown & KEY_UP) || (updown & KEY_DOWN) || (leftright & KEY_LEFT) || (leftright & KEY_RIGHT))
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","run_fatold",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
	else if (GetPlayerRunStyle(playerid) == RUN_6)
	{
 	 	if ((updown & KEY_UP) || (updown & KEY_DOWN) || (leftright & KEY_LEFT) || (leftright & KEY_RIGHT))
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","run_gang1",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
	else if (GetPlayerRunStyle(playerid) == RUN_7)
	{
 	 	if ((updown & KEY_UP) || (updown & KEY_DOWN) || (leftright & KEY_LEFT) || (leftright & KEY_RIGHT))
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","run_old",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
	else if (GetPlayerRunStyle(playerid) == RUN_8)
	{
 	 	if ((updown & KEY_UP) || (updown & KEY_DOWN) || (leftright & KEY_LEFT) || (leftright & KEY_RIGHT))
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","Run_Wuzi",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
	else if (GetPlayerRunStyle(playerid) == RUN_9)
	{
 	 	if ((updown & KEY_UP) || (updown & KEY_DOWN) || (leftright & KEY_LEFT) || (leftright & KEY_RIGHT))
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","swat_run",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
	else if (GetPlayerRunStyle(playerid) == RUN_10)
	{
 	 	if ((updown & KEY_UP) || (updown & KEY_DOWN) || (leftright & KEY_LEFT) || (leftright & KEY_RIGHT))
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","woman_run",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
	else if (GetPlayerRunStyle(playerid) == RUN_11)
	{
 	 	if ((updown & KEY_UP) || (updown & KEY_DOWN) || (leftright & KEY_LEFT) || (leftright & KEY_RIGHT))
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","WOMAN_runbusy",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
	else if (GetPlayerRunStyle(playerid) == RUN_12)
	{
 	 	if ((updown & KEY_UP) || (updown & KEY_DOWN) || (leftright & KEY_LEFT) || (leftright & KEY_RIGHT))
		{
		   	KillTimer(runtime[playerid]);
			ApplyAnimation(playerid,"PED","WOMAN_runsexy",4.1,1,1,1,1,1);
			runtime[playerid] = SetTimerEx("RunAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(runtime[playerid]);JaCorrendo[playerid] = 0;
	}
	return 1;
}

stock SetPlayerRunStyle(playerid, style)
{
	RunStyle[playerid] = style;
}

stock GetPlayerRunStyle(playerid)
{
	return RunStyle[playerid];
}
