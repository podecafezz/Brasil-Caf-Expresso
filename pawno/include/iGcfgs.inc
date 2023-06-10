#include <a_samp>
#include <dini>
#include <dudb>
#include <SII>
#include <cpstream>
#include <c_vehicleinfo>
#include <fader>
#include <streamer>

#define dcmd(%1,%2,%3) 		if(!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

#if !defined FALSE
	stock
	bool:FALSE = false;
#endif
new stringtext[128];
#define FormMessageForAll(%0,%1,%2)\
        do\
        {\
            format( stringtext, sizeof ( stringtext ), ( %1 ), %2);\
            SendClientMessageToAll( ( %0 ), stringtext);\
        }\
        while ( FALSE )

#define MAX_ZONE_NAME 40
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define dcmd(%1,%2,%3) 		if(!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

#define MaxWindows 13
#define WindowTextMaxLines 16

#define MAX_TIME_AFK  3

#define COR_RACHA   0xabff33AA
#define AntiCapsLock(%1) for (new ToLowerChar; ToLowerChar < strlen(%1); ToLowerChar ++) if (%1[ ToLowerChar ]> 64 && %1[ ToLowerChar ] < 91) %1[ ToLowerChar ] += 32

new entry[256];
new stringx[256];

#define MAX_EMPRESAS 100
#define MAX_HOUSES 200

#define DIALOG_TUTORIAL1                               1
#define DIALOG_TUTORIAL2                               2
#define DIALOG_TUTORIAL3                               3
#define DIALOG_TUTORIAL4                               4
#define DIALOG_TUTORIAL5                               5
#define DIALOG_TUTORIAL6                               6
#define DIALOG_TUTORIAL7                               7
#define DIALOG_TUTORIAL8                               8
#define DIALOG_TUTORIAL9                               9
#define DIALOG_TUTORIAL10                              10
#define DIALOG_TUTORIAL11                              11
#define DIALOG_TERMOS                                  12
#define DIALOG_LOGAR                                   13
#define DIALOG_REGISTRAR                               14
#define DIALOG_CAIXA_ELETRONICO                        15
#define DIALOG_CAIXA_ELETRONICO_INPUT                  16
#define DIALOG_TRANSFERIR                              17
#define DIALOG_ALHAMBRA                                18
#define DIALOG_TUTORIAL                                19
#define DIALOG_TUTORIAL12                              20
#define DIALOG_TUTORIALFIM                             21
#define DIALOG_DROGAS                                  22
#define DIALOG_DROGAS_INPUT                            23
#define DIALOG_DROGAS_INPUT2                           24
#define DIALOG_DROGAS_INPUT3                           25
#define DIALOG_DROGAS_INPUT4                           26
#define DIALOG_DROGAS_INPUT5                           27
#define DIALOG_DROGAS_INPUT6                           28
#define DIALOG_DROGAS_INPUT7                           29
#define DIALOG_ORIGEM                                  30
#define DIALOG_SEXO                                    31
#define DIALOG_CONTINUE                                32
new bool:DentroDeCasa[MAX_PLAYERS];

enum SAZONE_MAIN { //Betamaster
		SAZONE_NAME[28],
		Float:SAZONE_AREA[6]
};

static const gSAZones[][SAZONE_MAIN] = {  // Majority of names and area coordinates adopted from Mabako's 'Zones Script' v0.2
	//	NAME                            AREA (Xmin,Ymin,Zmin,Xmax,Ymax,Zmax)
	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Section",          {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Section",          {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Section",          {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Section",          {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemical",         {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemical",         {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"Castillo del Diablo",         {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"Castillo del Diablo",         {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"Castillo del Diablo",         {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"KACC Military Fuels",         {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"LS International",            {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"LS International",            {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"LS International",            {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"LS International",            {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"LS International",            {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"LS International",            {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Section",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Section",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Section",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Ind. Estate",        {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Section",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"Four Dragons Casino",         {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	// Main Zones
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

//---------------------------------------------------------------------------------------------------


stock GetPlayer2DZone(playerid, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new Float:x22, Float:y22, Float:z22;
	GetPlayerPos(playerid, x22, y22, z22);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x22 >= gSAZones[i][SAZONE_AREA][0] && x22 <= gSAZones[i][SAZONE_AREA][3] && y22 >= gSAZones[i][SAZONE_AREA][1] && y22 <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock Float:dini_IntFloat(filename[],key[])
{
   return floatstr(dini_Get(filename,key));
}

stock dini_FloatSetracha(filename[],key[],Float:value)
{
   new valuestring[256];
   format(valuestring,256,"%f",value);
   return dini_Set(filename,key,valuestring);
}

stock GetPlayer3DZone(playerid, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new Float:x33, Float:y33, Float:z33;
	GetPlayerPos(playerid, x33, y33, z33);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x33 >= gSAZones[i][SAZONE_AREA][0] && x33 <= gSAZones[i][SAZONE_AREA][3] && y33 >= gSAZones[i][SAZONE_AREA][1] && y33 <= gSAZones[i][SAZONE_AREA][4] && z33 >= gSAZones[i][SAZONE_AREA][2] && z33 <= gSAZones[i][SAZONE_AREA][5])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock IsPlayerInZone(playerid, zone[]) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new TmpZone[MAX_ZONE_NAME];
	GetPlayer3DZone(playerid, TmpZone, sizeof(TmpZone));
	for(new i = 0; i != sizeof(gSAZones); i++)
	{
		if(strfind(TmpZone, zone, true) != -1)
			return 1;
	}
	return 0;
}
//==============================================================================
new VehicleName[][] = { "Landstalker","Bravura","Buffalo","Linerunner","Pereniel",
"Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus","Voodoo",
"Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi",
"Washington","Bobcat","Mr Whoopee","BF Injection","Hunter","Premier","Enforcer",
"Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer",
"Previon","Coach","Cabbie","Stallion","Rumpo","RC Bandit","Romero","Packer",
"Monster Truck","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer",
"Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy","Solair",
"Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy",
"Hermes","Sabre","Rustler","ZR-350","Walton","Regina","Comet","BMX","Burrito",
"Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher",
"Virgo","Greenwood","Jetmax","Hotring","Sandking","Blista Compact","Police Maverick",
"Boxville","Benson","Mesa","RC Goblin","Hotring Racer","Hotring Racer","Bloodring Banger",
"Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt",
"Tanker","RoadTrain","Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500",
"HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck","Willard",
"Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight",
"Streak","Vortex","Vincent","Bullet","Clover","Sadler","Firetruck","Hustler",
"Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada",
"Yosemite","Windsor","Monster Truck","Monster Truck","Uranus","Jester","Sultan",
"Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna",
"Bandito","Freight","Trailer","Kart","Mower","Duneride","Sweeper","Broadway",
"Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug",
"Trailer","Emperor","Wayfarer","Euros","Hotdog","Club","Trailer","Trailer",
"Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix",
"Glendale","Sadler","Luggage Trailer","Luggage Trailer",
"Stair Trailer","Boxville","Farm Plow","Utility Trailer" };
//==============================================================================
// ------------------------------------------------- //
// ------------------- forwards -------------- //
// ------------------------------------------------- //
forward FecharMenuRachaTempo(playerid);
forward ResetarSistemaRacha(playerid);
forward ResetarValoresDaRacha();
forward ContadorDoRacha();
forward GetClosestHospital(playerid);
forward Float:GetDistanceToProperty(playerid,Property);
forward Localizacao(playerid);
forward MapIconStreamer();
forward AceitarCombustivel(playerid);
forward AceitarCurativo(playerid);
forward KillTimerPrisao(playerid);
forward UsouComando1(playerid);
forward Liberar(playerid);
forward UpdateEmp(empid);
forward Abastecer(playerid);
forward CriarExplosao(Float:X,Float:Y,Float:Z,tipo,Float:diam);
forward DestruirObjeto(objid);
forward AntiAfk();
forward split(const strsrc[], strdest[][], delimiter);
forward Taxi();
forward SpeedoUpdate();
forward RemoverTextDeath(playerid);
forward AtualizarVontade(playerid);
forward LimparFome(playerid);
forward GetPlayerHospital(playerid);
forward IsABoat(carid);
forward IsAPlane(carid);
forward IsABikeCar(carid);
forward OnPlayerRegister(playerid, password[]);
forward OnPlayerUpdateEx(playerid);
forward OnPlayerLogin(playerid,senha[]);
forward ClearChatBox(playerid,lines);
forward LoginLog(string[]);
forward KickLog(string[]);
forward CasaLog(string[]);
forward EmpresaLog(string[]);
forward SetHP(playerid);
forward IsAtCandySprunk(playerid);
forward SendMSG(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward SoltarJogador(playerid);
forward Soltar(playerid);
forward Prender(playerid);
forward PrenderJogador(playerid);
forward RelogioUPs();
forward Horarios();
forward PayDay();
forward AntiFlood(playerid);
forward SoltarFlood(playerid);
forward VisibilityUpdate();
forward CriarVeiculo(m,Float:x,Float:y,Float:z,Float:r,c,d);
forward AceitarSkin(playerid);
forward GlenPark(playerid);
forward AtualizarCombustivel();
forward SalvarDadosJogador(playerid) ;
forward LoadDadosJogador(playerid) ;
forward RestaurarVeiculo(playerid,vid);
forward SpawnProf(playerid) ;
forward NovoVeiculo();
forward KillVeiculo(carid);
forward UpdateCasa(casaid);
forward Float:GetDistanceToPropertyCasa(playerid,Property);

enum Variaveis
{
bool:CriandoRacha,
bool:RachaCriada,
bool:RachaIniciada,
CarroEscolhido,
IDRachaAberto,
TimerIni,
Player1, Player2,
Player3, Player4,
Player5, Player6,
Player7, Player8,
Player9, Player10,
Player11, Player12,
Carro1, Carro2, Carro3,
Carro4, Carro5, Carro6,
Carro7, Carro8, Carro9,
Carro10, Carro11, Carro12,
TimerRacha, ContadorRacha,
ContarPlacar, TimerTempoDeRacha,
TimerCriacao
}

new Racha[Variaveis],
CheckPoint[12],
Float:Circuito[20][3],
Float:Pista[4], Float:Pista2[4],
Float:Pista3[4], Menu:RACHAMENUCARRO,
Menu:RACHAMENUCARRO2, Menu:RACHAMENUPISTA,
Menu:RACHAMENUCRIAR, Menu:RACHAMENUPISTA2,
Menu:RACHAMENUPISTA3, Text:TempoIniciar;

public CriarVeiculo(m,Float:x,Float:y,Float:z,Float:r,c,d) CreateVehicle(m,x,y,z,r,c,d,60000);
enum OldSpeedoPos
{
    Float:sX,
    Float:sY,
    Float:sZ
}
new SavePlayerPos[MAX_PLAYERS][OldSpeedoPos];

new VehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
	"Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
	"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
	"Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
	"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
	"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
	"Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
	"Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
	"Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
	"Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
	"Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
	"Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
	"Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
	"Blista Compact", "Police Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin",
	"Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
	"Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
 	"Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
 	"FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
 	"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
 	"Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
	"Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
	"Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
	"Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
	"News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
 	"Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
 	"Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
 	"Tiller", "Utility Trailer"
};

enum iInfo
{
	Float:Pos_X,
	Float:Pos_Y,
	Float:Pos_Z,
	MapIcon,
};
new MapInfo[MAX_PLAYERS][iInfo];

enum pInfo
{
	pKey,
    bool:pLogado,
    pReg,
    pInTutorial,
    pTutorial,
    pLevel,
    pEmpregado,
    pAdmin,
    pExp,
    pSkin,
    pEmprego,
	pCash,
	pBanco,
	pSalario,
	pSetar,
	pVIP,
	pHabilitacaoT,
	pHabilitacaoA,
	pHabilitacaoB,
	pPortedArmas,
	pCombustivel,
	Marcadoria,

	pHeroina,
	pCocaina,
	pMaconha,
	pCrack,
	pOxi,
	pExtasi,
	pLSD,

	pVicHeroina,
	pVicCocaina,
	pVicMaconha,
	pVicCrack,
	pVicExtasi,
	pVicLSD,
	pVicOxi,
	pOrigem,
	pSexo,
	pChaveEmp,
	pChaveEmp_Empregado,
	jEmpregado_1,
	jEmpregado_2,
	jEmpregado_3,
	jEmpregado_4,
	bool:pSyncronizo,
}

new PlayerInfo[MAX_PLAYERS][pInfo];


enum pUlti
{
	pGPS,
	pRelogio,
	pVelocimetro,
	pReloginhoUp,
	pCelular,
	pAgenda,
	pCamisinha,
	pCartaodeCreditos,
	pCartaoTel,
	pChipOi,
	pChipTim,
	pChipClaro,
	pChipVivo,
	pNootBook,
}
enum pPos
{
	Float:LastX,
	Float:LastY,
	Float:LastZ,
};

new PlayerLastPos[MAX_PLAYERS][pPos];

new AntiNomeBot[][] = {
	"con.",
    "com1",
	"com2",
	"com3",
	"com4",
	"com5",
	"com6",
	"com7",
	"com8",
	"com9",
	"lpt1",
	"lpt2",
	"lpt3",
	"lpt4",
	"lpt5",
	"lpt6",
	"lpt7",
	"lpt8",
	"lpt9",
	"nul",
	"clock$",
	"aux",
	"prn",
	"con",
	"Carl",
	"Rocky",
	"Pepe",
	"Arnoldo",
	"SgtPepper",
	"Pepsi",
	"Pepno",
	"Azucar",
	"Vino_Toro",
	"Zoquete",
	"Pacman",
	"Batman",
	"AquilesBrinco",
	"Manfrey",
	"Sopapeala",
	"Papirola",
	"Sony",
	"[ViP]Labrik",
	"Justin_Bieber",
	"Poderoso_Chefao",
	"[MT]Lavis",
    "Gil_Henrique",
    "Server_Lixo",
    "Justin_Biba",
    "Justin_Viadinho",
    "Advanced_Lixo",
    "Chefao_Fusion",
    "Fusion_Games",
    "TSSA",
    "Ninguem",
    "Advanced_Derrubado"
};

new Morto[MAX_PLAYERS];

new bool:Preso[MAX_PLAYERS];
new bool:Algemado[MAX_PLAYERS];
new bool:KillVeh[MAX_VEHICLES];

new Encomendadrogas[MAX_PLAYERS];
new CombustivelValor[MAX_PLAYERS];
new TempoPreso[MAX_PLAYERS];
new Combustivel[MAX_PLAYERS];
new TimerSkin[MAX_PLAYERS];
new QuantidadeCombustivel[MAX_PLAYERS];
new CombustivelPlayerID[MAX_PLAYERS];
new TimerCurativo[MAX_PLAYERS];
new SkinID[MAX_PLAYERS];
new Aceitarskin[MAX_PLAYERS];
new Aceitarcombustivel[MAX_PLAYERS];
new Aceitarcurativo[MAX_PLAYERS];
new SkinValor[MAX_PLAYERS];
new SkinPlayerID[MAX_PLAYERS];
new AFK[MAX_PLAYERS];
new PlayerAfkTicks[MAX_PLAYERS];
new Float:PlayerCurrentPos[3];
new PlayerUlt[MAX_PLAYERS][pUlti];
new iPlayerChatTime[MAX_PLAYERS];
new szPlayerChatMsg[MAX_PLAYERS][128];
new Taximetro[MAX_PLAYERS][4];
new PrecoTaximetro[MAX_PLAYERS];
new CronometroTaxi[MAX_PLAYERS][4];
new TimerFome[MAX_PLAYERS];
new StatusCede[MAX_PLAYERS] = 1;
new StatusFome[MAX_PLAYERS] = 1;
new CaixaEletronico_Ok[MAX_PLAYERS];
new ConsumingMoney[MAX_PLAYERS];
new TransferenciaID[MAX_PLAYERS];
new LoginsTentativas[MAX_PLAYERS];
new UsouComando[MAX_PLAYERS][50];
new LocalizarID[MAX_PLAYERS];
new TimerLocalizar[MAX_PLAYERS];
new TimerCombustivel[MAX_PLAYERS];
new localizado[MAX_PLAYERS];
new antiflood[MAX_PLAYERS];
new mutado[MAX_PLAYERS];
new Camera[MAX_PLAYERS];
new Gps[MAX_PLAYERS];
new PrimeiroLogin[MAX_PLAYERS];


new abastecer;
new MaconhaGrove;
new CocainaGrove;
new HeroinaGrove;
new OxiGrove;
new LSDGrove;
new ExtasiGrove;
new CrackGrove;

new MaconhaBallas;
new CocainaBallas;
new HeroinaBallas;
new OxiBallas;
new LSDBallas;
new ExtasiBallas;
new CrackBallas;

new MaconhaFavela;
new CocainaFavela;
new HeroinaFavela;
new OxiFavela;
new LSDFavela;
new ExtasiFavela;
new CrackFavela;

new MaconhaAngel;
new CocainaAngel;
new HeroinaAngel;
new LSDAngel;
new OxiAngel;
new ExtasiAngel;
new CrackAngel;

new Maconhasf;
new Cocainasf;
new Heroinasf;
new LSDsf;
new Oxisf;
new Extasisf;
new Cracksf;

new Maconhalv;
new Cocainalv;
new Heroinalv;
new LSDlv;
new Oxilv;
new Extasilv;
new Cracklv;

new Text:ReloginhoUP;
new Text:ConnectMensagem;
new Text:TextInfos;
new Text:dm[MAX_PLAYERS];
new Text:TextHoras;

new Text:faixa[MAX_PLAYERS];
new Text:faixa1[MAX_PLAYERS];
new Text:faixa2[MAX_PLAYERS];
new Text:afk1[MAX_PLAYERS];
new Text:afk2[MAX_PLAYERS];
new Text:pvelo[MAX_PLAYERS];
new Text:fome[MAX_PLAYERS];
new Text:box[MAX_PLAYERS];
new Text:fahrzeug[MAX_PLAYERS];
new Text:km[MAX_PLAYERS];
new Text:hoehe[MAX_PLAYERS];
new Text:zustand[MAX_PLAYERS];
new Text:moldura0[MAX_PLAYERS];
new Text:moldura1[MAX_PLAYERS];
new Text:moldura2[MAX_PLAYERS];
new Text:moldura3[MAX_PLAYERS];
new Text:moldura4[MAX_PLAYERS];
new Text:moldura5[MAX_PLAYERS];
new Text:moldura6[MAX_PLAYERS];
new Text:Textdraw53[MAX_PLAYERS];


new c_Grana[][] =
{
18,
32,
38,
137,
146,
200,
186,
16,
1,
166,
66,
68,
96,
34,
74,
36,
11,
368,
14,
15,
36,
77,
69,
369,
47,
414,
38
};

new c_Imposto_de_renda[][] =
{
18,
32,
38,
137,
16,
19,
66,
68,
96,
34,
74,
36,
11,
14,
15,
36,
77,
69,
47,
38
};


enum eInfo
{
	Dono[24],
	Empregado_1[24],
	TemEmpregado_1,
	Empregado_2[24],
	TemEmpregado_2,
	Empregado_3[24],
	TemEmpregado_3,
	Empregado_4[24],
	TemEmpregado_4,
	Descricao[80],
	Login[80],
	NomeEmp[80],
	Level,
	Entrada,
	Entregas,
	Contrata,
	Float:Entradax,
	Float:Entraday,
	Float:Entradaz,
	Float:Saidax,
	Float:Saiday,
	Float:Saidaz,
	Interior,
	VirtualWorld,
	Compra,
	Venda,
	Lucro,
	Fechada,
	Luz,
	Agua,
	CNPJ,
	Mercadorias,
	TemDono

};

new EmpInfo[MAX_PLAYERS][eInfo];

new EmpresaPickup[sizeof(EmpInfo)];
//new EmpresaMapIcon[sizeof(EmpInfo)];

enum HouseInfo
{
	Dono[24],
	Morador_1[24],
	Morador_2[24],
	Morador_3[24],
	Descricao[80],
	Login[128],
	Compra,
	Venda,
	Interior,
	VirtualWorld,
	Trancada,
	Float:SaidaX,
	Float:SaidaY,
	Float:SaidaZ,
	Float:Angle,
	Float:EntradaX,
	Float:EntradaY,
	Float:EntradaZ,
	IPTU,
	TemDono
}
new hInfo[MAX_HOUSES][HouseInfo];

new CasaPickup[sizeof(hInfo)];

enum VeiculoCasaInfo
{
	VeiculoCasa,
	ID,
	VeiculoModelo,
	Float:PosCarX,
	Float:PosCarY,
	Float:PosCarZ,
	Float:Angulo,
	CarColor1,
	CarColor2,
	Respawn_Delay,
    NovoCarro,
    IPVA,
    Descricao[80],
    Donov[24],
    Trancado,
    TemMorador_1,
    TemMorador_2,
    TemMorador_3
}
new CarInfo[MAX_HOUSES][VeiculoCasaInfo];

enum TelePosEnum {
   Float:tX ,
   Float:tY
};
new Float:TelePosGps[ MAX_PLAYERS ][ TelePosEnum ];

new JogadorWorld[MAX_PLAYERS];
new JogadorInt[MAX_PLAYERS] = -1;

new Float:empresax;
new Float:empresay;
new Float:empresaz;

new idex[MAX_PLAYERS];
// ------------------------------------- //
// -------Bools [ True & False ]-------- //
// ------------------------------------- //
new bool:RegistrationStep[MAX_PLAYERS];
new bool:gPlayerAccount[MAX_PLAYERS];
new bool:TookSprunk[MAX_PLAYERS];
new bool:FaculdadeAberta;
new bool:Recebendo[MAX_PLAYERS];
new bool:Abastecendo[MAX_PLAYERS];
// ------------------------------------- //
// -------Menus Profissoes-------- //
// ------------------------------------- //
new Menu:Transporte,
    Menu:Profissoes,
    Menu:Honestas,
    Menu:Honestas2,
    Menu:Honestas3,
    Menu:Policiaismenu,
    Menu:Mafiosas,
    Menu:Governo,
    Menu:Outras,
	Menu:Exercito,
	Menu:Utilitarios;


new Marcadorias_Creck;
new Agencias[4];
new Academia;
new BocaDeFumo[6];
new dpsoltar;
new RandomMSG[][] =
{
	"{F0FFBA}» Visite o nossa comunidade diariamente para ficar informado de tudo!",
    "{F0FFBA}» Está precisando de ajuda de algum helper? Use /relatorio e aguarde algum helper reponde-lo!",
    "{F0FFBA}» Siga as regras para manter um bom RolePlay em nosso servidor!!",
    "{F0FFBA}» Para manter um bom jogo siga todas as regras , SEMPRE!!",
    "{F0FFBA}» Cheater? Use /reportar [id] [razão] para reportar ele a administração!",
    "{F0FFBA}» Se não possuir administradores online, você pode sempre deixar o seu /reportar para nós, iremos atende-lo quando possivel!",
    "{F0FFBA}» Não faça spam no comando /reportar. Caso contrario você será punido seriamente!.",
    "{F0FFBA}» Use /gps para localizar os principais locais!",
    "{F0FFBA}» Precisa de gasolina? você pode abastecer o seu veiculo em um dos Postos de Gasolina espalhados pela cidade",
    "{F0FFBA}» Você pode utilizar /calllist para ver o numeros publicos.",
    "{F0FFBA}» Respeite os outros jogadores para ser respeitado , qualquer chingamento OOC é totalmente punivel!",
    "{F0FFBA}» Apenas administradores podem fazer a pausa de algum RP , respeite isto por favor!",
    "{F0FFBA}» Digite /ajuda para mostrar a lista de comandos que pode ajuda-lo.",
    "{F0FFBA}» Nunca utilize /reportar ou /sos para pedir dinheiro a qualquer um administrador.",
    "{F0FFBA}» Encontrou algum bug? relate em nossa comunidade!.",
    "{F0FFBA}» Problemas com algum helper/gamemaster? utilize a comunidade no orkut para fazer uma reclamação /comunidade",
    "{F0FFBA}» Acesse o nossa comunidade diariamente para ficar dentro das novidades do servidor!",
    "{F0FFBA}» Jogadores de nivel 1 são considerados aprendizes , portanto não roube-o.",
    "{F0FFBA}» Roleplay Sempre! Dirija corretamente pelo lado direito da rua!."
};
new Float:CamPositions[25][8] =
{
{955.81,-50.90,1001.11,270.10,959.81,-50.90,1001.11,3.0},
{513.04,-17.21,1001.56,357.03,513.25,-13.22,1001.56,3.0},
{307.99,-143.09,999.60,0.59,307.95,-139.09,999.60,7.0},
{211.14,-41.50,1001.80,90.58,207.14,-41.54,1001.80,1.0},
{1220.48,-6.39,1001.32,90.57,1216.48,-6.43,1001.32,2.0},
{1221.43,8.60,1001.33,136.07,1218.66,5.72,1001.33,2.0},
{1937.74,986.60,992.47,89.18,1933.74,986.66,992.47,10.0},
{-2666.92,1429.46,906.46,180.33,-2666.90,1425.46,906.46,3.0},
{-2654.45,1425.91,906.46,180.28,-2654.43,1421.91,906.46,3.0},
{2193.82,1598.62,1005.06,177.95,2193.68,1594.62,1005.06,1.0},
{1254.87,-804.54,1084.01,269.72,1258.87,-804.56,1084.01,5.0},
{506.90,-4.29,1000.67,86.58,502.90,-4.05,1000.67,17.0},
{476.09,-14.96,1003.69,270.33,480.09,-14.94,1003.69,17.0},
{446.05,-11.11,1000.73,1.38,445.96,-7.11,1000.73,1.0},
{443.09,-17.73,1001.13,127.38,439.91,-20.16,1001.13,1.0},
{681.60,-452.82,-25.61,2.16,681.45,-448.83,-25.61,1.0},
{-223.29,1405.88,27.77,88.12,-227.29,1406.01,27.77,18.0},
{953.58,2143.96,1011.02,271.58,957.58,2144.07,1011.02,1.0},
{2324.44,-1136.41,1051.30,177.21,2324.24,-1140.41,1051.30,12.0},
{140.24,1378.15,1088.36,179.29,140.20,1374.15,1088.36,5.0},
{-1833.59,16.95,1061.14,182.24,-1833.44,12.95,1061.14,14.0},
{759.96,1443.13,1102.70,175.90,759.67,1439.14,1102.70,6.0},
{315.79,1027.13,1949.18,0.62,315.74,1031.13,1949.18,9.0},
{508.35,-85.03,998.96,358.16,508.48,-81.03,998.96,11.0},
{1084.76,2094.60,15.35,225.87,1087.63,2091.81,15.35,0.0}
};
public KillTimerPrisao(playerid)
{
    Preso[playerid] = false;
    KillTimer(TempoPreso[playerid]);
    return 1;
}

public Liberar(playerid)
{
    SetPlayerInterior(playerid, 6);
    SetPlayerPos(playerid, 265.9714, 83.1550, 1001.0391);
    SetPlayerWantedLevel(playerid, 0);
   	Preso[playerid] = false;
   	SendClientMessage(playerid, 0xA9C4E4AA, "{FF0000}| INFO | Você foi solto automáticamente por cumprir a sua pena na cadeia!");
   	KillTimer(TempoPreso[playerid]);
	return 1;
}

public GetClosestHospital(playerid)
{
	if(!IsPlayerConnected(playerid)){
	    return -1;
	}
	new Float:prevdist = 100000.000;
	new prevhosp;
	for(new hospid = 0; hospid < 4; hospid++){
	    new Float:dist;
	    if(hospid == 0){
            dist = GetPlayerDistanceToPoint(playerid,-2651.6501,634.1177);
		}
		else if(hospid == 1){
		    dist = GetPlayerDistanceToPoint(playerid,1173.5842,-1324.5615);
		}
		else if(hospid == 2){
		    dist = GetPlayerDistanceToPoint(playerid,2031.9415,-1404.3578);
		}
		else if(hospid == 3){
		    dist = GetPlayerDistanceToPoint(playerid,1582.5615,1768.7921);
		}
		if((dist < prevdist)){
		    prevdist = dist;
		    prevhosp = hospid;
		}
	}
    return prevhosp;
}
public UsouComando1(playerid)
{
	if(UsouComando[playerid][1] == 1){
 	UsouComando[playerid][1] = 0;}
 	if(UsouComando[playerid][2] == 1){
	UsouComando[playerid][2] = 0;}
	if(UsouComando[playerid][3] == 1){
	UsouComando[playerid][3] = 0;}
	if(UsouComando[playerid][4] == 1){
	UsouComando[playerid][4] = 0;}
	if(UsouComando[playerid][5] == 1){
	UsouComando[playerid][5] = 0;}
	if(UsouComando[playerid][6] == 1){
	UsouComando[playerid][6] = 0;}
	if(UsouComando[playerid][7] == 1){
	UsouComando[playerid][7] = 0;}
    return 1;
}
public Localizacao(playerid)
{
	DisablePlayerRaceCheckpoint(playerid);
	new Float:localizarx, Float:localizary, Float:localizarz;
   	GetPlayerPos(LocalizarID[playerid], localizarx, localizary, localizarz);
	SetPlayerRaceCheckpoint(playerid, 2, localizarx, localizary, localizarz, 0, 0, 0, 0);
	return 1;
}
public AceitarCombustivel(playerid)
{
	if(Aceitarcombustivel[playerid] == 1)
	{
		KillTimer(TimerCombustivel[playerid]);
	    TimerCombustivel[playerid] = SetTimerEx("AceitarCombustivel", 5000, true, "i", playerid);
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar o combustível. (/Aceitar ou /Recusar)");
	    Aceitarcombustivel[playerid] = 2;
	    return 1;
	}
	if(Aceitarcombustivel[playerid] == 2)
	{
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar o combustível. (/Aceitar ou /Recusar)");
		Aceitarcombustivel[playerid] = 3;
	    return 1;
	}
	if(Aceitarcombustivel[playerid] == 3)
	{
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar o combustível. (/Aceitar ou /Recusar)");
	    Aceitarcombustivel[playerid] = 4;
	    return 1;
	}
	if(Aceitarcombustivel[playerid] == 4)
	{
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar o combustível. (/Aceitar ou /Recusar)");
	    Aceitarcombustivel[playerid] = 5;
	    return 1;
	}
	if(Aceitarcombustivel[playerid] == 5)
	{
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar o combustível. (/Aceitar ou /Recusar)");
	    Aceitarcombustivel[playerid] = 6;
	    return 1;
	}
	if(Aceitarcombustivel[playerid] == 6)
	{
	    KillTimer(TimerCombustivel[playerid]);
	    Aceitarcombustivel[playerid] = 0;
	    return 1;
	}
	return 1;
}
public Float:GetDistanceToProperty(playerid,Property)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	GetPlayerPos(playerid,x1,y1,z1);
	x2 = EmpInfo[Property][Entradax];
	y2 = EmpInfo[Property][Entraday];
	z2 = EmpInfo[Property][Entradaz];
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}
public MapIconStreamer()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        new Float:SmallestDistance = 99999.9;
	        new CP,Float:OldDistance;
	        for(new propid; propid<MAX_EMPRESAS; propid++)
	        {
	            OldDistance = GetDistanceToProperty(i,propid);
	            if(OldDistance < SmallestDistance)
	            {
	                SmallestDistance = OldDistance;
	                CP = propid;
				}
			}
			RemovePlayerMapIcon(i,31);
			if(EmpInfo[CP][TemDono]== 1)
			{
                SetPlayerMapIcon(i,31,EmpInfo[CP][Entradax],EmpInfo[CP][Entraday],EmpInfo[CP][Entradaz],43,0);
			}
			else
			{
			    SetPlayerMapIcon(i,31,EmpInfo[CP][Entradax],EmpInfo[CP][Entraday],EmpInfo[CP][Entradaz],44,0);
			}
		}
	}
}

public Float:GetDistanceToPropertyCasa(playerid,Property)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	GetPlayerPos(playerid,x1,y1,z1);
	x2 = hInfo[Property][EntradaX];
	y2 = hInfo[Property][EntradaY];
	z2 = hInfo[Property][EntradaZ];
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}
stock Rachas()
{
    Racha[TimerTempoDeRacha] = -1; Racha[TimerRacha] = -1; Racha[TimerCriacao] = -1;
	Racha[Player1] = INVALID_PLAYER_ID; Racha[Player2] = INVALID_PLAYER_ID; Racha[Player3] = INVALID_PLAYER_ID; Racha[Player4] = INVALID_PLAYER_ID;
	Racha[Player5] = INVALID_PLAYER_ID; Racha[Player6] = INVALID_PLAYER_ID; Racha[Player7] = INVALID_PLAYER_ID; Racha[Player8] = INVALID_PLAYER_ID;
	Racha[Player9] = INVALID_PLAYER_ID; Racha[Player10] = INVALID_PLAYER_ID; Racha[Player11] = INVALID_PLAYER_ID; Racha[Player12] = INVALID_PLAYER_ID;
	Racha[CriandoRacha] = false; Racha[RachaCriada] = false; Racha[RachaIniciada] = false; Racha[IDRachaAberto] = 40; Racha[TimerIni] = 0;
	Racha[Carro1] = CreateVehicle(411, -2323.342041-4, -1630.801391+4, 483.634124+1, 209.889602, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro1], 3);
	Racha[Carro2] = CreateVehicle(411, -2323.342041+4, -1630.801391+4, 483.634124+1, 209.889602, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro2], 3);
	Racha[Carro3] = CreateVehicle(411, -2323.342041-4, -1630.801391-4, 483.634124+1, 209.889602, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro3], 3);
	Racha[Carro4] = CreateVehicle(411, -2323.342041+4, -1630.801391-4, 483.634124+1, 209.889602, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro4], 3);
	Racha[Carro5] = CreateVehicle(411, -2331.281738-4, -1615.347412+4, 483.648529+1, 201.416564, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro5], 3);
	Racha[Carro6] = CreateVehicle(411, -2331.281738+4, -1615.347412+4, 483.648529+1, 201.416564, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro6], 3);
	Racha[Carro7] = CreateVehicle(411, -2331.281738-4, -1615.347412-4, 483.648529+1, 201.416564, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro7], 3);
	Racha[Carro8] = CreateVehicle(411, -2331.281738+4, -1615.347412-4, 483.648529+1, 201.416564, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro8], 3);
	Racha[Carro9] =  CreateVehicle(411, -2337.822753-4, -1598.710083+4, 483.618133+1, 201.227416, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro9], 3);
	Racha[Carro10] = CreateVehicle(411, -2337.822753+4, -1598.710083+4, 483.618133+1, 201.227416, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro10], 3);
	Racha[Carro11] = CreateVehicle(411, -2337.822753-4, -1598.710083-4, 483.618133+1, 201.227416, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro11], 3);
	Racha[Carro12] = CreateVehicle(411, -2337.822753+4, -1598.710083-4, 483.618133+1, 201.227416, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro12], 3);
	RACHAMENUCRIAR = CreateMenu("Menu Racha", 1, 150, 150, 300, 150);
	SetMenuColumnHeader(RACHAMENUCRIAR, 0, "Escolha a opcao:");
	AddMenuItem(RACHAMENUCRIAR, 0, "Entrar no racha");
	AddMenuItem(RACHAMENUCRIAR, 0, "Criar um racha");
	AddMenuItem(RACHAMENUCRIAR, 0, "Sair");
	RACHAMENUCARRO = CreateMenu("Menu Racha", 1, 150, 150, 300, 150);
	SetMenuColumnHeader(RACHAMENUCARRO, 0, "Escolha o carro:");
	AddMenuItem(RACHAMENUCARRO, 0, "Infernus");   // 411
	AddMenuItem(RACHAMENUCARRO, 0, "Turismo"); 	  // 451
	AddMenuItem(RACHAMENUCARRO, 0, "Super GT");   // 506
	AddMenuItem(RACHAMENUCARRO, 0, "Hotknife");	  // 434
	AddMenuItem(RACHAMENUCARRO, 0, "Bandito"); 	  // 568
	AddMenuItem(RACHAMENUCARRO, 0, "Phoenix"); 	  // 603
	AddMenuItem(RACHAMENUCARRO, 0, "Kart");   	  // 571
	AddMenuItem(RACHAMENUCARRO, 0, "Burrito");    // 482
	AddMenuItem(RACHAMENUCARRO, 0, "NRG-500");    // 522
	AddMenuItem(RACHAMENUCARRO, 0, "Moto trilha");// 468
	AddMenuItem(RACHAMENUCARRO, 0, "Proxima lista");
	RACHAMENUCARRO2 = CreateMenu("Menu Racha", 1, 150, 150, 300, 150);
	SetMenuColumnHeader(RACHAMENUCARRO2, 0, "Escolha o carro:");
	AddMenuItem(RACHAMENUCARRO2, 0, "Bufalo");   // 402
	AddMenuItem(RACHAMENUCARRO2, 0, "Cheetah");  // 415
	AddMenuItem(RACHAMENUCARRO2, 0, "M. Bike");  // 510
	AddMenuItem(RACHAMENUCARRO2, 0, "Banshee");  // 429
	AddMenuItem(RACHAMENUCARRO2, 0, "Stallion"); // 439
	AddMenuItem(RACHAMENUCARRO2, 0, "Kombi");    // 483
	AddMenuItem(RACHAMENUCARRO2, 0, "PCJ-600");  // 461
	AddMenuItem(RACHAMENUCARRO2, 0, "Freeway");  // 463
	AddMenuItem(RACHAMENUCARRO2, 0, "Patriot");  // 470
	AddMenuItem(RACHAMENUCARRO2, 0, "Quad");     // 471
	AddMenuItem(RACHAMENUCARRO2, 0, "Lancha Squallo"); // 446 [ PISTA ESPECIAL ]
	RACHAMENUPISTA = CreateMenu("Menu Racha", 1, 150, 150, 300, 150);
	SetMenuColumnHeader(RACHAMENUPISTA, 0, "Escolha a pista:");
	AddMenuItem(RACHAMENUPISTA, 0, "Circuito Las Venturas");        // 0
	AddMenuItem(RACHAMENUPISTA, 0, "Welcome to the Jungle I");      // 1
	AddMenuItem(RACHAMENUPISTA, 0, "Welcome to the Jungle II");     // 2
	AddMenuItem(RACHAMENUPISTA, 0, "Grass Race");                   // 3
	AddMenuItem(RACHAMENUPISTA, 0, "Los Santos - San Fierro");      // 4
	AddMenuItem(RACHAMENUPISTA, 0, "Vale da Morte");                // 5
	AddMenuItem(RACHAMENUPISTA, 0, "Exportacao LV - LS");           // 6
	AddMenuItem(RACHAMENUPISTA, 0, "Alem da Ponte");                // 7
	AddMenuItem(RACHAMENUPISTA, 0, "Becos de Los Santos");          // 8
	AddMenuItem(RACHAMENUPISTA, 0, "Monte Chiliad");                // 9
	AddMenuItem(RACHAMENUPISTA, 0, "Proxima lista");
	RACHAMENUPISTA2 = CreateMenu("Menu Racha", 1, 150, 150, 300, 150);
	SetMenuColumnHeader(RACHAMENUPISTA2, 0, "Escolha a pista:");
	AddMenuItem(RACHAMENUPISTA2, 0, "Ida para o Deserto");          // 10
	AddMenuItem(RACHAMENUPISTA2, 0, "Aldea Malvada");               // 11
	AddMenuItem(RACHAMENUPISTA2, 0, "Las Colinas");                 // 12
	AddMenuItem(RACHAMENUPISTA2, 0, "Aeroporto San Fierro");        // 13
	AddMenuItem(RACHAMENUPISTA2, 0, "Ruas de San Fierro");          // 14
	AddMenuItem(RACHAMENUPISTA2, 0, "Da ponte ao Deserto");         // 15
	AddMenuItem(RACHAMENUPISTA2, 0, "Pontes de San Fierro");        // 16
	AddMenuItem(RACHAMENUPISTA2, 0, "Exportacao SF - LS");          // 17
	AddMenuItem(RACHAMENUPISTA2, 0, "Tierra Robada");               // 18
	AddMenuItem(RACHAMENUPISTA2, 0, "Velozes de Los Santos");       // 19
	AddMenuItem(RACHAMENUPISTA2, 0, "Proxima lista");
	RACHAMENUPISTA3 = CreateMenu("Menu Racha", 1, 150, 150, 300, 150);
	SetMenuColumnHeader(RACHAMENUPISTA3, 0, "Escolha a pista:");
	AddMenuItem(RACHAMENUPISTA3, 0, "Fim da Linha");                // 20
	AddMenuItem(RACHAMENUPISTA3, 0, "Entrando no Esgoto");          // 21
	AddMenuItem(RACHAMENUPISTA3, 0, "Montanha do Satelite");        // 22
	AddMenuItem(RACHAMENUPISTA3, 0, "Caverna do Diabo");            // 23
	AddMenuItem(RACHAMENUPISTA3, 0, "No Caminho do Treem");         // 24
	AddMenuItem(RACHAMENUPISTA3, 0, "Pedras e Trilhos");            // 25
	AddMenuItem(RACHAMENUPISTA3, 0, "Jardim Botanico");             // 26
	AddMenuItem(RACHAMENUPISTA3, 0, "Turismo Las Venturas");        // 27
	AddMenuItem(RACHAMENUPISTA3, 0, "Dark Side Race");              // 28
	AddMenuItem(RACHAMENUPISTA3, 0, "Passando pela Praia");         // 29
	AddMenuItem(RACHAMENUPISTA3, 0, "San Fierro Final");            // 30
	TempoIniciar = TextDrawCreate(86.0, 320.0, "~g~40 SEG~n~~y~PARA INICIAR O RACHA");
	TextDrawSetShadow(TempoIniciar, 0);
	TextDrawSetOutline(TempoIniciar, 0);
	TextDrawLetterSize(TempoIniciar, 0.2904, 0.836);
	TextDrawFont(TempoIniciar, 3);
	TextDrawSetOutline(TempoIniciar, 1);
	TextDrawAlignment(TempoIniciar, 2);
	TextDrawSetProportional(TempoIniciar, 1);
}
public ResetarSistemaRacha(playerid)
{
    print("[racha] comando racha usado /resetarracha");
	new strreset[128];
	if (Racha[ContadorRacha] >= 1) 						return SendClientMessage(playerid, -1, "{F9c68A}| INFO | Um racha acabou de ser criado, não abuse deste comando.");
	format(strreset, 256, "{F9c68A}| INFO | Administrador %s(%d) resetou o sistema de rachas.", pName(playerid),playerid); SendClientMessageToAll(-1, strreset);
	for (new i = 0; i < MAX_PLAYERS; i++) if (IsPlayerConnected(i))
	{
		new Menu:MenusRacha = GetPlayerMenu(i);
		if (MenusRacha == RACHAMENUCARRO || MenusRacha == RACHAMENUCARRO2 || MenusRacha == RACHAMENUPISTA || MenusRacha == RACHAMENUPISTA2 || MenusRacha == RACHAMENUPISTA3)
		{
			FecharMenuRachaTempo(i);
			Racha[CriandoRacha] = false;
		}
		if (GetPlayerVirtualWorld(i) == 3)
		{
			EjetarJogador(i); SpawnPlayer(i);
		}
	}
	ResetarValoresDaRacha(); Racha[IDRachaAberto] = 40; Racha[TimerIni] = 0;
	Racha[CriandoRacha] = false; Racha[RachaCriada] = false; Racha[RachaIniciada] = false;
	return 1;
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
    print("[racha] player enter race checkpoint");
	PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	if (Racha[Player1] == playerid) 	 PlayerNoCheckPoint(playerid, 0);
	else if (Racha[Player2] == playerid) PlayerNoCheckPoint(playerid, 1);
	else if (Racha[Player3] == playerid) PlayerNoCheckPoint(playerid, 2);
	else if (Racha[Player4] == playerid) PlayerNoCheckPoint(playerid, 3);
	else if (Racha[Player5] == playerid) PlayerNoCheckPoint(playerid, 4);
	else if (Racha[Player6] == playerid) PlayerNoCheckPoint(playerid, 5);
	else if (Racha[Player7] == playerid) PlayerNoCheckPoint(playerid, 6);
	else if (Racha[Player8] == playerid) PlayerNoCheckPoint(playerid, 7);
	else if (Racha[Player9] == playerid) PlayerNoCheckPoint(playerid, 8);
	else if (Racha[Player10] == playerid) PlayerNoCheckPoint(playerid, 9);
	else if (Racha[Player11] == playerid) PlayerNoCheckPoint(playerid, 10);
	else if (Racha[Player12] == playerid) PlayerNoCheckPoint(playerid, 11);
	return 1;
}

