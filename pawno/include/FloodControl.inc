# Include <a_samp>
# include <FloodControl>

p�blico  OnPlayerFloodControl ( playerid ,  configura��o ) {
    switch ( configura��o ) {
        caso  FLOOD_CONTROL_DEATH : {
            SendClientMessage ( playerid ,  0xFFFFFFFF ,  "FloodControl:! Voc�. FOI banido morte inunda��o POR" );
            Ban ( playerid ) ;
        }
        caso  FLOOD_CONTROL_BOOT : {
            SendClientMessage ( playerid ,  0xFFFFFFFF ,  "FloodControl:! Voc�. FOI banido inicializa��o inunda��o POR" );
            Ban ( playerid );
        }
        caso  FLOOD_CONTROL_VEHICLES : {
            SendClientMessage ( playerid ,  0xFFFFFFFF ,  "FloodControl: Voc�. FOI banido ve�culo inunda��o POR ! (CAR MASSA spawner) " );
            Ban ( playerid );
        }
        caso  FLOOD_CONTROL_CHAT : {
            SendClientMessage ( playerid ,  0xFFFFFFFF ,  "FloodControl:! Voc�. FOI POR inunda��o kickado bate-papo" );
            Chute ( playerid );
        }
        caso  FLOOD_CONTROL_COMMAND : {
            SendClientMessage ( playerid ,  0xFFFFFFFF ,  "! FloodControl: Voc�. FOI POR kickado Comando inunda��o" );
            Chute ( playerid );
        }
    }
    retornar  verdadeiro ;
} p�blico

OnPlayerText ( playerid ,  texto []) {
    / * - Novos parametros -
        OnPlayerFloodChat @ Command ( playerid, FLOOD_CONTROL_CHAT, iCount, iTime);
        Ex:
            OnPlayerFloodChat @ Command (playerid, FLOOD_CONTROL_CHAT, 2, 4);
        Nota:
            if ((getTime () - GetPVarInt (playerid, # lastText)) <= && iTime flood_stamp [playerid]> = iCount)
            De a Acordo com o exemplo a funcionara DESTA maneira, iCount (2) = Contagem de Mensagens los Menos fazer iTime (4).
            entao Caso o leitor envie 2 messages los Menos de 4 Segundos E Chamada OnPlayerFloodControl um retorno.
    * /     / / - COMECA um Contagem








{
    / * - Novos parametros -
        OnPlayerFloodChat @ Command (playerid, FLOOD_CONTROL_CHAT, iCount, iTime);
        Ex:
            OnPlayerFloodChat @ Command (playerid, FLOOD_CONTROL_CHAT, 2, 4);
        Nota:
            if ((getTime () - GetPVarInt (playerid, # lastText)) <= iTime && flood_stamp [playerid]> = iCount)
            De a Acordo com o exemplo a funcionara DESTA maneira, iCount (2) = Contagem de Mensagens los Menos fazer iTime (4).
            entao Caso o leitor envie 2 Comandos los Menos De 4 Segundos E Chamada OnPlayerFloodControl um retorno.
    * /     / / - COMECA um Contagem -



       OnPlayerFloodChat @ Command ( playerid ,  FLOOD_CONTROL_COMMAND ,  2 ,  4 );     (! se

strcmp ( cmdtext ,  # / floodcontrol, true)) {
        SendClientMessage ( playerid ,  0xFFFFFFFF ,  "FloodControl:! Voc�. Sera kickado inunda��es POR" );
        retorno  verdadeira ;
    }
    retornar  falso ;
}
