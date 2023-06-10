/* Funções do gamemode em MySql por Ricop522
 * Favor não retirar os créditos
 * (c) Copyright 2011-2012, Ricop522
 * Este arquivo foi criado por Ricop522 !
*/
#include <a_samp>
#include <a_npc>

#define SendFMessage(%0,%1,%2,%3)					\
    do                            					\
    {                                         		\
        format(u_Msg, sizeof (u_Msg), (%2), %3);	\
        SendClientMessage((%0), (%1), u_Msg);		\
    }                                           	\
    while (FALSE)

#define SendFMessageToAll(%0,%1,%2)                 \
	do                                              \
	{                                               \
	    format(u_Msg, sizeof(u_Msg), (%1), %2);		\
		SendClientMessageToAll((%0), u_Msg);		\
	}                                               \
	while (FALSE)

#define DialogBox(%0,%1,%2,%3,%4,%5)											ShowPlayerDialog( %0, %1, DIALOG_STYLE_MSGBOX, %2, %3, %4, %5 )
#define DialogInput(%0,%1,%2,%3,%4,%5)											ShowPlayerDialog( %0, %1, DIALOG_STYLE_INPUT, %2, %3, %4, %5 )
#define DialogList(%0,%1,%2,%3,%4,%5)           								ShowPlayerDialog( %0, %1, DIALOG_STYLE_LIST, %2, %3, %4, %5 )

