// ***********************************************************************************
// Código principal do FilterScript de Compra de Armas com Dialog
// Este código é público.
// Favor não retirar os créditos dos ADS!
// Apenas usar sem tirar créditos ou para estudo!
// MODIFICAR ESTE ARQUIVO, NÃO QUER DIZER QUE VOCÊ CRIOU
// CRIADO POR:   SuB_ZeRo0_   [Sa-Mp.com]
// ***********************************************************************************

// Menu
#define NomeMenu "Menu de Armas"                            // Nome do Menu
#define Btn1 "Comprar"                            // Botão 1
#define Btn2 "Sair"                            // Botão 2
#define IDMENU 13759
#define MSGComprar "Dependendo da quantidade de balas o preço irá aumentar!"                            // Msg compra de balas
#define MSGSucesso "[MENU] Compra efetuada com sucesso!"                            // Msg compra com sucesso
#define SDinheiro "[MENU] Você não tem dinheiro suficiente!"                            // Sem dinheiro para comprar
#define SBDinheiro "[MENU] Você não tem o dinheiro suficiente para comprar todas essas balas!"                            // Sem dinheiro pra comprar a quantidade de balas solicitadas
#define Comando "/amenu"                            // Comando
#define TextoMenu "Pistola - R$%i\nDesert - R$%i\nSawn-Off - R$%i\nTec9 - R$%i\nCombat - R$%i\nMicro SMG - R$%i\nSMG - R$%i\nAk-47 - R$%i\nColt M4A1 - R$%i\nSniper - R$%i\nExtintor - R$%i"                            // Texto que irá aparecer na Dialog

// Defines (IDs das Dialogs)
#define PISTOL 19877
#define DESERT 11678
#define SAWN 19239
#define TEC 19233
#define COMBAT 19467
#define MicroSMG 16789
#define SMG 16788
#define AK 16787
#define COLT 16786
#define SNIPER 12556
#define EXTIN 12467

//Preço de 1 Bala
#define PSAWN 7                            // Sawn-Off Shotgun
#define PTEC 3                            // Tec 9
#define PDESERT 3                            // Desert Eagle
#define PPISTOL 2                            // Pistola s/ silenciador
#define PCOMBAT 6                            // Combat Shotgun
#define PMicroSMG 3                            // Miscro SMG
#define PSMG 3                            // SMG
#define PAK 12                            // Ak-47
#define PCOLT 12                            // Colt M4A1
#define PSNIPER 15                            // Sniper c/ mira
#define PEXTIN 2                            // Extintor

//Preço das armas
#define VSAWN 4000                            // Sawn-Off Shotgun
#define VTEC 900                            // Tec 9
#define VDESERT 500                            // Desert Eagle
#define VPISTOL 200                            // Pistola s/ silenciador
#define VCOMBAT 3000                            // Combat Shotgun
#define VMicroSMG 900                            // Micro SMG
#define VSMG 800                            // SMG
#define VAK 10000                            // Ak-47
#define VCOLT 10000                            // Colt M4A1
#define VSNIPER 20000                            // Sniper c/ mira
#define VEXTIN 600                            // Extintor


// Cores
#define amarelo 0xFFFF00AA
#define vermelho 0xFF0000AA
#define laranja 0xFFA500AA

// IDs das armas
#define ID_Arma1 26
#define ID_Arma2 32
#define ID_Arma3 22
#define ID_Arma4 23
#define ID_Arma5 27
#define ID_Arma6 28
#define ID_Arma7 29
#define ID_Arma8 30
#define ID_Arma9 31
#define ID_Arma10 34
#define ID_Arma11 42

// Texto de compra das armas
#define TextoC1 "Balas para sua Pistola"
#define TextoC2 "Balas para sua Desert"
#define TextoC3 "Balas para sua Sawn-Off"
#define TextoC4 "Balas para sua Tec9"
#define TextoC5 "Balas para sua Combat"
#define TextoC6 "Balas para sua Micro SMG"
#define TextoC7 "Balas para sua SMG"
#define TextoC8 "Balas para sua Ak-47"
#define TextoC9 "Balas para sua Colt M4A1"
#define TextoC10 "Balas para sua Sniper"
#define TextoC11 "Balas para sua Sniper"