stock VerificarPlacar(playerid, Float:tempo)
{
	new arqui[40]; format(arqui, 40, "/iGamming/iEventos/iRachas/%d.ini", Racha[IDRachaAberto]);
	if (tempo < dini_IntFloat(arqui,"tem_1"))
	{
		if (strcmp(pName(playerid), dini_Get(arqui,"gan_1"), true) == 0)
		{
            dini_FloatSetracha(arqui,"tem_1", tempo); return 1;
		}
	    else
	    {
            dini_FloatSetracha(arqui,"tem_5", dini_IntFloat(arqui,"tem_4"));	dini_Set(arqui,"gan_5", dini_Get(arqui,"gan_4"));
            dini_FloatSetracha(arqui,"tem_4", dini_IntFloat(arqui,"tem_3"));	dini_Set(arqui,"gan_4", dini_Get(arqui,"gan_3"));
            dini_FloatSetracha(arqui,"tem_3", dini_IntFloat(arqui,"tem_2"));	dini_Set(arqui,"gan_3", dini_Get(arqui,"gan_2"));
            dini_FloatSetracha(arqui,"tem_2", dini_IntFloat(arqui,"tem_1"));	dini_Set(arqui,"gan_2", dini_Get(arqui,"gan_1"));
            dini_FloatSetracha(arqui,"tem_1", tempo);						dini_Set(arqui,"gan_1", pName(playerid));
			return 1;
	    }
	}
	else if (tempo < dini_IntFloat(arqui,"tem_2"))
	{
		if (strcmp(pName(playerid), dini_Get(arqui,"gan_2"), true) == 0)
		{
            dini_FloatSetracha(arqui,"tem_2",tempo); return 1;
		}
	    else
	    {
	        if (strcmp(pName(playerid), dini_Get(arqui,"gan_1"), true) == 0) return 1;
            dini_FloatSetracha(arqui,"tem_5", dini_IntFloat(arqui,"tem_4"));	dini_Set(arqui,"gan_5", dini_Get(arqui,"gan_4"));
            dini_FloatSetracha(arqui,"tem_4", dini_IntFloat(arqui,"tem_3"));	dini_Set(arqui,"gan_4", dini_Get(arqui,"gan_3"));
            dini_FloatSetracha(arqui,"tem_3", dini_IntFloat(arqui,"tem_2"));	dini_Set(arqui,"gan_3", dini_Get(arqui,"gan_2"));
            dini_FloatSetracha(arqui,"tem_2", tempo);						dini_Set(arqui,"gan_2", pName(playerid));
			return 1;
	    }
	}
	else if (tempo < dini_IntFloat(arqui,"tem_3"))
	{
		if (strcmp(pName(playerid), dini_Get(arqui,"gan_3"), true) == 0)
		{
            dini_FloatSetracha(arqui,"tem_3",tempo); return 1;
		}
	    else
	    {
	        if (strcmp(pName(playerid), dini_Get(arqui,"gan_1"), true) == 0) return 1;
	        if (strcmp(pName(playerid), dini_Get(arqui,"gan_2"), true) == 0) return 1;
            dini_FloatSetracha(arqui,"tem_5", dini_IntFloat(arqui,"tem_4"));	dini_Set(arqui,"gan_5", dini_Get(arqui,"gan_4"));
            dini_FloatSetracha(arqui,"tem_4", dini_IntFloat(arqui,"tem_3"));	dini_Set(arqui,"gan_4", dini_Get(arqui,"gan_3"));
            dini_FloatSetracha(arqui,"tem_3", tempo);						dini_Set(arqui,"gan_3", pName(playerid));
			return 1;
	    }
	}
	else if (tempo < dini_IntFloat(arqui,"tem_4"))
	{
		if (strcmp(pName(playerid), dini_Get(arqui,"gan_4"), true) == 0)
		{
            dini_FloatSetracha(arqui,"tem_4",tempo); return 1;
		}
	    else
	    {
	        if (strcmp(pName(playerid), dini_Get(arqui,"gan_1"), true) == 0) return 1;
	        if (strcmp(pName(playerid), dini_Get(arqui,"gan_2"), true) == 0) return 1;
	        if (strcmp(pName(playerid), dini_Get(arqui,"gan_3"), true) == 0) return 1;
            dini_FloatSetracha(arqui,"tem_5", dini_IntFloat(arqui,"tem_4"));	dini_Set(arqui,"gan_5", dini_Get(arqui,"gan_4"));
            dini_FloatSetracha(arqui,"tem_4", tempo);						dini_Set(arqui,"gan_4", pName(playerid));
			return 1;
	    }
	}
	else if (tempo < dini_IntFloat(arqui,"tem_5"))
	{
		if (strcmp(pName(playerid), dini_Get(arqui,"gan_5"), true) == 0)
		{
            dini_FloatSetracha(arqui,"tem_5",tempo); return 1;
		}
	    else
	    {
	        if (strcmp(pName(playerid), dini_Get(arqui,"gan_1"), true) == 0) return 1;
	        if (strcmp(pName(playerid), dini_Get(arqui,"gan_2"), true) == 0) return 1;
	        if (strcmp(pName(playerid), dini_Get(arqui,"gan_3"), true) == 0) return 1;
	        if (strcmp(pName(playerid), dini_Get(arqui,"gan_4"), true) == 0) return 1;
            dini_FloatSetracha(arqui,"tem_5", tempo); dini_Set(arqui,"gan_5", pName(playerid));
			return 1;
	    }
	}
	return 1;
}

stock MostrarRank(playerid, pista)
{
	new strdialog[512], arqui[40]; format(arqui, 40,"/iGamming/iEventos/iRachas/%d.ini", pista);
	format(strdialog, 512, ":: RANKING DA PISTA: %s\n\nPRIMEIRO LUGAR:\n\tNick: %s - Tempo: %f seg.\nSEGUNDO LUGAR:\n\tNick: %s - Tempo: %f seg.\nTERCEIRO LUGAR:\n\tNick: %s - Tempo: %f seg.\nQUARTO LUGAR:\n\tNick: %s - Tempo: %f seg.\nQUINTO LUGAR:\n\tNick: %s - Tempo: %f seg.\n",
	dini_Get(arqui,"nomep"),dini_Get(arqui,"gan_1"),floatdiv(dini_IntFloat(arqui,"tem_1"),1000.000000),dini_Get(arqui,"gan_2"),floatdiv(dini_IntFloat(arqui,"tem_2"),1000.000000),dini_Get(arqui,"gan_3"),floatdiv(dini_IntFloat(arqui,"tem_3"),1000.000000),dini_Get(arqui,"gan_4"),floatdiv(dini_IntFloat(arqui,"tem_4"),1000.000000),dini_Get(arqui,"gan_5"),floatdiv(dini_IntFloat(arqui,"tem_5"),1000.000000) );
    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "[iG] Cidade Virtual - RANKING RACHAS", strdialog, "Ok", "Cancelar"); return 1;
}

