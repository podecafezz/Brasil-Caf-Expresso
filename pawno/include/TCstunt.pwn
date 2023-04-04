#include <a_samp>
#include <Y_Objects>
#include <cpstream>
#include <core>
#include <float>
#include <dini>
#pragma tabsize 0



//======================================================  Cores ======================================================
#define roxo        0x8080FFAA
#define Amarelo     0xFBFB00AA
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_RED 0xFF0000AA
#define red 0xFF0000AA
#define Vermelho 0xFF0000AA
#define Cinza 0xBEBFBFAA
#define Verde 0x00F600AA
#define Branco 0xF6F6F6AA

#define AMARELO 0xFFFF00FF
#define COLOR_GREEN 0x33AA33AA
#define RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x33CCFFAA //blue
#define COLOR_DARKBLUE 0x3399FFAA //dark blue
#define COLOR_GREY 0xAFAFAFAA //grey
#define COLOR_LIGHTBLUE 0x33CCFFAA //light blue
#define COLOR_ORANGE 0xFF9900AA //orange
#define COLOR_GRAD1 0xB4B5B7AA
#define COLOR_GRAD2 0xBFC0C2AA
#define COLOR_GRAD3 0xCBCCCEAA
#define COLOR_GRAD4 0xD8D8D8AA
#define COLOR_GRAD5 0xE3E3E3AA
#define COLOR_GRAD6 0xF0F0F0AA
#define COLOR_INV 0xFFFFFF00

#define COR_VERMELHO                                                            0xFF0000AA
#define COL_BOX																	0x000000EE
#define COL_RED																	0xFF0000FF
#define COR_RED                                                               0xFF0000AA
#define COR_LEMON                                                             0x00FF00FF
#define COR_CINZA_AZUL 															0x456EAF67
#define COR_PRETO 																0x00000000
#define COR_NAO_SEI 															0xFFFFFFFF
#define COR_MAGENTA 															0xA587DE0BA354
#define COR_VERDEMEDIO 															0x9CDE7180
#define COR_VERMELHOCLARO 														0xFF99AADD
#define COR_DARKMAGENTA 														0xA7105DEF
#define COR_LARANJAVERMELHO 													0xE9370DFC
#define COR_DARKVERDE 															0x12900BBF
#define COR_AZULMEDIO 															0x63AFF00A
#define COR_DARKROXO 															0x800080AA
#define COR_MARROMCLARO 														0x99934EFA
#define COR_VIOLETA 															0x9955DEEE
#define COR_CIANOCLARO 															0xAAFFCC33
#define COR_AZULVERDECLARO 														0x0FFDD349
#define COR_OURO 																0xDEAD4370
#define COR_AZULCINZA 															0x456EAF67
#define COR_AZULVERDE 															0x46BBAA00
#define COR_AZULNEUTRO															0xABCDEF01
#define COR_CINZA 																0xAFAFAFAA
#define COR_VERDE 																0x0000FFAA
#define COR_VERMELHO2 															0xFF0000AA
#define COR_AMARELO 															0xFFFF00AA
#define COR_BRANCO 																0xFFFFFFAA
#define COR_ROXO 																0x9900FFAA
#define COR_MARROM 																0x993300AA
#define COR_LARANJA 															0xFF8040
#define COR_CIANO 																0x99FFFFAA
#define COR_AMARELOCLARO 														0xFFFFCCAA
#define COR_ROSA 																0xFF66FFAA
#define COR_BEJE 																0x999900AA
#define COR_LIMA 																0x99FF00AA
#define COR_PRETO2 																0x000000AA
#define COR_TURCA 																0x00A3C0AA
#define COR_GRADE1 																0xB4B5B7FF
#define COR_GRADE2 																0xBFC0C2FF
#define COR_GRADE3 																0xCBCCCEFF
#define COR_GRADE4 																0xD8D8D8FF
#define COR_GRADE5 																0xE3E3E3FF
#define COR_GRADE6 																0xF0F0F0FF
#define COR_VERDECLARO 															0x9ACD32AA
#define COR_AMARELO2 															0xF5DEB3AA
#define COR_FADA1 																0xE6E6E6E6
#define COR_FADA2 																0xC8C8C8C8
#define COR_FADA3 																0xAAAAAAAA
#define COR_FADA4 																0x8C8C8C8C
#define COR_FADA5 																0x6E6E6E6E
#define COR_DARKAZUL 															0x2641FEAA
#define COR_DEPARTE 															0xFF8282AA
#define COR_NOVA 																0xFFA500AA
#define COR_OPACO 																0xE0FFFFAA
#define COR_ADICIONAL 															0x63FF60AA
#define COR_SPIAO 																0xBFC0C200
#define COR_INVISIVEL 															0xAFAFAF00
#define COLOR_REDD 															    0xFF0000AA


#define nitro 1010
#define rodawire 1080
#define suspensao 1087
//======================================================dialogs======================================================
#define COR         1
#define Gangs       2
#define ARMS        3
#define menuarmas   4
#define pistolas    5
#define microsmg    6
#define shotguns    7
#define SMG         8
#define rifle       9
#define assalto     10
#define outras      11
#define tunar       12
#define tunarroda   13
#define tunarcor    14
#define tunarpaint  15               
#define Menugang    16
#define teletuning  17
#define teledrift   18
#define teleaero    19
#define teleoutros  20
#define telesmenu  21
#define sexshops 22
#define clubes 23
#define clubes2 24
#define REGISTRO    25
#define LOGIN   	26
#define AVISO       27
#define Menugame    28
#define timecs      29
//REGISTRO
#define PASTA_CONTAS        "/Contas/%s.ini"         //Diretório onde as contas são salvas
#define MAX_SENHA      		16                      //Tamanho máximo da senha
#define MIN_SENHA      		4                       //Tamanho mínimo da senha
#define TENTATIVAS_LOGIN	3                       //Ao exceder o limite de tentativas, é kickado

enum pInfo
{
	Senha[MAX_SENHA+1],
	Logged,
	LoginsFalsos
}

new PlayerInfo[MAX_PLAYERS][pInfo];
new file[128];
new STRX[256];
//=================================================Velocimetro=================================================
new HGS;

new Text: GostergeYazi[MAX_PLAYERS];
new Text: Cizgi;
new Text: ArkaPlan1;
new Text: ArkaPlan2;
new Text: ArkaPlan3;
new Text: ArkaPlan4;
new Text: ArkaPlan5;

new Float: KMH;
new Float: Xa;
new Float: Ya;
new Float: Za;
new Float: Xb[MAX_PLAYERS];
new Float: Yb[MAX_PLAYERS];
new Float: Zb[MAX_PLAYERS];

new ArIsim[][] = // Not made by me
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
//=================================================Velocimetro=================================================
new SVNAMES[2][256] = {
"RPG: 189.1.172.58:7778",
"The Crimes Brasil • Mata-Mata v1.0"
};
new MSGs[8][256] = {
"Obrigado por ter escolido nosso Servidor.",
"Não use Cheats/Hacks.",
"Adicione nosso Servidor nos Favoritos! ",
"Utilize /tunar Para Tunar Seu Carro",
"Utilize /Beco Para Ver Gangs e Armas",
"Utilize /cores Para Altera Sua Cor",
"Utilize /contar Para Iniciar Uma Contagem",
"Utilize /armas Para Pegar Um Kit De Armas"
};
//GPS
new Text:gps[MAX_PLAYERS];
enum GPSInfo
{
        zone_name[30],
    Float:zone_minx,
    Float:zone_miny,
    Float:zone_minz,
    Float:zone_maxx,
    Float:zone_maxy,
    Float:zone_maxz
}

new Float:Zones[][GPSInfo] = {
{ "'The Big Ear'",                -410.00,  1403.30,    -3.00,  -137.90,  1681.20,   200.00},
{ "Aldea Malvada",               -1372.10,  2498.50,     0.00, -1277.50,  2615.30,   200.00},
{ "Angel Pine",                  -2324.90, -2584.20,    -6.10, -1964.20, -2212.10,   200.00},
{ "Arco del Oeste",               -901.10,  2221.80,     0.00,  -592.00,  2571.90,   200.00},
{ "Avispa Country Club",         -2646.40,  -355.40,     0.00, -2270.00,  -222.50,   200.00},
{ "Avispa Country Club",         -2831.80,  -430.20,    -6.10, -2646.40,  -222.50,   200.00},
{ "Avispa Country Club",         -2361.50,  -417.10,     0.00, -2270.00,  -355.40,   200.00},
{ "Avispa Country Club",         -2667.80,  -302.10,   -28.80, -2646.40,  -262.30,    71.10},
{ "Avispa Country Club",         -2470.00,  -355.40,     0.00, -2270.00,  -318.40,    46.10},
{ "Avispa Country Club",         -2550.00,  -355.40,     0.00, -2470.00,  -318.40,    39.70},
{ "Back o Beyond",               -1166.90, -2641.10,     0.00,  -321.70, -1856.00,   200.00},
{ "Battery Point",               -2741.00,  1268.40,    -4.50, -2533.00,  1490.40,   200.00},
{ "Bayside",                     -2741.00,  2175.10,     0.00, -2353.10,  2722.70,   200.00},
{ "Bayside Marina",              -2353.10,  2275.70,     0.00, -2153.10,  2475.70,   200.00},
{ "Beacon Hill",                  -399.60, -1075.50,    -1.40,  -319.00,  -977.50,   198.50},
{ "Blackfield",                    964.30,  1203.20,   -89.00,  1197.30,  1403.20,   110.90},
{ "Blackfield",                    964.30,  1403.20,   -89.00,  1197.30,  1726.20,   110.90},
{ "Blackfield Chapel",            1375.60,   596.30,   -89.00,  1558.00,   823.20,   110.90},
{ "Blackfield Chapel",            1325.60,   596.30,   -89.00,  1375.60,   795.00,   110.90},
{ "Blackfield Intersection",      1197.30,  1044.60,   -89.00,  1277.00,  1163.30,   110.90},
{ "Blackfield Intersection",      1166.50,   795.00,   -89.00,  1375.60,  1044.60,   110.90},
{ "Blackfield Intersection",      1277.00,  1044.60,   -89.00,  1315.30,  1087.60,   110.90},
{ "Blackfield Intersection",      1375.60,   823.20,   -89.00,  1457.30,   919.40,   110.90},
{ "Blueberry",                     104.50,  -220.10,     2.30,   349.60,   152.20,   200.00},
{ "Blueberry",                      19.60,  -404.10,     3.80,   349.60,  -220.10,   200.00},
{ "Blueberry Acres",              -319.60,  -220.10,     0.00,   104.50,   293.30,   200.00},
{ "Caligula's Palace",            2087.30,  1543.20,   -89.00,  2437.30,  1703.20,   110.90},
{ "Caligula's Palace",            2137.40,  1703.20,   -89.00,  2437.30,  1783.20,   110.90},
{ "Calton Heights",              -2274.10,   744.10,    -6.10, -1982.30,  1358.90,   200.00},
{ "Chinatown",                   -2274.10,   578.30,    -7.60, -2078.60,   744.10,   200.00},
{ "City Hall",                   -2867.80,   277.40,    -9.10, -2593.40,   458.40,   200.00},
{ "Come-A-Lot",                   2087.30,   943.20,   -89.00,  2623.10,  1203.20,   110.90},
{ "Commerce",                     1323.90, -1842.20,   -89.00,  1701.90, -1722.20,   110.90},
{ "Commerce",                     1323.90, -1722.20,   -89.00,  1440.90, -1577.50,   110.90},
{ "Commerce",                     1370.80, -1577.50,   -89.00,  1463.90, -1384.90,   110.90},
{ "Commerce",                     1463.90, -1577.50,   -89.00,  1667.90, -1430.80,   110.90},
{ "Commerce",                     1583.50, -1722.20,   -89.00,  1758.90, -1577.50,   110.90},
{ "Commerce",                     1667.90, -1577.50,   -89.00,  1812.60, -1430.80,   110.90},
{ "Conference Center",            1046.10, -1804.20,   -89.00,  1323.90, -1722.20,   110.90},
{ "Conference Center",            1073.20, -1842.20,   -89.00,  1323.90, -1804.20,   110.90},
{ "Cranberry Station",           -2007.80,    56.30,     0.00, -1922.00,   224.70,   100.00},
{ "Creek",                        2749.90,  1937.20,   -89.00,  2921.60,  2669.70,   110.90},
{ "Dillimore",                     580.70,  -674.80,    -9.50,   861.00,  -404.70,   200.00},
{ "Doherty",                     -2270.00,  -324.10,    -0.00, -1794.90,  -222.50,   200.00},
{ "Doherty",                     -2173.00,  -222.50,    -0.00, -1794.90,   265.20,   200.00},
{ "Downtown",                    -1982.30,   744.10,    -6.10, -1871.70,  1274.20,   200.00},
{ "Downtown",                    -1871.70,  1176.40,    -4.50, -1620.30,  1274.20,   200.00},
{ "Downtown",                    -1700.00,   744.20,    -6.10, -1580.00,  1176.50,   200.00},
{ "Downtown",                    -1580.00,   744.20,    -6.10, -1499.80,  1025.90,   200.00},
{ "Downtown",                    -2078.60,   578.30,    -7.60, -1499.80,   744.20,   200.00},
{ "Downtown",                    -1993.20,   265.20,    -9.10, -1794.90,   578.30,   200.00},
{ "Downtown Los Santos",          1463.90, -1430.80,   -89.00,  1724.70, -1290.80,   110.90},
{ "Downtown Los Santos",          1724.70, -1430.80,   -89.00,  1812.60, -1250.90,   110.90},
{ "Downtown Los Santos",          1463.90, -1290.80,   -89.00,  1724.70, -1150.80,   110.90},
{ "Downtown Los Santos",          1370.80, -1384.90,   -89.00,  1463.90, -1170.80,   110.90},
{ "Downtown Los Santos",          1724.70, -1250.90,   -89.00,  1812.60, -1150.80,   110.90},
{ "Downtown Los Santos",          1370.80, -1170.80,   -89.00,  1463.90, -1130.80,   110.90},
{ "Downtown Los Santos",          1378.30, -1130.80,   -89.00,  1463.90, -1026.30,   110.90},
{ "Downtown Los Santos",          1391.00, -1026.30,   -89.00,  1463.90,  -926.90,   110.90},
{ "Downtown Los Santos",          1507.50, -1385.20,   110.90,  1582.50, -1325.30,   335.90},
{ "East Beach",                   2632.80, -1852.80,   -89.00,  2959.30, -1668.10,   110.90},
{ "East Beach",                   2632.80, -1668.10,   -89.00,  2747.70, -1393.40,   110.90},
{ "East Beach",                   2747.70, -1668.10,   -89.00,  2959.30, -1498.60,   110.90},
{ "East Beach",                   2747.70, -1498.60,   -89.00,  2959.30, -1120.00,   110.90},
{ "East Los Santos",              2421.00, -1628.50,   -89.00,  2632.80, -1454.30,   110.90},
{ "East Los Santos",              2222.50, -1628.50,   -89.00,  2421.00, -1494.00,   110.90},
{ "East Los Santos",              2266.20, -1494.00,   -89.00,  2381.60, -1372.00,   110.90},
{ "East Los Santos",              2381.60, -1494.00,   -89.00,  2421.00, -1454.30,   110.90},
{ "East Los Santos",              2281.40, -1372.00,   -89.00,  2381.60, -1135.00,   110.90},
{ "East Los Santos",              2381.60, -1454.30,   -89.00,  2462.10, -1135.00,   110.90},
{ "East Los Santos",              2462.10, -1454.30,   -89.00,  2581.70, -1135.00,   110.90},
{ "Easter Basin",                -1794.90,   249.90,    -9.10, -1242.90,   578.30,   200.00},
{ "Easter Basin",                -1794.90,   -50.00,    -0.00, -1499.80,   249.90,   200.00},
{ "Aeroporto de Easter Bay",          -1499.80,   -50.00,    -0.00, -1242.90,   249.90,   200.00},
{ "Aeroporto de Easter Bay",          -1794.90,  -730.10,    -3.00, -1213.90,   -50.00,   200.00},
{ "Aeroporto de Easter Bay",          -1213.90,  -730.10,     0.00, -1132.80,   -50.00,   200.00},
{ "Aeroporto de Easter Bay",          -1242.90,   -50.00,     0.00, -1213.90,   578.30,   200.00},
{ "Aeroporto de Easter Bay",          -1213.90,   -50.00,    -4.50,  -947.90,   578.30,   200.00},
{ "Aeroporto de Easter Bay",          -1315.40,  -405.30,    15.40, -1264.40,  -209.50,    25.40},
{ "Aeroporto de Easter Bay",          -1354.30,  -287.30,    15.40, -1315.40,  -209.50,    25.40},
{ "Aeroporto de Easter Bay",          -1490.30,  -209.50,    15.40, -1264.40,  -148.30,    25.40},
{ "Easter Bay Chemicals",        -1132.80,  -768.00,     0.00,  -956.40,  -578.10,   200.00},
{ "Easter Bay Chemicals",        -1132.80,  -787.30,     0.00,  -956.40,  -768.00,   200.00},
{ "El Castillo del Diablo",       -464.50,  2217.60,     0.00,  -208.50,  2580.30,   200.00},
{ "El Castillo del Diablo",       -208.50,  2123.00,    -7.60,   114.00,  2337.10,   200.00},
{ "El Castillo del Diablo",       -208.50,  2337.10,     0.00,     8.40,  2487.10,   200.00},
{ "El Corona",                    1812.60, -2179.20,   -89.00,  1970.60, -1852.80,   110.90},
{ "El Corona",                    1692.60, -2179.20,   -89.00,  1812.60, -1842.20,   110.90},
{ "El Quebrados",                -1645.20,  2498.50,     0.00, -1372.10,  2777.80,   200.00},
{ "Esplanade East",              -1620.30,  1176.50,    -4.50, -1580.00,  1274.20,   200.00},
{ "Esplanade East",              -1580.00,  1025.90,    -6.10, -1499.80,  1274.20,   200.00},
{ "Esplanade East",              -1499.80,   578.30,   -79.60, -1339.80,  1274.20,    20.30},
{ "Esplanade North",             -2533.00,  1358.90,    -4.50, -1996.60,  1501.20,   200.00},
{ "Esplanade North",             -1996.60,  1358.90,    -4.50, -1524.20,  1592.50,   200.00},
{ "Esplanade North",             -1982.30,  1274.20,    -4.50, -1524.20,  1358.90,   200.00},
{ "Fallen Tree",                  -792.20,  -698.50,    -5.30,  -452.40,  -380.00,   200.00},
{ "Fallow Bridge",                 434.30,   366.50,     0.00,   603.00,   555.60,   200.00},
{ "Fern Ridge",                    508.10,  -139.20,     0.00,  1306.60,   119.50,   200.00},
{ "Financial",                   -1871.70,   744.10,    -6.10, -1701.30,  1176.40,   300.00},
{ "Fisher's Lagoon",              1916.90,  -233.30,  -100.00,  2131.70,    13.80,   200.00},
{ "Flint Intersection",           -187.70, -1596.70,   -89.00,    17.00, -1276.60,   110.90},
{ "Flint Range",                  -594.10, -1648.50,     0.00,  -187.70, -1276.60,   200.00},
{ "Fort Carson",                  -376.20,   826.30,    -3.00,   123.70,  1220.40,   200.00},
{ "Foster Valley",               -2270.00,  -430.20,    -0.00, -2178.60,  -324.10,   200.00},
{ "Foster Valley",               -2178.60,  -599.80,    -0.00, -1794.90,  -324.10,   200.00},
{ "Foster Valley",               -2178.60, -1115.50,     0.00, -1794.90,  -599.80,   200.00},
{ "Foster Valley",               -2178.60, -1250.90,     0.00, -1794.90, -1115.50,   200.00},
{ "Frederick Bridge",             2759.20,   296.50,     0.00,  2774.20,   594.70,   200.00},
{ "Gant Bridge",                 -2741.40,  1659.60,    -6.10, -2616.40,  2175.10,   200.00},
{ "Gant Bridge",                 -2741.00,  1490.40,    -6.10, -2616.40,  1659.60,   200.00},
{ "Ganton",                       2222.50, -1852.80,   -89.00,  2632.80, -1722.30,   110.90},
{ "Ganton",                       2222.50, -1722.30,   -89.00,  2632.80, -1628.50,   110.90},
{ "Garcia",                      -2411.20,  -222.50,    -0.00, -2173.00,   265.20,   200.00},
{ "Garcia",                      -2395.10,  -222.50,    -5.30, -2354.00,  -204.70,   200.00},
{ "Garver Bridge",               -1339.80,   828.10,   -89.00, -1213.90,  1057.00,   110.90},
{ "~yGarver Bridge",               -1213.90,   950.00,   -89.00, -1087.90,  1178.90,   110.90},
{ "Garver Bridge",               -1499.80,   696.40,  -179.60, -1339.80,   925.30,    20.30},
{ "Parque Glen",                    1812.60, -1449.60,   -89.00,  1996.90, -1350.70,   110.90},
{ "Parque Glen",                    1812.60, -1100.80,   -89.00,  1994.30,  -973.30,   110.90},
{ "Parque Glen",                    1812.60, -1350.70,   -89.00,  2056.80, -1100.80,   110.90},
{ "Green Palms",                   176.50,  1305.40,    -3.00,   338.60,  1520.70,   200.00},
{ "Greenglass College",            964.30,  1044.60,   -89.00,  1197.30,  1203.20,   110.90},
{ "Greenglass College",            964.30,   930.80,   -89.00,  1166.50,  1044.60,   110.90},
{ "Hampton Barns",                 603.00,   264.30,     0.00,   761.90,   366.50,   200.00},
{ "Hankypanky Point",             2576.90,    62.10,     0.00,  2759.20,   385.50,   200.00},
{ "Harry Gold Parkway",           1777.30,   863.20,   -89.00,  1817.30,  2342.80,   110.90},
{ "Hashbury",                    -2593.40,  -222.50,    -0.00, -2411.20,    54.70,   200.00},
{ "Hilltop Farm",                  967.30,  -450.30,    -3.00,  1176.70,  -217.90,   200.00},
{ "Hunter Quarry",                 337.20,   710.80,  -115.20,   860.50,  1031.70,   203.70},
{ "Idlewood",                     1812.60, -1852.80,   -89.00,  1971.60, -1742.30,   110.90},
{ "Idlewood",                     1812.60, -1742.30,   -89.00,  1951.60, -1602.30,   110.90},
{ "Idlewood",                     1951.60, -1742.30,   -89.00,  2124.60, -1602.30,   110.90},
{ "Idlewood",                     1812.60, -1602.30,   -89.00,  2124.60, -1449.60,   110.90},
{ "Idlewood",                     2124.60, -1742.30,   -89.00,  2222.50, -1494.00,   110.90},
{ "Idlewood",                     1971.60, -1852.80,   -89.00,  2222.50, -1742.30,   110.90},
{ "Jefferson",                    1996.90, -1449.60,   -89.00,  2056.80, -1350.70,   110.90},
{ "Jefferson",                    2124.60, -1494.00,   -89.00,  2266.20, -1449.60,   110.90},
{ "Jefferson",                    2056.80, -1372.00,   -89.00,  2281.40, -1210.70,   110.90},
{ "Jefferson",                    2056.80, -1210.70,   -89.00,  2185.30, -1126.30,   110.90},
{ "Jefferson",                    2185.30, -1210.70,   -89.00,  2281.40, -1154.50,   110.90},
{ "Jefferson",                    2056.80, -1449.60,   -89.00,  2266.20, -1372.00,   110.90},
{ "Julius Thruway East",          2623.10,   943.20,   -89.00,  2749.90,  1055.90,   110.90},
{ "Julius Thruway East",          2685.10,  1055.90,   -89.00,  2749.90,  2626.50,   110.90},
{ "Julius Thruway East",          2536.40,  2442.50,   -89.00,  2685.10,  2542.50,   110.90},
{ "Julius Thruway East",          2625.10,  2202.70,   -89.00,  2685.10,  2442.50,   110.90},
{ "Julius Thruway North",         2498.20,  2542.50,   -89.00,  2685.10,  2626.50,   110.90},
{ "Julius Thruway North",         2237.40,  2542.50,   -89.00,  2498.20,  2663.10,   110.90},
{ "Julius Thruway North",         2121.40,  2508.20,   -89.00,  2237.40,  2663.10,   110.90},
{ "Julius Thruway North",         1938.80,  2508.20,   -89.00,  2121.40,  2624.20,   110.90},
{ "Julius Thruway North",         1534.50,  2433.20,   -89.00,  1848.40,  2583.20,   110.90},
{ "Julius Thruway North",         1848.40,  2478.40,   -89.00,  1938.80,  2553.40,   110.90},
{ "Julius Thruway North",         1704.50,  2342.80,   -89.00,  1848.40,  2433.20,   110.90},
{ "Julius Thruway North",         1377.30,  2433.20,   -89.00,  1534.50,  2507.20,   110.90},
{ "Julius Thruway South",         1457.30,   823.20,   -89.00,  2377.30,   863.20,   110.90},
{ "Julius Thruway South",         2377.30,   788.80,   -89.00,  2537.30,   897.90,   110.90},
{ "Julius Thruway West",          1197.30,  1163.30,   -89.00,  1236.60,  2243.20,   110.90},
{ "Julius Thruway West",          1236.60,  2142.80,   -89.00,  1297.40,  2243.20,   110.90},
{ "Juniper Hill",                -2533.00,   578.30,    -7.60, -2274.10,   968.30,   200.00},
{ "Juniper Hollow",              -2533.00,   968.30,    -6.10, -2274.10,  1358.90,   200.00},
{ "K.A.C.C. Military Fuels",      2498.20,  2626.50,   -89.00,  2749.90,  2861.50,   110.90},
{ "Kincaid Bridge",              -1339.80,   599.20,   -89.00, -1213.90,   828.10,   110.90},
{ "Kincaid Bridge",              -1213.90,   721.10,   -89.00, -1087.90,   950.00,   110.90},
{ "Kincaid Bridge",              -1087.90,   855.30,   -89.00,  -961.90,   986.20,   110.90},
{ "King's",                      -2329.30,   458.40,    -7.60, -1993.20,   578.30,   200.00},
{ "King's",                      -2411.20,   265.20,    -9.10, -1993.20,   373.50,   200.00},
{ "King's",                      -2253.50,   373.50,    -9.10, -1993.20,   458.40,   200.00},
{ "LVA Freight Depot",            1457.30,   863.20,   -89.00,  1777.40,  1143.20,   110.90},
{ "LVA Freight Depot",            1375.60,   919.40,   -89.00,  1457.30,  1203.20,   110.90},
{ "LVA Freight Depot",            1277.00,  1087.60,   -89.00,  1375.60,  1203.20,   110.90},
{ "LVA Freight Depot",            1315.30,  1044.60,   -89.00,  1375.60,  1087.60,   110.90},
{ "LVA Freight Depot",            1236.60,  1163.40,   -89.00,  1277.00,  1203.20,   110.90},
{ "Las Barrancas",                -926.10,  1398.70,    -3.00,  -719.20,  1634.60,   200.00},
{ "Las Brujas",                   -365.10,  2123.00,    -3.00,  -208.50,  2217.60,   200.00},
{ "Las Colinas",                  1994.30, -1100.80,   -89.00,  2056.80,  -920.80,   110.90},
{ "Las Colinas",                  2056.80, -1126.30,   -89.00,  2126.80,  -920.80,   110.90},
{ "Las Colinas",                  2185.30, -1154.50,   -89.00,  2281.40,  -934.40,   110.90},
{ "Las Colinas",                  2126.80, -1126.30,   -89.00,  2185.30,  -934.40,   110.90},
{ "Las Colinas",                  2747.70, -1120.00,   -89.00,  2959.30,  -945.00,   110.90},
{ "Las Colinas",                  2632.70, -1135.00,   -89.00,  2747.70,  -945.00,   110.90},
{ "Las Colinas",                  2281.40, -1135.00,   -89.00,  2632.70,  -945.00,   110.90},
{ "Las Payasadas",                -354.30,  2580.30,     2.00,  -133.60,  2816.80,   200.00},
{ "Aeroporto de Las Venturas",         1236.60,  1203.20,   -89.00,  1457.30,  1883.10,   110.90},
{ "Aeroporto de Las Venturas",         1457.30,  1203.20,   -89.00,  1777.30,  1883.10,   110.90},
{ "Aeroporto de Las Venturas",         1457.30,  1143.20,   -89.00,  1777.40,  1203.20,   110.90},
{ "Aeroporto de Las Venturas",         1515.80,  1586.40,   -12.50,  1729.90,  1714.50,    87.50},
{ "Last Dime Motel",              1823.00,   596.30,   -89.00,  1997.20,   823.20,   110.90},
{ "Leafy Hollow",                -1166.90, -1856.00,     0.00,  -815.60, -1602.00,   200.00},
{ "Lil' Probe Inn",                -90.20,  1286.80,    -3.00,   153.80,  1554.10,   200.00},
{ "Linden Side",                  2749.90,   943.20,   -89.00,  2923.30,  1198.90,   110.90},
{ "Linden Station",               2749.90,  1198.90,   -89.00,  2923.30,  1548.90,   110.90},
{ "Linden Station",               2811.20,  1229.50,   -39.50,  2861.20,  1407.50,    60.40},
{ "Little Mexico",                1701.90, -1842.20,   -89.00,  1812.60, -1722.20,   110.90},
{ "Little Mexico",                1758.90, -1722.20,   -89.00,  1812.60, -1577.50,   110.90},
{ "Los Flores",                   2581.70, -1454.30,   -89.00,  2632.80, -1393.40,   110.90},
{ "Los Flores",                   2581.70, -1393.40,   -89.00,  2747.70, -1135.00,   110.90},
{ "Aeroporto de Los Santos",     1249.60, -2394.30,   -89.00,  1852.00, -2179.20,   110.90},
{ "Aeroporto de Los Santos",     1852.00, -2394.30,   -89.00,  2089.00, -2179.20,   110.90},
{ "Aeroporto de Los Santos",     1382.70, -2730.80,   -89.00,  2201.80, -2394.30,   110.90},
{ "Aeroporto de Los Santos",     1974.60, -2394.30,   -39.00,  2089.00, -2256.50,    60.90},
{ "Aeroporto de Los Santos",     1400.90, -2669.20,   -39.00,  2189.80, -2597.20,    60.90},
{ "Aeroporto de Los Santos",     2051.60, -2597.20,   -39.00,  2152.40, -2394.30,    60.90},
{ "Marina",                        647.70, -1804.20,   -89.00,   851.40, -1577.50,   110.90},
{ "Marina",                        647.70, -1577.50,   -89.00,   807.90, -1416.20,   110.90},
{ "Marina",                        807.90, -1577.50,   -89.00,   926.90, -1416.20,   110.90},
{ "Market",                        787.40, -1416.20,   -89.00,  1072.60, -1310.20,   110.90},
{ "Market",                        952.60, -1310.20,   -89.00,  1072.60, -1130.80,   110.90},
{ "Market",                       1072.60, -1416.20,   -89.00,  1370.80, -1130.80,   110.90},
{ "Market",                        926.90, -1577.50,   -89.00,  1370.80, -1416.20,   110.90},
{ "Market Station",                787.40, -1410.90,   -34.10,   866.00, -1310.20,    65.80},
{ "Martin Bridge",                -222.10,   293.30,     0.00,  -122.10,   476.40,   200.00},
{ "Missionary Hill",             -2994.40,  -811.20,     0.00, -2178.60,  -430.20,   200.00},
{ "Montgomery",                   1119.50,   119.50,    -3.00,  1451.40,   493.30,   200.00},
{ "Montgomery",                   1451.40,   347.40,    -6.10,  1582.40,   420.80,   200.00},
{ "Montgomery Intersection",      1546.60,   208.10,     0.00,  1745.80,   347.40,   200.00},
{ "Montgomery Intersection",      1582.40,   347.40,     0.00,  1664.60,   401.70,   200.00},
{ "Mulholland",                   1414.00,  -768.00,   -89.00,  1667.60,  -452.40,   110.90},
{ "Mulholland",                   1281.10,  -452.40,   -89.00,  1641.10,  -290.90,   110.90},
{ "Mulholland",                   1269.10,  -768.00,   -89.00,  1414.00,  -452.40,   110.90},
{ "Mulholland",                   1357.00,  -926.90,   -89.00,  1463.90,  -768.00,   110.90},
{ "Mulholland",                   1318.10,  -910.10,   -89.00,  1357.00,  -768.00,   110.90},
{ "Mulholland",                   1169.10,  -910.10,   -89.00,  1318.10,  -768.00,   110.90},
{ "Mulholland",                    768.60,  -954.60,   -89.00,   952.60,  -860.60,   110.90},
{ "Mulholland",                    687.80,  -860.60,   -89.00,   911.80,  -768.00,   110.90},
{ "Mulholland",                    737.50,  -768.00,   -89.00,  1142.20,  -674.80,   110.90},
{ "Mulholland",                   1096.40,  -910.10,   -89.00,  1169.10,  -768.00,   110.90},
{ "Mulholland",                    952.60,  -937.10,   -89.00,  1096.40,  -860.60,   110.90},
{ "Mulholland",                    911.80,  -860.60,   -89.00,  1096.40,  -768.00,   110.90},
{ "Mulholland",                    861.00,  -674.80,   -89.00,  1156.50,  -600.80,   110.90},
{ "Mulholland Intersection",      1463.90, -1150.80,   -89.00,  1812.60,  -768.00,   110.90},
{ "North Rock",                   2285.30,  -768.00,     0.00,  2770.50,  -269.70,   200.00},
{ "Ocean Docks",                  2373.70, -2697.00,   -89.00,  2809.20, -2330.40,   110.90},
{ "Ocean Docks",                  2201.80, -2418.30,   -89.00,  2324.00, -2095.00,   110.90},
{ "Ocean Docks",                  2324.00, -2302.30,   -89.00,  2703.50, -2145.10,   110.90},
{ "Ocean Docks",                  2089.00, -2394.30,   -89.00,  2201.80, -2235.80,   110.90},
{ "Ocean Docks",                  2201.80, -2730.80,   -89.00,  2324.00, -2418.30,   110.90},
{ "Ocean Docks",                  2703.50, -2302.30,   -89.00,  2959.30, -2126.90,   110.90},
{ "Ocean Docks",                  2324.00, -2145.10,   -89.00,  2703.50, -2059.20,   110.90},
{ "Ocean Flats",                 -2994.40,   277.40,    -9.10, -2867.80,   458.40,   200.00},
{ "Ocean Flats",                 -2994.40,  -222.50,    -0.00, -2593.40,   277.40,   200.00},
{ "Ocean Flats",                 -2994.40,  -430.20,    -0.00, -2831.80,  -222.50,   200.00},
{ "Octane Springs",                338.60,  1228.50,     0.00,   664.30,  1655.00,   200.00},
{ "Old Venturas Strip",           2162.30,  2012.10,   -89.00,  2685.10,  2202.70,   110.90},
{ "Palisades",                   -2994.40,   458.40,    -6.10, -2741.00,  1339.60,   200.00},
{ "Palomino Creek",               2160.20,  -149.00,     0.00,  2576.90,   228.30,   200.00},
{ "Paradiso",                    -2741.00,   793.40,    -6.10, -2533.00,  1268.40,   200.00},
{ "Pershing Square",              1440.90, -1722.20,   -89.00,  1583.50, -1577.50,   110.90},
{ "Pilgrim",                      2437.30,  1383.20,   -89.00,  2624.40,  1783.20,   110.90},
{ "Pilgrim",                      2624.40,  1383.20,   -89.00,  2685.10,  1783.20,   110.90},
{ "Pilson Intersection",          1098.30,  2243.20,   -89.00,  1377.30,  2507.20,   110.90},
{ "Pirates in Men's Pants",       1817.30,  1469.20,   -89.00,  2027.40,  1703.20,   110.90},
{ "Playa del Seville",            2703.50, -2126.90,   -89.00,  2959.30, -1852.80,   110.90},
{ "Prickle Pine",                 1534.50,  2583.20,   -89.00,  1848.40,  2863.20,   110.90},
{ "Prickle Pine",                 1117.40,  2507.20,   -89.00,  1534.50,  2723.20,   110.90},
{ "Prickle Pine",                 1848.40,  2553.40,   -89.00,  1938.80,  2863.20,   110.90},
{ "Prickle Pine",                 1938.80,  2624.20,   -89.00,  2121.40,  2861.50,   110.90},
{ "Queens",                      -2533.00,   458.40,     0.00, -2329.30,   578.30,   200.00},
{ "Queens",                      -2593.40,    54.70,     0.00, -2411.20,   458.40,   200.00},
{ "Queens",                      -2411.20,   373.50,     0.00, -2253.50,   458.40,   200.00},
{ "Randolph Industrial Estate",   1558.00,   596.30,   -89.00,  1823.00,   823.20,   110.90},
{ "Redsands East",                1817.30,  2011.80,   -89.00,  2106.70,  2202.70,   110.90},
{ "Redsands East",                1817.30,  2202.70,   -89.00,  2011.90,  2342.80,   110.90},
{ "Redsands East",                1848.40,  2342.80,   -89.00,  2011.90,  2478.40,   110.90},
{ "Redsands West",                1236.60,  1883.10,   -89.00,  1777.30,  2142.80,   110.90},
{ "Redsands West",                1297.40,  2142.80,   -89.00,  1777.30,  2243.20,   110.90},
{ "Redsands West",                1377.30,  2243.20,   -89.00,  1704.50,  2433.20,   110.90},
{ "Redsands West",                1704.50,  2243.20,   -89.00,  1777.30,  2342.80,   110.90},
{ "Regular Tom",                  -405.70,  1712.80,    -3.00,  -276.70,  1892.70,   200.00},
{ "Richman",                       647.50, -1118.20,   -89.00,   787.40,  -954.60,   110.90},
{ "Richman",                       647.50,  -954.60,   -89.00,   768.60,  -860.60,   110.90},
{ "Richman",                       225.10, -1369.60,   -89.00,   334.50, -1292.00,   110.90},
{ "Richman",                       225.10, -1292.00,   -89.00,   466.20, -1235.00,   110.90},
{ "Richman",                        72.60, -1404.90,   -89.00,   225.10, -1235.00,   110.90},
{ "Richman",                        72.60, -1235.00,   -89.00,   321.30, -1008.10,   110.90},
{ "Richman",                       321.30, -1235.00,   -89.00,   647.50, -1044.00,   110.90},
{ "Richman",                       321.30, -1044.00,   -89.00,   647.50,  -860.60,   110.90},
{ "Richman",                       321.30,  -860.60,   -89.00,   687.80,  -768.00,   110.90},
{ "Richman",                       321.30,  -768.00,   -89.00,   700.70,  -674.80,   110.90},
{ "Robada Intersection",         -1119.00,  1178.90,   -89.00,  -862.00,  1351.40,   110.90},
{ "Roca Escalante",               2237.40,  2202.70,   -89.00,  2536.40,  2542.50,   110.90},
{ "Roca Escalante",               2536.40,  2202.70,   -89.00,  2625.10,  2442.50,   110.90},
{ "Rockshore East",               2537.30,   676.50,   -89.00,  2902.30,   943.20,   110.90},
{ "Rockshore West",               1997.20,   596.30,   -89.00,  2377.30,   823.20,   110.90},
{ "Rockshore West",               2377.30,   596.30,   -89.00,  2537.30,   788.80,   110.90},
{ "Rodeo",                          72.60, -1684.60,   -89.00,   225.10, -1544.10,   110.90},
{ "Rodeo",                          72.60, -1544.10,   -89.00,   225.10, -1404.90,   110.90},
{ "Rodeo",                         225.10, -1684.60,   -89.00,   312.80, -1501.90,   110.90},
{ "Rodeo",                         225.10, -1501.90,   -89.00,   334.50, -1369.60,   110.90},
{ "Rodeo",                         334.50, -1501.90,   -89.00,   422.60, -1406.00,   110.90},
{ "Rodeo",                         312.80, -1684.60,   -89.00,   422.60, -1501.90,   110.90},
{ "Rodeo",                         422.60, -1684.60,   -89.00,   558.00, -1570.20,   110.90},
{ "Rodeo",                         558.00, -1684.60,   -89.00,   647.50, -1384.90,   110.90},
{ "Rodeo",                         466.20, -1570.20,   -89.00,   558.00, -1385.00,   110.90},
{ "Rodeo",                         422.60, -1570.20,   -89.00,   466.20, -1406.00,   110.90},
{ "Rodeo",                         466.20, -1385.00,   -89.00,   647.50, -1235.00,   110.90},
{ "Rodeo",                         334.50, -1406.00,   -89.00,   466.20, -1292.00,   110.90},
{ "Royal Cassino",                 2087.30,  1383.20,   -89.00,  2437.30,  1543.20,   110.90},
{ "San Andreas Sound",            2450.30,   385.50,  -100.00,  2759.20,   562.30,   200.00},
{ "Santa Flora",                 -2741.00,   458.40,    -7.60, -2533.00,   793.40,   200.00},
{ "Praia de Santa Maria",             342.60, -2173.20,   -89.00,   647.70, -1684.60,   110.90},
{ "Praia de Santa Maria",              72.60, -2173.20,   -89.00,   342.60, -1684.60,   110.90},
{ "Shady Cabin",                 -1632.80, -2263.40,    -3.00, -1601.30, -2231.70,   200.00},
{ "Shady Creeks",                -1820.60, -2643.60,    -8.00, -1226.70, -1771.60,   200.00},
{ "Shady Creeks",                -2030.10, -2174.80,    -6.10, -1820.60, -1771.60,   200.00},
{ "Sobell Rail Yards",            2749.90,  1548.90,   -89.00,  2923.30,  1937.20,   110.90},
{ "Spinybed",                     2121.40,  2663.10,   -89.00,  2498.20,  2861.50,   110.90},
{ "Starfish Cassino",              2437.30,  1783.20,   -89.00,  2685.10,  2012.10,   110.90},
{ "Starfish Cassino",              2437.30,  1858.10,   -39.00,  2495.00,  1970.80,    60.90},
{ "Starfish Cassino",              2162.30,  1883.20,   -89.00,  2437.30,  2012.10,   110.90},
{ "Temple",                       1252.30, -1130.80,   -89.00,  1378.30, -1026.30,   110.90},
{ "Temple",                       1252.30, -1026.30,   -89.00,  1391.00,  -926.90,   110.90},
{ "Temple",                       1252.30,  -926.90,   -89.00,  1357.00,  -910.10,   110.90},
{ "Temple",                        952.60, -1130.80,   -89.00,  1096.40,  -937.10,   110.90},
{ "Temple",                       1096.40, -1130.80,   -89.00,  1252.30, -1026.30,   110.90},
{ "Temple",                       1096.40, -1026.30,   -89.00,  1252.30,  -910.10,   110.90},
{ "The Camel's Toe",              2087.30,  1203.20,   -89.00,  2640.40,  1383.20,   110.90},
{ "The Clown's Pocket",           2162.30,  1783.20,   -89.00,  2437.30,  1883.20,   110.90},
{ "The Emerald Isle",             2011.90,  2202.70,   -89.00,  2237.40,  2508.20,   110.90},
{ "Fazenda do Guh e do Xeh",      -1209.60, -1317.10,   114.90,  -908.10,  -787.30,   251.90},
{ "The Four Dragons Casino",      1817.30,   863.20,   -89.00,  2027.30,  1083.20,   110.90},
{ "The High Roller",              1817.30,  1283.20,   -89.00,  2027.30,  1469.20,   110.90},
{ "The Mako Span",                1664.60,   401.70,     0.00,  1785.10,   567.20,   200.00},
{ "The Panopticon",               -947.90,  -304.30,    -1.10,  -319.60,   327.00,   200.00},
{ "The Pink Swan",                1817.30,  1083.20,   -89.00,  2027.30,  1283.20,   110.90},
{ "The Sherman Dam",              -968.70,  1929.40,    -3.00,  -481.10,  2155.20,   200.00},
{ "The Strip",                    2027.40,   863.20,   -89.00,  2087.30,  1703.20,   110.90},
{ "The Strip",                    2106.70,  1863.20,   -89.00,  2162.30,  2202.70,   110.90},
{ "The Strip",                    2027.40,  1783.20,   -89.00,  2162.30,  1863.20,   110.90},
{ "The Strip",                    2027.40,  1703.20,   -89.00,  2137.40,  1783.20,   110.90},
{ "The Visage",                   1817.30,  1863.20,   -89.00,  2106.70,  2011.80,   110.90},
{ "The Visage",                   1817.30,  1703.20,   -89.00,  2027.40,  1863.20,   110.90},
{ "Unity Station",                1692.60, -1971.80,   -20.40,  1812.60, -1932.80,    79.50},
{ "Valle Ocultado",               -936.60,  2611.40,     2.00,  -715.90,  2847.90,   200.00},
{ "Verdant Bluffs",                930.20, -2488.40,   -89.00,  1249.60, -2006.70,   110.90},
{ "Verdant Bluffs",               1073.20, -2006.70,   -89.00,  1249.60, -1842.20,   110.90},
{ "Verdant Bluffs",               1249.60, -2179.20,   -89.00,  1692.60, -1842.20,   110.90},
{ "Verdant Meadows",                37.00,  2337.10,    -3.00,   435.90,  2677.90,   200.00},
{ "Praia de Verona",                  647.70, -2173.20,   -89.00,   930.20, -1804.20,   110.90},
{ "Praia de Verona",                  930.20, -2006.70,   -89.00,  1073.20, -1804.20,   110.90},
{ "Praia de Verona",                  851.40, -1804.20,   -89.00,  1046.10, -1577.50,   110.90},
{ "Praia de Verona",                 1161.50, -1722.20,   -89.00,  1323.90, -1577.50,   110.90},
{ "Praia de Verona",                 1046.10, -1722.20,   -89.00,  1161.50, -1577.50,   110.90},
{ "Vinewood",                      787.40, -1310.20,   -89.00,   952.60, -1130.80,   110.90},
{ "Vinewood",                      787.40, -1130.80,   -89.00,   952.60,  -954.60,   110.90},
{ "Vinewood",                      647.50, -1227.20,   -89.00,   787.40, -1118.20,   110.90},
{ "Vinewood",                      647.70, -1416.20,   -89.00,   787.40, -1227.20,   110.90},
{ "Whitewood Estates",             883.30,  1726.20,   -89.00,  1098.30,  2507.20,   110.90},
{ "Whitewood Estates",            1098.30,  1726.20,   -89.00,  1197.30,  2243.20,   110.90},
{ "Willowfield",                  1970.60, -2179.20,   -89.00,  2089.00, -1852.80,   110.90},
{ "Willowfield",                  2089.00, -2235.80,   -89.00,  2201.80, -1989.90,   110.90},
{ "Willowfield",                  2089.00, -1989.90,   -89.00,  2324.00, -1852.80,   110.90},
{ "Willowfield",                  2201.80, -2095.00,   -89.00,  2324.00, -1989.90,   110.90},
{ "Willowfield",                  2541.70, -1941.40,   -89.00,  2703.50, -1852.80,   110.90},
{ "Willowfield",                  2324.00, -2059.20,   -89.00,  2541.70, -1852.80,   110.90},
{ "Willowfield",                  2541.70, -2059.20,   -89.00,  2703.50, -1941.40,   110.90},
{ "~~Yellow Bell Station",          1377.40,  2600.40,   -21.90,  1492.40,  2687.30,    78.00},
// Main Zones
{ "Los Santos",                     44.60, -2892.90,  -242.90,  2997.00,  -768.00,   900.00},
{ "Las Venturas",                  869.40,   596.30,  -242.90,  2997.00,  2993.80,   900.00},
{ "Bone County",                  -480.50,   596.30,  -242.90,   869.40,  2993.80,   900.00},
{ "Tierra Robada",               -2997.40,  1659.60,  -242.90,  -480.50,  2993.80,   900.00},
{ "Tierra Robada",               -1213.90,   596.30,  -242.90,  -480.50,  1659.60,   900.00},
{ "San Fierro",                  -2997.40, -1115.50,  -242.90, -1213.90,  1659.60,   900.00},
{ "Red County",                  -1213.90,  -768.00,  -242.90,  2997.00,   596.30,   900.00},
{ "Flint County",                -1213.90, -2892.90,  -242.90,    44.60,  -768.00,   900.00},
{ "Whetstone",                   -2997.40, -2892.90,  -242.90, -1213.90, -1115.50,   900.00}
};
new gMax;
new GPS_Spawned[MAX_PLAYERS];

forward GPS();
new COLORS[] = {
0x33AA33AA,
0x8080FFAA,
0x80FFFFAA,
0x0000FFAA,
0x00FF00AA,
};
new Count = 5;
new CountText[5][5] ={
"~r~5",
"~g~4",
"~b~3",
"~y~2",
"~p~1"
};
new afk[MAX_PLAYERS];
new count2;
new sexshop;
new sexshop2;
new pickarmas;
new pickarmas2;
new pickarmas3;
new portao;
new portao2;
new Kills[MAX_PLAYERS];
new Mortes[MAX_PLAYERS];
new clube;
new clube2;
new portaoclube1;
new portaoclube2;
new visitorstr[256];
new Visitors;
new Text:Relogio;
new Banco;
new Matou[MAX_PLAYERS];
new Morreu[MAX_PLAYERS];
//cmds block
new nogame[MAX_PLAYERS];
new nox1[MAX_PLAYERS];
//=-===================================================================
//Cmd com timer
new tempocmdgodc[MAX_PLAYERS];
new tempocmdajato[MAX_PLAYERS];
new tempocmdvida[MAX_PLAYERS];
new tempocmdcolete[MAX_PLAYERS];
//======================================================Forwards======================================================
forward tempocmdgodc2(playerid);
forward tempocmdajato2(playerid);
forward tempocmdvida2(playerid);
forward tempocmdcolete2(playerid);
//texts
forward MudarHora();
forward Velocimetro();
//fim
forward MudarNomeDOServer();
forward RandomMSGs();
forward GlobalAnnouncement();
forward CountDown();
forward portaoclube(); 
forward DynUpdateEnd(playerid);
forward DynUpdateStart(playerid);
forward UpperToLower(text[]);
//======================================================Fim======================================================

new InShamal[MAX_PLAYERS];
new Float:ShamalPos[MAX_VEHICLES][3];
new sExplode[MAX_VEHICLES], tCount[MAX_VEHICLES];
new Float:difc[13][4] = {
{1.13, 0.05, 1.10, 0.0},
{1.13, 2.35, 1.10, 180.0},
{1.13, 4.65, 1.10, 180.0},
{1.13, 1.05, 1.10, 0.0},
{1.13, 3.45, 1.10, 180.0},
{1.13, 5.85, 1.10, 180.0},
{1.13, 0.39, 0.56, 0.0},
{1.13, 2.69, 0.56, 180.0},
{1.13, 4.99, 0.56, 180.0},
{1.13, 0.71, 0.56, 0.0},
{1.13, 3.79, 0.56, 180.0},
{1.13, 6.19, 0.56, 180.0},
{0.00, 0.30, 1.10, 0.0}
};


#define Text_Under_Minimap "~n~~n~~w~~r~BKs"
new RandomTools[4][2] =
{
	{2, 1},
	{5, 1},
	{6, 1},
	{4, 1}
//	{9, 1}
};
new RandomPistols[5][5] =
{
	{22, 99999},
	{24, 99999},
    {30, 99999},
    {28, 99999},
    {29, 99999}
};
new Armas[3][3] =
{
    {30, 99999},
    {31, 99999},
    {28, 99999}
};


main()
{
	print("\n----------------------------------");
	print("       Phoenix~Stunt Mode            ");
	print(" Feito Por KabuLoZo e judson.");
	print("----------------------------------\n");
}

public OnGameModeInit()
{

UsePlayerPedAnims();
//desativar interiores e armas nos interiores
AllowInteriorWeapons(1);
//================================================
portao = CreateObject(980, -2796.356445, -329.915344, 8.812454, 0.0000, 0.0000, 90.0000);
portao2 = CreateObject(980, 1426.874390, -1888.340942, 15.232559, 0.0000, 0.0000, 0.0000);
clube = CreateObject(980, 829.460205, -1872.485107, 14.640579, 0.000000, 0.000000, 0.000000); //
clube2 = CreateObject(980, 843.172974, -1872.689453, 14.640579, 0.000000, 0.000000, 0.000000); //
//gzs

//=================================================================
Banco = CPS_AddCheckpoint(1208.3286,-1749.7391,13.5933, 3.0, 50);
pickarmas = CPS_AddCheckpoint(1370.5743,-1660.4807,13.3828, 2.0, 40);
pickarmas2 = CPS_AddCheckpoint(2352.2661,2775.7212,10.8203, 2.0, 40); 
pickarmas3 = CPS_AddCheckpoint(-2175.7925,642.0870,49.4375, 2.0, 40); 
sexshop = CPS_AddCheckpoint(358.8824,-1799.0582,4.8351,2.0, 40);
sexshop2 = CPS_AddCheckpoint(2847.8589,-2060.5598,11.0976, 2.0, 40);
portaoclube1 = CPS_AddCheckpoint(836.1945,-1873.9556,12.8672, 2.0, 40);
portaoclube2 = CPS_AddCheckpoint(836.3056,-1884.4156,12.8672, 2.0, 40);

SetGameModeText("The Crimes Brasil • Mata-Mata ® v1.0");
SendRconCommand("mapname ¤ San Andreas ¤");
SetTimer("MudarNomeDOServer",750,1);
SetTimer ( "RandomMSGs", 80000, true);
SetTimer("MudarHora",1000,true);
//==============================================GPS=======================================
    SetTimer("GPS", 500, 1);
    gMax = GetMaxPlayers();
   	for(new i=0; i<gMax; i++)
       {
		/*gps[i] = TextDrawCreate(2.000000, 435.000000, "BKs");
		TextDrawBackgroundColor(gps[i], 255);
		TextDrawFont(gps[i], 3);
		TextDrawLetterSize(gps[i], 0.400000, 0.900000);
		TextDrawColor(gps[i], -1);
		TextDrawSetOutline(gps[i], 1);
		TextDrawSetProportional(gps[i], 1);*/ 
        gps[i] = TextDrawCreate(5.0, 400.0,Text_Under_Minimap);
        TextDrawBackgroundColor(gps[i], 255);
        TextDrawSetOutline(gps[i], 1);
        TextDrawColor(gps[i], -1);
       }

//===============================================Velocimetro===================================================
HGS = SetTimer("Velocimetro",300,1);
ArkaPlan1 = TextDrawCreate(515.000000, 334.000000, "-----------------");
TextDrawBackgroundColor(ArkaPlan1, -1);
TextDrawFont(ArkaPlan1, 3);
TextDrawLetterSize(ArkaPlan1, 0.480000, 1.000000);
TextDrawColor(ArkaPlan1, -1);
TextDrawSetOutline(ArkaPlan1, 1);
TextDrawSetProportional(ArkaPlan1, 1);

ArkaPlan2 = TextDrawCreate(515.000000, 406.000000, "-----------------");
TextDrawBackgroundColor(ArkaPlan2, -1);
TextDrawFont(ArkaPlan2, 3);
TextDrawLetterSize(ArkaPlan2, 0.480000, 1.000000);
TextDrawColor(ArkaPlan2, -1);
TextDrawSetOutline(ArkaPlan2, 1);
TextDrawSetProportional(ArkaPlan2, 1);

ArkaPlan3 = TextDrawCreate(514.000000, 339.000000, "I~n~I~n~I~n~I~n~I~n~I~n~I~n~I~n~I");
TextDrawBackgroundColor(ArkaPlan3, -1);
TextDrawFont(ArkaPlan3, 3);
TextDrawLetterSize(ArkaPlan3, 0.330000, 0.899999);
TextDrawColor(ArkaPlan3, -1);
TextDrawSetOutline(ArkaPlan3, 1);
TextDrawSetProportional(ArkaPlan3, 1);

ArkaPlan4 = TextDrawCreate(635.000000, 339.000000, "I~n~I~n~I~n~I~n~I~n~I~n~I~n~I~n~I");
TextDrawBackgroundColor(ArkaPlan4, -1);
TextDrawFont(ArkaPlan4, 3);
TextDrawLetterSize(ArkaPlan4, 0.330000, 0.899999);
TextDrawColor(ArkaPlan4, -1);
TextDrawSetOutline(ArkaPlan4, 1);
TextDrawSetProportional(ArkaPlan4, 1);

ArkaPlan5 = TextDrawCreate(512.000000, 327.000000, "Velocimetro");
TextDrawBackgroundColor(ArkaPlan5, 255);
TextDrawFont(ArkaPlan5, 2);
TextDrawLetterSize(ArkaPlan5, 0.430000, 1.200000);
TextDrawColor(ArkaPlan5, -1);
TextDrawSetOutline(ArkaPlan5, 1);
TextDrawSetProportional(ArkaPlan5, 1);

Cizgi = TextDrawCreate(576.000000, 343.000000, "Veiculo~n~ ~n~ ~n~Velocidade~n~ ~n~ ~n~Lataria~n~ ~n~");
TextDrawAlignment(Cizgi, 2);
TextDrawBackgroundColor(Cizgi, 255);
TextDrawFont(Cizgi, 0);
TextDrawLetterSize(Cizgi, 0.429999, 0.899999);
TextDrawColor(Cizgi, -1);
TextDrawSetOutline(Cizgi, 1);
TextDrawSetProportional(Cizgi, 1);
TextDrawUseBox(Cizgi, 1);
TextDrawBoxColor(Cizgi, 151456170);
TextDrawTextSize(Cizgi, -10.000000, -130.000000);

	for(new i=0; i<GetMaxPlayers(); i++)
	{
GostergeYazi[i] = TextDrawCreate(576.000000, 343.000000, " ");
TextDrawAlignment(GostergeYazi[i], 2);
TextDrawBackgroundColor(GostergeYazi[i], 255);
TextDrawFont(GostergeYazi[i], 2);
TextDrawLetterSize(GostergeYazi[i], 0.259999, 0.899999);
TextDrawColor(GostergeYazi[i], -1);
TextDrawSetOutline(GostergeYazi[i], 1);
TextDrawSetProportional(GostergeYazi[i], 1);
	}
//===============================================Velocimetro===================================================
	Relogio = TextDrawCreate(605.0,25.0,"00:00");
	TextDrawUseBox(Relogio, 0);
	TextDrawFont(Relogio, 3);
	TextDrawSetShadow(Relogio,0); // no shadow
    TextDrawSetOutline(Relogio,2); // thickness 1
    TextDrawBackgroundColor(Relogio,0x000000FF);
    TextDrawColor(Relogio,0xFFFFFFFF);
    TextDrawAlignment(Relogio,3);
	TextDrawLetterSize(Relogio,0.5,1.5);


Object_Object();//NÃO TIRE

//counter-striker

CreateDynamicObject(12814, 3316.955078125, -1990.0933837891, 43.46427154541, 0, 0, 274.04345703125);
CreateDynamicObject(12814, 3364.8845214844, -1986.6181640625, 43.310176849365, 0, 0, 274.04296875);
CreateDynamicObject(12814, 3315.330078125, -1964.8212890625, 42.883243560791, 0, 0, 274.04296875);
CreateDynamicObject(12814, 3362.22265625, -1960.7966308594, 42.918163299561, 0, 0, 274.04296875);
CreateDynamicObject(12814, 3359.5524902344, -1933.9168701172, 43.153408050537, 0, 0, 274.04296875);
CreateDynamicObject(12814, 3313.3312988281, -1937.4987792969, 43.025436401367, 0, 0, 274.04296875);
CreateDynamicObject(12814, 3311.201171875, -1907.9368896484, 43.049705505371, 0, 0, 274.04296875);
CreateDynamicObject(12814, 3357.1110839844, -1904.7447509766, 43.047645568848, 0, 0, 274.04296875);
CreateDynamicObject(12814, 3354.7509765625, -1876.146484375, 43.00545501709, 0, 0, 274.03747558594);
CreateDynamicObject(12814, 3309.0913085938, -1879.7241210938, 43.193290710449, 0, 0, 274.04296875);
CreateDynamicObject(10828, 3309.8662109375, -1987.8720703125, 45.443885803223, 0, 0, 3.9056396484375);
CreateDynamicObject(10828, 3317.5666503906, -1987.3994140625, 45.443885803223, 0, 0, 3.9056396484375);
CreateDynamicObject(10828, 3364.0991210938, -1984.1885986328, 45.7936668396, 0, 0, 3.9056396484375);
CreateDynamicObject(10828, 3311.0070800781, -2004.3077392578, 46.199699401855, 0, 0, 3.9056396484375);
CreateDynamicObject(10828, 3344.619140625, -2002.0373535156, 46.549480438232, 0, 0, 3.9056396484375);
CreateDynamicObject(10828, 3374.255859375, -1999.7188720703, 46.801418304443, 0, 0, 3.9056396484375);
CreateDynamicObject(10828, 3294.5209960938, -2005.3201904297, 45.695823669434, 0, 0, 274.04162597656);
CreateDynamicObject(4011, 3284.0634765625, -1965.9599609375, 41.84969329834, 0, 0, 3.9056396484375);
CreateDynamicObject(12814, 3352.1818847656, -1848.0817871094, 42.761329650879, 0, 0, 274.03747558594);
CreateDynamicObject(12814, 3308.4665527344, -1850.9173583984, 42.920871734619, 0, 0, 274.03747558594);
CreateDynamicObject(11445, 3323.7287597656, -1840.8829345703, 42.676746368408, 0, 0, 185.82061767578);
CreateDynamicObject(11442, 3327.5456542969, -1842.8532714844, 42.604598999023, 0, 0, 0);
CreateDynamicObject(11442, 3317.8239746094, -1842.0539550781, 42.172870635986, 19.535705566406, 0, 324.8359375);
CreateDynamicObject(11442, 3321.4895019531, -1844.7529296875, 42.96928024292, 24.573486328125, 0, 324.83276367188);
CreateDynamicObject(11088, 3360.9274902344, -1810.2238769531, 48.074836730957, 0, 0, 274.04284667969);
CreateDynamicObject(3578, 3366.7185058594, -1838.9504394531, 48.233692169189, 97.678588867188, 0, 3.9071350097656);
CreateDynamicObject(3578, 3370.8952636719, -1834.2554931641, 48.937320709229, 3.9025268554688, 0, 274.04135131836);
CreateDynamicObject(3578, 3361.4077148438, -1834.7429199219, 48.834232330322, 3.900146484375, 0, 274.03747558594);
CreateDynamicObject(3578, 3366.134765625, -1840.0523681641, 48.802833557129, 3.900146484375, 0, 184.17309570313);
CreateDynamicObject(16092, 3298.5480957031, -1914.3537597656, 40.790077209473, 0, 0, 270.13635253906);
CreateDynamicObject(16092, 3306.8391113281, -1922.0404052734, 40.790077209473, 0, 0, 184.17468261719);
CreateDynamicObject(972, 3304.3928222656, -1928.1090087891, 34.363872528076, 89.8642578125, 0, 0);
CreateDynamicObject(972, 3304.59765625, -1934.7897949219, 34.323387145996, 89.862670898438, 0, 0);
CreateDynamicObject(972, 3299.5944824219, -1939.1116943359, 34.827911376953, 89.862670898438, 0, 274.04345703125);
CreateDynamicObject(972, 3303.5703125, -1939.0894775391, 34.971237182617, 89.857177734375, 0, 274.04296875);
CreateDynamicObject(972, 3298.0151367188, -1911.3447265625, 29.956748962402, 89.857177734375, 0, 274.04296875);
CreateDynamicObject(972, 3304.0961914063, -1921.8509521484, 33.483879089355, 89.857177734375, 0, 180.27154541016);
CreateDynamicObject(972, 3304.3264160156, -1932.1287841797, 33.711547851563, 89.851684570313, 0, 180.26916503906);
CreateDynamicObject(972, 3307.8469238281, -1934.8298339844, 34.980430603027, 89.851684570313, 0, 274.04064941406);
CreateDynamicObject(972, 3297.5344238281, -1935.2755126953, 35.475112915039, 89.84619140625, 0, 274.03747558594);
CreateDynamicObject(8661, 3288.146484375, -1933.5832519531, 46.885284423828, 179.72863769531, 0, 4.4447937011719);
CreateDynamicObject(8661, 3292.6130371094, -1918.4571533203, 46.632270812988, 179.72534179688, 0, 4.4439697265625);
CreateDynamicObject(972, 3297.6872558594, -1931.3609619141, 33.774353027344, 89.862670898438, 0, 0);
CreateDynamicObject(9131, 3300.9011230469, -1914.2416992188, 44.186431884766, 0, 0, 3.9071350097656);
CreateDynamicObject(9131, 3300.712890625, -1914.5032958984, 46.28430557251, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3304.7990722656, -1913.5888671875, 44.186431884766, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3305.5837402344, -1913.5946044922, 44.186431884766, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3306.44140625, -1913.5173339844, 44.186431884766, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3307.4411621094, -1916.1203613281, 44.186431884766, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3307.4182128906, -1915.3206787109, 44.186431884766, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3307.3513183594, -1914.6517333984, 44.186431884766, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3307.2878417969, -1913.9763183594, 44.186431884766, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3307.6088867188, -1916.1318359375, 46.247295379639, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3307.5300292969, -1915.2204589844, 46.459426879883, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3307.3056640625, -1914.9169921875, 46.459426879883, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3307.4504394531, -1942.1047363281, 44.162162780762, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3306.6608886719, -1942.2060546875, 44.162162780762, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3307.3430175781, -1942.0998535156, 46.435157775879, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3306.6044921875, -1942.1960449219, 46.435157775879, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3305.8864746094, -1942.189453125, 44.162162780762, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3305.9055175781, -1942.2430419922, 46.435157775879, 0, 0, 3.9056396484375);
CreateDynamicObject(9131, 3304.5952148438, -1942.3276367188, 47.127960205078, 0, 89.864288330078, 3.9056396484375);
CreateDynamicObject(9131, 3304.5844726563, -1942.2707519531, 46.42960357666, 0, 89.862670898438, 3.900146484375);
CreateDynamicObject(9131, 3304.6098632813, -1942.2786865234, 45.673789978027, 0, 89.862670898438, 3.900146484375);
CreateDynamicObject(972, 3302.2685546875, -1980.9453125, 29.86743927002, 89.862670898438, 0, 356.09286499023);
CreateDynamicObject(972, 3303.7001953125, -1969.4202880859, 30.042224884033, 89.857177734375, 0, 359.99597167969);
CreateDynamicObject(972, 3303.8276367188, -1962.2738037109, 29.617805480957, 89.851684570313, 0, 359.99450683594);
CreateDynamicObject(972, 3306.8466796875, -1959.1131591797, 30.660053253174, 89.851684570313, 0, 277.94470214844);
CreateDynamicObject(972, 3303.8515625, -1956.4145507813, 29.538349151611, 89.851684570313, 0, 359.99450683594);
CreateDynamicObject(972, 3303.8937988281, -1949.8540039063, 31.192169189453, 89.851684570313, 0, 359.99450683594);
CreateDynamicObject(972, 3303.8503417969, -1942.78515625, 29.673233032227, 89.851684570313, 0, 359.99450683594);
CreateDynamicObject(972, 3303.9553222656, -1940.3485107422, 31.065326690674, 89.851684570313, 0, 359.99450683594);
CreateDynamicObject(18620, 3328.8132324219, -1941.7827148438, 47.314456939697, 0, 0, 0);
CreateDynamicObject(18620, 3340.8173828125, -1915.2076416016, 46.824977874756, 0, 0, 0);
CreateDynamicObject(18620, 3331.76953125, -1899.7211914063, 46.580852508545, 0, 0, 0);
CreateDynamicObject(18620, 3331.7133789063, -1885.0108642578, 46.726497650146, 0, 0, 0);
CreateDynamicObject(18620, 3325.3051757813, -1915.4396972656, 46.582912445068, 0, 0, 0);
CreateDynamicObject(18620, 3327.7836914063, -1905.5584716797, 46.582912445068, 0, 0, 0);
CreateDynamicObject(18620, 3333.8374023438, -1928.91796875, 46.902519226074, 0, 0, 0);
CreateDynamicObject(852, 3305.7221679688, -1986.4520263672, 43.47208404541, 0, 0, 0);
CreateDynamicObject(852, 3314.6706542969, -2002.02734375, 43.47208404541, 0, 0, 0);
CreateDynamicObject(852, 3314.8952636719, -2000.0413818359, 43.47208404541, 0, 0, 0);
CreateDynamicObject(852, 3315.1342773438, -1996.9703369141, 43.47208404541, 0, 0, 0);
CreateDynamicObject(852, 3318.3112792969, -1988.3292236328, 48.818916320801, 0, 0, 0);
CreateDynamicObject(2934, 3316.2199707031, -1971.3186035156, 44.342975616455, 0, 0, 274.04345703125);
CreateDynamicObject(3043, 3316.4641113281, -1974.310546875, 44.342975616455, 0, 0, 274.04345703125);
CreateDynamicObject(2062, 3308.0712890625, -1942.3232421875, 43.60188293457, 0, 0, 0);
CreateDynamicObject(2062, 3308.8525390625, -1942.3298339844, 43.60188293457, 0, 0, 0);
CreateDynamicObject(2669, 3377.0639648438, -1922.2386474609, 44.501495361328, 0, 0, 3.9071350097656);
CreateDynamicObject(2669, 3376.7045898438, -1917.0177001953, 44.395729064941, 0, 0, 182.47802734375);
CreateDynamicObject(2934, 3367.1374511719, -1932.6922607422, 44.36120223999, 0, 0, 301.39270019531);
CreateDynamicObject(3633, 3372.2729492188, -1934.7314453125, 43.384086608887, 0, 0, 0);
CreateDynamicObject(3594, 3368.0158691406, -1925.7546386719, 43.540458679199, 0, 0, 74.235595703125);
CreateDynamicObject(3509, 3374.8251953125, -1897.2730712891, 43.055458068848, 0, 0, 0);
CreateDynamicObject(3509, 3371.2827148438, -1876.4912109375, 43.01326751709, 0, 0, 0);
CreateDynamicObject(12957, 3369.2517089844, -1912.0085449219, 43.429798126221, 352.18569946289, 0, 0);
CreateDynamicObject(1358, 3360.9516601563, -1929.4201660156, 43.860889434814, 0, 0, 285.76477050781);
CreateDynamicObject(2905, 3310.2705078125, -1947.2983398438, 43.124698638916, 0, 0, 0);
CreateDynamicObject(2906, 3311.4123535156, -1947.5209960938, 43.107261657715, 0, 0, 0);
CreateDynamicObject(2907, 3310.8735351563, -1946.2009277344, 43.193283081055, 0, 0, 0);
CreateDynamicObject(2908, 3310.3793945313, -1948.2066650391, 43.110668182373, 0, 0, 0);
CreateDynamicObject(2906, 3310.19140625, -1945.9105224609, 43.107261657715, 0, 179.72863769531, 0);
CreateDynamicObject(2905, 3311.6557617188, -1945.6270751953, 43.124698638916, 0, 168.52146911621, 0);
CreateDynamicObject(3092, 3308.9221191406, -1941.8583984375, 43.997554779053, 0, 0, 0);
CreateDynamicObject(3567, 3345.2770996094, -1904.1287841797, 43.430328369141, 0, 0, 274.04345703125);
CreateDynamicObject(2678, 3346.064453125, -1902.2724609375, 45.092823028564, 0, 0, 96.492919921875);
CreateDynamicObject(2679, 3344.7768554688, -1902.3643798828, 44.969512939453, 0, 0, 274.04345703125);
CreateDynamicObject(12950, 3345.3254394531, -1898.4831542969, 40.815818786621, 0, 0, 180.32330322266);
CreateDynamicObject(12929, 3300.1252441406, -1882.6247558594, 43.201103210449, 0, 0, 3.9071350097656);
CreateDynamicObject(12929, 3295.5422363281, -1883.0570068359, 43.350051879883, 0, 0, 184.17736816406);
CreateDynamicObject(16302, 3352.9375, -1946.5662841797, 45.212936401367, 0, 0, 0);
CreateDynamicObject(972, 3343.6535644531, -1902.212890625, 31.005123138428, 89.862670898438, 0, 274.04345703125);
CreateDynamicObject(972, 3350.3044433594, -1901.7138671875, 30.962440490723, 89.857177734375, 0, 274.04296875);
CreateDynamicObject(972, 3353.935546875, -1901.3905029297, 31.074115753174, 89.857177734375, 0, 274.04296875);
CreateDynamicObject(972, 3353.7602539063, -1898.5618896484, 30.710502624512, 89.857177734375, 0, 274.04296875);
CreateDynamicObject(972, 3352.8679199219, -1898.5281982422, 30.755462646484, 89.857177734375, 0, 274.04296875);
CreateDynamicObject(972, 3344.5993652344, -1899.5141601563, 30.720966339111, 89.857177734375, 0, 274.04296875);
CreateDynamicObject(972, 3343.2844238281, -1899.4320068359, 30.82445526123, 89.857177734375, 0, 274.04296875);
CreateDynamicObject(1649, 3354.0109863281, -1903.4792480469, 45.790466308594, 0, 0, 93.771148681641);
CreateDynamicObject(1649, 3336.6296386719, -1904.8135986328, 45.620986938477, 0, 0, 274.04064941406);
CreateDynamicObject(1649, 3353.875, -1903.2561035156, 45.978610992432, 0, 0, 274.03747558594);
CreateDynamicObject(1649, 3336.1804199219, -1904.5113525391, 45.734455108643, 0, 0, 93.794281005859);
CreateDynamicObject(1649, 3338.7456054688, -1905.779296875, 45.982479095459, 0, 0, 3.9071350097656);
CreateDynamicObject(1649, 3342.2106933594, -1905.6109619141, 45.978610992432, 0, 0, 3.9056396484375);
CreateDynamicObject(1649, 3345.8166503906, -1905.3205566406, 45.978610992432, 0, 0, 3.9056396484375);
CreateDynamicObject(1649, 3350.0161132813, -1905.0394287109, 45.978610992432, 0, 0, 3.9056396484375);
CreateDynamicObject(1649, 3351.5471191406, -1904.9342041016, 45.797607421875, 0, 0, 3.9056396484375);
CreateDynamicObject(1649, 3338.5932617188, -1903.2269287109, 45.796539306641, 0, 0, 184.22912597656);
CreateDynamicObject(1649, 3342.6706542969, -1902.8016357422, 45.794036865234, 0, 0, 184.22424316406);
CreateDynamicObject(1649, 3348.1369628906, -1902.2751464844, 45.986206054688, 0, 0, 184.22424316406);
CreateDynamicObject(1649, 3351.890625, -1902.0737304688, 45.977813720703, 0, 0, 184.22424316406);
CreateDynamicObject(1980, 3339.9489746094, -1904.8331298828, 47.236053466797, 0, 89.864288330078, 93.771423339844);
CreateDynamicObject(1980, 3346.6860351563, -1904.1788330078, 47.229393005371, 0, 89.862670898438, 93.768310546875);
CreateDynamicObject(1980, 3350.7517089844, -1903.7946777344, 47.302822113037, 0, 89.862670898438, 93.768310546875);
CreateDynamicObject(8148, 3382.9504394531, -1920.3540039063, 44.515377044678, 0, 0, 183.09808349609);
CreateDynamicObject(8148, 3327.0708007813, -1856.52734375, 43.762271881104, 0, 0, 272.95715332031);
CreateDynamicObject(8661, 3284.3466796875, -1870.142578125, 43.201103210449, 93.768310546875, 0, 89.862670898438);
CreateDynamicObject(8661, 3286.3381347656, -1900.7044677734, 43.057518005371, 93.768310546875, 0, 93.769836425781);
CreateDynamicObject(3866, 3314.5161132813, -1825.4677734375, 49.374336242676, 0, 0, 183.58380126953);
CreateDynamicObject(3866, 3292.5583496094, -1836.2486572266, 50.767250061035, 0, 0, 218.74597167969);
CreateDynamicObject(3866, 3280.3481445313, -1846.5534667969, 49.565071105957, 0, 0, 218.74328613281);
CreateDynamicObject(17942, 3365.5256347656, -1969.1241455078, 44.214511871338, 0, 0, 3.9071350097656);
CreateDynamicObject(17942, 3363.5654296875, -1915.3575439453, 44.092056274414, 0, 0, 85.955474853516);
CreateDynamicObject(17958, 3346.8154296875, -1954.9921875, 44.035572052002, 0, 0, 0);
CreateDynamicObject(17958, 3341.4733886719, -1916.6514892578, 45.086891174316, 0, 0, 0);
CreateDynamicObject(17958, 3343.0217285156, -1878.6953125, 43.533073425293, 0, 0, 0);
CreateDynamicObject(972, 3359.1525878906, -1876.4105224609, 31.424125671387, 89.851684570313, 0, 293.57366943359);
CreateDynamicObject(972, 3353.96484375, -1878.806640625, 29.912498474121, 89.840698242188, 0, 285.75439453125);
CreateDynamicObject(972, 3351.14453125, -1881.2333984375, 31.938465118408, 89.840698242188, 0, 250.58715820313);
CreateDynamicObject(972, 3346.5771484375, -1881.4892578125, 32.293891906738, 89.840698242188, 0, 199.79187011719);
CreateDynamicObject(17942, 3360.787109375, -1886.7047119141, 44.301803588867, 0, 0, 101.58557128906);
CreateDynamicObject(14469, 3309.7302246094, -1941.787109375, 43.079761505127, 0, 0, 0);
CreateDynamicObject(972, 3294.4113769531, -1946.2836914063, 31.444107055664, 89.851684570313, 0, 277.94519042969);
CreateDynamicObject(972, 3295.1325683594, -1963.7255859375, 31.301914215088, 89.84619140625, 0, 262.31469726563);
CreateDynamicObject(1372, 3295.0173339844, -1943.3546142578, 43.033248901367, 0, 0, 3.9071350097656);
CreateDynamicObject(1372, 3296.6362304688, -1943.2852783203, 43.033248901367, 0, 0, 3.9056396484375);
CreateDynamicObject(3594, 3321.4152832031, -1989.3442382813, 44.103260040283, 0, 0, 97.677429199219);
CreateDynamicObject(13591, 3311.5693359375, -1996.8870849609, 43.611099243164, 0, 0, 274.04345703125);
CreateDynamicObject(987, 3316.4553222656, -1999.3873291016, 42.044013977051, 0, 0, 93.771301269531);
CreateDynamicObject(987, 3316.6059570313, -2003.421875, 42.202041625977, 0, 0, 93.768310546875);
CreateDynamicObject(647, 3381.4006347656, -1983.0227050781, 45.28840637207, 0, 0, 0);
CreateDynamicObject(8661, 3289.7768554688, -1860.1149902344, 42.928684234619, 93.768310546875, 0, 3.9057006835938);
CreateDynamicObject(972, 3305.529296875, -1854.5146484375, 41.690200805664, 359.97640991211, 0, 211.51867675781);
CreateDynamicObject(939, 3308.2182617188, -1882.1911621094, 42.873012542725, 0, 0, 274.04345703125);
CreateDynamicObject(3066, 3309.1159667969, -1881.8802490234, 47.081184387207, 0, 93.771423339844, 0);
CreateDynamicObject(2912, 3286.9499511719, -1880.0563964844, 43.201103210449, 0, 0, 0);
CreateDynamicObject(2912, 3286.3288574219, -1880.1533203125, 43.201103210449, 0, 0, 0);
CreateDynamicObject(2912, 3285.6865234375, -1880.1926269531, 43.201103210449, 0, 0, 0);
CreateDynamicObject(2912, 3284.9665527344, -1880.1507568359, 43.201103210449, 0, 0, 0);
CreateDynamicObject(2912, 3286.8903808594, -1880.0190429688, 43.901103973389, 0, 0, 0);
CreateDynamicObject(2912, 3286.1735839844, -1879.9422607422, 43.904579162598, 0, 0, 0);
CreateDynamicObject(2912, 3285.5810546875, -1879.8375244141, 43.897258758545, 0, 0, 0);
CreateDynamicObject(2912, 3285.2541503906, -1879.482421875, 44.079231262207, 0, 0, 0);
CreateDynamicObject(2912, 3286.8400878906, -1879.8135986328, 44.601104736328, 0, 0, 0);
CreateDynamicObject(2912, 3286.2048339844, -1879.7395019531, 44.604579925537, 0, 0, 0);
CreateDynamicObject(2912, 3286.0373535156, -1879.3843994141, 44.717163085938, 0, 0, 0);
CreateDynamicObject(2912, 3285.4506835938, -1879.4300537109, 44.779232025146, 0, 0, 0);
CreateDynamicObject(2912, 3285.6115722656, -1879.0749511719, 45.478183746338, 0, 0, 0);
CreateDynamicObject(2912, 3286.2434082031, -1879.4904785156, 45.417163848877, 0, 0, 0);
CreateDynamicObject(2912, 3286.7973632813, -1879.5432128906, 45.301105499268, 0, 0, 0);
CreateDynamicObject(2912, 3285.7390136719, -1860.7330322266, 42.928684234619, 0, 0, 0);
CreateDynamicObject(2912, 3285.8549804688, -1861.5877685547, 42.928684234619, 0, 0, 0);
CreateDynamicObject(2912, 3285.7043457031, -1860.4765625, 43.628684997559, 0, 0, 0);
CreateDynamicObject(2912, 3286.9721679688, -1879.3962402344, 43.201103210449, 0, 0, 0);
CreateDynamicObject(972, 3286.109375, -1892.5854492188, 47.704383850098, 89.840698242188, 0, 94.298797607422);

//bate bate
CreateDynamicObject(8344, 3022.769043, 369.937164, 1.169524, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(8343, 3111.250977, 353.248779, 1.171036, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(8344, 3111.300293, 430.497986, 1.037606, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(8343, 3022.638428, 446.779572, 1.143163, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(8356, 3153.867432, 403.354248, 1.058579, 0.0000, 270.6186, 0.0000);
CreateDynamicObject(8356, 3059.562988, 310.355957, 1.192013, 0.0000, 270.6186, 270.0000);
CreateDynamicObject(8356, 2978.716064, 403.145905, 1.190497, 0.0000, 270.6186, 180.0000);
CreateDynamicObject(8356, 3066.496338, 495.963715, 1.039136, 0.0000, 270.6186, 90.0000);
CreateDynamicObject(8357, 3064.956543, 439.072357, 1.087525, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(8357, 3070.096191, 401.079590, 1.041262, 0.0000, 0.0000, 270.0000);


//ilha
CreateDynamicObject(7033, 836.326111, -1879.110229, 16.380959, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2589, 820.158752, -2054.870605, 17.306602, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(11434, 828.726135, -2005.844604, 16.653622, 0.0000, 0.0000, 87.0028);
CreateDynamicObject(18233, 846.953735, -1946.847412, 11.867188, 0.0000, 0.0000, 219.0008);
CreateDynamicObject(2709, 843.517151, -1951.832153, 15.750342, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(7392, 835.917236, -1881.721436, 29.337269, 0.0000, 0.0000, 89.0024);
CreateDynamicObject(9833, 837.274048, -1881.973389, 42.151588, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(16442, 823.936218, -2012.896118, 15.946089, 0.0000, 0.0000, 358.7474);
CreateDynamicObject(2803, 819.974304, -2006.734985, 12.588219, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2805, 827.265564, -2002.390137, 14.510445, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(12854, 845.722046, -1960.135010, 13.875236, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1481, 851.847168, -1972.506836, 12.570313, 0.0000, 0.0000, 266.0005);
CreateDynamicObject(2472, 852.123291, -2037.757080, 11.867188, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(5333, 835.347107, -2141.216309, 20.653748, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(979, 848.870361, -2065.677734, 12.682408, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(979, 822.752808, -2067.152100, 12.682408, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(5004, 822.993774, -2308.799316, 23.347927, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3749, 835.320007, -2254.008789, 29.440716, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(5002, 874.332092, -2302.533203, 23.765512, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(5002, 873.755188, -2389.352295, 24.048737, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(5002, 786.252869, -2390.194580, 24.032757, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(5002, 786.221375, -2445.467041, 24.131968, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(5002, 873.983398, -2445.551270, 24.090189, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1341, 852.925415, -1899.766113, 12.835027, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(2600, 820.655457, -1920.475342, 12.639460, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(1257, 852.757690, -1836.988281, 12.759590, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1216, 842.388428, -1947.906738, 12.615103, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(1262, 837.975769, -1871.930176, 13.171267, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1262, 834.815735, -1872.109497, 13.233644, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1262, 837.850464, -1886.192505, 13.031194, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(1262, 834.687500, -1886.192505, 13.041945, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(1215, 824.032654, -1871.184937, 12.431511, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1215, 848.701416, -1872.034546, 12.452493, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1332, 852.587219, -1857.754517, 12.804882, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3279, 818.259644, -2258.102051, 23.841129, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3268, 688.848389, -2501.488770, 24.131966, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(16782, 698.998535, -2501.376709, 31.970619, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3877, 824.027893, -1871.355591, 13.165200, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3877, 848.605957, -1871.637695, 13.407930, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(8040, 719.688843, -2272.080811, 24.352709, 0.0000, 0.0000, 0.0005);
CreateDynamicObject(8263, 680.248901, -2350.091064, 26.675570, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(8263, 680.199585, -2437.095459, 26.708000, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(8263, 767.844360, -2253.699463, 26.866539, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(8263, 903.358948, -2252.866699, 26.683329, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(8369, 965.379822, -2292.735840, 27.932167, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(8263, 979.685181, -2390.910156, 26.874767, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(8263, 979.621521, -2425.411133, 27.191216, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(8263, 919.853638, -2485.036133, 27.166216, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(8263, 800.528870, -2484.893066, 27.232994, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(8210, 725.383179, -2485.811523, 27.232994, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3306, 964.034180, -2265.751709, 25.177395, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3307, 964.124146, -2290.231201, 25.227394, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3308, 963.798706, -2313.477783, 25.161453, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3309, 963.573608, -2338.024170, 25.274862, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3310, 967.296875, -2362.550781, 26.088745, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3311, 967.305542, -2387.511475, 27.028637, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3312, 967.344971, -2412.419922, 27.030037, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3313, 967.371216, -2436.909180, 26.942698, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3314, 962.486145, -2457.655762, 25.083315, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3315, 919.560120, -2270.601318, 24.758642, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3316, 891.206482, -2270.871094, 27.102388, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3316, 866.541016, -2270.852051, 27.127388, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3317, 906.933350, -2467.046143, 27.427065, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3351, 882.273743, -2467.049805, 27.468840, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3353, 853.835938, -2467.477051, 25.200775, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3306, 832.729797, -2468.443848, 25.193851, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3307, 807.774170, -2468.452637, 25.243855, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3308, 784.328491, -2468.518066, 25.152903, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3309, 759.508972, -2468.470947, 25.233093, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3310, 734.928101, -2473.434814, 26.171976, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3310, 710.218872, -2473.475830, 26.171976, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3311, 692.192444, -2432.712891, 27.070410, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3312, 692.173279, -2407.959717, 27.071812, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3313, 692.402100, -2383.320801, 26.885265, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3314, 698.232605, -2362.776611, 24.950882, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3315, 698.109680, -2330.233398, 24.567675, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3316, 698.514526, -2309.434082, 26.911421, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(987, 680.412598, -2290.415039, 25.082979, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(987, 692.165527, -2290.620117, 25.012478, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(987, 704.003052, -2290.804932, 25.137476, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(987, 716.057800, -2290.610840, 25.137476, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(987, 728.060425, -2290.547363, 25.137476, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(987, 740.071350, -2290.395752, 25.137476, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(987, 747.698425, -2290.509033, 25.085367, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3279, 850.674500, -2256.763184, 23.841129, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(4113, 833.216309, -2368.809326, 60.077343, 0.0000, 0.0000, 11.2500);
CreateDynamicObject(9241, 876.793884, -2373.008545, 25.715874, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(9241, 788.043945, -2369.368896, 26.107635, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(8263, 853.250732, -1908.742798, 15.751844, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(8263, 852.999512, -2005.283813, 15.857841, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(8263, 819.974304, -2006.926270, 15.636566, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(8263, 819.724243, -1907.336304, 15.296587, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3550, 850.866821, -1872.728882, 14.234197, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3550, 821.869202, -1872.140381, 13.966904, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3475, 850.885864, -1872.519775, 14.243362, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3475, 822.075378, -1872.460815, 14.018366, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(2395, 838.063416, -1875.807617, 11.867188, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(2395, 837.781006, -1873.943970, 11.867188, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(2395, 837.825134, -1874.049316, 14.389947, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(2395, 838.070007, -1875.505127, 14.414015, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(2395, 834.930176, -1875.074219, 11.867188, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(2395, 834.911072, -1875.046265, 14.367710, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(2395, 834.807068, -1874.066162, 11.867188, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(2395, 834.802124, -1873.670166, 14.515193, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(1216, 836.296143, -1875.362305, 12.559190, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(1216, 836.286987, -1882.892578, 12.559190, 0.0000, 0.0000, 0.0000);
//puteiro
CreateDynamicObject(3601, 2855.52734375, -2065.3798828125, 17.924934387207, 0, 0, 270.67565917969);
CreateDynamicObject(1078, 2849.494140625, -2065.3642578125, 13.178516387939, 0, 0, 0);
CreateDynamicObject(14666, 2849.515625, -2067.1943359375, 14.254442214966, 0, 0, 0);
CreateDynamicObject(2586, 2849.1025390625, -2060.4736328125, 10.6509141922, 0, 0, 268.68713378906);
CreateDynamicObject(10236, 2849.23828125, -2058.6591796875, 22.758262634277, 0, 0, 0);
CreateDynamicObject(3435, 2850.1123046875, -2070.66796875, 30.772659301758, 0, 0, 0);
CreateDynamicObject(2745, 2849.1057128906, -2066.6174316406, 26.964347839355, 0, 0, 272.66064453125);
CreateDynamicObject(3877, 2848.916015625, -2059.4545898438, 27.42147064209, 0, 0, 0);
CreateDynamicObject(3877, 2848.900390625, -2071.962890625, 27.42147064209, 0, 0, 0);
CreateDynamicObject(3877, 2842.6918945313, -2071.3283691406, 11.767303466797, 0, 0, 0);
CreateDynamicObject(3877, 2843.7453613281, -2059.5290527344, 11.767303466797, 0, 0, 0);
CreateDynamicObject(7392, 2853.6396484375, -2065.1767578125, 35.475803375244, 0, 0, 0);
CreateDynamicObject(3601, 352.66485595703, -1806.6956787109, 11.456523895264, 0, 0, 270.27014160156);
CreateDynamicObject(1553, 358.87564086914, -1801.1174316406, 16.024473190308, 0, 179.3649597168, 0);
CreateDynamicObject(1553, 357.92544555664, -1801.4743652344, 15.956100463867, 0, 0, 0);
CreateDynamicObject(2586, 359.015625, -1800.6646728516, 4.3100271224976, 0, 0, 180.58544921875);
CreateDynamicObject(14666, 359.13119506836, -1800.4642333984, 6.3138990402222, 0, 0, 270.54040527344);
CreateDynamicObject(2596, 357.7073059082, -1800.8536376953, 6.9784846305847, 0, 0, 176.57043457031);
CreateDynamicObject(8558, 326.64825439453, -1814.9608154297, 4.8626489639282, 0, 0, 180.63024902344);
CreateDynamicObject(1775, 348.00778198242, -1800.5543212891, 4.8695731163025, 0, 0, 180.58520507813);
CreateDynamicObject(1776, 349.93444824219, -1800.6271972656, 4.6507496833801, 0, 0, 176.615234375);
CreateDynamicObject(3877, 347.49615478516, -1807.2785644531, 8.0241231918335, 0, 280.59997558594, 0);
CreateDynamicObject(3877, 347.64779663086, -1803.5417480469, 8.1726503372192, 0, 272.65997314453, 0);
CreateDynamicObject(3435, 351.54809570313, -1806.8140869141, 23.304248809814, 0, 0, 0);
CreateDynamicObject(7392, 353.08874511719, -1802.8374023438, 26.757392883301, 0, 0, 270.31518554688);
CreateDynamicObject(2942, 351.61688232422, -1800.3527832031, 4.4828519821167, 0, 0, 180.63024902344);
CreateDynamicObject(2903, 358.06210327148, -1809.2169189453, 27.653923034668, 0, 0, 0);


//respawn
CreateDynamicObject(980, 1775.669312, -1942.054443, 15.336687, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(980, 1764.116455, -1942.069458, 15.337589, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(980, 1787.219238, -1942.036011, 18.185795, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(980, 1798.590210, -1942.196533, 18.185795, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(980, 1807.161743, -1942.152588, 15.210791, 0.0000, 269.7592, 0.0000);
CreateDynamicObject(3749, 1809.555908, -1891.209839, 18.264921, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3528, 1752.926270, -1890.489380, 23.650761, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3528, 1752.926270, -1898.716064, 23.848200, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3528, 1752.076172, -1907.691650, 23.798264, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3528, 1752.926270, -1916.638550, 24.057178, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3528, 1752.776367, -1925.698242, 24.108337, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, 1809.747925, -1885.391724, 15.873274, 310.1527, 358.2811, 258.7500);
CreateDynamicObject(3525, 1809.269287, -1895.542603, 16.713240, 310.1527, 358.2811, 258.7500);
CreateDynamicObject(13667, 1769.448364, -1904.942139, 28.447414, 0.0000, 0.0000, 11.2500);
CreateDynamicObject(13667, 1770.232422, -1937.200073, 28.457212, 0.0000, 0.0000, 11.2500);
CreateDynamicObject(980, 1766.700317, -1929.563232, 15.654842, 90.2408, 0.0000, 270.0000);
CreateDynamicObject(980, 1766.650024, -1918.030518, 15.629869, 90.2408, 0.0000, 270.0000);
CreateDynamicObject(980, 1766.595703, -1912.823486, 15.630518, 90.2408, 0.0000, 270.0000);
CreateDynamicObject(980, 1760.954346, -1912.731689, 15.679842, 90.2408, 0.0000, 270.0000);
CreateDynamicObject(980, 1761.006348, -1924.183716, 15.654465, 90.2408, 0.0000, 270.0000);
CreateDynamicObject(980, 1761.657593, -1929.261353, 15.654528, 90.2408, 0.0000, 270.0000);
CreateDynamicObject(2780, 1768.333130, -1908.343628, 12.649417, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2780, 1767.841675, -1933.160400, 12.565752, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2780, 1767.322144, -1920.330444, 12.562859, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1764.352173, -1931.645386, 12.974416, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1763.098389, -1930.280273, 12.976865, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1764.172852, -1928.305908, 12.974766, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1764.851440, -1927.492554, 12.973440, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1763.273193, -1924.958862, 12.976523, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1762.636353, -1923.825073, 12.977768, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1761.693848, -1922.944336, 12.981465, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1761.710938, -1921.305054, 13.085996, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1761.873535, -1918.895752, 12.979532, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1761.592041, -1917.709351, 13.366384, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1765.583618, -1909.599243, 12.975898, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1764.899292, -1914.509888, 12.978128, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1763.418579, -1918.926636, 12.979924, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1763.080688, -1919.874268, 12.980305, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1762.162109, -1921.656616, 12.980950, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1761.430420, -1923.981689, 12.981908, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1761.578857, -1925.212036, 12.982545, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1762.015137, -1926.697998, 12.978982, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1762.052979, -1928.159790, 12.978908, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1762.391724, -1929.551514, 12.978246, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1765.302734, -1931.798340, 12.972559, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1762.150513, -1927.791626, 13.980688, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1767.193115, -1927.737305, 12.968865, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1225, 1763.903442, -1927.161133, 13.314381, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1769.164185, -1933.395508, 17.285656, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1769.096802, -1920.308960, 17.260612, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1768.652344, -1908.979736, 17.259621, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1763.727539, -1915.008667, 13.421667, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1764.728149, -1915.817871, 13.243130, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1762.786133, -1918.841797, 14.148986, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1764.036865, -1919.000244, 14.144289, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1763.992065, -1919.272827, 14.144377, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1762.644409, -1918.566772, 14.469905, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1762.905273, -1918.003784, 14.419760, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1763.292480, -1916.330811, 14.147882, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1761.217285, -1916.553711, 14.770411, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3461, 1759.247803, -1916.718506, 14.479254, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3515, 1762.181274, -1920.850464, 11.350058, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3528, 1763.949219, -1921.786255, 12.597261, 357.4217, 271.4781, 1.7189);
CreateDynamicObject(9833, 1761.231079, -1916.290894, 8.552738, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(9833, 1762.117432, -1924.863892, 8.407125, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1342, 1810.180664, -1922.841431, 13.589691, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(1342, 1810.204590, -1917.766357, 13.592004, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(16778, 1763.629883, -1891.305054, 12.552683, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3279, 1806.152466, -1938.348877, 12.622492, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3279, 1801.033325, -1885.803345, 12.478420, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(8357, 1791.444336, -1912.605591, 12.490544, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(14467, 1808.809326, -1892.542847, 26.754087, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(7392, 1750.530396, -1910.860352, 37.420769, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(7073, 1747.016113, -1917.212402, 46.061302, 0.0000, 0.0000, 46.7962);
CreateDynamicObject(13667, 1814.373901, -1904.151733, 28.459915, 0.0000, 0.0000, 11.2500);
CreateDynamicObject(13667, 1813.056519, -1878.230957, 28.466835, 0.0000, 0.0000, 11.2500);
CreateDynamicObject(3528, 1814.161987, -1892.126587, 20.394209, 0.0000, 0.0000, 0.0000);

//aero velho
	CreateDynamicObject(1634, 431.883850, 2488.143555, 16.514490, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1634, 435.335052, 2488.330322, 20.433653, 30.0803, 0.8594, 272.5783);
	CreateDynamicObject(1634, 438.327820, 2488.378906, 27.371143, 50.7067, 0.8594, 272.5783);
	CreateDynamicObject(1634, 438.556854, 2488.340332, 35.409050, 73.9115, 0.8594, 272.5783);
	CreateDynamicObject(1634, 436.111816, 2488.188477, 43.131302, 90.2408, 0.8594, 272.5783);
	CreateDynamicObject(1634, 432.356049, 2514.852539, 16.406698, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1634, 438.490082, 2514.846436, 22.295284, 35.2369, 0.0000, 270.0000);
	CreateDynamicObject(1634, 441.126892, 2514.925781, 30.135866, 55.8633, 0.0000, 270.0000);
	CreateDynamicObject(1634, 441.553223, 2514.919189, 39.361549, 67.0360, 0.0000, 270.0000);
	CreateDynamicObject(1634, 438.314545, 2514.932373, 47.242619, 105.7106, 0.0000, 270.0000);
	CreateDynamicObject(8356, 333.331238, 2503.148438, 38.380356, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1634, 431.637970, 2500.262939, 16.364492, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1634, 437.884979, 2500.217041, 21.891632, 30.0803, 0.0000, 270.0000);
	CreateDynamicObject(1634, 440.967102, 2500.217773, 30.427536, 59.3011, 0.0000, 270.0000);
	CreateDynamicObject(1634, 439.243195, 2500.228760, 39.773060, 86.8030, 0.0000, 270.0000);
	CreateDynamicObject(1634, 434.625153, 2500.218750, 46.893990, 109.1483, 0.0000, 270.0000);
	CreateDynamicObject(1634, 268.252258, 2516.616211, 39.412029, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1634, 268.208282, 2512.519043, 39.454224, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1634, 268.309875, 2508.630127, 39.429222, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1634, 268.386566, 2504.434814, 39.379219, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1634, 268.175354, 2500.651855, 39.529228, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1634, 268.389771, 2496.502197, 39.329216, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1634, 268.506836, 2492.468262, 39.304214, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1634, 268.602386, 2490.402588, 39.249504, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(8355, 170.883698, 2503.188721, 38.344296, 0.0000, 0.0000, 90.0001);
	CreateDynamicObject(660, 257.556915, 2489.137695, 38.469490, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 415.164948, 2521.623535, 37.721405, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 390.161743, 2522.471680, 37.721405, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 358.453552, 2522.263184, 37.721405, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 267.998993, 2522.435547, 37.721405, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 273.751068, 2483.790771, 37.760033, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 305.992340, 2483.844238, 37.721405, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 347.296234, 2483.633545, 37.721405, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 414.094788, 2483.786621, 37.721405, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 379.282227, 2483.900391, 37.721405, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(8357, 163.582428, 2534.337402, 47.440102, 0.0000, 36.9558, 270.0000);
	CreateDynamicObject(8357, 172.594391, 2466.451172, 48.754112, 0.0000, 31.7992, 90.0000);
	CreateDynamicObject(8357, -0.737859, 2503.380127, 38.331978, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(8357, -21.746010, 2467.065186, 48.350891, 0.0000, 31.7992, 90.0000);
	CreateDynamicObject(8357, -47.634033, 2468.308594, 47.750774, 0.0000, 31.7992, 90.0000);
	CreateDynamicObject(8357, -47.220879, 2503.880371, 38.314827, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(8357, 160.708237, 2566.611328, 69.526711, 0.0000, 31.7992, 270.0000);
	CreateDynamicObject(8357, -29.035337, 2430.117920, 58.856133, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(8357, 182.491470, 2429.646973, 58.838749, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(7379, 196.485641, 2577.322021, 57.567032, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(8357, -32.059898, 2536.875732, 49.349625, 0.0000, 36.9558, 270.0000);
	CreateDynamicObject(8357, -33.725159, 2567.409424, 70.022606, 0.0000, 31.7992, 270.0000);
	CreateDynamicObject(972, -128.379028, 2582.192871, 77.291763, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, -105.500008, 2582.224609, 77.186546, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, -82.392441, 2582.247314, 77.450760, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, -57.922729, 2582.263916, 77.220192, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, -34.991192, 2582.293213, 77.229080, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, -12.389814, 2582.253906, 76.954796, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 8.348969, 2582.300781, 76.983871, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 31.912376, 2582.361816, 77.021690, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 55.675240, 2582.597900, 76.918083, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 79.216286, 2582.524414, 76.871475, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 99.450668, 2582.718018, 77.026505, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 123.564819, 2582.656982, 77.367844, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 147.878616, 2582.213379, 77.643501, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 172.184540, 2582.560059, 77.278511, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 197.162521, 2580.486816, 77.751373, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 221.602798, 2580.736572, 77.047531, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 246.433914, 2581.212402, 77.031868, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 252.054276, 2581.503906, 76.957214, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 266.649353, 2569.142578, 71.059074, 327.3414, 1.7189, 178.2811);
	CreateDynamicObject(972, 266.193298, 2549.811035, 59.088905, 327.3414, 1.7189, 178.2811);
	CreateDynamicObject(972, 267.083923, 2535.470947, 48.270271, 327.3414, 1.7189, 178.2811);
	CreateDynamicObject(972, -138.188080, 2569.534668, 71.241615, 30.9397, 359.1406, 0.0000);
	CreateDynamicObject(972, -138.306854, 2551.293213, 58.599205, 30.9397, 359.1406, 0.0000);
	CreateDynamicObject(972, -138.249176, 2531.758789, 45.853508, 30.9397, 359.1406, 0.0000);
	CreateDynamicObject(972, -140.799774, 2508.622070, 38.296082, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(972, -140.685760, 2485.820557, 38.301888, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(972, -138.466324, 2519.737305, 39.832420, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(972, -139.851608, 2462.639404, 49.469292, 329.0603, 347.1084, 0.0000);
	CreateDynamicObject(972, -135.044693, 2447.522705, 58.087387, 0.0000, 0.0000, 22.5000);
	CreateDynamicObject(972, -131.333374, 2425.727539, 58.837387, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(972, -114.438591, 2411.131348, 58.842560, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, -93.966507, 2411.551758, 58.837387, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, -69.336098, 2411.294922, 58.837387, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, -44.544659, 2411.287354, 58.837387, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, -20.878620, 2411.523926, 58.837387, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 3.027719, 2411.390137, 58.837387, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 26.729536, 2411.785889, 58.837387, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 51.192459, 2412.111328, 58.837387, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 74.514702, 2410.997803, 58.837387, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 95.789009, 2410.507324, 58.827644, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 117.435707, 2410.480225, 58.820007, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 140.337708, 2410.436035, 58.820007, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 163.817490, 2410.697754, 58.820007, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 186.345444, 2410.807861, 58.820007, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 210.886932, 2410.420410, 58.827812, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 232.483719, 2410.449463, 58.820007, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 256.347443, 2410.659424, 58.820007, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 277.810791, 2409.902588, 58.820000, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 288.476013, 2426.439697, 58.820007, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(972, 283.543549, 2444.138672, 58.820007, 0.0000, 0.0000, 202.5000);
	CreateDynamicObject(972, 278.487457, 2461.522461, 51.788383, 34.3775, 0.0000, 191.2500);
	CreateDynamicObject(972, 276.087921, 2471.931641, 45.334709, 34.3775, 0.0000, 191.2500);
	CreateDynamicObject(972, 416.217041, 2480.567871, 38.353798, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 392.830475, 2480.372803, 38.353798, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 368.907166, 2480.539063, 38.353798, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 344.763641, 2480.453857, 38.353798, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 320.648590, 2480.204102, 38.353798, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 296.648560, 2480.161377, 38.353798, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 412.432800, 2526.115234, 38.353798, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 389.276611, 2526.073730, 38.353798, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 367.209076, 2526.189209, 38.353798, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 358.787323, 2526.033203, 38.353798, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 324.580750, 2526.136963, 38.353798, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 300.251953, 2526.373535, 38.353798, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 276.688568, 2526.658203, 38.353798, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(972, 277.742432, 2520.004639, 38.353798, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(972, 280.661102, 2479.393799, 38.005241, 0.0000, 0.0000, 103.7510);
	CreateDynamicObject(17565, -11.742923, 2501.252197, 40.325027, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1634, -89.228455, 2509.949707, 39.613670, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(4856, -202.366226, 2538.399658, 81.795387, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1634, -95.891541, 2509.930664, 44.021088, 16.3293, 0.0000, 90.0000);
	CreateDynamicObject(1634, -100.970322, 2509.958008, 50.431892, 34.3775, 359.1406, 91.7189);
	CreateDynamicObject(1634, -89.256065, 2513.790771, 39.613670, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1634, -95.739853, 2514.018799, 43.941319, 16.3293, 0.0000, 90.0000);
	CreateDynamicObject(1634, -101.347725, 2514.083496, 50.739716, 34.3775, 2.5783, 90.8594);
	CreateDynamicObject(4856, -344.965302, 2603.216553, 81.810387, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(4856, -507.357086, 2658.692627, 81.766121, 0.0000, 0.0000, 270.0001);
	CreateDynamicObject(4856, -650.027954, 2724.059814, 81.778160, 0.0000, 0.0000, 90.0004);
	CreateDynamicObject(1633, -733.819580, 2744.009277, 75.270401, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1633, -733.888733, 2747.729248, 75.317383, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1633, -733.958130, 2751.783447, 75.474724, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1633, -734.086487, 2755.941895, 75.557419, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1633, -734.179382, 2759.359375, 75.659691, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1634, 261.792175, 2516.641113, 39.362022, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1634, 261.852112, 2512.402344, 39.404221, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1634, 261.928070, 2508.103760, 39.429253, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1634, 261.918610, 2503.928955, 39.429222, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1634, 261.890839, 2499.783691, 39.454224, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1634, 261.931854, 2496.176514, 39.429222, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1634, 262.154724, 2491.950684, 39.379219, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1681, 276.341278, 2504.647949, 63.334942, 353.1245, 0.0000, 90.0000);
	CreateDynamicObject(5822, 356.467926, 2543.095703, 23.968334, 0.0000, 0.0000, 0.0001);
	CreateDynamicObject(5822, 355.584930, 2531.457031, 37.327660, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(9767, 367.762268, 2437.445801, 24.395123, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(9767, 405.550964, 2388.979004, 46.310989, 0.0000, 0.0000, 258.7500);
	CreateDynamicObject(10009, 444.205139, 2383.058105, 62.860023, 0.0000, 0.0000, 225.0000);
	CreateDynamicObject(10009, 438.019867, 2381.622314, 70.438850, 0.0000, 0.0000, 11.2499);
	CreateDynamicObject(10009, 444.182983, 2379.387939, 77.942627, 0.0000, 0.0000, 157.5001);
	CreateDynamicObject(10009, 439.763062, 2384.367432, 85.416603, 0.0000, 0.0000, 314.9999);
	CreateDynamicObject(10009, 441.514221, 2378.500488, 92.731606, 0.0000, 0.0000, 101.2500);
	CreateDynamicObject(3279, 443.544281, 2381.424561, 95.350174, 0.0000, 358.2811, 236.7138);
	CreateDynamicObject(1212, 444.946198, 2382.857178, 111.402199, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.649963, 2383.159912, 111.453583, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 444.226105, 2382.415771, 111.462761, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.394348, 2382.419434, 111.476372, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.126770, 2382.354980, 111.498863, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 441.790222, 2382.941406, 111.489693, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.143219, 2383.272461, 111.475578, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.328186, 2381.851807, 111.491692, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.573639, 2381.813721, 111.488609, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.960480, 2381.707275, 111.484909, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 444.691589, 2381.712646, 111.472733, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 445.771973, 2382.173584, 111.443375, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 444.932495, 2381.701416, 111.469048, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 444.310944, 2380.942871, 111.498314, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.841095, 2381.165527, 111.500465, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 441.854248, 2381.177490, 111.135330, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.640625, 2381.712402, 111.506516, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.359253, 2381.759277, 111.509972, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.147705, 2381.948975, 111.508698, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 441.915863, 2381.604004, 111.521172, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.003540, 2381.666748, 111.501686, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 444.589417, 2380.671875, 111.434380, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 445.333313, 2380.965576, 109.200081, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 445.271545, 2381.046875, 109.180420, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 444.454834, 2380.762207, 111.500473, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.412872, 2381.259033, 111.505173, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.388519, 2381.252930, 111.505730, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.794464, 2381.729492, 111.503555, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.559662, 2381.881836, 111.503601, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.438354, 2382.680908, 111.485558, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.781403, 2382.983398, 111.472313, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.826263, 2382.975830, 111.455299, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 444.748291, 2382.668701, 111.447815, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 444.753479, 2382.648438, 111.448242, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.900146, 2382.410889, 111.468246, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.006622, 2382.812256, 111.472893, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.954102, 2382.975098, 111.469681, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.931335, 2383.883301, 111.430801, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 445.101501, 2381.895996, 111.461380, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 445.084900, 2382.018555, 111.458580, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 445.245056, 2382.367920, 111.447174, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.281464, 2382.242676, 111.499130, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 441.865021, 2382.163086, 111.507988, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.982422, 2382.510498, 111.480873, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 444.194122, 2382.009277, 111.473488, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 444.206085, 2382.395752, 111.463600, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 444.210754, 2382.519287, 111.460411, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.518372, 2382.323242, 111.476738, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 443.480316, 2382.295410, 111.478065, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.981842, 2382.661621, 111.477089, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 442.595612, 2382.845215, 111.478844, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1239, 445.718933, 2382.598633, 112.939743, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1240, 444.434540, 2383.720703, 112.659416, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1241, 442.917328, 2384.100830, 112.800621, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1242, 441.772034, 2381.888428, 113.380531, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1247, 441.116516, 2381.551514, 112.609421, 0.0000, 0.0000, 56.2500);
	CreateDynamicObject(1248, 446.295990, 2381.978760, 112.825981, 0.0000, 0.0000, 281.2500);
	CreateDynamicObject(1252, 445.603729, 2380.836426, 113.166191, 0.0000, 0.0000, 236.2501);
	CreateDynamicObject(1253, 445.311279, 2380.427002, 113.230865, 0.0000, 0.0000, 67.5000);
	CreateDynamicObject(1254, 445.236572, 2383.332275, 112.087135, 0.0000, 0.0000, 348.7500);
	CreateDynamicObject(1274, 443.760376, 2382.248535, 112.855782, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1276, 443.485229, 2384.122070, 111.922394, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1550, 441.437561, 2381.987549, 111.849457, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2061, 444.800201, 2383.736328, 111.648788, 0.0000, 0.0000, 326.2500);
	CreateDynamicObject(1634, 211.751038, 2514.292725, 16.906248, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(2780, -727.234009, 2758.026855, 72.748566, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2780, -725.478699, 2746.562744, 72.321953, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2780, -725.791687, 2752.364990, 72.197990, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(9766, 443.558228, 2421.583496, 114.395668, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(972, 350.116180, 2527.676514, 34.928589, 0.0000, 272.3375, 335.9358);
	CreateDynamicObject(972, 353.901642, 2524.981934, 34.783051, 0.0000, 272.3375, 335.9358);
	CreateDynamicObject(1632, 352.532532, 2532.964844, 39.441345, 0.0000, 0.0000, 168.7501);
	CreateDynamicObject(972, 339.948303, 2531.638184, 38.725739, 0.0000, 2.5783, 328.0463);
	CreateDynamicObject(972, 349.087769, 2545.382080, 37.567406, 0.0000, 2.5783, 249.2962);
	CreateDynamicObject(972, 363.714783, 2542.926514, 35.983788, 0.0000, 2.5783, 159.2962);
	CreateDynamicObject(972, 357.608795, 2527.492676, 53.070145, 268.0403, 353.1245, 169.6094);
	CreateDynamicObject(624, 259.611053, 2577.566650, 75.665161, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 207.371353, 2578.473877, 75.297623, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 99.021393, 2580.113037, 76.313889, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 13.291927, 2579.687012, 76.050827, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -58.946579, 2579.056641, 75.660065, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -132.095551, 2578.700439, 75.439148, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -124.657280, 2420.357422, 58.204994, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -93.357872, 2416.071045, 58.204994, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -24.457470, 2415.135254, 58.204994, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 40.876431, 2415.644531, 59.079079, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 116.315987, 2414.099121, 58.187607, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 181.482758, 2414.341064, 58.690552, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 283.239746, 2413.873291, 58.187607, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -123.872681, 2519.916016, 80.115341, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -123.573013, 2501.427979, 79.462334, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -134.709167, 2519.310059, 80.395920, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -136.763306, 2501.470215, 80.577415, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -150.323685, 2519.449707, 81.626755, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -151.589050, 2501.032227, 81.731262, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -178.830688, 2520.021973, 83.839645, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -175.477585, 2501.000000, 83.590355, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -199.099365, 2520.289063, 85.370476, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -194.977386, 2501.208984, 85.021500, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -224.844696, 2521.454346, 87.364075, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -219.165909, 2501.501465, 86.967979, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -246.658203, 2502.448730, 88.284874, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -244.765198, 2521.110596, 88.278801, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -269.671509, 2519.853760, 88.284874, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -257.225159, 2529.380615, 88.284874, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 339.628845, 2531.804688, 15.154917, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 308.818359, 2535.559814, 15.180235, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 251.521255, 2535.860352, 15.169172, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 192.570068, 2536.316162, 15.093773, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 127.870743, 2536.850342, 15.077780, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 59.889366, 2535.936279, 14.848860, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 8.440338, 2536.458496, 14.848860, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -68.257767, 2537.395996, 14.848860, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -114.418480, 2536.604980, 17.847198, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 359.850403, 2469.169922, 15.484375, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 327.977295, 2471.906250, 14.848860, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 307.015350, 2470.500732, 14.838104, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 284.356537, 2469.102539, 14.837078, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 271.265167, 2473.693848, 14.840443, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 221.187164, 2472.171143, 14.848860, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 168.336655, 2472.937744, 14.848860, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, 78.180969, 2475.083252, 14.841105, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -33.526115, 2475.636963, 14.848860, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(624, -107.481537, 2478.616211, 14.158133, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3279, 344.667542, 2470.376953, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 317.673584, 2471.111084, 15.550779, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 296.775635, 2471.663574, 15.551184, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 275.262573, 2472.650879, 15.551908, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 263.629944, 2475.345947, 15.553883, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 252.550613, 2475.516602, 15.554008, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 239.468903, 2474.175537, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 228.037094, 2470.608398, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 113.120483, 2470.810547, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 95.423325, 2469.797607, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 83.676308, 2470.899902, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 68.343430, 2470.597168, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 54.981083, 2471.877197, 15.552237, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 37.898720, 2470.099365, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 23.906544, 2471.975830, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, 8.952248, 2472.016113, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, -6.104738, 2471.718994, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, -20.800440, 2471.731934, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, -41.809380, 2473.996582, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3279, -59.729362, 2472.786621, 15.559992, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3277, 290.547943, 2541.864990, 25.245590, 0.0000, 0.0000, 78.7500);
	CreateDynamicObject(3277, 324.350769, 2541.215332, 25.194853, 0.0000, 0.0000, 78.7500);
	CreateDynamicObject(12912, 226.817413, 2538.833740, 27.215239, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(3252, 270.193298, 2540.090576, 15.985213, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3375, 147.764633, 2503.796875, 16.768406, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(12915, 199.504333, 2505.839111, 12.028274, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(3627, -67.957726, 2503.878662, 19.323862, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1633, -23.531891, 2516.606445, 16.784666, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1633, -9.087318, 2516.600586, 16.792475, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1633, 1.926430, 2516.667969, 16.784666, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1633, 15.074404, 2516.838379, 16.784666, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1633, 27.804392, 2517.019287, 16.784666, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1633, 40.575516, 2517.135742, 16.792475, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1633, 52.513237, 2517.260498, 16.784666, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1633, 65.422134, 2517.547852, 16.784668, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1633, 81.975815, 2517.684326, 16.784666, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1633, 97.710976, 2518.043701, 16.840033, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1633, 112.926270, 2518.166016, 16.975161, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1633, 125.836914, 2517.685303, 16.956476, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1660, -34.358322, 2500.814209, 14.854301, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(2931, 1.373081, 2490.789795, 15.217792, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(3625, 5.695406, 2499.444092, 17.869558, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3665, 53.749886, 2496.250488, 17.465967, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(6052, 156.708008, 2526.906982, 18.535534, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(7979, 89.222740, 2492.838379, 18.571335, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(16401, 121.331245, 2483.751953, 15.486071, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3665, 45.412754, 2500.231445, 40.297951, 0.0000, 0.0000, 270.0000);

//casaadm
CreateDynamicObject(972, -2741.237549, -404.708984, 6.005003, 0.0000, 1.7189, 311.5623);
CreateDynamicObject(972, -2723.195313, -388.339508, 5.832245, 0.0000, 1.7189, 311.5623);
CreateDynamicObject(972, -2761.018799, -409.943573, 5.917398, 0.0000, 1.7189, 266.5623);
CreateDynamicObject(972, -2776.758057, -409.286865, 6.234732, 0.0000, 1.7189, 266.5623);
CreateDynamicObject(972, -2800.999023, -407.928497, 6.208849, 0.0000, 1.7189, 266.5623);
CreateDynamicObject(972, -2807.003418, -397.065094, 6.228168, 0.0000, 1.7189, 176.5623);
CreateDynamicObject(972, -2805.455811, -372.177338, 6.200262, 0.0000, 1.7189, 176.5623);
CreateDynamicObject(987, -2806.412598, -350.030365, 9.108198, 0.0000, 0.0000, 262.2651);
CreateDynamicObject(986, -2803.305176, -346.110199, 7.898168, 0.0000, 0.0000, 24.2189);
CreateDynamicObject(973, -2806.957764, -348.724365, 11.026449, 0.0000, 270.6186, 87.3443);
CreateDynamicObject(986, -2800.302490, -314.855591, 7.898168, 0.0000, 0.0000, 144.5311);
CreateDynamicObject(972, -2644.545166, -223.197906, 3.230215, 0.0000, 1.7189, 86.5623);
CreateDynamicObject(972, -2666.324951, -223.690125, 3.332819, 0.0000, 1.7189, 97.7348);
CreateDynamicObject(972, -2622.349365, -224.085968, 4.050215, 0.0000, 1.7189, 86.4848);
CreateDynamicObject(972, -2600.125244, -223.730789, 4.477797, 0.0000, 1.7189, 91.7188);
CreateDynamicObject(972, -2578.198730, -223.047028, 4.391489, 0.0000, 1.7189, 91.7188);
CreateDynamicObject(972, -2560.347656, -222.198990, 9.430864, 343.6707, 0.0000, 92.5783);
CreateDynamicObject(972, -2539.879639, -222.362167, 14.622272, 343.6707, 0.0000, 92.5783);
CreateDynamicObject(972, -2521.239502, -221.744019, 19.079592, 343.6707, 0.0000, 92.5783);
CreateDynamicObject(971, -2512.727783, -220.539764, 27.912125, 0.0000, 0.0000, 258.7500);
CreateDynamicObject(972, -2530.105225, -233.564209, 20.992336, 1.7189, 2.5783, 177.4216);
CreateDynamicObject(972, -2532.597168, -255.976135, 20.988276, 1.7189, 2.5783, 166.1716);
CreateDynamicObject(972, -2538.876465, -279.840027, 30.799635, 1.7189, 2.5783, 166.1716);
CreateDynamicObject(972, -2535.053711, -264.975403, 29.746429, 1.7189, 2.5783, 166.1716);
CreateDynamicObject(972, -2542.954834, -295.629272, 25.428009, 1.7189, 2.5783, 166.1716);
CreateDynamicObject(972, -2546.977295, -311.536926, 25.563223, 1.7189, 2.5783, 166.1716);
CreateDynamicObject(972, -2566.189697, -315.705627, 23.935844, 1.7189, 2.5783, 267.4216);
CreateDynamicObject(972, -2585.929443, -318.566254, 22.093376, 1.7189, 358.2811, 282.8914);
CreateDynamicObject(972, -2604.500488, -322.843445, 21.304922, 1.7189, 358.2811, 282.8914);
CreateDynamicObject(972, -2622.417480, -334.619843, 11.200037, 1.7189, 358.2811, 282.8914);
CreateDynamicObject(972, -2644.616943, -343.434601, 7.896191, 1.7189, 358.2811, 282.8914);
CreateDynamicObject(972, -2663.843018, -351.305939, 5.278131, 1.7189, 358.2811, 294.1414);
CreateDynamicObject(972, -2685.046631, -360.639954, 5.328861, 1.7189, 358.2811, 294.1414);
CreateDynamicObject(972, -2705.760010, -373.514496, 5.648832, 1.7189, 358.2811, 305.3914);
CreateDynamicObject(3749, -2796.145508, -329.901733, 11.897477, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(986, -2797.677734, -316.917450, 7.898168, 0.0000, 0.0000, 88.2811);
CreateDynamicObject(986, -2797.690918, -341.007599, 7.898168, 0.0000, 0.0000, 88.2811);


//basepnx
CreateDynamicObject(987, 1304.854004, -1880.641846, 16.505630, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(987, 1292.841187, -1880.677734, 16.527397, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(987, 1281.147705, -1880.516357, 16.591311, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(987, 1270.821289, -1880.843994, 16.652512, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(987, 1259.462646, -1881.276978, 16.764254, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(972, 1245.139404, -1885.590820, 18.729851, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(972, 1227.974487, -1891.208252, 18.781420, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(972, 1220.515503, -1894.644165, 17.552073, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(972, 1195.667236, -1894.790039, 17.584990, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(972, 1173.533081, -1895.256836, 17.528131, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(972, 1148.761475, -1895.010986, 17.534597, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(972, 1125.073486, -1894.948120, 17.622959, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(972, 1100.087402, -1895.910156, 17.453682, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(972, 1085.879639, -1895.966797, 17.406252, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(972, 1076.572754, -1901.641968, 17.356256, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(972, 1076.609131, -1926.016357, 17.417891, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(972, 1076.045288, -1950.931641, 17.634483, 0.0000, 0.0000, 178.2039);
CreateDynamicObject(972, 1074.654785, -1958.618652, 18.277655, 0.0000, 0.0000, 166.9539);
CreateDynamicObject(972, 1100.541138, -2332.768066, 12.030499, 0.0000, 0.0000, 31.9538);
CreateDynamicObject(972, 1113.827881, -2353.584717, 11.869614, 0.0000, 0.0000, 31.9538);
CreateDynamicObject(972, 1129.976074, -2352.815674, 11.556284, 0.0000, 0.0000, 290.7038);
CreateDynamicObject(972, 1153.222900, -2344.734131, 11.979998, 0.0000, 0.0000, 290.7038);
CreateDynamicObject(972, 1173.147583, -2337.301270, 12.506512, 0.0000, 0.0000, 290.7038);
CreateDynamicObject(972, 1193.909546, -2329.416016, 12.743406, 0.0000, 0.0000, 290.7038);
CreateDynamicObject(972, 1205.380859, -2316.965332, 12.760586, 0.0000, 0.0000, 358.2038);
CreateDynamicObject(972, 1207.461548, -2297.096680, 13.011885, 0.0000, 0.0000, 346.9538);
CreateDynamicObject(972, 1213.165771, -2277.796631, 13.028128, 0.0000, 0.0000, 335.7038);
CreateDynamicObject(972, 1210.977173, -2258.379395, 13.179695, 0.0000, 0.0000, 245.7038);
CreateDynamicObject(972, 1211.778442, -2312.793945, 19.496151, 0.0000, 0.0000, 178.2039);
CreateDynamicObject(972, 1193.760254, -2329.225586, 19.567995, 0.0000, 0.0000, 290.7041);
CreateDynamicObject(972, 1175.024414, -2336.490723, 19.739193, 0.0000, 0.0000, 290.7041);
CreateDynamicObject(972, 1215.288818, -2289.467041, 19.339628, 0.0000, 0.0000, 155.7040);
CreateDynamicObject(972, 1219.006348, -2279.960693, 20.358027, 0.0000, 0.0000, 155.7040);
CreateDynamicObject(972, 1220.391968, -2271.287842, 18.192789, 0.0000, 0.0000, 155.7040);
CreateDynamicObject(972, 1526.419067, -2086.791748, 26.100405, 0.0000, 0.0000, 110.7040);
CreateDynamicObject(972, 1503.325562, -2093.114990, 27.515659, 0.0000, 0.0000, 99.4540);
CreateDynamicObject(972, 1532.535645, -2108.290039, 13.353472, 0.0000, 0.0000, 99.4540);
CreateDynamicObject(972, 1512.169434, -2111.282959, 13.107605, 0.0000, 0.0000, 99.4540);
CreateDynamicObject(972, 1491.136841, -2112.876221, 12.832708, 0.0000, 0.0000, 83.9068);
CreateDynamicObject(972, 1474.323608, -2110.688721, 12.634227, 0.0000, 0.0000, 89.0635);
CreateDynamicObject(972, 1456.110352, -2110.416260, 12.543756, 0.0000, 0.0000, 89.0635);
CreateDynamicObject(972, 1437.245850, -2111.440918, 12.551394, 0.0000, 357.4217, 93.3608);
CreateDynamicObject(972, 1416.454224, -2114.043701, 12.543756, 0.0000, 357.4217, 103.6743);
CreateDynamicObject(972, 1394.802979, -2122.354980, 12.799299, 0.0000, 355.7028, 120.8634);
CreateDynamicObject(972, 1556.647461, -2102.062744, 14.315449, 0.0000, 355.7028, 109.6134);
CreateDynamicObject(972, 1573.199951, -2095.764160, 16.201494, 0.0000, 355.7028, 115.6296);
CreateDynamicObject(972, 1595.912354, -2085.394043, 16.374395, 0.0000, 355.7028, 115.6296);
CreateDynamicObject(972, 1611.752808, -2067.155518, 17.642265, 0.0000, 356.5623, 158.9106);
CreateDynamicObject(972, 1619.008545, -2061.519287, 19.926298, 0.0000, 356.5623, 136.4107);
CreateDynamicObject(972, 1633.623169, -2039.639160, 19.514015, 0.0000, 0.0000, 147.6607);
CreateDynamicObject(972, 1642.691772, -2021.077393, 19.873362, 0.0000, 0.0000, 158.9106);
CreateDynamicObject(972, 1649.051758, -1996.504517, 22.307089, 0.0000, 0.0000, 170.1606);
CreateDynamicObject(972, 1649.524414, -1971.251587, 22.433245, 0.0000, 0.0000, 185.0025);
CreateDynamicObject(972, 1644.567871, -1946.997437, 23.007643, 0.0000, 0.0000, 196.2525);
CreateDynamicObject(972, 1638.089966, -1924.434448, 23.475311, 0.0000, 0.0000, 196.2525);
CreateDynamicObject(972, 1631.462524, -1901.562256, 23.986887, 0.0000, 0.0000, 196.2525);
CreateDynamicObject(972, 1625.468750, -1879.446899, 24.183231, 0.0000, 0.0000, 196.2525);
CreateDynamicObject(972, 1616.757324, -1899.692627, 24.150087, 0.0000, 0.0000, 95.0027);
CreateDynamicObject(972, 1617.501953, -1900.643311, 17.355881, 0.0000, 0.0000, 95.0027);
CreateDynamicObject(972, 1615.557251, -1901.879028, 18.355881, 0.0000, 0.0000, 95.0027);
CreateDynamicObject(972, 1624.235107, -1904.552002, 17.553417, 0.0000, 0.0000, 5.0028);
CreateDynamicObject(972, 1599.080444, -1896.860229, 18.362581, 0.0000, 0.0000, 275.0029);
CreateDynamicObject(972, 1599.010132, -1895.413086, 23.881014, 0.0000, 0.0000, 275.0029);
CreateDynamicObject(972, 1599.110229, -1904.715088, 26.142944, 0.0000, 0.0000, 185.0030);
CreateDynamicObject(972, 1590.058594, -1916.985474, 21.924349, 0.0000, 0.0000, 69.2210);
CreateDynamicObject(972, 1579.014648, -1918.111938, 21.266722, 0.0000, 0.0000, 91.7210);
CreateDynamicObject(972, 1590.483032, -1916.388916, 27.754248, 0.0000, 0.0000, 69.2210);
CreateDynamicObject(972, 1579.108643, -1917.696045, 26.424900, 0.0000, 0.0000, 91.7210);
CreateDynamicObject(972, 1555.123291, -1918.630005, 21.609413, 0.0000, 0.0000, 91.7210);
CreateDynamicObject(972, 1554.998779, -1918.329224, 28.170424, 0.0000, 0.0000, 91.7210);
CreateDynamicObject(972, 1509.675781, -1923.577148, 21.205883, 0.0000, 0.0000, 91.7210);
CreateDynamicObject(972, 1485.683105, -1924.356079, 21.263035, 0.0000, 0.0000, 91.7210);
CreateDynamicObject(972, 1460.497314, -1925.359985, 21.593801, 0.0000, 0.0000, 91.7210);
CreateDynamicObject(972, 1526.856323, -2071.651367, 25.538256, 0.0000, 0.0000, 16.3297);
CreateDynamicObject(972, 1521.756104, -2054.357666, 26.149920, 0.0000, 0.0000, 16.3297);
CreateDynamicObject(972, 1516.818726, -2029.766846, 28.260267, 0.0000, 0.0000, 5.0797);
CreateDynamicObject(972, 1515.441528, -2008.433594, 25.429981, 0.0000, 0.0000, 5.0797);
CreateDynamicObject(972, 1513.941162, -1987.650879, 25.078020, 0.0000, 0.0000, 5.0797);
CreateDynamicObject(972, 1510.715942, -1966.512085, 22.339880, 0.0000, 0.0000, 5.0797);
CreateDynamicObject(972, 1510.654663, -1966.043457, 28.421450, 0.0000, 0.0000, 5.0797);
CreateDynamicObject(972, 1509.330444, -1953.491943, 21.197903, 0.0000, 0.0000, 5.0797);
CreateDynamicObject(972, 1507.559814, -1932.656372, 21.032583, 0.0000, 0.0000, 5.0797);
CreateDynamicObject(972, 1445.728516, -1919.090088, 21.388231, 0.0000, 0.0000, 275.0797);
CreateDynamicObject(972, 1384.283936, -1900.523315, 16.516241, 0.0000, 0.0000, 275.0797);
CreateDynamicObject(972, 1367.521973, -1898.892822, 16.599859, 0.0000, 0.0000, 252.7339);
CreateDynamicObject(972, 1300.693604, -1876.830200, 15.561071, 0.0000, 0.0000, 275.2339);
CreateDynamicObject(3749, 1426.859619, -1887.564209, 18.288433, 0.0000, 0.0000, 0.0000);

//nascer
CreateDynamicObject(1609, -2290.947021, 728.933960, 48.899487, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(8378, -2362.428711, 725.510986, 46.634369, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3749, -2278.503174, 727.105957, 54.228722, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(13667, -2273.898438, 735.737671, 64.185585, 0.0000, 0.0000, 11.2500);
CreateDynamicObject(13667, -2274.384033, 720.171509, 64.185585, 0.0000, 0.0000, 11.2500);
CreateDynamicObject(9833, -2279.368408, 722.390442, 45.147858, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(9833, -2282.575928, 722.617004, 45.147873, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(9833, -2279.968262, 724.711304, 45.122612, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(9833, -2279.598145, 726.058716, 45.047607, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(9833, -2279.547119, 727.816467, 44.397858, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(9833, -2279.931396, 730.331360, 44.624107, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(9833, -2280.686523, 728.383789, 45.122612, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(9833, -2281.197266, 730.544861, 44.874454, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(7916, -2317.608643, 733.663452, 52.284454, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1609, -2349.059814, 729.119629, 40.508499, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(1609, -2349.084229, 724.957275, 40.502625, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(1609, -2342.273438, 725.347534, 42.089165, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(2780, -2352.024902, 723.089539, 39.333851, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2780, -2353.776367, 729.265137, 38.932831, 0.0000, 0.0000, 0.0000);

//natal

CreateDynamicObject(10985, 1939.571655, 1517.079956, 7.831814, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(731, 1940.100586, 1516.329956, 9.182678, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1223, 1939.475342, 1516.377319, 12.593370, 316.1687, 358.2811, 226.8734);
CreateDynamicObject(1223, 1940.213135, 1516.602539, 16.924454, 316.1687, 358.2811, 226.8734);
CreateDynamicObject(1223, 1939.851807, 1516.602539, 18.772364, 316.1687, 358.2811, 226.8734);
CreateDynamicObject(1223, 1939.445679, 1516.602539, 18.735613, 316.1687, 358.2811, 226.8734);
CreateDynamicObject(1223, 1939.404785, 1516.602539, 24.016308, 316.1687, 358.2811, 226.8734);
CreateDynamicObject(1223, 1939.527344, 1516.602539, 12.823879, 316.1687, 358.2811, 226.8734);
CreateDynamicObject(1223, 1938.942871, 1517.155396, 12.899727, 316.1687, 358.2811, 226.8734);
CreateDynamicObject(1223, 1939.067139, 1518.847778, 14.293457, 316.1687, 358.2811, 226.8734);
CreateDynamicObject(1223, 1939.067139, 1518.847778, 14.293457, 316.1687, 358.2811, 226.8734);
CreateDynamicObject(1223, 1939.067139, 1518.847778, 14.293457, 316.1687, 358.2811, 226.8734);
CreateDynamicObject(1223, 1941.667603, 1517.698730, 14.150457, 316.1687, 358.2811, 136.8734);
CreateDynamicObject(700, 1938.942871, 1517.306885, 9.915194, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.302002, 1516.602539, 10.141199, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.157349, 1516.602539, 10.176665, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.665649, 1516.602539, 10.315904, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.592896, 1516.602539, 10.099344, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.957275, 1516.602539, 10.018352, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.030396, 1516.602539, 10.234672, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.884277, 1516.602539, 10.165818, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.908691, 1516.902466, 9.590631, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.731079, 1516.304688, 9.533854, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.621948, 1515.680420, 9.253029, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.621948, 1515.680420, 9.253029, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.621948, 1515.680420, 9.253029, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.350098, 1515.276733, 9.044241, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.407349, 1516.602539, 10.585461, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.472900, 1516.602539, 10.192091, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.604248, 1516.602539, 10.187551, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.670044, 1516.602539, 9.793373, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.664917, 1516.038940, 9.338239, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.774292, 1515.898804, 9.256317, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.838379, 1515.902588, 9.251898, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.538574, 1516.602539, 9.798355, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.101807, 1516.147705, 9.449093, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.921631, 1515.556152, 9.166473, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1939.163330, 1516.496460, 10.125670, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.016846, 1518.859985, 10.036680, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.553589, 1518.847778, 10.595085, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.934692, 1518.847778, 9.900208, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1940.934692, 1518.847778, 9.900208, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(700, 1938.942871, 1515.578491, 41.885239, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(1232, 1942.096191, 1519.325562, 17.282131, 268.0403, 357.4217, 0.0000);
CreateDynamicObject(5822, 1940.775879, 1507.105225, 16.052668, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(8572, 1942.462891, 1511.421387, 23.493816, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(8572, 1944.200317, 1514.829956, 26.678352, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(8572, 1940.602295, 1517.376587, 30.062893, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(8572, 1938.705566, 1513.749390, 33.447430, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(8572, 1942.268188, 1511.763062, 36.931973, 0.0000, 0.0000, 0.0001);
CreateDynamicObject(8572, 1947.786865, 1511.728027, 40.316509, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(8572, 1949.619263, 1515.041748, 43.676044, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(8572, 1946.171021, 1516.907593, 47.085583, 0.0000, 0.0000, 179.9999);
CreateDynamicObject(8572, 1944.431152, 1519.844971, 50.595127, 0.0000, 0.0000, 89.9999);
CreateDynamicObject(8572, 1941.046997, 1521.789551, 53.979664, 0.0000, 0.0000, 179.9998);
CreateDynamicObject(8572, 1939.152588, 1518.406128, 57.389202, 0.0000, 0.0000, 269.9998);
CreateDynamicObject(3280, 1940.798950, 1516.452881, 58.773586, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3280, 1940.781006, 1517.979004, 58.773586, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3280, 1942.331055, 1517.996582, 58.773586, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3280, 1942.325317, 1516.435547, 58.773586, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2780, 1940.222534, 1515.102539, 10.853703, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(9833, 1938.893677, 1516.523315, 54.142342, 0.0000, 0.0000, 0.0000);


//stunts,races,arenas,circuitos ls,lv,sf .etc...
CreateDynamicObject(4853,2726.863,1835.499,8.638,0.0,0.0,0.0);
CreateDynamicObject(3578,2736.050,1982.287,6.512,0.0,0.0,-90.000);
CreateDynamicObject(3578,1428.839,2441.746,6.567,0.0,0.0,-371.248);
CreateDynamicObject(3578,1412.078,2444.267,6.601,0.0,0.0,-371.248);
CreateDynamicObject(3578,1376.766,2475.116,6.519,0.0,0.0,-348.748);
CreateDynamicObject(3578,1355.682,2469.666,6.512,0.0,0.0,-337.501);
CreateDynamicObject(3578,1235.421,2162.451,6.548,0.0,0.0,-438.748);
CreateDynamicObject(3578,1233.493,2178.089,6.512,0.0,0.0,-450.001);
CreateDynamicObject(3578,1202.601,2289.398,6.533,0.0,0.0,-292.501);
CreateDynamicObject(3578,1207.140,2307.615,6.525,0.0,0.0,-292.501);
CreateDynamicObject(3578,1234.460,1947.932,6.512,0.0,0.0,-281.248);
CreateDynamicObject(3578,1233.661,1933.741,6.510,0.0,0.0,-270.001);
CreateDynamicObject(3578,1200.647,1956.100,6.520,0.0,0.0,-270.001);
CreateDynamicObject(3578,1201.311,1943.139,6.512,0.0,0.0,-270.001);
CreateDynamicObject(3578,1235.206,1700.801,6.460,0.0,0.0,-281.248);
CreateDynamicObject(3578,1234.013,1683.038,6.512,0.0,0.0,-281.248);
CreateDynamicObject(3578,1199.438,1699.726,6.457,0.0,0.0,-270.001);
CreateDynamicObject(3578,1198.175,1678.422,6.512,0.0,0.0,-270.001);
CreateDynamicObject(3578,1235.551,1149.178,5.873,0.0,0.0,-270.001);
CreateDynamicObject(3578,1236.879,1127.692,6.591,0.0,0.0,-270.001);
CreateDynamicObject(3578,1202.977,1015.067,6.603,0.0,0.0,-258.748);
CreateDynamicObject(3578,1206.171,999.609,6.621,0.0,0.0,-258.748);
CreateDynamicObject(3578,1354.453,832.599,6.601,0.0,0.0,-225.001);
CreateDynamicObject(3578,2160.878,862.209,6.512,0.0,0.0,-371.248);
CreateDynamicObject(3578,2168.228,821.244,6.483,0.0,0.0,-348.748);
CreateDynamicObject(3578,2419.377,859.982,6.512,0.0,0.0,0.0);
CreateDynamicObject(3578,2401.385,859.682,6.489,0.0,0.0,0.0);
CreateDynamicObject(3578,2428.762,825.570,6.512,0.0,0.0,0.0);
CreateDynamicObject(3578,2404.533,825.793,6.485,0.0,0.0,0.0);
CreateDynamicObject(3578,2699.227,1338.297,6.517,0.0,0.0,-270.001);
CreateDynamicObject(3578,2698.748,1355.247,6.485,0.0,0.0,-270.001);
CreateDynamicObject(3578,2738.119,1359.346,6.454,0.0,0.0,-270.001);
CreateDynamicObject(3578,2737.879,1342.046,6.512,0.0,0.0,-270.001);
CreateDynamicObject(3578,2700.306,1606.161,6.520,0.0,0.0,-270.001);
CreateDynamicObject(3578,2698.885,1587.370,6.463,0.0,0.0,-270.001);
CreateDynamicObject(3578,2735.122,1611.708,6.512,0.0,0.0,-270.001);
CreateDynamicObject(3578,2735.948,1586.376,6.457,0.0,0.0,-247.501);
CreateDynamicObject(3578,2698.885,1986.296,6.520,0.0,0.0,-281.248);
CreateDynamicObject(3578,2700.547,2249.208,6.520,0.0,0.0,-270.001);
CreateDynamicObject(3578,2701.088,2230.176,6.488,0.0,0.0,-270.001);
CreateDynamicObject(3578,2734.957,2257.106,6.512,0.0,0.0,-270.001);
CreateDynamicObject(3578,2734.812,2225.728,6.471,0.0,0.0,-270.001);
CreateDynamicObject(3578,1643.081,2447.766,6.825,0.0,0.0,-180.000);
CreateDynamicObject(3578,1670.918,2446.998,6.760,0.0,0.0,0.0);
CreateDynamicObject(3578,1527.286,2479.340,6.562,0.0,0.0,0.0);
CreateDynamicObject(3578,1421.026,866.104,6.592,0.0,0.0,-348.748);
CreateDynamicObject(13592,1508.962,-2604.693,24.117,0.0,-341.093,0.0);
CreateDynamicObject(13592,1504.887,-2611.826,24.705,0.0,-329.061,0.0);
CreateDynamicObject(1634,1886.696,-2543.177,18.484,-339.374,0.0,-268.041);
CreateDynamicObject(1634,1883.329,-2537.417,13.844,-355.704,0.0,-268.041);
CreateDynamicObject(1634,1884.175,-2548.672,13.844,-355.704,0.0,-273.198);
CreateDynamicObject(8040,2026.501,-2637.475,13.317,0.0,0.0,-540.001);
CreateDynamicObject(1634,2068.637,-2493.344,13.594,0.0,0.0,-449.382);
CreateDynamicObject(1634,2074.473,-2493.274,18.951,-327.342,0.0,-449.382);
CreateDynamicObject(1634,2076.707,-2493.256,25.983,-296.403,0.0,-449.382);
CreateDynamicObject(1634,2075.325,-2493.254,33.528,-273.198,0.0,-449.382);
CreateDynamicObject(1634,2071.663,-2493.293,40.018,-258.587,0.0,-449.382);
CreateDynamicObject(1634,2065.825,-2493.339,46.889,-250.852,0.0,-449.382);
CreateDynamicObject(1634,1717.415,-2408.503,13.852,0.0,0.0,0.0);
CreateDynamicObject(1634,1717.392,-2403.310,17.218,-346.250,0.0,0.0);
CreateDynamicObject(1634,1717.391,-2398.234,22.828,-329.061,0.0,0.0);
CreateDynamicObject(1634,1777.541,-2564.099,20.585,-311.013,0.0,-184.676);
CreateDynamicObject(1634,1777.839,-2559.917,13.844,-346.250,0.0,-184.676);
CreateDynamicObject(1894,1528.738,-2507.311,12.555,0.0,0.0,-180.379);
CreateDynamicObject(16098,1553.809,-2461.125,12.093,0.0,0.0,-450.242);
CreateDynamicObject(3361,1656.095,-2533.398,17.580,0.0,0.0,0.0);
CreateDynamicObject(8395,1551.757,-2544.952,-3.315,0.0,-390.081,-357.423);
CreateDynamicObject(13643,1884.320,-2556.413,13.743,0.0,0.0,-538.764);
CreateDynamicObject(16085,1746.979,-2540.889,13.734,0.0,0.0,0.0);
CreateDynamicObject(17565,2109.813,-2544.002,14.398,0.0,0.0,0.0);
CreateDynamicObject(18451,1988.956,-2622.899,13.014,0.0,0.0,-268.901);
CreateDynamicObject(7979,1413.963,-2425.484,17.192,-347.109,0.0,0.0);
CreateDynamicObject(13641,1990.476,-2261.313,14.216,0.0,0.0,-273.198);
CreateDynamicObject(3279,2252.046,-929.425,1428.391,0.0,0.0,0.0);
CreateDynamicObject(3279,2249.436,-926.882,1444.144,0.0,0.0,0.0);
CreateDynamicObject(3279,-1064.545,-2212.311,10917.647,0.0,0.0,0.0);
CreateDynamicObject(3279,-1067.730,-2209.854,10933.547,0.0,0.0,0.0);
CreateDynamicObject(987,1743.334,-1742.079,53.569,0.0,0.0,0.0);
CreateDynamicObject(987,1754.827,-1742.108,53.569,0.0,0.0,0.0);
CreateDynamicObject(987,1766.589,-1742.028,53.480,0.0,0.0,0.0);
CreateDynamicObject(987,1778.574,-1741.979,53.569,0.0,0.0,0.0);
CreateDynamicObject(987,1790.235,-1742.028,53.529,0.0,0.0,0.0);
CreateDynamicObject(987,1801.080,-1742.028,53.440,0.0,0.0,0.0);
CreateDynamicObject(987,1812.125,-1742.069,53.569,0.0,0.0,-451.961);
CreateDynamicObject(987,1811.683,-1753.962,53.569,0.0,0.0,-451.961);
CreateDynamicObject(987,1811.301,-1765.756,53.569,0.0,0.0,-451.961);
CreateDynamicObject(987,1810.977,-1777.470,53.569,0.0,0.0,-451.961);
CreateDynamicObject(987,1810.592,-1789.181,53.569,0.0,0.0,-451.961);
CreateDynamicObject(987,1810.260,-1797.910,53.569,0.0,0.0,-451.961);
CreateDynamicObject(987,1743.344,-1742.022,53.569,0.0,0.0,-451.961);
CreateDynamicObject(987,1742.934,-1753.725,53.569,0.0,0.0,-451.961);
CreateDynamicObject(987,1742.487,-1765.285,53.569,0.0,0.0,-451.961);
CreateDynamicObject(987,1742.282,-1776.201,53.569,0.0,0.0,-447.663);
CreateDynamicObject(987,1742.589,-1787.405,53.569,0.0,0.0,-447.663);
CreateDynamicObject(987,1742.493,-1797.802,53.569,0.0,0.0,-447.663);
CreateDynamicObject(987,1773.757,-1808.522,53.569,0.0,0.0,-360.860);
CreateDynamicObject(987,1785.400,-1808.486,53.569,0.0,0.0,-360.860);
CreateDynamicObject(987,1797.122,-1808.985,53.569,0.0,0.0,-360.860);
CreateDynamicObject(987,1762.074,-1808.265,53.569,0.0,0.0,-360.860);
CreateDynamicObject(987,1750.573,-1808.754,53.569,0.0,0.0,-359.141);
CreateDynamicObject(987,1742.248,-1808.783,53.569,0.0,0.0,-359.141);
CreateDynamicObject(987,-2619.056,696.576,66.202,0.0,0.0,-180.000);
CreateDynamicObject(987,-2631.109,696.499,66.202,0.0,0.0,-180.000);
CreateDynamicObject(987,-2643.073,696.622,66.202,0.0,0.0,-180.000);
CreateDynamicObject(987,-2655.059,697.000,66.202,0.0,0.0,-180.000);
CreateDynamicObject(987,-2667.111,696.805,66.202,0.0,0.0,-180.000);
CreateDynamicObject(987,-2678.962,697.221,66.202,0.0,0.0,-180.000);
CreateDynamicObject(987,-2690.982,697.239,66.202,0.0,0.0,-180.000);
CreateDynamicObject(987,-2703.004,696.714,66.202,0.0,0.0,-180.000);
CreateDynamicObject(987,-2715.089,696.474,66.202,0.0,0.0,-180.000);
CreateDynamicObject(987,-2727.160,696.744,66.202,0.0,0.0,-180.000);
CreateDynamicObject(987,-2739.392,697.419,66.202,0.0,0.0,-90.000);
CreateDynamicObject(987,-2739.128,685.408,66.202,0.0,0.0,-90.000);
CreateDynamicObject(987,-2739.698,673.375,66.202,0.0,0.0,-90.000);
CreateDynamicObject(987,-2739.722,661.412,66.202,0.0,0.0,-90.000);
CreateDynamicObject(987,-2739.656,649.407,66.202,0.0,0.0,-90.000);
CreateDynamicObject(987,-2739.243,632.684,66.202,0.0,0.0,0.0);
CreateDynamicObject(987,-2727.245,632.779,66.202,0.0,0.0,0.0);
CreateDynamicObject(987,-2715.310,632.965,66.202,0.0,0.0,0.0);
CreateDynamicObject(987,-2704.008,632.553,66.202,0.0,0.0,0.0);
CreateDynamicObject(987,-2691.643,632.650,66.202,0.0,0.0,-450.001);
CreateDynamicObject(987,-2692.144,620.620,66.202,0.0,0.0,-90.000);
CreateDynamicObject(987,-2692.397,608.686,66.202,0.0,0.0,-90.000);
CreateDynamicObject(987,-2694.040,579.361,66.202,0.0,0.0,0.0);
CreateDynamicObject(987,-2682.117,579.245,66.202,0.0,0.0,0.0);
CreateDynamicObject(987,-2670.111,579.195,66.202,0.0,0.0,0.0);
CreateDynamicObject(987,-2658.179,579.535,66.202,0.0,0.0,0.0);
CreateDynamicObject(987,-2692.551,596.710,66.202,0.0,0.0,-90.000);
CreateDynamicObject(987,-2646.198,579.565,66.202,0.0,0.0,0.0);
CreateDynamicObject(987,-2634.267,579.708,66.202,0.0,0.0,-348.748);
CreateDynamicObject(987,-2623.611,582.903,66.203,0.0,0.0,-303.748);
CreateDynamicObject(987,-2617.644,592.847,66.202,0.0,0.0,-270.001);
CreateDynamicObject(987,-2618.112,604.768,66.202,0.0,0.0,-270.001);
CreateDynamicObject(987,-2618.365,616.612,66.202,0.0,0.0,-270.001);
CreateDynamicObject(987,-2618.234,628.626,66.202,0.0,0.0,-270.001);
CreateDynamicObject(987,-2618.238,640.584,66.202,0.0,0.0,-270.001);
CreateDynamicObject(987,-2618.251,652.538,66.202,0.0,0.0,-270.001);
CreateDynamicObject(987,-2617.942,664.837,66.202,0.0,0.0,-270.001);
CreateDynamicObject(987,-2617.847,676.838,66.202,0.0,0.0,-270.001);
CreateDynamicObject(987,-2618.134,685.745,66.218,0.0,0.0,-258.748);
CreateDynamicObject(987,-2739.430,643.500,66.359,0.0,0.0,-450.001);
CreateDynamicObject(987,-2692.483,590.802,66.264,0.0,0.0,-90.000);
CreateDynamicObject(1634,2067.191,1080.568,10.969,0.0,0.0,0.0);
CreateDynamicObject(1634,2041.940,1191.615,10.969,0.0,0.0,-270.001);
CreateDynamicObject(1634,1999.332,1206.190,18.383,0.0,0.0,-180.000);
CreateDynamicObject(1634,1979.879,1109.229,22.816,0.0,0.0,-180.000);
CreateDynamicObject(1634,1894.697,1055.537,22.148,0.0,0.0,-247.501);
CreateDynamicObject(13641,2075.141,1482.833,11.341,0.0,0.0,-270.001);
CreateDynamicObject(13641,2074.373,1528.646,11.399,0.0,0.0,-90.000);
CreateDynamicObject(1634,2069.123,1392.377,10.427,-345.390,0.0,0.0);
CreateDynamicObject(1634,2068.678,1394.402,15.432,-311.013,0.0,0.0);
CreateDynamicObject(1634,2068.571,1394.460,19.867,-290.386,0.0,-353.985);
CreateDynamicObject(13641,2069.115,1392.868,24.708,-359.141,-81.646,-263.904);
CreateDynamicObject(1634,2057.309,2017.360,235.249,-318.748,0.0,0.0);
CreateDynamicObject(1634,2061.563,2017.292,235.180,-318.748,0.0,0.0);
CreateDynamicObject(1634,2065.749,2017.230,235.128,-318.748,0.0,0.0);
CreateDynamicObject(1634,2069.634,2017.259,235.152,-319.607,0.0,0.0);
CreateDynamicObject(1634,2073.105,2017.263,235.156,-319.607,0.0,0.0);
CreateDynamicObject(1634,2076.807,2017.233,235.130,-318.748,0.0,0.0);
CreateDynamicObject(1634,2080.508,2017.198,235.075,-319.607,0.0,0.0);
CreateDynamicObject(1634,2084.662,2017.168,235.075,-320.467,0.0,0.0);
CreateDynamicObject(1634,2088.839,2017.153,235.062,-320.467,0.0,0.0);
CreateDynamicObject(1634,2092.429,2017.218,235.150,-320.467,0.0,0.0);
CreateDynamicObject(8171,2075.361,2084.519,232.006,0.0,0.0,0.0);
CreateDynamicObject(8171,2074.098,2213.370,194.702,-31.799,0.0,0.0);
CreateDynamicObject(8171,2074.262,2335.310,158.705,0.0,0.0,0.0);
CreateDynamicObject(1634,2091.423,2402.500,160.002,0.0,0.0,0.0);
CreateDynamicObject(1634,2087.247,2402.503,160.002,0.0,0.0,0.0);
CreateDynamicObject(1634,2083.220,2402.345,160.002,0.0,0.0,0.0);
CreateDynamicObject(1634,2079.189,2402.396,160.002,0.0,0.0,0.0);
CreateDynamicObject(1634,2075.000,2402.586,160.002,0.0,0.0,0.0);
CreateDynamicObject(1634,2070.934,2402.586,160.002,0.0,0.0,0.0);
CreateDynamicObject(1634,2066.862,2402.814,160.002,0.0,0.0,0.0);
CreateDynamicObject(1634,2062.769,2402.832,160.002,0.0,0.0,0.0);
CreateDynamicObject(1634,2058.626,2402.837,160.002,0.0,0.0,0.0);
CreateDynamicObject(1634,2056.343,2402.933,160.002,0.0,0.0,0.0);
CreateDynamicObject(13592,2068.173,2332.910,168.426,0.0,0.0,-90.000);
CreateDynamicObject(13592,2046.608,1256.356,19.618,0.0,0.0,-90.000);
CreateDynamicObject(13592,2062.506,1080.623,23.392,-6.875,-44.691,-270.001);
CreateDynamicObject(13592,2039.487,1257.238,19.743,0.0,0.0,-90.000);
CreateDynamicObject(13592,2045.083,1666.515,19.168,0.0,0.0,-270.001);
CreateDynamicObject(1634,2061.488,1101.643,10.769,-342.812,-352.266,-188.669);
CreateDynamicObject(1634,2090.377,972.455,10.969,0.0,0.0,-270.001);
CreateDynamicObject(1634,2087.193,972.513,12.551,-354.844,0.0,-270.001);
CreateDynamicObject(1634,2084.050,972.419,14.789,-348.828,0.0,-270.001);
CreateDynamicObject(1634,2081.598,972.476,16.764,-342.812,0.0,-270.001);
CreateDynamicObject(1634,2078.634,972.206,19.902,-335.077,0.0,-270.001);
CreateDynamicObject(1634,2075.796,972.335,24.107,-323.905,0.0,-270.001);
CreateDynamicObject(1634,2072.808,972.300,30.850,-312.732,0.0,-270.001);
CreateDynamicObject(13592,2079.319,969.262,46.277,0.0,-289.527,-355.704);
CreateDynamicObject(1634,2065.648,966.267,51.363,-322.186,-352.266,-277.810);
CreateDynamicObject(16303,2047.936,967.219,44.869,-352.266,-323.905,-168.748);
CreateDynamicObject(16303,2018.399,970.633,37.832,-0.859,-14.610,-165.310);
CreateDynamicObject(13641,2000.289,971.431,52.268,-356.563,-24.064,-178.282);
CreateDynamicObject(4007,1962.998,975.045,-30.295,-359.141,0.0,0.0);
CreateDynamicObject(4199,1968.115,971.120,49.681,0.0,0.0,-270.001);
CreateDynamicObject(13592,1929.159,966.954,61.562,0.0,0.0,-348.748);
CreateDynamicObject(13592,1928.866,959.251,62.359,0.0,0.0,-348.748);
CreateDynamicObject(13592,1929.460,952.225,62.581,-1.719,0.0,-348.748);
CreateDynamicObject(1634,1924.000,947.657,52.332,-22.345,0.0,-270.001);
CreateDynamicObject(1634,1918.624,947.777,54.975,-329.921,0.0,-270.001);
CreateDynamicObject(1634,2150.066,1085.006,13.789,-342.812,0.0,-33.747);
CreateDynamicObject(1634,2151.119,1087.142,18.483,-312.732,0.0,-33.747);
CreateDynamicObject(3458,2190.264,1245.807,15.443,-0.859,-21.486,-270.001);
CreateDynamicObject(1634,2189.894,1263.293,25.261,-335.077,0.0,0.0);
CreateDynamicObject(13592,2186.624,1267.538,41.539,-5.157,-330.780,-83.984);
CreateDynamicObject(1634,2182.286,1280.722,39.815,-323.045,0.0,-11.247);
CreateDynamicObject(13641,2127.750,2000.738,11.399,0.0,0.0,-270.001);
CreateDynamicObject(13641,2126.578,2041.474,11.391,0.0,0.0,-90.000);
CreateDynamicObject(13641,2126.092,2060.703,11.391,0.0,0.0,-90.000);
CreateDynamicObject(18367,2097.061,2328.142,9.129,-16.329,-1.719,-180.000);
CreateDynamicObject(18367,2095.754,2356.852,20.424,-12.892,0.0,-250.234);
CreateDynamicObject(18367,2123.883,2365.928,30.428,-25.783,0.0,-180.000);
CreateDynamicObject(18367,2123.043,2391.861,45.630,-29.221,0.0,-247.501);
CreateDynamicObject(18367,2146.238,2400.226,62.673,-10.313,0.0,-180.000);
CreateDynamicObject(18367,2144.955,2430.390,71.482,0.0,0.0,-281.248);
CreateDynamicObject(1634,2175.152,2424.379,75.727,-358.282,0.0,-101.247);
CreateDynamicObject(1634,2063.412,966.859,57.510,-309.294,-353.125,-277.810);
CreateDynamicObject(13592,2167.741,1003.057,16.441,-280.073,0.0,-337.501);
CreateDynamicObject(13592,2168.829,1004.939,23.253,-281.792,-1.719,0.0);
CreateDynamicObject(13592,2169.847,1006.413,30.558,-280.933,-6.016,-355.704);
CreateDynamicObject(13592,2170.922,1007.991,37.613,-281.792,-359.141,-1.719);
CreateDynamicObject(13592,2171.897,1009.166,44.132,-279.214,-10.313,-348.828);
CreateDynamicObject(13592,2172.573,1010.374,50.878,-278.354,0.0,-345.310);
CreateDynamicObject(13592,2173.625,1011.821,57.990,-280.933,-354.844,0.0);
CreateDynamicObject(13592,2175.026,1013.294,65.194,-282.652,-3.438,0.0);
CreateDynamicObject(13592,2175.970,1014.929,72.016,-282.652,-354.844,0.0);
CreateDynamicObject(13592,2177.082,1016.463,79.078,-282.652,-6.016,-359.141);
CreateDynamicObject(1634,2158.359,1007.977,9.868,-353.985,-321.326,-26.797);
CreateDynamicObject(13592,1995.418,1092.522,19.767,-0.859,0.0,-348.748);
CreateDynamicObject(13592,1883.002,1272.043,19.493,0.0,0.0,0.0);
CreateDynamicObject(1632,1987.199,1419.105,9.059,0.0,0.0,-191.248);
CreateDynamicObject(1634,1701.844,1459.449,11.090,0.0,0.0,-292.501);
CreateDynamicObject(1634,1697.594,1461.116,14.918,-335.937,0.0,-292.501);
CreateDynamicObject(1634,1696.364,1461.701,20.591,-298.121,0.0,-292.501);
CreateDynamicObject(13592,1701.756,1455.838,35.090,-357.423,-293.824,-11.247);
CreateDynamicObject(1634,1688.797,1455.092,37.895,-309.294,0.0,-287.344);
CreateDynamicObject(1634,2041.840,1008.969,10.969,0.0,0.0,0.0);
CreateDynamicObject(1634,2041.931,1012.267,14.183,-333.358,0.0,0.0);
CreateDynamicObject(1634,2042.154,1015.312,18.771,-323.905,0.0,0.0);
CreateDynamicObject(1634,2042.360,1017.396,23.244,-315.310,-359.141,0.0);
CreateDynamicObject(1634,2042.523,1018.645,27.435,-307.575,0.0,0.0);
CreateDynamicObject(13592,2039.192,1009.938,40.445,-356.563,-280.073,-85.703);
CreateDynamicObject(1634,2034.954,1021.309,46.542,-297.262,0.0,0.0);
CreateDynamicObject(13593,2084.064,1196.800,10.415,0.0,0.0,-90.000);
CreateDynamicObject(13593,2084.219,1194.048,10.415,0.0,0.0,-90.000);
CreateDynamicObject(13593,2084.179,1191.240,10.415,0.0,0.0,-90.000);
CreateDynamicObject(13593,2084.240,1188.417,10.415,0.0,0.0,-90.000);
CreateDynamicObject(13593,2087.883,1196.950,10.415,0.0,0.0,-270.001);
CreateDynamicObject(13593,2088.059,1194.184,10.415,0.0,0.0,-270.001);
CreateDynamicObject(13593,2088.010,1191.467,10.415,0.0,0.0,-270.001);
CreateDynamicObject(13593,2088.052,1188.641,10.415,0.0,0.0,-270.001);
CreateDynamicObject(13592,2188.207,2139.076,19.317,0.0,0.0,-337.501);
CreateDynamicObject(13666,2343.356,2064.280,14.652,0.0,0.0,0.0);
CreateDynamicObject(13666,2346.722,2063.687,14.602,0.0,0.0,0.0);
CreateDynamicObject(13666,2350.262,2063.101,14.552,0.0,0.0,0.0);
CreateDynamicObject(13666,2353.962,2062.459,14.569,0.0,0.0,0.0);
CreateDynamicObject(13666,2357.696,2061.827,14.526,0.0,0.0,0.0);
CreateDynamicObject(13666,2360.878,2061.234,14.558,0.0,0.0,0.0);
CreateDynamicObject(1634,2357.107,1906.018,10.969,0.0,0.0,-180.000);
CreateDynamicObject(1634,2353.277,1906.004,10.969,0.0,0.0,-180.000);
CreateDynamicObject(1634,2349.096,1905.881,10.969,0.0,0.0,-180.000);
CreateDynamicObject(1634,2344.969,1905.901,10.969,0.0,0.0,-180.000);
CreateDynamicObject(1634,2340.861,1905.852,10.977,0.0,0.0,-180.000);
CreateDynamicObject(1634,2361.292,1906.025,10.977,0.0,0.0,-180.000);
CreateDynamicObject(1634,2369.129,1856.767,20.029,0.0,0.0,-180.000);
CreateDynamicObject(1634,2365.368,1856.813,20.029,0.0,0.0,-180.000);
CreateDynamicObject(1634,2386.882,1813.327,20.032,0.0,0.0,-90.000);
CreateDynamicObject(1634,2386.555,1817.504,20.032,0.0,0.0,-90.000);
CreateDynamicObject(1634,2386.502,1821.545,20.032,0.0,0.0,-90.000);
CreateDynamicObject(1634,2386.515,1825.500,20.032,0.0,0.0,-90.000);
CreateDynamicObject(1634,2386.562,1829.033,20.032,0.0,0.0,-90.000);
CreateDynamicObject(13592,2447.053,1638.664,19.666,0.0,0.0,0.0);
CreateDynamicObject(13592,2395.784,1643.127,19.566,0.0,0.0,-78.747);
CreateDynamicObject(13592,2416.940,1676.518,19.616,0.0,0.0,-90.000);
CreateDynamicObject(1634,2372.407,1712.216,10.969,0.0,0.0,-270.001);
CreateDynamicObject(13638,2188.158,2027.254,11.552,0.0,0.0,-90.000);
CreateDynamicObject(13638,2187.510,2061.577,17.695,0.0,0.0,0.0);
CreateDynamicObject(13641,2279.741,2020.831,11.399,0.0,0.0,0.0);
CreateDynamicObject(13641,2314.582,2021.167,11.391,0.0,0.0,-180.000);
CreateDynamicObject(16084,2059.789,1942.811,10.389,0.0,-29.221,-101.247);
CreateDynamicObject(16367,2276.394,2148.824,11.156,0.0,0.0,-191.248);
CreateDynamicObject(18451,2277.726,2135.687,10.184,0.0,0.0,-101.247);
CreateDynamicObject(18567,2309.252,2141.815,10.849,0.0,0.0,-270.001);
CreateDynamicObject(1245,2348.156,2149.110,11.169,0.0,0.0,-180.000);
CreateDynamicObject(1245,2347.849,2136.916,11.169,0.0,0.0,-180.000);
CreateDynamicObject(1634,2407.257,2136.402,10.694,0.0,0.0,-90.000);
CreateDynamicObject(1634,2412.283,2149.823,10.569,0.0,0.0,-90.000);
CreateDynamicObject(1634,2418.702,2149.937,10.519,0.0,0.0,-270.001);
CreateDynamicObject(1634,2413.599,2136.357,10.619,0.0,0.0,-270.001);
CreateDynamicObject(1697,2529.518,2168.123,10.849,0.0,0.0,-180.000);
CreateDynamicObject(1697,2525.007,2167.955,10.849,0.0,0.0,-180.000);
CreateDynamicObject(1697,2525.174,2172.408,10.720,0.0,0.0,0.0);
CreateDynamicObject(1697,2529.594,2172.431,10.674,0.0,0.0,0.0);
CreateDynamicObject(1634,1929.623,2138.442,10.594,0.0,0.0,0.0);
CreateDynamicObject(1634,1925.419,2151.249,10.569,0.0,0.0,-180.000);
CreateDynamicObject(13592,2202.053,2281.543,19.593,0.0,0.0,0.0);
CreateDynamicObject(1634,2213.987,2284.826,10.494,0.0,0.0,-90.000);
CreateDynamicObject(1634,2220.560,2284.982,10.344,0.0,0.0,-270.001);
CreateDynamicObject(13639,2530.185,2372.887,9.190,0.0,0.0,0.0);
CreateDynamicObject(13641,2524.284,2364.313,11.199,0.0,0.0,-270.001);
CreateDynamicObject(13641,2523.910,2393.990,11.249,0.0,0.0,-90.000);
CreateDynamicObject(13641,2515.746,2232.799,11.041,0.0,0.0,0.0);
CreateDynamicObject(13641,2546.956,2233.138,11.241,0.0,0.0,-180.000);
CreateDynamicObject(1634,2182.111,1073.808,79.602,0.0,0.0,-337.501);
CreateDynamicObject(1634,2178.575,1072.342,79.602,0.0,0.0,-337.501);
CreateDynamicObject(1634,2174.865,1070.788,79.602,0.0,0.0,-337.501);
CreateDynamicObject(1634,2171.129,1069.309,79.627,0.0,0.0,-337.501);
CreateDynamicObject(1634,2169.527,1073.234,82.533,-346.250,0.0,-337.501);
CreateDynamicObject(1634,2173.210,1074.737,82.531,-346.250,0.0,-337.501);
CreateDynamicObject(1634,2177.118,1076.300,82.662,-343.672,0.0,-337.501);
CreateDynamicObject(1634,2180.939,1077.921,82.716,-343.672,0.0,-337.501);
CreateDynamicObject(8171,2143.867,1147.481,81.935,-356.563,0.0,-337.501);
CreateDynamicObject(8171,2099.682,1254.481,90.411,-354.844,0.0,-337.501);
CreateDynamicObject(13592,2116.839,1235.400,98.073,0.0,-355.704,-67.500);
CreateDynamicObject(13592,2109.706,1233.208,98.384,0.0,-356.563,-67.500);
CreateDynamicObject(13592,2102.597,1231.654,98.628,0.0,-358.282,-67.500);
CreateDynamicObject(1634,2090.540,1323.128,97.347,0.0,0.0,-337.501);
CreateDynamicObject(1634,2086.836,1321.501,97.264,0.0,0.0,-337.501);
CreateDynamicObject(1634,2083.250,1319.982,97.236,0.0,0.0,-337.501);
CreateDynamicObject(1634,2079.362,1318.380,97.237,0.0,0.0,-337.501);
CreateDynamicObject(1634,2075.590,1316.776,97.209,0.0,0.0,-337.501);
CreateDynamicObject(1634,2071.857,1315.236,97.184,0.0,0.0,-337.501);
CreateDynamicObject(1634,2068.129,1313.691,97.134,0.0,0.0,-337.501);
CreateDynamicObject(1634,2064.456,1312.169,97.109,0.0,0.0,-337.501);
CreateDynamicObject(1634,2060.658,1310.595,97.134,0.0,0.0,-337.501);
CreateDynamicObject(1634,2057.917,1309.395,97.092,0.0,0.0,-337.501);
CreateDynamicObject(621,2183.077,1096.798,78.124,0.0,0.0,0.0);
CreateDynamicObject(621,2152.002,1084.609,78.162,0.0,0.0,0.0);
CreateDynamicObject(621,2171.304,1124.194,79.915,0.0,0.0,0.0);
CreateDynamicObject(621,2139.905,1112.463,79.986,0.0,0.0,0.0);
CreateDynamicObject(621,2127.098,1143.566,82.007,0.0,0.0,0.0);
CreateDynamicObject(621,2158.166,1154.613,81.906,0.0,0.0,0.0);
CreateDynamicObject(621,2113.872,1174.983,84.054,0.0,0.0,0.0);
CreateDynamicObject(621,2146.565,1186.829,83.960,0.0,0.0,0.0);
CreateDynamicObject(621,2108.883,1278.526,92.001,0.0,0.0,0.0);
CreateDynamicObject(621,2076.085,1266.311,91.669,0.0,0.0,0.0);
CreateDynamicObject(621,2033.548,871.148,5.954,0.0,0.0,0.0);
CreateDynamicObject(621,2034.541,891.401,6.556,0.0,0.0,0.0);
CreateDynamicObject(621,2034.887,909.590,7.359,0.0,0.0,0.0);
CreateDynamicObject(621,2034.895,928.056,8.306,0.0,0.0,0.0);
CreateDynamicObject(621,2034.951,953.172,9.094,0.0,0.0,0.0);
CreateDynamicObject(621,2080.678,872.602,5.995,0.0,0.0,0.0);
CreateDynamicObject(621,2080.943,890.117,6.506,0.0,0.0,0.0);
CreateDynamicObject(621,2081.046,911.121,7.442,0.0,0.0,0.0);
CreateDynamicObject(621,2080.911,944.000,8.958,0.0,0.0,0.0);
CreateDynamicObject(8644,2098.896,954.797,18.261,0.0,0.0,-326.248);
CreateDynamicObject(10838,2057.822,863.118,21.444,0.0,0.0,-270.001);
CreateDynamicObject(11395,2111.701,888.272,22.688,0.0,0.0,0.0);
CreateDynamicObject(620,1867.443,-2693.126,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1867.223,-2677.436,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1867.305,-2666.878,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1867.550,-2656.771,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1867.455,-2644.684,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1846.736,-2693.285,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1846.222,-2677.501,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1846.285,-2666.001,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1846.414,-2656.055,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1845.977,-2644.059,12.614,0.0,0.0,0.0);
CreateDynamicObject(8355,1854.592,-2629.321,12.349,0.0,0.0,0.0);
CreateDynamicObject(8355,1855.595,-2627.061,12.549,0.0,0.0,0.0);
CreateDynamicObject(3627,1850.596,-2693.278,16.388,0.0,0.0,-90.000);
CreateDynamicObject(620,1777.524,-2692.220,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1777.533,-2680.432,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1777.779,-2667.539,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1777.658,-2654.690,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1777.532,-2642.730,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1800.452,-2692.828,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1800.645,-2679.798,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1800.471,-2669.267,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1800.644,-2658.076,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1800.184,-2643.232,12.614,0.0,0.0,0.0);
CreateDynamicObject(8355,1789.102,-2627.116,12.549,0.0,0.0,0.0);
CreateDynamicObject(3627,1794.391,-2691.334,16.113,0.0,0.0,-90.000);
CreateDynamicObject(620,1731.493,-2691.327,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1731.625,-2677.970,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1731.688,-2664.276,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1731.700,-2653.461,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1732.108,-2641.687,12.652,0.0,0.0,0.0);
CreateDynamicObject(620,1706.342,-2692.343,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1706.146,-2679.536,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1706.001,-2664.530,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1706.784,-2651.515,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1706.233,-2641.857,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1660.308,-2691.668,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1659.989,-2678.976,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1660.009,-2668.807,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1659.977,-2658.219,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1660.290,-2642.991,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1641.088,-2642.093,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1641.000,-2656.111,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1640.701,-2668.328,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1641.426,-2675.936,12.614,0.0,0.0,0.0);
CreateDynamicObject(620,1640.549,-2691.522,12.614,0.0,0.0,0.0);
CreateDynamicObject(8355,1718.852,-2627.295,12.574,0.0,0.0,0.0);
CreateDynamicObject(8355,1649.733,-2627.144,12.549,0.0,0.0,0.0);
CreateDynamicObject(3627,1713.561,-2691.341,16.413,0.0,0.0,-90.000);
CreateDynamicObject(3627,1644.567,-2692.388,16.388,0.0,0.0,-90.000);
CreateDynamicObject(1634,1995.544,-2494.816,13.786,-357.423,0.0,-90.000);
CreateDynamicObject(1634,1999.918,-2494.809,17.468,-339.374,0.0,-90.000);
CreateDynamicObject(1634,2003.771,-2494.798,22.072,-329.921,0.0,-90.000);
CreateDynamicObject(1634,2007.345,-2494.776,28.257,-320.467,0.0,-90.000);
CreateDynamicObject(1634,2009.018,-2494.783,33.010,-310.154,0.0,-90.000);
CreateDynamicObject(1634,2009.724,-2494.807,36.970,-301.559,0.0,-90.000);
CreateDynamicObject(13641,2009.588,-2495.030,33.245,-357.423,-73.052,0.0);
CreateDynamicObject(13641,1784.146,-2460.610,14.274,0.0,0.0,-180.000);
CreateDynamicObject(13641,1744.270,-2459.994,14.274,0.0,0.0,0.0);
CreateDynamicObject(13641,1724.437,-2459.537,14.074,0.0,0.0,0.0);
CreateDynamicObject(1634,1598.977,-2454.785,13.852,0.0,0.0,0.0);
CreateDynamicObject(13592,1760.690,-2499.636,22.375,0.0,0.0,0.0);
CreateDynamicObject(13592,1762.307,-2492.366,22.375,0.0,0.0,0.0);
CreateDynamicObject(13592,1959.370,-2379.821,22.293,0.0,0.0,-258.748);
CreateDynamicObject(13592,1951.862,-2380.098,22.318,0.0,0.0,-78.747);
CreateDynamicObject(13592,1944.434,-2380.531,22.242,0.0,0.0,-78.747);
CreateDynamicObject(13592,1937.009,-2380.811,22.118,0.0,0.0,-78.747);
CreateDynamicObject(13592,1929.582,-2381.336,21.817,0.0,0.0,-78.747);
CreateDynamicObject(13592,1922.109,-2381.478,21.768,0.0,0.0,-78.747);
CreateDynamicObject(13592,1914.737,-2381.980,21.793,0.0,0.0,-78.747);
CreateDynamicObject(13592,1907.417,-2382.265,21.817,0.0,0.0,-78.747);
CreateDynamicObject(13592,1899.934,-2382.724,21.835,0.0,0.0,-78.747);
CreateDynamicObject(13592,1892.796,-2382.968,21.760,0.0,0.0,-78.747);
CreateDynamicObject(13592,1885.377,-2383.474,21.800,0.0,0.0,-78.747);
CreateDynamicObject(13592,1966.744,-2379.565,22.342,0.0,0.0,-78.747);
CreateDynamicObject(13592,1974.129,-2378.870,22.317,0.0,0.0,-78.747);
CreateDynamicObject(1634,1882.646,-2379.145,13.627,-358.282,0.0,-348.748);
CreateDynamicObject(1634,1878.537,-2379.955,13.677,-357.423,0.0,-348.748);
CreateDynamicObject(1634,1877.890,-2376.881,16.453,-338.515,0.0,-348.748);
CreateDynamicObject(1634,1881.991,-2375.950,16.470,-335.937,0.0,-348.748);
CreateDynamicObject(1634,1881.383,-2372.947,20.906,-324.764,0.0,-348.748);
CreateDynamicObject(1634,1877.279,-2373.716,20.905,-324.764,0.0,-348.748);
CreateDynamicObject(10838,1854.615,-2637.010,28.751,0.0,0.0,-90.000);
CreateDynamicObject(10838,1789.600,-2638.171,28.976,0.0,0.0,-270.001);
CreateDynamicObject(10838,1718.268,-2639.561,29.051,0.0,0.0,-270.001);
CreateDynamicObject(10838,1648.894,-2640.828,28.326,0.0,0.0,-270.001);
CreateDynamicObject(10236,1888.760,-2631.967,23.585,0.0,0.0,0.0);
CreateDynamicObject(8644,1787.966,-2636.575,27.062,0.0,0.0,-67.500);
CreateDynamicObject(8644,1852.467,-2635.010,26.739,0.0,0.0,-56.247);
CreateDynamicObject(8644,1722.541,-2636.688,27.039,0.0,0.0,-67.500);
CreateDynamicObject(8644,1647.388,-2637.414,26.160,0.0,0.0,-67.500);
CreateDynamicObject(9132,1820.557,-2658.678,44.538,0.0,0.0,0.0);
CreateDynamicObject(3502,1876.426,-2371.011,28.474,-311.872,0.0,-348.748);
CreateDynamicObject(3502,1880.344,-2370.906,29.140,-304.137,0.0,-348.748);
CreateDynamicObject(3502,1879.266,-2365.819,35.875,-311.872,0.0,-348.748);
CreateDynamicObject(3502,1875.326,-2365.375,34.674,-313.591,-350.547,-348.748);
CreateDynamicObject(8355,1280.412,-2543.895,141.917,0.0,0.0,-270.001);
CreateDynamicObject(8171,1193.849,-2495.039,141.898,0.0,0.0,0.0);
CreateDynamicObject(3270,1470.195,-2641.240,11.557,0.0,0.0,-258.748);
CreateDynamicObject(1634,1823.019,-2631.198,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1822.990,-2627.223,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1822.921,-2623.132,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1822.969,-2618.970,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1822.951,-2614.800,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1822.976,-2610.637,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1822.977,-2606.503,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1822.961,-2602.367,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1822.963,-2598.231,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1822.946,-2594.070,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1823.004,-2589.894,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1822.986,-2585.776,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1822.917,-2581.611,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1822.989,-2577.451,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1829.439,-2631.267,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.429,-2627.180,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.411,-2623.062,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.441,-2618.901,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.369,-2614.718,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.376,-2610.535,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.447,-2606.418,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.425,-2602.374,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.385,-2598.304,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.382,-2594.178,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.330,-2590.099,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.376,-2585.954,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.426,-2581.828,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1829.373,-2577.655,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1752.892,-2632.009,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1752.914,-2627.914,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1752.908,-2623.753,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1752.938,-2619.609,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1752.897,-2615.939,13.819,0.0,0.0,-90.000);
CreateDynamicObject(1634,1752.937,-2611.794,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1752.966,-2607.651,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1752.950,-2603.474,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1752.950,-2599.319,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1752.992,-2595.139,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1753.025,-2590.971,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1753.053,-2586.916,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1753.055,-2582.822,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1753.050,-2578.645,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1759.308,-2631.991,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.379,-2627.880,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.372,-2623.729,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.399,-2619.566,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.372,-2615.482,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.397,-2611.322,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.444,-2607.172,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.417,-2603.001,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.403,-2599.034,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.392,-2595.131,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.349,-2591.163,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.369,-2587.040,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.372,-2582.942,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1759.362,-2578.910,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1677.931,-2632.356,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.965,-2628.255,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.909,-2624.091,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.903,-2619.933,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.885,-2615.789,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.868,-2611.587,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.889,-2607.424,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.828,-2603.207,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.847,-2599.020,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.931,-2594.840,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.916,-2590.663,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.936,-2586.582,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.961,-2582.459,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.978,-2578.322,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1677.952,-2636.531,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1684.376,-2636.543,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.375,-2632.326,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.301,-2628.283,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.342,-2624.149,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.366,-2620.056,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.434,-2615.971,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.431,-2611.870,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.450,-2607.806,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.469,-2603.686,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.499,-2599.681,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.580,-2595.612,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.639,-2591.571,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.662,-2587.515,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.659,-2583.340,13.844,0.0,0.0,-270.001);
CreateDynamicObject(1634,1684.646,-2579.308,13.844,0.0,0.0,-270.001);
CreateDynamicObject(4007,1563.488,-2406.511,42.284,0.0,0.0,-78.747);
CreateDynamicObject(1634,1457.923,-2491.988,13.677,-358.282,0.0,-270.001);
CreateDynamicObject(1634,1454.262,-2491.967,17.526,-331.639,0.0,-270.001);
CreateDynamicObject(1634,1451.366,-2491.894,22.481,-321.326,0.0,-270.001);
CreateDynamicObject(1634,1449.709,-2491.658,27.364,-310.154,-354.844,-273.438);
CreateDynamicObject(13592,1458.113,-2495.492,36.993,-357.423,-285.230,-357.423);
CreateDynamicObject(1634,1445.911,-2499.681,43.284,-301.559,-345.390,-281.248);
CreateDynamicObject(620,1349.098,-2527.236,141.959,0.0,0.0,0.0);
CreateDynamicObject(620,1349.063,-2560.027,141.959,0.0,0.0,0.0);
CreateDynamicObject(620,1318.033,-2559.950,141.959,0.0,0.0,0.0);
CreateDynamicObject(620,1317.848,-2527.128,141.959,0.0,0.0,0.0);
CreateDynamicObject(620,1295.149,-2527.285,141.959,0.0,0.0,0.0);
CreateDynamicObject(620,1294.844,-2560.493,141.959,0.0,0.0,0.0);
CreateDynamicObject(620,1264.492,-2560.220,141.959,0.0,0.0,0.0);
CreateDynamicObject(620,1263.388,-2527.783,141.959,0.0,0.0,0.0);
CreateDynamicObject(620,1227.851,-2559.727,141.959,0.0,0.0,0.0);
CreateDynamicObject(620,1227.907,-2527.613,141.959,0.0,0.0,0.0);
CreateDynamicObject(620,1176.921,-2563.700,141.965,0.0,0.0,0.0);
CreateDynamicObject(620,1202.472,-2563.282,141.965,0.0,0.0,0.0);
CreateDynamicObject(620,1213.624,-2525.772,141.965,0.0,0.0,0.0);
CreateDynamicObject(620,1177.632,-2538.024,141.965,0.0,0.0,0.0);
CreateDynamicObject(620,1178.437,-2509.095,141.965,0.0,0.0,0.0);
CreateDynamicObject(620,1210.689,-2507.965,141.965,0.0,0.0,0.0);
CreateDynamicObject(620,1178.717,-2472.213,141.965,0.0,0.0,0.0);
CreateDynamicObject(620,1211.188,-2470.796,141.965,0.0,0.0,0.0);
CreateDynamicObject(620,1213.600,-2426.926,141.965,0.0,0.0,0.0);
CreateDynamicObject(620,1175.725,-2427.108,141.965,0.0,0.0,0.0);
CreateDynamicObject(7379,1229.389,-2563.562,141.453,0.0,0.0,-270.001);
CreateDynamicObject(7379,1186.207,-2563.550,141.898,0.0,0.0,-270.001);
CreateDynamicObject(7379,1173.953,-2444.023,141.898,0.0,0.0,0.0);
CreateDynamicObject(7379,1173.866,-2437.969,141.898,0.0,0.0,0.0);
CreateDynamicObject(7379,1226.272,-2523.958,141.917,0.0,0.0,-270.001);
CreateDynamicObject(7379,1214.026,-2404.426,141.898,0.0,0.0,0.0);
CreateDynamicObject(7379,1174.254,-2413.980,141.898,0.0,0.0,0.0);
CreateDynamicObject(13592,1203.543,-2422.239,151.819,0.0,0.0,-90.000);
CreateDynamicObject(13592,1196.092,-2421.435,151.768,0.0,0.0,-90.000);
CreateDynamicObject(13592,1188.936,-2420.329,151.659,0.0,0.0,-90.000);
CreateDynamicObject(13592,1182.123,-2419.364,151.534,0.0,0.0,-90.000);
CreateDynamicObject(1634,1180.407,-2414.344,143.195,0.0,0.0,0.0);
CreateDynamicObject(1634,1176.722,-2414.296,143.217,0.0,0.0,0.0);
CreateDynamicObject(1634,1558.543,-2595.149,13.644,0.0,0.0,-270.001);
CreateDynamicObject(1634,1558.536,-2590.967,13.644,0.0,0.0,-270.001);
CreateDynamicObject(1634,1558.529,-2586.803,13.694,0.0,0.0,-270.001);
CreateDynamicObject(1634,1558.693,-2599.341,13.594,0.0,0.0,-270.001);
CreateDynamicObject(17523,1540.687,-2591.715,15.171,0.0,0.0,-90.000);
CreateDynamicObject(1634,1523.319,-2598.734,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1523.353,-2594.539,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1523.296,-2590.378,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1523.321,-2586.507,13.844,0.0,0.0,-90.000);
CreateDynamicObject(1634,1546.758,-2612.273,13.844,0.0,0.0,0.0);
CreateDynamicObject(1634,1542.734,-2612.217,13.844,0.0,0.0,0.0);
CreateDynamicObject(1634,1538.559,-2612.142,13.844,0.0,0.0,0.0);
CreateDynamicObject(1634,1546.102,-2567.265,13.844,0.0,0.0,-180.000);
CreateDynamicObject(1634,1541.927,-2567.208,13.844,0.0,0.0,-180.000);
CreateDynamicObject(1634,1537.971,-2567.363,13.844,0.0,0.0,-180.000);
CreateDynamicObject(1225,1540.889,-2582.076,17.035,0.0,0.0,0.0);
CreateDynamicObject(1225,1544.286,-2583.278,17.040,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.623,-2585.100,17.055,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.276,-2586.192,17.059,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.280,-2588.204,17.068,0.0,0.0,0.0);
CreateDynamicObject(1225,1540.122,-2591.318,17.082,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.665,-2592.402,17.087,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.449,-2593.215,17.090,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.927,-2595.821,17.102,0.0,0.0,0.0);
CreateDynamicObject(1225,1542.346,-2596.429,17.104,0.0,0.0,0.0);
CreateDynamicObject(1225,1543.472,-2594.066,17.094,0.0,0.0,0.0);
CreateDynamicObject(1225,1542.856,-2589.914,17.076,0.0,0.0,0.0);
CreateDynamicObject(1225,1540.765,-2588.533,17.070,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.337,-2590.014,17.076,0.0,0.0,0.0);
CreateDynamicObject(1225,1538.495,-2591.585,17.083,0.0,0.0,0.0);
CreateDynamicObject(1225,1536.792,-2592.945,17.089,0.0,0.0,0.0);
CreateDynamicObject(1225,1534.903,-2595.742,17.101,0.0,0.0,0.0);
CreateDynamicObject(1225,1533.716,-2596.377,17.104,0.0,0.0,0.0);
CreateDynamicObject(1225,1535.019,-2597.605,17.110,0.0,0.0,0.0);
CreateDynamicObject(1225,1535.150,-2598.287,17.113,0.0,0.0,0.0);
CreateDynamicObject(1225,1536.362,-2599.683,17.119,0.0,0.0,0.0);
CreateDynamicObject(1225,1538.299,-2599.411,17.117,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.945,-2598.307,17.113,0.0,0.0,0.0);
CreateDynamicObject(1225,1543.024,-2598.570,17.114,0.0,0.0,0.0);
CreateDynamicObject(1225,1543.891,-2600.090,17.120,0.0,0.0,0.0);
CreateDynamicObject(1225,1544.327,-2600.676,17.123,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.223,-2599.889,17.120,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.553,-2596.578,17.105,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.751,-2594.353,17.095,0.0,0.0,0.0);
CreateDynamicObject(1225,1547.001,-2591.228,17.082,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.100,-2589.196,17.073,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.574,-2586.617,17.061,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.211,-2585.194,17.428,0.0,0.0,0.0);
CreateDynamicObject(1225,1543.839,-2586.210,17.059,0.0,0.0,0.0);
CreateDynamicObject(1225,1540.979,-2583.451,17.047,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.044,-2583.463,17.047,0.0,0.0,0.0);
CreateDynamicObject(1225,1537.337,-2582.544,17.043,0.0,0.0,0.0);
CreateDynamicObject(1225,1536.520,-2582.448,17.043,0.0,0.0,0.0);
CreateDynamicObject(1225,1534.677,-2582.127,17.042,0.0,0.0,0.0);
CreateDynamicObject(1225,1534.642,-2582.131,17.042,0.0,0.0,0.0);
CreateDynamicObject(1225,1534.936,-2583.910,17.049,0.0,0.0,0.0);
CreateDynamicObject(1225,1538.276,-2583.408,17.047,0.0,0.0,0.0);
CreateDynamicObject(1225,1538.029,-2584.557,17.052,0.0,0.0,0.0);
CreateDynamicObject(1225,1535.446,-2585.403,17.056,0.0,0.0,0.0);
CreateDynamicObject(1225,1536.162,-2585.984,17.058,0.0,0.0,0.0);
CreateDynamicObject(1225,1537.585,-2586.255,17.060,0.0,0.0,0.0);
CreateDynamicObject(1225,1537.038,-2587.660,17.066,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.689,-2587.789,17.066,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.201,-2588.903,17.071,0.0,0.0,0.0);
CreateDynamicObject(1225,1540.805,-2591.184,17.081,0.0,0.0,0.0);
CreateDynamicObject(1225,1543.204,-2592.202,17.086,0.0,0.0,0.0);
CreateDynamicObject(1225,1544.172,-2592.767,17.088,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.501,-2594.856,17.097,0.0,0.0,0.0);
CreateDynamicObject(1225,1538.929,-2593.879,17.093,0.0,0.0,0.0);
CreateDynamicObject(1225,1537.907,-2592.389,17.087,0.0,0.0,0.0);
CreateDynamicObject(1225,1536.453,-2588.056,17.068,0.0,0.0,0.0);
CreateDynamicObject(1225,1535.824,-2588.301,17.069,0.0,0.0,0.0);
CreateDynamicObject(1225,1535.738,-2588.894,17.071,0.0,0.0,0.0);
CreateDynamicObject(1225,1535.822,-2590.438,17.078,0.0,0.0,0.0);
CreateDynamicObject(1225,1536.864,-2591.315,18.267,0.0,0.0,0.0);
CreateDynamicObject(1225,1537.310,-2593.832,17.093,0.0,0.0,0.0);
CreateDynamicObject(1225,1538.287,-2596.048,17.103,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.421,-2597.657,17.110,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.395,-2599.747,17.119,0.0,0.0,0.0);
CreateDynamicObject(1225,1543.010,-2599.691,17.119,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.586,-2598.365,17.113,0.0,0.0,0.0);
CreateDynamicObject(1225,1536.562,-2598.220,17.226,0.0,0.0,0.0);
CreateDynamicObject(1225,1535.603,-2600.779,17.123,0.0,0.0,0.0);
CreateDynamicObject(1225,1533.998,-2594.624,18.070,0.0,0.0,0.0);
CreateDynamicObject(1225,1534.373,-2592.851,17.089,0.0,0.0,0.0);
CreateDynamicObject(1225,1534.246,-2590.057,17.076,0.0,0.0,0.0);
CreateDynamicObject(1225,1534.027,-2587.544,17.065,0.0,0.0,0.0);
CreateDynamicObject(1225,1534.033,-2584.452,17.052,0.0,0.0,0.0);
CreateDynamicObject(1225,1534.596,-2584.176,17.051,0.0,0.0,0.0);
CreateDynamicObject(1225,1537.995,-2583.960,17.050,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.598,-2584.082,17.050,0.0,0.0,0.0);
CreateDynamicObject(1225,1540.287,-2584.098,17.050,0.0,0.0,0.0);
CreateDynamicObject(1225,1542.223,-2584.783,17.053,0.0,0.0,0.0);
CreateDynamicObject(1225,1543.086,-2583.464,17.047,0.0,0.0,0.0);
CreateDynamicObject(1225,1543.729,-2582.976,17.045,0.0,0.0,0.0);
CreateDynamicObject(1225,1545.312,-2582.496,17.043,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.283,-2581.301,17.038,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.666,-2581.446,17.039,0.0,0.0,0.0);
CreateDynamicObject(1225,1547.000,-2582.538,17.043,0.0,0.0,0.0);
CreateDynamicObject(1225,1547.162,-2584.736,17.053,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.459,-2584.920,18.197,0.0,0.0,0.0);
CreateDynamicObject(1225,1547.217,-2586.434,17.060,0.0,0.0,0.0);
CreateDynamicObject(1225,1543.857,-2587.854,17.067,0.0,0.0,0.0);
CreateDynamicObject(1225,1543.545,-2587.838,17.067,0.0,0.0,0.0);
CreateDynamicObject(1225,1544.854,-2589.902,17.076,0.0,0.0,0.0);
CreateDynamicObject(1225,1545.575,-2591.038,17.081,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.622,-2592.535,17.087,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.000,-2594.978,17.098,0.0,0.0,0.0);
CreateDynamicObject(1225,1545.383,-2596.104,17.103,0.0,0.0,0.0);
CreateDynamicObject(1225,1545.036,-2594.820,17.514,0.0,0.0,0.0);
CreateDynamicObject(1225,1543.263,-2593.996,17.094,0.0,0.0,0.0);
CreateDynamicObject(1225,1542.390,-2594.205,17.095,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.970,-2594.684,17.097,0.0,0.0,0.0);
CreateDynamicObject(1225,1544.042,-2597.330,17.108,0.0,0.0,0.0);
CreateDynamicObject(1225,1545.038,-2597.985,17.111,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.014,-2598.035,17.853,0.0,0.0,0.0);
CreateDynamicObject(1225,1547.667,-2601.469,17.127,0.0,0.0,0.0);
CreateDynamicObject(1225,1546.479,-2602.308,17.130,0.0,0.0,0.0);
CreateDynamicObject(1225,1544.558,-2602.197,17.130,0.0,0.0,0.0);
CreateDynamicObject(1225,1543.336,-2602.616,16.726,0.0,0.0,0.0);
CreateDynamicObject(1225,1540.670,-2602.557,16.726,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.951,-2602.212,16.724,0.0,0.0,0.0);
CreateDynamicObject(1225,1538.751,-2601.958,16.723,0.0,0.0,0.0);
CreateDynamicObject(1225,1537.241,-2602.186,16.724,0.0,0.0,0.0);
CreateDynamicObject(1225,1535.924,-2602.323,16.725,0.0,0.0,0.0);
CreateDynamicObject(1225,1535.813,-2600.976,16.719,0.0,0.0,0.0);
CreateDynamicObject(1225,1535.478,-2599.115,17.866,0.0,0.0,0.0);
CreateDynamicObject(1225,1537.194,-2599.583,16.712,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.716,-2596.469,17.562,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.827,-2596.757,17.819,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.108,-2601.656,16.722,0.0,0.0,0.0);
CreateDynamicObject(1225,1538.140,-2594.165,17.025,0.0,0.0,0.0);
CreateDynamicObject(1225,1537.579,-2590.888,16.921,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.313,-2588.090,16.662,0.0,0.0,0.0);
CreateDynamicObject(1225,1539.690,-2587.948,16.661,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.210,-2589.704,16.669,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.569,-2590.191,16.671,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.381,-2590.955,16.675,0.0,0.0,0.0);
CreateDynamicObject(1225,1540.210,-2592.229,16.680,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.018,-2591.942,16.679,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.573,-2591.977,16.679,0.0,0.0,0.0);
CreateDynamicObject(1225,1541.573,-2591.977,16.679,0.0,0.0,0.0);
CreateDynamicObject(17523,1538.059,-2600.092,19.339,0.0,0.0,-90.000);
CreateDynamicObject(17523,1538.814,-2600.542,19.341,0.0,0.0,-90.000);
CreateDynamicObject(1225,1537.003,-2601.998,17.129,0.0,0.0,0.0);
CreateDynamicObject(16395,1571.325,-2483.042,12.555,0.0,-329.061,0.0);
CreateDynamicObject(16395,1571.325,-2481.542,12.555,0.0,-329.061,0.0);
CreateDynamicObject(16303,2053.024,969.017,47.200,-352.266,-323.905,-168.748);
CreateDynamicObject(1634,1970.790,1356.321,10.313,0.0,0.0,-270.001);
CreateDynamicObject(1634,2613.369,1863.865,11.118,0.0,0.0,0.0);
CreateDynamicObject(1634,2609.843,1863.868,11.118,0.0,0.0,0.0);
CreateDynamicObject(1634,2605.799,1863.849,11.118,0.0,0.0,0.0);
CreateDynamicObject(1634,2609.913,1871.028,15.384,-347.969,0.0,0.0);
CreateDynamicObject(1634,2613.335,1871.080,15.449,-347.969,0.0,0.0);
CreateDynamicObject(1634,2605.799,1871.067,15.477,-347.969,0.0,0.0);
CreateDynamicObject(13592,2604.958,1954.945,19.817,0.0,0.0,-348.748);
CreateDynamicObject(13592,2394.686,1972.896,21.242,0.0,0.0,0.0);
CreateDynamicObject(16303,2311.485,2283.995,16.624,-352.266,-323.905,-168.748);
CreateDynamicObject(13648,2064.155,-2523.597,12.543,0.0,0.0,-90.000);
CreateDynamicObject(13648,2083.219,-2542.406,12.543,0.0,0.0,0.0);
CreateDynamicObject(13648,2042.937,-2544.647,12.543,0.0,0.0,-180.000);
CreateDynamicObject(13648,2061.977,-2564.100,12.543,0.0,0.0,-270.001);
CreateDynamicObject(16782,2064.198,-2564.610,14.891,0.0,0.0,-90.000);
CreateDynamicObject(16782,2042.258,-2543.242,15.247,0.0,0.0,-180.000);
CreateDynamicObject(16782,1649.750,-2677.102,12.717,0.0,-92.819,-273.438);
CreateDynamicObject(1225,2077.760,-2557.233,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2076.310,-2553.094,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2073.015,-2540.490,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2071.145,-2543.628,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2066.952,-2546.797,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2061.491,-2539.125,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2061.504,-2528.824,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2063.354,-2529.562,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2063.204,-2532.298,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2063.204,-2532.298,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2063.204,-2532.298,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2063.245,-2532.491,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2064.558,-2533.261,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2067.401,-2533.664,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2070.794,-2532.779,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2070.636,-2531.427,14.093,0.0,0.0,0.0);
CreateDynamicObject(1225,2072.572,-2531.175,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2076.926,-2537.542,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2076.428,-2543.056,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2071.989,-2543.998,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2065.536,-2542.660,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2059.528,-2539.851,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2055.351,-2531.906,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2053.026,-2530.053,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2054.133,-2535.931,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2053.493,-2542.569,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2051.361,-2546.244,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2050.419,-2549.269,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2050.745,-2551.304,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2054.570,-2551.895,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2059.803,-2552.310,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2064.597,-2553.718,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2064.439,-2557.474,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2069.236,-2557.050,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2074.318,-2551.668,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2071.910,-2542.839,13.960,0.0,0.0,0.0);
CreateDynamicObject(1225,2072.363,-2538.297,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2068.340,-2541.868,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2066.351,-2543.747,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2062.799,-2544.959,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2060.113,-2544.729,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2058.679,-2543.539,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2057.373,-2545.657,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2062.638,-2552.045,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2068.083,-2552.590,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2072.960,-2550.658,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2080.127,-2545.619,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2080.294,-2537.147,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2078.004,-2532.664,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2074.717,-2530.335,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2066.175,-2527.857,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2063.549,-2526.969,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2059.473,-2526.588,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2055.380,-2526.191,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2051.632,-2526.515,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2050.047,-2528.610,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2049.686,-2530.428,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2050.223,-2532.892,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2049.312,-2539.670,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2046.379,-2546.388,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2046.019,-2548.454,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2046.769,-2550.262,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2048.223,-2551.610,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2050.316,-2554.471,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2051.693,-2556.174,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2054.027,-2557.737,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2057.780,-2558.506,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2061.677,-2558.545,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2063.433,-2558.653,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2065.420,-2559.409,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2071.638,-2560.431,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2075.251,-2555.064,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2064.710,-2541.936,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2063.937,-2548.847,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2059.790,-2547.806,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2058.881,-2545.668,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2058.367,-2537.220,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2061.028,-2535.078,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2063.921,-2536.094,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2068.227,-2536.293,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2072.123,-2534.366,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2074.622,-2532.852,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2077.621,-2528.830,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2080.095,-2522.809,12.959,0.0,0.0,0.0);
CreateDynamicObject(1225,2076.616,-2524.169,12.959,0.0,0.0,0.0);
CreateDynamicObject(1225,2075.469,-2524.561,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2069.629,-2525.089,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2066.220,-2524.905,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2063.181,-2525.287,13.785,0.0,0.0,0.0);
CreateDynamicObject(1225,2060.719,-2525.002,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2057.921,-2524.693,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2056.176,-2525.022,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2054.534,-2524.689,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2052.879,-2524.405,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2051.474,-2524.352,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2050.218,-2524.278,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2049.671,-2524.104,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2048.151,-2524.349,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2046.954,-2524.297,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2046.624,-2524.385,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2045.834,-2524.359,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2044.525,-2559.484,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2044.556,-2557.069,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2044.428,-2553.720,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2044.395,-2551.735,13.174,0.0,0.0,0.0);
CreateDynamicObject(1225,2044.363,-2549.825,13.903,0.0,0.0,0.0);
CreateDynamicObject(1225,2044.310,-2546.688,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2044.411,-2545.183,14.144,0.0,0.0,0.0);
CreateDynamicObject(1225,2044.783,-2541.610,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2045.301,-2535.583,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2045.684,-2534.191,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2046.458,-2531.069,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2046.186,-2530.226,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2045.902,-2527.591,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2045.823,-2526.200,14.133,0.0,0.0,0.0);
CreateDynamicObject(1225,2043.873,-2533.564,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2043.957,-2537.518,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2044.708,-2539.820,14.030,0.0,0.0,0.0);
CreateDynamicObject(1225,2047.818,-2561.490,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2055.320,-2562.264,13.886,0.0,0.0,0.0);
CreateDynamicObject(1225,2065.201,-2560.535,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2068.365,-2560.197,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2070.805,-2560.317,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2069.963,-2560.890,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2065.816,-2560.408,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2058.052,-2562.264,13.198,0.0,0.0,0.0);
CreateDynamicObject(1225,2053.123,-2561.575,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2049.863,-2561.157,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2048.296,-2560.644,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2047.969,-2559.848,14.103,0.0,0.0,0.0);
CreateDynamicObject(1225,2046.557,-2561.450,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2045.977,-2561.189,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2064.619,-2562.007,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2066.891,-2561.006,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2071.286,-2559.137,13.784,0.0,0.0,0.0);
CreateDynamicObject(1225,2074.120,-2560.251,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2076.548,-2559.959,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2076.683,-2559.822,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2081.867,-2561.742,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2082.170,-2548.114,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2082.883,-2540.993,13.531,0.0,0.0,0.0);
CreateDynamicObject(1225,2082.836,-2533.390,12.959,0.0,0.0,0.0);
CreateDynamicObject(1225,2081.514,-2529.205,12.959,0.0,0.0,0.0);
CreateDynamicObject(1225,2082.379,-2526.533,12.959,0.0,0.0,0.0);
CreateDynamicObject(1225,2082.883,-2543.249,12.969,0.0,0.0,0.0);
CreateDynamicObject(1225,2080.340,-2551.992,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2080.787,-2552.852,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2081.282,-2555.021,12.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2080.439,-2556.718,12.953,0.0,0.0,0.0);
CreateDynamicObject(9833,2062.565,-2549.548,9.249,0.0,0.0,0.0);
CreateDynamicObject(2780,2078.562,-2527.703,12.553,0.0,0.0,0.0);
CreateDynamicObject(2780,2079.054,-2531.882,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2080.164,-2539.754,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2080.436,-2551.376,12.853,0.0,0.0,0.0);
CreateDynamicObject(2780,2079.175,-2558.539,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2070.664,-2558.872,13.721,0.0,0.0,0.0);
CreateDynamicObject(2780,2068.161,-2559.929,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2065.879,-2559.623,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2064.833,-2557.667,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2063.309,-2551.726,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2060.330,-2543.647,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2064.202,-2542.763,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2066.927,-2543.858,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2063.752,-2539.795,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2058.008,-2539.567,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2053.117,-2535.487,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2050.042,-2532.276,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2047.372,-2528.846,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2045.962,-2527.581,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2045.830,-2529.537,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2046.644,-2536.636,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2046.478,-2539.627,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2046.534,-2539.627,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2047.821,-2539.666,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2056.450,-2539.810,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2064.828,-2540.861,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2066.632,-2545.121,13.528,0.0,0.0,0.0);
CreateDynamicObject(2780,2065.516,-2548.415,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2068.658,-2542.272,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2067.279,-2537.022,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2065.178,-2532.521,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2059.036,-2531.195,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2058.209,-2532.068,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2057.424,-2532.383,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2056.521,-2534.503,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2056.444,-2535.002,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2056.127,-2535.808,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2047.629,-2545.418,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2045.428,-2545.852,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2046.157,-2546.777,13.687,0.0,0.0,0.0);
CreateDynamicObject(2780,2046.678,-2548.358,13.311,0.0,0.0,0.0);
CreateDynamicObject(2780,2046.664,-2551.029,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2065.782,-2540.910,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2065.974,-2539.003,12.820,0.0,0.0,0.0);
CreateDynamicObject(2780,2064.550,-2538.802,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2059.895,-2536.982,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2056.304,-2536.530,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2052.414,-2543.549,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2057.269,-2551.020,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2065.738,-2544.448,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2080.156,-2535.430,12.905,0.0,0.0,0.0);
CreateDynamicObject(2780,2078.843,-2534.504,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2062.491,-2529.799,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2057.015,-2530.492,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2053.581,-2532.125,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2053.124,-2528.516,13.738,0.0,0.0,0.0);
CreateDynamicObject(2780,2059.677,-2526.085,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2073.892,-2530.317,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2069.540,-2528.947,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2069.046,-2530.922,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2068.674,-2542.461,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2071.399,-2541.952,13.055,0.0,0.0,0.0);
CreateDynamicObject(2780,2075.148,-2545.567,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2074.452,-2549.788,13.444,0.0,0.0,0.0);
CreateDynamicObject(2780,2074.027,-2556.605,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2078.711,-2553.449,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2073.858,-2528.792,13.312,0.0,0.0,0.0);
CreateDynamicObject(2780,2077.441,-2525.082,12.553,0.0,0.0,0.0);
CreateDynamicObject(13648,2064.194,-2523.380,12.543,0.0,0.0,-90.000);
CreateDynamicObject(2780,2051.400,-2557.441,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2051.491,-2553.316,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2053.789,-2551.657,12.547,0.0,0.0,0.0);
CreateDynamicObject(2780,2053.789,-2551.657,12.547,0.0,0.0,0.0);
CreateDynamicObject(18367,1348.104,-2543.935,142.849,-309.294,0.0,-271.720);
CreateDynamicObject(18367,1394.827,-2544.575,107.250,-24.064,0.0,-90.000);
CreateDynamicObject(18367,1420.456,-2544.325,94.193,-20.626,0.0,-90.000);
CreateDynamicObject(16395,1499.462,-2545.662,19.851,0.0,-329.061,0.0);
CreateDynamicObject(18450,-299.121,2244.365,109.119,0.0,0.0,-376.330);
CreateDynamicObject(18450,-337.102,2255.617,111.131,0.0,-348.828,-377.264);
CreateDynamicObject(18450,-397.224,2274.333,136.171,0.0,-329.921,-377.264);
CreateDynamicObject(18450,-322.610,2251.190,108.631,0.0,-350.547,-377.190);
CreateDynamicObject(18450,-365.572,2264.467,121.228,0.0,-340.234,-377.264);
CreateDynamicObject(18450,-588.517,2333.845,190.305,0.0,-397.816,-377.264);
CreateDynamicObject(18450,-603.687,2338.565,172.771,0.0,-370.314,-377.264);
CreateDynamicObject(18450,-600.180,2338.035,176.021,0.0,-382.346,-377.264);
CreateDynamicObject(18450,-639.941,2349.841,168.768,0.0,-353.125,-377.264);
CreateDynamicObject(18450,-630.887,2347.007,168.631,0.0,-363.439,-377.264);
CreateDynamicObject(18450,-558.521,2324.510,216.236,0.0,-399.535,-377.264);
CreateDynamicObject(18450,-612.035,2341.145,172.489,0.0,-381.487,-377.264);
CreateDynamicObject(18450,-675.514,2360.912,176.168,0.0,-339.374,-377.264);
CreateDynamicObject(18450,-662.487,2356.835,172.813,0.0,-347.109,-377.264);
CreateDynamicObject(18450,-732.483,2378.603,198.619,0.0,-339.374,-377.264);
CreateDynamicObject(18450,-784.290,2394.680,219.028,0.0,-339.374,-377.264);
CreateDynamicObject(18450,-851.197,2415.479,248.597,0.0,-335.077,-377.264);
CreateDynamicObject(18450,-917.371,2435.911,243.396,0.0,-393.519,-377.264);
CreateDynamicObject(18450,-977.398,2454.535,201.770,0.0,-393.519,-377.264);
CreateDynamicObject(18450,-1026.664,2469.872,167.525,0.0,-393.519,-377.264);
CreateDynamicObject(18450,-1080.787,2486.702,129.972,0.0,-393.519,-377.264);
CreateDynamicObject(18450,-1091.492,2490.063,126.032,0.0,-370.314,-377.264);
CreateDynamicObject(18450,-1085.474,2488.157,130.160,0.0,-381.487,-377.264);
CreateDynamicObject(18450,-1124.605,2500.348,122.718,0.0,-358.282,-377.264);
CreateDynamicObject(18450,-1162.129,2512.024,126.789,0.0,-340.234,-377.264);
CreateDynamicObject(18450,-1155.817,2509.998,125.290,0.0,-350.547,-377.264);
CreateDynamicObject(18450,-1197.494,2523.041,142.973,0.0,-317.888,-377.264);
CreateDynamicObject(18450,-1191.212,2521.085,140.462,0.0,-329.061,-377.264);
CreateDynamicObject(18450,-1222.731,2530.890,169.929,0.0,-306.716,-377.264);
CreateDynamicObject(18450,-1278.090,2548.166,181.919,0.0,-390.081,-377.264);
CreateDynamicObject(18450,-1343.314,2568.436,142.357,0.0,-390.081,-377.264);
CreateDynamicObject(18450,-1375.125,2578.323,126.045,0.0,-384.925,-377.264);
CreateDynamicObject(18450,-1432.145,2596.028,101.545,0.0,-380.627,-377.264);
CreateDynamicObject(18450,-1466.412,2606.656,90.865,0.0,-368.595,-377.264);
CreateDynamicObject(18450,-1454.622,2603.002,93.481,0.0,-375.471,-377.264);
CreateDynamicObject(18450,-1502.599,2617.898,88.062,0.0,-360.860,-377.264);
CreateDynamicObject(18450,-1539.872,2629.474,90.388,0.0,-349.688,-377.264);
CreateDynamicObject(18450,-1526.113,2625.179,88.753,0.0,-355.704,-377.264);
CreateDynamicObject(18450,-1573.720,2639.969,99.758,0.0,-339.374,-377.264);
CreateDynamicObject(18450,-1559.320,2635.504,94.708,0.0,-343.672,-377.264);
CreateDynamicObject(18450,-1607.037,2650.343,115.347,0.0,-329.061,-377.264);
CreateDynamicObject(18450,-1596.100,2646.910,109.254,0.0,-335.077,-377.264);
CreateDynamicObject(18450,-1676.907,2672.001,127.509,0.0,-372.033,-377.264);
CreateDynamicObject(18450,-1744.503,2693.010,112.403,0.0,-372.033,-377.264);
CreateDynamicObject(18450,-1797.090,2709.389,108.761,0.0,-355.704,-377.264);
CreateDynamicObject(18450,-1769.812,2700.854,107.400,0.0,-359.141,-377.264);
CreateDynamicObject(18450,-1819.584,2716.375,113.462,0.0,-347.969,-377.264);
CreateDynamicObject(4867,-173.155,2207.067,109.451,0.0,0.0,-269.216);
CreateDynamicObject(18226,-252.967,2113.115,109.140,0.0,0.0,-528.748);
CreateDynamicObject(18226,-192.579,2106.412,102.965,0.0,0.0,-472.501);
CreateDynamicObject(18226,-119.327,2117.467,114.715,0.0,0.0,-472.501);
CreateDynamicObject(711,-258.735,2241.720,115.380,0.0,0.0,0.0);
CreateDynamicObject(711,-263.460,2224.596,115.545,0.0,0.0,0.0);
CreateDynamicObject(2780,-263.569,2224.655,116.520,0.0,0.0,0.0);
CreateDynamicObject(2780,-258.673,2241.741,116.205,0.0,0.0,0.0);
CreateDynamicObject(18226,-81.731,2153.262,116.640,0.0,0.0,-416.248);
CreateDynamicObject(18226,-75.572,2218.293,109.640,0.0,0.0,-416.248);
CreateDynamicObject(18226,-63.217,2281.541,122.425,0.0,0.0,-392.184);
CreateDynamicObject(18226,-101.235,2310.774,116.140,0.0,0.0,-343.196);
CreateDynamicObject(18226,-160.732,2311.200,111.065,0.0,0.0,-325.623);
CreateDynamicObject(18226,-213.906,2339.659,109.977,0.0,0.0,-325.623);
CreateDynamicObject(18226,-275.587,2360.976,108.435,0.0,0.0,-325.623);
CreateDynamicObject(18450,-460.074,2293.785,183.806,0.0,-323.905,-377.264);
CreateDynamicObject(18450,-1767.130,2700.042,107.995,0.0,-364.298,-377.264);
CreateDynamicObject(18450,-1860.376,2728.871,124.265,-354.844,-332.499,-377.264);
CreateDynamicObject(18450,-1918.923,2744.085,155.584,-354.844,-332.499,-377.264);
CreateDynamicObject(18450,-1980.635,2758.908,189.452,-352.266,-330.780,-376.405);
CreateDynamicObject(18450,-2042.810,2772.180,224.566,-352.266,-330.780,-376.405);
CreateDynamicObject(18450,-2111.644,2791.835,228.812,-352.266,-382.346,-376.405);
CreateDynamicObject(18450,-2170.084,2812.628,203.577,-352.266,-382.346,-376.405);
CreateDynamicObject(18450,-2212.582,2826.711,192.601,-352.266,-365.157,-376.405);
CreateDynamicObject(18450,-2190.078,2819.549,196.300,-352.266,-373.752,-376.405);
CreateDynamicObject(18450,-2248.893,2837.700,190.375,0.0,-356.563,-376.405);
CreateDynamicObject(18450,-2310.960,2856.180,196.740,-362.579,-352.266,-376.405);
CreateDynamicObject(18450,-2375.525,2875.653,205.889,-362.579,-352.266,-376.405);
CreateDynamicObject(18450,-2418.518,2887.744,214.190,-350.547,-345.390,-376.405);
CreateDynamicObject(18450,-2454.489,2896.283,224.360,-341.093,-336.796,-376.405);
CreateDynamicObject(18450,-500.076,2306.235,216.253,0.0,-320.467,-377.264);
CreateDynamicObject(18450,-429.914,2284.444,160.833,0.0,-323.905,-377.264);
CreateDynamicObject(18450,-2519.616,2905.990,250.796,-341.093,-336.796,-376.405);
CreateDynamicObject(18450,-2594.172,2923.516,263.409,-341.093,-363.439,-376.405);
CreateDynamicObject(18450,-2664.278,2948.686,260.069,-340.234,-361.720,-381.561);
CreateDynamicObject(18450,-2733.044,2976.569,257.939,-340.234,-361.720,-381.561);
CreateDynamicObject(18450,-2806.468,2998.208,255.636,-340.234,-361.720,-370.314);
CreateDynamicObject(18450,-2865.543,3007.956,253.960,-340.234,-361.720,-367.656);
CreateDynamicObject(18450,-2928.059,3014.023,252.143,-340.234,-361.720,-362.424);
CreateDynamicObject(18450,-3000.809,3010.159,249.895,-342.812,-361.720,-351.172);
CreateDynamicObject(8040,3765.612,-1877.323,1799.874,0.0,0.0,-180.000);
CreateDynamicObject(18450,3691.241,-1877.027,1778.758,0.0,-390.081,0.0);
CreateDynamicObject(18450,3626.156,-1876.962,1741.048,0.0,-390.081,0.0);
CreateDynamicObject(18450,3557.563,-1876.949,1701.284,0.0,-390.081,0.0);
CreateDynamicObject(18450,3491.165,-1876.956,1657.315,0.0,-396.957,0.0);
CreateDynamicObject(18450,3427.323,-1876.966,1609.275,0.0,-396.957,0.0);
CreateDynamicObject(18450,3357.464,-1876.958,1574.192,0.0,-376.330,0.0);
CreateDynamicObject(18450,3395.242,-1876.944,1588.339,0.0,-387.503,0.0);
CreateDynamicObject(18450,3283.363,-1876.941,1545.641,0.0,-385.784,0.0);
CreateDynamicObject(18450,3212.075,-1876.954,1511.194,0.0,-385.784,0.0);
CreateDynamicObject(18450,3176.446,-1876.957,1493.982,0.0,-385.784,0.0);
CreateDynamicObject(18450,3140.744,-1876.964,1476.936,0.0,-378.049,0.0);
CreateDynamicObject(18450,3141.846,-1876.992,1478.626,0.0,-381.487,0.0);
CreateDynamicObject(18450,3068.325,-1877.011,1444.564,0.0,-390.081,0.0);
CreateDynamicObject(18450,3002.223,-1877.019,1400.063,0.0,-397.816,0.0);
CreateDynamicObject(18450,2939.394,-1877.009,1351.302,0.0,-397.816,0.0);
CreateDynamicObject(18450,2878.147,-1877.007,1303.761,0.0,-397.816,0.0);
CreateDynamicObject(18450,2816.449,-1877.016,1255.876,0.0,-397.816,0.0);
CreateDynamicObject(18450,2761.629,-1877.025,1213.324,0.0,-397.816,0.0);
CreateDynamicObject(18450,2701.657,-1877.017,1160.716,0.0,-404.692,0.0);
CreateDynamicObject(18450,2646.906,-1877.007,1106.543,0.0,-404.692,0.0);
CreateDynamicObject(18450,2591.467,-1876.998,1051.681,0.0,-404.692,0.0);
CreateDynamicObject(18450,2534.942,-1876.976,995.709,0.0,-404.692,0.0);
CreateDynamicObject(18450,2481.326,-1876.987,936.743,0.0,-410.708,0.0);
CreateDynamicObject(18450,2432.500,-1876.998,877.052,0.0,-410.708,0.0);
CreateDynamicObject(18450,2383.269,-1876.983,816.874,0.0,-410.708,0.0);
CreateDynamicObject(18450,2337.084,-1876.981,751.933,0.0,-418.443,0.0);
CreateDynamicObject(18450,2297.643,-1876.982,687.719,0.0,-418.443,0.0);
CreateDynamicObject(18450,2256.316,-1876.974,620.429,0.0,-418.443,0.0);
CreateDynamicObject(18450,2216.011,-1876.988,554.791,0.0,-418.443,0.0);
CreateDynamicObject(18450,2177.145,-1877.013,491.509,0.0,-418.443,0.0);
CreateDynamicObject(18450,2141.771,-1877.048,420.242,0.0,-428.756,0.0);
CreateDynamicObject(18450,2113.308,-1877.051,346.987,0.0,-428.756,0.0);
CreateDynamicObject(18450,2085.731,-1877.046,276.045,0.0,-428.756,0.0);
CreateDynamicObject(18450,2058.108,-1877.063,204.959,0.0,-428.756,0.0);
CreateDynamicObject(18450,2030.834,-1877.064,134.747,0.0,-428.756,0.0);
CreateDynamicObject(18450,2003.157,-1877.058,63.577,0.0,-428.756,0.0);
CreateDynamicObject(18450,1990.246,-1877.062,33.884,0.0,-378.049,0.0);
CreateDynamicObject(18450,1989.127,-1877.065,37.310,0.0,-401.254,0.0);
CreateDynamicObject(18450,1963.068,-1877.068,26.964,0.0,-357.423,0.0);
CreateDynamicObject(18450,1968.747,-1877.086,28.383,0.0,-372.033,0.0);
CreateDynamicObject(18450,1992.916,-1877.086,42.161,0.0,-406.410,0.0);
CreateDynamicObject(1225,1925.809,-1883.917,29.594,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.396,-1877.178,29.410,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.444,-1873.733,29.408,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.214,-1871.556,29.418,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.591,-1873.847,29.401,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.936,-1874.487,29.386,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.547,-1875.452,29.403,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.338,-1876.663,29.413,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.197,-1877.947,29.419,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.157,-1878.592,29.421,0.0,0.0,0.0);
CreateDynamicObject(1225,1924.971,-1879.234,29.429,0.0,0.0,0.0);
CreateDynamicObject(1225,1924.990,-1880.472,29.428,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.034,-1881.187,29.426,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.333,-1881.613,29.615,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.408,-1882.252,29.612,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.131,-1882.688,29.624,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.319,-1883.185,30.216,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.438,-1874.419,29.408,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.038,-1872.733,29.426,0.0,0.0,0.0);
CreateDynamicObject(1225,1924.561,-1870.495,29.448,0.0,0.0,0.0);
CreateDynamicObject(1225,1924.040,-1871.229,29.471,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.616,-1872.229,29.400,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.448,-1876.002,29.408,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.872,-1872.929,29.389,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.263,-1875.015,29.416,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.310,-1877.634,29.996,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.025,-1879.365,29.860,0.0,0.0,0.0);
CreateDynamicObject(1225,1924.819,-1879.769,29.436,0.0,0.0,0.0);
CreateDynamicObject(1225,1924.690,-1871.286,29.442,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.389,-1881.350,30.059,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.243,-1882.275,29.619,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.339,-1882.917,29.615,0.0,0.0,0.0);
CreateDynamicObject(1225,1925.860,-1883.276,30.192,0.0,0.0,0.0);
CreateDynamicObject(1225,1907.538,-1887.584,17.022,0.0,0.0,0.0);
CreateDynamicObject(1225,1906.827,-1888.134,16.705,0.0,0.0,0.0);
CreateDynamicObject(1225,2901.744,-1881.111,1322.915,0.0,0.0,0.0);
CreateDynamicObject(1225,3163.084,-1872.661,1488.315,0.0,0.0,0.0);
CreateDynamicObject(1225,3523.917,-1880.023,1682.599,0.0,0.0,0.0);
CreateDynamicObject(18450,1981.957,-1877.087,34.200,0.0,-388.362,0.0);
CreateDynamicObject(6295,604.193,-2113.299,-6.085,0.0,0.0,0.0);
CreateDynamicObject(9584,694.907,-2178.583,-30.216,-16.329,0.0,-112.500);
CreateDynamicObject(9958,561.827,-2182.560,-26.064,-18.048,0.0,0.0);
CreateDynamicObject(6987,594.258,-2271.138,-38.928,-8.594,0.0,-213.748);
CreateDynamicObject(8395,454.902,-2069.268,-22.897,0.0,0.0,0.0);
CreateDynamicObject(8663,398.906,-2286.402,-23.658,0.0,0.0,0.0);
CreateDynamicObject(9071,357.608,-2183.210,-21.332,-0.859,0.0,-101.247);
CreateDynamicObject(14537,410.805,-2286.834,-27.311,0.0,0.0,0.0);
CreateDynamicObject(16051,506.714,-2118.114,-26.100,0.0,0.0,-292.501);
CreateDynamicObject(16146,555.344,-2357.874,-26.121,0.0,0.0,-45.000);
CreateDynamicObject(3755,673.268,-2417.510,-27.261,0.0,0.0,-112.500);
CreateDynamicObject(5313,522.624,-2481.095,-16.264,0.0,0.0,-315.001);
CreateDynamicObject(6404,387.831,-2479.769,-26.774,0.0,0.0,-45.000);
CreateDynamicObject(7490,226.194,-2426.973,-24.263,0.0,0.0,0.0);
CreateDynamicObject(9260,313.509,-2477.806,-24.050,0.0,0.0,-90.000);
CreateDynamicObject(10775,223.407,-2311.741,-22.893,-7.735,0.0,0.0);
CreateDynamicObject(10776,259.558,-2236.667,-27.826,0.0,0.0,-270.001);
CreateDynamicObject(11011,212.716,-2494.218,-24.624,0.0,0.0,0.0);
CreateDynamicObject(11012,311.546,-2543.243,-22.710,0.0,0.0,-348.748);
CreateDynamicObject(12847,762.875,-2513.143,-23.047,0.0,0.0,-191.248);
CreateDynamicObject(12931,577.859,-2682.938,-43.216,0.0,0.0,-112.500);
CreateDynamicObject(17015,457.926,-2265.261,4.649,0.0,0.0,0.0);
CreateDynamicObject(17017,435.038,-2363.648,22.838,0.0,0.0,0.0);
CreateDynamicObject(3781,198.966,-2174.649,-15.618,0.0,0.0,0.0);
CreateDynamicObject(4113,185.743,-2112.936,6.271,0.0,0.0,-337.501);
CreateDynamicObject(4550,400.749,-2593.352,-0.257,-42.972,0.0,0.0);
CreateDynamicObject(4601,697.634,-2699.514,-0.657,0.0,0.0,-258.748);
CreateDynamicObject(5033,443.938,-2713.664,-24.664,0.0,0.0,-348.748);
CreateDynamicObject(6364,228.402,-2038.281,-18.054,0.0,0.0,-78.747);
CreateDynamicObject(6366,324.080,-2042.910,-21.879,-16.329,0.0,-213.748);
CreateDynamicObject(6993,-21.053,-2178.951,-43.720,0.0,0.0,-45.000);
CreateDynamicObject(8393,-51.577,-2401.256,-39.267,-358.282,-349.688,-326.248);
CreateDynamicObject(8419,63.991,-2473.620,-34.104,0.0,0.0,-258.748);
CreateDynamicObject(8421,337.923,-2182.534,-2.730,0.0,0.0,-101.247);
CreateDynamicObject(8489,87.360,-2608.721,-25.423,0.0,0.0,0.0);
CreateDynamicObject(3866,759.330,-2384.485,-14.093,0.0,0.0,0.0);
CreateDynamicObject(3887,266.203,-1991.974,-8.021,0.0,0.0,-225.001);
CreateDynamicObject(4101,-216.265,-2017.632,-31.075,-353.125,-358.282,-270.001);
CreateDynamicObject(5408,-150.101,-1727.037,-35.044,0.0,0.0,0.0);
CreateDynamicObject(5708,-52.502,-1737.824,-44.752,0.0,0.0,-101.247);
CreateDynamicObject(5716,89.265,-2003.657,-46.226,0.0,0.0,-90.000);
CreateDynamicObject(6863,-164.952,-2177.864,-28.131,0.0,0.0,0.0);
CreateDynamicObject(6994,-52.961,-1930.752,-65.253,0.0,0.0,-146.247);
CreateDynamicObject(7511,123.682,-1836.847,-37.576,0.0,0.0,-90.000);
CreateDynamicObject(8131,8.889,-1988.968,-67.556,0.0,0.0,0.0);
CreateDynamicObject(8493,502.036,-2383.679,-24.861,-18.048,0.0,-326.248);
CreateDynamicObject(8620,225.034,-2372.048,-16.454,0.0,0.0,-270.001);
CreateDynamicObject(11427,235.541,-2261.785,-22.068,0.0,0.0,-292.501);
CreateDynamicObject(11428,780.968,-2149.547,-13.556,0.0,0.0,0.0);
CreateDynamicObject(8493,444.752,-2184.742,-17.559,0.0,0.0,-101.247);
CreateDynamicObject(8493,123.600,-2638.592,-20.174,0.0,0.0,0.0);
CreateDynamicObject(8397,81.290,-2777.565,-30.618,0.0,0.0,-78.747);
CreateDynamicObject(8498,254.087,-2791.319,-22.075,0.0,0.0,-213.748);
CreateDynamicObject(7983,41.554,-1612.764,-24.627,-6.016,0.0,-168.748);
CreateDynamicObject(4867,3859.492,-1886.581,3.075,0.0,0.0,0.0);
CreateDynamicObject(4867,3859.492,-2066.172,3.097,0.0,0.0,-180.000);
CreateDynamicObject(4867,4070.187,-2066.277,3.094,0.0,0.0,-180.000);
CreateDynamicObject(4867,4070.217,-1886.586,3.066,0.0,0.0,0.0);
CreateDynamicObject(4867,4275.091,-1886.500,3.063,0.0,0.0,0.0);
CreateDynamicObject(4867,4275.291,-2066.279,3.085,0.0,0.0,-180.000);
CreateDynamicObject(16771,4402.194,-1876.063,9.609,0.0,0.0,-270.001);
CreateDynamicObject(16771,4402.167,-1929.215,9.609,0.0,0.0,-270.001);
CreateDynamicObject(4563,4598.915,-2087.499,-55.709,0.0,0.0,-90.000);
CreateDynamicObject(3996,4452.139,-2108.177,33.865,0.0,-325.623,-180.000);
CreateDynamicObject(3996,4536.337,-2108.191,91.435,0.0,-325.623,-180.000);
CreateDynamicObject(1684,4413.592,-2108.150,6.772,-171.784,0.0,-90.000);
CreateDynamicObject(1684,4409.256,-2108.141,6.579,-182.957,0.0,-90.000);
CreateDynamicObject(1684,4405.054,-2108.150,7.137,-192.411,0.0,-90.000);
CreateDynamicObject(1684,4400.927,-2108.132,8.471,-203.583,0.0,-90.000);
CreateDynamicObject(1684,4397.191,-2108.123,10.716,-219.053,0.0,-90.000);
CreateDynamicObject(1684,4394.233,-2108.100,13.844,-233.664,0.0,-90.000);
CreateDynamicObject(1684,4392.286,-2108.108,17.548,-250.852,0.0,-90.000);
CreateDynamicObject(1684,4391.305,-2108.112,21.721,-262.884,0.0,-90.000);
CreateDynamicObject(1684,4390.830,-2108.117,25.551,-262.884,0.0,-90.000);
CreateDynamicObject(1684,4390.396,-2108.117,29.495,-264.603,0.0,-90.000);
CreateDynamicObject(1684,4384.116,-2108.286,1.825,-172.644,0.0,-90.000);
CreateDynamicObject(1395,4397.605,-1995.469,14.165,-359.141,-302.419,0.0);
CreateDynamicObject(1684,4440.346,-2002.243,39.875,-176.081,0.0,-90.000);
CreateDynamicObject(18367,4441.870,-2004.361,41.084,-15.470,0.0,-281.248);
CreateDynamicObject(18367,4469.687,-2009.816,52.427,-18.908,0.0,-280.388);
CreateDynamicObject(13638,4502.182,-2021.629,68.045,0.0,0.0,-190.314);
CreateDynamicObject(13638,4512.536,-2033.902,75.631,0.0,0.0,-178.127);
CreateDynamicObject(3502,4520.657,-2042.603,84.599,-27.502,-27.502,-292.501);
CreateDynamicObject(13638,4531.681,-2049.724,87.324,0.0,0.0,-178.127);
CreateDynamicObject(18367,4536.639,-2056.343,92.545,-12.892,0.0,-286.404);
CreateDynamicObject(3502,4567.306,-2065.996,106.463,-27.502,-27.502,-292.501);
CreateDynamicObject(13638,4574.828,-2075.046,108.704,0.0,0.0,-200.627);
CreateDynamicObject(13638,4572.642,-2090.963,112.841,0.0,0.0,-174.844);
CreateDynamicObject(1684,4580.681,-2108.385,118.565,-191.551,0.0,-90.000);
CreateDynamicObject(1684,4584.323,-2108.394,117.391,-203.583,0.0,-90.000);
CreateDynamicObject(1684,4384.140,-2098.360,1.825,-172.644,0.0,-90.000);
CreateDynamicObject(1684,4384.113,-2118.213,1.825,-172.644,0.0,-90.000);
CreateDynamicObject(1632,4274.599,-1861.273,3.863,0.0,0.0,-265.703);
CreateDynamicObject(1632,4268.162,-1861.736,8.132,-338.515,-359.141,-265.703);
CreateDynamicObject(8620,4253.444,-1863.492,5.427,0.0,0.0,-85.703);
CreateDynamicObject(1632,4238.357,-1864.870,4.363,-349.688,0.0,-85.778);
CreateDynamicObject(1632,4243.337,-1864.508,8.482,-336.796,0.0,-85.778);
CreateDynamicObject(1632,4246.848,-1864.265,13.000,-323.045,0.0,-85.778);
CreateDynamicObject(8493,4199.631,-1931.202,16.835,-336.796,-331.639,-359.141);
CreateDynamicObject(1503,4206.234,-1924.072,3.457,-351.406,0.0,-270.001);
CreateDynamicObject(1660,4178.435,-1932.260,2.658,0.0,0.0,-89.141);
CreateDynamicObject(16317,4188.350,-1917.810,2.757,0.0,0.0,0.0);
CreateDynamicObject(6994,4191.401,-2080.879,11.655,0.0,0.0,-88.281);
CreateDynamicObject(1245,4229.093,-2088.578,4.147,0.0,0.0,-355.704);
CreateDynamicObject(1245,4224.990,-2088.744,6.617,0.0,0.0,-355.704);
CreateDynamicObject(13592,4165.608,-2099.171,12.665,-1.719,-30.940,-348.748);
CreateDynamicObject(1634,4195.977,-2065.376,4.782,-350.547,0.0,-177.422);
CreateDynamicObject(1634,4196.205,-2070.817,9.676,-336.796,0.0,-177.422);
CreateDynamicObject(1634,4196.383,-2075.070,15.746,-323.905,0.0,-177.422);
CreateDynamicObject(1634,4196.429,-2077.736,22.207,-311.872,0.0,-177.422);
CreateDynamicObject(1696,4215.108,-2137.837,21.373,0.0,0.0,-87.422);
CreateDynamicObject(1697,4182.026,-2142.049,21.593,0.0,0.0,-89.141);
CreateDynamicObject(1245,4125.289,-2140.358,4.582,-0.859,-351.406,-181.238);
CreateDynamicObject(1245,4128.531,-2140.613,7.242,-0.859,-351.406,-181.238);
CreateDynamicObject(7023,4242.208,-2021.114,2.958,0.0,0.0,0.0);
CreateDynamicObject(1634,4254.858,-2048.480,5.482,-341.093,0.0,-267.182);
CreateDynamicObject(13592,4212.002,-2055.919,13.056,-1.719,-10.313,-348.748);
CreateDynamicObject(1634,4219.192,-2049.462,5.732,-349.688,0.0,-82.953);
CreateDynamicObject(1634,4219.559,-2052.790,5.711,-349.688,0.0,-82.953);
CreateDynamicObject(971,4143.458,-1977.792,5.414,-316.170,0.0,-88.522);
CreateDynamicObject(971,4139.670,-1977.928,10.490,-330.780,0.0,-88.522);
CreateDynamicObject(971,4136.893,-1978.017,16.187,-338.515,0.0,-88.522);
CreateDynamicObject(971,4135.339,-1978.076,20.563,-343.672,0.0,-88.522);
CreateDynamicObject(1634,4127.695,-1978.133,15.193,-332.499,0.0,-88.522);
CreateDynamicObject(1634,4122.823,-1978.253,10.056,-345.390,0.0,-88.522);
CreateDynamicObject(1634,4116.882,-1978.411,6.057,-357.423,0.0,-88.522);
CreateDynamicObject(1634,4110.042,-1978.597,3.256,-8.594,0.0,-88.522);
CreateDynamicObject(1245,4242.089,-2005.352,4.497,0.0,-351.406,-270.619);
CreateDynamicObject(6283,4054.173,-1838.191,8.019,0.0,0.0,-272.579);
CreateDynamicObject(1634,4067.017,-1859.348,4.590,-351.406,0.0,-270.860);
CreateDynamicObject(1655,4072.171,-1835.271,4.366,-353.985,0.0,-270.001);
CreateDynamicObject(1655,4066.537,-1835.260,8.357,-341.093,0.0,-270.001);
CreateDynamicObject(1655,4062.434,-1835.250,12.711,-330.780,0.0,-270.001);
CreateDynamicObject(1655,4058.458,-1835.260,19.414,-316.170,0.0,-270.001);
CreateDynamicObject(13592,4076.401,-1816.111,14.637,0.0,-335.937,-353.125);
CreateDynamicObject(1655,4069.583,-1821.073,8.665,-336.796,0.0,-268.282);
CreateDynamicObject(16304,4041.357,-1859.924,7.718,0.0,0.0,0.0);
CreateDynamicObject(18451,4165.351,-2072.894,3.356,0.0,0.0,-179.141);
CreateDynamicObject(18231,3982.774,-1950.206,4.392,-13.751,-81.646,-347.109);
CreateDynamicObject(8395,3905.627,-2064.174,-19.080,0.0,0.0,0.0);
CreateDynamicObject(2780,3905.361,-2063.128,18.887,0.0,0.0,0.0);
CreateDynamicObject(1697,3905.609,-2064.291,19.656,-328.202,0.0,0.0);
CreateDynamicObject(3665,3973.906,-1920.369,4.123,0.0,0.0,-90.000);
CreateDynamicObject(7979,4003.613,-1947.535,5.987,0.0,0.0,-258.748);
CreateDynamicObject(16401,3982.402,-1884.813,3.261,0.0,-18.048,-135.000);
CreateDynamicObject(16304,3957.294,-1872.052,7.435,0.0,0.0,0.0);
CreateDynamicObject(16305,3941.309,-1882.699,8.280,0.0,0.0,0.0);
CreateDynamicObject(16317,3951.056,-1876.783,2.939,0.0,0.0,0.0);
CreateDynamicObject(1634,3921.331,-2064.522,4.394,-352.266,0.0,-270.001);
CreateDynamicObject(1634,3905.585,-2048.558,4.394,-352.266,0.0,-180.000);
CreateDynamicObject(1634,3890.017,-2064.024,4.394,-352.266,0.0,-90.000);
CreateDynamicObject(1634,3905.905,-2079.779,4.394,-352.266,0.0,-360.001);
CreateDynamicObject(16134,3946.578,-1960.994,-0.181,0.0,-358.282,-85.548);
CreateDynamicObject(13590,4134.798,-1983.695,4.295,0.0,0.0,-359.141);
CreateDynamicObject(10948,3790.774,-1877.927,60.541,0.0,0.0,0.0);
CreateDynamicObject(13638,3849.674,-1881.843,5.448,0.0,0.0,-270.001);
CreateDynamicObject(13638,3837.828,-1893.585,13.359,0.0,0.0,-270.001);
CreateDynamicObject(13638,3825.522,-1905.683,21.346,0.0,0.0,-270.001);
CreateDynamicObject(13638,3814.339,-1917.589,29.332,0.0,0.0,-270.001);
CreateDynamicObject(18367,3807.193,-1920.996,34.553,-10.313,0.0,-90.000);
CreateDynamicObject(18367,3777.610,-1923.897,43.491,-10.313,0.0,-270.001);
CreateDynamicObject(1660,3774.710,-1914.264,39.523,0.0,0.0,-180.000);
CreateDynamicObject(1660,3809.981,-1927.584,52.602,-33.518,0.0,0.0);
CreateDynamicObject(1472,3809.294,-1921.864,53.091,0.0,0.0,0.0);
CreateDynamicObject(1472,3809.318,-1920.969,53.770,0.0,0.0,0.0);
CreateDynamicObject(1472,3809.341,-1919.993,54.549,0.0,0.0,0.0);
CreateDynamicObject(13638,3767.962,-1897.405,57.545,0.0,0.0,0.0);
CreateDynamicObject(18367,3765.922,-1889.887,62.840,-22.345,0.0,-180.000);
CreateDynamicObject(1660,3767.240,-1862.862,77.835,-33.518,0.0,0.0);
CreateDynamicObject(1472,3770.107,-1858.993,78.427,0.0,0.0,-90.000);
CreateDynamicObject(1660,3803.365,-1880.863,78.042,0.0,0.0,-270.001);
CreateDynamicObject(1660,3811.168,-1880.871,81.804,0.0,0.0,-270.001);
CreateDynamicObject(1660,3818.888,-1880.882,85.469,0.0,0.0,-270.001);
CreateDynamicObject(18367,3812.343,-1881.326,89.264,-18.908,0.0,-270.001);
CreateDynamicObject(13592,3853.583,-1869.359,112.393,0.0,0.0,-353.125);
CreateDynamicObject(13592,3854.846,-1861.489,112.192,0.0,0.0,-353.125);
CreateDynamicObject(16401,3864.583,-1857.749,102.410,0.0,-4.297,-4.297);
CreateDynamicObject(13592,3861.288,-1853.381,113.280,-2.578,-40.394,-355.704);
CreateDynamicObject(18367,3805.979,-1878.865,102.354,-8.594,0.0,0.0);
CreateDynamicObject(18367,3805.977,-1908.120,110.195,-8.594,0.0,0.0);
CreateDynamicObject(13641,3806.180,-1940.516,119.782,0.0,0.0,-90.000);
CreateDynamicObject(13603,3985.956,-1826.556,0.001,0.0,0.0,0.0);
CreateDynamicObject(5309,3790.909,-2142.257,7.465,0.0,0.0,0.0);
CreateDynamicObject(18367,3766.673,-2104.463,2.629,-13.751,0.0,0.0);
CreateDynamicObject(1634,3829.499,-2140.131,13.121,0.0,0.0,-90.000);
CreateDynamicObject(1634,3835.427,-2140.136,16.926,-345.390,0.0,-90.000);
CreateDynamicObject(5309,3925.152,-2142.366,6.590,0.0,0.0,0.0);
CreateDynamicObject(1634,3885.906,-2141.353,12.114,0.0,0.0,-270.001);
CreateDynamicObject(8493,3852.403,-2135.468,21.119,-337.655,-356.563,-231.945);
CreateDynamicObject(8493,3866.458,-2139.334,15.619,-307.575,-318.748,-250.698);
CreateDynamicObject(1633,4071.217,-2071.743,4.069,0.0,0.0,-270.001);
CreateDynamicObject(1633,4064.619,-2071.773,6.070,-358.282,0.0,-270.001);
CreateDynamicObject(1634,4057.640,-2071.760,8.108,0.0,0.0,-270.001);
CreateDynamicObject(1260,4018.786,-2073.745,5.967,0.0,0.0,-270.001);
CreateDynamicObject(12956,4069.343,-2011.477,5.797,0.0,0.0,0.0);
CreateDynamicObject(8302,4076.561,-2036.326,5.669,-342.812,-2.578,-258.748);
CreateDynamicObject(3627,4145.741,-1824.498,6.155,0.0,0.0,0.0);
CreateDynamicObject(1245,4211.606,-1820.836,4.226,0.0,0.0,0.0);
CreateDynamicObject(1245,4207.146,-1820.693,6.888,0.0,0.0,0.0);
CreateDynamicObject(1245,4202.647,-1820.507,9.590,0.0,0.0,0.0);
CreateDynamicObject(8069,4292.392,-1941.026,6.595,0.0,0.0,0.0);
CreateDynamicObject(1634,4311.724,-1907.376,4.985,-347.109,0.0,-219.844);
CreateDynamicObject(13592,4291.845,-1962.515,18.854,-301.559,-22.345,-44.691);
CreateDynamicObject(13592,4294.844,-1960.849,25.003,-301.559,-22.345,-44.691);
CreateDynamicObject(13592,4297.454,-1959.439,30.336,-301.559,-22.345,-44.691);
CreateDynamicObject(969,4309.994,-1960.941,30.409,-29.221,-6.875,-69.614);
CreateDynamicObject(969,4308.685,-1961.824,27.686,-29.221,-6.875,-69.614);
CreateDynamicObject(13647,4342.550,-2025.396,2.331,0.0,0.0,-109.922);
CreateDynamicObject(13647,4328.605,-2017.555,2.581,0.0,0.0,-290.856);
CreateDynamicObject(3402,3812.154,-1999.156,3.088,0.0,0.0,0.0);
CreateDynamicObject(3402,3841.980,-1999.150,3.088,0.0,0.0,0.0);
CreateDynamicObject(1634,3794.162,-1999.006,7.223,0.0,0.0,-270.001);
CreateDynamicObject(1634,3788.163,-1999.016,11.454,-339.374,0.0,-270.001);
CreateDynamicObject(1634,3784.777,-1999.021,17.186,-314.451,0.0,-270.001);
CreateDynamicObject(1634,3783.946,-1999.046,22.412,-292.965,0.0,-270.001);
CreateDynamicObject(1634,3784.770,-1999.038,27.969,-279.214,0.0,-270.001);
CreateDynamicObject(1634,3774.015,-1998.010,3.969,0.0,0.0,-273.438);
CreateDynamicObject(1634,3768.698,-1997.719,7.650,-341.953,0.0,-273.438);
CreateDynamicObject(1634,3764.777,-1997.494,12.210,-329.921,0.0,-273.438);
CreateDynamicObject(1634,3762.598,-1997.336,16.837,-307.575,0.0,-273.438);
CreateDynamicObject(1634,3762.166,-1997.303,23.179,-289.527,0.0,-273.438);
CreateDynamicObject(1634,3762.972,-1997.343,27.435,-276.635,0.0,-273.438);
CreateDynamicObject(2931,3861.801,-1997.601,3.006,0.0,0.0,-270.001);
CreateDynamicObject(2931,3858.671,-1997.617,4.804,0.0,0.0,-270.001);
CreateDynamicObject(1634,3955.805,-1981.381,4.669,-349.688,0.0,-358.282);
CreateDynamicObject(1634,4018.574,-2090.935,4.066,0.0,0.0,-359.141);
CreateDynamicObject(1634,4018.507,-2086.077,7.527,-341.953,0.0,-359.141);
CreateDynamicObject(13641,4017.740,-2083.177,12.444,-358.282,-34.377,-267.497);
CreateDynamicObject(13592,3982.727,-2073.337,13.290,-1.719,-11.173,-353.985);
CreateDynamicObject(1655,3991.610,-2068.816,5.434,0.0,0.0,-90.000);
CreateDynamicObject(8302,4052.804,-2034.738,5.069,-342.812,-2.578,-78.747);
CreateDynamicObject(1634,4263.698,-2141.306,4.382,-353.985,0.0,-270.001);
CreateDynamicObject(1634,4257.563,-2141.304,9.410,-338.515,0.0,-270.001);
CreateDynamicObject(13641,3963.575,-2138.726,12.818,-359.141,-3.438,-4.618);
CreateDynamicObject(13641,3963.355,-2143.139,12.818,-359.141,-3.438,-4.618);
CreateDynamicObject(1245,3968.542,-2142.498,15.292,0.0,-353.985,-180.000);
CreateDynamicObject(13642,3829.750,-1832.573,104.550,0.0,0.0,-5.157);
CreateDynamicObject(18367,3852.878,-1831.746,105.052,-8.594,0.0,-270.001);
CreateDynamicObject(1245,3884.717,-1832.698,114.548,0.0,0.0,-176.563);
CreateDynamicObject(1634,4529.471,-2115.876,87.991,-28.361,0.0,-267.422);
CreateDynamicObject(1634,4490.921,-2103.056,62.084,-28.361,0.0,-270.001);
CreateDynamicObject(8172,4037.741,-2237.246,3.134,0.0,0.0,0.0);
CreateDynamicObject(8172,4019.869,-2236.860,4.138,0.0,-353.985,-1.719);
CreateDynamicObject(8172,4001.932,-2236.378,7.022,0.0,-347.969,-1.719);
CreateDynamicObject(8172,3979.856,-2235.611,12.459,0.0,-341.953,-1.719);
CreateDynamicObject(8172,3957.076,-2235.133,21.463,0.0,-331.639,-1.719);
CreateDynamicObject(8172,3935.317,-2234.316,34.601,0.0,-326.483,-1.719);
CreateDynamicObject(8172,3919.930,-2233.788,47.062,0.0,-317.888,-1.719);
CreateDynamicObject(8172,3902.740,-2233.168,66.428,0.0,-307.575,-1.719);
CreateDynamicObject(8172,3887.657,-2232.743,91.089,0.0,-296.403,-1.719);
CreateDynamicObject(8172,3879.551,-2231.739,110.949,0.0,-281.792,-1.719);
CreateDynamicObject(8172,3855.491,-2231.047,130.406,0.0,0.0,-1.719);
CreateDynamicObject(8172,4060.796,-2237.114,4.570,0.0,-347.969,-179.141);
CreateDynamicObject(8172,4091.013,-2236.689,13.665,0.0,-337.655,-179.141);
CreateDynamicObject(8172,4119.423,-2236.086,30.065,0.0,-322.186,-179.141);
CreateDynamicObject(8172,4138.438,-2235.808,47.781,0.0,-311.872,-179.141);
CreateDynamicObject(8172,4155.359,-2235.464,71.953,0.0,-298.121,-179.141);
CreateDynamicObject(8172,4164.396,-2235.303,91.665,0.0,-289.527,-179.141);
CreateDynamicObject(8172,4168.196,-2235.051,105.158,0.0,-280.933,-179.141);
CreateDynamicObject(8172,4170.424,-2235.043,120.482,0.0,-274.917,-179.141);
CreateDynamicObject(8172,4191.571,-2234.658,140.370,0.0,0.0,-359.141);
CreateDynamicObject(1634,4368.173,-1834.651,4.060,-353.985,0.0,-138.438);
CreateDynamicObject(1634,4372.290,-1839.309,9.051,-339.374,0.0,-138.438);
CreateDynamicObject(13592,4400.805,-1896.656,23.181,0.0,0.0,-78.747);
CreateDynamicObject(13592,4408.226,-1896.266,23.200,0.0,0.0,-78.747);
CreateDynamicObject(1245,4413.315,-1898.594,14.410,-359.141,-19.767,-267.342);
CreateDynamicObject(1245,4410.053,-1898.693,14.415,-359.141,-19.767,-264.764);
CreateDynamicObject(1395,4411.583,-1965.077,21.802,-359.141,-293.824,-47.498);
CreateDynamicObject(1681,4375.419,-1929.063,6.039,0.0,0.0,-270.001);
CreateDynamicObject(1634,4377.399,-1914.661,3.810,0.0,0.0,-180.000);
CreateDynamicObject(1634,4377.759,-1943.276,3.835,0.0,0.0,0.0);
CreateDynamicObject(1503,4371.839,-1925.398,3.282,0.0,-359.141,-85.703);
CreateDynamicObject(1503,4381.788,-1925.103,3.257,0.0,-359.141,-265.703);
CreateDynamicObject(14826,4409.726,-1927.142,3.494,0.0,0.0,0.0);
CreateDynamicObject(8947,4411.392,-1928.059,6.108,0.0,0.0,-90.000);
CreateDynamicObject(3819,4295.571,-1820.724,3.736,0.0,0.0,-180.000);
CreateDynamicObject(1503,4296.411,-1820.676,3.229,0.0,0.0,-267.422);
CreateDynamicObject(3381,4250.244,-1813.569,12.515,0.0,0.0,-90.000);
CreateDynamicObject(13592,4324.934,-2100.931,12.706,0.0,0.0,-353.125);
CreateDynamicObject(13641,4324.141,-2071.664,4.219,-359.141,-355.704,-90.860);
CreateDynamicObject(4726,4314.384,-1988.064,22.985,0.0,0.0,0.0);
CreateDynamicObject(1634,4305.344,-2002.807,25.357,0.0,0.0,-185.157);
CreateDynamicObject(969,4310.755,-1995.597,24.475,-269.760,0.0,0.0);
CreateDynamicObject(1634,4304.795,-2008.831,29.166,-346.250,0.0,-185.157);
CreateDynamicObject(1634,4264.427,-1981.751,4.682,-353.125,0.0,-266.483);
CreateDynamicObject(16776,4232.125,-1975.282,3.064,0.0,0.0,0.0);
CreateDynamicObject(1634,4259.131,-1982.067,9.112,-338.515,0.0,-266.483);
CreateDynamicObject(1634,4204.184,-1981.146,4.382,-353.125,0.0,-91.719);
CreateDynamicObject(1634,4208.990,-1981.266,8.196,-341.093,0.0,-91.719);
CreateDynamicObject(17565,4090.769,-1908.960,5.200,0.0,0.0,-90.000);
CreateDynamicObject(1228,4104.107,-1921.251,3.462,0.0,0.0,0.0);
CreateDynamicObject(8550,3862.101,-1955.730,7.248,0.0,0.0,0.0);
CreateDynamicObject(1634,3857.141,-1961.015,4.262,-354.844,0.0,-45.000);
CreateDynamicObject(1634,3866.736,-1960.031,4.560,-354.844,0.0,-315.001);
CreateDynamicObject(1634,3866.670,-1951.021,4.515,-354.844,0.0,-225.001);
CreateDynamicObject(1634,3857.357,-1951.051,4.522,-354.844,0.0,-135.000);
CreateDynamicObject(1234,4370.376,-1875.276,7.123,0.0,0.0,0.0);
CreateDynamicObject(3263,1556.847,-18.626,20.529,0.0,0.0,-168.748);
CreateDynamicObject(3263,1565.478,-13.699,20.562,0.0,0.0,-168.748);
CreateDynamicObject(3263,1557.398,-15.068,20.640,0.0,0.0,-168.748);
CreateDynamicObject(3263,1554.238,-9.487,20.886,0.0,0.0,-168.748);
CreateDynamicObject(3263,1561.900,-1.042,21.733,0.0,0.0,-168.748);
CreateDynamicObject(3263,1557.968,-0.982,21.717,0.0,0.0,-168.748);
CreateDynamicObject(3263,1561.080,-12.173,20.836,0.0,0.0,-168.748);
CreateDynamicObject(3263,1560.821,-6.168,21.262,0.0,0.0,-168.748);
CreateDynamicObject(3263,1556.232,-10.338,20.866,0.0,0.0,-168.748);
CreateDynamicObject(3263,1558.969,-7.099,21.150,0.0,0.0,-168.748);
CreateDynamicObject(3263,1564.265,-5.811,21.221,0.0,0.0,-168.748);
CreateDynamicObject(3264,1547.723,-142.026,16.514,0.0,0.0,-585.001);
CreateDynamicObject(3264,1553.716,-144.102,16.502,0.0,0.0,-551.248);
CreateDynamicObject(3264,1547.857,-111.643,18.271,0.0,0.0,-607.501);
CreateDynamicObject(3856,1561.159,-28.778,25.201,0.0,0.0,-450.001);
CreateDynamicObject(4729,1565.569,-28.292,26.877,0.0,0.0,-250.079);
CreateDynamicObject(7306,1536.948,-178.086,16.454,0.0,-359.141,-90.075);
CreateDynamicObject(7306,1482.028,-192.961,12.368,0.0,-359.141,-292.575);
CreateDynamicObject(7305,1284.220,-154.285,35.093,0.0,-338.515,-350.547);
CreateDynamicObject(7415,1222.932,-127.883,47.336,0.0,0.0,-528.748);
CreateDynamicObject(8293,1166.637,-62.192,48.238,0.0,0.0,-292.501);
CreateDynamicObject(8293,995.229,-83.442,33.772,-357.423,-715.808,-588.542);
CreateDynamicObject(10838,685.337,-193.761,31.520,0.0,0.0,-348.748);
CreateDynamicObject(11395,727.971,-159.124,27.253,0.0,0.0,-315.001);
CreateDynamicObject(1322,1121.355,-54.584,20.495,0.0,0.0,0.0);
CreateDynamicObject(3262,778.002,-86.759,4.725,0.0,0.0,0.0);
CreateDynamicObject(3264,565.771,-202.996,14.810,0.0,0.0,-258.748);
CreateDynamicObject(3264,493.088,-243.071,9.852,0.0,0.0,-258.748);
CreateDynamicObject(3264,495.467,-244.239,9.852,0.0,0.0,-213.748);
CreateDynamicObject(3264,402.158,-307.306,10.370,0.0,0.0,-225.001);
CreateDynamicObject(3264,319.198,-357.831,8.395,0.0,0.0,-225.001);
CreateDynamicObject(3264,288.179,-387.833,7.841,0.0,0.0,-225.001);
CreateDynamicObject(3264,306.951,-373.678,8.521,0.0,0.0,-225.001);
CreateDynamicObject(3264,329.118,-348.417,7.726,0.0,0.0,-225.001);
CreateDynamicObject(3264,231.450,-356.996,6.068,0.0,0.0,-337.501);
CreateDynamicObject(3264,214.414,-341.225,2.663,0.0,0.0,-337.501);
CreateDynamicObject(970,211.205,-356.174,3.774,0.0,0.0,-416.248);
CreateDynamicObject(970,208.643,-352.682,3.320,0.0,0.0,-416.248);
CreateDynamicObject(970,206.191,-349.212,2.871,0.0,0.0,-416.248);
CreateDynamicObject(970,203.977,-346.175,2.477,0.0,0.0,-416.248);
CreateDynamicObject(982,310.713,-382.480,9.013,0.0,0.0,-397.111);
CreateDynamicObject(7306,686.644,-193.414,30.778,0.0,-359.141,-213.828);
CreateDynamicObject(2714,1550.802,13.485,25.633,0.0,0.0,-258.748);
CreateDynamicObject(4729,513.180,-222.518,22.757,0.0,0.0,-261.326);
CreateDynamicObject(982,103.099,-333.011,1.262,0.0,0.0,0.0);
CreateDynamicObject(982,102.635,-213.444,1.118,0.0,0.0,-326.248);
CreateDynamicObject(982,93.596,-201.090,1.271,0.0,0.0,-270.001);
CreateDynamicObject(982,-137.748,-187.056,1.520,0.0,0.0,-191.248);
CreateDynamicObject(982,-121.101,-123.470,2.793,0.0,0.0,-191.248);
CreateDynamicObject(982,-106.917,63.654,2.801,0.0,0.0,-191.248);
CreateDynamicObject(982,-30.907,177.760,1.762,0.0,0.0,-202.500);
CreateDynamicObject(982,-23.535,192.648,2.113,0.0,0.0,-213.748);
CreateDynamicObject(982,-16.640,168.192,1.762,0.0,0.0,-213.748);
CreateDynamicObject(982,-5.355,184.267,2.113,0.0,0.0,-213.748);
CreateDynamicObject(1225,683.866,-172.727,19.947,0.0,0.0,0.0);
CreateDynamicObject(1225,780.038,-134.640,29.201,0.0,0.0,0.0);
CreateDynamicObject(1225,-87.576,84.078,2.515,0.0,0.0,0.0);
CreateDynamicObject(1229,1269.358,-136.366,49.379,0.0,0.0,0.0);
CreateDynamicObject(1229,1269.358,-136.366,49.379,0.0,0.0,0.0);
CreateDynamicObject(1457,892.838,-93.618,24.123,0.0,0.0,-202.500);
CreateDynamicObject(1211,593.996,-201.074,11.837,0.0,0.0,0.0);
CreateDynamicObject(1211,587.312,-200.830,12.374,0.0,0.0,0.0);
CreateDynamicObject(1223,618.840,-191.078,9.450,0.0,0.0,-427.501);
CreateDynamicObject(1257,-116.855,-115.760,3.396,0.0,0.0,-236.248);
CreateDynamicObject(1257,-111.580,-116.503,3.396,0.0,0.0,-315.001);
CreateDynamicObject(1257,73.873,-230.171,1.857,0.0,0.0,-213.748);
CreateDynamicObject(1257,311.622,-366.103,9.862,0.0,0.0,-123.747);
CreateDynamicObject(1352,1560.015,14.010,23.237,-345.390,0.0,-536.409);
CreateDynamicObject(852,1557.619,-59.244,19.754,0.0,0.0,0.0);
CreateDynamicObject(852,1541.424,-170.709,14.389,0.0,0.0,0.0);
CreateDynamicObject(852,1535.799,-158.522,14.818,0.0,0.0,0.0);
CreateDynamicObject(852,1551.086,-134.770,16.701,0.0,0.0,0.0);
CreateDynamicObject(852,1338.797,-201.667,10.745,0.0,0.0,0.0);
CreateDynamicObject(1299,1226.565,-112.565,38.954,0.0,0.0,0.0);
CreateDynamicObject(1299,1223.643,-118.983,38.977,0.0,0.0,0.0);
CreateDynamicObject(1299,1007.755,-76.871,21.400,0.0,0.0,0.0);
CreateDynamicObject(1299,1037.142,-66.674,22.057,0.0,0.0,0.0);
CreateDynamicObject(1299,1028.323,-68.522,22.154,0.0,0.0,0.0);
CreateDynamicObject(1299,1013.108,-63.740,22.040,0.0,0.0,0.0);
CreateDynamicObject(1299,1017.964,-75.162,21.887,0.0,0.0,0.0);
CreateDynamicObject(1299,1016.414,-66.643,21.849,0.0,0.0,0.0);
CreateDynamicObject(1299,841.621,-100.282,25.484,0.0,0.0,0.0);
CreateDynamicObject(1299,844.259,-106.023,25.468,0.0,0.0,0.0);
CreateDynamicObject(1299,652.572,-197.704,11.465,0.0,0.0,0.0);
CreateDynamicObject(1299,617.239,-194.902,9.951,0.0,0.0,0.0);
CreateDynamicObject(1299,473.859,-265.354,10.307,0.0,0.0,0.0);
CreateDynamicObject(1299,-100.487,-154.418,2.564,0.0,0.0,0.0);
CreateDynamicObject(1299,-60.144,52.752,5.932,0.0,0.0,0.0);
CreateDynamicObject(1299,-57.347,54.799,5.932,0.0,0.0,0.0);
CreateDynamicObject(1299,-61.522,56.203,6.181,0.0,0.0,0.0);
CreateDynamicObject(1299,1225.225,-115.941,38.971,0.0,0.0,0.0);
CreateDynamicObject(3263,1554.963,-97.737,19.374,0.0,0.0,-168.748);
CreateDynamicObject(3263,1556.813,-97.082,19.390,0.0,0.0,-168.748);
CreateDynamicObject(1309,1556.841,-98.357,22.348,0.0,0.0,-631.497);
CreateDynamicObject(1309,1331.535,-199.073,19.196,0.0,-341.093,-745.716);
CreateDynamicObject(1309,812.174,-112.994,24.280,0.0,0.0,-337.501);
CreateDynamicObject(1260,196.723,-320.382,5.195,0.0,0.0,-225.001);
CreateDynamicObject(4729,197.550,-319.669,10.359,0.0,0.0,-382.501);
CreateDynamicObject(4731,465.407,-294.392,16.715,0.0,0.0,-485.547);
CreateDynamicObject(4988,814.734,-120.438,37.471,0.0,0.0,-416.248);
CreateDynamicObject(7901,814.354,-120.524,31.406,0.0,0.0,-247.501);
CreateDynamicObject(7903,802.986,-107.847,35.592,0.0,0.0,-405.075);
CreateDynamicObject(1299,1245.876,-130.361,38.414,0.0,0.0,0.0);
CreateDynamicObject(1299,1251.572,-134.464,38.454,0.0,0.0,0.0);
CreateDynamicObject(1299,1251.261,-139.858,38.327,0.0,0.0,0.0);
CreateDynamicObject(1299,1236.442,-133.711,38.652,0.0,0.0,0.0);
CreateDynamicObject(1299,1220.840,-140.362,39.068,0.0,0.0,0.0);
CreateDynamicObject(1299,1246.106,-116.632,38.129,0.0,0.0,0.0);
CreateDynamicObject(1299,1312.339,-188.614,19.336,0.0,0.0,0.0);
CreateDynamicObject(1299,1342.018,-206.407,10.622,0.0,0.0,0.0);
CreateDynamicObject(1299,1359.166,-210.528,7.770,0.0,0.0,0.0);
CreateDynamicObject(1299,1292.101,-172.132,27.665,0.0,0.0,0.0);
CreateDynamicObject(1299,1285.149,-166.768,30.675,0.0,0.0,0.0);
CreateDynamicObject(1299,1283.135,-168.736,30.915,0.0,0.0,0.0);
CreateDynamicObject(1299,1507.653,-190.637,11.962,0.0,0.0,0.0);
CreateDynamicObject(1299,1538.016,-164.660,14.851,0.0,0.0,0.0);
CreateDynamicObject(1299,1546.502,-146.495,16.822,0.0,0.0,0.0);
CreateDynamicObject(7906,1334.933,-200.573,27.952,-341.953,-363.439,-303.748);
CreateDynamicObject(7906,1534.156,-131.024,19.898,-368.595,-363.439,-236.248);
CreateDynamicObject(7906,1566.080,-97.451,33.030,-334.218,-363.439,-180.000);
CreateDynamicObject(7906,1550.146,-96.365,34.237,-350.547,-363.439,-184.378);
CreateDynamicObject(7906,1531.719,-132.738,19.306,-368.595,-363.439,-393.748);
CreateDynamicObject(7304,1073.348,-47.881,30.957,0.0,0.0,-258.748);
CreateDynamicObject(1299,781.257,-134.684,28.947,0.0,-344.531,-326.483);
CreateDynamicObject(1299,744.448,-163.013,18.434,0.0,0.0,0.0);
CreateDynamicObject(1299,747.449,-146.893,18.660,0.0,0.0,0.0);
CreateDynamicObject(1299,748.319,-151.362,18.721,0.0,0.0,0.0);
CreateDynamicObject(1299,758.237,-152.503,18.429,0.0,0.0,0.0);
CreateDynamicObject(1299,752.988,-152.146,18.513,0.0,0.0,0.0);
CreateDynamicObject(1299,743.134,-160.408,18.562,0.0,0.0,0.0);
CreateDynamicObject(1299,725.265,-174.704,20.232,0.0,0.0,0.0);
CreateDynamicObject(3264,258.396,-379.642,7.855,0.0,0.0,-281.248);
CreateDynamicObject(3264,258.228,-375.031,7.752,0.0,0.0,-281.248);
CreateDynamicObject(3264,260.332,-369.854,7.789,0.0,0.0,-281.248);
CreateDynamicObject(3264,261.268,-365.466,8.162,0.0,0.0,-281.248);
CreateDynamicObject(3264,260.765,-372.152,7.795,0.0,0.0,-281.248);
CreateDynamicObject(3264,259.230,-372.805,7.741,0.0,0.0,-281.248);
CreateDynamicObject(3264,257.525,-375.446,7.751,0.0,0.0,-281.248);
CreateDynamicObject(3264,257.537,-377.233,7.793,0.0,0.0,-281.248);
CreateDynamicObject(3264,255.774,-380.941,7.859,0.0,0.0,-281.248);
CreateDynamicObject(1299,256.897,-365.635,8.280,0.0,0.0,0.0);
CreateDynamicObject(1299,257.303,-370.722,8.227,0.0,0.0,0.0);
CreateDynamicObject(1299,257.280,-367.039,8.222,0.0,0.0,0.0);
CreateDynamicObject(1299,257.428,-373.787,8.205,0.0,0.0,0.0);
CreateDynamicObject(1299,255.645,-375.730,8.202,0.0,0.0,0.0);
CreateDynamicObject(1299,254.736,-377.551,8.330,0.0,0.0,0.0);
CreateDynamicObject(1299,253.712,-379.670,8.318,0.0,0.0,0.0);
CreateDynamicObject(1299,253.015,-380.278,8.319,0.0,0.0,0.0);
CreateDynamicObject(13667,1446.091,-223.040,23.650,0.0,0.0,-315.001);
CreateDynamicObject(13562,1550.712,-1.244,33.106,0.0,0.0,0.0);
CreateDynamicObject(13562,1222.581,-128.747,58.266,-378.908,0.0,-396.097);
CreateDynamicObject(3374,1177.099,-70.860,33.133,0.0,0.0,0.0);
CreateDynamicObject(2780,1562.251,47.579,20.583,0.0,0.0,0.0);
CreateDynamicObject(2780,1559.398,15.025,19.194,0.0,0.0,0.0);
CreateDynamicObject(2780,1508.199,-178.270,13.762,0.0,0.0,0.0);
CreateDynamicObject(3057,1555.739,-80.992,20.154,0.0,0.0,0.0);
CreateDynamicObject(1413,202.014,-316.739,1.813,0.0,0.0,0.0);
CreateDynamicObject(1413,209.047,-316.537,1.930,0.0,0.0,0.0);
CreateDynamicObject(1413,214.932,-316.458,2.301,0.0,0.0,-371.248);
CreateDynamicObject(1413,217.874,-322.345,2.905,0.0,0.0,-438.748);
CreateDynamicObject(1413,220.033,-331.233,3.866,0.0,0.0,-427.501);
CreateDynamicObject(1413,223.008,-337.094,4.717,0.0,0.0,-427.501);
CreateDynamicObject(1413,225.928,-341.286,5.512,0.0,0.0,-416.248);
CreateDynamicObject(1413,188.360,-323.751,1.863,0.0,0.0,-348.748);
CreateDynamicObject(1413,183.246,-321.968,1.863,0.0,0.0,-382.501);
CreateDynamicObject(1413,119.551,-270.141,1.863,0.0,0.0,-393.748);
CreateDynamicObject(1413,128.074,-276.028,1.863,0.0,0.0,-393.748);
CreateDynamicObject(1413,134.365,-278.875,1.863,0.0,0.0,-393.748);
CreateDynamicObject(1413,139.086,-267.102,1.863,0.0,0.0,-393.748);
CreateDynamicObject(1413,131.106,-261.003,1.863,0.0,0.0,-393.748);
CreateDynamicObject(1413,123.898,-257.289,1.863,0.0,0.0,-382.501);
CreateDynamicObject(1413,117.579,-253.292,1.863,0.0,0.0,-348.748);
CreateDynamicObject(1413,43.939,-201.403,1.895,0.0,0.0,-382.501);
CreateDynamicObject(1413,52.195,-204.697,1.746,0.0,0.0,-382.501);
CreateDynamicObject(1413,61.259,-211.482,1.738,0.0,0.0,-405.001);
CreateDynamicObject(1413,68.445,-217.164,1.875,0.0,0.0,-405.001);
CreateDynamicObject(1413,73.768,-221.764,1.863,0.0,0.0,-405.001);
CreateDynamicObject(1413,-113.771,-79.296,3.402,0.0,0.0,-472.501);
CreateDynamicObject(1413,-109.184,-67.977,3.402,0.0,0.0,-472.501);
CreateDynamicObject(1413,-111.188,-70.428,3.402,0.0,0.0,-483.748);
CreateDynamicObject(1413,-105.423,-62.995,3.395,0.0,0.0,-483.748);
CreateDynamicObject(1413,-98.844,-66.193,3.402,0.0,0.0,-483.748);
CreateDynamicObject(1413,-100.855,-77.608,3.402,0.0,0.0,-461.248);
CreateDynamicObject(1413,-43.788,145.677,3.402,0.0,0.0,-303.748);
CreateDynamicObject(1413,-39.440,151.172,3.328,0.0,0.0,-303.748);
CreateDynamicObject(1413,-28.154,145.953,3.264,0.0,0.0,-303.748);
CreateDynamicObject(1413,-32.810,139.651,3.395,0.0,0.0,-303.748);
CreateDynamicObject(4239,-27.429,165.152,9.292,0.0,0.0,-488.045);
CreateDynamicObject(1696,-19.633,193.208,2.437,0.0,0.0,-393.748);
CreateDynamicObject(1696,-15.108,190.272,2.437,0.0,0.0,-393.748);
CreateDynamicObject(1696,-10.924,187.382,2.437,0.0,0.0,-393.748);
CreateDynamicObject(1696,-7.483,185.533,2.437,0.0,0.0,-393.748);
CreateDynamicObject(8040,20.033,241.259,-0.347,0.0,0.0,-483.748);
CreateDynamicObject(2035,1550.765,13.509,25.130,-252.571,0.0,-258.748);
CreateDynamicObject(3271,1538.796,-76.996,19.351,0.0,0.0,-405.001);
CreateDynamicObject(1683,1258.734,-170.066,47.409,-378.049,-307.575,-344.531);
CreateDynamicObject(3271,1355.087,-194.548,10.427,-367.736,0.0,-450.001);
CreateDynamicObject(3271,843.943,-87.177,27.215,-359.141,-388.362,-601.405);
CreateDynamicObject(1681,603.930,-192.085,19.171,-403.832,-363.439,0.0);
CreateDynamicObject(10757,244.311,-371.667,17.866,-910.797,-853.318,-458.217);
CreateDynamicObject(3575,208.149,-304.286,2.451,0.0,0.0,0.0);
CreateDynamicObject(3575,106.268,-268.225,3.270,0.0,0.0,-326.248);
CreateDynamicObject(3575,-32.197,-191.073,3.494,0.0,0.0,-337.501);
CreateDynamicObject(7025,-105.354,-170.398,4.788,0.0,0.0,0.0);
CreateDynamicObject(7025,479.181,-279.885,10.306,0.0,0.0,-292.501);
CreateDynamicObject(7317,-50.866,7.336,8.170,0.0,0.0,-382.501);
CreateDynamicObject(7317,-22.879,142.410,8.050,0.0,0.0,-450.001);
CreateDynamicObject(7317,-50.684,187.747,6.631,0.0,0.0,-294.374);
CreateDynamicObject(2780,1268.882,-173.890,34.787,0.0,0.0,0.0);
CreateDynamicObject(3426,339.298,-361.121,10.807,0.0,-372.892,-389.290);
CreateDynamicObject(3425,295.762,-389.073,18.125,0.0,0.0,-371.248);
CreateDynamicObject(16776,9.441,243.665,0.638,0.0,0.0,-393.748);
CreateDynamicObject(16776,-31.947,83.436,3.860,0.0,0.0,-371.248);
CreateDynamicObject(3402,790.958,-127.534,21.996,0.0,-346.250,-326.248);
CreateDynamicObject(1299,783.931,-130.641,27.982,0.0,-344.531,-326.483);
CreateDynamicObject(1299,784.050,-131.634,28.093,0.0,-344.531,-326.483);
CreateDynamicObject(1299,782.881,-133.532,28.593,0.0,-344.531,-326.483);
CreateDynamicObject(1299,782.568,-134.318,29.039,0.0,-344.531,-326.483);
CreateDynamicObject(1299,738.304,-167.393,19.041,0.0,0.0,0.0);
CreateDynamicObject(1299,599.972,-198.647,11.208,0.0,0.0,0.0);
CreateDynamicObject(1299,428.111,-308.827,6.289,0.0,0.0,0.0);
CreateDynamicObject(1299,421.409,-308.303,7.074,0.0,0.0,0.0);
CreateDynamicObject(1299,417.202,-296.122,7.262,0.0,0.0,0.0);
CreateDynamicObject(1299,417.315,-305.438,7.721,0.0,0.0,0.0);
CreateDynamicObject(1299,412.343,-302.859,8.343,0.0,0.0,0.0);
CreateDynamicObject(1299,403.406,-312.297,11.204,0.0,0.0,0.0);
CreateDynamicObject(1299,368.491,-323.523,12.795,0.0,0.0,0.0);
CreateDynamicObject(1299,308.023,-370.218,8.958,0.0,0.0,0.0);
CreateDynamicObject(1299,192.263,-317.048,1.028,0.0,0.0,0.0);
CreateDynamicObject(1282,1450.927,-220.762,8.985,0.0,0.0,-303.748);
CreateDynamicObject(3276,1452.493,-217.978,9.540,0.0,-354.844,-540.001);
CreateDynamicObject(3276,1343.118,-214.262,10.510,0.0,-370.314,-196.404);
CreateDynamicObject(3276,1330.753,-208.830,13.631,0.0,-370.314,-201.561);
CreateDynamicObject(3276,1309.127,-195.600,19.927,0.0,-376.330,-212.814);
CreateDynamicObject(3276,1291.996,-184.383,25.744,0.0,-377.190,-211.015);
CreateDynamicObject(3276,1163.801,-84.183,31.071,0.0,-337.655,-202.500);
CreateDynamicObject(3276,1144.388,-76.814,25.597,0.0,-349.688,-198.203);
CreateDynamicObject(3276,1118.924,-71.237,21.149,0.0,-349.688,-187.031);
CreateDynamicObject(3276,1058.053,-76.070,22.787,0.0,-363.439,-190.468);
CreateDynamicObject(3276,946.563,-108.999,19.721,0.0,-353.125,-190.468);
CreateDynamicObject(3276,890.594,-98.826,23.393,0.0,-366.017,-198.203);
CreateDynamicObject(3276,852.416,-106.377,25.921,0.0,-358.282,-162.107);
CreateDynamicObject(3276,744.763,-171.966,18.883,0.0,-366.017,-150.934);
CreateDynamicObject(3276,730.986,-180.780,20.520,0.0,-363.439,-147.497);
CreateDynamicObject(3276,718.454,-189.100,21.175,0.0,-361.720,-147.497);
CreateDynamicObject(3276,654.289,-206.204,13.100,0.0,-350.547,-176.087);
CreateDynamicObject(3276,634.103,-205.478,10.392,0.0,-347.969,-183.043);
CreateDynamicObject(3276,618.323,-204.345,9.213,0.0,-362.579,-181.244);
CreateDynamicObject(3276,603.819,-204.894,10.050,0.0,-361.720,-175.228);
CreateDynamicObject(3276,585.429,-207.352,11.617,0.0,-365.157,-175.228);
CreateDynamicObject(3276,533.433,-217.018,15.454,0.0,-357.423,-146.866);
CreateDynamicObject(3276,496.172,-231.160,12.081,0.0,-353.125,-117.645);
CreateDynamicObject(3276,512.756,-233.657,13.679,0.0,-351.406,-140.145);
CreateDynamicObject(3276,438.482,-290.792,6.692,0.0,-355.704,-162.646);
CreateDynamicObject(3276,418.828,-293.962,7.285,0.0,-347.969,-342.646);
CreateDynamicObject(3276,361.178,-321.719,12.318,-371.174,-361.720,-330.614);
CreateDynamicObject(3276,380.601,-308.475,12.027,-371.174,0.0,-330.614);
CreateDynamicObject(3572,-68.087,29.438,2.490,0.0,-391.800,-292.501);
CreateDynamicObject(3565,-68.369,29.150,12.906,-359.141,-141.704,-292.501);
CreateDynamicObject(3565,-68.388,29.159,12.921,-360.860,-397.816,-472.501);
CreateDynamicObject(1384,-113.588,46.544,39.129,0.0,0.0,-472.501);
CreateDynamicObject(1387,-69.086,26.871,17.240,0.0,0.0,-292.501);
CreateDynamicObject(1278,-68.666,27.026,28.508,0.0,-177.800,-329.061);
CreateDynamicObject(1383,-113.569,46.512,6.997,0.0,0.0,-112.500);
CreateDynamicObject(8040,2520.975,-2689.513,4756.596,0.0,0.0,-270.001);
CreateDynamicObject(8171,2519.842,-2581.964,4750.595,-363.439,0.0,0.0);
CreateDynamicObject(8171,2519.621,-2457.574,4709.534,-391.800,0.0,0.0);
CreateDynamicObject(8171,2505.919,-2400.507,4675.084,-391.800,-341.953,-371.248);
CreateDynamicObject(8171,2538.365,-2396.041,4686.118,-389.222,-393.519,-345.310);
CreateDynamicObject(8171,2516.498,-2373.346,4665.680,-383.206,-359.141,0.0);
CreateDynamicObject(8171,2516.301,-2268.185,4584.356,-410.708,-359.141,0.0);
CreateDynamicObject(8171,2516.649,-2222.423,4483.790,-427.037,-359.141,0.0);
CreateDynamicObject(8171,2535.802,-2146.636,4381.162,-398.676,-379.768,0.0);
CreateDynamicObject(8171,2515.749,-2146.364,4381.375,-398.676,-352.266,0.0);
CreateDynamicObject(8171,2496.146,-2145.195,4384.157,-398.676,-341.953,0.0);
CreateDynamicObject(8171,2515.173,-2048.328,4293.626,-403.832,-352.266,0.0);
CreateDynamicObject(8171,2533.819,-2048.134,4292.285,-398.676,-395.238,-352.266);
CreateDynamicObject(8171,2540.239,-2092.902,4337.297,-398.676,-389.222,-352.266);
CreateDynamicObject(8171,2529.634,-2014.875,4277.628,-396.097,-387.503,-349.688);
CreateDynamicObject(8171,2497.252,-2046.352,4307.025,-396.097,-335.077,-366.876);
CreateDynamicObject(8171,2517.176,-2038.241,4301.357,-383.206,-353.125,-359.141);
CreateDynamicObject(8171,2490.792,-2266.177,4587.543,-410.708,-335.937,0.0);
CreateDynamicObject(8171,2536.691,-2270.704,4585.241,-410.708,-384.065,0.0);
CreateDynamicObject(8171,2512.977,-1929.645,4223.047,-405.551,-357.423,-355.704);
CreateDynamicObject(8171,2497.601,-1933.397,4228.225,-405.551,-338.515,-366.951);
CreateDynamicObject(8171,2540.924,-1923.950,4220.697,-405.551,-383.206,-355.704);
CreateDynamicObject(8171,2537.325,-1879.715,4177.543,-396.957,-356.563,-328.981);
CreateDynamicObject(8171,2506.956,-1859.423,4166.728,-396.957,-356.563,-367.656);
CreateDynamicObject(8171,2526.059,-1885.768,4183.427,-396.957,-359.141,-367.656);
CreateDynamicObject(8171,2553.268,-2227.226,4502.261,-427.037,-365.157,-353.125);
CreateDynamicObject(8171,2545.786,-2194.556,4429.566,-422.740,-361.720,-341.872);
CreateDynamicObject(8171,2483.268,-2209.109,4478.057,-422.740,-335.937,-365.312);
CreateDynamicObject(8171,2495.498,-2181.921,4416.123,-421.021,-336.796,-365.312);
CreateDynamicObject(8171,2492.670,-2023.217,4303.620,-381.487,-330.780,-365.232);
CreateDynamicObject(8171,2535.668,-2012.456,4288.594,-381.487,-376.330,-365.232);
CreateDynamicObject(8171,2499.718,-1768.674,4099.874,-395.238,-339.374,-356.563);
CreateDynamicObject(8171,2526.546,-1820.594,4133.544,-396.957,-353.125,-356.563);
CreateDynamicObject(8171,2523.541,-1721.174,4059.994,-395.238,-352.266,-356.563);
CreateDynamicObject(8171,2559.793,-2155.797,4405.294,-398.676,-401.254,0.0);
CreateDynamicObject(8171,2475.962,-2168.907,4415.130,-398.676,-327.342,0.0);
CreateDynamicObject(8171,2564.345,-2101.374,4364.548,-398.676,-400.394,-337.501);
CreateDynamicObject(8171,2478.699,-2096.572,4375.358,-398.676,-293.824,-371.248);
CreateDynamicObject(8171,2541.058,-2360.234,4666.614,-391.800,-402.973,-348.748);
CreateDynamicObject(8171,2535.202,-2330.842,4650.015,-391.800,-384.065,-344.451);
CreateDynamicObject(8171,2550.047,-2460.335,4712.492,-391.800,-411.567,-366.951);
CreateDynamicObject(8171,2541.184,-2459.304,4711.168,-389.222,-391.800,-346.170);
CreateDynamicObject(8171,2555.376,-2453.769,4721.352,-389.222,-396.097,-346.170);
CreateDynamicObject(8171,2485.550,-2466.636,4720.637,-391.800,-334.218,-369.529);
CreateDynamicObject(8171,2500.455,-2456.606,4711.113,-391.800,-355.704,-369.529);
CreateDynamicObject(8171,2476.298,-2409.114,4700.641,-391.800,-320.467,-369.529);
CreateDynamicObject(8171,2486.088,-2343.445,4660.632,-391.800,-320.467,-369.529);
CreateDynamicObject(8171,2495.938,-2351.834,4657.646,-389.222,-334.218,-369.529);
CreateDynamicObject(8171,2582.685,-2141.800,4419.006,-410.708,-418.443,0.0);
CreateDynamicObject(8171,2572.335,-2199.116,4458.480,-410.708,-399.535,0.0);
CreateDynamicObject(8171,2585.785,-2197.192,4487.414,-411.567,-418.443,0.0);
CreateDynamicObject(8171,2572.030,-2086.090,4370.198,-408.989,-419.302,-335.077);
CreateDynamicObject(8171,2573.160,-2107.454,4394.963,-400.394,-397.816,-346.250);
CreateDynamicObject(8171,2581.219,-2156.195,4417.420,-389.222,-396.097,-362.734);
CreateDynamicObject(8171,2551.051,-2118.565,4375.436,-400.394,-397.816,-346.250);
CreateDynamicObject(8171,2465.322,-2249.705,4595.112,-410.708,-317.029,0.0);
CreateDynamicObject(8171,2465.929,-2224.705,4567.947,-410.708,-317.029,-382.501);
CreateDynamicObject(8171,2454.638,-2235.418,4604.104,-410.708,-298.121,-372.188);
CreateDynamicObject(8171,2479.712,-2001.046,4307.676,-381.487,-312.732,-376.485);
CreateDynamicObject(8171,2550.678,-1990.701,4286.169,-330.780,-327.342,-173.280);
CreateDynamicObject(8171,2559.894,-1973.915,4291.319,-330.780,-302.419,-173.280);
CreateDynamicObject(8171,2556.476,-1897.905,4216.306,-330.780,-292.965,-180.155);
CreateDynamicObject(8171,2546.727,-1834.469,4159.842,-330.780,-313.591,-180.155);
CreateDynamicObject(8171,2557.000,-1825.021,4175.277,-329.921,-292.965,-174.139);
CreateDynamicObject(8171,2475.379,-2039.074,4329.419,-381.487,-298.121,-366.172);
CreateDynamicObject(8171,2536.364,-2070.935,4329.530,-400.394,-397.816,-346.250);
CreateDynamicObject(8171,2551.798,-2044.869,4332.313,-400.394,-397.816,-346.250);
CreateDynamicObject(8171,2592.115,-2154.990,4462.885,-410.708,-449.382,0.0);
CreateDynamicObject(8171,2471.157,-2186.499,4466.220,-422.740,-308.435,-365.312);
CreateDynamicObject(8171,2462.035,-2174.426,4480.095,-422.740,-298.981,-365.312);
CreateDynamicObject(8171,2471.661,-2089.613,4402.262,-398.676,-282.652,-371.248);
CreateDynamicObject(8171,2457.834,-2164.445,4488.047,-414.145,-263.744,-366.246);
CreateDynamicObject(8171,2463.286,-2145.398,4454.397,-414.145,-271.479,-361.089);
CreateDynamicObject(8171,2460.075,-2181.361,4544.450,-414.145,-250.852,-361.089);
CreateDynamicObject(8171,2464.045,-2155.188,4527.419,-414.145,-250.852,-383.590);
CreateDynamicObject(8171,2563.716,-1901.860,4245.240,-330.780,-280.933,-180.155);
CreateDynamicObject(8171,2563.898,-1827.850,4208.522,-330.780,-274.917,-180.155);
CreateDynamicObject(8171,2565.264,-1814.349,4226.075,-330.780,-272.338,-180.155);
CreateDynamicObject(8171,2561.314,-1795.759,4255.932,-330.780,-254.290,-180.155);
CreateDynamicObject(8171,2489.109,-1886.371,4198.317,-330.780,-402.113,-180.230);
CreateDynamicObject(8171,2470.688,-1873.233,4214.112,-330.780,-412.426,-180.230);
CreateDynamicObject(8171,2460.363,-1848.542,4218.634,-330.780,-420.161,-180.230);
CreateDynamicObject(8171,2449.900,-1859.240,4256.240,-331.639,-437.350,-180.230);
CreateDynamicObject(8171,2466.350,-1800.393,4180.946,-330.780,-420.161,-180.230);
CreateDynamicObject(8171,2484.763,-1827.052,4170.364,-330.780,-403.832,-180.230);
CreateDynamicObject(8171,2501.124,-1810.214,4143.688,-330.780,-402.113,-180.230);
CreateDynamicObject(8171,2493.570,-1715.949,4071.676,-395.238,-317.888,-356.563);
CreateDynamicObject(8171,2474.870,-1721.609,4101.128,-395.238,-305.856,-356.563);
CreateDynamicObject(8171,2544.960,-1735.229,4078.730,-395.238,-381.487,-356.563);
CreateDynamicObject(8171,2573.752,-1717.655,4090.450,-395.238,-404.692,-356.563);
CreateDynamicObject(8171,2546.508,-1668.632,4033.297,-395.238,-387.503,-356.563);
CreateDynamicObject(8171,2511.610,-1645.160,4006.376,-395.238,-350.547,-356.563);
CreateDynamicObject(8171,2485.335,-1618.655,4004.067,-395.238,-311.872,-356.563);
CreateDynamicObject(8171,2481.166,-1541.395,3956.536,-405.551,-313.591,-370.469);
CreateDynamicObject(8171,2569.848,-1628.129,4028.887,-395.238,-404.692,-356.563);
CreateDynamicObject(8171,2543.675,-1619.299,3998.082,-395.238,-388.362,-356.563);
CreateDynamicObject(8171,2561.017,-1575.720,3985.639,-395.238,-388.362,-345.310);
CreateDynamicObject(8171,2514.708,-1551.388,3937.854,-395.238,-350.547,-356.563);
CreateDynamicObject(8171,2492.123,-1571.189,3962.676,-395.238,-329.061,-356.563);
CreateDynamicObject(8171,2500.083,-1632.713,4002.883,-392.659,-329.921,-356.563);
CreateDynamicObject(8171,2528.840,-1558.305,3943.617,-392.659,-402.973,-356.563);
CreateDynamicObject(8171,2541.919,-1564.089,3964.786,-395.238,-388.362,-345.310);
CreateDynamicObject(8171,2521.090,-1561.704,3946.804,-395.238,-386.643,-345.310);
CreateDynamicObject(8171,2515.845,-1454.992,3860.408,-400.394,-350.547,-356.563);
CreateDynamicObject(8171,2489.469,-1443.381,3857.636,-400.394,-334.218,-356.563);
CreateDynamicObject(8171,2528.097,-1465.724,3868.911,-400.394,-364.298,-345.310);
CreateDynamicObject(8171,2520.622,-1404.124,3817.125,-400.394,-360.860,-322.810);
CreateDynamicObject(8171,2475.596,-1393.350,3822.649,-400.394,-360.860,-401.563);
CreateDynamicObject(8171,2502.623,-1400.090,3815.958,-398.676,-347.109,-355.858);
CreateDynamicObject(8171,2473.346,-1651.401,4047.292,-395.238,-298.121,0.0);
CreateDynamicObject(8171,2464.867,-1631.519,4052.674,-395.238,-274.917,-366.017);
CreateDynamicObject(8171,2478.490,-1464.695,3890.751,-395.238,-294.684,-354.844);
CreateDynamicObject(8171,2469.812,-1441.497,3896.571,-395.238,-280.073,-354.844);
CreateDynamicObject(8171,2556.367,-1518.767,3953.237,-395.238,-395.238,-345.310);
CreateDynamicObject(8171,2542.138,-1466.188,3915.085,-395.238,-398.676,-345.310);
CreateDynamicObject(8171,2478.992,-1590.300,4002.417,-405.551,-307.575,-382.501);
CreateDynamicObject(1225,2521.004,-1948.202,4265.678,0.0,0.0,0.0);
CreateDynamicObject(1225,2527.829,-1948.526,4264.184,0.0,0.0,0.0);
CreateDynamicObject(1225,2536.280,-1948.952,4262.453,0.0,0.0,0.0);
CreateDynamicObject(1225,2560.199,-1941.683,4281.192,0.0,0.0,0.0);
CreateDynamicObject(1225,2539.541,-1949.006,4263.381,0.0,0.0,0.0);
CreateDynamicObject(1225,2522.661,-1948.060,4265.350,0.0,0.0,0.0);
CreateDynamicObject(1225,2507.188,-1947.808,4271.913,0.0,0.0,0.0);
CreateDynamicObject(1225,2540.732,-1950.091,4264.168,0.0,0.0,0.0);
CreateDynamicObject(1225,2510.439,-1947.336,4268.638,0.0,0.0,0.0);
CreateDynamicObject(1225,2549.314,-1948.013,4265.447,0.0,0.0,0.0);
CreateDynamicObject(1225,2508.283,-1949.507,4270.649,0.0,0.0,0.0);
CreateDynamicObject(1225,2507.912,-1950.733,4271.162,0.0,0.0,0.0);
CreateDynamicObject(1225,2509.192,-1950.128,4270.087,0.0,0.0,0.0);
CreateDynamicObject(1225,2547.286,-1949.232,4265.626,0.0,0.0,0.0);
CreateDynamicObject(1225,2512.940,-1948.834,4268.044,0.0,0.0,0.0);
CreateDynamicObject(1225,2517.007,-1951.563,4267.567,0.0,0.0,0.0);
CreateDynamicObject(1225,2518.174,-1950.984,4266.916,0.0,0.0,0.0);
CreateDynamicObject(1225,2519.240,-1949.349,4265.999,0.0,0.0,0.0);
CreateDynamicObject(1225,2522.001,-1949.640,4266.187,0.0,0.0,0.0);
CreateDynamicObject(1225,2524.003,-1950.811,4265.846,0.0,0.0,0.0);
CreateDynamicObject(1225,2525.677,-1950.078,4265.200,0.0,0.0,0.0);
CreateDynamicObject(1225,2528.686,-1950.797,4264.658,0.0,0.0,0.0);
CreateDynamicObject(1225,2533.040,-1947.471,4262.545,0.0,0.0,0.0);
CreateDynamicObject(1225,2552.462,-1946.307,4268.413,0.0,0.0,0.0);
CreateDynamicObject(1225,2558.474,-1940.127,4277.451,0.0,0.0,0.0);
CreateDynamicObject(1225,2542.008,-1948.976,4264.053,0.0,0.0,0.0);
CreateDynamicObject(1225,2559.905,-1938.349,4279.498,0.0,0.0,0.0);
CreateDynamicObject(1225,2538.504,-1950.390,4263.676,0.0,0.0,0.0);
CreateDynamicObject(1225,2542.881,-1950.027,4264.738,0.0,0.0,0.0);
CreateDynamicObject(1225,2555.206,-1943.197,4272.440,0.0,0.0,0.0);
CreateDynamicObject(1225,2554.090,-1945.156,4271.042,0.0,0.0,0.0);
CreateDynamicObject(1225,2555.065,-1941.672,4271.651,0.0,0.0,0.0);
CreateDynamicObject(1225,2531.039,-1950.101,4263.851,0.0,0.0,0.0);
CreateDynamicObject(1225,2531.307,-1947.712,4263.057,0.0,0.0,0.0);
CreateDynamicObject(1225,2550.849,-1946.405,4265.911,0.0,0.0,0.0);
CreateDynamicObject(1225,2552.875,-1944.254,4268.474,0.0,0.0,0.0);
CreateDynamicObject(1225,2545.151,-1949.651,4265.210,0.0,0.0,0.0);
CreateDynamicObject(1225,2537.028,-1951.016,4263.529,0.0,0.0,0.0);
CreateDynamicObject(1225,2511.182,-1949.687,4268.748,0.0,0.0,0.0);
CreateDynamicObject(1225,2515.430,-1949.037,4267.476,0.0,0.0,0.0);
CreateDynamicObject(1225,2551.111,-1947.875,4266.810,0.0,0.0,0.0);
CreateDynamicObject(1225,2557.793,-1942.429,4276.979,0.0,0.0,0.0);
CreateDynamicObject(1225,2561.029,-1938.856,4281.759,0.0,0.0,0.0);
CreateDynamicObject(1225,2563.331,-1938.141,4285.788,0.0,0.0,0.0);
CreateDynamicObject(1225,2556.655,-1941.426,4274.521,0.0,0.0,0.0);
CreateDynamicObject(1225,2534.471,-1949.155,4262.695,0.0,0.0,0.0);
CreateDynamicObject(1225,2519.810,-1950.649,4266.447,0.0,0.0,0.0);
CreateDynamicObject(1225,2511.750,-1946.430,4267.817,0.0,0.0,0.0);
CreateDynamicObject(1225,2506.916,-1946.615,4272.307,0.0,0.0,0.0);
CreateDynamicObject(1225,2503.381,-1946.499,4276.522,0.0,0.0,0.0);
CreateDynamicObject(1225,2500.947,-1944.595,4279.419,0.0,0.0,0.0);
CreateDynamicObject(1225,2500.063,-1943.656,4280.460,0.0,0.0,0.0);
CreateDynamicObject(1225,2496.201,-1941.397,4285.092,0.0,0.0,0.0);
CreateDynamicObject(1225,2488.976,-1935.183,4293.665,0.0,0.0,0.0);
CreateDynamicObject(1225,2488.202,-1934.695,4294.591,0.0,0.0,0.0);
CreateDynamicObject(1225,2494.094,-1938.766,4287.554,0.0,0.0,0.0);
CreateDynamicObject(1225,2496.381,-1940.188,4285.487,0.0,0.0,0.0);
CreateDynamicObject(1225,2497.772,-1941.531,4283.170,0.0,0.0,0.0);
CreateDynamicObject(1225,2502.221,-1945.988,4277.921,0.0,0.0,0.0);
CreateDynamicObject(1225,2506.321,-1948.242,4272.997,0.0,0.0,0.0);
CreateDynamicObject(1225,2505.116,-1947.579,4274.444,0.0,0.0,0.0);
CreateDynamicObject(1225,2506.423,-1950.276,4272.563,0.0,0.0,0.0);
CreateDynamicObject(1225,2506.423,-1950.276,4272.563,0.0,0.0,0.0);
CreateDynamicObject(1225,2504.759,-1949.714,4274.578,0.0,0.0,0.0);
CreateDynamicObject(1225,2502.349,-1947.724,4277.441,0.0,0.0,0.0);
CreateDynamicObject(1225,2498.422,-1943.152,4282.044,0.0,0.0,0.0);
CreateDynamicObject(1225,2494.309,-1941.473,4287.012,0.0,0.0,0.0);
CreateDynamicObject(1225,2490.841,-1938.449,4291.125,0.0,0.0,0.0);
CreateDynamicObject(1225,2489.682,-1937.392,4292.498,0.0,0.0,0.0);
CreateDynamicObject(1225,2487.937,-1934.735,4294.513,0.0,0.0,0.0);
CreateDynamicObject(1225,2487.671,-1934.360,4294.821,0.0,0.0,0.0);
CreateDynamicObject(1225,2492.686,-1937.522,4288.816,0.0,0.0,0.0);
CreateDynamicObject(1225,2515.744,-1951.098,4267.488,0.0,0.0,0.0);
CreateDynamicObject(1225,2522.350,-1857.522,4162.877,0.0,0.0,0.0);
CreateDynamicObject(8171,2512.504,-1978.334,4276.718,-378.049,-347.969,-365.232);
CreateDynamicObject(8171,2467.344,-1378.873,3818.756,-418.443,-286.949,-359.141);
CreateDynamicObject(8171,2531.711,-1394.794,3822.749,-327.342,-306.716,-164.909);
CreateDynamicObject(8171,2462.200,-1367.268,3834.611,-418.443,-281.792,-359.141);
CreateDynamicObject(8171,2542.401,-1387.342,3842.440,-327.342,-298.981,-164.909);
CreateDynamicObject(8171,2523.769,-1335.849,3797.731,-327.342,-300.700,-164.909);
CreateDynamicObject(8171,2529.167,-1319.483,3807.604,-327.342,-296.403,-164.909);
CreateDynamicObject(8171,2457.747,-1304.860,3784.600,-418.443,-274.917,-359.141);
CreateDynamicObject(8171,2460.160,-1359.238,3867.306,-418.443,-268.041,-359.141);
CreateDynamicObject(8171,2465.348,-1422.129,3903.291,-395.238,-276.635,-354.844);
CreateDynamicObject(8171,2534.470,-1294.350,3835.030,-327.342,-279.214,-164.909);
CreateDynamicObject(8171,2548.441,-1358.194,3865.182,-327.342,-282.652,-164.909);
CreateDynamicObject(8171,2480.351,-1358.259,3796.975,-376.330,-328.202,-345.310);
CreateDynamicObject(8171,2513.139,-1351.142,3783.206,-376.330,-347.969,-345.310);
CreateDynamicObject(8171,2491.026,-1292.198,3761.227,-378.049,-341.953,-345.310);
CreateDynamicObject(8171,2509.690,-1271.213,3759.553,-378.049,-374.611,-345.310);
CreateDynamicObject(8171,2471.914,-1284.620,3763.542,-378.049,-322.186,-345.310);
CreateDynamicObject(8171,2530.946,-1223.745,3760.941,-378.049,-391.800,-345.310);
CreateDynamicObject(8171,2438.024,-1243.141,3770.200,-378.049,-307.575,-345.310);
CreateDynamicObject(8171,2551.290,-1467.603,3884.850,-396.097,-396.097,-345.310);
CreateDynamicObject(8171,2528.567,-1509.167,3926.309,-390.081,-378.908,-345.310);
CreateDynamicObject(8171,2505.192,-1518.109,3923.381,-387.503,-352.266,-345.310);
CreateDynamicObject(8171,2489.859,-1156.190,3683.201,-397.816,-374.611,-345.310);
CreateDynamicObject(8171,2506.947,-1141.561,3700.477,-397.816,-400.394,-345.310);
CreateDynamicObject(8171,2513.305,-1098.378,3698.934,-397.816,-422.740,-345.310);
CreateDynamicObject(8171,2459.361,-1172.899,3686.329,-397.816,-354.844,-345.310);
CreateDynamicObject(8171,2493.137,-1169.877,3698.775,-397.816,-392.659,-345.310);
CreateDynamicObject(8171,2435.311,-1176.570,3689.120,-397.816,-342.812,-345.310);
CreateDynamicObject(8171,2411.638,-1183.385,3701.786,-397.816,-329.921,-345.310);
CreateDynamicObject(8171,2385.258,-1174.653,3710.711,-397.816,-317.888,-345.310);
CreateDynamicObject(8171,2364.910,-1167.826,3726.125,-397.816,-306.716,-345.310);
CreateDynamicObject(8171,2355.610,-1165.355,3744.702,-397.816,-274.057,-345.310);
CreateDynamicObject(8171,2443.656,-1101.819,3591.572,-412.426,-354.844,-345.310);
CreateDynamicObject(8171,2423.039,-1113.292,3607.117,-412.426,-347.969,-345.310);
CreateDynamicObject(8171,2461.657,-1096.357,3591.726,-412.426,-365.157,-345.310);
CreateDynamicObject(8171,2490.808,-1947.469,4281.686,-381.487,-319.607,-376.485);
CreateDynamicObject(8171,2542.504,-1944.649,4262.754,-373.752,-376.330,-365.232);
CreateDynamicObject(8171,2387.661,-1103.354,3601.286,-412.426,-330.780,-345.310);
CreateDynamicObject(8171,2369.832,-1090.706,3598.124,-412.426,-311.013,-367.810);
CreateDynamicObject(8171,2469.002,-1073.547,3569.208,-412.426,-378.908,-322.810);
CreateDynamicObject(8171,2510.168,-1070.711,3704.020,-397.816,-443.366,-345.310);
CreateDynamicObject(8171,2408.150,-1049.917,3490.935,-418.443,-354.844,-345.310);
CreateDynamicObject(8171,2430.400,-1062.601,3519.370,-418.443,-366.017,-345.310);
CreateDynamicObject(8171,2384.070,-1043.408,3490.619,-418.443,-329.061,-345.310);
CreateDynamicObject(8171,2412.111,-1082.875,3547.688,-418.443,-341.953,-345.310);
CreateDynamicObject(8171,2425.815,-995.777,3417.943,-418.443,-372.892,-345.310);
CreateDynamicObject(8171,2403.916,-1014.646,3434.990,-418.443,-354.844,-345.310);
CreateDynamicObject(8171,2368.046,-979.576,3382.404,-418.443,-329.061,-345.310);
CreateDynamicObject(8171,2353.462,-1020.261,3474.231,-418.443,-313.591,-345.310);
CreateDynamicObject(8171,2348.219,-1022.293,3498.607,-418.443,-306.716,-367.810);
CreateDynamicObject(8171,2441.185,-990.185,3429.917,-418.443,-402.973,-322.810);
CreateDynamicObject(8171,2394.289,-960.848,3330.499,-423.599,-354.844,-345.310);
CreateDynamicObject(1676,2486.638,-1231.349,3743.322,0.0,0.0,0.0);
CreateDynamicObject(1676,2490.767,-1647.089,4020.849,0.0,0.0,0.0);
CreateDynamicObject(1676,2508.132,-1634.251,4001.768,0.0,0.0,0.0);
CreateDynamicObject(1676,2520.374,-1637.624,4002.215,0.0,0.0,0.0);
CreateDynamicObject(1676,2535.869,-1634.390,4005.823,0.0,0.0,0.0);
CreateDynamicObject(1676,2541.122,-1633.650,4008.894,0.0,0.0,0.0);
CreateDynamicObject(1676,2553.516,-1644.066,4024.251,0.0,0.0,0.0);
CreateDynamicObject(1676,2547.695,-1660.007,4030.932,0.0,0.0,0.0);
CreateDynamicObject(1676,2533.527,-1670.219,4028.127,0.0,0.0,0.0);
CreateDynamicObject(1676,2535.766,-1679.997,4039.164,0.0,0.0,0.0);
CreateDynamicObject(1676,2565.646,-1666.970,4050.780,0.0,0.0,0.0);
CreateDynamicObject(1676,2563.182,-1639.059,4029.988,0.0,0.0,0.0);
CreateDynamicObject(1676,2552.902,-1617.019,4005.796,0.0,0.0,0.0);
CreateDynamicObject(1676,2537.385,-1588.430,3975.983,0.0,0.0,0.0);
CreateDynamicObject(1676,2528.869,-1542.445,3945.298,0.0,0.0,0.0);
CreateDynamicObject(1676,2538.547,-1558.773,3961.638,0.0,0.0,0.0);
CreateDynamicObject(1676,2550.787,-1537.315,3960.590,0.0,0.0,0.0);
CreateDynamicObject(1676,2524.092,-1529.975,3935.089,0.0,0.0,0.0);
CreateDynamicObject(1676,2503.899,-1534.787,3934.030,0.0,0.0,0.0);
CreateDynamicObject(1676,2534.841,-1566.049,3961.585,0.0,0.0,0.0);
CreateDynamicObject(1676,2524.120,-1572.799,3956.581,0.0,0.0,0.0);
CreateDynamicObject(1676,2510.855,-1518.328,3924.990,0.0,0.0,0.0);
CreateDynamicObject(1676,2509.535,-1555.649,3946.068,0.0,0.0,0.0);
CreateDynamicObject(1676,2509.354,-1558.380,3947.552,0.0,0.0,0.0);
CreateDynamicObject(1676,2503.502,-1563.713,3951.925,0.0,0.0,0.0);
CreateDynamicObject(1676,2495.926,-1563.705,3962.545,0.0,0.0,0.0);
CreateDynamicObject(1676,2490.626,-1548.076,3970.081,0.0,0.0,0.0);
CreateDynamicObject(1676,2491.952,-1538.628,3941.105,0.0,0.0,0.0);
CreateDynamicObject(1676,2504.521,-1547.770,3941.875,0.0,0.0,0.0);
CreateDynamicObject(1676,2519.813,-1551.974,3943.909,0.0,0.0,0.0);
CreateDynamicObject(1676,2525.092,-1550.306,3946.260,0.0,0.0,0.0);
CreateDynamicObject(1676,2534.756,-1554.110,3956.132,0.0,0.0,0.0);
CreateDynamicObject(1676,2541.791,-1549.860,3959.698,0.0,0.0,0.0);
CreateDynamicObject(1676,2552.045,-1551.112,3968.736,0.0,0.0,0.0);
CreateDynamicObject(1676,2536.704,-1546.151,3953.621,0.0,0.0,0.0);
CreateDynamicObject(1676,2530.415,-1452.288,3903.398,0.0,0.0,0.0);
CreateDynamicObject(1676,2537.805,-1945.432,4263.241,0.0,0.0,0.0);
CreateDynamicObject(1676,2516.012,-1525.045,3929.364,0.0,0.0,0.0);
CreateDynamicObject(1676,2513.663,-1539.609,3937.301,0.0,0.0,0.0);
CreateDynamicObject(1676,2511.142,-1549.995,3942.976,0.0,0.0,0.0);
CreateDynamicObject(1676,2511.532,-1564.474,3950.823,0.0,0.0,0.0);
CreateDynamicObject(1676,2514.377,-1574.641,3957.245,0.0,0.0,0.0);
CreateDynamicObject(1676,2503.374,-1473.931,3901.842,0.0,0.0,0.0);
CreateDynamicObject(1676,2505.787,-1475.907,3902.875,0.0,0.0,0.0);
CreateDynamicObject(1676,2512.506,-1474.595,3904.171,0.0,0.0,0.0);
CreateDynamicObject(1676,2518.385,-1470.321,3904.629,0.0,0.0,0.0);
CreateDynamicObject(1676,2528.297,-1470.629,3910.712,0.0,0.0,0.0);
CreateDynamicObject(1676,2539.659,-1473.772,3917.822,0.0,0.0,0.0);
CreateDynamicObject(1676,2533.469,-1482.410,3918.870,0.0,0.0,0.0);
CreateDynamicObject(1676,2522.915,-1473.642,3909.247,0.0,0.0,0.0);
CreateDynamicObject(1676,2485.823,-1479.495,3904.329,0.0,0.0,0.0);
CreateDynamicObject(1676,2501.555,-1482.367,3906.447,0.0,0.0,0.0);
CreateDynamicObject(1676,2477.972,-1482.871,3912.228,0.0,0.0,0.0);
CreateDynamicObject(1676,2474.974,-1470.280,3908.121,0.0,0.0,0.0);
CreateDynamicObject(1676,2493.621,-1474.579,3902.350,0.0,0.0,0.0);
CreateDynamicObject(1676,2503.843,-1492.866,3912.105,0.0,0.0,0.0);
CreateDynamicObject(1676,2520.231,-1507.874,3923.569,0.0,0.0,0.0);
CreateDynamicObject(1676,2553.785,-1500.041,3945.165,0.0,0.0,0.0);
CreateDynamicObject(1676,2559.434,-1497.628,3950.483,0.0,0.0,0.0);
CreateDynamicObject(1676,2542.517,-1487.722,3927.109,0.0,0.0,0.0);
CreateDynamicObject(1676,2543.153,-1498.245,3932.570,0.0,0.0,0.0);
CreateDynamicObject(1676,2547.821,-1504.561,3940.409,0.0,0.0,0.0);
CreateDynamicObject(1676,2553.714,-1517.282,3952.582,0.0,0.0,0.0);
CreateDynamicObject(1676,2476.792,-1249.107,3749.627,0.0,0.0,0.0);
CreateDynamicObject(1676,2458.165,-1243.311,3754.056,0.0,0.0,0.0);
CreateDynamicObject(1676,2442.680,-1238.330,3763.819,0.0,0.0,0.0);
CreateDynamicObject(1676,2467.873,-1261.339,3756.766,0.0,0.0,0.0);
CreateDynamicObject(1676,2481.996,-1263.898,3754.279,0.0,0.0,0.0);
CreateDynamicObject(1676,2486.645,-1259.490,3751.350,0.0,0.0,0.0);
CreateDynamicObject(1676,2496.451,-1257.778,3753.597,0.0,0.0,0.0);
CreateDynamicObject(1676,2513.176,-1252.983,3758.236,0.0,0.0,0.0);
CreateDynamicObject(1676,2512.914,-1280.055,3771.215,0.0,0.0,0.0);
CreateDynamicObject(1676,2498.639,-1280.118,3759.847,0.0,0.0,0.0);
CreateDynamicObject(1676,2510.583,-1284.761,3766.785,0.0,0.0,0.0);
CreateDynamicObject(1676,2524.478,-1239.198,3760.224,0.0,0.0,0.0);
CreateDynamicObject(1676,2507.148,-1235.829,3751.925,0.0,0.0,0.0);
CreateDynamicObject(1676,2528.335,-1250.706,3764.925,0.0,0.0,0.0);
CreateDynamicObject(1676,2468.400,-1280.071,3765.232,0.0,0.0,0.0);
CreateDynamicObject(1676,2525.175,-1259.009,3763.915,0.0,0.0,0.0);
CreateDynamicObject(1676,2512.514,-1264.796,3768.154,0.0,0.0,0.0);
CreateDynamicObject(1676,2514.669,-1271.295,3774.039,0.0,0.0,0.0);
CreateDynamicObject(1676,2519.514,-1275.121,3785.452,0.0,0.0,0.0);
CreateDynamicObject(1676,2445.811,-1250.823,3768.204,0.0,0.0,0.0);
CreateDynamicObject(1676,2451.669,-1256.413,3765.490,0.0,0.0,0.0);
CreateDynamicObject(1676,2459.761,-1262.350,3762.870,0.0,0.0,0.0);
CreateDynamicObject(1225,2498.601,-1337.141,3781.003,0.0,0.0,0.0);
CreateDynamicObject(1225,2496.026,-1336.078,3781.409,0.0,0.0,0.0);
CreateDynamicObject(1225,2490.038,-1333.794,3781.776,0.0,0.0,0.0);
CreateDynamicObject(1225,2486.440,-1352.509,3792.128,0.0,0.0,0.0);
CreateDynamicObject(1225,2504.889,-1350.265,3784.983,0.0,0.0,0.0);
CreateDynamicObject(1225,2509.545,-1346.294,3782.980,0.0,0.0,0.0);
CreateDynamicObject(1225,2515.183,-1333.852,3780.071,0.0,0.0,0.0);
CreateDynamicObject(1225,2515.652,-1314.530,3779.162,0.0,0.0,0.0);
CreateDynamicObject(1225,2509.109,-1320.276,3774.203,0.0,0.0,0.0);
CreateDynamicObject(1225,2496.565,-1330.567,3779.462,0.0,0.0,0.0);
CreateDynamicObject(1225,2490.594,-1320.333,3776.824,0.0,0.0,0.0);
CreateDynamicObject(1225,2486.213,-1342.400,3787.731,0.0,0.0,0.0);
CreateDynamicObject(1225,2479.898,-1342.359,3791.191,0.0,0.0,0.0);
CreateDynamicObject(1225,2477.008,-1341.970,3792.608,0.0,0.0,0.0);
CreateDynamicObject(1225,2479.661,-1352.753,3795.969,0.0,0.0,0.0);
CreateDynamicObject(1225,2462.064,-1346.694,3802.950,0.0,0.0,0.0);
CreateDynamicObject(1225,2461.194,-1341.829,3801.944,0.0,0.0,0.0);
CreateDynamicObject(1225,2473.247,-1342.169,3794.769,0.0,0.0,0.0);
CreateDynamicObject(1225,2468.440,-1331.017,3792.427,0.0,0.0,0.0);
CreateDynamicObject(1225,2468.962,-1327.125,3790.400,0.0,0.0,0.0);
CreateDynamicObject(1225,2482.991,-1329.845,3783.891,0.0,0.0,0.0);
CreateDynamicObject(1225,2442.867,-1171.501,3685.391,0.0,0.0,0.0);
CreateDynamicObject(1225,2435.781,-1171.119,3686.082,0.0,0.0,0.0);
CreateDynamicObject(1225,2434.228,-1162.498,3679.037,0.0,0.0,0.0);
CreateDynamicObject(1225,2450.213,-1162.186,3678.762,0.0,0.0,0.0);
CreateDynamicObject(1225,2458.448,-1158.426,3676.541,0.0,0.0,0.0);
CreateDynamicObject(1225,2467.880,-1152.140,3672.453,0.0,0.0,0.0);
CreateDynamicObject(1225,2468.205,-1143.020,3665.370,0.0,0.0,0.0);
CreateDynamicObject(1225,2457.637,-1137.734,3660.337,0.0,0.0,0.0);
CreateDynamicObject(1225,2445.561,-1140.906,3661.769,0.0,0.0,0.0);
CreateDynamicObject(1225,2444.512,-1152.808,3670.958,0.0,0.0,0.0);
CreateDynamicObject(1225,2437.895,-1155.221,3672.268,0.0,0.0,0.0);
CreateDynamicObject(1225,2430.302,-1151.361,3670.284,0.0,0.0,0.0);
CreateDynamicObject(1225,2422.744,-1147.312,3668.218,0.0,0.0,0.0);
CreateDynamicObject(1225,2411.656,-1148.034,3670.850,0.0,0.0,0.0);
CreateDynamicObject(1225,2401.993,-1149.263,3676.578,0.0,0.0,0.0);
CreateDynamicObject(1225,2476.234,-1130.631,3662.016,0.0,0.0,0.0);
CreateDynamicObject(1225,2484.852,-1130.343,3670.319,0.0,0.0,0.0);
CreateDynamicObject(1225,2498.083,-1125.120,3682.768,0.0,0.0,0.0);
CreateDynamicObject(1225,2490.428,-1147.009,3684.875,0.0,0.0,0.0);
CreateDynamicObject(1225,2477.127,-1148.257,3672.746,0.0,0.0,0.0);
CreateDynamicObject(1225,2468.746,-1177.765,3692.508,0.0,0.0,0.0);
CreateDynamicObject(1225,2418.363,-1082.044,3567.525,0.0,0.0,0.0);
CreateDynamicObject(1225,2433.456,-1075.068,3558.008,0.0,0.0,0.0);
CreateDynamicObject(1225,2451.825,-1075.225,3563.538,0.0,0.0,0.0);
CreateDynamicObject(1225,2449.525,-1104.007,3597.847,0.0,0.0,0.0);
CreateDynamicObject(1225,2412.552,-1099.295,3590.793,0.0,0.0,0.0);
CreateDynamicObject(1225,2399.124,-1077.166,3546.328,0.0,0.0,0.0);
CreateDynamicObject(1225,2390.879,-1047.174,3496.114,0.0,0.0,0.0);
CreateDynamicObject(1225,2386.192,-1038.850,3483.845,0.0,0.0,0.0);
CreateDynamicObject(1225,2418.206,-1046.346,3492.650,0.0,0.0,0.0);
CreateDynamicObject(1225,2417.507,-1052.841,3500.804,0.0,0.0,0.0);
CreateDynamicObject(1225,2404.151,-1055.959,3505.561,0.0,0.0,0.0);
CreateDynamicObject(1225,2400.344,-1052.930,3501.033,0.0,0.0,0.0);
CreateDynamicObject(1225,2407.487,-1052.796,3499.448,0.0,0.0,0.0);
CreateDynamicObject(1225,2412.982,-1060.153,3511.527,0.0,0.0,0.0);
CreateDynamicObject(1225,2417.833,-1063.591,3518.285,0.0,0.0,0.0);
CreateDynamicObject(1225,2427.392,-1076.138,3540.946,0.0,0.0,0.0);
CreateDynamicObject(1225,2435.380,-1062.305,3524.637,0.0,0.0,0.0);
CreateDynamicObject(1225,2426.893,-1044.473,3492.306,0.0,0.0,0.0);
CreateDynamicObject(1225,2421.604,-1035.178,3475.409,0.0,0.0,0.0);
CreateDynamicObject(1225,2428.715,-1012.328,3447.200,0.0,0.0,0.0);
CreateDynamicObject(1225,2418.840,-1008.777,3433.747,0.0,0.0,0.0);
CreateDynamicObject(1225,2412.238,-1013.109,3437.383,0.0,0.0,0.0);
CreateDynamicObject(1225,2394.253,-1001.825,3414.694,0.0,0.0,0.0);
CreateDynamicObject(1225,2387.726,-999.199,3408.838,0.0,0.0,0.0);
CreateDynamicObject(1225,2374.213,-1009.417,3437.269,0.0,0.0,0.0);
CreateDynamicObject(1225,2367.003,-1020.741,3463.403,0.0,0.0,0.0);
CreateDynamicObject(1225,2360.515,-1023.221,3473.149,0.0,0.0,0.0);
CreateDynamicObject(1225,2354.725,-1025.575,3487.107,0.0,0.0,0.0);
CreateDynamicObject(1225,2346.544,-1012.900,3493.653,0.0,0.0,0.0);
CreateDynamicObject(1225,2349.187,-1006.686,3478.500,0.0,0.0,0.0);
CreateDynamicObject(1225,2354.484,-1007.590,3465.027,0.0,0.0,0.0);
CreateDynamicObject(1225,2390.086,-1001.402,3412.984,0.0,0.0,0.0);
CreateDynamicObject(1225,2409.606,-1025.504,3456.799,0.0,0.0,0.0);
CreateDynamicObject(1225,2411.903,-1025.808,3457.857,0.0,0.0,0.0);
CreateDynamicObject(1225,2413.030,-1026.229,3458.814,0.0,0.0,0.0);
CreateDynamicObject(1225,2414.223,-1028.015,3462.000,0.0,0.0,0.0);
CreateDynamicObject(1225,2399.436,-1043.100,3482.778,0.0,0.0,0.0);
CreateDynamicObject(1225,2396.500,-1045.747,3489.544,0.0,0.0,0.0);
CreateDynamicObject(1225,2404.275,-1046.130,3488.873,0.0,0.0,0.0);
CreateDynamicObject(1225,2407.387,-1047.073,3491.165,0.0,0.0,0.0);
CreateDynamicObject(1225,2409.160,-1047.301,3491.971,0.0,0.0,0.0);
CreateDynamicObject(1225,2424.710,-1040.476,3484.889,0.0,0.0,0.0);
CreateDynamicObject(1225,2438.839,-1029.318,3476.470,0.0,0.0,0.0);
CreateDynamicObject(1225,2447.299,-1020.765,3475.085,0.0,0.0,0.0);
CreateDynamicObject(1225,2444.322,-1008.884,3455.203,0.0,0.0,0.0);
CreateDynamicObject(1225,2432.464,-1000.954,3433.681,0.0,0.0,0.0);
CreateDynamicObject(1225,2418.328,-989.441,3405.011,0.0,0.0,0.0);
CreateDynamicObject(1225,2413.906,-991.162,3403.835,0.0,0.0,0.0);
CreateDynamicObject(1225,2392.129,-996.325,3405.269,0.0,0.0,0.0);
CreateDynamicObject(1225,2380.313,-998.920,3413.164,0.0,0.0,0.0);
CreateDynamicObject(1225,2380.273,-999.629,3414.514,0.0,0.0,0.0);
CreateDynamicObject(1225,2380.134,-1001.363,3417.845,0.0,0.0,0.0);
CreateDynamicObject(1225,2374.225,-999.353,3418.203,0.0,0.0,0.0);
CreateDynamicObject(1225,2369.007,-990.616,3405.533,0.0,0.0,0.0);
CreateDynamicObject(1225,2370.807,-986.863,3397.282,0.0,0.0,0.0);
CreateDynamicObject(1225,2373.563,-983.249,3388.625,0.0,0.0,0.0);
CreateDynamicObject(1225,2384.484,-957.055,3323.237,0.0,0.0,0.0);
CreateDynamicObject(1225,2397.772,-957.262,3327.827,0.0,0.0,0.0);
CreateDynamicObject(1225,2406.065,-973.997,3372.151,0.0,0.0,0.0);
CreateDynamicObject(1225,2409.822,-980.980,3385.514,0.0,0.0,0.0);
CreateDynamicObject(1225,2396.270,-967.797,3348.426,0.0,0.0,0.0);
CreateDynamicObject(1225,2396.690,-969.344,3351.651,0.0,0.0,0.0);
CreateDynamicObject(1225,2391.619,-972.164,3355.697,0.0,0.0,0.0);
CreateDynamicObject(1225,2390.026,-966.849,3344.566,0.0,0.0,0.0);
CreateDynamicObject(1225,2402.749,-953.796,3322.462,0.0,0.0,0.0);
CreateDynamicObject(1225,2405.897,-954.826,3325.511,0.0,0.0,0.0);
CreateDynamicObject(1225,2409.854,-960.368,3337.839,0.0,0.0,0.0);
CreateDynamicObject(1225,2404.332,-962.818,3341.003,0.0,0.0,0.0);
CreateDynamicObject(1225,2397.873,-959.342,3332.019,0.0,0.0,0.0);
CreateDynamicObject(1225,2392.937,-956.601,3324.985,0.0,0.0,0.0);
CreateDynamicObject(1225,2388.331,-956.383,3323.102,0.0,0.0,0.0);
CreateDynamicObject(1225,2386.749,-960.432,3330.702,0.0,0.0,0.0);
CreateDynamicObject(1225,2387.693,-962.882,3335.899,0.0,0.0,0.0);
CreateDynamicObject(1225,2393.759,-963.139,3338.320,0.0,0.0,0.0);
CreateDynamicObject(1225,2395.797,-962.813,3338.309,0.0,0.0,0.0);
CreateDynamicObject(1225,2401.784,-959.443,3333.451,0.0,0.0,0.0);
CreateDynamicObject(1225,2403.625,-955.729,3326.603,0.0,0.0,0.0);
CreateDynamicObject(1225,2391.348,-949.682,3310.649,0.0,0.0,0.0);
CreateDynamicObject(1225,2384.253,-946.775,3302.604,0.0,0.0,0.0);
CreateDynamicObject(1225,2379.935,-945.210,3298.116,0.0,0.0,0.0);
CreateDynamicObject(1225,2399.990,-942.745,3299.492,0.0,0.0,0.0);
CreateDynamicObject(1225,2382.517,-938.160,3284.827,0.0,0.0,0.0);
CreateDynamicObject(1225,2391.542,-941.123,3293.592,0.0,0.0,0.0);
CreateDynamicObject(1225,2398.429,-944.270,3302.051,0.0,0.0,0.0);
CreateDynamicObject(1225,2399.051,-947.541,3308.788,0.0,0.0,0.0);
CreateDynamicObject(1225,2393.649,-954.349,3320.707,0.0,0.0,0.0);
CreateDynamicObject(1225,2407.401,-997.136,3410.338,0.0,0.0,0.0);
CreateDynamicObject(1225,2408.270,-999.895,3415.019,0.0,0.0,0.0);
CreateDynamicObject(1225,2405.376,-1003.561,3420.240,0.0,0.0,0.0);
CreateDynamicObject(1225,2402.757,-997.322,3409.498,0.0,0.0,0.0);
CreateDynamicObject(1225,2402.159,-979.123,3379.892,0.0,0.0,0.0);
CreateDynamicObject(1225,2397.407,-978.613,3377.898,0.0,0.0,0.0);
CreateDynamicObject(1225,2387.824,-987.099,3389.277,0.0,0.0,0.0);
CreateDynamicObject(1225,2381.704,-987.833,3391.517,0.0,0.0,0.0);
CreateDynamicObject(1225,2377.505,-979.934,3379.701,0.0,0.0,0.0);
CreateDynamicObject(1225,2363.985,-971.026,3372.483,0.0,0.0,0.0);
CreateDynamicObject(1225,2349.189,-969.954,3380.767,0.0,0.0,0.0);
CreateDynamicObject(1225,2351.821,-993.626,3424.767,0.0,0.0,0.0);
CreateDynamicObject(1225,2351.122,-991.910,3422.261,0.0,0.0,0.0);
CreateDynamicObject(1225,2350.093,-995.631,3431.587,0.0,0.0,0.0);
CreateDynamicObject(1225,2348.044,-1001.060,3446.034,0.0,0.0,0.0);
CreateDynamicObject(1225,2354.095,-989.705,3443.479,0.0,0.0,0.0);
CreateDynamicObject(1225,2353.104,-990.921,3447.752,0.0,0.0,0.0);
CreateDynamicObject(1225,2354.794,-1004.634,3460.431,0.0,0.0,0.0);
CreateDynamicObject(1225,2348.039,-1026.609,3506.865,0.0,0.0,0.0);
CreateDynamicObject(1225,2350.203,-1020.548,3493.227,0.0,0.0,0.0);
CreateDynamicObject(1225,2376.284,-1021.119,3457.657,0.0,0.0,0.0);
CreateDynamicObject(1225,2390.363,-1036.334,3476.252,0.0,0.0,0.0);
CreateDynamicObject(1225,2523.026,-1361.754,3801.605,0.0,0.0,0.0);
CreateDynamicObject(1225,2418.018,-1056.414,3506.713,0.0,0.0,0.0);
CreateDynamicObject(1225,2426.142,-1017.819,3453.089,0.0,0.0,0.0);
CreateDynamicObject(1225,2429.599,-1001.548,3432.157,0.0,0.0,0.0);
CreateDynamicObject(1225,2441.164,-1001.872,3442.298,0.0,0.0,0.0);
CreateDynamicObject(1225,2451.101,-1001.163,3456.902,0.0,0.0,0.0);
CreateDynamicObject(1225,2440.440,-975.807,3425.685,0.0,0.0,0.0);
CreateDynamicObject(1225,2425.937,-961.304,3387.636,0.0,0.0,0.0);
CreateDynamicObject(1225,2424.783,-957.747,3384.079,0.0,0.0,0.0);
CreateDynamicObject(1225,2422.753,-963.966,3380.578,0.0,0.0,0.0);
CreateDynamicObject(1225,2421.541,-966.970,3378.330,0.0,0.0,0.0);
CreateDynamicObject(1225,2424.001,-970.722,3385.070,0.0,0.0,0.0);
CreateDynamicObject(1225,2424.499,-988.120,3408.235,0.0,0.0,0.0);
CreateDynamicObject(1225,2419.890,-995.724,3415.515,0.0,0.0,0.0);
CreateDynamicObject(1225,2420.618,-996.810,3417.714,0.0,0.0,0.0);
CreateDynamicObject(1225,2430.636,-998.884,3429.124,0.0,0.0,0.0);
CreateDynamicObject(1225,2430.798,-995.174,3423.826,0.0,0.0,0.0);
CreateDynamicObject(1225,2429.472,-993.345,3420.041,0.0,0.0,0.0);
CreateDynamicObject(1225,2408.886,-1011.294,3433.622,0.0,0.0,0.0);
CreateDynamicObject(1225,2406.772,-1010.314,3431.515,0.0,0.0,0.0);
CreateDynamicObject(1225,2401.890,-1012.379,3433.656,0.0,0.0,0.0);
CreateDynamicObject(1225,2388.865,-1023.251,3452.889,0.0,0.0,0.0);
CreateDynamicObject(1225,2387.731,-1029.509,3465.351,0.0,0.0,0.0);
CreateDynamicObject(1225,2378.085,-1027.327,3467.985,0.0,0.0,0.0);
CreateDynamicObject(1225,2380.698,-1016.706,3446.357,0.0,0.0,0.0);
CreateDynamicObject(1225,2376.943,-1009.323,3435.195,0.0,0.0,0.0);
CreateDynamicObject(1225,2367.211,-1009.752,3442.761,0.0,0.0,0.0);
CreateDynamicObject(1225,2363.395,-1011.990,3449.587,0.0,0.0,0.0);
CreateDynamicObject(1225,2359.596,-1012.294,3456.868,0.0,0.0,0.0);
CreateDynamicObject(1225,2378.453,-1017.157,3448.759,0.0,0.0,0.0);
CreateDynamicObject(1225,2397.659,-1020.994,3446.559,0.0,0.0,0.0);
CreateDynamicObject(1225,2401.589,-1019.202,3444.626,0.0,0.0,0.0);
CreateDynamicObject(1225,2405.461,-1016.460,3441.140,0.0,0.0,0.0);
CreateDynamicObject(1225,2414.832,-1019.938,3449.074,0.0,0.0,0.0);
CreateDynamicObject(1225,2402.926,-1033.117,3467.478,0.0,0.0,0.0);
CreateDynamicObject(1225,2497.966,-1379.972,3803.039,0.0,0.0,0.0);
CreateDynamicObject(1225,2497.249,-1388.014,3808.551,0.0,0.0,0.0);
CreateDynamicObject(1225,2495.098,-1413.609,3830.031,0.0,0.0,0.0);
CreateDynamicObject(1225,2495.927,-1419.184,3834.405,0.0,0.0,0.0);
CreateDynamicObject(1225,2485.732,-1369.817,3802.761,0.0,0.0,0.0);
CreateDynamicObject(1225,2480.990,-1354.315,3795.531,0.0,0.0,0.0);
CreateDynamicObject(1225,2475.153,-1344.969,3794.565,0.0,0.0,0.0);
CreateDynamicObject(1225,2471.377,-1342.072,3795.349,0.0,0.0,0.0);
CreateDynamicObject(1225,2470.777,-1343.722,3796.417,0.0,0.0,0.0);
CreateDynamicObject(1676,2496.526,-1400.598,3820.614,0.0,0.0,0.0);
CreateDynamicObject(1676,2494.087,-1413.345,3830.052,0.0,0.0,0.0);
CreateDynamicObject(1676,2488.323,-1443.131,3859.414,0.0,0.0,0.0);
CreateDynamicObject(1676,2504.558,-1448.099,3857.644,0.0,0.0,0.0);
CreateDynamicObject(1676,2519.432,-1434.531,3843.455,0.0,0.0,0.0);
CreateDynamicObject(1676,2528.565,-1397.576,3818.261,0.0,0.0,0.0);
CreateDynamicObject(1676,2525.577,-1366.255,3806.774,0.0,0.0,0.0);
CreateDynamicObject(1676,2533.455,-1361.766,3820.969,0.0,0.0,0.0);
CreateDynamicObject(1225,2511.332,-2535.956,4747.921,0.0,0.0,0.0);
CreateDynamicObject(1225,2515.261,-2532.913,4748.145,0.0,0.0,0.0);
CreateDynamicObject(1225,2517.126,-2532.818,4748.139,0.0,0.0,0.0);
CreateDynamicObject(1225,2524.559,-2540.779,4748.617,0.0,0.0,0.0);
CreateDynamicObject(1225,2526.725,-2545.994,4748.930,0.0,0.0,0.0);
CreateDynamicObject(1225,2515.601,-2547.890,4749.044,0.0,0.0,0.0);
CreateDynamicObject(1225,2511.363,-2556.360,4749.553,0.0,0.0,0.0);
CreateDynamicObject(1225,2511.831,-2565.859,4750.124,0.0,0.0,0.0);
CreateDynamicObject(1225,2517.955,-2574.727,4750.656,0.0,0.0,0.0);
CreateDynamicObject(1225,2523.018,-2584.775,4751.170,0.0,0.0,0.0);
CreateDynamicObject(1225,2522.653,-2603.148,4752.364,0.0,0.0,0.0);
CreateDynamicObject(1225,2505.068,-2576.202,4750.745,0.0,0.0,0.0);
CreateDynamicObject(1225,2532.626,-2527.040,4747.702,0.0,0.0,0.0);
CreateDynamicObject(1225,2509.080,-2516.672,4747.169,0.0,0.0,0.0);
CreateDynamicObject(1225,2505.195,-2520.477,4747.397,0.0,0.0,0.0);
CreateDynamicObject(1225,2513.936,-2521.302,4747.447,0.0,0.0,0.0);
CreateDynamicObject(1225,2520.026,-2522.514,4747.520,0.0,0.0,0.0);
CreateDynamicObject(1225,2524.010,-2527.615,4747.826,0.0,0.0,0.0);
CreateDynamicObject(1225,2527.941,-2556.434,4749.558,0.0,0.0,0.0);
CreateDynamicObject(1225,2514.857,-2602.437,4752.321,0.0,0.0,0.0);
CreateDynamicObject(1225,2510.707,-2615.189,4753.087,0.0,0.0,0.0);
CreateDynamicObject(1225,2513.976,-2083.982,4329.520,0.0,0.0,0.0);
CreateDynamicObject(1225,2508.184,-2090.425,4339.522,0.0,0.0,0.0);
CreateDynamicObject(1225,2536.604,-1977.960,4274.747,0.0,0.0,0.0);
CreateDynamicObject(1225,2524.787,-2083.602,4327.525,0.0,0.0,0.0);
CreateDynamicObject(1225,2527.996,-2074.131,4322.703,0.0,0.0,0.0);
CreateDynamicObject(1225,2519.063,-2062.688,4312.700,0.0,0.0,0.0);
CreateDynamicObject(1225,2514.215,-2055.397,4310.166,0.0,0.0,0.0);
CreateDynamicObject(1225,2504.105,-1994.640,4287.135,0.0,0.0,0.0);
CreateDynamicObject(1225,2522.461,-2021.134,4293.737,0.0,0.0,0.0);
CreateDynamicObject(1225,2541.296,-1981.449,4283.755,0.0,0.0,0.0);
CreateDynamicObject(1225,2512.592,-1994.786,4284.268,0.0,0.0,0.0);
CreateDynamicObject(1225,2499.545,-2036.141,4304.526,0.0,0.0,0.0);
CreateDynamicObject(1225,2491.093,-2069.708,4333.008,0.0,0.0,0.0);
CreateDynamicObject(1225,2487.926,-2079.328,4344.620,0.0,0.0,0.0);
CreateDynamicObject(1225,2487.221,-2092.238,4349.563,0.0,0.0,0.0);
CreateDynamicObject(1225,2505.171,-2104.156,4351.037,0.0,0.0,0.0);
CreateDynamicObject(1225,2508.540,-2112.324,4356.988,0.0,0.0,0.0);
CreateDynamicObject(1225,2512.009,-2124.441,4366.084,0.0,0.0,0.0);
CreateDynamicObject(1225,2508.063,-2145.907,4383.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2514.678,-2144.566,4381.728,0.0,0.0,0.0);
CreateDynamicObject(1225,2523.178,-2119.511,4360.195,0.0,0.0,0.0);
CreateDynamicObject(1225,2522.343,-2105.242,4348.918,0.0,0.0,0.0);
CreateDynamicObject(1225,2528.218,-2102.416,4345.635,0.0,0.0,0.0);
CreateDynamicObject(1225,2536.155,-2102.540,4349.598,0.0,0.0,0.0);
CreateDynamicObject(1225,2542.645,-2094.166,4352.441,0.0,0.0,0.0);
CreateDynamicObject(1225,2537.363,-2090.093,4343.766,0.0,0.0,0.0);
CreateDynamicObject(1225,2534.514,-2087.760,4339.006,0.0,0.0,0.0);
CreateDynamicObject(1225,2530.716,-2086.995,4334.032,0.0,0.0,0.0);
CreateDynamicObject(1225,2527.994,-2087.336,4330.986,0.0,0.0,0.0);
CreateDynamicObject(1225,2519.536,-2087.875,4332.616,0.0,0.0,0.0);
CreateDynamicObject(1225,2510.428,-2092.859,4341.080,0.0,0.0,0.0);
CreateDynamicObject(1225,2508.829,-2092.586,4341.139,0.0,0.0,0.0);
CreateDynamicObject(1225,2486.104,-2081.711,4338.913,0.0,0.0,0.0);
CreateDynamicObject(1225,2487.308,-2078.395,4335.948,0.0,0.0,0.0);
CreateDynamicObject(1225,2496.738,-2081.109,4331.518,0.0,0.0,0.0);
CreateDynamicObject(1225,2494.177,-2078.645,4331.590,0.0,0.0,0.0);
CreateDynamicObject(1225,2489.652,-2079.261,4339.424,0.0,0.0,0.0);
CreateDynamicObject(1225,2486.839,-2070.990,4346.056,0.0,0.0,0.0);
CreateDynamicObject(1225,2486.990,-2065.927,4344.493,0.0,0.0,0.0);
CreateDynamicObject(1225,2493.424,-2060.524,4320.216,0.0,0.0,0.0);
CreateDynamicObject(1225,2490.048,-2040.780,4312.116,0.0,0.0,0.0);
CreateDynamicObject(1225,2483.819,-2017.445,4309.066,0.0,0.0,0.0);
CreateDynamicObject(1225,2486.073,-2017.683,4306.852,0.0,0.0,0.0);
CreateDynamicObject(1225,2498.841,-2031.135,4303.285,0.0,0.0,0.0);
CreateDynamicObject(1225,2510.377,-2033.256,4300.464,0.0,0.0,0.0);
CreateDynamicObject(1225,2519.427,-2043.388,4304.344,0.0,0.0,0.0);
CreateDynamicObject(1225,2529.842,-2036.822,4303.106,0.0,0.0,0.0);
CreateDynamicObject(1225,2532.809,-2025.403,4299.971,0.0,0.0,0.0);
CreateDynamicObject(1225,2537.187,-2018.280,4301.028,0.0,0.0,0.0);
CreateDynamicObject(1225,2450.716,-1719.549,4181.702,0.0,0.0,0.0);
CreateDynamicObject(1225,2520.707,-2012.205,4290.756,0.0,0.0,0.0);
CreateDynamicObject(1225,2510.240,-2014.124,4292.888,0.0,0.0,0.0);
CreateDynamicObject(1225,2501.445,-2010.330,4294.618,0.0,0.0,0.0);
CreateDynamicObject(1225,2538.465,-1987.892,4280.073,0.0,0.0,0.0);
CreateDynamicObject(1225,2543.758,-1972.418,4275.033,0.0,0.0,0.0);
CreateDynamicObject(1225,2544.361,-1970.358,4274.333,0.0,0.0,0.0);
CreateDynamicObject(1225,2523.729,-1796.112,4116.780,0.0,0.0,0.0);
CreateDynamicObject(1225,2514.324,-1806.798,4129.328,0.0,0.0,0.0);
CreateDynamicObject(1225,2509.572,-1811.592,4136.923,0.0,0.0,0.0);
CreateDynamicObject(1225,2500.320,-1803.800,4142.200,0.0,0.0,0.0);
CreateDynamicObject(1225,2548.460,-1713.349,4066.172,0.0,0.0,0.0);
CreateDynamicObject(1225,2487.936,-1796.503,4151.154,0.0,0.0,0.0);
CreateDynamicObject(1225,2497.553,-1814.476,4151.000,0.0,0.0,0.0);
CreateDynamicObject(1225,2486.881,-1830.320,4171.082,0.0,0.0,0.0);
CreateDynamicObject(1225,2489.301,-1835.256,4171.152,0.0,0.0,0.0);
CreateDynamicObject(1225,2511.919,-1836.443,4150.465,0.0,0.0,0.0);
CreateDynamicObject(1225,2539.548,-1823.911,4146.522,0.0,0.0,0.0);
CreateDynamicObject(1225,2544.698,-1820.600,4150.850,0.0,0.0,0.0);
CreateDynamicObject(1225,2551.922,-1825.763,4162.439,0.0,0.0,0.0);
CreateDynamicObject(1225,2552.162,-1794.615,4153.667,0.0,0.0,0.0);
CreateDynamicObject(1225,2548.221,-1793.142,4142.304,0.0,0.0,0.0);
CreateDynamicObject(1225,2546.879,-1785.893,4136.426,0.0,0.0,0.0);
CreateDynamicObject(1225,2535.292,-1788.771,4121.636,0.0,0.0,0.0);
CreateDynamicObject(1225,2539.819,-1799.602,4133.172,0.0,0.0,0.0);
CreateDynamicObject(1225,2540.616,-1805.751,4137.588,0.0,0.0,0.0);
CreateDynamicObject(1225,2535.214,-1812.943,4135.142,0.0,0.0,0.0);
CreateDynamicObject(1225,2526.685,-1823.307,4138.222,0.0,0.0,0.0);
CreateDynamicObject(1225,2525.070,-1826.072,4140.538,0.0,0.0,0.0);
CreateDynamicObject(1225,2518.618,-1835.763,4148.794,0.0,0.0,0.0);
CreateDynamicObject(1225,2514.390,-1848.865,4159.172,0.0,0.0,0.0);
CreateDynamicObject(1225,2523.006,-1867.508,4171.741,0.0,0.0,0.0);
CreateDynamicObject(1225,2519.822,-1887.324,4186.845,0.0,0.0,0.0);
CreateDynamicObject(1225,2515.262,-1895.653,4193.577,0.0,0.0,0.0);
CreateDynamicObject(1225,2523.749,-1724.700,4063.968,0.0,0.0,0.0);
CreateDynamicObject(1225,2523.501,-1722.689,4062.561,0.0,0.0,0.0);
CreateDynamicObject(1225,2514.964,-1713.425,4056.991,0.0,0.0,0.0);
CreateDynamicObject(1225,2500.874,-1708.785,4059.953,0.0,0.0,0.0);
CreateDynamicObject(1225,2533.209,-1708.330,4055.810,0.0,0.0,0.0);
CreateDynamicObject(1225,2536.199,-1712.672,4059.905,0.0,0.0,0.0);
CreateDynamicObject(1225,2535.038,-1721.672,4065.383,0.0,0.0,0.0);
CreateDynamicObject(1225,2535.330,-1719.005,4063.733,0.0,0.0,0.0);
CreateDynamicObject(1225,2546.772,-1712.055,4065.022,0.0,0.0,0.0);
CreateDynamicObject(1676,2427.749,-1224.311,3773.050,0.0,0.0,0.0);
CreateDynamicObject(1676,2441.396,-1233.089,3760.360,0.0,0.0,0.0);
CreateDynamicObject(1676,2450.445,-1233.424,3752.771,0.0,0.0,0.0);
CreateDynamicObject(1676,2466.490,-1235.262,3745.043,0.0,0.0,0.0);
CreateDynamicObject(1676,2472.299,-1233.533,3742.902,0.0,0.0,0.0);
CreateDynamicObject(1676,2481.232,-1230.598,3740.045,0.0,0.0,0.0);
CreateDynamicObject(1676,2498.551,-1230.445,3746.031,0.0,0.0,0.0);
CreateDynamicObject(1676,2505.258,-1225.943,3747.258,0.0,0.0,0.0);
CreateDynamicObject(1676,2514.361,-1222.364,3749.545,0.0,0.0,0.0);
CreateDynamicObject(1676,2521.433,-1215.249,3753.106,0.0,0.0,0.0);
CreateDynamicObject(1676,2526.188,-1212.826,3756.136,0.0,0.0,0.0);
CreateDynamicObject(1225,2529.716,-2638.754,4754.502,0.0,0.0,0.0);
CreateDynamicObject(1225,2527.427,-2638.622,4754.495,0.0,0.0,0.0);
CreateDynamicObject(1225,2526.390,-2638.762,4754.503,0.0,0.0,0.0);
CreateDynamicObject(1225,2525.110,-2638.709,4754.500,0.0,0.0,0.0);
CreateDynamicObject(1225,2524.046,-2637.951,4754.455,0.0,0.0,0.0);
CreateDynamicObject(1225,2522.994,-2638.504,4754.488,0.0,0.0,0.0);
CreateDynamicObject(1225,2522.403,-2638.294,4754.475,0.0,0.0,0.0);
CreateDynamicObject(1225,2520.613,-2637.452,4754.424,0.0,0.0,0.0);
CreateDynamicObject(1225,2518.636,-2636.761,4754.383,0.0,0.0,0.0);
CreateDynamicObject(1225,2517.980,-2636.854,4754.388,0.0,0.0,0.0);
CreateDynamicObject(1225,2517.125,-2636.440,4754.364,0.0,0.0,0.0);
CreateDynamicObject(1225,2515.542,-2635.918,4754.332,0.0,0.0,0.0);
CreateDynamicObject(1225,2514.844,-2635.907,4754.332,0.0,0.0,0.0);
CreateDynamicObject(1225,2530.226,-2637.326,4754.417,0.0,0.0,0.0);
CreateDynamicObject(1225,2531.484,-2636.869,4754.389,0.0,0.0,0.0);
CreateDynamicObject(1225,2531.958,-2636.742,4754.382,0.0,0.0,0.0);
CreateDynamicObject(1225,2531.862,-2639.859,4754.569,0.0,0.0,0.0);
CreateDynamicObject(1225,2532.660,-2638.996,4754.517,0.0,0.0,0.0);
CreateDynamicObject(1225,2533.758,-2639.185,4754.528,0.0,0.0,0.0);
CreateDynamicObject(1225,2528.550,-2639.146,4754.526,0.0,0.0,0.0);
CreateDynamicObject(1225,2526.592,-2640.465,4754.605,0.0,0.0,0.0);
CreateDynamicObject(1225,2524.836,-2639.606,4754.554,0.0,0.0,0.0);
CreateDynamicObject(1225,2522.086,-2637.163,4754.758,0.0,0.0,0.0);
CreateDynamicObject(1225,2521.622,-2638.541,4754.490,0.0,0.0,0.0);
CreateDynamicObject(1225,2521.613,-2639.511,4754.548,0.0,0.0,0.0);
CreateDynamicObject(1225,2520.635,-2639.428,4754.543,0.0,0.0,0.0);
CreateDynamicObject(1225,2518.650,-2638.503,4754.487,0.0,0.0,0.0);
CreateDynamicObject(1225,2513.787,-2635.156,4754.287,0.0,0.0,0.0);
CreateDynamicObject(1225,2512.853,-2635.385,4754.300,0.0,0.0,0.0);
CreateDynamicObject(1225,2510.419,-2634.938,4754.273,0.0,0.0,0.0);
CreateDynamicObject(1225,2505.731,-2631.863,4754.088,0.0,0.0,0.0);
CreateDynamicObject(1225,2514.255,-2636.938,4754.394,0.0,0.0,0.0);
CreateDynamicObject(1225,2514.031,-2637.380,4754.420,0.0,0.0,0.0);
CreateDynamicObject(1225,2513.872,-2637.715,4754.440,0.0,0.0,0.0);
CreateDynamicObject(1225,2509.513,-2638.120,4754.464,0.0,0.0,0.0);
CreateDynamicObject(1225,2508.410,-2636.061,4754.341,0.0,0.0,0.0);
CreateDynamicObject(1225,2508.183,-2635.181,4754.288,0.0,0.0,0.0);
CreateDynamicObject(1225,2509.371,-2634.916,4754.272,0.0,0.0,0.0);
CreateDynamicObject(1225,2511.550,-2636.360,4754.359,0.0,0.0,0.0);
CreateDynamicObject(1225,2511.863,-2636.237,4754.352,0.0,0.0,0.0);
CreateDynamicObject(1225,2506.584,-2636.820,4754.386,0.0,0.0,0.0);
CreateDynamicObject(1225,2506.590,-2635.728,4755.238,0.0,0.0,0.0);
CreateDynamicObject(1225,2506.888,-2635.101,4755.362,0.0,0.0,0.0);
CreateDynamicObject(1225,2502.784,-2632.689,4754.138,0.0,0.0,0.0);
CreateDynamicObject(1225,2502.834,-2633.165,4754.167,0.0,0.0,0.0);
CreateDynamicObject(1225,2504.145,-2633.677,4754.198,0.0,0.0,0.0);
CreateDynamicObject(1225,2533.699,-2634.937,4754.273,0.0,0.0,0.0);
CreateDynamicObject(1225,2532.681,-2637.733,4755.645,0.0,0.0,0.0);
CreateDynamicObject(1225,2533.822,-2637.994,4755.584,0.0,0.0,0.0);
CreateDynamicObject(1225,2535.334,-2636.777,4754.384,0.0,0.0,0.0);
CreateDynamicObject(1225,2535.999,-2637.279,4754.414,0.0,0.0,0.0);
CreateDynamicObject(1225,2519.655,-2637.659,4754.437,0.0,0.0,0.0);
CreateDynamicObject(8171,-2048.017,-847.414,31.241,0.0,-269.760,0.0);
CreateDynamicObject(8171,-2048.042,-824.094,31.174,0.0,-269.760,0.0);
CreateDynamicObject(8171,-2048.041,-895.851,31.249,0.0,-269.760,0.0);
CreateDynamicObject(8171,-2034.774,-964.996,31.249,0.0,-269.760,-270.001);
CreateDynamicObject(8171,-2035.967,-754.883,31.174,0.0,-269.760,-90.000);
CreateDynamicObject(8171,-2000.379,-823.822,31.174,0.0,-269.760,-180.000);
CreateDynamicObject(8171,-2000.399,-961.713,31.174,0.0,-269.760,-180.000);
CreateDynamicObject(8171,-2028.229,-798.203,50.079,0.0,-182.097,-180.000);
CreateDynamicObject(8171,-2005.850,-799.186,49.279,0.0,-182.097,-180.000);
CreateDynamicObject(8171,-2028.229,-897.115,50.054,0.0,-182.097,-180.000);
CreateDynamicObject(8171,-2012.138,-921.193,49.467,0.0,-182.097,-180.000);
CreateDynamicObject(1608,-2047.081,-953.985,41.672,-378.049,-351.406,-418.443);
CreateDynamicObject(1225,-2042.550,-903.359,31.578,0.0,0.0,0.0);
CreateDynamicObject(2780,-2032.268,-807.033,22.929,0.0,0.0,0.0);
CreateDynamicObject(2780,-2019.637,-824.561,23.429,0.0,0.0,0.0);
CreateDynamicObject(3524,-2036.755,-849.930,31.985,0.0,0.0,-236.248);
CreateDynamicObject(6865,-2033.854,-755.448,36.822,0.0,0.0,-315.001);
CreateDynamicObject(8483,-2004.342,-963.257,35.578,0.0,0.0,-236.248);
CreateDynamicObject(9831,-2037.496,-955.870,30.776,-314.451,0.0,-393.748);
CreateDynamicObject(9833,-1997.367,-861.896,34.374,0.0,-413.286,0.0);
CreateDynamicObject(9833,-2018.168,-751.178,41.474,0.0,-323.905,-455.398);
CreateDynamicObject(9833,-2015.383,-857.815,52.799,0.0,-176.081,-353.985);
CreateDynamicObject(9833,-2028.438,-858.189,53.274,0.0,-176.081,-353.985);
CreateDynamicObject(9833,-2022.352,-859.230,53.049,0.0,-176.081,-353.985);
CreateDynamicObject(9833,-2051.986,-860.482,38.874,0.0,-275.776,-353.985);
CreateDynamicObject(9833,-2017.683,-937.527,25.374,-355.704,-357.423,-1820.780);
CreateDynamicObject(9833,-2027.075,-891.206,25.907,-355.704,-357.423,-1820.780);
CreateDynamicObject(9833,-2014.806,-800.140,25.882,-355.704,-357.423,-1820.780);
CreateDynamicObject(1225,-2004.710,-961.734,31.578,0.0,0.0,0.0);
CreateDynamicObject(1225,-2002.603,-899.781,31.578,0.0,0.0,0.0);
CreateDynamicObject(1225,-2024.312,-838.659,29.578,0.0,0.0,0.0);
CreateDynamicObject(1225,-2014.270,-835.461,29.578,0.0,0.0,0.0);
CreateDynamicObject(1225,-2016.324,-897.592,29.585,0.0,0.0,0.0);
CreateDynamicObject(1225,-2029.359,-913.434,29.585,0.0,0.0,0.0);
CreateDynamicObject(902,-2024.554,-847.708,29.133,0.0,0.0,0.0);
CreateDynamicObject(9833,-2002.639,-957.844,37.260,-355.704,-260.306,-1659.051);
CreateDynamicObject(9833,-2006.220,-960.402,37.635,-355.704,-260.306,-1659.051);
CreateDynamicObject(9833,-2029.629,-915.795,53.308,0.0,-176.081,-353.985);
CreateDynamicObject(9833,-2019.481,-940.462,52.936,0.0,-176.081,-353.985);
CreateDynamicObject(9833,-2019.644,-900.513,52.942,0.0,-176.081,-353.985);
CreateDynamicObject(9833,-2025.018,-794.361,53.164,0.0,-176.081,-353.985);
CreateDynamicObject(9833,-2009.923,-766.446,52.612,0.0,-176.081,-353.985);
CreateDynamicObject(9833,-2020.338,-816.061,52.993,0.0,-176.081,-353.985);
CreateDynamicObject(9833,-2051.481,-811.873,47.165,0.0,-231.945,-353.985);
CreateDynamicObject(9833,-1997.103,-907.626,41.535,0.0,-413.286,0.0);
CreateDynamicObject(9833,-2051.648,-922.322,37.307,0.0,-413.286,-542.201);
CreateDynamicObject(10757,-2018.492,-754.943,47.991,-329.061,-353.125,-366.091);
CreateDynamicObject(9833,-2026.989,-772.685,25.874,-355.704,-357.423,-1820.780);
CreateDynamicObject(9833,-2030.789,-830.061,25.374,-355.704,-357.423,-1820.780);
CreateDynamicObject(8493,-595.042,-5342.458,16.496,0.0,0.0,-461.248);
CreateDynamicObject(8493,-604.150,-5392.930,16.536,0.0,0.0,-461.248);
CreateDynamicObject(8493,-611.323,-5430.775,15.878,0.0,0.0,-461.248);
CreateDynamicObject(8493,-587.358,-5303.269,17.188,0.0,0.0,-461.248);
CreateDynamicObject(18367,-604.579,-5335.092,3.789,-354.844,0.0,-191.248);
CreateDynamicObject(8493,-590.334,-5323.626,16.744,0.0,-359.141,-461.248);
CreateDynamicObject(8493,-607.836,-5411.868,16.082,0.0,-359.141,-461.248);
CreateDynamicObject(18367,-620.797,-5423.765,3.136,-354.844,0.0,-191.248);
CreateDynamicObject(2064,-594.653,-5391.249,6.633,0.0,0.0,-197.344);
CreateDynamicObject(2064,-587.293,-5346.614,6.193,0.0,0.0,-366.091);
CreateDynamicObject(1225,-599.299,-5342.802,4.666,0.0,0.0,0.0);
CreateDynamicObject(1225,-607.774,-5389.953,4.680,0.0,0.0,0.0);
CreateDynamicObject(1225,-626.429,-5319.280,8.346,0.0,0.0,0.0);
CreateDynamicObject(1225,-588.620,-5301.036,6.159,0.0,0.0,0.0);
CreateDynamicObject(1225,-608.520,-5411.732,5.216,0.0,0.0,0.0);
CreateDynamicObject(1225,-646.729,-5424.530,7.477,0.0,0.0,0.0);
CreateDynamicObject(3524,-612.685,-5340.751,7.092,0.0,0.0,-281.248);
CreateDynamicObject(3524,-594.230,-5323.342,7.358,0.0,0.0,-461.248);
CreateDynamicObject(3524,-604.290,-5297.082,7.785,0.0,0.0,-281.248);
CreateDynamicObject(3524,-621.056,-5386.742,7.132,0.0,0.0,-281.248);
CreateDynamicObject(3524,-611.018,-5408.323,6.747,0.0,0.0,-101.247);
CreateDynamicObject(3524,-628.164,-5424.607,6.474,0.0,0.0,-281.248);
CreateDynamicObject(1608,-577.910,-5372.810,-3.466,0.0,0.0,-303.748);
CreateDynamicObject(1608,-630.809,-5359.615,-3.801,0.0,0.0,-135.000);
CreateDynamicObject(10166,-465.830,-5364.670,0.519,0.0,0.0,-213.748);
CreateDynamicObject(10166,-738.934,-5395.893,0.981,0.0,0.0,-11.247);
CreateDynamicObject(8613,-609.243,-5348.299,0.836,0.0,0.0,-371.248);
CreateDynamicObject(8613,-609.394,-5382.163,0.871,0.0,0.0,-191.248);
CreateDynamicObject(982,-599.145,-5375.719,5.213,0.0,-271.479,-371.174);
CreateDynamicObject(982,-595.803,-5358.821,5.223,0.0,-271.479,-371.174);
CreateDynamicObject(972,1563.081,1225.209,9.809,0.0,0.0,-450.001);
CreateDynamicObject(972,1599.562,1225.211,10.040,0.0,0.0,-450.001);
CreateDynamicObject(972,1582.962,1225.186,9.809,0.0,0.0,-450.001);
CreateDynamicObject(972,1605.492,1225.211,9.925,0.0,0.0,-450.001);
CreateDynamicObject(972,1560.926,1225.285,15.634,0.0,0.0,-450.001);
CreateDynamicObject(972,1604.991,1225.286,15.388,0.0,0.0,-450.001);
CreateDynamicObject(972,1582.844,1225.385,15.323,0.0,0.0,-450.001);
CreateDynamicObject(3452,1473.124,1746.577,15.562,0.0,0.0,-180.000);
CreateDynamicObject(3452,1443.797,1746.539,15.545,0.0,0.0,-180.000);
CreateDynamicObject(3452,1414.277,1746.547,15.545,0.0,0.0,-180.000);
CreateDynamicObject(3452,1502.664,1746.593,15.570,0.0,0.0,-180.000);
CreateDynamicObject(3453,1532.772,1741.131,15.545,0.0,0.0,-270.001);
CreateDynamicObject(3452,1539.149,1712.226,15.545,0.0,0.0,-270.001);
CreateDynamicObject(3452,1539.133,1682.942,15.545,0.0,0.0,-270.001);
CreateDynamicObject(3452,1539.132,1653.489,15.545,0.0,0.0,-270.001);
CreateDynamicObject(3452,1539.114,1623.972,15.545,0.0,0.0,-270.001);
CreateDynamicObject(3453,1533.614,1593.739,15.545,0.0,0.0,0.0);
CreateDynamicObject(3452,1504.332,1587.434,15.545,0.0,0.0,0.0);
CreateDynamicObject(3452,1474.785,1587.372,15.537,0.0,0.0,0.0);
CreateDynamicObject(3452,1445.337,1587.347,15.537,0.0,0.0,0.0);
CreateDynamicObject(3452,1415.975,1587.356,15.545,0.0,0.0,0.0);
CreateDynamicObject(3453,1385.894,1592.833,15.537,0.0,0.0,-90.000);
CreateDynamicObject(3452,1379.538,1622.079,15.537,0.0,0.0,-90.000);
CreateDynamicObject(3452,1379.505,1651.559,15.537,0.0,0.0,-90.000);
CreateDynamicObject(3452,1379.478,1681.120,15.545,0.0,0.0,-90.000);
CreateDynamicObject(3452,1379.449,1710.677,15.545,0.0,0.0,-90.000);
CreateDynamicObject(3453,1384.931,1740.190,15.545,0.0,0.0,-180.000);
CreateDynamicObject(7617,1460.488,1754.326,27.352,0.0,0.0,0.0);
CreateDynamicObject(7617,1371.857,1662.602,29.042,0.0,0.0,-272.579);
CreateDynamicObject(7617,1459.729,1578.962,27.277,0.0,0.0,-182.579);
CreateDynamicObject(7617,1548.110,1664.017,29.584,0.0,0.0,-272.579);
CreateDynamicObject(13631,1418.067,1687.847,34.904,0.0,0.0,0.0);
CreateDynamicObject(8357,1514.789,1652.056,9.890,0.0,0.0,0.0);
CreateDynamicObject(8357,1532.919,1690.973,9.851,0.0,0.0,0.0);
CreateDynamicObject(8357,1458.688,1764.209,9.982,0.0,0.0,-270.001);
CreateDynamicObject(8357,1480.050,1576.861,9.907,0.0,0.0,-270.001);
CreateDynamicObject(8357,1375.219,1661.016,9.840,0.0,0.0,-180.000);
CreateDynamicObject(8357,1437.463,1657.042,9.865,0.0,0.0,0.0);
CreateDynamicObject(8357,1413.750,1614.939,9.840,0.0,0.0,0.0);
CreateDynamicObject(7956,1388.808,1696.346,11.228,0.0,0.0,-153.203);
CreateDynamicObject(7956,1389.048,1631.040,11.228,0.0,0.0,-153.203);
CreateDynamicObject(7956,1428.291,1737.435,11.225,0.0,0.0,-243.203);
CreateDynamicObject(7956,1495.102,1737.692,11.217,0.0,0.0,-243.203);
CreateDynamicObject(7956,1529.458,1704.166,11.286,0.0,0.0,-333.204);
CreateDynamicObject(7956,1529.711,1637.405,11.278,0.0,0.0,-333.204);
CreateDynamicObject(7956,1495.578,1596.774,11.278,0.0,0.0,-63.203);
CreateDynamicObject(7956,1428.886,1596.477,11.253,0.0,0.0,-63.203);
CreateDynamicObject(7956,1423.857,1596.384,11.236,0.0,0.0,-63.203);
CreateDynamicObject(7956,1423.322,1737.468,11.225,0.0,0.0,-243.203);
CreateDynamicObject(7956,1388.758,1703.478,11.225,0.0,0.0,-153.203);
CreateDynamicObject(7956,1529.714,1630.349,11.278,0.0,0.0,-333.204);
CreateDynamicObject(3524,1528.145,1598.355,12.759,0.0,0.0,-123.747);
CreateDynamicObject(3524,1390.944,1598.263,12.709,0.0,0.0,-213.748);
CreateDynamicObject(3524,1390.461,1735.773,12.709,0.0,0.0,-315.001);
CreateDynamicObject(3524,1527.844,1736.485,12.767,0.0,0.0,-33.747);
CreateDynamicObject(3864,1471.822,1735.721,15.910,0.0,0.0,-270.001);
CreateDynamicObject(3864,1389.880,1711.237,15.921,0.0,0.0,-180.000);
CreateDynamicObject(3864,1390.783,1644.435,15.921,0.0,0.0,-180.000);
CreateDynamicObject(3864,1415.955,1598.037,15.921,0.0,0.0,-90.000);
CreateDynamicObject(3864,1487.683,1598.603,15.910,0.0,0.0,-90.000);
CreateDynamicObject(3864,1527.540,1630.743,15.971,0.0,0.0,0.0);
CreateDynamicObject(3864,1527.834,1686.615,15.971,0.0,0.0,0.0);
CreateDynamicObject(3864,1512.000,1735.755,15.971,0.0,0.0,-270.001);
CreateDynamicObject(3864,1422.818,1734.922,15.946,0.0,0.0,-270.001);
CreateDynamicObject(11417,1402.350,1579.034,22.520,0.0,0.0,-315.001);
CreateDynamicObject(11417,1372.350,1740.286,22.622,0.0,0.0,-247.501);
CreateDynamicObject(11417,1547.977,1735.074,22.520,0.0,0.0,-225.001);
CreateDynamicObject(13562,1540.481,1585.664,22.037,0.0,0.0,0.0);
CreateDynamicObject(13562,1434.800,1755.594,22.600,0.0,0.0,0.0);
CreateDynamicObject(13562,1370.423,1688.305,22.498,0.0,0.0,0.0);
CreateDynamicObject(13562,1383.076,1581.381,21.914,0.0,0.0,0.0);
CreateDynamicObject(3452,1473.021,1746.249,15.698,0.0,0.0,-180.000);
CreateDynamicObject(1642,1463.937,1605.454,9.857,0.0,0.0,-270.001);
CreateDynamicObject(1642,1452.470,1605.661,9.894,0.0,0.0,-270.001);
CreateDynamicObject(1642,1454.617,1731.913,9.869,0.0,0.0,-270.001);
CreateDynamicObject(1642,1462.381,1732.067,9.832,0.0,0.0,-270.001);
CreateDynamicObject(11395,1376.523,1594.757,22.943,0.0,0.0,-236.248);
CreateDynamicObject(8644,1459.252,1580.233,41.953,-359.141,0.0,-65.701);
CreateDynamicObject(7939,1529.312,1687.316,14.280,0.0,0.0,-90.000);
CreateDynamicObject(7939,1478.869,1737.435,14.393,0.0,0.0,0.0);
CreateDynamicObject(7939,1529.503,1647.506,14.168,0.0,0.0,-90.000);
CreateDynamicObject(7939,1480.225,1596.742,13.980,0.0,0.0,-180.000);
CreateDynamicObject(7939,1439.991,1596.737,13.993,0.0,0.0,-180.000);
CreateDynamicObject(7939,1389.289,1647.354,13.997,0.0,0.0,-270.001);
CreateDynamicObject(7939,1389.265,1686.996,13.980,0.0,0.0,-270.001);
CreateDynamicObject(7939,1440.296,1737.425,14.418,0.0,0.0,0.0);
CreateDynamicObject(8171,3450.674,-1316.711,4.565,0.0,0.0,-326.483);
CreateDynamicObject(8343,3407.194,-1206.364,4.532,0.0,0.0,-327.342);
CreateDynamicObject(8344,3451.313,-1214.072,4.448,0.0,0.0,-189.832);
CreateDynamicObject(8171,3453.654,-1344.525,4.391,0.0,0.0,-9.454);
CreateDynamicObject(8343,3490.798,-1423.570,4.563,0.0,0.0,-148.579);
CreateDynamicObject(8344,3465.194,-1417.922,4.534,0.0,0.0,-10.313);
CreateDynamicObject(3452,3416.428,-1316.122,7.792,0.0,0.0,-56.723);
CreateDynamicObject(3452,3400.529,-1291.852,7.773,0.0,0.0,-56.723);
CreateDynamicObject(3452,3384.394,-1267.240,7.760,0.0,0.0,-56.723);
CreateDynamicObject(3452,3368.380,-1242.849,7.781,0.0,0.0,-56.723);
CreateDynamicObject(3452,3489.229,-1306.765,7.502,0.0,0.0,-279.214);
CreateDynamicObject(3452,3494.142,-1277.844,7.518,0.0,0.0,-280.073);
CreateDynamicObject(3452,3499.244,-1248.905,7.526,0.0,0.0,-280.073);
CreateDynamicObject(3452,3504.173,-1220.118,7.509,0.0,0.0,-279.214);
CreateDynamicObject(3452,3423.755,-1349.242,7.812,0.0,0.0,-99.695);
CreateDynamicObject(3452,3418.781,-1378.113,7.804,0.0,0.0,-99.695);
CreateDynamicObject(3452,3413.795,-1407.011,7.794,0.0,0.0,-99.695);
CreateDynamicObject(3452,3516.234,-1364.675,7.491,0.0,0.0,-237.961);
CreateDynamicObject(3452,3531.410,-1389.328,7.468,0.0,0.0,-238.820);
CreateDynamicObject(4100,3474.791,-1315.215,6.149,0.0,0.0,-318.748);
CreateDynamicObject(4100,3477.011,-1301.704,6.193,0.0,0.0,-319.607);
CreateDynamicObject(4100,3479.254,-1288.196,6.193,0.0,0.0,-319.607);
CreateDynamicObject(4100,3481.640,-1274.712,6.224,0.0,0.0,-320.467);
CreateDynamicObject(4100,3484.115,-1261.170,6.249,0.0,0.0,-319.607);
CreateDynamicObject(4100,3486.439,-1247.621,6.274,0.0,0.0,-319.607);
CreateDynamicObject(4100,3488.894,-1234.079,6.274,0.0,0.0,-320.467);
CreateDynamicObject(4100,3491.221,-1220.518,6.299,0.0,0.0,-318.748);
CreateDynamicObject(4100,3491.762,-1206.898,6.252,0.0,0.0,-305.856);
CreateDynamicObject(4100,3489.540,-1193.415,6.174,0.0,0.0,-295.543);
CreateDynamicObject(4100,3484.460,-1181.406,6.149,0.0,0.0,-98.732);
CreateDynamicObject(4100,3476.154,-1169.823,6.149,0.0,0.0,-269.760);
CreateDynamicObject(4100,3466.017,-1160.734,6.149,0.0,0.0,-254.290);
CreateDynamicObject(4100,3453.958,-1154.395,6.149,0.0,0.0,-241.399);
CreateDynamicObject(4100,3441.272,-1151.125,6.149,0.0,0.0,-47.166);
CreateDynamicObject(4100,3427.606,-1150.110,6.149,0.0,0.0,-41.253);
CreateDynamicObject(4100,3414.224,-1152.034,6.109,0.0,0.0,-21.486);
CreateDynamicObject(4100,3401.679,-1157.469,6.084,0.0,0.0,-11.173);
CreateDynamicObject(4100,3390.938,-1165.791,6.084,0.0,0.0,-352.266);
CreateDynamicObject(4100,3382.389,-1176.509,6.059,0.0,0.0,-344.531);
CreateDynamicObject(4100,3375.907,-1188.502,6.034,0.0,0.0,-331.639);
CreateDynamicObject(4100,3372.645,-1201.688,6.034,0.0,0.0,-315.310);
CreateDynamicObject(4100,3372.822,-1215.302,6.009,0.0,0.0,-302.419);
CreateDynamicObject(4100,3376.194,-1228.481,6.009,0.0,0.0,-288.668);
CreateDynamicObject(4100,3382.032,-1240.849,5.984,0.0,0.0,-280.073);
CreateDynamicObject(4100,3389.229,-1252.565,5.959,0.0,0.0,-276.635);
CreateDynamicObject(4100,3396.731,-1264.120,5.934,0.0,0.0,-276.635);
CreateDynamicObject(4100,3404.266,-1275.577,5.916,0.0,0.0,-276.635);
CreateDynamicObject(4100,3412.126,-1287.438,5.941,0.0,0.0,-96.257);
CreateDynamicObject(4100,3419.436,-1298.399,5.991,0.0,0.0,-276.635);
CreateDynamicObject(4100,3427.040,-1309.828,5.941,0.0,0.0,-275.776);
CreateDynamicObject(4100,3434.686,-1321.228,5.966,0.0,0.0,-276.635);
CreateDynamicObject(4100,3438.321,-1333.785,5.966,0.0,0.0,-312.732);
CreateDynamicObject(4100,3436.952,-1347.424,5.993,0.0,0.0,-318.748);
CreateDynamicObject(4100,3434.726,-1361.038,6.011,0.0,0.0,-320.467);
CreateDynamicObject(4100,3432.203,-1374.534,6.011,0.0,0.0,-320.467);
CreateDynamicObject(4100,3429.585,-1388.690,6.036,0.0,0.0,-140.844);
CreateDynamicObject(4100,3427.132,-1401.632,6.036,0.0,0.0,-320.467);
CreateDynamicObject(4100,3425.110,-1415.229,6.011,0.0,0.0,-316.170);
CreateDynamicObject(4100,3425.128,-1428.856,5.986,0.0,0.0,-303.278);
CreateDynamicObject(4100,3428.162,-1442.143,5.961,0.0,0.0,-290.386);
CreateDynamicObject(4100,3434.216,-1454.308,5.936,0.0,0.0,-275.776);
CreateDynamicObject(4100,3442.995,-1464.754,5.961,0.0,0.0,-263.744);
CreateDynamicObject(4100,3453.718,-1473.188,5.961,0.0,0.0,-251.712);
CreateDynamicObject(4100,3466.599,-1479.163,5.986,0.0,0.0,-57.582);
CreateDynamicObject(4100,3479.740,-1479.123,6.014,0.0,0.0,-23.205);
CreateDynamicObject(4100,3492.494,-1474.300,5.989,0.0,0.0,-14.610);
CreateDynamicObject(4100,3503.705,-1466.655,6.014,0.0,0.0,-357.423);
CreateDynamicObject(4100,3512.874,-1456.536,6.064,0.0,0.0,-347.109);
CreateDynamicObject(4100,3519.898,-1444.853,6.089,0.0,0.0,-335.077);
CreateDynamicObject(4100,3524.080,-1432.458,6.089,0.0,0.0,-141.807);
CreateDynamicObject(4100,3525.258,-1418.884,6.064,0.0,0.0,-127.197);
CreateDynamicObject(4100,3523.254,-1404.821,6.089,0.0,0.0,-296.403);
CreateDynamicObject(4100,3518.375,-1392.124,6.114,0.0,0.0,-281.792);
CreateDynamicObject(4100,3511.449,-1380.283,6.139,0.0,0.0,-277.495);
CreateDynamicObject(4100,3504.119,-1368.687,6.164,0.0,0.0,-277.495);
CreateDynamicObject(4100,3496.667,-1357.118,6.191,0.0,0.0,-276.635);
CreateDynamicObject(4100,3491.034,-1348.518,6.166,0.0,0.0,-276.635);
CreateDynamicObject(4100,3477.267,-1327.759,6.116,0.0,0.0,-276.635);
CreateDynamicObject(4100,3464.724,-1375.011,6.236,0.0,0.0,-320.467);
CreateDynamicObject(4100,3462.177,-1388.498,6.236,0.0,0.0,-320.467);
CreateDynamicObject(4100,3459.790,-1401.977,6.211,0.0,0.0,-319.607);
CreateDynamicObject(4100,3457.490,-1415.534,6.236,0.0,0.0,-318.748);
CreateDynamicObject(4100,3458.733,-1428.687,6.236,0.0,0.0,-288.668);
CreateDynamicObject(4100,3465.860,-1440.039,6.236,0.0,0.0,-265.463);
CreateDynamicObject(4100,3477.492,-1442.628,6.264,0.0,0.0,-18.908);
CreateDynamicObject(4100,3486.854,-1433.895,6.264,0.0,0.0,-336.796);
CreateDynamicObject(4100,3490.816,-1420.939,6.264,0.0,0.0,-317.888);
CreateDynamicObject(4100,3489.289,-1407.815,6.264,0.0,0.0,-289.527);
CreateDynamicObject(4100,3483.229,-1395.609,6.264,0.0,0.0,-278.354);
CreateDynamicObject(4100,3469.578,-1374.042,6.266,0.0,0.0,-276.326);
CreateDynamicObject(4100,3448.908,-1276.111,6.149,0.0,0.0,-319.607);
CreateDynamicObject(4100,3451.061,-1263.123,6.149,0.0,0.0,-139.229);
CreateDynamicObject(4100,3453.430,-1249.622,6.149,0.0,0.0,-140.088);
CreateDynamicObject(4100,3455.779,-1236.105,6.149,0.0,0.0,-139.229);
CreateDynamicObject(4100,3458.086,-1222.573,6.149,0.0,0.0,-139.229);
CreateDynamicObject(4100,3458.474,-1209.001,6.149,0.0,0.0,-122.899);
CreateDynamicObject(4100,3454.182,-1195.676,6.149,0.0,0.0,-280.933);
CreateDynamicObject(4100,3444.988,-1186.059,6.149,0.0,0.0,-252.571);
CreateDynamicObject(4100,3432.871,-1182.538,6.149,0.0,0.0,-39.534);
CreateDynamicObject(4100,3419.821,-1185.515,6.234,0.0,0.0,-12.032);
CreateDynamicObject(4100,3410.003,-1194.407,6.234,0.0,0.0,-341.953);
CreateDynamicObject(4100,3406.056,-1207.048,6.234,0.0,0.0,-311.013);
CreateDynamicObject(4100,3408.380,-1220.304,6.234,0.0,0.0,-287.808);
CreateDynamicObject(4100,3414.601,-1232.538,6.234,0.0,0.0,-277.495);
CreateDynamicObject(4100,3421.934,-1244.106,6.234,0.0,0.0,-277.495);
CreateDynamicObject(4100,3443.781,-1277.174,6.141,0.0,0.0,-276.635);
CreateDynamicObject(4100,3436.201,-1265.665,6.191,0.0,0.0,-276.635);
CreateDynamicObject(11496,3421.557,-1329.970,1.872,0.0,0.0,-145.245);
CreateDynamicObject(1423,3424.689,-1329.965,2.783,0.0,0.0,-237.101);
CreateDynamicObject(1423,3425.745,-1333.447,2.783,0.0,0.0,-271.479);
CreateDynamicObject(1425,3425.521,-1331.595,2.525,0.0,0.0,-81.646);
CreateDynamicObject(1553,3508.471,-1207.480,2.976,0.0,0.0,-12.892);
CreateDynamicObject(1553,3511.140,-1208.009,2.976,0.0,0.0,-10.313);
CreateDynamicObject(1553,3512.551,-1208.287,2.977,0.0,0.0,-11.173);
CreateDynamicObject(1425,3510.378,-1208.481,2.235,0.0,0.0,-9.454);
CreateDynamicObject(1423,3543.540,-1397.358,2.452,0.0,0.0,-151.261);
CreateDynamicObject(1423,3541.509,-1398.436,2.452,0.0,0.0,-152.120);
CreateDynamicObject(1423,3539.536,-1399.568,2.452,0.0,0.0,-152.980);
CreateDynamicObject(7416,3449.282,-1222.807,4.260,0.0,0.0,0.0);
CreateDynamicObject(7416,3486.904,-1423.472,4.390,0.0,0.0,0.0);
CreateDynamicObject(3279,3474.038,-1430.669,4.190,0.0,0.0,0.0);
CreateDynamicObject(3279,3433.328,-1199.592,4.344,0.0,0.0,0.0);
CreateDynamicObject(8417,3507.734,-1331.468,4.473,0.0,0.0,-327.342);
CreateDynamicObject(984,3485.747,-1321.939,5.070,0.0,0.0,-238.820);
CreateDynamicObject(984,3496.665,-1315.225,5.084,0.0,0.0,-237.961);
CreateDynamicObject(984,3507.415,-1308.380,5.070,0.0,0.0,-237.101);
CreateDynamicObject(984,3515.661,-1310.628,5.070,0.0,0.0,-329.061);
CreateDynamicObject(983,3520.669,-1318.849,5.117,0.0,0.0,-328.202);
CreateDynamicObject(983,3503.516,-1354.795,5.117,0.0,0.0,-237.101);
CreateDynamicObject(983,3509.029,-1351.388,5.117,0.0,0.0,-59.301);
CreateDynamicObject(983,3514.462,-1347.901,5.117,0.0,0.0,-55.004);
CreateDynamicObject(983,3519.714,-1344.291,5.117,0.0,0.0,-55.863);
CreateDynamicObject(983,3525.047,-1340.738,5.117,0.0,0.0,-56.723);
CreateDynamicObject(983,3530.431,-1337.266,5.117,0.0,0.0,-237.961);
CreateDynamicObject(983,3530.074,-1333.728,5.117,0.0,0.0,-328.202);
CreateDynamicObject(983,3527.659,-1329.686,5.117,0.0,-0.859,-329.061);
CreateDynamicObject(1425,3480.655,-1334.205,5.017,0.0,0.0,-56.723);
CreateDynamicObject(1425,3521.930,-1321.358,4.886,0.0,0.0,-57.582);
CreateDynamicObject(3458,3451.517,-1234.479,5.782,0.0,0.0,-280.073);
CreateDynamicObject(3458,3420.057,-1232.163,5.782,0.0,0.0,-237.858);
CreateDynamicObject(3627,3462.118,-1403.756,8.237,0.0,0.0,-188.114);
CreateDynamicObject(1284,3431.215,-1272.144,7.794,0.0,0.0,-325.623);
CreateDynamicObject(1284,3417.047,-1281.122,7.794,0.0,0.0,-146.001);
CreateDynamicObject(3398,3483.059,-1418.181,18.578,0.0,0.0,0.0);
CreateDynamicObject(3398,3436.151,-1229.404,18.449,0.0,0.0,0.0);
CreateDynamicObject(2797,3424.068,-1276.434,10.051,0.0,0.0,-325.623);
CreateDynamicObject(12921,3484.908,-1338.050,7.923,0.0,0.0,-56.620);
CreateDynamicObject(982,1046.069,1731.529,10.504,0.0,0.0,-270.001);
CreateDynamicObject(982,1033.267,1744.319,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1033.278,1769.917,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1046.023,1782.716,10.504,0.0,0.0,-90.000);
CreateDynamicObject(982,1071.598,1782.693,10.504,0.0,0.0,-90.000);
CreateDynamicObject(982,1090.806,1782.729,10.504,0.0,0.0,-90.000);
CreateDynamicObject(982,1103.595,1769.944,10.504,0.0,0.0,-180.000);
CreateDynamicObject(982,1071.644,1731.536,10.504,0.0,0.0,-90.000);
CreateDynamicObject(982,1103.555,1744.443,10.504,0.0,0.0,-180.000);
CreateDynamicObject(982,1087.565,1731.534,10.504,0.0,0.0,-270.001);
CreateDynamicObject(3458,1089.592,1793.104,11.342,0.0,0.0,-180.000);
CreateDynamicObject(3458,1052.998,1793.082,11.342,0.0,0.0,-180.000);
CreateDynamicObject(3458,1089.531,1788.115,11.317,0.0,0.0,0.0);
CreateDynamicObject(3458,1053.076,1788.099,11.342,0.0,0.0,0.0);
CreateDynamicObject(3458,1112.445,1775.483,11.342,0.0,0.0,-270.001);
CreateDynamicObject(3458,1107.438,1775.550,11.342,0.0,0.0,-90.000);
CreateDynamicObject(3458,1112.469,1754.122,11.342,0.0,0.0,-270.001);
CreateDynamicObject(3458,1107.429,1754.122,11.342,0.0,0.0,-90.000);
CreateDynamicObject(1342,1113.782,1745.290,10.854,0.0,0.0,-180.000);
CreateDynamicObject(3458,1112.328,1754.163,13.542,0.0,0.0,-270.001);
CreateDynamicObject(3819,1107.519,1742.883,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1112.270,1742.872,15.968,0.0,0.0,0.0);
CreateDynamicObject(3819,1107.479,1759.365,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1112.345,1759.306,16.068,0.0,0.0,0.0);
CreateDynamicObject(3458,1112.337,1775.457,13.542,0.0,0.0,-270.001);
CreateDynamicObject(3819,1107.466,1776.031,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1112.255,1775.984,16.068,0.0,0.0,0.0);
CreateDynamicObject(3458,1089.576,1793.091,13.567,0.0,0.0,-180.000);
CreateDynamicObject(3458,1052.994,1793.084,13.567,0.0,0.0,-180.000);
CreateDynamicObject(3819,1096.367,1788.211,13.843,0.0,0.0,-270.001);
CreateDynamicObject(3819,1096.368,1792.909,16.093,0.0,0.0,-270.001);
CreateDynamicObject(3819,1083.554,1788.261,13.843,0.0,0.0,-270.001);
CreateDynamicObject(3819,1083.549,1792.866,16.093,0.0,0.0,-270.001);
CreateDynamicObject(3819,1070.994,1788.156,13.868,0.0,0.0,-270.001);
CreateDynamicObject(3819,1071.061,1792.847,16.093,0.0,0.0,-270.001);
CreateDynamicObject(3819,1058.273,1788.100,13.868,0.0,0.0,-270.001);
CreateDynamicObject(3819,1058.269,1792.843,16.093,0.0,0.0,-270.001);
CreateDynamicObject(3819,1045.442,1788.178,13.868,0.0,0.0,-270.001);
CreateDynamicObject(3819,1045.431,1792.874,16.093,0.0,0.0,-270.001);
CreateDynamicObject(8614,1092.690,1784.685,11.620,0.0,0.0,0.0);
CreateDynamicObject(1260,1027.964,1775.971,22.393,0.0,0.0,-202.500);
CreateDynamicObject(1260,1038.828,1720.929,18.193,0.0,0.0,-112.500);
CreateDynamicObject(7907,1027.994,1775.789,28.273,0.0,0.0,-292.501);
CreateDynamicObject(7913,1039.027,1720.583,23.760,0.0,0.0,-202.500);
CreateDynamicObject(13562,1111.246,1790.788,17.060,0.0,0.0,0.0);
CreateDynamicObject(3864,1028.059,1730.283,15.917,0.0,0.0,-157.500);
CreateDynamicObject(3864,1035.487,1788.631,18.967,0.0,0.0,-247.501);
CreateDynamicObject(1643,1096.533,1757.401,9.840,0.0,0.0,0.0);
CreateDynamicObject(1643,1039.280,1756.471,9.915,0.0,0.0,0.0);
CreateDynamicObject(5130,1111.563,1728.341,12.059,0.0,0.0,-135.000);
CreateDynamicObject(2773,1103.188,1730.933,10.338,0.0,0.0,-22.500);
CreateDynamicObject(2773,1104.696,1728.448,10.338,0.0,0.0,-49.143);
CreateDynamicObject(2035,1107.341,1736.541,12.870,0.0,0.0,-337.501);
CreateDynamicObject(1579,1111.810,1737.368,10.023,0.0,0.0,-90.000);
CreateDynamicObject(8357,2660.982,-2855.815,20.409,0.0,0.0,-90.000);
CreateDynamicObject(8344,2513.649,-2880.254,20.392,0.0,0.0,-90.000);
CreateDynamicObject(8343,2466.904,-2964.105,20.538,0.0,0.0,-157.500);
CreateDynamicObject(8344,2494.760,-3040.546,20.629,0.0,0.0,-11.247);
CreateDynamicObject(8355,2582.471,-3061.307,20.581,0.0,0.0,-67.500);
CreateDynamicObject(8355,2681.787,-3005.218,20.621,0.0,0.0,-56.247);
CreateDynamicObject(8344,2755.117,-3029.277,20.661,0.0,0.0,-201.332);
CreateDynamicObject(8343,2771.598,-3136.039,20.492,0.0,0.0,-281.248);
CreateDynamicObject(8344,2855.996,-3128.814,20.425,0.0,0.0,-258.748);
CreateDynamicObject(8344,2900.538,-3033.125,20.418,0.0,0.0,-56.247);
CreateDynamicObject(8357,2830.311,-2855.754,20.363,0.0,0.0,-90.000);
CreateDynamicObject(5005,2797.939,-2874.225,23.913,0.0,0.0,0.0);
CreateDynamicObject(5005,2823.346,-2836.330,23.899,0.0,0.0,0.0);
CreateDynamicObject(5005,2639.623,-2874.172,23.920,0.0,0.0,0.0);
CreateDynamicObject(5005,2597.436,-3072.571,24.056,0.0,0.0,-336.716);
CreateDynamicObject(1260,2764.367,-2882.319,28.725,0.0,0.0,-146.247);
CreateDynamicObject(4638,2557.469,-2874.861,22.110,0.0,0.0,-180.000);
CreateDynamicObject(1238,2715.347,-2840.486,20.711,0.0,0.0,0.0);
CreateDynamicObject(1238,2714.400,-2871.104,20.719,0.0,0.0,0.0);
CreateDynamicObject(1257,2722.379,-2837.589,21.672,0.0,0.0,-270.001);
CreateDynamicObject(1284,2715.521,-2847.079,23.630,0.0,0.0,-270.001);
CreateDynamicObject(1262,2715.648,-2839.648,26.055,0.0,0.0,-90.000);
CreateDynamicObject(1262,2715.812,-2845.579,26.136,0.0,0.0,-90.000);
CreateDynamicObject(1262,2715.982,-2839.633,21.153,0.0,0.0,-123.747);
CreateDynamicObject(1262,2707.002,-2873.541,22.744,0.0,0.0,-56.247);
CreateDynamicObject(1297,2709.479,-2838.096,23.787,0.0,0.0,-270.001);
CreateDynamicObject(1297,2664.528,-2837.962,23.787,0.0,0.0,-270.001);
CreateDynamicObject(1297,2620.485,-2837.932,23.795,0.0,0.0,-270.001);
CreateDynamicObject(3398,2592.756,-2882.821,34.009,0.0,0.0,-146.247);
CreateDynamicObject(7416,2615.417,-2915.310,19.793,0.0,0.0,0.0);
CreateDynamicObject(7416,2537.361,-2915.334,19.689,0.0,0.0,0.0);
CreateDynamicObject(7416,2530.946,-3005.160,18.131,0.0,0.0,0.0);
CreateDynamicObject(18323,2631.813,-2990.082,26.353,0.0,0.0,-67.500);
CreateDynamicObject(18323,2606.821,-2942.052,24.528,0.0,0.0,-247.501);
CreateDynamicObject(3997,2682.083,-2780.085,20.406,0.0,0.0,0.0);
CreateDynamicObject(5005,2643.234,-2836.225,23.857,0.0,0.0,0.0);
CreateDynamicObject(7416,2518.735,-3073.648,20.248,0.0,0.0,0.0);
CreateDynamicObject(7416,2744.276,-3028.222,20.375,0.0,0.0,-90.000);
CreateDynamicObject(7416,2744.660,-2911.065,20.041,0.0,0.0,0.0);
CreateDynamicObject(7416,2678.108,-2968.476,20.355,0.0,0.0,-270.001);
CreateDynamicObject(7416,2673.462,-3039.671,20.348,0.0,0.0,-180.000);
CreateDynamicObject(1260,2640.150,-2968.185,45.383,0.0,0.0,-247.501);
CreateDynamicObject(13607,2877.495,-2943.788,26.178,0.0,0.0,-213.748);
CreateDynamicObject(17030,2697.977,-2923.575,18.405,0.0,0.0,-281.248);
CreateDynamicObject(3997,2832.090,-2777.939,20.363,0.0,0.0,0.0);
CreateDynamicObject(7416,2819.021,-2906.775,19.658,0.0,0.0,0.0);
CreateDynamicObject(615,2782.428,-2885.182,20.110,0.0,0.0,-11.247);
CreateDynamicObject(615,2803.250,-2883.800,20.110,0.0,0.0,-11.247);
CreateDynamicObject(615,2823.770,-2884.086,20.102,0.0,0.0,-33.747);
CreateDynamicObject(615,2844.894,-2884.383,20.110,0.0,0.0,-33.747);
CreateDynamicObject(615,2810.891,-2948.251,20.102,0.0,0.0,-33.747);
CreateDynamicObject(615,2689.452,-2961.173,20.349,0.0,0.0,-78.747);
CreateDynamicObject(615,2721.968,-2938.722,20.085,0.0,0.0,-78.747);
CreateDynamicObject(615,2742.904,-2934.767,20.085,0.0,0.0,-78.747);
CreateDynamicObject(615,2758.724,-2941.799,20.085,0.0,0.0,-78.747);
CreateDynamicObject(687,2733.313,-2933.760,20.111,0.0,0.0,0.0);
CreateDynamicObject(7416,2445.656,-2892.990,19.559,0.0,0.0,-180.000);
CreateDynamicObject(7416,2694.867,-2883.597,19.893,0.0,0.0,0.0);
CreateDynamicObject(615,2524.463,-3025.200,20.249,0.0,0.0,-135.000);
CreateDynamicObject(615,2514.782,-3021.763,11.375,0.0,0.0,-135.000);
CreateDynamicObject(7416,2868.114,-2906.477,19.709,0.0,0.0,0.0);
CreateDynamicObject(7416,2869.022,-2981.746,20.249,0.0,0.0,0.0);
CreateDynamicObject(7416,2933.254,-2916.894,19.723,0.0,0.0,0.0);
CreateDynamicObject(7416,2767.312,-2972.344,-0.532,0.0,0.0,0.0);
CreateDynamicObject(7416,2805.947,-2981.994,20.197,0.0,0.0,0.0);
CreateDynamicObject(7416,2814.843,-3052.380,20.090,0.0,0.0,-180.000);
CreateDynamicObject(7416,2838.978,-3145.521,20.169,0.0,0.0,-180.000);
CreateDynamicObject(7416,2769.096,-3144.224,20.260,0.0,0.0,-180.000);
CreateDynamicObject(18269,2862.288,-3181.688,38.596,0.0,0.0,-303.748);
CreateDynamicObject(615,2808.036,-2997.472,19.316,0.0,0.0,-78.747);
CreateDynamicObject(615,2826.474,-3012.207,20.009,0.0,0.0,-78.747);
CreateDynamicObject(615,2802.827,-3056.823,20.009,0.0,0.0,-78.747);
CreateDynamicObject(615,2793.070,-3079.457,20.017,0.0,0.0,-78.747);
CreateDynamicObject(615,2804.466,-3032.576,20.009,0.0,0.0,-78.747);
CreateDynamicObject(615,2776.373,-2960.474,19.324,0.0,0.0,-78.747);
CreateDynamicObject(615,2793.880,-2980.288,19.191,0.0,0.0,-78.747);
CreateDynamicObject(615,2816.593,-2954.468,19.316,0.0,0.0,-78.747);
CreateDynamicObject(1260,2618.912,-2887.891,31.765,0.0,0.0,-135.000);
CreateDynamicObject(1260,2671.132,-2890.331,32.623,0.0,0.0,-123.747);
CreateDynamicObject(4832,2763.337,-2805.188,52.555,0.0,0.0,0.0);
CreateDynamicObject(3997,2551.212,-2780.075,20.331,0.0,0.0,0.0);
CreateDynamicObject(3997,2958.554,-2776.931,20.402,0.0,0.0,0.0);
CreateDynamicObject(7416,2442.031,-2796.541,19.906,0.0,0.0,-180.000);
CreateDynamicObject(7416,2435.583,-2972.034,20.104,0.0,0.0,-180.000);
CreateDynamicObject(3452,2663.190,-2825.553,24.830,0.0,0.0,-180.000);
CreateDynamicObject(3452,2636.693,-2825.719,24.905,0.0,0.0,-180.000);
CreateDynamicObject(3452,2608.368,-2825.696,24.880,0.0,0.0,-180.000);
CreateDynamicObject(3452,2580.005,-2825.698,24.881,0.0,0.0,-180.000);
CreateDynamicObject(3452,2551.723,-2826.042,24.881,0.0,0.0,-180.000);
CreateDynamicObject(3452,2853.292,-2827.116,25.088,0.0,0.0,-180.000);
CreateDynamicObject(3452,2828.764,-2827.105,25.113,0.0,0.0,-180.000);
CreateDynamicObject(7416,2384.465,-2879.714,20.124,0.0,0.0,-180.000);
CreateDynamicObject(7416,2442.552,-3055.581,20.349,0.0,0.0,-180.000);
CreateDynamicObject(5005,2460.674,-3036.173,23.639,0.0,0.0,-281.248);
CreateDynamicObject(5005,2458.395,-3071.552,24.181,0.0,0.0,-67.500);
CreateDynamicObject(5005,2485.045,-3101.462,23.908,0.0,0.0,-33.747);
CreateDynamicObject(5005,2503.688,-3112.561,24.049,0.0,0.0,-337.421);
CreateDynamicObject(5005,2505.588,-2966.944,23.690,0.0,0.0,-101.247);
CreateDynamicObject(5005,2446.294,-2877.450,23.656,0.0,0.0,-68.360);
CreateDynamicObject(5005,2506.421,-2836.211,23.883,0.0,0.0,0.0);
CreateDynamicObject(5005,2448.932,-2868.003,23.110,0.0,0.0,-326.248);
CreateDynamicObject(5005,2450.324,-2878.489,23.943,0.0,0.0,-292.501);
CreateDynamicObject(5005,2678.626,-2983.396,23.915,0.0,0.0,-326.248);
CreateDynamicObject(5005,2583.107,-3026.873,23.807,0.0,0.0,-337.501);
CreateDynamicObject(978,2550.485,-2873.936,21.232,0.0,0.0,0.0);
CreateDynamicObject(978,2541.452,-2873.956,21.232,0.0,0.0,0.0);
CreateDynamicObject(978,2532.629,-2873.930,21.232,0.0,0.0,0.0);
CreateDynamicObject(978,2523.602,-2873.896,21.232,0.0,0.0,0.0);
CreateDynamicObject(978,2514.955,-2873.894,21.232,0.0,0.0,0.0);
CreateDynamicObject(978,2506.540,-2875.094,21.232,0.0,0.0,-343.672);
CreateDynamicObject(978,2498.563,-2879.237,21.232,0.0,0.0,-322.031);
CreateDynamicObject(978,2492.580,-2885.950,21.232,0.0,0.0,-301.250);
CreateDynamicObject(978,2489.165,-2894.353,21.232,0.0,0.0,-284.061);
CreateDynamicObject(978,2488.896,-2903.600,21.378,0.0,0.0,-259.057);
CreateDynamicObject(978,2491.518,-2912.497,21.378,0.0,0.0,-247.810);
CreateDynamicObject(978,2494.809,-2920.636,21.378,0.0,0.0,-247.810);
CreateDynamicObject(978,2498.326,-2929.177,21.378,0.0,0.0,-247.810);
CreateDynamicObject(978,2501.488,-2937.204,21.378,0.0,0.0,-250.388);
CreateDynamicObject(978,2504.568,-2945.885,21.378,0.0,0.0,-250.388);
CreateDynamicObject(8357,3013.271,-2855.814,20.392,0.0,0.0,-90.000);
CreateDynamicObject(8357,3011.054,-2974.631,20.312,0.0,0.0,-90.000);
CreateDynamicObject(8344,3149.342,-2950.557,20.197,0.0,0.0,-270.001);
CreateDynamicObject(8344,3153.655,-2890.135,20.223,0.0,0.0,-158.514);
CreateDynamicObject(5005,2858.935,-2836.355,23.904,0.0,0.0,0.0);
CreateDynamicObject(3452,2880.857,-2827.073,25.113,0.0,0.0,-180.000);
CreateDynamicObject(3452,2910.123,-2827.024,25.102,0.0,0.0,-180.000);
CreateDynamicObject(7416,3011.668,-2912.512,19.810,0.0,0.0,0.0);
CreateDynamicObject(7416,3079.192,-2915.434,19.853,0.0,0.0,0.0);
CreateDynamicObject(7416,3143.675,-2915.232,20.009,0.0,0.0,0.0);
CreateDynamicObject(1260,3008.724,-2940.558,32.908,0.0,0.0,-303.748);
CreateDynamicObject(1260,2981.042,-2935.437,32.908,0.0,0.0,-303.748);
CreateDynamicObject(5005,2925.911,-2874.160,23.882,0.0,0.0,0.0);
CreateDynamicObject(5005,3045.836,-2874.074,23.886,0.0,0.0,0.0);
CreateDynamicObject(5005,3057.612,-2836.709,23.927,0.0,0.0,0.0);
CreateDynamicObject(5005,2991.692,-2955.119,23.586,0.0,0.0,0.0);
CreateDynamicObject(5005,3034.818,-2992.917,23.848,0.0,0.0,-180.000);
CreateDynamicObject(5005,3071.736,-2955.128,23.655,0.0,0.0,0.0);
CreateDynamicObject(978,2490.815,-3052.615,21.470,0.0,0.0,-250.079);
CreateDynamicObject(978,2495.541,-3060.059,21.470,0.0,0.0,-225.001);
CreateDynamicObject(978,2502.501,-3065.760,21.470,0.0,0.0,-213.748);
CreateDynamicObject(978,2510.816,-3069.071,21.470,0.0,0.0,-191.248);
CreateDynamicObject(978,2519.597,-3068.166,21.470,0.0,0.0,-157.500);
CreateDynamicObject(978,2527.601,-3064.064,21.421,0.0,0.0,-148.906);
CreateDynamicObject(978,2531.348,-3055.750,21.088,0.0,0.0,-81.406);
CreateDynamicObject(978,2607.513,-3028.088,21.421,0.0,0.0,-182.653);
CreateDynamicObject(978,2599.146,-3027.699,21.441,0.0,0.0,-182.653);
CreateDynamicObject(7416,2592.889,-3025.523,20.420,0.0,0.0,0.0);
CreateDynamicObject(978,2591.873,-3027.418,21.466,0.0,0.0,-182.653);
CreateDynamicObject(615,2728.846,-3009.480,20.444,0.0,0.0,-78.747);
CreateDynamicObject(615,2705.793,-3027.264,20.444,0.0,0.0,-78.747);
CreateDynamicObject(615,2681.787,-3050.094,20.342,0.0,0.0,-78.747);
CreateDynamicObject(5005,3197.796,-2886.690,23.774,0.0,0.0,-67.500);
CreateDynamicObject(5005,3154.501,-2990.709,23.749,0.0,0.0,-355.704);
CreateDynamicObject(5005,3210.894,-2962.562,23.749,0.0,0.0,-321.951);
CreateDynamicObject(5005,3207.996,-2952.260,23.749,0.0,0.0,-292.501);
CreateDynamicObject(7416,2695.553,-3094.544,20.399,0.0,0.0,-180.000);
CreateDynamicObject(7416,2605.377,-3102.434,20.523,0.0,0.0,-180.000);
CreateDynamicObject(3452,2927.669,-2883.502,25.730,0.0,0.0,0.0);
CreateDynamicObject(3452,2957.096,-2883.594,25.767,0.0,0.0,0.0);
CreateDynamicObject(3997,3099.849,-2797.649,19.792,0.0,0.0,0.0);
CreateDynamicObject(978,2730.209,-2951.972,20.932,0.0,0.0,-182.888);
CreateDynamicObject(978,2739.283,-2952.564,20.932,0.0,0.0,-182.888);
CreateDynamicObject(978,2747.882,-2953.773,20.932,0.0,0.0,-193.201);
CreateDynamicObject(978,2756.293,-2956.378,20.920,0.0,0.0,-200.936);
CreateDynamicObject(978,2764.111,-2960.391,21.170,0.0,-357.423,-212.109);
CreateDynamicObject(978,2771.645,-2965.496,21.320,0.0,0.0,-216.406);
CreateDynamicObject(978,2778.550,-2971.256,21.320,0.0,0.0,-223.282);
CreateDynamicObject(978,2784.515,-2977.817,21.401,0.0,0.0,-230.157);
CreateDynamicObject(978,2790.073,-2985.103,21.373,0.0,0.0,-236.173);
CreateDynamicObject(978,2794.348,-2992.720,21.287,0.0,0.0,-247.346);
CreateDynamicObject(978,2797.816,-3000.910,21.162,0.0,0.0,-250.784);
CreateDynamicObject(978,2799.948,-3010.144,21.351,0.0,0.0,-258.519);
CreateDynamicObject(5005,2662.637,-3044.182,24.001,0.0,0.0,-327.188);
CreateDynamicObject(5005,2723.256,-3116.272,24.009,0.0,0.0,-293.435);
CreateDynamicObject(5005,2803.489,-3027.931,24.009,0.0,0.0,-118.671);
CreateDynamicObject(978,2801.783,-3019.003,21.162,0.0,0.0,-262.816);
CreateDynamicObject(978,2802.417,-3027.918,21.162,0.0,0.0,-269.691);
CreateDynamicObject(979,2737.140,-2998.380,21.298,0.0,0.0,0.0);
CreateDynamicObject(979,2745.974,-3000.304,21.298,0.0,0.0,-23.205);
CreateDynamicObject(979,2753.515,-3005.344,21.298,0.0,0.0,-43.831);
CreateDynamicObject(979,2758.595,-3012.819,21.298,0.0,0.0,-67.036);
CreateDynamicObject(979,2760.344,-3021.643,21.290,0.0,0.0,-89.381);
CreateDynamicObject(979,2758.955,-3030.753,21.540,0.0,-2.578,-106.570);
CreateDynamicObject(979,2757.353,-3035.892,21.740,0.0,-2.578,-106.570);
CreateDynamicObject(1309,2426.441,-2909.367,34.035,0.0,0.0,-348.748);
CreateDynamicObject(3864,2792.816,-2829.647,26.460,0.0,0.0,-270.001);
CreateDynamicObject(3864,2746.859,-3009.180,26.555,0.0,0.0,-135.000);
CreateDynamicObject(3864,2779.630,-3127.542,26.357,0.0,0.0,-315.001);
CreateDynamicObject(3864,2866.981,-3180.749,26.374,0.0,0.0,-67.500);
CreateDynamicObject(3864,2843.826,-3039.948,26.270,0.0,0.0,-191.248);
CreateDynamicObject(3877,2721.869,-2837.545,24.653,0.0,0.0,0.0);
CreateDynamicObject(3425,2593.993,-2973.201,46.382,0.0,0.0,-348.748);
CreateDynamicObject(3279,2716.064,-2830.983,11.931,0.0,0.0,0.0);
CreateDynamicObject(1226,3109.422,-2950.743,23.978,0.0,0.0,-270.001);
CreateDynamicObject(1226,3102.184,-2950.492,23.978,0.0,0.0,-270.001);
CreateDynamicObject(1226,3094.666,-2950.070,23.978,0.0,0.0,-270.001);
CreateDynamicObject(1226,3085.249,-2949.615,23.978,0.0,0.0,-270.001);
CreateDynamicObject(1226,3076.953,-2949.378,23.978,0.0,0.0,-270.001);
CreateDynamicObject(1226,3065.394,-2948.749,23.978,0.0,0.0,-270.001);
CreateDynamicObject(1226,3049.673,-2948.831,23.978,0.0,0.0,-270.001);
CreateDynamicObject(8331,2428.224,-2909.468,42.312,0.0,0.0,-146.247);
CreateDynamicObject(8328,2616.968,-2889.703,37.526,0.0,0.0,-45.000);
CreateDynamicObject(978,3158.870,-2953.429,21.012,0.0,0.0,-154.922);
CreateDynamicObject(978,3165.780,-2948.178,21.000,0.0,0.0,-133.281);
CreateDynamicObject(978,3170.535,-2940.599,21.012,0.0,0.0,-110.781);
CreateDynamicObject(978,3172.227,-2931.211,21.125,0.0,0.0,-90.000);
CreateDynamicObject(978,3170.882,-2922.087,21.025,0.0,0.0,-68.434);
CreateDynamicObject(978,3167.667,-2913.773,21.063,0.0,0.0,-68.434);
CreateDynamicObject(978,3164.190,-2905.097,21.063,0.0,0.0,-68.434);
CreateDynamicObject(978,3160.777,-2896.479,21.063,0.0,0.0,-68.434);
CreateDynamicObject(978,3157.280,-2888.093,21.063,0.0,0.0,-66.715);
CreateDynamicObject(978,3152.302,-2880.566,21.063,0.0,0.0,-46.089);
CreateDynamicObject(978,3144.852,-2875.313,21.063,0.0,0.0,-23.589);
CreateDynamicObject(978,3136.009,-2873.375,21.063,0.0,0.0,-1.089);
CreateDynamicObject(979,3145.016,-2837.334,21.063,0.0,0.0,-180.000);
CreateDynamicObject(979,3153.812,-2839.105,21.063,0.0,0.0,-202.500);
CreateDynamicObject(979,3162.225,-2842.577,21.063,0.0,0.0,-202.500);
CreateDynamicObject(979,3170.406,-2846.951,21.063,0.0,0.0,-213.748);
CreateDynamicObject(979,3177.527,-2852.901,21.063,0.0,0.0,-226.639);
CreateDynamicObject(979,3183.931,-2859.667,21.063,0.0,0.0,-226.639);
CreateDynamicObject(5005,2810.452,-3181.280,24.043,0.0,0.0,-0.940);
CreateDynamicObject(5005,2738.380,-3153.598,23.819,0.0,0.0,-57.187);
CreateDynamicObject(5005,2866.936,-3170.846,23.828,0.0,0.0,-158.434);
CreateDynamicObject(5005,2839.627,-3045.262,23.975,0.0,0.0,-248.434);
CreateDynamicObject(978,2763.955,-3122.812,21.482,0.0,0.0,-247.346);
CreateDynamicObject(978,2766.062,-3127.829,21.482,0.0,0.0,-247.420);
CreateDynamicObject(978,2770.064,-3136.038,21.332,0.0,0.0,-242.189);
CreateDynamicObject(978,2776.103,-3142.658,21.332,0.0,0.0,-212.814);
CreateDynamicObject(978,2784.289,-3146.366,21.332,0.0,0.0,-195.545);
CreateDynamicObject(978,2798.183,-3146.432,21.332,0.0,0.0,-173.045);
CreateDynamicObject(978,2807.114,-3144.385,21.266,0.0,0.0,-161.798);
CreateDynamicObject(978,2815.716,-3141.871,21.266,0.0,0.0,-166.095);
CreateDynamicObject(978,2824.617,-3139.944,21.266,0.0,0.0,-169.532);
CreateDynamicObject(978,2833.626,-3138.063,21.266,0.0,0.0,-167.029);
CreateDynamicObject(978,2842.474,-3136.101,21.266,0.0,0.0,-167.814);
CreateDynamicObject(978,2851.173,-3134.248,21.266,0.0,0.0,-168.673);
CreateDynamicObject(978,2859.994,-3131.921,21.266,0.0,0.0,-161.798);
CreateDynamicObject(978,2867.742,-3127.208,21.109,0.0,0.0,-136.719);
CreateDynamicObject(978,2872.829,-3120.540,21.141,0.0,0.0,-116.797);
CreateDynamicObject(978,2876.210,-3112.071,21.234,0.0,0.0,-106.410);
CreateDynamicObject(978,2877.516,-3103.054,21.216,0.0,0.0,-89.926);
CreateDynamicObject(978,2874.910,-3094.550,21.266,0.0,0.0,-56.173);
CreateDynamicObject(978,2868.456,-3088.104,21.266,0.0,0.0,-33.673);
CreateDynamicObject(978,2860.169,-3084.777,21.266,0.0,0.0,-11.173);
CreateDynamicObject(978,2844.993,-3047.194,21.263,0.0,0.0,-117.657);
CreateDynamicObject(978,2849.239,-3039.058,21.258,0.0,0.0,-117.657);
CreateDynamicObject(978,2853.472,-3030.941,21.258,0.0,0.0,-117.657);
CreateDynamicObject(978,2857.774,-3022.751,21.258,0.0,0.0,-117.657);
CreateDynamicObject(978,2862.359,-3015.145,21.258,0.0,0.0,-125.392);
CreateDynamicObject(978,2868.360,-3008.221,21.258,0.0,0.0,-136.645);
CreateDynamicObject(978,2874.886,-3002.049,21.258,0.0,0.0,-136.645);
CreateDynamicObject(978,2881.981,-2996.050,21.258,0.0,0.0,-142.661);
CreateDynamicObject(978,2888.949,-2991.202,21.258,0.0,0.0,-147.892);
CreateDynamicObject(978,2893.853,-2984.236,21.258,0.0,0.0,-102.892);
CreateDynamicObject(3997,3107.410,-2797.708,19.516,0.0,0.0,0.0);
CreateDynamicObject(5005,2924.990,-3107.706,23.977,0.0,0.0,-121.169);
CreateDynamicObject(5005,2915.808,-3106.547,23.977,0.0,0.0,-87.422);
CreateDynamicObject(979,2912.203,-3090.291,21.266,0.0,0.0,-236.248);
CreateDynamicObject(979,2907.260,-3083.018,21.266,0.0,0.0,-236.248);
CreateDynamicObject(979,2900.827,-3076.505,21.266,0.0,0.0,-213.748);
CreateDynamicObject(979,2893.471,-3071.205,21.258,0.0,0.0,-218.045);
CreateDynamicObject(979,2887.438,-3064.599,21.258,0.0,0.0,-237.033);
CreateDynamicObject(979,2884.083,-3056.402,21.258,0.0,0.0,-257.814);
CreateDynamicObject(979,2883.609,-3047.378,21.258,0.0,0.0,-275.157);
CreateDynamicObject(979,2886.107,-3038.783,21.258,0.0,0.0,-297.657);
CreateDynamicObject(979,2891.060,-3031.188,21.258,0.0,0.0,-308.904);
CreateDynamicObject(979,2897.596,-3025.020,21.258,0.0,0.0,-324.455);
CreateDynamicObject(979,2905.036,-3019.719,21.258,0.0,0.0,-324.455);
CreateDynamicObject(979,2912.653,-3014.877,21.258,0.0,0.0,-330.471);
CreateDynamicObject(979,2920.489,-3009.960,21.265,0.0,0.0,-325.314);
CreateDynamicObject(979,2927.967,-3004.690,21.258,0.0,0.0,-324.455);
CreateDynamicObject(979,2935.460,-2999.348,21.258,0.0,0.0,-324.455);
CreateDynamicObject(979,2942.895,-2994.024,21.258,0.0,0.0,-324.455);
CreateDynamicObject(979,2951.140,-2992.019,21.258,0.0,0.0,-7.655);
CreateDynamicObject(7416,2912.216,-3040.425,20.220,0.0,0.0,0.0);
CreateDynamicObject(7416,2911.483,-3130.649,20.187,0.0,0.0,0.0);
CreateDynamicObject(978,2793.333,-3147.003,21.332,0.0,0.0,-173.045);
CreateDynamicObject(979,2458.293,-2905.808,20.830,0.0,0.0,-67.500);
CreateDynamicObject(979,2463.040,-3074.912,21.470,0.0,0.0,-56.247);
CreateDynamicObject(4239,2981.752,-2934.953,39.305,0.0,0.0,-292.501);
CreateDynamicObject(7904,3006.922,-2941.120,39.758,0.0,0.0,-27.731);
CreateDynamicObject(3458,2944.021,-2815.895,21.924,0.0,0.0,-90.000);
CreateDynamicObject(3627,2842.999,-2824.948,29.130,0.0,0.0,-90.000);
CreateDynamicObject(3627,2900.248,-2824.812,29.137,0.0,0.0,-90.000);
CreateDynamicObject(9190,2765.193,-2881.843,34.353,0.0,0.0,-236.248);
CreateDynamicObject(4828,2877.513,-2943.191,36.018,0.0,0.0,-90.000);
CreateDynamicObject(9186,2668.144,-2895.233,39.247,0.0,0.0,-11.247);
CreateDynamicObject(615,2945.272,-3012.527,8.472,0.0,0.0,-123.747);
CreateDynamicObject(615,2934.975,-3025.765,8.714,0.0,0.0,-78.747);
CreateDynamicObject(1309,2439.870,-3058.051,33.021,0.0,0.0,-303.748);
CreateDynamicObject(979,2449.331,-3065.065,42.633,0.0,-90.241,-33.747);
CreateDynamicObject(979,2444.181,-3061.611,42.562,0.0,-90.241,-33.747);
CreateDynamicObject(979,2442.020,-3059.650,42.518,0.0,-90.241,-33.747);
CreateDynamicObject(979,2435.280,-3055.599,42.259,0.0,-90.241,-33.747);
CreateDynamicObject(979,2446.901,-3063.331,38.166,0.0,0.0,-33.747);
CreateDynamicObject(979,2440.224,-3058.320,46.573,0.0,0.0,-60.390);
CreateDynamicObject(979,2440.100,-3058.468,42.550,0.0,0.0,-60.390);
CreateDynamicObject(979,2436.509,-3057.346,42.657,-17.189,-274.057,-50.002);
CreateDynamicObject(979,2433.189,-3054.019,43.249,-39.534,-149.542,-33.747);
CreateDynamicObject(979,2433.272,-3052.735,40.158,-7.735,-211.421,-75.860);
CreateDynamicObject(9186,2604.658,-3123.396,25.068,0.0,0.0,-303.748);
CreateDynamicObject(9187,2588.400,-3131.227,25.076,0.0,0.0,-315.001);
CreateDynamicObject(9189,2616.324,-3109.337,25.068,0.0,0.0,-146.247);
CreateDynamicObject(3864,2900.245,-3053.304,26.317,0.0,0.0,0.0);
CreateDynamicObject(978,2761.695,-3105.105,21.507,0.0,0.0,-288.908);
CreateDynamicObject(978,2761.215,-3113.911,21.482,0.0,0.0,-258.593);
CreateDynamicObject(978,2786.329,-3059.504,21.752,0.0,0.0,-300.155);
CreateDynamicObject(16501,2924.943,-2821.605,25.093,0.0,0.0,0.0);
CreateDynamicObject(16501,2924.936,-2821.604,22.603,0.0,0.0,0.0);
CreateDynamicObject(16501,2924.958,-2828.505,22.453,0.0,0.0,0.0);
CreateDynamicObject(9314,2512.993,-2906.351,21.457,0.0,0.0,-11.247);
CreateDynamicObject(9191,2639.872,-2968.488,51.206,0.0,0.0,-337.501);
CreateDynamicObject(3398,2450.092,-2951.659,34.292,0.0,0.0,-258.748);
CreateDynamicObject(3398,2682.388,-3037.319,34.537,0.0,0.0,-315.001);
CreateDynamicObject(615,2843.513,-3003.162,20.243,0.0,0.0,-78.747);
CreateDynamicObject(615,3020.829,-2899.052,19.804,0.0,0.0,-78.747);
CreateDynamicObject(3877,2727.802,-2834.540,22.071,0.0,0.0,0.0);
CreateDynamicObject(3877,2720.701,-2872.759,20.393,0.0,0.0,0.0);
CreateDynamicObject(4862,-1436.903,-372.634,35.500,0.0,0.0,-22.500);
CreateDynamicObject(978,-1674.573,-210.123,14.040,0.0,0.0,-315.001);
CreateDynamicObject(982,-1246.480,237.279,29.986,0.0,-86.803,-315.001);
CreateDynamicObject(982,-1245.624,238.144,29.986,0.0,-94.538,-315.001);
CreateDynamicObject(984,-1259.484,250.353,29.998,0.0,-85.944,-315.001);
CreateDynamicObject(984,-1258.636,251.230,30.035,0.0,-92.819,-315.001);
CreateDynamicObject(4597,-1258.736,234.110,12.780,0.0,0.0,-45.000);
CreateDynamicObject(4597,-1258.401,234.439,12.805,0.0,0.0,-45.000);
CreateDynamicObject(8322,-1355.073,88.668,35.842,0.0,0.0,-218.904);
CreateDynamicObject(4597,-1258.089,234.780,12.805,0.0,0.0,-45.000);
CreateDynamicObject(982,-1311.287,66.541,19.457,0.0,-91.100,-66.641);
CreateDynamicObject(984,-1325.719,60.323,19.387,0.0,-90.241,-67.500);
CreateDynamicObject(982,-1432.182,24.664,29.986,0.0,-90.241,-277.810);
CreateDynamicObject(982,-1451.981,27.404,30.001,0.0,-90.241,-277.810);
CreateDynamicObject(982,-1421.839,-49.156,13.832,0.0,0.0,0.0);
CreateDynamicObject(982,-1430.914,-70.964,13.832,0.0,0.0,-45.000);
CreateDynamicObject(13612,655.568,-2062.071,3.968,0.0,0.0,-359.141);
CreateDynamicObject(978,708.468,-2034.415,5.419,0.0,0.0,-22.500);
CreateDynamicObject(978,699.733,-2031.358,5.420,0.0,0.0,-16.404);
CreateDynamicObject(978,690.668,-2029.262,5.462,0.0,0.0,-9.534);
CreateDynamicObject(978,681.475,-2028.209,5.537,0.0,0.0,-3.438);
CreateDynamicObject(978,672.727,-2027.904,5.598,0.0,0.0,-0.859);
CreateDynamicObject(978,664.356,-2027.759,5.639,0.0,0.0,-0.859);
CreateDynamicObject(978,655.669,-2027.629,5.679,0.0,0.0,-0.859);
CreateDynamicObject(978,646.361,-2027.687,5.648,0.0,0.0,-358.202);
CreateDynamicObject(978,637.609,-2027.994,5.680,0.0,0.0,-358.202);
CreateDynamicObject(978,628.394,-2028.635,5.666,0.0,0.0,-353.905);
CreateDynamicObject(978,619.156,-2030.174,5.591,0.0,0.0,-346.955);
CreateDynamicObject(978,610.284,-2032.734,5.621,0.0,0.0,-340.939);
CreateDynamicObject(978,602.083,-2036.233,5.475,0.0,0.0,-332.264);
CreateDynamicObject(978,594.634,-2041.134,5.476,0.0,0.0,-321.017);
CreateDynamicObject(978,587.954,-2047.657,5.376,0.0,0.0,-309.764);
CreateDynamicObject(978,583.581,-2055.688,5.235,0.0,0.0,-287.264);
CreateDynamicObject(978,582.653,-2064.711,5.083,0.0,0.0,-264.764);
CreateDynamicObject(978,585.161,-2073.340,4.940,0.0,0.0,-242.264);
CreateDynamicObject(978,590.042,-2080.770,4.849,0.0,0.0,-231.017);
CreateDynamicObject(978,597.019,-2086.638,4.772,0.0,0.0,-208.517);
CreateDynamicObject(978,605.222,-2090.620,4.627,0.0,0.0,-203.280);
CreateDynamicObject(978,613.576,-2093.304,4.584,0.0,0.0,-192.033);
CreateDynamicObject(978,622.265,-2095.224,4.536,0.0,0.0,-192.033);
CreateDynamicObject(978,630.610,-2096.080,4.504,0.0,0.0,-180.780);
CreateDynamicObject(978,639.221,-2096.243,4.498,0.0,0.0,-180.780);
CreateDynamicObject(978,648.235,-2096.377,4.509,0.0,0.0,-180.780);
CreateDynamicObject(978,675.239,-2095.848,4.458,0.0,0.0,-176.482);
CreateDynamicObject(978,683.891,-2095.267,4.430,0.0,0.0,-176.482);
CreateDynamicObject(978,693.001,-2093.781,4.451,0.0,0.0,-165.235);
CreateDynamicObject(978,701.761,-2090.968,4.416,0.0,0.0,-159.139);
CreateDynamicObject(978,710.061,-2086.796,4.470,0.0,0.0,-147.892);
CreateDynamicObject(978,717.775,-2081.973,4.567,0.0,0.0,-147.892);
CreateDynamicObject(978,724.343,-2075.708,4.679,0.0,0.0,-125.392);
CreateDynamicObject(978,728.052,-2067.383,4.763,0.0,0.0,-102.892);
CreateDynamicObject(978,729.080,-2058.695,4.924,0.0,0.0,-91.639);
CreateDynamicObject(978,726.743,-2050.305,5.087,0.0,0.0,-57.892);
CreateDynamicObject(978,721.257,-2043.181,5.240,0.0,0.0,-46.639);
CreateDynamicObject(978,715.027,-2037.731,5.379,0.0,0.0,-35.392);
CreateDynamicObject(3989,667.919,-2129.203,-0.857,0.0,0.0,-269.141);
CreateDynamicObject(987,612.738,-2100.153,3.596,0.0,0.0,-337.501);
CreateDynamicObject(987,610.309,-2111.954,3.596,0.0,0.0,-281.248);
CreateDynamicObject(987,610.389,-2123.868,3.596,0.0,0.0,-270.001);
CreateDynamicObject(987,610.452,-2135.770,3.674,0.0,0.0,-270.001);
CreateDynamicObject(987,610.544,-2147.637,3.768,0.0,0.0,-270.001);
CreateDynamicObject(8150,672.656,-2147.509,6.628,0.0,0.0,0.0);
CreateDynamicObject(987,708.799,-2135.612,3.559,0.0,0.0,-90.000);
CreateDynamicObject(987,708.790,-2123.661,3.560,0.0,0.0,-90.000);
CreateDynamicObject(987,704.146,-2112.642,3.574,0.0,0.0,-67.500);
CreateDynamicObject(987,695.694,-2104.355,3.596,0.0,0.0,-45.000);
CreateDynamicObject(987,687.281,-2095.951,3.596,0.0,0.0,-45.000);
CreateDynamicObject(8041,661.323,-2096.416,9.504,0.0,0.0,-88.281);
CreateDynamicObject(3458,630.567,-2142.936,5.282,0.0,0.0,0.0);
CreateDynamicObject(3458,669.277,-2142.957,5.273,0.0,0.0,0.0);
CreateDynamicObject(11391,634.586,-2140.777,5.034,0.0,0.0,-270.001);
CreateDynamicObject(11393,620.878,-2119.962,5.153,0.0,0.0,-90.000);
CreateDynamicObject(14796,623.551,-2107.704,7.362,0.0,0.0,-180.000);
CreateDynamicObject(14826,615.273,-2128.616,4.382,0.0,0.0,-90.000);
CreateDynamicObject(2714,661.420,-2097.791,5.879,0.0,0.0,0.0);
CreateDynamicObject(2714,661.992,-2097.951,13.371,0.0,0.0,0.0);
CreateDynamicObject(3471,670.296,-2096.717,4.864,0.0,0.0,-90.000);
CreateDynamicObject(3471,652.557,-2097.767,4.864,0.0,0.0,-90.000);
CreateDynamicObject(6986,638.877,-2097.635,7.733,-88.522,-359.141,-266.563);
CreateDynamicObject(14467,673.542,-2103.176,6.326,0.0,0.0,0.0);
CreateDynamicObject(3452,675.599,-2018.508,7.868,0.0,0.0,-180.000);
CreateDynamicObject(3452,646.091,-2018.513,7.862,0.0,0.0,-180.000);
CreateDynamicObject(3452,616.682,-2018.532,7.842,0.0,0.0,-180.000);
CreateDynamicObject(3452,587.149,-2018.541,7.819,0.0,0.0,-180.000);
CreateDynamicObject(3452,705.077,-2018.504,7.906,0.0,0.0,-180.000);
CreateDynamicObject(3453,735.225,-2024.019,7.902,0.0,0.0,-270.001);
CreateDynamicObject(3452,741.600,-2053.287,7.906,0.0,0.0,-270.001);
CreateDynamicObject(3453,736.109,-2083.381,7.903,0.0,0.0,0.0);
CreateDynamicObject(3458,699.808,-2028.217,2.739,0.0,0.0,0.0);
CreateDynamicObject(3458,711.971,-2028.222,2.739,0.0,0.0,0.0);
CreateDynamicObject(3458,719.163,-2031.729,2.720,0.0,0.0,0.0);
CreateDynamicObject(3458,729.275,-2035.401,2.710,0.0,0.0,0.0);
CreateDynamicObject(3458,736.921,-2039.991,2.636,0.0,0.0,0.0);
CreateDynamicObject(3458,742.167,-2044.274,2.634,0.0,0.0,0.0);
CreateDynamicObject(3458,745.701,-2048.360,2.540,0.0,0.0,0.0);
CreateDynamicObject(3458,730.885,-2060.680,2.412,0.0,0.0,-90.000);
CreateDynamicObject(3458,728.980,-2075.423,2.362,0.0,0.0,-125.547);
CreateDynamicObject(978,722.679,-2079.943,4.734,0.0,0.0,-294.139);
CreateDynamicObject(3458,713.760,-2088.100,2.049,0.0,0.0,-136.794);
CreateDynamicObject(3458,712.879,-2092.059,1.678,0.0,0.0,-179.215);
CreateDynamicObject(8648,732.758,-2062.588,4.793,0.0,0.0,-180.000);
CreateDynamicObject(8648,732.714,-2042.908,5.016,0.0,0.0,-180.000);
CreateDynamicObject(8648,712.306,-2027.624,5.120,0.0,0.0,-270.001);
CreateDynamicObject(8648,691.231,-2027.605,5.120,0.0,0.0,-270.001);
CreateDynamicObject(3458,605.995,-2026.045,3.365,0.0,0.0,0.0);
CreateDynamicObject(3453,557.890,-2024.916,7.802,0.0,0.0,-180.000);
CreateDynamicObject(3452,552.578,-2055.052,7.996,0.0,0.0,-90.000);
CreateDynamicObject(3452,552.584,-2084.645,8.052,0.0,0.0,-90.000);
CreateDynamicObject(3453,558.920,-2113.930,7.962,0.0,0.0,-90.000);
CreateDynamicObject(3452,588.740,-2119.458,7.912,0.0,0.0,0.0);
CreateDynamicObject(3458,574.924,-2027.535,3.387,0.0,0.0,0.0);
CreateDynamicObject(3458,597.721,-2027.863,3.390,0.0,0.0,0.0);
CreateDynamicObject(3458,593.228,-2029.169,3.292,0.0,0.0,0.0);
CreateDynamicObject(3458,588.857,-2031.031,3.380,0.0,0.0,0.0);
CreateDynamicObject(3458,579.763,-2031.102,3.355,0.0,0.0,0.0);
CreateDynamicObject(3458,563.113,-2050.321,3.400,0.0,0.0,-270.001);
CreateDynamicObject(3458,567.280,-2050.287,3.392,0.0,0.0,-270.001);
CreateDynamicObject(3458,572.156,-2050.240,3.386,0.0,0.0,-270.001);
CreateDynamicObject(3458,577.215,-2050.319,3.452,0.0,0.0,-270.001);
CreateDynamicObject(3458,563.054,-2090.122,3.346,0.0,0.0,-270.001);
CreateDynamicObject(3458,567.240,-2090.653,3.338,0.0,0.0,-270.001);
CreateDynamicObject(3458,572.188,-2090.586,3.301,0.0,0.0,-270.001);
CreateDynamicObject(3458,577.157,-2090.496,3.457,0.0,0.0,-270.001);
CreateDynamicObject(3458,580.118,-2050.177,3.393,0.0,0.0,-90.000);
CreateDynamicObject(3458,580.187,-2090.623,3.410,0.0,0.0,-90.000);
CreateDynamicObject(3458,582.456,-2093.203,3.403,0.0,0.0,-90.000);
CreateDynamicObject(3458,584.728,-2097.135,3.362,0.0,0.0,-90.000);
CreateDynamicObject(3458,587.401,-2100.396,3.369,0.0,0.0,-90.000);
CreateDynamicObject(3458,589.479,-2102.507,3.337,0.0,0.0,-90.000);
CreateDynamicObject(3458,591.148,-2104.228,3.346,0.0,0.0,-90.000);
CreateDynamicObject(3458,592.592,-2105.404,3.364,0.0,0.0,-90.000);
CreateDynamicObject(3458,593.333,-2106.089,3.288,0.0,0.0,-90.000);
CreateDynamicObject(3458,604.070,-2111.146,3.298,0.0,0.0,-90.000);
CreateDynamicObject(3458,595.826,-2107.317,3.351,0.0,0.0,-90.000);
CreateDynamicObject(3458,599.576,-2109.567,3.313,0.0,0.0,-90.000);
CreateDynamicObject(3458,611.971,-2094.588,1.246,-343.672,-359.141,-181.719);
CreateDynamicObject(979,601.465,-2089.766,4.521,-274.917,0.0,-22.500);
CreateDynamicObject(979,599.455,-2089.391,4.560,-274.917,0.0,-22.500);
CreateDynamicObject(979,595.568,-2086.767,4.369,-274.917,0.0,-22.500);
CreateDynamicObject(979,588.396,-2079.925,4.637,-274.917,0.0,-45.000);
CreateDynamicObject(979,587.193,-2079.590,4.606,-274.917,0.0,-45.000);
CreateDynamicObject(979,585.020,-2074.923,4.269,-279.214,0.0,-67.500);
CreateDynamicObject(979,584.807,-2074.102,4.621,-279.214,0.0,-56.247);
CreateDynamicObject(979,584.356,-2075.205,4.621,-279.214,0.0,-56.247);
CreateDynamicObject(3458,581.691,-2033.094,3.360,0.0,0.0,-90.000);
CreateDynamicObject(3458,583.989,-2029.179,3.320,0.0,0.0,-90.000);
CreateDynamicObject(3458,586.858,-2025.997,3.257,0.0,0.0,-90.000);
CreateDynamicObject(3458,589.122,-2023.663,3.251,0.0,0.0,-90.000);
CreateDynamicObject(3458,591.238,-2021.479,3.235,0.0,0.0,-90.000);
CreateDynamicObject(3458,584.789,-2032.458,3.379,0.0,0.0,0.0);
CreateDynamicObject(3458,581.531,-2033.797,3.283,0.0,0.0,0.0);
CreateDynamicObject(3458,578.993,-2035.022,3.277,0.0,0.0,0.0);
CreateDynamicObject(3458,576.837,-2036.813,3.293,0.0,0.0,0.0);
CreateDynamicObject(3458,606.476,-2114.744,1.785,0.0,0.0,-90.000);
CreateDynamicObject(3268,698.539,-2130.803,3.557,0.0,0.0,0.0);
CreateDynamicObject(955,693.865,-2116.782,3.994,0.0,0.0,0.0);
CreateDynamicObject(3390,706.206,-2120.032,3.564,0.0,0.0,-326.248);
CreateDynamicObject(3393,703.825,-2117.621,3.567,0.0,0.0,-303.748);
CreateDynamicObject(3394,701.190,-2116.914,3.568,0.0,0.0,-270.001);
CreateDynamicObject(16662,706.577,-2133.609,4.753,0.0,0.0,-115.153);
CreateDynamicObject(936,705.803,-2128.450,4.034,0.0,0.0,-57.107);
CreateDynamicObject(936,706.779,-2129.897,4.031,0.0,0.0,-57.107);
CreateDynamicObject(936,707.344,-2131.809,3.954,0.0,0.0,-86.562);
CreateDynamicObject(936,707.418,-2133.586,4.004,0.0,0.0,-88.281);
CreateDynamicObject(936,707.038,-2135.468,4.036,0.0,0.0,-113.360);
CreateDynamicObject(936,706.279,-2137.096,4.040,0.0,0.0,-116.797);
CreateDynamicObject(936,705.114,-2138.644,4.042,0.0,0.0,-139.298);
CreateDynamicObject(936,705.693,-2138.029,4.016,0.0,0.0,-128.045);
CreateDynamicObject(936,708.046,-2134.554,4.021,0.0,0.0,-105.545);
CreateDynamicObject(936,707.320,-2130.833,3.930,0.0,0.0,-83.045);
CreateDynamicObject(1550,698.758,-2117.000,3.970,0.0,0.0,0.0);
CreateDynamicObject(1550,697.747,-2117.066,3.972,0.0,0.0,0.0);
CreateDynamicObject(2690,692.189,-2116.860,3.955,0.0,0.0,0.0);
CreateDynamicObject(2690,691.250,-2116.856,3.956,0.0,0.0,0.0);
CreateDynamicObject(3524,652.723,-2096.637,9.002,0.0,0.0,0.0);
CreateDynamicObject(3524,670.372,-2096.229,9.010,0.0,0.0,0.0);
CreateDynamicObject(3864,702.783,-2092.780,9.303,0.0,0.0,-56.247);
CreateDynamicObject(3864,724.576,-2035.541,10.335,0.0,0.0,-315.001);
CreateDynamicObject(3864,590.550,-2036.538,10.919,0.0,0.0,-225.001);
CreateDynamicObject(3864,593.077,-2088.027,10.990,0.0,0.0,-123.747);
CreateDynamicObject(11417,626.236,-2099.239,8.470,0.0,0.0,-315.001);
CreateDynamicObject(16782,702.783,-2145.896,4.612,0.0,0.0,-270.001);
CreateDynamicObject(16782,644.977,-2098.646,4.783,0.0,0.0,-90.000);
CreateDynamicObject(1571,683.538,-2143.082,4.767,0.0,0.0,-180.000);
CreateDynamicObject(1571,676.654,-2143.063,4.785,0.0,0.0,-180.000);
CreateDynamicObject(3279,603.947,-2131.313,3.302,0.0,0.0,-270.001);
CreateDynamicObject(16644,604.627,-2117.058,19.857,0.0,0.0,-90.000);
CreateDynamicObject(16644,604.630,-2099.987,19.753,0.0,0.0,-90.000);
CreateDynamicObject(16644,604.671,-2082.931,19.707,0.0,0.0,-90.000);
CreateDynamicObject(16644,604.698,-2067.303,19.706,0.0,0.0,-90.000);
CreateDynamicObject(16644,604.744,-2050.421,19.666,0.0,0.0,-90.000);
CreateDynamicObject(16644,604.763,-2034.100,19.683,0.0,0.0,-90.000);
CreateDynamicObject(16644,604.817,-2019.165,13.145,0.0,-41.253,-90.000);
CreateDynamicObject(4853,2726.863,1835.499,8.638,0.0,0.0,0.0);
CreateDynamicObject(3578,2736.050,1982.287,6.512,0.0,0.0,-90.000);
CreateDynamicObject(3578,1428.839,2441.746,6.567,0.0,0.0,-371.248);
CreateDynamicObject(3578,1412.078,2444.267,6.601,0.0,0.0,-371.248);
CreateDynamicObject(3578,1376.766,2475.116,6.519,0.0,0.0,-348.748);
CreateDynamicObject(3578,1355.682,2469.666,6.512,0.0,0.0,-337.501);
CreateDynamicObject(3578,1235.421,2162.451,6.548,0.0,0.0,-438.748);
CreateDynamicObject(3578,1233.493,2178.089,6.512,0.0,0.0,-450.001);
CreateDynamicObject(3578,1202.601,2289.398,6.533,0.0,0.0,-292.501);
CreateDynamicObject(3578,1207.140,2307.615,6.525,0.0,0.0,-292.501);
CreateDynamicObject(3578,1234.460,1947.932,6.512,0.0,0.0,-281.248);
CreateDynamicObject(3578,1233.661,1933.741,6.510,0.0,0.0,-270.001);
CreateDynamicObject(3578,1200.647,1956.100,6.520,0.0,0.0,-270.001);
CreateDynamicObject(3578,1201.311,1943.139,6.512,0.0,0.0,-270.001);
CreateDynamicObject(3578,1235.206,1700.801,6.460,0.0,0.0,-281.248);
CreateDynamicObject(3578,1234.013,1683.038,6.512,0.0,0.0,-281.248);
CreateDynamicObject(3578,1199.438,1699.726,6.457,0.0,0.0,-270.001);
CreateDynamicObject(3578,1198.175,1678.422,6.512,0.0,0.0,-270.001);
CreateDynamicObject(3578,1235.551,1149.178,5.873,0.0,0.0,-270.001);
CreateDynamicObject(3578,1236.879,1127.692,6.591,0.0,0.0,-270.001);
CreateDynamicObject(3578,1202.977,1015.067,6.603,0.0,0.0,-258.748);
CreateDynamicObject(3578,1206.171,999.609,6.621,0.0,0.0,-258.748);
CreateDynamicObject(3578,1354.453,832.599,6.601,0.0,0.0,-225.001);
CreateDynamicObject(3578,2160.878,862.209,6.512,0.0,0.0,-371.248);
CreateDynamicObject(3578,2168.228,821.244,6.483,0.0,0.0,-348.748);
CreateDynamicObject(3578,2419.377,859.982,6.512,0.0,0.0,0.0);
CreateDynamicObject(3578,2401.385,859.682,6.489,0.0,0.0,0.0);
CreateDynamicObject(3578,2428.762,825.570,6.512,0.0,0.0,0.0);
CreateDynamicObject(3578,2404.533,825.793,6.485,0.0,0.0,0.0);
CreateDynamicObject(3578,2699.227,1338.297,6.517,0.0,0.0,-270.001);
CreateDynamicObject(3578,2698.748,1355.247,6.485,0.0,0.0,-270.001);
CreateDynamicObject(3578,2738.119,1359.346,6.454,0.0,0.0,-270.001);
CreateDynamicObject(3578,2737.879,1342.046,6.512,0.0,0.0,-270.001);
CreateDynamicObject(3578,2700.306,1606.161,6.520,0.0,0.0,-270.001);
CreateDynamicObject(3578,2698.885,1587.370,6.463,0.0,0.0,-270.001);
CreateDynamicObject(3578,2735.122,1611.708,6.512,0.0,0.0,-270.001);
CreateDynamicObject(3578,2735.948,1586.376,6.457,0.0,0.0,-247.501);
CreateDynamicObject(3578,2698.885,1986.296,6.520,0.0,0.0,-281.248);
CreateDynamicObject(3578,2700.547,2249.208,6.520,0.0,0.0,-270.001);
CreateDynamicObject(3578,2701.088,2230.176,6.488,0.0,0.0,-270.001);
CreateDynamicObject(3578,2734.957,2257.106,6.512,0.0,0.0,-270.001);
CreateDynamicObject(3578,2734.812,2225.728,6.471,0.0,0.0,-270.001);
CreateDynamicObject(3578,1643.081,2447.766,6.825,0.0,0.0,-180.000);
CreateDynamicObject(3578,1670.918,2446.998,6.760,0.0,0.0,0.0);
CreateDynamicObject(3578,1527.286,2479.340,6.562,0.0,0.0,0.0);
CreateDynamicObject(3578,1421.026,866.104,6.592,0.0,0.0,-348.748);
CreateDynamicObject(3330,245.193,-1863.010,66.035,0.0,0.0,0.0);
CreateDynamicObject(3330,237.855,-1790.612,68.246,0.0,0.0,0.0);
CreateDynamicObject(3330,221.452,-1797.741,68.334,0.0,0.0,-315.001);
CreateDynamicObject(3330,211.607,-1813.938,68.323,0.0,0.0,-281.248);
CreateDynamicObject(3330,211.062,-1836.931,67.624,0.0,0.0,-258.748);
CreateDynamicObject(3330,222.938,-1856.332,67.056,0.0,0.0,-213.748);
CreateDynamicObject(3330,266.957,-1860.406,66.880,0.0,0.0,-348.748);
CreateDynamicObject(3330,254.967,-1791.308,68.222,0.0,0.0,0.0);
CreateDynamicObject(3330,271.928,-1791.588,68.305,0.0,0.0,0.0);
CreateDynamicObject(3330,288.741,-1855.640,67.043,0.0,0.0,-348.748);
CreateDynamicObject(3330,291.260,-1793.860,68.328,0.0,0.0,-371.248);
CreateDynamicObject(3330,303.404,-1807.425,68.346,0.0,0.0,-450.001);
CreateDynamicObject(3330,308.209,-1828.063,67.867,0.0,0.0,-427.501);
CreateDynamicObject(3330,305.320,-1846.852,67.327,0.0,0.0,-495.001);
CreateDynamicObject(3330,214.736,-1846.947,67.329,0.0,0.0,-416.248);
CreateDynamicObject(3330,304.648,-1837.132,67.609,0.0,0.0,-450.001);
CreateDynamicObject(972,280.537,-1842.291,2.506,0.0,0.0,0.0);
CreateDynamicObject(3866,283.607,-1812.676,11.148,0.0,0.0,-450.001);
CreateDynamicObject(619,268.911,-1801.018,3.352,0.0,0.0,-348.748);
CreateDynamicObject(1225,262.738,-1846.403,2.734,0.0,0.0,0.0);
CreateDynamicObject(1225,234.231,-1831.887,3.114,0.0,0.0,0.0);
CreateDynamicObject(2780,243.788,-1795.726,17.144,0.0,0.0,0.0);
CreateDynamicObject(2780,246.269,-1857.247,17.415,0.0,0.0,0.0);
CreateDynamicObject(2780,218.847,-1845.776,46.826,0.0,0.0,0.0);
CreateDynamicObject(2780,301.587,-1838.616,50.880,0.0,0.0,0.0);
CreateDynamicObject(2780,286.084,-1795.227,32.276,0.0,0.0,0.0);
CreateDynamicObject(3425,235.148,-1837.564,13.778,0.0,0.0,-382.501);
CreateDynamicObject(3374,227.520,-1838.598,4.076,0.0,0.0,0.0);
CreateDynamicObject(3524,259.410,-1805.595,6.290,0.0,0.0,0.0);
CreateDynamicObject(3361,270.648,-1838.248,4.523,0.0,0.0,-540.001);
CreateDynamicObject(3361,278.124,-1838.249,8.441,0.0,0.0,-540.001);
CreateDynamicObject(5822,293.177,-1842.161,17.606,0.0,0.0,-444.764);
CreateDynamicObject(982,282.039,-1846.350,22.927,0.0,-268.901,-450.001);
CreateDynamicObject(3279,272.265,-1842.771,22.654,0.0,0.0,0.0);
CreateDynamicObject(3361,240.833,-1819.554,5.132,0.0,0.0,-697.502);
CreateDynamicObject(5822,223.928,-1822.351,14.783,0.0,0.0,-242.264);
CreateDynamicObject(5822,234.647,-1817.182,28.039,0.0,0.0,-422.264);
CreateDynamicObject(982,226.502,-1825.198,32.935,-358.282,-269.760,-427.501);
CreateDynamicObject(3458,213.399,-1829.183,31.217,0.0,0.0,-371.248);
CreateDynamicObject(3458,245.923,-1835.652,31.217,0.0,0.0,-551.248);
CreateDynamicObject(11292,250.679,-1840.376,34.209,0.0,0.0,-191.248);
CreateDynamicObject(11292,250.751,-1840.179,37.261,0.0,0.0,-191.248);
CreateDynamicObject(5822,269.081,-1825.085,40.620,0.0,0.0,-366.017);
CreateDynamicObject(5822,267.891,-1837.111,54.001,0.0,0.0,-544.298);
CreateDynamicObject(3458,264.630,-1817.134,58.078,0.0,-360.860,-636.092);
CreateDynamicObject(5822,270.905,-1799.472,67.187,0.0,0.0,-361.720);
CreateDynamicObject(5822,270.074,-1811.404,80.418,0.0,0.0,-541.720);
CreateDynamicObject(982,267.705,-1801.868,85.332,-358.282,-269.760,-551.248);
CreateDynamicObject(3361,275.018,-1792.113,82.930,0.0,0.0,-726.877);
CreateDynamicObject(3361,277.821,-1792.480,80.931,0.0,0.0,-726.877);
CreateDynamicObject(3330,285.605,-1794.849,68.626,0.0,0.0,0.0);
CreateDynamicObject(3330,278.269,-1789.113,76.831,-271.479,0.0,0.0);
CreateDynamicObject(3330,265.040,-1773.820,141.869,0.0,0.0,-272.653);
CreateDynamicObject(3330,321.069,-1774.675,140.054,0.0,0.0,-273.513);
CreateDynamicObject(3330,290.132,-1789.041,77.003,-271.479,0.0,0.0);
CreateDynamicObject(3330,307.464,-1789.195,77.054,-271.479,0.0,0.0);
CreateDynamicObject(3330,297.112,-1688.135,107.341,-303.278,0.0,-183.513);
CreateDynamicObject(3330,265.898,-1751.299,144.629,0.0,0.0,-272.653);
CreateDynamicObject(3330,321.941,-1752.703,144.922,0.0,0.0,-272.653);
CreateDynamicObject(3330,318.253,-1730.912,145.146,0.0,0.0,-227.653);
CreateDynamicObject(3330,274.513,-1731.619,144.813,0.0,0.0,-126.406);
CreateDynamicObject(5822,278.296,-1764.229,87.468,0.0,0.0,-350.467);
CreateDynamicObject(3458,284.571,-1778.345,91.021,0.0,-360.860,-627.498);
CreateDynamicObject(3458,293.580,-1813.797,90.459,0.0,-360.860,-604.998);
CreateDynamicObject(11292,295.116,-1825.617,93.026,0.0,0.0,-242.344);
CreateDynamicObject(11292,301.823,-1822.989,93.112,0.0,0.0,-62.344);
CreateDynamicObject(11292,298.926,-1830.288,93.163,0.0,0.0,-152.344);
CreateDynamicObject(3330,297.463,-1686.009,130.106,-240.539,0.0,-183.513);
CreateDynamicObject(3330,297.590,-1686.253,172.291,0.0,0.0,-182.653);
CreateDynamicObject(3330,294.455,-1737.375,219.635,0.0,0.0,-182.653);
CreateDynamicObject(3330,290.237,-1737.344,227.109,0.0,-271.479,-182.653);
CreateDynamicObject(3330,290.393,-1740.692,166.906,0.0,-271.479,-182.653);
CreateDynamicObject(3330,309.109,-1710.282,143.858,0.0,0.0,-261.406);
CreateDynamicObject(3330,308.742,-1694.198,162.605,0.0,0.0,-272.653);
CreateDynamicObject(3330,262.602,-1698.342,108.739,-303.278,0.0,-104.765);
CreateDynamicObject(3458,235.128,-1691.239,113.999,-359.141,-365.157,-559.997);
CreateDynamicObject(3458,219.123,-1682.802,115.561,-359.141,-365.157,-627.498);
CreateDynamicObject(3458,219.999,-1669.125,116.765,-353.985,-361.720,-706.251);
CreateDynamicObject(3458,245.407,-1672.508,120.386,-353.985,-378.049,-762.498);
CreateDynamicObject(3458,270.119,-1689.111,130.089,-362.579,-378.049,-739.998);
CreateDynamicObject(3458,282.765,-1693.528,135.546,-362.579,-393.519,-739.998);
CreateDynamicObject(3458,279.797,-1692.496,134.055,-362.579,-388.362,-739.998);
CreateDynamicObject(3458,300.101,-1699.189,145.540,-362.579,-359.141,-818.751);
CreateDynamicObject(3458,303.669,-1698.570,145.400,-362.579,-359.141,-818.751);
CreateDynamicObject(3458,308.971,-1727.006,159.097,-323.905,-353.125,-897.498);
CreateDynamicObject(3458,320.932,-1722.309,159.130,-347.109,-353.125,-807.498);
CreateDynamicObject(3330,220.118,-1759.345,109.829,-268.901,0.0,-359.141);
CreateDynamicObject(3330,203.040,-1754.698,110.169,-268.901,0.0,-449.142);
CreateDynamicObject(3330,181.512,-1753.776,109.511,-270.619,0.0,-449.142);
CreateDynamicObject(3458,198.335,-1721.824,113.972,-359.141,-365.157,-537.497);
CreateDynamicObject(3458,318.933,-1705.029,163.892,-351.406,-333.358,-807.498);
CreateDynamicObject(3458,319.208,-1708.912,163.458,-349.688,-341.093,-807.498);
CreateDynamicObject(3330,316.548,-1687.781,166.027,-323.905,-580.017,-523.053);
CreateDynamicObject(3330,315.825,-1677.725,172.938,-274.057,0.0,-272.653);
CreateDynamicObject(3458,314.345,-1692.871,168.898,-353.985,-333.358,-706.251);
CreateDynamicObject(3458,298.810,-1696.466,176.956,-385.784,-338.515,-773.751);
CreateDynamicObject(3458,296.434,-1686.393,181.792,-368.595,-317.888,-807.269);
CreateDynamicObject(3458,278.667,-1705.093,179.313,-359.141,-365.157,-526.250);
CreateDynamicObject(3458,276.835,-1687.656,166.709,-354.844,-321.326,-614.606);
CreateDynamicObject(3458,276.906,-1686.504,171.065,-354.844,-336.796,-614.606);
CreateDynamicObject(3458,277.302,-1687.403,173.057,-354.844,-347.109,-614.606);
CreateDynamicObject(11292,259.448,-1662.673,174.802,0.0,0.0,-270.935);
CreateDynamicObject(11292,281.751,-1664.057,175.530,0.0,-361.720,-364.372);
CreateDynamicObject(3330,154.175,-1753.446,121.610,-292.965,0.0,-449.142);
CreateDynamicObject(3330,165.067,-1753.835,116.945,-286.949,0.0,-449.142);
CreateDynamicObject(3458,249.774,-1836.454,31.267,0.0,0.0,-551.248);
CreateDynamicObject(3458,188.990,-1737.689,112.024,-347.969,-365.157,-638.751);
CreateDynamicObject(3458,183.069,-1726.490,114.295,-386.643,-365.157,-540.076);
CreateDynamicObject(979,1452.733,1743.815,10.661,0.0,0.0,-199.922);
CreateDynamicObject(979,1444.065,1746.170,10.661,0.0,0.0,-191.248);
CreateDynamicObject(979,1434.809,1747.165,10.661,0.0,0.0,-180.000);
CreateDynamicObject(979,1426.076,1746.273,10.661,0.0,0.0,-168.748);
CreateDynamicObject(979,1417.153,1743.618,10.661,0.0,0.0,-157.500);
CreateDynamicObject(979,1408.944,1739.199,10.661,0.0,0.0,-146.247);
CreateDynamicObject(979,1382.891,1714.306,10.661,0.0,0.0,-123.747);
CreateDynamicObject(979,1401.451,1734.056,10.661,0.0,0.0,-144.529);
CreateDynamicObject(979,1394.817,1728.005,10.661,0.0,0.0,-130.623);
CreateDynamicObject(979,1388.577,1721.304,10.661,0.0,0.0,-135.000);
CreateDynamicObject(978,1461.963,1692.184,10.653,0.0,0.0,-95.157);
CreateDynamicObject(978,1459.766,1700.740,10.653,0.0,0.0,-56.247);
CreateDynamicObject(978,1453.910,1707.682,10.661,0.0,0.0,-45.000);
CreateDynamicObject(17019,1364.168,1679.626,15.818,0.0,0.0,-90.000);
CreateDynamicObject(17019,1385.503,1651.123,15.811,0.0,0.0,-30.309);
CreateDynamicObject(17019,1407.193,1626.176,15.811,0.0,0.0,-270.935);
CreateDynamicObject(17019,1385.791,1574.589,15.811,0.0,0.0,-180.000);
CreateDynamicObject(979,1376.856,1659.135,10.661,0.0,0.0,-31.169);
CreateDynamicObject(979,1416.509,1594.465,10.661,0.0,0.0,-89.141);
CreateDynamicObject(979,1414.788,1585.463,10.661,0.0,0.0,-112.426);
CreateDynamicObject(979,1377.868,1706.799,10.661,0.0,0.0,-123.747);
CreateDynamicObject(982,1447.124,1665.067,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1447.056,1639.747,10.497,0.0,0.0,0.0);
CreateDynamicObject(982,1447.018,1614.231,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1447.010,1588.779,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1446.995,1563.179,10.497,0.0,0.0,0.0);
CreateDynamicObject(982,1446.969,1541.021,10.504,0.0,0.0,0.0);
CreateDynamicObject(17019,1425.038,1525.569,15.818,0.0,0.0,-146.247);
CreateDynamicObject(978,1446.834,1597.916,10.661,0.0,0.0,-270.001);
CreateDynamicObject(5005,1372.306,1488.665,13.372,0.0,0.0,-90.000);
CreateDynamicObject(979,1404.258,1457.216,10.661,0.0,0.0,-90.000);
CreateDynamicObject(17019,1448.223,1420.302,15.818,0.0,0.0,-270.001);
CreateDynamicObject(17019,1448.123,1420.370,23.539,0.0,0.0,-270.001);
CreateDynamicObject(17019,1392.883,1420.550,15.818,0.0,0.0,-270.001);
CreateDynamicObject(17019,1392.843,1420.604,22.693,0.0,0.0,-270.001);
CreateDynamicObject(13630,1444.390,1754.825,22.524,0.0,0.0,-67.500);
CreateDynamicObject(10815,1441.083,1305.939,9.987,0.0,0.0,-315.001);
CreateDynamicObject(5005,1345.678,1474.122,13.372,0.0,0.0,0.0);
CreateDynamicObject(5005,1457.179,1344.582,12.989,0.0,0.0,-270.001);
CreateDynamicObject(979,1378.336,1393.224,10.661,0.0,0.0,-180.000);
CreateDynamicObject(979,1371.218,1396.849,10.661,0.0,0.0,-231.567);
CreateDynamicObject(978,1342.464,1398.010,10.661,0.0,0.0,-90.000);
CreateDynamicObject(978,1342.450,1404.410,10.653,0.0,0.0,-90.000);
CreateDynamicObject(978,1342.434,1413.573,10.661,0.0,0.0,-90.000);
CreateDynamicObject(978,1342.434,1422.680,10.661,0.0,0.0,-90.000);
CreateDynamicObject(978,1342.445,1431.794,10.661,0.0,0.0,-90.000);
CreateDynamicObject(978,1339.939,1440.356,10.661,0.0,0.0,-58.201);
CreateDynamicObject(978,1332.967,1445.289,10.661,0.0,0.0,-13.201);
CreateDynamicObject(978,1324.118,1446.544,10.661,0.0,0.0,-3.747);
CreateDynamicObject(978,1314.832,1446.863,10.661,0.0,0.0,-0.309);
CreateDynamicObject(978,1305.631,1446.907,10.661,0.0,0.0,-0.309);
CreateDynamicObject(978,1296.455,1446.955,10.661,0.0,0.0,-0.309);
CreateDynamicObject(978,1288.592,1443.720,10.653,0.0,0.0,-315.310);
CreateDynamicObject(978,1285.337,1435.817,10.661,0.0,0.0,-270.310);
CreateDynamicObject(978,1285.311,1426.486,10.661,0.0,0.0,-270.310);
CreateDynamicObject(978,1285.284,1417.252,10.661,0.0,0.0,-270.310);
CreateDynamicObject(978,1285.244,1407.926,10.661,0.0,0.0,-270.310);
CreateDynamicObject(978,1289.862,1403.389,10.661,0.0,0.0,-180.310);
CreateDynamicObject(978,1299.097,1403.354,10.661,0.0,0.0,-180.310);
CreateDynamicObject(978,1306.957,1399.979,10.661,0.0,0.0,-225.310);
CreateDynamicObject(978,1311.950,1392.429,10.661,0.0,0.0,-247.810);
CreateDynamicObject(978,1314.921,1384.568,10.661,0.0,0.0,-250.463);
CreateDynamicObject(978,1438.520,1388.543,10.661,0.0,0.0,-270.310);
CreateDynamicObject(978,1437.157,1379.844,10.661,0.0,0.0,-287.499);
CreateDynamicObject(978,1431.684,1373.441,10.661,0.0,0.0,-332.499);
CreateDynamicObject(982,1414.711,1371.303,10.497,0.0,0.0,-90.000);
CreateDynamicObject(982,1389.126,1371.327,10.504,0.0,0.0,-90.000);
CreateDynamicObject(982,1364.501,1376.233,10.504,0.0,0.0,-112.500);
CreateDynamicObject(978,1351.233,1382.658,10.661,0.0,0.0,-39.843);
CreateDynamicObject(978,1345.071,1389.447,10.661,0.0,0.0,-56.247);
CreateDynamicObject(978,1393.131,1371.418,10.661,0.0,0.0,0.0);
CreateDynamicObject(978,1413.814,1371.380,10.653,0.0,0.0,0.0);
CreateDynamicObject(979,1369.795,1404.861,10.661,0.0,0.0,-287.820);
CreateDynamicObject(982,1327.063,1373.167,10.504,0.0,0.0,-303.748);
CreateDynamicObject(982,1350.250,1363.544,10.504,0.0,0.0,-281.248);
CreateDynamicObject(982,1375.314,1358.529,10.504,0.0,0.0,-281.248);
CreateDynamicObject(982,1396.240,1346.542,10.504,0.0,0.0,-318.593);
CreateDynamicObject(982,1301.073,1364.813,10.504,0.0,0.0,-134.215);
CreateDynamicObject(982,1409.786,1325.258,10.504,0.0,0.0,-336.716);
CreateDynamicObject(982,1414.974,1300.728,10.504,0.0,0.0,-359.216);
CreateDynamicObject(982,1415.227,1282.325,10.504,0.0,0.0,-359.216);
CreateDynamicObject(982,1402.606,1269.372,10.504,0.0,0.0,-89.215);
CreateDynamicObject(982,1377.001,1269.020,10.504,0.0,0.0,-89.215);
CreateDynamicObject(982,1351.484,1270.809,10.504,0.0,0.0,-98.824);
CreateDynamicObject(982,1326.303,1274.689,10.504,0.0,0.0,-98.824);
CreateDynamicObject(978,1359.729,1361.684,10.653,0.0,0.0,-191.557);
CreateDynamicObject(978,1399.539,1342.683,10.661,0.0,0.0,-227.888);
CreateDynamicObject(978,1414.784,1308.790,10.661,0.0,0.0,-268.591);
CreateDynamicObject(978,1407.196,1269.496,10.661,0.0,0.0,-359.451);
CreateDynamicObject(978,1382.246,1269.110,10.661,0.0,0.0,-359.451);
CreateDynamicObject(978,1310.356,1279.770,10.661,0.0,0.0,-44.450);
CreateDynamicObject(978,1306.973,1287.730,10.661,0.0,0.0,-89.450);
CreateDynamicObject(978,1306.880,1296.930,10.661,0.0,0.0,-89.450);
CreateDynamicObject(978,1306.813,1306.228,10.661,0.0,0.0,-89.450);
CreateDynamicObject(978,1311.060,1312.802,10.661,0.0,0.0,-156.950);
CreateDynamicObject(978,1320.027,1315.289,10.661,0.0,0.0,-170.856);
CreateDynamicObject(978,1341.665,1316.972,13.913,0.0,-350.547,-180.384);
CreateDynamicObject(3458,1504.432,1572.977,11.342,0.0,0.0,-270.001);
CreateDynamicObject(3458,1504.435,1613.220,11.342,0.0,0.0,-270.001);
CreateDynamicObject(3458,1504.446,1653.425,11.342,0.0,0.0,-270.001);
CreateDynamicObject(979,1404.221,1468.921,10.661,0.0,0.0,-90.000);
CreateDynamicObject(982,1319.189,1346.863,10.504,0.0,0.0,-315.001);
CreateDynamicObject(982,1338.765,1330.777,10.504,0.0,0.0,-303.748);
CreateDynamicObject(982,1361.395,1319.127,10.504,0.0,0.0,-290.702);
CreateDynamicObject(979,1315.090,1351.034,10.661,0.0,0.0,-45.000);
CreateDynamicObject(979,1334.343,1333.798,10.661,0.0,0.0,-33.747);
CreateDynamicObject(979,1374.003,1316.374,10.661,0.0,0.0,-360.001);
CreateDynamicObject(979,1262.026,1373.498,10.653,0.0,0.0,-360.001);
CreateDynamicObject(17019,1439.008,1259.300,15.818,0.0,0.0,-270.001);
CreateDynamicObject(978,1326.122,1274.755,10.661,0.0,0.0,-8.978);
CreateDynamicObject(1681,1438.515,1342.243,12.798,0.0,0.0,-90.000);
CreateDynamicObject(3864,1419.358,1366.782,15.917,0.0,0.0,-90.000);
CreateDynamicObject(3864,1451.623,1557.291,15.917,0.0,0.0,-180.000);
CreateDynamicObject(3864,1452.514,1590.783,15.910,0.0,0.0,-180.000);
CreateDynamicObject(3864,1452.776,1629.429,15.910,0.0,0.0,-180.000);
CreateDynamicObject(3864,1318.597,1333.536,15.820,0.0,0.0,-146.247);
CreateDynamicObject(3864,1319.262,1329.211,15.917,0.0,0.0,-247.501);
CreateDynamicObject(3877,1457.128,1584.985,11.479,0.0,0.0,0.0);
CreateDynamicObject(3877,1497.119,1584.743,11.478,0.0,0.0,0.0);
CreateDynamicObject(13667,1505.815,1697.590,25.709,0.0,0.0,-101.247);
CreateDynamicObject(1217,1461.858,1586.202,10.234,0.0,0.0,0.0);
CreateDynamicObject(1217,1492.838,1587.037,10.234,0.0,0.0,0.0);
CreateDynamicObject(1257,1497.202,1530.563,11.102,0.0,0.0,0.0);
CreateDynamicObject(1262,1497.041,1584.801,12.858,0.0,0.0,-191.248);
CreateDynamicObject(1284,1488.644,1584.518,13.041,0.0,0.0,0.0);
CreateDynamicObject(1284,1466.604,1585.078,13.041,0.0,0.0,-180.000);
CreateDynamicObject(3279,1452.750,1582.950,6.214,0.0,0.0,-90.000);
CreateDynamicObject(9766,1413.385,1578.548,19.331,-358.282,0.0,-83.829);
CreateDynamicObject(982,1463.509,1320.605,18.866,0.0,0.0,-270.001);
CreateDynamicObject(982,1488.073,1320.641,18.555,-358.282,-359.141,-270.001);
CreateDynamicObject(982,1449.115,1290.671,19.051,0.0,-359.141,-270.001);
CreateDynamicObject(982,1474.753,1290.526,18.923,0.0,-359.141,-270.001);
CreateDynamicObject(982,1538.443,1295.023,13.763,-353.125,-359.141,-270.001);
CreateDynamicObject(982,1511.382,1294.959,16.584,-354.844,-359.141,-270.001);
CreateDynamicObject(982,1570.191,1316.511,10.546,0.0,0.0,-90.000);
CreateDynamicObject(982,1582.965,1303.725,10.534,0.0,0.0,0.0);
CreateDynamicObject(982,1582.937,1278.163,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1570.143,1265.364,10.496,0.0,0.0,-90.000);
CreateDynamicObject(982,1544.658,1265.443,10.496,0.0,0.0,-90.000);
CreateDynamicObject(982,1497.977,1286.152,10.525,0.0,0.0,0.0);
CreateDynamicObject(982,1497.965,1260.571,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1535.121,1265.462,10.496,0.0,0.0,-270.001);
CreateDynamicObject(982,1522.402,1252.793,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1522.393,1227.180,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1509.613,1214.320,10.496,0.0,0.0,-90.000);
CreateDynamicObject(982,1484.141,1214.339,10.504,0.0,0.0,-90.000);
CreateDynamicObject(982,1462.352,1223.376,10.504,0.0,0.0,-135.000);
CreateDynamicObject(8330,1477.718,1289.298,18.178,-340.234,0.0,0.0);
CreateDynamicObject(8329,1445.503,1430.332,33.471,0.0,0.0,-202.500);
CreateDynamicObject(10789,1517.004,1516.841,12.361,0.0,0.0,-90.000);
CreateDynamicObject(978,1582.698,1308.474,10.691,0.0,0.0,-270.001);
CreateDynamicObject(978,1571.518,1265.505,10.653,0.0,0.0,0.0);
CreateDynamicObject(978,1505.997,1214.497,10.653,0.0,0.0,0.0);
CreateDynamicObject(978,1462.129,1223.788,10.661,0.0,0.0,-45.000);
CreateDynamicObject(978,1547.450,1265.436,10.653,0.0,0.0,-360.001);
CreateDynamicObject(979,1498.459,1284.659,10.674,0.0,0.0,-90.000);
CreateDynamicObject(979,1497.979,1245.692,10.653,0.0,0.0,-90.000);
CreateDynamicObject(979,1492.919,1292.689,18.685,0.0,-358.282,-335.077);
CreateDynamicObject(982,1497.989,1254.209,10.538,0.0,0.0,0.0);
CreateDynamicObject(978,1446.330,1712.731,10.661,0.0,0.0,-22.500);
CreateDynamicObject(978,1437.387,1715.057,10.661,0.0,0.0,-6.875);
CreateDynamicObject(978,1428.133,1714.978,10.661,0.0,0.0,-352.186);
CreateDynamicObject(978,1419.575,1711.977,10.661,0.0,0.0,-329.686);
CreateDynamicObject(978,1412.494,1706.178,10.661,0.0,0.0,-311.563);
CreateDynamicObject(978,1407.857,1698.274,10.686,0.0,0.0,-289.218);
CreateDynamicObject(978,1446.901,1661.183,10.661,0.0,-0.859,-270.075);
CreateDynamicObject(982,1459.392,1548.152,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1459.407,1573.711,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1459.417,1599.173,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1459.455,1624.706,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1459.444,1650.274,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1460.599,1675.811,10.496,0.0,0.0,-5.231);
CreateDynamicObject(982,1459.332,1522.687,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1459.361,1497.151,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1459.366,1471.604,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1456.871,1446.279,10.515,0.0,0.0,-11.247);
CreateDynamicObject(982,1448.736,1518.050,10.504,0.0,0.0,-303.748);
CreateDynamicObject(982,1468.431,1740.282,10.496,0.0,0.0,-281.248);
CreateDynamicObject(982,1488.081,1727.225,10.496,0.0,0.0,-326.248);
CreateDynamicObject(982,1496.734,1701.338,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1495.557,1589.192,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1495.536,1614.753,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1495.589,1640.350,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1495.566,1665.904,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1495.560,1691.523,10.498,0.0,0.0,0.0);
CreateDynamicObject(982,1495.562,1563.649,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1495.539,1520.486,10.496,0.0,0.0,0.0);
CreateDynamicObject(982,1495.539,1512.500,10.504,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.132,1668.982,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.147,1660.399,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.132,1651.805,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.137,1643.217,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.168,1634.628,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.160,1625.989,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.162,1617.401,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.185,1608.794,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.205,1600.093,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.176,1591.398,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.177,1582.766,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.155,1574.100,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.182,1565.429,13.868,0.0,0.0,0.0);
CreateDynamicObject(3819,1504.139,1557.098,13.868,0.0,0.0,0.0);
CreateDynamicObject(1297,1381.617,1369.276,13.215,0.0,0.0,-101.247);
CreateDynamicObject(1297,1391.112,1368.984,13.215,0.0,0.0,-101.247);
CreateDynamicObject(973,1505.637,1320.760,17.998,0.0,-3.438,-180.000);
CreateDynamicObject(973,1446.254,1320.255,18.780,0.0,-0.859,-173.904);
CreateDynamicObject(973,1437.104,1320.575,19.029,0.0,-2.578,-188.595);
CreateDynamicObject(982,1495.490,1488.479,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1495.468,1462.905,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1495.503,1437.371,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1495.535,1413.408,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1495.556,1387.793,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1495.585,1362.262,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1495.572,1344.667,10.504,0.0,0.0,0.0);
CreateDynamicObject(982,1498.832,1319.495,10.515,0.0,0.0,-345.236);
CreateDynamicObject(4238,1458.449,1403.669,17.258,0.0,0.0,-238.826);
CreateDynamicObject(4239,1458.223,1424.284,19.753,0.0,0.0,-180.000);
CreateDynamicObject(4730,1439.299,1529.938,25.736,0.0,0.0,-315.001);
CreateDynamicObject(7415,1517.173,1619.615,19.663,0.0,0.0,-258.748);
CreateDynamicObject(974,1432.093,1749.016,28.848,0.0,0.0,-157.500);
CreateDynamicObject(8331,1445.501,1754.334,30.943,0.0,0.0,-45.000);
CreateDynamicObject(8330,1372.740,1693.501,24.795,0.0,0.0,-270.001);
CreateDynamicObject(8328,1377.836,1659.553,25.738,0.0,0.0,-33.747);
CreateDynamicObject(1342,1510.034,1555.179,10.852,0.0,0.0,-90.000);
CreateDynamicObject(1278,1506.079,1551.823,24.028,0.0,0.0,-90.000);
CreateDynamicObject(1297,1338.028,1419.828,13.215,0.0,0.0,-180.000);
CreateDynamicObject(1297,1331.863,1435.032,13.207,0.0,0.0,-123.747);
CreateDynamicObject(1297,1315.088,1439.293,13.207,0.0,0.0,-90.000);
CreateDynamicObject(1297,1300.490,1411.471,13.215,0.0,0.0,-326.248);
CreateDynamicObject(1297,1316.013,1407.915,13.215,0.0,0.0,-337.501);
CreateDynamicObject(1297,1294.080,1438.802,13.215,0.0,0.0,-45.000);
CreateDynamicObject(1297,1292.435,1423.476,13.215,0.0,0.0,-348.748);
CreateDynamicObject(1640,1482.420,1576.305,9.907,0.0,0.0,-90.000);
CreateDynamicObject(1640,1484.836,1576.253,9.932,0.0,0.0,-90.000);
CreateDynamicObject(1640,1472.008,1572.401,9.912,0.0,0.0,-90.000);
CreateDynamicObject(1640,1469.655,1572.538,9.882,0.0,0.0,-90.000);
CreateDynamicObject(11417,1504.434,1482.649,19.860,0.0,0.0,-146.247);
CreateDynamicObject(10789,1517.033,1494.007,12.359,0.0,0.0,-90.000);
CreateDynamicObject(982,1508.387,1550.695,10.504,0.0,0.0,-90.000);
CreateDynamicObject(982,1434.257,1677.859,10.504,0.0,0.0,-90.000);
CreateDynamicObject(978,1406.090,1689.226,10.586,0.0,-0.859,-273.593);
CreateDynamicObject(978,1408.434,1680.759,10.611,0.0,-359.141,-235.302);
CreateDynamicObject(978,1415.682,1676.977,10.711,0.0,0.0,-181.169);
CreateDynamicObject(978,1423.686,1676.801,10.661,0.0,0.0,-181.169);
CreateDynamicObject(3864,1453.079,1635.906,15.910,0.0,0.0,0.0);
CreateDynamicObject(1681,1438.129,1363.749,12.798,0.0,0.0,-90.000);
CreateDynamicObject(5005,1457.123,1256.897,12.997,0.0,0.0,-270.001);
CreateDynamicObject(984,1523.929,1265.463,10.449,0.0,0.0,-90.000);
CreateDynamicObject(984,1517.505,1258.988,10.449,0.0,0.0,0.0);
CreateDynamicObject(984,1519.948,1246.686,10.449,0.0,0.0,-337.501);
CreateDynamicObject(3864,1501.153,1680.028,15.845,0.0,0.0,-315.001);
CreateDynamicObject(978,1524.646,1265.519,10.653,0.0,0.0,-360.001);
CreateDynamicObject(17019,1439.350,1259.357,23.743,0.0,0.0,-270.001);
CreateDynamicObject(3374,1375.227,1499.796,11.314,0.0,0.0,0.0);
CreateDynamicObject(3374,1375.456,1507.507,11.314,0.0,0.0,0.0);
CreateDynamicObject(7832,1540.859,1565.359,14.041,0.0,0.0,0.0);
CreateDynamicObject(16778,3729.704,-1886.875,1799.106,0.0,0.0,-180.000);
CreateDynamicObject(16778,3729.440,-1865.519,1799.106,0.0,0.0,-180.000);
CreateDynamicObject(16782,3726.590,-1876.124,1807.809,0.0,0.0,0.0);
CreateDynamicObject(2780,3729.633,-1886.655,1799.364,0.0,0.0,0.0);
CreateDynamicObject(2780,3729.275,-1864.448,1799.611,0.0,0.0,0.0);
CreateDynamicObject(13592,1480.758,-1735.927,21.783,-360.001,-361.719,-353.048);
CreateDynamicObject(13592,1140.293,-1712.165,20.527,-360.001,-361.719,-353.048);
CreateDynamicObject(13592,1077.484,-1763.037,21.588,-360.001,-361.719,-353.048);
CreateDynamicObject(13592,682.962,-1748.848,21.309,-360.001,-361.719,-544.298);
CreateDynamicObject(13592,370.788,-1715.345,32.827,-360.001,-361.719,-623.048);
CreateDynamicObject(13592,154.390,-1861.747,12.319,-360.001,-361.719,-623.048);
CreateDynamicObject(16778,-257.079,2220.064,109.449,0.0,0.0,168.750);
CreateDynamicObject(13667,-251.586,2239.779,125.340,0.0,0.0,-11.250);
CreateDynamicObject(7894,-328.963,1326.584,53.102,0.0,0.0,22.500);
CreateDynamicObject(7894,-307.191,1402.801,71.802,0.0,0.0,11.250);
CreateDynamicObject(1634,1965.291,1356.453,14.643,24.924,-0.859,-272.579);
CreateDynamicObject(1634,1983.209,1623.353,13.392,14.610,-0.859,-272.579);
CreateDynamicObject(1634,1978.129,1623.569,18.946,33.518,-2.578,-272.579);
CreateDynamicObject(1634,2098.305,1610.592,12.868,25.783,-2.578,-452.579);
CreateDynamicObject(1634,2102.580,1610.593,18.490,34.377,-2.578,-452.579);
CreateDynamicObject(1634,2191.990,1833.519,12.143,16.329,-2.578,-452.579);
CreateDynamicObject(1634,2560.904,2059.017,12.245,16.329,-2.578,-362.579);



UsePlayerPedAnims();


AddPlayerClass(294,-2299.5703,726.0443,49.4373,270.5008,0,0,0,0,0,0); // Triads
AddPlayerClass(107,2517.3513,-1674.2330,14.1001,75.1960,0,0,0,0,0,0); // Groves
AddPlayerClass(108,2154.3777,-1703.6353,15.0859,272.4767,0,0,0,0,0,0); // vagos
AddPlayerClass(104,1970.7512,-1196.2738,25.6847,179.3820,0,0,0,0,0,0); // balas
AddPlayerClass(248,-587.2643,-1046.0092,26.6683,266.5681,0,0,0,0,0,0); // bikers
AddPlayerClass(287,-1340.8673,493.7612,33.2447,88.4827,0,0,0,0,0,0); // exercito
AddPlayerClass(191,2776.3770,-2456.3220,13.6365,90.2559,0,0,0,0,0,0); // exercito-ls
AddPlayerClass(280,1579.8376,-1634.9807,13.5615,6.0569,0,0,0,0,0,0); // LSPD
AddPlayerClass(281,-1615.2155,685.2371,7.1875,92.4541,0,0,0,0,0,0); // SFPD
AddPlayerClass(283,2251.2532,2490.2795,10.9908,100.6168,0,0,0,0,0,0); // LVPD
AddPlayerClass(195,2402.2715,-1715.4641,14.1328,177.8897,0,0,0,0,0,0); // Denise
AddPlayerClass(192,-2026.9391,-100.2322,35.1641,6.8937,0,0,0,0,0,0); // michele
AddPlayerClass(82,2002.6915,1544.4802,13.5859,274.6674,0,0,0,0,0,0); // Elvis
AddPlayerClass(99,1906.6267,-1352.5216,13.4722,174.8776,0,0,0,0,0,0); // Bmx-park
AddPlayerClass(92,1910.0073,-1355.0824,13.5331,175.5721,0,0,0,0,0,0); // bmx parq
AddPlayerClass(138,385.2151,-2059.9863,7.8359,356.1088,0,0,0,0,0,0); // praia
AddPlayerClass(45,379.7803,-2060.7524,7.8359,0.4746,0,0,0,0,0,0); // praia
AddPlayerClass(131,247.6903,-157.3746,1.5781,87.2410,0,0,0,0,0,0); // caipiras
AddPlayerClass(133,248.6829,-153.4175,1.5703,90.3105,0,0,0,0,0,0); // caipiras
AddPlayerClass(244,2216.5637,-1178.8657,29.7971,356.1999,0,0,0,0,0,0); // puita


//carros montanha russa
AddStaticVehicleEx(411,-270.276,2165.050,112.290,288.0,-1,-1,60);
AddStaticVehicleEx(411,-273.762,2171.930,112.302,288.0,-1,-1,60);
AddStaticVehicleEx(411,-275.666,2178.446,112.302,288.0,-1,-1,60);
//barcos shipwar
AddStaticVehicleEx(446,-597.266,-5331.813,0.323,261.0,-1,-1,60);
AddStaticVehicleEx(446,-593.315,-5311.795,0.323,261.0,-1,-1,60);
AddStaticVehicleEx(446,-598.302,-5292.875,0.323,261.0,-1,-1,60);
AddStaticVehicleEx(446,-609.969,-5401.175,0.323,261.0,-1,-1,60);
AddStaticVehicleEx(446,-614.059,-5419.824,0.323,261.0,-1,-1,60);
AddStaticVehicleEx(446,-625.005,-5435.115,0.323,261.0,-1,-1,60);
//estacionamento
AddStaticVehicleEx(601,-31.229,1520.797,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(502,-45.422,1521.146,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(601,-44.162,1508.798,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(522,-40.696,1496.574,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(599,-24.288,1497.017,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(503,-14.764,1525.997,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(597,-20.375,1534.276,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(541,-30.551,1534.162,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(596,-26.307,1546.903,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(522,-21.716,1559.231,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(541,-13.320,1514.204,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(522,-12.973,1506.292,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(522,-9.979,1489.796,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(411,-21.289,1488.326,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(490,-22.743,1518.835,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(411,-45.039,1530.072,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(500,-21.884,1506.992,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(415,-13.686,1498.709,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(500,3.929,1484.737,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(420,-0.593,1501.525,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(415,-3.483,1513.262,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(420,-5.771,1522.142,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(522,-3.432,1531.791,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(415,-3.845,1540.388,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(438,-7.983,1559.766,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(429,-6.927,1548.485,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(522,-15.517,1542.883,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(402,-4.702,1573.383,12.550,101.0,-1,-1,60);
AddStaticVehicleEx(429,5.824,1509.816,12.556,101.0,-1,-1,60);
AddStaticVehicleEx(402,2.965,1492.208,12.550,101.0,-1,-1,60);
AddStaticVehicleEx(429,-13.768,1568.441,12.550,101.0,-1,-1,60);
//mais do estacionamento
AddStaticVehicleEx(502,61.192,1514.181,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(503,59.185,1527.871,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(506,56.232,1534.333,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(451,52.269,1541.514,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(522,52.081,1549.646,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(477,52.606,1557.637,12.556,89.0,-1,-1,60);
AddStaticVehicleEx(506,47.806,1562.445,12.556,89.0,-1,-1,60);
AddStaticVehicleEx(477,44.598,1551.263,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(475,42.721,1543.157,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(506,38.782,1533.026,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(475,46.782,1525.641,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(481,48.975,1514.284,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(481,43.594,1506.611,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(522,30.626,1503.991,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(522,37.189,1517.668,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(475,31.062,1524.577,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(522,31.976,1540.140,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(522,33.229,1551.275,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(475,36.074,1563.240,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(522,39.959,1570.571,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(481,27.757,1568.321,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(481,23.520,1563.849,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(475,20.476,1550.701,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(429,20.059,1543.261,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(481,20.422,1530.794,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(481,19.737,1516.919,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(481,20.307,1508.890,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(481,26.325,1495.078,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(496,33.251,1490.577,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(411,41.458,1493.655,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(541,48.748,1497.491,12.550,89.0,-1,-1,60);
AddStaticVehicleEx(480,57.218,1502.095,12.550,89.0,-1,-1,60);
//atlantis
AddStaticVehicle(411,434.2070,-2215.7676,-28.5307,183.6192,75,1); //
AddStaticVehicle(475,302.8074,-2528.4822,-28.4545,101.5904,37,0); //
AddStaticVehicle(475,265.2197,-2409.6331,-28.4540,178.8046,37,0); //
AddStaticVehicle(475,525.5776,-2448.1716,-28.4539,222.2297,37,0); //
AddStaticVehicle(515,373.2521,-2215.2620,-27.2390,164.6920,63,78); //
AddStaticVehicle(515,358.6317,-2282.3169,-27.2388,182.2354,63,78); //
AddStaticVehicle(515,251.2970,-2423.4878,-27.2383,93.4042,63,78); //
AddStaticVehicle(560,251.4351,-2433.4202,-28.5528,90.1940,9,39); //
AddStaticVehicle(406,249.9667,-2455.0435,-26.7323,91.8335,1,1); //
AddStaticVehicle(560,482.1533,-2387.5559,-28.5523,320.6488,9,39); //
AddStaticVehicle(560,585.0880,-2341.8352,-28.5526,269.6888,9,39); //
AddStaticVehicle(487,646.3640,-2278.9216,-25.9939,354.5645,26,57); //
//helis estacionamento
AddStaticVehicleEx(488,-7.248,1598.598,27.984,134.0,-1,-1,60);
AddStaticVehicleEx(487,12.362,1595.715,29.704,134.0,-1,-1,60);
AddStaticVehicleEx(469,31.220,1592.555,30.221,134.0,-1,-1,60);
//avioes estacionamento
AddStaticVehicleEx(519,-111.628,1573.086,18.906,259.0,-1,-1,60);
AddStaticVehicleEx(476,-112.461,1588.983,18.906,259.0,-1,-1,60);
AddStaticVehicleEx(520,-114.250,1607.480,18.906,259.0,-1,-1,60);
//caminhoes estacionamento
AddStaticVehicleEx(515,-86.888,1464.929,12.337,44.0,-1,-1,60);
AddStaticVehicleEx(443,-91.383,1479.872,13.512,44.0,-1,-1,60);
AddStaticVehicleEx(406,-96.866,1496.168,14.678,44.0,-1,-1,60);
//motos base
AddStaticVehicleEx(522,1767.868,-2629.725,13.347,0.0,-1,-1,60);
AddStaticVehicleEx(522,1736.512,-2630.251,13.347,0.0,-1,-1,60);
AddStaticVehicleEx(522,1773.238,-2633.685,13.207,0.0,-1,-1,60);
AddStaticVehicleEx(522,1804.391,-2630.997,13.207,0.0,-1,-1,60);
AddStaticVehicleEx(522,1812.753,-2631.850,13.207,0.0,-1,-1,60);
AddStaticVehicleEx(522,1824.375,-2634.706,13.207,0.0,-1,-1,60);
AddStaticVehicleEx(522,1835.880,-2631.400,13.207,0.0,-1,-1,60);
AddStaticVehicleEx(522,1752.576,-2618.252,13.207,0.0,-1,-1,60);
AddStaticVehicleEx(522,1746.129,-2621.458,13.207,0.0,-1,-1,60);
AddStaticVehicleEx(522,1728.775,-2626.704,13.207,0.0,-1,-1,60);
AddStaticVehicleEx(522,1822.803,-2618.503,13.207,0.0,-1,-1,60);
AddStaticVehicleEx(522,1834.224,-2620.456,13.207,0.0,-1,-1,60);
AddStaticVehicleEx(522,1801.810,-2618.487,13.207,0.0,-1,-1,60);
AddStaticVehicleEx(522,1775.818,-2621.917,13.207,0.0,-1,-1,60);
AddStaticVehicleEx(522,1732.652,-2619.871,13.207,0.0,-1,-1,60);
//dift1
AddStaticVehicleEx(443,2342.884,1551.110,37.657,179.0,-1,-1,60);

//drift1
AddStaticVehicle(522,-262.9567,1541.6818,74.9209,316.4400,3,8); //
AddStaticVehicle(568,-265.0963,1542.7988,75.2205,316.6130,17,1); //
AddStaticVehicle(568,-267.5844,1545.1869,75.2106,317.2450,9,39); //
AddStaticVehicle(567,-269.8529,1548.1000,75.2330,315.5258,90,96); //
AddStaticVehicle(567,-272.1369,1550.6925,75.2401,315.1898,88,64); //
AddStaticVehicle(565,-274.3177,1553.5220,74.9843,313.8549,42,42); //
AddStaticVehicle(558,-276.7524,1555.8036,74.9909,315.1066,117,1); //
AddStaticVehicle(558,-279.4363,1558.3716,74.9915,316.2526,116,1); //
AddStaticVehicle(559,-281.7721,1560.7992,75.0173,317.0684,60,1); //
AddStaticVehicle(559,-284.5383,1563.3429,74.9798,314.8345,1,8); //
AddStaticVehicle(562,-286.6827,1566.1155,75.0207,313.9336,17,1); //
AddStaticVehicle(562,-288.9861,1568.5242,75.0204,314.6001,35,1); //
AddStaticVehicle(561,-291.6327,1570.8265,75.1826,315.4883,43,21); //
AddStaticVehicle(561,-294.1129,1573.3130,75.1802,314.9344,8,17); //
AddStaticVehicle(560,-296.2048,1576.0327,75.0674,315.0632,17,1); //
AddStaticVehicle(560,-299.0637,1578.8009,75.0709,316.1093,9,39); //
AddStaticVehicle(451,-301.6104,1581.2494,75.0644,316.8659,36,36); //
AddStaticVehicle(451,-303.9001,1583.4203,75.0676,316.3642,125,125); //


//star was:---------------------------------------------------------------------------------------------
AddStaticVehicle(432,2499.3757,-2866.6592,6.8868,82.2079,43,0); //
AddStaticVehicle(432,2460.0896,-2949.6995,6.8865,347.3307,43,0); //
AddStaticVehicle(432,2478.7241,-2800.4270,7.2049,169.2713,43,0); //
AddStaticVehicle(432,2365.4111,-2926.5752,6.8985,348.7967,43,0); //
AddStaticVehicle(432,2384.4973,-2770.1113,7.2049,174.3303,43,0); //
AddStaticVehicle(432,2293.6487,-2745.7327,7.2049,169.7569,43,0); //
AddStaticVehicle(432,2217.9827,-2818.3667,7.2056,261.8665,43,0); //
AddStaticVehicle(432,2270.9417,-2901.1772,6.8909,351.8025,43,0); //

//Vortex Voador:-------------------------------------------------------------------
AddStaticVehicle(539,-2316.9490,-1643.3420,483.0632,227.3786,70,86); //
AddStaticVehicle(539,-2319.0378,-1645.7164,483.0632,220.9612,79,74); //
AddStaticVehicle(539,-2321.1731,-1647.9282,483.0633,218.6726,86,70); //
AddStaticVehicle(539,-2314.7444,-1640.7700,483.0632,223.3918,61,98); //
//Casaadm:----------------------------------------------------------------------
AddStaticVehicle(560,286.3228,-1171.6273,80.6155,132.4352,9,39); //
AddStaticVehicle(402,300.3827,-1186.0695,80.7457,132.3557,39,39); //
AddStaticVehicle(557,298.6212,-1183.1578,81.2891,130.4287,1,1); //
AddStaticVehicle(558,295.6058,-1180.4763,80.5447,130.7575,30,1); //
AddStaticVehicle(559,293.4410,-1177.8021,80.5703,130.5089,60,1); //
AddStaticVehicle(561,291.7038,-1175.9534,80.7273,129.1283,8,17); //
AddStaticVehicle(562,288.7706,-1173.6798,80.5724,132.0566,35,1); //
AddStaticVehicle(522,289.7555,-1175.0203,80.4891,312.7237,3,8); //
AddStaticVehicle(451,284.4672,-1169.4448,80.6169,132.1582,125,125); //
AddStaticVehicle(463,282.8379,-1167.7963,80.4535,130.2063,19,19); //
//base pnx:---------------
AddStaticVehicle(558,1245.8627,-2008.3729,59.4093,91.4348,1,1); //
AddStaticVehicle(560,1246.4309,-2011.3024,59.5146,90.6285,17,1); //
AddStaticVehicle(561,1246.5748,-2014.3110,59.6204,89.6036,43,21); //
AddStaticVehicle(566,1246.4832,-2017.4568,59.5930,87.0166,30,8); //
AddStaticVehicle(406,1247.5490,-2055.3418,61.2694,269.3100,1,1); //
AddStaticVehicle(580,1246.2875,-2020.9202,59.6129,87.0259,81,81); //
AddStaticVehicle(432,1248.2318,-2047.6823,59.9740,266.5306,43,0); //
AddStaticVehicle(539,1245.4009,-2044.2228,59.2038,268.8572,79,74); //
AddStaticVehicle(539,1245.6029,-2041.6327,59.1980,269.2322,70,86); //
AddStaticVehicle(539,1244.9156,-2039.0740,59.2179,273.4403,75,75); //
AddStaticVehicle(539,1244.8513,-2036.6100,59.2198,272.3471,96,67); //
AddStaticVehicle(520,1117.3387,-2057.2422,75.7063,144.3302,0,0); //
AddStaticVehicle(425,1115.9355,-2017.9114,75.0025,199.7128,43,0); //
AddStaticVehicle(463,1263.0709,-2009.2520,58.8724,357.2406,11,11); //
AddStaticVehicle(463,1267.2441,-2009.1769,58.7534,359.4633,19,19); //
AddStaticVehicle(463,1265.2913,-2009.1740,58.8092,1.0930,7,7); //
AddStaticVehicle(522,1279.4922,-2008.7311,58.4121,358.9147,6,25); //
AddStaticVehicle(562,1276.4862,-2009.7791,58.6077,359.5700,17,1); //
AddStaticVehicle(561,1273.8989,-2009.4995,58.8370,358.3124,25,78); //
AddStaticVehicle(571,1271.3561,-2009.1420,58.3793,359.8107,36,2); //
AddStaticVehicle(572,1269.1199,-2009.8279,58.7400,0.4724,101,1); //
AddStaticVehicle(573,1259.8999,-2010.5183,60.0740,1.0342,115,43); //
AddStaticVehicle(574,1256.7695,-2010.6323,59.2377,4.5549,26,26); //
AddStaticVehicle(575,1254.2831,-2010.7511,59.1410,2.7332,19,96); //
AddStaticVehicle(522,1278.3436,-2045.6833,58.5967,87.0952,7,79); //
AddStaticVehicle(445,1246.7086,-2024.1808,59.6794,88.0874,35,35); //
AddStaticVehicle(447,1118.0455,-2038.0643,78.3852,149.6342,75,2); //
AddStaticVehicle(448,1247.0981,-2026.2119,59.3897,88.4374,3,6); //
AddStaticVehicle(451,1246.2758,-2028.1545,59.5251,90.2605,125,125); //
AddStaticVehicle(451,1246.0670,-2031.2823,59.5300,90.7810,36,36); //
AddStaticVehicle(451,1246.0443,-2033.7090,59.5319,89.3893,16,16); //
AddStaticVehicle(411,1276.2355,-2019.0719,58.6832,89.3881,106,1); //
AddStaticVehicle(411,1276.2684,-2023.8942,58.7057,88.2985,112,1); //
AddStaticVehicle(411,1276.4539,-2029.2363,58.7096,89.8854,116,1); //
AddStaticVehicle(411,1276.1747,-2034.2964,58.7322,88.3710,123,1); //
AddStaticVehicle(411,1276.2360,-2038.0309,58.7735,91.3706,64,1); //
AddStaticVehicle(411,1277.0360,-2043.2390,58.9723,127.4429,12,1); //



	//deserstunt
	AddStaticVehicle(471,-662.751,2316.170,138.434,103.0,-1,-1); // spawnpoint (1)
	AddStaticVehicle(468,-663.765,2299.952,135.985,88.0,-1,-1); // spawnpoint (3)
	AddStaticVehicle(471,-663.230,2301.960,135.765,88.0,-1,-1); // spawnpoint (4)
	AddStaticVehicle(463,-657.596,2300.051,135.459,88.0,-1,-1); // spawnpoint (5)
	AddStaticVehicle(522,-652.620,2303.081,135.388,88.0,-1,-1); // spawnpoint (6)
	AddStaticVehicle(522,-652.724,2301.283,135.195,88.0,-1,-1); // spawnpoint (7)
	AddStaticVehicle(468,-656.978,2301.932,135.426,88.0,-1,-1); // spawnpoint (8)

	//drift
	AddStaticVehicle(602,-345.591,1515.748,75.020,0.0,-1,-1);
	AddStaticVehicle(429,-342.628,1515.900,75.020,0.0,-1,-1);
	AddStaticVehicle(402,-339.605,1516.043,75.020,0.0,-1,-1);
	AddStaticVehicle(541,-336.731,1516.484,75.020,0.0,-1,-1);
	AddStaticVehicle(415,-333.645,1516.271,75.020,0.0,-1,-1);
	AddStaticVehicle(587,-330.548,1515.910,75.020,0.0,-1,-1);
	AddStaticVehicle(565,-327.680,1516.241,75.020,0.0,-1,-1);
	AddStaticVehicle(411,-324.870,1516.111,75.020,0.0,-1,-1);
	AddStaticVehicle(559,-321.906,1516.343,75.020,0.0,-1,-1);
	AddStaticVehicle(506,-318.565,1515.926,75.017,0.0,-1,-1);
	AddStaticVehicle(451,-352.042,1522.203,75.017,0.0,-1,-1);
	AddStaticVehicle(502,-356.233,1522.276,75.017,0.0,-1,-1);
	AddStaticVehicle(477,-362.522,1522.929,75.017,0.0,-1,-1);

	//stuntchiliad
	AddStaticVehicle(502,-2352.607,-1631.106,483.538,256.0,-1,-1);
	AddStaticVehicle(468,-2352.752,-1626.505,483.538,256.0,-1,-1);
	AddStaticVehicle(522,-2354.211,-1634.846,483.538,256.0,-1,-1);
	AddStaticVehicle(510,-2354.303,-1637.972,483.538,256.0,-1,-1);
	AddStaticVehicle(462,-2352.378,-1619.529,483.538,256.0,-1,-1);
	AddStaticVehicle(510,-2347.163,-1650.055,483.538,256.0,-1,-1);
	AddStaticVehicle(471,-2344.427,-1652.990,483.363,256.0,-1,-1);
	AddStaticVehicle(535,-2339.956,-1656.385,483.363,256.0,-1,-1);
	AddStaticVehicle(461,-2339.675,-1659.232,483.363,256.0,-1,-1);
	AddStaticVehicle(463,-2337.889,-1662.873,483.363,256.0,-1,-1);
	AddStaticVehicle(522,-2336.025,-1665.715,483.363,256.0,-1,-1);
	AddStaticVehicle(522,-2332.279,-1669.518,483.363,256.0,-1,-1);
	AddStaticVehicle(522,-2328.449,-1673.886,483.363,256.0,-1,-1);
	AddStaticVehicle(511,-1570.182,-249.802,15.144,47.0,-1,-1);
	AddStaticVehicle(513,-1570.772,-204.546,15.144,315.0,-1,-1);
	AddStaticVehicle(519,-1369.387,-549.033,15.144,206.0,-1,-1);

//swat
AddStaticVehicle(497,1574.6494,-1698.9749,28.9352,88.0495,0,1); // carros-swat
AddStaticVehicle(520,1564.9321,-1645.7269,29.1254,92.2459,0,0); // Carro-SWat
AddStaticVehicle(596,1552.7813,-1606.8126,13.1003,178.2901,0,1); // Carro-SWat
AddStaticVehicle(596,1558.5117,-1606.7473,13.1039,181.2921,0,1); // Carro-SWat
AddStaticVehicle(596,1564.6238,-1607.2321,13.1004,177.9081,0,1); // Carro-SWat
AddStaticVehicle(596,1570.7603,-1606.7118,13.1004,182.1802,0,1); // Carro-SWat
AddStaticVehicle(596,1575.2739,-1606.7065,13.1032,182.9994,0,1); // Carro-SWat
AddStaticVehicle(427,1579.5488,-1607.4174,13.5295,0.4341,0,1); // Carro-SWat
AddStaticVehicle(427,1583.7015,-1607.1293,13.5413,350.7001,0,1); // Carro-SWat
AddStaticVehicle(596,1603.9003,-1613.4874,13.2366,93.5135,0,1); // Carro-SWat
AddStaticVehicle(596,1603.6790,-1618.2177,13.2225,90.0080,0,1); // Carro-SWat
AddStaticVehicle(596,1603.7493,-1621.7427,13.2275,90.3176,0,1); // Carro-SWat
AddStaticVehicle(596,1604.0532,-1627.2362,13.2268,92.2576,0,1); // Carro-SWat
AddStaticVehicle(596,1604.0334,-1630.9730,13.2374,93.7238,0,1); // Carro-SWat
AddStaticVehicle(596,1585.6344,-1667.6477,5.6096,265.9763,0,1); // Carro-SWat
AddStaticVehicle(596,1586.1881,-1671.8259,5.6133,271.8584,0,1); // Carro-SWat
AddStaticVehicle(596,1602.4264,-1684.5614,5.6124,91.5542,0,1); // Carro-SWat
AddStaticVehicle(596,1602.2614,-1688.1465,5.6257,88.8733,0,1); // Carro-SWat
AddStaticVehicle(596,1602.6405,-1691.6191,5.6094,92.1045,0,1); // Carro-SWat
AddStaticVehicle(596,1602.8018,-1695.7223,5.6224,89.0915,0,1); // Carro-SWat
AddStaticVehicle(596,1602.0815,-1700.0789,5.6203,90.8321,0,1); // Carro-SWat
AddStaticVehicle(596,1602.1702,-1703.9597,5.6082,89.1566,0,1); // Carro-SWat
AddStaticVehicle(599,1558.7899,-1709.8843,6.1221,179.7291,0,1); // Carro-SWat
AddStaticVehicle(599,1564.5558,-1709.6927,6.0914,183.4746,0,1); // Carro-SWat
AddStaticVehicle(599,1570.6781,-1710.9601,6.1238,359.2470,0,1); // Carro-SWat
AddStaticVehicle(599,1574.6931,-1711.7211,6.1249,359.8405,0,1); // Carro-SWat
AddStaticVehicle(599,1578.4369,-1712.1707,6.1245,357.1702,0,1); // Carro-SWat
AddStaticVehicle(596,1582.9785,-1711.0580,5.6048,358.3314,0,1); // Carro-SWat
AddStaticVehicle(596,1587.7882,-1710.6630,5.6093,357.6909,0,1); // Carro-SWat
AddStaticVehicle(596,1591.5128,-1711.3068,5.5903,358.1465,0,1); // Carro-SWat
AddStaticVehicle(596,1595.6012,-1710.8368,5.5754,357.2292,0,1); // Carro-SWat
AddStaticVehicle(601,1528.3982,-1687.8776,5.6752,269.3848,1,1); // Carro-SWat
AddStaticVehicle(601,1528.4584,-1683.5313,5.6753,270.0833,1,1); // Carro-SWat
AddStaticVehicle(601,1544.0387,-1684.9030,5.6752,91.2300,1,1); // Carro-SWat
AddStaticVehicle(601,1543.4064,-1680.5978,5.6751,91.2638,1,1); // Carro-SWat
AddStaticVehicle(528,1545.5101,-1676.0804,5.9380,89.3494,0,0); // Carro-SWat
AddStaticVehicle(528,1545.5043,-1672.2666,5.9385,89.3180,0,0); // Carro-SWat
AddStaticVehicle(528,1546.1322,-1667.7831,5.9443,88.4493,0,0); // Carro-SWat
AddStaticVehicle(490,1545.9980,-1662.6781,5.9997,89.6899,0,0); // Carro-SWat
AddStaticVehicle(490,1545.7256,-1658.9888,6.0160,91.4967,0,0); // Carro-SWat
AddStaticVehicle(490,1545.2760,-1655.8080,6.0034,273.5830,0,0); // Carro-SWat
AddStaticVehicle(490,1545.7046,-1650.6581,6.0002,270.7552,0,0); // Carro-SWat
AddStaticVehicle(601,1539.1824,-1644.7813,5.6752,358.6711,1,1); // Carro-SWat
AddStaticVehicle(432,1529.2362,-1654.8708,5.9112,265.9326,1,1); // Carro-SWat
//triads
AddStaticVehicle(412,2219.5469,-2215.6577,13.3693,39.8597,0,0); // triad
AddStaticVehicle(566,2215.8726,-2219.0125,13.3661,43.2341,0,0); // triad
AddStaticVehicle(536,2211.8733,-2221.8987,13.2765,41.8482,0,0); // triad
AddStaticVehicle(536,2208.8569,-2225.6042,13.2758,54.5374,0,0); // triad
AddStaticVehicle(422,2205.0752,-2228.6377,13.5386,46.0469,0,0); // triad
AddStaticVehicle(422,2201.3684,-2232.1260,13.5386,45.0544,0,0); // triad
AddStaticVehicle(422,2198.4524,-2234.6462,13.5409,45.5298,0,0); // triad
AddStaticVehicle(412,2193.8740,-2248.5249,13.3663,44.3722,0,0); // triad
AddStaticVehicle(412,2191.2661,-2252.7168,13.3329,45.4326,0,0); // triad
AddStaticVehicle(412,2188.4280,-2255.7070,13.2927,45.2895,0,0); // triad
AddStaticVehicle(542,2174.6663,-2268.3845,13.1255,45.5436,0,0); // triad
AddStaticVehicle(445,2166.8203,-2275.5166,13.2674,48.0057,0,0); // triad
AddStaticVehicle(445,2161.3059,-2281.7356,13.2734,45.2563,0,0); // triad
AddStaticVehicle(445,2164.3545,-2281.3838,13.3100,39.9264,0,0); // triad
AddStaticVehicle(425,2179.1331,-2300.0027,14.1309,127.9650,0,0); // triad
AddStaticVehicle(487,2204.8372,-2298.5322,14.9219,310.1147,0,0); // triad
AddStaticVehicle(520,2194.5757,-2221.1548,21.5560,318.1211,0,0); // triad
AddStaticVehicle(432,2203.0122,-2255.3850,13.5598,136.1240,0,0); // triad

return 1;
}

stock PlayerName(playerid) {
new name[255];
GetPlayerName(playerid, name, 255);
return name;
}

new vehName[][] ={
"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster",
"Stretch","Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto",
"Taxi","Washington","Bobcat","Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee",
"Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo",
"RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer",
"Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer",
"PCJ-600","Faggio","Freeway","RC Baron","RC Raider","Glendale","Oceanic","Sanchez","Sparrow","Patriot",
"Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina","Comet","BMX",
"Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo",
"Greenwood","Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa",
"RC Goblin","Hotring Racer A","Hotring Racer B","Bloodring Banger","Rancher","Super GT","Elegant",
"Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain","Nebula","Majestic",
"Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona",
"FBI Truck","Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight",
"Streak","Vortex","Vincent","Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob",
"Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A","Monster B","Uranus",
"Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight",
"Trailer","Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford",
"BF-400","Newsvan","Tug","Trailer A","Emperor","Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C",
"Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)","Police Car (LVPD)","Police Ranger",
"Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
"Stair Trailer","Boxville","Farm Plow","Utility Trailer" };

public OnGameModeExit(){
	print("----------------------------------");
	print("[PnX]Phoenix Stunts ;D - DESLIGADO\n");
    print("Dados dos players salvos!\n");
	print("----------------------------------\n");
		KillTimer(HGS);
    TextDrawDestroy(Text:ArkaPlan1);
    TextDrawDestroy(Text:ArkaPlan2);
    TextDrawDestroy(Text:ArkaPlan3);
    TextDrawDestroy(Text:ArkaPlan4);
    TextDrawDestroy(Text:ArkaPlan5);
    TextDrawDestroy(Text:Cizgi);

   	for(new i=0; i<GetMaxPlayers(); i++)
	{
		TextDrawDestroy(GostergeYazi[i]);
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
PlayerPlaySound(playerid,1097 ,0, 0, 0);
SetPlayerCameraPos(playerid, -2672.529541, 1410.453491, 912.723999);
SetPlayerCameraLookAt(playerid, -2676.433349, 1410.398925, 912.723999);
SetPlayerPos(playerid, -2676.433349, 1410.398925, 912.723999);
SetPlayerInterior(playerid, 3);
SetPlayerFacingAngle(playerid, 266.910003);
ApplyAnimation(playerid,"DANCING","DAN_LOOP_A",4.0,1,0,0,0,-1);
PlayerPlaySound(playerid, 1097, 0.0, 0.0, 0.0);
GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~g~~r~] The ~y~Crimes ~g~Brasil ]",2000,5);
   return 1;
    }


public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
GameTextForPlayer(playerid,"~r~ Perdeu PlayBoy", 2500, 2);
SendDeathMessage(killerid,playerid,reason);
SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
InShamal[playerid] = 0;
GPS_Spawned[playerid] = 0;
if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
	}else{
		SendDeathMessage(killerid,playerid,reason);
        Matou[killerid]++;
		Morreu[playerid]++;
}
	if(Matou[killerid] == 5){
	new stringmorte[256];
	format(stringmorte, sizeof(stringmorte), "%s matou 5 desde que entrou, tá se achando... ¬¬", PlayerName(killerid));
	SendClientMessageToAll(Amarelo, stringmorte);
	}
	if(Matou[killerid] == 10){
	new stringmorte[256];
	format(stringmorte, sizeof(stringmorte), "%s matou 10 desde que entrou, começou a carreira assassina!", PlayerName(killerid));
	SendClientMessageToAll(Amarelo, stringmorte);
	}
	if(Matou[killerid] == 20){
	new stringmorte[256];
	format(stringmorte, sizeof(stringmorte), "%s matou 20 desde que entrou, chuva de cadáver! :D", PlayerName(killerid));
	SendClientMessageToAll(Amarelo, stringmorte);
	}
	if(Matou[killerid] == 50){
	new stringmorte[256];
	format(stringmorte, sizeof(stringmorte), "%s matou 50 desde que entrou, quem encara ?", PlayerName(killerid));
	SendClientMessageToAll(Amarelo, stringmorte);
	}
	if(Morreu[playerid] == 5){
	new stringmorte[256];
	format(stringmorte, sizeof(stringmorte), "%s morreu 5 vezes desde que entrou, já vai começar a morrer é ?", PlayerName(playerid));
	SendClientMessageToAll(Amarelo, stringmorte);
	}
	if(Morreu[playerid] == 10){
	new stringmorte[256];
	format(stringmorte, sizeof(stringmorte), "%s morreu 10 vezes desde que entrou, vixi, tá podre hein ? :S", PlayerName(playerid));
	SendClientMessageToAll(Amarelo, stringmorte);
	}
	if(Morreu[playerid] == 20){
	new stringmorte[256];
	format(stringmorte, sizeof(stringmorte), "%s morreu 20 vezes desde que entrou, PQP!", PlayerName(playerid));
	SendClientMessageToAll(Amarelo, stringmorte);
	}
	if(Morreu[playerid] == 50){
	new stringmorte[256];
	format(stringmorte, sizeof(stringmorte), "%s morreu 50 vezes desde que entrou, noob detected!", PlayerName(playerid));
	SendClientMessageToAll(Amarelo, stringmorte);
	}
return 1;
}

public OnPlayerConnect(playerid)
{
PlayerInfo[playerid][Logged] = 0;
nox1[playerid] = 0;
nogame[playerid] = 0;
tempocmdgodc[playerid] = 0;
tempocmdajato[playerid] = 0;
tempocmdcolete[playerid] = 0;
tempocmdvida[playerid] = 0;
afk[playerid] = 0;
//incons
SetPlayerMapIcon(playerid, 1, 1370.5743,-1660.4807,13.3828, 6, 0); //loja de armas LS
SetPlayerMapIcon(playerid, 2, 2352.2661,2775.7212,10.8203, 6, 0); //loja de armas SF
SetPlayerMapIcon(playerid, 3, -2175.7925,642.0870,49.4375, 6, 0); //loja de armas LV
SetPlayerMapIcon(playerid, 4, -1978.9912,287.5680,35.1719,55,0);//WANG
SetPlayerMapIcon(playerid, 5, 2104.9248,2249.4177,10.6952,52,0); //DINDIN
SetPlayerMapIcon(playerid, 6, 2005.3636,1545.3322,13.1746,19,0); //BARCOPIRATA
SetPlayerMapIcon(playerid, 7, 2386.4072,1042.7665,10.8203, 27, 0); //TRANSFENDER
SetPlayerMapIcon(playerid, 8, 1937.8339,2305.5427,10.8203,52,0); //DINDIN
SetPlayerMapIcon(playerid, 9, 2248.8840,2396.2600,10.8203,52,0); //DINDIN
SetPlayerMapIcon(playerid, 10, 1937.8339,2305.5427,10.8203,52,0); //DINDIN2
SetPlayerMapIcon(playerid, 11, 2248.8840,2396.2600,10.8203,52,0); //DINDIN3
SetPlayerMapIcon(playerid, 12, 2104.9248,2249.4177,10.6952,52,0); //DINDIN4
SetPlayerMapIcon(playerid, 13, 2187.0225,1674.5431,10.7696,25,0); //CALIGULAS
SetPlayerMapIcon(playerid, 14, 1978.3699,1018.3140,994.4688,44,0); //FORDRAGONS

//Fim incons
    new Text: gText2;
    gText2 = TextDrawCreate(0.0, 438, "   ~r~Comunidade~w~: http://www.orkut.com.br/Main#Community?cmm=101160864"); //Texto
    TextDrawUseBox(gText2, true);
    TextDrawFont(gText2,1);
    TextDrawBoxColor(gText2, 0x000000ff);
    TextDrawBackgroundColor(gText2, 126);
    TextDrawUseBox(gText2, true);
    TextDrawShowForPlayer(playerid,gText2);
    new Pname[MAX_PLAYER_NAME];
    new string[48];
    GetPlayerName(playerid, Pname, sizeof(Pname));
    format(string, sizeof(string), "- %s (%d) entrou no server.", Pname,playerid);
    ShowPlayerDialog(playerid, AVISO, DIALOG_STYLE_MSGBOX,"Olá", "Bem Vindo e bom jogo!\nClique em Ok para se logar-se!", "Ok", "Sair");
	SendClientMessageToAll(0xFF0000AA, string);
    SendClientMessage(playerid, COR_VERMELHO2, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    SendClientMessage(playerid, COLOR_WHITE, "Servidor The Crimes Brasil ® Mata-Mata v1.0");
    SendClientMessage(playerid, COLOR_WHITE, "Para ajuda inicial digite: /ajuda ");
    SendClientMessage(playerid, COLOR_WHITE, "Para conseguir veículos digite: /estacionamento ou /est ");
    SendClientMessage(playerid, COLOR_WHITE, "Para Trancar e Destracar Veiculos Digite:/Trancar e /Destrancar");
    SendClientMessage(playerid, COLOR_WHITE, "Para Ver Os Administradores Rcon Digite:/admins");
	SendClientMessage(playerid, COLOR_WHITE, "Para Ver Os Criadores Desse GM Digite: /creditos");
    SendClientMessage(playerid, COLOR_WHITE, "Para ver mais comandos digite /comandos");
    SendClientMessage(playerid, COR_VERMELHO2, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	ApplyAnimation(playerid,"DANCING","DAN_LOOP_A",4.0,1,0,0,0,-1);
    InShamal[playerid] = 0;
    /*new Text:text = TextDrawCreate(5.0, 400.0,Text_Under_Minimap);
 	TextDrawShowForPlayer(playerid, text);*/
   	Visitors ++;
	format(visitorstr, sizeof(visitorstr), "[INFO] O servidor teve %d visitantes.", Visitors);
	SendClientMessage(playerid, 0x8080FFAA, visitorstr);
    GPS_Spawned[playerid] = 0;

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
  Object_OnPlayerDisconnect(playerid, reason);
    new Pname[MAX_PLAYER_NAME];
    new string[56];
    GetPlayerName(playerid, Pname, sizeof(Pname));

    switch(reason)
    {
        case 0: format(string, sizeof(string), "%s (ID:%d) saiu do Servidor (NET De Merda)", Pname,playerid);
        case 1: format(string, sizeof(string), "%s (ID:%d) saiu do Servidor (Conta própria)", Pname,playerid);
        case 2: format(string, sizeof(string), "%s (ID:%d) saiu do Servidor (Kick/Ban)", Pname,playerid);
    }
    SendClientMessageToAll(0x009B00AA, string);
   TextDrawHideForPlayer(playerid, Relogio);
    return 1;
}

public OnPlayerSpawn(playerid)
{
TextDrawShowForPlayer(playerid, Relogio);
GPS_Spawned[playerid] = 1;
GameTextForPlayer(playerid,"~b~Voce Acaba De ~g~Nascer ", 2500, 5);
SetPlayerInterior(playerid,0);
PlayerPlaySound(playerid, 1184, 0.0, 0.0, 0.0); //music off  2286.0991,726.5040,49.4386,9.2913
ResetPlayerWeapons(playerid);
new randt = random(sizeof(RandomTools));
new randp = random(sizeof(RandomPistols));
new randx = random(sizeof(Armas));
GivePlayerWeapon(playerid, RandomPistols[randp][0], RandomPistols[randp][1]);
GivePlayerWeapon(playerid, RandomTools[randt][0], RandomTools[randt][1]);
GivePlayerWeapon(playerid, Armas[randx][0], Armas[randx][1]);
return 1;
}

public OnVehicleSpawn(vehicleid)
{
	tCount[vehicleid] = false;
	return 1;
}

public ExplodeShamal(vehicleid)
{
	KillTimer(sExplode[vehicleid]);
	if (tCount[vehicleid])
	{
		CreateExplosion(ShamalPos[vehicleid][0], ShamalPos[vehicleid][1], ShamalPos[vehicleid][2], 2, 15.0);
		sExplode[vehicleid] = SetTimerEx("ExplodeShamal", random(1300)+100, 1, "d", vehicleid);
	}
}

public OnVehicleDeath(vehicleid, killerid)
{
	if (GetVehicleModel(vehicleid) == 519 && ShamalExists(vehicleid) || GetVehicleModel(vehicleid) == 520 && ShamalExists(vehicleid))
	{
		CreateExplosion(ShamalPos[vehicleid][0], ShamalPos[vehicleid][1], ShamalPos[vehicleid][2], 2, 15.0);
		sExplode[vehicleid] = SetTimerEx("ExplodeShamal", 700, 1, "d", vehicleid);
		tCount[vehicleid] = true;
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if (GetVehicleModel(vehicleid) == 520 && ispassenger || GetVehicleModel(vehicleid) == 519 && ispassenger)
	{
		if (!ShamalExists(vehicleid))
		{
			CreateShamalInt(vehicleid, float(randomEx(3000)), float(randomEx(3000)), float(random(100)+800));
		}
		SetPlayerPosInShamal(playerid, vehicleid);
		InShamal[playerid] = vehicleid;
	}
	return 1;
}



public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & 16 && InShamal[playerid])
	{
		new Float:X, Float:Y, Float:Z, Float:A;
		GetVehiclePos(InShamal[playerid], X, Y, Z);
		GetVehicleZAngle(InShamal[playerid], A);
		X += (5 * floatsin(-floatsub(A, 45.0), degrees)),
		Y += (5 * floatcos(-floatsub(A, 45.0), degrees));
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, X, Y, floatsub(Z, 0.94));
		SetPlayerFacingAngle(playerid, A);
		SetCameraBehindPlayer(playerid);
		InShamal[playerid] = 0;
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(afk[playerid] == 1)
	{
	SendClientMessage(playerid, 0x6767B4AA, "[The Crimes]: Antes de voltar a falar dê /online! (:");
	return 0;
	}
	if(PlayerInfo[playerid][Logged] == 0){
	SendClientMessage(playerid, 0x6767B4AA, "[The Crimes]: Você não está logado(a)!");
	return 0;
	}
	UpperToLower(text);
    new string[256];
    format(string,sizeof(string),"[%d]: %s",playerid,text);
	SendPlayerMessageToAll(playerid,string);
    return 0;
    }



public OnPlayerCommandText(playerid, cmdtext[])
{
    new string[256];
    new idx;
    new tmp[256];
 	new cmd[256];
	cmd = strtok(cmdtext, idx);
//================================================================================
if (strcmp(cmdtext, "/sairgame", true)==0){
		if(nogame[playerid] == 0){
 		SendClientMessage(playerid, 0xFF0000AA, "Voce nao esta em algum game.");
		return 1;
		}
 		SpawnPlayer(playerid);
        new id;
	    id = GetPlayerVehicleID(playerid);
		DestroyVehicle(id);
		nogame[playerid] = 0;
 		SetPlayerColor(playerid, 0x008000AA);
      	new message[265];
	    new pname[30];
	    GetPlayerName(playerid, pname, sizeof(pname));
	    format(message, sizeof(message), "<Game> %s Saiu do Game", pname);
	    SendClientMessageToAll(COLOR_WHITE,message);
        GameTextForPlayer(playerid,"~r~Voce saiu do Game",4000,1);
        SendClientMessage(playerid, 0xFF0000AA, "Voce Saiu do game.");
		return 1;
		}
//================================================================================
if(strcmp(cmdtext, "/sairdm", true) == 0)
	{
    if(nox1[playerid] == 0){
 	SendClientMessage(playerid, 0xFF0000AA, "Voce nao esta em algum DM.");
	return 1;
	}    
 	SpawnPlayer(playerid);
	new message[265];
	new pname[30];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(message, sizeof(message), "<DM> %s Saiu do DM", pname);
	SendClientMessageToAll(COLOR_WHITE,message);
    GameTextForPlayer(playerid,"~r~Voce Saiu do DM",4000,1);
    nox1[playerid] = 0;   
    return 1;
 	}  
//================================================================================
if(strcmp(cmdtext, "/nodm", true) == 0){
SendClientMessage(playerid,0x008000AA,"|___Players Em Algum X1___|");
new Jogador[24];
new count = 0;
new msg[120];
for(new i=0; i<MAX_PLAYERS; i++){
if(IsPlayerConnected(i) && nox1[i]){
GetPlayerName(i,Jogador,24);
format(msg,sizeof(msg),"%s (ID: %d)", Jogador,i);
SendClientMessage(playerid, 0x0088CAAA, msg);
count++;
}
}
if(count == 0){
SendClientMessage(playerid, 0xFF0000AA, "Ninguém está em um DM!");
}
return 1;
}
//================================================================================
if(strcmp(cmdtext, "/nogame", true) == 0){
SendClientMessage(playerid,0x008000AA,"|_Players Em Algum Game_|");
new Jogador[24];
new count = 0;
new msg[120];
for(new i=0; i<MAX_PLAYERS; i++){
if(IsPlayerConnected(i) && nogame[i]){
GetPlayerName(i,Jogador,24);
format(msg,sizeof(msg),"%s (ID: %d)", Jogador,i);
SendClientMessage(playerid, 0x0088CAAA, msg);
count++;
}
}
if(count == 0){
SendClientMessage(playerid, 0xFF0000AA, "Ninguém está em um x1!");
}
return 1;
}
//bloqueando nos eventos
if(nox1[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, "Voce nao pode usar esse cmd pois Esta em um DM.");
if(nogame[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, "Voce nao pode usar esse cmd pois Esta em um game.");
//======================
//================================================================================
if (strcmp("/novoscomandos", cmdtext, true, 10) == 0)
	{
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
    format(string, sizeof(string), "%s (ID: %d) Está Vendo Os Novos comandos Do Serve(/novoscomandos)", pname,playerid);
    SendClientMessageToAll(roxo, string);
	SendClientMessage(playerid, 0xFF0000AA, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_WHITE, "Menus:/cores /tunar /armas /games /teles.");
	SendClientMessage(playerid, COLOR_WHITE, "Comandos:/Visitas /contar /beco /admins /ausente /online /ausentes /sairgame.");
	SendClientMessage(playerid, COLOR_WHITE, "Comandos Com Tempo:/godc /ajato /colete /vida.");
    SendClientMessage(playerid, 0xFF0000AA, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
	}
//==============================================================================
if (strcmp("/games", cmdtext, true, 10) == 0) 
  {
ShowPlayerDialog(playerid, Menugame, DIALOG_STYLE_LIST, "Menu De Games", "Counter-Striker\nBate-Bate", "OK", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta escolhendo um game para jogar( /games )", pname,playerid);
SendClientMessageToAll(roxo, string);      
return 1;
}
//==============================================================================
	if (strcmp("/tunar", cmdtext, true, 10) == 0)
		{
			ShowPlayerDialog(playerid, tunar, DIALOG_STYLE_LIST, "Tuning Menu", "Rodas\nCores\nPaintjobs\nNitro\nSuspensão\nAutoTuning", "OK", "Cancelar");
		new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Esta Tunado Seu Carro( /tunar )", pname,playerid);
       SendClientMessageToAll(roxo, string);
        	return 1;
		}

//=============================================================================
if (strcmp("/cores", cmdtext, true, 10) == 0) 
  {
ShowPlayerDialog(playerid, COR, DIALOG_STYLE_LIST, "Menu De Cores", "Vermelho\nAmarelo\nAzul Claro\nAzul Escuro\nRoxo\nVerde\nLaranja\nRosa Claro\nRosa Pink \nMaron\nBonina", "OK", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta Escolhendo Uma Nova Cor( /cores )", pname,playerid);
SendClientMessageToAll(roxo, string);      
return 1;
}
//==============================================================================
if (strcmp("/armas", cmdtext, true, 10) == 0) 
  {
ShowPlayerDialog(playerid, ARMS, DIALOG_STYLE_LIST, "Menu De Kit De Armas", "Kit-1\nKit-2\nKit-3\nKit-4\nKit-5\nKit-6 So Para Admins", "OK", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta Escolhendo Um Kit De Armas( /armas )", pname,playerid);
SendClientMessageToAll(roxo, string);      
return 1;
}
//=============================================================================
if (strcmp("/teles", cmdtext, true, 10) == 0) 
  {
ShowPlayerDialog(playerid, telesmenu, DIALOG_STYLE_LIST, "Menu De Teles", "Tunings\nDrifts\nAeros\nOutros", "OK", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta Vendo Os Teleportes Disponiveis( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);      
return 1;
}
//================================================================================
	if (strcmp("/ajuda", cmdtext, true, 10) == 0)
	{
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
    format(string, sizeof(string), "%s (ID: %d) Está Vendo As Ajudas ( /ajuda )", pname,playerid);
    SendClientMessageToAll(roxo, string);
	SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_WHITE, "Para Ver Os Comandos Digite:/Comandos");
	SendClientMessage(playerid, COLOR_WHITE, "Para Ver Os Teleportes Digite:/teleportes e /teles");
	SendClientMessage(playerid, COLOR_WHITE, "Para Ver Os Admins Online Digite: /admins");
	SendClientMessage(playerid, COLOR_WHITE, "Para Ficar Afk Digite:/ausente");
	SendClientMessage(playerid, COLOR_WHITE, "Para Voltar Do  Afk Digite:/online");
	SendClientMessage(playerid, COLOR_WHITE, "Para Ver Os Ausentes Digite: /ausentes");
    SendClientMessage(playerid, COLOR_WHITE, "Para Trancar e Destracar Veiculos Digite:/Trancar e /Destrancar");
    SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
	}
//================================================================================
	if (strcmp("/teleportes", cmdtext, true, 10) == 0)
	{
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
    format(string, sizeof(string), "%s (ID: %d) Está Vendo Os Tipos De Teleportes ( /teleportes )", pname,playerid);
    SendClientMessageToAll(roxo, string);
	SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_WHITE, "Teleportes de Stunt: /telesstunt");
	SendClientMessage(playerid, COLOR_WHITE, "Teleportes de DM: /telesdm");
	SendClientMessage(playerid, COLOR_WHITE, "Teleportes de Race: /telesrace");
	SendClientMessage(playerid, COLOR_WHITE, "Teleportes diversos: /telesfun e /telesfun2");
    SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
	}
//================================================================================
	if (strcmp("/beco", cmdtext, true, 10) == 0)
	{
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
    format(string, sizeof(string), "%s (ID: %d) Está Vendo Os Becos Do Serve( /beco)", pname,playerid);
    SendClientMessageToAll(roxo, string);
	SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_WHITE, "Escolha Um Beco Para Pegar Gangs e Armas");
	SendClientMessage(playerid, COLOR_WHITE, "Para Ir Ao Beco De Los Santos Digite: /becols");
	SendClientMessage(playerid, COLOR_WHITE, "Para Ir Ao Beco De San Fierro Digite: /becosf");
	SendClientMessage(playerid, COLOR_WHITE, "Para Ir Ao Beco De Las Venturas Digite: /becolv");
    SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
	}
//================================================================================
if (strcmp("/telesstunt", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Está Vendo Os Teleportes De Stunts ( /telesstunt )", pname,playerid);
SendClientMessageToAll(roxo, string);
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
SendClientMessage(playerid, COLOR_WHITE, "Para ir até o Stunt Em Las Venturas digite: /lvstunt");
SendClientMessage(playerid, COLOR_WHITE, "Para ir até o Aero Stunt de LS digite: /aeroportols");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao Stunt digite: /stunt");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao Drop digite: /drop");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao Deserto Fazer Stunts digite: /desertstunt");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao Drop Explosivo digite: /dropexplosivo");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao Reino Perdido digite: /atlants");
SendClientMessage(playerid, COLOR_WHITE, "Para ir até a Montanha Russa digite: /montanharussa");
SendClientMessage(playerid, COLOR_WHITE, "Para ir até o Antigo Aeroporto de Las Venturas digite: /aerovelho ou /aeroabandonado");
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
return 1;
}
//================================================================================
if (strcmp("/telesdm", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Está Vendo Os Teleportes De Deatch Match ( /telesdm )", pname,playerid);
SendClientMessageToAll(roxo, string);
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
SendClientMessage(playerid, COLOR_WHITE, "Para ir até a Crazy Arena digite: /crazyarena");
SendClientMessage(playerid, COLOR_WHITE, "Para ir até a Arena x1 digite: /arenax1");
SendClientMessage(playerid, COLOR_WHITE, "Para ir até a Ship War digite: /shipwar");
SendClientMessage(playerid, COLOR_WHITE, "Para ir até a Arena Sangrenta digite: /arenasangrenta");
SendClientMessage(playerid, COLOR_WHITE, "Para ir até a Remote DM digite: /remotedm");
SendClientMessage(playerid, COLOR_WHITE, "Para ir até a Sniper DM digite: /sniperdm");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/Arenadm ou /arenadm2 Para ir A Uma Arena Para Duelar Com Pessoas");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/becols - Para Ir ao Beco de Los Santos");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/becosf- Para Ir ao Beco de San Fierro");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/becolv - Para Ir ao Beco de Las Venturas");
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
return 1;
}
//================================================================================
if (strcmp("/telesrace", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Está Vendo Os Teleportes De Race ( /telesrace )", pname,playerid);
SendClientMessageToAll(roxo, string);
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao Circuito Flat OUT digite: /flat");
SendClientMessage(playerid, COLOR_WHITE, "Para ir até a Race digite : /race");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao Drift digite: /drift");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao Drift2 digite: /drift2");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao circuito 1 digite: /circuito1");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao circuito 2 digite: /circuito2");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao circuito 3 digite: /circuito3");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao circuito 4 digite: /circuito4");
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
return 1;
}
//================================================================================
if (strcmp("/telesfun", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Está Vendo Os Teleportes De 4Fun ( /telesfun )", pname,playerid);
SendClientMessageToAll(roxo, string);
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao Estacionamento digite: /estacionamento");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao 2°Estacionamento digite: /est");
SendClientMessage(playerid, COLOR_WHITE, "Para ir até Liberty City digite: /lc");
SendClientMessage(playerid, COLOR_WHITE, "Para ir a derby digite: /derby");
SendClientMessage(playerid, COLOR_WHITE, "Para ir Ao Banco digite: /irbanco");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/ls - Para ir a Los santos");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/sf - Para ir a San Fierro");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/lv - Para ir a Las Venturas");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/Telesfun2 - Para Ver A 2° Lista De Teleportes ");
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
return 1;
}
//================================================================================
if (strcmp("/telesfun2", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Está Vendo A 2°Lista Teleportes De 4Fun  ( /telesfun2 )", pname,playerid);
SendClientMessageToAll(roxo, string);
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/vortex-voador Para ir Ao Chiliad Voar Com O Vortex");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/ammu - Para Ir A Ammu Nation");
SendClientMessage(playerid, COLOR_WHITE, "Para ir ao Chiliad digite: /chiliad");
SendClientMessage(playerid, COLOR_WHITE, "Para ir Fazer Le Parkour digite: /parkour");
SendClientMessage(playerid, COLOR_WHITE, "Para ir Pular De Paraquedas digite: /jump e /megajump");
SendClientMessage(playerid, COLOR_WHITE, "Para ir A Ilha digite: /ilha");
SendClientMessage(playerid, COLOR_WHITE, "Para ir Ver A Arvore De Natal digite: /natal");
SendClientMessage(playerid, COLOR_WHITE, "Para ir Ao Clube De Golf digite: /golfclube");
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
return 1;
}

//================================================================================
if (strcmp("/creditos", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (%d) Está Vendo Os Criadores Do servidor  ( /creditos )", pname,playerid);
SendClientMessageToAll(roxo, string);
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
SendClientMessage(playerid, COR_AMARELO, "Criado por: [TC]Diego e [TC]Pedro");
SendClientMessage(playerid, COR_AMARELO, "Acesse: www.thecrimesgames.blogspot.com");
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
return 1;
}
//================================================================================
if (strcmp("/comandos", cmdtext, true, 10) == 0){
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Está Vendo A Lista De Comandos  ( /comandos )", pname,playerid);
SendClientMessageToAll(roxo, string);
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
SendClientMessage(playerid, COLOR_WHITE, "Para deixar seu veículo God Mode digite: /godc");
SendClientMessage(playerid, COLOR_WHITE, "Para se matar digite: /kill");
SendClientMessage(playerid, COLOR_WHITE, "Para ver todos os teleportes digite: /teleportes");
SendClientMessage(playerid, COLOR_WHITE, "Para Ver Os Comandos De Sexo digite: /sexo");
SendClientMessage(playerid, COLOR_WHITE, "Para Ver Os Comandos de Banco Digite: /banco");
SendClientMessage(playerid, COLOR_WHITE, "Para Ver Os Comandos de Administradores Digite: /comandosadmin");
SendClientMessage(playerid, COLOR_WHITE, "Digite: /contar - Para Iniciar Uma Contagem");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/comandos2 - Para Ver A 2°Lista de comandos");
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
return 1;
}
//================================================================================
if (strcmp("/comandos2", cmdtext, true, 10) == 0){
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Está Vendo A 2° Lista De Comandos  ( /comandos2 )", pname,playerid);
SendClientMessageToAll(roxo, string);
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/autotunar - Para Tunar Seu Carro");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/consertar - Para Consertar Seu Carro");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/armas - Para Pegar Os Kits De Armas Disponiveis");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/virar - Para Virar O Seu Veiculo");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/trancar - Para Trancar O Seu Veiculo");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/destrancar - Para Destrancar O Seu Veiculo");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/morrer - Para Morrer");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/transferir [ID] [Quantia]- Trasfere Um certa Quantia de Grana Para Alguem");
SendClientMessage(playerid, COLOR_WHITE, "Digite:/meustatus - Para Ver Seus Status");
SendClientMessage(playerid, COLOR_WHITE, "Digite: /Tunar - Para Tunar Seu Carro ");
SendClientMessage(playerid, COLOR_WHITE, "Digite: /cores - Para Mudar Sua Cor");
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
return 1;
}
//================================================================================
if (strcmp("/sexo", cmdtext, true, 10) == 0){
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Está Vendo A Lista De Comandos De  HottCaffe  ( /sexo )", pname,playerid);
SendClientMessageToAll(roxo, string);
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
SendClientMessage(playerid, COLOR_WHITE, "Para ficar em posição de transar para mulheres digite: /mulhersexo");
SendClientMessage(playerid, COLOR_WHITE, "Para comer a mulher digite: /comermulher");
SendClientMessage(playerid, COLOR_WHITE, "Para ficar de 4 digite: /de4");
SendClientMessage(playerid, COLOR_WHITE, "Para rolar e deitar digite: /mulherfudida ");
SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
return 1;
}
//================================================================================
if(strcmp(cmdtext, "/banco", true) == 0) {
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Está Vendo Os Comandos Do Banco ( /banco )", pname,playerid);
SendClientMessageToAll(roxo, string);
	    SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        SendClientMessage(playerid, COLOR_WHITE, "Todas As lojas 24-7 E um Banco mas e mais facil Voçê Digitar /irbanco para ir ao banco mas Neste caso as veses Voçê Perde Sua grana");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/irbanco - Para ir ao banco");
	    SendClientMessage(playerid, COLOR_WHITE, "Digite:/criarcartao - Cria a conta");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/lcard - Loga o cartão ");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/deposito - Deposita o dinheiro");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/sacar - Retira o dinehiro depositado");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/meusaldo - ve o saldo atual da conta");
        SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		return 1;
		}
//================================================================================
if (strcmp("/comandosadmin", cmdtext, true, 10) == 0)
{
if(IsPlayerAdmin(playerid) == 1)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Está Vendo A Lista De Comandos De Admin  ( /comandosadmin )", pname,playerid);
SendClientMessageToAll(roxo, string);
        SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/admcomandos - Para Ver A Segunda Lista De Comandos De Administradores");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/adminhelp - Para Ver A Terceira Lista De Comandos De Administradores");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/tadmin - Para Pegar Armas,skin e Cor Do Administradores");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/casaadm - Para Ir A Casa Dos Administradores");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/basepnx - Para Ir Na Base Da Gang Dos Administradores");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/acasaadm - Para Abrir O Portao Da Casa Dos Administradores");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/fcasaadm - Para Fechar O Portao Da Casa Dos Administradores");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/abasepnx - Para Abrir O Portao Da Base Da TC");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/fbasepnx - Para Fechar O Portao Da Base Da TC");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/respawnarcarros Para Da respawn em todos os carros do serve");
        SendClientMessage(playerid, COLOR_WHITE, "Digite:/respwncar para Da respawn No carro que estiver Dentro");
        SendClientMessage(playerid, COL_RED, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
   return 1;
}
}
//===============================================Comandos Normais  Inicio===================================

if(strcmp(cmdtext, "/abrirconta", true) == 0) {
format(file, sizeof(file), PASTA_CONTAS, PlayerName(playerid));
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == Banco){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(file, "ContaBancaria") == 0){
new grana;
grana = GetPlayerMoney(playerid);
if(grana > 299){
format(string, sizeof(string), "O player %s(id: %d) abriu uma conta bancária.", aname, playerid);
SendClientMessageToAll(roxo, string);
dini_IntSet(file, "ContaBancaria", 1);
GivePlayerMoney(playerid, -300);
dini_IntSet(file, "SaldoBancario", 300);
} else {
SendClientMessage(playerid, Vermelho,"Para abrir uma conta bancária você presisa de pelo menos 300 reais.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você já tem uma conta bancária.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está em um banco.");
}
return 1;
}

if(strcmp(cmdtext, "/saldo", true) == 0) {
format(file, sizeof(file), PASTA_CONTAS, PlayerName(playerid));
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == Banco){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(file, "ContaBancaria") == 1){
format(string, sizeof(string), "[The Crimes Brasil]: Você tem depositado em sua conta R$:%d.", dini_Int(file, "SaldoBancario"));
SendClientMessage(playerid, Verde, string);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem uma conta bancária.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está em um banco.");
}
return 1;
}

if(strcmp(cmdtext, "/saldocell", true) == 0) {
format(file, sizeof(file), PASTA_CONTAS, PlayerName(playerid));
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(file, "ContaBancaria") == 1){
format(string, sizeof(string), "SMS Recebido: Você tem depositado no banco R$:%d.", dini_Int(file, "SaldoBancario"));
SendClientMessage(playerid, Verde, string);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem uma conta bancária.");
}
return 1;
}

if(strcmp(cmd, "/depositar", true) == 0) {                
format(file, sizeof(file), PASTA_CONTAS, PlayerName(playerid));
new check;
check = CPS_GetPlayerCheckpoint(playerid);
        if(check == Banco){
			new valor;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, Vermelho, "Use /depositar [quantia].");
			}
    	    valor = strval(tmp);        
            new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
			if(dini_Int(file, "ContaBancaria") == 1){
            new grana;
            grana = GetPlayerMoney(playerid);
            if(grana > valor-1){    
            format(string, sizeof(string), "[The Crimes Brasil]: Você depositou a quantia de R$:%d.", valor);
            SendClientMessage(playerid, Verde, string);
            dini_IntSet(file, "SaldoBancario", dini_Int(file, "SaldoBancario")+valor);
            GivePlayerMoney(playerid, -valor); 
            return 1;    
            } else {            
            SendClientMessage(playerid, Vermelho, "Você não tem todo este dinheiro.");
            }            

			} else {
        SendClientMessage(playerid, Vermelho, "Você não tem uma conta bancária.");
   }
			} else {
            SendClientMessage(playerid, Vermelho, "Você não está em um banco");
   }
		}

        if(strcmp(cmd, "/sacar", true) == 0) {                
        format(file, sizeof(file), PASTA_CONTAS, PlayerName(playerid));
        new check;
        check = CPS_GetPlayerCheckpoint(playerid);
        if(check == Banco){
			new valor;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, Vermelho, "Use /sacar [quantia].");
			}
    	    valor = strval(tmp);        
            new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
			if(dini_Int(file, "ContaBancaria") == 1){
            if(dini_Int(file, "SaldoBancario") > valor-1){    
            format(string, sizeof(string), " Você sacou a quantia de R$%d.", valor);
            SendClientMessage(playerid, Verde, string);
            dini_IntSet(file, "SaldoBancario", dini_Int(file, "SaldoBancario")-valor);
            GivePlayerMoney(playerid, valor); 
		    return 1;    
            } else {            
            SendClientMessage(playerid, Vermelho, "Você não tem todo este dinheiro.");
            }            

			} else {
        SendClientMessage(playerid, Vermelho, "Você não tem uma conta bancária.");
   }
			} else {
            SendClientMessage(playerid, Vermelho, "Você não está em um banco.");
   }
		}

if(strcmp(cmdtext, "/vida", true) == 0)
    {
    /*if(nox1[playerid] == 1){
 	SendClientMessage(playerid, 0xFF0000AA, "Voce nao pode usar esse cmd pois Esta em um x1.");
	return 1;
	}
    if(nogame[playerid] == 0){
 	SendClientMessage(playerid, 0xFF0000AA, "Voce nao pode usar esse cmd pois Esta em um game.");
	return 1;
	}*/
    if(tempocmdvida[playerid]== 0){
    GivePlayerMoney(playerid, -5000);
	SetPlayerHealth(playerid,100);
    SendClientMessage(playerid, 0xFF0000AA, "Voce Comprou Vida Por 5000 Reais.");
    tempocmdvida[playerid] = 1;
    SetTimer("tempocmdvida2",600000, false);
    }
	else
	{
	SendClientMessage(playerid,0xFF0000AA, "Aguarde 10 Minutos para reutilizar esse comando.");
	}
	return 1;
 	} 


if(strcmp(cmdtext, "/colete", true) == 0)
    {
    /*if(nox1[playerid] == 1){
 	SendClientMessage(playerid, 0xFF0000AA, "Voce nao pode usar esse cmd pois Esta em um x1.");
	return 1;
	}
    if(nogame[playerid] == 0){
 	SendClientMessage(playerid, 0xFF0000AA, "Voce nao pode usar esse cmd pois Esta em um game.");
	return 1;
	}*/
    if(tempocmdcolete[playerid]== 0){
    GivePlayerMoney(playerid, -10000);
    SendClientMessage(playerid, 0xFF0000AA, "Voce Comprou Colete Por 5000 Reais.");
	SetPlayerArmour(playerid,100);
    tempocmdcolete[playerid] = 1;
    SetTimer("tempocmdcolete2",600000, false);
    }
	else
	{
	SendClientMessage(playerid,0xFF0000AA, "Aguarde 10 Minutos para reutilizar esse comando.");
	}
	return 1;
 	} 
if(strcmp(cmdtext, "/ajato", false) == 0)
    {
    /*if(nox1[playerid] == 1){
 	SendClientMessage(playerid, 0xFF0000AA, "Voce nao pode usar esse cmd pois Esta em um x1.");
	return 1;
	}
    if(nogame[playerid] == 0){
 	SendClientMessage(playerid, 0xFF0000AA, "Voce nao pode usar esse cmd pois Esta em um game.");
	return 1;
	}*/
    if(tempocmdajato[playerid]== 0){
    GivePlayerMoney(playerid, -10000);
    SendClientMessage(playerid, 0xFF0000AA, "Voce Comprou JetPack Por 10000 Reais.");
	SetPlayerSpecialAction(playerid, 2);
    tempocmdajato[playerid] = 1;
    SetTimer("tempocmdajato2",180000, false);
    }
	else
	{
	SendClientMessage(playerid,COLOR_RED, "Aguarde 3 Minutos para reutilizar esse comando.");
	}
	return 1;
 	} 

if(strcmp(cmdtext, "/godc", true) == 0)
    {
    if(tempocmdgodc[playerid]== 0){
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
    format(string, sizeof(string), "%s (ID: %d) deixou seu carro em god mod( /godc )", pname,playerid);
    SendClientMessageToAll(roxo, string);
    SetVehicleHealth(GetPlayerVehicleID(playerid),9999999);
    SendClientMessage(playerid, COLOR_WHITE, "Carro em God Mode");
	tempocmdgodc[playerid] = 1;
    SetTimer("tempocmdgodc2",180000, false);
    }
	else
	{
	SendClientMessage(playerid,COLOR_RED, "Aguarde 3 Minutos para reutilizar esse comando.");
	}
	return 1;
 	}

if (strcmp("/visitas", cmdtext, true, 10) == 0)
		{
SendClientMessage(playerid,0xFF0000AA,"Visitas!");
format(visitorstr, sizeof(visitorstr), "O servidor tem %d visitantes desde que foi ligado!", Visitors);
SendClientMessage(playerid, 0x8080FFAA, visitorstr);
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta Vendo Quantos Visitantes o Servidor Ja tem( /visitas )", pname,playerid);
SendClientMessageToAll(roxo, string);        	
return 1;
}
//================================================================================
if(strcmp(cmdtext, "/morrer", true) == 0)
{
SetPlayerHealth(playerid,0.0);
return 1;
}
//================================================================================
if(strcmp(cmdtext, "/autotunar", true) == 0) {
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
GameTextForPlayer(playerid,"~g~Carro Tunado - VAI COM TUDO NEGA", 2000, 5);
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) resolveu auto-tunar seu carro( /autotunar )", pname,playerid);
SendClientMessageToAll(roxo, string);
AddVehicleComponent(VehicleID, 1087);
AddVehicleComponent(VehicleID, 1078);
AddVehicleComponent(VehicleID, 1010);
ChangeVehiclePaintjob(VehicleID, 1);
AddVehicleComponent(VehicleID, 1003);
AddVehicleComponent(VehicleID, 1074);
return 1;
}
//================================================================================
if(strcmp(cmdtext, "/admins", true) == 0){
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta Vendo Os Admins Online( /admins )", pname,playerid);
SendClientMessageToAll(roxo, string);
SendClientMessage(playerid,roxo, "_________________________________________________");
SendClientMessage(playerid,roxo, " ");
SendClientMessage(playerid,roxo, ".:: Administradores Online ::.");
new Jogador[24];
new count = 0;
new msg[120];
for(new i=0; i<MAX_PLAYERS; i++){
if(IsPlayerConnected(i) && IsPlayerAdmin(i)){
GetPlayerName(i,Jogador,24);
format(msg,sizeof(msg),"NOME: %s ", Jogador);
SendClientMessage(playerid, 0x0080FFAA, msg);
count++;
}
}
if(count == 0){
SendClientMessage(playerid, COR_RED, "Não Tem administradores online no momento");
}
return 1;
}
//================================================================================
if(strcmp(cmdtext, "/consertar", true) == 0) {
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
RepairVehicle(VehicleID);
GameTextForPlayer(playerid,"~g~Carro Consertado", 2000, 5);
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) resolveu Consertar seu carro( /consertar )", pname,playerid);
SendClientMessageToAll(roxo, string);
return 1;
}
//================================================================================
if (strcmp("/virar", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		format(string, sizeof(string), "%s (ID: %d) virou seu carro( /virar )", pname,playerid);
		SendClientMessageToAll(roxo, string);
new Float:X, Float:Y, Float:Z;
if(IsPlayerInAnyVehicle(playerid))
SetCameraBehindPlayer(playerid);
GetPlayerPos(playerid, X, Y, Z);
SetVehiclePos(GetPlayerVehicleID(playerid), X, Y, Z);
SetVehicleZAngle(GetPlayerVehicleID(playerid), 0);
return 1;
}
//================================================================================

if (strcmp(cmdtext, "/trancar", true)==0)
	{
new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		format(string, sizeof(string), "%s (ID: %d) Trancou Seu Carro( /trancar )", pname,playerid);
		SendClientMessageToAll(roxo, string);
		new State;
    	new Float:X;
    	new Float:Y;
	    new Float:Z;
		if(IsPlayerInAnyVehicle(playerid))
		{
			State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,COLOR_RED,"Você só pode trancar as portas se estiver dirigindo.");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				if(i != playerid)
				{
					SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
				}
			}
			GameTextForPlayer(playerid, "~y~ Veiculo ~r~Trancado", 5000, 6);
			GetPlayerPos(playerid,X,Y,Z);
			PlayerPlaySound(playerid,1056,X,Y,Z);
			return 1;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "Você não está em nenhum veículo!");
			return 1;
		}
	}
//================================================================================
	if (strcmp(cmdtext, "/destrancar", true)==0)
	{
new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		format(string, sizeof(string), "%s (ID: %d) Destrancou seu carro( /destrancar )", pname,playerid);
		SendClientMessageToAll(roxo, string);
		new State;
    	new Float:X;
    	new Float:Y;
    	new Float:Z;
		if(IsPlayerInAnyVehicle(playerid))
		{
			State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,COLOR_RED,"Você só pode destrancar as portas se estiver dirigindo.");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
			}
			GameTextForPlayer(playerid, "~y~ Veiculo ~n~ ~g~Destrancado", 5000, 6);
			GetPlayerPos(playerid,X,Y,Z);
			PlayerPlaySound(playerid,1057,X,Y,Z);
			return 1;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "Você não está em nenhum veículo!");
			return 1;
		}
	}

//================================================================================
	if (strcmp("/mulhersexo", cmdtext, true, 10) ==0){ApplyAnimation(playerid,"benchpress","gym_bp_up_B",4.1,0,1,1,1,1); return 1;}
    if (strcmp("/comermulher", cmdtext, true, 10) ==0){ApplyAnimation(playerid,"MD_END","END_SC1_SMO",4.1,0,1,1,1,1); return 1;}
    if (strcmp("/de4", cmdtext, true, 10) ==0){ApplyAnimation(playerid,"FINALE","FIN_Land_Car",4.1,0,1,1,1,1); return 1;}
    if (strcmp("/mulherfudida", cmdtext, true, 10) ==0){ApplyAnimation(playerid,"FINALE","FIN_Land_Die",4.1,0,1,1,1,1); return 1;}


//====================================================================================================
if(strcmp(cmdtext, "/transferir", true) == 0)
	{
	new playermoney;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new giveplayerid, moneys;
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_RED, "USE: /transferir [id] [quantidade]");
	    	return 1;
		}
		giveplayerid = strval(tmp);
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_RED, "USE: /transferir [id] [quantidade]");
	    	return 1;
		}
 		moneys = strval(tmp);
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetPlayerMoney(playerid);
			if (moneys > 0 && playermoney >= moneys)
			{
				GivePlayerMoney(playerid, (0 - moneys));
				GivePlayerMoney(giveplayerid, moneys);
				format(string, sizeof(string), "Você enviou a %s(id: %d) a quantidade de $%d.", giveplayer,giveplayerid, moneys);
				SendClientMessage(playerid, COLOR_GREEN, string);
				format(string, sizeof(string), "Você recebeu $%d de %s(id: %d).", moneys, sendername, playerid);
				SendClientMessage(giveplayerid, COLOR_GREEN, string);
				printf("%s acaba de transferir $%d para %s",sendername,moneys,giveplayer);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "Voce nao tem essa quantia!.");
			}
		}
		else
		{
			format(string, sizeof(string), "%d [Aviso] player nao conectado.", giveplayerid);
			SendClientMessage(playerid, COLOR_RED, string);
		}

    return 1;
}
//=============================================================================
if (strcmp("/Meustatus", cmdtext, true, 10) == 0) // quando alguem digitar /status vai aparecer todos os status no chat
    {
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta Vendo Seus Status( /meustatus )", pname,playerid);
SendClientMessageToAll(roxo, string);
        new stringkills[256]; //string para armazenar a mensagem de kills
        new stringmortes[256]; //string para armazenar a mensagem de mortes
        SendClientMessage(playerid,COLOR_GREEN,"º SEUS STATUS: º");
        format(stringkills,sizeof(stringkills),"± Kills: %d", Kills[playerid]); //no %d vai aparecer o numero de kills que você fez
        SendClientMessage(playerid,0xFF0000AA, stringkills); // faz com que mostre no chat a mensagem que foi armazenada na string
        format(stringmortes,sizeof(stringmortes),"± Mortes: %d", Mortes[playerid]); // o mesmo que a mensagem anterior
        SendClientMessage(playerid, 0xFF0000AA, stringmortes);// o mesmo que a mensagem anterior
        return 1;
    }

//=============================================================================
if (strcmp(cmdtext, "/contar", true)==0)
	{
	if(Count >= 5)
	    {
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Inicio Uma Contagem( /contar )", pname,playerid);
SendClientMessageToAll(roxo, string);  
	    SendClientMessageToAll(0x33AA33AA, "Contador é iniciado!");
	    CountDown();
    	return 1;
    	}
    	else
	    {
	    SendClientMessage(playerid, 0xAA3333AA, "Contador já está ativado!");
	    return 1;
    	}
	}

         if(strcmp(cmd,"/ausente",true)==0){
	    	if(afk[playerid]){
  				SendClientMessage(playerid, Cinza, "[The Crimes Brasil]: Você já está AFK!");
  				return 1;
  			}
	    		new msg[256];
                strmid(tmp,cmdtext,8,strlen(cmdtext));
	    		if(!strlen(tmp)) {
				format(msg,sizeof(msg),"[The Crimes Brasil]: %s está AFK [Sem Motivo]",PlayerName(playerid));
				SendClientMessageToAll(Vermelho,msg);
				SendClientMessage(playerid, COLOR_RED, "USE: /online Para Voltar");
                afk[playerid] = 1;
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				SetPlayerCameraPos(playerid, x, y, z + 50);
				SetPlayerCameraLookAt(playerid, x, y, z);
		   		return 1;
			} else {
				format(msg,sizeof(msg),"[The Crimes Brasil]: %s está AFK [Motivo:%s]",PlayerName(playerid),tmp);
				SendClientMessage(playerid, COLOR_RED, "USE: /online Para Voltar");
                SendClientMessageToAll(Vermelho,msg);
				afk[playerid] = 1;
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				SetPlayerCameraPos(playerid, x, y, z + 50);
				SetPlayerCameraLookAt(playerid, x, y, z);
}
				return 1;
}
		
	if (strcmp(cmdtext, "/online", true) ==0){
	if(!afk[playerid]){
  		SendClientMessage(playerid, 0xFF0000AA, "~ [The Crimes Brasil]: Você não está AFK!");
  		return 1;
  	}
		new pName[30];
		GetPlayerName(playerid, pName, 30);
		format(string, 256, "~ [The Crimes Brasil]: %s não está mais AFK!", pName);
		SendClientMessageToAll(0x00CC00AA,string);
		afk[playerid] = 0;
		SetCameraBehindPlayer(playerid);
	return 1;
}

if(strcmp(cmdtext, "/ausentes", true) == 0){
SendClientMessage(playerid,0x008000AA,"|_Players AFK_|");
new Jogador[24];
new count = 0;
new msg[120];
for(new i=0; i<MAX_PLAYERS; i++){
if(IsPlayerConnected(i) && afk[i]){
GetPlayerName(i,Jogador,24);
format(msg,sizeof(msg),"%s", Jogador);
SendClientMessage(playerid, 0x0088CAAA, msg);
count++;
}
}
if(count == 0){
SendClientMessage(playerid, 0xFF0000AA, "Ninguém está AFK!");
}
return 1;
}
//===============================================Comandos Normais Fim===================================

//===============================================Comandos Admins Inicio===================================
//================================================================================
if (strcmp(cmdtext,"/basetc", true)==0)
{
if(IsPlayerAdmin(playerid) == 1)
{
DynUpdateStart(playerid);
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi para A Base Da TC So Adm Vai La!!! ( /basetc )", pname,playerid);
SendClientMessageToAll(0x00FF00FF, string);
ResetPlayerWeapons(playerid);
SetPlayerInterior(playerid,0);
GameTextForPlayer(playerid,"~r~Bem Vindo A ~y~Base Da TC!!!",2500,5);
SetPlayerPos(playerid,1132.3663,-2036.7626,69.0078);
SetPlayerFacingAngle(playerid,273.7028);
SetPlayerArmour(playerid, 100.0);
SetPlayerHealth(playerid, 100.0);
GivePlayerWeapon(playerid,4,0);
GivePlayerWeapon(playerid,39,99999);
GivePlayerWeapon(playerid,40,99999);
GivePlayerWeapon(playerid,32,99999);
GivePlayerWeapon(playerid,31,99999);
GivePlayerWeapon(playerid,34,99999);
SetPlayerSkin(playerid,167);
SetPlayerColor(playerid, Amarelo);
return 1;
}
}
//================================================================================
if (strcmp("/tadmin", cmdtext, true, 10) == 0)
{
if(IsPlayerAdmin(playerid) == 1)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "O Admin %s (ID: %d) se transformou em ADM( /tadmin )", pname,playerid);
SendClientMessageToAll(roxo, string);
GivePlayerMoney(playerid, 99999999);
GivePlayerWeapon(playerid,1,0);
GivePlayerWeapon(playerid,4,0);
GivePlayerWeapon(playerid,15,0);
GivePlayerWeapon(playerid,24,100000);
GivePlayerWeapon(playerid,27,100000);
GivePlayerWeapon(playerid,30,100000);
GivePlayerWeapon(playerid,32,100000);
GivePlayerWeapon(playerid,34,100000);
GivePlayerWeapon(playerid,46,100000);
GivePlayerWeapon(playerid,16,100000);
GivePlayerWeapon(playerid,39,100000);
GivePlayerWeapon(playerid,40,100000);
SetPlayerColor(playerid,COR_LEMON);
SetPlayerSkin(playerid,217);
return 1;
}
}
//================================================================================
if(strcmp(cmdtext,"/acasaadm",true)==0) {
if(IsPlayerAdmin(playerid)){
MoveObject(portao, -2796.488525, -330.162720, 3.462456,1.0);
GameTextForPlayer(playerid,"~r~Portao ~g~Aberto ",2500,3);
SendClientMessage(playerid, roxo, "Abrindo O Portao da Casa Do Adm");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Abriu A Casa do Adm ( /acasaadm )", pname,playerid);
SendClientMessageToAll(roxo, string);
return 1;
}
}
//================================================================================
if(strcmp(cmdtext,"/fcasaadm",true)==0) {
if(IsPlayerAdmin(playerid)){
MoveObject(portao, -2796.356445, -329.915344, 8.812454,1.0);
GameTextForPlayer(playerid,"~r~Portao ~g~Fechado ",2500,3);
SendClientMessage(playerid, roxo, "Fechando O Portao da Casa Do Adm");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Fechou A Casa do Adm ( /fcasaadm )", pname,playerid);
SendClientMessageToAll(roxo, string);
return 1;
}
}
//================================================================================
if(strcmp(cmdtext,"/abasepnx",true)==0) {
if(IsPlayerAdmin(playerid)){
MoveObject(portao2, 1426.8625,-1887.0956,24.7536,1.0);
GameTextForPlayer(playerid,"~r~Portao ~y~Aberto ",2500,3);
SendClientMessage(playerid, COLOR_YELLOW, "Abrindo O Portao da Base Da PnX");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Abriu A Base Da PnX ( /abasepnx )", pname,playerid);
SendClientMessageToAll(roxo, string);
return 1;
}
}
//================================================================================
if(strcmp(cmdtext,"/fbasepnx",true)==0) {
if(IsPlayerAdmin(playerid)){
MoveObject(portao2, 1426.874390, -1888.340942, 15.232559,1.0);
GameTextForPlayer(playerid,"~r~Portao ~y~Fechado ",2500,3);
SendClientMessage(playerid, COLOR_YELLOW, "Fechando O Portao da Base Da PnX");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Fechou A Base Da PnX ( /fbasepnx )", pname,playerid);
SendClientMessageToAll(roxo, string);
return 1;
}
}
if (strcmp("/casaadm", cmdtext, true, 10) == 0)
{
if(IsPlayerAdmin(playerid) == 1)
{
DynUpdateStart(playerid);
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi para A Casa Do Adm So Adm Vai La!!! ( /casaadm )", pname,playerid);
SendClientMessageToAll(0x00FF00FF, string);
ResetPlayerWeapons(playerid);
SetPlayerInterior(playerid,0);
GameTextForPlayer(playerid,"~r~Bem Vindo A ~g~Casa Do Adm ",2500,5);
SetPlayerPos(playerid,-2726.5742,-312.8034,7.0391);
SetPlayerFacingAngle(playerid,51.1942);
SetPlayerArmour(playerid, 100.0);
SetPlayerHealth(playerid, 100.0);
GivePlayerWeapon(playerid,4,0);
GivePlayerWeapon(playerid,39,99999);
GivePlayerWeapon(playerid,40,99999);
GivePlayerWeapon(playerid,32,99999);
GivePlayerWeapon(playerid,31,99999);
GivePlayerWeapon(playerid,34,99999);
SetPlayerSkin(playerid,217);
SetPlayerColor(playerid, COR_LEMON);
SendClientMessage(playerid, COLOR_GREEN, "Use /acasaadm Para Abrir A Casa Do Adm e /fcasaadm Para Fechar a Casa Do adm");
return 1;
}
}
//===============================================Comandos Admins Fim===================================

//===============================================Comandos Teleportes Stunts Inicio===================================
if(strcmp(cmdtext, "/stunt", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,-66.5618,1852.6011,17.2266);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 275.9698);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o Stunt( /stunt )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
   return 1;
}
//================================================================================
if(strcmp(cmdtext, "/lvstunt", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   GameTextForPlayer(playerid,"~w~Bem Vindo ao Stunt em Las Venturas", 3502, 10);
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para os Stunts em Las Venturas!( /lvstunt )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   SetVehiclePos(VehicleID,2067.2166,865.8118,6.7959);
   SetPlayerInterior(playerid,0);
}
   else{
   SetPlayerInterior(playerid,0);
   SetPlayerPos(playerid,2067.2166,865.8118,6.7959);
       }
   return 1;
}
//================================================================================
   if(strcmp(cmdtext, "/aeroportols", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,2140.5278,-2413.2410,13.5469);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o AirportStunt LS( /aeroportols )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
 }
   else{
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o AirportStunt LS( /aeroportols )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,2140.5278,-2413.2410,13.5469);
}
    return 1;
}
//================================================================================
if(strcmp(cmdtext, "/dropexplosivo", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   DynUpdateStart(playerid);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,2523.666,-2715.285,4763.050);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0);
   SetVehicleHealth(GetPlayerVehicleID(playerid),999999);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o Drop Explosivo( /dropexplosivo )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   SetPlayerInterior(playerid,0);
   ResetPlayerWeapons(playerid);
   SetPlayerArmour(playerid, 100.0);
   SetPlayerHealth(playerid, 100.0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
       return 1;
       }
//================================================================================
if(strcmp(cmdtext, "/drop", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   DynUpdateStart(playerid);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,3790.545,-1877.194,1802.409);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 89.0);
   SetVehicleHealth(GetPlayerVehicleID(playerid),999999);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o Drop( /drop )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
   SetPlayerArmour(playerid, 100.0);
   SetPlayerHealth(playerid, 100.0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
   return 1;
}
//================================================================================

       if(strcmp(cmdtext, "/desertstunt", true) == 0) {
       if(IsPlayerInAnyVehicle(playerid)) {
       new VehicleID;
       VehicleID = GetPlayerVehicleID(playerid);
       SetVehiclePos(VehicleID,-662.018,2327.373,139.434);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o deserto Stunt( /desertstunt )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
 }
   else{
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o deserto Stunt( /desertstunt )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,-662.018,2327.373,138.434);
}
    return 1;
}
//================================================================================
if(strcmp(cmdtext, "/atlants", true) == 0) {
   DynUpdateStart(playerid);
   if(IsPlayerInAnyVehicle(playerid)) {
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,426.3199,-2215.1509,-28.2578);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 179.0);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o Reino Perdido de Atlants( /Atlants )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
   SetPlayerArmour(playerid, 100.0);
   SetPlayerHealth(playerid, 100.0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
   return 1;
}
//================================================================================
if(strcmp(cmdtext, "/montanharussa", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   DynUpdateStart(playerid);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,-244.207,2292.398,111.640);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 198.0);
   SetVehicleHealth(GetPlayerVehicleID(playerid),999999);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para a Montanha Russa( /montanharussa )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
   SetPlayerArmour(playerid, 100.0);
   SetPlayerHealth(playerid, 100.0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
   return 1;
}
//================================================================================
	if (strcmp("/aerovelho", cmdtext, true, 10) == 0)
	{
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o antigo aeroporto de las venturas ! ( /aerovelho )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,398.3448,2531.1633,16.5444);
       SetPlayerFacingAngle(playerid,0.0);
       ResetPlayerWeapons(playerid);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
	   return 1;
	}
//================================================================================
    if(strcmp(cmdtext, "/aeroabandonado", true) == 0) {
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi Para O Aero Abandonado( /aeroabandonado )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       SetPlayerPos(playerid, 307.3101,2537.2102,16.8165);
       SetPlayerHealth(playerid, 100.0);
       ResetPlayerWeapons(playerid);
       return 1;
    }
//===============================================Comandos Teleportes Stunts Fim===================================


//===============================================Comandos Teleportes Race Inicio===================================
//================================================================================
if(strcmp(cmdtext, "/flat", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   DynUpdateStart(playerid);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,1547.1683,51.6628,25.5063);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 179.0);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o circuito de FLAT OUT 2( /Flat )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
   SetPlayerArmour(playerid, 100.0);
   SetPlayerHealth(playerid, 100.0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
   return 1;
}
//================================================================================
if(strcmp(cmdtext, "/drift", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,2284.951,1394.029,44.897);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 271.0);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o Drift( /drift )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
   SetPlayerArmour(playerid, 100.0);
   SetPlayerHealth(playerid, 100.0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
   return 1;
}
//================================================================================
   if(strcmp(cmdtext, "/drift2", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,-329.764,1532.244,75.017);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o Drift( /drift2 )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
 }
   else{
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o Drift( /drift2 )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,-329.764,1532.244,75.017);
}
    return 1;
}
//================================================================================
if(strcmp(cmdtext, "/race", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   DynUpdateStart(playerid);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,2068.362,872.231,8.764);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 179.0);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para a Race( /Race )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
   SetPlayerArmour(playerid, 100.0);
   SetPlayerHealth(playerid, 100.0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
   return 1;
}
//================================================================================

if(strcmp(cmdtext, "/race2", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   DynUpdateStart(playerid);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,2103.561,874.452,11.110);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 179.0);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o Race:( /race2 )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
 }
   else{
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para a Corrida( /race2 )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,2103.561,874.452,11.110);
       SetPlayerFacingAngle(playerid,179.0);
}
    return 1;
}

//================================================================================
if(strcmp(cmdtext, "/circuito1", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   DynUpdateStart(playerid);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,2954.5571,-2756.5898,44.4023);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 100.0);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o circuito 1 do Server ! ( /circuito1 )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
   SetPlayerArmour(playerid, 100.0);
   SetPlayerHealth(playerid, 100.0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
   return 1;
}
//================================================================================
if(strcmp(cmdtext, "/circuito2", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   DynUpdateStart(playerid);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,1518.5868,1567.7882,14.8203);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 100.0);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o circuito 2 do Server ! ( /circuito2 )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
   SetPlayerArmour(playerid, 100.0);
   SetPlayerHealth(playerid, 100.0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
   return 1;
}
//================================================================================
if(strcmp(cmdtext, "/circuito3", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   DynUpdateStart(playerid);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,-1231.4513,201.9816,18.1484);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 100.0);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o circuito 3 do Server ! ( /circuito3 )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
   SetPlayerArmour(playerid, 100.0);
   SetPlayerHealth(playerid, 100.0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
   return 1;
}
//================================================================================
if(strcmp(cmdtext, "/circuito4", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   DynUpdateStart(playerid);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,3408.7566,-1309.3259,9.1514);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 100.0);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o circuito 4 do Server ! ( /circuito4 )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
   SetPlayerArmour(playerid, 100.0);
   SetPlayerHealth(playerid, 100.0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
   return 1;
}
//===============================================Comandos Teleportes Race Fim===================================

//===============================================Comandos Teleportes Fun Inicio===================================
if(strcmp(cmdtext, "/derby", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   DynUpdateStart(playerid);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,625.6036,-2120.1682,8.6458);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 100.0);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para a arena derby ! ( /derby )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
   SetPlayerArmour(playerid, 100.0);
   SetPlayerHealth(playerid, 100.0);
 }
   else{
   SendClientMessage(playerid,COR_RED,"VOCÊ PRECISA ESTAR EM UM VEÍCULO!");
   SendClientMessage(playerid,COR_RED,"Vá até o Estacionamento para pegar um( /estacionamento ou /est ).");
       }
   return 1;
}
//================================================================================
if (strcmp("/vortex-voador", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi para Vortex Voador ( /vortex-voador )", pname,playerid);
SendClientMessageToAll(roxo, string);
SetPlayerInterior(playerid,0);
GameTextForPlayer(playerid,"~r~Bem Vindo Ao ~b~Vortex Voador.~g~Voe Com Sabedoria!!!",2500,5);
SetPlayerPos(playerid,-2321.3267,-1647.6564,483.7031);
SetPlayerFacingAngle(playerid,219.6043);
return 1;
}
//================================================================================
if (strcmp("/lv", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi para Las Venturas ( /lv )", pname,playerid);
SendClientMessageToAll(roxo, string);
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"~r~Bem Vindo A ~b Las Venturas",2500,5);
SetPlayerPos(playerid,2057.4209,860.4852,6.7198);
SetPlayerFacingAngle(playerid,3.7816);
return 1;
}
//================================================================================
if (strcmp("/irbanco", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi para o Banco ( /irbanco )", pname,playerid);
SendClientMessageToAll(roxo, string);
SetPlayerInterior(playerid,0);
GameTextForPlayer(playerid,"~r~Bem Vindo Ao ~g~Banco Principal",2500,5);
SetPlayerPos(playerid,2187.8354,1990.4028,10.8203);
SetPlayerFacingAngle(playerid,263.2029);
return 1;
}
//================================================================================
if (strcmp("/est", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi para o estacionamento 2 ( /est )", pname,playerid);
SendClientMessageToAll(roxo, string);
SetPlayerInterior(playerid,0);
GameTextForPlayer(playerid,"~r~Bem Vindo Ao ~y~Estacionamento",2500,5);
SetPlayerPos(playerid,2240.6167,2044.2520,11.0625);
SetPlayerFacingAngle(playerid,185.0127);
return 1;
}
//================================================================================
if (strcmp("/ls", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi para Los Santos ( /ls )", pname,playerid);
SendClientMessageToAll(roxo, string);
SetPlayerInterior(playerid,0);
GameTextForPlayer(playerid,"~r~Bem Vindo A ~b~Los Santos",2500,5);
SetPlayerPos(playerid,1479.3357,-1685.5623,14.0469);
SetPlayerFacingAngle(playerid,176.7125);
return 1;
}
//================================================================================
if (strcmp("/sf", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi para San Fierro ( /sf )", pname,playerid);
SendClientMessageToAll(roxo, string);
SetPlayerInterior(playerid,0);
GameTextForPlayer(playerid,"~r~Bem Vindo A ~b~San Fierro",2500,5);
SetPlayerPos(playerid,-2045.6298,403.1621,35.1719);
SetPlayerFacingAngle(playerid,269.2059);
return 1;
}
//================================================================================
if (strcmp("/ammu", cmdtext, true, 10) == 0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para Ammu Nation  ( /ammu )", pname,playerid);
SendClientMessageToAll(roxo, string);
SetPlayerInterior(playerid,0);
GameTextForPlayer(playerid,"~g~Bem Vindo A ~r~Ammu Nation",2500,5);
SetPlayerPos(playerid,-2625.8215,212.1119,4.6195);
SetPlayerFacingAngle(playerid,180.3922);
return 1;
}
//================================================================================

       if(strcmp(cmdtext, "/parkour", true) == 0) {
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o Parkour( /parkour )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,-2439.281,1544.843,8.059);
return 1;
}

//================================================================================
   if(strcmp(cmdtext, "/chiliad", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,-2351.763,-1644.297,483.363);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi para o Mont Chiliad( /chiliad )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   ResetPlayerWeapons(playerid);
   SetPlayerInterior(playerid,0);
 }
   else{
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o Mont Chiliad( /chiliad )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,-2351.763,-1644.297,483.363);
}
    return 1;
}



//================================================================================
       if(strcmp(cmdtext, "/megajump", true) == 0) {
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o Mega Jump( /megajump)", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,-1064.314,-2212.064,10925.985);
       GivePlayerWeapon(playerid,46,0);

return 1;
}
//================================================================================
       if(strcmp(cmdtext, "/jump", true) == 0) {
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o Jump( /jump )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,2252.396,-929.301,1436.730);
       GivePlayerWeapon(playerid,46,0);

return 1;
}

//================================================================================
if(strcmp(cmdtext, "/natal", true) == 0) {
   if(IsPlayerInAnyVehicle(playerid)) {
   DynUpdateStart(playerid);
   new VehicleID;
   VehicleID = GetPlayerVehicleID(playerid);
   SetVehiclePos(VehicleID,1940.7108,1473.2377,10.8203);
   SetVehicleZAngle(GetPlayerVehicleID(playerid), 1.1258);
   new pname[MAX_PLAYER_NAME];
   GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
   format(string, sizeof(string), "%s (ID: %d) Foi Ver A Arvore De Natal( /natal )", pname,playerid);
   SendClientMessageToAll(roxo, string);
   SetPlayerInterior(playerid,0);
 }
   else{
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi Ver A Arvore De Natal( /natal )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,1940.7108,1473.2377,10.8203);
       SetPlayerFacingAngle(playerid,1.1258);
}
    return 1;
}
//==============================================================================
if(strcmp(cmdtext, "/golfclube", true) == 0) {
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) foi para o Clube de Golf( /golfclube )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,1444.2400,2816.0571,10.8247);
       SetPlayerFacingAngle(playerid,0.0199);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
       GivePlayerWeapon(playerid,2,0);
   return 1;
}
//================================================================================
if(strcmp(cmdtext, "/pulardeparaquedas", true) == 0) {
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi Pular De Paraquedas (/pulardeparaquedas)", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,430.3645,-2246.8105,614.2421);
       SetPlayerFacingAngle(playerid,226.0);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
       GivePlayerWeapon(playerid,46,1);
   return 1;
}
//================================================================================
if(strcmp(cmdtext, "/estacionamento", true) == 0) {
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o Estacionamento( /estacionamento )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,-30.963,1509.681,12.556);
       SetPlayerFacingAngle(playerid,101.0);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
   return 1;
}
//================================================================================
if (strcmp(cmdtext, "/lc", true)==0)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi para Liberty City ! ( /lc )", pname,playerid);
SendClientMessageToAll(roxo, string);
SetPlayerInterior(playerid,1);
SetPlayerPos(playerid,-732.0,504.0,1372.5);
SetPlayerArmour(playerid, 100.0);
SetPlayerHealth(playerid, 100.0);
return 1;
}

//===============================================Comandos Teleportes Fun Fim===================================

//===============================================Comandos Teleportes DM Inico===================================
//================================================================================
if(strcmp(cmdtext, "/x1", true) == 0) {
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,1111.1134,1727.9189,12.9423);
       SetPlayerFacingAngle(playerid,271.0);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
       GivePlayerWeapon(playerid,4,0);
       GivePlayerWeapon(playerid,26,9999);
       GivePlayerWeapon(playerid,31,9999);
       GivePlayerWeapon(playerid,24,9999);
       GivePlayerWeapon(playerid,32,9999);
       nox1[playerid] = 1;
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o X1 ! ( /x1 )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       SendClientMessage(playerid, 0xFF0000AA, "Voce entrou em um DM!");
       SendClientMessage(playerid, 0x008000AA, "Use /sairdm Para Sair.");
   return 1;
}
//================================================================================
if(strcmp(cmdtext, "/crazyarena", true) == 0) {
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para a Crazy Arena( /crazyarena )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,229.359,-1807.635,4.141);
       SetPlayerFacingAngle(playerid,226.0);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
       GivePlayerWeapon(playerid,9,0);
       GivePlayerWeapon(playerid,46,0);
       GivePlayerWeapon(playerid,16,0);
       GivePlayerWeapon(playerid,26,9999);
       GivePlayerWeapon(playerid,31,9999);
       GivePlayerWeapon(playerid,24,9999);
       GivePlayerWeapon(playerid,32,9999);
       SendClientMessage(playerid, 0xFF0000AA, "Voce entrou em um DM!");
       SendClientMessage(playerid, 0x008000AA, "Use /sairdm Para Sair.")
nox1[playerid] = 1;   
return 1;
}
//================================================================================
if(strcmp(cmdtext, "/arenax1", true) == 0) {
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para a Arena x1 ( /arenax1 )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,1437.3440,1677.8251,10.8203);
       SetPlayerFacingAngle(playerid,4.1726);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
       GivePlayerWeapon(playerid,4,0);
       GivePlayerWeapon(playerid,26,9999);
       GivePlayerWeapon(playerid,31,9999);
       GivePlayerWeapon(playerid,24,9999);
       GivePlayerWeapon(playerid,32,9999);
       SendClientMessage(playerid, 0xFF0000AA, "Voce entrou em um DM!");
       SendClientMessage(playerid, 0x008000AA, "Use /sairdm Para Sair.")
nox1[playerid] = 1;      
 return 1;
}
//================================================================================
	if (strcmp("/shipwar", cmdtext, true, 10) == 0)
	{
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para a Ship War ! ( /shipwar )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,-649.646,-5357.238,0.773);
       SetPlayerFacingAngle(playerid,259.0);
       ResetPlayerWeapons(playerid);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
       GivePlayerWeapon(playerid,8,0);
       GivePlayerWeapon(playerid,32,9999);
       GivePlayerWeapon(playerid,26,9999);
       GivePlayerWeapon(playerid,16,9999);
       SendClientMessage(playerid, 0xFF0000AA, "Voce entrou em um DM!");
       SendClientMessage(playerid, 0x008000AA, "Use /sairdm Para Sair.")
nox1[playerid] = 1;
	   return 1;
	}

//================================================================================
    if(strcmp(cmdtext, "/sniperdm", true) == 0) {
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para a Sniper DM ! ( /sniperdm )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,183.111,1934.011,17.531);
       SetPlayerFacingAngle(playerid,89.0);
       ResetPlayerWeapons(playerid);
       GivePlayerWeapon(playerid,34,9999);
       SendClientMessage(playerid, 0xFF0000AA, "Voce entrou em um DM!");
       SendClientMessage(playerid, 0x008000AA, "Use /sairdm Para Sair.")
nox1[playerid] = 1;
       return 1;
    }
//================================================================================
	if (strcmp("/arenasangrenta", cmdtext, true, 10) == 0)
	{
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para a arena sangrenta ! ( /arenasangrenta )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,-2023.076,-961.297,31.825);
       SetPlayerFacingAngle(playerid,250.0);
       ResetPlayerWeapons(playerid);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
       GivePlayerWeapon(playerid,8,0);
       GivePlayerWeapon(playerid,32,9999);
       GivePlayerWeapon(playerid,26,9999);
       GivePlayerWeapon(playerid,33,9999);
       GivePlayerWeapon(playerid,30,9999);
       GivePlayerWeapon(playerid,16,9999);
       SendClientMessage(playerid, 0xFF0000AA, "Voce entrou em um DM!");
       SendClientMessage(playerid, 0x008000AA, "Use /sairdm Para Sair.")
nox1[playerid] = 1;
	   return 1;
	}
//================================================================================
	if (strcmp("/remotedm", cmdtext, true, 10) == 0)
	{
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para a Remote DM ! ( /remotedm )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,1612.075,1164.837,13.879);
       SetPlayerFacingAngle(playerid,0.0);
       ResetPlayerWeapons(playerid);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
       GivePlayerWeapon(playerid,40,9999);
       GivePlayerWeapon(playerid,39,9999);
       SendClientMessage(playerid, 0xFF0000AA, "Voce entrou em um DM!");
       SendClientMessage(playerid, 0x008000AA, "Use /sairdm Para Sair.")
nox1[playerid] = 1;
	   return 1;
	}
//================================================================================
       if(strcmp(cmdtext, "/arenadm", true) == 0) {
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o Arena DM( /arenadm )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,1777.283,-1805.586,52.129);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
       ResetPlayerWeapons(playerid);
       GivePlayerWeapon(playerid,4,0);
       GivePlayerWeapon(playerid,26,9999);
       GivePlayerWeapon(playerid,31,9999);
       GivePlayerWeapon(playerid,24,9999);
       GivePlayerWeapon(playerid,32,9999);
       SendClientMessage(playerid, 0xFF0000AA, "Voce entrou em um DM!");
       SendClientMessage(playerid, 0x008000AA, "Use /sairdm Para Sair.")
nox1[playerid] = 1;
return 1;
}
//================================================================================
       if(strcmp(cmdtext, "/arenadm2", true) == 0) {
       DynUpdateStart(playerid);
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para a Arena DM 2 /arenadm2 )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,-2729.083,671.718,65.754);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
       ResetPlayerWeapons(playerid);
       GivePlayerWeapon(playerid,4,0);
       GivePlayerWeapon(playerid,26,9999);
       GivePlayerWeapon(playerid,31,9999);
       GivePlayerWeapon(playerid,24,9999);
       GivePlayerWeapon(playerid,32,9999);
       SendClientMessage(playerid, 0x00FF00FF, "Boa sorte!");
       SendClientMessage(playerid, 0xFF0000AA, "Voce entrou em um DM!");
       SendClientMessage(playerid, 0x008000AA, "Use /sairdm Para Sair.")
nox1[playerid] = 1;
return 1;
}
//================================================================================
       if(strcmp(cmdtext, "/sniperdm2", true) == 0) {
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi para o Sniper DM( /sniperdm )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,183.111,1934.011,17.531);
       SetPlayerArmour(playerid, 100.0);
       SetPlayerHealth(playerid, 100.0);
       ResetPlayerWeapons(playerid);
       GivePlayerWeapon(playerid,34,9999);
       SendClientMessage(playerid, COLOR_WHITE, "Suba em uma torre e comece a atirar!");
       SendClientMessage(playerid, 0xFF0000AA, "Voce entrou em um DM!");
       SendClientMessage(playerid, 0x008000AA, "Use /sairdm Para Sair.")
nox1[playerid] = 1;
return 1;
}

//================================================================================
       if(strcmp(cmdtext, "/becols", true) == 0) {
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi Para o Beco De Los Santos( /becols )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,1371.1777,-1651.1398,13.3828);
       SetPlayerFacingAngle(playerid,182.6544);
return 1;
}
//================================================================================
       if(strcmp(cmdtext, "/becosf", true) == 0) {
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi Para o Beco De San Fierro( /becosf )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,-2181.1729,642.0693,49.4375);
       SetPlayerFacingAngle(playerid,262.9254);
return 1;
}
//================================================================================
     if(strcmp(cmdtext, "/becolv", true) == 0) {
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Foi Para o Beco De Las Venturas( /becolv )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       SetPlayerInterior(playerid,0);
       SetPlayerPos(playerid,2352.7693,2770.9922,10.8203);
       SetPlayerFacingAngle(playerid,7.2455);
return 1;
}
//===============================================Comandos Teleportes Fim==================================
return SendClientMessage(playerid, 0xFF0000AA, "Comando Invalido");
}



public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new str[256];
    new oldnew;
	if (newstate == 2 || newstate == 3)
    {
    if (oldnew == 0)
    	{
        format(str, sizeof(str), "~b~%s",vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
        GameTextForPlayer(playerid, str, 6000, 1);
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
new string[256];
new checknome = CPS_GetPlayerCheckpoint(playerid);
if(checknome == Banco) {
SendClientMessage(playerid, Verde, "|___Banco___|");
GameTextForPlayer(playerid, "~w~Banco", 5000, 6);
SendClientMessage(playerid, COLOR_WHITE, "Para depositar use /depositar [quantia]");    
SendClientMessage(playerid, COLOR_WHITE, "Para sacar use /sacar [quantia]");    
SendClientMessage(playerid, COLOR_WHITE, "Para ver seu saldo use /saldo");    
SendClientMessage(playerid, COLOR_WHITE, "Para ver seu saldo por meio de SMS use /saldocell");    
SendClientMessage(playerid, COLOR_WHITE, "Obs: Necessita ter uma conta bancária, e um celular para usar /saldocell.");    
SendClientMessage(playerid, COLOR_WHITE, "Para abrir uma conta use /abrirconta.");
 }
if(checknome == pickarmas){
ShowPlayerDialog(playerid, Menugang, DIALOG_STYLE_LIST, "Menu Da Gangs", "Gangs\nArmas", "OK", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta no Beco Vendo Armas e Gangs", pname,playerid);
SendClientMessageToAll(roxo, string);
	}
if(checknome == pickarmas2){
ShowPlayerDialog(playerid, Menugang, DIALOG_STYLE_LIST, "Menu Da Gangs", "Gangs\nArmas", "OK", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta no Beco Vendo Armas e Gangs", pname,playerid);
SendClientMessageToAll(roxo, string);
	}
if(checknome == pickarmas3){
ShowPlayerDialog(playerid, Menugang, DIALOG_STYLE_LIST, "Menu Da Gangs", "Gangs\nArmas", "OK", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta no Beco Vendo Armas e Gangs", pname,playerid);
SendClientMessageToAll(roxo, string);
	}
if(checknome == sexshop){
ShowPlayerDialog(playerid, sexshops, DIALOG_STYLE_LIST, "Sex Shop", "Pinto De Borracha-R$ 100\nVibrador Pequeno-R$50\nVibrador Largo-R$120\nVibrador Prateado-R$150", "Comprar", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta no Sex Shop Se Divertindo", pname,playerid);
SendClientMessageToAll(roxo, string);
	}
if(checknome == sexshop2){
ShowPlayerDialog(playerid, sexshops, DIALOG_STYLE_LIST, "Sex Shop", "Pinto De Borracha-R$ 100\nVibrador Pequeno-R$50\nVibrador Largo-R$120\nVibrador Prateado-R$150", "Comprar", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta no Sex Shop Se Divertindo", pname,playerid);
SendClientMessageToAll(roxo, string);
	}
if(checknome == portaoclube2){
ShowPlayerDialog(playerid,clubes, DIALOG_STYLE_LIST, "Menu Do Portao Do Clube", "Abrir Portao - R$ 50", "Abrir", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta Abrindo O Clube", pname,playerid);
SendClientMessageToAll(roxo, string);
	}
if(checknome == portaoclube1){
ShowPlayerDialog(playerid,clubes2, DIALOG_STYLE_LIST, "Menu Do Portao Do Clube", "Abrir Portao - R$ 50", "Abrir", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta Abrindo O Clube", pname,playerid);
SendClientMessageToAll(roxo, string);
	}
	return 1;
}

forward ExplodeShamal(vehicleid);

stock CreateShamalInt(vehicleid, Float:X, Float:Y, Float:Z)
{
	CreateObject(14404, X, Y, Z, 0.0, 0.0, 0.0);
	CreateObject(1562, floatadd(X, difc[0][0]), floatadd(Y, difc[0][1]), floatsub(Z, difc[0][2]), 0.0, 0.0, difc[0][3]);
	CreateObject(1562, floatadd(X, difc[1][0]), floatsub(Y, difc[1][1]), floatsub(Z, difc[1][2]), 0.0, 0.0, difc[1][3]);
	CreateObject(1562, floatadd(X, difc[2][0]), floatsub(Y, difc[2][1]), floatsub(Z, difc[2][2]), 0.0, 0.0, difc[2][3]);
	CreateObject(1562, floatsub(X, difc[3][0]), floatsub(Y, difc[3][1]), floatsub(Z, difc[3][2]), 0.0, 0.0, difc[3][3]);
	CreateObject(1562, floatsub(X, difc[4][0]), floatsub(Y, difc[4][1]), floatsub(Z, difc[4][2]), 0.0, 0.0, difc[4][3]);
	CreateObject(1562, floatsub(X, difc[5][0]), floatsub(Y, difc[5][1]), floatsub(Z, difc[5][2]), 0.0, 0.0, difc[5][3]);
	CreateObject(1563, floatadd(X, difc[6][0]), floatadd(Y, difc[6][1]), floatsub(Z, difc[6][2]), 0.0, 0.0, difc[6][3]);
	CreateObject(1563, floatadd(X, difc[7][0]), floatsub(Y, difc[7][1]), floatsub(Z, difc[7][2]), 0.0, 0.0, difc[7][3]);
	CreateObject(1563, floatadd(X, difc[8][0]), floatsub(Y, difc[8][1]), floatsub(Z, difc[8][2]), 0.0, 0.0, difc[8][3]);
	CreateObject(1563, floatsub(X, difc[9][0]), floatsub(Y, difc[9][1]), floatsub(Z, difc[9][2]), 0.0, 0.0, difc[9][3]);
	CreateObject(1563, floatsub(X, difc[10][0]), floatsub(Y, difc[10][1]), floatsub(Z, difc[10][2]), 0.0, 0.0, difc[10][3]);
	CreateObject(1563, floatsub(X, difc[11][0]), floatsub(Y, difc[11][1]), floatsub(Z, difc[11][2]), 0.0, 0.0, difc[11][3]);
	CreateObject(14405, X, floatsub(Y, difc[12][1]), floatsub(Z, difc[12][2]), 0.0, 0.0, difc[12][3]);
	ShamalPos[vehicleid][0] = X, ShamalPos[vehicleid][1] = Y, ShamalPos[vehicleid][2] = Z;
}

stock SetPlayerPosInShamal(playerid, shamalid)
{
	SetPlayerPos(playerid, ShamalPos[shamalid][0],
	floatsub(ShamalPos[shamalid][1], 5.87),
	floatsub(ShamalPos[shamalid][2], 0.75));
	SetPlayerFacingAngle(playerid, 0.0);
	SetCameraBehindPlayer(playerid);
}

stock ShamalExists(vehicleid)
{
	if (floatsqroot(floatadd(ShamalPos[vehicleid][0], floatadd(ShamalPos[vehicleid][1], ShamalPos[vehicleid][2]))))
	{
		return 1;
	}
	return 0;
}

stock randomEx(randval)
{
	new rand1 = random(2), rand2;
	if (!rand1) rand2 -= random(randval);
	else rand2 += random(randval);
	return rand2;
}

public MudarNomeDOServer()
{
    count2 ++;
    if(count2 > 4)count2 = 0;
    new string[129];
    format(string, sizeof(string), "hostname %s", SVNAMES[count2]);
    SendRconCommand(string);
}

public RandomMSGs()
{
	new string[256];
	new random1 = random(sizeof(MSGs));
	new random2 = random(sizeof(COLORS));
	format(string, sizeof(string), "%s", MSGs[random1]);
	SendClientMessageToAll(COLORS[random2],string);
	return 1;
}


public CountDown(){
    if (Count > 0){
    GameTextForAll( CountText[Count-1], 2500, 3);
    Count--;
    SetTimer("CountDown", 1000, 0);
    }
    else{
    GameTextForAll("~g~Vai Vai Vai!!!", 2500, 3);
    Count = 5;
    }
    return 1;
}

public portaoclube()
{
	MoveObject(clube,829.460205, -1872.485107, 14.640579,4.0);
	MoveObject(clube2,843.172974, -1872.689453, 14.640579,4.0);	
return 1;
}

public DynUpdateStart(playerid)
{
TogglePlayerControllable(playerid, false);
new string[255];
format(string, sizeof(string), "~g~CARREGANDO ~b~OBJETOS ~w~!");
GameTextForPlayer(playerid, string, 3000, 6);
PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
SetTimerEx("DynUpdateEnd", 5000, 0,"e",playerid);
return 1;
}
//------------------------------------------------------------------------------------------------------
public DynUpdateEnd(playerid)
{
TogglePlayerControllable(playerid, true);
new string[255];
format(string, sizeof(string), "~g~OBJETOS ~b~CARREGADOS ~w~!");
GameTextForPlayer(playerid, string, 3000, 6);
PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
//news========================================
new string[256];  
new car;
car = GetPlayerVehicleID(playerid);
//fim=========================================

if(dialogid == AVISO)
	{
	if(response == 1)
 	{
 	  	if(PlayerInfo[playerid][Logged] == 0){
			format(file, sizeof(file), PASTA_CONTAS, PlayerName(playerid));
			if(!dini_Exists(file))
			{
	    	format(STRX, sizeof(STRX), "Você não tem conta, %s!\n\nColoque sua senha e clique em \"Registrar\".", PlayerName(playerid));
	    	ShowPlayerDialog(playerid, REGISTRO, DIALOG_STYLE_INPUT, "Registrando uma conta", STRX, "Registrar", "Sair");
			}
			if(dini_Exists(file))
			{
	    	format(STRX, sizeof(STRX), "Bem-vindo(a) de volta, %! Logue-se em sua conta.\n\nColoque sua senha e clique em \"Logar\".", PlayerName(playerid));
	    	ShowPlayerDialog(playerid, LOGIN, DIALOG_STYLE_INPUT, "Logando em sua conta", STRX, "Logar", "Sair");
		}
		}
		}
		else
		{
		new stringz[256];
	    format(stringz, sizeof(stringz), "[Admin BOT]: %s tomou kick automático. [Motivo: Nao Registrou]", PlayerName(playerid));
	    SendClientMessageToAll(Verde,stringz);
	    Kick(playerid);
		}
	}
	format(file, sizeof(file), PASTA_CONTAS, PlayerName(playerid));
	if(dialogid == REGISTRO)
	{
	    if(response == 1)
	    {
	        if(strlen(inputtext) < MIN_SENHA || strlen(inputtext) > MAX_SENHA)
	        {
	            format(STRX, sizeof(STRX), "A senha deve ter entre %d e %d caracteres!", MIN_SENHA, MAX_SENHA);
	            SendClientMessage(playerid, Vermelho, STRX);
	    		format(STRX, sizeof(STRX), "Senha muito grande ou pequena, %s!\nColoque sua senha e clique em \"Registrar\".", PlayerName(playerid));
	    		ShowPlayerDialog(playerid, REGISTRO, DIALOG_STYLE_INPUT, "Registrando uma conta", STRX, "Registrar", "Sair");
	            return 1;
			}
			dini_Create(file);
			dini_Set(file, "Senha", encrypt(inputtext));
            GivePlayerMoney(playerid, 500);
        	SendClientMessage(playerid, Verde, "Conta registrada e logada!");
			PlayerInfo[playerid][Logged] = 1;
                   
		}
		else
		{
	    format(STRX, sizeof(STRX), "Bom Voce Tem que se Registrar Para Jogar %s!\nColoque sua senha e clique em \"Registrar\".", PlayerName(playerid));
	    ShowPlayerDialog(playerid, REGISTRO, DIALOG_STYLE_INPUT, "Registrando uma conta", STRX, "Registrar", "Sair");
		}
	}
	if(dialogid == LOGIN)
	{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, sizeof(aname));
format(file, sizeof(file), PASTA_CONTAS, aname);
	    if(response == 1)
	    {
	            new pass_confirm[256];
	            pass_confirm = dini_Get(file, "Senha");
	            if(strcmp(encrypt(inputtext), pass_confirm, true) == 0)
	                 {
	            PlayerInfo[playerid][Logged] = 1;
	            SendClientMessage(playerid, Verde, "[INFO] Logado com sucesso.");
            }
			else
			{
			    PlayerInfo[playerid][LoginsFalsos]++;
			    if(PlayerInfo[playerid][LoginsFalsos] >= TENTATIVAS_LOGIN)
			    {
			        format(STRX, sizeof(STRX), "[TCAdmin] %s tomou kick automático | Motivo: %d tentativas de login", aname, TENTATIVAS_LOGIN);
		        	SendClientMessageToAll(0xFF2F2FAA, STRX);
		        	Kick(playerid);
				}
				else
				{
    			SendClientMessage(playerid, Vermelho, "Senha incorreta!");
	    		format(STRX, sizeof(STRX), "Senha incorreta, %! Logue-se em sua conta.\n\nColoque sua senha e clique em \"Logar\".", aname);
	    		ShowPlayerDialog(playerid, LOGIN, DIALOG_STYLE_INPUT, "Logando em sua conta", STRX, "Logar", "Sair");
				}
			}
		}
		else
		{
	    		format(STRX, sizeof(STRX), "Bom Voce Tem que Logar ou nao podera jogar, %! Logue-se em sua conta.\n\nColoque sua senha e clique em \"Logar\". \n\n The Crimes RPG!.",aname);
	    		ShowPlayerDialog(playerid, LOGIN, DIALOG_STYLE_INPUT, "Logando em sua conta", STRX, "Logar", "Sair");
		}
	}
if(dialogid == Menugame) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
ShowPlayerDialog(playerid, timecs, DIALOG_STYLE_LIST, "Menu de Games", "Terrorista\nContra-Terrorista", "OK", "Cancelar");     
                    } 
          if(listitem == 1) 
			{
nogame[playerid] = 1;
DynUpdateStart(playerid);
new carbatebate;
carbatebate = CreateVehicle(539,3064.8015,404.9203,4.8072,296.4110,0,1,60); 
PutPlayerInVehicle(playerid,carbatebate,0);
SendClientMessage(playerid, 0xFF0000AA, "Voce entrou No Game Bate-Bate.");
SendClientMessage(playerid, 0x008000AA, "Use /sairgame Para Sair.");
                    }
                    }                    
                    }  

if(dialogid == timecs) 
	{
		if(response)
		{
   			if(listitem == 0)//terrorista 
			{
DynUpdateStart(playerid);
SetPlayerPos(playerid,3293.6619,-1867.3699,45.1846);    
SetPlayerSkin(playerid,294);
SetPlayerColor(playerid, 0xFF0000AA);
GivePlayerWeapon(playerid,30,99999); // ak
GivePlayerWeapon(playerid,24,99999); // Desert
GivePlayerWeapon(playerid,28,99999); // uzi
GivePlayerWeapon(playerid,34,99999); // awp
GivePlayerWeapon(playerid,16,99999); // granada
SendClientMessage(playerid, 0xFF0000AA, "Voce Entrou no time Dos Terroristas");
SendClientMessage(playerid, 0x008000AA, "Use /sairgame Para Sair.");
nogame[playerid] = 1;
	  }
   			if(listitem == 1)//Contra Terrorista 
			{
DynUpdateStart(playerid);
SetPlayerPos(playerid,3321.1628,-1995.6696,45.3614);  
SetPlayerSkin(playerid, 287);
SetPlayerColor(playerid, 0x0000FFAA);	
GivePlayerWeapon(playerid,31,99999); // M4
GivePlayerWeapon(playerid,24,99999); // Desert
GivePlayerWeapon(playerid,29,99999); // mp5
GivePlayerWeapon(playerid,34,99999); // awp
GivePlayerWeapon(playerid,16,99999); // granada
SendClientMessage(playerid, 0xFF0000AA, "Voce Entrou no time Dos Contra-Terroristas");
SendClientMessage(playerid, 0x008000AA, "Use /sairgame Para Sair.");
nogame[playerid] = 1;
} 
}                    
}
if(dialogid == clubes) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
MoveObject(clube2,843.147705, -1872.769165, 7.018070,2.0);
GameTextForPlayer(playerid,"~r~Portao ~g~Aberto",2500,3);
SendClientMessage(playerid, roxo, "Abrindo O Portao do Clube");
SetTimer("portaoclube", 6000, false);
                    }                    
                    }
                    }
if(dialogid == clubes2) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
new grana;
grana = GetPlayerMoney(playerid);
if(grana > 49){
MoveObject(clube,829.445923,-1872.439697,8.137922,2.0);
GameTextForPlayer(playerid,"~r~Portao ~g~Aberto",2500,3);
SendClientMessage(playerid, roxo, "Abrindo O Portao do Clube");
SetTimer("portaoclube", 6000, false);
GivePlayerMoney(playerid,-50);
 } else {
SendClientMessage(playerid, Vermelho, "Você não tem dinheiro para Abrir o Clube");
                    } 
                    } 
                    }                    
                    }

if(dialogid == sexshops) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Um Penis De Buracha");
GivePlayerMoney(playerid, -100);
GivePlayerWeapon(playerid,10,99999); //Pinto	                         }
   			    }
               if(listitem == 1) 
			{
GivePlayerWeapon(playerid,11,99999); //VibradorPequeno
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Um Vibrador Pequeno");	   		
GivePlayerMoney(playerid, -50);
	                 }
			if(listitem == 2) 
			{
GivePlayerWeapon(playerid,12,99999); //Vibrado Largo
SendClientMessage(playerid, 0x008000AA, "Voce Comprou um Vibrador Largo");
GivePlayerMoney(playerid,-120);
                    }                     
			if(listitem == 3) 
			{
GivePlayerWeapon(playerid,13,99999); //Silver Vibrado
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Um Vibrador De Prata");
GivePlayerMoney(playerid,-150);
                    } 
                    }                    
                    }


if(dialogid == Gangs) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Entro Na Gang Dos Groove Street( /beco )", pname,playerid);
SendClientMessageToAll(roxo, string);    
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"Bem Vindo A GanG Groove Street!!!",2500,3);
GivePlayerWeapon(playerid,23,99999);
GivePlayerWeapon(playerid,31,99999);
GivePlayerWeapon(playerid,32,99999);
GivePlayerWeapon(playerid,26,99999);
SetPlayerSkin(playerid,107);
SetPlayerColor(playerid, COLOR_GREEN);
SetPlayerPos(playerid,2495.3728,-1687.5945,13.5161);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,1.8559);
		                }
   			if(listitem == 1) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Entro Na Gang Dos Ballas( /beco)", pname,playerid);
SendClientMessageToAll(roxo, string);    
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"Bem Vindo A GanG Dos Ballas!!!",2500,3);
GivePlayerWeapon(playerid,30,99999);
GivePlayerWeapon(playerid,24,99999);
GivePlayerWeapon(playerid,29,99999);
GivePlayerWeapon(playerid,37,99999);
SetPlayerSkin(playerid,104);
SetPlayerColor(playerid, COR_DARKROXO);
SetPlayerPos(playerid,1959.9818,-1197.9978,27.2088);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,90.9438);	   		
	                 }
			if(listitem == 2) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Entro Na Gang Dos Frangos( /beco )", pname,playerid);
SendClientMessageToAll(roxo, string);    
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"Bem Vindo A Gang Dos Frangos!!!",2500,3);
GivePlayerWeapon(playerid,4,0);
GivePlayerWeapon(playerid,24,99999);
GivePlayerWeapon(playerid,26,99999);
GivePlayerWeapon(playerid,30,99999);
GivePlayerWeapon(playerid,32,99999);
GivePlayerWeapon(playerid,18,10);
SetPlayerSkin(playerid,167);
SetPlayerColor(playerid, COLOR_YELLOW);
                    }
                 if(listitem == 3) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Entro Na Gang Dos Aztecas( /beco )", pname,playerid);
SendClientMessageToAll(roxo, string);    
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"Bem Vindo A Gang Dos Aztecas!!!",2500,3);
GivePlayerWeapon(playerid,30,99999);
GivePlayerWeapon(playerid,4,0);
GivePlayerWeapon(playerid,28,99999);
GivePlayerWeapon(playerid,25,99999);
SetPlayerSkin(playerid,115);
SetPlayerColor(playerid,COR_MARROM);
SetPlayerPos(playerid,2638.8899,-1993.3119,13.9935);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,226.4027);
                      }
			if(listitem == 4) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Entro Na Gang Dos Vagos ( /beco )", pname,playerid);
SendClientMessageToAll(roxo, string);    
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"Bem Vindo A Gang Dos Vagos!!!",2500,3);
GivePlayerWeapon(playerid,24,99999);
GivePlayerWeapon(playerid,26,99999);
GivePlayerWeapon(playerid,28,99999);
GivePlayerWeapon(playerid,25,99999);
SetPlayerSkin(playerid,108);
SetPlayerColor(playerid,COLOR_GREY);
SetPlayerPos(playerid,2143.9407,-1683.5302,15.0859);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,261.9361);
                           }
                       if(listitem == 5) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Entro Na Gang Dos Nangs-Boys ( /beco )", pname,playerid);
SendClientMessageToAll(roxo, string);  
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"Bem Vindo A Gang Dos Nangs Boys!!!",2500,3);
GivePlayerWeapon(playerid,4,0);
GivePlayerWeapon(playerid,22,99999);
GivePlayerWeapon(playerid,24,99999);
GivePlayerWeapon(playerid,30,99999);
SetPlayerSkin(playerid,122);
SetPlayerColor(playerid,COLOR_ORANGE);
SetPlayerPos(playerid,-2650.0681,1373.5823,12.2512);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,184.0100);
                           }                           
                           if(listitem == 6) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Entro Na Gang Dos Triads ( /beco )", pname,playerid);
SendClientMessageToAll(roxo, string);  
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"Bem Vindo A Gang Dos Triads!!!",2500,3);
GivePlayerWeapon(playerid,23,99999);
GivePlayerWeapon(playerid,31,99999);
GivePlayerWeapon(playerid,32,99999);
GivePlayerWeapon(playerid,26,99999);
SetPlayerSkin(playerid,117);
SetPlayerColor(playerid,COR_ROSA);
SetPlayerPos(playerid,-2207.7107,625.1318,49.4378);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,179.1503);
                           }
                            if(listitem == 7) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Entro Na Gang Dos Bikers ( /beco )", pname,playerid);
SendClientMessageToAll(roxo, string);  
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"Bem Vindo A Gang Dos Bikers!!!",2500,3);
GivePlayerWeapon(playerid,4,0);
GivePlayerWeapon(playerid,25,99999);
GivePlayerWeapon(playerid,32,99999);
GivePlayerWeapon(playerid,30,99999);
SetPlayerSkin(playerid,248);
SetPlayerColor(playerid,COR_TURCA);
SetPlayerPos(playerid,-587.2010,-1053.2687,23.4304);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,244.4728);
                           }                           
                   if(listitem == 8) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Entro Na Gang Dos Mafiosos ( /beco )", pname,playerid);
SendClientMessageToAll(roxo, string);  
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"Bem Vindo A Gang Dos Mafiosos!!!",2500,3);
GivePlayerWeapon(playerid,4,0);
GivePlayerWeapon(playerid,24,99999);
GivePlayerWeapon(playerid,26,99999);
GivePlayerWeapon(playerid,30,99999);
GivePlayerWeapon(playerid,32,99999);
GivePlayerWeapon(playerid,18,10);
SetPlayerSkin(playerid,124);
SetPlayerColor(playerid,COR_MAGENTA);
SetPlayerPos(playerid,2616.2285,1807.4331,10.8203);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,90.0951);
                           }                           
                 if(listitem == 9)  
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Entro Na Gang Dos LSPD ( /beco )", pname,playerid);
SendClientMessageToAll(roxo, string);  
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"Bem Vindo A Gang Dos Policiais De Los Santos!!!",2500,3);
GivePlayerWeapon(playerid,27,99999);
GivePlayerWeapon(playerid,24,99999);
GivePlayerWeapon(playerid,29,99999);
GivePlayerWeapon(playerid,31,99999);
GivePlayerWeapon(playerid,32,99999);
SetPlayerSkin(playerid,285);
SetPlayerColor(playerid,COLOR_LIGHTBLUE);
SetPlayerPos(playerid,1589.2607,-1622.3763,13.3828);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,92.6879);
                           }
                 if(listitem == 10)  
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Entro Na Gang Dos SFPD ( /beco )", pname,playerid);
SendClientMessageToAll(roxo, string);  
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"Bem Vindo A Gang Dos Policiais De San Fierro!!!",2500,3);
GivePlayerWeapon(playerid,27,99999);
GivePlayerWeapon(playerid,24,99999);
GivePlayerWeapon(playerid,29,99999);
GivePlayerWeapon(playerid,31,99999);
GivePlayerWeapon(playerid,32,99999);
SetPlayerSkin(playerid,285);
SetPlayerColor(playerid,0x800000AA);
SetPlayerPos(playerid,-1637.6677,662.0030,7.1875);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,263.3492);
                           }                           
              if(listitem == 11)  
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Entro Na Gang Dos LVPD ( /beco )", pname,playerid);
SendClientMessageToAll(roxo, string);  
ResetPlayerWeapons(playerid);
GameTextForPlayer(playerid,"Bem Vindo A Gang Dos Policiais De Las Venturas!!!",2500,3);
GivePlayerWeapon(playerid,27,99999);
GivePlayerWeapon(playerid,24,99999);
GivePlayerWeapon(playerid,29,99999);
GivePlayerWeapon(playerid,31,99999);
GivePlayerWeapon(playerid,32,99999);
SetPlayerSkin(playerid,285);
SetPlayerColor(playerid,0x8000FFAA);
SetPlayerPos(playerid,2296.5537,2468.4824,10.8203);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,88.0272);
                           }

}
		}
//============================================================================================================================================================================================================
    if(dialogid == COR) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
            SetPlayerColor(playerid, 0xFF0000AA);
              SendClientMessage(playerid, 0xFF0000AA, "Você Altero Sua Cor Para Vermelho");
		                         }
   			if(listitem == 1) 
			{
		SetPlayerColor(playerid, 0xFFFF00AA);		 
              SendClientMessage(playerid, 0xFFFF00AA, "Você Altero Sua Cor Para Amarelo");
	   		
	                 }
			if(listitem == 2) 
			{
                     	SetPlayerColor(playerid, 0x80FFFFAA);		 
              SendClientMessage(playerid, 0x80FFFFAA, "Você Altero Sua Cor Para Azul Claro");
                    }
                 if(listitem == 3) 
			{
            	SetPlayerColor(playerid, 0x0000FFAA);		 
              SendClientMessage(playerid, 0x0000FFAA, "Você Altero Sua Cor Para Azul Escuro");
                      }
			if(listitem == 4) 
			{
                    	SetPlayerColor(playerid, 0x5500AAAA);		 
              SendClientMessage(playerid, 0x5500AAAA, "Você Altero Sua Cor Para Roxo");
                           }
                       if(listitem == 5) 
			{
                    	SetPlayerColor(playerid, 0x255C1DAA);		 
              SendClientMessage(playerid, 0x255C1DAA, "Você Altero Sua Cor Para Verde");
                           }                           
                           if(listitem == 6) 
			{
                    	SetPlayerColor(playerid, 0xFF8000AA);		 
              SendClientMessage(playerid, 0xFF8000AA, "Você Altero Sua Cor Para Laranja");
                           }
                            if(listitem == 7) 
			{
                    	SetPlayerColor(playerid, 0xFF80C0AA);		 
              SendClientMessage(playerid, 0xFF80C0AA, "Você Altero Sua Cor Para Rosa Claro");
                           }                           
                   if(listitem == 8) 
			{
                    	SetPlayerColor(playerid, 0xFF00FFAA);		 
              SendClientMessage(playerid, 0xFF00FFAA, "Você Altero Sua Cor Para Rosa Pink");
                           }                           
                 if(listitem == 9)  
			{
                    	SetPlayerColor(playerid, 0x804040AA);		 
              SendClientMessage(playerid, 0x804040AA, "Você Altero Sua Cor Para Maron");
                           }
            if(listitem == 10) 
			{
                    	SetPlayerColor(playerid, 0x800000AA);		 
              SendClientMessage(playerid, 0x800000AA, "Você Altero Sua Cor Para Bonina");
                           }
}
		}
//============================================================================================================================================================================================================	
if(dialogid == ARMS) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{

       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Pegou O Kit 1 De Armas ( /armas )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       GivePlayerWeapon(playerid,4,0);
       GivePlayerWeapon(playerid,24,100000);
       GivePlayerWeapon(playerid,26,100000);
       GivePlayerWeapon(playerid,18,15);
		                         }
   			if(listitem == 1) 
			{

       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Pegou O Kit 2 De Armas ( /armas )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       GivePlayerWeapon(playerid,8,0);
       GivePlayerWeapon(playerid,30,100000);
       GivePlayerWeapon(playerid,28,100000);
       GivePlayerWeapon(playerid,18,15);
	   		
	                 }
			if(listitem == 2) 
			{

       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Pegou O Kit 3 De Armas ( /armas )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       GivePlayerWeapon(playerid,1,0);
       GivePlayerWeapon(playerid,31,100000);
       GivePlayerWeapon(playerid,34,100000);
       GivePlayerWeapon(playerid,16,15);
                    }
                 if(listitem == 3) 
			{

       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Pegou O Kit 4 De Armas ( /armas )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       GivePlayerWeapon(playerid,4,0);
       GivePlayerWeapon(playerid,31,100000);
       GivePlayerWeapon(playerid,27,100000);
       GivePlayerWeapon(playerid,34,100000);
                      }
			if(listitem == 4) 
			{
       new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "%s (ID: %d) Pegou O Kit 5 De Armas ( /armas )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       GivePlayerWeapon(playerid,4,0);
       GivePlayerWeapon(playerid,39,100000);
       GivePlayerWeapon(playerid,40,100000);
       GivePlayerWeapon(playerid,34,100000);
                           }
                       if(listitem == 5) 
			{
if(IsPlayerAdmin(playerid)){       
new pname[MAX_PLAYER_NAME];
       GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
       format(string, sizeof(string), "O Admin %s (ID: %d) Pegou O Kit 6 De Armas ( /armas )", pname,playerid);
       SendClientMessageToAll(roxo, string);
       ResetPlayerWeapons(playerid);
       GivePlayerWeapon(playerid,38,99999);
       GivePlayerWeapon(playerid,34,99999);                           
       GivePlayerWeapon(playerid,28,99999);       
       GivePlayerWeapon(playerid,31,99999);          
       GivePlayerWeapon(playerid,26,99999);         
       GivePlayerWeapon(playerid,24,99999);       
       GivePlayerWeapon(playerid,4,99999);
       }
        }
		}
        }
//============================================================================================================================================================================================================ 
if(dialogid == menuarmas) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
ShowPlayerDialog(playerid, pistolas, DIALOG_STYLE_LIST, "Menu De Armas - Pistolas", "9MM Pistol\nPMM Silenciada\nDesert\nVoltar", "OK", "Cancelar");
		                         }
   			if(listitem == 1) 
			{
ShowPlayerDialog(playerid, microsmg, DIALOG_STYLE_LIST, "Menu De Armas - Micro Smgs", "Uzi\nTec-9\nVoltar", "OK", "Cancelar");   		
	                 }
			if(listitem == 2) 
			{
ShowPlayerDialog(playerid, shotguns, DIALOG_STYLE_LIST, "Menu De Armas - Shotguns", "Shotgun\nSaw-Off Shotgun\nCombat Shotgun\nVoltar", "OK", "Cancelar");
                    }                     
			if(listitem == 3) 
			{
ShowPlayerDialog(playerid, SMG, DIALOG_STYLE_LIST, "Menu De Armas - Smg", "MP5\nVoltar", "OK", "Cancelar");
                    } 
 			if(listitem == 4) 
			{
ShowPlayerDialog(playerid, rifle, DIALOG_STYLE_LIST, "Menu De Armas - Rifles", "Rifle\nSniper Rifle\nVoltar", "OK", "Cancelar");
                    } 
			if(listitem == 5) 
			{
ShowPlayerDialog(playerid, assalto, DIALOG_STYLE_LIST, "Menu De Armas - Assalto", "AK-47\nM4\nVoltar", "OK", "Cancelar");
                    } 
			if(listitem == 6) 
			{
ShowPlayerDialog(playerid, outras, DIALOG_STYLE_LIST, "Menu De Armas - Outras", "Explosivo Remoto\nGranadas\nMolotov's\nSpray\nExtintor\nSerra-Eletrica\nFaca\nVoltar", "OK", "Cancelar");
                    }   
                    }                    
                    }
//==================================================================  
    if(dialogid == Menugang) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
         
ShowPlayerDialog(playerid, Gangs, DIALOG_STYLE_LIST, "Menu De Gangs", "Groove\nBallas\nFrangos\nAztecas\nVagos\nNang Boys\nTriads\nBikers\nMafiosos\nLSPD\nSFPD\nLVPD", "OK", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta No Beco Escolhendo Uma Gangue( /beco)", pname,playerid);
SendClientMessageToAll(roxo, string);     
		                         }
   			if(listitem == 1) 
			{
SendClientMessage(playerid, 0x8000FFAA, "Compre Suas Armas E Seja Feliz !!!");
ShowPlayerDialog(playerid, menuarmas, DIALOG_STYLE_LIST, "Menu Da Gang", "Pistolas\nMicro Smg\nShotguns\nSMG\nRifles\nAssalto\nOutras", "OK", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta no Beco Comprando Armas(/beco)", pname,playerid);
SendClientMessageToAll(roxo, string);
                           }
}
}

//==================================================================  

  if(dialogid == telesmenu) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
         
ShowPlayerDialog(playerid, teletuning, DIALOG_STYLE_LIST, "Menu De Teles", "Tuning 1\nTuning 2\nTuning 3", "Teleportar", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta Escolhendo Um Tele( /teles)", pname,playerid);
SendClientMessageToAll(roxo, string);     
		                         }
   			if(listitem == 1) 
			{

ShowPlayerDialog(playerid, teledrift, DIALOG_STYLE_LIST, "Menu De Teles", "Drift 1\nDrift 2\nDrift 3", "Teleportar", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta Escolhendo Um Tele( /teles)", pname,playerid);
SendClientMessageToAll(roxo, string);
                           }
   			if(listitem == 2) 
			{

ShowPlayerDialog(playerid, teleaero, DIALOG_STYLE_LIST, "Menu De Teles", "Aero SF\nAeroLV\nAero Abandonado\nAeroLS", "Teleportar", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta Escolhendo Um Tele( /teles)", pname,playerid);
SendClientMessageToAll(roxo, string);
                           }
   			if(listitem == 3) 
			{

ShowPlayerDialog(playerid, teleoutros, DIALOG_STYLE_LIST, "Menu De Teles", "Army\nArmy Boat\n4Dragon\nChiliad\nPark Skate\nPraia De Verona\nPick Nick", "Teleportar", "Cancelar");
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Esta Escolhendo Um Tele( /teles)", pname,playerid);
SendClientMessageToAll(roxo, string);
                           }

}
}

//==================================================================  

if(dialogid == pistolas) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
GivePlayerWeapon(playerid,22,99999); //9MM
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma 9MM Pistol");
		                         }
   			if(listitem == 1) 
			{
GivePlayerWeapon(playerid,23,99999); //PMM Silenciada
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma 9MM Silenciada");	   		
	                 }
			if(listitem == 2) 
			{
	 GivePlayerWeapon(playerid,24,99999); //Desert
 SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma Desert");
                    }                     
			if(listitem == 3) 
			{
ShowPlayerDialog(playerid, menuarmas, DIALOG_STYLE_LIST, "Menu De Armas", "Pistolas\nMicro Smg\nShotguns\nSMG\nRifles\nAssalto\nOutras", "OK", "Cancelar");
                    } 
                    }                    
                    }
//==================================================================      
 if(dialogid == microsmg) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
GivePlayerWeapon(playerid,28,99999); //Uzi
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma Uzi");		                         }
   			if(listitem == 1) 
			{
GivePlayerWeapon(playerid,32,99999); //TEc-9
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma Tec-9");
                    }                     
 			if(listitem == 2) 
			{
ShowPlayerDialog(playerid, menuarmas, DIALOG_STYLE_LIST, "Menu De Armas", "Pistolas\nMicro Smg\nShotguns\nSMG\nRifles\nAssalto\nOutras", "OK", "Cancelar");
                    } 
                    }                    
                    }     
//==================================================================
if(dialogid == shotguns) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
GivePlayerWeapon(playerid,25,99999); //Shotgun
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma Shotgun");
		                         }
   			if(listitem == 1) 
			{
GivePlayerWeapon(playerid,26,99999); //Saw-off 
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma Saw-Off");	   		
	                 }
			if(listitem == 2) 
			{
	 GivePlayerWeapon(playerid,27,99999); //Combat
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma Combat Shotgun");
                    }                     
			if(listitem ==3 ) 
			{
ShowPlayerDialog(playerid, menuarmas, DIALOG_STYLE_LIST, "Menu De Armas", "Pistolas\nMicro Smg\nShotguns\nSMG\nRifles\nAssalto\nOutras", "OK", "Cancelar");
                    } 
                    }                    
                    }
//==================================================================
 if(dialogid == SMG) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
GivePlayerWeapon(playerid,29,99999); //MP5
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma MP5 ");
                    }                     
 			if(listitem == 1) 
			{
ShowPlayerDialog(playerid, menuarmas, DIALOG_STYLE_LIST, "Menu De Armas", "Pistolas\nMicro Smg\nShotguns\nSMG\nRifles\nAssalto\nOutras", "OK", "Cancelar");
                    } 
                    }                    
                    }  
//==================================================================
 if(dialogid == rifle) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
GivePlayerWeapon(playerid,33,99999); //Rifle
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Um Rifle");
		                         }
   			if(listitem == 1) 
			{
GivePlayerWeapon(playerid,34,99999); //Sniper Rifle
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma Sniper Rifle");
                    }                     
			if(listitem == 2) 
			{
ShowPlayerDialog(playerid, menuarmas, DIALOG_STYLE_LIST, "Menu De Armas", "Pistolas\nMicro Smg\nShotguns\nSMG\nRifles\nAssalto\nOutras", "OK", "Cancelar");
                    } 
                    }                    
                    }  
//==================================================================
 if(dialogid == assalto) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
GivePlayerWeapon(playerid,30,99999); //AK-47
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma AK-47");
		                         }
   			if(listitem == 1) 
			{
GivePlayerWeapon(playerid,31,99999); //M4
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma M4");
                    }                     
			if(listitem == 2) 
			{
ShowPlayerDialog(playerid, menuarmas, DIALOG_STYLE_LIST, "Menu De Armas", "Pistolas\nMicro Smg\nShotguns\nSMG\nRifles\nAssalto\nOutras", "OK", "Cancelar");
                    } 
                    }                    
                    }  
//==================================================================
if(dialogid == outras) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{
GivePlayerWeapon(playerid,39,35); //Detonador
GivePlayerWeapon(playerid,40,35); // Explosivo remoto		                    
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Um Explosivo Remoto");
   		        }
           	if(listitem == 1) 
			{
GivePlayerWeapon(playerid,16,40); //Granadas
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma Granada");	   		
	                 }
			if(listitem == 2) 
			{
	 GivePlayerWeapon(playerid,18,99999); // Molotov's
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Um Molotov's");
                    }                     
			if(listitem == 3) 
			{
	 GivePlayerWeapon(playerid,41,99999); // Spray
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Um Spray");
                    }  
			if(listitem == 4) 
			{
	 GivePlayerWeapon(playerid,42,99999); // Extintor
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Um Extintor");
                    }  
			if(listitem == 5) 
			{
	 GivePlayerWeapon(playerid,9,99999); // Serra-Eletrica
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma Serra Eletrica");
                    }  
			if(listitem == 6) 
			{
	 GivePlayerWeapon(playerid,4,99999); // faca
SendClientMessage(playerid, 0x008000AA, "Voce Comprou Uma Faca ");
                    }  
 			if(listitem == 7) 
			{
ShowPlayerDialog(playerid, menuarmas, DIALOG_STYLE_LIST, "Menu De Armas", "Pistolas\nMicro Smg\nShotguns\nSMG\nRifles\nAssalto\nOutras", "OK", "Cancelar");
                    } 
                    }                    
                    }

//==================================================================        
if(dialogid == tunar) // Menu
	{
		if(response)
		{
   			if(listitem == 0) // Rodas
			{
				ShowPlayerDialog(playerid, tunarroda, DIALOG_STYLE_LIST, "Rodas", "Roda 1 \nRoda 2 \nRoda 3 \nRoda 4 \nRoda 5 \nRoda 6 \nVoltar", "Intalar", "Cancelar");
			}
			if(listitem == 1) // Cores
			{
				ShowPlayerDialog(playerid, tunarcor, DIALOG_STYLE_LIST, "Cores", "Preto \nBranco \nAzul Escuro \nAzul Claro \nVerde \nVermelho \nAmarelo \nRosa \nVoltar", "Pintar", "Cancelar");
			}
			if(listitem == 2) // Paintjobs
			{
				ShowPlayerDialog(playerid, tunarpaint, DIALOG_STYLE_LIST, "Paintjobs", "Estilo 1 \nEstilo 2 \nEstilo 3 \nVoltar", "Pintar", "Cancelar");
   			}
			if(listitem == 3) // Nitro
			{
            AddVehicleComponent(car,1010);
   			}
			if(listitem == 4) // Suspensão
			{
            AddVehicleComponent(car,1087);
   			}
			if(listitem == 5) // AutoTuning
			{
	new idcarro;
	idcarro = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562)
	{
	AddVehicleComponent(idcarro,1046);
	AddVehicleComponent(idcarro,1171);
	AddVehicleComponent(idcarro,1149);
	AddVehicleComponent(idcarro,1035);
	AddVehicleComponent(idcarro,1147);
	AddVehicleComponent(idcarro,1036);
	AddVehicleComponent(idcarro,1040);
	ChangeVehiclePaintjob(idcarro, 2);
	ChangeVehicleColor(idcarro, 6, 6);
	AddVehicleComponent(idcarro,nitro);
 	AddVehicleComponent(idcarro,rodawire);
 	AddVehicleComponent(idcarro,suspensao);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
	{
	AddVehicleComponent(idcarro,1028);
	AddVehicleComponent(idcarro,1169);
	AddVehicleComponent(idcarro,1141);
	AddVehicleComponent(idcarro,1032);
	AddVehicleComponent(idcarro,1138);
	AddVehicleComponent(idcarro,1026);
 	AddVehicleComponent(idcarro,1027);
	ChangeVehiclePaintjob(idcarro, 2);
	AddVehicleComponent(idcarro,nitro);
 	AddVehicleComponent(idcarro,rodawire);
 	AddVehicleComponent(idcarro,suspensao);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 565)
	{
	AddVehicleComponent(idcarro,1046);
	AddVehicleComponent(idcarro,1153);
	AddVehicleComponent(idcarro,1150);
	AddVehicleComponent(idcarro,1054);
	AddVehicleComponent(idcarro,1049);
	AddVehicleComponent(idcarro,1047);
 	AddVehicleComponent(idcarro,1051);
 	AddVehicleComponent(idcarro,nitro);
 	AddVehicleComponent(idcarro,rodawire);
 	AddVehicleComponent(idcarro,suspensao);
	ChangeVehiclePaintjob(idcarro, 2);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 559)
	{
	AddVehicleComponent(idcarro,1065);
	AddVehicleComponent(idcarro,1160);
	AddVehicleComponent(idcarro,1159);
	AddVehicleComponent(idcarro,1067);
	AddVehicleComponent(idcarro,1162);
	AddVehicleComponent(idcarro,1069);
 	AddVehicleComponent(idcarro,1071);
 	AddVehicleComponent(idcarro,nitro);
 	AddVehicleComponent(idcarro,rodawire);
 	AddVehicleComponent(idcarro,suspensao);
	ChangeVehiclePaintjob(idcarro, 1);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 561)
	{
	AddVehicleComponent(idcarro,1064);
	AddVehicleComponent(idcarro,1155);
	AddVehicleComponent(idcarro,1154);
	AddVehicleComponent(idcarro,1055);
	AddVehicleComponent(idcarro,1158);
	AddVehicleComponent(idcarro,1056);
 	AddVehicleComponent(idcarro,1062);
 	AddVehicleComponent(idcarro,nitro);
 	AddVehicleComponent(idcarro,rodawire);
 	AddVehicleComponent(idcarro,suspensao);
	ChangeVehiclePaintjob(idcarro, 2);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
	{
	AddVehicleComponent(idcarro,1089);
	AddVehicleComponent(idcarro,1166);
	AddVehicleComponent(idcarro,1168);
	AddVehicleComponent(idcarro,1088);
	AddVehicleComponent(idcarro,1164);
	AddVehicleComponent(idcarro,1090);
 	AddVehicleComponent(idcarro,1094);
 	AddVehicleComponent(idcarro,nitro);
 	AddVehicleComponent(idcarro,rodawire);
 	AddVehicleComponent(idcarro,suspensao);
	ChangeVehiclePaintjob(idcarro, 2);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 575)
	{
	AddVehicleComponent(idcarro,1044);
	AddVehicleComponent(idcarro,1174);
	AddVehicleComponent(idcarro,1176);
	AddVehicleComponent(idcarro,1042);
 	AddVehicleComponent(idcarro,1099);
 	AddVehicleComponent(idcarro,nitro);
 	AddVehicleComponent(idcarro,rodawire);
 	AddVehicleComponent(idcarro,suspensao);
	ChangeVehiclePaintjob(idcarro, 0);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 534)
	{
	AddVehicleComponent(idcarro,1126);
    AddVehicleComponent(idcarro,1179);
	AddVehicleComponent(idcarro,1180);
	AddVehicleComponent(idcarro,1122);
 	AddVehicleComponent(idcarro,1101);
 	AddVehicleComponent(idcarro,1125);
 	AddVehicleComponent(idcarro,1123);
 	AddVehicleComponent(idcarro,1100);
 	AddVehicleComponent(idcarro,nitro);
 	AddVehicleComponent(idcarro,rodawire);
 	AddVehicleComponent(idcarro,suspensao);
	ChangeVehiclePaintjob(idcarro, 2);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 536)
	{
	AddVehicleComponent(idcarro,1104);
	AddVehicleComponent(idcarro,1182);
	AddVehicleComponent(idcarro,1184);
	AddVehicleComponent(idcarro,1108);
 	AddVehicleComponent(idcarro,1107);
 	AddVehicleComponent(idcarro,nitro);
 	AddVehicleComponent(idcarro,rodawire);
 	AddVehicleComponent(idcarro,suspensao);
	ChangeVehiclePaintjob(idcarro, 1);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 567)
	{
	AddVehicleComponent(idcarro,1129);
	AddVehicleComponent(idcarro,1189);
	AddVehicleComponent(idcarro,1187);
	AddVehicleComponent(idcarro,1102);
 	AddVehicleComponent(idcarro,1133);
 	AddVehicleComponent(idcarro,nitro);
 	AddVehicleComponent(idcarro,rodawire);
 	AddVehicleComponent(idcarro,suspensao);
	ChangeVehiclePaintjob(idcarro, 2);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 420)
	{
	AddVehicleComponent(idcarro,1010);
 	AddVehicleComponent(idcarro,1087);
 	AddVehicleComponent(idcarro,1081);
 	AddVehicleComponent(idcarro,1139);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 400)
	{
	AddVehicleComponent(idcarro,1010);
 	AddVehicleComponent(idcarro,1087);
 	AddVehicleComponent(idcarro,1018);
 	AddVehicleComponent(idcarro,1013);
 	AddVehicleComponent(idcarro,1081);
 	AddVehicleComponent(idcarro,1086);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 401)
	{
	AddVehicleComponent(idcarro,1086);
 	AddVehicleComponent(idcarro,1139);
 	AddVehicleComponent(idcarro,1081);
 	AddVehicleComponent(idcarro,1010);
 	AddVehicleComponent(idcarro,1087);
 	AddVehicleComponent(idcarro,1012);
 	AddVehicleComponent(idcarro,1013);
 	AddVehicleComponent(idcarro,1042);
 	AddVehicleComponent(idcarro,1043);
 	AddVehicleComponent(idcarro,1018);
 	AddVehicleComponent(idcarro,1006);
 	AddVehicleComponent(idcarro,1007);
 	AddVehicleComponent(idcarro,1017);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 576)
	{
	ChangeVehiclePaintjob(idcarro,2);
 	AddVehicleComponent(idcarro,1191);
 	AddVehicleComponent(idcarro,1193);
 	AddVehicleComponent(idcarro,1010);
 	AddVehicleComponent(idcarro,1018);
 	AddVehicleComponent(idcarro,1081);
 	AddVehicleComponent(idcarro,1087);
 	AddVehicleComponent(idcarro,1134);
 	AddVehicleComponent(idcarro,1137);
	}
	else
	{
	AddVehicleComponent(idcarro,nitro);
 	AddVehicleComponent(idcarro,rodawire);
 	AddVehicleComponent(idcarro,suspensao);
        }
   			}
		}
		return 1;
	}
//============================================================================================================================================================================================================
	if(dialogid == tunarroda) // Rodas
	{
		if(response)
		{
			if(listitem == 0) // Estilo 1
			{
			AddVehicleComponent(car,1084);
			}
			if(listitem == 1) // Estilo 2
			{
			AddVehicleComponent(car,1073);
			}
			if(listitem == 2) // Estilo 3
			{
			AddVehicleComponent(car,1075);
			}
			if(listitem == 3) // Estilo 4
			{
			AddVehicleComponent(car,1077);
			}
			if(listitem == 4) // Estilo 5
			{
			AddVehicleComponent(car,1079);
			}
			if(listitem == 5) // Estilo 6
			{
			AddVehicleComponent(car,1080);
			}
			if(listitem == 6) // Voltar
  			{
			ShowPlayerDialog(playerid, tunar, DIALOG_STYLE_LIST, "Tuning Menu", "Rodas\nCores\nPaintjobs\nNitro\nSuspensão\nAutoTuning", "Instalar", "Cancelar");
			}
		}
		return 1;
	}
//============================================================================================================================================================================================================
	if(dialogid == tunarcor) // Cores
	{
		if(response)
		{
			if(listitem == 0) // Preto
			{
			ChangeVehicleColor(car,0,0);
			}
			if(listitem == 1) // Branco
			{
			ChangeVehicleColor(car,1,1);
			}
			if(listitem == 2) // Azul Escuro
			{
			ChangeVehicleColor(car,425,425);
			}
			if(listitem == 3) // Azul Claro
			{
			ChangeVehicleColor(car,2,2);
			}
			if(listitem == 4) // Verde
			{
			ChangeVehicleColor(car,16,16);
			}
			if(listitem == 5) // Vermelho
			{
			ChangeVehicleColor(car,3,3);
			}
			if(listitem == 6) // Amarelo
			{
			ChangeVehicleColor(car,6,6);
			}
			if(listitem == 7) // Rosa
			{
			ChangeVehicleColor(car,146,146);
			}
			if(listitem == 8) // Voltar
			{
			ShowPlayerDialog(playerid, tunar, DIALOG_STYLE_LIST, "Tuning Menu", "Rodas\nCores\nPaintjobs\nNitro\nSuspensão\nAutoTuning", "Pintar", "Cancelar");
			}
		}
		return 1;
	}
//============================================================================================================================================================================================================

	if(dialogid == tunarpaint) // Paintjobs
	{
		if(response)
		{
			if(listitem == 0) // Estilo 1
			{
			ChangeVehiclePaintjob(car,0);
			}
			if(listitem == 1) // Estilo 2
			{
			ChangeVehiclePaintjob(car,1);
			}
			if(listitem == 2) // Estilo 3
			{
			ChangeVehiclePaintjob(car,2);
			}
			if(listitem == 4) // Voltar
			{
			ShowPlayerDialog(playerid, tunar, DIALOG_STYLE_LIST, "Tuning Menu", "Rodas\nCores\nPaintjobs\nNitro\nSuspensão\nAutoTuning", "Pintar", "Cancelar");
			}
		}
    	return 1;    
     }     
    
    
if(dialogid == teletuning) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Tunning 1( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,-1917.2754,287.0215,41.0469);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,175.4554);
		                }
   			if(listitem == 1) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Tunning 2( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,-2705.5503,206.1621,4.1797);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,175.4554);   		
	                 }
			if(listitem == 2) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Tunning 3( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,2387.4126,1022.6620,10.8203);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,175.4554);
                    }
                    }
		    }


if(dialogid == teledrift) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{


new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Drift 1( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,-274.9351,1535.3416,75.3594);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,175.4554);
		                }
   			if(listitem == 1) 
			{


new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Drift 2( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,2273.3972,1395.4358,42.8203);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,175.4554);   		
	                 }
			if(listitem == 2) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Drift 3( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,-2399.6096,-613.3132,132.6484);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,176.2701);
                    }
                    }
		    }

if(dialogid == teleaero) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{


new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Aero De San Fierro( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,-1347.1360,-234.9015,14.1484);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,176.2701);
		                }
   			if(listitem == 1) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Aero De Las Venturas( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,1317.7917,1260.0190,10.8203);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,176.2701);   		
	                 }
			if(listitem == 2) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Aero Abandonado( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,420.2640,2521.1553,16.4844);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,176.2701);
                    }
			if(listitem == 3) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Aero De Los Santos( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,1732.7311,-2522.4780,13.5469);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,84.4835);
                    }
                    }
		    }


if(dialogid == teleoutros) 
	{
		if(response)
		{
   			if(listitem == 0) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Army Dos Teles Outros( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,299.5175,1984.7994,17.6406);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,178.4425);
		                }
   			if(listitem == 1) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Army Boat Dos Teles Outros( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,-1385.3300,493.5960,27.6945);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,178.4425);   		
	                 }
			if(listitem == 2) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O 4Dragons Dos Teles Outros( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,420.2640,2521.1553,16.4844);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,176.2701);
                    }
			if(listitem == 3) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Chiliad Dos Teles Outros( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,2028.5538,1008.3543,10.8203);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,178.4425);
                    }

			if(listitem == 4) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Park Skate Dos Teles Outros( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,1880.9452,-1394.7611,13.5703);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,178.4425);
                    }
			if(listitem == 5) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para A Praia De Verona Dos Teles Outros( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,339.4781,-1837.2505,3.7086);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,195.2791);
                    }
			if(listitem == 6) 
			{

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "%s (ID: %d) Foi Para O Pick Nick Dos Teles Outros( /teles )", pname,playerid);
SendClientMessageToAll(roxo, string);    
SetPlayerPos(playerid,-457.3965,-2480.4163,116.2867);
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,76.0651);
                    }
                    }
		    }    
      return 1;     
     }         

//============================================================================================================================================================================================================
encrypt(pass[])
{
	static charset[] = "";
	static css = 63;
	new target[MAX_SENHA + 1];
	new	j = strlen(pass);
	new sum = j;
	new	tmpp = 0;
	new	i;
	new	modw;
	for (i = 0; i < MAX_SENHA || i < j; i++)
	{
		modw = i % MAX_SENHA;
		tmpp = (i >= j) ? charset[(7 * i) % css] : pass[i];
		sum = (sum + chrfind(tmpp, charset) + 1)		% css;
		target[modw] = charset[(sum + target[modw])	% css];
	}
	target[MAX_SENHA] = '\0';
	return target;
}
stock chrfind(needle, haystack[], start = 0)
{
	while(haystack[start])
	{
	    if(haystack[start++] == needle)
	    {
	        return start-1;
		}
	}
	return -1;
}

public Velocimetro()
{
	for(new i=0; i<GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
		{
			TextDrawShowForPlayer(i, Text:ArkaPlan1);
			TextDrawShowForPlayer(i, Text:ArkaPlan2);
			TextDrawShowForPlayer(i, Text:ArkaPlan3);
			TextDrawShowForPlayer(i, Text:ArkaPlan4);
			TextDrawShowForPlayer(i, Text:ArkaPlan5);
			new HGG[265]; new Float:Can;
			GetVehicleHealth(GetPlayerVehicleID(i), Can);
   			GetPlayerPos(i,Xa,Ya,Za);
   			KMH = floatsqroot(floatpower(floatabs(floatsub(Xa,Xb[i])),2)+floatpower(floatabs(floatsub(Ya,Yb[i])),2)+floatpower(floatabs(floatsub(Za,Zb[i])),2));
			KMH *= 14.2;
			format(HGG, sizeof(HGG), " ~n~%s~n~ ~n~ ~n~%0.0fKM/h~n~ ~n~ ~n~%.2f~n~", ArIsim[GetVehicleModel(GetPlayerVehicleID(i))-400], KMH, Can);
			TextDrawSetString(Text:GostergeYazi[i], HGG);
            TextDrawShowForPlayer(i, GostergeYazi[i]);
  			TextDrawShowForPlayer(i, Cizgi);
		}
		else
		{
			TextDrawHideForPlayer(i, Text:GostergeYazi[i]);
			TextDrawHideForPlayer(i, Text:ArkaPlan1);
			TextDrawHideForPlayer(i, Text:ArkaPlan2);
			TextDrawHideForPlayer(i, Text:ArkaPlan3);
			TextDrawHideForPlayer(i, Text:ArkaPlan4);
			TextDrawHideForPlayer(i, Text:ArkaPlan5);
			TextDrawHideForPlayer(i, Text:Cizgi);
		}	GetPlayerPos(i,Xb[i],Yb[i],Zb[i]), Xb[i] = Xa; Yb[i] = Ya; Zb[i] = Za;
	}
}
public MudarHora(){
        new hour,minute,second;
        new string[256];
        gettime(hour,minute,second);
        if (minute <= 9){format(string,25,"~w~~h~%d:0%d",hour,minute);}
        else {format(string,25,"~w~~h~%d:%d",hour,minute);}
        TextDrawSetString(Relogio,string);
        SetWorldTime(hour);
        return 1;
}
public GPS()
{
        new str[256];
   		for(new i=0; i<gMax; i++)
        {
            if(IsPlayerConnected(i))
                {
                    if(GPS_Spawned[i] == 1)
                    {
                    			format(str,sizeof(str),"~n~~n~~w~ GPS~p~: ~w~%s", GetPlayerArea(i));
                                TextDrawSetString(gps[i], str);
                                TextDrawShowForPlayer(i, gps[i]);
                        }
                        else
                        {
                            TextDrawHideForPlayer(i, gps[i]);
                        }
                }
        }
        return 1;
}

stock GetPlayerArea(playerid)
{
        new str[130];
        format(str,sizeof(str),"%s",Zones[GetPlayerZone(playerid)][zone_name]);
        return str;
}

stock GetPlayerZone(playerid)
{
        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerid,x,y,z);
        for(new i=0;i<sizeof(Zones);i++)
        {
                if(x > Zones[i][zone_minx] && y > Zones[i][zone_miny] && z > Zones[i][zone_minz] && x < Zones[i][zone_maxx] && y < Zones[i][zone_maxy] && z < Zones[i][zone_maxz])
                return i;
        }
        return false;
}

public tempocmdgodc2(playerid)
{
tempocmdgodc[playerid] = 0;
SendClientMessage(playerid, 0xFF0000AA,"Comando /Godc Liberado!");
return 1;
}

public tempocmdvida2(playerid)
{
tempocmdvida[playerid] = 0;
SendClientMessage(playerid, 0xFF0000AA,"Comando /vida Liberado!");
return 1;
}

public tempocmdcolete2(playerid)
{
tempocmdcolete[playerid] = 0;
SendClientMessage(playerid, 0xFF0000AA,"Comando /colete Liberado!");
return 1;
}

public tempocmdajato2(playerid)
{
tempocmdajato[playerid] = 0;
SendClientMessage(playerid, 0xFF0000AA,"Comando /ajato  Liberado!");
return 1;
}
                                               

public UpperToLower(text[])
{
	for(new Char ; Char < strlen(text) ; Char++)
	{
		if(text[Char] > 64 && text[Char] < 91)
  		{
			text[Char] += 32;
		}
	}
	return 1;
}   
