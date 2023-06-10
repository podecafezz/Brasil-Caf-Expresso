//Includes
#include <a_samp>
#include <c_vehicleinfo>
#include <a_players>
#include <a_vehicles>
#include <dini>
#include <cpstream>
#include <utils>

//Outros
#pragma tabsize 0
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define SendFormattedMessage(%0,%1,%2) do{new _str[128]; format(_str,128,%2); SendClientMessage(%0,%1,_str);}while(FALSE)
                                                                   
//Menus de profs
#define Comuns                                                                  974
#define Policiais                                                               975
#define Criminosas                                                              976
#define Vendas                                                                  977

#define MAX_SWEARS 100
#define STR 100
#define MAX_PROPS 250

//Cores
#define COLOR_AZUL              0x0000A0AA
#define Amarelo		 															0xFFFF00FF
#define Vermelho                                                                0xD20000FF
#define Vermelho2	 															0xAA3333FF
#define Branco	 																0xFFFFFFFF
#define Verde	 																0x33AA33FF
#define Preto	 																0x00000000
#define Azul	 																0x33CCFFFF
#define Azul2	 																0x33CCFFAA
#define Violeta	 																0x9955DEFF
#define Cinza	 																0xAFAFAFFF
#define COLOR_GREEN                                                             0x33AA33FF
#define COLOR_RED                                                               0xAA3333FF
#define COLOR_WHITE                                                             0xFFFFFFFF
#define COLOR_LIME		 	                                                  	0x80FF00AA
#define COR_ADMIN 0x80FF00FF
#define GREEN 0x21DD00FF
#define RED 0xE70000AA
#define ADMIN_RED 0xFB0000FF
#define YELLOW 0xFFFF00FF
#define ORANGE 0xF97804FF
#define LIGHTRED 0xFF8080FF
#define LIGHTBLUE 0x00C2ECFF
#define PURPLE 0xB360FDFF
#define PLAYER_COLOR 0xFFFFFFFF
#define BLUE 0x1229FAFF
#define LIGHTGREEN 0x38FF06FF
#define DARKPINK 0xE100E1FF
#define DARKGREEN 0x008040FF
#define ANNOUNCEMENT 0x00CACAFB
#define COLOR_SYSTEM 0xEFEFF7AA
#define NICESKY 0x99FFFFAA
#define GRAY 0xCECECEFF
#define WHITE 0xFFFFFFAA
#define CYAN 0x00FFFFAA
#define ADMIN_SPEC_TYPE_NONE 0
#define ADMIN_SPEC_TYPE_PLAYER 1
#define ADMIN_SPEC_TYPE_VEHICLE 2
#define VOTETIME 30000 // change the time to change the amount of time left.
#define STRING 255
#define WAIT_TIME 120000
#define SalarioMinimo                                                           412
#define Desempregado                                                            0
#define COR_DESEMPREGADO                                                        0xAEAEAEFF
#define Estagiario                                                              1
#define COR_ESTAGIARIO                                                          0x48FDC8FF
#define Guarda                                                                  2
#define COR_GUARDA                                                              0x74C3FFFF
#define Policial_R                                                              3
#define COR_RODOVIARIO                                                          0x062DBEFF
#define Policial_M                                                              4
#define COR_MILITAR                                                             0x6384FFFF
#define Policial_C                                                              5
#define COR_CIVIL                                                               0x0056AEFF
#define Policial_F                                                              6
#define COR_FEDERAL                                                             0x008DCFFF
#define Delegado                                                                7
#define COR_DELEGADO                                                            0x41C9D2FF
#define Bope                                                                    8
#define COR_BOPE                                                                0x00AEFFFF
#define Swat                                                                    9
#define COR_SWAT                                                                0x00EBE8FF
#define Narcoticos                                                              10
#define COR_NARCOTICOS                                                          0x5EC4DDFF
#define Traficante                                                              11
#define COR_TRAFICANTE                                                          0xCE0000FF
#define Assasino                                                                12
#define COR_ASSASINO                                                            0xFF7777FF
#define Terrorista                                                              13
#define COR_TERRORISTA                                                          0x943232FF
#define Sequestrador                                                            14
#define COR_SEQUESTRADOR                                                        0x9B5858FF
#define AssasinoProfissional                                                    15
#define COR_ASSPROF                                                             0xE83333FF
#define Jornalista                                                              16
#define COR_JORNALISTA                                                          0xA1F976FF
#define Fotografo                                                               17
#define COR_FOTOGRAFO                                                           0x3BB400FF
#define Reporter                                                                18
#define COR_REPORTER                                                            0x9BD181FF
#define Ancora                                                                  19
#define COR_ANCORA                                                              0x5DD521FF
#define Meteorologista                                                          20
#define COR_METEOROLOGISTA                                                      0x3C6B25FF
#define Mecanico                                                                21
#define COR_MECANICO                                                            0xd9E1ECFF
#define VendedorCasa                                                            22
#define COR_VENDEDORCASA                                                        0xD58FF5FF
#define VendedorSkin                                                            23
#define COR_VENDEDORSKIN                                                        0x88589FFF
#define VendedorCarro                                                           24
#define COR_VENDEDORCARRO                                                       0x7300A9FF
#define VendedorComb                                                            25
#define COR_VENDEDORCOM                                                         0xAA2DE4FF
#define Taxista                                                                 26
#define COR_TAXISTA                                                             0xFFFF00FF
#define Medico                                                                  27
#define COR_MEDICO                                                              0x9955DEFF
#define FBI                                                                     28
#define COR_FBI                                                                 0x14016100
#define ComandoVermelho                                                         29
#define COR_COMANDO                                                             0x61010100
#define COR_MOD                                                                 0xB30000AA
#define MPS             1
#define KMPH            0
#define MPH 			2
#define KNOTS 			3
#define PTP_RADIUS              2.0     // Radius of PlayerToPoint Function
#define MAX_CARROS 500
#define MAX_CASAS 100

//#include "../include/gl_common.inc"
#define AZULBLUE                0x8958A7AA
//#define SPEED			KMPH

//news
new fe;
new ho;
new ho2;
new hott;
new MinutisOn[MAX_PLAYERS];
new hott2;
new entrarpref;
new sairpref;
new gmod[MAX_PLAYERS];
new amod[MAX_PLAYERS];
new celigado[MAX_PLAYERS];
new comfome[MAX_PLAYERS];
new hotel;
new Depositar;
new nickn[MAX_PLAYERS];
new Sacar;
new Sacar1;
new emcasa[MAX_PLAYERS];
new Float:CasaX[MAX_PLAYERS];
new Float:CasaY[MAX_PLAYERS];
new Float:CasaZ[MAX_PLAYERS];
new cm;
//new Text:fominha[MAX_PLAYERS];
new Depositar1;
new Comprovante;
new nocarro[MAX_PLAYERS];
new Menu:Tunar;
new pAdmin[MAX_PLAYERS];
new secondies[MAX_PLAYERS];
new Menu:Paintjobs;
new incar[MAX_PLAYERS];
new Menu:Cores;
new Menu:Rodas;
new Menu:controle_ilha;
new proximaprop;
new proximacasa;
new gSpectateID[MAX_PLAYERS];
new gSpectateType[MAX_PLAYERS];
new Logado[MAX_PLAYERS];
new emteste[MAX_PLAYERS];
new proximocarro;
new evento;
new Float:eventoX;
new Float:eventoY;
new Float:eventoZ;
new noevento[MAX_PLAYERS];
new Reboque;
new academia;
new portaodp;
new naarena[MAX_PLAYERS];
new namoto[MAX_PLAYERS];
new pickupacademia;
new pickupacademia1;
new pickuplans;
new pickuplane;
new Pickuploja;
new Pickuploja1;
new EntradaPizzaria;
new SaidaPizzaria;
new Pizzaria;
new EntradaAmmu;
new SaidaAmmu;
new Ammu;
new EntradaBurguer;
new SaidaBurguer;
new Burguer;
new EntradaBurguer2;
new SaidaBurguer2;
new guerra;
new PCash[MAX_PLAYERS];
new TowTruckers=0;
new IsTowTrucker[MAX_PLAYERS];
new podehab[MAX_PLAYERS];
new pickupbanco;
new pickupbanco1;
new Banco;
new PrecoCorrida[MAX_PLAYERS];
new Telefone;
new Loja;
new podeenviar[MAX_PLAYERS];
new Text:morti;
new Text:Relogio;     
new Float:sangui[MAX_PLAYERS];
new Text:Exp;
new SendoVotado[MAX_PLAYERS];
new Detido[MAX_PLAYERS];
new Faculdade;
new blockbomba;
new HabLocal;
new Trancado[MAX_VEHICLES];
new TrancadoPara[MAX_VEHICLES];
new portaom;
new Swears[MAX_SWEARS][STR];
new num_words = 0;

new cs1[MAX_PLAYERS];
new cs2[MAX_PLAYERS];
new cs3[MAX_PLAYERS];
new cs4[MAX_PLAYERS];

new Text:Philipsmsginicio;
new Text:text1;
new Text:text2;
new Text:text3;
new Text:text4;
new Text:text5;
new Text:text6;
//cs

new Shopping;
new portaocv;
new convitefbi[MAX_PLAYERS];
new convitecv[MAX_PLAYERS];
new vcblock[MAX_PLAYERS];
new crblock[MAX_PLAYERS];
new kitblock[MAX_PLAYERS];
new profis;
new praga[MAX_PLAYERS];
new Text:dano;
new Text:mote;
new Text:motendo;
new Text:motendo2;
new TAXISTAS;
new flood[MAX_PLAYERS];
new mincalado[MAX_PLAYERS];
new calado[MAX_PLAYERS];
new VoteKick;
new Votes;
new Voted[MAX_PLAYERS];
new PlayerCount;

new plon;
new Wait[MAX_PLAYERS];
new tutorial[MAX_PLAYERS];
new carga;
new portaofbi;
new diadasemana;
new diasemana[7][] = {
"Domingo","Segunda","Terca","Quarta","Quinta","Sexta","Sabado"
};

new discarga;
new comjornal[MAX_PLAYERS] = 0;
new cargadele[MAX_VEHICLES] = 0;
new Pescaria;
new VendaPesca;
new portaoj;
new localjornal;
new hora, minutoss;
new areadm;
new minutos[MAX_PLAYERS] = 0;
new minutosafk[MAX_PLAYERS] = 0;
new NaFaculdade[MAX_PLAYERS] = 0;
new Conversa[MAX_PLAYERS] = 0;
new abastecendo[MAX_PLAYERS];
new dms[MAX_PLAYERS];
new Menu:ElevadorControle;
new Menu:PortaoControle;
new elevador1;
new portao1;
new portao2;
new pc1;
new pc2;
new pc3;
new pc4;
new pickuplan1;
new pickuplan2;
new pickuplan3;
new pickuplan4;
new Pickupagencia;
new Pickupescola;
new Pickupagencia1;
new Pickupescola1;

new AreaPosto[MAX_PLAYERS];
new Pescando[MAX_PLAYERS];
new portaomansao;
new Float:AFKX[MAX_PLAYERS], Float:AFKY[MAX_PLAYERS], Float:AFKZ[MAX_PLAYERS];
new Peixes[MAX_PLAYERS];
new afkm[MAX_PLAYERS];
new Text:Textdraw0[MAX_PLAYERS];
new areadmp[MAX_PLAYERS];
new tempoon[MAX_PLAYERS];
new dia;
new armas;
new podedm;
new counta;
new Taximetro[MAX_PLAYERS][2];
new Prof[30][256] = {
"Desempregado",
"Estágiario",
"Guarda",
"Policial Rodoviário",
"Policial Militar",
"Policial Civil",
"Policial Federal",
"Delegado",
"BOPE",
"SWAT",
"Narcoticos",
"Traficante de Armas",
"Assasino",
"Terrorista",
"Sequestrador",
"Assasino Profissional",
"Jornalista",
"Fotografo",
"Reporter",
"Ancora",
"Meteorologista",
"Mecanico",
"Vendedor de Casa",
"Vendedor de Skin",
"Vendedor de Carro",
"Vendedor de Gasolina",
"Taxista",
"Medico",
"Agente FBI",
"Membro CV"
};
new MSGs[12][256] = { 
"Veja os creditos em /creditos",
"Leia as regras para não ser banido: /regras",
"Dúvidas reporte a um admin ! /reportar [texto]",
"Dúvidas ? Fale com um admin Online ! /admins",
"Não sabe jogar ? Digite /ajuda",
"Estude para conseguir o melhor, vá para a faculdade.",
"Entre em nossa comunidade: pesquise no orkut por: Philips RPG ServeR. cmm=99420698",
"Philips RPG agradece a sua visita !",
"Veja quem ajuda o server ! /vips",
"Para ver seus status digite /meustatus",
"Agora os mecanicos podem guinchar carros usando 2(tecla de sub-missão).",
"Para ver as ultimas novidades digite /novidades"
};
new PeixesR[5][256] = { 
"pirarucu",
"sardinha",
"cavalinha",
"bacalhau",
"salmão"
};

new COLORS[] = { // aqui são as cores.
Vermelho,
Azul,
Amarelo,
Verde
};

new CheckStatusTimer;

new PlayerVehicle[212][] = {
"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana",
"Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat",
"Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife",
"Trailer 1", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo",
"Seasparrow", "Pizzaboy", "Tram", "Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
"Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow",
"Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito",
"Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring",
"Sandking", "Blista Compact", "Police Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B",
"Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster","Stunt",  "Tanker",
"Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak",
"Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck LA", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit",
"Utility", "Nevada", "Yosemite", "Windsor", "Monster A", "Monster B", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance",
"RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito", "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway",
"Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer 3", "Emperor", "Wayfarer", "Euros", "Hotdog",
"Club", "Freight Carriage", "Trailer 4", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car (LSPD)", "Police Car (SFPD)",
"Police Car (LVPD)", "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage Trailer A",
"Luggage Trailer B", "Stairs", "Boxville", "Tiller", "Utility Trailer" };


new bool:TextDrawsShown[MAX_PLAYERS];
new bool:LightRedHealthCreated[MAX_PLAYERS];
new bool:LightYellowSpeedCreated[MAX_PLAYERS];
new bool:VHSCreated[MAX_PLAYERS];
new bool:ExclamationShown[MAX_PLAYERS];

new conta = 0;
new Timer[1];


new Text:Black0;
new Text:Black1;
new Text:Black2;
new Text:Black3;
new Text:LightBlack;
new Text:BlackHealth;
new Text:DarkRedHealth;
new Text:BlackSpeed;
new Text:DarkYellowSpeed;
new Text:Marker;
new Text:Exclamation;
new adminvisivel[MAX_PLAYERS];


new Text:VHS[MAX_PLAYERS];
new Text:LightRedHealth[MAX_PLAYERS];
new Text:LightYellowSpeed[MAX_PLAYERS];


//Forwards
//forward ChecarArmas(playerid);
//forward ChecarGrana(playerid);
forward CriarVeiculo(m,Float:x,Float:y,Float:z,Float:r,c,d);
forward CriarVeiculo2(m,Float:x,Float:y,Float:z,Float:r,c,d);
forward CriarExplosao(Float:X,Float:Y,Float:Z,tipo,Float:diam);
forward DestruirObjeto(objid);
forward TempoFaculdade();
forward Posto(playerid);
forward Praga(playerid);
//forward PlayerUpdate(playerid);
forward playermoney(playerid);
//forward SavePlayerHouse(houseid);
//forward ReadPlayerHouseData(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward abastece();
forward Up(playerid);
//forward Vidaa();
forward cheats();
forward Combustivel();
forward Portoes();
//forward Speed2();
forward MudarHora();
//forward MudarStats(playerid);
forward Score();
forward ABroadCast(COLOR,const string[],level);
forward ABroadCast2(COLOR,const string[],level);
forward Presos();
forward RandomMSGs();
//forward Clima();
forward AntiAfk();
forward PescaT();
forward CheckStatus();
forward Taxi();
forward Online(playerid);
forward ChangeText();
forward Contagem();
forward Liberarcmd();
//forward vervip();
//forward game();
forward VoteTimer(giveplayerid);
forward WaitT(playerid);
//forward voltartext();
forward lutinha(playerid, fightid);
forward Timerunic();
                                            
main()
{
	print("\n----------------------------------");
	print("Philips RPG");
	print("----------------------------------\n");
}

//inicio
public CriarVeiculo(m,Float:x,Float:y,Float:z,Float:r,c,d) CreateVehicle(m,x,y,z,r,c,d,7200);

public CriarVeiculo2(m,Float:x,Float:y,Float:z,Float:r,c,d){
new string[256];
format(string, sizeof(string), "carro%d.ini", proximocarro);
new carroid;
carroid = AddStaticVehicle(m, x, y, z, r, c, d);
dini_IntSet(string, "Id", carroid);
proximocarro++;
}


public OnPlayerRequestSpawn(playerid) {
	SendClientMessage(playerid, Vermelho,"Você não se registrou/logou.");
    return 0;
}

public OnGameModeInit()
{ 
//tenso tneso tenso tex

Philipsmsginicio = TextDrawCreate(216.000000, 159.000000, "Philips RPG");
TextDrawBackgroundColor(Philipsmsginicio, 255);
TextDrawFont(Philipsmsginicio, 2);
TextDrawLetterSize(Philipsmsginicio, 0.950000, 3.000000);
TextDrawColor(Philipsmsginicio, 809775224);
TextDrawSetOutline(Philipsmsginicio, 0);
TextDrawSetProportional(Philipsmsginicio, 1);
TextDrawSetShadow(Philipsmsginicio, 1);

text1 = TextDrawCreate(216.000000, 159.000000, "Philips RPG");
TextDrawBackgroundColor(text1, 255);
TextDrawFont(text1, 2);
TextDrawLetterSize(text1, 0.950000, 3.000000);
TextDrawColor(text1, 809775224);
TextDrawSetOutline(text1, 0);
TextDrawSetProportional(text1, 1);
TextDrawSetShadow(text1, 1);

	ho = CreateObject(980, 610.76342773438, -2003.1768798828, 5.1717176437378, 0, 0, 270);
    ho2 = CreateObject(980, 610.77551269531, -1991.6096191406, 5.2127165794373, 0, 0, 90);
	hott = CreateObject(980, 666.91223144531, -1908.8677978516, 4.6584520339966, 0, 0, 0);
   	hott2 = CreateObject(980, 686.42858886719, -1909.5538330078, 4.4638714790344, 0, 0, 0);

text2 = TextDrawCreate(0.000000, 164.000000, "________________");
TextDrawBackgroundColor(text2, 255);
TextDrawFont(text2, 3);
TextDrawLetterSize(text2, 0.500000, 3.000000);
TextDrawColor(text2, -126);
TextDrawSetOutline(text2, 0);
TextDrawSetProportional(text2, 1);
TextDrawSetShadow(text2, 1);
TextDrawUseBox(text2, 1);
TextDrawBoxColor(text2, -166);
TextDrawTextSize(text2, 650.000000, 20.000000);

text3 = TextDrawCreate(-1.000000, 157.000000, "-");
TextDrawBackgroundColor(text3, 255);
TextDrawFont(text3, 1);
TextDrawLetterSize(text3, 0.519999, 0.200000);
TextDrawColor(text3, -1);
TextDrawSetOutline(text3, 0);
TextDrawSetProportional(text3, 1);
TextDrawSetShadow(text3, 1);
TextDrawUseBox(text3, 1);
TextDrawBoxColor(text3, 255);
TextDrawTextSize(text3, 660.000000, -61.000000);

text4 = TextDrawCreate(-1.000000, 192.000000, "-");
TextDrawBackgroundColor(text4, 255);
TextDrawFont(text4, 1);
TextDrawLetterSize(text4, 0.500000, 0.199999);
TextDrawColor(text4, -1);
TextDrawSetOutline(text4, 0);
TextDrawSetProportional(text4, 1);
TextDrawSetShadow(text4, 1);
TextDrawUseBox(text4, 1);
TextDrawBoxColor(text4, 255);
TextDrawTextSize(text4, 650.000000, 0.000000);

text5 = TextDrawCreate(-1.000000, 157.000000, "-");
TextDrawBackgroundColor(text5, 255);
TextDrawFont(text5, 1);
TextDrawLetterSize(text5, -5.819998, 3.500001);
TextDrawColor(text5, -1);
TextDrawSetOutline(text5, 0);
TextDrawSetProportional(text5, 1);
TextDrawSetShadow(text5, 1);
TextDrawUseBox(text5, 1);
TextDrawBoxColor(text5, 255);
TextDrawTextSize(text5, 7.000000, 0.000000);

text6 = TextDrawCreate(630.000000, 160.000000, "_______");
TextDrawBackgroundColor(text6, 255);
TextDrawFont(text6, 0);
TextDrawLetterSize(text6, 2.120000, 3.700001);
TextDrawColor(text6, -1);
TextDrawSetOutline(text6, 0);
TextDrawSetProportional(text6, 1);
TextDrawSetShadow(text6, 1);
TextDrawUseBox(text6, 1);
TextDrawBoxColor(text6, 255);
TextDrawTextSize(text6, 640.000000, 104.000000);
//fim text
blockbomba = 0;
diadasemana = 0;
SetWeather(2);
entrarpref = CreatePickup(1239,1,1481.3777,-1772.3026,18.7958);
sairpref = CreatePickup(1239,1,389.2030,173.7325,1008.3828);
//Negoço
Black0 = TextDrawCreate(481.000000,353.000000,"_");
	Black1 = TextDrawCreate(481.000000,353.000000,"_");
	Black2 = TextDrawCreate(597.000000,353.000000,"_");
	Black3 = TextDrawCreate(481.000000,422.000000,"_");
	TextDrawUseBox(Black0,1);
	TextDrawBoxColor(Black0,0x000000ff);
	TextDrawTextSize(Black0,596.000000,8.000000);
	TextDrawUseBox(Black1,1);
	TextDrawBoxColor(Black1,0x000000ff);
	TextDrawTextSize(Black1,480.000000,0.000000);
	TextDrawUseBox(Black2,1);
	TextDrawBoxColor(Black2,0x000000ff);
	TextDrawTextSize(Black2,596.000000,0.000000);
	TextDrawUseBox(Black3,1);
	TextDrawBoxColor(Black3,0x000000ff);
	TextDrawTextSize(Black3,596.000000,3.000000);
	TextDrawAlignment(Black0,0);
	TextDrawAlignment(Black1,0);
	TextDrawAlignment(Black2,0);
	TextDrawAlignment(Black3,0);
	TextDrawBackgroundColor(Black0,0x000000ff);
	TextDrawBackgroundColor(Black1,0x000000ff);
	TextDrawBackgroundColor(Black2,0x000000ff);
	TextDrawBackgroundColor(Black3,0x000000ff);
	TextDrawFont(Black0,3);
	TextDrawLetterSize(Black0,1.000000,-0.100000);
	TextDrawFont(Black1,3);
	TextDrawLetterSize(Black1,1.000000,7.500000);
	TextDrawFont(Black2,3);
	TextDrawLetterSize(Black2,1.000000,7.500000);
	TextDrawFont(Black3,3);
	TextDrawLetterSize(Black3,1.000000,-0.100000);
	TextDrawColor(Black0,0xffffffff);
	TextDrawColor(Black1,0xffffffff);
	TextDrawColor(Black2,0xffffffff);
	TextDrawColor(Black3,0xffffffff);
	TextDrawSetOutline(Black0,1);
	TextDrawSetOutline(Black1,1);
	TextDrawSetOutline(Black2,1);
	TextDrawSetOutline(Black3,1);
	TextDrawSetProportional(Black0,1);
	TextDrawSetProportional(Black1,1);
	TextDrawSetProportional(Black2,1);
	TextDrawSetProportional(Black3,1);
	TextDrawSetShadow(Black0,1);
	TextDrawSetShadow(Black1,1);
	TextDrawSetShadow(Black2,1);
	TextDrawSetShadow(Black3,1);

	LightBlack = TextDrawCreate(484.000000,355.000000,"_");
	TextDrawUseBox(LightBlack,1);
	TextDrawBoxColor(LightBlack,0x00000033);
	TextDrawTextSize(LightBlack,593.000000,0.000000);
	TextDrawAlignment(LightBlack,0);
	TextDrawBackgroundColor(LightBlack,0x000000ff);
	TextDrawFont(LightBlack,3);
	TextDrawLetterSize(LightBlack,1.000000,7.099995);
	TextDrawColor(LightBlack,0xffffffff);
	TextDrawSetOutline(LightBlack,1);
	TextDrawSetProportional(LightBlack,1);
	TextDrawSetShadow(LightBlack,1);

	BlackHealth = TextDrawCreate(487.000000,385.000000,"_");
	TextDrawUseBox(BlackHealth,1);
	TextDrawBoxColor(BlackHealth,0x00000099);
	TextDrawTextSize(BlackHealth,590.000000,-11.000000);
	TextDrawAlignment(BlackHealth,0);
	TextDrawBackgroundColor(BlackHealth,0x000000ff);
	TextDrawFont(BlackHealth,3);
	TextDrawLetterSize(BlackHealth,1.000000,0.399999);
	TextDrawColor(BlackHealth,0xffffffff);
	TextDrawSetOutline(BlackHealth,1);
	TextDrawSetProportional(BlackHealth,1);
	TextDrawSetShadow(BlackHealth,1);

	DarkRedHealth = TextDrawCreate(488.000000,386.000000,"_");
	TextDrawUseBox(DarkRedHealth,1);
	TextDrawBoxColor(DarkRedHealth,0xff000066);
	TextDrawTextSize(DarkRedHealth,589.000000,0.000000);
	TextDrawAlignment(DarkRedHealth,0);
	TextDrawBackgroundColor(DarkRedHealth,0x000000ff);
	TextDrawFont(DarkRedHealth,3);
	TextDrawLetterSize(DarkRedHealth,1.000000,0.199999);
	TextDrawColor(DarkRedHealth,0xffffffff);
	TextDrawSetOutline(DarkRedHealth,1);
	TextDrawSetProportional(DarkRedHealth,1);
	TextDrawSetShadow(DarkRedHealth,1);

	BlackSpeed = TextDrawCreate(536.000000,403.000000,"_");
	TextDrawUseBox(BlackSpeed,1);
	TextDrawBoxColor(BlackSpeed,0x00000099);
	TextDrawTextSize(BlackSpeed,590.000000,0.000000);
	TextDrawAlignment(BlackSpeed,0);
	TextDrawBackgroundColor(BlackSpeed,0x000000ff);
	TextDrawFont(BlackSpeed,3);
	TextDrawLetterSize(BlackSpeed,1.000000,1.400000);
	TextDrawColor(BlackSpeed,0xffffffff);
	TextDrawSetOutline(BlackSpeed,1);
	TextDrawSetShadow(BlackSpeed,1);
	TextDrawSetProportional(BlackSpeed,1);

	DarkYellowSpeed = TextDrawCreate(537.000000,404.000000,"_");
	TextDrawUseBox(DarkYellowSpeed,1);
	TextDrawBoxColor(DarkYellowSpeed,0xffff0033);
	TextDrawTextSize(DarkYellowSpeed,589.000000,0.000000);
	TextDrawAlignment(DarkYellowSpeed,0);
	TextDrawBackgroundColor(DarkYellowSpeed,0x000000ff);
	TextDrawFont(DarkYellowSpeed,3);
	TextDrawLetterSize(DarkYellowSpeed,1.000000,1.200000);
	TextDrawColor(DarkYellowSpeed,0xffffffff);
	TextDrawSetOutline(DarkYellowSpeed,1);
	TextDrawSetProportional(DarkYellowSpeed,1);
	TextDrawSetShadow(DarkYellowSpeed,1);

	Marker = TextDrawCreate(511.000000,382.000000,"l");
	TextDrawAlignment(Marker,0);
	TextDrawBackgroundColor(Marker,0x000000ff);
	TextDrawFont(Marker,1);
	TextDrawLetterSize(Marker,0.099999,1.000000);
	TextDrawColor(Marker,0xffffffff);
	TextDrawSetOutline(Marker,1);
	TextDrawSetProportional(Marker,1);
	TextDrawSetShadow(Marker,1);

	Exclamation = TextDrawCreate(579.000000,351.000000,"~r~!");
	TextDrawAlignment(Exclamation,0);
	TextDrawBackgroundColor(Exclamation,0x000000ff);
	TextDrawFont(Exclamation,2);
	TextDrawLetterSize(Exclamation,1.200000,3.399999);
	TextDrawColor(Exclamation,0xffffffff);
	TextDrawSetOutline(Exclamation,1);
	TextDrawSetProportional(Exclamation,1);
	TextDrawSetShadow(Exclamation,1);

         
    dano = TextDrawCreate(0.000000,0.000000,"~r~_");
    TextDrawFont(dano,2);     
    TextDrawUseBox(dano,1);
	TextDrawBoxColor(dano,0xFF000044);
    TextDrawColor(dano,0xFF000044);
    TextDrawLetterSize(dano,999.599999,999.000000);
    TextDrawSetOutline(dano,1);
    //TextDrawSetShadow(dano,1);
    TextDrawSetProportional(dano,1);
    TextDrawBackgroundColor(dano,0x000000ff);
    
    mote = TextDrawCreate(0.000000,0.000000,"~w~_");
    TextDrawFont(mote,2);     
    TextDrawUseBox(mote,1);
	TextDrawBoxColor(mote,0x000000FF);
    TextDrawColor(mote,0x000000FF);
    TextDrawLetterSize(mote,999.599999,999.000000);
    TextDrawSetOutline(mote,1);
   // TextDrawSetShadow(dano,1);
    TextDrawSetProportional(mote,1);
    TextDrawBackgroundColor(mote,0x000000FF); 
    
    motendo = TextDrawCreate(0.000000,0.000000,"~w~_");
    TextDrawFont(motendo,2);     
    TextDrawUseBox(motendo,1);
	TextDrawBoxColor(motendo,0x00000049);
    TextDrawColor(motendo,0x00000049);
    TextDrawLetterSize(motendo,999.599999,999.000000);
    TextDrawSetOutline(motendo,1);
   // TextDrawSetShadow(dano,1);
    TextDrawSetProportional(motendo,1);
    TextDrawBackgroundColor(motendo,0x00000049); 
    
    motendo2 = TextDrawCreate(0.000000,0.000000,"~w~_");
    TextDrawFont(motendo2,2);     
    TextDrawUseBox(motendo2,1);
	TextDrawBoxColor(motendo2,0x000000AA);
    TextDrawColor(motendo2,0x000000AA);
    TextDrawLetterSize(motendo2,999.599999,999.000000);
    TextDrawSetOutline(motendo2,1);
   // TextDrawSetShadow(dano,1);
    TextDrawSetProportional(motendo2,1);
    TextDrawBackgroundColor(motendo2,0x000000AA);      

    morti = TextDrawCreate(260.000000,222.000000,"~r~morreu");
    TextDrawFont(morti,2);
    TextDrawColor(morti,0xAA3333AA);
    TextDrawLetterSize(morti,0.599999,1.000000);
    TextDrawSetOutline(morti,1);
    TextDrawSetShadow(morti,1);
    TextDrawSetProportional(morti,1);
    TextDrawBackgroundColor(morti,0x000000ff);

	CheckStatusTimer = SetTimer("CheckStatus", 900, 1);
SetTimer("Portoes", 120000, 1);

cm = CreateObject(976, 323.88812255859, -1186.2302246094, 75.399711608887, 0, 0, 218.34912109375);
Pickuploja = CreatePickup(1239, 1, 1352.2811,-1759.2417,13.5078, -1);    
    Pickuploja1 = CreatePickup(1318, 1, -25.9943,-187.8349,1003.5469, -1);
    pickupacademia = CreatePickup(1318, 1, 1153.9280,-1772.6763,16.5992, -1);
    pickupacademia1 = CreatePickup(1318, 1, 774.1472,-50.3324,1000.5859, -1);
    EntradaPizzaria = CreatePickup(1318, 1, 2105.1492,-1806.3323,13.5547, 0);
    SaidaPizzaria = CreatePickup(1318, 1, 372.3133,-133.5121,1001.4922, 0);
    EntradaAmmu = CreatePickup(1318, 1, 1368.7828,-1279.8550,13.5469, 0);
    SaidaAmmu = CreatePickup(1318, 1, 315.5867,-143.4563,999.6016, 0);
    EntradaBurguer = CreatePickup(1318, 1, 1199.1945,-918.1529,43.1236, 0);
    SaidaBurguer = CreatePickup(1318, 1, 363.0583,-75.0801,1001.5078, 0);
    EntradaBurguer2 = CreatePickup(1318, 1, 810.9125,-1615.9412,13.5469, 0);
    SaidaBurguer2 = CreatePickup(1318, 1, 363.0583,-75.0801,1001.5078, 2);

	Tunar = CreateMenu("~b~Tunar", 1, 50.0, 180.0, 200.0, 200.0);
    AddMenuItem(Tunar, 0, "Paintjobs");
    AddMenuItem(Tunar, 0, "Cores");
    AddMenuItem(Tunar, 0, "Rodas");
    AddMenuItem(Tunar, 0, "Nitro");
    AddMenuItem(Tunar, 0, "Suspensao");
    AddMenuItem(Tunar, 0, "Tunar");
    AddMenuItem(Tunar, 0, "Cancelar");
    Paintjobs = CreateMenu("~b~Paintjobs", 1, 50.0, 180.0, 200.0, 200.0);
	AddMenuItem(Paintjobs, 0, "Pantjob 1");
	AddMenuItem(Paintjobs, 0, "Pantjob 2");
	AddMenuItem(Paintjobs, 0, "Pantjob 3");
	AddMenuItem(Paintjobs, 0, "Pantjob 4");
	AddMenuItem(Paintjobs, 0, "Pantjob 5");
    Cores = CreateMenu("~b~Cores", 1, 50.0, 180.0, 200.0, 200.0);
    AddMenuItem(Cores, 0, "Preto");
    AddMenuItem(Cores, 0, "Branco");
    AddMenuItem(Cores, 0, "Darbk Blue");
    AddMenuItem(Cores, 0, "Light Blue");
    AddMenuItem(Cores, 0, "Green");
    AddMenuItem(Cores, 0, "Red");
    AddMenuItem(Cores, 0, "Yellow");
    AddMenuItem(Cores, 0, "Pink");
    AddMenuItem(Cores, 0, "Cancelar");
    Rodas = CreateMenu("~b~Rodas", 1, 50.0, 180.0, 200.0, 200.0);
    AddMenuItem(Rodas, 0, "Estilo 1");
    AddMenuItem(Rodas, 0, "Estilo 2");
    AddMenuItem(Rodas, 0, "Estilo 3");
    AddMenuItem(Rodas, 0, "Estilo 4");
    AddMenuItem(Rodas, 0, "Estilo 5");
    AddMenuItem(Rodas, 0, "Estilo 6");
    AddMenuItem(Rodas, 0, "Cancelar");
    controle_ilha = CreateMenu("Controle", 1, 50.0, 180.0, 200.0, 200.0);
    ElevadorControle = CreateMenu("Elevador", 1, 50.0, 180.0, 200.0, 200.0);
    PortaoControle = CreateMenu("Portoes", 1, 50.0, 180.0, 200.0, 200.0);

	AddMenuItem(controle_ilha, 0, "Elevador");
	AddMenuItem(controle_ilha, 0, "Portoes");
	AddMenuItem(ElevadorControle, 0, "Elevador 1 Andar");
	AddMenuItem(ElevadorControle, 0, "Elevador 2 Andar");
	AddMenuItem(ElevadorControle, 0, "Elevador 3 Andar");
	AddMenuItem(PortaoControle, 0, "Abrir Portao 1");
	AddMenuItem(PortaoControle, 0, "Fechar Portao 1");

	Pickupagencia1 = CreatePickup(1277, 1, 1791.46484375,-1696.3012695313,13.085081863403, -1);
	Pickupescola1 = CreatePickup(1318, 1, -2029.8780517578,-119.17469787598,1035.571533203, -1);
    Pickupagencia = CreatePickup(1318, 1, 834.63342285156,7.2929058074951,1004.1870117188, -1);
	Pickupescola = CreatePickup(1254, 1, 1804.6518554688,-1715.8947753906,13.336117362976, -1);
 
UsePlayerPedAnims();
//base cv
CreateObject(3749, 2423.631348, -2089.838379, 18.398302, 0.0000, 0.0000, 90.0000);
portaocv = CreateObject(980, 2423.698242, -2089.869873, 15.317423, 0.0000, 0.0000, 90.0000);
//base fbi
CreateObject(3749, 2232.698975, -2215.799316, 18.405289, 0.0000, 0.0000, 315.0000);
portaofbi = CreateObject(980, 2232.818359, -2215.736084, 15.320267, 0.0000, 0.0000, 315.0000);
	TAXISTAS = CreateObject(980, 1811.6870117188, -1886.5489501953, 15.181365966797, 0, 0, 270);
 //base mecanica
CreateObject(3749, 1534.756226, -1452.098389, 18.534021, 0.0000, 0.0000, 0.0000);
portaom = CreateObject(980, 1535.336426, -1452.098389, 15.165947, 0.0000, 0.0000, 0.0000);
portaodp = CreateObject(980, 1552.437988, -1627.392578, 15.156204, 0.0000, 0.0000, 90.0000);

    Depositar1 = CreatePickup(1239, 1, 242.222457,118.88782,1003.4046, -1);
    Comprovante = CreatePickup(1239, 1, 250.5496,118.887825,1003.4046, -1);
    Sacar1 = CreatePickup(1239, 1, 246.490554,118.88782501221,1003.4046, -1);

//objects
//etc
DisableInteriorEnterExits();
SetGameModeText("Brasil Philips RPG 0.7");
SendRconCommand("mapname Los Santos");
SendRconCommand("hostname Brasil Philips RPG || Venha Viver o Futuro!");

	pickuplane =  CreatePickup(1239, 1, 2164.7490234375,-1801.0004882813,13.510689163208, -1);
	pickuplans =  CreatePickup(1239, 1, 2130.3933105469,-1807.2817382813,670.62042236328, -1);
    pickuplan1 = CreatePickup(1239, 1, 2138.49609375,-1816.1645507813,670.33666992188, -1);
	pickuplan2 = CreatePickup(1239, 1, 2132.5961914063,-1816.1645507813,670.33666992188, -1);
	pickuplan3 = CreatePickup(1239, 1, 2126.961914063,-1816.1645507813,670.33666992188, -1);
	pickuplan4 = CreatePickup(1239, 1, 2120.96191406255,-1816.1645507813,670.33666992188, -1);
    pickupbanco = CreatePickup(1239, 1, 1720.3205566406,-1741.5162353516,13.897917747498, -1);
    pickupbanco1 = CreatePickup(1318, 1, 246.42222595215,107.68905639648,1003.5040893555, -1);
fe = CPS_AddCheckpoint(2092.7805,-1565.2965,12.7645, 9.0, 999999); 
Depositar = CPS_AddCheckpoint(242.2199,118.5333,1003.2188, 1.0, 80);
Sacar = CPS_AddCheckpoint(250.6065,118.5373,1003.2188, 1.0, 80);
pc1 = CPS_AddCheckpoint(2138.7126,-1816.1311,670.5513, 1.5, 70);
pc2 = CPS_AddCheckpoint(2132.8457,-1815.8822,670.5513, 1.5, 70);
pc3 = CPS_AddCheckpoint(2126.7415,-1815.9147,670.5513, 1.5, 70);
pc4 = CPS_AddCheckpoint(2120.7815,-1816.0684,670.5513, 1.5, 70);
Pizzaria = CPS_AddCheckpoint(376.8232,-120.7552,1001.4995, 1.5, 70);
Ammu = CPS_AddCheckpoint(312.9799,-134.2396,999.6016, 1.5, 70);
Burguer = CPS_AddCheckpoint(376.5019,-68.9176,1001.5078, 1.5, 70);
academia = CPS_AddCheckpoint(768.6035,-37.2981,1000.6865, 1.5, 70);
Reboque = CPS_AddCheckpoint(1519.5504,-1478.3710,9.5000, 1.5, 70);

hotel = CPS_AddCheckpoint(654.76928710938,-1899.3647460938,3.4272708892822,3.0,50);

Banco = CPS_AddCheckpoint(246.7561,118.5147,1003.2188, 3.0, 50);
Telefone = CPS_AddCheckpoint(1723.3234,-1720.8914,13.5444, 3.0, 50);
Loja = CPS_AddCheckpoint(-29.0512,-185.0015,1003.5469, 3.0, 50);
Faculdade = CPS_AddCheckpoint(1139.4012,-1761.3579,13.5950, 3.0, 50);
HabLocal = CPS_AddCheckpoint(-2032.3525,-117.4710,1035.1719, 3.0, 50);
Shopping = CPS_AddCheckpoint(1128.9546,-1461.7429,15.7969, 3.0, 50);
profis = CPS_AddCheckpoint(364.5743,173.6367,1008.3893, 3.0, 50);
Pescaria = CPS_AddCheckpoint(836.7571,-2065.4785,12.8672, 5.0, 50);
VendaPesca = CPS_AddCheckpoint(387.0509,-1837.0605,7.8359, 3.0, 50);
localjornal = CPS_AddCheckpoint(1022.6270,-981.9053,42.6063, 3.0, 50);
areadm = CPS_AddCheckpoint(1360.9185,-1651.3649,13.3828, 3.0, 50);
armas = CPS_AddCheckpoint(1080.9312,-1698.0581,13.5469, 3.0, 50);
carga = CPS_AddCheckpoint(1003.1738,-905.0977,42.8021, 5.0, 50);
discarga = CPS_AddCheckpoint(1655.6230,1624.9274,11.3729, 5.0, 150);
  portao1 = CreateObject(980, 2675.9626464844, -2565.7807617188, 15.405038833618, 0, 0, 0);
    portao2 = CreateObject(980, 2676.1135253906, -2745.8696289063, 15.322637557983, 0, 0, 0);
    elevador1 = CreateObject(3885, 2735.5400390625, -2743.0239257813, 12.061451911926, 0, 0, 165);


SetTimer("Online", 60000, 1);
SetTimer("Taxi", 5000, 1);
SetTimer("Liberarcmd", 300000, 1);
//SetTimer("game", 3000, 1);



AddPlayerClass(255,-2233.8994,-1734.9799,480.8356,222.4816,0,0,0,0,0,0); //

//Mensagenzinha quando inicia

print("<|-----------------------------------------|>");
print(" |  .: [  - Philips RPG  ] :.  |");
print("<|-----------------------------------------|>");

    //SetTimer("Up", 900000, 1);    
    SetTimer("Combustivel", 50000, 1);  
    SetTimer("PescaT", 80000, 1);   
    //SetTimer("Speed2", 1000, 1);    
    SetTimer("Presos", 600000, 1);
 //   SetTimer("ChecarArmas",5000, true);         
//    SetTimer("ChecarGrana",3000, true); 
    SetTimer("RandomMSGs",60000,1); 
    
 
	new File:temp;
	new index = 0;
	new tmp[256];
	new modelid, Float:X, Float:Y, Float:Z, Float:ang, Cor1, Cor2;
	temp = fopen("Carros.cfg", io_readwrite);
	while(fread(temp, tmp, sizeof(tmp), false)) {
		index = 0;
		modelid    = strval(strtok(tmp, index));
		X          = Float:floatstr(strtok(tmp, index));
		Y          = Float:floatstr(strtok(tmp, index));
		Z          = Float:floatstr(strtok(tmp, index));
		ang        = Float:floatstr(strtok(tmp, index));
		Cor1       = strval(strtok(tmp, index));
		Cor2       = strval(strtok(tmp, index));

		cAddStaticVehicleEx(modelid, X, Y, Z, ang, Cor1, Cor2, 7200);
	}
	fclose(temp);


Relogio = TextDrawCreate(500.000000, 102.000000, "00:00");
TextDrawBackgroundColor(Relogio, 255);
TextDrawFont(Relogio, 3);
TextDrawLetterSize(Relogio, 0.639999, 2.500000);
TextDrawColor(Relogio, 525020074);
TextDrawSetOutline(Relogio, 1);
TextDrawSetProportional(Relogio, 1);
TextDrawUseBox(Relogio, 1);
TextDrawBoxColor(Relogio, 70);
TextDrawTextSize(Relogio, 564.000000, 2.000000);   

Exp = TextDrawCreate(0.0, 435, "                ~r~Philips RPG ~y~ || ~b~Seja Bem Vindo");
TextDrawBackgroundColor(Exp, 255);
TextDrawFont(Exp, 3);
TextDrawLetterSize(Relogio, 0.279999, 1.000000);
TextDrawColor(Relogio, -1);
TextDrawSetOutline(Relogio, 1);
TextDrawSetProportional(Relogio, 1);
SetTimer("MudarHora",2000,true);
SetTimer("ChangeText",10000,true);
SetTimer("Posto",500,true);
SetTimer("Score",1000,true);
SetTimer("TempoFaculdade",1000,true);
SetTimer("abastece",400,true);
//SetTimer("MudarStats",20000,true);
SetTimer("AntiAfk",60000,true);
new carro = 0;
for(carro = 0; carro < 500; carro++)
{
Trancado[carro] = 0;
TrancadoPara[carro] = 0;
}
new string[256];
for(new carror = 0; carror < MAX_CARROS; carror++)
{
format(string, sizeof(string), "carro%d.ini", carror);
if(dini_Exists(string)){
new carroid;
carroid = AddStaticVehicle(dini_Int(string, "Modelo"), dini_Float(string, "CordX"), dini_Float(string, "CordY"), dini_Float(string, "CordZ"), dini_Float(string, "Angulo"), dini_Int(string, "Cor1"), dini_Int(string, "Cor2"));
dini_IntSet(string, "Id", carroid);
proximocarro++;
}
}
for(new p = 0; p < MAX_CASAS; p++)
{
format(string, sizeof(string), "prop%d.ini", p);
if(dini_Exists(string)){
new pickupid;
if(dini_Int(string, "TDono") == 0){
pickupid = CreatePickup(1273, 1, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"), -1);
dini_IntSet(string, "Id", pickupid);
proximaprop++;
} else {
pickupid = CreatePickup(1272, 1, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"), -1);
dini_IntSet(string, "Id", pickupid);
proximaprop++;
}
}
}
for(new c = 0; c < MAX_CASAS; c++)
{
format(string, sizeof(string), "casa%d.ini", c);
if(dini_Exists(string)){
new pickupid;
if(dini_Int(string, "TDono") == 0){
pickupid = CreatePickup(1273, 1, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"), -1);
dini_IntSet(string, "Id", pickupid);
proximacasa++;
} else {
pickupid = CreatePickup(1272, 1, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"), -1);
dini_IntSet(string, "Id", pickupid);
proximacasa++;
}
}
}
if(!dini_Exists("int0.ini")){
dini_Create("int0.ini");
dini_IntSet("int0.ini", "Int", 1);
dini_FloatSet("int0.ini", "EX", 222.9534);
dini_FloatSet("int0.ini", "EY", 1287.7649);
dini_FloatSet("int0.ini", "EZ", 1082.1406);
}
if(!dini_Exists("int1.ini")){
dini_Create("int1.ini");
dini_IntSet("int1.ini", "Int", 4);
dini_FloatSet("int1.ini", "EX", 261.0827);
dini_FloatSet("int1.ini", "EY", 1284.6899);
dini_FloatSet("int1.ini", "EZ", 1080.2578);
}
if(!dini_Exists("int2.ini")){
dini_Create("int2.ini");
dini_IntSet("int2.ini", "Int", 9);
dini_FloatSet("int2.ini", "EX", 260.6734);
dini_FloatSet("int2.ini", "EY", 1237.7909);
dini_FloatSet("int2.ini", "EZ", 1084.2578);
}
if(!dini_Exists("int3.ini")){
dini_Create("int3.ini");
dini_IntSet("int3.ini", "Int", 15);
dini_FloatSet("int3.ini", "EX", 376.8426);
dini_FloatSet("int3.ini", "EY", 1417.3226);
dini_FloatSet("int3.ini", "EZ", 1081.3281);
}
if(!dini_Exists("int4.ini")){
dini_Create("int4.ini");
dini_IntSet("int4.ini", "Int", 15);
dini_FloatSet("int4.ini", "EX", 295.2874);
dini_FloatSet("int4.ini", "EY", 1473.2769);
dini_FloatSet("int4.ini", "EZ", 1080.2578);
}
if(!dini_Exists("int5.ini")){
dini_Create("int5.ini");
dini_IntSet("int5.ini", "Int", 15);
dini_FloatSet("int5.ini", "EX", 327.9431);
dini_FloatSet("int5.ini", "EY", 1478.3801);
dini_FloatSet("int5.ini", "EZ", 1084.4375);
}
if(!dini_Exists("int6.ini")){
dini_Create("int6.ini");
dini_IntSet("int6.ini", "Int", 10);
dini_FloatSet("int6.ini", "EX", 2270.1050);
dini_FloatSet("int6.ini", "EY", -1210.3917);
dini_FloatSet("int6.ini", "EZ", 1047.5625);
}
if(!dini_Exists("int7.ini")){
dini_Create("int7.ini");
dini_IntSet("int7.ini", "Int", 2);
dini_FloatSet("int7.ini", "EX", 447.1211);
dini_FloatSet("int7.ini", "EY", 1397.8444);
dini_FloatSet("int7.ini", "EZ", 1084.3047);
}
if(!dini_Exists("int8.ini")){
dini_Create("int8.ini");
dini_IntSet("int8.ini", "Int", 6);
dini_FloatSet("int8.ini", "EX", 2196.0063);
dini_FloatSet("int8.ini", "EY", -1204.6326);
dini_FloatSet("int8.ini", "EZ", 1049.0234);
}
if(!dini_Exists("int9.ini")){
dini_Create("int9.ini");
dini_IntSet("int9.ini", "Int", 3);
dini_FloatSet("int9.ini", "EX", 235.3416);
dini_FloatSet("int9.ini", "EY", 1187.2882);
dini_FloatSet("int9.ini", "EZ", 1080.2578);
}
if(!dini_Exists("int10.ini")){
dini_Create("int10.ini");
dini_IntSet("int10.ini", "Int", 2);
dini_FloatSet("int10.ini", "EX", 490.9987);
dini_FloatSet("int10.ini", "EY", 1399.4164);
dini_FloatSet("int10.ini", "EZ", 1080.2578);
}
if(!dini_Exists("int11.ini")){
dini_Create("int11.ini");
dini_IntSet("int11.ini", "Int", 5);
dini_FloatSet("int11.ini", "EX", 227.1212);
dini_FloatSet("int11.ini", "EY", 1114.1840);
dini_FloatSet("int11.ini", "EZ", 1080.9972);
}
if(!dini_Exists("int12.ini")){
dini_Create("int12.ini");
dini_IntSet("int12.ini", "Int", 7);
dini_FloatSet("int12.ini", "EX", 225.6624);
dini_FloatSet("int12.ini", "EY", 1022.5345);
dini_FloatSet("int12.ini", "EZ", 1084.0145);
}
if(!dini_Exists("Top.ini")){
dini_Create("Top.ini");
dini_IntSet("Top.ini", "Nivel", 0);
dini_Set("Top.ini", "NivelNome", "Ninguem");
dini_IntSet("Top.ini", "Fama", 0);
dini_Set("Top.ini", "FamaNome", "Ninguem");
dini_IntSet("Top.ini", "Minutos", 0);
dini_Set("Top.ini", "MinutosNome", "Ninguem");
}
new	strings[100], File:file;
	if((file = fopen("antiswear.cfg",io_read)))
	{
		while(fread(file,strings))
		{
		    for(new i = 0, j = strlen(strings); i < j; i++) if(strings[i] == '\n' || strings[i] == '\r') strings[i] = '\0';
            Swears[num_words] = strings;
            printf("%s", strings);
            num_words++;
		}
		fclose(file);
	}
}

public OnGameModeExit()
{
	KillTimer(CheckStatusTimer);
    KillTimer(Timer[0]);

	TextDrawDestroy(Text:Black0);
	TextDrawDestroy(Text:Black1);
	TextDrawDestroy(Text:Black2);
	TextDrawDestroy(Text:Black3);
	TextDrawDestroy(Text:LightBlack);
	TextDrawDestroy(Text:BlackHealth);
	TextDrawDestroy(Text:DarkRedHealth);
	TextDrawDestroy(Text:BlackSpeed);
	TextDrawDestroy(Text:DarkYellowSpeed);
	TextDrawDestroy(Text:Marker);
	TextDrawDestroy(Text:Exclamation);
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		TextDrawDestroy(Text:VHS[i]);
		TextDrawDestroy(Text:LightRedHealth[i]);
		TextDrawDestroy(Text:LightYellowSpeed[i]);
        Kick(i);
	}
}

public OnPlayerRequestClass(playerid, classid)
{
    new nomepl[MAX_PLAYER_NAME];    
    GetPlayerName(playerid, nomepl, MAX_PLAYER_NAME);
    TextDrawHideForPlayer(playerid, Textdraw0[playerid]);    
    TextDrawHideForPlayer(playerid,Philipsmsginicio);
    TextDrawHideForPlayer(playerid,text2);
    TextDrawHideForPlayer(playerid,text3);
    TextDrawHideForPlayer(playerid,text4);
    TextDrawHideForPlayer(playerid,text5);
    TextDrawHideForPlayer(playerid,text6);

 
    ShowPlayerDialog(playerid, 3, DIALOG_STYLE_MSGBOX, "Bem Vindo", "Seja Bem Vindo\nNosso server está começando, curta sua 2ª vida aqui\nClique em OK e comece a jogar", "OK", "Sair");
	SetPlayerPos(playerid, 1491.6591,-1697.8002,14.5469);
	SetPlayerFacingAngle(playerid,85.9499);
	SetPlayerCameraPos(playerid, 1479.9567,-1697.1774,14.0469);
	SetPlayerCameraLookAt(playerid, 1479.9567,-1697.1774,14.0469);
	PlayerPlaySound(playerid,1076,2808.1721,-1425.4561,55.2740);//musica on
 ApplyAnimation(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
    SetPlayerColor(playerid, Preto);
    SetSpawnInfo(playerid, 1, dini_Int(nomepl, "Skin"), dini_Int(nomepl, "CasaX"), dini_Int(nomepl, "CasaY"), dini_Int(nomepl, "CasaZ"), 354.1657, 0, 0, 0, 0, 0, 0);
    if(Logado[playerid] == 1){
		Logado[playerid] = 0;
	}
if(dini_Int(nomepl, "Banido") == 1){
SendClientMessage(playerid, Vermelho, "VOCÊ ESTÁ BANIDO, entre em contato com um administrador.");
Ban(playerid);
}
	return 1;
}
public OnPlayerSpawn(playerid)
{
//TextDrawShowForPlayer(playerid, fominha[playerid]);
SetPlayerVirtualWorld(playerid, 0);
comfome[playerid] = 0;
celigado[playerid] = 0;
noevento[playerid] = 0;
SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 1);
SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 1);
SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 1);
TextDrawHideForPlayer(playerid, text1);
TextDrawHideForPlayer(playerid, mote);
TextDrawHideForPlayer(playerid, motendo);
TextDrawHideForPlayer(playerid, motendo2);
//TogglePlayerClock(playerid, 1);
new Float:X;
new Float:Y;
new Float:Z;
gmod[playerid] = 0;
new string[256];
new nomepl[MAX_PLAYER_NAME];
TextDrawHideForPlayer(playerid, morti);
SetPlayerHealth(playerid, 100);
GetPlayerName(playerid, nomepl, sizeof(nomepl));
SetPlayerSkin(playerid, dini_Int(nomepl, "Skin"));
GetPlayerPos(playerid, X, Y, Z);
AFKX[playerid] = X;
AFKY[playerid] = Y;
AFKZ[playerid] = Z;
SetPlayerPos(playerid, X, Y, Z);
PlayerPlaySound(playerid,1063,X,Y,Z);//Music Off
SetPlayerInterior(playerid, dini_Int(nomepl, "CasaI"));
TextDrawShowForPlayer(playerid, Relogio); 
TextDrawShowForPlayer(playerid, Exp);
TextDrawShowForPlayer(playerid, Textdraw0[playerid]);
if(dini_Int(nomepl, "Luta") == 0){
dini_IntSet(nomepl, "Luta", 4);
}
SetPlayerFightingStyle(playerid, dini_Int(nomepl, "Luta"));
/*if(areadmp[playerid] == 1){
SetPlayerInterior(playerid, 10);
SetPlayerPos(playerid, -975.975708,1060.983032,1345.671875);
format(string, sizeof(string), "Você estáva na área de dm e voltou pra lá, para sair: /sairdm.");
SendClientMessage(playerid, Amarelo, string);
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid, 26, 150);
GivePlayerWeapon(playerid, 24, 150);
GivePlayerWeapon(playerid, 34, 150);
}*/
if(dini_Int(nomepl, "Arma") == 1){
GivePlayerWeapon(playerid, 4, 150);
}
if(dini_Int(nomepl, "Profissao") == Desempregado){
SetPlayerColor(playerid, COR_DESEMPREGADO);
}
if(dini_Int(nomepl, "Profissao") == Estagiario){
GivePlayerWeapon(playerid, 1, 1);
SetPlayerColor(playerid, COR_ESTAGIARIO);
}
if(dini_Int(nomepl, "Profissao") == Guarda){
SetPlayerColor(playerid, COR_GUARDA);
GivePlayerWeapon(playerid, 3, 1);
}
if(dini_Int(nomepl, "Profissao") == Policial_R){
GivePlayerWeapon(playerid, 3, 1);
GivePlayerWeapon(playerid, 22, 12);
SetPlayerColor(playerid, COR_RODOVIARIO);
}
if(dini_Int(nomepl, "Profissao") == Policial_M){
GivePlayerWeapon(playerid, 3, 1);
GivePlayerWeapon(playerid, 22, 15);
SetPlayerColor(playerid, COR_MILITAR);
}
if(dini_Int(nomepl, "Profissao") == Policial_C){
GivePlayerWeapon(playerid, 3, 1);
GivePlayerWeapon(playerid, 22, 20);
GivePlayerWeapon(playerid, 25, 5);
SetPlayerColor(playerid, COR_CIVIL);
}
if(dini_Int(nomepl, "Profissao") == Policial_F){
GivePlayerWeapon(playerid, 3, 1);
GivePlayerWeapon(playerid, 27, 37);
GivePlayerWeapon(playerid, 31, 75);
GivePlayerWeapon(playerid, 23, 20);
SetPlayerColor(playerid, COR_FEDERAL);
}
if(dini_Int(nomepl, "Profissao") == Delegado){
GivePlayerWeapon(playerid, 3, 1);
GivePlayerWeapon(playerid, 25, 25);
GivePlayerWeapon(playerid, 22, 15);
SetPlayerColor(playerid, COR_DELEGADO);
}
if(dini_Int(nomepl, "Profissao") == Bope){
GivePlayerWeapon(playerid, 3, 1);
GivePlayerWeapon(playerid, 27, 50);
GivePlayerWeapon(playerid, 31, 150);
GivePlayerWeapon(playerid, 24, 50);
SetPlayerColor(playerid, COR_BOPE);
}
if(dini_Int(nomepl, "Profissao") == Swat){
GivePlayerWeapon(playerid, 3, 1);
GivePlayerWeapon(playerid, 27, 50);
GivePlayerWeapon(playerid, 31, 150);
GivePlayerWeapon(playerid, 24, 50);
GivePlayerWeapon(playerid, 29, 50);
SetPlayerColor(playerid, COR_SWAT);
}
if(dini_Int(nomepl, "Profissao") == Narcoticos){
GivePlayerWeapon(playerid, 3, 1);
GivePlayerWeapon(playerid, 27, 50);
GivePlayerWeapon(playerid, 31, 150);
GivePlayerWeapon(playerid, 24, 50);
GivePlayerWeapon(playerid, 16, 5);
SetPlayerColor(playerid, COR_NARCOTICOS);
}
if(dini_Int(nomepl, "Profissao") == Traficante){
GivePlayerWeapon(playerid, 24, 7);
SetPlayerColor(playerid, COR_TRAFICANTE);
}
if(dini_Int(nomepl, "Profissao") == Assasino){
GivePlayerWeapon(playerid, 24, 27);
GivePlayerWeapon(playerid, 26, 20);
GivePlayerWeapon(playerid, 28, 70);
GivePlayerWeapon(playerid, 4, 15);
SetPlayerColor(playerid, COR_ASSASINO);
}
if(dini_Int(nomepl, "Profissao") == Terrorista){
GivePlayerWeapon(playerid, 24, 150);
GivePlayerWeapon(playerid, 30, 250);
GivePlayerWeapon(playerid, 18, 20);
GivePlayerWeapon(playerid, 33, 150);
SetPlayerColor(playerid, COR_TERRORISTA);
}
if(dini_Int(nomepl, "Profissao") == Sequestrador){
GivePlayerWeapon(playerid, 24, 15);
SetPlayerColor(playerid, COR_SEQUESTRADOR);
}
if(dini_Int(nomepl, "Profissao") == AssasinoProfissional){
GivePlayerWeapon(playerid, 23, 27);
GivePlayerWeapon(playerid, 34, 30);
GivePlayerWeapon(playerid, 25, 30);
GivePlayerWeapon(playerid, 39, 15);
GivePlayerWeapon(playerid, 8, 15);
GivePlayerWeapon(playerid, 40, 9999999);
SetPlayerColor(playerid, COR_ASSPROF);
}
if(dini_Int(nomepl, "Profissao") == Jornalista){
GivePlayerWeapon(playerid, 14, 15);
SetPlayerColor(playerid, COR_JORNALISTA);
}
if(dini_Int(nomepl, "Profissao") == Fotografo){
GivePlayerWeapon(playerid, 43, 20);
GivePlayerWeapon(playerid, 14, 15);
SetPlayerColor(playerid, COR_FOTOGRAFO);
}
if(dini_Int(nomepl, "Profissao") == Reporter){
GivePlayerWeapon(playerid, 14, 15);
SetPlayerColor(playerid, COR_REPORTER);
}
if(dini_Int(nomepl, "Profissao") == Ancora){
GivePlayerWeapon(playerid, 14, 15);
SetPlayerColor(playerid, COR_ANCORA);
}
if(dini_Int(nomepl, "Profissao") == Meteorologista){
GivePlayerWeapon(playerid, 14, 15);
SetPlayerColor(playerid, COR_METEOROLOGISTA);
}
if(dini_Int(nomepl, "Profissao") == Mecanico){
GivePlayerWeapon(playerid, 41, 500);
SetPlayerColor(playerid, COR_MECANICO);
}
if(dini_Int(nomepl, "Profissao") == VendedorCasa){
GivePlayerWeapon(playerid, 9, 15);
SetPlayerColor(playerid, COR_VENDEDORCASA);
}
if(dini_Int(nomepl, "Profissao") == VendedorSkin){
GivePlayerWeapon(playerid, 9, 15);
SetPlayerColor(playerid, COR_VENDEDORSKIN);
}
if(dini_Int(nomepl, "Profissao") == VendedorCarro){
GivePlayerWeapon(playerid, 9, 15);
SetPlayerColor(playerid, COR_VENDEDORCARRO);
}
if(dini_Int(nomepl, "Profissao") == VendedorComb){
GivePlayerWeapon(playerid, 9, 15);
SetPlayerColor(playerid, COR_VENDEDORCOM);
}
if(dini_Int(nomepl, "Profissao") == Taxista){
GivePlayerWeapon(playerid, 22, 5);
SetPlayerColor(playerid, COR_TAXISTA);
}
if(dini_Int(nomepl, "Profissao") == Medico){
GivePlayerWeapon(playerid, 23, 15);
SetPlayerColor(playerid, COR_MEDICO);
}
if(dini_Int(nomepl, "Profissao") == FBI){
GivePlayerWeapon(playerid, 24, 999999);
GivePlayerWeapon(playerid, 31, 999999);
GivePlayerWeapon(playerid, 25, 999999);
GivePlayerWeapon(playerid, 34, 999999);
GivePlayerWeapon(playerid, 32, 999999);
GivePlayerWeapon(playerid, 46, 999999);
GivePlayerWeapon(playerid, 39, 999999);
GivePlayerWeapon(playerid, 40, 999999);
GivePlayerWeapon(playerid, 3, 999999);
SetPlayerColor(playerid, COR_FBI);
SetPlayerSkin(playerid, 286);
SetPlayerArmour(playerid, 100);
}
if(dini_Int(nomepl, "Profissao") == ComandoVermelho){
GivePlayerWeapon(playerid, 24, 999999);
GivePlayerWeapon(playerid, 30, 999999);
GivePlayerWeapon(playerid, 26, 999999);
GivePlayerWeapon(playerid, 28, 999999);
GivePlayerWeapon(playerid, 34, 999999);
GivePlayerWeapon(playerid, 46, 999999);
GivePlayerWeapon(playerid, 39, 999999);
GivePlayerWeapon(playerid, 40, 999999);
GivePlayerWeapon(playerid, 8, 999999);
SetPlayerColor(playerid, COR_COMANDO);
SetPlayerSkin(playerid, 124);
SetPlayerArmour(playerid, 100);
}
if(cs1[playerid] == 1){
SetPlayerInterior(playerid, 1);
SetPlayerPos(playerid, 1408.1414794922,-22.053915023804,1000.9221801758);
format(string, sizeof(string), "Voce Morreru CT,/sairct para sair do jogo");
SendClientMessage(playerid, AZULBLUE, string);
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid, 23, 999999);
GivePlayerWeapon(playerid, 29, 999999);
GivePlayerWeapon(playerid, 34, 999999);
GivePlayerWeapon(playerid, 25, 999999);
GivePlayerWeapon(playerid, 31, 999999);
SetPlayerColor(playerid,COLOR_AZUL);
SetPlayerSkin(playerid,285);
SetPlayerArmour(playerid,200);
SetPlayerHealth(playerid,100);
}

if(cs2[playerid] == 1){
SetPlayerInterior(playerid, 1);
SetPlayerPos(playerid, 1408.1414794922,-22.053915023804,1000.9221801758);
SendClientMessage(playerid, Verde, "Você morreu terrorista /sairjogo para de jogar");
SetPlayerInterior(playerid, 1);
SetPlayerPos(playerid, 1365.7126464844,-22.462772369385,1000.921875);
SetPlayerColor(playerid,RED);
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid, 28, 999999);
GivePlayerWeapon(playerid, 33, 999999);
GivePlayerWeapon(playerid, 25, 999999);
GivePlayerWeapon(playerid, 27, 999999);
GivePlayerWeapon(playerid, 30, 999999);
SetPlayerSkin(playerid,136);
SetPlayerArmour(playerid,200);
SetPlayerHealth(playerid,100);
}
if(cs3[playerid] == 1){
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, -453.9510,2200.1616,43.7733);
format(string, sizeof(string), "Voce Morreru Terrorista,/sairjogo para sair do jogo");
SendClientMessage(playerid, AZULBLUE, string);
SetPlayerArmour(playerid,200);
SetPlayerColor(playerid,RED);
SetPlayerHealth(playerid,100);
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid, 28, 999999);
GivePlayerWeapon(playerid, 33, 999999);
GivePlayerWeapon(playerid, 25, 999999);
GivePlayerWeapon(playerid, 27, 999999);
GivePlayerWeapon(playerid, 30, 999999);
SetPlayerSkin(playerid,136);
}
if(cs4[playerid] == 1){
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, -358.2130,2253.3440,42.4844);
format(string, sizeof(string), "Voce Morreru CT,/sairjogo para sair do jogo");
SendClientMessage(playerid, AZULBLUE, string);
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid, 23, 999999);
GivePlayerWeapon(playerid, 29, 999999);
GivePlayerWeapon(playerid, 34, 999999);
GivePlayerWeapon(playerid, 25, 999999);
GivePlayerWeapon(playerid, 31, 999999);
SetPlayerSkin(playerid,285);
SetPlayerArmour(playerid,200);
SetPlayerHealth(playerid,100);
}
if(areadmp[playerid] == 1){
SetPlayerInterior(playerid, 10);
SetPlayerPos(playerid, -975.975708,1060.983032,1345.671875);
format(string, sizeof(string), "Você estáva na área de dm e voltou pra lá, para sair: /sairdm.");
SendClientMessage(playerid, Amarelo, string);
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid, 26, 150);
GivePlayerWeapon(playerid, 24, 150);
GivePlayerWeapon(playerid, 34, 150);
}
if(dini_Int(nomepl, "Vip") > 0){
GivePlayerWeapon(playerid, 34, 999999999);
GivePlayerWeapon(playerid, 42, 999999999);
SetPlayerHealth(playerid, 150);
SetPlayerArmour(playerid, 100);
}
if(dini_Int(nomepl, "Arma") == 2){
GivePlayerWeapon(playerid, 8, 150);
}
if(dini_Int(nomepl, "Arma") == 3){
GivePlayerWeapon(playerid, 5, 150);
}
if(dini_Int(nomepl, "Arma") == 4){
GivePlayerWeapon(playerid, 2, 150);
}
if(dini_Int(nomepl, "Arma") == 5){
GivePlayerWeapon(playerid, 6, 150);
}
if(dini_Int(nomepl, "Arma") == 6){
GivePlayerWeapon(playerid, 7, 150);
}
if(dini_Int(nomepl, "Arma") == 7){
GivePlayerWeapon(playerid, 9, 150);
}
if(dini_Int(nomepl, "Hotel") == 1){
SetPlayerPos(playerid, 438.66622,-1971.4533691406,3.577997922897);
SetPlayerInterior(playerid, 0);
}
if(dini_Int(nomepl, "Preso") == 1){
SetPlayerPos(playerid, 264.4181,77.3247,1001.0391);                    
SetPlayerInterior(playerid, 6);
ResetPlayerWeapons(playerid);
SetPlayerHealth(playerid, 99999);
}
}


public OnPlayerPickUpPickup(playerid, pickupid)
{
if(pickupid == entrarpref)
{
GameTextForPlayer(playerid, "~h~~h~~p~Prefeitura", 5000, 8);
SetPlayerPos(playerid,385.4674,173.9319,1008.3828);
SetPlayerInterior(playerid, 3);
}
if(pickupid == sairpref)
{
SetPlayerPos(playerid,1481.1007,-1768.5459,18.7958);
SetPlayerInterior(playerid, 0);
}
/*new string[256];
for(new p = 0; p < MAX_CASAS; p++)
{
format(string, sizeof(string), "prop%d.ini", p);
if(dini_Exists(string)){
if(pickupid == dini_Int(string, "Id")){
new STRX[256];
if(dini_Int(string, "TDono") == 1){
format(STRX, sizeof(STRX), "Propriedade[%s] de: %s, Dinheiro nela: R$%d", dini_Get(string, "Nome"), dini_Get(string, "Dono"), dini_Int(string, "Grana"));
SendClientMessage(playerid, Azul, STRX);
} else {
format(STRX, sizeof(STRX), "Propriedade[%s] a venda, Valor de compra: R$%d, use /comprarprop", dini_Get(string, "Nome"), dini_Int(string, "Preco"));
SendClientMessage(playerid, Azul, STRX);
}
}
}
}
for(new c = 0; c < MAX_CASAS; c++)
{
format(string, sizeof(string), "casa%d.ini", c);
if(dini_Exists(string)){
if(pickupid == dini_Int(string, "Id")){
new STRX[256];
if(dini_Int(string, "TDono") == 1){
format(STRX, sizeof(STRX), "Dono da casa: %s, Pagou nela: R$%d", dini_Get(string, "Dono"), dini_Int(string, "Preco"));
SendClientMessage(playerid, Azul, STRX);
} else {
format(STRX, sizeof(STRX), "Casa a venda, Valor de compra: R$%d, use /comprarcasa", dini_Int(string, "Preco"));
SendClientMessage(playerid, Verde, STRX);
}
}
}
}    */
new STRX[256];
new string[256];
for(new p = 0; p < MAX_PROPS; p++)
{
format(string, sizeof(string), "prop%d.ini", p);
if(dini_Exists(string)){
if(pickupid == dini_Int(string, "Id")){
if(dini_Int(string, "TDono") == 1){
format(STRX, sizeof(STRX), "~b~]Propriedade]~n~~w~%s~n~~y~Dono:~w~%s~n~~y~Dinheiro:~w~R$%d~n~~r~/ajudaprop", dini_Get(string, "Nome"), dini_Get(string, "Dono"), dini_Int(string, "Grana"));
GameTextForPlayer(playerid, STRX, 10000, 5);
} else {
format(STRX, sizeof(STRX), "~g~]Propriedade]~n~~w~%s~n~~y~Dono:~w~Ninguem~n~~y~Valor:~w~R$%d~n~~g~/comprarprop~n~~r~/ajudaprop", dini_Get(string, "Nome"), dini_Int(string, "Preco"));
GameTextForPlayer(playerid, STRX, 10000, 5);
}
}
}
}
for(new c = 0; c < MAX_CASAS; c++)
{
format(string, sizeof(string), "casa%d.ini", c);
if(dini_Exists(string)){
if(pickupid == dini_Int(string, "Id")){
if(dini_Int(string, "TDono") == 1){
format(STRX, sizeof(STRX), "~b~]Casa]~n~~y~Dono:~w~%s~n~~r~ENTER", dini_Get(string, "Dono"));
GameTextForPlayer(playerid, STRX, 5000, 5);
//format(STRX, sizeof(STRX), "Dono da casa: %s, Pagou nela: R$%d", dini_Get(string, "Dono"), dini_Int(string, "Preco"));
//SendClientMessage(playerid, Azul, STRX);
} else {
//format(STRX, sizeof(STRX), "Casa a venda, Valor de compra: R$%d, use /comprarcasa", dini_Int(string, "Preco"));
//SendClientMessage(playerid, Verde, STRX);
format(STRX, sizeof(STRX), "~g~]Casa]~n~~y~Dono:~w~Ninguem~n~~y~Valor:~w~R$%d~n~~g~/comprarcasa~n~~r~ENTER", dini_Int(string, "Preco"));
GameTextForPlayer(playerid, STRX, 5000, 5);
}
}
}
}
if(pickupid ==pickupbanco) { // Pickup definido
GameTextForPlayer(playerid, "~r~Banco", 5000, 6);
SetPlayerInterior(playerid,10);
SetPlayerPos(playerid,246.552429,111.057975,1003.21875);
}
if(pickupid == pickupacademia) { // Pickup definido
GameTextForPlayer(playerid, "~r~Academia", 5000, 6);
SetPlayerInterior(playerid,6);
SetPlayerPos(playerid,774.6920,-47.6505,1000.5859);
}
if(pickupid == pickupacademia1) { // Pickup definido
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,1154.1013,-1768.5906,16.5938);
}
if(pickupid == EntradaPizzaria) { // Pickup definido
if(hora >= 6 && hora < 22){
GameTextForPlayer(playerid, "~r~Pizzaria", 5000, 6);
SetPlayerInterior(playerid,5);
SetPlayerPos(playerid,372.5565,-131.3607,1001.4922);
} else {
SendClientMessage(playerid, Vermelho, "A Pizzaria abre das 6 as 22 horas.");
}
}
if(pickupid == SaidaPizzaria) { // Pickup definido
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,2101.7786,-1806.3678,13.5547);
}
if(pickupid == EntradaAmmu) { // Pickup definido
if(hora >= 9 && hora < 23){
GameTextForPlayer(playerid, "~r~Ammu-nation", 5000, 6);
SetPlayerInterior(playerid,7);
SetPlayerPos(playerid,315.3442,-141.5688,999.6016);
} else {
SendClientMessage(playerid, Vermelho, "A Ammu-nation abre das 9 as 23 horas.");
}
}
if(pickupid == SaidaAmmu) { // Pickup definido
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,1365.5867,-1280.2438,13.5469);
}
if(pickupid == EntradaBurguer) { // Pickup definido
if(hora >= 6 && hora < 22){
GameTextForPlayer(playerid, "~r~Burguer Shot", 5000, 6);
SetPlayerInterior(playerid,10);
SetPlayerPos(playerid,364.8885,-73.5423,1001.5078);
} else {
SendClientMessage(playerid, Vermelho, "O Burguer Shot abre das 6 as 22 horas.");
}
}
if(pickupid == SaidaBurguer) { // Pickup definido
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,1199.7549,-921.1312,43.1025);
}
if(pickupid == EntradaBurguer2) { // Pickup definido
if(hora >= 6 && hora < 22){
GameTextForPlayer(playerid, "~r~Burguer Shot", 5000, 6);
SetPlayerInterior(playerid,10);
SetPlayerPos(playerid,364.8885,-73.5423,1001.5078);
SetPlayerVirtualWorld(playerid, 2);
} else {
SendClientMessage(playerid, Vermelho, "O Burguer Shot abre das 6 as 22 horas.");
}
}
if(pickupid == SaidaBurguer2) { // Pickup definido
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,813.7556,-1616.6449,13.5547);
SetPlayerVirtualWorld(playerid, 0);
}
if(pickupid == pickupbanco1) { // Pickup definido
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,1719.3339,-1738.7709,13.5469);
}
if(pickupid == Comprovante) { // Pickup definido
CreatePlayer3DTextLabel(playerid,"SACAR",Verde,355.8266,197.6798,1015.0875,500);
}
if(pickupid == Depositar1) { // Pickup definido
CreatePlayer3DTextLabel(playerid,"DEPOSITAR",Verde,349.9531,197.3023,1015.0875,500);
}
if(pickupid == Sacar1) { // Pickup definido
CreatePlayer3DTextLabel(playerid,"COMPROVANTE",Verde,361.6920,193.4469,1015.0875,500);
}
if(pickupid == pickuplane) { // Pickup definido
SendClientMessage(playerid, AZULBLUE , "Voçê Entrou na Lan House Diveita-se !!!");
SetPlayerPos(playerid,2130.6982421875,-1809.4261474609,670.55133056641);
}
if(pickupid == pickuplans) { // Pickup definido
SendClientMessage(playerid, AZULBLUE , "Voçê Saiu Da Lan House Volte Sempre !!!");
SetPlayerPos(playerid,2164.6201171875,-1799.3431396484,13.372232437134);
}
if(pickupid == Pickupagencia1) { // Pickup definido
SendClientMessage(playerid, AZULBLUE , "Você Entrou na Agencia de emprego Va Até O Check Para Pegar uma Profissão !");
SetPlayerInterior(playerid,3);
SetPlayerPos(playerid, 831.2233,7.2051,1004.1797);
}
if(pickupid == Pickupagencia) { // Pickup definido
SendClientMessage(playerid, AZULBLUE , "Você Saiu Da Agencia De emprego  !");
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,1788.0539550781,-1696.0172119141,13.482467651367);
}
if(pickupid == Pickupescola1) { // Pickup definido
SendClientMessage(playerid, AZULBLUE , "Você Saiu Da Auto Escola Obrigado Por Tirar Hab Conosco !");
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,1805.1411132813,-1719.0336914063,13.537221908569);
}
if(pickupid == Pickupescola) { // Pickup definido
SendClientMessage(playerid, AZULBLUE , "Você Entrou Da Auto Escola Va até o o icone e compre sua habilitção!");
SetPlayerInterior(playerid,3);
SetPlayerPos(playerid,-2029.1252,-117.2932,1035.1719);
}
if(pickupid == Pickuploja) { // Pickup definido
SendClientMessage(playerid, AZULBLUE , "Você entrou na Loja  !");
SetPlayerInterior(playerid,17);
SetPlayerPos(playerid,-25.5048,-185.9433,1003.5469);
}
if(pickupid == Pickuploja1) { // Pickup definido
SendClientMessage(playerid, AZULBLUE , "Você Saiu da Loja  !");
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,1351.3214,-1754.0997,13.3559);
}
if(pickupid == pickuplan1) { // Pickup definido
}
if(pickupid ==pickuplan2) { // Pickup definido
}
if(pickupid == pickuplan3) { // Pickup definido
}
if(pickupid == pickuplan4) { // Pickup definido
}
	return 1;
}

public OnPlayerConnect(playerid)
{
new nomepl[MAX_PLAYER_NAME];
//new string[256];
plon = plon+1; 
praga[playerid] = 0;
abastecendo[playerid] = 0;
secondies[playerid] = 0;
pAdmin[playerid] = 0;
    emteste[playerid] = 0;
    incar[playerid] = 0;
    amod[playerid] = 0;
    MinutisOn[playerid] = 0;
    gmod[playerid] = 0;
	cs1[playerid] = 0;
    nickn[playerid] = 0;
    cs2[playerid] = 0;
    cs3[playerid] = 0;
    cs4[playerid] = 0;
    podehab[playerid] = 0;        
    naarena[playerid] = 0;    
    namoto[playerid] = 0;

minutosafk[playerid] = 0;
sangui[playerid] = 100;
Voted[playerid] = 0;
tutorial[playerid] = 0;
dms[playerid] = 0;
mincalado[playerid] = 0;
flood[playerid] = 0;
tempoon[playerid] = 0;
convitefbi[playerid] = 0;
convitecv[playerid] = 0;
calado[playerid] = 0;
adminvisivel[playerid] = 0;
comjornal[playerid] = 0;
areadmp[playerid] = 0;
vcblock[playerid] = 0;
SetPlayerColor(playerid, Preto);
crblock[playerid] = 0;
Detido[playerid] = 0;
TextDrawShowForPlayer(playerid,text1);
TextDrawShowForPlayer(playerid,text2);
TextDrawShowForPlayer(playerid,text3);
TextDrawShowForPlayer(playerid,text4);
TextDrawShowForPlayer(playerid,text5);
TextDrawShowForPlayer(playerid,text6);


Textdraw0[playerid] = TextDrawCreate(8.000000, 200.000000, "Carregando");
TextDrawBackgroundColor(Textdraw0[playerid], 255);
TextDrawFont(Textdraw0[playerid], 1);
TextDrawLetterSize(Textdraw0[playerid], 0.489999, 2.099999);
TextDrawColor(Textdraw0[playerid], -1642517384);
TextDrawSetOutline(Textdraw0[playerid], 0);
TextDrawSetProportional(Textdraw0[playerid], 1);
TextDrawSetShadow(Textdraw0[playerid], 1);
TextDrawUseBox(Textdraw0[playerid], 1);
TextDrawBoxColor(Textdraw0[playerid], 0x000000AA); //-186
TextDrawTextSize(Textdraw0[playerid], 106.000000, 0.000000);
TextDrawHideForPlayer(playerid, Textdraw0[playerid]);
/*fominha[playerid] = TextDrawCreate(580, 180, "~w~Fome:~n~~r~0%");
TextDrawLetterSize(Text:fominha[playerid], 1, 0);
TextDrawTextSize(Text:fominha[playerid], 0, 0);
TextDrawAlignment(Text:fominha[playerid], 0);
TextDrawColor(Text:fominha[playerid], -1);
TextDrawUseBox(Text:fominha[playerid], 1);
TextDrawSetShadow(Text:fominha[playerid], 2);
TextDrawBoxColor(Text:fominha[playerid], 170);
TextDrawSetOutline(Text:fominha[playerid], 0);
TextDrawBackgroundColor(Text:fominha[playerid], 170);
TextDrawFont(Text:fominha[playerid], 1);
TextDrawSetProportional(Text:fominha[playerid], 1);
TextDrawHideForPlayer(playerid, fominha[playerid]);  */
Peixes[playerid] = 0;
GetPlayerName(playerid, nomepl, sizeof(nomepl));
if(strcmp(nomepl, "aux", true) == 0 || strcmp(nomepl, "con", true) == 0)
{
Kick(playerid);
}
//format(string,sizeof string,"%s(id:%d) entrou no Philips RPG.",nomepl,playerid);
//SendClientMessageToAll(Verde,string);
if(dini_Int(nomepl, "Banido") == 1){
new Ip[30];
GetPlayerIp(playerid, Ip, sizeof(Ip));
SendClientMessage(playerid, Vermelho, "VOCÊ ESTÁ BANIDO, entre em contato com um administrador.");
//format(string,sizeof string,"Philips RPG: %s(id:%d) foi BANIDO, MOTIVO: BAN EVADING.",nomepl,playerid);
dini_Set(nomepl, "Ip", Ip);
Ban(playerid);
//SendClientMessageToAll(Amarelo,string);
}
SetPlayerMapIcon(playerid, 8, 663.5419,-1897.6047,2.9629, 31, 0);//hotel
SendClientMessage(playerid, Azul, "Bem Vindo ao Philips RPG, aguarde para logar/registrar.");
SendClientMessage(playerid, Azul, "Carregando...");
//SetPlayerMapIcon(playerid, 4, 1937.0552,-2175.1611,13.3052, 52, 0);//banco
SetPlayerMapIcon(playerid, 70, 1815.9700,-1892.0165,13.1675, 42, 0);//agencia taxi
SetPlayerMapIcon(playerid, 29, 1719.6400,-1740.0034,13.5469, 52, 0); //icone banco
SetPlayerMapIcon(playerid, 28, 1350.8461,-1752.5222,13.3601, 58, 0); //icone loja
SetPlayerMapIcon(playerid, 20, 1723.3234,-1720.8914,13.5444, 42, 0); //icone telefone
SetPlayerMapIcon(playerid, 21, 1139.4012,-1761.3579,13.5950, 36, 0); //icone faculdade
SetPlayerMapIcon(playerid, 94, 2164.0520,-1799.6964,13.3726, 16, 0); //icone lan
SetPlayerMapIcon(playerid, 22, 1172.6731,-1323.1965,15.4022, 22, 0); //icone hospital
SetPlayerMapIcon(playerid, 23, 1804.8284,-1717.6776,13.5367, 55, 0); //icone HabLocal
SetPlayerMapIcon(playerid, 24, 1128.9546,-1461.7429,15.7969, 38, 0); //icone Shopping
SetPlayerMapIcon(playerid, 25, 1546.4675,-1676.2452,13.5624, 30, 0); //icone delegacia
SetPlayerMapIcon(playerid, 26, 1481.0590,-1770.1975,18.7958, 48, 0); //icone agencia
SetPlayerMapIcon(playerid, 40, 836.7571,-2065.4785,12.8672, 9, 0); //icone pescaria
SetPlayerMapIcon(playerid, 41, 387.0509,-1837.0605,7.8359, 50, 0); //icone venda pesca
SetPlayerMapIcon(playerid, 42, 1022.6270,-981.9053,42.6063, 23, 0); //icone local jornal
SetPlayerMapIcon(playerid, 43, 1360.9185,-1651.3649,13.3828, 18, 0); //icone area dm
SetPlayerMapIcon(playerid, 44, 1080.9312,-1698.0581,13.5469, 19, 0); //icone loja de defesas
SetPlayerMapIcon(playerid, 45, 1003.1738,-905.0977,42.8021, 43, 0); //icone carga
SetPlayerMapIcon(playerid, 46, 1655.6230,1624.9274,11.3729, 44, 0); //icone discarga
SetPlayerMapIcon(playerid, 47, 1534.510254,-1452.143799,15.165947, 27, 0); //icone base mecanico
SetPlayerMapIcon(playerid, 48, 1022.6270,-981.9053,42.6063, 23, 0); //icone base jornal
SetPlayerMapIcon(playerid, 49, 12232.818359,-2215.736084,15.320267, 30, 0); //icone fbi
SetPlayerMapIcon(playerid, 50, 1139.3826,-1761.7094,13.5953, 16, 0); //icone academia
afkm[playerid] = 0;
Pescando[playerid] = 0;
/*if(dini_Int(nomepl, "Calado") == 1){
calado[playerid] = 1;
mincalado[playerid] = 0;
}        */
//new skin;
//skin = dini_Get(nomepl, "Skin");
//SetSpawnInfo(playerid, 1, dini_Int(nomepl, "Skin"), dini_Int(nomepl, "CasaX"), dini_Int(nomepl, "CasaY"), dini_Int(nomepl, "CasaZ"), 354.1657, 0, 0, 0, 0, 0, 0);

TextDrawsShown[playerid] = false;
	VHSCreated[playerid] = false;
	LightRedHealthCreated[playerid] = false;
	LightYellowSpeedCreated[playerid] = false;
	
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
        new string[256];
        new playa[MAX_PLAYER_NAME];         
        plon = plon-1;
        GetPlayerName(playerid, playa,MAX_PLAYER_NAME);
        TextDrawHideForPlayer(playerid, Relogio);  
        TextDrawDestroy(Textdraw0[playerid]);
       // TextDrawDestroy(fominha[playerid]);
        SendoVotado[playerid] = 0;
        switch(reason)
        {
        case 0: format(string,sizeof string,"%s(ID:%d) Saiu do Philips RPG. (Conexão)",playa, playerid);
        case 1: format(string,sizeof string,"%s(ID:%d) Saiu do Philips RPG. (Vontade Própria)",playa, playerid);
        case 2: format(string,sizeof string,"%s(ID:%d) Saiu do Philips RPG. (Kickado/Banido)",playa, playerid);
        }
        if(Logado[playerid] == 1){
        SendClientMessageToAll(Vermelho,string);         
        new Float:X, Float:Y, Float:Z;        
        GetPlayerPos(playerid, X, Y, Z);
        dini_IntSet(playa, "Procurado", GetPlayerWantedLevel(playerid));
        if(dini_Int(playa, "Casa") == 0 && GetPlayerInterior(playerid) == 0){        
        dini_FloatSet(playa,"CasaX",Float:X);
        dini_FloatSet(playa,"CasaY",Float:Y);
        dini_FloatSet(playa,"CasaZ",Float:Z);
        }
        dini_IntSet(playa, "Admin", pAdmin[playerid]);
        if(naarena[playerid] == 1){
        DestroyVehicle(namoto[playerid]);
        }        
        if(emteste[playerid] == 1){ 
        DestroyVehicle(nocarro[playerid]);       
        }
        }       
        if 	(IsTowTrucker[playerid]==1)
	    {
	    IsTowTrucker[playerid]=0;
	    TowTruckers--;
	    }     
       if(IsPlayerInAnyVehicle(playerid)){   
            new vid;
            vid = GetPlayerVehicleID(playerid);  
            Trancado[vid] = 0;
            TrancadoPara[vid] = 0;       
            }
        if(Logado[playerid] == 1){
		Logado[playerid] = 0;
        new grana;        
        grana = GetPlayerPCash(playerid);
        dini_IntSet(playa, "Dinheiro", grana);        
        ResetPlayerPCash(playerid);
        minutos[playerid] = 0;
        Conversa[playerid] = 0;   
        Voted[playerid] = 0;     
        NaFaculdade[playerid] = 0;         
        AreaPosto[playerid] = 0;
        }        
        if(calado[playerid] == 1){ 
        dini_Set(playa, "Calado", "1");       
        }
        return 1;
}   

public OnPlayerCommandText(playerid, cmdtext[])
{
new specplayerid;

	for(new i=0; i<MAX_PLAYERS; i++)
{
new playa[MAX_PLAYER_NAME];
GetPlayerName(playerid, playa,MAX_PLAYER_NAME);
if(pAdmin[i] >= 1)
{
new stringcmd[256];
//new playa[MAX_PLAYER_NAME];
//GetPlayerName(playerid, playa,MAX_PLAYER_NAME);
format(stringcmd, 256, "[IAdmin]O player %s(id:%d) digitou o comando %s", playa,playerid,cmdtext);
SendClientMessage(i,Violeta, stringcmd);
}
}
minutosafk[playerid] = 0;

	    new cmd[256];    
	    new string[256];
       // new index;    
	    new idx;
		cmd = strtok(cmdtext, idx);
        new giveplayerid;
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    new nomepp[MAX_PLAYER_NAME];    
    GetPlayerName(playerid, nomepp, MAX_PLAYER_NAME);
if(NaFaculdade[playerid] == 0 && calado[playerid] == 0 && dini_Int(nomepp, "Preso") == 0){

if(strcmp(cmd, "/votekick", true) == 0)
    { 
          new tmp[256];    
        
    if(Wait[playerid] == 1) return SendClientMessage(playerid, RED, "Por favor, aguarde 60 segundos antes de votar novamente");    
         PlayerCount = 0;
         for (new i = 0; i < GetMaxPlayers(); i++)
        {         
            if(IsPlayerConnected(i))
            {
            	PlayerCount = PlayerCount+1;
            }
        }
        if(plon <= 3)
		{
			SendClientMessage(playerid, RED, "ERROR: Deve ter mais de 3 jogadores online para iniciar uma votação de kick");
			return 1;
		}      
    	new reason[256];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, ORANGE, "USE: /votekick [Id] [motivo]");
			return 1;
		}
		if(VoteKick == 1)
		{
			SendClientMessage(playerid, RED, "ERROR: Há uma votação em andamento, por favor aguarde");
			return 1;
		}
		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
	    	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(reason) - 1)))
			{
				reason[idx - offset] = cmdtext[idx];
				idx++;
			}
			reason[idx - offset] = EOS;
			if(!strlen(reason))
			{
				SendClientMessage(playerid, ORANGE, "USE: /votekick [Id] [motivo]");
				return 1;
			}
			else
			{

				format(string, sizeof(string), "[Philips RPG]: Jogador %s iniciou um votekick em %s. [motivo: %s] - %d segundos restantes.", Name(playerid), Name(giveplayerid), reason, VOTETIME / 1000);
				print(string);
				SendClientMessageToAll(YELLOW, string);
				SendClientMessageToAll(YELLOW, "Se você quer que este jogador seja kickado. Use /votar");
				Votes = 1;
				SetTimerEx("VoteTimer", VOTETIME, 0, "i", giveplayerid);
				VoteKick = 1;
                SendoVotado[giveplayerid] = 1;
				Voted[playerid] = 1;
				Wait[playerid] = 1;
				SetTimerEx("WaitT", WAIT_TIME, 0, "d", playerid);
			}
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d não é um jogador ativo.", giveplayerid);
			SendClientMessage(playerid, RED, string);
		}
		return 1;
	} 



  /*  if(strcmp(cmd, "/votar", true) == 0)
	{
	    if(Voted[playerid] == 1)
	    {
			SendClientMessage(playerid, RED, "Você já votou!");
		}
		else
		{
		  //  Voted[playerid] = 1;
		   // Votes++;
		    //format(string, sizeof(string), "%s votou (%d/%d)", Name(playerid), Votes, (PlayerCount /= 2)+1);
		   // SendClientMessageToAll(YELLOW, string);
		}
  }
	}      */

if (strcmp(cmdtext,"/votar", true)==0){
if(Voted[playerid] == 1)
{
SendClientMessage(playerid, RED, "Você já votou!");
return 1;
} else {
PlayerCount = 0;
for (new i = 0; i < GetMaxPlayers(); i++)
{
if(IsPlayerConnected(i))
{
PlayerCount = PlayerCount+1;
}
}
if(VoteKick == 1){       
new pleyers;
pleyers = plon;
pleyers /= 2;
pleyers = pleyers+1;
Voted[playerid] = 1;
Votes++;
format(string, sizeof(string), "[Philips RPG]%s votou (%d/%d)", Name(playerid), Votes, pleyers);
SendClientMessageToAll(YELLOW, string);
return 1;
} else {
SendClientMessage(playerid, Vermelho, "Não existe votação em andamento");
}
}
}
if(strcmp(cmdtext, "/controlefbi", true) == 0)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);    
if(dini_Int(aname, "Profissao") == FBI || pAdmin[playerid] >= 3){
TogglePlayerControllable(playerid,false);
ShowMenuForPlayer(controle_ilha, playerid);
return 1;
}
}
if (strcmp(cmdtext,"/acr", true)==0){
if(pAdmin[playerid] >= 5) {
MoveObject(cm , 318.48477172852, -1190.3775634766, 75.399711608887, 3.0);
SendClientMessage(playerid,0x0050F6AA, "Portão Da Casa Do Admin ReTuRnS Aberto !");
return 1;
}
}
if (strcmp(cmdtext,"/fcr", true)==0){
   if(pAdmin[playerid] >= 5) {
MoveObject(cm , 323.88812255859, -1186.2302246094, 75.399711608887, 3.0);
SendClientMessage(playerid,0x0050F6AA, "Portão Da Casa Do Admin ReTuRnS Fechado !");
return 1;
}
}
if (strcmp(cmdtext,"/abrirhotel", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);      
if(dini_Int(aname, "Hotel") == 1){
MoveObject(hott , 666.91223144531, -1908.8677978516, -1.4638714790344, 4.0);
MoveObject(hott2 , 686.42858886719, -1909.5538330078, -1.4638714790344, 4.0);
SendClientMessage(playerid,0x0050F6AA, "Hotel Aberto!");
return 1;
}
}
if (strcmp(cmdtext,"/fecharhotel", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);    
if(dini_Int(aname, "Hotel")== 1){
MoveObject(hott ,  666.91223144531, -1908.8677978516, 4.6584520339966, 4.0);
MoveObject(hott2, 686.42858886719, -1909.5538330078, 4.4638714790344, 4.0);
SendClientMessage(playerid,0x0050F6AA, "Hotel Fechado !");
return 1;
}
}
if (strcmp(cmdtext,"/ag", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);    
if(dini_Int(aname, "Hotel")== 1){
MoveObject(ho , 610.76342773438, -2003.1768798828, -1.1717176437378, 4.0);
MoveObject(ho2 , 610.77551269531, -1991.6096191406, -1.1717176437378, 4.0);
SendClientMessage(playerid,0x0050F6AA, "Garege Do Hotel Aberta!");
return 1;
}
}
if (strcmp(cmdtext,"/fg", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);    
if(dini_Int(aname, "Hotel")== 1){
MoveObject(ho , 610.76342773438, -2003.1768798828, 5.1717176437378, 4.0);
MoveObject(ho2 , 610.77551269531, -1991.6096191406, 5.2127165794373, 4.0);
SendClientMessage(playerid,0x0050F6AA, "Garage Do Hotel Fechada !");
return 1;
}
}
/*if(strcmp(cmd, "/emprestimo", true) == 0) {
new str[256];
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);   
format(str, sizeof(str), "Ola Jogador %s\nSeu Id No Jogo É:%d\nemprestimo é assim\nPrimeiro Plano 25 mil Reias Você vai pagar 25 meses de emprestimo\nSegundo Plano 45 mil Reias Você vai pagar 45 meses de emprestimo\nTerceiro Plano 60 mil Reias Você vai pagar 60 meses de emprestimo",aname,playerid);
ShowPlayerDialog(playerid, 88788, DIALOG_STYLE_MSGBOX, "Philips RPG FINACIAMENTO",str,"Sair","Sair");
return 1;
}    */
if(strcmp(cmd, "/hotel", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);   
new str[256];
format(str, sizeof(str), "Ola Jogador %s\nSeu Id No Jogo É:%d\nPara Quem mora no hotel\nVamos Lá \n/abrirhotel para abrir o hotel /fecharhotel para fechalo\n/ag para abrir a garege do hotel /fg para fechala\nObrigado por morar aqui.",aname,playerid);
ShowPlayerDialog(playerid, 88788, DIALOG_STYLE_MSGBOX, "Philips RPG HOTEL",str,"Sair","Sair");
return 1;
}     
  
if(strcmp(cmd, "/setcar", true) == 0) {
		new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
        if(pAdmin[playerid] >= 4){
			new tmp[256];
			new carid, Float:ang, nome[256], cor1[256], cor2;

			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)){
				SendClientMessage(playerid, Cinza, "~ IErro: ID fora do normal | ID's = 400-611");
				return 1;
			}
		    carid = strval(tmp);

    	    tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, Cinza, "~ IErro: /setcar [id] [Dono] [cor1] [cor2]");
				return 1;
			}
			set(nome, tmp);

    	    tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, Cinza, "~ IErro: /setcar [id] [Dono] [cor1] [cor2]");
				return 1;
			}
			set(cor1,tmp);

    	    tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, Cinza, "~ IErro: /setcar [id] [Dono] [cor1] [cor2]");
				return 1;
			}
			cor2 = strval(tmp);
			if(carid >= 400 && carid <= 611){
			    if(IsPlayerInAnyVehicle(playerid)){
			        if(IsNumeric(cor1)){
				        new File:temp;
				        new Float:X, Float:Y, Float:Z;
						GetPlayerPos(playerid, X, Y, Z);
						GetVehicleZAngle(GetPlayerVehicleID(playerid),ang);
						format(string, sizeof(string), "%d %f %f %f %f %s %d //%s\r\n", carid, X, Y, Z, ang, cor1, cor2, nome);
						temp = fopen("Carros.cfg", io_append);
    	                fwrite(temp, string);
        	            fclose(temp);
                     	SetTimerEx("CriarVeiculo",5000,false,"dffffdd",carid,X,Y,Z,ang,strval(cor1),cor2);                     
                        format(string, sizeof(string), "Vendedor %s(id:%d) você setou o carro de id %d.", aname, playerid, carid);
                        SendClientMessage(playerid, Azul, string);
						return 1;
			        } else {
					    SendClientMessage(playerid,Cinza,"~ IErro: /setcar [id] [local] [cor1] [cor2]");
					    return 1;
			        }
				}
				else{
				    SendClientMessage(playerid, Cinza, "~ IErro: Você não está em nenhum veículo e assim não pode setar um carro.");
					return 1;
				}
			}
			else{
				SendClientMessage(playerid, Cinza, "~ IErro: ID fora do normal | ID's = 400-611");
				return 1;
			}
		} else {
			SendClientMessage(playerid, Cinza, "~ IErro: Você não tem permissão para isso");
			return 1;
		}
	}

    

if(strcmp(cmdtext, "/abastecer", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(AreaPosto[playerid] == 1){
format(string, sizeof(string), "Aguarde, estámos abastecendo seu carro/galil de gasolina...");
SendClientMessage(playerid, Azul, string);
abastecendo[playerid] = 1;
TogglePlayerControllable(playerid, 0);
return 1;
} else {
SendClientMessage(playerid, Vermelho, "Você não está em um posto");
return 1;
}
}


if(strcmp("/telefonar", cmd, true) == 0)
	{
        new tmp[256];        
        new Mensagem[256];        
        new Message[256];        
        new pName[MAX_PLAYER_NAME+1];
    	new iName[MAX_PLAYER_NAME+1];
		tmp = strtok(cmdtext,idx);

		if(!strlen(tmp) || strlen(tmp) > 13) {
			SendClientMessage(playerid,Vermelho,"Use: /telefonar (id) (mensagem)");
			return 1;
		}

		new id = strval(tmp);
        //Mensagem = strmid(cmdtext,idx);        
        strmid(Mensagem, cmdtext, 13, strlen(cmdtext));
		if(!strlen(Mensagem)) {
			SendClientMessage(playerid,Vermelho,"Use: /telefonar (id) (mensagem)");
			return 1;
		}

		if(IsPlayerConnected(id) == 0) {
			SendClientMessage(playerid,Vermelho,"ID de player invalido");
			return 1;
		} else {
        new check;
        check = CPS_GetPlayerCheckpoint(playerid);        
        new checkp;
        checkp = CPS_GetPlayerCheckpoint(id);
        GetPlayerName(id,iName,sizeof(iName));
		GetPlayerName(playerid,pName,sizeof(pName)); 
        if(strfind(Mensagem,"64.191.47.197",true) != -1) 
         {   
            new pname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
        SendClientMessage(playerid, COLOR_RED, "[Philips RPG]Nada de divulgar outros servers aqui !"); 
        format(string, sizeof(string), "[Philips-Bot]%s(id:%d) foi banido por divulgar outro servidor.", Conversa[playerid]);   
         Ban(playerid);
         SendClientMessageToAll(Amarelo, string);    
        return 1; 
          }           
          if(strfind(Mensagem,";",true) != -1 || strfind(Mensagem,":",true) != -1)
   {   
   SendClientMessage(playerid, COLOR_RED, "[Philips RPG]Não use 2 PONTOS(:) ou PONTO E VIRGULA(;).");
   return 1; 
   } else {
		if(check == Telefone) {
        if(dini_Int(pName, "CartaoTelefonico") > 0){
        if(checkp == Telefone){
			format(Message,sizeof(Message)," Você disse a %s(%d): %s",iName,id,Mensagem);
			SendClientMessage(playerid,Verde,Message);
			format(Message,sizeof(Message)," Ligação de %s(%d): %s",pName,playerid,Mensagem);
			SendClientMessage(id,Verde,Message);
            dini_IntSet(pName, "CartaoTelefonico", dini_Int(pName, "CartaoTelefonico")-1);
            } else {
            if(celigado[id] == 1){
            format(Message,sizeof(Message)," Você disse a %s(%d): %s",iName,id,Mensagem);
			SendClientMessage(playerid,Verde,Message);
			format(Message,sizeof(Message)," Ligação de %s(%d): %s",pName,playerid,Mensagem);
			SendClientMessage(id,Verde,Message);            
            } else {
			SendClientMessage(playerid,Vermelho,"O player não está com o celular ligado.");
            }
            }            
            } else {            
            SendClientMessage(playerid,Vermelho,"Você não tem Créditos no cartão para fazer esta ligação.");            
            }
		} else {
            if(celigado[playerid] == 1){
            if(checkp == Telefone){
            format(Message,sizeof(Message)," Você disse a %s(%d): %s",iName,id,Mensagem);
			SendClientMessage(playerid,Verde,Message);
			format(Message,sizeof(Message)," Ligação de %s(%d): %s",pName,playerid,Mensagem);
			SendClientMessage(id,Verde,Message); 
            } else {            
            if(celigado[id] == 1){
            format(Message,sizeof(Message)," Você disse a %s(%d): %s",iName,id,Mensagem);
			SendClientMessage(playerid,Verde,Message);
			format(Message,sizeof(Message)," Ligação de %s(%d): %s",pName,playerid,Mensagem);
			SendClientMessage(id,Verde,Message);            
            } else {
            SendClientMessage(playerid,Vermelho,"Ele não está com o celular ligado.");
            }            
            }           
            } else {
			SendClientMessage(playerid,Vermelho,"Seu celular não está ligado, /ligarcelular.");
            }              
            }
		    }
            }
		return 1;
	        }


if(strcmp(cmdtext, "/tunarcarro", true) == 0) {
if(pAdmin[playerid] >= 3){
new VehicleID;
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Admin %s(id:%d) você tunou seu carro.", aname, playerid);
SendClientMessage(playerid, Azul, string);
VehicleID = GetPlayerVehicleID(playerid);
ChangeVehiclePaintjob(VehicleID,0);
AddVehicleComponent(VehicleID, 1087);
AddVehicleComponent(VehicleID, 1074);
AddVehicleComponent(VehicleID, 1010);
}
return 1;
}
if(strcmp(cmdtext, "/aon", true) == 0) {
if(pAdmin[playerid] >= 4){
SendClientMessage(playerid, Azul, "Admin mode ON, teclas: ENTER SPACE ALT.");
amod[playerid] = 1;
}
return 1;
}
if(strcmp(cmdtext, "/aoff", true) == 0) {
if(pAdmin[playerid] >= 4){
SendClientMessage(playerid, Azul, "Admin mode OFF.");
amod[playerid] = 0;
}
return 1;
}
if(strcmp(cmdtext, "/hora", true) == 0) {
new Hour, Minute, Second;
gettime(Hour, Minute, Second);
format(string, sizeof(string), "São %d horas, %d minutos e %d segundos.", Hour, Minute, Second);
SendClientMessage(playerid, Azul, string);
return 1;
}
if(strcmp(cmdtext, "/meustatus", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Nível: %d(%d/5 exp)\n Profissao: %s \nFaculdade: %d meses \nCréditos cartão telefonico: %d\nCelular(s)%d \nFama %d.\nExpulsão fora da sala %d/60\nPontos na carteira:%d", dini_Int(aname, "Nivel"), dini_Int(aname, "Experiencia"), Prof[dini_Int(aname, "Profissao")], dini_Int(aname, "Faculdade"), dini_Int(aname, "CartaoTelefonico"), dini_Int(aname, "Celular"), dini_Int(aname, "Fama"),dini_Int(aname, "expulso"),dini_Int(aname, "pontoshab"));
ShowPlayerDialog(playerid, 869, DIALOG_STYLE_MSGBOX, "Meu Status", string, "Ok", "Fechar");
return 1;
}

    if(strcmp(cmdtext, "/aprender", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
new grana;
grana = GetPlayerPCash(playerid);
if(check == Faculdade){
if(grana > 699){
if(hora == 12 && minutoss >= 30){
//SetPlayerPos(playerid,359.0746,203.4659,1008.3828);
SetPlayerPos(playerid,1494.325195,1304.942871,1093.289062);
ResetPlayerWeapons(playerid);
//SetPlayerInterior(playerid, 3);
SetPlayerInterior(playerid, 3); 
GivePlayerPCash(playerid, -700);
SendClientMessage(playerid, Verde,"Durante 5 Horas você vai ficar aprendendo.");
NaFaculdade[playerid] = 1;
minutos[playerid] = 0;
Conversa[playerid] = 0;
SetPlayerHealth(playerid, 999999);
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
PlayerPlaySound(playerid,1076,X,Y,Z);
} else {
SendClientMessage(playerid, Vermelho,"A Faculdade abre das 12:30 as 13:00.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não tem 700 reais.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na faculdade.");
}
return 1;
}

if(strcmp(cmdtext, "/rebocar", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == Reboque){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == Mecanico){
if(IsPlayerInAnyVehicle(playerid)){
SendClientMessage(playerid, Verde,"Obrigado por ajudar a manter os carros organizados.");
SetVehicleToRespawn(GetPlayerVehicleID(playerid));
} else {
SendClientMessage(playerid, Vermelho,"Você não éstá em um carro.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não é mecânico.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está no reboque(fica na base dos mecânicos).");
}
return 1;
}

if(strcmp(cmdtext, "/comandosmp3", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "MP3") == 1){
ShowPlayerDialog(playerid, 871, DIALOG_STYLE_MSGBOX, "Comandos MP3", "/play: Começa a tocar. \n/stop: Para de tocar.", "Ok", "Fechar");
//SendClientMessage(playerid, Verde,"Digite /play para começar e /stop para parar.");
} else {
SendClientMessage(playerid, Vermelho,"Você não tem um mp3 para usar seu manual.");
}
return 1;
}

if(strcmp(cmdtext, "/ajudaprop", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
ShowPlayerDialog(playerid, 871, DIALOG_STYLE_MSGBOX, "Ajuda de Propriedade", "/comprarprop: Compra uma propriedade. \n/venderprop: Vende uma propriedade. \n/sacarprop(Dono): Pega o dinhero da propriedade. \n/propnm [nome](Dono): Muda o nome da sua prop.", "Ok", "Fechar");
//SendClientMessage(playerid, Verde,"Digite /play para começar e /stop para parar.");}
return 1;
}

if(strcmp(cmdtext, "/ajudacasa", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
ShowPlayerDialog(playerid, 871, DIALOG_STYLE_MSGBOX, "Ajuda de Casa", "/comprarcasa: Compra uma casa. \n/vendercasa: Vende uma casa. \nENTER: Entra ou sai de casa \nALT(Dono): Tranca/Destranca casa.", "Ok", "Fechar");
//SendClientMessage(playerid, Verde,"Digite /play para começar e /stop para parar.");}
return 1;
}

if(strcmp(cmdtext,"/comandosvip", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Vip") > 0){
format(string, sizeof(string), "Comandos VIP\n/kit: Pega um kit VIP.\n/vc: Cura vida e colete.",aname,playerid);
ShowPlayerDialog(playerid, 871, DIALOG_STYLE_MSGBOX, "|___Philips VIP___|", string, "Ok", "Fechar");
return 1;
}
}

if(strcmp(cmdtext,"/meuvip", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Vip") > 0){
format(string, sizeof(string), "Pegar Kit Vip.\nPegar vida e colete.\nAcessar Banco.\nAcessar profissões.",aname,playerid);
ShowPlayerDialog(playerid, 4755, DIALOG_STYLE_LIST, "|___Philips VIP___|", string, "Ok", "Fechar");
return 1;
}
}

if (strcmp(cmdtext,"/vc", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Vip") > 0){
if(vcblock[playerid] == 0){
SetPlayerHealth(playerid, 100);
SetPlayerArmour(playerid, 100);
vcblock[playerid] = 1;
SendClientMessage(playerid,Verde, "Você pegou colete e vida.");
return 1;
} else {
SendClientMessage(playerid,Vermelho, "Aguarde 5 minutos para usar este comando novamente.");
return 1; 
}
}
}

if (strcmp(cmdtext,"/kit", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Vip") > 0){
if(kitblock[playerid] == 0){
GivePlayerWeapon(playerid, 34, 99999);
GivePlayerWeapon(playerid, 24, 99999);
GivePlayerWeapon(playerid, 30, 99999);
GivePlayerWeapon(playerid, 25, 99999);
GivePlayerWeapon(playerid, 28, 99999);
GivePlayerWeapon(playerid, 39, 99999);
GivePlayerWeapon(playerid, 40, 99999);
GivePlayerWeapon(playerid, 46, 99999);
GivePlayerWeapon(playerid, 41, 99999);
GivePlayerWeapon(playerid, 14, 99999);
GivePlayerWeapon(playerid, 1, 99999);
GivePlayerWeapon(playerid, 43, 99999);
kitblock[playerid] = 1;
SendClientMessage(playerid,Verde, "Você pegou kit vip.");
return 1;
} else {
SendClientMessage(playerid,Vermelho, "Aguarde 5 minutos para usar este comando novamente.");
return 1; 
}
}
}
if(strcmp(cmdtext, "/tunar", true) == 0)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == Mecanico || pAdmin[playerid] >= 3){
TogglePlayerControllable(playerid,0);
ShowMenuForPlayer(Tunar, playerid);
return 1;
}
}
if (strcmp(cmdtext,"/ad", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == Guarda || dini_Int(aname, "Profissao") == Policial_R || dini_Int(aname, "Profissao") == Policial_M || dini_Int(aname, "Profissao") == Policial_C || dini_Int(aname, "Profissao") == Policial_F || dini_Int(aname, "Profissao") == Delegado || dini_Int(aname, "Profissao") == Bope || dini_Int(aname, "Profissao") == Swat || dini_Int(aname, "Profissao") == Narcoticos || pAdmin[playerid] >= 3){
MoveObject (portaodp,1552.437988, -1627.392578, 9.702465, 3.0);
SendClientMessage(playerid,0x0000FFAA, "Abrindo...");
return 1;
}
}
if (strcmp(cmdtext,"/abrirfbi", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == FBI || pAdmin[playerid] >= 3){
MoveObject(portaofbi, 2232.810359, -2215.736084, 9.822554, 3.0);
SendClientMessage(playerid,0x0000FFAA, "Abrindo...");
return 1;
}
}
if (strcmp(cmdtext,"/fecharfbi", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == FBI || pAdmin[playerid] >= 3){
MoveObject(portaofbi, 2232.818359, -2215.736084, 15.320267, 3.0);
SendClientMessage(playerid,0x0000FFAA, "Fechando...");
return 1;
}
}
if (strcmp(cmdtext,"/abrircv", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == ComandoVermelho || pAdmin[playerid] >= 3){
MoveObject(portaocv,2423.698242, -2089.869873, 9.869022, 3.0);
SendClientMessage(playerid,0x0000FFAA, "Abrindo...");
return 1;
}
}
if (strcmp(cmdtext,"/fecharcv", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == ComandoVermelho || pAdmin[playerid] >= 3){
MoveObject(portaocv, 2423.698242, -2089.869873, 15.317423, 3.0);
SendClientMessage(playerid,0x0000FFAA, "Fechando...");
return 1;
}
}
if (strcmp(cmdtext,"/fd", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == Guarda || dini_Int(aname, "Profissao") == Policial_R || dini_Int(aname, "Profissao") == Policial_M || dini_Int(aname, "Profissao") == Policial_C || dini_Int(aname, "Profissao") == Policial_F || dini_Int(aname, "Profissao") == Delegado || dini_Int(aname, "Profissao") == Bope || dini_Int(aname, "Profissao") == Swat || dini_Int(aname, "Profissao") == Narcoticos || pAdmin[playerid] >= 3){
MoveObject (portaodp,1552.437988, -1627.392578, 15.156204, 3.0);
SendClientMessage(playerid,0x0000FFAA, "Fechando...");
return 1;
}
}
if (strcmp(cmdtext,"/aj", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == Jornalista || dini_Int(aname, "Profissao") == Fotografo || dini_Int(aname, "Profissao") == Reporter || dini_Int(aname, "Profissao") == Ancora || dini_Int(aname, "Profissao") == Meteorologista || pAdmin[playerid] >= 3){
MoveObject (portaoj,777.568481, -1329.843750, 9.899357, 3.0);
SendClientMessage(playerid,0x0000FFAA, "Abrindo...");
return 1;
}
}
if (strcmp(cmdtext,"/fj", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == Jornalista || dini_Int(aname, "Profissao") == Fotografo || dini_Int(aname, "Profissao") == Reporter || dini_Int(aname, "Profissao") == Ancora || dini_Int(aname, "Profissao") == Meteorologista || pAdmin[playerid] >= 3){
MoveObject (portaoj,777.568481, -1329.843750, 15.320265, 3.0);
SendClientMessage(playerid,0x0000FFAA, "Fechando...");
return 1;
}
}

if (strcmp(cmdtext,"/am", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == Mecanico || pAdmin[playerid] >= 3){
MoveObject (portaom,1535.336426, -1452.098389, 9.739429, 3.0);
SendClientMessage(playerid,0x0000FFAA, "Abrindo...");
return 1;
}
}
if (strcmp(cmdtext,"/fm", true)==0){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == Mecanico || pAdmin[playerid] >= 3){
MoveObject(portaom,1535.336426, -1452.098389, 15.165947, 3.0);
SendClientMessage(playerid,0x0000FFAA, "Fechando...");
return 1;
}
}

if (strcmp(cmdtext,"/ft", true)==0){
    new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	 
   if(dini_Int(aname, "Profissao") == Taxista || pAdmin[playerid] >= 3){
MoveObject(TAXISTAS , 1811.6870117188, -1886.5489501953, 15.181365966797, 3.0);
SendClientMessage(playerid,0x0050F6AA, "Portão Da Agencia Taxista Fechado !");
return 1;
}
}
if (strcmp(cmdtext,"/at", true)==0){
   new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	 
   if(dini_Int(aname, "Profissao") == Taxista || pAdmin[playerid] >= 3){
MoveObject(TAXISTAS , 1811.6870117188, -1886.5489501953, 9.61365966797, 3.0);
SendClientMessage(playerid,0x0050F6AA, "Portão Da Agencia Taxista Aberto !");
return 1;
}
}

if(strcmp(cmd, "/pegararmas", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(dini_Int(aname, "Profissao") == Guarda || dini_Int(aname, "Profissao") == Policial_R || dini_Int(aname, "Profissao") == Policial_M || dini_Int(aname, "Profissao") == Policial_C || dini_Int(aname, "Profissao") == Policial_F || dini_Int(aname, "Profissao") == Delegado || dini_Int(aname, "Profissao") == Bope || dini_Int(aname, "Profissao") == Swat || dini_Int(aname, "Profissao") == Narcoticos || dini_Int(aname, "Profissao") == FBI || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/pegararmas [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
            new distancia;
	    	distancia = GetDistanceBetweenPlayers(plid, playerid);
			    if(distancia > 10){
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}
                if(IsPlayerInAnyVehicle(plid) == 1 || IsPlayerInAnyVehicle(playerid) == 1){
                SendClientMessage(playerid, Azul, "Alguem está dentro de um carro...");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
					format(string, sizeof(string), "O policial %s apreendeu suas armas.", aname);
					SendClientMessage(plid, Vermelho, string);
                    ResetPlayerWeapons(plid);
				    SendClientMessage(playerid, COLOR_GREEN, "Armas Apreendidas");
			    	return 1;
                    }    
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}

    if(strcmp(cmd, "/deter", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(dini_Int(aname, "Profissao") == Guarda || dini_Int(aname, "Profissao") == Policial_R || dini_Int(aname, "Profissao") == Policial_M || dini_Int(aname, "Profissao") == Policial_C || dini_Int(aname, "Profissao") == Policial_F || dini_Int(aname, "Profissao") == Delegado || dini_Int(aname, "Profissao") == Bope || dini_Int(aname, "Profissao") == Swat || dini_Int(aname, "Profissao") == Narcoticos || dini_Int(aname, "Profissao") == FBI || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/deter [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
                new distancia;
	    	distancia = GetDistanceBetweenPlayers(plid, playerid);
			    if(distancia > 10){
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}
                if(IsPlayerInAnyVehicle(plid) == 1 || IsPlayerInAnyVehicle(playerid) == 1){
                SendClientMessage(playerid, Azul, "Alguem está dentro de um carro...");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
					format(string, sizeof(string), "O policial %s te deteu você pode fugir, usando /fugir.", aname);
					SendClientMessage(plid, Vermelho, string);
                    SetPlayerSpecialAction(plid, 10);
				    SendClientMessage(playerid, COLOR_GREEN, "Detido ! Para liberar use /liberar [id]");    
                    Detido[plid] = 1;
			    	return 1;
                    }    
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}

    if(strcmp(cmd, "/liberar", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(dini_Int(aname, "Profissao") == Guarda || dini_Int(aname, "Profissao") == Policial_R || dini_Int(aname, "Profissao") == Policial_M || dini_Int(aname, "Profissao") == Policial_C || dini_Int(aname, "Profissao") == Policial_F || dini_Int(aname, "Profissao") == Delegado || dini_Int(aname, "Profissao") == Bope || dini_Int(aname, "Profissao") == Swat || dini_Int(aname, "Profissao") == Narcoticos || dini_Int(aname, "Profissao") == FBI || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/liberar [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
   new distancia;
	    	distancia = GetDistanceBetweenPlayers(plid, playerid);
			    if(distancia > 10){
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}
                 if(Detido[plid] == 0){
			        SendClientMessage(playerid, COLOR_RED, "O player não foi detido.");
			    	return 1;
				}
                if(IsPlayerInAnyVehicle(plid) == 1 || IsPlayerInAnyVehicle(playerid) == 1){
                SendClientMessage(playerid, Azul, "Alguem está dentro de um carro...");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
					format(string, sizeof(string), "O policial %s te liberou.", aname);
					SendClientMessage(plid, Vermelho, string);
                    SetPlayerSpecialAction(plid, 0);
                    new Float:X, Float:Y, Float:Z;                      
                    GetPlayerPos(plid, X,Y,Z);
                    SetPlayerPos(plid, X,Y,Z);
                    celigado[plid] = 0;
				    SendClientMessage(playerid, COLOR_GREEN, "Liberado !");
			    	return 1;
                    }    
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}

if(strcmp(cmd, "/algemar", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(dini_Int(aname, "Profissao") == Policial_M || dini_Int(aname, "Profissao") == Policial_C || dini_Int(aname, "Profissao") == Policial_F || dini_Int(aname, "Profissao") == Delegado || dini_Int(aname, "Profissao") == Bope || dini_Int(aname, "Profissao") == Swat || dini_Int(aname, "Profissao") == Narcoticos || dini_Int(aname, "Profissao") == FBI || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/algemar [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
   new distancia;
	    	distancia = GetDistanceBetweenPlayers(plid, playerid);
			    if(distancia > 10){
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}
                if(IsPlayerInAnyVehicle(plid) == 1 || IsPlayerInAnyVehicle(playerid) == 1){
                SendClientMessage(playerid, Vermelho, "Alguem está dentro de um carro...");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
					format(string, sizeof(string), "O policial %s te algemou.", aname);
					SendClientMessage(plid, Azul, string);
                    TogglePlayerControllable(plid, 0);
				    SendClientMessage(playerid, COLOR_GREEN, "Player algemado");
			    	return 1;
                    }    
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}

    if(strcmp(cmd, "/desalgemar", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(dini_Int(aname, "Profissao") == Policial_M || dini_Int(aname, "Profissao") == Policial_C || dini_Int(aname, "Profissao") == Policial_F || dini_Int(aname, "Profissao") == Delegado || dini_Int(aname, "Profissao") == Bope || dini_Int(aname, "Profissao") == Swat || dini_Int(aname, "Profissao") == Narcoticos || dini_Int(aname, "Profissao") == FBI || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/desalgemar [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
   new distancia;
	    	distancia = GetDistanceBetweenPlayers(plid, playerid);
			    if(distancia > 10){
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}
                if(IsPlayerInAnyVehicle(plid) == 1 || IsPlayerInAnyVehicle(playerid) == 1){
                SendClientMessage(playerid, Vermelho, "Alguem está dentro de um carro...");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
					format(string, sizeof(string), "O policial %s te desalgemou.", aname);
					SendClientMessage(plid, Azul, string);
                    TogglePlayerControllable(plid, 1);
				    SendClientMessage(playerid, COLOR_GREEN, "Player desalgemado");
			    	return 1;
                    }    
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}




    if(strcmp(cmd, "/prender", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);        
	    if(dini_Int(aname, "Profissao") == Policial_C || dini_Int(aname, "Profissao") == Policial_F || dini_Int(aname, "Profissao") == Delegado || dini_Int(aname, "Profissao") == Bope || dini_Int(aname, "Profissao") == Swat || dini_Int(aname, "Profissao") == Narcoticos || dini_Int(aname, "Profissao") == FBI || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/prender [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
            new distancia;
	    	distancia = GetDistanceBetweenPlayers(plid, playerid);
			    if(distancia > 10){
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}
                if(IsPlayerInAnyVehicle(plid) == 1 || IsPlayerInAnyVehicle(playerid) == 1){
                SendClientMessage(playerid, Vermelho, "Alguem está dentro de um carro...");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
                new pname[MAX_PLAYER_NAME];
                    GetPlayerName(plid, pname, MAX_PLAYER_NAME);
					format(string, sizeof(string), "O policial %s te prendeu.", aname);
					SendClientMessage(plid, Azul, string);
                    SetPlayerPos(plid, 264.4181,77.3247,1001.0391); 
                    SetPlayerHealth(plid, 99999);
                    SetPlayerWantedLevel(plid, 0);
                    SetPlayerInterior(plid, 6);
                    ResetPlayerWeapons(plid);                 
                    dini_IntSet(pname, "Preso", 1);
				    SendClientMessage(playerid, COLOR_GREEN, "Player Preso");
			    	return 1;
                    }    
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}

    if(strcmp(cmd, "/famar", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(dini_Int(aname, "PFama") == 1){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/famar [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");
                } else {
                new pname[MAX_PLAYER_NAME];
                    GetPlayerName(plid, pname, MAX_PLAYER_NAME);
					format(string, sizeof(string), "O player %s te famou.", aname);
					SendClientMessage(plid, Azul, string);
                    dini_IntSet(pname, "Fama", dini_Int(pname, "Fama")+1);
                    dini_IntSet(aname, "PFama", 0);
				    SendClientMessage(playerid, COLOR_GREEN, "Player Famado, no próximo up podera famar de novo.");
			    	return 1;
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}

    if(strcmp(cmd, "/ccar", true) == 0) {
        if(pAdmin[playerid] >= 5){
			new tmp[256];
			new carid, Float:ang, preco, cor1, cor2;

			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)){
				SendClientMessage(playerid, Cinza, "Erro: ID fora do normal | ID's = 400-611");
				return 1;
			}
		    carid = strval(tmp);

    	    tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, Cinza, "Erro: /ccar [id] [preço] [cor1] [cor2]");
				return 1;
			}
            preco = strval(tmp);

    	    tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, Cinza, "Erro: /ccar [id] [preço] [cor1] [cor2]");
				return 1;
			}
            cor1 = strval(tmp);

    	    tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, Cinza, "Erro: /ccar [id] [preço] [cor1] [cor2]");
				return 1;
			}
			cor2 = strval(tmp);
			if(carid >= 400 && carid <= 611){
            if(IsPlayerInAnyVehicle(playerid)){
				        new Float:X, Float:Y, Float:Z;
						GetPlayerPos(playerid, X, Y, Z);
						GetVehicleZAngle(GetPlayerVehicleID(playerid),ang);
						format(string, sizeof(string), "carro%d.ini", proximocarro);
                        if(!dini_Exists(string)){
                        dini_Create(string);
                        dini_IntSet(string, "Modelo", carid);
                        dini_FloatSet(string, "CordX", Float:X);
                        dini_FloatSet(string, "CordY", Float:Y);
                        dini_FloatSet(string, "CordZ", Float:Z);
                        dini_FloatSet(string, "Angulo", Float:ang);
                        dini_IntSet(string, "Cor1", cor1);
                        dini_IntSet(string, "Cor2", cor2);
                        dini_IntSet(string, "TDono", 0);
                        dini_Set(string, "Dono", "Ninguem");
                        dini_IntSet(string, "Preco", preco);
                        }
			SetTimerEx("CriarVeiculo2",5000,false,"dffffdd",carid,X,Y,Z,ang,cor1,cor2);
                        format(string, sizeof(string), "Carro criado com sucesso.");
                        SendClientMessage(playerid, Azul, string);
						return 1;
            } else {
            SendClientMessage(playerid, Vermelho, "Você não está em um carro.");
            }
			}
			else{
				SendClientMessage(playerid, Cinza, "Erro: ID fora do normal | ID's = 400-611");
				return 1;
			}
		} else {
			SendClientMessage(playerid, Cinza, "Erro: Você não tem permissão para isso");
			return 1;
		}
	}

    if(strcmp(cmdtext, "/comprarprop", true) == 0) {
    for(new p = 0; p < MAX_CASAS; p++)
    {
    format(string, sizeof(string), "prop%d.ini", p);
    if(dini_Exists(string)){
   // new Float:X, Float:Y, Float:Z;
    //GetPlayerPos(playerid, X, Y, Z);
    if(IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"))){
    if(dini_Int(string, "TDono") == 0){
    if(GetPlayerPCash(playerid) >= dini_Int(string, "Preco")){
    if(GetProps(playerid) <= 3){
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    dini_IntSet(string, "TDono", 1);
    dini_Set(string, "Dono", pname);
    GivePlayerPCash(playerid, -dini_Int(string, "Preco"));
    new pickupid;
    DestroyPickup(dini_Int(string, "Id"));
    pickupid = CreatePickup(1272, 1, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"), -1);
    dini_IntSet(string, "Id", pickupid);
    } else {
    SendClientMessage(playerid, Vermelho, "Você já tem 3 propriedades.");
    }
    } else {
    SendClientMessage(playerid, Vermelho, "Você não tem dinheiro.");
    }
    } else {
    SendClientMessage(playerid, Vermelho, "Esta propriedade não está a venda !");
    }
    } else {
    //SendClientMessage(playerid, Vermelho, "Você não está em uma propriedade.");
    }
    }
    }
    return 1;
    }

    if(strcmp(cmd, "/precoprop", true) == 0) {
    new preco;
    new tmp[256];
    tmp = strtok(cmdtext, idx);
    if(!strlen(tmp)){
    SendClientMessage(playerid, Vermelho, "/precoprop [preço]");
    return 1;
    }
    preco = strval(tmp);
    for(new p = 0; p < MAX_CASAS; p++)
    {
    format(string, sizeof(string), "prop%d.ini", p);
    if(dini_Exists(string)){
   // new Float:X, Float:Y, Float:Z;
    //GetPlayerPos(playerid, X, Y, Z);
    if(IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"))){
    if(pAdmin[playerid] >= 5){
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    dini_IntSet(string, "Preco", preco);
    } else {
    SendClientMessage(playerid, Vermelho, "Você não tem permissão.");
    }
    } else {
    //SendClientMessage(playerid, Vermelho, "Você não está em uma propriedade.");
    }
    }
    }
    return 1;
    }

    if(strcmp(cmd, "/precocasa", true) == 0) {
    new preco;
    new tmp[256];
    tmp = strtok(cmdtext, idx);
    if(!strlen(tmp)){
    SendClientMessage(playerid, Vermelho, "/precocasa [preço]");
    return 1;
    }
    preco = strval(tmp);
    for(new c = 0; c < MAX_CASAS; c++)
    {
    format(string, sizeof(string), "casa%d.ini", c);
    if(dini_Exists(string)){
   // new Float:X, Float:Y, Float:Z;
    //GetPlayerPos(playerid, X, Y, Z);
    if(IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"))){
    if(pAdmin[playerid] >= 5){
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    dini_IntSet(string, "Preco", preco);
    } else {
    SendClientMessage(playerid, Vermelho, "Você não tem permissão.");
    }
    } else {
    //SendClientMessage(playerid, Vermelho, "Você não está em uma propriedade.");
    }
    }
    }
    return 1;
    }

    if(strcmp(cmd, "/ircasa", true) == 0) {
    new id;
    new tmp[256];
    tmp = strtok(cmdtext, idx);
    if(!strlen(tmp)){
    SendClientMessage(playerid, Vermelho, "/ircasa [id]");
    return 1;
    }
    id = strval(tmp);
    format(string, sizeof(string), "casa%d.ini", id);
    if(dini_Exists(string)){
   // new Float:X, Float:Y, Float:Z;
    //GetPlayerPos(playerid, X, Y, Z);
  //  if(IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"))){
    if(pAdmin[playerid] >= 5){
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    SetPlayerPos(playerid, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"));
    } else {
    SendClientMessage(playerid, Vermelho, "Você não tem permissão.");
    }
    }
    return 1;
    }

    if(strcmp(cmd, "/irprop", true) == 0) {
    new id;
    new tmp[256];
    tmp = strtok(cmdtext, idx);
    if(!strlen(tmp)){
    SendClientMessage(playerid, Vermelho, "/irprop [id]");
    return 1;
    }
    id = strval(tmp);
    format(string, sizeof(string), "prop%d.ini", id);
    if(dini_Exists(string)){
   // new Float:X, Float:Y, Float:Z;
    //GetPlayerPos(playerid, X, Y, Z);
  //  if(IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"))){
    if(pAdmin[playerid] >= 5){
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    SetPlayerPos(playerid, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"));
    } else {
    SendClientMessage(playerid, Vermelho, "Você não tem permissão.");
    }
    }
    return 1;
    }

    if(strcmp(cmd, "/infoprop", true) == 0) {
    new id;
    new tmp[256];
    tmp = strtok(cmdtext, idx);
    if(!strlen(tmp)){
    SendClientMessage(playerid, Vermelho, "/infoprop [id]");
    return 1;
    }
    id = strval(tmp);
    format(string, sizeof(string), "prop%d.ini", id);
    if(dini_Exists(string)){
    if(pAdmin[playerid] >= 5){
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    new tdono[10];
    if(dini_Int(string, "TDono") == 0){
    format(tdono, sizeof(tdono), "Não");
    } else {
    format(tdono, sizeof(tdono), "Sim");
    }
    format(string, sizeof(string), "Propriedade[%s] Id:%d, Dono[%s] = %s, Preço: R$%d, Dinheiro nela: R$%d.", dini_Get(string, "Nome"), id, tdono, dini_Get(string, "Dono"), dini_Int(string, "Preco"), dini_Int(string, "Dinheiro"));
    SendClientMessage(playerid, Azul, string);
    } else {
    SendClientMessage(playerid, Vermelho, "Você não tem permissão.");
    }
    }
    return 1;
    }

    if(strcmp(cmd, "/infocasa", true) == 0) {
    new id;
    new tmp[256];
    tmp = strtok(cmdtext, idx);
    if(!strlen(tmp)){
    SendClientMessage(playerid, Vermelho, "/infocasa [id]");
    return 1;
    }
    id = strval(tmp);
    format(string, sizeof(string), "casa%d.ini", id);
    if(dini_Exists(string)){
    if(pAdmin[playerid] >= 5){
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    new tdono[10];
    if(dini_Int(string, "TDono") == 0){
    format(tdono, sizeof(tdono), "Não");
    } else {
    format(tdono, sizeof(tdono), "Sim");
    }
    format(string, sizeof(string), "Casa Id:%d, Dono[%s] = %s, Preço: R$%d.", id, tdono, dini_Get(string, "Dono"), dini_Int(string, "Preco"));
    SendClientMessage(playerid, Azul, string);
    } else {
    SendClientMessage(playerid, Vermelho, "Você não tem permissão.");
    }
    }
    return 1;
    }

    if(strcmp(cmd, "/infocarro", true) == 0) {
    new id;
    new tmp[256];
    tmp = strtok(cmdtext, idx);
    if(!strlen(tmp)){
    SendClientMessage(playerid, Vermelho, "/infocarro [id]");
    return 1;
    }
    id = strval(tmp);
    format(string, sizeof(string), "carro%d.ini", id);
    if(dini_Exists(string)){
    if(pAdmin[playerid] >= 5){
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    new tdono[10];
    if(dini_Int(string, "TDono") == 0){
    format(tdono, sizeof(tdono), "Não");
    } else {
    format(tdono, sizeof(tdono), "Sim");
    }
    format(string, sizeof(string), "Carro Id:%d, Dono[%s] = %s, Preço: R$%d, Modelo: %s(%d), Cores(%d, %d).", id, tdono, dini_Get(string, "Dono"), dini_Int(string, "Preco"), PlayerVehicle[dini_Int(string, "Modelo")-400], dini_Int(string, "Modelo"), dini_Int(string, "Cor1"), dini_Int(string, "Cor2"));
    SendClientMessage(playerid, Azul, string);
    } else {
    SendClientMessage(playerid, Vermelho, "Você não tem permissão.");
    }
    }
    return 1;
    }

    if(strcmp(cmd, "/irccar", true) == 0) {
    new id;
    new tmp[256];
    tmp = strtok(cmdtext, idx);
    if(!strlen(tmp)){
    SendClientMessage(playerid, Vermelho, "/ircarro [id]");
    return 1;
    }
    id = strval(tmp);
    format(string, sizeof(string), "carro%d.ini", id);
    if(dini_Exists(string)){
    new Float:X, Float:Y, Float:Z;
    GetVehiclePos(dini_Int(string, "Id"), X, Y, Z);
  //  if(IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"))){
    if(pAdmin[playerid] >= 5){
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    SetPlayerPos(playerid, X, Y, Z);
    } else {
    SendClientMessage(playerid, Vermelho, "Você não tem permissão.");
    }
    }
    return 1;
    }

     if(strcmp(cmdtext, "/comprarcasa", true) == 0) {
    for(new c = 0; c < MAX_CASAS; c++)
    {
    format(string, sizeof(string), "casa%d.ini", c);
    if(dini_Exists(string)){
   // new Float:X, Float:Y, Float:Z;
    //GetPlayerPos(playerid, X, Y, Z);
    if(IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"))){
    if(dini_Int(string, "TDono") == 0){
    if(GetPlayerPCash(playerid) >= dini_Int(string, "Preco")){
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    dini_IntSet(string, "TDono", 1);
    dini_Set(string, "Dono", pname);
    GivePlayerPCash(playerid, -dini_Int(string, "Preco"));
    new pickupid;
    DestroyPickup(dini_Int(string, "Id"));
    pickupid = CreatePickup(1272, 1, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"), -1);
    dini_IntSet(string, "Id", pickupid);
    } else {
    SendClientMessage(playerid, Vermelho, "Você não tem dinheiro.");
    }
    } else {
    SendClientMessage(playerid, Vermelho, "Esta casa não está a venda !");
    }
    } else {
    //SendClientMessage(playerid, Vermelho, "Você não está em uma propriedade.");
    }
    }
    }
    return 1;
    }

    if(strcmp("/horarios", cmdtext, true, 10) == 0){
SendClientMessage(playerid, Amarelo, "Lanchonetes abrem das 6:00 as 22:00");
SendClientMessage(playerid, Amarelo, "Faculdade abre de 12:30 a 13:00");
SendClientMessage(playerid, Amarelo, "Ammu-nations abrem das 9:00 as 23:00");
return 1;
}

if(strcmp(cmdtext, "/comprarcarro", true) == 0) {
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, sizeof(pname));
if(dini_Int(pname, "TCarro") == 1){
SendClientMessage(playerid, Vermelho, "Você já tem um carro");
return 1;
}
for(new carro = 0; carro < MAX_CARROS; carro++)
{
format(string, sizeof(string), "carro%d.ini", carro);
if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && VehicleID == dini_Int(string, "Id")){
if(GetPlayerPCash(playerid) >= dini_Int(string, "Preco")){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
dini_IntSet(pname, "TCarro", 1);
dini_IntSet(string, "TDono", 1);
dini_Set(string, "Dono", aname);
SendClientMessage(playerid, Azul, "Parabéns Você comprou um carro.");
SendClientMessage(playerid, Azul, "Para edita-lo use /meucarro.");
GivePlayerPCash(playerid, -dini_Int(string, "Preco"));
TogglePlayerControllable(playerid, 1);
incar[playerid] = 0;
return 1;
} else {
SendClientMessage(playerid, Vermelho, "Você não tem dinheiro.");
return 1;
}
}
}
}

if(strcmp(cmdtext, "/meucarro", true) == 0) {
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
new resultados;
for(new carro = 0; carro < MAX_CARROS; carro++)
{
format(string, sizeof(string), "carro%d.ini", carro);
if(dini_Exists(string)){
if(strcmp(dini_Get(string, "Dono"), pname, false) == 0 && dini_Int(pname, "TCarro") == 1){
ShowPlayerDialog(playerid, 4501, DIALOG_STYLE_LIST, "Meu Carro", "Salvar Posição \nAlterar cor 1 \nAlterar cor 2 \nRespawnar Carro \nVender Carro", "OK", "Cancelar");
resultados = 0;
} else {
resultados = 1;
}
}
}
if(resultados == 1){
SendClientMessage(playerid, Vermelho, "Você não tem carro.");
return 1;
}
return 1;
}

if(strcmp(cmdtext, "/venderprop", true) == 0) {
new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    for(new p = 0; p < MAX_CASAS; p++)
    {
    format(string, sizeof(string), "prop%d.ini", p);
    if(dini_Exists(string)){
   // new Float:X, Float:Y, Float:Z;
    //GetPlayerPos(playerid, X, Y, Z);
    if(IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"))){
    if(dini_Int(string, "TDono") == 1){
    if(strcmp(dini_Get(string, "Dono"), pname, false) == 0 || pAdmin[playerid] >= 5){
    dini_IntSet(string, "TDono", 0);
    dini_Set(string, "Dono", "Ninguem");
    GivePlayerPCash(playerid, dini_Int(string, "Preco") / 2);
    new pickupid;
    DestroyPickup(dini_Int(string, "Id"));
    pickupid = CreatePickup(1273, 1, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"), -1);
    dini_IntSet(string, "Id", pickupid);
    } else {
    SendClientMessage(playerid, Vermelho, "Esta propriedade não é sua.");
    }
    } else {
    SendClientMessage(playerid, Vermelho, "Esta propriedade já está a venda !");
    }
    } else {
   // SendClientMessage(playerid, Vermelho, "Você não está em uma propriedade.");
    }
    }
    }
    return 1;
    }

    if(strcmp(cmdtext, "/vendercasa", true) == 0) {
new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    for(new c = 0; c < MAX_CASAS; c++)
    {
    format(string, sizeof(string), "casa%d.ini", c);
    if(dini_Exists(string)){
   // new Float:X, Float:Y, Float:Z;
    //GetPlayerPos(playerid, X, Y, Z);
    if(IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"))){
    if(dini_Int(string, "TDono") == 1){
    if(strcmp(dini_Get(string, "Dono"), pname, false) == 0 || pAdmin[playerid] >= 5){
    dini_IntSet(string, "TDono", 0);
    dini_Set(string, "Dono", "Ninguem");
    GivePlayerPCash(playerid, dini_Int(string, "Preco") / 2);
    new pickupid;
    DestroyPickup(dini_Int(string, "Id"));
    pickupid = CreatePickup(1273, 1, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"), -1);
    dini_IntSet(string, "Id", pickupid);
    } else {
    SendClientMessage(playerid, Vermelho, "Esta casa não é sua.");
    }
    } else {
    SendClientMessage(playerid, Vermelho, "Esta casa já está a venda !");
    }
    } else {
   // SendClientMessage(playerid, Vermelho, "Você não está em uma propriedade.");
    }
    }
    }
    return 1;
    }

    if(strcmp(cmdtext, "/sacarprop", true) == 0) {
new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    for(new p = 0; p < MAX_CASAS; p++)
    {
    format(string, sizeof(string), "prop%d.ini", p);
    if(dini_Exists(string)){
   // new Float:X, Float:Y, Float:Z;
    //GetPlayerPos(playerid, X, Y, Z);
    if(IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"))){
    if(dini_Int(string, "TDono") == 1){
    if(strcmp(dini_Get(string, "Dono"), pname, false) == 0){
    GivePlayerPCash(playerid, dini_Int(string, "Grana"));
    new strx[256];
    format(strx, sizeof(strx), "Você pegou R$%d da sua propriedade.", dini_Int(string, "Grana"));
    SendClientMessage(playerid, Amarelo, strx);
    dini_IntSet(string, "Grana", 0);
    } else {
    SendClientMessage(playerid, Vermelho, "Esta propriedade não é sua.");
    }
    } else {
    SendClientMessage(playerid, Vermelho, "Esta propriedade não tem dono.");
    }
    } else {
   // SendClientMessage(playerid, Vermelho, "Você não está em uma propriedade.");
    }
    }
    }
    return 1;
    }

    if(strcmp(cmd, "/criarprop", true) == 0) {
    if(pAdmin[playerid] >= 5){
    new tmp[256];
    new preco
    tmp = strtok(cmdtext, idx);
    if(!strlen(tmp)){
    SendClientMessage(playerid, Vermelho, "/criarprop [preço]");
    return 1;
    }
    preco = strval(tmp);
    format(string, sizeof(string), "prop%d.ini", proximaprop);
    if(!dini_Exists(string)){
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    dini_Create(string);
    dini_FloatSet(string, "PosX", X);
    dini_FloatSet(string, "PosY", Y);
    dini_FloatSet(string, "PosZ", Z);
    dini_IntSet(string, "Int", 0);
    dini_FloatSet(string, "IntX", X);
    dini_FloatSet(string, "IntY", Y);
    dini_FloatSet(string, "IntZ", Z);
    dini_FloatSet(string, "Mundo", proximaprop);
    dini_IntSet(string, "TDono", 0);
    dini_Set(string, "Dono", "Ninguem");
    dini_IntSet(string, "Preco", preco);
    dini_Set(string, "Nome", "Sem Nome");
    new pickupid;
    pickupid = CreatePickup(1273, 1, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"), -1);
    dini_IntSet(string, "Id", pickupid);
    proximaprop++;
    }
    }
    return 1;
    }

     if(strcmp(cmd, "/criarcasa", true) == 0) {
    if(pAdmin[playerid] >= 5){
    new tmp[256];
    new preco
    tmp = strtok(cmdtext, idx);
    if(!strlen(tmp)){
    SendClientMessage(playerid, Vermelho, "/criarcasa [preço]");
    return 1;
    }
    preco = strval(tmp);
    format(string, sizeof(string), "casa%d.ini", proximacasa);
    if(!dini_Exists(string)){
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    dini_Create(string);
    dini_FloatSet(string, "PosX", X);
    dini_FloatSet(string, "PosY", Y);
    dini_FloatSet(string, "PosZ", Z);
    dini_IntSet(string, "Int", 0);
    dini_FloatSet(string, "IntX", X);
    dini_FloatSet(string, "IntY", Y);
    dini_FloatSet(string, "IntZ", Z);
    dini_FloatSet(string, "Mundo", proximacasa);
    dini_IntSet(string, "TDono", 0);
    dini_Set(string, "Dono", "Ninguem");
    dini_IntSet(string, "Preco", preco);
    new pickupid;
    pickupid = CreatePickup(1273, 1, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"), -1);
    dini_IntSet(string, "Id", pickupid);
    proximacasa++;
    }
    }
    return 1;
    }


      if(strcmp(cmd, "/soltar", true) == 0) {
        new plid;        
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);        
	    new pname[MAX_PLAYER_NAME];
        GetPlayerName(plid, pname, MAX_PLAYER_NAME);
        if(pAdmin[playerid] >= 3){
	    new tmp[256];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
		SendClientMessage(playerid, COLOR_RED, "/prender [id]");
		return 1;
		}
        plid = strval(tmp);
		if(IsPlayerConnected(plid)){
        if(dini_Int(pname, "Preso") == 0){
        SendClientMessage(playerid, Vermelho, "O jogador nao esta preso");
        } else {
        if(plid == playerid){
        SendClientMessage(playerid, Vermelho, "Quér prender voce mesmo?");
        } else {
		format(string, sizeof(string), "o Pm %s Soltou vocÊ.", aname);
		SendClientMessage(plid, Azul, string);
        dini_IntSet(pname, "Preso", 0);
        SpawnPlayer(plid);
		SendClientMessage(playerid, COLOR_GREEN, "Jogador Solto com susesso");
		return 1;
        }
		}
		return 1;
		}else{
    	SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		return 1;
		}
		}
     	}

    if(strcmp(cmd, "/curar", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);        
	    if(dini_Int(aname, "Profissao") == Medico || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/curar [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
   new distancia;
	    	distancia = GetDistanceBetweenPlayers(plid, playerid);
			    if(distancia > 10){
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}
                if(IsPlayerInAnyVehicle(plid) == 1 || IsPlayerInAnyVehicle(playerid) == 1){
                SendClientMessage(playerid, Vermelho, "Alguem está dentro de um carro...");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
                    if(crblock[playerid] == 0){
					format(string, sizeof(string), "O médico %s te curou.", aname);
					SendClientMessage(plid, Azul, string);
                    SetPlayerHealth(plid, 100);                                      
				    SendClientMessage(playerid, COLOR_GREEN, "Player Curado");    
                    crblock[playerid] = 1;
			    	return 1;
                    } else {
                     SendClientMessage(playerid, Vermelho, "Aguarde 5 minutos para refazer os curativos.");                     
                    return 1;
                    }                            
                    }
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}


    if(strcmp(cmd, "/ttaxi", true) == 0 && IsPlayerConnected(playerid)) {
	    new pname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	    if(dini_Int(pname, "Profissao") == Taxista || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/ttaxi [id]");
			    return 1;
			}
        	plid = strval(tmp);
			if(GetPlayerVehicleID(playerid) == GetPlayerVehicleID(plid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
                SendClientMessage(playerid, COLOR_GREEN, "O taxímetro começou a rodar.");
                SendClientMessage(plid, COLOR_GREEN, "O taxímetro começou a rodar. A bandeirada de $20 foi cobrada.");
                GivePlayerPCash(playerid,20);
                GivePlayerPCash(plid,-20);
                Taximetro[plid][0] = 1;
                Taximetro[plid][1] = playerid;
		    	return 1;
			}
			else {
			    SendClientMessage(playerid, COLOR_RED, "O passageiro não está dentro do seu carro ou você não é o motorista.");
		    	return 1;
			}
            }            
            return 1;
            }  
        
    if(strcmp(cmd, "/venderak", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);        
	    if(dini_Int(aname, "Profissao") == Traficante || dini_Int(aname, "Profissao") == ComandoVermelho || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/venderak [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
                new distancia;
	    	distancia = GetDistanceBetweenPlayers(playerid, plid);
			    if(distancia > 10){
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}
                if(IsPlayerInAnyVehicle(plid) == 1 && IsPlayerInAnyVehicle(playerid) == 1){
                SendClientMessage(playerid, Vermelho, "Alguem está dentro de um carro...");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
					format(string, sizeof(string), "O traficante %s te vendeu uma AK.", aname);
					SendClientMessage(plid, Vermelho, string);
                    GivePlayerWeapon(plid, 30, 150);                   
				    SendClientMessage(playerid, COLOR_GREEN, "Ak 47 Vendida !");
			    	return 1;
                    }    
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}

     if(strcmp(cmd, "/vendersniper", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);        
	    if(dini_Int(aname, "Profissao") == Traficante || dini_Int(aname, "Profissao") == ComandoVermelho || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/vendersniper [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
   new distancia;
	    	distancia = GetDistanceBetweenPlayers(playerid, plid);
			    if(distancia > 10){   
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}
                if(IsPlayerInAnyVehicle(plid) == 1 && IsPlayerInAnyVehicle(playerid) == 1){
                SendClientMessage(playerid, Vermelho, "Alguem está dentro de um carro...");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
					format(string, sizeof(string), "O traficante %s te vendeu uma Sniper.", aname);
					SendClientMessage(plid, Vermelho, string);
                    GivePlayerWeapon(plid, 34, 25);                   
				    SendClientMessage(playerid, COLOR_GREEN, "Ak 47 Vendida !");
			    	return 1;
                    }    
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}

     if(strcmp(cmd, "/venderm4", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);        
	    if(dini_Int(aname, "Profissao") == Traficante || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/venderm4 [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
                new distancia;
	    	distancia = GetDistanceBetweenPlayers(playerid, plid);
			    if(distancia > 10){
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}
                if(IsPlayerInAnyVehicle(plid) == 1 && IsPlayerInAnyVehicle(playerid) == 1){
                SendClientMessage(playerid, Vermelho, "Alguem está dentro de um carro...");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
					format(string, sizeof(string), "O traficante %s te vendeu uma M4.", aname);
					SendClientMessage(plid, Vermelho, string);
                    GivePlayerWeapon(plid, 31, 150);                   
				    SendClientMessage(playerid, COLOR_GREEN, "M4 Vendida !");
			    	return 1;
                    }    
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}


    if(strcmp(cmd, "/venderswanoff", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);        
	    if(dini_Int(aname, "Profissao") == Traficante || dini_Int(aname, "Profissao") == ComandoVermelho || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/venderswanoff [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
                new distancia;
	    	distancia = GetDistanceBetweenPlayers(playerid, plid);
			    if(distancia > 10){
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}
                if(IsPlayerInAnyVehicle(plid) == 1 && IsPlayerInAnyVehicle(playerid) == 1){
                SendClientMessage(playerid, Vermelho, "Alguem está dentro de um carro...");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
					format(string, sizeof(string), "O traficante %s te vendeu uma Swan Off.", aname);
					SendClientMessage(plid, Vermelho, string);
                    GivePlayerWeapon(plid, 26, 35);                   
				    SendClientMessage(playerid, COLOR_GREEN, "Swan Off Vendida !");
			    	return 1;
                    }    
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}

    if(strcmp(cmd, "/vendertec", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);        
	    if(dini_Int(aname, "Profissao") == Traficante || dini_Int(aname, "Profissao") == ComandoVermelho || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/vendertec [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
                new distancia;
	    	distancia = GetDistanceBetweenPlayers(playerid, plid);
			    if(distancia > 10){
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}
                if(IsPlayerInAnyVehicle(plid) == 1 && IsPlayerInAnyVehicle(playerid) == 1){
                SendClientMessage(playerid, Vermelho, "Alguem está dentro de um carro...");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
					format(string, sizeof(string), "O traficante %s te vendeu uma Tec.", aname);
					SendClientMessage(plid, Vermelho, string);
                    GivePlayerWeapon(plid, 32, 150);                   
				    SendClientMessage(playerid, COLOR_GREEN, "Tec Vendida !");
			    	return 1;
                    }    
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}

    if(strcmp(cmd, "/soltar", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME); 
        new plid;       
	    if(dini_Int(aname, "Profissao") == Policial_C || dini_Int(aname, "Profissao") == Policial_F || dini_Int(aname, "Profissao") == Delegado || dini_Int(aname, "Profissao") == Bope || dini_Int(aname, "Profissao") == Swat || dini_Int(aname, "Profissao") == Narcoticos || dini_Int(aname, "Profissao") == FBI || pAdmin[playerid] >= 3){
	    	new tmp[256];
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/prender [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
                new pname[MAX_PLAYER_NAME];
        GetPlayerName(plid, pname, MAX_PLAYER_NAME);
                if(dini_Int(pname, "Preso") == 0){
                SendClientMessage(playerid, Vermelho, "O player não está preso");                
                } else {                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {                   
				    SendClientMessage(playerid, COLOR_GREEN, "~> [COMANDO REMOVIDO] <~");
			    	return 1;
                    }    
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
		}
	}

if(strcmp(cmdtext, "/profissao", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == Desempregado){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Desempregado___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Desempregado___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");  */
}
if(dini_Int(aname, "Profissao") == Estagiario){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Estágiario___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Estágiario___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");     */
}
if(dini_Int(aname, "Profissao") == Guarda){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Guarda - Policia___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/pegararmas [id]: Pega as armas de uma pessoa. \n/ad: Abre a porta da delegacia. \n/fd: Fecha a porta da delegacia. \n/deter [id]: Detem alguém. \n/liberar [id]: Libera alguém detido.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Guarda - Policia___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/pegararmas [id]: Pega as armas de uma pessoa.");
SendClientMessage(playerid, Vermelho,"/ad: Abre a porta da delegacia.");
SendClientMessage(playerid, Vermelho,"/fd: Fecha a porta da delegacia.");
SendClientMessage(playerid, Vermelho,"/deter [id]: Detem alguém.");
SendClientMessage(playerid, Vermelho,"/liberar [id]: Libera alguém detido.");  */
}
if(dini_Int(aname, "Profissao") == Policial_R){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Policial Rodoviário - Policia___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/pegararmas [id]: Pega as armas de uma pessoa. \n/ad: Abre a porta da delegacia. \n/fd: Fecha a porta da delegacia. \n/deter [id]: Detem alguém. \n/liberar [id]: Libera alguém detido.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Policial Rodoviário - Policia___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/pegararmas [id]: Pega as armas de uma pessoa.");
SendClientMessage(playerid, Vermelho,"/ad: Abre a porta da delegacia.");
SendClientMessage(playerid, Vermelho,"/fd: Fecha a porta da delegacia.");
SendClientMessage(playerid, Vermelho,"/deter [id]: Detem alguém.");
SendClientMessage(playerid, Vermelho,"/liberar [id]: Libera alguém detido.");  */
}
if(dini_Int(aname, "Profissao") == Policial_M){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Policial Militar - Policia___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/pegararmas [id]: Pega as armas de uma pessoa. \n/ad: Abre a porta da delegacia. \n/fd: Fecha a porta da delegacia. \n/deter [id]: Detem alguém. \n/liberar [id]: Libera alguém detido. \n/algemar [id]: Algema alguém. \n/desalgemar [id]: Desalgema alguém.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Policial Militar - Policia___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/pegararmas [id]: Pega as armas de uma pessoa.");
SendClientMessage(playerid, Vermelho,"/algemar [id]: Algema alguem.");
SendClientMessage(playerid, Vermelho,"/desalgemar [id]: Desalgema alguem.");
SendClientMessage(playerid, Vermelho,"/ad: Abre a porta da delegacia.");
SendClientMessage(playerid, Vermelho,"/fd: Fecha a porta da delegacia.");
SendClientMessage(playerid, Vermelho,"/deter [id]: Detem alguém. - /liberar [id]: Libera alguém detido.");     */
}
if(dini_Int(aname, "Profissao") == Policial_C){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Policial Civil - Policia___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/pegararmas [id]: Pega as armas de uma pessoa. \n/ad: Abre a porta da delegacia. \n/fd: Fecha a porta da delegacia. \n/deter [id]: Detem alguém. \n/liberar [id]: Libera alguém detido. \n/algemar [id]: Algema alguém. \n/desalgemar [id]: Desalgema alguém. \n/prender [id]: Prende Alguém.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Policial Civil - Policia___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/pegararmas [id]: Pega as armas de uma pessoa.");
SendClientMessage(playerid, Vermelho,"/algemar [id]: Algema alguem. /desalgemar [id] Desalgema");
SendClientMessage(playerid, Vermelho,"/prender [id]: Prende alguem. /soltar [id] Solta");
SendClientMessage(playerid, Vermelho,"/ad: Abre a porta da delegacia. /fd Fecha.");
SendClientMessage(playerid, Vermelho,"/deter [id]: Detem alguém. - /liberar [id]: Libera alguém detido.");  */
}
if(dini_Int(aname, "Profissao") == Policial_F){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Policial Federal - Policia___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/pegararmas [id]: Pega as armas de uma pessoa. \n/ad: Abre a porta da delegacia. \n/fd: Fecha a porta da delegacia. \n/deter [id]: Detem alguém. \n/liberar [id]: Libera alguém detido. \n/algemar [id]: Algema alguém. \n/desalgemar [id]: Desalgema alguém. \n/prender [id]: Prende Alguém.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Policial Federal - Policia___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/pegararmas [id]: Pega as armas de uma pessoa.");
SendClientMessage(playerid, Vermelho,"/algemar [id]: Algema alguem. /desalgemar [id] Desalgema");
SendClientMessage(playerid, Vermelho,"/prender [id]: Prende alguem. /soltar [id] Solta");
SendClientMessage(playerid, Vermelho,"/ad: Abre a porta da delegacia. /fd Fecha.");
SendClientMessage(playerid, Vermelho,"/deter [id]: Detem alguém. - /liberar [id]: Libera alguém detido."); */
}
if(dini_Int(aname, "Profissao") == Delegado){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Delegado - Policia___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/pegararmas [id]: Pega as armas de uma pessoa. \n/ad: Abre a porta da delegacia. \n/fd: Fecha a porta da delegacia. \n/deter [id]: Detem alguém. \n/liberar [id]: Libera alguém detido. \n/algemar [id]: Algema alguém. \n/desalgemar [id]: Desalgema alguém. \n/prender [id]: Prende Alguém.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Delegado - Policia___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/pegararmas [id]: Pega as armas de uma pessoa.");
SendClientMessage(playerid, Vermelho,"/algemar [id]: Algema alguem. /desalgemar [id] Desalgema");
SendClientMessage(playerid, Vermelho,"/prender [id]: Prende alguem. /soltar [id] Solta");
SendClientMessage(playerid, Vermelho,"/ad: Abre a porta da delegacia. /fd Fecha.");
SendClientMessage(playerid, Vermelho,"/deter [id]: Detem alguém. - /liberar [id]: Libera alguém detido."); */
}
if(dini_Int(aname, "Profissao") == Bope){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___BOPE - Policia___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/pegararmas [id]: Pega as armas de uma pessoa. \n/ad: Abre a porta da delegacia. \n/fd: Fecha a porta da delegacia. \n/deter [id]: Detem alguém. \n/liberar [id]: Libera alguém detido. \n/algemar [id]: Algema alguém. \n/desalgemar [id]: Desalgema alguém. \n/prender [id]: Prende Alguém.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___BOPE - Policia___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/pegararmas [id]: Pega as armas de uma pessoa.");
SendClientMessage(playerid, Vermelho,"/algemar [id]: Algema alguem. /desalgemar [id] Desalgema");
SendClientMessage(playerid, Vermelho,"/prender [id]: Prende alguem. /soltar [id] Solta");
SendClientMessage(playerid, Vermelho,"/ad: Abre a porta da delegacia. /fd Fecha.");
SendClientMessage(playerid, Vermelho,"/deter [id]: Detem alguém. - /liberar [id]: Libera alguém detido.");*/
}
if(dini_Int(aname, "Profissao") == Swat){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___SWAT - Policia___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/pegararmas [id]: Pega as armas de uma pessoa. \n/ad: Abre a porta da delegacia. \n/fd: Fecha a porta da delegacia. \n/deter [id]: Detem alguém. \n/liberar [id]: Libera alguém detido. \n/algemar [id]: Algema alguém. \n/desalgemar [id]: Desalgema alguém. \n/prender [id]: Prende Alguém.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___SWAT - Policia___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/pegararmas [id]: Pega as armas de uma pessoa.");
SendClientMessage(playerid, Vermelho,"/algemar [id]: Algema alguem. /desalgemar [id] Desalgema");
SendClientMessage(playerid, Vermelho,"/prender [id]: Prende alguem. /soltar [id] Solta");
SendClientMessage(playerid, Vermelho,"/ad: Abre a porta da delegacia. /fd Fecha.");
SendClientMessage(playerid, Vermelho,"/deter [id]: Detem alguém. - /liberar [id]: Libera alguém detido.");    */
}
if(dini_Int(aname, "Profissao") == Narcoticos){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Narcoticos - Policia___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/pegararmas [id]: Pega as armas de uma pessoa. \n/ad: Abre a porta da delegacia. \n/fd: Fecha a porta da delegacia. \n/deter [id]: Detem alguém. \n/liberar [id]: Libera alguém detido. \n/algemar [id]: Algema alguém. \n/desalgemar [id]: Desalgema alguém. \n/prender [id]: Prende Alguém.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Narcoticos - Policia___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/pegararmas [id]: Pega as armas de uma pessoa.");
SendClientMessage(playerid, Vermelho,"/algemar [id]: Algema alguem. /desalgemar [id] Desalgema");
SendClientMessage(playerid, Vermelho,"/prender [id]: Prende alguem. /soltar [id] Solta");
SendClientMessage(playerid, Vermelho,"/ad: Abre a porta da delegacia. /fd Fecha.");
SendClientMessage(playerid, Vermelho,"/deter [id]: Detem alguém. - /liberar [id]: Libera alguém detido.");   */
}
if(dini_Int(aname, "Profissao") == Traficante){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Traficante de Armas - Crime___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/venderak [id]: Vende uma AK-47 a alguém. \n/venderm4 [id]: Vende uma M4 a alguém. \n/venderswanoff [id]: Vende uma Swan Off a alguém. \n/vendersniper [id]: Vende uma Sniper a alguém. \n/vendertec [id]: Vende uma TEC a alguém.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Traficante de Armas - Crime___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/venderak [id]: Vende uma AK-47 a alguém.");
SendClientMessage(playerid, Vermelho,"/venderm4 [id]: Vende uma M4 a alguém.");
SendClientMessage(playerid, Vermelho,"/venderswanoff [id]: Vende uma Swan Off a alguém.");
SendClientMessage(playerid, Vermelho,"/vendersniper [id]: Vende uma Sniper a alguém.");
SendClientMessage(playerid, Vermelho,"/vendertec [id]: Vende uma TEC a alguém."); */    
}
if(dini_Int(aname, "Profissao") == Assasino){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Assasino - Crime___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Assasino - Crime___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status."); */
}
if(dini_Int(aname, "Profissao") == Terrorista){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Terrorista - Crime___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/terror [texto]: Manda uma mensagem para por medo. \n/plantarbomba: Planta uma bomba.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Terrorista - Crime___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/terror [texto]: Manda uma mensagem para por medo.");
SendClientMessage(playerid, Vermelho,"/plantarbomba: Planta uma bomba.");*/
}
if(dini_Int(aname, "Profissao") == Sequestrador){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Sequestrador - Crime___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/avisar [texto]: Avisa algo.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Sequestrador - Crime___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/avisar [texto]: Avisa algo.");     */
}
if(dini_Int(aname, "Profissao") == AssasinoProfissional){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Assasino Profissional - Crime___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Assasino Profissional - Crime___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");*/
}
if(dini_Int(aname, "Profissao") == Jornalista){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Jornalista - Jornal___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/noticiar [texto]: Faz uma notícia. \n/aj: Abre a base dos jornalistas. \n/fj: Fecha a base dos jornalistas.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Jornalista - Jornal___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/noticiar [texto]: Faz uma noticia.");
SendClientMessage(playerid, Vermelho,"/aj: Abre a base dos jornalistas.");
SendClientMessage(playerid, Vermelho,"/fj: Fecha a base dos jornalistas.");  */
}
if(dini_Int(aname, "Profissao") == Fotografo){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Fotografo - Jornal___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/aj: Abre a base dos jornalistas. \n/fj: Fecha a base dos jornalistas.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Fotografo - Jornal___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/aj: Abre a base dos jornalistas.");
SendClientMessage(playerid, Vermelho,"/fj: Fecha a base dos jornalistas."); */
}
if(dini_Int(aname, "Profissao") == Reporter){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Reporter - Jornal___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/noticiar [texto]: Faz uma notícia. \n/aj: Abre a base dos jornalistas. \n/fj: Fecha a base dos jornalistas.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Reporter - Jornal___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/noticiar [texto]: Faz uma noticia.");
SendClientMessage(playerid, Vermelho,"/aj: Abre a base dos jornalistas.");
SendClientMessage(playerid, Vermelho,"/fj: Fecha a base dos jornalistas.");   */
}
if(dini_Int(aname, "Profissao") == Ancora){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Ancora - Jornal___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/noticiar [texto]: Faz uma notícia. \n/aj: Abre a base dos jornalistas. \n/fj: Fecha a base dos jornalistas.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Ancora - Jornal___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/noticiar [texto]: Faz uma noticia.");
SendClientMessage(playerid, Vermelho,"/aj: Abre a base dos jornalistas.");
SendClientMessage(playerid, Vermelho,"/fj: Fecha a base dos jornalistas.");      */
}
if(dini_Int(aname, "Profissao") == Meteorologista){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Meteorologista - Jornal___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/clima [previsão]: Faz uma previsão do tempo. \n/aj: Abre a base dos jornalistas. \n/fj: Fecha a base dos jornalistas.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Meteorologista - Jornal___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/clima [previsão]: Faz uma previsão do clima.");
SendClientMessage(playerid, Vermelho,"/aj: Abre a base dos jornalistas.");
SendClientMessage(playerid, Vermelho,"/fj: Fecha a base dos jornalistas.");      */
}
if(dini_Int(aname, "Profissao") == Mecanico){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Mecanico - Oficina___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/reparar: Repara um carro. \n/pintar [cor1] [cor2]: Pinta um carro. \n/am: Abre a base dos mecanicos. \n/fm: Fecha a base dos mecanicos. \n/tunar: Tuna um carro. \n2(Tecla de sub-missão): Guincha um carro. \nObs: Para guinchar presisa estar em um carro de mecanico.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Mecanico - Oficina___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/pintar [cor1] [cor2]: Pinta um carro.");
SendClientMessage(playerid, Vermelho,"/reparar: Repara um carro.");
SendClientMessage(playerid, Vermelho,"/am: Abre a base dos mecanicos.");
SendClientMessage(playerid, Vermelho,"/fm: Fecha a base dos mecanicos.");   */
}
if(dini_Int(aname, "Profissao") == VendedorCasa){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Vendedor de casas - Vendedor___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/casa [nome]: REMOVIDO PELO SISTEMA DE CASA.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Vendedor de Casas - Vendedor___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/casa [nome]: Vende uma casa a alguém."); */
}
if(dini_Int(aname, "Profissao") == VendedorSkin){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Vendedor de skins - Vendedor___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Vendedor de Skins - Vendedor___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/setskin [id] [skin]: Vende uma skin a alguém.");*/
}
if(dini_Int(aname, "Profissao") == VendedorCarro){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Vendedor de carros - Vendedor___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Vendedor de Carros - Vendedor___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/setcar [idcarro] [Dono] [cor1] [co2]: Vende um carro(Max 4 Carros por casa).");*/
}
if(dini_Int(aname, "Profissao") == VendedorComb){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Vendedor de gasolina - Vendedor___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/completar [id]: Completa o tanque de alguém.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Vendedor de Gasolina - Vendedor___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/abastecercarro: Abastece um carro."); */
}
if(dini_Int(aname, "Profissao") == Taxista){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Taxista - Honesta___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/ttaxi [id]: Liga o taximetro. \n/at: Abre a base dos taxistas. \n/ft: Fecha a base dos taxistas.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Taxista - Honesta___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/ttaxi [id]: Liga o taximetro.");
SendClientMessage(playerid, Vermelho,"/at: Abre a base dos taxistas.");
SendClientMessage(playerid, Vermelho,"/ft: Fecha a base dos taxistas."); */
}
if(dini_Int(aname, "Profissao") == Medico){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___Medico - Honesta___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/curar [id]: Faz um curativo.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Médico - Honesta___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/curar [id]: Faz um curativo."); */
}
if(dini_Int(aname, "Profissao") == FBI){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___FBI - Organização___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/pegararmas [id]: Pega as armas de uma pessoa. \n/ad: Abre a porta da delegacia. \n/fd: Fecha a porta da delegacia. \n/deter [id]: Detem alguém. \n/liberar [id]: Libera alguém detido. \n/algemar [id]: Algema alguém. \n/desalgemar [id]: Desalgema alguém. \n/prender [id]: Prende Alguém.", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Organização FBI___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/pegararmas [id]: Pega as armas de uma pessoa.");
SendClientMessage(playerid, Vermelho,"/algemar [id]: Algema alguem. /desalgemar [id] Desalgema");
SendClientMessage(playerid, Vermelho,"/prender [id]: Prende alguem. /soltar [id] Solta");
SendClientMessage(playerid, Vermelho,"/abrirfbi: Abre a base FBI. /fecharfbi Fecha.");
SendClientMessage(playerid, Vermelho,"/deter [id]: Detem alguém. - /liberar [id]: Libera alguém detido.");*/
}
if(dini_Int(aname, "Profissao") == ComandoVermelho){
ShowPlayerDialog(playerid, 80, DIALOG_STYLE_MSGBOX, "Comandos da Profissao", "|___CV - Organização___| \n/meustatus: Ve seus status \n/r [texto]: Chat da profissão. \n/venderak [id]: Vende uma AK-47 a alguém. \n/venderswanoff [id]: Vende uma Swan Off a alguém \n/vendersniper [id]: Vende uma Sniper a alguém. \n/vendertec [id]: Vende uma TEC a alguém. \n/plantarbomba: Planta uma bomba. \n/abrircv: Abre a base CV \n/fecharcv: Fecha a base CV \n", "Ok", "Fechar");
/*SendClientMessage(playerid, Verde,"|___Organização CV___|");
SendClientMessage(playerid, Vermelho,"/meustatus: Ve seus status.");
SendClientMessage(playerid, Vermelho,"/venderak [id]: Vende uma AK-47 a alguém.");
SendClientMessage(playerid, Vermelho,"/abrircv: Abre a base CV. /fecharcv Fecha");
SendClientMessage(playerid, Vermelho,"/venderswanoff [id]: Vende uma Swan Off a alguém.");
SendClientMessage(playerid, Vermelho,"/vendersniper [id]: Vende uma Sniper a alguém.");
SendClientMessage(playerid, Vermelho,"/vendertec [id]: Vende uma TEC a alguém.");
SendClientMessage(playerid, Vermelho,"/plantarbomba: Planta uma bomba."); */
}
return 1;
}

/*if(strcmp(cmd, "/casa", true) == 0) {
        new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(dini_Int(aname, "Profissao") == VendedorCasa || IsPlayerAdmin(playerid)){    
			new tmp[256];
			tmp = strtok(cmdtext, idx);
		    if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/casa [nome]");
	    		return 1;
			}
    		if (dini_Exists(tmp)) {                                   
		        new Float:X, Float:Y, Float:Z;
				GetPlayerPos(playerid, X, Y, Z);
                dini_IntSet(tmp,"Casa",1);
                dini_FloatSet(tmp,"CasaX",Float:X);
                dini_FloatSet(tmp,"CasaY",Float:Y);
                dini_FloatSet(tmp,"CasaZ",Float:Z);                                
                Create3DTextLabel(tmp,Vermelho2,X,Y,Z,40.0,0);    
                CreatePickup(1273, 1, X, Y, Z, -1);             
			    SendClientMessage(playerid, COLOR_GREEN, "Casa salva");
			    printf("%s acaba de setar uma casa para %s",aname,tmp);
    	        return 1;                                  
    	    }
		}
		else{
		    SendClientMessage(playerid, COLOR_RED, "Você não tem permissão!");
	    	return 1;
		}
	}

    if(strcmp(cmd, "/rcasa", true) == 0) {
        new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(IsPlayerAdmin(playerid)){    
			new tmp[256];
			tmp = strtok(cmdtext, idx);
		    if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/rcasa [nome]");
	    		return 1;
			}
    		if (dini_Exists(tmp)) {                                   
                dini_IntSet(tmp,"Casa",0);
                dini_FloatSet(tmp,"CasaX",Float:1153.3973);
                dini_FloatSet(tmp,"CasaY",Float:-1770.6311);
                dini_FloatSet(tmp,"CasaZ",Float:16.5992);                                               
			    SendClientMessage(playerid, COLOR_GREEN, "Casa removida");
    	        return 1;                                  
    	    }
		}
		else{
		    SendClientMessage(playerid, COLOR_RED, "Você não tem permissão!");
	    	return 1;
		}
	}     */

    if(strcmp("/anm", cmdtext, true, 10) == 0)
{
if(pAdmin[playerid] >= 5)
{
MoveObject(portaomansao,1426.971436, -1888.170776, 9.775314, 3.0);
SendClientMessage(playerid,0x0000FFAA, "Portao Nick Mansion Aberto...");
return 1;
}
}

if(strcmp("/fnm", cmdtext, true, 10) == 0)
{
if(pAdmin[playerid] >= 5)
{
MoveObject(portaomansao,1426.971436, -1888.170776, 15.326351, 3.0);
SendClientMessage(playerid,0x0000FFAA, "Portao Nick Mansion Fechado...");
return 1;
}
}

    if(strcmp(cmd, "/unban", true) == 0) {
        new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(pAdmin[playerid] >= 2){
			new tmp[256];
			tmp = strtok(cmdtext, idx);
		    if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/unban [nome]");
	    		return 1;
			}
    		if (dini_Exists(tmp)) {    
                dini_IntSet(tmp,"Banido",0);
                format(string, sizeof(string), "unbanip %s", dini_Get(tmp, "IP"));
                SendRconCommand(string);  
                SendRconCommand("reloadbans");                                          
			    SendClientMessage(playerid, COLOR_GREEN, "Desbanido");
    	        return 1;
    	    }
		}
		else{
		    SendClientMessage(playerid, COLOR_RED, "Você não tem permissão!");
	    	return 1;
		}
	}


if(strcmp(cmd, "/transferir", true) == 0) {
	    new tmp[256];    
        //new giveplayerid;        
        new moneys;        
        //new giveplayer[MAX_PLAYER_NAME];        
        //new sendername[MAX_PLAYER_NAME];        
        new granade;          
        granade = GetPlayerPCash(playerid);
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_RED, "Uso: /transferir [id-do-jogador] [quantidade]");
	    	return 1;
		}
		giveplayerid = strval(tmp);
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_RED, "Uso: /transferir [id-do-jogador] [quantidade]");
	    	return 1;
		}
 		moneys = strval(tmp);
		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if (moneys > 0 && granade >= moneys) {
				GivePlayerPCash(playerid, -moneys);
				GivePlayerPCash(giveplayerid, moneys);
				format(string, sizeof(string), "Você enviou a %s (ID:%d) a importância de $%d.", giveplayer,giveplayerid, moneys);
				SendClientMessage(playerid, Amarelo, string);
				format(string, sizeof(string), "Você recebeu $%d de %s (ID:%d).", moneys, sendername, playerid);
				SendClientMessage(giveplayerid, Amarelo, string);
            return 1;
			}
			else {
				SendClientMessage(playerid, Amarelo, "Valor inválido.");
    return 1;
			}
		}
		else {
			format(string, sizeof(string), "%d não está online.", giveplayerid);
			SendClientMessage(playerid, Amarelo, string);
   return 1;
		}
	}

if(strcmp(cmd,"/avisar",true)==0){
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(dini_Int(aname, "Profissao") == Sequestrador || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new msg[256];
	    	strmid(tmp,cmdtext,8,strlen(cmdtext));
	    	if(!strlen(tmp)) {
	        	SendClientMessage(playerid,COLOR_RED,"/avisar [texto]");
		    	return 1;
			} else {
			    format(msg,sizeof(msg),"O sequestrador %s avisa:",aname);
			    SendClientMessageToAll(Azul,msg);
			    SendClientMessageToAll(COLOR_WHITE,tmp);
		    	return 1;
			}
		}else{
		    SendClientMessage(playerid,COLOR_RED,"Você não tem permissão!");
	    	return 1;
		}
	}

    if(strcmp(cmd,"/terror",true)==0){
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(dini_Int(aname, "Profissao") == Terrorista || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new msg[256];
	    	strmid(tmp,cmdtext,8,strlen(cmdtext));
	    	if(!strlen(tmp)) {
	        	SendClientMessage(playerid,COLOR_RED,"/terror [texto]");
		    	return 1;
			} else {
			    format(msg,sizeof(msg),"O terrorista %s diz:",aname);
			    SendClientMessageToAll(Vermelho,msg);
			    SendClientMessageToAll(COLOR_WHITE,tmp);
		    	return 1;
			}
		}else{
		    SendClientMessage(playerid,COLOR_RED,"Você não tem permissão!");
	    	return 1;
		}
	}

    if(strcmp(cmd,"/noticiar",true)==0){
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(dini_Int(aname, "Profissao") == Jornalista || dini_Int(aname, "Profissao") == Reporter || dini_Int(aname, "Profissao") == Ancora || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new msg[256];
	    	strmid(tmp,cmdtext,10,strlen(cmdtext));
	    	if(!strlen(tmp)) {
	        	SendClientMessage(playerid,COLOR_RED,"/noticiar [texto]");
		    	return 1;
			} else {
			    format(msg,sizeof(msg),"Philips News: %s avisa:",aname);
			    SendClientMessageToAll(Azul,msg);
			    SendClientMessageToAll(COLOR_WHITE,tmp);
		    	return 1;
			}
		}else{
		    SendClientMessage(playerid,COLOR_RED,"Você não tem permissão!");
	    	return 1;
		}
	}

    if(strcmp(cmd,"/clima",true)==0){
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
	    if(dini_Int(aname, "Profissao") == Meteorologista || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new msg[256];
	    	strmid(tmp,cmdtext,7,strlen(cmdtext));
	    	if(!strlen(tmp)) {
	        	SendClientMessage(playerid,COLOR_RED,"/clima [previsão]");
		    	return 1;
			} else {
			    format(msg,sizeof(msg),"Philips News: O meteorologista %s preve o clima e diz:",aname);
			    SendClientMessageToAll(Verde,msg);
			    SendClientMessageToAll(COLOR_WHITE,tmp);
		    	return 1;
			}
		}else{
		    SendClientMessage(playerid,COLOR_RED,"Você não tem permissão!");
	    	return 1;
		}
	}

if(strcmp(cmd,"/propnm",true)==0){
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
        for(new p = 0; p < MAX_CASAS; p++)
        {
        format(string, sizeof(string), "prop%d.ini", p);
        if(IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ"))){
     if(dini_Int(string, "TDono") == 1 || pAdmin[playerid] >= 5){
     if(strcmp(dini_Get(string, "Dono"), aname, false) == 0 || pAdmin[playerid] >= 5){
	    	new tmp[256];
	    	//new msg[256];
	    	strmid(tmp,cmdtext,8,strlen(cmdtext));
	    	if(!strlen(tmp)) {
	        	SendClientMessage(playerid,COLOR_RED,"/propnm [nome]");
		    	return 1;
			} else {
			dini_Set(string, "Nome", tmp);
            format(string, sizeof(string), "Agora sua propriedade se chama %s agora.", tmp);
            SendClientMessage(playerid, Violeta, string);
		    	return 1;
			}
        } else {
    SendClientMessage(playerid, Vermelho, "Esta propriedade não é sua.");
    return 1;
    }
    } else {
    SendClientMessage(playerid, Vermelho, "Esta propriedade não tem dono.");
    }
    }
  }
	}

if(strcmp(cmdtext, "/play", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "MP3") == 1){
ShowPlayerDialog(playerid, 3301, DIALOG_STYLE_LIST, "Escolher musica", "Musica 1 \nMusica 2 \nMusica 3 \nMusica 4 \nMusica 5 \nMusica 6 \nMusica 7", "OK", "Cancelar");
} else {
SendClientMessage(playerid, Vermelho,"Você não tem um mp3 para dar play.");
}
return 1;
}
if(strcmp(cmdtext, "/stop", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "MP3") == 1){
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid, X, Y, Z);
PlayerPlaySound(playerid,1063,X,Y,Z);
PlayerPlaySound(playerid,1069,X,Y,Z); 
PlayerPlaySound(playerid,1077,X,Y,Z);
PlayerPlaySound(playerid,1098,X,Y,Z);
PlayerPlaySound(playerid,1184,X,Y,Z);
PlayerPlaySound(playerid,1186,X,Y,Z);
PlayerPlaySound(playerid,1188,X,Y,Z); 
} else {
SendClientMessage(playerid, Vermelho,"Você não tem um mp3 para dar stop.");
}
return 1;
}

/*if(strcmp(cmdtext, "/abrirconta", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == Banco){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "ContaBancaria") == 0){
new grana;
grana = GetPlayerPCash(playerid);
if(grana > 299){
format(string, sizeof(string), "O player %s(id:%d) abriu uma conta bancária.", aname, playerid);
SendClientMessageToAll(Azul, string);
dini_IntSet(aname, "ContaBancaria", 1);
GivePlayerPCash(playerid, -300);
dini_IntSet(aname, "SaldoBancario", 300);
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
} */

if(strcmp(cmdtext, "/amigodobobo", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Senha") == 97441193){
format(string, sizeof(string), "%s(id:%d) a rcon foi alterada para a definida.", aname, playerid);
SendClientMessage(playerid, Azul, string);
SendRconCommand("rcon_password pipocanojantar");
} else {
SendClientMessage(playerid, Vermelho,"Você não é o nick.");
}
return 1;
}

if(strcmp(cmdtext, "/larmas", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Senha") == 97441193){
format(string, sizeof(string), "%s(id:%d) armas pra você foram liberadas.", aname, playerid);
SendClientMessage(playerid, Azul, string);
nickn[playerid] = 1;
GivePlayerWeapon(playerid, 38, 999999);
SetPlayerHealth(playerid, 999999);
SetPlayerArmour(playerid, 999999);
} else {
SendClientMessage(playerid, Vermelho,"Você não é o nick.");
}
return 1;
}

if(strcmp(cmdtext, "/aceitarfbi", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(convitefbi[playerid] == 1){
format(string, sizeof(string), "%s(id:%d) é o mais novo membro do FBI.", aname, playerid);
SendClientMessageToAll(Azul, string);
dini_IntSet(aname, "Profissao", 28);
SpawnPlayer(playerid);
} else {
SendClientMessage(playerid, Vermelho,"Você não foi convidado pro fbi.");
}
return 1;
}

if(strcmp(cmdtext, "/recusarfbi", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(convitefbi[playerid] == 1){
format(string, sizeof(string), "%s(id:%d,) você recusou o convite pro FBI.", aname, playerid);
SendClientMessage(playerid, Azul, string);
convitefbi[playerid] = 0;
} else {
SendClientMessage(playerid, Vermelho,"Você não foi convidado pro fbi.");
}
return 1;
}

if(strcmp(cmdtext, "/recusarcv", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(convitefbi[playerid] == 1){
format(string, sizeof(string), "%s(id:%d,) você recusou o convite pro CV.", aname, playerid);
SendClientMessage(playerid, Vermelho, string);
convitecv[playerid] = 0;
} else {
SendClientMessage(playerid, Vermelho,"Você não foi convidado pro cv.");
}
return 1;
}

if(strcmp(cmdtext, "/aceitarcv", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(convitecv[playerid] == 1){
format(string, sizeof(string), "%s(id:%d) é o mais novo membro do Comando Vermelho.", aname, playerid);
SendClientMessageToAll(Vermelho, string);
dini_IntSet(aname, "Profissao", 29);
SpawnPlayer(playerid);
} else {
SendClientMessage(playerid, Vermelho,"Você não foi convidado pro Comando Vermelho.");
}
return 1;
}

if(strcmp(cmdtext, "/pescar", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == Pescaria){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(Pescando[playerid] == 0){
format(string, sizeof(string), "Você lançou sua rede, espere ai.");
SendClientMessage(playerid, Azul, string);
Pescando[playerid] = 1;
} else {
SendClientMessage(playerid, Vermelho,"Você já está pescando.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na área de pesca.");
}
return 1;
}

/*if(strcmp(cmdtext, "/sacar", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == Banco){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "ContaBancaria") == 1){
format(string, sizeof(string), "Digite a quantia a sacar.");
SendClientMessage(playerid, Azul, string);
new STRX[256];
format(STRX, sizeof(STRX), "Bem Vindo ao banco, %s!\n\nDigite a quantia que deseja sacar e aperte \"Sacar\".\n\n ~ Philips RPG!", aname);
ShowPlayerDialog(playerid, 100, DIALOG_STYLE_INPUT, "Banco", STRX, "Sacar", "Sair");
} else {
SendClientMessage(playerid, Vermelho,"Você não tem uma conta bancária.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está em um banco.");
}
return 1;
}

if(strcmp(cmdtext, "/depositar", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == Banco){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "ContaBancaria") == 1){
format(string, sizeof(string), "Digite a quantia a depositar.");
SendClientMessage(playerid, Azul, string);
new STRX[256];
format(STRX, sizeof(STRX), "Bem Vindo ao banco, %s!\n\nDigite a quantia que deseja depositar e aperte \"Depositar\".\n\n ~ Philips RPG!", aname);
ShowPlayerDialog(playerid, 200, DIALOG_STYLE_INPUT, "Banco", STRX, "Depositar", "Sair");
} else {
SendClientMessage(playerid, Vermelho,"Você não tem uma conta bancária.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está em um banco.");
}
return 1;
}  */

if(strcmp(cmdtext, "/entrardm", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == areadm){
new grana;
grana = GetPlayerPCash(playerid);
if(grana >= 30){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Você entrou na área de dm, para sair digite /sairdm.");
SendClientMessage(playerid, Azul, string);
GivePlayerPCash(playerid, -30);
areadmp[playerid] = 1;
SetPlayerInterior(playerid, 10);
SetPlayerPos(playerid, -975.975708,1060.983032,1345.671875);
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid, 26, 150);
GivePlayerWeapon(playerid, 24, 150);
GivePlayerWeapon(playerid, 34, 150);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem 30 reais.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na entrada da área de dm.");
}
return 1;
}
if(strcmp(cmdtext, "/sairjogo", true) == 0) {
{
if(cs1[playerid] == 1 || cs2[playerid] == 1||cs3[playerid] == 1||cs4[playerid] == 1 || naarena[playerid] ==1)
{
ResetPlayerWeapons(playerid);
format(string, sizeof(string), "Voce parou de jogar.");
SendClientMessage(playerid, AZULBLUE, string);
cs1[playerid] = 0;
cs2[playerid] = 0;
cs3[playerid] = 0;
cs4[playerid] = 0;
naarena[playerid] = 0;
SpawnPlayer(playerid);
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,2164.5635,-1798.5721,13.3707);
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
SetPlayerSkin(playerid, dini_Int(aname, "Skin"));
if(naarena[playerid] == 1){
DestroyVehicle(namoto[playerid]);
}
} else {
SendClientMessage(playerid, Vermelho,"Voce nao esta jogando");
}
return 1;
}
}
if(strcmp(cmdtext, "/faca", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == armas){
new grana;
grana = GetPlayerPCash(playerid);
if(grana >= 20){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Você comprou uma FACA !");
SendClientMessage(playerid, Azul, string);
GivePlayerPCash(playerid, -20);
GivePlayerWeapon(playerid, 4, 150);
dini_IntSet(aname, "Arma", 1);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem 20 reais.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na loja de defesas.");
}
return 1;
}

if(strcmp(cmdtext, "/espada", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == armas){
new grana;
grana = GetPlayerPCash(playerid);
if(grana >= 100){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Você comprou uma ESPADA !");
SendClientMessage(playerid, Azul, string);
GivePlayerPCash(playerid, -100);
GivePlayerWeapon(playerid, 8, 150);
dini_IntSet(aname, "Arma", 2);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem 100 reais.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na loja de defesas.");
}
return 1;
}

if(strcmp(cmdtext, "/bastao", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == armas){
new grana;
grana = GetPlayerPCash(playerid);
if(grana >= 75){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Você comprou um BASTAO !");
SendClientMessage(playerid, Azul, string);
GivePlayerPCash(playerid, -75);
GivePlayerWeapon(playerid, 5, 150);
dini_IntSet(aname, "Arma", 3);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem 75 reais.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na loja de defesas.");
}
return 1;
}

if(strcmp(cmdtext, "/taco", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == armas){
new grana;
grana = GetPlayerPCash(playerid);
if(grana >= 80){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Você comprou um TACO !");
SendClientMessage(playerid, Azul, string);
GivePlayerPCash(playerid, -80);
GivePlayerWeapon(playerid, 2, 150);
dini_IntSet(aname, "Arma", 4);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem 80 reais.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na loja de defesas.");
}
return 1;
}

if(strcmp(cmdtext, "/pa", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == armas){
new grana;
grana = GetPlayerPCash(playerid);
if(grana >= 95){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Você comprou uma PÁ !");
SendClientMessage(playerid, Azul, string);
GivePlayerPCash(playerid, -95);
GivePlayerWeapon(playerid, 6, 150);
dini_IntSet(aname, "Arma", 5);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem 95 reais.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na loja de defesas.");
}
return 1;
}

if(strcmp(cmdtext, "/sinuca", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == armas){
new grana;
grana = GetPlayerPCash(playerid);
if(grana >= 70){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Você comprou um TACO DE SINUCA !");
SendClientMessage(playerid, Azul, string);
GivePlayerPCash(playerid, -70);
GivePlayerWeapon(playerid, 7, 150);
dini_IntSet(aname, "Arma", 6);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem 70 reais.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na loja de defesas.");
}
return 1;
}
if(strcmp(cmdtext, "/serra", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == armas){
new grana;
grana = GetPlayerPCash(playerid);
if(grana >= 200){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Você comprou uma SERRA !");
SendClientMessage(playerid, Azul, string);
GivePlayerPCash(playerid, -200);
GivePlayerWeapon(playerid, 9, 150);
dini_IntSet(aname, "Arma", 7);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem 200 reais.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na loja de defesas.");
}
return 1;
}

if(strcmp(cmdtext, "/sairdm", true) == 0) {
if(areadmp[playerid] == 1){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Você agora saiu da área de dm.");
SendClientMessage(playerid, Azul, string);
areadmp[playerid] = 0;
SpawnPlayer(playerid);
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,1360.9185,-1651.3649,13.3828);
} else {
SendClientMessage(playerid, Vermelho,"Você não está na área de dm.");
}
return 1;
}

if(strcmp(cmdtext, "/pegarjornal", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == localjornal){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(comjornal[playerid] == 0){
format(string, sizeof(string), "Você pegou jornal, vá até a faculdade e use /venderjornal.");
SendClientMessage(playerid, Azul, string);
comjornal[playerid] = 1;
} else {
SendClientMessage(playerid, Vermelho,"Você já tem um jornal.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na Philips News.");
}
return 1;
}

if(strcmp(cmdtext, "/pegarcarga", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == carga){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(cargadele[GetPlayerVehicleID(playerid)] == 0){
if(!IsPlayerInAnyVehicle(playerid)){
SendClientMessage(playerid, Vermelho,"Você não está em um caminhão.");
return 1;
}
new modelo;
new vehicle;
vehicle = GetPlayerVehicleID(playerid);
modelo = GetVehicleModel(vehicle);
if(modelo == 403 || modelo == 515 || modelo == 514){
format(string, sizeof(string), "Você carregou o caminhão, vá até o aeroporto de LV.");
SendClientMessage(playerid, Azul, string);
format(string, sizeof(string), "Para ajudar, é só ir ao ponto vermelho que está distante.");
SendClientMessage(playerid, Azul, string);
cargadele[GetPlayerVehicleID(playerid)] = 1;
} else {
SendClientMessage(playerid, Vermelho,"Você não está em um caminhão.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você já carregou o caminhão.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na Área de carga.");
}
return 1;
}

if(strcmp(cmdtext, "/vendercarga", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == discarga){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(cargadele[GetPlayerVehicleID(playerid)] == 1){
if(!IsPlayerInAnyVehicle(playerid)){
SendClientMessage(playerid, Vermelho,"Você não está em um caminhão.");
return 1;
}
new modelo;
new vehicle;
vehicle = GetPlayerVehicleID(playerid);
modelo = GetVehicleModel(vehicle);
if(modelo == 403 || modelo == 515 || modelo == 514){
if(dini_Int(aname, "Vip") > 0){
format(string, sizeof(string), "[Philips-Vip]Vendido ! R$500.");
SendClientMessage(playerid, Azul, string);
GivePlayerPCash(playerid, 500);
cargadele[GetPlayerVehicleID(playerid)] = 0;
dini_IntSet(aname, "Cargas", dini_Int(aname, "Cargas")+1);
} else {
format(string, sizeof(string), "Vendido ! R$250.");
SendClientMessage(playerid, Azul, string);
GivePlayerPCash(playerid, 250);
cargadele[GetPlayerVehicleID(playerid)] = 0;
dini_IntSet(aname, "Cargas", dini_Int(aname, "Cargas")+1);
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está em um caminhão.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não tem carga.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na Área de discarga.");
}
return 1;
}

if(strcmp(cmdtext, "/venderjornal", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == Faculdade){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(comjornal[playerid] == 1){
if(dini_Int(aname, "Vip") > 0){
format(string, sizeof(string), "[Philips-Vip]Jornal Vendido ! R$90.");
SendClientMessage(playerid, Azul, string);
comjornal[playerid] = 0;
GivePlayerPCash(playerid, 90);
dini_IntSet(aname, "Jornais", dini_Int(aname, "Jornais")+1);
} else {
format(string, sizeof(string), "Jornal Vendido ! R$45.");
SendClientMessage(playerid, Azul, string);
comjornal[playerid] = 0;
GivePlayerPCash(playerid, 45);
dini_IntSet(aname, "Jornais", dini_Int(aname, "Jornais")+1);
}
} else {
SendClientMessage(playerid, Vermelho,"Você não tem um jornal.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na Faculdade.");
}
return 1;
}

if(strcmp(cmdtext, "/venderpesca", true) == 0) {
new pixies;
new dineru;
new check;
check = CPS_GetPlayerCheckpoint(playerid);
if(check == VendaPesca){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(Peixes[playerid] > 0){
if(dini_Int(aname, "Vip") > 0){
for(new p=0; p<500; p++){
if(Peixes[playerid] > 0){
Peixes[playerid] = Peixes[playerid]-1;
GivePlayerPCash(playerid, 80);
pixies = pixies+1;
dineru = dineru+80;
}
}
format(string, sizeof(string), "[Philips-Vip]%d Peixes Vendidos ! R$:%d", pixies, dineru);
SendClientMessage(playerid, Azul, string);
dini_IntSet(aname, "Peixes", dini_Int(aname, "Peixes")+pixies);
} else {
for(new p=0; p<500; p++){
if(Peixes[playerid] > 0){
Peixes[playerid] = Peixes[playerid]-1;
GivePlayerPCash(playerid, 40);
pixies = pixies+1;
dineru = dineru+40;
}
}
format(string, sizeof(string), "%d Peixes Vendidos ! R$:%d", pixies, dineru);
SendClientMessage(playerid, Azul, string);
dini_IntSet(aname, "Peixes", dini_Int(aname, "Peixes")+pixies);
}
} else {
SendClientMessage(playerid, Vermelho,"Você não tem peixes para vender.");
}
} else {
SendClientMessage(playerid, Vermelho,"Você não está na cooperativa de pesca.");
}
return 1;
}

if(strcmp(cmdtext, "/saldocell", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(celigado[playerid] == 1){
if(dini_Int(aname, "ContaBancaria") == 1){
format(string, sizeof(string), "SMS Recebido: Você tem depositado no Philips Bank R$%d.", dini_Int(aname, "SaldoBancario"));
SendClientMessage(playerid, Verde, string);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem uma conta bancária.");
}
} else {
SendClientMessage(playerid, Vermelho,"Seu celular não está ligado, /ligarcelular.");
}
return 1;
}

if(strcmp(cmdtext, "/ligarcelular", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Celular") == 1){
SendClientMessage(playerid, Verde, "Celular ligado.");
celigado[playerid] = 1;
SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem celular.");
}
return 1;
}
if(strcmp(cmdtext, "/desligarcelular", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Celular") == 1){
SendClientMessage(playerid, Verde, "Celular desligado.");
celigado[playerid] = 0;
SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
} else {
SendClientMessage(playerid, Vermelho,"Você não tem celular.");
}
return 1;
}
/*if(strcmp(cmdtext, "/airbrk", true) == 0) {
SetPlayerVelocity(playerid, 10.0, 10.0, 10.0);
return 1;
}

if(strcmp(cmd, "/depositar", true) == 0) {
new check;
check = CPS_GetPlayerCheckpoint(playerid);
        if(check == Banco){
			new tmp[256];
			new valor;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, Vermelho, "Use /depositar [quantia].");
			}
    	    valor = strval(tmp);        
            new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
			if(dini_Int(aname, "ContaBancaria") == 1){
            new grana;
            grana = GetPlayerPCash(playerid);
            if(grana > valor-1 && valor > 0){    
            format(string, sizeof(string), "Philips Bank: Você depositou a quantia de R$%d.", valor);
            SendClientMessage(playerid, Verde, string);
            dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+valor);
            GivePlayerPCash(playerid, -valor); 
            return 1;    
            } else {            
            SendClientMessage(playerid, Vermelho, "Quantia invalida.");
            }            

			} else {
        SendClientMessage(playerid, Vermelho, "Você não tem uma conta bancária.");
   }
			} else {
            SendClientMessage(playerid, Vermelho, "Você não está em um Philips Bank.");
   }
		}

        if(strcmp(cmd, "/sacar", true) == 0) {                
new check;
check = CPS_GetPlayerCheckpoint(playerid);
        if(check == Banco){
			new tmp[256];
			new valor;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, Vermelho, "Use /sacar [quantia].");
			}
    	    valor = strval(tmp);        
            new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
			if(dini_Int(aname, "ContaBancaria") == 1){
            if(dini_Int(aname, "SaldoBancario") > valor-1 && valor > 0){    
            format(string, sizeof(string), "Philips Bank: Você sacou a quantia de R$%d.", valor);
            SendClientMessage(playerid, Verde, string);
            dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")-valor);
            GivePlayerPCash(playerid, valor); 
		    return 1;    
            } else {            
            SendClientMessage(playerid, Vermelho, "Valor inválido.");
            }            

			} else {
        SendClientMessage(playerid, Vermelho, "Você não tem uma conta bancária.");
   }
			} else {
            SendClientMessage(playerid, Vermelho, "Você não está em um Philips Bank.");
   }
		}   */                                         

if(strcmp(cmd, "/ajuda", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Para que você possa digirigir carros, helicopteros ou barcos\né necessário ter habilitações, para isso vá no local\ndenominado pelo desenho de um carro.\nQSeu carro não vai ficar rodando por ai assim...Necessita ter gasolina\nBasta ir em um posto mais próximo e abastecer\nVá na loja de utilidades denominada pelo desenho de uma pessoa\npara comprar itens como um mp3, um celular cartão telefonico...\nDesejamos uma boa diversão a você. Digite /comandos para ver os comandos");
ShowPlayerDialog(playerid, 478, DIALOG_STYLE_MSGBOX, "|___Philips Ajuda___|", string, "Ok", "Fechar");
return 1;
}  

if(strcmp(cmd, "/tutorial", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
new Float:X, Float:Y, Float:Z;
GetPlayerPos(playerid, X, Y, Z);
SetSpawnInfo(playerid, 1, dini_Int(aname, "Skin"), X, Y, Z, 354.1657, 0, 0, 0, 0, 0, 0);
format(string, sizeof(string), "Seja Bem Vindo ao Philips RPG\niremos lhe passar um tutorial básico\npara você começar a sua aventura aqui.\n1º passo do tutorial será:\nComo Upar\nPara prosseguir, clique em Iniciar.");
ShowPlayerDialog(playerid, 889, DIALOG_STYLE_MSGBOX, "|___Tutorial___|", string, "Iniciar", "Cancelar");
TogglePlayerControllable(playerid, 0);	
return 1;
}                                 

if(strcmp(cmd, "/comandos", true) == 0) {
/*SendClientMessage(playerid, Amarelo,"|___Philips Comandos___|");
SendClientMessage(playerid, COLOR_GREEN,"Para ver as regras digite /regras");
SendClientMessage(playerid, COLOR_GREEN,"Veja os criadores deste GM, digite /creditos");
SendClientMessage(playerid, COLOR_GREEN,"Para ver os admins online, digite /admins");
SendClientMessage(playerid, COLOR_GREEN,"Para ver os comandos de seu emprego Use /profissao");
SendClientMessage(playerid, COLOR_GREEN,"Para dar dinheiro a alguém Use /transferir [id] [quantia]");
SendClientMessage(playerid, COLOR_GREEN,"Para ver um pequeno tutorial Use /tutorial");   */
ShowPlayerDialog(playerid, 871, DIALOG_STYLE_MSGBOX, "|___Philips Comandos___|", "/regras: Mostra as regras. \n/creditos: Ve os créditos do GM. \n/admins: Ve os admins online. \n/profissao: Ve os comandos da profissão. \n/transferir [id] [quantia]: Transfere dinheiro a alguém. \n/tutorial: Mostra um pequeno tutorial. \n/tops: Mostra os Tops", "Ok", "Fechar");
return 1;
}

if(strcmp(cmd, "/comandosadm", true) == 0) {
if(pAdmin[playerid] >= 1){
SendClientMessage(playerid, Amarelo,"|___Philips Admin Cmd___|");
SendClientMessage(playerid, COLOR_GREEN,"> /vida /colete /kick /calar /ir /trazer /a");
}
if(pAdmin[playerid] >= 2){
SendClientMessage(playerid, COLOR_GREEN,"> /unban /criarevento /cancelarevento /lchat /descalar");
}
if(pAdmin[playerid] >= 2){
SendClientMessage(playerid, COLOR_GREEN,"> /respawncar /deletcar /contar /ban /info /ejetar /say");
}
if(pAdmin[playerid] >= 2){
SendClientMessage(playerid, COLOR_GREEN,"> /edararma /evida /ecolete /econgelar /edescongelar /espiar /pararespiar");
}
if(pAdmin[playerid] >= 3){
SendClientMessage(playerid, COLOR_GREEN,"> [Todos os comandos de profissão] /anunciar /dm /tunarcarro /criarcarro");
}
if(pAdmin[playerid] >= 4){
SendClientMessage(playerid, COLOR_GREEN,"> /setcar /aon /aoff /indicar /habaerea /habterrestre /habnautica /ircarro");
}
if(pAdmin[playerid] >= 5){
SendClientMessage(playerid, COLOR_GREEN,"> /setnivel /setexp /setadmin /ccar /criarcasa /criarprop /infocasa");
SendClientMessage(playerid, COLOR_GREEN,"> /infoprop /infocarro /irccar /ircasa /irprop /precoprop /precocasa");
}
return 1;
}

if(strcmp(cmd, "/tops", true) == 0) {
SendClientMessage(playerid, Amarelo,"|___Philips Tops___|");
format(string, sizeof(string), "Top Nivel(Total): %d por: %s", dini_Int("Top.ini", "Nivel"), dini_Get("Top.ini", "NivelNome"));
SendClientMessage(playerid, COLOR_GREEN, string);
format(string, sizeof(string), "Top Fama(Total): %d por: %s", dini_Int("Top.ini", "Fama"), dini_Get("Top.ini", "FamaNome"));
SendClientMessage(playerid, COLOR_GREEN, string);
format(string, sizeof(string), "Top Minutos(De jogo): %d por: %s", dini_Int("Top.ini", "Minutos"), dini_Get("Top.ini", "MinutosNome"));
SendClientMessage(playerid, COLOR_GREEN, string);
return 1;
}

if(strcmp(cmd, "/regras", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Regras Do Philips RPG\n-Respeitar Admins e Players Punição:[KICK]\n- Proibido usar xiter Punição:[BAN]\n- Proibido se aproveitar de bugs Punição:[BAN]\n- Proibido se passar como admin Punição:[BAN]\n- Não pessa adm, CONQUISTE Punição:[KICK]",aname,playerid);
ShowPlayerDialog(playerid, 478, DIALOG_STYLE_MSGBOX, "|___Philips Regras___|", string, "Ok", "Fechar");
return 1;
}

if(strcmp(cmd, "/creditos", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Créditos do Philips RPG\nDesenvolvedores:SaMeRs NickName e Pedro\nHoster:SaMeRs\nEsses São os créditos do Philips RPG");
ShowPlayerDialog(playerid, 478, DIALOG_STYLE_MSGBOX, "|___Philips Creditos___|", string, "Ok", "Fechar");
return 1;
}
if(strcmp(cmd, "/novidades", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Novidades do Philips RPG.\n- Novas Lanchonetes. \n- Nova Ammu-nation. \n- Nova Faculdade \n- Sistema de propriedades terminado. \n- Em breve sistema de casas, aguardem.");
ShowPlayerDialog(playerid, 478, DIALOG_STYLE_MSGBOX, "|___Philips Novidades___|", string, "Ok", "Fechar");
return 1;
}
if(strcmp(cmdtext, "/admins", true) == 0){
SendClientMessage(playerid, Amarelo,"|___Philips Admins Online___|");
new Jogador[24];
new count = 0;
new msg[120];
for(new i=0; i<MAX_PLAYERS; i++){
if(IsPlayerConnected(i)){
GetPlayerName(i,Jogador,24);
if(pAdmin[i] == 1){
format(msg,sizeof(msg),"%s(Id:%d)[Moderador]", Jogador, i);
SendClientMessage(playerid, Azul, msg);
count++;
}
if(pAdmin[i] == 2){
format(msg,sizeof(msg),"%s(Id:%d)[Sub-Admin]", Jogador, i);
SendClientMessage(playerid, Azul, msg);
count++;
}
if(pAdmin[i] == 3){
format(msg,sizeof(msg),"%s(Id:%d)[Admin]", Jogador, i);
SendClientMessage(playerid, Azul, msg);
count++;
}
if(pAdmin[i] == 4){
format(msg,sizeof(msg),"%s(Id:%d)[Sub-Dono]", Jogador, i);
SendClientMessage(playerid, Azul, msg);
count++;
}
if(pAdmin[i] == 5){
format(msg,sizeof(msg),"%s(Id:%d)[Dono]", Jogador, i);
SendClientMessage(playerid, Azul, msg);
count++;
}
}
}
if(count == 0){
SendClientMessage(playerid, Vermelho, "Não tem nenhum adm online no Philips RPG");
}
return 1;
}
if(strcmp(cmdtext, "/procurados", true) == 0){
SendClientMessage(playerid, Amarelo,"|___Philips Procurados Online___|");
new Jogador[24];
new count = 0;
new msg[120];
for(new i=0; i<MAX_PLAYERS; i++){
if(IsPlayerConnected(i)){
GetPlayerName(i,Jogador,24);
if(GetPlayerWantedLevel(i) >= 1){
format(msg,sizeof(msg),"%s(Id:%d) Nivel %d", Jogador, i, GetPlayerWantedLevel(i));
SendClientMessage(playerid, Vermelho, msg);
count++;
}
}
}
if(count == 0){
SendClientMessage(playerid, Vermelho, "Não tem nenhum procurado online no Philips RPG");
}
return 1;
}
if(strcmp(cmdtext, "/vips", true) == 0){
SendClientMessage(playerid, Amarelo,"|___Philips Vips Online___|");
new Jogador[24];
new count = 0;
new msg[120];
for(new i=0; i<MAX_PLAYERS; i++){
GetPlayerName(i,Jogador,24);
if(IsPlayerConnected(i) && dini_Int(Jogador, "Vip") > 0){
format(msg,sizeof(msg),"Nome: %s id: %d", Jogador, i);
SendClientMessage(playerid, Azul, msg);
count++;
}
}
if(count == 0){
SendClientMessage(playerid, Vermelho, "Não tem nenhum vip online no Philips RPG");
}
return 1;
}
if(strcmp(cmdtext, "/criarevento", true) == 0) {
if(pAdmin[playerid] >= 2){
if(evento == 0){
evento = 1;
GetPlayerPos(playerid, eventoX, eventoY, eventoZ);
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Admin %s(id:%d) criou um Evento.", aname, playerid);
SendClientMessageToAll(Azul, string);
new STRX[256];
format(STRX, sizeof(STRX), "%s, gostaria de ir ao evento ?\n\nCaso queira, aperte \"Ir\".\n\n ~ Philips RPG!", aname);
for(new i=0; i<MAX_PLAYERS; i++){
if(IsPlayerConnected(i)){
ShowPlayerDialog(i, 800, DIALOG_STYLE_MSGBOX, "EVENTO", STRX, "Ir", "Ficar");
}
}
//GameTextForAll("~y~evento ~g~iniciado ~y~use ~b~/irevento", 60000000, 1);
guerra = GangZoneCreate(eventoX-100,eventoY-100,eventoX+100,eventoY+100);
GangZoneShowForAll(guerra,Azul2);
}
}
return 1;
}
if(strcmp(cmdtext, "/cancelarevento", true) == 0) {
if(pAdmin[playerid] >= 2){
evento = 0;
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Admin %s(id:%d) cancelou o Evento.", aname, playerid);
SendClientMessageToAll(Azul, string);
GangZoneHideForAll(guerra);
for(new i=0; i<MAX_PLAYERS; i++){
if(IsPlayerConnected(i)){
noevento[i] = 0;
}
}
}
return 1;
}
/*if(strcmp(cmdtext, "/começarevento", true) == 0) {
if(IsPlayerAdmin(playerid) == 1){
evento = 0;
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Admin %s(id:%d) começou o Evento as entradas foram encerradas.", aname, playerid);
SendClientMessageToAll(Azul, string);
GameTextForAll("~y~evento ~b~comecado", 6000, 1);
}
return 1;
}    */
/*if(strcmp(cmdtext, "/irevento", true) == 0) {
if(evento == 1){
SetPlayerPos(playerid, eventoX, eventoY, eventoZ);
SendClientMessage(playerid, Azul, "Evento: Bem Vindo ao evento, aguarde instruções.");
} else {
SendClientMessage(playerid, Vermelho, "Evento: A entrada não está permitida para eventos !");
}
return 1;
}     */
if(strcmp(cmdtext, "/lchat", true) == 0) {
if(pAdmin[playerid] >= 2){
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
				SendClientMessageToAll(0xEFEFF7AA, " ");
                SendClientMessageToAll(Vermelho, "Chat Limpo");
				new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
           format(string, sizeof(string), "Admin %s(id:%d) você limpou o chat.", aname, playerid);
SendClientMessage(playerid, Azul, string);
    }
return 1;
}
if(strcmp(cmdtext, "/jetpack", true) == 0) {
if(pAdmin[playerid] >= 5){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Admin %s(id:%d) você criou um JetPack.", aname, playerid);
SendClientMessage(playerid, Azul, string);
SetPlayerSpecialAction(playerid, 2);
}
return 1;
}

if(strcmp(cmdtext, "/fugir", true) == 0) {
if(Detido[playerid] == 1){
format(string, sizeof(string), "Você agora está fugindo... Corra !");
SendClientMessage(playerid, Azul, string);
SetPlayerSpecialAction(playerid, 0);
celigado[playerid] = 0;
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid, X,Y,Z);
SetPlayerPos(playerid, X,Y,Z); 
return 1;
} else {
SendClientMessage(playerid, COLOR_RED, "Você não está detido.");
}
}
if(strcmp(cmdtext, "/respawncar", true) == 0) {
if(pAdmin[playerid] >= 2){
new VehicleID;
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Admin %s(id:%d) você respawnou seu carro.", aname, playerid);
SendClientMessage(playerid, Azul, string);
VehicleID = GetPlayerVehicleID(playerid);
SetVehicleToRespawn(VehicleID);
}
return 1;
}

if(strcmp(cmdtext, "/saircarro", true) == 0) {
if(incar[playerid] == 1){
SendClientMessage(playerid, Azul, "Você saiu do carro");
TogglePlayerControllable(playerid, 1);
RemovePlayerFromVehicle(playerid);
incar[playerid] = 0;
} else {
SendClientMessage(playerid, Vermelho, "Você não está em um carro a venda !");
}
return 1;
}
if(strcmp(cmdtext, "/deletcar", true) == 0) {
if(pAdmin[playerid] >= 2){
new VehicleID;
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Admin %s(id:%d) você deletou seu carro.", aname, playerid);
SendClientMessage(playerid, Azul, string);
VehicleID = GetPlayerVehicleID(playerid);
DestroyVehicle(VehicleID);
}
return 1;
}
if(strcmp(cmdtext, "/contar", true) == 0) {
if(pAdmin[playerid] >= 2){
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Admin %s(id:%d) iniciou uma contagem.", aname, playerid);
SendClientMessageToAll(Azul, string);
conta = 0;
counta = SetTimer("Contagem", 1000, 1);
}
return 1;
}
 if(strcmp(cmd, "/completar", true) == 0) {
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);        
	    if(dini_Int(aname, "Profissao") == VendedorComb || pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_RED, "/completar [id]");
		    	return 1;
			}
        	plid = strval(tmp);
			if(IsPlayerConnected(plid) && Logado[plid] == 1){
   new distancia;
	    	distancia = GetDistanceBetweenPlayers(plid, playerid);
			    if(distancia > 10){
			        SendClientMessage(playerid, COLOR_RED, "Você está muito longe, chegue mais perto!");
			    	return 1;
				}                
                if(plid == playerid){
                SendClientMessage(playerid, Vermelho, "Você não pode fazer isto com si mesmo.");                
                } else {
				if(distancia <= 10){
					format(string, sizeof(string), "O vendedor %s completou seu tanque de gasolina.", aname);
					SendClientMessage(plid, Azul, string);
                    new pname[MAX_PLAYER_NAME];                    
                    GetPlayerName(plid, pname, MAX_PLAYER_NAME);
                    dini_IntSet(pname, "Combustivel", 100);                                      
				    SendClientMessage(playerid, COLOR_GREEN, "Completado !");    
			    	return 1;                                           
                    }
                }
				}
		    	return 1;
			}
			else{
    	        SendClientMessage(playerid, COLOR_RED, "Jogador não está conectado/logado");
		    	return 1;
			}
	}   
if(strcmp(cmdtext, "/reparar", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == Mecanico || pAdmin[playerid] >= 3){
if(IsPlayerInAnyVehicle(playerid) == 1){
new VehicleID;
format(string, sizeof(string), "Mecanico %s(id:%d) você reparou seu carro.", aname, playerid);
SendClientMessage(playerid, Azul, string);
VehicleID = GetPlayerVehicleID(playerid);
RepairVehicle(VehicleID);
} else {
SendClientMessage(playerid, Vermelho, "Você não está em um carro para reparar.");
}
}
return 1;
}

if(strcmp(cmdtext, "/trancar", true) == 0) {
if(IsPlayerInAnyVehicle(playerid) == 1){
new VehicleID;
format(string, sizeof(string), "Veículo Trancado !.");
SendClientMessage(playerid, Azul, string);
VehicleID = GetPlayerVehicleID(playerid);
Trancado[VehicleID] = 1;
TrancadoPara[VehicleID] = playerid;
} else {
SendClientMessage(playerid, Vermelho, "Você não está em um carro para trancar.");
}
return 1;
}

if(strcmp(cmdtext, "/destrancar", true) == 0) {
if(IsPlayerInAnyVehicle(playerid) == 1){
new VehicleID;
format(string, sizeof(string), "Veículo Destrancado !.");
SendClientMessage(playerid, Azul, string);
VehicleID = GetPlayerVehicleID(playerid);
Trancado[VehicleID] = 0;
TrancadoPara[VehicleID] = 0;
} else {
SendClientMessage(playerid, Vermelho, "Você não está em um carro para destrancar.");
}
return 1;
}

if(strcmp(cmd, "/pintar", true) == 0) {
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == Mecanico || pAdmin[playerid] >= 3){
        new tmp[256];
        new cor1,cor2;
        new veiculo;
        tmp = strtok(cmdtext,idx);
        cor1 = strval(tmp);
        tmp = strtok(cmdtext, idx);
        if(!strlen(tmp)) {
    SendClientMessage(playerid, COLOR_RED, "/pintar [cor1] [cor2]");    
    return 1;
}

        cor2 = strval(tmp);
        veiculo = GetPlayerVehicleID(playerid);
        if(IsPlayerInVehicle(playerid,veiculo)){
        ChangeVehicleColor(veiculo,cor1,cor2);
            format(string, sizeof(string), "Mecanico %s(id:%d) você pintou seu carro de %d e %d.", aname, playerid, cor1, cor2);
            SendClientMessage(playerid, Azul, string);        
        return 1;        
        }
}
}

if(strcmp(cmd, "/indicar", true) == 0) {                
                 if(pAdmin[playerid] >= 4){
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "IErro: Use /indicar [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){    
             new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);            
            dini_IntSet(pname, "Carta", 1);
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você deu carta de indicação a %s.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
            format(string, sizeof(string), "Admin %s(id:%d) te deu uma carta de indicação.", aname, playerid);
            SendClientMessage(plid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "IErro: ID inválido");
		    	return 1;    
       }
			}
		}

        if(strcmp(cmd, "/enviarfbi", true) == 0) {                
                 if(pAdmin[playerid] >= 5){
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "IErro: Use /enviarfbi [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){    
             new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);            
            convitefbi[plid] = 1;
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você convidou %s para o fbi.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
            format(string, sizeof(string), "Admin %s(id:%d) te convidou ao fbi use /aceitarfbi para aceitar.", aname, playerid);
            SendClientMessage(plid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "IErro: ID inválido");
		    	return 1;    
       }
			}
		}

                if(strcmp(cmd, "/enviarcv", true) == 0) {                
                 if(pAdmin[playerid] >= 5){
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "IErro: Use /enviarcv [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){    
             new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);            
            convitecv[plid] = 1;
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você convidou %s para o CV.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
            format(string, sizeof(string), "Admin %s(id:%d) te convidou ao CV use /aceitarcv para aceitar.", aname, playerid);
            SendClientMessage(plid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "IErro: ID inválido");
		    	return 1;    
       }
			}
		}

        if(strcmp(cmd, "/habaerea", true) == 0) {                
                 if(pAdmin[playerid] >= 4){
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "IErro: Use /habaerea [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){    
             new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);            
            dini_IntSet(pname, "HabAerea", 1);
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você deu habilitação aerea a %s.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
            format(string, sizeof(string), "Admin %s(id:%d) te deu uma habilitação aerea.", aname, playerid);
            SendClientMessage(plid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "IErro: ID inválido");
		    	return 1;    
       }
			}
		}

        if(strcmp(cmd, "/habterrestre", true) == 0) {                
            if(pAdmin[playerid] >= 4){
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "IErro: Use /habterrestre [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){    
             new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);            
            dini_IntSet(pname, "HabTerrestre", 1);
			new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você deu habilitação terrestre a %s.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
            format(string, sizeof(string), "Admin %s(id:%d) te deu uma habilitação terrestre.", aname, playerid);
            SendClientMessage(plid, Azul, string);
		    return 1;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_RED, "IErro: ID inválido");
		    	return 1;    
       		}
			}
			}

        
    if(strcmp(cmd, "/habnautica", true) == 0) {                
                 if(pAdmin[playerid] >= 4){
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "IErro: Use /habnautica [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){    
             new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);            
            dini_IntSet(pname, "HabNautica", 1);
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você deu habilitação nautica a %s.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
            format(string, sizeof(string), "Admin %s(id:%d) te deu uma habilitação nautica.", aname, playerid);
            SendClientMessage(plid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "IErro: ID inválido");
		    	return 1;    
       }
			}
		}



            if(strcmp(cmd, "/vida", true) == 0) {                
                 if(pAdmin[playerid] >= 1){
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "IErro: Use /vida [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){
			    SetPlayerHealth(plid, 100);    
             new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você completou a vida de %s.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
            format(string, sizeof(string), "Admin %s(id:%d) completou sua vida.", aname, playerid);
            SendClientMessage(plid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "IErro: ID inválido");
		    	return 1;    
       }
			}
		}

        if(strcmp(cmd, "/edararma", true) == 0) {
                 if(pAdmin[playerid] >= 2){
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Erro: Use /edararma [id da arma].");
			return 1;
			}
    	    plid = strval(tmp);
             new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) deu uma arma a todos do evento.", aname, playerid);
            SendClientMessageToAll(Azul, string);
            for(new i=0; i<MAX_PLAYERS; i++){
            if(IsPlayerConnected(i) && noevento[i] == 1){
            GivePlayerWeapon(i, plid, 999999);
            }
            }
		    	return 1;
			}
		}

        if(strcmp(cmd, "/evida", true) == 0) {
                 if(pAdmin[playerid] >= 2){
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) deu vida a todos do evento.", aname, playerid);
            SendClientMessageToAll(Azul, string);
            for(new i=0; i<MAX_PLAYERS; i++){
            if(IsPlayerConnected(i) && noevento[i] == 1){
            SetPlayerHealth(i, 100);
            }
            }
		    	return 1;
			}
		}

        if(strcmp(cmd, "/ecolete", true) == 0) {
                 if(pAdmin[playerid] >= 2){
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) deu colete a todos do evento.", aname, playerid);
            SendClientMessageToAll(Azul, string);
            for(new i=0; i<MAX_PLAYERS; i++){
            if(IsPlayerConnected(i) && noevento[i] == 1){
            SetPlayerArmour(i, 100);
            }
            }
		    	return 1;
			}
		}

        if(strcmp(cmd, "/econgelar", true) == 0) {
                 if(pAdmin[playerid] >= 2){
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) congelou todos do evento.", aname, playerid);
            SendClientMessageToAll(Azul, string);
            for(new i=0; i<MAX_PLAYERS; i++){
            if(IsPlayerConnected(i) && noevento[i] == 1){
            TogglePlayerControllable(i, 0);
            }
            }
		    	return 1;
			}
		}

        if(strcmp(cmd, "/edescongelar", true) == 0) {
                 if(pAdmin[playerid] >= 2){
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) descongelou todos do evento.", aname, playerid);
            SendClientMessageToAll(Azul, string);
            for(new i=0; i<MAX_PLAYERS; i++){
            if(IsPlayerConnected(i) && noevento[i] == 1){
            TogglePlayerControllable(i, 1);
            }
            }
		    	return 1;
			}
		}

        if(strcmp(cmd, "/kick", true) == 0) {                
                 if(pAdmin[playerid] >= 1){
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "IErro: Use /kick [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){    
             new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin: %s(id:%d) kickou você.", aname, playerid);
            SendClientMessage(plid, Vermelho, string);            
            Kick(plid);
            format(string, sizeof(string), "Admin %s(id:%d) kickou %s.", aname, playerid, pname);
            SendClientMessageToAll(Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "IErro: ID inválido");
		    	return 1;    
       }
			}
		}

        if(strcmp(cmd, "/descalar", true) == 0) {                
                 if(pAdmin[playerid] >= 2){
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "IErro: Use /descalar [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){    
             new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin: %s(id:%d) descalou você.", aname, playerid);
            SendClientMessage(plid, Vermelho, string);            
            calado[plid] = 0;
            format(string, sizeof(string), "Admin: %s(id:%d) você descalou %s.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "IErro: ID inválido");
		    	return 1;    
       }
			}
		}

        if(strcmp(cmd, "/calar", true) == 0) {                
                 if(pAdmin[playerid] >= 1){
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "IErro: Use /calar [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){    
             new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin: %s(id:%d) calou você.", aname, playerid);
            SendClientMessage(plid, Vermelho, string);            
            calado[plid] = 1;
            format(string, sizeof(string), "Admin: %s(id:%d) você calou %s.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "IErro: ID inválido");
		    	return 1;    
       }
			}
		}

        if(strcmp(cmd, "/ban", true) == 0) {                
                 if(pAdmin[playerid] >= 2){
			new tmp[256];
            new msg[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Erro: Use /ban [id] [motivo]");
			return 1;
			}
    	    plid = strval(tmp);
            msg = strrest(cmdtext, idx);
            if(!strlen(msg)){
            SendClientMessage(playerid, COLOR_GREEN, "Erro: Use /ban [id] [motivo]");
            return 1;
            }
			if(IsPlayerConnected(plid)){    
             new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            new plrIP[16];                        
             GetPlayerIp(plid, plrIP, sizeof(plrIP)); 
             dini_Set(pname, "IP", plrIP);             
            dini_IntSet(pname, "Banido", 1);            
            format(string, sizeof(string), "Admin: %s(id:%d) baniu você [Motivo: %s]", aname, playerid, msg);
            SendClientMessage(plid, Vermelho, string);            
            Ban(plid);
            format(string, sizeof(string), "Admin %s(id:%d) baniu %s [Motivo: %s]", aname, playerid, pname, msg);
            SendClientMessageToAll(Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "IErro: ID inválido");
		    	return 1;    
       }
			}
		}
		
		                	if(strcmp(cmd, "/colete", true) == 0) if(pAdmin[playerid] >= 1) {
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "IErro: Use /colete [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){
			    SetPlayerArmour(plid, 100);    
                new pname[MAX_PLAYER_NAME];
            GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			    new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);            
            format(string, sizeof(string), "Admin %s(id:%d) você completou o colete de %s.", aname, playerid, pname);
            SendClientMessage(playerid, COR_ADMIN, string);
            format(string, sizeof(string), "Admin %s(id:%d) completou seu colete.", aname, playerid);
            SendClientMessage(plid, COR_ADMIN, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "IErro: ID inválido");
		    	return 1;
			}
		}
		
		if(strcmp(cmd, "/ir", true) == 0 && pAdmin[playerid] >= 1) {
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /ir [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){
			new interiordele;
				interiordele = GetPlayerInterior(plid);
				SetPlayerInterior(playerid, interiordele);
			new Float:X, Float:Y, Float:Z;
			    GetPlayerPos(plid, X, Y, Z);             
			    SetPlayerPos(playerid, X+2, Y, Z);     
  	    	new pname[MAX_PLAYER_NAME];
		GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Você foi até o player %s.", pname);
            SendClientMessage(playerid, COR_ADMIN, string);
            format(string, sizeof(string), "Admin %s(id:%d) se teleportou até você.", aname, playerid, pname);
            SendClientMessage(plid, COR_ADMIN, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
		}

        if(strcmp(cmd, "/ircarro", true) == 0 && pAdmin[playerid] >= 4) {
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /ircarro [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){
			new vid;
            vid = GetPlayerVehicleID(plid);
            PutPlayerInVehicle(playerid, vid, 1); 
  	    	new pname[MAX_PLAYER_NAME];
		GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você foi até o carro do player %s.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);            
            format(string, sizeof(string), "Admin %s(id:%d) se teleportou até seu carro.", aname, playerid, pname);
            SendClientMessage(plid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
		}

        if(strcmp(cmd, "/info", true) == 0 && pAdmin[playerid] >= 2) {
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /info [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){
            new aname[MAX_PLAYER_NAME];            
            GetPlayerName(plid, aname, MAX_PLAYER_NAME);             
            new plrIP[16];            
            new Float:vida;            
            GetPlayerHealth(plid, vida);            
            new Float:colete;            
            GetPlayerArmour(plid, colete);
             GetPlayerIp(plid, plrIP, sizeof(plrIP));
            format(string, sizeof(string), "Nome: %s Dinheiro: %d", aname, GetPlayerPCash(plid));
            SendClientMessage(playerid, Azul, string);            
            format(string, sizeof(string), "Saldo Bancário: %d Nível: %d(%d/5)", dini_Int(aname, "SaldoBancario"), dini_Int(aname, "Nivel"), dini_Int(aname, "Experiencia"));
            SendClientMessage(playerid, Azul, string);             
            format(string, sizeof(string), "Faculdade: %d Profissão: %s", dini_Int(aname, "Faculdade"), Prof[dini_Int(aname, "Profissao")]);
            SendClientMessage(playerid, Azul, string);             
            format(string, sizeof(string), "Casa: %d Prop: %d", dini_Int(aname, "Casa"), dini_Int(aname, "Prop"));
            SendClientMessage(playerid, Azul, string);            
            format(string, sizeof(string), "IP: %s Vida: %f", plrIP, vida);
            SendClientMessage(playerid, Azul, string); 
            format(string, sizeof(string), "Arma atual: %d Colete: %f", GetPlayerWeapon(plid), colete);
            SendClientMessage(playerid, Azul, string); 
            format(string, sizeof(string), "Tem carro: %d", dini_Int(aname, "TCarro"));
            SendClientMessage(playerid, Azul, string);             
            return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
		}

        /*if(strcmp(cmd, "/prop", true) == 0 && IsPlayerAdmin(playerid)) {
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /prop [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){
  	    	new pname[MAX_PLAYER_NAME];
		GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);              
            dini_IntSet(pname, "Prop", 1);
            format(string, sizeof(string), "Admin %s(id:%d) você deu uma propriedade a %s.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);             
            format(string, sizeof(string), "Admin %s(id:%d) te vendeu uma propriedade.", aname, playerid);
            SendClientMessage(plid, Azul, string);            
            SendClientMessage(plid, Verde, "Use /propnm [nome] para mudar o nome de sua propriedade.");
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
		}       */
		
		if(strcmp(cmd, "/disarmar", true) == 0)if(pAdmin[playerid] >= 3) {
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /disarmar [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){
			ResetPlayerWeapons(plid);
  	    	new pname[MAX_PLAYER_NAME];
		GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você desarmou o player %s.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
		}
						                	if(strcmp(cmd, "/trazer", true) == 0)if(pAdmin[playerid] >= 1) {
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /trazer [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid) && NaFaculdade[plid] == 0){
			new interiormeu;
				interiormeu = GetPlayerInterior(playerid);
				SetPlayerInterior(plid, interiormeu);
			new Float:X, Float:Y, Float:Z;
			    GetPlayerPos(playerid, X, Y, Z);         
			    SetPlayerPos(plid, X+2, Y, Z);     
  	    	new pname[MAX_PLAYER_NAME];
		GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você teleportou %s para sua posição.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);                
            format(string, sizeof(string), "Admin %s(id:%d) te teleportou até ele.", aname, playerid, pname);
            SendClientMessage(plid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "Player não conectado ou está na faculdade.");
		    	return 1;
			}
		}
		
								                	if(strcmp(cmd, "/ejetar", true) == 0) if(pAdmin[playerid] >= 2){
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /ejetar [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){
			RemovePlayerFromVehicle(plid);
  	    	new pname[MAX_PLAYER_NAME];
		GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você ejetou o player %s.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
		}
		
		
		 	if(strcmp(cmd, "/espiar", true) == 0)if(pAdmin[playerid] >= 2) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "Use /espiar [id]");
			return 1;
		}
		specplayerid = strval(tmp);

		if(!IsPlayerConnected(specplayerid)) {
		    SendClientMessage(playerid, COLOR_RED, "ID Inválido.");
			return 1;
		}

		TogglePlayerSpectating(playerid, 1);
		PlayerSpectatePlayer(playerid, specplayerid);
		SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
		gSpectateID[playerid] = specplayerid;
		gSpectateType[playerid] = ADMIN_SPEC_TYPE_PLAYER;
        if(IsPlayerInAnyVehicle(specplayerid)){
        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specplayerid)); 
        return 1;       
        } else { 
        PlayerSpectatePlayer(playerid, specplayerid);
        return 1;       
        }
 		//return 1;
	}
	
	 	if(strcmp(cmd, "/pararespiar", true) == 0) if(pAdmin[playerid] >= 2) {
		TogglePlayerSpectating(playerid, 0);
		gSpectateID[playerid] = INVALID_PLAYER_ID;
		gSpectateType[playerid] = ADMIN_SPEC_TYPE_NONE;
		return 1;
	}
		
		
		
		if(strcmp(cmd, "/deletcarof", true) == 0)if(pAdmin[playerid] >= 4) {
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /deletcarof [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){
			new vid;
			    vid = GetPlayerVehicleID(plid);
			    DestroyVehicle(vid);
  	    	new pname[MAX_PLAYER_NAME];
		GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você deletou o carro que o player %s estava.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
		}
		
 	if(strcmp(cmd, "/respawncarof", true) == 0) if(pAdmin[playerid] >= 4) {
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /respawncarof [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){
			new vid;
			    vid = GetPlayerVehicleID(plid);
			    SetVehicleToRespawn(vid);
  	    	new pname[MAX_PLAYER_NAME];
		GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você respawnou o carro que o player %s estava.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
		}

        if(strcmp(cmd, "/repaircarof", true) == 0) if(pAdmin[playerid] >= 4) {
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /repaircarof [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){
			new vid;
			    vid = GetPlayerVehicleID(plid);
			    RepairVehicle(vid);
  	    	new pname[MAX_PLAYER_NAME];
		GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você reparou o carro que o player %s estava.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
		}

        if(strcmp(cmd, "/tempo", true) == 0)
	{
        new tmp[256];
	    if(IsPlayerConnected(playerid))
	    {
	        if(pAdmin[playerid] < 5)
			{
			    SendClientMessage(playerid, Vermelho, "   Voce não esta autorizado a usar este comando!");
			    return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
			    SendClientMessage(playerid, COLOR_WHITE, "USE: /tempo [tempoid]");
			    return 1;
			}
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
			new weather;
			weather = strval(tmp);
			if(weather < 0||weather > 45) { SendClientMessage(playerid, Vermelho, "   Tempo id de 0 ~ 45 !"); return 1; }
			SetWeather(weather);
			//SetWorldTime(weather);
			format(string, 256, "Admin %s setou o tempo para %d",name,weather);
			SendClientMessageToAll(Azul,string);
			SendClientMessage(playerid, Amarelo, "Tempo setado!");
		}
		return 1;
	}
		
		if(strcmp(cmd, "/explode", true) == 0) if(pAdmin[playerid] >= 4) {
			new tmp[256];
			new plid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /explode [id].");
			return 1;
			}
    	    plid = strval(tmp);
			if(IsPlayerConnected(plid)){
			new Float:xi,Float:yi,Float:zi;
			GetPlayerPos(plid,xi,yi,zi);
			SetTimerEx("CriarExplosao",1,false,"fffdf",xi,yi,zi,2,50.0);
  	    	new pname[MAX_PLAYER_NAME];
		    GetPlayerName(plid, pname, MAX_PLAYER_NAME);
			new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você explodiu o player de nome %s.", aname, playerid, pname);
            SendClientMessage(playerid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
		}
		
		if(strcmp(cmd, "/criarcarro", true) == 0) if(pAdmin[playerid] >= 3) {
			new tmp[256];
			new plid;
			new Float:X,Float:Y,Float:Z,Float:Angle;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /criarcarro [iddocaro].");
			return 1;
			}
    	    plid = strval(tmp);
			if(pAdmin[playerid] >= 3){
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,Angle);
			new carro = CreateVehicle(plid, X, Y, Z, Angle, -1, -1, 7200);
			PutPlayerInVehicle(playerid,carro,0);
			if(GetPlayerInterior(playerid))
		 	LinkVehicleToInterior(carro,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(carro,GetPlayerVirtualWorld(playerid));
			new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Admin %s(id:%d) você criou o carro de id %d.", aname, playerid, plid);
            SendClientMessage(playerid, Azul, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "Você não é admin");
		    	return 1;
			}
		}



 if(!strcmp(cmd,"/plantarbomba",true)){ 
 new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
		if(dini_Int(aname, "Profissao") == Terrorista || dini_Int(aname, "Profissao") == ComandoVermelho || pAdmin[playerid] >= 3){
new dinid,Float:xb,Float:yb,Float:zb;
if(IsPlayerInAnyVehicle(playerid)){
SendClientMessage(playerid,COLOR_RED,"Ta Louco? Você não pode plantar uma bomba dentro do veiculo.");
return 1;
}
if(blockbomba == 0){
format(string, sizeof(string), "O terrorista %s plantou uma bomba.", aname);
SendClientMessageToAll(Azul, string);
GetPlayerPos(playerid,xb,yb,zb);
ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
SetTimerEx("CriarExplosao",8000,false,"fffdf",xb,yb,zb,2,50.0);
dinid = CreateObject(1252,xb,yb,zb-0.8,0,0,0);
SetTimerEx("DestruirObjeto",8000,false,"d",dinid);
GameTextForPlayer(playerid,"BOMBA PLANTADA",1000,4);
blockbomba = 1;
return 1;
} else {
SendClientMessage(playerid, Vermelho, "Já existe uma bomba plantada, aguarde ela explodir");
}
}
}

if(strcmp(cmd,"/setskin", true)==0)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Profissao") == VendedorSkin || pAdmin[playerid] >= 3){
new tmp[256];
new plid, skin;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)){
SendClientMessage(playerid, COLOR_RED, "IErro: /setskin [id] [skin]");
return 1;
}
plid = strval(tmp);
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) {
SendClientMessage(playerid, COLOR_RED, "IErro: /setskin [id] [skin]");
return 1;
}
skin = strval(tmp);
if(IsPlayerConnected(plid)){
if(skin < 300){
new pname[MAX_PLAYER_NAME];
GetPlayerName(plid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "O Vendedor %s(id:%d) te vendeu a skin %d.", aname, playerid, skin);
SendClientMessage(plid, Azul, string);
format(string, sizeof(string), "Você vendeu a %s(id:%d) a skin %d.", pname, plid, skin);
SendClientMessage(playerid, Azul, string);
SetPlayerSkin(plid,skin);
dini_IntSet(pname, "Skin", skin);
return 1;
}  else {
SendClientMessage(playerid, COLOR_RED, "Skins de 0 a 299.");
}
}
else
{
SendClientMessage(playerid, COLOR_RED, "Jogador não conectado.");
return 1;
}
}
}

if(strcmp(cmd,"/setprof", true)==0)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(pAdmin[playerid] >= 5){
new tmp[256];
new plid, skin;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)){
SendClientMessage(playerid, COLOR_RED, "IErro: /setprof [id] [prof]");
return 1;
}
plid = strval(tmp);
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) {
SendClientMessage(playerid, COLOR_RED, "IErro: /setprof [id] [prof]");
return 1;
}
skin = strval(tmp);
if(IsPlayerConnected(plid)){
new pname[MAX_PLAYER_NAME];
GetPlayerName(plid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "O Admin %s(id:%d) te setou a prof %s.", aname, playerid, Prof[skin]);
SendClientMessage(plid, Azul, string);
format(string, sizeof(string), "Você deu a %s(id:%d) a prof %s.", pname, plid, Prof[skin]);
SendClientMessage(playerid, Azul, string);
dini_IntSet(pname, "Profissao", skin);
SpawnPlayer(plid);
return 1;
}
else
{
SendClientMessage(playerid, COLOR_RED, "Jogador não conectado.");
return 1;
}
}
}

if(strcmp(cmd,"/setexp", true)==0)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(pAdmin[playerid] >= 5){
new tmp[256];
new plid, skin;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)){
SendClientMessage(playerid, COLOR_RED, "IErro: /setexp [id] [exp]");
return 1;
}
plid = strval(tmp);
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) {
SendClientMessage(playerid, COLOR_RED, "IErro: /setexp [id] [exp]");
return 1;
}
skin = strval(tmp);
if(IsPlayerConnected(plid)){
new pname[MAX_PLAYER_NAME];
GetPlayerName(plid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "O Admin %s(id:%d) te setou com %d de exp.", aname, playerid, skin);
SendClientMessage(plid, Azul, string);
format(string, sizeof(string), "Você setou a %s(id:%d), %d de exp.", pname, plid, skin);
SendClientMessage(playerid, Azul, string);
dini_IntSet(pname, "Experiencia", skin);
return 1;
}
else
{
SendClientMessage(playerid, COLOR_RED, "Jogador não conectado.");
return 1;
}
}
}

if(strcmp(cmd,"/setadmin", true)==0)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(pAdmin[playerid] >= 5 || IsPlayerAdmin(playerid)){
new tmp[256];
new plid, skin;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)){
SendClientMessage(playerid, COLOR_RED, "IErro: /setadmin [id] [level]");
return 1;
}
plid = strval(tmp);
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) {
SendClientMessage(playerid, COLOR_RED, "IErro: /setadmin [id] [level]");
return 1;
}
skin = strval(tmp);
if(IsPlayerConnected(plid)){
new pname[MAX_PLAYER_NAME];
GetPlayerName(plid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "O Admin %s(id:%d) te setou %d leveis de admin.", aname, playerid, skin);
SendClientMessage(plid, Azul, string);
format(string, sizeof(string), "Você setou a %s(id:%d), %d leveis de admin.", pname, plid, skin);
SendClientMessage(playerid, Azul, string);
pAdmin[plid] = skin;
return 1;
}
else
{
SendClientMessage(playerid, COLOR_RED, "Jogador não conectado.");
return 1;
}
}
}


if(strcmp(cmd,"/setcomb", true)==0)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(pAdmin[playerid] >= 5){
new tmp[256];
new plid, skin;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)){
SendClientMessage(playerid, COLOR_RED, "IErro: /setcomb [id] [quantia]");
return 1;
}
plid = strval(tmp);
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) {
SendClientMessage(playerid, COLOR_RED, "IErro: /setcomb [id] [quantia]");
return 1;
}
skin = strval(tmp);
if(IsPlayerConnected(plid)){
if(skin <= 100){
new pname[MAX_PLAYER_NAME];
GetPlayerName(plid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "O Admin %s(id:%d) te setou com %d de combustivel.", aname, playerid, skin);
SendClientMessage(plid, Azul, string);
format(string, sizeof(string), "Você setou a %s(id:%d), %d de combustivel.", pname, plid, skin);
SendClientMessage(playerid, Azul, string);
dini_IntSet(pname, "Combustivel", skin);
return 1;
} else {
SendClientMessage(playerid, COLOR_RED, "Valores de 0 a 100.");
return 1;
}
}
else
{
SendClientMessage(playerid, COLOR_RED, "Jogador não conectado.");
return 1;
}
}
}

if(strcmp(cmd,"/setnivel", true)==0)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(pAdmin[playerid] >= 5){
new tmp[256];
new plid, skin;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)){
SendClientMessage(playerid, COLOR_RED, "IErro: /setnivel [id] [nivel]");
return 1;
}
plid = strval(tmp);
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) {
SendClientMessage(playerid, COLOR_RED, "IErro: /setnivel [id] [nivel]");
return 1;
}
skin = strval(tmp);
if(IsPlayerConnected(plid)){
new pname[MAX_PLAYER_NAME];
GetPlayerName(plid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "O Admin %s(id:%d) te setou com %d de nivel.", aname, playerid, skin);
SendClientMessage(plid, Azul, string);
format(string, sizeof(string), "Você setou a %s(id:%d), %d de nivel.", pname, plid, skin);
SendClientMessage(playerid, Azul, string);
dini_IntSet(pname, "Nivel", skin);
return 1;
}
else
{
SendClientMessage(playerid, COLOR_RED, "Jogador não conectado.");
return 1;
}
}
}


if(strcmp(cmd,"/setvip", true)==0)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(pAdmin[playerid] >= 5){
new tmp[256];
new plid, skin;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)){
SendClientMessage(playerid, COLOR_RED, "IErro: /setvip [id] [minutos]");
return 1;
}
plid = strval(tmp);
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) {
SendClientMessage(playerid, COLOR_RED, "IErro: /setvip [id] [minutos]");
return 1;
}
skin = strval(tmp);
if(IsPlayerConnected(plid)){
new pname[MAX_PLAYER_NAME];
GetPlayerName(plid, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "O Admin %s(id:%d) te deu %d minutos de vip.", aname, playerid, skin);
SendClientMessage(plid, Azul, string);
format(string, sizeof(string), "Você deu a %s(id:%d), %d minutos de vip.", pname, plid, skin);
SendClientMessage(playerid, Azul, string);
dini_IntSet(pname, "Vip", skin);
SpawnPlayer(plid);
return 1;
}
else
{
SendClientMessage(playerid, COLOR_RED, "Jogador não conectado.");
return 1;
}
}
}



if(strcmp(cmd,"/dararma", true)==0 && pAdmin[playerid] >= 4)
{
new tmp[256];
new plid, idarma;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)){
SendClientMessage(playerid, COLOR_RED, "IErro: /dararma [id] [iddaarma]");
return 1;
}
plid = strval(tmp);
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) {
SendClientMessage(playerid, COLOR_RED, "IErro: /dararma [id] [iddaarma]");
return 1;
}
idarma = strval(tmp);
if(IsPlayerConnected(plid)){
new pname[MAX_PLAYER_NAME];
GetPlayerName(plid, pname, MAX_PLAYER_NAME);
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Admin %s(id:%d) você deu para %s a arma de id %d.", aname, playerid, pname, idarma);
SendClientMessage(playerid, Azul, string);
format(string, sizeof(string), "Admin %s(id:%d) deu para você a arma de id %d.", aname, playerid, idarma);
SendClientMessage(plid, Azul, string);
GivePlayerWeapon(plid,idarma,100000);
return 1;
}
else
{
SendClientMessage(playerid, COLOR_RED, "Jogador não conectado.");
return 1;
}
}

if(strcmp(cmd,"/dargrana", true)==0 && pAdmin[playerid] >= 4)
{
new tmp[256];
new plid, grana;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)){
SendClientMessage(playerid, COLOR_RED, "IErro: /dargrana [id] [grana]");
return 1;
}
plid = strval(tmp);
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) {
SendClientMessage(playerid, COLOR_RED, "IErro: /dargrana [id] [grana]");
return 1;
}
grana = strval(tmp);
if(IsPlayerConnected(plid)){
new pname[MAX_PLAYER_NAME];
GetPlayerName(plid, pname, MAX_PLAYER_NAME);
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Admin %s(id:%d) você deu para %s $%d de dinheiro.", aname, playerid, pname, grana);
SendClientMessage(playerid, Azul, string);
format(string, sizeof(string), "Admin %s(id:%d) deu para você $%d de dinheiro.", aname, playerid, grana);
SendClientMessage(plid, Azul, string);
GivePlayerPCash(plid,grana);
return 1;
}
else
{
SendClientMessage(playerid, COLOR_RED, "Jogador não conectado.");
return 1;
}
}

if(strcmp(cmd,"/setargrana", true)==0 && pAdmin[playerid] >= 4)
{
new tmp[256];
new plid, grana;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)){
SendClientMessage(playerid, COLOR_RED, "IErro: /setargrana [id] [grana]");
return 1;
}
plid = strval(tmp);
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) {
SendClientMessage(playerid, COLOR_RED, "IErro: /setargrana [id] [grana]");
return 1;
}
grana = strval(tmp);
if(IsPlayerConnected(plid)){
new pname[MAX_PLAYER_NAME];
GetPlayerName(plid, pname, MAX_PLAYER_NAME);
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
format(string, sizeof(string), "Admin %s(id:%d) você setou %s com $%d de dinheiro.", aname, playerid, pname, grana);
SendClientMessage(playerid, Azul, string);
format(string, sizeof(string), "Admin %s(id:%d) setou você com $%d de dinheiro.", aname, playerid, grana);
SendClientMessage(plid, Azul, string);
ResetPlayerPCash(plid);
GivePlayerPCash(plid,grana);
return 1;
}
else
{
SendClientMessage(playerid, COLOR_RED, "IErro: Jogador não conectado.");
return 1;
}
}

if(strcmp(cmd, "/reportar", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {      
          //  new sendername[MAX_PLAYER_NAME];
	        GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, Vermelho, "USE: /reportar [texto]");
				return 1;
			}
			format(string, sizeof(string), "Reporte: [%s(id:%d)]: (%s)", sendername, playerid,(result));
			ABroadCast(Amarelo,string,1);
			SendClientMessage(playerid, Amarelo, "Sua mensagem foi enviada aos admins.");
	    }
	    return 1;
	}

    if(strcmp(cmd, "/r", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {      
          //  new sendername[MAX_PLAYER_NAME];
	        GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, Vermelho, "USE: /r [texto]");
				return 1;
			}
			format(string, sizeof(string), "[ChatProfissao]%s(id:%d): %s", sendername, playerid,(result));
			ABroadCast2(GetPlayerColor(playerid),string,1);
	    }
	    return 1;
	}

    if(strcmp(cmd, "/a", true) == 0)
	{
	    if(pAdmin[playerid] >= 1)
	    {      
            //new sendername[MAX_PLAYER_NAME];
	        GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, Vermelho, "USE: /a [texto]");
				return 1;
			}
			format(string, sizeof(string), "AdminChat: [%s(id:%d)]: (%s)", sendername, playerid,(result));
			ABroadCast(Azul,string,1);
	    }
	    return 1;
	}


		
	if(strcmp(cmd,"/anunciar",true)==0) if(pAdmin[playerid] >= 3){
	    if(pAdmin[playerid] >= 3){
	    	new tmp[256];
	    	strmid(tmp,cmdtext,10,strlen(cmdtext));
	    	if(!strlen(tmp)) {
	        	SendClientMessage(playerid,COLOR_RED,"/anunciar [texto]");
		    	return 1;
			} else {
			    GameTextForAll(tmp,3000,6);
		    	return 1;
			}
		}else{
		    SendClientMessage(playerid,COLOR_RED,"Você não tem permissão!");
	    	return 1;
		}
	}
	
	
	if(strcmp(cmd, "/say", true) == 0) if(pAdmin[playerid] >= 2){
			new tmp[256];
			strmid(tmp, cmdtext, 4, strlen(cmdtext));
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /say [texto].");
			return 1;
			}
			if(IsPlayerConnected(playerid)){
			new pname[MAX_PLAYER_NAME];
				GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
				format(string, sizeof(string), "Admin %s: %s", pname, tmp);
				SendClientMessageToAll(0x33AAFFFF, string);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
		}

        if(strcmp(cmd, "/lembrete", true) == 0){        
             new pname[MAX_PLAYER_NAME];
				GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
            if(dini_Int(pname, "Bloco") == 1){
			new tmp[256];
			strmid(tmp, cmdtext, 9, strlen(cmdtext));
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /lembrete [texto].");
			return 1;
			}
			if(IsPlayerConnected(playerid)){
				dini_Set(pname, "Lembrete", tmp);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
   }
		}

        if(strcmp(cmd, "/msg", true) == 0){
             new pname[MAX_PLAYER_NAME];
				GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
            if(pAdmin[playerid] >= 5){
			new tmp[256];
			strmid(tmp, cmdtext, 4, strlen(cmdtext));
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GREEN, "Use /msg [texto].");
			return 1;
			}
			if(IsPlayerConnected(playerid)){
                TextDrawSetString(Exp,tmp);
		    	return 1;
			}
			else{
			    SendClientMessage(playerid, COLOR_RED, "ID inválido");
		    	return 1;
			}
   }
		}
	
if(!strcmp(cmd, "/respawncars", true) && pAdmin[playerid] >= 4)
	{
		new carro = 0;
		for(carro = 0; carro < MAX_VEHICLES; carro++)
		{
            for(new i = 0; i < MAX_PLAYERS; i++)
		    {
            if(GetPlayerVehicleID(i) == carro){
			//SetVehicleToRespawn(carro);
            } else {
            SetVehicleToRespawn(carro);
            }
            }
		}
		new pname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
        format(string, sizeof(string), "Admin %s(id:%d) respawnou todos os carros.", pname, playerid);
        SendClientMessageToAll(Azul, string);
		return 1;
	}

    if(!strcmp(cmd, "/dm", true) && pAdmin[playerid] >= 3)
	{
		new pname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, pname, MAX_PLAYER_NAME);          
        if(podedm == 0){
        format(string, sizeof(string), "Admin %s(id:%d) permitiu o DM.", pname, playerid);
        SendClientMessageToAll(Azul, string);
        podedm = 1;         
        } else {           
        if(podedm == 1){
        format(string, sizeof(string), "Admin %s(id:%d) proibiu o DM.", pname, playerid);
        SendClientMessageToAll(Azul, string);
        podedm = 0;         
        }        
        }
		return 1;
	}



    } else {
    SendClientMessage(playerid, Vermelho, "Você não pode usar comandos no momento(calado/na faculdade/preso).");  
    return 1;  
    }
                
return SendClientMessage(playerid, Vermelho, "Este comando não existe no Philips RPG.");
}

public OnPlayerText(playerid, text[])
{
new string[256];
//for(new i=0;i<MAX_PLAYERS;i++){
//if(IsPlayerConnected(i)){  
//new dist;
//dist = GetDistanceBetweenPlayers(i,playerid);
//if(dist <= 15){
//new string[256];
//new pname[MAX_PLAYER_NAME];
//GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
//format(string, sizeof(string), "%s[id:%d]: %s.", pname, playerid, text);
//SendClientMessage(i, Branco, string);
//}
//}
//}
podeenviar[playerid] = 0;

new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
minutosafk[playerid] = 0;
if(calado[playerid] == 1){
SendClientMessage(playerid, Vermelho, "[Philips RPG]Você está calado e sua mensagem não foi enviada.");
podeenviar[playerid] = 1;
return 0;
} else {
//flood[playerid] = flood[playerid]+1;
if(NaFaculdade[playerid] == 1)
{
Conversa[playerid] = Conversa[playerid]+1;
new Float:X;
new Float:Y;
new Float:Z;
PlayerPlaySound(playerid,1147, X, Y, Z);
if(dini_Int(pname, "Vip") == 0){
format(string, sizeof(string), "Você está conversando %d/3 alertas do professor.", Conversa[playerid]);
SendClientMessage(playerid, Azul, string);
} else {
format(string, sizeof(string), "[Philips-Vip]Você está conversando %d/6 alertas do professor.", Conversa[playerid]);
SendClientMessage(playerid, Azul, string);
}
if(dini_Int(pname, "Vip") == 0){
if(Conversa[playerid] == 3){
SpawnPlayer(playerid);
SetPlayerPos(playerid, 1139.4012, -1761.3579, 13.5950);
NaFaculdade[playerid] = 0;                                                                       
minutos[playerid] = 0;
dini_IntSet(pname, "expulso", dini_Int(pname, "expulso")+1);
SendClientMessage(playerid, Vermelho, "Você conversou de mais e o professor te pos para fora da sala.");
}
} else {
if(Conversa[playerid] == 6){
SpawnPlayer(playerid);
SetPlayerPos(playerid, 1139.4012, -1761.3579, 13.5950);
NaFaculdade[playerid] = 0;                                                                       
minutos[playerid] = 0;
dini_IntSet(pname, "expulso", dini_Int(pname, "expulso")+2);
SendClientMessage(playerid, Vermelho, "[Philips-Vip]Você conversou de mais e o professor te pos para fora da sala.");
}
}
/*if(podeenviar[playerid] == 0){
if(dini_Int(pname, "Vip") == 0){
SetPlayerChatBubble(playerid, text, 0xFF0000FF, 100.0, 10000);
} else {
format(string, sizeof(string), "Philips VIP: %s", text);
SetPlayerChatBubble(playerid, string, Azul, 100.0, 10000);
}
format(string, sizeof(string), "[ID:%d] %s", playerid, text);
SendPlayerMessageToAll(playerid, string);
}  */
return 0;
}
for(new s = 0; s < num_words; s++)
    {
        new pos;
		while((pos = strfind(text,Swears[s],true)) != -1) for(new i = pos, j = pos + strlen(Swears[s]); i < j; i++){
	 	text[i] = '*';
		for(new n = 0; n <= MAX_PLAYERS; n++)
		{
			if(IsPlayerConnected(n) == 1)
			{
				PlayerPlaySound(n, 1130, 0.0, 0.0, 0.0);
			}
		}
		}
	}
if(podeenviar[playerid] == 0){
new strx[256];
if(dini_Int(pname, "Vip") == 0){
SetPlayerChatBubble(playerid, text, 0xFF0000FF, 100.0, 10000);
} else {
format(string, sizeof(string), "Philips VIP: %s", text);
SetPlayerChatBubble(playerid, string, Azul, 100.0, 10000);
}
format(strx,sizeof(strx),"%s[VIP]",pname);
if(dini_Int(pname, "Vip") > 0){
SetPlayerName(playerid, strx);
}
new playename[MAX_PLAYER_NAME];
GetPlayerName(playerid, playename, MAX_PLAYER_NAME);
format(string,sizeof(string),"(id:%d): %s",playerid,text);
SendPlayerMessageToAll(playerid, string);
SetPlayerName(playerid, pname);
//flood[playerid] = flood[playerid]+1;
if(flood[playerid] == 5){
SendClientMessage(playerid, Verde, "[Philips RPG]Você está falando muito e pode ser calado.");
}
if(flood[playerid] == 6){
SendClientMessage(playerid, Vermelho, "[Philips RPG]O BIXO VAI PEGA... Espera um poco pra fala.");
}
if(flood[playerid] == 7){
SendClientMessage(playerid, Vermelho, "[Philips RPG]O Bixo pego, você falo de mais e foi calado por 1 minuto.");
format(string, sizeof(string), "[Philips-Bot]%s(id:%d) foi calado por falar de mais.", pname, playerid);   
    SendClientMessageToAll(Amarelo, string);  
calado[playerid] = 1;
mincalado[playerid] = 0;
}
}
return 0;
}
}

public OnPlayerDeath(playerid, killerid, reason)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
TextDrawHideForPlayer(playerid, motendo);
TextDrawHideForPlayer(playerid, motendo2);
TextDrawShowForPlayer(playerid, morti);
TextDrawShowForPlayer(playerid, mote);
TextDrawHideForPlayer(playerid, dano);
SendDeathMessage(killerid, playerid, reason);
SetSpawnInfo(playerid,1,dini_Int(aname, "Skin"),1172.6731,-1323.1965,15.4022,271.9589, 0, 0, 0, 0, 0, 0);
new string[256];
GetPlayerState(killerid);
new pname[MAX_PLAYER_NAME];
GetPlayerName(killerid, pname, MAX_PLAYER_NAME);
if(IsPlayerInAnyVehicle(killerid)) {
if(podedm == 0){
SendClientMessage(killerid, Amarelo, "Philips RPG: Você cometeu DB(Drive By) e foi kickado."); //Mensagem que envia pra pessoa que mata
Kick(killerid);
format(string, sizeof(string), "Philips RPG: O player %s(id:%d) cometeu DB e foi kickado do servidor.", pname, killerid); //Uma mensagem que manda para todo mundo
SendClientMessageToAll(Amarelo, string);
}
}
if(dini_Int(pname, "Profissao") == ComandoVermelho && dini_Int(aname, "Profissao") == FBI || dini_Int(aname, "Profissao") == ComandoVermelho && dini_Int(pname, "Profissao") == FBI){
SendClientMessage(killerid, Azul, "Você matou um inimigo e roubou dele 50 reais !");
SendClientMessage(playerid, Vermelho, "Você perdeu pro inimigo e ele lhe roubou 50 reais...");
GivePlayerPCash(killerid, 50);
GivePlayerPCash(playerid, -50);
} else {
if(podedm == 0){
if(cs1[killerid] == 0){
if(cs2[killerid] == 0){
if(cs3[killerid] == 0){
if(cs4[killerid] == 0){
if(areadmp[killerid] == 0 && GetPlayerWantedLevel(playerid) == 0){
GivePlayerPCash(playerid, -30);
SendClientMessage(killerid, Vermelho, "Você matou uma pessoa e ganhou 1 nivel de procurado.");
SetPlayerWantedLevel(killerid, GetPlayerWantedLevel(killerid)+1);
}
}
}
}
}
}
}
if(GetPlayerWantedLevel(playerid) == 1){
SetPlayerWantedLevel(playerid, 0);
SendClientMessage(playerid, Vermelho, "Você era um criminoso e recebeu multa de 100 reais.");
GivePlayerPCash(playerid, -100);
SendClientMessage(killerid, Vermelho, "Você matou um criminoso e ganhou 50 reais de recompensa.");
GivePlayerPCash(killerid, 50);
}
if(GetPlayerWantedLevel(playerid) == 2){
SetPlayerWantedLevel(playerid, 0);
SendClientMessage(playerid, Vermelho, "Você era um criminoso e recebeu multa de 200 reais.");
GivePlayerPCash(playerid, -200);
SendClientMessage(killerid, Vermelho, "Você matou um criminoso e ganhou 100 reais de recompensa.");
GivePlayerPCash(killerid, 100);
}
if(GetPlayerWantedLevel(playerid) == 3){
SetPlayerWantedLevel(playerid, 0);
SendClientMessage(playerid, Vermelho, "Você era um criminoso e recebeu multa de 300 reais.");
GivePlayerPCash(playerid, -300);
SendClientMessage(killerid, Vermelho, "Você matou um criminoso e ganhou 150 reais de recompensa.");
GivePlayerPCash(killerid, 150);
}
if(GetPlayerWantedLevel(playerid) == 4){
SetPlayerWantedLevel(playerid, 0);
SendClientMessage(playerid, Vermelho, "Você era um criminoso e recebeu multa de 450 reais.");
GivePlayerPCash(playerid, -450);
SendClientMessage(killerid, Vermelho, "Você matou um criminoso e ganhou 200 reais de recompensa.");
GivePlayerPCash(killerid, 200);
}
if(GetPlayerWantedLevel(playerid) == 5){
SetPlayerWantedLevel(playerid, 0);
SendClientMessage(playerid, Vermelho, "Você era um criminoso e recebeu multa de 600 reais.");
GivePlayerPCash(playerid, -600);
SendClientMessage(killerid, Vermelho, "Você matou um criminoso e ganhou 250 reais de recompensa.");
GivePlayerPCash(killerid, 250);
}
if(GetPlayerWantedLevel(playerid) == 6){
SetPlayerWantedLevel(playerid, 0);
SendClientMessage(playerid, Vermelho, "Você era um super criminoso, recebeu multa de 1000 reais e foi preso.");
GivePlayerPCash(playerid, -1000);
SendClientMessage(killerid, Vermelho, "Você matou um criminoso e ganhou 300 reais de recompensa.");
GivePlayerPCash(killerid, 300);
SpawnPlayer(playerid);
SetPlayerPos(playerid, 264.4181,77.3247,1001.0391);
SetPlayerHealth(playerid, 99999);
SetPlayerInterior(playerid, 6);
ResetPlayerWeapons(playerid);
dini_IntSet(aname, "Preso", 1);
}
return 1;
}

 

public OnVehicleDeath(vehicleid,killerid) {
Trancado[vehicleid] = 0;
TrancadoPara[vehicleid] = 0;
cargadele[vehicleid] = 0;
return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid, X, Y, Z);
if(Trancado[vehicleid] == 1){
if(TrancadoPara[vehicleid] == playerid){
SendClientMessage(playerid, Vermelho, "Você entrou em um carro[TRANCADO].");
return 1;
} else {
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(TrancadoPara[vehicleid], nomepl, MAX_PLAYER_NAME);
SetPlayerPos(playerid, X, Y, Z);
new string[256];
format(string, sizeof(string), "Este carro está trancado por: %s.", nomepl);
ShowPlayerDialog(playerid, 79, DIALOG_STYLE_MSGBOX, "CARRO TRANCADO", string, "Ok", "Fechar");
return 1;
}
} else {
SendClientMessage(playerid, Vermelho, "Você entrou em um carro.");
}
new modelo;
modelo = GetVehicleModel(vehicleid);
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, sizeof(pname));
if(modelo == 596){
if(dini_Int(pname, "Profissao") == Policial_R || dini_Int(pname, "Profissao") == Policial_M || dini_Int(pname, "Profissao") == Policial_C || dini_Int(pname, "Profissao") == Policial_F || dini_Int(pname, "Profissao") == Delegado || dini_Int(pname, "Profissao") == Bope || dini_Int(pname, "Profissao") == Swat || dini_Int(pname, "Profissao") == Narcoticos || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Bem Vindo Policial.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(modelo == 528 || modelo == 490){
if(dini_Int(pname, "Profissao") == FBI || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Azul, "Bem Vindo Agente.");
} else {
if(dini_Int(pname, "Profissao") == ComandoVermelho){
//SendClientMessage(playerid, Vermelho, "Você está roubando um veiculo do FBI. CORRA.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
}
if(modelo == 444 || modelo == 471){
if(dini_Int(pname, "Profissao") == ComandoVermelho || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Membro do CV, bem vindo.");
} else {
if(dini_Int(pname, "Profissao") == FBI){
//SendClientMessage(playerid, Azul, "Agente FBI, você apreendeu um carro do CV.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
}
if(modelo == 497){
if(dini_Int(pname, "Profissao") == Policial_R || dini_Int(pname, "Profissao") == Policial_M || dini_Int(pname, "Profissao") == Policial_C || dini_Int(pname, "Profissao") == Policial_F || dini_Int(pname, "Profissao") == Delegado || dini_Int(pname, "Profissao") == Bope || dini_Int(pname, "Profissao") == Swat || dini_Int(pname, "Profissao") == Narcoticos || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Bem Vindo Policial.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(modelo == 488){
if(dini_Int(pname, "Profissao") == Jornalista || dini_Int(pname, "Profissao") == Fotografo || dini_Int(pname, "Profissao") == Reporter || dini_Int(pname, "Profissao") == Ancora || dini_Int(pname, "Profissao") == Meteorologista || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Bem Vindo Jornalista. Encubra as notícias !.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(modelo == 525){
if(dini_Int(pname, "Profissao") == Mecanico || pAdmin[playerid] >= 3){
//IsTowTrucker[playerid]=1;
//TowTruckers = TowTruckers+1;
//SendClientMessage(playerid, Verde, "Bem Vindo Mecanico.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(modelo == 416){
if(dini_Int(pname, "Profissao") == Medico || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Bem Vindo Médico. Cuide bem de seus pacientes !.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(modelo == 582){
if(dini_Int(pname, "Profissao") == Jornalista || dini_Int(pname, "Profissao") == Fotografo || dini_Int(pname, "Profissao") == Reporter || dini_Int(pname, "Profissao") == Ancora || dini_Int(pname, "Profissao") == Meteorologista || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Bem Vindo Jornalista. Encubra as notícias !.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(modelo == 601){
if(dini_Int(pname, "Profissao") == Swat || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Bem Vindo Policial.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(modelo == 427){
if(dini_Int(pname, "Profissao") == Bope || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Bem Vindo Policial.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(modelo == 523){
if(dini_Int(pname, "Profissao") == Guarda || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Bem Vindo Policial.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(modelo == 601){
if(dini_Int(pname, "Profissao") == Swat || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Bem Vindo Policial.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(modelo == 599){
if(dini_Int(pname, "Profissao") == Delegado || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Bem Vindo Policial. Um Colete vai ajudar você.");
//SetPlayerArmour(playerid, 100);
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(modelo == 420){
if(dini_Int(pname, "Profissao") == Taxista || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Bem Vindo Taxista, use /ttaxi [id].");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(modelo == 586){
if(dini_Int(pname, "Profissao") == Taxista || pAdmin[playerid] >= 3){
//SendClientMessage(playerid, Verde, "Bem Vindo Taxista, use /ttaxi [id].");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não pode dirigir este veiculo.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
if(dini_Int(pname, "Combustivel") <= 0){
SendClientMessage(playerid, Vermelho, "Observação: Você não tem combustivel.");
} else {
if(modelo == 417 || modelo == 488 || modelo == 487 || modelo == 548 || modelo == 497 || modelo == 563 || modelo == 447 || modelo == 469 || modelo == 592 || modelo == 577 || modelo == 511 || modelo == 512 || modelo == 593 ||modelo == 520 || modelo == 553 || modelo == 476 || modelo == 519 || modelo == 460 || modelo == 513){
if(dini_Int(pname, "HabAerea") == 0){
SendClientMessage(playerid, Vermelho, "Observação: Você não tem habilitação aerea.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
} else {
if(modelo == 472 || modelo == 473 || modelo == 493 || modelo == 595 || modelo == 484 || modelo == 430 || modelo == 453 || modelo == 452 || modelo == 446 || modelo == 454){
if(dini_Int(pname, "HabNautica") == 0){
SendClientMessage(playerid, Vermelho, "Observação: Você não tem habilitação nautica.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
} else {
}
if(dini_Int(pname, "HabTerrestre") == 0){
if(modelo == 509 || modelo == 510 || modelo == 527 || modelo == 481){
if(modelo == 527){
if(emteste[playerid] == 1){
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não tem habilitação terrestre.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
//SendClientMessage(playerid, Vermelho, "Você está dirigindo uma bicicleta, por tanto, não presisa de habilitação.");
//SendClientMessage(playerid, Vermelho, "Compre habilitações perto da Delegacia, o simbolo de um carrinho azul.");
} else {
SendClientMessage(playerid, Vermelho, "Observação: Você não tem habilitação terrestre.");
SendClientMessage(playerid, Vermelho, "Observação: Cancele a entrada ou ganhará 1 nivel de procurado.");
}
}
}
}
return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
SendClientMessage(playerid, Vermelho, "Você saiu de um carro.");
if(emteste[playerid] == 1){
DestroyVehicle(vehicleid);
emteste[playerid] = 0;
SendClientMessage(playerid, Vermelho, "Seu teste foi cancelado pois você saiu do carro.");
}
return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    new checknome = CPS_GetPlayerCheckpoint(playerid);
    if(checknome == Reboque){
    SendClientMessage(playerid, Verde, "|___Philips - Reboque___|");
    GameTextForPlayer(playerid, "~w~Reboque", 5000, 6);
    SendClientMessage(playerid, COLOR_WHITE, "Esteja no carro e digite /rebocar.");
    }
    if(checknome == Banco) {
    SendClientMessage(playerid, Verde, "|___Philips - Banco___|");
    GameTextForPlayer(playerid, "~w~Banco", 5000, 6);      
    SendClientMessage(playerid, COLOR_WHITE, "Escolha o seu serviço.");     
    ShowPlayerDialog(playerid, 300, DIALOG_STYLE_LIST, "Banco", "Sacar \nDepositar \nVer Saldo \nAbrir Conta", "Solicitar", "Fechar");
    /*SendClientMessage(playerid, COLOR_WHITE, "Para depositar use /depositar");    
    SendClientMessage(playerid, COLOR_WHITE, "Para sacar use /sacar");    
    SendClientMessage(playerid, COLOR_WHITE, "Para ver seu saldo use /saldo");    
    SendClientMessage(playerid, COLOR_WHITE, "Para ver seu saldo por meio de SMS use /saldocell");    
    SendClientMessage(playerid, COLOR_WHITE, "Obs: Necessita ter uma conta bancária, e um celular para usar /saldocell.");    
    SendClientMessage(playerid, COLOR_WHITE, "Para abrir uma conta use /abrirconta.");      */
 }
if(checknome == academia) {
    SendClientMessage(playerid, Verde, "|___Philips - Academia___|");
    GameTextForPlayer(playerid, "~w~Academia", 5000, 6);
    ShowPlayerDialog(playerid, 890, DIALOG_STYLE_LIST, "Academia", "Boxe \nKung Fu \nKnee Head \nGrab Kick \nEl Bow", "Aprender", "Fechar");
    SendClientMessage(playerid, COLOR_WHITE, "Selecione o estilo de luta e aguarde. Custa R$650 para aprender.");
 }
 if(checknome == Pizzaria) {
    SendClientMessage(playerid, Verde, "|___Philips - Pizzaria___|");
    GameTextForPlayer(playerid, "~w~Pizzaria", 5000, 6);
    SendClientMessage(playerid, COLOR_WHITE, "Escolha a pizza.");
ShowPlayerDialog(playerid, 939, DIALOG_STYLE_LIST, "Pizzaria", "Mini Pizza R$:5,00 \nPizza pequena R$:10,00 \nPizza média R$:15,00 \nPizza grande R$:20,00 \nPizza gigante R$:30,00", "Comer", "Fechar");
 }
 if(checknome == Ammu) {
    SendClientMessage(playerid, Verde, "|___Philips - Ammu-nation___|");
    GameTextForPlayer(playerid, "~w~Ammu-nation", 5000, 6);
    SendClientMessage(playerid, COLOR_WHITE, "Escolha a arma.");
ShowPlayerDialog(playerid, 949, DIALOG_STYLE_LIST, "Ammu-nation", "9mm R$:149,00 \n9mm+silenciador R$:169,00 \nDeagle R$:349,00 \nMac 10 R$:399,00 \nMP5 R$:389,00 \nAK-47 R$:699,00 \nM4 R$:749,00 \nSniper R$:999,00 \nShotgun R$:489,00", "Comprar", "Fechar");
 }
 if(checknome == Burguer) {
    SendClientMessage(playerid, Verde, "|___Philips - Burguer Shot___|");
    GameTextForPlayer(playerid, "~w~Burguer Shot", 5000, 6);
    SendClientMessage(playerid, COLOR_WHITE, "Escolha o hamburguer.");
ShowPlayerDialog(playerid, 939, DIALOG_STYLE_LIST, "Burguer-shot", "Hamburguer Simples R$:5,00 \nHamburguer de Frango R$:10,00 \nHamburguer Grande R$:15,00 \nHamburguer de Picanha R$:20,00 \nBig Philips R$:30,00", "Comer", "Fechar");
 }
    if(checknome == pc1) {
     ShowPlayerDialog(playerid, 878, DIALOG_STYLE_LIST, "Lan House Philips RPG", "Counter Strike\nStunt R$:100\nMotocross R$:100\nCorrida de moto R$:100", "Jogar", "Sair");
    }
    if(checknome == pc2) {
    ShowPlayerDialog(playerid, 878, DIALOG_STYLE_LIST, "Lan House Philips RPG", "Counter Strike\nStunt R$:100\nMotocross R$:100\nCorrida de moto R$:100", "Jogar", "Sair");
    }
    if(checknome == pc3) {
    ShowPlayerDialog(playerid, 878, DIALOG_STYLE_LIST, "Lan House Philips RPG", "Counter Strike\nStunt R$:100\nMotocross R$:100\nCorrida de moto R$:100", "Jogar", "Sair");
     }
    if(checknome == pc4) {
    ShowPlayerDialog(playerid, 878, DIALOG_STYLE_LIST, "Lan House Philips RPG", "Counter Strike\nStunt R$:100\nMotocross R$:100\nCorrida de moto R$:100", "Jogar", "Sair");
    }
     if(checknome == Depositar) {
     ShowPlayerDialog(playerid, 300, DIALOG_STYLE_LIST, "Banco", "Sacar \nDepositar \nVer Saldo \nAbrir Conta", "Solicitar", "Ir embora");
     }     
     if(checknome == fe) {
     new string[256];  
     new Float:vidacarro;
     GetVehicleHealth(GetPlayerVehicleID(playerid), vidacarro);     
     if(emteste[playerid] == 1){          
     if(vidacarro > 849 && IsPlayerInAnyVehicle(playerid)){       
     emteste[playerid] = 0;
     format(string, sizeof(string), "Você passou no teste,parabens\nVocê deseja adiquirir a habilitação? custo R$500");
     ShowPlayerDialog(playerid, 792, DIALOG_STYLE_MSGBOX, "|___Teste Concluido___|", string, "SIM", "NÃO");
     DestroyVehicle(GetPlayerVehicleID(playerid));        
     } else {      
     DestroyVehicle(GetPlayerVehicleID(playerid));      
     emteste[playerid] = 0;
     SendClientMessage(playerid, Vermelho, "Seu carro tomou muitos danos, por isso foi reprovado.");    
     }
     }else{                   
     emteste[playerid] = 0;
     SendClientMessage(playerid, Verde, "Você não esta em teste.");
     }      
     }
    if(checknome == Sacar) {
    ShowPlayerDialog(playerid, 300, DIALOG_STYLE_LIST, "Banco", "Sacar \nDepositar \nVer Saldo \nAbrir Conta", "Solicitar", "Ir embora");
     }
    if(checknome == hotel) {
    ShowPlayerDialog(playerid, 55, DIALOG_STYLE_LIST, "Hotel Philips", "Alugar Um Quarto \nPara De Alugar", "Confirmar", "Sair");
    }
   if(checknome == Telefone) {
    SendClientMessage(playerid, Verde, "|___Philips - Telefone___|");
    GameTextForPlayer(playerid, "~w~Telefone", 5000, 6);
    SendClientMessage(playerid, COLOR_WHITE, "Telefone usando /telefonar [id] [mensagem]");    
    SendClientMessage(playerid, COLOR_WHITE, "Para telefonar necessita cartão telefonico.");
    SendClientMessage(playerid, COLOR_WHITE, "Você pode telefonar de qualquer lugar com um celular."); 
    SendClientMessage(playerid, COLOR_WHITE, "Compre um na loja de utilidades.");   
 } 
 if(checknome == Loja) {
    SendClientMessage(playerid, Verde, "|___Philips - Loja___|");
    GameTextForPlayer(playerid, "~w~Loja de Utilidades", 5000, 6);
    SendClientMessage(playerid, COLOR_WHITE, "Compre avontade.");
    ShowPlayerDialog(playerid, 3300, DIALOG_STYLE_LIST, "Philips - Loja", "Celular(350R$) \nCartão telefonico 20 créditos(10R$) \nMP3(150R$) \nBloco de Lembretes(5R$)", "Comprar", "Cancelar");  
 }  
 if(checknome == Faculdade) {
    SendClientMessage(playerid, Verde, "|___Philips - Faculdade___|");
    GameTextForPlayer(playerid, "~w~Faculdade", 5000, 6);
    SendClientMessage(playerid, COLOR_WHITE, "Digite /aprender para começar seu estudo.");      
    SendClientMessage(playerid, COLOR_WHITE, "A mensal da faculdade é 700 R$.");
    SendClientMessage(playerid, COLOR_WHITE, "Os professores compram jornais para sempre ficarem informados.");
    SendClientMessage(playerid, COLOR_WHITE, "Pegue um jornal na Philips News, e venda para eles ! /venderjornal");     
 }
 if(checknome == HabLocal) {
    SendClientMessage(playerid, Verde, "|___Philips - Habilitações___|");
    GameTextForPlayer(playerid, "~w~habilitacoes", 5000, 6);
    SendClientMessage(playerid, COLOR_WHITE, "Escolha a habilitação e clique em Comprar.");     
    ShowPlayerDialog(playerid, 4400, DIALOG_STYLE_LIST, "Philips - Habilitações", "Terrestre R$:500 \nAerea R$:550 \nNautica R$:550", "Comprar", "Cancelar");  
 }
 if(checknome == Shopping) {
    SendClientMessage(playerid, Verde, "|___Philips - Shopping___|");
    GameTextForPlayer(playerid, "~w~shopping", 5000, 6);
    SendClientMessage(playerid, COLOR_WHITE, "Digite a skin e clique em Comprar, cada skin custa R$:50.");     
    ShowPlayerDialog(playerid, 5500, DIALOG_STYLE_INPUT, "Skin", "Bem-vindo(a).\n\nDigite o skin a escolha e clique em \"Comprar\". \n\n~ Philips RPG !.", "Comprar", "Voltar"); 
 }
 if(checknome == profis) {
    SendClientMessage(playerid, Verde, "|___Agência de empregos___|");
    GameTextForPlayer(playerid, "~w~agencia de empregos", 5000, 6);
    new nomepl[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nomepl, sizeof(nomepl));
    SendClientMessage(playerid, Vermelho, "Escolha sua profissão.");
     ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "Agência de Empregos", "Honestas \nPoliciais \nCriminosas \nVendas", "Selecionar", "Voltar");       
   // ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "Agência de Empregos", "Estágiario \nGuarda(Policia) \nPolicial Rodoviário(Policia) \nPolicial Militar(Policia) \nPolicial Civil(Policia) \nPolicial Federal(Policia) \nDelegado(Policia) \nBOPE(Policia) \nSWAT(Policia) \nNarcoticos(Policia) \nTraficante de Armas(Crime) \nAssasino(Crime) \nTerrorista(Crime) \nSequestrador(Crime) \nAssasino Profissional(Crime) \nPróximas >>", "Aceitar", "Voltar");       
 } 
 if(checknome == Pescaria) {
    SendClientMessage(playerid, Verde, "|___Local da Pesca___|");
    GameTextForPlayer(playerid, "~w~pescaria", 5000, 6);
    new nomepl[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nomepl, sizeof(nomepl));
    SendClientMessage(playerid, Vermelho, "Digite /pescar para começar a pescar.");    
    SendClientMessage(playerid, Vermelho, "Pesque e relaxe... Depois venda na cooperativa.");
 } 
 if(checknome == VendaPesca) {
    SendClientMessage(playerid, Verde, "|___Cooperativa de Pesca___|");
    GameTextForPlayer(playerid, "~w~cooperativa de pesca", 5000, 6);
    new nomepl[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nomepl, sizeof(nomepl));
    SendClientMessage(playerid, Vermelho, "Digite /venderpesca para vender o que pescou.");    
 } 
 if(checknome == localjornal) {
    SendClientMessage(playerid, Verde, "|___Philips News___|");
    GameTextForPlayer(playerid, "~w~Philips news", 5000, 6);
    new nomepl[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nomepl, sizeof(nomepl));
    SendClientMessage(playerid, Vermelho, "Digite /pegarjornal para pegar um jornal para vender.");    
 }
 if(checknome == areadm) {
    SendClientMessage(playerid, Verde, "|___Philips - Área DM___|");
    GameTextForPlayer(playerid, "~w~area dm", 5000, 6);
    new nomepl[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nomepl, sizeof(nomepl));
    SendClientMessage(playerid, Vermelho, "Digite /entrardm e pague 30 reais para entrar.");    
 }  
 if(checknome == carga) {
    SendClientMessage(playerid, Verde, "|___Philips - Área de Carga___|");
    GameTextForPlayer(playerid, "~w~area carga", 5000, 6);
    new nomepl[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nomepl, sizeof(nomepl));
    SendClientMessage(playerid, Vermelho, "Digite /pegarcarga e pegue a carga.");    
 }  
 if(checknome == discarga) {
    SendClientMessage(playerid, Verde, "|___Philips - Área de Discarga___|");
    GameTextForPlayer(playerid, "~w~area discarga", 5000, 6);
    new nomepl[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nomepl, sizeof(nomepl));
    SendClientMessage(playerid, Vermelho, "Digite /vendercarga e venda por 250 reais.");    
 }
 if(checknome == armas) {
    SendClientMessage(playerid, Verde, "|___Philips - Loja de defesas___|");
    GameTextForPlayer(playerid, "~w~loja de defesas", 5000, 6);
    new nomepl[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nomepl, sizeof(nomepl));
    SendClientMessage(playerid, Vermelho, "Compre armas brancas.");
    SendClientMessage(playerid, Vermelho, "/faca = Compre uma Faca por 20R$");   
    SendClientMessage(playerid, Vermelho, "/espada = Compre uma Espada por 100R$");  
    SendClientMessage(playerid, Vermelho, "/bastao = Compre um Bastão de Beisebol por 75R$");
    SendClientMessage(playerid, Vermelho, "/taco = Compre um Taco de golfe por 80R$");
    SendClientMessage(playerid, Vermelho, "/pa = Compre uma Pá por 95R$"); 
    SendClientMessage(playerid, Vermelho, "/sinuca = Compre um Taco de sinuca por 70R$"); 
    SendClientMessage(playerid, Vermelho, "/serra = Compre uma Serra Eletrica por 200R$");         
 }                                                                       
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid, X, Y, Z);
//PlayerPlaySound(playerid,1063,X,Y,Z);
new STRX[256];
if(dialogid == 949){
if(response){
if(listitem == 0){
if(GetPlayerPCash(playerid) >= 149){
SendClientMessage(playerid, Amarelo, "Você comprou uma arma, agradecemos a preferencia !");
GivePlayerPCash(playerid, -149);
GivePlayerWeapon(playerid, 22, 50);
} else {
SendClientMessage(playerid, Vermelho, "Desculpe, não vendemos fiado. Você não tem dinheiro.");
}
}
if(listitem == 1){
if(GetPlayerPCash(playerid) >= 169){
SendClientMessage(playerid, Amarelo, "Você comprou uma arma, agradecemos a preferencia !");
GivePlayerPCash(playerid, -169);
GivePlayerWeapon(playerid, 23, 50);
} else {
SendClientMessage(playerid, Vermelho, "Desculpe, não vendemos fiado. Você não tem dinheiro.");
}
}
if(listitem == 2){
if(GetPlayerPCash(playerid) >= 349){
SendClientMessage(playerid, Amarelo, "Você comprou uma arma, agradecemos a preferencia !");
GivePlayerPCash(playerid, -349);
GivePlayerWeapon(playerid, 24, 50);
} else {
SendClientMessage(playerid, Vermelho, "Desculpe, não vendemos fiado. Você não tem dinheiro.");
}
}
if(listitem == 3){
if(GetPlayerPCash(playerid) >= 399){
SendClientMessage(playerid, Amarelo, "Você comprou uma arma, agradecemos a preferencia !");
GivePlayerPCash(playerid, -399);
GivePlayerWeapon(playerid, 28, 300);
} else {
SendClientMessage(playerid, Vermelho, "Desculpe, não vendemos fiado. Você não tem dinheiro.");
}
}
if(listitem == 4){
if(GetPlayerPCash(playerid) >= 389){
SendClientMessage(playerid, Amarelo, "Você comprou uma arma, agradecemos a preferencia !");
GivePlayerPCash(playerid, -389);
GivePlayerWeapon(playerid, 29, 300);
} else {
SendClientMessage(playerid, Vermelho, "Desculpe, não vendemos fiado. Você não tem dinheiro.");
}
}
if(listitem == 5){
if(GetPlayerPCash(playerid) >= 699){
SendClientMessage(playerid, Amarelo, "Você comprou uma arma, agradecemos a preferencia !");
GivePlayerPCash(playerid, -699);
GivePlayerWeapon(playerid, 30, 500);
} else {
SendClientMessage(playerid, Vermelho, "Desculpe, não vendemos fiado. Você não tem dinheiro.");
}
}
if(listitem == 6){
if(GetPlayerPCash(playerid) >= 749){
SendClientMessage(playerid, Amarelo, "Você comprou uma arma, agradecemos a preferencia !");
GivePlayerPCash(playerid, -749);
GivePlayerWeapon(playerid, 31, 500);
} else {
SendClientMessage(playerid, Vermelho, "Desculpe, não vendemos fiado. Você não tem dinheiro.");
}
}
if(listitem == 7){
if(GetPlayerPCash(playerid) >= 999){
SendClientMessage(playerid, Amarelo, "Você comprou uma arma, agradecemos a preferencia !");
GivePlayerPCash(playerid, -999);
GivePlayerWeapon(playerid, 34, 100);
} else {
SendClientMessage(playerid, Vermelho, "Desculpe, não vendemos fiado. Você não tem dinheiro.");
}
}
if(listitem == 8){
if(GetPlayerPCash(playerid) >= 489){
SendClientMessage(playerid, Amarelo, "Você comprou uma arma, agradecemos a preferencia !");
GivePlayerPCash(playerid, -489);
GivePlayerWeapon(playerid, 25, 100);
} else {
SendClientMessage(playerid, Vermelho, "Desculpe, não vendemos fiado. Você não tem dinheiro.");
}
}
}
}
if(dialogid == 4755){
if(response){
if(listitem == 0){
if(kitblock[playerid] == 0){
GivePlayerWeapon(playerid, 34, 99999);
GivePlayerWeapon(playerid, 24, 99999);
GivePlayerWeapon(playerid, 30, 99999);
GivePlayerWeapon(playerid, 25, 99999);
GivePlayerWeapon(playerid, 28, 99999);
GivePlayerWeapon(playerid, 39, 99999);
GivePlayerWeapon(playerid, 40, 99999);
GivePlayerWeapon(playerid, 46, 99999);
GivePlayerWeapon(playerid, 41, 99999);
GivePlayerWeapon(playerid, 14, 99999);
GivePlayerWeapon(playerid, 1, 99999);
GivePlayerWeapon(playerid, 43, 99999);
kitblock[playerid] = 1;
SendClientMessage(playerid,Verde, "Você pegou kit vip.");
return 1;
} else {
SendClientMessage(playerid,Vermelho, "Aguarde 5 minutos para usar este comando novamente.");
}
}
if(listitem == 1){
if(vcblock[playerid] == 0){
SetPlayerHealth(playerid, 100);
SetPlayerArmour(playerid, 100);
vcblock[playerid] = 1;
SendClientMessage(playerid,Verde, "Você pegou colete e vida.");
return 1;
} else {
SendClientMessage(playerid,Vermelho, "Aguarde 5 minutos para usar este comando novamente.");
}
}
if(listitem == 2){
ShowPlayerDialog(playerid, 300, DIALOG_STYLE_LIST, "Banco", "Sacar \nDepositar \nVer Saldo \nAbrir Conta", "Solicitar", "Fechar");
}
if(listitem == 3){
ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "Agência de Empregos", "Honestas \nPoliciais \nCriminosas \nVendas", "Selecionar", "Voltar");
}
}
}
if(dialogid == 890){
if(response){
if(listitem == 0)  //Boxe
{
if(GetPlayerPCash(playerid) >= 650){
GivePlayerPCash(playerid, -650);
TogglePlayerControllable(playerid, 0);
SendClientMessage(playerid, Azul, "Durante 5 minutos você irá ficar aprendendo.");
SetTimerEx("lutinha", 300000, 0, "dd", playerid, 5);
} else {
SendClientMessage(playerid, Vermelho, "Você não tem R$650");
}
}
if(listitem == 1)  //Kung fu
{
if(GetPlayerPCash(playerid) >= 650){
GivePlayerPCash(playerid, -650);
TogglePlayerControllable(playerid, 0);
SendClientMessage(playerid, Azul, "Durante 5 minutos você irá ficar aprendendo.");
SetTimerEx("lutinha", 300000, 0, "dd", playerid, 6);
} else {
SendClientMessage(playerid, Vermelho, "Você não tem R$650");
}
}
if(listitem == 2)  //Knee Head
{
if(GetPlayerPCash(playerid) >= 650){
GivePlayerPCash(playerid, -650);
TogglePlayerControllable(playerid, 0);
SendClientMessage(playerid, Azul, "Durante 5 minutos você irá ficar aprendendo.");
SetTimerEx("lutinha", 300000, 0, "dd", playerid, 7);
} else {
SendClientMessage(playerid, Vermelho, "Você não tem R$650");
}
}
if(listitem == 3)  //Grab Kick
{
if(GetPlayerPCash(playerid) >= 650){
GivePlayerPCash(playerid, -650);
TogglePlayerControllable(playerid, 0);
SendClientMessage(playerid, Azul, "Durante 5 minutos você irá ficar aprendendo.");
SetTimerEx("lutinha", 300000, 0, "dd", playerid, 15);
} else {
SendClientMessage(playerid, Vermelho, "Você não tem R$650");
}
}
if(listitem == 4)  //El bow
{
if(GetPlayerPCash(playerid) >= 650){
GivePlayerPCash(playerid, -650);
TogglePlayerControllable(playerid, 0);
SendClientMessage(playerid, Azul, "Durante 5 minutos você irá ficar aprendendo.");
SetTimerEx("lutinha", 300000, 0, "dd", playerid, 26);
} else {
SendClientMessage(playerid, Vermelho, "Você não tem R$650");
}
}
}
}

if(dialogid == 939){
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(playerid, nomepl, MAX_PLAYER_NAME);
if(response){
if(listitem == 0)  //Mini Pizza
{
if(GetPlayerPCash(playerid) >= 5){
GivePlayerPCash(playerid, -5);
SendClientMessage(playerid, Verde, "Você fez um lanche !");
if(dini_Int(nomepl, "Fome")-2 >= 0){
dini_IntSet(nomepl, "Fome", dini_Int(nomepl, "Fome")-2);
} else {
dini_IntSet(nomepl, "Fome", 0);
}
} else {
SendClientMessage(playerid, Vermelho, "Você não tem R$5");
}
}
if(listitem == 1)  //Pizza Pequena
{
if(GetPlayerPCash(playerid) >= 10){
GivePlayerPCash(playerid, -10);
SendClientMessage(playerid, Verde, "Você fez um lanche !");
if(dini_Int(nomepl, "Fome")-3 >= 0){
dini_IntSet(nomepl, "Fome", dini_Int(nomepl, "Fome")-3);
} else {
dini_IntSet(nomepl, "Fome", 0);
}
} else {
SendClientMessage(playerid, Vermelho, "Você não tem R$10");
}
}
if(listitem == 2)  //Pizza média
{
if(GetPlayerPCash(playerid) >= 15){
GivePlayerPCash(playerid, -15);
SendClientMessage(playerid, Verde, "Você fez um lanche !");
if(dini_Int(nomepl, "Fome")-4 >= 0){
dini_IntSet(nomepl, "Fome", dini_Int(nomepl, "Fome")-4);
} else {
dini_IntSet(nomepl, "Fome", 0);
}
} else {
SendClientMessage(playerid, Vermelho, "Você não tem R$15");
}
}
if(listitem == 3)  //Pizza grande
{
if(GetPlayerPCash(playerid) >= 20){
GivePlayerPCash(playerid, -20);
SendClientMessage(playerid, Verde, "Você fez um lanche !");
if(dini_Int(nomepl, "Fome")-5 >= 0){
dini_IntSet(nomepl, "Fome", dini_Int(nomepl, "Fome")-5);
} else {
dini_IntSet(nomepl, "Fome", 0);
}
} else {
SendClientMessage(playerid, Vermelho, "Você não tem R$20");
}
}
if(listitem == 4)  //Pizza gigante
{
if(GetPlayerPCash(playerid) >= 30){
GivePlayerPCash(playerid, -30);
SendClientMessage(playerid, Verde, "Você fez um lanche !");
if(dini_Int(nomepl, "Fome")-7 >= 0){
dini_IntSet(nomepl, "Fome", dini_Int(nomepl, "Fome")-7);
} else {
dini_IntSet(nomepl, "Fome", 0);
}
} else {
SendClientMessage(playerid, Vermelho, "Você não tem R$30");
}
}
}
}
	if(dialogid == 55) // Menu
	        {
		    if(response)
		    {
         	if(listitem == 0)
			{
             new nomepl[MAX_PLAYER_NAME];    
             GetPlayerName(playerid, nomepl, MAX_PLAYER_NAME);
             new string[256];
            new grana;
            grana = GetPlayerPCash(playerid);
            if(grana > 7000){
			dini_IntSet(nomepl, "Hotel", 1);
		    format(string, sizeof(string), "Caro Senhor (a) %s Você Acaba De Alugar Um quarto No Hotel Do Philips RPG", nomepl);
            SendClientMessage(playerid, AZULBLUE, string);
            GivePlayerPCash(playerid, -7000);
            } else {
		    SendClientMessage(playerid, Vermelho, "Você não tem dinheiro para alugar um quarto no Hotel Presisa De R$7000 ");
		    }
		    }
		    if(listitem == 1)
			{
            new string[256];
            new nomepl[MAX_PLAYER_NAME];    
            GetPlayerName(playerid, nomepl, MAX_PLAYER_NAME);      
            if(dini_Int(nomepl, "Hotel") > 0)
			{
            dini_IntSet(nomepl, "Hotel", 0);
			format(string, sizeof(string), "Senhor (a) %s Obrigado por Morar aqui esse tempo , o Hotel Philips Agradece", nomepl);
            SendClientMessage(playerid, AZULBLUE, string);
			}
			else
			{
			SendClientMessage(playerid, Vermelho, "Você não esta Hospedado No Hotel!");
			}
			}
			}
			}
   if(dialogid == 4501) // Menu
	        {
            new string[256];
		    if(response)
		    {
         	if(listitem == 0) //Salvar posição
			{
            if(IsPlayerInAnyVehicle(playerid)){
            new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            new Float:carroX,Float:carroY,Float:carroZ,Float:carroA;
            new vid;
            vid = GetPlayerVehicleID(playerid);
            GetVehiclePos(vid, carroX, carroY, carroZ);
            GetVehicleZAngle(vid, carroA);
            new pname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
            for(new carro = 0; carro < MAX_CARROS; carro++)
            {
            format(string, sizeof(string), "carro%d.ini", carro);
            if(strcmp(dini_Get(string, "Dono"), pname, true) == 0 && GetPlayerVehicleID(playerid) == dini_Int(string, "Id")){
            dini_FloatSet(string, "CordX", Float:carroX);
            dini_FloatSet(string, "CordY", Float:carroY);
            dini_FloatSet(string, "CordZ", Float:carroZ);
            dini_FloatSet(string, "Angulo", Float:carroA);
            SendClientMessage(playerid, Verde, "Seu carro foi salvo na sua posição.");
            }
            }
            } else {
            SendClientMessage(playerid, Vermelho, "Para salvar a posição você presisa estar no seu carro.");
            }
			}
			if(listitem == 1)    //Alterar cor 1
			{
            format(STRX, sizeof(STRX), "Alterar Cor 1\n\nDigite o número da cor desejada e aperte \"Alterar\".\n\n ~ Philips RPG!");
            ShowPlayerDialog(playerid, 4502, DIALOG_STYLE_INPUT, "Meu Carro", STRX, "Alterar", "Cancelar");
            }
            if(listitem == 2)  //Alterar cor 2
            {
            format(STRX, sizeof(STRX), "Alterar Cor 2\n\nDigite o número da cor desejada e aperte \"Alterar\".\n\n ~ Philips RPG!");
            ShowPlayerDialog(playerid, 4503, DIALOG_STYLE_INPUT, "Meu Carro", STRX, "Alterar", "Cancelar");
            }
            if(listitem == 3) // Respawnar carro
            {
            new pname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
            for(new carro = 0; carro < MAX_CARROS; carro++)
            {
            format(string, sizeof(string), "carro%d.ini", carro);
            if(strcmp(dini_Get(string, "Dono"), pname, true) == 0){
            DestroyVehicle(dini_Int(string, "Id"));
            new carroid;
            carroid = AddStaticVehicle(dini_Int(string, "Modelo"), dini_Float(string, "CordX"), dini_Float(string, "CordY"), dini_Float(string, "CordZ"), dini_Float(string, "Angulo"), dini_Int(string, "Cor1"), dini_Int(string, "Cor2"));
            dini_IntSet(string, "Id", carroid);
            }
            }
            SendClientMessage(playerid, Amarelo, "Carro respawnado !");
            }
            if(listitem == 4) // Vender carro
            {
            new pname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
            for(new carro = 0; carro < MAX_CARROS; carro++)
            {
            format(string, sizeof(string), "carro%d.ini", carro);
            if(strcmp(dini_Get(string, "Dono"), pname, true) == 0){
            dini_Set(string, "Dono", "Nenhum");
            dini_IntSet(string, "TDono", 0);
            dini_IntSet(pname, "TCarro", 0);
            GivePlayerPCash(playerid, dini_Int(string, "Preco") / 2);
            }
            }
            }
			}
            }
            if(dialogid == 4502)
{
new string[256];
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(playerid, nomepl, sizeof(nomepl));
if(response == 1)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, sizeof(aname));
if(!IsNumeric(inputtext)){
SendClientMessage(playerid, Vermelho, "Philips RPG - Valor inválido.");
return 1;
} else {
for(new carro = 0; carro < MAX_CARROS; carro++)
{
format(string, sizeof(string), "carro%d.ini", carro);
if(strcmp(dini_Get(string, "Dono"), aname, true) == 0){
dini_IntSet(string, "Cor1", StrToInt(inputtext));
ChangeVehicleColor(dini_Int(string, "Id"), dini_Int(string, "Cor1"), dini_Int(string, "Cor2"));
}
}
}
}
}
if(dialogid == 4503)
{
new string[256];
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(playerid, nomepl, sizeof(nomepl));
if(response == 1)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, sizeof(aname));
if(!IsNumeric(inputtext)){
SendClientMessage(playerid, Vermelho, "Philips RPG - Valor inválido.");
return 1;
} else {
for(new carro = 0; carro < MAX_CARROS; carro++)
{
format(string, sizeof(string), "carro%d.ini", carro);
if(strcmp(dini_Get(string, "Dono"), aname, true) == 0){
dini_IntSet(string, "Cor2", StrToInt(inputtext));
ChangeVehicleColor(dini_Int(string, "Id"), dini_Int(string, "Cor1"), dini_Int(string, "Cor2"));
}
}
}
}
}
  if(dialogid == 878) // Menu
	        {
		    if(response)
		    {
         	if(listitem == 0)
			{
            ShowPlayerDialog(playerid, 879, DIALOG_STYLE_LIST, "CS MAPAS", "Head-ShoT\nD-DusT2", "Jogar", "Sair");
			}
			if(listitem == 1)
			{
            new grana;            
            grana = GetPlayerPCash(playerid);            
            if(grana > 99){ 
            GivePlayerPCash(playerid, -100);
            naarena[playerid] = 1;
            SendClientMessage(playerid, Amarelo, "Você agora está no Stunt, para sair use /sairjogo");
            SetPlayerInterior(playerid, 14);
            SetPlayerPos(playerid,-1465.268676,1557.868286,1052.531250);
            new moto;
            moto = AddStaticVehicle(522,-1465.268676,1557.868286,1052.531250,0.0,3,3);
            LinkVehicleToInterior(moto, 14);              
            namoto[playerid] = moto;
            PutPlayerInVehicle(playerid, moto, 0);            
            }
			}
            if(listitem == 2)
			{
            new grana;            
            grana = GetPlayerPCash(playerid);            
            if(grana > 99){ 
            GivePlayerPCash(playerid, -100);
            naarena[playerid] = 1;
            SendClientMessage(playerid, Amarelo, "Você agora está no Motocross, para sair use /sairjogo");
            SetPlayerInterior(playerid, 4);
            SetPlayerPos(playerid,-1444.645507,-664.526000,1053.572998);
            new moto;
            moto = AddStaticVehicle(468,-1444.645507,-664.526000,1053.572998,0.0,3,3);
            LinkVehicleToInterior(moto, 4);              
            namoto[playerid] = moto;
            PutPlayerInVehicle(playerid, moto, 0);            
            }
			}
            if(listitem == 3)
			{
            new grana;            
            grana = GetPlayerPCash(playerid);            
            if(grana > 99){ 
            GivePlayerPCash(playerid, -100);
            naarena[playerid] = 1;
            SendClientMessage(playerid, Amarelo, "Você agora está na Corrida de Moto, para sair use /sairjogo");
            SetPlayerInterior(playerid, 7);
            SetPlayerPos(playerid,-1398.065307,-217.028900,1051.115844);
            new moto;
            moto = AddStaticVehicle(522,-1398.065307,-217.028900,1051.115844,0.0,2,2);
            LinkVehicleToInterior(moto, 7);              
            namoto[playerid] = moto;
            PutPlayerInVehicle(playerid, moto, 0);            
            }
			}
			}
   }
			if(dialogid == 879) // Menu
	        {
		    if(response)
		    {
         	if(listitem == 0)
			{
            ShowPlayerDialog(playerid, 888, DIALOG_STYLE_LIST, "HEAD SHOT", "TERRORISTA R$100\nCT R$100", "Jogar", "Sair");
			}
			if(listitem == 1)
			{
			ShowPlayerDialog(playerid, 887, DIALOG_STYLE_LIST, "D-DusT2", "CT R$100\nTERRORISTA R$100", "Jogar", "Sair");

			}
			}
			}
            if(dialogid == 887) // Menu
	        {
		    if(response)
		    {
            if(listitem == 0)
			{
            new grana;
			grana = GetPlayerPCash(playerid);
    		if(grana > 99)
			{
            SendClientMessage(playerid, Verde, "Voce Virou CT,mate os terrorista");
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, -358.2130,2253.3440,42.4844);
            ResetPlayerWeapons(playerid);
            GivePlayerWeapon(playerid, 23, 999999);
            GivePlayerWeapon(playerid, 29, 999999);
            GivePlayerWeapon(playerid, 34, 999999);
            GivePlayerWeapon(playerid, 25, 999999);
		    GivePlayerWeapon(playerid, 31, 999999);
			SetPlayerSkin(playerid,285);
            SetPlayerArmour(playerid,200);
            SetPlayerHealth(playerid,100);
			cs4[playerid] = 1;
		   	GivePlayerPCash(playerid, -100);
			 } else{
			SendClientMessage(playerid, Vermelho, "Você não tem dinheiro para jogar presisa de R$100");
			}
			}
			if(listitem == 1)
			{
            new grana;
			grana = GetPlayerPCash(playerid);
    		if(grana > 99)
			{
           SendClientMessage(playerid, Verde, "Voce viro TERRORIS,Tente matar os CTS");
		   SetPlayerInterior(playerid, 0);
           SetPlayerPos(playerid, -453.9510,2200.1616,43.7733);
           ResetPlayerWeapons(playerid);
           GivePlayerWeapon(playerid, 28, 999999);
           GivePlayerWeapon(playerid, 33, 999999);
           GivePlayerWeapon(playerid, 25, 999999);
           GivePlayerWeapon(playerid, 27, 999999);
           GivePlayerWeapon(playerid, 30, 999999);
           SetPlayerSkin(playerid,136);
           SetPlayerArmour(playerid,200);
           SetPlayerHealth(playerid,100);
		   cs3[playerid] = 1;
		   GivePlayerPCash(playerid, -100);
			} else{
			SendClientMessage(playerid, Vermelho, "Você não tem dinheiro para jogar presisa de R$100");
			}
			}
			}
			}
		   if(dialogid == 888) // Menu
	       {
		   if(response)
		   {
           if(listitem == 0)
		   {
           new grana;
		   grana = GetPlayerPCash(playerid);
    	   if(grana > 99)
		   {
           SendClientMessage(playerid, Verde, "Voce viro TERRORIS,Tente matar os CTS");
           SetPlayerInterior(playerid, 1);
           SetPlayerPos(playerid, 1365.7126464844,-22.462772369385,1000.921875);
           ResetPlayerWeapons(playerid);
           GivePlayerWeapon(playerid, 28, 999999);
           GivePlayerWeapon(playerid, 33, 999999);
           GivePlayerWeapon(playerid, 25, 999999);
           GivePlayerWeapon(playerid, 27, 999999);
           GivePlayerWeapon(playerid, 30, 999999);
           SetPlayerSkin(playerid,136);
           SetPlayerArmour(playerid,200);
           SetPlayerHealth(playerid,100);
		   cs2[playerid] = 1;
   		   GivePlayerPCash(playerid, -100);
		   } else{
		   SendClientMessage(playerid, Vermelho, "Você não tem dinheiro para jogar presisa de R$100");
		   }
		   }
		   if(listitem == 1)
		   {
           new grana;
		   grana = GetPlayerPCash(playerid);
    	   if(grana > 99)
		   {
           SendClientMessage(playerid, Verde, "Voce Virou CT,mate os terrorista");
           SetPlayerInterior(playerid, 1);
           SetPlayerPos(playerid, 1408.1414794922,-22.053915023804,1000.9221801758);
           ResetPlayerWeapons(playerid);
           GivePlayerWeapon(playerid, 23, 999999);
           GivePlayerWeapon(playerid, 29, 999999);
           GivePlayerWeapon(playerid, 34, 999999);
           GivePlayerWeapon(playerid, 25, 999999);
		   GivePlayerWeapon(playerid, 31, 999999);
           SetPlayerSkin(playerid,285);
           SetPlayerArmour(playerid,200);
           SetPlayerHealth(playerid,100);
		   cs1[playerid] = 1;
           GivePlayerPCash(playerid, -100);
		   } else{
		   SendClientMessage(playerid, Vermelho, "Você não tem dinheiro para jogar presisa de R$100");
		   }
		   }
		   }
		   }
if(dialogid == 3)
{
if(response == 1)
{
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(playerid, nomepl, sizeof(nomepl));
if(dini_Exists(nomepl))
{
format(STRX, sizeof(STRX), "Bem-vindo(a) novamente, %s! Logue-se para jogar.\n\nDigite sua senha e clique em \"Logar\". \n\n~ Philips RPG!.", nomepl);
ShowPlayerDialog(playerid, 2, DIALOG_STYLE_INPUT, "Logar", STRX, "Logar", "Sair");
}
else
{
if(!dini_Exists(nomepl)){
format(STRX, sizeof(STRX), "Você não é registrado, %s!\n\nEscolha uma senha e clique em \"Registrar\".\n\n ~ Philips RPG!", nomepl);
ShowPlayerDialog(playerid, 1, DIALOG_STYLE_INPUT, "Registrar", STRX, "Registrar", "Sair");
}
}
}
}
if(dialogid == 800)
{
if(response == 1)
{
if(evento == 1){
SetPlayerPos(playerid, eventoX, eventoY, eventoZ);
noevento[playerid] = 1;
SendClientMessage(playerid, Azul, "Evento: Bem Vindo ao evento, aguarde instruções.");
} else {
SendClientMessage(playerid, Vermelho, "Evento: Desculpe, o evento foi cancelado...");
}
}
}
if(dialogid == 889)
{
if(response == 1)
{
new string[256];
tutorial[playerid] = tutorial[playerid]+1;
if(tutorial[playerid] == 1){
SetPlayerPos(playerid, 836.7571,-2065.4785,12.8672);
format(string, sizeof(string), "Você foi teleportado até o local da pesca.\nAqui é um dos locais em que você pode upar,\noutros, você irá aprender no futuro de sua jornada.\nQuando sua rede voltar, poderá pescar mais.\nQuando acabar de pescar venda seus peixes.");
ShowPlayerDialog(playerid, 889, DIALOG_STYLE_MSGBOX, "|___Tutorial___|", string, "Próximo", "Cancelar");
}
if(tutorial[playerid] == 2){
SetPlayerPos(playerid, 387.0509,-1837.0605,7.8359);
format(string, sizeof(string), "Você foi teleportado até o local da venda de pesca.\nAqui é onde você irá vender seus peixes, quando não quiser mais pescar.\napós vender uma certa quantia de peixes\nvocê irá receber 1 de exp, você também ganha 1 de exp por jogar a cada 15 minutos.\nQuando checar a 5 de exp, você irá subir de nivel.");
ShowPlayerDialog(playerid, 889, DIALOG_STYLE_MSGBOX, "|___Tutorial___|", string, "Próximo", "Cancelar");
}
if(tutorial[playerid] == 3){
SetPlayerPos(playerid, 328.0012,-1513.7246,36.0391);
format(string, sizeof(string), "Você foi teleportado até a faculdade.\nAqui é onde você irá estudar para conseguir empregos melhores.\nDurante sua aula você poderá falar 3 vezes.\nSe falar mais o professor irá lhe retirar.");
ShowPlayerDialog(playerid, 889, DIALOG_STYLE_MSGBOX, "|___Tutorial___|", string, "Próximo", "Cancelar");
}
if(tutorial[playerid] == 4){
SetPlayerPos(playerid, 1720.1409,-1739.3186,13.5469);
format(string, sizeof(string), "Você foi teleportado até a agencia de empregos.\nAqui você poderá pegar empregos.\nPara entrar, basta chegar perto da porta.\nCada profissão tem um requisito diferente.");
ShowPlayerDialog(playerid, 889, DIALOG_STYLE_MSGBOX, "|___Tutorial___|", string, "Próximo", "Cancelar");
}
if(tutorial[playerid] == 5){
SetPlayerPos(playerid, 1128.9072,-1457.5833,15.7969);
format(string, sizeof(string), "Você foi teleportado até o shopping.\nAqui você poderá comprar novas skins(roupas).\nBasta digitar o número da skin e clicar em Comprar.\nCada skin custa 50 reais.");
ShowPlayerDialog(playerid, 889, DIALOG_STYLE_MSGBOX, "|___Tutorial___|", string, "Próximo", "Cancelar");
}
if(tutorial[playerid] == 6){
SetPlayerPos(playerid, 1352.5071,-1752.2034,13.3579);
format(string, sizeof(string), "Você foi teleportado até a lojinha.\nAqui você poderá comprar simples coisas\ncomo um bloco de lembretes, um mp3.\nOs equipamentos são até uteis.");
ShowPlayerDialog(playerid, 889, DIALOG_STYLE_MSGBOX, "|___Tutorial___|", string, "Próximo", "Cancelar");
}
if(tutorial[playerid] == 7){
SetPlayerPos(playerid, 1080.9312,-1698.0581,13.5469);
format(string, sizeof(string), "Você foi teleportado até a loja de defesas.\nAqui você poderá comprar armas brancas.\nEssas armas ficam salvas na sua conta.\nSempre que você nascer, ela aparece-rá.");
ShowPlayerDialog(playerid, 889, DIALOG_STYLE_MSGBOX, "|___Tutorial___|", string, "Próximo", "Cancelar");
}
if(tutorial[playerid] == 8){
SetPlayerPos(playerid, 1804.6815,-1719.7866,13.5364);
format(string, sizeof(string), "Você foi teleportado até o local de habilitações.\nAqui você poderá comprar habilitações.\nEssas habilitações são usadas para dirigir automoveis.\nLembre-se que automoveis usam Gasolina.");
ShowPlayerDialog(playerid, 889, DIALOG_STYLE_MSGBOX, "|___Tutorial___|", string, "Próximo", "Cancelar");
}
if(tutorial[playerid] == 9){
SetPlayerPos(playerid, 1720.1409,-1739.3186,13.5469);
format(string, sizeof(string), "Você foi teleportado até o banco.\nAqui você poderá depositar ou sacar seu dinhero.\nPara fazer isto é necessario abrir uma conta.\nBasta entrar e se dirigir a um dos caixas.");
ShowPlayerDialog(playerid, 889, DIALOG_STYLE_MSGBOX, "|___Tutorial___|", string, "Próximo", "Cancelar");
}
if(tutorial[playerid] == 10){
SetPlayerPos(playerid, 2165.3789,-1798.6650,13.3713);
format(string, sizeof(string), "Você foi teleportado até a Lan House\nAqui você podera jogar varios jogos\nclaro que tera um valor cobrado.\nJogos:Counter Strike\n e Stunts");
ShowPlayerDialog(playerid, 889, DIALOG_STYLE_MSGBOX, "|___Tutorial___|", string, "Próximo", "Cancelar");
}
if(tutorial[playerid] == 11){
format(string, sizeof(string), "Finalização.\nTutorial concluido.\nSe tiver mais dúvidas peça um admin online.\ndigitando /admins, para ver os comandos \nuse /comandos, aproveite sua vida aqui !");
ShowPlayerDialog(playerid, 889, DIALOG_STYLE_MSGBOX, "|___Tutorial___|", string, "Finalizar", "Cancelar");
}
if(tutorial[playerid] == 12){
TogglePlayerControllable(playerid, 1);
SpawnPlayer(playerid);
tutorial[playerid] = 0;
}
} else {
TogglePlayerControllable(playerid, 1);
SpawnPlayer(playerid);
tutorial[playerid] = 0;
}
}
if(dialogid == 787)
{
new string[256];
if(response == 1)
{
format(string, sizeof(string), "Primeira Pergunta\nQual é cor do sinal aberto");
ShowPlayerDialog(playerid, 788, DIALOG_STYLE_MSGBOX, "|___Perguntas___|", string, "VERDE", "VERMELHO");
} else {
TogglePlayerControllable(playerid, 1);
format(string, sizeof(string), "Você errou a resposta");
ShowPlayerDialog(playerid, 5457, DIALOG_STYLE_MSGBOX, "|___Perguntas___|", string, "sair", "sair");
}
}
if(dialogid == 788)
{
new string[256];
if(response == 1)
{
format(string, sizeof(string), "Segunda Pergunta\nQuantos pontos é o limite para perder a carteira");
ShowPlayerDialog(playerid, 789, DIALOG_STYLE_MSGBOX, "|___Perguntas___|", string, "10", "20");
} else {
TogglePlayerControllable(playerid, 1);
format(string, sizeof(string), "Você errou a resposta");
ShowPlayerDialog(playerid, 5457, DIALOG_STYLE_MSGBOX, "|___Perguntas___|", string, "sair", "sair");
}
}
if(dialogid == 789)
{
new string[256];
if(response == 1)
{
TogglePlayerControllable(playerid, 1);
format(string, sizeof(string), "Você errou a resposta.");
ShowPlayerDialog(playerid, 5457, DIALOG_STYLE_MSGBOX, "|___Perguntas___|", string, "sair", "sair");
} else {
format(string, sizeof(string), "Terceira Pergunta\nCom quantos niveis de ácool você pode dirigir");
ShowPlayerDialog(playerid, 790, DIALOG_STYLE_MSGBOX, "|___Perguntas___|", string, "5 Doses", "10 Doses");
}
}
if(dialogid == 790)
{
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(playerid, nomepl, sizeof(nomepl));                 
new string[256];
if(response == 1)
{
new carro;
carro = CreateVehicle(527,3711.7400,-651.2714,10.7924,90.1792,3,3,50000);
SetPlayerInterior(playerid, 0);
TogglePlayerControllable(playerid, 1);
LinkVehicleToInterior(carro,0);	
emteste[playerid] = 1;
SetPlayerPos(playerid,3711.4768,-645.0613,10.6423);
SetPlayerCheckpoint(playerid,2092.7805,-1565.2965,12.7645,5.0);
PutPlayerInVehicle(playerid,carro,0);
nocarro[playerid] = carro;
format(string, sizeof(string), "Vá até o Ponto Vermelho Marcado Ao mapa");
ShowPlayerDialog(playerid, 5457, DIALOG_STYLE_MSGBOX, "|___Teste___|", string, "sair", "sair");
SetPlayerCheckpoint(playerid,2092.7805,-1565.2965,12.7645,5.0);
SetPlayerMapIcon(playerid,50,2092.7805,-1565.2965,12.7645,45,AZULBLUE);
} else {
TogglePlayerControllable(playerid, 1);
format(string, sizeof(string), "Você errou a resposta");
ShowPlayerDialog(playerid, 5457, DIALOG_STYLE_MSGBOX, "|___Perguntas___|", string, "sair", "sair");
}
}
 if(dialogid == 792) // Menu
	{
		if(response == 1)
		{
            new grana;            
            grana = GetPlayerPCash(playerid);            
            new nomepl[MAX_PLAYER_NAME];
            GetPlayerName(playerid, nomepl, MAX_PLAYER_NAME);      
            if(grana >= 500)
            {            
            emteste[playerid] = 0;
            GivePlayerPCash(playerid, -500);
			SendClientMessage(playerid, Azul, "Você conseguiu habilitação terrestre.");
            new pname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, pname, MAX_PLAYER_NAME);            
            dini_IntSet(pname, "HabTerrestre", 1);             
            } else {            
            SendClientMessage(playerid, Vermelho, "Você não tem dinheiro suficiente.");
            } 
            }           
            }
if(dialogid == 75)
{
if(response == 1)
{
RemovePlayerFromVehicle(playerid);
} else {
RemovePlayerFromVehicle(playerid);
}
}
if(dialogid == 854)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
if(response == 1)
{
dini_IntSet(pname, "Skin", 170);
SetPlayerSkin(playerid, 170);
SendClientMessage(playerid, Verde, "Philips: Seu sexo foi definido como Homem !.");
} else {
dini_IntSet(pname, "Skin", 193);
SetPlayerSkin(playerid, 193);
SendClientMessage(playerid, Verde, "Philips: Seu sexo foi definido como Mulher !.");
}
}
if(dialogid == 5500)
{
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(playerid, nomepl, sizeof(nomepl));
if(response == 1)
{
new grana;
grana = GetPlayerPCash(playerid);
if(grana > 49){
new PName[MAX_PLAYER_NAME];
GetPlayerName(playerid, PName, sizeof(PName));
if(!IsNumeric(inputtext)){
SendClientMessage(playerid, Vermelho, "Philips: Digite um valor númerico de 0 a 299.");
return 1;
}
new skin;
skin = GetPlayerSkin(playerid);
dini_Set(nomepl, "Skin", inputtext);
if(dini_Int(nomepl, "Skin") <= 299){
SetPlayerSkin(playerid, dini_Int(nomepl, "Skin"));
GivePlayerPCash(playerid, -50);    
SendClientMessage(playerid, Verde, "Philips: Você comprou uma nova skin com sucesso !");
} else {
SetPlayerSkin(playerid, skin);
dini_IntSet(nomepl, "Skin", skin);
SendClientMessage(playerid, Vermelho, "Philips: Skins de 0 a 299.");
}
} else {
SendClientMessage(playerid, Vermelho, "Philips: Você não tem dinheiro para comprar uma roupa");
}
}
}
if(dialogid == 100)
{
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(playerid, nomepl, sizeof(nomepl));
if(response == 1)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, sizeof(aname));
if(!IsNumeric(inputtext)){
SendClientMessage(playerid, Vermelho, "Philips: Valor inválido.");
return 1;
} else {
dini_Set(aname, "Input", inputtext);
new string[256];
if(dini_Int(aname, "SaldoBancario") > dini_Int(aname, "Input")-1 && dini_Int(aname, "Input") > 0){  
format(string, sizeof(string), "Philips Bank: Você sacou a quantia de R$%d.", dini_Int(aname, "Input"));
SendClientMessage(playerid, Verde, string);
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")-dini_Int(aname, "Input"));
GivePlayerPCash(playerid, dini_Int(aname, "Input"));   
} else {
SendClientMessage(playerid, Vermelho, "Philips: Valor inválido.");
}
}
}
}
if(dialogid == 200)
{
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(playerid, nomepl, sizeof(nomepl));
if(response == 1)
{
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, sizeof(aname));
if(!IsNumeric(inputtext)){
SendClientMessage(playerid, Vermelho, "Philips: Valor inválido.");
return 1;
} else {
dini_Set(aname, "Input", inputtext);
new string[256];
new grana;
grana = GetPlayerPCash(playerid);
if(grana > dini_Int(aname, "Input")-1 && dini_Int(aname, "Input") > 0){  
format(string, sizeof(string), "Philips Bank: Você depositou a quantia de R$%d.", dini_Int(aname, "Input"));
SendClientMessage(playerid, Verde, string);
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+dini_Int(aname, "Input"));
GivePlayerPCash(playerid, -dini_Int(aname, "Input"));   
} else {
SendClientMessage(playerid, Vermelho, "Philips: Valor inválido.");
}
}
}
}
if(dialogid == 1)
{
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(playerid, nomepl, sizeof(nomepl));
if(response == 1)
{
new PName[MAX_PLAYER_NAME];
GetPlayerName(playerid, PName, sizeof(PName));
new string[256];
format(string,sizeof string,"%s(id:%d) entrou no Philips RPG.",nomepl,playerid);
SendClientMessageToAll(Verde,string);
dini_Create(PName);
dini_Set(PName, "Senha", inputtext);
dini_Set(PName, "Skin", "0");
dini_Set(PName, "Admin", "0");
dini_Set(PName, "Banido", "0");
dini_Set(PName, "Experiencia", "0");
dini_Set(PName, "expulso", "0");
dini_Set(PName, "pontoshab", "0");
dini_Set(PName, "Nivel", "0");
dini_Set(PName, "Profissao", "0");
dini_Set(PName, "ContaBancaria", "0");
dini_Set(PName, "SaldoBancario", "0");
dini_Set(PName, "Celular", "0");
dini_Set(PName, "CartaoTelefonico", "0");
dini_Set(PName, "Faculdade", "0");
dini_Set(PName, "MP3", "0");
dini_Set(PName, "Dinheiro", "500");
dini_Set(PName, "HabTerrestre", "0"); 
dini_Set(PName, "HabAerea", "0");
dini_Set(PName, "HabNautica", "0");
dini_Set(PName, "Combustivel", "30");
dini_Set(PName, "Preso", "0"); 
dini_Set(PName, "Bloco", "0");
dini_Set(PName, "Casa", "0");
dini_Set(PName, "Prop", "0");
dini_Set(PName, "Carta", "0"); 
dini_Set(PName, "IP", "0");  
dini_Set(PName, "Lembrete", "Nada"); 
dini_Set(PName, "Propnome", "Sem Nome");
dini_Set(PName, "Arma", "0");  
dini_Set(PName, "Vip", "0");
dini_Set(PName, "Peixes", "0"); 
dini_Set(PName, "Cargas", "0"); 
dini_Set(PName, "Jornais", "0");
dini_Set(PName, "TCarro", "0");
dini_Set(PName, "Carro", "Nenhum");
dini_Set(PName, "Luta", "4");
dini_Set(PName, "Fama", "0");
dini_Set(PName, "PFama", "0");
dini_Set(PName, "Fome", "0");
dini_Set(PName, "Procurado", "0");
dini_FloatSet(PName,"CasaX",Float:1154.1013);
dini_FloatSet(PName,"CasaY",Float:-1768.5906);
dini_FloatSet(PName,"CasaZ",Float:16.5938);
 SetSpawnInfo(playerid, 11, dini_Int(PName, "Skin"), dini_Float(PName, "CasaX"), dini_Float(PName, "CasaY"), dini_Float(PName, "CasaZ"), 354.1657, 0, 0, 0, 0, 0, 0);            
Logado[playerid] = 1;
SendClientMessage(playerid, Verde, "Philips: Sua conta foi criada com sucesso !!");
SendClientMessage(playerid, Verde, "Philips: Em caso de dúvidas digite /ajuda.");
SendClientMessage(playerid, Verde, "Philips: Chame um adm caso presise, /reportar [mensagem].");
SpawnPlayer(playerid);
ShowPlayerDialog(playerid, 854, DIALOG_STYLE_MSGBOX, "Sexo", "Ok, Registro concluido !\nAgora, diga se é Homem ou Mulher. \nIsso irá definir sua skin. \nOk, você é Homem ou Mulher ?", "Homem", "Mulher");
GivePlayerPCash(playerid, 500);
} else {
Kick(playerid);
}
}
if(dialogid == 2)
{
if(response == 1)
{
//new string[256];
new PName[MAX_PLAYER_NAME];
GetPlayerName(playerid, PName, sizeof(PName));
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(playerid, nomepl, sizeof(nomepl));


new pass_confirm[255];
pass_confirm = dini_Get(PName, "Senha");
if(strlen(inputtext) >= 1){
if(strcmp(inputtext, pass_confirm, true) == 0)
//if(inputtext == dini_Int(PName, "Senha"))
{
new string[256];
format(string,sizeof string,"%s(id:%d) entrou no Philips RPG.",nomepl,playerid);
SendClientMessageToAll(Verde,string);
Logado[playerid] = 1;
pAdmin[playerid] = dini_Int(PName, "Admin");
SetPlayerWantedLevel(playerid, dini_Int(PName, "Procurado"));
SendClientMessage(playerid, Verde, "Philips RPG: Sua conta foi logada com sucesso !!");
SendClientMessage(playerid, Verde, "Philips: Chame um adm caso presise, /reportar [mensagem].");
if(dini_Int(nomepl, "Casa") == 0){
//SetSpawnInfo(playerid, 1, dini_Int(nomepl, "Skin"), 1787.0605,-1696.6660,13.4812, 354.1657, 0, 0, 0, 0, 0, 0);
}
SpawnPlayer(playerid);
ResetPlayerPCash(playerid);
GivePlayerPCash(playerid, dini_Int(nomepl, "Dinheiro"));
dini_IntSet(nomepl, "Dinheiro", 0);
if(dini_Int(nomepl, "Bloco") == 1){
format(STRX, sizeof(STRX), "Lembrete: %s.", dini_Get(nomepl, "Lembrete"));
SendClientMessage(playerid, Azul, STRX);
}
} else {
format(STRX, sizeof(STRX), "Senha Incorreta ! Tente Novamente.\n\nDigite sua senha e clique em \"Logar\". \n\n~ Philips RPG!.");
SendClientMessage(playerid, Vermelho, "SENHA INCORRETA !!");
ShowPlayerDialog(playerid, 2, DIALOG_STYLE_INPUT, "Logar", STRX, "Logar", "Sair");
}
} else {
format(STRX, sizeof(STRX), "Senha Incorreta ! Tente Novamente.\n\nDigite sua senha e clique em \"Logar\". \n\n~ Philips RPG!.");
SendClientMessage(playerid, Vermelho, "SENHA INCORRETA !!");
ShowPlayerDialog(playerid, 2, DIALOG_STYLE_INPUT, "Logar", STRX, "Logar", "Sair");
}
} else {
Kick(playerid);
}
}
if(dialogid == 3300) // Menu
	{
		if(response)
		{
            new grana;            
            grana = GetPlayerPCash(playerid);            
            new nomepl[MAX_PLAYER_NAME];
            GetPlayerName(playerid, nomepl, sizeof(nomepl));
   			if(listitem == 0) // Celular 350
			{
            if(grana > 349){            
            GivePlayerPCash(playerid, -350);
			SendClientMessage(playerid, Azul, "Você comprou um celular.");
            dini_IntSet(nomepl, "Celular", 1);
            } else {            
            SendClientMessage(playerid, Vermelho, "Você não tem dinheiro suficiente.");
            }	
			}
			if(listitem == 1) // Cartao telefonico 10
			{
            if(grana > 9){            
            GivePlayerPCash(playerid, -10);
			SendClientMessage(playerid, Azul, "Você comprou um cartão telefonico.");
            dini_IntSet(nomepl, "CartaoTelefonico", dini_Int(nomepl, "CartaoTelefonico")+20);
            } else {            
            SendClientMessage(playerid, Vermelho, "Você não tem dinheiro suficiente.");
            }
            }
			if(listitem == 2) // MP3  150
			{
			if(grana > 149){            
            GivePlayerPCash(playerid, -150);
			SendClientMessage(playerid, Azul, "Você comprou um MP3 use /comandosmp3.");
            dini_IntSet(nomepl, "MP3", 1);
            } else {            
            SendClientMessage(playerid, Vermelho, "Você não tem dinheiro suficiente.");
            }
               }
               if(listitem == 3) // Bloco de Lembretes
			{
			if(grana > 4){            
            GivePlayerPCash(playerid, -5);
			SendClientMessage(playerid, Azul, "Você comprou um Bloco de Lembretes use /lembrete [texto].");
            dini_IntSet(nomepl, "Bloco", 1);            
            dini_Set(nomepl, "Lembrete", "Nada");
            } else {            
            SendClientMessage(playerid, Vermelho, "Você não tem dinheiro suficiente.");
            }
               }   
	}
 } 
 if(dialogid == 4400) // Menu
	{
		if(response)
		{
            new grana;
            new string[256];            
            grana = GetPlayerPCash(playerid);            
            new nomepl[MAX_PLAYER_NAME];
            GetPlayerName(playerid, nomepl, sizeof(nomepl));
   			if(listitem == 0) // Terrestre
			{
            new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
            format(string, sizeof(string), "Ola Caro Senhor (a) :%s\nIremos Comecar o Teste Agora De Habilitacao\nA Primeiro Coisa é responder as perguntas\nClique Ok para continuar ou cancelar para sair",aname);
            ShowPlayerDialog(playerid, 787, DIALOG_STYLE_MSGBOX, "|___Perguntas___|", string, "Iniciar", "Cancelar");
            TogglePlayerControllable(playerid, 0);	
            }	
  			if(listitem == 1) // Aerea
			{
            if(grana > 549){            
            GivePlayerPCash(playerid, -550);
			SendClientMessage(playerid, Azul, "Você conseguiu habilitação aerea.");
            dini_IntSet(nomepl, "HabAerea", 1);
            } else {            
            SendClientMessage(playerid, Vermelho, "Você não tem dinheiro suficiente.");
            }
            }
			if(listitem == 2) // Nautica
			{
			if(grana > 549){            
            GivePlayerPCash(playerid, -550);
			SendClientMessage(playerid, Azul, "Você conseguiu habilitação nautica.");
            dini_IntSet(nomepl, "HabNautica", 1);
            } else {            
            SendClientMessage(playerid, Vermelho, "Você não tem dinheiro suficiente.");
            }
            }
	        }
            }
 if(dialogid == 3301) // Menu
	{
		if(response)
		{            
            new nomepl[MAX_PLAYER_NAME];
            GetPlayerName(playerid, nomepl, sizeof(nomepl));
   			if(listitem == 0) // Musica 1 
			{
            PlayerPlaySound(playerid,1062,X,Y,Z);	
			}
			if(listitem == 1) // Musica 2
			{
            PlayerPlaySound(playerid,1068,X,Y,Z);
            }
			if(listitem == 2) // Musica 3
			{
			PlayerPlaySound(playerid,1076,X,Y,Z);
            }            
            if(listitem == 3) // Musica 4
			{
			PlayerPlaySound(playerid,1097,X,Y,Z);
            }            
            if(listitem == 4) // Musica 5
			{
			PlayerPlaySound(playerid,1183,X,Y,Z);
            }            
            if(listitem == 5) // Musica 6
			{
			PlayerPlaySound(playerid,1085,X,Y,Z);
            }            
            if(listitem == 6) // Musica 7
			{
			PlayerPlaySound(playerid,1069,X,Y,Z);
            }   
	}
 }  
 if(dialogid == 300) // Banco
	{
		if(response)
		{            
            new aname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, aname, sizeof(aname));
   			if(listitem == 0) // Sacar
			{
	        if(dini_Int(aname, "ContaBancaria") == 1){         
            new string[256];
            format(string, sizeof(string), "Digite a quantia a sacar.");
            SendClientMessage(playerid, Azul, string);
            format(STRX, sizeof(STRX), "Bem Vindo ao banco, %s!\n\nDigite a quantia que deseja sacar e aperte \"Sacar\".\n\n ~ Philips RPG!", aname);
            ShowPlayerDialog(playerid, 100, DIALOG_STYLE_INPUT, "Banco", STRX, "Sacar", "Fechar");
            } else {
            SendClientMessage(playerid, Vermelho,"Você não tem uma conta bancária.");
            }
			}
			if(listitem == 1) // Depositar
			{
            if(dini_Int(aname, "ContaBancaria") == 1){              
            new string[256];
            format(string, sizeof(string), "Digite a quantia a depositar.");
            SendClientMessage(playerid, Azul, string);
            format(STRX, sizeof(STRX), "Bem Vindo ao banco, %s!\n\nDigite a quantia que deseja depositar e aperte \"Depositar\".\n\n ~ Philips RPG!", aname);
            ShowPlayerDialog(playerid, 200, DIALOG_STYLE_INPUT, "Banco", STRX, "Depositar", "Fechar");
            } else {
            SendClientMessage(playerid, Vermelho,"Você não tem uma conta bancária.");
            }
            }
			if(listitem == 2) // Ver Saldo
			{
        	if(dini_Int(aname, "ContaBancaria") == 1){      
            new string[256];
			new PName[MAX_PLAYER_NAME];
			GetPlayerName(playerid, PName, sizeof(PName));
            format(string, sizeof(string), "Saldo Bancario:%d\nObrigado Por Consultar.",dini_Int(aname, "SaldoBancario"));
            ShowPlayerDialog(playerid, 200, DIALOG_STYLE_MSGBOX, "Saldo",string,"Ok","Fechar");
            }else {
            SendClientMessage(playerid, Vermelho,"Você não tem uma conta bancária.");
            }
            }  
            if(listitem == 3) // Abrir conta
			{
			if(dini_Int(aname, "ContaBancaria") == 0){
            new string[256];
            format(string, sizeof(string), "Philips Bank\nVocê abriu uma Conta. \n%s, seja bem vindo ao Philips Bank", aname);
            ShowPlayerDialog(playerid, 78, DIALOG_STYLE_MSGBOX, "Banco", string, "Ok", "Fechar");
            dini_IntSet(aname, "ContaBancaria", 1);
            dini_IntSet(aname, "SaldoBancario", 0);
            } else {
            SendClientMessage(playerid, Vermelho,"Você já tem uma conta bancária.");
            }
            }            
            }
            }
            if(dialogid == 10) // Agencia
	        {
		    if(response)
		    {
            //new string[256];            
            new nomepl[MAX_PLAYER_NAME];
            GetPlayerName(playerid, nomepl, sizeof(nomepl));
   			if(listitem == 0) // Honestas 
			{
            ShowPlayerDialog(playerid, Comuns, DIALOG_STYLE_LIST, "Honestas", "Estágiario \nTaxista \nMedico \nMecanico \nJornalista \nFotografo \nReporter \nAncora \nMeteorologista", "Selecionar", "Voltar");	
			}
			if(listitem == 1) // Policiais 
			{
            ShowPlayerDialog(playerid, Policiais, DIALOG_STYLE_LIST, "Policiais", "Guarda \nPolicial Rodoviário \nPolicial Militar \nPolicial Civil \nPolicial Federal \nDelegado \nBOPE \nSWAT \nNarcoticos", "Selecionar", "Voltar");	           
            }
            if(listitem == 2) // Criminosas 
			{
            ShowPlayerDialog(playerid, Criminosas, DIALOG_STYLE_LIST, "Criminosas", "Traficante de Armas \nAssasino \nTerrorista \nSequestrador \nAssasino Profissional", "Selecionar", "Voltar");           
            }
            if(listitem == 3) // Vendas
    	      	{
                 ShowPlayerDialog(playerid, Vendas, DIALOG_STYLE_LIST, "Criminosas", "Vendedor de Casa \nVendedor de Skin \nVendedor de Carro \nVendedor de Gasolina", "Selecionar", "Voltar");
            }
            }
            }
             if(dialogid == Vendas){ 
             new nomepl[MAX_PLAYER_NAME];
             GetPlayerName(playerid, nomepl, MAX_PLAYER_NAME);
             new string[256];              
             if(response)
             {             
             if(listitem == 0)  //casa           
             {
              if(dini_Int(nomepl, "Nivel") > 92 && dini_Int(nomepl, "Faculdade") > 81 && dini_Int(nomepl, "Carta") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é um Vendedor de casa !");
            dini_IntSet(nomepl, "Profissao", 22);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/93 de Nivel, %d/82 Meses na faculdade %d/1 Carta de indicação.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"), dini_Int(nomepl, "Carta"));            
            SendClientMessage(playerid, Vermelho, string);
            }              
             }              
             if(listitem == 1) //skin             
             {
             if(dini_Int(nomepl, "Nivel") > 51 && dini_Int(nomepl, "Faculdade") > 30 && dini_Int(nomepl, "Carta") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é um Vendedor de skins !");
            dini_IntSet(nomepl, "Profissao", 23);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/52 de Nivel, %d/31 Meses na faculdade %d/1 Carta de indicação.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"), dini_Int(nomepl, "Carta"));            
            SendClientMessage(playerid, Vermelho, string);
            }                
             }               
             if(listitem == 2) //carro             
             {
             if(dini_Int(nomepl, "Nivel") > 257 && dini_Int(nomepl, "Faculdade") > 174 && dini_Int(nomepl, "Carta") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é um Vendedor de carro !");
            dini_IntSet(nomepl, "Profissao", 24);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/258 de Nivel, %d/175 Meses na faculdade %d/1 Carta de indicação.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"), dini_Int(nomepl, "Carta"));            
            SendClientMessage(playerid, Vermelho, string);
            }              
             }             
             if(listitem == 3) //comb             
             {
             if(dini_Int(nomepl, "Nivel") > 33 && dini_Int(nomepl, "Faculdade") > 11 && dini_Int(nomepl, "Carta") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é um Vendedor de gasolina !");
            dini_IntSet(nomepl, "Profissao", 25);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/34 de Nivel, %d/12 Meses na faculdade %d/1 Carta de indicação.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"), dini_Int(nomepl, "Carta"));            
            SendClientMessage(playerid, Vermelho, string);
            }              
             }
             }
             } 
                if(dialogid == Criminosas){ 
             new nomepl[MAX_PLAYER_NAME];
             GetPlayerName(playerid, nomepl, MAX_PLAYER_NAME);
             new string[256];              
             if(response)
             {              
             if(listitem == 0)    //traficante         
             {
             if(dini_Int(nomepl, "Nivel") > 4 && dini_Int(nomepl, "Celular") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é Traficante de Armas !");
            dini_IntSet(nomepl, "Profissao", 11);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/5 de Nivel %d/0 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);            
            format(string, sizeof(string), "Celular %d/1.", dini_Int(nomepl, "Celular"));            
            SendClientMessage(playerid, Vermelho, string);                          
             }             
             }              
             if(listitem == 1)   //assasino             
             {
              if(dini_Int(nomepl, "Nivel") > 8 && dini_Int(nomepl, "Celular") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é Assasino !");
            dini_IntSet(nomepl, "Profissao", 12);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/9 de Nivel %d/0 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);            
            format(string, sizeof(string), "Celular %d/1.", dini_Int(nomepl, "Celular"));            
            SendClientMessage(playerid, Vermelho, string);                          
             }             
             }             
             if(listitem == 2)   //terrorista             
             {
             if(dini_Int(nomepl, "Nivel") > 25 && dini_Int(nomepl, "Celular") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é Terrorista!");
            dini_IntSet(nomepl, "Profissao", 13);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/26 de Nivel %d/0 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);            
            format(string, sizeof(string), "Celular %d/1.", dini_Int(nomepl, "Celular"));            
            SendClientMessage(playerid, Vermelho, string);                          
             }             
             }             
             if(listitem == 3) //sequestrador             
             {
             if(dini_Int(nomepl, "Nivel") > 31 && dini_Int(nomepl, "Celular") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é Terrorista!");
            dini_IntSet(nomepl, "Profissao", 14);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/32 de Nivel %d/0 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);            
            format(string, sizeof(string), "Celular %d/1.", dini_Int(nomepl, "Celular"));            
            SendClientMessage(playerid, Vermelho, string);                          
             }             
             }             
             if(listitem == 4) //assasino prof             
             {
              if(dini_Int(nomepl, "Nivel") > 33 && dini_Int(nomepl, "Celular") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é Terrorista!");
            dini_IntSet(nomepl, "Profissao", 15);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/34 de Nivel %d/0 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);            
            format(string, sizeof(string), "Celular %d/1.", dini_Int(nomepl, "Celular"));            
            SendClientMessage(playerid, Vermelho, string);                          
             }             
             }
             }
             } 
              if(dialogid == Policiais){ 
             new nomepl[MAX_PLAYER_NAME];
             GetPlayerName(playerid, nomepl, MAX_PLAYER_NAME);
             new string[256];              
             if(response)
             {             
             if(listitem == 0) //Guarda             
             {
            if(dini_Int(nomepl, "Nivel") > 10 && dini_Int(nomepl, "Faculdade") > 5){ 
            SendClientMessage(playerid, Verde, "Você agora é um Guarda !");
            dini_IntSet(nomepl, "Profissao", 2);
            SpawnPlayer(playerid);
            } else {
            format(string, sizeof(string), "Requer: %d/11 de Nivel, %d/7 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);              
             }             
             }             
             if(listitem == 1) //Policial Rodoviario             
             {
               if(dini_Int(nomepl, "Nivel") > 21 && dini_Int(nomepl, "Faculdade") > 11){ 
            SendClientMessage(playerid, Verde, "Você agora é um Policial rodoviário !");
          dini_IntSet(nomepl, "Profissao", 3);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/22 de Nivel, %d/12 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);
            }                         
             }              
             if(listitem == 2) //Policial Militar             
             {
             if(dini_Int(nomepl, "Nivel") > 27 && dini_Int(nomepl, "Faculdade") > 17 && dini_Int(nomepl, "HabTerrestre") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é um Policial Militar !");
            dini_IntSet(nomepl, "Profissao", 4);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/28 de Nivel, %d/18 Meses na faculdade %d/1 Habilitação terrestre.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"), dini_Int(nomepl, "HabTerrestre"));            
            SendClientMessage(playerid, Vermelho, string);
            }               
             }              
             if(listitem == 3) //Policial Civil             
             {                          
              if(dini_Int(nomepl, "Nivel") > 35 && dini_Int(nomepl, "Faculdade") > 24 && dini_Int(nomepl, "HabTerrestre") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é um Policial Civil !");
            dini_IntSet(nomepl, "Profissao", 5);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/36 de Nivel, %d/25 Meses na faculdade %d/1 Habilitação terrestre.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"), dini_Int(nomepl, "HabTerrestre"));            
            SendClientMessage(playerid, Vermelho, string);
            } 
             }
             if(listitem == 4) //Policial Federal
             {             
             if(dini_Int(nomepl, "Nivel") > 44 && dini_Int(nomepl, "Faculdade") > 27 && dini_Int(nomepl, "HabTerrestre") == 1 && dini_Int(nomepl, "HabAerea") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é um Policial Federal !");
            dini_IntSet(nomepl, "Profissao", 6);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/45 de Nivel, %d/28 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);            
            format(string, sizeof(string), "Habilitação terrestre %d/1 Habilitação Aerea %d/1.", dini_Int(nomepl, "HabTerrestre"), dini_Int(nomepl, "HabAerea"));            
            SendClientMessage(playerid, Vermelho, string);
            }  
             } 
             if(listitem == 5) //Delegado
             {             
              if(dini_Int(nomepl, "Nivel") > 40 && dini_Int(nomepl, "Faculdade") > 20 && dini_Int(nomepl, "HabTerrestre") == 1 && dini_Int(nomepl, "HabAerea") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é um Delegado !");
            dini_IntSet(nomepl, "Profissao", 7);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/41 de Nivel, %d/21 meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);            
            format(string, sizeof(string), "Habilitação terrestre %d/1 Habilitação Aerea %d/1.", dini_Int(nomepl, "HabTerrestre"), dini_Int(nomepl, "HabAerea"));            
            SendClientMessage(playerid, Vermelho, string);
            }   
             }  
             if(listitem == 6) //BOPE
             {             
              if(dini_Int(nomepl, "Nivel") > 48 && dini_Int(nomepl, "Faculdade") > 28 && dini_Int(nomepl, "HabTerrestre") == 1 && dini_Int(nomepl, "HabAerea") == 1 && dini_Int(nomepl, "HabNautica") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é do BOPE !");
            dini_IntSet(nomepl, "Profissao", 8);
            SpawnPlayer(playerid);            
            } else {            
            format(string, sizeof(string), "Requer: %d/49 de Nivel, %d/29 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);            
            format(string, sizeof(string), "Habilitação terrestre %d/1 Habilitação Aerea %d/1 Habilitação Nautica %d/1.", dini_Int(nomepl, "HabTerrestre"), dini_Int(nomepl, "HabAerea"), dini_Int(nomepl, "HabNautica"));            
            SendClientMessage(playerid, Vermelho, string);
            }   
             }  
             if(listitem == 7) //SWAT
             {             
              if(dini_Int(nomepl, "Nivel") > 64 && dini_Int(nomepl, "Faculdade") > 47 && dini_Int(nomepl, "HabTerrestre") == 1 && dini_Int(nomepl, "HabAerea") == 1 && dini_Int(nomepl, "HabNautica") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é da SWAT !");
            dini_IntSet(nomepl, "Profissao", 9);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/65 de Nivel, %d/48 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);            
            format(string, sizeof(string), "Habilitação terrestre %d/1 Habilitação Aerea %d/1 Habilitação Nautica %d/1.", dini_Int(nomepl, "HabTerrestre"), dini_Int(nomepl, "HabAerea"), dini_Int(nomepl, "HabNautica"));            
            SendClientMessage(playerid, Vermelho, string);
            } 
             }
             if(listitem == 8) //Narcoticos
             {             
              if(dini_Int(nomepl, "Nivel") > 54 && dini_Int(nomepl, "Faculdade") > 40 && dini_Int(nomepl, "HabTerrestre") == 1 && dini_Int(nomepl, "HabAerea") == 1 && dini_Int(nomepl, "HabNautica") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é da Narcoticos !");
            dini_IntSet(nomepl, "Profissao", 10);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/55 de Nivel, %d/41 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);            
            format(string, sizeof(string), "Habilitação terrestre %d/1 Habilitação Aerea %d/1 Habilitação Nautica %d/1.", dini_Int(nomepl, "HabTerrestre"), dini_Int(nomepl, "HabAerea"), dini_Int(nomepl, "HabNautica"));            
            SendClientMessage(playerid, Vermelho, string);                          
             }
             }        
             }
             }   
             if(dialogid == Comuns){ 
             new nomepl[MAX_PLAYER_NAME];
             GetPlayerName(playerid, nomepl, MAX_PLAYER_NAME);
             new string[256];              
             if(response)
             {
             if(listitem == 0) // Estágiario 
			{
            SendClientMessage(playerid, Verde, "Você agora é um estágiario !");
            dini_IntSet(nomepl, "Profissao", 1);
            SpawnPlayer(playerid);	
			}
            if(listitem == 1)   //taxista
            {            
              if(dini_Int(nomepl, "HabTerrestre") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é um Taxista !");
            dini_IntSet(nomepl, "Profissao", 26);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/1 Habilitação terrestre.", dini_Int(nomepl, "HabTerrestre"));            
            SendClientMessage(playerid, Vermelho, string);
            }                       
            } 
            if(listitem == 2) //medico
            {             
            if(dini_Int(nomepl, "Nivel") > 5 && dini_Int(nomepl, "Faculdade") > 8 && dini_Int(nomepl, "HabTerrestre") == 1){  
            SendClientMessage(playerid, Verde, "Você agora é um Médico !");
            dini_IntSet(nomepl, "Profissao", 27);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/6 de Nivel, %d/9 Meses na faculdade %d/1 Habilitação terrestre.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"), dini_Int(nomepl, "HabTerrestre"));                        
            SendClientMessage(playerid, Vermelho, string);
            }                   
            } 
            if(listitem == 3) //mecanico
            {             
              if(dini_Int(nomepl, "Nivel") > 2 && dini_Int(nomepl, "Faculdade") > 1){ 
            SendClientMessage(playerid, Verde, "Você agora é um Mecanico !");
            dini_IntSet(nomepl, "Profissao", 21);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/3 de Nivel, %d/2 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);
            }                         
            } 
            if(listitem == 4) //Jornalista
            {            
            if(dini_Int(nomepl, "Nivel") > 5 && dini_Int(nomepl, "Faculdade") > 4){ 
            SendClientMessage(playerid, Verde, "Você agora é um Jornalista !");
            dini_IntSet(nomepl, "Profissao", 16);
            SpawnPlayer(playerid);
            } else {
            format(string, sizeof(string), "Requer: %d/6 de Nivel, %d/5 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);
            } 
            } 
            if(listitem == 5) //Fotografo
            {            
            if(dini_Int(nomepl, "Nivel") > 13 && dini_Int(nomepl, "Faculdade") > 7){ 
            SendClientMessage(playerid, Verde, "Você agora é um Fotografo !");
            dini_IntSet(nomepl, "Profissao", 17);
            SpawnPlayer(playerid);
            } else {
            format(string, sizeof(string), "Requer: %d/14 de Nivel, %d/8 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);
            } 
            } 
            if(listitem == 6) //Reporter
            {            
             if(dini_Int(nomepl, "Nivel") > 15 && dini_Int(nomepl, "Faculdade") > 9 && dini_Int(nomepl, "HabTerrestre") == 1){ 
            SendClientMessage(playerid, Verde, "Você agora é um Reporter !");
          dini_IntSet(nomepl, "Profissao", 18);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/16 de Nivel, %d/10 Meses na faculdade %d/1 Habilitação terrestre.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"), dini_Int(nomepl, "HabTerrestre"));            
            SendClientMessage(playerid, Vermelho, string);
            } 
            } 
            if(listitem == 7) //Ancora
            {            
            if(dini_Int(nomepl, "Nivel") > 27 && dini_Int(nomepl, "Faculdade") > 10){ 
            SendClientMessage(playerid, Verde, "Você agora é Ancora do jornal !");
            dini_IntSet(nomepl, "Profissao", 19);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/28 de Nivel, %d/11 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);
            }  
            }  
            if(listitem == 8) //Meteorologista
            {            
             if(dini_Int(nomepl, "Nivel") > 31 && dini_Int(nomepl, "Faculdade") > 20){ 
            SendClientMessage(playerid, Verde, "Você agora é um Meteorologista !");
            dini_IntSet(nomepl, "Profissao", 20);
            SpawnPlayer(playerid);
            } else {            
            format(string, sizeof(string), "Requer: %d/32 de Nivel, %d/21 Meses na faculdade.", dini_Int(nomepl, "Nivel"), dini_Int(nomepl, "Faculdade"));            
            SendClientMessage(playerid, Vermelho, string);
            }  
            }     
             }
             }  
             return 1;             
             }


public Online(playerid)
{
for(new i=0;i<MAX_PLAYERS;i++){
new string[256];
new aname[MAX_PLAYER_NAME];
GetPlayerName(i, aname, MAX_PLAYER_NAME);
tempoon[i] = tempoon[i]+1;
if(dini_Int(aname, "Vip") > 0){
dini_IntSet(aname, "Vip", dini_Int(aname, "Vip")-1);
if(dini_Int(aname, "Vip") <= 5){
format(string, sizeof(string), "[Philips-Vip]Seu vip está acabando ! Você ainda tem %d minutos de vip.", dini_Int(aname, "Vip"));
SendClientMessage(playerid, Azul, string);
}
}
if(tempoon[i] == 15){
tempoon[i] = 0;
dini_IntSet(aname, "Experiencia", dini_Int(aname, "Experiencia")+1);
podehab[playerid] = 1;
SendClientMessage(i, Amarelo,"Você ganhou 1 de experiência por jogar a 15 minutos.");
SendClientMessage(i, Amarelo,"Para ganhar experiência normalmente, trabalhe.");
}
}
}


public Liberarcmd()
{
for(new i=0;i<MAX_PLAYERS;i++){
vcblock[i] = 0;
kitblock[i] = 0;
crblock[i] = 0;
}
return 1;
}


public AntiAfk()
{
new string[256];
for(new i=0;i<MAX_PLAYERS;i++){
if(IsPlayerConnected(i) == 1){
MinutisOn[i] = MinutisOn[i]+1;
if(NaFaculdade[i] == 0){
new Float:XX, Float:YY, Float:ZZ;
GetPlayerPos(i, XX, YY, ZZ);
if(AFKX[i] == XX && AFKY[i] == YY && AFKZ[i] == ZZ){
minutosafk[i] = minutosafk[i]+1;
} else {
minutosafk[i] = 0;
}
AFKX[i] = XX;
AFKY[i] = YY;
AFKZ[i] = ZZ;
if(minutosafk[i] > 2){
format(string, sizeof(string), "[Info]Você está parado a %d/10 minutos.", minutosafk[i]); 
SendClientMessage(i, Amarelo, string);
}
if(minutosafk[i] == 9){
SendClientMessage(i, Violeta, "[Info]Cuidado ! Se não se mecher, será kickado em 1 minuto.");
}
if(minutosafk[i] == 10){
SendClientMessage(i, Vermelho, "[Philips-Bot]Você estáva afk e foi kickado !"); 
new pname[MAX_PLAYER_NAME];
GetPlayerName(i, pname, MAX_PLAYER_NAME);
Kick(i);
format(string, sizeof(string), "[Philips-Bot]O player %s(id:%d) estáva afk e foi kickado.", pname, i); 
SendClientMessageToAll(Amarelo, string);
printf("[Philips-Bot]%s (ID:%d) estáva afk e foi kick\n",pname,i);
}
}
}
}
return 1;
}

public Combustivel()
{
for(new i=0;i<MAX_PLAYERS;i++){
new vid;
vid = GetPlayerVehicleID(i);
new modelo;
modelo = GetVehicleModel(vid);
if(modelo == 509 || modelo == 510 || modelo == 481){
} else {
new estado;
estado = GetPlayerVehicleSeat(i);
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(i, nomepl, sizeof(nomepl));
GetPlayerState(i);
if(IsPlayerInAnyVehicle(i) == 1){
if(estado == 0){
dini_IntSet(nomepl, "Combustivel", dini_Int(nomepl, "Combustivel")-1);
}
if(dini_Int(nomepl, "Combustivel") <= 0){
SendClientMessage(i, Vermelho, "Acabou o combustivel do carro e você não pode mais dirigi-lo.");
RemovePlayerFromVehicle(i);
}
}
}
}
return 1;
}
public Presos()
{
for(new i=0;i<MAX_PLAYERS;i++){
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(i, nomepl, sizeof(nomepl));
if(dini_Int(nomepl, "Preso") == 1){
dini_IntSet(nomepl, "Preso", 0);
SpawnPlayer(i);
SetPlayerPos(i, 1546.4675, -1676.2452, 13.5624);
SendClientMessage(i, Vermelho, "Você foi solto, lembre-se o crime não compensa.");
}
}
return 1;
}

        public MudarHora(){         
        new string[256];        
        if(minutoss < 60){ 
        minutoss = minutoss+1;       
        }         
        if(minutoss == 60){        
        minutoss = 0;
        hora = hora+1;           
        }        
        if(hora == 24){        
        hora = 0; 
        dia = dia+1; 
        diadasemana = diadasemana+1;      
        }  
        if(diadasemana == 7){         
        diadasemana = 0;
        } 
        if(hora == 12 && minutoss == 30){
        GameTextForAll("~w~Faculdade ~g~ABERTA", 6000, 1);
        }
        if(hora == 13 && minutoss == 0){
        GameTextForAll("~w~Faculdade ~r~FECHADA", 6000, 1);
        }
        if(hora == 6 && minutoss == 0){
        GameTextForAll("~w~Lanchonetes ~g~ABERTAS", 6000, 1);
        }
        if(hora == 22 && minutoss == 0){
        GameTextForAll("~w~Lanchonetes ~r~FECHADAS", 6000, 1);
        }
        if(hora == 9 && minutoss == 0){
        GameTextForAll("~w~Ammu-nations ~g~ABERTAS", 6000, 1);
        }
        if(hora == 23 && minutoss == 0){
        GameTextForAll("~w~Ammu-nations ~r~FECHADAS", 6000, 1);
        }
        if(dia == 30){                          
        dispesas1();          
        hot();
        dia = 0;        
        }
        if (minutoss <= 9){            
        //new Hour, Minute, Second;          
       // gettime(Hour, Minute, Second); 
       // for(new i=0;i<MAX_PLAYERS;i++){ 
        //if(IsPlayerConnected(i)){         
        //SetPlayerTime(i, Hour, Minute);   
        //}      
        //}
        format(string,25,"%d:0%d~n~Dia:%d~n~%s",hora,minutoss,dia,diasemana[diadasemana]);        
        TextDrawSetString(Relogio,string);
        }
        else {                  
       // new Hour, Minute, Second; 
        //gettime(Hour, Minute, Second);            
        //for(new i=0;i<MAX_PLAYERS;i++){ 
       // if(IsPlayerConnected(i)){          
        //SetPlayerTime(i, Hour, Minute);       
        //}  
      //  }
        format(string,25,"%d:%d~n~Dia:%d~n~%s",hora,minutoss,dia,diasemana[diadasemana]);            
        TextDrawSetString(Relogio,string);              
        }
        if(hora == 22 && minutoss == 30){
        SendClientMessageToAll(Amarelo, "As rendas de propriedades forão depositadas nelas.");
        for(new p=0; p<MAX_CASAS; p++){
        new strx[256];
        format(strx, sizeof(strx), "prop%d.ini", p);
        if(dini_Exists(strx)){
        if(dini_Int(strx, "TDono") == 1){
        new grana;
        grana = (dini_Int(strx, "Preco") /100);
        if(dini_Int(strx, "Grana")+grana >= 4500){
        dini_IntSet(strx, "Grana", 4500);
        } else {
        dini_IntSet(strx, "Grana", dini_Int(strx, "Grana")+grana);
        }
        }
        }
        }
        }
        for(new i=0;i<MAX_PLAYERS;i++){
        if(IsPlayerConnected(i) == 1){
        if(hora == 12 && minutoss == 0){
        SendClientMessage(i, Amarelo, "Está na hora do almoço e sua fome aumentou.");
        new nomepl[MAX_PLAYER_NAME];
        GetPlayerName(i, nomepl, sizeof(nomepl));
        dini_IntSet(nomepl, "Fome", dini_Int(nomepl, "Fome")+5);
        }
        if(hora == 8 && minutoss == 0){
        SendClientMessage(i, Amarelo, "Está na hora do café e sua fome aumentou.");
        new nomepl[MAX_PLAYER_NAME];
        GetPlayerName(i, nomepl, sizeof(nomepl));
        dini_IntSet(nomepl, "Fome", dini_Int(nomepl, "Fome")+3);
        }
        if(hora == 20 && minutoss == 0){
        SendClientMessage(i, Amarelo, "Está na hora da janta e sua fome aumentou.");
        new nomepl[MAX_PLAYER_NAME];
        GetPlayerName(i, nomepl, sizeof(nomepl));
        dini_IntSet(nomepl, "Fome", dini_Int(nomepl, "Fome")+4);
        }
playermoney(i);
TextDrawHideForPlayer(i, dano);
}
        }
        SetWorldTime(hora);
        return 1;
}

public abastece(){
for(new i=0; i<MAX_PLAYERS; i++){
new nome[MAX_PLAYERS];
GetPlayerName(i, nome, MAX_PLAYER_NAME);
if(abastecendo[i]){
if(dini_Int(nome, "Combustivel") < 100 && GetPlayerPCash(i) > 0){
dini_IntSet(nome, "Combustivel", dini_Int(nome, "Combustivel")+1);
GivePlayerPCash(i, -1);
} else {
if(GetPlayerPCash(i) == 0){
if(IsPlayerInAnyVehicle(i)){
SendClientMessage(i, Vermelho, "Seu dinheiro acabou, por isso não pudemos abastecer seu carro.");
TogglePlayerControllable(i, 1);
abastecendo[i] = 0;
} else {
SendClientMessage(i, Vermelho, "Seu dinheiro acabou, por isso não pudemos abastecer seu galil de gasolina.");
abastecendo[i] = 0;
TogglePlayerControllable(i, 1);
}
} else {
if(IsPlayerInAnyVehicle(i)){
abastecendo[i] = 0;
SendClientMessage(i, Azul, "Carro 100%% abastecido !");
TogglePlayerControllable(i, 1);
} else {
abastecendo[i] = 0;
SendClientMessage(i, Azul, "Galil de gasolina 100%% cheio !");
TogglePlayerControllable(i, 1);
}
}
}
}
}
}

public Praga(playerid){
if(IsPlayerInAnyVehicle(playerid)){
SetVehicleVelocity(GetPlayerVehicleID(playerid), 0, 0, 0);
} else {
SetPlayerVelocity(playerid, 0, 0, 0);
}
if(praga[playerid] > 1){
SetTimerEx("Praga", 50, 0, "d", playerid);
praga[playerid] = praga[playerid]-1;
}
if(praga[playerid] == 100){
TextDrawHideForPlayer(playerid, mote);
}
}

public TempoFaculdade(){
for(new i=0; i<MAX_PLAYERS; i++){
if(NaFaculdade[i] == 1){
new nomepl[MAX_PLAYER_NAME];
GetPlayerName(i, nomepl, sizeof(nomepl));
new Float:X,Float:Y,Float:Z;
GetPlayerPos(i,X,Y,Z);
if(hora == 17 && minutoss >= 30){
NaFaculdade[i] = 0;
SendClientMessage(i, Verde, "Thrinnn ! São 17:30 a aula acabou.");
SpawnPlayer(i);
SetPlayerPos(i, 1139.4012, -1761.3579, 13.5950);
PlayerPlaySound(i,1077,X,Y,Z);
dini_IntSet(nomepl, "Faculdade", dini_Int(nomepl, "Faculdade")+1);
SetPlayerInterior(i, 0);
}
}
}
}

public Posto(){
for(new i=0; i<MAX_PLAYERS; i++){
new Float:X, Float:Y, Float:Z;
GetPlayerPos(i, X, Y, Z);
if((X >= -1496.1409 && Y <= 1884.1014 && X <= -1449.3982 && Y >= 1851.1890) || (X >= 608.2354 && X <= 619.7912 && Y >= 1851.1890 && Y <= 1884.1014) || (X >= -1332.9951 && X <= -1324.0493 && Y >= 2669.6433 && Y <= 2685.6675)){
				GameTextForPlayer(i,"~g~Posto Ipiranga ~r~/abastecer",3000,4);
				AreaPosto[i] = 1;
			}
			else if((X >= 651.7850 && X <= 661.3630 && Y >= -577.0740 && Y <= -555.3830) || (X >= 2131.2070 && X <= 2161.8208 && Y >= 2735.4387 && Y <= 2762.3884) || (X >= -1615.1073 && X <= -1601.3243 && Y >= -2733.9380 && Y <= -2692.7102) || (X >= 1587.0552 && X <= 1605.8910 && Y >= 2189.7161 && Y <= 2208.1714)){
			    GameTextForPlayer(i,"~g~Posto Texaco ~r~/abastecer",3000,4);
			    AreaPosto[i] = 1;
			}
			else if((X >= 996.3851 && X <= 1011.8171 && Y >= -943.7941 && Y <= -930.1505) || (X >= -107.9445 && X <= -77.7968 && Y >= -1178.9248 && Y <= -1163.9293) || (X >= -2420.0505 && X <= -2400.0459 && Y >= 958.4067 && Y <= 997.0031) || (X >= -1703.8510 && X <= -1644.2720 && Y >= 408.3849 && Y <= 427.6900) || (X >= 2104.0168 && X <= 2136.1519 && Y >= 901.5171 && Y <= 947.6444)){
			    GameTextForPlayer(i,"~g~Posto Shell ~r~/abastecer",3000,4);
			    AreaPosto[i] = 1;
			}
			else if((X >= -1695.3916 && X <= -1659.0499 && Y >= 412.7228 && Y <= 414.0763) || (X >= -1675.6531 && X <= -1675.1965 && Y >= 398.1009 && Y <= 434.0430) || (X >= 1932.0310 && X <= 1948.1785 && Y >= -1783.5273 && Y <= -1764.2950) || (X >= 992.8317 && X <= 1016.6620 && Y >= -945.4556 && Y <= -929.5608) || (X >= 2189.5925 && X <= 2213.6421 && Y >= 2463.2566 && Y <= 2487.5833)){
		    	GameTextForPlayer(i,"~g~Posto Petrobras ~r~/abastecer",3000,4);
			    AreaPosto[i] = 1;
			}
             else if(AreaPosto[i] == 1){
            AreaPosto[i] = 0;
            }
  }
}

public Score(){
for(new i=0; i<MAX_PLAYERS; i++){
new string[256];
new pname[MAX_PLAYER_NAME];
        GetPlayerName(i, pname, MAX_PLAYER_NAME);
        SetPlayerScore(i, dini_Int(pname, "Nivel"));
        if(dini_Int(pname, "Nivel") > dini_Int("Top.ini", "Nivel")){
        dini_IntSet("Top.ini", "Nivel", dini_Int(pname, "Nivel"));
        dini_Set("Top.ini", "NivelNome", pname);
        }
        if(dini_Int(pname, "Fama") > dini_Int("Top.ini", "Fama")){
        dini_IntSet("Top.ini", "Fama", dini_Int(pname, "Fama"));
        dini_Set("Top.ini", "FamaNome", pname);
        }
        if(MinutisOn[i] > dini_Int("Top.ini", "Minutos")){
        dini_IntSet("Top.ini", "Minutos", MinutisOn[i]);
        dini_Set("Top.ini", "MinutosNome", pname);
        }
        if(pAdmin[i] >= 1 && pAdmin[i] <= 5){
        if(pAdmin[i] == 1){
        SetPlayerChatBubble(i, "~> Moderador <~", 0x8080FFFF, 100.0, 10000);
        }
        if(pAdmin[i] == 2){
        SetPlayerChatBubble(i, "~> Sub-Admin <~", 0x8080FFFF, 100.0, 10000);
        }
        if(pAdmin[i] == 3){
        SetPlayerChatBubble(i, "~> Admin <~", 0x8080FFFF, 100.0, 10000);
        }
        if(pAdmin[i] == 4){
        SetPlayerChatBubble(i, "~> Sub-Dono <~", 0x8080FFFF, 100.0, 10000);
        }
        if(pAdmin[i] == 5){
        SetPlayerChatBubble(i, "~> Dono <~", 0x8080FFFF, 100.0, 10000);
        }
        } else {
        if(GetPlayerWantedLevel(i) > 0){
        format(string,256,"~> Procurado Nivel %d <~",GetPlayerWantedLevel(i));
        SetPlayerChatBubble(i,string, Vermelho, 100.0, 10000);
        }
		}

  }
}

public ChangeText(){
for(new i=0; i<MAX_PLAYERS; i++){
//PlayerUpdate(i);
new string[256];
new pname[MAX_PLAYER_NAME];
        GetPlayerName(i, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "~r~Nivel:~g~%d~n~~r~Exp:~b~(%d/5)~n~~r~Facul:~b~%d~n~~r~Fome:~y~%d%%~n~~r~Comb:~p~%d", dini_Int(pname, "Nivel"), dini_Int(pname, "Experiencia"), dini_Int(pname, "Faculdade"), dini_Int(pname, "Fome"), dini_Int(pname, "Combustivel"));
TextDrawSetString(Textdraw0[i], string);
//format(string, sizeof(string), "~w~Fome:~n~~r~%d%%", dini_Int(pname, "Fome"));
//TextDrawSetString(fominha[i], string);
if(dini_Int(pname, "Fome") >= 80){
praga[i] = 200;
Praga(i);
GameTextForPlayer(i, "~r~fome...", 10000, 6);
TextDrawShowForPlayer(i, mote);
//ApplyAnimation(i,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
/*if(IsPlayerInAnyVehicle(i)){
SetVehicleVelocity(GetPlayerVehicleID(i), 0, 0, 0);
} else {
SetPlayerVelocity(i, 0, 0, 0);
}     */
//comfome[i] = 1;
} else {
if(comfome[i] == 1){
//comfome[i] = 0;
//ClearAnimations(i);
}
}
  }
}

public RandomMSGs()
{
   new string[256];
   new random1 = random(sizeof(MSGs));
   new random2 = random(sizeof(COLORS));
   format(string, sizeof(string), "%s", MSGs[random1]);
   SendClientMessageToAll(COLORS[random2],string);
}



public Up(playerid)
{
//for(new i=0;i<MAX_PLAYERS;i++){
//dia = 0;
new string[256];
new aname[MAX_PLAYER_NAME];
GetPlayerName(playerid, aname, MAX_PLAYER_NAME);
if(Logado[playerid] == 1){
if(dini_Int(aname, "Vip") > 0){
dini_IntSet(aname, "Nivel", dini_Int(aname, "Nivel")+1);
dini_IntSet(aname, "PFama", 1);
} else {
dini_IntSet(aname, "Nivel", dini_Int(aname, "Nivel")+1);
dini_IntSet(aname, "PFama", 1);
}
SendClientMessage(playerid, Azul,"Você completou 5/5 de exp, um resumo de seus ganhos:");
format(string, sizeof(string), "1 nivel, agora você tem %d niveis.", dini_Int(aname, "Nivel"));
SendClientMessage(playerid, Verde, string);
SendClientMessage(playerid, Amarelo, "Agora você pode famar alguém, /famar [id]");
if(dini_Int(aname, "Prop") == 1){
if(dini_Int(aname, "Vip") > 0){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+3000);
format(string, sizeof(string), "[Philips-Vip]A sua propriedade de nome %s lhe rendeu 3000 reais.", dini_Get(aname, "Propnome"));
SendClientMessage(playerid, Verde, string);
} else {
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+1500);
format(string, sizeof(string), "A sua propriedade de nome %s lhe rendeu 1500 reais.", dini_Get(aname, "Propnome"));
SendClientMessage(playerid, Verde, string);
}
}
if(dini_Int(aname, "Casa") == 1){
if(dini_Int(aname, "Vip") > 0){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")-80);
format(string, sizeof(string), "[Philips-Vip]Você tem uma casa e suas contas foram pagas, 50 Reais de Luz e 30 Reais de água.");
SendClientMessage(playerid, Verde, string);
} else {
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")-150);
format(string, sizeof(string), "Você tem uma casa e suas contas foram pagas, 120 Reais de Luz e 30 Reais de água.");
SendClientMessage(playerid, Verde, string);
}
}
if(dini_Int(aname, "ContaBancaria") == 1){
new salarioagora;
salarioagora = dini_Int(aname, "SaldoBancario");
if(dini_Int(aname, "Profissao") == Estagiario){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Guarda){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Policial_R){
 dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Policial_M){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Policial_C){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Policial_F){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Delegado){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Bope){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Swat){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == FBI){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == ComandoVermelho){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Narcoticos){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Traficante){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Assasino){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Terrorista){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Sequestrador){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == AssasinoProfissional){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Jornalista){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Fotografo){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Reporter){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Ancora){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Meteorologista){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Mecanico){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == VendedorCasa){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == VendedorSkin){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == VendedorCarro){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == VendedorComb){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Taxista){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo);
}
if(dini_Int(aname, "Profissao") == Medico){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")+SalarioMinimo+SalarioMinimo+SalarioMinimo);
}
format(string, sizeof(string), "Você recebeu seu salário: R$%d.", dini_Int(aname, "SaldoBancario")-salarioagora);
SendClientMessage(playerid, Verde, string);
}
}
return 1;
}

public DestruirObjeto(objid) DestroyObject(objid);
public CriarExplosao(Float:X,Float:Y,Float:Z,tipo,Float:diam) {
 CreateExplosion(X,Y,Z,tipo,diam);    
 blockbomba = 0; 
 } 

public OnPlayerUpdate(playerid)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
new arma;
arma = GetPlayerWeapon(playerid);
if(GetPlayerWantedLevel(playerid) > 6){
SetPlayerWantedLevel(playerid, 6);
}
if(arma == 38 || arma == 35 || arma == 36 || arma == 37) {
if(Logado[playerid] == 1 && nickn[playerid] == 0){
new string[256];
SendClientMessage(playerid, Amarelo, "[Philips-Bot]Você foi pego de Weapon Cheat e foi Banido !"); 
new plrIP[16];                        
GetPlayerIp(playerid, plrIP, sizeof(plrIP)); 
dini_Set(pname, "IP", plrIP);             
dini_IntSet(pname, "Banido", 1);
Ban(playerid);
format(string, sizeof(string), "[Philips-Bot]O player %s(id:%d) foi pego de Weapon Cheat e foi Banido.", pname, playerid); 
SendClientMessageToAll(Amarelo, string);
printf("[Philips-Bot]%s (ID:%d) foi pego com Weapon Cheat e foi banido\n",pname,playerid);
return 1;
}
return 1;
}
new Float:vida;
GetPlayerHealth(playerid, vida);
if(vida < sangui[playerid]){
TextDrawShowForPlayer(playerid, dano);
sangui[playerid] = vida;
return 1;
}
if(vida < 15){
TextDrawShowForPlayer(playerid, motendo);
}
if(vida < 10){
TextDrawHideForPlayer(playerid, motendo);
TextDrawShowForPlayer(playerid, motendo2);
}
if(vida > 15){
TextDrawHideForPlayer(playerid, motendo);
TextDrawHideForPlayer(playerid, motendo2);
}
sangui[playerid] = vida;
if(dini_Int(pname, "Experiencia") >= 5){
Up(playerid);
dini_IntSet(pname, "Experiencia", dini_Int(pname, "Experiencia")-5);
}
if(dini_Int(pname, "pontoshab") == 30){
dini_IntSet(pname, "HabTerrestre", 0);
}
if(dini_Int(pname, "expulso") == 60){
dini_IntSet(pname, "faculdade", 0);
}
return 1;
}  



/*public ChecarArmas(playerid) 
{
for(new i=0;i<MAX_PLAYERS;i++){ 
new arma;
arma = GetPlayerWeapon(i);
new pname[MAX_PLAYER_NAME];
GetPlayerName(i, pname, MAX_PLAYER_NAME); 
if(arma == 38 || arma == 35 || arma == 36 || arma == 37) {
if(Logado[i] == 1){
new string[256];
SendClientMessage(i, Amarelo, "[Philips-Bot]Você foi pego de Weapon Cheat e foi Banido !"); 
new plrIP[16];                        
GetPlayerIp(i, plrIP, sizeof(plrIP)); 
dini_Set(pname, "IP", plrIP);             
dini_IntSet(pname, "Banido", 1);
Ban(i);
format(string, sizeof(string), "[Philips-Bot]O player %s(id:%d) foi pego de Weapon Cheat e foi Banido.", pname, i); 
SendClientMessageToAll(Amarelo, string);
printf("[Philips-Bot]%s (ID:%d) foi pego com Weapon Cheat e foi banido\n",pname,i);
}
}
}
return 1;
} */

public OnVehicleSpawn(vehicleid){
Trancado[vehicleid] = 0;
TrancadoPara[vehicleid] = 0;
cargadele[vehicleid] = 0;
}

/*public ChecarGrana(playerid)
{
for(new i=0;i<MAX_PLAYERS;i++){
new grana;
grana = GetPlayerPCash(i);
if(grana > 50000000) 
{
new string[256];
SendClientMessage(i, Amarelo, "[Philips-Bot]Você foi pego de Money Cheat e teve a grana Resetada.");
ResetPlayerPCash(i); 
new pname[MAX_PLAYER_NAME];
GetPlayerName(i, pname, MAX_PLAYER_NAME);
format(string, sizeof(string), "[Philips-Bot]O player %s(id:%d) foi pego de Money Cheat(R$%d) e teve a grana resetada.", pname, i, grana);
SendClientMessageToAll(Amarelo, string);
printf("%s (ID:%d) foi pego com $%d e teve o dinheiro resetado\n",pname,i,grana);
}
}
return 1;
} */
    public PescaT()
{
	for(new i=0; i<MAX_PLAYERS; i++){
        if(IsPlayerConnected(i)) {         
          if(Pescando[i] == 1){           
          new check;            
          new string[256];
        check = CPS_GetPlayerCheckpoint(i);
        if(check == Pescaria){
          Peixes[i] = Peixes[i]+1;            
          new randomp = random(sizeof(PeixesR));         
          format(string, sizeof(string), "Sua rede voltou... Você acaba de pescar um(a) %s !", PeixesR[randomp]);          
          SendClientMessage(i, Amarelo, string);
          format(string, sizeof(string), "Pode continuar a pescar, ou ir vender sua pesca. Você tem %d peixes !", Peixes[i]);   
          SendClientMessage(i, Amarelo, string); 
          Pescando[i] = 0;      
          } else {             
          Pescando[i] = 0;
          }         
          }
			}
	}
 }
/*forward IsNumeric(const string[]);
public IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++) if (string[i] > '9' || string[i] < '0') return 0;
	return 1;
}     */

/*encrypt(pass[])
{
	static charset[] = "qwertyaQWERTYUIOPZXCVBNMLKJHGFDSAsdfghzxcvbnuiopjklm1324657809_";
	static css = 63;
	new target[16 + 1];
	new	j = strlen(pass);
	new sum = j;
	new	tmpp = 0;
	new	i;
	new	modw;
	for (i = 0; i < 16 || i < j; i++)
	{
		modw = i % 16;
		tmpp = (i >= j) ? charset[(7 * i) % css] : pass[i];
		sum = (sum + chrfind(tmpp, charset) + 1)		% css;
		target[modw] = charset[(sum + target[modw])	% css];
	}
	target[16] = '\0';
	return target;
} */

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


public OnPlayerStateChange(playerid, newstate, oldstate)
{
if(newstate == PLAYER_STATE_ONFOOT){
if(Taximetro[playerid][0] == 1){
			SendClientMessage(playerid, COLOR_GREEN, "Taxi pago.");
			SendClientMessage(Taximetro[playerid][1], COLOR_RED, "Você recebeu o valor da corrida até aqui.");
			GivePlayerPCash(playerid, -PrecoCorrida[playerid]);
			GivePlayerPCash(Taximetro[playerid][1], PrecoCorrida[playerid]);
			PrecoCorrida[playerid] = 0;
			Taximetro[playerid][1] = 0;
			Taximetro[playerid][0] = 0;
	    	return 1;
		}
  }
if(newstate == 2){
new vid;
vid = GetPlayerVehicleID(playerid);
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
new modelo;
modelo = GetVehicleModel(vid);
new string[256];
for(new carro = 0; carro < MAX_CARROS; carro++)
{
format(string, sizeof(string), "carro%d.ini", carro);
if(dini_Exists(string)){
if(vid == dini_Int(string, "Id")){
if(dini_Int(string, "TDono") == 1){
if(strcmp(dini_Get(string, "Dono"), pname, true) == 0){
SendClientMessage(playerid, Azul, "Philips RPG - Este carro é seu, seja bem vindo !");
} else {
format(string, sizeof(string), "Este carro não é seu, é de: \n%s", dini_Get(string, "Dono"));
ShowPlayerDialog(playerid, 75, DIALOG_STYLE_MSGBOX, "Philips RPG", string, "Ok", "Fechar");
RemovePlayerFromVehicle(playerid);
}
} else {
format(string, sizeof(string), "Philips RPG - Este carro está a venda ! Preço: %d reais, use /comprarcarro", dini_Int(string, "Preco"));
SendClientMessage(playerid, Amarelo, string);
SendClientMessage(playerid, Vermelho, "Para sair do carro digite /saircarro ou aperte F.");
TogglePlayerControllable(playerid, 0);
incar[playerid] = 1;
}
}
}
}
if(modelo == 596){
if(dini_Int(pname, "Profissao") == Policial_R || dini_Int(pname, "Profissao") == Policial_M || dini_Int(pname, "Profissao") == Policial_C || dini_Int(pname, "Profissao") == Policial_F || dini_Int(pname, "Profissao") == Delegado || dini_Int(pname, "Profissao") == Bope || dini_Int(pname, "Profissao") == Swat || dini_Int(pname, "Profissao") == Narcoticos || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Bem Vindo Policial.");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(modelo == 528 || modelo == 490){
if(dini_Int(pname, "Profissao") == FBI || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Azul, "Bem Vindo Agente.");
} else {
if(dini_Int(pname, "Profissao") == ComandoVermelho){
SendClientMessage(playerid, Vermelho, "Você está roubando um veiculo do FBI. CORRA.");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
}
if(modelo == 444 || modelo == 471){
if(dini_Int(pname, "Profissao") == ComandoVermelho || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Membro do CV, bem vindo.");
} else {
if(dini_Int(pname, "Profissao") == FBI){
SendClientMessage(playerid, Azul, "Agente FBI, você apreendeu um carro do CV.");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
}
if(modelo == 497){
if(dini_Int(pname, "Profissao") == Policial_R || dini_Int(pname, "Profissao") == Policial_M || dini_Int(pname, "Profissao") == Policial_C || dini_Int(pname, "Profissao") == Policial_F || dini_Int(pname, "Profissao") == Delegado || dini_Int(pname, "Profissao") == Bope || dini_Int(pname, "Profissao") == Swat || dini_Int(pname, "Profissao") == Narcoticos || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Bem Vindo Policial.");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(modelo == 488){
if(dini_Int(pname, "Profissao") == Jornalista || dini_Int(pname, "Profissao") == Fotografo || dini_Int(pname, "Profissao") == Reporter || dini_Int(pname, "Profissao") == Ancora || dini_Int(pname, "Profissao") == Meteorologista || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Bem Vindo Jornalista. Encubra as notícias !.");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(modelo == 525){
if(dini_Int(pname, "Profissao") == Mecanico || pAdmin[playerid] >= 3){
IsTowTrucker[playerid]=1;
TowTruckers = TowTruckers+1;
SendClientMessage(playerid, Verde, "Bem Vindo Mecanico.");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(modelo == 416){
if(dini_Int(pname, "Profissao") == Medico || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Bem Vindo Médico. Cuide bem de seus pacientes !.");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(modelo == 582){
if(dini_Int(pname, "Profissao") == Jornalista || dini_Int(pname, "Profissao") == Fotografo || dini_Int(pname, "Profissao") == Reporter || dini_Int(pname, "Profissao") == Ancora || dini_Int(pname, "Profissao") == Meteorologista || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Bem Vindo Jornalista. Encubra as notícias !.");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(modelo == 601){
if(dini_Int(pname, "Profissao") == Swat || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Bem Vindo Policial.");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(modelo == 427){
if(dini_Int(pname, "Profissao") == Bope || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Bem Vindo Policial.");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(modelo == 523){
if(dini_Int(pname, "Profissao") == Guarda || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Bem Vindo Policial.");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(modelo == 601){
if(dini_Int(pname, "Profissao") == Swat || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Bem Vindo Policial.");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(modelo == 599){
if(dini_Int(pname, "Profissao") == Delegado || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Bem Vindo Policial. Um Colete vai ajudar você.");
SetPlayerArmour(playerid, 100);
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(modelo == 420){
if(dini_Int(pname, "Profissao") == Taxista || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Bem Vindo Taxista, use /ttaxi [id].");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(modelo == 586){
if(dini_Int(pname, "Profissao") == Taxista || pAdmin[playerid] >= 3){
SendClientMessage(playerid, Verde, "Bem Vindo Taxista, use /ttaxi [id].");
} else {
SendClientMessage(playerid, Vermelho, "Por roubar um veiculo seu nivel de procurado foi aumentado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
if(dini_Int(pname, "Combustivel") <= 0 && modelo != 481 && modelo != 510 && modelo != 509){
RemovePlayerFromVehicle(playerid);
SendClientMessage(playerid, Vermelho, "Você não tem combustivel.");
} else {
if(modelo == 417 || modelo == 488 || modelo == 487 || modelo == 548 || modelo == 497 || modelo == 563 || modelo == 447 || modelo == 469 || modelo == 592 || modelo == 577 || modelo == 511 || modelo == 512 || modelo == 593 ||modelo == 520 || modelo == 553 || modelo == 476 || modelo == 519 || modelo == 460 || modelo == 513){
if(dini_Int(pname, "HabAerea") == 0){
SendClientMessage(playerid, Vermelho, "Você não tem habilitação aerea e ganhou nivel de procurado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
} else {
if(modelo == 472 || modelo == 473 || modelo == 493 || modelo == 595 || modelo == 484 || modelo == 430 || modelo == 453 || modelo == 452 || modelo == 446 || modelo == 454){
if(dini_Int(pname, "HabNautica") == 0){
SendClientMessage(playerid, Vermelho, "Você não tem habilitação nautica e ganhou nivel de procurado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
} else {
}
if(dini_Int(pname, "HabTerrestre") == 0){
if(modelo == 509 || modelo == 510 || modelo == 527 || modelo == 481){
if(modelo == 527){
if(emteste[playerid] == 1){
} else {
SendClientMessage(playerid, Vermelho, "Você não tem habilitação terrestre e ganhou nivel de procurado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
//SendClientMessage(playerid, Vermelho, "Você está dirigindo uma bicicleta, por tanto, não presisa de habilitação.");
//SendClientMessage(playerid, Vermelho, "Compre habilitações perto da Delegacia, o simbolo de um carrinho azul.");
} else {
SendClientMessage(playerid, Vermelho, "Você não tem habilitação terrestre e ganhou nivel de procurado.");
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+1);
}
}
}
}
}
return 1;
}

///////////////////////////
//   Standard Functions
//////////////////////////

stock GetName(playerid)
{
	new pname[MAX_PLAYER_NAME]; pname="ID Inválido";
	if(IsPlayerConnected(playerid)) {
		GetPlayerName(playerid, pname, sizeof (pname));
	}
	return pname;
}

stock GetProps(playerid){
new props;
new string[256];
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, sizeof (pname));
for(new p = 0; p < MAX_CASAS; p++)
{
format(string, sizeof(string), "prop%d.ini", p);
if(dini_Int(string, "TDono") == 1){
if(strcmp(dini_Get(string, "Dono"), pname, false) == 0){
props = props+1;
}
}
}
return props;
}

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x); tempposy = (oldposy -y); tempposz = (oldposz -z);
	if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{ return true; }
	return false;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	{

    if ((newkeys==KEY_SUBMISSION)&&(IsPlayerInAnyVehicle(playerid))&&(GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
	    {
	    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 525)
	        {
	        SendClientMessage(playerid,0xFFFF00AA,"Guinchando o carro...");
			new Float:pX,Float:pY,Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			new Float:vX,Float:vY,Float:vZ;
			new Found=0;
			new vid=0;
			while((vid<MAX_VEHICLES)&&(!Found))
   				{
   				vid++;
   				GetVehiclePos(vid,vX,vY,vZ);
   				if  ((floatabs(pX-vX)<7.0)&&(floatabs(pY-vY)<7.0)&&(floatabs(pZ-vZ)<7.0)&&(vid!=GetPlayerVehicleID(playerid)))
   				    {
   				    Found=1;
   				    if	(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
   				        {
   				        DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
   				        }
   				    AttachTrailerToVehicle(vid,GetPlayerVehicleID(playerid));
   				    SendClientMessage(playerid,0xFFFF00AA,"Carro guinchado!");
   				    }
       			}
			if  (!Found)
			    {
			    SendClientMessage(playerid,0xFFFF00AA,"Você não está perto de um carro.");
			    }
		    }
	    }

        if (newkeys==KEY_SECONDARY_ATTACK && emcasa[playerid] == 1)
	    {
        emcasa[playerid] = 0;
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, CasaX[playerid], CasaY[playerid], CasaZ[playerid]);
        SendClientMessage(playerid, Vermelho, "Você saiu da casa.");
        return 1;
        }
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
    new string[256];
    for(new c = 0; c < MAX_CASAS; c++)
    {
    format(string, sizeof(string), "casa%d.ini", c);

        if (newkeys==KEY_WALK && IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ")))
	    {
       if(strcmp(dini_Get(string, "Dono"), pname, false) == 0 || IsPlayerAdmin(playerid)){
       if(dini_Int(string, "Trancada") == 1){
        dini_IntSet(string, "Trancada", 0);
        SendClientMessage(playerid, Verde, "Casa Destrancada");
        } else {
        dini_IntSet(string, "Trancada", 1);
        SendClientMessage(playerid, Verde, "Casa Trancada");
        }
       }
       return 1;
     }

        if(newkeys==KEY_SECONDARY_ATTACK && IsPlayerInRangeOfPoint(playerid, 2.0, dini_Float(string, "PosX"), dini_Float(string, "PosY"), dini_Float(string, "PosZ")))
	    {
        if(dini_Int(string, "Trancada") == 1){
        if(strcmp(dini_Get(string, "Dono"), pname, false) == 0 || IsPlayerAdmin(playerid)){
        new strx[256];
        format(strx, sizeof(strx), "int%d.ini", dini_Int(string, "Int"));
        if(dini_Exists(strx)){
        emcasa[playerid] = 1;
        new Float:X, Float:Y, Float:Z;
        GetPlayerPos(playerid, X, Y, Z);
        CasaX[playerid] = X;
        CasaY[playerid] = Y;
        CasaZ[playerid] = Z;
        SetPlayerVirtualWorld(playerid, c);
        SetPlayerInterior(playerid, dini_Int(strx, "Int"));
        SetPlayerPos(playerid, dini_Float(strx, "EX"), dini_Float(strx, "EY"), dini_Float(strx, "EZ"));
        SendClientMessage(playerid, Vermelho, "Você entrou na casa para sair use ENTER.");
        }
        }
        } else {
        new strx[256];
        format(strx, sizeof(strx), "int%d.ini", dini_Int(string, "Int"));
        if(dini_Exists(strx)){
        emcasa[playerid] = 1;
        new Float:X, Float:Y, Float:Z;
        GetPlayerPos(playerid, X, Y, Z);
        CasaX[playerid] = X;
        CasaY[playerid] = Y;
        CasaZ[playerid] = Z;
        SetPlayerVirtualWorld(playerid, c);
        SetPlayerInterior(playerid, dini_Int(strx, "Int"));
        SetPlayerPos(playerid, dini_Float(strx, "EX"), dini_Float(strx, "EY"), dini_Float(strx, "EZ"));
        SendClientMessage(playerid, Vermelho, "Você entrou na casa para sair use ENTER.");
        }
        }
        }
        return 1;
        }

        if (newkeys==KEY_ACTION)
	    {  
        new aname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, aname, MAX_PLAYER_NAME);   
//     new string[256];
//	    format(string, sizeof(string), "Nível: %d(%d/5 exp). Profissao: %s \nFaculdade: %d meses Créditos cartão telefonico: %d. \n%d Celular(s), %d mp3, Skin numero %d.", dini_Int(aname, "Nivel"), dini_Int(aname, "Experiencia"), Prof[dini_Int(aname, "Profissao")], dini_Int(aname, "Faculdade"), dini_Int(aname, "CartaoTelefonico"), dini_Int(aname, "Celular"), dini_Int(aname, "MP3"), dini_Int(aname, "Skin"));
//ShowPlayerDialog(playerid, 869, DIALOG_STYLE_MSGBOX, "Meu Status", string, "Ok", "Fechar");
	    }
        if (newkeys==KEY_SECONDARY_ATTACK && pAdmin[playerid] >= 4 && amod[playerid] == 1)
	    {
        new Float:px, Float:py, Float:pz, Float:pa;
				GetPlayerFacingAngle(playerid,pa);
				if(pa >= 0.0 && pa <= 22.5) //n1
				{
					GetPlayerPos(playerid, px, py, pz);
					SetPlayerPos(playerid, px, py+20, pz);
				}
				if(pa >= 332.5) //n2
				{
					GetPlayerPos(playerid, px, py, pz);
					SetPlayerPos(playerid, px, py+20, pz);
				}
				if(pa >= 22.5 && pa <= 67.5) //nw
				{
					GetPlayerPos(playerid, px, py, pz);
					SetPlayerPos(playerid, px-10, py+10, pz);
				}
				if(pa >= 67.5 && pa <= 112.5) //w
				{
					GetPlayerPos(playerid, px, py, pz);
					SetPlayerPos(playerid, px-20, py, pz);
				}
				if(pa >= 112.5 && pa <= 157.5) //sw
				{
					GetPlayerPos(playerid, px, py, pz);
					SetPlayerPos(playerid, px-10, py-10, pz);
				}
				if(pa >= 157.5 && pa <= 202.5) //s
				{
					GetPlayerPos(playerid, px, py, pz);
					SetPlayerPos(playerid, px, py-20, pz);
				}
				if(pa >= 202.5 && pa <= 247.5)//se
				{
					GetPlayerPos(playerid, px, py, pz);
					SetPlayerPos(playerid, px+10, py-10, pz);
				}
				if(pa >= 247.5 && pa <= 292.5)//e
				{
					GetPlayerPos(playerid, px, py, pz);
					SetPlayerPos(playerid, px+20, py, pz);
				}
				if(pa >= 292.5 && pa <= 332.5)//e
				{
					GetPlayerPos(playerid, px, py, pz);
					SetPlayerPos(playerid, px+10, py+10, pz);
				}
        }
        if (newkeys==KEY_SECONDARY_ATTACK && incar[playerid] == 1)
	    {
        TogglePlayerControllable(playerid, 1);
RemovePlayerFromVehicle(playerid);
incar[playerid] = 0;
}
        if (newkeys==KEY_SPRINT && pAdmin[playerid] >= 4 && amod[playerid] == 1)
	    {
        new Float:px, Float:py, Float:pz;
        GetPlayerPos(playerid, px, py, pz);
		SetPlayerPos(playerid, px, py, pz+5);
        }
        if (newkeys==KEY_WALK && pAdmin[playerid] >= 4 && amod[playerid] == 1)
	    {
        if(gmod[playerid] == 0){
        SetPlayerHealth(playerid, 999999);
        gmod[playerid] = 1;
        SendClientMessage(playerid, Azul, "Modo invencivel: ATIVADO");
        }  else {
        if(gmod[playerid] == 1){
        SetPlayerHealth(playerid, 100);
        gmod[playerid] = 0;
        SendClientMessage(playerid, Azul, "Modo invencivel: DESATIVADO");
        }
        }
        }
     return 1;
	}

public VoteTimer(giveplayerid)
{
	new string[STRING];
	new TempPlayerCount = plon;
	TempPlayerCount /= 2;
    if(SendoVotado[giveplayerid] == 1){
	if(Votes > TempPlayerCount)
	{
		format(string, sizeof(string), "%s foi kickado do servidor MOTIVO:VOTAÇÃO", Name(giveplayerid));
		SendClientMessageToAll(YELLOW, string);
		Kick(giveplayerid);
	}
	else
	{
	    format(string, sizeof(string), "%s não foi expulso, porque não houve votos suficientes", Name(giveplayerid));
	    SendClientMessageToAll(YELLOW, string);
	}
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
	    Voted[i] = 0;
	}
    SendoVotado[giveplayerid] = 0;
	Votes = 0;
	VoteKick = 0;
    }    
    Votes = 0;
	VoteKick = 0;
	return 1;
 }

public WaitT(playerid)
{
	Wait[playerid] = 0;
	return 1;
}

public playermoney(playerid)
{
    ResetPlayerMoney(playerid);
    return GivePlayerMoney(playerid,PCash[playerid]);
}

public CheckStatus()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInAnyVehicle(i))
			{

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

				if(TextDrawsShown[i] == false)
				{
				    TextDrawShowForPlayer(i, Text:Black0);
				    TextDrawShowForPlayer(i, Text:Black1);
				    TextDrawShowForPlayer(i, Text:Black2);
				    TextDrawShowForPlayer(i, Text:Black3);
				    TextDrawShowForPlayer(i, Text:LightBlack);
				    TextDrawShowForPlayer(i, Text:BlackHealth);
				    TextDrawShowForPlayer(i, Text:DarkRedHealth);
				    TextDrawShowForPlayer(i, Text:BlackSpeed);
				    TextDrawShowForPlayer(i, Text:DarkYellowSpeed);
				    TextDrawShowForPlayer(i, Text:Marker);
				    TextDrawsShown[i] = true;
				}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			    new String[128];
		        new Float:X, Float:Y, Float:Z, Float:Speed;
                GetVehicleVelocity(GetPlayerVehicleID(i), X, Y, Z);
                Speed = floatmul(floatsqroot(floatadd(floatadd(floatpower(X, 2), floatpower(Y, 2)),  floatpower(Z, 2))), 100.0);
				new PlayerVehicleModelID = GetVehicleModel(GetPlayerVehicleID(i));
				PlayerVehicleModelID -= 400;
                new nomepl[MAX_PLAYER_NAME];                
                GetPlayerName(i, nomepl, MAX_PLAYER_NAME);
				format(String,sizeof(String),"~b~Veiculo:~n~~w~%s~n~~b~Health:~n~~n~VeLo:~n~~w~%im/h~n~%ikm/h~n~~n~~b~CoMb: ~g~%d ~r~litros", PlayerVehicle[PlayerVehicleModelID], floatround(floatdiv(Speed, 1.609344), floatround_floor), floatround(Speed, floatround_floor), dini_Int(nomepl, "Combustivel"));
				if(VHSCreated[i] == true)
				{
					TextDrawDestroy(VHS[i]);
				}
				VHS[i] = TextDrawCreate(485.000000,355.000000,String);
				TextDrawAlignment(VHS[i],0);
				TextDrawBackgroundColor(VHS[i],0x000000ff);
				TextDrawFont(VHS[i],1);
				TextDrawLetterSize(VHS[i],0.299999,1.000000);
				TextDrawColor(VHS[i],0xffffffff);
				TextDrawSetOutline(VHS[i],1);
				TextDrawSetProportional(VHS[i],1);
				TextDrawSetShadow(VHS[i],1);
            	TextDrawShowForPlayer(i, VHS[i]);
            	VHSCreated[i] = true;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

				new Float:CarHealth;
				GetVehicleHealth(GetPlayerVehicleID(i), CarHealth);
				if(LightRedHealthCreated[i] == true)
				{
					TextDrawDestroy(LightRedHealth[i]);
				}
				LightRedHealth[i] = TextDrawCreate(488.000000,386.000000,"_");
				TextDrawUseBox(LightRedHealth[i],1);
				TextDrawBoxColor(LightRedHealth[i],0xff000099);
				TextDrawTextSize(LightRedHealth[i], floatadd(484.0, floatdiv(CarHealth, 9.5238095238)),0.000000);
				TextDrawAlignment(LightRedHealth[i],0);
				TextDrawBackgroundColor(LightRedHealth[i],0x000000ff);
				TextDrawFont(LightRedHealth[i],3);
				TextDrawLetterSize(LightRedHealth[i],1.000000,0.199999);
				TextDrawColor(LightRedHealth[i],0xffffffff);
				TextDrawSetOutline(LightRedHealth[i],1);
				TextDrawSetProportional(LightRedHealth[i],1);
				TextDrawSetShadow(LightRedHealth[i],1);
            	TextDrawShowForPlayer(i, LightRedHealth[i]);
            	LightRedHealthCreated[i] = true;
				if(CarHealth < 250)
				{
					if(ExclamationShown[i] == true)
					{
						TextDrawHideForPlayer(i, Text:Exclamation);
					    ExclamationShown[i] = false;
					}
					else
					{
						TextDrawShowForPlayer(i, Text:Exclamation);
					    ExclamationShown[i] = true;
					}
				}
				else if(CarHealth > 250)
				{
					if(ExclamationShown[i] == true)
					{
						TextDrawHideForPlayer(i, Text:Exclamation);
					    ExclamationShown[i] = false;
					}
				}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

				if(LightYellowSpeedCreated[i] == true)
				{
					TextDrawDestroy(LightYellowSpeed[i]);
				}
				LightYellowSpeed[i] = TextDrawCreate(537.000000,404.000000,"_");
				TextDrawUseBox(LightYellowSpeed[i],1);
				TextDrawBoxColor(LightYellowSpeed[i],0xffff0066);
				if(Speed >= 150)
				{
					TextDrawTextSize(LightYellowSpeed[i],589.000000,0.000000);
				}
				else
				{
					TextDrawTextSize(LightYellowSpeed[i], floatadd(533.0, floatmul(Speed, 0.373333333333)),0.000000);
				}
				TextDrawAlignment(LightYellowSpeed[i],0);
				TextDrawBackgroundColor(LightYellowSpeed[i],0x000000ff);
				TextDrawFont(LightYellowSpeed[i],3);
				TextDrawLetterSize(LightYellowSpeed[i],1.000000,1.200000);
				TextDrawColor(LightYellowSpeed[i],0xffffffff);
				TextDrawSetOutline(LightYellowSpeed[i],1);
				TextDrawSetProportional(LightYellowSpeed[i],1);
				TextDrawSetShadow(LightYellowSpeed[i],1);
            	TextDrawShowForPlayer(i, LightYellowSpeed[i]);
            	LightYellowSpeedCreated[i] = true;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			}
			else
			{
			    if(TextDrawsShown[i] == true)
			    {
					TextDrawHideForPlayer(i, Text:Black0);
					TextDrawHideForPlayer(i, Text:Black1);
					TextDrawHideForPlayer(i, Text:Black2);
					TextDrawHideForPlayer(i, Text:Black3);
					TextDrawHideForPlayer(i, Text:LightBlack);
					TextDrawHideForPlayer(i, Text:BlackHealth);
					TextDrawHideForPlayer(i, Text:DarkRedHealth);
					TextDrawHideForPlayer(i, Text:BlackSpeed);
					TextDrawHideForPlayer(i, Text:DarkYellowSpeed);
					TextDrawHideForPlayer(i, Text:Marker);
					TextDrawHideForPlayer(i, Text:Exclamation);
				    TextDrawsShown[i] = false;
				}
				TextDrawHideForPlayer(i, Text:VHS[i]);
				TextDrawHideForPlayer(i, Text:LightRedHealth[i]);
				TextDrawHideForPlayer(i, Text:LightYellowSpeed[i]);
			}
		}
	}
}

public Portoes()
{                                                                   
MoveObject (portaodp,1552.437988, -1627.392578, 15.156204, 3.0);
MoveObject(portaocv, 2423.698242, -2089.869873, 15.317423, 3.0);
MoveObject(portaofbi, 2232.818359, -2215.736084, 15.320267, 3.0);
MoveObject (portaoj,777.568481, -1329.843750, 15.320265, 3.0);
MoveObject(portaom,1535.336426, -1452.098389, 15.165947, 3.0);
MoveObject (TAXISTAS,1811.6870117188, -1886.5489501953, 15.181365966797, 3.0);
}

public Contagem()
{
if(conta == 0){
GameTextForAll("~b~5", 800, 4);
conta = conta+1;
}
else if(conta == 1){
GameTextForAll("~p~4", 800, 4);
conta = conta+1;
}
else if(conta == 2){
GameTextForAll("~r~3", 800, 4);
conta = conta+1;
}
else if(conta == 3){
GameTextForAll("~r~2", 800, 4);
conta = conta+1;
}
else if(conta == 4){
GameTextForAll("~r~1", 800, 4);
conta = conta+1;
}
else if(conta == 5){
GameTextForAll("~g~vai vai", 800, 4);
conta = 0;
KillTimer(counta);
}
}

public Taxi()
{
	for(new i=0; i<MAX_PLAYERS; i++){
		if(Taximetro[i][0] == 1){
			if(GetPlayerPCash(i) > PrecoCorrida[i] + 3){
			    new string[256];
				PrecoCorrida[i] = PrecoCorrida[i] + 3;
				format(string, sizeof(string), "O taxímetro mostra: $%d", PrecoCorrida[i]);
				SendClientMessage(i, COLOR_GREEN, string);
				SendClientMessage(Taximetro[i][1], COLOR_GREEN, string);
			}
			if(GetPlayerPCash(i) < PrecoCorrida[i] + 3){
				SendClientMessage(i, COLOR_RED, "Você não tem mais dinheiro para o taxi, vai ficar aqui");
				SendClientMessage(Taximetro[i][1], COLOR_RED, "Seu passageiro ficou sem dinheiro e por isso foi deixado aqui.");
				GivePlayerPCash(i, -PrecoCorrida[i]);
				GivePlayerPCash(Taximetro[i][1], PrecoCorrida[i]);
				RemovePlayerFromVehicle(i);
				PrecoCorrida[i] = 0;
				Taximetro[i][1] = 0;
				Taximetro[i][0] = 0;
			}
		}
	}
}
public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:current;
    current = GetPlayerMenu(playerid);
    new car;
	car = GetPlayerVehicleID(playerid);

//====================================================================================================
    if(current == Tunar)
    {
        switch(row)
        {
            case 0:
            {
            HideMenuForPlayer(Tunar, playerid);
            ShowMenuForPlayer(Paintjobs, playerid);
            TogglePlayerControllable(playerid, 0);
            }
            case 1:
            {
            HideMenuForPlayer(Tunar, playerid);
            ShowMenuForPlayer(Cores, playerid);
            TogglePlayerControllable(playerid, 0);
            }
            case 2:
            {
            HideMenuForPlayer(Tunar, playerid);
            ShowMenuForPlayer(Rodas, playerid);
            TogglePlayerControllable(playerid, 0);
            }
            case 3:
            {
            AddVehicleComponent(car,1010);
            TogglePlayerControllable(playerid,1);
            }
            case 4:
            {
            AddVehicleComponent(car,1087);
            TogglePlayerControllable(playerid,1);
            }
            case 5:
            {
			ChangeVehicleColor(car,1,1);
			AddVehicleComponent(car,1087);
			AddVehicleComponent(car,1010);
			AddVehicleComponent(car,1079);
			ChangeVehiclePaintjob(car,2);
            TogglePlayerControllable(playerid,1);
            }
            case 6:
            {
            TogglePlayerControllable(playerid, 1); // Cancelar
            }
        }
    }

    if(current == Paintjobs)
    {
        switch(row)
        {
            case 0: // Paintjobs 1
            {
            ChangeVehiclePaintjob(car,0);
            TogglePlayerControllable(playerid, 1);
            }
            case 1: // Paintjobs 2
            {
            ChangeVehiclePaintjob(car,1);
            TogglePlayerControllable(playerid, 1);
            }
            case 2: // Paintjobs 3
            {
            ChangeVehiclePaintjob(car,2);
            TogglePlayerControllable(playerid, 1);
            }
            case 3:
            {
            TogglePlayerControllable(playerid, 1); // Cancelar
            }
        }
    }

    if(current == Cores)
    {
        switch(row)
        {
            case 0: // Preto
            {
            ChangeVehicleColor(car,0,0);
            TogglePlayerControllable(playerid, 1);
            }
            case 1: // Branco
            {
            ChangeVehicleColor(car,1,1);
            TogglePlayerControllable(playerid, 1);
            }
            case 2: // Darbk Blue
            {
            ChangeVehicleColor(car,425,425);
            TogglePlayerControllable(playerid, 1);
            }
            case 3: // Light Blue
            {
            ChangeVehicleColor(car,2,2);
            TogglePlayerControllable(playerid, 1);
            }
            case 4: // Green
            {
            ChangeVehicleColor(car,16,16);
            TogglePlayerControllable(playerid, 1);
            }
            case 5: // Red
            {
            ChangeVehicleColor(car,3,3);
            TogglePlayerControllable(playerid, 1);
			}
			case 6: // Yellow
			{
			ChangeVehicleColor(car,6,6);
			TogglePlayerControllable(playerid, 1);
			}
			case 7: // Pink
			{
			ChangeVehicleColor(car,146,146);
			TogglePlayerControllable(playerid, 1);
			}
			case 8: // Cancelar
			{
			TogglePlayerControllable(playerid, 1);
			}
        }
    }

    if(current == Rodas)
    {
        switch(row)
        {
            case 0: // Estilo 1
            {
            AddVehicleComponent(car,1084);
            TogglePlayerControllable(playerid, 1);
            }
            case 1: // Estilo 2
            {
            AddVehicleComponent(car,1073);
            TogglePlayerControllable(playerid, 1);
            }
            case 2: //Estilo 3
            {
            AddVehicleComponent(car,1075);
            TogglePlayerControllable(playerid, 1);
            }
            case 3: // Estilo 4
            {
            AddVehicleComponent(car,1077);
            TogglePlayerControllable(playerid, 1);
            }
            case 4: // Estilo 5
            {
            AddVehicleComponent(car,1079);
            TogglePlayerControllable(playerid, 1);
            }
            case 5: // Estilo 6
            {
            AddVehicleComponent(car,1080);
            TogglePlayerControllable(playerid, 1);
            }
            case 6: // Cancelar
            {
            TogglePlayerControllable(playerid, 1);
            }
        }
    }

if(current == ElevadorControle)
    {
        switch(row)
        {
            case 0:{
MoveObject(elevador1 , 2735.5400390625, -2743.0239257813, 12.061451911926, 3.0);
SendClientMessage(playerid, AZULBLUE, "Elevador esta No 1 Andar .");
TogglePlayerControllable(playerid, true);
			}
            case 1:{
MoveObject(elevador1 , 2735.5400390625, -2743.0239257813, 3.5614519119263, 3.0);
SendClientMessage(playerid, AZULBLUE, "Elevador esta No 2 Andar .");
TogglePlayerControllable(playerid, true);
			}
            case 2:{
MoveObject(elevador1 , 2735.5400390625, -2743.0239257813, 0.56145191192627, 3.0);
SendClientMessage(playerid, AZULBLUE, "Elevador esta No 3 Andar .");
TogglePlayerControllable(playerid, true);
		    }
        }
    }

    if(current == PortaoControle)
    {
        switch(row)
        {
            case 0:{
             MoveObject(portao1 , 2675.9626464844, -2565.7807617188, 9.9050388336182, 3.0);
SendClientMessage(playerid, AZULBLUE, "Portão 1 Do FBI  Aberto .");
TogglePlayerControllable(playerid, true);
			}
            case 1:{
             MoveObject(portao1 , 2675.9626464844, -2565.7807617188, 15.405038833618, 3.0);
SendClientMessage(playerid, AZULBLUE, "Portão 1 Do FBI Fechado .");
TogglePlayerControllable(playerid, true);
			}
            case 2:{
             MoveObject(portao2 , 2676.1135253906, -2745.8696289063, 09.722637557983, 3.0);
SendClientMessage(playerid, AZULBLUE, "Portão 2 Do FBI  Aberto  .");
TogglePlayerControllable(playerid, true);
			}
            case 3:{
             MoveObject(portao2 , 2676.1135253906, -2745.8696289063, 15.322637557983, 3.0);
SendClientMessage(playerid, AZULBLUE, "Portão 2 Do FBI  Fechado .");
TogglePlayerControllable(playerid, true);
		    }
        }
    }
 if(current == controle_ilha)
    {
        switch(row)
        {
            case 0:{
                HideMenuForPlayer(controle_ilha, playerid);
                ShowMenuForPlayer(ElevadorControle, playerid);
            }
            case 1:{
                HideMenuForPlayer(current, playerid);
                ShowMenuForPlayer(PortaoControle, playerid);
            }
            }
            }
            }
public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, true); // Assim, se o player apertar F, vai poder andar novamente.
	return 1;
}                                 
public ABroadCast(COLOR,const string[],level)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (pAdmin[i] >= 1)
			{
				SendClientMessage(i, COLOR, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}

public ABroadCast2(COLOR,const string[],level)
{               
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (GetPlayerColor(i) == COLOR)
			{
				SendClientMessage(i, COLOR, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}

stock token_by_delim(const string[], return_str[], delim, start_index)
{
	new xc=0;
	while(string[start_index] != EOS && string[start_index] != delim) {
	    return_str[xc] = string[start_index];
	    xc++;
	    start_index++;
	}
	return_str[xc] = EOS;
	if(string[start_index] == EOS) start_index = (-1);
	return start_index;
}

stock Name(playerid) //By Alex "Y_Less" Cole
{
	new plname[24];
    GetPlayerName(playerid, plname, sizeof(plname));
    return plname;
}     

/*ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
	new pos = 0;
	while (text[pos] < 0x21)
	{
		if (text[pos] == 0) return INVALID_PLAYER_ID;
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if (IsNumeric(text[pos]))
	{
		userid = strval(text[pos]);
		if (userid >=0 && userid < MAX_PLAYERS)
		{
			if(!IsPlayerConnected(userid))
				userid = INVALID_PLAYER_ID;
			else return userid;
		}
	}
	new len = strlen(text[pos]);
	new count = 0;
	new pname[MAX_PLAYER_NAME];
	for (new i = 0; i < GetMaxPlayers(); i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, pname, sizeof (pname));
			if (strcmp(pname, text[pos], true, len) == 0)
			{
				if (len == strlen(pname)) return i;
				else
				{
					count++;
					userid = i;
				}
			}
		}
	}
	if (count != 1)
	{
		if (playerid != INVALID_PLAYER_ID)
		{
			if (count) SendClientMessage(playerid, COLOR_SYSTEM, "ERROR: Existem vários usuários, entre playername completa.");
			else SendClientMessage(playerid, COLOR_SYSTEM, "ERROR: NICK não encontrada.");
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid;
}                */

stock GetDistanceBetweenPlayers(playerid,playerid2) //By Slick (Edited by Sacky)
{
new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
new Float:tmpdis;
GetPlayerPos(playerid,x1,y1,z1);
GetPlayerPos(playerid2,x2,y2,z2);
tmpdis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
return floatround(tmpdis);
}
stock GivePlayerPCash(playerid, money)
{
	PCash[playerid] = PCash[playerid] + money;
	return PCash[playerid];
}

stock ResetPlayerPCash(playerid)
{
	PCash[playerid] = 0;
	return PCash[playerid];
}

stock GetPlayerPCash(playerid)
{
	return PCash[playerid];
}
forward hot();
public hot()
{
for(new i=0; i<MAX_PLAYERS; i++) {
new string[256];
new aname[MAX_PLAYER_NAME];
GetPlayerName(i, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "Hotel") == 1){
if(dini_Int(aname, "vip") > 0){
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")-165);
format(string, sizeof(string), "Vomo voce é GameMaster do servidor,O Hotel Deu Desconto no condominio Foram Cobrados");
SendClientMessage(i, Verde, string);
format(string, sizeof(string), "$25 Reais De luz $50 Reais de agua e $90 Reais de Oficina Mecanica.");
SendClientMessage(i, Verde, string);
} else {
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")-250);
format(string, sizeof(string), "o Hotel Cobrou Condominio:");
SendClientMessage(i, Verde, string);
format(string, sizeof(string), "Agua:$50 Luz:$50 Oficina:$100 ,Vire vip e ganhe Descontos no Nessas contas ");
SendClientMessage(i, Verde, string);}
}
}
return 1;
}

public lutinha(playerid, fightid){
SendClientMessage(playerid, Amarelo, "Parabéns você aprendeu um novo estilo de luta !");
TogglePlayerControllable(playerid, 1);
SetPlayerFightingStyle(playerid, fightid);
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
dini_IntSet(pname, "Luta", fightid);
}

forward dispesas1();
public dispesas1()
{
for(new i=0; i<MAX_PLAYERS; i++) {
new string[256];
new aname[MAX_PLAYER_NAME];
GetPlayerName(i, aname, MAX_PLAYER_NAME);
if(dini_Int(aname, "financiar") > 0){
dini_IntSet(aname, "financiar", dini_Int(aname, "financiar")-1);
dini_IntSet(aname, "SaldoBancario", dini_Int(aname, "SaldoBancario")-1000);
format(string, sizeof(string), "Você ainda tem %d Meses paga pagar de Emprestimo", dini_Int(aname, "financiar"));
SendClientMessage(i, 0x004080AA, string);
format(string,sizeof(string),"Lembrando Cada Vez Cobrado o Emprestimo é retirado automaticamente 1000 Reais De Sua conta");
SendClientMessage(i,0x004080AA,string);
}
}
return 1;
}    

stock strrest(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}
	new offset = index;
	new result[128];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