stock PlayerNoCheckPoint(playerid, NumPla)
{
	CheckPoint[NumPla]++;
	if (CheckPoint[NumPla] == 20)
	{
		Racha[ContarPlacar]++;
		new Float:Tempo = floatsub(GetTickCount(),Racha[TimerIni]);
		if (Racha[ContarPlacar] == 1)
		{
			new strdialog[128], arqui[40]; format(arqui, 40,"/iGamming/iEventos/iRachas/%d.ini", Racha[IDRachaAberto]);
			format(strdialog, 256,"!! PARABÉNS PELO PRIMEIRO LUGAR NO RACHA !!\n\nVocê completou o racha %s em primeiro lugar.\nSeu tempo foi de %f segundos.\n\nConfira o Ranking usando /ranking", dini_Get(arqui,"nomep"),floatdiv(Tempo,1000));
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "[iG] Cidade Virtual - PARABÉNS - PRIMEIRO LUGAR", strdialog, "Ok", "Cancelar"); VerificarPlacar(playerid, floatround(Tempo));
			format(strdialog, 256,"{F9c68A}| INFO | %s(%d) conquistou o primeiro lugar no racha, tempo %f segundos.", pName(playerid), playerid, floatdiv(Tempo,1000)); SendClientMessageToAll(COR_RACHA, strdialog);
		}
		else if (Racha[ContarPlacar] == 2)
		{
			new strdialog[128], arqui[40]; format(arqui, 40,"/iGamming/iEventos/iRachas/%d.ini", Racha[IDRachaAberto]);
			format(strdialog, 256,"!! PARABÉNS PELO SEGUNDO LUGAR NO RACHA !!\n\nVocê completou o racha %s em segundo lugar.\nSeu tempo foi de %f segundos.\n\nConfira o Ranking usando /ranking", dini_Get(arqui,"nomep"),floatdiv(Tempo,1000));
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "[iG] Cidade Virtual - PARABÉNS - SEGUNDO LUGAR", strdialog, "Ok", "Cancelar"); VerificarPlacar(playerid, floatround(Tempo));
			format(strdialog, 256,"{F9c68A}| INFO | %s(%d) conquistou o segundo lugar no racha, tempo %f segundos.", pName(playerid), playerid, floatdiv(Tempo,1000)); SendClientMessageToAll(COR_RACHA, strdialog);
		}
		else if (Racha[ContarPlacar] == 3)
		{
			new strdialog[128], arqui[40]; format(arqui, 40,"/iGamming/iEventos/iRachas/%d.ini", Racha[IDRachaAberto]);
			format(strdialog, 256,"!! PARABÉNS PELO TERCEIRO LUGAR NO RACHA !!\n\nVocê completou o racha %s em terceiro lugar.\nSeu tempo foi de %f segundos.\n\nConfira o Ranking usando /ranking", dini_Get(arqui,"nomep"),floatdiv(Tempo,1000));
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "[iG] Cidade Virtual - PARABÉNS - TERCEIRO LUGAR", strdialog, "Ok", "Cancelar"); VerificarPlacar(playerid, floatround(Tempo));
			format(strdialog, 256,"{F9c68A}| INFO | %s(%d) conquistou o terceiro lugar no racha, tempo %f segundos.", pName(playerid), playerid, floatdiv(Tempo,1000)); SendClientMessageToAll(COR_RACHA, strdialog);
		}
		else if (Racha[ContarPlacar] == 4)
		{
			new strdialog[128], arqui[40]; format(arqui, 40,"/iGamming/iEventos/iRachas/%d.ini", Racha[IDRachaAberto]);
			format(strdialog, 256,"!! PARABÉNS PELO QUARTO LUGAR NO RACHA !!\n\nVocê completou o racha %s em quarto lugar.\nSeu tempo foi de %f segundos.\n\nConfira o Ranking usando /ranking", dini_Get(arqui,"nomep"),floatdiv(Tempo,1000));
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "[iG] Cidade Virtual - PARABÉNS - QUARTO LUGAR", strdialog, "Ok", "Cancelar"); VerificarPlacar(playerid, floatround(Tempo));
			format(strdialog, 256,"{F9c68A}| INFO | %s(%d) conquistou o quarto lugar no racha, tempo %f segundos.", pName(playerid), playerid, floatdiv(Tempo,1000)); SendClientMessageToAll(COR_RACHA, strdialog);
		}
		else if (Racha[ContarPlacar] >= 5)
		{
			new strdialog[128], arqui[40]; format(arqui, 40,"/iGamming/iEventos/iRachas/%d.ini", Racha[IDRachaAberto]);
			format(strdialog, 256,"!! PARABÉNS VOCÊ CONCLUIU O RACHA !!\n\nVocê completou o racha %s.\nSeu tempo foi de %f segundos.\n\nConfira o Ranking usando /ranking", dini_Get(arqui,"nomep"),floatdiv(Tempo,1000));
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "[iG] Cidade Virtual - PARABÉNS", strdialog, "Ok", "Cancelar"); VerificarPlacar(playerid, floatround(Tempo));
  		}
		new NoRacha = 0; EjetarJogador(playerid); DisablePlayerRaceCheckpoint(playerid); SetPlayerVirtualWorldEx(playerid, 0); SpawnPlayer(playerid); CheckPoint[NumPla] = 0;
		for (new i = 0; i < MAX_PLAYERS; i++) if (IsPlayerConnected(i) && GetPlayerVirtualWorld(i) == 3)
		{
			if (!IsPlayerInAnyVehicle(i) && CheckPoint[NumPla] <= 20) SpawnPlayer(i);
			else NoRacha++;
		}
		if (NoRacha == 0)
		{
			Racha[Player1] = INVALID_PLAYER_ID; Racha[Player2] = INVALID_PLAYER_ID; Racha[Player3] = INVALID_PLAYER_ID; Racha[Player4] = INVALID_PLAYER_ID; Racha[Player5] = INVALID_PLAYER_ID; Racha[Player6] = INVALID_PLAYER_ID;
			Racha[Player7] = INVALID_PLAYER_ID; Racha[Player8] = INVALID_PLAYER_ID; Racha[Player9] = INVALID_PLAYER_ID; Racha[Player10] = INVALID_PLAYER_ID; Racha[Player11] = INVALID_PLAYER_ID; Racha[Player12] = INVALID_PLAYER_ID;
			Racha[CriandoRacha] = false; Racha[RachaCriada] = false; Racha[RachaIniciada] = false; Racha[ContarPlacar] = 0;
			ResetarValoresDaRacha();
		}
	}
	if (CheckPoint[NumPla] == 1) 	   SetPlayerRaceCheckpoint(playerid, 0, Circuito[1][0], Circuito[1][1], Circuito[1][2], Circuito[2][0], Circuito[2][1], Circuito[2][2], 15);
	else if (CheckPoint[NumPla] == 2)  SetPlayerRaceCheckpoint(playerid, 0, Circuito[2][0], Circuito[2][1], Circuito[2][2], Circuito[3][0], Circuito[3][1], Circuito[3][2], 15);
	else if (CheckPoint[NumPla] == 3)  SetPlayerRaceCheckpoint(playerid, 0, Circuito[3][0], Circuito[3][1], Circuito[3][2], Circuito[4][0], Circuito[4][1], Circuito[4][2], 15);
	else if (CheckPoint[NumPla] == 4)  SetPlayerRaceCheckpoint(playerid, 0, Circuito[4][0], Circuito[4][1], Circuito[4][2], Circuito[5][0], Circuito[5][1], Circuito[5][2], 15);
	else if (CheckPoint[NumPla] == 5)  SetPlayerRaceCheckpoint(playerid, 0, Circuito[5][0], Circuito[5][1], Circuito[5][2], Circuito[6][0], Circuito[6][1], Circuito[6][2], 15);
	else if (CheckPoint[NumPla] == 6)  SetPlayerRaceCheckpoint(playerid, 0, Circuito[6][0], Circuito[6][1], Circuito[6][2], Circuito[7][0], Circuito[7][1], Circuito[7][2], 15);
	else if (CheckPoint[NumPla] == 7)  SetPlayerRaceCheckpoint(playerid, 0, Circuito[7][0], Circuito[7][1], Circuito[7][2], Circuito[8][0], Circuito[8][1], Circuito[8][2], 15);
	else if (CheckPoint[NumPla] == 8)  SetPlayerRaceCheckpoint(playerid, 0, Circuito[8][0], Circuito[8][1], Circuito[8][2], Circuito[9][0], Circuito[9][1], Circuito[9][2], 15);
	else if (CheckPoint[NumPla] == 9)  SetPlayerRaceCheckpoint(playerid, 0, Circuito[9][0], Circuito[9][1], Circuito[9][2], Circuito[10][0], Circuito[10][1], Circuito[10][2], 15);
	else if (CheckPoint[NumPla] == 10) SetPlayerRaceCheckpoint(playerid, 0, Circuito[10][0], Circuito[10][1], Circuito[10][2], Circuito[11][0], Circuito[11][1], Circuito[11][2], 15);
	else if (CheckPoint[NumPla] == 11) SetPlayerRaceCheckpoint(playerid, 0, Circuito[11][0], Circuito[11][1], Circuito[11][2], Circuito[12][0], Circuito[12][1], Circuito[12][2], 15);
	else if (CheckPoint[NumPla] == 12) SetPlayerRaceCheckpoint(playerid, 0, Circuito[12][0], Circuito[12][1], Circuito[12][2], Circuito[13][0], Circuito[13][1], Circuito[13][2], 15);
	else if (CheckPoint[NumPla] == 13) SetPlayerRaceCheckpoint(playerid, 0, Circuito[13][0], Circuito[13][1], Circuito[13][2], Circuito[14][0], Circuito[14][1], Circuito[14][2], 15);
	else if (CheckPoint[NumPla] == 14) SetPlayerRaceCheckpoint(playerid, 0, Circuito[14][0], Circuito[14][1], Circuito[14][2], Circuito[15][0], Circuito[15][1], Circuito[15][2], 15);
	else if (CheckPoint[NumPla] == 15) SetPlayerRaceCheckpoint(playerid, 0, Circuito[15][0], Circuito[15][1], Circuito[15][2], Circuito[16][0], Circuito[16][1], Circuito[16][2], 15);
	else if (CheckPoint[NumPla] == 16) SetPlayerRaceCheckpoint(playerid, 0, Circuito[16][0], Circuito[16][1], Circuito[16][2], Circuito[17][0], Circuito[17][1], Circuito[17][2], 15);
	else if (CheckPoint[NumPla] == 17) SetPlayerRaceCheckpoint(playerid, 0, Circuito[17][0], Circuito[17][1], Circuito[17][2], Circuito[18][0], Circuito[18][1], Circuito[18][2], 15);
	else if (CheckPoint[NumPla] == 18) SetPlayerRaceCheckpoint(playerid, 0, Circuito[18][0], Circuito[18][1], Circuito[18][2], Circuito[19][0], Circuito[19][1], Circuito[19][2], 15);
	else if (CheckPoint[NumPla] == 19) SetPlayerRaceCheckpoint(playerid, 1, Circuito[19][0], Circuito[19][1], Circuito[19][2], Circuito[19][0], Circuito[19][1], Circuito[19][2], 20);
}
stock CriarRacha(playerid,PistaRacha)
{
    print("[racha] criando racha");
	KillTimer(Racha[TimerRacha]); Racha[TimerRacha] = -1; Racha[RachaCriada] = true; Racha[TimerIni] = 0;
    DestroyVehicle(Racha[Carro1]);DestroyVehicle(Racha[Carro2]);DestroyVehicle(Racha[Carro3]);DestroyVehicle(Racha[Carro4]);DestroyVehicle(Racha[Carro5]);DestroyVehicle(Racha[Carro6]);DestroyVehicle(Racha[Carro7]);DestroyVehicle(Racha[Carro8]);DestroyVehicle(Racha[Carro9]);DestroyVehicle(Racha[Carro10]);DestroyVehicle(Racha[Carro11]);DestroyVehicle(Racha[Carro12]);
	Racha[Carro1] = CreateVehicle(Racha[CarroEscolhido], Pista[0]-4, Pista[1]+4, Pista[2]+1, Pista[3], -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro1], 3);
	Racha[Carro2] = CreateVehicle(Racha[CarroEscolhido], Pista[0]+4, Pista[1]+4, Pista[2]+1, Pista[3], -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro2], 3);
	Racha[Carro3] = CreateVehicle(Racha[CarroEscolhido], Pista[0]-4, Pista[1]-4, Pista[2]+1, Pista[3], -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro3], 3);
	Racha[Carro4] = CreateVehicle(Racha[CarroEscolhido], Pista[0]+4, Pista[1]-4, Pista[2]+1, Pista[3], -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro4], 3);
	Racha[Carro5] = CreateVehicle(Racha[CarroEscolhido], Pista2[0]-4, Pista2[1]+4, Pista2[2]+1, Pista2[3], -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro5], 3);
	Racha[Carro6] = CreateVehicle(Racha[CarroEscolhido], Pista2[0]+4, Pista2[1]+4, Pista2[2]+1, Pista2[3], -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro6], 3);
	Racha[Carro7] = CreateVehicle(Racha[CarroEscolhido], Pista2[0]-4, Pista2[1]-4, Pista2[2]+1, Pista2[3], -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro7], 3);
	Racha[Carro8] = CreateVehicle(Racha[CarroEscolhido], Pista2[0]+4, Pista2[1]-4, Pista2[2]+1, Pista2[3], -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro8], 3);
	Racha[Carro9] =  CreateVehicle(Racha[CarroEscolhido], Pista3[0]-4, Pista3[1]+4, Pista3[2]+1, Pista3[3], -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro9], 3);
	Racha[Carro10] = CreateVehicle(Racha[CarroEscolhido], Pista3[0]+4, Pista3[1]+4, Pista3[2]+1, Pista3[3], -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro10], 3);
	Racha[Carro11] = CreateVehicle(Racha[CarroEscolhido], Pista3[0]-4, Pista3[1]-4, Pista3[2]+1, Pista3[3], -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro11], 3);
	Racha[Carro12] = CreateVehicle(Racha[CarroEscolhido], Pista3[0]+4, Pista3[1]-4, Pista3[2]+1, Pista3[3], -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro12], 3);
	Racha[Player1] = INVALID_PLAYER_ID; Racha[Player2] = INVALID_PLAYER_ID; Racha[Player3] = INVALID_PLAYER_ID; Racha[Player4] = INVALID_PLAYER_ID; Racha[Player5] = INVALID_PLAYER_ID; Racha[Player6] = INVALID_PLAYER_ID;
	Racha[Player7] = INVALID_PLAYER_ID; Racha[Player8] = INVALID_PLAYER_ID; Racha[Player9] = INVALID_PLAYER_ID; Racha[Player10] = INVALID_PLAYER_ID; Racha[Player11] = INVALID_PLAYER_ID; Racha[Player12] = INVALID_PLAYER_ID;
	CheckPoint[0] = 0; CheckPoint[1] = 0; CheckPoint[2] = 0; CheckPoint[3] = 0; CheckPoint[4] = 0; CheckPoint[5] = 0; CheckPoint[6] = 0; CheckPoint[7] = 0; CheckPoint[8] = 0; CheckPoint[9] = 0; CheckPoint[10] = 0; CheckPoint[11] = 0;
	if (PistaRacha == 0)// Circuito Las Venturas
	{
	    Racha[IDRachaAberto] = 0;
		new Float:PISTA000[20][3] = {
		{2717.764160, 1934.531250, 7.687500},{2717.619628, 2234.531738, 7.604482},{2629.435302, 2512.127685, 7.298759},{2349.521728, 2622.983398, 7.682996},
		{2054.432373, 2566.006835, 7.726562},{1764.531860, 2485.381835, 7.764380},{1268.009399, 2473.411376, 8.014484},{981.165710, 2567.496582, 10.714376},
		{678.792358, 2566.408935, 28.855609},{661.078430, 2265.490966, 25.837467},{657.436340, 1864.768188, 5.029215},{814.407043, 1802.255249, 3.201631},
		{860.463195, 1605.431640, 13.871212},{791.658935, 1309.342041, 24.919544},{837.357971, 1111.192749, 29.726291},{930.584045, 800.083068, 14.470630},
		{909.344909, 724.906250, 10.414097},{718.309570, 665.922180, 10.243046},{449.919738, 738.884765, 5.631542},{225.637542, 969.696594, 28.189987}  };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA000[i][0]; Circuito[i][1] = PISTA000[i][1]; Circuito[i][2] = PISTA000[i][2]; }
	}
	else if (PistaRacha == 1)// Welcome to the Jungle I
	{
	    Racha[IDRachaAberto] = 1;
		new Float:PISTA001[20][3] = {
		{-719.286621, -2353.074462, 41.926330},{-583.502197, -2382.776611, 28.670028},{-744.336425, -2665.327148, 85.044418},{-1181.046264, -2638.804443, 11.757812},
		{-1644.685302, -2624.108398, 47.611743},{-1893.728393, -2417.671142, 32.500026},{-1666.294433, -2251.023437, 34.980625},{-1706.785156, -2090.174804, 38.938465},
		{-1978.337890, -1987.545898, 78.515136},{-1718.420898, -1913.098754, 98.473617},{-1473.659423, -1784.838378, 50.796295},{-1408.148071, -2033.960937, 1.088661},
		{-1217.081298, -2341.961669, 17.353271},{-947.448059, -2351.675781, 59.928367},{-791.698852, -2473.090576, 77.652099},{-711.668823, -2352.657714, 41.132732},
		{-584.846496, -2355.433837, 27.718805},{-450.755828, -2259.855468, 46.365333},{-253.861938, -2258.455322, 28.279623},{-25.353826, -2509.576660, 36.648437} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA001[i][0]; Circuito[i][1] = PISTA001[i][1]; Circuito[i][2] = PISTA001[i][2]; }
	}
	else if (PistaRacha == 2)// Welcome to the Jungle II
	{
	    Racha[IDRachaAberto] = 2;
		new Float:PISTA002[20][3] = {
		{-284.571472, -1919.465332, 27.894615},{-317.265991, -1906.736083, 12.051520},{-442.578765, -1918.419067, 6.510727},{-482.475921, -2025.482666, 48.864818},
		{-665.688415, -2020.083496, 24.711362},{-758.633789, -1863.458984, 12.673524},{-795.975891, -2150.163818, 23.007125},{-945.900268, -2197.227050, 37.533653},
		{-971.206604, -2362.048339, 64.825149},{-1300.319213, -2193.197753, 21.847095},{-1409.710937, -2035.631469, 1.043722},{-1475.725341, -1791.665649, 51.465637},
		{-1693.388793, -1901.614501, 95.470947},{-1977.675903, -2022.405883, 78.675697},{-1675.380493, -2117.414062, 36.598442},{-1692.529052, -2302.983154, 44.220577},
		{-1437.810791, -2510.963378, 55.451072},{-1448.895019, -2686.001953, 54.554828},{-1447.829589, -2871.375488, 48.202938},{-1606.037963, -2714.467041, 48.470649} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA002[i][0]; Circuito[i][1] = PISTA002[i][1]; Circuito[i][2] = PISTA002[i][2]; }
	}
	else if (PistaRacha == 3)// Grass Racha
	{
	    Racha[IDRachaAberto] = 3;
		new Float:PISTA003[20][3] = {
		{-1855.056762, 416.330749, 16.712366},{-1811.474975, 355.433654, 16.728637},{-1892.344726, -88.412101, 38.242187},{-1902.990966, -536.656250, 37.939670},
		{-1896.533447, -970.498229, 42.161548},{-1912.043212, -1372.370117, 40.179687},{-1511.516113, -1610.117309, 38.709926},{-1171.743774, -1878.377929, 76.871673},
		{-772.728698, -1738.360961, 95.307662},{-742.886047, -1268.759277, 68.160636},{-713.576965, -1715.428588, 45.936500},{-650.367309, -1597.362915, 24.002742},
		{-484.342071, -1673.327758, 11.662823},{-278.590698, -1660.161987, 15.495124}, {79.410552, -1261.379150, 13.882271},{631.703735, -1216.228637, 17.683254},
		{596.139038, -1179.972045, 21.364948},{5.779144, -1470.392822, 3.969820},{-150.105575, -1401.615234, 2.268792},{-73.015609, -1125.964355, 1.078125} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA003[i][0]; Circuito[i][1] = PISTA003[i][1]; Circuito[i][2] = PISTA003[i][2]; }
	}
	else if (PistaRacha == 4)// Los Santos - San Fierro
	{
	    Racha[IDRachaAberto] = 4;
		new Float:PISTA004[20][3] = {
		{-129.693023, -1458.979858, 2.417948},{-81.831260, -1294.033935, 5.276229},{-290.318359, -1760.040771, 14.954913},{-292.578948, -2187.968505, 28.131282},
		{-162.465087, -2442.826416, 34.134784},{-190.832336, -2817.502441, 42.915657},{-742.155944, -2762.253173, 74.209640},{-1335.103515, -2875.501220, 55.830619},
		{-1815.948242, -2601.201171, 54.606357},{-2207.123291, -2638.461425, 47.964645},{-2532.279052, -2182.489746, 29.736419},{-2928.595458, -1574.768920, 10.971591},
		{-2893.870117, -1072.541992, 9.202444},{-2753.618652, -439.703979, 8.060346},{-2147.082031, -342.310974, 35.128551},{-1991.178588, -332.500122, 34.564369},
		{-1804.203735, -318.425231, 24.370887},{-1818.764160, -580.837280, 16.061901},{-1703.321655, -575.162841, 14.448581},{-1545.558227, -431.429260, 5.685532} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA004[i][0]; Circuito[i][1] = PISTA004[i][1]; Circuito[i][2] = PISTA004[i][2]; }
	}
	else if (PistaRacha == 5)// Vale da Morte
	{
	    Racha[IDRachaAberto] = 5;
		new Float:PISTA005[20][3] = {
		{-1700.391113, -753.190185, 38.659492},{-1219.645751, -778.980957, 63.631496},{-885.947326, -1118.427612, 98.599601},{-652.554565, -999.129333, 68.545669},
		{-385.263305, -835.436279, 46.697277},{-124.094917, -983.679687, 25.558439},{37.064823, -648.413269, 2.736660},{277.687805, -565.487792, 40.148895},
		{425.053710, -563.997497, 39.551090},{498.003173, -296.393005, 40.521091},{550.943298, -143.430297, 36.341030},{941.417358, -178.274444, 10.757051},
		{1230.022705, -121.402717, 38.937011},{932.249938, -90.420806, 17.380336},{635.563537, -196.756240, 10.071129},{307.437011, -383.182006, 8.844088},
		{475.508209, -383.591918, 27.698127},{531.205017, -73.802810, 34.376869},{518.940002, 237.733276, 14.001208},{753.585388, 338.885467, 20.063451} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA005[i][0]; Circuito[i][1] = PISTA005[i][1]; Circuito[i][2] = PISTA005[i][2]; }
	}
	else if (PistaRacha == 6)// Exportacao LV - LS
	{
	    Racha[IDRachaAberto] = 6;
		new Float:PISTA006[20][3] = {
		{1006.176208, 1852.384643, 10.430006},{1008.727783, 1195.589111, 10.236639},{1176.740478, 1171.264404, 10.299489},{1216.871215, 1054.652465, 7.421719},
		{1360.894775, 851.147277, 6.782662},{1797.062500, 824.101928, 10.205003},{1693.903076, 400.478546, 29.974599},{1611.161621, 55.773639, 36.881233},
		{1702.289672, -488.348419, 33.228214},{1657.007446, -998.960998, 62.444137},{1600.145385, -1555.877319, 28.152595},{1612.431762, -1792.581054, 26.634685},
		{1657.006713, -1963.291015, 23.418912},{1527.337646, -2123.629394, 13.965246},{1367.787475, -2158.275146, 13.113336},{1313.959960, -2304.261474, 13.113015},
		{1261.170654, -2354.107910, 17.711456},{1392.611572, -2378.283203, 19.396038},{1596.408447, -2379.893554, 12.941571},{1789.118164, -2364.750000, 13.106526} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA006[i][0]; Circuito[i][1] = PISTA006[i][1]; Circuito[i][2] = PISTA006[i][2]; }
	}
	else if (PistaRacha == 7)// Alem da Ponte
	{
	    Racha[IDRachaAberto] = 7;
		new Float:PISTA007[20][3] = {
		{-139.053283, 479.863189, 11.805200},{-272.477508, 66.965866, 0.805204},{-263.744812, -275.741546, 1.249075},{-948.553833, -244.465820, 37.452556},
		{-988.093566, -440.138031, 35.614543},{-450.904602, -420.304168, 15.175228},{-379.793273, -719.537780, 23.448123},{-631.972473, -735.687011, 60.346534},
		{-840.601806, -1025.979980, 86.260704},{-924.936401, -1392.259277, 126.312622},{-901.506225, -1530.568725, 118.902259},{-827.455810, -1582.092041, 125.486618},
		{-957.578125, -1630.016113, 76.994140},{-960.831604, -1717.728637, 77.304267},{-895.406677, -1722.018920, 76.936241},{-849.426269, -1845.664550, 90.652542},
		{-973.601440, -1917.611572, 80.221969},{-1185.895996, -2426.367187, 52.041145},{-771.764953, -2449.549072, 71.376556},{-258.684448, -2077.233398, 36.827159} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA007[i][0]; Circuito[i][1] = PISTA007[i][1]; Circuito[i][2] = PISTA007[i][2]; }
	}
	else if (PistaRacha == 8)// Becos de Los Santos
	{
	    Racha[IDRachaAberto] = 8;
		new Float:PISTA008[20][3] = {
		{1404.921630, -859.338745, 45.062976},{1517.328857, -824.946228, 68.796035},{1441.228881, -699.373535, 88.520904},{1235.028076, -737.960632, 95.527709},
		{976.195007, -808.230163, 97.655883},{660.669311, -1080.245361, 47.837833},{360.886901, -1165.546875, 77.436859},{239.173522, -1339.437744, 51.777278},
		{75.366249, -1534.052246, 4.894973},{-23.574291, -1530.302978, 1.529627},{-211.249572, -1643.395263, 2.261135},{-259.700286, -2076.787109, 36.769195},
		{-407.359405, -2199.873046, 55.390705},{-683.913208, -2256.248535, 14.404859},{-1143.549560, -2561.554443, 70.270843},{-984.175292, -1908.105590, 79.482902},
		{-1565.578735, -1604.916625, 37.107791},{-1966.884643, -1830.172851, 36.042770},{-2109.494384, -2085.839599, 62.016326},{-2392.016601, -2203.897216, 32.918148} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA008[i][0]; Circuito[i][1] = PISTA008[i][1]; Circuito[i][2] = PISTA008[i][2]; }
	}
	else if (PistaRacha == 9)// // Monte Chiliad
	{
	    Racha[IDRachaAberto] = 9;
		new Float:PISTA009[20][3] = {
		{-2282.278808, -1743.909423, 462.895965},{-2370.610595, -1811.562500, 431.783294},{-2454.282714, -1720.336303, 430.906097},{-2445.683349, -1812.158691, 410.269958},{-2476.371582, -1473.342651, 390.731903},
		{-2255.171386, -1485.330932, 379.019775},{-2199.005371, -1721.035400, 376.566009},{-2224.685546, -1490.353515, 357.983551},{-2400.645019, -1390.940917, 359.355499},{-2574.985839, -1501.815551, 358.949462},
		{-2337.729492, -1294.308471, 309.487670},{-2515.621093, -1276.142700, 271.493743},{-2670.341796, -1395.536987, 254.464752},{-2514.172363, -1114.476684, 177.281280},{-2616.802734, -1156.987182, 170.322067},
		{-2749.494384, -1386.656982, 142.539535},{-2763.443359, -1559.873657, 140.687332},{-2788.061523, -1753.430908, 141.170013},{-2807.352050, -1875.603149, 119.980606},{-2682.233886, -2066.537353, 78.444396} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA009[i][0]; Circuito[i][1] = PISTA009[i][1]; Circuito[i][2] = PISTA009[i][2]; }
	}
	else if (PistaRacha == 10)// Ida para o Deserto
	{
	    Racha[IDRachaAberto] = 10;
		new Float:PISTA010[20][3] = {
		{-1969.954101, -350.781036, 39.385437},{-1858.241943, 275.741302, 38.475227},{-1496.804565, 722.883239, 45.694610},{-1097.206298, 1216.302001, 39.053028},
		{-1178.845947, 1632.345703, 16.527322},{-1744.814086, 1827.786376, 22.592517},{-1812.652343, 2137.796386, 7.021401},{-1608.924926, 2377.552246, 49.992443},
		{-1431.454956, 2362.404296, 52.966388},{-1239.469848, 1923.159912, 42.487216},{-1057.134643, 2151.739501, 86.867042},{-1218.108520, 2684.743408, 45.833038},
		{-778.900573, 2717.219482, 44.926380},{-699.735656, 2518.386230, 74.880165},{-394.360107, 2447.764160, 41.880592},{-458.196441, 2026.987060, 60.113449},
		{-884.037780, 1970.386108, 59.826820},{-888.303527, 1795.879272, 59.830310},{-1060.686645, 1837.314208, 51.151885},{-1470.864746, 1864.188964, 32.263175} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA010[i][0]; Circuito[i][1] = PISTA010[i][1]; Circuito[i][2] = PISTA010[i][2]; }
	}
	else if (PistaRacha == 11)// Aldea malvada
	{
	    Racha[IDRachaAberto] = 11;
		new Float:PISTA011[20][3] = {
		{-742.862915, 2345.306396, 124.704368},{-771.988037, 2562.049316, 85.496520},{-698.244018, 2686.380126, 56.350490},{-1221.171875, 2671.874267, 46.156074},
		{-1069.066284, 2120.596435, 87.809745},{-1238.431884, 1900.461425, 42.033107},{-1139.591064, 1801.239013, 40.714706},{-879.299865, 1799.497802, 60.058334},
		{-387.776397, 2079.180419, 60.934398},{-454.331420, 1759.572631, 71.986824},{-414.813842, 1918.147705, 57.434959},{-381.049682, 1301.458251, 24.665538},
		{-117.450904, 1242.966430, 17.335269},{-117.723251, 1150.838012, 19.297956},{-190.289108, 1147.553100, 19.396835},{-73.070541, 1269.739135, 11.941926},
		{-115.081527, 1819.740112, 19.725664},{-140.033905, 2060.376708, 17.234668},{127.230728, 2063.298095, 16.656877},{134.606872, 1944.174682, 19.197139} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA011[i][0]; Circuito[i][1] = PISTA011[i][1]; Circuito[i][2] = PISTA011[i][2]; }
	}
	else if (PistaRacha == 12)// Las Colinas
	{
	    Racha[IDRachaAberto] = 12;
		new Float:PISTA012[20][3] = {
		{2643.383056, -1493.598876, 29.831798},{2642.630859, -1242.424194, 49.419883},{2629.700439, -1047.262329, 69.000686},{2269.173583, -1061.966064, 48.160293},
		{2163.571289, -1011.194702, 62.367500},{2217.677978, -1128.282226, 25.218006},{1844.772583, -1050.609008, 24.718629},{1365.802856, -1036.558837, 25.712705},
		{1166.269409, -1039.738769, 31.317155},{1159.216796, -752.742980, 59.391372},{1259.291992, -391.214508, 2.120414},{1837.192504, -340.266204, 42.861038},
		{1905.058105, 43.194625, 34.217208},{1522.929077, 117.807792, 29.461843},{1288.989746, 249.684204, 18.978914},{1318.174194, 312.855072, 18.993560},
		{1016.411743, 465.519195, 19.452507},{579.401916, 287.327117, 17.664585},{213.141235, 51.539123, 1.662100},{-47.100700, 31.648017, 2.704642} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA012[i][0]; Circuito[i][1] = PISTA012[i][1]; Circuito[i][2] = PISTA012[i][2]; }
	}
	else if (PistaRacha == 13)// Aeroporto San Fierro
	{
	    Racha[IDRachaAberto] = 13;
		new Float:PISTA013[20][3] = {
		{-1548.873413, -456.115356, 5.671846},{-1430.739135, -444.172088, 11.560546},{-1405.154541, -303.971374, 5.766051},{-1399.201782, -239.374679, 5.578011},
		{-1341.937255, -238.452301, 5.565104},{-1345.751464, -136.655578, 5.563583},{-1466.287597, -135.573806, 5.571005},{-1467.307861, -31.847562, 5.564646},
		{-1377.779418, -31.161249, 5.565684},{-1377.521728, 35.067615, 5.568968},{-1343.762084, 38.081436, 5.559361},{-1344.904174, -239.373321, 5.574370},
		{-1467.749877, -239.032913, 5.569497},{-1466.851562, -31.451370, 5.568430},{-1399.333251, -30.890438, 5.572390},{-1378.843139, 83.454818, 2.017742},
		{-1259.313354, 100.425102, 5.508598},{-1199.441406, 32.846401, 13.725395},{-1429.877075, -114.020545, 13.716154},{-1509.861938, -290.265960, 5.420659} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA013[i][0]; Circuito[i][1] = PISTA013[i][1]; Circuito[i][2] = PISTA013[i][2]; }
	}
	else if (PistaRacha == 14)// Ruas de San Fierro
	{
	    Racha[IDRachaAberto] = 14;
		new Float:PISTA014[20][3] = {
		{-2606.557617, 708.446228, 27.381868},{-2510.889404, 722.996154, 29.518684},{-2260.879394, 726.505554, 48.867076},{-2143.385498, 730.974060, 68.982353},
		{-2143.139160, 1052.279541, 79.417007},{-2143.166992, 1175.727661, 55.143272},{-1884.606689, 1176.972534, 44.868640},{-1883.853027, 1055.663574, 44.868972},
		{-2213.596191, 1055.550170, 55.156013},{-2605.225341, 1123.842529, 55.007736},{-2698.149658, 1215.680664, 54.760448},{-2722.227783, 1092.184814, 45.837680},
		{-2533.007324, 1247.795532, 34.571060},{-2457.331298, 1220.568969, 34.629810},{-2456.014160, 1376.849975, 6.611100},{-2123.877929, 1332.045288, 6.607064},
		{-1773.258911, 1361.838378, 6.759480},{-1615.328979, 1193.851440, 6.604257},{-1794.517578, 1187.058471, 24.545772},{-1793.408569, 755.822998, 24.464126} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA014[i][0]; Circuito[i][1] = PISTA014[i][1]; Circuito[i][2] = PISTA014[i][2]; }
	}
	else if (PistaRacha == 15)// Da ponte ao deserto
	{
	    Racha[IDRachaAberto] = 15;
		new Float:PISTA015[20][3] = {
		{-2681.528808, 1348.828979, 55.377426},{-2681.363037, 1947.315917, 63.353214},{-2674.775146, 2191.801757, 54.986968},{-2737.045410, 2352.787841, 71.624404},
		{-2642.129882, 2503.134765, 29.303390},{-2504.801025, 2420.764648, 16.163000},{-2327.447021, 2391.115478, 5.341866},{-2430.620849, 2316.856689, 4.549824},
		{-2431.958251, 2246.091308, 4.556173},{-2466.533691, 2247.229736, 4.370783},{-2490.557617, 2396.898193, 15.080049},{-2639.972412, 2504.735595, 29.006687},
		{-2732.663085, 2355.093750, 71.500511},{-2640.564697, 2596.316650, 71.650230},{-1996.632324, 2563.491210, 54.783836},{-1675.304809, 2138.709228, 18.730857},
		{-1538.906738, 1841.883789, 28.148801},{-1472.001342, 1863.031860, 32.205207},{-1317.072998, 1856.135375, 37.645679},{-1202.752319, 1822.811157, 41.285156} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA015[i][0]; Circuito[i][1] = PISTA015[i][1]; Circuito[i][2] = PISTA015[i][2]; }
	}
	else if (PistaRacha == 16)// Pontes de San Fierro
	{
	    Racha[IDRachaAberto] = 16;
		new Float:PISTA016[20][3] = {
		{-1793.814331, 380.530487, 16.803136},{-1649.336059, 561.899414, 39.053432},{-1211.577148, 1024.207519, 42.510631},{-1085.157470, 1368.524780, 28.558738},
		{-1176.578979, 1676.532348, 20.875473},{-1501.273071, 1844.559936, 30.586578},{-1535.984497, 1853.524536, 28.511878},{-1734.711547, 2169.216796, 16.919757},
		{-1983.329589, 2244.567871, 14.742956},{-1997.369995, 2442.349121, 35.275432},{-1821.153686, 2687.494628, 55.408535},{-2010.422851, 2618.904052, 50.704524},
		{-1911.891845, 2413.532226, 51.342941},{-2022.386230, 2583.456542, 54.716346},{-2644.780517, 2594.762939, 72.296470},{-2734.205078, 2334.624023, 70.652442},
		{-2680.587402, 2115.350585, 55.367538},{-2682.409423, 1803.942871, 67.814369},{-2682.834960, 1431.525634, 55.370903},{-2671.940673, 1209.451660, 55.346958} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA016[i][0]; Circuito[i][1] = PISTA016[i][1]; Circuito[i][2] = PISTA016[i][2]; }
	}
	else if (PistaRacha == 17)// Exportacao SF - LS
	{
	    Racha[IDRachaAberto] = 17;
		new Float:PISTA017[20][3] = {
		{-1987.621704, -1204.397338, 39.252483},{-1904.312866, -1313.609741, 39.249538},{-1905.171630, -1377.475097, 39.912052},{-1530.154907, -1606.823120, 37.663154},
		{-1160.055419, -1890.404174, 78.004280},{-857.083618, -1870.239501, 88.790420},{-742.426025, -1270.201171, 68.173583},{-703.013916, -1717.638061, 44.242172},
		{-656.592529, -1597.800537, 23.922498},{-294.774505, -1677.149536, 14.356830},{-104.103218, -1417.310302, 12.424338},{-130.195205, -1307.591918, 2.496956},
		{171.344284, -1593.318359, 13.419194},{575.935058, -1730.776123, 13.045301},{959.774780, -1787.843627, 14.057699},{1052.635253, -1862.300903, 13.325797},
		{1120.917724, -2383.015625, 11.370548},{1319.948852, -2429.423339, 9.046969},{1345.897460, -2195.096191, 13.316892},{1485.058959, -2124.809326, 13.532680} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA017[i][0]; Circuito[i][1] = PISTA017[i][1]; Circuito[i][2] = PISTA017[i][2]; }
	}
	else if (PistaRacha == 18)// Tierra Robada
	{
	    Racha[IDRachaAberto] = 18;
		new Float:PISTA018[20][3] = {
		{-1308.066406, 2410.185546, 94.068267},{-1308.115844, 2228.527343, 98.820777},{-1150.147094, 2266.121582, 96.585647},{-1099.769531, 2360.978027, 85.168693},{-1073.294311, 2118.989013, 87.708938},
		{-1274.727661, 2000.374145, 64.949241},{-1255.371704, 1920.462036, 42.688400},{-1436.804809, 2382.074951, 53.286720},{-1290.939086, 2659.890625, 49.102924},{-1219.134399, 2664.508544, 45.872749},
		{-1100.004150, 2364.568359, 84.857391},{-1062.717407, 2124.237792, 87.412254},{-1272.765380, 1987.463867, 61.768615},{-1127.623168, 1750.729858, 35.186264},{-1018.438049, 1619.232299, 32.489753},
		{-1022.146545, 1408.682983, 39.452033},{-981.210205, 1452.819335, 37.121166},{-944.058593, 1409.636718, 29.377151},{-873.117980, 1496.937133, 22.941133},{-776.541748, 1437.158813, 13.341149} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA018[i][0]; Circuito[i][1] = PISTA018[i][1]; Circuito[i][2] = PISTA018[i][2]; }
	}
	else if (PistaRacha == 19)// Velozes de Los Santos
	{
	    Racha[IDRachaAberto] = 19;
		new Float:PISTA019[20][3] = {
		{2590.043701, -1611.169921, 19.201911},{2425.086181, -1589.739135, 12.943617},{2342.553466, -1545.288574, 23.502420},{2355.544189, -1474.422119, 23.502590},{2444.931152, -1443.948730, 23.495862},
		{2642.397216, -1434.173095, 29.949680},{2632.617431, -1048.028564, 68.974555},{2173.243164, -1006.517333, 62.367645},{1980.063842, -1063.107177, 23.981124},{1984.820800, -1260.324462, 23.381757},
		{2262.867187, -1260.805541, 23.549173},{2317.037109, -1217.575805, 23.120178},{2378.718994, -1256.477416, 23.399114},{2795.256591, -1262.430908, 46.369125},{2802.609863, -1384.860351, 20.833086},
		{2874.003906, -1390.636474, 10.484971},{2853.215820, -1669.025024, 10.434932},{2812.767089, -1850.225097, 10.502489},{2663.098876, -1807.794677, 8.887307},{2642.976318, -1655.965087, 10.703125} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA019[i][0]; Circuito[i][1] = PISTA019[i][1]; Circuito[i][2] = PISTA019[i][2]; }
	}
	else if (PistaRacha == 20)// Fim da Linha
	{
	    Racha[IDRachaAberto] = 20;
		new Float:PISTA020[20][3] = {
		{2502.809082, -1256.564331, 34.441783},{2370.986816, -1259.601196, 23.407920},{2359.671142, -1300.839599, 23.405170},{2069.088867, -1300.872192, 23.392879},{2067.384033, -1088.340087, 24.353071},
		{1873.862182, -1052.136352, 23.247171},{1862.959838, -1260.777954, 12.940641},{2264.093017, -1260.628295, 23.549400},{2314.009521, -1301.014648, 23.571086},{2371.271728, -1300.127075, 23.411067},
		{2342.364990, -1398.144042, 23.383182},{2343.229736, -1731.046020, 12.946048},{2215.756835, -1760.756347, 12.957123},{2221.048339, -1972.318481, 12.997491},{2413.591064, -1971.688354, 12.994171},
		{2423.710693, -1932.171386, 12.966923},{2713.814208, -1934.441528, 12.881507},{2723.362792, -2155.614746, 10.504392},{2848.031005, -2069.968017, 10.662041},{2899.235351, -1867.100341, 2.535869} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA020[i][0]; Circuito[i][1] = PISTA020[i][1]; Circuito[i][2] = PISTA020[i][2]; }
	}
	else if (PistaRacha == 21)// Entrando no Esgoto
	{
	    Racha[IDRachaAberto] = 21;
		new Float:PISTA021[20][3] = {
		{2413.585449, -2049.345458, 13.092844},{2566.496093, -2049.426025, 3.566014},{2618.329101, -1623.817138, 7.643983},{2641.971679, -1404.063964, 29.989665},{2681.613525, -1397.956542, 30.318307},
		{2722.859375, -1395.879028, 36.253917},{2700.751953, -1594.192138, 12.926008},{2622.048339, -1620.437133, 9.058316},{2561.550537, -1850.181396, 3.508723},{1944.705444, -1833.487304, 6.785639},
		{1628.295166, -1757.536376, 3.666111},{1617.064453, -1592.602783, 13.252269},{1656.134277, -1588.072998, 13.089918},{1657.655883, -1480.458862, 13.088886},{1751.198364, -1477.712280, 13.217002},
		{1811.359863, -1420.060302, 13.130663},{1849.337036, -1261.093627, 13.096259},{2069.390380, -1261.422607, 23.525718},{2185.627929, -1259.819213, 23.660236},{2313.128173, -1261.803466, 23.502231} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA021[i][0]; Circuito[i][1] = PISTA021[i][1]; Circuito[i][2] = PISTA021[i][2]; }
	}
	else if (PistaRacha == 22)// Montanha do Satelite
	{
	    Racha[IDRachaAberto] = 22;
		new Float:PISTA022[20][3] = {
		{-303.225067, 1395.675292, 72.080696},{-369.683074, 1463.981811, 62.553554},{-326.415344, 1315.947387, 52.464889},{-427.512023, 1446.508544, 34.037570},{-351.916564, 1273.219238, 23.259021},
		{-108.737739, 1256.294799, 16.132883},{185.369674, 1143.682006, 14.322655},{348.122253, 1407.471923, 6.404944},{281.928344, 1409.699584, 10.158242},{276.584655, 1480.076538, 10.335430},
		{115.052383, 1480.077148, 10.371314},{117.653617, 1340.179199, 10.330186},{278.326782, 1339.218994, 10.327145},{279.880737, 1410.611938, 10.165678},{348.479339, 1408.283813, 6.392566},
		{522.898925, 1717.777465, 10.565810},{594.201843, 2168.150634, 38.419227},{480.209167, 2381.151611, 28.930004},{455.857849, 2554.979492, 16.565259},{315.237182, 2602.859863, 16.406398} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA022[i][0]; Circuito[i][1] = PISTA022[i][1]; Circuito[i][2] = PISTA022[i][2]; }
	}
	else if (PistaRacha == 23)// Caverna do Diabo
	{
	    Racha[IDRachaAberto] = 23;
		new Float:PISTA023[20][3] = {
		{-884.289062, 1979.308105, 60.071613},{-507.750579, 1984.047119, 60.057079},{-383.134490, 2077.555419, 60.711654},{-480.023834, 1940.420166, 86.272117},{-458.145172, 1760.427246, 72.117057},
		{-414.861938, 1919.035034, 57.418846},{-467.160736, 1600.548095, 37.273517},{-470.099212, 1476.968383, 22.604463},{-439.263519, 1436.376464, 20.934225},{-398.806121, 1230.675781, 6.517593},
		{-402.433593, 1201.218750, 7.679683},{-262.041046, 1198.397949, 19.166332},{-115.257667, 1198.161743, 19.165164},{-120.277076, 1253.832275, 17.665988},{185.451416, 1143.180786, 14.190192},
		{225.026138, 972.395874, 27.753746},{426.549774, 606.487976, 18.495363},{641.157592, 311.346313, 19.443668},{1020.989196, 475.958374, 19.435806},{1303.216308, 319.506042, 18.973352} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA023[i][0]; Circuito[i][1] = PISTA023[i][1]; Circuito[i][2] = PISTA023[i][2]; }
	}
	else if (PistaRacha == 24)// No Caminho do Treem
	{
	    Racha[IDRachaAberto] = 24;
		new Float:PISTA024[20][3] = {
		{2782.965087, 1875.584350, 8.522254},{2784.806640, 1969.617919, 4.134310},{2552.988281, 2364.253662, 6.529472},{2516.216308, 2647.708984, 10.392102},{2152.064208, 2694.145263, 10.385836},
		{1833.184692, 2691.399169, 10.394910},{1556.740112, 2634.303710, 10.387752},{1220.727416, 2634.715087, 10.410326},{1050.338256, 2740.100585, 14.541639},{911.425048, 2750.306396, 19.179708},
		{808.269775, 2626.614990, 20.422721},{736.979614, 2152.964355, 14.207097},{740.860229, 1645.148071, 6.881257},{708.464050, 1363.932128, 11.323919},{407.144409, 1207.901489, 18.547891},
		{51.640350, 1292.518920, 18.350360},{-676.768554, 1172.425659, 28.549081},{-991.272521, 957.530395, 34.035812},{-1619.825805, 500.696136, 25.518787},{-1946.326904, 122.253898, 25.286838} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA024[i][0]; Circuito[i][1] = PISTA024[i][1]; Circuito[i][2] = PISTA024[i][2]; }
	}
	else if (PistaRacha == 25)// Pedras e Trilhos
	{
	    Racha[IDRachaAberto] = 25;
		new Float:PISTA025[20][3] = {
		{-1947.134399, -171.131713, 25.272861},{-1981.757202, -607.731994, 25.294694},{-1892.135498, -1236.112426, 13.520882},{-1568.919677, -1497.442626, 16.027271},{-943.894592, -1497.287841, 90.254760},
		{-776.510864, -1160.492309, 63.056640},{-492.428039, -1244.515380, 41.593849},{-350.379364, -1220.137939, 39.773788},{-149.057098, -1028.800781, 10.840903},{89.721084, -1020.538269, 21.480611},
		{571.546569, -1179.014038, 5.561748},{800.000610, -1356.782226, -2.062182},{996.296203, -1552.524780, -3.227249},{1350.191284, -1933.723876, 4.700088},{1694.957885, -1955.924316, 13.129442},
		{2070.499755, -1955.775878, 13.115815},{2191.700927, -1932.690429, 13.116274},{2202.893554, -1691.628417, 13.404837},{2282.089599, -1451.790527, 22.872995},{2287.153076, -1063.440063, 26.438552} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA025[i][0]; Circuito[i][1] = PISTA025[i][1]; Circuito[i][2] = PISTA025[i][2]; }
	}
	else if (PistaRacha == 26)// Jardim Botanico
	{
	    Racha[IDRachaAberto] = 26;
		new Float:PISTA026[20][3] = {
		{1430.483764, -2013.774169, 51.109474},{1250.155395, -1918.635375, 30.691989},{1421.437133, -1922.829101, 14.851649},{1426.410888, -1873.253784, 13.042552},{1054.528808, -1851.961303, 13.229735},
		{703.133422, -1757.934814, 13.791459},{268.761749, -1691.153198, 7.984558},{145.996856, -1567.165405, 10.582013},{238.404754, -1441.791015, 12.942337},{628.733276, -1210.479003, 17.763284},
		{795.089233, -1049.218139, 24.445634},{785.240295, -918.057556, 42.838016},{692.993774, -836.741149, 42.635433},{681.316223, -486.108337, 15.843763},{641.976684, -485.671752, 15.844246},
		{639.897216, -418.957061, 15.844531},{231.929138, -362.259246, 6.905676},{206.920379, -282.607421, 1.086256},{227.240844, -281.328857, 1.085997},{232.570785, 54.965435, 2.079042} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA026[i][0]; Circuito[i][1] = PISTA026[i][1]; Circuito[i][2] = PISTA026[i][2]; }
	}
	else if (PistaRacha == 27)// Turismo Las Venturas
	{
	    Racha[IDRachaAberto] = 27;
		new Float:PISTA027[20][3] = {
		{2308.201660, 2478.329345, 3.458029},{2320.547119, 2445.814208, 3.567759},{2347.839599, 2413.352783, 10.868083},{2229.237304, 2413.238769, 11.058114},{2137.520019, 2144.315185, 10.852519},
		{2135.636962, 1860.047241, 10.767887},{2058.291992, 1705.172973, 10.453313},{2057.876953, 1193.094360, 10.380566},{2178.159423, 1193.581420, 10.438036},{2256.604736, 1212.960449, 7.047712},
		{2406.784667, 1212.535644, 6.869894},{2407.435058, 1373.322875, 10.376381},{2623.936767, 1371.606567, 10.376093},{2625.233642, 1254.011962, 10.375943},{2426.846679, 1253.882934, 10.539421},
		{2430.125244, 955.515441, 10.376291},{2547.247558, 953.043212, 10.554358},{2547.703613, 773.219970, 10.558589},{2428.134521, 771.975524, 10.377696},{2427.662353, 568.750183, 8.788238} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA027[i][0]; Circuito[i][1] = PISTA027[i][1]; Circuito[i][2] = PISTA027[i][2]; }
	}
	else if (PistaRacha == 28)// Dark Side Race
	{
	    Racha[IDRachaAberto] = 28;
		new Float:PISTA028[20][3] = {
		{-92.326911, -1029.694580, 23.823141},{-407.631408, -827.811584, 47.590740},{-827.616271, -1016.379760, 84.212394},{-886.609985, -1121.041870, 98.652984},{-1228.162841, -768.968872, 63.608604},
		{-984.943847, -411.931610, 35.965854},{-914.568664, -146.546371, 53.858623},{-671.832885, 3.137985, 70.895416},{-886.394958, -43.339637, 34.411708},{-669.897705, 52.417655, 31.522729},
		{-776.392944, 142.793701, 7.928477},{-200.948593, 239.145294, 11.775557},{-124.619750, 548.629821, 6.452180},{-159.264312, 649.268859, 2.989275},{-297.579223, 652.733215, 17.070449},
		{-114.464706, 766.592895, 20.181396},{-122.460510, 824.024780, 20.260116},{-292.127136, 806.483032, 14.539805},{-193.615036, 1027.412231, 19.353322},{-200.871383, 1229.144165, 19.446424} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA028[i][0]; Circuito[i][1] = PISTA028[i][1]; Circuito[i][2] = PISTA028[i][2]; }
	}
	else if (PistaRacha == 29)// Passando pela Praia
	{
	    Racha[IDRachaAberto] = 29;
		new Float:PISTA029[20][3] = {
		{-2553.592773, -2120.692871, 32.695610},{-2871.535400, -1803.936767, 34.891204},{-2900.488525, -1115.969238, 9.262218},{-2898.553710, -800.222473, 7.765925},{-2925.201660, -620.280517, 2.624850},
		{-2906.344238, -168.563385, 3.108360},{-2904.721435, 273.057403, 2.739187},{-2875.216064, 401.343414, 5.006911},{-2827.021728, 550.822753, 5.040854},{-2815.614990, 901.294006, 43.824039},
		{-2865.002197, 1215.861206, 5.297245},{-2373.606201, 1376.703369, 6.891825},{-1935.950683, 1299.728637, 6.967515},{-1684.263427, 1281.786743, 6.818021},{-1545.513793, 937.882629, 6.770476},
		{-1558.835449, 660.820678, 6.810307},{-1713.905151, 684.399108, 24.499681},{-1726.898071, 612.179748, 24.512111},{-1978.968994, 607.231445, 34.785812},{-1979.395019, 429.111206, 24.801660} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA029[i][0]; Circuito[i][1] = PISTA029[i][1]; Circuito[i][2] = PISTA029[i][2]; }
	}
	else if (PistaRacha == 30)// San Fierro Final
	{
	    Racha[IDRachaAberto] = 30;
		new Float:PISTA030[20][3] = {
		{-2331.812744, 311.608032, 38.792644},{-2524.499267, 160.464996, 3.892270},{-2806.680175, 157.715606, 6.735175},{-2809.658203, -206.700485, 6.735977},{-2655.068847, -209.605575, 4.003264},
		{-2646.365966, -254.668701, 6.453045},{-2475.944091, -308.138763, 41.182643},{-2372.749511, -207.664932, 42.427898},{-2257.597412, -189.357727, 34.876422},{-2278.726074, 388.318359, 34.327724},
		{-2205.635498, 453.015747, 34.874336},{-2145.261474, 452.936218, 34.638118},{-2143.195068, 730.018676, 69.034065},{-2143.379150, 917.585144, 79.472778},{-1979.729248, 924.625427, 44.916751},
		{-1629.711791, 908.751403, 11.524114},{-1629.111694, 845.609008, 7.334320},{-1794.984252, 845.162231, 24.358392},{-1774.252929, 984.473205, 23.167022},{-1685.496459, 984.303405, 17.217987} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA030[i][0]; Circuito[i][1] = PISTA030[i][1]; Circuito[i][2] = PISTA030[i][2]; }
	}
	else if (PistaRacha == 31)// PISTA ESPECIAL LANCHA
	{
	    Racha[IDRachaAberto] = 31;
		new Float:PISTA031[20][3] = {
		{1744.589111, -16.664186, -0.200000},{1382.220336, -258.261535, -0.200000},{695.569824, -221.033401, -0.200000},{141.129852, -421.134704, -0.200000},{-100.564727, -664.004516, -0.200000},
		{-114.477798, -884.752075, -0.200000},{46.269908, -916.362854, -0.200000},{36.087413, -1309.833374, -0.200000},{44.582794, -1586.707641, -0.200000},{-199.482299, -1736.681518, -0.200000},
		{-183.179992, -2157.478515, -0.200000},{-29.559234, -2271.232421, -0.200000},{113.024879, -2097.844970, -0.200000},{247.128372, -1940.123291, -0.200000},{366.388763, -2010.694824, -0.200000},
		{870.663085, -1955.261108, -0.200000},{880.463745, -2090.861572, -0.200000},{720.005920, -2122.665771, -0.200000},{723.511291, -1882.251342, -0.200000},{726.670959, -1486.867065, -0.200000} };
		for (new i = 0; i < 20; i++) { Circuito[i][0] = PISTA031[i][0]; Circuito[i][1] = PISTA031[i][1]; Circuito[i][2] = PISTA031[i][2]; }
	}
	new strrac[128];
	KillTimer(Racha[TimerCriacao]); Racha[TimerCriacao] = -1;
	Racha[TimerTempoDeRacha] = SetTimer("ResetarValoresDaRacha", 600000, 0);
	Racha[TimerRacha] = SetTimer("ContadorDoRacha", 1125, 1); Racha[ContadorRacha] = 40;
 	format(strrac, 256,"{F9c68A}| INFO | %s(%d) acabou de criar um racha.", pName(playerid), playerid); SendClientMessageToAll(COR_RACHA, strrac);
	if (Racha[CarroEscolhido] >= 400 && Racha[CarroEscolhido] <= 611)
	{
	   	new arquix[40]; format(arquix, 40, "/iGamming/iEventos/iRachas/%d.ini", Racha[IDRachaAberto]);
     	format(strrac, 256, "{F9c68A}| INFO | Racha [Pista: %s] [Carro: %s]", dini_Get(arquix,"nomep"), NomeCarro(Racha[CarroEscolhido]));
		SendClientMessageToAll(COR_RACHA, strrac);
	}
	return 1;
}

