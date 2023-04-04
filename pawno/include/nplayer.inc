/*
					      __________.__
					  ____\______   \  | _____  ___.__. ___________
					 /    \|     ___/  | \__  \<   |  |/ __ \_  __ \
					|   |  \    |   |  |__/ __ \\___  \  ___/|  | \/
					|___|  /____|   |____(____  / ____|\___  >__|
					     \/                   \/\/         \/
    Credits:
    Incognito (http://forum.sa-mp.com/member.php?u=925) (Audio Plugin) (Non 0.3d Version)
    Norn (Scott Davey) (http://forum.sa-mp.com/member.php?u=33812)
    Y_Less - Callback Hooking Method (http://forum.sa-mp.com/member.php?u=29176)
*/

#include <a_samp>
stock NRNULL[] = "\1\0";
#define NPMAX_ITEMS  500
#define NPMAX_CATEGORIES  30
#define NPINVALID_ITEM_ID    -1
#define NPMAX_CATEGORY_LENGTH 75
#define NPMAX_ITEM_LENGTH    75
#define NPMAX_STREAM_URL_LENGTH   128
#define NPCATEGORIES_DIALOG_ID    1553
#define NPLAYER_DIALOG_ID 1552
forward PlayerCategoryBrowse(playerid, listitem);
forward PlayerAddCategory(name[NPMAX_CATEGORY_LENGTH]);
forward AddStreamToCategory(categoryid, name[NPMAX_ITEM_LENGTH], streamurl[NPMAX_STREAM_URL_LENGTH]);
forward PlayerInitDialog(playerid);
forward PlayerStop(playerid);
forward PlayerPlay(playerid, itemid);
forward DeleteCategory(categoryid);
forward ModifyCategory(categoryid, name[NPMAX_CATEGORY_LENGTH]);
forward ModifyItem(itemid, name[NPMAX_ITEM_LENGTH], streamurl[NPMAX_STREAM_URL_LENGTH]);
forward DeleteItem(itemid);
forward ItemCountFromCategory(categoryid);
forward CategoryIDFromDialogOrder(listitem);
forward ItemIDFromDialogOrder(playerid, listitem);
enum nPlayerItem
{
    npCategoryID,
    npTitle[NPMAX_ITEM_LENGTH],
    npStreamURL[NPMAX_STREAM_URL_LENGTH]
}
new PlayerItem[NPMAX_ITEMS][nPlayerItem], nCategories[NPMAX_ITEMS][NPMAX_CATEGORY_LENGTH], nrCATEGORY_COUNT = 0, npITEM_COUNT = 0, npDIALOG_STRING[1028], npTextString[128];
public PlayerAddCategory(name[NPMAX_CATEGORY_LENGTH])
{
    new CATEGORY_ID = NPINVALID_ITEM_ID;
    if(strlen(name) >= 1 && strlen(name) <= NPMAX_CATEGORY_LENGTH) {
        if(nrCATEGORY_COUNT < NPMAX_CATEGORIES) {
            for(new i=0;i<NPMAX_CATEGORIES;i++) {
                if(!strlen(nCategories[i])) {
                    format(nCategories[i], NPMAX_CATEGORY_LENGTH, name);
                    CATEGORY_ID = i;
                    printf("[nPlayer:] Category ID %d (%s) created.", CATEGORY_ID, nCategories[i]);
                    nrCATEGORY_COUNT++;
                    return CATEGORY_ID;
                }
            }
        }
    }
    return CATEGORY_ID;
}
public AddStreamToCategory(categoryid, name[NPMAX_ITEM_LENGTH], streamurl[NPMAX_STREAM_URL_LENGTH])
{
    new ITEM_ID = -1;
    if(strlen(name) >= 1 && strlen(name) <= NPMAX_ITEM_LENGTH) {
        if(npITEM_COUNT < NPMAX_ITEMS) {
            for(new i=0;i<NPMAX_ITEMS;i++) {
                if(!strlen(PlayerItem[i][npTitle])) {
                    ITEM_ID = i;
                    PlayerItem[i][npCategoryID] = categoryid;
                    format(PlayerItem[i][npTitle], NPMAX_ITEM_LENGTH, name);
                    format(PlayerItem[i][npStreamURL], NPMAX_STREAM_URL_LENGTH, streamurl);
                    printf("[nPlayer:] Item ID %d (%s) created and attached to %s.", i, PlayerItem[i][npTitle], nCategories[categoryid]);
                    npITEM_COUNT++;
                    return ITEM_ID;
                }
            }
        }
    }
    return ITEM_ID;
}
public PlayerInitDialog(playerid)
{
	format(npDIALOG_STRING, sizeof(npDIALOG_STRING), "");
    for(new i=0;i<nrCATEGORY_COUNT;i++) {
        if(!i) {
            if(strlen(nCategories[i]) >= 1)
                format(npDIALOG_STRING, sizeof(npDIALOG_STRING), nCategories[i]);
        }
        else {
            if(strlen(nCategories[i]) >= 1)
                format(npDIALOG_STRING, sizeof(npDIALOG_STRING), "%s\n%s", npDIALOG_STRING, nCategories[i]);
        }
    }
    if(strlen(npDIALOG_STRING) >= 1) { ShowPlayerDialog(playerid, NPCATEGORIES_DIALOG_ID, DIALOG_STYLE_LIST, "Player - Browse Categories", npDIALOG_STRING, "Browse", "Cancel"); }
    return true;
}
stock PlayerCategoryNameFromID(categoryid)
{
    new category_name[NPMAX_CATEGORY_LENGTH];
    format(category_name, sizeof(category_name), nCategories[categoryid]);
    return category_name;
}
stock ItemNameFromID(itemid)
{
    new item_name[NPMAX_ITEM_LENGTH];
    format(item_name, sizeof(item_name), PlayerItem[itemid][npTitle]);
    return item_name;
}
public PlayerStop(playerid)
{
    StopAudioStreamForPlayer(playerid);
    return true;
}

