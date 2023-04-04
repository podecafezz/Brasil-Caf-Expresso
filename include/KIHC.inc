new Mname[25] = " ";
new Enter[256] = "Enter";
new Buy[256] = "Buy"; 
new Rent[256] = "Rent";
new Exit[256] = "Exit";
new tot = 0;
forward OnPlayerCmdText(playerid,cmdtext[]);
forward OnPlayerSelectMenuRow(playerid,row); 

public OnPlayerCmdText(playerid, cmdtext[])
{
if (strcmp("/build house small", cmdtext, true) == 0)
	{
if (fexist("Setup.sts")){}
else{new File:sts0 = fopen("Setup.sts",io_write);fclose(sts0);}
new File:sts1 = fopen("Setup.sts",io_read);
new stsS[256];
new stsV =0 ;
new tot1 = 0;
new totS[256];
new totvS[256];
fread(sts1,stsS,256,false);
stsV = strval(stsS);
tot = stsV;
tot1 = tot + 1;
valstr(totS,tot,false);
valstr(totvS,tot1,false);
new File:sts2 = fopen("Setup.sts",io_write);
fwrite(sts2,totvS);
fclose(sts2);

new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
new File:Step1 = fopen("Step1.txt",io_append);
new AdStaticPickup[256];
if (tot == 0){
format(AdStaticPickup,150,"\r\n// Place This Under OnGameModeInit");fwrite(Step1,AdStaticPickup);}
format(AdStaticPickup,255,"\r\nAddStaticPickup(1239,2,%f,%f,%f);",X,Y,Z);
fwrite(Step1,AdStaticPickup);
fclose(Step1);


new File:Step2 = fopen("Step2.txt",io_append);
new gMenu[256];
if (tot == 0){
format(gMenu,150,"\r\n// Place This At The Top Of Your Script");fwrite(Step2,gMenu);}
format(gMenu,256,"\r\nnew Menu:gMenu%s;",totS);fwrite(Step2,gMenu);
format(gMenu,256,"\r\nnew Menu:gMenue%s;",totS);fwrite(Step2,gMenu);
fclose(Step2);

new File:Step3 = fopen("Step3.txt",io_append);
new pickup1[256];
new pickup2[256];
new pickup3[256];
new pickup4[256];
new pickup5[256];
new pickup6[256];
new pickup7[256];
if (tot == 0){
format(pickup1,150,"\r\n// Place This Under OnPlayerPickUpPickup");fwrite(Step3,pickup1);}
format(pickup1,256,"\r\nif ( pickupid == %s ){",totS);
format(pickup2,256,"\r\ngMenu%s = CreateMenu(Mname, 2, 50, 200, 41, 30);",totS);
format(pickup3,256,"\r\nAddMenuItem(gMenu%s,0,%s);",totS,Enter);
format(pickup4,256,"\r\nAddMenuItem(gMenu%s,0,%s);",totS,Buy);
format(pickup5,256,"\r\nAddMenuItem(gMenu%s,0,%s);",totS,Rent);
format(pickup6,256,"\r\nShowMenuForPlayer(gMenu%s,playerid);",totS);
format(pickup7,256,"\r\nTogglePlayerControllable(playerid,0);}",totS);
fwrite(Step3,pickup1);
fwrite(Step3,pickup2);
fwrite(Step3,pickup3);
fwrite(Step3,pickup4);
fwrite(Step3,pickup5);
fwrite(Step3,pickup6);
fwrite(Step3,pickup7);
fclose(Step3);

new File:Step4 = fopen("Step4.txt",io_append);
new line1[256];

new dash[20] = "Mname";
if (tot == 0){
format(line1,150,"\r\n// Place This Under OnPlayerSelectedMenuRow");fwrite(Step4,line1);
format(line1,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step4,line1);}
format(line1,256,"\r\nif (Current == gMenu%s) {",totS);
fwrite(Step4,line1);
format(line1,256,"\r\nswitch(row) {");
fwrite(Step4,line1);
format(line1,256,"\r\ncase 0: {",totS);
fwrite(Step4,line1);
new ran = random(4);
new houseo[256];
new housep[256];
if (ran == 0){
houseo = "SetPlayerInterior(playerid,1);";
housep = "SetPlayerPos(playerid,223.043991,1289.259888,1082.199951);";
}
if (ran == 1){
houseo = "SetPlayerInterior(playerid,15);";
housep = "SetPlayerPos(playerid,295.138977,1474.469971,1080.519897);";
}
if (ran == 2){
houseo = "SetPlayerInterior(playerid,15);";
housep = "SetPlayerPos(playerid,328.493988,1480.589966,1084.449951);";
}
if (ran == 3){
houseo = "SetPlayerInterior(playerid,10);";
housep = "SetPlayerPos(playerid,2262.83,-1137.71,1050.63);";
}
if (ran == 4){
houseo = "SetPlayerInterior(playerid,9);";
housep = "SetPlayerPos(playerid,2251.85,-1138.16,1050.63);";
}

format(line1,256,"\r\n%s",houseo);
fwrite(Step4,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step4,line1);
format(line1,256,"\r\ngMenue%s = CreateMenu(%s, 2, 50, 200, 25, 25);",totS,dash);
fwrite(Step4,line1);
format(line1,256,"\r\nAddMenuItem(gMenue%s, 0, %s);",totS,Exit);
fwrite(Step4,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s,playerid);",totS);
fwrite(Step4,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);}");
fwrite(Step4,line1);
format(line1,256,"\r\ncase 1:	{");
fwrite(Step4,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step4,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step4,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step4,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);}");
fwrite(Step4,line1);
format(line1,256,"\r\ncase 2: {");
fwrite(Step4,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);");
fwrite(Step4,line1);
format(line1,256,"}}}");
fwrite(Step4,line1);
format(line1,256,"\r\nif (Current == gMenue%s) {",totS);fwrite(Step4,line1);
format(line1,256,"\r\nswitch(row) {");fwrite(Step4,line1);
format(line1,256,"\r\ncase 0: {",totS);fwrite(Step4,line1);
format(line1,256,"\r\nSetPlayerInterior(playerid,0);");fwrite(Step4,line1);
format(line1,256,"\r\nSetPlayerPos(playerid,%f,%f,%f);}}}",X,Y,Z);
fwrite(Step4,line1);
fclose(Step4);
new File:Step5 = fopen("Step5.txt",io_append);
new line2[150];
if (tot == 0){
format(line2,150,"\r\n// Place This Under OnPlayerExitedMenu");fwrite(Step5,line2);
format(line2,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step5,line2);}
format(line2,150,"\r\nif( Current == gMenu%s){",totS);fwrite(Step5,line2);
format(line2,150,"\r\nTogglePlayerControllable(playerid,1);}");fwrite(Step5,line2);
fclose(Step5);

SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A Blue Print For The House Was Successfully Generated.");
	}

if (strcmp("/build house medium", cmdtext, true) == 0)
	{


if (fexist("Setup.sts")){}
else{new File:sts0 = fopen("Setup.sts",io_write);fclose(sts0);}
new File:sts1 = fopen("Setup.sts",io_read);
new stsS[256];
new stsV =0 ;
new tot1 = 0;
new totS[256];
new totvS[256];
fread(sts1,stsS,256,false);
stsV = strval(stsS);
tot = stsV;
tot1 = tot + 1;
valstr(totS,tot,false);
valstr(totvS,tot1,false);
new File:sts2 = fopen("Setup.sts",io_write);
fwrite(sts2,totvS);
fclose(sts2);

new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
new File:Step1 = fopen("Step1.txt",io_append);
new AdStaticPickup[256];
if (tot == 0){
format(AdStaticPickup,150,"\r\n// Place This Under OnGameModeInit");fwrite(Step1,AdStaticPickup);}
format(AdStaticPickup,255,"\r\nAddStaticPickup(1239,2,%f,%f,%f);",X,Y,Z);
fwrite(Step1,AdStaticPickup);
fclose(Step1);


new File:Step2 = fopen("Step2.txt",io_append);
new gMenu[256];
if (tot == 0){
format(gMenu,150,"\r\n// Place This At The Top Of Your Script");fwrite(Step2,gMenu);}
format(gMenu,256,"\r\nnew Menu:gMenu%s;",totS);fwrite(Step2,gMenu);
format(gMenu,256,"\r\nnew Menu:gMenue%s;",totS);fwrite(Step2,gMenu);
fclose(Step2);

new File:Step3 = fopen("Step3.txt",io_append);
new pickup1[256];
new pickup2[256];
new pickup3[256];
new pickup4[256];
new pickup5[256];
new pickup6[256];
new pickup7[256];
if (tot == 0){
format(pickup1,150,"\r\n// Place This Under OnPlayerPickUpPickup");fwrite(Step3,pickup1);}
format(pickup1,256,"\r\nif ( pickupid == %s ){",totS);
format(pickup2,256,"\r\ngMenu%s = CreateMenu(Mname, 2, 50, 200, 41, 30);",totS);
format(pickup3,256,"\r\nAddMenuItem(gMenu%s,0,%s);",totS,Enter);
format(pickup4,256,"\r\nAddMenuItem(gMenu%s,0,%s);",totS,Buy);
format(pickup5,256,"\r\nAddMenuItem(gMenu%s,0,%s);",totS,Rent);
format(pickup6,256,"\r\nShowMenuForPlayer(gMenu%s,playerid);",totS);
format(pickup7,256,"\r\nTogglePlayerControllable(playerid,0);}",totS);
fwrite(Step3,pickup1);
fwrite(Step3,pickup2);
fwrite(Step3,pickup3);
fwrite(Step3,pickup4);
fwrite(Step3,pickup5);
fwrite(Step3,pickup6);
fwrite(Step3,pickup7);
fclose(Step3);

new File:Step4 = fopen("Step4.txt",io_append);
new line1[256];
new dash[20] = "Mname";
if (tot == 0){
format(line1,150,"\r\n// Place This Under OnPlayerSelectedMenuRow");fwrite(Step4,line1);
format(line1,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step4,line1);}
format(line1,256,"\r\nif (Current == gMenu%s) {",totS);
fwrite(Step4,line1);
format(line1,256,"\r\nswitch(row) {");
fwrite(Step4,line1);
format(line1,256,"\r\ncase 0: {",totS);
fwrite(Step4,line1);
new ran = random(3);
new houseo[256];
new housep[256];
if (ran == 0){
houseo = "SetPlayerInterior(playerid,2);";
housep = "SetPlayerPos(playerid,225.756989,1240.000000,1082.149902);";
}
if (ran == 1){
houseo = "SetPlayerInterior(playerid,2);";
housep = "SetPlayerPos(playerid,2451.77, -1699.80,1013.51);";
}
if (ran == 2){
houseo = "SetPlayerInterior(playerid,15);";
housep = "SetPlayerPos(playerid,385.803986,1471.769897,1080.209961  );";
}
if (ran == 3){
houseo = "SetPlayerInterior(playerid,10);";
housep = "SetPlayerPos(playerid,2260.76,-1210.45,1049.02);";
}

format(line1,256,"\r\n%s",houseo);
fwrite(Step4,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step4,line1);
format(line1,256,"\r\ngMenue%s = CreateMenu(%s, 2, 50, 200, 25, 25);",totS,dash);
fwrite(Step4,line1);
format(line1,256,"\r\nAddMenuItem(gMenue%s, 0, %s);",totS,Exit);
fwrite(Step4,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s,playerid);",totS);
fwrite(Step4,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);}");
fwrite(Step4,line1);
format(line1,256,"\r\ncase 1:	{");
fwrite(Step4,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step4,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step4,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step4,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);}");
fwrite(Step4,line1);
format(line1,256,"\r\ncase 2: {");
fwrite(Step4,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);");
fwrite(Step4,line1);
format(line1,256,"}}}");
fwrite(Step4,line1);
format(line1,256,"\r\nif (Current == gMenue%s) {",totS);fwrite(Step4,line1);
format(line1,256,"\r\nswitch(row) {");fwrite(Step4,line1);
format(line1,256,"\r\ncase 0: {",totS);fwrite(Step4,line1);
format(line1,256,"\r\nSetPlayerInterior(playerid,0);");fwrite(Step4,line1);
format(line1,256,"\r\nSetPlayerPos(playerid,%f,%f,%f);}}}",X,Y,Z);
fwrite(Step4,line1);
fclose(Step4);
new File:Step5 = fopen("Step5.txt",io_append);
new line2[150];
if (tot == 0){
format(line2,150,"\r\n// Place This Under OnPlayerExitedMenu");fwrite(Step5,line2);
format(line2,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step5,line2);}
format(line2,150,"\r\nif ( Current == gMenu%s){",totS);fwrite(Step5,line2);
format(line2,150,"\r\nTogglePlayerControllable(playerid,1);}");fwrite(Step5,line2);
fclose(Step5);

SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A Blue Print For The House Was Successfully Generated.");
	}
if (strcmp("/build house large", cmdtext, true) == 0)
	{
if (fexist("Setup.sts")){}
else{new File:sts0 = fopen("Setup.sts",io_write);fclose(sts0);}
new File:sts1 = fopen("Setup.sts",io_read);
new stsS[256];
new stsV =0 ;
new tot1 = 0;
new totS[256];
new totvS[256];
fread(sts1,stsS,256,false);
stsV = strval(stsS);
tot = stsV;
tot1 = tot + 1;
valstr(totS,tot,false);
valstr(totvS,tot1,false);
new File:sts2 = fopen("Setup.sts",io_write);
fwrite(sts2,totvS);
fclose(sts2);


new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
new File:Step1 = fopen("Step1.txt",io_append);
new AdStaticPickup[256];
if (tot == 0){
format(AdStaticPickup,150,"\r\n// Place This Under OnGameModeInit");fwrite(Step1,AdStaticPickup);}
format(AdStaticPickup,255,"\r\nAddStaticPickup(1239,2,%f,%f,%f);",X,Y,Z);
fwrite(Step1,AdStaticPickup);
fclose(Step1);


new File:Step2 = fopen("Step2.txt",io_append);
new gMenu[256];
if (tot == 0){
format(gMenu,150,"\r\n// Place This At The Top Of Your Script");fwrite(Step2,gMenu);}
format(gMenu,256,"\r\nnew Menu:gMenu%s;",totS);fwrite(Step2,gMenu);
format(gMenu,256,"\r\nnew Menu:gMenue%s;",totS);fwrite(Step2,gMenu);
fclose(Step2);

new File:Step3 = fopen("Step3.txt",io_append);
new pickup1[256];
new pickup2[256];
new pickup3[256];
new pickup4[256];
new pickup5[256];
new pickup6[256];
new pickup7[256];
if (tot == 0){
format(pickup1,150,"\r\n// Place This Under OnPlayerPickUpPickup");fwrite(Step3,pickup1);}
format(pickup1,256,"\r\nif ( pickupid == %s ){",totS);
format(pickup2,256,"\r\ngMenu%s = CreateMenu(Mname, 2, 50, 200, 41, 30);",totS);
format(pickup3,256,"\r\nAddMenuItem(gMenu%s,0,%s);",totS,Enter);
format(pickup4,256,"\r\nAddMenuItem(gMenu%s,0,%s);",totS,Buy);
format(pickup5,256,"\r\nAddMenuItem(gMenu%s,0,%s);",totS,Rent);
format(pickup6,256,"\r\nShowMenuForPlayer(gMenu%s,playerid);",totS);
format(pickup7,256,"\r\nTogglePlayerControllable(playerid,0);}",totS);
fwrite(Step3,pickup1);
fwrite(Step3,pickup2);
fwrite(Step3,pickup3);
fwrite(Step3,pickup4);
fwrite(Step3,pickup5);
fwrite(Step3,pickup6);
fwrite(Step3,pickup7);
fclose(Step3);

new File:Step4 = fopen("Step4.txt",io_append);
new line1[256];

new dash[20] = "Mname";
if (tot == 0){
format(line1,150,"\r\n// Place This Under OnPlayerSelectedMenuRow");fwrite(Step4,line1);
format(line1,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step4,line1);}
format(line1,256,"\r\nif (Current == gMenu%s) {",totS);
fwrite(Step4,line1);
format(line1,256,"\r\nswitch(row) {");
fwrite(Step4,line1);
format(line1,256,"\r\ncase 0: {",totS);
fwrite(Step4,line1);
new ran = random(3);
new houseo[256];
new housep[256];
if (ran == 0){
houseo = "SetPlayerInterior(playerid,3);";
housep = "SetPlayerPos(playerid,235.508994,1189.169897,1080.339966);";
}
if (ran == 1){
houseo = "SetPlayerInterior(playerid,7);";
housep = "SetPlayerPos(playerid,225.630997,1022.479980,1084.069946);";
}
if (ran == 2){
houseo = "SetPlayerInterior(playerid,8);";
housep = "SetPlayerPos(playerid,2807.63,-1170.15,1025.57);";
}
if (ran == 3){
houseo = "SetPlayerInterior(playerid,1 );";
housep = "SetPlayerPos(playerid,-2158.72,641.29,1052.38);";
}

format(line1,256,"\r\n%s",houseo);
fwrite(Step4,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step4,line1);
format(line1,256,"\r\ngMenue%s = CreateMenu(%s, 2, 50, 200, 25, 25);",totS,dash);
fwrite(Step4,line1);
format(line1,256,"\r\nAddMenuItem(gMenue%s, 0, %s);",totS,Exit);
fwrite(Step4,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s,playerid);",totS);
fwrite(Step4,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);}");
fwrite(Step4,line1);
format(line1,256,"\r\ncase 1:	{");
fwrite(Step4,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step4,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step4,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step4,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);}");
fwrite(Step4,line1);
format(line1,256,"\r\ncase 2: {");
fwrite(Step4,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);");
fwrite(Step4,line1);
format(line1,256,"}}}");
fwrite(Step4,line1);
format(line1,256,"\r\nif (Current == gMenue%s) {",totS);fwrite(Step4,line1);
format(line1,256,"\r\nswitch(row) {");fwrite(Step4,line1);
format(line1,256,"\r\ncase 0: {",totS);fwrite(Step4,line1);
format(line1,256,"\r\nSetPlayerInterior(playerid,0);");fwrite(Step4,line1);
format(line1,256,"\r\nSetPlayerPos(playerid,%f,%f,%f);}}}",X,Y,Z);
fwrite(Step4,line1);
fclose(Step4);

new File:Step5 = fopen("Step5.txt",io_append);
new line2[150];
if (tot == 0){
format(line2,150,"\r\n// Place This Under OnPlayerExitedMenu");fwrite(Step5,line2);
format(line2,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step5,line2);}
format(line2,150,"\r\nif( Current == gMenu%s){",totS);fwrite(Step5,line2);
format(line2,150,"\r\nTogglePlayerControllable(playerid,1);}");fwrite(Step5,line2);
fclose(Step5);
SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A Blue Print For The House Was Successfully Generated.");}

if (strcmp("/build", cmdtext, true)==0)
{
SendClientMessage(playerid,0xFFFFFFAA,"KIHC: Do /build house small, for small houses.");
SendClientMessage(playerid,0xFFFFFFAA,"KIHC: Do /build house medium, for medium houses.");
SendClientMessage(playerid,0xFFFFFFAA,"KIHC: Do /build house large, for large houses.");
}


return 1;
}
public OnPlayerSelectMenuRow(playerid,row)
{
	
	return 1;
}