public ContadorDoRacha()
{
	TextDrawShowForAll(TempoIniciar);
	Racha[ContadorRacha] --;
	new string[128];
	if (Racha[ContadorRacha] >= 21) 	 format(string, 128,"~w~%d SEG~n~~g~PARA INICIAR O RACHA", Racha[ContadorRacha]);
	else if (Racha[ContadorRacha] >= 10) format(string, 128,"~y~%d SEG~n~~g~PARA INICIAR O RACHA", Racha[ContadorRacha]);
	else if (Racha[ContadorRacha] <= 9 ) format(string, 128,"~r~%d SEG~n~~g~INICIANDO RACHA", Racha[ContadorRacha]);
	TextDrawSetString(TempoIniciar,string);
	if (Racha[ContadorRacha] >= 1)
	{
		if (Racha[Player1] != INVALID_PLAYER_ID) // player1
		{
			if (GetPlayerVirtualWorld(Racha[Player1]) == 0)
			{
				SetPlayerVirtualWorldEx(Racha[Player1], 3); PutPlayerInVehicle(Racha[Player1], Racha[Carro1], 0);
				SetCameraBehindPlayer(Racha[Player1]); TogglePlayerControllable(Racha[Player1], 0);
			} else TogglePlayerControllable(Racha[Player1], 0);
		}
		if (Racha[Player2] != INVALID_PLAYER_ID) // player2
		{
			if (GetPlayerVirtualWorld(Racha[Player2]) == 0)
			{
				SetPlayerVirtualWorldEx(Racha[Player2], 3); PutPlayerInVehicle(Racha[Player2], Racha[Carro2], 0);
				SetCameraBehindPlayer(Racha[Player2]); TogglePlayerControllable(Racha[Player2], 0);
			} else TogglePlayerControllable(Racha[Player2], 0);
		}
		if (Racha[Player3] != INVALID_PLAYER_ID) // player3
		{
			if (GetPlayerVirtualWorld(Racha[Player3]) == 0)
			{
				SetPlayerVirtualWorldEx(Racha[Player3], 3); PutPlayerInVehicle(Racha[Player3], Racha[Carro3], 0);
				SetCameraBehindPlayer(Racha[Player3]); TogglePlayerControllable(Racha[Player3], 0);
			} else TogglePlayerControllable(Racha[Player3], 0);
		}
		if (Racha[Player4] != INVALID_PLAYER_ID) // player4
		{
			if (GetPlayerVirtualWorld(Racha[Player4]) == 0)
			{
				SetPlayerVirtualWorldEx(Racha[Player4], 3); PutPlayerInVehicle(Racha[Player4], Racha[Carro4], 0);
				SetCameraBehindPlayer(Racha[Player4]); TogglePlayerControllable(Racha[Player4], 0);
			} else TogglePlayerControllable(Racha[Player4], 0);
		}
		if (Racha[Player5] != INVALID_PLAYER_ID) // player5
		{
			if (GetPlayerVirtualWorld(Racha[Player5]) == 0)
			{
				SetPlayerVirtualWorldEx(Racha[Player5], 3); PutPlayerInVehicle(Racha[Player5], Racha[Carro5], 0);
				SetCameraBehindPlayer(Racha[Player5]); TogglePlayerControllable(Racha[Player5], 0);
			} else TogglePlayerControllable(Racha[Player5], 0);
		}
		if (Racha[Player6] != INVALID_PLAYER_ID) // player6
		{
			if (GetPlayerVirtualWorld(Racha[Player6]) == 0)
			{
				SetPlayerVirtualWorldEx(Racha[Player6], 3); PutPlayerInVehicle(Racha[Player6], Racha[Carro6], 0);
				SetCameraBehindPlayer(Racha[Player6]); TogglePlayerControllable(Racha[Player6], 0);
			} else TogglePlayerControllable(Racha[Player6], 0);
		}
		if (Racha[Player7] != INVALID_PLAYER_ID) // player7
		{
			if (GetPlayerVirtualWorld(Racha[Player7]) == 0)
			{
				SetPlayerVirtualWorldEx(Racha[Player7], 3); PutPlayerInVehicle(Racha[Player7], Racha[Carro7], 0);
				SetCameraBehindPlayer(Racha[Player7]); TogglePlayerControllable(Racha[Player7], 0);
			} else TogglePlayerControllable(Racha[Player7], 0);
		}
		if (Racha[Player8] != INVALID_PLAYER_ID) // player8
		{
			if (GetPlayerVirtualWorld(Racha[Player8]) == 0)
			{
				SetPlayerVirtualWorldEx(Racha[Player8], 3); PutPlayerInVehicle(Racha[Player8], Racha[Carro8], 0);
				SetCameraBehindPlayer(Racha[Player8]); TogglePlayerControllable(Racha[Player8], 0);
			} else TogglePlayerControllable(Racha[Player8], 0);
		}
		if (Racha[Player9] != INVALID_PLAYER_ID) // player9
		{
			if (GetPlayerVirtualWorld(Racha[Player9]) == 0)
			{
				SetPlayerVirtualWorldEx(Racha[Player9], 3); PutPlayerInVehicle(Racha[Player9], Racha[Carro9], 0);
				SetCameraBehindPlayer(Racha[Player9]); TogglePlayerControllable(Racha[Player9], 0);
			} else TogglePlayerControllable(Racha[Player9], 0);
		}
		if (Racha[Player10] != INVALID_PLAYER_ID) // player10
		{
			if (GetPlayerVirtualWorld(Racha[Player10]) == 0)
			{
				SetPlayerVirtualWorldEx(Racha[Player10], 3); PutPlayerInVehicle(Racha[Player10], Racha[Carro10], 0);
				SetCameraBehindPlayer(Racha[Player10]); TogglePlayerControllable(Racha[Player10], 0);
			} else TogglePlayerControllable(Racha[Player10], 0);
		}
		if (Racha[Player11] != INVALID_PLAYER_ID) // player11
		{
			if (GetPlayerVirtualWorld(Racha[Player11]) == 0)
			{
				SetPlayerVirtualWorldEx(Racha[Player11], 3); PutPlayerInVehicle(Racha[Player11], Racha[Carro11], 0);
				SetCameraBehindPlayer(Racha[Player11]); TogglePlayerControllable(Racha[Player11], 0);
			} else TogglePlayerControllable(Racha[Player11], 0);
		}
		if (Racha[Player12] != INVALID_PLAYER_ID) // player12
		{
			if (GetPlayerVirtualWorld(Racha[Player12]) == 0)
			{
				SetPlayerVirtualWorldEx(Racha[Player12], 3); PutPlayerInVehicle(Racha[Player12], Racha[Carro12], 0);
				SetCameraBehindPlayer(Racha[Player12]); TogglePlayerControllable(Racha[Player12], 0);
			} else TogglePlayerControllable(Racha[Player12], 0);
		}
	}
	if (Racha[ContadorRacha] <= 0) { KillTimer(Racha[TimerRacha]); Racha[TimerRacha] = -1; ComecarRacha(); }
}

stock ComecarRacha()
{
    print("[racha] comecando racha");
	Racha[RachaIniciada] = true; TextDrawHideForAll(TempoIniciar); Racha[TimerIni] = GetTickCount();
	CheckPoint[0] = 0; CheckPoint[1] = 0; CheckPoint[2] = 0;  CheckPoint[3] = 0;
	CheckPoint[4] = 0; CheckPoint[5] = 0; CheckPoint[6] = 0;  CheckPoint[7] = 0;
	CheckPoint[8] = 0; CheckPoint[9] = 0; CheckPoint[10] = 0; CheckPoint[11] = 0;
	if (Racha[Player1] != INVALID_PLAYER_ID)
	{
		GameTextForPlayer(Racha[Player1], "~g~Vai!", 2000, 3); TogglePlayerControllable(Racha[Player1], 1); ShowPlayerDialog(Racha[Player1],-1,0,"","","","");
		SetPlayerRaceCheckpoint(Racha[Player1], 0, Circuito[0][0], Circuito[0][1], Circuito[0][2], Circuito[1][0], Circuito[1][1], Circuito[1][2], 15);
		SendClientMessage(Racha[Player1], COR_RACHA,"Comandos para o Racha: /carro /sair");
	}
	if (Racha[Player2] != INVALID_PLAYER_ID)
	{
		GameTextForPlayer(Racha[Player2], "~g~Vai!", 2000, 3); TogglePlayerControllable(Racha[Player2], 1); ShowPlayerDialog(Racha[Player2],-1,0,"","","","");
		SetPlayerRaceCheckpoint(Racha[Player2], 0, Circuito[0][0], Circuito[0][1], Circuito[0][2], Circuito[1][0], Circuito[1][1], Circuito[1][2], 15);
		SendClientMessage(Racha[Player2], COR_RACHA,"Comandos para o Racha: /carro /sair");
	}
	if (Racha[Player3] != INVALID_PLAYER_ID)
	{
		GameTextForPlayer(Racha[Player3], "~g~Vai!", 2000, 3); TogglePlayerControllable(Racha[Player3], 1); ShowPlayerDialog(Racha[Player3],-1,0,"","","","");
		SetPlayerRaceCheckpoint(Racha[Player3], 0, Circuito[0][0], Circuito[0][1], Circuito[0][2], Circuito[1][0], Circuito[1][1], Circuito[1][2], 15);
		SendClientMessage(Racha[Player3], COR_RACHA,"Comandos para o Racha: /carro /sair");
	}
	if (Racha[Player4] != INVALID_PLAYER_ID)
	{
		GameTextForPlayer(Racha[Player4], "~g~Vai!", 2000, 3); TogglePlayerControllable(Racha[Player4], 1); ShowPlayerDialog(Racha[Player4],-1,0,"","","","");
		SetPlayerRaceCheckpoint(Racha[Player4], 0, Circuito[0][0], Circuito[0][1], Circuito[0][2], Circuito[1][0], Circuito[1][1], Circuito[1][2], 15);
		SendClientMessage(Racha[Player4], COR_RACHA,"Comandos para o Racha: /carro /sair");
	}
	if (Racha[Player5] != INVALID_PLAYER_ID)
	{
		GameTextForPlayer(Racha[Player5], "~g~Vai!", 2000, 3); TogglePlayerControllable(Racha[Player5], 1); ShowPlayerDialog(Racha[Player5],-1,0,"","","","");
		SetPlayerRaceCheckpoint(Racha[Player5], 0, Circuito[0][0], Circuito[0][1], Circuito[0][2], Circuito[1][0], Circuito[1][1], Circuito[1][2], 15);
		SendClientMessage(Racha[Player5], COR_RACHA,"Comandos para o Racha: /carro /sair");
	}
	if (Racha[Player6] != INVALID_PLAYER_ID)
	{
		GameTextForPlayer(Racha[Player6], "~g~Vai!", 2000, 3); TogglePlayerControllable(Racha[Player6], 1); ShowPlayerDialog(Racha[Player6],-1,0,"","","","");
		SetPlayerRaceCheckpoint(Racha[Player6], 0, Circuito[0][0], Circuito[0][1], Circuito[0][2], Circuito[1][0], Circuito[1][1], Circuito[1][2], 15);
		SendClientMessage(Racha[Player6], COR_RACHA,"Comandos para o Racha: /carro /sair");
	}
	if (Racha[Player7] != INVALID_PLAYER_ID)
	{
		GameTextForPlayer(Racha[Player7], "~g~Vai!", 2000, 3); TogglePlayerControllable(Racha[Player7], 1); ShowPlayerDialog(Racha[Player7],-1,0,"","","","");
		SetPlayerRaceCheckpoint(Racha[Player7], 0, Circuito[0][0], Circuito[0][1], Circuito[0][2], Circuito[1][0], Circuito[1][1], Circuito[1][2], 15);
		SendClientMessage(Racha[Player7], COR_RACHA,"Comandos para o Racha: /carro /sair");
	}
	if (Racha[Player8] != INVALID_PLAYER_ID)
	{
		GameTextForPlayer(Racha[Player8], "~g~Vai!", 2000, 3); TogglePlayerControllable(Racha[Player8], 1); ShowPlayerDialog(Racha[Player8],-1,0,"","","","");
		SetPlayerRaceCheckpoint(Racha[Player8], 0, Circuito[0][0], Circuito[0][1], Circuito[0][2], Circuito[1][0], Circuito[1][1], Circuito[1][2], 15);
		SendClientMessage(Racha[Player8], COR_RACHA,"Comandos para o Racha: /carro /sair");
	}
	if (Racha[Player9] != INVALID_PLAYER_ID)
	{
		GameTextForPlayer(Racha[Player9], "~g~Vai!", 2000, 3); TogglePlayerControllable(Racha[Player9], 1); ShowPlayerDialog(Racha[Player9],-1,0,"","","","");
		SetPlayerRaceCheckpoint(Racha[Player9], 0, Circuito[0][0], Circuito[0][1], Circuito[0][2], Circuito[1][0], Circuito[1][1], Circuito[1][2], 15);
		SendClientMessage(Racha[Player9], COR_RACHA,"Comandos para o Racha: /carro /sair");
	}
	if (Racha[Player10] != INVALID_PLAYER_ID)
	{
		GameTextForPlayer(Racha[Player10], "~g~Vai!", 2000, 3); TogglePlayerControllable(Racha[Player10], 1); ShowPlayerDialog(Racha[Player10],-1,0,"","","","");
		SetPlayerRaceCheckpoint(Racha[Player10], 0, Circuito[0][0], Circuito[0][1], Circuito[0][2], Circuito[1][0], Circuito[1][1], Circuito[1][2], 15);
		SendClientMessage(Racha[Player10], COR_RACHA,"Comandos para o Racha: /carro /sair");
	}
	if (Racha[Player11] != INVALID_PLAYER_ID)
	{
		GameTextForPlayer(Racha[Player11], "~g~Vai!", 2000, 3); TogglePlayerControllable(Racha[Player11], 1); ShowPlayerDialog(Racha[Player11],-1,0,"","","","");
		SetPlayerRaceCheckpoint(Racha[Player11], 0, Circuito[0][0], Circuito[0][1], Circuito[0][2], Circuito[1][0], Circuito[1][1], Circuito[1][2], 15);
		SendClientMessage(Racha[Player11], COR_RACHA,"Comandos para o Racha: /carro /sair");
	}
	if (Racha[Player12] != INVALID_PLAYER_ID)
	{
		GameTextForPlayer(Racha[Player12], "~g~Vai!", 2000, 3); TogglePlayerControllable(Racha[Player12], 1); ShowPlayerDialog(Racha[Player12],-1,0,"","","","");
		SetPlayerRaceCheckpoint(Racha[Player12], 0, Circuito[0][0], Circuito[0][1], Circuito[0][2], Circuito[1][0], Circuito[1][1], Circuito[1][2], 15);
		SendClientMessage(Racha[Player12], COR_RACHA,"Comandos para o Racha: /carro /sair");
	}
}

public ResetarValoresDaRacha()
{
    print("[racha] resetando racha");
	KillTimer(Racha[TimerCriacao]); Racha[TimerCriacao] = -1; KillTimer(Racha[TimerTempoDeRacha]); Racha[TimerTempoDeRacha] = -1; KillTimer(Racha[TimerRacha]); Racha[TimerRacha] = -1; Racha[ContadorRacha] = 0; Racha[ContarPlacar] = 0; Racha[RachaIniciada] = false; Racha[IDRachaAberto] = 40; Racha[TimerIni] = 0;
    DestroyVehicle(Racha[Carro1]);DestroyVehicle(Racha[Carro2]);DestroyVehicle(Racha[Carro3]);DestroyVehicle(Racha[Carro4]);DestroyVehicle(Racha[Carro5]);DestroyVehicle(Racha[Carro6]);DestroyVehicle(Racha[Carro7]);DestroyVehicle(Racha[Carro8]);DestroyVehicle(Racha[Carro9]);DestroyVehicle(Racha[Carro10]);DestroyVehicle(Racha[Carro11]);DestroyVehicle(Racha[Carro12]);
	Racha[Carro1] = CreateVehicle(411, -2323.342041-4, -1630.801391+4, 483.634124+1, 209.889602, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro1], 3);
	Racha[Carro2] = CreateVehicle(411, -2323.342041+4, -1630.801391+4, 483.634124+1, 209.889602, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro2], 3);
	Racha[Carro3] = CreateVehicle(411, -2323.342041-4, -1630.801391-4, 483.634124+1, 209.889602, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro3], 3);
	Racha[Carro4] = CreateVehicle(411, -2323.342041+4, -1630.801391-4, 483.634124+1, 209.889602, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro4], 3);
	Racha[Carro5] = CreateVehicle(411, -2331.281738-4, -1615.347412+4, 483.648529+1, 201.416564, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro5], 3);
	Racha[Carro6] = CreateVehicle(411, -2331.281738+4, -1615.347412+4, 483.648529+1, 201.416564, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro6], 3);
	Racha[Carro7] = CreateVehicle(411, -2331.281738-4, -1615.347412-4, 483.648529+1, 201.416564, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro7], 3);
	Racha[Carro8] = CreateVehicle(411, -2331.281738+4, -1615.347412-4, 483.648529+1, 201.416564, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro8], 3);
	Racha[Carro9] =  CreateVehicle(411, -2337.822753-4, -1598.710083+4, 483.618133+1, 201.227416, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro9], 3);
	Racha[Carro10] = CreateVehicle(411, -2337.822753+4, -1598.710083+4, 483.618133+1, 201.227416, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro10], 3);
	Racha[Carro11] = CreateVehicle(411, -2337.822753-4, -1598.710083-4, 483.618133+1, 201.227416, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro11], 3);
	Racha[Carro12] = CreateVehicle(411, -2337.822753+4, -1598.710083-4, 483.618133+1, 201.227416, -1, -1, -1); SetVehicleVirtualWorld(Racha[Carro12], 3);
	Racha[Player1] = INVALID_PLAYER_ID; Racha[Player2] = INVALID_PLAYER_ID; Racha[Player3] = INVALID_PLAYER_ID; Racha[Player4] = INVALID_PLAYER_ID; Racha[Player5] = INVALID_PLAYER_ID; Racha[Player6] = INVALID_PLAYER_ID; Racha[Player7] = INVALID_PLAYER_ID;
	Racha[Player8] = INVALID_PLAYER_ID; Racha[Player9] = INVALID_PLAYER_ID; Racha[Player10] = INVALID_PLAYER_ID; Racha[Player11] = INVALID_PLAYER_ID; Racha[Player12] = INVALID_PLAYER_ID;
	CheckPoint[0] = 0; CheckPoint[1] = 0; CheckPoint[2] = 0; CheckPoint[3] = 0; CheckPoint[4] = 0; CheckPoint[5] = 0; CheckPoint[6] = 0; CheckPoint[7] = 0; CheckPoint[8] = 0; CheckPoint[9] = 0; CheckPoint[10] = 0; CheckPoint[11] = 0;
	Racha[CriandoRacha] = false; Racha[RachaCriada] = false; Racha[RachaIniciada] = false; TextDrawHideForAll(TempoIniciar);
	for (new i = 0; i < MAX_PLAYERS; i++) if (IsPlayerConnected(i) && GetPlayerVirtualWorld(i) == 3)
	{
		EjetarJogador(i); DisablePlayerRaceCheckpoint(i); SetPlayerVirtualWorldEx(i, 0);
		SpawnPlayer(i); GameTextForPlayer(i, "  ~n~  ~n~  ~n~  ~n~  ~n~  ~n~  ~n~  ~n~~r~O SISTEMA~n~~r~FOI RESETADO", 3000, 3);
	}
	return 1;
}

stock NomeCarro(modeloid)
{
	new nomecarrotmp[50]; format(nomecarrotmp, 50,"%s", VehicleName[modeloid-400]);
	return nomecarrotmp;
}

stock SetPlayerPosEx(playerid, Float:ppx, Float:ppy, Float:ppz, Float:ppa, inte)
{
	if (inte >= 0) SetPlayerInterior(playerid, inte);
	SetPlayerPos(playerid, ppx, ppy, ppz); SetPlayerFacingAngle(playerid, ppa); SetCameraBehindPlayer(playerid);
	if (inte >= 0) SetPlayerInterior(playerid, inte);
	return 1;
}
public SalvarDadosJogador(playerid)
{
    new iGamm[128];
	iGamm = GetPlayerFile(playerid);
	new Float:Px = 0.0,Float:Py = 0.0,Float:Pz = 0.0,Float:Pvida = 0.0,Float:Pcolete = 0.0,Float:Prosto = 0.0,dinheiro = 0,interior = 0,estrelas = 1,Arma2 = 0,Arma3 = 0,
	Arma4 = 0,Arma5 = 0,Arma6 = 0,Arma7 = 0,Arma8 = 0,Arma9 = 0,Balas2 = 0,Balas3 = 0,Balas4 = 0,Balas5 = 0,Balas6 = 0,Balas7 = 0,Balas8 = 0,Balas9 = 0,vitw = 0;
	GetPlayerPos(playerid,Px,Py,Pz);
	GetPlayerHealth(playerid,Pvida);
	GetPlayerArmour(playerid,Pcolete);
	GetPlayerFacingAngle(playerid,Prosto);
	dinheiro = GetPlayerMoney(playerid);
	interior = GetPlayerInterior(playerid) ;
	estrelas = GetPlayerWantedLevel(playerid) ;
	vitw = GetPlayerVirtualWorld(playerid) ;
    GetPlayerWeaponData(playerid,2,Arma2,Balas2);
    GetPlayerWeaponData(playerid,3,Arma3,Balas3);
    GetPlayerWeaponData(playerid,4,Arma4,Balas4);
    GetPlayerWeaponData(playerid,5,Arma5,Balas5);
    GetPlayerWeaponData(playerid,6,Arma6,Balas6);
    GetPlayerWeaponData(playerid,7,Arma7,Balas7);
    GetPlayerWeaponData(playerid,8,Arma8,Balas8);
    GetPlayerWeaponData(playerid,9,Arma9,Balas9);
	if(Pvida > 100) Pvida = 100.000000;
	dini_IntSet(iGamm,"VirtualW",vitw);
	dini_IntSet(iGamm,"Interior",interior);
	dini_IntSet(iGamm,"Estrelas",estrelas);
	dini_IntSet(iGamm,"Dinheiro",dinheiro);
	dini_FloatSet(iGamm,"Vida",Pvida);
	dini_FloatSet(iGamm,"Colete",Pcolete);
	dini_FloatSet(iGamm,"Rosto",Prosto);
	Px +=(0.2*floatsin(360-Prosto,degrees)); 	dini_FloatSet(iGamm,"Px",Px);
	Py +=(0.2*floatcos(360-Prosto,degrees)); 	dini_FloatSet(iGamm,"Py",Py);
	Pz = Pz + 0.3; 								dini_FloatSet(iGamm,"Pz",Pz);
	dini_IntSet(iGamm,"Weapon2",Arma2); dini_IntSet(iGamm,"Ammo2",Balas2);
	dini_IntSet(iGamm,"Weapon3",Arma3); dini_IntSet(iGamm,"Ammo3",Balas3);
	dini_IntSet(iGamm,"Weapon4",Arma4); dini_IntSet(iGamm,"Ammo4",Balas4);
	dini_IntSet(iGamm,"Weapon5",Arma5); dini_IntSet(iGamm,"Ammo5",Balas5);
	dini_IntSet(iGamm,"Weapon6",Arma6); dini_IntSet(iGamm,"Ammo6",Balas6);
	dini_IntSet(iGamm,"Weapon7",Arma7); dini_IntSet(iGamm,"Ammo7",Balas7);
	dini_IntSet(iGamm,"Weapon8",Arma8); dini_IntSet(iGamm,"Ammo8",Balas8);
	dini_IntSet(iGamm,"Weapon9",Arma9); dini_IntSet(iGamm,"Ammo9",Balas9);
	return 1;
}