public PlayerPlay(playerid, itemid)
{
    PlayerStop(playerid);
    PlayAudioStreamForPlayer(playerid, PlayerItem[itemid][npStreamURL]);
    return true;
}
public DeleteCategory(categoryid)
{
    format(nCategories[categoryid], NPMAX_CATEGORY_LENGTH, "");
    for(new i=0;i<npITEM_COUNT;i++) {
        if(PlayerItem[i][npCategoryID] == categoryid && strlen(PlayerItem[i][npTitle]) >= 1) {
            format(PlayerItem[i][npTitle], NPMAX_ITEM_LENGTH, "");
            npITEM_COUNT--;
        }
    }
    nrCATEGORY_COUNT--;
    return true;
}
public ModifyCategory(categoryid, name[NPMAX_CATEGORY_LENGTH])
{
    format(nCategories[categoryid], NPMAX_ITEM_LENGTH, name);
    return true;
}
public ModifyItem(itemid, name[NPMAX_ITEM_LENGTH], streamurl[NPMAX_STREAM_URL_LENGTH])
{
    format(PlayerItem[itemid][npTitle], NPMAX_ITEM_LENGTH, name);
    format(PlayerItem[itemid][npStreamURL], NPMAX_ITEM_LENGTH, streamurl);
    return true;
}
public DeleteItem(itemid)
{
    format(PlayerItem[itemid][npTitle], NPMAX_ITEM_LENGTH, "");
    npITEM_COUNT--;
    return true;
}
public ItemCountFromCategory(categoryid)
{
    new count = 0;
    for(new i=0;i<npITEM_COUNT;i++) {
        if(PlayerItem[i][npCategoryID] == categoryid && strlen(PlayerItem[i][npTitle]) >= 1) {
            count++;
        }
    }
    return count;
}
public CategoryIDFromDialogOrder(listitem)
{
    new current_array_id, bool:breakloop = false, id = -1;
    for(new i=0;i<nrCATEGORY_COUNT;i++) {
        if(strlen(nCategories[i]) >= 1) {
            if(!breakloop) {
                if(current_array_id == listitem) {
                    id = i;
                    breakloop = true;
                }
                current_array_id++;
            }
        }
    }
    return id;
}
public ItemIDFromDialogOrder(playerid, listitem)
{
    new categoryid = GetPVarInt(playerid, "playerCategory"), current_array_id, bool:breakloop = false, id = -1;
    for(new i=0;i<npITEM_COUNT;i++) {
        if(PlayerItem[i][npCategoryID] == categoryid && strlen(PlayerItem[i][npTitle]) >= 1) {
            if(!breakloop) {
                if(current_array_id == listitem) {
                    id = i;
                    breakloop = true;
                }
                current_array_id++;
            }
        }
    }
    return id;
}
public PlayerCategoryBrowse(playerid, listitem)
{
    format(npDIALOG_STRING, sizeof(npDIALOG_STRING), "");
    new categoryid = CategoryIDFromDialogOrder(listitem);
    SetPVarInt(playerid, "playerCategory", categoryid);
    if(ItemCountFromCategory(categoryid) >= 1) {
        for(new i=0;i<npITEM_COUNT;i++) {
            if(PlayerItem[i][npCategoryID] == categoryid) {
                if(!i) {
                    if(strlen(PlayerItem[i][npTitle]) >= 1)
                        format(npDIALOG_STRING, sizeof(npDIALOG_STRING), PlayerItem[i][npTitle]);
                }
                else {
                    if(strlen(PlayerItem[i][npTitle]) >= 1)
                        format(npDIALOG_STRING, sizeof(npDIALOG_STRING), "%s\n%s", npDIALOG_STRING, PlayerItem[i][npTitle]);
                }
            }
        }
        new dialog_title[100];
        format(dialog_title, sizeof(dialog_title), "Player - %s", nCategories[categoryid]);
        if(strlen(npDIALOG_STRING) >= 1) { ShowPlayerDialog(playerid, NPLAYER_DIALOG_ID, DIALOG_STYLE_LIST, dialog_title, npDIALOG_STRING, "Stream", "Go Back"); }
    }
    else {
        format(npTextString, sizeof(npTextString), "[Player:] No items exist in category ' %s '.", PlayerCategoryNameFromID(categoryid));
        SendClientMessage(playerid, 0xFF0000FF, npTextString);
        PlayerInitDialog(playerid);
    }
    return true;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid) {
        case NPLAYER_DIALOG_ID:
        {
            if(response) {
                new item_id = ItemIDFromDialogOrder(playerid, listitem);
                PlayerPlay(playerid, item_id);
                format(npTextString,sizeof(npTextString),"[Player:] Stream for %s started.", ItemNameFromID(item_id));
                SendClientMessage(playerid, 0xADD8E6FF, npTextString);
            }
            else {
                PlayerInitDialog(playerid);
            }
        }
        case NPCATEGORIES_DIALOG_ID:
        {
            if(response) {
                PlayerCategoryBrowse(playerid, listitem);
            }
        }
    }
    if (inputtext[0]) return CallLocalFunction("nplayer_OnDialogResponse","iiiis",playerid,dialogid,response,listitem,inputtext);
    else return CallLocalFunction("nplayer_OnDialogResponse","iiiis",playerid,dialogid,response,listitem,NRNULL);
}
#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse nplayer_OnDialogResponse
forward nplayer_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);

