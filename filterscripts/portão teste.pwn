
#include a_samp
#include zcmd




/*---- DEFINES ----*/

#define DIALOG_NOME             9001
#define DIALOG_TIPO             9002
#define DIALOG_NOMECOMANDO      9003
#define DIALOG_TIPO2                    9004
#define DIALOG_CIMABAIXO        9005
#define DIALOG_TIPO_COMANDO     9006
#define DIALOG_TESTE_CIMABAIXO  9007
#define VelocidadeRotacao       0.7 //Normal 0.6
#define VelocidadeSobeDesce     0.05 //Normal 0.07
#define VelocidadeDirecao       0.07 //Normal 0.07



/*----- Variaveis -----*/
new objeto, testando;
new timer;
new NoAnim[5];
new NomePortao[64];
new NomeComando[64];
new TipoPortao;
new CimaBaixo;
new Editando = 0;
new TipoComando;



public OnFilterScriptInit()
{
        print(#---F-I-L-T-E-R---S-C-R-I-P-T---);
        print(#\n------Criação de portões-------);
        print(#----------By: ForT------------\n);
        return 1;
}

CMD:testar(playerid)
{
    if(Editando == 0)return SendClientMessage(playerid, 0xFF0000, #Ninguem está fazendo um portão!);
    if(testando > 0)return SendClientMessage(playerid, 0xFF0000, #Tem alguem testando o portão!);
    ShowPlayerDialog(playerid,DIALOG_TESTE_CIMABAIXO, DIALOG_STYLE_MSGBOX, #Escolha uma opção, #Mover o portão para cima ou para baixo?, #Cima, #Baixo);
        return true;
}
CMD:salvarportao(playerid)
{
        if(Editando == 0)return SendClientMessage(playerid, 0xFF0000, #Ninguem está fazendo um portão!);
        ShowPlayerDialog(playerid,DIALOG_NOME,DIALOG_STYLE_INPUT,#Escolha o nome do portão, "Digite o nome do portão\n{FF0000}OBS: NÃO USE ACENTOS",#Continuar, #sair);
        return true;
}


CMD:sairportao(playerid)
{
    if(Editando == 0)return SendClientMessage(playerid, 0xFF0000, #Ninguem está fazendo um portão!);
        KillTimer(timer);
        DestroyObject(objeto);
        Editando = 0;
        ClearAnimations(playerid);
        RemovePlayerMapIcon(playerid, 80);
        SendClientMessage(playerid, 0x2641FEFF, #Você cancelou a edição do portão);
        return true;
}


CMD:criarportao(playerid)
{
    if(Editando > 0)return SendClientMessage(playerid, 0xFF0000, #Tem alguem fazendo um portão!);
        ShowPlayerDialog(playerid,DIALOG_TIPO,DIALOG_STYLE_LIST,#Escolha o tipo do portão, #ID: 980\nID: 969\nID: 971\nID: 975\nID: 976\nID: 988\nID: 989\nID: 2990,#Continuar, #sair);
        return true;
}


CMD:tipo(playerid)
{
    if(Editando == 0)return SendClientMessage(playerid, 0xFF0000, #Ninguem está fazendo um portão!);
        ShowPlayerDialog(playerid,DIALOG_TIPO2,DIALOG_STYLE_LIST,#Escolha o tipo do portão, #ID: 980\nID: 969\nID: 971\nID: 975\nID: 976\nID: 988\nID: 989\nID: 2990,#Continuar, #sair);
        return true;
}


CMD:comandos(playerid)
{
        SendClientMessage(playerid, 0xF6F600AA, #|------------------------| AJUDA PORTÃO |------------------------|);
        SendClientMessage(playerid, 0xFF6347AA, #ATENÇÃO: PARA PODER MOVER O PORTÃO É PRECISO APERTAR A LETRA ' C ');
        SendClientMessage(playerid, 0xF6F600AA, "Controle a POSIÇÃO do portão com os botões de direcionamento (cima, baixo, direita e esquerda)");
        SendClientMessage(playerid, 0xF6F600AA, #Mude a ROTAÇÃO com os numeros 6 e 4 ! Mude a ALTURA usando Y e N);
        SendClientMessage(playerid, 0xF6F600AA, #Faça um novo portão usando /criarportao);
        SendClientMessage(playerid, 0xF6F600AA, #Teste o portão usando o comando /testar);
        SendClientMessage(playerid, 0xF6F600AA, #Mude o modelo do portão usando /tipo);
        SendClientMessage(playerid, 0xF6F600AA, #Cancele a edição do portão usando /sairportao);
        SendClientMessage(playerid, 0xF6F600AA, #Salve o portão usando /salvarportao ! Segure spaço para aumentar a velocidade);
        return true;
}



public OnPlayerConnect(playerid)
{
    SendClientMessage(playerid, 0xF6F600AA, #|------| Criador de portão |------|);
    SendClientMessage(playerid, 0xF6F600AA, #Para ver os comandos USE: /comandos);
    return true;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
        if(dialogid == DIALOG_NOME)
        {
            if(!response)return true;
            new NaoPode[128];
        strmid(NaoPode,inputtext,0,strlen(inputtext),128);
        for(new letra=0;letra<128; ++letra)
        {
                if(NaoPode[letra]=='/' || NaoPode[letra]=='ã' ||
                        NaoPode[letra]=='ó' || NaoPode[letra]=='á' || NaoPode[letra]=='ç' ||
                        NaoPode[letra]=='â' || NaoPode[letra]=='í' || NaoPode[letra]=='ú' ||
                        NaoPode[letra]=='?' || NaoPode[letra]=='!')
                        {
                            SendClientMessage(playerid, -1, "Você usou um caracter inválido");
                            ShowPlayerDialog(playerid,DIALOG_NOME,DIALOG_STYLE_INPUT,#Escolha o nome do portão, "Digite o nome do portão\n{FF0000}OBS: NÃO USE ACENTOS",#Continuar, #sair);
                                return true;
                        }
                }
            if(!strlen(inputtext))
                {
                        ShowPlayerDialog(playerid,DIALOG_NOME,DIALOG_STYLE_INPUT,#Escolha o nome do portão, "Digite o nome do portão\n{FF0000}OBS: NÃO USE ACENTOS",#Continuar, #sair);
                        return true;
                }
                new string[64];
                format(string, sizeof string, "%s.pwn", inputtext);
                if(fexist(string))
                {
                        SendClientMessage(playerid, 0xFF0000, #Ja existe um arquivo com este nome.);
                        ShowPlayerDialog(playerid,DIALOG_NOME,DIALOG_STYLE_INPUT,#Escolha o nome do portão, "Digite o nome do portão\n{FF0000}OBS: NÃO USE ACENTOS",#Continuar, #sair);
                        return true;
                }
                strmid(NomePortao, inputtext, 0, strlen(inputtext), 128);
                ShowPlayerDialog(playerid, DIALOG_NOMECOMANDO, DIALOG_STYLE_INPUT, #Digite o nome do Comando, "Digite o comando para abri-lo\n{FF0000}OBS: NÃO USE ACENTOS\nOBS²: NÃO PRECISA DE '/' (Barra)", #Continuar, #sair);
        }
        if(dialogid == DIALOG_NOMECOMANDO)
        {
            if(!response)
                {
                        DestroyObject(objeto);
                        KillTimer(timer);
                        return true;
                }
            new NaoPode[128];
        strmid(NaoPode,inputtext,0,strlen(inputtext),128);
        for(new letra=0;letra<128; ++letra)
        {
                if(NaoPode[letra]=='/' || NaoPode[letra]=='ã' ||
                        NaoPode[letra]=='ó' || NaoPode[letra]=='á' || NaoPode[letra]=='ç' ||
                        NaoPode[letra]=='â' || NaoPode[letra]=='í' || NaoPode[letra]=='ú' ||
                        NaoPode[letra]=='?' || NaoPode[letra]=='!')
                        {
                            SendClientMessage(playerid, -1, "Você usou um caracter inválido");
                            ShowPlayerDialog(playerid, DIALOG_NOMECOMANDO, DIALOG_STYLE_INPUT, #Digite o nome do Comando, "Digite o comando para abri-lo\n{FF0000}OBS: NÃO USE ACENTOS\nOBS²: NÃO PRECISA DE '/' (Barra)", #Continuar, #sair);
                                return true;
                        }
        }
            if(!strlen(inputtext))
                {
                        ShowPlayerDialog(playerid, DIALOG_NOMECOMANDO, DIALOG_STYLE_INPUT, #Digite o nome do Comando, "Digite o comando para abri-lo\n{FF0000}OBS: NÃO USE ACENTOS\nOBS²: NÃO PRECISA DE '/' (Barra)", #Continuar, #sair);
                        return true;
                }
                strmid(NomeComando, inputtext, 0, strlen(inputtext), 128);
                ShowPlayerDialog(playerid, DIALOG_CIMABAIXO, DIALOG_STYLE_MSGBOX, #Escolha uma opção, #O Portão vai abrir para cima ou para baixo?, #Cima, #Baixo);
        }

        if(dialogid == DIALOG_CIMABAIXO)
        {
                if(response == 1)
                {
                        CimaBaixo = 0;
                        SendClientMessage(playerid, -1, #Ta legal! O portão vai abrir pra cima);
                        ShowPlayerDialog(playerid, DIALOG_TIPO_COMANDO, DIALOG_STYLE_MSGBOX, #Escolha uma opção, #Agora diga qual tipo de comando você usa?, #zcmd, #strcmp);
                        return true;
                }
                if(response == 0)
                {
                        CimaBaixo = 1;
                        SendClientMessage(playerid, -1, #Ta legal! O portão vai abrir pra baixo);
                        ShowPlayerDialog(playerid, DIALOG_TIPO_COMANDO, DIALOG_STYLE_MSGBOX, #Escolha uma opção, #Agora diga qual tipo de comando você usa?, #zcmd, #strcmp);
                        return true;
                }
        }

        if(dialogid == DIALOG_TESTE_CIMABAIXO)
        {
                new Float:pX, Float:pY, Float:pZ,
                Float:rotX, Float:rotY, Float:rotZ;
                if(response == 0)
                {
                        GetObjectPos(objeto, pX, pY, pZ);
                        GetObjectRot(objeto, rotX, rotY, rotZ);
                    MoveObject(objeto,pX, pY, pZ-10,3,rotX, rotY, rotZ);
                    SetTimer("Teste", 5000, 0);
                        CimaBaixo = 1;
                        testando = 1;
                        return true;
                }
                if(response == 1)
                {
                        GetObjectPos(objeto, pX, pY, pZ);
                        GetObjectRot(objeto, rotX, rotY, rotZ);
                    MoveObject(objeto,pX, pY, pZ+7,3,rotX, rotY, rotZ);
                    SetTimer("Teste", 5000, 0);
                        CimaBaixo = 0;
                        testando = 1;
                        return true;
                }
        }

        if(dialogid == DIALOG_TIPO_COMANDO)
        {
                if(response == 0)
                {
                        TipoComando = 0;
                        SendClientMessage(playerid, -1, #OK! você usa strcmp);
                        SalvarPortao(playerid);
                        return true;
                }
                if(response == 1)
                {
                        TipoComando = 1;
                        SendClientMessage(playerid, -1, #OK! você usa zcmd);
                        SalvarPortao(playerid);
                        return true;
                }
        }
        if(dialogid == DIALOG_TIPO)
        {
            if(!response)return true;
            switch(listitem)
            {
                        case 0: TipoPortao = 980;
                        case 1: TipoPortao = 969;
                        case 2: TipoPortao = 971;
                        case 3: TipoPortao = 975;
                        case 4: TipoPortao = 976;
                        case 5: TipoPortao = 988;
                        case 6: TipoPortao = 989;
                        case 7: TipoPortao = 2990;
                }
                timer = SetTimerEx("ChecarKeys", 77, true, "i", playerid);
                new Float:pX, Float:pY, Float:pZ;
                GetPlayerPos(playerid, pX, pY, pZ);
                objeto = CreateObject(TipoPortao, pX, pY+1, pZ, 0.0, 0.0, 0.0);
                SendClientMessage(playerid, 0xF6F600AA, #Para ver os comandos USE: /comandos);
                Editando = 1;
        }
        if(dialogid == DIALOG_TIPO2)
        {
            if(!response)return true;
            switch(listitem)
            {
                        case 0: TipoPortao = 980;
                        case 1: TipoPortao = 969;
                        case 2: TipoPortao = 971;
                        case 3: TipoPortao = 975;
                        case 4: TipoPortao = 976;
                        case 5: TipoPortao = 988;
                        case 6: TipoPortao = 989;
                        case 7: TipoPortao = 2990;
                }
                new Float:pX, Float:pY, Float:pZ, Float:rotX, Float:rotY, Float:rotZ;
                GetObjectPos(objeto, pX, pY, pZ);
                GetObjectRot(objeto, rotX, rotY, rotZ);
                DestroyObject(objeto);
                objeto = CreateObject(TipoPortao, pX, pY, pZ, rotX, rotY, rotZ);
                SendClientMessage(playerid, -1 ,#Portão modificado com sucesso!);
        }
        return 1;
}





public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
        if(newkeys == KEY_CROUCH && NoAnim[playerid] > 0 && Editando > 0)
        {
            ClearAnimations(playerid);
            NoAnim[playerid] = 0;
            return true;
        }
        if(newkeys == KEY_CROUCH && NoAnim[playerid] < 1 && Editando > 0)
        {
            ApplyAnimation(playerid,"PAULNMAC","Piss_loop",1.0,1,0,0,0,0);
            NoAnim[playerid] = 1;
            return true;
        }
        return 1;
}





forward ChecarKeys(playerid);
public ChecarKeys(playerid)
{
        if(NoAnim[playerid] == 0)return true;
        new keys, updown, leftright;
        new Float:pX, Float:pY, Float:pZ;
        new Float:rotX, Float:rotY, Float:rotZ;
        GetPlayerKeys(playerid, keys, updown, leftright);
        if(keys & KEY_ANALOG_LEFT){
                GetObjectRot(objeto, rotX, rotY, rotZ);
                SetObjectRot(objeto, rotX, rotY, rotZ+VelocidadeRotacao);}
        if(keys & KEY_ANALOG_RIGHT){
                GetObjectRot(objeto, rotX, rotY, rotZ);
                SetObjectRot(objeto, rotX, rotY, rotZ-VelocidadeRotacao);}
        if(updown == KEY_UP){
                GetObjectPos(objeto, pX, pY, pZ);
                SetObjectPos(objeto, pX-VelocidadeDirecao, pY, pZ);}
        if(updown == KEY_DOWN){
                GetObjectPos(objeto, pX, pY, pZ);
                SetObjectPos(objeto, pX+VelocidadeDirecao, pY, pZ);}
        if(leftright == KEY_LEFT){
                GetObjectPos(objeto, pX, pY, pZ);
                SetObjectPos(objeto, pX, pY-VelocidadeDirecao, pZ);}
        if(leftright == KEY_RIGHT){
                GetObjectPos(objeto, pX, pY, pZ);
                SetObjectPos(objeto, pX, pY+VelocidadeDirecao, pZ);}
        if(keys & KEY_YES){
                GetObjectPos(objeto, pX, pY, pZ);
                SetObjectPos(objeto, pX, pY, pZ+VelocidadeSobeDesce);}
        if(keys & KEY_NO){
                GetObjectPos(objeto, pX, pY, pZ);
                SetObjectPos(objeto, pX, pY, pZ-VelocidadeSobeDesce);}
        if(updown == KEY_UP && keys == KEY_SPRINT){
                GetObjectPos(objeto, pX, pY, pZ);
                SetObjectPos(objeto, pX-0.8, pY, pZ);}
        if(updown == KEY_DOWN && keys == KEY_SPRINT){
                GetObjectPos(objeto, pX, pY, pZ);
                SetObjectPos(objeto, pX+0.8, pY, pZ);}
        if(leftright == KEY_LEFT && keys == KEY_SPRINT){
                GetObjectPos(objeto, pX, pY, pZ);
                SetObjectPos(objeto, pX, pY-0.8, pZ);}
        if(leftright == KEY_RIGHT && keys == KEY_SPRINT){
                GetObjectPos(objeto, pX, pY, pZ);
                SetObjectPos(objeto, pX, pY+0.8, pZ);}
    GetObjectPos(objeto, pX, pY, pZ);
    RemovePlayerMapIcon(playerid, 80);
        SetPlayerMapIcon(playerid, 80,pX,pY,pZ, 56, 0xE6E6E6E6);
        return true;
}






forward SalvarPortao(playerid);
public SalvarPortao(playerid)
{
        new str[256],str2[256], fiile[64];
        new Float:pX, Float:pY, Float:pZ;
        new Float:rotX, Float:rotY, Float:rotZ;
        GetObjectPos(objeto, pX, pY, pZ);GetObjectRot(objeto, rotX, rotY, rotZ);
        new File:fileportao;
        format(fiile, sizeof fiile, "%s.pwn", NomePortao);
        fileportao = fopen(fiile,io_append);
        format(str, 256, "//no Topo do GM\nnew %s;\n\n\n//OnGameModeInit\n%s = CreateObject(%d, %0.4f,%0.4f,%0.4f,%0.4f,%0.4f,%0.4f);\n\n\n",
        NomePortao, NomePortao, TipoPortao, pX,pY,pZ,rotX,rotY,rotZ);
        fwrite(fileportao,str);
        fclose(fileportao);
        if(TipoComando == 1)
        {
                fileportao = fopen(fiile,io_append);
                if(CimaBaixo == 1)
                {
                        format(str2, 256, "//comando\nCMD:%s(playerid)\n{\n    MoveObject(%s, %0.4f,%0.4f,%0.4f,3,%0.4f,%0.4f,%0.4f);\n",
                        NomeComando,NomePortao,pX,pY,pZ-10,rotX,rotY,rotZ);
                }
                else
                {
                        format(str2, 256, "//comando\nCMD:%s(playerid)\n{\n    MoveObject(%s, %0.4f,%0.4f,%0.4f,3,%0.4f,%0.4f,%0.4f);\n",
                        NomeComando,NomePortao,pX,pY,pZ+7,rotX,rotY,rotZ);
                }
                fwrite(fileportao,str2);
                fclose(fileportao);
                fileportao = fopen(fiile,io_append);
                format(str2, 356, "    SetTimer(#Move%s, 5000, 0);\n    SendClientMessage(playerid, 0x2641FEFF, #Portao aberto);\n    return true;\n}\n\n//No fim do GM\nforward Move%s();\npublic Move%s()\n{\n",
                NomePortao,
                NomePortao, NomePortao);
                fwrite(fileportao,str2);
                fclose(fileportao);
        }
        if(TipoComando == 0)
        {
                fileportao = fopen(fiile,io_append);
                if(CimaBaixo == 1)
                {
                        format(str2, 256, "//comando\nif(strcmp(#/%s, cmdtext, true) == 0)\n{\n    MoveObject(%s, %0.4f,%0.4f,%0.4f,3,%0.4f,%0.4f,%0.4f);\n",
                        NomeComando,NomePortao,pX,pY,pZ-10,rotX,rotY,rotZ);
                }
                else
                {
                        format(str2, 256, "//comando\nif(strcmp(#/%s, cmdtext, true) == 0)\n{\n    MoveObject(%s, %0.4f,%0.4f,%0.4f,3,%0.4f,%0.4f,%0.4f);\n",
                        NomeComando,NomePortao,pX,pY,pZ+7,rotX,rotY,rotZ);
                }
                fwrite(fileportao,str2);
                fclose(fileportao);
                fileportao = fopen(fiile,io_append);
                format(str2, 356, "    SetTimer(#Move%s, 5000, 0);\n    SendClientMessage(playerid, 0x2641FEFF, #Portao aberto);\n    return true;\n}\n\n//No fim do GM\nforward Move%s();\npublic Move%s()\n{\n",
                NomePortao,
                NomePortao, NomePortao);
                fwrite(fileportao,str2);
                fclose(fileportao);
        }
        fileportao = fopen(fiile,io_append);
        format(str2, 256, "    MoveObject(%s,%0.4f, %0.4f, %0.4f,3,%0.4f, %0.4f, %0.4f);\n    return true;\n}",
        NomePortao, pX, pY, pZ, rotX, rotY, rotZ);
        fwrite(fileportao,str2);
        fclose(fileportao);
        KillTimer(timer);
        DestroyObject(objeto);
        Editando = 0;
        NoAnim[playerid] = 0;
        RemovePlayerMapIcon(playerid, 80);
        ClearAnimations(playerid);
        format(str2, sizeof str2, "Atenção: O arquivo ( %s.pwn ) foi criado com sucesso em sua pasta scriptfiles", NomePortao);
        SendClientMessage(playerid, 0x2641FEFF, #|------------------------| Criador de Portão |------------------------|);
        SendClientMessage(playerid, 0x2641FEFF, str2);
        SendClientMessage(playerid, 0x2641FEFF, #Nele contem as informações necessárias para adicionar este portão em seu GameMode.);
        SendClientMessage(playerid, 0x2641FEFF, #Qualquer duvida ou BUG adicione este email: dimmy_cn@hotmail.com ! Bom jogo.);
        SendClientMessage(playerid, 0x2641FEFF, #________________________________________________________________________);
        return true;
}

forward Teste();
public Teste()
{
        new Float:pX, Float:pY, Float:pZ,
                Float:rotX, Float:rotY, Float:rotZ;
        GetObjectPos(objeto, pX, pY, pZ);
        GetObjectRot(objeto, rotX, rotY, rotZ);
        if(CimaBaixo == 0)MoveObject(objeto,pX, pY, pZ-7,3,rotX, rotY, rotZ);
        if(CimaBaixo == 1)MoveObject(objeto,pX, pY, pZ+10,3,rotX, rotY, rotZ);
    testando = 0;
    return true;
}