public LoadDadosJogador(playerid)
{
	new Menu:Current = GetPlayerMenu(playerid) ;
	if(IsValidMenu(Current)) HideMenuForPlayer(Current,playerid);
	ResetPlayerWeapons(playerid) ;
	SetPlayerVirtualWorldEx(playerid,0);
	new iGamm[128];
	iGamm = GetPlayerFile(playerid);
	SpawnPlayer(playerid);
	SetPlayerPos(playerid,-187.8477,1208.7825,19.6922);
	TogglePlayerControllable(playerid,0);

	new Arma2 = dini_Int(iGamm,"Weapon2"),
		Arma3 = dini_Int(iGamm,"Weapon3"),
		Arma4 = dini_Int(iGamm,"Weapon4"),
		Arma5 = dini_Int(iGamm,"Weapon5"),
		Arma6 = dini_Int(iGamm,"Weapon6"),
		Arma7 = dini_Int(iGamm,"Weapon7"),
		Arma8 = dini_Int(iGamm,"Weapon8"),
		Arma9 = dini_Int(iGamm,"Weapon9"),
		Balas2 = dini_Int(iGamm,"Ammo2"),
		Balas3 = dini_Int(iGamm,"Ammo3"),
		Balas4 = dini_Int(iGamm,"Ammo4"),
		Balas5 = dini_Int(iGamm,"Ammo5"),
		Balas6 = dini_Int(iGamm,"Ammo6"),
		Balas7 = dini_Int(iGamm,"Ammo7"),
		Balas8 = dini_Int(iGamm,"Ammo8"),
		Balas9 = dini_Int(iGamm,"Ammo9");
	if(Balas2 == 69) Balas2 = 65;
	if(Balas3 == 69) Balas3 = 65;
	if(Balas4 == 69) Balas4 = 65;
	if(Balas5 == 69) Balas5 = 65;
	if(Balas6 == 69) Balas6 = 65;
	if(Balas7 == 69) Balas7 = 65;
	if(Balas8 == 69) Balas8 = 65;
	if(Balas9 == 69) Balas9 = 65;
	GivePlayerMoney(playerid,(dini_Int(iGamm,"Dinheiro")));
	SetPlayerWantedLevel(playerid,(dini_Int(iGamm,"Estrelas")));
	SetPlayerHealth(playerid,(dini_Float(iGamm,"Vida")));
	SetPlayerArmour(playerid,(dini_Float(iGamm,"Colete")));
    PlayerInfo[playerid][pSyncronizo] = false;
	GivePlayerWeapon(playerid,0,65535);
	GivePlayerWeapon(playerid,Arma2,Balas2);
	GivePlayerWeapon(playerid,Arma3,Balas3);
	GivePlayerWeapon(playerid,Arma4,Balas4);
	GivePlayerWeapon(playerid,Arma5,Balas5);
	GivePlayerWeapon(playerid,Arma6,Balas6);
	GivePlayerWeapon(playerid,Arma7,Balas7);
	GivePlayerWeapon(playerid,Arma8,Balas8);
	GivePlayerWeapon(playerid,Arma9,Balas9);
	SetPlayerWorldBounds(playerid,99999,-99999,99999,-99999);
	ShowPlayerDialog(playerid,DIALOG_CONTINUE,DIALOG_STYLE_MSGBOX,"Continuar?","Deseja continuar na mesma posisão que você\nparou pela ultima ves que jogou no servidor?","Sim","Não");
	return 1;
}
forward SalvarDadosJogador2(playerid);
public SalvarDadosJogador2(playerid)
{
    new iGamm[128];
	iGamm = GetPlayerFile(playerid);
	new Arma2 = 0,Arma3 = 0,
	Arma4 = 0,Arma5 = 0,Arma6 = 0,
	Arma7 = 0,Arma8 = 0,Arma9 = 0,
	Balas2 = 0,Balas3 = 0,Balas4 = 0,
	Balas5 = 0,Balas6 = 0,Balas7 = 0,
	Balas8 = 0,Balas9 = 0;
    GetPlayerWeaponData(playerid,2,Arma2,Balas2);
    GetPlayerWeaponData(playerid,3,Arma3,Balas3);
    GetPlayerWeaponData(playerid,4,Arma4,Balas4);
    GetPlayerWeaponData(playerid,5,Arma5,Balas5);
    GetPlayerWeaponData(playerid,6,Arma6,Balas6);
    GetPlayerWeaponData(playerid,7,Arma7,Balas7);
    GetPlayerWeaponData(playerid,8,Arma8,Balas8);
    GetPlayerWeaponData(playerid,9,Arma9,Balas9);
	dini_IntSet(iGamm,"Weapon2",Arma2); dini_IntSet(iGamm,"Ammo2",Balas2);
	dini_IntSet(iGamm,"Weapon3",Arma3); dini_IntSet(iGamm,"Ammo3",Balas3);
	dini_IntSet(iGamm,"Weapon4",Arma4); dini_IntSet(iGamm,"Ammo4",Balas4);
	dini_IntSet(iGamm,"Weapon5",Arma5); dini_IntSet(iGamm,"Ammo5",Balas5);
	dini_IntSet(iGamm,"Weapon6",Arma6); dini_IntSet(iGamm,"Ammo6",Balas6);
	dini_IntSet(iGamm,"Weapon7",Arma7); dini_IntSet(iGamm,"Ammo7",Balas7);
	dini_IntSet(iGamm,"Weapon8",Arma8); dini_IntSet(iGamm,"Ammo8",Balas8);
	dini_IntSet(iGamm,"Weapon9",Arma9); dini_IntSet(iGamm,"Ammo9",Balas9);
	return 1;
}
forward LoadDadosJogador2(playerid);
public LoadDadosJogador2(playerid)
{
	new Menu:Current = GetPlayerMenu(playerid) ;
	if(IsValidMenu(Current)) HideMenuForPlayer(Current,playerid);
    new iGamm[128];
	iGamm = GetPlayerFile(playerid);
	new Arma2 = dini_Int(iGamm,"Weapon2"),
		Arma3 = dini_Int(iGamm,"Weapon3"),
		Arma4 = dini_Int(iGamm,"Weapon4"),
		Arma5 = dini_Int(iGamm,"Weapon5"),
		Arma6 = dini_Int(iGamm,"Weapon6"),
		Arma7 = dini_Int(iGamm,"Weapon7"),
		Arma8 = dini_Int(iGamm,"Weapon8"),
		Arma9 = dini_Int(iGamm,"Weapon9"),
		Balas2 = dini_Int(iGamm,"Ammo2"),
		Balas3 = dini_Int(iGamm,"Ammo3"),
		Balas4 = dini_Int(iGamm,"Ammo4"),
		Balas5 = dini_Int(iGamm,"Ammo5"),
		Balas6 = dini_Int(iGamm,"Ammo6"),
		Balas7 = dini_Int(iGamm,"Ammo7"),
		Balas8 = dini_Int(iGamm,"Ammo8"),
		Balas9 = dini_Int(iGamm,"Ammo9");
	if(Balas2 == 69) Balas2 = 65;
	if(Balas3 == 69) Balas3 = 65;
	if(Balas4 == 69) Balas4 = 65;
	if(Balas5 == 69) Balas5 = 65;
	if(Balas6 == 69) Balas6 = 65;
	if(Balas7 == 69) Balas7 = 65;
	if(Balas8 == 69) Balas8 = 65;
	if(Balas9 == 69) Balas9 = 65;
	GivePlayerWeapon(playerid,0,65535);
	GivePlayerWeapon(playerid,Arma2,Balas2);
	GivePlayerWeapon(playerid,Arma3,Balas3);
	GivePlayerWeapon(playerid,Arma4,Balas4);
	GivePlayerWeapon(playerid,Arma5,Balas5);
	GivePlayerWeapon(playerid,Arma6,Balas6);
	GivePlayerWeapon(playerid,Arma7,Balas7);
	GivePlayerWeapon(playerid,Arma8,Balas8);
	GivePlayerWeapon(playerid,Arma9,Balas9);
	SetPlayerWorldBounds(playerid,99999,-99999,99999,-99999);
	return 1;
}
new strhora[40];
stock HoraAtual()
{
	new Hour,Minute,Second;
	gettime(Hour,Minute,Second);
	format(strhora,sizeof(strhora),"~y~%02d:%02d",Hour,Minute);
	TextDrawSetString(TextHoras,strhora);
}
public AntiFlood(playerid) antiflood[playerid] = 0;
public SoltarFlood(playerid) mutado[playerid] = 0;
CriarCasa(casaid, Float:iconX, Float:iconY, Float:iconZ, Float:Anglee, Float:interiorX, Float:interiorY, Float:interiorZ, Compraa, Vendaa, Interiora, virtualworld, IPTUs)
{
	new casa[128];
	format(casa, sizeof(casa), "/iGamming/iCasas/%d.ini",casaid);
	if(!dini_Exists(casa))
	{
		dini_Create(casa);

		format(hInfo[casaid][Dono], 24, "Ninguem");
		dini_Set(casa, "Dono", "Ninguem");

		format(hInfo[casaid][Morador_1], 24, "Ninguem");
		dini_Set(casa, "Morador_1", "Ninguem");
		format(hInfo[casaid][Morador_2], 24, "Ninguem");
		dini_Set(casa, "Morador_2", "Ninguem");
		format(hInfo[casaid][Morador_3], 24, "Ninguem");
		dini_Set(casa, "Morador_3", "Ninguem");
		format(hInfo[casaid][Descricao], 128, "Casa [iG]");
		dini_Set(casa, "Descricaoc", "Casa [iG]");
		format(hInfo[casaid][Login], 128, "00/00/0000 00:00:00");
		dini_Set(casa, "Login", "00/00/0000 00:00:00");

		hInfo[casaid][Compra] = Compraa;
		dini_IntSet(casa, "Compra", Compraa);
		hInfo[casaid][Venda] = Vendaa;
		dini_IntSet(casa, "Venda", Vendaa);
		hInfo[casaid][Interior] = Interiora;
		dini_IntSet(casa, "Interior", Interiora);
		hInfo[casaid][VirtualWorld] = virtualworld;
		dini_IntSet(casa, "VirtualWorld", virtualworld);
		hInfo[casaid][Trancada] = 1;
		dini_IntSet(casa, "Trancada", 1);

		hInfo[casaid][Angle] = Anglee;
		hInfo[casaid][SaidaX] = interiorX;
		hInfo[casaid][SaidaY] = interiorY;
		hInfo[casaid][SaidaZ] = interiorZ;
		dini_FloatSet(casa, "X", interiorX);
		dini_FloatSet(casa, "Y", interiorY);
		dini_FloatSet(casa, "Z", interiorZ);
		CarInfo[casaid][VeiculoCasa] = 0;
		dini_IntSet(casa, "VeiculoCasa", 0);
		CarInfo[casaid][VeiculoModelo] = 0;
		dini_IntSet(casa, "CarroModelo", 0);
		CarInfo[casaid][ID] = casaid;
		dini_IntSet(casa, "ID", casaid);
		CarInfo[casaid][PosCarX] = 0;
		CarInfo[casaid][PosCarY] = 0;
		CarInfo[casaid][PosCarZ] = 0;
		CarInfo[casaid][Angulo] = 0;
		CarInfo[casaid][IPVA] = 0;
		CarInfo[casaid][Trancado] = 1;
		dini_IntSet(casa, "Trancado", 1);
		dini_FloatSet(casa, "PosCarX", 0);
		dini_FloatSet(casa, "PosCarY", 0);
		dini_FloatSet(casa, "PosCarZ", 0);
		dini_FloatSet(casa, "Angulo", 0);
		CarInfo[casaid][CarColor1] = 0;
		CarInfo[casaid][CarColor2] = 0;
		dini_IntSet(casa, "Cor_1", 0);
		dini_IntSet(casa, "Cor_2", 0);
		dini_IntSet(casa, "IPVA", 0);

		hInfo[casaid][TemDono] = 0;
		dini_IntSet(casa, "TemDono", 0);

		hInfo[casaid][IPTU] = IPTUs;
		dini_IntSet(casa, "IPTU", 0);
		print("-");
		print("--------------Casa Criada--------------");
		printf("- Casa ID: %d", casaid);
		printf("- Preço Compra: %d", Compraa);
		printf("- Preço Compra: %d", Vendaa);
		printf("- Interior: %d", Interiora);
		printf("- VirtualWorld: %d", virtualworld);
		print("-----------------------------------------");
		print("-");
	}
	else
	{
	    format(hInfo[casaid][Dono], 24, dini_Get(casa, "Dono"));
	    format(hInfo[casaid][Morador_1], 24, dini_Get(casa, "Morador_1"));
	    format(hInfo[casaid][Morador_2], 24, dini_Get(casa, "Morador_2"));
	    format(hInfo[casaid][Morador_3], 24, dini_Get(casa, "Morador_3"));
	    format(hInfo[casaid][Descricao], 80, dini_Get(casa, "Descricaoc"));
		format(hInfo[casaid][Login], 128, dini_Get(casa, "Login"));
	    hInfo[casaid][Compra] = dini_Int(casa, "Compra");
	    hInfo[casaid][Venda] = dini_Int(casa, "Venda");
	    hInfo[casaid][Interior] = dini_Int(casa, "Interior");
	    hInfo[casaid][Trancada] = dini_Int(casa, "Trancada");
	    hInfo[casaid][SaidaX] = dini_Float(casa, "X");
	    hInfo[casaid][SaidaY] = dini_Float(casa, "Y");
		hInfo[casaid][SaidaZ] = dini_Float(casa, "Z");
		hInfo[casaid][Angle] = dini_Float(casa, "Angle");
		hInfo[casaid][IPTU] = dini_Int(casa, "IPTU");
		hInfo[casaid][TemDono] = dini_Int(casa, "TemDono");
		hInfo[casaid][VirtualWorld] = dini_Int(casa, "VirtualWorld");
	}
    hInfo[casaid][EntradaX]=iconX;
	hInfo[casaid][EntradaY]=iconY;
	hInfo[casaid][EntradaZ]=iconZ;

	UpdateCasa(casaid);

	new string[20];
	format(string, sizeof(string), "Casa ID° %d", casaid);
    Create3DTextLabel(string,0xFFFFFFAA,iconX, iconY, iconZ+0.75,20.0,0,1);
	Create3DTextLabel("Aperte 'F' para sair",0xFFFFFFAA,hInfo[casaid][SaidaX], hInfo[casaid][SaidaY], hInfo[casaid][SaidaZ]+0.75,20.0,hInfo[casaid][VirtualWorld],1);
	CreateDynamicPickup(1318,1, hInfo[casaid][SaidaX], hInfo[casaid][SaidaY], hInfo[casaid][SaidaZ], hInfo[casaid][VirtualWorld], hInfo[casaid][Interior],  -1, 100);
}

public UpdateCasa(casaid)
{
    if(hInfo[casaid][TemDono] == 0)
	{
        DestroyDynamicPickup(CasaPickup[ casaid ]);
        CasaPickup[ casaid ] = CreateDynamicPickup(1273,1,hInfo[casaid][EntradaX],hInfo[casaid][EntradaY],hInfo[casaid][EntradaZ]);
	}
	else
	{
        DestroyDynamicPickup(CasaPickup[ casaid ]);
        CasaPickup[ casaid ] = CreateDynamicPickup(1272,1,hInfo[casaid][EntradaX],hInfo[casaid][EntradaY],hInfo[casaid][EntradaZ]);
	}
}

CriarVeiculoCasa(casaid, Float:Carx, Float:Cary, Float:Carz, Float:Anglee, color1, color2, respawn_delay)
{
    new casa[128];
	format(casa, sizeof(casa), "/iGamming/iCasas/%d.ini",casaid);
	if(dini_Exists(casa))
	{
		if(dini_Int(casa, "CarroModelo") == 0)
		{
            format(CarInfo[casaid][Descricao], 128, "Sem Mensagem");
	     	dini_Set(casa, "Descricao", "Sem Mensagem");
	     	format(CarInfo[casaid][Donov], 24, "Ninguem");
	     	dini_Set(casa, "DonoV", "Ninguem");
		    dini_IntSet(casa, "CarroModelo", 560);
		    CarInfo[casaid][VeiculoModelo] = 560;

		    dini_IntSet(casa, "ID", casaid);
		    CarInfo[casaid][ID] = casaid;

		    CarInfo[casaid][PosCarX] = Carx;
			CarInfo[casaid][PosCarY] = Cary;
			CarInfo[casaid][PosCarZ] = Carz;
			CarInfo[casaid][Angulo] = Anglee;
			dini_FloatSet(casa, "PosCarX", Carx);
			dini_FloatSet(casa, "PosCarY", Cary);
			dini_FloatSet(casa, "PosCarZ", Carz);
			dini_FloatSet(casa, "Angulo", Anglee);
			CarInfo[casaid][CarColor1] = color1;
			CarInfo[casaid][CarColor2] = color2;
			dini_IntSet(casa, "Cor_1", color1);
			dini_IntSet(casa, "Cor_2", color2);
			dini_IntSet(casa, "Tempo_Respawn", respawn_delay);
			CarInfo[casaid][Respawn_Delay] = respawn_delay;
			if(hInfo[casaid][TemDono] == 0)
			{
                CarInfo[casaid][VeiculoCasa] = CreateVehicle(CarInfo[casaid][VeiculoModelo], Carx, Cary, Carz, Anglee, color1, color2, respawn_delay);
			}
			print("-");
			print("--------------Carro Criado-------------");
			printf("- Veiculo Casa ID: %d", casaid);
			printf("- Modelo: %d", 560);
			printf("- Cor 1: %d", color1);
			printf("- Cor 2: %d", color2);
			printf("- Temporespawn: %d", respawn_delay);
			print("---------------------------------------");
			print("-");
		}
		else
		{
		    CarInfo[casaid][VeiculoModelo] = dini_Int(casa, "CarroModelo");
		}
		format(CarInfo[casaid][Descricao], 128, dini_Get(casa, "Descricao"));
		format(CarInfo[casaid][Donov], 24, dini_Get(casa, "DonoV"));
		CarInfo[casaid][PosCarX] = dini_Int(casa, "PosCarX");
		CarInfo[casaid][PosCarY] = dini_Int(casa, "PosCarY");
		CarInfo[casaid][PosCarZ] = dini_Int(casa, "PosCarZ");
		CarInfo[casaid][Angulo] = dini_Int(casa, "Angulo");
		CarInfo[casaid][CarColor1] = dini_Int(casa, "Cor_1");
		CarInfo[casaid][CarColor2] = dini_Int(casa, "Cor_2");
		CarInfo[casaid][Respawn_Delay] = dini_Int(casa, "Tempo_Respawn");
		CarInfo[casaid][IPVA] = dini_Int(casa, "IPVA");
		CarInfo[casaid][Trancado] = dini_Int(casa, "Trancado");
		CarInfo[casaid][ID] = dini_Int(casa, "ID");
		if(hInfo[casaid][TemDono] == 0)
		{
            CarInfo[casaid][VeiculoCasa] = CreateVehicle(CarInfo[casaid][VeiculoModelo], Carx, Cary, Carz, Anglee, color1, color2, respawn_delay);
	    }
	}
}

public NovoVeiculo()
{
	for(new carid=0;carid<MAX_HOUSES;carid++)
	{
		if(CarInfo[carid][NovoCarro] == 1)
		{
		    CarInfo[carid][NovoCarro] = 0;
		    KillVeiculo(CarInfo[carid][VeiculoCasa]);
	    	CarInfo[carid][VeiculoCasa] = CreateVehicle(CarInfo[carid][VeiculoModelo], CarInfo[carid][PosCarX], CarInfo[carid][PosCarY], CarInfo[carid][PosCarZ], CarInfo[carid][Angulo], CarInfo[carid][CarColor1], CarInfo[carid][CarColor2], CarInfo[carid][Respawn_Delay]);
		}
	}
}

public KillVeiculo(carid)
{
	for (new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerInVehicle(i, carid))
	    {
			RemovePlayerFromVehicle(i);
    		KillVeh[carid] = true;
    		SetVehicleToRespawn(carid);
		}
		else
		{
		    KillVeh[carid] = true;
		    SetVehicleToRespawn(carid);
		}
	}
}
public OnVehicleSpawn(vehicleid)
{
	for(new i=0;i<MAX_HOUSES;i++)
	{
    	if(KillVeh[CarInfo[i][VeiculoCasa]] == true)
    	{
     		KillVeh[CarInfo[i][VeiculoCasa]] = false;
        	DestroyVehicle(CarInfo[i][VeiculoCasa]);
		}
	}
}

stock GetCasaID(playerid)
{
	for(new i=0; i < MAX_HOUSES; i++)
	{
	    if(PlayerToPoint(MAX_DISTANCE_TO_PROP, playerid, hInfo[i][EntradaX], hInfo[i][EntradaY], hInfo[i][EntradaZ]))
	    {
	        return i;
		}
	}
	return -255;
}

