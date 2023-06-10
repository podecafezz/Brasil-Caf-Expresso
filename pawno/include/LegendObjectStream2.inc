////////// Include criado por Renan Gonçalves da Silva //////////
#define MaxObjects 3595 /* Aqui você define o máximo de objetos, pode definir para o número que você quiser. */
forward PlayerObjectsUpdate();
new Object[200][MaxObjects],ObjectMaxCount[200],ObjectID[MaxObjects],ObjectCreated[MaxObjects];
new Float:ObjectX[MaxObjects],Float:ObjectY[MaxObjects],Float:ObjectZ[MaxObjects],Float:ObjectRX[MaxObjects],Float:ObjectRY[MaxObjects],
Float:ObjectRZ[MaxObjects],Float:ObjectViewDistance[MaxObjects];
public PlayerObjectsUpdate()
{
for(new I = 0; I < 200; I ++)
{
for(new J = 0; J < MaxObjects; J ++)
{
if(IsPlayerConnected(I))
{
if(ObjectCreated[J])
{
new Float:X,Float:Y,Float:Z;
GetPlayerPos(I,X,Y,Z);
X = (X > ObjectX[J]) ? X - ObjectX[J] : ObjectX[J] - X;
Y = (Y > ObjectY[J]) ? Y - ObjectY[J] : ObjectY[J] - Y;
Z = (Z > ObjectZ[J]) ? Z - ObjectZ[J] : ObjectZ[J] - Z;
if((X < ObjectViewDistance[J]) && (Y < ObjectViewDistance[J]) && (Z < ObjectViewDistance[J]))
{
if(Object[I][J] == 250 && ObjectMaxCount[I] < 150)
{
Object[I][J] = CreatePlayerObject(I,ObjectID[J],ObjectX[J],ObjectY[J],ObjectZ[J],ObjectRX[J],ObjectRY[J],ObjectRZ[J]);
ObjectMaxCount[I] ++;
}
}
else
{
if(Object[I][J] != 250)
{
DestroyPlayerObject(I,Object[I][J]);
Object[I][J] = 250;
ObjectMaxCount[I] --;
}
}
}
}
}
}
return 1;
}

CreateStreamObject(ID,Float:X,Float:Y,Float:Z,Float:RX,Float:RY,Float:RZ,Float:ViewDistance) /* OnGameModeInit */
{
for(new I = 0; I < MaxObjects; I ++)
{
if(!ObjectCreated[I])
{
ObjectID[I] = ID;
ObjectX[I] = X;
ObjectY[I] = Y;
ObjectZ[I] = Z;
ObjectRX[I] = RX;
ObjectRY[I] = RY;
ObjectRZ[I] = RZ;
ObjectViewDistance[I] = ViewDistance;
ObjectCreated[I] = 1;
return I;
}
}
return 1;
}

ObjectStream() /* Coloque ObjectStream(); no OnGameModeInit */
{
SetTimer("PlayerObjectsUpdate",500,1);
return 1;
}

ObjectStreamConnect(playerid) /* Coloque ObjectStreamConnect(playerid); no OnPlayerConnect */
{
ObjectMaxCount[playerid] = 0;
for(new I = 0; I < MaxObjects; I ++)
{
Object[playerid][I] = 250;
}
return 1;
}

ObjectStreamDisconnect(playerid) /* Coloque ObjectStreamDisconnect(playerid); no OnPlayerDisconnect */
{
for(new I = 0; I < 150; I ++)
{
DestroyPlayerObject(playerid,I);
}
return 1;
}
