    /* [FS] ELEIÇÕES PRESIDENCIAIS | CRIADO POR: [DirectX]_Gabriel (NÃO RETIRE OS CREDITOS DO FS) */

    //INCLUDES
    #include <a_samp>
    #include <zcmd>


    //DEFINES


    // CORES
    #define VERDE 0x008000C8 // {008000}
    #define VERMELHO 0xFF0000C8
    #define AMARELO 0xFFFF00C8

    // NEWS'S
    new Votou[300], bool:Votacao;
    new Candidato1, Candidato2, Candidato3, Candidato4, VotoBranco;
    new Urna;
    new Text3D:Texto[MAX_PLAYERS];

    public OnFilterScriptInit()
    {
            print("\n----------------------------------------------");
            print("SISTEMA DE ELEIÇÕES POR : [DirectX]_Gabriel AKA RODRA");
            print("----------------------------------------------\n");
            return 1;
    }

    public OnFilterScriptExit()
    {
            return 1;
    }

    public OnPlayerConnect(playerid)
    {
            SendClientMessage(playerid, VERDE, "Sistema de Eleições por: {FFFFFF} Douglas_PRT aka Rodra.");
            return 1;
    }

    public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
    {
            if(dialogid == 2345)
    {
            if(response)
    {

            if(listitem == 0)
    {
            SendClientMessage(playerid, AMARELO, "O seu voto foi registado. {FFFFFF}(Candidato 1).");
            Candidato1++;
            Votou[playerid] = 1;
    }

            if(listitem == 1)
    {
        SendClientMessage(playerid, AMARELO, "O seu voto foi registado. {FFFFFF}(Candidato 2).");
            Candidato2++;
            Votou[playerid] = 1;
    }

            if(listitem == 2)
    {
            SendClientMessage(playerid, AMARELO, "O seu voto foi registado. {FFFFFF}(Candidato 3).");
            Candidato3++;
            Votou[playerid] = 1;
    }

            if(listitem == 3)
    {
            SendClientMessage(playerid, AMARELO, "O seu voto foi registado. {FFFFFF}(Candidato 4).");
            Candidato4++;
            Votou[playerid] = 1;
    }

        if(listitem == 4)
    {
            SendClientMessage(playerid, AMARELO, "O seu voto foi registado. {FFFFFF}(Voto em Branco).");
            Candidato4++;
            Votou[playerid] = 1;
    }
    }
            return 1;
    }
            return 0;
    }

    CMD:abrirurnas(playerid)
    {
            if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, VERMELHO, "[ERRO]: Não tens permissão para efectuar este comando.");
            if(Votacao == true) return SendClientMessage(playerid, VERMELHO, "[ERRO]: Já está a decorrer uma eleição.");
            SendClientMessageToAll(VERMELHO, "As urnas das Eleições Presidenciais estão oficialmente abertas, dirige-te ao local de voto e digita '/votar'.");
            Votacao = true;
            //PICKUP + 3DLABEL
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            Urna = CreateObject(3013, x, y, z, 0.0, 0.0, 0.0, 96.0);
            Texto[playerid] = Create3DTextLabel("{FFFF00}Urna de Voto\n Usa /votar", 0x000000FF, x, y, z, 40.0, 0, 0);
            return 1;
    }
    CMD:fecharurnas(playerid)
    {
        if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, VERMELHO, "[ERRO]: Não tens permissão para efectuar este comando.");
            if(Votacao == false) return SendClientMessage(playerid, VERMELHO, "[ERRO]: Não está a decorrer nenhuma votação de momento.");
            new string[300];
            new Total = (Candidato1 + Candidato2 + Candidato3 + Candidato4 + VotoBranco);
            format(string,256, "{008000}[RESULTADOS]{FFFFFF} Candidato 1: [%d] | Candidato 2: [%d] | Candidato 3: [%d] | Candidato 4: [%d] || Total Votos: %d  | Votos em Branco: %d",Candidato1, Candidato2, Candidato3, Candidato4, Total, VotoBranco);
            SendClientMessageToAll(0xFFFFFFFF, string);
            // REMOVER PICKUP + 3DTEXT
            DestroyObject(Urna);
            Delete3DTextLabel(Texto[playerid]);
            // FECHAR VOTACAO
            Votacao = false;
            // ANULAR TODOS OS DADOS
            Candidato1 = 0;
            Candidato2 = 0;
            Candidato3 = 0;
            Candidato4 = 0;
            VotoBranco = 0;
            // ACTIVAR VOTO PARA TODOS OS JOGADORES
            for(new i; i < MAX_PLAYERS; i++)
            if(Votou[i] == 1)
            Votou[i] = 0;
            return 1;
    }
    CMD:votar(playerid)
    {
            if(Votacao == false) return SendClientMessage(playerid, VERMELHO, "[ERRO]: Não está a decorrer nenhuma votação, pelo que não podes votar.");
            if(Votou[playerid] == 1) return SendClientMessage(playerid, VERMELHO, "[ERRO]: Apenas um voto por pessoa.");
            new Float:X,Float:Y,Float:Z;
            GetObjectPos(Urna,X,Y,Z);
            if(!IsPlayerInRangeOfPoint(playerid, 2.0,X,Y,Z)) return SendClientMessage(playerid, VERMELHO, "[ERRO]: Não estás no local de votação.");
        ShowPlayerDialog(playerid, 2345, DIALOG_STYLE_LIST, "Eleições | Escolha o seu Candidato:", "Candidato 1\nCandidato 2\nCandidato 3\nCandidato 4\nVoto Branco", "Votar", "Cancelar");
            return 1;
    }

    /* [FS] ELEIÇÕES PRESIDENCIAIS | CRIADO POR: [DirectX]_Gabriel (NÃO RETIRE OS CREDITOS DO FS) */