forward MapIconStreamer2();
public MapIconStreamer2()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        new Float:SmallestDistance = 300.0;
	        new CP,Float:OldDistance;
	        for(new propid; propid<MAX_HOUSES; propid++)
	        {
	            OldDistance = GetDistanceToPropertyCasa(i,propid);
	            if(OldDistance < SmallestDistance)
	            {
	                SmallestDistance = OldDistance;
	                CP = propid;
				}
			}
			RemovePlayerMapIcon(i, 32);
			if(hInfo[CP][TemDono] == 1)
			{
                SetPlayerMapIcon(i, 32,hInfo[CP][EntradaX],hInfo[CP][EntradaY],hInfo[CP][EntradaZ],32,0);
			}
			else
			{
			    SetPlayerMapIcon(i, 32,hInfo[CP][EntradaX],hInfo[CP][EntradaY],hInfo[CP][EntradaZ],31,0);
			}
		}
	}
}
stock SetPlayerRouting(playerid,Float:x1,Float:y1)
{
	if(IsPlayerInAnyVehicle(playerid) && Gps[ playerid ] == 1)
	{
        new string[ 128 ];
		new textstring[ 200 ];
		new Float:x2,Float:y2,Float:z2;
	    new Float:angle2;

		GetVehiclePos(GetPlayerVehicleID(playerid),x2,y2,z2);
	   	GetVehicleZAngle(GetPlayerVehicleID(playerid),angle2);

	 	new Float:dist;
  		dist = floatsqroot(floatpower(floatabs(floatsub(x1,x2)),2)+floatpower(floatabs(floatsub(y1,y2)),2));

		new Float:angle1;
		if((y1-y2) >= 0.0) angle1 = acos((x1-x2)/dist) - 90;
		else angle1 = 270 - acos((x1-x2)/dist);

		new Float:offset;
		offset = 360.0 - angle2 + angle1;
		if(offset >= 360.0) offset = offset - 360.0;
		else if(offset < 0.0) offset = offset + 360.0;

		if(offset >= 330.0 || offset < 30.0) format(string,sizeof(string),"~u~ Siga reto ~w~%d ~u~",floatround(dist));
		else if(offset >= 30.0 && offset < 60.0) format(string,sizeof(string),"Vire a esquerda ~<~ ~w~%d",floatround(dist));
		else if(offset >= 60.0 && offset < 100.0) format(string,sizeof(string),"Vire a esquerda ~<~~<~ ~w~%d",floatround(dist));
		else if(offset >= 100.0 && offset < 150.0) format(string,sizeof(string),"Vire a esquerda ~d~~<~ ~w~%d",floatround(dist));
		else if(offset >= 150.0 && offset < 210.0) format(string,sizeof(string),"Volte ~d~ ~w~%d ~d~",floatround(dist));
		else if(offset >= 210.0 && offset < 260.0) format(string,sizeof(string),"Vire a direita~w~%d ~>~~d~",floatround(dist));
		else if(offset >= 260.0 && offset < 300.0) format(string,sizeof(string),"Vire a direita~w~%d ~>~~>~",floatround(dist));
		else if(offset >= 300.0 && offset < 330.0) format(string,sizeof(string),"Vire a direita~w~%d ~>~",floatround(dist));
		format(textstring,sizeof(textstring),"~r~    Sistema Global de GPS ~n~~n~~y~Coordenadas: ~w~~n~X %.01f - Y %.01f ~n~~n~ ~y~Distancia & Direcao: ~n~%s",x1,y1,string);
		TextDrawSetString(Textdraw53[ playerid ],textstring);
		if(floatround(dist) <= 25)
		{
			TextDrawHideForPlayer(playerid, Textdraw53[playerid]);
			Gps[ playerid ] = 0;
			SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Você acaba de chegar no lugar localizado");
		}
		TelePosGps[ playerid ][ tX ] = x1;
		TelePosGps[ playerid ][ tY ] = y1;
	}
    return 0x01;
}
forward GpsCheck();
public GpsCheck()
{
    for(new i = 0; i <= MAX_PLAYERS; ++i)
	{
	    if(IsPlayerConnected(i))
	    {
			if(IsPlayerInAnyVehicle(i) && Gps[ i ] == 1)
			{
			   	SetPlayerRouting(i,TelePosGps[ i ][ tX ],TelePosGps[ i ][ tY ]);
			}
		}
	}
    return 0x01;
}
stock sscanf(string[ ],format[ ],{Float,_}:...)
{
    new name[ MAX_PLAYER_NAME ];
	#if defined isnull
		if (isnull(string))
	#else
		if (string[ 0 ] == 0 || (string[ 0 ] == 1 && string[ 1 ] == 0))
	#endif
		{
			return format[ 0 ];
		}
	#pragma tabsize 4
	new
		formatPos = 0 ,
		stringPos = 0 ,
		paramPos = 2 ,
		paramCount = numargs() ,
		delim = ' ';
	while (string[ stringPos ] && string[ stringPos ] <= ' ')
	{
		stringPos++;
	}
	while (paramPos < paramCount && string[ stringPos ])
	{
		switch (format[ formatPos++ ])
		{
			case '\0':
			{
				return 0;
			}
			case 'i','d':
			{
				new
					neg = 1 ,
					num = 0 ,
					ch = string[ stringPos ];
				if (ch == '-')
				{
					neg = -1;
					ch = string[ ++stringPos ];
				}
				do
				{
					stringPos++;
					if ('0' <= ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return -1;
					}
				}
				while ((ch = string[ stringPos ]) > ' ' && ch != delim);
				setarg(paramPos,0,num * neg);
			}
			case 'h','x':
			{
				new
					num = 0 ,
					ch = string[ stringPos ];
				do
				{
					stringPos++;
					switch (ch)
					{
						case 'x','X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						default:
						{
							return -1;
						}
					}
				}
				while ((ch = string[ stringPos ]) > ' ' && ch != delim);
				setarg(paramPos,0,num);
			}
			case 'c':
			{
				setarg(paramPos,0,string[ stringPos++ ]);
			}
			case 'f':
			{
				setarg(paramPos,0,_:floatstr(string[ stringPos ]));
			}
			case 'p':
			{
				delim = format[ formatPos++ ];
				continue;
			}
			case '\'':
			{
				new
					end = formatPos - 1 ,
					ch;
				while ((ch = format[ ++end ]) && ch != '\'') {}
				if (!ch)
				{
					return -1;
				}
				format[ end ] = '\0';
				if ((ch = strfind(string,format[ formatPos ],false,stringPos)) == -1)
				{
					if (format[ end + 1 ])
					{
						return -1;
					}
					return 0;
				}
				format[ end ] = '\'';
				stringPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
			{
				new
					end = stringPos - 1 ,
					id = 0 ,
					bool:num = true ,
					ch;
				while ((ch = string[ ++end ]) && ch != delim)
				{
					if (num)
					{
						if ('0' <= ch <= '9')
						{
							id = (id * 10) + (ch - '0');
						}
						else
						{
							num = false;
						}
					}
				}
				if (num && IsPlayerConnected(id))
				{
					setarg(paramPos,0,id);
				}
				else
				{
					#if !defined foreach
						#define foreach(%1,%2) for (new %2 = 0; %2 <= MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
						#define __SSCANF_FOREACH__
					#endif
					string[ end ] = '\0';
					num = false;
					id = end - stringPos;
					foreach(Player,playerid)
					{
						GetPlayerName(playerid,name,sizeof (name));
						if (!strcmp(name,string[ stringPos ],true,id))
						{
							setarg(paramPos,0,playerid);
							num = true;
							break;
						}
					}
					if (!num)
					{
						setarg(paramPos,0,INVALID_PLAYER_ID);
					}
					string[ end ] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
				}
				stringPos = end;
			}
			case 's','z':
			{
				new
					i = 0 ,
					ch;
				if (format[ formatPos ])
				{
					while ((ch = string[ stringPos++ ]) && ch != delim)
					{
						setarg(paramPos,i++,ch);
					}
					if (!i)
					{
						return -1;
					}
				}
				else
				{
					while ((ch = string[ stringPos++ ]))
					{
						setarg(paramPos,i++,ch);
					}
				}
				stringPos--;
				setarg(paramPos,i,'\0');
			}
			default:
			{
				continue;
			}
		}
		while (string[ stringPos ] && string[ stringPos ] != delim && string[ stringPos ] > ' ')
		{
			stringPos++;
		}
		while (string[ stringPos ] && (string[ stringPos ] == delim || string[ stringPos ] <= ' '))
		{
			stringPos++;
		}
		paramPos++;
	}
	do
	{
		if ((delim = format[ formatPos++ ]) > ' ')
		{
			if (delim == '\'')
			{
				while ((delim = format[ formatPos++ ]) && delim != '\'') {}
			}
			else if (delim != 'z')
			{
				return delim;
			}
		}
	}
	while (delim > ' ');
	return 0;
}
dcmd_gpspos(playerid,params[ ])
{
	new Float:x,Float:y;new string[ 100 ];
	if(PlayerUlt[playerid][pGPS] == 1)
 	{
		if (sscanf(params,"ff",x,y))
		{
			SendClientMessage(playerid,0xBBBBBBAA,"Use: /gpspos <X> <Y> || /gpsmenu | Em dialogs");
			SendClientMessage(playerid,0xBBBBBBAA,"Use: /gpspos 0 0 para desligar.");
			return 1;
		}
		else
		{
		    if((x == 0 && y == 0) && Gps[ playerid ] == 1)
			{
			    Gps[ playerid ] = 0;
			    SendClientMessage(playerid,0xFFFFFFFF,"{F9c68A}| INFO | Você desligou o GPS");
			    TextDrawHideForPlayer(playerid,Textdraw53[ playerid ]);
			}
		    else
		    {
		        if(IsPlayerInAnyVehicle(playerid))
		        {
			        Gps[ playerid ] = 1;
			        SetPlayerRouting(playerid,x,y);
				    format(string,sizeof(string),"{F9c68A}| INFO | Você colocou o gps na posisão %f,%f",x,y);
				    SendClientMessage(playerid,0xFFFFFFFF,string);
				    TextDrawShowForPlayer(playerid,Textdraw53[ playerid ]);
				}
				else
				{
				    SendClientMessage(playerid,-1,"{FF0000}| ERRO | Você não esta em um veiculo");
				    return 1;
				}
			}
	 	}
	}
	else
	{
	    SendClientMessage(playerid,-1,"{FF0000}| ERRO | Você não tem um GPS compre em um mercadinho");
	    return 1;
	}
    return 1;
}
stock Settimers()
{
    SetTimer("Sendmsg", 300000, true);
	SetTimer("VisibilityUpdate", 3000, 1);
	SetTimer("RelogioUPs", 1000, 1);
	SetTimer("Horarios", 1000, 1);
	SetTimer("SpeedoUpdate", 1000, 1);
	SetTimer("Taxi", 8000, 1);
	SetTimer("AntiAfk", 1000, 1);
    SetTimer("MapIconStreamer",500,1);
    SetTimer("MapIconStreamer2",500,1);
}
stock CarregarInts()
{
    for(new i=1; i<MAX_VEHICLES; i++)
	{
        SetVehicleNumberPlate(i,"{FF0000}[iG]");
        SetVehicleToRespawn(i);
    }

    Create3DTextLabel("Agencia de empregos",-1,1210.7449,-1749.1862,13.5939,30.0,0);
    Create3DTextLabel("Agencia de empregos",-1,2474.5315,1023.1827,10.8203,30.0,0);
    Create3DTextLabel("Agencia de empregos",-1,914.0947,-1002.4798,38.0225,30.0,0);
    Create3DTextLabel("Agencia de empregos",-1,-88.8682,1210.0992,19.7422,30.0,0);

    Marcadorias_Creck = CPS_AddCheckpoint(-2185.5188,2416.8181,5.1869,1.0,100);
    Agencias[0] = CPS_AddCheckpoint(1210.7449,-1749.1862,13.5939,1.0,100); // /agencia ls
    Agencias[1] = CPS_AddCheckpoint(2474.5315,1023.1827,10.8203,1.0,100); // /agencia lv
    Agencias[2] = CPS_AddCheckpoint(-1749.3247,902.1302,25.0859,1.0,100); // /agencia sf
    Agencias[3] = CPS_AddCheckpoint(-88.8682,1210.0992,19.7422,1.0,100); // /agencia fc

    Academia = CPS_AddCheckpoint(657.1364,-1869.0104,5.4609,1.0,100); // /academia
    BocaDeFumo[0] = CPS_AddCheckpoint(2465.0020,-1714.5026,13.5003,1.0,100); // /boca de fumo groov
    BocaDeFumo[1] = CPS_AddCheckpoint(2227.3303,-1260.7715,23.9146,1.0,100); // /boca de ballas
    BocaDeFumo[2] = CPS_AddCheckpoint(2274.3569,-1081.7512,51.7734,1.0,100); // /boca de fumo favela
    BocaDeFumo[3] = CPS_AddCheckpoint(-2153.9883,-2350.0881,30.6735,1.0,100); // /boca de fumo angel
    BocaDeFumo[4] = CPS_AddCheckpoint(-1830.6721,660.6439,30.4313,1.0,100); // /boca de fumo sf
    BocaDeFumo[5] = CPS_AddCheckpoint(2474.8918,1123.9121,10.8203,1.0,100); // /boca de fumo lv
    dpsoltar = CPS_AddCheckpoint(249.5317,69.2701,1003.6406, 1.0, 30);

    for(new empid=1; empid<MAX_EMPRESAS; empid++)
	{
    	UpdateEmp(empid);
        if(EmpInfo[empid][TemDono] == 0)
	    {
            DestroyDynamicPickup(EmpresaPickup[ empid ]);
            EmpresaPickup[ empid ] = CreateDynamicPickup(1578,1,EmpInfo[empid][Entradax],EmpInfo[empid][Entraday],EmpInfo[empid][Entradaz]);
        }
    	else
	    {
            DestroyDynamicPickup(EmpresaPickup[ empid ]);
            EmpresaPickup[ empid ] = CreateDynamicPickup(1580,1,EmpInfo[empid][Entradax],EmpInfo[empid][Entraday],EmpInfo[empid][Entradaz]);
	    }
	}

	AddStaticPickup(1274, 1, 2308.7542,-13.2503,26.7422);

    Create3DTextLabel("Caixa Eletronico", -1, 2308.7542,-13.2503,26.7422, 15, 0);
    Create3DTextLabel("\n\nAperte 'F'", -1, 2308.7542,-13.2503,26.7422, 15, 0);
	FaculdadeAberta = false;
}
stock CarregarEmpresas()
{
    AddEmpresa(1,2330.5688,2532.3857,10.8203,372.5565,-131.3607,1001.4922,170000,60000,5,0,510); // //pizzaria lv
    AddEmpresa(2,2247.7795,2397.4233,10.8203,-26.8339,-55.5846,1003.5469,250000,80000,6,0,670); // //mercadinho lv
    AddEmpresa(3,2506.9846,2121.1387,10.8400,1204.6689,-13.5429,1000.9219,350000,120000,2,0,700); // //laped lv
    AddEmpresa(4,2538.8635,2083.8901,10.8203,286.1490,-84.5633,1001.5156,269000,70000,2,0,480); // /ammu lv 2
    AddEmpresa(5,2546.3665,1972.0591,10.8203,6.0856,-28.8966,1003.5494,250000,80000,10,0,532); // mercadinho lv
    AddEmpresa(6,2452.4326,2064.2207,10.8203,-26.8339,-55.5846,1003.5469,250000,80000,10,0,736); // mercadinho lv
    AddEmpresa(7,2441.2324,2064.3979,10.8203,501.9578,-70.5648,998.7578,140000,50000,6,0,150); // /bar lv
    AddEmpresa(8,2471.9006,2034.0121,11.0625,366.0248,-73.3478,1001.5078,160000,60000,11,0,936); // /burguer lv
    AddEmpresa(9,2392.9126,2043.1230,10.8203,2393.0122,2043.3147,10.8203,160000,60000,10,0,456); // /burguer lv
    AddEmpresa(10,2638.0378,1849.7019,11.0234,372.5565,-131.3607,1001.4922,160000,60000,9,0,960); // // pizzaria lv
    AddEmpresa(11,2637.7566,1671.4438,11.0234,366.0002,-9.4338,1001.8516,160000,60000,5,0,101); // /burguer lv
    AddEmpresa(12,2194.5112,1990.8713,12.2969,-26.8339,-55.5846,1003.5469,250000,80000,9,0,700); // /mercadinho lv
    AddEmpresa(13,2094.5767,2122.2173,10.8203,-201.2236,-43.2465,1002.2734,150000,60000,6,0,400); // tatto lv
    AddEmpresa(14,2080.3831,2121.7244,10.8125,418.4666,-80.4595,1001.8047,150000,60000,3,0,800); // gays lv
    AddEmpresa(15,2083.2090,2223.7258,11.0234,372.5565,-131.3607,1001.4922,250000,60000,5,0,135); // /pizzaria lv
    AddEmpresa(16,2090.5706,2224.3250,11.0234,161.4048,-94.2416,1001.8047,450000,60000,18,0,670); // /zip lv
    AddEmpresa(17,2097.9600,2223.8076,11.0234,-26.8339,-55.5846,1003.5469,250000,80000,6,0,480); // mercadinho lv
    AddEmpresa(18,2102.7744,2228.6799,11.0234,366.0002,-9.4338,1001.8516,160000,60000,9,0,640); // /burguer lv
    AddEmpresa(19,2102.4763,2257.5403,11.0234,207.5219,-109.7448,1005.1328,450000,60000,15,0,925); // binco lv
    AddEmpresa(20,1937.2355,2307.1228,10.8203,-25.8096,-187.0804,1003.5469,250000,80000,17,0,1000); // mercadinho lv
    AddEmpresa(21,1872.9092,2071.8076,11.0625,363.8544,-74.1033,1001.5078,160000,60000,10,0,746); // /burguer lv
    AddEmpresa(22,1656.5192,1733.2720,10.8281,207.5219,-109.7448,1005.1328,450000,60000,15,0,630); // binco lv qualquer binco
    AddEmpresa(23,2085.5659,2074.0461,11.0547,-100.4998,-23.4285,1000.7188,160000,60000,3,0,456); // sex shop lv
    AddEmpresa(24,2020.2926,1007.7021,10.8203,2016.1156,1017.1541,996.8750,1060000,360000,10,0,1776); // four dragons lv
    AddEmpresa(25,2158.9602,942.9059,10.8203,286.1490,-84.5633,1001.5156,146000,46000,4,0,46); // ammu lv
    AddEmpresa(26,2885.2007,2453.6736,11.0690,-27.8440,-26.6737,1003.5573,250000,80000,4,0,444); // mercadinho lv
    AddEmpresa(27,2846.2434,2415.1316,11.0690,364.7589,-10.1625,1001.8516,250000,80000,9,0,456); // burguer lv
    AddEmpresa(28,2825.9021,2407.1685,11.0625,206.9123,-139.2604,1003.5078,450000,80000,3,0,671); // hard skins lv
    AddEmpresa(29,2802.6982,2430.3247,11.0625,226.1667,-8.0267,1002.2109,450000,80000,5,0,320); // victim lv
    AddEmpresa(30,2779.1616,2453.3660,11.0625,203.7841,-49.1135,1001.8047,450000,80000,1,0,230); // urban skins lv
    AddEmpresa(31,2756.4304,2476.5505,11.0625,372.5565,-131.3607,1001.4922,160000,60000,5,0,304); // pizza lv
    AddEmpresa(32,1154.2976,-1436.3075,15.7969,161.4048,-94.2416,1001.8047,560000,360000,18,0,1146); // /zip emp
    AddEmpresa(33,1157.5060,-1474.0527,15.8003,161.4048,-94.2416,1001.8047,560000,360000,18,0,1146); // /zip emp
    AddEmpresa(34,1152.4220,-1513.1171,15.7969,161.4048,-94.2416,1001.8047,560000,360000,18,0,1146); // /zip emp
    AddEmpresa(35,1103.3588,-1511.6057,15.7969,-100.2674,-22.9376,1000.7188,360000,160000,3,0,465); // /sexshop
    AddEmpresa(36,1099.0818,-1473.7172,15.7969,-100.2674,-22.9376,1000.7188,360000,160000,3,0,465); // /sexshop
    AddEmpresa(37,1161.5176,-1428.2543,22.7808,161.4048,-94.2416,1001.8047,560000,360000,18,0,1146); // /zip
    AddEmpresa(38,1161.5751,-1442.8003,22.7846,366.0002,-9.4338,1001.8516,456000,260000,5,0,101); // /lanchonete
    AddEmpresa(39,1165.2974,-1470.0333,22.7740,366.0002,-9.4338,1001.8516,456000,260000,5,0,101); // /lanchonete
    AddEmpresa(40,1161.9402,-1516.2778,22.7461,207.1212,-138.9537,1003.5078,656000,360000,3,0,1476); // /hard skin
    AddEmpresa(41,1113.6234,-1532.7817,22.7568,207.0212,-139.3674,1003.5078,656000,360000,3,0,1476); // /loja de skin
    AddEmpresa(42,1087.7002,-1501.3298,22.7512,-26.8339,-55.5846,1003.5469,250000,80000,9,0,700); // /loja de ultilitarios
    AddEmpresa(43,1095.2303,-1443.6019,22.7582,-26.8339,-55.5846,1003.5469,250000,80000,10,0,736); // /loja de ultilitarios
    AddEmpresa(44,927.3385,-1352.8605,13.3767,364.9409,-10.2125,1001.8516,456000,260000,5,0,101); // /lanchonete
    AddEmpresa(45,953.6769,-1336.6019,13.5391,-100.2674,-22.9376,1000.7188,360000,160000,3,0,465); // /sexsho´
    AddEmpresa(46,1038.0449,-1339.4619,13.7266,377.1941,-192.3123,1000.6328,76000,30000,17,0,145); // lanchonete
    AddEmpresa(47,1071.4395,-1221.2772,16.8906,207.1212,-138.9537,1003.5078,656000,360000,3,0,1476); // /skin hard
    AddEmpresa(48,1199.4521,-919.0333,43.1152,364.0796,-74.2606,1001.5078,780000,30666,10,0,156); // /restaurante
    AddEmpresa(49,1315.3734,-898.6756,39.5781,-27.5060,-56.9301,1003.5469,250000,80000,10,0,736); // /loja ulti
    AddEmpresa(50,499.8448,-1359.3340,16.2630,207.0467,-139.3870,1003.5078,6788880,3600000,3,0,1776); // /prolaps
    AddEmpresa(51,453.2271,-1478.2440,30.8121,204.3336,-167.0224,1000.5234,6788880,3600000,14,0,1776); // /loja skin ds
    AddEmpresa(52,460.9466,-1500.9530,31.0582,225.0306,-9.1838,1002.2180,450000,80000,5,0,320); // victim
    AddEmpresa(53,479.9038,-1536.2733,19.5382,207.0467,-139.3870,1003.5078,6788880,3600000,3,0,1776); // prolaps
    AddEmpresa(54,1368.3207,-1279.7192,13.5469,285.4542,-40.2899,1001.5156,9788880,4600000,1,0,3776); // /ammu ls
    AddEmpresa(55,1835.8776,-1682.3151,13.3714,493.1443,-24.2607,1000.6797,9788880,4600000,17,0,3776); // /alhambra
    AddEmpresa(56,1975.9409,-2036.6766,13.5469,-201.3323,-23.3410,1002.2734,46566,16000,16,0,666); // /tatto
    AddEmpresa(57,1941.0419,-2115.8931,13.6953,-100.2674,-22.9376,1000.7188,360000,160000,3,0,465); // /sex shop
    AddEmpresa(58,2104.8223,-1806.6566,13.5547,372.2838,-132.4285,1001.4922,156000,60000,5,0,450); // /pizzaria
    AddEmpresa(59,2069.3838,-1779.9840,13.5592,-201.3323,-23.3410,1002.2734,46566,16000,16,0,666); // tatto
    AddEmpresa(60,2397.9414,-1898.1337,13.5469,366.0002,-9.4338,1001.8516,456000,260000,9,0,401); // lonchonete
    AddEmpresa(61,2400.4541,-1981.4188,13.5469,297.1440,-109.8702,1001.5156,9788880,4600000,6,0,3776); // /ammu ls
    AddEmpresa(62,2354.1331,-1512.1857,24.0000,-228.0642,1401.2402,27.7656,25000,12000,18,0,106); // bar ls
    AddEmpresa(63,2421.6204,-1509.1631,23.9922,366.0002,-9.4338,1001.8516,160000,60000,5,0,101); // lanchonete
    AddEmpresa(64,2421.5024,-1219.2456,25.5616,1204.6534,-13.5429,1000.9219,140000,60000,2,0,1450); // /puteiro
    AddEmpresa(65,1458.9150,-1012.2986,26.8438,2305.7942,-16.0904,26.7496,57700000,35500000,0,70,15477); // banco
    AddEmpresa(66,-2336.3320,-166.7674,35.554,366.0248,-73.3478,1001.5078,14656,60000,10,0,1455); // /lanchonete
    AddEmpresa(67,-2551.3562,193.6363,6.2092,493.1443,-24.2607,1000.6797,145660,45560,17,0,455); // almabra sf
    AddEmpresa(68,-2242.3022,128.3930,35.3203,-2240.1028,136.9730,1035.4141,14556,8000,6,0,95); // zero sf
    AddEmpresa(69,-1911.9583,828.4583,35.1778,366.0248,-73.3478,1001.5078,160000,60000,11,0,936); // lanchonete
    AddEmpresa(70,-1882.8904,865.6584,35.1728,161.4048,-94.2416,1001.8047,450000,60000,18,0,670); // zip
    AddEmpresa(71,-1808.1355,945.2289,24.8906,372.5565,-131.3607,1001.4922,170000,60000,5,0,510); // pizzaria
    AddEmpresa(72,-1694.2394,951.0083,24.8906,226.5139,-8.1751,1002.2109,1045666,566000,5,7,1003); // victim
    AddEmpresa(73,1668.5679,-1409.0950,13.5497,2305.7942,-16.0904,26.7496,57700000,35500000,0,70,15477); // emp banco
    AddEmpresa(74,1366.9000,248.5201,19.5669,372.2838,-132.4285,1001.4922,156000,60000,5,0,450); // pizzaria emp
    AddEmpresa(75,681.5667,-473.8066,16.5363,-228.0642,1401.2402,27.7656,25000,12000,18,0,106); // bar ls // bar emp
    AddEmpresa(76,-78.5773,-1169.7644,2.1414,364.0796,-74.2606,1001.5078,780000,30666,10,0,156); // posto de gasosa
    AddEmpresa(77,326.8486,-1515.3450,36.0325,2305.7942,-16.0904,26.7496,57700000,35500000,0,70,15477); // emp banco
    AddEmpresa(78,1699.3138,-1667.9319,20.1977,2305.7942,-16.0904,26.7496,57700000,35500000,0,70,15477); // banco
    AddEmpresa(79,1833.3752,-1842.6705,13.5781,-26.8339,-55.5846,1003.5469,250000,80000,6,0,670); // marcadinho
    AddEmpresa(80,2309.7905,-1643.5237,14.8270,501.9578,-70.5648,998.7578,140000,50000,6,0,150); // emp bar
    AddEmpresa(81,2637.4075,1129.0375,11.1797,364.0796,-74.2606,1001.5078,780000,30666,10,0,156); // emp posto
    AddEmpresa(82,2226.2517,1837.1191,10.8203,2016.1156,1017.1541,996.8750,1060000,360000,10,0,1776); // cassino
    AddEmpresa(83,2167.3000,2114.5437,10.8203,1204.6534,-13.5429,1000.9219,140000,60000,2,0,1450); // strip emp
    AddEmpresa(84,2165.5044,2164.1343,10.8203,2016.1156,1017.1541,996.8750,1060000,360000,10,0,1776); // cassino
    AddEmpresa(85,2313.8613,2120.7156,10.8281,2016.1156,1017.1541,996.8750,1060000,360000,10,0,1776); // cassino emp
    AddEmpresa(86,2516.1252,2297.4841,10.8203,-100.2674,-22.9376,1000.7188,360000,160000,3,0,465); // emp sex shop
    AddEmpresa(87,2127.4912,2378.6338,10.8203,2305.7942,-16.0904,26.7496,57700000,35500000,0,70,15477); // banco emp
    AddEmpresa(88,2169.7415,2795.9229,10.8203,364.0796,-74.2606,1001.5078,780000,30666,10,0,156); // burguer shot
    AddEmpresa(89,-1272.2372,2712.7893,50.2663,364.0796,-74.2606,1001.5078,780000,30666,10,0,156); // posto de gas
    AddEmpresa(90,-1508.7742,2609.2754,55.8359,297.1440,-109.8702,1001.5156,9788880,4600000,6,0,3776); // ammu emp
    AddEmpresa(91,-1213.3101,1830.9211,41.9297,372.5565,-131.3607,1001.4922,160000,60000,5,0,304); // pizza emp
    AddEmpresa(92,-1465.7225,1872.9993,32.6328,364.0796,-74.2606,1001.5078,780000,30666,10,0,156); // posto
    AddEmpresa(93,-315.4438,829.9329,14.2422,297.1440,-109.8702,1001.5156,9788880,4600000,6,0,3776); // ammu emp
    AddEmpresa(94,811.0093,-1616.1953,13.5469,364.0796,-74.2606,1001.5078,780000,30666,10,0,156); // burguer emp
}
stock CarregarTextsDraws()
{
    TextHoras = TextDrawCreate(547.000000,23.000000,"Hora~n~00:00");
	TextDrawFont(TextHoras,3);
	TextDrawLetterSize(TextHoras,0.599999,1.899999);
	TextDrawColor(TextHoras,-1);
	TextDrawSetOutline(TextHoras,1);
	TextDrawSetProportional(TextHoras,1);
	TextDrawTextSize(TextHoras,611.000000,33.000000);

	TextInfos = TextDrawCreate(220.000000, 339.000000, "~y~# ~g~Area de drogas ~p~[ INFO ] Use: /PegarDrogas~y~ #");
    TextDrawBackgroundColor(TextInfos, 255);
    TextDrawFont(TextInfos, 1);
    TextDrawLetterSize(TextInfos, 0.400000, 3.099998);
    TextDrawColor(TextInfos, -1);
    TextDrawSetOutline(TextInfos, 1);
    TextDrawSetProportional(TextInfos, 1);

	ReloginhoUP = TextDrawCreate(518.000000, 4.000000, "~y~UP~p~: ~w~10~p~:~w~00");
	TextDrawBackgroundColor(ReloginhoUP, 255);
	TextDrawFont(ReloginhoUP, 1);
	TextDrawLetterSize(ReloginhoUP, 0.460000, 1.799999);
	TextDrawColor(ReloginhoUP, -1);
	TextDrawSetOutline(ReloginhoUP, 1);
	TextDrawSetProportional(ReloginhoUP, 1);

	ConnectMensagem = TextDrawCreate(137.000000,279.000000,"   ~y~B~p~R~w~A~b~S~r~I~g~L ~p~i~r~G~w~A~g~M~w~M~p~I~y~N~r~G");
    TextDrawAlignment(ConnectMensagem,0);
    TextDrawBackgroundColor(ConnectMensagem,0x000000ff);
    TextDrawFont(ConnectMensagem,3);
    TextDrawLetterSize(ConnectMensagem,1.000000,6.099996);
    TextDrawColor(ConnectMensagem,-1);
    TextDrawSetOutline(ConnectMensagem,1);
    TextDrawSetProportional(ConnectMensagem,1);
    TextDrawSetShadow(ConnectMensagem,1);
    for(new i=0; i<MAX_PLAYERS; i++)
    {
    faixa[i] = TextDrawCreate(0,0,"~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~  ");
	TextDrawFont(faixa[i],1);
	TextDrawColor(faixa[i],0xFFFFFFAA);
	TextDrawLetterSize(faixa[i],0.299999,1.000000);
	TextDrawSetOutline(faixa[i],0);
	TextDrawSetShadow(faixa[i],0);
	TextDrawSetProportional(faixa[i],1);
	TextDrawBackgroundColor(faixa[i],0x000000ff);
	TextDrawBoxColor(faixa[i], 0x000000FF);
	TextDrawUseBox(faixa[i], true); //Fundo
	TextDrawBoxColor(faixa[i], 0x000000AA); //Cor do fundo
	TextDrawTextSize(faixa[i],900,900);
	TextDrawBoxColor(faixa[i],0x000000FF);

	faixa1[i] = TextDrawCreate(0,0,"~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ");
	TextDrawFont(faixa1[i],1);
	TextDrawColor(faixa1[i],0xFFFFFFAA);
	TextDrawLetterSize(faixa1[i],0.299999,1.000000);
	TextDrawSetOutline(faixa1[i],0);
	TextDrawSetShadow(faixa1[i],0);
	TextDrawSetProportional(faixa1[i],1);
	TextDrawBackgroundColor(faixa1[i],0x000000ff);
	TextDrawBoxColor(faixa1[i], 0x000000FF);
	TextDrawUseBox(faixa1[i], true); //Fundo
	TextDrawBoxColor(faixa1[i], 0x000000AA); //Cor do fundo
	TextDrawTextSize(faixa1[i],900,900);
	TextDrawBoxColor(faixa1[i],0x000000FF);

	faixa2[i] = TextDrawCreate(0,347,"~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ");
	TextDrawFont(faixa2[i],1);
	TextDrawColor(faixa2[i],0xFFFFFFAA);
	TextDrawLetterSize(faixa2[i],0.299999,1.000000);
	TextDrawSetOutline(faixa2[i],0);
	TextDrawSetShadow(faixa2[i],0);
	TextDrawSetProportional(faixa2[i],1);
	TextDrawBackgroundColor(faixa2[i],0x000000ff);
	TextDrawBoxColor(faixa2[i], 0x000000FF);
	TextDrawUseBox(faixa2[i], true); //Fundo
	TextDrawBoxColor(faixa2[i], 0x000000AA); //Cor do fundo
	TextDrawTextSize(faixa2[i],900,900);
	TextDrawBoxColor(faixa2[i],0x000000FF);

    dm[i] = TextDrawCreate(370,430,"~g~PARK GLEN - ~w~DM LIBERADO!");
    TextDrawFont(dm[i],1);
    TextDrawColor(dm[i],0xFFFFFFAA);
    TextDrawLetterSize(dm[i],0.499999,0.899999);
    TextDrawSetOutline(dm[i],1);
    TextDrawSetShadow(dm[i],0);
    TextDrawSetProportional(dm[i],1);
    TextDrawBackgroundColor(dm[i],0x000000ff);

     //-
	afk1[i] = TextDrawCreate(60,150.000000,"Voce esta ~r~AUSENTE");
	TextDrawFont(afk1[i],3);
	TextDrawColor(afk1[i],0xFFFFFFAA);
	TextDrawLetterSize(afk1[i],1.533999,2.722000);
	TextDrawSetOutline(afk1[i],1);
	TextDrawSetShadow(afk1[i],0);
	TextDrawSetProportional(afk1[i],1);
	TextDrawBackgroundColor(afk1[i],0x000000ff);
	//-
	afk2[i] = TextDrawCreate(200,300.000000,"Para voltar digite: ~g~/online");
	TextDrawFont(afk2[i],2);
	TextDrawColor(afk2[i],0xFFFFFFAA);
	TextDrawLetterSize(afk2[i],0.433999,0.822000);
	TextDrawSetOutline(afk2[i],1);
	TextDrawSetShadow(afk2[i],0);
	TextDrawSetProportional(afk2[i],1);
	TextDrawBackgroundColor(afk2[i],0x000000ff);

    box[i] = TextDrawCreate(198.000000,396.000000,"_");
    TextDrawUseBox(box[i],1);
    TextDrawBoxColor(box[i],0x00000066);
    TextDrawTextSize(box[i],430.000000,0.000000);
    TextDrawAlignment(box[i],0);
    TextDrawBackgroundColor(box[i],0x00000033);
    TextDrawFont(box[i],3);
    TextDrawLetterSize(box[i],1.000000,3.000000);
    TextDrawColor(box[i],-1);
    TextDrawSetOutline(box[i],1);
    TextDrawSetProportional(box[i],1);
    TextDrawSetShadow(box[i],1);

    moldura0[i] = TextDrawCreate(441.000000, 383.000000, "__~n~__~n~__~n~__~n~");
    TextDrawBackgroundColor(moldura0[i], 255);
    TextDrawFont(moldura0[i], 1);
    TextDrawLetterSize(moldura0[i], 0.500000, 1.000000);
    TextDrawColor(moldura0[i], -1);
    TextDrawSetOutline(moldura0[i], 0);
    TextDrawSetProportional(moldura0[i], 1);
    TextDrawSetShadow(moldura0[i], 1);
    TextDrawUseBox(moldura0[i], 1);
    TextDrawBoxColor(moldura0[i], -741092574);
    TextDrawTextSize(moldura0[i], 195.000000, 0.000000);

    moldura1[i] = TextDrawCreate(441.000000, 380.000000, "_");
    TextDrawBackgroundColor(moldura1[i], 255);
    TextDrawFont(moldura1[i], 1);
    TextDrawLetterSize(moldura1[i], 0.500000, -0.200000);
    TextDrawColor(moldura1[i], -1);
    TextDrawSetOutline(moldura1[i], 0);
    TextDrawSetProportional(moldura1[i], 1);
    TextDrawSetShadow(moldura1[i], 1);
    TextDrawUseBox(moldura1[i], 1);
    TextDrawBoxColor(moldura1[i], 255);
    TextDrawTextSize(moldura1[i], 195.000000, 0.000000);

    moldura2[i] = TextDrawCreate(441.000000, 424.000000, "_");
    TextDrawBackgroundColor(moldura2[i], 255);
    TextDrawFont(moldura2[i], 1);
    TextDrawLetterSize(moldura2[i], 0.500000, -0.200000);
    TextDrawColor(moldura2[i], -1);
    TextDrawSetOutline(moldura2[i], 0);
    TextDrawSetProportional(moldura2[i], 1);
    TextDrawSetShadow(moldura2[i], 1);
    TextDrawUseBox(moldura2[i], 1);
    TextDrawBoxColor(moldura2[i], 255);
    TextDrawTextSize(moldura2[i], 195.000000, 0.000000);

    moldura3[i] = TextDrawCreate(200.000000, 380.000000, "_~n~_~n~_~n~_~n~_");
    TextDrawBackgroundColor(moldura3[i], 255);
    TextDrawFont(moldura3[i], 1);
    TextDrawLetterSize(moldura3[i], 0.500000, 0.939999);
    TextDrawColor(moldura3[i], -1);
    TextDrawSetOutline(moldura3[i], 0);
    TextDrawSetProportional(moldura3[i], 1);
    TextDrawSetShadow(moldura3[i], 1);
    TextDrawUseBox(moldura3[i], 1);
    TextDrawBoxColor(moldura3[i], 255);
    TextDrawTextSize(moldura3[i], 193.000000, 0.000000);

    moldura4[i] = TextDrawCreate(441.000000, 380.000000, "_~n~_~n~_~n~_~n~_");
    TextDrawBackgroundColor(moldura4[i], 255);
    TextDrawFont(moldura4[i], 1);
    TextDrawLetterSize(moldura4[i], 0.500000, 0.939999);
    TextDrawColor(moldura4[i], -1);
    TextDrawSetOutline(moldura4[i], 0);
    TextDrawSetProportional(moldura4[i], 1);
    TextDrawSetShadow(moldura4[i], 1);
    TextDrawUseBox(moldura4[i], 1);
    TextDrawBoxColor(moldura4[i], 255);
    TextDrawTextSize(moldura4[i], 438.000000, 0.000000);

    moldura5[i] = TextDrawCreate(441.000000, 397.000000, "_");
    TextDrawBackgroundColor(moldura5[i], 255);
    TextDrawFont(moldura5[i], 1);
    TextDrawLetterSize(moldura5[i], 0.500000, -0.300000);
    TextDrawColor(moldura5[i], -1);
    TextDrawSetOutline(moldura5[i], 0);
    TextDrawSetProportional(moldura5[i], 1);
    TextDrawSetShadow(moldura5[i], 1);
    TextDrawUseBox(moldura5[i], 1);
    TextDrawBoxColor(moldura5[i], 255);
    TextDrawTextSize(moldura5[i], 195.000000, 0.000000);

    moldura6[i] = TextDrawCreate(315.000000, 398.000000, "_~n~_~n~_~n~_");
    TextDrawBackgroundColor(moldura6[i], 255);
    TextDrawFont(moldura6[i], 1);
    TextDrawLetterSize(moldura6[i], 0.500000, 0.639999);
    TextDrawColor(moldura6[i], -1);
    TextDrawSetOutline(moldura6[i], 0);
    TextDrawSetProportional(moldura6[i], 1);
    TextDrawSetShadow(moldura6[i], 1);
    TextDrawUseBox(moldura6[i], 1);
    TextDrawBoxColor(moldura6[i], 255);
    TextDrawTextSize(moldura6[i], 311.000000, 0.000000);

    fahrzeug[i] = TextDrawCreate(198.000000,396.000000," ");
    TextDrawAlignment(fahrzeug[i],0);
    TextDrawBackgroundColor(fahrzeug[i],0x000000ff);
    TextDrawFont(fahrzeug[i],1);
    TextDrawLetterSize(fahrzeug[i],0.299999,1.000000);
    TextDrawColor(fahrzeug[i],-1);
    TextDrawSetOutline(fahrzeug[i],1);
    TextDrawSetProportional(fahrzeug[i],1);
    TextDrawSetShadow(fahrzeug[i],1);

    km[i] = TextDrawCreate(345.000000,396.000000," ");
    TextDrawAlignment(km[i],0);
    TextDrawBackgroundColor(km[i],0x000000ff);
    TextDrawFont(km[i],1);
    TextDrawLetterSize(km[i],0.299999,1.000000);
    TextDrawColor(km[i],-1);
    TextDrawSetOutline(km[i],1);
    TextDrawSetProportional(km[i],1);
    TextDrawSetShadow(km[i],1);

    hoehe[i] = TextDrawCreate(199.000000,408.000000," ");
    TextDrawAlignment(hoehe[i],0);
    TextDrawBackgroundColor(hoehe[i],0x000000ff);
    TextDrawFont(hoehe[i],1);
    TextDrawLetterSize(hoehe[i],0.299999,1.000000);
    TextDrawColor(hoehe[i],-1);
    TextDrawSetOutline(hoehe[i],1);
    TextDrawSetProportional(hoehe[i],1);
    TextDrawSetShadow(hoehe[i],1);

    zustand[i] = TextDrawCreate(345.000000,408.000000," ");
    TextDrawAlignment(zustand[i],0);
    TextDrawBackgroundColor(zustand[i],0x000000ff);
    TextDrawFont(zustand[i],1);
    TextDrawLetterSize(zustand[i],0.299999,1.000000);
    TextDrawColor(zustand[i],-1);
    TextDrawSetOutline(zustand[i],1);
    TextDrawSetProportional(zustand[i],1);
    TextDrawSetShadow(zustand[i],1);

    //-
    fome[i] = TextDrawCreate(230,400, " ");
    TextDrawFont(fome[i],1);
    TextDrawColor(fome[i],0xFFFFFFAA);
    TextDrawLetterSize(fome[i],0.599999,1.400000);
    TextDrawSetOutline(fome[i],1);
    TextDrawSetShadow(fome[i],0);
    TextDrawSetProportional(fome[i],1);
    TextDrawBackgroundColor(fome[i],0x000000ff);
    TextDrawShowForPlayer(i, fome[i]);

    pvelo[i] = TextDrawCreate(227.000000, 383.000000, "~l~.:: ~p~B~g~r~y~a~r~s~b~i~y~l ~y~I~p~G~r~a~b~m~r~m~g~i~y~n~b~g ~l~::.");
    TextDrawBackgroundColor(pvelo[i], 255);
    TextDrawFont(pvelo[i], 3);
    TextDrawLetterSize(pvelo[i], 0.500000, 1.000000);
    TextDrawColor(pvelo[i], -1);
    TextDrawSetOutline(pvelo[i], 1);
    TextDrawSetProportional(pvelo[i], 1);
    //-
	}
}
stock CarregarMenus()
{
    Utilitarios = CreateMenu("~g~Utilitarios", 1, 200.0, 180.0, 200.0, 200.0);
	AddMenuItem(Utilitarios, 0, "GPS~p~ [1200]");
	AddMenuItem(Utilitarios, 0, "RELOGIO~p~ [50]");
	AddMenuItem(Utilitarios, 0, "VELOCIMETRO~p~ [500]");
	AddMenuItem(Utilitarios, 0, "Reloginho UP~p~ [1500]");
	AddMenuItem(Utilitarios, 0, "Agenda~p~ [7]");
	AddMenuItem(Utilitarios, 0, "Camisinha~p~ [2]");
	AddMenuItem(Utilitarios, 0, "Cartao de Creditos~p~ [600]");
	AddMenuItem(Utilitarios, 0, "Celular~p~ [500]");
	AddMenuItem(Utilitarios, 0, "Cartao Tel~p~ [10]");
	AddMenuItem(Utilitarios, 0, "Chip OI~p~ [10]");
	AddMenuItem(Utilitarios, 0, "Chip Tim~p~ [10]");
	AddMenuItem(Utilitarios, 0, "Chip Claro~p~ [10]");
	AddMenuItem(Utilitarios, 0, "Chip Vivo~p~ [10]");
	AddMenuItem(Utilitarios, 0, "Nootbook~p~ [3000]");

	Exercito = CreateMenu("Exercitos 1", 1, 200.0, 180.0, 200.0, 200.0);
	AddMenuItem(Exercito, 0, "Forca Aerea~p~ [190]");
	AddMenuItem(Exercito, 0, "Forca Terrestre~p~ [190]");
	AddMenuItem(Exercito, 0, "Forca Naval~p~ [190]");

	Profissoes = CreateMenu("Profissoes", 1, 200.0, 180.0, 200.0, 200.0);
	AddMenuItem(Profissoes, 0, "Honestas1");
	AddMenuItem(Profissoes, 0, "Honestas2");
	AddMenuItem(Profissoes, 0, "Honestas3");
	AddMenuItem(Profissoes, 0, "Policiais");
	AddMenuItem(Profissoes, 0, "Mafiosas");
	AddMenuItem(Profissoes, 0, "Transportes");
	AddMenuItem(Profissoes, 0, "Governo");
	AddMenuItem(Profissoes, 0, "Exercito");
	AddMenuItem(Profissoes, 0, "Outros");

	Honestas = CreateMenu("Honestas 1", 1, 200.0, 180.0, 200.0, 200.0);
	AddMenuItem(Honestas, 0, "Desempregado~p~ [0]");
	AddMenuItem(Honestas, 0, "Vendedor de Spawn~p~ [250]");
	AddMenuItem(Honestas, 0, "Vendedor de Carros~p~ [250]");
	AddMenuItem(Honestas, 0, "Barman~p~ []");
	AddMenuItem(Honestas, 0, "Guarda Costas~p~ []");
	AddMenuItem(Honestas, 0, "Motorista particular~p~ []");
	AddMenuItem(Honestas, 0, "Estudante~p~ []");
	AddMenuItem(Honestas, 0, "Estagiario~p~ []");
	AddMenuItem(Honestas, 0, "Pescador~p~ []");
	AddMenuItem(Honestas, 0, "Cacador~p~ []");

	Honestas2 = CreateMenu("Honestas 2", 1, 200.0, 180.0, 200.0, 200.0);
	AddMenuItem(Honestas2, 0, "Caminhoneiro~p~ []");
	AddMenuItem(Honestas2, 0, "Jornalista~p~ []");
	AddMenuItem(Honestas2, 0, "Advogado~p~ []");
	AddMenuItem(Honestas2, 0, "Medico~p~ []");
	AddMenuItem(Honestas2, 0, "Farmaceutico~p~ []");
	AddMenuItem(Honestas2, 0, "Cientista~p~ []");
	AddMenuItem(Honestas2, 0, "Vendedor de Skins~p~ []");
	AddMenuItem(Honestas2, 0, "Mecanico~p~ []");
	AddMenuItem(Honestas2, 0, "Seguranca Particular~p~ []");
	AddMenuItem(Honestas2, 0, "Entregador de Pizza~p~ []");

	Honestas3 = CreateMenu("Honestas 3", 1, 200.0, 180.0, 200.0, 200.0);
	AddMenuItem(Honestas3, 0, "Frentista~p~ []");
	AddMenuItem(Honestas3, 0, "Bancario~p~ []");
	AddMenuItem(Honestas3, 0, "Rapper~p~ []");
	AddMenuItem(Honestas3, 0, "Chaveiro~p~ []");
	AddMenuItem(Honestas3, 0, "Aposentado~p~ []");
	AddMenuItem(Honestas3, 0, "Gari~p~ []");
	AddMenuItem(Honestas3, 0, "Porteiro da Ilha~p~ []");
	AddMenuItem(Honestas3, 0, "Seguranca da Ilha~p~ []");
	AddMenuItem(Honestas3, 0, "Seguranca da Vila~p~ []");
	AddMenuItem(Honestas3, 0, "Porteiro da Vila~p~ []");

	Policiaismenu = CreateMenu("Pliciais", 1, 200.0, 180.0, 200.0, 200.0);
	AddMenuItem(Policiaismenu, 0, "Policia Militar~p~ []");
	AddMenuItem(Policiaismenu, 0, "Policia Civil~p~ []");
	AddMenuItem(Policiaismenu, 0, "Policia Rodoviaria~p~ []");
	AddMenuItem(Policiaismenu, 0, "Swat~p~ []");
	AddMenuItem(Policiaismenu, 0, "FBI~p~ []");
	AddMenuItem(Policiaismenu, 0, "Interpol~p~ []");
	AddMenuItem(Policiaismenu, 0, "Policia Florestal~p~ []");
	AddMenuItem(Policiaismenu, 0, "Ibama~p~ []");
	AddMenuItem(Policiaismenu, 0, "Policia Federal~p~ []");
	AddMenuItem(Policiaismenu, 0, "Narcoticos~p~ []");
	AddMenuItem(Policiaismenu, 0, "CIA~p~ []");

	Mafiosas = CreateMenu("Mafiosas", 1, 200.0, 180.0, 200.0, 200.0);
	AddMenuItem(Mafiosas, 0, "Assasino~p~ []");
	AddMenuItem(Mafiosas, 0, "Traficante de Drogas~p~ []");
	AddMenuItem(Mafiosas, 0, "Vendedor de Armas~p~ []");
	AddMenuItem(Mafiosas, 0, "Matador de Aluguel~p~ []");
	AddMenuItem(Mafiosas, 0, "Prostituta~p~ []");
	AddMenuItem(Mafiosas, 0, "Chefao da Marfia~p~ []");
	AddMenuItem(Mafiosas, 0, "Seguestrador~p~ []");
	AddMenuItem(Mafiosas, 0, "Terrorista~p~ []");
	AddMenuItem(Mafiosas, 0, "Ladrao de Veiculos~p~ []");

	Transporte = CreateMenu("Transporte", 1, 200.0, 180.0, 200.0, 200.0);
	AddMenuItem(Transporte, 0, "Taxista~p~ []");
	AddMenuItem(Transporte, 0, "Motorista de Onibus~p~ []");
	AddMenuItem(Transporte, 0, "Mototaxista~p~ []");
	AddMenuItem(Transporte, 0, "AeroTaxista~p~ []");
	AddMenuItem(Transporte, 0, "Maquista~p~ []");

	Governo = CreateMenu("Governo", 1, 200.0, 180.0, 200.0, 200.0);
	AddMenuItem(Governo, 0, "Deputado~p~ []");
	AddMenuItem(Governo, 0, "Vereador~p~ []");
	AddMenuItem(Governo, 0, "Prefeito~p~ []");
	AddMenuItem(Governo, 0, "Governador~p~ []");
	AddMenuItem(Governo, 0, "Presidente~p~ []");
	AddMenuItem(Governo, 0, "Senador~p~ []");

    Outras = CreateMenu("Outras", 1, 200.0, 180.0, 200.0, 200.0);
	AddMenuItem(Outras, 0, "Vigia~p~ [50]");
	AddMenuItem(Outras, 0, "Jogado de futebol~p~ [50]");
	AddMenuItem(Outras, 0, "Modelo~p~ [50]");
	AddMenuItem(Outras, 0, "Matematico~p~ [150]");
	AddMenuItem(Outras, 0, "Cantor~p~ [20]");
	AddMenuItem(Outras, 0, "Bombeiro~p~ [20]");
}
stock CarregarCasas()
{
	CriarCasa(0, 1442.9769,-629.5287,95.7186,178.6666 , 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166);
	CriarVeiculoCasa(0, 1454.3051,-636.2531,95.4855,00.00000, 0, 0, 60000);
    CriarCasa(1,1180.6436,-1261.0978,15.1797,178.6666, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 1
    CriarVeiculoCasa(1,1183.3438,-1256.3412,14.8849,181.5493,0,0,60000); // casacarro 1
    CriarCasa(2,1289.0182,-1272.2578,13.5421,267.3742, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 2
    CriarVeiculoCasa(2,1283.6968,-1273.2844,13.2471,89.3455,0,0,60000); // casacarro 2
    CriarCasa(3,1242.7125,-1099.1998,27.9766,185.3447, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 3
    CriarVeiculoCasa(3,1246.9681,-1107.8298,25.1840,87.0711,0,0,60000); // casacarro 3
    CriarCasa(4,1326.6516,-1090.5967,27.9766,88.9086, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 4
    CriarVeiculoCasa(4,1329.4823,-1098.9320,24.8165,267.7721,0,0,60000); // casacarro 4
    CriarCasa(5,1411.2686,-921.3064,38.4219,84.9666, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 5
    CriarVeiculoCasa(5,1423.1879,-916.6552,35.7500,170.4704,0,0,60000); // casacarro 5
    CriarCasa(6,1534.4757,-800.2939,72.8495,271.3435, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 6
    CriarVeiculoCasa(6,1531.4215,-813.5717,71.7297,89.6640,0,0,60000); // casacarro 6
    CriarCasa(7,1527.6067,-772.9483,80.5781,319.3498, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 7
    CriarVeiculoCasa(7,1516.1854,-765.6156,79.7415,142.3904,0,0,60000); // casacarro 7
    CriarCasa(8,1497.0365,-688.0214,95.5633,359.5567, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 8
    CriarVeiculoCasa(8,1517.6586,-694.3355,94.4580,91.8940,0,0,60000); // casacarro 8
    CriarCasa(9,1298.5203,-799.1024,84.1406,0.3895, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 9
    CriarVeiculoCasa(9,1255.0345,-803.6511,83.8264,182.9767,0,0,60000); // casacarro 9
    CriarCasa(10,1331.6758,-632.5883,109.1349,202.1523, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 10
    CriarVeiculoCasa(10,1354.3733,-629.8290,108.8378,18.1902,0,0,60000); // casacarro 10
    CriarVeiculoCasa(11,1088.5797,-640.6484,112.8402,270.6318,0,0,60000); // casacarro 11 certo
    CriarCasa(11,1094.9246,-646.6957,113.6484,183.6366, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 11
    CriarVeiculoCasa(12,1038.8876,-640.5571,119.8221,7.4989,0,0,60000); // casacarro 12
    CriarCasa(12,1045.0914,-642.5051,120.1172,16.0774, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 12
    CriarVeiculoCasa(13,1011.1232,-659.7744,120.8466,34.1534,0,0,60000); // casacarro 13
    CriarCasa(13,980.2843,-677.1107,121.9763,213.8822, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 13
    CriarVeiculoCasa(14,945.7864,-718.2571,121.9168,28.7244,0,0,60000); // casacarro 14
    CriarCasa(14,945.9199,-710.1779,122.6199,205.9052, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 14
    CriarVeiculoCasa(15,907.2632,-783.4279,101.1351,22.2825,0,0,60000); // casacarro 15
    CriarCasa(15,890.9781,-782.4037,101.3063,293.7841, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 15
    CriarVeiculoCasa(16,814.5134,-767.0546,76.6220,286.9725,0,0,60000); // casacarro 16
    CriarCasa(16,808.6380,-759.2776,76.5314,102.8574, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 16
    CriarVeiculoCasa(17,230.2423,-1411.1782,51.3145,331.5994,0,0,60000); // casacarro 17
    CriarCasa(17,228.360,-1405.0049,51.6094,62.8224, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa17
    CriarCasa(18,255.2363,-1366.5060,53.1094,125.6249, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 18
    CriarVeiculoCasa(18,248.5121,-1355.8860,52.8145,303.3760,0,0,60000); // casacarro 18
    CriarVeiculoCasa(19,311.8434,-1335.9058,53.1511,35.1633,0,0,60000); // casacarro 19
    CriarCasa(19,298.2274,-1337.7134,53.4415,122.2726, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 19
    CriarVeiculoCasa(20,192.0426,-1315.9807,69.9539,178.7573,0,0,60000); // casacarro 20
    CriarCasa(20,189.6465,-1308.2172,70.2495,182.0150, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 20
    CriarVeiculoCasa(21,217.6329,-1280.3783,62.2203,163.0193,0,0,60000); // casacarro 21
    CriarCasa(21,219.8821,-1250.7811,78.3311,127.7659, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 21
    CriarCasa(22,265.8177,-1288.1177,74.6325,32.5896, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 22 certo
    CriarVeiculoCasa(22,277.1049,-1265.5110,73.6502,305.4447,0,0,60000); // casacarro 22 certo
    CriarCasa(23,251.6170,-1220.3655,76.1024,304.0003, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 23
    CriarVeiculoCasa(23,250.8252,-1226.5657,74.6496,219.2519,0,0,60000); // casacarro 23
    CriarVeiculoCasa(24,283.1940,-1160.2391,80.6184,224.2630,0,0,60000); // casacarro 24
    CriarCasa(24,300.3199,-1154.5287,81.3906,318.2713, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 24
    CriarVeiculoCasa(25,405.6369,-1153.5542,76.9678,147.3614,0,0,60000); // casacarro 25
    CriarCasa(25,416.4819,-1154.3405,76.6876,54.7811, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 25
    CriarVeiculoCasa(26,473.4063,-1171.4514,64.5494,194.9720,0,0,60000); // casacarro 26
    CriarCasa(26,470.9162,-1164.3936,67.2020,285.1129, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 26
    CriarVeiculoCasa(27,568.5525,-1131.4510,50.3445,209.7115,0,0,60000); // casacarro 27
    CriarCasa(27,565.3152,-1112.2058,62.8064,303.1641, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 27
    CriarVeiculoCasa(28,528.0695,-1207.0281,43.9383,288.3067,0,0,60000); // casacarro 28
    CriarCasa(28,552.8520,-1200.3164,44.8315,199.6001, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 28
    CriarVeiculoCasa(29,725.5538,-994.9861,52.3468,60.1087,0,0,60000); // casacarro 29
    CriarCasa(29,725.1600,-998.8096,52.7344,149.6966, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 29
    CriarVeiculoCasa(30,833.6932,-889.5701,68.4769,318.7822,0,0,60000); // casacarro 30
    CriarCasa(30,836.2426,-894.3798,68.7689,237.6512, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 30
    CriarVeiculoCasa(31,830.0552,-851.8408,69.6288,199.3345,0,0,60000); // casacarro 31
    CriarCasa(31,828.0319,-858.7717,70.3308,22.5481, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 31
    CriarVeiculoCasa(32,943.5189,-840.4159,94.0252,31.0982,0,0,60000); // casacarro 32
    CriarCasa(32,937.6721,-848.4227,93.6269,295.4395, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 32
    CriarVeiculoCasa(33,958.6351,-764.0418,109.2995,97.7602,0,0,60000); // casacarro 33
    CriarCasa(33,977.3770,-771.1562,112.2026,176.8601, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 33
    CriarVeiculoCasa(34,1102.0087,-820.5056,86.6508,94.6419,0,0,60000); // casacarro 34
    CriarCasa(34,1093.7950,-806.6432,107.4197,192.2759, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 34
    CriarVeiculoCasa(35,1110.1359,-732.7385,100.0122,89.7874,0,0,60000); // casacarro 35
    CriarCasa(35,1112.2179,-742.0629,100.1329,356.6987, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 35
    CriarVeiculoCasa(36,1113.3422,-306.5906,73.6974,90.3057,0,0,60000); // casacarro 36
    CriarCasa(36,1105.5420,-299.7543,74.5391,268.4362, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 36
    CriarVeiculoCasa(37,786.2191,-489.5294,17.0492,179.9514,0,0,60000); // casacarro 37
    CriarCasa(37,795.2526,-506.6995,18.0129,271.5143, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 37
    CriarVeiculoCasa(38,246.7587,-129.4097,1.9211,89.3806,0,0,60000); // casacarro 38
    CriarCasa(38,252.3210,-121.3610,3.5354,181.5511, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 38
    CriarVeiculoCasa(39,278.2352,-54.1692,1.2849,179.0631,0,0,60000); // casacarro 39
    CriarCasa(39,267.6174,-55.3332,2.7772,354.8815, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 39
    CriarCasa(40,342.1204,62.2463,3.8424,212.4756, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 40
    CriarVeiculoCasa(40,343.1028,67.1221,3.6511,123.9620,0,0,60000); // casacarro 40
    CriarVeiculoCasa(41,733.2892,296.8531,19.9392,180.2804,0,0,60000); // casacarro 41
    CriarCasa(41,747.1564,305.0965,20.2344,188.4570, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 41
    CriarVeiculoCasa(42,1950.0823,157.7490,36.5999,346.5180,0,0,60000); // casacarro 42
    CriarCasa(42,1945.8392,163.2924,37.2327,68.6192, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 42
    CriarCasa(43,1925.7523,170.6076,37.2813,157.3032, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 43
    CriarVeiculoCasa(43,1904.0358,170.7243,36.8568,340.7058,0,0,60000); // casacarro 43
    CriarVeiculoCasa(44,2209.7979,58.0670,26.8579,269.7932,0,0,60000); // casacarro 44
    CriarCasa(44,2204.1746,62.2201,28.4416,180.7108, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 44
    CriarVeiculoCasa(45,2265.0386,105.8306,26.8603,179.7418,0,0,60000); // casacarro 45 certo
    CriarCasa(45,2269.6301,111.3603,28.4416,270.8876, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 45
    CriarVeiculoCasa(46,2231.2705,171.6305,27.1845,180.8887,0,0,60000); // casacarro 46
    CriarCasa(46,2236.5203,167.1311,28.1535,0.3393, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 46
    CriarVeiculoCasa(47,2358.3203,-62.1454,27.1743,359.5313,0,0,60000); // casacarro 47
    CriarCasa(47,2367.6819,-62.7683,28.1535,267.5717, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 47
    CriarVeiculoCasa(48,2558.3577,72.0302,26.1823,88.8177,0,0,60000); // casacarro 48
    CriarCasa(48,2550.9900,57.0908,27.6756,0.0862, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 48
    CriarVeiculoCasa(49,2804.2219,-1069.9835,30.1216,273.1059,0,0,60000); // casacarro 49
    CriarCasa(49,2793.5022,-1087.3553,30.7188,186.9193, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 49
    CriarVeiculoCasa(50,2806.5784,-1182.7562,25.1126,267.1922,0,0,60000); // casacarro 50
    CriarCasa(50,2808.0664,-1176.8208,25.3764,1.0079, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 50
    CriarVeiculoCasa(51,2854.2559,-1355.2986,10.7698,269.2908,0,0,60000); // casacarro 51
    CriarCasa(51,2853.4524,-1365.8750,14.1641,90.1965, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 51
    CriarVeiculoCasa(52,2743.0999,-1215.1475,65.1906,183.6218,0,0,60000); // casacarro 52
    CriarCasa(52,2749.9539,-1222.2085,64.6016,2.4007, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 52
    CriarVeiculoCasa(53,2445.4531,-1309.2732,23.6148,181.5027,0,0,60000); // casacarro 53
    CriarCasa(53,2434.0242,-1303.3667,25.0081,91.8689, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 53
    CriarVeiculoCasa(54,2378.8752,-1360.3306,23.7052,2.2469,0,0,60000); // casacarro 54
    CriarCasa(54,2383.1970,-1366.2255,24.4914,358.2443, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 54
    CriarVeiculoCasa(55,2384.5183,-1641.6860,13.2170,179.2517,0,0,60000); // casacarro 55
    CriarCasa(55,2393.2834,-1646.1382,13.9051,267.4116, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 55
    CriarVeiculoCasa(56,2473.1899,-1700.2029,13.2250,359.6500,0,0,60000); // casacarro 56
    CriarCasa(56,2459.5322,-1690.7317,13.5440,267.2494, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 56
    CriarVeiculoCasa(57,2505.5852,-1694.3521,13.2615,1.5503,0,0,60000); // casacarro 57
    CriarCasa(57,2495.3311,-1690.3750,14.7656,181.1222, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 57
    CriarVeiculoCasa(58,2492.6479,-1651.4524,13.1895,85.7251,0,0,60000); // casacarro 58
    CriarCasa(58,2486.4878,-1645.1298,14.0772,1.2471, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 58
    CriarVeiculoCasa(59,2319.3796,-1711.6976,13.2515,179.9835,0,0,60000); // casacarro 59
    CriarCasa(59,2326.8081,-1716.8396,14.2379,92.4738, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 59
    CriarVeiculoCasa(60,2684.5249,-2021.3998,13.2338,179.4369,0,0,60000); // casacarro 60
    CriarCasa(60,2695.2722,-2020.0891,14.0223,179.1733, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 60
    CriarVeiculoCasa(61,2645.3354,-1983.2590,13.2553,180.0618,0,0,60000); // casacarro 61
    CriarCasa(61,2652.9001,-1989.6794,13.9988,91.3096, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 61
    CriarVeiculoCasa(62,2812.6287,-1969.7476,11.1471,270.5318,0,0,60000); // casacarro 62
    CriarCasa(62,2802.0464,-1962.9847,13.5469,357.6068, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 62
    CriarVeiculoCasa(63,2167.3167,-1681.9840,14.7912,315.8827,0,0,60000); // casacarro 63
    CriarCasa(63,2166.6367,-1671.8516,15.0745,132.8396, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 63
    CriarVeiculoCasa(64,2059.9229,-1694.6840,13.2561,268.3471,0,0,60000); // casacarro 64
    CriarCasa(64,2065.5703,-1703.4084,14.1484,90.7965, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 64
    CriarVeiculoCasa(65,1975.5828,-1727.8602,15.6737,269.6310,0,0,60000); // casacarro 65
    CriarCasa(65,1980.9275,-1719.0586,17.0305,356.4608, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 65
    CriarVeiculoCasa(66,1927.5220,-1927.0514,13.1689,269.2595,0,0,60000); // casacarro 66
    CriarCasa(66,1928.5051,-1916.0969,15.2568,268.4662, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 66
    CriarVeiculoCasa(67,1699.0106,-2082.0613,13.2517,180.7106,0,0,60000); // casacarro 67
    CriarCasa(67,1684.8607,-2099.1572,13.8343,89.2463, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 67
    CriarVeiculoCasa(68,1900.4180,-2057.3806,13.1658,270.1732,0,0,60000); // casacarro 68
    CriarCasa(68,1895.4807,-2068.3672,15.6689,181.0464, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 68
    CriarVeiculoCasa(69,1645.0809,-1696.9840,20.1690,180.5201,0,0,60000); // casacarro 69
    CriarCasa(69,1654.2578,-1656.1927,22.5156,5.7214, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 69
    CriarVeiculoCasa(70,1134.3954,-2048.0198,68.7129,0.1895,0,0,60000); // casacarro 70
    CriarCasa(70,1123.8970,-2036.9446,69.8858,182.1458, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 70
    CriarVeiculoCasa(71,892.6564,-1658.2670,13.2525,181.9721,0,0,60000); // casacarro 71
    CriarCasa(71,893.7419,-1636.3730,14.9297,2.0605, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 71
    CriarVeiculoCasa(72,756.7012,-1605.4927,12.9331,356.4261,0,0,60000); // casacarro 72
    CriarCasa(72,766.7313,-1605.8689,13.8039,271.9626, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 72
    CriarVeiculoCasa(73,708.3142,-1421.4548,13.2400,359.9400,0,0,60000); // casacarro 73
    CriarCasa(73,738.9045,-1417.9452,13.5234,181.9815, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 73
    CriarVeiculoCasa(74,660.0930,-1418.8368,13.9027,358.6877,0,0,60000); // casacarro 74
    CriarCasa(74,685.4459,-1421.6711,14.7261,267.3153, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 74
    CriarVeiculoCasa(75,697.6573,-1641.1542,3.1221,267.8908,0,0,60000); // casacarro 75
    CriarCasa(75,694.0811,-1645.8280,4.0938,179.0604, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 75
    CriarVeiculoCasa(76,322.3761,-1765.7349,4.3056,180.1007,0,0,60000); // casacarro 76
    CriarCasa(76,315.7607,-1770.3987,4.6553,86.5458, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa 76
    CriarVeiculoCasa(77,-2377.4404,2431.5420,8.6893,61.7840,0,0,60000); // /casacarro 73
    CriarCasa(77,-2379.2688,2444.4370,10.1694,70.8147, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 73
    CriarVeiculoCasa(78,-2479.0925,2437.2942,15.7444,278.7376,0,0,60000); // /casacarro 74
    CriarCasa(78,-2479.8115,2449.5786,17.3230,99.8891, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 74
    CriarVeiculoCasa(79,-2568.5496,2317.5525,4.6130,184.5552,0,0,60000); // /casacarro 75
    CriarCasa(79,-2583.1223,2307.9561,7.0029,96.1678, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 75
    CriarVeiculoCasa(80,-2560.4404,2258.2964,4.7693,334.3509,0,0,60000); // /casacarro 76
    CriarCasa(80,-2552.0837,2266.5203,5.4755,154.3253, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 76
    CriarVeiculoCasa(81,-2528.2766,2251.3433,4.6804,334.6111,0,0,60000); // /casacarro 77
    CriarCasa(81,-2523.7847,2238.9995,5.3984,155.8101, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 77
    CriarVeiculoCasa(82,-2619.0718,2364.8479,8.6223,180.5803,0,0,60000); // /casacarro 78
    CriarCasa(82,-2627.1370,2359.5413,8.9724,184.0917, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 78
    CriarVeiculoCasa(83,-2567.9783,1147.5844,55.4314,156.3648,0,0,60000); // /casacarro 79
    CriarCasa(83,-2563.3074,1148.6655,55.7266,341.2960, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 79
    CriarVeiculoCasa(84,-2390.7664,1127.5575,55.4319,162.7894,0,0,60000); // /casacarro 80
    CriarCasa(84,-2396.7061,1132.2957,55.7333,341.9771, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 80
    CriarVeiculoCasa(85,-2497.4653,918.8804,64.6503,183.0185,0,0,60000); // /casacarro 81
    CriarCasa(85,-2502.9368,921.2216,65.2248,1.6098, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 81
    CriarVeiculoCasa(86,-2586.0813,915.4602,64.6822,88.2101,0,0,60000); // /casacarro 82
    CriarCasa(86,-2580.8323,919.8080,64.9844,359.6252, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 82
    CriarVeiculoCasa(87,-2634.1411,929.7346,71.2240,215.0715,0,0,60000); // /casacarro 83
    CriarCasa(87,-2641.0132,935.5859,71.9531,2.1036, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 83
    CriarVeiculoCasa(88,-2680.6267,868.9402,76.2233,8.5447,0,0,60000); // /casacarro 84
    CriarCasa(88,-2662.0195,877.1789,79.7738,87.8570, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 84
    CriarVeiculoCasa(89,-2664.7590,913.2177,79.3793,181.9970,0,0,60000); // /casacarro 85
    CriarCasa(89,-2671.4004,927.9124,79.7031,88.2021, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 85
    CriarVeiculoCasa(90,-2721.7795,977.9406,54.1674,3.2691,0,0,60000); // /casacarro 86
    CriarCasa(90,-2710.8184,968.0437,54.4609,183.9939, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 86
    CriarVeiculoCasa(91,-2664.7112,989.8184,64.6000,358.6718,0,0,60000); // /casacarro 87
    CriarCasa(91,-2655.4800,986.3392,64.9913,90.5205, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 87
    CriarVeiculoCasa(92,-2569.0625,988.8469,77.9780,0.3683,0,0,60000); // /casacarro 88
    CriarCasa(92,-2573.6121,993.2848,78.2734,180.5932, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 88
    CriarVeiculoCasa(93,-2474.4001,1341.3624,7.7551,271.9175,0,0,60000); // /casacarro 89
    CriarCasa(94,-2477.4382,1338.1753,8.5039,90.6144, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 89
    CriarVeiculoCasa(94,-1976.6553,1276.8351,6.8984,359.2574,0,0,60000); // /casacarro 90
    CriarCasa(95,-1970.4613,1273.3085,7.5223,176.5912, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 90
    CriarVeiculoCasa(95,-1701.9650,1368.2659,6.8793,44.0103,0,0,60000); // /casacarro 91
    CriarCasa(96,-1700.0284,1380.4049,7.1875,305.6799, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 91
    CriarVeiculoCasa(96,-1920.1851,1187.0150,45.0782,179.5356,0,0,60000); // /casacarro 92
    CriarCasa(97,-1915.4536,1189.9508,45.4453,1.6333, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 92
    CriarVeiculoCasa(97,-2014.7754,994.7219,49.6476,269.5303,0,0,60000); // /casacarro 93
    CriarCasa(98,-2017.4915,999.8312,50.8660,356.3216, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 93
    CriarVeiculoCasa(98,-2105.2915,893.5327,76.4086,358.1534,0,0,60000); // /casacarro 94
    CriarCasa(99,-2099.6028,897.7919,76.7109,87.7701, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 94
    CriarVeiculoCasa(99,-2134.1709,932.9062,79.6282,359.9402,0,0,60000); // /casacarro 95
    CriarCasa(100,-2116.8157,927.2569,86.0791,355.2948, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 95
    CriarVeiculoCasa(100,-2276.4517,904.2974,66.3463,268.5472,0,0,60000); // /casacarro 96
    CriarCasa(101,-2281.5027,916.5942,66.6484,179.1676, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 96
    CriarVeiculoCasa(101,-2233.1809,1105.4730,79.7061,181.0426,0,0,60000); // /casacarro 97
    CriarCasa(102,-2227.8503,1107.3915,80.0078,87.4124, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 97
    CriarVeiculoCasa(102,-2206.9004,715.9346,49.1625,0.0183,0,0,60000); // /casacarro 98
    CriarCasa(103,-2213.5591,721.5107,49.4141,263.0389, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 98
    CriarVeiculoCasa(103,-2622.5190,729.1614,27.9978,269.6003,0,0,60000); // /casacarro 99
    CriarCasa(104,-2624.6960,733.1990,28.1135,88.1327, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 99
    CriarVeiculoCasa(104,-2796.2109,223.8559,6.8922,89.0174,0,0,60000); // /casacarro 100
    CriarCasa(105,-2791.7996,218.5833,7.8594,184.7012, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 100
    CriarVeiculoCasa(105,-2693.8801,127.3654,4.0413,90.2270,0,0,60000); // /casacarro 101
    CriarCasa(106,-2691.3015,123.4634,4.3359,357.6856, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 101
    CriarVeiculoCasa(106,-2718.8047,-19.6650,4.0454,269.5281,0,0,60000); // /casacarro 102
    CriarCasa(107,-2723.0308,-16.7194,7.2031,90.9735, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 102
    CriarVeiculoCasa(107,-2725.2805,-196.7985,4.0413,271.1463,0,0,60000); // /casacarro 103
    CriarCasa(108,-2724.1904,-191.2555,4.3359,88.5107, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 103
    CriarVeiculoCasa(108,-2729.5078,-281.8337,6.7440,179.6047,0,0,60000); // /casacarro 104
    CriarCasa(109,-2719.8557,-318.8753,7.8438,229.6118, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 104
    CriarVeiculoCasa(109,-2511.5684,-193.9185,25.1701,269.8448,0,0,60000); // /casacarro 105
    CriarCasa(110,-2515.0291,-189.1557,25.0886,1.3995, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 105
    CriarVeiculoCasa(110,-2449.5654,-122.7646,25.8434,92.5483,0,0,60000); // /casacarro 106
    CriarCasa(111,-2455.3672,-135.9403,26.1468,0.9734, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 106
    CriarVeiculoCasa(111,2089.5361,-1140.9573,25.2101,89.5337,0,0,60000); // /casacarro 107
    CriarCasa(112,2095.3611,-1145.1383,26.5929,0.4849, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 107
    CriarVeiculoCasa(113,1934.7771,-1118.4199,26.1791,178.4830,0,0,60000); // /casacarro 108
    CriarCasa(113,1939.0729,-1114.4871,27.4523,92.8109, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 108
    CriarVeiculoCasa(114,2106.0300,-1251.1763,25.1903,357.2817,0,0,60000); // /casacarro 109
    CriarCasa(114,2110.9702,-1243.9486,25.8516,178.5916, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 109
    CriarVeiculoCasa(115,2149.2017,-1249.9792,24.6993,1.8684,0,0,60000); // /casacarro 110
    CriarCasa(115,2153.7144,-1243.0902,25.3672,180.5260, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 110
    CriarVeiculoCasa(116,2242.2263,-1235.0969,24.2865,0.4824,0,0,60000); // /casacarro 111
    CriarCasa(116,2250.0935,-1238.4879,25.8984,91.0872, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 111
    CriarVeiculoCasa(117,2347.9937,-1166.5431,27.3142,359.5231,0,0,60000); // /casacarro 112
    CriarCasa(117,2351.8708,-1170.0958,28.0470,183.1064, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 112
    CriarVeiculoCasa(118,2443.3269,-1134.5989,34.4278,178.1950,0,0,60000); // /casacarro 113
    CriarCasa(118,2427.3933,-1135.7715,34.7109,0.4479, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 113
    CriarVeiculoCasa(119,2486.1121,-1248.0955,30.5432,175.7862,0,0,60000); // /casacarro 114
    CriarCasa(119,2492.0454,-1239.2385,37.9054,266.5662, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 114
    CriarVeiculoCasa(120,2525.2734,-1358.0762,28.6707,90.6170,0,0,60000); // /casacarro 115
    CriarCasa(120,2522.2341,-1343.8619,30.7297,267.8820, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 115
    CriarVeiculoCasa(121,2636.0586,-1108.8928,68.0497,358.5060,0,0,60000); // /casacarro 116
    CriarCasa(121,2626.0398,-1112.6005,67.8529,356.3009, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 116
    CriarVeiculoCasa(122,2592.1152,-947.7121,81.0967,193.7815,0,0,60000); // /casacarro 117
    CriarCasa(122,2583.0862,-953.3709,81.3884,284.5050, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 117
    CriarVeiculoCasa(123,2339.2202,-1047.5129,52.2843,183.8205,0,0,60000); // /casacarro 118
    CriarCasa(123,2334.9844,-1045.5237,52.3582,181.4922, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 118
    CriarVeiculoCasa(124,2273.0522,-1036.5211,50.7642,134.8977,0,0,60000); // /casacarro 119
    CriarCasa(124,2260.1731,-1019.5439,59.2931,51.5952, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 119
    CriarVeiculoCasa(125,2176.6946,-986.5095,64.1741,168.6726,0,0,60000); // /casacarro 120
    CriarCasa(125,2186.0474,-997.9493,66.4688,259.2809, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 120
    CriarVeiculoCasa(126,2109.7703,-969.0455,54.2759,163.6811,0,0,60000); // /casacarro 121
    CriarCasa(126,2091.1223,-972.7896,51.9551,137.9949, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 121
    CriarVeiculoCasa(127,2116.0754,-1059.9768,25.4117,144.5120,0,0,60000); // /casacarro 122
    CriarCasa(127,2105.4893,-1056.4607,27.1066,50.3160, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 122
    CriarVeiculoCasa(128,2102.5669,-1274.7937,25.1955,178.0297,0,0,60000); // /casacarro 123
    CriarCasa(128,2111.2356,-1279.3741,25.6875,252.1230, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 123
    CriarVeiculoCasa(129,2095.6970,-1279.2488,25.2011,179.6067,0,0,60000); // /casacarro 124
    CriarCasa(129,2090.9878,-1278.4783,26.1797,91.3194, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 124
    CriarVeiculoCasa(130,1800.0398,-1586.6844,13.2144,308.1482,0,0,60000); // /casacarro 125
    CriarCasa(130,1798.3348,-1578.6825,14.0898,102.6283, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 125
    CriarVeiculoCasa(131,1388.6929,-1567.7301,13.2990,169.7197,0,0,60000); // /casacarro 126
    CriarCasa(131,1396.9224,-1570.4095,14.2721,270.8851, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // /casa 126
    CriarVeiculoCasa(132,-59.8551,52.1321,2.8157,340.0593,0,0,60000); // fazendo carro
    CriarCasa(132,-62.6094,76.1919,3.1172,67.3793, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // fazenda
    CriarVeiculoCasa(133,-373.9951,-1423.4672,25.4310,0.0219,0,0,60000); // carro fazenda
    CriarCasa(133,-383.0343,-1438.7936,26.3279,96.3140, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // fazenda
    CriarVeiculoCasa(134,1977.4989,-1674.9730,15.6742,269.1730,0,0,60000); // carro cas
    CriarCasa(134,1981.3611,-1682.8208,17.0537,89.7447, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(135,1852.3413,734.5479,11.0009,269.1038,0,0,60000); // carro casa
    CriarCasa(135,1846.2443,741.4610,11.4609,181.5456, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(136,1853.6178,654.3394,10.9131,269.1454,0,0,60000); // carro casa
    CriarCasa(136,1846.2809,661.4322,11.4609,180.5682, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(137,2050.3376,658.6807,10.9668,0.9286,0,0,60000); // carro casa
    CriarCasa(137,2043.1283,651.8907,11.4609,89.5154, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(138,2353.1541,699.5798,10.9032,358.9638,0,0,60000); // carro casa
    CriarCasa(138,2346.3235,691.9062,11.4609,89.2828, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(139,2441.5198,706.2090,10.8356,90.6116,0,0,60000); // carro casa
    CriarCasa(139,2450.0576,714.2272,11.4683,274.7673, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(140,2452.5835,697.8279,11.1666,88.3494,0,0,60000); // carro casa
    CriarCasa(140,2448.1282,689.6826,11.4609,273.0188, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(141,2044.4524,2657.9133,10.5327,180.8019,0,0,60000); // carro casa
    CriarCasa(141,2037.0957,2663.8347,10.8203,7.3386, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(142,1928.7246,2654.6133,10.5253,180.0881,0,0,60000); // carro casa
    CriarCasa(142,1921.7188,2664.2000,10.8203,359.9594, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(143,1917.0006,2769.0310,10.5248,89.2045,0,0,60000); // carro casa
    CriarCasa(143,1929.7754,2774.2676,10.8203,1.0003, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(144,1960.1427,2754.4004,10.5253,179.9969,0,0,60000); // carro casa
    CriarCasa(144,1967.3921,2766.0210,10.8265,1.6715, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(145,2028.1382,2733.0776,10.5258,358.5656,0,0,60000); // carro casa
    CriarCasa(145,2037.2351,2721.5413,11.5430,179.4545, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(146,1555.1141,2750.1719,10.5251,88.4330,0,0,60000); // carro casa
    CriarCasa(146,1564.5029,2757.1426,10.8203,271.7198, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(147,1463.3815,2782.1753,10.4470,177.1974,0,0,60000); // carro casa
    CriarCasa(147,1457.0298,2773.5120,10.8203,91.6476, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(148,1566.2516,2668.5027,10.5212,358.9418,0,0,60000); // carro casa
    CriarCasa(148,1572.9418,2658.6926,10.8203,179.9202, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(149,1458.0651,2520.7141,10.5258,272.8471,0,0,60000); // carro casa
    CriarCasa(149,1454.0591,2525.6563,10.8203,93.7564, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(150,1276.2445,2529.6941,10.5252,267.6686,0,0,60000); // carro casa
    CriarCasa(150,1274.2797,2522.6016,10.8203,91.9017, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(151,424.5107,2530.9043,16.3258,89.7851,0,0,60000); // carro casa
    CriarCasa(151,424.1859,2536.5210,16.1484,91.2171, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(152,-912.6337,2686.3215,42.0751,314.0449,0,0,60000); // carro casa
    CriarCasa(152,-911.0029,2672.5696,42.3703,44.7153, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(153,-237.3493,2608.2922,62.4085,179.4749,0,0,60000); // carro casa
    CriarCasa(153,-254.0960,2603.3076,62.8582,93.7446, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(154,-223.1591,2769.2139,62.3725,181.2219,0,0,60000); // carro casa
    CriarCasa(154,-219.6404,2767.0688,62.6875,358.7831, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(155,-1533.6489,2641.1458,55.5411,87.2449,0,0,60000); // carro casa
    CriarCasa(155,-1532.7953,2656.5618,56.2814,177.2780, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(156,-1422.1282,2179.9292,50.2487,205.3831,0,0,60000); // carro casa
    CriarCasa(156,-1426.9236,2171.0256,50.6250,15.9350, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(157,-1359.3252,2041.9910,52.1208,267.1830,0,0,60000); // carro casa
    CriarCasa(157,-1353.8838,2057.7102,53.1172,357.8481, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(158,-1670.1935,2496.1184,86.7428,269.4015,0,0,60000); // carro casa
    CriarCasa(158,-1667.2949,2486.5132,87.1694,102.4802, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(159,-1040.6801,1537.4099,33.4551,307.3885,0,0,60000); // carro casa
    CriarCasa(159,-1051.3966,1549.8723,33.4376,309.8983, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(160,-151.7318,878.0536,18.0926,271.6284,0,0,60000); // carro casa
    CriarCasa(160,-152.0060,882.0321,18.4609,109.8795, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(161,-257.9189,1158.6783,19.4539,90.7480,0,0,60000); // carro casa
    CriarCasa(161,-258.7858,1151.2094,20.9399,159.5365, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(162,-340.2962,1164.7147,19.4489,179.7136,0,0,60000); // carro casa
    CriarCasa(162,-324.4836,1165.0513,20.9399,271.0804, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(163,-360.6741,1196.8262,19.4472,179.7822,0,0,60000); // carro casa
    CriarCasa(163,-369.1966,1169.0148,20.2719,47.9261, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(164,-240.0498,999.2593,19.4529,358.9633,0,0,60000); // carro casa
    CriarCasa(164,-247.7798,1001.3541,20.9399,257.3379, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(165,-290.9698,1746.6503,42.3962,88.8603,0,0,60000); // carro casa
    CriarCasa(165,-314.8873,1774.1327,43.6406,214.1225, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
    CriarVeiculoCasa(166,732.9194,-1264.1086,13.2597,1.3577,0,0,60000); // carro casa
    CriarCasa(166,726.2867,-1276.2180,13.6484,91.3340, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0, 166); // casa
}
public Taxi()
{
    for(new i=0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(Taximetro[i][1] == 1)
            {
                if(GetPlayerMoney(i) > PrecoTaximetro[i] + 3)
                {
                    PrecoTaximetro[i] += 3;
                    format(stringx, sizeof(stringx), "{F9c68A}| INFO | O taxímetro informa: R$%d", PrecoTaximetro[i]);
					SendClientMessage(Taximetro[i][2], 0xF0CC00AA, stringx);
                }
                if(GetPlayerMoney(i) < PrecoTaximetro[i] + 3)
                {
                    SendClientMessage(i, 0xF0CC00AA, "{F9c68A}| INFO | Você não possui mais dinheiro para continuar a corrida, e ira ficar nesse local.");
                    SendClientMessage(Taximetro[i][2], 0xF0CC00AA, "{F9c68A}| INFO | O seu passageiro não tem mais dinheiro para continuar o percurso e ficará neste local!");
					GivePlayerMoney(i, -PrecoTaximetro[i]);
                    GivePlayerMoney(Taximetro[i][2], PrecoTaximetro[i]);
                    RemovePlayerFromVehicle(i);
                    Taximetro[i][1] = 0; Taximetro[i][2] = 0; PrecoTaximetro[i] = 0;
                    KillTimer(CronometroTaxi[i][1]); KillTimer(CronometroTaxi[i][2]);
                }
            }
        }
    }
	return 1;
}

stock MaiorLevel()
{
    new dorgas, mano;
    for(new dorgado; dorgado < MAX_PLAYERS; dorgado++)
    if(IsPlayerConnected(dorgado))
    {
        if(!IsPlayerAdmin(dorgado))
        {
        	new maconha = GetPlayerScore(dorgado);
        	if(maconha > dorgas)
        	{
            	mano = dorgado;
            	dorgas = maconha;
        	}
        }
    }
    return mano;
}

stock IsPlayerInPlace(playerid,Float:XMin,Float:YMin,Float:XMax,Float:YMax )
{
    new RetValue = 0;
    new Float:X,Float:Y,Float:Z;
    GetPlayerPos(playerid,X,Y,Z );

    if( X >= XMin && Y >= YMin && X < XMax && Y < YMax )
    {
        RetValue = 1;
    }
    return RetValue;
}


public AntiAfk()
{
    for(new i=0; i < MAX_PLAYERS; i++)
    {
    	GetPlayerPos(i, PlayerCurrentPos[0], PlayerCurrentPos[1], PlayerCurrentPos[2]);
		if(!floatcmp(PlayerCurrentPos[0], PlayerLastPos[i][LastX]) && !floatcmp(PlayerCurrentPos[1], PlayerLastPos[i][LastY]))
		{
			PlayerAfkTicks[i] ++;
		}
		else
		{
			PlayerAfkTicks[i] = 0;
		}
		PlayerLastPos[i][LastX] = PlayerCurrentPos[0];
		PlayerLastPos[i][LastY] = PlayerCurrentPos[1];
		PlayerLastPos[i][LastZ] = PlayerCurrentPos[2];

		if(PlayerAfkTicks[i] == MAX_TIME_AFK * 60)
		{
		    if(IsPlayerConnected(i))
		    {
                if(!IsPlayerNPC(i))
                {
    	   	    	AFK[i] = 1;
       				format(stringx, sizeof(stringx), "{F9c68A}| INFO | %s foi bloqueado de evoluir, por ficar ausente por 3 minutos.", pName(i));
    				SendClientMessageToAll(0x00FF7FAA, stringx);
    				SetPlayerVirtualWorld(i, 1);
    				SetCameraBehindPlayer(i);
    				TogglePlayerControllable(i, 0);
    				TextDrawShowForPlayer(i, afk1[i]);
    				TextDrawShowForPlayer(i, afk2[i]);
    				TextDrawShowForPlayer(i, faixa1[i]);
    				TextDrawShowForPlayer(i, faixa2[i]);
                }
			}
		}
    }
	return 1;
}
public AceitarSkin(playerid)
{
	if(Aceitarskin[playerid] == 1)
	{
		KillTimer(TimerSkin[playerid]);
	    TimerSkin[playerid] = SetTimerEx("AceitarSkin", 5000, true, "i", playerid);
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar a solicitação de uma nova skin. (/Aceitar ou /Recusar)");
	    Aceitarskin[playerid] = 2;
	    return 1;
	}
	if(Aceitarskin[playerid] == 2)
	{
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar a solicitação de uma nova skin. (/Aceitar ou /Recusar)");
		Aceitarskin[playerid] = 3;
	    return 1;
	}
	if(Aceitarskin[playerid] == 3)
	{
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar a solicitação de uma nova skin. (/Aceitar ou /Recusar)");
	    Aceitarskin[playerid] = 4;
	    return 1;
	}
	if(Aceitarskin[playerid] == 4)
	{
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar a solicitação de uma nova skin. (/Aceitar ou /Recusar)");
	    Aceitarskin[playerid] = 5;
	    return 1;
	}
	if(Aceitarskin[playerid] == 5)
	{
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar a solicitação de uma nova skin. (/Aceitar ou /Recusar)");
	    Aceitarskin[playerid] = 6;
	    return 1;
	}
	if(Aceitarskin[playerid] == 6)
	{
	    KillTimer(TimerSkin[playerid]);
	    Aceitarskin[playerid] = 0;
	    return 1;
	}
	return 1;
}
public AceitarCurativo(playerid)
{
	if(Aceitarcurativo[playerid] == 1)
	{
	    KillTimer(TimerCurativo[playerid]);
	    TimerCurativo[playerid] = SetTimerEx("AceitarCurativo", 5000, true, "i", playerid);
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar a solicitação de curativo. (/Aceitar ou /Recusar)");
	    Aceitarcurativo[playerid] = 2;
	    return 1;
	}
	if(Aceitarcurativo[playerid] == 2)
	{
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar a solicitação de curativo. (/Aceitar ou /Recusar)");
		Aceitarcurativo[playerid] = 3;
	    return 1;
	}
	if(Aceitarcurativo[playerid] == 3)
	{
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar a solicitação de curativo. (/Aceitar ou /Recusar)");
	    Aceitarcurativo[playerid] = 4;
	    return 1;
	}
	if(Aceitarcurativo[playerid] == 4)
	{
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar a solicitação de curativo. (/Aceitar ou /Recusar)");
	    Aceitarcurativo[playerid] = 5;
	    return 1;
	}
	if(Aceitarcurativo[playerid] == 5)
	{
	    SendClientMessage(playerid, 0xA9C4E4AA, "{F9c68A}| INFO | Para aceitar ou recusar a solicitação de curativo. (/Aceitar ou /Recusar)");
	    Aceitarcurativo[playerid] = 6;
	    return 1;
	}
	if(Aceitarcurativo[playerid] == 6)
	{
	    KillTimer(TimerCurativo[playerid]);
	    Aceitarcurativo[playerid] = 0;
	    return 1;
	}
	return 1;
}
public DestruirObjeto(objid) DestroyObject(objid);
public CriarExplosao(Float:X,Float:Y,Float:Z,tipo,Float:diam) CreateExplosion(X,Y,Z,tipo,diam);
public GlenPark(playerid) {TextDrawHideForPlayer(playerid, dm[playerid]);}

public AtualizarCombustivel()
{
    for(new i=0; i < MAX_PLAYERS; i++)
    {
		if(IsPlayerConnected(i))
		{
			if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
			{
				if(Abastecendo[i] == false)
				{
					new vehicleid = GetPlayerVehicleID(i);
					if(GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510)
					{
		    			TogglePlayerControllable(i, true);
					}
					else
					{
						if(PlayerInfo[i][pEmprego] == 0)
						{
					    	PlayerInfo[i][pEmprego] = 0;
						}
						else
						{
  							PlayerInfo[i][pEmprego]--;
     			    		TogglePlayerControllable(i, true);
						}
        				if(PlayerInfo[i][pEmprego] == 5 || PlayerInfo[i][pEmprego] == 4 || PlayerInfo[i][pEmprego] == 3 || PlayerInfo[i][pEmprego] == 2 || PlayerInfo[i][pEmprego] == 1)
						{
							SendClientMessage(i, -1, "{F9c68A}| INFO | Seu combustível está acabando, vá até um posto de gasolina mais próximo e abasteça!");
  							PlayerPlaySound(i, 1057, 0.0, 0.0, 10.0);
    		    			return 0;
						}
					}
				}
			}
		}
    }
	return 1;
}
public Abastecer(playerid)
{
	if(Abastecendo[playerid] == true)
	{
        KillTimer(abastecer);
        new preco = Combustivel[playerid] * 2;
        PlayerInfo[playerid][pCombustivel] += Combustivel[playerid];
        GivePlayerMoney(playerid, -preco);
        PlayerInfo[playerid][pCombustivel] = Combustivel[playerid];
        format(stringx, sizeof(stringx), "[ POSTO ] Você abasteceu %d litros de combustível, custo - R$%d,00", Combustivel[playerid], preco);
        SendClientMessage(playerid, 0xEEDC2DAA, stringx);
        TogglePlayerControllable(playerid, true);
        Abastecendo[playerid] = false;
        Combustivel[playerid] = 0;
	}
	return 1;
}
stock GetEmpresaID(playerid)
{
	for(new i=0; i<MAX_EMPRESAS; i++)
	{
	    if(PlayerToPoint(1.5, playerid, EmpInfo[i][Entradax], EmpInfo[i][Entraday], EmpInfo[i][Entradaz]))
	    {
	        return i;
		}
	}
	return -255;
}
AddMapIcon(iconid, Float:iconX, Float:iconY, Float:iconZ, IconID)
{
    new icon[128];
	format(icon, sizeof(icon), "/iGamming/iIcones/%d.ini",iconid);
	if(!dini_Exists(icon))
	{
		dini_Create(icon);
		MapInfo[empid][MapIcon] = IconID;
		dini_IntSet(icon, "MapIcon", IconID);
		dini_FloatSet(icon, "Pos_X", iconX);
		dini_FloatSet(icon, "Pos_Y", iconY);
		dini_FloatSet(icon, "Pos_Z", iconZ);
	}
	else
	{
        MapInfo[iconid][Pos_X] = dini_Float(icon, "Pos_X");
        MapInfo[iconid][Pos_Y] = dini_Float(icon, "Pos_Y");
        MapInfo[iconid][Pos_Z] = dini_Float(icon, "Pos_Z");
		MapInfo[iconid][MapIcon] = dini_Int(icon, "MapIcon");
	}
}
AddEmpresa(empid, Float:iconX, Float:iconY, Float:iconZ, Float:interiorX, Float:interiorY, Float:interiorZ, Custo, Sella, Interiora, virtualworld, cnpj)
{
    new empresa[128];
	format(empresa, sizeof(empresa), "/iGamming/iEmpresas/%d.ini",empid);
	if(!dini_Exists(empresa))
	{
		dini_Create(empresa);

		format(EmpInfo[empid][Dono], 24, "Ninguem");
		dini_Set(empresa, "Dono", "Ninguem");

		dini_Set(empresa, "Empregado_1", "Ninguem");
		format(EmpInfo[empid][Empregado_1], 24, "Ninguem");

		dini_Set(empresa, "Empregado_2", "Ninguem");
		format(EmpInfo[empid][Empregado_2], 24, "Ninguem");

		dini_Set(empresa, "Empregado_3", "Ninguem");
		format(EmpInfo[empid][Empregado_3], 24, "Ninguem");

		dini_Set(empresa, "Empregado_4", "Ninguem");
		format(EmpInfo[empid][Empregado_4], 24, "Ninguem");

		dini_Set(empresa, "Descricao", "Empresa [iG]");
		format(EmpInfo[empid][Descricao], 128, "Empresa [iG]");

		dini_Set(empresa, "NomeEmp", "Empresa [iG]");
		format(EmpInfo[empid][NomeEmp], 128, "Empresa [iG]");

		dini_Set(empresa, "Login", "(0/0/0000) 00:00:00");
		format(EmpInfo[empid][Login], 128, "(0/0/0000) 00:00:00");

		EmpInfo[empid][Level] = 1;
		dini_IntSet(empresa, "Level", 1);

		EmpInfo[empid][Entregas] = 0;
		dini_IntSet(empresa, "Entregas", 0);

		EmpInfo[empid][Entrada] = 0;
		dini_IntSet(empresa, "Entrada", 0);

		EmpInfo[empid][TemDono] = 0;
		dini_IntSet(empresa, "TemDono", 0);

		EmpInfo[empid][Contrata] = 0;
		dini_IntSet(empresa, "Contrata-se", 0);

		EmpInfo[empid][Agua] = 0;
		dini_IntSet(empresa, "Agua", 0);

		EmpInfo[empid][Mercadorias] = 0;
		dini_IntSet(empresa, "Mercadorias", 0);

		EmpInfo[empid][Luz] = 0;
		dini_IntSet(empresa, "Luz", 0);

		EmpInfo[empid][CNPJ] = cnpj;

		dini_IntSet(empresa, "CNPJ", cnpj);

		EmpInfo[empid][Compra] = Custo;
		dini_IntSet(empresa, "Compra", Custo);

		EmpInfo[empid][Venda] = Sella;
		dini_IntSet(empresa, "Venda", Sella);

		EmpInfo[empid][Interior] = Interiora;
		dini_IntSet(empresa, "Interior", Interiora);

		dini_IntSet(empresa, "VirtualWorld", empid);
		EmpInfo[empid][VirtualWorld] = empid;

		EmpInfo[empid][Fechada] = 0;
		dini_IntSet(empresa, "Fechada", 0);

		EmpInfo[empid][Saidax] = interiorX;
		EmpInfo[empid][Saiday] = interiorY;
		EmpInfo[empid][Saidaz] = interiorZ;

		EmpInfo[empid][TemEmpregado_1] = 0;
		dini_IntSet(empresa, "TemEmpregado_1", 0);
		EmpInfo[empid][TemEmpregado_2] = 0;
		dini_IntSet(empresa, "TemEmpregado_2", 0);
		EmpInfo[empid][TemEmpregado_3] = 0;
		dini_IntSet(empresa, "TemEmpregado_3", 0);
		EmpInfo[empid][TemEmpregado_4] = 0;
		dini_IntSet(empresa, "TemEmpregado_4", 0);

		dini_FloatSet(empresa, "Saida_X", interiorX);
		dini_FloatSet(empresa, "Saida_Y", interiorY);
		dini_FloatSet(empresa, "Saida_Z", interiorZ);

		print("-");
		print("--------------Empresa Criada--------------");
		printf("- EmpresaID: %d", empid);
		printf("- Preco de compra: %d", Custo);
		printf("- Preco de venda: %d", Sella);
		printf("- Interior: %d", Interiora);
		printf("- VirtualWorld: %d", virtualworld);
		print("-----------------------------------------");
		print("-");
	}
	else
	{
	    format(EmpInfo[empid][Dono], 24, dini_Get(empresa, "Dono"));
	    format(EmpInfo[empid][Descricao], 128, dini_Get(empresa, "Descricao"));
	    format(EmpInfo[empid][NomeEmp], 128, dini_Get(empresa, "NomeEmp"));
	    format(EmpInfo[empid][Login], 128, dini_Get(empresa, "Login"));
	    format(EmpInfo[empid][Empregado_1], 24, dini_Get(empresa, "Empregado_1"));
	    format(EmpInfo[empid][Empregado_2], 24, dini_Get(empresa, "Empregado_2"));
	    format(EmpInfo[empid][Empregado_3], 24, dini_Get(empresa, "Empregado_3"));
		format(EmpInfo[empid][Empregado_4], 24, dini_Get(empresa, "Empregado_4"));
	    EmpInfo[empid][Compra] = dini_Int(empresa, "Compra");
	    EmpInfo[empid][Venda] = dini_Int(empresa, "Venda");
	    EmpInfo[empid][Lucro] = dini_Int(empresa, "Lucro");
	    EmpInfo[empid][Interior] = dini_Int(empresa, "Interior");
	    EmpInfo[empid][Level] = dini_Int(empresa, "Level");
	    EmpInfo[empid][Entregas] = dini_Int(empresa, "Entregas");
	    EmpInfo[empid][Entrada] = dini_Int(empresa, "Entrada");
	    EmpInfo[empid][TemDono] = dini_Int(empresa, "TemDono");
	    EmpInfo[empid][Contrata] = dini_Int(empresa, "Contrata-se");
	    EmpInfo[empid][Fechada] = dini_Int(empresa, "Fechada");
	    EmpInfo[empid][Saidax] = dini_Float(empresa, "Saida_X");
	    EmpInfo[empid][Saiday] = dini_Float(empresa, "Saida_Y");
		EmpInfo[empid][Saidaz] = dini_Float(empresa, "Saida_Z");
		EmpInfo[empid][VirtualWorld] = dini_Int(empresa, "VirtualWorld");
		EmpInfo[empid][Mercadorias] = dini_Int(empresa, "Mercadorias");
		EmpInfo[empid][Luz] = dini_Int(empresa, "Luz");
		EmpInfo[empid][CNPJ] = dini_Int(empresa, "CNPJ");
		EmpInfo[empid][Agua] = dini_Int(empresa, "Agua");
		EmpInfo[empid][TemEmpregado_1] = dini_Int(empresa, "TemEmpregado_1");
		EmpInfo[empid][TemEmpregado_2] = dini_Int(empresa, "TemEmpregado_2");
		EmpInfo[empid][TemEmpregado_3] = dini_Int(empresa, "TemEmpregado_3");
		EmpInfo[empid][TemEmpregado_4] = dini_Int(empresa, "TemEmpregado_4");
	}

	if(EmpInfo[empid][TemDono] == 0)
	{
	    EmpInfo[empid][Fechada] = 0;
		dini_IntSet(empresa, "Fechada", 0);
	}

    EmpInfo[empid][Entradax] = iconX;
	EmpInfo[empid][Entraday] = iconY;
	EmpInfo[empid][Entradaz] = iconZ;

	UpdateEmp(empid);
	format(stringx, sizeof(stringx), "Empresa ID° %d", empid);
    Create3DTextLabel(stringx,0xFFFFFFAA,iconX, iconY, iconZ+0.75,20.0,0,1);
	Create3DTextLabel("Aperte 'F' para sair",0xFFFFFFAA,EmpInfo[empid][Saidax], EmpInfo[empid][Saiday], EmpInfo[empid][Saidaz]+0.75,20.0,EmpInfo[empid][VirtualWorld],1);
	CreateDynamicPickup(1318,1, EmpInfo[empid][Saidax], EmpInfo[empid][Saiday], EmpInfo[empid][Saidaz], EmpInfo[empid][VirtualWorld], EmpInfo[empid][Interior],  -1, 100);
}
public SetHP(playerid) {
	new Float:Health;
	GetPlayerHealth(playerid,Health);
	if(Health < 80)
	{
		SetPlayerHealth(playerid,(Health -15));
	}
	TookSprunk[playerid] = false;
    return 1;
}

public IsAtCandySprunk(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,2,-2420.219,984.578,44.297)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-2420.180,985.945,44.297)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2225.203,-1153.422,1025.906)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2576.703,-1284.430,1061.094)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2155.906,1606.773,1000.055)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2209.906,1607.195,1000.055)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2222.203,1606.773,1000.055)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,495.969,-24.320,1000.734)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,501.828,-1.430,1000.734)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,373.828,-178.141,1000.734)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,330.680,178.500,1020.070)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,331.922,178.500,1020.070)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,350.906,206.086,1008.477)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,361.563,158.617,1008.477)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,371.594,178.453,1020.070)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,374.891,188.977,1008.477)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2155.844,1607.875,1000.063)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2202.453,1617.008,1000.063)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2209.242,1621.211,1000.063)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2222.367,1602.641,1000.063)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,500.563,-1.367,1000.734)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,379.039,-178.883,1000.734)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2480.86,-1959.27,12.9609)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,1634.11,-2237.53,12.8906)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2139.52,-1161.48,23.3594)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2153.23,-1016.15,62.2344)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-1350.12,493.859,10.5859)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-2229.19,286.414,34.7031)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,1659.46,1722.86,10.2188)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2647.7,1129.66,10.2188)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2845.73,1295.05,10.7891)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,1398.84,2222.61,10.4219)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-1455.12,2591.66,55.2344)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-76.0312,1227.99,19.125)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,662.43,-552.164,15.7109)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-253.742,2599.76,62.2422)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2271.73,-76.4609,25.9609)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,1789.21,-1369.27,15.1641)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,1729.79,-1943.05,12.9453)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2060.12,-1897.64,12.9297)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,1928.73,-1772.45,12.9453)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2325.98,-1645.13,14.2109)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2352.18,-1357.16,23.7734)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,1154.73,-1460.89,15.1562)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-1350.12,492.289,10.5859)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-2118.97,-423.648,34.7266)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-2118.62,-422.414,34.7266)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-2097.27,-398.336,34.7266)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-2092.09,-490.055,34.7266)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-2063.27,-490.055,34.7266)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-2005.65,-490.055,34.7266)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-2034.46,-490.055,34.7266)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-2068.56,-398.336,34.7266)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-2039.85,-398.336,34.7266)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-2011.14,-398.336,34.7266)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-1980.79,142.664,27.0703)) return 1;
 	else if(IsPlayerInRangeOfPoint(playerid,2,2319.99,2532.85,10.2188)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,1520.15,1055.27,10.00)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2503.14,1243.7,10.2188)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,2085.77,2071.36,10.4531)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-862.828,1536.61,21.9844)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-14.7031,1175.36,18.9531)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,-253.742,2597.95,62.2422)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,201.016,-107.617,0.898438)) return 1;
	else if(IsPlayerInRangeOfPoint(playerid,2,1277.84,372.516,18.9531)) return 1;
	else return 0;
}

stock IsPlayerInCaixa(playerid)
{
    if(PlayerToPoint(1.5,playerid,2308.7542,-13.2503,26.7422))
	{
	    return 1;
	}
	return 0;
}

public SendMSG(playerid)
{
	new randMSG = random(sizeof(RandomMSG));
	SendClientMessage(playerid, -1, RandomMSG[randMSG]);
}

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(stringx); i < j; i++) if (string[i] <= 47 || string[i] >= 58) return 0;
	return 1;
}

stock EjetarJogador(playerid)
{
	new Float:Px = 0.000000,
	Float:Py = 0.000000,
	Float:Pz = 0.000000,
	Float:Pa = 0.000000;
	GetPlayerPos(playerid, Px, Py, Pz);
	GetPlayerFacingAngle(playerid, Pa);
	RemovePlayerFromVehicle(playerid);
	SetPlayerPos(playerid, Px, Py, (Pz+3));
	return 1;
}

public VisibilityUpdate()
{
	new dist;
	new Float:x, Float:x1, Float:y, Float:y1, Float:tmp;

	for(new i=0; i<MAX_PLAYERS; i++)
    {
	    if(IsPlayerConnected(i))
	    {
	        GetPlayerPos(i, x, y, tmp);
	        for(new j=0; j<MAX_PLAYERS; j++)
            {
	            if(IsPlayerConnected(j) && j != i)
	            {
					GetPlayerPos(j, x1, y1, tmp);
	                dist = floatround(floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)));
					if(GetPlayerVirtualWorld(j) == GetPlayerVirtualWorld(i) && GetPlayerVirtualWorld(i) == 24)
			  		{
				  		SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x000000FF));
			  		}
	                else if(dist <= 999)
					{
                        if(PlayerInfo[i][pEmprego] != 41 || PlayerInfo[i][pEmprego] != 42 || PlayerInfo[i][pEmprego] != 43 || PlayerInfo[i][pEmprego] != 44 || PlayerInfo[i][pEmprego] != 46 || PlayerInfo[i][pEmprego] != 47 || PlayerInfo[i][pEmprego] != 48 || PlayerInfo[i][pEmprego] != 49)
 					{
							SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x000000EE));
						}
						else if(GetPlayerVehicleID(j) != 0)
 					{
                            SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x000000EE));
						}
					}
					else if(dist <= 1000) SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x000000AA));
	                else if(dist <= 2000) SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x00000099));
	                else if(dist <= 3000) SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x00000088));
	                else if(dist <= 4000) SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x00000077));
	                else if(dist <= 5000) SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x00000066));
	                else if(dist <= 6000) SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x00000055));
	                else if(dist <= 7000) SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x00000044));
	                else if(dist <= 8000) SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x00000033));
	                else if(dist <= 9000) SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x00000022));
	                else if(dist <= 10000) SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x00000011));
	                else if(dist <= 11000) SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x00000011));
	                else SetPlayerMarkerForPlayer(i, j, ((GetPlayerColor(j) & 0xFFFFFF00) | 0x00000011));

	                if(GetPlayerInterior(i) != GetPlayerInterior(j)) SetPlayerMarkerForPlayer(i, j, (GetPlayerColor(j) & 0xFFFFFF00));
				}
			}
		}
	}
}


public IsABoat(carid)
{
    new oo = GetVehicleModel(carid);
 	if(oo == 430 || oo == 452 || oo == 453 || oo == 454 || oo == 472 || oo == 473 || oo == 484 || oo == 493 || oo == 595)
	{
		return 1;
	}
	return 0;
}
public IsAPlane(carid)
{
 	new oo = GetVehicleModel(carid);
 	if(oo == 487 || oo == 520 || oo == 417 || oo == 425 || oo == 447 ||oo == 460 || oo == 464 || oo == 465 || oo == 469 || oo == 476 || oo == 488 || oo == 497|| oo == 501 || oo == 511  || oo == 512 || oo == 513 || oo == 519 ||oo == 548 || oo == 553 || oo == 563 || oo == 577 || oo == 592 || oo == 593)
 	{
 	 	return 1;
 	}
 	return 0;
}

public IsABikeCar(carid)
{
 	new oo = GetVehicleModel(carid);
 	if(oo == 510 || oo == 481)
 	{
 	 	return 1;
 	}
 	return 0;
}

new minu2 = 0;
new TempoReloginho = 59;
new foicount1 = 1;
new SalarioUP;
public RelogioUPs() //conta de segundos em segundos
{
    HoraAtual();
    minu2++; //+ 1 segundo ate chegar no 59 ( 1 minuto )
    TempoReloginho--;// tira menos - 1 segundos cada segundo
    new string[128];// strting
    if(minu2>=59) // quando chegar no 1 minuto oque fazer
    {
    minu2 = 0;
    foicount1 ++;
    TempoReloginho = 59;
    }
    if(foicount1 == 1) format(string, 128,"~y~UP~p~: ~w~9~p~:~w~%d", TempoReloginho);
    else if(foicount1 == 2) format(string, 128,"~y~UP~p~: ~w~8~p~:~w~%d", TempoReloginho);
    else if(foicount1 == 3) format(string, 128,"~y~UP~p~: ~w~7~p~:~w~%d", TempoReloginho);
    else if(foicount1 == 4) format(string, 128,"~y~UP~p~: ~w~6~p~:~w~%d", TempoReloginho);
    else if(foicount1 == 5) format(string, 128,"~y~UP~p~: ~w~5~p~:~w~%d", TempoReloginho);
    else if(foicount1 == 6) format(string, 128,"~y~UP~p~: ~w~4~p~:~w~%d", TempoReloginho);
    else if(foicount1 == 7) format(string, 128,"~y~UP~p~: ~w~3~p~:~w~%d", TempoReloginho);
    else if(foicount1 == 8) format(string, 128,"~y~UP~p~: ~w~2~p~:~w~%d", TempoReloginho);
    else if(foicount1 == 9) format(string, 128,"~y~UP~p~: ~w~1~p~:~w~%d", TempoReloginho);
    else if(foicount1 == 10) format(string, 128,"~y~UP~p~: ~w~0~p~:~w~%d", TempoReloginho);
    TextDrawSetString(ReloginhoUP,string);
    TextDrawShowForAll(ReloginhoUP);
    if(foicount1 == 11)
    {
    foicount1 = 1;
	SalarioUP ++;
    for(new i=0; i<MAX_PLAYERS; i++)
    {
    if(PlayerInfo[i][pExp] <= 6)
    {
        PlayerInfo[i][pExp] ++;
        format(string, sizeof(string), "| UP | Você ganhou +1 de experiência! [ %d / 5 ]",PlayerInfo[i][pExp]);
        PlayerPlaySound(i, 1057, 0, 0, 0);
        SendClientMessage(i, 0x75EA00AA, string);
    }
    if(PlayerInfo[i][pExp] >= 6)
    {
	    PlayerInfo[i][pExp] = 0;
        PlayerInfo[i][pLevel] ++;
        format(string, sizeof(string), "| UP | Você juntou 5 pontos de experiência e ganhou 1 level! [level %d ]",PlayerInfo[i][pLevel]);
        SendClientMessage(i, 0x75EA00AA, string);
        PlayerPlaySound(i, 1057, 0, 0, 0);
    }
    }
    new melhor = MaiorLevel();
	SendClientMessageToAll( 0xFFFFFFAA, "{75EA00}~•~•~•~•~•~•~•~•~•~•~•~•~•~•~•~•~• {FFFFFF}Record {75EA00}~•~•~•~•~•~•~•~•~•~•~•~•~•~•~•~•~•");
	format(string, sizeof(string), "{75EA00}» {FFFFFF}Jogado record do server : %s (%d) [Level: %d]", pName(melhor), melhor, GetPlayerScore(melhor));
	SendClientMessageToAll( 0xFFFFFFAA, string);
	SendClientMessageToAll( 0xFFFFFFAA, "{75EA00}~•~•~•~•~•~•~•~•~•~•~•~•~•~•~•~•~• {FFFFFF}Record {75EA00}~•~•~•~•~•~•~•~•~•~•~•~•~•~•~•~•~•");
    }
    if(SalarioUP == 3)
	{
	SalarioUP = 0;
    PayDay();
    }
    return 1;
}
stock GetPlayerDistanceToPoint(playerid,Float:x,Float:y)
{
    new Float:x1,Float:y1,Float:z1;
    new Float:tmpdis;
    GetPlayerPos(playerid,x1,y1,z1);
    tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2));
    return floatround(tmpdis);
}
public Horarios()
{
	new h,mi,s;
	gettime(h,mi,s);

    SetWorldTime(0);

    if(h==7 && mi==00)
    {
		if(FaculdadeAberta == false)
		{
        FaculdadeAberta = true;
        GameTextForAll("~w~Escola ~p~Aberta!", 6000, 1);
        }
    }
    if(h==8 && mi==00)
    {
        if(FaculdadeAberta == true)
		{
        FaculdadeAberta = false;
        GameTextForAll("~w~Escola ~p~Fechada!", 6000, 1);
        }
    }
    if(h==13 && mi==00)
    {
        if(FaculdadeAberta == false)
		{
        FaculdadeAberta = true;
        GameTextForAll("~w~Escola ~p~Aberta!", 6000, 1);
        }
    }
    if(h==14 && mi==00)
    {
        if(FaculdadeAberta == true)
		{
        FaculdadeAberta = false;
        GameTextForAll("~w~Escola ~p~Fechada!", 6000, 1);
        }
	}
    if(h==18 && mi==00)
    {
        if(FaculdadeAberta == false)
		{
        FaculdadeAberta = true;
        GameTextForAll("~w~Escola ~p~Aberta!", 6000, 1);
        }
    }
    if(h==20 && mi==30)
    {
        if(FaculdadeAberta == true)
		{
        FaculdadeAberta = false;
        GameTextForAll("~w~Escola ~p~Fechada!", 6000, 1);
        }
    }
    return 1;
}
public PayDay()
{
    for(new i=0; i<MAX_PLAYERS; i++)
    {

		PlayerInfo[i][pBanco] = PlayerInfo[i][pBanco] += PlayerInfo[i][pSalario];

		format(stringx, sizeof(stringx), "{00D200}[+]{C6E2FF} Salário: $%d |", PlayerInfo[i][pSalario]);
		SendClientMessage(i, -1, stringx);

		new rands = random(sizeof(c_Grana));

        format(stringx, sizeof(stringx), "{00D200}[+]{C6E2FF} Bônus: +$%i |", c_Grana[rands][0]);
		SendClientMessage(i, -1, stringx);
        PlayerInfo[i][pBanco] = PlayerInfo[i][pBanco] += c_Grana[rands][0];

        format(stringx, sizeof(stringx), " {AA3333}[-]{C6E2FF} Inflação: -10$ |");
		SendClientMessage(i, -1, stringx);

        new account = PlayerInfo[i][pBanco];

        format(stringx, sizeof(stringx), "{00D200}[+]{C6E2FF} Banco: $%d |", account);
		SendClientMessage(i, -1, stringx);

		new randes = random(sizeof(c_Imposto_de_renda));

        format(stringx, sizeof(stringx), " {AA3333}[-]{C6E2FF} Imposto de Renda: -$%d |", c_Imposto_de_renda[randes][0]);
		SendClientMessage(i, -1, stringx);

		format(stringx, sizeof(stringx), "~r~Pagamento do dia");
		GameTextForPlayer(i, stringx, 5000, 1);
	}
    return 1;
}

public LimparFome(playerid)
{
    TextDrawHideForPlayer(playerid, fome[playerid]);
	return 1;
}

public SpeedoUpdate()
{
    new str1[128],str2[128],str4[128],str5[128];
    new Float:Speedo_X,Float:Speedo_Y,Float:Speedo_Z;
	new Float:PlayerSpeedDistance,value;
	new Float:Speedo_HP;

	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
		{
		    GetPlayerPos(i, Speedo_X, Speedo_Y, Speedo_Z);
			GetPlayerVehicleID(i);
			GetVehicleHealth(GetPlayerVehicleID(i), Speedo_HP);
			PlayerSpeedDistance = floatsqroot(floatpower(floatabs(floatsub(Speedo_X,SavePlayerPos[i][sX])),2)+floatpower(floatabs(floatsub(Speedo_Y,SavePlayerPos[i][sY])),2)+floatpower(floatabs(floatsub(Speedo_Z,SavePlayerPos[i][sZ])),2));
			value = floatround(PlayerSpeedDistance * 3600);

            if(PlayerUlt[i][pVelocimetro] == 1 && Gps[ i ] == 0)
			{
				TextDrawShowForPlayer(i, moldura0[i]);
				TextDrawShowForPlayer(i, moldura1[i]);
				TextDrawShowForPlayer(i, moldura2[i]);
				TextDrawShowForPlayer(i, moldura3[i]);
				TextDrawShowForPlayer(i, fahrzeug[i]);
				TextDrawShowForPlayer(i, km[i]);
				TextDrawShowForPlayer(i, hoehe[i]);
				TextDrawShowForPlayer(i, moldura4[i]);
				TextDrawShowForPlayer(i, moldura5[i]);
				TextDrawShowForPlayer(i, moldura6[i]);
				TextDrawShowForPlayer(i, zustand[i]);
				TextDrawShowForPlayer(i, pvelo[i]);
			}
			new km_anzahl = floatround(value/800);

			format(str1,sizeof(str1),"~d~~p~Veiculo:~b~%s",VehicleNames[GetVehicleModel(GetPlayerVehicleID(i))-400]);
			TextDrawSetString(fahrzeug[i], str1);

			if(km_anzahl >= 0)
			{
                format(str2,sizeof(str2),"~d~~p~KM/H:~b~%d",km_anzahl);
				TextDrawSetString(km[i], str2);
			}

			format(str4,sizeof(str4),"~d~~p~Altura:~b~%.1f", Speedo_Z);
			TextDrawSetString(hoehe[i], str4);

			if(Speedo_HP >= 551)
			{
				format(str5,sizeof(str5),"~d~~p~Lataria:~b~%.2f", Speedo_HP);
				TextDrawSetString(zustand[i], str5);
			}
			else if(Speedo_HP >= 361)
			{
                format(str5,sizeof(str5),"~d~~p~Lataria:~b~%.2f", Speedo_HP);
				TextDrawSetString(zustand[i], str5);
			}
			else
			{
                format(str5,sizeof(str5),"~d~~p~Lataria:~b~%.2f", Speedo_HP);
				TextDrawSetString(zustand[i], str5);
			}
		}
		SavePlayerPos[i][sX] = Speedo_X, SavePlayerPos[i][sY] = Speedo_Y, SavePlayerPos[i][sZ] = Speedo_Z;
	}
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerInAnyVehicle(i)||Gps[ i ] == 1)
		{
            TextDrawHideForPlayer(i, moldura0[i]); TextDrawHideForPlayer(i, moldura1[i]); TextDrawHideForPlayer(i, moldura2[i]); TextDrawHideForPlayer(i, moldura3[i]); TextDrawHideForPlayer(i, fahrzeug[i]); TextDrawHideForPlayer(i, km[i]);
			TextDrawHideForPlayer(i, hoehe[i]); TextDrawHideForPlayer(i, moldura4[i]); TextDrawHideForPlayer(i, moldura5[i]); TextDrawHideForPlayer(i, moldura6[i]); TextDrawHideForPlayer(i, zustand[i]); TextDrawHideForPlayer(i, pvelo[i]); //TextDrawHideForPlayer(i, url[i]);
		}
 	}
    return 1;
}

public UpdateEmp(empid)
{
    if(EmpInfo[empid][TemDono] == 0)
	{
        DestroyDynamicPickup(EmpresaPickup[ empid ]);
        EmpresaPickup[ empid ] = CreateDynamicPickup(1578,1,EmpInfo[empid][Entradax],EmpInfo[empid][Entraday],EmpInfo[empid][Entradaz]);
	}
	else
	{
        DestroyDynamicPickup(EmpresaPickup[ empid ]);
        EmpresaPickup[ empid ] = CreateDynamicPickup(1580,1,EmpInfo[empid][Entradax],EmpInfo[empid][Entraday],EmpInfo[empid][Entradaz]);
	}
}
