/*
								seif_walk - Walking styles by Seif
*/
/*x---------------------------------Important-------------------------------------x*/
//**INCLUDES**//
#include <a_samp>
/*x---------------------------------Defining-------------------------------------x*/
//**DEFINES**//
#define WALK_DEFAULT    0
#define WALK_NORMAL     1
#define WALK_PED        2
#define WALK_GANGSTA    3
#define WALK_GANGSTA2   4
#define WALK_OLD        5
#define WALK_FAT_OLD    6
#define WALK_FAT        7
#define WALK_LADY      	8
#define WALK_LADY2      9
#define WALK_WHORE      10
#define WALK_WHORE2     11
#define WALK_DRUNK     	12
#define WALK_BLIND     	13
#define WALK_SILENCED   14
#define WALK_LOC   	15
#define WALK_1   	16
#define WALK_2   	17
#define WALK_3   	18
#define WALK_4   	19
#define WALK_5    	20
#define WALK_6    	21
#define WALK_7    	22
#define WALK_8    	23
#define WALK_9    	24
#define WALK_10    	25
#define WALK_11    	26
#define WALK_12    	27
//**VARIABLES**//
new walktime[MAX_PLAYERS];
new WalkStyle[MAX_PLAYERS];
//**NATIVES**//
/*
	native SetPlayerWalkingStyle(playerid, style)
	native GetPlayerWalkingStyle(playerid)
*/
/*x---------------------------------CallBacks-------------------------------------x*/
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (((newkeys & KEY_WALK && newkeys & KEY_UP) || (newkeys & KEY_WALK && newkeys & KEY_DOWN) || (newkeys & KEY_WALK && newkeys & KEY_LEFT) || (newkeys & KEY_WALK && newkeys & KEY_RIGHT))
		|| ((oldkeys & KEY_WALK && newkeys & KEY_UP) || (oldkeys & KEY_WALK && newkeys & KEY_DOWN) || (oldkeys & KEY_WALK && newkeys & KEY_LEFT) || (oldkeys & KEY_WALK && newkeys & KEY_RIGHT))
		|| ((newkeys & KEY_WALK && oldkeys & KEY_UP) || (newkeys & KEY_WALK && oldkeys & KEY_DOWN) || (newkeys & KEY_WALK && oldkeys & KEY_LEFT) || (newkeys & KEY_WALK && oldkeys & KEY_RIGHT))
		&& GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
	return Walk_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
}

forward Walk_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);

#define OnPlayerKeyStateChange Walk_OnPlayerKeyStateChange

forward WalkAnim(playerid);
public  WalkAnim(playerid)
{
	new keys, updown, leftright;
	GetPlayerKeys(playerid,keys,updown,leftright);
	if (GetPlayerWalkingStyle(playerid) == WALK_NORMAL)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_PED)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WALK_civi",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_civi",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
 	else if (GetPlayerWalkingStyle(playerid) == WALK_GANGSTA)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_gang1",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_GANGSTA2)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_gang2",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_OLD)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WALK_old",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_old",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_FAT_OLD)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WALK_fatold",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_fatold",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_FAT)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WALK_fat",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_fat",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_LADY)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WOMAN_walknorm",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walknorm",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_LADY2)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WOMAN_walkbusy",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkbusy",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_WHORE)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WOMAN_walkpro",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkpro",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_WHORE2)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WOMAN_walksexy",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walksexy",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_DRUNK)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WALK_drunk",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WALK_drunk",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_BLIND)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","Walk_Wuzi",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","Walk_Wuzi",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_SILENCED)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","Player_Sneak",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","Player_Sneak",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_LOC)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_1)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","JOG_femaleA",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_2)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","JOG_maleA",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_3)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","run_civi",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_4)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","run_fat",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_5)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","run_fatold",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_6)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","run_gang1",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_7)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","run_old",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_8)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","Run_Wuzi",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_9)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","swat_run",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_10)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","woman_run",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_11)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WOMAN_runbusy",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_12)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid,"PED","WOMAN_runsexy",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0,"d",playerid);
		}
		else ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	return 1;
}

stock SetPlayerWalkingStyle(playerid, style)
{
	WalkStyle[playerid] = style;
}

stock GetPlayerWalkingStyle(playerid)
{
	return WalkStyle[playerid];
}
