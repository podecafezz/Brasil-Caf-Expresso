/*
	Strip-Tease functions include
			 Created by:
	Rafael -> rafael_msn_7@hotmail.com
	Texugo -> texugo_cs@hotmail.com
*/

#include <a_samp>

new MakingStrip[MAX_PLAYERS];
new TimerStrip[MAX_PLAYERS];
new MST[MAX_PLAYERS];

forward ST_OnPlayerConnect(playerid);
forward ST_OnPlayerKeyStateChange(playerid,newkeys,oldkeys);
forward ApplyPlayerStripTease(playerid);
forward ClearPlayerStripTease(playerid);
forward PayStripTease(playerid,recieverid,amount);
forward EndPay(playerid,pickup);
forward MakingStripTease(playerid);

/*Natives
native ApplyPlayerStripTease(playerid);
native ClearPlayerStripTease(playerid);
native PayStripTease(playerid,recieverid,amount);
native ST_OnPlayerConnect(playerid);
native ST_OnPlayerKeyStateChange(playerid,newkeys,oldkeys);
*/

stock ST_GetXYInFrontOfPlayer(playerid,&Float:x,&Float:y,Float:distance) // By Y_Less
{
	new Float:a;
    GetPlayerPos(playerid,x,y,a);
    GetPlayerFacingAngle(playerid,a);
    if (GetPlayerVehicleID(playerid)){
        GetVehicleZAngle(GetPlayerVehicleID(playerid),a);
    }
    x+=(distance*floatsin(-a,degrees));
    y+=(distance*floatcos(-a,degrees));
}

stock IsPlayerMakingStripTease(playerid)return MakingStrip[playerid];

public ST_OnPlayerConnect(playerid)
{
	MakingStrip[playerid]=0;
	MST[playerid]=0;
	if(!TimerStrip[playerid]){}
	else KillTimer(TimerStrip[playerid]);
}

public ST_OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
    if((newkeys==8192)&&(MakingStrip[playerid]==1)&&(MST[playerid]==0)){
		KillTimer(TimerStrip[playerid]);
		ApplyAnimation(playerid,"STRIP","STR_C1",4.1,0,1,1,1,1);
		MST[playerid]=1;
		TimerStrip[playerid]=SetTimerEx("MakingStripTease",5500,false,"d",playerid);
	}
	if((newkeys==16384)&&(MakingStrip[playerid] == 1)&&(MST[playerid] == 0)){
		KillTimer(TimerStrip[playerid]);
		ApplyAnimation(playerid,"STRIP","STR_B2C",4.1,0,1,1,1,1);
		MST[playerid]=1;
		TimerStrip[playerid]=SetTimerEx("MakingStripTease",5000,false,"d",playerid);
	}
    if((newkeys==16)&&(MakingStrip[playerid] == 1)&&(MST[playerid]==0)){
		KillTimer(TimerStrip[playerid]);
		ApplyAnimation(playerid,"STRIP","STR_C2",4.1,0,1,1,1,1);
		MST[playerid]=1;
		TimerStrip[playerid]=SetTimerEx("MakingStripTease",5000,false,"d",playerid);
	}
	if((newkeys==32)&&(MakingStrip[playerid]==1)&&(MST[playerid]==0)){
		KillTimer(TimerStrip[playerid]);
		ApplyAnimation(playerid,"STRIP","STR_A2B",4.1,0,1,1,1,1);
		MST[playerid]=1;
		TimerStrip[playerid]=SetTimerEx("MakingStripTease",4500,false,"d",playerid);
	}
}

public ApplyPlayerStripTease(playerid)
{
    ApplyAnimation(playerid,"STRIP","STR_Loop_A",4.1,0,1,1,1,1);
	MakingStrip[playerid]=1;
	TogglePlayerControllable(playerid,0);
	TimerStrip[playerid]=SetTimerEx("MakingStripTease",100,false,"d",playerid);
}

public ClearPlayerStripTease(playerid)
{
    ClearAnimations(playerid);
	MakingStrip[playerid]=0;
 	KillTimer(TimerStrip[playerid]);
  	MST[playerid]=0;
   	TogglePlayerControllable(playerid,1);
}

public PayStripTease(playerid,recieverid,amount)
{
	new pickupmoney;
	if((MakingStrip[playerid]==0)&&(MakingStrip[recieverid]==1)){
		TogglePlayerControllable(playerid,0);
		GivePlayerMoney(recieverid,amount);
		GivePlayerMoney(playerid,-amount);
		KillTimer(TimerStrip[recieverid]);
		MST[recieverid]=1;
		ApplyAnimation(playerid,"STRIP","PLY_CASH",4.1,0,1,1,1,1);
		ApplyAnimation(recieverid,"STRIP","STR_A2B",4.1,0,1,1,1,1);
		TimerStrip[recieverid]=SetTimerEx("MakingStripTease",4500,false,"d",recieverid);
		new Float:X,Float:Y,Float:Z;
		GetPlayerPos(recieverid,X,Y,Z);
		ST_GetXYInFrontOfPlayer(recieverid,X,Y,0.4);
		pickupmoney=CreatePickup(1212,1,X,Y,Z-0.7);
		SetTimerEx("EndPay",1300,false,"dd",playerid,pickupmoney);
	}
}

public EndPay(playerid,pickup){
	DestroyPickup(pickup);
	TogglePlayerControllable(playerid,1);
}

public MakingStripTease(playerid)
{
	if(MakingStrip[playerid]==1){
 		MST[playerid]=0;
      	ApplyAnimation(playerid,"STRIP","STR_Loop_A",4.1,0,1,1,1,1);
	  	KillTimer(TimerStrip[playerid]);
	  	TimerStrip[playerid]=SetTimerEx("MakingStripTease",100,false,"d",playerid);
   	}
}
